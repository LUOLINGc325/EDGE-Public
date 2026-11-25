#!/usr/bin/env python3
"""Check square-link replica matrices over the integers by unit elimination."""

from fractions import Fraction
from itertools import combinations, product

VERTICES = ("A", "B", "C", "D")
SIDES = (("A", "B"), ("C", "D"))
SINGLETONS = tuple((vertex,) for vertex in VERTICES)


def cut(part):
    return part, tuple(vertex for vertex in VERTICES if vertex not in part)


def merge(pair):
    return (pair,) + tuple((vertex,) for vertex in VERTICES if vertex not in pair)


def matrix_rows(n, partition):
    dimension = len(partition) - 1
    coordinates = tuple(product(range(n), repeat=dimension))
    index = {coordinate: idx for idx, coordinate in enumerate(coordinates)}
    groups = {vertex: i for i, part in enumerate(partition) for vertex in part}
    nsites = len(index)
    rows = []
    for left in SIDES[0]:
        for site_id, site in enumerate(coordinates):
            row = {}
            for right_id, right in enumerate(SIDES[1]):
                # This produces the ungauged physical block I - T_(g_i-g_j).
                translated = tuple(
                    (coordinate + (groups[left] == axis) - (groups[right] == axis)) % n
                    for axis, coordinate in enumerate(site)
                )
                right_site = index[translated]
                if right_site != site_id:
                    row[right_id * nsites + site_id] = 1
                    row[right_id * nsites + right_site] = -1
            rows.append(row)
    return rows


def integral_unit_rank(rows):
    # After clearing a unit pivot's column, clearing its row by column operations
    # has no effect on the remaining submatrix. Both operations are unimodular.
    rank = 0
    rows = list(rows)
    while rows:
        pivot_index = min(
            (i for i, row in enumerate(rows) if any(abs(a) == 1 for a in row.values())),
            key=lambda i: len(rows[i]),
            default=None,
        )
        if pivot_index is None:
            assert all(not row for row in rows), "nonunit residual requires further elimination"
            return rank
        pivot = rows.pop(pivot_index)
        column = next(c for c, value in pivot.items() if abs(value) == 1)
        unit = pivot.pop(column)
        for row in rows:
            multiplier = row.pop(column, 0) * unit
            if multiplier != 0:
                for c, value in pivot.items():
                    reduced = row.get(c, 0) - multiplier * value
                    if reduced:
                        row[c] = reduced
                    else:
                        row.pop(c, None)
        rank += 1
    return rank


def main():
    partitions = {
        "full": [(SINGLETONS, True)],
        "same-side merges": [(merge(side), False) for side in SIDES],
        "cross-side merges": [(merge(pair), True) for pair in product(*SIDES)],
        "single cuts": [(cut((vertex,)), False) for vertex in VERTICES],
        "opposite-side cut": [(cut(SIDES[0]), False)],
        "cross 2:2 cuts": [(cut(("A", right)), True) for right in SIDES[1]],
    }
    for n in range(2, 7):
        exponents = {}
        for name, entries in partitions.items():
            for partition, has_two_sides in entries:
                q = len(partition)
                expected = n ** (q - 1) - 1
                if has_two_sides:
                    expected += (n - 1) ** 2 * n ** (q - 3) if q >= 3 else n - 1
                exponent = integral_unit_rank(matrix_rows(n, partition))
                assert exponent == expected
                exponents.setdefault(name, []).append(exponent)
        e4 = exponents["full"][0]
        e3 = sum(exponents["same-side merges"] + exponents["cross-side merges"])
        e31 = sum(exponents["single cuts"])
        e22 = sum(exponents["opposite-side cut"] + exponents["cross 2:2 cuts"])
        i3 = Fraction(e31 - e22, n - 1)
        gm = Fraction(e4, (n - 1) * n * n) - Fraction(e3, 3 * (n - 1) * n) + Fraction(e31, 3 * (n - 1))
        delta = gm - Fraction(n*n-3*n+3, 3*n*n) * i3
        assert delta == Fraction((n-2)*(n-3), 3*n*n)
        print(f"n={n} e4={e4} sum_e3={e3} sum_e31={e31} sum_e22={e22} I3/log(k)={i3} Delta/log(k)={delta}")


if __name__ == "__main__":
    main()
