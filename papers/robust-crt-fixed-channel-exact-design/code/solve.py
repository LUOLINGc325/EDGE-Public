#!/usr/bin/env python3
"""Exact five- and six-channel common-scale robust-CRT modulus design.

Only integer arithmetic is used for objectives, pruning, and threshold tests.
The mathematical model is:

    minimize a[L-1]
    subject to 2 <= a[0] < ... < a[L-1], pairwise coprimality,
               product(a[:-1]) >= ceil(rho).

This optimizes the standard certified m/4 radius within the common-scale,
pairwise-coprime-base design family. It is not a converse for arbitrary
decoders or arbitrary non-coprime base designs.

The proved capacity-localization widths are 20 for L=5 and 39 for L=6.
The corresponding search intervals for the largest base have at most 6 and
9 integers. An anchored local maximum is deliberately distinguished from
the unrestricted maximum among all tuples ending at that integer.

Examples:
    python code/solve.py optimize --channels 5 --threshold 10000/3
    python code/solve.py capacity --channels 6 --maximum 100 --anchored
    python code/solve.py examples > results/solver_examples.json

Public Python API:
    optimize(L, R)  # R: positive int, Fraction, or exact rational string
    capacity_local(L, M, anchored=False)

No Lean source or formal-verification claim is supplied by this program.
"""

from __future__ import annotations

import argparse
from bisect import bisect_left
from fractions import Fraction
from itertools import combinations
import json
from math import comb, gcd, prod
from typing import Any


SCHEMA_VERSION = 1
ALGORITHM = "rcrt-local-exact-v1"
PARAMETERS = {
    5: {"width": 20, "scan": 6, "primes": (2, 3, 5, 7, 11)},
    6: {"width": 39, "scan": 9, "primes": (2, 3, 5, 7, 11, 13)},
}
COUNT_KEYS = (
    "graph_gcd_evaluations",
    "anchor_candidates",
    "search_nodes",
    "completed_cliques",
    "pruned_cardinality",
    "pruned_product_bound",
)


def _parameters(L: int) -> dict[str, Any]:
    if isinstance(L, bool) or not isinstance(L, int) or L not in PARAMETERS:
        raise ValueError("The certified practical solver supports L=5 or L=6.")
    return PARAMETERS[L]


def _threshold(value: int | Fraction | str) -> tuple[Fraction, int]:
    """Parse rho exactly and return rho and its integer ceiling."""
    if isinstance(value, bool) or not isinstance(value, (int, Fraction, str)):
        raise TypeError("Use an int, Fraction, or rational string; floats are rejected.")
    rho = Fraction(value)
    if rho <= 0:
        raise ValueError("The threshold must be strictly positive.")
    return rho, (rho.numerator + rho.denominator - 1) // rho.denominator


def _falling(n: int, degree: int) -> int:
    return prod(n - j for j in range(degree))


def _base_threshold(L: int, R: int) -> int:
    """Least n >= max(2,L-1) with n(n-1)...(n-L+2) >= R."""
    minimum = max(2, L - 1)
    hi = minimum
    while _falling(hi, L - 1) < R:
        hi *= 2
    lo = minimum - 1  # Sentinel: integers below minimum are excluded.
    while hi - lo > 1:
        mid = (lo + hi) // 2
        if _falling(mid, L - 1) >= R:
            hi = mid
        else:
            lo = mid
    return hi


def _zero_counts() -> dict[str, int]:
    return {key: 0 for key in COUNT_KEYS}


def _sum_counts(reports: list[dict[str, Any]]) -> dict[str, int]:
    return {
        key: sum(report["counts"][key] for report in reports)
        for key in COUNT_KEYS
    }


