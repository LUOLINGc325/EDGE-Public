#!/usr/bin/env python3
"""Construct an optimal path-forest ball cover from integer path lengths."""

from heapq import heapify, heappop, heappush
from math import isqrt


def exact_odd_partition(lengths):
    """Assign the first sqrt(sum(lengths)) odds to square-order demands."""
    n = len(lengths)
    total = sum(lengths)
    m = isqrt(total)
    if n == 0 or total != m * m or any(length <= 0 for length in lengths):
        raise ValueError("expected positive path lengths of square total order")
    if n == 1:
        return [list(range(1, 2 * m, 2))]
    limit = 100 * n
    if min(lengths) < limit:
        raise ValueError("the branch for several paths requires lengths at least 100n")

    assigned = [[] for _ in lengths]
    heap = [(-length, i) for i, length in enumerate(lengths)]
    heapify(heap)
    while -heap[0][0] - (2 * m - 1) >= limit:
        neg_length, i = heappop(heap)
        weight = 2 * m - 1
        assigned[i].append(weight)
        heappush(heap, (neg_length + weight, i))
        m -= 1
    assert 10 * n <= m and 9 * m < limit

    residual = [0] * n
    for neg_length, i in heap:
        residual[i] = -neg_length
    modulus = 2 * m
    endpoint = n - 1
    if m % 2:
        assigned[endpoint].append(m)
        residual[endpoint] -= m

    odds = [i for i in range(n) if i != endpoint and residual[i] % 2]
    evens = [i for i in range(n) if i != endpoint and not residual[i] % 2]
    # All odd demands are consecutive in pairs, including a possible last pair.
    order = evens + odds + [endpoint] if residual[endpoint] % 2 else odds + evens + [endpoint]
    available = bytearray(m + 1)
    for small in range(1, m, 2):
        available[small] = 1
    next_small = 1

    def take_unused():
        nonlocal next_small
        while next_small < m and not available[next_small]:
            next_small += 2
        assert next_small < m
        small = next_small
        available[small] = 0
        next_small += 2
        return small

    def pair_class(weight):
        return min(weight, modulus - weight)

    def take_two(delta):
        for a in range(1, modulus, 2):
            b = (delta - a) % modulus
            class_a = pair_class(a)
            class_b = pair_class(b)
            if class_a != class_b and available[class_a] and available[class_b]:
                available[class_a] = 0
                available[class_b] = 0
                return [a, b]
        raise AssertionError("additive pair supply exhausted")

    # Freeze each prefix from the unmodified adjusted target demands.
    prefix = 0
    demands = residual.copy()
    for position, left in enumerate(order[:-1]):
        right = order[position + 1]
        prefix = (prefix + demands[left]) % modulus
        if prefix == 0:
            continue
        if prefix % 2:
            small = take_unused()
            first = modulus - small if prefix < m else small
            left_weights = [first] + take_two((prefix - first) % modulus)
            assert m <= sum(left_weights) <= 5 * m
        else:
            left_weights = take_two(prefix)
        for weight in left_weights:
            other = modulus - weight
            assigned[left].append(weight)
            residual[left] -= weight
            assigned[right].append(other)
            residual[right] -= other

    for i, need in enumerate(residual):
        assert need >= 0 and need % modulus == 0
        for _ in range(need // modulus):
            small = take_unused()
            assigned[i].extend((small, modulus - small))
    assert not any(available)
    return assigned


def planned_centers(lengths):
    """Return (path, center) ordered by ignition time, with vertices zero-based."""
    total = sum(lengths)
    rounds = isqrt(total - 1) + 1
    extended = list(lengths)
    extended[-1] += rounds * rounds - total
    assignment = exact_odd_partition(extended)
    centers = [None] * rounds
    for path, weights in enumerate(assignment):
        start = 0
        for weight in weights:
            radius = (weight - 1) // 2
            centers[rounds - radius - 1] = (path, min(start + radius, lengths[path] - 1))
            start += weight
    return centers


def legal_sources(lengths):
    """Spread over explicit vertices and return the actual legal ignition order."""
    burned = [bytearray(length) for length in lengths]
    frontier = []
    sources = []
    scan_path = 0
    scan_vertex = 0
    for path, center in planned_centers(lengths):
        next_frontier = []
        for component, vertex in frontier:
            for neighbor in (vertex - 1, vertex + 1):
                if 0 <= neighbor < lengths[component] and not burned[component][neighbor]:
                    burned[component][neighbor] = 1
                    next_frontier.append((component, neighbor))

        if burned[path][center]:
            while scan_path < len(lengths):
                if scan_vertex == lengths[scan_path]:
                    scan_path += 1
                    scan_vertex = 0
                elif burned[scan_path][scan_vertex]:
                    scan_vertex += 1
                else:
                    break
            if scan_path == len(lengths):
                break
            path, center = scan_path, scan_vertex

        burned[path][center] = 1
        sources.append((path, center))
        next_frontier.append((path, center))
        frontier = next_frontier
    assert all(all(path) for path in burned)
    return sources
