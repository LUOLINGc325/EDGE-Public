#!/usr/bin/env python3
"""Finite, deterministic diagnostics for the manuscript's paintbox argument.

Exact algebra uses Fraction. Finite enumeration and floating matrix exponentials
do not prove a statement about all paintboxes or all Xi probability measures.
This script is independent of verify_cost_orders.py and imports no code from it.
"""
from __future__ import annotations

import argparse
from collections import defaultdict
from fractions import Fraction as F
import hashlib
import itertools
import json
import math
from pathlib import Path
import platform

import numpy as np
import scipy
from scipy.linalg import expm


def C(b):
    return b * (b - 1) // 2


def H(n):
    return sum((F(1, j) for j in range(1, n + 1)), F(0))


def subsets(labels):
    for size in range(len(labels) + 1):
        yield from itertools.combinations(labels, size)


def clean(measure):
    return dict(sorted((x, w) for x, w in measure.items() if w))


def circle_rho(points, weights):
    assert len(points) == len(weights) and len(set(points)) == len(points)
    assert all(0 <= z < 1 for z in points)
    assert all(w > 0 for w in weights) and sum(weights) == 1
    rho = defaultdict(F)
    diagonal = sum(w * w for w in weights) / 2
    rho[F(0)] += diagonal
    rho[F(1)] += diagonal
    for i in range(len(points)):
        for j in range(len(points)):
            if i != j:
                rho[(points[j] - points[i]) % 1] += weights[i] * weights[j]
    rho = clean(rho)
    assert sum(rho.values()) == 1
    assert sum(x * mass for x, mass in rho.items()) == F(1, 2)
    assert all(rho.get(1 - x) == w for x, w in rho.items())
    return rho


def mu_direct_subsets(p):
    """Equation 7.5: integrate t^(s-1)(1-t)^(M-s-1) exactly."""
    assert sum(p) == 1 and all(x > 0 for x in p)
    m = len(p)
    out = defaultdict(F)
    p2 = sum(x * x for x in p)
    out[F(0)] = out[F(1)] = p2 / 2
    for selected in subsets(tuple(range(m))):
        s = len(selected)
        if not 0 < s < m:
            continue
        x = sum(p[i] for i in selected)
        beta = F(math.factorial(s - 1) * math.factorial(m - s - 1), math.factorial(m - 1))
        out[x] += x * (1 - x) * beta
    return clean(out)


def mu_ordered_pair_subsets(p):
    """Equation 7.7: condition on B_i=1, B_j=0; use the Beta weight."""
    m = len(p)
    out = defaultdict(F)
    p2 = sum(x * x for x in p)
    out[F(0)] = out[F(1)] = p2 / 2
    cells = 0
    for i in range(m):
        for j in range(m):
            if i == j:
                continue
            others = tuple(k for k in range(m) if k not in (i, j))
            for selected in subsets(others):
                s = len(selected)
                beta = F(math.factorial(s) * math.factorial(m - 2 - s), math.factorial(m - 1))
                x = p[i] + sum(p[k] for k in selected)
                out[x] += p[i] * p[j] * beta
                cells += 1
    return clean(out), cells


def mu_cyclic_average(p):
    """Fix label zero as the first arc; enumerate all (M-1)! cycles."""
    m = len(p)
    out = defaultdict(F)
    count = math.factorial(m - 1)
    between_counts = defaultdict(int)
    for tail in itertools.permutations(range(1, m)):
        order = (0,) + tail
        positions = [F(0)] * m
        pos = F(0)
        for label in order:
            positions[label] = pos
            pos += p[label]
        assert pos == 1
        for x, mass in circle_rho(positions, p).items():
            out[x] += mass / count
        for i in range(m):
            start = order.index(i)
            for j in range(m):
                if i == j:
                    continue
                between = []
                cursor = (start + 1) % m
                while order[cursor] != j:
                    between.append(order[cursor])
                    cursor = (cursor + 1) % m
                between_counts[i, j, tuple(sorted(between))] += 1
    for (i, j, selected), integer_count in between_counts.items():
        s = len(selected)
        beta = F(math.factorial(s) * math.factorial(m - 2 - s), math.factorial(m - 1))
        assert F(integer_count, count) == beta
    expected_cells = m * (m - 1) * 2 ** max(0, m - 2)
    assert len(between_counts) == expected_cells
    return clean(out), count, len(between_counts)


