#!/usr/bin/env python3
"""Exact finite certificate for both cotree dynamic programs."""

from collections import deque
from dataclasses import dataclass
from functools import lru_cache
from itertools import combinations, product
from random import Random


@dataclass
class Tree:
    vertices: tuple
    mode: str = "leaf"
    left: object = None
    right: object = None


@dataclass
class Table:
    tree: Tree
    entries: dict
    left: object = None
    right: object = None


@dataclass
class Packing:
    triples: list
    edges: list
    nonedges: list
    singles: list


def components(adjacency, vertices, complement=False):
    remaining = set(vertices)
    parts = []
    while remaining:
        root = remaining.pop()
        part, work = [root], [root]
        while work:
            vertex = work.pop()
            if complement:
                fresh = remaining - adjacency[vertex]
            else:
                fresh = remaining & adjacency[vertex]
            remaining.difference_update(fresh)
            part.extend(fresh)
            work.extend(fresh)
        parts.append(tuple(sorted(part)))
    return parts


def cotree(adjacency, vertices):
    if len(vertices) == 1:
        return Tree(vertices)
    parts = components(adjacency, vertices)
    mode = "union"
    if len(parts) == 1:
        parts = components(adjacency, vertices, complement=True)
        mode = "join"
    if len(parts) == 1:
        return None
    children = [cotree(adjacency, part) for part in parts]
    if any(child is None for child in children):
        return None
    tree = children[0]
    for child in children[1:]:
        tree = Tree(tree.vertices + child.vertices, mode, tree, child)
    return tree


