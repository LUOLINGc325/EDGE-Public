#!/usr/bin/env python3
"""Exact standard-library certificate for the qubit Lüders merge example.

All arithmetic is Fraction arithmetic. The positive-root sandwiches are
evaluated using explicit factorizations from the accompanying derivation.
This is a finite arithmetic certificate, not a substitute for Lean verification
of the universal density-matrix semantics.
"""

from fractions import Fraction as Q
from itertools import product
import json


def require(condition, message="Exact arithmetic certificate failed"):
    if not condition:
        raise ArithmeticError(message)


def mat(a, b, c, d):
    return ((Q(a), Q(b)), (Q(c), Q(d)))


I = mat(1, 0, 0, 1)
Z = mat(0, 0, 0, 0)
P = mat(1, 0, 0, 0)
R = mat(0, 0, 0, 1)


def add(a, b):
    return tuple(tuple(a[i][j] + b[i][j] for j in range(2)) for i in range(2))


def scale(c, a):
    return tuple(tuple(c * a[i][j] for j in range(2)) for i in range(2))


def mul(a, b):
    return tuple(tuple(sum(a[i][k] * b[k][j] for k in range(2)) for j in range(2)) for i in range(2))


def trace(a):
    return a[0][0] + a[1][1]


def summat(xs):
    a = Z
    for b in xs:
        a = add(a, b)
    return a


def psd(a):
    return a[0][1] == a[1][0] and a[0][0] >= 0 and a[1][1] >= 0 and a[0][0] * a[1][1] >= a[0][1] ** 2


def H(x, z):
    return mat(z, x, x, -z)


def build(s):
    require(Q(1, 4) <= s <= 1)
    d = 1 - s * s
    a = (16 * s * s - 1) / 15
    E = [scale(a, I), scale(d / 15, mat(16, 0, 0, 1)), scale(d, R)]
    F = [scale(Q(3, 4), P), mat(Q(1, 8), Q(1, 4), Q(1, 4), Q(1, 2)), mat(Q(1, 8), Q(-1, 4), Q(-1, 4), Q(1, 2))]
    C = [add(E[0], E[1]), E[2]]
    require(all(psd(e) for e in E + F + C))
    require(summat(E) == summat(F) == summat(C) == I)
    for f in F:
        require(mul(f, f) == scale(trace(f), f))
    require(C[0] == mat(1, 0, 0, s * s))

    def e_sandwich(i, f):
        if i == 0:
            return scale(a, f)
        if i == 1:
            K = mat(4, 0, 0, 1)
            return scale(d / 15, mul(mul(K, f), K))
        return scale(d, mul(mul(R, f), R))

    def c_sandwich(i, f):
        if i == 0:
            K = mat(1, 0, 0, s)
            return mul(mul(K, f), K)
        return scale(d, mul(mul(R, f), R))

    def f_sandwich(f, e):
        return scale(1 / trace(f), mul(mul(f, e), f))

    fine = [add(e_sandwich(i, f), scale(-1, f_sandwich(f, e))) for i, e in enumerate(E) for f in F]
    coarse = [add(c_sandwich(i, f), scale(-1, f_sandwich(f, e))) for i, e in enumerate(C) for f in F]
    z, k = d / 10, d / 5
    ell = (1 - s) * (4 * s - 1) / 20
    require(fine == [Z, Z, Z, Z, H(0, z), H(0, z), Z, H(-k, -z), H(k, -z)])
    require(coarse == [Z, H(ell, z), H(-ell, z), Z, H(-k, -z), H(k, -z)])
    for diffs in [fine, coarse]:
        require(summat(diffs) == Z)
        require(all(trace(e) == 0 and e[0][1] == e[1][0] for e in diffs))
    return E, F, C, fine, coarse


def enumerate_events(diffs):
    maximum = Q(-1)
    witnesses = []
    event_count = 0
    squared_values = set()
    for bits in product([0, 1], repeat=len(diffs)):
        D = summat(e for b, e in zip(bits, diffs) if b)
        require(trace(D) == 0)
        square = D[0][0] ** 2 + D[0][1] ** 2
        require(mul(D, D) == scale(square, I))
        squared_values.add(square)
        if square > maximum:
            maximum, witnesses = square, [bits]
        elif square == maximum:
            witnesses.append(bits)
        event_count += 1
    return {"count": event_count, "max_squared": str(maximum), "witness": list(witnesses[0]), "distinct_squared_values": [str(x) for x in sorted(squared_values)]}


def tv_plus(diffs):
    rho = scale(Q(1, 2), mat(1, 1, 1, 1))
    require(psd(rho) and trace(rho) == 1 and mul(rho, rho) == rho)
    return sum(abs(trace(mul(rho, D))) for D in diffs) / 2


def main():
    E, F, C, fine, coarse = build(Q(3, 4))
    f, c = enumerate_events(fine), enumerate_events(coarse)
    require(Q(f["max_squared"]) == Q(49, 5120))
    require(Q(c["max_squared"]) == Q(81, 6400))
    require(Q(f["max_squared"]) < Q(1, 100) < Q(c["max_squared"]))
    require(tv_plus(fine) == Q(7, 80))
    require(tv_plus(coarse) == Q(9, 80))
    family = []
    for s in [Q(1, 4), Q(1, 3), Q(2, 5), Q(1, 2), Q(2, 3), Q(3, 4), Q(4, 5), Q(9, 10), Q(1)]:
        _, _, _, fds, cds = build(s)
        ef, ec = enumerate_events(fds), enumerate_events(cds)
        expected_f = (1 - s * s) ** 2 / 20
        expected_c = max(expected_f, ((1 - s) * (3 + 8 * s) / 20) ** 2)
        require(Q(ef["max_squared"]) == expected_f)
        require(Q(ec["max_squared"]) == expected_c)
        strict = expected_c > expected_f
        require(strict == (s < 1 and 44 * s * s + 8 * s - 11 > 0))
        family.append({"s": str(s), "fine_squared": str(expected_f), "coarse_squared": str(expected_c), "strict_increase": strict})
    print(json.dumps({"arithmetic": "exact fractions; no float operations", "fine": f, "coarse": c, "same_plus_input_fine_tv": str(tv_plus(fine)), "same_plus_input_coarse_tv": str(tv_plus(coarse)), "family_checks": family, "scope": "Finite rational record matrices and event enumeration. General all-density and all-parameter claims are supported by the accompanying analytic proof and require separate Lean verification."}, indent=2))


if __name__ == "__main__":
    main()
