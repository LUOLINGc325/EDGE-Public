"""Exact finite checks supporting the manuscript; no asymptotic claim is inferred.

Run from any directory. Only the Python standard library is required.
"""
from fractions import Fraction as Q
from itertools import product
from math import comb
from pathlib import Path
import argparse
import json


def run():
    derivative_checks = 0
    for n in range(1, 101):
        N = n + 1
        for k in range(1, N):
            assert Q(n * comb(n - 1, k - 1), k * (N - k)) == Q(comb(N, k), N)
            derivative_checks += 1
    deletion_checks = 0
    for n in range(1, 8):
        N = n + 1
        t = [Q(k * k - 2 * k, n * n + 1) for k in range(N)]
        for bits in product((0, 1), repeat=N):
            k = sum(bits)
            outputs = [t[k - z] for z in bits]
            for s in (1, 2, 3):
                lhs = sum(abs(x - y) ** s for x in outputs for y in outputs) / N ** 2
                rhs = (Q(2 * k * (N - k), N ** 2) * abs(t[k] - t[k - 1]) ** s
                       if 0 < k < N else Q(0))
                assert lhs == rhs
                deletion_checks += 1
    beta = Q(1, 7)
    bits = (0, 1, 0, 1, 0)
    def ordered_estimator(v):
        return beta * (v[0] - v[1] + v[2] - v[3])
    outputs = [ordered_estimator(bits[:i] + bits[i + 1:]) for i in range(5)]
    avg = sum(abs(x - y) for x in outputs for y in outputs) / 25
    assert outputs == [2 * beta, beta, 0, -beta, -2 * beta]
    assert avg == Q(8, 5) * beta
    return {
        "status": "passed",
        "arithmetic": "exact Python Fraction and integer binomial coefficients",
        "bernstein_coefficient_identities": derivative_checks,
        "exhaustive_deletion_power_identities": deletion_checks,
        "order_dependent_non_nesting_example": {
            "n": 4, "beta": str(beta), "worst_replacement": str(beta),
            "average_deletion": str(avg), "ratio": "8/5"
        },
        "scope": "Finite exact consistency checks, supplementary to the written proofs; no Lean execution."
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results" / "identity_checks.json")
    args = parser.parse_args()
    result = run()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(result, indent=2))
