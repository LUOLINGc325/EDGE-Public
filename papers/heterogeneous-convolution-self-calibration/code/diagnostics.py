#!/usr/bin/env python3
"""Finite diagnostics for heterogeneous convolution self-calibration.

This script checks selected identities, quadratures and examples.  The minimax theorem is proved in the manuscript.  Integration error estimates from SciPy
are explicitly separated from analytic truncation envelopes.

Run from any directory:
    python3 code/diagnostics.py
The sole generated output is ../results/diagnostics.json.
"""

from __future__ import annotations

import json
import math
import platform
from datetime import datetime, timezone, timedelta
from pathlib import Path

import numpy as np
import scipy
from scipy.integrate import quad, quad_vec
from scipy.special import gamma, gammaincc
from scipy.stats import norm
import sympy as sp


SEED = 20261126
BANDWIDTH = 4.0
SHIFT = math.pi / 2.0
M2_ETA = 0.75 + math.pi**2 / 6.0
PARAMS = {
    "s": 1.25,
    "b": 0.8,
    "kappa": 0.15,
    "lambda": 0.08,
    "epsilon": 0.4,
    "stable_coefficient": 0.04,
    "A": 3.0,
    "L": 2.0,
    "M": 3.0,
}


def sinc4(x):
    return np.sinc(np.asarray(x) / np.pi) ** 4


def eta_density(x):
    x = np.asarray(x)
    return (sinc4(x) + sinc4(x - SHIFT) + sinc4(x + SHIFT)) / (2.0 * np.pi)


def eta_cf(t):
    t = np.asarray(t)
    u = np.abs(t)
    cubic = np.maximum(4.0 - u, 0.0) ** 3 - 4.0 * np.maximum(2.0 - u, 0.0) ** 3
    return (1.0 + 2.0 * np.cos(np.pi * t / 2.0)) * cubic / 96.0


def eta_tail_envelopes(radius):
    """Exact analytic envelopes, evaluated in floating-point arithmetic."""
    r = float(radius)
    a = SHIFT
    if r <= a:
        raise ValueError("The tail envelope requires radius > pi/2.")
    mass = (r ** -3 + (r - a) ** -3 + (r + a) ** -3) / (3.0 * math.pi)
    positive = 1.0 / (r - a) + a / (r - a) ** 2 + a * a / (3.0 * (r - a) ** 3)
    negative = 1.0 / (r + a) - a / (r + a) ** 2 + a * a / (3.0 * (r + a) ** 3)
    second = (1.0 / r + positive + negative) / math.pi
    return {
        "mass_tail_bound": mass,
        "second_moment_tail_bound": second,
        "status": "analytic envelope evaluated in binary64; not interval arithmetic",
    }


