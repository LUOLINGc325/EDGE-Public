#!/usr/bin/env python3
"""Finite numerical checks for the finite-threshold Gaussian sphere kernel.

This is numerical reproduction code, not a formal proof.  The primary finite-degree
calculation uses weighted polynomial quadrature, not the proposed asymptotic law.
Run from any directory: python path/to/code/reproduce.py
"""
from __future__ import annotations

import json
import math
import platform
import warnings
from functools import lru_cache
from pathlib import Path

import mpmath as mp
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import scipy
from scipy.integrate import IntegrationWarning, quad
from scipy.special import eval_jacobi, gamma, gammaln, roots_jacobi

ROOT = Path(__file__).resolve().parents[1]


def chi_density(r: float, nu: float) -> float:
    if r <= 0:
        return 0.0
    return math.exp((1 - nu / 2) * math.log(2) - gammaln(nu / 2)
                    + (nu - 1) * math.log(r) - r * r / 2)


@lru_cache(maxsize=None)
def jacobi_rule(n: int, left: float, right: float):
    return roots_jacobi(n, left, right)


def normalized_zonal(l: int, t, d: int):
    beta = (d - 3) / 2
    at_one = math.exp(gammaln(l + beta + 1) - gammaln(beta + 1)
                       - gammaln(l + 1))
    return eval_jacobi(l, beta, beta, t) / at_one


