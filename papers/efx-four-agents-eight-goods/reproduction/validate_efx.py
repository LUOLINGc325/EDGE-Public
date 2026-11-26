#!/usr/bin/env python3
"""Independent exact EFX validator; no SAT solver or floating arithmetic.

Input JSON: n, m, valuations[n][2**m]. Values may be integers or rational
strings, but never JSON floating-point values. Every complete labeled
allocation, including allocations with empty bundles, is checked.
"""
from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import math
from collections import Counter
from fractions import Fraction
from pathlib import Path


def exact_value(x):
    if isinstance(x, bool) or isinstance(x, float):
        raise ValueError("Use integers or rational strings, never floats/bools")
    if isinstance(x, (int, str)):
        return Fraction(x)
    raise ValueError(f"Unsupported value: {type(x)}")


def validate(data, keep_examples=5):
    n, m = int(data["n"]), int(data["m"])
    table = data.get("valuations", data.get("values"))
    if n < 1 or m < 0 or len(table) != n:
        raise ValueError("Invalid dimensions")
    v = [[exact_value(x) for x in row] for row in table]
    if any(len(row) != 1 << m for row in v):
        raise ValueError("Each valuation must contain exactly 2**m entries")
    for i, row in enumerate(v):
        if row[0] != 0 or any(x < 0 for x in row):
            raise ValueError(f"Agent {i}: not normalized/nonnegative")
        for mask in range(1 << m):
            for g in range(m):
                larger = mask | (1 << g)
                if row[mask] > row[larger]:
                    raise ValueError(f"Agent {i}: monotonicity fails {mask}->{larger}")
    removal = [[Fraction(0) for _ in range(1 << m)] for _ in range(n)]
    for i in range(n):
        for mask in range(1, 1 << m):
            removal[i][mask] = max(v[i][mask ^ (1 << g)]
                                   for g in range(m) if mask & (1 << g))
    count = 0
    tested = 0
    by_shape = Counter()
    examples = []
    for owners in itertools.product(range(n), repeat=m):
        bundles = [0] * n
        for g, i in enumerate(owners):
            bundles[i] |= 1 << g
        tested += 1
        # Including the own bundle in the maximum is sound by monotonicity.
        if all(v[i][bundles[i]] >= max(removal[i][b] for b in bundles)
               for i in range(n)):
            count += 1
            shape = tuple(sorted(b.bit_count() for b in bundles))
            by_shape[",".join(map(str, shape))] += 1
            if len(examples) < keep_examples:
                examples.append({"bundle_masks": bundles,
                                 "bundles": [[g for g in range(m) if b & (1 << g)]
                                             for b in bundles]})
    return {"n": n, "m": m, "normalization": True, "monotonicity": True,
            "allocations_checked": tested, "expected_allocations": n**m,
            "efx_count": count, "efx_by_shape": dict(sorted(by_shape.items())),
            "examples": examples, "arithmetic": "exact rational",
            "includes_empty_bundles": True,
            "conclusion": "counterexample_verified" if count == 0 else "EFX_exists_for_this_profile"}


def main():
    p = argparse.ArgumentParser(description=__doc__)
    p.add_argument("instance", type=Path)
    p.add_argument("--output", type=Path)
    args = p.parse_args()
    input_bytes = args.instance.read_bytes()
    result = validate(json.loads(input_bytes))
    result["input"] = args.instance.name
    result["input_sha256"] = hashlib.sha256(input_bytes).hexdigest()
    text = json.dumps(result, indent=2, ensure_ascii=False)
    if args.output:
        args.output.write_text(text + "\n")
    print(text)


if __name__ == "__main__":
    main()
