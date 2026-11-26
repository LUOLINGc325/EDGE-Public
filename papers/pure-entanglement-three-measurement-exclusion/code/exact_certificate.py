#!/usr/bin/env python3
"""Finite, exact certificates. Python standard library only; no numerical tolerances.

This does not certify the universal cyclotomic theorem. It checks three
rational qutrit instances, a rational rank-two instance, and support lifts.
All checks remain active under python -O.
"""
from __future__ import annotations

import argparse
from fractions import Fraction as Q
from itertools import combinations, product
import json
from pathlib import Path


CHECKS = {}


def require(condition, category):
    CHECKS[category] = CHECKS.get(category, 0) + 1
    if not condition:
        raise ArithmeticError(f"Certificate failed: {category}")


def zeros(n, m=None):
    return [[Q(0) for _ in range(n if m is None else m)] for _ in range(n)]


def eye(n):
    return [[Q(i == j) for j in range(n)] for i in range(n)]


def transpose(a):
    return [list(row) for row in zip(*a)]


def add(a, b):
    return [[x+y for x, y in zip(ra, rb)] for ra, rb in zip(a, b)]


def scale(c, a):
    return [[c*x for x in row] for row in a]


def mul(a, b):
    bt = transpose(b)
    return [[sum((x*y for x, y in zip(ra, cb)), Q(0)) for cb in bt] for ra in a]


def column(a, j):
    return [[row[j]] for row in a]


def hstack(cols):
    return [[c[i][0] for c in cols] for i in range(len(cols[0]))]


def diagonal(values):
    return [[Q(values[i]) if i == j else Q(0) for j in range(len(values))]
            for i in range(len(values))]


def determinant(a):
    a = [row[:] for row in a]
    out = Q(1)
    for j in range(len(a)):
        pivot = next((k for k in range(j, len(a)) if a[k][j]), None)
        if pivot is None:
            return Q(0)
        if pivot != j:
            a[j], a[pivot] = a[pivot], a[j]
            out = -out
        value = a[j][j]
        out *= value
        for k in range(j+1, len(a)):
            ratio = a[k][j]/value
            for l in range(j+1, len(a)):
                a[k][l] -= ratio*a[j][l]
    return out


def inverse(a):
    n = len(a)
    out = [row[:] + unit[:] for row, unit in zip(a, eye(n))]
    for j in range(n):
        pivot = next((k for k in range(j, n) if out[k][j]), None)
        if pivot is None:
            raise ArithmeticError("Singular inverse")
        out[j], out[pivot] = out[pivot], out[j]
        value = out[j][j]
        out[j] = [x/value for x in out[j]]
        for k in range(n):
            if k != j:
                value = out[k][j]
                out[k] = [x-value*y for x, y in zip(out[k], out[j])]
    return [row[n:] for row in out]


def outer(v):
    return mul(v, transpose(v))


def trace(a):
    return sum((a[i][i] for i in range(len(a))), Q(0))


def psd(a, category):
    require(a == transpose(a), category + ":symmetric")
    for k in range(1, len(a)+1):
        for subset in combinations(range(len(a)), k):
            minor = [[a[i][j] for j in subset] for i in subset]
            require(determinant(minor) >= 0, category + ":principal_minor")


def all_transversals(bases, category):
    d = len(bases[0])
    determinants = []
    for f in product(range(3), repeat=d):
        b = hstack([column(bases[f[a]], a) for a in range(d)])
        value = determinant(b)
        require(value != 0, category + ":nonzero_determinant")
        gram = mul(b, transpose(b))
        require(determinant(gram) == value*value, category + ":gram_determinant")
        require(trace(gram) == d, category + ":unit_column_trace")
        determinants.append(value)
    min_squared = min(x*x for x in determinants)
    error_lower = min_squared*Q(d-1, d)**(d-1)/3
    return {
        "count": len(determinants),
        "minimum_absolute_determinant": min(abs(x) for x in determinants),
        "uniform_prior_separable_error_lower_bound": error_lower,
        "all_determinants": determinants,
    }


def lift(bases, extra):
    r = len(bases[0])
    lifted = []
    for b in bases:
        large = eye(r+extra)
        for i in range(r):
            for j in range(r):
                large[i][j] = b[i][j]
        lifted.append(large)
    return lifted


