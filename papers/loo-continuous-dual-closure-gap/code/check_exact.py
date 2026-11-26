#!/usr/bin/env python3
"""Check label certificates, the count recursion, and exact binomial gaps."""

from fractions import Fraction as F
from itertools import product
from math import comb


def verify_pair(a):
    size = 2 / (a + 1)
    upper = 2 / a - 1 / a**2
    multipliers = (1 / (a + 1), F(0), F(1))
    values = (F(0), a, a)
    for i, j in product(range(3), repeat=2):
        rhs = size + multipliers[j]*(values[i] - 1) + multipliers[i]*(values[j] - 1)
        assert rhs >= ((i, j) in ((1, 0), (0, 1), (2, 2)))
    assert upper - size == (a - 1)/(a*a*(a + 1)) > 0
    for j in (1, 2, 7, 30):
        u = a + F(1, 2*j)
        p0, p = (u - 1)/(u + 1), 1/(u + 1)
        assert p0 + 2*p == 1
        assert u*p/(p0 + p) == 1
        assert 2*p < size


def tail(k, m, p):
    if m <= 0:
        return F(1)
    if m > k:
        return F(0)
    a, b = p.numerator, p.denominator
    return F(sum(comb(k, j)*a**j*(b-a)**(k-j) for j in range(m, k + 1)), b**k)


def verify_telescope(k, m, p, outcomes):
    count = 0
    total = F(0)
    for j, outcome in enumerate(outcomes, start=1):
        difference = tail(k-j, m-count-1, p) - tail(k-j, m-count, p)
        assert difference >= 0
        total += (outcome - p)*difference
        count += outcome
    assert total == (count >= m) - tail(k, m, p)


def main():
    values = [1 + F(j, k) for k in range(1, 17) for j in range(1, 13)]
    for a in values:
        verify_pair(a)
    print(f"Pairwise label and feasible-law checks: {len(values)} parameters.")
    v, w = F(2, 3), F(3, 4)
    assert w-v == F(1, 12)
    telescopes = 0
    for k in range(1, 9):
        for m in range(1, k + 1):
            for outcomes in product((0, 1), repeat=k):
                verify_telescope(k, m, v, outcomes)
                telescopes += 1
    print(f"Exact all-count certificate telescopes: {telescopes}.")
    k = 2000
    midpoint = k * (v+w)/2
    m = -((-midpoint.numerator) // midpoint.denominator)
    primal = tail(k, m, v)
    dual = tail(k, m, w)
    assert primal < F(1, 1000)
    assert dual > F(999, 1000)
    assert dual-primal > F(999, 1000)
    print(f"At dimension {2*k}, count cutoff {m}: exact continuous-dual gap exceeds 999/1000.")
    print("All checks passed.")


if __name__ == "__main__":
    main()
