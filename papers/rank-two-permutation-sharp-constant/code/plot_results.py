#!/usr/bin/env python3
"""Plot existing finite-grid results; no simulations or result-file mutations.

From the case root: python code/plot_results.py
Requires NumPy and Matplotlib. Outputs results/figures/binary_scaling.{png,pdf}.
"""
import hashlib
import json
import math
from pathlib import Path
from statistics import NormalDist

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D
import numpy as np

ROOT = Path(__file__).resolve().parents[1]
SOURCE = ROOT / "results/numerical_codes.json"
OUT = ROOT / "results/figures"


def main():
    raw = SOURCE.read_bytes()
    digest = hashlib.sha256(raw).hexdigest()
    channels = json.loads(raw)["binary_channels"]
    assert len(channels) == 3
    OUT.mkdir(parents=True, exist_ok=True)
    plt.rcParams.update({"font.size": 10, "axes.labelsize": 11,
                         "axes.titlesize": 11, "mathtext.fontset": "stix",
                         "font.family": "DejaVu Sans", "pdf.fonttype": 42,
                         "axes.spines.top": False, "axes.spines.right": False})
    fig, axes = plt.subplots(1, 2, figsize=(9.4, 4.2))
    colors, markers = ["#0072B2", "#D55E00", "#009E73"], ["o", "s", "^"]
    handles = []
    for channel, color, marker in zip(channels, colors, markers):
        a, b, eps = channel["a"], channel["b"], channel["epsilon"]
        assert abs(eps - 0.1) < 1e-14
        coefficient = (b-a) / ((math.sqrt(a*(1-a)) + math.sqrt(b*(1-b)))
                              * NormalDist().inv_cdf(1-eps/2))
        assert math.isclose(coefficient, channel["coefficient"], rel_tol=1e-12)
        rows = sorted(channel["rows"], key=lambda row: row["n"])
        for row in rows:
            feasible = [c["M"] for c in row["candidates"] if c["max_error_metric_decoder"] <= eps]
            assert row["best_feasible_grid_M_in_searched_window"] == max(feasible)
        n = np.array([row["n"] for row in rows])
        M = np.array([row["best_feasible_grid_M_in_searched_window"] for row in rows])
        x = np.linspace(4, 68, 200)
        axes[0].plot(x, coefficient*x, "--", color=color, lw=1.3, alpha=0.85)
        axes[0].plot(np.sqrt(n), M, linestyle="none", marker=marker, color=color, ms=6.5, zorder=3)
        axes[1].axhline(coefficient, ls="--", color=color, lw=1.3, alpha=0.85)
        axes[1].plot(n, M/np.sqrt(n), linestyle="none", marker=marker, color=color, ms=6.5, zorder=3)
        handles.append(Line2D([], [], color=color, marker=marker, linestyle="none",
                              label=fr"$(a,b)=({a:.2f},{b:.2f}),\ C={coefficient:.4f}$"))
    axes[0].set(title="(a) Constructed message count", xlabel=r"$\sqrt{n}$", ylabel=r"$M_{\mathrm{grid}}$", xlim=(4, 68), ylim=(0, 57))
    axes[0].set_xticks([8, 16, 32, 64])
    axes[1].set(title="(b) Normalized message count", xlabel=r"Blocklength $n$ (log scale)", ylabel=r"$M_{\mathrm{grid}}/\sqrt{n}$", xscale="log", xlim=(45, 5700), ylim=(0.26, 0.91))
    axes[1].set_xticks([64, 256, 1024, 4096], labels=["64", "256", "1024", "4096"])
    axes[1].minorticks_off()
    for ax in axes:
        ax.grid(axis="y", alpha=0.22, lw=0.6)
        ax.set_axisbelow(True)
    fig.suptitle(r"Binary-output metric-grid constructions: $\epsilon=0.1$", y=0.98, fontsize=12)
    fig.legend(handles=handles, loc="upper center", bbox_to_anchor=(0.5, 0.91), ncol=3, frameon=False, fontsize=8.6, columnspacing=1.3)
    fig.text(0.5, 0.025, "Markers: largest feasible grid in the bounded search.  Dashed: exact asymptotic reference.", ha="center", fontsize=8.5)
    fig.subplots_adjust(left=0.075, right=0.98, bottom=0.19, top=0.73, wspace=0.25)
    fig.savefig(OUT / "binary_scaling.png", dpi=180, pil_kwargs={"optimize": True})
    fig.savefig(OUT / "binary_scaling.pdf", metadata={"Title": "Binary-output metric-grid scaling", "CreationDate": None, "ModDate": None})
    plt.close(fig)
    caption = """# Binary-output scaling figure

**Caption.** Constructive finite-grid lower bounds at maximal-error target
epsilon = 0.1 for three positive binary-output channels with endpoint
probabilities (a,b). Each marker is the largest feasible metric-grid message
count found **only within the bounded search window** recorded in
`../numerical_codes.json`, using the numerically evaluated exact count law and
the stated metric decoder. Panel (a) plots this count against sqrt(n); panel
(b) divides the count by sqrt(n). Dashed lines show C sqrt(n) and C, respectively,
where C = (b-a)/[(sqrt(a(1-a))+sqrt(b(1-b))) Phi^{-1}(1-epsilon/2)] is the
proved asymptotic coefficient. The markers are constructive lower bounds;
they are not the globally optimal finite-blocklength message counts and do
not establish the O(1) remainder. No new simulation or numerical search was
run to make this figure.

Reproduce from the case root: `python code/plot_results.py`.
The PDF contains vector artwork; the PNG is a 180 dpi preview.
"""
    (OUT / "README.md").write_text(caption + "\nInput SHA-256: `" + digest + "`.\n")
    assert SOURCE.read_bytes() == raw
    print(json.dumps({name: {"bytes": (OUT/name).stat().st_size,
                            "sha256": hashlib.sha256((OUT/name).read_bytes()).hexdigest()}
                      for name in ["binary_scaling.png", "binary_scaling.pdf", "README.md"]}, indent=2))


if __name__ == "__main__":
    main()
