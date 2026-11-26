#!/usr/bin/env python3
"""Exact six-cycle checks in the original and character replica bases."""

from fractions import Fraction
from itertools import product
from math import comb


class BinaryField:
    def __init__(self, size, modulus):
        self.order = size - 1
        self.exp = []
        self.log = {}
        value = 1
        for index in range(self.order):
            assert value and value not in self.log
            self.exp.append(value)
            self.log[value] = index
            value <<= 1
            if value & size:
                value ^= modulus
        assert value == 1

    def mul(self, a, b):
        return self.exp[(self.log[a] + self.log[b]) % self.order] if a and b else 0

    def power(self, value, exponent):
        return self.exp[(self.log[value] * exponent) % self.order] if value else 0

    def roots(self, n):
        assert self.order % n == 0
        return tuple(self.exp[i * (self.order // n)] for i in range(n))


def rank_three(field, rows):
    matrix = [list(row) for row in rows]
    rank = 0
    for j in range(3):
        pivot = next((i for i in range(rank, 3) if matrix[i][j]), None)
        if pivot is None:
            continue
        matrix[rank], matrix[pivot] = matrix[pivot], matrix[rank]
        unit = matrix[rank][j]
        for i in range(rank + 1, 3):
            coefficient = matrix[i][j]
            if coefficient:
                for k in range(j, 3):
                    matrix[i][k] = field.mul(unit, matrix[i][k]) ^ field.mul(coefficient, matrix[rank][k])
        rank += 1
    return rank


def full_character_rank(field, roots):
    total = 0
    for b1, b2, a1, a2, a3 in product(roots, repeat=5):
        rows = (
            (b1 ^ a1, b2 ^ a1, 0),
            (0, b2 ^ a2, 1 ^ a2),
            (b1 ^ a3, 0, 1 ^ a3),
        )
        total += rank_three(field, rows)
    return total


def trim(poly):
    while poly and poly[-1] == 0:
        poly.pop()
    return poly


def remainder(field, a, b):
    a = list(a)
    inverse_lead = field.power(b[-1], -1)
    while a and len(a) >= len(b):
        shift = len(a) - len(b)
        ratio = field.mul(a[-1], inverse_lead)
        for i, value in enumerate(b):
            a[shift + i] ^= field.mul(value, ratio)
        trim(a)
    return a


def gcd_degree(field, first, second):
    a, b = list(first), list(second)
    while b:
        a, b = b, remainder(field, a, b)
    return len(a) - 1


def ratio_polynomial(field, n, left, right):
    coefficients = [
        (field.mul(field.power(left, n - i), field.power(right, i)) ^ 1)
        if comb(n, i) % 2 else 0
        for i in range(1, n)
    ]
    assert len(trim(coefficients)) == n - 1 and coefficients[0] != 0
    return coefficients


def formula_general_odd(field, n, roots):
    h = 0
    for b1, b2 in product(roots, repeat=2):
        if len({b1, b2, 1}) != 3:
            continue
        q2 = ratio_polynomial(field, n, b2, 1)
        q3 = ratio_polynomial(field, n, 1, b1)
        for a in roots:
            if a in (b1, b2):
                continue
            u = field.mul(b1 ^ a, field.power(b2 ^ a, -1))
            reciprocal = [field.mul(coef, field.power(u, -i)) for i, coef in enumerate(q3)][::-1]
            h += gcd_degree(field, q2, reciprocal)
    weights = (24, 42, 36, 18, 3)
    baseline = sum(
        weight * ((n - 1)**length + (-1)**length * (n - 1)) // n
        for length, weight in enumerate(weights, 2)
    )
    return baseline - h - 3*(n-1)**2*(n-2) - (n-1)**3, h


def direct_binary_rank(n):
    coords = tuple(product(range(n), repeat=5))
    index = {coord: i for i, coord in enumerate(coords)}
    shifts = [tuple(int(i == ax) for ax in range(5)) for i in range(6)]
    pivots = {}
    for left in range(3):
        for copy_id, coord in enumerate(coords):
            row = 0
            for right in (left, (left+1) % 3):
                target = tuple(
                    (x + a - b) % n for x, a, b in zip(coord, shifts[left], shifts[3+right])
                )
                row ^= (1 << (right*n**5 + copy_id)) ^ (1 << (right*n**5 + index[target]))
            while row:
                pivot = row.bit_length() - 1
                if pivot not in pivots:
                    pivots[pivot] = row
                    break
                row ^= pivots[pivot]
    return len(pivots)


def main():
    checks = ((3, 4, 0x7), (5, 16, 0x13), (7, 8, 0xB), (9, 64, 0x43), (11, 1024, 0x409))
    for n, size, modulus in checks:
        field = BinaryField(size, modulus)
        roots = field.roots(n)
        expected, h = formula_general_odd(field, n, roots)
        assert full_character_rank(field, roots) == expected
        if n in (3, 5):
            assert direct_binary_rank(n) == expected
        if ((n + 1) & n) == 0:
            assert expected == (n-1)*(3*n**4+2*n**3-2*n*n+n+4)
        if ((n - 1) & (n - 2)) == 0:
            assert expected == (n-1)*(3*n**4+2*n**3-4*n*n+11*n-8)
        normalized = Fraction(expected, (n-1)*n**4)
        print(f"n={n} H(n)={h} rank={expected} S/log(2)={normalized}")
    print("raw replica bit-elimination agrees at n=3,5")
    print("field mode elimination and polynomial gcd counts agree at every tested n")


if __name__ == "__main__":
    main()
