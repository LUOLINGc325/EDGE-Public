"""Exact checks for chordal gadgets, split optimization and interval SMAWK."""

from functools import cache
from fractions import Fraction
from itertools import combinations, combinations_with_replacement
from random import Random


def closed_neighborhoods(order, edges):
    closed = [1 << v for v in range(order)]
    for u, v in edges:
        closed[u] |= 1 << v
        closed[v] |= 1 << u
    return closed


def domination_score(closed, chosen):
    counts = [(mask & chosen).bit_count() for mask in closed]
    return sum(count == 1 for count in counts) if all(counts) else -1


def exact_optimum(closed):
    return max(domination_score(closed, mask) for mask in range(1 << len(closed)))


def row_maxima(rows, columns, value, result):
    """SMAWK for leftmost row maxima in a totally monotone matrix."""
    if not rows:
        return
    reduced = []
    for column in columns:
        while reduced:
            row = rows[len(reduced) - 1]
            if value(row, column) <= value(row, reduced[-1]):
                break
            reduced.pop()
        if len(reduced) < len(rows):
            reduced.append(column)

    row_maxima(rows[1::2], reduced, value, result)
    positions = {column: index for index, column in enumerate(reduced)}
    lower = 0
    for i in range(0, len(rows), 2):
        row = rows[i]
        upper = positions[result[rows[i + 1]]] if i + 1 < len(rows) else len(reduced) - 1
        best = lower
        for j in range(lower + 1, upper + 1):
            if value(row, reduced[j]) > value(row, reduced[best]):
                best = j
        result[row] = reduced[best]
        lower = upper


def interval_solver(intervals):
    n = len(intervals)
    if not n:
        return 0, 0
    end = sorted({x for interval in intervals for x in interval})
    ranks = {x: i + 1 for i, x in enumerate(end)}
    upper = len(end) + 1
    left = [ranks[a] for a, _ in intervals] + [0, upper]
    right = [ranks[b] for _, b in intervals] + [0, upper]
    start, stop = n, n + 1
    by_left = sorted(range(n), key=left.__getitem__)
    by_right = sorted(range(n), key=right.__getitem__, reverse=True)

    prefix = [[0] * (upper + 1) for _ in range(upper + 1)]
    for v in range(n):
        prefix[left[v]][right[v]] += 1
    for a in range(1, upper + 1):
        for b in range(1, upper + 1):
            prefix[a][b] += prefix[a - 1][b] + prefix[a][b - 1] - prefix[a - 1][b - 1]

    def count(a, b, c, d):
        if a > b or c > d:
            return 0
        return prefix[b][d] - prefix[a - 1][d] - prefix[b][c - 1] + prefix[a - 1][c - 1]

    def gap_empty(i, j):
        return not count(right[i] + 1, upper, 1, left[j] - 1)

    scores = {}
    back = {}
    optimum = -1
    final = None
    for j in by_left:
        if gap_empty(start, j):
            scores[start, j] = 0
        columns = [i for i in by_right + [start] if (i, j) in scores]
        if not columns:
            continue
        rows = [k for k in by_left + [stop]
                if left[j] < left[k] and right[j] < right[k] and gap_empty(j, k)]

        def value(k, i):
            return scores[i, j] + count(right[i] + 1, right[j], left[j], left[k] - 1)

        choices = {}
        row_maxima(rows, columns, value, choices)
        for k in rows:
            i = choices[k]
            candidate = value(k, i)
            assert candidate == max(value(k, alternative) for alternative in columns)
            if k == stop:
                if candidate > optimum:
                    optimum = candidate
                    final = i, j
            else:
                scores[j, k] = candidate
                back[j, k] = i

    i, j = final
    chosen = 0
    while i != start:
        chosen |= 1 << j
        i, j = back[i, j], i
    return optimum, chosen | (1 << j)


def check_intervals(intervals):
    edges = ((u, v) for u, v in combinations(range(len(intervals)), 2)
             if max(intervals[u][0], intervals[v][0]) <= min(intervals[u][1], intervals[v][1]))
    closed = closed_neighborhoods(len(intervals), edges)
    value, witness = interval_solver(intervals)
    assert value == domination_score(closed, witness) == exact_optimum(closed)


def split_solver(k, masks):
    core = (1 << k) - 1
    edges = list(combinations(range(k), 2))
    edges.extend((u, v) for v, mask in enumerate(masks, k)
                 for u in range(k) if mask & (1 << u))
    closed = closed_neighborhoods(k + len(masks), edges)
    choices = [((1 << len(closed)) - 1) ^ core]
    for u in range(k):
        forced = sum(1 << v for v in range(k, len(closed)) if not closed[v] & (1 << u))
        choices.append(forced | (1 << u))
    witness = max(choices, key=lambda choice: domination_score(closed, choice))
    value = domination_score(closed, witness)
    assert value == exact_optimum(closed)
    return value


