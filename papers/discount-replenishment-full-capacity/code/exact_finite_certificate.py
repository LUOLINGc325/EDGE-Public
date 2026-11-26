#!/usr/bin/env python3
"""Exact rational certificates for the discounted free-disposal inventory model.

Only the Python standard library is used.  The program verifies finite Bellman
equations and all finite action comparisons; FINITE_REDUCTION.md supplies the
analytic proof that these finite checks certify the infinite-state model.
This is not Lean code and is not a proof-assistant verification.
"""

from __future__ import annotations

import argparse
from fractions import Fraction as Q
import json
from pathlib import Path


def floor_q(x: Q) -> int:
    return x.numerator // x.denominator


def qs(x: Q) -> str:
    return str(x.numerator) if x.denominator == 1 else str(x)


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ValueError(message)


def solve_linear(matrix: list[list[Q]], rhs: list[Q]) -> list[Q]:
    """Exact Gauss-Jordan elimination; all pivot tests are exact."""
    n = len(rhs)
    a = [row[:] + [rhs[i]] for i, row in enumerate(matrix)]
    for j in range(n):
        pivot = next((i for i in range(j, n) if a[i][j]), None)
        require(pivot is not None, "singular policy evaluation matrix")
        a[j], a[pivot] = a[pivot], a[j]
        scale = a[j][j]
        a[j] = [x / scale for x in a[j]]
        for i in range(n):
            if i == j or not a[i][j]:
                continue
            scale = a[i][j]
            a[i] = [x - scale * y for x, y in zip(a[i], a[j])]
    return [row[-1] for row in a]


