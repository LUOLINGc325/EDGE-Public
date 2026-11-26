#!/usr/bin/env python3
"""Exact finite-order audit of the joint Hamiltonian/channel polymer identity.

This is an algebraic regression check, not a proof of infinite-volume CMI decay.
Uses rational arithmetic, noncommuting Hamiltonian terms, nonunital channels,
overlapping gates, and two separately labelled gates with identical support.
"""
from __future__ import annotations

import itertools
import json
import math
from pathlib import Path
import sympy as sp

ROOT = Path(__file__).resolve().parents[1]
N = 3
DIM = 2 ** N
ORDER = 4
I2 = sp.eye(2)
X = sp.Matrix([[0, 1], [1, 0]])
Z = sp.diag(1, -1)


def kron_all(items):
    out = sp.Matrix([[1]])
    for item in items:
        out = sp.kronecker_product(out, item)
    return out


H = [kron_all([X, X, I2]), kron_all([I2, Z, Z]), kron_all([Z, I2, I2])]
HS = [{0, 1}, {1, 2}, {0}]
bell = sp.Matrix([1, 0, 0, 1])
bell = bell * bell.T / 2
zero_pair = sp.diag(1, 0, 0, 0)
zero_one = sp.diag(1, 0)
GS = [{0, 1}, {1, 2}, {0, 1}, {2}]
TARGETS = [bell, zero_pair, zero_pair, zero_one]
SUPPORTS = HS + GS
BITS = [tuple((i >> (N - 1 - j)) & 1 for j in range(N)) for i in range(DIM)]


def subset_index(bits, sites):
    v = 0
    for site in sites:
        v = 2 * v + bits[site]
    return v


def reset_map(mat, sites, target):
    sites = sorted(sites)
    rest = [j for j in range(N) if j not in sites]
    dim_rest = 2 ** len(rest)
    reduced = sp.zeros(dim_rest)
    for a in range(DIM):
        for b in range(DIM):
            if all(BITS[a][j] == BITS[b][j] for j in sites):
                reduced[subset_index(BITS[a], rest), subset_index(BITS[b], rest)] += mat[a, b]
    out = sp.zeros(DIM)
    for a in range(DIM):
        for b in range(DIM):
            out[a, b] = target[subset_index(BITS[a], sites), subset_index(BITS[b], sites)] * reduced[subset_index(BITS[a], rest), subset_index(BITS[b], rest)]
    return out


def delta(mat, gate):
    return reset_map(mat, GS[gate], TARGETS[gate]) - mat


def selected_gates(mat, gate_mask):
    # Time order is kept: gate 0 acts first; no overlapping gates are commuted.
    for gate in range(len(GS)):
        if gate_mask & (1 << gate):
            mat = delta(mat, gate)
    return mat


def components(mask):
    remaining = {i for i in range(len(SUPPORTS)) if mask & (1 << i)}
    result = []
    while remaining:
        component = {min(remaining)}
        remaining -= component
        while True:
            added = {j for j in remaining if any(SUPPORTS[j] & SUPPORTS[i] for i in component)}
            if not added:
                break
            component |= added
            remaining -= added
        result.append(sum(1 << i for i in component))
    return result


def multiply_series(left, right):
    out = [sp.zeros(DIM) for _ in range(ORDER + 1)]
    for degree in range(ORDER + 1):
        for j in range(degree + 1):
            out[degree] += left[j] * right[degree - j]
    return out


def is_zero(mat):
    return all(value == 0 for value in mat)


def main():
    # Sum the Taylor words that use precisely each chosen set of H labels.
    hseries = {mask: [sp.zeros(DIM) for _ in range(ORDER + 1)] for mask in range(2 ** len(H))}
    hseries[0][0] = sp.eye(DIM)
    for degree in range(1, ORDER + 1):
        for word in itertools.product(range(len(H)), repeat=degree):
            mask = 0
            product = sp.eye(DIM)
            for index in word:
                mask |= 1 << index
                product = product * H[index]
            hseries[mask][degree] += sp.Rational((-1) ** degree, math.factorial(degree)) * product

    coefficient = {}
    for mask in range(2 ** len(SUPPORTS)):
        hm = mask & ((1 << len(H)) - 1)
        gm = mask >> len(H)
        coefficient[mask] = [selected_gates(mat, gm) for mat in hseries[hm]]

    factorization_checks = 0
    disconnected_checks = 0
    hermiticity_checks = 0
    support_checks = 0
    for mask, series in coefficient.items():
        parts = components(mask)
        product = [sp.eye(DIM)] + [sp.zeros(DIM) for _ in range(ORDER)]
        for part in parts:
            product = multiply_series(product, coefficient[part])
        for degree in range(ORDER + 1):
            assert is_zero(product[degree] - series[degree]), (mask, degree, 'factorization')
            factorization_checks += 1
            disconnected_checks += int(len(parts) > 1)
            assert is_zero(series[degree] - series[degree].H), (mask, degree, 'Hermiticity')
            hermiticity_checks += 1
        union = set().union(*(SUPPORTS[i] for i in range(len(SUPPORTS)) if mask & (1 << i))) if mask else set()
        for site in set(range(N)) - union:
            for pauli in [X, Z]:
                ops = [I2] * N
                ops[site] = pauli
                local = kron_all(ops)
                for degree in range(ORDER + 1):
                    assert is_zero(local * series[degree] - series[degree] * local), (mask, degree, 'support')
                    support_checks += 1

    total_h = sum(H, sp.zeros(DIM))
    reconstruction_checks = 0
    for gm in range(2 ** len(GS)):
        for degree in range(ORDER + 1):
            expected = selected_gates(sp.Rational((-1) ** degree, math.factorial(degree)) * total_h ** degree, gm)
            observed = sum((coefficient[hm + (gm << len(H))][degree] for hm in range(2 ** len(H))), sp.zeros(DIM))
            assert is_zero(expected - observed), (gm, degree, 'reconstruction')
            reconstruction_checks += 1

    # If order were discarded, this example would already fail at beta^0.
    order_defect = delta(delta(sp.eye(DIM), 0), 2) - delta(delta(sp.eye(DIM), 2), 0)
    assert not is_zero(order_defect)
    trace_checks = 0
    for gate in range(len(GS)):
        for a in range(DIM):
            for b in range(DIM):
                elementary = sp.zeros(DIM)
                elementary[a, b] = 1
                assert sp.trace(delta(elementary, gate)) == 0
                trace_checks += 1

    result = {
        'status': 'PASS',
        'arithmetic': 'exact rational (SymPy)',
        'qubits': N,
        'Hamiltonian_labels': len(H),
        'ordered_channel_labels': len(GS),
        'distinct_label_subsets': len(coefficient),
        'beta_Taylor_order': ORDER,
        'factorization_coefficient_checks': factorization_checks,
        'disconnected_factorization_coefficient_checks': disconnected_checks,
        'Hermiticity_coefficient_checks': hermiticity_checks,
        'outside_support_commutator_checks': support_checks,
        'reconstruction_coefficient_checks': reconstruction_checks,
        'trace_annihilation_checks': trace_checks,
        'noncommuting_gate_order_defect_squared_Frobenius': str(sp.trace(order_defect.H * order_defect)),
        'limitations': 'Finite-order algebra check; no claim of a formal proof of the analytic cluster expansion or CMI theorem.'
    }
    (ROOT / 'results' / 'exact_expansion_audit.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    main()
