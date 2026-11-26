#!/usr/bin/env python3
"""Independent exact finite audit for robust-CRT modulus optimization.

The reference enumerates the entire interval [2, M_max], not the author's
localized search. This is a finite mathematical/computational audit, not Lean
verification and not a proof of any unbounded theorem.
"""

from __future__ import annotations

import argparse
from bisect import bisect_left
from datetime import datetime, timezone
from hashlib import sha256
from itertools import combinations
import json
from math import comb, gcd, prod
from pathlib import Path
import platform
from time import perf_counter


def polynomial_product(offsets: tuple[int, ...]) -> list[int]:
    """Coefficients, low-to-high, of product(X-offset)."""
    out = [1]
    for offset in offsets:
        nxt = [0] * (len(out) + 1)
        for degree, value in enumerate(out):
            nxt[degree] -= offset * value
            nxt[degree + 1] += value
        out = nxt
    return out


def difference(a: list[int], b: list[int]) -> list[int]:
    out = [0] * max(len(a), len(b))
    for i, x in enumerate(a):
        out[i] += x
    for i, x in enumerate(b):
        out[i] -= x
    while len(out) > 1 and out[-1] == 0:
        out.pop()
    return out


def shift_variable(coefficients: list[int], shift: int) -> list[int]:
    """Compute coefficients of p(t+shift) by the binomial identity."""
    out = [0] * len(coefficients)
    for old_degree, coefficient in enumerate(coefficients):
        for new_degree in range(old_degree + 1):
            out[new_degree] += (
                coefficient * comb(old_degree, new_degree)
                * shift ** (old_degree - new_degree)
            )
    return out


def polynomial_audit() -> dict:
    delta5 = difference(
        polynomial_product((9, 7, 6, 5)),
        polynomial_product((21, 3, 2, 1)),
    )
    assert delta5 == [1764, -936, 132]
    discriminant5 = delta5[1] ** 2 - 4 * delta5[2] * delta5[0]
    assert delta5[2] > 0 and discriminant5 == -55296
    delta6 = difference(
        polynomial_product((13, 11, 10, 9, 7)),
        polynomial_product((40, 4, 3, 2, 1)),
    )
    delta6_shifted = shift_variable(delta6, 13)
    assert delta6_shifted == [320760, 111870, 13395, 555]
    assert all(coefficient > 0 for coefficient in delta6_shifted)
    return {
        "status": "pass_exact_integer_polynomial_identities",
        "method": "independent coefficient convolution and binomial translation; no symbolic library and no author-generated coefficients read at runtime",
        "five_base_difference_coefficients_low_to_high": delta5,
        "five_base_discriminant": discriminant5,
        "six_base_difference_coefficients_low_to_high": delta6,
        "six_base_difference_after_M_equals_t_plus_13": delta6_shifted,
    }


def pairwise_coprime(values: tuple[int, ...]) -> bool:
    return all(gcd(a, b) == 1 for a, b in combinations(values, 2))


