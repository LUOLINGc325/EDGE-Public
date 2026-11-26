#!/usr/bin/env python3
"""Exact finite checks for the manuscript's label-balanced majority identities.

This is research reproduction code, not Lean/formal verification. Exhaustive
label-count profiles check the combinatorial identity; rational p values check
the expectation formulas. The manuscript proves the infinite families.
"""
from fractions import Fraction as F
from math import comb
from pathlib import Path
import argparse
import json


def q(t):
    return 1 if t > 0 else -1


def correction(n, m, positives):
    k = n // m
    low, extra = divmod(positives, k)
    fold_counts = [low + 1] * extra + [low] * (k - extra)
    assert sum(fold_counts) == positives
    assert all(0 <= r <= m for r in fold_counts)
    total = 2 * positives - n
    folds = [2 * r - m for r in fold_counts]
    cv = F(1, 2) - sum(y * q(total - y) for y in folds) * F(1, 2 * n)
    selected_empirical = F(1, 2) - F(q(total) * total, 2 * n)
    actual = cv - selected_empirical
    if m % 2 == 0:
        expected = F(2, n) if total == 2 else F(0)
    else:
        delta = n % 2
        expected = F(k + delta, 2 * n) if total == delta else F(0)
    assert actual == expected, (n, m, positives, actual, expected)
    return cv


def main(output):
    profiles = 0
    mse_checks = 0
    parity_cases = set()
    for n in range(2, 81):
        for m in range(1, n):
            if n % m:
                continue
            k = n // m
            cvs = [correction(n, m, r) for r in range(n + 1)]
            profiles += n + 1
            parity_cases.add((n % 2, m % 2))
            if n > 30:
                continue
            for p in [F(0), F(1, 4), F(1, 2), F(3, 4), F(1)]:
                mu = 2 * p - 1
                probs = [comb(n, r) * p**r * (1 - p)**(n - r) for r in range(n + 1)]
                actual = sum(probs[r] * (cvs[r] - (F(1, 2) - mu * q(2 * r - n) / 2))**2
                             for r in range(n + 1))
                baseline = (1 - mu**2) / (4 * n)
                if m % 2 == 0:
                    expected = baseline + 2 * mu / n * probs[n // 2 + 1]
                else:
                    delta = n % 2
                    a = F(k + delta, 2 * n)
                    expected = baseline + (a*a - F(delta, n)*a + (2*delta-1)*a*mu) * probs[(n + delta)//2]
                assert actual == expected, (n, m, p, actual, expected)
                mse_checks += 1
    result = {
        "status": "passed",
        "arithmetic": "fractions.Fraction; exact equality",
        "maximum_n_profile": 80,
        "maximum_n_mse": 30,
        "label_count_profiles": profiles,
        "rational_mse_checks": mse_checks,
        "attainable_parity_pairs_n_m": sorted(parity_cases),
        "p_values": ["0", "1/4", "1/2", "3/4", "1"],
        "scope": "Equations (9.1)-(9.2), including m=1, ties, and degenerate label laws.",
        "limitation": "Finite exact checks do not prove the asymptotic statements or all-n identities."
    }
    Path(output).write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", default="stratification_exact.json")
    main(parser.parse_args().output)
