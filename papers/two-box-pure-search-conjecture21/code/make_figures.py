#!/usr/bin/env python3
"""Publication figures; points are the proved discrete q=(m-1)/m values."""
from pathlib import Path
import json
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from fractions import Fraction

ROOT = Path(__file__).resolve().parents[1]
data = json.loads((ROOT / "results/exact_checks.json").read_text())
rows = [row for row in data["candidate_checks"] if row["m"] <= 16]
plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 10,
                     "axes.spines.top": False, "axes.spines.right": False,
                     "savefig.bbox": "tight"})
fig, ax = plt.subplots(1, 2, figsize=(10, 3.65), constrained_layout=True)
ms = [row["m"] for row in rows]
ax[0].plot(ms, [float(Fraction(row["pure_value"])) for row in rows], "o-",
           color="#176a79", label="Best deterministic value")
ax[0].plot(ms, [float(Fraction(row["mixed_value"])) for row in rows], "s--",
           color="#b36a25", label="Known randomized value")
ax[0].set(xlabel="Integer parameter m", ylabel="Worst conditional expected search time")
ax[0].legend(frameon=False, fontsize=9)
ax[0].grid(alpha=.18)
ax[1].plot(ms, [float(Fraction(row["randomization_gap"])) for row in rows], "o-",
           color="#464873")
ax[1].axhline(.5, color="grey", linestyle=":", label="Limit 1/2")
ax[1].set(xlabel="Integer parameter m", ylabel="Extra expected cost of determinism", ylim=(0,.54))
ax[1].legend(frameon=False)
ax[1].grid(alpha=.18)
out = ROOT / "figures"
out.mkdir(exist_ok=True)
for ext in ("pdf", "png"):
    fig.savefig(out / ("determinism_cost." + ext), dpi=200)
print("Wrote figures/determinism_cost.pdf and .png")
