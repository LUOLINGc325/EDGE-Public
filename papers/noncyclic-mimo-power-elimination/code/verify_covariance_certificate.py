#!/usr/bin/env python3
"""Exact rational certificate for a deterministic noncyclic Gaussian code.

This is a reproducible mathematical calculation, not Lean/formalization code.
Run with Python and SymPy. No numerical eigensolver is used for certification.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path

import sympy as sp


def matrix_json(matrix: sp.MatrixBase) -> list[list[str]]:
    return [[str(sp.factor(matrix[i, j])) for j in range(matrix.cols)]
            for i in range(matrix.rows)]


def leading_minors(matrix: sp.MatrixBase) -> list[sp.Expr]:
    assert matrix == matrix.T
    return [sp.factor(matrix[:i, :i].det())
            for i in range(1, matrix.rows + 1)]


def require_positive_definite(matrix: sp.MatrixBase) -> list[str]:
    minors = leading_minors(matrix)
    assert all(value.is_positive is True for value in minors), minors
    return [str(value) for value in minors]


def require_zero(matrix: sp.MatrixBase) -> bool:
    assert all(sp.cancel(value) == 0 for value in matrix), matrix
    return True


def certificate() -> dict:
    B = sp.diag(sp.Rational(1, 3), sp.Rational(1, 3), sp.Rational(1, 2))
    A = B.inv()
    H = sp.eye(2)
    Pi = sp.diag(36, 9)
    C = (sp.eye(2) + Pi).inv()
    Gamma = sp.Matrix([[1, 0, 1], [0, 1, 0]])
    Q = sp.eye(3)
    alpha = sp.Integer(100)
    LQ = sp.diag(sp.Rational(1, 8), sp.Rational(1, 8), sp.Rational(1, 3))

    J0 = sp.Matrix(3, 3, lambda i, j: sum(
        Gamma[k, i] * Gamma[k, j]
        * (B[i, i] * B[j, j] - C[k, k]) / (1 - B[i, i] * B[j, j])
        for k in range(2)
    ))
    J = alpha**2 * J0 - LQ
    P = J + alpha**2 * Gamma.T * Gamma
    R = alpha * sp.diag(6, 3) * Gamma
    Fenc = R * P.inv()
    U = R * P.inv() * R.T
    Omega = Pi - U
    K = A * R.T * C
    Fcl = A - K * Fenc
    driving_covariance = Q + K * K.T
    slack_covariance = K * Omega * K.T

    variables = sp.symbols("s11 s12 s13 s22 s23 s33")
    S_template = sp.Matrix([
        [variables[0], variables[1], variables[2]],
        [variables[1], variables[3], variables[4]],
        [variables[2], variables[4], variables[5]],
    ])
    residual = S_template - Fcl * S_template * Fcl.T - driving_covariance
    solutions = sp.solve(
        [residual[i, j] for i in range(3) for j in range(i, 3)],
        variables, dict=True,
    )
    assert len(solutions) == 1
    S = S_template.subs(solutions[0]).applyfunc(sp.factor)
    difference = P - S
    actual_input = (Fenc * S * Fenc.T).applyfunc(sp.factor)
    actual_power = sp.factor(sp.trace(actual_input))
    gap_above_threshold = sp.factor(actual_power - 43)
    gap_below_budget = sp.factor(45 - actual_power)
    assert gap_above_threshold.is_positive is True
    assert gap_below_budget.is_positive is True

    positive_matrices = {
        "J0": J0,
        "J": J,
        "P": P,
        "Pi_minus_U": Omega,
        "Q_plus_KKt": driving_covariance,
        "P_minus_Fcl_P_Fclt": P - Fcl * P * Fcl.T,
        "stationary_error_S": S,
        "P_minus_S": difference,
        "stationary_input_covariance": actual_input,
    }
    minors = {
        name: require_positive_definite(matrix)
        for name, matrix in positive_matrices.items()
    }
    checks = {
        "homogeneous_kernel_equation": require_zero(
            J0 - B * J0 * B.T + Gamma.T * C * Gamma
            - B * Gamma.T * Gamma * B.T
        ),
        "process_noise_gramian": require_zero(LQ - B * LQ * B.T - B * Q * B.T),
        "joint_covariance_schur_complement": require_zero(
            P - R.T * Pi.inv() * R - J
        ),
        "source_riccati_balance": require_zero(
            P - A * P * A.T - Q + A * R.T * C * R * A.T
        ),
        "strict_lyapunov_supersolution": require_zero(
            P - Fcl * P * Fcl.T - driving_covariance - slack_covariance
        ),
        "actual_stationary_lyapunov": require_zero(
            S - Fcl * S * Fcl.T - driving_covariance
        ),
        "difference_lyapunov": require_zero(
            difference - Fcl * difference * Fcl.T - slack_covariance
        ),
    }
    matrices = {
        "A": A, "B": B, "H": H, "Pi": Pi, "C": C,
        "Gamma": Gamma, "Q": Q, "LQ": LQ, "J0": J0, "J": J,
        "P": P, "R": R, "U": U, "Pi_minus_U": Omega,
        "K": K, "Fenc": Fenc, "Fcl": Fcl,
        "stationary_error_S": S, "P_minus_S": difference,
        "stationary_input_covariance": actual_input,
    }
    return {
        "schema_version": 1,
        "status": "pass",
        "arithmetic": "exact rational arithmetic; no numerical eigenvalue certification",
        "sympy_version": sp.__version__,
        "scope": "One deterministic finite-dimensional LTI realization at A=diag(3,3,2), H=I_2, Q=I_3",
        "alpha": str(alpha),
        "encoder": "u_t=Fenc*(x_t-xhat_t)",
        "decoder": "xhat_(t+1)=A*xhat_t+K*y_t",
        "error_dynamics": "e_(t+1)=Fcl*e_t+w_t-K*z_t",
        "stability_reason": "P>0 and P-Fcl*P*Fcl.T>0 imply Fcl is Schur stable",
        "initialization_scope": "Every finite initial error covariance converges to S by Schur stability",
        "matrices": {name: matrix_json(matrix) for name, matrix in matrices.items()},
        "positive_definite_certificates": minors,
        "exact_zero_residual_checks": checks,
        "actual_power": str(actual_power),
        "actual_power_decimal_for_readability_only": str(sp.N(actual_power, 18)),
        "actual_channel_powers_decimal_for_readability_only": [
            str(sp.N(actual_input[i, i], 18)) for i in range(2)
        ],
        "threshold_43_to_be_established_by_general_theorem": "43",
        "actual_power_minus_43": str(gap_above_threshold),
        "45_minus_actual_power": str(gap_below_budget),
        "note": "The certificate proves the realization and 43<p_actual<45; it does not by itself prove the global lower bound 43.",
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).with_name("covariance_certificate.json"))
    args = parser.parse_args()
    result = certificate()
    args.output.write_text(json.dumps(result, indent=2, ensure_ascii=False) + "\n")
    print(json.dumps({
        "status": result["status"],
        "actual_power": result["actual_power"],
        "decimal_for_readability_only": result["actual_power_decimal_for_readability_only"],
        "strict_bounds": "43 < actual_power < 45",
        "output": str(args.output),
    }, ensure_ascii=False))


if __name__ == "__main__":
    main()
