"""Exact Pauli PEC calculations. Only the Python standard library is needed.

Labels are nonzero integers interpreted as vectors over GF(2).  They label
Pauli conjugation channels, so their addition is XOR, regardless of whether
the underlying Pauli matrices commute.  z[j] = exp(2*t*w[j]) is supplied as a
positive rational number > 1.  No floating point enters these routines.
"""
from __future__ import annotations

from fractions import Fraction as Q
from itertools import combinations
from math import comb, prod


def check_labels(labels):
    labels = tuple(labels)
    if any(not isinstance(v, int) or v <= 0 for v in labels):
        raise ValueError("Every active label must be a nonzero integer")
    if len(set(labels)) != len(labels):
        raise ValueError("Combine repeated generators before calling")
    return labels


def span(labels):
    group = {0}
    for v in labels:
        group |= {g ^ v for g in tuple(group)}
    return tuple(sorted(group))


def rank(labels):
    return (len(span(labels))).bit_length() - 1


def inverse_coefficients(labels, z):
    """Multiply the factors ((z+1) I - (z-1) Ad(P))/2 exactly."""
    labels = check_labels(labels)
    z = tuple(map(Q, z))
    if len(labels) != len(z) or any(x <= 1 for x in z):
        raise ValueError("One rational z > 1 is required per active generator")
    coeff = {0: Q(1)}
    for v, x in zip(labels, z):
        a, b = (1 + x) / 2, (x - 1) / 2
        new = {}
        for g, c in coeff.items():
            new[g] = new.get(g, Q(0)) + a * c
            new[g ^ v] = new.get(g ^ v, Q(0)) - b * c
        coeff = new
    assert sum(coeff.values()) == 1
    return coeff


def cost(labels, z):
    return sum(map(abs, inverse_coefficients(labels, z).values()), Q(0))


def even_odd_masses(labels, z):
    """Positive subset weights, retaining parity before cancellation."""
    labels = check_labels(labels)
    z = tuple(map(Q, z))
    if len(z) != len(labels) or any(x <= 1 for x in z):
        raise ValueError("Invalid active parameters")
    masses = {(0, 0): Q(1)}
    for v, x in zip(labels, z):
        a, b = (1 + x) / 2, (x - 1) / 2
        new = {}
        for (g, parity), value in masses.items():
            for key, weight in [((g, parity), a), ((g ^ v, parity ^ 1), b)]:
                new[key] = new.get(key, Q(0)) + value * weight
        masses = new
    return {g: (masses.get((g, 0), Q(0)), masses.get((g, 1), Q(0)))
            for g in span(labels)}


def odd_dependency(labels):
    """Return a shortest odd kernel subset, or None. Exponential verifier."""
    labels = check_labels(labels)
    for size in range(1, len(labels) + 1, 2):
        for subset in combinations(range(len(labels)), size):
            value = 0
            for j in subset:
                value ^= labels[j]
            if value == 0:
                return subset
    return None


def parity_functional(labels):
    """Polynomial GF(2) elimination for h.v_j=1; returns consistency."""
    rows = {}
    for v in check_labels(labels):
        rhs = 1
        while v:
            pivot = v.bit_length() - 1
            if pivot not in rows:
                rows[pivot] = (v, rhs)
                break
            old, bit = rows[pivot]
            v ^= old
            rhs ^= bit
        if not v and rhs:
            return False
    return True


def weak_leading_term(labels, rates=None):
    """Exact coefficient in Gamma_fact-Gamma_opt = coefficient*t**h+O(t**(h+1)).

    Distinct h-subsets are counted once, even if several shortest odd kernel
    subsets contain them.  Positive rational rates are supported.
    """
    labels = check_labels(labels)
    rates = tuple(map(Q, rates if rates is not None else [1] * len(labels)))
    if len(rates) != len(labels) or any(w <= 0 for w in rates):
        raise ValueError("Positive rates are required")
    witness = odd_dependency(labels)
    if witness is None:
        return {"odd_girth": None, "order": None, "coefficient": Q(0), "subsets": []}
    girth = len(witness)
    order = (girth + 1) // 2
    syndromes = set()
    for subset in combinations(range(len(labels)), order - 1):
        value = 0
        for j in subset:
            value ^= labels[j]
        syndromes.add(value)
    selected = []
    coefficient = Q(0)
    for subset in combinations(range(len(labels)), order):
        value = 0
        for j in subset:
            value ^= labels[j]
        if value in syndromes:
            selected.append(subset)
            coefficient += 2 * prod(rates[j] for j in subset)
    assert coefficient > 0
    return {"odd_girth": girth, "order": order, "coefficient": coefficient,
            "subsets": selected}


def graph_labels(n, edges):
    edges = tuple(tuple(e) for e in edges)
    if any(not (0 <= i < j < n) for i, j in edges):
        raise ValueError("Use a simple graph with edges 0 <= i < j < n")
    return check_labels((1 << i) ^ (1 << j) for i, j in edges)


def is_bipartite(n, edges):
    neighbors = [[] for _ in range(n)]
    for i, j in edges:
        neighbors[i].append(j)
        neighbors[j].append(i)
    color = {}
    for root in range(n):
        if root in color:
            continue
        color[root] = 0
        todo = [root]
        while todo:
            u = todo.pop()
            for v in neighbors[u]:
                if v in color:
                    if color[v] == color[u]:
                        return False
                else:
                    color[v] = color[u] ^ 1
                    todo.append(v)
    return True


def weighted_maxcut(n, edges, weights=None):
    weights = tuple(map(Q, weights if weights is not None else [1] * len(edges)))
    return max((sum((w for (u, v), w in zip(edges, weights)
                     if ((mask >> u) ^ (mask >> v)) & 1), Q(0))
                for mask in range(1 << n)), default=Q(0))


def odd_cycle_cost(length, z):
    """Equal-rate odd cycle formula, exact at any rational z=exp(2t)>1."""
    if length < 3 or length % 2 != 1:
        raise ValueError("An odd cycle of length >= 3 is required")
    z = Q(z)
    a, b = (z + 1) / 2, (z - 1) / 2
    h = (length + 1) // 2
    return z ** length - 2 * sum(comb(length, k) * a ** (length - k) * b ** k
                                 for k in range(h, length + 1))
