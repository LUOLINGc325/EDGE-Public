#!/usr/bin/env python3
"""Exact finite Bellman check allowing arbitrary adaptive interleaving of pairs."""
from functools import lru_cache
from fractions import Fraction as Q
import json


def verify(n, t):
    w = t * (t - 1)
    z = 2 * w + 1
    b = t * (2 * t - 1)
    points = [(Q(0), Q(1)), (Q(1), Q(0)), (t, t)]
    masses = [w / z, w / z, 1 / z]
    checked = 0

    def consistent(local):
        return [(point, p) for point, p in zip(points, masses)
                if all(value is None or point[i] == value for i, value in enumerate(local))]

    def local_value(local):
        observed = [value for value in local if value is not None]
        if not observed:
            return b / z
        if len(observed) == 2:
            return Q(1)
        return t if observed[0] == t else Q(1)

    @lru_cache(None)
    def value(state):
        nonlocal checked
        if all(all(v is not None for v in local) for local in state):
            best = Q(1)
        else:
            best = Q(0)
            for j, local in enumerate(state):
                feasible = consistent(local)
                total = sum(p for _, p in feasible)
                for coordinate in (0, 1):
                    if local[coordinate] is not None:
                        continue
                    conditional = {}
                    for point, mass in feasible:
                        x = point[coordinate]
                        conditional[x] = conditional.get(x, Q(0)) + mass / total
                    for fraction in (Q(0), Q(1)):
                        expectation = Q(0)
                        for x, mass in conditional.items():
                            updated_local = list(local)
                            updated_local[coordinate] = x
                            updated = list(state)
                            updated[j] = tuple(updated_local)
                            expectation += mass * (1 + fraction * (x - 1)) * value(tuple(updated))
                        best = max(best, expectation)
        product = Q(1)
        for local in state:
            product *= local_value(local)
        if best != product:
            raise RuntimeError(f'Bellman product failed: {state}: {best} != {product}')
        checked += 1
        return best

    initial = value(tuple((None, None) for _ in range(n)))
    return {'pairs': n, 't': str(t), 'partial_information_states_checked': checked,
            'optimal_expectation': str(initial), 'factorized_value': str((b/z)**n)}


def main():
    rows = [verify(n, t) for t in (Q(3), Q(5, 2)) for n in range(1, 5)]
    print(json.dumps({'status': 'PASS', 'arithmetic': 'fractions.Fraction',
                      'checks': rows,
                      'scope': 'Exact finite adaptive-order Bellman recursion; analytic proof handles arbitrary n.'}, indent=2))


if __name__ == '__main__':
    main()
