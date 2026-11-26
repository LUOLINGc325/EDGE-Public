"""Exact cyclic-word, matrix, and tensor-product checks for order six."""

from itertools import combinations, product
from math import comb
import json
import random

import sympy as sp


def require(condition, details):
    if not condition:
        raise AssertionError(details)


def canonical(word):
    return min(word[k:] + word[:k] for k in range(len(word)))


def orbit_counts(length, count):
    counts = {}
    for indices in combinations(range(length), count):
        index_set = set(indices)
        word = canonical("".join("D" if i in index_set else "S" for i in range(length)))
        counts[word] = counts.get(word, 0) + 1
    return counts


def tr(values, word):
    result = sp.eye(next(iter(values.values())).rows)
    for symbol in word:
        result *= values[symbol]
    return sp.expand(sp.trace(result))


WORDS = ("SSSSDD", "SSSDSD", "SSDSSD", "SSDDDD", "SDSDDD", "SDDSDD", "DDDDDD")
WEIGHTS = (6, 6, 3, 6, 6, 3, 1)
GROUPS = ((0, 1, 2), (3, 4, 5), (6,))
DELTA = sp.Rational(1, 32)


def moments(s, d):
    base = tr({"S": s, "D": d}, "SSSSSS")
    return tuple(tr({"S": s, "D": d}, word) / base for word in WORDS)


def kv(x):
    return DELTA * (1 + sum(w*m for w, m in zip(WEIGHTS, x)))


def grouped(x, y):
    means_x, means_y, totals = [], [], []
    within = []
    for group in GROUPS:
        weight = sum(WEIGHTS[i] for i in group)
        totals.append(weight)
        means_x.append(sum(WEIGHTS[i]*x[i] for i in group)/weight)
        means_y.append(sum(WEIGHTS[i]*y[i] for i in group)/weight)
        numerator = sum((WEIGHTS[i]*WEIGHTS[j]*(x[i]-x[j])*(y[i]-y[j])
                         for i, j in combinations(group, 2)), sp.S.Zero)
        within.append(numerator/weight)
    require(means_x[0] >= means_x[1] >= means_x[2], ("x-group ordering", means_x))
    require(means_y[0] >= means_y[1] >= means_y[2], ("y-group ordering", means_y))
    require(all(v >= 0 for v in within), ("within-group covariance", within))
    between = sum(totals[i]*totals[j]*(means_x[i]-means_x[j])*(means_y[i]-means_y[j])
                  for i, j in combinations(range(3), 2))/31
    return DELTA * (sum(within)+between)


def direct(s1, d1, s2, d2):
    u1, v1 = (s1+d1)/2, (s1-d1)/2
    u2, v2 = (s2+d2)/2, (s2-d2)/2
    plus = sp.kronecker_product(u1, u2) + sp.kronecker_product(v1, v2)
    minus = sp.kronecker_product(u1, v2) + sp.kronecker_product(v1, u2)
    return sp.expand(sp.trace(plus**6+minus**6)) / (sp.trace(s1**6)*sp.trace(s2**6)).expand()


def random_positive(rng, size, rank):
    matrix = sp.Matrix(rank, size, [rng.randint(-2, 2)+sp.I*rng.randint(-2, 2) for _ in range(rank*size)])
    return (matrix.conjugate().T * matrix).applyfunc(sp.expand)


def polynomial_checks():
    for word, expected in zip(WORDS, WEIGHTS):
        require(len(word) == 6, word)
        require(orbit_counts(6, word.count("D"))[canonical(word)] == expected, word)
    t = sp.Symbol("t")
    differences = []
    for j in range(7):
        poly = sp.Poly((1+t)**(6-j)*(1-t)**j, t)
        coefficients = poly.nth(2) - poly.nth(4)
        differences.append(sp.Rational(comb(6, j)*coefficients, 15))
    require(differences == [0, 4, 0, -8, 0, 4, 0], differences)
    return [int(x) for x in differences]


def main():
    polynomial = polynomial_checks()
    first = (sp.diag(4, 2), sp.Matrix([[0, 2], [2, 0]]))
    second = (sp.Matrix([[4, 1], [1, 3]]), sp.diag(2, 1))
    a, b = moments(*first), moments(*second)
    require(a[4] < a[5] and b[4] > b[5], "opposite signs of f-g")
    checks = [(first, second), (first, first)]
    equality = (sp.diag(1, 2, 3), sp.diag(1, -2, 0))
    complete_erasure = (sp.diag(1, 1, 0), sp.zeros(3))
    checks += [(equality, second), (complete_erasure, first), (equality, equality)]

    rng = random.Random(131313)
    for size, rank, other_size, other_rank in product((2, 3), (1, 2), (2,), (1, 2)):
        pair = []
        for dimension, row_count in ((size, rank), (other_size, other_rank)):
            u, v = random_positive(rng, dimension, row_count), random_positive(rng, dimension, row_count)
            pair.append((u+v, u-v))
        checks.append(tuple(pair))
    outputs = []
    for idx, (left, right) in enumerate(checks):
        x, y = moments(*left), moments(*right)
        out = direct(*left, *right)
        require(out == kv([m*n for m, n in zip(x, y)]), ("tensor trace identity", idx))
        bound = DELTA + (kv(x)-DELTA)*(kv(y)-DELTA)/(1-DELTA)
        gap = out - bound
        require(gap == grouped(x, y) and gap >= 0, ("grouped exact gap", idx))
        if idx in (0, 1):
            require(gap > 0, ("strict examples", idx))
            outputs.append({"gap": str(gap), "output_moment": str(out)})
        if idx in (2, 3, 4):
            require(gap == 0, ("erasure equality", idx))

    seven_s = sp.Matrix([[8, 1, -sp.I], [1, 8, 1], [sp.I, 1, 8]])
    seven_d = sp.diag(1, 2, 3)
    complex_word = tr({"S": seven_s, "D": seven_d}, "SSDDDSD")
    require(complex_word == 53632-12*sp.I, complex_word)
    print(json.dumps({
        "cyclic_orbit_weights": WEIGHTS,
        "average_coefficient_differences": polynomial,
        "exact_tensor_pair_checks": len(checks),
        "opposite_internal_differences": [str(a[4]-a[5]), str(b[4]-b[5])],
        "strict_gap_examples": outputs,
        "order_seven_complex_word": str(complex_word),
    }, indent=2))


if __name__ == "__main__":
    main()
