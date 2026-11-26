"""Exact small-instance checks for cloning, interpolation and witness retrieval."""

from fractions import Fraction
from itertools import combinations
from random import Random


def minimal_transversals(order, edges):
    for size in range(min(order, len(edges)) + 1):
        for vertices in combinations(range(order), size):
            mask = sum(1 << v for v in vertices)
            private = 0
            for edge in edges:
                overlap = edge & mask
                if not overlap:
                    break
                if overlap & (overlap - 1) == 0:
                    private |= overlap
            else:
                if private == mask:
                    yield mask


def beta_acyclic(order, edges):
    remaining = (1 << order) - 1
    while remaining:
        for vertex in range(order):
            bit = 1 << vertex
            if not remaining & bit:
                continue
            incident = sorted({edge & remaining for edge in edges if edge & bit},
                              key=int.bit_count)
            if all(a & b == a for a, b in zip(incident, incident[1:])):
                remaining ^= bit
                break
        else:
            return False
    return True


def clone_hypergraph(order, edges, copies):
    clone_block = (1 << copies) - 1
    cloned_edges = tuple(sum(clone_block << (v * copies) for v in range(order)
                             if edge & (1 << v)) for edge in edges)
    return order * copies, cloned_edges


def interpolate(values):
    """Recover coefficients given P(1), P(2), ... using Lagrange interpolation."""
    size = len(values)
    coefficients = [Fraction(0)] * size
    for i, value in enumerate(values, 1):
        polynomial = [1]
        denominator = 1
        for j in range(1, size + 1):
            if i == j:
                continue
            expanded = [0] * (len(polynomial) + 1)
            for power, coefficient in enumerate(polynomial):
                expanded[power] -= j * coefficient
                expanded[power + 1] += coefficient
            polynomial = expanded
            denominator *= i - j
        for power, coefficient in enumerate(polynomial):
            coefficients[power] += Fraction(value * coefficient, denominator)
    assert all(x.denominator == 1 for x in coefficients)
    return [int(x) for x in coefficients]


def interpolated_counts(order, edges, check_clones=False):
    values = []
    for copies in range(1, order + 2):
        big_order, big_edges = clone_hypergraph(order, edges, copies)
        if check_clones:
            assert beta_acyclic(big_order, big_edges)
        values.append(sum(1 for _ in minimal_transversals(big_order, big_edges)))
    return interpolate(values)


def checked_witness(order, edges, optimum):
    allowed = (1 << order) - 1
    for vertex in range(order):
        candidate = allowed ^ (1 << vertex)
        old_indices = [i for i in range(order) if candidate & (1 << i)]
        reduced_edges = tuple({sum(1 << i for i, old in enumerate(old_indices)
                                   if edge & (1 << old)) for edge in edges})
        assert beta_acyclic(len(old_indices), reduced_edges)
        if len(old_indices) >= optimum:
            counts = interpolated_counts(len(old_indices), reduced_edges)
            if counts[optimum]:
                allowed = candidate
    return allowed


def check(order, edges):
    literal = tuple(minimal_transversals(order, edges))
    expected = [0] * (order + 1)
    for mask in literal:
        expected[mask.bit_count()] += 1
    assert interpolated_counts(order, edges, check_clones=True) == expected
    if literal:
        optimum = max(mask.bit_count() for mask in literal)
        witness = checked_witness(order, edges, optimum)
        assert witness in literal and witness.bit_count() == optimum


def maximal_cliques(order, edges):
    neighbors = [0] * order
    for u, v in edges:
        neighbors[u] |= 1 << v
        neighbors[v] |= 1 << u
    cliques = []
    for v in range(1, 1 << order):
        members = [i for i in range(order) if v & (1 << i)]
        if any(((neighbors[u] | (1 << u)) & v) != v for u in members):
            continue
        if any((neighbors[u] & v) == v for u in range(order) if not v & (1 << u)):
            continue
        cliques.append(v)
    return tuple(cliques)


def main():
    exhaustive = []
    for order in range(4):
        marks = range(1, 1 << order)
        count = 0
        for size in range(len(marks) + 1):
            for edges in combinations(marks, size):
                if beta_acyclic(order, edges):
                    check(order, edges)
                    count += 1
        exhaustive.append(count)
    rng = Random(20261124)
    count = 0
    while count < 25:
        edges = tuple(rng.sample(range(1, 16), rng.randrange(1, 7)))
        if beta_acyclic(4, edges):
            check(4, edges)
            count += 1
    graph_checks = 0
    for order in range(1, 5):
        possible_edges = tuple(combinations(range(order), 2))
        for size in range(len(possible_edges) + 1):
            for edges in combinations(possible_edges, size):
                hypergraph = maximal_cliques(order, edges)
                if beta_acyclic(order, hypergraph):
                    check(order, hypergraph)
                    graph_checks += 1
    check(3, (0, 1, 6))
    print("Exhaustive beta-acyclic hypergraphs by order 0 through 3:", exhaustive)
    print("Seeded order-4 hypergraphs: 25. Strongly chordal graph checks:", graph_checks)
    print("Exact coefficient, clone acyclicity and optimal witness checks passed.")


if __name__ == "__main__":
    main()
