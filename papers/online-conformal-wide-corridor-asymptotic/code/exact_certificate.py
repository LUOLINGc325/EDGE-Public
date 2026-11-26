#!/usr/bin/env python3
"""Rational enclosure of the universal wide-corridor coefficient J."""

from fractions import Fraction as Q
from math import isqrt


SCALE = 10**28
TERMS = 100
STEPS_PER_UNIT = 400
LIMIT = 5


def outward(lo, hi):
    """Round exact fractions to a fixed denominator, outwards."""
    return Q(lo.numerator*SCALE // lo.denominator, SCALE), Q(
        -((-hi.numerator*SCALE) // hi.denominator), SCALE
    )


def sqrt_bounds(lo, hi):
    lower_square = lo.numerator * SCALE**2 // lo.denominator
    upper_square = hi.numerator * SCALE**2 // hi.denominator
    return Q(isqrt(lower_square), SCALE), Q(isqrt(upper_square)+1, SCALE)


def atan_inverse(denominator):
    term = Q(1, denominator)
    total = Q()
    for k in range(TERMS):
        total += term / (2*k+1)
        term *= Q(-1, denominator**2)
    other = total + term / (2*TERMS+1)
    return min(total, other), max(total, other)


def gaussian_series(q):
    """Enclose exp(-q^2/2) and integral from 0 to q of exp(-x^2/2)."""
    x = q*q/2
    if x >= TERMS:
        raise ValueError("The first omitted exponent term must start a decreasing tail")
    exp_sum = int_sum = Q()
    term = Q(1)
    for k in range(TERMS):
        exp_sum += term
        int_sum += q*term/(2*k+1)
        term *= -x/(k+1)
    other_exp = exp_sum + term
    other_int = int_sum + q*term/(2*TERMS+1)
    return (outward(min(exp_sum, other_exp), max(exp_sum, other_exp)),
            outward(min(int_sum, other_int), max(int_sum, other_int)))


def main():
    atan5 = atan_inverse(5)
    atan239 = atan_inverse(239)
    pi_lo, pi_hi = outward(16*atan5[0]-4*atan239[1], 16*atan5[1]-4*atan239[0])
    g0_lo, g0_hi = sqrt_bounds(2/pi_hi, 2/pi_lo)
    p_lo = p_hi = Q()
    ratio_lo = pi_lo/4
    total_lo = total_hi = Q()
    for node in range(1, LIMIT*STEPS_PER_UNIT+1):
        q = Q(node, STEPS_PER_UNIT)
        exp, integral = gaussian_series(q)
        next_lo, next_hi = outward(g0_lo*integral[0], g0_hi*integral[1])
        next_ratio_lo, next_ratio_hi = outward(
            (1-exp[1])/next_hi**2, (1-exp[0])/next_lo**2
        )
        weight_lo, weight_hi = max(0, next_lo-p_hi), next_hi-p_lo
        total_lo += ratio_lo*weight_lo
        total_hi += next_ratio_hi*weight_hi
        p_lo, p_hi = next_lo, next_hi
        ratio_lo = next_ratio_lo
    total_lo += ratio_lo*(1-p_hi)
    total_hi += 1-p_lo
    lower, upper = outward(g0_lo*total_lo, g0_hi*total_hi)
    display_scale = 10**7
    lower_units = lower.numerator*display_scale//lower.denominator
    upper_units = -((-upper.numerator*display_scale)//upper.denominator)

    def display(units):
        return f"{units // display_scale}.{units % display_scale:07d}"

    print(f"Alternating series terms: {TERMS}")
    print(f"Monotone quadrature intervals: {LIMIT*STEPS_PER_UNIT} on [0,{LIMIT}] plus tail")
    if not (lower > Q(3, 5) and upper < Q(4, 5) and upper-lower < Q(1, 2000)):
        raise RuntimeError("Certificate does not establish the requested interval and width")
    if not (Q(lower_units, display_scale) < lower <= upper < Q(upper_units, display_scale)):
        raise RuntimeError("Printed strict endpoints must be strictly outside arithmetic bounds")
    print(f"Certified enclosure: {display(lower_units)} < J < {display(upper_units)}")
    print("All bounds use exact rational arithmetic.")


if __name__ == "__main__":
    main()