def capacity_local(L: int, M: int, anchored: bool = False) -> dict[str, Any]:
    """Compute an exact local capacity with a maximizing witness.

    With anchored=False, this equals the global capacity C_L(M), by the
    manuscript's localization theorem. Empty feasible sets have capacity 0.

    With anchored=True, the largest base is fixed to M and all other bases
    lie in the proved global-capacity window. The returned value is exact
    for that restricted set. It need not equal the unrestricted anchored
    maximum. At the first globally feasible M, an unrestricted capacity
    maximizer must contain M, which is what optimize() uses.

    Pruning uses only exact cardinality bounds and products of the largest
    remaining candidates, disregarding their possible mutual conflicts.
    """
    settings = _parameters(L)
    if isinstance(M, bool) or not isinstance(M, int) or M < 0:
        raise ValueError("M must be a nonnegative integer.")
    if not isinstance(anchored, bool):
        raise TypeError("anchored must be a bool.")

    width = settings["width"]
    lower = max(2, M - width)
    # Descending order provides an admissible product bound and a fixed tie rule.
    values = list(range(M, lower - 1, -1))
    n = len(values)
    counts = _zero_counts()
    best = 0
    witness: list[int] | None = None

    if n >= L:
        adjacency = [0] * n
        for i in range(n):
            for j in range(i + 1, n):
                counts["graph_gcd_evaluations"] += 1
                # The difference is at most width, even for enormous M.
                if gcd(values[i], values[i] - values[j]) == 1:
                    adjacency[i] |= 1 << j
                    adjacency[j] |= 1 << i

        full_mask = (1 << n) - 1

        def largest_product(mask: int, needed: int) -> int:
            result = 1
            for _ in range(needed):
                bit = mask & -mask
                result *= values[bit.bit_length() - 1]
                mask ^= bit
            return result

        def visit(
            mask: int,
            needed: int,
            value: int,
            chosen: tuple[int, ...],
            anchor: int,
        ) -> None:
            nonlocal best, witness
            counts["search_nodes"] += 1
            if needed == 0:
                counts["completed_cliques"] += 1
                if value > best:
                    best = value
                    witness = sorted([values[anchor]] + [values[i] for i in chosen])
                return

            while True:
                if mask.bit_count() < needed:
                    counts["pruned_cardinality"] += 1
                    return
                if value * largest_product(mask, needed) <= best:
                    counts["pruned_product_bound"] += 1
                    return
                bit = mask & -mask
                index = bit.bit_length() - 1
                mask ^= bit
                visit(
                    mask & adjacency[index],
                    needed - 1,
                    value * values[index],
                    chosen + (index,),
                    anchor,
                )

        anchors = range(1) if anchored else range(n - L + 1)
        for anchor in anchors:
            counts["anchor_candidates"] += 1
            smaller_mask = full_mask & ~((1 << (anchor + 1)) - 1)
            visit(smaller_mask & adjacency[anchor], L - 1, 1, (), anchor)

    candidate_bound = (
        comb(n - 1, L - 1) if anchored and n >= L
        else comb(n, L) if not anchored and n >= L
        else 0
    )
    return {
        "channels": L,
        "maximum": M,
        "anchored": anchored,
        "exact_scope": "anchored_local_maximum" if anchored else "global_capacity_C_L(M)",
        "window": {"lower": lower, "upper": M, "width_bound": width},
        "capacity": best,
        "witness": witness,
        "raw_candidate_bound": candidate_bound,
        "counts": counts,
        "tie_rule": "first maximizer in descending anchor/candidate order",
    }


def optimize(L: int, R: int | Fraction | str) -> dict[str, Any]:
    """Return the exact optimum and per-trial finite search certificates."""
    settings = _parameters(L)
    rho, integer_threshold = _threshold(R)
    b = _base_threshold(L, integer_threshold)
    primes = settings["primes"]
    prime_product = prod(primes[:-1])
    scan = settings["scan"]
    width = settings["width"]
    attempts: list[dict[str, Any]] = []

    answer: dict[str, Any] = {
        "schema_version": SCHEMA_VERSION,
        "algorithm": ALGORITHM,
        "channels": L,
        "input_threshold": str(rho),
        "integer_threshold": integer_threshold,
        "input_bits": rho.numerator.bit_length() + rho.denominator.bit_length(),
        "integer_threshold_bits": integer_threshold.bit_length(),
        "base_threshold_b": b,
        "scope": "common-scale pairwise-coprime bases; standard certified m/4 radius",
        "search_bounds": {
            "largest_base_lower": b + 1,
            "largest_base_upper_non_base_case": b + scan,
            "capacity_window_width": width,
            "maximum_trials_non_base_case": scan,
            "raw_candidate_bound_per_trial": comb(width, L - 1),
            "raw_candidate_bound_total_non_base_case": scan * comb(width, L - 1),
        },
    }

    if integer_threshold <= prime_product:
        answer.update({
            "method": "prime-divisor-count-base-case",
            "largest_base": primes[-1],
            "bases": list(primes),
            "product_smallest": prime_product,
            "minimality_certificate": {
                "kind": "distinct_prime_divisors",
                "primes_below_largest_base": list(primes[:-1]),
                "required_distinct_primes": L,
                "available_distinct_primes_below_largest_base": L - 1,
            },
            "attempts": attempts,
            "counts": _zero_counts(),
        })
        return answer

    for maximum in range(b + 1, b + scan + 1):
        certificate = capacity_local(L, maximum, anchored=True)
        certificate["threshold_met"] = certificate["capacity"] >= integer_threshold
        attempts.append(certificate)
        if certificate["threshold_met"]:
            answer.update({
                "method": "bounded-local-exact-search",
                "largest_base": maximum,
                "bases": certificate["witness"],
                "product_smallest": certificate["capacity"],
                "minimality_certificate": {
                    "kind": "first-feasible-localized-capacity-threshold",
                    "lower_bound": b + 1,
                    "failed_trial_maxima": [item["maximum"] for item in attempts[:-1]],
                    "reason_anchoring_suffices": (
                        "At a first globally feasible maximum, a capacity maximizer "
                        "must include that maximum and lies in the proved window."
                    ),
                },
                "attempts": attempts,
                "counts": _sum_counts(attempts),
            })
            return answer
    raise AssertionError("No feasible tuple in the mathematically certified search interval.")