def qutrit(amplitudes, t):
    a = [[Q(0), Q(-1), Q(1)], [Q(1), Q(0), Q(-1)], [Q(-1), Q(1), Q(0)]]
    u = mul(add(eye(3), scale(t, a)), inverse(add(eye(3), scale(-t, a))))
    bases = [eye(3), u, mul(u, u)]
    for b in bases:
        require(mul(transpose(b), b) == eye(3), "qutrit:orthogonal_basis")
    ds = diagonal(amplitudes)
    norm2 = sum(x*x for x in amplitudes)
    overlaps = []
    decoders = []
    for outcome in range(3):
        vectors = [mul(ds, column(b, outcome)) for b in bases]
        v = hstack(vectors)
        g = mul(transpose(v), v)
        require(determinant(g) > 0, "qutrit:conditional_independence")
        for i, j in combinations(range(3), 2):
            ratio = g[i][j]**2/(g[i][i]*g[j][j])
            require(Q(0) < ratio < Q(1, 4), "qutrit:strict_overlap_bounds")
            overlaps.append(ratio)
        w = mul(v, inverse(g))
        decoder = []
        for i in range(3):
            c = zeros(3)
            j, k = [x for x in range(3) if x != i]
            c[j][j], c[k][k] = g[j][j]/2, g[k][k]/2
            c[j][k], c[k][j] = g[j][k], g[k][j]
            psd(c, "qutrit:coordinate_PSD")
            n = mul(mul(w, c), transpose(w))
            psd(n, "qutrit:decoder_PSD")
            require(trace(n) > 0, "qutrit:nonzero_effect")
            require(mul(n, vectors[i]) == zeros(3, 1), "qutrit:exact_exclusion")
            for actual in range(3):
                probability = mul(mul(transpose(vectors[actual]), n), vectors[actual])[0][0]
                expected = Q(0) if actual == i else g[actual][actual]/2
                require(probability == expected, "qutrit:wrong_label_probability")
            decoder.append(n)
        require(add(add(decoder[0], decoder[1]), decoder[2]) == eye(3), "qutrit:POVM_sum")
        decoders.append(decoder)
    transversals = all_transversals(bases, "qutrit:transversal")
    # A rank-three state embedded in dimension five. The extra outcomes are
    # impossible for this state, and common to all three measurements.
    lifted = lift(bases, 2)
    for b in lifted:
        require(mul(transpose(b), b) == eye(5), "rank_deficient:orthogonal_basis")
    lifted_check = all_transversals(lifted, "rank_deficient:transversal")
    require(lifted_check["minimum_absolute_determinant"] == transversals["minimum_absolute_determinant"],
            "rank_deficient:support_determinant")
    return {
        "schmidt_probabilities": [Q(x*x, norm2) for x in amplitudes],
        "cayley_parameter": t,
        "bases": bases,
        "maximum_squared_normalized_overlap": max(overlaps),
        "decoders_by_classical_outcome": decoders,
        "transversals": transversals,
        "rank_three_dimension_five_lift": {
            k: v for k, v in lifted_check.items() if k != "all_determinants"
        },
    }


def qubit():
    # lambda=1/5 and c=5/13 satisfy c^2<min(lambda,1-lambda).
    c, s = Q(5, 13), Q(12, 13)
    bases = [eye(2), [[c, s], [s, -c]], [[c, s], [-s, c]]]
    for b in bases:
        require(mul(transpose(b), b) == eye(2), "qubit:orthogonal_basis")
    ds = diagonal([1, 2])
    decoders = []
    for outcome in range(2):
        vectors = [mul(ds, column(b, outcome)) for b in bases]
        # Write v1 as alpha*e + sign*beta*f, up to an irrelevant sign.
        e, f = column(eye(2), outcome), column(eye(2), 1-outcome)
        alpha = c*(1 if outcome == 0 else 2)
        beta = s*(2 if outcome == 0 else 1)
        sign = 1 if outcome == 0 else -1
        require(beta > alpha > 0, "qubit:strict_triangle")
        vminus = add(scale(beta, e), scale(-sign*alpha, f))
        vplus = add(scale(beta, e), scale(sign*alpha, f))
        decoder = [scale(1-alpha**2/beta**2, outer(f)),
                   scale(1/(2*beta**2), outer(vminus)),
                   scale(1/(2*beta**2), outer(vplus))]
        for i, n in enumerate(decoder):
            psd(n, "qubit:decoder_PSD")
            require(mul(n, vectors[i]) == zeros(2, 1), "qubit:exact_exclusion")
            for actual in range(3):
                value = mul(mul(transpose(vectors[actual]), n), vectors[actual])[0][0]
                require(value == 0 if actual == i else value > 0, "qubit:wrong_label_probability")
        require(add(add(decoder[0], decoder[1]), decoder[2]) == eye(2), "qubit:POVM_sum")
        require(mul(transpose(vectors[0]), vectors[1])[0][0] != 0, "qubit:nondiscrimination")
        decoders.append(decoder)
    return {"schmidt_probabilities": [Q(1, 5), Q(4, 5)],
            "bases": bases,
            "decoders_by_classical_outcome": decoders,
            "transversals": all_transversals(bases, "qubit:transversal"),
            "rank_two_dimension_three_lift": all_transversals(lift(bases, 1), "qubit_lift:transversal")}


def encode(value):
    if isinstance(value, Q):
        return str(value)
    if isinstance(value, dict):
        return {k: encode(v) for k, v in value.items()}
    if isinstance(value, (tuple, list)):
        return [encode(v) for v in value]
    return value


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    data = {
        "arithmetic": "exact fractions; no floating-point predicates",
        "scope": "Three qutrit instances, one qubit instance, and their specified support lifts. Not a formalization of the general theorem.",
        "qutrits": [qutrit([1, 1, 1], Q(9, 10)),
                     qutrit([1, 2, 3], Q(9, 10)),
                     qutrit([1, 10, 100], Q(999, 1000))],
        "qubit": qubit(),
    }
    data["checks_by_category"] = CHECKS
    data["total_exact_checks"] = sum(CHECKS.values())
    data["result"] = "PASS"
    rendered = json.dumps(encode(data), ensure_ascii=False, indent=2, sort_keys=True) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered, encoding="utf-8")
    print(json.dumps({"result": "PASS", "total_exact_checks": data["total_exact_checks"],
                      "qutrit_transversals": 81, "lifted_rank_three_transversals": 729,
                      "qubit_transversals": 9, "lifted_rank_two_transversals": 27}, sort_keys=True))


if __name__ == "__main__":
    main()
