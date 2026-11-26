"""Small exact checks of the signed holdout and paired-alternative identities."""

from fractions import Fraction
from itertools import product
import json
from math import comb, factorial


def require(condition):
    if not condition:
        raise ValueError("exact identity failed")


def mixture_checks():
    checks = 0
    for pairs in range(1, 5):
        signs = list(product((-1, 1), repeat=pairs))
        for epsilon in (Fraction(1, 16), Fraction(1, 8), Fraction(1, 4)):
            q = Fraction(1, 2 * pairs)
            alternatives = [
                [q * (1 + 2 * epsilon * sign[j] * (-1) ** parity)
                 for j in range(pairs) for parity in range(2)]
                for sign in signs
            ]
            for law in alternatives:
                require(sum(law) == 1 and sum(abs(m - q) for m in law) / 2 == epsilon)
            for draws in range(1, 6):
                moment = sum(
                    sum(a * b / q for a, b in zip(first, second)) ** draws
                    for first in alternatives for second in alternatives
                ) / len(alternatives) ** 2
                count_formula = sum(
                    comb(pairs, j) * (1 + 4 * epsilon ** 2 * (2 * j - pairs) / pairs) ** draws
                    for j in range(pairs + 1)
                ) / 2 ** pairs
                require(moment == count_formula)
                checks += 1
    return checks


def convolution_checks():
    checks = 0
    means = (Fraction(0), Fraction(1, 7), Fraction(2), Fraction(11, 3))
    for left, right in product(means, repeat=2):
        for total in range(10):
            convolution = sum(
                left ** i * right ** (total - i) / (factorial(i) * factorial(total - i))
                for i in range(total + 1)
            )
            require(convolution == (left + right) ** total / factorial(total))
            checks += 1
    return checks


def accuracy_checks():
    checks = 0
    for n in range(1, 31):
        for p_count, q_count in product(range(n + 1), repeat=2):
            direct = Fraction(p_count - q_count, n)
            accuracy = Fraction(p_count + n - q_count, 2 * n)
            require(direct == 2 * accuracy - 1)
            complement = Fraction((n - p_count) - (n - q_count), n)
            require(complement == -direct)
            checks += 1
    return checks


if __name__ == "__main__":
    print(json.dumps({
        "paired_mixture_second_moment_checks": mixture_checks(),
        "poisson_padding_convolution_checks": convolution_checks(),
        "balanced_accuracy_and_complement_checks": accuracy_checks(),
    }, indent=2))
