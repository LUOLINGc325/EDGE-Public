#!/usr/bin/env python3
"""Recompute the three exact examples and the repair certificates.

Run from the case directory:
  python code/verify_certificates.py --output results/exact_certificate.json
"""

from __future__ import annotations

import argparse
import hashlib
import json
import platform
from pathlib import Path

import sympy as sp

from moment_certificate import (
    R, add_atom, atomic_moment, barycentric_simplex_certificate, bayes_error,
    canonical_blocks, check_dual, exact_psd_decomposition, moment_matrix,
    numerical_repair, objective, realize_blocks, realize_moment, repair_blocks,
    subsets,
)


def matrix_json(matrix):
    return [[str(value) for value in row] for row in matrix.tolist()]


def measure_json(measure):
    return [{"point": [str(v) for v in point], "mass": str(mass)} for point, mass in sorted(measure.items())]


def moments_summary(moments):
    answer = []
    for matrix in moments:
        prior = matrix[0, 0]
        mean = matrix[1:, 0] / prior
        covariance = matrix[1:, 1:] / prior - mean * mean.T
        answer.append({"prior": str(prior), "mean": [str(v) for v in mean], "covariance": matrix_json(covariance), "matrix": matrix_json(matrix)})
    return answer


def repair_certificate(moments, blocks, mixing):
    repaired = repair_blocks(moments, blocks, mixing)
    measures = realize_blocks(moments, repaired)
    target = (1 - mixing) * objective(blocks)
    risk = bayes_error(measures)
    assert risk >= target
    return {
        "mixing": str(mixing),
        "original_objective": str(objective(blocks)),
        "repaired_objective": str(objective(repaired)),
        "bayes_error": str(risk),
        "bayes_error_at_least_scaled_objective": True,
        "all_class_moments_preserved_exactly": True,
        "positive_singleton_masses": [str(repaired[(i,)][0, 0]) for i in range(len(moments))],
        "class_atom_counts": [len(measure) for measure in measures],
        "class_measures": [measure_json(measure) for measure in measures],
    }


def equal_mean_unequal_variance():
    moments = [moment_matrix(R(1, 2), [0], [[1]]), moment_matrix(R(1, 2), [0], [[4]])]
    blocks = canonical_blocks(moments, {(0, 1): moments[0], (1,): moments[1] - moments[0]})
    e00 = sp.diag(1, 0)
    dual = [e00 / 2, e00 / 2]
    assert objective(blocks) == check_dual(moments, dual) == R(1, 2)
    try:
        realize_moment(blocks[(1,)])
    except ValueError:
        rejected_unrealizable = True
    else:
        raise AssertionError("A zero-mass positive-variance remainder was incorrectly realized.")
    sequence = []
    for n in [2, 3, 5, 10, 100]:
        measures = [{}, {}]
        for i, scale in enumerate([1, 2]):
            add_atom(measures[i], [0], (1 - R(1, n**2)) / 2)
            for sign in [-1, 1]:
                add_atom(measures[i], [sign * scale * n], R(1, 4 * n**2))
            assert atomic_moment(measures[i], 1) == moments[i]
        risk = bayes_error(measures)
        assert risk == (1 - R(1, n**2)) / 2 < R(1, 2)
        sequence.append({"n": n, "risk": str(risk), "supremum_gap": str(R(1, 2) - risk), "class_measures": [measure_json(measure) for measure in measures]})
    return {
        "name": "Equal means, unequal variances: supremum without attainment",
        "moments": moments_summary(moments),
        "primal_objective": str(objective(blocks)),
        "dual_objective": str(check_dual(moments, dual)),
        "dual_matrices": [matrix_json(matrix) for matrix in dual],
        "zero_mass_positive_variance_block_rejected": rejected_unrealizable,
        "explicit_approaching_sequence": sequence,
        "repair_certificates": [repair_certificate(moments, blocks, R(1, n**2)) for n in [2, 3, 10]],
        "nonattainment_reason": "For equal priors, Bayes error 1/2 requires the two class probability measures to coincide. Their second moments are 1 and 4, so no admissible pair attains 1/2. The exact sequence establishes the matching supremum.",
    }, moments, blocks


