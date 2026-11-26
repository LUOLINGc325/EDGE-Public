#!/usr/bin/env python3
"""Exact finite witnesses for the secondary Bernstein-inverse transition bound.

All arithmetic is rational. This checks selected instances of the general
written proof, including the full inverse-row identity and a feasible dual.
It is not a numerical proof of the continuum of parameters in that theorem.
"""
from fractions import Fraction as F
from math import comb
from pathlib import Path
import argparse
import json


def choose(a, b):
    return comb(a, b) if 0 <= b <= a else 0


def inverse_row(M, n, j):
    return [F((-1) ** (j-k) * comb(M, k)
              * comb(M-n+j-k-1, j-k), comb(n, j)) for k in range(j+1)]


def witness(n, t, v=F(1, 2)):
    assert n >= 16 and t >= F(16, n)
    M = 4 * n
    threshold = 2 / t + 1
    j = (threshold.numerator + threshold.denominator - 1) // threshold.denominator
    j += (j + 1) % 2
    assert j % 2 == 1 and threshold <= j < threshold + 2
    assert j <= F(n, 4) + 1
    w = inverse_row(M, n, j)
    # Verify w H = e_j, including every column of the original n-query kernel.
    for ell in range(n+1):
        product = sum((w[k] * F(choose(k, ell) * choose(M-k, n-ell), comb(M, n))
                       for k in range(j+1)), F(0))
        assert product == (1 if ell == j else 0)
    norm = sum(map(abs, w), F(0))
    target_product = sum((w[k] * v / (1 + t*k) for k in range(j+1)), F(0))
    assert norm <= 10 ** j
    assert target_product <= -v
    y = [-z/norm for z in w]
    assert sum(map(abs, y), F(0)) == 1
    # H^T y = -e_j/norm, hence its positive-part penalty is exactly zero.
    dual = -target_product/norm
    assert dual >= v/F(10**j)
    return {"M": M, "n": n, "t": str(t), "v": str(v), "odd_order": j,
            "inverse_row": list(map(str, w)), "l1_norm": str(norm),
            "inverse_target_product": str(target_product),
            "signed_event_dual_support": list(map(str, y)),
            "certified_event_lower_bound": str(dual),
            "coarser_rational_lower_bound": str(v/F(10**j)),
            "status": "exact_dual_feasibility_and_negative_inverse_coefficient"}


def polynomial_checks():
    checks = 0
    for n in (16, 17, 32, 64):
        upto = n // 4 + 1
        for u in [F(k, 32) for k in range(33)]:
            values = [sum((w*u**k for k, w in enumerate(inverse_row(4*n, n, j))), F(0))
                      for j in range(upto+1)]
            for j in range(upto):
                left = (n-j)*values[j+1]
                right = (n*(4*u-3)-j*(1+u))*values[j]
                if j:
                    right += u*j*values[j-1]
                assert left == right
                checks += 1
            for j, value in enumerate(values):
                if u <= F(3, 4):
                    assert (-1)**j * value >= 0
                if u <= F(1, 4):
                    assert (-1)**j * value >= 2**j
                if u >= F(3, 4):
                    assert abs(value) <= 1
    return checks


def main():
    root = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path,
                        default=root / "results/bernstein_transition_certificates.json")
    args = parser.parse_args()
    cases = [witness(n, F(16*multiplier, n))
             for n in (16, 17, 24, 32, 48, 64, 96, 128)
             for multiplier in (1, 2, 4, 8, 16)]
    checked = polynomial_checks()
    result = {"status": "passed", "arithmetic": "exact fractions.Fraction",
              "dual_certificates": len(cases), "recurrence_grid_checks": checked,
              "scope": "Finite diagnostic and dual witnesses; universal claims rest on the written proof.",
              "cases": cases}
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({k:v for k,v in result.items() if k != "cases"}))


if __name__ == "__main__":
    main()
