#!/usr/bin/env python3
"""Rigorous rational logarithm bounds for one finite curvature evaluation.

All arithmetic underlying the interval is fractions.Fraction. Decimal output is
only a readable rendering. This certifies a *single point*, never all parameters
or all weight vectors. A positive lower bound would refute the corresponding
inequality. No such positive-weight counterexample was known when implemented.
"""
from __future__ import annotations
import argparse
from collections import defaultdict
from decimal import Decimal, localcontext
from fractions import Fraction as F
from functools import lru_cache
import json
from math import comb

from entropy_search import collision_counts


@lru_cache(maxsize=None)
def log_near_one_bounds(numerator, denominator, terms):
    """0 <= z <= 1/3; log(y)=2 atanh(z), y in [1,2]."""
    y=F(numerator,denominator)
    assert 1 <= y <= 2
    z=(y-1)/(y+1)
    power=z
    total=F(0)
    z2=z*z
    for j in range(terms):
        total += 2*power/(2*j+1)
        power *= z2
    tail=2*power/((2*terms+1)*(1-z2))
    return total,total+tail


@lru_cache(maxsize=None)
def log_integer_bounds(integer, terms):
    assert integer >= 1
    exponent=integer.bit_length()-1
    a,b=log_near_one_bounds(integer,1<<exponent,terms)
    lo2,hi2=log_near_one_bounds(2,1,terms)
    return a+exponent*lo2,b+exponent*hi2


def curvature_expression(weights, p):
    """Return rational constant + sum coeff[M]*log(M), exactly.

    At p=a/b, q_s=M_s/b^n and sum_s q_s''=0, so all log(b) terms
    cancel. This avoids unnecessary common-denominator logarithm bounds.
    """
    n=len(weights)
    a,b=p.numerator,p.denominator
    coeff=defaultdict(F)
    constant=F(0)
    sums=[F(0),F(0),F(0)]
    for layer in collision_counts(weights).values():
        M=sum(c*a**k*(b-a)**(n-k) for k,c in layer.items())
        q=F(M,b**n)
        r=t=F(0)
        for k,c in layer.items():
            mass=F(c*a**k*(b-a)**(n-k),b**n)
            score=F(k,1)/p-F(n-k,1)/(1-p)
            score_prime=-F(k,1)/p**2-F(n-k,1)/(1-p)**2
            r+=mass*score
            t+=mass*(score**2+score_prime)
        coeff[M]-=t
        constant-=r*r/q
        for j,v in enumerate((q,r,t)): sums[j]+=v
    assert sums==[F(1),F(0),F(0)],sums
    return constant,{integer:c for integer,c in coeff.items() if c and integer!=1}


def bound_expression(constant,coeff,terms):
    lo=hi=constant
    for integer,c in coeff.items():
        a,b=log_integer_bounds(integer,terms)
        if c>0:
            lo+=c*a; hi+=c*b
        else:
            lo+=c*b; hi+=c*a
    return lo,hi


def conditional_rank_expression(weights,p):
    """Exact second derivative of E[H(S|K)] as a log expression."""
    n=len(weights)
    by_k=defaultdict(list)
    for layer in collision_counts(weights).values():
        for k,c in layer.items():by_k[k].append(c)
    coeff=defaultdict(F)
    for k in range(n+1):
        choose=comb(n,k)
        b=F(choose)*p**k*(1-p)**(n-k)
        score=F(k)/p-F(n-k)/(1-p)
        score_prime=-F(k)/p**2-F(n-k)/(1-p)**2
        bpp=b*(score**2+score_prime)
        coeff[choose]+=bpp
        for count in by_k[k]:coeff[count]-=bpp*F(count,choose)
    return F(0),{integer:c for integer,c in coeff.items() if c and integer!=1}


def decimal_string(x,precision=60):
    with localcontext() as ctx:
        ctx.prec=precision
        return str(Decimal(x.numerator)/Decimal(x.denominator))


def certify(weights,p,kind,terms=60):
    constant,coeff=curvature_expression(weights,p)
    if kind=="strong":
        constant+=1/(p*(1-p))
    elif kind=="binomial":
        c2,coeff2=curvature_expression([1]*len(weights),p)
        constant-=c2
        for integer,c in coeff2.items(): coeff[integer]=coeff.get(integer,F(0))-c
    elif kind=="mutual":
        c2,coeff2=conditional_rank_expression(weights,p)
        constant-=c2
        for integer,c in coeff2.items():coeff[integer]=coeff.get(integer,F(0))-c
    elif kind=="conditional":
        constant,coeff=conditional_rank_expression(weights,p)
    elif kind!="concavity": raise ValueError(kind)
    lo,hi=bound_expression(constant,coeff,terms)
    return {
        "weights":list(weights),"parameter":str(p),"inequality":kind,
        "target_expression":{"concavity":"H_w''(p)","strong":"H_w''(p)+1/(p(1-p))","binomial":"H_w''(p)-H_Bin(n,p)''","mutual":"I(K;S_w)''(p)","conditional":"E[H(S_w|K)]''(p)"}[kind],
        "constant":str(constant),
        "log_terms":{str(k):str(v) for k,v in sorted(coeff.items()) if v},
        "series_terms":terms,
        "lower_rational":str(lo),"upper_rational":str(hi),
        "lower_decimal":decimal_string(lo),"upper_decimal":decimal_string(hi),
        "interval_width_decimal":decimal_string(hi-lo),
        "conclusion":"strict_positive_counterexample" if lo>0 else "strict_negative_at_this_point" if hi<0 else "inconclusive_or_exact_zero",
        "scope":"one_point_exact_rational_logarithm_interval",
    }


if __name__=="__main__":
    ap=argparse.ArgumentParser()
    ap.add_argument("--weights",required=True)
    ap.add_argument("--p",default="1/2")
    ap.add_argument("--kind",choices=("concavity","strong","binomial","mutual","conditional"),default="concavity")
    ap.add_argument("--terms",type=int,default=60)
    args=ap.parse_args()
    weights=[int(x) for x in args.weights.split(',')]
    if not weights or min(weights)<1 or 1 not in weights: raise ValueError("positive integer weights containing 1 required")
    p=F(args.p)
    if not 0<p<1: raise ValueError("0<p<1 required")
    print(json.dumps(certify(weights,p,args.kind,args.terms),indent=2))
