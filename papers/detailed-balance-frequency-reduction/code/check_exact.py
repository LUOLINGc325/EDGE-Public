#!/usr/bin/env python3
"""Certify annealed strict increases using exact resolvent products."""

from fractions import Fraction as F


A = ((F(-1), F(0), F(1)), (F(1), F(-1), F(0)), (F(0), F(1), F(-1)))
B = ((F(-16), F(0), F(1)), (F(1), F(-1, 4), F(0)), (F(0), F(1), F(-1, 4)))


def eye(n):
    return tuple(tuple(F(i == j) for j in range(n)) for i in range(n))


def matmul(left, right):
    return tuple(
        tuple(sum(a * b for a, b in zip(row, col, strict=True)) for col in zip(*right, strict=True))
        for row in left
    )


def inverse(matrix):
    n = len(matrix)
    rows = [list(left + right) for left, right in zip(matrix, eye(n), strict=True)]
    for i in range(n):
        pivot_index = next(j for j in range(i, n) if rows[j][i])
        rows[i], rows[pivot_index] = rows[pivot_index], rows[i]
        pivot = rows[i][i]
        rows[i] = [x / pivot for x in rows[i]]
        for j, row in enumerate(rows):
            if j != i:
                factor = row[i]
                rows[j] = [a - factor*b for a, b in zip(row, rows[i], strict=True)]
    inverse_matrix = tuple(tuple(row[n:]) for row in rows)
    assert matmul(matrix, inverse_matrix) == eye(n)
    return inverse_matrix


def multiply_repeated(matrix, stages, initial):
    for _ in range(stages):
        initial = matmul(matrix, initial)
    return initial


def cycle_product(speed, target, stages):
    rate = 2 * speed * stages
    out = eye(3)
    for generator in (A, B):
        resolvent_input = tuple(
            tuple(F(i == j) + (target * F(i == j) - value) / rate for j, value in enumerate(row))
            for i, row in enumerate(generator)
        )
        resolvent = inverse(resolvent_input)
        assert all(value > 0 for row in resolvent for value in row)
        out = multiply_repeated(resolvent, stages, out)
    return out


def spectral_side(matrix, above):
    v = ((F(1),),) * len(matrix)
    for _ in range(45):
        mv = matmul(matrix, v)
        ratios = tuple(y[0] / x[0] for y, x in zip(mv, v, strict=True))
        if (above and min(ratios) > 1) or (not above and max(ratios) < 1):
            return min(ratios), max(ratios)
        v = mv
    raise AssertionError("Collatz–Wielandt bracket did not separate from one")


def format_floor(x, scale):
    k = x.numerator * scale // x.denominator
    return f"{k // scale}.{k % scale:05d}"


def verify_comparison(stages, low_speed, high_speed, target):
    print(f"{stages} stage(s) per season, target exponent {target}:")
    for speed, above in ((low_speed, False), (high_speed, True)):
        lo, hi = spectral_side(cycle_product(speed, target, stages), above)
        ceiling = F(-((-hi.numerator * 10**5) // hi.denominator), 10**5)
        print(f"  speed {speed}: radius in [{format_floor(lo,10**5)},{format_floor(ceiling,10**5)}]")


def main():
    # At small rates the exact slope solves (1+z/2)^2=49/43.
    assert (1 + F(13, 200))**2 < F(49, 43) < (1 + F(7, 100))**2
    print("Slow coefficient in (13/100,7/50).")
    verify_comparison(1, F(1, 1000), F(1, 50), F(1, 1000))
    verify_comparison(4, F(1, 100), F(1, 10), F(1, 200))
    print("Both strict annealed increases passed in exact arithmetic.")


if __name__ == "__main__":
    main()
