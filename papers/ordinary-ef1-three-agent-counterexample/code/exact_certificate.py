#!/usr/bin/env python3
"""Exact EF1 certificate using full utility evaluation and independent differences.

Python 3.11+ standard library only. No solver and no floating-point arithmetic.
Run from any directory; --output optionally writes the deterministic certificate.
"""

from __future__ import annotations

import argparse
from itertools import product
import json
from pathlib import Path


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def cyclic_profile(alpha=2, beta=1, gamma=2, zeta=2):
    utilities = [[[0 for _ in range(3)] for _ in range(3)] for _ in range(3)]
    for observer in range(3):
        utilities[observer][observer] = [alpha, beta, gamma]
        utilities[observer][(observer + 1) % 3][2] = gamma + zeta
    return utilities


def utility(profile, observer, allocation, deleted=None):
    return sum(
        profile[observer][recipient][item]
        for item, recipient in enumerate(allocation)
        if item != deleted
    )


def swapped(allocation, first, second):
    return tuple(
        second if recipient == first else first if recipient == second else recipient
        for recipient in allocation
    )


def direct_gap(profile, allocation, observer, target, deleted=None):
    return utility(profile, observer, swapped(allocation, observer, target), deleted) - utility(
        profile, observer, allocation, deleted
    )


def difference_gap(profile, allocation, observer, target, deleted=None):
    total = 0
    for item, recipient in enumerate(allocation):
        if item == deleted:
            continue
        value = profile[observer][observer][item] - profile[observer][target][item]
        if recipient == target:
            total += value
        elif recipient == observer:
            total -= value
    return total


def inspect_profile(profile, store_witnesses=False):
    n = len(profile)
    m = len(profile[0][0])
    fair = []
    witnesses = []
    gap_checks = 0
    for allocation in product(range(n), repeat=m):
        bad = []
        for observer, target in product(range(n), repeat=2):
            if observer == target:
                continue
            gaps = []
            for deleted in [None, *range(m)]:
                direct = direct_gap(profile, allocation, observer, target, deleted)
                alternate = difference_gap(profile, allocation, observer, target, deleted)
                require(direct == alternate, "Direct utility and signed-difference evaluations disagree")
                gap_checks += 1
                gaps.append(direct)
            if min(gaps) > 0:
                bad.append({
                    "observer": observer + 1,
                    "target": target + 1,
                    "gap_without_deletion": gaps[0],
                    "gaps_after_deleting_a_b_c": gaps[1:],
                    "minimum_remaining_gap": min(gaps),
                })
        if not bad:
            fair.append([recipient + 1 for recipient in allocation])
        if store_witnesses:
            witnesses.append({
                "recipients_of_a_b_c": [recipient + 1 for recipient in allocation],
                "ef1_failure_witnesses": bad,
            })
    return {"fair_allocations": fair, "witnesses": witnesses, "gap_checks": gap_checks}


def run():
    profile = cyclic_profile()
    primary = inspect_profile(profile, store_witnesses=True)
    require(not primary["fair_allocations"], "The displayed profile unexpectedly has an EF1 allocation")
    require(len(primary["witnesses"]) == 27, "The certificate does not cover all allocations")
    require(primary["gap_checks"] == 648, "Unexpected primary comparison count")
    margins = [max(w["minimum_remaining_gap"] for w in row["ef1_failure_witnesses"]) for row in primary["witnesses"]]
    require(min(margins) >= 1, "The advertised strict margin is missing")

    # This grid includes alpha=beta, gamma=min(alpha,beta), and zeta=min(alpha,beta).
    # It checks the proved real-parameter formula; it does not prove that formula.
    grid_results = []
    grid_gap_checks = 0
    for alpha, beta, gamma, zeta in product(range(1, 5), repeat=4):
        inspection = inspect_profile(cyclic_profile(alpha, beta, gamma, zeta))
        no_fair = not inspection["fair_allocations"]
        predicted = alpha != beta and min(alpha, beta) < min(gamma, zeta)
        require(no_fair == predicted, f"Parameter classification fails at {(alpha, beta, gamma, zeta)}")
        grid_gap_checks += inspection["gap_checks"]
        grid_results.append({
            "parameters": [alpha, beta, gamma, zeta],
            "ef1_allocations": len(inspection["fair_allocations"]),
            "no_ef1_predicted": predicted,
        })

    # A recipient-independent additive shift preserves every swap comparison.
    shifted = [[[value + 1 for value in recipient] for recipient in observer] for observer in profile]
    shifted_result = inspect_profile(shifted)
    require(not shifted_result["fair_allocations"], "The strictly positive shifted profile lost the obstruction")
    for allocation in product(range(3), repeat=3):
        for observer, target in product(range(3), repeat=2):
            if observer == target:
                continue
            for deleted in [None, 0, 1, 2]:
                require(
                    direct_gap(profile, allocation, observer, target, deleted)
                    == direct_gap(shifted, allocation, observer, target, deleted),
                    "Recipient-independent shift changed a swap comparison",
                )

    return {
        "status": "passed",
        "scope": "Exact finite checks; general parameter and minimality results have separate written proofs",
        "utilities_observer_recipient_item": profile,
        "agents": 3,
        "items": ["a", "b", "c"],
        "primary_allocations": 27,
        "primary_ordered_comparisons": 162,
        "primary_gap_checks": primary["gap_checks"],
        "primary_ef1_allocations": 0,
        "minimum_certified_margin": min(margins),
        "parameter_grid_cases": len(grid_results),
        "parameter_grid_gap_checks": grid_gap_checks,
        "shifted_profile_gap_checks": shifted_result["gap_checks"],
        "shift_invariance_comparisons": 648,
        "allocation_witnesses": primary["witnesses"],
        "parameter_grid": grid_results,
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    certificate = run()
    encoded = json.dumps(certificate, indent=2, sort_keys=True) + "\n"
    if args.output is not None:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(encoded, encoding="utf-8")
    print(json.dumps({key: value for key, value in certificate.items() if key not in {"allocation_witnesses", "parameter_grid", "utilities_observer_recipient_item"}}, sort_keys=True))


if __name__ == "__main__":
    main()
