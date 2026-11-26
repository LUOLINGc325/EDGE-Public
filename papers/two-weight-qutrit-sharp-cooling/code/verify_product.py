#!/usr/bin/env python3
"""Exact product-configuration verification of the sharp two-weight qutrit bound.

This program does not use the path Fisher identity or the six-row shell table to
compute E and F. It groups exact product probabilities, enumerates every allowed
permutation, and builds both quadratic forms from their defining sums. Positive
semidefiniteness of C E-F is checked in Q(sqrt(r)), with exact rational signs.
Finite enumeration checks the reported scope; it is not the all-dimension proof.
"""
from __future__ import annotations

import argparse
from dataclasses import dataclass
from fractions import Fraction as F
from itertools import permutations, product
import json
from pathlib import Path

if not __debug__:
    raise RuntimeError("Verification requires assertions; do not run with python -O.")


@dataclass(frozen=True)
class Surd:
    """a+b sqrt(r), using exact rational comparisons (r>0)."""

    a: F
    b: F
    r: F

    def __add__(self, other):
        if not isinstance(other, Surd):
            other = Surd(F(other), F(0), self.r)
        assert self.r == other.r
        return Surd(self.a + other.a, self.b + other.b, self.r)

    __radd__ = __add__

    def __neg__(self):
        return Surd(-self.a, -self.b, self.r)

    def __sub__(self, other):
        return self + (-other if isinstance(other, Surd) else -F(other))

    def __mul__(self, other):
        if not isinstance(other, Surd):
            other = Surd(F(other), F(0), self.r)
        assert self.r == other.r
        return Surd(self.a * other.a + self.b * other.b * self.r,
                    self.a * other.b + self.b * other.a, self.r)

    __rmul__ = __mul__

    def sign(self):
        a, b, r = self.a, self.b, self.r
        if b == 0:
            return (a > 0) - (a < 0)
        if a == 0:
            return (b > 0) - (b < 0)
        if a > 0 and b > 0:
            return 1
        if a < 0 and b < 0:
            return -1
        gap = a*a - b*b*r
        result = (gap > 0) - (gap < 0)
        return result if a > 0 else -result

    def json(self):
        return {"rational": str(self.a), "sqrt_coefficient": str(self.b),
                "radicand": str(self.r)}


def psd_exact(matrix):
    """A real symmetric 2x2 matrix is PSD iff its principal minors are >=0."""
    h00, h01, h11 = matrix
    return h00.sign() >= 0 and h11.sign() >= 0 and (h00*h11-h01*h01).sign() >= 0


def chains_of(p, s):
    index = {value: i for i, value in enumerate(p)}
    assert len(index) == len(p)
    paths = []
    for value, i in index.items():
        if value / s in index:
            continue
        path = [i]
        value *= s
        while value in index:
            path.append(index[value])
            value *= s
        paths.append(path)
    assert sorted(i for path in paths for i in path) == list(range(len(p)))
    return paths


def sharp_constant(s, a, L):
    b, D = 3-a, a+(3-a)*s
    if L == 0:
        return Surd(F(0), F(0), F(1)), "no_resonance"
    single = 2*(1+s)/(3*D)
    if L == 1:
        return Surd(single, F(0), F(1)), "three_cycle"
    A = sum((s**j for j in range(0, L, 2)), F(0))
    B = sum((s**j for j in range(1, L, 2)), F(0))
    T = sum((s**j for j in range(1, L)), F(0))
    r = B/A
    alternating = Surd((1+s)/(2*D), T/(2*D*B), r)
    if (alternating-single).sign() > 0:
        return alternating, "alternating_transpositions"
    return Surd(single, F(0), r), "three_cycle"


def model(s, a, unnormalized_p):
    Z = sum(unnormalized_p, F(0))
    p = [x/Z for x in unnormalized_p]
    D, b = a+(3-a)*s, 3-a
    q = [F(1)/D]*a + [s/D]*b
    singleton = 0 if a == 1 else 2
    repeat = [y for y in range(3) if y != singleton]
    basis = [(0, 0)]*3
    basis[repeat[0]], basis[repeat[1]] = (1, 0), (0, 1)
    shells = {}
    for x, px in enumerate(p):
        for y, qy in enumerate(q):
            shells.setdefault(px*qy, []).append((x, y))
    paths = chains_of(p, s)
    return p, q, singleton, repeat, basis, shells, paths


