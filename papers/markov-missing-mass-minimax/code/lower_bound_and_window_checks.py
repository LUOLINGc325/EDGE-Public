#!/usr/bin/env python3
"""Small independent path-enumeration checks for route B, round 1.

The checks do not replace the all-n,T mathematical proofs. The lower-bound
checks use floating point; the window identities use exact rational arithmetic.
No external package, simulation, chain fitting, or network access is used.
"""

from fractions import Fraction
from itertools import product
import json
import math


def path_probability(path, stationary, refresh):
    value = stationary[path[0]]
    for previous, current in zip(path, path[1:]):
        value *= refresh * stationary[current] + (
            (1 - refresh) if previous == current else 0
        )
    return value


def missing_mass(path, stationary):
    seen = set(path)
    return sum(p for label, p in enumerate(stationary) if label not in seen)


def lower_bound_checks():
    rows = []
    for n in range(1, 5):
        for mixing_bound in (1, 2, 3, 8):
            refresh = min(1.0, 2.0 / mixing_bound)
            effective_size = 1 + (n - 1) * refresh
            cloud_size = 2 * n
            delta = 1 / (4 * math.sqrt(effective_size))
            pi0 = [0.5] + [0.5 / cloud_size] * cloud_size
            pi1 = [0.5 + delta] + [(0.5 - delta) / cloud_size] * cloud_size
            mass0 = mass1 = overlap_event = tv_conditional = 0.0
            weighted_overlap = 0.0
            min_target_gap = float("inf")
            for path in product(range(cloud_size + 1), repeat=n):
                p0 = path_probability(path, pi0, refresh)
                p1 = path_probability(path, pi1, refresh)
                mass0 += p0
                mass1 += p1
                if path[0] != 0:
                    continue
                target_gap = abs(missing_mass(path, pi0) - missing_mass(path, pi1))
                overlap_event += min(p0, p1)
                tv_conditional += 0.5 * abs(p0 / pi0[0] - p1 / pi1[0])
                weighted_overlap += min(p0, p1) * target_gap**2 / 4
                min_target_gap = min(min_target_gap, target_gap)
            asserted_bound = 1 / (1024 * effective_size)
            assert abs(mass0 - 1) < 1e-11
            assert abs(mass1 - 1) < 1e-11
            assert min_target_gap + 1e-12 >= delta / 2
            assert tv_conditional <= 0.5 + 1e-12
            assert overlap_event >= 0.25 - 1e-12
            assert weighted_overlap + 1e-12 >= asserted_bound
            assert asserted_bound + 1e-12 >= min(1, mixing_bound / n) / 3072
            rows.append({
                "n": n,
                "T": mixing_bound,
                "conditional_total_variation": tv_conditional,
                "event_overlap": overlap_event,
                "computed_overlap_lower_bound": weighted_overlap,
                "analytic_lower_bound": asserted_bound,
            })
    return rows


def window_value(path, radius):
    n = len(path)
    count = sum(
        all(path[i] != path[j] for j in range(n) if abs(j - i) >= radius)
        for i in range(n)
    )
    return Fraction(count, n)


def window_expectation_formula(n, states, refresh, radius):
    assert states >= 2 and n >= 2 * radius
    q = 1 - Fraction(1, states)
    s = 1 - refresh / states
    c = 1 - (1 - refresh) ** radius
    interior = (n - 2 * radius) * q**2 * c**2 * s ** (n - 2 * radius - 1)
    boundary = 2 * q * c * sum(s**k for k in range(n - 2 * radius, n - radius))
    return (interior + boundary) / n


def exact_window_checks():
    count = 0
    examples = []
    for n in range(2, 7):
        for states in (2, 3):
            stationary = [Fraction(1, states)] * states
            for refresh in (Fraction(1, 2), Fraction(1, 3), Fraction(1)):
                means = {radius: Fraction(0) for radius in range(1, n // 2 + 1)}
                risks = means.copy()
                missing_mean = Fraction(0)
                total_probability = Fraction(0)
                for path in product(range(states), repeat=n):
                    probability = path_probability(path, stationary, refresh)
                    target = missing_mass(path, stationary)
                    total_probability += probability
                    missing_mean += probability * target
                    for radius in means:
                        value = window_value(path, radius)
                        means[radius] += probability * value
                        risks[radius] += probability * (value - target) ** 2
                assert total_probability == 1
                assert missing_mean == (1 - Fraction(1, states)) * (
                    1 - refresh / states
                ) ** (n - 1)
                for radius, exact_mean in means.items():
                    formula_mean = window_expectation_formula(n, states, refresh, radius)
                    assert exact_mean == formula_mean
                    count += 1
                    if n == 6 and states == 3 and refresh == Fraction(1, 2):
                        examples.append({
                            "n": n,
                            "states": states,
                            "refresh": str(refresh),
                            "radius": radius,
                            "exact_missing_mean": str(missing_mean),
                            "exact_estimator_mean": str(exact_mean),
                            "exact_random_target_mse": str(risks[radius]),
                        })
    return {"identities_checked_exactly": count, "examples": examples}


def long_sample_bias_examples():
    rows = []
    for n in (100, 1000, 10000):
        states = (n + 1) // 2
        q = 1 - 1 / states
        s = 1 - 0.5 / states
        missing_mean = q * s ** (n - 1)
        for radius in (2, 4):
            c = 1 - 0.5**radius
            estimator_mean = (
                (n - 2 * radius) * q**2 * c**2 * s ** (n - 2 * radius - 1)
                + 2 * q * c * sum(s**k for k in range(n - 2 * radius, n - radius))
            ) / n
            bias = estimator_mean - missing_mean
            limit = math.exp(-1) * ((1 - 0.5**radius) ** 2 - 1)
            rows.append({
                "n": n,
                "T": 2,
                "radius": radius,
                "bias": bias,
                "bias_limit": limit,
                "mse_lower_bound_from_bias": bias**2,
            })
    return rows


if __name__ == "__main__":
    print(json.dumps({
        "status": "all finite checks passed; not a formal proof",
        "lower_bound_float_enumeration": lower_bound_checks(),
        "window_exact_rational_enumeration": exact_window_checks(),
        "window_long_sample_analytic_formula": long_sample_bias_examples(),
    }, indent=2))
