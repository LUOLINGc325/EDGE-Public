#!/usr/bin/env python3
"""Exact rank enumeration for pilot-grid conformal calibration."""

from fractions import Fraction
from itertools import combinations
from math import comb, prod


def next_rank(count, offset, width):
    """First boundary strictly above the pilot count."""
    return count + width - (count + offset) % width


def output_rank(count, offset, width, pilot_size):
    """Rank pilot_size + 1 represents infinity."""
    return min(next_rank(count, offset, width), pilot_size + 1)


def exact_offset_check():
    comparisons = 0
    for pilot_size in range(21):
        for width in range(1, 14):
            for first in range(pilot_size + 1):
                distances = {next_rank(first, offset, width) - first
                             for offset in range(width)}
                assert distances == set(range(1, width + 1))
                for second in range(first, pilot_size + 1):
                    count = sum(output_rank(first, off, width, pilot_size)
                                != output_rank(second, off, width, pilot_size)
                                for off in range(width))
                    assert count == min(width, second - first)
                    comparisons += 1
    print(f"Verified {comparisons:,} exact offset counts, including overflow.")


def pooled_words(n, m):
    """Pooled rank labels for two private n-samples and a pilot of size m."""
    indices = tuple(range(2 * n + m))
    for pilot in combinations(indices, m):
        private = tuple(i for i in indices if i not in pilot)
        for first in combinations(private, n):
            second = tuple(i for i in private if i not in first)
            yield pilot, first, second


def disagreement_from_pooled_ranks(n, k, m, b):
    numerator = 0
    words = 0
    for pilot, first, second in pooled_words(n, m):
        first_count = sum(rank < first[k - 1] for rank in pilot)
        second_count = sum(rank < second[k - 1] for rank in pilot)
        numerator += sum(output_rank(first_count, s, b, m)
                         != output_rank(second_count, s, b, m)
                         for s in range(b))
        words += 1
    return Fraction(numerator, words * b)


def rising(value, length):
    return prod(range(value, value + length))


def beta_binomial(prob_count, shapes, count):
    a, b = shapes
    return Fraction(comb(prob_count, count) * rising(a, count)
                    * rising(b, prob_count - count), rising(a + b, prob_count))


def disagreement_from_beta_binomial(n, k, m, b):
    total = 0
    private = tuple(range(2 * n))
    for first in combinations(private, n):
        second = tuple(i for i in private if i not in first)
        separation = abs(first[k - 1] - second[k - 1])
        total += sum(
            Fraction(min(b, count), b)
            * beta_binomial(m, (separation, 2 * n + 1 - separation), count)
            for count in range(m + 1)
        )
    return total / comb(2 * n, n)


def inflation_from_pooled_ranks(n, k, m, b):
    """Average PIT inflation by exact means of labels' pooled order statistics."""
    total = 0
    words = 0
    for pilot in combinations(range(n + m), m):
        private = tuple(i for i in range(n + m) if i not in pilot)
        private_rank = private[k - 1] + 1
        count = sum(i < private_rank - 1 for i in pilot)
        for s in range(b):
            rank = output_rank(count, s, b, m)
            public_rank = n + m + 1 if rank == m + 1 else pilot[rank - 1] + 1
            total += public_rank - private_rank
            words += 1
    return Fraction(total, words * (n + m + 1))


def inflation_from_spacings(n, k, m, b):
    """Average conditional upper-order-statistic means after a beta-binomial count."""
    return sum(
        beta_binomial(m, (k, n + 1 - k), count)
        * Fraction(n + 1 - k + m - count, n + 1 + m)
        * Fraction(sum(min(d, m - count + 1) for d in range(1, b + 1)),
                   b * (m - count + 1))
        for count in range(m + 1)
    )


def exact_distribution_check():
    cases = 0
    for n in range(1, 4):
        for k in range(1, n + 1):
            for m in range(1, 7):
                for b in range(1, m + 3):
                    assert disagreement_from_pooled_ranks(n, k, m, b) == (
                        disagreement_from_beta_binomial(n, k, m, b)
                    )
                    observed = inflation_from_pooled_ranks(n, k, m, b)
                    assert observed == inflation_from_spacings(n, k, m, b)
                    assert observed <= Fraction(b + 1, 2 * (m + 1))
                    cases += 1
    print(f"Verified exact disagreement and expected inflation in {cases:,} parameter cases.")


if __name__ == "__main__":
    exact_offset_check()
    exact_distribution_check()
