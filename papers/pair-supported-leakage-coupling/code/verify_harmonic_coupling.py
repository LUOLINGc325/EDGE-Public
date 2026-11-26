#!/usr/bin/env python3
"""Exact diagnostics for the common-threshold coupling.

No solver or Monte Carlo randomness is used in acceptance. A seeded RNG selects
small rational input fixtures only. Each fixture is checked by two independent
exact calculations: the full recursively generated tuple law, and the
subset-state label-use recurrence. These checks are not general proofs.
"""
from __future__ import annotations

from collections import defaultdict
from fractions import Fraction as F
from functools import lru_cache
from itertools import combinations
import hashlib
import json
import math
from pathlib import Path
import random

HERE = Path(__file__).resolve().parent

def require(condition, message):
    if not condition:
        raise RuntimeError(message)

def harmonic(n):
    return sum((F(1,k) for k in range(1,n+1)), F(0))

def marks_of(P):
    n, m = len(P), len(P[0])
    marks = []
    for y in range(m):
        levels = sorted({F(0)} | {P[i][y] for i in range(n)})
        for lo, hi in zip(levels, levels[1:]):
            if hi == lo:
                continue
            mask = sum(1 << i for i in range(n) if P[i][y] >= hi)
            require(mask != 0, "empty positive layer")
            marks.append((y, mask, hi-lo))
    return marks

def exact_scheme(P):
    """Full distribution by next-useful-event elimination."""
    n,m = len(P),len(P[0])
    marks=marks_of(P)
    @lru_cache(None)
    def law(mask):
        if mask == 0:
            return {(-1,)*n:F(1)}
        active=[(y,s & mask,r) for y,s,r in marks if s & mask]
        total=sum((r for _,_,r in active), F(0))
        require(total>0, "nonempty unassigned set cannot have zero rate")
        ans=defaultdict(F)
        for y,s,r in active:
            for child, mass in law(mask ^ s).items():
                tup=tuple(y if s & (1<<i) else child[i] for i in range(n))
                ans[tup]+=r*mass/total
        return dict(ans)
    return law((1<<n)-1)

def label_probabilities(P):
    """A separate scalar recurrence without tuple enumeration."""
    n,m=len(P),len(P[0])
    marks=marks_of(P)
    def one(target):
        @lru_cache(None)
        def use(mask):
            if mask == 0:
                return F(0)
            denominator=F(0)
            numerator=F(0)
            for label, offered, rate in marks:
                accepted=offered & mask
                if accepted:
                    denominator+=rate
                    if label == target:
                        numerator+=rate
                    else:
                        numerator+=rate*use(mask & ~accepted)
            return numerator/denominator
        return use((1<<n)-1)
    return [one(y) for y in range(m)]

def analyze(name,P,costs=None,known_optimum=None):
    n,m=len(P),len(P[0])
    require(all(len(row)==m for row in P), name+": rectangular")
    require(all(sum(row,F(0))==1 for row in P), name+": row sum")
    require(all(x>=0 for row in P for x in row), name+": nonnegative")
    costs=costs or [F(1)]*m
    require(len(costs)==m and all(c>=0 for c in costs), name+": costs")

    dist=exact_scheme(P)
    require(sum(dist.values(),F(0))==1,name+": law normalization")
    row_marg=[[F(0)]*m for _ in range(n)]
    q=[F(0)]*m
    distinct_cost=F(0)
    for tup,mass in dist.items():
        require(mass>0 and all(0<=y<m for y in tup),name+": invalid atom")
        for i,y in enumerate(tup):
            row_marg[i][y]+=mass
        used=set(tup)
        distinct_cost+=mass*sum((costs[y] for y in used),F(0))
        for y in used:
            q[y]+=mass
    require(row_marg==P,name+": exact marginals disagree")
    q2=label_probabilities(P)
    require(q==q2,name+": independent label-use recurrence disagrees")

    maxima=[max(row[y] for row in P) for y in range(m)]
    support=[sum(row[y]>0 for row in P) for y in range(m)]
    r=max(support)
    profile=[sum((v/F(j) for j,v in enumerate(
        sorted((row[y] for row in P),reverse=True),1)), F(0))
        for y in range(m)]
    T=sum((costs[y]*maxima[y] for y in range(m)),F(0))
    upper=sum((costs[y]*min(F(1),profile[y]) for y in range(m)),F(0))
    uncapped=sum((costs[y]*profile[y] for y in range(m)),F(0))
    lower_support=sum((costs[y]*maxima[y] for y in range(m)),F(0))
    for y in range(m):
        require(maxima[y]<=q[y]<=min(F(1),profile[y]),name+": label profile bound")
    require(lower_support<=distinct_cost<=upper<=uncapped<=harmonic(r)*T,
            name+": cost inequality chain")
    if known_optimum is not None:
        require(distinct_cost>=known_optimum,name+": below known optimum")

    payload={"name":name,"rows":n,"labels":m,"atoms":len(dist),"column_rank":r,
        "T_c":str(T),"scheme_cost":str(distinct_cost),"profile_bound":str(upper),
        "harmonic_rank_bound":str(harmonic(r)*T),"exact_probabilities":list(map(str,q)),
        "known_optimum":None if known_optimum is None else str(known_optimum),
        "matrix":[list(map(str,row)) for row in P],"costs":list(map(str,costs))}
    return payload

