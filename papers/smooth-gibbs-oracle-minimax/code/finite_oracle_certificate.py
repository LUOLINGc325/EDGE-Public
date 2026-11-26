#!/usr/bin/env python3
"""Exact arithmetic certificates for the finite oracle argument.

These checks verify finite identities and instances, not the continuum minimax
theorems. No floating-point tolerance is used. The underlying polynomial method
and reciprocal-difference identity are classical tools.
"""
from __future__ import annotations

import argparse
from fractions import Fraction as Q
from itertools import product
from math import comb, factorial
from pathlib import Path
import json
import random


def difference_sum(order: int, base: Q, step: Q) -> Q:
    return sum(((-1) ** j * Q(comb(order, j), 1) / (base + j * step)
                for j in range(order + 1)), Q(0))


def difference_product(order: int, base: Q, step: Q) -> Q:
    denominator = Q(1)
    for j in range(order + 1):
        denominator *= base + j * step
    return Q(factorial(order)) * step ** order / denominator


def parity(mask: int) -> int:
    return (-1) ** mask.bit_count()


def all_boolean_functions_at_depth(bits: int, depth: int) -> set[int]:
    """Enumerate semantic truth tables of all trees for a small exact check."""
    full = (1 << (1 << bits)) - 1
    tables = {0, full}
    query_masks = [sum(1 << x for x in range(1 << bits) if (x >> j) & 1)
                   for j in range(bits)]
    for _ in range(depth):
        new = set(tables)
        for q in query_masks:
            zero_sides = {t & (full ^ q) for t in tables}
            one_sides = {t & q for t in tables}
            new.update(left | right for left in zero_sides for right in one_sides)
        tables = new
    return tables


def random_tree(rng: random.Random, bits: int, depth: int):
    if depth == 0 or rng.randrange(7) == 0:
        return Q(rng.randrange(5), 4)
    return (rng.randrange(bits), random_tree(rng, bits, depth - 1),
            random_tree(rng, bits, depth - 1))


def tree_value(tree, assignment: int) -> Q:
    while isinstance(tree, tuple):
        j, left, right = tree
        tree = right if (assignment >> j) & 1 else left
    return tree


def one_event_matching_witness(bits: int, step: Q, volume: Q = Q(1, 2)):
    """Certified sharp example for one EVENT of a finite Boolean oracle.

    Query bits-1 coordinates uniformly without replacement. A_j is the
    probability of the event when j queried bits equal one. This is only an
    event-probability approximation problem, not a complete Gibbs sampler.
    """
    alpha = volume * difference_product(bits, Q(1), step) / 2 ** bits
    target = [volume / (1 + step * j) for j in range(bits + 1)]
    approx = [target[j] - alpha * (-1) ** j for j in range(bits + 1)]
    coefficients = [approx[0]]
    for j in range(1, bits):
        coefficients.append((bits * approx[j] - j * coefficients[-1]) / (bits - j))
    assert coefficients[-1] == approx[-1]
    assert all(0 <= c <= 1 for c in coefficients)
    for j in range(bits + 1):
        output = Q(0)
        if j < bits:
            output += Q(bits - j, bits) * coefficients[j]
        if j > 0:
            output += Q(j, bits) * coefficients[j - 1]
        assert output == approx[j]
        assert abs(output - target[j]) == alpha
    return {"bits": bits, "query_budget": bits - 1, "step": str(step),
            "event_volume": str(volume), "exact_minimax_event_error": str(alpha),
            "event_output_probabilities": list(map(str, coefficients)),
            "scope": "single-event finite-bit oracle only"}


def run():
    identities = []
    for order, base, step in product(range(26), [Q(1), Q(2, 3), Q(7, 2)],
                                     [Q(1, 100), Q(1, 7), Q(3, 2)]):
        direct = difference_sum(order, base, step)
        closed = difference_product(order, base, step)
        assert direct == closed > 0
        identities.append((order, base, step))

    enumerated = []
    for bits, depth in [(2, 1), (3, 2)]:
        tables = all_boolean_functions_at_depth(bits, depth)
        for table in tables:
            coefficient = sum(parity(x) * ((table >> x) & 1)
                              for x in range(1 << bits))
            assert coefficient == 0
        enumerated.append({"bits": bits, "depth": depth,
                           "distinct_truth_tables": len(tables),
                           "all_top_parity_coefficients_zero": True})

    rng = random.Random(20261125)
    random_checks = 0
    for bits in range(2, 9):
        for _ in range(16):
            tree = random_tree(rng, bits, bits - 1)
            coefficient = sum((parity(x) * tree_value(tree, x)
                               for x in range(1 << bits)), Q(0))
            assert coefficient == 0
            random_checks += 1

    walsh_checks = 0
    for bits in range(1, 11):
        step, volume = Q(1, 3 * bits), Q(1, 2)
        coefficient = sum((parity(x) * volume / (1 + step * x.bit_count())
                           for x in range(1 << bits)), Q(0)) / 2 ** bits
        assert coefficient == volume * difference_product(bits, Q(1), step) / 2 ** bits
        assert coefficient > 0
        walsh_checks += 1

    matching = [one_event_matching_witness(bits, Q(1, divisor * bits))
                for bits in range(2, 11) for divisor in [2, 10]]
    return {"schema": "smooth-gibbs-finite-certificates-v1", "status": "passed",
            "arithmetic": "fractions.Fraction; exact rational arithmetic",
            "seed": 20261125, "reciprocal_identity_checks": len(identities),
            "exhaustive_tree_checks": enumerated,
            "adaptive_rational_leaf_tree_checks": random_checks,
            "direct_boolean_cube_walsh_checks": walsh_checks,
            "matching_finite_event_witnesses": matching,
            "limitations": ["No finite experiment proves the all-n theorem.",
                            "No check here formalizes C^m smoothness or arbitrary measurable random seeds.",
                            "Single-event optimality is not full-law TV optimality.",
                            "No assertion that the frozen all-temperature target is solved."]}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1]
                        / "results/finite_oracle_certificates.json")
    args = parser.parse_args()
    result = run()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps({"status": result["status"],
                      "reciprocal_identity_checks": result["reciprocal_identity_checks"],
                      "exhaustive_tree_checks": result["exhaustive_tree_checks"],
                      "random_tree_checks": result["adaptive_rational_leaf_tree_checks"],
                      "matching_event_witnesses": len(result["matching_finite_event_witnesses"])}))