def ridge_quadrature(l: int, r: float, c: float, p: float, d: int,
                     multiplier: int = 1) -> float:
    """Direct weighted Jacobi quadrature of the normalized ridge integral.

    In d=3 and |c|<r, the only non-polynomial factor is absorbed into
    the Gaussian quadrature weight; degree-l polynomial integration is exact
    in exact arithmetic.  Exterior smooth thresholds use a larger full rule.
    """
    if r <= 0:
        return 0.0 if l else max(c, 0.0) ** p
    if c <= -r:
        return 0.0
    beta = (d - 3) / 2
    cd = math.exp(gammaln(d / 2) - .5 * math.log(math.pi)
                  - gammaln((d - 1) / 2))
    if c >= r:
        if p == int(p) and l > p:
            return 0.0
        n = multiplier * max(48, l + 24)
        x, w = jacobi_rule(n, beta, beta)
        return float(cd * np.dot(w, (r * x + c) ** p * normalized_zonal(l, x, d)))
    a = -c / r
    n = multiplier * max(40, (l + 2) // 2 + 8)
    x, w = jacobi_rule(n, beta, p)
    u = (x + 1) / 2
    t = a + (1 - a) * u
    # t-a is handled by the right exponent p of the quadrature measure.
    smooth = (1 + t) ** beta * normalized_zonal(l, t, d)
    prefactor = cd * r ** p * (1 - a) ** (p + beta + 1) / 2 ** (p + beta + 1)
    return float(prefactor * np.dot(w, smooth))


def ridge_circle_step(l: int, r: float, c: float) -> float:
    if r <= abs(c):
        return 0.0
    return math.sin(l * math.acos(-c / r)) / (math.pi * l)


def leading_A(p: float, d: int) -> float:
    return math.exp((d + p - 3) * math.log(2) + gammaln(d / 2)
                    + 2 * gammaln(p + 1) + gammaln(p + d / 2)
                    - 2 * math.log(math.pi))


def fixed_limit(p: float, d: int, cs, coeffs, l: int) -> float:
    merged = {}
    for c, a in zip(cs, coeffs):
        merged[c] = merged.get(c, 0.0) + a
    S = sum(a*a*math.exp(-c*c/2) for c, a in merged.items())
    T = sum(a*merged.get(-c, 0.0)*math.exp(-c*c/2) for c, a in merged.items())
    return leading_A(p, d) * (S - (-1)**l * math.cos(math.pi*p) * T)


def scaled_eigenvalue(l: int, p: float, d: int, cs, coeffs,
                     multiplier: int = 1):
    s = d + 2 * p
    def integrand(r):
        if d == 2 and p == 0:
            h = sum(a * ridge_circle_step(l, r, c) for c, a in zip(cs, coeffs))
        else:
            h = sum(a * ridge_quadrature(l, r, c, p, d, multiplier)
                    for c, a in zip(cs, coeffs))
        return l**s * h*h * chi_density(r, d)
    bounds = [0.0] + sorted(set(abs(c) for c in cs if c != 0)) + [math.inf]
    value = error = 0.0
    for left, right in zip(bounds[:-1], bounds[1:]):
        v, e = quad(integrand, left, right, epsabs=2e-10, epsrel=2e-9, limit=800)
        value += v
        error += e
    return {"scaled_value": value, "eigenvalue": value/l**s,
            "radial_quadrature_error_estimate": error}


@lru_cache(maxsize=None)
def inverse_chi_characteristic(nu: float, omega: float):
    if omega == 0:
        return (1.0, 0.0, 0.0)
    sign = 1 if omega > 0 else -1
    omega = abs(omega)
    lognorm = (1 - nu/2)*math.log(2) - gammaln(nu/2)
    def density(u):
        if u <= 0:
            return 0.0
        exponent = lognorm - (nu+1)*math.log(u) - 1/(2*u*u)
        return math.exp(exponent) if exponent > -745 else 0.0
    co, ec = quad(density, 0, math.inf, weight="cos", wvar=omega,
                  epsabs=5e-11, limlst=200, limit=300)
    si, es = quad(density, 0, math.inf, weight="sin", wvar=omega,
                  epsabs=5e-11, limlst=200, limit=300)
    return co, sign*si, ec+es


def crossover_matrix(p: float, d: int, taus, parity: int):
    n = len(taus)
    matrix = np.zeros((n, n))
    max_error = 0.0
    for i in range(n):
        for j in range(n):
            cm, _, em = inverse_chi_characteristic(d+2*p, float(taus[i]-taus[j]))
            cp, sp, ep = inverse_chi_characteristic(d+2*p, float(taus[i]+taus[j]))
            matrix[i,j] = cm - parity*(math.cos(math.pi*p)*cp + math.sin(math.pi*p)*sp)
            max_error = max(max_error, em+ep)
    return matrix, max_error


def exact_cap_mp(l: int, r: float, c: float, p: float, d: int):
    alpha = mp.mpf(d-2)/2
    q = mp.mpf(str(p)) + alpha
    theta = mp.acos(-mp.mpf(str(c))/mp.mpf(str(r)))
    factor = 2**alpha * mp.gamma(mp.mpf(d)/2)*mp.gamma(mp.mpf(str(p))+1)
    factor /= mp.pi * mp.gamma(q+1)
    return factor * mp.mpf(str(r))**mp.mpf(str(p)) * mp.quad(
        lambda t: mp.power(max(mp.mpf(0), mp.cos(t)-mp.cos(theta)), q)
        * mp.cos((l+alpha)*t), [0, theta])


def exterior_mpmath(l: int, v: float, p: float, d: int):
    pp, vv = mp.mpf(str(p)), mp.mpf(str(v))
    if d == 2:
        return mp.quad(lambda t: mp.power(1+vv*mp.cos(t),pp)*mp.cos(l*t),
                       [0,mp.pi/2,mp.pi])/mp.pi
    beta=mp.mpf(d-3)/2
    norm=mp.gamma(mp.mpf(d)/2)/(mp.sqrt(mp.pi)*mp.gamma(mp.mpf(d-1)/2))
    return norm*mp.quad(lambda t: mp.power(1+vv*t,pp)*mp.power(1-t*t,beta)
                       *mp.jacobi(l,beta,beta,t)/mp.binomial(l+beta,l),[-1,0,1])


def make_figure(report):
    """A finite-degree illustration; no curve fitting or claimed proof."""
    (ROOT/"figures").mkdir(parents=True, exist_ok=True)
    plt.rcParams.update({"font.size":10,"axes.spines.top":False,
                         "axes.spines.right":False,"svg.fonttype":"none",
                         "svg.hashsalt":"finite-threshold-reproduction"})
    fig,axes=plt.subplots(1,2,figsize=(10,3.7),constrained_layout=True)
    cases=[report["fixed_threshold_sequences"][2],
           report["coalescing_threshold_sequences"][0]]
    titles=["Fixed opposite thresholds", "Three coalescing thresholds"]
    for ax,case,title in zip(axes,cases,titles):
        for parity,color,marker,label in [(0,"#285C9E","o","Even degree"),
                                          (1,"#B9542D","s","Odd degree")]:
            rows=[x for x in case["rows"] if x["l"]%2==parity]
            ax.plot([1/x["l"] for x in rows],[x["scaled_value"] for x in rows],
                    color=color,marker=marker,label=label,linewidth=1.5)
            ax.axhline(rows[0]["limit"],color=color,linestyle="--",linewidth=1)
        ax.set_title(title+"\n"+r"$d=3,\ p=0.35$")
        ax.set_xlabel(r"$1/\ell$")
        ax.set_ylabel(r"$\ell^{d+2p}\mu_\ell$")
        ax.set_xlim(0,.045)
        ax.grid(alpha=.18)
        ax.legend(frameon=False,loc="center right")
    fig.savefig(ROOT/"figures"/"spectral_transition_checks.svg",
                metadata={"Date":None,"Description":"Finite-degree numerical checks. Dashed lines are the analytic limits."})
    fig.savefig(ROOT/"figures"/"spectral_transition_checks.png",dpi=180)
    plt.close(fig)


def main():
    (ROOT / "results").mkdir(parents=True, exist_ok=True)
    report = {
        "kind": "finite_numerical_checks_not_proof",
        "model": "Probability measure on S^(d-1), w~N(0,I_d); multiplicity is not included in mu_l.",
        "versions": {"python": platform.python_version(), "numpy": np.__version__,
                     "scipy": scipy.__version__, "mpmath": mp.__version__,
                     "matplotlib":matplotlib.__version__},
        "settings": {"radial_epsabs": 2e-10, "radial_epsrel": 2e-9,
                     "quadrature_orders": "cap max(40,ceil((l+1)/2)+8); exterior max(48,l+24)",
                     "independent_cap_precision_digits": 60},
        "warnings": [],
    }
    with warnings.catch_warnings(record=True) as caught:
        warnings.simplefilter("always", IntegrationWarning)
        mp.mp.dps = 60
        cap_rows = []
        for l,r,c,p,d in [(2,1.4,0,1,3),(7,1.2,.3,.35,3),
                           (8,2.0,-.6,.75,4),(9,1.3,.4,0,2),
                           (10,1.0,.2,.4,2)]:
            direct = ridge_quadrature(l,r,c,p,d,4)
            cap = float(exact_cap_mp(l,r,c,p,d))
            cap_rows.append({"l":l,"r":r,"c":c,"p":p,"d":d,
                             "direct_ridge":direct,"cap_integral":cap,
                             "absolute_difference":abs(direct-cap)})
        report["exact_cap_crosschecks"] = cap_rows

        exterior=[]
        for p,d,l in [(.3,2,6),(.3,3,7),(1.4,2,7),(1.4,3,8)]:
            pp=mp.mpf(str(p)); b=mp.mpf(d-1)/2
            endpoint=2**pp*mp.beta(pp+b,b)/mp.beta(b,b)
            endpoint*=(-1)**l*mp.rf(-pp,l)/mp.rf(pp+d-1,l)
            points=[0.,.25,.5,.75,1.]
            mpvalues=[exterior_mpmath(l,v,p,d) for v in points]
            values=[{"v":v,"coefficient":float(z),"coefficient_decimal":mp.nstr(z,55)}
                    for v,z in zip(points,mpvalues)]
            magnitudes=[abs(x["coefficient"]) for x in values]
            exterior.append({"p":p,"d":d,"l":l,"values":values,
                "pochhammer_endpoint":float(endpoint),
                "endpoint_absolute_difference":float(abs(mpvalues[-1]-endpoint)),
                "sampled_absolute_monotonicity":all(a<=b+1e-40 for a,b in zip(magnitudes[:-1],magnitudes[1:]))})
        report["exterior_threshold_checks"] = exterior

        low = scaled_eigenvalue(2,1,3,[0],[1])
        report["normalization"] = {"case":"d=3,p=1,c=0,l=2",
            "quadrature_eigenvalue":low["eigenvalue"],"exact_eigenvalue":3/256,
            "absolute_difference":abs(low["eigenvalue"]-3/256),
            "direct_ridge_at_r1":ridge_quadrature(2,1,0,1,3),"exact_ridge_at_r1":1/16}

        zeros=[]
        for l in [3,5,9,17]:
            for c in [0.0,.4]:
                cs, aa = ([0],[1]) if c==0 else ([c,-c],[1,1])
                h = sum(a*ridge_quadrature(l,1.7,b,1,3,2) for a,b in zip(aa,cs))
                zeros.append({"l":l,"cs":cs,"coefficients":aa,
                              "ridge_residual_r1_7":h})
        report["integer_polynomial_parity_residuals"] = zeros

        fixed=[]
        cases=[("circle_step_shift",0.,2,[.7],[1.]),
               ("fractional_shift",.35,3,[.6],[1.]),
               ("fractional_opposite_thresholds",.35,3,[.6,-.6],[1.,.7]),
               ("fractional_zero",.35,3,[0.],[1.])]
        for name,p,d,cs,aa in cases:
            rows=[]
            for l in [24,25,48,49,96,97]:
                calc=scaled_eigenvalue(l,p,d,cs,aa)
                target=fixed_limit(p,d,cs,aa,l)
                rows.append({"l":l,**calc,"limit":target,
                             "relative_error_to_limit":(calc["scaled_value"]-target)/target})
            fixed.append({"name":name,"p":p,"d":d,"cs":cs,"coefficients":aa,"rows":rows})
        report["fixed_threshold_sequences"] = fixed

        cross=[]
        for name,p,d,taus,aa in [
                ("fractional_three_thresholds",.35,3,[.6,-.4,1.1],[1.,-.7,.35]),
                ("relu_revived_odd_branch",1.,3,[.8],[1.])]:
            mats={}; rows=[]
            for parity in [1,-1]:
                M,err=crossover_matrix(p,d,taus,parity)
                target=leading_A(p,d)*float(np.array(aa)@M@np.array(aa))
                mats[str(parity)]={"matrix":M.tolist(),"matrix_eigenvalues":np.linalg.eigvalsh(M).tolist(),
                                   "predicted_scaled_limit":target,"transform_error_estimate":err}
            for l in [24,25,48,49,96,97]:
                calc=scaled_eigenvalue(l,p,d,[t/l for t in taus],aa)
                target=mats[str((-1)**l)]["predicted_scaled_limit"]
                rows.append({"l":l,**calc,"limit":target,
                             "relative_error_to_limit":(calc["scaled_value"]-target)/target})
            cross.append({"name":name,"p":p,"d":d,"taus":taus,"coefficients":aa,
                          "parity_limits":mats,"rows":rows})
        report["coalescing_threshold_sequences"] = cross

        stability=[]
        for p,d,cs,aa,l in [(.35,3,[.6,-.6],[1.,.7],97),
                             (.35,3,[.6/97,-.4/97,1.1/97],[1.,-.7,.35],97),
                             (1.,3,[.8/97],[1.],97)]:
            v1=scaled_eigenvalue(l,p,d,cs,aa,1)
            v2=scaled_eigenvalue(l,p,d,cs,aa,2)
            stability.append({"l":l,"p":p,"d":d,"cs":cs,"coefficients":aa,
                              "base":v1,"doubled_node_order":v2,
                              "scaled_absolute_difference":abs(v1["scaled_value"]-v2["scaled_value"])})
        report["node_order_stability"] = stability
        report["warnings"]=[str(w.message) for w in caught]
    # These finite checks detect convention/sign/implementation mistakes only.
    report["finite_checks_pass"] = bool(
        report["normalization"]["absolute_difference"] < 1e-12
        and max(x["absolute_difference"] for x in cap_rows) < 1e-10
        and max(x["endpoint_absolute_difference"] for x in exterior) < 1e-40
        and all(x["sampled_absolute_monotonicity"] for x in exterior)
        and max(abs(x["ridge_residual_r1_7"]) for x in zeros) < 1e-11
        and max(x["scaled_absolute_difference"] for x in stability) < 1e-6
        and all(min(v["matrix_eigenvalues"]) >= -1e-9
                for case in cross for v in case["parity_limits"].values())
        and not report["warnings"])
    path=ROOT/"results"/"numerical_checks.json"
    path.write_text(json.dumps(report,ensure_ascii=False,indent=2)+"\n")
    make_figure(report)
    print(json.dumps({"file":str(path),"finite_checks_pass":report["finite_checks_pass"],
                      "warnings":report["warnings"],
                      "max_cap_discrepancy":max(x["absolute_difference"] for x in cap_rows),
                      "max_node_order_discrepancy":max(x["scaled_absolute_difference"] for x in stability)},indent=2))


if __name__ == "__main__":
    main()
