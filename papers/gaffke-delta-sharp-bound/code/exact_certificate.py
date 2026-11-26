"""Exact checks of the Gaffke leave-one-out inequalities."""
from fractions import Fraction as F
from functools import cache
from itertools import combinations_with_replacement
from math import prod


@cache
def tail_probabilities(x):
    """Return (Pr(S>0), Pr(S>E0)); signed exponential difference recursion."""
    if x and x[0] == 1:
        return tail_probabilities(x[1:])
    if not x or x[-1] <= 1:
        return F(0), F(0)
    if x[0] >= 1:
        return F(1), 1 - prod(1 / value for value in x)
    a, d = x[-1] - 1, 1 - x[0]
    stay_positive = tail_probabilities(x[1:])
    stay_negative = tail_probabilities(x[:-1])
    return tuple(
        (a * positive + d * negative) / (a + d)
        for positive, negative in zip(stay_positive, stay_negative, strict=True)
    )


def partial_fractions(x):
    """Independent Laplace product calculation when positive scales are distinct."""
    positive = [value - 1 for value in x if value > 1]
    negative = [1 - value for value in x if value < 1]
    if len(positive) != len(set(positive)) or not positive:
        return None
    a = d = F(0)
    for scale in positive:
        signed_weight = prod(scale / (scale - other) for other in positive if other != scale)
        matched = signed_weight * prod(1 / (1 + deficit / scale) for deficit in negative)
        a += matched
        d += matched / (1 + 1 / scale)
    return a, d


def verify(x):
    a, d = tail_probabilities(x)
    delta = a - d
    assert 0 <= d <= a <= 1
    r = sum(value < 1 for value in x)
    positives = sum(value > 1 for value in x)
    assert d ** (len(x) - 1) <= a ** len(x)
    strict_equality = positives == 1 and r == len(x) - 1 and all(v == 0 for v in x[:-1])
    if d > 0:
        assert (d ** (len(x) - 1) == a ** len(x)) == strict_equality
    if r and positives:
        assert d**r <= a ** (r + 1)
        assert (d**r == a ** (r + 1)) == (positives == 1 and all(v == 0 for v in x[:r]))
    for i, value in enumerate(x):
        _, d_deleted = tail_probabilities(x[:i] + x[i + 1:])
        assert d - d_deleted == (value - 1) * delta
    independently = partial_fractions(x)
    if independently is not None:
        assert independently == (a, d)
    return independently is not None


def main():
    alphabet = (F(0), F(1, 4), F(1, 2), F(1), F(3, 2), F(2), F(3), F(5))
    count = independent = 0
    for n in range(2, 7):
        for x in combinations_with_replacement(alphabet, n):
            independent += verify(x)
            count += 1
    print(f"Exact vectors checked, including repeated and neutral coordinates: {count}")
    print(f"Independent partial-fraction confirmations: {independent}")
    for x in ((F(0), F(1, 2), F(2), F(4)), (F(0), F(0), F(1), F(3))):
        a, d = tail_probabilities(x)
        print(f"{','.join(str(z) for z in x)}: K={1-d}, Delta={a-d}")


if __name__ == "__main__":
    main()
