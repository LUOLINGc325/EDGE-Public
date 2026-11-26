#!/usr/bin/env python3
"""Small-k exact feasibility probe; no claim about the all-k open problem.

Enumerate binary symplectic maps modulo free output one-qubit Cliffords.
One edge is a transvection on a weight-two Pauli, realizable by one CNOT and
free one-qubit Cliffords. Every CNOT edge, with arbitrary local frames, occurs.
No ancillas and no free qubit permutations are used. Intended only for k<=3.
"""

import argparse
import itertools
import json
import math
import time
from collections import Counter, deque
from pathlib import Path


def canonical(rows):
    out = []
    for i in range(0, len(rows), 2):
        a, b = rows[i:i+2]
        triple = sorted((a, b, a ^ b))
        out.extend(triple[:2])
    return tuple(out)


def transvection(rows, p):
    w = 0
    for i in range(len(rows) // 2):
        if p >> (2*i+1) & 1:
            w ^= rows[2*i]
        if p >> (2*i) & 1:
            w ^= rows[2*i+1]
    return tuple(r ^ w if p >> a & 1 else r for a, r in enumerate(rows))


def generators(k, chain=False):
    pairs = [(i, j) for i in range(k) for j in range(i+1, k)
             if not chain or j == i+1]
    return [a << (2*i) | b << (2*j)
            for i, j in pairs for a in (1, 2, 3) for b in (1, 2, 3)]


def full_inputs(k):
    return [sum(a << (2*i) for i, a in enumerate(labels))
            for labels in itertools.product((1, 2, 3), repeat=k)]


def score(rows, inputs):
    total = 0
    for p in inputs:
        zeroes = sum(not ((rows[2*i] & p).bit_count() % 2
                         or (rows[2*i+1] & p).bit_count() % 2)
                     for i in range(len(rows)//2))
        total += 3**zeroes
    return total


def rank(binary_rows):
    pivots = {}
    for row in binary_rows:
        while row:
            pivot = row.bit_length()-1
            if pivot in pivots:
                row ^= pivots[pivot]
            else:
                pivots[pivot] = row
                break
    return len(pivots)


def singleton_crossranks(rows):
    return [rank([rows[2*i] & ~ (3 << (2*i)),
                  rows[2*i+1] & ~ (3 << (2*i))])
            for i in range(len(rows)//2)]


def local_actions(before, after):
    actions = []
    for i in range(0, len(before), 2):
        a, b = before[i:i+2]
        options = {a: 1, b: 2, a ^ b: 3}
        actions.append([options[after[i]], options[after[i+1]]])
    return actions


def expected_score(k):
    return ((3*5**k + 3**k - 6)//4 if k % 2
            else (3*5**k - 3**k + 2)//4)


def dual_axis_rows(k):
    rows = tuple(1 << i for i in range(2*k))
    x = sum(1 << (2*i) for i in range(k))
    z = sum(2 << (2*i) for i in range(k))
    return canonical(transvection(transvection(rows, z), x))


def right_local_orbit(rows):
    """Output-local canonical forms of M L over every local input L."""
    k = len(rows)//2
    choices = [(a, b) for a in (1, 2, 3) for b in (1, 2, 3) if a != b]
    orbit = set()
    for actions in itertools.product(choices, repeat=k):
        transformed = []
        for row in rows:
            new_row = 0
            for i, (a, b) in enumerate(actions):
                local = (a if row >> (2*i) & 1 else 0) ^ (b if row >> (2*i+1) & 1 else 0)
                new_row |= local << (2*i)
            transformed.append(new_row)
        orbit.add(canonical(transformed))
    return orbit


def search(k, chain=False, full=False):
    if not 2 <= k <= 3:
        raise ValueError("This bounded probe supports only k=2 or k=3.")
    start = canonical(tuple(1 << i for i in range(2*k)))
    predecessor = {start: None}
    depths = {start: 0}
    queue = deque([start])
    inputs = full_inputs(k)
    moves = generators(k, chain)
    optimum = expected_score(k)
    witness = None
    levels = {}
    optimum_crossrank_histogram = Counter()
    first_depth = None
    optimal_states = set()
    while queue:
        state = queue.popleft()
        depth = depths[state]
        if first_depth is not None and depth > first_depth and not full:
            break
        level = levels.setdefault(depth, {"states": 0, "max_score": 0, "optimal_states": 0})
        level["states"] += 1
        value = score(state, inputs)
        level["max_score"] = max(level["max_score"], value)
        if value == optimum:
            optimal_states.add(state)
            level["optimal_states"] += 1
            optimum_crossrank_histogram[tuple(singleton_crossranks(state))] += 1
            if first_depth is None:
                first_depth, witness = depth, state
        if full or first_depth is None or depth < first_depth:
            for p in moves:
                successor = canonical(transvection(state, p))
                if successor not in predecessor:
                    predecessor[successor] = (state, p)
                    depths[successor] = depth + 1
                    queue.append(successor)
    path = []
    state = witness
    while state is not None and predecessor[state] is not None:
        previous, p = predecessor[state]
        before_local = transvection(previous, p)
        path.append({"weight_two_pauli_bits": p,
                     "free_local_row_actions_after_gate": local_actions(before_local, state),
                     "resulting_symplectic_rows": list(state)})
        state = previous
    path.reverse()
    dual_orbit = right_local_orbit(dual_axis_rows(k))
    expected_orbits = 2**(k*k) * math.prod(4**j-1 for j in range(1, k+1)) // 6**k
    cnot_orbit = right_local_orbit(canonical(transvection(start, moves[0])))
    return {"k": k, "connectivity": "chain" if chain else "all-to-all",
            "target_score_from_source": optimum, "minimum_CNOT_in_this_finite_enumeration": first_depth,
            "enumerated_all_output_local_orbits": full and not queue,
            "levels": levels,
            "total_scored_states": sum(v["states"] for v in levels.values()),
            "expected_number_of_output_local_orbits": expected_orbits,
            "full_enumeration_count_matches_group_order": full and len(predecessor) == expected_orbits,
            "optimal_singleton_crossrank_histogram": {str(key): value for key, value in optimum_crossrank_histogram.items()},
            "dual_axis_input_local_orbit_size_mod_output_locals": len(dual_orbit),
            "all_enumerated_optima_in_dual_axis_double_local_orbit": optimal_states <= dual_orbit,
            "enumerated_optima_outside_dual_axis_double_local_orbit": len(optimal_states - dual_orbit),
            "one_cnot_input_local_orbit_size_mod_output_locals": len(cnot_orbit),
            "dual_axis_and_one_cnot_double_local_orbits_disjoint": not bool(dual_orbit & cnot_orbit),
            "all_enumerated_optima_in_union_of_these_two_orbits": optimal_states <= (dual_orbit | cnot_orbit),
            "one_minimum_witness": path,
            "scope": "exact finite k<=3 route probe, not an all-k theorem or full optimum classification"}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--full", action="store_true")
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    started = time.perf_counter()
    results = [search(k, chain, args.full) for k in (2, 3) for chain in (False, True)]
    report = {"results": results, "elapsed_seconds": time.perf_counter()-started}
    rendered = json.dumps(report, indent=2) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered)
    print(rendered, end="")
