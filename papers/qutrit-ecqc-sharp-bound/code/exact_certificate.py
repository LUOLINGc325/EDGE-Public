#!/usr/bin/env python3
"""Exact ECQC algebra in Q(omega), omega^2+omega+1=0; stdlib only.

This checks the displayed witness, all 81 equality candidates, and finite
identities used in the analytic classification. It is not an exhaustive
search over all pure states and does not machine-prove the classification.
"""
from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction as F
from pathlib import Path
import argparse
import json


@dataclass(frozen=True)
class W:
    a: F = F(0)
    b: F = F(0)

    def __post_init__(self):
        object.__setattr__(self, 'a', F(self.a))
        object.__setattr__(self, 'b', F(self.b))

    def __add__(self, other):
        other = coerce(other)
        return W(self.a + other.a, self.b + other.b)

    __radd__ = __add__

    def __neg__(self):
        return W(-self.a, -self.b)

    def __sub__(self, other):
        return self + -coerce(other)

    def __rsub__(self, other):
        return coerce(other) + -self

    def __mul__(self, other):
        other = coerce(other)
        return W(self.a*other.a - self.b*other.b,
                 self.a*other.b + self.b*other.a - self.b*other.b)

    __rmul__ = __mul__

    def conj(self):
        return W(self.a-self.b, -self.b)

    def norm2(self):
        return self.a*self.a-self.a*self.b+self.b*self.b

    def __truediv__(self, other):
        other = coerce(other)
        n = other.norm2()
        if not n:
            raise ZeroDivisionError
        z = self*other.conj()
        return W(z.a/n, z.b/n)

    def key(self):
        return (str(self.a), str(self.b))


def coerce(x):
    return x if isinstance(x, W) else W(x)


ONE, ZERO, OMEGA = W(1), W(), W(0, 1)
POW = (ONE, OMEGA, -ONE-OMEGA)


def ident(n=3):
    return [[W(int(i == j)) for j in range(n)] for i in range(n)]


def transpose(a):
    return [list(row) for row in zip(*a)]


def conjugate(a):
    return [[x.conj() for x in row] for row in a]


def dagger(a):
    return transpose(conjugate(a))


def mul(a, b):
    return [[sum((a[i][k]*b[k][j] for k in range(len(b))), ZERO)
             for j in range(len(b[0]))] for i in range(len(a))]


def scale(a, x):
    return [[z*x for z in row] for row in a]


def trace(a):
    return sum((a[i][i] for i in range(len(a))), ZERO)


def det3(a):
    return (a[0][0]*(a[1][1]*a[2][2]-a[1][2]*a[2][1])
            -a[0][1]*(a[1][0]*a[2][2]-a[1][2]*a[2][0])
            +a[0][2]*(a[1][0]*a[2][1]-a[1][1]*a[2][0]))


def fourier_quadratic(b):
    return [[POW[(b*x*x+j*x) % 3] for j in range(3)] for x in range(3)]


# V/sqrt(s) is the actual orthonormal basis. Order matches Iqbal Eq. (25).
BASES = [('M0_Z', ident(), 1), ('M1_F', fourier_quadratic(0), 3),
         ('M2_Q2', fourier_quadratic(2), 3),
         ('M3_Q1', fourier_quadratic(1), 3)]
C0 = [[ZERO, W(F(1, 2)), W(F(1, 2))],
      [W(F(-1, 2)), ZERO, ZERO], [W(F(-1, 2)), ZERO, ZERO]]


def weyl(a, b):
    m = [[ZERO for _ in range(3)] for _ in range(3)]
    for j in range(3):
        m[(j+a) % 3][j] = POW[(b*j) % 3]
    return m


def probability(c, v, s):
    amplitudes = scale(mul(mul(dagger(v), c), conjugate(v)), F(1, s))
    return [[z.norm2() for z in row] for row in amplitudes]


def entropy_dyadic(values):
    total = F(0)
    for x in values:
        if not x:
            continue
        n, d = x.numerator, x.denominator
        assert n & (n-1) == 0 and d & (d-1) == 0
        total -= x*(n.bit_length()-d.bit_length())
    return total


def mutual_information(p):
    rows = [sum(row) for row in p]
    cols = [sum(col) for col in zip(*p)]
    return entropy_dyadic(rows)+entropy_dyadic(cols)-entropy_dyadic(sum(p, []))


def projective_key(c):
    first = next(z for row in c for z in row if z != ZERO)
    return tuple((z/first).key() for row in c for z in row)


