#!/usr/bin/env python3
"""Physical all-to-all optimal-shadow circuits with 3*k-6 CNOTs, odd k>=5.

The all-k claim uses the character-sum identity proved in
../theory/complete_resource.md, not numerical extrapolation.  The conversion
of a compact transvection word to physical H/S/CNOT gates reuses the
previously audited case code.  Every output circuit is replayed exactly.
"""
from __future__ import annotations

import argparse
import json
from pathlib import Path
import sys

CASE = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(CASE / "code"))
from new_path_family import (  # noqa: E402
    coefficients, expected_inflated_rows, invert, local_gates, remap, replay,
    transvection_word_gates,
)
from new_verify_resource_witnesses import pairing, score  # noqa: E402


SEED_WORD = [
    [3, 4, 2, 2], [0, 1, 2, 3], [0, 2, 3, 1],
    [2, 4, 3, 1], [1, 2, 2, 1], [2, 3, 3, 1],
    [0, 3, 2, 2], [0, 1, 3, 3], [3, 4, 3, 3],
]
SEED_ROWS = (427, 1021, 442, 613, 430, 601, 341, 767, 490, 661)
SEED_COEFFICIENTS = [1875, 81, -6]


def seed():
    literal = transvection_word_gates(SEED_WORD, 5)
    # A simultaneous physical relabelling changes no allowed complete edge.
    literal = remap(literal, {0: 2, 1: 1, 2: 0, 3: 3, 4: 4})
    literal += local_gates(0, (1, 3))
    assert replay(literal, 5) == SEED_ROWS
    assert sum(g["gate"] == "CNOT" for g in literal) == 9
    return literal


def encoder_three():
    gates = [
        {"gate": "CNOT", "control": 0, "target": 1},
        {"gate": "CNOT", "control": 2, "target": 0},
        {"gate": "CNOT", "control": 1, "target": 2},
    ]
    actual = replay(gates, 3)
    assert actual == (17, 10, 5, 34, 21, 42)
    assert [(actual[2*i] & 3, actual[2*i+1] & 3) for i in range(3)] == [(1, 2)]*3
    return gates


def balanced_encoder(sites):
    """Map the local plane at sites[0] to the repeated plane on odd sites.

    Returns an actual CNOT list.  The first three gates distribute the root
    plane to three group representatives; disjoint recursive circuits then
    spread it within the groups. The number of gates is 3*(len(sites)-1)/2.
    """
    r = len(sites)
    if r == 1:
        return []
    assert r >= 3 and r % 2 == 1
    # Balanced odd positive part sizes, whose sum is r.
    half = (r-3)//2
    halves = [half//3 + (i < half % 3) for i in range(3)]
    sizes = [2*h+1 for h in halves]
    groups, offset = [], 0
    for size in sizes:
        groups.append(sites[offset:offset+size])
        offset += size
    root = remap(encoder_three(), {i: groups[i][0] for i in range(3)})
    for group in groups:
        root += balanced_encoder(group)
    return root


def entangling_depth(gates, k):
    # Single-qubit Clifford gates are free in this resource model. The
    # earliest-layer schedule respects the order of every gate on its wire.
    last = [0]*k
    for g in gates:
        if g["gate"] == "CNOT":
            a, b = g["control"], g["target"]
            last[a] = last[b] = 1+max(last[a], last[b])
    return max(last)


def construct(k, direct_score_limit=9):
    if k < 5 or k % 2 != 1:
        raise ValueError("This family is for odd k>=5.")
    r = k-4
    enc = balanced_encoder(list(range(r)))
    literal = invert(enc) + remap(seed(), {0: 0, 1: r, 2: r+1, 3: r+2, 4: r+3}) + enc
    count = sum(g["gate"] == "CNOT" for g in literal)
    assert count == 3*k-6
    actual = replay(literal, k)
    expected = expected_inflated_rows(SEED_ROWS, 5, r)
    assert actual == expected
    for i in range(2*k):
        for j in range(2*k):
            assert pairing(actual[i], actual[j], k) == int(i//2 == j//2 and i != j)
    cert = coefficients(SEED_ROWS, 5)
    assert cert["C5_C3_C0"] == SEED_COEFFICIENTS
    exact = (1875*5**r + 81*3**r - 6)//4
    source = (3*5**k + 3**k - 6)//4
    assert exact == source
    direct = score(actual, k)[0] if k <= direct_score_limit else None
    if direct is not None:
        assert direct == source
    height, capacity = 0, 1
    while capacity < r:
        height += 1
        capacity *= 3
    depth = entangling_depth(literal, k)
    assert depth <= 6*height+7
    return {
        "k": k,
        "connectivity": "complete",
        "cnot_count": count,
        "cnot_depth": depth,
        "proved_depth_upper_bound": 6*height+7,
        "seed_size": 5,
        "inflated_group_size": r,
        "seed_coefficient_certificate": cert,
        "source_optimal_score": source,
        "coefficient_score": exact,
        "direct_finite_score": direct,
        "final_rows": list(actual),
        "physical_gates": literal,
        "free_wire_permutation_used": False,
        "minimality_claim": "nine is exact for the five-qubit dual-axis coset; no all-k exact-count claim",
        "proof": "../theory/complete_resource.md",
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--k", type=int, default=7)
    parser.add_argument("--direct-score-limit", type=int, default=9)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    data = construct(args.k, args.direct_score_limit)
    if args.output:
        args.output.write_text(json.dumps(data, indent=2)+"\n")
    print(json.dumps({key: data[key] for key in (
        "k", "cnot_count", "cnot_depth", "proved_depth_upper_bound",
        "source_optimal_score", "direct_finite_score",
        "seed_coefficient_certificate",
    )}, indent=2))
