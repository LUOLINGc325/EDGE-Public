"""Exact interval pair-state recurrence and comparison to the full witness oracle."""

from itertools import combinations, combinations_with_replacement
from random import Random

from certificate import exchanges, graph_from_edges, maximum_sets, verify


def optimal_interval_exclusion(intervals):
    """Return original-order indices of an optimal target and of its forcing set."""
    n = len(intervals)
    if n == 0:
        return set(), set()
    if any(left > right for left, right in intervals):
        raise ValueError("invalid closed interval")
    order = sorted(range(n), key=intervals.__getitem__)
    endpoints = sorted({point for interval in intervals for point in interval})
    rank = {point: i for i, point in enumerate(endpoints)}
    left = [rank[intervals[v][0]] for v in order]
    right = [rank[intervals[v][1]] for v in order]
    side = len(endpoints)

    prefix = [[0] * (side + 1) for _ in range(side + 1)]
    for a, b in zip(left, right):
        prefix[a + 1][b + 1] += 1
    for i in range(1, side + 1):
        for j in range(1, side + 1):
            prefix[i][j] += prefix[i - 1][j] + prefix[i][j - 1] - prefix[i - 1][j - 1]

    def cost(previous, vertex, successor):
        ax = 0 if previous < 0 else right[previous] + 1
        bx = right[vertex] + 1
        ay = left[vertex]
        by = side if successor == n else left[successor]
        return prefix[bx][by] - prefix[ax][by] - prefix[bx][ay] + prefix[ax][ay] - 1

    table = [{-1: (1, 0)} for _ in order]
    predecessor = {}
    optimum = (0, 0)
    final = None
    for vertex in range(n):
        for previous, (size, minus_paid) in table[vertex].items():
            endpoint = size, minus_paid - cost(previous, vertex, n)
            if endpoint > optimum:
                optimum = endpoint
                final = previous, vertex
            for successor in range(vertex + 1, n):
                if right[vertex] >= left[successor]:
                    continue
                update = size + 1, minus_paid - cost(previous, vertex, successor)
                if previous_score := table[successor].get(vertex):
                    if previous_score >= update:
                        continue
                table[successor][vertex] = update
                predecessor[vertex, successor] = previous

    chosen = set()
    previous, vertex = final
    while previous >= 0:
        chosen.add(order[vertex])
        previous, vertex = predecessor[previous, vertex], previous
    chosen.add(order[vertex])

    # Bounding each original interval against the chosen chain is an independent
    # reconstruction check. It costs at most O(n^2) here.
    forcing = {u for u, (a, b) in enumerate(intervals)
               if u not in chosen and sum(
                   max(a, intervals[v][0]) <= min(b, intervals[v][1]) for v in chosen
               ) == 1}
    assert (len(chosen), -len(forcing)) == optimum
    return chosen, forcing


def check(intervals):
    graph = graph_from_edges(len(intervals), (
        (u, v) for u, v in combinations(range(len(intervals)), 2)
        if max(intervals[u][0], intervals[v][0]) <= min(intervals[u][1], intervals[v][1])
    ))
    chosen, forcing = optimal_interval_exclusion(intervals)
    assert not any(graph[u] & (1 << v) for u, v in combinations(chosen, 2))
    chosen_mask = sum(1 << v for v in chosen)
    assert sum(1 << u for u in forcing) == exchanges(graph, chosen_mask)
    assert len(forcing) == verify(graph, force_check=True)
    assert chosen_mask in maximum_sets(graph)


def main():
    options = tuple(combinations_with_replacement(range(4), 2))
    counts = []
    for size in range(7):
        count = 0
        for intervals in combinations_with_replacement(options, size):
            check(intervals)
            count += 1
        counts.append(count)
    rng = Random(20261124)
    for _ in range(400):
        intervals = [tuple(sorted(rng.choices(range(8), k=2)))
                     for _ in range(rng.randrange(0, 10))]
        check(intervals)
    print("Interval multisets, by order:", counts, "total", sum(counts))
    print("Seeded interval inputs, including unsorted and tied endpoints: 400")
    print("Pair-state optimum and unique-cover witness agree with full enumeration.")


if __name__ == "__main__":
    main()
