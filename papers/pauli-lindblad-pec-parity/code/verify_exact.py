"""Deterministic exact certificates; run from any working directory.

Uses independent subset expansion and Fourier inversion to challenge the
convolution implementation, all simple labelled graphs through five vertices,
all nonempty distinct-generator families in GF(2)^3, and overlapping odd cycles.
These are finite checks, not substitutes for the general written proofs.
"""
from fractions import Fraction as Q
from itertools import combinations
from pathlib import Path
from math import comb, factorial, prod
import hashlib
import json
import sys

from pec_exact import (cost, inverse_coefficients, even_odd_masses, graph_labels,
                       is_bipartite, odd_cycle_cost, odd_dependency,
                       parity_functional, rank, weak_leading_term, weighted_maxcut)

ROOT = Path(__file__).resolve().parents[1]


def fourier_coefficients(labels, z):
    """Independent ambient Walsh inversion; no convolution or rank routine."""
    dimension = max(labels, default=0).bit_length()
    size = 1 << dimension
    eigenvalues = [prod(Q(x) for v, x in zip(labels, z)
                        if (character & v).bit_count() % 2)
                  for character in range(size)]
    result = {}
    for g in range(size):
        value = sum(((-1 if (character & g).bit_count() % 2 else 1) * eigenvalue
                     for character, eigenvalue in enumerate(eigenvalues)), Q(0)) / size
        if value:
            result[g] = value
    return result


def direct_subset_coefficients(labels, z):
    result = {}
    for subset in range(1 << len(labels)):
        syndrome = 0
        weight = Q(1)
        for j, (v, x) in enumerate(zip(labels, z)):
            if (subset >> j) & 1:
                syndrome ^= v
                weight *= (1 - Q(x)) / 2
            else:
                weight *= (1 + Q(x)) / 2
        result[syndrome] = result.get(syndrome, Q(0)) + weight
    return {g: value for g, value in result.items() if value}


def series_product(left, right, degree):
    return [sum((left[i] * right[d - i] for i in range(d + 1)), Q(0))
            for d in range(degree + 1)]


def direct_gap_series(labels, rates, degree):
    """Taylor expansion of every subset weight; select each coefficient's
    sign by its first nonzero Taylor coefficient. Independent of odd-girth
    reasoning. This determines the analytic germ of the exact l1 cost.
    """
    terms = {}
    for subset in range(1 << len(labels)):
        syndrome, sign = 0, (-1) ** subset.bit_count()
        polynomial = [Q(1)] + [Q(0)] * degree
        for j, (v, w) in enumerate(zip(labels, rates)):
            active = (subset >> j) & 1
            if active:
                syndrome ^= v
            factor = [Q(0) if active else Q(1)]
            factor += [Q((2 * w) ** d, 2 * factorial(d)) for d in range(1, degree + 1)]
            polynomial = series_product(polynomial, factor, degree)
        old = terms.setdefault(syndrome, [Q(0)] * (degree + 1))
        for d in range(degree + 1):
            old[d] += sign * polynomial[d]
    optimal = [Q(0)] * (degree + 1)
    for polynomial in terms.values():
        first = next((x for x in polynomial if x), Q(0))
        sign = 1 if first > 0 else -1 if first < 0 else 0
        for d, value in enumerate(polynomial):
            optimal[d] += sign * value
    total_rate = sum(rates)
    factorized = [Q((2 * total_rate) ** d, factorial(d)) for d in range(degree + 1)]
    return [a - b for a, b in zip(factorized, optimal)]


def audit_instance(labels, z, direct=False):
    coeff = {g: c for g, c in inverse_coefficients(labels, z).items() if c}
    assert coeff == fourier_coefficients(labels, z)
    if direct:
        assert coeff == direct_subset_coefficients(labels, z)
    gamma = sum(map(abs, coeff.values()), Q(0))
    factorized = prod(map(Q, z))
    masses = even_odd_masses(labels, z)
    gap = 2 * sum((min(p, m) for p, m in masses.values()), Q(0))
    assert factorized - gamma == gap
    assert (gamma == factorized) == parity_functional(labels)
    assert (odd_dependency(labels) is None) == parity_functional(labels)
    return gamma


