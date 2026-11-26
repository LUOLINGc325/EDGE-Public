#!/usr/bin/env python3
"""Certify finite-dimensional qubit shell capacity with exact integers.

For each requested machine dimension m, this program minimizes every
degree-(m-1) Bernstein coefficient of

    G_n(t) = (1 - 1/m) * sum_i n_i*t**i
             - (1+t) * sum_i n_i*n_{i+1}/(n_i+n_{i+1}) * t**i

over ALL positive integer compositions n of m.  Nonnegative minima imply
G_n(t) >= 0 for every composition in the requested finite dimension range
and every 0 <= t <= 1.  This is a finite certificate, not an assertion about
unbounded m.  In particular, the default upper limit 64 is an output range,
not a constant used by the recurrence or a claimed analytic cutoff.

The coefficient with index k has weights
W_i = binom(k,i)/binom(m-1,i), with W_i=0 for i>k.  Only the first k+1
layers and their final outgoing edge can contribute.  Any later tail may
be merged into one layer: its vertex costs are zero and increasing that
last multiplicity only decreases the objective.  Equivalently, the
dynamic program has zero cost for every tail starting after index k.

State (i,s,a) means: index i, remaining total multiplicity s, first
multiplicity a.  It minimizes the exact objective over every positive
integer tail with those data.  If s>a, conditioning on its second
multiplicity b gives the recurrence in minimum_coefficient().

All comparisons and minimizations use Python integers.  We multiply the
objective by m*lcm(1,...,m)*(m-1)!; the scaled weight is the integer
(k)_i*(m-1-i)!, and each harmonic-mean denominator a+b divides the lcm.
Fractions are used only to report a reduced result and independently
evaluate the returned minimizing composition.  Decimal output is for
readability and is never used in verification.

Usage:
    python exact_certificate.py --max-m 8 --output shell-small.json
    python exact_certificate.py --max-m 64 --output results/exact_certificate.json
    python exact_certificate.py --min-m 19 --max-m 24 --output shell-range.json

For fixed m, all coefficients require O(m^5) integer arithmetic operations;
checking every dimension through M requires O(M^6).  The retained witness
backtracking tables use O(m^3) integers.  Value arrays alone use O(m^2).
"""
from __future__ import annotations

import argparse
from fractions import Fraction
import json
from math import comb, factorial, lcm
from pathlib import Path
from typing import Any


def coefficient_counts(m: int, k: int) -> tuple[int, int]:
    """Return computed state and candidate-transition counts for (m,k)."""
    states = comb(m + 2, 3) - comb(m - k + 1, 3)
    transitions = comb(m + 2, 4) - comb(m - k + 1, 4)
    return states, transitions


def direct_coefficient(m: int, k: int, composition: list[int]) -> Fraction:
    """Evaluate a witness by the original coefficient formula, not the DP."""
    if (not composition or any(type(a) is not int or a <= 0 for a in composition)
            or sum(composition) != m):
        raise ValueError("A witness must be a positive integer composition of m")
    d = m - 1
    weights = [
        Fraction(comb(k, i), comb(d, i)) if i <= k else Fraction(0)
        for i in range(len(composition) + 1)
    ]
    value = Fraction(m - 1, m) * sum(
        a * weights[i] for i, a in enumerate(composition)
    )
    value -= sum(
        Fraction(a * b, a + b) * (weights[i] + weights[i + 1])
        for i, (a, b) in enumerate(zip(composition, composition[1:]))
    )
    return value


