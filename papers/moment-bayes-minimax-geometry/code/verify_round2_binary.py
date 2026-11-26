#!/usr/bin/env python3
"""Exact unequal-prior endpoint and raw-dual certificates for round two.

The general statements and nonattainment proofs are in
secondary/round2/binary_and_multiclass.zh.md. This script verifies finite
rational instances and displayed polynomial identities only.
"""
from __future__ import annotations
import argparse
import hashlib
import json
import platform
from pathlib import Path
import sympy as sp
from moment_certificate import (
    R, add_atom, atomic_moment, bayes_error, canonical_blocks, check_dual,
    exact_psd_decomposition, moment_matrix, objective, realize_blocks,
)


def matrix_json(matrix):
    return [[str(v) for v in row] for row in matrix.tolist()]


def measure_json(measure):
    return [{"point": [str(v) for v in point], "mass": str(mass)} for point, mass in sorted(measure.items())]


def verify_class_measures(moments, measures):
    for target, measure in zip(moments, measures):
        assert atomic_moment(measure, target.rows - 1) == target
    return bayes_error(measures)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=Path("results/round2_binary_certificate.json"))
    args = parser.parse_args()
    p, q = R(1, 3), R(2, 3)
    e00 = sp.diag(1, 0)
    moments_a = [moment_matrix(p, [0], [[0]]), moment_matrix(q, [1], [[1]])]
    measures_a = [{}, {}]
    add_atom(measures_a[0], [0], p)
    add_atom(measures_a[1], [0], p)
    add_atom(measures_a[1], [2], q - p)
    risk_a = verify_class_measures(moments_a, measures_a)
    assert risk_a == p
    exact_psd_decomposition(moments_a[1] - moments_a[0])
    saturation_a = (q - p) * sp.Matrix([[1]]) - p * sp.Matrix([[-1]]) * sp.Matrix([[-1]]).T
    assert saturation_a == sp.zeros(1)

    moments_b = [moment_matrix(p, [0], [[1]]), moments_a[1]]
    difference = moments_b[1] - moments_b[0]
    residual_schur = difference[1:, 1:] - difference[1:, 0] * difference[1:, 0].T / difference[0, 0]
    assert residual_schur == sp.Matrix([[-R(1, 3)]])
    try:
        exact_psd_decomposition(difference)
    except ValueError:
        difference_rejected = True
    else:
        raise AssertionError("An indefinite endpoint remainder was accepted.")
    sequence = []
    for n in [2, 3, 5]:
        t = p * (1 - R(1, n))
        common = t * e00
        blocks = canonical_blocks(moments_b, {(0, 1): common, (0,): moments_b[0] - common, (1,): moments_b[1] - common})
        measures = realize_blocks(moments_b, blocks)
        risk = verify_class_measures(moments_b, measures)
        assert t <= risk < p
        sequence.append({"n": n, "guaranteed_common_mass": str(t), "actual_bayes_error": str(risk), "class_measures": [measure_json(m) for m in measures]})

    moments_c = [moments_a[0], moment_matrix(q, [2], [[1]])]
    t_star = R(2, 15)
    measures_c = [{}, {}]
    add_atom(measures_c[0], [0], p)
    add_atom(measures_c[1], [0], t_star)
    add_atom(measures_c[1], [R(5, 2)], q - t_star)
    risk_c = verify_class_measures(moments_c, measures_c)
    assert risk_c == t_star < p
    common = t_star * e00
    blocks_c = canonical_blocks(moments_c, {(0, 1): common, (0,): moments_c[0] - common, (1,): moments_c[1] - common})
    assert objective(blocks_c) == t_star
    q2_star = sp.Matrix([[1, -R(2, 5)], [-R(2, 5), R(4, 25)]])
    exact_psd_decomposition(q2_star)
    assert sp.trace(q2_star * moments_c[1]) == t_star
    assert q2_star[0, 0] == 1

    # epsilon is positive. The identity is polynomial in the unrestricted x.
    x = sp.symbols("x", real=True)
    eps = sp.symbols("eps", positive=True)
    coefficient = 4 * (1 + eps) / (25 * eps)
    q1_eps = coefficient * x**2
    q2_eps = (1 + eps) * R(4, 25) * (x - R(5, 2))**2
    square_slack = 4 * (1 + eps)**2 / (25 * eps) * (x - 5 * eps / (2 * (1 + eps)))**2
    assert sp.simplify(q1_eps + q2_eps - 1 - square_slack) == 0
    approximants = []
    for epsilon in [R(1), R(1, 3), R(1, 10), R(1, 100)]:
        m = R(4, 25) * (1 + epsilon) / epsilon
        dual = [sp.diag(0, m), (1 + epsilon) * q2_star]
        cost = check_dual(moments_c, dual)
        assert cost == (1 + epsilon) * t_star
        approximants.append({"epsilon": str(epsilon), "M": str(m), "dual_cost": str(cost), "duality_gap": str(cost - t_star), "dual_matrices": [matrix_json(y) for y in dual]})
    q2_polynomial = R(4, 25) * (x - R(5, 2))**2
    assert q2_polynomial.subs(x, 0) == 1
    assert q2_polynomial.subs(x, R(5, 2)) == 0
    assert sp.diff(q2_polynomial, x).subs(x, 0) == -R(4, 5)

    source_path = Path(__file__).resolve()
    result = {
        "status": "PASS",
        "arithmetic": "exact rational SymPy and exact symbolic polynomial identities",
        "scope": "Three unequal-prior finite examples, endpoint residual PSD checks, and explicit approaching full-space dual certificates. General endpoint and nonattainment statements require the accompanying written proofs.",
        "environment": {"python": platform.python_version(), "sympy": sp.__version__},
        "source_sha256": {source_path.name: hashlib.sha256(source_path.read_bytes()).hexdigest(), "moment_certificate.py": hashlib.sha256((source_path.parent / "moment_certificate.py").read_bytes()).hexdigest()},
        "priors": [str(p), str(q)],
        "endpoint_attained": {"moments": [matrix_json(a) for a in moments_a], "saturation_matrix": matrix_json(saturation_a), "endpoint_remainder": matrix_json(moments_a[1] - moments_a[0]), "bayes_error": str(risk_a), "class_measures": [measure_json(m) for m in measures_a]},
        "endpoint_not_attained": {"moments": [matrix_json(a) for a in moments_b], "supremum": str(p), "endpoint_remainder_schur": matrix_json(residual_schur), "indefinite_remainder_rejected": difference_rejected, "approaching_sequence": sequence},
        "interior_attained": {"moments": [matrix_json(a) for a in moments_c], "bayes_error": str(risk_c), "class_measures": [measure_json(m) for m in measures_c], "common_mass_feasibility": "4t <= 2/3 - t, hence t <= 2/15", "reduced_dual_q2": matrix_json(q2_star)},
        "full_space_dual": {"infimum": str(t_star), "attained": False, "nonattainment_scope": "Proved in accompanying text using complementary contact and a nonzero derivative at a global minimum; not inferred from numerical optimization.", "forced_q2_derivative_at_zero": "-4/5", "approximants": approximants, "symbolic_slack_square_verified": True},
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print("PASS: exact unequal-prior endpoint and interior certificates.")
    print("Endpoint attained: p=1/3, variances (0,1), means (0,1), Bayes error=1/3.")
    print("Endpoint not attained: variances (1,1), means (0,1), residual Schur=-1/3.")
    print("Interior attained: variances (0,1), means (0,2), Bayes error=2/15.")
    print("Unreduced dual: explicit feasible costs (1+epsilon)*2/15; limiting nonattainment proof recorded.")
    print(f"Certificate written to {args.output}")


if __name__ == "__main__":
    main()
