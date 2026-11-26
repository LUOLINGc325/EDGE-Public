"""Exact certificates for the Helly circular-arc weighted optimizer and ratio."""

from itertools import combinations, combinations_with_replacement
from random import Random


def interval_cover(intervals, weights, count):
    if not count:
        return 0, ()
    n = len(intervals)
    before = n
    by_start = sorted(range(n), key=lambda j: intervals[j][0])
    by_end = [before] + sorted(range(n), key=lambda j: intervals[j][1])
    scores = {}
    back = {}
    answer = None
    ending = None
    for j in by_start:
        a, b = intervals[j]
        if a == 1:
            scores[before, j] = weights[j]
        candidates = [(0 if i == before else intervals[i][1], i)
                      for i in by_end if (i, j) in scores]
        if b == count:
            for previous_end, i in candidates:
                value = scores[i, j]
                if previous_end <= count - 1 and (answer is None or value > answer):
                    answer, ending = value, (i, j)

        position = 0
        prefix_best = None
        for k in by_start:
            start, end = intervals[k]
            if not a < start <= b + 1 or end <= b:
                continue
            while position < len(candidates) and candidates[position][0] <= start - 2:
                _, i = candidates[position]
                if prefix_best is None or scores[i, j] > scores[prefix_best, j]:
                    prefix_best = i
                position += 1
            if prefix_best is not None:
                scores[j, k] = scores[prefix_best, j] + weights[k]
                back[j, k] = prefix_best

    if ending is None:
        return None
    i, j = ending
    witness = [j]
    while i != before:
        witness.append(i)
        i, j = back[i, j], i
    return answer, tuple(witness)


def circular_cover(period, points, arcs, weights):
    if not points:
        return 0, ()
    result = None
    for j, arc in enumerate(arcs):
        for p in range(period):
            point = 1 << p
            if not points & point & arc:
                continue
            uncovered = points & ~arc
            ordered = [1 << ((p + step) % period) for step in range(1, period)]
            ordered = [p for p in ordered if uncovered & p]
            labels = []
            ranges = []
            for k, candidate in enumerate(arcs):
                if candidate & point:
                    continue
                covered = [i for i, q in enumerate(ordered, 1) if q & candidate]
                if not covered:
                    continue
                left, right = covered[0], covered[-1]
                assert len(covered) == right - left + 1
                ranges.append((left, right))
                labels.append(k)
            solution = interval_cover(ranges, [weights[k] for k in labels], len(ordered))
            if solution is None:
                continue
            score, witness = solution
            total = score + weights[j]
            if result is None or total > result[0]:
                result = total, tuple(labels[k] for k in witness) + (j,)
    return result


def is_minimal_cover(points, arcs, selected):
    union = 0
    shared = 0
    for i in selected:
        shared |= union & arcs[i]
        union |= arcs[i]
    return (union & points == points
            and all(arcs[i] & points & ~shared for i in selected))


def direct_optimum(points, arcs, weights):
    result = None
    for size in range(len(arcs) + 1):
        for selected in combinations(range(len(arcs)), size):
            if is_minimal_cover(points, arcs, selected):
                value = sum(weights[i] for i in selected)
                result = value if result is None else max(result, value)
    return result


def check_circular(period, points, arcs, weights):
    optimal = direct_optimum(points, arcs, weights)
    actual = circular_cover(period, points, arcs, weights)
    assert (None if actual is None else actual[0]) == optimal
    if actual is not None:
        score, selected = actual
        assert is_minimal_cover(points, arcs, selected)
        assert sum(weights[i] for i in selected) == score


def available_arcs(period):
    return [sum(1 << ((start + offset) % period) for offset in range(length))
            for start in range(period) for length in range(1, period)] + [(1 << period) - 1]


def continuous_arcs(nodes):
    # Even positions are endpoints and odd positions are open-cell representatives.
    return [sum(1 << ((2 * start + offset) % (2 * nodes)) for offset in range(2 * steps + 1))
            for start in range(nodes) for steps in range(nodes)] + [(1 << (2 * nodes)) - 1]


def maximal_graph_cliques(arcs):
    n = len(arcs)
    neighbors = [sum(1 << j for j in range(n) if arcs[i] & arcs[j]) for i in range(n)]
    cliques = set()
    for mask in range(1, 1 << n):
        if not all(mask & neighbors[i] == mask for i in range(n) if mask & (1 << i)):
            continue
        if any(mask & neighbors[i] == mask for i in range(n) if not mask & (1 << i)):
            continue
        cliques.add(mask)
    return cliques


def graph_model(period, arcs):
    maximal = maximal_graph_cliques(arcs)
    representatives = {}
    for p in range(period):
        clique = sum(1 << i for i, arc in enumerate(arcs) if arc & (1 << p))
        if clique in maximal:
            representatives[clique] = p
    if len(representatives) != len(maximal):
        return False, False
    points = sum(1 << p for p in representatives.values())
    check_circular(period, points, arcs, [i % 5 - 2 for i in range(len(arcs))])
    check_circular(period, points, arcs, [1] * len(arcs))
    proper = not any(a != b and a & b == a for a in arcs for b in arcs)
    if proper:
        covers = [len(selected) for size in range(len(arcs) + 1)
                  for selected in combinations(range(len(arcs)), size)
                  if is_minimal_cover(points, arcs, selected)]
        assert max(covers) <= 2 * min(covers)
    return True, proper


def main():
    period = 5
    count = 0
    for n in range(5):
        for arcs in combinations_with_replacement(available_arcs(period), n):
            check_circular(period, (1 << period) - 1, arcs, [i % 5 - 2 for i in range(n)])
            count += 1
    rng = Random(20261124)
    for _ in range(400):
        period = rng.randrange(5, 11)
        arcs = rng.choices(available_arcs(period), k=rng.randrange(9))
        points = rng.randrange(1 << period)
        check_circular(period, points, arcs, rng.choices(range(-6, 7), k=len(arcs)))

    period = 10
    graph_checks = helly_checks = proper_checks = 0
    for n in range(1, 5):
        for arcs in combinations_with_replacement(continuous_arcs(period // 2), n):
            helly, proper = graph_model(period, arcs)
            graph_checks += 1
            helly_checks += helly
            proper_checks += proper

    path_arcs = (0b00111, 0b11100, 0b1110000)
    path_witnesses = (1 << 2) | (1 << 4)
    assert direct_optimum(path_witnesses, path_arcs, [1] * 3) == 2
    assert direct_optimum(path_witnesses, path_arcs, [-1] * 3) == -1
    cycle_arcs = tuple(sum(1 << ((2 * v + i) % 10) for i in range(3)) for v in range(5))
    assert graph_model(10, cycle_arcs) == (True, True)
    for leaves in range(3, 9):
        pts = (1 << leaves) - 1
        star_arcs = tuple([pts] + [1 << i for i in range(leaves)])
        assert circular_cover(leaves, pts, star_arcs, [1] * (leaves + 1))[0] == leaves
        assert direct_optimum(pts, star_arcs, [-1] * (leaves + 1)) == -1

    print("Exhaustive circular cover inputs:", count, "seeded inputs: 400")
    print("Arc graph models:", graph_checks, "Helly:", helly_checks, "proper Helly:", proper_checks)
    print("Tight P3, non-interval C5, and unbounded interval stars verified.")
    print("Exact signed-weight objectives, witnesses and ratio checks passed.")


if __name__ == "__main__":
    main()
