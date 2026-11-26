#!/usr/bin/env python3
"""Two-agent ordinal SD-EF1 plus EF1 for independent common market values.

Only the Python standard library is required. Items are numbered 0,...,m-1.
Each order lists every item once, most preferred first. Weak orders may be
refined arbitrarily. Market values are exact nonnegative rational numbers.
The proof and scope of this construction are in ../manuscript/.
"""

from __future__ import annotations

import argparse
from fractions import Fraction
import json
from pathlib import Path
from typing import Iterable, Sequence


def rational(value: int | str | Fraction) -> Fraction:
    if isinstance(value, float):
        raise ValueError("Use a decimal/fraction string, not a binary floating-point number")
    return Fraction(value)


def prefix_counts(bundle: Iterable[int], order: Sequence[int]) -> list[int]:
    selected = set(bundle)
    counts = [0]
    for item in order:
        counts.append(counts[-1] + (item in selected))
    return counts


def feasible(bundle: Iterable[int], p: Sequence[int], q: Sequence[int]) -> bool:
    a = set(bundle)
    if len(a) * 2 != len(p):
        return False
    pc, qc = prefix_counts(a, p), prefix_counts(a, q)
    return all(pc[2*t] >= t and qc[2*t] <= t for t in range(1, len(p)//2 + 1))


def complementary_seed(p: Sequence[int], q: Sequence[int]) -> set[int]:
    """Known adjacent-pair construction: two-color two perfect matchings."""
    adjacency: list[list[int]] = [[] for _ in p]
    for order in (p, q):
        for j in range(0, len(order), 2):
            u, v = order[j], order[j+1]
            adjacency[u].append(v)
            adjacency[v].append(u)
    colors: dict[int, int] = {}
    for start in p:
        if start in colors:
            continue
        colors[start] = 0
        stack = [start]
        while stack:
            u = stack.pop()
            for v in adjacency[u]:
                if v not in colors:
                    colors[v] = 1 - colors[u]
                    stack.append(v)
                elif colors[v] == colors[u]:
                    raise AssertionError("The union of two perfect matchings must be bipartite")
    return {item for item, color in colors.items() if color == 0}


def greedy_target(p: Sequence[int], q: Sequence[int]) -> set[int]:
    """Greedy base of the q-prefix nested-capacity matroid, ordered by p."""
    k = len(p)//2
    q_position = {item: j for j, item in enumerate(q)}
    counts = [0] * k
    target: set[int] = set()
    for item in p:
        first = q_position[item]//2
        if all(counts[t] < t+1 for t in range(first, k)):
            target.add(item)
            for t in range(first, k):
                counts[t] += 1
    if len(target) != k:
        raise AssertionError("Greedy maximal independent set must have rank k")
    return target


def exchange_path(start: Iterable[int], target: set[int],
                  p: Sequence[int], q: Sequence[int]) -> list[frozenset[int]]:
    """At most k valid swaps, using the smallest saturated q-prefix."""
    a = set(start)
    if not feasible(a, p, q):
        raise ValueError("Starting allocation is not ordinal-feasible")
    q_position = {item: j for j, item in enumerate(q)}
    path = [frozenset(a)]
    while a != target:
        incoming = next(item for item in p if (item in a) != (item in target))
        if incoming not in target:
            raise AssertionError("First symmetric difference must enter the greedy target")
        counts = prefix_counts(a, q)
        first = q_position[incoming]//2 + 1
        tight = next(t for t in range(first, len(p)//2 + 1) if counts[2*t] == t)
        outgoing = next(item for item in q[:2*tight] if item in a and item not in target)
        a.remove(outgoing)
        a.add(incoming)
        if not feasible(a, p, q):
            raise AssertionError("A saturated-prefix exchange violated ordinal feasibility")
        path.append(frozenset(a))
    if len(path)-1 > len(p)//2:
        raise AssertionError("Exchange path exceeded its proved length bound")
    return path


def market_ef1(a: Iterable[int], universe: set[int], weights: Sequence[Fraction]) -> bool:
    a = set(a)
    b = universe - a
    sa = sum((weights[g] for g in a), Fraction(0))
    sb = sum((weights[g] for g in b), Fraction(0))
    return (sa - max((weights[g] for g in a), default=Fraction(0)) <= sb
            and sb - max((weights[g] for g in b), default=Fraction(0)) <= sa)


def solve(p: Sequence[int], q: Sequence[int],
          market: Sequence[int | str | Fraction], *, include_trace: bool = False) -> dict:
    p, q = list(p), list(q)
    m = len(market)
    real_items = set(range(m))
    if len(p) != m or len(q) != m or set(p) != real_items or set(q) != real_items:
        raise ValueError("Both orders must be permutations of 0,...,m-1")
    weights = [rational(w) for w in market]
    if any(w < 0 for w in weights):
        raise ValueError("The theorem requires nonnegative market values")
    original_orders = [p[:], q[:]]
    dummy = m if m % 2 else None
    if dummy is not None:
        p.append(dummy)
        q.append(dummy)
        weights.append(Fraction(0))
    universe = set(range(len(p)))
    seed = complementary_seed(p, q)
    target = greedy_target(p, q)
    left = exchange_path(seed, target, p, q)
    right = exchange_path(universe-seed, target, p, q)
    path = left + list(reversed(right[:-1]))
    if len(path)-1 != len(p)//2:
        raise AssertionError("Complementary seeds must be joined by exactly k exchanges")
    total = sum(weights, Fraction(0))
    values = [sum((weights[g] for g in a), Fraction(0)) for a in path]
    selected: int | None = next((i for i, s in enumerate(values) if 2*s == total), None)
    crossing = None
    if selected is None:
        for i in range(len(path)-1):
            if (2*values[i] < total) != (2*values[i+1] < total):
                crossing = [i, i+1]
                selected = next((j for j in crossing if market_ef1(path[j], universe, weights)), None)
                if selected is None:
                    raise AssertionError("Both endpoints of a market crossing failed EF1")
                break
    if selected is None:
        raise AssertionError("Complementary endpoints did not produce a crossing")
    first = set(path[selected]) & real_items
    second = real_items - first
    bundles = [sorted(first), sorted(second)]
    subjective_witnesses = []
    for i, order in enumerate(original_orders):
        other = set(bundles[1-i])
        witness = next((g for g in order if g in other), None)
        subjective_witnesses.append(witness)
    market_witnesses = []
    for i in range(2):
        other = bundles[1-i]
        market_witnesses.append(max(other, key=lambda g: (weights[g], -g)) if other else None)
    result = {
        "items": m,
        "allocation": bundles,
        "market_values": [str(sum((weights[g] for g in bundle), Fraction(0))) for bundle in bundles],
        "subjective_removal_witnesses": subjective_witnesses,
        "market_removal_witnesses": market_witnesses,
        "padded_items": len(p),
        "dummy": dummy,
        "path_swaps": len(path)-1,
        "path_swap_bound": len(p)//2,
        "selected_path_index": selected,
        "crossing_indices": crossing,
    }
    if include_trace:
        result["trace"] = {
            "seed": sorted(seed), "target": sorted(target),
            "vertices": [sorted(a) for a in path],
            "market_values": [str(s) for s in values],
        }
    return result


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("instance", type=Path, help="JSON with order1, order2, market")
    parser.add_argument("--trace", action="store_true")
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    data = json.loads(args.instance.read_text(encoding="utf-8"))
    result = solve(data["order1"], data["order2"], data["market"], include_trace=args.trace)
    text = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(text, encoding="utf-8")
    else:
        print(text, end="")


if __name__ == "__main__":
    main()
