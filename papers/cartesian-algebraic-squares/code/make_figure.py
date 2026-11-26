"""Draw the exact P4 Cartesian-square graph and its labeled triangular root."""
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib.lines import Line2D


def main():
    target = Path(__file__).resolve().parents[1] / "figures"
    target.mkdir(exist_ok=True)
    plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 10,
                         "svg.hashsalt": "cartesian-algebraic-squares-v1"})
    blue, orange, gray = "#2F66AD", "#CA6B32", "#535D67"
    fig, axes = plt.subplots(1, 2, figsize=(10, 4.65))
    all_vertices = [(i, j) for i in range(1, 5) for j in range(1, 5)]
    for ax, root in zip(axes, (False, True)):
        vertices = [(i, j) for i, j in all_vertices if not root or i <= j]
        vertex_set = set(vertices)
        for i, j in vertices:
            for other in ((i + 1, j), (i, j + 1)):
                if other in vertex_set:
                    ax.plot([i, other[0]], [j, other[1]], color="#A8B0BA",
                            lw=1.6, zorder=1)
        for i, j in vertices:
            color = blue if i < j else orange if i > j else gray
            ax.scatter([i], [j], s=780, c=[color], edgecolors="white",
                       linewidths=1.2, zorder=2)
            ax.text(i, j, f"{i},{j}", ha="center", va="center", color="white",
                    fontsize=9.4, zorder=3)
        ax.set_aspect("equal")
        ax.set_xlim(.45, 4.55)
        ax.set_ylim(.45, 4.55)
        ax.axis("off")
    axes[0].set_title("a   Product: P₄ □ P₄", loc="left", fontsize=13, pad=6)
    axes[1].set_title("b   One square root: i ≤ j", loc="left", fontsize=13, pad=6)
    axes[0].text(.5, -.03, "16 vertices · 4 fixed core vertices",
                 transform=axes[0].transAxes, ha="center", color="#414B57")
    axes[1].text(.5, -.03, "10 vertices · 4 labeled core vertices",
                 transform=axes[1].transAxes, ha="center", color="#414B57")
    handles = [Line2D([], [], color=c, marker="o", linestyle="", markersize=9,
                      label=label) for c, label in
               [(blue, "Wing A: i < j"), (orange, "Wing B: i > j"),
                (gray, "Core: i = j")]]
    fig.legend(handles=handles, loc="lower center", ncol=3, frameon=False,
               bbox_to_anchor=(.5, -.005), columnspacing=2.6)
    fig.subplots_adjust(left=.04, right=.96, top=.9, bottom=.14, wspace=.28)
    for suffix in ("png", "pdf", "svg"):
        metadata = {"Date": None} if suffix == "svg" else (
            {"CreationDate": None, "ModDate": None} if suffix == "pdf" else {})
        fig.savefig(target / f"path4_square.{suffix}", dpi=240,
                    facecolor="white", metadata=metadata)
    plt.close(fig)
    print("Generated exact P4 product and root figures.")


if __name__ == "__main__":
    main()
