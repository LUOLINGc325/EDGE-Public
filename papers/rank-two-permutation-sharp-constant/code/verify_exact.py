#!/usr/bin/env python3
"""Fresh exact finite certificate after recovery; not an asymptotic proof.

All checks use integers/Fraction and explicit exceptions, including under -O.
The previous checker was lost in an environment reset. This replacement states
its complete tested domains and regenerates its own certificate; it does not
claim source-byte identity or reuse a historical success status.
"""
from collections import Counter
from fractions import Fraction as F
from functools import lru_cache
from itertools import product, combinations
from math import comb
from pathlib import Path
import hashlib
import json


COUNTS=Counter()


def check(ok, group):
    if not ok:
        raise ArithmeticError(group)
    COUNTS[group]+=1


def bernoulli_sum(ps):
    out=[F(1)]
    for p in ps:
        nxt=[F(0)]*(len(out)+1)
        for i,x in enumerate(out):
            nxt[i]+=(1-p)*x; nxt[i+1]+=p*x
        out=nxt
    return out


@lru_cache(None)
def kernel(n,w,a,b):
    x=[F(comb(n-w,k))*a**k*(1-a)**(n-w-k) for k in range(n-w+1)]
    y=[F(comb(w,k))*b**k*(1-b)**(w-k) for k in range(w+1)]
    out=[F(0)]*(n+1)
    for i,p in enumerate(x):
        for j,q in enumerate(y):out[i+j]+=p*q
    return tuple(out)


def enumerate_words(ps):
    out=[F(0)]*(len(ps)+1)
    for bits in product([0,1],repeat=len(ps)):
        p=F(1)
        for bit,q in zip(bits,ps):p*=q if bit else 1-q
        out[sum(bits)]+=p
    return out


def inverse(a):
    n=len(a);m=[list(row)+[F(i==j) for j in range(n)] for i,row in enumerate(a)]
    for i in range(n):
        pivot=next(j for j in range(i,n) if m[j][i])
        m[i],m[pivot]=m[pivot],m[i]
        d=m[i][i];m[i]=[v/d for v in m[i]]
        for j in range(n):
            if j!=i:
                d=m[j][i];m[j]=[x-d*y for x,y in zip(m[j],m[i])]
    return [row[n:] for row in m]


def main():
    pairs=[(F(1,10),F(9,10)),(F(1,20),F(2,5)),(F(3,20),F(93,100)),
           (F(1,1000),F(9,10)),(F(1,5),F(21,100))]
    for a,b in pairs:
        for n in range(1,17):
            laws=[kernel(n,w,a,b) for w in range(n+1)]
            for w,p in enumerate(laws):
                q=a+(b-a)*F(w,n);v=a*b+(1-a-b)*q
                check(sum(p)==1,'normalizations')
                check(sum(F(y)*p[y] for y in range(n+1))==n*q,'moment_checks')
                check(sum((F(y)-n*q)**2*p[y] for y in range(n+1))==n*v,'moment_checks')
                for y in range(1,n):check(p[y]**2>=p[y-1]*p[y+1],'log_concavity')
                if n<=7:
                    independent=enumerate_words([a]*(n-w)+[b]*w)
                    for x,y in zip(p,independent):check(x==y,'enumerated_outcome_coefficients')
            for w in range(n):
                r=bernoulli_sum([a]*(n-w-1)+[b]*w)
                get=lambda y:r[y] if 0<=y<len(r) else F(0)
                p,t=laws[w],laws[w+1]
                for y in range(n):
                    det=t[y+1]*p[y]-t[y]*p[y+1]
                    check(det==(b-a)*(get(y)**2-get(y-1)*get(y+1)) and det>=0,'adjacent_mlr_determinants')
    a,b=pairs[0]
    for ts in [(F(1,4),)*3,(F(1,2),)*3,(F(3,4),)*3,(F(1,4),F(1,2),F(3,4))]:
        direct=enumerate_words([a+(b-a)*t for t in ts]);mix=[F(0)]*4
        for w,weight in enumerate(bernoulli_sum(ts)):
            for y,p in enumerate(kernel(3,w,a,b)):mix[y]+=weight*p
        for x,y in zip(direct,mix):check(x==y,'endpoint_simulation_coefficients')
    channels=[([F(1,10),F(9,10)],[F(9,10),F(1,10)]),
              ([F(1,2),F(1,3),F(1,6)],[F(1,6),F(1,3),F(1,2)]),
              ([F(1,10),F(1,5),F(3,10),F(2,5)],[F(2,5),F(3,10),F(1,5),F(1,10)])]
    for p0,p1 in channels:
        r=len(p0)-1;u=[p1[i]-p0[i] for i in range(r)]
        c=lambda p:[[p[i]*F(i==j)-p[i]*p[j] for j in range(r)] for i in range(r)]
        c0,c1=c(p0),c(p1)
        for t in [F(0),F(1,4),F(1,2),F(3,4),F(1)]:
            v=[[(1-t)*c0[i][j]+t*c1[i][j] for j in range(r)] for i in range(r)]
            vi=inverse(v);j=sum(u[i]*vi[i][k]*u[k] for i in range(r) for k in range(r))
            fisher=sum((y-x)**2/((1-t)*x+t*y) for x,y in zip(p0,p1))
            den=1-t*(1-t)*fisher
            check(den>0 and j==fisher/den,'covariance_metric_identities')
    best=[]
    for a,b in pairs[:2]:
        for n in range(1,9):
            laws=[kernel(n,w,a,b) for w in range(n+1)]
            records={}
            for m in range(2,n+2):
                top=F(-1);top_types=None
                for types in combinations(range(n+1),m):
                    decisions=[max(range(m),key=lambda j:(laws[types[j]][y],j)) for y in range(n+1)]
                    envelope=sum(max(laws[w][y] for w in types) for y in range(n+1))
                    assigned=sum(laws[types[decisions[y]]][y] for y in range(n+1))
                    check(decisions==sorted(decisions) and envelope==assigned,'small_codebooks')
                    if envelope>top:top,top_types=envelope,types
                records[str(m)]={'best_types':list(top_types),'optimal_average_success':str(top/m)}
            best.append({'a':str(a),'b':str(b),'n':n,'code_sizes':records})
    source=Path(__file__).resolve()
    result={'status':'passed','arithmetic':'exact integer and Fraction','checks':dict(sorted(COUNTS.items())),
            'total_checks':sum(COUNTS.values()),'binary_pairs':[[str(a),str(b)] for a,b in pairs],
            'domains':{'kernel_and_moments':'all n=1..16 and w=0..n, five rational endpoint pairs',
                       'word_enumeration':'all n=1..7 and w=0..n, same five pairs',
                       'small_codebooks':'all distinct type subsets of size >=2, n=1..8, first two endpoint pairs',
                       'covariance':'three specified finite-output channels and five rational compositions'},
            'exhaustive_small_binary_codes':best,'source_sha256':hashlib.sha256(source.read_bytes()).hexdigest(),
            'recovery_note':'Fresh replacement verifier and fresh run after temporary-directory reset; not a byte-identical recovery of the earlier 19728-check program.',
            'scope':'finite exact evidence; not a universal or asymptotic theorem proof'}
    out=source.parents[1]/'results/exact_certificate.json';out.parent.mkdir(exist_ok=True)
    out.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({'status':'passed','checks':result['checks'],'total':result['total_checks']},indent=2))


if __name__=='__main__':main()
