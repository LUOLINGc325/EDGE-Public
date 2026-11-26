#!/usr/bin/env python3
"""Offline finite checks for regret geometry and the nonregular scalar LQR law.

These are reproducible finite numerical examples, not proofs of the general
theorems, asymptotic statements, or novel mathematical claims.  The Chebyshev
examples use a constrained numerical optimizer and a separate linear-program
feasibility test.  The scalar formula is compared with numerical minimization
of its defining convex objective and with direct Gaussian integration.

Run: python code/verify_geometry.py --local-only
"""
from __future__ import annotations

import argparse
import json
import math
from pathlib import Path

import numpy as np
import scipy
from scipy.integrate import quad
from scipy.optimize import linprog, minimize, minimize_scalar
from scipy.stats import norm


SEED = 20261125


def radius_values(center, points, hessian):
    difference = center[None, :] - points
    return 0.5 * np.einsum("ni,ij,nj->n", difference, hessian, difference)


def numerical_chebyshev_center(points, hessian):
    """Solve the finite epigraph problem with analytic constraint Jacobians."""
    dimension = points.shape[1]
    start = np.zeros(dimension + 1)
    start[-1] = float(np.max(radius_values(start[:-1], points, hessian))) + 1.0

    def constraints(value):
        return value[-1] - radius_values(value[:-1], points, hessian)

    def jacobian(value):
        return np.column_stack((-(value[:-1] - points) @ hessian,
                                np.ones(points.shape[0])))

    result = minimize(
        lambda value: value[-1], start,
        jac=lambda value: np.r_[np.zeros(dimension), 1.0],
        constraints=[{"type": "ineq", "fun": constraints, "jac": jacobian}],
        method="SLSQP", options={"ftol": 1e-12, "maxiter": 2000},
    )
    return result, float(np.min(constraints(result.x)))


def zero_in_active_hull(points, hessian):
    """Independently test the zero-center subgradient criterion by an LP."""
    distances = radius_values(np.zeros(points.shape[1]), points, hessian)
    active = points[np.isclose(distances, np.max(distances), rtol=1e-12, atol=1e-12)]
    equality = np.vstack((active.T, np.ones(active.shape[0])))
    target = np.r_[np.zeros(points.shape[1]), 1.0]
    result = linprog(np.zeros(active.shape[0]), A_eq=equality, b_eq=target,
                     bounds=(0.0, None), method="highs")
    return result, active


def scalar_limit_objective(u, *, z, b, q, r, sigma, rho):
    return r * u * u + q * (abs(z + b * u) + rho * sigma) ** 2


def scalar_closed_minimizer(z, *, b, q, r, sigma, rho):
    eta = q * b * b / r
    alpha = eta / (1.0 + eta)
    return -float(np.sign(z)) * min(abs(z), alpha * (abs(z) + rho * sigma)) / b


def gaussian_closed_moment(eta, rho):
    alpha = eta / (1.0 + eta)
    threshold = eta * rho
    density, survival = norm.pdf(threshold), norm.sf(threshold)
    return (1.0 - 2.0 * (1.0 - alpha * alpha) * (threshold * density + survival)
            + 4.0 * alpha * alpha * rho * density
            + 2.0 * alpha * alpha * rho * rho * survival)


