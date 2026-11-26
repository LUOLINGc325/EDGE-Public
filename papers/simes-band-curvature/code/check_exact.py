#!/usr/bin/env python3
"""Check finite Simes band curvatures by independent occupancy enumeration."""

from fractions import Fraction
from math import comb, factorial, prod


def compositions(total, parts):
    if parts == 1:
        yield (total,)
        return
    for first in range(total + 1):
        for rest in compositions(total - first, parts - 1):
            yield (first,) + rest


def rejection_counts(m, q, fixed, band):
    """For r fixed entries, band=0 means forced zeros, otherwise band k+1."""
    uniform = m - fixed
    grid_step = q / m
    widths = [grid_step] * m + [1 - q]
    distribution = [Fraction(0)] * (m + 1)
    for counts in compositions(uniform, m + 1):
        multiplicity = factorial(uniform) // prod(factorial(c) for c in counts)
        mass = multiplicity * prod(width ** c for width, c in zip(widths, counts))
        rank = 0
        running = 0
        for i, count in enumerate(counts[:m], start=1):
            running += count
            supported = running + (fixed if i > band else 0)
            if supported >= i:
                rank = i
        distribution[rank] += mass
    assert sum(distribution) == 1
    return distribution


def forced_mass(m, q, r, i):
    t = q * i / m
    return (1 - q) * comb(m - r, i - r) * t ** (i - r) * (1 - t) ** (m - i - 1)


def tail_curvatures(m, q):
    tails = [Fraction(0)] * (m - 1)
    running = Fraction(0)
    for i in range(m, 1, -1):
        running += 2 * (forced_mass(m, q, 2, i) - forced_mass(m, q, 1, i)) / i
        tails[i - 2] = running
    return tails


def check_occupancy():
    checked = 0
    for m in range(2, 8):
        for q in (Fraction(1, 5), Fraction(2, 3), Fraction(3, 4), Fraction(24, 25)):
            assert 1 - rejection_counts(m, q, 0, 0)[0] == q
            for r in (1, 2):
                actual = rejection_counts(m, q, r, 0)
                assert all(actual[i] == forced_mass(m, q, r, i) for i in range(r, m + 1))
            for k, predicted in enumerate(tail_curvatures(m, q), start=1):
                a1 = 1 - rejection_counts(m, q, 1, k)[0]
                a2 = 1 - rejection_counts(m, q, 2, k)[0]
                assert a2 - 2 * a1 + q == predicted
                checked += 1
    return checked


def check_band_signs():
    checked = 0
    for m in range(2, 61):
        for q in (Fraction(1, 10), Fraction(2, 3), Fraction(3, 4), Fraction(9, 10), Fraction(999, 1000)):
            curvatures = tail_curvatures(m, q)
            signs = [(value > 0) - (value < 0) for value in curvatures]
            assert signs == sorted(signs) and signs.count(0) <= 1
            assert signs[-1] == 1
            assert curvatures[0] == (1 - q) * (2 * (1 - q / m) ** (m - 2) - 1)
            assert sum(curvatures) == 1 - q
            checked += len(curvatures)
    return checked


def main():
    print(f"Independent multinomial occupancy comparisons: {check_occupancy()}")
    print(f"Exact sign and budget checks: {check_band_signs()}")
    m = 40
    q = Fraction(3, 4)
    values = tail_curvatures(m, q)
    assert values[0] < 0
    assert values[1] > 0
    print(f"m={m}, q={q}: first-band rational sign negative, second positive")
    print(f"  Normalized first curvature: {values[0]}")
    q = Fraction(3, 4)
    exponential_lower_bound = 1 + q + q * q / 2
    alternative = (1 - q) * (1 - 1 / exponential_lower_bound)
    conjectured = (1 - q) / 2
    assert alternative == Fraction(33, 260) and alternative > conjectured
    print(f"q={q}: rational lower bound {alternative} exceeds conjectured {conjectured}")
    print("ALL_CHECKS_OK")


if __name__ == "__main__":
    main()
