"""Independent global disjunctive-LP audit of finite CVaR ski rental.

This file does NOT import the proposed cumulative-capacity implementation.
For each season, CVaR is the minimum over its finitely many loss levels of
eta + E[(cost-eta)_+]/q.  Its sublevel constraint is therefore a UNION of
linear halfspaces, not an intersection or a single common LP.

We enumerate one loss-level choice for each season, solve every resulting LP,
then independently check rational primal AND dual certificates.  Floating-point
HiGHS is only a certificate finder.  A returned case is accepted only when exact
Fraction arithmetic verifies matching global upper and lower bounds.

Branches choosing the maximum loss at a season i<B have lower bound
(B+i-1)/i > (2B-1)/B and cannot beat the deterministic day-B policy; those
branches are discarded with this explicit algebraic certificate.

This verifies the stated finite B,q cases, not an arbitrary-B theorem.
"""

from fractions import Fraction as F
from itertools import product
from math import factorial
from pathlib import Path
import argparse
import json
import time

import numpy as np
from scipy.optimize import linprog

if not __debug__:
    raise RuntimeError('Exact certificate checks require Python without -O.')


def reconstruct(value):
    return F(float(value)).limit_denominator(10**9)


def exact_linear_system(equations,n,approximate):
    """Rational RREF; floating values only select any unconstrained coordinates."""
    rows=[[F(v) for v in lhs]+[F(rhs)] for lhs,rhs in equations]
    pivot_columns=[]
    at=0
    for col in range(n):
        pivot=next((j for j in range(at,len(rows)) if rows[j][col]),None)
        if pivot is None: continue
        rows[at],rows[pivot]=rows[pivot],rows[at]
        scale=rows[at][col]
        rows[at]=[v/scale for v in rows[at]]
        for j in range(len(rows)):
            if j!=at and rows[j][col]:
                scale=rows[j][col]
                rows[j]=[v-scale*w for v,w in zip(rows[j],rows[at])]
        pivot_columns.append(col)
        at+=1
    assert all(any(row[:-1]) or not row[-1] for row in rows),'inconsistent active system'
    x=[reconstruct(v) for v in approximate]
    free=set(range(n))-set(pivot_columns)
    for j,col in enumerate(pivot_columns):
        x[col]=rows[j][-1]-sum(rows[j][k]*x[k] for k in free)
    return x


def cv(eta, losses, p, q):
    return eta + sum(x*max(F(0),c-eta) for c,x in zip(losses,p))/q


def true_ratio(B, p, q):
    values=[]
    for i in range(1,B+1):
        losses=[F(B+j-1 if j<=i else i) for j in range(1,B+1)]
        values.append(min(cv(eta,losses,p,q) for eta in set(losses))/i)
    return max(values),values


def row(B,i,k,q):
    eta=F(i if k==0 else B+k-1)
    losses=[F(B+j-1 if j<=i else i) for j in range(1,B+1)]
    return [max(F(0),c-eta)/q for c in losses]+[F(-i)],-eta


def exact_certificates(B,A,b,result):
    """Check standard nonnegative-variable LP primal and dual exactly."""
    if result.status!=0:
        raise AssertionError(('LP solver failed',B,result.status,result.message))
    primal_equations=[([F(1)]*B+[F(0)],F(1))]
    for j,value in enumerate(result.x):
        if abs(value)<1e-9:
            unit=[F(0)]*(B+1);unit[j]=F(1)
            primal_equations.append((unit,F(0)))
    for i,slack in enumerate(result.ineqlin.residual):
        if abs(slack)<1e-8:
            primal_equations.append((A[i],b[i]))
    x=exact_linear_system(primal_equations,B+1,result.x)
    dual_equations=[]
    for j,value in enumerate(result.x):
        if value>1e-9:
            dual_equations.append(([A[i][j] for i in range(B)]+[F(j<B)],F(j==B)))
    for i,value in enumerate(result.ineqlin.marginals):
        if abs(value)<1e-9:
            unit=[F(0)]*(B+1);unit[i]=F(1)
            dual_equations.append((unit,F(0)))
    dual_vector=exact_linear_system(dual_equations,B+1,
                                  list(result.ineqlin.marginals)+[result.eqlin.marginals[0]])
    y,lam=dual_vector[:-1],dual_vector[-1]
    assert all(v>=0 for v in x),('negative primal',x)
    assert sum(x[:-1])==1,('primal normalization',x)
    assert all(sum(a*v for a,v in zip(r,x))<=rhs for r,rhs in zip(A,b)),('primal feasibility',x)
    assert all(v<=0 for v in y),('dual signs',y)
    for j in range(B+1):
        lhs=sum(A[i][j]*y[i] for i in range(B))+(lam if j<B else 0)
        rhs=F(1 if j==B else 0)
        assert lhs<=rhs,('dual feasibility',j,lhs,rhs,y,lam)
    dual=sum(rhs*v for rhs,v in zip(b,y))+lam
    assert dual==x[-1],('certificate gap',dual,x[-1])
    return x,dual


