#!/usr/bin/env python3
"""Render two self-contained scientific figures from reproducible ODE data."""
import json
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
from scipy.special import gammaln

from verify_ode import Half, beta_cost, beta_baseline

ROOT=Path(__file__).resolve().parents[1]
plt.rcParams.update({"font.family":"DejaVu Sans","font.size":10,
                     "axes.spines.top":False,"axes.spines.right":False,
                     "figure.dpi":150,"savefig.dpi":200})


def save(fig,name):
    (ROOT/"figures").mkdir(exist_ok=True)
    fig.savefig(ROOT/"figures"/(name+".png"),bbox_inches="tight")
    fig.savefig(ROOT/"figures"/(name+".pdf"),bbox_inches="tight")
    plt.close(fig)


def main():
    colors=["#236c7e","#686868","#b8592d"]
    fig,ax=plt.subplots(1,2,figsize=(10.4,3.7),layout="constrained")
    x=np.linspace(-.985,.985,500)
    for beta,color in zip([.5,1,2],colors):
        c=np.exp(gammaln(beta+.5)-gammaln(beta)-.5*np.log(np.pi))
        ax[0].plot(x,c*(1-x*x)**(beta-1),color=color,label=rf"$\beta={beta:g}$")
    ax[0].set(xlabel="Target position",ylabel="Target density",title="(a) Target distributions")
    ax[0].legend(frameon=False)
    ax[0].set_xlim(-1,1)
    rows=json.loads((ROOT/"results"/"ode_checks.json").read_text())["profiles"]
    lower=np.array([r["support_lower_bound"] for r in rows if r["support_lower_bound"]>0])
    actual=np.array([r["uniform_gap"] for r in rows if r["support_lower_bound"]>0])
    ax[1].scatter(lower,actual,s=25,alpha=.8,color=colors[0],label="29 nonzero profiles")
    lim=[min(lower.min(),actual.min())*.75,max(lower.max(),actual.max())*1.3]
    ax[1].plot(lim,lim,ls="--",color="#666666",lw=1,label="Analytic lower bound")
    ax[1].set(xscale="log",yscale="log",xlim=lim,ylim=lim,
              xlabel="Global supporting lower bound",ylabel=r"Computed $J_1(r)-5/12$",
              title="(b) Uniform-target theorem")
    ax[1].legend(frameon=False,loc="upper left",fontsize=8)
    save(fig,"global_bound")
    strength=np.linspace(0,4,41)
    data={"rate_profile":"strength * 1_{3/4 <= |x| <= 7/8}","strengths":strength.tolist(),"curves":{}}
    fig,ax=plt.subplots(figsize=(6.5,3.6),layout="constrained")
    for beta,color in zip([.5,1,2],colors):
        values=[]
        for z in strength:
            half=Half([0,.75,.875,1],[0,z,0])
            # Subtract the numerical zero-profile baseline to cancel quadrature bias.
            zero=Half([0,1],[0])
            values.append(beta_cost(half,half,beta,640)-beta_cost(zero,zero,beta,640))
        ax.plot(strength,values,lw=2,color=color,label=rf"$\beta={beta:g}$")
        data["curves"][str(beta)]=values
    ax.axhline(0,color="#555555",lw=.8)
    ax.set(xlabel="Rate within two interior boundary bands",
           ylabel=r"Change in mean search time $J_\beta(r)-J_\beta(0)$",
           title="A single rate profile changes from harmful to helpful")
    ax.legend(frameon=False)
    ax.ticklabel_format(axis="y",style="sci",scilimits=(-2,2))
    save(fig,"beta_transition")
    (ROOT/"results"/"figure_data.json").write_text(json.dumps(data,indent=2)+"\n")
    print("Rendered global_bound and beta_transition as PNG/PDF; wrote figure_data.json")


if __name__=="__main__":
    main()
