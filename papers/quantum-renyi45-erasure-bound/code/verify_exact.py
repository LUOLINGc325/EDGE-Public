#!/usr/bin/env python3
"""Exact cyclic-word identities and Gaussian-integer matrix cross-checks.

Standard library only. Finite checks do not prove positivity in all dimensions;
that proof is in the manuscript. No assertions are used, so -O is safe.
"""
from __future__ import annotations
from collections import defaultdict
from fractions import Fraction as F
from itertools import product
from pathlib import Path
import argparse
import json
import random


def require(ok, message):
    if not ok:
        raise RuntimeError(message)


def poly_add(*polys):
    out = defaultdict(F)
    for p in polys:
        for w, c in p.items():
            out[w] += c
    return {w: c for w, c in out.items() if c}


def scale(p, c):
    return {w: c * v for w, v in p.items() if c * v}


def pmul(p, q):
    out = defaultdict(F)
    for u, a in p.items():
        for v, b in q.items():
            out[u + v] += a * b
    return {w: c for w, c in out.items() if c}


def power(p, n):
    q = {"": F(1)}
    for _ in range(n):
        q = pmul(q, p)
    return q


def cyclic(p):
    out = defaultdict(F)
    for w, c in p.items():
        key = min(w[j:] + w[:j] for j in range(len(w))) if w else w
        out[key] += c
    return {w: c for w, c in out.items() if c}


def pword(w, substitutions):
    q = {"": F(1)}
    for c in w:
        q = pmul(q, substitutions[c])
    return q


def adjoint(p):
    return {w[::-1]: c for w, c in p.items()}


def symbolic_checks():
    plus = {"S": F(1), "D": F(1)}
    minus = {"S": F(1), "D": F(-1)}
    comm = {"SD": F(1), "DS": F(-1)}
    checks = []
    for k, a, b, c, weights in (
        (4, "SSDD", "SDSD", "DDDD", (4, 2, 1)),
        (5, "SSSDD", "SSDSD", "SDDDD", (5, 5, 5)),
    ):
        lhs = scale(poly_add(power(plus, k), power(minus, k)), F(1, 2**k))
        rhs = {"S"*k: F(1, 2**(k-1)), a: F(weights[0], 2**(k-1)),
               b: F(weights[1], 2**(k-1)), c: F(weights[2], 2**(k-1))}
        require(not cyclic(poly_add(lhs, scale(rhs, -1))), f"order-{k} trace expansion")
        checks.append(f"order_{k}_trace_expansion")
    norm = pmul(adjoint(comm), comm)
    require(not cyclic(poly_add({"SSDD": F(1), "SDSD": F(-1)}, scale(norm, F(-1, 2)))), "quartic commutator")
    checks.append("quartic_commutator_identity")
    require(not cyclic(poly_add({"SSSDD": F(1), "SSDSD": F(-1)}, scale(pmul({"S":F(1)}, norm), -1))), "quintic commutator")
    checks.append("quintic_commutator_identity")
    congruence = pword("DMDP", {"D":{"D":F(1)}, "M":minus, "P":plus})
    require(not cyclic(poly_add(congruence, {"SDSD": F(-1), "DDDD": F(1)})), "quartic positive congruence")
    checks.append("quartic_positive_congruence_identity")
    substitutions = {"S":{"U":F(1,2),"V":F(1,2)}, "D":{"U":F(1,2),"V":F(-1,2)}}
    lhs = poly_add(pword("SSDSD", substitutions), scale(pword("SDDDD", substitutions), -1))
    rhs = {"UUUUV":F(1,8), "UVVVV":F(1,8), "UUUVV":F(-1,8), "UUVVV":F(-1,8)}
    require(not cyclic(poly_add(lhs, scale(rhs, -1))), "quintic two-basis identity")
    checks.append("quintic_two_basis_identity")
    # Commuting scalar covariance identity: each x_j y_k coefficient is checked.
    for weights in ((4,2,1),(5,5,5)):
        wsum = sum(weights)
        lhs = {(j,k): (wsum*weights[j] if j==k else 0)-weights[j]*weights[k]
               for j in range(3) for k in range(3)}
        rhs = defaultdict(int)
        for j in range(3):
            for k in range(j+1,3):
                v=weights[j]*weights[k]
                rhs[j,j]+=v; rhs[k,k]+=v; rhs[j,k]-=v; rhs[k,j]-=v
        require(all(lhs[z]==rhs[z] for z in lhs), "weighted covariance")
        checks.append("weighted_covariance_"+"_".join(map(str, weights)))
    return checks


