#!/usr/bin/env python3
"""Reproduce the already-performed finite checks of the island counterexample.

The fixed scope is K in {2, 3}, n in {1, ..., 5}, and r=1/2: exactly 10,694
paths. No simulation or model search is performed. Exact rational enumeration
checks the killed-matrix missing-mass expectation, the two-arm singleton
expectation, and the pathwise comparison of the interior-run and singleton
statistics. The two-eigenvalue closed forms are additionally checked in float.

Run with Python's standard library only:
    python code/general_counterexample_checks.py

Output:
    results/general_counterexample_checks.json

These finite checks do not replace the analytic proof in
the general counterexample proof in the manuscript.
"""

from collections import Counter
from fractions import Fraction
import hashlib
from itertools import product
import json
from math import sqrt
from pathlib import Path
import sys


def as_rational_record(value):
    return {"fraction": str(value), "decimal": float(value)}


def check_fixed_cases():
    total_paths = 0
    maximum_float_error = 0.0
    rows = []
    for islands in (2, 3):
        refresh = Fraction(1, 2)
        mass = Fraction(1, 2 * islands)
        killed = (
            (refresh * mass, refresh * (1 - 2 * mass)),
            (refresh * mass, 1 - 2 * refresh * mass),
        )

        def step(vector):
            return tuple(
                sum(vector[i] * killed[i][j] for i in range(2))
                for j in range(2)
            )

        no_return = [Fraction(1)]
        from_target = (1 - refresh + refresh * mass, refresh * (1 - 2 * mass))
        no_visit = []
        from_stationarity = (mass, 1 - 2 * mass)
        for _ in range(5):
            no_return.append(sum(from_target))
            from_target = step(from_target)
            no_visit.append(sum(from_stationarity))
            from_stationarity = step(from_stationarity)

        trace = float(1 - refresh * mass)
        determinant = float(refresh * mass * (1 - refresh))
        gap = sqrt(trace * trace - 4 * determinant)
        dominant = (trace + gap) / 2
        secondary = (trace - gap) / 2
        coefficient_c = (float(no_return[2]) - secondary * float(no_return[1])) / gap
        coefficient_d = (dominant * float(no_return[1]) - float(no_return[2])) / gap
        coefficient_b = (float(no_visit[1]) - secondary * float(no_visit[0])) / gap
        coefficient_e = (dominant * float(no_visit[0]) - float(no_visit[1])) / gap

        for n in range(1, 6):
            expected_missing = Fraction(0)
            expected_singleton = Fraction(0)
            expected_difference = Fraction(0)
            path_count = 0
            for path in product(range(2 * islands), repeat=n):
                probability = mass
                for previous, current in zip(path, path[1:]):
                    probability *= refresh * mass + (
                        1 - refresh if current == (previous ^ 1) else 0
                    )
                counts = Counter(path)
                target = Fraction(2 * islands - len(counts), 2 * islands)
                singleton = Fraction(sum(count == 1 for count in counts.values()), n)
                numerator = 0
                for label in counts:
                    positions = [i for i, value in enumerate(path) if value == label]
                    if (
                        positions[0] > 0
                        and positions[-1] < n - 1
                        and positions[-1] - positions[0] + 1 == len(positions)
                    ):
                        numerator += len(positions)
                interior = Fraction(numerator, n)
                adjacent_equalities = sum(
                    previous == current for previous, current in zip(path, path[1:])
                )
                assert abs(interior - singleton) <= Fraction(2, n) + Fraction(
                    2 * adjacent_equalities, n
                )
                expected_missing += probability * target
                expected_singleton += probability * singleton
                expected_difference += probability * abs(interior - singleton)
                path_count += 1
                total_paths += 1

            two_arm_value = sum(
                no_return[i - 1] * no_return[n - i] for i in range(1, n + 1)
            ) / n
            difference_bound = Fraction(2, n) + refresh / islands
            assert expected_missing == no_visit[n - 1]
            assert expected_singleton == two_arm_value
            assert expected_difference <= difference_bound

            closed_missing = (
                coefficient_b * dominant ** (n - 1)
                + coefficient_e * secondary ** (n - 1)
            )
            missing_float_error = abs(closed_missing - float(expected_missing))
            maximum_float_error = max(maximum_float_error, missing_float_error)
            closed_singleton = None
            singleton_float_error = None
            if n >= 3:
                closed_singleton = (
                    ((n - 2) / n)
                    * (
                        coefficient_c**2 * dominant ** (n - 3)
                        + coefficient_d**2 * secondary ** (n - 3)
                    )
                    + (2 * coefficient_c * coefficient_d / n)
                    * (dominant ** (n - 2) - secondary ** (n - 2))
                    / gap
                    + (2 / n)
                    * (
                        coefficient_c * dominant ** (n - 2)
                        + coefficient_d * secondary ** (n - 2)
                    )
                )
                singleton_float_error = abs(closed_singleton - float(expected_singleton))
                maximum_float_error = max(maximum_float_error, singleton_float_error)
            rows.append({
                "islands_K": islands,
                "state_count": 2 * islands,
                "n": n,
                "r": str(refresh),
                "path_count": path_count,
                "expected_random_missing_mass": as_rational_record(expected_missing),
                "killed_matrix_missing_mass": as_rational_record(no_visit[n - 1]),
                "expected_singleton_estimate": as_rational_record(expected_singleton),
                "two_arm_singleton_formula": as_rational_record(two_arm_value),
                "expected_absolute_estimator_difference": as_rational_record(expected_difference),
                "absolute_difference_upper_bound": as_rational_record(difference_bound),
                "all_pathwise_bounds_passed": True,
                "closed_form_missing_mass_double": closed_missing,
                "closed_form_missing_mass_absolute_error": missing_float_error,
                "closed_form_singleton_double": closed_singleton,
                "closed_form_singleton_absolute_error": singleton_float_error,
                "short_sample_note": "Singleton closed form requires n>=3; the exact two-arm identity was checked for this n." if n < 3 else "",
            })

    assert total_paths == 10694
    assert len(rows) == 10
    assert maximum_float_error < 1e-12
    return {
        "exact_path_checks": total_paths,
        "parameter_pairs": len(rows),
        "all_exact_moment_and_pathwise_checks_passed": True,
        "maximum_double_precision_closed_form_error": maximum_float_error,
        "double_precision_error_tolerance": 1e-12,
        "rows": rows,
    }


