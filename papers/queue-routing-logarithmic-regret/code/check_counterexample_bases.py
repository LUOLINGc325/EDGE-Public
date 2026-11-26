"""Reproduce the counterexample's exact LP and source-slack checks.

Only algebra and recorded source provenance are checked here. This script is
not a certificate for the stochastic policy, concentration, or convergence proof.
No paper text or paper binary is included in the output.

Usage:
    python code/check_counterexample_bases.py
    python code/check_counterexample_bases.py --output lp_certificate.json
"""

import argparse
from itertools import combinations
import json
from pathlib import Path

from sympy import Matrix, Rational


def enumerate_primal(arrival, capacity):
    """All nonsingular standard-form bases, retaining the feasible ones."""
    matrix = Matrix([
        [1, 1, 0, 0, 0, 0],
        [0, 0, 1, 1, 0, 0],
        [1, 0, 1, 0, 1, 0],
        [0, 1, 0, 1, 0, 1],
    ])
    rhs = Matrix([*arrival, *capacity])
    names = ["x11", "x12", "x21", "x22", "s1", "s2"]
    feasible = []
    for basis in combinations(range(6), 4):
        basic_matrix = matrix[:, basis]
        if basic_matrix.det() == 0:
            continue
        values = basic_matrix.inv() * rhs
        if any(value < 0 for value in values):
            continue
        solution = [Rational(0)] * 6
        for index, value in zip(basis, values):
            solution[index] = value
        feasible.append({
            "basis": [names[index] for index in basis],
            "solution": [str(value) for value in solution],
            "nondegenerate": all(value > 0 for value in values),
        })
    return feasible