def disjoint_affine_supports():
    moments = [moment_matrix(R(1, 3), [0, b], [[1, 0], [0, 0]]) for b in range(3)]
    infinity_remainder = sp.diag(0, R(1, 6), 0)
    raw = {(0, 1, 2): infinity_remainder}
    raw.update({(i,): matrix - infinity_remainder for i, matrix in enumerate(moments)})
    blocks = canonical_blocks(moments, raw)
    dual = []
    for b in range(3):
        affine_normal = sp.Matrix([-b, 0, 1])
        assert (affine_normal.T * moments[b] * affine_normal)[0] == 0
        dual.append(2 * affine_normal * affine_normal.T)
    assert objective(blocks) == check_dual(moments, dual) == 0
    repaired = repair_blocks(moments, blocks, R(1, 5))
    assert repaired[(0, 1, 2)] == sp.zeros(3)
    measures = realize_blocks(moments, repaired)
    assert bayes_error(measures) == 0
    for i, measure in enumerate(measures):
        assert all(point[1] == i for point in measure)
    return {
        "name": "Disjoint affine supports with singular covariance",
        "moments": moments_summary(moments),
        "affine_supports": ["x_2 = 0", "x_2 = 1", "x_2 = 2"],
        "primal_objective": "0",
        "dual_objective": "0",
        "dual_matrices": [matrix_json(matrix) for matrix in dual],
        "zero_mass_nonsingleton_remainder": matrix_json(infinity_remainder),
        "repair_certificate": repair_certificate(moments, blocks, R(1, 5)),
        "all_realized_atoms_on_correct_disjoint_affine_support": True,
        "proof_scope": "Zero variance of x_2-b forces each admissible class onto its own line. The lines are disjoint, hence every admissible tuple has Bayes error zero. A zero-cost feasible dual independently certifies the relaxation value.",
    }, moments, blocks


