"""Compare both algorithms with exhaustive induced-vertex-set search."""

from itertools import combinations, combinations_with_replacement
from random import Random

from packing import chordal, convex


def optimum_by_vertex_sets(adjacency):
    """Independent oracle using the degree characterization, with no DP."""
    n = len(adjacency)
    masks = [sum(1 << v for v in ns) for ns in adjacency]
    best = 0
    for selected in range(1 << n):
        retained = [v for v in range(n) if selected & (1 << v)]
        degrees = [(selected & mask).bit_count() for mask in masks]
        edges = sum(degrees[v] for v in retained) // 2
        if edges <= best:
            continue
        high = sum(1 << v for v in retained if degrees[v] > 1)
        if not any(high & masks[v] for v in retained if high & (1 << v)):
            best = edges
    return best


def from_edges(n, edges):
    adjacency = [set() for _ in range(n)]
    for u, v in edges:
        adjacency[u].add(v)
        adjacency[v].add(u)
    return adjacency


def check_witness(adjacency, witness):
    for u, v in witness:
        assert v in adjacency[u]
    for first, second in combinations(witness, 2):
        for u in first:
            for v in second:
                if v in adjacency[u]:
                    joined = (min(u, v), max(u, v))
                    assert joined in (first, second), (first, second, joined)


def chordal_instances():
    counts = []
    for n in range(7):
        pairs = tuple(combinations(range(n), 2))
        checked = 0
        for mask in range(1 << len(pairs)):
            adjacency = from_edges(n, (edge for i, edge in enumerate(pairs) if mask & (1 << i)))
            try:
                witness = chordal(adjacency)
            except ValueError:
                continue
            check_witness(adjacency, witness)
            assert len(witness) == optimum_by_vertex_sets(adjacency), (n, mask)
            checked += 1
        counts.append(checked)
    assert counts == [1, 1, 2, 8, 61, 822, 18154]
    print(f"Chordal labelled graph counts through n=6: {counts}; total {sum(counts)}")


def check_convex(p, intervals):
    adjacency = from_edges(p + len(intervals), (
        (i - 1, p + y) for y, (a, b) in enumerate(intervals) for i in range(a, b + 1)))
    witness = {(i - 1, p + y) for i, y in convex(p, intervals)}
    check_witness(adjacency, witness)
    assert len(witness) == optimum_by_vertex_sets(adjacency), (p, intervals)


def convex_instances():
    counts = []
    for p in range(6):
        intervals = [(a, b) for a in range(1, p + 1) for b in range(a, p + 1)]
        checked = 0
        for k in range(5):
            for chosen in combinations_with_replacement(intervals, k):
                check_convex(p, chosen)
                checked += 1
        counts.append(checked)
    rng = Random(20261124)
    for _ in range(300):
        p = rng.randint(1, 8)
        intervals = []
        for _ in range(rng.randint(0, 6)):
            left = rng.randint(1, p)
            intervals.append((left, rng.randint(left, p)))
        check_convex(p, intervals)
    print(f"Convex interval multisets through p=5, |Y|<=4: {counts}; total {sum(counts)}")
    print("Convex seeded additional instances: 300")


if __name__ == "__main__":
    chordal_instances()
    convex_instances()
    print("Exact optimum and valid witness agree in all checked instances.")
