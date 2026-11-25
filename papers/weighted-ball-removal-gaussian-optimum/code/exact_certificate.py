#!/usr/bin/env python3
"""Compare discrete recursion, integrated Erlang clocks, and binomial loss."""

from collections import Counter
from fractions import Fraction
from functools import cache
from itertools import combinations
from math import comb, factorial


def compositions(total, length):
    if length == 1:
        yield (total,)
        return
    for head in range(total + 1):
        for rest in compositions(total - head, length - 1):
            yield (head, *rest)


@cache
def discrete_loss(counts, weights):
    nonempty = [i for i, amount in enumerate(counts) if amount]
    if len(nonempty) <= 1:
        return Fraction(sum(counts))
    weight_sum = sum(weights[i] for i in nonempty)
    return sum(
        weights[i]
        * discrete_loss(counts[:i] + (counts[i] - 1,) + counts[i + 1 :], weights)
        for i in nonempty
    ) / weight_sum


def multiply_poly(left, right):
    result = [Fraction(0)] * (len(left) + len(right) - 1)
    for i, a in enumerate(left):
        for j, b in enumerate(right):
            result[i + j] += a * b
    return result


@cache
def erlang_intersection(counts, weights):
    """Integrate the product of independent Erlang survival functions."""
    polynomial = [Fraction(1)]
    for amount, rate in zip(counts, weights):
        survival_coefficients = [rate**d / factorial(d) for d in range(amount)]
        polynomial = multiply_poly(polynomial, survival_coefficients)
    rate_sum = sum(weights)
    return sum(
        coeff * factorial(degree) / rate_sum ** (degree + 1)
        for degree, coeff in enumerate(polynomial)
    )


def erlang_loss(counts, weights):
    nonempty = [i for i, amount in enumerate(counts) if amount]
    total = Fraction(0)
    for size in range(1, len(nonempty) + 1):
        sign = (-1) ** (size - 1)
        for subset in combinations(nonempty, size):
            # A given subset occurs once for each possible winning Erlang.
            pairs = sorted((weights[i], counts[i]) for i in subset)
            rates, shapes = map(tuple, zip(*pairs))
            total += sign * sum(rates) * erlang_intersection(shapes, rates)
    return total


def binomial_losses(n, p):
    q = 1 - p
    mass = [comb(n, j) * p**j * q ** (n - j) for j in range(n + 1)]
    losses = []
    minimizers = []
    cdf = Fraction(0)
    for a in range(n + 1):
        losses.append(
            sum(
                mass[j] * (Fraction(max(j - a, 0), p) + Fraction(max(a - j, 0), q))
                for j in range(n + 1)
            )
        )
        if cdf <= q <= cdf + mass[a]:
            minimizers.append(a)
        cdf += mass[a]
    return losses, minimizers


def exact_profiles():
    profiles = (
        (1, 1),
        (2, 1),
        (5, 1),
        (1, 1, 1),
        (5, 2, 1),
        (9, 2, 1),
        (5, 4, 2, 1),
        (13, 4, 2, 1),
        (5, 3, 2, 2, 1),
    )
    verified = Counter()
    for profile in profiles:
        weights = tuple(Fraction(x, sum(profile)) for x in profile)
        for n in range(1, 10):
            allocations = list(compositions(n, len(weights)))
            discrete = [discrete_loss(a, weights) for a in allocations]
            integrated = [erlang_loss(a, weights) for a in allocations]
            assert discrete == integrated, (n, profile)
            verified[len(weights)] += len(allocations)
            if len(weights) == 2:
                losses, quantiles = binomial_losses(n, weights[0])
                exact_minimizers = [a[0] for a, val in zip(allocations, discrete)
                                    if val == min(discrete)]
                assert discrete == losses, (n, profile)
                assert exact_minimizers == quantiles, (n, profile)

    print("Exact discrete/Erlang comparisons")
    for k, count in sorted(verified.items()):
        print(f"  k={k}: {count} allocations")
    print(f"  total: {sum(verified.values())} allocations")

    extended = 0
    for numerator, denominator in ((1, 2), (1, 7), (2, 5), (5, 6), (14, 15)):
        p = Fraction(numerator, denominator)
        weights = (p, 1 - p)
        for n in range(1, 31):
            losses, quantiles = binomial_losses(n, p)
            discrete = [discrete_loss((a, n - a), weights) for a in range(n + 1)]
            assert discrete == losses, (n, p)
            assert [a for a, val in enumerate(discrete) if val == min(discrete)] == quantiles
            extended += len(discrete)
    print(f"Exact discrete/binomial comparisons and quantile checks: {extended} allocations")

    losses, quantiles = binomial_losses(6, Fraction(5, 6))
    assert quantiles == [4]
    assert losses[4] == Fraction(139, 81)
    assert losses[5] == Fraction(3125, 1296)
    print("Correa et al. example n=6, p=5/6")
    print(f"  all losses: {', '.join(map(str, losses))}")
    print(f"  unique minimizer: ({quantiles[0]}, {6 - quantiles[0]})")


if __name__ == "__main__":
    exact_profiles()
