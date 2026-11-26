#!/usr/bin/env python3
"""Recompute finite LQR identities from DARE and Gaussian moments.

This is an exact symbolic certificate, not a formal proof or an asymptotic
simulation. No network, Lean, credentials, or external applications are used.
"""
from __future__ import annotations

import argparse
import json
from pathlib import Path

import sympy as sp


def simplify(value):
    return sp.simplify(sp.radsimp(value))


def normal_polynomial_mean(expr, variances):
    """Integrate a polynomial of independent centered Gaussian variables."""
    variables = tuple(variances)
    answer = sp.Integer(0)
    for powers, coefficient in sp.Poly(sp.expand(expr), *variables).terms():
        term = coefficient
        for variable, power in zip(variables, powers):
            if power % 2:
                term = 0
                break
            if power:
                term *= sp.factorial2(power - 1) * variances[variable] ** (power // 2)
        answer += term
    return simplify(answer)


def two_step_fisher(b_values, input_variances):
    """Derive E[z1 z1' + z2 z2'] and score covariance, with x1=0."""
    m = len(b_values)
    first = sp.symbols(f"u1_0:{m}")
    second = sp.symbols(f"u2_0:{m}")
    w1, w2 = sp.symbols("w1 w2")
    variances = {w1: sp.Integer(1), w2: sp.Integer(1)}
    variances.update(dict(zip(first, input_variances)))
    variances.update(dict(zip(second, input_variances)))
    x2 = sum(b * u for b, u in zip(b_values, first)) + w1
    z1, z2 = sp.Matrix([0, *first]), sp.Matrix([x2, *second])
    fisher = (z1 * z1.T + z2 * z2.T).applyfunc(
        lambda e: normal_polynomial_mean(e, variances)
    )
    score = z1 * w1 + z2 * w2
    score_mean = score.applyfunc(lambda e: normal_polynomial_mean(e, variances))
    score_covariance = (score * score.T).applyfunc(
        lambda e: normal_polynomial_mean(e, variances)
    ) - score_mean * score_mean.T
    return fisher, score_mean, score_covariance.applyfunc(simplify)


def derive_scalar_state(a_value, b_values):
    """Differentiate the scalar-state/multi-input DARE, not stated formulas."""
    m = len(b_values)
    a, p = sp.symbols("a p", real=True)
    b = sp.symbols(f"b0:{m}", real=True)
    gains = sp.symbols(f"k0:{m}", real=True)
    theta = (a, *b)
    beta = sum(entry * entry for entry in b)
    riccati_residual = beta * p**2 + (1 - a**2 - beta) * p - 1
    p_derivative = [-sp.diff(riccati_residual, t) / sp.diff(riccati_residual, p) for t in theta]
    optimal_gain = sp.Matrix([-a * p * entry / (1 + beta * p) for entry in b])
    derivative = sp.Matrix([
        [sp.diff(k, t) + sp.diff(k, p) * dp for t, dp in zip(theta, p_derivative)]
        for k in optimal_gain
    ])

    beta_value = sum(entry * entry for entry in b_values)
    linear_coefficient = 1 - a_value**2 - beta_value
    p_value = simplify(
        (-linear_coefficient + sp.sqrt(linear_coefficient**2 + 4 * beta_value))
        / (2 * beta_value)
    )
    substitution = {a: a_value, p: p_value, **dict(zip(b, b_values))}
    k_value = optimal_gain.subs(substitution).applyfunc(simplify)
    d_value = derivative.subs(substitution).applyfunc(simplify)

    closed_loop = a + sum(bj * kj for bj, kj in zip(b, gains))
    cost = (1 + sum(kj * kj for kj in gains)) / (1 - closed_loop**2)
    # The parameter gradient holds the deployed gain fixed. The Hessian holds
    # the model fixed; only after differentiating do we insert the optimum.
    gain_substitution = dict(zip(gains, k_value))
    evaluation = {**substitution, **gain_substitution}
    gradient = sp.Matrix([sp.diff(cost, t) for t in theta]).subs(evaluation).applyfunc(simplify)
    hessian = sp.hessian(cost, gains).subs(evaluation).applyfunc(simplify)
    gain_gradient = sp.Matrix([sp.diff(cost, k) for k in gains]).subs(evaluation).applyfunc(simplify)
    return {
        "riccati_residual": simplify(riccati_residual.subs(substitution)),
        "P": p_value, "K": k_value, "D": d_value,
        "g": gradient, "H": hessian, "gain_gradient": gain_gradient,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--local-only", action="store_true", help="Required explicit offline mode")
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results" / "algebra_checks.json")
    args = parser.parse_args()
    if not args.local_only:
        parser.error("use --local-only; this certificate performs only local symbolic arithmetic")

    checks = []

    def check(name, expression):
        residual = expression.applyfunc(simplify) if isinstance(expression, sp.MatrixBase) else simplify(expression)
        passed = all(entry == 0 for entry in residual) if isinstance(residual, sp.MatrixBase) else residual == 0
        checks.append({"name": name, "residual": str(residual), "passed": bool(passed)})

    V = sp.symbols("V", positive=True)
    m = sp.symbols("m", integer=True, positive=True)
    root5 = sp.sqrt(5)

    # Three inputs exhibit both the distinguished input and exchangeable
    # orthogonal inputs. The general-m aggregation below follows permutation
    # symmetry of the symbolic model, and is separately transparent in output.
    family = derive_scalar_state(sp.Integer(1), [sp.Integer(1), sp.Integer(0), sp.Integer(0)])
    F, score_mean, score_cov = two_step_fisher([1, 0, 0], [1, V, V])
    S = F.inv()
    D, H, g = family["D"], family["H"], family["g"]
    check("dimension_family_DARE", family["riccati_residual"])
    check("dimension_family_stationarity", family["gain_gradient"])
    check("dimension_family_Fisher_from_Gaussian_moments", F - sp.diag(2, 2, 2 * V, 2 * V))
    check("dimension_family_score_centered", score_mean)
    check("dimension_family_score_information_identity", score_cov - F)
    check("dimension_family_direction_identity", D[0, 0] + family["K"][0] * D[0, 1] + 1)

    active_variance = S[0, 0] * D[0, 0] ** 2 + S[1, 1] * D[0, 1] ** 2
    nuisance_per_channel = simplify(H[1, 1] * S[2, 2] * D[1, 2] ** 2 / 2)
    c_ce = simplify(H[0, 0] * active_variance / 2 + (m - 1) * nuisance_per_channel)
    c_bias = simplify(((g.T * S * D.T * H * D * S * g)[0]) / (2 * (g.T * S * g)[0]))
    check("dimension_family_CE_constant", c_ce - (sp.Rational(1, 2) + 3 * root5 / 10 + root5 * (m - 1) / (10 * V)))
    check("dimension_family_cost_bias_constant", c_bias - (sp.Rational(11, 20) + root5 / 4))
    check("dimension_family_nuisance_permutation", D[1, 2] - D[2, 3])

    zero = derive_scalar_state(sp.Rational(1, 2), [sp.Rational(1, 2)])
    da, db, k = zero["D"][0, 0], zero["D"][0, 1], zero["K"][0]
    ratio = simplify(-da / (k * db))
    # Solve the required Fisher variance ratio; do not insert the claimed v.
    v = simplify(1 / (2 * ratio - sp.Rational(1, 4)))
    F_zero, score_mean_zero, score_cov_zero = two_step_fisher([sp.Rational(1, 2)], [v])
    S_zero = F_zero.inv().applyfunc(simplify)
    check("zero_gap_family_DARE", zero["riccati_residual"])
    check("zero_gap_family_stationarity", zero["gain_gradient"])
    check("zero_gap_family_score_centered", score_mean_zero)
    check("zero_gap_family_score_information_identity", score_cov_zero - F_zero)
    check("zero_gap_family_recovered_input_variance", v - 4 / (47 + 24 * root5))
    check("zero_gap_family_derivative_relation", da - 3 * db)
    check("zero_gap_family_DSg", zero["D"] * S_zero * zero["g"])

    # A separate sequence keeps the total input energy equal to one. Derive
    # its low-a coefficients before substituting a=m^-2; do not insert the
    # asserted one-half limits.
    a = sp.symbols("a", positive=True)
    t = sp.symbols("t", positive=True)
    fixed = derive_scalar_state(a, [sp.Integer(1)])
    p_fixed, k_fixed = fixed["P"], fixed["K"][0]
    da_fixed, db_fixed = fixed["D"][0, 0], fixed["D"][0, 1]
    sigma_fixed = 1 / (1 - (a + k_fixed) ** 2)
    sa_fixed, sb_fixed = 1 / (1 + t), 1 / (2 * t)
    ce_fixed = (
        sigma_fixed * (1 + p_fixed) * (sa_fixed * da_fixed**2 + sb_fixed * db_fixed**2)
        + sigma_fixed * (1 / t - 1) * sb_fixed * k_fixed**2
    ).subs(a, t**2)
    penalty_fixed = (
        sigma_fixed * (1 + p_fixed)
        * (sa_fixed * da_fixed + sb_fixed * k_fixed * db_fixed) ** 2
        / (sa_fixed + sb_fixed * k_fixed**2)
    ).subs(a, t**2)
    ce_limit = sp.limit(ce_fixed, t, 0, dir="+")
    penalty_limit = sp.limit(penalty_fixed, t, 0, dir="+")
    check("fixed_energy_CE_limit", ce_limit - sp.Rational(1, 2))
    check("fixed_energy_penalty_per_radius_squared_limit", penalty_limit - sp.Rational(1, 2))
    check("fixed_energy_maximal_ratio_limit", penalty_limit / ce_limit - 1)
    F_fixed, _, score_cov_fixed = two_step_fisher([1, 0, 0], [1 / m, 1 / m, 1 / m])
    check("fixed_energy_Fisher_representative_channels", F_fixed - sp.diag(1 + 1 / m, 2 / m, 2 / m, 2 / m))
    check("fixed_energy_score_information_identity", score_cov_fixed - F_fixed)

    output = {
        "method": "Exact SymPy differentiation of DARE and rational cost; independent Gaussian polynomial moments",
        "arithmetic": "Exact rational and radical expressions, including sqrt(5) and sqrt(a^4+4), and deterministic one-sided function limits",
        "scope": "Finite algebraic identities and deterministic function limits. No statistical asymptotic theorem, global minimax proof, or Lean verification is claimed.",
        "checks": checks,
        "count": len(checks),
        "all_passed": all(row["passed"] for row in checks),
        "dimension_family": {"P": str(family["P"]), "K_m3": str(family["K"]), "D_m3": str(D), "g_m3": str(g), "H_m3": str(H), "F_m3": str(F), "CE_constant_general_m": str(c_ce), "cost_penalty_per_radius_squared": str(c_bias)},
        "zero_gap_family": {"P": str(zero["P"]), "K": str(zero["K"]), "D": str(zero["D"]), "g": str(zero["g"]), "H": str(zero["H"]), "input_variance_derived": str(v), "F": str(F_zero), "S": str(S_zero)},
        "fixed_total_energy_family": {"a": "m^-2", "input_covariance": "I_m/m", "expected_input_energy_per_time": "1", "P_symbolic": str(p_fixed), "K_symbolic": str(k_fixed), "D_symbolic": str(fixed["D"]), "CE_constant_limit": str(ce_limit), "penalty_per_radius_squared_limit": str(penalty_limit), "limit_order": "N tends to infinity at each fixed m, followed by m tending to infinity", "representative_fisher": str(F_fixed)},
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(output, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps({"checks": len(checks), "all_passed": output["all_passed"], "output": str(args.output)}, sort_keys=True))
    if not output["all_passed"]:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
