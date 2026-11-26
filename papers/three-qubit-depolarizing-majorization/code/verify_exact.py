#!/usr/bin/env python3
"""Exact, finite checks for the three-qubit research manuscript.

Uses only Python's standard library. These checks supplement the analytic proof;
they are not a machine formalization of matrix majorization for all states.
"""
from fractions import Fraction as F
from itertools import combinations, product
from pathlib import Path
import json
import math

ROOT = Path(__file__).resolve().parents[1]
N = 8


def zeros():
    return [[F(0) for _ in range(N)] for _ in range(N)]


def unit(i, j):
    x = zeros()
    x[i][j] = F(1)
    return x


def add(a, b):
    return [[x + y for x, y in zip(ar, br)] for ar, br in zip(a, b)]


def scale(a, q):
    return [[q * x for x in row] for row in a]


def trace(a):
    return sum(a[i][i] for i in range(N))


def bit(x, site):
    return (x >> (2 - site)) & 1


def lifted_marginal(a, kept):
    """Tr_complement(a) tensor identity, with the original factor order."""
    out = zeros()
    lost = tuple(i for i in range(3) if i not in kept)
    for i, j in product(range(N), repeat=2):
        if any(bit(i, k) != bit(j, k) for k in lost):
            continue
        for u, v in product(range(N), repeat=2):
            if any(bit(u, k) != bit(v, k) for k in lost):
                continue
            if all(bit(u, k) == bit(i, k) and bit(v, k) == bit(j, k) for k in kept):
                out[i][j] += a[u][v]
    return out


def layers(a):
    out = []
    for j in range(4):
        x = zeros()
        for kept in combinations(range(3), j):
            x = add(x, lifted_marginal(a, kept))
        out.append(scale(x, F(1, math.comb(3, j) * 2 ** (3 - j))))
    return out


def spinflip(a):
    """Y^tensor3 a^T Y^tensor3, exactly, on complex matrix-unit coefficients."""
    return [[(-1) ** (i.bit_count() + j.bit_count()) * a[7-j][7-i]
             for j in range(N)] for i in range(N)]


def pauli_channel(a, lam):
    """Independent Pauli conjugations; no partial traces in this implementation."""
    probs = ((1 + 3 * lam) / 4, (1 - lam) / 4,
             (1 - lam) / 4, (1 - lam) / 4)
    out = a
    for site in range(3):
        nxt = zeros()
        mask = 1 << (2-site)
        for i, j in product(range(N), repeat=2):
            for p, q in enumerate(probs):
                ii, jj = (i ^ mask, j ^ mask) if p in (1, 2) else (i, j)
                sign = (-1) ** (bit(i, site) + bit(j, site)) if p in (2, 3) else 1
                nxt[ii][jj] += q * sign * out[i][j]
        out = nxt
    return out


def solve3(rows, rhs):
    a = [[F(x) for x in r] + [F(b)] for r, b in zip(rows, rhs)]
    for col in range(3):
        p = next((r for r in range(col, 3) if a[r][col]), None)
        if p is None:
            return None
        a[col], a[p] = a[p], a[col]
        q = a[col][col]
        a[col] = [x/q for x in a[col]]
        for r in range(3):
            if r != col:
                q = a[r][col]
                a[r] = [x-q*y for x, y in zip(a[r], a[col])]
    return tuple(a[r][3] for r in range(3))


def polygon_certificate():
    # Every inequality is rows[i] dot r <= rhs[i].
    rows, rhs = [], []
    for i in range(3):
        e = [0, 0, 0]
        e[i] = 1
        rows.extend([e, [-v for v in e]])
        rhs.extend([F(1, 2), F(0)])
        t = [-1, -1, -1]
        t[i] = 1
        rows.append(t)
        rhs.append(F(0))
    result = {}
    for low in (True, False):
        rr = rows + ([[1, 1, 1]] if low else [[-1, -1, -1]])
        bb = rhs + ([F(1)] if low else [F(-1)])
        vertices = set()
        for active in combinations(range(len(rr)), 3):
            v = solve3([rr[i] for i in active], [bb[i] for i in active])
            if v is not None and all(sum(F(x)*y for x, y in zip(r, v)) <= b for r, b in zip(rr, bb)):
                vertices.add(v)
        assert vertices
        for v in vertices:
            s = sum(v)
            delta = 1-s if low else F(0)
            d = [sum((1-v[j]) if bit(mask, j) == 0 else v[j] for j in range(3))-1
                 for mask in range(N)]
            assert d[7] == s-1 and min(d) == d[7]
            assert max(d) == d[0] == 2-s
            assert d[0] <= 1+delta
            assert all(x <= 1 for x in d[1:])
            assert sum(d) == 4
        result['s_le_1' if low else 's_ge_1'] = [[str(x) for x in v] for v in sorted(vertices)]
    return result


