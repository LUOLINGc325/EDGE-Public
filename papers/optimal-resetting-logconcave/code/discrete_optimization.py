#!/usr/bin/env python3
"""Unrestricted finite-grid optimization as an independent numerical stress test.

The optimizer sees only a target density, a Laplace kernel matrix, and probability
simplex constraints. It is not given the analytic support, density, endpoint
atoms, or symmetry. Initialization is deliberately asymmetric. The analytic
solution is used only after optimization as a benchmark.

Parameter convention: the Gaussian target is fixed at V(x)=x^2/2 (sigma=1).
The Gaussian runs vary alpha, the Laplace-kernel parameter. The reported
critical dimensionless value is alpha*sigma, equal to alpha because sigma=1.

The objective quadrature is split at every reset site, so kernel derivative
kinks lie on integration-cell boundaries. We compare two quadrature orders and
adaptive whole-line integration, and report a uniform analytic tail bound.
These diagnostics are not certified quadrature enclosures. The reported convex
duality gap certifies optimization only for the finite quadrature objective.

Example:
    OPENBLAS_NUM_THREADS=1 python code/discrete_optimization.py \
        --output results/discrete_optimization.json
"""

from __future__ import annotations

import argparse
import json
import math
from pathlib import Path
import time

import mpmath as mp
import numpy as np
from numpy.polynomial.legendre import leggauss
from scipy.optimize import brentq, minimize

from independent_review import Candidate, GAUSSIAN, QUARTIC, real_integral


OPTIMIZATION_GAP_TOL = 2e-7
INTEGRATION_CHECK_TOL = 2e-9


def quadrature_matrix(target, alpha, Z, sites, truncation, order):
    auxiliary = np.arange(-truncation, truncation+0.125, 0.25)
    knots = np.unique(np.round(np.concatenate((sites, auxiliary)), decimals=12))
    nodes, weights = leggauss(order)
    midpoints = (knots[:-1]+knots[1:])/2
    halfwidths = (knots[1:]-knots[:-1])/2
    x = (midpoints[:, None]+halfwidths[:, None]*nodes[None, :]).reshape(-1)
    dx_weights = (halfwidths[:, None]*weights[None, :]).reshape(-1)
    q = np.array([math.exp(-target.V(float(t)))/Z for t in x])
    matrix = (alpha/2)*np.exp(-alpha*np.abs(x[:, None]-sites[None, :]))
    return matrix, q*dx_weights, len(knots)-1


def objective_and_gradient(weights, matrix, q_weights):
    density = matrix @ weights
    objective = float(np.sum(q_weights/density))
    gradient = -(matrix.T @ (q_weights/density**2))
    return objective, gradient


def refine_pairwise(weights, matrix, q_weights, max_steps=12000):
    """Exact feasible pairwise line searches when SLSQP's value test stalls."""
    weights = weights.copy()
    density = matrix @ weights
    for step_index in range(max_steps):
        objective = float(np.sum(q_weights/density))
        gradient = -(matrix.T @ (q_weights/density**2))
        if -objective-float(np.min(gradient)) <= OPTIMIZATION_GAP_TOL/4:
            return weights, step_index
        entering = int(np.argmin(gradient))
        active = np.flatnonzero(weights > 1e-15)
        leaving = int(active[np.argmax(gradient[active])])
        if entering == leaving:
            return weights, step_index
        direction = matrix[:, entering]-matrix[:, leaving]
        maximum_step = float(weights[leaving])

        def derivative(amount):
            return -float(np.dot(q_weights, direction/(density+amount*direction)**2))

        if derivative(maximum_step) <= 0:
            amount = maximum_step
        else:
            amount = brentq(derivative, 0, maximum_step, xtol=2e-15, rtol=1e-14)
        weights[leaving] -= amount
        weights[entering] += amount
        density += amount*direction
        if (step_index+1) % 50 == 0:
            density = matrix @ weights
    return weights, max_steps


