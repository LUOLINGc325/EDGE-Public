#!/usr/bin/env python3
"""Rational enclosures for the characteristic root and the leading amplitude.

Only Python's standard library is used. This is a certificate for two constants,
not a machine proof of the delay equation, CVaR optimality, or asymptotic theorem.
All arithmetic controlling the reported intervals is fractions.Fraction.
"""
from fractions import Fraction as F
from math import factorial
import argparse
import json
from pathlib import Path


def exp_interval(x, degree=90):
    """For 0<=x<degree+2, bound the positive Taylor tail geometrically."""
    if not 0 <= x < degree + 2:
        raise ValueError("Taylor-tail condition violated")
    term = F(1)
    total = term
    for k in range(1, degree + 1):
        term *= x / k
        total += term
    first_omitted = term * x / (degree + 1)
    return total, total + first_omitted / (1 - x / (degree + 2))


def log_two_interval(terms=90):
    """log(2)=2*atanh(1/3), with an explicit positive geometric tail."""
    z = F(1, 3)
    low = 2 * sum((z ** (2 * k + 1) / (2 * k + 1)
                   for k in range(terms)), F(0))
    high = low + 2 * z ** (2 * terms + 1) / ((2 * terms + 1) * (1 - z*z))
    return low, high


def integral_interval(c, terms=80):
    """Bound integral_0^1 (exp(c*t)-1)/(1+t) dt by positive series.

    J_0=log(2), J_n=1/n-J_{n-1}; coefficients c^n/n! are positive.
    For c<=3/2, exp(c)<5 follows from exp_interval(3/2).
    The remaining integral is bounded by the pointwise exponential tail.
    """
    if not 0 <= c <= F(3, 2):
        raise ValueError("c is outside the certified range")
    jlow, jhigh = log_two_interval()
    low, high = F(0), F(0)
    coefficient = F(1)
    for n in range(1, terms + 1):
        jlow, jhigh = F(1, n) - jhigh, F(1, n) - jlow
        if jlow <= 0:
            raise ArithmeticError("moment enclosure lost positivity")
        coefficient *= c / n
        low += coefficient * jlow
        high += coefficient * jhigh
    first_omitted = coefficient * c / (terms + 1)
    high += first_omitted / (1 - c / (terms + 2))
    return low, high


def decimal_outward(x, places, upper=False):
    scale = 10 ** places
    n = x.numerator * scale // x.denominator
    if upper and F(n, scale) < x:
        n += 1
    sign = "-" if n < 0 else ""
    n = abs(n)
    return f"{sign}{n // scale}.{n % scale:0{places}d}"


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    c_low = F(1256431208626169676982737616609216, 10**33)
    c_high = c_low + F(1, 10**33)
    elow_l, elow_u = exp_interval(c_low)
    ehigh_l, ehigh_u = exp_interval(c_high)
    # f(c)=exp(c)-1-2c is strictly increasing for c>=1.
    if not (F(1) < c_low < c_high < F(3, 2)):
        raise ArithmeticError("root bracket is outside (1,3/2)")
    if not (elow_u - 1 - 2*c_low < 0 < ehigh_l - 1 - 2*c_high):
        raise ArithmeticError("root sign test failed")
    i_low, _ = integral_interval(c_low)
    _, i_high = integral_interval(c_high)
    # The integral is increasing in c. Bound the positive prefactor without
    # assuming it is monotone: numerator and denominator are bounded separately.
    a_low = elow_l * i_low / (c_high * (2*c_high-1))
    a_high = ehigh_u * i_high / (c_low * (2*c_low-1))
    if not 1 < a_low < a_high < F(6, 5):
        raise ArithmeticError("amplitude range check failed")
    scale = 10**30
    a_cert_low = F(a_low.numerator * scale // a_low.denominator, scale)
    a_cert_high = F(-(-a_high.numerator * scale // a_high.denominator), scale)
    if not a_cert_low <= a_low < a_high <= a_cert_high:
        raise ArithmeticError("outward certificate rounding failed")
    payload = {
        "status": "PASS",
        "arithmetic": "exact rational, Python fractions.Fraction",
        "scope": "root and amplitude constants only; no global theorem certification",
        "root_equation": "exp(c)=1+2*c, c>0",
        "root_lower": str(c_low), "root_upper": str(c_high),
        "root_decimal_outward": [decimal_outward(c_low, 30), decimal_outward(c_high, 30, True)],
        "amplitude_formula": "exp(c)/(c*(2*c-1))*integral_0^1 (exp(c*t)-1)/(1+t) dt",
        "amplitude_lower": str(a_cert_low), "amplitude_upper": str(a_cert_high),
        "amplitude_decimal_outward": [decimal_outward(a_cert_low, 28), decimal_outward(a_cert_high, 28, True)],
        "amplitude_greater_than_one": True,
        "exp_taylor_degree": 90,
        "integral_series_terms": 80,
        "log2_atanh_terms": 90,
        "analytic_requirements": [
            "positive exponential power series and geometric tail",
            "log(2)=2*atanh(1/3) positive power series",
            "termwise integration of a uniformly convergent nonnegative series",
            "J_n=1/n-J_(n-1) for J_n=integral_0^1 t^n/(1+t) dt"
        ]
    }
    rendered = json.dumps(payload, indent=2, ensure_ascii=False) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered)
    print(json.dumps({k:payload[k] for k in ["status","root_decimal_outward","amplitude_decimal_outward","scope"]}, indent=2))


if __name__ == "__main__":
    main()