def rational_measure(measure):
    return [{"point": str(x), "mass": str(w)} for x, w in sorted(measure.items())]


def cyclic_suite():
    families = [
        [F(1)], [F(1, 3), F(2, 3)], [F(1, 7), F(2, 7), F(4, 7)],
        [F(i, 10) for i in (1, 2, 3, 4)],
        [F(i, 31) for i in (1, 2, 4, 8, 16)],
        [F(i, 15) for i in (1, 2, 3, 4, 5)],
    ]
    reports = []
    for p in families:
        direct = mu_direct_subsets(p)
        conditioned, cells = mu_ordered_pair_subsets(p)
        circular, cycles, count_cells = mu_cyclic_average(p)
        assert direct == conditioned == circular
        assert sum(direct.values()) == 1
        assert sum(x * w for x, w in direct.items()) == F(1, 2)
        assert cells == count_cells
        reports.append({"masses": [str(x) for x in p], "M": len(p),
                        "cycles_enumerated": cycles, "ordered_pair_subset_cells": cells,
                        "three_way_exact_equality": True,
                        "resulting_mu": rational_measure(direct)})
    return {"vectors": len(reports), "maximum_atoms": 5,
            "cycles_enumerated_total": sum(r["cycles_enumerated"] for r in reports),
            "ordered_pair_subset_cells_total": sum(r["ordered_pair_subset_cells"] for r in reports),
            "cases": reports}


def arc_moments(points, weights, h):
    """Integrate piecewise-constant A_h by exact rational breakpoints."""
    assert 0 <= h <= 1
    breakpoints = sorted({F(0), F(1), *points, *((z - h) % 1 for z in points)})
    mean = second = F(0)
    for left, right in zip(breakpoints, breakpoints[1:]):
        if right == left:
            continue
        midpoint = (left + right) / 2
        value = sum(w for z, w in zip(points, weights) if 0 < (z - midpoint) % 1 <= h)
        mean += (right - left) * value
        second += (right - left) * value * value
    return mean, second, len(breakpoints) - 1


def circle_variance_suite():
    configurations = [
        ([F(0)], [F(1)]),
        ([F(0), F(1, 3)], [F(1, 4), F(3, 4)]),
        ([F(1, 7), F(2, 5), F(5, 6)], [F(1, 6), F(1, 3), F(1, 2)]),
        ([F(0), F(1, 5), F(1, 2), F(7, 8)], [F(i, 10) for i in (1, 2, 3, 4)]),
        ([F(i, 17) for i in (1, 3, 8, 13, 16)], [F(i, 15) for i in (1, 2, 3, 4, 5)]),
    ]
    reports = []
    total_thresholds = above_half = total_intervals = both_overlap_terms = 0
    for points, weights in configurations:
        rho = circle_rho(points, weights)
        thresholds = sorted({F(0), F(1, 12), F(1, 4), F(2, 5), F(1, 2),
                             F(3, 5), F(3, 4), F(11, 12), F(1), *rho.keys()})
        rows = []
        for h in thresholds:
            mean, second, intervals = arc_moments(points, weights, h)
            assert mean == h
            variance = second - mean * mean
            stoploss = sum(w * max(x - h, F(0)) for x, w in rho.items())
            excess = stoploss - (1 - h) ** 2 / 2
            assert excess == variance / 2 and variance >= 0
            lower_stoploss = sum(w * max(h - x, F(0)) for x, w in rho.items())
            assert second == 2 * lower_stoploss
            total_thresholds += 1
            above_half += int(h > F(1, 2))
            total_intervals += intervals
            for x in rho:
                if h > x and h > 1 - x:
                    both_overlap_terms += 1
            rows.append({"h": str(h), "variance": str(variance), "stoploss_excess": str(excess),
                         "breakpoint_intervals": intervals})
        # Outside [0,1], equal mass and equal mean give equal stop-loss values.
        for h in (F(-1, 3), F(4, 3)):
            rho_stoploss = sum(w * max(x - h, F(0)) for x, w in rho.items())
            uniform_stoploss = F(1, 2) - h if h < 0 else F(0)
            assert rho_stoploss == uniform_stoploss
        reports.append({"points": [str(z) for z in points], "weights": [str(w) for w in weights],
                        "thresholds": rows})
    assert both_overlap_terms > 0
    return {"circle_measures": len(reports), "thresholds_checked": total_thresholds,
            "thresholds_strictly_above_half": above_half,
            "piecewise_intervals_integrated": total_intervals,
            "overlap_pairs_with_both_terms_positive": both_overlap_terms,
            "maximum_exact_identity_error": "0", "outside_interval_checks": 2 * len(reports),
            "cases": reports}


