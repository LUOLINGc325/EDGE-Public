#!/usr/bin/env python3
"""Symbolic identities and high-precision checks for the written theorem.

These checks are reproducible evidence, not a proof of all real parameters.
Run from any working directory. No network access is used.
"""
from __future__ import annotations

import argparse
import json
import platform
from pathlib import Path

import mpmath as mp
import sympy as sp

ROOT = Path(__file__).resolve().parents[1]


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def symbolic_checks():
    x, y, z, c, v = sp.symbols("x y z c v", real=True)
    q = sp.Matrix([[-x-z, x+c, z-c],
                   [x-c, -x-y, y+c],
                   [z+c, y-c, -y-z]])
    s = x + y + z
    d = x*x+y*y+z*z-x*y-y*z-z*x
    poly = v*((v+s)**2-d+3*c*c)
    require(sp.expand((v*sp.eye(3)-q).det()-poly) == 0,
            "Characteristic polynomial identity failed")
    require(q*sp.ones(3, 1) == sp.zeros(3, 1), "Row sums")
    require(sp.ones(1, 3)*q == sp.zeros(1, 3), "Column sums")
    u, w, h, C, a = sp.symbols("u w h C a", positive=True)
    ds = sp.expand(d.subs({x:u/3-2*h, y:u/3+h, z:u/3+h}))
    require(sp.simplify(ds-9*h*h) == 0, "Curve discriminant")
    f = sp.log((a+C)/(a-C))
    require(sp.simplify(sp.diff(f, a, 2)-4*C*a/(a*a-C*C)**2) == 0,
            "Convexity identity")
    b = 2*C*sp.log((u+3*C)/(u-3*C))
    deriv = 2*sp.log((u+3*C)/(u-3*C))+12*u*C/(u*u-9*C*C)
    require(sp.simplify(sp.diff(b, C)-deriv) == 0, "Monotone bound")
    hstar = 2*u/3-sp.sqrt(u*u+w*w)/sp.sqrt(3)
    require(sp.simplify((u/3-2*hstar)**2-(w*w/3+3*hstar*hstar)) == 0,
            "Boundary equation")
    require(sp.simplify(sp.trace(q)+2*s) == 0, "Trace/activity identity")
    return {
        "count": 8,
        "checks": [
            "characteristic polynomial",
            "row sums", "column sums",
            "curve discriminant", "strict convexity derivative",
            "monotone lower-envelope derivative",
            "endpoint equation", "trace/activity identity"
        ],
        "all_exact_identities_verified": True
    }


def matrix(x, y, z, c):
    return mp.matrix([[-x-z, x+c, z-c],
                      [x-c, -x-y, y+c],
                      [z+c, y-c, -y-z]])


def entropy_direct(q):
    # Direct pairwise stationary flux formula, uniform stationary law.
    ans = mp.mpf("0")
    for i in range(3):
        for j in range(i+1, 3):
            a, b = q[i, j]/3, q[j, i]/3
            require(a > 0 and b > 0, "Nonpositive off-diagonal rate")
            ans += (a-b)*mp.log(a/b)
    return ans


def gap(u, w):
    return 2*w/mp.sqrt(3)*mp.log((u+mp.sqrt(3)*w)/(u-mp.sqrt(3)*w))


def curve(u, w, fraction):
    hstar = 2*u/3-mp.sqrt(u*u+w*w)/mp.sqrt(3)
    h = hstar*fraction
    c = mp.sqrt(w*w/3+3*h*h)
    return matrix(u/3-2*h, u/3+h, u/3+h, c), hstar


