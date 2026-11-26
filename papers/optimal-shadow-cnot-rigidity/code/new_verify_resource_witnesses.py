#!/usr/bin/env python3
"""Replay fixed resource witnesses using only actual H, S, and CNOT gates.

This verifier does not run the heuristic search. It checks the physical gate
list independently of the transvection representation used by that search.
Only H and S have zero CNOT cost. There is no wire permutation operation.
"""
import argparse
import hashlib
import json
from pathlib import Path


def gate(rows, entry):
    rows = list(rows)
    name = entry["gate"]
    if name == "H":
        i = entry["qubit"]
        rows[2*i], rows[2*i+1] = rows[2*i+1], rows[2*i]
    elif name == "S":
        i = entry["qubit"]
        rows[2*i+1] ^= rows[2*i]
    elif name == "CNOT":
        c, t = entry["control"], entry["target"]
        assert c != t
        rows[2*t] ^= rows[2*c]
        rows[2*c+1] ^= rows[2*t+1]
    else:
        raise ValueError("unsupported/free operation: " + name)
    return tuple(rows)


def pairing(a, b, k):
    return sum(((a >> (2*i)) & 1)*((b >> (2*i+1)) & 1)
               + ((a >> (2*i+1)) & 1)*((b >> (2*i)) & 1)
               for i in range(k)) % 2


def score(rows, k):
    result = 0
    histogram = {}
    for code in range(3**k):
        p, remaining = 0, code
        for i in range(k):
            p |= (1+remaining % 3) << (2*i)
            remaining //= 3
        size = sum(bool((rows[2*i] & p).bit_count() % 2
                        or (rows[2*i+1] & p).bit_count() % 2) for i in range(k))
        result += 3**(k-size)
        histogram[str(size)] = histogram.get(str(size), 0) + 1
    return result, histogram


def rank_sum(rows, k):
    total = 0
    matrix = []
    for i in range(k):
        row = []
        for j in range(k):
            a, b = (rows[2*i] >> (2*j)) & 3, (rows[2*i+1] >> (2*j)) & 3
            rank = int(bool(a or b)) + int(bool(a and b and a != b))
            row.append(rank)
            total += rank
        matrix.append(row)
    return total, matrix


def sign_rectangle(rows, k):
    signs = []
    for i in range(k):
        row = []
        for j in range(k):
            a, b = (rows[2*i] >> (2*j)) & 3, (rows[2*i+1] >> (2*j)) & 3
            if not (a and b and a != b):
                return None
            images = [((a & v).bit_count() % 2) + 2*((b & v).bit_count() % 2)
                      for v in (1, 2, 3)]
            row.append(sum(images[s] > images[t] for s in range(3)
                           for t in range(s+1, 3)) % 2)
        signs.append(row)
    rectangles = [[signs[i][j] ^ signs[i][0] ^ signs[0][j] ^ signs[0][0]
                   for j in range(k)] for i in range(k)]
    return {"block_signs": signs, "dephased_rectangle_signs": rectangles,
            "nonzero_rectangle_exists": any(any(row) for row in rectangles)}


def verify(witness):
    k = witness["k"]
    rows = tuple(1 << i for i in range(2*k))
    count = 0
    edge_counts = {}
    for entry in witness["physical_gates"]:
        if entry["gate"] == "CNOT":
            c, t = entry["control"], entry["target"]
            assert 0 <= c < k and 0 <= t < k and c != t
            if witness["connectivity"] == "labelled_path":
                assert abs(c-t) == 1
            edge = f"{min(c,t)}-{max(c,t)}"
            edge_counts[edge] = edge_counts.get(edge, 0) + 1
            count += 1
        else:
            assert 0 <= entry["qubit"] < k
        rows = gate(rows, entry)
    assert count == witness["cnot_count"]
    assert list(rows) == witness["final_rows"]
    for i in range(2*k):
        for j in range(2*k):
            assert pairing(rows[i], rows[j], k) == int(i//2 == j//2 and i != j)
    actual_score, histogram = score(rows, k)
    target = (3*5**k + (3**k-6 if k % 2 else -3**k+2))//4
    assert actual_score == target == witness["score"]
    total, blocks = rank_sum(rows, k)
    return {"name": witness["name"], "k": k, "connectivity": witness["connectivity"],
            "actual_cnot_count": count, "actual_score": actual_score,
            "source_optimal_score": target, "block_rank_sum": total,
            "block_ranks": blocks, "edge_counts": edge_counts,
            "output_weight_histogram": histogram,
            "odd_block_sign_invariant": sign_rectangle(rows, k),
            "physical_gate_replay_passed": True,
            "free_wire_permutation_used": False,
            "minimality_claim": witness["minimality_claim"]}


if __name__ == "__main__":
    base = Path(__file__).resolve().parent
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--input", type=Path, default=base/"new_resource_witnesses.json")
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    raw = args.input.read_bytes()
    data = json.loads(raw)
    report = {"witness_file_sha256": hashlib.sha256(raw).hexdigest(),
              "checks": [verify(w) for w in data["witnesses"]],
              "scope": "fixed constructive upper bounds; only k4 path is matched by a proved lower bound"}
    rendered = json.dumps(report, indent=2) + "\n"
    if args.output:
        args.output.write_text(rendered)
    print(rendered, end="")