def uniform_subsets(m,k):
    return [[F(int(j in S),k) for j in range(m)]
        for S in combinations(range(m),k)]

def random_rows(rng,n,m):
    rows=[]
    for i in range(n):
        nums=[rng.randrange(0,8) for _ in range(m)]
        if not any(nums):
            nums[rng.randrange(m)]=1
        den=sum(nums)
        rows.append([F(a,den) for a in nums])
    return rows

def fixtures():
    for n in range(1,6):
        yield f"deterministic-{n}",[[F(i==j) for j in range(n)] for i in range(n)],None,F(n)
        yield f"identical-{n}",[[F(1,5)]*5 for _ in range(n)],None,F(1)
    yield "triangle",[[F(1,2),F(1,2),0],[F(1,2),0,F(1,2)],[0,F(1,2),F(1,2)]],None,F(2)
    yield "asymmetric-zeros",[
        [F(2,3),F(1,3),0,0],
        [F(1,6),F(2,3),F(1,6),0],
        [0,F(1,2),F(1,4),F(1,4)]],None,None
    for m,k in [(3,1),(3,2),(4,2),(4,3),(5,4)]:
        yield f"all-subsets-{m}-{k}",uniform_subsets(m,k),None,F(m-k+1)
    # Original dense family at the three exactly certified vertices and midpoint.
    for b in [F(0),F(1,20),F(1,6),F(1,4)]:
        a=F(1,2)-b
        P=[[a,a,b,b],[a,b,a,b],[b,a,a,b],[b,b,b,1-3*b]]
        yield "dense-original-"+str(b).replace("/","_"),P,None,max(3-9*b,F(5,2)-6*b)
    rng=random.Random(20261125)
    for j in range(60):
        n=1+j%5
        m=2+(j//5)%4
        P=random_rows(rng,n,m)
        costs=[F(rng.randrange(0,10),rng.randrange(1,6)) for _ in range(m)]
        yield "rational-"+str(j),P,costs,None

def main():
    results=[analyze(*fixture) for fixture in fixtures()]
    hard_lower_rows=[]
    # Arithmetic diagnostic of the proved deterministic inequalities, not
    # generation of the astronomically large random incidence examples.
    for L in [12,16,20,50,100,500,1000]:
        p=1.0/L
        a=-math.log1p(-p)
        b=L-2*math.log(L)-math.log(math.log(L))-2
        k=math.floor(b/a)
        m=math.ceil(6*L**4)
        exponent=L**2*(math.log(7*math.e)+(4-math.e**2)*math.log(L))
        require(b>0 and k<=L**2 and m<=7*L**4,"lower parameters")
        require(exponent<-3*L**2,"failure exponent")
        ratio=(1-p)*p*(k+1)
        bound=L-2*math.log(L)-math.log(math.log(L))-4
        require(ratio>bound,"lower ratio arithmetic")
        hard_lower_rows.append({"log_n":L,"m":m,"k":k,"ratio_certificate":ratio,
            "simplified_bound":bound,"log_cover_failure_bound":exponent})
    output={"kind":"exact_rational_finite_coupling_diagnostics",
        "seed_for_fixture_selection":20261125,"fixture_count":len(results),
        "total_tuple_atoms":sum(x["atoms"] for x in results),
        "exact_inequalities_and_marginals":True,
        "universal_proof":False,"results":results,
        "lower_parameter_arithmetic_kind":"floating illustrations of analytic inequalities",
        "lower_parameter_diagnostics":hard_lower_rows}
    dest=HERE.parent/"results"/"HARMONIC_AUTHOR_CHECKS.json"
    dest.write_text(json.dumps(output,ensure_ascii=False,indent=2)+"\n")
    print(json.dumps({"fixtures":len(results),"atoms":output["total_tuple_atoms"],
        "failures":0,"verification_sha256":hashlib.sha256(dest.read_bytes()).hexdigest(),
        "path":str(dest)}))
if __name__=="__main__":
    main()

