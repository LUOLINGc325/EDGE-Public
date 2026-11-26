"""Exact sweep solver and independent enumeration of small input graphs."""

from collections import defaultdict
from itertools import combinations, combinations_with_replacement
from random import Random


def maximal_cliques_by_sweep(vertices):
    """Return one sweep coordinate per maximal clique on nonempty labels."""
    endpoints = sorted({point for left, right, _ in vertices for point in (left, right)})
    candidates = {}
    for point in endpoints:
        active = defaultdict(list)
        for index, (left, right, labels) in enumerate(vertices):
            if left <= point <= right:
                active[labels].append(index)
        for size in range(1, len(active) + 1):
            for family in combinations(active, size):
                if all(first & second for first, second in combinations(family, 2)):
                    clique = frozenset(vertex for labels in family for vertex in active[labels])
                    candidates.setdefault(clique, point)
    return {
        clique: point
        for clique, point in candidates.items()
        if not any(clique < other for other in candidates)
    }


def solve(vertices, weights):
    """Return an optimum value and selected vertex IDs of the supplied representation."""
    optional = [index for index, vertex in enumerate(vertices) if vertex[2]]
    mandatory = frozenset(range(len(vertices))) - set(optional)
    intervals = [vertices[index] for index in optional]

    starts = defaultdict(list)
    ends = defaultdict(list)
    cliques = defaultdict(list)
    for index, (left, right, _) in enumerate(intervals):
        starts[left].append(index)
        ends[right].append(index)
    for clique, point in maximal_cliques_by_sweep(intervals).items():
        cliques[point].append(clique)

    def retain(table, state, value, selected):
        incumbent = table.get(state)
        if incumbent is None or value > incumbent[0]:
            table[state] = (value, selected)

    initial_value = sum(weights[index] for index in mandatory)
    table = {(): (initial_value, mandatory)}
    for point in sorted(starts.keys() | ends.keys()):
        for index in starts[point]:
            next_table = dict(table)
            label = intervals[index][2]
            for state, (value, selected) in table.items():
                if sum(intervals[active][2] == label for active, _ in state) < 2:
                    next_state = tuple(sorted(state + ((index, False),)))
                    original = optional[index]
                    retain(next_table, next_state, value + weights[original], selected | {original})
            table = next_table

        next_table = {}
        for state, (value, selected) in table.items():
            active = dict(state)
            for clique in cliques[point]:
                hits = clique.intersection(active)
                if not hits:
                    break
                if len(hits) == 1:
                    active[next(iter(hits))] = True
            else:
                if all(active[index] for index in ends[point] if index in active):
                    next_state = tuple((index, witnessed) for index, witnessed in active.items()
                                       if index not in ends[point])
                    retain(next_table, next_state, value, selected)
        table = next_table
    return table[()]


def subsets(vertices):
    for size in range(len(vertices) + 1):
        yield from map(frozenset, combinations(vertices, size))


def reference_cliques(vertices):
    """Compute adjacency, then test every vertex subset for clique maximality."""
    indices = range(len(vertices))
    edges = {
        frozenset((i, j))
        for i, j in combinations(indices, 2)
        if max(vertices[i][0], vertices[j][0]) <= min(vertices[i][1], vertices[j][1])
        and vertices[i][2] & vertices[j][2]
    }
    cliques = [
        subset for subset in subsets(indices)
        if subset and all(frozenset(pair) in edges for pair in combinations(subset, 2))
    ]
    return {clique for clique in cliques if not any(clique < other for other in cliques)}


def reference_optimum(n, cliques, weights):
    """Check minimality by removing vertices and testing coverage afresh."""
    def covers(selection):
        return all(selection & clique for clique in cliques)

    minimal = [
        subset for subset in subsets(range(n))
        if covers(subset) and all(not covers(subset - {vertex}) for vertex in subset)
    ]
    value = max(sum(weights[vertex] for vertex in subset) for subset in minimal)
    return value, set(minimal)


def check(vertices, weights):
    cliques = reference_cliques(vertices)
    indices = [index for index, vertex in enumerate(vertices) if vertex[2]]
    projected = [vertices[index] for index in indices]
    actual_cliques = {
        frozenset(indices[index] for index in clique)
        for clique in maximal_cliques_by_sweep(projected)
    }
    actual_cliques.update(frozenset({index}) for index, vertex in enumerate(vertices) if not vertex[2])
    assert actual_cliques == cliques, (vertices, actual_cliques, cliques)

    expected_value, minimal = reference_optimum(len(vertices), cliques, weights)
    actual_value, selection = solve(vertices, weights)
    assert actual_value == expected_value, (vertices, weights, actual_value, expected_value)
    assert selection in minimal
    assert sum(weights[vertex] for vertex in selection) == actual_value
    for subset in minimal:
        points = {point for vertex in subset for point in vertices[vertex][:2]}
        types = {vertices[vertex][2] for vertex in subset if vertices[vertex][2]}
        assert all(
            sum(vertices[vertex][2] == labels and vertices[vertex][0] <= point <= vertices[vertex][1]
                for vertex in subset) <= 2
            for point in points for labels in types
        )


def main():
    alphabet = [(left, right, mask) for left in range(3) for right in range(left, 3)
                for mask in range(4)]
    exhaustive = 0
    for size in range(4):
        for vertices in combinations_with_replacement(alphabet, size):
            check(vertices, [1] * size)
            exhaustive += 1

    rng = Random(906141)
    random_cases = 600
    for _ in range(random_cases):
        size = rng.randrange(9)
        k = rng.randrange(1, 5)
        vertices = []
        for _ in range(size):
            left, right = sorted((rng.randrange(-3, 5), rng.randrange(-3, 5)))
            vertices.append((left, right, rng.randrange(1 << k)))
        check(vertices, [rng.randrange(-4, 8) for _ in range(size)])
    tight = [(0, 2, 1), (1, 3, 1), (0, 0, 1), (3, 3, 1)]
    check(tight, [1] * len(tight))
    optimum, minimal = reference_optimum(4, reference_cliques(tight), [1] * 4)
    assert optimum == 2 and frozenset({0, 1}) in minimal

    print(f"Exhaustive canonical interval-label inputs (n <= 3, k <= 2): {exhaustive}")
    print(f"Seeded signed-weight inputs (n <= 8, k <= 4): {random_cases}")
    print("Clique enumeration, objective, solution, and active capacity agree with independent enumeration.")
    print("Capacity two is attained by a minimum-under-inclusion transversal of four intervals.")


if __name__ == "__main__":
    main()
