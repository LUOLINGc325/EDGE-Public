#!/usr/bin/env python3
"""Standard-library rational certificates for the one-max CVaR research note.

These finite computations do not certify the universal analytic theorem.
They check exact root enclosures, delayed identities, clipping identities and
the two endpoints. No floating-point arithmetic decides a certificate.
"""
from __future__ import annotations

import argparse
from fractions import Fraction as Q
from math import factorial
from pathlib import Path
import json


def profile(a: Q, delta: Q, t: Q) -> Q:
    if not (a >= 1 and 0 < delta < 1 and 0 <= t <= 1):
        raise ValueError("profile requires a>=1, 0<delta<1, 0<=t<=1")
    h = 1 - delta
    total = Q(1)
    j = 1
    while j * delta < t:
        total += a**j * (t-j*delta)**j / (h**j * factorial(j))
        j += 1
    return 1 + (a-1)*total


def integrated_excess(a: Q, delta: Q, t: Q) -> Q:
    """Integral from 0 to t of profile(a,delta,s)-1, by monomials."""
    h = 1-delta
    total = (a-1)*t
    j = 1
    while j*delta < t:
        total += (a-1)*a**j*(t-j*delta)**(j+1)/(h**j*factorial(j+1))
        j += 1
    return total


def derivative(a: Q, delta: Q, t: Q) -> Q:
    h = 1-delta
    total = Q(0)
    j = 1
    while j*delta < t:
        total += (a-1)*a**j*(t-j*delta)**(j-1)/(h**j*factorial(j-1))
        j += 1
    return total


def exp_bounds(x: Q, terms: int) -> tuple[Q,Q]:
    """Taylor lower sum and a geometric majorant of its positive remainder."""
    if x < 0 or terms+2 <= x:
        raise ValueError("positive x and terms+2>x required")
    term = Q(1)
    lower = term
    for j in range(1, terms+1):
        term *= x/j
        lower += term
    first_omitted = term*x/(terms+1)
    upper = lower + first_omitted/(1-x/Q(terms+2))
    return lower, upper


def terminal_bounds(a: Q, delta: Q, terms: int=120) -> tuple[Q,Q]:
    if delta == 1:
        return a*a, a*a
    if delta == 0:
        el, eu = exp_bounds(a, max(terms, 2*int(a)+2))
        return 1+(a-1)*el, 1+(a-1)*eu
    value = profile(a, delta, Q(1))
    return value, value


def compare_terminal(a: Q, delta: Q, theta: Q) -> int:
    terms = 120
    for _ in range(8):
        lower, upper = terminal_bounds(a, delta, terms)
        if upper < theta:
            return -1
        if lower > theta:
            return 1
        if lower == upper == theta:
            return 0
        terms *= 2
    raise ArithmeticError("exponential enclosure cannot separate the target")


def root_interval(theta: Q, delta: Q, bits: int=72) -> tuple[Q,Q]:
    if theta < 1 or not 0 <= delta <= 1:
        raise ValueError("theta>=1 and 0<=delta<=1 required")
    if theta == 1:
        return Q(1), Q(1)
    lo, hi = Q(1), Q(2)
    while compare_terminal(hi, delta, theta) < 0:
        hi *= 2
    for _ in range(bits):
        mid = (lo+hi)/2
        sign = compare_terminal(mid, delta, theta)
        if sign == 0:
            return mid, mid
        if sign < 0:
            lo = mid
        else:
            hi = mid
    return lo, hi


def decimal(q: Q, places: int=18) -> str:
    """Display only; all pass/fail decisions use Fraction."""
    from decimal import Decimal, localcontext
    with localcontext() as ctx:
        ctx.prec = places+12
        return f"{Decimal(q.numerator)/Decimal(q.denominator):.{places}f}"


def generate() -> dict:
    counts = {"integral_identities":0,"dde_identities":0,
              "clipping_terminal_identities":0,"root_enclosures":0,
              "phase_transition_identities":0}
    deltas = [Q(1,10),Q(1,7),Q(1,4),Q(1,3),Q(2,5),Q(1,2),Q(3,5),Q(3,4),Q(9,10)]
    a_values = [Q(5,4),Q(3,2),Q(2),Q(3),Q(5)]
    for delta in deltas:
        h = 1-delta
        for a in a_values:
            for k in range(61):
                t = Q(k,60)
                lhs = profile(a,delta,t)
                rhs = a*(1+integrated_excess(a,delta,max(Q(0),t-delta))/h)
                if lhs != rhs:
                    raise AssertionError(("integral",a,delta,t,lhs,rhs))
                counts["integral_identities"] += 1
                if t > delta:
                    if derivative(a,delta,t) != a*(profile(a,delta,t-delta)-1)/h:
                        raise AssertionError(("DDE",a,delta,t))
                    counts["dde_identities"] += 1
            theta = profile(a,delta,Q(1))
            # The clipped law equals the original profile on [0,h].
            lower_tail_mean = 1+integrated_excess(a,delta,h)/h
            if a*lower_tail_mean != theta:
                raise AssertionError(("clip terminal",a,delta))
            if not lower_tail_mean <= profile(a,delta,h) <= theta:
                raise AssertionError(("clip support",a,delta))
            counts["clipping_terminal_identities"] += 1
            if delta >= Q(1,2):
                if theta != a*a or profile(a,delta,h) != a:
                    raise AssertionError(("phase",a,delta))
                counts["phase_transition_identities"] += 1
    roots = []
    for theta in [Q(2),Q(10),Q(100),Q(1000)]:
        for delta in [Q(0),Q(1,10),Q(1,4),Q(1,3),Q(2,5),Q(49,100),Q(1,2),Q(3,4),Q(1)]:
            lo, hi = root_interval(theta,delta)
            ll,lu = terminal_bounds(lo,delta)
            hl,hu = terminal_bounds(hi,delta)
            if not (lu <= theta <= hl):
                raise AssertionError(("root enclosure",theta,delta))
            if hi-lo > Q(1,10**19):
                raise AssertionError(("root precision",theta,delta))
            roots.append({"theta":str(theta),"delta":str(delta),
                          "lower":str(lo),"upper":str(hi),
                          "display_midpoint":decimal((lo+hi)/2),
                          "width":str(hi-lo),"verified":True})
            counts["root_enclosures"] += 1
    return {"status":"PASS","arithmetic":"fractions.Fraction; rigorous exponential Taylor enclosures at delta=0",
            "scope":"Finite exact algebra and root enclosures only; the general theorem is the written proof.",
            "counts":counts,"total_checks":sum(counts.values()),"root_intervals":roots}


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    result = generate()
    serialized = json.dumps(result,ensure_ascii=False,indent=2)+"\n"
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(serialized,encoding="utf-8")
    print(json.dumps({k:v for k,v in result.items() if k != "root_intervals"},ensure_ascii=False,indent=2))


if __name__ == "__main__":
    main()
