#!/usr/bin/env python3
"""Exact finite certificate for the Fredkin entropy bound.

Python standard library only. Polynomial identities are reconstructed from the
amplitude matrix; all Bernstein arithmetic and logarithm enclosures are rational.
This is an executable finite certificate, not a proof-assistant formalization.
"""
from __future__ import annotations

import argparse
from fractions import Fraction as F
from itertools import combinations, permutations, product
import json
from math import comb
from pathlib import Path

ZERO = (0, 0, 0, 0)


def require(condition, message):
    if not condition:
        raise ArithmeticError(message)


class Poly:
    """Sparse exact polynomial in the ordered variables p, q, a, b."""

    def __init__(self, value=0):
        if isinstance(value, Poly):
            self.t = value.t.copy()
        elif isinstance(value, dict):
            self.t = {k: F(v) for k, v in value.items() if v}
        else:
            self.t = {} if value == 0 else {ZERO: F(value)}

    def __add__(self, other):
        out = self.t.copy()
        for k, v in Poly(other).t.items():
            out[k] = out.get(k, F(0)) + v
        return Poly(out)

    __radd__ = __add__

    def __neg__(self):
        return Poly({k: -v for k, v in self.t.items()})

    def __sub__(self, other):
        return self + (-Poly(other))

    def __rsub__(self, other):
        return Poly(other) - self

    def __mul__(self, other):
        out = {}
        for k, v in self.t.items():
            for j, w in Poly(other).t.items():
                idx = tuple(x + y for x, y in zip(k, j))
                out[idx] = out.get(idx, F(0)) + v * w
        return Poly(out)

    __rmul__ = __mul__

    def __truediv__(self, number):
        return self * (F(1) / F(number))

    def __pow__(self, n):
        require(isinstance(n, int) and n >= 0, "nonnegative integer power required")
        out = Poly(1)
        for _ in range(n):
            out = out * self
        return out

    def scaled(self, factors):
        return Poly({k: v * prod(F(f) ** j for f, j in zip(factors, k))
                     for k, v in self.t.items()})

    def permuted(self, order):
        return Poly({tuple(k[i] for i in order): v for k, v in self.t.items()})

    def mixed_targets(self):
        return Poly({k: v for k, v in self.t.items() if k[2] == k[3] == 0})


def prod(items):
    result = F(1)
    for x in items:
        result *= x
    return result


def same(a, b, label):
    difference = Poly(a) - b
    require(not difference.t, "polynomial identity failed: " + label)


def determinant(matrix):
    n = len(matrix)
    out = Poly(0)
    for perm in permutations(range(n)):
        term = Poly((-1) ** sum(perm[i] > perm[j]
                               for i in range(n) for j in range(i + 1, n)))
        for i, j in enumerate(perm):
            term = term * matrix[i][j]
        out = out + term
    return out


def reconstruct():
    p, q, a, b = [Poly({tuple(int(i == j) for i in range(4)): 1}) for j in range(4)]
    c, d = (1 + a) / 2, (1 + b) / 2
    x = [(1-p)*d, (1-p)*(1-d), p*d, p*(1-d)]
    y = [(1-q)*c, (1-q)*(1-c), q*c, q*(1-c)]
    n = [[1, 1, 1, 1], [1, 1, 1, 1],
         [1, 1, 1, 0], [1, 1, 0, 1]]
    # Similar characteristic polynomial to M M^T, including singular endpoints.
    k = [[sum((n[i][l]*n[j][l]*y[l] for l in range(4)), Poly(0))*x[j]
          for j in range(4)] for i in range(4)]
    base = [Poly(1)]
    for size in range(1, 5):
        base.append(sum((determinant([[k[i][j] for j in ix] for i in ix])
                         for ix in combinations(range(4), size)), Poly(0)))
    same(base[4], 0, "rank-three matrix block")
    t, u, v = p*q, 1-p, 1-q
    same(base[1], 1-t/2+t*a*b/2, "manuscript cubic B1")
    same(base[2], t*(t*a*a*b*b+(3*t-4*q)*a*a+(3*t-4*p)*b*b
                    -8*u*v*a*b+t-4*p-4*q+8)/16, "manuscript cubic B2")
    same(base[3], t*t*u*v*(1-a*a)*(1-b*b)/16, "manuscript cubic B3")
    r, s = p*q*c*(1-d), p*q*(1-c)*d
    es = []
    for j in range(7):
        take = lambda i: base[i] if 0 <= i <= 4 else Poly(0)
        es.append(take(j) + (r+s)*take(j-1) + r*s*take(j-2))
    same(es[0], 1, "e0")
    same(es[1], 1, "unit trace")
    same(es[6], 0, "rank at most five")
    for j in range(2, 6):
        same(es[j], es[j].scaled([1, 1, -1, -1]), "common target flip")
        same(es[j], es[j].permuted([1, 0, 3, 2]), "exchange of sides")
    return (p, q, a, b), es