def solve(B,q):
    started=time.monotonic()
    deterministic=F(2*B-1,B)
    # k=0 and k=1 are identical for i=B.  Drop k=1 there.
    # q=1 is expectation, where the minimum loss always minimizes eta.
    choices=([[0] for _ in range(B)] if q==1 else
             [list(range(i)) for i in range(1,B)]+[[0]+list(range(2,B+1))])
    tables=[{k:row(B,i,k,q) for k in options} for i,options in enumerate(choices,1)]
    best_upper=deterministic
    best_lower=deterministic
    best_p=[F(0)]*(B-1)+[F(1)]
    best_choices=None
    checked=0
    objective=np.array([0.]*B+[1.])
    equality=np.array([[1.]*B+[0.]])
    for cutoffs in product(*choices):
        rows=[tables[i][k] for i,k in enumerate(cutoffs)]
        A=[a for a,_ in rows]
        b=[rhs for _,rhs in rows]
        res=linprog(objective,A_ub=np.array(A,dtype=float),b_ub=np.array(b,dtype=float),
                    A_eq=equality,b_eq=np.array([1.]),bounds=(0,None),method='highs')
        x,dual=exact_certificates(B,A,b,res)
        checked+=1
        best_lower=min(best_lower,dual)
        if x[-1]<best_upper:
            best_upper=x[-1]
            best_p=x[:-1]
            best_choices=list(cutoffs)
    assert best_upper==best_lower,('global certificate gap',B,q,best_lower,best_upper)
    actual,season_values=true_ratio(B,best_p,q)
    assert actual==best_upper,('CVaR reconstruction',B,q,actual,best_upper)
    return {'B':B,'q':str(q),'optimal_ratio':str(best_upper),
            'optimal_probabilities':[str(p) for p in best_p],
            'season_ratios':[str(a) for a in season_values],
            'chosen_threshold_indices':best_choices,
            'exact_primal_dual_LPs':checked,
            'full_threshold_choices_before_pruning':factorial(B+1),
            'pruning':'duplicate final threshold; branches with season i<B at its maximum loss exceed deterministic upper bound; q=1 is expectation',
            'global_exact_certificates':'PASS','elapsed_seconds':round(time.monotonic()-started,3)}


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--max-B',type=int,default=6)
    ap.add_argument('--q',nargs='*',default=['1','9/10','3/4','1/2','1/3'])
    ap.add_argument('--critical-only',action='store_true',
                    help='audit the five claimed critical q values and their +/-1/100 neighbors')
    ap.add_argument('--output',type=Path)
    args=ap.parse_args()
    cases=[]
    critical={2:F(2,3),3:F(6,11),4:F(24,49),5:F(160,353),6:F(1125,2638)}
    if args.critical_only and args.max_B>6:
        raise ValueError('The independently chosen critical test inputs cover B=2,...,6 only.')
    for B in range(2,args.max_B+1):
        inputs=([critical[B]+d for d in (-F(1,100),F(0),F(1,100))]
                if args.critical_only else args.q)
        for raw in inputs:
            q=F(raw)
            if not 0<q<=1: raise ValueError('0<q<=1')
            result=solve(B,q)
            if args.critical_only:
                result['claimed_q_critical']=str(critical[B])
                result['offset_from_claimed_threshold']=str(q-critical[B])
            cases.append(result)
            print(B,str(q),result['optimal_ratio'],result['exact_primal_dual_LPs'],flush=True)
    summary={'method':'global CVaR loss-threshold enumeration with exact rational primal-dual verification',
             'cases':cases,'status':'PASS','total_exact_LPs':sum(r['exact_primal_dual_LPs'] for r in cases),
             'scope':'only the listed finite B and q; the proposed recurrence is not imported or used'}
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(json.dumps(summary,indent=2)+'\n')


if __name__=='__main__': main()
