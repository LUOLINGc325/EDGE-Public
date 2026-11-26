#!/usr/bin/env python3
"""Finite exact tests of the compressed cut and triangulation correspondence."""

from collections import deque
from itertools import combinations, permutations
from random import Random


def doubled_lex_order(matrix, columns):
    """Small-oracle ordering. The production theorem uses Spinrad's algorithm."""
    for rows in permutations(range(len(matrix))):
        sorted_columns = sorted(
            range(columns), key=lambda y: tuple(matrix[x][y] for x in reversed(rows))
        )
        ordered = [tuple(matrix[x][y] for y in sorted_columns) for x in rows]
        reverse_rows = [row[::-1] for row in ordered]
        if reverse_rows == sorted(reverse_rows):
            return ordered
    raise AssertionError("no row-and-column lexicographic order")


def first_neighbor(vertices, predicate):
    low, high = 0, len(vertices)
    while low < high:
        middle = (low + high) // 2
        if predicate(vertices[middle]):
            high = middle
        else:
            low = middle + 1
    return vertices[low] if low < len(vertices) else None


def compressed_network(matrix, columns):
    row_neighbors = [tuple(y for y, value in enumerate(row) if value) for row in matrix]
    col_neighbors = [tuple(x for x in range(len(matrix)) if matrix[x][y]) for y in range(columns)]
    left_pairs = list(combinations(range(len(matrix)), 2))
    right_pairs = list(combinations(range(columns), 2))
    left = {(i, j): index for index, (i, j) in enumerate(left_pairs)}
    right = {(a, b): len(left) + index for index, (a, b) in enumerate(right_pairs)}
    next_vertex = len(left) + len(right)
    row_nodes, col_nodes, arcs = {}, {}, []
    for i, selected in enumerate(row_neighbors):
        for a in selected:
            row_nodes[i, a] = next_vertex
            col_nodes[i, a] = next_vertex + 1
            arcs.append((next_vertex, next_vertex + 1))
            next_vertex += 2
    for i, selected in enumerate(row_neighbors):
        for a, b in zip(selected, selected[1:]):
            arcs.append((row_nodes[i, a], row_nodes[i, b]))
    for a, selected in enumerate(col_neighbors):
        for i, j in zip(selected, selected[1:]):
            arcs.append((col_nodes[j, a], col_nodes[i, a]))
    for (i, j), node in left.items():
        first = first_neighbor(row_neighbors[i], lambda a: matrix[j][a])
        if first is not None:
            arcs.append((node, row_nodes[i, first]))
    for (a, b), node in right.items():
        first = first_neighbor(col_neighbors[a], lambda i: matrix[i][b])
        if first is not None:
            arcs.append((col_nodes[first, a], node))
    return left, right, arcs, next_vertex


def min_cover(left, right, arcs, size):
    """Edmonds--Karp on finite tests; the manuscript uses a faster max-flow solver."""
    source, sink = size, size + 1
    residual = [{} for _ in range(size + 2)]

    def arc(u, v, capacity):
        residual[u][v] = capacity
        residual[v][u] = 0

    forbid = len(left) + len(right) + 1
    for u, v in arcs:
        arc(u, v, forbid)
    for u in left.values():
        arc(source, u, 1)
    for v in right.values():
        arc(v, sink, 1)

    while True:
        previous = {source: source}
        queue = deque([source])
        while queue and sink not in previous:
            u = queue.popleft()
            for v, capacity in residual[u].items():
                if capacity and v not in previous:
                    previous[v] = u
                    queue.append(v)
        if sink not in previous:
            break
        v = sink
        while v != source:
            u = previous[v]
            residual[u][v] -= 1
            residual[v][u] += 1
            v = u

    return {node for node in left.values() if node not in previous} | {
        node for node in right.values() if node in previous
    }


def graph(size, edges):
    neighbors = [set() for _ in range(size)]
    for u, v in edges:
        neighbors[u].add(v)
        neighbors[v].add(u)
    return neighbors


def connected(neighbors, vertices):
    root = next(iter(vertices))
    seen = {root}
    stack = [root]
    while stack:
        fresh = (neighbors[stack.pop()] & vertices) - seen
        seen.update(fresh)
        stack.extend(fresh)
    return seen == vertices


