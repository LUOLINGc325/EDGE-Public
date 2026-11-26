#!/usr/bin/env python3
"""Exact finite algebra checks for the localized derivative-kernel estimator.

The kernel, its integral, inverse Bernstein coefficients, reproduction, parity,
and derivative identities are evaluated as Fractions. Values involving pi, exp,
binomial probabilities, and variance comparisons are ordinary floating-point
diagnostics, not certified interval bounds and not substitutes for the proof.

Run: python code/localized_upper.py
"""
from __future__ import annotations

from fractions import Fraction as F
import hashlib
import json
import math
from pathlib import Path

import numpy as np
from scipy.stats import binom


def add(a, b, scale=F(1)):
    out = list(a) + [F(0)] * max(0, len(b) - len(a))
    for i, x in enumerate(b):
        out[i] += scale * x
    while len(out) > 1 and out[-1] == 0:
        out.pop()
    return out


def multiply(a, b):
    out = [F(0)] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            out[i + j] += x * y
    return out


def chebyshev(m):
    if m == 0:
        return [F(1)]
    prev, cur = [F(1)], [F(0), F(1)]
    for _ in range(1, m):
        prev, cur = cur, add([F(0)] + [2 * x for x in cur], prev, F(-1))
    return cur


def evaluate(poly, x):
    value = F(0)
    for coef in reversed(poly):
        value = value * x + coef
    return value


def normalized_integral_kernel(m, r):
    assert m >= 1 and m % 2 == 1 and r >= 1
    tm = chebyshev(m)
    assert tm[0] == 0
    # The sign relating T_m and sin(m asin(x)) disappears under the 2r power.
    quotient = [x / m for x in tm[1:]]
    kernel = [F(1)]
    for _ in range(2 * r):
        kernel = multiply(kernel, quotient)
    normalizer = sum(x / (j + 1) for j, x in enumerate(kernel))
    assert normalizer > 0 and kernel[0] == 1
    poly = [F(0)] + [x / ((j + 1) * normalizer) for j, x in enumerate(kernel)]
    assert evaluate(poly, F(1)) == 1
    assert evaluate(poly, F(-1)) == -1
    assert all(x == 0 for j, x in enumerate(poly) if j % 2 == 0)
    return kernel, normalizer, poly


def inverse_bernstein(poly, n):
    """Coefficients of poly(2p-1) in the degree-n Bernstein basis."""
    d = len(poly) - 1
    assert d <= n
    ordinary_p = [
        sum(
            poly[t] * math.comb(t, j) * 2**j * (-1) ** (t - j)
            for t in range(j, d + 1)
        )
        for j in range(d + 1)
    ]
    scaled = [ordinary_p[j] / math.comb(n, j) for j in range(d + 1)]
    return [
        sum(scaled[j] * math.comb(k, j) for j in range(min(k, d) + 1))
        for k in range(n + 1)
    ]


def bernstein_value(coefficients, p):
    n = len(coefficients) - 1
    return sum(
        a * math.comb(n, k) * p**k * (1 - p) ** (n - k)
        for k, a in enumerate(coefficients)
    )


def log_fraction(x):
    assert x > 0
    return math.log(x.numerator) - math.log(x.denominator)