def gaussian_integrated_moment(eta, rho):
    alpha = eta / (1.0 + eta)
    threshold = eta * rho

    def integrand(x):
        return 2.0 * min(x, alpha * (x + rho)) ** 2 * norm.pdf(x)

    first, first_error = quad(integrand, 0.0, threshold, epsabs=1e-12,
                              epsrel=1e-12, limit=200)
    second, second_error = quad(integrand, threshold, np.inf, epsabs=1e-12,
                                epsrel=1e-12, limit=200)
    return first + second, first_error + second_error


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--local-only", action="store_true", help="Required explicit offline mode")
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results" / "geometry_checks.json")
    args = parser.parse_args()
    if not args.local_only:
        parser.error("use --local-only; this program performs no network operations")

    rng = np.random.default_rng(SEED)
    checks = []

    def record(name, passed, **data):
        checks.append({"name": name, "passed": bool(passed), **data})

    # A symmetric finite vertex set also determines its compact convex hull.
    # Convex squared distance takes its maximum over that hull at a vertex.
    # Rank-zero and rank-deficient gain maps are intentionally included.
    least_slack = math.inf
    largest_relative_violation = 0.0
    equality_error = 0.0
    inequality_count = 0
    zero_maps = 0
    for case in range(240):
        gain_dimension = 1 + case % 6
        parameter_dimension = 1 + (case // 6) % 5
        factor = rng.normal(size=(gain_dimension, gain_dimension))
        hessian = factor.T @ factor + 0.2 * np.eye(gain_dimension)
        derivative = rng.normal(size=(gain_dimension, parameter_dimension))
        if case % 17 == 0:
            derivative[:] = 0.0
            zero_maps += 1
        elif case % 5 == 0 and gain_dimension > 1:
            derivative[-1] = derivative[0]
        vertices = rng.normal(size=(8, parameter_dimension))
        symmetric_vertices = np.vstack((vertices, -vertices,
                                        np.zeros((1, parameter_dimension))))
        images = symmetric_vertices @ derivative.T
        epsilon = 10.0 ** rng.uniform(-3.0, 1.0)
        baseline = float(np.max(radius_values(np.zeros(gain_dimension), images, hessian)))
        equality_error = max(equality_error, abs(
            float(np.max(radius_values(np.zeros(gain_dimension), epsilon * images, hessian)))
            - epsilon * epsilon * baseline))
        for displacement in epsilon * rng.normal(size=(12, gain_dimension)):
            actual = float(np.max(radius_values(displacement, epsilon * images, hessian)))
            lower = 0.5 * float(displacement @ hessian @ displacement) + epsilon * epsilon * baseline
            slack = actual - lower
            least_slack = min(least_slack, slack)
            largest_relative_violation = max(largest_relative_violation,
                                              max(0.0, -slack) / (1.0 + abs(lower)))
            inequality_count += 1
    record("symmetric_Chebyshev_pair_inequality", largest_relative_violation < 2e-12,
           finite_inequalities=inequality_count, parameter_sets=240,
           zero_derivative_cases=zero_maps, least_raw_slack=least_slack,
           maximum_relative_violation=largest_relative_violation,
           center_equality_maximum_absolute_error=equality_error,
           formula="max_h 0.5||delta-epsilon D h||_H^2 >= 0.5||delta||_H^2 + epsilon^2 max_h 0.5||D h||_H^2")

    # The source sets below are convex hulls of the displayed points and all
    # contain zero.  Symmetry of the source set is deliberately absent.
    geometry_cases = [
        {"label": "asymmetric_interior_point_zero_center",
         "vertices": [[-1., 0.], [1., 0.], [0., .4], [0., 0.]],
         "D": np.eye(2), "H": np.eye(2), "center": [0., 0.]},
        {"label": "asymmetric_equilateral_triangle_zero_center",
         "vertices": [[1., 0.], [-.5, math.sqrt(3.) / 2.],
                      [-.5, -math.sqrt(3.) / 2.], [0., 0.]],
         "D": np.eye(2), "H": np.eye(2), "center": [0., 0.]},
        {"label": "asymmetric_interval_nonzero_center",
         "vertices": [[-1.], [0.], [2.]],
         "D": np.eye(1), "H": np.eye(1), "center": [.5]},
        {"label": "asymmetry_removed_by_derivative_kernel",
         "vertices": [[1., 2.], [-1., 3.], [0., 0.]],
         "D": np.array([[1., 0.]]), "H": np.eye(1), "center": [0.]},
        {"label": "non_Euclidean_metric_zero_center",
         "vertices": [[-.5, 0.], [.5, 0.], [0., .25], [0., 0.]],
         "D": np.eye(2), "H": np.diag([4., 1.]), "center": [0., 0.]},
    ]
    for case in geometry_cases:
        vertices = np.asarray(case["vertices"])
        images = vertices @ case["D"].T
        solution, feasibility_slack = numerical_chebyshev_center(images, case["H"])
        hull, active = zero_in_active_hull(images, case["H"])
        expected = np.asarray(case["center"])
        error = float(np.linalg.norm(solution.x[:-1] - expected))
        zero_expected = bool(np.linalg.norm(expected) == 0.0)
        hull_resolved = hull.success or hull.status == 2  # status 2 = infeasible
        criterion_matches = hull_resolved and bool(hull.success) == zero_expected
        record(case["label"], solution.success and error < 2e-6
               and feasibility_slack > -2e-9 and criterion_matches,
               source_vertices=vertices.tolist(), derivative=case["D"].tolist(),
               hessian=case["H"].tolist(), optimizer_status=str(solution.message),
               numerical_center=solution.x[:-1].tolist(), expected_center=expected.tolist(),
               center_error=error, minimum_epigraph_slack=feasibility_slack,
               active_image_points_at_zero=active.tolist(),
               zero_in_active_convex_hull=bool(hull.success),
               hull_weights=None if not hull.success else hull.x.tolist())

    # An approximate solution may be shifted on the entire epsilon scale when
    # its permitted objective gap is of order epsilon^2.
    tolerance_examples = []
    radius, shift = 1.5, 0.4
    for epsilon in [1e-1, 1e-2, 1e-3, 1e-4, 1e-5, 1e-6]:
        gain = shift * epsilon
        exact_value = (radius * epsilon) ** 2
        candidate_value = (abs(gain) + radius * epsilon) ** 2
        tolerance = (2.0 * radius * abs(shift) + shift * shift) * epsilon * epsilon
        tolerance_examples.append({
            "epsilon": epsilon, "allowed_objective_error": tolerance,
            "actual_objective_error": candidate_value - exact_value,
            "objective_error_over_epsilon_squared": (candidate_value - exact_value) / epsilon**2,
            "gain_error_over_epsilon": gain / epsilon,
            "true_regret_over_epsilon_squared": gain * gain / epsilon**2,
        })
    record("order_epsilon_squared_optimization_tolerance_obstruction",
           all(abs(row["actual_objective_error"] - row["allowed_objective_error"])
               <= 1e-12 * row["allowed_objective_error"]
               and abs(row["gain_error_over_epsilon"] - shift) < 1e-12
               and row["true_regret_over_epsilon_squared"] > .15
               for row in tolerance_examples),
           model="regret(k,theta)=(k-theta)^2; uncertainty=[-1.5 epsilon,1.5 epsilon]",
           consequence="Every displayed candidate is allowed, while its first-order gain shift remains 0.4.",
           examples=tolerance_examples)

    parameter_cases = [
        dict(q=1., r=1., b=1., sigma=1., rho=0.),
        dict(q=1., r=1., b=1., sigma=1., rho=.25),
        dict(q=1., r=1., b=1., sigma=1., rho=1.),
        dict(q=2.5, r=.7, b=-.8, sigma=.6, rho=2.),
        dict(q=.2, r=2., b=1.3, sigma=1.7, rho=.05),
        dict(q=3., r=.5, b=2., sigma=1.2, rho=.5),
        dict(q=.4, r=3., b=-.25, sigma=2., rho=6.),
    ]
    branch_rows = []
    for parameters in parameter_cases:
        eta = parameters["q"] * parameters["b"]**2 / parameters["r"]
        boundary = eta * parameters["rho"] * parameters["sigma"]
        z_values = [-3.0 * parameters["sigma"], -.2 * parameters["sigma"], 0.,
                    .2 * parameters["sigma"], 3.0 * parameters["sigma"]]
        if boundary > 0:
            z_values += [sign * boundary * scale for sign in [-1., 1.]
                         for scale in [.999, 1.0, 1.001]]
        max_gain_error = max_objective_error = 0.0
        optimizers_succeeded = True
        for z in z_values:
            analytic = scalar_closed_minimizer(z, **parameters)
            bound = (1.0 + abs(z / parameters["b"])
                     + math.sqrt(parameters["q"] / parameters["r"])
                     * (abs(z) + parameters["rho"] * parameters["sigma"]))
            objective = lambda u: scalar_limit_objective(u, z=z, **parameters)
            # Brent's relative tolerance can be made tighter than the bounded
            # method's square-root machine-epsilon floor.  That matters at a cusp,
            # where a small gain error gives a first-order objective error.
            # The defining objective is coercive and strictly convex, so its
            # unbounded bracketing search has only one minimum to locate.
            numeric = minimize_scalar(objective, bracket=(-bound, bound), method="brent",
                                      options={"xtol": 1e-13, "maxiter": 2000})
            optimizers_succeeded = optimizers_succeeded and numeric.success
            max_gain_error = max(max_gain_error, abs(numeric.x - analytic) / (1.0 + abs(analytic)))
            max_objective_error = max(max_objective_error,
                                      abs(numeric.fun - objective(analytic)) / (1.0 + abs(numeric.fun)))
        branch_rows.append({**parameters, "eta": eta, "branch_boundary_abs_z": boundary,
                            "tested_z_values": z_values,
                            "maximum_relative_gain_error": max_gain_error,
                            "maximum_relative_objective_error": max_objective_error,
                            "all_optimizers_succeeded": bool(optimizers_succeeded)})
    record("A_zero_scalar_closed_minimizer_against_convex_optimization",
           all(row["all_optimizers_succeeded"] and row["maximum_relative_gain_error"] < 3e-6
               and row["maximum_relative_objective_error"] < 2e-8 for row in branch_rows),
           objective="r u^2 + q (|z+b u| + rho sigma)^2", cases=branch_rows)

    integral_parameters = [(0.05, 0.), (.05, .1), (.05, 10.), (.5, .25), (1., 1.),
                           (3., .7), (12., .5), (1., 20.)]
    integral_parameters += [(float(10**rng.uniform(-1.5, 1.3)),
                             float(10**rng.uniform(-2.0, 1.0))) for _ in range(36)]
    integral_rows = []
    for eta, rho in integral_parameters:
        closed = gaussian_closed_moment(eta, rho)
        integrated, quadrature_error = gaussian_integrated_moment(eta, rho)
        ce = (eta / (1.0 + eta))**2
        integral_rows.append({"eta": eta, "rho": rho, "closed_moment": closed,
                              "quadrature_moment": integrated, "quadrature_error_estimate": quadrature_error,
                              "absolute_difference": abs(closed - integrated),
                              "certainty_equivalent_moment": ce, "excess_over_CE": closed - ce})
    record("A_zero_scalar_normal_integral", all(row["absolute_difference"] < 5e-11
           and -1e-12 <= row["closed_moment"] <= 1.0 + 1e-12
           and (row["rho"] == 0 or row["excess_over_CE"] > 0) for row in integral_rows),
           integrated_quantity="E[min(|X|, eta/(1+eta) (|X|+rho))^2], X standard normal",
           cases=integral_rows)

    # A further finite check uses the *exact* scalar LQR cost, with both A and B
    # uncertain and a correlated positive-definite ellipsoid.  Maximizing over
    # that ellipsoid is analytic because its support in [1,k] is analytic.
    # Minimizing the exact expression is numerical.  This is only a diagnostic
    # at the four displayed radii, not proof of convergence or of its rate.
    b, q, r, sigma, rho, z_b = .8, 1.4, .9, .7, 1.2, -.6
    shape = np.array([[sigma**2, .14], [.14, .36]])
    finite_lqr_rows = []
    for z in [-2.4, -.2, 0., 1.3]:
        limiting = scalar_closed_minimizer(z, b=b, q=q, r=r, sigma=sigma, rho=rho)
        sequence = []
        for epsilon in [.03, .01, .003, .001]:
            def exact_scaled_excess(u):
                k = epsilon * u
                support = math.sqrt(shape[0, 0] + 2.0 * k * shape[0, 1] + k * k * shape[1, 1])
                worst_scaled_closed_loop = abs(z + (b + epsilon * z_b) * u) + rho * support
                denominator = 1.0 - epsilon**2 * worst_scaled_closed_loop**2
                return math.inf if denominator <= 0 else (r * u*u + q * worst_scaled_closed_loop**2) / denominator

            numeric = minimize_scalar(exact_scaled_excess, bounds=(-8., 8.), method="bounded",
                                      options={"xatol": 1e-12, "maxiter": 2000})
            sequence.append({"epsilon": epsilon, "numerical_scaled_gain": float(numeric.x),
                             "limiting_gain": limiting, "absolute_gain_difference": abs(numeric.x - limiting),
                             "gain_difference_over_epsilon": abs(numeric.x - limiting) / epsilon,
                             "optimizer_succeeded": bool(numeric.success)})
        finite_lqr_rows.append({"z_A": z, "sequence": sequence})
    record("finite_exact_scalar_LQR_diagnostic_with_correlated_full_uncertainty",
           all(row["optimizer_succeeded"] and row["gain_difference_over_epsilon"] < 8.0
               for case in finite_lqr_rows for row in case["sequence"]),
           parameters={"b": b, "q": q, "r": r, "sigma": sigma, "rho": rho, "z_B": z_b,
                       "shape": shape.tolist()},
           scope="Finite diagnostic only; it does not establish an asymptotic rate.", cases=finite_lqr_rows)

    output = {
        "method": "Seeded finite quadratic geometry; SLSQP epigraph minimization; LP convex-hull feasibility; Brent and bounded scalar optimization; Gaussian quadrature",
        "scope": "Finite numerical checks only. These results do not replace the general mathematical proofs, global novelty review, or formal verification.",
        "seed": SEED,
        "versions": {"numpy": np.__version__, "scipy": scipy.__version__},
        "normalization": "Quadratic regret geometry uses 0.5 times H norm squared; source parameter Hessian is D.T @ H @ D, with no extra 0.5.",
        "checks": checks,
        "count": len(checks),
        "all_passed": all(row["passed"] for row in checks),
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(output, indent=2, sort_keys=True, allow_nan=False) + "\n", encoding="utf-8")
    print(json.dumps({"checks": len(checks), "all_passed": output["all_passed"],
                      "output": str(args.output)}, sort_keys=True))
    if not output["all_passed"]:
        raise SystemExit(1)


if __name__ == "__main__":
    main()
