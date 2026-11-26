#!/usr/bin/env python3
"""Exact finite checks accompanying the analytic proof; Python standard library.

The checks do not replace the general minimax or measure-theoretic proof.
Run from the case directory: python3 code/verify_certificates.py
"""
from fractions import Fraction as F
from itertools import combinations, product
from math import comb
import json
from pathlib import Path


def padd(a, b):
    n = max(len(a), len(b))
    return [(a[i] if i < len(a) else F(0)) +
            (b[i] if i < len(b) else F(0)) for i in range(n)]


def pmul(a, b):
    out = [F(0)] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            out[i + j] += x * y
    return out


def pscale(a, c):
    return [c * x for x in a]


def ppow(a, n):
    out = [F(1)]
    for _ in range(n):
        out = pmul(out, a)
    return out


def compose(a, b):
    out = [F(0)]
    for c in reversed(a):
        out = padd(pmul(out, b), [c])
    return out


def trim(a):
    while len(a) > 1 and a[-1] == 0:
        a.pop()
    return a


def assert_poly(a, b):
    assert trim(a) == trim(b), (a, b)


def exact_example():
    # s0=delta=2, q3=1, all other q_t=0.
    s = [F(0), F(1)]
    x = [F(0), F(4), F(-1)]  # boundary x=s(4-s)
    y = ppow(s, 2)
    eps = F(1, 192)
    risk = padd(pscale(x, F(1, 4)), pscale(y, F(1, 12)))
    risk = padd(risk, pscale(pmul(x, padd(y, pscale(x, -1))), -eps))
    risk = padd(risk, pscale(ppow(padd(x, y), 3), eps * eps))
    assert_poly(risk, [F(0), F(1), -F(1, 12), -F(35, 576), F(1, 96)])
    cert = pscale(padd([F(35, 24)], pscale(risk, -1)), F(576))
    assert_poly(cert, [F(840), F(-576), F(48), F(35), F(-6)])
    shifted = compose(cert, [F(3), F(1)])
    assert_poly(shifted, [F(3), F(9), F(39), F(-37), F(-6)])
    # For z in [-3,0], -z^3(37+6z)>=0 and the quadratic
    # 39 z^2+9 z+3 = 39(z+3/26)^2 +129/52.
    assert_poly(
        padd(pscale(ppow([F(3, 26), F(1)], 2), F(39)), [F(129, 52)]),
        [F(3), F(9), F(39)],
    )
    # For z in [0,1], subtract (3+9z-4z^2):
    # z^2*(43-37z-6z^2)=z^2*(1-z)*(43+6z)>=0.
    assert_poly(
        padd(shifted, [F(-3), F(-9), F(4)]),
        pmul([F(0), F(0), F(1)], pmul([F(1), F(-1)], [F(43), F(6)])),
    )
    # These inequalities prove cert>=129/52 for every s in [0,4].
    affine = F(3, 2)
    paper_upper = F(35, 24)
    stronger_upper = paper_upper - F(129, 52 * 576)
    assert affine - paper_upper == F(1, 24)
    assert stronger_upper == F(4839, 3328)
    # Monotonicity in x throughout the original disk, not just on a grid.
    derivative_lower = F(1, 4) - F(16, 192)
    assert derivative_lower == F(1, 6) > 0
    # Fixed-moment Bayes/least-squares lower bound, x=3,y=9.
    assert F(3 * 9, 9 + 3 * 3) == affine
    return {
        "affine_value": str(affine),
        "nonlinear_step": str(eps),
        "uniform_paper_upper": str(paper_upper),
        "certified_gap": str(affine - paper_upper),
        "stronger_polynomial_upper": str(stronger_upper),
        "polynomial_coefficients_low_to_high": list(map(str, cert)),
        "shifted_coefficients_low_to_high": list(map(str, shifted)),
        "continuous_domain_certificate": "Two polynomial factorizations on z in [-3,0] and [0,1]",
    }


def u3(values):
    return sum((a * b * c for a, b, c in combinations(values, 3)), F(0)) / comb(len(values), 3)


def finite_moment_checks():
    laws = [
        [(F(-1), F(1, 4)), (F(1), F(3, 4))],
        [(F(-2), F(1, 3)), (F(1), F(2, 3))],
        [(F(-1), F(1, 4)), (F(1), F(1, 2)), (F(3), F(1, 4))],
    ]
    records = []
    for n in range(3, 8):
        for number, law in enumerate(laws):
            mu = sum(value * prob for value, prob in law)
            y = sum((value - mu) ** 2 * prob for value, prob in law)
            eu, euu, emu = F(0), F(0), F(0)
            for sample in product(law, repeat=n):
                vals = [a for a, _ in sample]
                prob = F(1)
                for _, p in sample:
                    prob *= p
                u = u3(vals)
                eu += prob * u
                euu += prob * u * u
                emu += prob * sum(vals, F(0)) / n * u
            x = mu * mu
            assert eu == mu ** 3
            assert euu == x ** 3 + F(9, n) * x*x*y + F(18, n*(n-1)) * x*y*y + F(6, n*(n-1)*(n-2)) * y**3
            assert emu == x*x + F(3, n)*x*y
            if x > 0 and y > 0:
                a = n*x/(y+n*x)
                assert a*emu - mu*eu == 2*x*x*y/(y+n*x) > 0
            records.append({"n": n, "law": number, "paths": len(law)**n, "result": "exact_pass"})
    return records


def same_moments_large_outliers():
    # Rare huge values do not change the product-statistic risk at fixed moments.
    records = []
    eps = F(1, 192)
    for magnitude in [2, 100, 10**6]:
        m = F(magnitude)
        law = [(1-m, F(2)/(m*m)), (F(1), 1-F(4)/(m*m)), (1+m, F(2)/(m*m))]
        risk = F(0)
        for sample in product(law, repeat=3):
            values = [v for v, _ in sample]
            prob = sample[0][1]*sample[1][1]*sample[2][1]
            f = sum(values, F(0))/6 - eps*values[0]*values[1]*values[2]
            risk += prob*(f-1)**2
        expected = F(7, 12) - 3*eps + 125*eps*eps
        assert risk == expected
        records.append({"magnitude": magnitude, "risk": str(risk), "result": "exact_pass"})
    return records


def main():
    report = {
        "arithmetic": "fractions.Fraction; no floating point used in certificates",
        "scope": "Exact algebra and finite-support cross-checks; general theorem proved in manuscript",
        "example": exact_example(),
        "multilinear_moment_checks": finite_moment_checks(),
        "rare_outlier_checks": same_moments_large_outliers(),
        "result": "PASS",
    }
    target = Path(__file__).resolve().parents[1] / "results/exact_certificate.json"
    target.parent.mkdir(exist_ok=True)
    target.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps(report, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
