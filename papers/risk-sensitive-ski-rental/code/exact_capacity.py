"""Exploratory exact piecewise-affine capacity for CVaR ski rental.

Variable r is competitive ratio minus one, tail mass is q=1-delta.
All cells and coefficients use fractions.Fraction.
"""
from fractions import Fraction as Q
from dataclasses import dataclass
import json


def capacity_at(B,r,last=None):
    """O(B) ordered-field operations; exact when r is a Fraction.

    At r=(B-1)/B only i<B is permitted; append U_(B-1)+1
    separately for the left endpoint extension of the final capacity.
    """
    if B<2: raise ValueError('B>=2 required')
    if last is None: last=B
    if not 0<=r or r>Q(B-1,B) or not 0<=last<=B:
        raise ValueError('invalid domain')
    if r==Q(B-1,B) and last==B:
        u=capacity_at(B,r,B-1)
        return u+[u[-1]+1]
    prefix=[]
    total=0*r
    left=0
    suffix=0*r
    high=False
    for i in range(1,last+1):
        if prefix:
            suffix+=prefix[-1]
        if not high:
            u=(i*r+total)/(B-1)
            if u>1: high=True
        if high:
            while True:
                k=(i-1)-left
                if k<=0: raise ArithmeticError('no active predecessor')
                u=1+(i*r-(B-1)+suffix)/k
                if u-1<=prefix[left]: break
                suffix-=prefix[left]
                left+=1
        prefix.append(u)
        total+=u
    return prefix


def exact_solution(B,q):
    """Return exact value and one optimizer for rational tail mass q."""
    q=Q(q)
    if not 0<=q<=1: raise ValueError('0<=q<=1 required')
    D=Q(2*B-1,B)
    endpoint=capacity_at(B,Q(B-1,B))
    qc=1/endpoint[-1]
    if q<=qc:
        return D,[Q(0)]*(B-1)+[Q(1)]
    cells,_=partition(B)
    for lo,hi,funcs in cells:
        a,b=funcs[-1].a,funcs[-1].b
        r=(1/q-b)/a
        if lo<=r<=hi:
            u=[Q(0)]+[f(r) for f in funcs]
            p=[q*(u[i]-u[i-1]) for i in range(1,B+1)]
            return 1+r,p
    raise ArithmeticError('missing symbolic cell')


@dataclass(frozen=True)
class Affine:
    a: Q = Q(0)
    b: Q = Q(0)

    def __call__(self, r):
        return self.a*r + self.b

    def __add__(self, other):
        if not isinstance(other, Affine):
            other=Affine(Q(0),Q(other))
        return Affine(self.a+other.a,self.b+other.b)

    __radd__=__add__

    def __neg__(self):
        return Affine(-self.a,-self.b)

    def __sub__(self,other):
        return self + (-other if isinstance(other,Affine) else -Q(other))

    def __truediv__(self,d):
        return Affine(self.a/d,self.b/d)


def restrict_ge(lo,hi,f):
    """Intersect closed interval with f(r)>=0. Ignore zero length cells."""
    if f.a==0:
        return None if f.b<0 else (lo,hi)
    t=-f.b/f.a
    if f.a>0: lo=max(lo,t)
    else: hi=min(hi,t)
    return (lo,hi) if lo<hi else None


def partition(B):
    if B<2: raise ValueError('B>=2 required')
    cap=Q(B-1,B)
    # A cell records every cumulative function; retaining prefix formulas is
    # necessary to construct both the optimal distribution and certificates.
    cells=[(Q(0),cap,tuple())]
    counts=[]
    for i in range(1,B+1):
        nxt=[]
        for lo,hi,prev in cells:
            candidates=[]
            u=(Affine(Q(i),Q(0))+sum(prev,Affine()))/(B-1)
            candidates.append((u,[Affine(Q(0),Q(1))-u]))
            for ell in range(1,i):
                u=1+(Affine(Q(i),Q(-(B-1)))+sum(prev[ell-1:],Affine()))/(i-ell)
                lower=Affine(Q(0),Q(1))+(prev[ell-2] if ell>1 else 0)
                upper=1+prev[ell-1]
                candidates.append((u,[u-lower,upper-u]))
            for u,conditions in candidates:
                bounds=(lo,hi)
                for c in conditions:
                    bounds=restrict_ge(*bounds,c)
                    if bounds is None: break
                if bounds is not None:
                    nxt.append((*bounds,prev+(u,)))
        nxt.sort(key=lambda row:(row[0],row[1]))
        merged=[]
        for row in nxt:
            if merged and merged[-1][1]==row[0] and merged[-1][2]==row[2]:
                merged[-1]=(merged[-1][0],row[1],row[2])
            else: merged.append(row)
        assert merged[0][0]==0 and merged[-1][1]==cap
        assert all(a[1]==b[0] for a,b in zip(merged,merged[1:]))
        for l,h,p in merged:
            t=(l+h)/2
            assert p[-1].a>0
            assert p[-1](t)>(p[-2](t) if i>1 else 0)
        cells=merged
        counts.append(len(cells))
    return cells,counts


def summary(B):
    cells,counts=partition(B)
    h=Q(B-1,B)
    K=cells[-1][2][-1](h)
    assert K==1+cells[-1][2][-2](h)
    out=[]
    for lo,hi,p in cells:
        a,b=p[-1].a,p[-1].b
        # q*capacity=1: r=(1/q-b)/a.
        qlo=1/p[-1](hi)
        qhi=min(Q(1),1/p[-1](lo)) if lo else Q(1)
        if qlo>=qhi: continue
        out.append({'q_lo':str(qlo),'q_hi':str(qhi),
                    'ratio_constant':str(1-b/a),'ratio_inverse_q':str(1/a),
                    'r_lo':str(max(lo,(Q(1)-b)/a)),'r_hi':str(hi),
                    'cumulative':[[str(f.a),str(f.b)] for f in p]})
    return {'B':B,'capacity_at_endpoint':str(K),'q_critical':str(1/K),
            'delta_critical':str(1-1/K),'partition_counts':counts,'pieces':out}


if __name__=='__main__':
    import argparse
    ap=argparse.ArgumentParser();ap.add_argument('--max-B',type=int,default=12);ap.add_argument('--output')
    args=ap.parse_args()
    data=[summary(B) for B in range(2,args.max_B+1)]
    for d in data:
        print(d['B'],d['delta_critical'],len(d['pieces']),d['partition_counts'][-1])
    if args.output:
        from pathlib import Path
        Path(args.output).write_text(json.dumps(data,indent=2)+'\n')
