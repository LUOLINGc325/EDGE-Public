#!/usr/bin/env python3
"""Independent finite-case checks of the radial occupation/resolvent identity.

This program checks two independently evaluated sides of A_t = K F_t in
dimensions 1 and 3, and K q_lambda = (1-q_lambda)/lambda in dimensions
2, 4, 5 and 8.  It does not certify the continuum theorem, global optimality,
or uniqueness of a resetting law.

Run from any directory:
    python3 code/radial_resolvent_check.py

The test cases, precision and tolerance below are fixed before execution.
Only mpmath is required in addition to the Python standard library.
"""

from __future__ import annotations

import argparse
from datetime import datetime, timezone
import hashlib
import json
from pathlib import Path
import platform
import sys

import mpmath as mp


DIGITS = 40
ABSOLUTE_TOLERANCE = "1e-32"
DIFFUSIVITY = "1.3"
TARGET_RADIUS = "0.7"
DIRECT_CASES = (("0.9", "0.05"), ("2.1", "0.7"), ("5.0", "3.0"))
RESOLVENT_DIMENSIONS = (2, 4, 5, 8)
RESOLVENT_POSITION = "2.1"
RESOLVENT_RATE = "0.8"


def decimal(value: mp.mpf) -> str:
    return mp.nstr(value, n=DIGITS)


def kernel(r: mp.mpf, s: mp.mpf, d: int, a: mp.mpf, D: mp.mpf) -> mp.mpf:
    inner = min(r, s)
    if d == 1:
        return (inner - a) / D
    if d == 2:
        return mp.log(inner / a) / D
    return (a ** (2 - d) - inner ** (2 - d)) / (D * (d - 2))


def check_result(label: str, left: mp.mpf, right: mp.mpf, **inputs: object) -> dict:
    error = abs(left - right)
    passed = bool(mp.isfinite(left) and mp.isfinite(right) and error <= mp.mpf(ABSOLUTE_TOLERANCE))
    return {
        "label": label,
        "inputs": inputs,
        "left": decimal(left),
        "right": decimal(right),
        "absolute_error": decimal(error),
        "absolute_tolerance": ABSOLUTE_TOLERANCE,
        "passed": passed,
    }


def direct_occupation_checks(D: mp.mpf, a: mp.mpf) -> list[dict]:
    rows = []
    for d in (1, 3):
        for position_text, time_text in DIRECT_CASES:
            r, t = mp.mpf(position_text), mp.mpf(time_text)

            def hit_probability(s: mp.mpf, u: mp.mpf) -> mp.mpf:
                if u == 0:
                    return mp.mpf(0)
                factor = mp.mpf(1) if d == 1 else a / s
                return factor * mp.erfc((s - a) / mp.sqrt(4 * D * u))

            # Integrate the explicit survival probability in time. This side
            # does not call the spatial kernel or use the resolvent identity.
            occupation = t - mp.quad(lambda u: hit_probability(r, u), [0, t])
            # Independently integrate the finite-time hit probability in space.
            potential = mp.quad(
                lambda s: kernel(r, s, d, a, D) * hit_probability(s, t) * s ** (d - 1),
                [a, r, mp.inf],
            )
            rows.append(check_result(
                "finite_time_occupation",
                occupation,
                potential,
                dimension=d,
                target_radius=TARGET_RADIUS,
                diffusivity=DIFFUSIVITY,
                position=position_text,
                time=time_text,
            ))
    return rows


def bessel_resolvent_checks(D: mp.mpf, a: mp.mpf) -> list[dict]:
    rows = []
    r, rate = mp.mpf(RESOLVENT_POSITION), mp.mpf(RESOLVENT_RATE)
    beta = mp.sqrt(rate / D)
    for d in RESOLVENT_DIMENSIONS:
        order = 1 - mp.mpf(d) / 2
        denominator = mp.besselk(order, a * beta)

        def q(s: mp.mpf) -> mp.mpf:
            return (s / a) ** order * mp.besselk(order, s * beta) / denominator

        closed_expression = (1 - q(r)) / rate
        kernel_integral = mp.quad(
            lambda s: kernel(r, s, d, a, D) * q(s) * s ** (d - 1),
            [a, r, mp.inf],
        )
        rows.append(check_result(
            "bessel_resolvent",
            closed_expression,
            kernel_integral,
            dimension=d,
            target_radius=TARGET_RADIUS,
            diffusivity=DIFFUSIVITY,
            position=RESOLVENT_POSITION,
            laplace_parameter=RESOLVENT_RATE,
        ))
    return rows


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    default_path = Path(__file__).resolve().parents[1] / "results" / "radial_resolvent_check.json"
    parser.add_argument("--output", type=Path, default=default_path)
    args = parser.parse_args()
    mp.mp.dps = DIGITS
    started = datetime.now(timezone.utc).isoformat(timespec="seconds")
    D, a = mp.mpf(DIFFUSIVITY), mp.mpf(TARGET_RADIUS)
    rows = direct_occupation_checks(D, a) + bessel_resolvent_checks(D, a)
    passed = all(row["passed"] for row in rows)
    report = {
        "schema_version": 1,
        "started_at_utc": started,
        "completed_at_utc": datetime.now(timezone.utc).isoformat(timespec="seconds"),
        "status": "passed_finite_cases" if passed else "failed",
        "scope": "Finite numerical checks of radial occupation and Laplace-resolvent identities only",
        "not_certified": [
            "The continuum analytic identity for every parameter",
            "Global optimality among all renewal laws",
            "Identification or uniqueness of all resetting laws",
            "Interval-arithmetic error bounds",
        ],
        "design": {
            "precision_decimal_digits": DIGITS,
            "criterion": "All independently evaluated pairs are finite and have absolute difference <= tolerance",
            "absolute_tolerance": ABSOLUTE_TOLERANCE,
            "case_count": len(rows),
            "parameters_fixed_before_execution": True,
        },
        "environment": {
            "python": platform.python_version(),
            "mpmath": mp.__version__,
            "platform": platform.platform(),
        },
        "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "results": rows,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(json.dumps({
        "status": report["status"],
        "case_count": len(rows),
        "maximum_absolute_error": decimal(max(mp.mpf(row["absolute_error"]) for row in rows)),
        "output": str(args.output),
    }, ensure_ascii=False))
    return 0 if passed else 1


if __name__ == "__main__":
    sys.exit(main())
