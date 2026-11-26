#!/usr/bin/env python3
"""Recompute two exact small examples and optionally draw their prefix costs.

The mathematical data require only the Python standard library. Figures also
require Matplotlib. This script uses labelled load-state dynamic programming,
with lexicographic tie-breaking, to return an optimal recipient sequence.
The examples illustrate the theorem; they are not its proof.
"""
from __future__ import annotations

import argparse
import json
from itertools import accumulate
from pathlib import Path


def require(condition: bool, message: str) -> None:
    if not condition:
        raise RuntimeError(message)


def optimal_labelled_allocation(values: tuple[int, ...], agents: int = 4) -> dict:
    states = {(0,) * agents: (0, ())}
    for value in values:
        following = {}
        for loads, (cost, recipients) in states.items():
            for agent in range(agents):
                updated = list(loads)
                updated[agent] += value
                key = tuple(updated)
                candidate = (cost + max(updated) - min(updated), recipients + (agent + 1,))
                if key not in following or candidate < following[key]:
                    following[key] = candidate
        states = following
    final_loads, (optimum, recipients) = min(states.items(), key=lambda item: item[1])
    loads = [0] * agents
    prefix_loads = []
    ranges = []
    for value, agent in zip(values, recipients):
        loads[agent - 1] += value
        prefix_loads.append(list(loads))
        ranges.append(max(loads) - min(loads))
    require(sum(ranges) == optimum, "recipient path has the wrong cost")
    require(tuple(loads) == final_loads, "recipient path has the wrong final state")
    return {
        "values": list(values),
        "optimal_cost": optimum,
        "optimal_recipients_one_based": list(recipients),
        "prefix_loads": prefix_loads,
        "prefix_ranges": ranges,
        "prefix_cumulative_costs": list(accumulate(ranges)),
        "final_loads": list(final_loads),
        "terminal_load_states_considered": len(states),
    }


def make_data() -> dict:
    cases = []
    T, m, n = 3, 3, 4
    M = m + 1
    K = M * T
    H = m * (m + 1) // 2
    Q = 2 * H + 1
    for name, source, expected_zero, expected_positive in [
        ("yes", (1, 2, 3), 12, 159),
        ("no", (2, 2, 2), 21, 267),
    ]:
        core = (T,) + source + (T,)
        zero = optimal_labelled_allocation(core + (0,) * m, n)
        positive = optimal_labelled_allocation(tuple(Q * x for x in core) + (1,) * m, n)
        require(zero["optimal_cost"] == expected_zero, "unexpected zero-tail optimum")
        require(positive["optimal_cost"] == expected_positive, "unexpected positive optimum")
        R = zero["prefix_ranges"][M]
        require(n * (zero["optimal_cost"] - K) >= M * R, "terminal inequality failed")
        cases.append({"partition_answer": name, "source_values": list(source),
                      "zero_tail": zero, "strictly_positive": positive})
    return {
        "schema_version": 1,
        "method": "exact labelled load-state DP; least cost then lexicographically least recipients",
        "scope": "two illustrative inputs only; not a proof of the general theorem",
        "agents": n, "T": T, "m": m, "M": M,
        "zero_tail_threshold": K,
        "positive_scale_Q": Q, "positive_error_bound_H": H,
        "positive_threshold": Q * K + H,
        "examples": cases,
    }


