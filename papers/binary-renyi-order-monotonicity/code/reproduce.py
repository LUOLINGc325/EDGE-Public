#!/usr/bin/env python3
"""Reproduce exact algebra checks, high-precision examples, and the paper figure.

These computations support the analytic proof; they are not a proof of its
universal quantifiers. Run from any working directory.
"""
from __future__ import annotations
import csv
import json
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import mpmath as mp
import sympy as sp

ROOT = Path(__file__).resolve().parents[1]


def exact_algebra():
    y, u, d, r = sp.symbols("y u d r", positive=True)
    g = d + u*y/(1+y)
    ds = lambda f: sp.factor(-u*y*sp.diff(f, y))
    gp, gpp = ds(g), ds(ds(g))
    determinant = u**3*y/(1+y)**4*(d-(d+u)*y**2)
    assert sp.factor(g* gpp-gp**2-determinant) == 0
    h = d + u*r/(1+r)
    w = r/(1+r)**2
    tau = (1-r)/(1+r)
    endpoint_numerator = (d*(1-r**2)-u*r**2)/(1+r)**2
    assert sp.factor(tau*h-u*w-endpoint_numerator) == 0
    a, delta = sp.symbols("a delta", real=True)
    c = sp.log(2)
    binomial_sum = ((1+delta)**a+(1-delta)**a)/2
    logarithm = sp.series(sp.log(binomial_sum), delta, 0, 5).removeO()
    coeff2 = sp.factor(logarithm.coeff(delta, 2)/(1-a))
    coeff4 = sp.factor(logarithm.coeff(delta, 4)/(1-a))
    assert sp.simplify(coeff2 + a/2) == 0
    assert sp.simplify(coeff4-a*(a*a+a-3)/12) == 0
    shannon = c - ((1+delta)*sp.log(1+delta)
                   +(1-delta)*sp.log(1-delta))/2
    shannon_series = sp.series(shannon,delta,0,5).removeO()
    assert shannon_series.coeff(delta,2) == -sp.Rational(1,2)
    assert shannon_series.coeff(delta,4) == -sp.Rational(1,12)
    return {
        "status": "pass",
        "g_first_derivative": str(gp),
        "g_second_derivative": str(gpp),
        "logconvex_determinant_identity_residual": "0",
        "endpoint_identity_residual": "0",
        "entropy_uniform_quadratic_coefficient": str(coeff2),
        "entropy_uniform_quartic_coefficient": str(coeff4),
        "shannon_uniform_quadratic_coefficient": "-1/2",
        "shannon_uniform_quartic_coefficient": "-1/12",
        "scope": "Exact symbolic identities only; positivity is proved in the manuscript.",
    }


def entropy(alpha, p):
    alpha, p = mp.mpf(alpha), mp.mpf(p)
    if p == 0 or p == 1:
        return mp.mpf(0)
    if alpha == 1:
        return -p*mp.log(p)-(1-p)*mp.log1p(-p)
    # The precision used here is ample for the displayed interior examples.
    return mp.log(mp.power(p,alpha)+mp.power(1-p,alpha))/(1-alpha)


def powered(alpha, p):
    return mp.power(entropy(alpha,p)/mp.log(2), 2/mp.mpf(alpha))


def examples():
    mp.mp.dps = 100
    rows = []
    p = mp.mpf(1)/17
    for a in ["0.25","0.5","1","1.5","2","3","4","10","100"]:
        rows.append({
            "p": "1/17",
            "alpha": a,
            "H_alpha_nats": mp.nstr(entropy(a,p),42),
            "powered_F_alpha": mp.nstr(powered(a,p),42),
            "inside_theorem_domain": mp.mpf(a)>=1,
        })
    # Confirm a known domain-external example and every consecutive included pair.
    assert powered(".25",p) > powered(".5",p)
    inside = [row for row in rows if row["inside_theorem_domain"]]
    for left,right in zip(inside,inside[1:]):
        assert mp.mpf(right["powered_F_alpha"])>mp.mpf(left["powered_F_alpha"])
    out = ROOT/"results/comparison_table.csv"
    with out.open("w",newline="") as f:
        writer=csv.DictWriter(f,fieldnames=list(rows[0]))
        writer.writeheader()
        writer.writerows(rows)
    return rows


def figure():
    mp.mp.dps=60
    p=mp.mpf(1)/17
    xs=[mp.mpf(1)/10+mp.mpf(i)*39/6000 for i in range(601)]
    ys=[float(powered(x,p)) for x in xs]
    plt.rcParams.update({
        "font.family":"DejaVu Sans",
        "font.size":10,
        "axes.spines.top":False,
        "axes.spines.right":False,
    })
    fig,ax=plt.subplots(figsize=(7.4,3.8),layout="constrained")
    ax.axvspan(.1,1,color="#e9edf1",zorder=0)
    ax.plot([float(x) for x in xs],ys,color="#0c7686",lw=2.5)
    ax.axvline(1,color="#74838c",ls="--",lw=1)
    lowx=[.25,.5]
    ax.scatter(lowx,[float(powered(x,p)) for x in lowx],
               s=28,color="#b64e35",zorder=3)
    ax.annotate("Known low-order failure",xy=(.5,float(powered(.5,p))),
                xytext=(.18,.25),fontsize=9,color="#8e422f",
                arrowprops={"arrowstyle":"->","color":"#8e422f"})
    ax.text(2.65,.12,"Strictly increasing for every order ≥ 1",
            ha="center",fontsize=9,color="#0c6573")
    ax.set_xlim(.1,4)
    ax.set_ylim(.06,.37)
    ax.set_xlabel("Rényi order α")
    ax.set_ylabel("Normalized powered entropy")
    ax.set_title("A known low-order obstruction and the proved above-one regime",
                 loc="left",fontsize=11,pad=13)
    ax.text(.99,.04,"Binary probability p = 1/17",transform=ax.transAxes,
            ha="right",color="#4c5c65",fontsize=9)
    ax.grid(axis="y",alpha=.14)
    fig.savefig(ROOT/"figures/powered_entropy.png",dpi=210)
    fig.savefig(ROOT/"figures/powered_entropy.pdf")
    plt.close(fig)


def main():
    for folder in ("results","figures"):
        (ROOT/folder).mkdir(exist_ok=True)
    result=exact_algebra()
    rows=examples()
    figure()
    result["example_rows"]=len(rows)
    result["example_precision_decimal_digits"]=100
    result["packages"]={"sympy":sp.__version__,"mpmath":mp.__version__,
                        "matplotlib":matplotlib.__version__}
    (ROOT/"results/algebra_and_examples.json").write_text(
        json.dumps(result,indent=2)+"\n")
    print(json.dumps(result,indent=2))


if __name__=="__main__":
    main()