def main():
    script_path = Path(__file__).resolve()
    results = check_fixed_cases()
    output = script_path.parents[1] / "results" / "general_counterexample_checks.json"
    output.parent.mkdir(parents=True, exist_ok=True)
    report = {
        "status": "all fixed finite checks passed",
        "exit_code": 0,
        "scope": "Finite arithmetic verification of an analytic estimator-specific counterexample; not a proof of the asymptotic theorem or a minimax lower bound.",
        "runtime": {"python": sys.version, "dependencies": "Python standard library only"},
        "provenance": {
            "script": "code/general_counterexample_checks.py",
            "script_sha256": hashlib.sha256(script_path.read_bytes()).hexdigest(),
            "command": "python code/general_counterexample_checks.py",
            "fixed_islands_K": [2, 3],
            "fixed_sample_sizes": [1, 2, 3, 4, 5],
            "refresh_probability": "1/2",
            "arithmetic": "Fractions for path probabilities and moments; float for the two-eigenvalue closed forms only",
            "monte_carlo_used": False,
            "adaptive_model_search": False,
            "scope_change_from_previously_executed_check": False,
        },
        "checks": results,
    }
    output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({
        "status": report["status"],
        "exit_code": report["exit_code"],
        "exact_path_checks": results["exact_path_checks"],
        "parameter_pairs": results["parameter_pairs"],
        "maximum_double_precision_closed_form_error": results["maximum_double_precision_closed_form_error"],
        "script_sha256": report["provenance"]["script_sha256"],
        "report_sha256": hashlib.sha256(output.read_bytes()).hexdigest(),
        "output": str(output),
    }, indent=2))


if __name__ == "__main__":
    main()
