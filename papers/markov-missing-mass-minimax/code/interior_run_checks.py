#!/usr/bin/env python3
"""Reproducible, bounded validation of the interior unique-run estimator.

The exact tests are finite arithmetic checks, not universal mathematical proofs.
The seeded simulations use a fixed grid and do not search over models. In every
simulation the target is the random stationary mass of the actually unseen set.
The alternating-island family is outside the refreshing-chain theorem.

Run with Python's standard library only:
    python code/interior_run_checks.py --replicates 500 --seed 20261125

Outputs, relative to this script's case directory:
    results/interior_run_checks.json
    results/interior_run_simulation.csv
"""

from __future__ import annotations

import argparse
from bisect import bisect_right
from collections import Counter
import csv
from fractions import Fraction
import hashlib
from itertools import combinations, product
import json
import math
from pathlib import Path
import random
import sys


def run_numerators(path):
    """Return interior unique-run, all unique-run, and singleton numerators.

    A label is eligible only if it has exactly one maximal run in the *whole*
    trajectory. The interior statistic additionally removes both censored ends.
    """
    assert len(path) >= 1
    runs = []
    begin = 0
    for index in range(1, len(path) + 1):
        if index == len(path) or path[index] != path[begin]:
            runs.append((path[begin], begin, index))
            begin = index
    counts = Counter(label for label, _, _ in runs)
    interior = raw = 0
    for label, begin, end in runs:
        if counts[label] == 1:
            raw += end - begin
            if begin > 0 and end < len(path):
                interior += end - begin
    singleton_count = sum(count == 1 for count in Counter(path).values())
    return interior, raw, singleton_count


def interior_reference_numerator(path):
    """Independent definition using all occurrence positions of each label."""
    total = 0
    for label in set(path):
        positions = [i for i, value in enumerate(path) if value == label]
        if (
            positions[0] > 0
            and positions[-1] < len(path) - 1
            and positions[-1] - positions[0] + 1 == len(positions)
        ):
            total += len(positions)
    return total


def positive_compositions(total, parts):
    for cuts in combinations(range(1, total), parts - 1):
        endpoints = (0,) + cuts + (total,)
        yield tuple(endpoints[i + 1] - endpoints[i] for i in range(parts))


def rational_record(value):
    return {"fraction": str(value), "decimal": float(value)}


def estimator_implementation_checks():
    named_cases = (
        ((0,), 0),
        ((0, 0, 0), 0),
        ((0, 1), 0),
        ((0, 1, 1, 0), 2),
        ((0, 1, 2, 1, 3), 1),
        ((0, 1, 1, 2, 1, 1, 3), 1),
        ((0, 1, 2, 2, 1, 3, 3, 4), 4),
    )
    for path, expected in named_cases:
        assert run_numerators(path)[0] == expected
        assert interior_reference_numerator(path) == expected
    count = 0
    for alphabet_size in (2, 3):
        for n in range(1, 8):
            for path in product(range(alphabet_size), repeat=n):
                computed, raw, singleton_count = run_numerators(path)
                assert computed == interior_reference_numerator(path)
                assert 0 <= computed <= raw <= n
                assert 0 <= singleton_count <= n
                count += 1
    return {
        "named_edge_cases_passed": len(named_cases),
        "all_paths_compared_with_independent_definition": count,
        "max_length": 7,
        "alphabet_sizes": [2, 3],
    }


def uniform_composition_checks():
    rows = []
    weighted_indicator_checks = 0
    for n in range(1, 10):
        for k in range(1, n + 1):
            compositions = list(positive_compositions(n, k))
            count = len(compositions)
            assert count == math.comb(n - 1, k - 1)
            mean = sum(Fraction(c[0]) for c in compositions) / count
            variance = sum((Fraction(c[0]) - mean) ** 2 for c in compositions) / count
            claimed_variance = Fraction(n * (n - k) * (k - 1), k * k * (k + 1))
            assert mean == Fraction(n, k)
            assert variance == claimed_variance
            covariance = None
            if k >= 2:
                covariance = sum(
                    (Fraction(c[0]) - mean) * (Fraction(c[1]) - mean)
                    for c in compositions
                ) / count
                assert covariance == -Fraction(n * (n - k), k * k * (k + 1))
            squared_weight_sum = sum(
                sum(Fraction(length, n) ** 2 for length in c) for c in compositions
            ) / count
            assert squared_weight_sum == Fraction(2 * n - k + 1, n * (k + 1))
            for a in range(k + 1):
                values = [Fraction(sum(c[:a]), n) for c in compositions]
                value_mean = sum(values) / count
                value_variance = sum((value - value_mean) ** 2 for value in values) / count
                assert value_mean == Fraction(a, k)
                assert value_variance == Fraction(
                    (n - k) * a * (k - a), n * k * k * (k + 1)
                )
                weighted_indicator_checks += 1
            rows.append({
                "n": n,
                "k": k,
                "composition_count": count,
                "mean_first_length": rational_record(mean),
                "variance_first_length": rational_record(variance),
                "covariance_first_two": None if covariance is None else rational_record(covariance),
                "expected_squared_weight_sum": rational_record(squared_weight_sum),
            })
    return {
        "all_exact_equalities_passed": True,
        "weighted_indicator_variance_cases": weighted_indicator_checks,
        "rows": rows,
    }


