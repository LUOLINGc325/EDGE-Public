#!/usr/bin/env python3
"""Exact primal/dual checks for the secondary theorem's degenerate example.

No routing vertices or LP bases are enumerated. The example has redundant
server caps, so one optimal solution and dual witness for each objective are
constructed by two row comparisons. The generic checker then verifies their
standard-form primal feasibility, dual feasibility, and exact objective
equality over the rationals. It is a certificate verifier, not a general LP
solver or a stochastic proof.

Usage: python code/check_axis_certificate.py --output results/axis_certificate.json
"""
from __future__ import annotations

import argparse
from fractions import Fraction
import json
from pathlib import Path
from typing import Any, Sequence


def rational(value: Any) -> Fraction:
    if isinstance(value, Fraction):
        return value
    if type(value) is int or isinstance(value, str):
        return Fraction(value)
    raise ValueError("Exact inputs must be integers, Fraction values, or rational strings.")


def dot(left: Sequence[Fraction], right: Sequence[Fraction]) -> Fraction:
    if len(left) != len(right):
        raise ValueError("Dot-product dimension mismatch.")
    return sum((a * b for a, b in zip(left, right)), Fraction(0))


def matrix_rank(A: Sequence[Sequence[Fraction]]) -> int:
    """Exact row elimination, used only for the degeneracy certificate."""
    rows = [list(row) for row in A]
    if not rows or not rows[0] or any(len(row) != len(rows[0]) for row in rows):
        raise ValueError("A must be a nonempty rectangular matrix.")
    rank = 0
    for column in range(len(rows[0])):
        pivot = next((r for r in range(rank, len(rows)) if rows[r][column]), None)
        if pivot is None:
            continue
        rows[rank], rows[pivot] = rows[pivot], rows[rank]
        scale = rows[rank][column]
        rows[rank] = [entry / scale for entry in rows[rank]]
        for row in range(rank + 1, len(rows)):
            scale = rows[row][column]
            rows[row] = [entry - scale * lead for entry, lead in zip(rows[row], rows[rank])]
        rank += 1
        if rank == len(rows):
            break
    return rank


def check_lp_optimality(A, b, c, primal, dual) -> dict[str, Any]:
    """Verify max c.z subject to A.z=b,z>=0, and min b.y subject to A^T.y>=c.

    The equality-constraint dual vector y is unrestricted in sign. Slack
    columns in A enforce the signs required by original inequality rows.
    """
    A = [[rational(x) for x in row] for row in A]
    b, c, primal, dual = ([rational(x) for x in v] for v in [b, c, primal, dual])
    if not A or not A[0] or any(len(row) != len(A[0]) for row in A):
        raise ValueError("A must be nonempty and rectangular.")
    m, n = len(A), len(A[0])
    if (len(b), len(c), len(primal), len(dual)) != (m, n, n, m):
        raise ValueError("Certificate dimension mismatch.")
    primal_residual = [dot(row, primal) - rhs for row, rhs in zip(A, b)]
    dual_slack = [dot([A[i][j] for i in range(m)], dual) - c[j] for j in range(n)]
    primal_value, dual_value = dot(c, primal), dot(b, dual)
    feasible_primal = all(x >= 0 for x in primal) and all(x == 0 for x in primal_residual)
    feasible_dual = all(x >= 0 for x in dual_slack)
    return {
        "primal": list(map(str, primal)), "dual": list(map(str, dual)),
        "objective": list(map(str, c)),
        "primal_residual": list(map(str, primal_residual)),
        "dual_slack": list(map(str, dual_slack)),
        "primal_feasible": feasible_primal, "dual_feasible": feasible_dual,
        "primal_value": str(primal_value), "dual_value": str(dual_value),
        "duality_gap": str(dual_value - primal_value),
        "optimality_certified": feasible_primal and feasible_dual and primal_value == dual_value,
    }


A = [[1, 1, 0, 0, 0, 0], [0, 0, 1, 1, 0, 0],
     [1, 0, 1, 0, 1, 0], [0, 1, 0, 1, 0, 1]]
B = [Fraction(1, 2), Fraction(1, 2), Fraction(1), Fraction(1)]
VERTEX = [Fraction(1, 2), Fraction(0), Fraction(1, 2), Fraction(0), Fraction(0), Fraction(1)]
CENTER = [Fraction(4, 5), Fraction(1, 5), Fraction(7, 10), Fraction(1, 10)]


def example_witness(objective: Sequence[Fraction]):
    """One primal and dual witness from two row comparisons, no enumeration."""
    z = [Fraction(0) for _ in range(6)]
    y = [Fraction(0) for _ in range(4)]
    for i in range(2):
        chosen = 2 * i + int(objective[2 * i + 1] > objective[2 * i])
        z[chosen] = Fraction(1, 2)
        y[i] = max(objective[2 * i], objective[2 * i + 1])
    z[4] = 1 - z[0] - z[2]
    z[5] = 1 - z[1] - z[3]
    return z, y


