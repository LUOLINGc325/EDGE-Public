#!/usr/bin/env python3
"""Record minimax LPs with Bernoulli arrivals and active quantile labels.

The null state is represented explicitly. Numerical discovery uses SciPy;
verification uses only Fraction and the residual-corrected weak-duality
routine already supplied by minimax_quantile_lp.py. The global lower bound
depends on the written record-preserving Poisson coupling theorem.
"""
from __future__ import annotations
import argparse
from fractions import Fraction as Q
import hashlib
import json
from pathlib import Path
from minimax_quantile_lp import RationalLP, qjson, qload, rounded, certify_dual
from certify_horizon_schedule import exp_minus_unit_interval

ROOT = Path(__file__).resolve().parent.parent

def build_sparse_lp(n, m, p, mode):
    if n < 1 or m < 1 or not Q(0) < p <= Q(1) or mode not in ("strict", "weak"):
        raise ValueError("invalid horizon, labels, arrival probability or mode")
    def w(k, r):
        if k == n:
            assert r == 0
            return n*m+n-1
        assert 1 <= k < n and 0 <= r <= m
        return m+(k-1)*(m+1)+r
    def s(k, r):
        assert 1 <= k <= n and 1 <= r <= m
        return n*m+n+(k-1)*m+r-1
    def row(terms):
        out = {}
        for j, a in terms:
            out[j] = out.get(j, Q(0))+Q(a)
        return {j:a for j,a in out.items() if a}
    weights = [(1-p+p*Q(j,m))**n-(1-p+p*Q(j-1,m))**n
               for j in range(1,m+1)]
    eq = [{j:weights[j] for j in range(m)}]
    ub = [{j:Q(1),j+1:Q(-1)} for j in range(m-1)]
    for k in range(1,n+1):
        for r in range(1,m+1):
            terms=[(s(k,r),-1)]
            if r < m:
                terms.append((s(k,r+1),1))
            ub.append(row(terms+[(r-1,p/m)]))
            future=[] if k == 1 else [(w(k-1,r),p/m)]
            ub.append(row(terms+future))
        # The initial/null state is needed at every remaining horizon.
        terms=[(w(k,0),1),(s(k,1),-1)]
        if k > 1:
            terms.append((w(k-1,0),-(1-p)))
        eq.append(row(terms))
        if k == n:
            continue
        for r in range(1,m+1):
            terms=[(w(k,r),1)]
            factor=1-p+p*Q(r if mode == "strict" else r-1,m)
            if k > 1:
                terms.append((w(k-1,r),-factor))
            sr=r+1 if mode == "strict" else r
            if sr <= m:
                terms.append((s(k,sr),-1))
            eq.append(row(terms))
    return RationalLP(n,m,mode,n*(2*m+1),w(n,0),1/weights[-1],weights,ub,eq)

def bellman_sparse(values,n,p,mode):
    m=len(values)
    previous=[Q(0)]*(m+1)
    for _ in range(n):
        suffix=[Q(0)]*(m+2)
        for r in range(m,0,-1):
            suffix[r]=suffix[r+1]+p/m*max(values[r-1],previous[r])
        current=[(1-p)*previous[0]+suffix[1]]
        for r in range(1,m+1):
            if mode == "strict":
                current.append((1-p+p*Q(r,m))*previous[r]+suffix[r+1])
            else:
                current.append((1-p+p*Q(r-1,m))*previous[r]+suffix[r])
        previous=current
    return previous[0]

def verify_mode(n,m,p,mode,certificate):
    lp=build_sparse_lp(n,m,p,mode)
    denominator=int(certificate["dual_denominator"])
    ys=[Q(int(x),denominator) for x in certificate["inequality_multiplier_numerators"]]
    zs=[Q(int(x),denominator) for x in certificate["equality_multiplier_numerators"]]
    lower,diagnostics=certify_dual(lp,ys,zs)
    vd=int(certificate["value_denominator"])
    values=[Q(int(x),vd) for x in certificate["value_numerators"]]
    if len(values)!=m or values!=sorted(values) or any(v<0 for v in values):
        raise ValueError("invalid sorted nonnegative reward vector")
    prophet=sum((w*v for w,v in zip(lp.prophet_weights,values)),Q(0))
    if prophet<=0:
        raise ValueError("zero prophet")
    reward=bellman_sparse(values,n,p,mode)
    upper=reward/prophet
    assert 0<=lower<=upper<=1
    return {"lower_bound":qjson(lower),"upper_bound":qjson(upper),
            "candidate_reward":qjson(reward),"candidate_prophet":qjson(prophet),
            "dual_diagnostics":diagnostics}

def exp_minus_rate(rate):
    integer=rate.numerator//rate.denominator
    fraction=rate-integer
    lo1,hi1=exp_minus_unit_interval(Q(1))
    lof,hif=exp_minus_unit_interval(fraction)
    return lo1**integer*lof,hi1**integer*hif

