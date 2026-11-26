"""Exact cyclic-word and complex-covariance checks at Rényi order seven."""

from itertools import combinations
import json
import random

import sympy as sp


def require(condition, details):
    if not condition:
        raise AssertionError(details)


def canonical(word):
    return min(word[k:] + word[:k] for k in range(len(word)))


def orbit_counts(number):
    counts = {}
    for indices in combinations(range(7), number):
        positions = set(indices)
        word = canonical("".join("D" if i in positions else "S" for i in range(7)))
        counts[word] = counts.get(word, 0) + 1
    return counts


WORDS = (
    "SSSSSDD", "SSSSDSD", "SSSDSSD",
    "SSSDDDD", "SSDDDSD", "SSDDDSD"[::-1], "SSDDSDD", "SDDSDSD",
    "SDDDDDD",
)
GROUPS = ((0, 1, 2), (3, 4, 5, 6, 7), (8,))
DELTA = sp.Rational(1, 64)


def tr(s, d, word):
    result = sp.eye(s.rows)
    for symbol in word:
        result = (result * (s if symbol == "S" else d)).applyfunc(sp.expand)
    return sp.expand(sp.trace(result))


def moment_vector(s, d):
    normalization = tr(s, d, "SSSSSSS")
    return tuple(tr(s, d, word) / normalization for word in WORDS)


def moment(vector):
    return sp.expand(DELTA * (1 + 7*sum(vector)))


def covariance_parts(x, y):
    means_x, means_y, totals = [], [], []
    within = []
    for group in GROUPS:
        totals.append(7*len(group))
        sx, sy = sum(x[i] for i in group), sum(y[i] for i in group)
        means_x.append(sx/len(group))
        means_y.append(sy/len(group))
        within.append(sp.expand(7*(sum(x[i]*y[i] for i in group)-sx*sy/len(group))))
    require(all(v >= 0 for v in within), ("negative within-group part", within))
    require(means_x[0] >= means_x[1] >= means_x[2], means_x)
    require(means_y[0] >= means_y[1] >= means_y[2], means_y)
    between = sum(totals[i]*totals[j]*(means_x[i]-means_x[j])*(means_y[i]-means_y[j])
                  for i, j in combinations(range(3), 2))/63
    return DELTA * (sum(within)+between)


def direct_output(s1, d1, s2, d2):
    u1, v1 = (s1+d1)/2, (s1-d1)/2
    u2, v2 = (s2+d2)/2, (s2-d2)/2
    plus = sp.kronecker_product(u1, u2) + sp.kronecker_product(v1, v2)
    minus = sp.kronecker_product(u1, v2) + sp.kronecker_product(v1, u2)
    numerator = tr(plus, minus, "SSSSSSS") + tr(plus, minus, "DDDDDDD")
    denominator = tr(s1, d1, "SSSSSSS") * tr(s2, d2, "SSSSSSS")
    return sp.expand(numerator / denominator)


def symbolic_checks():
    for group, count in zip(GROUPS, (2, 4, 6)):
        observed = orbit_counts(count)
        require({canonical(WORDS[j]): 7 for j in group} == observed, (count, observed))

    x, y, u, v, X, Y, U, V = sp.symbols("x y u v X Y U V", real=True)
    first = sp.Matrix([x+y, u+sp.I*v, u-sp.I*v, y, 0])
    other = sp.Matrix([X+Y, U+sp.I*V, U-sp.I*V, Y, 0])
    Q = sp.Matrix([[x, u+sp.I*v], [u-sp.I*v, y]])
    M = sp.Matrix([[4*X+3*Y-2*U, -X-2*Y+3*U-5*sp.I*V],
                   [-X-2*Y+3*U+5*sp.I*V, 3*X+6*Y-4*U]])
    require(sp.expand(5*first.dot(other)-sum(first)*sum(other)-sp.trace(Q*M)) == 0,
            "covariance trace identity")
    decomposition = 25*(X*Y-U*U-V*V) + 24*(U-X/3-Y/4)**2 + 25*X*X/3 + 25*Y*Y/2
    require(sp.expand(M.det()-decomposition) == 0, "PSD determinant decomposition")


def random_positive(rng, dimension, rank):
    z = sp.Matrix(rank, dimension, [rng.randint(-2, 2)+sp.I*rng.randint(-2, 2) for _ in range(rank*dimension)])
    return (z.conjugate().T*z).applyfunc(sp.expand)


def main():
    symbolic_checks()
    s = sp.Matrix([[8, 1, -sp.I], [1, 8, 1], [sp.I, 1, 8]])
    d = sp.diag(1, 2, 3)
    require(tr(s, d, WORDS[4]) == 53632-12*sp.I, "complex witness")
    pure_erasure = (sp.diag(1, 2, 3), sp.diag(1, -2, 0))
    complete_erasure = (sp.diag(1, 1, 0), sp.zeros(3))
    pairs = [((s, d), (s, d)), ((s, d), (s.conjugate(), d)), (pure_erasure, (s, d)),
             (complete_erasure, (s, d))]

    rng = random.Random(141171)
    for run in range(8):
        endpoints = []
        for j in range(2):
            dimension, rank = 2+(run+j)%2, 1+(run//2+j)%2
            u, v = random_positive(rng, dimension, rank), random_positive(rng, dimension, rank)
            endpoints.append((u+v, u-v))
        pairs.append(tuple(endpoints))

    chiral_results = []
    for index, (first, second) in enumerate(pairs):
        x, y = moment_vector(*first), moment_vector(*second)
        value = direct_output(*first, *second)
        require(value == moment([a*b for a, b in zip(x, y)]), ("tensor trace identity", index))
        bound = DELTA+(moment(x)-DELTA)*(moment(y)-DELTA)/(1-DELTA)
        gap = value-bound
        require(gap == covariance_parts(x, y) and gap >= 0, ("gap identity", index))
        h = (x[0]+x[1]+x[2])/3 - x[8]
        j = (y[0]+y[1]+y[2])/3 - y[8]
        guaranteed = sp.Rational(7, 192)*h*j + sp.Rational(35, 4608)*(x[3]-x[7])*(y[3]-y[7])
        require(gap >= guaranteed, ("quantitative gap", index))
        if index < 2:
            require(gap > 0, "non-erasure gap")
            chiral_results.append(value)
        if index in (2, 3):
            require(gap == 0, "erasure equality")

    imaginary = sp.im(moment_vector(s, d)[4])
    difference = chiral_results[1]-chiral_results[0]
    require(difference == sp.Rational(7, 16)*imaginary*imaginary and difference > 0,
            "output visibility of complex orientation")
    print(json.dumps({
        "orbit_sizes": [[7]*len(group) for group in GROUPS],
        "symbolic_covariance_and_psd_determinant": "exact",
        "explicit_tensor_pairs": len(pairs),
        "unnormalized_complex_trace": str(tr(s, d, WORDS[4])),
        "normalization": str(tr(s, d, "SSSSSSS")),
        "orientation_output_moment_difference": str(difference),
    }, indent=2))


if __name__ == "__main__":
    main()