def _brute_capacities(L: int, maximum: int) -> tuple[list[int], dict[str, int]]:
    """Independent bounded check: enumerate every tuple without localization.

    This verifier shares no graph search, clique pruning, or product bound
    with capacity_local(). It is a finite implementation check, not an
    all-range proof.
    """
    by_anchor = [0] * (maximum + 1)
    examined = 0
    coprime = 0
    for bases in combinations(range(2, maximum + 1), L):
        examined += 1
        if any(gcd(bases[i], bases[j]) != 1 for i in range(L) for j in range(i)):
            continue
        coprime += 1
        value = prod(bases[:-1])
        by_anchor[bases[-1]] = max(by_anchor[bases[-1]], value)
    capacities: list[int] = []
    running = 0
    for value in by_anchor:
        running = max(running, value)
        capacities.append(running)
    return capacities, {"tuples_enumerated": examined, "pairwise_coprime_tuples": coprime}


def _check_answer(answer: dict[str, Any]) -> None:
    bases = answer["bases"]
    assert len(bases) == answer["channels"]
    assert bases == sorted(set(bases)) and bases[0] >= 2
    assert all(gcd(a, b) == 1 for a, b in combinations(bases, 2))
    assert bases[-1] == answer["largest_base"]
    assert prod(bases[:-1]) == answer["product_smallest"]
    assert answer["product_smallest"] >= answer["integer_threshold"]


def build_example_report() -> dict[str, Any]:
    """Reproduce the checked finite ranges and the fixed large-input examples."""
    finite_checks = []
    for L, maximum in ((5, 35), (6, 30)):
        brute, counts = _brute_capacities(L, maximum)
        for M in range(maximum + 1):
            local = capacity_local(L, M)
            assert local["capacity"] == brute[M], (L, M, local, brute[M])
        thresholds = {1}
        for value in brute:
            if value > 0:
                thresholds.add(value)
                if value + 1 <= brute[-1]:
                    thresholds.add(value + 1)
        for threshold in sorted(thresholds):
            answer = optimize(L, threshold)
            _check_answer(answer)
            expected = bisect_left(brute, threshold)
            assert answer["largest_base"] == expected, (L, threshold, answer, expected)
        finite_checks.append({
            "channels": L,
            "maximum_range": [0, maximum],
            **counts,
            "capacity_comparisons": maximum + 1,
            "threshold_comparisons": len(thresholds),
            "capacities": brute,
            "all_equal": True,
        })

    edge_inputs: tuple[int | Fraction | str, ...] = (1, Fraction(1, 2), "10000/3")
    edges = []
    for L in (5, 6):
        base = prod(PARAMETERS[L]["primes"][:-1])
        for value in edge_inputs + (base, base + 1, Fraction(2 * base + 1, 2)):
            answer = optimize(L, value)
            _check_answer(answer)
            edges.append(answer)

    examples = []
    for L in (5, 6):
        for exponent in (4, 8, 20, 100, 500):
            answer = optimize(L, 10 ** exponent)
            _check_answer(answer)
            examples.append({"input_description": f"10^{exponent}", **answer})

    return {
        "schema_version": SCHEMA_VERSION,
        "algorithm": ALGORITHM,
        "reproduce": "python code/solve.py examples > results/solver_examples.json",
        "verification_scope": (
            "Unlocalized all-tuple enumeration on the stated finite ranges; "
            "boundary inversion checks and exact large-integer examples. "
            "These checks validate the implementation on those inputs; "
            "all-range correctness relies on the manuscript's analytic proofs."
        ),
        "finite_checks": finite_checks,
        "edge_cases": edges,
        "large_and_ordinary_examples": examples,
        "timing_note": "No hardware-independent timing or universal performance claim is made.",
        "formalization": "No Lean code or kernel verification in this delivery.",
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    subparsers = parser.add_subparsers(dest="command", required=True)
    design = subparsers.add_parser("optimize", help="Optimize an exact rational threshold.")
    design.add_argument("--channels", type=int, choices=sorted(PARAMETERS), required=True)
    design.add_argument("--threshold", required=True)
    cap = subparsers.add_parser("capacity", help="Compute a capacity and witness.")
    cap.add_argument("--channels", type=int, choices=sorted(PARAMETERS), required=True)
    cap.add_argument("--maximum", type=int, required=True)
    cap.add_argument("--anchored", action="store_true")
    subparsers.add_parser("examples", help="Run bounded checks and print the reproducibility report.")
    arguments = parser.parse_args()
    if arguments.command == "optimize":
        result = optimize(arguments.channels, arguments.threshold)
    elif arguments.command == "capacity":
        result = capacity_local(arguments.channels, arguments.maximum, arguments.anchored)
    else:
        result = build_example_report()
    print(json.dumps(result, indent=2, sort_keys=True, ensure_ascii=False))


if __name__ == "__main__":
    main()
