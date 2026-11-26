#!/usr/bin/env python3
"""Exact DARE differentiation and independent disk minimax checks for MR curvature.

Run from any directory with --local-only.  The algebra uses exact SymPy
arithmetic; the separate numerical checks use the original regret objective
on a two-dimensional Fisher disk, not a two-model restriction.  Numerical
optimization is a diagnostic, not a certificate of global optimality.
"""
from __future__ import annotations

import argparse
import json
import math
from pathlib import Path

import numpy as np
import scipy
from scipy.optimize import brentq, minimize_scalar
import sympy as sp

from verify_lqr_algebra import simplify, two_step_fisher


def derive_directional_quantities():
    """Differentiate the DARE twice along a Fisher support direction."""
    t, p, gain = sp.symbols("t p gain", real=True)
    root5 = sp.sqrt(5)
    p0 = (1 + root5) / 2
    k0 = (1 - root5) / 2
    # S=I/2, L=I/sqrt(2). The sign is fixed by D L u > 0.
    u = sp.Matrix([-3, 1]) / sp.sqrt(10)
    h = u / sp.sqrt(2)
    a = 1 + h[0] * t
    b = 1 + h[1] * t
    residual = b**2 * p**2 + (1 - a**2 - b**2) * p - 1
    at = {t: 0, p: p0}
    p1 = simplify((-sp.diff(residual, t) / sp.diff(residual, p)).subs(at))
    p2 = simplify((-(
        sp.diff(residual, t, 2)
        + 2 * sp.diff(residual, t, p) * p1
        + sp.diff(residual, p, 2) * p1**2
    ) / sp.diff(residual, p)).subs(at))

    gain_expression = -a * b * p / (1 + b**2 * p)
    y = simplify((sp.diff(gain_expression, t) + sp.diff(gain_expression, p) * p1).subs(at))
    z = simplify((
        sp.diff(gain_expression, t, 2)
        + 2 * sp.diff(gain_expression, t, p) * p1
        + sp.diff(gain_expression, p, 2) * p1**2
        + sp.diff(gain_expression, p) * p2
    ).subs(at))

    cost = (1 + gain**2) / (1 - (a + b * gain)**2)
    H = simplify(sp.diff(cost, gain, 2).subs({t: 0, gain: k0}))
    # Exact performance difference is B(theta,k)*(k-k*(theta))^2.
    # Differentiate with deployed gain held at k0 throughout.
    B = (1 + b**2 * p) / (1 - (a + b * k0)**2)
    B1 = simplify((sp.diff(B, t) + sp.diff(B, p) * p1).subs(at))
    cubic = simplify(H * y * z / 2 + B1 * y**2)
    w = simplify(cubic / (H * y))

    # Independent derivative from the original rational cost and the DARE
    # value P(theta): R'''(k0,theta0)[h,h,h]/6.
    p3 = simplify((-(
        sp.diff(residual, t, 3)
        + 3 * sp.diff(residual, t, t, p) * p1
        + 3 * sp.diff(residual, t, p, p) * p1**2
        + sp.diff(residual, p, 3) * p1**3
        + 3 * (sp.diff(residual, t, p) + sp.diff(residual, p, p) * p1) * p2
    ) / sp.diff(residual, p)).subs(at))
    cubic_from_cost = simplify((sp.diff(cost, t, 3).subs({t: 0, gain: k0}) - p3) / 6)
    F, score_mean, score_cov = two_step_fisher([sp.Integer(1)], [sp.Integer(1)])
    return {
        "u": u, "h": h, "P": p0, "K": k0, "P_first": p1,
        "P_second": p2, "P_third": p3, "y": y, "z": z,
        "H": H, "B1": B1, "cubic": cubic,
        "cubic_from_original_cost": cubic_from_cost,
        "w": w, "F": F, "score_mean": score_mean, "score_cov": score_cov,
    }


def original_regret(k, a, b):
    """Original model-wise regret evaluated without subtractive cancellation."""
    a = np.asarray(a)
    b = np.asarray(b)
    linear = 1 - a * a - b * b
    p = (-linear + np.sqrt(linear * linear + 4 * b * b)) / (2 * b * b)
    optimum = -a * b * p / (1 + b * b * p)
    stability = 1 - (a + b * k) ** 2
    return np.where(stability > 0, (1 + b * b * p) * (k - optimum) ** 2 / stability, np.inf)


