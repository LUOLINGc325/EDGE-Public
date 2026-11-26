#!/usr/bin/env python3
"""Finite diagnostics for the long-query affine-state research extension.

This script does not prove any universal theorem. Analytic truncation formulas
come from the manuscript; their numerical evaluations and finite matrix/grid
checks use floating-point arithmetic, not certified interval arithmetic.

Dependencies: Python >= 3.10, numpy, mpmath, sympy.
Run: python3 code/verify_new_results.py
The default report is results/new_verification.json beside the code directory.
"""

from __future__ import annotations

import argparse
from datetime import datetime, timezone
import hashlib
import importlib.metadata
import json
import math
from pathlib import Path
import platform
import sys
import time

import mpmath as mp
import numpy as np
import sympy as sp


SEED = 97123961
MP_DPS = 65


def json_safe(value):
    if isinstance(value, dict):
        return {str(k): json_safe(v) for k, v in value.items()}
    if isinstance(value, (list, tuple)):
        return [json_safe(v) for v in value]
    if isinstance(value, np.ndarray):
        return json_safe(value.tolist())
    if isinstance(value, np.generic):
        return value.item()
    return value


def random_isometry(rng, output_dimension, input_dimension):
    raw = rng.normal(size=(output_dimension, input_dimension))
    raw = raw + 1j * rng.normal(size=raw.shape)
    q, r = np.linalg.qr(raw, mode="reduced")
    phase = np.diag(r)
    phase = np.where(np.abs(phase) > 0, phase / np.abs(phase), 1.0)
    return q * phase.conj()


def random_state(rng, dimension, rank):
    a = rng.normal(size=(dimension, rank)) + 1j * rng.normal(size=(dimension, rank))
    rho = a @ a.conj().T
    return rho / np.trace(rho)


def single_query_diagnostics(rng):
    z = np.diag([1.0, -1.0]).astype(complex)
    x = np.array([[0.0, 1.0], [1.0, 0.0]], dtype=complex)
    omega_grid = np.linspace(-1.0, 1.0, 25)
    instances = []

    def inspect(rho, isometry, ancilla_dimension, environment_dimension, duration, name):
        dimension = 2 * ancilla_dimension
        pplus = np.diag([1.0] * ancilla_dimension + [0.0] * ancilla_dimension)
        pminus = np.eye(dimension) - pplus
        observable = np.kron(z, np.eye(environment_dimension))
        pulled_back = isometry.conj().T @ observable @ isometry
        cross = np.trace(pulled_back @ pplus @ rho @ pminus)
        diagonal = pplus @ rho @ pplus + pminus @ rho @ pminus
        a = float(np.trace(pulled_back @ diagonal).real)
        b = float(2 * cross.real)
        c = float(2 * cross.imag)

        def actual(omega):
            phases = np.repeat(np.exp(-0.5j * omega * duration * np.array([1.0, -1.0])),
                               ancilla_dimension)
            evolved = phases[:, None] * rho * phases.conj()[None, :]
            dilation_output = isometry @ evolved @ isometry.conj().T
            block = dilation_output.reshape(2, environment_dimension, 2, environment_dimension)
            output = np.einsum("aibi->ab", block)
            return float(np.trace(z @ output).real), output

        max_harmonic_error = 0.0
        max_odd_error = 0.0
        max_trace_error = 0.0
        minimum_eigenvalue = 1.0
        for omega in omega_grid:
            f, output = actual(float(omega))
            fminus, _ = actual(float(-omega))
            model = a + b * math.cos(omega * duration) + c * math.sin(omega * duration)
            max_harmonic_error = max(max_harmonic_error, abs(f - model))
            max_odd_error = max(max_odd_error, abs((f - fminus) / 2 - c * math.sin(omega * duration)))
            max_trace_error = max(max_trace_error, abs(np.trace(output) - 1.0))
            minimum_eigenvalue = min(minimum_eigenvalue, float(np.linalg.eigvalsh(output).min()))
        tolerance = 2e-12
        passed = (max_harmonic_error <= tolerance and max_odd_error <= tolerance
                  and abs(c) <= 1 + tolerance and max_trace_error <= tolerance
                  and minimum_eigenvalue >= -tolerance)
        instances.append({
            "name": name, "ancilla_dimension": ancilla_dimension,
            "stinespring_environment_dimension": environment_dimension,
            "duration": duration, "coefficients": {"constant": a, "cosine": b, "sine": c},
            "maximum_harmonic_discrepancy": max_harmonic_error,
            "maximum_odd_part_discrepancy": max_odd_error,
            "maximum_output_trace_discrepancy": float(max_trace_error),
            "minimum_output_eigenvalue": minimum_eigenvalue,
            "floating_tolerance": tolerance, "passed": passed,
        })

    for ancilla in (1, 2, 3):
        for environment in (ancilla, ancilla + 1):
            for rank in (1, 2 * ancilla):
                for repetition in range(3):
                    rho = random_state(rng, 2 * ancilla, rank)
                    dilation = random_isometry(rng, 2 * environment, 2 * ancilla)
                    duration = float(rng.uniform(0.15, 19.0))
                    inspect(rho, dilation, ancilla, environment, duration,
                            f"a{ancilla}_e{environment}_rank{rank}_repeat{repetition}")

    # Known saturation witness: |+>, a Z rotation, and output Z readout
    # after Rx(pi/2), whose pulled-back observable is Y.
    plus = np.array([1.0, 1.0], dtype=complex) / math.sqrt(2)
    rotate_x = (np.eye(2) - 1j * x) / math.sqrt(2)
    inspect(np.outer(plus, plus.conj()), rotate_x, 1, 1, 1.7, "sine_coefficient_saturation")

    mixture_weights = rng.dirichlet(np.ones(len(instances)))
    variation_bound = float(sum(w * abs(r["coefficients"]["sine"])
                                for w, r in zip(mixture_weights, instances)))
    return {
        "passed": all(r["passed"] for r in instances) and variation_bound <= 1 + 2e-12,
        "instance_count": len(instances), "frequency_grid_size": len(omega_grid),
        "frequency_interval": [-1.0, 1.0],
        "mixture_signed_measure_total_variation_upper_bound": variation_bound,
        "coverage": "Finite qubit oracle with ancillas, pure/mixed inputs and random known CPTP Stinespring maps; no universal claim.",
        "instances": instances,
    }


