#!/usr/bin/env python3
"""Finite exact checks for the sharp Bell-chain product coefficient.

Uses only the Python standard library. All arithmetic is rational. The physical
Bell contraction is checked separately by verify_bell_contraction.py; this file
checks the correlation formula, the sharp witnesses, and the support criteria.
Finite checks are not substituted for the universal written or Lean proof.
"""

from __future__ import annotations

import argparse
from fractions import Fraction as Q
from hashlib import sha256
from itertools import product
import json
from math import prod
from pathlib import Path


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ValueError(message)


def encode_q(x: Q) -> str:
    return str(x.numerator) if x.denominator == 1 else f"{x.numerator}/{x.denominator}"


def unit_on_support(d: int, support: tuple[int, ...]) -> tuple[Q, ...]:
    """Positive rational point of the unit sphere with exactly this support."""
    require(bool(support), "Input support must be nonempty.")
    a = [Q(0)] * d
    if len(support) == 1:
        a[support[0]] = Q(1)
        return tuple(a)
    parameters = [Q(j + 2) for j in support[1:]]
    squared = sum(t * t for t in parameters)
    denominator = 1 + squared
    a[support[0]] = (squared - 1) / denominator
    for j, t in zip(support[1:], parameters):
        a[j] = 2 * t / denominator
    require(sum(x * x for x in a) == 1, "Rational parametrization failed.")
    require({j for j, x in enumerate(a) if x} == set(support), "Support changed.")
    return tuple(a)


def profile(a: tuple[Q, ...]) -> dict:
    d = len(a)
    correlations = tuple(sum(a[j] * a[(j + r) % d] for j in range(d))
                         for r in range(d))
    entanglement = sum(a[j] * a[k] for j in range(d) for k in range(d) if j != k)
    support = frozenset(j for j, x in enumerate(a) if x > 0)
    differences = frozenset((k - j) % d for j in support for k in support if j != k)
    require(all(x >= 0 for x in a), "This route takes amplitude moduli.")
    require(sum(x * x for x in a) == 1, "Input is not normalized.")
    require(entanglement == sum(correlations[1:]), "Displacement sum failed.")
    require(all(correlations[r] == correlations[(-r) % d] for r in range(d)),
            "Inversion symmetry failed.")
    require(differences == frozenset(r for r in range(1, d) if correlations[r] > 0),
            "Correlation positivity differs from actual support differences.")
    return {"amplitudes": a, "correlations": correlations,
            "entanglement": entanglement, "differences": differences}


def coefficient(d: int, m: int) -> Q:
    return Q(1) if d % 2 == 0 else Q(1, 2 ** (m - 1))


def correlation_average(profiles: tuple[dict, ...]) -> Q:
    d = len(profiles[0]["amplitudes"])
    return sum(prod(p["correlations"][r] for p in profiles) for r in range(1, d))


def support_equality_prediction(d: int, profiles: tuple[dict, ...]) -> bool:
    if any(p["entanglement"] == 0 for p in profiles):
        return True
    if d % 2 == 0:
        return all(p["differences"] == frozenset({d // 2}) for p in profiles)
    return any(all(p["differences"] == frozenset({r, (-r) % d}) for p in profiles)
               for r in range(1, d))


def check_family(d: int, profiles: tuple[dict, ...]) -> tuple[bool, bool]:
    m = len(profiles)
    value = correlation_average(profiles)
    bound = coefficient(d, m) * prod(p["entanglement"] for p in profiles)
    equality = value == bound
    zero = value == 0
    common = set(range(1, d))
    for p in profiles:
        common.intersection_update(p["differences"])
    require(value <= bound, f"Upper bound failed at d={d},m={m}.")
    require(equality == support_equality_prediction(d, profiles),
            f"Equality iff failed at d={d},m={m}.")
    require(zero == (not common), f"Zero iff failed at d={d},m={m}.")
    return equality, zero


def run() -> dict:
    report = {
        "arithmetic": "Python fractions.Fraction; no floating-point comparisons",
        "claim_scope": "Finite verification only; universal theorem requires the proof.",
        "script_sha256": sha256(Path(__file__).read_bytes()).hexdigest(),
        "families": [],
        "sharp_witnesses": [],
    }
    totals = {"normalized_profiles": 0, "input_families": 0,
              "upper_bound_checks": 0, "equality_iff_checks": 0,
              "zero_iff_checks": 0, "equality_cases": 0, "zero_cases": 0}
    cached = {}
    for d in range(2, 8):
        entries = []
        for mask in range(1, 2 ** d):
            support = tuple(j for j in range(d) if (mask >> j) & 1)
            entries.append(profile(unit_on_support(d, support)))
        cached[d] = entries
        totals["normalized_profiles"] += len(entries)
    scopes = [(d, 2) for d in range(2, 8)] + [(d, 3) for d in (3, 4, 5)]
    for d, m in scopes:
        count = equalities = zeros = 0
        for ps in product(cached[d], repeat=m):
            equal, zero = check_family(d, ps)
            count += 1
            equalities += int(equal)
            zeros += int(zero)
        report["families"].append({
            "dimension": d, "links": m, "support_patterns_per_link": len(cached[d]),
            "input_families": count, "equality_cases": equalities, "zero_cases": zeros,
            "weights": "one positive normalized rational vector for every nonempty support",
        })
        totals["input_families"] += count
        totals["upper_bound_checks"] += count
        totals["equality_iff_checks"] += count
        totals["zero_iff_checks"] += count
        totals["equality_cases"] += equalities
        totals["zero_cases"] += zeros
    for d in range(2, 17):
        h = d // 2 if d % 2 == 0 else 1
        a = [Q(0)] * d
        a[0], a[h] = Q(3, 5), Q(4, 5)
        p = profile(tuple(a))
        for m in range(2, 9):
            ps = (p,) * m
            check_family(d, ps)
            value = correlation_average(ps)
            expected = coefficient(d, m) * Q(24, 25) ** m
            require(value == expected, "Explicit sharp witness value failed.")
            report["sharp_witnesses"].append({
                "dimension": d, "links": m, "support": [0, h],
                "amplitudes": ["3/5", "4/5"],
                "input_entanglement": "24/25",
                "output_average": encode_q(value),
                "ratio": encode_q(coefficient(d, m)),
            })
    a = [Q(3, 5), Q(4, 5), Q(0), Q(0), Q(0)]
    b = [Q(3, 5), Q(0), Q(4, 5), Q(0), Q(0)]
    za, zb = profile(tuple(a)), profile(tuple(b))
    require(correlation_average((za, zb)) == 0, "Nontrivial zero example failed.")
    report["nontrivial_zero_example"] = {
        "dimension": 5, "links": 2,
        "support_differences": [[1, 4], [2, 3]],
        "input_entanglements": ["24/25", "24/25"], "output_average": "0",
    }
    report["totals"] = totals
    report["totals"]["sharp_witness_checks"] = len(report["sharp_witnesses"])
    report["status"] = "PASS"
    return report


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] /
                        "results" / "exact_certificate.json")
    args = parser.parse_args()
    report = run()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n")
    print(json.dumps({"status": report["status"], **report["totals"]}, sort_keys=True))


if __name__ == "__main__":
    main()
