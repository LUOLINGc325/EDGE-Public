#!/usr/bin/env python3
"""Finite floating-point checks of OU posterior structure, not proof evidence.

The mathematical derivation uses H1 weak equations and truncation. This script
uses dense covariance matrices and independent eigendecompositions. It checks
72 deterministic cases, including repeated points and both query endpoints,
plus 16 balanced-replication covariance lower-bound cases.
"""

from __future__ import annotations

import json
from pathlib import Path

import numpy as np


def kernel(x: np.ndarray, y: np.ndarray) -> np.ndarray:
    return np.exp(-np.abs(x[:, None] - y[None, :]))


def check_case(points: np.ndarray, query: float, lam: float) -> dict:
    grid = np.unique(np.r_[np.linspace(0.0, 1.0, 1201), points, query])
    cross_query = np.exp(-np.abs(grid - query))
    n = len(points)
    if n:
        gram = kernel(points, points)
        system = gram + lam * lam * np.eye(n)
        vector = np.exp(-np.abs(points - query))
        z = np.linalg.solve(system, vector)
        h = cross_query - z @ kernel(points, grid)
        h_obs = vector - gram @ z
        sigma2 = float(1.0 - vector @ z)
        condition = float(np.linalg.cond(system))
    else:
        z = np.empty(0)
        h_obs = np.empty(0)
        h = cross_query
        sigma2 = 1.0
        condition = 1.0

    # Absolute tolerances acknowledge covariance-subtraction cancellation.
    tol = float(1e-9 + 32 * np.finfo(float).eps * condition)
    sigma = float(np.sqrt(max(sigma2, 0.0)))
    left = h[grid <= query]
    right = h[grid >= query]
    min_left_increment = float(np.min(np.diff(left), initial=0.0))
    max_right_increment = float(np.max(np.diff(right), initial=0.0))
    min_weight = float(np.min(z, initial=0.0))
    weight_mass = float(np.sum(z))
    weight_identity_residual = float(
        np.max(np.abs(h_obs - lam * lam * z), initial=0.0)
    )
    empirical_l2_scaled = float(lam * lam * (z @ z) / sigma2)
    max_covariance_excess = float(np.max(h) - sigma2)

    # Check the RKHS modulus on a fixed set of grid-index pairs.
    pair_rng = np.random.default_rng(9103)
    first = pair_rng.integers(0, len(grid), size=180)
    second = pair_rng.integers(0, len(grid), size=180)
    gap = np.abs(grid[first] - grid[second])
    modulus_rhs = sigma * np.sqrt(2 * (1 - np.exp(-gap)))
    modulus_excess = float(
        np.max(np.abs(h[first] - h[second]) - modulus_rhs, initial=0.0)
    )

    checks = {
        "positive_query_variance": sigma2 > 0.0,
        "nonnegative_covariance": float(np.min(h)) >= -tol,
        "nonnegative_weights": min_weight >= -tol,
        "left_nondecreasing": min_left_increment >= -tol,
        "right_nonincreasing": max_right_increment <= tol,
        "peak_at_query": max_covariance_excess <= tol,
        "total_influence_at_most_one": weight_mass <= 1.0 + tol,
        "weight_covariance_identity": weight_identity_residual <= tol,
        "empirical_l2": empirical_l2_scaled <= 1.0 + 10 * tol,
        "rkhs_modulus_sampled_pairs": modulus_excess <= 10 * tol,
    }
    checks = {key: bool(value) for key, value in checks.items()}
    return {
        "n": n,
        "query": query,
        "lambda": lam,
        "condition_number": condition,
        "absolute_tolerance": tol,
        "sigma_squared": sigma2,
        "minimum_covariance_on_grid": float(np.min(h)),
        "minimum_weight": min_weight,
        "weight_mass": weight_mass,
        "left_min_increment": min_left_increment,
        "right_max_increment": max_right_increment,
        "maximum_covariance_excess_over_query": max_covariance_excess,
        "weight_identity_residual": weight_identity_residual,
        "empirical_l2_scaled": empirical_l2_scaled,
        "sampled_modulus_excess": modulus_excess,
        "checks": checks,
        "passed": all(checks.values()),
    }


