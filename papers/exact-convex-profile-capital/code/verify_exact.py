"""Certify selected finite-grid optima and adaptive Bellman values in rational arithmetic."""

from fractions import Fraction
from functools import lru_cache
from itertools import product
import json

import numpy as np
from scipy.optimize import linprog


def flat_target(x, y, a, radius):
    u, v = x - 1, y - 1
    return 1 + a * (u * max(radius, abs(v)) + v * max(radius, abs(u)))


def stake_payoffs(grid):
    points = list(product(grid, repeat=2))
    columns = []
    for first, initial_stake in product(range(2), repeat=2):
        for remaining_stakes in product(range(2), repeat=len(grid)):
            decision = dict(zip(grid, remaining_stakes))
            columns.append([
                (1 + initial_stake * (point[first] - 1))
                * (1 + decision[point[first]] * (point[1 - first] - 1))
                for point in points
            ])
    return points, columns


def certify_lp(grid, a, radius):
    points, columns = stake_payoffs(grid)
    target = [flat_target(x, y, a, radius) for x, y in points]
    matrix = np.array(columns, dtype=float).T
    solution = linprog(np.ones(len(columns)), A_ub=-matrix, b_ub=-np.array(target, dtype=float))
    if not solution.success:
        raise RuntimeError(solution.message)
    primal = [Fraction(float(value)).limit_denominator(10**8) for value in solution.x]
    dual = [Fraction(float(-value)).limit_denominator(10**8) for value in solution.ineqlin.marginals]
    assert min(primal) >= 0 and min(dual) >= 0
    assert all(sum(primal[j] * column[i] for j, column in enumerate(columns)) >= value
               for i, value in enumerate(target))
    assert all(sum(weight * payoff for weight, payoff in zip(dual, column)) <= 1
               for column in columns)
    cost = sum(primal)
    assert cost == sum(weight * payoff for weight, payoff in zip(dual, target))
    total = sum(dual)
    law = {point: weight / total for point, weight in zip(points, dual) if weight}
    return cost, law


def bellman(law):
    @lru_cache(maxsize=None)
    def visit(state):
        active = [(point, weight) for point, weight in law.items()
                  if all(seen is None or point[i] == seen for i, seen in enumerate(state))]
        mass = sum(weight for _, weight in active)
        if all(seen is not None for seen in state):
            return Fraction(1)
        returns = []
        for index, seen in enumerate(state):
            if seen is not None:
                continue
            outcomes = {}
            for point, weight in active:
                value = point[index]
                outcomes[value] = outcomes.get(value, Fraction(0)) + weight
            for stake in (0, 1):
                returns.append(sum(
                    weight / mass * (1 + stake * (value - 1))
                    * visit(state[:index] + (value,) + state[index + 1:])
                    for value, weight in outcomes.items()
                ))
        return max(returns)

    return visit((None,) * len(next(iter(law))))


def main():
    profiles = [(Fraction(1, 2), Fraction(3, 4)), (Fraction(2, 5), Fraction(1, 4))]
    out = {"finite_optimality": [], "adaptive_product": []}
    block_laws = []
    for a, radius in profiles:
        optimum = 1 + a * (1 - radius) * max(1, 2 * radius)
        grid_base = {Fraction(1), 1 - radius}
        if radius <= Fraction(1, 2):
            grid_base.add(Fraction(0))
        for t in (8, 64, 256):
            grid = sorted(grid_base | {Fraction(1 + t)})
            cost, law = certify_lp(grid, a, radius)
            value = bellman(law)
            expected_target = sum(weight * flat_target(*point, a, radius) for point, weight in law.items())
            assert 1 <= cost <= optimum and cost >= optimum - Fraction(4, t)
            assert expected_target / value == cost
            out["finite_optimality"].append({
                "a": str(a), "radius": str(radius), "t": t,
                "exact_finite_cost": str(cost), "exact_full_cost": str(optimum),
                "dual_support": len(law)
            })
            if t == 64:
                block_laws.append((law, expected_target, value, cost))

    (law1, target1, value1, cost1), (law2, target2, value2, cost2) = block_laws
    joint = {x + y: wx * wy for x, wx in law1.items() for y, wy in law2.items()}
    joint_value = bellman(joint)
    assert joint_value == value1 * value2
    assert target1 * target2 / joint_value == cost1 * cost2
    out["adaptive_product"].append({
        "adaptive_bellman_value": str(joint_value), "exact_grid_product_cost": str(cost1 * cost2),
        "support_size": len(joint)
    })
    out["scope"] = "LP candidates are verified over the rationals. The full-domain proof appears in the manuscript."
    print(json.dumps(out, indent=2))


if __name__ == "__main__":
    main()