def high_pass_coefficients(j_index, order, width):
    """Evaluate formula Q8; periodic sine reduction avoids large arguments."""
    m = 2 * order + 4
    j = j_index.astype(float)
    residue = j_index % (2 * m)
    sin_numerator = np.sin(math.pi * residue / (2 * m))
    sin_numerator[residue == 0] = 0.0
    sinc_power = (sin_numerator / (math.pi * j / (2 * m))) ** m
    polynomial_magnitude = np.ones_like(j)
    for k in range(1, order + 1):
        polynomial_magnitude *= (j - k) * (j + k) / (k * k)
    signs = np.where((j_index + 1 + order) % 2 == 0, 1.0, -1.0)
    return (4 * width / math.pi) * signs * sinc_power * polynomial_magnitude / j


def high_pass_diagnostics():
    width = 1.0
    target_analytic_tail = 5e-10
    omega_grid = np.linspace(-width, width, 41)
    rows = []
    for order in range(7):
        m = 2 * order + 4
        factorial_squared = math.factorial(order) ** 2
        a = 2 * m / math.pi
        # For j>J: |a_j| <= K j^-5, using |sinc|<=2m/(pi j).
        k_tail = (4 * width / math.pi) * a ** m / factorial_squared
        needed = max(4096, math.ceil((k_tail / (4 * target_analytic_tail)) ** 0.25))
        cutoff = 1 << (needed - 1).bit_length()
        index = np.arange(order + 1, cutoff + 1, dtype=np.int64)
        coefficients = high_pass_coefficients(index, order, width)
        times = math.pi * index / (2 * width)
        variation = math.fsum(np.abs(coefficients))
        moment = math.fsum(np.abs(coefficients) * times)
        tail_c = k_tail / (4 * cutoff ** 4)
        tail_m = k_tail * math.pi / (6 * width * cutoff ** 3)
        explicit_c_upper = 3 * width * (6 * math.e) ** (2 * order)
        explicit_m_upper = (8 / 3) * m ** (2 * order + 1) / factorial_squared
        differences = [abs(math.fsum(coefficients * np.sin(omega * times)) - omega)
                       for omega in omega_grid]
        numerical_allowance = 2e-11 * max(1.0, variation)
        duration_floor = (order + 0.375) * math.pi / (2 * width)
        per_coefficient_ratio = float(np.max(np.abs(coefficients) * index.astype(float) ** 5 / k_tail))
        passed = (max(differences) <= tail_c + numerical_allowance
                  and variation + tail_c <= explicit_c_upper + numerical_allowance
                  and moment + tail_m <= explicit_m_upper + numerical_allowance
                  and variation + tail_c >= width - numerical_allowance
                  and times[0] > duration_floor
                  and per_coefficient_ratio <= 1 + 2e-11)
        rows.append({
            "J": order, "m": m, "L": width, "T": duration_floor,
            "cutoff_j_inclusive": cutoff, "retained_terms": len(index),
            "minimum_retained_query_duration": float(times[0]),
            "finite_variation_sum": variation, "analytic_variation_tail_upper": tail_c,
            "explicit_full_variation_upper": explicit_c_upper,
            "finite_first_absolute_moment_sum": moment,
            "analytic_first_moment_tail_upper": tail_m,
            "explicit_full_first_moment_upper": explicit_m_upper,
            "tail_coefficient_K": k_tail,
            "maximum_finite_coefficient_to_K_j_minus_5_ratio": per_coefficient_ratio,
            "maximum_scalar_identity_grid_discrepancy": max(differences),
            "floating_roundoff_allowance_not_interval_certified": numerical_allowance,
            "passed": passed,
        })
    return {
        "passed": all(row["passed"] for row in rows),
        "frequency_grid_size": len(omega_grid), "frequency_interval": [-width, width],
        "tail_formula": "|a_j|<=K j^-5; sum_{j>N}|a_j|<=K/(4N^4); sum_{j>N}s_j|a_j|<=K*pi/(6L*N^3)",
        "coverage": "J=0,...,6 only; the tail formulas are analytic inputs, while finite sums are floating-point diagnostics.",
        "instances": rows,
    }


