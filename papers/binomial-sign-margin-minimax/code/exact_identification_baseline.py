"""Exact algebraic diagnostics for the identification baseline, not a minimax solver.

Uses only the standard library. For integer beta and rational L, work modulo
L*beta*h**(beta+1) + L*(beta+1)*h**beta - (beta+1), with its unique root h in (0,1).
All stored certificate endpoints and polynomial operations are rational.
"""
from fractions import Fraction as F
from math import comb
from pathlib import Path
import json
import hashlib


def trim(p):
    p = list(p)
    while len(p) > 1 and p[-1] == 0:
        p.pop()
    return p


def add(a, b):
    return trim([(a[i] if i < len(a) else F(0)) + (b[i] if i < len(b) else F(0))
                 for i in range(max(len(a), len(b)))])


def scale(p, c):
    return trim([x*c for x in p])


def reduce_poly(p, modulus):
    p = trim(p)
    while len(p) >= len(modulus) and p != [0]:
        shift = len(p) - len(modulus)
        factor = p[-1]/modulus[-1]
        p = add(p, [F(0)]*shift + scale(modulus, -factor))
    return p


def monomial(degree, coefficient=F(1)):
    return [F(0)]*degree + [F(coefficient)]


def evaluate(p, x):
    v = F(0)
    for a in reversed(p):
        v = v*x+a
    return v


def interval_evaluate(p, lo, hi):
    """Exact interval Horner evaluation; does not assume a minimal polynomial."""
    left = right = F(0)
    for a in reversed(p):
        products = [left*lo, left*hi, right*lo, right*hi]
        left, right = min(products)+a, max(products)+a
    return left, right


def raw_moment(j, beta, ell, modulus):
    # Positive density ell*beta*z^(beta-1) on (0,h), plus mass 1-ell*h^beta at -1.
    positive = monomial(beta+j, ell*beta/F(beta+j))
    endpoint = scale(add([F(1)], monomial(beta, -ell)), F((-1)**j))
    return reduce_poly(add(positive, endpoint), modulus)


def count_probability(n, k, moments, reflected, modulus):
    # Exact expansion of C(n,k) E[(1+Z)^k (1-Z)^(n-k)] / 2^n.
    p = [F(0)]
    for s in range(k+1):
        for t in range(n-k+1):
            j = s+t
            c = F(comb(n,k)*comb(k,s)*comb(n-k,t)*(-1)**t, 2**n)
            if reflected:
                c *= (-1)**j
            p = add(p, scale(moments[j], c))
    return reduce_poly(p, modulus)


def as_strings(p):
    return [str(x) for x in p]


def one_case(beta, ell):
    modulus = add(add(monomial(beta+1, ell*beta), monomial(beta, ell*(beta+1))), [F(-(beta+1))])
    lo, hi = F(0), F(1)
    assert evaluate(modulus, lo) < 0 < evaluate(modulus, hi)
    for _ in range(96):
        mid = (lo+hi)/2
        if evaluate(modulus, mid) < 0:
            lo = mid
        else:
            hi = mid
    assert evaluate(modulus, lo) <= 0 <= evaluate(modulus, hi)
    p_lo, p_hi = ell*lo**beta, ell*hi**beta
    assert F(1,2) < p_lo < p_hi < 1
    moments = [raw_moment(j,beta,ell,modulus) for j in range(4)]
    assert moments[0] == [1]
    assert moments[1] == [0]
    checks=[]
    for n in (1,2,3):
        plus=[count_probability(n,k,moments,False,modulus) for k in range(n+1)]
        minus=[count_probability(n,k,moments,True,modulus) for k in range(n+1)]
        total=[F(0)]
        for p in plus:
            total=add(total,p)
        assert reduce_poly(total,modulus)==[1]
        equal=plus==minus
        assert equal == (n in (1,2))
        inequality_certificate = None
        if n == 3:
            difference = add(plus[0], scale(minus[0], F(-1)))
            difference_interval = interval_evaluate(difference, lo, hi)
            assert difference_interval[0] > 0 or difference_interval[1] < 0
            inequality_certificate = {'count':0,'difference_coefficients':as_strings(difference),'difference_interval':[str(x) for x in difference_interval],'interval_excludes_zero':True,'reason':'Fraction interval Horner evaluation at the isolated positive root; nonzero remainder alone is not used as a value certificate.'}
        checks.append({'n':n,'equal_output_laws':equal,'plus_coefficients_mod_root_polynomial':[as_strings(p) for p in plus],'minus_coefficients_mod_root_polynomial':[as_strings(p) for p in minus],'inequality_certificate':inequality_certificate})
    return {'beta':beta,'L':str(ell),'root_polynomial':as_strings(modulus),'h_interval':[str(lo),str(hi)],'p_interval':[str(p_lo),str(p_hi)],'risk_floor_interval':[str(p_lo-F(1,2)),str(p_hi-F(1,2))],'normalization_exact':True,'mean_zero_exact':True,'channel_checks':checks}


def main():
    records=[one_case(beta,ell) for beta in (1,2,3,4,6,8) for ell in (F(1),F(3,2),F(2),F(5))]
    source=Path(__file__)
    result={'status':'PASS','arithmetic':'fractions.Fraction plus exact polynomial quotient arithmetic; no floating-point step','instances':len(records),'channel_pairs_checked':3*len(records),'equal_pairs_certified':2*len(records),'unequal_n3_pairs_certified':len(records),'scope':'Finite algebraic diagnostics of B2/B3 examples. Not a proof for arbitrary real beta,L, not a joint Q,n minimax certificate.','source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),'records':records}
    out=source.parent.parent/'results'/'exact_identification_baseline.json'
    out.write_text(json.dumps(result,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='records'},ensure_ascii=False))


if __name__=='__main__':
    main()
