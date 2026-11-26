#!/usr/bin/env python3
"""Construct optimal labelled-path shadow circuits with 4*k-8 CNOTs, k>=4.

The arbitrary-size claim follows from the finite seed coefficient certificate
and the symbolic site-inflation identity in resource_path_family.md. This
script emits actual H/S/CNOT gates, checks the encoder and seed coefficients,
and verifies a requested finite circuit against that identity. It does not
claim the resulting bound is the exact minimum for every k.
"""
import argparse
import itertools
import json
from collections import deque
from pathlib import Path

import probe
from new_verify_resource_witnesses import gate, pairing, score


def local_words():
    words = {(1, 2): []}
    queue = deque([(1, 2)])
    while queue:
        a, b = queue.popleft()
        for name, target in (("H", (b, a)), ("S", (a, a ^ b))):
            if target not in words:
                words[target] = words[(a, b)] + [name]
                queue.append(target)
    return words


LOCAL_WORDS = local_words()


def local_gates(site, rows):
    return [{"gate": name, "qubit": site} for name in LOCAL_WORDS[tuple(rows)]]


def rotation_gates(i, j, a, b):
    out = []
    for site, label in ((i, a), (j, b)):
        if label == 3:
            out.append({"gate": "S", "qubit": site})
        if label in (1, 3):
            out.append({"gate": "H", "qubit": site})
    out.extend([{"gate": "H", "qubit": j},
                {"gate": "CNOT", "control": i, "target": j},
                {"gate": "H", "qubit": j},
                {"gate": "S", "qubit": i},
                {"gate": "S", "qubit": j}])
    for site, label in ((i, a), (j, b)):
        if label in (1, 3):
            out.append({"gate": "H", "qubit": site})
        if label == 3:
            out.append({"gate": "S", "qubit": site})
    return out


def replay(gates, k):
    rows = tuple(1 << i for i in range(2*k))
    for entry in gates:
        rows = gate(rows, entry)
    return rows


def transvection_word_gates(word, k):
    rows = tuple(1 << i for i in range(2*k))
    gates = []
    for i, j, a, b in word:
        gates.extend(rotation_gates(i, j, a, b))
        raw = probe.transvection(rows, (a << (2*i)) | (b << (2*j)))
        end = probe.canonical(raw)
        for site, action in enumerate(probe.local_actions(raw, end)):
            gates.extend(local_gates(site, action))
        rows = end
    assert replay(gates, k) == rows
    return gates


def encoder_three():
    # Every step is a nearest-neighbor weight-two Pauli transvection followed
    # by the explicitly specified free local action. No wire permutation.
    steps = [
        (5, ((2, 3), (3, 2), (1, 2))),
        (24, ((1, 2), (1, 3), (3, 2))),
        (5, ((2, 1), (3, 1), (1, 2))),
        (36, ((1, 2), (3, 2), (3, 2))),
    ]
    out = []
    for p, actions in steps:
        sites = [i for i in range(3) if (p >> (2*i)) & 3]
        i, j = sites
        out.extend(rotation_gates(i, j, (p >> (2*i)) & 3, (p >> (2*j)) & 3))
        for site, action in enumerate(actions):
            out.extend(local_gates(site, action))
    for site, action in enumerate(((1, 3), (1, 3), (2, 3))):
        out.extend(local_gates(site, action))
    rows = replay(out, 3)
    assert rows == (9, 42, 25, 62, 17, 22)
    assert all(((rows[2*i] & 3), (rows[2*i+1] & 3)) == (1, 2) for i in range(3))
    assert sum(g["gate"] == "CNOT" for g in out) == 4
    return out


def remap(gates, mapping):
    out = []
    for entry in gates:
        if entry["gate"] == "CNOT":
            out.append({"gate": "CNOT", "control": mapping[entry["control"]],
                        "target": mapping[entry["target"]]})
        else:
            out.append({"gate": entry["gate"], "qubit": mapping[entry["qubit"]]})
    return out


def invert(gates):
    # S^-1 = S^3 as a physical gate, rather than silently ignoring its phase.
    out = []
    for entry in reversed(gates):
        out.extend([dict(entry)] * (3 if entry["gate"] == "S" else 1))
    return out


def seeds():
    # The even seed was found independently with search seed 929; it need not
    # be the cheapest four-qubit circuit. Its endpoint is suitable for lifting.
    even_word = [[0, 1, 1, 3], [2, 3, 1, 3], [1, 2, 1, 1], [0, 1, 1, 1],
                 [2, 3, 2, 1], [1, 2, 2, 3], [2, 3, 2, 3], [0, 1, 3, 1]]
    even = (local_gates(0, (3, 1)) + transvection_word_gates(even_word, 4)
            + local_gates(0, (1, 3)))
    odd_word = [[3, 4, 1, 2], [0, 1, 3, 3], [2, 3, 1, 3], [1, 2, 2, 3],
                [2, 3, 1, 3], [3, 4, 1, 3], [0, 1, 1, 1], [1, 2, 2, 1],
                [2, 3, 3, 1], [1, 2, 2, 1], [0, 1, 1, 1], [3, 4, 3, 3]]
    odd = transvection_word_gates(odd_word, 5) + local_gates(0, (2, 1))
    out = {4: even, 5: odd}
    assert replay(even, 4) == (119, 219, 126, 163, 47, 153, 102, 143)
    assert replay(odd, 5) == (603, 501, 511, 598, 487, 634, 439, 730, 346, 685)
    return out


