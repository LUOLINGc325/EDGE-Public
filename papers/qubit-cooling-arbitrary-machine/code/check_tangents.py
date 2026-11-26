#!/usr/bin/env python3
"""Independent exact bounds proving the six staircase exponential tangents."""

from fractions import Fraction as F

TANGENTS = (
    (F(7, 20), F(7, 10)),
    (F(1, 4), F(7, 12)),
    (F(1, 7), F(95, 231)),
    (F(1, 8), F(3, 8)),
    (F(1, 16), F(11, 48)),
    (F(1, 16), F(11, 48)),
)


def exp_upper(x, terms):
    partial = term = F(1)
    for k in range(1, terms + 1):
        term *= x / k
        partial += term
    # Consecutive ratios after the first omitted term are at most x/(terms+2).
    remainder = (term*x/(terms+1)) / (1 - x/(terms+2))
    return partial + remainder


for k, (alpha, beta) in enumerate(TANGENTS, 2):
    anchor = beta/alpha - 1
    upper = exp_upper(anchor, 20)
    assert alpha * upper < 1
    print(f"k={k}: anchor {anchor}, alpha={alpha}; rigorous exp(anchor) < {1/alpha}")
