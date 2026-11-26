#!/usr/bin/env python3
"""Render exact analytical compatibility sets; no fitted data."""
from pathlib import Path
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parents[1]
out = ROOT/"figures"
out.mkdir(exist_ok=True)
plt.rcParams.update({"font.family":"DejaVu Sans", "font.size":10,
                     "axes.spines.top":False, "axes.spines.right":False,
                     "savefig.bbox":"tight"})
fig, axes = plt.subplots(1, 2, figsize=(10, 3.8), sharey=True)
for ax, w, title, positive in zip(
    axes, [2*np.pi, np.pi], [r"Positive repeated eigenvalue: $\lambda=e^{-\alpha}$",
                             r"Negative repeated eigenvalue: $\lambda=-e^{-\alpha}$"],
    [True, False]
):
    threshold = np.sqrt(3)*w
    a = np.linspace(threshold+0.0001, 30, 2400)
    g = 2*w/np.sqrt(3)*np.log((a+np.sqrt(3)*w)/(a-np.sqrt(3)*w))
    ax.fill_between(a, g, 80, where=g<=80, color="#cbe4ef", label="All finite rates above the curve")
    ax.plot(a, g, color="#146784", lw=2, label="Attained positive minimum")
    ax.axvline(threshold, ls="--", lw=1, color="#777777")
    if positive:
        ax.plot([3, 30], [0, 0], color="#172f44", lw=3, clip_on=False, label="Reversible embedding")
        ax.text(5, 20, "Only zero", color="#3e5362")
        ax.text(18, 3.5, "Excluded gap", color="#3e5362")
    else:
        ax.text(3.35, 37, "No reciprocal\nembedding", rotation=90, va="center", fontsize=9)
    ax.text(19, 69, "Unbounded above", color="#146784")
    ax.set(xlim=(3, 30), ylim=(0, 80), xlabel=r"$\alpha=ut=-\log|\lambda|$",
           title=title)
    ax.grid(axis="y", alpha=.18)
axes[0].set_ylabel(r"Entropy production per sampling interval, $\sigma t$")
fig.suptitle("Exact compatibility sets for symmetric three-state observations", fontsize=13, y=1.05)
fig.tight_layout()
fig.savefig(out/"entropy_compatibility_sets.pdf")
fig.savefig(out/"entropy_compatibility_sets.png", dpi=180)
print("Saved analytical figure in", out)