def occupancy_pgf(p, b):
    """Expand E[(d*t + sum_i p_i B_i(t))^b] coefficient by coefficient."""
    m = len(p)
    dust = 1 - sum(p)
    coefficient = defaultdict(F)
    for selected in subsets(tuple(range(m))):
        s = len(selected)
        mass = sum((p[i] for i in selected), F(0))
        for dust_power in range(b + 1):
            inside = F(math.comb(b, dust_power)) * dust ** dust_power * mass ** (b - dust_power)
            if not inside:
                continue
            for negative_power in range(m - s + 1):
                degree = s + dust_power + negative_power
                coefficient[degree] += inside * (-1) ** negative_power * math.comb(m - s, negative_power)
    coefficient = clean(coefficient)
    assert all(1 <= degree <= b and mass >= 0 for degree, mass in coefficient.items())
    assert sum(coefficient.values()) == 1
    return coefficient


def occupancy_dynamic(p, n):
    """Independently draw atoms/dust, tracking seen atoms and dust classes."""
    dust = 1 - sum(p)
    states = {(0, 0): F(1)}
    distributions, missing_ratios = {}, {}
    for b in range(1, n + 1):
        updated = defaultdict(F)
        for (mask, dust_classes), probability in states.items():
            if dust:
                updated[mask, dust_classes + 1] += probability * dust
            for i, mass in enumerate(p):
                updated[mask | (1 << i), dust_classes] += probability * mass
        states = clean(updated)
        dist = defaultdict(F)
        ratio = F(0)
        for (mask, dust_classes), probability in states.items():
            k = mask.bit_count() + dust_classes
            dist[k] += probability
            missing = dust + sum((mass for i, mass in enumerate(p) if not (mask >> i) & 1), F(0))
            ratio += probability * missing / k
        distributions[b] = clean(dist)
        missing_ratios[b] = ratio
    return distributions, missing_ratios


def f_binary(b, r):
    if b == 1:
        return F(0)
    y = 1 - r
    return 2 * sum((F((-1) ** (j + 1) * math.comb(b - 1, j), j) * y**j
                    for j in range(1, b)), F(0))


PAINTBOXES = [
    ("pure_dust", []), ("star", [F(1)]),
    ("one_atom_small", [F(1, 1000)]), ("one_atom_seventh", [F(1, 7)]),
    ("one_atom_half", [F(1, 2)]), ("one_atom_three_quarters", [F(3, 4)]),
    ("two_atoms_with_dust", [F(1, 5), F(2, 5)]),
    ("two_equal_atoms_with_dust", [F(1, 4), F(1, 4)]),
    ("two_unequal_no_dust", [F(1, 3), F(2, 3)]),
    ("two_equal_no_dust", [F(1, 2), F(1, 2)]),
    ("three_atoms_with_dust", [F(1, 7), F(2, 7), F(3, 7)]),
    ("three_dyadic_with_dust", [F(1, 8), F(1, 4), F(1, 2)]),
    ("three_unequal_no_dust", [F(1, 7), F(2, 7), F(4, 7)]),
    ("four_atoms_with_dust", [F(i, 16) for i in (1, 2, 3, 4)]),
    ("four_unequal_no_dust", [F(i, 10) for i in (1, 2, 3, 4)]),
    ("five_atoms_with_dust", [F(i, 64) for i in (1, 2, 4, 8, 16)]),
    ("five_geometric_no_dust", [F(i, 31) for i in (1, 2, 4, 8, 16)]),
    ("five_equal_no_dust", [F(1, 5)] * 5),
    ("five_arithmetic_no_dust", [F(i, 15) for i in (1, 2, 3, 4, 5)]),
]


