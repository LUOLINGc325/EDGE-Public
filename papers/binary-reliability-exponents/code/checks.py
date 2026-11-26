"""Exact finite count and adjacent-overlap tests for binary noisy permutation."""

from fractions import Fraction as Q
from itertools import combinations_with_replacement
from random import Random
import json


def require(condition, context):
    if not condition:
        raise RuntimeError(str(context))


def count_laws(n, denominator, low, high):
    laws = []
    for w in range(n+1):
        row = [1]
        for trial in range(n):
            weight = high if trial < w else low
            following = [0] * (len(row)+1)
            for y, mass in enumerate(row):
                following[y] += (denominator-weight)*mass
                following[y+1] += weight*mass
            row = following
        require(sum(row) == denominator**n and min(row) > 0, (n, w))
        laws.append(row)
    return laws


def overlap(left, right):
    return sum(min(x, y) for x, y in zip(left, right))


def verify_pairs():
    rng = Random(20261125)
    pairs = tested_thresholds = 0
    for _ in range(30):
        n, den = rng.randrange(2, 25), rng.randrange(4, 13)
        low, high = sorted(rng.sample(range(1, den), 2))
        laws = count_laws(n, den, low, high)
        for i, left in enumerate(laws):
            for j, right in enumerate(laws[i:], start=i):
                require(all(right[y+1]*left[y] >= right[y]*left[y+1]
                            for y in range(n)), (n, i, j, "monotone likelihood ratio"))
                best_threshold = min(sum(left[cut:])+sum(right[:cut])
                                     for cut in range(n+2))
                require(best_threshold == overlap(left, right),
                        (n, i, j, "binary overlap"))
                pairs += 1
                tested_thresholds += n+2
    return {"channel_horizon_pairs": 30, "composition_pairs": pairs,
            "thresholds_enumerated": tested_thresholds}


def verify_codebooks():
    checked = repeated = 0
    for n, den, a, b in ((6, 4, 1, 3), (9, 5, 1, 3), (12, 9, 2, 7),
                         (15, 6, 1, 4)):
        rows = count_laws(n, den, a, b)
        one = den**n
        overlaps = {(i, j): overlap(rows[i], rows[j])
                    for i in range(n+1) for j in range(i, n+1)}
        for m in (2, 3, 4):
            for comp in combinations_with_replacement(range(n+1), m):
                success = sum(max(rows[w][y] for w in comp) for y in range(n+1))
                total_error = m*one-success
                pair_total = sum(overlaps[i, j] for i, j in zip(comp, comp[1:]))
                require(2*total_error >= pair_total, (n, comp, "average bound"))
                if m == 2:
                    require(total_error == pair_total, (n, comp, "two-message identity"))
                checked += 1
                repeated += int(len(set(comp)) < len(comp))
    return {"ordered_codebooks": checked, "with_repeated_types": repeated}


def verify_symmetric_witness():
    horizons = 0
    for n in range(2, 65, 2):
        rows = count_laws(n, 4, 1, 3)
        ov = Q(overlap(rows[0], rows[-1]), 4**n)
        # The crossing is at 1/2 and exp(-n C) equals (3/4)^(n/2).
        rate = Q(3, 4)**(n//2)
        require(rate/(n+1) <= ov <= 2*rate, (n, "symmetric rate witness"))
        horizons += 1
    return {"even_horizons": horizons, "first_row": "1/4", "last_row": "3/4"}


print(json.dumps({"pair_tests": verify_pairs(),
                  "composed_codebooks": verify_codebooks(),
                  "symmetric_crossing": verify_symmetric_witness()}, indent=2))
