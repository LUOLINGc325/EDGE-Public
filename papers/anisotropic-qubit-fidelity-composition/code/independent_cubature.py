#!/usr/bin/env python3
"""Independent exact complex-matrix verification using 24 rational sphere nodes.

Does not import the polynomial verifier or its composition formula. Each pair
of nodes is turned into two 2x2 complex matrices and multiplied explicitly.
The manuscript proves why this cubature is exact for the required moments.
"""
from fractions import Fraction as Q
from itertools import product
import argparse
import json
from pathlib import Path


def add(z,w): return (z[0]+w[0],z[1]+w[1])
def neg(z): return (-z[0],-z[1])
def conj(z): return (z[0],-z[1])
def mul(z,w): return (z[0]*w[0]-z[1]*w[1],z[0]*w[1]+z[1]*w[0])
def norm2(z): return z[0]**2+z[1]**2
def mm(A,B):
    return [[add(mul(A[i][0],B[0][j]),mul(A[i][1],B[1][j]))
             for j in range(2)] for i in range(2)]
def adj(A): return [[conj(A[j][i]) for j in range(2)] for i in range(2)]
def unitary(x):
    a,b=(x[0],x[1]),(x[2],x[3])
    return [[a,neg(conj(b))],[b,conj(a)]]
def dens(x,kind):
    if kind=='A_mode':
        return 1+x[0]/4+(2*(x[0]**2+x[1]**2)-1)/4+x[2]*(x[0]+Q(1,6))*(1-x[0])/8
    if kind=='B_mode':
        return 1+x[0]/4+(2*(x[0]**2+x[1]**2)-1)/4+Q(5,48)*x[1]*x[3]
    term=x[0]*x[2] if kind=='A' else x[1]*x[3]
    return 1+Q(1,4)*x[0]+Q(1,4)*(2*(x[0]**2+x[1]**2)-1)+Q(1,2)*term


def main():
    if not __debug__:
        raise SystemExit("Verification requires assertions: do not use python -O or -OO.")
    parser=argparse.ArgumentParser()
    parser.add_argument('--output',type=Path)
    args=parser.parse_args()
    pts=[]
    for j in range(4):
        for s in [-1,1]:
            t=[Q(0)]*4;t[j]=Q(s);pts.append(tuple(t))
    pts.extend(product([Q(-1,2),Q(1,2)],repeat=4))
    identity=[[(Q(1),Q(0)),(Q(0),Q(0))],[(Q(0),Q(0)),(Q(1),Q(0))]]
    for x in pts:
        assert sum(v*v for v in x)==1
        assert mm(adj(unitary(x)),unitary(x))==identity
    matrices={}
    for k in ['A','B','A_mode','B_mode']:
        weights=[dens(x,k)/24 for x in pts]
        assert sum(weights)==1 and min(weights)>0
        states=[]
        for i,j in product(range(2),repeat=2):
            v=(Q(0),Q(0))
            for x,w in zip(pts,weights):
                col=[(x[0],x[1]),(x[2],x[3])]
                z=mul(col[i],conj(col[j]))
                v=add(v,(w*z[0],w*z[1]))
            states.append(v)
        matrices[k]=states
    assert matrices['A']==matrices['B']==[(Q(13,24),Q(0)),(Q(1,48),Q(0)),(Q(1,48),Q(0)),(Q(11,24),Q(0))]
    assert matrices['A_mode']==matrices['B_mode']==[(Q(13,24),Q(0)),(Q(5,1152),Q(0)),(Q(5,1152),Q(0)),(Q(11,24),Q(0))]
    out=[]
    for first,second in [p for pair in [('A','B'),('A_mode','B_mode')] for p in product(pair,repeat=2)]:
        total=Q(0)
        for x,y in product(pts,repeat=2):
            U=mm(unitary(y),unitary(x))
            total+=dens(x,first)*dens(y,second)*norm2(U[0][0])/576
        if second.endswith('_mode'):
            expected=Q(334055 if second.startswith('A') else 334105,663552)
        else:
            expected=Q(193,384) if second=='A' else Q(581,1152)
        assert total==expected
        out.append({'first':first,'second':second,'actual':str(total),'matrix_products':576})
    record={'status':'passed','arithmetic':'Independent Fraction complex-pair matrices',
            'unitaries_checked':24,'ordered_matrix_products':4608,
            'single_density_matrices':matrices,'compositions':out,
            'scope':'Exact cubature arithmetic; the continuous-law bridge is an analytic theorem, not finite enumeration'}
    text=json.dumps(record,default=str,indent=2)+'\n'
    if args.output: args.output.write_text(text,encoding='utf-8')
    print(text,end='')


if __name__=='__main__': main()
