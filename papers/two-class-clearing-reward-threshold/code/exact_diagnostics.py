#!/usr/bin/env python3
"""Exact finite diagnostics for the unequal-reward priority theorem.

Only the Python standard library is required.  The main check computes the
actual nonpreemptive service-completion Bellman equations by integrating the
binomial survivor distribution against an exponential service duration.  It
then compares that calculation with the separate first-event recurrences used
in the manuscript.  All arithmetic is rational; no tolerance is used.

These are finite diagnostics, not a proof of an all-population theorem.
Run from any directory; the default output is ../results/exact_diagnostics.json.
"""

from __future__ import annotations

import argparse
from collections import Counter
from dataclasses import dataclass
from fractions import Fraction as Q
from functools import lru_cache
import json
from math import comb
from pathlib import Path
from typing import Dict, Iterable, Tuple


State = Tuple[int, int]
Values = Dict[State, Q]


class DiagnosticFailure(RuntimeError):
    """A claimed finite identity or inequality was violated."""


@dataclass(frozen=True)
class Parameters:
    name: str
    a: Q
    b: Q
    c: Q
    region: str

    @property
    def threshold(self) -> Q:
        return self.c * (self.b + 1) / (self.a + self.c)


PARAMETERS = (
    Parameters("slow_half", Q(1, 2), Q(1, 4), Q(3), "a<1"),
    Parameters("slow_three_quarters", Q(3, 4), Q(1, 2), Q(2), "a<1"),
    Parameters("slow_small_rates", Q(1, 10), Q(1, 20), Q(3), "a<1"),
    Parameters("slow_near_equal_service", Q(9, 10), Q(4, 5), Q(3, 2), "a<1"),
    Parameters("unit_service_three", Q(1), Q(1, 2), Q(3), "a=1"),
    Parameters("unit_service_two", Q(1), Q(3, 4), Q(2), "a=1"),
    Parameters("mixed_2_1_3", Q(2), Q(1), Q(3), "a>1,b<c"),
    Parameters("mixed_three_halves", Q(3, 2), Q(1), Q(2), "a>1,b<c"),
    Parameters("mixed_five_halves", Q(5, 2), Q(3, 2), Q(2), "a>1,b<c"),
    Parameters("boundary_b_equals_c_two", Q(3), Q(2), Q(2), "b=c"),
    Parameters("boundary_b_equals_c_three_halves", Q(2), Q(3, 2), Q(3, 2), "b=c"),
    Parameters("double_fast_4_3_2", Q(4), Q(3), Q(2), "b>c"),
    Parameters("double_fast_seven_halves", Q(7, 2), Q(3), Q(3, 2), "b>c"),
    Parameters("double_fast_ten", Q(10), Q(4), Q(3), "b>c"),
    Parameters("double_fast_near_boundary", Q(9, 8), Q(11, 10), Q(21, 20), "b>c"),
)


def exact_text(value: Q) -> str:
    return str(value)


def states(limit: int) -> Iterable[State]:
    """Increasing total population, with both coordinates at most limit."""
    for total in range(2 * limit + 1):
        for n in range(max(0, total - limit), min(limit, total) + 1):
            yield n, total - n


class Checks:
    def __init__(self) -> None:
        self.counts: Counter[str] = Counter()

    def require(self, condition: bool, name: str, context: str) -> None:
        self.counts[name] += 1
        if not condition:
            raise DiagnosticFailure(f"{name}: {context}")