def spatial_eta_checks():
    frequencies = np.array([0.0, 0.25, 0.8, 1.5, 2.0, 2.7, 3.8, 4.0, 4.2, 7.3])
    records = []
    for radius in (64.0, 128.0):
        points = np.linspace(-radius, radius, int(2 * radius) + 1)

        def integrand(x):
            value = float(eta_density(x))
            return value * np.concatenate(([1.0, x * x], np.cos(frequencies * x)))

        values, estimated_error = quad_vec(
            integrand, -radius, radius, epsabs=2e-11, epsrel=2e-11,
            norm="max", points=points, limit=10000,
        )
        tails = eta_tail_envelopes(radius)
        mass_allowance = tails["mass_tail_bound"] + 8 * float(estimated_error) + 1e-10
        moment_allowance = tails["second_moment_tail_bound"] + 8 * float(estimated_error) + 1e-10
        exact_cf = eta_cf(frequencies)
        errors = np.abs(values[2:] - exact_cf)
        assert abs(float(values[0]) - 1.0) <= mass_allowance
        assert abs(float(values[1]) - M2_ETA) <= moment_allowance
        assert float(np.max(errors)) <= mass_allowance
        records.append({
            "radius": radius,
            "quadrature": "scipy.integrate.quad_vec, direct spatial density",
            "quadrature_estimated_abs_error_max_norm": float(estimated_error),
            "quadrature_error_is_rigorous": False,
            "tail_envelopes": tails,
            "mass_integral_truncated": float(values[0]),
            "mass_target": 1.0,
            "mass_absolute_difference": abs(float(values[0]) - 1.0),
            "second_moment_integral_truncated": float(values[1]),
            "second_moment_target": M2_ETA,
            "second_moment_absolute_difference": abs(float(values[1]) - M2_ETA),
            "cf_comparisons": [
                {"t": float(t), "spatial_integral_truncated": float(v),
                 "closed_formula": float(e), "absolute_difference": float(err)}
                for t, v, e, err in zip(frequencies, values[2:], exact_cf, errors)
            ],
            "within_analytic_tail_plus_numerical_allowance": True,
        })
    grid = np.unique(np.concatenate((
        np.linspace(-200.0, 200.0, 16001),
        np.array([0.0, SHIFT, -SHIFT]),
    )))
    scaled = eta_density(grid) * (1.0 + grid * grid) ** 2
    lower = 1.0 / (2.0 * math.pi * (1.0 + SHIFT * SHIFT) ** 2)
    assert float(np.min(scaled)) >= lower
    return {
        "seed": None,
        "deterministic": True,
        "truncated_quadratures": records,
        "tail_lower_bound_grid": {
            "grid_size": int(grid.size),
            "grid_interval": [-200.0, 200.0],
            "sampled_min_eta_times_one_plus_x2_squared": float(np.min(scaled)),
            "analytic_global_lower_bound": lower,
            "finite_grid_does_not_prove_global_bound": True,
        },
    }


def symbolic_eta_checks():
    t = sp.symbols("t", real=True)
    r0 = 2 * sp.pi / 3 - sp.pi * t**2 / 4 + sp.pi * t**3 / 16
    r1 = sp.pi * (4 - t) ** 3 / 48
    factor = (1 + 2 * sp.cos(sp.pi * t / 2)) / (2 * sp.pi)
    e0, e1 = factor * r0, factor * r1
    records = []
    for boundary, left, right in [(2, e0, e1), (4, e1, sp.Integer(0))]:
        for order in range(3):
            residual = sp.simplify(
                sp.diff(left, t, order).subs(t, boundary)
                - sp.diff(right, t, order).subs(t, boundary)
            )
            assert residual == 0
            records.append({"boundary": boundary, "derivative_order": order,
                            "exact_residual": str(residual), "passed": True})
    targets = [(0, sp.Integer(1)), (1, sp.Integer(0)),
               (2, -sp.Rational(3, 4) - sp.pi**2 / 6)]
    for order, target in targets:
        residual = sp.simplify(sp.diff(e0, t, order).subs(t, 0) - target)
        assert residual == 0
        records.append({"boundary": 0, "derivative_order": order,
                        "exact_residual": str(residual), "passed": True})
    return {
        "seed": None, "deterministic": True,
        "engine": "SymPy exact expressions",
        "checked_finite_symbolic_identities": len(records),
        "checks": records,
        "scope": "C2 matching at 2 and 4, mass, even-origin derivative and second moment; negative side follows evenness in the written proof",
        "does_not_prove_minimax_theorem": True,
    }


def cp_exponent(t, sign, frequency):
    t = np.asarray(t)
    h = eta_cf(t - frequency) + eta_cf(t + frequency)
    return PARAMS["lambda"] * (1.0 - eta_cf(t)) - sign * PARAMS["lambda"] * PARAMS["epsilon"] * h / 2.0


