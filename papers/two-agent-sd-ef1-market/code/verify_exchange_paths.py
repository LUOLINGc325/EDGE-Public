#!/usr/bin/env python3
"""Reproduce the independent bounded exchange-path audit.

This script deliberately does not import allocate.py. It enumerates all second
rankings and all balanced starting bundles for 0, 2, 4, and 6 goods, fixing the
first ranking by relabeling. SD-EF1 is checked using its literal single-removal
definition as well as the even-prefix formulation. These finite diagnostics do
not substitute for the proof for arbitrarily many goods.

Run from any directory:
    python code/verify_exchange_paths.py
"""

from __future__ import annotations

import argparse
from itertools import combinations, permutations, product
import json
from pathlib import Path


def sd_after_one_removal(own: set[int], other: set[int], order: tuple[int, ...]) -> bool:
    """Direct existential witness test; one good must work at every prefix."""
    if not other:
        return True
    prefixes = [set(order[:j]) for j in range(1, len(order) + 1)]
    return any(
        all(len(own & prefix) >= len((other - {removed}) & prefix)
            for prefix in prefixes)
        for removed in other
    )


def literal_sd_ef1(a: set[int], p: tuple[int, ...], q: tuple[int, ...]) -> bool:
    other = set(p) - a
    return (sd_after_one_removal(a, other, p)
            and sd_after_one_removal(other, a, q))


def audit_size(n: int) -> dict[str, int | bool]:
    k = n // 2
    p = tuple(range(n))
    p_prefixes = [set(p[:2 * t]) for t in range(1, k + 1)]
    profiles = balanced_checked = feasible_starts = exchanges = choices = 0

    for q in permutations(p):
        profiles += 1
        q_prefixes = [set(q[:2 * t]) for t in range(1, k + 1)]

        def independent(a: set[int]) -> bool:
            return all(len(a & prefix) <= t
                       for t, prefix in enumerate(q_prefixes, 1))

        def prefix_feasible(a: set[int]) -> bool:
            return (len(a) == k and independent(a)
                    and all(len(a & prefix) >= t
                            for t, prefix in enumerate(p_prefixes, 1)))

        target: set[int] = set()
        for g in p:
            if independent(target | {g}):
                target.add(g)
        assert len(target) == k, (n, q, "greedy rank")

        for start_tuple in combinations(p, k):
            a = set(start_tuple)
            balanced_checked += 1
            literal = literal_sd_ef1(a, p, q)
            assert literal == prefix_feasible(a), (n, q, a, "prefix equivalence")
            if not literal:
                continue
            feasible_starts += 1
            assert literal_sd_ef1(target, p, q), (n, q, "greedy feasibility")
            distance = len(a - target)

            for _ in range(distance):
                g = next(j for j in p if (j in a) != (j in target))
                assert g in target - a, (n, q, a, "first difference")
                tight = next(t for t, prefix in enumerate(q_prefixes, 1)
                             if g in prefix and len(a & prefix) == t)
                outgoing = (a - target) & q_prefixes[tight - 1]
                assert outgoing, (n, q, a, "saturated-prefix exchange")

                # Every permitted outgoing choice is checked at this state.
                # Repeated intermediate states are deliberately counted again.
                for removed in outgoing:
                    choices += 1
                    candidate = (a - {removed}) | {g}
                    assert removed > g, (n, q, a, "p-prefix improvement")
                    assert prefix_feasible(candidate), (n, q, candidate, "capacity")
                    assert literal_sd_ef1(candidate, p, q), (n, q, candidate, "SD-EF1")
                    assert len(candidate - target) == len(a - target) - 1

                # A fixed choice makes the reported path counts reproducible.
                a = (a - {min(outgoing)}) | {g}
                exchanges += 1
            assert a == target, (n, q, "path termination")

    return {
        "padded_goods": n,
        "ranking_profiles": profiles,
        "balanced_starting_bundles_checked": balanced_checked,
        "feasible_starting_bundles": feasible_starts,
        "exchanges_on_deterministic_paths": exchanges,
        "permitted_outgoing_choices_checked_with_repetition": choices,
        "passed": True,
    }


def audit_market_crossing() -> dict[str, int | bool | str]:
    crossings = 0
    for x, y, a, b in product(range(6), repeat=4):
        # A has a plus residual value x; its complement has b plus y.
        before, after, total = x + a, x + b, x + y + a + b
        if not (2 * before <= total <= 2 * after):
            continue
        crossings += 1
        if total - 2 * before <= b:
            assert before >= total - before - b
        else:
            assert after - b <= total - after
    return {
        "range_of_each_nonnegative_integer_quantity": "0 through 5 inclusive",
        "quadruples_checked_before_crossing_filter": 6 ** 4,
        "crossing_configurations_checked": crossings,
        "common_inserted_good_witness_passed": True,
    }


def main() -> None:
    project = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path,
                        default=project / "results" / "exchange_path_audit.json")
    args = parser.parse_args()
    cases = [audit_size(n) for n in (0, 2, 4, 6)]
    expected = [(1, 1, 0, 0), (2, 4, 2, 2), (24, 100, 80, 80),
                (720, 7056, 8136, 8968)]
    for case, counts in zip(cases, expected):
        actual = tuple(case[key] for key in (
            "ranking_profiles", "feasible_starting_bundles",
            "exchanges_on_deterministic_paths",
            "permitted_outgoing_choices_checked_with_repetition"))
        assert actual == counts, (actual, counts)
    crossing = audit_market_crossing()
    assert crossing["crossing_configurations_checked"] == 406

    result = {
        "schema_version": 1,
        "status": "PASS",
        "generator": "code/verify_exchange_paths.py",
        "imports_main_allocator": False,
        "ranking_normalization": "The first ranking is the identity by relabeling.",
        "sd_ef1_check": "A single removed good must satisfy every prefix comparison.",
        "exchange_choice_counting": (
            "All permitted outgoing choices are checked at each visited state; "
            "repeated intermediate states are counted again. The actual path "
            "uses the smallest numerical outgoing label."
        ),
        "exchange_cases": cases,
        "market_crossing": crossing,
        "scope_limit": (
            "Finite diagnostics only: no claim of exhaustive verification for "
            "arbitrarily many goods, weak rankings, or arbitrary market weights. "
            "Those cases are addressed by the mathematical proof."
        ),
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