def reciprocal_refresh_count_checks():
    rows = []
    for n in range(1, 21):
        for refresh in (Fraction(1), Fraction(1, 2), Fraction(1, 8), Fraction(1, 32)):
            probabilities = [
                Fraction(math.comb(n - 1, k - 1))
                * refresh ** (k - 1)
                * (1 - refresh) ** (n - k)
                for k in range(1, n + 1)
            ]
            assert sum(probabilities) == 1
            computed = sum(probability / k for k, probability in enumerate(probabilities, 1))
            formula = (1 - (1 - refresh) ** n) / (n * refresh)
            assert computed == formula
            assert computed <= 1 and computed <= 1 / (n * refresh)
            rows.append({"n": n, "r": str(refresh), "expected_reciprocal": rational_record(computed)})
    return {"all_exact_equalities_passed": True, "rows": rows}


def latent_observable_checks():
    distributions = (
        (Fraction(1, 2), Fraction(1, 2)),
        (Fraction(2, 3), Fraction(1, 3)),
        (Fraction(1, 2), Fraction(1, 3), Fraction(1, 6)),
    )
    rows = []
    configurations = 0
    for n in range(1, 7):
        for k in range(1, n + 1):
            compositions = list(positive_compositions(n, k))
            for stationary in distributions:
                means = {name: Fraction(0) for name in (
                    "absolute_difference", "squared_difference", "deleted_boundary_weight",
                    "merged_extra_weight", "latent_mse", "observable_mse", "probability",
                )}
                for labels in product(range(len(stationary)), repeat=k):
                    label_probability = math.prod(stationary[label] for label in labels)
                    counts = Counter(labels)
                    missing = sum(p for x, p in enumerate(stationary) if counts[x] == 0)
                    extra_positions = []
                    for label in set(labels):
                        positions = [j for j, value in enumerate(labels) if value == label]
                        if (
                            len(positions) >= 2
                            and positions[0] > 0
                            and positions[-1] < k - 1
                            and positions[-1] - positions[0] + 1 == len(positions)
                        ):
                            extra_positions.extend(positions)
                    for lengths in compositions:
                        weight = label_probability / len(compositions)
                        path = tuple(
                            label for label, length in zip(labels, lengths) for _ in range(length)
                        )
                        latent_numerator = sum(
                            length for label, length in zip(labels, lengths) if counts[label] == 1
                        )
                        boundary_numerator = sum(
                            lengths[j] for j in {0, k - 1} if counts[labels[j]] == 1
                        )
                        extra_numerator = sum(lengths[j] for j in extra_positions)
                        interior_numerator = run_numerators(path)[0]
                        assert interior_numerator == interior_reference_numerator(path)
                        assert interior_numerator - latent_numerator == extra_numerator - boundary_numerator
                        latent = Fraction(latent_numerator, n)
                        observable = Fraction(interior_numerator, n)
                        difference = observable - latent
                        assert difference * difference <= abs(difference)
                        assert missing == sum(p for x, p in enumerate(stationary) if x not in set(path))
                        means["probability"] += weight
                        means["absolute_difference"] += weight * abs(difference)
                        means["squared_difference"] += weight * difference * difference
                        means["deleted_boundary_weight"] += weight * Fraction(boundary_numerator, n)
                        means["merged_extra_weight"] += weight * Fraction(extra_numerator, n)
                        means["latent_mse"] += weight * (latent - missing) ** 2
                        means["observable_mse"] += weight * (observable - missing) ** 2
                        configurations += 1
                assert means["probability"] == 1
                assert means["deleted_boundary_weight"] <= Fraction(2, k)
                assert means["merged_extra_weight"] <= Fraction(2, k)
                assert means["absolute_difference"] <= min(Fraction(1), Fraction(4, k))
                assert means["squared_difference"] <= means["absolute_difference"]
                assert means["latent_mse"] <= Fraction(13, 4 * k)
                assert means["observable_mse"] <= Fraction(29, 2 * k)
                rows.append({
                    "n": n,
                    "k": k,
                    "stationary_probabilities": [str(p) for p in stationary],
                    **{name: rational_record(value) for name, value in means.items() if name != "probability"},
                })
    return {
        "all_exact_equalities_and_bounds_passed": True,
        "label_composition_configurations": configurations,
        "rows": rows,
    }


