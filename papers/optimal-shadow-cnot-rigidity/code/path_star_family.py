#!/usr/bin/env python3
"""Literal optimal-shadow star circuits with 3*k-4 CNOTs, k>=3.

Sharpness is proved for every odd k; for even k>=4 a one-CNOT gap remains.
All-order proof: theory/path_resource.md, Sections 6-7. This constructor
checks the exact symbolic map and local equivalence for each requested
size; finite checks are not used to infer the arbitrary-size theorem.
"""
import argparse
import json
from pathlib import Path
import sys

CASE = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(CASE / "code"))
from new_path_family import local_gates, rotation_gates, replay
from new_verify_resource_witnesses import pairing, score


def edge_word(k):
    if k < 3:
        raise ValueError("The proved family requires k>=3.")
    return ([(0, j, 1, 1) for j in range(2, k)]
            + [(0, 1, 3, 1)]
            + [(0, j, 2, 2) for j in range(2, k)]
            + [(0, 1, 3 if k % 2 else 1, 2)]
            + [(0, j, 1 if k % 2 else 3, 3) for j in range(2, k)])


def controlled_pauli_gates(i, j, a, b):
    # T_(a_i+b_j) T_(a_i) T_(b_j). The factors commute.
    local_transvection = {1: (3, 2), 2: (1, 3), 3: (2, 1)}
    return (local_gates(i, local_transvection[a])
            + local_gates(j, local_transvection[b])
            + rotation_gates(i, j, a, b))


def physical_gates(k):
    result = []
    for i, j, a, b in edge_word(k):
        result.extend(controlled_pauli_gates(i, j, a, b))
    return result


def symbolic_rows(k):
    out = [0] * (2*k)
    for bit in range(2*k):
        inp = [int(i == bit) for i in range(2*k)]
        x, z, y, w = inp[:4]
        U = sum(inp[2*j] for j in range(2,k)) % 2
        V = sum(inp[2*j+1] for j in range(2,k)) % 2
        if k % 2:
            vals = [x^y^U, x^z^y^w^U^V,
                    x^z^y^V, x^w^U^V]
            for j in range(2,k):
                vals += [inp[2*j]^x^y^w^U^V, inp[2*j+1]^z^y^U]
        else:
            vals = [z^y^w^U^V, z^w^V,
                    x^z^y^V, z^U]
            for j in range(2,k):
                vals += [inp[2*j]^z^y^U, inp[2*j+1]^x^y^w^U^V]
        for row, value in enumerate(vals):
            out[row] |= value << bit
    return tuple(out)


def multiply(A, B):
    result = []
    for row in A:
        z = 0
        for j, b in enumerate(B):
            if row & (1 << j): z ^= b
        result.append(z)
    return tuple(result)


def normalized_rows(k):
    # The two separately proved local normalizations S2 and S6.
    R = (3, 1)
    left, right = [], []
    N = [0] * (2*k)
    for i in range(k):
        if k % 2:
            lm = (2, 1) if i == 0 else R if i == 1 else (1, 2)
            rm = (1, 2) if i == 0 else R
            diagonal = R
        else:
            lm = (2, 3) if i == 0 else R if i == 1 else (1, 2)
            rm = (2, 1) if i == 0 else (1, 3)
            diagonal = (0, 1)
        left.extend(v << (2*i) for v in lm)
        right.extend(v << (2*i) for v in rm)
        for j in range(k):
            block = diagonal if i == j else (1, 2)
            N[2*i] |= block[0] << (2*j)
            N[2*i+1] |= block[1] << (2*j)
    return multiply(left, multiply(N, right))


def construct(k, direct_score=True):
    word = edge_word(k)
    gates = physical_gates(k)
    rows = replay(gates, k)
    assert rows == symbolic_rows(k) == normalized_rows(k)
    counts = {}
    for g in gates:
        if g["gate"] == "CNOT":
            pair = (g["control"], g["target"])
            assert 0 in pair and pair[0] != pair[1]
            edge = str(max(pair))
            counts[edge] = counts.get(edge, 0) + 1
    assert sum(counts.values()) == 3*k-4
    assert counts["1"] == 2 and all(counts[str(j)] == 3 for j in range(2,k))
    for i in range(2*k):
        for j in range(2*k):
            assert pairing(rows[i], rows[j], k) == int(i//2 == j//2 and i != j)
    target = (3*5**k + (3**k-6 if k%2 else -3**k+2))//4
    actual = None
    if direct_score:
        actual, _ = score(rows,k)
        assert actual == target
    return {"k":k,"connectivity":"labelled_star_center_0",
            "cnot_count":3*k-4,"edge_counts_by_leaf":counts,
            "controlled_pauli_word":word,"physical_gates":gates,
            "final_rows":rows,"exact_symbolic_map_match":True,
            "exact_local_normalization_match":True,"symplectic":True,
            "optimal_score_formula":target,"direct_score":actual,
            "exact_minimum_proved":bool(k%2),
            "all_order_proof":"theory/path_resource.md Sections 6-7",
            "formalization":"not_a_Lean_kernel_certificate"}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--k",type=int,default=7)
    parser.add_argument("--output",type=Path)
    parser.add_argument("--skip-direct-score",action="store_true")
    args=parser.parse_args()
    report=construct(args.k,not args.skip_direct_score)
    encoded=json.dumps(report,indent=2)+"\n"
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(encoded)
    else:print(encoded,end="")


if __name__=="__main__":main()
