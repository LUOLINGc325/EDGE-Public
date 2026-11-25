"""Exact rational Bellman computation; finite evidence, not a universal proof."""
from fractions import Fraction as F
from functools import lru_cache
from math import comb
import argparse
import json

@lru_cache(None)
def agreement(m, k):
    if not 2 <= k <= m:
        raise ValueError("require 2 <= k <= m")
    return F(comb(m//2,k)+comb((m+1)//2,k),comb(m,k))

def minimax(lines):
    """Upper convex envelope, exact rational breakpoints, original labels."""
    by_slope={}
    for slope,intercept,label in lines:
        if slope not in by_slope or intercept>by_slope[slope][0]:
            by_slope[slope]=(intercept,label)
    hull=[]; starts=[]
    for slope in sorted(by_slope):
        intercept,label=by_slope[slope]; start=None
        while hull:
            old_slope,old_intercept,_=hull[-1]
            start=(old_intercept-intercept)/(slope-old_slope)
            if len(hull)==1 or start>starts[-1]: break
            hull.pop(); starts.pop()
        if not hull:start=None
        hull.append((slope,intercept,label));starts.append(start)
    candidates={F(0),F(1)}
    candidates.update(x for x in starts if x is not None and 0<=x<=1)
    value,t=min((max(b+s*x for s,b,_ in hull),x) for x in candidates)
    return value,t,[k for s,b,k in lines if b+s*t==value]

def table(max_m,max_r):
    a={(0,m):agreement(m,2) for m in range(2,max_m+1)}; rows=[]
    for r in range(1,max_r+1):
        for m in range(2,max_m+1):
            lines=[(agreement(m,k)-a[r-1,k],a[r-1,k],k) for k in range(2,m+1)]
            value,t,active=minimax(lines);a[r,m]=value
            reduced_value,reduced_t,_=minimax([x for x in lines if x[2] in {2,3,m}])
            rows.append(dict(r=r,m=m,deficit=str(value),resilience=str(1-value),
                first_fraction=str(t),active=active,three_constraint_matches=value==reduced_value,
                reduced_fraction=str(reduced_t)))
    return a,rows

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("--max-m",type=int,default=64);p.add_argument("--max-r",type=int,default=12)
    p.add_argument("--output",default="results/exact_bellman_64_12.json")
    args=p.parse_args();a,rows=table(args.max_m,args.max_r)
    fail=[x for x in rows if not x["three_constraint_matches"]]
    parity=[(r,m) for r in range(args.max_r+1) for m in range(4,args.max_m+1,2) if a[r,m]!=a[r,m-1]]
    result=dict(arithmetic="exact fractions",scope=dict(max_m=args.max_m,max_r=args.max_r),
        three_constraint_failures=fail,parity_failures=parity,rows=rows)
    with open(args.output,"w") as f:json.dump(result,f,indent=2);f.write("\n")
    print(json.dumps(dict(rows=len(rows),three_constraint_failures=fail,parity_failures=parity),indent=2))
    if fail or parity:raise SystemExit(1)

if __name__=="__main__":main()
