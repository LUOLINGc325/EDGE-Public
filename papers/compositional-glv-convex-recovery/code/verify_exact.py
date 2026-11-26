#!/usr/bin/env python3
"""Exact rational certificate for the finite-jet GLV reconstruction.

Run from the case directory:
    python code/verify_exact.py --output results/exact_certificate.json

This is a finite, independently generated algebraic example, not a proof of
genericity, a formal proof-assistant certificate, or a biological benchmark.
All calculations are over SymPy's exact rational field; there is no tolerance.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path

import sympy as sp


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def matrix_strings(matrix: sp.Matrix) -> list[list[str]]:
    return [
        [str(matrix[i, j]) for j in range(matrix.cols)]
        for i in range(matrix.rows)
    ]


def matrix_digest(matrix: sp.Matrix) -> str:
    payload = json.dumps(
        matrix_strings(matrix), separators=(",", ":"), ensure_ascii=True
    ).encode("ascii")
    return hashlib.sha256(payload).hexdigest()


def rational_summary(value: sp.Expr) -> dict[str, object]:
    value = sp.Rational(value)
    return {
        "exact_value": str(value),
        "nonzero": value != 0,
        "numerator_digits": len(str(abs(value.p))),
        "denominator_digits": len(str(value.q)),
    }


def solve_full_column_rank(matrix: sp.Matrix, rhs: sp.Matrix) -> sp.Matrix:
    solution, free_parameters = matrix.gauss_jordan_solve(rhs)
    require(free_parameters.rows == 0, "Linear system is not uniquely solvable")
    require(matrix * solution == rhs, "Exact linear system residual is nonzero")
    return solution


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--output", type=Path, default=Path("results/exact_certificate.json")
    )
    args = parser.parse_args()

    n = 3
    m = n - 1
    dimension = n * (n + 3) // 2
    unknowns = m * n + n * m * (m - 1) // 2
    rates = sp.Matrix([1, 3, 9])
    interactions = -sp.eye(n)
    initial = sp.Matrix([sp.Rational(1, 2), 1, 3])
    z = sp.Symbol("z", positive=True)

    # Independent logistic trajectories expressed in z=e^t. These are the
    # source model only; the reconstruction below consumes proportions/jets.
    x_symbolic = sp.Matrix(
        [
            sp.cancel(
                rates[i]
                * initial[i]
                * z ** rates[i]
                / (rates[i] + initial[i] * (z ** rates[i] - 1))
            )
            for i in range(n)
        ]
    )
    dt = lambda expression: sp.cancel(z * sp.diff(expression, z))
    x_dot_symbolic = x_symbolic.applyfunc(dt)
    x_ddot_symbolic = x_dot_symbolic.applyfunc(dt)
    require(x_symbolic.subs(z, 1) == initial, "Initial state mismatch")
    logistic_residual = sp.Matrix(
        [
            sp.cancel(
                x_dot_symbolic[i]
                - x_symbolic[i] * (rates[i] - x_symbolic[i])
            )
            for i in range(n)
        ]
    )
    require(logistic_residual == sp.zeros(n, 1), "Logistic equation mismatch")

    total_symbolic = sum(x_symbolic)
    p_symbolic = (x_symbolic / total_symbolic).applyfunc(sp.cancel)
    p_dot_symbolic = p_symbolic.applyfunc(dt)
    p_ddot_symbolic = p_dot_symbolic.applyfunc(dt)
    z_nodes = [sp.Rational(1) + sp.Rational(k, 4) for k in range(dimension)]

    records = []
    for z_value in z_nodes:
        x = x_symbolic.subs(z, z_value)
        x_dot = x_dot_symbolic.subs(z, z_value)
        x_ddot = x_ddot_symbolic.subs(z, z_value)
        total, total_dot, total_ddot = map(sum, (x, x_dot, x_ddot))
        p = x / total
        p_dot = x_dot / total - x * total_dot / total**2
        p_ddot = (
            x_ddot / total
            - 2 * x_dot * total_dot / total**2
            - x * total_ddot / total**2
            + 2 * x * total_dot**2 / total**3
        )
        # A separate symbolic z-differentiation checks the quotient-rule jets.
        require(p == p_symbolic.subs(z, z_value), "Proportion mismatch")
        require(p_dot == p_dot_symbolic.subs(z, z_value), "First jet mismatch")
        require(
            p_ddot == p_ddot_symbolic.subs(z, z_value), "Second jet mismatch"
        )
        require(all(value > 0 for value in p), "Nonpositive proportion")
        require(sum(p) == 1, "Proportions do not sum to one")
        require(sum(p_dot) == 0, "First-jet normalization fails")
        require(sum(p_ddot) == 0, "Second-jet normalization fails")
        q = sp.Matrix(
            [p_dot[i] / p[i] - p_dot[n - 1] / p[n - 1] for i in range(m)]
        )
        records.append(
            {
                "z": z_value,
                "x": x,
                "p": p,
                "p_dot": p_dot,
                "p_ddot": p_ddot,
                "q": q,
                "total": total,
                "total_dot": total_dot,
            }
        )

    # Independently check the sufficient hidden-state excitation certificate.
    # Monomial order: X1,X2,X3,X1^2,X1X2,X1X3,X2^2,X2X3,X3^2.
    monomial_names = ["X1", "X2", "X3"] + [
        f"X{i+1}*X{j+1}" for i in range(n) for j in range(i, n)
    ]
    evaluation = sp.Matrix(
        [
            list(record["x"])
            + [
                record["x"][i] * record["x"][j]
                for i in range(n)
                for j in range(i, n)
            ]
            for record in records
        ]
    )
    excitation_determinant = evaluation.det(method="domain-ge")
    require(excitation_determinant != 0, "Quadratic excitation matrix singular")

    # From this point the lift uses only observed p and p'.
    # Column order: U11,U12,U13,U21,U22,U23,V12,1,V12,2,V12,3.
    rows = []
    for record in records:
        p, q = record["p"], record["q"]
        rows.append(
            [-q[1] * p[k] for k in range(n)]
            + [q[0] * p[k] for k in range(n)]
            + [-p[k] for k in range(n)]
        )
    lift = sp.Matrix(rows)
    kernel = lift.nullspace()
    require(len(kernel) == 1, "Lift kernel does not have dimension one")
    rank = unknowns - len(kernel)
    require(rank == 8, "Expected rank eight for the three-species lift")
    generator = kernel[0]
    require(generator[0] != 0, "Chosen rational normalization chart is invalid")

    # This representative has U11=-2. Its scale relative to the source model
    # is established only after the data-driven recovery, not imposed in it.
    generator = sp.cancel(-2 / generator[0]) * generator
    U = sp.Matrix(m, n, list(generator[: m * n]))
    V = sp.Matrix(list(generator[m * n :]))
    require(U.rank() == 2, "Recovered row-difference rank is below two")
    require(lift * generator == sp.zeros(dimension, 1), "Nonzero lift residual")
    intercept_system = sp.Matrix(
        [[U[1, k], -U[0, k]] for k in range(n)]
    )
    recovered_a = solve_full_column_rank(intercept_system, V)

    effective = []
    for index, record in enumerate(records):
        p, q = record["p"], record["q"]
        u = U * p
        norm_squared = (u.T * u)[0]
        if norm_squared == 0:
            continue
        recovered_total = (u.T * (q - recovered_a))[0] / norm_squared
        require(recovered_total > 0, "Rational kernel representative is reversed")
        recovered_state = recovered_total * p
        record["u"] = u
        record["norm_squared"] = norm_squared
        record["recovered_total"] = recovered_total
        record["recovered_state"] = recovered_state
        effective.append(index)

    require(len(effective) >= n + 1, "Too few effective nodes")
    selected: list[int] = []
    design = sp.zeros(0, n + 1)
    for index in effective:
        new_row = sp.Matrix([[1] + list(records[index]["recovered_state"])])
        candidate = design.col_join(new_row)
        if candidate.rank() > design.rows:
            selected.append(index)
            design = candidate
        if design.rows == n + 1:
            break
    require(design.rows == n + 1, "Affine design has deficient rank")
    design_determinant = design.det(method="domain-ge")
    require(design_determinant != 0, "Selected affine design is singular")

    # Only the selected n+1 nodes use p''. Recover total derivative by the
    # data formula, then fit each entire GLV row by an exact affine solve.
    eta_rows = []
    for index in selected:
        record = records[index]
        p = record["p"]
        p_dot = record["p_dot"]
        p_ddot = record["p_ddot"]
        q_dot = sp.Matrix(
            [
                p_ddot[i] / p[i]
                - (p_dot[i] / p[i]) ** 2
                - p_ddot[n - 1] / p[n - 1]
                + (p_dot[n - 1] / p[n - 1]) ** 2
                for i in range(m)
            ]
        )
        u, norm_squared = record["u"], record["norm_squared"]
        u_dot = U * p_dot
        numerator = (u.T * (record["q"] - recovered_a))[0]
        numerator_dot = (
            u_dot.T * (record["q"] - recovered_a) + u.T * q_dot
        )[0]
        recovered_total_dot = (
            numerator_dot / norm_squared
            - 2 * (u.T * u_dot)[0] * numerator / norm_squared**2
        )
        record["recovered_total_dot"] = recovered_total_dot
        eta_rows.append(
            [
                p_dot[i] / p[i]
                + recovered_total_dot / record["recovered_total"]
                for i in range(n)
            ]
        )
    fitted = solve_full_column_rank(design, sp.Matrix(eta_rows))
    recovered_rates = sp.Matrix(list(fitted.row(0)))
    recovered_interactions = fitted[1:, :].T

    # Compare the recovered model to the independently specified source model.
    true_B = sp.Matrix(
        [list(interactions.row(i) - interactions.row(n - 1)) for i in range(m)]
    )
    recovered_scale = U[0, 0] / true_B[0, 0]
    expected_a = sp.Matrix([rates[i] - rates[n - 1] for i in range(m)])
    require(recovered_scale == 2, "Recovered common scale mismatch")
    require(U == recovered_scale * true_B, "Recovered B is not scaled correctly")
    require(recovered_a == expected_a, "Intercept vector recovery fails")
    require(recovered_rates == rates, "Intrinsic growth recovery fails")
    require(
        recovered_interactions == recovered_scale * interactions,
        "Interaction matrix recovery fails",
    )
    for index in effective:
        record = records[index]
        require(
            record["recovered_total"] == record["total"] / recovered_scale,
            "Scale-total identity fails",
        )
        require(
            record["recovered_state"] == record["x"] / recovered_scale,
            "Scale-state identity fails",
        )
    for index in selected:
        record = records[index]
        require(
            record["recovered_total_dot"]
            == record["total_dot"] / recovered_scale,
            "Recovered total derivative fails",
        )

    # A symbolic check of the n=2 appendix identity and its nonzero witness.
    X, Y = sp.symbols("X Y")
    r1, r2, A11, A12, A21, A22 = sp.symbols("r1 r2 A11 A12 A21 A22")
    b1, b2 = A11 - A21, A12 - A22
    F = b1 * X * (r1 + A11 * X + A12 * Y) + b2 * Y * (
        r2 + A21 * X + A22 * Y
    )
    decomposition = (b1 * X + b2 * Y) * (A11 * X + A22 * Y) + (
        b1 * r1 * X + b2 * r2 * Y
    )
    require(sp.expand(F - decomposition) == 0, "Appendix factor identity fails")
    E = b1 * b2 * (r1 - r2) * (b1 * r1 * A22 - b2 * r2 * A11)
    E_witness = E.subs({r1: 1, r2: 3, A11: 1, A12: 2, A21: 3, A22: 4})
    require(E_witness == 16, "Appendix exceptional polynomial witness fails")

    certificate = {
        "certificate_kind": "exact_rational_finite_jet_example",
        "status": "passed",
        "arithmetic": "exact rational and symbolic polynomial arithmetic",
        "sympy_version": sp.__version__,
        "dimension": n,
        "source_model": {
            "r": matrix_strings(rates),
            "A": matrix_strings(interactions),
            "x_at_t_zero": matrix_strings(initial),
            "coordinate": "z = exp(t); d/dt = z d/dz",
            "x_of_z": [str(entry) for entry in x_symbolic],
        },
        "observation": {
            "z_nodes": [str(value) for value in z_nodes],
            "time_nodes": [f"log({value})" for value in z_nodes],
            "first_jet_nodes": dimension,
            "second_jet_node_indices_zero_based": selected,
            "effective_node_indices_zero_based": effective,
            "positive_proportions_and_jet_normalizations_exact": True,
            "symbolic_and_quotient_rule_jets_agree": True,
        },
        "quadratic_excitation": {
            "matrix_shape": list(evaluation.shape),
            "monomial_order": monomial_names,
            "rank": dimension,
            "determinant": rational_summary(excitation_determinant),
            "matrix_sha256": matrix_digest(evaluation),
        },
        "lift": {
            "matrix_shape": list(lift.shape),
            "columns": [
                "U11", "U12", "U13", "U21", "U22", "U23",
                "V12,1", "V12,2", "V12,3",
            ],
            "rank": rank,
            "nullity": len(kernel),
            "matrix_sha256": matrix_digest(lift),
            "normalization": "U11 = -2; positive recovered total",
            "recovered_U": matrix_strings(U),
            "recovered_V12": matrix_strings(V),
            "recovered_a": matrix_strings(recovered_a),
            "residual_exactly_zero": True,
        },
        "affine_reconstruction": {
            "design_shape": list(design.shape),
            "determinant": rational_summary(design_determinant),
            "design_sha256": matrix_digest(design),
            "recovered_common_scale": str(recovered_scale),
            "recovered_r": matrix_strings(recovered_rates),
            "recovered_scaled_A": matrix_strings(recovered_interactions),
            "all_state_and_parameter_comparisons_exact": True,
        },
        "two_species_appendix_checks": {
            "polynomial_factorization_identity_exact": True,
            "exceptional_polynomial_nonzero_witness": str(E_witness),
        },
        "scope": [
            "Checks one explicit three-species example and two symbolic identities.",
            "Does not prove the general theorems or certify a proof assistant.",
            "Does not evaluate integral quadrature, noisy inference, or biological fit.",
            "Uses first derivatives at nine nodes and second derivatives at four nodes.",
            "The separate continuous-path theorem is derivative-free.",
        ],
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(
        json.dumps(certificate, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    print(
        json.dumps(
            {
                "status": certificate["status"],
                "output": str(args.output),
                "lift_rank": rank,
                "excitation_rank": dimension,
                "affine_rank": n + 1,
                "scale": str(recovered_scale),
                "r": list(map(str, recovered_rates)),
                "scaled_A": matrix_strings(recovered_interactions),
            },
            ensure_ascii=False,
        )
    )


if __name__ == "__main__":
    main()
