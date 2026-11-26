"""Exact rational certificate for the DSBS common crossover.

This is a numerical certificate, not proof-assistant code.  Every comparison
uses integers or fractions.Fraction; decimal output is rounded outwards.
Run with Python 3.11+.  No external packages or floating point are used.
"""

from fractions import Fraction as Q
from math import isqrt
import json


def add(a, b):
    return (a[0] + b[0], a[1] + b[1])


def neg(a):
    return (-a[1], -a[0])


def sub(a, b):
    return add(a, neg(b))


def mul(a, b):
    products = [x * y for x in a for y in b]
    return (min(products), max(products))


def scale(a, c):
    return mul(a, (Q(c), Q(c)))


def sqrt_interval(x, places=40):
    assert x >= 0
    den = 10**places
    k = isqrt((x.numerator * den * den) // x.denominator)
    lo, hi = Q(k, den), Q(k + 1, den)
    assert lo * lo <= x < hi * hi
    return lo, hi


def log_point(x, terms):
    assert x > 0
    z = (x - 1) / (x + 1)
    power = z
    total = Q(0)
    for k in range(terms):
        total += 2 * power / (2 * k + 1)
        power *= z * z
    remainder = 2 * abs(power) / ((2 * terms + 1) * (1 - z * z))
    # The geometric majorant follows by replacing all later odd denominators
    # by the first omitted one.  This symmetric enclosure is valid for z<0.
    return total - remainder, total + remainder


def log_interval(a, terms):
    return log_point(a[0], terms)[0], log_point(a[1], terms)[1]


def outer_decimal(a, places=35):
    den = 10**places
    lo = (a[0].numerator * den) // a[0].denominator
    hi = -((-a[1].numerator * den) // a[1].denominator)

    def fmt(k):
        sign = "-" if k < 0 else ""
        k = abs(k)
        return f"{sign}{k // den}.{k % den:0{places}d}"

    return [fmt(lo), fmt(hi)]


def evaluate(e):
    q = e / (1 - e)
    root_q = sqrt_interval(q)
    u = sqrt_interval(1 - q * q)
    log_two = log_point(Q(2), 50)
    log_q = sub(log_point(16 * q, 20), scale(log_two, 4))
    half_one_plus_u = scale(add((Q(1), Q(1)), u), Q(1, 2))
    log_one_plus_u = add(log_two, log_interval(half_one_plus_u, 8))
    coefficient = sub(add((Q(1), Q(1)), root_q), u)
    difference = add(mul(u, log_one_plus_u), mul(coefficient, log_q))
    return {
        "e": str(e),
        "q": str(q),
        "sqrt_q": outer_decimal(root_q),
        "u": outer_decimal(u),
        "log_q": outer_decimal(log_q),
        "log_one_plus_u": outer_decimal(log_one_plus_u),
        "difference": outer_decimal(difference),
        "sign": 1 if difference[0] > 0 else (-1 if difference[1] < 0 else 0),
    }


if __name__ == "__main__":
    left = Q("0.0551046517029798")
    right = Q("0.0551046517029799")
    a, b = evaluate(left), evaluate(right)
    assert a["sign"] == 1
    assert b["sign"] == -1
    print(json.dumps({
        "method": "integer square-root bounds and rational atanh-series logarithms",
        "sqrt_places": 40,
        "log_series_terms": {"log_2": 50, "log_16q": 20, "log_half_one_plus_u": 8},
        "certified_interval": ["0.0551046517029798", "0.0551046517029799"],
        "endpoints": [a, b],
    }, indent=2))