def check_axis_box(radius: Fraction):
    if radius < 0:
        raise ValueError("Radii must be nonnegative.")
    edge_count = len(CENTER)
    axes = []
    for edge in range(edge_count):
        for sign in [-1, 1]:
            objective = list(CENTER)
            objective[edge] += sign * edge_count * radius
            objective += [Fraction(0), Fraction(0)]
            z, y = example_witness(objective)
            certificate = check_lp_optimality(A, B, objective, z, y)
            assert certificate["optimality_certified"]
            candidate_value = dot(objective, VERTEX)
            optimal_value = Fraction(certificate["primal_value"])
            axes.append({"edge_index": edge, "sign": sign,
                         "candidate_value": str(candidate_value),
                         "candidate_gap": str(optimal_value - candidate_value),
                         "candidate_optimal": candidate_value == optimal_value,
                         "lp_certificate": certificate})
    return {
        "center": list(map(str, CENTER)), "radii": [str(radius)] * edge_count,
        "axis_objective_count": len(axes),
        "accepted": all(row["candidate_optimal"] for row in axes), "axes": axes,
    }


def exposure_certificate():
    """Exact optimum of the max-min exposure LP, plus its simplex witness."""
    maxima = []
    coordinate_certificates = []
    for edge in range(4):
        objective = [Fraction(int(i == edge)) for i in range(4)]
        z, y = example_witness(objective)
        result = check_lp_optimality(A, B, objective + [Fraction(0), Fraction(0)], z, y)
        assert result["optimality_certified"]
        maxima.append(Fraction(result["primal_value"]))
        coordinate_certificates.append(result)
    assert maxima == [Fraction(1, 2)] * 4

    # Variables: q11,q12,q21,q22,s1,s2,eta,t11,t12,t21,t22 >= 0.
    # Exposure inequalities q_e >= eta*m_e become q_e-eta*m_e-t_e=0.
    exposure_A = [[Fraction(x) for x in row] + [Fraction(0)] * 5 for row in A]
    for edge in range(4):
        row = [Fraction(0)] * 11
        row[edge], row[6], row[7 + edge] = Fraction(1), -maxima[edge], Fraction(-1)
        exposure_A.append(row)
    exposure_b = B + [Fraction(0)] * 4
    exposure_c = [Fraction(int(i == 6)) for i in range(11)]
    exposure_z = [Fraction(1, 4)] * 4 + [Fraction(1, 2)] * 3 + [Fraction(0)] * 4
    exposure_y = [Fraction(1), Fraction(0), Fraction(0), Fraction(0),
                  Fraction(-1), Fraction(-1), Fraction(0), Fraction(0)]
    exact_lp = check_lp_optimality(exposure_A, exposure_b, exposure_c, exposure_z, exposure_y)
    assert exact_lp["optimality_certified"] and Fraction(exact_lp["primal_value"]) == Fraction(1, 2)

    eta = Fraction(exact_lp["primal_value"])
    kappa = 1 / eta
    p = [Fraction(1, 2), Fraction(1, 2), Fraction(0), Fraction(0)]
    coefficient = [weight / maximum for weight, maximum in zip(p, maxima)]
    assert coefficient == [Fraction(1), Fraction(1), Fraction(0), Fraction(0)]
    assert sum(p, Fraction(0)) == 1 and all(x >= 0 for x in p)
    assert [exposure_z[e] / maxima[e] for e in range(4)] == [eta] * 4
    return {
        "coordinate_maxima": list(map(str, maxima)),
        "coordinate_maximum_certificates": coordinate_certificates,
        "standard_form_variables": ["q11", "q12", "q21", "q22", "s1", "s2", "eta", "t11", "t12", "t21", "t22"],
        "standard_form_A": [[str(x) for x in row] for row in exposure_A],
        "standard_form_b": list(map(str, exposure_b)),
        "standard_form_certificate": exact_lp,
        "eta_star": str(eta), "kappa": str(kappa),
        "nonnegative_eta_restriction": "Harmless for this optimum: a feasible positive eta attains the same global upper bound eta <= 1/2.",
        "elementary_upper_bound": "q11+q12=1/2 and q11,q12 >= eta/2 imply eta <= 1/2.",
        "minimax_certificate": {
            "simplex_weights": list(map(str, p)),
            "weighted_objective_coefficients": list(map(str, coefficient)),
            "value_for_every_feasible_q": "1/2",
            "reason": "sum_e p_e*q_e/m_e = q11+q12 = 1/2; the proposed q has q_e/m_e=1/2 on every edge.",
        },
        "nonconstant_K_coefficient_ratio_to_M_bound": str(kappa / len(CENTER)),
    }


