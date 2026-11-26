"""Independent numerical stress checks; not a proof of the infinite family."""
import json
import math
from pathlib import Path

import numpy as np
from scipy.special import expit
from scipy.stats import poisson


def pmf(ps, fixed_ones):
    a = np.ones(1)
    for p in ps:
        a = np.convolve(a, [1.0 - p, p])
    return np.pad(a, (fixed_ones, 0))


def calibrate(log_odds, fixed_ones, k):
    target = poisson.sf(k - 1, k)
    left, right = -100.0, 100.0
    for _ in range(72):
        mid = (left + right) / 2
        ps = expit(log_odds + mid)
        a = pmf(ps, fixed_ones)
        if a[k:].sum() < target:
            left = mid
        else:
            right = mid
    ps = expit(log_odds + (left + right) / 2)
    return ps, pmf(ps, fixed_ones), target


def main():
    rng = np.random.default_rng(20261124)
    rows = []
    violations = []
    min_u = min_a = math.inf
    max_boundary_error = 0.0
    for case in range(1200):
        n = int(rng.integers(1, 101))
        k = int(rng.integers(1, n + 1))
        fixed_ones = int(rng.integers(0, k))
        variable = n - fixed_ones
        mode = case % 4
        log_odds = (np.zeros(variable) if mode == 0 else
                    rng.uniform(-8.0, 8.0, variable) if mode == 1 else
                    rng.normal(0.0, 3.0, variable) if mode == 2 else
                    np.linspace(-12.0, 12.0, variable))
        ps, a, target = calibrate(log_odds, fixed_ones, k)
        j = np.arange(len(a))
        cdf_gap = np.cumsum(a) - poisson.cdf(j, k)
        gamma = 1.0 - poisson.pmf(k, k)
        u_gap = float(np.dot(a, np.minimum(j / k, 1.0)) - gamma)
        a_gap = float(np.dot(a, np.minimum(k / (j + 1), 1.0)) - gamma)
        boundary_error = float(abs(a[k:].sum() - target))
        low_violation = float(np.max(cdf_gap[:k], initial=0.0))
        high_violation = float(-np.min(cdf_gap[k - 1:], initial=0.0))
        min_u = min(min_u, u_gap)
        min_a = min(min_a, a_gap)
        max_boundary_error = max(max_boundary_error, boundary_error)
        if max(low_violation, high_violation, -u_gap, -a_gap) > 2e-12:
            violations.append({"case": case, "n": n, "k": k, "fixed_ones": fixed_ones,
                               "low_violation": low_violation, "high_violation": high_violation,
                               "u_gap": u_gap, "a_gap": a_gap})
        if case < 12:
            rows.append({"n": n, "k": k, "fixed_ones": fixed_ones,
                         "u_gap": u_gap, "a_gap": a_gap,
                         "boundary_error": boundary_error})
    report = {"kind": "independent_numerical_stress_check_not_theorem_proof",
              "seed": 20261124, "cases": 1200, "n_range": [1, 100],
              "boundary_probabilities": "fixed Bernoulli ones present; arbitrary zeros may be appended",
              "max_stockout_calibration_error": max_boundary_error,
              "min_utilization_gap": min_u, "min_acceptance_gap": min_a,
              "tolerance": 2e-12, "violations": violations, "sample_cases": rows}
    (Path(__file__).resolve().parents[1] / "results" / "independent_probability.json").write_text(
        json.dumps(report, indent=2) + "\n")
    print(json.dumps({k: v for k, v in report.items() if k != "sample_cases"}, indent=2))
    if violations:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
