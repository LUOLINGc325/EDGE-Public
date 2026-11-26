#!/usr/bin/env python3
"""Compare the finite-stake criterion against an exact two-cap frontier."""

from fractions import Fraction as F
from itertools import accumulate, product


P = (F(1, 4), F(3, 8), F(3, 8))
TIED_RATIOS = (F(1, 2), F(7, 6), F(7, 6))
DISTINCT_RATIOS = (F(1, 2), F(1), F(4, 3))


def expectation(masses, values):
    return sum(mass * value for mass, value in zip(masses, values, strict=True))


def fill_power(size, width, ordered_ratios, ordered_masses):
    power = F(0)
    for ratio, mass in zip(ordered_ratios, ordered_masses, strict=True):
        allocation = min(size, width * mass)
        power += ratio * allocation
        size -= allocation
    return power


def size_for_power(power, width, ordered_ratios, ordered_masses):
    size = F(0)
    for ratio, mass in zip(ordered_ratios, ordered_masses, strict=True):
        allocation = min(power, width * mass * ratio)
        size += allocation / ratio
        power -= allocation
    assert power == 0
    return size


def capped(q, evidence, caps):
    return tuple(expectation(q, (min(e, cap) for e in evidence)) for cap in caps)


def predicts_admissible(evidence, caps, ratios, q, ordered_ratios, ordered_masses):
    if expectation(P, evidence) != 1:
        return False
    for lo, hi in zip((0, caps[0]), caps, strict=True):
        increments = tuple(min(max(e - lo, 0), hi - lo) for e in evidence)
        size = expectation(P, increments)
        actual = expectation(q, increments)
        if actual != fill_power(size, hi - lo, ordered_ratios, ordered_masses):
            return False
    for ratio in set(ratios):
        tied = tuple(e for e, r in zip(evidence, ratios, strict=True) if r == ratio)
        if any(min(tied) < cap < max(tied) for cap in caps):
            return False
    return True


def frontier_dominates(target, caps, ordered_ratios, ordered_masses):
    # At a fixed first-slot null allocation u, maximize each slot independently.
    # The remaining null budget for the second slot is 1-u.
    a, b = caps
    required = size_for_power(target[0], a, ordered_ratios, ordered_masses)
    upper = min(a, 1)
    breakpoints = {required, upper}
    for mass in accumulate(ordered_masses):
        for point in (a * mass, 1 - (b - a) * mass):
            if required <= point <= upper:
                breakpoints.add(point)
    # The required first cap already holds throughout this reduced domain.
    # Both frontier coordinates are affine between successive breakpoints.
    for size in breakpoints:
        first = fill_power(size, a, ordered_ratios, ordered_masses)
        total = first + fill_power(1 - size, b - a, ordered_ratios, ordered_masses)
        if total >= target[1] and (first > target[0] or total > target[1]):
            return True
    return False


def verify_grid(ratios, caps, scale):
    q = tuple(p * ratio for p, ratio in zip(P, ratios, strict=True))
    ordered_ratios, ordered_masses = zip(*sorted(zip(ratios, P, strict=True), reverse=True))
    feasible = 0
    admissible = 0
    grid = tuple(F(j, scale) for j in range(int(caps[1] * scale) + 1))
    for evidence in product(grid, repeat=len(P)):
        if expectation(P, evidence) > 1:
            continue
        feasible += 1
        expected = predicts_admissible(evidence, caps, ratios, q, ordered_ratios, ordered_masses)
        observed = not frontier_dominates(capped(q, evidence, caps), caps, ordered_ratios, ordered_masses)
        assert expected == observed, (ratios, caps, evidence, expected, observed)
        admissible += observed
    return feasible, admissible


def verify_witnesses():
    q = tuple(p * ratio for p, ratio in zip(P, TIED_RATIOS, strict=True))
    tied = (F(0), F(2), F(2, 3))
    straddling = (F(0), F(0), F(8, 3))
    unsorted = (F(2), F(2, 3), F(2, 3))
    averaged = (F(0), F(4, 3), F(4, 3))
    assert all(expectation(P, e) == 1 for e in (tied, straddling, unsorted, averaged))
    assert capped(q, tied, (2, 3)) == (F(7, 6), F(7, 6))
    assert capped(q, averaged, (1, 3)) == (F(7, 8), F(7, 6))
    assert capped(q, straddling, (1, 3)) == (F(7, 16), F(7, 6))
    assert capped(q, unsorted, (2, 3)) == (F(5, 6), F(5, 6))
    return "Exact witnesses: tied admissible power 7/6; straddling gain 7/16; nonoptimal loss 1/3."


def main():
    total = 0
    for ratios, name in ((TIED_RATIOS, "tied"), (DISTINCT_RATIOS, "distinct")):
        for caps in ((F(1), F(3)), (F(2), F(3)), (F(1, 2), F(3, 2))):
            feasible, admissible = verify_grid(ratios, caps, 6)
            print(f"{name}, caps {','.join(map(str, caps))}: {feasible} feasible, {admissible} admissible.")
            total += feasible
    print(verify_witnesses())
    print(f"All {total} frontier comparisons passed.")


if __name__ == "__main__":
    main()
