#!/usr/bin/env python3
"""Exact rational certificates for the five-block slope-profile band.

This program certifies an OUTER interval for the coordinate projection of the
original log-concave band relaxation. It does not solve that multivariate
optimization problem. All mathematical decisions use fractions.Fraction;
floating-point numbers are rejected as inputs. Decimal input strings denote
their exact rational values. No third-party numerical package is required.

The code implements one finite, auditable realization of the manuscript's
secondary algorithm. `scalar_band` requires valid mass bounds and five blocks.
`calibrate` supplies outward bounds on the original integer-Beta quantiles.
`node_band` applies the observable stencil across available original scales.
It returns only nodal density intervals; the continuous concavity extension is
proved in the manuscript but is deliberately not implemented here.

Arithmetic certificates establish enclosure, not efficient uniform bit
complexity. Large samples or extreme rational inputs can be expensive.
"""

from __future__ import annotations

import argparse
import json
from dataclasses import dataclass
from fractions import Fraction as Q
from pathlib import Path
from typing import Iterable


def rational(value: Q | int | str) -> Q:
    """Read an exact rational; never silently accept a binary float."""
    if isinstance(value, bool) or isinstance(value, float):
        raise TypeError("use an integer, Fraction, or exact decimal/rational string")
    if not isinstance(value, (int, str, Q)):
        raise TypeError("unsupported rational input")
    return Q(value)


@dataclass(frozen=True)
class Interval:
    lo: Q
    hi: Q

    def __post_init__(self) -> None:
        object.__setattr__(self, "lo", rational(self.lo))
        object.__setattr__(self, "hi", rational(self.hi))
        if self.lo > self.hi:
            raise ValueError("reversed interval")

    @classmethod
    def point(cls, x: Q | int | str) -> "Interval":
        return cls(rational(x), rational(x))

    def __add__(self, other: "Interval") -> "Interval":
        return Interval(self.lo + other.lo, self.hi + other.hi)

    def __sub__(self, other: "Interval") -> "Interval":
        return Interval(self.lo - other.hi, self.hi - other.lo)

    def __mul__(self, other: "Interval") -> "Interval":
        products = [a * b for a in (self.lo, self.hi)
                    for b in (other.lo, other.hi)]
        return Interval(min(products), max(products))

    def reciprocal(self) -> "Interval":
        if self.lo <= 0 <= self.hi:
            raise ZeroDivisionError("interval contains zero")
        return Interval(1 / self.hi, 1 / self.lo)

    def __truediv__(self, other: "Interval") -> "Interval":
        return self * other.reciprocal()

    def square_positive(self) -> "Interval":
        if self.lo < 0:
            raise ValueError("positive interval required")
        return Interval(self.lo * self.lo, self.hi * self.hi)

    def intersect(self, other: "Interval") -> "Interval":
        return Interval(max(self.lo, other.lo), min(self.hi, other.hi))

    def json(self) -> dict[str, str]:
        return {"lo": str(self.lo), "hi": str(self.hi)}


def _two_power(k: int) -> Q:
    return Q(2 ** k) if k >= 0 else Q(1, 2 ** (-k))


def _floor_log2(x: Q) -> int:
    if x <= 0:
        raise ValueError("positive argument required")
    k = x.numerator.bit_length() - x.denominator.bit_length()
    return k - 1 if x < _two_power(k) else k


