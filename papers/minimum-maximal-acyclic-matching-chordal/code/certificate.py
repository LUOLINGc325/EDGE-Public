#!/usr/bin/env python3
"""Exact finite checks for the chordal reduction and interval optimizer."""

from itertools import combinations, combinations_with_replacement, product
from math import inf
from random import Random


def graph_edges(intervals):
    return [
        (u, v)
        for u, v in combinations(range(len(intervals)), 2)
        if max(intervals[u][0], intervals[v][0])
        <= min(intervals[u][1], intervals[v][1])
    ]


def interval_optimum(intervals, edges):
    """Range-gap optimizer, with the graph edge list and its interval model."""
    order = sorted(intervals)
    spans = []
    for u, v in edges:
        left_u, right_u = intervals[u]
        left_v, right_v = intervals[v]
        spans.append(
            (max(left_u, left_v), min(right_u, right_v),
             min(left_u, left_v), max(right_u, right_v), (u, v))
        )
    spans.sort()
    nodes = [(-inf, -inf, -inf, -inf, None), *spans, (inf, inf, inf, inf, None)]
    previous = [-1] * len(nodes)
    distance = [0] + [inf] * (len(nodes) - 1)

    def closed_gap(left_core, right_core, left_cover, right_cover):
        if left_cover >= right_cover:
            return True
        prior_right = -inf
        prior_right_in_gap = -inf
        for left, right in order:
            if not (left_core < left and right < right_core):
                continue
            if left_cover < left < right_cover:
                eligible_prior = prior_right if right < right_cover else prior_right_in_gap
                if eligible_prior >= left:
                    return False
            prior_right = max(prior_right, right)
            if right < right_cover:
                prior_right_in_gap = max(prior_right_in_gap, right)
        return True

    for current in range(1, len(nodes)):
        right_core, _, right_cover, _, edge = nodes[current]
        cost = int(edge is not None)
        for source in range(current):
            _, left_core, _, left_cover, _ = nodes[source]
            if distance[source] + cost >= distance[current]:
                continue
            if not (left_cover < right_core and left_core < right_cover):
                continue
            if closed_gap(left_core, right_core, left_cover, right_cover):
                distance[current] = distance[source] + cost
                previous[current] = source

    match = []
    current = previous[-1]
    assert current >= 0
    while current:
        match.append(nodes[current][-1])
        current = previous[current]
    return match[::-1]


def bit_indices(mask):
    while mask:
        bit = mask & -mask
        yield bit.bit_length() - 1
        mask ^= bit


def neighbor_masks(size, edges):
    neighbors = [0] * size
    for u, v in edges:
        neighbors[u] |= 1 << v
        neighbors[v] |= 1 << u
    return neighbors


def saturated_vertices(matching):
    mask = 0
    for u, v in matching:
        endpoints = (1 << u) | (1 << v)
        assert not mask & endpoints
        mask |= endpoints
    return mask


def forest(neighbors, mask):
    """Independent cycle test by DFS of the induced subgraph."""
    unseen = mask
    while unseen:
        root = (unseen & -unseen).bit_length() - 1
        pending = [(root, -1)]
        while pending:
            vertex, parent = pending.pop()
            if not (unseen & (1 << vertex)):
                return False
            unseen ^= 1 << vertex
            pending.extend(
                (other, vertex)
                for other in bit_indices(mask & neighbors[vertex])
                if other != parent
            )
    return True


def maximal(neighbors, edges, matching):
    mask = saturated_vertices(matching)
    if not forest(neighbors, mask):
        return False
    for u, v in edges:
        endpoints = (1 << u) | (1 << v)
        if not (mask & endpoints) and forest(neighbors, mask | endpoints):
            return False
    return True


def brute_interval_optimum(size, neighbors, edges):
    adjacency = [tuple(bit_indices(mask)) for mask in neighbors]
    minimum = size + 1

    def visit(available, matched, count):
        nonlocal minimum
        if count >= minimum:
            return
        if not available:
            if all(
                matched & ((1 << u) | (1 << v))
                or not forest(neighbors, matched | (1 << u) | (1 << v))
                for u, v in edges
            ):
                minimum = count
            return
        bit = available & -available
        available ^= bit
        vertex = bit.bit_length() - 1
        visit(available, matched, count)
        for other in adjacency[vertex]:
            other_bit = 1 << other
            if available & other_bit:
                new = matched | bit | other_bit
                if forest(neighbors, new):
                    visit(available ^ other_bit, new, count + 1)

    visit((1 << size) - 1, 0, 0)
    return minimum


