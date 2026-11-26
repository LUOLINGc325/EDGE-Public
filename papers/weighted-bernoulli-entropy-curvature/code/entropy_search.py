#!/usr/bin/env python3
"""Reproducible exploratory curvature search; numerical output is not a proof.

Two independent probability engines:
* group convolution propagates q,q',q'' for Bin(m,p) terms at each distinct jump;
* exact integer collision counts N[s,k], evaluated in arbitrary precision.

Only positive integer weights containing 1 belong to the registered target.
Natural logarithms are used throughout.
"""
from __future__ import annotations

import argparse
from collections import Counter
from datetime import datetime, timezone
from functools import lru_cache
from itertools import combinations_with_replacement, product
import json
import math
from pathlib import Path
import random
import time

import numpy as np


@lru_cache(maxsize=None)
def binomial_coefficients(n: int) -> np.ndarray:
    return np.array([math.comb(n, k) for k in range(n + 1)], dtype=np.longdouble)


def grouped_curvature(weights, p):
    """Compute entropy and derivatives with direct (never FFT) convolutions."""
    p = np.longdouble(p)
    if not 0 < p < 1:
        raise ValueError("curvature is evaluated only at interior p")
    q = np.array([1], dtype=np.longdouble)
    r = np.array([0], dtype=np.longdouble)
    t = np.array([0], dtype=np.longdouble)
    for w, m in sorted(Counter(weights).items()):
        k = np.arange(m + 1, dtype=np.longdouble)
        prob = binomial_coefficients(m) * p**k * (1-p)**(m-k)
        score = k/p - (m-k)/(1-p)
        score_prime = -k/p**2 - (m-k)/(1-p)**2
        b = np.zeros(m*w+1, dtype=np.longdouble)
        d = np.zeros_like(b)
        e = np.zeros_like(b)
        b[::w] = prob
        d[::w] = prob*score
        e[::w] = prob*(score*score+score_prime)
        nq = np.convolve(q, b)
        nr = np.convolve(r, b) + np.convolve(q, d)
        nt = np.convolve(t, b) + 2*np.convolve(r, d) + np.convolve(q, e)
        q, r, t = nq, nr, nt
    positive = q > 0
    qp, rp, tp = q[positive], r[positive], t[positive]
    logs = np.log(qp)
    h = -np.sum(qp*logs)
    hp = -np.sum(rp*logs)
    hpp = -np.sum(tp*logs+rp*(rp/qp))
    return {
        "p": float(p), "entropy": float(h), "entropy_prime": float(hp),
        "entropy_second": float(hpp),
        "scaled_second": float(p*(1-p)*hpp),
        "strong_margin": float(p*(1-p)*hpp+1),
        "mass_error": float(abs(np.sum(q)-1)),
        "derivative_mass_error": float(abs(np.sum(r))),
        "second_derivative_mass_error": float(abs(np.sum(t))),
        "support_size": int(np.sum(positive)),
    }


def scalar_dp(weights, p):
    """Independent item-by-item derivative recurrence for engine checks."""
    p = np.longdouble(p)
    q = np.array([1], dtype=np.longdouble)
    r = np.array([0], dtype=np.longdouble)
    t = np.array([0], dtype=np.longdouble)
    for w in weights:
        nq = np.zeros(len(q)+w, dtype=np.longdouble)
        nr, nt = np.zeros_like(nq), np.zeros_like(nq)
        nq[:len(q)] += (1-p)*q
        nq[w:] += p*q
        nr[:len(q)] += (1-p)*r-q
        nr[w:] += p*r+q
        nt[:len(q)] += (1-p)*t-2*r
        nt[w:] += p*t+2*r
        q, r, t = nq, nr, nt
    use = q > 0
    return float(-np.sum(t[use]*np.log(q[use])+r[use]*(r[use]/q[use])))


def collision_counts(weights):
    """Exact Python-integer table indexed by subset sum and cardinality."""
    counts = {(0, 0): 1}
    for w in weights:
        out = counts.copy()
        for (s, k), c in counts.items():
            out[(s+w, k+1)] = out.get((s+w, k+1), 0)+c
        counts = out
    by_sum = {}
    for (s, k), c in counts.items():
        by_sum.setdefault(s, {})[k] = c
    return by_sum


