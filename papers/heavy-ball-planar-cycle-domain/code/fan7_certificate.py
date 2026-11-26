#!/usr/bin/env python3
"""Independent rational/algebraic certificate for the published FAN7 tuning.

No code is imported or copied from hb1d-cycles. The tuning is attributed to
AbdulazizHGA/hb1d-cycles, commit 0cfc2ba80119c15303d935ab65a88e9f1bd2d329.
The simpler weights 43/200, 157/200 and this checker are independently chosen.

Every sign verdict uses fractions.Fraction. Fundamental cosines are selected by
an exact cyclotomic identity and Sturm isolation of the largest real root.
The infinite tail uses the analytic bound documented in theory_fan7_sharpness.md.
"""
from fractions import Fraction as F
from math import gcd
from pathlib import Path
import json


def trim(p):
    p = list(map(F, p))
    while len(p) > 1 and p[-1] == 0:
        p.pop()
    return p


def add(p, q):
    out = [F(0)] * max(len(p), len(q))
    for i, x in enumerate(p):
        out[i] += x
    for i, x in enumerate(q):
        out[i] += x
    return trim(out)


def scale(p, a):
    return trim([F(a) * x for x in p])


def mul(p, q):
    out = [F(0)] * (len(p) + len(q) - 1)
    for i, x in enumerate(p):
        for j, y in enumerate(q):
            out[i + j] += x * y
    return trim(out)


def divmod_poly(p, q):
    p, q = trim(p), trim(q)
    assert q != [F(0)]
    out = [F(0)] * max(1, len(p) - len(q) + 1)
    while p != [F(0)] and len(p) >= len(q):
        j, a = len(p) - len(q), p[-1] / q[-1]
        out[j] += a
        for i, b in enumerate(q):
            p[i + j] -= a * b
        p = trim(p)
    return trim(out), p


def evaluate(p, x):
    y = F(0)
    for a in reversed(p):
        y = y * x + a
    return y


def sturm(p):
    seq = [trim(p), trim([i * p[i] for i in range(1, len(p))])]
    while seq[-1] != [F(0)]:
        _, r = divmod_poly(seq[-2], seq[-1])
        if r == [F(0)]:
            break
        seq.append(scale(r, -1))
    return seq


def variations(values):
    signs = [1 if v > 0 else -1 for v in values if v]
    return sum(x != y for x, y in zip(signs, signs[1:]))


def isolate_largest(p, bits=100):
    if len(p) == 2:
        r = -p[0] / p[1]
        return (r, r), {"exact_rational_root": str(r)}
    seq = sturm(p)
    at_infinity = variations([q[-1] for q in seq])
    lo, hi = F(-2), F(2)
    assert evaluate(p, hi) != 0
    assert variations([evaluate(q, hi) for q in seq]) == at_infinity
    for _ in range(bits + 2):
        mid = (lo + hi) / 2
        assert evaluate(p, mid) != 0
        greater = variations([evaluate(q, mid) for q in seq]) - at_infinity
        if greater:
            lo = mid
        else:
            hi = mid
    nlo = variations([evaluate(q, lo) for q in seq]) - at_infinity
    nhi = variations([evaluate(q, hi) for q in seq]) - at_infinity
    assert nlo == 1 and nhi == 0 and hi - lo <= F(1, 2**bits)
    return (lo, hi), {"roots_above_lower": nlo, "roots_above_upper": nhi}


def iv(a):
    return (F(a), F(a))


def iadd(a, b):
    return (a[0] + b[0], a[1] + b[1])


def ineg(a):
    return (-a[1], -a[0])


def isub(a, b):
    return iadd(a, ineg(b))


def imul(a, b):
    vals = [x * y for x in a for y in b]
    return (min(vals), max(vals))


def iscale(a, r):
    return imul(a, iv(r))


def isquare(a):
    if a[0] <= 0 <= a[1]:
        return (F(0), max(a[0] ** 2, a[1] ** 2))
    return (min(a[0] ** 2, a[1] ** 2), max(a[0] ** 2, a[1] ** 2))


def ieval(p, x):
    y = iv(0)
    for a in reversed(p):
        y = iadd(imul(y, x), iv(a))
    return y


