#!/usr/bin/env python3
"""Reproduce the weighted projector checks using rational arithmetic."""

from fractions import Fraction as F
from itertools import product


def dot(left, right):
    return sum(a * b for a, b in zip(left, right, strict=True))


def multiply(matrix, vector):
    return tuple(dot(row, vector) for row in matrix)


def transpose(matrix):
    return tuple(zip(*matrix, strict=True))


def season(rates, right):
    n = len(rates)
    matrix = [[F(0) for _ in rates] for _ in rates]
    for i in range(n):
        previous = (i - 1) % n
        matrix[i][previous] = rates[previous]
        matrix[i][i] = -rates[previous] * right[previous] / right[i]
    return matrix


def left_vector(rates, right):
    values = tuple(1 / (rates[i - 1] * right[i - 1]) for i in range(len(rates)))
    normalization = dot(values, right)
    return tuple(value / normalization for value in values)


def verify_pair(rates, right):
    ones = (F(1),) * len(rates)
    zero = (F(0),) * len(rates)
    left_first = left_vector(rates, ones)
    left_second = left_vector(rates, right)
    first = season(rates, ones)
    second = season(rates, right)
    assert multiply(first, ones) == multiply(second, right) == zero
    assert multiply(transpose(first), left_first) == multiply(transpose(second), left_second) == zero
    assert dot(left_first, ones) == dot(left_second, right) == 1
    overlap = dot(left_second, ones) * dot(left_first, right)
    weights = tuple(1 / rates[i - 1] for i in range(len(rates)))
    ratios = tuple(right[i] / right[i - 1] for i in range(len(rates)))
    inverse_previous = tuple(1 / right[i - 1] for i in range(len(rates)))
    formula = dot(weights, right) * dot(weights, inverse_previous) / (sum(weights) * dot(weights, ratios))
    assert overlap == formula
    return overlap


def verify_weight_grid():
    checked = 0
    for n in range(3, 7):
        for rates in product((F(1, 2), F(1), F(3)), repeat=n):
            weights = tuple(1 / rates[i - 1] for i in range(n))
            factor = weights[-1] * weights[1] / sum(weights)**2
            m = 1 + 1 / factor
            # Use squared geometric entries so the half-time AM–GM witness
            # is rational and can be checked directly against the two matrices.
            right = tuple(m**(2 * i) for i in range(n))
            x = tuple(m**i for i in range(n))
            assert verify_pair(rates, right) >= factor * m**(2 * (n - 2)) > 1
            fast_left = multiply(season(rates, (F(1),) * n), x)
            fast_right = multiply(season(rates, right), x)
            assert all(a + b < 0 for a, b in zip(fast_left, fast_right, strict=True))
            checked += 1
    return checked


def verify_four_cycle():
    for denominator in range(1, 65):
        for direction in (-1, 1):
            u = F(1) + F(direction, denominator + 1)
            right = (u, F(1), 1 / u, F(1))
            overlap = verify_pair((F(1),) * 4, right)
            assert overlap > 1
            assert (overlap - 1) / (u - 1)**4 == 1 / (8 * u * (u*u + 1))
    assert F(1, 8) / (1 + 1) == F(1, 16)
    return 128


def main():
    assert verify_pair((F(1),) * 3, (F(1), F(4), F(16))) == F(49, 43)
    assert verify_pair((F(1),) * 4, (F(1), F(2), F(4), F(8))) == F(225, 196)
    assert verify_pair((F(1),) * 4, (F(2), F(1), F(1, 2), F(1))) == F(81, 80)
    print("Exact overlaps: 49/43, 225/196, 81/80.")
    print(f"Weighted cycle projector, overlap lower bound and fast witness: {verify_weight_grid()} cases.")
    print(f"Exact quartic identity: {verify_four_cycle()} rational amplitudes.")
    print("All checks passed.")


if __name__ == "__main__":
    main()