def reduce_formula(variable_count, clauses):
    next_vertex = 0
    edges = set()

    def vertex():
        nonlocal next_vertex
        next_vertex += 1
        return next_vertex - 1

    def edge(u, v):
        edges.add((min(u, v), max(u, v)))

    core = [vertex() for _ in clauses]
    private_leaves = [vertex() for _ in clauses]
    for u, v in combinations(core, 2):
        edge(u, v)
    for u, v in zip(core, private_leaves):
        edge(u, v)

    anchors, markers, selectors, wings, choices = [], [], [], [], []
    for variable in range(1, variable_count + 1):
        f, fp, fm = (vertex() for _ in range(3))
        wp, wm, ap, am = (vertex() for _ in range(4))
        anchors.extend((f, fp, fm))
        markers.extend((ap, am))
        selectors.extend((wp, wm))
        edge(wp, wm)
        edge(f, wp)
        edge(f, wm)
        edge(ap, wp)
        edge(am, wm)
        edge(fp, ap)
        edge(fm, am)
        for c, clause in zip(core, clauses):
            if variable in clause or -variable in clause:
                edge(c, wp)
                edge(c, wm)
            if variable in clause:
                edge(c, ap)
            if -variable in clause:
                edge(c, am)
        for anchor, partners in ((f, (wp, wm)), (fp, (ap,)), (fm, (am,))):
            first_wing = next_vertex
            for _ in range(3 * variable_count + 1):
                a, b = vertex(), vertex()
                wings.extend((a, b))
                edge(anchor, a)
                edge(anchor, b)
                edge(a, b)
            choices.append(tuple((anchor, p) for p in (*partners, first_wing)))

    return next_vertex, sorted(edges), private_leaves + wings + anchors + markers + selectors + core, choices


def check_formula(variable_count, clauses):
    size, edges, elimination, choices = reduce_formula(variable_count, clauses)
    neighbors = neighbor_masks(size, edges)
    remaining = (1 << size) - 1
    for v in elimination:
        later = neighbors[v] & remaining
        assert all((later ^ (1 << u)) & ~neighbors[u] == 0 for u in bit_indices(later))
        remaining ^= 1 << v
    assert remaining == 0

    exact_sat = any(
        all(any(values[abs(lit) - 1] == (lit > 0) for lit in clause) for clause in clauses)
        for values in product((False, True), repeat=variable_count)
    )
    # The forcing lemma requires every anchor. Its private wing vertices are
    # interchangeable by automorphism, so keep just one wing partner per anchor.
    exists = any(maximal(neighbors, edges, match) for match in product(*choices))
    assert exists == exact_sat, (variable_count, clauses)
    return exact_sat


def check_intervals(intervals):
    edges = graph_edges(intervals)
    neighbors = neighbor_masks(len(intervals), edges)
    matching = interval_optimum(intervals, edges)
    assert len(matching) == brute_interval_optimum(len(intervals), neighbors, edges), intervals
    assert all(edge in edges for edge in matching)
    assert maximal(neighbors, edges, matching), intervals


def main():
    rng = Random(711947)
    exhaustive_intervals = 0
    types = tuple(combinations_with_replacement(range(4), 2))
    for n in range(7):
        for intervals in combinations_with_replacement(types, n):
            check_intervals(intervals)
            exhaustive_intervals += 1
    for _ in range(550):
        intervals = [tuple(sorted(rng.choices(range(12), k=2))) for _ in range(rng.randint(0, 9))]
        rng.shuffle(intervals)
        check_intervals(intervals)
    print(f"interval representations: {exhaustive_intervals} exhaustive + 550 seeded passed", flush=True)

    sat_count = 0
    clause_types = [(1,), (-1,), (2,), (-2,), (1, 2), (1, -2), (-1, 2), (-1, -2)]
    for subset in range(1 << len(clause_types)):
        clauses = [clause for i, clause in enumerate(clause_types) if (1 << i) & subset]
        sat_count += check_formula(2, clauses)
    for _ in range(120):
        clauses = [
            tuple(rng.sample((-3, -2, -1, 1, 2, 3), rng.randint(1, 3)))
            for _ in range(rng.randint(1, 12))
        ]
        sat_count += check_formula(3, clauses)
    print(f"chordal reductions: 256 exhaustive + 120 seeded passed; {sat_count} satisfiable cases")


if __name__ == "__main__":
    main()