class CompletionModel:
    """Independent implementation using the actual next service completion."""

    def __init__(self, parameters: Parameters, checks: Checks) -> None:
        self.p = parameters
        self.checks = checks
        self.reference_marginal: Values | None = None

    @lru_cache(maxsize=None)
    def transitions(self, service: int, u: int, v: int) -> Tuple[Tuple[int, int, Q], ...]:
        """u,v are waiting counts after the selected job enters service.

        At service time t the two survivor counts are conditionally independent
        Bin(u,exp(-t)) and Bin(v,exp(-c*t)).  Expanding the two failure factors
        and integrating exp(-(mu+k+j+c*(ell+h))*t) gives the expression below.
        This does not allow a scheduling decision at an abandonment event.
        """
        mu = self.p.a if service == 1 else self.p.b
        out = []
        for k in range(u + 1):
            for ell in range(v + 1):
                probability = Q(0)
                for j in range(u - k + 1):
                    for h in range(v - ell + 1):
                        coefficient = ((-1) ** (j + h)) * comb(u - k, j) * comb(v - ell, h)
                        probability += coefficient * mu / (mu + k + j + self.p.c * (ell + h))
                probability *= comb(u, k) * comb(v, ell)
                self.checks.require(
                    probability >= 0,
                    "completion_probability_nonnegative",
                    f"{self.p.name}, service={service}, waiting={(u,v)}, survivors={(k,ell)}",
                )
                out.append((k, ell, probability))
        self.checks.require(
            sum((probability for _, _, probability in out), Q(0)) == 1,
            "completion_distribution_mass_one",
            f"{self.p.name}, service={service}, waiting={(u,v)}",
        )
        return tuple(out)

    def expectation(self, values: Values, service: int, u: int, v: int) -> Q:
        return sum((probability * values[k, ell] for k, ell, probability in self.transitions(service, u, v)), Q(0))

    def solve(self, reward: Q, limit: int) -> Tuple[Values, Values, Values, Dict[State, Dict[int, Q]]]:
        optimal: Values = {(0, 0): Q(0)}
        priority: Values = {(0, 0): Q(0)}
        initial_low: Values = {}
        actions: Dict[State, Dict[int, Q]] = {}
        for n, m in states(limit):
            if n == m == 0:
                continue
            available: Dict[int, Q] = {}
            if n:
                available[1] = reward + self.expectation(optimal, 1, n - 1, m)
            if m:
                available[2] = 1 + self.expectation(optimal, 2, n, m - 1)
            optimal[n, m] = max(available.values())
            actions[n, m] = available
            if n:
                priority[n, m] = reward + self.expectation(priority, 1, n - 1, m)
            else:
                priority[n, m] = 1 + self.expectation(priority, 2, 0, m - 1)
            if m:
                initial_low[n, m] = 1 + self.expectation(priority, 2, n, m - 1)
        return optimal, priority, initial_low, actions


def first_event_priority(p: Parameters, reward: Q, limit: int) -> Values:
    """Separate implementation: SP1's first-event rational recurrence."""
    out: Values = {(0, 0): Q(0)}
    for n, m in states(limit):
        if n == m == 0:
            continue
        if not n:
            out[n, m] = sum((p.b / (p.b + j * p.c) for j in range(m)), Q(0))
        else:
            A = p.a + n - 1
            numerator = A * out[n - 1, m] + p.a * reward
            if m:
                numerator += m * p.c * out[n, m - 1]
            out[n, m] = numerator / (A + m * p.c)
    return out


