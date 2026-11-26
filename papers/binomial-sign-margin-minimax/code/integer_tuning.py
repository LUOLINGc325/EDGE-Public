#!/usr/bin/env python3
"""All-integer degree selection and an exact rational sign-mean estimator.

The supplied integer r must satisfy 2*r-1 > beta for the desired margin class.
No floating-point operation is used in selection, coefficient construction,
estimation, or the finite checks below.
"""
from fractions import Fraction
import hashlib
import json
import math
from pathlib import Path

from localized_upper import normalized_integral_kernel, inverse_bernstein


def choose_odd_m(Q: int, n: int, r: int):
    if any(not isinstance(x, int) or isinstance(x, bool) or x < 1 for x in (Q, n, r)):
        raise ValueError("Q, n and r must be positive integers")
    if n < 256 * r * r:
        return None
    h = min(n, Q.bit_length())
    a = math.isqrt((n * h) // (256 * r * r))
    m = a if a % 2 else a - 1
    assert m >= 1 and m % 2 == 1
    assert 256 * r * r * m * m <= n * h
    assert 256 * r * r * (m + 2) ** 2 > n * h
    assert 9 * 256 * r * r * m * m >= n * h
    assert 4 * r * m <= n - 1
    return m


def estimate_sign_mean(counts, n: int, r: int):
    data = tuple(counts)
    if not data:
        raise ValueError("at least one count is required")
    if any(not isinstance(k, int) or isinstance(k, bool) or not 0 <= k <= n for k in data):
        raise ValueError("counts must be integers between zero and n")
    m = choose_odd_m(len(data), n, r)
    if m is None:
        return Fraction(0)
    _, _, poly = normalized_integral_kernel(m, r)
    coefficients = inverse_bernstein(poly, n)
    value = sum((coefficients[k] for k in data), Fraction(0)) / len(data)
    return max(Fraction(-1), min(Fraction(1), value))


def sign_decision(counts, n: int, r: int):
    value = estimate_sign_mean(counts, n, r)
    return 1 if value >= 0 else -1


def main():
    rows = []
    for r in (2, 3):
        threshold = 256 * r * r
        for n in (1, threshold - 1, threshold, threshold + 1, 4 * threshold):
            for exponent in (0, 1, 16, n):
                Q = 1 << exponent
                m = choose_odd_m(Q, n, r)
                rows.append({
                    "r": r, "n": n, "Q_is_power_of_two_with_exponent": exponent,
                    "Q_bit_length": Q.bit_length(), "odd_m": m,
                    "zero_estimator": m is None,
                    "all_integer_rounding_invariants_passed": True,
                })
    n, r = 1024, 2
    counts = (0, n // 4, n // 2, 3 * n // 4, n)
    estimate = estimate_sign_mean(counts, n, r)
    decision = sign_decision(counts, n, r)
    assert estimate == 0 and decision == 1
    root = Path(__file__).resolve().parents[1]
    payload = {
        "scope": "Exact finite implementation checks; not an all-parameter statistical-risk proof.",
        "arithmetic": "Python arbitrary-precision integers and fractions only",
        "number_of_tuning_cases": len(rows),
        "proof_file": "manuscript/implementation_supplement.md",
        "proof_sha256_at_run": hashlib.sha256((root / "manuscript/implementation_supplement.md").read_bytes()).hexdigest(),
        "tuning_cases": rows,
        "exact_tie_case": {
            "n": n, "r": r, "counts": list(counts),
            "estimate": str(estimate), "decision": decision,
        },
    }
    path = root / "results/integer_tuning.json"
    path.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n")
    print("40 all-integer tuning cases and one exact zero-estimate tie case passed")
    print(path)


if __name__ == "__main__":
    main()

