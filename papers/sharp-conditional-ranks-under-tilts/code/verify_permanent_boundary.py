#!/usr/bin/env python3
from fractions import Fraction
from itertools import permutations, product
from math import factorial, prod
from random import Random


def known_first_word(weights, words):
    masses = [prod(weights[i][j] for i, j in enumerate(word)) for word in words]
    return Fraction(masses[0], sum(masses))


def check_matrix(matrix):
    n = len(matrix)
    words = tuple(permutations(range(n)))
    epsilon = Fraction(1, 100)
    reference_0 = (1 - epsilon) / 2
    values = tuple(Fraction(j, n + 1) for j in range(1, n + 1))
    queries = []
    for step in range(n + 1):
        weights = tuple(tuple(1 + Fraction(step * c, n) for c in row) for row in matrix)
        first_mass = known_first_word(weights, words)
        queries.append(prod(weights[i][i] for i in range(n)) / first_mass)
        for row in weights:
            deviation = epsilon / n * sum((v - Fraction(1, 2)) * (w - Fraction(3, 2))
                                           for v, w in zip(values, row))
            lower_tilt = Fraction(3, 2) + 2 * deviation / reference_0
            mass = reference_0 * (lower_tilt + Fraction(3, 2)) + epsilon / n * sum(row)
            first_moment = reference_0 * Fraction(3, 2) + epsilon / n * sum(v * w for v, w in zip(values, row))
            assert 1 <= lower_tilt <= 2 and 2 * first_moment == mass
    while len(queries) > 1:
        queries = [right - left for left, right in zip(queries, queries[1:])]
    result = queries[0] * Fraction(n ** n, factorial(n))
    expected = sum(all(matrix[i][j] for i, j in enumerate(word)) for word in words)
    assert result == expected
    return (n + 1) * n


def main():
    checks = 0
    for bits in product((0, 1), repeat=9):
        checks += check_matrix(tuple(bits[i:i + 3] for i in range(0, 9, 3)))
    rng = Random(95101)
    for _ in range(64):
        checks += check_matrix(tuple(tuple(rng.randrange(2) for _ in range(4)) for _ in range(4)))
    print('Reconstructed all 512 binary 3x3 permanents and 64 binary 4x4 permanents.')
    print(f'Checked {checks} exact bounded-tilt common-mean rows at all interpolation queries.')


if __name__ == '__main__':
    main()