def combine(children):
    table = {0: 0}
    for profile in children:
        updated = {}
        for count, score in table.items():
            for selected, extra in profile.items():
                index = min(2, count + selected)
                updated[index] = max(updated.get(index, -1), score + extra)
        table = updated
    return table


@cache
def tree_profiles(tree, parent_selected):
    output = {}
    for root_selected in (0, 1):
        children = combine(tree_profiles(child, root_selected) for child in tree)
        options = [score + int(count + root_selected + parent_selected == 1)
                   for count, score in children.items() if count + root_selected + parent_selected]
        if options:
            output[root_selected] = max(options)
    return output


def reduction_optima(universe, sets):
    s, u = len(sets), len(universe)
    assert set.union(*sets) == universe
    step = s + u + 1
    penalty = step * s + s + u + 1
    core_edges = list(combinations(range(s), 2))
    core_edges.extend((j, s + v) for j, subset in enumerate(sets) for v in subset)
    closed = closed_neighborhoods(s + u, core_edges)
    path = ((),)
    branch = ((),) + (path,) * penalty
    baseline = 2 * s * step + u * penalty * (2 + 2 * penalty)
    candidates = {}
    for selected in (0, 1):
        candidates["set", selected] = combine([tree_profiles(path, selected)] * step)
        candidates["element", selected] = combine([tree_profiles(branch, selected)] * penalty)

    actual = -1
    for chosen in range(1 << (s + u)):
        score = 0
        for v in range(s + u):
            vertex_type = "set" if v < s else "element"
            selected = int(bool(chosen & (1 << v)))
            table = candidates[vertex_type, selected]
            core_count = (closed[v] & chosen).bit_count()
            options = [value + int(count + core_count == 1) for count, value in table.items()
                       if count + core_count]
            if not options:
                break
            score += max(options)
        else:
            actual = max(actual, score)

    minimum = next(size for size in range(1, s + 1)
                   if any(set.union(*chosen_sets) == universe
                          for chosen_sets in combinations(sets, size)))
    assert baseline - step * minimum <= actual <= baseline - step * minimum + s + u
    for budget in range(s + 1):
        assert (actual >= baseline - step * budget) == (minimum <= budget)


def check_linear_thresholds():
    for r in (3, 4, 5):
        pairs = tuple(combinations(range(r), 2))
        k = len(pairs)
        masks = tuple(sum(1 << i for i, pair in enumerate(pairs) if v in pair)
                      for v in range(r))
        assert split_solver(k, masks) == r + 1

    count = 0
    for n in (1, 2, 5, 10, 50, 100):
        for ratio in map(Fraction, ("0.01", "0.25", "0.5", "0.8", "0.95", "0.99")):
            r = 2 // ratio + 1
            filler_order = r * (r + 1) // 2
            filler_score = r + 1
            leap = ratio * filler_order - filler_score
            assert leap > 0
            copies = n * (1 - ratio) // leap + 1
            order = n + copies * filler_order
            target = n + copies * filler_score
            isolates = -(-(ratio * order - target) // (1 - ratio))
            lhs = ratio * (order + isolates)
            assert target + isolates - 1 < lhs <= target + isolates
            for exact in range(n + 1):
                assert (exact + copies * filler_score + isolates >= lhs) == (exact == n)
            count += 1
    return count


def main():
    options = tuple(combinations_with_replacement(range(4), 2))
    intervals_checked = 0
    for size in range(7):
        for intervals in combinations_with_replacement(options, size):
            check_intervals(intervals)
            intervals_checked += 1
    rng = Random(20261124)
    for _ in range(300):
        intervals = [tuple(sorted(rng.choices(range(9), k=2))) for _ in range(rng.randrange(10))]
        check_intervals(intervals)
    split_checks = 0
    for k in range(5):
        for size in range(5):
            for masks in combinations_with_replacement(range(1 << k), size):
                split_solver(k, masks)
                split_checks += 1
    reduction_checks = 0
    for u in range(1, 4):
        universe = set(range(u))
        family = [set(e) for r in range(1, u + 1) for e in combinations(range(u), r)]
        for s in range(1, 4):
            for sets in combinations(family, s):
                if set.union(*sets) == universe:
                    reduction_optima(universe, sets)
                    reduction_checks += 1
    print("Exhaustive interval multisets:", intervals_checked, "seeded intervals: 300")
    print("Exact split instances:", split_checks, "exact chordal reductions:", reduction_checks)
    print("Exact fixed proportional threshold calibrations:", check_linear_thresholds())
    print("Verified all interval witnesses and every reduction threshold.")


if __name__ == "__main__":
    main()
