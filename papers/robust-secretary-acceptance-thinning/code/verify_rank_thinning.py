"""Independent exact checks for the acceptance-thinning theorem.

Uses fractions, finite combinatorial sums and direct permutation evaluation.
Does not call a floating-point LP solver or a proof assistant.
"""
from fractions import Fraction as F
from itertools import permutations
from math import comb, factorial
from pathlib import Path
import json

def C(n,k):
    return comb(n,k) if 0<=k<=n else 0

def kernel(s,r,q):
    return F(comb(s-1,r-1))*q**(r-1)*(1-q)**(s-r) if 1<=r<=s else F(0)

def A(n,t,s,k):
    return sum((F(C(k,j)*C(n-k,t-j),comb(n,t)) for j in range(s,t+1)),F(0))

def A_order(n,t,s,k):
    return sum((F(C(r-1,s-1)*C(n-r,t-s),comb(n,t)) for r in range(1,k+1)),F(0))

def evaluate(n,p,policy):
    """Enumerate permutations, integrating proposal/rejection coins exactly."""
    occ={(t,s):F(0) for t in range(1,n+1) for s in range(1,t+1)}
    absolute=[F(0) for _ in range(n+1)]
    nf=factorial(n)
    for perm in permutations(range(1,n+1)):
        survival=F(1)
        for t,r in enumerate(perm,1):
            s=sum(v<=r for v in perm[:t])
            offer=policy[t,s]
            mass=survival*offer
            occ[t,s]+=mass/nf
            absolute[r]+=p*mass/nf
            survival*=1-p*offer
    tails=[sum(absolute[:k+1],F(0)) for k in range(n+1)]
    return occ,tails

def transform_policy(n,p0,p,occ):
    q=p/p0
    new={}
    pol={}
    survival=F(1)
    for t in range(1,n+1):
        for s in range(1,t+1):
            new[t,s]=sum((kernel(s,r,q)*occ[t,r] for r in range(1,s+1)),F(0))
            pol[t,s]=t*new[t,s]/survival if survival else F(0)
            assert 0<=pol[t,s]<=1
        survival-=p*sum(new[t,s] for s in range(1,t+1))
        assert survival>=0
    return new,pol

def main():
    counts={"cdf_representation":0,"hypergeometric_intertwining":0,"row_stochasticity":0,"truncated_column_bound":0,"semigroup":0,"policy_instances":0,"policy_tail_equalities":0,"terminal_fill_tail_equalities":0,"strict_improvements":0}
    qs=[F(1,3),F(1,2),F(2,3),F(1)]
    for n in range(1,11):
        for t in range(1,n+1):
            for s in range(1,t+1):
                for k in range(n+1):
                    assert A(n,t,s,k)==A_order(n,t,s,k)
                    counts['cdf_representation']+=1
            for q in qs:
                for r in range(1,t+1):
                    assert sum(kernel(t,r2,q) for r2 in range(1,t+1))==1
                    counts['row_stochasticity']+=1
                    assert q*sum(kernel(s,r,q) for s in range(r,t+1))<=1
                    counts['truncated_column_bound']+=1
                    for k in range(n+1):
                        lhs=q*sum((A(n,t,s,k)*kernel(s,r,q) for s in range(r,t+1)),F(0))
                        rhs=sum((F(comb(k,j))*q**j*(1-q)**(k-j)*A(n,t,r,j) for j in range(k+1)),F(0))
                        assert lhs==rhs,(n,t,k,r,q,lhs,rhs)
                        counts['hypergeometric_intertwining']+=1
    for s in range(1,14):
        for r in range(1,s+1):
            for q1 in qs:
                for q2 in qs:
                    lhs=sum((kernel(s,j,q1)*kernel(j,r,q2) for j in range(r,s+1)),F(0))
                    assert lhs==kernel(s,r,q1*q2)
                    counts['semigroup']+=1
    for n in range(1,7):
        policies=[
            {(t,s):F(1) for t in range(1,n+1) for s in range(1,t+1)},
            {(t,s):F(t-s+1,t+1) for t in range(1,n+1) for s in range(1,t+1)},
            {(t,s):F(t>n//3 and (s==1 or t==n)) for t in range(1,n+1) for s in range(1,t+1)},
        ]
        for policy in policies:
            for p0 in [F(1,3),F(3,5),F(1)]:
                occ,tails=evaluate(n,p0,policy)
                for q in qs:
                    p=q*p0
                    new,pol=transform_policy(n,p0,p,occ)
                    direct_occ,direct_tails=evaluate(n,p,pol)
                    assert direct_occ==new
                    for k in range(n+1):
                        expected=sum((F(comb(k,j))*q**j*(1-q)**(k-j)*tails[j] for j in range(k+1)),F(0))
                        assert direct_tails[k]==expected
                        counts['policy_tail_equalities']+=1
                    old_ratio=min(tails[k]/(1-(1-p0)**k) for k in range(1,n+1))
                    new_ratio=min(direct_tails[k]/(1-(1-p)**k) for k in range(1,n+1))
                    assert new_ratio>=old_ratio
                    counts['policy_instances']+=1
                    old_survival=1-p0*sum(occ[t,s] for t in range(1,n) for s in range(1,t+1))
                    new_survival=1-p*sum(new[t,s] for t in range(1,n) for s in range(1,t+1))
                    delta=new_survival-old_survival
                    assert delta>=0
                    pol_fill=pol.copy()
                    if delta:
                        pol_fill[n,1]+=delta/new_survival
                    assert 0<=pol_fill[n,1]<=1
                    _,tails_fill=evaluate(n,p,pol_fill)
                    for k in range(1,n+1):
                        assert tails_fill[k]-direct_tails[k]==p*delta/n
                        counts['terminal_fill_tail_equalities']+=1
                    filled_ratio=min(tails_fill[k]/(1-(1-p)**k) for k in range(1,n+1))
                    if q<1 and sum(occ[t,s] for t in range(1,n) for s in range(1,t+1))>0:
                        assert delta>0 and filled_ratio>old_ratio
                        counts['strict_improvements']+=1
    report={"status":"PASS","arithmetic":"fractions.Fraction exact rational","counts":counts,"scope":"finite exact regression checks; analytical proof remains the universal justification","source":"verify_rank_thinning.py"}
    path=Path(__file__).resolve().parents[1]/'results/rank_thinning_verification.json'
    path.write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(report,indent=2))

if __name__=='__main__':main()
