#!/usr/bin/env python3
"""Explore rank-fibre decompositions; statements here are numerical only.

For K=sum B_i, the conditional law S|K=k is p-independent. Define f_k=H(S|K=k).
Then H(S)=E[f_K]+I(K;S). We test the two summands' curvatures separately and
the discrete concavity of f_k. This can falsify overly strong proof strategies.
"""
from __future__ import annotations
from collections import Counter
from datetime import datetime, timezone
import json
import math
from pathlib import Path
import random
import time
import numpy as np

from entropy_search import binomial_coefficients, grouped_curvature


def exact_int64_counts(weights):
    n=len(weights)
    if n>60: raise ValueError("int64 count table requires n<=60")
    table=np.zeros((n+1,sum(weights)+1),dtype=np.int64)
    table[0,0]=1
    used=0
    for i,w in enumerate(weights):
        for k in range(i+1,0,-1):
            table[k,w:w+used+1]+=table[k-1,:used+1]
        used+=w
    assert int(table.sum())==2**n
    for k in range(n+1): assert int(table[k].sum())==math.comb(n,k)
    return table


def diagnostics(weights,grid):
    n=len(weights)
    c=exact_int64_counts(weights)
    f=[]
    for k in range(n+1):
        counts=c[k,c[k]>0].astype(np.longdouble)
        total=np.longdouble(math.comb(n,k))
        f.append(float(np.log(total)-np.sum(counts*np.log(counts))/total))
    f=np.array(f,dtype=np.longdouble)
    dd=f[2:]-2*f[1:-1]+f[:-2]
    records=[]
    for p in grid:
        p=np.longdouble(p)
        k=np.arange(n-1,dtype=np.longdouble)
        hcond_second=float(n*(n-1)*np.sum(binomial_coefficients(n-2)*p**k*(1-p)**(n-2-k)*dd))
        full=grouped_curvature(weights,p)
        records.append({"p":float(p),"entropy_second":full["entropy_second"],"conditional_rank_entropy_second":hcond_second,"mutual_information_second":full["entropy_second"]-hcond_second,"scaled_binomial_gap":float(p*(1-p)*(full["entropy_second"]-grouped_curvature([1]*n,p)["entropy_second"]))})
    middle=n//2
    return {
        "weights":list(weights),"n":n,"sum_weights":sum(weights),
        "layer_entropies":list(map(float,f)),"max_layer_second_difference":float(max(dd)),"max_layer_second_difference_k":int(np.argmax(dd)),
        "max_conditional_curvature":max(records,key=lambda r:r["conditional_rank_entropy_second"]),
        "max_mutual_information_curvature":max(records,key=lambda r:r["mutual_information_second"]),
        "max_binomial_gap":max(records,key=lambda r:r["scaled_binomial_gap"]),
        "mixed_cardinality_fibres":int(np.sum(np.sum(c>0,axis=0)>1)),
        "support_size":int(np.sum(np.sum(c,axis=0)>0)),
        "central_layer_collision_entropy":float(math.log(math.comb(n,middle))-f[middle]),
    }


def cases():
    seen=set()
    rng=random.Random(2026112502)
    def accept(w):
        w=tuple(sorted(w))
        if w in seen or sum(w)>3500 or len(w)>60:return None
        seen.add(w)
        return w
    for n in (5,8,12,20,32,48):
        for width in (5,12,24,48):
            for _ in range(5):
                w=accept([1]+[rng.randint(1,width) for _ in range(n-1)])
                if w:yield "dense_distinct_draw",w
    for n in (8,12,20,32):
        for width in (2,4,8):
            for center in (3,10,40):
                w=accept([1]+[center+rng.randint(0,width) for _ in range(n-1)])
                if w:yield "narrow_high_weight_band_plus_one",w
    for a in range(2,15):
        for b in range(a+1,min(20,2*a+3)):
            w=accept([1,1,a,a,a,b,b,b,a+b,a+b,a+b-1])
            if w:yield "mixed_cardinality_relation_cluster",w
    for n in (8,12,20,32):
        for split in (2,4,6):
            tail=[1]*split
            while len(tail)<n:
                tail.append(rng.choice(tail)+rng.choice(tail)+rng.choice((-1,0,1)))
                tail[-1]=max(1,min(tail[-1],80))
            w=accept(tail)
            if w:yield "recursive_relations",w


if __name__=="__main__":
    grid=np.r_[.002,.005,.01,.02,.05,.1,np.linspace(.15,.5,8)]
    start=time.monotonic()
    leaders={key:[] for key in ("layer","conditional","mutual","binomial")}
    family_counts=Counter()
    num=0
    positive_counts=Counter()
    for family,w in cases():
        r=diagnostics(w,grid)
        r["family"]=family
        family_counts[family]+=1
        num+=1
        values={"layer":r["max_layer_second_difference"],"conditional":r["max_conditional_curvature"]["conditional_rank_entropy_second"],"mutual":r["max_mutual_information_curvature"]["mutual_information_second"],"binomial":r["max_binomial_gap"]["scaled_binomial_gap"]}
        for key,value in values.items():
            leaders[key].append((value,r))
            leaders[key].sort(key=lambda t:t[0],reverse=True)
            del leaders[key][15:]
            if value>1e-9:
                positive_counts[key]+=1
                if positive_counts[key]<=5: print(json.dumps({"violation_type":key,"value":value,"record":r}),flush=True)
        if num%25==0: print(json.dumps({"completed":num,"elapsed_seconds":round(time.monotonic()-start,2),"maxima":{k:v[0][0] for k,v in leaders.items()}}),flush=True)
    out={"timestamp_utc":datetime.now(timezone.utc).isoformat(),"weight_vectors":num,"family_counts":dict(family_counts),"grid":grid.tolist(),"positive_counts":dict(positive_counts),"leaders":leaders,"elapsed_seconds":time.monotonic()-start,"status":"exploratory_numerical_not_proof"}
    Path(__file__).with_name("collision_diagnostics_results.json").write_text(json.dumps(out,indent=2)+"\n")
    print(json.dumps({k:v for k,v in out.items() if k not in ("leaders","grid")}),flush=True)