def shell_options(p, basis, shells):
    """All exact local E and delta coefficients, computed from the definition."""
    options = []
    for weight, targets in shells.items():
        choices = []
        for sources in permutations(targets):
            E = [F(0), F(0), F(0)]
            delta = [[F(0), F(0)] for _ in p]
            for (x, y), (_, yy) in zip(targets, sources):
                du = basis[yy][0]-basis[y][0]
                dv = basis[yy][1]-basis[y][1]
                E[0] += weight*du*du
                E[1] += weight*du*dv
                E[2] += weight*dv*dv
                delta[x][0] += weight*du
                delta[x][1] += weight*dv
            choices.append((E, delta))
        options.append(choices)
    return options


def enumerate_model(name, s, a, raw_p):
    p, q, singleton, repeat, basis, shells, paths = model(s, a, raw_p)
    L = max(len(path)-1 for path in paths)
    C, mechanism = sharp_constant(s, a, L)
    restricted_C = (1+s)/(2*(a+(3-a)*s)) if L else F(0)
    assert (Surd(F(2,3), F(0), C.r)-C).sign() > 0 or L == 0
    options = shell_options(p, basis, shells)
    count, nonzero = 0, 0
    for combination in product(*options):
        count += 1
        E = [F(0), F(0), F(0)]
        delta = [[F(0), F(0)] for _ in p]
        for ee, dd in combination:
            for j in range(3):
                E[j] += ee[j]
            for x in range(len(p)):
                delta[x][0] += dd[x][0]
                delta[x][1] += dd[x][1]
        FF = [F(0), F(0), F(0)]
        for px, (du, dv) in zip(p, delta):
            FF[0] += du*du/px
            FF[1] += du*dv/px
            FF[2] += dv*dv/px
        if E[0] != 0 or E[2] != 0:
            nonzero += 1
        H = [C*ee-ff for ee, ff in zip(E, FF)]
        if not psd_exact(H):
            raise AssertionError((name, s, a, count, E, FF, C, H))
        # Equal perturbations on the repeated pair mean u=v. Check that
        # one-dimensional restriction directly from the computed forms.
        assert restricted_C*(E[0]+2*E[1]+E[2]) >= FF[0]+2*FF[1]+FF[2]
    return {"name": name, "s": str(s), "a": a, "b": 3-a,
            "p": [str(x) for x in p], "longest_chain_edges": L,
            "shell_sizes": sorted(len(x) for x in shells.values()),
            "permutations_checked": count, "nonzero_energy_forms": nonzero,
            "sharp_bound": C.json(), "optimal_mechanism": mechanism,
            "all_sharp_bound_psd_checks": True,
            "degeneracy_preserving_tangent_bound": str(restricted_C),
            "all_degeneracy_preserving_checks": True}