def occupancy_suite():
    records, data = [], {}
    polynomial_checks = harmonic_checks = missing_checks = potential_checks = moment_identity_checks = 0
    n = 10
    r_values = [F(0), F(1, 10), F(1, 2), F(9, 10), F(99, 100)]
    for name, p in PAINTBOXES:
        assert all(mass > 0 for mass in p) and sum(p) <= 1
        p2 = sum((mass**2 for mass in p), F(0))
        p3 = sum((mass**3 for mass in p), F(0))
        distributions, missing = occupancy_dynamic(p, n)
        deficits = {}
        for b in range(1, n + 1):
            assert occupancy_pgf(p, b) == distributions[b]
            polynomial_checks += 1
            deficits[b] = H(b - 1) - sum(prob * H(k - 1) for k, prob in distributions[b].items())
            if b >= 2:
                assert deficits[b] <= F(b, 2) * p2
                harmonic_checks += 1
                assert missing[b] >= F(1, b) - p2 / 2
                missing_checks += 1
            if b < n:
                EH_next = sum(prob * H(k - 1) for k, prob in distributions[b + 1].items())
                EH_now = sum(prob * H(k - 1) for k, prob in distributions[b].items())
                assert EH_next - EH_now == missing[b]
        assert missing[1] == 1 - p2
        assert deficits[2] == p2 and deficits[3] == 3 * p2 / 2
        assert deficits[4] == 2 * p2 - (4 * p3 - 3 * p2 * p2) / 6
        if p2:
            assert 4 * p3 - 3 * p2 * p2 > 0
        for b in range(2, n + 1):
            for r in r_values:
                fb = f_binary(b, r)
                loss = fb - sum(prob * f_binary(k, r) for k, prob in distributions[b].items())
                bound = C(b) * p2 * (fb - f_binary(b - 1, r))
                assert 0 <= loss <= bound
                potential_checks += 1
        if p and sum(p) == 1:
            mu = mu_direct_subsets(p)
            for b in range(2, n + 1):
                integral_mu = sum(mass * x ** (b - 1) for x, mass in mu.items())
                assert integral_mu == p2 / 2 + missing[b]
                moment_identity_checks += 1
        data[name] = (p, distributions, p2)
        records.append({"name": name, "masses": [str(x) for x in p], "dust": str(1 - sum(p)),
                        "P2": str(p2), "P3": str(p3),
                        "D_b": {str(b): str(d) for b, d in deficits.items()},
                        "D4_formula": str(2 * p2 - (4 * p3 - 3 * p2 * p2) / 6),
                        "K4_distribution": {str(k): str(w) for k, w in distributions[4].items()}})
    return {"paintboxes": len(records), "maximum_atoms": 5, "maximum_sample_size": n,
            "pgf_vs_dynamic_distribution_checks": polynomial_checks,
            "harmonic_bounds": harmonic_checks, "missing_mass_lower_bounds": missing_checks,
            "cyclic_mu_missing_mass_moment_identities": moment_identity_checks,
            "exact_stoploss_potential_inequalities": potential_checks,
            "r_values": [str(r) for r in r_values],
            "threshold_parameterization": "r=1-exp(-s/2); rational r makes binary potentials rational",
            "pure_dust_boundary": "K_b=b, D_b=P2=0; not divided by P2 in the normalized generator",
            "cases": records}, data