def make_model(name: str, params: dict[str, str], law: dict) -> dict:
    p = {key: Q(value) for key, value in params.items()}
    lam, mu, alpha, h, b, K, k = (p[key] for key in ("lambda", "mu", "alpha", "h", "b", "K", "k"))
    require(all(x > 0 for x in (lam, alpha, h, b)), "strictly positive model rates/slopes required")
    require(mu >= 0 and 0 <= k <= K, "invalid opportunity rate or order fees")
    d = lam + mu + alpha
    C = K * (1 + lam / alpha)
    L = -floor_q((d + lam) * K / b)
    U = floor_q(lam * K / h)
    xs = list(range(L, U + 1))
    cutoff = U - L
    if law["type"] == "finite":
        raw = {int(r): Q(prob) for r, prob in law["probabilities"].items()}
        require(sum(raw.values(), Q(0)) == 1, "capacity probabilities must sum to one")
        require(all(r >= 0 and prob >= 0 for r, prob in raw.items()), "invalid capacity law")
        probabilities: dict[int, Q] = {}
        for r, prob in raw.items():
            rt = min(r, cutoff)
            probabilities[rt] = probabilities.get(rt, Q(0)) + prob
    elif law["type"] == "geometric_half_positive":
        # P(R=r)=2^{-r}, r=1,2,... .  This is an exact infinite-support input.
        if cutoff == 0:
            probabilities = {0: Q(1)}
        else:
            probabilities = {r: Q(1, 2**r) for r in range(1, cutoff)}
            probabilities[cutoff] = Q(1, 2 ** (cutoff - 1))
    else:
        raise ValueError("unknown capacity law")
    probabilities = {r: prob for r, prob in sorted(probabilities.items()) if prob}
    require(sum(probabilities.values(), Q(0)) == 1, "truncated law does not sum to one")

    def fee(x: int, y: int, r: int) -> Q:
        return Q(0) if y <= x else (k if y <= x + r else K)

    def holding(x: int) -> Q:
        return h * max(x, 0) + b * max(-x, 0)

    # Each continuation state has demand (x-1,0) and capacity-offer (x,r)
    # decisions.  Their weights sum to lambda+mu exactly.
    events = {
        x: [(lam, x - 1, 0, "demand")]
        + [(mu * prob, x, r, "opportunity") for r, prob in probabilities.items() if mu * prob]
        for x in xs
    }
    index = {x: i for i, x in enumerate(xs)}
    policy = {x: [0] * len(events[x]) for x in xs}
    require(0 in index, "finite interval must contain zero")

    def action_values(g: list[Q], x: int, r: int) -> list[Q]:
        return [fee(x, y, r) + g[index[y]] for y in xs]

    def bellman(g: list[Q]) -> list[Q]:
        return [
            (holding(x) + sum(weight * min(action_values(g, state, r)) for weight, state, r, _ in events[x])) / d
            for x in xs
        ]

    history = []
    for iteration in range(1, 501):
        n = len(xs)
        matrix = [[Q(0) for _ in xs] for _ in xs]
        rhs = [holding(x) for x in xs]
        for i, x in enumerate(xs):
            matrix[i][i] = d
            for target, (weight, state, r, _) in zip(policy[x], events[x]):
                matrix[i][index[target]] -= weight
                rhs[i] += weight * fee(state, target, r)
        require(all(sum(row, Q(0)) == alpha for row in matrix), "policy matrix row sum mismatch")
        g = solve_linear(matrix, rhs)
        fg = bellman(g)
        residual = max(abs(a - b_) for a, b_ in zip(fg, g))
        require(all(a <= b_ for a, b_ in zip(fg, g)), "policy value is not a Bellman supersolution")
        history.append(qs(residual))
        if residual == 0:
            break
        policy = {
            x: [xs[min(range(len(xs)), key=lambda j: action_values(g, state, r)[j])]
                for _, state, r, _ in events[x]]
            for x in xs
        }
    else:
        raise ValueError("policy iteration did not terminate within the explicit guard")

    minimum = min(g)
    minimizers = [x for x in xs if g[index[x]] == minimum]
    S = min(minimizers)
    require(minimum >= 0 and g[index[0]] <= lam * K / alpha, "a priori value bound failed")
    require(S >= 0, "negative global minimizer")
    require(all(g[index[x + 1]] < g[index[x]] for x in xs if x < S), "strict descent failed")
    require(h * S <= alpha * minimum <= h * (S + 1), "minimum cost window failed")
    if K > 0:
        require(h * S < alpha * minimum, "strict minimum lower window failed")
    for x in xs:
        if x >= S + 1:
            require(g[index[x]] - minimum == (h * x - alpha * minimum) / d, "affine tail identity failed")
    require(set(minimizers).issubset({S, S + 1}), "unexpected minimizer tie structure")

    rows = []
    positive_gaps = []
    checked_inequalities = 0
    for x in xs:
        for _, state, r, event_type in events[x]:
            costs = action_values(g, state, r)
            best = min(costs)
            targets = [target for target, value in zip(xs, costs) if value == best]
            gaps = [value - best for value in costs]
            require(all(gap >= 0 for gap in gaps), "negative certified action gap")
            checked_inequalities += len(gaps)
            local_positive = [gap for gap in gaps if gap > 0]
            positive_gaps.extend(local_positive)
            rows.append({
                "continuation_state": x,
                "event": event_type,
                "decision_state": state,
                "capacity": r,
                "canonical_target": min(targets),
                "all_optimal_targets_in_interval": targets,
                "decision_value": qs(best),
                "smallest_strict_gap": qs(min(local_positive)) if local_positive else None,
            })

    # A strict accepted-discount witness below S has insufficient capacity:
    # x+r<S and the unique optimum uses all r units.  All competitors in the
    # exact action interval are checked, including regular and free actions.
    binding_witnesses = []
    for x in xs:
        for r, probability in probabilities.items():
            if not (r > 0 and x < x + r < S and x + r in index):
                continue
            costs = action_values(g, x, r)
            target = x + r
            chosen = costs[index[target]]
            other = [value for y, value in zip(xs, costs) if y != target]
            margin = min(other) - chosen if other else Q(0)
            if margin > 0:
                binding_witnesses.append({
                    "x": x, "r": r, "S": S, "q": r, "target": target,
                    "opportunity_probability_after_exact_tail_merge": qs(probability),
                    "discounted_action_value": qs(chosen), "strict_gap": qs(margin),
                    "no_action_value": qs(g[index[x]]),
                    "regular_to_S_value": qs(K + minimum),
                })

    if k == K:
        require(all(min(action_values(g, x, r)) == min(action_values(g, x, 0))
                    for x in xs for r in probabilities), "equal fees should remove capacity dependence")
    if K == 0:
        require(xs == [0] and g == [Q(0)], "zero-fee degenerate solution failed")

    # The baseline proof supplies global existence; sharp bounds supply exact
    # finite action sufficiency.  Neither uses a numerical tail extrapolation.
    return {
        "name": name,
        "parameters": {key: qs(value) for key, value in p.items()},
        "capacity_law": law,
        "capacity_tail_merge": {"cutoff": cutoff, "probabilities": {str(r): qs(prob) for r, prob in probabilities.items()}},
        "coarse_existence_interval": {
            "L": -floor_q(d * C / b), "U": floor_q(d * C / h), "C": qs(C),
        },
        "exact_action_interval": {"L": L, "U": U, "number_of_targets": len(xs)},
        "discount_contraction": qs((lam + mu) / d),
        "supnorm_residual_multiplier": qs(d / alpha),
        "policy_evaluation_iterations": iteration,
        "exact_policy_residual_history": history,
        "G": {str(x): qs(g[index[x]]) for x in xs},
        "minimum_value": qs(minimum),
        "smallest_minimizer": S,
        "all_global_minimizers": minimizers,
        "bellman_residual": "0",
        "exact_action_inequalities_checked": checked_inequalities,
        "minimum_strict_action_gap": qs(min(positive_gaps)) if positive_gaps else None,
        "binding_discount_witnesses": binding_witnesses,
        "canonical_policy_and_exact_ties": rows,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    examples = [
        ("binding_discount", {"lambda": "1", "mu": "1", "alpha": "1", "h": "1", "b": "4", "K": "6", "k": "1"},
         {"type": "finite", "probabilities": {"1": "1/2", "2": "1/2"}}),
        ("zero_discount_fee_infinite_capacity_support", {"lambda": "1", "mu": "1", "alpha": "1", "h": "1", "b": "4", "K": "3", "k": "0"},
         {"type": "geometric_half_positive"}),
        ("equal_fees", {"lambda": "1", "mu": "2", "alpha": "1", "h": "1", "b": "5", "K": "2", "k": "2"},
         {"type": "finite", "probabilities": {"1": "1/3", "5": "2/3"}}),
        ("all_order_fees_zero", {"lambda": "2", "mu": "3", "alpha": "1/2", "h": "2", "b": "3", "K": "0", "k": "0"},
         {"type": "geometric_half_positive"}),
        ("two_adjacent_global_minimizers", {"lambda": "1", "mu": "1", "alpha": "1", "h": "1", "b": "4", "K": "1", "k": "1/2"},
         {"type": "finite", "probabilities": {"1": "1"}}),
    ]
    cases = [make_model(*example) for example in examples]
    require(bool(cases[0]["binding_discount_witnesses"]), "chosen main example lacks a strict binding-discount witness")
    require(cases[-1]["all_global_minimizers"] == [0, 1], "designated exact tie example failed")
    result = {
        "schema": "exact-inventory-certificate-v1",
        "arithmetic": "Python fractions.Fraction; exact rational comparisons",
        "scope": "Infinite-state discounted unit-demand model with free disposal, via the proved exact finite reduction; no Lean execution",
        "case_count": len(cases),
        "cases": cases,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(args.output), "cases": [
        {"name": row["name"], "states": row["exact_action_interval"]["number_of_targets"],
         "S": row["smallest_minimizer"], "minimum": row["minimum_value"],
         "minimizers": row["all_global_minimizers"],
         "strict_binding_witnesses": len(row["binding_discount_witnesses"]),
         "residual": row["bellman_residual"]}
        for row in cases]}, ensure_ascii=False))


if __name__ == "__main__":
    main()
