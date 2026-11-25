"""Exact finite transport verification using only the standard library."""

from collections import Counter
from fractions import Fraction
from itertools import combinations, combinations_with_replacement


TRIPLES = tuple(combinations_with_replacement(range(3), 3))
PAIRS = tuple(combinations_with_replacement(range(3), 2))
COUNTS = tuple(Counter(t) for t in TRIPLES)
MATRIX = tuple(
    tuple(n[i] * (n[j] - (i == j)) for n in COUNTS)
    for i, j in PAIRS
)
RHS = (Fraction(2, 3),) * 6
LOW = tuple(Fraction(n, 9) for n in (0, 1, 2, 1, 2, 0, 0, 2, 0, 1))
HIGH = tuple(Fraction(n, 3) for n in (0, 0, 1, 1, 0, 0, 0, 0, 1, 0))


def dot(v, w):
    return sum(a * b for a, b in zip(v, w, strict=True))


def solve_basis(columns):
    rows = [
        [Fraction(row[j]) for j in columns] + [rhs]
        for row, rhs in zip(MATRIX, RHS, strict=True)
    ]
    for col in range(6):
        pivot = next((i for i in range(col, 6) if rows[i][col]), None)
        if pivot is None:
            return None
        rows[col], rows[pivot] = rows[pivot], rows[col]
        diagonal = rows[col][col]
        rows[col] = [a / diagonal for a in rows[col]]
        for i in range(6):
            if i != col:
                scale = rows[i][col]
                rows[i] = [a - scale * b for a, b in zip(rows[i], rows[col], strict=True)]
    return tuple(row[-1] for row in rows)


def feasible_vertices():
    vertices = set()
    for columns in combinations(range(10), 6):
        weights = solve_basis(columns)
        if weights is not None and all(weight >= 0 for weight in weights):
            full = [Fraction(0)] * 10
            for j, weight in zip(columns, weights, strict=True):
                full[j] = weight
            vertices.add(tuple(full))
    return vertices


def certificate(x):
    x2 = x * x
    if x <= Fraction(1, 2):
        bound = (1 + 2 * x2) / 9
        last = 1
        slack = 0, x2, (1 - x2) / 3, x2 * (1 - x), (1 - x) * (1 - 2 * x) / 3, 0
    else:
        bound = x / 3
        last = x * (3 - 2 * x)
        slack = 0, x2, x * (1 - x), x2 * (1 - x), 0, (1 - x) * (2 * x - 1)
    zero, a000, a022, a111, a122, a222 = slack
    dual = tuple(Fraction(value) / 6 for value in (x2, -x2, -x2, x2, 2 * x2, last))
    return bound, dual, (a000, zero, zero, zero, zero, a022, a111, zero, a122, a222)


def check_dyadic_coupling():
    grid = 256
    mass_lo = Counter()
    mass_hi = Counter()
    for i in range(grid):
        for j in range(grid):
            k = (grid - 1) ^ i ^ j
            cells = [
                range(3 * q // grid, (3 * (q + 1) - 1) // grid + 1)
                for q in (i, j, k)
            ]
            possible = {
                tuple(sorted((a, b, c)))
                for a in cells[0] for b in cells[1] for c in cells[2]
            }
            mass_hi.update(possible)
            if len(possible) == 1:
                mass_lo.update(possible)
    parity = tuple((3 * a + b) / 4 for a, b in zip(LOW, HIGH, strict=True))
    for t, mass in zip(TRIPLES, parity, strict=True):
        assert Fraction(mass_lo[t], grid ** 2) <= mass <= Fraction(mass_hi[t], grid ** 2)
    assert parity[5] == 0 and parity[6] == 0
    assert parity[8] == parity[9] == Fraction(1, 12)
    for numerator in range(101):
        x = Fraction(numerator, 100)
        bound, _, _ = certificate(x)
        cost = tuple(Fraction(0) if 0 in t else x ** t.count(1) for t in TRIPLES)
        expected_loss = (
            (1 - x) * (1 - 2 * x) / 36 if numerator <= 50
            else (1 - x) * (2 * x - 1) / 12
        )
        assert bound - dot(parity, cost) == expected_loss


def main():
    vertices = feasible_vertices()
    for vector in (LOW, HIGH):
        assert sum(vector) == 1
        assert tuple(dot(row, vector) for row in MATRIX) == RHS
        assert vector in vertices
    assert solve_basis((1, 2, 3, 4, 7, 9)) == tuple(LOW[j] for j in (1, 2, 3, 4, 7, 9))
    assert solve_basis((1, 2, 3, 4, 7, 8)) == tuple(HIGH[j] for j in (1, 2, 3, 4, 7, 8))
    for k in range(101):
        x = Fraction(k, 100)
        cost = tuple(Fraction(0) if 0 in t else x ** t.count(1) for t in TRIPLES)
        bound, dual, slack = certificate(x)
        assert dot(dual, RHS) == bound
        assert tuple(dot(col, dual) - c for col, c in zip(zip(*MATRIX), cost, strict=True)) == slack
        assert all(value >= 0 for value in slack)
        best = max(dot(vertex, cost) for vertex in vertices)
        assert best == bound
        optimal = {vertex for vertex in vertices if dot(vertex, cost) == best}
        if 0 < k < 50:
            assert optimal == {LOW}
        elif 50 < k < 100:
            assert optimal == {HIGH}
        elif k == 50:
            assert optimal == {LOW, HIGH}
        elif k == 0:
            assert optimal == {w for w in vertices if w[5] == w[8] == 0}
        else:
            assert optimal == {w for w in vertices if w[0] == 0}
    check_dyadic_coupling()
    print(f"Enumerated {len(vertices)} distinct basic feasible vertices over all 210 bases.")
    print("Verified both independent active bases and all five optimal-face regimes.")
    print("Primal, dual, and complementarity agree at all 101 rational check points.")
    print("Parity-law mass vector lies inside all ten exact depth-eight dyadic enclosures.")


if __name__ == "__main__":
    main()
