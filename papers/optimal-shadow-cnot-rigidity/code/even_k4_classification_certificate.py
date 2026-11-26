#!/usr/bin/env python3
"""Complete normalized k4 optimizer class enumeration over F_2.

The proof of completeness and the residual group are in
proofs/even_optimizer_classification.md, Section 11. Qubit permutations here
define a matrix equivalence relation; this script never grants free wire
permutations to a physical circuit.
"""
from collections import deque
from itertools import product
from pathlib import Path
import hashlib
import json

GL = [(a, b) for a in (1,2,3) for b in (1,2,3) if a != b]
K = (3, 3)


def act(rows, value):
    return sum(((row & value).bit_count() & 1) << i
               for i, row in enumerate(rows))


def swap_pairs(value):
    return ((value & 0x55) << 1) | ((value & 0xaa) >> 1)


def orthogonal(a, b):
    return all((x & swap_pairs(y)).bit_count() % 2 == 0
               for x in a for y in b)


def indices(mask):
    while mask:
        bit = mask & -mask
        yield bit.bit_length()-1
        mask ^= bit


def canonical_output(rows):
    # Residual output locals are precisely I and J, which swap the two rows.
    return tuple(value for i in range(4) for value in sorted(rows[2*i:2*i+2]))


def enumerate_normalized():
    candidates = []
    for i in range(4):
        choices = []
        for off_diagonal in product(GL, repeat=3):
            blocks = list(off_diagonal)
            blocks.insert(i, K)
            rows = tuple(sum(block[a] << (2*j) for j, block in enumerate(blocks))
                         for a in (0,1))
            if act(rows, 255) == 3:
                choices.append(rows)
        assert len(choices) == 56
        candidates.append(choices)

    compatible = {}
    for i in range(4):
        for j in range(i+1, 4):
            compatible[i,j] = [sum(1 << b for b, B in enumerate(candidates[j])
                                    if orthogonal(A, B)) for A in candidates[i]]
    raw_count = 0
    quotient = set()
    for a in range(56):
        for b in indices(compatible[0,1][a]):
            for c in indices(compatible[0,2][a] & compatible[1,2][b]):
                for d in indices(compatible[0,3][a] & compatible[1,3][b]
                                 & compatible[2,3][c]):
                    raw_count += 1
                    rows = tuple(value for i, choice in enumerate((a,b,c,d))
                                 for value in candidates[i][choice])
                    quotient.add(canonical_output(rows))
    assert raw_count == 896
    assert len(quotient) == 56
    assert raw_count == 16*len(quotient)
    return quotient, raw_count


def input_swap(rows, j):
    result = []
    mask = 3 << (2*j)
    for row in rows:
        block = (row >> (2*j)) & 3
        block = ((block & 1) << 1) | ((block >> 1) & 1)
        result.append((row & ~mask) | (block << (2*j)))
    return canonical_output(result)


def simultaneous_permutation(rows, permutation):
    result = []
    for i in range(4):
        for row in rows[2*permutation[i]:2*permutation[i]+2]:
            result.append(sum(((row >> (2*permutation[j])) & 3) << (2*j)
                              for j in range(4)))
    return canonical_output(result)


def classify(quotient):
    permutations = []
    for i in range(3):
        permutation = list(range(4))
        permutation[i], permutation[i+1] = permutation[i+1], permutation[i]
        permutations.append(permutation)
    remaining = set(quotient)
    orbits = []
    while remaining:
        representative = min(remaining)
        orbit = {representative}
        queue = deque([representative])
        while queue:
            rows = queue.popleft()
            successors = [input_swap(rows, j) for j in range(4)]
            successors += [simultaneous_permutation(rows, p) for p in permutations]
            for successor in successors:
                assert successor in quotient
                if successor not in orbit:
                    orbit.add(successor)
                    queue.append(successor)
        remaining -= orbit
        orbits.append(orbit)
    assert sorted(map(len, orbits)) == [8, 48]
    return orbits


def inverse(rows):
    return tuple(sum(((rows[j ^ 1] >> (i ^ 1)) & 1) << j for j in range(8))
                 for i in range(8))


def multiply(left, right):
    result = []
    for row in left:
        value = 0
        for j in range(8):
            if (row >> j) & 1:
                value ^= right[j]
        result.append(value)
    return tuple(result)


def delta(rows):
    return sum((sum(bool((row >> (2*j)) & 3) for j in range(4)) % 2 ^ 1) << i
               for i, row in enumerate(rows))


def local_diagonal(actions):
    return tuple(row << (2*i) for i, action in enumerate(actions) for row in action)


def normalize(rows):
    matching = []
    for i in range(4):
        positions = []
        for j in range(4):
            a, b = (rows[2*i] >> (2*j)) & 3, (rows[2*i+1] >> (2*j)) & 3
            dimension = int(bool(a or b)) + int(bool(a and b and a != b))
            if dimension == 1:
                positions.append(j)
            else:
                assert dimension == 2
        assert len(positions) == 1
        matching.append(positions[0])
    assert len(set(matching)) == 4
    rows = tuple(sum(((row >> (2*matching[j])) & 3) << (2*j) for j in range(4))
                 for row in rows)
    d, e = delta(rows), delta(inverse(rows))
    left = local_diagonal([next(B for B in GL if act(B, (d >> (2*i)) & 3) == 3)
                           for i in range(4)])
    right = local_diagonal([next(B for B in GL if act(B, 3) == ((e >> (2*i)) & 3))
                            for i in range(4)])
    result = multiply(multiply(left, rows), right)
    assert delta(result) == delta(inverse(result)) == 255
    assert all(((result[2*i] >> (2*i)) & 3,
                (result[2*i+1] >> (2*i)) & 3) == K for i in range(4))
    return canonical_output(result), matching


def main():
    quotient, raw_count = enumerate_normalized()
    orbits = classify(quotient)
    dual = tuple(sum((K[a] if i == j else (2,1)[a]) << (2*j) for j in range(4))
                 for i in range(4) for a in (0,1))
    dual_rep, _ = normalize(dual)
    dual_orbit = next(o for o in orbits if dual_rep in o)
    assert len(dual_orbit) == 8
    case = Path(__file__).resolve().parents[1]
    witness_raw = (case/"code/new_resource_witnesses.json").read_bytes()
    path_witness = next(w for w in json.loads(witness_raw)["witnesses"]
                        if w["name"] == "k4_path_7")
    members = []
    for name, rows in [("displayed_counterexample", (110,184,166,245,71,158,58,175)),
                       ("k4_path_7", path_witness["final_rows"])]:
        normalized, matching = normalize(rows)
        orbit = next(o for o in orbits if normalized in o)
        assert len(orbit) == 48
        members.append({"name": name, "normalized_rows": normalized,
                        "rank_one_matching_zero_based": matching,
                        "class": "exceptional", "class_left_quotient_size": len(orbit)})
    result = {"row_candidates_each": 56, "normalized_symplectic_matrices": raw_count,
              "quotient_by_output_I_J": len(quotient), "number_of_classes": len(orbits),
              "classes": [{"class": "dual_axis" if o is dual_orbit else "exceptional",
                            "representative_rows": min(o), "left_quotient_size": len(o),
                            "normalized_matrix_count": 16*len(o)} for o in orbits],
              "membership_checks": members,
              "resource_witness_file_sha256": hashlib.sha256(witness_raw).hexdigest(),
              "scope": "complete k4 equivalence classification; permutations not free in physical circuits"}
    destination = case/"results/even_k4_classification.json"
    destination.write_text(json.dumps(result, indent=2)+"\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