def spectrum(w):
    return [w[0]/8 + w[1]*F(3-h, 12) + w[2]*F(math.comb(3-h, 2), 6)
            + (w[3] if h == 0 else 0) for h in range(4)]


def coding_certificate():
    weights = [tuple(F(i == j) for i in range(4)) for j in range(4)]
    weights.append((F(1, 10), F(2, 10), F(3, 10), F(4, 10)))
    for lam in (F(0), F(1, 3), F(1, 2), F(1)):
        weights.append(tuple(F(math.comb(3, j))*lam**j*(1-lam)**(3-j) for j in range(4)))
    checks = 0
    for w in weights:
        q = spectrum(w)
        assert all(q[i] >= q[i+1] for i in range(3))
        assert q[0]+3*q[1]+3*q[2]+q[3] == 1
        for m in range(1, 9):
            best = F(-1)
            for code in combinations(range(8), m):
                score = sum(max(q[(x ^ y).bit_count()] for x in code) for y in range(8))/m
                best = max(best, score)
                if m >= 2 and 0 in code and 7 in code:
                    assert score == q[0] + (F(8, m)-1)*q[1]
                checks += 1
            expected = F(1) if m == 1 else q[0]+(F(8, m)-1)*q[1]
            assert best == expected
    alpha, beta = F(3, 4), F(1, 4)
    example = {str(m): str(F(1) if m == 1 else
                          alpha**3+(F(8,m)-1)*alpha**2*beta if m <= 8 else
                          F(8,m)*alpha**3) for m in range(1, 13)}
    return {'weight_cases': len(weights), 'classical_codebooks_checked': checks,
            'lambda_half_optimal_success_by_M': example,
            'scope': 'Exact classical attainability and normalization; the quantum converse is analytic.'}


def matrix_certificates():
    # Matrix units form a basis over C. Four evaluation points determine each
    # degree-at-most-three polynomial entry of the channel identities.
    points = (F(0), F(1, 3), F(1, 2), F(1))
    for i, j in product(range(N), repeat=2):
        a = unit(i, j)
        es = layers(a)
        # Expand (Tr(.) I - id)^tensor3 on the operator basis.
        rhs = add(add(scale(es[0], 8), scale(es[1], -12)), add(scale(es[2], 6), scale(es[3], -1)))
        assert spinflip(a) == rhs
        for lam in points:
            expanded = zeros()
            for k in range(4):
                w = math.comb(3,k)*lam**k*(1-lam)**(3-k)
                expanded = add(expanded, scale(es[k], w))
            assert expanded == pauli_channel(a, lam)
            assert pauli_channel(a, -lam) == spinflip(pauli_channel(a, lam))
    return {'matrix_units': 64, 'polynomial_degree_bound': 3,
            'interpolation_points': [str(x) for x in points],
            'spinflip_identity': 'passed', 'channel_layer_expansion': 'passed',
            'negative_parameter_identity': 'passed',
            'note': 'Negative values beyond -1/3 occur only as algebraic interpolation checks, not physical channels.'}


def main():
    result = {'status': 'passed', 'arithmetic': 'fractions.Fraction (exact rational)',
              'polygon_vertices': polygon_certificate(),
              'matrix_identities': matrix_certificates(),
              'coding': coding_certificate(),
              'full_quantum_theorem_formalized': False}
    output = ROOT/'results'/'exact_certificate.json'
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(result, indent=2, ensure_ascii=False)+'\n', encoding='utf-8')
    print(json.dumps(result, indent=2, ensure_ascii=False))


if __name__ == '__main__':
    main()
