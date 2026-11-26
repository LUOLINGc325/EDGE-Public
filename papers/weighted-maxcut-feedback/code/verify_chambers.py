#!/usr/bin/env python3
"""Standard-library-only replay of a finite-order BEKSZ certificate.

Checks every branch of a binary chamber partition and the exact cut mixture
in every nonempty leaf. No floating-point values or solver output flags are
trusted. A successful replay proves the inequality at this fixed order n,
using the continuity and relabeling argument stated in the manuscript.
"""
from fractions import Fraction as F
import argparse
import gzip
import itertools
import json
from pathlib import Path


def require(condition,message):
    if not condition:
        raise ValueError(message)


def verify(path):
    raw=gzip.decompress(path.read_bytes()) if path.suffix=='.gz' else path.read_bytes()
    data=json.loads(raw)
    require(data['schema']=='exact_chamber_cut_certificates_v1','schema')
    n=data['n']; masks=data['masks']; tree=data['tree']
    require(n>=3,'order')
    expected={m for m in range(1,1<<n,2) if m!=(1<<n)-1}
    require(len(masks)==len(set(masks)) and set(masks)==expected,'hyperplane inventory')
    seen=set(); leaves=prunes=0; positive_margins=[]; zero_gradients=[]
    initial=[]
    initial.append(([0]*(n-1)+[-1,1],F(0)))
    for i in range(n-1):
        v=[0]*(n+1); v[i]=-1; v[i+1]=1; v[n]=1
        initial.append((v,F(0)))
    v=[0]*(n+1); v[0]=v[n]=1
    initial.append((v,F(1)))

    def walk(index,depth,rows):
        nonlocal leaves,prunes
        require(isinstance(index,int) and 0<=index<len(tree),'node index')
        require(index not in seen,'node reused or cycle')
        seen.add(index); node=tree[index]
        if node['kind']=='split':
            require(depth<len(masks),'split past terminal depth')
            require(len(node['children'])==2,'missing sign branch')
            for sign,child in zip([-1,1],node['children']):
                v=[-sign*int((masks[depth]>>i)&1) for i in range(n)]+[1]
                walk(child,depth+1,rows+[(v,F(-sign))])
        elif node['kind']=='prune':
            multipliers={}
            for j,v in node['multipliers']:
                require(isinstance(j,int) and 0<=j<len(rows) and j not in multipliers,'dual index')
                v=F(v); require(v>=0,'negative upper-inequality multiplier')
                multipliers[j]=v
            z=F(node['equality_multiplier'])
            coefficients=[z]*n+[F(0)]
            upper=2*z
            for j,m in multipliers.items():
                row,rhs=rows[j]
                coefficients=[a+m*b for a,b in zip(coefficients,row)]
                upper+=m*rhs
            require(coefficients==[F(0)]*n+[F(1)],'invalid dual combination')
            require(upper<=0 and upper==F(node['margin_upper']),'cannot exclude positive margin')
            prunes+=1
        elif node['kind']=='leaf':
            require(depth==len(masks),'unfinished chamber leaf')
            require(not node.get('unverified',False),'unverified cut leaf')
            d=list(map(F,node['degrees']))
            require(len(d)==n and sum(d)==2,'degree normalization')
            for row,rhs in rows:
                require(sum(row[i]*d[i] for i in range(n))<rhs,'non-interior witness')
            eps=[[1]+[1-2*((m>>(i-1))&1) for i in range(1,n)] for m in range(1<<(n-1))]
            q=[F(0)]*n
            for e in eps:
                z=sum(x*y for x,y in zip(d,e))
                require(z!=0,'zero Rademacher sum at witness')
                s=1 if z>0 else -1
                q=[a+F(b*s,len(eps)) for a,b in zip(q,e)]
            require(list(map(F,node['gradient']))==q,'incorrect chamber gradient')
            p={}
            for mask,v in node['cuts']:
                require(isinstance(mask,int) and 0<=mask<len(eps) and mask not in p,'cut index')
                v=F(v); require(v>=0,'negative cut probability'); p[mask]=v
            require(sum(p.values())==1,'cut probability normalization')
            slacks=[]
            for a,b in itertools.combinations(range(n),2):
                prob=sum(v for mask,v in p.items() if eps[mask][a]!=eps[mask][b])
                target=F(2,5)+F(4,15)*(q[a]+q[b])
                require(prob>=target,f'edge inequality fails at {a},{b}')
                slacks.append(prob-target)
            margin=min(slacks)
            require(margin==F(node['minimum_edge_slack']),'incorrect stored edge margin')
            if margin>0:
                positive_margins.append(margin)
            else:
                zero_gradients.append([str(x) for x in q])
            leaves+=1
        else:
            raise ValueError('unknown node kind')
    walk(0,0,initial)
    require(len(seen)==len(tree),'unvisited extraneous tree nodes')
    return {'verified':True,'n':n,'leaves':leaves,'pruned_branches':prunes,
            'tree_nodes':len(tree),'arithmetic':'fractions.Fraction; no solver needed',
            'minimum_positive_edge_margin':str(min(positive_margins)) if positive_margins else None,
            'zero_margin_gradients':zero_gradients}


if __name__=='__main__':
    ap=argparse.ArgumentParser()
    ap.add_argument('files',nargs='+',type=Path)
    args=ap.parse_args()
    for path in args.files:
        print(json.dumps({'file':str(path),**verify(path)}))