def high_region(variables, es):
    p, q, a, b = variables
    u, v, t, aa, bb = 1-p, 1-q, p*q, a*a, b*b
    f2 = t*aa*bb + q*(2-p)*aa + p*(2-q)*bb + 4*(u+v)*a*b
    f3 = (aa*(1+2*u-u*v) + bb*(1+2*v-u*v) - (1+5*u*v)*aa*bb
          + 2*a*b*((u+v+2*u*v)-u*(1-v)*aa-v*(1-u)*bb))
    cc = 1+3*u+3*v+9*u*v
    f4 = cc-q*(4-3*p)*aa-p*(4-3*q)*bb+t*aa*bb-16*u*v*a*b
    same(es[2].mixed_targets()-es[2], t*f2/8, "high e2 deficit")
    same(es[3].mixed_targets()-es[3], t*t*f3/16, "high e3 deficit")
    same(es[4], t**3*(1-aa)*(1-bb)*f4/256, "high e4 formula")
    same(es[5], t**4*u*v*(1-aa)**2*(1-bb)**2/256, "e5 formula")
    # Exact constants in the manuscript's analytic nonnegativity bounds.
    require(1-F(1,5)-3*F(1,5)-F(1,25) == F(4,25), "e2 constant")
    require(F(1,2)-F(1,5)-F(11,2)*F(1,25) == F(2,25), "e3 constant")
    require(F(2,5)-8*F(1,25) == F(2,25), "e4 constant")
    return {"identities": 4, "status": "PASS",
            "analytic_bounds": {"f2": "(4/25)(a^2+b^2)",
                                "f3": "(2/25)(a^2+b^2)",
                                "e4_inner_deficit": "(2/25)(a^2+b^2)"}}


def bernstein(poly):
    deg = tuple(max((k[j] for k in poly.t), default=0) for j in range(4))
    indices = list(product(*(range(x+1) for x in deg)))
    values = {ix: poly.t.get(ix, F(0)) for ix in indices}
    for axis, n in enumerate(deg):
        new = {}
        for ix in indices:
            val = F(0)
            for j in range(ix[axis]+1):
                src = list(ix)
                src[axis] = j
                val += values[tuple(src)]*F(comb(ix[axis], j), comb(n, j))
            new[ix] = val
        values = new
    return deg, values


def split(deg, values, axis):
    left, right = {}, {}
    other = [j for j in range(4) if j != axis]
    for fixed in product(*(range(deg[j]+1) for j in other)):
        ix = [0]*4
        for j, val in zip(other, fixed):
            ix[j] = val
        row = []
        for k in range(deg[axis]+1):
            ix[axis] = k
            row.append(values[tuple(ix)])
        lft, rgt = [row[0]], [row[-1]]
        while len(row) > 1:
            row = [(row[j]+row[j+1])/2 for j in range(len(row)-1)]
            lft.append(row[0])
            rgt.append(row[-1])
        for k, (lv, rv) in enumerate(zip(lft, reversed(rgt))):
            ix[axis] = k
            left[tuple(ix)], right[tuple(ix)] = lv, rv
    return left, right


LEAVES = {
    (2, 1): [[]],
    (2, -1): [[3,1,3,5], [3,1,3,4,1,7], [3,1,3,4,1,6,1,5],
              [3,1,3,4,1,6,1,4], [3,1,3,4,1,6,0], [3,1,3,4,0],
              [3,1,2], [3,0], [2]],
    (3, 1): [[]], (3, -1): [[1], [0]],
    (4, 1): [[]], (4, -1): [[]],
}


def cover(paths):
    """Check that the prescribed leaves exactly partition the initial cube."""
    require(len(paths) == len(set(map(tuple, paths))), "duplicate leaf")
    if [] in paths:
        require(len(paths) == 1, "leaf has descendants")
        return
    first = sorted(set(path[0] for path in paths))
    require(len(first) == 2 and first[0] % 2 == 0 and first[1] == first[0]+1,
            "incomplete or inconsistent subdivision")
    for code in first:
        require(0 <= code <= 7, "invalid subdivision axis")
        cover([path[1:] for path in paths if path[0] == code])