def numerical_disk_checks(k0, w, epsilon_values):
    """Search both full semicircles and independently screen the whole disk."""
    direction_angle = math.atan2(1, -3)
    rows = []
    angle_grid = np.linspace(-math.pi, math.pi, 8192, endpoint=False)
    radius_grid = np.linspace(0, 1, 65)

    for epsilon in epsilon_values:
        radius = epsilon / math.sqrt(2)

        def boundary_value(k, angle):
            return float(original_regret(k, 1 + radius * math.cos(angle), 1 + radius * math.sin(angle)))

        def branch_maximum(k, center):
            # First search the entire semicircle, then refine every sampled
            # local peak. This does not assume its maximizer is at +/-u.
            lo, hi = center - math.pi / 2, center + math.pi / 2
            grid = np.linspace(lo, hi, 257)
            values = np.array([boundary_value(k, x) for x in grid])
            candidates = [(float(values[0]), float(grid[0])), (float(values[-1]), float(grid[-1]))]
            for j in range(1, len(grid) - 1):
                if values[j] >= values[j - 1] and values[j] >= values[j + 1]:
                    fitted = minimize_scalar(
                        lambda angle: -boundary_value(k, angle),
                        bounds=(grid[j - 1], grid[j + 1]), method="bounded",
                        options={"xatol": 1e-14, "maxiter": 1000},
                    )
                    candidates.append((-float(fitted.fun), float(fitted.x)))
            return max(candidates)

        def imbalance(k):
            positive, _ = branch_maximum(k, direction_angle)
            negative, _ = branch_maximum(k, direction_angle + math.pi)
            return positive - negative

        # Solve the equalizer of the actual two angular maxima. Each branch
        # is re-optimized as the candidate gain moves.
        fitted_gain = brentq(imbalance, k0 - 2 * epsilon, k0 + 2 * epsilon, xtol=5e-15, rtol=1e-14)
        value_plus, angle_plus = branch_maximum(fitted_gain, direction_angle)
        value_minus, angle_minus = branch_maximum(fitted_gain, direction_angle + math.pi)
        robust_value = max(value_plus, value_minus)

        # Independent outer minimization of the full-boundary maximum.
        def robust_objective(k):
            return max(branch_maximum(k, direction_angle)[0], branch_maximum(k, direction_angle + math.pi)[0])

        outer = minimize_scalar(
            robust_objective, bounds=(k0 - epsilon, k0 + epsilon), method="bounded",
            options={"xatol": 1e-13, "maxiter": 1000},
        )

        # A full-disk scan includes 65 radial levels and 8192 angles; this is
        # diagnostic corroboration, not the mathematical global proof.
        radii = radius_grid[:, None] * radius
        disk_values = original_regret(
            fitted_gain,
            1 + radii * np.cos(angle_grid)[None, :],
            1 + radii * np.sin(angle_grid)[None, :],
        )
        disk_index = np.unravel_index(np.argmax(disk_values), disk_values.shape)
        disk_peak = float(disk_values[disk_index])
        coefficient = (fitted_gain - k0) / epsilon**2
        rows.append({
            "epsilon": epsilon, "ellipsoid_shape": "S=I_2/2",
            "gain": fitted_gain, "gain_shift_per_epsilon_squared": coefficient,
            "predicted_w": w, "coefficient_error": coefficient - w,
            "refined_robust_value": robust_value,
            "active_endpoint_value_difference": value_plus - value_minus,
            "active_angles": [angle_plus, angle_minus],
            "active_angle_shifts_from_leading_directions": [angle_plus - direction_angle, angle_minus - direction_angle - math.pi],
            "full_disk_scan_maximum": disk_peak,
            "full_disk_scan_maximum_radius_fraction": float(radius_grid[disk_index[0]]),
            "full_disk_scan_excess_over_refined_maximum": disk_peak - robust_value,
            "independent_outer_minimizer_gain": float(outer.x),
            "independent_outer_gain_difference": float(outer.x) - fitted_gain,
            "independent_outer_objective_difference": float(outer.fun) - robust_value,
        })
    return rows


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--local-only", action="store_true", required=True)
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results" / "mr_second_order_checks.json")
    args = parser.parse_args()
    derived = derive_directional_quantities()
    root5 = sp.sqrt(5)
    checks = []

    def check(name, value):
        residual = value.applyfunc(simplify) if isinstance(value, sp.MatrixBase) else simplify(value)
        passed = all(x == 0 for x in residual) if isinstance(residual, sp.MatrixBase) else residual == 0
        checks.append({"name": name, "residual": str(residual), "passed": bool(passed)})

    check("actual_two_step_Fisher", derived["F"] - 2 * sp.eye(2))
    check("actual_two_step_score_centered", derived["score_mean"])
    check("actual_two_step_information_identity", derived["score_cov"] - derived["F"])
    check("unit_support_direction", (derived["u"].T * derived["u"])[0] - 1)
    check("Fisher_ellipsoid_support_direction", (derived["h"].T * derived["F"] * derived["h"])[0] - 1)
    check("first_gain_directional_derivative", derived["y"] - (root5 - 1) / 2)
    check("second_gain_directional_derivative", derived["z"] - (sp.Rational(3, 4) - 11 * root5 / 20))
    check("gain_Hessian_from_original_cost", derived["H"] - (3 + 7 * root5 / 5))
    check("performance_weight_directional_derivative", derived["B1"] + sp.Rational(7, 5) + 3 * root5 / 5)
    check("cubic_regret_from_independent_original_cost_derivative", derived["cubic"] - derived["cubic_from_original_cost"])
    check("cubic_regret_coefficient", derived["cubic"] + sp.Rational(19, 20) + 9 * root5 / 20)
    check("second_order_MR_gain_coefficient", derived["w"] + sp.Rational(1, 8) + 7 * root5 / 40)
    penalty = simplify(derived["H"] * derived["w"] ** 2 / 2)
    check("critical_scale_expected_extra_risk", penalty - sp.Rational(13, 32) - 147 * root5 / 800)
    c_ce = sp.Rational(1, 2) + 3 * root5 / 10
    check("critical_scale_risk_ratio_increment", penalty / c_ce - sp.Rational(29, 80) - 3 * root5 / 20)

    numerical = numerical_disk_checks(float(derived["K"]), float(derived["w"]), [0.1, 0.05, 0.02, 0.01, 0.005, 0.002])
    numerical_checks = {
        "coefficient_error_decreases": all(abs(b["coefficient_error"]) < abs(a["coefficient_error"]) for a, b in zip(numerical, numerical[1:])),
        "smallest_radius_coefficient_error_below_1e_minus_5": abs(numerical[-1]["coefficient_error"]) < 1e-5,
        "full_disk_scan_never_exceeds_refined_peak_by_1e_minus_12": all(row["full_disk_scan_excess_over_refined_maximum"] < 1e-12 for row in numerical),
        "disk_peak_on_boundary": all(row["full_disk_scan_maximum_radius_fraction"] == 1.0 for row in numerical),
        "independent_outer_minimizer_agrees_to_1e_minus_7": all(abs(row["independent_outer_gain_difference"]) < 1e-7 for row in numerical),
    }
    output = {
        "scope": "Exact scalar-state two-unknown-parameter LQR derivatives and numerical full-disk diagnostics; no formal verification and no numerical proof of global optimality.",
        "objective": "min_k max_theta [C(k,theta)-C(k*(theta),theta)]",
        "parameter_order": ["a", "b"], "true_model": [1, 1],
        "ellipsoid": "theta=(1,1)+epsilon L u, L=I_2/sqrt(2), ||u||<=1",
        "support_sign_convention": "y=D L u is positive",
        "exact_derived_quantities": {key: str(value) for key, value in derived.items()},
        "exact_expected_extra_risk_coefficient": str(penalty),
        "exact_checks": checks, "exact_check_count": len(checks),
        "exact_all_passed": all(row["passed"] for row in checks),
        "numerical_disk_results": numerical,
        "numerical_diagnostics": numerical_checks,
        "numerical_all_passed": all(numerical_checks.values()),
        "runtime_versions": {"sympy": sp.__version__, "numpy": np.__version__, "scipy": scipy.__version__},
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(output, indent=2, sort_keys=True) + "\n", encoding="utf-8")
    print(json.dumps({"exact_checks": len(checks), "exact_all_passed": output["exact_all_passed"], "numerical_all_passed": output["numerical_all_passed"], "output": str(args.output)}, sort_keys=True))
    if not output["exact_all_passed"] or not output["numerical_all_passed"]:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
