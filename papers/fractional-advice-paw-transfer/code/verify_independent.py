#!/usr/bin/env python3
"""Non-author verification against a fully explicit virtual-capacity graph.

All allocations and comparisons use exact fractions. The reference sees final
advice only to build the static graph for an equivalence check; the delivered
algorithm is then called with rowwise advice and no horizon. Every subarrival
is compared, in addition to every returned original row. This script is a
finite audit, not a formal proof of the all-real theorem.
"""
from fractions import Fraction as Q
from random import Random
from pathlib import Path
from hashlib import sha256
import argparse
import importlib.util
import json


def explicit_waterfill(caps,loads,neighbors,supply):
    while supply:
        remaining=[j for j in neighbors if loads[j]<1]
        if not remaining:
            return
        low=min(loads[j] for j in remaining)
        active=[j for j in remaining if loads[j]==low]
        above=[loads[j] for j in remaining if loads[j]>low]
        target=min(above) if above else Q(1)
        capacity=sum((caps[j] for j in active),Q(0))
        rise=min(target-low,supply/capacity)
        assert rise>0
        for j in active:
            loads[j]+=rise
        supply-=capacity*rise


def explicit_run(n,rows,lam):
    caps=[];origins=[];pair={}
    for i,(neighbors,advice) in enumerate(rows):
        for j,a in enumerate(advice):
            if a>0:
                pair[i,j]=len(caps)
                caps.append(a);origins.append(j)
    for j in range(n):
        residual=1-sum((advice[j] for _,advice in rows),Q(0))
        assert residual>=0
        if residual:
            caps.append(residual);origins.append(j)
    loads=[Q(0) for _ in caps]
    def aggregate():
        return [sum((caps[k]*loads[k] for k,u in enumerate(origins) if u==j),Q(0))
                for j in range(n)]
    history=[];outrows=[]
    for i,(neighbors,advice) in enumerate(rows):
        before=aggregate()
        virtual_neighbors=[k for k,j in enumerate(origins) if j in neighbors]
        steps=[(j,a) for j,a in enumerate(advice) if a]
        # The delivered routine also calls its waterfill for a zero remainder.
        steps.append((None,1-sum(advice,Q(0))))
        for target,demand in steps:
            if target is None:
                push=Q(0)
            else:
                k=pair[i,target]
                assert demand==caps[k]
                push=caps[k]*max(Q(0),lam-loads[k])
                loads[k]+=push/caps[k]
            explicit_waterfill(caps,loads,virtual_neighbors,demand-push)
            history.append(aggregate())
        after=aggregate()
        outrows.append({j:after[j]-before[j] for j in neighbors})
    return history,outrows


def check(mod,n,rows,lam,stats):
    class ObservedPAW(mod.FractionalPAW):
        def __init__(self,n,trust):
            super().__init__(n,trust)
            self.subarrival_history=[]
        def _waterfill(self,neighbors,supply):
            answer=super()._waterfill(neighbors,supply)
            self.subarrival_history.append(self.loads())
            return answer
    expected_history,expected_rows=explicit_run(n,rows,lam)
    algorithm=ObservedPAW(n,lam)
    actual_rows=[]
    for neighbors,advice in rows:
        actual_rows.append(algorithm.arrive(neighbors,{j:a for j,a in enumerate(advice) if a}))
    assert actual_rows==expected_rows,(n,rows,lam,"row mismatch",actual_rows,expected_rows)
    assert algorithm.subarrival_history==expected_history,(n,rows,lam,"subarrival mismatch")
    for row in actual_rows:
        assert sum(row.values(),Q(0))<=1
    assert all(Q(0)<=z<=1 for z in algorithm.loads())
    assert sum((sum(row.values(),Q(0)) for row in actual_rows),Q(0))==sum(algorithm.loads(),Q(0))
    stats["runs"]+=1
    stats["subarrival_comparisons"]+=len(expected_history)
    stats["row_comparisons"]+=len(rows)


def random_instance(rng,n,T):
    capacities=[Q(1) for _ in range(n)]
    rows=[]
    for _ in range(T):
        neighbors=tuple(j for j in range(n) if rng.random()<0.6)
        advice=[Q(0) for _ in range(n)]
        rem=Q(1)
        order=list(neighbors);rng.shuffle(order)
        for j in order:
            amount=min(capacities[j],rem)*Q(rng.randrange(6),5)
            advice[j]=amount;rem-=amount;capacities[j]-=amount
        rows.append((neighbors,tuple(advice)))
    return rows


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--implementation",type=Path)
    parser.add_argument("--output",type=Path)
    parser.add_argument("--random-instances",type=int,default=3000)
    args=parser.parse_args()
    here=Path(__file__).resolve().parent
    source=args.implementation or here/"paw_fractional.py"
    if not source.is_file():
        parser.error(f"Implementation file was not found: {source.name}")
    spec=importlib.util.spec_from_file_location("delivered_paw",source)
    mod=importlib.util.module_from_spec(spec);spec.loader.exec_module(mod)
    stats={"status":"pass","runs":0,"subarrival_comparisons":0,"row_comparisons":0,
           "seed":20261126,"arithmetic":"exact fractions; no floating tolerance",
           "implementation_sha256":sha256(source.read_bytes()).hexdigest()}
    examples=[(0,[((),())]),
              (1,[((0,),(Q(1,2),)),((0,),(Q(1,2),)),((0,),(Q(0),))]),
              (2,[((0,1),(Q(0),Q(0))),((0,1),(Q(1,3),Q(2,3))),
                  ((0,1),(Q(2,3),Q(1,3))),((0,),(Q(0),Q(0))),
                  ((),(Q(0),Q(0)))])]
    for n,rows in examples:
        for lam in (Q(0),Q(1,4),Q(1,2),Q(3,4),Q(1)):
            check(mod,n,rows,lam,stats)
    rng=Random(stats["seed"])
    for _ in range(args.random_instances):
        n=rng.randrange(1,7);T=rng.randrange(1,10)
        rows=random_instance(rng,n,T)
        for lam in (Q(0),Q(1),Q(rng.randrange(1,100),100)):
            check(mod,n,rows,lam,stats)
    stats["coverage"]=["all original-edge row outputs","all subarrival aggregate loads",
                       "empty neighborhoods","zero remainder","repeated advice to same original vertex",
                       "advice to previously loaded residual","fully advised capacity","lambda endpoints"]
    report=json.dumps(stats,indent=2)+"\n"
    if args.output:
        args.output.write_text(report)
    print(report,end="")


if __name__=="__main__":
    main()
