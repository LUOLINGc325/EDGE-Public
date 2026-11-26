#!/usr/bin/env python3
"""Exact algebraic certificates for the research note.

This checks the pointwise polynomial identity and rational finite-dimensional
instances. It does not formalize Brownian first passage, Tonelli's theorem,
Laplace uniqueness, or the continuum result.
"""
from __future__ import annotations
from fractions import Fraction as Q
from pathlib import Path
import hashlib
import json
import platform
import random
import sympy as sp

ROOT = Path(__file__).resolve().parents[1]


def run():
    fx, fy, gx, gy, kernel = sp.symbols("fx fy gx gy kernel", positive=True)
    lhs = kernel * (gx**2 * fy / fx + gy**2 * fx / fy) / 2
    rhs = kernel * gx * gy + kernel * (gx * fy - gy * fx)**2 / (2 * fx * fy)
    polynomial = sp.expand(2 * fx * fy * (lhs-rhs))
    assert polynomial == 0

    rng = random.Random(20261124)
    checks = []
    for case in range(240):
        n = 2 + case % 7
        f = [Q(rng.randint(1, 30), rng.randint(1, 20)) for _ in range(n)]
        g = [Q(rng.randint(1, 30), rng.randint(1, 20)) for _ in range(n)]
        weights = [Q(rng.randint(1, 12), rng.randint(1, 12)) for _ in range(n)]
        matrix = [[Q(0) for _ in range(n)] for _ in range(n)]
        for i in range(n):
            for j in range(i, n):
                matrix[i][j] = matrix[j][i] = Q(rng.randint(1, 12), rng.randint(1, 12))
        normalization = sum(w*gi*gi for w,gi in zip(weights,g))
        objective = sum(
            weights[i]*weights[j]*g[i]**2*matrix[i][j]*f[j]/f[i]
            for i in range(n) for j in range(n)
        )/normalization
        baseline = sum(
            weights[i]*weights[j]*matrix[i][j]*g[i]*g[j]
            for i in range(n) for j in range(n)
        )/normalization
        gap = sum(
            weights[i]*weights[j]*matrix[i][j]*
            (g[i]*f[j]-g[j]*f[i])**2/(2*f[i]*f[j])
            for i in range(n) for j in range(n)
        )/normalization
        assert objective == baseline+gap
        assert gap >= 0
        proportional = all(f[i]*g[0] == f[0]*g[i] for i in range(n))
        assert (gap == 0) == proportional
        # A separate equality fixture checks the zero gap, not only random
        # strict cases.
        h = [Q(3,7)*gi for gi in g]
        equality_gap = sum(
            weights[i]*weights[j]*matrix[i][j]*
            (g[i]*h[j]-g[j]*h[i])**2/(2*h[i]*h[j])
            for i in range(n) for j in range(n)
        )
        assert equality_gap == 0
        checks.append({"case":case,"dimension":n,"residual":"0","gap_nonnegative":True,
                       "equality_classification_passed":True})

    # Symmetry is essential. A nonnegative but nonsymmetric kernel can fail.
    f = [Q(2),Q(1)]
    g = [Q(1),Q(1)]
    nonsymmetric = [[Q(0),Q(1)],[Q(0),Q(0)]]
    j = sum(g[i]**2*nonsymmetric[i][k]*f[k]/f[i]
            for i in range(2) for k in range(2))
    e = sum(g[i]*nonsymmetric[i][k]*g[k] for i in range(2) for k in range(2))
    assert j == Q(1,2) and e == 1 and j < e

    # Independently integrate the nontrivial exponential-mixture oracle.
    u = sp.symbols("u", nonnegative=True)
    f_mix = (u+u**2)/2
    a_mix = (1-u)/2+(1-u**2)/8
    mixed = sp.integrate(sp.cancel(2*u*a_mix/f_mix), (u,0,1))
    assert sp.simplify(mixed-(4*sp.log(2)-sp.Rational(7,4))) == 0
    deterministic_ratio = sp.simplify(
        (sp.Rational(4,3)*(2**sp.Rational(3,2)-2))/
        (2*(2-sp.sqrt(2)))
    )
    assert sp.simplify(deterministic_ratio-2*sp.sqrt(2)/3) == 0

    result = {
        "schema_version":1,
        "status":"passed",
        "arithmetic":"symbolic rational functions and Python exact Fraction arithmetic",
        "seed":20261124,
        "python":platform.python_version(),
        "sympy":sp.__version__,
        "script_sha256":hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "pointwise_identity_cleared_polynomial":str(polynomial),
        "rational_cases":checks,
        "rational_case_count":len(checks),
        "nonsymmetric_counterexample":{
            "matrix":[[0,1],[0,0]],"f":[2,1],"g":[1,1],
            "unnormalized_objective":"1/2","baseline":"1",
            "claim":"Nonnegative entries alone do not imply the bound."
        },
        "exact_examples":{
            "mixed_exponential_objective":str(mixed),
            "deterministic_reference_objective_per_tau":str(deterministic_ratio)
        },
        "scope":"Algebra and finite weighted sums only; no continuum or Lean certification."
    }
    out=ROOT/"results"/"exact_certificate.json"
    out.write_text(json.dumps(result,ensure_ascii=False,indent=2)+"\n")
    print(json.dumps({"status":"passed","rational_cases":len(checks),
                      "pointwise_residual":str(polynomial),
                      "output":str(out.relative_to(ROOT))}))


if __name__=="__main__":
    run()
