#!/usr/bin/env python3
"""Exact finite checks for the chordal-bipartite reduction."""

from itertools import combinations, product
from random import Random


def indices(mask):
    while mask:
        bit = mask & -mask
        yield bit.bit_length() - 1
        mask ^= bit


def adjacency(size, edges):
    neighbors = [0] * size
    for u, v in edges:
        neighbors[u] |= 1 << v
        neighbors[v] |= 1 << u
    return neighbors


def forest(neighbors, mask):
    unseen = mask
    while unseen:
        component_start = (unseen & -unseen).bit_length() - 1
        pending = [(component_start, -1)]
        while pending:
            vertex, parent = pending.pop()
            if not (unseen & (1 << vertex)):
                return False
            unseen ^= 1 << vertex
            pending.extend(
                (other, vertex)
                for other in indices(mask & neighbors[vertex])
                if other != parent
            )
    return True


def maximal(neighbors, edge_masks, mask):
    return forest(neighbors, mask) and all(
        (edge & mask) or not forest(neighbors, mask | edge)
        for edge in edge_masks
    )


def has_long_induced_cycle(neighbors):
    """Find an induced path closing a two-edge segment, in a bipartite graph."""
    full = (1 << len(neighbors)) - 1
    for vertex, neighborhood in enumerate(neighbors):
        for start, end in combinations(indices(neighborhood), 2):
            endpoints = (1 << start) | (1 << end)
            avoid = (1 << vertex) | (neighborhood ^ endpoints)
            avoid |= neighbors[start] & neighbors[end]
            permitted = full & ~avoid
            reached = 1 << start
            frontier = reached
            while frontier:
                new_frontier = 0
                for other in indices(frontier):
                    new_frontier |= neighbors[other]
                frontier = new_frontier & permitted & ~reached
                if frontier & (1 << end):
                    return True
                reached |= frontier
    return False


def independent_domination(neighbors):
    size = len(neighbors)
    for count in range(size + 1):
        for chosen in combinations(range(size), count):
            mask = sum(1 << v for v in chosen)
            if any(mask & neighbors[v] for v in chosen):
                continue
            if all((mask & (1 << v)) or (mask & neighbors[v]) for v in range(size)):
                return chosen
    raise AssertionError("every graph has a maximal independent set")


def transform(left_count, size, source_edges):
    next_vertex = 2 * size
    edges = list(source_edges)
    leaf_edges = [(v, size + v) for v in range(size)]
    edges.extend(leaf_edges)
    shore = [v < left_count for v in range(size)]
    shore.extend(not left for left in list(shore))
    anchor_pairs, modes = [], []
    repetitions = len(source_edges) + size + 1
    for u, v in source_edges:
        a, b = next_vertex, next_vertex + 1
        next_vertex += 2
        shore.extend((not shore[u], not shore[v]))
        anchor_pairs.append((a, b))
        edges.extend(((u, a), (a, b), (b, v)))
        first_x = next_vertex
        second_y = next_vertex + 3
        for _ in range(repetitions):
            x, y = next_vertex, next_vertex + 1
            next_vertex += 2
            shore.extend((not shore[a], not shore[b]))
            edges.extend(((a, x), (x, y), (y, b)))
        # All wing pairs for e are interchangeable. If both anchors
        # separately match wings, they must use distinct wings.
        modes.append([((a, b),)] + [
            ((a, p), (b, q))
            for p, q in product((u, first_x), (v, second_y))
        ])
    assert all(shore[u] != shore[v] for u, v in edges)
    return adjacency(next_vertex, edges), edges, leaf_edges, anchor_pairs, modes


def endpoints(edge):
    u, v = edge
    return (1 << u) | (1 << v)


def direct_full_optimum(neighbors, edge_masks, incumbent):
    """Enumerate arbitrary matchings, including those with unsaturated anchors."""
    best = incumbent

    def visit(available, chosen, count):
        nonlocal best
        if count >= best:
            return
        if not available:
            if maximal(neighbors, edge_masks, chosen):
                best = count
            return
        bit = available & -available
        available ^= bit
        vertex = bit.bit_length() - 1
        visit(available, chosen, count)
        for other in indices(neighbors[vertex] & available):
            other_bit = 1 << other
            larger = chosen | bit | other_bit
            if forest(neighbors, larger):
                visit(available ^ other_bit, larger, count + 1)

    visit((1 << len(neighbors)) - 1, 0, 0)
    return best


def anchored_optimum(neighbors, edge_masks, leaf_edges, modes, incumbent):
    """Enumerate all anchor-saturating candidates up to wing-pair permutations."""
    leaf_masks = [endpoints(edge) for edge in leaf_edges]
    option_masks = [
        [(len(option), sum(endpoints(edge) for edge in option)) for option in group]
        for group in modes
    ]
    best = incumbent

    def add_leaves(next_leaf, chosen, count):
        nonlocal best
        if count >= best:
            return
        if next_leaf == len(leaf_masks):
            if maximal(neighbors, edge_masks, chosen):
                best = count
            return
        add_leaves(next_leaf + 1, chosen, count)
        mask = leaf_masks[next_leaf]
        if not mask & chosen:
            add_leaves(next_leaf + 1, chosen | mask, count + 1)

    def choose_anchors(next_group, chosen, count):
        if count + len(modes) - next_group >= best:
            return
        if next_group == len(modes):
            add_leaves(0, chosen, count)
            return
        for cost, mode in option_masks[next_group]:
            if not (chosen & mode) and forest(neighbors, chosen | mode):
                choose_anchors(next_group + 1, chosen | mode, count + cost)

    choose_anchors(0, 0, 0)
    return best


def certify(left, right, source_edges, *, full_check=False):
    size = left + right
    source = adjacency(size, source_edges)
    if has_long_induced_cycle(source):
        return False

    neighbors, edges, leaves, anchors, modes = transform(left, size, source_edges)
    assert not has_long_induced_cycle(neighbors)
    edge_masks = [endpoints(edge) for edge in edges]
    chosen = independent_domination(source)
    expected = len(anchors) + len(chosen)
    witness = anchors + [leaves[v] for v in chosen]
    witness_mask = sum(endpoints(edge) for edge in witness)
    assert witness_mask.bit_count() == 2 * expected
    assert maximal(neighbors, edge_masks, witness_mask)
    actual = anchored_optimum(neighbors, edge_masks, leaves, modes, expected)
    assert actual == expected, (left, right, source_edges)
    if full_check:
        assert direct_full_optimum(neighbors, edge_masks, expected) == expected
    return True


def main():
    tested = unrestricted = 0
    for left, right in ((0, 0), (0, 2), (1, 1), (1, 2), (2, 2), (2, 3)):
        candidates = tuple(product(range(left), range(left, left + right)))
        for mask in range(1 << len(candidates)):
            source = [edge for i, edge in enumerate(candidates) if mask & (1 << i)]
            full_check = left + right <= 3
            tested += certify(left, right, source, full_check=full_check)
            unrestricted += full_check
    print(f"exhaustive bipartite sources: {tested}; full unrestricted matching searches: {unrestricted}", flush=True)

    rng = Random(862331)
    checked = rejected = 0
    for _ in range(120):
        left, right = 3, 3
        candidates = tuple(product(range(left), range(left, left + right)))
        probability = rng.choice((0.25, 0.45, 0.6, 0.85))
        source = [edge for edge in candidates if rng.random() < probability]
        if certify(left, right, source):
            checked += 1
        else:
            rejected += 1
    print(f"seeded chordal bipartite sources: {checked}; excluded nonchordal sources: {rejected}")


if __name__ == "__main__":
    main()
