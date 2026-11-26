#!/usr/bin/env python3
"""Exact certificate for the unit-demand boundary of the replenishment theorem.

This is a finite certificate for an INFINITE-state discounted model, not a
truncated Markov chain.  The proof of why every target outside the finite set
is strictly dominated is included in COMPOUND_DEMAND_BOUNDARY.md.

Standard library only.  No floating-point arithmetic and no proof assistant.
"""

from fractions import Fraction as Q
from pathlib import Path
import argparse
import json


LAMBDA = Q(1)
MU = Q(1, 10)
ALPHA = Q(1)
H = Q(1)
B = Q(40)
K = Q(15)
K_CHEAP = Q(1)
DEMAND_SIZE = 2
CAPACITY = 3
D = LAMBDA + MU + ALPHA
GAMMA = (LAMBDA + MU) / D
C = K + LAMBDA * K / ALPHA


def cost(x):
    return H * max(x, 0) + B * max(-x, 0)


def fee(x, r, y):
    if y <= x:
        return Q(0)
    if y <= x + r:
        return K_CHEAP
    return K


def exact_value(x):
    """Candidate G on the finite target set I = {-1,0,...,63}."""
    values = {
        -1: Q(1213, 42),
        0: Q(59, 6),
        1: Q(5173, 504),
        2: Q(71, 12),
        3: Q(179, 28),
        4: Q(119, 24),
        5: Q(913, 168),
    }
    if x in values:
        return values[x]
    if x >= 6:
        return (H * x + (LAMBDA + MU) * Q(119, 24)) / D
    raise ValueError("Exact finite certificate is defined only on I")


def as_string(q):
    return str(q)


def verify():
    assert 0 < ALPHA and 0 < LAMBDA and 0 < MU
    assert 0 < H and 0 < B and 0 <= K_CHEAP <= K
    assert C == 30 and D * C == 63 and GAMMA == Q(11, 21)

    # Exact, analytically justified target set; no reflecting or absorbing edge.
    targets = list(range(-1, 64))
    assert all(cost(y) <= D * C for y in targets)
    assert cost(-2) > D * C and cost(64) > D * C
    # The running cost grows linearly farther out on each side, so those two
    # strict inequalities prove that EVERY outside integer has cost(y)/D > C.

    values = {y: exact_value(y) for y in targets}

    def predecision(x, r):
        competing = {y: fee(x, r, y) + values[y] for y in targets}
        optimum = min(competing.values())
        minimizers = [y for y in targets if competing[y] == optimum]
        return optimum, minimizers

    g = min(values.values())
    assert g == Q(119, 24)
    assert [x for x in targets if values[x] == g] == [4]
    assert K + g < C
    assert all(v >= 0 for v in values.values())

    # Every action target in I is checked.  Demand states below I are evaluated
    # with their ACTUAL inventories x-2, never clipped to I's lower endpoint.
    rows = []
    for x in targets:
        vd, yd = predecision(x - DEMAND_SIZE, 0)
        vo, yo = predecision(x, CAPACITY)
        rhs = (cost(x) + LAMBDA * vd + MU * vo) / D
        assert values[x] == rhs, (x, values[x], rhs)
        rows.append({
            "postdecision_state": x,
            "G": as_string(values[x]),
            "demand_predecision_state": x - DEMAND_SIZE,
            "demand_value": as_string(vd),
            "demand_optimal_targets": yd,
            "offer_value": as_string(vo),
            "offer_optimal_targets": yo,
            "bellman_residual": "0",
        })

    # The queried state is above the regular reorder point, and its offered
    # capacity is insufficient to reach the unique global minimizer S=4.
    x, r = 0, 3
    optimum, optimal_targets = predecision(x, r)
    every_action = [
        {"target": y, "quantity": y - x, "charge": as_string(fee(x, r, y)),
         "total_value": as_string(fee(x, r, y) + values[y])}
        for y in targets
    ]
    wait_value = values[0]
    free_value = min(values[y] for y in targets if y <= x)
    discount_values = {q: K_CHEAP + values[x + q] for q in (1, 2, 3)}
    regular_value = min(K + values[y] for y in targets if y > x + r)
    assert optimum == Q(83, 12)
    assert optimal_targets == [2]
    assert free_value == wait_value == Q(59, 6)
    assert regular_value == Q(479, 24)
    assert discount_values[3] - discount_values[2] == Q(10, 21)
    assert wait_value - optimum == Q(35, 12)
    assert regular_value - optimum == Q(313, 24)
    assert discount_values[1] > discount_values[3] > discount_values[2]

    # s=-1: regular replenishment is strictly optimal there, while at 0 it is
    # strictly suboptimal.  All more negative states have higher running cost.
    assert predecision(-1, 0) == (K + g, [4])
    assert predecision(0, 0) == (values[0], [0])
    # With an unconstrained cheap offer the can-order point is c=1.  At x=3,
    # free disposal to 2 is cheaper than either waiting or ordering to S.
    assert min(values[0], values[1]) > K_CHEAP + g
    assert values[2] < K_CHEAP + g
    assert predecision(3, 3) == (values[2], [2])

    return {
        "certificate": "infinite-state compound-demand strict partial-fill counterexample",
        "arithmetic": "Python standard-library Fraction; exact rational identities",
        "formal_verification": False,
        "parameters": {
            "lambda": "1", "mu": "1/10", "alpha": "1", "h": "1",
            "b": "40", "regular_setup_K": "15", "discount_setup_k": "1",
            "deterministic_demand_size": 2, "deterministic_offer_capacity": 3,
        },
        "infinite_state_space": "all integers; free disposal is allowed",
        "finite_reduction": {
            "bounded_value_C": as_string(C),
            "event_denominator_d": as_string(D),
            "discount_gamma": as_string(GAMMA),
            "target_set": {"lower_inclusive": -1, "upper_inclusive": 63},
            "target_count": len(targets),
            "condition": "c(y) <= d*C = 63",
            "outside_exclusion": "c(y)/d > C for every y <= -2 or y >= 64",
            "available_reference_action": "target S=4, total value <= K+g=479/24 < C",
            "boundary_handling": "actual outside predecision states; all targets minimized over I",
            "uniqueness": "exact finite Bellman contraction, modulus 11/21",
        },
        "shape": {"unique_global_minimizer_S": 4, "minimum_g": as_string(g),
                  "regular_reorder_s": -1, "unconstrained_cheap_can_order_c": 1},
        "strict_counterexample": {
            "state": {"inventory_x": x, "offer_capacity_r": r},
            "unique_optimal_quantity": 2,
            "optimal_value": as_string(optimum),
            "free_or_wait_value": as_string(free_value),
            "discount_values": {str(q): as_string(v) for q, v in discount_values.items()},
            "best_regular_value": as_string(regular_value),
            "full_capacity_excess_cost": "10/21",
            "unused_capacity_units": 1,
            "all_finite_action_values": every_action,
        },
        "bellman_checks": rows,
        "all_checks_passed": True,
        "proof_scope": "Only the extension to demand batches of size two is refuted; the original unit-demand conjecture is unaffected.",
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).with_suffix(".json"))
    args = parser.parse_args()
    report = verify()
    args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"all_checks_passed": True, "target_count": 65,
                      "unique_optimal_quantity": 2, "full_capacity_excess_cost": "10/21",
                      "output": str(args.output)}, ensure_ascii=False))