def minimum_coefficient(m: int, k: int) -> dict[str, Any]:
    """Return the exact global minimum of B_k over all compositions of m.

    With c=(m-1)/m, the unscaled recurrence is

      V_i(a,a) = c*W_i*a,
      V_i(s,a) = c*W_i*a + min_{1<=b<=s-a}
          [-(W_i+W_{i+1})*a*b/(a+b) + V_{i+1}(s-a,b)].

    Beyond i=k all costs vanish.  Each evaluated transition has a+b<=m,
    ensuring that the lcm-scaled harmonic mean is an integer.  The exact
    minimum is min_a V_0(m,a).  Ties are resolved by the smallest a or b.
    """
    if type(m) is not int or type(k) is not int or m < 2 or not 0 <= k < m:
        raise ValueError("Need integers m>=2 and 0<=k<=m-1")
    d = m - 1
    common = lcm(*range(1, m + 1))
    scale = m * common * factorial(d)
    weights: list[int] = []
    falling = 1
    for i in range(k + 1):
        if i:
            falling *= k - i + 1
        weights.append(falling * factorial(d - i))
    weights.append(0)

    # Every positive tail beyond index k has zero objective.  This boundary
    # permits arbitrary tail length; merging it yields the stored witness.
    next_values: list[list[int | None]] = [[None] * (m + 1) for _ in range(m + 1)]
    for s in range(1, m + 1):
        for a in range(1, s + 1):
            next_values[s][a] = 0
    backtracking: list[list[list[int]]] = []
    state_count = 0
    transition_count = 0

    for i in range(k, -1, -1):
        current: list[list[int | None]] = [[None] * (m + 1) for _ in range(m + 1)]
        choice = [[0] * (m + 1) for _ in range(m + 1)]
        vertex_weight = (m - 1) * common * weights[i]
        edge_weight = m * (weights[i] + weights[i + 1])
        # At least i positive multiplicities precede this state.
        for s in range(1, m - i + 1):
            current[s][s] = vertex_weight * s
            state_count += 1
            for a in range(1, s):
                best: int | None = None
                best_b = 0
                for b in range(1, s - a + 1):
                    tail = next_values[s - a][b]
                    if tail is None:
                        raise RuntimeError("Invalid dynamic-program dependency")
                    value = (
                        -edge_weight * a * b * (common // (a + b))
                        + tail
                    )
                    transition_count += 1
                    if best is None or value < best:
                        best, best_b = value, b
                if best is None:
                    raise RuntimeError("A nonterminal state has no successor")
                current[s][a] = vertex_weight * a + best
                choice[s][a] = best_b
                state_count += 1
        next_values = current
        backtracking.append(choice)

    first = min(range(1, m + 1), key=lambda a: next_values[m][a])
    raw = next_values[m][first]
    if raw is None:
        raise RuntimeError("Missing root state")
    composition: list[int] = []
    s, a = m, first
    for choice in reversed(backtracking):
        composition.append(a)
        b = choice[s][a]
        s -= a
        a = b
        if not s:
            break
    if s:
        composition.append(s)

    result = Fraction(raw, scale)
    if direct_coefficient(m, k, composition) != result:
        raise RuntimeError("The independently evaluated witness disagrees")
    if (state_count, transition_count) != coefficient_counts(m, k):
        raise RuntimeError("State or transition count disagrees with its identity")
    return {
        "m": m,
        "k": k,
        "minimum": str(result),
        "decimal": float(result),
        "nonnegative": result >= 0,
        "minimizer": composition,
        "states": state_count,
        "transitions": transition_count,
    }


def assemble_certificate(minimum_m: int, maximum_m: int,
                         results: list[dict[str, Any]]) -> dict[str, Any]:
    """Validate a complete result table and attach finite-scope metadata.

    This also permits the previously generated exact table to be reused
    without repeating its expensive DP run.  It verifies all indices,
    witnesses, signs and count identities, but witness verification alone
    is not a fresh proof of global minimality; that fact comes from the DP.
    """
    expected = [(m, k) for m in range(minimum_m, maximum_m + 1) for k in range(m)]
    if [(row["m"], row["k"]) for row in results] != expected:
        raise ValueError("The table does not contain exactly the requested coefficients")
    for row in results:
        m, k = row["m"], row["k"]
        value = Fraction(row["minimum"])
        states, transitions = coefficient_counts(m, k)
        if row.get("states", states) != states or row["transitions"] != transitions:
            raise ValueError("Incorrect count in an existing result row")
        if direct_coefficient(m, k, row["minimizer"]) != value:
            raise ValueError("Incorrect witness in an existing result row")
        if row["nonnegative"] != (value >= 0):
            raise ValueError("Incorrect exact sign in an existing result row")
        row["states"] = states
    return {
        "schema_version": 1,
        "arithmetic": "exact_integer",
        "minimum_m": minimum_m,
        "maximum_m": maximum_m,
        "all_passed": all(row["nonnegative"] for row in results),
        "coefficient_count": len(results),
        "states": sum(row["states"] for row in results),
        "transitions": sum(row["transitions"] for row in results),
        "scope": "All positive integer compositions in the listed finite dimension range; every t in [0,1] via Bernstein coefficients",
        "unbounded_dimension_claim": False,
        "decimal_fields_used_for_verification": False,
        "results": results,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--min-m", type=int, default=2, help="First machine dimension (default: 2)")
    parser.add_argument("--max-m", type=int, default=64, help="Last machine dimension (default: 64)")
    parser.add_argument("--output", type=Path, required=True, help="Destination JSON certificate")
    args = parser.parse_args()
    if args.min_m < 2 or args.max_m < args.min_m:
        parser.error("Require 2 <= --min-m <= --max-m")
    results = []
    for m in range(args.min_m, args.max_m + 1):
        rows = [minimum_coefficient(m, k) for k in range(m)]
        results.extend(rows)
        print(json.dumps({
            "m": m,
            "all_passed": all(row["nonnegative"] for row in rows),
            "coefficients": len(rows),
            "states": sum(row["states"] for row in rows),
            "transitions": sum(row["transitions"] for row in rows),
        }), flush=True)
    certificate = assemble_certificate(args.min_m, args.max_m, results)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(certificate, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({
        key: certificate[key] for key in (
            "minimum_m", "maximum_m", "all_passed", "coefficient_count", "states", "transitions"
        )
    }), flush=True)
    return 0 if certificate["all_passed"] else 2


if __name__ == "__main__":
    raise SystemExit(main())
