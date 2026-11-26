#!/usr/bin/env python3
"""Exact rational certificates for assignment-operator obstructions.
These certify method obstructions, NOT a counterexample to queue threshold optimality.
Only the V3 K8 check concerns the actual Bellman orbit.
"""
from __future__ import annotations
from fractions import Fraction as F
from functools import cache
import argparse,json

def q(f,m,x,y,relaxed=True):
    cap=min(m, x+y if relaxed else max(x-1,0)+y)
    return min(f(x+y-k,k) for k in range(y,cap+1))

def event(f,m,x,y,lam=F(1),a=F(4),b=F(1)):
    return lam*f(x+1,y)+a*f(max(x-1,0),y)+y*b*f(x,max(y-1,0))+(m-y)*b*f(x,y)

def cone_values(f,m,x,y):
    ans={'K1':f(x+1,y)-f(x,y)}
    if y<m:
        ans['K2']=f(x+2,y)+f(x,y+1)-f(x+1,y)-f(x+1,y+1)
        ans['K3']=f(x,y)+f(x+1,y+1)-f(x+1,y)-f(x,y+1)
        ans['K4']=f(x,y+1)-f(x,y)
    if y+2<=m:
        ans['K5']=f(x,y)+f(x,y+2)-2*f(x,y+1)
        ans['K6']=f(x+2,y)+f(x,y+2)-2*f(x+1,y+1)
    return ans

def certificate(m):
    assert m>=3
    C=m+8;n0=m+6;D=F(m+6)
    @cache
    def W(x,y):
        n=x+y
        return F(n*n+y*max(C-n,0))
    @cache
    def f(x,y):
        return F(x+y)+event(W,m,x,y)/D
    @cache
    def sw(x,y):return q(f,m,x,y)
    r=min(m,(m+7)//2)
    gap=sw(n0-1,0)+sw(n0+1,0)-2*sw(n0,0)
    expression=F(2*(m+5)-r*(m+7-r),m+6)
    assert gap==expression and gap<0
    gap_k3=sw(n0-1,0)+sw(n0,1)-sw(n0,0)-sw(n0-1,1)
    assert gap_k3==gap
    assert all(q(W,m,x,y)==W(x,y) for x in range(2*C+1) for y in range(m+1))
    observed={k:None for k in ['K1','K2','K3','K4','K5','K6']}
    for x in range(2*C+1):
        for y in range(m+1):
            for k,v in cone_values(W,m,x,y).items():
                observed[k]=v if observed[k] is None else min(observed[k],v)
    assert all(v>=0 for v in observed.values())
    return {'m':m,'C':C,'center_n':n0,'chosen_y_after_crossing':r,
            'SW_at_center_minus_one':str(sw(n0-1,0)),
            'SW_at_center':str(sw(n0,0)),
            'SW_at_center_plus_one':str(sw(n0+1,0)),
            'negative_x_convexity_and_K3':str(gap),
            'formula':str(expression),'finite_cone_minima':{k:str(v) for k,v in observed.items()},
            'finite_Qfixed_check':True,'finite_check_x_max':2*C,
            'scope':'The finite grid is a regression check; global cone membership and all-m negativity are proved analytically in assignment_closure.md.'}

def actual_k8(m,lam=F(1),a=F(4),b=F(1),alpha=F(1)):
    D=alpha+lam+a+m*b
    @cache
    def V(t,x,y):
        if not t:return F(0)
        def w(xx,yy):return q(lambda u,v:V(t-1,u,v),m,xx,yy,False)
        return F(x+y)+event(w,m,x,y,lam,a,b)/D
    x=2;y=m-2
    vals=[V(3,x,y+2),V(3,x+1,y),V(3,x,y+1),V(3,x+1,y+1)]
    gap=vals[0]+vals[1]-vals[2]-vals[3]
    assert gap==-b*b/(D*D)
    return {'m':m,'horizon':3,'x':x,'y':y,'parameters':{'lambda':str(lam),'fast':str(a),'slow':str(b),'alpha':str(alpha)},
            'terms':[str(t) for t in vals],'K8_gap':str(gap),'general_formula':'-b^2/(alpha+lambda+a+m*b)^2',
            'scope':'Exact actual nonpreemptive Bellman recursion from V0=0; not a queue-policy counterexample.'}

def convex_extension_certificate(m):
    """An input with a genuine convex extension still loses convexity under S."""
    assert m>=3
    n0=2*m+10;D=F(m+6)
    C=(F((m+6)*n0)-F(3*m+34,4))/(m+4)
    assert C>n0+2
    @cache
    def W(x,y):
        n=x+y
        return 2*C*n+max(C-x-F(y,2),0)**2
    @cache
    def f(x,y):return F(x+y)+event(W,m,x,y)/D
    @cache
    def sw(x,y):return q(f,m,x,y)
    choices=[]
    for n in [n0-1,n0,n0+1]:
        vals=[f(n-y,y) for y in range(m+1)]
        choices.append([y for y,v in enumerate(vals) if v==min(vals)])
    assert choices==[[0],[1,2],[3]]
    gap=sw(n0-1,0)+sw(n0+1,0)-2*sw(n0,0)
    assert gap==-1/D
    gap_k3=sw(n0-1,0)+sw(n0,1)-sw(n0,0)-sw(n0-1,1)
    assert gap_k3==gap
    observed={k:None for k in ['K1','K2','K3','K4','K5','K6']}
    limit=2*int(C)+3
    for x in range(limit):
        for y in range(m+1):
            assert q(W,m,x,y)==W(x,y)
            for k,v in cone_values(W,m,x,y).items():
                observed[k]=v if observed[k] is None else min(observed[k],v)
    assert all(v>=0 for v in observed.values())
    return {'m':m,'center_n':n0,'C':str(C),'minimizers_at_three_populations':choices,
            'three_optimized_values':[str(sw(n,0)) for n in [n0-1,n0,n0+1]],
            'negative_x_convexity_and_K3':str(gap),'formula':'-1/(m+6)',
            'finite_cone_minima':{k:str(v) for k,v in observed.items()},
            'convex_extension':'W=2*C*(x+y)+(C-x-y/2)_+^2, convex on the real quadrant.',
            'affine_tail':'W=2*C*(x+y) whenever x+y>=C+m/2; all coordinate marginal slopes are bounded.',
            'scope':'Global cone membership, convex extension, and all-m failure are analytic. The finite checks are regression checks, not an actual Bellman-orbit witness.'}

if __name__=='__main__':
    ap=argparse.ArgumentParser();ap.add_argument('--output');args=ap.parse_args()
    out={'claim':'method_obstructions_not_threshold_counterexamples',
         'composite_Qfixed_counterexamples':[certificate(m) for m in range(3,13)],
         'convex_extension_Qfixed_counterexamples':[convex_extension_certificate(m) for m in range(3,13)],
         'actual_V3_K8_counterexamples':[actual_k8(m) for m in range(2,13)]}
    s=json.dumps(out,indent=2)+'\n'
    if args.output:
        from pathlib import Path
        Path(args.output).write_text(s)
    else: print(s,end='')
