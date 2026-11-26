#!/usr/bin/env python3
"""Independent standard-library certificate verifier. Imports no author solver.

Reconstructs the entire causal game, enumerates feasible hindsight comparators,
and checks rational primal/dual optimality for the claimed game.
"""
from __future__ import annotations
import argparse
from fractions import Fraction
from itertools import product
import json
from pathlib import Path
import sys

Q=Fraction


def verify(path):
    item=json.loads(path.read_text());data=item['model']
    assert item['schema']=='finite-game-exact-v2'
    T=data['horizon'];locations=list(map(Q,data['actions']))
    losses=[list(map(Q,row)) for row in data['loss_table']]
    P=Q(data['path_budget']);B=Q(data['switch_budget']);n=len(locations);k=len(losses)
    assert T>=1 and n>=1 and k>=1 and P>=0 and B>=0
    assert all(len(row)==n for row in losses)
    prefixes=[h for t in range(T) for h in product(range(k),repeat=t)]
    p={};q={};column=1
    for h in prefixes:
        p[h]=list(range(column,column+n));column+=n
        if h:
            q[h]=[[column+i*n+j for j in range(n)] for i in range(n)];column+=n*n
    eq=[{j:Q(1) for j in p[()]}];beq=[Q(1)]
    for h in prefixes[1:]:
        for i in range(n):
            row={q[h][i][j]:Q(1) for j in range(n)};row[p[h[:-1]][i]]=Q(-1)
            eq.append(row);beq.append(Q(0))
        for j in range(n):
            row={q[h][i][j]:Q(1) for i in range(n)};row[p[h][j]]=Q(-1)
            eq.append(row);beq.append(Q(0))
    comparator_paths=[u for u in product(range(n),repeat=T)
                      if sum((abs(locations[u[t]]-locations[u[t-1]]) for t in range(1,T)),Q(0))<=P]
    ub=[];bub=[]
    for word in product(range(k),repeat=T):
        r={0:Q(-1)};s={}
        for t in range(T):
            for i in range(n):
                idx=p[word[:t]][i];r[idx]=r.get(idx,Q(0))+losses[word[t]][i]
            if t:
                for i in range(n):
                    for j in range(n):
                        if i!=j:s[q[word[:t]][i][j]]=Q(1)
        best=min(sum((losses[word[t]][u[t]] for t in range(T)),Q(0)) for u in comparator_paths)
        ub.extend([r,s]);bub.extend([best,B])
    def clean(rows):return [{j:a for j,a in row.items() if a} for row in rows]
    def decode(rows):
        out=[]
        for entries in rows:
            row={int(j):Q(a) for j,a in entries}
            assert len(row)==len(entries) and all(0<=j<column for j in row)
            out.append({j:a for j,a in row.items() if a})
        return out
    matrix=item['matrix'];assert matrix['nvars']==column
    assert decode(matrix['eq'])==clean(eq) and list(map(Q,matrix['beq']))==beq
    assert decode(matrix['ub'])==clean(ub) and list(map(Q,matrix['bub']))==bub
    x=list(map(Q,item['primal']));y=list(map(Q,item['dual_eq']));z=list(map(Q,item['dual_ub']))
    assert len(x)==column and len(y)==len(eq) and len(z)==len(ub)
    assert all(v>=0 for v in x[1:]) and all(v<=0 for v in z)
    def dot(row):return sum((a*x[j] for j,a in row.items()),Q(0))
    assert all(dot(row)==b for row,b in zip(eq,beq))
    assert all(dot(row)<=b for row,b in zip(ub,bub))
    dual=[Q(0)]*column
    for rows,mults in [(eq,y),(ub,z)]:
        for row,m in zip(rows,mults):
            for j,a in row.items():dual[j]+=a*m
    assert dual[0]==1 and all(v<=0 for v in dual[1:])
    value=sum((a*b for a,b in zip(beq,y)),Q(0))+sum((a*b for a,b in zip(bub,z)),Q(0))
    assert value==x[0]==Q(item['value'])
    return {'file':path.name,'value':str(value),'nvars':column,'equations':len(eq),
            'inequalities':len(ub),'comparator_paths_enumerated':len(comparator_paths),'passed':True}


if __name__=='__main__':
    if not __debug__:raise RuntimeError('Do not run this verifier with python -O')
    parser=argparse.ArgumentParser();parser.add_argument('directory',type=Path)
    parser.add_argument('--output',type=Path,required=True);args=parser.parse_args()
    rows=[verify(p) for p in sorted(args.directory.glob('*.json')) if p.name!='INDEX.json']
    assert len(rows)==6
    report={'all_passed':True,'count':len(rows),'arithmetic':'fractions.Fraction',
            'solver_imports':False,'model_reconstructed':True,'certificates':rows}
    args.output.write_text(json.dumps(report,indent=2)+'\n');print(json.dumps(report,indent=2))
