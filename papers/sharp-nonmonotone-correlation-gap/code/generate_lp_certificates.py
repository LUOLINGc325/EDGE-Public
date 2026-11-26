#!/usr/bin/env python3
"""Independent finite-dimensional LP attack on a correlation-gap inequality.

The LP ranges over every nonnegative submodular set function on a fixed ground
set and normalizes its expectation under a fixed correlated distribution.
For n <= 4 we enumerate all coupling-polytope vertices by all invertible bases.
For larger n we sample vertices by independent random linear objectives.
Numerical solutions are accompanied by rational primal/dual certificates where
available. Nothing in this script proves an assertion for unbounded n.
"""
from fractions import Fraction as Q
from itertools import combinations
from pathlib import Path
import json
import math
import numpy as np
from scipy.optimize import linprog
from scipy.sparse import csr_matrix

ROOT=Path(__file__).resolve().parent.parent

def matrix(n):
    return np.array([[1]*(1<<n)]+[[int(bool(s&(1<<i))) for s in range(1<<n)] for i in range(n)],dtype=float)

def submod_rows(n):
    rows=[]; descriptions=[]
    for i,j in combinations(range(n),2):
        for s in range(1<<n):
            if s&((1<<i)|(1<<j)):continue
            row=np.zeros(1<<n,dtype=float)
            row[s]=1;row[s|(1<<i)|(1<<j)]=1
            row[s|(1<<i)]=-1;row[s|(1<<j)]=-1
            rows.append(row);descriptions.append((s,i,j))
    return np.array(rows),descriptions

def bases(n):
    A=matrix(n);result=[]
    for cols in combinations(range(1<<n),n+1):
        B=A[:,cols]
        det=round(float(np.linalg.det(B)))
        if det==0:continue
        inv=np.linalg.inv(B)
        rational=[[Q(round(v*abs(det)),abs(det)) for v in row] for row in inv]
        for i in range(n+1):
            for j in range(n+1):
                if sum(rational[i][k]*int(B[k,j]) for k in range(n+1))!=int(i==j):
                    raise RuntimeError('incorrect rational inverse')
        result.append((cols,inv,rational))
    return result

def vertices(n,x,cached):
    b=np.array([1]+list(map(float,x)));br=[Q(1)]+x
    found=set()
    for cols,inv,rational in cached:
        if np.min(inv@b)<-1e-10:continue
        z=[sum(v*w for v,w in zip(row,br)) for row in rational]
        if min(z)<0:continue
        pair=tuple((s,zv) for s,zv in zip(cols,z) if zv)
        found.add(pair)
    return sorted(found)

def sample_vertices(n,x,count,rng):
    A=matrix(n);b=np.array([1]+list(map(float,x)));found=set()
    for j in range(count):
        c=rng.normal(size=1<<n)
        if j%3==0:c*=10**rng.uniform(-1,1,size=1<<n)
        r=linprog(c,A_eq=A,b_eq=b,bounds=(0,None),method='highs')
        if not r.success:raise RuntimeError(r.message)
        z=[Q(float(v)).limit_denominator(10**8) for v in r.x]
        if sum(z)!=1 or any(sum(z[s] for s in range(1<<n) if s&(1<<i))!=x[i] for i in range(n)):
            raise RuntimeError('coupling reconstruction failure')
        found.add(tuple((s,zv) for s,zv in enumerate(z) if zv))
    return sorted(found)

def product_weights(n,x):
    return [math.prod((x[i] if s&(1<<i) else 1-x[i]) for i in range(n)) for s in range(1<<n)]

def rationalize_solution(r,AR,a,q):
    # Fractions are verified against the original inequalities, never trusted
    # because they happen to be near a floating point LP solution.
    for limit in (10**4,10**6,10**8,10**10,10**12):
        f=[Q(float(v)).limit_denominator(limit) for v in r.x]
        y=[Q(float(v)).limit_denominator(limit) for v in r.ineqlin.marginals]
        nu=Q(float(r.eqlin.marginals[0])).limit_denominator(limit)
        if min(f)<0 or any(v>0 for v in y):continue
        if sum(aa*ff for aa,ff in zip(a,f))!=1:continue
        if any(sum(Q(int(v))*ff for v,ff in zip(row,f))>0 for row in AR):continue
        if any(sum(Q(int(AR[i,j]))*y[i] for i in range(len(y)))+a[j]*nu>q[j] for j in range(len(f))):continue
        obj=sum(qj*fj for qj,fj in zip(q,f))
        if obj!=nu:continue
        return {'f':[str(v) for v in f],
                'dual_inequality':[[i,str(v)] for i,v in enumerate(y) if v],
                'dual_equality':str(nu),'objective':str(obj)}
    # Solve the numerically identified dual support exactly. A basic dual
    # normally has at most 2**n nonzero multipliers; all remaining inequalities
    # are checked after recovery.
    import sympy as sp
    ids=[i for i,v in enumerate(r.ineqlin.marginals) if abs(v)>1e-10]
    f=[Q(float(v)).limit_denominator(10**7) for v in r.x]
    js=[j for j,v in enumerate(f) if v>0]
    def R(z):return sp.Rational(z.numerator,z.denominator)
    M=sp.Matrix([[int(AR[i,j]) for i in ids]+[R(a[j])] for j in js])
    rhs=sp.Matrix([R(q[j]) for j in js])
    solution=sp.linsolve((M,rhs))
    if len(solution)!=1:return None
    z=list(next(iter(solution)))
    if any(v.free_symbols for v in z):return None
    y=[Q(0)]*len(AR)
    for i,v in zip(ids,z[:-1]):y[i]=Q(int(v.p),int(v.q))
    nu=Q(int(z[-1].p),int(z[-1].q))
    if min(f)<0 or any(v>0 for v in y):return None
    if sum(aa*ff for aa,ff in zip(a,f))!=1:return None
    if any(sum(Q(int(v))*ff for v,ff in zip(row,f))>0 for row in AR):return None
    if any(sum(Q(int(AR[i,j]))*y[i] for i in range(len(y)))+a[j]*nu>q[j] for j in range(len(f))):return None
    obj=sum(qj*fj for qj,fj in zip(q,f))
    if obj!=nu:return None
    return {'f':[str(v) for v in f],
            'dual_inequality':[[i,str(v)] for i,v in enumerate(y) if v],
            'dual_equality':str(nu),'objective':str(obj)}

