#!/usr/bin/env python3
"""Exact S^3 polynomial integration; no floating point and no external packages.

This checks the finite algebra in the manuscript. The general sphere-moment
formula and the probabilistic interpretation are proved in the manuscript,
not certified merely by executing this program.
"""
from __future__ import annotations

import argparse
from fractions import Fraction as F
from itertools import product
import json
from pathlib import Path


class Poly:
    def __init__(self, n, terms=None):
        self.n = n
        self.t = {tuple(k): F(v) for k, v in (terms or {}).items() if v}

    @classmethod
    def const(cls, n, c):
        return cls(n, {(0,) * n: F(c)})

    @classmethod
    def var(cls, n, i):
        k = [0] * n
        k[i] = 1
        return cls(n, {tuple(k): F(1)})

    def coerce(self, other):
        return other if isinstance(other, Poly) else Poly.const(self.n, other)

    def __add__(self, other):
        other = self.coerce(other)
        assert self.n == other.n
        t = dict(self.t)
        for k, v in other.t.items():
            t[k] = t.get(k, F(0)) + v
        return Poly(self.n, t)

    __radd__ = __add__

    def __neg__(self):
        return Poly(self.n, {k: -v for k, v in self.t.items()})

    def __sub__(self, other):
        return self + -self.coerce(other)

    def __rsub__(self, other):
        return self.coerce(other) - self

    def __mul__(self, other):
        other = self.coerce(other)
        assert self.n == other.n
        t = {}
        for k, a in self.t.items():
            for l, b in other.t.items():
                m = tuple(x + y for x, y in zip(k, l))
                t[m] = t.get(m, F(0)) + a * b
        return Poly(self.n, t)

    __rmul__ = __mul__

    def __pow__(self, k):
        assert isinstance(k, int) and k >= 0
        result = Poly.const(self.n, 1)
        for _ in range(k):
            result = result * self
        return result

    def lift(self, n, offset):
        return Poly(n, {(0,) * offset + k + (0,) * (n - offset - self.n): v
                        for k, v in self.t.items()})

    def evaluate(self, x):
        return sum((c * prod(v ** k for v, k in zip(x, e))
                    for e, c in self.t.items()), F(0))


def prod(xs):
    answer = F(1)
    for x in xs:
        answer *= x
    return answer


def sphere_moment(e):
    """Normalized S^3 monomial moment, proved from rotational symmetry."""
    assert len(e) == 4
    if any(k % 2 for k in e):
        return F(0)
    a = [k // 2 for k in e]
    numerator = prod(prod(range(1, 2 * k, 2)) for k in a)
    denominator = prod(4 + 2 * j for j in range(sum(a)))
    return numerator / denominator


def integrate(p):
    assert p.n % 4 == 0
    return sum((c * prod(sphere_moment(e[j:j+4])
                         for j in range(0, p.n, 4)) for e, c in p.t.items()), F(0))


def density(x, kind, c=F(1,4), d=F(1,4), eps=F(1,2)):
    if kind == 'A_mode':
        return (1+F(1,4)*x[0]+F(1,4)*(2*(x[0]**2+x[1]**2)-1)
            +F(1,8)*x[2]*(x[0]+F(1,6))*(1-x[0]))
    if kind == 'B_mode':
        return 1+F(1,4)*x[0]+F(1,4)*(2*(x[0]**2+x[1]**2)-1)+F(5,48)*x[1]*x[3]
    anisotropy = x[0] * x[2] if kind == 'A' else x[1] * x[3]
    return 1 + c*x[0] + d*(2*(x[0]**2+x[1]**2)-1) + eps*anisotropy


def main():
    if not __debug__:
        raise SystemExit("Verification requires assertions: do not use python -O or -OO.")
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    x = [Poly.var(4, i) for i in range(4)]
    q = x[0]**2 + x[1]**2
    ur = x[0]*x[2] - x[1]*x[3]
    ui = x[0]*x[3] + x[1]*x[2]
    vr = x[0]*x[2] + x[1]*x[3]
    vi = x[1]*x[2] - x[0]*x[3]
    laws = {}
    checks = 0
    for kind in ('A', 'B', 'A_mode', 'B_mode'):
        f = density(x, kind)
        record = {
            'mass': integrate(f),
            'mean': [integrate(z*f) for z in x],
            'q': integrate(q*f),
            'u': [integrate(ur*f), integrate(ui*f)],
            'v': [integrate(vr*f), integrate(vi*f)],
        }
        assert record['mass'] == 1
        assert record['mean'] == [F(1,16), F(0), F(0), F(0)]
        assert record['q'] == F(13,24)
        coherence = F(5,1152) if kind.endswith('_mode') else F(1,48)
        assert record['u'] == [(1 if kind.startswith('A') else -1)*coherence, F(0)]
        assert record['v'] == [coherence, F(0)]
        checks += 5
        laws[kind] = record

    z = [Poly.var(8, i) for i in range(8)]
    a, b = z[:4], z[4:]
    # First a, then b. This is the first column of U(b) U(a).
    r0 = b[0]*a[0]-b[1]*a[1]-b[2]*a[2]-b[3]*a[3]
    r1 = b[0]*a[1]+b[1]*a[0]-b[2]*a[3]+b[3]*a[2]
    composed = r0**2 + r1**2
    qa, qb = a[0]**2+a[1]**2, b[0]**2+b[1]**2
    ba, bb = a[2]**2+a[3]**2, b[2]**2+b[3]**2
    u2r, u2i = b[0]*b[2]-b[1]*b[3], b[0]*b[3]+b[1]*b[2]
    v1r, v1i = a[0]*a[2]+a[1]*a[3], a[1]*a[2]-a[0]*a[3]
    algebraic_difference = composed - (qa*qb+ba*bb-2*(u2r*v1r-u2i*v1i))
    assert not algebraic_difference.t
    checks += 1
    scalar = F(1,2) + 2*(F(13,24)-F(1,2))**2
    rows = []
    for first, second in [p for pair in [('A','B'),('A_mode','B_mode')] for p in product(pair,repeat=2)]:
        answer = integrate(composed*density(a, first)*density(b, second))
        correction = -2 * laws[second]['u'][0] * laws[first]['v'][0]
        assert answer == scalar + correction
        assert answer >= F(1,2)
        assert correction != 0
        checks += 3
        rows.append({'first':first,'second':second,'predicted':scalar,
                     'actual':answer,'discrepancy':correction})

    # Check the whole low-degree moment table independently against a rational
    # 24-cell cubature. This is finite cubature verification, not Haar existence.
    points = []
    for i in range(4):
        for sign in (-1,1):
            v = [F(0)]*4
            v[i] = F(sign)
            points.append(tuple(v))
    points += list(product((F(-1,2),F(1,2)), repeat=4))
    moment_count = 0
    for e in product(range(6), repeat=4):
        if sum(e) > 5:
            continue
        value = sum((prod(v**k for v,k in zip(p,e)) for p in points), F(0))/24
        assert value == sphere_moment(e)
        moment_count += 1
    assert moment_count == 126
    checks += moment_count
    out = {'status':'passed','arithmetic':'Python Fraction, exact rational',
           'scope':'Polynomial algebra and moments, not end-to-end Lean or a proof of the sphere measure construction',
           'checks':checks,'sphere_monomials_through_degree_5':moment_count,
           'laws':laws,'compositions':rows,'cubature_points':len(points)}
    encoded = json.dumps(out, default=str, ensure_ascii=False, indent=2)+'\n'
    if args.output:
        args.output.write_text(encoded,encoding='utf-8')
    print(encoded,end='')


if __name__ == '__main__':
    main()