def inspect_run(p: Parameters, reward: Q, reward_kind: str, model: CompletionModel,
                limit: int, checks: Checks) -> Tuple[dict, dict]:
    optimal, priority, initial_low, actions = model.solve(reward, limit)
    recurrence = first_event_priority(p, reward, limit)
    q = {(n, m): priority[n, m] - priority[n, m - 1]
         for n in range(limit + 1) for m in range(1, limit + 1)}
    if model.reference_marginal is None:
        model.reference_marginal = q.copy()
    else:
        for state, value in q.items():
            checks.require(value == model.reference_marginal[state], "marginal_independent_of_reward", f"{p.name},{reward_kind},{state}")
    deviations = {(n, m): priority[n, m] - initial_low[n, m]
                  for n in range(limit + 1) for m in range(1, limit + 1)}
    residuals: Values = {}
    H_signs: Counter[str] = Counter()
    for state in states(limit):
        checks.require(priority[state] == recurrence[state], "completion_vs_first_event_priority", f"{p.name},{reward_kind},{state}")
        if reward_kind != "below_threshold":
            checks.require(optimal[state] == priority[state], "priority_equals_optimal_above_or_at_threshold", f"{p.name},{reward_kind},{state}")
    for m in range(1, limit + 1):
        checks.require(q[0, m] == p.b / (p.b + (m - 1) * p.c), "marginal_zero_high_boundary", f"{p.name},{reward_kind},m={m}")
        checks.require(deviations[0, m] == 0, "deviation_zero_high_boundary", f"{p.name},{reward_kind},m={m}")
    for n in range(1, limit + 1):
        product = Q(1)
        for j in range(n):
            product *= (p.a + j) / (p.a + p.c + j)
        checks.require(q[n, 1] == product, "marginal_product_boundary", f"{p.name},{reward_kind},n={n}")
        for m in range(1, limit + 1):
            A = p.a + n - 1
            B = p.b + (m - 1) * p.c
            H = (p.a - 1) * B + n * (p.b - p.c)
            t = p.b * A - n * p.a * reward
            H_signs["zero" if H == 0 else "positive" if H > 0 else "negative"] += 1
            q_rhs = A * q[n - 1, m]
            if m > 1:
                q_rhs += (m - 1) * p.c * q[n, m - 1]
            checks.require((A + m * p.c) * q[n, m] == q_rhs, "marginal_first_event_identity", f"{p.name},{reward_kind},{(n,m)}")
            residual = (H * q[n, m] - t) / A
            residuals[n, m] = residual
            residual_from_differences = n * (priority[n, m] - priority[n - 1, m]) + B * q[n, m] - p.b
            checks.require(residual == residual_from_differences, "residual_two_formulas", f"{p.name},{reward_kind},{(n,m)}")
            g_rhs = p.b * priority[n, m - 1] + n * initial_low[n - 1, m] + p.b
            d_rhs = n * deviations[n - 1, m] + residual
            if m > 1:
                g_rhs += (m - 1) * p.c * initial_low[n, m - 1]
                d_rhs += (m - 1) * p.c * deviations[n, m - 1]
            denominator = B + n
            checks.require(denominator * initial_low[n, m] == g_rhs, "initial_low_first_event_identity", f"{p.name},{reward_kind},{(n,m)}")
            checks.require(denominator * deviations[n, m] == d_rhs, "deviation_first_event_identity", f"{p.name},{reward_kind},{(n,m)}")
            if reward_kind != "below_threshold":
                checks.require(residual >= 0, "residual_nonnegative_above_or_at_threshold", f"{p.name},{reward_kind},{(n,m)}")
                checks.require(deviations[n, m] >= 0, "deviation_nonnegative_above_or_at_threshold", f"{p.name},{reward_kind},{(n,m)}")
            if reward_kind == "above_threshold":
                checks.require(deviations[n, m] > 0, "deviation_strictly_positive_above_threshold", f"{p.name},{reward_kind},{(n,m)}")
    pair_difference = reward / (p.b + 1) - p.c / (p.a + p.c)
    checks.require(deviations[1, 1] == pair_difference, "two_job_necessity_identity", f"{p.name},{reward_kind}")
    if reward_kind == "at_threshold":
        checks.require(pair_difference == 0, "two_job_threshold_tie", p.name)
    if reward_kind == "below_threshold":
        checks.require(pair_difference < 0 and actions[1, 1][2] > actions[1, 1][1], "two_job_strict_counterexample_below_threshold", p.name)
    interior = [(n, m) for n in range(1, limit + 1) for m in range(1, limit + 1)]
    selected_states = [(1, 1), (1, 2), (2, 1), (2, 2), (3, 2), (2, 3), (limit, limit)]
    selected_states = list(dict.fromkeys(state for state in selected_states if max(state) <= limit))
    example = {
        "parameters": {"a": exact_text(p.a), "b": exact_text(p.b), "c": exact_text(p.c), "r": exact_text(reward), "r_star": exact_text(p.threshold)},
        "reward_position": reward_kind,
        "states": [
            {"n": n, "m": m, "optimal_value": exact_text(optimal[n, m]),
             "priority_value_F": exact_text(priority[n, m]), "initial_low_value_G": exact_text(initial_low[n, m]),
             "deviation_D": exact_text(deviations[n, m]), "marginal_q": exact_text(q[n, m]),
             "source_R": exact_text(residuals[n, m]),
             "optimal_action1_value": exact_text(actions[n, m][1]), "optimal_action2_value": exact_text(actions[n, m][2])}
            for n, m in selected_states
        ],
    }
    report = {
        "parameter_name": p.name, "region": p.region,
        "parameters": example["parameters"], "reward_position": reward_kind,
        "grid_states": (limit + 1) ** 2, "interior_states": limit ** 2,
        "priority_optimal_states": sum(optimal[state] == priority[state] for state in states(limit)),
        "source_R_signs": {"negative": sum(residuals[s] < 0 for s in interior), "zero": sum(residuals[s] == 0 for s in interior), "positive": sum(residuals[s] > 0 for s in interior)},
        "H_signs": dict(sorted(H_signs.items())),
        "minimum_source_R": exact_text(min(residuals.values())),
        "minimum_deviation_D": exact_text(min(deviations[s] for s in interior)),
        "two_job_priority_value": exact_text(priority[1, 1]),
        "two_job_initial_low_value": exact_text(initial_low[1, 1]),
        "two_job_difference": exact_text(pair_difference),
    }
    return report, example


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--limit", type=int, default=6, help="maximum of each class count (default: 6)")
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results" / "exact_diagnostics.json")
    args = parser.parse_args()
    if args.limit < 2:
        parser.error("--limit must be at least 2")
    checks = Checks()
    reports = []
    examples = {}
    for p in PARAMETERS:
        checks.require(p.c > 1 and p.b < p.a < p.b * p.c, "parameter_in_strict_wedge", p.name)
        checks.require(p.threshold > 1, "threshold_exceeds_one", p.name)
        model = CompletionModel(p, checks)
        rewards = (("at_threshold", p.threshold), ("above_threshold", p.threshold + Q(1, 3)), ("below_threshold", (p.threshold + 1) / 2))
        for reward_kind, reward in rewards:
            report, example = inspect_run(p, reward, reward_kind, model, args.limit, checks)
            reports.append(report)
            if p.name in {"mixed_2_1_3", "double_fast_4_3_2"}:
                examples[f"{p.name}/{reward_kind}"] = example
    result = {
        "schema": "weighted-priority-exact-finite-diagnostics-v1",
        "arithmetic": "Python fractions.Fraction; all comparisons are exact; no numerical tolerance",
        "scope": {"parameter_families": len(PARAMETERS), "reward_positions_per_family": 3,
                  "parameter_reward_runs": len(reports), "maximum_each_class_count": args.limit,
                  "total_state_instances": len(reports) * (args.limit + 1) ** 2,
                  "total_interior_state_instances": len(reports) * args.limit ** 2},
        "method": "Integrate the survivor distribution at the actual completion time of a nonpreemptive exponential service; compute optimal Bellman values and SP1 values independently of the manuscript's first-event recurrences; compare exact identities and relevant inequalities.",
        "limitations": "Finite diagnostics support error detection and reproducibility. They do not establish a theorem for all populations or all real parameters. The written proof provides that argument. No Lean compilation or formal verification is performed.",
        "outcome": "all_requested_finite_checks_satisfied",
        "check_counts": dict(sorted(checks.counts.items())),
        "total_exact_checks": sum(checks.counts.values()),
        "runs": reports,
        "examples": examples,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    examples_output = args.output.with_name("exact_examples.json")
    examples_output.write_text(json.dumps({"schema": "weighted-priority-exact-examples-v1", "arithmetic": result["arithmetic"], "limitations": result["limitations"], "examples": examples}, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(args.output), "examples_output": str(examples_output), "outcome": result["outcome"], "scope": result["scope"], "total_exact_checks": result["total_exact_checks"]}, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