def global_bounds(n,m,p,strict,weak):
    rate=n*p
    rho=Q(m,n)/p*(1-(1-p/m)**n)
    tie=Q(n-1,m)*p
    alo,ahi=qload(strict["lower_bound"]),qload(strict["upper_bound"])
    blo,bhi=qload(weak["lower_bound"]),qload(weak["upper_bound"])
    active_lower=rho*max(Q(0),alo,blo-tie)
    active_upper=min(Q(1),bhi,ahi+tie)
    _,ehi=exp_minus_rate(rate)
    coupling_penalty=rate**2*(rate+2)/n
    raw_global_lower=(1-ehi)*active_lower-coupling_penalty
    _,e1hi=exp_minus_unit_interval(Q(1))
    classical_lower=1-e1hi
    lower=max(Q(0),classical_lower,raw_global_lower)
    upper=active_upper
    assert 0<=lower<=upper<=1
    return {"rate":qjson(rate),"rho_sparse":qjson(rho),
            "weak_strict_gap_bound":qjson(tie),
            "active_minimax_lower":qjson(active_lower),
            "active_minimax_upper":qjson(active_upper),
            "coupling_penalty_after_multiplication":qjson(coupling_penalty),
            "exp_minus_rate_upper":qjson(ehi),
            "raw_global_lower":qjson(raw_global_lower),
            "classical_global_lower":qjson(classical_lower),
            "global_lower":qjson(lower),"global_upper":qjson(upper),
            "global_width":qjson(upper-lower),
            "exact_optima_discretization_width_bound":qjson(Q(3*(n-1),2*m)*p)}

def solve_mode(n,m,p,mode,denominator=10**12):
    import numpy as np
    from scipy.optimize import linprog
    from scipy.sparse import csr_matrix
    lp=build_sparse_lp(n,m,p,mode)
    def matrix(rows):
        rr=[];cc=[];vv=[]
        for i,row in enumerate(rows):
            for j,value in row.items():
                rr.append(i);cc.append(j);vv.append(float(value))
        return csr_matrix((vv,(rr,cc)),shape=(len(rows),lp.variable_count))
    objective=np.zeros(lp.variable_count);objective[lp.objective_index]=1
    rhs=np.zeros(len(lp.eq_rows));rhs[0]=1
    sol=linprog(objective,A_ub=matrix(lp.ub_rows),b_ub=np.zeros(len(lp.ub_rows)),
                A_eq=matrix(lp.eq_rows),b_eq=rhs,bounds=(0,float(lp.upper_bound)),
                method="highs",options={"dual_feasibility_tolerance":1e-9,
                                        "primal_feasibility_tolerance":1e-9})
    if not sol.success:
        raise RuntimeError(sol.message)
    ys=[min(Q(0),rounded(y,denominator)) for y in sol.ineqlin.marginals]
    zs=[rounded(z,denominator) for z in sol.eqlin.marginals]
    values=[]
    for value in sol.x[:m]:
        values.append(max(Q(0),values[-1] if values else Q(0),rounded(value,denominator)))
    cert={"dual_denominator":str(denominator),
          "inequality_multiplier_numerators":[str(y*denominator) for y in ys],
          "equality_multiplier_numerators":[str(z*denominator) for z in zs],
          "value_denominator":str(denominator),
          "value_numerators":[str(v*denominator) for v in values]}
    return {"floating_solver_objective":float(sol.fun),"solver_iterations":int(sol.nit),
            "variable_count":lp.variable_count,"inequality_count":len(lp.ub_rows),
            "equality_count":len(lp.eq_rows),"certificate":cert,
            **verify_mode(n,m,p,mode,cert)}

def verify_result(data):
    if data.get("schema")!="record-sparse-global-lp-v1":
        raise ValueError("unsupported certificate")
    n,m=int(data["n"]),int(data["m"]);p=qload(data["arrival_probability"])
    checked={}
    for mode in ["strict","weak"]:
        checked[mode]=verify_mode(n,m,p,mode,data[mode]["certificate"])
        for key in ["lower_bound","upper_bound","candidate_reward","candidate_prophet"]:
            if qload(checked[mode][key])!=qload(data[mode][key]):
                raise ValueError("stored mode result differs from exact replay")
    bounds=global_bounds(n,m,p,checked["strict"],checked["weak"])
    for key in bounds:
        if qload(bounds[key])!=qload(data["bounds"][key]):
            raise ValueError("stored global bound differs from exact replay")
    return {"verified":True,"n":n,"m":m,"arrival_probability":str(p),
            "global_lower":bounds["global_lower"]["decimal"],
            "global_upper":bounds["global_upper"]["decimal"],
            "new_method_raw_lower":bounds["raw_global_lower"]["decimal"],
            "classical_lower_used":qload(bounds["global_lower"])==qload(bounds["classical_global_lower"])}

def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--n",type=int)
    parser.add_argument("--m",type=int)
    parser.add_argument("--rate",type=Q)
    parser.add_argument("--output",type=Path)
    parser.add_argument("--verify",type=Path)
    args=parser.parse_args()
    if args.verify:
        print(json.dumps(verify_result(json.loads(args.verify.read_text())),indent=2))
        return
    if args.n is None or args.m is None or args.rate is None or args.output is None:
        parser.error("supply n, m, rate and output, or verify")
    p=args.rate/args.n
    data={"schema":"record-sparse-global-lp-v1","n":args.n,"m":args.m,
          "arrival_probability":qjson(p),
          "scope":"All positive horizons and all nonnegative iid laws; depends on the written global transfer theorem",
          "whole_theorem_machine_formalized":False,
          "source_sha256":hashlib.sha256(Path(__file__).read_bytes()).hexdigest()}
    for mode in ["strict","weak"]:
        data[mode]=solve_mode(args.n,args.m,p,mode)
    data["bounds"]=global_bounds(args.n,args.m,p,data["strict"],data["weak"])
    verification=verify_result(data)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(data,indent=2)+"\n")
    print(json.dumps(verification,indent=2))

if __name__=="__main__":
    main()
