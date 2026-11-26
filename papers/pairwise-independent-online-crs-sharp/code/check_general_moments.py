"""Exact certificates for selected higher-order moment-matched hard laws.

The node proposals are rational numbers near classical Laguerre nodes. No
floating-point library is used for verification: positive moment weights, rounded
integer supports and all factorial moments are checked with fractions. These
finite instances illustrate Theorem G; its all-fixed-orders claim is proved in
the manuscript, not by this finite list.
"""
from fractions import Fraction as F
from math import factorial, prod, isqrt
import hashlib
import json

NODES = {
 1:[275255,2724745],
 2:[190164,1784493,5525344],
 3:[145304,1339097,3926964,8588636],
 4:[117581,1074562,3085937,6414730,11807189],
 5:[98747,898303,2552590,5196153,9124248,15129960],
 6:[85115,772138,2180592,4389793,7554091,11989993,18528277],
}


def solve(matrix, rhs):
    n=len(rhs)
    a=[list(map(F,row))+[F(b)] for row,b in zip(matrix,rhs)]
    for j in range(n):
        pivot=next(i for i in range(j,n) if a[i][j])
        a[j],a[pivot]=a[pivot],a[j]
        v=a[j][j]
        a[j]=[x/v for x in a[j]]
        for i in range(n):
            if i==j: continue
            v=a[i][j]
            a[i]=[x-v*y for x,y in zip(a[i],a[j])]
    return [row[-1] for row in a]


def falling(n,j):
    return prod(n-a for a in range(j))


def even_block_counts(total, size=1):
    if size>total:
        yield ()
        return
    # Returned counts ell_s satisfy sum_s s*ell_s=total.
    def rec(s,remaining):
        if s>total:
            if remaining==0: yield ()
            return
        for c in range(remaining//s+1):
            for rest in rec(s+1,remaining-s*c):
                yield (c,)+rest
    yield from rec(1,total)


def centered_binomial_even(k,j):
    if j==0: return F(1)
    out=F(0)
    for counts in even_block_counts(j):
        ell=sum(counts)
        denom=4**j
        for s,c in enumerate(counts,1):
            denom*=factorial(c)*factorial(2*s)**c
        out+=F(falling(2*k,ell)*factorial(2*j),denom)
    return out


def ceil_sqrt_fraction(x):
    s=isqrt(x.numerator//x.denominator)
    if s*s*x.denominator<x.numerator: s+=1
    assert (s-1)**2<x<=s*s
    return s


def add(law,n,p):
    law[n]=law.get(n,F(0))+p


def order_constants(r):
    nodes=[F(n,10**6) for n in NODES[r]]
    A=[[z**j for z in nodes] for j in range(r+1)]
    nu=[F(factorial(2*j),4**j*factorial(j)) for j in range(r+1)]
    alpha=solve(A,nu)
    assert min(alpha)>0 and sum(alpha)==1
    tail_limit=[F(1)]+[F(0)]*(r-1)+[F(1)]
    direction=solve(A,tail_limit)
    w=min([F(1,4)]+[a/(4*(1+abs(b))) for a,b in zip(alpha,direction)])
    limiting=solve(A,[nu[j]-w*tail_limit[j] for j in range(r+1)])
    assert min(limiting)>0 and sum(limiting)==1-w
    return nodes,alpha,w


def certificate(r,m,k):
    assert m**(4*r+2)<=k<(m+1)**(4*r+2)
    a,b=m*m,m**(2*r+2)
    assert a<=k and b<=k and b*b<=a*k
    nodes,alpha,w=order_constants(r)
    s=[ceil_sqrt_fraction(k*z) for z in nodes]
    assert len(set(s))==r+1 and min(s)>0 and max(s)<=k
    A=[[F(x*x,k)**j for x in s] for j in range(r+1)]
    beta=[centered_binomial_even(k,j)/k**j for j in range(r+1)]
    tau=[F(1)]+[F(b*a**(2*j)+a*b**(2*j),(a+b)*k**j) for j in range(1,r+1)]
    lam=solve(A,[beta[j]-w*tau[j] for j in range(r+1)])
    assert min(lam)>0 and sum(lam)==1-w,(r,m,k,min(lam))
    law={}
    for center,weight in [(k-a,w*F(b,2*(a+b))),(k+b,w*F(a,2*(a+b))),
                          (k+a,w*F(b,2*(a+b))),(k-b,w*F(a,2*(a+b)))]:
        add(law,center,weight)
    for x,p in zip(s,lam):
        add(law,k-x,p/2); add(law,k+x,p/2)
    assert sum(law.values())==1 and min(law.values())>0
    assert min(law)>=0 and max(law)<=2*k
    checked=0
    for j in range(2*r+2):
        observed=sum((p*falling(n,j) for n,p in law.items()),F(0))
        target=F(falling(2*k,j),2**j)
        assert observed==target,('factorial',r,m,k,j)
        checked+=1
    lower=w*F(b,2*(k+b))
    assert lower>=w/F(6*m**(2*r))
    # The second inequality in G10 is exact after raising to integer powers.
    assert (lower/(w/6))**(2*r+1)*k**r>=1
    law_serial=json.dumps([[n,str(p)] for n,p in sorted(law.items())],separators=(',',':'))
    return {'independence_order':2*r+1,'r':r,'m':m,'rank':k,
      'count_layers':len(law),'factorial_moments_checked':checked,
      'minimum_component_weight_positive':True,
      'lower_bound_positive':True,'coarse_lower_inequality_exact':True,
      'law_sha256':hashlib.sha256(law_serial.encode()).hexdigest(),
      'exact_hard_component_weight':str(w/2),
      'exact_lower_loss':str(lower)}


if __name__=='__main__':
    tests=[]
    for r in NODES:
        for m in [1000,10000,1000000]:
            lo,hi=m**(4*r+2),(m+1)**(4*r+2)-1
            for k in [lo,(lo+hi)//2,hi]:
                tests.append(certificate(r,m,k))
    print(json.dumps({'status':'passed','arithmetic':'exact rational',
      'orders_checked':[3,5,7,9,11,13],
      'instance_count':len(tests),
      'factorial_moment_checks':sum(x['factorial_moments_checked'] for x in tests),
      'node_denominator':10**6,'node_numerators':NODES,
      'scope':'Finite exact certificates only; no all-r proof inferred from a finite test.',
      'instances':tests},indent=2))
