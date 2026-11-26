#!/usr/bin/env python3
"""Verify the three-cycle harmonic response, exact slopes, and separated peaks."""

from fractions import Fraction as F


def response(s):
    return (1 + s / 2 + s*s / 3) / (s**4 + 3*s*s + 9)


def slope(s):
    return -(4*s**5 + 9*s**4 + 24*s**3 + 9*s*s - 27) / (6*(s**4 + 3*s*s + 9)**2)


def solve(matrix, rhs):
    n = len(rhs)
    rows = [list(row) + [b] for row, b in zip(matrix, rhs, strict=True)]
    for i in range(n):
        k = next(j for j in range(i, n) if rows[j][i])
        rows[i], rows[k] = rows[k], rows[i]
        pivot = rows[i][i]
        rows[i] = [x / pivot for x in rows[i]]
        for j in range(n):
            if j != i:
                factor = rows[j][i]
                rows[j] = [a - factor*b for a, b in zip(rows[j], rows[i], strict=True)]
    return tuple(row[-1] for row in rows)


def independent_response(s):
    q = ((-1, 1, 0), (0, -1, 1), (1, 0, -1))
    a = tuple(tuple(-entry + F(1, 3) for entry in row) for row in q)
    d = tuple(tuple(F(i == j) for j in range(3)) for i in range(3))
    system = tuple(
        a[i] + tuple(-s * dx for dx in d[i]) for i in range(3)
    ) + tuple(
        tuple(s * dx for dx in d[i]) + a[i] for i in range(3)
    )
    centered = (F(2, 3), F(-1, 3), F(-1, 3), F(-1, 3), F(2, 3), F(-1, 3))
    resolved = solve(system, centered)
    return sum(x*y for x, y in zip(centered, resolved, strict=True)) / 6


def verify_scales():
    ratio = 10**4
    weight = F(1, 100)
    left, center, right = F(1, 4), F(3, 4), F(2)
    interference = 1 / (weight*ratio - 1) + 13*weight / (left**3 * (ratio**2 - weight))
    assert interference < F(1, 90)
    assert response(center) - response(F(0)) > response(F(0))*weight/(1 - weight)
    assert ratio > right / left
    assert slope(left) == F(852736, 16609827) > F(1, 20)
    assert slope(right) == F(-473, 8214) < F(-1, 20)
    assert response(center) - response(F(0)) == F(29, 939)
    count = 0
    for n in (1, 2, 4, 8, 16):
        harmonics = [(ratio**j, weight**j) for j in range(n)]
        baseline = sum(w for _, w in harmonics) * response(F(0))
        for k, _ in harmonics:
            left_derivative = sum(w*j*slope(left*j/k) for j, w in harmonics)
            right_derivative = sum(w*j*slope(right*j/k) for j, w in harmonics)
            center_value = sum(w*response(center*j/k) for j, w in harmonics)
            assert left_derivative > 0
            assert right_derivative < 0
            assert center_value > baseline > 0
            count += 1
    return count


def main():
    samples = (F(0), F(1, 10), F(1, 4), F(1, 3), F(1, 2), F(3, 4), F(1), F(2), F(3), F(5), F(7), F(10))
    for s in samples:
        assert response(s) == independent_response(s)
    print(f"Three-cycle rational response comparisons: {len(samples)}.")
    print(f"Intervals with both slope signs and center gain: {verify_scales()}.")
    print("Uniform derivative interference <1/90, individual slopes >1/20 in magnitude.")
    print("Single-harmonic gain 29/939 exceeds all later baseline loss 1/891.")
    print("All checks passed.")


if __name__ == "__main__":
    main()