def build_certificate():
    rank = matrix_rank([[Fraction(x) for x in row] for row in A])
    positive_support = [i for i, x in enumerate(VERTEX) if x > 0]
    support_rank = matrix_rank([[Fraction(row[i]) for i in positive_support] for row in A])
    assert rank == 4 and len(positive_support) == support_rank == 3
    center_z, center_y = example_witness(CENTER)
    center = check_lp_optimality(A, B, CENTER + [Fraction(0), Fraction(0)], center_z, center_y)
    assert center["optimality_certified"] and center_z == VERTEX
    assert Fraction(center["primal_value"]) == Fraction(3, 4)
    row_advantages = [CENTER[2*i] - CENTER[2*i+1] for i in range(2)]
    assert row_advantages == [Fraction(3, 5), Fraction(3, 5)]

    narrow = check_axis_box(Fraction(1, 100))
    assert narrow["accepted"] and narrow["axis_objective_count"] == 8

    wide = check_axis_box(Fraction(1, 2))
    assert not wide["accepted"]
    # This is inside the clipped original box, not merely an outside axis point.
    false_objective = [Fraction(3, 10), Fraction(7, 10), Fraction(7, 10), Fraction(1, 10)]
    assert all(abs(a - c) <= Fraction(1, 2) and 0 <= c <= 1 for a, c in zip(CENTER, false_objective))
    false_z, false_y = example_witness(false_objective)
    false_certificate = check_lp_optimality(A, B, false_objective + [Fraction(0), Fraction(0)], false_z, false_y)
    gain = Fraction(false_certificate["primal_value"]) - dot(false_objective, VERTEX[:4])
    assert false_certificate["optimality_certified"] and gain == Fraction(1, 5)

    medium = check_axis_box(Fraction(1, 5))
    assert not medium["accepted"]
    # Each row prefers server 1 throughout this smaller original box, although
    # some cross-polytope vertices fall outside it and make the axis test fail.
    worst_row_advantages = [CENTER[2*i] - CENTER[2*i+1] - 2 * Fraction(1, 5) for i in range(2)]
    assert worst_row_advantages == [Fraction(1, 5), Fraction(1, 5)]
    return {
        "schema": "exact-degenerate-axis-certificate/v1",
        "scope": "Exact LP certificates for the secondary theorem's S6 example and S5 exposure calculation; no stochastic or full Lean proof.",
        "arithmetic": "Python fractions.Fraction; exact primal/dual equalities and rational row elimination.",
        "enumerates_routing_vertices": False, "enumerates_lp_bases": False,
        "all_checks_passed": True,
        "standard_form": {"A": A, "b": list(map(str, B)),
                          "variables": ["x11", "x12", "x21", "x22", "s1", "s2"],
                          "candidate": list(map(str, VERTEX))},
        "degeneracy": {"equality_matrix_rank": rank, "positive_support_indices": positive_support,
                       "positive_support_size": len(positive_support),
                       "positive_support_column_rank": support_rank,
                       "vertex_certified_by_independent_support_columns": True,
                       "every_representing_basis_degenerate": len(positive_support) < rank,
                       "reason": "A standard-form basic solution has four basic variables, but this feasible vertex has only three positive coordinates."},
        "center_optimum": center,
        "center_unique_optimum": {"row_advantages": list(map(str, row_advantages)),
                                  "unique": all(x > 0 for x in row_advantages)},
        "narrow_box_acceptance": narrow,
        "false_box_rejection": {"axis_test": wide,
                                "original_clipped_box_counterexample": false_certificate,
                                "improvement_over_candidate": str(gain),
                                "inside_original_clipped_box": True},
        "conservative_rejection": {"axis_test": medium,
                                   "candidate_robust_over_original_box": True,
                                   "worst_row_advantages": list(map(str, worst_row_advantages)),
                                   "meaning": "The axis enclosure test is sufficient, not necessary, for robustness over the original box."},
        "optimal_edge_exposure": exposure_certificate(),
        "limits": ["Each objective's optimality is checked with its own primal and dual witness; a common basis is never required.",
                   "The example-specific witness construction uses redundant capacities; the generic certificate checker does not solve arbitrary LPs.",
                   "Passing eight objectives is an algebraic example check. General box containment and eventual statistical success require the written proof."]
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results" / "axis_certificate.json")
    args = parser.parse_args()
    result = build_certificate()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({"all_checks_passed": True, "narrow_box_axes": 8,
                      "false_box_rejected": True, "matrix_rank": 4,
                      "positive_support_size": 3, "output": str(args.output)}))


if __name__ == "__main__":
    main()
