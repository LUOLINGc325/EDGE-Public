#!/usr/bin/env python3
"""Verify finite event-query LP witnesses using only exact standard-library arithmetic.

This verifier does not import the discovery program, SciPy or SymPy. It rebuilds
the hypergeometric experiment and checks a feasible output rule against the
signed-event dual bound. Equality proves the optimum for the stated finite
problem; it does not prove a full-distribution Gibbs sampling upper bound.
"""
from fractions import Fraction
from math import comb
from pathlib import Path
import argparse
import hashlib
import json


def verify(record):
    M, n = record["M"], record["n"]
    t, v = Fraction(record["t"]), Fraction(record["volume"])
    a = list(map(Fraction, record["leaf_event_probabilities"]))
    y = list(map(Fraction, record["signed_event_dual"]))
    error = Fraction(record["optimal_event_error"])
    assert 0 <= n < M and t > 0 and 0 < v <= 1
    assert len(a) == n + 1 and len(y) == M + 1
    assert all(0 <= z <= 1 for z in a) and error >= 0
    assert sum(map(abs, y), Fraction(0)) <= 1
    transpose_y = [Fraction(0)] * (n + 1)
    primal_error = Fraction(0)
    dual_value = Fraction(0)
    for k in range(M + 1):
        h = [Fraction(0)] * (n + 1)
        # An n-subset contains j of the k marked coordinates.
        for j in range(max(0, n - (M - k)), min(n, k) + 1):
            h[j] = Fraction(comb(k, j) * comb(M - k, n - j), comb(M, n))
        assert sum(h, Fraction(0)) == 1
        target = v / (1 + t * k)
        produced = sum((h[j] * a[j] for j in range(n + 1)), Fraction(0))
        primal_error = max(primal_error, abs(produced - target))
        dual_value += target * y[k]
        for j in range(n + 1):
            transpose_y[j] += h[j] * y[k]
    dual_value -= sum((max(z, Fraction(0)) for z in transpose_y), Fraction(0))
    assert primal_error <= error
    assert dual_value == error
    assert primal_error == error
    return {"M": M, "n": n, "t": str(t), "error": str(error),
            "status": "exact_primal_dual_equality"}


def main():
    root = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("input", type=Path, nargs="?",
                        default=root / "results/finite_event_lp_certificates.json")
    parser.add_argument("--output", type=Path,
                        default=root / "results/finite_event_lp_independent_verification.json")
    args = parser.parse_args()
    raw = args.input.read_bytes()
    data = json.loads(raw)
    checks = [verify(record) for record in data["cases"]]
    result = {"status": "passed", "verified_cases": len(checks),
              "input_name": args.input.name, "input_sha256": hashlib.sha256(raw).hexdigest(),
              "arithmetic": "fractions.Fraction; no floating point or optimization solver",
              "scope": "finite Boolean-query single-event minimax only",
              "cases": checks}
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({k: v for k, v in result.items() if k != "cases"}))


if __name__ == "__main__":
    main()
