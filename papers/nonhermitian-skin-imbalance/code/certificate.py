#!/usr/bin/env python3
"""Exact checks for the rational example in the theorem."""
from fractions import Fraction


def main():
    right = Fraction(3)
    mixing = Fraction(1, 4)
    detuning = Fraction(5, 2)
    radius = right + 1 / right
    q = mixing * radius / detuning
    assert right > 1
    assert 0 < mixing < 1
    assert 2 < detuning
    assert detuning ** 2 < radius ** 2 * (1 - mixing ** 2)
    assert 0 < q < 1

    bound = q ** 2 * (1 + q ** 2) / (2 * (1 - q ** 2) ** 3)
    assert bound == Fraction(45, 512)
    print(f"radius={radius}")
    print(f"q={q}")
    print(f"point_gap_root_margin_squared={radius ** 2 - detuning ** 2 / (1 - mixing ** 2)}")
    print(f"open_many_body_gap_lower_bound={2 * (detuning - 2)}")
    print(f"all_even_lengths_imbalance_upper_bound={bound}")


if __name__ == "__main__":
    main()