def high_precision_curvature(weights, p_string, dps=100):
    """Independent arbitrary-precision evaluation using exact counts.

    This is a high-precision numerical cross-check, not an interval certificate.
    """
    import mpmath as mp
    mp.mp.dps = dps
    p = mp.mpf(p_string)
    n = len(weights)
    counts = collision_counts(weights)
    h = mp.mpf(0)
    hpp = mp.mpf(0)
    masses = [mp.mpf(0), mp.mpf(0), mp.mpf(0)]
    for layer in counts.values():
        q, r, t = mp.mpf(0), mp.mpf(0), mp.mpf(0)
        for k, c in layer.items():
            mass = c*p**k*(1-p)**(n-k)
            a = k/p-(n-k)/(1-p)
            a_prime = -k/p**2-(n-k)/(1-p)**2
            q += mass
            r += mass*a
            t += mass*(a*a+a_prime)
        h -= q*mp.log(q)
        hpp -= t*mp.log(q)+r*r/q
        for j, value in enumerate((q, r, t)):
            masses[j] += value
    return {
        "weights": list(weights), "p": str(p_string), "dps": dps,
        "entropy": mp.nstr(h, dps), "entropy_second": mp.nstr(hpp, dps),
        "scaled_second": mp.nstr(p*(1-p)*hpp, dps),
        "strong_margin": mp.nstr(p*(1-p)*hpp+1, dps),
        "mass_residuals": [mp.nstr(masses[0]-1, 8), mp.nstr(masses[1], 8), mp.nstr(masses[2], 8)],
        "support_size": len(counts),
        "mixed_cardinality_fibres": sum(len(layer)>1 for layer in counts.values()),
        "status": "arbitrary_precision_numerical_crosscheck_not_rigorous_interval",
    }


def canonical(weights):
    weights = tuple(sorted(int(w) for w in weights))
    if not weights or weights[0] != 1 or min(weights) <= 0:
        raise ValueError("registered target requires positive integer weights containing 1")
    return weights


@lru_cache(maxsize=None)
def binomial_curvature(n, p):
    return grouped_curvature([1]*n, p)["entropy_second"]


def families(mode):
    """Deterministic dense families plus seeded local mutations."""
    seen = set()
    def emit(label, w):
        w = canonical(w)
        if w in seen or sum(w)>4500 or len(w)>160:
            return None
        seen.add(w)
        return label, w

    for n in (1,2,3,4,8,16,32,64,128):
        val=emit("equal_weight_baseline", [1]*n)
        if val: yield val
    if mode in ("quick", "structured", "all"):
        counts = (1,2,4,8,16)
        for a in range(2,10):
            for m1,m2 in product(counts,repeat=2):
                val=emit("two_jump_multiplicity", [1]*m1+[a]*m2)
                if val: yield val
        triples = [(1,a,b) for a in range(2,7) for b in range(a+1,11)]
        if mode == "quick": triples = [(1,2,3),(1,2,4),(1,3,4),(1,4,5),(1,5,9)]
        for jumps in triples:
            for multiplicities in product((1,3,8),repeat=3):
                val=emit("three_jump_multiplicity", [w for w,m in zip(jumps,multiplicities) for _ in range(m)])
                if val: yield val
        for base in (2,3,4,5):
            for length in (3,4,5):
                for mult in (1,2,3,5,8):
                    for offset in (-1,0,1):
                        raw=[1]+[max(1,base**j+offset) for j in range(1,length)]
                        val=emit("near_carry_chain", sorted(raw*mult))
                        if val: yield val
        for a in range(2,18):
            for mult in (1,2,4,8):
                for raw in ([1,a,a+1,2*a,2*a+1], [1,a,a+1,a+2,2*a+1], [1,1,a,a+1,a+2,2*a+2]):
                    val=emit("resonant_relation_cluster", sorted(raw*mult))
                    if val: yield val
        for size in (4,8,12,20,32):
            for mult in (1,2,3):
                val=emit("dense_interval", list(range(1,size+1))*mult)
                if val: yield val
        for length in (5,8,12):
            fib=[1,1]
            while len(fib)<length: fib.append(fib[-1]+fib[-2])
            for mult in (1,2,3,5):
                val=emit("repeated_fibonacci", fib*mult)
                if val: yield val
    if mode in ("exhaustive", "all"):
        for n in range(2,9):
            for tail in combinations_with_replacement(range(1,9),n-1):
                val=emit("bounded_exhaustive", [1,*tail])
                if val: yield val
    if mode in ("structured", "all"):
        rng=random.Random(20261125)
        for _ in range(350):
            jumps=sorted({1,*[rng.randint(2,24) for _ in range(rng.randint(2,5))]})
            w=[a for a in jumps for _ in range(rng.randint(1,12))]
            val=emit("seeded_dense_multiplicity",w)
            if val: yield val