def high_precision_checks():
    mp.mp.dps = 90
    fractions = [mp.mpf("0"), mp.mpf("0.1"), mp.mpf("0.5"),
                 mp.mpf("0.9"), mp.mpf("0.99"), mp.mpf("0.9999"),
                 1-mp.mpf("1e-12"), 1-mp.mpf("1e-30")]
    max_exponential_error = mp.mpf(0)
    max_activity_error = mp.mpf(0)
    max_minimizer_error = mp.mpf(0)
    count = 0
    for sign in (1, -1):
        for branch in range(1, 4):
            for t in (mp.mpf("0.25"), mp.mpf("1"), mp.mpf("3")):
                w = (2*branch if sign == 1 else 2*branch-1)*mp.pi/t
                for ratio in (mp.mpf("1.0001"), mp.mpf("1.1"),
                              mp.mpf("2"), mp.mpf("5")):
                    u = ratio*mp.sqrt(3)*w
                    lam = sign*mp.exp(-u*t)
                    p = mp.eye(3)*lam + mp.ones(3, 3)*(1-lam)/3
                    previous = None
                    for f in fractions:
                        q, _ = curve(u, w, f)
                        ep = entropy_direct(q)
                        error = max(abs(v) for v in mp.expm(t*q)-p)
                        activity = -sum(q[i, i] for i in range(3))/3
                        max_exponential_error = max(max_exponential_error, error)
                        max_activity_error = max(max_activity_error, abs(activity-2*u/3))
                        require(error < mp.mpf("1e-65"), "Matrix exponential mismatch")
                        require(ep+mp.mpf("1e-65") >= gap(u, w), "Lower bound violated")
                        if previous is not None:
                            require(ep > previous, "Curve entropy is not increasing")
                        else:
                            max_minimizer_error = max(max_minimizer_error, abs(ep-gap(u,w)))
                        previous = ep
                        count += 1
    return {
        "precision_decimal_digits": mp.mp.dps,
        "curve_matrices_checked": count,
        "signs": 2,
        "branches_per_sign": 3,
        "sampling_intervals": ["0.25", "1", "3"],
        "u_over_sqrt3omega": ["1.0001", "1.1", "2", "5"],
        "distance_to_boundary_smallest_fraction": "1e-30",
        "max_exponential_entry_error": mp.nstr(max_exponential_error, 12),
        "max_activity_error": mp.nstr(max_activity_error, 12),
        "max_minimizer_error": mp.nstr(max_minimizer_error, 12),
        "all_checks_passed": True
    }


def numerical_examples():
    mp.mp.dps = 90
    cases = []
    for sign, u, w in [(1, mp.mpf(12), 2*mp.pi), (-1, mp.mpf(6), mp.pi)]:
        rows = []
        for f in [mp.mpf("0"), mp.mpf("0.5"), mp.mpf("0.99"),
                  1-mp.mpf("1e-12")]:
            q, ds = curve(u, w, f)
            rows.append({
                "delta_fraction": mp.nstr(f, 20),
                "entropy_rate": mp.nstr(entropy_direct(q), 25),
                "minimum_off_diagonal_rate": mp.nstr(
                    min(q[i,j] for i in range(3) for j in range(3) if i != j), 25),
                "generator": [[mp.nstr(q[i,j], 25) for j in range(3)] for i in range(3)]
            })
        cases.append({
            "t": "1", "sign": sign, "u": str(u), "omega": mp.nstr(w, 25),
            "lambda": mp.nstr(sign*mp.exp(-u), 25),
            "entropy_gap": mp.nstr(gap(u, w), 25),
            "activity": mp.nstr(2*u/3, 25),
            "delta_star": mp.nstr(ds, 25), "examples": rows
        })
    return cases


def main():
    p = argparse.ArgumentParser()
    p.add_argument("--output", type=Path, default=ROOT/"results"/"primary_verification.json")
    args = p.parse_args()
    result = {
        "method": "exact symbolic identities plus direct high-precision matrix exponentials",
        "proof_status": "computational evidence only; general theorem is proved in manuscripts",
        "environment": {"python": platform.python_version(), "sympy": sp.__version__,
                        "mpmath": mp.__version__},
        "symbolic": symbolic_checks(),
        "high_precision": high_precision_checks(),
        "examples": numerical_examples()
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, ensure_ascii=False)+"\n")
    print(json.dumps({"output": str(args.output), "symbolic": result["symbolic"],
                      "high_precision": result["high_precision"]}, indent=2))


if __name__ == "__main__":
    main()
