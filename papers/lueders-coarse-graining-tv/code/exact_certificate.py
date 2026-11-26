#!/usr/bin/env python3
"""Exact rational certificate for a qubit Lueders coarse-graining counterexample.

No floating-point arithmetic or third-party dependencies are used.  Each positive
Kraus square root is represented by (N, r), meaning K = N / sqrt(r), so that its
sandwich action is the rational expression N X N / r.  The universal bound over
complex density matrices is the Bloch-disk lemma in the accompanying proof; this
script checks every rational input to that lemma and both attaining states.
"""

from __future__ import annotations

import argparse
from fractions import Fraction as F
import json
from pathlib import Path


def matrix(a, b, c, d):
    return ((F(a), F(b)), (F(c), F(d)))


ZERO = matrix(0, 0, 0, 0)
IDENTITY = matrix(1, 0, 0, 1)


def add(a, b):
    return tuple(tuple(a[i][j] + b[i][j] for j in range(2)) for i in range(2))


def neg(a):
    return tuple(tuple(-a[i][j] for j in range(2)) for i in range(2))


def sub(a, b):
    return add(a, neg(b))


def scale(c, a):
    return tuple(tuple(F(c) * a[i][j] for j in range(2)) for i in range(2))


def mul(a, b):
    return tuple(
        tuple(sum((a[i][k] * b[k][j] for k in range(2)), F(0)) for j in range(2))
        for i in range(2)
    )


def total(matrices):
    answer = ZERO
    for a in matrices:
        answer = add(answer, a)
    return answer


def trace(a):
    return a[0][0] + a[1][1]


def determinant(a):
    return a[0][0] * a[1][1] - a[0][1] * a[1][0]


def psd(a):
    return (
        a[0][1] == a[1][0]
        and a[0][0] >= 0
        and a[1][1] >= 0
        and determinant(a) >= 0
    )


def sandwich(root, x):
    numerator, normalization_square = root
    return scale(1 / F(normalization_square), mul(mul(numerator, x), numerator))


def encode_matrix(a):
    return [[str(entry) for entry in row] for row in a]


def root_data(root):
    numerator, normalization_square = root
    return {
        "numerator": encode_matrix(numerator),
        "normalization_square": str(normalization_square),
        "meaning": "positive square root = numerator / sqrt(normalization_square)",
    }


def difference_table(effects_a, roots_a, effects_b, roots_b):
    return [
        sub(sandwich(ra, b), sandwich(rb, a))
        for a, ra in zip(effects_a, roots_a)
        for b, rb in zip(effects_b, roots_b)
    ]


def subset_table(differences):
    rows = []
    for mask in range(1 << len(differences)):
        value = total(d for index, d in enumerate(differences) if mask & (1 << index))
        if value[0][0] != -value[1][1] or value[0][1] != value[1][0]:
            raise AssertionError("Subset difference is not real symmetric and traceless")
        diagonal, off_diagonal = value[0][0], value[0][1]
        squared_norm = diagonal * diagonal + off_diagonal * off_diagonal
        rows.append(
            {
                "mask": mask,
                "selected_indices": [i for i in range(len(differences)) if mask & (1 << i)],
                "diagonal": str(diagonal),
                "off_diagonal": str(off_diagonal),
                "squared_operator_norm": str(squared_norm),
            }
        )
    return rows


def witness_data(rho, effects_a, roots_a, effects_b, roots_b):
    if not psd(rho) or trace(rho) != 1:
        raise AssertionError("Invalid witness density matrix")
    ab = [trace(mul(rho, sandwich(ra, b))) for ra in roots_a for b in effects_b]
    ba = [trace(mul(rho, sandwich(rb, a))) for a in effects_a for rb in roots_b]
    if any(p < 0 for p in ab + ba) or sum(ab) != 1 or sum(ba) != 1:
        raise AssertionError("Witness order records are not probability distributions")
    return {
        "density_matrix": encode_matrix(rho),
        "probabilities_AB": list(map(str, ab)),
        "probabilities_BA": list(map(str, ba)),
        "differences": list(map(str, (p - q for p, q in zip(ab, ba)))),
        "total_variation": str(sum((abs(p - q) for p, q in zip(ab, ba)), F(0)) / 2),
    }


