#!/usr/bin/env python3
"""Designed numerical diagnostics, explicitly not mathematical proofs.

The cases exercise a PSD kernel boundary, regularization to positive definite
recurrence, synchronous and nonsynchronous eigenvalue counts, repeated modes,
and slow escape from a zero-input nonhyperbolic equilibrium. Randomness is used
only to choose deterministic orthogonal coordinates, not to search for claims.
"""

from __future__ import annotations

import hashlib
import json
import platform
from pathlib import Path

import numpy as np
import scipy
from scipy.integrate import solve_ivp
from scipy.optimize import brentq, linear_sum_assignment

CASE = Path(__file__).resolve().parents[1]
SEED = 20261126
RNG = np.random.default_rng(SEED)
RECORDS: list[dict] = []
SPECTRAL_TOLERANCE = 1e-8


def field(state, R, W, u, c, ty, ta):
    n = len(u)
    y, a = state[:n], state[n:]
    return np.concatenate(((-y+u+(1-np.sqrt(a))*(R@y))/ty,
                           (-a+c+W@(a*y*y))/ta))


def full_jacobian(y, a, R, W, ty, ta):
    n = len(y)
    s = np.sqrt(a)
    A = (-np.eye(n)+(1-s)[:, None]*R)/ty
    B = np.diag(-(R@y)/(2*s))/ty
    C = 2*W*(a*y)[None, :]/ta
    D = (-np.eye(n)+W*(y*y)[None, :])/ta
    return np.block([[A, B], [C, D]])


def complex_step_jacobian(state, R, W, u, c, ty, ta):
    result = np.empty((len(state), len(state)))
    h = 1e-30
    for j in range(len(state)):
        probe = state.astype(complex)
        probe[j] += 1j*h
        result[:, j] = np.imag(field(probe, R, W, u, c, ty, ta))/h
    return result


def mode_counts(eigenvalues):
    real = np.real(eigenvalues)
    return {"unstable": int(np.sum(real > SPECTRAL_TOLERANCE)),
            "stable": int(np.sum(real < -SPECTRAL_TOLERANCE)),
            "zero_real_part": int(np.sum(np.abs(real) <= SPECTRAL_TOLERANCE))}


def encoded_eigenvalues(eigenvalues):
    return [[float(z.real), float(z.imag)] for z in sorted(eigenvalues, key=lambda z: (z.real, z.imag))]


def spectrum_error(observed, predicted):
    costs = np.abs(observed[:, None]-predicted[None, :])
    rows, columns = linear_sum_assignment(costs)
    return float(np.max(costs[rows, columns]))


def orthogonal_basis(n, constant_first=False):
    matrix = RNG.normal(size=(n, n))
    if constant_first:
        matrix[:, 0] = 1
    q, upper = np.linalg.qr(matrix)
    signs = np.sign(np.diag(upper))
    signs[signs == 0] = 1
    return q*signs[None, :]


def equilibrium_metrics(y, a, R, W, u, c, ty, ta):
    state = np.concatenate((y, a))
    values = field(state, R, W, u, c, ty, ta)
    jac = full_jacobian(y, a, R, W, ty, ta)
    direct_jac = complex_step_jacobian(state, R, W, u, c, ty, ta)
    eigenvalues = np.linalg.eigvals(jac)
    scale = max(1., float(np.max(np.abs(state))))
    return {
        "equilibrium_residual_abs": float(np.max(np.abs(values))),
        "equilibrium_residual_scaled": float(np.max(np.abs(values)))/scale,
        "jacobian_complex_step_error": float(np.max(np.abs(jac-direct_jac))),
        "eigenvalues_real_imag": encoded_eigenvalues(eigenvalues),
        "counts": mode_counts(eigenvalues),
        "spectral_abscissa": float(np.max(eigenvalues.real)),
    }, eigenvalues


def add_record(category, name, passed, **details):
    RECORDS.append({"category": category, "name": name,
                    "status": "diagnostic_passed" if passed else "diagnostic_failed", **details})


