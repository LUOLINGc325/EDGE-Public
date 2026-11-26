"""Exact finite-sample rank, calibration and width certificates."""
from collections import Counter, defaultdict
from fractions import Fraction as F
from functools import cache
from itertools import permutations, product
from math import factorial, prod


def rank_fraction(sample):
    counts = Counter(sample)
    n = len(sample)
    ways = factorial(n) // prod(factorial(c) for c in counts.values())
    total = ways
    rank = 1
    for i, value in enumerate(sample):
        remaining = n - i
        for smaller, count in counts.items():
            if smaller < value and count:
                rank += ways * count // remaining
        ways = ways * counts[value] // remaining
        counts[value] -= 1
    assert ways == 1 and 1 <= rank <= total
    return F(rank, total)


@cache
def k_statistic(sorted_sample):
    if not sorted_sample or sorted_sample[-1] <= 1:
        return F(1)
    if sorted_sample[0] >= 1:
        return 1 / prod(sorted_sample)
    positive, negative = sorted_sample[-1] - 1, 1 - sorted_sample[0]
    return (
        positive * k_statistic(sorted_sample[1:])
        + negative * k_statistic(sorted_sample[:-1])
    ) / (positive + negative)


def p_value(scaled, rank):
    if min(scaled) >= 1:
        return rank / prod(scaled)
    return k_statistic(tuple(sorted(scaled)))


def check_iid_law(values, probabilities, n):
    mean = sum(value * p for value, p in zip(values, probabilities, strict=True))
    histograms = defaultdict(F), defaultdict(F)
    for indices in product(range(len(values)), repeat=n):
        x = tuple(values[i] for i in indices)
        prob = prod(probabilities[i] for i in indices)
        rank = rank_fraction(x)
        for which, scaled in enumerate(
            (tuple(z / mean for z in x), tuple((1 - z) / (1 - mean) for z in x))
        ):
            p = p_value(scaled, rank)
            assert p <= k_statistic(tuple(sorted(scaled)))
            histograms[which][p] += prob
    for histogram in histograms:
        probability = F(0)
        for p in sorted(histogram):
            probability += histogram[p]
            assert probability <= p
        assert probability == 1


def floor_root(numerator, degree):
    left, right = 0, 1
    while right**degree <= numerator:
        right *= 2
    while right - left > 1:
        middle = (right + left) // 2
        if middle**degree <= numerator:
            left = middle
        else:
            right = middle
    return left


def root_interval(x, degree):
    scale = 2**160
    lower = floor_root(x.numerator * scale**degree // x.denominator, degree)
    return F(lower, scale), F(lower + 1, scale)


def decimal_interval(interval, places=12):
    scale = 10**places
    a, b = (x * scale for x in interval)
    lower = a.numerator // a.denominator
    upper = -(-b.numerator // b.denominator)

    def show(x):
        assert x >= 0
        return f"{x // scale}.{x % scale:0{places}d}"

    return f"[{show(lower)}, {show(upper)}]"


def example():
    x = (F(49, 100), F(1, 2), F(51, 100))
    alpha = F(1, 40)
    rank = rank_fraction(x)
    P = prod(x)
    assert rank == F(1, 6) and tuple(1 - z for z in reversed(x)) == x
    assert x[0]**3 / P > alpha / rank
    old = root_interval(alpha * P, 3)
    improved = root_interval(alpha * P / rank, 3)
    gain = 2 * (improved[0] - old[1]), 2 * (improved[1] - old[0])
    theoretical = root_interval(alpha / rank, 3), root_interval(alpha, 3)
    supremum = theoretical[0][0] - theoretical[1][1], theoretical[0][1] - theoretical[1][0]
    assert 0 < gain[0] <= gain[1] < supremum[0]
    print(f"Three-observation 95% width reduction: {decimal_interval(gain)}")
    print(f"Sharp three-observation supremum: {decimal_interval(supremum)}")


def main():
    examples = [(1, 1, 1, 1), (1, 1, 2, 2), (1, 2, 2, 3), (1, 2, 3, 4, 5)]
    checked = 0
    for pattern in examples:
        orbit = sorted(set(permutations(pattern)))
        for i, sample in enumerate(orbit, 1):
            assert rank_fraction(sample) == F(i, len(orbit))
            checked += 1
    print(f"Lexicographic orbit ranks verified with and without ties: {checked}")
    laws = [
        ((F(0), F(1)), (F(2, 3), F(1, 3))),
        ((F(0), F(1, 2), F(1)), (F(1, 4), F(1, 2), F(1, 4))),
        ((F(1, 3), F(1, 2), F(2, 3)), (F(1, 6), F(1, 3), F(1, 2))),
    ]
    for values, probabilities in laws:
        for n in (2, 3, 4, 5):
            check_iid_law(values, probabilities, n)
    print("Exact discrete IID null calibration: 24 one-sided distributions")
    example()


if __name__ == "__main__":
    main()
