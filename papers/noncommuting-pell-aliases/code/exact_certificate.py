#!/usr/bin/env python3
"""Exact graph, Pell arithmetic and Markov support tests."""

from fractions import Fraction
from json import dumps
from math import isqrt


ORDER = 16


def support():
    neighbors = []
    for layer, step in ((0, 1), (1, 3)):
        for i in range(8):
            neighbors.append(((i + step) % 8 + 8 * layer,
                              (i - step) % 8 + 8 * layer,
                              i + 8 * (1 - layer)))
    return neighbors


def girth(neighbors):
    best = ORDER + 1
    for root in range(ORDER):
        depth = [-1] * ORDER
        parents = [-1] * ORDER
        depth[root] = 0
        queue = [root]
        for v in queue:
            for w in neighbors[v]:
                if depth[w] < 0:
                    depth[w] = depth[v] + 1
                    parents[w] = v
                    queue.append(w)
                elif parents[v] != w:
                    best = min(best, depth[v] + depth[w] + 1)
        assert len(queue) == ORDER
    return best


def principal_log(c, s, neighbors):
    """Exact rational entries of B = Q(0)-c Pi_{2,6} (tensor) X."""
    matrix = [[Fraction(0) for _ in range(ORDER)] for _ in range(ORDER)]
    signs = (1, 0, -1, 0)
    for i, (plus, minus, spoke) in enumerate(neighbors):
        matrix[i][i] = -(s + c)
        matrix[i][plus] = matrix[i][minus] = Fraction(s, 2)
        matrix[i][spoke] = c
        other = 8 if i < 8 else 0
        for j in range(8):
            matrix[i][other + j] -= Fraction(c * signs[(j - i) % 4], 4)
    assert all(sum(row) == 0 for row in matrix)
    assert all(matrix[i][j] == matrix[j][i] for i in range(ORDER) for j in range(ORDER))
    assert matrix[0][12] == -Fraction(c, 4)
    return matrix


def exact_rank(columns):
    basis = {}
    for column in columns:
        values = list(column)
        for position, normal in sorted(basis.items()):
            if values[position]:
                factor = values[position]
                values = [x - factor * y for x, y in zip(values, normal)]
        pivot = next((i for i, x in enumerate(values) if x), None)
        if pivot is not None:
            divisor = values[pivot]
            basis[pivot] = [value / divisor for value in values]
    return len(basis)


def commutator_columns(matrix, neighbors):
    """A column encodes B E - E B, for E with a single directed unit rate."""
    for v, local in enumerate(neighbors):
        for w in local:
            yield [((matrix[i][v] if j == w else -matrix[i][v] if j == v else 0)
                    - ((matrix[w][j] - matrix[v][j]) if i == v else 0))
                   for i in range(ORDER) for j in range(ORDER)]


def main():
    neighbors = support()
    assert all(len(set(row)) == 3 and i not in row for i, row in enumerate(neighbors))
    assert all(i in neighbors[j] for i, row in enumerate(neighbors) for j in row)
    assert girth(neighbors) == 6
    pell = []
    ell, k = 1, 1
    for _ in range(8):
        assert ell * ell - 2 * k * k == -1
        pell.append([ell, k])
        ell, k = 3 * ell + 4 * k, 2 * ell + 3 * k
    ranks = []
    for scale in (2, 4, 8, 42, 240):
        matrix = principal_log(1, scale, neighbors)
        rank = exact_rank(commutator_columns(matrix, neighbors))
        assert rank == 46
        accepted = []
        for k in range(1, isqrt((scale * scale - 1) // 2) + 1):
            if isqrt(2 * k * k - 1) ** 2 == 2 * k * k - 1:
                accepted.append(k)
        ranks.append({"s_over_c": scale, "real_linear_rank": rank,
                      "positive_bias_indices": accepted})
    result = {"graph_order": ORDER, "girth": 6, "ranks_at_rational_scales": ranks,
              "pell_witnesses": pell, "negative_principal_log_entry_in_c_units": "-1/4"}
    print(dumps(result, indent=2))


if __name__ == "__main__":
    main()
