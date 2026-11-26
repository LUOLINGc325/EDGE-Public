#!/usr/bin/env python3
"""Exact corroboration of the two-box pure-search theorem; no third-party deps.

Finite checks are not a substitute for the all-m, all-sequences written proof.
The event-time evaluation below is independent of the budget calculation.
"""
from fractions import Fraction as F
from pathlib import Path
import argparse
import json
import platform


def parameters(m):
    if not isinstance(m, int) or m < 3:
        raise ValueError("the theorem requires an integer m >= 3")
    r = F(1, m)
    q = 1 - r
    Q = 1 / q
    delta = F(m - 1, m ** (m - 1) - 1)
    V = Q + 1 + delta / m
    source_value = 2 + r + F(m ** (m - 2) + m - 2,
                             (m - 1) * (m ** (m - 1) - 1))
    gamma = F(m ** (m - 2) - 1, m ** (m - 1) - 1)
    return r, q, Q, delta, V, source_value, gamma


def event_time_payoff(prefix, period, box, r):
    """Sum q*r^(k-1)*time_of_kth_visit, with exact geometric periodic tail."""
    q = 1 - r
    total = F(0)
    seen = 0
    for t, action in enumerate(prefix, 1):
        if action == box:
            total += q * r ** seen * t
            seen += 1
    positions = [j for j, action in enumerate(period, 1) if action == box]
    if not positions:
        return None  # infinite expectation, since q<1
    ratio = r ** len(positions)
    for j, position in enumerate(positions):
        first_time = len(prefix) + position
        total += q * r ** (seen + j) * (
            F(first_time) / (1 - ratio)
            + len(period) * ratio / (1 - ratio) ** 2
        )
    return total


def candidate_action(m, index):
    if index < 2:
        return index + 1
    h = m - 1
    return 2 if (index - 2) % (2 * h) < h else 1


def candidate_check(m):
    r, q, Q, delta, V, source_value, gamma = parameters(m)
    h = m - 1
    period = [2] * h + [1] * h
    payoffs = [event_time_payoff([1, 2], period, box, r) for box in (1, 2)]
    assert payoffs == [V, V]
    assert V == source_value
    assert 0 < gamma == 1 - m ** (m - 2) * delta
    assert delta / m < 1
    # Verify a full budget cycle, checking every wrong branch as well.
    state = [1 + delta / m, 1 + delta / m]
    min_forcing_margin = None
    for n in range(2 + 2 * h):
        action = candidate_action(m, n)
        active, other = action - 1, 2 - action
        if n:
            assert state[active] < 1
            assert state[other] >= 1
            margin = 1 - state[active]
            min_forcing_margin = margin if min_forcing_margin is None else min(min_forcing_margin, margin)
            # Opposite action leaves active box unsearched, violating nonnegativity.
            assert state[active] - 1 < 0
        state[active] *= m
        state[other] -= 1
        assert min(state) >= 0
    assert state == [h + delta, delta]
    assert min_forcing_margin == gamma
    mixed = 2 * Q - F(1, 2)
    gap = V - mixed
    assert gap == F(m - 3, 2 * (m - 1)) + delta / m > 0
    return {"m": m, "q": str(q), "pure_value": str(V),
            "mixed_value": str(mixed), "randomization_gap": str(gap),
            "gamma": str(gamma), "period_length": 2 * h,
            "candidate_event_time_payoffs": list(map(str, payoffs)),
            "all_exact_checks_passed": True}


def exhaustive_prefix_check(m, depth):
    """Enumerate every word, without candidate pruning or a periodicity assumption.

    A prefix has necessary conditional lower bound X_i+r^a_i/(1-r).
    Only at full depth do we compare this bound with V.
    """
    r, q, Q, delta, V, source_value, gamma = parameters(m)
    stack = [((), (0, 0), (F(0), F(0)))]
    survivors = []
    examined = 0
    while stack:
        word, counts, elapsed = stack.pop()
        if len(word) == depth:
            examined += 1
            lower = [elapsed[i] + r ** counts[i] * Q for i in (0, 1)]
            if max(lower) <= V:
                survivors.append("".join(map(str, word)))
            continue
        next_elapsed = tuple(elapsed[i] + r ** counts[i] for i in (0, 1))
        for action in (1, 2):
            next_counts = list(counts)
            next_counts[action - 1] += 1
            stack.append((word + (action,), tuple(next_counts), next_elapsed))
    expected = "".join(str(candidate_action(m, n)) for n in range(depth))
    swapped = expected.translate(str.maketrans("12", "21"))
    assert sorted(survivors) == sorted([expected, swapped])
    assert examined == 2 ** depth
    return {"m": m, "depth": depth, "all_words_examined": examined,
            "surviving_prefixes": sorted(survivors), "passed": True}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--max-m", type=int, default=100)
    parser.add_argument("--prefix-depth", type=int, default=14)
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results" / "exact_checks.json")
    args = parser.parse_args()
    checks = [candidate_check(m) for m in range(3, args.max_m + 1)]
    prefixes = [exhaustive_prefix_check(m, args.prefix_depth) for m in (3, 4, 5)]
    result = {"arithmetic": "fractions.Fraction; exact integer/rational operations",
              "python": platform.python_version(), "candidate_parameter_count": len(checks),
              "candidate_checks": checks, "exhaustive_prefix_checks": prefixes,
              "scope": "Finite corroboration; the universal theorem is proved in the manuscript.",
              "passed": True}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"passed": True, "m_range": [3, args.max_m],
                      "prefix_words_examined": sum(row["all_words_examined"] for row in prefixes),
                      "output": str(args.output)}, indent=2))


if __name__ == "__main__":
    main()
