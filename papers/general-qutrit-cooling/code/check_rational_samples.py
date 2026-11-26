#!/usr/bin/env python3
"""Cross-check the projector inequalities directly at exact rational states."""
from collections import defaultdict
from fractions import Fraction
from itertools import combinations_with_replacement, permutations, product
from math import gcd


def configurations(p, q):
    shells = defaultdict(list)
    for x, y in product(range(3), repeat=2):
        shells[p[x] * q[y]].append(3 * x + y)
    groups = list(shells.values())
    for cells in product(*(permutations(group) for group in groups)):
        feed = dict(
            (target, source)
            for targets, sources in zip(groups, cells)
            for target, source in zip(targets, sources)
        )
        yield [feed[index] % 3 for index in range(9)]


def q_values(p, preserve_reference):
    ratios = sorted({source / target for source, target in product(p, repeat=2)})
    patterns = set()
    for a, b in combinations_with_replacement(ratios, 2):
        values = (Fraction(1), a, b)
        if not preserve_reference:
            values = tuple(sorted(item / max(values) for item in values))
        normalization = sum(values)
        patterns.add(tuple(item / normalization for item in values))
    return patterns


def variance_difference(p, q, feed, psi):
    answer = Fraction(0)
    for x in range(3):
        delta = [psi[feed[3 * x + y]] - psi[y] for y in range(3)]
        mean = sum(weight * value for weight, value in zip(q, delta))
        second = sum(weight * value ** 2 for weight, value in zip(q, delta))
        answer += p[x] * (2 * second - 3 * mean ** 2)
    return answer


def verify_state(u, v, preserve_reference=False):
    p = (1, u, u * v)
    p = tuple(item / sum(p) for item in p)
    count = 0
    for q in q_values(p, preserve_reference):
        for feed in configurations(p, q):
            first = variance_difference(p, q, feed, (0, 1, 0))
            second = variance_difference(p, q, feed, (0, 0, 1))
            polarized = variance_difference(p, q, feed, (0, 1, 1)) - first - second
            assert first >= 0 and second >= 0 and 4 * first * second >= polarized ** 2
            count += 1
    return count


def main():
    if not __debug__:
        raise RuntimeError("Run with assertions enabled")
    count = verify_state(Fraction(1, 2), Fraction(1, 3), preserve_reference=True)
    print(f"generic rational point: {count} permutations")
    assert count == 582
    total = count
    t = Fraction(2, 3)
    rays = [(0, 1), (1, 0)] + [
        (a, b) for a, b in product(range(1, 4), repeat=2) if gcd(a, b) == 1
    ]
    for a, b in rays:
        count = verify_state(t ** a, t ** b)
        print(f"rational point on ray {(a, b)}: {count} permutations")
        total += count
    assert total == 14382
    print(f"rational-parameter cross-check total: {total} permutations")


if __name__ == "__main__":
    main()
