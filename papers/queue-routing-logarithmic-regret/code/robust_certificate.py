#!/usr/bin/env python3
"""Exact robust optimality certificate for one supplied LP basis.

The maximization LP is max c^T z subject to A z = b and z >= 0.
The objective belongs to the Cartesian box lows <= c <= highs.  A basis
is supplied by an external LP solver; this checker never enumerates bases.

For each nonbasic column j, write alpha_j = A_B^{-1} A_j.  Its reduced
cost is c_j - c_B^T alpha_j.  Exact maximization over the box gives

    high_j - sum_k alpha_kj *
                 (low_Bk if alpha_kj >= 0 else high_Bk).

A primal-feasible basis whose maximum reduced costs are all <= 0 is
optimal for every objective in the box.  Strict negativity additionally
certifies a unique primal optimum for every objective in the box.

Rejection is failure of this supplied-basis certificate, not proof that
no other basis or argument could certify optimality.  In particular,
degenerate bases can fail a reduced-cost test while their vertex is optimal.
Confidence coverage, statistical validity, and queue stability are outside
this program's scope.

Inputs must be integers, Fraction objects, or rational/decimal strings.
Binary floats and booleans are deliberately rejected.

Examples:
    python robust_certificate.py input.json --output certificate.json
    python robust_certificate.py --self-check --output ../results/certificate_checker.json

JSON input keys: A, b, basis_indices, lows, highs; optional keys:
require_strict (default false), rate_indices (display-only variable subset).
"""
from __future__ import annotations

import argparse
import json
from fractions import Fraction
from pathlib import Path
from typing import Any, Sequence


def rational(value: Any) -> Fraction:
    if isinstance(value, bool) or isinstance(value, float):
        raise ValueError("Use an integer or a rational string; floats/bools are not exact inputs.")
    if isinstance(value, Fraction):
        return value
    if isinstance(value, int):
        return Fraction(value)
    if isinstance(value, str):
        try:
            return Fraction(value.strip())
        except (ValueError, ZeroDivisionError) as error:
            raise ValueError(f"Invalid rational input: {value!r}") from error
    raise ValueError(f"Unsupported rational input type: {type(value).__name__}")


def inverse(matrix: Sequence[Sequence[Fraction]]) -> list[list[Fraction]]:
    """Gauss-Jordan inversion over Q; raises on a singular supplied basis."""
    size = len(matrix)
    augmented = [
        list(row) + [Fraction(int(i == j)) for j in range(size)]
        for i, row in enumerate(matrix)
    ]
    for column in range(size):
        pivot = next((r for r in range(column, size) if augmented[r][column]), None)
        if pivot is None:
            raise ValueError("The supplied basis matrix is singular.")
        augmented[column], augmented[pivot] = augmented[pivot], augmented[column]
        scale = augmented[column][column]
        augmented[column] = [entry / scale for entry in augmented[column]]
        for row in range(size):
            if row == column:
                continue
            scale = augmented[row][column]
            if scale:
                augmented[row] = [
                    entry - scale * pivot_entry
                    for entry, pivot_entry in zip(augmented[row], augmented[column])
                ]
    return [row[size:] for row in augmented]


def dot(left: Sequence[Fraction], right: Sequence[Fraction]) -> Fraction:
    return sum((x * y for x, y in zip(left, right)), Fraction(0))


def _indices(values: Sequence[Any], upper: int, name: str) -> list[int]:
    result = list(values)
    if any(type(index) is not int or index < 0 or index >= upper for index in result):
        raise ValueError(f"{name} must contain valid zero-based integer column indices.")
    if len(set(result)) != len(result):
        raise ValueError(f"{name} must not contain duplicate columns.")
    return result