def build_certificate():
    arrival = [Rational(2, 5), Rational(3, 5)]
    service = [Rational(3), Rational(3)]
    epsilon = Rational(1)
    primal_zero = enumerate_primal(arrival, service)
    primal = enumerate_primal(arrival, [value - epsilon for value in service])

    # Dual G z >= h with z = (v1,v2,w1,w2); v coordinates are unrestricted.
    matrix = Matrix([
        [1, 0, 1, 0],
        [1, 0, 0, 1],
        [0, 1, 1, 0],
        [0, 1, 0, 1],
        [0, 0, 1, 0],
        [0, 0, 0, 1],
    ])
    rhs = Matrix([4, 1, 2, 3, 0, 0])
    dual = []
    for active in combinations(range(6), 4):
        basic_matrix = matrix[list(active), :]
        if basic_matrix.det() == 0:
            continue
        solution = basic_matrix.inv() * rhs[list(active), :]
        slack = matrix * solution - rhs
        if any(value < 0 for value in slack):
            continue
        all_active = [index for index, value in enumerate(slack) if value == 0]
        dual.append({
            "solution": [str(value) for value in solution],
            "active_constraints": all_active,
            "active_rank": matrix[all_active, :].rank(),
            "nondegenerate": len(all_active) == 4,
        })

    # Source Eq. (12) is checked for EVERY feasible basis at epsilon = 0.
    # In these forests both servers are roots and each type has one parent.
    # Thus each server subtree contains that server alone and its assigned
    # types; the denominator |S(subtree)| is exactly 1.
    slack_checks = []
    for row in primal_zero:
        basis = set(row["basis"])
        assert {"s1", "s2"}.issubset(basis)
        assert sum(name in basis for name in ["x11", "x12"]) == 1
        assert sum(name in basis for name in ["x21", "x22"]) == 1
        bounds = []
        for server in [1, 2]:
            types = [customer for customer in [1, 2]
                     if f"x{customer}{server}" in basis]
            subtree_arrival = sum((arrival[customer - 1] for customer in types), Rational(0))
            bound = service[server - 1] - subtree_arrival
            bounds.append(bound)
            slack_checks.append({
                "basis": row["basis"],
                "root_server": server,
                "subtree_servers": [server],
                "subtree_customer_types": types,
                "subtree_arrival": str(subtree_arrival),
                "subtree_service": str(service[server - 1]),
                "denominator_server_count": 1,
                "eq12_upper_bound": str(bound),
                "epsilon_strictly_below_bound": bool(epsilon < bound),
            })
        assert epsilon < min(bounds)

    assert len(primal_zero) == len(primal) == 4
    assert [row["basis"] for row in primal_zero] == [row["basis"] for row in primal]
    assert len(dual) == 3
    assert all(row["nondegenerate"] for row in primal_zero + primal + dual)
    assert all(row["active_rank"] == 4 for row in dual)
    minimum_bound = min(Rational(row["eq12_upper_bound"]) for row in slack_checks)
    assert minimum_bound == 2

    theta = [Rational(4), Rational(1), Rational(2), Rational(3)]
    q0 = [Rational(1, 5), Rational(1, 5), Rational(3, 10), Rational(3, 10)]
    values = [sum((weight * Rational(value) for weight, value in zip(theta, row["solution"][:4])), Rational(0))
              for row in primal]
    optimum = max(values)
    reference_value = sum((weight * value for weight, value in zip(theta, q0)), Rational(0))
    assert optimum == Rational(17, 5)
    assert values.count(optimum) == 1
    assert reference_value == Rational(5, 2)
    dual_optimum = [Rational(4), Rational(3), Rational(0), Rational(0)]
    reduced = matrix[:4, :] * Matrix(dual_optimum) - rhs[:4, :]
    assert list(reduced) == [0, 3, 1, 0]

    return {
        "scope": "exact LP, graph and source Eq. (12) audit only; not a stochastic proof certificate",
        "arithmetic": "exact rational arithmetic with SymPy",
        "parameters": {
            "lambda": ["2/5", "3/5"], "mu": ["3", "3"],
            "epsilon": "1", "theta0": [["4", "1"], ["2", "3"]],
            "x0": [["2/5", "0"], ["0", "3/5"]],
            "q0": [["1/5", "1/5"], ["3/10", "3/10"]],
        },
        "graph": {"I": 2, "J": 2, "L": 4, "connected": True,
                  "strict_edge_condition": 4 > 2 + 2 - 1},
        "primal_at_epsilon_zero": primal_zero,
        "primal_at_epsilon_one": primal,
        "dual_at_theta0": dual,
        "all_primal_bfs_nondegenerate": True,
        "all_dual_vertices_nondegenerate": True,
        "source_eq12": {
            "location": "van Kempen et al. (2026), Section 2.3.2, Lemma 3, equation (12)",
            "doi": "10.1287/stsy.2024.0095",
            "url": "https://pubsonline.informs.org/doi/10.1287/stsy.2024.0095",
            "formula": "epsilon < min_j (sum_{l in S(subtree_j)} mu_l - sum_{k in C(subtree_j)} lambda_k) / |S(subtree_j)|",
            "per_basis_subtree_checks": slack_checks,
            "minimum_over_all_feasible_zero_slack_bases": str(minimum_bound),
            "chosen_epsilon": "1",
            "strict_inequality_verified": True,
            "feasible_basis_sets_unchanged": True,
        },
        "objective_checks": {
            "all_vertex_values": [str(value) for value in values],
            "optimal_value": str(optimum),
            "unique_optimal_vertex": values.count(optimum) == 1,
            "q0_value": str(reference_value),
            "q0_instantaneous_loss": str(optimum - reference_value),
            "inactive_edge_reduced_costs": {"x12": str(reduced[1]), "x21": str(reduced[2])},
        },
        "source_snapshot_hashes": [
            {
                "id": "published-main-pdf",
                "url": "https://pubsonline.informs.org/doi/pdf/10.1287/stsy.2024.0095",
                "bytes": 3501685,
                "sha256": "df656bf3a8a7ed7828b21a8fd536ff144540b3d3f973afd5747f1b5e13b3f2cf",
                "format_checked": "PDF-1.6",
            },
            {
                "id": "author-hosted-preprint-pdf",
                "url": "https://pure.tue.nl/ws/portalfiles/portal/352800778/2412.10168v1.pdf",
                "bytes": 1159923,
                "sha256": "1bd1e7f8197ff4d41bc3b10e5448c665495b70fd201b32e840381223a5c529fa",
                "format_checked": "PDF-1.5",
            },
            {
                "id": "official-supplement-web-extraction",
                "url": "https://pubsonline.informs.org/doi/suppl/10.1287/stsy.2024.0095/suppl_file/stsy.2024.0095.sm1.pdf",
                "bytes": 17429,
                "sha256": "5aa426d699c16a7f9911df47dd9de826ac2381507ffd2066f45bdf81847b3851",
                "format_checked": "local JSON extraction, not the original PDF bytes",
            },
        ],
        "provenance_note": "Hashes identify locally inspected source snapshots; copyrighted source contents are not reproduced in this package.",
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results" / "exact_lp_certificate.json")
    args = parser.parse_args()
    certificate = build_certificate()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(certificate, indent=2) + "\n")
    print(f"Verified 4 primal bases at each slack, 3 dual vertices, and epsilon=1 < Eq.12 bound=2; wrote {args.output}.")
