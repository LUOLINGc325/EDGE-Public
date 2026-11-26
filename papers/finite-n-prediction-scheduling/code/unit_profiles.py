#!/usr/bin/env python3
"""Rational unit-instance snapshots for the proposed finite-n construction.

This code evaluates the manuscript's recurrence and independently checks its
finite output. It is not a substitute for the general proof of that recurrence,
its optimality, or the fallback after a prediction error.
"""

from __future__ import annotations

import argparse
from fractions import Fraction
import json
from pathlib import Path
import random

from snapshot_certificate import combine_snapshots, validate_unit_profile


def generate_unit_profile(m: int, robustness) -> dict:
    R = robustness if isinstance(robustness, Fraction) else Fraction(str(robustness))
    if m < 1:
        raise ValueError("m must be positive.")
    if R < Fraction(2 * m, m + 1):
        raise ValueError("R is below the finite-m no-prediction threshold.")
    cutoff = 0 if R >= m else int(Fraction(m + 1) / (R + 1))
    q_values = [Fraction(0)]
    recurrence = []
    for i in range(1, m):
        previous = q_values[-1]
        if i <= cutoff:
            d = ((R - 2) * (m + 1) + (R + 2) * i) / 2
            numerator = (m + 1) - (R + 1) * i
            denominator = (m - i) * d
            if denominator <= 0:
                raise ArithmeticError(("nonpositive recurrence denominator", m, R, i, d))
            coefficient = numerator / denominator
            if not 0 <= coefficient <= 1:
                raise ArithmeticError(("recurrence coefficient outside [0,1]", m, R, i, coefficient))
            current = previous + coefficient * (1 - previous)
            recurrence.append({"i": i, "d_i": str(d), "coefficient": str(coefficient),
                               "q_previous": str(previous), "q_current": str(current)})
        else:
            current = previous
        if not previous <= current <= 1:
            raise ArithmeticError(("unit level out of range or decreasing", m, R, i))
        q_values.append(current)
    snapshots = [[Fraction(0)] * m]
    for k in range(1, m + 1):
        level = q_values[min(k, m - 1)]
        snapshots.append([Fraction(1)] * k + [level] * (m - k))
    raw = {
        "m": m, "R": str(R), "cutoff": cutoff,
        "source": "Finite-n manuscript unit-profile recurrence; exact execution only, universal proof separate.",
        "q_values": [str(x) for x in q_values],
        "recurrence": recurrence,
        "snapshots": [[str(x) for x in row] for row in snapshots],
        "completion_times": [str(sum(row, Fraction(0))) for row in snapshots[1:]],
    }
    validated = validate_unit_profile(m, raw, R)
    raw["exact_validation"] = {
        "cost": str(validated["cost"]),
        "optimum": str(Fraction(m * (m + 1), 2)),
        "ratio": str(validated["cost"] / Fraction(m * (m + 1), 2)),
        "invariant_margins": [str(x) for x in validated["margins"]],
    }
    return raw


def generate_profiles(n: int, robustness) -> dict:
    return {str(m): generate_unit_profile(m, robustness) for m in range(1, n + 1)}


def regression(directory: str) -> dict:
    """Reproduce the finite exact checks and three supplied rational examples."""
    from mrc_simulator import simulate_exact

    rng = random.Random(20261125)
    count, unit_checks = 0, 0
    rows = []
    for n in range(2, 11):
        for R in sorted({Fraction(2 * n, n + 1), Fraction(2), Fraction(5, 2), Fraction(3), Fraction(n)}):
            profiles = generate_profiles(n, R)
            for m in range(1, n + 1):
                run = simulate_exact([1] * m, R, keep_trace=False)
                if str(run.ratio) != profiles[str(m)]["exact_validation"]["ratio"]:
                    raise AssertionError(("unit-MRC mismatch", n, m, R))
                unit_checks += 1
            for _ in range(5):
                y = sorted(Fraction(rng.randint(1, 40), rng.randint(1, 7)) for _ in range(n))
                certificate = combine_snapshots(y, profiles, R)
                if not certificate["valid"]:
                    raise AssertionError("positive-prediction certificate failed")
                count += 1
            rows.append({"n": n, "R": str(R),
                         "unit_ratios": {k: v["exact_validation"]["ratio"] for k, v in profiles.items()}})
    output = Path(directory)
    output.mkdir(parents=True, exist_ok=True)
    report = {
        "seed": 20261125,
        "exact_positive_prediction_combinations_verified": count,
        "unit_profile_to_independent_MRC_matches": unit_checks,
        "rows": rows,
        "scope": "Finite exact checks, not a general proof of recurrence, monotonicity in m, or universal optimality.",
        "prediction_error_fallback": "Not simulated here. The manuscript uses ordinary Round-Robin among unfinished jobs after the first detected prediction error. Its state-dependent robustness guarantee is a separate mathematical proof, including simultaneous completions.",
    }
    (output / "unit_profile_regression.json").write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    examples = []
    for R, y in [
        (Fraction(2), [Fraction(1, 3), Fraction(2, 3), Fraction(2), Fraction(7, 2), Fraction(8)]),
        (Fraction(5, 3), [Fraction(1), Fraction(1), Fraction(2), Fraction(3), Fraction(3)]),
        (Fraction(5, 2), [Fraction(1), Fraction(3, 2), Fraction(3, 2), Fraction(7), Fraction(9), Fraction(21)]),
    ]:
        payload = {"R": str(R), "prediction": [str(x) for x in y],
                   "profiles": generate_profiles(len(y), R)}
        examples.append({"input": payload, "certificate": combine_snapshots(y, payload["profiles"], R)})
    (output / "snapshot_examples.json").write_text(json.dumps({"examples": examples}, indent=2) + "\n", encoding="utf-8")
    return {"combinations_verified": count, "unit_matches": unit_checks,
            "sample_ratios": [e["certificate"]["ratio"] for e in examples],
            "directory": str(output)}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--sizes", nargs="+", help="Sorted positive predictions, rational syntax accepted.")
    parser.add_argument("--robustness")
    parser.add_argument("--output")
    parser.add_argument("--certificate-output")
    parser.add_argument("--regression-directory")
    args = parser.parse_args()
    if args.regression_directory:
        print(json.dumps(regression(args.regression_directory)))
        return
    if not args.sizes or not args.robustness or not args.output:
        parser.error("--sizes, --robustness, and --output are required except with --regression-directory")
    payload = {"R": args.robustness, "prediction": args.sizes,
               "profiles": generate_profiles(len(args.sizes), args.robustness)}
    certificate = combine_snapshots(payload["prediction"], payload["profiles"], payload["R"])
    Path(args.output).write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    if args.certificate_output:
        Path(args.certificate_output).write_text(json.dumps(certificate, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"valid": certificate["valid"], "ratio": certificate["ratio"],
                      "maximum_active_unit_ratio": certificate["maximum_active_unit_ratio"],
                      "profile_output": args.output, "certificate_output": args.certificate_output}))


if __name__ == "__main__":
    main()
