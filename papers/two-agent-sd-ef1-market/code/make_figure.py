#!/usr/bin/env python3
"""Make the paper's market-crossing figure from results/example_trace.json.

Requires matplotlib. The PDF is vector-based; the PNG is exported at 300 dpi.
The figure illustrates one trace, not a proof or a numerical performance study.
"""

from __future__ import annotations

import argparse
from fractions import Fraction
import json
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt


def main() -> None:
    project = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--trace", type=Path,
                        default=project / "results" / "example_trace.json")
    parser.add_argument("--output-dir", type=Path, default=project / "figures")
    args = parser.parse_args()
    data = json.loads(args.trace.read_text(encoding="utf-8"))
    trace = data["trace"]
    vertices = [set(v) for v in trace["vertices"]]
    values = [Fraction(v) for v in trace["market_values"]]
    chosen = data["selected_path_index"]
    crossing = data["crossing_indices"]
    assert len(vertices) == len(values) == 4, "This layout is for the four-vertex example."
    assert values == [3, 2, 1, 0] and chosen == 1 and crossing == [1, 2]
    assert vertices[0].isdisjoint(vertices[-1])
    assert vertices[0] | vertices[-1] == set(range(data["padded_items"]))
    total = values[0] + values[-1]
    half = total / 2
    assert half == Fraction(3, 2)
    swaps = []
    for before, after in zip(vertices, vertices[1:]):
        removed, inserted = before - after, after - before
        assert len(removed) == len(inserted) == 1
        swaps.append((next(iter(removed)), next(iter(inserted))))

    plt.rcParams.update({
        "font.family": "DejaVu Sans",
        "font.size": 10,
        "axes.labelsize": 10,
        "axes.titlesize": 12,
        "xtick.labelsize": 9,
        "ytick.labelsize": 9,
        "mathtext.fontset": "dejavusans",
        "pdf.fonttype": 42,
        "ps.fonttype": 42,
        "savefig.facecolor": "white",
    })
    ink = "#243549"
    muted = "#5B6877"
    line = "#476A90"
    accent = "#00856B"
    crossing_color = "#C96B24"
    fig = plt.figure(figsize=(7.5, 4.9), facecolor="white")
    grid = fig.add_gridspec(2, 1, height_ratios=[3.1, 1.1], hspace=0.35,
                           left=0.10, right=0.96, top=0.88, bottom=0.10)
    ax = fig.add_subplot(grid[0])
    strip = fig.add_subplot(grid[1], sharex=ax)
    fig.suptitle("A market EF1 endpoint on an exchange path",
                 x=0.10, y=0.975, ha="left", color=ink, fontsize=12.5,
                 fontweight="semibold")
    fig.text(0.10, 0.922, "Every vertex satisfies subjective SD-EF1.",
             ha="left", color=muted, fontsize=10)

    x = list(range(len(values)))
    y = [float(v) for v in values]
    ax.set_xlim(-0.24, 3.52)
    ax.set_ylim(-0.22, 3.30)
    ax.set_yticks([0, 1, 2, 3])
    ax.set_xticks(x, [str(i) for i in x])
    ax.set_xlabel("Path index", labelpad=6, color=ink)
    ax.set_ylabel(r"Agent 1 market value, $w(A)$", labelpad=9, color=ink)
    ax.tick_params(axis="both", colors=muted, length=3)
    ax.spines[["top", "right"]].set_visible(False)
    for spine in ("left", "bottom"):
        ax.spines[spine].set_color("#B7C1CB")
    ax.grid(axis="y", color="#E6EBF0", linewidth=0.7)
    ax.set_axisbelow(True)
    ax.axhline(float(half), color=muted, linestyle=(0, (4, 3)), linewidth=1.2,
               zorder=1)
    ax.text(3.12, float(half) + 0.10, r"$W/2=1.5$", color=muted,
            fontsize=9.5, va="bottom")
    ax.plot(x, y, color=line, linewidth=1.8, zorder=2)
    lo, hi = crossing
    ax.plot(x[lo:hi+1], y[lo:hi+1], color=crossing_color,
            linewidth=3.0, zorder=3)
    ax.scatter(x, y, s=48, color=line, edgecolor="white", linewidth=1.0, zorder=4)
    ax.scatter([chosen], [y[chosen]], s=128, color=accent,
               edgecolor="white", linewidth=1.8, zorder=5)
    ax.annotate("Selected endpoint\nmarket EF1", xy=(chosen, y[chosen]),
                xytext=(1.38, 2.65), ha="left", va="center", color=accent,
                fontsize=10,
                arrowprops={"arrowstyle": "-", "color": accent,
                            "linewidth": 1.0, "shrinkB": 8})
    ax.annotate("Crossing", xy=(1.5, float(half)), xytext=(2.08, 1.98),
                ha="left", va="center", color=crossing_color, fontsize=9.5,
                arrowprops={"arrowstyle": "-", "color": crossing_color,
                            "linewidth": 1.0, "shrinkB": 4})

    strip.set_ylim(-0.20, 1.0)
    strip.axis("off")
    strip.text(-0.24, 0.97, "Agent 1 bundles", ha="left", va="top",
               fontsize=9.5, color=muted)
    for index, vertex in enumerate(vertices):
        label = r"$\{" + ",".join(str(g) for g in sorted(vertex)) + r"\}$"
        selected = index == chosen
        strip.text(index, 0.48, label, ha="center", va="center", fontsize=10,
                   color=accent if selected else ink,
                   bbox={"boxstyle": "round,pad=0.42,rounding_size=0.15",
                         "facecolor": "#EAF6F1" if selected else "#F3F6F9",
                         "edgecolor": accent if selected else "#CFD8E1",
                         "linewidth": 1.0 if selected else 0.8})
    for index, (removed, inserted) in enumerate(swaps):
        strip.annotate("", xy=(index + 0.69, 0.48),
                       xytext=(index + 0.31, 0.48),
                       arrowprops={"arrowstyle": "->", "color": muted,
                                   "linewidth": 0.9, "mutation_scale": 9})
        strip.text(index + 0.5, 0.08, f"{removed} out, {inserted} in",
                   ha="center", va="center", color=muted, fontsize=8.5)
    fig.text(0.10, 0.035,
             "Each step exchanges one good. Item labels follow the zero-based example data.",
             ha="left", color=muted, fontsize=8.5)

    args.output_dir.mkdir(parents=True, exist_ok=True)
    pdf = args.output_dir / "market_crossing.pdf"
    png = args.output_dir / "market_crossing.png"
    metadata = {
        "Title": "Market crossing along a subjective SD-EF1 exchange path",
        "Subject": "Illustrative four-vertex trace; total market value 3; selected index 1",
        "Creator": "code/make_figure.py (matplotlib)",
        "CreationDate": None,
        "ModDate": None,
    }
    fig.savefig(pdf, metadata=metadata)
    fig.savefig(png, dpi=300,
                metadata={"Description": metadata["Subject"],
                          "Software": "code/make_figure.py (matplotlib)"})
    plt.close(fig)
    print(json.dumps({"pdf": str(pdf), "png": str(png),
                      "path_market_values": [str(v) for v in values],
                      "half_total": str(half), "selected_path_index": chosen,
                      "one_for_one_swaps": swaps}, indent=2))


if __name__ == "__main__":
    main()