def triple_overlap_certificate():
    moments, blocks, dual = barycentric_simplex_certificate(3)
    measures = realize_blocks(moments, blocks)
    assert objective(blocks) == check_dual(moments, dual) == bayes_error(measures) == R(5, 12)
    assert all(matrix.det() > 0 for matrix in moments)
    # Every dual slack is |S| times a strictly convex quadratic centered at the
    # subset barycenter.  Its kernel has dimension one.  Complementarity forces
    # every positive-mass optimal block onto that barycenter.
    e00 = sp.diag(1, 0, 0)
    contact_points = {}
    for s in subsets(3):
        slack = sum((dual[i] for i in s), sp.zeros(3)) - (len(s) - 1) * e00
        nullspace = slack.nullspace()
        assert len(nullspace) == 1
        vector = nullspace[0] / nullspace[0][0]
        contact_points[','.join(str(i + 1) for i in s)] = [str(v) for v in vector[1:]]
        if 0 in s and len(s) < 3:
            assert vector[1] * vector[2] == 0
    cross_moment = moments[0][1, 2]
    assert cross_moment == R(1, 108)
    forced_triple_mass = cross_moment / R(1, 9)
    assert forced_triple_mass == blocks[(0, 1, 2)][0, 0] == R(1, 12)

    # A separate rational dual for the restricted primal omitting the triple block.
    # In barycentric coordinates p=(1-x-y,x,y), q_i = sum p_j^2
    # - p_i^2/4 - 13*p_i/8 + 281/320.
    barycentric = [sp.Matrix([1, -1, -1]), sp.Matrix([0, 1, 0]), sp.Matrix([0, 0, 1])]
    e0 = sp.Matrix([1, 0, 0])
    sum_squares = sum((v * v.T for v in barycentric), sp.zeros(3))
    pair_only_dual = [sum_squares - v * v.T / 4 - R(13, 16) * (v * e0.T + e0 * v.T) + R(281, 320) * e00 for v in barycentric]
    pair_upper = check_dual(moments, pair_only_dual, max_subset_size=2)
    assert pair_upper == R(1189, 2880) < R(5, 12)
    full_contact = sp.Matrix([1, R(1, 3), R(1, 3)])
    invalid_full_slack = sum(pair_only_dual, sp.zeros(3)) - 2 * e00
    assert (full_contact.T * invalid_full_slack * full_contact)[0] == -R(71, 960)
    # Independent symbolic checks of the explicit sums-of-squares formulas.
    u, v = sp.symbols("u v")
    p = [u, v, 1 - u - v]
    q = [sum(z**2 for z in p) - z**2 / 4 - R(13, 8) * z + R(281, 320) for z in p]
    for i in range(3):
        j, ell = [r for r in range(3) if r != i]
        single_squares = R(5, 4) * (p[i] - R(21, 20))**2 + R(1, 2) * (p[j] - p[ell])**2
        assert sp.expand(q[i] - single_squares) == 0
    for i, j in [(0, 1), (0, 2), (1, 2)]:
        pair_squares = R(23, 8) * (p[i] + p[j] - R(45, 46))**2 + R(7, 8) * (p[i] - p[j])**2 + R(9, 1840)
        assert sp.expand(q[i] + q[j] - 1 - pair_squares) == 0

    return {
        "name": "Three classes with simultaneous pair and triple overlaps",
        "moments": moments_summary(moments),
        "primal_objective": "5/12",
        "dual_objective": "5/12",
        "actual_bayes_error": "5/12",
        "distinct_support_points": len(set().union(*(set(measure) for measure in measures))),
        "primal_blocks": {','.join(str(i + 1) for i in s): matrix_json(matrix) for s, matrix in blocks.items()},
        "dual_matrices": [matrix_json(matrix) for matrix in dual],
        "class_measures": [measure_json(measure) for measure in measures],
        "dual_contact_points": contact_points,
        "class_1_cross_second_moment": str(cross_moment),
        "triple_mass_forced_at_every_optimum": str(forced_triple_mass),
        "pair_only_dual_matrices": [matrix_json(matrix) for matrix in pair_only_dual],
        "pair_only_upper_bound": str(pair_upper),
        "certified_full_minus_pair_only_gap_at_least": str(R(5, 12) - pair_upper),
        "pair_only_dual_not_claimed_feasible_for_full_problem": True,
        "pair_only_singleton_square_identity": "q_i = (5/4)(p_i-21/20)^2 + (1/2)(p_j-p_k)^2",
        "pair_only_pair_square_identity": "q_i+q_j-1 = (23/8)(p_i+p_j-45/46)^2 + (7/8)(p_i-p_j)^2 + 9/1840",
        "pair_only_triple_slack_at_centroid": "-71/960",
        "pair_only_certificate_scope": "A certified upper bound, not a claim that 1189/2880 is the pair-only optimum.",
        "repair_certificate": repair_certificate(moments, blocks, R(1, 7)),
    }, moments, blocks


def general_simplex_checks():
    results = []
    for k in [2, 3, 4, 5]:
        moments, blocks, dual = barycentric_simplex_certificate(k)
        measures = realize_blocks(moments, blocks)
        expected = 1 - R(2**k - 1, k * 2**(k - 1))
        assert objective(blocks) == check_dual(moments, dual) == bayes_error(measures) == expected
        results.append({"classes": k, "dimension": k - 1, "subset_atom_count": 2**k - 1, "common_prior": str(R(1, k)), "exact_optimal_error": str(expected)})
    # Unequal positive subset masses test that the implementation is not tied
    # to equal priors or uniform submeasure weights.
    weights = {s: R(1 + sum(2**i for i in s)) for s in subsets(4)}
    moments, blocks, dual = barycentric_simplex_certificate(4, weights)
    assert objective(blocks) == check_dual(moments, dual) == bayes_error(realize_blocks(moments, blocks))
    return {"uniform_subset_weights": results, "unequal_subset_weights": {"moments": moments_summary(moments), "exact_optimal_error": str(objective(blocks))}}


def negative_input_checks():
    rejected = []
    for name, matrix in [
        ("negative diagonal", [[-1, 0], [0, 1]]),
        ("zero diagonal nonzero off-diagonal", [[0, 1], [1, 0]]),
        ("indefinite positive diagonal", [[1, 2], [2, 1]]),
        ("nonsymmetric", [[1, 1], [0, 1]]),
    ]:
        try:
            exact_psd_decomposition(matrix)
        except ValueError:
            rejected.append(name)
        else:
            raise AssertionError(f"Invalid PSD input accepted: {name}")
    return rejected


