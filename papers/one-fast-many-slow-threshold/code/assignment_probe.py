#!/usr/bin/env python3
"""Exploratory finite-horizon Bellman and stronger-cone checks.
Floating-point output is exploratory, not a theorem or infinite-horizon certificate.
"""
from __future__ import annotations
import argparse,json
import numpy as np

def assignment(f, relaxed=False):
    n,m1=f.shape; m=m1-1
    h=f.copy()
    for y in range(m):
        for k in range(y+1,m+1):
            s=k-y
            start=s if relaxed else s+1
            if start>=n: continue
            h[start:,y]=np.minimum(h[start:,y],f[start-s:n-s,k])
    return h

def step(f,lam,a,b,alpha,relaxed=False):
    n,m1=f.shape;m=m1-1
    h=assignment(f,relaxed)
    # Last row is dropped: this is exact finite propagation, with no artificial cap.
    out=np.indices((n-1,m1)).sum(axis=0).astype(float)
    for x in range(n-1):
        for y in range(m1):
            out[x,y]+=(lam*h[x+1,y]+a*h[max(x-1,0),y]+y*b*h[x,max(y-1,0)]+(m-y)*b*h[x,y])/(alpha+lam+a+m*b)
    return out

def k8(f):
    z=f[:-1,2:]+f[1:,:-2]-f[:-1,1:-1]-f[1:,1:-1]
    ij=np.unravel_index(np.argmin(z),z.shape)
    return float(z[ij]),tuple(map(int,ij))

def run(m,lam,a,b,alpha,horizon=150,cutoff=50,relaxed=False):
    f=np.zeros((cutoff+horizon+1,m+1))
    first=None
    worst=(0,None,None)
    for t in range(1,horizon+1):
        f=step(f,lam,a,b,alpha,relaxed)
        r,ij=k8(f[:cutoff+1])
        if r<worst[0]:worst=(r,t,ij)
        if r<-1e-9 and first is None:first=(r,t,ij)
    return {'parameters':[m,lam,a,b,alpha], 'relaxed':relaxed,'horizon':horizon,'first_violation':first,'worst':worst}

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--quick',action='store_true');args=ap.parse_args()
    rows=[]
    for m in [2,3,4,8]:
        for lam,a,b,alpha in [(1,4,1,1),(.1,10,1,.1),(5,10,1,.01),(10,2,1,1),(1,2,1,10)]:
            rows.append(run(m,lam,a,b,alpha,horizon=30 if args.quick else 150,cutoff=15 if args.quick else 50))
    print(json.dumps(rows,indent=2))
