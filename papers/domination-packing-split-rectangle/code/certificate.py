"""Exact geometry, extremal table, and witness checks for the split rectangle bound."""
from bisect import bisect_left, bisect_right
from itertools import combinations, combinations_with_replacement, product
from random import Random


def intersects(a, b):
    return max(a[0], b[0]) <= min(a[1], b[1]) and max(a[2], b[2]) <= min(a[3], b[3])


def neighborhoods(rectangles):
    return [sum(1 << j for j, other in enumerate(rectangles) if intersects(box, other))
            for box in rectangles]


def contains_as_bits(masks, order):
    seen = 0
    for mask in masks:
        seen |= mask
    return seen == (1 << order) - 1


def disjoint_masks(masks):
    seen = 0
    for mask in masks:
        if seen & mask:
            return False
        seen |= mask
    return True


def witnesses(clique, independent):
    """Return vertex indices for a dominating set and a certified packing."""
    if not clique:
        return set(range(len(independent))), set(range(len(independent)))
    anchor_x = max(box[0] for box in clique)
    anchor_y = max(box[2] for box in clique)
    quadrants = {(sx, sy): [] for sx, sy in product((1, -1), repeat=2)}
    for index, (left, right, bottom, top) in enumerate(independent, len(clique)):
        x = min(max(anchor_x, left), right) - anchor_x
        y = min(max(anchor_y, bottom), top) - anchor_y
        signs = (1 if x >= 0 else -1, 1 if y >= 0 else -1)
        quadrants[signs].append((abs(x), abs(y), index))

    all_chosen, isolated, largest_packing = set(), set(), set()
    for (sx, sy), points in quadrants.items():
        extents = [(right - anchor_x if sx == 1 else anchor_x - left,
                    top - anchor_y if sy == 1 else anchor_y - bottom, index)
                   for index, (left, right, bottom, top) in enumerate(clique)]
        extents.sort(reverse=True)
        active_y = -1
        first_new = 0
        frontier = []
        skyline_y = -1
        for x, y, vertex in sorted(points, reverse=True):
            while first_new < len(extents) and extents[first_new][0] >= x:
                active_y = max(active_y, extents[first_new][1])
                first_new += 1
            if y > active_y:
                isolated.add(vertex)
            elif y > skyline_y:
                frontier.append((x, y, vertex))
                skyline_y = y
        frontier.reverse()
        x_values = [x for x, _, _ in frontier]
        descending_y_negated = [-y for _, y, _ in frontier]
        intervals = []
        for radius_x, radius_y, vertex in extents:
            lo = bisect_left(descending_y_negated, -radius_y)
            hi = bisect_right(x_values, radius_x) - 1
            if lo <= hi:
                intervals.append((lo, hi, vertex))
        intervals.sort()

        position = first = 0
        packing = set()
        while position < len(frontier):
            best_end, best_vertex = position - 1, None
            while first < len(intervals) and intervals[first][0] <= position:
                _, high, vertex = intervals[first]
                if high > best_end:
                    best_end, best_vertex = high, vertex
                first += 1
            assert best_vertex is not None
            all_chosen.add(best_vertex)
            packing.add(frontier[position][2])
            position = best_end + 1
        if len(packing) > len(largest_packing):
            largest_packing = packing
    if not all_chosen:
        all_chosen.add(0)
        largest_packing.add(0)
    return all_chosen | isolated, largest_packing | isolated


def exact_graph_check(clique, independent):
    assert all(intersects(a, b) for a, b in combinations(clique, 2))
    assert not any(intersects(a, b) for a, b in combinations(independent, 2))
    closed = neighborhoods(clique + independent)
    chosen, packing = witnesses(clique, independent)
    assert contains_as_bits((closed[v] for v in chosen), len(closed))
    assert disjoint_masks(closed[v] for v in packing)
    assert len(chosen) <= 4 * len(packing)
    gamma = next(size for size in range(len(closed) + 1)
                 if any(contains_as_bits(selection, len(closed))
                        for selection in combinations(closed, size)))
    rho = next(size for size in range(len(closed), -1, -1)
               if any(disjoint_masks(selection) for selection in combinations(closed, size)))
    assert gamma <= 4 * rho
    assert gamma <= len(chosen) and len(packing) <= rho


