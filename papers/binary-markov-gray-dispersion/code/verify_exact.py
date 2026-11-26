#!/usr/bin/env python3
"""Exact finite checks of the analytic constructions; not a proof for all n."""
from fractions import Fraction as F
from math import comb
import json
from pathlib import Path

def matrices(rho, root, noise):
    g = root / (1 - 2 * noise)
    a, b, c = (1 + rho + 2*g)/4, (1-rho)/4, (1+rho-2*g)/4
    return (((a,b),(b,c)), ((c,b),(b,a)))

def matvec(A,v):
    return tuple(sum(A[i][j]*v[j] for j in range(2)) for i in range(2))

def word_mass(C,word,n):
    v=(F(1,2),F(1,2))
    for i in range(n):
        v=matvec(C[(word>>i)&1],v)
    return sum(v)

def noise_convolution(masses,q,n):
    out=list(masses)
    for bit in range(n):
        step=1<<bit
        for base in range(0,1<<n,step*2):
            for off in range(step):
                i=base+off;j=i+step;a,b=out[i],out[j]
                out[i]=(1-q)*a+q*b
                out[j]=q*a+(1-q)*b
    return out

def markov_mass(p,word,n):
    if not n:return F(1)
    k=sum(((word>>i)^(word>>(i-1)))&1 for i in range(1,n))
    return F(1,2)*p**k*(1-p)**(n-1-k)

def main():
    p,D,d0=F(4,9),F(1,10),F(9,50)
    rho,root=1-2*p,F(1,3)
    assert root**2==rho
    critical=(1-2*root/(1+rho))/2
    assert 0<D<d0<critical
    t=(d0-D)/(1-2*D)
    assert t+D-2*t*D==d0
    q0,q1=t*D/(1-d0),(1-t)*D/d0
    assert q0==F(1,82) and q1==F(1,2)
    CR,CQ=matrices(rho,root,d0),matrices(rho,root,D)
    assert all(x>0 for C in (CR,CQ) for A in C for row in A for x in row)
    for C in (CR,CQ):
        assert all(sum(C[y][j][i] for y in range(2) for j in range(2))==1 for i in range(2))
    nchecks=[]
    for n in range(1,11):
        R=[word_mass(CR,x,n) for x in range(1<<n)]
        Q=[word_mass(CQ,x,n) for x in range(1<<n)]
        P=[markov_mass(p,x,n) for x in range(1<<n)]
        assert sum(R)==sum(Q)==sum(P)==1
        assert noise_convolution(R,d0,n)==P
        assert noise_convolution(R,t,n)==Q
        assert noise_convolution(Q,D,n)==P
        nchecks.append({'n':n,'words':1<<n,'all_three_convolutions_exact':True})
    # Check the conditional product law pointwise for all x,z,e at n=4.
    n=4;posterior_checks=0
    for z in range(1<<n):
        for x in range(1<<n):
            delta=z^x;k=delta.bit_count()
            denom=d0**k*(1-d0)**(n-k)
            total=F(0)
            for e in range(1<<n):
                a=delta^e;ke,ka=e.bit_count(),a.bit_count()
                actual=D**ke*(1-D)**(n-ke)*t**ka*(1-t)**(n-ka)/denom
                predicted=F(1)
                for i in range(n):
                    q=q1 if (delta>>i)&1 else q0
                    predicted*=q if (e>>i)&1 else 1-q
                assert actual==predicted
                total+=actual;posterior_checks+=1
            assert total==1
    # The type probability at its own empirical parameter is a mode.
    type_checks=0
    for m in range(1,65):
        for k in range(m+1):
            r=F(k,m)
            pk=comb(m,k)*r**k*(1-r)**(m-k)
            assert pk>=F(1,m+1)
            for j in range(m+1):
                assert pk>=comb(m,j)*r**j*(1-r)**(m-j)
            type_checks+=1
    result={'arithmetic':'Python fractions.Fraction; exact rational equalities',
      'parameters':{'p':str(p),'D':str(D),'d0':str(d0),'Dc':str(critical),'t':str(t),'q0':str(q0),'q1':str(q1)},
      'R_matrix_0':[[str(x) for x in row] for row in CR[0]],
      'Q_matrix_0':[[str(x) for x in row] for row in CQ[0]],
      'block_checks':nchecks,'conditional_product_entries':posterior_checks,
      'binomial_mode_cases':type_checks,'status':'passed',
      'scope':'Finite exact checks support the implementation and algebra; universal results rest on the manuscript proof. No Lean claim.'}
    path=Path(__file__).resolve().parents[1]/'results'/'exact_checks.json'
    path.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))

if __name__=='__main__':main()
