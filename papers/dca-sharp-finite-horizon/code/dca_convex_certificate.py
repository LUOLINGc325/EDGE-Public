"""Exploratory exact-rational certificate assembly; not a theorem checker.

GD weights below are transposed to f2 interpolation directions.  The lift
coefficient calculation follows the independently obtained x--s cancellation
identity.  All arithmetic is rational.  A negative multiplier is reported,
never silently clipped.  The domain tested is 0<eta<=1, -eta<rho<0.
"""
from fractions import Fraction as Q
from collections import defaultdict


def E(n,z):
    return sum((z**(-j) for j in range(1,2*n+1)),Q(0))


def add(W,i,j,c):
    W[i,j] += c


def d2(k,h,r):
    a=h-r
    W=defaultdict(Q)
    for i in range(k):
        T=E(i,h)-E(i,r)
        U=E(i+1,h)-E(i+1,r)
        add(W,i,i+1,1-r*E(i+1,r)+(1-h)*T/(2*a)-h*(1+r)*U/(2*a))
        add(W,i+1,i,-r*E(i+1,r)+(1+r)*T/(2*a)+r*(1-h)*U/(2*a))
        add(W,i,i+2,h*U/(2*a))
        add(W,i+2,i,-r*U/(2*a))
    return W


def convex_gd(n,h,r):
    a=h-r
    T=lambda k:E(k,h)-E(k,r)
    if T(n)>=0:
        k=n-1
        W=d2(k,h,r)
        u=1-r*E(k+1,r)+(1-h)*T(k)/(2*a)
        v=-r*E(k+1,r)+(1+r)*T(k)/(2*a)
        branch='rho'
    else:
        k=max(j for j in range(n) if T(j)>=0)
        W=d2(k,h,r)
        u=h*E(k+1,h)-(1+h)*T(k)/(2*a)
        v=-1+h*E(k+1,h)-(1-r)*T(k)/(2*a)
        branch='eta'
    add(W,k,k+1,u)
    add(W,k+1,k,v)
    for i in range(k+1,n):
        u=h*E(i+1,h)
        add(W,i,i+1,u)
        add(W,i+1,i,u-1)
    return W,branch,k


def lift(W,n,h,r):
    # W is the original GD objective interpolation orientation.
    # f2's order is the transpose of that orientation.
    lam=defaultdict(Q,{(j,i):v for (i,j),v in W.items()})
    H=defaultdict(Q)
    for t in range(n+1):
        B=[Q(0) for _ in range(n+2)]
        for i in range(n+1):
            if i==t:continue
            q=lam[i,t]
            B[i]+=q
            B[t]-=q
            m=(lam[i,t]+lam[t,i])/(h-r)
            B[t+1]+=m
            B[i+1]-=m
            B[t]-=r*m
            B[i]+=r*m
        for i in range(n+2):
            if i!=t+1:
                H[i,t+1]=-B[i]
    return H


def run():
    tests=0
    failures=[]
    for hd in range(2,11):
        for hn in range(1,hd+1):
            h=Q(hn,hd)
            for rd in range(2,11):
                for rn in range(1,rd):
                    r=-Q(rn,rd)
                    if not(-h<r<-h/(1+h)):continue
                    for n in range(2,9):
                        W,b,k=convex_gd(n,h,r)
                        H=lift(W,n,h,r)
                        # Only the transition pair needs this modification;
                        # eta tails are supplied by the published local DCA
                        # inequality, not by a second full-cancellation lift.
                        if b=='eta':
                            W0=defaultdict(Q,{ij:v for ij,v in W.items()
                                  if max(ij)<=k+1})
                            H=lift(W0,k+1,h,r)
                            C=-r*r*(E(k+1,h)-E(k+1,r))/(h-r)**2
                            H[k,k+2]+=h*C
                            H[k,k+1]-=h*C
                            H[k+1,k+2]-=(1+h)*C
                            H[k+2,k+1]-=C
                        tests+=1
                        negative=[(ij,str(v)) for ij,v in H.items() if v<0]
                        if negative:
                            failures.append({'eta':str(h),'rho':str(r),'N':n,'branch':b,'k':k,'negative':negative})
                            if len(failures)>=5:return tests,failures
    return tests,failures


if __name__=='__main__':
    import json
    tests,failures=run()
    print(json.dumps({'exact_rational_tests':tests,'first_failures':failures},indent=2))
