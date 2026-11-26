#!/usr/bin/env python3
"""Exact finite checks for the chain-graph normal-form algorithms."""

from collections import deque
from functools import lru_cache
from itertools import combinations_with_replacement, product
from random import Random


def consecutive(degrees, bottoms, step_top, step_bottom, required):
    tops = len(degrees)
    run = [[0] * (bottoms + step_bottom) for _ in range(tops + step_top)]
    for top in range(tops - 1, -1, -1):
        for bottom in range(bottoms - 1, -1, -1):
            if (bottom >= bottoms - degrees[top]) == required:
                run[top][bottom] = 1 + run[top + step_top][bottom + step_bottom]
    return run


def evaluate(a_outer, a_inner, long_paths, v_inner, v_outer, one_edge, tops, bottoms, runs,
             *, reconstruct=False):
    a, v, positive, negative = runs
    used_tops = a_outer + a_inner + 2 * (long_paths + v_inner + v_outer) + one_edge
    used_bottoms = 2 * (a_outer + a_inner + long_paths) + v_inner + v_outer + one_edge
    if used_tops > tops or used_bottoms > bottoms:
        return None

    start_bottom = bottoms - used_bottoms
    # Outside A, first long slots, inside A and V, second long slots, outside V.
    high_top, low_bottom = a_outer, start_bottom + 2 * a_outer
    a_top, a_bottom = high_top + long_paths, low_bottom + long_paths
    edge_top, edge_bottom = a_top + a_inner, a_bottom + 2 * a_inner
    v_top, v_bottom = edge_top + one_edge, edge_bottom + one_edge
    low_top, high_bottom = v_top + 2 * v_inner, v_bottom + v_inner
    final_top, final_bottom = low_top + long_paths, high_bottom + long_paths

    tests = (
        (a, 0, start_bottom, a_outer),
        (a, a_top, a_bottom, a_inner),
        (v, v_top + 1, v_bottom, v_inner),
        (v, final_top + 1, final_bottom, v_outer),
        (positive, high_top, low_bottom, long_paths),
        (positive, low_top, high_bottom, long_paths),
        (negative, low_top, low_bottom, long_paths),
        (positive, edge_top, edge_bottom, one_edge),
    )
    if any(count and table[i][j] < count for table, i, j, count in tests):
        return None

    if not reconstruct:
        return tops + bottoms - 2 * (a_outer + a_inner + v_inner + v_outer) - 3 * long_paths - one_edge

    paths = [(tops + b,) for b in range(start_bottom)]
    paths.extend((t,) for t in range(used_tops, tops))
    for first_top, first_bottom, count in ((0, start_bottom, a_outer), (a_top, a_bottom, a_inner)):
        paths.extend(
            (tops + first_bottom + 2 * j, first_top + j, tops + first_bottom + 2 * j + 1)
            for j in range(count)
        )
    for first_top, first_bottom, count in ((v_top, v_bottom, v_inner), (final_top, final_bottom, v_outer)):
        paths.extend(
            (first_top + 2 * j, tops + first_bottom + j, first_top + 2 * j + 1)
            for j in range(count)
        )
    for j in range(long_paths):
        paths.append((tops + low_bottom + j, high_top + j, tops + high_bottom + j, low_top + j))
    if one_edge:
        paths.append((edge_top, tops + edge_bottom))
    return paths