def psd_case(name, eigenvalues, Q, modal_input, c, k, ty, ta):
    eigenvalues, modal_input = np.asarray(eigenvalues), np.asarray(modal_input)
    n = len(eigenvalues)
    R = Q@np.diag(eigenvalues)@Q.T
    u = Q@modal_input
    W = np.full((n, n), k)
    beta = float(k*np.sum(modal_input[eigenvalues == 0]**2))

    def normalization(s):
        return c/s**2+k*np.sum((modal_input/(1-eigenvalues+eigenvalues*s))**2)

    lo = np.sqrt(c)
    if np.linalg.norm(modal_input) == 0:
        s = lo
        iterations = 0
    else:
        hi, iterations = max(1., 2*lo), 0
        while normalization(hi) > 1:
            hi *= 2
            iterations += 1
            if iterations > 60:
                raise RuntimeError("No normalization bracket found in a nominally subcritical case")
        s = brentq(lambda ss: normalization(ss)-1, lo, hi, xtol=1e-12, rtol=1e-13)
    y = Q@(modal_input/(1-eigenvalues+eigenvalues*s))
    a = np.full(n, s*s)
    metrics, _ = equilibrium_metrics(y, a, R, W, u, np.full(n, c), ty, ta)
    passed = (metrics["equilibrium_residual_scaled"] < 1e-10
              and metrics["jacobian_complex_step_error"] < 1e-8
              and metrics["counts"] == {"unstable": 0, "stable": 2*n, "zero_real_part": 0})
    add_record("PSD equilibrium", name, passed,
               parameters={"recurrence_spectrum": eigenvalues.tolist(), "modal_input": modal_input.tolist(),
                           "c": c, "k": k, "w": n*k, "tau_y": ty, "tau_a": ta},
               kernel_budget=beta, s=float(s), normalization_error=abs(float(normalization(s)-1)),
               bracket_doublings=iterations, **metrics)


def psd_diagnostics():
    Q = orthogonal_basis(4)
    k, c, ty, ta = 0.7, 1.2, 0.8, 1.3
    for beta in [0., 0.5, 0.95, 0.9999]:
        drives = [np.sqrt(beta/k), 0.25, -0.15, 0.1]
        psd_case(f"singular PSD, beta={beta:g}", [0., 0.2, 0.6, 1.], Q, drives, c, k, ty, ta)
    for beta in [1., 1.05]:
        drives = np.array([np.sqrt(beta/k), 0.25, -0.15, 0.1])
        spectrum = np.array([0., 0.2, 0.6, 1.])
        ss = np.array([np.sqrt(c), 10., 1000.])
        ff = [float(c/s**2+k*np.sum((drives/(1-spectrum+spectrum*s))**2)) for s in ss]
        add_record("PSD budget illustration", f"nominal no-equilibrium budget beta={beta:g}",
                   min(ff) > 1, configured_kernel_budget=beta,
                   sample_s=ss.tolist(), sample_F=ff,
                   status_interpretation="No root search. Finite samples illustrate the exact analytic criterion; they do not prove nonexistence. The beta parameter is nominal before floating-point rounding.")
    # A small positive eigenvalue repairs the same formerly over-budget drive.
    for lam in [0.1, 0.01, 0.001]:
        drives = [np.sqrt(1.05/k), 0.25, -0.15, 0.1]
        psd_case(f"positive-definite repair, smallest eigenvalue={lam:g}",
                 [lam, 0.2, 0.6, 1.], Q, drives, c, k, ty, ta)
    psd_case("zero recurrence with subcritical input", [0., 0.], np.eye(2),
             [0.3, -0.4], 0.8, 2., 0.7, 1.4)
    psd_case("positive-definite zero input", [0.1, 0.6, 1.], orthogonal_basis(3),
             [0., 0., 0.], 0.25, 0.9, 0.7, 1.4)


