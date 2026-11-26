#!/usr/bin/env python3
"""Exact cut mixtures with strictly positive slack outside K3 or K5.

These distributions prove the equality-support part of the finite-order
theorem. This program uses only rational arithmetic and the standard library.
"""
import argparse
import itertools
import json
from fractions import Fraction as F
from pathlib import Path


def distribution(n,k):
    if k not in (3,5) or n<k:
        raise ValueError('Requires k=3 or k=5 and n>=k')
    p=F(2,3) if k==3 else F(3,5)
    q0=F(1,2) if k==3 else F(3,8)
    minority=list(itertools.combinations(range(k),(k-1)//2))
    probs={}
    for special in minority:
        for tail in range(1<<(n-k)):
            bits=[int(i in special) for i in range(k)]+[(tail>>i)&1 for i in range(n-k)]
            ones=tail.bit_count()
            prob=p**ones*(1-p)**(n-k-ones)/len(minority)
            if bits[0]:
                bits=[1-b for b in bits]
            mask=sum(b<<(i-1) for i,b in enumerate(bits) if i>0)
            probs[mask]=probs.get(mask,F(0))+prob
    assert sum(probs.values())==1 and all(v>=0 for v in probs.values())
    slack_by_type={}
    for a,b in itertools.combinations(range(n),2):
        prob=sum(v for mask,v in probs.items() if (0 if a==0 else (mask>>(a-1))&1)!=(0 if b==0 else (mask>>(b-1))&1))
        target=F(2,5)+F(4,15)*q0*(int(a<k)+int(b<k))
        kind='inside' if b<k else ('cross' if a<k else 'outside')
        slack=prob-target
        if kind in slack_by_type:
            assert slack==slack_by_type[kind]
        slack_by_type[kind]=slack
    assert slack_by_type['inside']==0
    assert all(v>0 for k,v in slack_by_type.items() if k!='inside')
    return {'n':n,'k':k,'outside_minority_probability':str(p),
            'gradient':[str(q0 if i<k else 0) for i in range(n)],
            'cuts':[[i,str(v)] for i,v in sorted(probs.items())],
            'slack_by_type':{k:str(v) for k,v in slack_by_type.items()}}


if __name__=='__main__':
    ap=argparse.ArgumentParser()
    ap.add_argument('--n',type=int,default=8)
    ap.add_argument('--output',type=Path,default=Path('results/exceptional_cut_distributions.json'))
    args=ap.parse_args()
    result={'schema':'exceptional_cut_distributions_v1','certificates':[distribution(args.n,k) for k in (3,5)]}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({'verified':True,'n':args.n,'slacks':[r['slack_by_type'] for r in result['certificates']]}))