def certificate():
    a = [
        matrix(F(2, 3), 0, 0, 0),
        matrix(F(5, 18), F(1, 6), F(1, 6), F(1, 2)),
        matrix(F(1, 18), F(-1, 6), F(-1, 6), F(1, 2)),
    ]
    roots_a = [
        (matrix(2, 0, 0, 0), 6),
        (matrix(11, 3, 3, 15), 468),
        (matrix(1, -3, -3, 9), 180),
    ]
    b = [matrix(F(16, 25), 0, 0, 1), matrix(F(9, 25), 0, 0, 0)]
    roots_b = [(matrix(4, 0, 0, 5), 25), (matrix(3, 0, 0, 0), 25)]
    coarse = [add(a[0], a[1]), a[2]]
    roots_coarse = [(matrix(29, 3, 3, 21), 900), roots_a[2]]
    for name, effects, roots in [("A", a, roots_a), ("B", b, roots_b), ("coarse_A", coarse, roots_coarse)]:
        if total(effects) != IDENTITY:
            raise AssertionError(f"{name}: effects do not sum to identity")
        for index, (effect, root) in enumerate(zip(effects, roots)):
            numerator, normalization_square = root
            if normalization_square <= 0 or not psd(numerator) or not psd(effect):
                raise AssertionError(f"{name}[{index}]: positivity failure")
            if sandwich(root, IDENTITY) != effect:
                raise AssertionError(f"{name}[{index}]: positive square-root certificate failure")

    fine_differences = difference_table(a, roots_a, b, roots_b)
    coarse_differences = difference_table(coarse, roots_coarse, b, roots_b)
    if fine_differences[:2] != [ZERO, ZERO]:
        raise AssertionError("The first fine outcome should commute with B")
    reduced_fine = fine_differences[2:]
    if total(reduced_fine) != ZERO or total(coarse_differences) != ZERO:
        raise AssertionError("Difference matrices must sum to zero")
    fine_table = subset_table(reduced_fine)
    coarse_table = subset_table(coarse_differences)
    fine_bound, coarse_bound = F(1, 30), F(9, 250)
    for rows, bound in [(fine_table, fine_bound), (coarse_table, coarse_bound)]:
        values = [F(row["squared_operator_norm"]) for row in rows]
        if max(values) != bound * bound:
            raise AssertionError("Claimed maximum subset squared norm is wrong")

    fine_witness = witness_data(
        matrix(F(1, 2), F(1, 2), F(1, 2), F(1, 2)), a, roots_a, b, roots_b
    )
    coarse_witness = witness_data(
        matrix(F(1, 5), F(2, 5), F(2, 5), F(4, 5)), coarse, roots_coarse, b, roots_b
    )
    if F(fine_witness["total_variation"]) != fine_bound:
        raise AssertionError("Fine witness does not attain the bound")
    if F(coarse_witness["total_variation"]) != coarse_bound:
        raise AssertionError("Coarse witness does not attain the bound")
    if coarse_bound - fine_bound != F(1, 375):
        raise AssertionError("Incorrect strict gap")

    return {
        "schema_version": 1,
        "arithmetic": "Python standard-library fractions.Fraction; no floating-point arithmetic",
        "status": "all_exact_checks_passed",
        "scope": "Admissibility, exact Lueders difference matrices, all 32 subset norm certificates, and both attaining states. The all-complex-density upper-bound lemma is supplied in core_proof.md and the Lean development.",
        "effects": {"A": list(map(encode_matrix, a)), "B": list(map(encode_matrix, b)), "coarse_A": list(map(encode_matrix, coarse))},
        "positive_square_root_certificates": {"A": list(map(root_data, roots_a)), "B": list(map(root_data, roots_b)), "coarse_A": list(map(root_data, roots_coarse))},
        "fine_difference_order": ["D00", "D01", "D10", "D11", "D20", "D21"],
        "fine_differences": list(map(encode_matrix, fine_differences)),
        "fine_subset_bit_order": ["D10", "D11", "D20", "D21"],
        "fine_subset_table": fine_table,
        "coarse_difference_order": ["D00", "D01", "D10", "D11"],
        "coarse_differences": list(map(encode_matrix, coarse_differences)),
        "coarse_subset_bit_order": ["D00", "D01", "D10", "D11"],
        "coarse_subset_table": coarse_table,
        "fine_attaining_state": fine_witness,
        "coarse_attaining_state": coarse_witness,
        "exact_scores": {"fine": str(fine_bound), "coarse": str(coarse_bound), "increase": str(coarse_bound - fine_bound), "ratio": str(coarse_bound / fine_bound)},
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, help="Write the complete deterministic JSON certificate here")
    args = parser.parse_args()
    result = certificate()
    if args.output:
        args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"status": result["status"], "exact_scores": result["exact_scores"]}, sort_keys=True))


if __name__ == "__main__":
    main()
