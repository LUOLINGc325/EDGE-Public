#!/usr/bin/env python3
"""Independent exact checks for the binomial-thinning derivation.
Not a universal proof or a Lean verification.
"""
import json
from fractions import Fraction as F
from math import comb
from pathlib import Path

def choose(n,k):
    return comb(n,k) if 0 <= k <= n else 0

def kernel(s,r,c):
    return F(choose(s-1,r-1))*c**(r-1)*(1-c)**(s-r) if 1 <= r <= s else F(0)

def bin_tail(m,r,c):
    return sum((F(choose(m,j))*c**j*(1-c)**(m-j) for j in range(r,m+1)),F(0))

def a_tail(n,t,s,k):
    return sum((F(choose(k,j)*choose(n-k,t-j),choose(n,t))
                for j in range(s,t+1)),F(0))

def a_rank(n,t,s,k):
    return sum((F(choose(j-1,s-1)*choose(n-j,t-s),choose(n,t))
                for j in range(s,k+1)),F(0))

def require(cond,label):
    if not cond:
        raise RuntimeError(label)

counts={"rank_kernel":0,"row":0,"column":0,"intertwining":0,
        "semigroup":0,"transferred_feasibility":0,"success_transport":0}
cs=[F(1,5),F(1,3),F(1,2),F(3,4),F(1)]
for n in range(1,11):
    for t in range(1,n+1):
        for s in range(1,t+1):
            for k in range(n+1):
                require(a_tail(n,t,s,k)==a_rank(n,t,s,k),
                        f"rank identity {n,t,s,k}")
                counts["rank_kernel"]+=1
        for c in cs:
            for s in range(1,t+1):
                require(sum((kernel(s,r,c) for r in range(1,s+1)),F(0))==1,
                        "row sum")
                counts["row"]+=1
            for r in range(1,t+1):
                col=c*sum((kernel(s,r,c) for s in range(r,t+1)),F(0))
                require(col==bin_tail(t,r,c) and 0<=col<=1,"column identity")
                counts["column"]+=1
                for k in range(n+1):
                    lhs=c*sum((a_tail(n,t,s,k)*kernel(s,r,c)
                               for s in range(r,t+1)),F(0))
                    rhs=sum((F(choose(k,j))*c**j*(1-c)**(k-j)*
                             a_tail(n,t,r,j) for j in range(k+1)),F(0))
                    require(lhs==rhs,f"intertwining {n,t,r,k,c}")
                    counts["intertwining"]+=1
for s in range(1,11):
    for r in range(1,s+1):
        for c in cs:
            for d in cs:
                require(sum((kernel(s,j,c)*kernel(j,r,d)
                             for j in range(r,s+1)),F(0))==kernel(s,r,c*d),
                        "semigroup")
                counts["semigroup"]+=1
for n in range(1,11):
    for p_plus in [F(1,4),F(2,3),F(1)]:
        # Fixed rational time/rank probabilities with no relation to K.
        survival=F(1)
        x={}
        for t in range(1,n+1):
            for s in range(1,t+1):
                pi=F((3*t+2*s)%7,6)
                x[t,s]=survival*pi/t
            survival-=p_plus*sum((x[t,s] for s in range(1,t+1)),F(0))
        for c in cs:
            p_minus=c*p_plus
            y={(t,s):sum((kernel(s,r,c)*x[t,r] for r in range(1,s+1)),F(0))
               for t in range(1,n+1) for s in range(1,t+1)}
            sx=sy=F(1)
            for t in range(1,n+1):
                require(sy>=sx,"survival ordering")
                for s in range(1,t+1):
                    require(0<=t*y[t,s]<=sy,"transferred occupancy feasibility")
                    counts["transferred_feasibility"]+=1
                sx-=p_plus*sum((x[t,s] for s in range(1,t+1)),F(0))
                sy-=p_minus*sum((y[t,s] for s in range(1,t+1)),F(0))
            old=[p_plus*sum((a_tail(n,t,s,k)*x[t,s] for t in range(1,n+1)
                             for s in range(1,t+1)),F(0)) for k in range(n+1)]
            for k in range(n+1):
                new=p_minus*sum((a_tail(n,t,s,k)*y[t,s] for t in range(1,n+1)
                                 for s in range(1,t+1)),F(0))
                mixture=sum((F(choose(k,j))*c**j*(1-c)**(k-j)*old[j]
                             for j in range(k+1)),F(0))
                require(new==mixture,"whole-success-vector transport")
                counts["success_transport"]+=1
receipt={"status":"PASS","arithmetic":"fractions.Fraction","n_max":10,
         "probability_grid":[str(c) for c in cs],"counts":counts,
         "scope":"Finite exact checks of identities and feasible-policy transport; universal proof is separate."}
out=Path(__file__).resolve().parents[1]/"results/finite_thinning_exact_check.json"
out.write_text(json.dumps(receipt,indent=2)+"\n")
print(json.dumps(receipt,indent=2))

