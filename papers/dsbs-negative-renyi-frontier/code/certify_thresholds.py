"""Exact rational interval certificates for the negative-Renyi phase curve.

This is a finite certificate generator, not a formal proof of the continuum
theorem. All certified arithmetic uses fractions.Fraction and integer sqrt.
mpmath is used only to propose narrow rational root brackets.
"""
from __future__ import annotations

import argparse
import json
import math
from dataclasses import dataclass
from decimal import Decimal, localcontext
from fractions import Fraction as Q
from pathlib import Path


@dataclass(frozen=True)
class I:
    lo: Q
    hi: Q

    def __post_init__(self):
        assert self.lo <= self.hi

    @staticmethod
    def point(x):
        return I(Q(x), Q(x))

    def __add__(self, other):
        other = other if isinstance(other, I) else I.point(other)
        return I(self.lo + other.lo, self.hi + other.hi)

    __radd__ = __add__

    def __neg__(self):
        return I(-self.hi, -self.lo)

    def __sub__(self, other):
        return self + (-other if isinstance(other, I) else -Q(other))

    def __rsub__(self, other):
        return I.point(other) - self

    def __mul__(self, other):
        other = other if isinstance(other, I) else I.point(other)
        candidates = [a*b for a in (self.lo, self.hi)
                      for b in (other.lo, other.hi)]
        return I(min(candidates), max(candidates))

    __rmul__ = __mul__

    def __truediv__(self, other):
        other = other if isinstance(other, I) else I.point(other)
        assert other.lo > 0 or other.hi < 0
        return self * I(1/other.hi, 1/other.lo)

    def square(self):
        if self.lo <= 0 <= self.hi:
            return I(Q(0), max(self.lo*self.lo, self.hi*self.hi))
        return I(min(self.lo*self.lo, self.hi*self.hi),
                 max(self.lo*self.lo, self.hi*self.hi))


BITS = 168
TERMS = 72


