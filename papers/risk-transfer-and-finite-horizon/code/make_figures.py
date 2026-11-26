"""Scientific illustration of the proved formula; floating-point, not proof.

The dashed historical bound is Christianson et al. (2024), Theorem 13.
The solid curve uses their Theorem 12 construction, proved minimax here.
"""
from pathlib import Path
from math import ceil, log1p
import csv

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

from one_max import root_float


def old_lower(theta, delta):
    if delta == 0:
        return root_float(theta, 0)
    n = max(1, ceil(1 / delta) - 1)
    lo, hi = 1.0, theta**0.5
    for _ in range(70):
        mid = (lo + hi) / 2
        if np.log(mid - 1) + n * log1p(mid / n) < np.log(theta - 1):
            lo = mid
        else:
            hi = mid
    return (lo + hi) / 2


def main():
    case = Path(__file__).resolve().parents[1]
    (case / "figures").mkdir(exist_ok=True)
    theta = 100.0
    risks = np.linspace(0, 1, 501)
    optimum = np.array([root_float(theta, d) for d in risks])
    lower = np.array([old_lower(theta, d) for d in risks])
    plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 10,
                         "axes.spines.top": False, "axes.spines.right": False,
                         "axes.labelcolor": "#25364A", "text.color": "#25364A",
                         "xtick.color": "#435266", "ytick.color": "#435266",
                         "pdf.fonttype": 42, "svg.fonttype": "none"})
    fig, axes = plt.subplots(1, 2, figsize=(10.5, 3.8), gridspec_kw={"width_ratios": [1.45, 1]},
                             layout="constrained")
    ax = axes[0]
    ax.fill_between(risks, lower, optimum, color="#DCE7F2", label="Gap closed by the new lower bound")
    ax.plot(risks, optimum, color="#126D83", lw=2.5, label="2024 algorithm, now proved minimax")
    ax.plot(risks, lower, color="#7A8191", lw=1.5, ls="--", label="2024 Theorem 13 lower bound")
    ax.axvline(.5, color="#B8BDC4", lw=1, ls=":")
    ax.set(xlabel=r"Risk parameter $\delta$ (worst $1-\delta$ reward mass)",
           ylabel="Optimal competitive ratio", xlim=(0, 1), ylim=(3, 10.8),
           title=r"A. Exact optimum for $\theta=100$")
    ax.text(.63, 9.3, r"$a_\delta=\sqrt{\theta}=10$", fontsize=11)
    ax.legend(loc="lower right", frameon=False, fontsize=8.3)
    ax.grid(axis="y", color="#E4E7EB", lw=.65)
    ax = axes[1]
    eps = np.geomspace(1e-4, .15, 110)
    gains = np.array([10 - root_float(theta, .5 - e) for e in eps])
    guide = 360 * eps**2
    ax.loglog(eps, gains, color="#126D83", lw=2.5, label="Exact randomized advantage")
    ax.loglog(eps, guide, color="#B46D40", lw=1.5, ls="--", label=r"$4R(R-1)\varepsilon^2$")
    ax.set(xlabel=r"$\varepsilon=1/2-\delta$", ylabel=r"$R-a_\delta$, where $R=10$",
           title="B. Quadratic approach to the plateau")
    ax.legend(loc="lower right", frameon=False, fontsize=8.3)
    ax.grid(which="major", color="#E4E7EB", lw=.65)
    for suffix in ["pdf", "png", "svg"]:
        fig.savefig(case / "figures" / f"exact_optimality.{suffix}", dpi=200,
                    metadata={"Creator": "CVaR optimal search illustration"} if suffix == "pdf" else None)
    plt.close(fig)
    with (case / "results" / "curve_data.csv").open("w", newline="", encoding="utf-8") as stream:
        writer = csv.writer(stream)
        writer.writerow(["delta", "optimal_ratio_float", "historical_lower_bound_float"])
        writer.writerows(zip(risks, optimum, lower))
    print("Created scientific figures and 501-row floating-point curve data.")


if __name__ == "__main__":
    main()
