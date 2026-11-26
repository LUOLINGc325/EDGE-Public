#!/usr/bin/env python3
"""Recompute the stockout curve and the two exact IID sharpness families."""
from __future__ import annotations

from pathlib import Path
import json
import platform
import numpy as np
import scipy
from scipy.optimize import brentq
from scipy.stats import poisson, binom
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]


def poisson_utilization(lam, k):
    j = np.arange(k)
    return 1 - float(np.dot(k - j, poisson.pmf(j, lam))) / k


def poisson_parameter(beta, k):
    high = float(max(2, 2 * k))
    while poisson.sf(k - 1, high) < beta:
        high *= 2
    return brentq(lambda x: poisson.sf(k - 1, x) - beta, 1e-12, high,
                  xtol=5e-14)


def binomial_utilization(n, p, k):
    j = np.arange(k)
    return 1 - float(np.dot(k - j, binom.pmf(j, n, p))) / k


def main():
    (ROOT / "results").mkdir(exist_ok=True)
    (ROOT / "figures").mkdir(exist_ok=True)
    optimal = []
    for k in (1, 2, 3, 5, 10, 20, 50):
        beta = float(poisson.sf(k - 1, k))
        gamma = 1 - float(poisson.pmf(k, k))
        assert abs(gamma - poisson_utilization(k, k)) < 2e-14
        optimal.append({"k": k, "optimal_stockout": beta, "guarantee": gamma})

    sharpness = []
    for k in (1, 2, 5):
        for beta in (0.2, float(poisson.sf(k - 1, k)), 0.9):
            lam = poisson_parameter(beta, k)
            u = poisson_utilization(lam, k)
            a = k / lam * u
            for n in (50, 200, 1000, 5000):
                r = brentq(lambda p: binom.sf(k - 1, n, p) - beta,
                           1e-14, 1 - 1e-14, xtol=5e-16)
                un = binomial_utilization(n, r, k)
                # Exchangeability identity for an applicant's n-1 competitors.
                an_minus_one = k * un / (n * r)
                eps, high_value = n ** -3, float(n ** 4)
                theta = (r - eps) / (1 - eps)
                assert 0 < theta < 1
                high_count_mean = n * eps
                high_capped_mean = sum(binom.sf(j, n, eps) for j in range(k))
                alg = (n * r + n * eps * (high_value - 1)) * an_minus_one
                lp = k + high_count_mean * (high_value - 1)
                opt = k + high_capped_mean * (high_value - 1)
                assert opt <= lp + 1e-8 * max(1, lp)
                assert min(un, alg / opt) >= min(u, a) - 1e-10
                sharpness.append({
                    "k": k, "beta": beta, "lambda": lam, "n": n,
                    "binomial_eligibility": r, "scaled_eligibility": n * r,
                    "calibration_error": abs(float(binom.sf(k - 1, n, r)) - beta),
                    "constant_value_ratio": un, "constant_value_limit": u,
                    "rare_value_ratio_prophet": alg / opt,
                    "rare_value_ratio_lp": alg / lp, "rare_value_limit": a})

    plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 11,
                         "axes.spines.top": False, "axes.spines.right": False})
    fig, ax = plt.subplots(figsize=(8.4, 4.7), constrained_layout=True)
    colors = ["#174a7e", "#007b83", "#b25d20", "#79449d"]
    for k, color in zip((1, 2, 5, 10), colors):
        means = np.unique(np.r_[np.geomspace(0.005, max(20, k * 6), 700), k])
        beta = poisson.sf(k - 1, means)
        u = np.array([poisson_utilization(x, k) for x in means])
        guarantee = np.minimum(u, k / means * u)
        valid = (beta >= 0.002) & (beta <= 0.998)
        ax.plot(beta[valid], guarantee[valid], color=color, lw=2.2, label=f"k = {k}")
        x, y = poisson.sf(k - 1, k), 1 - poisson.pmf(k, k)
        ax.scatter([x], [y], color=color, s=38, zorder=4)
    ax.set(xlim=(0, 1), ylim=(0, 1), xlabel="Target stockout probability  β",
           ylabel="Exact worst-case reward ratio", title="A unique optimal stockout calibration")
    ax.grid(alpha=0.17)
    ax.legend(loc="lower center", ncols=4, frameon=False)
    fig.savefig(ROOT / "figures" / "stockout_curve.png", dpi=220)
    fig.savefig(ROOT / "figures" / "stockout_curve.pdf")
    plt.close(fig)
    output = {"status": "passed", "optimal_calibrations": optimal,
              "sharpness_rows": sharpness,
              "scope": "floating-point reproduction, not proof",
              "environment": {"python": platform.python_version(),
                              "numpy": np.__version__, "scipy": scipy.__version__,
                              "matplotlib": matplotlib.__version__}}
    (ROOT / "results" / "curve_and_sharpness.json").write_text(
        json.dumps(output, indent=2) + "\n")
    print(json.dumps({"status": "passed", "sharpness_rows": len(sharpness),
                      "optimal_calibrations": optimal}, indent=2))


if __name__ == "__main__":
    main()