def binary_rates(n):
    return {b: {b - 1: F(C(b))} for b in range(2, n + 1)}


def paintbox_rates(distributions, p2, n):
    if p2 <= 0:
        raise ValueError("Pure dust is the separate Kingman component; division by P2=0 is invalid")
    result = {}
    for b in range(2, n + 1):
        result[b] = {m: prob / p2 for m, prob in distributions[b].items() if m < b and prob}
        assert 1 <= sum(result[b].values()) <= C(b)
        assert 1 - distributions[b].get(b, F(0)) <= C(b) * p2
    return result


def mixed_rates(q, kappa, n):
    result = {b: {m: (1 - kappa) * rate for m, rate in q[b].items()} for b in range(2, n + 1)}
    for b in range(2, n + 1):
        result[b][b - 1] = result[b].get(b - 1, F(0)) + kappa * C(b)
        result[b] = clean(result[b])
    return result


def tree_moments(q, n):
    mean, second = {1: F(0)}, {1: F(0)}
    for b in range(2, n + 1):
        total = sum(q[b].values())
        mean[b] = (b + sum(rate * mean[m] for m, rate in q[b].items())) / total
        second[b] = (2 * b * mean[b] + sum(rate * second[m] for m, rate in q[b].items())) / total
    return mean, second


def matrix(q, n):
    out = np.zeros((n - 1, n - 1))
    for b in range(2, n + 1):
        out[b - 2, b - 2] = -float(sum(q[b].values())) / b
        for m, rate in q[b].items():
            if m > 1:
                out[b - 2, m - 2] += float(rate) / b
    return out


