#!/usr/bin/env python3
"""Exact unrestricted deterministic adaptive oracle scheduling.

This implements a threshold game on (unseen, pending long, total known long).
It does not assume either postponement or the two-phase conjecture.  Arithmetic
inside each threshold evaluation is integer arithmetic after clearing the
input denominators.  It is ordinary executable reproduction code, not Lean.
"""
from fractions import Fraction
from math import lcm
import argparse
import json


def tri(k):
    return k * (k + 1) // 2


def threshold_table(n, p, x, rho):
    p, x, rho = Fraction(p), Fraction(x), Fraction(rho)
    if n < 1 or p <= 0 or x <= 0:
        raise ValueError("n >= 1 and p,x > 0 are required")
    q = lcm(p.denominator, x.denominator)
    pp, xx = int(p*q), int(x*q)
    aa, bb = rho.numerator, rho.denominator
    values, actions = {}, {}
    for f in range(n + 1):
        for ell in range(n - f + 1):
            for d in range(ell + 1):
                state = (f, d, ell)
                if f == 0:
                    values[state] = bb*xx*tri(d) - aa*xx*tri(ell)
                    actions[state] = ("finish",)
                    continue
                rank = f+d
                options = {
                    "test": bb*q*rank + max(values[(f-1,d,ell)],
                                            values[(f-1,d+1,ell+1)]),
                    "execute_unknown": max(values[(f-1,d,ell)],
                                            bb*xx*rank+values[(f-1,d,ell+1)]),
                }
                if d:
                    options["execute_known_long"] = (
                        bb*xx*rank + values[(f,d-1,ell)]
                    )
                best = min(options.values())
                values[state] = best
                actions[state] = tuple(k for k, v in options.items() if v == best)
    residual = (bb-aa)*pp*tri(n) + values[(n,0,0)]
    return residual, values, actions, {
        "scale_q": q, "integer_p": pp, "integer_x": xx,
        "threshold_numerator": aa, "threshold_denominator": bb,
    }


def solve(n, p, x):
    p, x = Fraction(p), Fraction(x)
    if n < 1 or p <= 0 or x <= 0:
        raise ValueError("n >= 1 and p,x > 0 are required")
    q = lcm(p.denominator, x.denominator)
    pp, xx = int(p*q), int(x*q)
    denominator_bound = tri(n)*(pp+xx)
    lo, hi = Fraction(1), Fraction(n)
    evaluations = 0
    while (hi-lo)*2*denominator_bound**2 >= 1:
        mid = (lo+hi)/2
        residual, _, _, _ = threshold_table(n,p,x,mid)
        evaluations += 1
        if residual == 0:
            lo = hi = mid
            break
        if residual > 0:
            lo = mid
        else:
            hi = mid
    value = ((lo+hi)/2).limit_denominator(denominator_bound)
    if not lo <= value <= hi:
        raise AssertionError("rational reconstruction left the certified interval")
    residual, table, actions, scale = threshold_table(n,p,x,value)
    evaluations += 1
    if residual != 0:
        raise AssertionError("reconstructed optimum did not have zero threshold value")
    return {
        "n": n, "p": str(p), "x": str(x),
        "optimal_competitive_ratio": str(value),
        "threshold_residual": residual,
        "root_optimal_actions": actions[(n,0,0)],
        "state_count": len(table),
        "denominator_bound": denominator_bound,
        "bisection_lower": str(lo), "bisection_upper": str(hi),
        "threshold_evaluations": evaluations,
        "input_scaling": scale,
        "known_long_execution_included": True,
        "two_phase_assumption": False,
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--n", type=int, required=True)
    parser.add_argument("--p", required=True)
    parser.add_argument("--x", required=True)
    parser.add_argument("--output")
    args = parser.parse_args()
    answer = json.dumps(solve(args.n,args.p,args.x),indent=2)+"\n"
    if args.output:
        with open(args.output,"w") as handle:
            handle.write(answer)
    print(answer,end="")
