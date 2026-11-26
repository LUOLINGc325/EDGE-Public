"""Exact checks of arbitrary-rank-interval smoothing with unbounded atom width."""
from fractions import Fraction as Q
from itertools import combinations, product
from math import factorial
import sys

sys.dont_write_bytecode = True
from exact_certificate import atom_overlap, finite_n, forced


def check_intervals(m, q):
    bands = (q / m,) * m + (1 - q,)
    thresholds = (Q(0), *(i * q / m for i in range(1, m + 1)), Q(1))
    pair = [[forced(m, bands, i, j) for j in range(m + 1)] for i in range(m + 1)]
    grid = sorted(set(thresholds) | {Q(i, 12) for i in range(13)})
    checked, strict, multi = 0, 0, 0
    for a, b in combinations(grid, 2):
        masses = [
            atom_overlap(a, b, left, right)
            for left, right in zip(thresholds, thresholds[1:])
        ]
        diagonal = sum(mass * pair[i][i] for i, mass in enumerate(masses))
        mixed = sum(
            pi * pj * pair[i][j]
            for (i, pi), (j, pj) in product(enumerate(masses), repeat=2)
        )
        assert 0 <= diagonal - mixed
        checked += 1
        strict += diagonal > mixed
        multi += sum(mass > 0 for mass in masses) >= 3
    return checked, strict, multi


def main():
    q_grid = (Q(1, 20), Q(1, 5), Q(1, 2), Q(3, 4), Q(19, 20))
    totals = [0, 0, 0]
    for m, q in product(range(2, 8), q_grid):
        for j, count in enumerate(check_intervals(m, q)):
            totals[j] += count
    print(f"{totals[0]} exact interval inequalities, {totals[1]} strict")
    print(f"{totals[2]} intervals cross at least two Simes thresholds")

    laws = ((Q(1),), (Q(1, 5), Q(4, 5)), (Q(1, 4), Q(1, 2), Q(1, 4)),
            (Q(1, 10), Q(3, 10), Q(1, 5), Q(2, 5)))
    tested = 0
    for m, q, n, masses in product(range(2, 6), q_grid, (1, 3, 5), laws):
        assert finite_n(m, q, n, masses, (Q(1),) * len(masses)) <= q
        tested += 1
    print(f"{tested} unweighted finite-sample laws: exact marginals and Simes control")

    q = Q(99, 100)
    taylor_lower = sum(q**j / factorial(j) for j in range(5))
    assert taylor_lower > Q(8, 3)
    assert Q(4, 5) * (1 - 1 / taylor_lower) > Q(1, 2)
    print("q=99/100, B=5: rational Taylor comparison is strict")


if __name__ == "__main__":
    main()