def j_closed(v):
    v = mp.mpf(v)
    return 2 * mp.log((1 + mp.sqrt(1 + v)) / 2) + 2 / (1 + mp.sqrt(1 + v)) - 1


def smooth_moment_integral(h, width=1):
    h = mp.mpf(h)
    w = mp.mpf(width) + h
    a = mp.pi * h / (4 * w)
    value = 4 / (mp.pi * a ** 2) * mp.quad(
        lambda t: (a - t) * mp.log(mp.cot(t)), [0, a])
    return value, a


def smooth_nyquist_diagnostics():
    width = 1.0
    omega_grid = np.linspace(-width, width, 41)
    rows = []
    for delta in (0.25, 0.1, 0.03, 0.01, 0.003, 0.001):
        h = 1.5 * delta
        w = width + h
        a = math.pi * h / (4 * w)
        cutoff = max(50000, math.ceil(math.sqrt(1 / (4 * math.pi * a * a * 1e-6))))
        j = np.arange(cutoff, dtype=np.int64)
        odd = 2 * j.astype(float) + 1
        times = math.pi * odd / (2 * w)
        magnitude = 8 * w / (math.pi ** 2 * odd ** 2) * np.sinc(a * odd / math.pi) ** 2
        coefficients = np.where(j % 2 == 0, 1.0, -1.0) * magnitude
        variation = math.fsum(magnitude)
        moment = math.fsum(magnitude * times)
        exact_c = width + 2 * h / 3
        c_tail = w / (6 * math.pi ** 2 * a * a * cutoff ** 3)
        m_tail = 1 / (4 * math.pi * a * a * cutoff ** 2)
        mp_moment, mp_a = smooth_moment_integral(str(h), width)
        lower = 2 / mp.pi * j_closed(2 * mp.mpf(width) / mp.mpf(str(delta)))
        upper = 2 / mp.pi * mp.log(1 / mp_a) + 3 / mp.pi
        differences = [abs(math.fsum(coefficients * np.sin(omega * times)) - omega)
                       for omega in omega_grid]
        allowance = 3e-11 * max(1.0, exact_c, float(mp_moment))
        c_gap = exact_c - variation
        m_gap = float(mp_moment) - moment
        passed = (-allowance <= c_gap <= c_tail + allowance
                  and -allowance <= m_gap <= m_tail + allowance
                  and max(differences) <= c_tail + allowance
                  and float(lower) <= float(mp_moment) + allowance
                  and float(mp_moment) <= float(upper) + allowance)
        rows.append({
            "L": width, "Delta": delta, "h": h, "W": w,
            "retained_odd_terms": cutoff, "exact_variation_formula": exact_c,
            "finite_variation_sum": variation, "variation_gap": c_gap,
            "analytic_variation_tail_upper": c_tail,
            "finite_first_moment_sum": moment,
            "independent_mpmath_moment_integral": mp.nstr(mp_moment, 50),
            "moment_gap": m_gap, "analytic_moment_tail_upper": m_tail,
            "exact_frontier_lower_bound_F4": mp.nstr(lower, 50),
            "moment_upper_bound_F12": mp.nstr(upper, 50),
            "maximum_scalar_identity_grid_discrepancy": max(differences),
            "floating_roundoff_allowance_not_interval_certified": allowance,
            "passed": passed,
        })
    return {"passed": all(row["passed"] for row in rows),
            "frequency_grid_size": len(omega_grid), "instances": rows,
            "tail_formula": "C tail <= W/(6*pi^2*a^2*N^3); M tail <= 1/(4*pi*a^2*N^2)",
            "coverage": "Six positive normalization excesses and a finite frequency grid; analytic tails account for truncation, not floating-point rounding."}


