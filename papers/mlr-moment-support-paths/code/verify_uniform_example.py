#!/usr/bin/env python3
"""Exact certificate for the explicit five-regime sharp rational-carrier example.

This checks a supplied proposed sequence without using any general path theorem.
The parameter p=z/(1+z) compactifies positive exponential tilt z.
"""
from functools import cmp_to_key
import hashlib
import json
import math
from pathlib import Path
import time
import sympy as sp

from algebra import compare,rational_between
from sweep import root_data,poly_data

p,x=sp.symbols("p x")
started=time.monotonic()
n,k=6,4
carrier=[10,12,15,20,30,60,60]
proposed=[(0,1,2,3),(0,1,3,4),(0,1,4,5),(1,2,4,5),(2,3,4,5)]
unnormalized=[sp.Poly(w*p**i*(1-p)**(n-i),p) for i,w in enumerate(carrier)]
Z=sum(unnormalized,sp.Poly(0,p))
assert all(w>0 for w in carrier)
assert [(n-i)*carrier[i] for i in range(n)]==[60]*n
# The normalized transformed carrier is uniform; its ratio to binomial
# coefficients is strictly log-convex, checked entirely with rational numbers.
h=[sp.Rational(1,math.comb(n-1,i)) for i in range(n)]
assert all(h[i]**2<h[i-1]*h[i+1] for i in range(1,n-1))
bound=(k//2)*(n-k)+1
assert len(proposed)==bound
left=sp.Rational(0)
regimes=[]
for index,J in enumerate(proposed):
    B=J+(n,)
    weights={}
    for j in B:
        cardinal=sp.prod((x-b)/sp.Integer(j-b) for b in B if b!=j)
        weights[j]=sum((unnormalized[i]*cardinal.subs(x,i) for i in range(n+1)),sp.Poly(0,p))
    roots=[r for j in J[::2] for r in weights[j].real_roots(radicals=False)
           if compare(left,r)<0 and compare(r,sp.Rational(1))<0]
    right=min(roots,key=cmp_to_key(compare),default=sp.Rational(1))
    sample=rational_between(left,right)
    # Exact signs on the entire open cell.
    for b in weights.values():
        assert b.eval(sample)>0
        assert not any(compare(left,r)<0 and compare(r,right)<0
                       for r in b.real_roots(radicals=False))
    # Full polynomial moment identities after multiplication by common Z>0.
    for power in range(k+1):
        lhs=sum((b*j**power for j,b in weights.items()),sp.Poly(0,p))
        rhs=sum((u*i**power for i,u in enumerate(unnormalized)),sp.Poly(0,p))
        assert (lhs-rhs).is_zero
    Q=sp.prod(x-j for j in J)
    dual=Q/Q.subs(x,n)
    assert all(dual.subs(x,i)>=int(i==n) for i in range(n+1))
    assert all(dual.subs(x,i)==int(i==n) for i in B)
    dual_value=sum((u*dual.subs(x,i) for i,u in enumerate(unnormalized)),sp.Poly(0,p))
    assert (dual_value-weights[n]).is_zero
    regimes.append({"index":index,"support":list(B),"paired_nodes":list(J),
                    "left":root_data(left),"right":root_data(right),"sample":str(sample),
                    "weight_numerators":{str(j):poly_data(b) for j,b in weights.items()},
                    "weight_common_denominator":poly_data(Z),
                    "objective_numerator":poly_data(weights[n])})
    left=right
assert left==1
result={"format":"sharp-uniform-transformed-carrier-v1", "n":n,"k":k,
        "original_carrier":carrier,"tilt":"mu_z(i) proportional to carrier_i*z^i, z>0",
        "compact_parameter":"p=z/(1+z)","transformed_carrier":[60]*n,
        "normalized_binomial_relative_carrier":[str(v) for v in h],
        "strict_relative_log_convexity_verified":True,"regime_bound":bound,
        "regime_count":len(regimes),"exact_certificate_passed":True,
        "coverage":"Every p in (0,1), equivalently every positive z; limits are endpoint point masses",
        "regimes":regimes,"seconds":round(time.monotonic()-started,6),
        "scope":"One explicit sharpness witness, not the proof of sharpness in all dimensions"}
target=Path(__file__).resolve().parents[1]/"results/uniform_example.json"
target.write_text(json.dumps(result,indent=2)+"\n")
print(json.dumps({key:value for key,value in result.items() if key!="regimes"}))
print(json.dumps({"sha256":hashlib.sha256(target.read_bytes()).hexdigest()}))
