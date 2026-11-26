#!/usr/bin/env python3
"""Independent exact enumeration of all 65,536 eight-qubit Pauli strings.

No Walsh routine, correlation table or derived certificate is imported. Phases
are integer exponents of i modulo four, so this verifier uses no floating point.
"""
from __future__ import annotations

import argparse
from fractions import Fraction
from itertools import product
import json
from pathlib import Path


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ValueError(message)


def action(word: tuple[int, ...], basis: int) -> tuple[int, int]:
    """I,X,Y,Z have labels 0,1,2,3; return output basis and phase exponent."""
    target = basis
    phase = 0
    for bit, pauli in enumerate(word):
        occupied = (basis >> bit) & 1
        if pauli in (1, 2):
            target ^= 1 << bit
        if pauli == 2:
            phase += 3 if occupied else 1
        if pauli == 3:
            phase += 2 * occupied
    return target, phase % 4


def evaluate(amplitudes: tuple[int, ...]) -> dict:
    local_paulis = [tuple(action(w, x) for x in range(16))
                    for w in product(range(4), repeat=4)]
    total = 0
    nonzero = 0
    examined = 0
    squared_total = 0
    for left in local_paulis:
        for right in local_paulis:
            real = imaginary = 0
            for x in range(16):
                y, pl = left[x]
                z, pr = right[x]
                if y != z:
                    continue
                term = amplitudes[x] * amplitudes[y]
                phase = (pl + pr) % 4
                if phase == 0:
                    real += term
                elif phase == 1:
                    imaginary += term
                elif phase == 2:
                    real -= term
                else:
                    imaginary -= term
            require(imaginary == 0, "Hermitian expectation has imaginary part")
            total += abs(real)
            squared_total += real*real
            nonzero += real != 0
            examined += 1
    q = sum(x*x for x in amplitudes)
    require(examined == 65536, "Incomplete Pauli enumeration")
    require(squared_total == 256*q*q, "Pauli purity normalization failed")
    return {"full_pauli_count": examined, "nonzero_expectations": nonzero,
            "total_absolute_numerator": total, "Q": q,
            "zeta_half": str(Fraction(total, 256*q)),
            "pauli_purity_normalization": True}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    source = (18,17,16,15,14,13,12,11,10,9,8,7,6,5,4,1)
    permuted = (18,17,16,15,14,13,12,11,10,9,8,6,7,5,4,1)
    a, b = evaluate(source), evaluate(permuted)
    require(a["total_absolute_numerator"] == 894720, "Source mismatch")
    require(b["total_absolute_numerator"] == 894656, "Permuted mismatch")
    require(Fraction(b["zeta_half"]) < Fraction(a["zeta_half"]), "No strict reduction")
    out = {"schema": "schmidt-half-full-pauli-v1", "arithmetic": "exact integers and Gaussian phases",
           "source": a, "permuted": b, "status": "passed"}
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(out, indent=2) + "\n", encoding="utf-8")
    print(json.dumps(out, indent=2))


if __name__ == "__main__":
    main()