def block_action(rows, i, j, value):
    return (((rows[2*i] >> (2*j)) & value).bit_count() % 2
            + 2 * (((rows[2*i+1] >> (2*j)) & value).bit_count() % 2))


def coefficients(rows, size):
    # For an odd group size r, the score of the symbolic inflation equals
    # (C5*5^r + C3*3^r + C0)/4. Every accumulation below is an integer.
    by_v = [[0, 0, 0] for _ in range(4)]
    for outside in itertools.product((1, 2, 3), repeat=size-1):
        for v in range(4):
            values = (v,) + outside
            outputs = [0] * size
            for i in range(size):
                for j in range(size):
                    outputs[i] ^= block_action(rows, i, j, values[j])
            weight = 3 ** sum(outputs[i] == 0 for i in range(1, size))
            c = outputs[0] ^ v
            chi = lambda u: (-1) ** ((u & v).bit_count() % 2)
            if c == 0:
                by_v[v][1] += weight
                by_v[v][2] -= weight * sum(chi(u) for u in (1, 2, 3))
            else:
                by_v[v][0] += weight
                by_v[v][1] -= weight * sum(chi(u) for u in (1, 2, 3)
                                           if (u & c).bit_count() % 2)
                by_v[v][2] += weight * sum(chi(u) for u in (1, 2, 3)
                                           if not (u & c).bit_count() % 2)
    total = [sum(row[i] for row in by_v) for i in range(3)]
    return {"C5_C3_C0": total, "contributions_by_v": by_v,
            "outside_configurations": 3**(size-1), "parity_values": 4}


def expected_inflated_rows(seed_rows, seed_size, r):
    k = seed_size + r - 1
    result = [0] * (2*k)
    for input_bit in range(2*k):
        inp = [0] * k
        inp[input_bit // 2] = 1 << (input_bit % 2)
        v = 0
        for value in inp[:r]:
            v ^= value
        seed_input = [v] + inp[r:]
        out = [0] * seed_size
        for i in range(seed_size):
            for j in range(seed_size):
                out[i] ^= block_action(seed_rows, i, j, seed_input[j])
        c = out[0] ^ v
        inflated = [value ^ c for value in inp[:r]] + out[1:]
        for i, value in enumerate(inflated):
            if value & 1:
                result[2*i] |= 1 << input_bit
            if value & 2:
                result[2*i+1] |= 1 << input_bit
    return tuple(result)


def construct(k, direct_score_limit=9):
    if k < 4:
        raise ValueError("This family is for k>=4; separate exact k2/k3 witnesses are known.")
    size = 4 if k % 2 == 0 else 5
    seed_gates = seeds()[size]
    seed_rows = replay(seed_gates, size)
    coefficient = coefficients(seed_rows, size)
    assert coefficient["C5_C3_C0"] == ([375, -27, 2] if size == 4 else [1875, 81, -6])
    r = k-size+1
    encoder = []
    base_encoder = encoder_three()
    for endpoint in range(r-1, 1, -2):
        encoder.extend(remap(base_encoder, {0: endpoint, 1: endpoint-1, 2: endpoint-2}))
    physical = (invert(encoder) + remap(seed_gates, {i: r-1+i for i in range(size)})
                + encoder)
    for entry in physical:
        if entry["gate"] == "CNOT":
            assert abs(entry["control"]-entry["target"]) == 1
    count = sum(entry["gate"] == "CNOT" for entry in physical)
    assert count == 4*k-8
    actual = replay(physical, k)
    expected = expected_inflated_rows(seed_rows, size, r)
    assert actual == expected
    for i in range(2*k):
        for j in range(2*k):
            assert pairing(actual[i], actual[j], k) == int(i//2 == j//2 and i != j)
    a, b, c = coefficient["C5_C3_C0"]
    exact_score = (a*5**r + b*3**r + c)//4
    source_score = (3*5**k + (3**k-6 if k % 2 else -3**k+2))//4
    assert exact_score == source_score
    direct = None
    if k <= direct_score_limit:
        direct = score(actual, k)[0]
        assert direct == exact_score
    return {"k": k, "connectivity": "labelled_path", "cnot_count": count,
            "source_optimal_score": source_score, "coefficient_score": exact_score,
            "direct_finite_score": direct, "seed_size": size, "inflated_group_size": r,
            "seed_coefficient_certificate": coefficient, "final_rows": list(actual),
            "physical_gates": physical, "free_wire_permutation_used": False,
            "minimality_claim": "none; uniform constructive upper bound"}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--k", type=int, default=7)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--direct-score-limit", type=int, default=9)
    args = parser.parse_args()
    result = construct(args.k, args.direct_score_limit)
    rendered = json.dumps(result, indent=2) + "\n"
    if args.output:
        args.output.write_text(rendered)
    print(json.dumps({key: result[key] for key in
                      ("k", "cnot_count", "coefficient_score", "direct_finite_score", "seed_coefficient_certificate")}, indent=2))
