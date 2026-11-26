#!/usr/bin/env python3
"""Rational conservative stopping certificate from validated input bounds."""

from argparse import ArgumentParser
from fractions import Fraction as F
from json import dumps
from math import isqrt


def ceiling_sqrt(dimension):
    root = isqrt(dimension)
    return root + (root * root != dimension)


def certify(gamma, margin, radius, power, separation, projector_sum,
            reset_norm, endpoints, dimension, tolerance):
    if not (0 < gamma < 1 and 0 < margin <= 1 and radius > 1 and power >= 0
            and 0 < separation <= 1 and projector_sum >= 0 and reset_norm >= 0
            and endpoints >= 1 and dimension >= 2 and tolerance > 0):
        raise ValueError("input is outside the stated certificate parameter domain")
    p, q = gamma.numerator, gamma.denominator
    stable_upper = power * 2 * radius / (radius - 1)
    u = 1 + reset_norm + projector_sum + 2 * stable_upper + 1 / separation
    width_cap = min((radius - 1) / 2, separation / 8, F(1, 8))
    kappa = F(1, 8)
    limit = (margin / (6 * u * u)) ** q
    while kappa > width_cap or kappa ** p > limit:
        kappa /= 2
    beta = min(2 * gamma, F(1))
    b = 4
    leading = 5 * b * u ** 3 / margin ** 2
    local = 200 * b * u ** 8 / margin ** 3
    outer = 60 * b * u ** 3 / (margin ** 2 * kappa)
    remainder = endpoints * local * (4 + 8 * (1 / beta + 1)) + 10 * outer / kappa
    rate = ceiling_sqrt(dimension) * (leading + remainder)
    required = (rate / tolerance) ** q
    low, high = 0, 1
    while high ** p < required:
        high *= 2
    while high - low > 1:
        middle = (low + high) // 2
        if middle ** p >= required:
            high = middle
        else:
            low = middle
    return {"U_upper": str(u), "slit_width": str(kappa),
            "trace_rate_constant_upper": str(rate), "certified_time": high - 1}


def main():
    parser = ArgumentParser(description=__doc__)
    for name in ("gamma", "margin", "radius", "power", "separation", "projector-sum",
                 "reset-norm", "tolerance"):
        parser.add_argument("--" + name, type=F, required=True)
    for name in ("endpoints", "dimension"):
        parser.add_argument("--" + name, type=int, required=True)
    print(dumps(certify(**vars(parser.parse_args())), indent=2))


if __name__ == "__main__":
    main()
