#!/usr/bin/env python3
"""Check finite budgets and the reversed-prefix witness in exact arithmetic."""

from fractions import Fraction as F
from itertools import product


def expectation(masses, evidence):
    return sum(p * e for p, e in zip(masses, evidence, strict=True))


def capped(masses, evidence, caps):
    return tuple(expectation(masses, [min(e, t) for e in evidence]) for t in caps)


def check_grid(p, q, evidence, caps, scale):
    assert expectation(p, evidence) == 1
    target = capped(q, evidence, caps)
    budgets = 0
    equal = 0
    grids = [range(int(scale / mass) + 1) for mass in p]
    for numerators in product(*grids):
        alternative = tuple(F(k, scale) for k in numerators)
        if expectation(p, alternative) > 1:
            continue
        budgets += 1
        moments = capped(q, alternative, caps)
        if all(new >= old for new, old in zip(moments, target, strict=True)):
            assert moments == target
            equal += 1
    assert equal >= 1
    return budgets, equal


def check_order_reversal():
    boundaries = (F(0), F(1, 2), F(5, 8), F(3, 4), F(7, 8), F(1))
    p = tuple(v - u for u, v in zip(boundaries[:-1], boundaries[1:], strict=True))
    q = tuple(
        (v - u) * (1 + v + u) / 2
        for u, v in zip(boundaries[:-1], boundaries[1:], strict=True)
    )
    evidence = (F(0), F(1), F(1), F(1), F(5))
    alternate = (F(0), F(1, 2), F(1), F(3, 2), F(5))
    caps = tuple(map(F, (2, 4, 5, 8)))
    assert expectation(p, evidence) == expectation(p, alternate) == 1
    assert sum(p) == sum(q) == 1
    differences = tuple(
        new - old
        for new, old in zip(capped(q, alternate, caps), capped(q, evidence, caps), strict=True)
    )
    assert differences == (F(1, 64),) * 4
    return differences


def main():
    p = (F(3, 4), F(1, 4))
    q = (F(1, 2), F(1, 2))
    tests = ((F(1, 3), F(1)), (F(0), F(1, 2)))
    assert tuple(expectation(p, phi) for phi in tests) == (F(1, 2), F(1, 8))
    evidence = tuple(left + 4 * right for left, right in zip(*tests, strict=True))
    assert evidence == (F(1, 3), F(3))
    caps = (F(1), F(2), F(5), F(8))
    assert all(e not in caps for e in evidence)
    budgets, equal = check_grid(p, q, evidence, caps, 60)
    print(f"Randomized cutoff mixture: {budgets} feasible competitor budgets, {equal} equal.")
    p = (F(1, 2), F(1, 4), F(1, 4))
    q = (F(1, 4), F(1, 4), F(1, 2))
    budgets, equal = check_grid(p, q, (F(0), F(1), F(3)), (F(1), F(2), F(3)), 8)
    print(f"Compatible sharp case: {budgets} feasible competitor budgets, {equal} equal.")
    print("Reversed-order gains:", ", ".join(map(str, check_order_reversal())))
    print("All checks passed.")


if __name__ == "__main__":
    main()