def certify_basis(
    A: Sequence[Sequence[Any]],
    b: Sequence[Any],
    basis_indices: Sequence[int],
    lows: Sequence[Any],
    highs: Sequence[Any],
    *,
    require_strict: bool = False,
    rate_indices: Sequence[int] | None = None,
) -> dict[str, Any]:
    """Return a JSON-safe exact certificate for one standard-form LP basis."""
    if type(require_strict) is not bool:
        raise ValueError("require_strict must be a boolean.")
    matrix = [[rational(entry) for entry in row] for row in A]
    if not matrix or not matrix[0]:
        raise ValueError("A must be a nonempty matrix.")
    rows, columns = len(matrix), len(matrix[0])
    if any(len(row) != columns for row in matrix):
        raise ValueError("A must be rectangular.")
    rhs, low, high = ([rational(entry) for entry in values] for values in (b, lows, highs))
    if len(rhs) != rows or len(low) != columns or len(high) != columns:
        raise ValueError("b, lows, or highs have incompatible dimensions.")
    if any(left > right for left, right in zip(low, high)):
        raise ValueError("Every lower endpoint must be <= its upper endpoint.")
    basis = _indices(basis_indices, columns, "basis_indices")
    if len(basis) != rows:
        raise ValueError("A basis must contain exactly as many columns as A has rows.")
    displayed_rates = (
        _indices(rate_indices, columns, "rate_indices") if rate_indices is not None else None
    )
    basis_matrix = [[row[column] for column in basis] for row in matrix]
    basis_inverse = inverse(basis_matrix)
    basic_values = [dot(row, rhs) for row in basis_inverse]
    solution = [Fraction(0) for _ in range(columns)]
    for index, value in zip(basis, basic_values):
        solution[index] = value
    residual = [dot(row, solution) - value for row, value in zip(matrix, rhs)]
    primal_feasible = all(value >= 0 for value in basic_values) and not any(residual)
    midpoint = [(left + right) / 2 for left, right in zip(low, high)]
    nonbasic = [index for index in range(columns) if index not in set(basis)]
    reduced_checks: list[dict[str, Any]] = []
    maxima: list[Fraction] = []
    for column in nonbasic:
        vector = [matrix[row][column] for row in range(rows)]
        alpha = [dot(row, vector) for row in basis_inverse]
        maximizing = list(midpoint)
        minimizing = list(midpoint)
        maximizing[column], minimizing[column] = high[column], low[column]
        for index, coefficient in zip(basis, alpha):
            maximizing[index] = low[index] if coefficient >= 0 else high[index]
            minimizing[index] = high[index] if coefficient >= 0 else low[index]
        maximum = high[column] - dot(alpha, [maximizing[index] for index in basis])
        minimum = low[column] - dot(alpha, [minimizing[index] for index in basis])
        maxima.append(maximum)
        reduced_checks.append({
            "column": column,
            "basis_coordinates": [str(value) for value in alpha],
            "minimum": str(minimum),
            "maximum": str(maximum),
            "maximizing_cost": [str(value) for value in maximizing],
            "minimizing_cost": [str(value) for value in minimizing],
        })
    nonpositive = all(value <= 0 for value in maxima)
    negative = all(value < 0 for value in maxima)
    robust_optimal = primal_feasible and nonpositive
    strict_unique = primal_feasible and negative
    accepted = strict_unique if require_strict else robust_optimal
    reasons = []
    if not primal_feasible:
        reasons.append("The supplied basis solution is not primal feasible.")
    if not nonpositive:
        reasons.append("At least one nonbasic reduced cost is positive for a box objective.")
    elif require_strict and not negative:
        reasons.append("Strict certification requested, but a reduced-cost maximum is zero.")
    result: dict[str, Any] = {
        "schema": "exact-robust-lp-basis-certificate/v1",
        "scope": "Algebraic sufficient certificate conditional on the supplied objective box.",
        "arithmetic": "Python fractions.Fraction; Gauss-Jordan inversion over the rationals.",
        "enumerates_bases": False,
        "accepted": accepted,
        "require_strict": require_strict,
        "primal_feasible": primal_feasible,
        "basis_nondegenerate": primal_feasible and all(value > 0 for value in basic_values),
        "robust_optimality_certified": robust_optimal,
        "strict_unique_optimum_certified": strict_unique,
        "rejection_reasons": reasons,
        "input": {
            "A": [[str(value) for value in row] for row in matrix],
            "b": [str(value) for value in rhs],
            "basis_indices": basis,
            "lows": [str(value) for value in low],
            "highs": [str(value) for value in high],
        },
        "basis_inverse": [[str(value) for value in row] for row in basis_inverse],
        "basic_values": [str(value) for value in basic_values],
        "primal_solution": [str(value) for value in solution],
        "constraint_residuals": [str(value) for value in residual],
        "nonbasic_columns": nonbasic,
        "basic_reduced_costs": "identically zero for every cost vector",
        "maximum_nonbasic_reduced_cost": str(max(maxima)) if maxima else None,
        "nonbasic_reduced_costs": reduced_checks,
        "objective_interval_at_solution": [
            str(dot(low, solution)), str(dot(high, solution))
        ] if primal_feasible else None,
    }
    if displayed_rates is not None:
        result["rate_indices"] = displayed_rates
        result["rates"] = [str(solution[index]) for index in displayed_rates]
    return result


def _feasible(A: Sequence[Sequence[Any]], b: Sequence[Any], point: Sequence[Any]) -> bool:
    x = [rational(value) for value in point]
    return all(value >= 0 for value in x) and all(
        dot([rational(value) for value in row], x) == rational(rhs)
        for row, rhs in zip(A, b)
    )