def levy_spatial_checks():
    radius, frequency = 64.0, 12.0
    ts = np.array([0.0, 0.3, 4.2, 10.5, 12.0, 13.5, 17.0])
    points = np.linspace(-radius, radius, 257)
    lam, eps = PARAMS["lambda"], PARAMS["epsilon"]
    output = []
    tails = eta_tail_envelopes(radius)
    for sign in (-1, 1):
        def integrand(x):
            value = lam * float(eta_density(x)) * (1.0 + sign * eps * math.cos(frequency * x))
            return value * np.concatenate(([1.0, x * x], 1.0 - np.cos(ts * x)))
        values, error = quad_vec(
            integrand, -radius, radius, epsabs=2e-10, epsrel=2e-10,
            norm="max", points=points, limit=10000,
        )
        mass_tail = lam * (1.0 + eps) * tails["mass_tail_bound"]
        moment_tail = lam * (1.0 + eps) * tails["second_moment_tail_bound"]
        psi_tail = 2.0 * mass_tail
        computed = cp_exponent(ts, sign, frequency)
        assert abs(float(values[0]) - lam) <= mass_tail + 8 * float(error) + 1e-10
        assert abs(float(values[1]) - lam * M2_ETA) <= moment_tail + 8 * float(error) + 1e-10
        assert float(np.max(np.abs(values[2:] - computed))) <= psi_tail + 8 * float(error) + 1e-10
        output.append({
            "sign": sign, "T": frequency, "radius": radius,
            "mass_integral_truncated": float(values[0]), "mass_target": lam,
            "second_moment_integral_truncated": float(values[1]),
            "second_moment_target": lam * M2_ETA,
            "quadrature_estimated_abs_error_max_norm": float(error),
            "quadrature_error_is_rigorous": False,
            "analytic_tail_envelopes": {"mass": mass_tail, "second_moment": moment_tail, "exponent": psi_tail},
            "cp_exponent_comparisons": [
                {"t": float(t), "spatial_integral_truncated": float(v),
                 "closed_formula": float(e), "absolute_difference": abs(float(v - e))}
                for t, v, e in zip(ts, values[2:], computed)
            ],
            "passed_finite_checks": True,
        })
    return {"seed": None, "deterministic": True, "records": output}


def alpha(frequency):
    return PARAMS["kappa"] * (1.0 + frequency * frequency) ** (-PARAMS["s"] / 2.0)


def q_density(x, frequency):
    x = np.asarray(x)
    b = PARAMS["b"]
    c = math.exp(-b * frequency * frequency / 2.0)
    return np.exp(-x*x/(2*b)) / math.sqrt(2*math.pi*b) * (1.0 + alpha(frequency) * (np.cos(frequency*x) - c))


def q_cf(t, frequency):
    t = np.asarray(t)
    b, a = PARAMS["b"], alpha(frequency)
    return ((1.0-a*math.exp(-b*frequency*frequency/2.0))*np.exp(-b*t*t/2.0)
            + a/2.0*(np.exp(-b*(t-frequency)**2/2.0)+np.exp(-b*(t+frequency)**2/2.0)))


def signal_cf(t, frequency, mean_design, sign):
    return q_cf(t, frequency) * np.exp(-mean_design * cp_exponent(t, sign, frequency))


def hs_tail_bound(frequency, outer_gap):
    s, b = PARAMS["s"], PARAMS["b"]
    a = alpha(frequency)
    coeff_squares = (1.0-a*math.exp(-b*frequency*frequency/2.0))**2 + a*a/2.0
    upper_gamma = gamma(s+0.5) * gammaincc(s+0.5, b*outer_gap*outer_gap)
    return (3.0/(2.0*math.pi) * coeff_squares * 2.0**(2*s) * (1.0+frequency*frequency)**s
            * b**(-s-0.5) * float(upper_gamma))


