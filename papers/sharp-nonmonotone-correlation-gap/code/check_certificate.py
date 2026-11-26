#!/usr/bin/env python3
"""Recheck LP and extremal-family certificates with the Python standard library.

No scipy/numpy/sympy required. Runs identically with python -O.
All comparisons are rational; exp is bracketed by its alternating series.
"""
from fractions import Fraction as Q
from itertools import combinations
from pathlib import Path
import argparse
import hashlib
import json
import math

ROOT=Path(__file__).resolve().parent.parent

def need(test,message):
    if not test:raise ValueError(message)

def rows(n):
    out=[]
    for i,j in combinations(range(n),2):
        for s in range(1<<n):
            if not s&((1<<i)|(1<<j)):
                out.append({s:1,s|(1<<i)|(1<<j):1,s|(1<<i):-1,s|(1<<j):-1})
    return out

def inverse(B):
    n=len(B);M=[[Q(v) for v in row]+[Q(i==j) for j in range(n)] for i,row in enumerate(B)]
    for j in range(n):
        pivot=next((i for i in range(j,n) if M[i][j]),None)
        if pivot is None:return None
        M[j],M[pivot]=M[pivot],M[j]
        d=M[j][j];M[j]=[v/d for v in M[j]]
        for i in range(n):
            if i!=j and M[i][j]:
                t=M[i][j];M[i]=[a-t*b for a,b in zip(M[i],M[j])]
    return [r[n:] for r in M]

def exact_bases(n):
    out=[]
    for cols in combinations(range(1<<n),n+1):
        B=[[1]*(n+1)]+[[int(bool(s&(1<<i))) for s in cols] for i in range(n)]
        inv=inverse(B)
        if inv is not None:out.append((cols,inv))
    return out

def exact_vertices(n,x,bs):
    b=[Q(1)]+x;out=set()
    for cols,inv in bs:
        z=[sum(v*w for v,w in zip(row,b)) for row in inv]
        if min(z)>=0:out.add(tuple((s,v) for s,v in zip(cols,z) if v))
    return out

def weights(n,x):
    return [math.prod(x[i] if s&(1<<i) else 1-x[i] for i in range(n)) for s in range(1<<n)]

def exp_negative_bounds(r,k=25):
    need(0<=r<=1,'exponential argument out of range')
    need(k%2==1,'odd truncation needed for lower bound')
    term=Q(1);total=term
    for j in range(1,k+1):
        term*= -r/j;total+=term
    lo=total;hi=total+term*(-r)/(k+1)
    return lo,hi

