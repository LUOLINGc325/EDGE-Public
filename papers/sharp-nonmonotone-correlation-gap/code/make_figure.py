#!/usr/bin/env python3
"""Plot proven coefficient and the exact finite sharpness family."""
from pathlib import Path
import json
import math
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]


def main():
    p = np.linspace(0.00001, 0.99999, 1000)
    old = (1-p) * (1-math.exp(-1))
    sharp = -np.expm1(-(1-p))
    plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 10,
                         "axes.spines.top": False, "axes.spines.right": False})
    fig, (ax, bx) = plt.subplots(1, 2, figsize=(10.4, 4.0), layout="constrained")
    ax.plot(p, sharp, color="#16746d", lw=2.5, label="Sharp guarantee (this proof)")
    ax.plot(p, old, color="#7b8595", lw=1.8, ls="--", label="Chekuri-Livanos guarantee")
    ax.fill_between(p, old, sharp, color="#16746d", alpha=.1)
    ax.set(xlabel="Marginal cap p (0 < p < 1)", ylabel="Guaranteed independent / correlated value",
           title="A. The exact worst-case coefficient", xlim=(0,1), ylim=(0,.67))
    ax.legend(frameon=False, fontsize=8, loc="upper right")
    ms = np.unique(np.geomspace(1, 256, 100).astype(int))
    finite = -np.expm1(ms*np.log1p(-.5/ms))
    limit = -math.expm1(-.5)
    bx.plot(ms, finite, color="#bb6b31", marker=".", ms=3, lw=1.5,
            label="Exact finite construction")
    bx.axhline(limit, color="#16746d", ls="--", label="Sharp limit")
    bx.set(xlabel="Number m of ordinary elements (log scale)",
           ylabel="Independent / correlated value", title="B. Sharpness at p = 1/2", xscale="log")
    bx.legend(frameon=False, fontsize=8)
    for a in (ax, bx):
        a.grid(alpha=.15)
    fig.savefig(ROOT / "figures" / "sharp_bound.png", dpi=190)
    fig.savefig(ROOT / "figures" / "sharp_bound.pdf")
    rows = []
    for q in (.1,.25,.5,.75,.8,.9,.95):
        before = (1-q)*(1-math.exp(-1))
        after = -math.expm1(-(1-q))
        rows.append({"p":q,"previous":before,"sharp":after,
                     "relative_gain_percent":100*(after/before-1)})
    (ROOT/"results"/"coefficient_table.json").write_text(
        json.dumps(rows, indent=2)+"\n", encoding="utf-8")
    print("Generated figures and coefficient table; these illustrate analytic formulas.")


if __name__ == "__main__":
    main()