# Gaussian integers (real, imaginary), so matrix products stay exact integers.
def zadd(a,b): return (a[0]+b[0], a[1]+b[1])
def zneg(a): return (-a[0],-a[1])
def zmul(a,b): return (a[0]*b[0]-a[1]*b[1],a[0]*b[1]+a[1]*b[0])
def zconj(a): return (a[0],-a[1])
Z=(0,0)
O=(1,0)


def mmul(a,b):
    n,m,r=len(a),len(b[0]),len(b)
    out=[[Z for _ in range(m)] for _ in range(n)]
    for i in range(n):
        for k in range(r):
            if a[i][k] == Z: continue
            for j in range(m):
                out[i][j]=zadd(out[i][j],zmul(a[i][k],b[k][j]))
    return out


def madd(a,b): return [[zadd(x,y) for x,y in zip(u,v)] for u,v in zip(a,b)]
def mneg(a): return [[zneg(x) for x in u] for u in a]
def dagger(a): return [[zconj(a[j][i]) for j in range(len(a))] for i in range(len(a[0]))]
def eye(n): return [[O if i==j else Z for j in range(n)] for i in range(n)]
def mpow(a,n):
    out=eye(len(a))
    for _ in range(n): out=mmul(out,a)
    return out
def trace(a):
    z=Z
    for i in range(len(a)): z=zadd(z,a[i][i])
    require(z[1]==0,"trace unexpectedly nonreal")
    return z[0]
def kron(a,b):
    return [[zmul(a[i][j],b[k][l]) for j in range(len(a[0])) for l in range(len(b[0]))]
            for i in range(len(a)) for k in range(len(b))]
def diag(vals): return [[(int(vals[i]),0) if i==j else Z for j in range(len(vals))] for i in range(len(vals))]
def gram(rng,n,r):
    a=[[(rng.randint(-2,2),rng.randint(-2,2)) for _ in range(r)] for _ in range(n)]
    return mmul(a,dagger(a))


def invariants(u,v,k):
    s=madd(u,v); d=madd(u,mneg(v)); total=trace(mpow(s,k))
    require(total>0,"zero total")
    a=F(trace(mmul(mpow(s,k-2),mpow(d,2))),total)
    b=F(trace(mmul(mmul(mmul(mpow(s,k-3),d),s),d)),total)
    c=F(trace(mmul(mpow(s,k-4),mpow(d,4))),total)
    q=F(trace(mpow(u,k))+trace(mpow(v,k)),total)
    weights=(4,2,1) if k==4 else (5,5,5)
    require(a>=b>=c>=0,"moment ordering")
    require(F(1,2**(k-1))<=q<=1,"entropy range")
    require(q==F(1,2**(k-1))*(1+sum(w*x for w,x in zip(weights,(a,b,c)))),"moment expansion")
    return (a,b,c,q)


def check_pair(first,second,k):
    u1,v1=first;u2,v2=second
    a1,b1,c1,q1=invariants(u1,v1,k);a2,b2,c2,q2=invariants(u2,v2,k)
    uo=madd(kron(u1,u2),kron(v1,v2));vo=madd(kron(u1,v2),kron(v1,u2))
    ao,bo,co,qo=invariants(uo,vo,k)
    require((ao,bo,co)==(a1*a2,b1*b2,c1*c2),"tensor moments")
    delta=F(1,2**(k-1)); bound=delta+(q1-delta)*(q2-delta)/(1-delta)
    weights=(4,2,1) if k==4 else (5,5,5)
    x=(a1,b1,c1);y=(a2,b2,c2)
    gap=sum(F(weights[j]*weights[l],2**(k-1)*sum(weights))*(x[j]-x[l])*(y[j]-y[l])
            for j in range(3) for l in range(j+1,3))
    require(qo-bound==gap>=0,"BEC gap identity")
    erasure1=(a1==b1==c1);erasure2=(a2==b2==c2)
    require((gap==0)==(erasure1 or erasure2),"equality criterion")
    return gap==0