def synchronous_and_branch_diagnostics():
    configurations = [
        {"name": "two distinct negative modes", "spectrum": [1., 0.4, 0., -0.5, -1.],
         "s0_values": [1.5, 2., 2.4, 3., 3.5]},
        {"name": "repeated negative mode", "spectrum": [1., 0.3, -0.5, -0.5, -1.],
         "s0_values": [1.4]},
        {"name": "repeated unit and negative modes", "spectrum": [1., 1., 0.2, -0.7, -0.7, -0.2],
         "s0_values": [1.6]},
    ]
    w, u0, ty, ta = 2., 0.2, 0.7, 1.1
    for configuration in configurations:
        spectrum = np.asarray(configuration["spectrum"])
        n = len(spectrum)
        Q = orthogonal_basis(n, constant_first=True)
        R = Q@np.diag(spectrum)@Q.T
        W = np.full((n, n), w/n)
        for s0 in configuration["s0_values"]:
            c = s0*s0-w*u0*u0
            y = np.full(n, u0/s0)
            a = np.full(n, s0*s0)
            metrics, actual = equilibrium_metrics(y, a, R, W, np.full(n, u0), np.full(n, c), ty, ta)
            x = u0/s0
            J2 = np.array([[-s0/ty, -x/(2*s0*ty)], [2*w*s0*s0*x/ta, -c/(s0*s0*ta)]])
            predicted = np.concatenate((np.linalg.eigvals(J2),
                                        (-1+(1-s0)*spectrum[1:])/ty,
                                        np.full(n-1, -1/ta))).astype(complex)
            error = spectrum_error(actual, predicted)
            passed = (error < 1e-8 and metrics["counts"] == mode_counts(predicted)
                      and metrics["equilibrium_residual_scaled"] < 1e-10
                      and metrics["jacobian_complex_step_error"] < 1e-8)
            add_record("synchronous spectrum", f"{configuration['name']}, s0={s0:g}", passed,
                       parameters={"recurrence_spectrum": spectrum.tolist(), "s0": s0, "u0": u0,
                                   "c": c, "w": w, "tau_y": ty, "tau_a": ta},
                       predicted_counts=mode_counts(predicted), spectrum_matching_error=error, **metrics)

            for lam in sorted(set(spectrum[spectrum < 0])):
                s = 1-1/lam
                if s <= s0+1e-12:
                    continue
                indices = np.flatnonzero(spectrum == lam)
                # The second orientation tests a genuinely repeated eigenspace.
                directions = [("axis", Q[:, indices[0]])]
                if len(indices) > 1:
                    directions.append(("mixed sphere point", (3*Q[:, indices[0]]+4*Q[:, indices[1]])/5))
                for orientation, direction in directions:
                    radius = np.sqrt((s*s-s0*s0)/(w*s*s))
                    x = u0/s
                    y = x*np.ones(n)+radius*np.sqrt(n)*direction
                    a = np.full(n, s*s)
                    metrics, actual = equilibrium_metrics(y, a, R, W, np.full(n, u0), np.full(n, c), ty, ta)
                    J3 = np.array([[-s/ty, 0., -x/(2*s*ty)],
                                   [0., 0., -lam*radius/(2*s*ty)],
                                   [2*w*s*s*x/ta, 2*w*s*s*radius/ta, -c/(s*s*ta)]])
                    remaining = [spectrum[i] for i in range(n) if i not in [0, indices[0]]]
                    predicted = np.concatenate((np.linalg.eigvals(J3),
                                                (np.asarray(remaining)/lam-1)/ty,
                                                np.full(n-1, -1/ta))).astype(complex)
                    error = spectrum_error(actual, predicted)
                    q = int(np.sum(spectrum < lam))
                    multiplicity = len(indices)
                    counts = {"unstable": q+1, "stable": 2*n-q-multiplicity,
                              "zero_real_part": multiplicity-1}
                    passed = (error < 1e-8 and metrics["counts"] == counts
                              and metrics["equilibrium_residual_scaled"] < 1e-10
                              and metrics["jacobian_complex_step_error"] < 1e-8)
                    add_record("nonsynchronous branch", f"{configuration['name']}, s0={s0:g}, lambda={lam:g}, {orientation}",
                               passed, parameters={"recurrence_spectrum": spectrum.tolist(), "s0": s0,
                                                   "branch_eigenvalue": float(lam), "branch_pole": float(s),
                                                   "r": float(radius), "u0": u0, "c": c, "w": w,
                                                   "tau_y": ty, "tau_a": ta},
                               predicted_counts=counts, spectrum_matching_error=error, **metrics)