def xi_suite(data):
    n = 10
    binary = binary_rates(n)
    lower_mean, lower_second = tree_moments(binary, n)
    records, numerical = [], [("Kingman", F(1), binary)]
    exact_moment_rows = lambda_crosschecks = 0
    selected = {"star", "one_atom_small", "two_equal_no_dust", "three_atoms_with_dust",
                "five_atoms_with_dust", "five_geometric_no_dust"}
    for name, (p, distributions, p2) in data.items():
        if not p2:
            try:
                paintbox_rates(distributions, p2, n)
            except ValueError:
                pass
            else:
                raise AssertionError("The P2=0 singularity must be treated explicitly")
            continue
        q = paintbox_rates(distributions, p2, n)
        if len(p) == 1:
            x = p[0]
            for b in range(2, n + 1):
                for k in range(2, b + 1):
                    explicit = math.comb(b, k) * x ** (k - 2) * (1 - x) ** (b - k)
                    assert q[b].get(b - k + 1, F(0)) == explicit
                    lambda_crosschecks += 1
        for kappa in (F(0), F(1, 3), F(3, 4)):
            combined = mixed_rates(q, kappa, n)
            mean, second = tree_moments(combined, n)
            for b in range(2, n + 1):
                assert lower_mean[b] <= mean[b] <= b
                assert lower_second[b] <= second[b] <= 2 * b * mean[b] <= 2 * b * b
                exact_moment_rows += 1
            assert mean[2] == 2 and mean[3] == 3
            records.append({"paintbox": name, "Kingman_weight": str(kappa),
                            "mean_at_10": str(mean[n]), "second_moment_at_10": str(second[n])})
            if name in selected:
                numerical.append((name, kappa, combined))
    thresholds = [0, 0.01, 0.1, 0.5, 1, 2, 4, 8, 16, 32, 64]
    Ak = matrix(binary, n)
    vk = np.array([float(lower_mean[b]) for b in range(2, n + 1)])
    c = np.arange(2, n + 1, dtype=float)
    worst = {"lower_violation": 0.0, "star_upper_violation": 0.0,
             "mean_refined_upper_violation": 0.0, "mean_equation_residual": 0.0,
             "derivative_identity_residual": 0.0}
    numerical_values = 0
    tolerance = 2e-10
    for name, kappa, q in numerical:
        A = matrix(q, n)
        exact_v, _ = tree_moments(q, n)
        v = np.array([float(exact_v[b]) for b in range(2, n + 1)])
        residual = float(np.max(np.abs(A @ v + np.ones(n - 1))))
        worst["mean_equation_residual"] = max(worst["mean_equation_residual"], residual)
        assert residual <= tolerance
        for threshold in thresholds:
            semigroup = expm(threshold * A)
            stoploss = semigroup @ v
            fk = expm(threshold * Ak) @ vk
            star = c * np.exp(-threshold / c)
            refined = v * np.exp(-threshold / c)
            values = {
                "lower_violation": float(max(0, np.max(fk - stoploss))),
                "star_upper_violation": float(max(0, np.max(stoploss - star))),
                "mean_refined_upper_violation": float(max(0, np.max(stoploss - refined))),
                "derivative_identity_residual": float(np.max(np.abs(A @ stoploss + semigroup @ np.ones(n - 1)))),
            }
            for key, error in values.items():
                worst[key] = max(worst[key], error)
                assert error <= tolerance * n
            numerical_values += n - 1
    q_example = paintbox_rates(data["two_equal_no_dust"][1], data["two_equal_no_dust"][2], n)
    wrong_budget = sum(C(4 - m + 1) * rate for m, rate in q_example[4].items())
    assert wrong_budget == F(27, 4) and wrong_budget != C(4)
    return {"finite_Xi_chain_instances": len(records), "maximum_sample_size": n,
            "exact_mean_and_second_moment_rows": exact_moment_rows,
            "single_atom_Lambda_rate_crosschecks": lambda_crosschecks,
            "Kingman_mixture_weights": ["0", "1/3", "3/4"],
            "numerical_chain_instances": len(numerical), "thresholds": thresholds,
            "numerical_state_threshold_values": numerical_values,
            "numerical_tolerance": tolerance,
            "order_tolerance_rule": "2e-10 * N, with N=10; residual of mean equation uses 2e-10",
            "max_absolute_errors_or_violations": worst,
            "wrong_single_group_budget_example": {"paintbox": ["1/2", "1/2"],
                                                   "wrong_budget": str(wrong_budget),
                                                   "true_pair_budget": "6",
                                                   "note": "Do not encode disjoint simultaneous mergers as one group."},
            "exact_cases": records,
            "limitation": "Only finitely many finite-atom paintboxes, dust masses, binary mixture weights, states, and thresholds are checked."}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", default="paintbox_results.json")
    args = parser.parse_args()
    occupancy_report, data = occupancy_suite()
    report = {
        "title": "Exact finite diagnostics for paintbox occupancy and circular differences",
        "selection": "Deterministic rational vectors and fixed finite grids; no random sampling",
        "cyclic_representation": cyclic_suite(),
        "arc_variance_identity": circle_variance_suite(),
        "occupancy": occupancy_report, "finite_Xi_chains": xi_suite(data),
        "environment": {"python": platform.python_version(), "numpy": np.__version__, "scipy": scipy.__version__},
        "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "overall_status": "PASS: every stated finite check completed",
        "scope": "Finite mathematical diagnostics for the cyclic representation and Xi generators.",
    }
    destination = Path(args.output)
    destination.write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps({"output": str(destination.resolve()), "status": report["overall_status"],
                      "cyclic_vectors": report["cyclic_representation"]["vectors"],
                      "circle_thresholds": report["arc_variance_identity"]["thresholds_checked"],
                      "occupancy_checks": report["occupancy"]["pgf_vs_dynamic_distribution_checks"],
                      "exact_potential_inequalities": report["occupancy"]["exact_stoploss_potential_inequalities"],
                      "Xi_exact_moment_rows": report["finite_Xi_chains"]["exact_mean_and_second_moment_rows"],
                      "Xi_float_state_threshold_values": report["finite_Xi_chains"]["numerical_state_threshold_values"],
                      "Xi_float_max_errors": report["finite_Xi_chains"]["max_absolute_errors_or_violations"]}, indent=2))


if __name__ == "__main__":
    main()