def check_loewner(m: int, lam: float) -> dict:
    n = m * m + m - 1
    locations = np.linspace(0, 1, m)
    reps = np.full(m, n // m, dtype=int)
    reps[: n % m] += 1
    gram = kernel(locations, locations)
    precision = np.linalg.solve(gram, np.eye(m))
    dsqrt = np.diag(lam / np.sqrt(reps))
    c = np.linalg.solve(np.eye(m) + dsqrt @ precision @ dsqrt, np.eye(m))
    diag_scale = np.diag(1 / np.sqrt(np.diag(c)))
    normalized_covariance = diag_scale @ (c @ c) @ diag_scale / (lam * lam)
    normalized_covariance = (normalized_covariance + normalized_covariance.T) / 2
    least_eigenvalue = float(np.linalg.eigvalsh(normalized_covariance)[0])
    claimed_lower_bound = (1 / (2 * lam * (1 + lam * lam))) ** 2
    precision_norm = float(np.linalg.eigvalsh(precision)[-1])
    tol = 1e-9 * max(1.0, claimed_lower_bound)
    checks = {
        "precision_norm_bound": precision_norm <= 2 * m - 1 + tol,
        "replications_at_least_m": int(np.min(reps)) >= m,
        "covariance_loewner_bound": least_eigenvalue >= claimed_lower_bound - tol,
    }
    checks = {key: bool(value) for key, value in checks.items()}
    return {
        "m": m,
        "n": n,
        "lambda": lam,
        "replications": reps.tolist(),
        "precision_operator_norm": precision_norm,
        "least_noise_covariance_eigenvalue": least_eigenvalue,
        "claimed_lower_bound": claimed_lower_bound,
        "checks": checks,
        "passed": all(checks.values()),
    }


def main() -> None:
    rng = np.random.default_rng(20261125)
    designs = {
        "no_observations": np.array([], dtype=float),
        "one_left_endpoint": np.array([0.0]),
        "one_right_endpoint": np.array([1.0]),
        "ties_at_endpoints_and_query": np.array([0, 0, 0.37, 0.37, 0.37, 1, 1]),
        "small_gaps_and_ties": np.array([0, 0, 0.001, 0.002, 0.37, 0.9, 1, 1]),
        "random_with_endpoints": np.r_[0.0, rng.uniform(size=18), 1.0],
    }
    lambdas = (0.01, 0.2, 1.0, 10.0)
    cases = []
    for name, points in designs.items():
        for lam in lambdas:
            for query in (0.0, 0.37, 1.0):
                result = check_case(points, query, lam)
                result["design"] = name
                result["points"] = points.tolist()
                cases.append(result)
    lower_cases = [check_loewner(m, lam) for m in (2, 4, 8, 16) for lam in lambdas]
    result = {
        "kind": "floating_point_structure_checks_not_a_proof",
        "seed": 20261125,
        "numpy_version": np.__version__,
        "structure_case_count": len(cases),
        "structure_pass_count": sum(case["passed"] for case in cases),
        "loewner_case_count": len(lower_cases),
        "loewner_pass_count": sum(case["passed"] for case in lower_cases),
        "all_passed": all(case["passed"] for case in cases + lower_cases),
        "scope": "Dense covariance calculations; neither exhaustive verification nor formal proof.",
        "structure_cases": cases,
        "loewner_cases": lower_cases,
    }
    target = Path(__file__).resolve().parents[1] / "results" / "green_checks.json"
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({key: value for key, value in result.items() if not key.endswith("cases")}, indent=2))
    if not result["all_passed"]:
        failed = [case for case in cases + lower_cases if not case["passed"]]
        print(json.dumps(failed, indent=2))
        raise SystemExit(1)


if __name__ == "__main__":
    main()

