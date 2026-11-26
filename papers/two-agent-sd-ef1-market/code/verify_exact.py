#!/usr/bin/env python3
"""Independent definition-level checks of the construction.

The verifier tests SD-EF1 by choosing one removed good and examining EVERY
ranking prefix. It does not reuse the allocator's even-prefix predicate.
This finite computation supplements, and does not replace, the general proof.
"""
from __future__ import annotations

import argparse
from fractions import Fraction
import hashlib
import itertools
import json
from pathlib import Path
import platform
import random
import sys

from allocate import solve


def sd_ef1(own: set[int], other: set[int], order: list[int]) -> bool:
    if not other:
        return True
    for removed in other:
        remaining = other - {removed}
        if all(len(own.intersection(order[:r])) >= len(remaining.intersection(order[:r]))
               for r in range(1, len(order)+1)):
            return True
    return False


def cardinal_ef1(own: set[int], other: set[int], values: list[Fraction]) -> bool:
    if not other:
        return True
    own_value = sum((values[g] for g in own), Fraction(0))
    return any(own_value >= sum((values[g] for g in other if g != removed), Fraction(0))
               for removed in other)


def check(p: list[int], q: list[int], weights: list[Fraction], result: dict) -> None:
    a, b = (set(bundle) for bundle in result["allocation"])
    assert not a & b and a | b == set(range(len(weights)))
    assert abs(len(a)-len(b)) <= 1
    for own, other, order in [(a, b, p), (b, a, q)]:
        assert sd_ef1(own, other, order)
        assert cardinal_ef1(own, other, weights)
    assert result["path_swaps"] == result["padded_items"]//2
    if "trace" in result:
        n = result["padded_items"]
        universe = set(range(n))
        dummy = result["dummy"]
        pp, qq = p[:], q[:]
        if dummy is not None:
            pp.append(dummy)
            qq.append(dummy)
        vertices = [set(a) for a in result["trace"]["vertices"]]
        assert vertices[-1] == universe-vertices[0]
        for vertex in vertices:
            assert len(vertex) == n//2
            assert sd_ef1(vertex, universe-vertex, pp)
            assert sd_ef1(universe-vertex, vertex, qq)
        for first, second in zip(vertices, vertices[1:]):
            assert len(first-second) == len(second-first) == 1


def weak_sd_ef1(own: set[int], other: set[int], values: list[int]) -> bool:
    """Check weak orders at actual value levels, including a tied zero level."""
    if not other:
        return True
    return any(all(sum(values[g] >= threshold for g in own)
                       >= sum(values[g] >= threshold for g in other if g != removed)
                   for threshold in set(values)) for removed in other)


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1]/"results"/"exact_verification.json")
    args = parser.parse_args()
    digest = hashlib.sha256()
    counts = {"binary_exhaustive": 0, "extra_ternary_exhaustive": 0,
              "random_rational": 0, "weak_order_cases": 0}

    def run(p, q, w, category, trace=False):
        result = solve(p, q, w, include_trace=trace)
        check(p, q, list(map(Fraction, w)), result)
        record = [p, q, list(map(str, w)), result["allocation"], result["path_swaps"]]
        digest.update((json.dumps(record, separators=(",", ":"))+"\n").encode())
        counts[category] += 1
        return result

    # Relabeling fixes the first strict order without losing any order pair.
    for m in range(7):
        p = list(range(m))
        for q_tuple in itertools.permutations(p):
            q = list(q_tuple)
            for w in itertools.product(range(2), repeat=m):
                run(p, q, list(w), "binary_exhaustive")
            if m <= 4:
                for w in itertools.product(range(3), repeat=m):
                    if 2 in w:  # exclude cases counted in the binary suite
                        run(p, q, list(w), "extra_ternary_exhaustive")

    rng = random.Random(20261124)
    for case in range(360):
        m = [7, 8, 15, 31, 64, 101][case % 6]
        p, q = list(range(m)), list(range(m))
        rng.shuffle(p)
        rng.shuffle(q)
        w = [Fraction(rng.randrange(20), rng.randrange(1, 12)) if rng.random() > .3 else Fraction(0)
             for _ in range(m)]
        if case % 17 == 0:
            w = [Fraction(0)]*m
        elif case % 19 == 0:
            w[rng.randrange(m)] = Fraction(10**20, 3)
        run(p, q, w, "random_rational", trace=case < 24)

    for case in range(120):
        m = [1, 3, 7, 12, 25][case % 5]
        valuations = [[rng.randrange(6) for _ in range(m)] for _ in range(2)]
        if case % 11 == 0:
            valuations[case % 2] = [0]*m
        p, q = [sorted(range(m), key=lambda g: (-v[g], g)) for v in valuations]
        w = [Fraction(rng.randrange(10), rng.randrange(1, 5)) for _ in range(m)]
        result = run(p, q, w, "weak_order_cases", trace=True)
        a, b = (set(bundle) for bundle in result["allocation"])
        assert weak_sd_ef1(a, b, valuations[0])
        assert weak_sd_ef1(b, a, valuations[1])

    example = {"order1": [0,1,2,3,4,5], "order2": [1,2,3,4,5,0], "market": [1,0,1,0,1,0]}
    example_result = solve(example["order1"], example["order2"], example["market"], include_trace=True)
    check(example["order1"], example["order2"], list(map(Fraction, example["market"])), example_result)
    seed = set(example_result["trace"]["seed"])
    comp = set(range(6))-seed
    assert not (cardinal_ef1(seed, comp, list(map(Fraction, example["market"])))
                and cardinal_ef1(comp, seed, list(map(Fraction, example["market"]))))
    assert not (cardinal_ef1(comp, seed, list(map(Fraction, example["market"])))
                and cardinal_ef1(seed, comp, list(map(Fraction, example["market"]))))

    output = {
        "status": "passed", "counts": counts, "total_instances": sum(counts.values()),
        "transcript_sha256": digest.hexdigest(),
        "arithmetic": "Python fractions.Fraction; exact rational comparisons",
        "exhaustive_scope": "All strict second rankings and binary market vectors for 0<=m<=6; first order fixed by relabeling. Additional ternary vectors containing a 2 for m<=4.",
        "random_seed": 20261124,
        "checks": ["complete partition", "balanced cardinalities", "subjective SD-EF1 from its full definition",
                   "common-market EF1 from its full definition", "exact k-swap complementary path",
                   "all-prefix path verification on selected traces", "weak ties, zero values and dummy removal"],
        "logical_scope": "Finite regression evidence; not a proof of the arbitrary-m theorem",
        "python": platform.python_version(),
        "example": example_result,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(output, indent=2, ensure_ascii=False)+"\n", encoding="utf-8")
    print(json.dumps({"status": output["status"], "counts": counts, "total_instances": output["total_instances"],
                      "transcript_sha256": output["transcript_sha256"]}, indent=2))


if __name__ == "__main__":
    main()
