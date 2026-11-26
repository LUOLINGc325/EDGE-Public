"""Independent continuous quadrature and speed-constrained finite-grid checks."""
import json
import math

import numpy as np
from scipy.integrate import quad
from scipy.optimize import minimize


def integrate(f, end, points=()):
    return quad(
        f, 0.0, end, points=sorted({p for p in points if 0.0 < p < end}),
        epsabs=2e-12, epsrel=2e-12, limit=200,
    )[0]


def fixed_profile(k, end, a, b, initial, final, level):
    upper_switch = math.log((a - initial + (final + b) * math.exp(k * end)) / (a + b)) / k
    lower_switch = math.log((b + initial + (a - final) * math.exp(k * end)) / (a + b)) / k

    def bounds(t):
        forward_lower = -b + (initial + b) * math.exp(-k * t)
        forward_upper = a + (initial - a) * math.exp(-k * t)
        backward_lower = a + (final - a) * math.exp(k * (end - t))
        backward_upper = -b + (final + b) * math.exp(k * (end - t))
        return max(forward_lower, backward_lower), min(forward_upper, backward_upper)

    def profile(t):
        lo, hi = bounds(t)
        return min(hi, max(lo, level))

    points = [upper_switch, lower_switch]
    if -b < level < a:
        for numerator, denominator, from_end in (
            (a - initial, a - level, False),
            (initial + b, level + b, False),
            (a - level, a - final, True),
            (level + b, final + b, True),
        ):
            if numerator > 0 and denominator > 0:
                switch = math.log(numerator / denominator) / k
                points.append(end - switch if from_end else switch)
    return profile, points


def free_profile(k, end, a, b, level):
    decay = math.exp(-k * end)
    other = b + 2 * level
    root = 2 * a * other * (1 - decay) / (
        a + other + math.sqrt((a - other)**2 + 4 * a * other * decay)
    )
    peak = min(level, root)
    arrival = math.log(a / (a - peak)) / k
    brake_duration = math.log(other / (other - peak)) / k
    terminal = peak * (2 * level - peak) / other

    def profile(t):
        return min(level, a * -math.expm1(-k * t),
                   -b + (terminal + b) * math.exp(k * (end - t)))

    return profile, [arrival, end - brake_duration], terminal


def actuator_profile(k, end, a, level):
    duration = math.log(a / (a - level)) / k
    terminal = 2 * level - level**2 / a
    displacement = 2 * a * duration + level * (end - 2 * duration)

    def profile(t):
        if t < duration:
            return a * -math.expm1(-k * t)
        if t <= end - duration:
            return level
        return a + (level - a) * math.exp(-k * (t - end + duration))

    return profile, [duration, end - duration], terminal, displacement


def discrete_qp(k, end, a, b, initial, displacement, target=None, cells=170, actuator=False):
    dt = end / cells
    decay = math.exp(-k * dt)
    state = np.zeros((cells + 1, cells))
    for j in range(cells):
        state[j + 1] = decay * state[j]
        state[j + 1, j] += 1 - decay
    offset = initial * decay ** np.arange(cells + 1)
    one = -math.expm1(-k * dt) / k
    two = -math.expm1(-2 * k * dt) / (2 * k)
    eu, uu = one - two, dt - 2 * one + two
    base = state[:-1]
    last = state[-1]

    area_vector = one * base.sum(axis=0) + dt - one
    area_const = one * offset[:-1].sum()
    eq_jac = area_vector[None, :]
    eq_rhs = np.array([displacement - area_const])
    if actuator:
        eq_jac = np.full((1, cells), dt)
        eq_rhs = np.array([displacement])
    if target is not None:
        eq_jac = np.vstack([area_vector, last])
        eq_rhs = np.append(eq_rhs, target - offset[-1])

    def loss(u):
        v = base @ u + offset[:-1]
        result = two * (v @ v) + 2 * eu * (u @ v) + uu * (u @ u)
        if target is None:
            result += (last @ u + offset[-1])**2 / (2 * k)
        return result

    def jac(u):
        v = base @ u + offset[:-1]
        result = 2 * two * (base.T @ v) + 2 * eu * (v + base.T @ u) + 2 * uu * u
        if target is None:
            result += (last @ u + offset[-1]) * last / k
        return result

    result = minimize(
        loss, np.zeros(cells), jac=jac, method="SLSQP",
        bounds=[(-b, a)] * cells,
        constraints={"type": "eq", "fun": lambda u: eq_jac @ u - eq_rhs,
                     "jac": lambda u: eq_jac},
        options={"ftol": 1e-12, "maxiter": 1000},
    )
    if not result.success:
        raise RuntimeError(result.message)
    return float(result.fun)