def exhaustive_capacity(channel_count: int, maximum_budget: int, width: int) -> dict:
    start = perf_counter()
    best_exact = [0] * (maximum_budget + 1)
    witness_exact: list[tuple[int, ...] | None] = [None] * (maximum_budget + 1)
    min_first_exact: list[int | None] = [None] * (maximum_budget + 1)
    count_best_exact = [0] * (maximum_budget + 1)
    checked = 0
    feasible = 0
    for values in combinations(range(2, maximum_budget + 1), channel_count):
        checked += 1
        if not pairwise_coprime(values):
            continue
        feasible += 1
        value = prod(values[:-1])
        last = values[-1]
        if value > best_exact[last]:
            best_exact[last] = value
            witness_exact[last] = values
            min_first_exact[last] = values[0]
            count_best_exact[last] = 1
        elif value == best_exact[last]:
            assert min_first_exact[last] is not None
            min_first_exact[last] = min(min_first_exact[last], values[0])
            count_best_exact[last] += 1
    assert checked == comb(maximum_budget - 1, channel_count)

    rows = []
    running_value = 0
    running_witness: tuple[int, ...] | None = None
    running_min_first: int | None = None
    running_count = 0
    previous_value = 0
    threshold_queries: list[dict] = []
    for budget in range(2, maximum_budget + 1):
        candidate = best_exact[budget]
        if candidate > running_value:
            running_value = candidate
            running_witness = witness_exact[budget]
            running_min_first = min_first_exact[budget]
            running_count = count_best_exact[budget]
        elif candidate > 0 and candidate == running_value:
            assert running_min_first is not None and min_first_exact[budget] is not None
            running_min_first = min(running_min_first, min_first_exact[budget])
            running_count += count_best_exact[budget]
        if running_value > 0:
            assert running_witness is not None and running_min_first is not None
            assert running_min_first >= budget - width
            assert running_witness[-1] <= budget
            assert pairwise_coprime(running_witness)
            assert prod(running_witness[:-1]) == running_value
        row = {
            "M": budget,
            "capacity": running_value,
            "witness": list(running_witness) if running_witness else None,
            "smallest_first_coordinate_among_all_capacity_maximizers": running_min_first,
            "capacity_maximizer_count": running_count,
        }
        rows.append(row)
        if running_value > previous_value:
            for threshold in sorted({previous_value + 1, running_value,
                                     (previous_value + 1 + running_value) // 2}):
                threshold_queries.append({"R": threshold, "optimal_maximum": budget})
        previous_value = running_value
    return {
        "L": channel_count,
        "M_min": 2,
        "M_max": maximum_budget,
        "all_tuples_tested": checked,
        "pairwise_coprime_tuples": feasible,
        "reference_method": "Enumerate every L-subset of [2,M_max]; group by its actual maximum; take cumulative product maxima. No localization, pattern templates, residue classes, root bounds or author solver are used.",
        "localization_check": {
            "width": width,
            "status": "pass_for_every_capacity_maximizer_in_finite_domain",
            "scope_limit": "Only the listed finite budgets; not an unbounded localization proof.",
        },
        "elapsed_seconds": perf_counter() - start,
        "capacity_table": rows,
        "inverse_threshold_queries": threshold_queries,
    }


def finite_template_audit(maximum_start: int = 10000) -> dict:
    counts = {"five": 0, "six_branch_A": 0, "six_branch_B": 0}
    for s in range(5, maximum_start + 1):
        if s % 6 in (1, 5):
            five = (s, s + 2, s + 3, s + 4, s + 6)
            assert pairwise_coprime(five)
            counts["five"] += 1
        if s % 6 == 5:
            if s % 5:
                six = (s, s + 2, s + 4, s + 5, s + 6, s + 8)
                counts["six_branch_A"] += 1
            else:
                six = (s, s + 2, s + 3, s + 4, s + 6, s + 8)
                counts["six_branch_B"] += 1
            assert pairwise_coprime(six)
    return {
        "status": "pass_finite_coprimality_check",
        "start_min": 5,
        "start_max": maximum_start,
        "tuple_counts": counts,
        "scope_limit": "Finite diagnostic only; universal coprimality remains a written-proof obligation.",
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parent.parent / "results/independent_reference.json")
    parser.add_argument("--max-five", type=int, default=35)
    parser.add_argument("--max-six", type=int, default=50)
    args = parser.parse_args()
    start = perf_counter()
    report = {
        "schema": "robust-crt-independent-finite-audit/v1",
        "created_at_utc": datetime.now(timezone.utc).isoformat(),
        "python": platform.python_version(),
        "script_sha256": sha256(Path(__file__).read_bytes()).hexdigest(),
        "independent_from_author_search": True,
        "polynomials": polynomial_audit(),
        "templates": finite_template_audit(),
        "exhaustive_capacity": [
            exhaustive_capacity(5, args.max_five, 20),
            exhaustive_capacity(6, args.max_six, 39),
        ],
        "author_solver_comparison": "not_yet_performed",
        "formalization": {"lean_written": False, "lean_run": False},
        "scope": "Exact polynomial identities and finite exhaustive numerical verification only; neither final mathematical audit nor actual-value certification.",
    }
    report["total_elapsed_seconds"] = perf_counter() - start
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({
        "report": str(args.output),
        "polynomials": report["polynomials"]["status"],
        "finite_tuples": sum(x["all_tuples_tested"] for x in report["exhaustive_capacity"]),
        "capacity_maxima": {str(x["L"]): x["capacity_table"][-1]["capacity"] for x in report["exhaustive_capacity"]},
        "elapsed_seconds": report["total_elapsed_seconds"],
    }, ensure_ascii=False))


if __name__ == "__main__":
    main()
