#!/usr/bin/env python3
"""Rational Collatz–Wielandt certificates for a directed environmental cycle."""

from fractions import Fraction as F


G = ((-1, 1, 0), (0, -1, 1), (1, 0, -1))
SPEEDS = (F(1, 4), F(1, 2), F(1), F(2), F(4))


def lifted(matrices, speed):
    n = len(matrices[0])
    states = tuple((k, i) for k in range(len(G)) for i in range(n))
    out = []
    for k, i in states:
        row = []
        for l, j in states:
            within = F(matrices[k][i][j]) if k == l else F(0)
            across = speed * G[k][l] if i == j else F(0)
            row.append(within + across)
        out.append(tuple(row))
    return tuple(out)


def matvec(matrix, vector):
    return tuple(sum(x * y for x, y in zip(row, vector, strict=True)) for row in matrix)


def bounds(matrix):
    # Integerize the rational matrix and shift it until its entries are positive
    # on the diagonal. Every iterate of the shifted matrix is strictly positive.
    scale = 4
    integer = tuple(tuple(int(scale * a) for a in row) for row in matrix)
    assert all(F(a, scale) == b for ra, rb in zip(integer, matrix, strict=True)
               for a, b in zip(ra, rb, strict=True))
    shift = max(0, 1 - min(integer[i][i] for i in range(len(integer))))
    vector = (1,) * len(integer)
    lo = None
    hi = None
    for _ in range(1200):
        image = matvec(integer, vector)
        ratios = tuple(F(y, scale * x) for x, y in zip(vector, image, strict=True))
        lo, hi = min(ratios), max(ratios)
        if hi - lo < F(1, 10**8):
            break
        vector = tuple(y + shift*x for x, y in zip(vector, image, strict=True))
        assert all(x > 0 for x in vector)
    assert hi - lo < F(1, 10**8)
    return lo, hi


def print_enclosure(lo, hi):
    scale = 10**7
    lower = (lo.numerator * scale) // lo.denominator
    upper = -((-hi.numerator * scale) // hi.denominator)
    return f"[{F(lower, scale)}, {F(upper, scale)}]"


def verify_case(name, matrices, flat=False):
    print(name)
    before = None
    for speed in SPEEDS:
        matrix = lifted(matrices, speed)
        lo, hi = bounds(matrix)
        if flat:
            assert lo == hi == 1
        elif before is not None:
            assert before > hi
        print(f"  speed {speed}: {print_enclosure(lo, hi)}")
        before = lo


def main():
    assert G[0][1] > 0 and G[1][0] == 0
    verify_case("Distinct symmetric frozen graphs", (
        ((1, 1), (1, -1)), ((-1, 2), (2, 3)), ((0, 3), (3, -1)),
    ))
    verify_case("Common eigenvector, distinct eigenvalues", (
        ((0, 1), (1, 0)), ((2, 2), (2, 2)), ((1, 3), (3, 1)),
    ))
    verify_case("Common eigenvector and common eigenvalue", (
        ((0, 1), (1, 0)), ((-1, 2), (2, -1)), ((-2, 3), (3, -2)),
    ), flat=True)
    print("All 15 exact spectral enclosures passed.")


if __name__ == "__main__":
    main()
