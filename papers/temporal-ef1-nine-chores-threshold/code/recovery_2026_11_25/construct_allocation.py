#!/usr/bin/env python3
"""Exact rational TEF1 construction for three agents and at most eight chores.

The finite search implements the proved covering family. It does not prove
universal coverage by itself. Accept integers or rational strings; reject floats.
"""
from fractions import Fraction
from itertools import permutations, product
import argparse
import json
from pathlib import Path


def exact(x):
    if isinstance(x, bool) or not isinstance(x, (int, str, Fraction)):
        raise TypeError('Costs must be integers or exact rational strings')
    return Fraction(x)


def normalize(costs):
    if len(costs) != 3 or len({len(row) for row in costs}) != 1:
        raise ValueError('Expected three equally long cost rows')
    if len(costs[0]) > 8:
        raise ValueError('This constructor covers at most eight chores')
    c = tuple(tuple(exact(x) for x in row) for row in costs)
    if any(x < 0 for row in c for x in row):
        raise ValueError('Costs must be nonnegative')
    return c


def failures(costs, path):
    """Direct definition, independent of the SMT input or certificate."""
    bad = []
    for t in range(len(path) + 1):
        bundles = [[k for k in range(t) if path[k] == i] for i in range(3)]
        for i, own in enumerate(bundles):
            for j, other in enumerate(bundles):
                if i == j:
                    continue
                rhs = sum(costs[i][k] for k in other)
                # The empty bundle satisfies EF1 with no deletion.
                lhs = [sum(costs[i][k] for k in own if k != r) for r in own] or [0]
                if min(lhs) > rhs:
                    bad.append((t, i, j))
    return bad


def construct(costs):
    costs = normalize(costs)
    m = len(costs[0])
    padded = tuple(row + (Fraction(0),) * (8 - m) for row in costs)
    considered = 0
    for first in permutations(range(3)):
        for tail in product(range(3), repeat=4):
            path = first + tail
            considered += 1
            if failures(padded, path):
                continue
            bundles = [[k for k in range(7) if path[k] == i] for i in range(3)]
            for u in range(3):
                own = sum(padded[u][k] for k in bundles[u])
                if all(own <= sum(padded[u][k] for k in b) for b in bundles):
                    result = (path + (u,))[:m]
                    if failures(costs, result):
                        raise AssertionError('Direct output validation failed')
                    return {'assignment': result, 'chores': m,
                            'seven_step_paths_considered': considered,
                            'direct_prefix_validation': 'pass'}
    raise AssertionError('No covering-family witness found; do not silently fall back')


def main():
    p = argparse.ArgumentParser()
    p.add_argument('input', type=Path, help='JSON containing three cost rows')
    p.add_argument('--output', type=Path)
    args = p.parse_args()
    result = construct(json.loads(args.input.read_text()))
    text = json.dumps(result, indent=2) + '\n'
    if args.output:
        args.output.write_text(text)
    print(text, end='')


if __name__ == '__main__':
    main()
