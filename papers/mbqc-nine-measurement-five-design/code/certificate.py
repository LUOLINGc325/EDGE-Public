#!/usr/bin/env python3
"""Exact quotient-ring certificate for the nine-measurement five-design."""

from fractions import Fraction as F
import json

P = (1, 0, -8, 0, -2, 0, -8, 0, 81)
B = tuple(F(k, 88288) for k in (24487, 80743, 70811, 45691, 100217, -100743, -318411, -593163))
C = tuple(F(k, 240) for k in (-41, -399, 87, -215, 137, 255, -567, 3159))
ZERO = (F(0),) * 8
ONE = (F(1),) + ZERO[1:]
A = (F(0), F(1)) + ZERO[2:]


def evaluate(coefficients, value):
    result = F(0)
    for coefficient in reversed(coefficients):
        result = result * value + coefficient
    return result


def multiply(a, b):
    out = [F(0)] * 15
    for j, v in enumerate(a):
        for k, w in enumerate(b):
            out[j+k] += v*w
    for j in range(len(out)-1, 7, -1):
        coeff = out[j] / P[8]
        for k in range(8):
            out[j-8+k] -= coeff * P[k]
    return tuple(out[:8])


def const(q):
    return (F(q),) + ZERO[1:]


def add(a, b):
    return tuple(x+y for x,y in zip(a,b))


def matrix_multiply(left, right):
    size = len(left)
    result = [[ZERO] * size for _ in range(size)]
    for i in range(size):
        for j in range(size):
            for k in range(size):
                result[i][j] = add(result[i][j], multiply(left[i][k], right[k][j]))
    return result


def diagonal(coefficients):
    return [[v if i == j else ZERO for j in range(len(coefficients))] for i,v in enumerate(coefficients)]


def tilt_word(H, dimension):
    product = H
    for variable in (A, B, C):
        entries = [ONE, variable]
        if dimension == 3:
            square = multiply(variable, variable)
            entries.append(add(tuple(2*v for v in square), const(-1)))
        product = matrix_multiply(H, matrix_multiply(diagonal(entries), product))
    return product


def main():
    lower, upper = F(-35, 100), F(-34, 100)
    assert evaluate(P, lower) < 0 < evaluate(P, upper)
    assert 16 * abs(upper) > 648 * abs(lower)**7
    bounds = [sum(abs(coeff) * abs(lower)**j for j, coeff in enumerate(poly)) for poly in (B,C)]
    assert max(bounds) < 1
    H2 = [[const(F(q,2)) for q in row] for row in ((-1,-3),(-1,1))]
    H4 = [[const(F(q,8)) for q in row] for row in ((3,5,35),(4,4,-28),(1,-1,1))]
    for H in (H2,H4):
        assert matrix_multiply(H, H) == diagonal([ONE] * len(H))
    M2, M4 = tilt_word(H2,2), tilt_word(H4,3)
    checked = [M2[0][0], M4[0][0], M4[0][2]]
    assert checked == [ZERO] * 3
    print(json.dumps({
        "degree_eight_polynomial_ascending": P,
        "a_isolating_interval": [str(lower), str(upper)],
        "cosine_absolute_upper_bounds": [str(bound) for bound in bounds],
        "exact_residuals_ascending": [list(map(str,row)) for row in checked],
        "annihilated_integer_spins": [1,2,3,4,5],
        "internal_cosines_cos_2phi": ["0", "a", "b(a)", "c(a)", "0", "1", "1/sqrt(2)"],
    }, indent=2))


if __name__ == "__main__":
    main()
