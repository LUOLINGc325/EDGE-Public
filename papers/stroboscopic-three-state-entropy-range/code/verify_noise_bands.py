#!/usr/bin/env python3
"""Primary finite-resolution checks. The general theorem is a written proof."""
from __future__ import annotations
import argparse
import json
import platform
from pathlib import Path
import mpmath as mp
import sympy as sp

ROOT = Path(__file__).resolve().parents[1]


def require(ok, message):
    if not ok:
        raise RuntimeError(message)


def G(a, b):
    return 2*b/mp.sqrt(3)*mp.log((a+mp.sqrt(3)*b)/(a-mp.sqrt(3)*b))


def gradient(a, b):
    den = a*a-3*b*b
    return (-4*b*b/den,
            2/mp.sqrt(3)*mp.log((a+mp.sqrt(3)*b)/(a-mp.sqrt(3)*b))
            +4*a*b/den)


def boundary_minimum(u, t, sign, epsilon):
    ell = mp.exp(-u*t)
    beta = (2 if sign > 0 else 1)*mp.pi
    r = epsilon/mp.sqrt(2)
    def obj(phi):
        z = ell+r*mp.exp(1j*phi)
        a = -mp.log(abs(z))/t
        b = (beta-mp.arg(z))/t
        return G(a, b)
    ga, gb = gradient(u, beta/t)
    guess = mp.atan2(gb, ga)
    phi = mp.findroot(lambda p: mp.diff(obj, p), (guess-mp.mpf(".08"),guess+mp.mpf(".08")))
    require(0 < phi < mp.pi, "Boundary stationary point outside upper semicircle")
    value = obj(phi)
    for j in range(257):
        require(value <= obj(mp.pi*j/256)+mp.mpf("1e-60"),
                "Stationary candidate loses to comparison grid")
    z = ell+r*mp.exp(1j*phi)
    return value, phi, -mp.log(abs(z))/t, (beta-mp.arg(z))/t


def homogeneous(a, b):
    p = mp.ones(3)/3
    h = mp.eye(3)-p
    c = mp.matrix([[0,1,-1],[-1,0,1],[1,-1,0]])
    return -a*h+b/mp.sqrt(3)*c


def entropy(q):
    return sum((q[i,j]-q[j,i])/3*mp.log(q[i,j]/q[j,i])
               for i in range(3) for j in range(i+1,3))


def frobenius(q):
    return mp.sqrt(sum(abs(v)**2 for v in q))