def main():
    parser=argparse.ArgumentParser();parser.add_argument("--output",type=Path)
    args=parser.parse_args();rng=random.Random(20261124)
    symbolic=symbolic_checks()
    cases=[]
    for n in range(1,5):
        for j in range(12):
            r=1+j%n
            cases.append((gram(rng,n,r),gram(rng,n,(j+1)%n+1)))
    # Endpoint, erasure, commuting non-erasure, and a noncommuting rank-one pair.
    cases.extend([
        (diag([1,0,2]),diag([0,1,2])),
        (diag([3,2]),diag([3,2])),
        (diag([3,0]),diag([0,4])),
        (diag([1,2]),diag([2,1])),
        (diag([1,0]),[[(1,0),(0,-1)],[(0,1),(1,0)]]),
        (diag([1,0,0]),diag([0,0,0])),
    ])
    records={}
    for k in (4,5):
        for uv in cases: invariants(*uv,k)
        pairs=[(cases[i],cases[(7*i+11)%len(cases)]) for i in range(len(cases))]
        pairs += [(cases[-6],cases[i]) for i in range(len(cases))]
        pairs += [(cases[i],cases[j]) for i in range(len(cases)-6,len(cases)) for j in range(len(cases)-6,len(cases))]
        zeros=sum(check_pair(x,y,k) for x,y in pairs)
        # Three-input formula uses fresh direct tensor output, beyond two-input testing.
        triple_count=0
        for i,j,l in ((0,12,24),(1,13,25),(2,14,26),(48,51,52),(49,51,52)):
            u,v=cases[i];ua,va=cases[j]
            uu=madd(kron(u,ua),kron(v,va));vv=madd(kron(u,va),kron(v,ua))
            check_pair((uu,vv),cases[l],k)
            ul,vl=cases[l]
            final_u=madd(kron(uu,ul),kron(vv,vl))
            final_v=madd(kron(uu,vl),kron(vv,ul))
            final_q=invariants(final_u,final_v,k)[3]
            rows=[invariants(*cases[z],k) for z in (i,j,l)]
            delta=F(1,2**(k-1));product_kappa=F(1)
            for row in rows: product_kappa *= (row[3]-delta)/(1-delta)
            bound=delta+(1-delta)*product_kappa
            require(final_q>=bound,"three-input full bound")
            equality=any(row[0]==0 for row in rows) or sum(row[0]!=row[2] for row in rows)<=1
            require((final_q==bound)==equality,"three-input equality classification")
            triple_count+=1
        witness=([[(2,0),(1,0)],[(1,0),(1,0)]],
                 [[(2,0),(-1,0)],[(-1,0),(1,0)]])
        a,b,c,q=invariants(*witness,k)
        expected=(F(5,17),F(4,17),F(2,17),F(47,136)) if k==4 else (F(3,11),F(2,11),F(1,11),F(41,176))
        require((a,b,c,q)==expected,"named noncommutative input")
        check_pair(witness,witness,k)
        wu,wv=witness
        qo=invariants(madd(kron(wu,wu),kron(wv,wv)),madd(kron(wu,wv),kron(wv,wu)),k)[3]
        delta=F(1,2**(k-1));gap=qo-delta-(q-delta)**2/(1-delta)
        require(qo==(F(425,2312) if k==4 else F(191,1936)),"named XOR output")
        require(gap==(F(13,4046) if k==4 else F(5,968)),"named strict gap")
        records[str(k)]={"single_matrix_pairs":len(cases),"dense_xor_pairs":len(pairs),
                         "equality_pairs":zeros,"strict_pairs":len(pairs)-zeros,
                         "three_input_checks":triple_count,"largest_single_dimension":4,
                         "largest_two_input_dimension":16,
                         "named_noncommutative_witness":{"invariants":[str(a),str(b),str(c)],
                            "input_K":str(q),"output_K":str(qo),"gap":str(gap)}}
    report={"status":"pass","arithmetic":"Gaussian integers and exact rational scalars",
            "seed":20261124,"symbolic_identity_count":len(symbolic),"symbolic_identities":symbolic,
            "orders":records,
            "coverage":"Universal formal cyclic-word equalities plus the listed finite PSD matrix checks. Positivity and all-dimensional entropy theorems rely on the written proof; no proof-assistant certification is claimed."}
    output=json.dumps(report,ensure_ascii=False,indent=2)+"\n"
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True);args.output.write_text(output)
    print(output,end="")


if __name__=="__main__": main()