def join_choice(a, b, bound_a, bound_b, triples, edges):
    """Optimal k and two retained nonedge counts for fixed (triples, edges)."""
    a -= edges
    b -= edges
    low = max(0, triples - bound_b, 2 * triples - b)
    high = min(triples, bound_a, a - triples)
    best = None
    for parity in (0, 1):
        first = (low + 1 - parity) // 2
        last = (high - parity) // 2
        if first > last:
            continue
        left_cross = bound_a - parity - (a - triples - parity) // 2
        right_cross = (b - 2 * triples + parity) // 2 - (bound_b - triples + parity)
        j_values = {first, last, min(last, max(first, left_cross)), min(last, max(first, right_cross))}
        for j in j_values:
            k = 2 * j + parity
            left_retain = min(bound_a - k, (a - triples - k) // 2)
            right_retain = min(bound_b - triples + k, (b - 2 * triples + k) // 2)
            candidate = (left_retain + right_retain, k, left_retain, right_retain)
            if best is None or candidate > best:
                best = candidate
    return best


def build(tree, partition):
    if tree.mode == "leaf":
        return Table(tree, {(0, 0): (0, None)})
    left, right = build(tree.left, partition), build(tree.right, partition)
    size_left, size_right = len(tree.left.vertices), len(tree.right.vertices)
    entries = {}

    def record(key, value, decision):
        if key not in entries or value > entries[key][0]:
            entries[key] = value, decision

    for (t_left, s_left), (bound_left, _) in left.entries.items():
        a = size_left - 3 * t_left - 2 * s_left
        for (t_right, s_right), (bound_right, _) in right.entries.items():
            b = size_right - 3 * t_right - 2 * s_right
            child_states = ((t_left, s_left), (t_right, s_right))
            base = (t_left + t_right, s_left + s_right)
            if tree.mode == "union":
                limit = min(a, b)
                for r in (limit, max(0, limit - 1)):
                    p_left = min(bound_left, (a - r) // 2)
                    p_right = min(bound_right, (b - r) // 2)
                    record(base, p_left + p_right + r, (*child_states, p_left, p_right, r, 0, 0))
                continue

            edge_choices = range(min(a, b) + 1) if partition else (0,)
            for new_edges in edge_choices:
                for new_triples in range((a + b - 2 * new_edges) // 3 + 1):
                    choice = join_choice(a, b, bound_left, bound_right, new_triples, new_edges)
                    if choice is not None:
                        value, k, p_left, p_right = choice
                        parent = (base[0] + new_triples, base[1] + new_edges)
                        record(
                            parent, value,
                            (*child_states, p_left, p_right, k, new_triples - k, new_edges)
                        )

    return Table(tree, entries, left, right)


def materialize(table, state):
    expected_pairs, decision = table.entries[state]
    if decision is None:
        return Packing([], [], [], [table.tree.vertices[0]])
    left_state, right_state, p_left, p_right, k, l, new_edges = decision
    left = materialize(table.left, left_state)
    right = materialize(table.right, right_state)

    def split_pairs(packing, retain, spend):
        pairs = packing.nonedges
        singles = packing.singles + [v for pair in pairs[retain + spend:] for v in pair]
        return pairs[:retain], pairs[retain:retain + spend], singles

    if table.tree.mode == "join":
        kept_left, spent_left, free_left = split_pairs(left, p_left, k)
        kept_right, spent_right, free_right = split_pairs(right, p_right, l)
        triples = left.triples + right.triples
        triples.extend((u, free_right.pop(), v) for u, v in spent_left)
        triples.extend((u, free_left.pop(), v) for u, v in spent_right)
        paths2 = left.edges + right.edges
        paths2.extend((free_left.pop(), free_right.pop()) for _ in range(new_edges))
        result = Packing(triples, paths2, kept_left + kept_right, free_left + free_right)
    else:
        kept_left, _, free_left = split_pairs(left, p_left, 0)
        kept_right, _, free_right = split_pairs(right, p_right, 0)
        nonedges = kept_left + kept_right + [(free_left.pop(), free_right.pop()) for _ in range(k)]
        result = Packing(left.triples + right.triples, left.edges + right.edges, nonedges, free_left + free_right)

    assert (len(result.triples), len(result.edges)) == state
    assert len(result.nonedges) == expected_pairs
    return result


def partition_witness(tree):
    table = build(tree, partition=True)
    state = max(table.entries, key=lambda key: 2 * key[0] + key[1])
    result = materialize(table, state)
    remaining = result.singles + [v for pair in result.nonedges for v in pair]
    return result.triples + result.edges + [(v,) for v in remaining]


def cover_witness(tree, adjacency):
    if tree.mode == "union":
        return cover_witness(tree.left, adjacency) + cover_witness(tree.right, adjacency)
    table = build(tree, partition=False)
    result = materialize(table, max(table.entries))
    remaining = iter(result.singles + [v for pair in result.nonedges for v in pair])
    cover = result.triples
    for u in remaining:
        v = next(remaining, None)
        if v is None:
            cover.append((u,))
        elif v in adjacency[u]:
            cover.append((u, v))
        else:
            middle = next(iter(adjacency[u] & adjacency[v]))
            cover.append((u, middle, v))
    return cover


def shortest_path_oracle(adjacency):
    """Enumerate every shortest path on the small input graph."""
    n = len(adjacency)
    distances = []
    masks = {1 << v for v in range(n)}
    for source in range(n):
        distance = [None] * n
        distance[source] = 0
        queue = deque([source])
        while queue:
            u = queue.popleft()
            for v in adjacency[u]:
                if distance[v] is None:
                    distance[v] = distance[u] + 1
                    queue.append(v)
        distances.append(distance)

        def extend(u, path):
            masks.add(path)
            for v in adjacency[u]:
                if distance[v] == distance[u] + 1:
                    extend(v, path | (1 << v))

        extend(source, 1 << source)

    def optimum(partition):
        @lru_cache(None)
        def visit(available):
            if available == 0:
                return 0
            first = available & -available
            return 1 + min(
                visit(available & ~path)
                for path in masks
                if path & first and (not partition or path & available == path)
            )

        return visit((1 << n) - 1)

    return distances, optimum(True), optimum(False)


def check(adjacency):
    n = len(adjacency)
    tree = cotree(adjacency, tuple(range(n)))
    if tree is None:
        return False
    distances, exact_partition, exact_cover = shortest_path_oracle(adjacency)
    actual_partition = partition_witness(tree)
    actual_cover = cover_witness(tree, adjacency)
    assert len(actual_partition) == exact_partition
    assert len(actual_cover) == exact_cover
    assert sum(map(len, actual_partition)) == n
    for answer in (actual_partition, actual_cover):
        assert {v for path in answer for v in path} == set(range(n))
        for path in answer:
            assert distances[path[0]][path[-1]] == len(path) - 1
            assert all(v in adjacency[u] for u, v in zip(path, path[1:]))
    return True


def from_edges(size, edges):
    adjacency = [set() for _ in range(size)]
    for u, v in edges:
        adjacency[u].add(v)
        adjacency[v].add(u)
    return adjacency


def random_cograph(rng, size):
    def visit(lo, hi):
        if hi - lo == 1:
            return []
        middle = rng.randint(lo + 1, hi - 1)
        crossing = list(product(range(lo, middle), range(middle, hi))) if rng.randrange(2) else []
        return visit(lo, middle) + visit(middle, hi) + crossing

    return from_edges(size, visit(0, size))


def main():
    exhaustive = 0
    for n in range(1, 6):
        edges = list(combinations(range(n), 2))
        for mask in range(1 << len(edges)):
            admissible = [uv for j, uv in enumerate(edges) if mask & (1 << j)]
            exhaustive += check(from_edges(n, admissible))
    print(f"exhaustive labeled cographs: {exhaustive} passed", flush=True)
    rng = Random(202439)
    for _ in range(220):
        assert check(random_cograph(rng, rng.randint(1, 11)))
    print("seeded cographs: 220 passed")

    for _ in range(3000):
        a, b = rng.randrange(50), rng.randrange(50)
        bound_a, bound_b = rng.randint(0, a // 2), rng.randint(0, b // 2)
        triples, edges = rng.randrange(30), rng.randrange(45)
        expected = []
        for k in range(triples + 1):
            l = triples - k
            if k <= bound_a and l <= bound_b and 2 * k + l + edges <= a and k + 2 * l + edges <= b:
                left = min(bound_a - k, (a - 2 * k - l - edges) // 2)
                right = min(bound_b - l, (b - k - 2 * l - edges) // 2)
                expected.append(left + right)
        observed = join_choice(a, b, bound_a, bound_b, triples, edges)
        assert (observed[0] if observed is not None else None) == (max(expected) if expected else None)
    print("independent join transition scans: 3000 passed")


if __name__ == "__main__":
    main()
