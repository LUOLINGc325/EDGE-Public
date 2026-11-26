#!/usr/bin/env python3
"""Exact arithmetic for the proved horizon-cutoff schedule, not a large LP solve.

Only the standard library is needed.  The large-horizon proof is in the
manuscript; this program checks its numeric schedules and combines the
explicit policy certificate with an existing exact finite upper witness.
It does not label uncomputed LP optima as certified numbers.
"""
from __future__ import annotations
import argparse
from fractions import Fraction as Q
import hashlib
import json
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent

def qjson(x):
    return {"numerator": str(x.numerator), "denominator": str(x.denominator),
            "decimal_display_only": float(x)}

def ceilq(x):
    return -((-x.numerator) // x.denominator)

def exp_minus_unit_interval(x, odd_degree=61):
    """Alternating Taylor enclosure for exp(-x), 0 <= x <= 1."""
    if not (Q(0) <= x <= Q(1)) or odd_degree < 1 or odd_degree % 2 != 1:
        raise ValueError("require x in [0,1] and a positive odd truncation")
    term = total = Q(1)
    for k in range(1, odd_degree + 1):
        term *= -x / k
        total += term
    lower = total
    upper = total + term * -x / (odd_degree + 1)
    assert Q(0) <= lower <= upper <= Q(1)
    return lower, upper

def schedule(epsilon):
    """Reserve epsilon/2 for horizon error and epsilon/2 for quantile LP error."""
    if not Q(0) < epsilon < Q(1):
        raise ValueError("epsilon must be in (0,1)")
    rate = 1
    while Q(2) ** rate < Q(4) / epsilon:
        rate += 1
    horizon = ceilq(Q(16 * rate * rate * (rate + 2)) / epsilon)
    labels = max(1, ceilq(Q(3 * (horizon - 1)) / epsilon))
    elo, ehi = exp_minus_unit_interval(Q(1))
    exp_rate_upper = ehi ** rate
    positive_denominator_lower = 1 - exp_rate_upper
    delta_upper = Q(rate * rate * (rate + 2), horizon) / positive_denominator_lower
    horizon_error_upper = exp_rate_upper + 2 * delta_upper
    quantile_error = Q(3 * (horizon - 1), 2 * labels)
    assert horizon >= rate >= 1
    assert exp_rate_upper <= epsilon / 4
    assert delta_upper <= epsilon / 8
    assert horizon_error_upper <= epsilon / 2
    assert quantile_error <= epsilon / 2
    assert horizon_error_upper + quantile_error <= epsilon
    return {
        "requested_total_width": qjson(epsilon),
        "poisson_rate_integer": rate, "single_horizon_N": horizon,
        "quantile_labels_m": labels,
        "variables_per_LP": 2 * horizon * labels,
        "inequalities_per_LP_excluding_box": labels - 1 + 2 * horizon * labels,
        "equalities_per_LP": 1 + (horizon - 1) * labels,
        "horizon_error_upper": qjson(horizon_error_upper),
        "quantile_error_upper": qjson(quantile_error),
        "large_LPs_solved": False,
        "meaning": "A sufficient finite schedule guaranteed by the written theorem, not computed LP values."
    }

def sparse_schedule(epsilon):
    """Theorem 6: exact-optimum analytic width, with active labels only.

    The displayed count is not bit complexity. Rational coefficients contain
    N-th powers. Approximate LP optima require an additional verified gap.
    """
    if not Q(0) < epsilon < Q(1):
        raise ValueError("epsilon must be in (0,1)")
    rate = 1
    while Q(2) ** rate < Q(3) / epsilon:
        rate += 1
    horizon = ceilq(Q(3 * rate * rate * (rate + 2)) / epsilon)
    labels = ceilq(Q(9 * rate, 2) / epsilon)
    quantile = Q(3 * rate, 2 * labels)
    missing_tail = Q(1, 2 ** rate)
    coupling = Q(rate * rate * (rate + 2), horizon)
    total = quantile + missing_tail + coupling
    assert horizon >= rate >= 1 and labels >= 1
    assert max(quantile, missing_tail, coupling) <= epsilon / 3
    assert total <= epsilon
    return {
        "requested_exact_optima_width": qjson(epsilon),
        "poisson_rate_integer": rate, "horizon_N": horizon,
        "active_labels_m": labels,
        "variables_per_LP": horizon * (2 * labels + 1),
        "inequalities_per_LP_excluding_box": labels - 1 + 2 * horizon * labels,
        "equalities_per_LP": 1 + horizon + (horizon - 1) * labels,
        "coefficient_integer_bit_upper_bound": horizon * (horizon * labels).bit_length() + 2,
        "quantile_width_bound": qjson(quantile),
        "tail_error_bound": qjson(missing_tail),
        "coupling_error_bound": qjson(coupling),
        "total_analytic_width_bound": qjson(total),
        "large_LPs_solved": False,
        "additional_solver_gap_included": False,
        "meaning": "Finite rational LP schedule only; count is variables, not total bit encoding or a claim of practical runtime."
    }

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path,
                        default=ROOT / "results/horizon_schedule_certificate.json")
    args = parser.parse_args()
    source = ROOT / "results/finite_candidate_exact_lp_n100_m30.json"
    witness = json.loads(source.read_text())
    rec = Q(int(witness["record_value_numerator"]))
    prophet = Q(int(witness["prophet_value_numerator"]))
    upper = rec / prophet
    elo, ehi = exp_minus_unit_interval(Q(1))
    lower = 1 - ehi
    assert lower > Q(6321, 10000)
    assert upper < Q(18, 25)
    assert lower < upper
    policy_path = ROOT / "results/sparse_policy_certificate.json"
    policy = json.loads(policy_path.read_text())
    endpoint = policy["claims"]["all_horizon_ratio_lower"]
    policy_lower = Q(int(endpoint["numerator"]), int(endpoint["denominator"]))
    assert policy_lower > Q(6817, 10000) and policy_lower < upper
    result = {
        "schema": "record-global-horizon-schedule-v2",
        "arithmetic": "Python Fraction; alternating rational Taylor enclosure",
        "proof_dependency": "Written all-horizon theorem, causal coupling, quantile transfer and the explicit policy certificate",
        "whole_theorem_machine_formalized": False,
        "existing_actual_global_interval": {
            "lower": qjson(policy_lower), "upper": qjson(upper),
            "lower_origin": "Exact downward-rounded explicit sparse-policy certificate plus the written global transfer theorem.",
            "lower_certificate_sha256": hashlib.sha256(policy_path.read_bytes()).hexdigest(),
            "classical_baseline_lower": qjson(lower),
            "upper_origin": "Exact n=100,m=30 all-record-policy witness",
            "upper_witness_sha256": hashlib.sha256(source.read_bytes()).hexdigest(),
            "lower_priority_claimed": False,
            "sharp_global_constant_identified": False
        },
        "full_quantile_schedules": [schedule(Q(1, d)) for d in [10, 100, 1000]],
        "active_label_schedules": [sparse_schedule(Q(1, d)) for d in [10, 100, 1000]],
        "implementation_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n")
    print("Exact global policy/witness interval:", float(policy_lower), float(upper))
    for row in result["active_label_schedules"]:
        print("epsilon", row["requested_exact_optima_width"]["decimal_display_only"],
              "N", row["horizon_N"], "m", row["active_labels_m"],
              "variables/LP", row["variables_per_LP"], "(not solved)")
    print("PASS: all stated error schedules checked by rational arithmetic.")

if __name__ == "__main__":
    main()