def solve_one(target, alpha, site_count, seed):
    # The same fixed box is used for all cases; no analytic free boundary is used.
    sites = np.linspace(-3.0, 3.0, site_count)
    truncation = 10.0 if target.name == "gaussian" else 6.0
    from scipy.integrate import quad
    Z = 2*quad(lambda x: math.exp(-target.V(x)), 0, np.inf,
               epsabs=1e-12, epsrel=1e-12)[0]
    matrix, q_weights, cells = quadrature_matrix(
        target, alpha, Z, sites, truncation, order=16)

    rng = np.random.default_rng(seed)
    initial = np.exp(-((sites-0.8)/1.4)**2)*(0.6+0.8*rng.random(site_count)) + 0.005
    initial /= np.sum(initial)
    initial_asymmetry = float(np.sum(np.abs(initial-initial[::-1])))
    started = time.perf_counter()
    constraint = {"type": "eq", "fun": lambda w: float(np.sum(w)-1),
                  "jac": lambda w: np.ones_like(w)}
    result = minimize(
        objective_and_gradient, initial, args=(matrix, q_weights), jac=True,
        method="SLSQP", bounds=[(0, 1)]*site_count, constraints=[constraint],
        options={"ftol": 2e-13, "maxiter": 2000, "disp": False})
    weights = np.maximum(result.x, 0)
    weights /= np.sum(weights)
    F16, gradient = objective_and_gradient(weights, matrix, q_weights)
    gap = max(0.0, -F16-float(np.min(gradient)))
    initial_iterations = int(result.nit)
    if gap > OPTIMIZATION_GAP_TOL:
        # This follow-up resolves a concrete residual optimization error.
        result = minimize(
            objective_and_gradient, weights, args=(matrix, q_weights), jac=True,
            method="SLSQP", bounds=[(0, 1)]*site_count, constraints=[constraint],
            options={"ftol": 2e-15, "maxiter": 2000, "disp": False})
        weights = np.maximum(result.x, 0)
        weights /= np.sum(weights)
        F16, gradient = objective_and_gradient(weights, matrix, q_weights)
        gap = max(0.0, -F16-float(np.min(gradient)))
        iterations = initial_iterations+int(result.nit)
    else:
        iterations = initial_iterations
    pairwise_iterations = 0
    if gap > OPTIMIZATION_GAP_TOL:
        weights, pairwise_iterations = refine_pairwise(weights, matrix, q_weights)
        F16, gradient = objective_and_gradient(weights, matrix, q_weights)
        gap = max(0.0, -F16-float(np.min(gradient)))
    elapsed = time.perf_counter()-started

    assert gap <= OPTIMIZATION_GAP_TOL, (target.name, alpha, site_count, "duality gap", gap)
    assert abs(float(np.sum(weights))-1) <= 2e-14
    assert float(np.min(weights)) >= 0

    matrix32, q_weights32, _ = quadrature_matrix(
        target, alpha, Z, sites, truncation, order=32)
    F32 = float(np.sum(q_weights32/(matrix32 @ weights)))

    def exact_grid_integrand(x):
        density = float(np.dot(weights, (alpha/2)*np.exp(-alpha*np.abs(x-sites))))
        # Avoid a harmless 0/0 deep in the tails after both floating values underflow.
        q = math.exp(-target.V(x))/Z
        if q == 0:
            return 0.0
        return q/density

    F_adaptive = real_integral(exact_grid_integrand, sites)
    discrepancy = max(abs(F16-F32), abs(F16-F_adaptive), abs(F32-F_adaptive))
    assert discrepancy <= INTEGRATION_CHECK_TOL*(1+F_adaptive), (
        target.name, alpha, site_count, "quadrature disagreement", discrepancy)

    # Uniform bound over ALL simplex weights on this finite grid:
    # p_w(x) >= (alpha/2) exp[-alpha(|x|+3)], and convexity bounds q's tail.
    tail_log_bound = (math.log(4/alpha)+3*alpha-math.log(Z)
                      -target.V(truncation)+alpha*truncation
                      -math.log(target.Vprime(truncation)-alpha))
    tail_bound = math.exp(tail_log_bound)

    # Analytic shape is introduced only now, for the post hoc benchmark.
    reference = Candidate(target, alpha)
    Fstar = reference.F_formula
    difference = F_adaptive-Fstar
    numerical_allowance = INTEGRATION_CHECK_TOL*(1+Fstar)+discrepancy+tail_bound
    assert difference >= -numerical_allowance, (
        target.name, alpha, site_count, "apparent counterexample exceeds integration tolerance",
        difference, numerical_allowance)
    assert difference/Fstar < 2e-4, (
        target.name, alpha, site_count, "grid fails to approximate optimum", difference/Fstar)

    nonzero = [(float(z), float(w)) for z, w in zip(sites, weights) if w > 1e-9]
    return {
        "target": target.name,
        "target_potential": "V(x)=x^2/2" if target.name == "gaussian" else "V(x)=x^4/4",
        "gaussian_sigma": 1.0 if target.name == "gaussian" else None,
        "alpha": alpha,
        "reset_grid_points": site_count,
        "reset_grid_min": -3.0,
        "reset_grid_max": 3.0,
        "reset_grid_step": float(sites[1]-sites[0]),
        "symmetry_constraint": False,
        "analytic_shape_supplied_to_optimizer": False,
        "initial_L1_asymmetry": initial_asymmetry,
        "final_L1_asymmetry": float(np.sum(np.abs(weights-weights[::-1]))),
        "SLSQP_success": bool(result.success),
        "SLSQP_message": str(result.message),
        "SLSQP_iterations_total": iterations,
        "pairwise_refinement_iterations": pairwise_iterations,
        "optimizer_seconds": elapsed,
        "finite_quadrature_duality_gap": gap,
        "quadrature_order_used_for_optimization": 16,
        "quadrature_cells": cells,
        "integration_truncation": truncation,
        "uniform_tail_upper_bound": tail_bound,
        "F_order16": F16,
        "F_order32": F32,
        "F_adaptive_whole_line": F_adaptive,
        "maximum_quadrature_discrepancy": discrepancy,
        "F_analytic": Fstar,
        "analytic_a_for_posthoc_comparison": reference.a,
        "absolute_gap_to_analytic": difference,
        "relative_gap_to_analytic": difference/Fstar,
        "allowance_for_small_negative_gap": numerical_allowance,
        "nonzero_weights_above_1e_minus_9": [{"x": z, "weight": w} for z, w in nonzero],
        "all_grid_sites": sites.tolist(),
        "all_weights": weights.tolist(),
    }


