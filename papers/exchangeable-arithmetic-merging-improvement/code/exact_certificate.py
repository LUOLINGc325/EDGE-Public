#!/usr/bin/env python3
"""Exact orbit budgets and an explicit strict-dominance witness."""

from fractions import Fraction as Q
from itertools import combinations_with_replacement, permutations, accumulate


def old_reject(values, units=1):
    return any(total >= length * units
               for length, total in enumerate(accumulate(values), 1))


def bonus(values, units=1):
    x, y, z = values[:3]
    return z >= units and 2*y+x >= 3*units and 2*(x+y+z) >= 5*units


def orbit_check(size, units):
    inv = 0
    for orbit in combinations_with_replacement(range(2*units+1), size):
        old = new = total = 0
        for order in permutations(orbit):
            before = old_reject(order, units)
            old += before
            new += before or bonus(order, units)
            total += 1
        assert old <= new
        assert new * size * units <= total * sum(orbit)
        if size == 3 and orbit[0] < units <= orbit[1] and sum(orbit) < 3 * units:
            possible = 2*sum(orbit) >= 5*units and 2*orbit[2]+orbit[0] >= 3*units
            assert old == 4 and new == 4 + possible
        inv += 1
    return inv


def arithmetic_prefix(values):
    answer = Q(1)
    for length in range(1, len(values)+1):
        total = 0
        for count, value in enumerate(sorted(values[:length]), 1):
            total += value
            if 2*count > length:
                answer = min(answer, 2*total / (2*count-length))
    return answer


def main():
    for size, units in ((3, 12), (4, 4), (5, 2)):
        print(f"K={size}, grid spacing=1/{units}: checked {orbit_check(size, units)} multisets")
    level = Q(1, 10)
    for size in (3, 4, 5, 12):
        values = ((level, level / 4, level / 2) + (level,) * (size-3))
        evidence = tuple(2*max(0, 1-p/level) for p in values)
        assert bonus(evidence) and not old_reject(evidence)
        assert arithmetic_prefix(values) == Q(7, 60)
        print(f"K={size}: original 7/60, improved 1/10")
    print("All checks used exact integer or rational arithmetic.")


if __name__ == "__main__":
    main()