def main():
    family_count = 0
    for family in range(1, 1 << 7):
        labels = tuple(j + 1 for j in range(7) if (family >> j) & 1)
        for z in ([Q(3, 2)] * len(labels), [Q(3 + j, 2) for j in range(len(labels))]):
            audit_instance(labels, z, direct=True)
            family_count += 1
    graph_count, recovery_count, approximation_recovery_count = 0, 0, 0
    for n in range(1, 6):
        potential = tuple(combinations(range(n), 2))
        for edge_mask in range(1 << len(potential)):
            edges = tuple(e for j, e in enumerate(potential) if (edge_mask >> j) & 1)
            labels = graph_labels(n, edges)
            z = [Q(2 + j % 3) for j in range(len(edges))]
            gamma = audit_instance(labels, z)
            assert (gamma == prod(z)) == is_bipartite(n, edges)
            graph_count += 1
            # Exact rational finite-parameter MaxCut reduction, no log calls.
            base = 1 << (n + 2)
            scaled = cost(labels, [base] * len(edges))
            maximum = int(weighted_maxcut(n, edges))
            assert base ** maximum <= scaled < base ** (maximum + 1)
            assert scaled ** 2 <= (1 << rank(labels)) * base ** (2 * maximum)
            recovered = 0
            while base ** (recovered + 1) <= scaled:
                recovered += 1
            assert recovered == maximum
            recovery_count += 1
            # The proof allows any gamma_hat in [gamma/2, 2*gamma].
            # Checking both interval endpoints also checks every interior
            # value by monotonicity of the two exact threshold comparisons.
            for estimate in (scaled / 2, 2 * scaled):
                threshold_value = 2 * estimate
                assert base ** maximum <= threshold_value < base ** (maximum + 1)
                recovered_approx = 0
                while base ** (recovered_approx + 1) <= threshold_value:
                    recovered_approx += 1
                assert recovered_approx == maximum
                approximation_recovery_count += 1

    named = {
        "triangle": (3, [(0, 1), (0, 2), (1, 2)], 2, Q(6)),
        "square": (4, [(0, 1), (1, 2), (2, 3), (0, 3)], None, Q(0)),
        "five_cycle": (5, [(0, 1), (1, 2), (2, 3), (3, 4), (0, 4)], 3, Q(20)),
        "theta_3_2_2": (6, [(0, 1), (1, 2), (2, 5), (0, 3), (3, 5), (0, 4), (4, 5)], 3, Q(38)),
    }
    examples = {}
    for name, (n, edges, expected_order, expected_coefficient) in named.items():
        labels = graph_labels(n, edges)
        weak = weak_leading_term(labels)
        assert weak['order'] == expected_order
        assert weak['coefficient'] == expected_coefficient
        expansion = direct_gap_series(labels, [1] * len(labels), 5)
        leading = next(((d, c) for d, c in enumerate(expansion) if c), (None, Q(0)))
        assert leading == (expected_order, expected_coefficient)
        for rates in ([1 + j % 3 for j in range(len(labels))],):
            weighted = weak_leading_term(labels, rates)
            weighted_expansion = direct_gap_series(labels, rates, 5)
            leading_weighted = next(((d, c) for d, c in enumerate(weighted_expansion) if c), (None, Q(0)))
            assert leading_weighted == (weighted['order'], weighted['coefficient'])
        examples[name] = {
            "vertices": n, "edges": edges, "odd_girth": weak['odd_girth'],
            "first_order": weak['order'], "leading_coefficient": str(weak['coefficient']),
            "distinct_leading_subsets": len(weak['subsets']),
            "gap_taylor_coefficients_through_5": list(map(str, expansion)),
            "gamma_at_z_2": str(cost(labels, [2] * len(labels))),
            "factorized_at_z_2": str(2 ** len(labels)),
            "max_cut": str(weighted_maxcut(n, edges)),
        }
    cycle_checks = 0
    for length in (3, 5, 7, 9):
        edges = [(j, j + 1) for j in range(length - 1)] + [(0, length - 1)]
        labels = graph_labels(length, edges)
        for z in (Q(101, 100), Q(3, 2), Q(2), Q(7)):
            assert cost(labels, [z] * length) == odd_cycle_cost(length, z)
            cycle_checks += 1
    # Noncommuting one-qubit labels X, Z, Y have exactly the same binary circuit.
    assert cost([1, 2, 3], [2, 2, 2]) == Q(11, 2)
    results = {
        "status": "passed", "arithmetic": "Python fractions.Fraction; exact integers/rationals",
        "all_GF2_3_nonempty_families_two_parameter_sets": family_count,
        "all_simple_labelled_graphs_n_1_through_5": graph_count,
        "finite_parameter_maxcut_recoveries": recovery_count,
        "factor_two_approximation_endpoint_recoveries": approximation_recovery_count,
        "maxcut_recovery_base": "Q=2^(n+2), matching the manuscript rational-channel reduction",
        "odd_cycle_closed_formula_checks": cycle_checks,
        "three_way_coefficient_checks": "convolution vs ambient Walsh vs direct subsets (254 instances)",
        "examples": examples,
        "scope": "Finite certificates only. General theorem relies on the written proof.",
        "python": sys.version.split()[0],
    }
    out = ROOT / 'results' / 'exact_certificate.json'
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(results, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps({k: v for k, v in results.items() if k != 'examples'}, indent=2))
    print("theta_3_2_2 coefficient: 38, not the double-counted value 40")


if __name__ == '__main__':
    main()
