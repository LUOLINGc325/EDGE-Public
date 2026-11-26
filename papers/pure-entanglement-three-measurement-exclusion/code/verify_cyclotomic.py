#!/usr/bin/env python3
"""Finite high-precision diagnostics for the general cyclotomic construction.

This is NOT an exact certificate and does not prove any assertion for all ranks,
all Schmidt spectra, or all transversals.  The accompanying manuscript supplies
those analytic proofs.  The separate rational example has an exact checker.

Run from any directory; results are written under this case by default.
"""

from __future__ import annotations

import argparse
import json
from math import isqrt
from pathlib import Path

import mpmath as mp


CASES = [
    ("r3_uniform", [1, 1, 1]),
    ("r3_quadratic", [1, 4, 9]),
    ("r3_imbalanced", [1, 10, 100]),
    ("r5_uniform", [1, 1, 1, 1, 1]),
    ("r5_linear", [1, 2, 3, 4, 5]),
    ("r5_quadratic", [1, 4, 9, 16, 25]),
    ("r7_uniform", [1, 1, 1, 1, 1, 1, 1]),
    ("r7_linear", [1, 2, 3, 4, 5, 6, 7]),
    ("r7_geometric", [1, 2, 4, 8, 16, 32, 64]),
]


def require(condition: bool, message: str) -> None:
    """Keep verification active under python -O."""
    if not condition:
        raise ArithmeticError(message)


def is_prime(n: int) -> bool:
    if n < 2:
        return False
    if n % 2 == 0:
        return n == 2
    return all(n % d for d in range(3, isqrt(n) + 1, 2))


