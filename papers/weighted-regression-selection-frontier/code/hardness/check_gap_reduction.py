"""Exact small-instance checks of the graph-to-regression risk-gap transfer.

This is not a proof of the general hardness theorem. It checks the symbolic
loss identity, evaluates every full-rank d+1 support via rational hull KKT,
and lower-bounds every proper row span for the explicit shift a=v*1.
The adjacent-basis hull theorem is attributed to Zhang, arXiv:2608.28007v2 G.2.
"""
from __future__ import annotations

import argparse
from collections import deque
from itertools import combinations, permutations
import json
from pathlib import Path
import sys

import sympy as sp

sys.path.insert(0, str(Path(__file__).resolve().parents[1] / 'computation'))
from gamma_engine import certify_k1, verify_certificate


def shortest_directed_path(v, edges, source, target):
    adjacency = [[] for _ in range(v)]
    for j, (u, w) in enumerate(edges):
        adjacency[u].append((w, j))
    todo = deque([source])
    previous = {source: None}
    while todo:
        u = todo.popleft()
        if u == target:
            break
        for w, j in adjacency[u]:
            if w not in previous:
                previous[w] = (u, j)
                todo.append(w)
    if target not in previous:
        raise ValueError('The input graph is not strongly connected')
    result = []
    u = target
    while u != source:
        w, j = previous[u]
        result.append(j)
        u = w
    return result[::-1]


def hamiltonian(v, edges):
    arcs = set(edges)
    for order in permutations(range(1, v)):
        cycle = (0,) + order + (0,)
        if all(e in arcs for e in zip(cycle, cycle[1:])):
            return list(cycle)
    return None


def construct(v, edges):
    assert v >= 3
    assert len(set(edges)) == len(edges) and all(u != w for u, w in edges)
    for u in range(v):
        for w in range(v):
            shortest_directed_path(v, edges, u, w)
    x = sp.zeros(len(edges), v - 1)
    for j, (u, w) in enumerate(edges):
        if u != v - 1:
            x[j, u] = 1
        if w != v - 1:
            x[j, w] = -1
    multiplicities = [0] * len(edges)
    cycle_decomposition = []
    for j, (u, w) in enumerate(edges):
        cycle = [j] + shortest_directed_path(v, edges, w, u)
        assert len(cycle) <= v
        for z in cycle:
            multiplicities[z] += 1
        cycle_decomposition.append(cycle)
    c = sp.Matrix(multiplicities)
    total = sum(multiplicities)
    a = v * sp.ones(v - 1, 1)
    y = sp.ones(len(edges), 1) + x * a
    assert x.rank() == v - 1 and x.T * c == sp.zeros(v - 1, 1)
    assert min(multiplicities) >= 1 and total <= len(edges) * v
    assert set(y).issubset({1, 1 - v, 1 + v})
    return x, c, a, y, cycle_decomposition


def check_graph(name, v, edges):
    x, c, a, y, cycles = construct(v, edges)
    total = sum(c)
    p = sp.diag(*[z / total for z in c])
    h = x.T * p * x
    z = sp.Matrix(sp.symbols(f'z0:{v-1}'))
    residual = x * (a + z) - y
    risk = (residual.T * p * residual)[0]
    assert sp.expand(risk - 1 - (z.T * h * z)[0]) == 0
    assert (x.T * p * (x * a - y)) == sp.zeros(v - 1, 1)
    # Exact full-rank support infima (independent of the translating optimum).
    g = x.T * sp.diag(*list(c))
    certificate = certify_k1(g.tolist(), list(c), name)
    verification = verify_certificate(certificate)
    full_excess = sp.Rational(certificate['full_rank_budget_d_plus_one_optimum'])
    # Every proper span is contained in an independent (d-1)-row hyperplane.
    # Test distance in the ORIGINAL evaluation metric and at the prescribed shift.
    hyperplanes = {}
    for basis in combinations(range(len(edges)), v - 2):
        rows = x[list(basis), :]
        if rows.rank() != v - 2:
            continue
        normal = rows.nullspace()[0]
        normal /= next(z for z in normal if z != 0)
        key = tuple(normal)
        distance = (normal.T * a)[0] ** 2 / (normal.T * h.inv() * normal)[0]
        assert distance >= sp.Rational(v*v, total*(v-1))
        hyperplanes[key] = distance
    deficient_lower = min(hyperplanes.values())
    cycle = hamiltonian(v, edges)
    if cycle is not None:
        assert full_excess == 0
        indices = [edges.index(e) for e in zip(cycle, cycle[1:])]
        selected = x[indices, :]
        assert selected.rank() == v - 1
        assert selected.T * sp.ones(v, 1) == sp.zeros(v - 1, 1)
    else:
        assert full_excess >= 1/total
        assert deficient_lower >= 1/total
    return {
        'name': name, 'vertices': v, 'arcs': [list(e) for e in edges],
        'multiplicities': [int(z) for z in c], 'row_count': int(total),
        'dimension': v-1, 'budget': v,
        'features': [[int(z) for z in x.row(i)] for i in range(x.rows)],
        'labels': [int(z) for z in y], 'shift': [int(z) for z in a],
        'cycle_decomposition': cycles, 'hamiltonian_cycle': cycle,
        'symbolic_loss_identity_verified': True,
        'full_rank_excess_infimum': str(full_excess),
        'all_rank_deficient_excess_lower_bound': str(deficient_lower),
        'theorem_no_instance_gap': str(1/total),
        'full_support_check': verification,
        'full_rank_certificate': certificate,
        'scope': 'Exact finite checks; general theorem is a separate written proof.'
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path, required=True)
    args = parser.parse_args()
    cases = [
        ('directed_cycle_4', 4, [(0,1),(1,2),(2,3),(3,0)]),
        ('bidirected_star_4', 4,
         [(0,3),(3,0),(1,3),(3,1),(2,3),(3,2)]),
        ('bidirected_path_4', 4,
         [(0,1),(1,0),(1,2),(2,1),(2,3),(3,2)]),
        ('cycle_with_chords_4', 4,
         [(0,1),(1,2),(2,3),(3,0),(0,2),(2,0)]),
    ]
    results = [check_graph(*case) for case in cases]
    args.output.write_text(json.dumps({'status': 'exact_checks_passed', 'results': results},
                                      indent=2) + '\n')
    print(json.dumps({'status': 'exact_checks_passed', 'cases': len(results),
                      'full_rank_supports': sum(r['full_support_check']['supports']
                                                for r in results)}))


if __name__ == '__main__':
    main()
