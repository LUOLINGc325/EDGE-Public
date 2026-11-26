"""Verify finite frame examples and measurement counts with exact integers."""

from collections import Counter
from fractions import Fraction
from itertools import product
import json
from random import Random


def solve(matrix, target):
    """Solve a nonsingular rational system by elimination."""
    size = len(matrix)
    rows = [[Fraction(value) for value in row] + [Fraction(rhs)]
            for row, rhs in zip(matrix, target, strict=True)]
    for j in range(size):
        pivot = next((i for i in range(j, size) if rows[i][j]), None)
        if pivot is None:
            raise ValueError("singular matrix")
        rows[j], rows[pivot] = rows[pivot], rows[j]
        leading = rows[j][j]
        rows[j] = [value / leading for value in rows[j]]
        for i, row in enumerate(rows):
            if i != j and row[j]:
                leading = row[j]
                rows[i] = [x - leading * y for x, y in zip(row, rows[j], strict=True)]
    return [row[-1] for row in rows]


def vandermonde_row(node, d):
    """Integer coordinates for z ↦ (1,z,...,z**(d-1))."""
    x, y = node
    real, imaginary = 1, 0
    coordinates = []
    for _ in range(d):
        coordinates.append((real, imaginary))
        real, imaginary = real * x - imaginary * y, real * y + imaginary * x
    return coordinates


def moment_row(vector):
    """Coefficients of v*Qv in the independent entries of Hermitian Q."""
    coefficients = [x*x + y*y for x, y in vector]
    for a, (x, y) in enumerate(vector):
        for u, v in vector[a+1:]:
            coefficients.extend((2*(x*u+y*v), -2*(x*v-y*u)))
    return coefficients


def unwhitened_frame(d, rng):
    nodes = rng.sample(list(product(range(-6, 7), repeat=2)), d*d)
    assert len(set(nodes)) == d*d  # Every d-row Vandermonde minor is nonzero.
    basis = [moment_row(vandermonde_row(node, d)) for node in nodes]
    target = [1] + [0] * (d*d-1)
    coefficients = solve(basis, target)
    assert [sum(x*y for x, y in zip(row, coefficients, strict=True)) for row in basis] == target

    real = [[Fraction(0) for _ in range(d)] for _ in range(d)]
    imaginary = [[Fraction(0) for _ in range(d)] for _ in range(d)]
    for i in range(d):
        real[i][i] = coefficients[i]
    j = d
    for a in range(d):
        for b in range(a+1, d):
            real[a][b] = real[b][a] = coefficients[j]
            imaginary[a][b] = coefficients[j+1]
            imaginary[b][a] = -imaginary[a][b]
            j += 2
    # Realification is invertible exactly when the complex dual is invertible.
    block = [r + [-x for x in i] for r, i in zip(real, imaginary, strict=True)]
    block += [i + r for r, i in zip(real, imaginary, strict=True)]
    solve(block, [0] * (2*d))
    return {"dimension": d, "nodes": nodes, "dual_invertible": True}


def grid(d):
    p = d // 2
    q = d - p
    columns = (d*d + q - 1) // q
    rows = (d*d + p - 1) // p
    cells = [(j // p, j % columns) for j in range(d*d)]
    assert len(set(cells)) == d*d
    row_count = Counter(i for i, _ in cells)
    col_count = Counter(j for _, j in cells)
    assert len(row_count) == rows and max(row_count.values()) <= p
    assert len(col_count) == columns and max(col_count.values()) <= q
    count = rows + columns - 1
    assert count == 4*d + (1 if d % 2 else -1)
    return count


def main():
    rng = Random(261037347)
    frames = [unwhitened_frame(d, rng) for d in range(2, 6)]
    bounds = {}
    for d in range(3, 129):
        by_grid = grid(d)
        by_triples = 8 if d == 3 else d*d - (d*d - 1) // 3
        assert min(by_grid, by_triples) < d*d
        if d <= 12:
            bounds[d] = {"grid": by_grid, "triples": by_triples, "best": min(by_grid, by_triples)}
    return {"arithmetic": "exact rational", "unwhitened_frame_examples": frames,
            "grid_dimensions_checked": 126, "small_dimension_bounds": bounds,
            "tensor_qubit_examples": [{"qubits": n, "settings": 3*n+1, "baseline": 4**n}
                                      for n in range(2, 9)]}


if __name__ == "__main__":
    print(json.dumps(main(), ensure_ascii=False, indent=2))
