#!/usr/bin/env python3
"""Plot the manuscript's binary asymptotic rate; numerical illustration only."""
from __future__ import annotations

import argparse
import json
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

from phase_diagram import rate


ROOT = Path(__file__).resolve().parents[1]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=ROOT / "results/phase_diagram.svg")
    parser.add_argument("--data", type=Path, default=ROOT / "results/phase_plot_data.json")
    parser.add_argument("--preview", type=Path, help="Optional PNG for visual inspection.")
    args = parser.parse_args()
    p, q, epsilon = [0.1, 0.9], [0.7, 0.3], 0.5
    endpoint = rate(p, q, epsilon, 0.0)
    saturated = rate(p, q, epsilon, float("inf"))
    threshold = saturated["saturation_rho"]
    rhos = np.unique(np.r_[np.linspace(0, 0.4, 241), threshold])
    values = [rate(p, q, epsilon, float(rho))["rate"] for rho in rhos]

    plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 11, "svg.fonttype": "none"})
    fig, ax = plt.subplots(figsize=(8.4, 5.0))
    fig.subplots_adjust(left=0.12, right=0.97, top=0.80, bottom=0.20)
    fig.text(0.12, 0.94, "Approximate-DP e-power rate", fontsize=17, weight="bold", color="#14374f")
    fig.text(0.12, 0.885, r"$P=\mathrm{Bernoulli}(0.1)$, $Q=\mathrm{Bernoulli}(0.7)$, $\varepsilon=0.5$",
             fontsize=12, color="#435866")
    ax.axvspan(0, threshold, color="#e7f0f5", zorder=0)
    ax.plot(rhos, values, color="#14648a", linewidth=2.6, zorder=3)
    ax.axhline(saturated["rate"], color="#788997", linewidth=1.0, linestyle=(0, (4, 3)))
    ax.axvline(threshold, color="#647784", linewidth=1.0, linestyle=(0, (3, 3)))
    ax.scatter([0, threshold], [endpoint["rate"], saturated["rate"]], s=34,
               color="#14648a", edgecolor="white", linewidth=0.7, zorder=4)
    ax.annotate(f"Nonprivate rate\n{endpoint['rate']:.6f}", xy=(0, endpoint["rate"]),
                xytext=(0.045, 0.99), fontsize=10, color="#27485a",
                arrowprops={"arrowstyle": "-", "color": "#8aa5b5"})
    ax.annotate(r"$\rho_{\rm sat}$" + f" = {threshold:.6f}",
                xy=(threshold, saturated["rate"]), xytext=(0.19, 0.51),
                fontsize=10, color="#27485a",
                arrowprops={"arrowstyle": "-", "color": "#8aa5b5"})
    ax.text(0.323, saturated["rate"] + 0.047, "Pure-DP plateau", ha="center", fontsize=10, color="#435866")
    ax.text(0.095, 0.39, "Active TV constraint", ha="center", fontsize=10, color="#435866")
    ax.set_xlim(-0.006, 0.4)
    ax.set_ylim(0.23, 1.10)
    ax.set_xlabel(r"Privacy-failure exponent $\rho=\lim -\log(\delta_n)/n$", labelpad=11)
    ax.set_ylabel(r"Optimal limiting e-power $J_\varepsilon(\rho)$", labelpad=10)
    ax.spines[["top", "right"]].set_visible(False)
    ax.spines[["bottom", "left"]].set_color("#aab9c4")
    ax.tick_params(colors="#526472")
    ax.grid(axis="y", color="#e3e9ed", linewidth=0.6)
    ax.set_axisbelow(True)
    fig.text(0.12, 0.043, "Numerical evaluation of the proved asymptotic formula; units: nats per observation.",
             fontsize=9, color="#5f707b")
    args.output.parent.mkdir(parents=True, exist_ok=True)
    fig.savefig(args.output, metadata={"Date": None, "Description": "Asymptotic formula illustration, not a finite-sample certificate."})
    if args.preview:
        args.preview.parent.mkdir(parents=True, exist_ok=True)
        fig.savefig(args.preview, dpi=160)
    plt.close(fig)
    report = {"kind": "numerical_illustration_not_proof", "P": p, "Q": q, "epsilon": epsilon,
              "saturation_rho": threshold, "nonprivate_rate": endpoint["rate"],
              "pure_dp_rate": saturated["rate"],
              "curve": [{"rho": float(x), "rate": y} for x, y in zip(rhos, values)]}
    args.data.parent.mkdir(parents=True, exist_ok=True)
    args.data.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(args.output), "data": str(args.data),
                      "points": len(values), "saturation_rho": threshold}))


if __name__ == "__main__":
    main()