def signal_checks():
    b, s, mean_design = PARAMS["b"], PARAMS["s"], 1.7
    records = []
    for frequency in (10.0, 14.0, 20.0, 28.0, 40.0):
        radius = 10.0 * math.sqrt(b)
        def integrand(x):
            value = float(q_density(x, frequency))
            return np.array([value, x*x*value])
        values, spatial_error = quad_vec(integrand, -radius, radius, epsabs=2e-11, epsrel=2e-11, limit=2000)
        target_second = b-alpha(frequency)*b*b*frequency*frequency*math.exp(-b*frequency*frequency/2.0)
        signal_second = target_second+mean_design*PARAMS["lambda"]*M2_ETA
        assert signal_second < PARAMS["M"]
        z = radius/math.sqrt(b)
        mass_tail = (1.0+2.0*PARAMS["kappa"]) * 2.0*norm.sf(z)
        moment_tail = (1.0+2.0*PARAMS["kappa"]) * 2.0*b*(z*norm.pdf(z)+norm.sf(z))
        assert abs(float(values[0])-1.0) <= mass_tail+8*float(spatial_error)+1e-10
        assert abs(float(values[1])-target_second) <= moment_tail+8*float(spatial_error)+1e-10
        xgrid = np.linspace(-12*math.sqrt(b), 12*math.sqrt(b), 4001)
        bracket = 1.0+alpha(frequency)*(np.cos(frequency*xgrid)-math.exp(-b*frequency*frequency/2.0))
        assert float(np.min(bracket)) >= 1.0-2.0*PARAMS["kappa"]

        gap = 12.0/math.sqrt(b)
        cutoff = frequency+gap
        points = sorted(set([-frequency, 0.0, frequency, -BANDWIDTH, BANDWIDTH,
                             -frequency-BANDWIDTH, -frequency+BANDWIDTH,
                             frequency-BANDWIDTH, frequency+BANDWIDTH]))
        norm_values = {}
        norm_errors = {}
        for label, func in [
            ("q", lambda t: q_cf(t, frequency)),
            ("f1", lambda t: signal_cf(t, frequency, mean_design, -1)),
            ("f2", lambda t: signal_cf(t, frequency, mean_design, 1)),
        ]:
            value, error = quad(lambda t: (1+t*t)**s * float(func(t))**2 / (2*math.pi),
                                -cutoff, cutoff, points=points, epsabs=2e-12, epsrel=2e-11, limit=2000)
            norm_values[label] = float(value)
            norm_errors[label] = float(error)
        tail = hs_tail_bound(frequency, gap)
        assert norm_values["q"]+tail+8*norm_errors["q"] < PARAMS["L"]**2
        assert norm_values["f1"] <= norm_values["q"]+8*sum(norm_errors.values())+1e-10
        assert norm_values["f2"] <= norm_values["q"]+8*sum(norm_errors.values())+1e-10
        lower, upper = frequency-BANDWIDTH, frequency+BANDWIDTH
        distance, distance_error = quad(
            lambda t: float(signal_cf(t, frequency, mean_design, 1)-signal_cf(t, frequency, mean_design, -1))**2/math.pi,
            lower, upper, points=[frequency-2, frequency, frequency+2],
            epsabs=1e-19, epsrel=2e-11, limit=1000,
        )
        assert distance > 100 * distance_error and distance > 0
        records.append({
            "T": frequency, "alpha": alpha(frequency), "mean_design": mean_design,
            "positivity_grid": {"size": int(xgrid.size), "minimum_bracket": float(np.min(bracket)),
                                "analytic_lower_bound": 1.0-2.0*PARAMS["kappa"]},
            "q_spatial_quadrature": {
                "radius": radius, "mass": float(values[0]), "second_moment": float(values[1]),
                "second_moment_formula": target_second, "second_moment_upper_bound": b,
                "estimated_abs_error": float(spatial_error), "error_is_rigorous": False,
                "analytic_tail_bounds": {"mass": float(mass_tail), "second_moment": float(moment_tail)},
            },
            "signal_second_moment_formula": signal_second,
            "signal_moment_limit": PARAMS["M"],
            "hs_norm_squared_truncated": norm_values,
            "hs_quad_estimated_errors": norm_errors,
            "hs_cutoff": cutoff, "hs_analytic_tail_envelope_for_q_and_signals": tail,
            "hs_radius_squared": PARAMS["L"]**2,
            "signal_l2_distance_squared": float(distance),
            "signal_l2_distance_quad_estimated_error": float(distance_error),
            "signal_l2_distance_fourier_tail": 0.0,
            "signal_l2_distance_tail_reason": "CF difference is exactly supported on the two bands; evenness accounts for the negative band",
            "scaled_distance_times_one_plus_T2_to_s": float(distance*(1+frequency*frequency)**s),
            "passed_finite_checks": True,
        })
    return {"seed": None, "deterministic": True, "records": records,
            "scope": "Finite T values and one declared parameter tuple; no Monte Carlo risk fit or global Sobolev proof."}


