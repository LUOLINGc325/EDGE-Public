#!/usr/bin/env python3
"""Exact checker for positive combinations of fixed-order snapshots.

Input JSON:
  {"R": "2", "prediction": ["1", "2", "3"],
   "profiles": {"1": {"snapshots": [["0"], ["1"]]}, ...}}

A unit m-job profile has m+1 cumulative-service snapshots, indexed 0..m.
Snapshot k must finish jobs 0..k-1 and must not overprocess any other job.
Times are derived as the sums of service, not assumed independently.
Profiles are externally supplied certificates; this checker does not assert
that the published Sys construction or any optimizer always produces them.
All validations and reported margins use Fraction arithmetic.
"""

from __future__ import annotations

import argparse
from fractions import Fraction
import json
from pathlib import Path
from typing import Any, Sequence


def q(value: Any) -> Fraction:
    if isinstance(value, Fraction):
        return value
    return Fraction(str(value))


def frozen_optimum(values: Sequence[Fraction]) -> Fraction:
    """sum_i e_i + sum_{i<j} min(e_i,e_j), without sorting assumptions."""
    return sum(values, Fraction(0)) + sum(
        (min(values[i], values[j]) for i in range(len(values)) for j in range(i + 1, len(values))),
        Fraction(0),
    )


def snapshot_cost(times: Sequence[Fraction], k: int, n: int) -> Fraction:
    return sum(times[1:k + 1], Fraction(0)) + (n - k) * times[k]


def validate_unit_profile(m: int, raw: dict, R: Fraction) -> dict:
    if m <= 0:
        raise ValueError("Unit-profile dimension must be positive.")
    rows = [[q(value) for value in row] for row in raw["snapshots"]]
    if len(rows) != m + 1 or any(len(row) != m for row in rows):
        raise ValueError(f"m={m}: expected m+1 rows, each with m entries.")
    if rows[0] != [Fraction(0)] * m:
        raise ValueError(f"m={m}: snapshot zero must be the zero vector.")
    times = [sum(row, Fraction(0)) for row in rows]
    if "completion_times" in raw:
        supplied = [q(value) for value in raw["completion_times"]]
        if supplied != times[1:]:
            raise ValueError(f"m={m}: independent completion_times disagree with service sums.")
    margins = []
    for k, row in enumerate(rows):
        if any(not (0 <= value <= 1) for value in row):
            raise ValueError(f"m={m}, k={k}: service outside [0,1].")
        if any(row[i] != 1 for i in range(k)):
            raise ValueError(f"m={m}, k={k}: completed prefix does not have unit service.")
        if k and any(rows[k - 1][i] > row[i] for i in range(m)):
            raise ValueError(f"m={m}, k={k}: cumulative service decreased.")
        F = snapshot_cost(times, k, m)
        margin = R * frozen_optimum(row) - F
        if margin < 0:
            raise ValueError(f"m={m}, k={k}: frozen-instance invariant failed by {-margin}.")
        margins.append(margin)
    return {"m": m, "snapshots": rows, "times": times,
            "cost": sum(times[1:], Fraction(0)), "margins": margins,
            "source": raw.get("source", "Externally supplied; universal existence not checked.")}


def embed_unit_snapshot(profile: dict, n: int, k: int) -> list[Fraction]:
    m = profile["m"]
    prefix = n - m
    local_k = max(0, k - prefix)
    return [Fraction(0)] * prefix + profile["snapshots"][local_k]


