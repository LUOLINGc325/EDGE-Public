#!/usr/bin/env python3
"""Enumerate rational primal and dual vertices on two-coordinate grids."""

from fractions import Fraction as F
from itertools import combinations, product


def dot(coefficients, values):
    return sum(a*b for a, b in zip(coefficients, values, strict=True))


def solve(equations):
    n = len(equations)
    rows = [list(a) + [b] for a, b in equations]
    for i in range(n):
        k = next((j for j in range(i, n) if rows[j][i]), None)
        if k is None:
            return None
        rows[i], rows[k] = rows[k], rows[i]
        pivot = rows[i][i]
        rows[i] = [x/pivot for x in rows[i]]
        for j in range(n):
            if j != i:
                factor = rows[j][i]
                rows[j] = [a-factor*b for a, b in zip(rows[j], rows[i], strict=True)]
    return tuple(row[-1] for row in rows)


def canonical(n, i, sign=1):
    return tuple(F(sign if j == i else 0) for j in range(n))


def primal_vertices(a, b):
    xs, ys = (F(0), a), (F(0), b)
    points = tuple(product(xs, ys))
    inequalities = []
    for i, context in ((0, ys), (1, xs)):
        for y in context:
            inequalities.append(tuple((point[i]-1) if point[1-i] == y else F(0) for point in points))
    inequalities.extend(canonical(4, i, -1) for i in range(4))
    zero_constraints = [(row, F(0)) for row in inequalities]
    normalization = ((F(1),)*4, F(1))
    vertices = set()
    for active in combinations(zero_constraints, 3):
        p = solve((*active, normalization))
        if p is not None and all(dot(row, p) <= 0 for row in inequalities):
            vertices.add(p)
    assert vertices
    return points, vertices


def penalty_row(x, y, a, b):
    return (F(1), x-1 if y != b else F(0), x-1 if y == b else F(0),
            y-1 if x != a else F(0), y-1 if x == a else F(0))


def dual_optimum(points, payoff, a, b):
    inequalities = [(penalty_row(x, y, a, b), p) for (x, y), p in zip(points, payoff, strict=True)]
    inequalities.extend((canonical(5, i), F(0)) for i in range(1, 5))
    candidates = []
    for active in combinations(inequalities, 5):
        variables = solve(active)
        if variables is not None and all(dot(row, variables) >= target for row, target in inequalities):
            candidates.append(variables)
    assert candidates
    return min(candidates)


def main():
    total = 0
    payoff_patterns = tuple(product((F(0), F(1)), repeat=4))
    grid_values = (F(1, 2), F(3, 2), F(2), F(4))
    for a, b in product(grid_values, repeat=2):
        points, vertices = primal_vertices(a, b)
        for payoff in payoff_patterns:
            primal = max(dot(payoff, p) for p in vertices)
            dual = dual_optimum(points, payoff, a, b)
            assert primal == dual[0]
            assert max(dual[1:]) <= primal*(1+2*max(a, b))
            assert dual[1] <= primal and dual[3] <= primal
            assert dual[2] <= primal*(1+max(b-1, 0))
            assert dual[4] <= primal*(1+max(a-1, 0))
            rewards = dict(zip(points, payoff, strict=True))
            for x, y in product((F(1, 7), a, a+1), (F(1, 9), b, b+1)):
                tx = x if x == a else F(0)
                ty = y if y == b else F(0)
                lifted = dual[0] + dual[1+(ty==b)]*(x-1) + dual[3+(tx==a)]*(y-1)
                assert lifted >= rewards.get((x, y), 0)
            total += 1
    print(f"Exact primal/dual grid comparisons with bounded multiplier and extension checks: {total}.")
    print("All checks passed.")


if __name__ == "__main__":
    main()
