"""Evaluate conservative rational foreground bounds and the transition formula."""

import json
import math
from fractions import Fraction

R = Fraction


def check(condition, message):
    if not condition:
        raise ValueError(message)


def display_interval(lower, upper, digits=8):
    denominator = 10 ** digits
    lo = math.floor(lower * denominator)
    hi = math.ceil(upper * denominator)
    return {"lower_units": lo, "upper_units": hi, "units_denominator": denominator}


def exp_minus(x):
    """Exact rational enclosures via alternating terms on [0, 1]."""
    count = max(1, math.ceil(x))
    y = x / count
    term = R(1)
    total = term
    for j in range(1, 61):
        term *= -y / j
        total += term
        if j == 59:
            lower = total
    return lower ** count, total ** count


def passage_interval(p, rho, gamma, c):
    s = 1 - p - rho
    a_coefficient = (1 / p + 1 / s) / 2
    drift = a_coefficient * c * c
    lo = hi = R(0)
    for j in range(math.ceil(2 * gamma)):
        x = rho * (gamma - R(j, 2)) / drift
        poly = sum(x ** t / math.factorial(t) for t in range(j + 1))
        exp_lo, exp_hi = exp_minus(x)
        lo += (1 - exp_hi * poly) / rho
        hi += (1 - exp_lo * poly) / rho
    check(0 <= lo <= hi <= gamma / drift, "passage-time bounds inconsistent")
    check(hi - lo < R(1, 10 ** 40), "rational enclosure too wide")
    return lo, hi


def foreground_bounds(p, q, gamma, n):
    """Dyadic a=2^-n, for n divisible by the denominator of gamma."""
    rho = q - p
    a = R(1, 2 ** n)
    sqrt_a = R(1, 2 ** (n // 2))
    k = math.ceil(2 * gamma)
    check(n % 2 == 0 and (n * gamma).denominator == 1, "n needs integral exponents")
    alpha = R(1, 2 ** int(n * gamma))
    horizon_multiplier = math.ceil(8 / rho)
    horizon = math.ceil(horizon_multiplier * n / a)
    boundary_coefficient = 4 * (math.isqrt(horizon_multiplier * (k + 2)) + 1)
    b = boundary_coefficient * n / sqrt_a
    noise = 2 * a ** (k + 2)
    check(b * b / (2 * horizon) >= (k + 2) * n, "noise exponent too small")
    hazard = a * (2 * b + 1)
    level_bound = noise + (3 * hazard / k) ** k
    eligible = hazard < k and level_bound <= alpha / 2
    out = {"n": n, "audit_count": k, "certified_at_alpha": eligible}
    if eligible:
        check(a * b <= R(1, 2), "fallback exponential reduction requires ab<=1/2")
        foreground = (k + hazard + (1 + a * rho) * horizon * noise) / rho
        # Use e^(ab) < 2, log 2 < 1, Pinsker, and log(q/p) <= q/p - 1.
        survival = noise + 2 ** k * a ** 4
        fallback_cost = (1 + n * gamma + q / p - 1) / (2 * rho * rho)
        upper = foreground + survival * fallback_cost
        out["a_scaled_cost"] = {
            "asymptotic_target": str(k / rho),
            "finite_upper_units": math.ceil(upper * 10 ** 8),
            "units_denominator": 10 ** 8,
        }
    return out


def factor_check(p, rho, d, a):
    """Check exact null factor mean over a grid of feasible laws."""
    s = 1 - p - rho
    factors = (1 + d / p, 1 - d / s, 1 + d * (1 / p + 1 / s) / a, R(1), R(1))
    checks = 0
    for j in range(21):
        theta = p * j / 20
        for i in range(21):
            hidden_one = min(theta, rho) * i / 20
            for k in range(21):
                hidden_zero = min(1 - theta, rho - hidden_one) * k / 20
                record = (
                    theta - hidden_one, 1 - theta - hidden_zero,
                    a * hidden_one, a * hidden_zero,
                    (1 - a) * (hidden_one + hidden_zero),
                )
                mean = sum(x * y for x, y in zip(record, factors))
                check(sum(record) == 1 and mean <= 1, "null factor failed")
                checks += 1
    return checks


def main():
    p, q = R(1, 5), R(1, 2)
    rho = q - p
    results = {"null_factor_grid_checks": factor_check(p, rho, R(1, 20), R(1, 128))}
    for gamma in (R(1, 4), R(3, 4), R(5, 4)):
        passages = []
        previous_lower = math.ceil(2 * gamma) / rho
        for c in (R(1, 10), R(1, 4), R(1, 2), R(1)):
            lo, hi = passage_interval(p, rho, gamma, c)
            check(hi < previous_lower, "transition cost should decrease with drift")
            previous_lower = lo
            passages.append({"c": str(c), **display_interval(lo, hi)})
        results[str(gamma)] = {
            "bridge": passages,
            "finite_foreground_bounds": [foreground_bounds(p, q, gamma, n)
                                         for n in (32, 64, 96, 128, 160)],
        }
    print(json.dumps(results, indent=2))


if __name__ == "__main__":
    main()