def make_cdf(probabilities):
    assert all(value > 0 for value in probabilities)
    assert abs(math.fsum(probabilities) - 1) < 1e-12
    cdf = []
    total = 0.0
    for value in probabilities:
        total += value
        cdf.append(total)
    cdf[-1] = 1.0
    return cdf


def sample_stationary_path(n, refresh, cdf, rng, alternating=False):
    """Generate geometric refresh blocks; optionally alternate within each block."""
    path = []
    log_survival = math.log1p(-refresh) if refresh < 1 else None
    while len(path) < n:
        label = bisect_right(cdf, rng.random())
        length = 1 if refresh == 1 else 1 + int(math.log1p(-rng.random()) / log_survival)
        length = min(length, n - len(path))
        if alternating:
            path.extend(label ^ (j % 2) for j in range(length))
        else:
            path.extend([label] * length)
    return path


def average_and_standard_error(values):
    count = len(values)
    average = math.fsum(values) / count
    variance = math.fsum((value - average) ** 2 for value in values) / (count - 1)
    return average, math.sqrt(variance / count)


def fixed_simulation_specification():
    rows = []
    for n in (32, 128, 512, 2048):
        for refresh in (1.0, 0.5, 0.125, 0.03125):
            cloud_size = max(2, math.ceil(n * refresh))
            rows.append({
                "family": "uniform_refresh", "theorem_applies": True,
                "n": n, "r": refresh,
                "probabilities": [1 / cloud_size] * cloud_size,
                "dust_count": cloud_size, "heavy_mass": "", "islands": "",
            })
            rows.append({
                "family": "heavy_plus_dust_refresh", "theorem_applies": True,
                "n": n, "r": refresh,
                "probabilities": [0.5] + [0.5 / cloud_size] * cloud_size,
                "dust_count": cloud_size, "heavy_mass": 0.5, "islands": "",
            })
            epsilon = min(0.1, 1 / (n * refresh))
            rows.append({
                "family": "dominant_two_state_refresh", "theorem_applies": True,
                "n": n, "r": refresh,
                "probabilities": [1 - epsilon, epsilon],
                "dust_count": 1, "heavy_mass": 1 - epsilon, "islands": "",
            })
    for n in (32, 128, 512, 2048):
        islands = math.ceil(n / 2)
        rows.append({
            "family": "alternating_islands_general_chain", "theorem_applies": False,
            "n": n, "r": 0.5,
            "probabilities": [1 / (2 * islands)] * (2 * islands),
            "dust_count": "", "heavy_mass": "", "islands": islands,
        })
    return rows


def simulate_fixed_grid(replicates, seed):
    rows = []
    for row_index, specification in enumerate(fixed_simulation_specification()):
        row_seed = seed + 1000003 * row_index
        rng = random.Random(row_seed)
        probabilities = specification["probabilities"]
        cdf = make_cdf(probabilities)
        n = specification["n"]
        refresh = specification["r"]
        targets, estimates, errors, losses, raw_losses, gt_losses = ([] for _ in range(6))
        for _ in range(replicates):
            path = sample_stationary_path(
                n, refresh, cdf, rng, alternating=not specification["theorem_applies"]
            )
            seen = set(path)
            target = math.fsum(p for x, p in enumerate(probabilities) if x not in seen)
            interior, raw, singleton_count = run_numerators(path)
            estimate = interior / n
            error = estimate - target
            targets.append(target)
            estimates.append(estimate)
            errors.append(error)
            losses.append(error**2)
            raw_losses.append((raw / n - target) ** 2)
            gt_losses.append((singleton_count / n - target) ** 2)
        mse, mse_se = average_and_standard_error(losses)
        bias, bias_se = average_and_standard_error(errors)
        rows.append({
            "family": specification["family"],
            "refreshing_theorem_applies": specification["theorem_applies"],
            "n": n,
            "r": refresh,
            "n_times_r": n * refresh,
            "state_count": len(probabilities),
            "dust_count": specification["dust_count"],
            "heavy_mass": specification["heavy_mass"],
            "island_count": specification["islands"],
            "replicates": replicates,
            "seed": row_seed,
            "target_mean": math.fsum(targets) / replicates,
            "interior_run_mean": math.fsum(estimates) / replicates,
            "interior_run_bias": bias,
            "interior_run_bias_standard_error": bias_se,
            "interior_run_mse": mse,
            "interior_run_mse_standard_error": mse_se,
            "n_r_times_interior_run_mse": n * refresh * mse,
            "raw_unique_run_mse": math.fsum(raw_losses) / replicates,
            "classical_good_turing_mse": math.fsum(gt_losses) / replicates,
        })
    return rows