def sqrt_point(q: Q) -> I:
    assert q >= 0
    scale = 1 << BITS
    z = math.isqrt((q.numerator * scale * scale) // q.denominator)
    lo, hi = Q(z, scale), Q(z+1, scale)
    assert lo*lo <= q <= hi*hi
    return I(lo, hi)


def log_unit(q: Q) -> I:
    """log(q) for 1<=q<=2, with the geometric tail bounded exactly."""
    assert 1 <= q <= 2
    y = (q-1)/(q+1)
    y2 = y*y
    power = y
    total = Q(0)
    for j in range(TERMS):
        total += power / (2*j+1)
        power *= y2
    tail = 2*power / ((2*TERMS+1)*(1-y2))
    return I(2*total, 2*total+tail)


LOG_TWO = log_unit(Q(2))


def log_point(q: Q) -> I:
    assert q > 0
    k = 0
    while q < 1:
        q *= 2
        k -= 1
    while q > 2:
        q /= 2
        k += 1
    return log_unit(q) + k*LOG_TWO


def log_interval(i: I) -> I:
    return I(log_point(i.lo).lo, log_point(i.hi).hi)


def endpoint(e: Q) -> I:
    assert 0 < e < Q(1, 2)
    s = sqrt_point(1-2*e)
    a = (1-s)/2
    le = log_point((1-e)/e)
    la = log_interval((1-a)/a)
    return ((1-s*le/la).square()) * ((1-e)/e)


def frac(q: Q) -> str:
    return f"{q.numerator}/{q.denominator}"


def dec(q: Q, digits=25) -> str:
    with localcontext() as c:
        c.prec = digits
        return str(Decimal(q.numerator)/Decimal(q.denominator))


def serialize(i: I) -> dict:
    # Outward rational compression keeps certificates compact. Integer floor
    # and ceiling preserve the exact containment; no floating point is used.
    scale = 10**44
    lo = Q((i.lo.numerator*scale)//i.lo.denominator, scale)
    hi = Q(-((-i.hi.numerator*scale)//i.hi.denominator), scale)
    assert lo <= i.lo <= i.hi <= hi
    assert lo*hi > 0
    return {"lower_rational": frac(lo), "upper_rational": frac(hi),
            "lower_decimal_display": dec(lo),
            "upper_decimal_display": dec(hi)}


def propose(beta: Q | None, digits=14):
    import mpmath as mp
    mp.mp.dps = 90
    target = mp.mpf(1) if beta is None else 1+mp.mpf(beta.denominator)/beta.numerator

    def k_of_t(t):
        u = mp.sqrt(-mp.expm1(-2*t))
        x = mp.atanh(u)
        f = x*u-t
        aa = mp.exp(t/2)*f/t
        cc = (1/(1+mp.exp(-t)))*(t/x)**2
        return 1+cc*(aa*aa-1)

    low, high = mp.mpf(2), mp.mpf(4)
    while k_of_t(high) <= target:
        high *= 2
    for _ in range(280):
        mid = (low+high)/2
        if k_of_t(mid) < target:
            low = mid
        else:
            high = mid
    e = 1/(1+mp.exp((low+high)/2))
    scale = 10**digits
    n = int(mp.floor(e*scale))
    return Q(n, scale), Q(n+1, scale)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    records = []
    betas = [Q(1, 10), Q(1, 4), Q(1, 2), Q(1), Q(2), Q(5), Q(10), None]
    for beta in betas:
        lo, hi = propose(beta)
        target = Q(1) if beta is None else 1+1/beta
        left, right = endpoint(lo)-target, endpoint(hi)-target
        assert left.lo > 0 and right.hi < 0
        records.append({
            'beta': 'infinity' if beta is None else frac(beta),
            'epsilon_bracket': [frac(lo), frac(hi)],
            'epsilon_display': [dec(lo), dec(hi)],
            'K_minus_target_at_left': serialize(left),
            'K_minus_target_at_right': serialize(right),
            'signs_certified': True,
        })
        print(records[-1]['beta'], records[-1]['epsilon_display'], flush=True)

    # Recurrence in the attributed hyperbolic Wilker series proof.
    numerator = lambda n: (9**n-1)//4+6*n-8*n*n
    for n in range(1, 129):
        assert numerator(n+1)-9*numerator(n) == 64*n*(n-1)
    assert numerator(1) == numerator(2) == 0
    assert all(numerator(n) > 0 for n in range(3, 130))

    report = {
        'method': 'Exact rational intervals; binary square-root enclosure; '
                  'atanh logarithm series with explicit positive tail.',
        'square_root_bits': BITS, 'log_series_terms': TERMS,
        'threshold_brackets_certified': len(records),
        'individual_endpoint_signs_certified': 2*len(records),
        'wilker_recurrence_finite_checks': 128,
        'records': records,
        'limits': 'Finite brackets supplement the written global theorem. '
                  'mpmath proposes brackets but no mpmath value is trusted '
                  'in a certified inequality. No Lean code is generated.',
    }
    (args.output/'threshold_certificates.json').write_text(
        json.dumps(report, ensure_ascii=False, indent=2)+'\n', encoding='utf-8')
    rows = ['# Certified phase thresholds', '',
            '| beta | lower epsilon | upper epsilon | endpoint signs |',
            '|---|---:|---:|---|']
    for r in records:
        rows.append(f"| {r['beta']} | {r['epsilon_display'][0]} | "
                    f"{r['epsilon_display'][1]} | +, - (exact rational) |")
    rows += ['', 'The strict region is epsilon below the threshold; the '
             'threshold itself belongs to the equality region.',
             'The continuum and uniqueness assertions are proved in the manuscript.', '']
    (args.output/'threshold_certificates.md').write_text('\n'.join(rows), encoding='utf-8')


if __name__ == '__main__':
    main()

