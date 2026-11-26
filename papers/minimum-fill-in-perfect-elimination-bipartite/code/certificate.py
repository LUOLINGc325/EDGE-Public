#!/usr/bin/env python3
"""Finite checks for perfect-edge-elimination bipartite minimum fill-in."""

from itertools import combinations, product
from math import comb
from random import Random


def edge(u, v):
    return (min(u, v), max(u, v))


def graph(size, edges):
    neighbors = [set() for _ in range(size)]
    for u, v in edges:
        neighbors[u].add(v)
        neighbors[v].add(u)
    return neighbors


def connected(neighbors, vertices):
    root = next(iter(vertices))
    reached = {root}
    pending = [root]
    while pending:
        fresh = (neighbors[pending.pop()] & vertices) - reached
        reached.update(fresh)
        pending.extend(fresh)
    return reached == vertices


def two_connected(neighbors):
    vertices = set(range(len(neighbors)))
    return len(vertices) >= 3 and all(
        connected(neighbors, vertices - {u}) for u in vertices
    )


def chordal(size, edges):
    neighbors = graph(size, edges)
    weights = [0] * size
    remaining = set(range(size))
    while remaining:
        u = max(remaining, key=lambda v: (weights[v], v))
        selected_neighbors = neighbors[u] - remaining
        if any(v not in neighbors[w] for v, w in combinations(selected_neighbors, 2)):
            return False
        remaining.remove(u)
        for v in neighbors[u] & remaining:
            weights[v] += 1
    return True


def fill_by_order(neighbors, order):
    neighbors = [set(row) for row in neighbors]
    added = set()
    for u in order:
        for v, w in combinations(neighbors[u], 2):
            if w not in neighbors[v]:
                added.add(edge(v, w))
                neighbors[v].add(w)
                neighbors[w].add(v)
        for v in neighbors[u]:
            neighbors[v].remove(u)
        neighbors[u].clear()
    return added


def exact_fill(size, edges):
    missing = sorted(set(combinations(range(size), 2)) - edges)
    for count in range(len(missing) + 1):
        for chosen in combinations(missing, count):
            fill = set(chosen)
            if chordal(size, edges | fill):
                return fill
    raise AssertionError("complete graph is chordal")


def double_subdivide(size, source):
    edges, projection, discarded, square_diagonals = set(), list(range(size)), set(), []
    for u, v in sorted(source):
        a, b = len(projection), len(projection) + 1
        projection.extend((u, None))
        discarded.add(b)
        edges.update((edge(u, a), edge(v, a), edge(u, b), edge(v, b)))
        square_diagonals.append(((u, v), (a, b)))
    return edges, projection, discarded, square_diagonals


def undo_subdivision(edges, projection, discarded):
    return {
        edge(projection[u], projection[v])
        for u, v in edges
        if u not in discarded and v not in discarded and projection[u] != projection[v]
    }


def augment(core, core_size, left_count, degree):
    neighbors = graph(core_size, core)
    next_vertex = core_size
    sides = [v < left_count for v in range(core_size)]
    edges, internal_fill = set(core), set()
    private_elimination, pendant_elimination, gadgets = [], [], []
    for v in range(core_size):
        u = min(neighbors[v])
        small = tuple(range(next_vertex, next_vertex + degree - 1))
        next_vertex += len(small)
        large = tuple(range(next_vertex, next_vertex + degree))
        next_vertex += len(large)
        sides.extend([sides[v]] * len(small))
        sides.extend([sides[u]] * len(large))
        first, second = (v, *small), (u, *large)
        edges.update(edge(x, y) for x, y in product(first, second))
        internal_fill.update(edge(x, y) for x, y in combinations(first, 2))
        private_elimination.extend(zip(small, large[:-1]))
        pendant_elimination.append((v, large[-1]))
        gadgets.append((first, second))
    assert all(sides[u] != sides[v] for u, v in edges)
    return next_vertex, edges, internal_fill, private_elimination + pendant_elimination, gadgets


def verify_elimination(neighbors, order):
    remaining = set(range(len(neighbors)))
    for u, v in order:
        assert u in remaining and v in remaining and v in neighbors[u]
        assert all(neighbors[u] & remaining <= neighbors[w] for w in neighbors[v] & remaining)
        remaining.difference_update((u, v))
    assert all(not (neighbors[u] & remaining) for u in remaining)


def actual_degeneracy(neighbors):
    degrees = [len(row) for row in neighbors]
    remaining = set(range(len(neighbors)))
    result = 0
    while remaining:
        u = min(remaining, key=lambda v: (degrees[v], v))
        result = max(result, degrees[u])
        remaining.remove(u)
        for v in neighbors[u] & remaining:
            degrees[v] -= 1
    return result


def check(size, source, rng):
    base_fill = exact_fill(size, source)
    hubbed = source | {
        (v, hub) for v in range(size) for hub in (size, size + 1)
    } | {(size, size + 1)}
    old_size = size + 2
    core, projection, discarded, squares = double_subdivide(old_size, hubbed)
    core_size = len(projection)
    core_neighbors = graph(core_size, core)
    assert two_connected(core_neighbors)
    assert actual_degeneracy(core_neighbors) == 2
    core_fill = hubbed | base_fill
    assert len(core_fill) == len(hubbed) + len(base_fill)
    assert chordal(core_size, core | core_fill)

    # Check the reverse map on both canonical and randomly ordered triangulations.
    random_order = list(range(core_size))
    rng.shuffle(random_order)
    for candidate in (core_fill, fill_by_order(core_neighbors, random_order)):
        assert all(first in candidate or second in candidate for first, second in squares)
        image = undo_subdivision(core | candidate, projection, discarded)
        assert hubbed <= image
        assert chordal(old_size, image)
        assert len(image - hubbed) <= len(candidate) - len(hubbed)

    for degree in (2, 3, 4):
        size_h, edges, private_fill, elimination, gadgets = augment(
            core, core_size, old_size, degree
        )
        neighbors = graph(size_h, edges)
        assert two_connected(neighbors)
        assert min(map(len, neighbors)) == actual_degeneracy(neighbors) == degree
        verify_elimination(neighbors, elimination)
        assert len(private_fill) == core_size * comb(degree, 2)
        assert chordal(size_h, edges | core_fill | private_fill)

        # Test the disjoint charge from each gadget on a second chordal completion.
        alternate = fill_by_order(neighbors, reversed(range(size_h)))
        assert chordal(size_h, edges | alternate)
        charged = []
        for a, b in gadgets:
            filled_a = {edge(u, v) for u, v in combinations(a, 2)}
            filled_b = {edge(u, v) for u, v in combinations(b, 2)}
            selected = filled_a if filled_a <= alternate else filled_b
            assert selected <= alternate
            charged.extend(selected)
        assert len(charged) == len(set(charged))
        assert all(v >= core_size for _, v in charged)


def main():
    rng = Random(4931993)
    exhaustive = 0
    for size in range(1, 5):
        candidates = list(combinations(range(size), 2))
        for mask in range(1 << len(candidates)):
            source = {uv for i, uv in enumerate(candidates) if mask & (1 << i)}
            check(size, source, rng)
            exhaustive += 1
    print(f"exhaustive source graphs: {exhaustive}; degrees 2, 3, 4 passed", flush=True)

    for _ in range(60):
        size = rng.randint(5, 7)
        probability = rng.choice((0.2, 0.4, 0.6, 0.8))
        source = {uv for uv in combinations(range(size), 2) if rng.random() < probability}
        check(size, source, rng)
    print("seeded source graphs: 60; degrees 2, 3, 4 passed")


if __name__ == "__main__":
    main()