def check():
    assert OMEGA*OMEGA+OMEGA+ONE == ZERO
    assert OMEGA*OMEGA*OMEGA == ONE
    for _, v, s in BASES:
        assert mul(dagger(v), v) == scale(ident(), s)
    for a in range(4):
        for b in range(a):
            _, v, s = BASES[a]
            _, u, r = BASES[b]
            assert all(z.norm2() == F(s*r, 3)
                       for row in mul(dagger(v), u) for z in row)

    expected = [[F(0), F(1, 4), F(1, 4)],
                [F(1, 4), F(0), F(0)],
                [F(1, 4), F(0), F(0)]]
    witness_tables = {}
    for name, v, s in BASES:
        p = probability(C0, v, s)
        assert p == expected and mutual_information(p) == 1
        witness_tables[name] = [[str(x) for x in row] for row in p]

    orbit, marginal_pairs = set(), set()
    for a in range(3):
        for b in range(3):
            for c in range(3):
                for d in range(3):
                    state = mul(mul(weyl(a, b), C0), transpose(weyl(c, d)))
                    ra = mul(state, dagger(state))
                    rb = mul(transpose(state), conjugate(state))
                    for reduced in (ra, rb):
                        assert trace(reduced) == ONE
                        assert mul(reduced, reduced) == scale(reduced, F(1, 2))
                        assert det3(reduced) == ZERO
                    # Positive reduced matrices with R^2=R/2 and trace=1
                    # have exactly two nonzero eigenvalues, both 1/2.
                    for _, v, s in BASES:
                        p = probability(state, v, s)
                        assert sorted(sum(p, [])) == [F(0)]*5+[F(1, 4)]*4
                        assert mutual_information(p) == 1
                    orbit.add(projective_key(state))
                    marginal_pairs.add((tuple(z.key() for row in ra for z in row),
                                        tuple(z.key() for row in rb for z in row)))
    assert len(orbit) == len(marginal_pairs) == 81

    # Hesse kernel vectors are stored without their common sqrt(2) factor.
    h0 = [[ZERO], [ONE], [-ONE]]
    hesse = []
    for a in range(3):
        for b in range(3):
            h = mul(weyl(a, b), h0)
            hesse.append(h)
            for _, v, s in BASES:
                p = [row[0].norm2()/F(2*s) for row in mul(dagger(v), h)]
                assert sorted(p) == [F(0), F(1, 2), F(1, 2)]
    assert len({projective_key(h) for h in hesse}) == 9
    for i in range(9):
        for j in range(i):
            assert mul(dagger(hesse[i]), hesse[j])[0][0].norm2()/4 == F(1, 4)

    # The singleton vectors perpendicular to h0: e0 and (1,w^b,w^b)/sqrt(3).
    singletons = [([[ONE], [ZERO], [ZERO]], 1)]
    singletons += [([[ONE], [POW[b]], [POW[b]]], 3) for b in range(3)]
    for g, s in singletons:
        assert mul(dagger(h0), g)[0][0] == ZERO
        assert mul(dagger(g), g)[0][0] == W(s)
    for i, (g, s) in enumerate(singletons):
        for h, r in singletons[:i]:
            assert mul(dagger(g), h)[0][0].norm2()/F(s*r) == F(1, 3)

    # Analytic proof reduces full-rank candidates to these 18 unitaries.
    # Their quadratic-basis tables are uniform, not permutations.
    full_rank_cases = 0
    for slope in (1, 2):
        for offset in range(3):
            for phase in range(3):
                u = [[ZERO for _ in range(3)] for _ in range(3)]
                for y in range(3):
                    x = (slope*y+offset) % 3
                    u[x][y] = POW[(phase*x) % 3]
                v = fourier_quadratic(1)
                transformed = scale(mul(mul(dagger(v), u), conjugate(v)), F(1, 3))
                assert all(z.norm2() == F(1, 3) for row in transformed for z in row)
                full_rank_cases += 1
    assert full_rank_cases == 18

    return {
        'status': 'PASS', 'arithmetic': 'fractions in Q(omega), omega^2+omega+1=0',
        'measurement_convention': 'same column basis on both parties; U^dagger C conjugate(U)',
        'orthonormal_bases': 4, 'mutually_unbiased_pairs': 6,
        'witness_joint_tables': witness_tables,
        'witness_reduced_spectrum': ['1/2', '1/2', '0'],
        'classical_mutual_information_bits': ['1']*4,
        'ecqc_score_bits': '3', 'quantum_mutual_information_bits': '2',
        'ratio': '3/2', 'excess_bits': '1',
        'equality_candidates_checked': len(orbit),
        'distinct_marginal_pairs': len(marginal_pairs),
        'hesse_kernel_rays': len(hesse),
        'tetrahedron_pair_overlap_squared': '1/3',
        'full_rank_monomial_candidates_excluded': full_rank_cases,
        'scope': 'Exact finite algebra. Universal upper bound and exhaustiveness require the written proof.'
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    result = check()
    data = json.dumps(result, ensure_ascii=False, indent=2)+'\n'
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(data, encoding='utf-8')
    print(data, end='')


if __name__ == '__main__':
    main()