def high_precision_gaussian():
    mp.mp.dps = 70

    def J(a, alpha):
        b = alpha-a
        return alpha*mp.sqrt(mp.pi/2)*mp.exp(b*b/2)*mp.erfc(-b/mp.sqrt(2))

    critical = mp.findroot(lambda alpha: J(mp.mpf(0), alpha)-1, (mp.mpf("0.49"), mp.mpf("0.52")))
    cases = []
    for alpha in [mp.mpf("0.5"), mp.mpf(1)]:
        A = J(mp.mpf(0), alpha)
        if A <= 1:
            a = mp.mpf(0)
            F = 4/mp.sqrt(2*mp.pi)/alpha**2*A
            atom = None
        else:
            a = mp.findroot(lambda x: J(x, alpha)-1, (mp.mpf(1), mp.mpf("1.5")))
            prefactor = (2*mp.pi)**(-mp.mpf(1)/4)
            denominator = prefactor*(2*mp.sqrt(mp.pi)*mp.erf(a/2)
                                     + 2*mp.exp(-a*a/4)/alpha)
            F = denominator**2
            atom = prefactor*mp.exp(-a*a/4)*(alpha-a/2)/(alpha**2*denominator)
        cases.append({"alpha": mp.nstr(alpha, 55), "A": mp.nstr(A, 55),
                      "a": mp.nstr(a, 55), "F_star": mp.nstr(F, 55),
                      "endpoint_atom_each": None if atom is None else mp.nstr(atom, 55)})
    return {"working_decimal_digits": mp.mp.dps,
            "certified_interval_enclosure": False,
            "target_potential": "V(x)=x^2/2",
            "sigma": 1.0,
            "critical_dimensionless_parameter": "alpha*sigma; sigma=1",
            "critical_alpha": mp.nstr(critical, 55), "cases": cases}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()
    configurations = [(GAUSSIAN, 0.5), (GAUSSIAN, 1.0), (QUARTIC, 1.0)]
    cases = []
    for index, (target, alpha) in enumerate(configurations):
        coarse = solve_one(target, alpha, 61, 917+index)
        fine = solve_one(target, alpha, 121, 1723+index)
        # Grids are nested. Numerical optimization errors, not the theorem,
        # control the tolerance on this monotonicity diagnostic.
        allowance = coarse["finite_quadrature_duality_gap"]+fine["finite_quadrature_duality_gap"]
        allowance += 2*INTEGRATION_CHECK_TOL*(1+coarse["F_analytic"])
        assert fine["F_adaptive_whole_line"] <= coarse["F_adaptive_whole_line"]+allowance
        cases.extend([coarse, fine])
    report = {
        "status": "PASS",
        "scope": "Unrestricted discrete probability weights, no imposed symmetry or analytic shape",
        "limitations": [
            "Only the finite reset grid and finite quadrature objective are optimized numerically.",
            "Quadrature discrepancies are diagnostics, not rigorous interval enclosures.",
            "The convex duality gap applies to the finite quadrature objective.",
            "A tiny negative comparison within numerical allowance is not a mathematical counterexample.",
        ],
        "optimization_duality_gap_tolerance": OPTIMIZATION_GAP_TOL,
        "integration_comparison_tolerance_factor": INTEGRATION_CHECK_TOL,
        "high_precision_gaussian": high_precision_gaussian(),
        "cases": cases,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2, allow_nan=False)+"\n", encoding="utf-8")
    print(json.dumps({"status": "PASS", "output": str(args.output),
                      "cases": [{key: row[key] for key in (
                          "target", "alpha", "reset_grid_points", "F_adaptive_whole_line",
                          "absolute_gap_to_analytic", "finite_quadrature_duality_gap",
                          "maximum_quadrature_discrepancy", "SLSQP_iterations_total")}
                                for row in cases]}, indent=2))


if __name__ == "__main__":
    main()