def approximate_frontier_diagnostics():
    width = 1.0
    grid = np.linspace(-width, width, 101)
    rows = []
    for delta, epsilon in ((0.0, 0.1), (0.05, 0.05), (0.002, 0.01),
                           (0.01, 0.002), (0.1, 0.0), (0.0, 0.0001)):
        r = delta + epsilon
        lower = 2 / math.pi * (math.log(2 * width / r) - 6)
        upper = 2 / math.pi * math.log(width / r) + 2
        if delta >= epsilon and delta > 0:
            moment, _ = smooth_moment_integral(str(1.5 * delta), width)
            observed = float(moment)
            detail = {"construction": "exact smoothed rule; zero bias follows from analytic convolution identity",
                      "moment_integral": mp.nstr(moment, 50),
                      "exact_total_variation": width + delta}
            passed = lower <= observed + 1e-11 and observed <= upper + 1e-11
        else:
            count = math.ceil(2 * width / (math.pi ** 2 * epsilon))
            j = np.arange(count)
            odd = 2 * j + 1
            coeff = 8 * width * (-1.0) ** j / (math.pi ** 2 * odd.astype(float) ** 2)
            times = math.pi * odd / (2 * width)
            variation = math.fsum(np.abs(coeff))
            observed = math.fsum(np.abs(coeff) * times)
            gap_bound = 2 * width / (math.pi ** 2 * count)
            actual_grid = max(abs(math.fsum(coeff * np.sin(w * times)) - w) for w in grid)
            passed = (variation <= width + 1e-11 and actual_grid <= epsilon + 1e-11
                      and gap_bound <= epsilon + 1e-11
                      and lower <= observed + 1e-11 and observed <= upper + 1e-11)
            detail = {"construction": "finite Nyquist truncation", "retained_terms": count,
                      "total_variation": variation, "first_moment": observed,
                      "analytic_uniform_error_upper": gap_bound,
                      "maximum_grid_error": actual_grid}
        rows.append({"Delta": delta, "epsilon": epsilon, "r": r,
                     "frontier_lower_F2": lower, "frontier_upper_F2": upper,
                     "diagnostic": detail, "passed": passed})
    return {"passed": all(row["passed"] for row in rows), "instances": rows,
            "coverage": "Six witness parameter pairs, including both zero-coordinate boundaries; no numerical minimax certification."}


def statistical_cost_diagnostics():
    rows = []
    for r in (10, 100, 1000, 10000, 100000):
        x = 1 / (2 * mp.pi * r)
        moment, _ = smooth_moment_integral(3 * x / 2)
        objective = 2 * r * (1 + x) ** 2 + (1 + x) * moment
        two_terms = 2 * r + 2 / mp.pi * mp.log(r)
        residual = objective - two_terms
        rows.append({"L": 1, "r=t0*L": r, "chosen_excess_ratio": mp.nstr(x, 40),
                     "witness_objective_divided_by_L": mp.nstr(objective, 45),
                     "two_asymptotic_terms": mp.nstr(two_terms, 45),
                     "remaining_constant_scale_residual": mp.nstr(residual, 45),
                     "passed": bool(mp.isfinite(objective) and 0 <= residual <= 5)})
    return {"passed": all(row["passed"] for row in rows), "instances": rows,
            "coverage": "Explicit upper-bound witness only; bounded residual in these five cases does not prove the asymptotic infimum."}


