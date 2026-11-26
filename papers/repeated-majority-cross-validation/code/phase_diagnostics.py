"""Numerical diagnostics for the proved asymptotic; not a proof certificate.

Evaluate the complete-average risk by an exact finite hypergeometric formula,
using SciPy floating point. The total-count sum is truncated outside twelve
standard deviations, so the reported numbers are diagnostic approximations.
No random simulation and no formal proof assistant are used.
"""

from __future__ import annotations

import argparse
import json
import math
from pathlib import Path

import numpy as np
from scipy.stats import binom, hypergeom


def complete_risk(k: int, m: int, mu: float) -> dict:
    n = k * m
    if not (k >= 2 and m >= 1 and abs(mu) < 1):
        raise ValueError("invalid model parameters")
    p = (1 + mu) / 2
    sd = math.sqrt(n * p * (1 - p))
    lo = max(0, math.floor(n * p - 12 * sd - 3))
    hi = min(n, math.ceil(n * p + 12 * sd + 3))
    # Always include the decision-boundary strip; it carries the small second
    # term even when the mean is displaced. Its Gaussian tails are tiny beyond
    # twelve fold standard deviations in the requested diagnostics.
    boundary = math.ceil(12 * math.sqrt(m) + 3)
    lo = min(lo, max(0, (n - boundary) // 2))
    hi = max(hi, min(n, (n + boundary + 1) // 2))
    count = np.arange(lo, hi + 1, dtype=np.int64)
    s = 2 * count - n
    eps = (n - m) % 2
    r = (m + s + eps) // 2
    boundary_mass = hypergeom.pmf(r, n, count, m)
    tau = np.where(s > 0, hypergeom.sf(r - 1, n, count, m),
                   hypergeom.cdf(r - 1, n, count, m))
    g = np.abs(s) / n * tau + ((m + s + eps) * (n - m + eps)
                              / (2.0 * m * n)) * boundary_mass
    sigma = np.where(s > 0, 1.0, -1.0)
    baseline_error = -0.5 * sigma * (s / n - mu)
    mass = binom.pmf(count, n, p)
    risk = float(np.dot(mass, (baseline_error + g) ** 2))
    peak_second = float(np.dot(mass, g ** 2))
    cross = float(np.dot(mass, 2 * baseline_error * g))
    a_term = math.exp(-n * mu * mu / 2) / (2 * math.sqrt(2) * math.pi * math.sqrt(n * m))
    prediction = 1 / (4 * n) + a_term
    return {
        "n": n, "k": k, "m": m, "mu": mu,
        "n_mu_squared_minus_log_k": n * mu * mu - math.log(k),
        "complete_mse_numeric": risk,
        "asymptotic_prediction": prediction,
        "risk_to_prediction": risk / prediction,
        "peak_second_to_A": peak_second / a_term,
        "twice_cross_term": cross,
        "n_times_mse": n * risk,
        "critical_limit": 0.25 + math.exp(-(n * mu * mu - math.log(k)) / 2) / (2 * math.sqrt(2) * math.pi),
        "included_mass": float(mass.sum()),
        "count_range": [int(lo), int(hi)],
        "precision": "IEEE binary64; SciPy binomial/hypergeometric functions",
    }


def run() -> dict:
    rows = []
    for k, m in [(20, 25), (80, 51), (320, 101), (1280, 201), (5120, 401)]:
        for a in [-2.0, 0.0, 2.0]:
            mu = math.sqrt((math.log(k) + a) / (k * m))
            rows.append(complete_risk(k, m, mu))
            rows.append(complete_risk(k, m, -mu))
        rows.append(complete_risk(k, m, 0.0))
    # Slow fold growth: these finite data do not prove the absence of an
    # m-versus-log(k) rate restriction, which is established in the manuscript.
    for k, m in [(128, 4), (1024, 6), (8192, 8), (65536, 10)]:
        mu = math.sqrt(math.log(k) / (k * m))
        rows.append(complete_risk(k, m, mu))
    return {
        "kind": "floating_point_asymptotic_diagnostic",
        "scope": "finite complete-average MSE only; not a universal proof or exact interval certificate",
        "rows": rows,
        "case_count": len(rows),
        "all_finite": all(math.isfinite(x["complete_mse_numeric"]) for x in rows),
        "minimum_included_mass": min(x["included_mass"] for x in rows),
        "interpretation": "Convergence is supported by these finite diagnostics; rigorous uniformity and constants are proved analytically.",
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    report = run()
    text = json.dumps(report, ensure_ascii=False, indent=2, allow_nan=False) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(text, encoding="utf-8")
    else:
        print(text, end="")
