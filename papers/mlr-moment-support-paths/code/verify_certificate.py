#!/usr/bin/env python3
"""Independently verify endpoint-binomial phase certificates.

No import from sweep.py and no reliance on the proposed pivot/path theorem.
Each open interval is certified by exact moment, positivity, and dual identities;
continuity proves its boundary values. Float LP checks are supplementary only.
"""
from __future__ import annotations

import argparse
from functools import lru_cache
import hashlib
import json
import math
from pathlib import Path
import time

import numpy as np
from scipy.optimize import linprog
import scipy
import sympy as sp
from algebra import compare

p,x = sp.symbols("p x")
if not __debug__:
    raise RuntimeError("Verification requires assertions; do not run Python with -O")


def poly(coefficients):
    return sp.Poly.from_list([sp.Rational(v) for v in coefficients], p, domain=sp.QQ)


@lru_cache(None)
def binomial_pmf(n):
    return tuple(sp.Poly(math.comb(n,i)*p**i*(1-p)**(n-i),p) for i in range(n+1))


def read_endpoint(data):
    if data["kind"] == "rational":
        return sp.Rational(data["value"])
    q=poly(data["polynomial"])
    if not q.is_irreducible:
        raise AssertionError("Endpoint polynomial is not irreducible")
    a,b=map(sp.Rational,data["isolating_interval"])
    if not (a < b and q.count_roots(a,b)==1):
        raise AssertionError("Invalid rational isolating interval")
    index=int(q.count_roots(-sp.oo,a))
    if index!=data["real_root_index"]:
        raise AssertionError("Inconsistent algebraic-root index")
    return sp.CRootOf(q,index)


def vanishes_at(polynomial, endpoint):
    if endpoint.is_Rational:
        return polynomial.eval(endpoint)==0
    minimal=sp.Poly.from_list(endpoint.poly.all_coeffs(),p,domain=sp.QQ)
    return polynomial.rem(minimal).is_zero


