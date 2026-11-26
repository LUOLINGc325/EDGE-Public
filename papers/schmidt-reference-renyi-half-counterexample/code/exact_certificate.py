#!/usr/bin/env python3
"""Rebuild the complete integer Walsh certificate with Python's standard library.

This is an exact finite computation, not the formal proof of the quantum bridge.
Run with -O as well: all checks remain active because no assert statement is used.
"""
from __future__ import annotations

import argparse
from fractions import Fraction
import json
from pathlib import Path


AMPLITUDES = tuple(range(18, 3, -1)) + (1,)
PERMUTATION = tuple(12 if j == 11 else 11 if j == 12 else j for j in range(16))


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ValueError(message)


def correlation_table(amplitudes: tuple[int, ...]) -> list[list[int]]:
    return [
        [sum(amplitudes[x] * amplitudes[x ^ s] *
             (-1 if (k & x).bit_count() % 2 else 1)
             for x in range(16)) for k in range(16)]
        for s in range(16)
    ]


def build() -> dict:
    a = AMPLITUDES
    p = PERMUTATION
    b = tuple(a[p[j]] for j in range(16))
    require(sorted(p) == list(range(16)), "Not a permutation")
    require(all(p[p[j]] == j for j in range(16)), "Permutation is not involutive")
    require(all(x > 0 for x in a), "Amplitude is not strictly positive")
    require(all(a[j] > a[j + 1] for j in range(15)), "Not strictly decreasing")
    q = sum(x*x for x in a)
    require(q == 2096 == sum(x*x for x in b), "Squared norm mismatch")
    rows = {}
    for label, v, expected in (("source", a, 55920), ("permuted", b, 55916)):
        table = correlation_table(v)
        row_sums = [sum(abs(h) for h in row) for row in table]
        total = sum(row_sums)
        require(total == expected, f"{label}: incorrect exact L1 total")
        require(sum(h*h for row in table for h in row) == 16*q*q,
                f"{label}: Parseval normalization failed")
        require(all(table[s][k] == 0 for s in range(16) for k in range(16)
                    if (s & k).bit_count() % 2), f"{label}: Pauli parity failed")
        rows[label] = {"amplitudes": v, "walsh_table": table,
                       "per_shift_absolute_sum": row_sums, "absolute_sum": total,
                       "zeta_half": str(Fraction(total, 16*q))}
    require(rows["source"]["absolute_sum"] - rows["permuted"]["absolute_sum"] == 4,
            "The strict gap was lost")
    return {"schema": "schmidt-half-exact-v1", "arithmetic": "arbitrary-precision integers",
            "local_dimension": 16, "total_qubits": 8, "Q": q,
            "permutation": p, "states": rows,
            "zeta_ratio_source_to_permuted": str(Fraction(55920, 55916)),
            "entropy_drop_exact": "2 * log_2(13980/13979)",
            "checks": {"normalization": True, "positive_strict_spectrum": True,
                       "permutation": True, "parseval": True, "pauli_parity": True,
                       "strict_gap": True}}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    payload = build()
    rendered = json.dumps(payload, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered, encoding="utf-8")
    print(json.dumps({"status": "passed", "Q": payload["Q"],
                      "source_L1": 55920, "permuted_L1": 55916,
                      "exact_entropy_drop": payload["entropy_drop_exact"]}))


if __name__ == "__main__":
    main()
