#!/usr/bin/env python3
"""Construct bounded-hop independent-set reconfiguration sequences.

Only the Python standard library is required.  The theorem applies to connected
simple graphs for which the subgraph induced by the symmetric difference of the
two endpoint independent sets is a forest; in particular it applies to every
connected even-hole-free graph.  This program checks the weaker, endpoint-based
condition, and does not attempt even-hole-free graph recognition.

The returned integer dual potentials independently certify both assignment
optima.  The movement sequence is an actual sequence of feasible k-jumps.
"""

from __future__ import annotations

import argparse
from collections import deque
import json
from pathlib import Path
from typing import Iterable, Sequence


def exchange_bound(distance: int, k: int) -> int:
    """Upper bound for one valid TJ exchange; distance must be positive."""
    if distance < 1 or k < 3:
        raise ValueError("exchange_bound requires distance >= 1 and k >= 3")
    return max(1, (distance - 2 + k - 3) // (k - 2))


def approximation_factor(k: int) -> tuple[int, int]:
    if k < 3:
        raise ValueError("k must be at least 3")
    if k == 3:
        return 3, 1
    if k == 4:
        return 2, 1
    if k == 5:
        return 5, 3
    return 3, 2


def hungarian(cost: Sequence[Sequence[int]]) -> tuple[list[int], list[int], list[int]]:
    """Minimum square assignment with integral row and column dual potentials.

    Returns (column_for_row, row_potential, column_potential).  The potentials
    satisfy u[i] + v[j] <= cost[i][j], with equality on the returned matching.
    """
    n = len(cost)
    if any(len(row) != n for row in cost):
        raise ValueError("assignment matrix must be square")
    if n == 0:
        return [], [], []
    if any(not isinstance(value, int) for row in cost for value in row):
        raise ValueError("assignment costs must be integers")
    u = [0] * (n + 1)
    v = [0] * (n + 1)
    p = [0] * (n + 1)
    way = [0] * (n + 1)
    infinity = (n + 1) * (1 + max(abs(value) for row in cost for value in row))
    for i in range(1, n + 1):
        p[0] = i
        minv = [infinity] * (n + 1)
        used = [False] * (n + 1)
        j0 = 0
        while True:
            used[j0] = True
            i0 = p[j0]
            delta = infinity
            j1 = 0
            for j in range(1, n + 1):
                if not used[j]:
                    current = cost[i0 - 1][j - 1] - u[i0] - v[j]
                    if current < minv[j]:
                        minv[j] = current
                        way[j] = j0
                    if minv[j] < delta:
                        delta = minv[j]
                        j1 = j
            if j1 == 0:
                raise RuntimeError("assignment augmentation failed")
            for j in range(n + 1):
                if used[j]:
                    u[p[j]] += delta
                    v[j] -= delta
                else:
                    minv[j] -= delta
            j0 = j1
            if p[j0] == 0:
                break
        while True:
            j1 = way[j0]
            p[j0] = p[j1]
            j0 = j1
            if j0 == 0:
                break
    matching = [-1] * n
    for j in range(1, n + 1):
        matching[p[j] - 1] = j - 1
    return matching, u[1:], v[1:]


def _validated_graph(adjacency: Sequence[Iterable[int]]) -> tuple[list[list[int]], list[int]]:
    n = len(adjacency)
    if n == 0:
        raise ValueError("the graph must have at least one vertex")
    graph: list[list[int]] = []
    for i, neighbors in enumerate(adjacency):
        values = set(neighbors)
        if any(type(j) is not int or j < 0 or j >= n or j == i for j in values):
            raise ValueError("the graph must be simple and use vertices 0,...,n-1")
        graph.append(sorted(values))
    masks = [sum(1 << j for j in row) for row in graph]
    for i, row in enumerate(graph):
        if any(not (masks[j] >> i) & 1 for j in row):
            raise ValueError("the adjacency relation must be symmetric")
    return graph, masks


def _distances(graph: Sequence[Sequence[int]]) -> list[list[int]]:
    n = len(graph)
    distance: list[list[int]] = []
    for source in range(n):
        row = [-1] * n
        row[source] = 0
        queue = deque([source])
        while queue:
            u = queue.popleft()
            for v in graph[u]:
                if row[v] < 0:
                    row[v] = row[u] + 1
                    queue.append(v)
        if -1 in row:
            raise ValueError("the graph must be connected")
        distance.append(row)
    return distance


def _independent(vertices: set[int], masks: Sequence[int]) -> bool:
    occupied = sum(1 << v for v in vertices)
    return all(not (masks[v] & occupied) for v in vertices)


def _forest_on(vertices: set[int], graph: Sequence[Sequence[int]]) -> bool:
    parent = {v: v for v in vertices}

    def root(v: int) -> int:
        while parent[v] != v:
            parent[v] = parent[parent[v]]
            v = parent[v]
        return v

    for u in sorted(vertices):
        for v in graph[u]:
            if v in vertices and u < v:
                x, y = root(u), root(v)
                if x == y:
                    return False
                parent[x] = y
    return True


def solve(adjacency: Sequence[Iterable[int]], source: Iterable[int],
          target: Iterable[int], k: int) -> dict:
    """Return a feasible sequence, assignment bounds and integer certificates.

    Raises ValueError if an input assumption is violated.  Vertex names are
    integers 0,...,n-1, and adjacency is an undirected simple adjacency list.
    The output includes ``moves``, ``length``, ``lower_bound`` (W),
    ``assignment_upper_bound`` (U), and ``execution_order``.  ``matching`` is
    the upper assignment; both it and the lower assignment have exact dual
    certificates.  No floating-point arithmetic is used.
    """
    if type(k) is not int or k < 3:
        raise ValueError("k must be an integer at least 3")
    graph, masks = _validated_graph(adjacency)
    n = len(graph)
    initial, goal = set(source), set(target)
    if any(type(v) is not int or v < 0 or v >= n for v in initial | goal):
        raise ValueError("invalid endpoint vertex")
    if len(initial) != len(goal):
        raise ValueError("the endpoint independent sets must have equal cardinality")
    if not _independent(initial, masks) or not _independent(goal, masks):
        raise ValueError("both endpoint sets must be independent")
    sources = sorted(initial - goal)
    targets = sorted(goal - initial)
    if not _forest_on(set(sources + targets), graph):
        raise ValueError("the subgraph induced by the symmetric difference must be a forest")
    distance = _distances(graph)
    r = len(sources)
    lower_cost = [[(distance[s][t] + k - 1) // k for t in targets] for s in sources]
    upper_cost = [[exchange_bound(distance[s][t], k) for t in targets] for s in sources]
    multiplier = r + 1
    lex_cost = [[multiplier * upper_cost[i][j] - int(distance[sources[i]][targets[j]] == 1)
                 for j in range(r)] for i in range(r)]
    lower_match, lower_rows, lower_columns = hungarian(lower_cost)
    upper_match, upper_rows, upper_columns = hungarian(lex_cost)
    lower_bound = sum(lower_cost[i][lower_match[i]] for i in range(r))
    upper_bound = sum(upper_cost[i][upper_match[i]] for i in range(r))
    matched_targets = [targets[upper_match[i]] for i in range(r)]

    # A dependency i -> j says that source i must vacate before target j is filled.
    outgoing = [[] for _ in range(r)]
    indegree = [0] * r
    for i in range(r):
        for j in range(r):
            if i != j and distance[sources[i]][matched_targets[j]] == 1:
                outgoing[i].append(j)
                indegree[j] += 1
    queue = deque(i for i in range(r) if indegree[i] == 0)
    order: list[int] = []
    while queue:
        i = queue.popleft()
        order.append(i)
        for j in outgoing[i]:
            indegree[j] -= 1
            if indegree[j] == 0:
                queue.append(j)
    if len(order) != r:
        raise RuntimeError("an optimal assignment unexpectedly has a dependency cycle")

    occupied = sum(1 << v for v in initial)
    moves: list[list[int]] = []

    def move(u: int, v: int) -> None:
        nonlocal occupied
        if not (occupied >> u) & 1 or (occupied >> v) & 1:
            raise RuntimeError("invalid move occupancy")
        if not 1 <= distance[u][v] <= k:
            raise RuntimeError("a reported move exceeds the hop bound")
        without_u = occupied ^ (1 << u)
        if masks[v] & without_u:
            raise RuntimeError("a reported move violates independence")
        occupied = without_u | (1 << v)
        moves.append([u, v])

    for index in order:
        s, t = sources[index], matched_targets[index]
        before = occupied
        before_length = len(moves)
        # Explicit stack avoids a recursion limit on long graphs.
        tasks = [("exchange", s, t)]
        while tasks:
            kind, u, v = tasks.pop()
            if kind == "move":
                move(u, v)
                continue
            d = distance[u][v]
            if d <= k:
                move(u, v)
                continue
            offset = d - k + 1
            x = next(w for w in range(n)
                     if distance[u][w] == offset and distance[w][v] == k - 1)
            blockers = masks[x] & occupied
            if not (occupied >> x) & 1 and not blockers:
                tasks.append(("move", x, v))
                tasks.append(("exchange", u, x))
            else:
                z = x if (occupied >> x) & 1 else (blockers & -blockers).bit_length() - 1
                move(z, v)
                tasks.append(("exchange", u, z))
        expected = (before ^ (1 << s)) | (1 << t)
        if occupied != expected:
            raise RuntimeError("the local simulation failed to restore the other occupancies")
        if len(moves) - before_length > exchange_bound(distance[s][t], k):
            raise RuntimeError("the local exchange bound was exceeded")

    expected_goal = sum(1 << v for v in goal)
    if occupied != expected_goal:
        raise RuntimeError("the final configuration differs from the requested target")
    numerator, denominator = approximation_factor(k)
    if len(moves) > upper_bound or denominator * upper_bound > numerator * lower_bound:
        raise RuntimeError("the proved approximation bounds were violated")

    return {
        "algorithm": "bounded-hop forest-difference assignment, version 1",
        "n": n,
        "k": k,
        "source": sorted(initial),
        "target": sorted(goal),
        "sources_only": sources,
        "targets_only": targets,
        "differences_forest": True,
        "lower_bound": lower_bound,
        "assignment_upper_bound": upper_bound,
        "matching": [[sources[i], matched_targets[i]] for i in range(r)],
        "execution_order": order,
        "moves": moves,
        "length": len(moves),
        "factor_numerator": numerator,
        "factor_denominator": denominator,
        "lower_certificate": {
            "column_for_row": lower_match,
            "row_potential": lower_rows,
            "column_potential": lower_columns,
            "optimal_value": lower_bound,
        },
        "upper_certificate": {
            "column_for_row": upper_match,
            "row_potential": upper_rows,
            "column_potential": upper_columns,
            "lex_multiplier": multiplier,
            "optimal_lex_value": sum(lex_cost[i][upper_match[i]] for i in range(r)),
            "optimal_primary_value": upper_bound,
        },
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", nargs="?", type=Path,
                        help="JSON with adjacency, source, target and k; default: an 11-vertex path demo")
    parser.add_argument("--output", type=Path, help="write the result JSON to this path")
    args = parser.parse_args()
    if args.input is None:
        graph = [[] for _ in range(11)]
        for u in range(10):
            graph[u].append(u + 1)
            graph[u + 1].append(u)
        data = {"adjacency": graph, "source": [0, 3, 6], "target": [4, 7, 10], "k": 3}
    else:
        data = json.loads(args.input.read_text(encoding="utf-8"))
    result = solve(data["adjacency"], data["source"], data["target"], data["k"])
    output = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        args.output.write_text(output, encoding="utf-8")
    else:
        print(output, end="")


if __name__ == "__main__":
    main()
