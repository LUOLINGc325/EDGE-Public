#!/usr/bin/env python3
"""Exact arithmetic checks for the independently derived sharp efficiency theorem.

Only Python's standard library is used. Finite calculations are supplemental to
the universal analytic proofs in manuscript/manuscript.en.md, Sections 3-4.
"""
from fractions import Fraction as Q
import json


def positive(x):
    return max(x, Q(0))


def target(x, y, lam):
    return 1 + lam * (positive(x - 1) * positive(y - 1)
                      - positive(1 - x) * positive(1 - y))


def second_fraction(x, lam):
    return 2 * lam * positive(x - 1) / (2 - lam + 2 * lam * x)


def attaining_merger(x, y, lam):
    first = 2 * lam / (2 + lam)
    xy = (1 + first * (x - 1)) * (1 + second_fraction(x, lam) * (y - 1))
    yx = (1 + first * (y - 1)) * (1 + second_fraction(y, lam) * (x - 1))
    return (xy + yx) / 2


def formula_merger(x, y, lam):
    a = lam / (2 + lam)
    u, v = x - 1, y - 1
    return 1 + a * (u + v) + a * (positive(u) * v + positive(v) * u)


def difference_formula(x, y, lam):
    a = lam / (2 + lam)
    u, v = x - 1, y - 1
    if u >= 0 and v >= 0:
        return a * (1 + u + v)
    if u >= 0:
        return a * (1 + v) * (1 + u)
    if v >= 0:
        return a * (1 + u) * (1 + v)
    b, d = -u, -v
    return a * ((1 - b) * (1 - d) + b * d)


def finite_cost(t, lam):
    return max(Q(1), (1 + lam * (t - 1) ** 2 + 2 * t * (t - 1))
               / (t * (2 * t - 1)))


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def main():
    grid = [Q(0), Q(1, 7), Q(1, 2), Q(9, 10), Q(1), Q(11, 10),
            Q(3, 2), Q(2), Q(3), Q(10), Q(100)]
    lambdas = [Q(1, 100), Q(1, 10), Q(1, 3), Q(1, 2), Q(3, 4), Q(1)]
    point_checks = 0
    for lam in lambdas:
        c = 2 / (2 + lam)
        for x in grid:
            require(0 <= second_fraction(x, lam) <= 1, 'fraction outside [0,1]')
            for y in grid:
                actual = attaining_merger(x, y, lam)
                formula = formula_merger(x, y, lam)
                require(actual == formula, 'strategy and formula differ')
                diff = actual - c * target(x, y, lam)
                require(diff == difference_formula(x, y, lam), 'quadrant identity failed')
                require(diff >= 0 and target(x, y, lam) >= 0, 'majorization failed')
                point_checks += 1

    # Every deterministic strategy on the three queried points has arbitrary
    # a,g(1),g(t) in [0,1]; the witness is multi-affine in these parameters.
    # Enumerating all vertices exactly thus independently checks its maximum.
    ts = [Q(3, 2), Q(2), Q(3), Q(4), Q(10), Q(101)]
    vertex_checks = 0
    for t in ts:
        for a in [Q(0), Q(1)]:
            for g_one in [Q(0), Q(1)]:
                for g_t in [Q(0), Q(1)]:
                    # Order x then y; the reverse swaps the two axis terms.
                    at_01 = 1 - a
                    at_10 = 1 - g_one
                    at_tt = (1 + a * (t - 1)) * (1 + g_t * (t - 1))
                    lhs = at_tt + t * (t - 1) * (at_01 + at_10)
                    require(lhs <= t * (2 * t - 1), 'finite witness failed')
                    vertex_checks += 1

    costs = []
    for lam in lambdas:
        for t in ts:
            cost = finite_cost(t, lam)
            q = 2 * (cost - 1) / cost
            require(0 <= q <= 1, 'finite-cost first fraction invalid')
            axis = cost * (1 - q) / 2 + cost / 2
            diag = cost * t * (1 + q * (t - 1))
            require(axis == 1, 'finite-cost axis not exact')
            require(diag >= target(t, t, lam), 'finite-cost diagonal insufficient')
            if cost > 1:
                require(diag == target(t, t, lam), 'finite-cost diagonal not exact')
            require(cost <= 1 + lam / 2, 'finite cost exceeds limiting optimum')
            costs.append({'lambda': str(lam), 't': str(t), 'capital': str(cost)})

    require(finite_cost(Q(3), Q(1)) == Q(17, 15), '17/15 certificate failed')
    witness_target = target(Q(3), Q(3), Q(1)) + 6 * (target(Q(0), Q(1), Q(1))
                                                               + target(Q(1), Q(0), Q(1)))
    require(witness_target == 17, 'target witness not 17')
    print(json.dumps({
        'status': 'PASS',
        'arithmetic': 'fractions.Fraction (exact rational)',
        'attainment_and_quadrant_point_checks': point_checks,
        'finite_witness_parameter_vertices_checked': vertex_checks,
        'finite_superhedging_costs_checked': len(costs),
        'three_point_witness': {'t': '3', 'lambda': '1', 'generalized_bound': '15',
                                'target_value': '17', 'sharp_capital': '17/15'},
        'whole_domain_sharp_efficiency': '2/(2+lambda)',
        'whole_domain_sharp_capital': '1+lambda/2',
        'cost_table': costs,
        'scope': 'Supplementary finite exact checks; universal claims proved analytically; not Lean.'
    }, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