def main():
    k, end, a, b = 1.4, 1.65, 2.7, 1.1
    cases = []
    for initial, final, level in [(0.0, 0.0, 1.0), (0.9, -0.38, 0.12),
                                  (-0.4, 1.1, 0.0), (0.65, -0.35, -0.55)]:
        profile, points = fixed_profile(k, end, a, b, initial, final, level)
        displacement = integrate(profile, end, points)
        exact = integrate(lambda t: profile(t)**2, end, points)
        discrete = discrete_qp(k, end, a, b, initial, displacement, target=final)
        assert abs(profile(0) - initial) < 1e-12 and abs(profile(end) - final) < 1e-12
        assert -1e-8 < discrete - exact < 2e-4, (discrete, exact)
        cases.append({"kind": "fixed", "initial": initial, "final": final, "level": level,
                      "displacement": displacement, "energy": exact, "grid_energy": discrete})
    for level in [0.3, 1.2, 3.0, 10.0]:
        profile, points, final = free_profile(k, end, a, b, level)
        displacement = integrate(profile, end, points)
        exact = integrate(lambda t: profile(t)**2, end, points) + final**2 / (2 * k)
        discrete = discrete_qp(k, end, a, b, 0.0, displacement)
        assert abs(profile(end) - final) < 1e-12
        assert -1e-8 < discrete - exact < 9e-4, (discrete, exact)
        cases.append({"kind": "free", "level": level, "terminal": final,
                      "displacement": displacement, "energy": exact, "grid_energy": discrete})

    limit_level = a * -math.expm1(-k * end / 2)
    for level in [0.4, 0.8, 0.95 * limit_level]:
        profile, points, final, displacement = actuator_profile(k, end, a, level)
        exact = integrate(lambda t: profile(t)**2, end, points) + final**2 / (2*k)
        discrete = discrete_qp(k, end, a, b, 0.0, displacement, actuator=True)
        assert abs(integrate(profile, end, points) + final/k - displacement) < 1e-12
        assert -1e-8 < discrete - exact < 9e-4, (discrete, exact)
        cases.append({"kind": "actuator", "level": level, "terminal": final,
                      "displacement": displacement, "energy": exact, "grid_energy": discrete})

    upper, switches = fixed_profile(k, end, a, b, 0.0, 0.0, a)
    apex = upper(switches[0])
    lim_area = integrate(upper, end, switches)
    lim_energy = integrate(lambda t: upper(t)**2, end, switches)
    slope_sum = 1 / (k * (a - apex)) + 1 / (k * (b + apex))
    fixed_coefficient = 4 * math.sqrt(2) / (3 * math.sqrt(slope_sum))
    fixed_samples = []
    for epsilon in [0.02, 0.01, 0.003]:
        profile, points = fixed_profile(k, end, a, b, 0.0, 0.0, apex - epsilon)
        area_diff = lim_area - integrate(profile, end, points)
        energy_diff = integrate(lambda t: profile(t)**2, end, points) - lim_energy
        ratio = (energy_diff + 2 * apex * area_diff) / area_diff**1.5
        fixed_samples.append(ratio)
    assert abs(fixed_samples[-1] / fixed_coefficient - 1) < 0.002

    forward = lambda t: a * -math.expm1(-k * t)
    max_free_area = integrate(forward, end)
    max_free_energy = integrate(lambda t: forward(t)**2, end) + forward(end)**2 / (2 * k)
    free_coefficient = forward(end) * math.sqrt(2 * (a + b) / k)
    free_samples = []
    for level in [60.0, 300.0, 1500.0]:
        profile, points, terminal = free_profile(k, end, a, b, level)
        delta = max_free_area - integrate(profile, end, points)
        energy_diff = max_free_energy - integrate(lambda t: profile(t)**2, end, points) - terminal**2 / (2 * k)
        free_samples.append(energy_diff / math.sqrt(delta))
    assert abs(free_samples[-1] / free_coefficient - 1) < 0.002
    print(json.dumps({"cases": cases, "cells": 170, "fixed_frontier": {
        "prediction": fixed_coefficient, "ratios": fixed_samples}, "free_frontier": {
        "prediction": free_coefficient, "ratios": free_samples}}, indent=2))


if __name__ == "__main__":
    main()
