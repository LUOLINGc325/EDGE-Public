#!/usr/bin/env python3
"""Exact rational checks of finite examples, with rigorous Poisson enclosures.

Python standard library only. These are finite certificates, not a proof of the
universal theorem. Exponentials are enclosed by a positive Taylor series and an
explicit geometric remainder; no floating-point arithmetic is used in checks.
"""
from __future__ import annotations

from fractions import Fraction as Q
from itertools import product, permutations
from math import factorial
from pathlib import Path
import json
import platform

ROOT = Path(__file__).resolve().parents[1]
TERMS = 192


def convolution(parameters):
    masses = [Q(1)]
    for p in parameters:
        new = [Q(0)] * (len(masses) + 1)
        for j, value in enumerate(masses):
            new[j] += value * (1 - p)
            new[j + 1] += value * p
        masses = new
    return masses


def exp_minus_bounds(x, terms=TERMS):
    assert x >= 0
    total = term = Q(1)
    for j in range(1, terms + 1):
        term *= x / j
        total += term
    next_term = term * x / (terms + 1)
    ratio = x / (terms + 2)
    assert ratio < 1
    # Positive exp(x) series: all omitted ratios are at most this ratio.
    upper = total + next_term / (1 - ratio)
    return 1 / upper, 1 / total


def poisson_bounds(x, k, terms=TERMS):
    if x == 0:
        return {"beta": (Q(0), Q(0)), "u": (Q(0), Q(0)),
                "a": (Q(1), Q(1))}
    elo, ehi = exp_minus_bounds(x, terms)
    coefficients = [x ** j / factorial(j) for j in range(k)]
    tail_poly = sum(coefficients, Q(0))
    deficit_poly = sum((k - j) * c for j, c in enumerate(coefficients)) / k
    beta = (1 - ehi * tail_poly, 1 - elo * tail_poly)
    u = (1 - ehi * deficit_poly, 1 - elo * deficit_poly)
    a = (Q(k) / x * u[0], Q(k) / x * u[1])
    return {"beta": beta, "u": u, "a": a}


def inverse_bracket(beta, k, bits=44):
    assert 0 < beta < 1
    low, high = Q(0), Q(max(2, 2 * k))
    while poisson_bounds(high, k)["beta"][0] <= beta:
        high *= 2
        assert high < TERMS
    for _ in range(bits):
        mid = (low + high) / 2
        lower, upper = poisson_bounds(mid, k)["beta"]
        if upper < beta:
            low = mid
        elif lower > beta:
            high = mid
        else:
            lower, upper = poisson_bounds(mid, k, TERMS * 2)["beta"]
            if upper < beta:
                low = mid
            elif lower > beta:
                high = mid
            else:
                raise ArithmeticError("Taylor enclosure insufficient")
    assert poisson_bounds(low, k)["beta"][1] < beta
    assert poisson_bounds(high, k)["beta"][0] > beta
    return low, high


def cdf_bounds(x, j):
    elo, ehi = exp_minus_bounds(x)
    polynomial = sum((x ** i / factorial(i) for i in range(j + 1)), Q(0))
    return elo * polynomial, ehi * polynomial


