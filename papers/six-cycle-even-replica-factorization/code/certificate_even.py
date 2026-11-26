#!/usr/bin/env python3
"""Exact checks of local blocks and the raw six-cycle replica rank."""

from fractions import Fraction
from itertools import product


def binary_rank(columns):
    pivots = {}
    for column in columns:
        while column:
            index = column.bit_length() - 1
            if index not in pivots:
                pivots[index] = column
                break
            column ^= pivots[index]
    return len(pivots)


def replica_rows(n):
    sites = tuple(product(range(n), repeat=5))
    index = {site: i for i, site in enumerate(sites)}
    shifts = [tuple(int(i == axis) for axis in range(5)) for i in range(6)]
    for left in range(3):
        for reference, site in enumerate(sites):
            result = 0
            for right in (left, (left + 1) % 3):
                moved = tuple(
                    (coordinate + a - b) % n
                    for coordinate, a, b in zip(site, shifts[left], shifts[3 + right])
                )
                offset = right * len(sites)
                result ^= (1 << (offset+reference)) ^ (1 << (offset+index[moved]))
            yield result


def local_columns(m, dimension, pencil):
    # Entry monomials are encoded by masks of variables having degree one.
    base = [m**j for j in range(dimension)]
    exponents = tuple(product(range(m), repeat=dimension))
    for col in range(len(pencil)):
        for values in exponents:
            index = sum(a*b for a, b in zip(values, base))
            allowed = sum(1 << i for i, value in enumerate(values) if value+1 < m)
            result = 0
            for row in range(len(pencil)):
                for support in pencil[row][col]:
                    if support & allowed == support:
                        shift = sum(base[i] for i in range(dimension) if (support >> i) & 1)
                        result ^= 1 << (row*m**dimension+index+shift)
            yield result


def odd_minus(n):
    return (n-1)*(3*n**4+2*n**3-2*n*n+n+4)


def even_twice(r, odd_rank):
    return 48*(r**5-1)+16*odd_rank+62+32*(r-1)


def main():
    for m in (2, 4, 8):
        quadric = [[(0b0011, 0b1100)]]
        segric = [[(0b0001,), (0b0010,)], [(0b0100,), (0b1000,)]]
        quadric_nullity = m**4 - binary_rank(local_columns(m, 4, quadric))
        segric_nullity = 2*m**4 - binary_rank(local_columns(m, 4, segric))
        assert quadric_nullity == (4*m**3-m)//3
        assert segric_nullity == (4*m**3+2*m)//3
        print(f"m={m} rank-two critical length={m*quadric_nullity} rank-one length={m*segric_nullity}")

    even, odd = binary_rank(replica_rows(6)), binary_rank(replica_rows(7))
    assert binary_rank(replica_rows(2)) == 62
    assert even == even_twice(3, odd_minus(3)) == 20894
    assert odd == odd_minus(7) == 46812
    fixed_gap = Fraction(odd, 6*7**4) - Fraction(even, 5*6**4)
    assert fixed_gap == Fraction(195233, 7779240) > 0
    print(f"E(2)=62 E(6)={even} E(7)={odd} (S7-S6)/log(2)={fixed_gap}")

    for r in (3, 7, 15, 31):
        numerator = (
            128*r**7+224*r**6-736*r**5-1000*r**4+192*r**3+640*r*r+288*r+41
        )
        fraction = Fraction(numerator, 8*r**4*(2*r-1)*(2*r+1)**4)
        resolved = (
            Fraction(odd_minus(2*r+1), (2*r)*(2*r+1)**4)
            - Fraction(even_twice(r, odd_minus(r)), (2*r-1)*(2*r)**4)
        )
        assert resolved == fraction > 0
    print("four branch checks of the consecutive-index inequality passed")


if __name__ == "__main__":
    main()
