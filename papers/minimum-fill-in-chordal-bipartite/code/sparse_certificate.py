#!/usr/bin/env python3
"""Verify the sparse grouped cut against the earlier explicit-pair cut."""

from bisect import bisect_left
from collections import deque
from random import Random

from certificate import chordal, chordal_bipartite, compressed_network, doubled_lex_order, min_cover


def groups(primary, secondary):
    """Map a first endpoint and its current neighbor to previous neighbor and weight."""
    suffix_sizes = {}
    for other, neighbors in enumerate(secondary):
        for rank, vertex in enumerate(neighbors):
            suffix_sizes[vertex, other] = len(neighbors) - rank - 1

    result = {}
    for vertex, neighbors in enumerate(primary):
        previous_neighbor, previous_size = None, 0
        for other in neighbors:
            current_size = suffix_sizes[vertex, other]
            weight = current_size - previous_size
            assert weight >= 0
            result[vertex, other] = previous_neighbor, weight
            previous_neighbor, previous_size = other, current_size
    return result


def nested_difference(larger, smaller, low, high):
    """Emit ordered identifiers in the nested difference within [low, high)."""
    if low == high:
        return
    work = [(low, high)]
    while work:
        start, end = work.pop()
        large_count = bisect_left(larger, end) - bisect_left(larger, start)
        small_count = bisect_left(smaller, end) - bisect_left(smaller, start)
        count = large_count - small_count
        assert count >= 0
        if count == 0:
            continue
        if start + 1 == end:
            yield start
        else:
            middle = (start + end) // 2
            work.extend(((middle, end), (start, middle)))


def residual_source_side(arcs, size, source, sink):
    """Edmonds–Karp for small reference instances, with integer bottlenecks."""
    residual = [dict() for _ in range(size)]
    for u, v, capacity in arcs:
        assert v not in residual[u]
        residual[u][v] = capacity
        residual[v][u] = 0
    while True:
        previous = {source: source}
        queue = deque([source])
        while queue and sink not in previous:
            u = queue.popleft()
            for v, capacity in residual[u].items():
                if capacity > 0 and v not in previous:
                    previous[v] = u
                    queue.append(v)
        if sink not in previous:
            return set(previous)
        v = sink
        path = []
        while v != source:
            u = previous[v]
            path.append((u, v))
            v = u
        amount = min(residual[u][v] for u, v in path)
        for u, v in path:
            residual[u][v] -= amount
            residual[v][u] += amount


def grouped_fill(rows, columns, edges):
    """Compute a fill from Γ-free, ordered adjacency lists."""
    if not edges:
        return set()

    row_neighbors = [[] for _ in range(rows)]
    col_neighbors = [[] for _ in range(columns)]
    for i, a in sorted(edges):
        row_neighbors[i].append(a)
        col_neighbors[a].append(i)

    left_groups = groups(row_neighbors, col_neighbors)
    right_groups = groups(col_neighbors, row_neighbors)
    row_nodes, col_nodes = {}, {}
    for index, (i, a) in enumerate(edges):
        row_nodes[i, a] = 2 * index
        col_nodes[i, a] = 2 * index + 1
    source, sink = 2 * len(edges), 2 * len(edges) + 1
    total_weight = sum(weight for _, weight in left_groups.values()) + sum(
        weight for _, weight in right_groups.values()
    )
    capacity = total_weight + 1
    arcs = [(row_nodes[i, a], col_nodes[i, a], capacity) for i, a in edges]
    for i, neighbors in enumerate(row_neighbors):
        for a, b in zip(neighbors, neighbors[1:]):
            arcs.append((row_nodes[i, a], row_nodes[i, b], capacity))
    for a, neighbors in enumerate(col_neighbors):
        for i, j in zip(neighbors, neighbors[1:]):
            arcs.append((col_nodes[j, a], col_nodes[i, a], capacity))
    for (i, a), (_, weight) in left_groups.items():
        if weight:
            arcs.append((source, row_nodes[i, a], weight))
    for (a, i), (_, weight) in right_groups.items():
        if weight:
            arcs.append((col_nodes[i, a], sink, weight))

    assert len(arcs) <= 5 * len(edges)
    reachable = residual_source_side(arcs, sink + 1, source, sink)
    cut = sum(weight for u, v, weight in arcs if u in reachable and v not in reachable)
    assert cut < capacity
    fill = set()
    for (i, a), (prior, weight) in left_groups.items():
        if weight and row_nodes[i, a] not in reachable:
            smaller = col_neighbors[prior] if prior is not None else ()
            selected = [(i, j) for j in nested_difference(col_neighbors[a], smaller, i + 1, rows)]
            assert len(selected) == weight
            fill.update(selected)
    for (a, i), (prior, weight) in right_groups.items():
        if weight and col_nodes[i, a] in reachable:
            smaller = row_neighbors[prior] if prior is not None else ()
            selected = [
                (rows + a, rows + b)
                for b in nested_difference(row_neighbors[i], smaller, a + 1, columns)
            ]
            assert len(selected) == weight
            fill.update(selected)
    assert len(fill) == cut
    return fill


def check(matrix, columns):
    rows = len(matrix)
    if not chordal_bipartite(
        rows + columns, [(i, rows + a) for i, row in enumerate(matrix) for a, value in enumerate(row) if value]
    ):
        return False

    matrix = doubled_lex_order(matrix, columns)
    edges = [(i, a) for i, row in enumerate(matrix) for a, value in enumerate(row) if value]
    fill = grouped_fill(rows, columns, edges)
    left, right, arcs, nodes = compressed_network(matrix, columns)
    prior_cover = min_cover(left, right, arcs, nodes)
    assert len(fill) == len(prior_cover)
    assert chordal(rows + columns, {(i, rows + a) for i, a in edges} | fill)
    return True


def main():
    tested = 0
    for rows, columns in ((0, 0), (0, 3), (1, 3), (2, 2), (2, 3), (3, 3)):
        for mask in range(1 << (rows * columns)):
            matrix = [[(mask >> (i * columns + a)) & 1 for a in range(columns)] for i in range(rows)]
            tested += check(matrix, columns)
    print(f"weighted grouped cut agrees on {tested} exhaustive chordal bipartite cases")

    rng = Random(19760328)
    seeded = 0
    for _ in range(180):
        rows, columns = (rng.randint(2, 4) for _ in range(2))
        density = rng.choice((0.2, 0.5, 0.7, 0.85))
        matrix = [[int(rng.random() < density) for _ in range(columns)] for _ in range(rows)]
        seeded += check(matrix, columns)
    print(f"weighted grouped cut agrees on {seeded} seeded chordal bipartite cases")

    for rows, columns in ((257, 2), (2, 257), (257, 1), (1, 257), (48, 48)):
        edges = [(i, a) for i in range(rows) for a in range(columns)]
        expected = min(rows * (rows - 1), columns * (columns - 1)) // 2
        assert len(grouped_fill(rows, columns, edges)) == expected
    assert len(grouped_fill(400, 400, [(398, 398), (398, 399), (399, 398), (399, 399)])) == 1
    print("sparse, output-heavy, and isolated-vertex regressions: 6 passed")


if __name__ == "__main__":
    main()
