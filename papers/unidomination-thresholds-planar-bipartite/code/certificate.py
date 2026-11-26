"""Exact small graph and arithmetic tests for the planar threshold reductions."""

from fractions import Fraction
from itertools import combinations
from math import isqrt
from random import Random


def closed_neighborhoods(order, edges):
    closed = [1 << u for u in range(order)]
    for u, v in edges:
        closed[u] |= 1 << v
        closed[v] |= 1 << u
    return closed


def packing_optimum(closed, representatives=None):
    if representatives is None:
        representatives = range(len(closed))
    masks = list(representatives)

    def recurse(index, covered):
        if index == len(masks):
            return covered.bit_count()
        without = recurse(index + 1, covered)
        mask = closed[masks[index]]
        if covered & mask:
            return without
        return max(without, recurse(index + 1, covered | mask))

    return recurse(0, 0)


def domination_optimum(closed):
    best = -1
    for mask in range(1 << len(closed)):
        counts = [(mask & row).bit_count() for row in closed]
        if all(counts):
            best = max(best, sum(x == 1 for x in counts))
    return best


def subdivision_core(n, edges):
    all_edges = [(v, n + v) for v in range(n)]
    degrees = [0] * n
    for i, (u, v) in enumerate(edges, 2 * n):
        all_edges.extend(((u, i), (v, i)))
        degrees[u] += 1
        degrees[v] += 1
    return closed_neighborhoods(2 * n + len(edges), all_edges), degrees


def check_exact_core(n, edges):
    graph, degrees = subdivision_core(n, edges)
    independent_scores = []
    for vertices in range(1 << n):
        if all(((vertices >> u) & (vertices >> v) & 1) == 0 for u, v in edges):
            independent_scores.append(sum(degrees[v] for v in range(n) if vertices & (1 << v)))
    # For arbitrary source degree, the gain over its one leaf is the degree.
    pred = 2 * n + max(independent_scores)
    assert packing_optimum(graph) == pred
    old_max = max(degrees, default=0)
    if n and all(d == 3 for d in degrees):
        assert max(row.bit_count() - 1 for row in graph) == 4
        assert (pred - 2 * n) % 3 == 0
    else:
        assert max((row.bit_count() - 1 for row in graph), default=0) <= max(old_max + 1, 2)


def check_filler(q):
    leaf_count = 2 * q
    graph_edges = []
    representatives = [0]
    for branch in range(1, q + 1):
        first_leaf = q + 1 + (branch - 1) * leaf_count
        graph_edges.append((0, branch))
        graph_edges.extend((branch, leaf) for leaf in range(first_leaf, first_leaf + leaf_count))
        representatives.extend((branch, first_leaf))
    closed = closed_neighborhoods(2 * q * q + q + 1, graph_edges)
    for branch in range(1, q + 1):
        first = q + 1 + (branch - 1) * leaf_count
        equivalent = range(first, first + leaf_count)
        for a, b in combinations(equivalent, 2):
            assert closed[a] & closed[b]
            assert closed[a].bit_count() == closed[b].bit_count()
            assert all(bool(closed[a] & closed[c]) == bool(closed[b] & closed[c])
                       for c in representatives if c != first)
    assert packing_optimum(closed, representatives) == 4 * q


def root_ceiling(c, order):
    radicand = c.numerator ** 2 * order
    floor = isqrt(radicand) // c.denominator
    return floor + int((floor * c.denominator) ** 2 < radicand)


def ceil_fraction(value):
    return -(-value.numerator // value.denominator)


def calibration_checks():
    linear = 0
    quadratic = 0
    for n in (1, 4, 7, 12, 45, 100, 234):
        for c in map(Fraction, ("0.5001", "0.51", "0.54", "0.6", "0.75", "0.9", "0.999")):
            q = ((1 - c) * n) // (4 * c - 2) + 1
            order, target = n + 4 * q, n + 2 * q
            extra = ceil_fraction((c * order - target) / (1 - c))
            assert ceil_fraction(c * (order + extra)) == target + extra
            for score in range(n + 1):
                assert (score + 2 * q + extra >= c * (order + extra)) == (score == n)
            linear += 1
        for c in map(Fraction, ("2.8285", "2.85", "2.9", "3", "3.9", "4", "7.1")):
            core_size = 2 * n
            for k in (0, core_size // 3, core_size):
                actual_core_order = 7 * n
                base_target = 2 * core_size + 3 * k
                q = 1
                while True:
                    order = actual_core_order + 2 * q * q + q + 1
                    target = base_target + 4 * q
                    if (c.denominator * target) ** 2 < c.numerator ** 2 * order and order >= c ** 2:
                        break
                    q *= 2

                def delta(t):
                    return root_ceiling(c, order + t) - target - t

                low, high = 0, 2 * delta(0) + 2
                assert delta(low) > 0 >= delta(high)
                while high - low > 1:
                    middle = (low + high) // 2
                    if delta(middle) > 0:
                        low = middle
                    else:
                        high = middle
                assert delta(high) == 0
                for alpha in range(core_size + 1):
                    observed = ((c.denominator * (2 * core_size + 3 * alpha + 4 * q + high)) ** 2
                                >= c.numerator ** 2 * (order + high))
                    assert observed == (alpha >= k)
                quadratic += 1
    return linear, quadratic


def main():
    full_cover_count = 0
    for a in range(4):
        for b in range(4):
            candidates = [(u, a + v) for u in range(a) for v in range(b)]
            for selected in range(1 << len(candidates)):
                edges = [edge for i, edge in enumerate(candidates) if selected & (1 << i)]
                value = domination_optimum(closed_neighborhoods(a + b, edges))
                assert 2 * value >= a + b
                full_cover_count += 1
    assert domination_optimum(closed_neighborhoods(4, ((0, 1), (1, 2), (2, 3), (3, 0)))) == 2

    core_count = 0
    for n in range(6):
        candidates = tuple(combinations(range(n), 2))
        for size in range(len(candidates) + 1):
            for edges in combinations(candidates, size):
                check_exact_core(n, edges)
                core_count += 1
    rng = Random(20261124)
    for _ in range(45):
        n = rng.randrange(6, 9)
        candidates = tuple(combinations(range(n), 2))
        edges = rng.sample(candidates, rng.randrange(4, 11))
        check_exact_core(n, edges)
    cube = [(u, u ^ (1 << bit)) for u in range(8) for bit in range(3) if u & (1 << bit) == 0]
    check_exact_core(8, cube)
    for q in range(1, 9):
        check_filler(q)
    linear, quadratic = calibration_checks()
    print("Exhaustive bipartite full-cover bounds:", full_cover_count)
    print("Exhaustive subdivision cores:", core_count, "seeded cores: 45, cube: 1")
    print("Exact tree fillers q=1 through 8")
    print("Exact ratio and square-root calibrations:", linear, quadratic)
    print("All finite checks passed.")


if __name__ == "__main__":
    main()
