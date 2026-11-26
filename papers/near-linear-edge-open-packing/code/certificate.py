"""Check exact optimum and output feasibility against induced-vertex search."""

from itertools import combinations, combinations_with_replacement, permutations
from random import Random

from sweeps import interval_packing, permutation_packing


def brute(n, graph):
    best = 0
    for mask in range(1 << n):
        induced = [(u, v) for u, v in graph if mask & (1 << u) and mask & (1 << v)]
        if len(induced) <= best:
            continue
        degree = [0] * n
        for u, v in induced:
            degree[u] += 1
            degree[v] += 1
        if all(min(degree[u], degree[v]) == 1 for u, v in induced):
            best = len(induced)
    return best


def check(n, graph, witness):
    assert witness <= graph
    for a, b in combinations(witness, 2):
        assert all(tuple(sorted((u, v))) not in graph or tuple(sorted((u, v))) in (a, b)
                   for u in a for v in b)
    assert len(witness) == brute(n, graph), (n, graph, witness)


def check_intervals(intervals):
    n = len(intervals)
    graph = {(u, v) for u, v in combinations(range(n), 2)
             if max(intervals[u][0], intervals[v][0]) <= min(intervals[u][1], intervals[v][1])}
    check(n, graph, interval_packing(intervals))


def interval_instances():
    options = list(combinations_with_replacement(range(4), 2))
    counts = []
    for n in range(7):
        count = 0
        for intervals in combinations_with_replacement(options, n):
            check_intervals(intervals)
            count += 1
        counts.append(count)
    rng = Random(20261124)
    for _ in range(300):
        intervals = [tuple(sorted(rng.choices(range(9), k=2))) for _ in range(rng.randint(0, 10))]
        check_intervals(intervals)
    print(f"Interval multisets over four coordinates, by order: {counts}; total {sum(counts)}")
    print("Interval seeded additional instances: 300")


def permutation_instances():
    counts = []
    for n in range(8):
        count = 0
        for order in permutations(range(n)):
            graph = {(u, v) for u, v in combinations(range(n), 2) if order[u] > order[v]}
            check(n, graph, permutation_packing(order))
            count += 1
        counts.append(count)
    print(f"Permutation orders through n=7: {counts}; total {sum(counts)}")


if __name__ == "__main__":
    interval_instances()
    permutation_instances()
    print("Exact optimum and valid witness agree in all checked instances.")
