#!/usr/bin/env python3
"""Compute the proved finite-alphabet rate; numerical calculations are not proofs.

Two scalar bisections implement the clipped-likelihood characterization. An
independent epigraph-constrained SLSQP calculation checks selected instances.
"""
from __future__ import annotations

import argparse
import json
import math
from pathlib import Path

import numpy as np


def probabilities(p, q):
    p, q = np.asarray(p, dtype=float), np.asarray(q, dtype=float)
    if p.ndim != 1 or q.shape != p.shape or len(p) < 2:
        raise ValueError("P and Q must have the same finite alphabet, of size >= 2")
    if not np.all(np.isfinite(p)) or not np.all(np.isfinite(q)):
        raise ValueError("Probabilities must be finite")
    if np.min(p) <= 0 or np.min(q) <= 0:
        raise ValueError("The theorem and this routine require full support")
    if not np.isclose(p.sum(), 1, rtol=0, atol=1e-12) or not np.isclose(q.sum(), 1, rtol=0, atol=1e-12):
        raise ValueError("Probabilities must sum to one")
    return p, q


def kl(r, p):
    r, p = np.asarray(r), np.asarray(p)
    keep = r > 0
    return float(np.sum(r[keep] * np.log(r[keep] / p[keep])))


def tv(r, q):
    return float(np.abs(np.asarray(r) - q).sum() / 2)


def clipped_minimizer(p, q, beta):
    p, q = probabilities(p, q)
    if not math.isfinite(beta) or beta < 0:
        raise ValueError("beta must be finite and nonnegative")
    if beta == 0:
        return p.copy()
    ratio = q / p
    spread = float(np.log(ratio).max() - np.log(ratio).min())
    if beta >= spread:
        return q.copy()
    multiplier = math.exp(beta)
    lower, upper = float(ratio.min()), float(ratio.max() / multiplier)
    for _ in range(100):
        a = (lower + upper) / 2
        r = p * np.minimum(a * multiplier, np.maximum(a, ratio))
        if r.sum() < 1:
            lower = a
        else:
            upper = a
    a = (lower + upper) / 2
    r = p * np.minimum(a * multiplier, np.maximum(a, ratio))
    # Only a floating-point normalization; the mathematical definition is (G1).
    return r / r.sum()


def rate(p, q, epsilon, rho):
    p, q = probabilities(p, q)
    if epsilon <= 0 or not math.isfinite(epsilon):
        raise ValueError("epsilon must be fixed, finite and positive")
    if rho < 0 or math.isnan(rho):
        raise ValueError("rho must be nonnegative or +infinity")
    ratio = q / p
    spread = float(np.ptp(np.log(ratio)))
    re = clipped_minimizer(p, q, epsilon)
    te = tv(re, q)
    saturation = epsilon * te
    if epsilon >= spread or rho == 0:
        r, beta, branch = q.copy(), max(epsilon, spread), "nonprivate_endpoint"
    elif rho >= saturation:
        r, beta, branch = re, epsilon, "pure_dp_plateau"
    else:
        radius = rho / epsilon
        low, high = epsilon, spread
        for _ in range(90):
            beta = (low + high) / 2
            r = clipped_minimizer(p, q, beta)
            if tv(r, q) > radius:
                low = beta
            else:
                high = beta
        beta = (low + high) / 2
        r = clipped_minimizer(p, q, beta)
        branch = "active_radius"
    return {
        "rate": kl(r, p) + epsilon * tv(r, q),
        "optimizer": r.tolist(),
        "tv_radius_used": tv(r, q),
        "penalty_beta": beta,
        "saturation_rho": saturation,
        "log_likelihood_spread": spread,
        "branch": branch,
    }


def independent_epigraph_value(p, q, epsilon, radius):
    """Convex formulation in (r,t), with t >= abs(r-q); numerical QA only."""
    from scipy.optimize import minimize

    p, q = probabilities(p, q)
    m = len(p)
    if radius == 0:
        return kl(q, p), True

    def objective(x):
        return kl(x[:m], p) + epsilon * np.sum(x[m:]) / 2

    def jac(x):
        return np.r_[np.log(np.maximum(x[:m], 1e-300) / p) + 1, np.full(m, epsilon / 2)]

    constraints = [
        {"type": "eq", "fun": lambda x: np.sum(x[:m]) - 1},
        {"type": "ineq", "fun": lambda x: x[m:] - x[:m] + q},
        {"type": "ineq", "fun": lambda x: x[m:] + x[:m] - q},
        {"type": "ineq", "fun": lambda x: 2 * radius - np.sum(x[m:])},
    ]
    result = minimize(objective, np.r_[q, np.zeros(m)], jac=jac,
                      bounds=[(1e-14, 1)] * m + [(0, 2)] * m,
                      constraints=constraints, method="SLSQP",
                      options={"ftol": 2e-12, "maxiter": 1500})
    feasible = (abs(np.sum(result.x[:m]) - 1) < 1e-7 and
                tv(result.x[:m], q) <= radius + 1e-7)
    return float(result.fun), bool(result.success and feasible)


def checks():
    rng = np.random.default_rng(58244)
    comparisons = []
    for m in (2, 3, 4, 6):
        for _ in range(6):
            p, q = rng.dirichlet(np.ones(m) * 2, size=2)
            epsilon = float(rng.uniform(0.15, 1.4))
            saturation = rate(p, q, epsilon, math.inf)["saturation_rho"]
            for fraction in (0.2, 0.7, 1.3):
                rho = max(saturation * fraction, 1e-6)
                got = rate(p, q, epsilon, rho)
                other, ok = independent_epigraph_value(p, q, epsilon, min(rho / epsilon, 1.0))
                error = abs(got["rate"] - other)
                if not ok or error > 2e-7:
                    raise AssertionError((m, p, q, epsilon, rho, got, other, ok))
                comparisons.append({"m": m, "epsilon": epsilon, "rho": rho,
                                    "absolute_error": error, "optimizer_success": ok})
    example = []
    for rho in (0, 0.02, 0.05, 0.10, 0.20, 0.30, 1.0):
        example.append({"rho": rho, **rate([0.1, 0.9], [0.7, 0.3], 0.5, rho)})
    return {"kind": "numerical_cross_check_not_proof", "seed": 58244,
            "comparisons": comparisons,
            "max_absolute_error": max(x["absolute_error"] for x in comparisons),
            "binary_example": {"p_success": 0.1, "q_success": 0.7, "epsilon": 0.5, "rows": example}}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results/phase_checks.json")
    args = parser.parse_args()
    result = checks()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, allow_nan=False) + "\n")
    print(json.dumps({"checks": len(result["comparisons"]), "max_absolute_error": result["max_absolute_error"], "output": str(args.output)}))


if __name__ == "__main__":
    main()