def verify(data, numerical=True):
    started=time.monotonic()
    n,k=data["n"],data["k"]
    assert 2 <= k < n
    cells=data["regimes"]
    assert len(cells)==data["regime_count"]
    assert data["regime_bound"]==(k//2)*(n-k)+1
    exact_checks=0
    numeric=[]
    previous_right=sp.Rational(0)
    for idx,cell in enumerate(cells):
        assert cell["index"]==idx
        left,right=read_endpoint(cell["left"]),read_endpoint(cell["right"])
        assert compare(left,previous_right)==0 and compare(left,right)<0
        sample=sp.Rational(cell["sample"])
        assert compare(left,sample)<0 and compare(sample,right)<0
        previous_right=right
        J=cell["paired_nodes"]
        assert J==sorted(set(J)) and len(J)==2*(k//2)
        assert all(J[t+1]==J[t]+1 for t in range(0,len(J),2))
        assert min(J)>=k%2 and max(J)<n
        B=cell["support"]
        assert B==(([0] if k%2 else [])+J+[n])
        assert len(B)==k+1
        beta={int(i):poly(c) for i,c in cell["weights"].items()}
        assert set(beta)==set(B)
        # Exact positivity on each entire open interval, not merely at the sample.
        for i,b in beta.items():
            assert b.degree()<=k and b.eval(sample)>0
            assert not any(compare(left,r)<0 and compare(r,right)<0
                           for r in b.real_roots(radicals=False))
            exact_checks+=1
        # Independent ordinary-moment identity from the full binomial pmf.
        pmf=binomial_pmf(n)
        for degree in range(k+1):
            lhs=sum((b*i**degree for i,b in beta.items()),sp.Poly(0,p))
            rhs=sum((pmf[i]*i**degree for i in range(n+1)),sp.Poly(0,p))
            assert (lhs-rhs).is_zero
            exact_checks+=1
        Q=sp.prod(x-j for j in J)
        dual=Q/Q.subs(x,n)
        if k%2:
            dual=x*dual/n
        dual=sp.Poly(dual,x)
        assert dual.degree()==k
        for i in range(n+1):
            assert dual.eval(i) >= int(i==n)
        for i in B:
            assert dual.eval(i) == int(i==n)
        expected_dual=sum((pmf[i]*dual.eval(i) for i in range(n+1)),sp.Poly(0,p))
        assert (expected_dual-beta[n]).is_zero
        assert (beta[n]-poly(cell["objective"])).is_zero
        exact_checks+=n+2
        # Reconstruct the Christoffel quadrature, using direct pmf summation.
        N=n-1-k%2
        assert {int(j) for j in cell["transformed_weights"]}==set(J)
        for j,coefficients in cell["transformed_weights"].items():
            j=int(j)
            cardinal=sp.prod((x-h)/sp.Integer(j-h) for h in J if h!=j)
            expectation=sum((binomial_pmf(N)[i]*cardinal.subs(x,i+k%2)
                             for i in range(N+1)),sp.Poly(0,p))
            assert (expectation-poly(coefficients)).is_zero
            exact_checks+=1
        if right!=1:
            quadrature={int(j):poly(v) for j,v in cell["transformed_weights"].items()}
            zero_nodes=[j for j in J if vanishes_at(quadrature[j],right)]
            assert zero_nodes==cell["departing_left_nodes"]
            assert all(j in J[::2] for j in zero_nodes)
            g=quadrature[zero_nodes[0]]
            for j in zero_nodes[1:]:
                g=sp.gcd(g,quadrature[j])
            g=g.clear_denoms()[1].primitive()[1]
            if g.LC()<0:
                g=-g
            assert (g-poly(cell["departure_gcd"])).is_zero and vanishes_at(g,right)
            # Check each claimed replacement and boundary matching without the path rule.
            newJ=set(cells[idx+1]["paired_nodes"])
            removed={a for a,b in cell["replacements"]}
            added={b for a,b in cell["replacements"]}
            assert set(J)-removed | added==newJ
            assert removed<=set(zero_nodes)
            exact_checks+=len(zero_nodes)+2
        else:
            assert cell["departure_gcd"] is None and cell["departing_left_nodes"]==[]
        if numerical:
            value=float(sample)
            A=np.array([[math.comb(i,r)/math.comb(n,r) if i>=r else 0.
                         for i in range(n+1)] for r in range(k+1)])
            target=np.array([value**r for r in range(k+1)])
            objective=np.zeros(n+1); objective[n]=-1.
            lp=linprog(objective,A_eq=A,b_eq=target,bounds=(0,None),method="highs",
                       options={"primal_feasibility_tolerance":1e-9,
                                "dual_feasibility_tolerance":1e-9})
            exact_objective=float(beta[n].eval(sample))
            difference=abs(-lp.fun-exact_objective) if lp.success else None
            residual=float(np.max(np.abs(A@lp.x-target))) if lp.success else None
            numerical_pass=bool(lp.success and difference<2e-7 and residual<2e-8)
            numeric.append({"regime":idx,"sample":str(sample),"lp_success":bool(lp.success),
                            "objective_absolute_error":difference,"moment_residual":residual,
                            "numerical_check_passed":numerical_pass})
    assert previous_right==1
    # Endpoints have degenerate binomial first moment and hence unique point masses.
    assert data["endpoint_optima"]["p=0"]["objective"]=="0"
    assert data["endpoint_optima"]["p=1"]["objective"]=="1"
    return {"n":n,"k":k,"exact_certificate_passed":True,
            "coverage":"All p in [0,1], via exact open-cell certificates and continuity",
            "regimes":len(cells),"exact_identity_and_sign_checks":exact_checks,
            "numerical_checks":numeric,
            "all_numerical_checks_passed":all(r["numerical_check_passed"] for r in numeric),
            "numeric_role":"Supplementary independent LP check; not proof and not certificate acceptance",
            "verifier_seconds":round(time.monotonic()-started,6),
            "versions":{"sympy":sp.__version__,"scipy":scipy.__version__}}


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("certificate")
    parser.add_argument("--output")
    parser.add_argument("--no-numerical",action="store_true")
    args=parser.parse_args()
    raw=Path(args.certificate).read_bytes()
    result=verify(json.loads(raw),not args.no_numerical)
    result["certificate_sha256"]=hashlib.sha256(raw).hexdigest()
    if args.output:
        Path(args.output).write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({k:v for k,v in result.items() if k!="numerical_checks"}))


if __name__=="__main__":
    main()