def decimal_lower(value, digits=22, upper=False):
    scale = 10 ** digits
    if upper:
        integer = -((-value.numerator * scale) // value.denominator)
    else:
        integer = value.numerator * scale // value.denominator
    sign = "-" if integer < 0 else ""
    integer = abs(integer)
    return f"{sign}{integer // scale}.{integer % scale:0{digits}d}"


def exact_probability_cases():
    families = [
        [Q(1, 4)],
        [Q(1, 2), Q(1, 2)],
        [Q(1, 7), Q(2, 7), Q(5, 7)],
        [Q(0), Q(1, 3), Q(2, 3), Q(1)],
        [Q(1), Q(1), Q(1, 5), Q(2, 5), Q(4, 5), Q(0)],
        [Q(1, 1000), Q(1, 3), Q(997, 1000), Q(2, 7), Q(1, 9), Q(8, 9)],
        [Q(1, 10)] * 8,
        [Q(1, 2)] * 8,
        [Q(9, 10)] * 8,
        [Q(1, 100), Q(1, 5), Q(2, 5), Q(3, 5),
         Q(4, 5), Q(99, 100), Q(0), Q(1)],
    ]
    results = []
    for parameters in families:
        masses = convolution(parameters)
        assert sum(masses) == 1 and min(masses) >= 0
        scaled = [factorial(j) * p for j, p in enumerate(masses)]
        assert all(scaled[j] ** 2 >= scaled[j - 1] * scaled[j + 1]
                   for j in range(1, len(scaled) - 1))
        for k in range(1, min(5, len(parameters)) + 1):
            beta = sum(masses[k:], Q(0))
            if not 0 < beta < 1:
                continue
            low, high = inverse_bracket(beta, k)
            utilization = sum(p * min(Q(j, k), Q(1))
                              for j, p in enumerate(masses))
            acceptance = sum(p * min(Q(k, j + 1), Q(1))
                             for j, p in enumerate(masses))
            upper_u = poisson_bounds(high, k)["u"][1]
            upper_a = poisson_bounds(low, k)["a"][1]
            if k == 1:
                assert utilization == beta
                u_result = "exact equality by the stockout constraint"
            else:
                assert utilization > upper_u
                u_result = decimal_lower(utilization - upper_u)
            assert acceptance > upper_a
            prefix = Q(0)
            margins = []
            for j, mass in enumerate(masses):
                prefix += mass
                if j < k - 1:
                    gap = cdf_bounds(high, j)[0] - prefix
                    assert gap > 0
                    margins.append(gap)
                elif j > k - 1:
                    gap = prefix - cdf_bounds(low, j)[1]
                    assert gap > 0
                    margins.append(gap)
                else:
                    assert prefix == 1 - beta
            results.append({
                "bernoulli_parameters": [str(p) for p in parameters],
                "k": k, "stockout_exact": str(beta),
                "lambda_interval_exact": [str(low), str(high)],
                "lambda_interval_decimal": [decimal_lower(low),
                                            decimal_lower(high, upper=True)],
                "utilization_exact": str(utilization),
                "acceptance_exact": str(acceptance),
                "utilization_gap_certified_lower": u_result,
                "acceptance_gap_certified_lower": decimal_lower(acceptance - upper_a),
                "minimum_off_cut_cdf_gap_certified_lower":
                    decimal_lower(min(margins)) if margins else "no off-cut index",
                "all_checks": "passed",
            })
    return results


def explicit_order_reward(distributions, k, threshold, tie):
    n = len(distributions)
    orders = list(permutations(range(n)))
    reward = Q(0)
    offline = Q(0)
    outcomes_count = 0
    for outcomes in product(*distributions):
        values = [row[0] for row in outcomes]
        value_probability = Q(1)
        for _, probability in outcomes:
            value_probability *= probability
        offline += value_probability * sum(sorted(values, reverse=True)[:k])
        options = []
        for value in values:
            if value > threshold:
                options.append([(True, Q(1))])
            elif value < threshold:
                options.append([(False, Q(1))])
            else:
                options.append([(True, tie), (False, 1 - tie)])
        for coin_outcomes in product(*options):
            probability = value_probability / len(orders)
            for _, coin_probability in coin_outcomes:
                probability *= coin_probability
            for order in orders:
                selected = []
                for i in order:
                    if coin_outcomes[i][0] and len(selected) < k:
                        selected.append(i)
                reward += probability * sum(values[i] for i in selected)
                outcomes_count += 1
    return reward, offline, outcomes_count


def exact_bridge_cases():
    distributions = [
        [(0, Q(1, 4)), (1, Q(1, 2)), (3, Q(1, 4))],
        [(0, Q(1, 5)), (1, Q(1, 5)), (7, Q(3, 5))],
        [(1, Q(3, 7)), (2, Q(4, 7))],
        [(0, Q(2, 3)), (1, Q(1, 3))],
    ]
    threshold, tie = Q(1), Q(2, 5)
    parameters = [sum(probability * (Q(1) if value > threshold else
                                    tie if value == threshold else Q(0))
                      for value, probability in law) for law in distributions]
    masses = convolution(parameters)
    rows = []
    for k in (1, 2, 3, 4):
        reward, offline, count = explicit_order_reward(
            distributions, k, threshold, tie)
        u = sum(m * min(Q(j, k), Q(1)) for j, m in enumerate(masses))
        a = sum(m * min(Q(k, j + 1), Q(1)) for j, m in enumerate(masses))
        formula = threshold * k * u
        for i, law in enumerate(distributions):
            surplus = sum(p * max(Q(v) - threshold, Q(0)) for v, p in law)
            others = convolution(parameters[:i] + parameters[i + 1:])
            rate = sum(m * min(Q(k, j + 1), Q(1)) for j, m in enumerate(others))
            formula += surplus * rate
        assert reward == formula
        # Independent exact ex-ante optimizer: fill mass in descending value order.
        atoms = sorted((Q(v), p) for law in distributions for v, p in law)
        capacity, lp = Q(k), Q(0)
        for value, mass in reversed(atoms):
            selected_mass = min(capacity, mass)
            lp += value * selected_mass
            capacity -= selected_mass
        assert capacity == 0
        assert offline <= lp and reward >= min(u, a) * lp
        rows.append({"k": k, "enumerated_outcomes_including_orders": count,
                     "direct_reward": str(reward), "bridge_reward": str(formula),
                     "offline": str(offline), "ex_ante_lp": str(lp),
                     "utilization": str(u), "acceptance": str(a),
                     "all_checks": "passed"})
    return rows


def main():
    probability = exact_probability_cases()
    bridge = exact_bridge_cases()
    output = {
        "status": "passed", "arithmetic": "fractions.Fraction exact rational",
        "exponential_enclosure": {
            "method": "positive exp(x) Taylor sum plus geometric remainder, then reciprocal",
            "terms": TERMS, "inverse_bracket_bisections": 44},
        "probability_cases": len(probability), "bridge_cases": len(bridge),
        "scope": "finite numerical certificates; not a universal theorem",
        "python": platform.python_version(),
        "probability": probability, "online_bridge": bridge}
    (ROOT / "results").mkdir(exist_ok=True)
    path = ROOT / "results" / "exact_certificates.json"
    path.write_text(json.dumps(output, indent=2) + "\n")
    print(json.dumps({k: output[k] for k in
                      ("status", "probability_cases", "bridge_cases", "arithmetic")},
                     indent=2))


if __name__ == "__main__":
    main()