def low_region(es):
    mu = [F(39,100), F(1,5), F(1,5), F(1,5), F(1,100)]
    target = {j: sum((prod(c) for c in combinations(mu, j)), F(0)) for j in range(2,6)}
    rows = []
    for (j, sign), paths in LEAVES.items():
        cover(paths)
        gap = target[j] - es[j].scaled([F(4,5), 1, 1, sign])
        degree, coeffs = bernstein(gap)
        leaf_rows = []
        for path in paths:
            current = coeffs
            for code in path:
                current = split(degree, current, code//2)[code % 2]
            lower = min(current.values())
            require(lower > 0, "nonpositive Bernstein coefficient")
            leaf_rows.append({"path": path, "minimum_coefficient": str(lower),
                              "coefficient_count": len(current)})
        rows.append({"elementary_degree": j, "target_sign": sign,
                     "multidegree": degree, "leaves": leaf_rows})
    bound_e5 = F(256, 9765625)
    require(bound_e5 < target[5], "e5 upper bound")
    # H(mu) < 2 in bits is precisely this integer inequality.
    require(100**100 < 2**200 * 39**39 * 20**60, "comparison entropy below two")
    return {"status": "PASS", "comparison_spectrum": list(map(str, mu)),
            "comparison_elementary_coefficients": {str(k): str(v) for k,v in target.items()},
            "strict_entropy_integer_check": "100^100 < 2^200 * 39^39 * 20^60",
            "e5_global_bound": str(bound_e5), "leaf_count": sum(len(r["leaves"]) for r in rows),
            "groups": rows}


def log_interval(x, terms=120):
    """Rigorous rational enclosure using log(x)=2 atanh((x-1)/(x+1))."""
    x = F(x)
    require(x > 0, "positive logarithm argument")
    exponent = 0
    while x > 2:
        x /= 2
        exponent += 1
    while x < 1:
        x *= 2
        exponent -= 1

    def series(y):
        z = (y-1)/(y+1)
        value = sum((2*z**(2*k+1)/F(2*k+1) for k in range(terms)), F(0))
        remainder = 2*z**(2*terms+1)/(F(2*terms+1)*(1-z*z))
        return value, value+remainder

    lo, hi = series(x)
    l2, h2 = series(F(2))
    if exponent >= 0:
        return lo+exponent*l2, hi+exponent*h2
    return lo+exponent*h2, hi+exponent*l2


def g_interval(z):
    lz, hz = log_interval(z)
    lu, hu = log_interval((1+z)/(1-z))
    factor = (1+z)*(3+z)/(2*z*(1-2*z))
    return lz+factor*lu, hz+factor*hu


def root_certificate():
    lo = F("0.03434315277502667444460539397551")
    hi = F("0.03434315277502667444460539397552")
    gl, gh = g_interval(lo), g_interval(hi)
    require(gl[1] < 0 < gh[0], "unique-root bracket signs")
    # Strict monotonicity of G is established analytically in the manuscript.
    pfun = lambda z: 2*(1-z)/(z*z-z+2)
    plo, phi = pfun(hi), pfun(lo)
    # At the root these four expressions have definite monotonicities on (0,1/10).
    # lambda+ increases, the three equal lambdas decrease, and lambda- increases.
    def weights(z):
        dd = (z*z-z+2)**2
        return [(1+z)**2/dd] + [(1-z)**2/dd]*3 + [z*z*(1-z)**2/dd]

    wl, wh = weights(lo), weights(hi)
    intervals = [(min(a,b), max(a,b)) for a,b in zip(wl,wh)]
    require(all(0 < a <= b < F(1,3) for a,b in intervals), "entropy monotonic interval")
    # -x log x is increasing on (0,1/3), since e<3.
    lower, upper = F(0), F(0)
    for a,b in intervals:
        la, ha = log_interval(a)
        lb, hb = log_interval(b)
        lower += -a*ha
        upper += -b*lb
    log2lo, log2hi = log_interval(F(2))
    bits_lower, bits_upper = lower/log2hi, upper/log2lo
    announced_low = F("2.0005218601563057308143799514")
    announced_high = F("2.0005218601563057308143799515")
    require(announced_low < bits_lower <= bits_upper < announced_high,
            "entropy bracket containment")
    p_announced_low = F("0.9819392163298089913774376228")
    p_announced_high = F("0.9819392163298089913774376230")
    require(p_announced_low < plo < phi < p_announced_high, "control bracket containment")
    return {"status": "PASS", "logarithm_series_terms": 120,
            "z_strict_lower": str(lo), "z_strict_upper": str(hi),
            "control_probability_strict_decimal_bounds": ["0.9819392163298089913774376228", "0.9819392163298089913774376230"],
            "entropy_bits_strict_decimal_bounds": ["2.0005218601563057308143799514", "2.0005218601563057308143799515"],
            "endpoint_signs": ["negative", "positive"]}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    variables, es = reconstruct()
    result = {"certificate_version": 1, "status": "PASS",
              "arithmetic": "Python standard-library integers and fractions.Fraction only",
              "scope": "Finite polynomial identities, low-region covering certificate, and rational log enclosures; universal analytic reductions are proved in the manuscript",
              "polynomial_terms": {str(j): len(es[j].t) for j in range(2,6)},
              "high_region": high_region(variables, es),
              "low_region": low_region(es),
              "unique_root": root_certificate()}
    serialized = json.dumps(result, indent=2, ensure_ascii=False) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(serialized, encoding="utf-8")
    print(serialized)


if __name__ == "__main__":
    main()