def simulation_summary(rows):
    refreshing = [row for row in rows if row["refreshing_theorem_applies"]]
    islands = [row for row in rows if not row["refreshing_theorem_applies"]]
    return {
        "fixed_grid_rows": len(rows),
        "refreshing_rows": len(refreshing),
        "general_chain_rows": len(islands),
        "trajectories_total": sum(row["replicates"] for row in rows),
        "largest_observed_n_r_times_refreshing_mse": max(
            row["n_r_times_interior_run_mse"] for row in refreshing
        ),
        "general_chain_rows_full": islands,
        "interpretation": [
            "Reported targets are random missing masses of each realized trajectory.",
            "Monte Carlo standard errors describe finite simulation uncertainty; they are not proof certificates.",
            "A bounded set of scaled risks does not establish a uniform upper bound.",
            "Alternating islands are outside the refreshing-chain theorem; their simulation only supports a scope warning.",
            "The raw-run baseline deliberately retains both censored boundary runs and is not the proposed estimator.",
        ],
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--replicates", type=int, default=500)
    parser.add_argument("--seed", type=int, default=20261125)
    args = parser.parse_args()
    assert 200 <= args.replicates <= 1000, "This bounded validation permits 200--1000 repeats per fixed row."

    results_directory = Path(__file__).resolve().parents[1] / "results"
    results_directory.mkdir(parents=True, exist_ok=True)
    exact_results = {
        "estimator_implementation": estimator_implementation_checks(),
        "uniform_composition": uniform_composition_checks(),
        "reciprocal_refresh_count": reciprocal_refresh_count_checks(),
        "latent_observable_comparison": latent_observable_checks(),
    }
    rows = simulate_fixed_grid(args.replicates, args.seed)
    csv_path = results_directory / "interior_run_simulation.csv"
    with csv_path.open("w", newline="", encoding="utf-8") as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    report = {
        "status": "all finite exact checks passed; simulations completed",
        "scope": "Validation only. This file does not certify the universal theorem or settle the general Markov minimax problem.",
        "runtime": {"python": sys.version, "dependencies": "Python standard library only"},
        "provenance": {
            "script": "code/interior_run_checks.py",
            "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            "simulation_csv_sha256": hashlib.sha256(csv_path.read_bytes()).hexdigest(),
            "seed": args.seed,
            "row_seed_rule": "base_seed + 1000003 * zero_based_row_index",
            "replicates_per_row": args.replicates,
            "adaptive_search": False,
        },
        "simulation_design": {
            "sample_sizes": [32, 128, 512, 2048],
            "refresh_probabilities": [1, 0.5, 0.125, 0.03125],
            "uniform_states": "max(2, ceil(n*r))",
            "heavy_plus_dust": "heavy mass 1/2 and max(2, ceil(n*r)) equally weighted dust states",
            "dominant_two_state": "pi=(1-epsilon, epsilon), epsilon=min(0.1, 1/(n*r))",
            "general_chain": "P=(1-r)A+r*1*pi, r=1/2; A swaps two labels in every island; pi uniform over 2*ceil(n/2) labels",
            "general_chain_mixing_check": "A preserves pi, so P^t=(1-r)^t A^t + (1-(1-r)^t)*1*pi; t_mix(1/4)<=2 at r=1/2.",
            "sampling": "independent geometric refresh blocks with fresh categorical labels; alternating-island blocks alternate the paired label",
        },
        "exact_checks": exact_results,
        "simulation_summary": simulation_summary(rows),
    }
    json_path = results_directory / "interior_run_checks.json"
    json_path.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({
        "status": report["status"],
        "independent_path_definition_checks": exact_results["estimator_implementation"]["all_paths_compared_with_independent_definition"],
        "composition_parameter_pairs": len(exact_results["uniform_composition"]["rows"]),
        "reciprocal_parameter_pairs": len(exact_results["reciprocal_refresh_count"]["rows"]),
        "latent_parameter_rows": len(exact_results["latent_observable_comparison"]["rows"]),
        "latent_configurations": exact_results["latent_observable_comparison"]["label_composition_configurations"],
        "simulation_summary": report["simulation_summary"],
        "outputs": [str(json_path), str(csv_path)],
    }, indent=2))


if __name__ == "__main__":
    main()
