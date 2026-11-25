"""Targeted finite exact checks; not a universal mathematical proof."""
from fractions import Fraction as F
import argparse
import hashlib
import json
from pathlib import Path
import platform
from erasure_dp import agreement,table
from closed_form import deficit,deficit_at,first_fraction,infinite_deficit,parameter

def crossings(lines):
    points={F(0),F(1)}
    for i,(s,b,_) in enumerate(lines):
        for u,v,_ in lines[:i]:
            if s!=u:
                t=(v-b)/(s-u)
                if 0<=t<=1:points.add(t)
    return points

def run(max_m,max_r):
    values,rows=table(max_m,max_r);failures=[]
    counts=dict(formula_states=0,schedule_states=0,envelope_breakpoints=0,
                independent_pairwise_states=0,balanced_binomial_states=0)
    for r in range(max_r+1):
        for m in range(2,max_m+1):
            counts["formula_states"]+=1
            if values[r,m]!=deficit(r,m):failures.append(dict(check="product",r=r,m=m))
            if r==0:continue
            lines=[(agreement(m,k)-values[r-1,k],values[r-1,k],k) for k in range(2,m+1)]
            t=first_fraction(r,m);counts["schedule_states"]+=1
            if not 0<=t<=1 or max(s*t+b for s,b,_ in lines)!=values[r,m]:
                failures.append(dict(check="schedule",r=r,m=m))
            reduced=[x for x in lines if x[2] in {2,3,m}]
            for t in crossings(reduced):
                counts["envelope_breakpoints"]+=1
                if max(s*t+b for s,b,_ in lines)!=max(s*t+b for s,b,_ in reduced):
                    failures.append(dict(check="full_envelope",r=r,m=m,t=str(t)))
            if m<=14 and r<=8:
                counts["independent_pairwise_states"]+=1
                value=min(max(s*t+b for s,b,_ in lines) for t in crossings(lines))
                if value!=deficit(r,m):failures.append(dict(check="pairwise_solver",r=r,m=m))
    for m in range(5,301):
        for k in range(5,m+1,2):
            counts["balanced_binomial_states"]+=1
            if 2*agreement(m,k)>parameter(m)-parameter(k):
                failures.append(dict(check="balanced_binomial",m=m,k=k))
    samples=[]
    for r in range(max_r+1):
        direct=deficit_at(r,F(1,4))
        if direct!=infinite_deficit(r):failures.append(dict(check="infinite_formula",r=r))
        samples.append(dict(r=r,deficit=str(direct),resilience=str(1-direct)))
    hashes={p.name:hashlib.sha256(p.read_bytes()).hexdigest()
            for p in sorted(Path(__file__).parent.glob("*.py"))}
    return dict(status="passed" if not failures else "failed",
        scope="targeted finite exact-arithmetic consistency checks; not a universal proof",
        arithmetic="fractions.Fraction; no floating-point tolerance",python_version=platform.python_version(),
        grid=dict(m_min=2,m_max=max_m,r_min=0,r_max=max_r),counts=counts,
        failures=failures,infinite_message_samples=samples,source_sha256=hashes)

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument("--max-m",type=int,default=64);p.add_argument("--max-r",type=int,default=12)
    p.add_argument("--output",default="results/exact_formula_verification.json")
    args=p.parse_args();result=run(args.max_m,args.max_r)
    Path(args.output).write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({k:v for k,v in result.items() if k not in {"source_sha256","infinite_message_samples"}},indent=2))
    if result["status"]!="passed":raise SystemExit(1)

if __name__=="__main__":main()