def run():
    rng=np.random.default_rng(20261124)
    specs=[
      ('n2_balanced',['1/2','1/2']),
      ('n2_asymmetric',['1/5','4/5']),
      ('n3_balanced',['1/2']*3),
      ('n3_upper_construction',['1/2','1/4','1/4']),
      ('n3_sparse',['4/5','1/10','1/10']),
      ('n3_unequal',['2/5','1/5','3/10']),
      ('n4_balanced',['1/2']*4),
      ('n4_upper_construction',['1/2','1/6','1/6','1/6']),
      ('n4_sparse',['4/5','1/15','1/15','1/15']),
      ('n4_unequal',['4/5','1/10','1/20','1/20']),
      ('n4_small_max',['1/5']*4),
      ('n4_high',['4/5']*4),
      ('n5_sampled_upper',['1/2']+['1/8']*4),
      ('n5_sampled_sparse',['4/5']+['1/20']*4),
      ('n6_sampled_upper',['1/2']+['1/10']*5),
    ]
    cache={};case_results=[];cert_cases=[]
    for name,xs in specs:
        x=list(map(Q,xs));n=len(x);A,desc=submod_rows(n);q=product_weights(n,x)
        if n<=4:
            if n not in cache:cache[n]=bases(n)
            vs=vertices(n,x,cache[n]);mode='all coupling vertices'
        else:
            vs=sample_vertices(n,x,200,rng);mode='sampled coupling vertices'
        best=math.inf;best_cert=None;best_a=None;certs=[];failures=0
        for k,pair in enumerate(vs):
            a=[Q(0)]*(1<<n)
            for s,v in pair:a[s]=v
            r=linprog(list(map(float,q)),A_ub=csr_matrix(A),b_ub=np.zeros(len(A)),A_eq=[list(map(float,a))],b_eq=[1],bounds=(0,None),method='highs')
            if not r.success:raise RuntimeError(r.message)
            cc=rationalize_solution(r,A,a,q)
            if cc is None:
                failures+=1
                if n<=4:raise RuntimeError(f'rational certificate failed: {name} coupling {k}')
            else:
                cc['coupling']=[[s,str(v)] for s,v in pair]
                certs.append(cc)
            if r.fun<best-1e-10:
                best=float(r.fun);best_cert=cc;best_a=pair
        c=1-math.exp(-(1-float(max(x))))
        if best<c-1e-8:raise RuntimeError(f'COUNTEREXAMPLE FOUND: {name}, {best} < {c}')
        summary={'name':name,'n':n,'x':xs,'p':str(max(x)),'mode':mode,
                 'couplings':len(vs),'rational_certificates':len(certs),
                 'certificate_failures':failures,'minimum_lp_value':best,
                 'best_exact_value':None if best_cert is None else best_cert['objective'],
                 'conjectured_bound':c,'observed_margin':best-c}
        case_results.append(summary)
        cert_cases.append({'name':name,'n':n,'x':xs,'coverage':mode,'coupling_count':len(vs),'certificates':certs})
        print(json.dumps(summary),flush=True)
        (ROOT/'results'/'lp_summary.json').write_text(json.dumps({'method':'independent LP over the full nonnegative submodular cone; coupling coverage specified per case','cases':case_results},indent=2)+'\n')
        (ROOT/'results'/'lp_exact_certificates.json').write_text(json.dumps({'format':1,'cases':cert_cases},separators=(',',':'))+'\n')
    print('COMPLETE: finite LP attack found no counterexample. This is not an unbounded proof.',flush=True)

if __name__=='__main__':run()
