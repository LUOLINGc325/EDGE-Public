#!/usr/bin/env python3
"""Reproduce the exact symbolic identities used in the contact-branch proof.

Run from any directory:
    python /absolute/path/to/code/verify_contact_algebra.py

Requires SymPy. The checks are exact symbolic equalities, not numerical samples
and not a formal proof of the global optimization argument. Positivity and
domain arguments are supplied in the contact-branch derivation in the manuscript.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path

import sympy as sp


def verify() -> dict[str, bool]:
    checks: dict[str, bool] = {}

    def zero(name: str, expression: sp.Expr) -> None:
        checks[name] = sp.factor(expression) == 0
        if not checks[name]:
            raise AssertionError(f"Exact symbolic identity failed: {name}")

    p, k = sp.symbols("p k", real=True)
    # The proof applies this Hessian only at an interior contact, where r,u,D>0.
    r, u, d, t, b = sp.symbols("r u d t b", positive=True)
    distance_square = r**2 + 1 - 2 * r * u
    objective = distance_square ** (p / 2) - t * r**p + b * (u**2 - sp.Rational(1, 2))

    # Differentiate the original objective before substituting stationarity.
    hessian = sp.hessian(objective, (r, u))
    normalized = hessian.applyfunc(
        lambda value: sp.powsimp(
            value.subs(distance_square, d) / (p * d ** (p / 2 - 1)),
            force=True,
        )
    )
    normalized = normalized.subs(
        t, (r - u) * d ** (p / 2 - 1) / r ** (p - 1)
    ).subs(b, p * r * d ** (p / 2 - 1) / (2 * u))
    normalized = normalized.applyfunc(lambda value: sp.powsimp(value, force=True))
    # Power combination above is valid because all power bases r,d are positive.
    expected = sp.Matrix(
        [
            [
                1 + (p - 2) * (r - u) ** 2 / d - (p - 1) * (r - u) / r,
                -1 - (p - 2) * r * (r - u) / d,
            ],
            [
                -1 - (p - 2) * r * (r - u) / d,
                (p - 2) * r**2 / d + r / u,
            ],
        ]
    )
    for row, column in ((0, 0), (0, 1), (1, 1)):
        zero(f"original_hessian_entry_{row}{column}", normalized[row, column] - expected[row, column])

    # Q/A at a stationary contact, using D=r^2+1-2ru.
    stationary_value = 1 - r * u + p * r * (u**2 - sp.Rational(1, 2)) / (2 * u)
    zero(
        "zero_contact_equation",
        4 * k * stationary_value.subs(u, k * r)
        - (4 * k + 2 * (p - 2) * k**2 * r**2 - p),
    )

    x = (p - 4 * k) / (2 * (p - 2))
    radial_square = x / k**2
    D = 1 + radial_square * (1 - 2 * k)
    N = p - 2 * (p + 2) * k * (1 - k)
    J = -2 * (p + 2) * k**2 + p * (p + 2) * k - p * (p - 1)

    zero("distance_square_parameterization", D - N / (2 * (p - 2) * k**2))
    h_rr = (p - 1) * k - (p - 2) * (1 - x) / D
    h_ru = -(1 + (p - 2) * radial_square * (1 - k) / D)
    h_uu = (p - 2) * radial_square / D + 1 / k
    zero(
        "stationary_hessian_rr_rewrite",
        1 + (p - 2) * radial_square * (1 - k) ** 2 / D
        - (p - 1) * (1 - k) - h_rr,
    )
    zero("hessian_determinant", h_rr * h_uu - h_ru**2 - (p - 2) * J / N)
    zero("quadratic_discriminant", sp.discriminant(J, k) - p * (p + 2) * (p - 2) * (p - 4))

    log_b_derivative = -1 / k + (p - 2) * sp.diff(D, k) / (2 * D)
    zero("log_b_derivative", log_b_derivative - J / (k * N))
    log_t_derivative = -1 / (1 - k) + (p - 2) * (
        sp.diff(N, k) / N + 4 / (p - 4 * k)
    ) / 2
    zero(
        "log_t_derivative",
        log_t_derivative
        - p * (2 * k - 1) * J / ((p - 4 * k) * (k - 1) * N),
    )

    # Exact endpoint/curvature identities supporting the interval sign proofs.
    zero("N_left_endpoint", N.subs(k, p / 4) - p**2 * (p - 2) / 8)
    zero("N_right_endpoint", N.subs(k, (4 - p) / 4) - p**2 * (p - 2) / 8)
    zero("N_convexity", sp.diff(N, k, 2) - 4 * (p + 2))
    zero("N_global_lower_bound_identity", N - (p - 2) / 2 - 2 * (p + 2) * (k - sp.Rational(1, 2)) ** 2)
    zero("J_quarter_endpoint", J.subs(k, p / 4) - p * (p - 2) * (p - 4) / 8)
    zero("J_half_endpoint", J.subs(k, sp.Rational(1, 2)) - (p - 1) * (2 - p) / 2)
    zero("J_one_endpoint", J.subs(k, 1) - (p - 4))
    zero("J_first_derivative", sp.diff(J, k) - (p + 2) * (p - 4 * k))
    zero("J_concavity", sp.diff(J, k, 2) + 4 * (p + 2))
    zero("p4_quadratic", J.subs(p, 4) + 12 * (k - 1) ** 2)
    zero("high_p_endpoint_distance_ratio", (D / radial_square).subs(k, 1) - p / (p - 4))

    # Transition identity from the root contributor's independent calculation.
    q = sp.symbols("q", positive=True)
    transition = (2 * q - 1) * sp.log(2 - 1 / q) - sp.log(2**q - 1)
    claimed_second_derivative = (
        1 / (q**2 * (2 * q - 1))
        + sp.log(2) ** 2 * 2 ** (-q) / (1 - 2 ** (-q)) ** 2
    )
    zero("transition_second_derivative", sp.diff(transition, q, 2) - claimed_second_derivative)

    # The p=1 root simplifies exactly, without floating-point fitting.
    k1 = (3 - sp.sqrt(3)) / 4
    x1 = 2 * k1 - sp.Rational(1, 2)
    r1_square = x1 / k1**2
    d1 = 1 + r1_square * (1 - 2 * k1)
    t1_square = (1 - k1) ** 2 * r1_square / d1
    zero("p1_known_anchor", 1 / t1_square - (6 * sp.sqrt(3) - 8))
    return checks


def main() -> None:
    case_root = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--output", type=Path,
        default=case_root / "research" / "contact_algebra_checks.json",
    )
    args = parser.parse_args()
    checks = verify()
    derivation = case_root / "research" / "contact_branch_derivation.md"
    record = {
        "checks": checks,
        "check_count": len(checks),
        "symbolic_engine": f"SymPy {sp.__version__}",
        "proof_role": "Exact algebra checks only; interval inequalities and the global argument are proved in the derivation.",
        "domains": [
            "Hessian differentiation: r>0, u>0, D=r^2+1-2ru>0, p>=1.",
            "Rational contact identities: p!=2, k!=0, and all displayed denominators nonzero.",
            "Positive power bases justify symbolic power combination; no numerical sampling is used.",
        ],
        "derivation_sha256": hashlib.sha256(derivation.read_bytes()).hexdigest(),
        "verification_script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(record, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps({"status": "pass", "checks": len(checks), "output": str(args.output)}, indent=2))


if __name__ == "__main__":
    main()
