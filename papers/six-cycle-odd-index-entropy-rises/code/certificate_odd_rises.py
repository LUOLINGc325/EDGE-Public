#!/usr/bin/env python3
"""Verify the sparse-support lemma and exact first displayed odd rise."""

from collections import Counter
from fractions import Fraction
from itertools import combinations, product
from math import comb
from pathlib import Path
import runpy


def all_forms():
    unit = [tuple(int(i == j) for i in range(5)) for j in range(5)]
    left = unit[:3]
    right = unit[3:] + [(0, 0, 0, 0, 0)]
    survivors = set()
    for shift in (0, 1):
        for choose_left in product((False, True), repeat=3):
            factors = [
                left[i] if choose_left[i] else right[(i + shift) % 3]
                for i in range(3)
            ]
            combined = tuple(map(sum, zip(*factors)))
            survivors.symmetric_difference_update((combined,))
    assert len(survivors) == 12
    return survivors


def all_directions(forms):
    directions = set()
    for left, right in combinations(forms, 2):
        difference = tuple(x-y for x, y in zip(left, right))
        sign = next(value for value in difference if value)
        assert sign in (-1, 1)
        directions.add(tuple(sign * entry for entry in difference))
    assert len(directions) == 36
    return directions


def support_lemma(forms, directions):
    histogram = Counter()
    for direction in directions:
        leading = next(i for i, value in enumerate(direction) if value)
        assert direction[leading] == 1
        cosets = Counter(
            tuple(x-v[leading]*d for x, d in zip(v, direction))
            for v in forms
        )
        histogram[sum(size == 1 for size in cosets.values())] += 1
    assert histogram == Counter({8: 30, 10: 6})
    for first, second in combinations(directions, 2):
        assert any(
            (first[i] * second[j] - first[j] * second[i]) % 3
            for i, j in combinations(range(5), 2)
        )
    assert comb(len(directions), 2) * 9 == 5670
    return dict(sorted(histogram.items()))


def main():
    forms = all_forms()
    directions = all_directions(forms)
    histogram = support_lemma(forms, directions)
    print(f"forms={len(forms)} directions={len(directions)} singletons_histogram={histogram}")
    print("all direction pairs have a unit 2x2 minor modulo 3")
    print("bound H(3^j) <= 5670 (3^j)^3")

    repository_cases = Path(__file__).resolve().parents[2]
    companion = repository_cases / "six-cycle-replica-arithmetic" / "code" / "certificate_six_cycle.py"
    arithmetic = runpy.run_path(str(companion))
    rank = {}
    for n, size, modulus in ((9, 64, 0x43), (11, 1024, 0x409)):
        field = arithmetic["BinaryField"](size, modulus)
        roots = field.roots(n)
        rank[n] = arithmetic["full_character_rank"](field, roots)
    assert rank == {9: 167264, 11: 466940}
    difference = Fraction(rank[11], 10*11**4) - Fraction(rank[9], 8*9**4)
    assert difference == Fraction(245306, 96059601) > 0
    print(f"E(9)={rank[9]} E(11)={rank[11]} (S11-S9)/log(2)={difference}")


if __name__ == "__main__":
    main()