def characteristic_identity_checks():
    rng = np.random.default_rng(SEED)
    designs = {
        "equal": np.full(9, 1.5),
        "unbalanced": np.array([1.0]*19+[2.8]),
        "all_distinct": np.sort(rng.uniform(1.0, 3.0, size=13)),
        "nearly_equal": 1.5+np.linspace(-1e-4, 1e-4, 16),
    }
    records = []
    for name, design in designs.items():
        mean = float(np.mean(design))
        weights = design-mean
        information = float(np.dot(weights, weights))
        for beta in (0.7, 1.5, 2.0):
            for frequency in (12.0, 24.0):
                ts = np.unique(np.concatenate((
                    np.linspace(-frequency-5, frequency+5, 1201),
                    np.array([0, frequency-4, frequency, frequency+4,
                              -frequency-4, -frequency, -frequency+4]),
                )))
                jp, jm = cp_exponent(ts, 1, frequency), cp_exponent(ts, -1, frequency)
                h = eta_cf(ts-frequency)+eta_cf(ts+frequency)
                first_signal = signal_cf(ts, frequency, mean, -1)
                second_signal = signal_cf(ts, frequency, mean, 1)
                max_absolute, max_scaled, max_outside = 0.0, 0.0, 0.0
                max_direct_difference = 0.0
                for a, w in zip(design, weights):
                    stable = PARAMS["stable_coefficient"] * np.abs(ts)**beta
                    direct_p = first_signal*np.exp(-a*(stable+jp))
                    direct_q = second_signal*np.exp(-a*(stable+jm))
                    direct = direct_p-direct_q
                    common = (q_cf(ts, frequency)*np.exp(-a*stable)
                              *np.exp(-(mean+a)*PARAMS["lambda"]*(1-eta_cf(ts))))
                    centered = common*2*np.sinh(w*PARAMS["lambda"]*PARAMS["epsilon"]*h/2)
                    error = np.abs(direct-centered)
                    max_absolute = max(max_absolute, float(np.max(error)))
                    active = np.abs(h) > 1e-14
                    if np.any(active):
                        max_scaled = max(max_scaled, float(np.max(error[active]/np.maximum(common[active], 1e-280))))
                    max_outside = max(max_outside, float(np.max(np.abs(direct[~active]))))
                    max_direct_difference = max(max_direct_difference, float(np.max(np.abs(direct))))
                assert max_absolute < 2e-14
                assert max_scaled < 1e-12
                assert max_outside < 2e-14
                if name == "equal":
                    assert information == 0.0
                    # Distinct exponential evaluation orders need not produce
                    # bit-identical products. The centered expression is
                    # exactly zero here; the direct expression is checked at
                    # the stated binary64 roundoff allowance.
                    assert max_direct_difference < 2e-14
                records.append({
                    "design": name, "a": design.tolist(), "N": int(design.size),
                    "mean": mean, "I": information, "beta": beta, "T": frequency,
                    "frequency_grid_size": int(ts.size),
                    "max_absolute_identity_error": max_absolute,
                    "max_error_divided_by_common_cf_factor_on_active_band": max_scaled,
                    "max_direct_difference_off_active_band": max_outside,
                    "max_direct_difference": max_direct_difference,
                    "absolute_roundoff_allowance": 2e-14,
                    "common_factor_scaled_roundoff_allowance": 1e-12,
                    "equal_design_centered_expression_exactly_zero": name == "equal",
                    "passed_finite_checks": True,
                })
    return {"seed": SEED, "rng": "numpy.random.default_rng / PCG64",
            "randomness_used_only_for_one_fixed_distinct_design": True,
            "records": records}


