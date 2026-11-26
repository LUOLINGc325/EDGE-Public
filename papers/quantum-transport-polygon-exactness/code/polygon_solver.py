#!/usr/bin/env python3
"""Exact rational implementation of the manuscript's cubic algorithm.

The theorem covers real arrays. This implementation accepts rational arrays
or rational spectral points with an integer exponent, and never rounds them.
"""
from __future__ import annotations

import argparse
from fractions import Fraction as F
from itertools import combinations
import json
from pathlib import Path


def require(condition, message):
    if not condition:
        raise ValueError(message)


def check_structure(a):
    n = len(a)
    require(n > 0 and all(len(row) == n for row in a), 'nonempty square array required')
    for i in range(n):
        require(a[i][i] == 0, 'diagonal must be zero')
        for j in range(n):
            require(a[i][j] == a[j][i] and a[i][j] >= 0, 'nonnegative symmetric array required')
    # Adjacent discrete curvatures plus nonnegative adjacent distances imply
    # all (S) and (M) inequalities by the interval decomposition. This costs
    # O(n^2), unlike explicitly checking every four-point inequality.
    for u in range(1, n - 1):
        for v in range(u + 1, n):
            curvature = a[u-1][v] - a[u][v] - a[u-1][v-1] + a[u][v-1]
            require(curvature >= 0, f'negative interval curvature at {(u, v)}')


def optimal_polygon(a):
    """Return the endpoint DP optimum and an increasing-chain witness."""
    n = len(a)
    if n == 1:
        return F(0), [0]
    values = [[None] * n for _ in range(n)]
    parents = [[None] * n for _ in range(n)]
    values[0][0] = F(0)
    best, best_edges = F(0), 1
    for k in range(1, n):
        for j in range(k, n):
            for i in range(k-1, j):
                previous = values[k-1][i]
                if previous is None:
                    continue
                candidate = previous + a[i][j]
                if values[k][j] is None or candidate < values[k][j]:
                    values[k][j] = candidate
                    parents[k][j] = i
        deficit = (a[0][n-1] - values[k][n-1]) / (k+1)
        if deficit > best:
            best, best_edges = deficit, k
    chain = [n-1]
    j = n-1
    for k in range(best_edges, 0, -1):
        j = parents[k][j]
        require(j is not None, 'missing DP predecessor')
        chain.append(j)
    return best, list(reversed(chain))


def monotone_potential(a, delta):
    n = len(a)
    z = [F(0)] * n
    for _ in range(n-1):
        changed = False
        for i in range(n):
            for j in range(n):
                if i == j:
                    continue
                weight = delta + (a[i][j] if i < j else -a[i][j])
                candidate = z[i] + weight
                if candidate < z[j]:
                    z[j] = candidate
                    changed = True
        if not changed:
            break
    for i in range(n):
        for j in range(n):
            if i != j:
                weight = delta + (a[i][j] if i < j else -a[i][j])
                require(z[j] <= z[i] + weight, 'negative cycle or incomplete Bellman-Ford')
    y = []
    for value in z:
        y.append(max(y[-1], value) if y else value)
    return [value-y[0] for value in y]


def verify_certificate(a, delta, chain, y):
    """O(n^2) certificate check; independent of DP or shortest-path internals."""
    n = len(a)
    require(delta >= 0 and len(y) == n, 'invalid certificate shape')
    require(all(y[i] <= y[i+1] for i in range(n-1)), 'potential is not monotone')
    actual = max((abs(y[j]-y[i]-a[i][j]) for i in range(n) for j in range(i+1,n)), default=F(0))
    require(actual <= delta, 'upper-bound certificate failed')
    if n == 1:
        require(delta == 0 and chain == [0], 'singleton convention failed')
        return
    require(len(chain) >= 2 and all(0 <= i < n for i in chain), 'invalid chain')
    require(all(i < j for i,j in zip(chain,chain[1:])), 'chain is not increasing')
    numerator = a[chain[0]][chain[-1]] - sum(a[i][j] for i,j in zip(chain,chain[1:]))
    require(numerator / len(chain) == delta, 'lower-bound certificate failed')


def solve(array):
    a = [[F(value) for value in row] for row in array]
    check_structure(a)
    delta, chain = optimal_polygon(a)
    y = monotone_potential(a, delta)
    verify_certificate(a, delta, chain, y)
    return {
        'n': len(a),
        'delta': str(delta),
        'polygon_indices': chain,
        'potential': [str(value) for value in y],
        'tail_cut_weights': [str(y[i+1]-y[i]) for i in range(len(y)-1)],
        'arithmetic': 'exact rational',
        'certificate_verified': True,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    source = parser.add_mutually_exclusive_group(required=True)
    source.add_argument('--points', nargs='+', help='strictly increasing rational numbers')
    source.add_argument('--array', type=Path, help='JSON square matrix of rational strings or integers')
    parser.add_argument('--q', type=int, default=2, help='integer exponent for --points, at least 1')
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    if args.points:
        points = list(map(F, args.points))
        require(args.q >= 1, 'integer q must be at least 1')
        require(all(x < y for x,y in zip(points,points[1:])), 'points must be strictly increasing')
        array = [[abs(x-y)**args.q for y in points] for x in points]
    else:
        array = json.loads(args.array.read_text(encoding='utf-8'))
        require(all(isinstance(x,(str,int)) for row in array for x in row), 'use strings for noninteger rationals')
    result = solve(array)
    rendered = json.dumps(result, indent=2, sort_keys=True) + '\n'
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered, encoding='utf-8')
    print(rendered, end='')


if __name__ == '__main__':
    main()