def outward(a, places=12):
    n = 10**places
    lo = (a[0] * n).numerator // (a[0] * n).denominator
    q = a[1] * n
    hi = -((-q.numerator) // q.denominator)
    assert F(lo, n) <= a[0] <= a[1] <= F(hi, n)
    return {"lower": str(F(lo, n)), "upper": str(F(hi, n))}


def cyclotomic_table(nmax):
    out = {}
    for n in range(1, nmax + 1):
        p = [-1] + [0] * (n - 1) + [1]
        for d in range(1, n):
            if n % d == 0:
                p, remainder = divmod_poly(p, out[d])
                assert remainder == [F(0)]
        assert all(a.denominator == 1 for a in p)
        out[n] = p
    return out


def real_cyclotomic(phi, cheb):
    # z^-d Phi(z) = a_d + sum_j a_(d+j) (z^j+z^-j).
    d = (len(phi) - 1) // 2
    assert len(phi) == 2 * d + 1 and phi == list(reversed(phi))
    q = [phi[d]]
    for j in range(1, d + 1):
        q = add(q, scale(cheb[j], phi[d + j]))
    assert q[-1] == 1
    return q


def main():
    mu, L, gamma, beta = F(1, 100), F(1), F(34, 13), F(312, 665)
    assert 0 < mu < L and -1 < beta < 1 and 0 < gamma * L < 2 * (1 + beta)
    h = (L - mu) * gamma
    u, t, v = (1 + beta) / h, (1 - beta) / h, mu * gamma / h
    cheb = [[F(2)], [F(0), F(1)]]
    for j in range(1, 20):
        cheb.append(add(mul([0, 1], cheb[j]), scale(cheb[j - 1], -1)))
    phi = cyclotomic_table(20)
    roots, root_records = {}, []
    for k in range(3, 21):
        q = real_cyclotomic(phi[k], cheb)
        root, evidence = isolate_largest(q)
        roots[k] = root
        root_records.append({"K": k, "polynomial_ascending": list(map(str, q)),
                             "interval_for_two_cos": list(map(str, root)), **evidence})

    def cosine(k, j):
        j %= k
        j = min(j, k - j)
        return iscale(ieval(cheb[j], roots[k]), F(1, 2))

    def coefficient_A(k, m):
        c = cosine(k, m)
        p = isub(iscale(isub(iv(1), c), u), iv(v))
        return isub(imul(p, isub(iv(1), p)),
                    iscale(isub(iv(1), isquare(c)), t * t))

    def residual(k, m, delta):
        term1 = imul(coefficient_A(k, m), isub(iv(1), cosine(k, m * delta)))
        sine_product_twice = isub(cosine(k, m * (delta - 1)), cosine(k, m * (delta + 1)))
        return isub(term1, iscale(sine_product_twice, t / 2))

    w1, w2 = F(43, 200), F(157, 200)
    mixed = []
    for delta in range(1, 7):
        value = iadd(iscale(residual(7, 1, delta), w1),
                     iscale(residual(7, 2, delta), w2))
        assert value[0] > F(1, 10000)
        mixed.append({"delta": delta, **outward(value)})

    pure = []
    for k in range(3, 21):
        for m in range(1, (k - 1) // 2 + 1):
            if gcd(m, k) != 1:
                continue
            delta = pow(m, -1, k)
            value = residual(k, m, delta)
            assert value[1] < 0, (k, m, value)
            pure.append({"K": k, "m": m, "binding_delta": delta, **outward(value)})

    c_lo, c_hi = 1 - (1 + v) / u, 1 - v / u
    assert -1 < c_lo < c_hi < 1
    sin_min_sq = 1 - max(c_lo * c_lo, c_hi * c_hi)
    max_ratio_sq = 1 / (16 * t * t * sin_min_sq)
    assert max_ratio_sq < F(169, 4)
    # pi < 22/7 and cot(x) >= 1/x - x/2 for 0<x<pi/2.
    # At K>=21, x=pi/K <22/147, hence cot(x)>147/22-11/147>13/2.
    cot_lower = F(147, 22) - F(11, 147)
    assert cot_lower > F(13, 2)
    out = {
        "schema": "independent_fan7_algebraic_certificate_v1",
        "source_tuning": {
            "repository": "AbdulazizHGA/hb1d-cycles",
            "commit": "0cfc2ba80119c15303d935ab65a88e9f1bd2d329",
            "path": "results/fan_tunings.json",
            "name": "FAN7",
            "new_example_claimed": False,
        },
        "parameters": {"mu": str(mu), "L": str(L), "gamma": str(gamma), "beta": str(beta)},
        "weights": {"m1": str(w1), "m2": str(w2)},
        "normalization": {"h": str(h), "u": str(u), "t": str(t), "v": str(v)},
        "root_certificates": root_records,
        "mixed_residuals": mixed,
        "mixed_uniform_lower_bound": "1/10000",
        "finite_excluded_primitive_modes": pure,
        "infinite_tail": {"first_excluded_K": 21, "p_feasible_cos_interval": [str(c_lo), str(c_hi)],
                          "sin_min_squared": str(sin_min_sq), "max_A_over_q_squared": str(max_ratio_sq),
                          "ratio_strict_upper": "13/2", "cotangent_strict_lower": str(cot_lower),
                          "analytic_ingredients": ["pi < 22/7", "sin x <= x", "cos x >= 1-x^2/2",
                                                   "cot decreases on (0,pi/2)"]},
        "verified": True,
        "claims_not_verified": ["No two-dimensional cycle at this tuning", "Entire research target",
                                "Lean kernel certification"],
    }
    target = Path(__file__).with_name("fan7_certificate.json")
    target.write_text(json.dumps(out, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"verified": True, "mixed_slacks": len(mixed),
                      "finite_pure_modes_excluded": len(pure), "tail_starts_at": 21,
                      "mixed_margin_lower": "1/10000", "certificate": str(target)}, indent=2))


if __name__ == "__main__":
    main()
