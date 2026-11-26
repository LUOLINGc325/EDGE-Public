#!/usr/bin/env python3
"""Independently verify the complete two-qubit Pauli MUB boundary example.

This script imports no author implementation and uses only Python's standard
library. Gaussian integers are pairs of ordinary integers. The orbit vectors
are represented by their numerators 2 * P * psi, so an inner product has
denominator 4 and its squared modulus has denominator 16. No floating-point
or Python complex arithmetic is used.

Run from any working directory:
    python code/verify_boundary.py

By default the deterministic certificate is written to the sibling results
directory. Passing --output selects a different JSON destination. A failed
exact equality raises an exception and leaves no successful certificate.
"""

from __future__ import annotations

import argparse
from collections import Counter
from itertools import product
import json
from pathlib import Path


Gaussian = tuple[int, int]
ZERO: Gaussian = (0, 0)
ONE: Gaussian = (1, 0)
NEG_ONE: Gaussian = (-1, 0)
IMAG: Gaussian = (0, 1)
NEG_IMAG: Gaussian = (0, -1)

# Literal Hermitian Pauli matrices in order I, X, Y, Z.
PAULI = (
    ((ONE, ZERO), (ZERO, ONE)),
    ((ZERO, ONE), (ONE, ZERO)),
    ((ZERO, NEG_IMAG), (IMAG, ZERO)),
    ((ONE, ZERO), (ZERO, NEG_ONE)),
)

INDICES = tuple(product(range(2), repeat=2))
LABELS = tuple(product(range(4), repeat=2))
FIDUCIAL_NUMERATOR = (ONE, IMAG, IMAG, IMAG)


def add(z: Gaussian, w: Gaussian) -> Gaussian:
    return z[0] + w[0], z[1] + w[1]


def multiply(z: Gaussian, w: Gaussian) -> Gaussian:
    return z[0] * w[0] - z[1] * w[1], z[0] * w[1] + z[1] * w[0]


def conjugate(z: Gaussian) -> Gaussian:
    return z[0], -z[1]


def norm_squared(z: Gaussian) -> int:
    return z[0] * z[0] + z[1] * z[1]


def tensor_entry(label: tuple[int, int], x: tuple[int, int],
                 y: tuple[int, int]) -> Gaussian:
    return multiply(PAULI[label[0]][x[0]][y[0]],
                    PAULI[label[1]][x[1]][y[1]])


def orbit_numerator(label: tuple[int, int]) -> tuple[Gaussian, ...]:
    result = []
    for x in INDICES:
        value = ZERO
        for y, fiducial_value in zip(INDICES, FIDUCIAL_NUMERATOR):
            value = add(value, multiply(tensor_entry(label, x, y), fiducial_value))
        result.append(value)
    return tuple(result)


def inner_numerator(v: tuple[Gaussian, ...],
                    w: tuple[Gaussian, ...]) -> Gaussian:
    value = ZERO
    for x, y in zip(v, w):
        value = add(value, multiply(conjugate(x), y))
    return value


def flip_row(label: tuple[int, int]) -> tuple[int, int]:
    # I,Z do not flip; X,Y do flip. Y differs from XZ only by i.
    return tuple(int(local_label in (1, 2)) for local_label in label)


def require(condition: bool, explanation: str) -> None:
    # Do not use assert: verification must remain active under python -O.
    if not condition:
        raise ValueError(explanation)


def frequencies(values: Counter[Gaussian]) -> list[dict[str, object]]:
    return [{"real": z[0], "imaginary": z[1], "count": count}
            for z, count in sorted(values.items())]


def verify() -> dict[str, object]:
    require(len(INDICES) == 4 and len(LABELS) == 16,
            "Wrong Hilbert-space or label cardinality")
    row_sizes = Counter(flip_row(label) for label in LABELS)
    require(len(row_sizes) == 4 and set(row_sizes.values()) == {4},
            "The complete labels do not form four rows of four")
    require(all(norm_squared(z) == 1 for z in FIDUCIAL_NUMERATOR),
            "The fiducial is not equimodular with coordinate norm squared 1/4")

    vectors = {label: orbit_numerator(label) for label in LABELS}
    diagonal: Counter[Gaussian] = Counter()
    within_row: Counter[Gaussian] = Counter()
    cross_row: Counter[Gaussian] = Counter()
    for left in LABELS:
        for right in LABELS:
            overlap = inner_numerator(vectors[left], vectors[right])
            if left == right:
                require(overlap == (4, 0),
                        f"Non-unit vector at label {left}: numerator {overlap}")
                diagonal[overlap] += 1
            elif flip_row(left) == flip_row(right):
                require(overlap == ZERO,
                        f"Nonorthogonal row pair {left}, {right}: {overlap}")
                within_row[overlap] += 1
            else:
                require(norm_squared(overlap) == 4,
                        f"Non-unbiased cross pair {left}, {right}: {overlap}")
                cross_row[overlap] += 1

    counts = {
        "normalized_diagonal": sum(diagonal.values()),
        "within_row_ordered": sum(within_row.values()),
        "cross_row_ordered": sum(cross_row.values()),
    }
    require(counts == {"normalized_diagonal": 16,
                       "within_row_ordered": 48,
                       "cross_row_ordered": 192},
            f"Unexpected pair counts: {counts}")
    require(sum(counts.values()) == 256, "Incomplete pair coverage")

    return {
        "schema_version": 1,
        "status": "PASS",
        "purpose": "Independent exact nonvacuity check of the actual n=2 Pauli MUB definition",
        "arithmetic": "Gaussian integer pairs; only integer addition, multiplication and conjugation",
        "imports_author_code": False,
        "uses_floating_point": False,
        "qubits": 2,
        "dimension": 4,
        "pauli_order": ["I", "X", "Y", "Z"],
        "basis_index_order": [list(index) for index in INDICES],
        "fiducial_coordinate_numerators": [list(z) for z in FIDUCIAL_NUMERATOR],
        "fiducial_coordinate_denominator": 2,
        "fiducial_coordinate_norm_squared": {"numerator": 1, "denominator": 4},
        "label_count": 16,
        "row_rule": "Local labels I,Z map to flip 0; X,Y map to flip 1",
        "rows": [{"flip": list(row), "size": size}
                 for row, size in sorted(row_sizes.items())],
        "ordered_pair_count": 256,
        "counts": counts,
        "inner_product_denominator": 4,
        "squared_inner_product_denominator": 16,
        "diagonal_inner_product_numerator_frequencies": frequencies(diagonal),
        "within_row_inner_product_numerator_frequencies": frequencies(within_row),
        "cross_row_inner_product_numerator_frequencies": frequencies(cross_row),
        "normalized_diagonal_overlap": {"numerator": 1, "denominator": 1},
        "normalized_within_row_overlap": {"numerator": 0, "denominator": 1},
        "normalized_cross_row_squared_overlap": {"numerator": 1, "denominator": 4},
        "scope_limit": "Finite independent arithmetic check only; not a Lean compilation or axiom-audit certificate",
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--output", type=Path,
        default=Path(__file__).resolve().parents[1] / "results" / "boundary_exact.json",
    )
    arguments = parser.parse_args()
    certificate = verify()
    arguments.output.parent.mkdir(parents=True, exist_ok=True)
    arguments.output.write_text(
        json.dumps(certificate, ensure_ascii=False, indent=2) + "\n", encoding="utf-8"
    )
    print(json.dumps({"status": certificate["status"],
                      "ordered_pair_count": certificate["ordered_pair_count"],
                      "counts": certificate["counts"]}, sort_keys=True))


if __name__ == "__main__":
    main()
