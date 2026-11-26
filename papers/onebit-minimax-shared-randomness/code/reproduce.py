#!/usr/bin/env python3
"""Deterministic, high-precision diagnostics for one-bit minimax quantization.

Run from the case directory::

    python3 code/reproduce.py

The default run uses mpmath with 80 decimal digits and writes
``results/diagnostics.json`` and ``results/diagnostics.md``.  SymPy, when
available, additionally checks the displayed Taylor coefficients exactly.

These are numerical/symbolic diagnostics, not computer-assisted proofs or
formal verification.  In particular, finite-grid comparisons do not establish
theorems for every real input or optimality over all protocols.

The mathematical model permits private coins that are mutually independent
conditional on the public seed and independent of the input.  All randomness
jointly available to the parties is counted as public randomness.  This script
does not sample any coins; every computation is deterministic.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import platform
from pathlib import Path

import mpmath as mp


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--digits", type=int, default=80)
    parser.add_argument("--grid-points", type=int, default=401)
    parser.add_argument("--max-r", type=int, default=10)
    args = parser.parse_args()
    if args.digits < 60:
        parser.error("--digits must be at least 60")
    if args.grid_points < 101 or args.grid_points % 2 != 1:
        parser.error("--grid-points must be odd and at least 101")
    if args.max_r < 2:
        parser.error("--max-r must be at least 2")

    mp.mp.dps = args.digits
    tolerance = mp.power(10, -(args.digits - 20))
    zero, one = mp.mpf(0), mp.mpf(1)
    c = mp.exp(-1)
    root_c = mp.sqrt(c)
    r = (1 - c) / 2
    s = (1 + c) / 2
    d_star = c / 2
    v_star = d_star / 4
    prior_atom = c / (1 + c)
    lower_constant = c * (1 - c) ** 3 / (6 * (1 + c) ** 3)
    fair_upper_constant = (1 + c) ** 2 / 16
    construction_leading = (1 + 2 * c + 3 * c * c) / 24
    construction_cubic = -(1 - c * c) / 24

    def decimal(value: mp.mpf, digits: int | None = None) -> str:
        return mp.nstr(value, digits or args.digits - 5)

    def distance(t: mp.mpf) -> mp.mpf:
        return mp.sqrt(c + t * t)

    def prior_density(t: mp.mpf) -> mp.mpf:
        return c / (2 * (c + t * t) ** mp.mpf("1.5"))

    def threshold_density(t: mp.mpf) -> mp.mpf:
        return 1 / (2 * distance(t))

    def prior_cdf_integral(z: mp.mpf) -> mp.mpf:
        total = prior_atom * (int(z >= -1) + int(z >= 1))
        if z > -r:
            total += mp.quad(prior_density, [-r, min(z, r)])
        return total

    def prior_moment_integral(z: mp.mpf) -> mp.mpf:
        total = prior_atom * (-int(z >= -1) + int(z >= 1))
        if z > -r:
            total += mp.quad(lambda t: t * prior_density(t), [-r, min(z, r)])
        return total

    def prior_cdf_formula(z: mp.mpf) -> mp.mpf:
        if z < -1:
            return zero
        if z < -r:
            return prior_atom
        if z <= r:
            return (1 + z / distance(z)) / 2
        if z < 1:
            return 1 - prior_atom
        return one

    def prior_moment_formula(z: mp.mpf) -> mp.mpf:
        if z < -1 or z >= 1:
            return zero
        if -r <= z <= r:
            return -c / (2 * distance(z))
        return -prior_atom

    def ideal_risk_integral(z: mp.mpf) -> mp.mpf:
        atoms = ((abs(z + r) - s) ** 2 + (abs(z - r) - s) ** 2) / 4
        breaks = [-r, z, r] if -r < z < r else [-r, r]
        continuous = mp.quad(
            lambda t: (abs(z - t) - distance(t)) ** 2 * threshold_density(t),
            breaks,
        )
        return atoms + continuous

    def ideal_risk_formula(z: mp.mpf) -> mp.mpf:
        return d_star if abs(z) <= r else d_star + (abs(z) - r) * (abs(z) - 1)

    def centroid_bayes_risk(t: mp.mpf) -> mp.mpf:
        a, b = t - distance(t), t + distance(t)
        atoms = prior_atom * (min((-1 - a) ** 2, (-1 - b) ** 2)
                              + min((1 - a) ** 2, (1 - b) ** 2))
        breaks = [-r, t, r] if -r < t < r else [-r, r]
        continuous = mp.quad(
            lambda z: min((z - a) ** 2, (z - b) ** 2) * prior_density(z),
            breaks,
        )
        return atoms + continuous

    checks: list[dict[str, object]] = []

    def check(name: str, passed: bool, comparisons: int = 1) -> None:
        checks.append({"name": name, "passed": bool(passed),
                       "scalar_comparisons": comparisons})

    print("Checking probability laws and moments...", flush=True)
    moment_records = []
    moment_specs = [
        ("prior_total_mass", 2 * prior_atom + mp.quad(prior_density, [-r, r]), one),
        ("threshold_total_mass", mp.mpf("0.5") + mp.quad(threshold_density, [-r, r]), one),
        ("prior_mean", mp.quad(lambda z: z * prior_density(z), [-r, r]), zero),
        ("threshold_mean", mp.quad(lambda t: t * threshold_density(t), [-r, r]), zero),
        ("prior_second_moment", 2 * prior_atom + mp.quad(lambda z: z * z * prior_density(z), [-r, r]), 3 * c / 2),
        ("threshold_continuous_mass", mp.quad(threshold_density, [-r, r]), mp.mpf("0.5")),
        ("prior_continuous_mass", mp.quad(prior_density, [-r, r]), (1 - c) / (1 + c)),
        ("s_squared", s * s, c + r * r),
        ("hyperbolic_parameter_length", mp.asinh(r / root_c), mp.mpf("0.5")),
    ]
    for name, computed, expected in moment_specs:
        error = abs(computed - expected)
        moment_records.append({"name": name, "computed": decimal(computed),
                               "formula": decimal(expected), "absolute_error": decimal(error)})
        check(name, error <= tolerance)

    cdf_grid = [mp.mpf(-1) + mp.mpf(2) * k / 100 for k in range(101)]
    cdf_grid.extend([-1 - mp.mpf("0.01"), 1 + mp.mpf("0.01"), -r, r])
    cdf_error, truncation_error = zero, zero
    ratio_error = zero
    ratio_count = 0
    for z in cdf_grid:
        f_integral = prior_cdf_integral(z)
        m_integral = prior_moment_integral(z)
        cdf_error = max(cdf_error, abs(f_integral - prior_cdf_formula(z)))
        truncation_error = max(truncation_error, abs(m_integral - prior_moment_formula(z)))
        if -1 < z < 1:
            ratio_error = max(ratio_error, abs(m_integral ** 2 / (f_integral * (1 - f_integral)) - c))
            ratio_count += 1
    check("prior_cdf_quadrature_vs_formula", cdf_error <= tolerance, len(cdf_grid))
    check("prior_truncated_moment_quadrature_vs_formula", truncation_error <= tolerance, len(cdf_grid))
    check("constant_centroid_variance_reduction", ratio_error <= tolerance, ratio_count)

    print("Integrating the optimal risk on the deterministic dense grid...", flush=True)
    risk_grid = [mp.mpf(-1) + mp.mpf(2) * k / (args.grid_points - 1)
                 for k in range(args.grid_points)]
    risk_grid.extend([-r, r, -(1 + r) / 2, (1 + r) / 2])
    risk_error, risk_worst_z = zero, zero
    risk_max_excess = -mp.inf
    sample_points = [-one, -(1 + r) / 2, -r, zero, r, (1 + r) / 2, one]
    risk_samples = []
    for z in risk_grid:
        value = ideal_risk_integral(z)
        formula = ideal_risk_formula(z)
        error = abs(value - formula)
        if error > risk_error:
            risk_error, risk_worst_z = error, z
        risk_max_excess = max(risk_max_excess, value - d_star)
    for z in sample_points:
        risk_samples.append({"z": decimal(z), "x": decimal((z + 1) / 2),
                             "risk_integral_z": decimal(ideal_risk_integral(z)),
                             "risk_formula_z": decimal(ideal_risk_formula(z))})
    check("ideal_risk_integral_vs_piecewise", risk_error <= tolerance, len(risk_grid))
    check("ideal_risk_grid_below_optimal_bound", risk_max_excess <= tolerance, len(risk_grid))

    bayes_error = zero
    bayes_grid = [-r + 2 * r * k / 40 for k in range(41)]
    for t in bayes_grid:
        bayes_error = max(bayes_error, abs(centroid_bayes_risk(t) - d_star))
    check("centroid_curve_bayes_integral", bayes_error <= tolerance, len(bayes_grid))

    def finite_construction(n: int) -> dict[str, object]:
        h = one / n
        us = [-mp.mpf("0.5") + (mp.mpf(j) + mp.mpf("0.5")) * h
              for j in range(n)]
        interior = [root_c * mp.sinh(u) for u in us]
        thresholds = [-r] + interior + [r]
        weights = [mp.mpf("0.25")] + [one / (2 * n)] * n + [mp.mpf("0.25")]
        pairs = [(-one, c)] + [(-root_c * mp.exp(-u), root_c * mp.exp(u))
                              for u in us] + [(-c, one)]

        def direct_risk(z: mp.mpf) -> mp.mpf:
            return mp.fsum(p * min((z - a) ** 2, (z - b) ** 2)
                           for p, (a, b) in zip(weights, pairs))

        a_h = 1 - h / mp.sinh(h)
        b_h = c * c / 2 + h * (c * mp.coth(h) - c * c / mp.sinh(h)) / 2
        w_formula = a_h * c * mp.sinh((1 - h) / 2) ** 2 + b_h
        candidates = [-one] + thresholds + [one]
        values = [direct_risk(z) for z in candidates]
        maximum = max(values)
        maximizers = [candidates[k] for k, value in enumerate(values)
                      if abs(value - maximum) <= tolerance]
        node_error = max(abs(values[j + 2] - (a_h * interior[j] ** 2 + b_h))
                         for j in range(n))
        w_error = abs(maximum - w_formula)
        outer_excess = max(values[0], values[1], values[-2], values[-1]) - d_star
        fair_or_cardinality_upper = (1 + c) ** 2 / (64 * n * n)
        actual_support_lower = lower_constant / (n + 3) ** 2
        gap_x = maximum / 4 - v_star
        check(f"n_{n}_interior_peak_sum_vs_formula", node_error <= tolerance, n)
        check(f"n_{n}_enumerated_max_vs_Wn", w_error <= tolerance)
        check(f"n_{n}_exterior_candidates_below_D", outer_excess <= tolerance, 4)
        check(f"n_{n}_public_cardinality_lower_bound", gap_x + tolerance >= actual_support_lower)
        check(f"n_{n}_uniform_quadrature_upper_bound", gap_x <= fair_or_cardinality_upper + tolerance)
        return {
            "n": n, "distinct_public_states": n + 2,
            "enumerated_candidates": len(candidates),
            "maximum_risk_z_direct_sum": decimal(maximum),
            "W_n_formula_z": decimal(w_formula),
            "maximum_risk_x": decimal(maximum / 4),
            "gap_x": decimal(gap_x),
            "maximizer_z": [decimal(z) for z in maximizers],
            "interior_peak_formula_max_absolute_error": decimal(node_error),
            "W_n_absolute_error": decimal(w_error),
            "max_exterior_candidate_risk_minus_D": decimal(outer_excess),
            "lower_bound_gap_for_actual_state_count": decimal(actual_support_lower),
            "construction_uniform_upper_bound_gap": decimal(fair_or_cardinality_upper),
            "n_squared_centered_gap": decimal((maximum - d_star) * n * n),
            "distance_to_construction_leading_coefficient": decimal(abs((maximum - d_star) * n * n - construction_leading)),
        }

    finite_records = []
    finite_by_n: dict[int, dict[str, object]] = {}
    for k in range(args.max_r):
        n = 2 ** k
        print(f"Enumerating every finite-quantizer peak for n={n}...", flush=True)
        record = finite_construction(n)
        finite_records.append(record)
        finite_by_n[n] = record

    bit_records = []
    for bit_count in range(2, args.max_r + 1):
        states = 2 ** bit_count
        n = states // 2
        observed = mp.mpf(finite_by_n[n]["maximum_risk_x"])
        lower_gap = lower_constant / (states + 1) ** 2
        upper_gap = fair_upper_constant / (states * states)
        gap = observed - v_star
        check(f"fair_R_{bit_count}_resource_count", states // 4 * 2 + n == states and n + 2 <= states)
        check(f"fair_R_{bit_count}_lower_and_upper_bracket", lower_gap <= gap + tolerance and gap <= upper_gap + tolerance, 2)
        bit_records.append({
            "R": bit_count, "fair_public_bit_strings": states,
            "interior_states_n": n, "distinct_thresholds": n + 2,
            "bit_strings_assigned_to_each_endpoint": states // 4,
            "constructed_risk_x": decimal(observed),
            "all_protocol_lower_bound_gap": decimal(lower_gap),
            "construction_upper_bound_gap": decimal(upper_gap),
            "constructed_gap_x": decimal(gap),
            "four_power_R_times_gap": decimal(states * states * gap),
            "construction_leading_constant": decimal(construction_leading),
            "distance_to_leading_constant": decimal(abs(states * states * gap - construction_leading)),
        })

    print("Checking symbolic Taylor coefficients...", flush=True)
    symbolic: dict[str, object] = {"status": "not_run", "reason": "SymPy unavailable"}
    sympy_version = None
    try:
        import sympy as sp
    except ImportError:
        pass
    else:
        sympy_version = sp.__version__
        hh = sp.symbols("h", real=True)
        cc = sp.exp(-1)
        expression = ((1 - hh / sp.sinh(hh)) * cc * sp.sinh((1 - hh) / 2) ** 2
                      + cc ** 2 / 2 + hh * (cc * sp.coth(hh) - cc ** 2 / sp.sinh(hh)) / 2)
        expanded = sp.series(expression, hh, 0, 4).removeO().expand()
        quadratic = sp.simplify(expanded.coeff(hh, 2).rewrite(sp.exp))
        cubic = sp.simplify(expanded.coeff(hh, 3).rewrite(sp.exp))
        constant = sp.simplify(expanded.coeff(hh, 0).rewrite(sp.exp))
        first = sp.simplify(expanded.coeff(hh, 1).rewrite(sp.exp))
        symbolic_zeroes = [sp.simplify(constant - cc / 2), first,
                           sp.simplify(quadratic - (1 + 2 * cc + 3 * cc ** 2) / 24),
                           sp.simplify(cubic + (1 - cc ** 2) / 24)]
        symbolic_ok = all(item == 0 for item in symbolic_zeroes)
        check("sympy_exact_Taylor_coefficients", symbolic_ok, 4)
        symbolic = {
            "status": "passed" if symbolic_ok else "failed",
            "scope": "Exact symbolic equality checks of coefficients; not a proof-assistant verification.",
            "constant": str(constant), "linear": str(first),
            "quadratic": str(quadratic), "cubic": str(cubic),
            "difference_from_claimed_coefficients": [str(item) for item in symbolic_zeroes],
        }

    passed = all(item["passed"] for item in checks)
    script_path = Path(__file__).resolve()
    results_dir = script_path.parent.parent / "results"
    results_dir.mkdir(parents=True, exist_ok=True)
    report = {
        "schema_version": 1,
        "status": "passed" if passed else "failed",
        "scope": "Deterministic numerical and optional symbolic diagnostics only. They do not replace the manuscript proofs, certify global novelty, prove minimax bounds numerically, or count as Lean verification.",
        "model": "Input z in [-1,1], or x=(z+1)/2 in [0,1]; exactly one transmitted bit. Public seed independent of input. Conditional on the public seed, the two private random sources are mutually independent and independent of the input. Every jointly available random source is counted as public randomness.",
        "runtime": {"python": platform.python_version(), "mpmath": mp.__version__,
                    "sympy": sympy_version, "decimal_precision": args.digits,
                    "absolute_error_tolerance": decimal(tolerance),
                    "seed": "none; no random sampling",
                    "command_from_case_directory": f"python3 code/reproduce.py --digits {args.digits} --grid-points {args.grid_points} --max-r {args.max_r}",
                    "source_sha256": hashlib.sha256(script_path.read_bytes()).hexdigest()},
        "constants": {"C": decimal(c), "r": decimal(r), "s": decimal(s),
                      "prior_mass_at_each_endpoint": decimal(prior_atom),
                      "optimal_risk_z_D": decimal(d_star), "optimal_risk_x": decimal(v_star),
                      "finite_state_lower_constant_x": decimal(lower_constant),
                      "fair_bit_uniform_upper_constant_x": decimal(fair_upper_constant),
                      "finite_construction_leading_coefficient": decimal(construction_leading),
                      "finite_construction_cubic_coefficient": decimal(construction_cubic)},
        "normalization_and_moments": moment_records,
        "cdf_and_partial_moments": {"points": len(cdf_grid),
                                    "cdf_max_absolute_error": decimal(cdf_error),
                                    "truncated_moment_max_absolute_error": decimal(truncation_error),
                                    "centroid_ratio_points": ratio_count,
                                    "centroid_ratio_max_absolute_error": decimal(ratio_error)},
        "optimal_risk_quadrature": {"uniform_grid_points": args.grid_points,
                                    "additional_boundary_points": 4,
                                    "max_absolute_error": decimal(risk_error),
                                    "worst_error_at_z": decimal(risk_worst_z),
                                    "max_risk_minus_D_on_checked_points": decimal(risk_max_excess),
                                    "reference_values": risk_samples},
        "centroid_curve_bayes_quadrature": {"points": len(bayes_grid),
                                            "max_absolute_error": decimal(bayes_error)},
        "finite_construction": finite_records,
        "fair_public_bits": bit_records,
        "symbolic_Taylor_check": symbolic,
        "checks": checks,
        "summary": {"check_groups": len(checks),
                    "scalar_comparisons": sum(int(item["scalar_comparisons"]) for item in checks),
                    "failed_groups": [item["name"] for item in checks if not item["passed"]]},
    }

    json_text = json.dumps(report, indent=2, ensure_ascii=False, allow_nan=False) + "\n"
    json_path = results_dir / "diagnostics.json"
    pending_json = json_path.with_suffix(".json.tmp")
    pending_json.write_text(json_text, encoding="utf-8")
    pending_json.replace(json_path)

    lines = [
        "# Numerical reproduction diagnostics", "",
        f"Status: **{report['status'].upper()}**.", "",
        "These are deterministic numerical and symbolic checks of the displayed formulas. They are not proofs of the continuum statements, minimax optimality, novelty, or formal verification.", "",
        f"Runtime: Python {platform.python_version()}, mpmath {mp.__version__}, SymPy {sympy_version or 'unavailable'}; {args.digits} decimal digits; no random sampling.", "",
        "Reproduce from the case directory:", "",
        "```sh", str(report["runtime"]["command_from_case_directory"]), "```", "",
        f"Absolute error tolerance: `{decimal(tolerance)}`.", "",
        f"Optimal risk on [0,1]: `1/(8e) = {decimal(v_star, 45)}`.", "",
        "## Independent quadrature checks", "",
        "| Quantity | Number of points | Maximum absolute discrepancy |",
        "| --- | ---: | ---: |",
        f"| Prior CDF | {len(cdf_grid)} | {decimal(cdf_error, 8)} |",
        f"| Prior truncated first moment | {len(cdf_grid)} | {decimal(truncation_error, 8)} |",
        f"| Constant centroid variance reduction | {ratio_count} | {decimal(ratio_error, 8)} |",
        f"| Optimal risk integral versus piecewise formula | {len(risk_grid)} | {decimal(risk_error, 8)} |",
        f"| Bayes risk of the centroid curve | {len(bayes_grid)} | {decimal(bayes_error, 8)} |", "",
        "The probability masses and moments are computed by quadrature in diagnostics.json. Each risk integral is split at its absolute-value switch to avoid integrating through an unresolved kink.", "",
        "## Explicit finite construction", "",
        "The table enumerates every threshold and both interval endpoints. Risk is convex quadratic between these locations, so these are the only candidate maxima for the finite construction. The table verifies the finite-sum implementation against W_n; it does not numerically optimize over all finite-seed protocols.", "",
        "| n | Distinct public states | Enumerated candidates | Maximum MSE on [0,1] | Difference from W_n/4 |",
        "| ---: | ---: | ---: | ---: | ---: |",
    ]
    for row in finite_records:
        lines.append(f"| {row['n']} | {row['distinct_public_states']} | {row['enumerated_candidates']} | {decimal(mp.mpf(row['maximum_risk_x']), 19)} | {decimal(mp.mpf(row['W_n_absolute_error']) / 4, 8)} |")
    lines.extend([
        "", "## Fair public bits and the resource bounds", "",
        "Exactly R fair bits give 2^R equiprobable strings. The construction assigns one quarter of the strings to each endpoint and uses n=2^(R−1) interior thresholds. Communication remains exactly one transmitted bit.", "",
        "The lower column is a theorem-derived bound for every admissible R-bit protocol. The upper column is the proved bound for this construction. This computation only checks their ordering for the listed R values.", "",
        "| R | Lower bound on excess | Constructed excess | Upper bound on excess | 4^R × constructed excess |",
        "| ---: | ---: | ---: | ---: | ---: |",
    ])
    for row in bit_records:
        lines.append(f"| {row['R']} | {decimal(mp.mpf(row['all_protocol_lower_bound_gap']), 10)} | {decimal(mp.mpf(row['constructed_gap_x']), 10)} | {decimal(mp.mpf(row['construction_upper_bound_gap']), 10)} | {decimal(mp.mpf(row['four_power_R_times_gap']), 14)} |")
    lines.extend([
        "",
        f"Predicted construction limit: `(1+2/e+3/e²)/24 = {decimal(construction_leading, 35)}`.", "",
        "This leading coefficient belongs to the explicit construction. The sharp finite-R minimax coefficient is not claimed. At small R the construction need not beat all earlier finite-bit rules.", "",
        "## Symbolic expansion", "",
        f"SymPy status: **{symbolic['status']}**.", "",
        "The checked expansion is W_n = C/2 + (1+2C+3C²)/(24n²) − (1−C²)/(24n³) + O(n⁻⁴), with C=e⁻¹. The four constant-through-cubic coefficient differences are recorded in diagnostics.json.", "",
        "## Check summary", "",
        f"{report['summary']['check_groups']} check groups; {report['summary']['scalar_comparisons']} scalar comparisons; {len(report['summary']['failed_groups'])} failed groups.", "",
        "The diagnostic JSON binds the exact source bytes by SHA-256 and records the interpreter, dependency versions, parameters, tolerance, and all aggregate discrepancies.", "",
    ])
    md_path = results_dir / "diagnostics.md"
    pending_md = md_path.with_suffix(".md.tmp")
    pending_md.write_text("\n".join(lines), encoding="utf-8")
    pending_md.replace(md_path)
    print(json.dumps({"status": report["status"], **report["summary"],
                      "ideal_risk_max_error": decimal(risk_error, 8),
                      "outputs": [json_path.name, md_path.name]}), flush=True)
    return 0 if passed else 1


if __name__ == "__main__":
    raise SystemExit(main())