def _round_positive(interval: Interval, bits: int) -> Interval:
    """Outward dyadic rounding controls rational denominator growth."""
    if interval.lo <= 0:
        raise ValueError("strictly positive interval required")
    step = _two_power(_floor_log2(interval.hi) - bits)
    a, b = interval.lo / step, interval.hi / step
    lower = (a.numerator // a.denominator) * step
    upper = (-(-b.numerator // b.denominator)) * step
    return Interval(lower, upper)


def _round_absolute(interval: Interval, bits: int) -> Interval:
    """Outward rounding to the absolute grid 2**(-bits)."""
    step = _two_power(-bits)
    a, b = interval.lo / step, interval.hi / step
    return Interval((a.numerator // a.denominator) * step,
                    (-(-b.numerator // b.denominator)) * step)


def exp_interval(x: Q | int | str, bits: int = 96) -> Interval:
    """Enclose exp(x) by a positive Taylor series, then exact squaring.

    For 0 <= y <= 1/2, after term y^k/k!, the remaining series is at most
    (y^(k+1)/(k+1)!)/(1-y/(k+2)). This geometric majorant is exact.
    Negative arguments use reciprocal intervals. Rounding is always outward.
    """
    x = rational(x)
    if bits < 16:
        raise ValueError("bits must be at least 16")
    if x == 0:
        return Interval.point(1)
    if x < 0:
        return exp_interval(-x, bits).reciprocal()
    y, squarings = x, 0
    while y > Q(1, 2):
        y /= 2
        squarings += 1
    working_bits = bits + squarings + 12
    epsilon = _two_power(-working_bits)
    total, term, k = Q(1), Q(1), 0
    while True:
        next_term = term * y / (k + 1)
        tail = next_term / (1 - y / (k + 2))
        if tail <= epsilon * total:
            out = Interval(total, total + tail)
            break
        k += 1
        term = next_term
        total += term
    out = _round_positive(out, working_bits)
    for _ in range(squarings):
        out = _round_positive(out.square_positive(), working_bits)
    return out


def _log_reduced(y: Q, bits: int) -> Interval:
    """For 1 <= y <= 2, log y = 2*atanh((y-1)/(y+1))."""
    if not 1 <= y <= 2:
        raise ValueError("range reduction failed")
    z = (y - 1) / (y + 1)
    if not z:
        return Interval.point(0)
    z2, power, total, j = z * z, z, Q(0), 0
    epsilon = _two_power(-bits)
    while True:
        total += 2 * power / (2 * j + 1)
        power *= z2
        tail = 2 * power / ((2 * j + 3) * (1 - z2))
        if tail <= epsilon:
            return Interval(total, total + tail)
        j += 1


def log_interval(x: Q | int | str, bits: int = 96) -> Interval:
    """Enclose log of a positive rational, using only rational series."""
    x = rational(x)
    if x <= 0:
        raise ValueError("log requires a positive argument")
    k = _floor_log2(x)
    working_bits = bits + (abs(k) + 1).bit_length() + 4
    reduced = _log_reduced(x / _two_power(k), working_bits)
    log2 = _log_reduced(Q(2), working_bits)
    return _round_absolute(reduced + Interval.point(k) * log2, bits + 4)


def log_of_interval(x: Interval, bits: int = 96) -> Interval:
    return Interval(log_interval(x.lo, bits).lo,
                    log_interval(x.hi, bits).hi)


def integral_exp(left: Q, right: Q, slope: Q, bits: int = 96) -> Interval:
    """Enclose integral_left^right exp(slope*t) dt.

    Endpoint subtraction is intersected with positive integrand bounds. This
    remains valid near zero slope even when cancellation widens the enclosure.
    """
    left, right, slope = map(rational, (left, right, slope))
    if left >= right:
        raise ValueError("block must have positive length")
    length = right - left
    if slope == 0:
        return Interval.point(length)
    a, b = exp_interval(slope * left, bits), exp_interval(slope * right, bits)
    difference = (b - a) / Interval.point(slope)
    coarse = Interval(length * min(a.lo, b.lo),
                      length * max(a.hi, b.hi))
    return difference.intersect(coarse)


@dataclass(frozen=True)
class Block:
    left: Q
    right: Q
    mass: Q

    def __post_init__(self) -> None:
        for name in ("left", "right", "mass"):
            object.__setattr__(self, name, rational(getattr(self, name)))
        if not self.left < self.right:
            raise ValueError("block must have positive length")
        if not 0 < self.mass <= 1:
            raise ValueError("mass bound must be in (0,1]")


@dataclass(frozen=True)
class FiveBlocks:
    """Coordinates are translated so that the target is zero.

    The four flank masses are LOWER bounds; the central mass is an UPPER
    bound. Flanks must represent original interior blocks when this is used
    to enclose the original vector relaxation. `stencil` enforces that rule.
    """
    left: tuple[Block, Block]
    right: tuple[Block, Block]
    center: Block
    h: Q
    radius: Q = Q(12)

    def __post_init__(self) -> None:
        object.__setattr__(self, "h", rational(self.h))
        object.__setattr__(self, "radius", rational(self.radius))
        if self.h <= 0 or self.radius < 3:
            raise ValueError("invalid geometric constants")
        if len(self.left) != 2 or len(self.right) != 2:
            raise ValueError("exactly two blocks on each side are needed")
        for pair in (self.left, self.right):
            if pair[0].right > pair[1].left:
                raise ValueError("same-side blocks must be ordered and disjoint")
        if any(b.left < -self.radius * self.h or b.right > -3 * self.h
               for b in self.left):
            raise ValueError("left-block geometry fails")
        if any(b.left < 3 * self.h or b.right > self.radius * self.h
               for b in self.right):
            raise ValueError("right-block geometry fails")
        if not -self.h <= self.center.left < self.center.right <= self.h:
            raise ValueError("central-block geometry fails")


def _minimum(intervals: Iterable[Interval]) -> Interval:
    values = tuple(intervals)
    return Interval(min(x.lo for x in values), min(x.hi for x in values))


def profile(blocks: FiveBlocks, slope: Q, bits: int = 96) -> dict[str, Interval]:
    """Positive density-scale profile; no numerical logarithms are needed."""
    def ratio(block: Block) -> Interval:
        return Interval.point(block.mass) / integral_exp(
            block.left, block.right, slope, bits)
    left, right = _minimum(map(ratio, blocks.left)), _minimum(map(ratio, blocks.right))
    center = ratio(blocks.center)
    lower = _minimum((left, right))
    upper_left = center.square_positive() / left
    upper_right = center.square_positive() / right
    upper = Interval(max(upper_left.lo, upper_right.lo),
                     max(upper_left.hi, upper_right.hi))
    return {"left": left, "right": right, "center": center,
            "lower": lower, "upper": upper,
            "upper_left": upper_left, "upper_right": upper_right}


def _log_gap(values: dict[str, Interval], bits: int) -> Interval:
    return log_of_interval(values["left"] / values["right"], bits)


def scalar_band(blocks: FiveBlocks, log_tolerance: Q = Q(1, 10**6),
                bits: int = 96, max_iterations: int = 256) -> dict:
    """Return certified finite endpoints and a bracket for the global root.

    `log_endpoint_error_bound` bounds the loss of EACH reported log endpoint
    from the mathematically optimal profile for the supplied mass constants.
    The certificate remains an enclosure if `converged` is false. A crossing
    output lower > upper certifies that no vector meeting the stipulated
    five-block constraints exists; it must not be called coverage success.
    """
    tolerance = rational(log_tolerance)
    if tolerance <= 0 or max_iterations < 1:
        raise ValueError("positive tolerance and iteration limit required")
    bits = max(bits, -_floor_log2(tolerance) + 32, 32)
    zero = profile(blocks, Q(0), bits)
    gap0 = _log_gap(zero, bits)
    magnitude = max(abs(gap0.lo), abs(gap0.hi))
    root = Interval(-magnitude / (6 * blocks.h), magnitude / (6 * blocks.h))
    iterations = 0
    precision_increases = 0
    while ((blocks.radius + 2) * blocks.h * (root.hi - root.lo) > tolerance / 2
           and iterations < max_iterations):
        midpoint = (root.lo + root.hi) / 2
        gap = _log_gap(profile(blocks, midpoint, bits), bits)
        if gap.hi < 0:
            new = Interval(midpoint, root.hi)
        elif gap.lo > 0:
            new = Interval(root.lo, midpoint)
        else:
            new = root.intersect(Interval(midpoint - gap.hi / (6 * blocks.h),
                                         midpoint - gap.lo / (6 * blocks.h)))
        if new.hi - new.lo > (root.hi - root.lo) / 2:
            bits *= 2
            precision_increases += 1
        root = new
        iterations += 1
    # Evaluations may have more uncertainty than desired on ill-scaled input.
    # Refining them is logically separate from shrinking the root bracket.
    for _ in range(12):
        evaluated_bits = bits
        lower_profile = profile(blocks, root.lo, bits)
        upper_profile = profile(blocks, root.hi, bits)
        candidate_lowers = (lower_profile["left"], upper_profile["right"])
        candidate_uppers = (lower_profile["upper_left"], upper_profile["upper_right"])
        numeric_error = max(log_interval(iv.hi / iv.lo, bits).hi
                            for iv in candidate_lowers + candidate_uppers)
        if numeric_error <= tolerance / 2:
            break
        bits *= 2
        precision_increases += 1
    lower = max(iv.lo for iv in candidate_lowers)
    upper = min(iv.hi for iv in candidate_uppers)
    error = (blocks.radius + 2) * blocks.h * (root.hi - root.lo) + numeric_error
    return {
        "lower": lower,
        "upper": upper,
        "root_bracket": root,
        "log_endpoint_error_bound": error,
        "log_tolerance": tolerance,
        "converged": error <= tolerance,
        "infeasibility_certificate": lower > upper,
        "iterations": iterations,
        "precision_bits": evaluated_bits,
        "precision_increases": precision_increases,
        "arithmetic": "exact rational interval arithmetic",
        "scope": "five-block outer coordinate certificate; not original exact extrema",
    }


def beta_cdf_integer(alpha: int, beta: int, z: Q) -> Q:
    """Exact integer-Beta CDF via a binomial polynomial, no special functions."""
    z = rational(z)
    if (not isinstance(alpha, int) or not isinstance(beta, int)
            or alpha < 1 or beta < 1 or not 0 <= z <= 1):
        raise ValueError("positive integer shapes and z in [0,1] required")
    if z in (0, 1):
        return z
    n, a, denominator = alpha + beta - 1, z.numerator, z.denominator
    complement = denominator - a
    term, total = complement ** n, 0
    for k in range(n + 1):
        if k >= alpha:
            total += term
        if k < n:
            numerator = term * (n - k) * a
            divisor = (k + 1) * complement
            term, remainder = divmod(numerator, divisor)
            if remainder:
                raise ArithmeticError("integer polynomial recurrence lost exactness")
    return Q(total, denominator ** n)


def beta_quantile_bracket(alpha: int, beta: int, probability: Q,
                          steps: int = 48) -> Interval:
    """Exact quantile bracket; lo and hi are outward, not rounded estimates."""
    probability = rational(probability)
    if not 0 < probability < 1 or steps < 1:
        raise ValueError("interior probability and positive steps required")
    low, high = Q(0), Q(1)
    for _ in range(steps):
        midpoint = (low + high) / 2
        value = beta_cdf_integer(alpha, beta, midpoint)
        if value == probability:
            return Interval.point(midpoint)
        if value < probability:
            low = midpoint
        else:
            high = midpoint
    return Interval(low, high)


def calibrate(n: int, alpha: Q = Q(1, 20), quantile_steps: int | None = None) -> dict:
    """Original dyadic multiplicity allocation, with outward Beta constants.

    The exact source quantiles are enclosed, not replaced by a tail inequality.
    The default guarantees absolute mass uncertainty <= n**(-3)/16. An
    explicit quantile_steps overrides this precision, retaining coverage but
    not necessarily the manuscript's asymptotic numerical error guarantee.
    Extremely small n can have no scales; that is rejected explicitly.
    """
    alpha = rational(alpha)
    if not isinstance(n, int) or n < 3 or not 0 < alpha < 1:
        raise ValueError("n >= 3 and alpha in (0,1) required")
    if quantile_steps is None:
        quantile_steps = 3 * n.bit_length() + 4
    logn, bits, s, q = log_interval(Q(n)), 96, 0, 1
    while True:
        if logn.hi <= q:
            break
        if logn.lo > q:
            s, q = s + 1, 2 * q
        else:
            bits *= 2
            logn = log_interval(Q(n), bits)
    bmax = n.bit_length() - 1 - 3 - s
    if bmax < 0:
        raise ValueError("sample size has no original dyadic scales")
    harmonic = sum((Q(1, b + 2) for b in range(bmax + 1)), Q(0))
    scales = []
    for b in range(bmax + 1):
        r = q * 2 ** b
        count = (n - 1) // r
        delta = alpha / (2 * (b + 2) * count * harmonic)
        lower_q = beta_quantile_bracket(r, n + 1 - r, delta, quantile_steps)
        upper_q = beta_quantile_bracket(r, n + 1 - r, 1 - delta, quantile_steps)
        if lower_q.lo == 0:
            raise ValueError("quantile_steps too small to certify a positive lower mass")
        scales.append({"B": b, "step": 2 ** b, "r": r, "count": count,
                       "delta": delta, "c": lower_q.lo, "d": upper_q.hi,
                       "c_quantile_bracket": lower_q, "d_quantile_bracket": upper_q})
    return {"n": n, "alpha": alpha, "q": q, "s": s,
            "m": (n - 1) // q + 1, "H": harmonic, "scales": scales,
            "quantile_steps": quantile_steps,
            "quantile_absolute_error_bound": _two_power(-quantile_steps),
            "rate_precision_sufficient": _two_power(-quantile_steps) <= Q(1, n**3)}


def stencil(grid: Iterable[Q], target_index: int, step: int,
            lower_mass: Q, upper_mass: Q) -> FiveBlocks | None:
    """Observable center and offsets -16,-8,+8,+16; return None if unusable.

    The grid is x_i = X_(1+(i-1)q). Zero-based indices are used in code.
    All selected flank endpoints must be interior grid nodes. A geometry
    failure is a normal fallback, never an invitation to change the proof.
    """
    knots = tuple(map(rational, grid))
    if len(knots) < 2 or any(a >= b for a, b in zip(knots, knots[1:])):
        raise ValueError("grid must be strictly increasing")
    if not isinstance(step, int) or step < 1 or not 0 <= target_index < len(knots):
        raise ValueError("invalid step or target index")
    count = (len(knots) - 1) // step
    v = min(target_index // step, count - 1)
    if count < 1 or target_index > count * step:
        return None
    indices = (v - 16, v - 8, v + 8, v + 16)
    if any(j < 0 or j >= count or j * step < 1
           or (j + 1) * step >= len(knots) - 1 for j in indices):
        return None
    target = knots[target_index]
    def block(j: int, mass: Q) -> Block:
        return Block(knots[j * step] - target,
                     knots[(j + 1) * step] - target, mass)
    center = block(v, upper_mass)
    h = 2 * (center.right - center.left)
    try:
        return FiveBlocks((block(indices[0], lower_mass), block(indices[1], lower_mass)),
                          (block(indices[2], lower_mass), block(indices[3], lower_mass)),
                          center, h)
    except ValueError:
        return None


def node_band(sample: Iterable[Q], target_index: int, calibration: dict,
              log_tolerance: Q | None = None) -> dict:
    """Multiscale nodal certificate from a sorted exact-rational sample.

    The caller may sort first. Ties are rejected (probability zero for a true
    density). If no scale has the certified geometry, return [0,+infinity].
    Quantile constants come from `calibrate`; an externally modified dict is
    outside this function's trust boundary.
    """
    sample = tuple(map(rational, sample))
    n, q = calibration["n"], calibration["q"]
    if len(sample) != n or any(a >= b for a, b in zip(sample, sample[1:])):
        raise ValueError("sample must be strictly sorted with calibrated size")
    grid = sample[::q]
    if not 0 <= target_index < len(grid):
        raise ValueError("target index outside the selected grid")
    tolerance = rational(log_tolerance) if log_tolerance is not None else Q(1, n)
    intervals = []
    for scale in calibration["scales"]:
        blocks = stencil(grid, target_index, scale["step"], scale["c"], scale["d"])
        if blocks is not None:
            interval = scalar_band(blocks, tolerance)
            interval["B"] = scale["B"]
            intervals.append(interval)
    lower = max((x["lower"] for x in intervals), default=Q(0))
    upper = min((x["upper"] for x in intervals), default=None)
    return {"target": grid[target_index], "target_index": target_index,
            "lower": lower, "upper": upper,
            "infeasibility_certificate": upper is not None and lower > upper,
            "all_scalar_tolerances_met": all(x["converged"] for x in intervals),
            "rate_precision_sufficient": calibration.get("rate_precision_sufficient", False),
            "scales_used": len(intervals), "certificates": intervals,
            "fallback": "uninformative [0,+infinity]" if not intervals else None}


def jsonable(value):
    if isinstance(value, Q):
        return str(value)
    if isinstance(value, Interval):
        return value.json()
    if isinstance(value, dict):
        return {str(k): jsonable(v) for k, v in value.items()}
    if isinstance(value, (list, tuple)):
        return [jsonable(v) for v in value]
    return value


def demo() -> dict:
    """A deterministic symmetric fixture, not a coverage simulation."""
    blocks = FiveBlocks((Block(-8, -7, Q(1, 10)), Block(-4, -3, Q(1, 10))),
                        (Block(3, 4, Q(1, 10)), Block(7, 8, Q(1, 10))),
                        Block(Q(-1, 2), Q(1, 2), Q(3, 25)), Q(1), Q(8))
    result = scalar_band(blocks, Q(1, 10**8))
    return {"description": "Exact symmetric five-block fixture; root zero is exact.",
            "expected_lower": Q(1, 10), "expected_upper": Q(18, 125),
            "certificate": result,
            "limitations": ["No empirical experiment establishes coverage.",
                            "The mathematical proof and outward arithmetic establish enclosure.",
                            "Continuous extension and full-sample performance are not benchmarked."]}


def pipeline_demo() -> dict:
    """Reproduce the asymmetric and calibrated nodal deterministic fixtures."""
    blocks = FiveBlocks((Block(-8, -7, Q(2, 25)), Block(-4, -3, Q(3, 25))),
                        (Block(3, 4, Q(1, 10)), Block(7, 8, Q(3, 20))),
                        Block(Q(-2, 5), Q(3, 5), Q(4, 25)), Q(1), Q(8))
    calibration = calibrate(320)
    band = node_band([Q(i, 320) for i in range(320)], 20, calibration, Q(1, 10**5))
    return {"kind": "deterministic arithmetic certificates; not statistical simulation",
            "asymmetric_five_block": scalar_band(blocks, Q(1, 10**7)),
            "integer_beta_pipeline": {"calibration": calibration, "node_band": band}}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--pipeline", action="store_true",
                        help="also exercise asymmetric and exact-Beta nodal fixtures")
    args = parser.parse_args()
    output = json.dumps(jsonable(pipeline_demo() if args.pipeline else demo()), indent=2) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(output)
    else:
        print(output, end="")
