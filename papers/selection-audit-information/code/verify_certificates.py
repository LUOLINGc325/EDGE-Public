#!/usr/bin/env python3
"""Check finite-instance primal/dual bounds using rational interval arithmetic.

Only the Python standard library is required. This program does not prove the
asymptotic theorem. It bounds the exact finite-a convex problem, including the
one-sided composite null and alternative, at the instances in the certificate.
Log scores are rational. The implemented factors are exp(score)/normalizer;
exponentially small factors are never replaced by zero in the definition.
"""
from fractions import Fraction as F
from itertools import combinations
from functools import lru_cache
from pathlib import Path
import argparse
import json
import sys

if hasattr(sys, "set_int_max_str_digits"):
    sys.set_int_max_str_digits(0)
DEN = 10**75


def down(x):
    return F((x.numerator * DEN) // x.denominator, DEN)


def up(x):
    return F(-((-x.numerator * DEN) // x.denominator), DEN)


@lru_cache(None)
def exp_bounds(x):
    """Rational enclosure: Taylor series plus a geometric remainder."""
    x = F(x)
    if x < -256:
        # exp(-256) < 2**(-256), since e > 2. A zero interval lower
        # endpoint is not a zero factor: the factor remains exp(x)>0.
        return F(0), F(1, 2**256)
    if x < 0:
        lo, hi = exp_bounds(-x)
        return down(1 / hi), up(1 / lo)
    k = 0
    y = x
    while y > F(1, 2):
        k += 1
        y /= 2
    term = F(1)
    total = F(1)
    n = 72
    for j in range(1, n + 1):
        term *= y / j
        total += term
    nxt = term * y / (n + 1)
    tail = nxt / (1 - y / (n + 2))
    lo, hi = down(total), up(total + tail)
    for _ in range(k):
        lo, hi = down(lo * lo), up(hi * hi)
    return lo, hi


@lru_cache(None)
def log_bounds(x):
    """Rational enclosure from log(y)=2 sum z**(2j+1)/(2j+1)."""
    x = F(x)
    if x <= 0:
        raise ValueError("log requires a positive rational")
    if x == 1:
        return F(0), F(0)
    y, k = x, 0
    while y >= 2:
        y /= 2
        k += 1
    while y < 1:
        y *= 2
        k -= 1
    z = (y - 1) / (y + 1)
    zz, term, total = z * z, z, F(0)
    n = 82
    for j in range(n):
        total += 2 * term / (2 * j + 1)
        term *= zz
    tail = 2 * term / ((2 * n + 1) * (1 - zz))
    lo, hi = total, total + tail
    if k:
        l2, u2 = log_bounds(F(2)) if x != 2 else _log_two()
        if k > 0:
            lo, hi = lo + k * l2, hi + k * u2
        else:
            lo, hi = lo + k * u2, hi + k * l2
    return down(lo), up(hi)


@lru_cache(None)
def _log_two():
    z, total, term = F(1, 3), F(0), F(1, 3)
    for j in range(82):
        total += 2 * term / (2 * j + 1)
        term /= 9
    tail = 2 * term / (165 * (1 - z * z))
    return down(total), up(total + tail)


def solve3(rows, rhs):
    a = [[F(v) for v in row] + [F(b)] for row, b in zip(rows, rhs)]
    for col in range(3):
        pivot = next((j for j in range(col, 3) if a[j][col]), None)
        if pivot is None:
            return None
        a[col], a[pivot] = a[pivot], a[col]
        div = a[col][col]
        a[col] = [x / div for x in a[col]]
        for j in range(3):
            if j != col:
                div = a[j][col]
                a[j] = [x - div * y for x, y in zip(a[j], a[col])]
    return tuple(row[3] for row in a)


def parameter_vertices(theta_lo, theta_hi, rho):
    """All vertices of (theta,h1,h0) satisfying the seven constraints."""
    rows = [(-1, 0, 0), (1, 0, 0), (0, -1, 0), (0, 0, -1),
            (-1, 1, 0), (1, 0, 1), (0, 1, 1)]
    rhs = [-theta_lo, theta_hi, 0, 0, 0, 1, rho]
    vertices = set()
    for ix in combinations(range(7), 3):
        v = solve3([rows[i] for i in ix], [rhs[i] for i in ix])
        if v is not None and all(sum(F(c) * x for c, x in zip(row, v)) <= b
                                 for row, b in zip(rows, rhs)):
            vertices.add(v)
    return sorted(vertices)


def law(theta, h1, h0, a):
    return (theta - h1, 1 - theta - h0, a * h1, a * h0,
            (1 - a) * (h1 + h0))


def dot(x, y):
    return sum((u * v for u, v in zip(x, y)), F(0))


def kl_bounds(q, p):
    lo = hi = F(0)
    for v, u in zip(q, p):
        if not v:
            continue
        if u <= 0:
            raise ValueError("primal KL is infinite")
        l, h = log_bounds(v / u)
        lo += v * l
        hi += v * h
    return down(lo), up(hi)


def decimal(x, places=24, direction=None):
    # Directed decimal division preserves the interval in exported JSON.
    # No subsequent formatting step rounds the value a second time.
    from decimal import Decimal, localcontext, ROUND_FLOOR, ROUND_CEILING
    with localcontext() as ctx:
        ctx.prec = places
        if direction == 'lower':
            ctx.rounding = ROUND_FLOOR
        elif direction == 'upper':
            ctx.rounding = ROUND_CEILING
        return format(Decimal(x.numerator) / Decimal(x.denominator), 'g')


def verify(case):
    p, q, rho, a = [F(case[k]) for k in ('p', 'q', 'rho', 'a')]
    if not (0 < p < q < 1 and 0 < rho < min(q, 1-p) and 0 < a < 1):
        raise ValueError("out-of-scope parameter")
    hp = tuple(map(F, case['null_hidden']))
    hq = tuple(map(F, case['alternative_hidden']))
    for t, h in [(p, hp), (q, hq)]:
        if not (0 <= h[0] <= t and 0 <= h[1] <= 1-t and sum(h) <= rho):
            raise ValueError("infeasible primal mechanism")
    P, Q = law(p, *hp, a), law(q, *hq, a)
    primal_lo, primal_hi = kl_bounds(Q, P)
    z = tuple(map(F, case['log_scores']))
    if len(z) != 5:
        raise ValueError("expected five log scores")
    exp_upper = [exp_bounds(v)[1] for v in z]
    null = [law(*v, a) for v in parameter_vertices(F(0), p, rho)]
    alt = [law(*v, a) for v in parameter_vertices(q, F(1), rho)]
    normalizer = max(F(1), max(dot(v, exp_upper) for v in null))
    log_c_lo, log_c_hi = log_bounds(normalizer)
    lower = min(dot(v, z) for v in alt) - log_c_hi
    if lower > primal_hi:
        raise ArithmeticError("dual lower bound exceeds primal upper bound")
    gap = primal_hi - lower
    if lower <= 0:
        raise ArithmeticError("certificate does not establish positive growth")
    if gap > F('1e-16'):
        raise ArithmeticError(f"primal-dual gap too large: {decimal(gap)}")
    return {
        'p':str(p), 'q':str(q), 'rho':str(rho), 'a':str(a),
        'information_lower':decimal(lower,direction='lower'),
        'information_upper':decimal(primal_hi,direction='upper'),
        'gap_upper':decimal(gap,direction='upper'), 'null_vertices':len(null),
        'alternative_vertices':len(alt),
        'normalizer_upper':decimal(normalizer,direction='upper'),
        'exact_rational_lower':str(lower),
        'exact_rational_upper':str(primal_hi),
        'exact_rational_gap':str(gap),
        'all_composite_null_constraints_certified':True,
        'all_composite_alternative_growth_constraints_certified':True,
        'passed':True,
    }


def main():
    root = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser()
    parser.add_argument('--input', type=Path, default=root/'results'/'certificates.json')
    parser.add_argument('--output', type=Path, default=root/'results'/'verified_bounds.json')
    args = parser.parse_args()
    cases = json.loads(args.input.read_text())['cases']
    checked = [verify(c) for c in cases]
    result = {'method':'exact rational enclosures of exp and log',
              'scope':'finite-a primal/dual bounds; no continuum theorem formalization',
              'case_count':len(checked), 'all_passed':all(c['passed'] for c in checked),
              'cases':checked}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({'case_count':len(checked),'all_passed':result['all_passed'],
                      'largest_gap':max(float(c['gap_upper']) for c in checked)}))


if __name__ == '__main__':
    main()
