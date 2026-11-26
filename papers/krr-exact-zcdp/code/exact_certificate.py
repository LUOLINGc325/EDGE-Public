#!/usr/bin/env python3
"""Selected rigorous k-RR certificates using only integer/rational arithmetic.

Every elementary-function enclosure follows explicit Taylor remainders.
All arithmetic is outward rounded to a dyadic lattice. No mpmath, scipy,
float transcendental function, or unchecked assertion is used to certify signs.
These finite certificates supplement, and do not prove, the universal theorem.
"""
from __future__ import annotations

import argparse
import json
from dataclasses import dataclass
from fractions import Fraction as Q
from pathlib import Path

BITS = 256
SCALE = 1 << BITS


def down(x):
    x = Q(x)
    return Q((x.numerator*SCALE)//x.denominator, SCALE)


def up(x):
    x = Q(x)
    return Q(-((-x.numerator*SCALE)//x.denominator), SCALE)


@dataclass(frozen=True)
class I:
    lo: Q
    hi: Q

    def __init__(self, lo, hi=None):
        lo, hi = Q(lo), Q(lo if hi is None else hi)
        if lo > hi:
            raise ValueError("reversed interval")
        object.__setattr__(self, "lo", down(lo))
        object.__setattr__(self, "hi", up(hi))

    def __add__(self, other):
        other = box(other)
        return I(self.lo + other.lo, self.hi + other.hi)

    __radd__ = __add__

    def __neg__(self):
        return I(-self.hi, -self.lo)

    def __sub__(self, other):
        return self + (-box(other))

    def __rsub__(self, other):
        return box(other) + (-self)

    def __mul__(self, other):
        other = box(other)
        vals = [a*b for a in (self.lo,self.hi) for b in (other.lo,other.hi)]
        return I(min(vals), max(vals))

    __rmul__ = __mul__

    def reciprocal(self):
        if self.lo <= 0 <= self.hi:
            raise ArithmeticError("interval division includes zero")
        return I(1/self.hi, 1/self.lo)

    def __truediv__(self, other):
        return self * box(other).reciprocal()

    def __rtruediv__(self, other):
        return box(other) * self.reciprocal()


def box(x):
    return x if isinstance(x, I) else I(x)


def exp_scalar(x):
    x = Q(x)
    if x < 0:
        return exp_scalar(-x).reciprocal()
    shifts = 0
    while x > Q(1,2):
        x /= 2
        shifts += 1
    term = total = Q(1)
    for n in range(1,65):
        term *= x/n
        total += term
    next_term = term*x/65
    tail = next_term/(1-x/66)
    result = I(total,total+tail)
    for _ in range(shifts):
        result = result*result
    return result


def exp(x):
    x = box(x)
    return I(exp_scalar(x.lo).lo, exp_scalar(x.hi).hi)


def log_unit(x):
    """log(x) for 1<=x<=2 via 2*atanh((x-1)/(x+1))."""
    x = Q(x)
    if not 1 <= x <= 2:
        raise ValueError("log_unit range")
    z_exact = (x-1)/(x+1)
    z, z2 = I(z_exact), I(z_exact*z_exact)
    term, total = z, I(0)
    count = 160
    for j in range(count):
        total += term/(2*j+1)
        term *= z2
    # Positive omitted series <= z^(2M+1)/((2M+1)*(1-z^2)).
    rem = 2*term / ((2*count+1)*(1-z2))
    return I(2*total.lo, 2*total.hi + rem.hi)


LOG2 = log_unit(Q(2))


def log_scalar(x):
    x = Q(x)
    if x <= 0:
        raise ValueError("log of nonpositive value")
    power = 0
    while x > 2:
        x /= 2
        power += 1
    while x < 1:
        x *= 2
        power -= 1
    return log_unit(x) + power*LOG2


def log(x):
    x = box(x)
    return I(log_scalar(x.lo).lo, log_scalar(x.hi).hi)


def hyp(t):
    et = exp(t)
    emt = exp(-box(t))
    return (et-emt)/2, (et+emt)/2


def C(t):
    s,h = hyp(t)
    return (s*h-t)/(box(t)*h-s)


def H(t,a,c):
    s,h = hyp(t)
    _,ha = hyp(a)
    return (box(t)*t-a*a)*s/(c+h)-2*t*log((c+h)/(c+ha))


def rho_stationary(t,e,c):
    s,h = hyp(t)
    return e*e*s/(2*t*(c+h))


def serial(x):
    x = box(x)
    return {"lower": str(x.lo), "upper": str(x.hi)}


def require(ok, message):
    if not ok:
        raise ArithmeticError(message)


def check_interior(k,epsilon,L,U,rho_lo,rho_hi):
    e = Q(epsilon)
    a = e/2
    c = Q(k-2)/2 / exp(a)
    low,high = Q(L),Q(U)
    phase = c-C(a)
    hlow,hhigh = H(low,a,c),H(high,a,c)
    curvature = C(low)-c
    require(phase.lo>0,"interior classification failed")
    require(low>a and high>low,"invalid bracket")
    require(hlow.lo>0 and hhigh.hi<0,"root signs uncertified")
    require(curvature.lo>0,"bracket not beyond inflection point")
    bounds = I(rho_stationary(high,e,c).lo,rho_stationary(low,e,c).hi)
    require(bounds.lo>=Q(rho_lo) and bounds.hi<=Q(rho_hi),"claimed rho enclosure failed")
    return {"k":k,"epsilon":epsilon,"t_bracket":[L,U],
            "rho_decimal_enclosure":[rho_lo,rho_hi],"rho_rational_enclosure":serial(bounds),
            "phase_difference":serial(phase),"H_lower":serial(hlow),"H_upper":serial(hhigh),
            "C_lower_minus_c":serial(curvature),"status":"proved_by_rational_intervals"}


def check_boundary(k,epsilon):
    e = Q(epsilon)
    a = e/2
    c = Q(k-2)/2 / exp(a)
    phase = C(a)-c
    require(phase.lo>0,"boundary classification failed")
    ee=exp(e)
    rho=e*(ee-1)/(ee+k-1)
    return {"k":k,"epsilon":epsilon,"C_a_minus_c":serial(phase),
            "rho_rational_enclosure":serial(rho),"status":"proved_by_rational_intervals"}


def check_transition(k,L,U):
    low,high=Q(L),Q(U)
    kval=lambda e:2+2*exp(e/2)*C(e/2)
    left,right=kval(low)-k,kval(high)-k
    require(left.hi<0 and right.lo>0,"transition signs uncertified")
    return {"k":k,"epsilon_bracket":[L,U],"left_sign":serial(left),
            "right_sign":serial(right),"status":"proved_by_rational_intervals"}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output",type=Path,default=Path("results/exact_certificate.json"))
    args=parser.parse_args()
    interior=[
        (7,"0.1","1.636370695872","1.636370695874","0.001496918479663","0.001496918479668"),
        (10,"1","1.686743925605","1.686743925607","0.148132973354","0.148132973357"),
        (100,"1","8.021666745077","8.021666745080","0.0611382122225","0.0611382122227"),
        (1000,"1","12.774110057981","12.774110057984","0.0390746579043","0.0390746579046"),
        (1000000,"1","26.621586056443","26.621586056447","0.0187817197204","0.0187817197207"),
    ]
    transitions=[(7,"0.436747543470","0.436747543471"),
                 (10,"1.301453285078","1.301453285081"),
                 (100,"5.101784832617","5.101784832620")]
    output={"arithmetic":"Fraction; 256-bit outward dyadic rounding; Taylor remainders",
            "scope":"Finite parameter and root enclosures; not a proof of the universal theorem",
            "interior":[check_interior(*row) for row in interior],
            "boundary":[check_boundary(*row) for row in [(2,"1"),(6,"0.1"),(7,"0.5"),(14,"2")]],
            "transitions":[check_transition(*row) for row in transitions]}
    output["certified_cases"]=len(interior)+4+len(transitions)
    output["status"]="PASS"
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(output,indent=2)+"\n")
    print(f"PASS: {output['certified_cases']} rational interval certificates -> {args.output}")


if __name__=="__main__":
    main()
