#!/usr/bin/env python3
"""Exact finite checks for proofs/lower.md.
No finite enumeration replaces the analytic proof or a Lean verification.
"""
from __future__ import annotations
import argparse
from collections import Counter
from fractions import Fraction as F
from functools import lru_cache
from hashlib import sha256
import json
from math import comb
from pathlib import Path

@lru_cache(None)
def aq(q):
    return F(sum(comb(q,r)*abs(2*r-q) for r in range(q+1)),2**q)

def block(m,q,L,B):return F(m*L,2)*aq(q)-(L-1)*B
def ceilq(x):return -((-x.numerator)//x.denominator)

def grid(T):
    if T<=16:return [F(j,4) for j in range(4*(T-1)+1)]
    out={F(0),F(T-1)}
    for k in {0,1,2,(T-1)//4,(T-1)//2,3*(T-1)//4,T-2,T-1}:
        for delta in (F(-1,4),F(0),F(1,4),F(1,2),F(3,4)):
            if 0<=k+delta<=T-1:out.add(k+delta)
    return sorted(out)

def bellman(blocks,L,penalty):
    T=blocks*L
    @lru_cache(None)
    def value(t,old,known):
        if t==T:return F(0)
        candidates=[]
        for action in (0,1):
            cost=penalty if t and action!=old else F(0)
            new_block=(t+1)%L==0
            if t%L==0:
                cost+=sum((F(s*(2*action-1),2)+value(t+1,action,0 if new_block else s) for s in (-1,1)),F(0))/2
            else:
                cost+=F(known*(2*action-1),2)+value(t+1,action,0 if new_block else known)
            candidates.append(cost)
        return min(candidates)
    return value(0,-1,0)

def main():
    if not __debug__:raise RuntimeError('Run without -O.')
    p=argparse.ArgumentParser();p.add_argument('--output',type=Path,default=Path(__file__).resolve().parents[1]/'results/lower_certificate.json');args=p.parse_args()
    counts=Counter()
    for q in range(1,257):
        k=q//2
        assert aq(q)==F(q*comb(2*k,k),4**k)
        assert aq(q)**2>=F(q,2)
        zero=F(comb(q-1,(q-1)//2),2**(q-1)) if q%2 else F(0)
        assert aq(q)-aq(q-1)==zero
        counts['rademacher_assertions']+=3
    for T in list(range(2,41))+[64,127,128,255,256,1000,1024]:
        points=grid(T)
        for P in points:
            m=P.numerator//P.denominator+1;v=1+P
            assert m<=v<2*m and 1<=m<=T
            base=block(m,T//m,1,F(0))
            assert 16*base**2>=m*T and 32*base**2>=v*T
            for B in points:
                b=B/m;q=max(1,ceilq(32*b*b));lower=base
                assert 32*b*b<=q<=1+32*b*b
                if m*q<=T:
                    lower=max(lower,block(m,q,T//(m*q),B));counts['feasible_blocks']+=1
                else:counts['infeasible_blocks']+=1
                H=F(T) if B==0 else min(F(T),F(T*m)/B)
                D=min(F(T),T*v/(B+1))
                assert lower>=H/72 and H>=D/2
                assert 144*lower>=D and (144*lower)**2>=T*v
                if B==0:assert block(1,1,T,B)==F(T,2)
                counts['budget_parameter_cases']+=1
            for lam in set(points)|{F(T),F(2*T),F(10*T)}:
                L=min(T//m,lam.numerator//lam.denominator+1);q=T//(m*L)
                assert L>=1 and q>=1 and L-1<=lam
                assert L>=min(F(T,m),1+lam)/2
                lower=F(m*L,2)*aq(q);square=T*v*(1+lam)
                if square<=T*T:assert (8*lower)**2>=square
                else:assert 8*lower>=T
                counts['penalty_parameter_cases']+=1
    for blocks in range(1,5):
        for L in range(1,7):
            for penalty in {F(0),F(L-1,2),F(L-1),F(L)}:
                got=bellman(blocks,L,penalty)
                assert got==-F(blocks,2)*max(F(0),L-1-penalty)
                if penalty>=L-1:assert got==0
                counts['causal_bellman_cases']+=1
    for L in range(1,129):
        for offset in (0,1,7,101):
            mean=F(2*offset+L-1,2)
            assert sum((F(offset+i)-mean)**2 for i in range(L))==F(L*(L*L-1),12)
            counts['quadratic_run_identities']+=1
    for n1 in range(12):
        for n2 in range(12):
            for w in (F(0),F(1,7),F(1,2),F(6,7),F(1)):
                assert w/(n1+1)**2+(1-w)/(n2+1)**2>=1/(w*n1+(1-w)*n2+1)**2
                counts['jensen_checks']+=1
    script=Path(__file__).resolve();proof=script.parents[1]/'proofs/lower.md'
    result={'schema':'path-drift-lower-exact-v2','all_passed':True,'arithmetic':'exact integers and fractions.Fraction','counts':dict(counts),'script_sha256':sha256(script.read_bytes()).hexdigest(),'proof_sha256':sha256(proof.read_bytes()).hexdigest(),'limitations':'Finite checks supplement the analytic proof; no Lean or infinite-family enumeration claim.'}
    args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(json.dumps(result,indent=2,sort_keys=True)+'\n')
    print(json.dumps(result,indent=2,sort_keys=True))

if __name__=='__main__':main()
