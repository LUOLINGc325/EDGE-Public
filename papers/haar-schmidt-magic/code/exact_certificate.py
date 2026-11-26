#!/usr/bin/env python3
"""Exact rational enclosures for the Haar Schmidt-gauge cube moment at c=1."""

import argparse
from fractions import Fraction
from itertools import product


def arctan_interval(inv_x, terms):
    value = sum(Fraction((-1) ** k, (2 * k + 1) * inv_x ** (2 * k + 1))
                for k in range(terms))
    other = value + Fraction((-1) ** terms, (2 * terms + 1) * inv_x ** (2 * terms + 1))
    return min(value, other), max(value, other)


def pi_interval():
    a_low, a_high = arctan_interval(5, 28)
    b_low, b_high = arctan_interval(239, 9)
    # Machin's identity: pi = 16 arctan(1/5) - 4 arctan(1/239).
    low = Fraction(3141592653589793238462643383279, 10 ** 30)
    high = low + Fraction(1, 10 ** 30)
    assert low <= 16 * a_low - 4 * b_high
    assert 16 * a_high - 4 * b_low <= high
    return low, high


PI_LOW, PI_HIGH = pi_interval()
PI_MID = (PI_LOW + PI_HIGH) / 2
PI_RADIUS = (PI_HIGH - PI_LOW) / 2


def sine_interval(pi_multiplier):
    value = pi_multiplier * PI_MID
    term = value
    partial = term
    for k in range(1, 15):
        term *= -value ** 2 / ((2 * k) * (2 * k + 1))
        partial += term
    omitted = -term * value ** 2 / (30 * 31)
    # The omitted tail alternates with decreasing sizes. Sine is 1-Lipschitz.
    error = pi_multiplier * PI_RADIUS
    return max(Fraction(0), partial + omitted - error), min(Fraction(1), partial + error)


def cdf_interval(r):
    low, high = sine_interval(r)
    return r + low / PI_HIGH, r + high / PI_LOW


def quantile_interval(p, precision):
    if p in (0, 1):
        return 2 * p, 2 * p

    left, right = Fraction(0), Fraction(1)
    for _ in range(precision):
        mid = (left + right) / 2
        low, high = cdf_interval(mid)
        if high <= p:
            left = mid
        elif low >= p:
            right = mid
        else:
            # The previously certified enclosing pair remains valid.
            break

    # The singular value 2 sin(pi r / 2) increases with r.
    slow, _ = sine_interval(left / 2)
    _, shigh = sine_interval(right / 2)
    return 2 * slow, 2 * shigh


def walsh_in_place(values):
    stride = 1
    while stride < len(values):
        for base in range(0, len(values), 2 * stride):
            for i in range(base, base + stride):
                first, second = values[i], values[i + stride]
                values[i] = first + second
                values[i + stride] = first - second
        stride *= 2


def cube_numerator(values):
    dimension = len(values)
    total = 0
    for shift in range(dimension):
        weights = [value * values[i ^ shift] for i, value in enumerate(values)]
        walsh_in_place(weights)
        total += sum(weight ** 4 for weight in weights)
    return total


def square_numerator(values):
    transformed = values.copy()
    walsh_in_place(transformed)
    return sum(value ** 4 for value in transformed)


def test_walsh():
    for values in ([1, 2], [3, 1, 0, 2], [7, 4, 4, 3, 2, 1, 0, 0]):
        d = len(values)
        brute_numerator = 0
        for x, a, b, c in product(range(d), repeat=4):
            term = 1
            for u, v, w in product((0, 1), repeat=3):
                term *= values[x ^ (u * a) ^ (v * b) ^ (w * c)]
            brute_numerator += term
        assert cube_numerator(values) == d * brute_numerator
        square_brute = sum(values[x] * values[x ^ a] * values[x ^ b] * values[x ^ a ^ b]
                           for x, a, b in product(range(d), repeat=3))
        assert square_numerator(values) == d * square_brute


def floor_q(value):
    return value.numerator // value.denominator


def ceil_q(value):
    return -floor_q(-value)


def decimal(integer, digits):
    sign = "-" if integer < 0 else ""
    integer = abs(integer)
    return f"{sign}{integer // 10 ** digits}.{integer % 10 ** digits:0{digits}d}"


def show_interval(name, low, high):
    digits = 12
    outside_low = decimal(floor_q(low * 10 ** digits), digits)
    outside_high = decimal(ceil_q(high * 10 ** digits), digits)
    print(f"exact {name} interval: [{low}, {high}]")
    print(f"outward decimal {name} interval: [{outside_low}, {outside_high}]")


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--bits", type=int, default=10)
    args = parser.parse_args()
    assert args.bits > 0
    test_walsh()
    print("exact integer Walsh identity verified on three dyadic grids")

    d = 2 ** args.bits
    scale = 2 ** 26
    endpoints = [quantile_interval(Fraction(d - i, d), precision=29) for i in range(d + 1)]
    lower_grid = [floor_q(scale * low) for low, _ in endpoints[1:]]
    upper_grid = [ceil_q(scale * high) for _, high in endpoints[:-1]]

    denominator = d ** 5 * scale ** 8
    low = Fraction(cube_numerator(lower_grid), denominator)
    high = Fraction(cube_numerator(upper_grid), denominator)
    assert 0 < low < high
    print(f"dyadic quarter-circle cells: {d}, amplitude grid denominator: {scale}")
    show_interval("balanced M2 moment", low, high)

    # The sign of the semicircle quantile is a character of the first bit.
    # Its product on any parallelogram equals one, so use |h| and monotonicity.
    square_low = Fraction(square_numerator(lower_grid + lower_grid[::-1]), (2 * d * scale) ** 4)
    square_high = Fraction(square_numerator(upper_grid + upper_grid[::-1]), (2 * d * scale) ** 4)
    show_interval("semicircle four-point moment A", square_low, square_high)
    coeff_low = Fraction(3, 16) - Fraction(7, 8) * square_high
    coeff_high = Fraction(3, 16) - Fraction(7, 8) * square_low
    show_interval("second-order coefficient before division by ln(2)", coeff_low, coeff_high)


if __name__ == "__main__":
    main()
