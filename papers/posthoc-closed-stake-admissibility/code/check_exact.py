#!/usr/bin/env python3
"""Check the accumulating-stake examples on exact capped profiles."""

from fractions import Fraction as F
from itertools import product


P = (F(1, 4), F(3, 8), F(3, 8))
ALLOWED_LOW = F(1, 2)
ALLOWED_HIGH = F(5, 2)


def expectation(masses, values):
    return sum(p * value for p, value in zip(masses, values, strict=True))


def capped(q, evidence, stake):
    return expectation(q, [min(stake, e) for e in evidence])


def relevant_caps(base, candidate):
    # On the continuous portions of S, extrema occur at endpoints or evidence knots.
    evidence_knots = set(base + candidate)
    caps = {F(0), ALLOWED_LOW, ALLOWED_HIGH}
    caps.update(e for e in evidence_knots if e <= ALLOWED_LOW or e >= ALLOWED_HIGH)
    # Below the smallest evidence knot above 1/2 the profile difference is affine.
    # Retain only the first dyadic cap below that knot and the accumulation point.
    cutoff = min((e for e in evidence_knots if e > ALLOWED_LOW), default=F(1))
    dyadic = F(1, 2)
    while True:
        cap = ALLOWED_LOW + dyadic
        caps.add(cap)
        if cap < cutoff:
            break
        dyadic /= 2
    return caps


def profile_test(q, base, candidate):
    differences = tuple(
        capped(q, candidate, cap) - capped(q, base, cap)
        for cap in relevant_caps(base, candidate)
    )
    return min(differences), max(differences)


def verify_grid(q, base, should_have_dominator):
    scale = 6
    ranges = [range(int(scale / p) + 1) for p in P]
    checked = 0
    strict_dominators = 0
    for indices in product(*ranges):
        candidate = tuple(F(i, scale) for i in indices)
        if expectation(P, candidate) > 1:
            continue
        checked += 1
        minimum, maximum = profile_test(q, base, candidate)
        if minimum >= 0 and maximum > 0:
            strict_dominators += 1
    assert bool(strict_dominators) == should_have_dominator
    return checked, strict_dominators


def verify_partial_gap_with_full_cut():
    p = (F(3, 4), F(1, 4))
    ratios = (F(2, 3), F(2))
    q = tuple(mass * ratio for mass, ratio in zip(p, ratios, strict=True))
    evidence = (F(2, 3), F(2))
    assert expectation(p, evidence) == sum(q) == 1
    # Here S = {0} union [2,infty). Its positive partial gap cutoff is the
    # smaller ratio, even though A_t is full at t=1/3.
    assert all(e > F(1, 3) for e in evidence)
    assert capped(q, evidence, 2) == F(4, 3)
    # For every E', (R-c)*min(E',2) is bounded by its value at E
    # and the term c*min(E',2) is bounded by c*E'.
    c = min(ratios)
    upper = sum(mass * max(ratio - c, 0) * 2 for mass, ratio in zip(p, ratios, strict=True)) + c
    assert upper == F(4, 3)


def main():
    tied = (F(0), F(4, 3), F(4, 3))
    ordered = (F(0), F(7, 6), F(3, 2))
    improvement = (F(0), F(13, 12), F(19, 12))
    assert all(expectation(P, evidence) == 1 for evidence in (tied, ordered, improvement))
    q_tied = (F(1, 8), F(7, 16), F(7, 16))
    q_ordered = (F(1, 8), F(3, 8), F(1, 2))
    assert profile_test(q_ordered, ordered, improvement) == (F(0), F(1, 96))
    checked, found = verify_grid(q_tied, tied, False)
    print(f"Tied, fractional gap: {checked} budgets, {found} strict dominators.")
    checked, found = verify_grid(q_ordered, ordered, True)
    print(f"Ordered, suboptimal gap: {checked} budgets, {found} strict dominators.")
    verify_partial_gap_with_full_cut()
    print("Exact gap gain 1/96 and positive cutoff on a full cut verified.")


if __name__ == "__main__":
    main()