def partition(degrees, bottoms):
    tops = len(degrees)
    runs = (
        consecutive(degrees, bottoms, 1, 2, True),
        consecutive(degrees, bottoms, 2, 1, True),
        consecutive(degrees, bottoms, 1, 1, True),
        consecutive(degrees, bottoms, 1, 1, False),
    )
    best_size, best = tops + bottoms, (0, 0, 0, 0, 0, 0)

    def score(candidate):
        nonlocal best_size, best
        size = evaluate(*candidate, tops, bottoms, runs)
        if size is not None and size < best_size:
            best_size, best = size, candidate

    count_a = min(tops, bottoms // 2)
    count_v = min(bottoms, tops // 2)
    for a, v, optional in product(range(count_a + 1), range(count_v + 1), (0, 1)):
        score((a, 0, 0, 0, v, optional))
    for long_count in range(1, min(tops, bottoms) // 2 + 1):
        left_top, left_bottom = tops - 2 * long_count, bottoms - 2 * long_count
        for a_outer in range(min(left_top, left_bottom // 2) + 1):
            for a_inner in range(min(left_top - a_outer, (left_bottom - 2 * a_outer) // 2) + 1):
                remains_top = left_top - a_outer - a_inner
                remains_bottom = left_bottom - 2 * (a_outer + a_inner)
                for v_inner in range(min(remains_top // 2, remains_bottom) + 1):
                    for v_outer in range(min(remains_top // 2, remains_bottom) - v_inner + 1):
                        score((a_outer, a_inner, long_count, v_inner, v_outer, 0))
    return evaluate(*best, tops, bottoms, runs, reconstruct=True)


def cover(degrees, bottoms):
    tops = len(degrees)
    best = partition(degrees, bottoms)
    upper = len(best)
    for top_copies, bottom_copies in product(range(upper), repeat=2):
        new_bottoms = bottoms + bottom_copies
        new_counts = [new_bottoms] * top_copies + [degree + bottom_copies for degree in degrees]
        candidate = partition(new_counts, new_bottoms)
        if len(candidate) >= len(best):
            continue
        projection = [0] * top_copies + list(range(tops + bottoms)) + [tops + bottoms - 1] * bottom_copies
        best = []
        for path in candidate:
            image = tuple(projection[u] for u in path)
            if len(image) == 3 and image[0] == image[-1]:
                image = image[:2]
            best.append(image)
    return best


def oracle(degrees, bottoms):
    tops = len(degrees)
    n = tops + bottoms
    adjacency = [set() for _ in range(n)]
    for i, degree in enumerate(degrees):
        for j in range(bottoms - degree, bottoms):
            adjacency[i].add(tops + j)
            adjacency[tops + j].add(i)
    paths = [set() for _ in range(n)]
    distances = []
    for root in range(n):
        dst = [-1] * n
        dst[root] = 0
        queue = deque([root])
        while queue:
            u = queue.popleft()
            for v in adjacency[u]:
                if dst[v] < 0:
                    dst[v] = dst[u] + 1
                    queue.append(v)
        distances.append(dst)

        def enumerate_paths(u, mask, vertices):
            for v in vertices:
                paths[v].add(mask)
            for v in adjacency[u]:
                if dst[v] == dst[u] + 1:
                    enumerate_paths(v, mask | (1 << v), (*vertices, v))

        enumerate_paths(root, 1 << root, (root,))

    def minimum(disjoint):
        @lru_cache(None)
        def solve(mask):
            if not mask:
                return 0
            v = (mask & -mask).bit_length() - 1
            return 1 + min(
                solve(mask & ~path) for path in paths[v]
                if not disjoint or mask & path == path
            )
        return solve((1 << n) - 1)

    return minimum, adjacency, distances


def check(degrees, bottoms, *, verify_cover):
    optimum, adjacency, distances = oracle(degrees, bottoms)
    actual_partition = partition(degrees, bottoms)
    assert len(actual_partition) == optimum(True), (degrees, bottoms)
    assert sum(map(len, actual_partition)) == len(adjacency)
    witnesses = [actual_partition]
    if verify_cover:
        chosen = cover(degrees, bottoms)
        assert len(chosen) == optimum(False), (degrees, bottoms)
        witnesses.append(chosen)
    for paths in witnesses:
        assert set(range(len(adjacency))) == {v for path in paths for v in path}
        assert all(
            distances[path[0]][path[-1]] == len(path) - 1
            and all(v in adjacency[u] for u, v in zip(path, path[1:]))
            for path in paths
        )


def main():
    partitions, covers = 0, 0
    for n in range(2, 12):
        for size_top in range(1, n):
            size_bottom = n - size_top
            for row in combinations_with_replacement(range(1, size_bottom + 1), size_top):
                if row[-1] != size_bottom:
                    continue
                check(row[::-1], size_bottom, verify_cover=n <= 7)
                partitions += 1
                covers += n <= 7
    print(f"exhaustive chain degree sequences: {partitions} partitions, {covers} covers passed", flush=True)
    rng = Random(4202024)
    for _ in range(80):
        size_top, size_bottom = rng.randint(1, 5), rng.randint(1, 5)
        row = [size_bottom] + rng.choices(range(1, size_bottom + 1), k=size_top - 1)
        check(sorted(row, reverse=True), size_bottom, verify_cover=True)
    print("seeded chain graphs: 80 partitions and covers passed")


if __name__ == "__main__":
    main()