def run(mode, output):
    grid=np.unique(np.r_[np.geomspace(.002,.1,9),np.linspace(.12,.5,20)])
    start=time.monotonic()
    leaders=[]
    binomial_gap_leaders=[]
    counts=Counter()
    total_points=0
    max_residual=0.0
    for family,weights in families(mode):
        counts[family]+=1
        records=[grouped_curvature(weights,p) for p in grid]
        for rec in records:
            rec["binomial_second"] = binomial_curvature(len(weights),rec["p"])
            rec["binomial_curvature_gap"] = rec["entropy_second"]-rec["binomial_second"]
            rec["scaled_binomial_curvature_gap"] = rec["p"]*(1-rec["p"])*rec["binomial_curvature_gap"]
        total_points+=len(records)
        best=max(records,key=lambda x:x["scaled_second"])
        record={"family":family,"weights":list(weights),"n":len(weights),"sum_weights":sum(weights),**best}
        leaders.append(record)
        leaders.sort(key=lambda x:x["scaled_second"],reverse=True)
        del leaders[40:]
        gap_best=max(records,key=lambda x:x["scaled_binomial_curvature_gap"])
        gap_record={"family":family,"weights":list(weights),"n":len(weights),"sum_weights":sum(weights),**gap_best}
        binomial_gap_leaders.append(gap_record)
        binomial_gap_leaders.sort(key=lambda x:x["scaled_binomial_curvature_gap"],reverse=True)
        del binomial_gap_leaders[40:]
        max_residual=max(max_residual,max(r["second_derivative_mass_error"] for r in records))
        if record["strong_margin"]>1e-10:
            print(json.dumps({"candidate":record}),flush=True)
        if gap_record["scaled_binomial_curvature_gap"]>1e-10:
            print(json.dumps({"binomial_dominance_counterexample_candidate":gap_record}),flush=True)
        done=sum(counts.values())
        if done%100==0:
            print(json.dumps({"completed":done,"elapsed_seconds":round(time.monotonic()-start,2),"best_scaled_second":leaders[0]["scaled_second"]}),flush=True)
    data={
        "timestamp_utc":datetime.now(timezone.utc).isoformat(),
        "timestamp_asia_shanghai":datetime.now(timezone.utc).astimezone(__import__('zoneinfo').ZoneInfo('Asia/Shanghai')).isoformat(),
        "mode":mode,"grid":grid.tolist(),"family_counts":dict(counts),
        "weight_vectors":sum(counts.values()),"parameter_evaluations":total_points,
        "elapsed_seconds":time.monotonic()-start,"max_second_derivative_mass_residual":max_residual,
        "leaders":leaders,"binomial_gap_leaders":binomial_gap_leaders,
        "numerical_status":"exploratory_long_double_not_proof",
    }
    output.write_text(json.dumps(data,indent=2)+"\n")
    print(json.dumps({k:v for k,v in data.items() if k not in ("leaders","binomial_gap_leaders","grid")}),flush=True)
    print(json.dumps({"best":leaders[:3]}),flush=True)


def selfcheck():
    checks=[]
    for weights in ([1], [1,1], [1,1,2], [1,2,3,4], [1,1,2,2,3,3], [1,2,4,8]):
        for p in (.01,.17,.5):
            result=grouped_curvature(weights,p)
            reference=scalar_dp(weights,p)
            if abs(result["entropy_second"]-reference)>1e-10*max(1,abs(reference)):
                raise AssertionError((weights,p,result,reference))
            if max(result["mass_error"], result["derivative_mass_error"],result["second_derivative_mass_error"])>1e-10:
                raise AssertionError((weights,p,result))
            if weights==[1]:
                assert abs(result["scaled_second"]+1)<1e-12
            if weights==[1,2,4,8]:
                assert abs(result["scaled_second"]+4)<1e-12
            checks.append({"weights":weights,"p":p,"absolute_disagreement":abs(result["entropy_second"]-reference)})
    print(json.dumps({"checks":len(checks),"maximum_engine_disagreement":max(c["absolute_disagreement"] for c in checks)}))


if __name__=="__main__":
    ap=argparse.ArgumentParser()
    ap.add_argument("--mode",choices=("quick","structured","exhaustive","all"),default="quick")
    ap.add_argument("--output",type=Path,default=Path(__file__).with_name("search_results.json"))
    ap.add_argument("--selfcheck",action="store_true")
    ap.add_argument("--weights",type=str)
    ap.add_argument("--p",default="0.5")
    ap.add_argument("--dps",type=int,default=100)
    args=ap.parse_args()
    if args.selfcheck:
        selfcheck()
    elif args.weights:
        print(json.dumps(high_precision_curvature([int(x) for x in args.weights.split(',')],args.p,args.dps),indent=2))
    else:
        run(args.mode,args.output)
