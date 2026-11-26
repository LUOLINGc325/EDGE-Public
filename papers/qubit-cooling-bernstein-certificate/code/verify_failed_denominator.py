#!/usr/bin/env python3
"""Exact counterexample to a uniform-denominator relaxation, not to capacity.

The exact identity is

    (1+r)D = r*n_0 + r**L*n_L
             + sum_i r**i*(n_i-r*n_{i+1})**2/(n_i+n_{i+1}).

Since n_i+n_{i+1} <= m, replacing each denominator by m gives a lower
bound D_relaxed <= D.  Asking m*D_relaxed >= S is consequently a sufficient
condition for the desired capacity inequality m*D >= S.  The example here
violates that sufficient condition while strictly satisfying m*D/S > 1.
Every computation and sign comparison uses fractions.Fraction; decimal
rounding is not used.  Only the Python standard library is needed.
"""
from __future__ import annotations

import argparse
from fractions import Fraction
import json
from pathlib import Path


def require(condition: bool, message: str) -> None:
    """Keep certificate checks active even when Python runs with -O."""
    if not condition:
        raise RuntimeError(message)


def verify() -> dict:
    n = [1] * 16 + [2, 3] + [4] * 10 + [3, 2, 1]
    m = sum(n)
    L = len(n) - 1
    r = Fraction(51, 50)
    require(m == 67 and L == 30, "Unexpected composition")
    S = sum(Fraction(a) * r**i for i, a in enumerate(n))
    H = sum(
        Fraction(a * b, a + b) * r**i
        for i, (a, b) in enumerate(zip(n, n[1:]))
    )
    D = S - (1 + r) * H
    boundary = r * n[0] + r**L * n[-1]
    square_terms = [
        r**i * (a - r * b)**2
        for i, (a, b) in enumerate(zip(n, n[1:]))
    ]
    exact_energy = sum(
        value / (a + b)
        for value, (a, b) in zip(square_terms, zip(n, n[1:]))
    )
    require((1 + r) * D == boundary + exact_energy,
            "The exact square identity failed")
    relaxed_D = (boundary + sum(square_terms) / m) / (1 + r)
    require(relaxed_D <= D, "Replacing denominators by m did not lower D")

    T = sum(square_terms) + m * boundary - (1 + r) * S
    expected_T = Fraction(
        -10604338926485104406727426317654093808327350038071,
        58207660913467407226562500000000000000000000000000,
    )
    require(T == expected_T, "The stated exact value of T is incorrect")
    require(T == (1 + r) * (m * relaxed_D - S),
            "T does not represent the stated sufficient condition")
    require(T < 0, "The proposed sufficient condition was not refuted")

    ratio = m * D / S
    lower = Fraction(1672363041530, 10**12)
    upper = Fraction(1672363041531, 10**12)
    require(S > 0 and ratio > 1, "The original capacity target did not hold")
    require(lower < ratio < upper, "The exact ratio enclosure failed")

    return {
        "schema_version": 1,
        "status": "passed",
        "scope": "Counterexample to the uniform-denominator sufficient condition only; the original capacity inequality holds strictly for this example",
        "arithmetic": "Python standard-library fractions.Fraction; exact sign comparisons",
        "m": m,
        "L": L,
        "multiplicities": n,
        "r": str(r),
        "S": str(S),
        "D": str(D),
        "relaxed_D": str(relaxed_D),
        "T": str(T),
        "T_negative": T < 0,
        "target_ratio_mD_over_S": str(ratio),
        "target_ratio_greater_than_one": ratio > 1,
        "target_ratio_strict_lower": str(lower),
        "target_ratio_strict_upper": str(upper),
        "target_ratio_gap_above_one": str(ratio - 1),
        "exact_square_identity_checked": True,
        "relaxed_D_not_greater_than_D_checked": True,
        "T_identity_checked": True,
        "decimal_rounding_used_for_verification": False,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, help="Optional JSON result path")
    args = parser.parse_args()
    result = verify()
    output = json.dumps(result, indent=2) + "\n"
    if args.output is not None:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(output, encoding="utf-8")
        print(json.dumps({
            "status": result["status"],
            "T_negative": result["T_negative"],
            "original_capacity_target_holds_strictly": result["target_ratio_greater_than_one"],
        }))
    else:
        print(output, end="")


if __name__ == "__main__":
    main()