def combine_snapshots(prediction: Sequence[Any], raw_profiles: dict, robustness: Any) -> dict:
    if not __debug__:
        raise RuntimeError("Run this certificate checker without Python -O; exact assertions are required.")
    y = [q(value) for value in prediction]
    n = len(y)
    if not n or y[0] <= 0 or y != sorted(y):
        raise ValueError("Prediction must be a nonempty sorted strictly positive vector.")
    R = q(robustness)
    if R < Fraction(2 * n, n + 1):
        raise ValueError("R must be at least the finite-n no-prediction threshold.")
    gaps = [y[i] - (y[i - 1] if i else 0) for i in range(n)]
    profiles = {}
    for start, coefficient in enumerate(gaps):
        if coefficient:
            m = n - start
            raw = raw_profiles.get(str(m), raw_profiles.get(m))
            if raw is None:
                raise ValueError(f"Missing active unit profile m={m}.")
            profiles[m] = validate_unit_profile(m, raw, R)
    rows = []
    component_rows = []
    for k in range(n + 1):
        row = [Fraction(0)] * n
        parts = []
        for start, coefficient in enumerate(gaps):
            if not coefficient:
                continue
            profile = profiles[n - start]
            unscaled = embed_unit_snapshot(profile, n, k)
            scaled = [coefficient * x for x in unscaled]
            row = [a + b for a, b in zip(row, scaled)]
            parts.append({"m": n - start, "coefficient": coefficient,
                          "local_k": max(0, k - start),
                          "profile": profile, "unscaled": unscaled, "scaled": scaled})
        rows.append(row)
        component_rows.append(parts)
    times = [sum(row, Fraction(0)) for row in rows]
    records = []
    for k, row in enumerate(rows):
        if any(not (0 <= row[i] <= y[i]) for i in range(n)):
            raise AssertionError(("service bounds violated", k, row, y))
        if any(row[i] != y[i] for i in range(k)):
            raise AssertionError(("completed prefix differs from prediction", k, row, y))
        if k and any(rows[k - 1][i] > row[i] for i in range(n)):
            raise AssertionError(("service decreased", k))
        F = snapshot_cost(times, k, n)
        phi = frozen_optimum(row)
        weighted_phi = Fraction(0)
        weighted_F = Fraction(0)
        for part in component_rows[k]:
            profile, coefficient = part["profile"], part["coefficient"]
            local_k = part["local_k"]
            weighted_phi += coefficient * frozen_optimum(profile["snapshots"][local_k])
            weighted_F += coefficient * snapshot_cost(profile["times"], local_k, profile["m"])
            assert frozen_optimum(part["scaled"]) == coefficient * frozen_optimum(part["unscaled"])
        assert F == weighted_F, ("snapshot-cost linearity failed", k, F, weighted_F)
        assert phi >= weighted_phi, ("frozen optimum superadditivity failed", k)
        assert weighted_F <= R * weighted_phi
        assert F <= R * phi
        pair_margins = []
        for i in range(n):
            for j in range(i + 1, n):
                weighted_min = sum((min(p["scaled"][i], p["scaled"][j])
                                    for p in component_rows[k]), Fraction(0))
                margin = min(row[i], row[j]) - weighted_min
                assert margin >= 0
                pair_margins.append(margin)
        assert phi - weighted_phi == sum(pair_margins, Fraction(0))
        records.append({"k": k, "elapsed": [str(x) for x in row], "time": str(times[k]),
                        "scheduled_cost": str(F), "frozen_optimum": str(phi),
                        "weighted_component_cost": str(weighted_F),
                        "weighted_component_optimum": str(weighted_phi),
                        "superadditivity_margin": str(phi - weighted_phi),
                        "invariant_margin": str(R * phi - F),
                        "completed_prefix_checked": True, "service_monotone_checked": True})

    # Check every exact pair-order crossing on each linear interpolation phase.
    # On the intervening subintervals both F and Phi are affine, so these points
    # suffice to validate this particular piecewise-linear finite certificate.
    phase_records = []
    for k in range(1, n + 1):
        left, right = rows[k - 1], rows[k]
        delta = [right[i] - left[i] for i in range(n)]
        knots = {Fraction(0), Fraction(1)}
        for i in range(n):
            for j in range(i + 1, n):
                slope = delta[i] - delta[j]
                if slope:
                    s = (left[j] - left[i]) / slope
                    if 0 < s < 1:
                        knots.add(s)
        f_left = snapshot_cost(times, k - 1, n)
        f_right = snapshot_cost(times, k, n)
        assert f_right - f_left == (n - k + 1) * (times[k] - times[k - 1])
        margins = []
        for s in sorted(knots):
            point = [left[i] + s * delta[i] for i in range(n)]
            F = f_left + s * (f_right - f_left)
            margin = R * frozen_optimum(point) - F
            assert margin >= 0, ("phase invariant failed", k, s, margin)
            margins.append({"phase_fraction": str(s), "invariant_margin": str(margin)})
        phase_records.append({"completion_index": k, "duration": str(times[k] - times[k - 1]),
                              "exact_knots_checked": margins})

    total_cost = sum(times[1:], Fraction(0))
    opt = frozen_optimum(y)
    ray_opt = sum((gaps[start] * Fraction((n - start) * (n - start + 1), 2)
                   for start in range(n)), Fraction(0))
    assert opt == ray_opt
    weighted_cost = sum((gaps[n - m] * profile["cost"] for m, profile in profiles.items()), Fraction(0))
    assert total_cost == weighted_cost
    worst_unit_ratio = max(profile["cost"] / Fraction(m * (m + 1), 2)
                           for m, profile in profiles.items())
    assert total_cost / opt <= worst_unit_ratio
    return {
        "schema_version": 1,
        "R": str(R), "prediction": [str(x) for x in y], "gaps": [str(x) for x in gaps],
        "unit_profiles": {str(m): {"source": profile["source"],
                                    "cost": str(profile["cost"]),
                                    "optimum": str(Fraction(m * (m + 1), 2)),
                                    "invariant_margins": [str(x) for x in profile["margins"]]}
                          for m, profile in sorted(profiles.items())},
        "snapshots": records, "phases": phase_records,
        "total_scheduled_cost": str(total_cost), "optimum": str(opt),
        "ratio": str(total_cost / opt), "maximum_active_unit_ratio": str(worst_unit_ratio),
        "valid": True,
        "scope": "Exact finite supplied-profile certificate only. Unit-profile existence, universal optimality, and the prediction-error fallback require separate proofs.",
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input")
    parser.add_argument("--output")
    args = parser.parse_args()
    raw = json.loads(Path(args.input).read_text(encoding="utf-8"))
    result = combine_snapshots(raw["prediction"], raw["profiles"], raw["R"])
    rendered = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        Path(args.output).write_text(rendered, encoding="utf-8")
    else:
        print(rendered, end="")


if __name__ == "__main__":
    main()