def draw(data: dict, figures: Path) -> None:
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt

    figures.mkdir(parents=True, exist_ok=True)
    plt.rcParams.update({"font.family": "DejaVu Sans", "font.size": 10,
                         "axes.labelsize": 10.5, "axes.titlesize": 11,
                         "pdf.fonttype": 42, "ps.fonttype": 42})
    fig, axes = plt.subplots(2, 1, figsize=(8.8, 6.8), sharex=True)
    fig.subplots_adjust(left=0.11, right=0.93, bottom=0.14, top=0.78, hspace=0.36)
    fig.suptitle("Four agents: exact cumulative-envy examples", x=0.11, ha="left",
                 y=0.96, fontsize=16, weight="bold")
    fig.text(0.11, 0.905, "T = 3  |  Three middle goods  |  Prescribed order  |  Threshold K = 12",
             fontsize=10.5, color="#454545")
    colors = ("#245A81", "#B64E23")
    markers = ("o", "s")
    rounds = list(range(1, 9))
    for example, color, marker in zip(data["examples"], colors, markers):
        record = example["zero_tail"]
        label = (f"PARTITION {example['partition_answer']}: "
                 f"{example['source_values']}")
        axes[0].step(rounds, record["prefix_ranges"], where="mid", color=color,
                     linewidth=2, marker=marker, markersize=5, label=label)
        axes[1].plot(rounds, record["prefix_cumulative_costs"], color=color,
                     linewidth=2, marker=marker, markersize=5)
        axes[1].annotate(f"{record['optimal_cost']}", (8, record["optimal_cost"]),
                         xytext=(9, -3), textcoords="offset points", color=color,
                         fontsize=11, weight="bold")
    for ax in axes:
        ax.axvspan(4.5, 8.5, color="#EEF1F4", zorder=-2)
        ax.axvline(4.5, color="#7C8792", linestyle=(0, (3, 3)), linewidth=1)
        ax.spines[["top", "right"]].set_visible(False)
        ax.grid(axis="y", color="#D8DDE1", linewidth=0.65, zorder=-1)
        ax.set_xlim(0.6, 8.65)
        ax.set_xticks(rounds)
    axes[0].set_title("Load range after each good", loc="left", pad=10)
    axes[0].set_ylabel("Maximum envy")
    axes[0].set_ylim(-0.3, 4.55)
    axes[0].set_yticks(range(5))
    axes[0].legend(loc="lower left", bbox_to_anchor=(0, 1.18), frameon=False,
                   ncol=2, borderaxespad=0, handlelength=2.3, columnspacing=2)
    axes[0].text(6.5, 4.32, "Second sentinel + zero suffix", fontsize=9,
                 ha="center", color="#596571")
    axes[1].set_title("Cumulative maximum envy", loc="left", pad=10)
    axes[1].set_ylabel("Accumulated cost")
    axes[1].set_xlabel("Round (one good per round)")
    axes[1].set_ylim(0, 23)
    axes[1].set_yticks([0, 6, 12, 18, 21])
    axes[1].axhline(data["zero_tail_threshold"], color="#596571",
                    linestyle=(0, (4, 3)), linewidth=1, zorder=-1)
    axes[1].text(0.75, 12.6, "K = 12", color="#596571", fontsize=9)
    fig.text(0.11, 0.045,
             "Each curve uses an exact optimal allocation. These finite examples illustrate, "
             "but do not prove, the theorem.", fontsize=9, color="#454545")
    fig.savefig(figures / "prefix_costs.png", dpi=200, facecolor="white")
    fig.savefig(figures / "prefix_costs.pdf", facecolor="white",
                 metadata={"CreationDate": None, "ModDate": None,
                           "Title": "Exact small-instance prefix costs for cumulative envy"})
    plt.close(fig)


def main() -> None:
    base = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=base / "results" / "illustrative_examples.json")
    parser.add_argument("--figures-dir", type=Path, default=base / "figures")
    parser.add_argument("--no-figures", action="store_true",
                        help="write exact JSON only; no Matplotlib dependency")
    args = parser.parse_args()
    data = make_data()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(data, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    if not args.no_figures:
        draw(data, args.figures_dir)
    print(json.dumps({"examples": len(data["examples"]),
                      "zero_optima": [x["zero_tail"]["optimal_cost"] for x in data["examples"]],
                      "positive_optima": [x["strictly_positive"]["optimal_cost"] for x in data["examples"]],
                      "figures_generated": not args.no_figures}))


if __name__ == "__main__":
    main()