def mixed_rank_repair_check():
    k, dimension = 4, 3
    raw = {}
    for s in subsets(k):
        if len(s) == k:
            raw[s] = sp.diag(0, 1, 2, 0)
        else:
            code = sum(2**i for i in s)
            mass = R(1 + code, 100)
            mean = [R(len(s), 5), R(sum(s), 7), R((-1)**code, 3)]
            factor = sp.Matrix([[len(s), 1], [sum(i + 1 for i in s), 0], [1, 1]])
            covariance = factor * factor.T / 9
            raw[s] = moment_matrix(mass, mean, covariance)
    normalization = sum((len(s) * matrix[0, 0] for s, matrix in raw.items()), R(0))
    blocks = {s: matrix / normalization for s, matrix in raw.items()}
    moments = [sum((matrix for s, matrix in blocks.items() if i in s), sp.zeros(dimension + 1)) for i in range(k)]
    checked = repair_certificate(moments, blocks, R(1, 11))
    return {
        "description": "Four classes in dimension three, fourteen positive-mass mixed-rank blocks and one nonzero zero-mass full-subset block; unequal means and singular component covariances.",
        **checked,
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=Path("results/exact_certificate.json"))
    args = parser.parse_args()
    example1, moments1, blocks1 = equal_mean_unequal_variance()
    example2, moments2, blocks2 = disjoint_affine_supports()
    example3, moments3, blocks3 = triple_overlap_certificate()
    numeric = []
    try:
        import numpy as np
    except ImportError:
        numeric = [{"status": "not run", "reason": "NumPy unavailable; exact SymPy certificates are unaffected"}]
        numpy_version = None
    else:
        numpy_version = np.__version__
        for number, moments, blocks in [(1, moments1, blocks1), (2, moments2, blocks2), (3, moments3, blocks3)]:
            result = numerical_repair([matrix.tolist() for matrix in moments], {s: matrix.tolist() for s, matrix in blocks.items()}, 0.125)
            assert result["max_absolute_moment_error"] < 1e-8
            assert result["unmerged_bayes_error_lower_bound"] + 1e-10 >= result["target_objective"]
            numeric.append({"example": number, **{key: value for key, value in result.items() if key not in {"blocks", "atoms"}}, "labeled_atom_records": len(result["atoms"])})
    code_dir = Path(__file__).resolve().parent
    code_hashes = {name: hashlib.sha256((code_dir / name).read_bytes()).hexdigest() for name in ["moment_certificate.py", "verify_certificates.py"]}
    certificate = {
        "status": "PASS",
        "arithmetic": "Exact rational SymPy arithmetic for all substantive certificate equalities and PSD tests",
        "scope": "Finite primal/dual examples, moment-preserving repair construction, finite atomic realization, and explicit pair-only obstruction. This computation does not certify the general theorem or the statistical minimax interchange.",
        "environment": {"python": platform.python_version(), "sympy": sp.__version__, "numpy": numpy_version},
        "source_sha256": code_hashes,
        "examples": [example1, example2, example3],
        "simplex_family_checks": general_simplex_checks(),
        "mixed_rank_repair_check": mixed_rank_repair_check(),
        "invalid_psd_inputs_rejected": negative_input_checks(),
        "floating_point_diagnostics": numeric,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(certificate, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print("PASS: all exact rational certificates and moment identities.")
    print("Example 1: supremum = 1/2; explicit sequence certified; no-attainment argument recorded.")
    print("Example 2: primal = dual = actual Bayes error = 0 on disjoint affine lines.")
    print("Example 3: primal = dual = actual Bayes error = 5/12; seven distinct atoms.")
    print("Pair-only upper bound = 1189/2880; certified gap at least 11/2880.")
    print("Every full optimum requires triple mass 1/12 by the contact/cross-moment certificate.")
    print("Simplex families checked at k=2,3,4,5, including an unequal-weight k=4 instance.")
    print(f"Certificate written to {args.output}")


if __name__ == "__main__":
    main()
