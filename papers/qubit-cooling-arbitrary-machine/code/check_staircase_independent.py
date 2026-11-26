#!/usr/bin/env python3
"""Independent Bernstein-basis cross-check of staircase capacity certificates."""

from fractions import Fraction as Q
from math import comb

from sympy import Poly, Rational, expand, symbols
from prefix_certificate import c, polynomial, x

t = symbols("t")
degree_pairs = (
    (Q(7, 20), Q(7, 10)), (Q(1, 4), Q(7, 12)), (Q(1, 7), Q(95, 231)),
    (Q(1, 8), Q(3, 8)), (Q(1, 16), Q(11, 48)), (Q(1, 16), Q(11, 48)),
)


def edge(left, right):
    return left - (1+t)*Rational(left*right,left+right)


def energy(prefix):
    numerator = t
    for i, (left, right) in enumerate(zip(prefix,prefix[1:])):
        numerator += t**i*(left-t*right)**2/(left+right)
    return numerator


def rational_coefficients(expression):
    coefficients = Poly(expression,t).all_coeffs()
    return tuple(Q(int(r.p),int(r.q)) for r in reversed(coefficients))


def bernstein_lower(coefficients, a, b):
    degree = len(coefficients)-1
    monomials = [sum(value*comb(i,j)*a**(i-j) for i,value in enumerate(coefficients)
                     if i>=j)*(b-a)**j for j in range(degree+1)]
    bernstein = [sum(monomials[j]*Q(comb(k,j),comb(degree,j)) for j in range(k+1))
                 for k in range(degree+1)]
    return min(bernstein)


def cover(a,b, alternatives,depth=0):
    if any(bernstein_lower(coefficients,a,b)+coefficient*a**power>=0
           for coefficients,coefficient,power in alternatives):
        return 1
    assert depth<16, (a,b)
    h=(a+b)/2
    return cover(a,h,alternatives,depth+1)+cover(h,b,alternatives,depth+1)


def nonnegative(a,b,expressions):
    return cover(a,b,[(rational_coefficients(f),coefficient,power) for f,coefficient,power in expressions])


def check_prefixes():
    fixed = [(1,3+x),(1,2,4+x),tuple(range(1,9))]
    for k in range(3,8):
        run=tuple(range(1,k+1))
        fixed.extend(run+(j,) for j in range(1,k-1))
        fixed.append(run+(k+2+x,))
    for prefix in fixed:
        assert all(value>=0 for _,value in polynomial(prefix).terms())
    for k in (6, 7):
        endpoint = polynomial(tuple(range(1, k+1))).eval(c, 0)
        assert all(value >= 0 for _, value in endpoint.terms())
    return len(fixed) + 2


def check_repeated(k,alpha,beta):
    prefix = list(range(1,k+1))
    prefix_mass = sum(n*t**i for i,n in enumerate(prefix[:-1]))
    prefix_deficit = sum(t**i*edge(n,prefix[i+1]) for i,n in enumerate(prefix[:-1]))
    # Delete a copy of the repeated final multiplicity.
    # The change in S in excess of t times the shorter chain is X.
    X = expand((1-t)*prefix_mass+k*t**(k-1))
    B = prefix_deficit + Rational(k,2)*t**(k-1)
    lower = 1-Q(k+1,max(19,sum(prefix)+k))
    fast = nonnegative(Q(1,2),Q(1), [((k+1)*B-X,0,0)])
    intercept = nonnegative(lower,Q(1), [(energy(prefix)-(1+t)*X/k+beta,0,0)])
    slope = nonnegative(lower,Q(1), [(t*(1+t)*B/k-alpha,0,0)])
    return fast,intercept,slope


def check_down(k):
    prefix=list(range(1,k+1))+[k-1]
    removed=sum(prefix[-3:-1])
    short_prefix=prefix[:-3]+[prefix[-1]]
    front_mass=sum(n*t**i for i,n in enumerate(prefix[:-1]))
    short_mass=sum(n*t**i for i,n in enumerate(short_prefix[:-1]))
    X=expand(front_mass-t*t*short_mass)
    front_deficit=sum(t**i*edge(n,prefix[i+1]) for i,n in enumerate(prefix[:-1]))
    short_deficit=sum(t**i*edge(n,short_prefix[i+1]) for i,n in enumerate(short_prefix[:-1]))
    B=expand(front_deficit-t*t*short_deficit)
    fast=nonnegative(Q(1,2),Q(1), [(removed**2*B-X,0,0)])
    minimal=max(19,sum(prefix))
    leaves=0
    for m in range(minimal,removed**2):
        exponent = m-sum(prefix)+len(prefix)-1
        leaves += nonnegative(Q(1,2),Q(1),[
            (m*B-X,removed,exponent),
            (energy(prefix)+(1+t)*((m-removed)*B-X)/removed,1,exponent),
        ])
    return fast,removed**2-minimal,leaves


if __name__ == "__main__":
    if not __debug__:
        raise RuntimeError("Run with assertions enabled")
    print(f"Independent prefix polynomials verified: {check_prefixes()}",flush=True)
    for k,(a,b) in enumerate(degree_pairs,2):
        print(f"Repeated level {k}: pass {check_repeated(k,a,b)}",flush=True)
    for k in range(3,8):
        print(f"Down bump {k}: pass {check_down(k)}",flush=True)
