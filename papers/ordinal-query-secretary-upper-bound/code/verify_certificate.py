#!/usr/bin/env python3
"""Exact finite-information certificate, using only the Python standard library.

No optimization solver, floating-point assertion, or external data is used.
The proof linking this finite experiment to the original secretary model is
written separately in the manuscript; this program verifies the finite part.
"""
from __future__ import annotations

import argparse
from dataclasses import dataclass
from fractions import Fraction as Q
from functools import lru_cache
from itertools import product
from pathlib import Path
import json

PERMUTATIONS = ((1,4,3,2), (2,1,4,3), (4,1,3,2),
                (4,2,1,3), (4,3,1,2), (4,3,2,1))
NUMERATORS = (2,1,2,1,2,3)
DENOMINATOR = 11
FRONTIER = ((3,21,28,11,0), (4,18,18,0,0))
ZERO = (0,0,0,0,0)
UPPER = Q(14845259,37748736)

def require(condition, message):
    if not condition:
        raise ValueError(message)

@dataclass(frozen=True)
class World:
    permutation_index: int
    sample_mask: int
    sample_count: int
    arrivals: tuple[int, ...]
    observations: tuple[int, ...]
    responses: tuple[int, ...]

def make_worlds():
    """Rank 1 sampled or passed worlds contribute zero to every future payoff."""
    worlds=[]
    for ip,perm in enumerate(PERMUTATIONS):
        for mask in range(16):
            if mask & 1:
                continue
            sample={i+1 for i in range(4) if mask >> i & 1}
            seen=set(sample)
            arr=[]; obs=[]; replies=[min(seen)-1 if seen else 4]
            for rank in perm:
                if rank in sample:
                    continue
                arr.append(rank)
                obs.append(sum(x<rank for x in seen))
                seen.add(rank)
                replies.append(min(seen)-1)
            worlds.append(World(ip,mask,len(sample),tuple(arr),tuple(obs),tuple(replies)))
    return worlds

def build_graph(worlds):
    nodes=[]
    @lru_cache(None)
    def visit(ids, time, query_remaining):
        ids=tuple(i for i in ids if worlds[i].responses[time]>0)
        if not ids:
            return -1
        groups={}
        for i in ids:
            groups.setdefault(worlds[i].observations[time], []).append(i)
        arrivals=[]
        for observation,group in sorted(groups.items()):
            coefficients=[0]*5
            for i in group:
                w=worlds[i]
                if w.arrivals[time]==1:
                    coefficients[w.sample_count]+=NUMERATORS[w.permutation_index]
            successor=visit(tuple(group), time+1, query_remaining)
            arrivals.append({'observation':observation,
                             'accept_coefficients':coefficients,
                             'reject_successor':successor})
        query=[]
        if query_remaining:
            groups={}
            for i in ids:
                groups.setdefault(worlds[i].responses[time], []).append(i)
            for response,group in sorted(groups.items()):
                query.append({'response':response,
                              'successor':visit(tuple(group),time,False)})
        index=len(nodes)
        nodes.append({'world_ids':list(ids),'time':time,
                      'query_remaining':bool(query_remaining),
                      'arrival_branches':arrivals,'query_branches':query})
        return index
    root=visit(tuple(range(len(worlds))),0,True)
    return nodes,root

def vector_add(left,right):
    return tuple(x+y for x,y in zip(left,right))

def minkowski(left,right):
    return {vector_add(x,y) for x in left for y in right}

def enumerate_all_policies(nodes):
    """Enumerate every distinct coefficient vector. No dominance pruning."""
    values=[]
    for i,node in enumerate(nodes):
        waiting={ZERO}
        for branch in node['arrival_branches']:
            j=branch['reject_successor']
            require(j<i,'Non-acyclic reject edge')
            choices={tuple(branch['accept_coefficients'])}
            choices.update(values[j] if j>=0 else {ZERO})
            waiting=minkowski(waiting,choices)
        querying={ZERO}
        for branch in node['query_branches']:
            j=branch['successor']
            require(0<=j<i,'Invalid query edge')
            querying=minkowski(querying,values[j])
        values.append(waiting|querying)
    return values

def dominates(a,b):
    return all(x>=y for x,y in zip(a,b))

def evaluate(coefficients,p):
    return sum(Q(c,DENOMINATOR)*p**h*(1-p)**(4-h)
               for h,c in enumerate(coefficients))

def poly_add(a,b):
    return tuple((a[i] if i<len(a) else 0)+(b[i] if i<len(b) else 0)
                 for i in range(max(len(a),len(b))))