def diagnostic(n, m, r, mesh=800):
    assert 4 * r * m <= n - 1
    kernel, normalizer, poly = normalized_integral_kernel(m, r)
    a = inverse_bernstein(poly, n)
    b = inverse_bernstein(kernel, n - 1)
    assert a[-1] == 1 and a[0] == -1
    assert all(a[n - k] == -a[k] for k in range(n + 1))
    assert all(n * (a[k + 1] - a[k]) == 2 * b[k] / normalizer for k in range(n))
    reproduction = 0
    for z in (F(-3, 4), F(-1, 2), F(0), F(1, 2), F(3, 4)):
        assert bernstein_value(a, (1 + z) / 2) == evaluate(poly, z)
        reproduction += 1

    N = n - 1
    s = 2 * r - 1
    E = 8 * r * r * m * m / N
    log_cprime = math.log(12) + 2 * r * math.log(math.pi) + math.log(1 + 1 / (2 * s))
    derivative_ratios = []
    sign_ratios = []
    for k, value in enumerate(b):
        if not value:
            continue
        x = abs(F(2 * k, N) - 1)
        local_log = min(0.0, -2 * r * math.log(float(m * x))) if x else 0.0
        derivative_ratios.append(log_fraction(abs(value)) - (math.log(3) + E + local_log))
    for k, value in enumerate(a):
        x = F(2 * k, n) - 1
        sign = 1 if x > 0 else (-1 if x < 0 else 0)
        error = abs(value - sign)
        if error:
            sign_ratios.append(
                log_fraction(error) - (log_cprime + E - s * math.log1p(float(m * abs(x))))
            )

    af = np.array([float(x) for x in a])
    radii = np.linspace(0, 1, mesh + 1)
    probabilities = binom.pmf(np.arange(n + 1)[None, :], n, ((1 + radii) / 2)[:, None])
    values = probabilities @ (af * af)
    suffix = np.maximum.accumulate(values[::-1])[::-1]
    betas = [1.0, 2.0] if r == 2 else [4.0]
    variances = []
    for beta in betas:
        increment = np.diff(radii**beta, prepend=0.0)
        variances.append({
            "beta": beta,
            "L": 1.0,
            "grid_robust_variance_lower_approximation": float(increment @ suffix),
            "continuum_upper_certificate": False,
        })
    return {
        "n": n,
        "odd_m": m,
        "r": r,
        "degree_of_kernel": len(kernel) - 1,
        "degree_of_sign_polynomial": len(poly) - 1,
        "normalization_integral_exact": str(normalizer),
        "all_n_derivative_identities_exact": True,
        "endpoint_and_antisymmetry_checks_exact": True,
        "exact_reproduction_checks": reproduction,
        "max_abs_inverse_coefficient_float": float(np.max(np.abs(af))),
        "log_ratio_to_L13_bound_float": max(derivative_ratios),
        "log_ratio_to_L18_bound_float": max(sign_ratios, default=None),
        "variance_diagnostics": variances,
    }


def main():
    cases = [(33, 1, 2), (33, 3, 2), (65, 7, 2), (129, 15, 2),
             (257, 31, 2), (49, 3, 3), (97, 7, 3), (193, 15, 3)]
    rows = []
    for case in cases:
        row = diagnostic(*case)
        rows.append(row)
        print("n=%d, m=%d, r=%d: exact constructor checks passed" % case, flush=True)
    root = Path(__file__).resolve().parents[1]
    payload = {
        "status": "finite_exact_algebra_checks_and_float_diagnostics",
        "scope": "Explicit rational derivative-kernel estimator; not a replacement for its all-parameter analytic proof.",
        "proof_file": "manuscript/localized_upper.md",
        "proof_sha256_at_run": hashlib.sha256((root / "manuscript/localized_upper.md").read_bytes()).hexdigest(),
        "exact_arithmetic": ["polynomial construction", "normalizing integral", "inverse Bernstein coefficients",
                             "derivative coefficient identities", "antisymmetry", "five reproduction points per case"],
        "floating_point_only": ["displayed coefficient values", "pi/exponential bound ratios",
                                "binomial probabilities", "finite-grid variance lower approximations"],
        "certified_interval_arithmetic": False,
        "number_of_cases": len(rows),
        "total_exact_derivative_identities": sum(x["n"] for x in rows),
        "total_exact_reproduction_checks": sum(x["exact_reproduction_checks"] for x in rows),
        "rows": rows,
    }
    output = root / "results/localized_upper.json"
    output.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n")
    print(output)


if __name__ == "__main__":
    main()

