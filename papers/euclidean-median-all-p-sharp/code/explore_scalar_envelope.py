#!/usr/bin/env python3
"""Finite-grid research diagnostic, not a proof or a certified sharp constant.

Enumerates the radial stationary branches separated by the exact turning points
of their derivative equation, then builds a lower hull on a finite X grid.
The continuous-envelope and analytic-branch obligations remain separate.
"""
import json
from pathlib import Path
from math import sqrt,log,exp
import numpy as np
from scipy.optimize import brentq


def radial_minimum(p,lam,X):
    if p==1:
        if X==1:return -lam,1.0
        r=sqrt(X)+lam*sqrt((1-X)/(1-lam*lam))
        return sqrt(1-lam*lam)*sqrt(1-X)-lam*sqrt(X),r
    if p==2:
        r=sqrt(X)/(1-lam*lam)
        return 1-X/(1-lam*lam),r
    if X==0:
        if p>=2:return 1.0,0.0
        q=exp(2*p/(2-p)*log(lam))
        return (1-q)**(1-p/2),sqrt(q/(1-q))
    if X==1:
        c=exp(p/(p-1)*log(lam));r=1/(1-c)
        return -(c/(1-c))**(p-1),r
    s=sqrt(X);a=1-X;log_target=p*log(lam)
    def eq(r):
        u=r-s
        if u<=0:return -float('inf')
        return log(u)+(p/2-1)*log(u*u+a)-(p-1)*log(r)-log_target
    # For p>=2, all possible minimizers lie below the endpoint radius R.
    # For p<2, the stationarity equation is increasing; grow the bracket.
    if p>=2:
        c=exp(p/(p-1)*log(lam));R=1/(1-c)+1e-9
    else:
        R=2.0
        while eq(R)<0:R*=2
    points=[s]
    disc=(p-2)**2*a*a-4*(p-1)*a*X
    if p>2 and disc>0:
        for u in [((p-2)*a-sqrt(disc))/(2*(p-1)*s),((p-2)*a+sqrt(disc))/(2*(p-1)*s)]:
            r=s+u
            if s<r<R:points.append(r)
    points.append(R);points=sorted(points)
    candidates=[]
    for lo,hi in zip(points[:-1],points[1:]):
        fl,fh=eq(lo),eq(hi)
        if fl==0:candidates.append(lo)
        if fh==0:candidates.append(hi)
        if fl*fh<0:candidates.append(brentq(eq,lo,hi,xtol=2e-14))
    if not candidates:raise RuntimeError((p,lam,X,points,[eq(r) for r in points]))
    def value(r):
        A=(r-s)**2+a
        return A**(p/2)-exp(p*log(lam))*r**p
    r=min(candidates,key=value)
    return value(r),r


def grid_envelope(p,lam,grid_size=501):
    xs=np.linspace(0,1,grid_size)
    ys=np.array([radial_minimum(p,lam,float(x))[0] for x in xs])
    hull=[]
    for i in range(grid_size):
        while len(hull)>=2:
            j,k=hull[-2],hull[-1]
            if (ys[k]-ys[j])*(xs[i]-xs[k])>=(ys[i]-ys[k])*(xs[k]-xs[j])-1e-14:
                hull.pop()
            else:break
        hull.append(i)
    for j,k in zip(hull[:-1],hull[1:]):
        if xs[j]<=.5<=xs[k]:
            theta=(xs[k]-.5)/(xs[k]-xs[j])
            return theta*ys[j]+(1-theta)*ys[k],(float(xs[j]),float(xs[k])),len(hull)
    raise RuntimeError('Missing mean')


def scan(p,grid_size=501):
    hi=2**(-.5) if p<=2 else 2**(-1+1/p)
    v,contact,nh=grid_envelope(p,hi,grid_size)
    if v>=-1e-10:lam=hi
    else:lam=brentq(lambda l:grid_envelope(p,l,grid_size)[0],1/3,hi,xtol=1e-12)
    value,contact,nh=grid_envelope(p,lam,grid_size)
    return {'p':p,'lambda_grid':lam,'C_grid':1/lam,'grid_contacts':contact,'grid_hull_vertices':nh,'value_at_half':value,'one_dimensional_constant':2**(1-1/p),'note':'Finite grid and floating-point roots only; not a proof or rigorous error enclosure.'}


if __name__=='__main__':
    ps=[1,1.05,1.2,1.5,1.8,1.95,2,2.1,2.5,3,3.5,3.9,4,4.1,4.5,5,6,8,12,20]
    rows=[scan(p) for p in ps]
    out={'status':'exploratory_only','grid_size':501,'rows':rows}
    target=Path(__file__).resolve().parents[1]/'results/scalar_exploration.json'
    target.write_text(json.dumps(out,indent=2)+'\n')
    for row in rows:print(f"p={row['p']:5g}  C={row['C_grid']:.12f}  contacts={row['grid_contacts']}")