def chordal_bipartite(size, edges):
    neighbors = graph(size, edges)
    for cardinality in range(6, size + 1, 2):
        for selected in combinations(range(size), cardinality):
            vertices = set(selected)
            if all(len(neighbors[u] & vertices) == 2 for u in vertices):
                if connected(neighbors, vertices):
                    return False
    return True


def chordal(size, edges):
    """Maximum-cardinality search followed by direct ordering verification."""
    neighbors = graph(size, edges)
    labels = [0] * size
    remaining = set(range(size))
    while remaining:
        u = max(remaining, key=lambda v: (labels[v], v))
        already_selected = neighbors[u] - remaining
        if any(v not in neighbors[w] for v, w in combinations(already_selected, 2)):
            return False
        remaining.remove(u)
        for v in neighbors[u] & remaining:
            labels[v] += 1
    return True


def check(matrix, columns):
    rows = len(matrix)
    size = rows + columns

    def original_edges(entries):
        return {(x, rows + y) for x, row in enumerate(entries) for y, value in enumerate(row) if value}

    if not chordal_bipartite(size, original_edges(matrix)):
        return False

    matrix = doubled_lex_order(matrix, columns)
    edges = original_edges(matrix)
    left, right, arcs, nodes = compressed_network(matrix, columns)
    outgoing = [set() for _ in range(nodes)]
    for u, v in arcs:
        outgoing[u].add(v)
    pair_graph = set()
    for (i, j), left_node in left.items():
        seen = {left_node}
        pending = [left_node]
        while pending:
            fresh = outgoing[pending.pop()] - seen
            seen.update(fresh)
            pending.extend(fresh)
        for (a, b), right_node in right.items():
            square = all((matrix[i][a], matrix[i][b], matrix[j][a], matrix[j][b]))
            assert (right_node in seen) == square
            if square:
                pair_graph.add((left_node, right_node))

    by_node = {node: pair for pair, node in left.items()}
    by_node.update({node: (rows + a, rows + b) for (a, b), node in right.items()})
    cover = min_cover(left, right, arcs, nodes)
    assert all(u in cover or v in cover for u, v in pair_graph)
    fill = {by_node[node] for node in cover}
    assert chordal(size, edges | fill)

    missing = list(set(combinations(range(size), 2)) - edges)
    # Check all smaller completions, allowing fill edges that cross the source shores.
    for cardinality in range(len(fill)):
        assert all(
            not chordal(size, edges.union(candidate))
            for candidate in combinations(missing, cardinality)
        )

    if size <= 5:
        minimal_covers = set()
        for count in range(len(by_node) + 1):
            for chosen in combinations(by_node, count):
                subset = frozenset(chosen)
                if all(u in subset or v in subset for u, v in pair_graph):
                    if all(any((u == f and v not in subset) or (v == f and u not in subset)
                               for u, v in pair_graph) for f in subset):
                        minimal_covers.add(frozenset(by_node[f] for f in subset))
        minimal_fills = set()
        for count in range(len(missing) + 1):
            for candidate in combinations(missing, count):
                subset = frozenset(candidate)
                if any(previous <= subset for previous in minimal_fills):
                    continue
                if chordal(size, edges | subset):
                    minimal_fills.add(subset)
        assert minimal_covers == minimal_fills

    return True


def main():
    extensive = 0
    for rows, columns in ((0, 0), (0, 3), (1, 3), (2, 2), (2, 3), (3, 3)):
        for mask in range(1 << (rows * columns)):
            matrix = [[(mask >> (i * columns + a)) & 1 for a in range(columns)] for i in range(rows)]
            extensive += check(matrix, columns)
    print(f"exhaustive chordal bipartite matrices: {extensive} passed", flush=True)

    rng = Random(19760328)
    retained = 0
    for _ in range(180):
        rows, columns = (rng.randint(2, 4) for _ in range(2))
        density = rng.choice((0.2, 0.5, 0.7, 0.85))
        matrix = [[int(rng.random() < density) for _ in range(columns)] for _ in range(rows)]
        retained += check(matrix, columns)
    print(f"seeded inputs: {retained} chordal bipartite passed; {180 - retained} nonchordal inputs excluded")


if __name__ == "__main__":
    main()
