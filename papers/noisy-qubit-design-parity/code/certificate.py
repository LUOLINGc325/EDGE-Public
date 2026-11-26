#!/usr/bin/env python3
"""Exact Schur-spectrum enumerator and parity-threshold certificates."""

from fractions import Fraction as F
import json
from math import comb


def trace_eigenvalue(m, ell, radius):
    """Evaluate the exact Haar scalar directly as a symmetric-power trace."""
    plus = (1+radius)/2
    minus = (1-radius)/2
    determinant = plus*minus
    trace = sum(plus**(ell-j) * minus**j for j in range(ell+1))
    return determinant**((m-ell)//2) * trace / (ell+1)


def h(m, x):
    return sum(F(comb(m,2*j),2*j+1)*x**j for j in range(m//2+1))


def gain(k, x, q):
    return ((1-q*x)/(1-x))**k - 1


def deficit(m, x, q):
    return 1 - h(m,q*x)/h(m,x)


def exact_error(m, radius, contraction):
    return max(
        abs(trace_eigenvalue(m, ell, contraction*radius) / trace_eigenvalue(m, ell, radius)-1)
        for ell in range(m%2, m+1, 2)
    )


def threshold_bracket(k, q):
    def signed_comparison(x):
        return deficit(2*k+1,x,q) - gain(k,x,q)

    lower = F(1, 2**16)
    upper = 1 - lower
    assert signed_comparison(lower) > 0 > signed_comparison(upper)
    for _ in range(24):
        middle = (lower+upper)/2
        residual = signed_comparison(middle)
        if residual == 0:
            return [str(middle)] * 2
        if residual > 0:
            lower = middle
        else:
            upper = middle
    assert signed_comparison(lower) > 0 > signed_comparison(upper)
    return [str(lower), str(upper)]


def main():
    spectral_cases = 0
    verified_orders = (1,2,3,4,5,6,8,10,16,24,32)
    radii = (F(0),F(1,50),F(1,10),F(1,4),F(1,2),F(4,5),F(99,100))
    contractions = (F(0),F(1,4),F(1,2),F(2,3),F(9,10),F(1))
    for m in verified_orders:
        for radius in radii:
            for contraction in contractions:
                x, q = radius**2, contraction**2
                assert exact_error(m,radius,contraction) == max(gain(m//2,x,q), deficit(m,x,q))
                spectral_cases += 1
    for radius in radii:
        for contraction in contractions:
            assert exact_error(2,radius,contraction) == exact_error(3,radius,contraction)
    r, kappa = F(1,4),F(1,2)
    eps4 = exact_error(4,r,kappa)
    eps5 = exact_error(5,r,kappa)
    assert eps4 == F(41,400) < F(1965,14896) == eps5
    pairs = [
        {"k":k, "q":str(q), "x_star_dyadic_bracket":threshold_bracket(k,q)}
        for k in (2,3,4,6,8,12,16)
        for q in (F(0),F(1,4),F(4,9),F(15,16))
    ]
    print(json.dumps({
        "method":"exact direct symmetric-power trace vs extreme-block formula",
        "schur_spectral_cases":spectral_cases,
        "counterexample":{"p":"1/2", "radius":"1/4", "eps4":str(eps4), "eps5":str(eps5)},
        "phase_threshold_brackets":pairs,
    },indent=2))


if __name__ == "__main__":
    main()
