"""Exact finite cross-check of oriented conflicts and two-pair witness recovery."""

from functools import lru_cache
from itertools import combinations
from random import Random
import argparse


def vertices(mask):
    while mask:
        bit = mask & -mask
        yield bit.bit_length() - 1
        mask ^= bit


def complement(adjacency):
    universe = (1 << len(adjacency)) - 1
    return [universe ^ neighbors ^ (1 << i) for i, neighbors in enumerate(adjacency)]


def from_edges(n, edges):
    graph = [0] * n
    for u, v in edges:
        graph[u] |= 1 << v
        graph[v] |= 1 << u
    return graph


def has_long_hole(graph, minimum):
    """Start at the smallest vertex of a possible induced cycle."""
    def extend(first, path, forbidden, unused):
        tail = path[-1]
        if len(path) > 2:
            forbidden |= graph[path[-2]]
        if len(path) >= minimum - 1:
            if graph[tail] & graph[first] & unused & ~forbidden:
                return True
        next_vertices = graph[tail] & unused & ~forbidden & ~graph[first]
        for nxt in vertices(next_vertices):
            if extend(first, (*path, nxt), forbidden, unused ^ (1 << nxt)):
                return True
        return False

    universe = (1 << len(graph)) - 1
    for first, neighborhood in enumerate(graph):
        greater = universe ^ ((1 << (first + 1)) - 1)
        for nxt in vertices(greater & neighborhood):
            if extend(first, (first, nxt), 0, greater ^ (1 << nxt)):
                return True
    return False


def oriented_conflicts(graph, edges):
    arcs = [arc for u, v in edges for arc in ((u, v), (v, u))]
    conflicts = []
    for i, (c, x) in enumerate(arcs):
        conflicts.append(0)
        for j in range(i):
            d, y = arcs[j]
            if c == d:
                continue
            touches = len({c, x, d, y}) < 4 or (graph[c] | graph[x]) & ((1 << d) | (1 << y))
            if touches:
                conflicts[i] |= 1 << j
                conflicts[j] |= 1 << i
    return arcs, conflicts


def connected_after_deleting_common(graph, active, u, v):
    unseen = active & ~(graph[u] & graph[v]) & ~(1 << u)
    frontier = 1 << u
    while frontier:
        if frontier & (1 << v):
            return True
        reached = 0
        for w in vertices(frontier):
            reached |= graph[w]
        frontier = reached & unseen
        unseen ^= frontier
    return False


def maximum_clique_weakly_chordal(adjacency):
    graph = list(adjacency)
    active = (1 << len(graph)) - 1
    history = []
    while True:
        nonedges = ((u, v) for u, v in combinations(vertices(active), 2) if not graph[u] & (1 << v))
        pair = None
        for u, v in nonedges:
            if not connected_after_deleting_common(graph, active, u, v):
                pair = u, v
                break
        if pair is None:
            assert all(graph[u] & (1 << v) for u, v in combinations(vertices(active), 2))
            clique = active
            break
        u, v = pair
        old_u, old_v = graph[u], graph[v]
        history.append((u, v, old_u, old_v))
        active ^= 1 << v
        graph[u] = (old_u | old_v) & active
        for w in vertices(active & ~(1 << u)):
            graph[w] &= ~(1 << v)
            if graph[u] & (1 << w):
                graph[w] |= 1 << u
    for u, v, old_u, old_v in reversed(history):
        if clique & (1 << u):
            others = clique ^ (1 << u)
            if others & ~old_u:
                assert not (others & ~old_v)
                clique = others | (1 << v)
    return clique


def joins(edge, first, second):
    x, y = edge
    return (x in first and y in second) or (y in first and x in second)


def optimum_by_definition(edges):
    edge_sets = [set(edge) for edge in edges]
    graph = from_edges(len(edges), [
        (i, j) for i, j in combinations(range(len(edges)), 2)
        if any(k not in (i, j) and joins(e, edge_sets[i], edge_sets[j])
               for k, e in enumerate(edge_sets))
    ])

    @lru_cache(None)
    def solve(mask):
        if not mask:
            return 0
        u = (mask & -mask).bit_length() - 1
        remaining = mask ^ (1 << u)
        return max(solve(remaining), 1 + solve(remaining & ~graph[u]))
    return solve((1 << len(edges)) - 1)


def verify(p, q, edges, compare_optimum):
    graph = from_edges(p + q, edges)
    if has_long_hole(graph, 6):
        return False
    arcs, conflict = oriented_conflicts(graph, edges)
    compatible = complement(conflict)
    assert not has_long_hole(conflict, 5)
    assert not has_long_hole(compatible, 5)
    chosen = maximum_clique_weakly_chordal(compatible)
    assert all(compatible[u] & (1 << v) for u, v in combinations(vertices(chosen), 2))
    packing = {tuple(sorted(arcs[i])) for i in vertices(chosen)}
    assert len(packing) == chosen.bit_count()
    assert not any(joins(g, e, f)
                   for e, f in combinations(packing, 2)
                   for g in edges if g not in (e, f))
    if compare_optimum:
        assert len(packing) == optimum_by_definition(edges)
    return True


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--full", action="store_true", help="include all 4-by-4 inputs")
    args = parser.parse_args()
    labelled_counts = []
    sizes = [(2, 2), (2, 3), (3, 3), (3, 4)]
    if args.full:
        sizes.append((4, 4))
    for p, q in sizes:
        options = [(x, y) for x in range(p) for y in range(p, p + q)]
        accepted = sum(
            verify(p, q, [options[i] for i in vertices(mask)], compare_optimum=True)
            for mask in range(1 << len(options))
        )
        labelled_counts.append((p, q, accepted))
    rng = Random(608956)
    random_count = 0
    for _ in range(2000):
        p, q = rng.randrange(4, 9), rng.randrange(4, 9)
        density = rng.random()
        edges = [(x, y) for x in range(p) for y in range(p, p + q) if rng.random() < density]
        random_count += verify(p, q, edges, compare_optimum=len(edges) <= 16)
    print("Exhaustive chordal bipartite labelled inputs:", labelled_counts)
    print("Additional seeded chordal bipartite inputs:", random_count)
    print("No long hole or antihole in the oriented graph; all packing witnesses passed.")


if __name__ == "__main__":
    main()
