#!/usr/bin/env python3
"""Exact-rational checks for the binary-reward conversion theorem.

The constructor checks every adjacent fixed stream, including changes to gate
coordinates, and the claimed adjacent-table witness. Separate random causal
policies are checked against every binary table and every neighboring pair at
small horizons. These finite certificates complement, and do not replace, the
general proof or its Lean formalization. No floating-point arithmetic is used.
"""
from __future__ import annotations

import argparse
from fractions import Fraction as F
from itertools import product
import json
from pathlib import Path
import random


def bits(length):
    return list(product((0, 1), repeat=length))


def profile(horizon, lam, delta):
    budget = 2 ** (horizon - 1) * delta
    return min(F(1), budget, (lam - 1 + budget) / (lam + 1))


def defect(p, q, lam):
    return sum((max(F(0), x - lam * y) for x, y in zip(p, q)), F(0))


def law(horizon, kernel, *, stream=None, table=None):
    assert (stream is None) != (table is None)
    masses = []
    for actions in bits(horizon):
        rewards, mass = [], F(1)
        for t, action in enumerate(actions):
            p = kernel(t, actions[:t], tuple(rewards))
            assert 0 <= p <= 1
            mass *= p if action else 1 - p
            rewards.append(stream[t] if stream is not None else table[t][action])
        masses.append(mass)
    assert sum(masses) == 1 and min(masses) >= 0
    return masses


def constructor(horizon, m):
    def kernel(t, actions, rewards):
        if t < horizon - 1:
            return F(1, 2)
        gate = all(a == r for a, r in zip(actions[:-1], rewards[:-1]))
        if not gate:
            return m / 2
        return m if actions[-1] == rewards[-1] else F(0)
    return kernel


def stream_maximum(horizon, kernel, lam, *, all_pairs=False):
    streams = bits(horizon)
    laws = {r: law(horizon, kernel, stream=r) for r in streams}
    by_time = [F(0)] * horizon
    count = 0
    for r in streams:
        for t in range(horizon):
            other = tuple(1 - r[j] if j == t else r[j] for j in range(horizon))
            by_time[t] = max(by_time[t], defect(laws[r], laws[other], lam))
            count += 1
    global_maximum = None
    if all_pairs:
        global_maximum = max(defect(laws[r], laws[s], lam) for r in streams for s in streams)
    return max(by_time), by_time, count, global_maximum


def constructor_check(horizon, lam, delta):
    m = profile(horizon, lam, delta)
    nu = max(F(0), lam * m - (lam - 1))
    kernel = constructor(horizon, m)
    maximum, by_time, count, global_maximum = stream_maximum(horizon, kernel, lam, all_pairs=True)
    expected = (m + nu) / 2 ** (horizon - 1)
    assert maximum == expected <= delta
    assert global_maximum == expected
    assert by_time[-1] == 0 and by_time[-2] == expected
    table = tuple([(0, 1)] * (horizon - 1) + [(0, 0)])
    other = tuple([(0, 1)] * (horizon - 2) + [(1, 0), (0, 0)])
    p, q = law(horizon, kernel, table=table), law(horizon, kernel, table=other)
    assert defect(p, q, lam) == m
    assert defect(q, p, lam) == nu
    return {
        "horizon": horizon, "lambda": str(lam), "delta": str(delta),
        "sharp_profile": str(m), "view_maximum": str(maximum),
        "view_maximum_by_changed_time": [str(x) for x in by_time],
        "table_forward": str(m), "table_reverse": str(nu),
        "directed_stream_neighbors_checked": count,
        "all_ordered_stream_pairs_checked": 2 ** (2 * horizon),
        "global_fixed_stream_maximum": str(global_maximum),
    }


def independent_upper_check(horizon, lam, seed):
    rng = random.Random(seed)
    parameters = {}
    for t in range(horizon):
        for a in bits(t):
            for r in bits(t):
                den = rng.randint(2, 11)
                parameters[t, a, r] = F(rng.randint(0, den), den)

    def kernel(t, actions, rewards):
        return parameters[t, actions, rewards]

    delta, by_time, stream_count, _ = stream_maximum(horizon, kernel, lam)
    upper = profile(horizon, lam, delta)
    rows = bits(2)
    tables = list(product(rows, repeat=horizon))
    laws = {d: law(horizon, kernel, table=d) for d in tables}
    maximum, bilateral_maximum, count = F(0), F(0), 0
    for table in tables:
        for t in range(horizon):
            for row in rows:
                if row == table[t]:
                    continue
                other = table[:t] + (row,) + table[t + 1:]
                u = defect(laws[table], laws[other], lam)
                v = defect(laws[other], laws[table], lam)
                assert u <= upper
                assert u + v <= 2 ** (horizon - 1) * delta
                assert v >= lam * u - (lam - 1)
                maximum = max(maximum, u)
                bilateral_maximum = max(bilateral_maximum, u + v)
                count += 1
    return {
        "horizon": horizon, "lambda": str(lam), "random_seed": seed,
        "view_maximum": str(delta), "view_maximum_by_changed_time": [str(x) for x in by_time],
        "universal_upper": str(upper), "actual_table_maximum": str(maximum),
        "actual_bilateral_maximum": str(bilateral_maximum),
        "directed_stream_neighbors_checked": stream_count,
        "tables_checked": len(tables), "directed_table_neighbors_checked": count,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results/binary_verification.json")
    args = parser.parse_args()
    constructors = []
    for horizon in range(2, 6):
        for lam in [F(1), F(3, 2), F(2), F(5)]:
            transition = (lam - 1) / (lam * 2 ** (horizon - 1))
            saturation = F(1, 2 ** (horizon - 2))
            deltas = sorted({F(0), F(1, 100), F(1, 10), F(1, 4), F(1, 2), F(1),
                             transition, transition / 2, saturation, saturation / 2})
            for delta in deltas:
                constructors.append(constructor_check(horizon, lam, delta))
    independent = [independent_upper_check(t, lam, 20261124 + 100 * t + index)
                   for t in [2, 3, 4] for index, lam in enumerate([F(1), F(3, 2), F(3)])]
    record = {
        "status": "PASS", "arithmetic": "Python fractions.Fraction; no floating-point operations",
        "scope": "Finite exhaustive checks of explicit witnesses and independently sampled causal policies; not a general proof",
        "constructor_cases": len(constructors),
        "constructor_directed_stream_neighbors": sum(x["directed_stream_neighbors_checked"] for x in constructors),
        "constructor_all_ordered_stream_pairs": sum(x["all_ordered_stream_pairs_checked"] for x in constructors),
        "independent_policy_cases": len(independent),
        "independent_directed_table_neighbors": sum(x["directed_table_neighbors_checked"] for x in independent),
        "constructor_results": constructors, "independent_policy_results": independent,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(record, indent=2) + "\n")
    print(json.dumps({k: v for k, v in record.items() if not k.endswith("_results")}, indent=2))


if __name__ == "__main__":
    main()