def witness_check(s, a, raw_p, kind):
    p, q, singleton, repeat, basis, shells, paths = model(s, a, raw_p)
    path = max(paths, key=len)
    L = len(path)-1
    assert L >= 1
    inverse = {(x,y):(x,y) for x in range(len(p)) for y in range(3)}
    A = sum((s**j for j in range(0,L,2)), F(0))
    B = sum((s**j for j in range(1,L,2)), F(0))
    T = sum((s**j for j in range(1,L)), F(0))
    D = a+(3-a)*s
    r = B/A if B else F(1)
    zero = Surd(F(0), F(0), r)
    if kind == "three_cycle":
        psi = [zero]*3
        psi[repeat[0]], psi[repeat[1]] = zero+2, zero+1
        i = 0
        weight = p[path[i]]*s/D
        shell = shells[weight]
        S = next(c for c in shell if c[1] == singleton)
        U = next(c for c in shell if c[1] == repeat[0])
        V = next(c for c in shell if c[1] == repeat[1])
        inverse[S], inverse[U], inverse[V] = U, V, S
        C = zero+2*(1+s)/(3*D)
    elif kind == "equal_repeated_tangent":
        psi = [zero]*3
        psi[repeat[0]], psi[repeat[1]] = zero+1, zero+1
        weight = p[path[0]]*s/D
        shell = shells[weight]
        S = next(c for c in shell if c[1] == singleton)
        U = next(c for c in shell if c[1] == repeat[0])
        inverse[S], inverse[U] = U, S
        C = zero+(1+s)/(2*D)
    else:
        assert L >= 2
        psi = [zero]*3
        psi[repeat[0]], psi[repeat[1]] = Surd(F(0), F(1), r), zero-1
        for i in range(L):
            weight = p[path[i]]*s/D
            shell = shells[weight]
            S = next(c for c in shell if c[1] == singleton)
            U = next(c for c in shell if c[1] == repeat[i % 2])
            inverse[S], inverse[U] = U, S
        C = Surd((1+s)/(2*D), T/(2*D*B), r)
    assert sorted(inverse.values()) == sorted(inverse)
    # Restore the physical tangent normalization; no gauge invariance is assumed
    # by the actual E,F computation below.
    mean = sum((qy*h for qy,h in zip(q,psi)), zero)
    psi = [h-mean for h in psi]
    assert sum((qy*h for qy,h in zip(q,psi)), zero).sign() == 0
    E = zero
    delta = [zero for _ in p]
    for (x,y), (xx,yy) in inverse.items():
        assert p[x]*q[y] == p[xx]*q[yy]
        change = psi[yy]-psi[y]
        E += p[x]*q[y]*change*change
        delta[x] += p[x]*q[y]*change
    FF = sum((dd*dd*(1/px) for px,dd in zip(p,delta)), zero)
    assert E.sign() > 0
    assert (FF-C*E).sign() == 0
    return {"s":str(s), "a":a, "dimension":len(p), "L":L,
            "mechanism":kind, "E_positive":True, "F_equals_C_E":True,
            "C":C.json()}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, required=True,
                        help="Explicit certificate destination, e.g. product_certificate.json")
    args = parser.parse_args()
    cases = []
    ratios = [F(1,25), F(1,9), F(1,4), F(4,9), F(9,10)]
    for s in ratios:
        for a in (1,2):
            for n in range(2,6):
                cases.append(enumerate_model(f"geometric_{n}",s,a,[s**j for j in range(n)]))
    for s in (F(1,4), F(4,9)):
        for a in (1,2):
            cases.append(enumerate_model("two_components_plus_isolate",s,a,
                         [F(1),s,s*s,F(7),7*s,F(11,13)]))
            cases.append(enumerate_model("no_mixed_shell",s,a,[F(1),F(7),F(11,13)]))
    witnesses = []
    for s in ratios:
        for a in (1,2):
            for L in range(1,17):
                raw_p=[s**j for j in range(L+1)]
                witnesses.append(witness_check(s,a,raw_p,"three_cycle"))
                witnesses.append(witness_check(s,a,raw_p,"equal_repeated_tangent"))
                if L>=2:
                    witnesses.append(witness_check(s,a,raw_p,"alternating_transpositions"))
            for kind in ("three_cycle","alternating_transpositions"):
                witnesses.append(witness_check(s,a,[F(1),s,s*s,s**3,F(7),7*s,F(11,13)],kind))
    result={"status":"passed", "arithmetic":"fractions.Fraction and exact real quadratic surds; no floating point decisions",
            "scope":"Exhaustive shell-preserving product permutations for the listed finite models; direct-definition E,F; analytic proof covers all remaining dimensions and weights.",
            "model_count":len(cases), "permutations_checked":sum(x["permutations_checked"] for x in cases),
            "exact_witness_count":len(witnesses), "models":cases,"witnesses":witnesses}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({k:v for k,v in result.items() if k not in ("models","witnesses")}))


if __name__ == "__main__":
    main()