def symbolic():
    a,b=sp.symbols("a b",positive=True)
    f=2*b/sp.sqrt(3)*sp.log((a+sp.sqrt(3)*b)/(a-sp.sqrt(3)*b))
    ga=-4*b*b/(a*a-3*b*b)
    gb=2/sp.sqrt(3)*sp.log((a+sp.sqrt(3)*b)/(a-sp.sqrt(3)*b))+4*a*b/(a*a-3*b*b)
    require(sp.simplify(sp.diff(f,a)-ga)==0,"G_a identity")
    require(sp.simplify(sp.diff(f,b)-gb)==0,"G_b identity")
    v=sp.symbols("v",real=True)
    h=sp.eye(3)-sp.ones(3)/3
    c=sp.Matrix([[0,1,-1],[-1,0,1],[1,-1,0]])
    require(c*c==-3*h,"Cycle square")
    e=(sp.cos(v)-1)*h+sp.sin(v)*c/sp.sqrt(3)
    require(sp.trigsimp(sp.trace(e.T*e)-4*(1-sp.cos(v)))==0,"Exact distance identity")
    return {"identities":4,"passed":True}


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--output",type=Path,default=ROOT/"results"/"noise_primary_verification.json")
    args=parser.parse_args()
    mp.mp.dps=90
    cases=[]
    max_distance_error=mp.mpf(0)
    max_entropy_error=mp.mpf(0)
    count=0
    for sign, alpha in ((1,mp.mpf(12)),(-1,mp.mpf(6))):
        for t in (mp.mpf(".5"),mp.mpf(1),mp.mpf(2)):
            u=alpha/t; ell=mp.exp(-alpha); lam=sign*ell
            omega=(2 if sign>0 else 1)*mp.pi/t
            base=G(u,omega)
            ga,gb=gradient(u,omega)
            linear=mp.sqrt(ga*ga+gb*gb)/(mp.sqrt(2)*ell*t)
            quadratic=2/(u*ell*ell*t*t)
            rows=[]
            p0=mp.ones(3)/3+lam*(mp.eye(3)-mp.ones(3)/3)
            for ratio in map(mp.mpf,[".2",".1",".03",".01",".001",".0001",".00001",".000001"]):
                eps=ratio*ell; r=eps/mp.sqrt(2)
                require(eps<ell/2 and ell+r<mp.exp(-mp.sqrt(3)*omega*t),
                        "Base smallness assumption")
                m,phi,a,b=boundary_minimum(u,t,sign,eps)
                q=homogeneous(a,b)
                distance=frobenius(mp.expm(t*q)-p0)
                de=abs(distance-eps)/eps
                ee=abs(entropy(q)-m)
                max_distance_error=max(max_distance_error,de)
                max_entropy_error=max(max_entropy_error,ee)
                require(de<mp.mpf("1e-65") and ee<mp.mpf("1e-65"),"High endpoint realization")
                require(all(q[i,j]>0 for i in range(3) for j in range(3) if i!=j),
                        "High endpoint support")
                row={"epsilon_over_abs_lambda":str(ratio),
                     "epsilon":mp.nstr(eps,30),"high_minimum":mp.nstr(m,30),
                     "minimizing_phi":mp.nstr(phi,30),
                     "high_linear_slope_ratio":mp.nstr((base-m)/eps/linear,30)}
                # Direct path linking the minimizing observation to the center.
                zstar=ell+r*mp.exp(1j*phi)
                for s in map(mp.mpf,["0",".25",".5",".75","1"]):
                    z=ell+s*(zstar-ell)
                    qa=homogeneous(-mp.log(abs(z))/t,(omega*t-mp.arg(z))/t)
                    require(frobenius(mp.expm(t*qa)-p0)<=eps*(1+mp.mpf("1e-65")),
                            "Joining path leaves observation ball")
                    require(entropy(qa)>=m-mp.mpf("1e-65"),"Joining path violates lower bound")
                    count+=1
                if sign>0:
                    d=-mp.log(1-eps/ell)/t
                    require(d<u/3,"Principal positivity condition")
                    upper=2*d*d/(u-3*d)
                    c=2/(mp.sqrt(3)*t)*mp.asin(eps/(2*mp.sqrt(2)*ell))
                    qlow=homogeneous(u,mp.sqrt(3)*c)
                    low=entropy(qlow)
                    require(abs(frobenius(mp.expm(t*qlow)-p0)-eps)/eps<mp.mpf("1e-65"),
                            "Low endpoint witness distance")
                    aminus=-mp.log(ell-r)/t
                    bminus=(2*mp.pi-mp.asin(r/ell))/t
                    lower_high=G(aminus,bminus)
                    require(low<=upper and upper<lower_high<=m,"Certified gap condition")
                    row.update({"low_witness":mp.nstr(low,30),"low_upper_bound":mp.nstr(upper,30),
                                "high_safe_lower_bound":mp.nstr(lower_high,30),
                                "low_witness_coefficient_ratio":mp.nstr(low/(eps*eps)/quadratic,30),
                                "low_upper_coefficient_ratio":mp.nstr(upper/(eps*eps)/quadratic,30)})
                rows.append(row)
                count+=1
            final=rows[-1]
            require(abs(mp.mpf(final["high_linear_slope_ratio"])-1)<mp.mpf("1e-5"),
                    "High linear coefficient convergence")
            if sign>0:
                require(abs(mp.mpf(final["low_witness_coefficient_ratio"])-1)<mp.mpf("1e-10"),
                        "Low witness coefficient convergence")
                require(abs(mp.mpf(final["low_upper_coefficient_ratio"])-1)<mp.mpf("1e-5"),
                        "Low upper coefficient convergence")
            cases.append({"sign":sign,"u":str(u),"t":str(t),"lambda":mp.nstr(lam,30),
                          "G_at_center":mp.nstr(base,30),"high_linear_coefficient":mp.nstr(linear,30),
                          "low_quadratic_coefficient_if_positive":mp.nstr(quadratic,30) if sign>0 else None,
                          "rows":rows})
    result={"status":"PASS","decimal_precision":mp.mp.dps,
            "environment":{"python":platform.python_version(),"mpmath":mp.__version__,"sympy":sp.__version__},
            "symbolic":symbolic(),"direct_endpoint_and_join_matrices_checked":count,
            "additional_low_witness_matrices_checked":24,
            "max_high_relative_distance_error":mp.nstr(max_distance_error,20),
            "max_high_entropy_error":mp.nstr(max_entropy_error,20),
            "numerical_minimization_scope":"Stationary candidate checked against 257 semicircle points; not an interval-certified global numerical optimization. The exact variational formula and full-set theorem are proved in writing.",
            "M_epsilon_scope":"M is not computed exactly: the file records proved lower witnesses and upper bounds and checks their common leading coefficient.",
            "cases":cases}
    args.output.parent.mkdir(exist_ok=True,parents=True)
    args.output.write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({k:v for k,v in result.items() if k!="cases"},indent=2))


if __name__=="__main__":
    main()