def choose_prime(weights: list[int]) -> int:
    """Exact integer test of q>max(2r(r-1)+1,80*sqrt(kappa))."""
    r = len(weights)
    lo, hi = min(weights), max(weights)
    q = max(2 * r * (r - 1) + 2, isqrt(6400 * hi // lo) + 1)
    while not (q * q * lo > 6400 * hi and is_prime(q)):
        q += 1
    require(q > 2 * r * (r - 1) + 1, "degree condition failed")
    return q


def max_entry(matrix: mp.matrix) -> mp.mpf:
    return max(abs(matrix[i, j]) for i in range(matrix.rows) for j in range(matrix.cols))


def fmt(value: mp.mpf) -> str:
    return mp.nstr(value, 40)


def column(matrix: mp.matrix, a: int) -> mp.matrix:
    return mp.matrix([matrix[i, a] for i in range(matrix.rows)])


def check_case(name: str, weights: list[int], tolerance: mp.mpf) -> dict:
    r = len(weights)
    require(r >= 3 and all(w > 0 for w in weights), f"{name}: invalid weights")
    q = choose_prime(weights)
    total = sum(weights)
    lambdas = [mp.mpf(w) / total for w in weights]
    kappa = mp.mpf(max(weights)) / min(weights)
    omega = mp.exp(2j * mp.pi / r)
    z = mp.exp(2j * mp.pi * (q - 1) / (r * q))
    fourier = mp.matrix(r, r)
    for a in range(r):
        for j in range(r):
            fourier[a, j] = omega ** (-a * j) / mp.sqrt(r)
    unitaries = [
        fourier * mp.diag([z ** (x * j) for j in range(r)]) * fourier.H
        for x in range(3)
    ]
    identity = mp.eye(r)
    unitary_error = max(max_entry(u.H * u - identity) for u in unitaries)
    require(unitary_error < tolerance, f"{name}: unitarity residual")
    require(max_entry(unitaries[0] - identity) < tolerance, f"{name}: U0 != I")

    # An independently assembled geometric-sum formula checks Fourier indexing.
    direct_error = mp.mpf(0)
    for x, u in enumerate(unitaries):
        for a in range(r):
            for b in range(r):
                direct = sum((omega ** (b - a) * z**x) ** j for j in range(r)) / r
                direct_error = max(direct_error, abs(u[a, b] - direct))
    require(direct_error < tolerance, f"{name}: Fourier/geometric-sum mismatch")

    norm_error = mp.mpf(0)
    max_overlap = mp.mpf(0)
    min_gram_eigenvalue = mp.inf
    sum_error = mp.mpf(0)
    hermitian_error = mp.mpf(0)
    min_effect_eigenvalue = mp.inf
    max_exclusion_error = mp.mpf(0)
    max_wrong_label_error = mp.mpf(0)
    max_probability_imaginary = mp.mpf(0)
    min_same_output_01_overlap = mp.inf
    min_conditional_probability = mp.inf
    nonorthogonality_identity_error = mp.mpf(0)
    branches = []
    c = (1 - z**r) / (r * (1 - z))
    require(abs(c) > tolerance, f"{name}: diagonal overlap vanished numerically")

    for a in range(r):
        unnormalised = []
        vectors = []
        probabilities = []
        for u in unitaries:
            b = column(u, a)
            w = mp.matrix([mp.sqrt(lambdas[j]) * mp.conj(b[j]) for j in range(r)])
            probability = mp.re((w.H * w)[0])
            require(probability > 0, f"{name}, outcome {a}: zero branch")
            unnormalised.append(w)
            vectors.append(w / mp.sqrt(probability))
            probabilities.append(probability)
            min_conditional_probability = min(min_conditional_probability, probability)
        v = mp.matrix(r, 3)
        for j in range(r):
            for x in range(3):
                v[j, x] = vectors[x][j]
        gram = v.H * v
        norm_error = max(norm_error, *(abs(gram[x, x] - 1) for x in range(3)))
        overlap = max(abs(gram[x, y]) for x in range(3) for y in range(3) if x != y)
        max_overlap = max(max_overlap, overlap)
        require(overlap < mp.mpf("0.5"), f"{name}, outcome {a}: Gram condition")
        gram_eigenvalues = mp.eighe((gram + gram.H) / 2, eigvals_only=True)
        min_gram_eigenvalue = min(min_gram_eigenvalue, min(gram_eigenvalues))
        require(min(gram_eigenvalues) > 0, f"{name}, outcome {a}: Gram positivity")
        ginverse = gram**-1
        dual = v * ginverse
        projection = v * ginverse * v.H
        effects = []
        for x in range(3):
            others = [j for j in range(3) if j != x]
            j, k = others
            block = mp.zeros(3)
            block[j, j] = block[k, k] = mp.mpf("0.5")
            block[j, k] = gram[j, k]
            block[k, j] = gram[k, j]
            effect = dual * block * dual.H + (identity - projection) / 3
            effects.append(effect)
            hermitian_error = max(hermitian_error, max_entry(effect - effect.H))
            # Hermitian symmetrisation is only for the numerical eigensolver.
            # The unsymmetrised matrix is used for all sums/probabilities below.
            eig = mp.eighe((effect + effect.H) / 2, eigvals_only=True)
            min_effect_eigenvalue = min(min_effect_eigenvalue, min(eig))
            require(min(eig) > -tolerance, f"{name}, outcome {a}: effect positivity")
            require(mp.re(sum(effect[j, j] for j in range(r))) > tolerance, f"{name}, outcome {a}: null effect")
        sum_error = max(sum_error, max_entry(sum(effects, mp.zeros(r)) - identity))
        for x in range(3):
            for y in range(3):
                value = (vectors[x].H * effects[y] * vectors[x])[0]
                max_probability_imaginary = max(max_probability_imaginary, abs(mp.im(value)))
                if x == y:
                    max_exclusion_error = max(max_exclusion_error, abs(value))
                else:
                    max_wrong_label_error = max(max_wrong_label_error, abs(value - mp.mpf("0.5")))
        same = (unnormalised[0].H * unnormalised[1])[0]
        expected = lambdas[a] * mp.conj(c)
        nonorthogonality_identity_error = max(nonorthogonality_identity_error, abs(same - expected))
        min_same_output_01_overlap = min(min_same_output_01_overlap, abs(gram[0, 1]))
        require(abs(same) > tolerance, f"{name}, outcome {a}: 0/1 orthogonality")
        branches.append({
            "outcome": a,
            "probabilities_by_hypothesis": [fmt(p) for p in probabilities],
            "maximum_absolute_overlap": fmt(overlap),
            "absolute_overlap_01": fmt(abs(gram[0, 1])),
        })

    for label, error in [
        ("normalisation", norm_error),
        ("POVM sum", sum_error),
        ("hermiticity", hermitian_error),
        ("exclusion", max_exclusion_error),
        ("wrong-label probability", max_wrong_label_error),
        ("probability imaginary part", max_probability_imaginary),
        ("nonorthogonality identity", nonorthogonality_identity_error),
    ]:
        require(error < tolerance, f"{name}: {label} residual {error}")
    theorem_overlap_bound = 12 * mp.pi * mp.sqrt(kappa) / q
    require(max_overlap <= theorem_overlap_bound, f"{name}: analytic overlap bound")
    require(theorem_overlap_bound < mp.mpf("0.5"), f"{name}: sufficient prime bound")
    require(min_same_output_01_overlap > tolerance, f"{name}: fixed-input nondiscrimination witness")

    return {
        "name": name,
        "schmidt_rank": r,
        "integer_schmidt_weights": weights,
        "normalisation_denominator": total,
        "prime_q": q,
        "transversal_degree_upper_bound": 2 * r * (r - 1),
        "specialisation_extension_degree": q - 1,
        "prime_conditions_checked_exactly": True,
        "transversal_nonvanishing_scope": "analytic degree argument; no floating-point certificate claimed",
        "unitarity_residual": fmt(unitary_error),
        "fourier_geometric_sum_residual": fmt(direct_error),
        "normalisation_residual": fmt(norm_error),
        "max_absolute_gram_overlap": fmt(max_overlap),
        "analytic_absolute_overlap_bound": fmt(theorem_overlap_bound),
        "minimum_gram_eigenvalue": fmt(min_gram_eigenvalue),
        "povm_sum_residual": fmt(sum_error),
        "hermiticity_residual": fmt(hermitian_error),
        "minimum_symmetrised_effect_eigenvalue": fmt(min_effect_eigenvalue),
        "max_exclusion_probability_absolute_value": fmt(max_exclusion_error),
        "max_wrong_label_probability_error_from_one_half": fmt(max_wrong_label_error),
        "max_probability_imaginary_part": fmt(max_probability_imaginary),
        "minimum_same_output_01_overlap": fmt(min_same_output_01_overlap),
        "minimum_conditional_probability": fmt(min_conditional_probability),
        "nonorthogonality_identity_residual": fmt(nonorthogonality_identity_error),
        "branches": branches,
        "passed": True,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--dps", type=int, default=80, help="decimal working precision, at least 80")
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results" / "numerical_checks.json")
    args = parser.parse_args()
    require(args.dps >= 80, "working precision must be at least 80 decimal digits")
    mp.mp.dps = args.dps
    tolerance = mp.mpf("1e-60")
    results = [check_case(name, weights, tolerance) for name, weights in CASES]
    payload = {
        "status": "all_finite_numerical_diagnostics_passed",
        "evidence_type": "high_precision_floating_point_diagnostics_not_exact_certificate",
        "working_decimal_precision": args.dps,
        "residual_tolerance": "1e-60",
        "mpmath_version": mp.__version__,
        "case_count": len(results),
        "outcome_branches_checked": sum(len(c[1]) for c in CASES),
        "povm_effects_checked": 3 * sum(len(c[1]) for c in CASES),
        "conditional_probabilities_checked": 9 * sum(len(c[1]) for c in CASES),
        "general_scope": "The manuscript proves the all-ranks/all-spectra theorem; this script only checks the listed nine spectra.",
        "eigenvalue_note": "Effect Hermiticity is checked first; only the eigenvalue diagnostic uses (N+N*)/2. All probability and sum checks use the original N.",
        "cases": results,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"status": payload["status"], "case_count": len(results), "outcome_branches_checked": payload["outcome_branches_checked"], "output": str(args.output)}, ensure_ascii=False))


if __name__ == "__main__":
    main()
