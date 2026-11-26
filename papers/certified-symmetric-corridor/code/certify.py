#!/usr/bin/env python3
"""Generate trial slopes and certify a Bellman residual using outward rounding."""

from fractions import Fraction
from math import erf, sqrt

import numpy as np
from scipy.linalg import solve_banded
from scipy.special import ndtri


CELLS = 1536
HORIZON = 16
P_SCALE = 2**26
TIME_SCALE = 2**24
V_SCALE = 2**10
W_SCALE = 2**54


def ceil_div(numerator, denominator):
    return -((-numerator) // denominator)


def outward(x, y, scale):
    return x.numerator * scale // x.denominator, ceil_div(y.numerator * scale, y.denominator)


def alternating_atan(reciprocal):
    z = Fraction(1, reciprocal)
    term = z
    total = Fraction(0)
    for j in range(25):
        total += term / (2 * j + 1)
        term *= -z * z
    return total + term / 51, total


def exponential_integral_bounds(x):
    """Bound exp(-x) and the normalized Gaussian integral at v=sqrt(2x)."""
    assert 0 <= x <= 8
    term = Fraction(1)
    exponential = term
    integral = term
    for j in range(1, 51):
        term *= -x / j
        exponential += term
        integral += term / (2 * j + 1)
    next_term = -term * x / 51
    return (
        (exponential + next_term, exponential),
        (integral + next_term / 103, integral),
    )


def gaussian_table():
    atan5_lo, atan5_hi = alternating_atan(5)
    atan239_lo, atan239_hi = alternating_atan(239)
    pi_lo = 16 * atan5_lo - 4 * atan239_hi
    pi_hi = 16 * atan5_hi - 4 * atan239_lo
    constant_lo = Fraction(7978845608, 10**10)
    constant_hi = Fraction(7978845609, 10**10)
    assert constant_lo**2 * pi_hi < 2 < constant_hi**2 * pi_lo

    intervals = []
    for v_index in range(4 * V_SCALE + 1):
        v = Fraction(v_index, V_SCALE)
        kernel, integral = exponential_integral_bounds(v * v / 2)
        j_lo = constant_lo * v * integral[0]
        j_hi = constant_hi * v * integral[1]
        assert 0 <= kernel[0] <= kernel[1] and 0 <= j_lo <= j_hi
        g_lo = constant_lo * kernel[0] + v * j_lo
        g_hi = constant_hi * kernel[1] + v * j_hi
        intervals.append((*outward(j_lo, j_hi, P_SCALE), *outward(g_lo, g_hi, P_SCALE)))
    table = np.array(intervals, dtype=np.int64)
    assert np.all(table[1:, :2] >= table[:-1, :2])
    return table.T


def hamiltonian_bounds(p, table):
    j_lo, j_hi, g_lo, g_hi = table
    v_lo = np.maximum(0, np.searchsorted(j_hi, p, side="right") - 1)
    v_hi = np.minimum(4 * V_SCALE, np.searchsorted(j_lo, p, side="left"))
    assert np.all(v_lo <= v_hi)
    linear_num = v_lo * p
    overshoot = ceil_div((v_hi - v_lo) * np.maximum(0, p - j_lo[v_lo]), V_SCALE)
    lo = g_lo[v_lo] - ceil_div(linear_num, V_SCALE) - overshoot
    hi = g_hi[v_lo] - linear_num // V_SCALE
    return lo, hi, v_lo, v_hi


def trial_rows():
    """SciPy chooses the witness. No fact about this solver is used in the proof."""
    x = np.linspace(0, 1, CELLS + 1)
    threshold = erf(4 / sqrt(2))
    p = np.zeros(CELLS + 1)
    p[-1] = 1
    tick = 0
    yield tick, np.rint(P_SCALE * p).astype(np.int64)
    while tick < HORIZON * TIME_SCALE:
        step = min(HORIZON * TIME_SCALE - tick, max(
            TIME_SCALE // 2**20, min(3 * (TIME_SCALE + tick) // 1000, tick // 8)
        ))
        dt = step / TIME_SCALE
        diffusion = dt * CELLS**2 / 2
        old = p.copy()
        for _ in range(3):
            midpoint = np.clip((old[1:-1] + p[1:-1]) / 2, 0, threshold)
            drift = -ndtri((midpoint + 1) / 2) - x[1:-1] / 2
            advective = drift * dt * CELLS / 2
            upward = (diffusion + advective) / 2
            downward = (diffusion - advective) / 2
            matrix = np.zeros((3, CELLS - 1))
            matrix[0, 1:] = -upward[:-1]
            matrix[1, :] = 1 + diffusion
            matrix[2, :-1] = -downward[1:]
            rhs = ((1 - diffusion) * old[1:-1]
                   + upward * old[2:] + downward * old[:-2])
            rhs[-1] += upward[-1]
            p[1:-1] = solve_banded((1, 1), matrix, rhs)
        p = np.clip(p, 0, 1)
        tick += step
        yield tick, np.rint(P_SCALE * p).astype(np.int64)


def potential_numerator(p):
    """The dimensionless primitive at x=j/N equals Sigma/(2*N*P_SCALE)."""
    return np.r_[np.int64(0), np.cumsum(p[:-1] + p[1:])]


def corner_data(p, potential, potential_time, step, table):
    drift_num = -np.arange(CELLS + 1, dtype=np.int64) * p
    lo = (drift_num // (2 * CELLS)
          + potential // (4 * CELLS)
          + potential_time // (2 * CELLS * step))
    hi = (ceil_div(drift_num, 2 * CELLS)
          + ceil_div(potential, 4 * CELLS)
          + ceil_div(potential_time, 2 * CELLS * step))
    h_lo, h_hi, v_lo, v_hi = hamiltonian_bounds(p, table)
    difference = np.diff(p)
    # CELLS is even, so this centered curvature term is exact in P_SCALE units.
    curvature = difference * (CELLS // 2)
    return (
        np.minimum(lo[:-1] + h_lo[:-1], lo[1:] + h_lo[1:]) + curvature,
        np.maximum(hi[:-1] + h_hi[:-1], hi[1:] + h_hi[1:]) + curvature,
        np.minimum(v_lo[:-1], v_lo[1:]),
        np.maximum(v_hi[:-1], v_hi[1:]),
        difference,
    )


def residual_bounds(old, new, step, table):
    old_potential = potential_numerator(old)
    new_potential = potential_numerator(new)
    potential_time = -TIME_SCALE * (new_potential - old_potential)
    old_lo, old_hi, v0_lo, v0_hi, diff0 = corner_data(
        old, old_potential, potential_time, step, table
    )
    new_lo, new_hi, v1_lo, v1_hi, diff1 = corner_data(
        new, new_potential, potential_time, step, table
    )
    poly = ceil_div(
        step * np.maximum(abs(diff0), abs(diff1)) + 2 * TIME_SCALE * abs(diff1 - diff0),
        16 * CELLS * step,
    )
    p_max = np.maximum.reduce([old[:-1], old[1:], new[:-1], new[1:]])
    p_min = np.minimum.reduce([old[:-1], old[1:], new[:-1], new[1:]])
    v_range = np.maximum(v0_hi, v1_hi) - np.minimum(v0_lo, v1_lo)
    concavity = ceil_div((p_max - p_min) * v_range, 4 * V_SCALE)
    return (
        int(np.min(np.minimum(old_lo, new_lo) - poly)),
        int(np.max(np.maximum(old_hi, new_hi) + poly + concavity)),
    )


def discounted_weight(old_tick, new_tick, old_exponential):
    assert 0 <= old_tick < new_tick <= HORIZON * TIME_SCALE
    new_exponential, _ = exponential_integral_bounds(Fraction(new_tick, 2 * TIME_SCALE))
    weight = (
        2 * (old_exponential[0] - new_exponential[1]),
        2 * (old_exponential[1] - new_exponential[0]),
    )
    lo, hi = outward(*weight, W_SCALE)
    assert 0 < lo <= hi
    return lo, hi, new_exponential


def certify():
    assert CELLS % 2 == 0 and 2 * CELLS * P_SCALE * TIME_SCALE < 2**63
    table = gaussian_table()
    rows = trial_rows()
    old_tick, old = next(rows)
    assert old_tick == 0 and not np.any(old[:-1]) and old[-1] == P_SCALE
    exponential = (Fraction(1), Fraction(1))
    low_num, high_num, steps = 0, 0, 0
    for tick, new in rows:
        assert np.all(new >= 0) and np.all(new <= P_SCALE)
        assert new[0] == 0 and new[-1] == P_SCALE
        q_lo, q_hi = residual_bounds(old, new, tick - old_tick, table)
        weight_lo, weight_hi, exponential = discounted_weight(old_tick, tick, exponential)
        low_num += q_lo * (weight_lo if q_lo >= 0 else weight_hi)
        high_num += q_hi * (weight_hi if q_hi >= 0 else weight_lo)
        old_tick, old = tick, new
        steps += 1
    assert old_tick == HORIZON * TIME_SCALE
    scale = P_SCALE * W_SCALE
    low = (Fraction(low_num, scale) - Fraction(1, 2 * CELLS) - 2 * exponential[1]) / 2
    high = (Fraction(high_num, scale) + 4 * exponential[1]) / 2
    lo_dec, hi_dec = outward(low, high, 10**5)
    assert Fraction(1034, 1000) < low < high < Fraction(1052, 1000)
    print(f"Spatial cells: {CELLS}; verified time cells: {steps}")
    print(f"Outward-rounded enclosure at 1e-5 scale: [{lo_dec}, {hi_dec}] / 100000")
    print("Certified: 1.034 < C_star < 1.052 for alpha=kappa=1/2")


if __name__ == "__main__":
    certify()
