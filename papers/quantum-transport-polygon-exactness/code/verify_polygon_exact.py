#!/usr/bin/env python3
"""Exact finite checks for the polygon approximation theorem.

Uses only Python's standard library. These checks validate their finite inputs;
the universal theorem is established by the accompanying mathematical proofs.
No assert is used, so Python -O does not disable any check.
"""
from __future__ import annotations

import argparse
from fractions import Fraction as F
from itertools import combinations, permutations
import json
from pathlib import Path
import sys


def require(condition, message):
    if not condition:
        raise ValueError(message)


def cycle_deficit(a, cycle):
    return sum((a[i][j] if i > j else -a[i][j])
               for i, j in zip(cycle, cycle[1:] + cycle[:1]))


def cycles(n):
    for k in range(2, n + 1):
        for vertices in combinations(range(n), k):
            for tail in permutations(vertices[1:]):
                yield (vertices[0],) + tail


def polygon_value(a):
    n = len(a)
    best = F(0)
    witness = ()
    for k in range(3, n + 1):
        for chain in combinations(range(n), k):
            deficit = a[chain[0]][chain[-1]] - sum(a[i][j] for i, j in zip(chain, chain[1:]))
            if deficit / k > best:
                best = deficit / k
                witness = chain
    return best, witness


def check_assumptions_and_local_identities(a):
    n = len(a)
    counts = dict(superadditive=0, anti_monge=0, peak_lift=0, shortcut=0, curvature=0)
    for i in range(n):
        require(a[i][i] == 0, 'diagonal is not zero')
        for j in range(n):
            require(a[i][j] == a[j][i] and a[i][j] >= 0, 'array sign or symmetry')
    for i, j, k in combinations(range(n), 3):
        gain = a[i][k] - a[i][j] - a[j][k]
        require(gain >= 0, 'superadditivity')
        counts['superadditive'] += 1
        # Descending k -> j -> i and rising-net peak i -> k -> j.
        require(a[i][k] - (a[j][k] + a[i][j]) == gain, 'descending shortcut identity')
        require(-a[i][j] - (-a[i][k] + a[j][k]) == gain, 'peak shortcut identity')
        counts['shortcut'] += 2
    for w, u, v, maximum in combinations(range(n), 4):
        slack = a[w][maximum] + a[u][v] - a[w][v] - a[u][maximum]
        require(slack >= 0, 'anti-Monge')
        old = a[w][v] - a[u][v]
        new = a[w][maximum] - a[u][maximum]
        require(new - old == slack and new >= old, 'peak-lifting identity')
        counts['anti_monge'] += 1
        counts['peak_lift'] += 1
    # Independently verify the interval-curvature decomposition.
    weights = {}
    for u in range(1, n - 1):
        for v in range(u + 1, n):
            w = a[u - 1][v] - a[u][v] - a[u - 1][v - 1] + a[u][v - 1]
            require(w >= 0, 'negative interval curvature')
            weights[u, v] = w
    for i in range(n):
        for j in range(i + 1, n):
            recovered = sum(a[t][t + 1] for t in range(i, j))
            recovered += sum(w for (u, v), w in weights.items() if i < u < v <= j)
            require(recovered == a[i][j], 'interval reconstruction')
            counts['curvature'] += 1
    return counts


def check_split(a, cycle):
    maximum = max(cycle)
    count = 0
    for k, v in enumerate(cycle):
        u, w = cycle[k - 1], cycle[(k + 1) % len(cycle)]
        if not (w < u < v < maximum):
            continue
        walk = list(cycle)
        walk[k] = maximum
        positions = [t for t, x in enumerate(walk) if x == maximum]
        require(len(positions) == 2, 'lift does not create precisely two maxima')
        left, right = positions
        first = tuple(walk[left:right])
        second = tuple(walk[right:] + walk[:left])
        require(2 <= len(first) < len(cycle) and 2 <= len(second) < len(cycle), 'invalid split lengths')
        require(len(first) + len(second) == len(cycle), 'split length loss')
        require(len(set(first)) == len(first) and len(set(second)) == len(second), 'split cycles not simple')
        combined = cycle_deficit(a, first) + cycle_deficit(a, second)
        require(combined == cycle_deficit(a, tuple(walk)), 'split deficit identity')
        require(combined >= cycle_deficit(a, cycle), 'peak lift decreased deficit')
        count += 1
    return count


