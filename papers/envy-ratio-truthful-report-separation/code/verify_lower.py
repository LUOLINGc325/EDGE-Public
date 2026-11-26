"""Generate and verify exact rational dual certificates for random-phantom envy.

This is ordinary reproducibility code, not Lean/formalization code.
Previously proposed weights are fixed below. All calculations and assertions
use exact rational arithmetic; this script requires only Python's standard library.
"""
from fractions import Fraction as Q
from math import comb
from pathlib import Path
import json
import sys


def add(a, b):
    out = [Q(0)] * max(len(a), len(b))
    for i, v in enumerate(a): out[i] += v
    for i, v in enumerate(b): out[i] += v
    while len(out) > 1 and out[-1] == 0: out.pop()
    return out


def scale(a, s): return [s * x for x in a]


def mul(a, b):
    out = [Q(0)] * (len(a) + len(b) - 1)
    for i, u in enumerate(a):
        for j, v in enumerate(b): out[i+j] += u*v
    return out


def quotient(a, b):
    a = list(a)
    out = [Q(0)] * (len(a) - len(b) + 1)
    for i in range(len(out)-1, -1, -1):
        c = a[i+len(b)-1] / b[-1]
        out[i] = c
        for j, v in enumerate(b): a[i+j] -= c*v
    assert all(v == 0 for v in a)
    return out


def point(a, y):
    out = Q(0)
    for v in a[::-1]: out = out*y + v
    return out


def bernstein(poly, lo, hi):
    n = len(poly) - 1
    power = [Q(0)] * (n+1)
    for i, c in enumerate(poly):
        for j in range(i+1):
            power[j] += c * comb(i,j) * lo**(i-j) * (hi-lo)**j
    return [sum((power[j] * Q(comb(k,j),comb(n,j)) for j in range(k+1)),Q(0)) for k in range(n+1)]


def certify(poly, lo, hi, depth=0):
    bs = bernstein(poly,lo,hi)
    if min(bs) >= 0:
        return [{"left":str(lo),"right":str(hi),"bernstein":[str(b) for b in bs]}]
    if depth >= 16:
        raise ValueError((lo,hi,depth,min(bs)))
    mid = (lo+hi)/2
    return certify(poly,lo,mid,depth+1) + certify(poly,mid,hi,depth+1)


def kernel_terms(x,y):
    # (numerator coefficients, denominator coefficients) for k(y,x), k(1-y,x).
    if y < x/2:
        first = ([Q(1),Q(-1)],[1-x,Q(1)])
    else:
        first = ([1-x,Q(1)],[Q(1),Q(-1)])
    if y < 1-x:
        second = ([1/(1-x)],[Q(1)])
    else:
        second = ([2-x,Q(-1)],[Q(0),Q(1)])
    return first,second


def generate(xs, weights, lower):
    assert sum(weights) == 1 and min(weights)>=0
    points = sorted(set([Q(0),Q(1,2)] + [v for x in xs for v in (x/2,1-x) if 0<v<Q(1,2)]))
    records=[]
    for lo,hi in zip(points,points[1:]):
        mid=(lo+hi)/2
        terms=[]
        for x,w in zip(xs,weights):
            for n,d in kernel_terms(x,mid): terms.append((scale(n,w/2),d))
        factors=[]
        for _,d in terms:
            if len(d)>1 and d not in factors: factors.append(d)
        denominator=[Q(1)]
        for d in factors:
            assert min(point(d,lo),point(d,hi))>0
            denominator=mul(denominator,d)
        numerator=scale(denominator,-lower)
        for n,d in terms:
            numerator=add(numerator,mul(n,quotient(denominator,d)))
        proof=certify(numerator,lo,hi)
        records.append({"left":str(lo),"right":str(hi),"positive_denominator_factors":[[str(c) for c in d] for d in factors],"numerator":[str(c) for c in numerator],"subintervals":proof})
    result={"criterion":"expected ex post envy divided by deterministic optimum","family":"all Borel report-independent phantom laws, clamped to reported extrema","adversary":"q_j/2 on (0,x_j), q_j/2 on (1-x_j,1)","x":[str(x) for x in xs],"q":[str(w) for w in weights],"lower":str(lower),"reflection":"h(y)=h(1-y)","intervals":records}
    # Recompute every stored Bernstein coefficient independently from stored polynomials.
    for rec in records:
        poly=list(map(Q,rec['numerator']))
        for sub in rec['subintervals']:
            bs=bernstein(poly,Q(sub['left']),Q(sub['right']))
            assert bs==list(map(Q,sub['bernstein'])) and min(bs)>=0
    return result


if __name__=='__main__':
    mode=sys.argv[1] if len(sys.argv)>1 else '21'
    if mode=='7':
        xs=[Q(k,30) for k in range(15,22)]
        qs=[Q(k,10000) for k in [315,3427,963,1272,814,2866,343]]
        lower=Q(4519,2500)  # 1.8076
    elif mode=='21':
        xs=[Q(k,100) for k in range(50,71)]
        nums=[2804,130421,34098,68547,48220,60079,41417,52791,
              34343,49757,26694,42641,29775,29936,29084,32205,
              97966,97615,18842,60847,11918]
        qs=[Q(v,1000000) for v in nums]
        lower=Q(3617,2000)  # 1.8085
    else:
        raise SystemExit('Use mode 21 or 7')
    result=generate(xs,qs,lower)
    target=Path(__file__).resolve().parents[1] / 'results' / f'lower_certificate_{mode}.json'
    target.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({"path":str(target),"lower":str(lower),"lower_decimal":float(lower),"q":[str(q) for q in qs],"base_intervals":len(result['intervals']),"certified_subintervals":sum(len(r['subintervals']) for r in result['intervals']),"max_polynomial_degree":max(len(r['numerator'])-1 for r in result['intervals'])},indent=2))
