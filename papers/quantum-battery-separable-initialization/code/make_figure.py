#!/usr/bin/env python3
"""Plot exact formulas. These figures are illustrations, not independent tests."""
from __future__ import annotations

import csv
import json
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

ROOT = Path(__file__).resolve().parents[1]


def main() -> None:
    figures, results = ROOT / "figures", ROOT / "results"
    figures.mkdir(exist_ok=True)
    results.mkdir(exist_ok=True)
    m = np.arange(1, 65, dtype=int)
    q = m // 2
    a = 1 + 2*q/m
    n = m*(2*m-1)
    sep = 2*np.sqrt(2)*a
    joint = 2*np.sqrt(2)*m
    normalized_sep = 2*n.astype(float)**2*a/m
    normalized_joint = 2*n.astype(float)**2
    with (results / "analytical_curves.csv").open("w", newline="") as stream:
        writer = csv.writer(stream)
        writer.writerow(["m", "M", "battery_spins_N", "a_m", "separable_power", "joint_power",
                         "capacity_fraction", "normalized_separable_power", "normalized_joint_power"])
        for j in range(len(m)):
            writer.writerow([int(m[j]), int(2*m[j]), int(n[j]), float(a[j]), float(sep[j]),
                             float(joint[j]), float(a[j]/m[j]), float(normalized_sep[j]),
                             float(normalized_joint[j])])
    plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 10,
                         "axes.spines.top": False, "axes.spines.right": False,
                         "axes.titleweight": "bold", "pdf.fonttype": 42})
    fig, axs = plt.subplots(2, 1, figsize=(7.0, 7.5), constrained_layout=True)
    colors = {"sep": "#147D92", "joint": "#CB663B"}
    axs[0].plot(m, joint, color=colors["joint"], lw=2.1, label="Unrestricted joint initialization")
    axs[0].plot(m, sep, color=colors["sep"], lw=2.1, label="Separable initialization (exact)")
    axs[0].set(xlabel=r"Half the graph vertices, $m=M/2$", ylabel="Peak power (unscaled)",
               title="A  Exact peak powers in the complete-graph model", xlim=(1, 64), ylim=(0, 190))
    axs[0].legend(loc="upper left", frameon=False)
    axs[0].grid(alpha=.18)
    inset = axs[0].inset_axes([.61, .16, .35, .37])
    inset.plot(m[:10], sep[:10], ".-", color=colors["sep"], ms=5, lw=1.2)
    inset.set(xlim=(1, 10), ylim=(2.4, 6.0), xticks=[1, 4, 7, 10], yticks=[3, 4, 5],
              title="Odd/even m at small sizes")
    inset.tick_params(labelsize=8)
    inset.title.set_fontsize(8)
    axs[1].loglog(n, normalized_joint, color=colors["joint"], lw=2.1,
                   label=r"Joint: $2N^2$")
    axs[1].loglog(n, normalized_sep, color=colors["sep"], lw=2.1,
                   label=r"Separable: $2N^2 a_m/m$")
    axs[1].loglog(n[5:], 4*np.sqrt(2)*n[5:].astype(float)**1.5, color="#64748B", lw=1.1,
                   ls="--", label=r"Asymptote: $4\sqrt{2}N^{3/2}$")
    axs[1].set(xlabel=r"Battery spins, $N=m(2m-1)$", ylabel="Peak power (norm normalized)",
               title="B  Norm-normalized powers have different scaling exponents")
    axs[1].legend(frameon=False, loc="upper left")
    axs[1].grid(alpha=.18, which="major")
    fig.savefig(figures / "power_comparison.pdf")
    fig.savefig(figures / "power_comparison.png", dpi=220)
    plt.close(fig)
    (results / "figure_status.json").write_text(json.dumps({
        "status": "generated", "data_kind": "exact analytical formulas evaluated numerically",
        "independent_evidence": False, "m_range": [1, 64],
        "matplotlib_version": matplotlib.__version__, "numpy_version": np.__version__,
        "files": ["figures/power_comparison.pdf", "figures/power_comparison.png", "results/analytical_curves.csv"]
    }, indent=2)+"\n")
    print("Generated exact-formula plot and 64-row table; no fitted exponents.")


if __name__ == "__main__":
    main()