def poly_scale(a,c):
    return tuple(c*x for x in a)

def poly_mul(a,b):
    out=[Q(0)]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):
            out[i+j]+=x*y
    return tuple(out)

def pad(a,n=5):
    return tuple(a)+(Q(0),)*(n-len(a))

def verify_sos():
    p=(Q(0),Q(1)); q=(Q(1),Q(-1)); a=Q(5,16)
    square=lambda x:poly_mul(x,x)
    shifted=(-a-Q(11,18432),Q(1))
    bracket=poly_add(poly_mul(q,(Q(35,8),Q(-1))),(Q(43,256),))
    sos_a=poly_add(poly_scale(square(shifted),Q(9,11)),
                   poly_scale(poly_mul(square((-a,Q(1))),bracket),Q(1,11)))
    A=tuple(Q(x,11) for x in (3,9,-17,6,-1))
    require(pad(sos_a)==pad(poly_add((UPPER,),poly_scale(A,-1))),
            'First sum-of-squares identity failed')
    sos_b=poly_add(poly_scale(square(poly_mul(q,(Q(1),Q(-7)))),Q(1,88)),
                  poly_scale(square(poly_mul(p,q)),Q(9,44)))
    sos_b=poly_add(sos_b,poly_scale(poly_mul(poly_mul(square(p),p),q),Q(3,2)))
    sos_b=poly_add(sos_b,poly_scale(square(square(p)),Q(3,8)))
    B=tuple(Q(x,11) for x in (4,2,-12,2,4))
    require(pad(sos_b)==pad(poly_add((Q(3,8),),poly_scale(B,-1))),
            'Second sum-of-squares identity failed')
    require(Q(3,8)<UPPER<Q(39327,100000),'Rational ordering failed')
    return {'A_identity':'exact coefficient equality',
            'B_identity':'exact coefficient equality',
            'upper':str(UPPER),'simple_upper':'39327/100000',
            'simple_upper_slack':str(Q(39327,100000)-UPPER)}

def run(output):
    require(sum(NUMERATORS)==DENOMINATOR,'Distribution not normalized')
    require(all(sorted(p)==[1,2,3,4] for p in PERMUTATIONS),'Not permutations')
    worlds=make_worlds()
    nodes,root=build_graph(worlds)
    sets=enumerate_all_policies(nodes)
    all_vectors=sets[root]
    require(len(worlds)==48,'Unexpected world count')
    require(len(nodes)==33,'Unexpected decision-state count')
    require(len(all_vectors)==744,'Unexpected complete coefficient count')
    require(all(c in all_vectors for c in FRONTIER),'Frontier not attainable')
    for c in all_vectors:
        require(any(dominates(f,c) for f in FRONTIER),
                'Undominated policy: '+str(c))
    checks=verify_sos()
    # Integer coefficient domination certifies every real p in [0,1].
    # These exact evaluations are cross-checks, not the universal proof.
    for j in range(101):
        p=Q(j,100)
        actual=max(evaluate(c,p) for c in all_vectors)
        predicted=max(evaluate(c,p) for c in FRONTIER)
        require(actual==predicted<=UPPER,'Exact rational cross-check failed')
    output.mkdir(parents=True,exist_ok=True)
    def save(name,value):
        (output/name).write_text(json.dumps(value,indent=2,ensure_ascii=False)+'\n')
    save('finite_kernel.json',{'permutations':PERMUTATIONS,'numerators':NUMERATORS,
         'denominator':DENOMINATOR,'worlds':[w.__dict__ for w in worlds],
         'nodes':nodes,'root':root})
    save('all_policy_coefficients.json',{'basis':'p^h (1-p)^(4-h) / 11; h=0,...,4',
         'vectors':sorted(all_vectors),'frontier':FRONTIER,
         'node_vector_counts':[len(v) for v in sets]})
    summary={'status':'passed','arithmetic':'exact integers and fractions',
             'worlds':48,'states':33,'distinct_policy_coefficients':744,
             'pruning_used_in_enumeration':False,'frontier':FRONTIER,
             'rational_cross_checks':101,'sos':checks,
             'scope':'Finite top-four decision problem and real-parameter algebra. '
                     'Original-model projection and the 6/n sampling transfer are proved in the manuscript.'}
    save('exact_certificate.json',summary)
    print(json.dumps(summary,indent=2))

if __name__=='__main__':
    parser=argparse.ArgumentParser()
    parser.add_argument('--output',type=Path,
                        default=Path(__file__).resolve().parents[1]/'results')
    run(parser.parse_args().output)