def symbolic_and_integral_diagnostics():
    v = sp.symbols("v", nonnegative=True)
    j = 2 * sp.log((1 + sp.sqrt(1 + v)) / 2) + 2 / (1 + sp.sqrt(1 + v)) - 1
    derivative_residual = sp.simplify(sp.diff(j, v) - 1 / (1 + sp.sqrt(1 + v)) ** 2)
    endpoint = sp.simplify(j.subs(v, 0))
    a, b = sp.symbols("a b", real=True)
    trig_residual = sp.trigsimp(sp.sin(a) - sp.sin(a - b)
                                - sp.sin(a) * (1 - sp.cos(b)) - sp.cos(a) * sp.sin(b))
    integral_rows = []
    for number in ("0.1", "1", "100", "1000000"):
        vv = mp.mpf(number)
        numerical = mp.quad(lambda t: 1 / (1 + mp.sqrt(1 + t)) ** 2, [0, vv])
        discrepancy = abs(numerical - j_closed(vv))
        integral_rows.append({"v": number, "absolute_discrepancy": mp.nstr(discrepancy, 20),
                              "passed": bool(discrepancy < mp.mpf("1e-55"))})
    return {"passed": bool(derivative_residual == 0 and endpoint == 0 and trig_residual == 0)
                       and all(row["passed"] for row in integral_rows),
            "sympy_J_derivative_residual": str(derivative_residual),
            "sympy_J_at_zero": str(endpoint),
            "sympy_endpoint_trigonometric_identity_residual": str(trig_residual),
            "quadrature_checks": integral_rows,
            "coverage": "Symbolic identities and four high-precision definite-integral consistency checks only."}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results" / "new_verification.json")
    parser.add_argument("--seed", type=int, default=SEED)
    args = parser.parse_args()
    started = time.monotonic()
    mp.mp.dps = MP_DPS
    rng = np.random.default_rng(args.seed)
    sections = {
        "single_query_channels": single_query_diagnostics(rng),
        "high_pass_filters": high_pass_diagnostics(),
        "smooth_nyquist_filters": smooth_nyquist_diagnostics(),
        "approximate_frontier_witnesses": approximate_frontier_diagnostics(),
        "statistical_cost_witnesses": statistical_cost_diagnostics(),
        "symbolic_and_integral_checks": symbolic_and_integral_diagnostics(),
    }
    passed = all(value["passed"] for value in sections.values())
    report = {
        "schema": "long-time-affine-new-results-finite-diagnostic-v1",
        "generated_at_utc": datetime.now(timezone.utc).isoformat(),
        "seed": args.seed,
        "code_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "environment": {"python": sys.version, "platform": platform.platform(),
                        "packages": {name: importlib.metadata.version(name)
                                     for name in ("numpy", "mpmath", "sympy")},
                        "mpmath_decimal_digits": MP_DPS},
        "limitations": [
            "Finite matrix examples and frequency grids do not prove universal statements.",
            "Analytic tail bounds are theorem inputs checked numerically, not generated proof certificates.",
            "Finite sums and tail expressions use floating-point arithmetic; allowances are not interval-certified rounding bounds.",
            "No physical hardware, external peer review, global novelty claim or Lean verification is represented.",
        ],
        "sections": sections, "passed": passed,
        "elapsed_seconds": time.monotonic() - started,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(json_safe(report), indent=2, sort_keys=True, allow_nan=False) + "\n")
    print(json.dumps({"passed": passed, "report": str(args.output.resolve()),
                      "section_passes": {key: value["passed"] for key, value in sections.items()},
                      "code_sha256": report["code_sha256"],
                      "elapsed_seconds": report["elapsed_seconds"]}, indent=2))
    return 0 if passed else 1


if __name__ == "__main__":
    raise SystemExit(main())
