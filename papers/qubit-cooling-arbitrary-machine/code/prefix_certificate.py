#!/usr/bin/env python3
"""Exact shell capacity certificates from finite multiplicity prefixes."""

from functools import reduce
from operator import mul

from sympy import Poly, cancel, symbols


t, c, x, y = symbols("t c x y")


def polynomial(prefix):
    """Clear the denominators of the lower bound minus the upper average."""
    last = prefix[-1]
    depth = len(prefix) - 1
    edge_denoms = [left + right for left, right in zip(prefix, prefix[1:])]
    mass = sum(prefix) + c
    bound = sum(t**index * left * (left - t*right)/(left + right)
                for index, (left, right) in enumerate(zip(prefix, prefix[1:])))
    bound += t**depth * (last - last*c/(last + (1+t)*c))
    average = (sum(t**index * count for index, count in enumerate(prefix))
               + t**(depth+1)*c) / mass
    positive_denominator = mass * (last + (1+t)*c) * reduce(mul, edge_denoms, 1)
    difference = cancel((bound - average) * positive_denominator)
    degree = Poly(difference, t).degree()
    return Poly(cancel(difference.subs(t, (1+2*y)/(2+2*y)) * (2+2*y)**degree),
                x, c, y, domain="ZZ")


def verify(prefix):
    result = polynomial(prefix)
    assert result.coeff_monomial(1) > 0
    assert all(coefficient > 0 for _, coefficient in result.terms())
    print(f"{prefix}: {len(result.terms())} positive coefficients, constant {result.coeff_monomial(1)}")


FIRST_CERTIFICATES = (
    (1, 2, 4+x),
    (1, 2, 1, 2+x),
    (1, 2, 2, 4+x),
    (1, 2, 3, 5+x),
    (1, 2, 3, 1),
)

if __name__ == "__main__":
    for prefix in FIRST_CERTIFICATES:
        verify(prefix)
