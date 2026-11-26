#!/usr/bin/env python3
"""Discover rational primal/dual witnesses; reject anything not exactly feasible."""
from __future__ import annotations
import argparse
from fractions import Fraction as F
import json
from pathlib import Path
from finite_game_lp import model, solve

CASES = [('linear',2,'0','0','1/2'), ('linear',3,'0','1/2','3/8'),
         ('linear',4,'1/2','1/2','83/128'), ('linear',4,'1','1','13/16'),
         ('quadratic',3,'1/2','1/2','5/16'), ('quadratic',4,'0','1/2','47/144')]


def dot(row,x): return sum((a*x[j] for j,a in row.items()),F(0))


def exact_check(game,x,y,z):
    if len(x)!=game['nvars'] or len(y)!=len(game['eq']) or len(z)!=len(game['ub']):
        return False
    if any(v<0 for v in x[1:]) or any(v>0 for v in z):return False
    if any(dot(r,x)!=b for r,b in zip(game['eq'],game['beq'])):return False
    if any(dot(r,x)>b for r,b in zip(game['ub'],game['bub'])):return False
    dual=[F(0)]*game['nvars']
    for rows,multipliers in [(game['eq'],y),(game['ub'],z)]:
        for row,multiplier in zip(rows,multipliers):
            for j,a in row.items():dual[j]+=a*multiplier
    if dual[0]!=1 or any(v>0 for v in dual[1:]):return False
    objective=sum((a*b for a,b in zip(game['beq'],y)),F(0))+sum((a*b for a,b in zip(game['bub'],z)),F(0))
    return objective==x[0]


def encode_rows(rows):
    return [[[j,str(a)] for j,a in sorted(row.items()) if a] for row in rows]


def certificate(data):
    game,solution=solve(data)
    for denominator in [1024,10000,1000000,1000000000]:
        x=[F(float(v)).limit_denominator(denominator) for v in solution.x]
        y=[F(float(v)).limit_denominator(denominator) for v in solution.eqlin.marginals]
        z=[F(float(v)).limit_denominator(denominator) for v in solution.ineqlin.marginals]
        if exact_check(game,x,y,z):break
    else:raise ValueError('Numerical candidate has no validated rational reconstruction')
    return {'schema':'finite-game-exact-v2','model':data,
            'matrix':{'nvars':game['nvars'],'eq':encode_rows(game['eq']),
                      'beq':list(map(str,game['beq'])),'ub':encode_rows(game['ub']),
                      'bub':list(map(str,game['bub']))},
            'primal':list(map(str,x)),'dual_eq':list(map(str,y)),
            'dual_ub':list(map(str,z)),'value':str(x[0]),
            'note':'Exact finite rational witness. Not a continuum theorem or novelty assessment.'}


if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--output',type=Path,required=True)
    args=parser.parse_args();args.output.mkdir(parents=True,exist_ok=True);index=[]
    for family,T,P,B,expected in CASES:
        data=model(T,P,B,family);cert=certificate(data)
        if F(cert['value'])!=F(expected):raise ValueError('Recovered optimum disagrees with pre-recovery value')
        name=f'{family}_T{T}_P{P.replace("/","over")}_B{B.replace("/","over")}.json'
        (args.output/name).write_text(json.dumps(cert,indent=2)+'\n')
        index.append({'file':name,'value':cert['value'],'nvars':cert['matrix']['nvars']})
    (args.output/'INDEX.json').write_text(json.dumps({'schema':'certificate-index-v2','certificates':index},indent=2)+'\n')
    print(json.dumps(index,indent=2))
