#!/usr/bin/env python3
"""Exact finite checks of the finite-alphabet, zero-epsilon theorem.

All probabilities use fractions.Fraction.  The channel tests enumerate every
reward symbol and every pair.  The causal tests construct the policy one
action at a time and check every fixed-stream pair, including streams that
differ in gate coordinates.  Independently sampled causal policies are checked
against every neighboring table for the stated small parameter grid.

These are finite checks, not a substitute for the all-parameter proof.
"""
from __future__ import annotations

import argparse
from fractions import Fraction as F
from itertools import product
import json
from pathlib import Path
import random


def tv(p, q):
    return sum((abs(x - y) for x, y in zip(p, q)), F(0)) / 2


def coefficient(k, q, horizon):
    return min(F(k), F(q, 2)) * min(k, q) ** (horizon - 2)


def channel(k, q, c):
    """Return joint (sensitive action, terminal bit) center and q vertices."""
    q0 = min(q, 2 * k)
    pairs, singleton = divmod(q0, 2)
    assert 0 <= c <= F(1, q0)
    center = [[F(0), F(0)] for _ in range(k)]
    for a in range(pairs):
        center[a] = [F(1, q0), F(1, q0)]
    if singleton:
        center[pairs] = [F(0), F(1, q0)]
    vertices = []
    for symbol in range(q):
        values = [row[:] for row in center]
        if symbol < 2 * pairs:
            a, sign = divmod(symbol, 2)
            shift = c if sign == 0 else -c
            values[a][0] -= shift
            values[a][1] += shift
        elif singleton and symbol == 2 * pairs:
            values[pairs][0] += c
            values[pairs][1] -= c
        vertices.append(tuple(x for row in values for x in row))
    return tuple(x for row in center for x in row), vertices


def channel_check(k, q, c):
    center, vertices = channel(k, q, c)
    q0 = min(q, 2 * k)
    assert sum(center) == 1 and min(center) >= 0
    marginal = [center[2 * a] + center[2 * a + 1] for a in range(k)]
    for y, law in enumerate(vertices):
        assert sum(law) == 1 and min(law) >= 0
        assert [law[2 * a] + law[2 * a + 1] for a in range(k)] == marginal
        assert tv(law, center) == (c if y < q0 else 0)
        for z, other in enumerate(vertices):
            expected = F(0) if y == z else (2 * c if y < q0 and z < q0
                                            else c if (y < q0) != (z < q0) else F(0))
            assert tv(law, other) == expected
    pairs, singleton = divmod(q0, 2)
    left = [2 * a if a < pairs else 2 * pairs if singleton and a == pairs else 0
            for a in range(k)]
    right = [2 * a + 1 if a < pairs else 0 for a in range(k)]
    table_left = [vertices[left[a]][2 * a + b] for a in range(k) for b in range(2)]
    table_right = [vertices[right[a]][2 * a + b] for a in range(k) for b in range(2)]
    assert sum(table_left) == sum(table_right) == 1
    assert tv(table_left, table_right) == q0 * c
    return {"K": k, "q": q, "q0": q0, "c": str(c),
            "ordered_channel_pairs_checked": q * q,
            "table_tv": str(q0 * c)}


def witness_kernel(k, q, horizon, sensitive, c):
    center, vertices = channel(k, q, c)
    marginal = tuple(center[2 * a] + center[2 * a + 1] for a in range(k))
    m = min(k, q)

    def kernel(t, actions, rewards):
        if t < horizon - 1:
            return marginal if t == sensitive else tuple(F(1, m) if a < m else F(0)
                                                        for a in range(k))
        a = actions[sensitive]
        if not marginal[a]:
            return (F(1),) + (F(0),) * (k - 1)
        passed = all(rewards[s] == actions[s] for s in range(horizon - 1)
                     if s != sensitive)
        joint = vertices[rewards[sensitive]] if passed else center
        return (joint[2 * a] / marginal[a], joint[2 * a + 1] / marginal[a]) + (F(0),) * (k - 2)

    return kernel


def causal_law(k, horizon, kernel, stream=None, table=None):
    assert (stream is None) != (table is None)
    masses = []
    for actions in product(range(k), repeat=horizon):
        rewards, mass = [], F(1)
        for t, action in enumerate(actions):
            probabilities = kernel(t, actions[:t], tuple(rewards))
            assert min(probabilities) >= 0 and sum(probabilities) == 1
            mass *= probabilities[action]
            if t < horizon - 1:
                rewards.append(stream[t] if stream is not None else table[t][action])
        masses.append(mass)
    assert sum(masses) == 1 and min(masses) >= 0
    return masses