def check_lp_cases(data):
    total=0;bs={};exhaustive=0;sampled=0
    for case in data['cases']:
        n=case['n'];x=list(map(Q,case['x']));q=weights(n,x);AR=rows(n)
        need(all(0<=v<=1 for v in x),'bad marginal')
        vertices_seen=set();minimum=None
        for cc in case['certificates']:
            a=[Q(0)]*(1<<n);pair=tuple((s,Q(v)) for s,v in cc['coupling'])
            need(len(set(s for s,v in pair))==len(pair),'duplicate coupling index')
            for s,v in pair:
                need(0<=s<(1<<n) and v>0,'bad coupling entry');a[s]=v
            need(sum(a)==1,'coupling total is not 1')
            for i in range(n):need(sum(a[s] for s in range(1<<n) if s&(1<<i))==x[i],'incorrect marginal')
            f=list(map(Q,cc['f']));need(len(f)==1<<n,'bad f dimension')
            need(min(f)>=0,'negative set value')
            for row in AR:need(sum(v*f[j] for j,v in row.items())<=0,'not submodular')
            need(sum(av*fv for av,fv in zip(a,f))==1,'normalization failure')
            obj=sum(qv*fv for qv,fv in zip(q,f));nu=Q(cc['dual_equality'])
            need(obj==Q(cc['objective']),'wrong primal objective')
            need(obj>=nu,'dual bound exceeds primal objective')
            if 'primal_dual_gap' in cc:need(obj-nu==Q(cc['primal_dual_gap']),'wrong duality gap')
            else:need(obj==nu,'primal/dual objectives differ in optimality certificate')
            y=[Q(0)]*len(AR);seen_dual=set()
            for j,v in cc['dual_inequality']:
                need(j not in seen_dual and 0<=j<len(AR),'bad dual index');seen_dual.add(j)
                y[j]=Q(v);need(y[j]<=0,'bad dual sign')
            dual=[a[j]*nu for j in range(1<<n)]
            for row,yv in zip(AR,y):
                if yv:
                    for j,v in row.items():dual[j]+=yv*v
            need(all(v<=qj for v,qj in zip(dual,q)),'dual infeasibility')
            elo,ehi=exp_negative_bounds(1-max(x))
            need(nu>=1-elo,'certificate does not reach claimed bound')
            vertices_seen.add(pair);minimum=nu if minimum is None else min(nu,minimum);total+=1
        if case['coverage']=='all coupling vertices':
            need(n<=4,'unexpected exhaustive dimension')
            if n not in bs:bs[n]=exact_bases(n)
            expected=exact_vertices(n,x,bs[n])
            need(vertices_seen==expected,'coupling vertices missing or extra')
            need(len(expected)==case['coupling_count'],'wrong vertex count')
            exhaustive+=1
        else:
            need(case['coverage']=='sampled coupling vertices','unknown coverage')
            need(len(vertices_seen)<=case['coupling_count'],'too many sampled certificates')
            sampled+=1
        print(f"PASS {case['name']}: n={n}, verified={len(vertices_seen)}, coverage={case['coverage']}, minimum={minimum}")
    print(f'LP TOTAL: {total} exact primal/dual certificates; {exhaustive} exhaustive fixed-marginal cases; {sampled} sampled cases.')
    return total

def extremal_family():
    # Ground set has one blocker b (bit 0) and m interchangeable positive
    # elements. f(S)=1 precisely when b is absent and an ordinary element is
    # present. The correlated law is b alone with probability p and each
    # ordinary singleton with probability (1-p)/m.
    checks=0
    for p in (Q(1,10),Q(1,2),Q(4,5),Q(19,20)):
        first_m=max(1,math.ceil((1-p)/p))
        for m in range(first_m,10):
            n=m+1;f=[Q(int(not(s&1) and bool(s>>1))) for s in range(1<<n)]
            for row in rows(n):need(sum(v*f[j] for j,v in row.items())<=0,'extremal family not submodular')
            x=[p]+[(1-p)/m]*m;q=weights(n,x)
            need(max(x)==p,'extremal family violates the marginal cap')
            actual=sum(v*w for v,w in zip(q,f))
            theory=(1-p)*(1-(1-(1-p)/m)**m)
            need(actual==theory,'independent expectation mismatch')
            a=[Q(0)]*(1<<n);a[1]=p
            for i in range(1,n):a[1<<i]=(1-p)/m
            need(sum(a)==1,'family coupling not normalized')
            need(sum(a[s]*f[s] for s in range(1<<n))==1-p,'family correlated expectation mismatch')
            for s in range(1<<n):need(f[s]<=1-int(bool(s&1)),'family upper envelope failed')
            elo,ehi=exp_negative_bounds(1-p)
            need(theory/(1-p)>=1-elo,'finite family fell below asymptotic constant')
            checks+=1
        print(f'PASS extremal family: p={p}; m={first_m},...,9; exact f+=(1-p) via blocker envelope and explicit coupling.')
    print(f'EXTREMAL TOTAL: {checks} fully enumerated exact instances.')

def main():
    parser=argparse.ArgumentParser();parser.add_argument('--certificates',type=Path,default=ROOT/'results'/'lp_exact_certificates.json');args=parser.parse_args()
    data=json.loads(args.certificates.read_text());need(data['format']==1,'unknown certificate format')
    check_lp_cases(data);extremal_family()
    print('PASS: all listed finite checks. Universal validity requires the written proof.')

if __name__=='__main__':main()