def zero_frequency_example():
    seed = SEED+1
    rng = np.random.default_rng(seed)
    design = np.array([1.0]*96+[2.5]*32)
    weights = design-design.mean()
    frequency = math.pi/2
    b, stable_coefficient, envelope_constant = 0.4, 0.04, 0.2
    x = rng.choice(np.array([-1.0, 1.0]), size=design.size)+rng.normal(0.0, math.sqrt(b), size=design.size)
    y = x+rng.normal(0.0, np.sqrt(2*stable_coefficient*design))
    exponent_grid = np.linspace(0.0, envelope_constant*(1+frequency**2), 501)
    phase = np.exp(1j*frequency*y)
    scores = np.array([np.sum(weights*np.exp(design*u)*phase) for u in exponent_grid])
    index = int(np.argmin(np.abs(scores)))
    selected = float(exponent_grid[index])
    raw = complex(np.mean(np.exp(design*selected)*phase))
    clipped = raw/max(1.0, abs(raw))
    population_cf_roundoff = math.exp(-b*frequency**2/2)*math.cos(frequency)
    assert np.isfinite(scores).all()
    assert math.isfinite(raw.real) and math.isfinite(raw.imag)
    assert abs(clipped) <= 1.0+1e-14
    return {
        "seed": seed, "rng": "numpy.random.default_rng / PCG64",
        "N": int(design.size), "a": design.tolist(),
        "signal": "equal mixture N(-1,0.4) and N(1,0.4)",
        "frequency": frequency,
        "signal_cf_exact": "exp(-0.4*t^2/2)*cos(t)=0 at t=pi/2",
        "signal_cf_binary64_roundoff": population_cf_roundoff,
        "noise": "Gaussian symmetric Levy exponent 0.04*t^2",
        "true_noise_exponent_at_frequency": stable_coefficient*frequency**2,
        "population_score": "exactly zero for every trial exponent; the exponent is not identified at this frequency",
        "grid_size": int(exponent_grid.size),
        "grid_interval": [float(exponent_grid[0]), float(exponent_grid[-1])],
        "grid_spacing": float(exponent_grid[1]-exponent_grid[0]),
        "selected_grid_exponent": selected,
        "selected_score_modulus": float(abs(scores[index])),
        "raw_reconstructed_cf": {"real": raw.real, "imaginary": raw.imag, "modulus": abs(raw)},
        "unit_disk_projected_cf": {"real": clipped.real, "imaginary": clipped.imag, "modulus": abs(clipped)},
        "absolute_reconstruction_error_at_known_zero": abs(clipped),
        "grid_minimization_error_certificate": None,
        "stochastic_error_certificate": None,
        "all_computations_finite_without_division_by_signal_cf": True,
        "scope": "One fixed-seed illustration of finite no-division reconstruction; not a risk estimate and not evidence that the noise exponent is estimable at a signal-CF zero.",
    }


def main():
    results = {
        "schema_version": 1,
        "script": "code/diagnostics.py",
        "status": "finite_diagnostics_passed_not_a_proof",
        "disclaimer": "These diagnostics check finite examples and symbolic identities. The manuscript proves the minimax limits. No Monte Carlo risk-rate fit was performed.",
        "environment": {"python": platform.python_version(), "numpy": np.__version__,
                        "scipy": scipy.__version__, "sympy": sp.__version__},
        "fixed_parameters": PARAMS,
        "eta": spatial_eta_checks(),
        "eta_symbolic": symbolic_eta_checks(),
        "levy": levy_spatial_checks(),
        "signals": signal_checks(),
        "observation_cf_identity": characteristic_identity_checks(),
        "signal_cf_zero_example": zero_frequency_example(),
    }
    destination = Path(__file__).resolve().parents[1] / "results" / "diagnostics.json"
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(json.dumps(results, ensure_ascii=False, indent=2, allow_nan=False)+"\n", encoding="utf-8")
    print(json.dumps({
        "status": results["status"], "output": str(destination),
        "eta_radii": len(results["eta"]["truncated_quadratures"]),
        "exact_symbolic_checks": results["eta_symbolic"]["checked_finite_symbolic_identities"],
        "levy_records": len(results["levy"]["records"]),
        "signal_records": len(results["signals"]["records"]),
        "design_beta_frequency_records": len(results["observation_cf_identity"]["records"]),
    }, ensure_ascii=False))


if __name__ == "__main__":
    main()
