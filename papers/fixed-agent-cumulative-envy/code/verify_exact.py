#!/usr/bin/env python3
"""Exact finite checks for the fixed-agent cumulative-envy reduction.

Uses only the Python standard library and unbounded integer arithmetic. The
optimizer enumerates all attainable sorted load vectors and retains the least
prefix cost at each state. A separate labelled-assignment enumerator checks the
optimizer and the inequalities on small instances. Neither check substitutes
for the general written proof.

Run from any directory:
    python3 code/verify_exact.py
    python3 -O code/verify_exact.py --output envy-certificate.json

All checks use explicit exceptions, so optimization flags cannot disable them.
The JSON output is deterministic and contains no wall-clock time or timestamp.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from dataclasses import dataclass
from itertools import combinations_with_replacement, product
from pathlib import Path
from typing import Iterable


class VerificationError(RuntimeError):
    """A mathematical or implementation check failed."""


def require(condition: bool, message: str) -> None:
    if not condition:
        raise VerificationError(message)


@dataclass(frozen=True)
class Instance:
    original: tuple[int, ...]
    agents: int
    target: int
    variables: tuple[int, ...]
    prefix_rounds: int
    tail_length: int
    threshold: int
    perturbation_bound: int
    scale: int
    core: tuple[int, ...]
    full_zero: tuple[int, ...]
    full_positive: tuple[int, ...]
    positive_threshold: int


def construct(original: Iterable[int], agents: int = 4) -> Instance:
    """The reduction, including the fixed-n padding and positive conversion."""
    values = tuple(original)
    if type(agents) is not int or agents < 4:
        raise ValueError("the reduction is defined for an integer n >= 4")
    if not values or any(type(x) is not int or x <= 0 for x in values):
        raise ValueError("the PARTITION input must be nonempty positive integers")
    total = sum(values)
    if total % 2:
        raise ValueError("odd-total PARTITION inputs are immediate no-instances")
    target = total // 2
    variables = values + (target,) * (agents - 4)
    tail = len(variables)
    rounds = tail + 1
    threshold = rounds * target
    bound = tail * (tail + 1) // 2
    scale = 2 * bound + 1
    core = (target,) + variables + (target,)
    full_zero = core + (0,) * tail
    full_positive = tuple(scale * x for x in core) + (1,) * tail
    require(sum(core) == agents * target, "construction total does not equal nT")
    require(all(x > 0 for x in full_positive), "positive instance contains zero")
    require(len(full_zero) == 2 * tail + 2, "construction length is incorrect")
    return Instance(values, agents, target, variables, rounds, tail, threshold,
                    bound, scale, core, full_zero, full_positive,
                    scale * threshold + bound)


def subset_sum_oracle(values: tuple[int, ...]) -> bool:
    """Exact source-problem oracle, independent of any scheduling quantities."""
    if sum(values) % 2:
        return False
    reachable = {0}
    for value in values:
        reachable |= {subtotal + value for subtotal in reachable}
    return sum(values) // 2 in reachable


def minimum_cost_by_final_loads(values: tuple[int, ...], agents: int):
    """Exact optimization by sorted load states; no reduction theorem is used."""
    current = {(0,) * agents: 0}
    visited = 1
    largest_layer = 1
    for value in values:
        following = {}
        for loads, prefix_cost in current.items():
            previous_load = None
            for recipient, old_load in enumerate(loads):
                # Equal current loads give the same next sorted state.
                if old_load == previous_load:
                    continue
                previous_load = old_load
                updated = list(loads)
                updated[recipient] += value
                updated.sort()
                new_loads = tuple(updated)
                candidate_cost = prefix_cost + new_loads[-1] - new_loads[0]
                incumbent = following.get(new_loads)
                if incumbent is None or candidate_cost < incumbent:
                    following[new_loads] = candidate_cost
        current = following
        visited += len(current)
        largest_layer = max(largest_layer, len(current))
    require(bool(current), "dynamic program produced no states")
    return current, visited, largest_layer


def check_dynamic_program(instance: Instance) -> dict:
    """Compare both target decisions to PARTITION and check all terminal states."""
    expected = subset_sum_oracle(instance.original)
    core_dp, zero_states, zero_peak = minimum_cost_by_final_loads(
        instance.core, instance.agents)
    best_zero = None
    smallest_slack = None
    for loads, core_cost in core_dp.items():
        terminal_range = loads[-1] - loads[0]
        cost = core_cost + instance.tail_length * terminal_range
        slack = (instance.agents * (cost - instance.threshold)
                 - instance.prefix_rounds * terminal_range)
        require(slack >= 0, f"terminal inequality failed: {instance}, {loads}")
        best_zero = cost if best_zero is None else min(best_zero, cost)
        smallest_slack = slack if smallest_slack is None else min(smallest_slack, slack)
    require((best_zero <= instance.threshold) == expected,
            f"zero-tail equivalence failed: {instance}")
    if expected:
        require(best_zero == instance.threshold, "yes-instance misses exact baseline")
    else:
        require(best_zero >= instance.threshold + 1, "integer no-instance gap failed")
    positive_dp, positive_states, positive_peak = minimum_cost_by_final_loads(
        instance.full_positive, instance.agents)
    best_positive = min(positive_dp.values())
    require((best_positive <= instance.positive_threshold) == expected,
            f"positive-tail equivalence failed: {instance}")
    return {
        "partition_yes": expected,
        "zero_optimum": best_zero,
        "positive_optimum": best_positive,
        "zero_terminal_states": len(core_dp),
        "positive_terminal_states": len(positive_dp),
        "states_visited": zero_states + positive_states,
        "largest_layer": max(zero_peak, positive_peak),
        "minimum_integer_inequality_slack": smallest_slack,
    }


def labelled_costs(instance: Instance, assignment: tuple[int, ...]):
    """Directly evaluate one labelled assignment in both target constructions.

    Load vectors are never sorted and no dominance rule or DP is used here.
    """
    loads_zero = [0] * instance.agents
    loads_positive = [0] * instance.agents
    cost_zero = 0
    cost_positive = 0
    terminal_range = None
    last_core_index = len(instance.core) - 1
    for index, recipient in enumerate(assignment):
        loads_zero[recipient] += instance.full_zero[index]
        loads_positive[recipient] += instance.full_positive[index]
        range_zero = max(loads_zero) - min(loads_zero)
        range_positive = max(loads_positive) - min(loads_positive)
        cost_zero += range_zero
        cost_positive += range_positive
        if index == last_core_index:
            terminal_range = range_zero
    require(terminal_range is not None, "missing terminal range")
    return cost_zero, cost_positive, terminal_range


def check_all_assignments(instance: Instance) -> dict:
    """Enumerate every labelled assignment, including every tail recipient."""
    total = 0
    best_zero = None
    best_positive = None
    smallest_slack = None
    largest_perturbation = 0
    for assignment in product(range(instance.agents), repeat=len(instance.full_zero)):
        cost_zero, cost_positive, terminal_range = labelled_costs(instance, assignment)
        slack = (instance.agents * (cost_zero - instance.threshold)
                 - instance.prefix_rounds * terminal_range)
        require(slack >= 0, f"labelled-assignment inequality failed: {assignment}")
        perturbation = abs(cost_positive - instance.scale * cost_zero)
        require(perturbation <= instance.perturbation_bound,
                f"positive-conversion error bound failed: {assignment}")
        best_zero = cost_zero if best_zero is None else min(best_zero, cost_zero)
        best_positive = (cost_positive if best_positive is None
                         else min(best_positive, cost_positive))
        smallest_slack = slack if smallest_slack is None else min(smallest_slack, slack)
        largest_perturbation = max(largest_perturbation, perturbation)
        total += 1
    expected_total = instance.agents ** len(instance.full_zero)
    require(total == expected_total, "assignment enumeration is incomplete")
    reference = check_dynamic_program(instance)
    require(best_zero == reference["zero_optimum"], "zero-tail DP/brute mismatch")
    require(best_positive == reference["positive_optimum"], "positive DP/brute mismatch")
    return {
        "agents": instance.agents,
        "partition_input": list(instance.original),
        "goods": len(instance.full_zero),
        "assignments_checked": total,
        "zero_optimum": best_zero,
        "zero_threshold": instance.threshold,
        "positive_optimum": best_positive,
        "positive_threshold": instance.positive_threshold,
        "minimum_integer_inequality_slack": smallest_slack,
        "maximum_observed_absolute_perturbation": largest_perturbation,
        "proved_perturbation_bound": instance.perturbation_bound,
    }


def check_boundaries() -> dict:
    invalid = [
        ((), 4), ((0, 2), 4), ((-1, 3), 4), ((1, 2), 4),
        ((1.0, 1), 4), ((True, 1), 4), ((1, 1), 3), ((1, 1), True),
    ]
    for values, agents in invalid:
        try:
            construct(values, agents)
        except ValueError:
            pass
        else:
            raise VerificationError(f"invalid construction input accepted: {values}, {agents}")
    huge = 2 ** 80
    stress = []
    for agents in (4, 5, 6):
        for values in ((huge + 1, huge + 1), (huge, huge + 2)):
            instance = construct(values, agents)
            result = check_dynamic_program(instance)
            stress.append({
                "agents": agents,
                "partition_input_decimal": [str(x) for x in values],
                "partition_yes": result["partition_yes"],
                "zero_optimum_decimal": str(result["zero_optimum"]),
                "positive_optimum_decimal": str(result["positive_optimum"]),
            })
    return {"invalid_inputs_rejected": len(invalid),
            "large_integer_stress_instances": stress,
            "arithmetic": "unbounded integers; no floating-point operations"}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    default_output = Path(__file__).resolve().parents[1] / "results" / "exact_certificate.json"
    parser.add_argument("--output", type=Path, default=default_output)
    args = parser.parse_args()

    suite = []
    # Every order is tested for the four-agent family.
    for length in range(1, 6):
        suite.extend((4, values) for values in product(range(1, 5), repeat=length)
                     if sum(values) % 2 == 0)
    # Larger fixed agent counts are tested on nondecreasing input families.
    for agents in (5, 6):
        for length in range(1, 5):
            suite.extend((agents, values)
                         for values in combinations_with_replacement(range(1, 6), length)
                         if sum(values) % 2 == 0)

    stats = {n: {"instances": 0, "yes": 0, "no": 0,
                 "zero_terminal_states": 0, "positive_terminal_states": 0,
                 "states_visited": 0, "largest_layer": 0} for n in (4, 5, 6)}
    for agents, values in suite:
        result = check_dynamic_program(construct(values, agents))
        row = stats[agents]
        row["instances"] += 1
        row["yes" if result["partition_yes"] else "no"] += 1
        for key in ("zero_terminal_states", "positive_terminal_states", "states_visited"):
            row[key] += result[key]
        row["largest_layer"] = max(row["largest_layer"], result["largest_layer"])

    brute_inputs = [(4, (1, 1)), (4, (1, 3)), (4, (1, 2, 3)),
                    (4, (2, 2, 2)), (5, (2,)), (6, (2,))]
    exhaustive = [check_all_assignments(construct(values, n)) for n, values in brute_inputs]
    boundary = check_boundaries()

    encoded_suite = json.dumps(suite, separators=(",", ":")).encode()
    certificate = {
        "schema_version": 1,
        "result": "PASS",
        "claim_boundary": (
            "These deterministic finite exact computations verify only the listed inputs. "
            "The general NP-completeness theorem and inequalities rely on the written proof; "
            "this is not a formal proof-assistant certificate."
        ),
        "source_problem_oracle": "exact subset-sum set enumeration",
        "target_optimizer": "minimum cumulative cost per attainable sorted load vector",
        "independent_enumerator": "all labelled recipient sequences, including tail goods",
        "four_agent_range": {"input_length": [1, 5], "input_values": [1, 4],
                             "orders": "all", "total": "even"},
        "five_six_agent_range": {"input_length": [1, 4], "input_values": [1, 5],
                                  "orders": "nondecreasing", "total": "even"},
        "dp_statistics_by_agents": stats,
        "zero_tail_instances_checked": len(suite),
        "strictly_positive_instances_checked": len(suite),
        "additional_large_integer_instances_per_construction": 6,
        "terminal_inequality": "n * (C - M*T) >= M*R",
        "positive_conversion": "B=r(r+1)/2; Q=2B+1; K_positive=Q*M*T+B",
        "assignment_checks": exhaustive,
        "all_labelled_assignments_checked": sum(row["assignments_checked"] for row in exhaustive),
        "boundary_checks": boundary,
        "suite_sha256": hashlib.sha256(encoded_suite).hexdigest(),
        "verifier_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }
    rendered = json.dumps(certificate, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(rendered, encoding="utf-8")
    print(rendered, end="")


if __name__ == "__main__":
    main()
