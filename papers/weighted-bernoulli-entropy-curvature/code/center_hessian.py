#!/usr/bin/env python3
"""Directed probe of the full heterogeneous entropy Hessian at p_i=1/2.

This is a new, stronger candidate than the registered common-parameter problem.
Only a small deterministic collection is examined. Any discovered positive
eigenvalue is followed by an exact rational direction and logarithm interval.
"""
from __future__ import annotations
from collections import Counter, defaultdict
from datetime import datetime,timezone
from fractions import Fraction as F
from functools import lru_cache
from itertools import combinations_with_replacement
import json
from pathlib import Path
import random
import numpy as np

from exact_curvature_certificate import bound_expression, decimal_string


@lru_cache(maxsize=None)
def cube(n):
    values=np.arange(1<<n,dtype=np.int64)
    bits=((values[:,None]>>np.arange(n))&1).astype(np.int64)
    return bits,2*bits-1


def hessian(weights):
    n=len(weights)
    bits,eps=cube(n)
    sums=bits@np.array(weights,dtype=np.int64)
    counts=np.bincount(sums)
    use=counts>0
    support_counts=counts[use]
    a=np.array([np.bincount(sums,weights=eps[:,i],minlength=len(counts))[use] for i in range(n)])
    logs=np.log(counts[sums].astype(np.float64))
    first=eps.T@(eps*logs[:,None])-np.eye(n)*sum(logs)
    second=(a/support_counts)@a.T
    h=-4/(1<<n)*(first+second)
    return (h+h.T)/2,int(max(counts)),counts,sums


def exact_direction_expression(weights,direction):
    """H'' along p_i(t)=1/2+t*d_i, all data rational except logarithms."""
    n=len(weights)
    bits,eps=cube(n)
    sums=bits@np.array(weights,dtype=np.int64)
    by_sum=defaultdict(list)
    for s,row in zip(sums,eps):by_sum[int(s)].append(row)
    constant=F(0)
    coeff=defaultdict(F)
    direction=[F(x) for x in direction]
    norm2=sum(d*d for d in direction)
    for rows in by_sum.values():
        c=len(rows)
        scores=[sum(d*int(e) for d,e in zip(direction,row)) for row in rows]
        asum=sum(scores)
        bsum=sum(v*v-norm2 for v in scores)
        constant-=F(4,1<<n)*asum*asum/c
        coeff[c]-=F(4,1<<n)*bsum
    return constant,{k:v for k,v in coeff.items() if k>1 and v}


def certificate(weights,direction,terms=60):
    constant,coeff=exact_direction_expression(weights,direction)
    lo,hi=bound_expression(constant,coeff,terms)
    return {"weights":list(weights),"direction":list(map(str,direction)),"constant":str(constant),"log_terms":{str(k):str(v) for k,v in coeff.items()},"lower_rational":str(lo),"upper_rational":str(hi),"lower_decimal":decimal_string(lo),"upper_decimal":decimal_string(hi),"conclusion":"strict_positive_direction" if lo>0 else "strict_negative_direction" if hi<0 else "inconclusive","scope":"one_heterogeneous_direction_at_all_parameters_one_half","series_terms":terms}


def cases():
    seen=set()
    rng=random.Random(2026112503)
    def take(w):
        w=tuple(sorted(w))
        if w in seen:return None
        seen.add(w)
        return w
    for w in ([1,1,2],[1,1,1,3,4],[1]*4,[1]*8,[1,2,3,4,5,6,7,8],[1,1,2,2,3,3,4,4,5,5]):
        a=take(w)
        if a:yield "baseline",a
    for n in range(4,11):
        for width in (3,6,12):
            for _ in range(12):
                w=take([1]+[rng.randint(1,width) for _ in range(n-1)])
                if w:yield "dense",w
        for _ in range(8):
            vals=[1,1]
            while len(vals)<n:
                vals.append(max(1,rng.choice(vals)+rng.choice(vals)+rng.choice((-1,0,1))))
            w=take(vals)
            if w:yield "recursive_relation",w


if __name__=="__main__":
    leaders=[]
    family_counts=Counter()
    max_fibre_hist=Counter()
    positives=[]
    for family,w in cases():
        h,max_fibre,_,_=hessian(w)
        evals,evecs=np.linalg.eigh(h)
        r={"family":family,"weights":list(w),"n":len(w),"maximum_fibre":max_fibre,"eigenvalues":evals.tolist(),"largest_eigenvalue":float(evals[-1]),"eigenvector":evecs[:,-1].tolist()}
        family_counts[family]+=1
        max_fibre_hist[max_fibre]+=1
        leaders.append(r)
        leaders.sort(key=lambda a:a["largest_eigenvalue"],reverse=True)
        del leaders[20:]
        if evals[-1]>1e-8:
            direction=np.rint(evecs[:,-1]*1000).astype(np.int64).tolist()
            c=certificate(w,direction)
            r["rational_direction_certificate"]=c
            positives.append(r)
            print(json.dumps({"positive_candidate":r}),flush=True)
            if c["conclusion"]=="strict_positive_direction":break
    out={"timestamp_utc":datetime.now(timezone.utc).isoformat(),"weight_vectors":sum(family_counts.values()),"family_counts":dict(family_counts),"maximum_fibre_histogram":dict(max_fibre_hist),"positive_candidates":positives,"leaders":leaders,"status":"bounded_directed_probe_not_universal_proof"}
    path=Path(__file__).with_name("center_hessian_results.json")
    path.write_text(json.dumps(out,indent=2)+"\n")
    print(json.dumps({k:v for k,v in out.items() if k not in ("leaders","positive_candidates")}),flush=True)
    print(json.dumps({"top":leaders[:3]}),flush=True)
