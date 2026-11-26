"""Exact resonant Fourier-block rank certificate at a published K=21 boundary.

This is secondary research on the SAME frozen topic. The parameter existence,
global exposed support, positive spectral weights and active lag set are cited
from Pasechnyuk-Vilensky--Takac, arXiv:2610.09912v2, Theorem 3.17, Table 2 and
Appendix G.4. Those published assertions are not re-proved here.

The new checks are complex coefficient-matrix minors over the entire published
rational parameter enclosure. Only exact Fraction interval arithmetic is used.
The interval and Machin-pi primitives are shared with the audited G.15 checker.
"""

from fractions import Fraction as F
from functools import lru_cache
from itertools import combinations, combinations_with_replacement, permutations
from math import factorial
import json

from check_rank_rigidity_g15 import I, C, PI


def round_complex(z, denominator=10**18):
    return C(z.re.rounded_out(denominator), z.im.rounded_out(denominator))


@lru_cache(maxsize=None)
def cis(k, period):
    k %= period
    if k > period // 2:
        k -= period
    if k == 0:
        return C.cast(1)
    x = 2*k*PI/period
    bound = max(abs(x.lo), abs(x.hi))
    cosine, sine = I.cast(0), I.cast(0)
    n = 18
    for j in range(n+1):
        cosine += (-1)**j*x**(2*j)/factorial(2*j)
        sine += (-1)**j*x**(2*j+1)/factorial(2*j+1)
    e_cos = bound**(2*n+1)/factorial(2*n+1)
    e_sin = bound**(2*n+2)/factorial(2*n+2)
    return round_complex(C(cosine+I(-e_cos, e_cos),
                           sine+I(-e_sin, e_sin)))


K = 21
POSITIVE_MODES = [3, 4, 5]
SIGNED_MODES = sorted(POSITIVE_MODES + [-m for m in POSITIVE_MODES])
LAGS = [1, -12, -4]
KAPPA = I(F('106.8055118'), F('106.8055121'))  # L/mu, not mu/L
GAMMA = I.cast(F('2.240775'))
BETA = I.cast(F('0.6152'))
MU = 1/KAPPA
DEN = (1-MU)*GAMMA
assert 0 < MU.lo <= MU.hi < 1
assert 0 < BETA.lo <= BETA.hi < 1
assert 0 < GAMMA.lo <= GAMMA.hi < 2*(1+BETA.lo)


@lru_cache(maxsize=None)
def multiplier(k):
    z = cis(k, K)
    return C(((1+BETA-MU*GAMMA)-(1+BETA)*z.re)/DEN,
             -(1-BETA)*z.im/DEN)


def pair_coefficient(lag, p, q):
    mp, mq = multiplier(p), multiplier(q)
    ans = (1-mp)*mq*(cis(lag*q, K)-1)
    if p != q:
        ans += (1-mq)*mp*(cis(lag*p, K)-1)
    return round_complex(ans)


def determinant(matrix):
    n = len(matrix)
    assert all(len(row) == n for row in matrix)
    value = C.cast(0)
    for perm in permutations(range(n)):
        inversions = sum(perm[i] > perm[j] for i in range(n) for j in range(i+1,n))
        term = C.cast((-1)**inversions)
        for i in range(n):
            term *= matrix[i][perm[i]]
        value += term
    return value


groups = {}
for p, q in combinations_with_replacement(SIGNED_MODES, 2):
    s = (p+q) % K
    if s:
        groups.setdefault(s, []).append((p,q))

records = []
for s, pairs in sorted(groups.items()):
    # Column 0 is the unknown auxiliary potential coefficient. Remaining
    # columns are the distinct complex-bilinear Gram entries at this sum.
    matrix = [[round_complex(cis(lag*s,K)-1)] +
              [-pair_coefficient(lag,p,q) for p,q in pairs]
              for lag in LAGS]
    columns = 1+len(pairs)
    assert columns <= len(LAGS), (s,pairs)
    chosen = None
    for rows in combinations(range(len(LAGS)),columns):
        minor = [[matrix[i][j] for j in range(columns)] for i in rows]
        det = determinant(minor)
        if det.re.excludes_zero() or det.im.excludes_zero():
            chosen = {'sum_residue':s,'unordered_signed_pairs':[list(x) for x in pairs],
                      'matrix_shape':[len(LAGS),columns],
                      'selected_lags':[LAGS[i] for i in rows],
                      'minor':[[z.output() for z in row] for row in minor],
                      'determinant':det.output()}
            break
    assert chosen is not None, ('unproved rank',s,pairs)
    records.append(chosen)

assert len(records) == 14
assert set(groups[1]) == {(-4,5),(-3,4)}
assert set(groups[8]) == {(3,5),(4,4)}

output = {
    'status':'PASS',
    'arithmetic':'exact rational intervals; no floating-point assertions',
    'source':'Pasechnyuk-Vilensky and Takac, arXiv:2610.09912v2, Theorem 3.17/Table 2/G.4',
    'published_dependencies_not_reproved':['parameter existence','global dual sign and exact support',
                                        'positive unique spectral masses','positive weights on active lags'],
    'period':K,'positive_modes':POSITIVE_MODES,'signed_modes':SIGNED_MODES,'active_lags':LAGS,
    'parameter_box':{'kappa_L_over_mu':KAPPA.output(),'gamma_L':GAMMA.output(),'beta':BETA.output()},
    'blocks':records,
    'block_count':len(records),
    'new_statement_verified_by_finite_checks':'every nonzero quadratic Fourier block has full column rank',
    'theorem_consequence':'with the published exposure and full-support spectral facts, every periodic orbit has affine dimension six and least period twenty-one',
    'not_claimed':['complete planar domain','full Lean verification','new construction of the published tuning']
}

if __name__ == '__main__':
    print(json.dumps(output,indent=2))
