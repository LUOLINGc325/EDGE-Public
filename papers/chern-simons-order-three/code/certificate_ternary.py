#!/usr/bin/env python3
"""Calculate ternary replica Gauss exponents exactly over F_3."""

from fractions import Fraction
from itertools import combinations, product

EDGES = tuple(combinations(range(4), 2))
SINGLETONS = tuple((i,) for i in range(4))


def merge(pair):
    return (pair,) + tuple(block for block in SINGLETONS if block[0] not in pair)


def cut(part):
    return (part, tuple(i for i in range(4) if i not in part))


def add_mod_three(first, second):
    return [(a + b) % 3 for a, b in zip(first, second)]


def replica_hessian(links, partition):
    dimension = len(partition) - 1
    sites = list(product(range(3), repeat=dimension))
    index = {point: idx for idx, point in enumerate(sites)}
    shifts = [[int(i == axis) for axis in range(dimension)] for i in range(len(partition))]
    color = {party: shifts[i] for i, block in enumerate(partition) for party in block}
    nsites = len(sites)
    width = 4 * nsites
    matrix = [[0] * width for _ in range(width)]
    for ((u, v), weight) in zip(EDGES, links):
        offset = [(a - b) % 3 for a, b in zip(color[u], color[v])]
        for i, site in enumerate(sites):
            row = u * nsites + i
            source = v * nsites + i
            target = v * nsites + index[tuple(add_mod_three(site, offset))]
            matrix[row][source] = (matrix[row][source] + weight) % 3
            matrix[source][row] = matrix[row][source]
            matrix[row][target] = (matrix[row][target] - weight) % 3
            matrix[target][row] = matrix[row][target]
    return matrix


def diagonal_congruence(matrix):
    coefficients = []
    while matrix:
        width = len(matrix)
        pivot = next((i for i in range(width) if matrix[i][i]), None)
        if pivot is None:
            edge = next(((i, j) for i in range(width) for j in range(i) if matrix[i][j]), None)
            if edge is None:
                break
            pivot, j = edge
            # Substitute e_pivot + e_j for e_pivot by congruent operations.
            matrix[pivot] = add_mod_three(matrix[pivot], matrix[j])
            for row in matrix:
                row[pivot] = (row[pivot] + row[j]) % 3
        coefficient = matrix[pivot][pivot]
        assert coefficient in (1, 2)
        coefficients.append(2 * coefficient % 3)  # Q = x^T H x / 2.
        keep = [i for i in range(width) if i != pivot]
        matrix = [
            [(matrix[i][j] - coefficient * matrix[i][pivot] * matrix[pivot][j]) % 3 for j in keep]
            for i in keep
        ]
    return coefficients


def gauss_exponent(links, partition):
    """For normalized positive sum, return e such that Z = 3^-e."""
    coefficients = diagonal_congruence(replica_hessian(links, partition))
    rank = len(coefficients)
    assert rank % 2 == 0
    # The two one-dimensional sums are +i sqrt(3) and -i sqrt(3).
    sign = (-1) ** (rank // 2 + coefficients.count(2))
    assert sign == 1
    return rank // 2


def defect(links):
    full = gauss_exponent(links, SINGLETONS)
    merged = {pair: gauss_exponent(links, merge(pair)) for pair in EDGES}
    single_cuts = {i: gauss_exponent(links, cut((i,))) for i in range(4)}
    pair_cuts = {j: gauss_exponent(links, cut((0, j))) for j in range(1, 4)}
    i3 = Fraction(sum(single_cuts.values()) - sum(pair_cuts.values()), 2)
    gm = Fraction(full - sum(merged.values()) + 3 * sum(single_cuts.values()), 18)
    return full, merged, single_cuts, pair_cuts, i3, gm, gm - i3/9


def bipartite_exponent(links, partition):
    """Direct Gaussian sum for the two sides of the signed cycle."""
    groups = {vertex: i for i, group in enumerate(partition) for vertex in group}
    dimension = len(partition) - 1
    coordinates = tuple(product(range(3), repeat=dimension))
    index = {point: i for i, point in enumerate(coordinates)}
    weights = dict(zip(EDGES, links))
    nsites = len(coordinates)
    matrix = [[0] * (2 * nsites) for _ in range(2 * nsites)]
    for side_a, i in enumerate((0, 3)):
        for side_b, j in enumerate((1, 2)):
            edge_weight = weights[tuple(sorted((i, j)))]
            translation = tuple(
                int(groups[i] == c) - int(groups[j] == c) for c in range(dimension)
            )
            for reference, site in enumerate(coordinates):
                shifted = index[tuple((x + h) % 3 for x, h in zip(site, translation))]
                row = matrix[side_a * nsites + reference]
                offset = side_b * nsites
                row[offset + reference] = (row[offset + reference] + edge_weight) % 3
                row[offset + shifted] = (row[offset + shifted] - edge_weight) % 3

    rank = 0
    for column in range(2 * nsites):
        pivot = next((i for i in range(rank, 2 * nsites) if matrix[i][column]), None)
        if pivot is None:
            continue
        matrix[rank], matrix[pivot] = matrix[pivot], matrix[rank]
        for i in range(rank + 1, 2 * nsites):
            multiplier = matrix[i][column] * matrix[rank][column] % 3
            if multiplier:
                matrix[i] = [(a - multiplier * b) % 3 for a, b in zip(matrix[i], matrix[rank])]
        rank += 1
    return rank


def main():
    links = (1, 1, 0, 0, 1, 2)
    partitions_by_type = {
        "1:1:1:1": (SINGLETONS,),
        "2:1:1": tuple(merge(pair) for pair in EDGES),
        "3:1": tuple(cut((i,)) for i in range(4)),
        "2:2": tuple(cut((0, j)) for j in range(1, 4)),
    }
    expected = (40, 12, 2, 4)
    print("k=3 signed-cycle links", links)
    for (kind, partitions), target in zip(partitions_by_type.items(), expected):
        direct = [bipartite_exponent(links, partition) for partition in partitions]
        hessian = [gauss_exponent(links, partition) for partition in partitions]
        assert direct == hessian == [target] * len(partitions)
        print(f"{kind} rank exponents ({len(partitions)} partitions): {direct}")
    _, _, _, _, i3, gm, delta = defect(links)
    assert (i3, gm, delta) == (-2, Fraction(-4, 9), Fraction(-2, 9))
    print(f"I3/log(3)={i3} GM(a=0)/log(3)={gm} Delta/log(3)={delta}")


if __name__ == "__main__":
    main()
