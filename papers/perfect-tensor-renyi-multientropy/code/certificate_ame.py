#!/usr/bin/env python3
"""Cross-check the AME determinant count against direct replica matrices."""

from fractions import Fraction
from itertools import product
from math import comb


def sparse_rank(rows, p):
    rows = [dict(row) for row in rows if row]
    rank = 0
    while rows:
        index = min(range(len(rows)), key=lambda i: len(rows[i]))
        pivot = rows.pop(index)
        column = min(pivot)
        inv = pow(pivot.pop(column), -1, p)
        kept = []
        for row in rows:
            multiple = row.pop(column, 0) * inv % p
            if multiple:
                for key, value in pivot.items():
                    updated = (row.get(key, 0) - multiple * value) % p
                    if updated:
                        row[key] = updated
                    else:
                        row.pop(key, None)
            if row:
                kept.append(row)
        rows = kept
        rank += 1
    return rank


def direct_replica_rank(p, n):
    shifts = [(1, 0, 0), (0, 1, 0), (0, 0, 1), (0, 0, 0)]
    copies = tuple(product(range(n), repeat=3))
    index = {site: i for i, site in enumerate(copies)}
    rows = []
    for left in range(2):
        for copy_id, site in enumerate(copies):
            row = {}
            for right in range(2):
                weight = p - 1 if (left, right) == (1, 1) else 1
                displacement = [a - b for a, b in zip(shifts[left], shifts[right + 2])]
                target = tuple((a + b) % n for a, b in zip(site, displacement))
                row[right * n**3 + copy_id] = weight
                row[right * n**3 + index[target]] = -weight % p
            rows.append(row)
    return sparse_rank(rows, p)


def arithmetic_count(p, r):
    if r == 1:
        return 0
    # The square-free coordinate ring for ordered root pairs.
    d = r - 1
    lead = pow(r, -1, p)
    reduction = [-comb(r, i) * lead % p for i in range(d)]

    def increment(poly, axis):
        result = {}
        for powers, repeat in poly.items():
            value = powers[axis] + 1
            if value < d:
                target = (value, powers[1]) if axis == 0 else (powers[0], value)
                result[target] = (result.get(target, 0) + repeat) % p
            else:
                for i, c in enumerate(reduction):
                    target = (i, powers[1]) if axis == 0 else (powers[0], i)
                    result[target] = (result.get(target, 0) + c * repeat) % p
        return {key: value for key, value in result.items() if value}

    def affine_power(constant):
        poly = {(0, 0): 1}
        for _ in range(r):
            terms_u = increment(poly, 0)
            terms_v = increment(poly, 1)
            poly = {
                key: (2 * terms_u.get(key, 0) - terms_v.get(key, 0)
                      + constant * poly.get(key, 0)) % p
                for key in set(terms_u) | set(terms_v) | set(poly)
            }
            poly = {key: value for key, value in poly.items() if value}
        return poly

    with_constant, without_constant = affine_power(1), affine_power(0)
    polynomial = {
        key: (with_constant.get(key, 0) - without_constant.get(key, 0)) % p
        for key in set(with_constant) | set(without_constant)
    }
    polynomial = {key: value for key, value in polynomial.items() if value}
    rows = []
    for i in range(d):
        current = dict(polynomial)
        for _ in range(i):
            current = increment(current, 0)
        for _ in range(d):
            rows.append(current)
            current = increment(current, 1)

    # Multiplication by P_r(2u-v) vanishes exactly on the counted pairs.
    return d * d - sparse_rank(rows, p)


def main():
    for p, indices in ((3, (2, 3, 4, 5, 6, 7, 8, 9, 10)), (5, (2, 3, 4, 5, 6, 8))):
        for n in indices:
            r = n
            while r % p == 0:
                r //= p
            m = n // r
            additive_pairs = arithmetic_count(p, r)
            c = 1 + 3 * (r - 1) + additive_pairs
            predicted = 2 * n**3 - (m*m+1)//2 - m*m*c
            direct = direct_replica_rank(p, n)
            assert direct == predicted
            normalized = Fraction(direct, (n - 1) * n*n)
            print(f"p={p} n={n} r={r} m={m} additive_pairs={additive_pairs} exponent={direct} S/log(p)={normalized}")
    for p, field in ((3, 3), (3, 9), (5, 5), (7, 7)):
        assert arithmetic_count(p, field-1) == field*field-6*field+10
        assert arithmetic_count(p, field+1) == field*field


if __name__ == "__main__":
    main()
