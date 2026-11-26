#!/usr/bin/env python3
"""Exact arithmetic for the manuscript's illustrative four-arm instance.

This is a reproducible example certificate, not the proof of the general theorem.
Only Python's standard library is required.
"""
from fractions import Fraction as Q
from itertools import combinations
import json
from pathlib import Path


def text(x):
    return str(x.numerator) if x.denominator == 1 else f"{x.numerator}/{x.denominator}"


def main():
    arms = [Q(3, 10), Q(3, 10), Q(1, 5), Q(1, 5)]
    rows = []
    for size in range(1, len(arms)):
        for chosen in combinations(range(len(arms)), size):
            remainder = 1 - sum(arms[i] for i in chosen)
            denominator = sum(1 / arms[i] for i in chosen) + 1 / remainder
            rows.append((chosen, Q(size) / denominator, denominator, remainder))
    value = max(row[1] for row in rows)
    best = [row for row in rows if row[1] == value]
    masses = [max(Q(0), 1 - value / a) for a in arms]
    chosen, _, denominator, remainder = best[0]
    lengths = [arms[i] for i in chosen] + [remainder]
    probabilities = [1 / (denominator * b) for b in lengths]
    result = {
        "arithmetic": "fractions.Fraction, exact rational arithmetic",
        "scope": "One nondegenerate illustrative instance; not a finite-grid substitute for the real-parameter proof.",
        "arms": list(map(text, arms)),
        "value": text(value),
        "proper_nonempty_subsets_checked": len(rows),
        "maximizers_one_based": [[i + 1 for i in row[0]] for row in best],
        "partition_lengths": list(map(text, lengths)),
        "attacker_probabilities": list(map(text, probabilities)),
        "per_part_probability_times_length": [text(p * b) for p, b in zip(probabilities, lengths)],
        "payoff_for_trap_in_each_part": [
            text(sum(p * b for j, (p, b) in enumerate(zip(probabilities, lengths)) if j != k))
            for k in range(len(lengths))
        ],
        "defender_arm_masses": list(map(text, masses)),
        "defender_center_mass": text(1 - sum(masses)),
        "nonzero_arm_support_cutoffs": [text(a - value) for a, p in zip(arms, masses) if p > 0],
        "candidate_values": [
            {"I_one_based": [i + 1 for i in row[0]], "value": text(row[1])}
            for row in rows
        ],
    }
    destination = Path(__file__).resolve().parents[1] / "results" / "four_arm_certificate.json"
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps({"value": result["value"], "subsets": len(rows),
                      "center_mass": result["defender_center_mass"], "output": str(destination)}))


if __name__ == "__main__":
    main()