def sharp_example():
    points = [(5, 2), (3, 3), (-3, 0), (1, -3), (-1, 3),
              (-2, 1), (6, -1), (2, 4), (4, -2), (-1, -2)]
    leaves = [(4*x-1, 4*x+1, 4*y-1, 4*y+1) for x, y in points]
    boxes = []
    point_pair = {}
    for i, j in combinations(range(len(points)), 2):
        px, py = points[i]
        qx, qy = points[j]
        unexpanded = (min(0, px, qx), max(0, px, qx),
                      min(0, py, qy), max(0, py, qy))
        left, right, bottom, top = unexpanded
        box = (4*left-1, 4*right+1, 4*bottom-1, 4*top+1)
        support = frozenset(k for k, (x, y) in enumerate(points, 1)
                            if left <= x <= right and bottom <= y <= top)
        for k, square in enumerate(leaves, 1):
            assert intersects(box, square) == (k in support)
        boxes.append(box)
        point_pair[(i+1, j+1)] = support
    all_points = frozenset(range(1, len(points)+1))
    covers = set(point_pair.values())
    maximal = sorted((c for c in covers if not any(c < d for d in covers)),
                     key=lambda c: tuple(sorted(c)))
    assert len(maximal) == 21
    obstruction = {}
    for first in maximal:
        if 3 in first:
            key = tuple(sorted(first))
            obstruction[key] = (len(all_points - first),
                                max(len((b | c) - first)
                                    for b, c in combinations_with_replacement(maximal, 2)))
    expected = {(1, 3, 6): (7, 6), (2, 3, 5, 6): (6, 5),
                (3, 7): (8, 6), (3, 5, 6, 8): (6, 5),
                (3, 4, 10): (7, 6), (3, 9, 10): (7, 6)}
    assert obstruction == expected
    chosen_pairs = [(2, 4), (1, 3), (3, 8), (7, 10)]
    assert set.union(*(set(point_pair[key]) for key in chosen_pairs)) == all_points
    closed = neighborhoods(boxes + leaves)
    assert all(a & b for a, b in combinations(closed, 2))
    assert not any(contains_as_bits(v, len(closed)) for v in combinations(closed, 3))
    chosen, packing = witnesses(boxes, leaves)
    assert (len(chosen), len(packing)) == (4, 1)
    print("Sharp graph: 55 vertices, domination 4 and packing 1.")
    for row, counts in sorted(obstruction.items()):
        print(f"Box leaves {row}: remaining {counts[0]}; two-box maximum {counts[1]}.")


def run():
    clique_options = [(-3, 1, 0, 3), (0, 4, -3, 1), (-4, 2, -1, 4),
                      (-1, 3, -4, 0), (0, 0, 0, 0)]
    leaf_options = [(-3, -2, 1, 2), (2, 3, -3, -2), (-1, 1, 3, 4),
                    (1, 1, -1, -1), (3, 4, 2, 3), (5, 6, 5, 6)]
    total = 0
    for mask_c in range(1 << len(clique_options)):
        clique = [box for i, box in enumerate(clique_options) if mask_c & (1 << i)]
        for mask_i in range(1 << len(leaf_options)):
            independent = [box for i, box in enumerate(leaf_options) if mask_i & (1 << i)]
            exact_graph_check(clique, independent)
            total += 1
    seed = Random(98541)
    for _ in range(400):
        clique = [(-seed.randrange(0, 14), seed.randrange(0, 14),
                   -seed.randrange(0, 14), seed.randrange(0, 14))
                  for _ in range(seed.randrange(0, 7))]
        independent = []
        for _ in range(20):
            x, y = seed.randrange(-16, 17), seed.randrange(-16, 17)
            candidate = (x, x + seed.randrange(0, 6), y, y + seed.randrange(0, 6))
            if not any(intersects(candidate, box) for box in independent):
                independent.append(candidate)
            if len(independent) == 6:
                break
        exact_graph_check(clique, independent)
    print(f"Exhaustive grid submodels: {total}; seeded rectangle models: 400.")
    sharp_example()


if __name__ == "__main__":
    run()