def witness_check(k, q, horizon, sensitive, delta):
    q0, gates = min(q, 2 * k), min(k, q) ** (horizon - 2)
    c = min(F(1, q0), gates * delta / 2)
    kernel = witness_kernel(k, q, horizon, sensitive, c)
    streams = list(product(range(q), repeat=horizon - 1))
    laws = {r: causal_law(k, horizon, kernel, stream=r) for r in streams}
    maximum = F(0)
    neighbors = [F(0)] * (horizon - 1)
    for r, p in laws.items():
        for s, other in laws.items():
            distance = tv(p, other)
            assert distance <= 2 * c / gates <= delta
            maximum = max(maximum, distance)
            different = [t for t in range(horizon - 1) if r[t] != s[t]]
            if len(different) == 1:
                neighbors[different[0]] = max(neighbors[different[0]], distance)
    assert maximum == 2 * c / gates
    pairs, singleton = divmod(q0, 2)
    gate_row = tuple(a if a < min(k, q) else 0 for a in range(k))
    left_row = tuple(2 * a if a < pairs else 2 * pairs if singleton and a == pairs else 0
                     for a in range(k))
    right_row = tuple(2 * a + 1 if a < pairs else 0 for a in range(k))
    left = tuple(left_row if t == sensitive else gate_row for t in range(horizon - 1))
    right = tuple(right_row if t == sensitive else gate_row for t in range(horizon - 1))
    p = causal_law(k, horizon, kernel, table=left)
    other = causal_law(k, horizon, kernel, table=right)
    expected = min(F(1), coefficient(k, q, horizon) * delta)
    assert tv(p, other) == q0 * c == expected
    return {"K": k, "q": q, "T": horizon, "sensitive_row_1_based": sensitive + 1,
            "delta": str(delta), "c": str(c), "coefficient": str(coefficient(k, q, horizon)),
            "view_tv_all_pairs": str(maximum), "view_tv_by_changed_row": [str(x) for x in neighbors],
            "table_tv": str(expected), "fixed_streams_checked": len(streams),
            "ordered_stream_pairs_checked": len(streams) ** 2}


def independent_upper_check(k, q, horizon, seed):
    rng = random.Random(seed)
    parameters = {}
    for t in range(horizon):
        for actions in product(range(k), repeat=t):
            for rewards in product(range(q), repeat=t):
                weights = [rng.randrange(1, 10) for _ in range(k)]
                parameters[t, actions, rewards] = tuple(F(w, sum(weights)) for w in weights)

    def kernel(t, actions, rewards):
        return parameters[t, actions, rewards]

    streams = list(product(range(q), repeat=horizon - 1))
    stream_laws = {r: causal_law(k, horizon, kernel, stream=r) for r in streams}
    delta, stream_count = F(0), 0
    for r in streams:
        for t in range(horizon - 1):
            for symbol in range(q):
                if symbol == r[t]:
                    continue
                s = r[:t] + (symbol,) + r[t + 1:]
                delta = max(delta, tv(stream_laws[r], stream_laws[s]))
                stream_count += 1
    rows = list(product(range(q), repeat=k))
    tables = list(product(rows, repeat=horizon - 1))
    table_laws = {d: causal_law(k, horizon, kernel, table=d) for d in tables}
    upper, maximum, table_count = min(F(1), coefficient(k, q, horizon) * delta), F(0), 0
    for d in tables:
        for t in range(horizon - 1):
            for row in rows:
                if row == d[t]:
                    continue
                e = d[:t] + (row,) + d[t + 1:]
                distance = tv(table_laws[d], table_laws[e])
                assert distance <= upper
                maximum = max(maximum, distance)
                table_count += 1
    return {"K": k, "q": q, "T": horizon, "seed": seed,
            "view_tv": str(delta), "upper": str(upper), "table_tv_maximum": str(maximum),
            "directed_stream_neighbors_checked": stream_count, "tables_checked": len(tables),
            "directed_table_neighbors_checked": table_count}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] /
                        "results/finite_alphabet_verification.json")
    args = parser.parse_args()
    channels = [channel_check(k, q, c) for k in range(2, 9) for q in range(2, 2 * k + 4)
                for c in [F(0), F(1, 2 * min(q, 2 * k)), F(1, min(q, 2 * k))]]
    witnesses = []
    grid = [(2, 2, 2), (2, 3, 2), (2, 4, 2), (2, 5, 2),
            (3, 3, 2), (3, 5, 2), (3, 6, 2), (3, 7, 2),
            (4, 7, 2), (4, 9, 2),
            (2, 2, 3), (2, 3, 3), (2, 4, 3), (2, 5, 3),
            (3, 3, 3), (3, 5, 3), (3, 7, 3), (2, 3, 4)]
    for k, q, horizon in grid:
        saturation = 1 / coefficient(k, q, horizon)
        for delta in sorted({F(0), saturation / 3, saturation, F(1)}):
            for sensitive in range(horizon - 1):
                witnesses.append(witness_check(k, q, horizon, sensitive, delta))
    independent = [independent_upper_check(k, q, t, 20261124 + 100 * k + 10 * q + t)
                   for k, q, t in [(2, 2, 2), (2, 3, 2), (2, 4, 2), (3, 3, 2),
                                   (2, 2, 3), (2, 3, 3), (2, 4, 3)]]
    record = {"status": "PASS", "arithmetic": "fractions.Fraction; exact rational arithmetic",
              "scope": "Finite checks only; separate from general mathematical and Lean claims",
              "channel_cases": len(channels),
              "ordered_channel_pairs": sum(x["ordered_channel_pairs_checked"] for x in channels),
              "causal_witness_cases": len(witnesses),
              "ordered_stream_pairs": sum(x["ordered_stream_pairs_checked"] for x in witnesses),
              "independent_policy_cases": len(independent),
              "directed_table_neighbors": sum(x["directed_table_neighbors_checked"] for x in independent),
              "channel_results": channels, "causal_witness_results": witnesses,
              "independent_policy_results": independent}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(record, indent=2) + "\n")
    print(json.dumps({k: v for k, v in record.items() if not k.endswith("_results")}, indent=2))


if __name__ == "__main__":
    main()
