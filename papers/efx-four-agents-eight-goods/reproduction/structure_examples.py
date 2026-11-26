#!/usr/bin/env python3
"""Construct exact examples and audit the five partition shapes.

This script is independent of search_efx.py. These examples refute proposed
shortcuts, not the EFX existence problem.
"""
from __future__ import annotations

import itertools
import json
import math
from collections import Counter
from pathlib import Path

from validate_efx import validate

ROOT = Path(__file__).resolve().parent


def additive(weights):
    return [sum(w for g, w in enumerate(weights) if mask & (1 << g))
            for mask in range(1 << len(weights))]


def restricted_partitions(m, n):
    """Restricted growth strings produce every unlabeled nonempty partition once."""
    def rec(labels, max_label):
        if len(labels) == m:
            if max_label == n - 1:
                masks = [0] * n
                for g, label in enumerate(labels):
                    masks[label] |= 1 << g
                yield tuple(masks)
            return
        for label in range(min(max_label + 1, n - 1) + 1):
            yield from rec(labels + [label], max(label, max_label))
    if m:
        yield from rec([0], 0)


def singleton_extensions(instance, agent, good):
    n, m = instance["n"], instance["m"]
    v = instance["valuations"]
    others = [i for i in range(n) if i != agent]
    goods = [g for g in range(m) if g != good]
    remaining_efx = 0
    full_efx = 0
    for labels in itertools.product(others, repeat=len(goods)):
        a = [0] * n
        a[agent] = 1 << good
        for g, label in zip(goods, labels):
            a[label] |= 1 << g
        def efx_for(i, js):
            return all(v[i][a[i]] >= v[i][a[j] ^ (1 << g)]
                       for j in js for g in range(m) if a[j] & (1 << g))
        if all(efx_for(i, others) for i in others):
            remaining_efx += 1
            if efx_for(agent, range(n)):
                full_efx += 1
    return {"agent": agent, "singleton_good": good,
            "residual_EFX_count": remaining_efx,
            "full_EFX_extensions": full_efx}


def main():
    # Scale by ten so the strictly positive additive example uses only integers.
    # Goods: g,a,b,c1,c2,c3,c4,c5.
    sharp = {"n": 4, "m": 8,
             "goods": ["g", "a", "b", "c1", "c2", "c3", "c4", "c5"],
             "description": "Quartet bound for singleton elimination cannot be reduced to triples; NOT an EFX counterexample.",
             "valuations": [additive([30, 1, 1, 10, 10, 10, 10, 10])] +
                           [additive([10, 1000, 1000, 10, 10, 10, 10, 10]) for _ in range(3)]}
    (ROOT / "quartet_sharpness.json").write_text(json.dumps(sharp, indent=2) + "\n")
    sharp_report = validate(sharp)
    sharp_report["singleton_test"] = singleton_extensions(sharp, 0, 0)
    sharp_report["triple_dominance"] = all(sharp["valuations"][0][1] >= sharp["valuations"][0][s]
                                           for s in range(256) if not (s & 1) and s.bit_count() <= 3)
    (ROOT / "quartet_sharpness_validation.json").write_text(json.dumps(sharp_report, indent=2) + "\n")

    # All four agents agree on every singleton and pair. Pair-acceptance edges
    # are exactly the seven edges containing g. Agent zero has higher-order synergy.
    base = additive([100, 10, 10, 1, 1, 1, 1, 1])
    special = [value + (1000 if (mask & 0b11111000).bit_count() >= 4 else 0)
               for mask, value in enumerate(base)]
    synergy = {"n": 4, "m": 8,
               "goods": ["g", "h", "k", "z1", "z2", "z3", "z4", "z5"],
               "description": "Identical pair data does not justify choosing an arbitrary singleton recipient; NOT an EFX counterexample.",
               "valuations": [special, base, base, base]}
    (ROOT / "pair_shortcut_obstruction.json").write_text(json.dumps(synergy, indent=2) + "\n")
    synergy_report = validate(synergy)
    synergy_report["all_singleton_extensions_for_agent_zero"] = [singleton_extensions(synergy, 0, g) for g in range(8)]
    synergy_report["singleton_pair_tables_equal"] = all(special[s] == base[s] for s in range(256) if s.bit_count() <= 2)
    (ROOT / "pair_shortcut_validation.json").write_text(json.dumps(synergy_report, indent=2) + "\n")

    shapes = Counter(tuple(sorted(x.bit_count() for x in p)) for p in restricted_partitions(8, 4))
    report = {"unlabeled_partitions": sum(shapes.values()),
              "nonempty_labeled_allocations": sum(shapes.values()) * math.factorial(4),
              "all_labeled_allocations": 4**8,
              "by_shape": [{"sizes": list(shape), "unlabeled": count, "labeled": count*24}
                           for shape, count in sorted(shapes.items())],
              "subsets_size_at_most_four": sum(math.comb(8, k) for k in range(5))}
    (ROOT / "partition_counts.json").write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps({"quartet": sharp_report, "pair_obstruction": synergy_report, "partitions": report}, indent=2))


if __name__ == "__main__":
    main()
