#!/usr/bin/env python3
"""Exact finite checks for the quantile-slot and endpoint formula.

The exhaustive oracle enumerates tables, which does not assume the cut
conditions or construct tables from the proposed formula. All calculations
use integer masses and a common denominator.
"""

from collections import defaultdict
from itertools import combinations_with_replacement, product
from random import Random


def compositions(total, cells):
    """Enumerate every ordered weak composition."""
    if cells == 1:
        yield (total,)
        return
    for first in range(total + 1):
        for rest in compositions(total - first, cells - 1):
            yield (first,) + rest


def table_margins(table, categories):
    rows = tuple(sum(table[i * categories : (i + 1) * categories])
                 for i in range(categories))
    cols = tuple(sum(table[j::categories]) for j in range(categories))
    return rows, cols


def success_masses(table, thresholds):
    categories = len(thresholds)
    return tuple(sum(table[i * categories + j]
                     for i in range(threshold, categories))
                 for j, threshold in enumerate(thresholds))


def cut_test(g, control, cdf, total):
    return all(
        sum(control[j] - g[j] for j in range(k + 1)) <= value
        and sum(g[k:]) <= total - value
        for k, value in enumerate(cdf)
    )


def endpoints(control, cdf, lower, upper, total):
    for k, value in enumerate(cdf):
        if sum(upper[: k + 1]) < sum(control[: k + 1]) - value:
            return None
        if sum(lower[k:]) > total - value:
            return None
    lo = max(sum(lower), *(sum(control[: k + 1]) - value + sum(lower[k + 1 :])
                           for k, value in enumerate(cdf)))
    hi = min(sum(upper), *(total - value + sum(upper[:k])
                           for k, value in enumerate(cdf)))
    return (lo, hi) if lo <= hi else None


def monotone_boxes(control, rng):
    """Unrestricted bounds and deterministic random integer boxes."""
    yield (0,) * len(control), control
    for _ in range(6):
        pairs = [sorted((rng.randrange(c + 1), rng.randrange(c + 1))) for c in control]
        yield tuple(p[0] for p in pairs), tuple(p[1] for p in pairs)


def check(total=6, categories=3):
    """Compare the cut and interval conditions against complete tables."""
    oracle = defaultdict(list)
    for table in compositions(total, categories * categories):
        oracle[table_margins(table, categories)].append(table)

    rng = Random(15754)
    n_vectors = 0
    n_boxes = 0
    for thresholds in combinations_with_replacement(range(categories + 1), categories):
        for (treated, control), tables in oracle.items():
            cdf = tuple(sum(treated[:cut]) for cut in thresholds)
            attained = {success_masses(table, thresholds) for table in tables}
            for g in product(*(range(c + 1) for c in control)):
                assert cut_test(g, control, cdf, total) == (g in attained), (
                    thresholds, treated, control, g
                )
                n_vectors += 1
            for lower, upper in monotone_boxes(control, rng):
                actual = {sum(g) for g in attained
                          if all(lo <= v <= hi for lo, v, hi in zip(lower, g, upper))}
                bounds = endpoints(control, cdf, lower, upper, total)
                predicted = set() if bounds is None else set(range(bounds[0], bounds[1] + 1))
                assert actual == predicted, (thresholds, treated, control, lower, upper, bounds, actual)
                n_boxes += 1
    tables = sum(map(len, oracle.values()))
    print(f"Verified {n_vectors:,} candidate mass vectors and {n_boxes:,} boxes "
          f"against all {tables:,} tables at denominator {total}.")


def check_examples():
    """Check the exact weak-DTD and two-sided strict examples."""
    control = (3, 3, 3)
    weak = (0, 1, 2, 2, 0, 1, 1, 2, 0)
    assert table_margins(weak, 3) == (control, control)
    assert success_masses(weak, (0, 1, 2)) == (3, 2, 0)
    assert endpoints(control, (0, 3, 6), (0, 2, 0), control, 9) == (5, 9)
    upper = (2, 0, 1, 1, 0, 2, 0, 3, 0)
    lower = (3, 0, 0, 0, 2, 1, 0, 1, 2)
    assert endpoints(control, (3, 6, 9), (0, 1, 0), (1, 3, 3), 9) == (1, 4)
    for table, expected in ((lower, (0, 1, 0)), (upper, (1, 3, 0))):
        assert table_margins(table, 3) == (control, control)
        assert success_masses(table, (1, 2, 3)) == expected
    print("Verified the weak-DTD and two-sided strict examples at denominator 9.")


if __name__ == "__main__":
    check()
    check_examples()