def critical_zero_input_diagnostics():
    # Exact nominal parameters: n=2, recurrence eigenvalues 1,-1/2, c=9,
    # w=2, tau_y=tau_a=1. At the critical equilibrium r=0, s=S=3.
    S, lam, w, ty, ta = 3., -0.5, 2., 1., 1.
    B2, theta = w*S/2, -lam/ty
    kappa = theta*B2
    epsilon = 0.08
    for r0 in [0.01, 0.02, 0.04]:
        def rhs(_time, state):
            r, s = state
            return [theta*(s-S)*r,
                    (S*S-s*s+w*s*s*r*r)/(2*ta*s)]

        def exit_event(_time, state):
            return state[0]-epsilon

        exit_event.terminal = True
        exit_event.direction = 1
        conditional_cone_time_bound = (r0**-2-epsilon**-2)/kappa
        solution = solve_ivp(rhs, (0., 1.05*conditional_cone_time_bound+1),
                             [r0, S+B2*r0*r0], method="Radau", rtol=1e-10, atol=1e-12,
                             events=exit_event, dense_output=True)
        escaped = len(solution.t_events[0]) == 1
        event_time = float(solution.t_events[0][0]) if escaped else None
        end_time = event_time if escaped else float(solution.t[-1])
        times = np.unique(np.concatenate((solution.t, np.linspace(0., end_time, 400))))
        trajectory = solution.sol(times)
        rr, ss = trajectory
        z2 = ss-S-B2*rr*rr
        rho = np.sqrt(ta)*np.abs(z2)  # x0=x=0, hence z1 is identically zero.
        cone_ratios = rho/(rr**3)
        cubic_ratios = theta*(ss-S)*rr/(kappa*rr**3)
        passed = (solution.success and escaped and float(np.max(cone_ratios)) < 1
                  and float(np.min(cubic_ratios)) >= 0.5
                  and event_time < conditional_cone_time_bound)
        add_record("critical zero-input trajectory", f"r0={r0:g}", passed,
                   parameters={"u0": 0., "c": 9., "S": S, "lambda_min": lam, "w": w,
                               "tau_y": ty, "tau_a": ta, "r0": r0, "epsilon": epsilon,
                               "B2": B2, "kappa": kappa},
                   solver={"method": "Radau", "rtol": 1e-10, "atol": 1e-12,
                           "success": bool(solution.success), "message": solution.message,
                           "accepted_time_points": len(solution.t), "function_evaluations": solution.nfev},
                   exit_observed=escaped, exit_time=event_time,
                   cone_based_time_bound_conditional_on_invariance=conditional_cone_time_bound,
                   max_observed_rho_over_r_cubed=float(np.max(cone_ratios)),
                   observed_cubic_ratio_range=[float(np.min(cubic_ratios)), float(np.max(cubic_ratios))],
                   final_r=float(rr[-1]),
                   interpretation="Finite trajectories illustrate the zero-input escape mechanism. Neither numerical cone membership nor a zero linear eigenvalue proves nonlinear instability; the manuscript supplies the elementary proof.")


def main():
    psd_diagnostics()
    synchronous_and_branch_diagnostics()
    critical_zero_input_diagnostics()
    passed = sum(item["status"] == "diagnostic_passed" for item in RECORDS)
    categories = sorted(set(record["category"] for record in RECORDS))
    errors = {}
    for key in ["equilibrium_residual_abs", "equilibrium_residual_scaled",
                "jacobian_complex_step_error", "spectrum_matching_error", "normalization_error"]:
        values = [record[key] for record in RECORDS if key in record]
        errors["max_"+key] = max(values) if values else None
    report = {
        "kind": "finite designed numerical diagnostics",
        "status": "diagnostics_passed" if passed == len(RECORDS) else "diagnostics_failed",
        "numerical_not_proof": True,
        "scope": "Designed finite-dimensional examples; no random search claim, global dynamics claim, or independent scientific approval.",
        "seed": SEED,
        "floating_point": "NumPy float64/complex128; exact boundary parameters are nominal before rounding.",
        "spectral_classification_tolerance": SPECTRAL_TOLERANCE,
        "environment": {"python": platform.python_version(), "numpy": np.__version__, "scipy": scipy.__version__},
        "manuscript_sha256_at_run": hashlib.sha256((CASE/"paper.en.md").read_bytes()).hexdigest(),
        "summary": {"cases": len(RECORDS), "passed": passed, "failed": len(RECORDS)-passed,
                    "category_counts": {category: sum(record["category"] == category for record in RECORDS)
                                        for category in categories}, **errors},
        "cases": RECORDS,
    }
    output = CASE/"results"/"numerical.json"
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, indent=2, allow_nan=False)+"\n")
    print(json.dumps({"status": report["status"], **report["summary"], "output": str(output)}))
    if passed != len(RECORDS):
        for record in RECORDS:
            if record["status"] != "diagnostic_passed":
                print(json.dumps(record))
        raise SystemExit(1)


if __name__ == "__main__":
    main()
