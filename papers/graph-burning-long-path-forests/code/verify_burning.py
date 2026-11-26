"""Exact deterministic certificates and regression cases for the graph-burning construction."""
from hashlib import sha256
from json import dumps
from math import isqrt
from random import Random

from construct_burning import (
    build_banks, exact_odd_partition, initial_bank_totals, odd,
    orient_bank, projected_centers, threshold, verify_cover,
)


def verify_partition(groups, targets):
    rounds = isqrt(sum(targets))
    assert sorted(j for group in groups for j in group) == list(range(1, rounds + 1))
    assert [sum(2*j - 1 for j in group) for group in groups] == targets


def run_forest(orders, label):
    groups = []
    centers, groups, stats = projected_centers(orders)
    padded = orders.copy()
    padded[-1] += stats['padding']
    verify_partition(groups, padded)
    assert verify_cover(orders, centers)
    digest = sha256(dumps(groups, separators=(',', ':')).encode()).hexdigest()
    return dict(label=label, n=len(orders), original_total=sum(orders),
                min_order=min(orders), certificate_sha256=digest, **stats)


def run():
    reports = []
    # The guaranteed bound starts exactly at a square total when all paths are tied.
    for n in (2, 3, 4, 5, 8, 16, 33):
        L = threshold(n)
        reports.append(run_forest([L] * n, 'all_at_bound'))
    rng = Random(20261124)
    for n in (2, 3, 5, 8, 16):
        L = threshold(n)
        orders = [L + rng.randrange(2 * L) for _ in range(n)]
        reports.append(run_forest(orders, 'heterogeneous_nonsquare'))
        orders = [L] * n
        orders[n // 2] += 100 * L
        reports.append(run_forest(orders, 'single_long_component'))
    for size in (1, 2, 7, 100, 101):
        reports.append(run_forest([size], 'one_path'))
    # Independently check every admissible prefix adjustment on every bank for a base case.
    n = 3
    rounds = isqrt(n * threshold(n))
    banks, used = build_banks(n, rounds)
    tested = 0
    for bank in banks:
        default_left, default_right = initial_bank_totals(*bank)
        for delta in range(2*rounds - 1):
            a, b = orient_bank(*bank, delta)
            assert sum(map(odd, a)) == default_left + delta
            assert sum(map(odd, b)) == default_right - delta
            assert len(set(a+b)) == len(a+b)
            tested += 1
    return {'forests':reports,'all_bank_adjustments_checked':tested}


if __name__ == '__main__':
    print(dumps(run(), indent=2))