def construct_monotone_fit(a, delta):
    n = len(a)
    d = [F(0) for _ in range(n)]  # zero-cost super-source reaches each node
    for _ in range(n - 1):
        changed = False
        for i in range(n):
            for j in range(n):
                if i == j:
                    continue
                weight = delta + (a[i][j] if i < j else -a[i][j])
                if d[j] > d[i] + weight:
                    d[j] = d[i] + weight
                    changed = True
        if not changed:
            break
    for i in range(n):
        for j in range(n):
            if i != j:
                weight = delta + (a[i][j] if i < j else -a[i][j])
                require(d[j] <= d[i] + weight, 'negative cycle or incomplete shortest paths')
    z = []
    for value in d:
        z.append(max(z[-1], value) if z else value)
    base = z[0]
    z = [value - base for value in z]
    gaps = [z[i + 1] - z[i] for i in range(n - 1)]
    require(all(g >= 0 for g in gaps), 'running maximum is not monotone')
    error = F(0)
    for i in range(n):
        for j in range(i + 1, n):
            require(abs((d[j] - d[i]) - a[i][j]) <= delta, 'signed potential fit')
            require(abs((z[j] - z[i]) - a[i][j]) <= delta, 'running maximum damaged fit')
            reconstructed = sum(gaps[k] for k in range(i, j))
            require(reconstructed == z[j] - z[i], 'spectral prefix-cut reconstruction')
            error = max(error, abs(reconstructed - a[i][j]))
    require(error == delta, 'constructed approximation does not attain exact lower bound')
    return z


def power_array(points, q):
    return [[abs(x - y) ** q for y in points] for x in points]


def interval_array(n, mode):
    adjacent = [F((i + 1) % 4, 3) for i in range(n - 1)]
    weights = {}
    for u in range(1, n - 1):
        for v in range(u + 1, n):
            if mode == 0:
                value = F((u + 2 * v) % 5, 7)
            elif mode == 1:
                value = F(int(u == 1 and v == n - 1))
            else:
                value = F((u * v + 1) % 7, u + v)
            weights[u, v] = value
    a = [[F(0) for _ in range(n)] for _ in range(n)]
    for i in range(n):
        for j in range(i + 1, n):
            value = sum(adjacent[i:j]) + sum(w for (u, v), w in weights.items() if i < u < v <= j)
            a[i][j] = a[j][i] = value
    return a


def cases():
    for n in range(2, 8):
        sequences = [
            [F(k) for k in range(n)],
            [F(k * k) for k in range(n)],
            [F(k, k + 1) for k in range(n)],
            [F(v) for v in (0, 1, 5, 7, 14, 17, 26)[:n]],
        ]
        for index, points in enumerate(sequences):
            for q in (1, 2, 3, 5):
                yield f'power_n{n}_s{index}_q{q}', power_array(points, q)
        if n >= 3:
            for mode in range(3):
                yield f'interval_n{n}_mode{mode}', interval_array(n, mode)


def run(negative_control=False):
    summary = {
        'status': 'passed',
        'arithmetic': 'Python fractions.Fraction; no floating-point tolerances',
        'scope': 'Finite deterministic cases only; does not replace either universal proof',
        'case_count': 0,
        'simple_cycles_checked': 0,
        'peak_split_checks': 0,
        'local_identity_counts': {},
        'negative_control': bool(negative_control),
        'case_results': [],
    }
    for label, a in cases():
        counts = check_assumptions_and_local_identities(a)
        for key, count in counts.items():
            summary['local_identity_counts'][key] = summary['local_identity_counts'].get(key, 0) + count
        delta, chain = polygon_value(a)
        maximum = F(0)
        cycle_witness = ()
        cycle_count = split_count = 0
        for cycle in cycles(len(a)):
            value = cycle_deficit(a, cycle) / len(cycle)
            if value > maximum:
                maximum, cycle_witness = value, cycle
            split_count += check_split(a, cycle)
            cycle_count += 1
        tested_delta = delta
        if negative_control and delta > 0:
            tested_delta -= F(1, 97)
        require(maximum == tested_delta, f'cycle/polygon mismatch in {label}: {maximum} != {tested_delta}')
        fit = construct_monotone_fit(a, delta)
        summary['case_count'] += 1
        summary['simple_cycles_checked'] += cycle_count
        summary['peak_split_checks'] += split_count
        summary['case_results'].append({
            'case': label,
            'n': len(a),
            'polygon_value': str(delta),
            'maximum_cycle_mean': str(maximum),
            'polygon_witness': chain,
            'cycle_witness': cycle_witness,
            'monotone_fit': [str(v) for v in fit],
        })
    return summary


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path)
    parser.add_argument('--negative-control', action='store_true')
    args = parser.parse_args()
    try:
        result = run(args.negative_control)
        code = 0
    except (ValueError, ArithmeticError) as exc:
        result = {'status': 'failed', 'negative_control': args.negative_control, 'error': str(exc)}
        code = 1
    rendered = json.dumps(result, indent=2, sort_keys=True) + '\n'
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered, encoding='utf-8')
    print(json.dumps({k: v for k, v in result.items() if k != 'case_results'}, indent=2, sort_keys=True))
    return code


if __name__ == '__main__':
    raise SystemExit(main())