def self_check() -> dict[str, Any]:
    """Deterministic checks of mathematical acceptance/rejection, not queue simulation."""
    A = [
        [1, 1, 0, 0, 0, 0],
        [0, 0, 1, 1, 0, 0],
        [1, 0, 1, 0, 1, 0],
        [0, 1, 0, 1, 0, 1],
    ]
    b, basis = ["2/5", "3/5", 2, 2], [0, 3, 4, 5]
    narrow = certify_basis(
        A, b, basis,
        ["15/4", "3/4", "7/4", "11/4", 0, 0],
        ["17/4", "5/4", "9/4", "13/4", 0, 0],
        require_strict=True, rate_indices=[0, 1, 2, 3],
    )
    assert narrow["accepted"]
    assert narrow["rates"] == ["2/5", "0", "0", "3/5"]
    assert narrow["maximum_nonbasic_reduced_cost"] == "-1/2"
    wide = certify_basis(
        A, b, basis, [0, 0, 0, 0, 0, 0], [5, 5, 5, 5, 0, 0],
        require_strict=True, rate_indices=[0, 1, 2, 3],
    )
    assert not wide["accepted"]
    witness = wide["nonbasic_reduced_costs"][0]["maximizing_cost"]
    alternative = ["0", "2/5", "0", "3/5", "2", "1"]
    assert _feasible(A, b, alternative)
    gain = dot(list(map(rational, witness)), list(map(rational, alternative))) - dot(
        list(map(rational, witness)), list(map(rational, wide["primal_solution"]))
    )
    assert gain == 2

    # Negative basis coefficient must select the HIGH, not the LOW, endpoint.
    signed_A, signed_b = [[1, 0, 1], [0, 1, -1]], [1, 1]
    signed = certify_basis(signed_A, signed_b, [0, 1], [2, 4, -4], [3, 6, -3])
    assert not signed["accepted"]
    assert signed["maximum_nonbasic_reduced_cost"] == "1"
    signed_witness = signed["nonbasic_reduced_costs"][0]["maximizing_cost"]
    assert signed_witness == ["2", "6", "-3"]
    assert _feasible(signed_A, signed_b, [0, 2, 1])
    assert dot(list(map(rational, signed_witness)), [Fraction(0), Fraction(2), Fraction(1)]) - dot(
        list(map(rational, signed_witness)), [Fraction(1), Fraction(1), Fraction(0)]
    ) == 1

    boundary = certify_basis(signed_A, signed_b, [0, 1], [2, 4, -4], [3, 5, -3])
    strict_boundary = certify_basis(
        signed_A, signed_b, [0, 1], [2, 4, -4], [3, 5, -3], require_strict=True
    )
    assert boundary["accepted"] and not strict_boundary["accepted"]
    assert boundary["maximum_nonbasic_reduced_cost"] == "0"

    rejected_inputs = {}
    for name, call in {
        "singular_basis": lambda: certify_basis([[1, 1], [1, 1]], [1, 1], [0, 1], [0, 0], [1, 1]),
        "binary_float": lambda: certify_basis([[1]], [0.1], [0], [0], [1]),
        "inverted_box": lambda: certify_basis([[1]], [1], [0], [2], [1]),
    }.items():
        try:
            call()
        except ValueError as error:
            rejected_inputs[name] = str(error)
        else:
            raise AssertionError(f"{name} was not rejected.")
    infeasible = certify_basis([[1]], [-1], [0], [0], [1])
    assert not infeasible["accepted"] and not infeasible["primal_feasible"]
    return {
        "scope": "Exact supplied-basis robust-certificate checker; no stochastic proof claim.",
        "all_checks_passed": True,
        "checks": {
            "k22_narrow_box_certifies": narrow,
            "k22_wide_box_rejects": wide,
            "wide_box_feasible_improvement_witness": {
                "cost": witness, "alternative_solution": alternative, "objective_gain": str(gain)
            },
            "negative_basis_coefficient_endpoint_check": signed,
            "boundary_nonstrict_accepts_strict_rejects": {
                "nonstrict": boundary["accepted"],
                "strict": strict_boundary["accepted"],
                "maximum_reduced_cost": boundary["maximum_nonbasic_reduced_cost"],
            },
            "invalid_inputs_rejected": rejected_inputs,
            "negative_basic_value_rejected": not infeasible["accepted"],
        },
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", nargs="?", type=Path)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--self-check", action="store_true")
    args = parser.parse_args()
    if args.self_check == (args.input is not None):
        parser.error("Choose exactly one JSON input file or --self-check.")
    try:
        result = self_check() if args.self_check else certify_basis(
            **json.loads(args.input.read_text(encoding="utf-8"))
        )
    except (ValueError, TypeError, KeyError, OSError) as error:
        print(json.dumps({"accepted": False, "error": str(error)}, indent=2))
        return 2
    rendered = json.dumps(result, indent=2, ensure_ascii=False) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered, encoding="utf-8")
        print(json.dumps({
            "output": str(args.output),
            "all_checks_passed": result.get("all_checks_passed"),
            "accepted": result.get("accepted"),
        }))
    else:
        print(rendered, end="")
    return 0 if result.get("all_checks_passed", result.get("accepted", False)) else 1


if __name__ == "__main__":
    raise SystemExit(main())

