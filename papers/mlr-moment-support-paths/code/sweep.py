#!/usr/bin/env python3
"""Exact all-bias endpoint-moment certificates; no formal proof code.

Generation uses support pivots.  verify_certificate.py checks the result
independently from polynomial moment and dual identities, not from pivot rules.
"""
from __future__ import annotations

import argparse
from functools import lru_cache, cmp_to_key
import hashlib
import json
import math
from pathlib import Path
import platform
import time

import sympy as sp
from sympy.functions.combinatorial.numbers import stirling
from algebra import compare, interval, rational_between

p, x = sp.symbols("p x")


def qstr(value):
    value = sp.Rational(value)
    return str(value)


def poly_data(poly):
    poly = sp.Poly(poly, p, domain=sp.QQ)
    return [qstr(v) for v in poly.all_coeffs()]


@lru_cache(None)
def moment(N, degree):
    return sum(sp.Integer(stirling(degree, r, kind=2))
               * sp.Integer(math.factorial(N) // math.factorial(N-r)) * p**r
               for r in range(min(degree, N)+1))


def binomial_expectation(poly, N, shift=0):
    poly = sp.Poly(sp.Poly(poly, x).as_expr().subs(x, x+shift), x)
    return sp.Poly(sum(coef * moment(N, power[0])
                       for power, coef in poly.terms()), p, domain=sp.QQ)


def cardinal_weights(nodes, N, shift=0):
    result = {}
    for j in nodes:
        cardinal = sp.prod((x-h) / sp.Integer(j-h) for h in nodes if h != j)
        result[j] = binomial_expectation(cardinal, N, shift)
    return result


@lru_cache(None)
def internal_roots(coefficients):
    poly = sp.Poly.from_list(list(coefficients), p, domain=sp.QQ)
    if poly.is_zero:
        raise ValueError("Identically zero weight is not an admissible strict regime")
    result = poly.real_roots(radicals=False)
    return tuple(dict.fromkeys(r for r in result if compare(r,sp.Rational(0))>0
                              and compare(r,sp.Rational(1))<0))


def roots_of(poly):
    return internal_roots(tuple(poly.all_coeffs()))


def root_data(root):
    if root.is_Rational:
        return {"kind": "rational", "value": qstr(root)}
    a,b = interval(root)
    return {"kind": "real_algebraic", "polynomial": [str(v) for v in root.poly.all_coeffs()],
            "real_root_index": int(root.index),
            "isolating_interval": [qstr(a), qstr(b)]}


def successor(nodes, departing, maximum):
    blocks = []
    for j in nodes:
        if not blocks or j != blocks[-1][-1] + 1:
            blocks.append([j])
        else:
            blocks[-1].append(j)
    new_nodes = set(nodes)
    replacements = []
    for block in blocks:
        exits = sorted(set(block).intersection(departing))
        if exits:
            old, new = exits[0], block[-1]+1
            if new > maximum:
                raise AssertionError("Terminal block cannot exit")
            new_nodes.remove(old)
            new_nodes.add(new)
            replacements.append([old, new])
    return tuple(sorted(new_nodes)), replacements


def generate(n, k):
    if not 2 <= k < n:
        raise ValueError("Require 2 <= k < n; elementary k=0,1,n handled separately")
    started = time.monotonic()
    m = k//2
    odd = k % 2
    N = n-1-odd
    shift = odd
    nodes = tuple(range(shift, shift+2*m))
    current = sp.Rational(0)
    regimes = []
    while True:
        transformed = cardinal_weights(nodes, N, shift)
        candidate_roots = [(r, j) for j in nodes[::2]
                           for r in roots_of(transformed[j]) if compare(r,current)>0]
        following = min((r for r, j in candidate_roots), default=sp.Rational(1),
                        key=cmp_to_key(compare))
        departing = [j for j in nodes[::2]
                     if any(compare(r,following)==0 for r in roots_of(transformed[j]))]
        support = ((0,) if odd else ()) + nodes + (n,)
        weights = cardinal_weights(support, n)
        sample = rational_between(current, following)
        if not all(poly.eval(sample) > 0 for poly in weights.values()):
            raise AssertionError(f"Nonpositive regime {n,k,nodes,sample}")
        if following != 1:
            new_nodes, replacements = successor(nodes, departing, n-1)
            departure_gcd = transformed[departing[0]]
            for j in departing[1:]:
                departure_gcd = sp.gcd(departure_gcd, transformed[j])
            departure_gcd = departure_gcd.clear_denoms()[1].primitive()[1]
            if departure_gcd.LC() < 0:
                departure_gcd = -departure_gcd
        else:
            new_nodes, replacements = None, []
            departure_gcd = None
        regimes.append({"index": len(regimes), "paired_nodes": list(nodes),
                        "support": list(support), "left": root_data(current),
                        "right": root_data(following), "sample": qstr(sample),
                        "transformed_weights": {str(j): poly_data(v) for j,v in transformed.items()},
                        "weights": {str(j): poly_data(v) for j,v in weights.items()},
                        "objective": poly_data(weights[n]), "departing_left_nodes": departing,
                        "replacements": replacements,
                        "departure_gcd": poly_data(departure_gcd) if departure_gcd is not None else None})
        if following == 1:
            break
        current, nodes = following, new_nodes
        if len(regimes) > m*(n-k)+1:
            raise AssertionError("More regimes than the proposed universal bound")
    transitions = [r for r in regimes if r["replacements"]]
    exceptional = [r for r in transitions if len(r["replacements"]) > 1]
    nonunit = [r for r in transitions if any(b-a != 2 for a,b in r["replacements"])]
    unit_scope = (not odd and k <= n-2) or (odd and k-1 <= n-3)
    if unit_scope:
        assert all(b-a == 2 for r in transitions for a,b in r["replacements"])
    return {"format": "endpoint-binomial-phase-certificate-v1", "n": n, "k": k,
            "parameter": "p", "parameter_domain": "0 < p < 1",
            "endpoint_optima": {"p=0": {"support": [0], "weights": ["1"], "objective": "0"},
                                "p=1": {"support": [n], "weights": ["1"], "objective": "1"}},
            "regime_bound": m*(n-k)+1, "regime_count": len(regimes),
            "exceptional_points": [r["right"] for r in exceptional],
            "exceptional_point_definition": "A transition with at least two support replacements",
            "nonunit_transitions": [{"point":r["right"],"replacements":r["replacements"]}
                                    for r in nonunit],
            "all_observed_exceptional_points_rational": all(r["right"]["kind"] == "rational" for r in exceptional),
            "binomial_unit_pivot_scope": bool(unit_scope), "regimes": regimes,
            "generation_seconds": round(time.monotonic()-started, 6),
            "environment": {"python": platform.python_version(), "sympy": sp.__version__}}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--n", type=int, required=True)
    parser.add_argument("--k", type=int, required=True)
    parser.add_argument("--output", required=True)
    args = parser.parse_args()
    result = generate(args.n, args.k)
    target = Path(args.output)
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(result, ensure_ascii=False, indent=2)+"\n")
    print(json.dumps({"file": str(target), "n":args.n,"k":args.k,
                      "regimes":result["regime_count"],"bound":result["regime_bound"],
                      "exceptional_points":result["exceptional_points"],
                      "seconds":result["generation_seconds"],
                      "sha256": hashlib.sha256(target.read_bytes()).hexdigest()}))


if __name__ == "__main__":
    main()
