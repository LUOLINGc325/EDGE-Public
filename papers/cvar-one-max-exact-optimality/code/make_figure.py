#!/usr/bin/env python3
"""Illustrative plots only. Exact certificates are generated separately."""
from pathlib import Path
import csv
import math
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from scipy.optimize import brentq

ROOT = Path(__file__).resolve().parents[1]


def phi(a, delta, t=1.0):
    if delta == 0:
        return 1+(a-1)*math.exp(a*t)
    if delta == 1:
        raise ValueError("delta=1 uses the separate deterministic endpoint")
    total = 1.0
    j = 1
    while j*delta < t:
        z = t-j*delta
        total += math.exp(j*math.log(a*z/(1-delta))-math.lgamma(j+1))
        j += 1
    return 1+(a-1)*total


def optimum(theta, delta):
    if delta >= 0.5:
        return math.sqrt(theta)
    return brentq(lambda a:phi(a,delta)-theta,1,math.sqrt(theta),xtol=2e-13)


def main():
    (ROOT/"figures").mkdir(exist_ok=True)
    (ROOT/"results").mkdir(exist_ok=True)
    plt.rcParams.update({"font.family":"DejaVu Sans","font.size":10,
                         "axes.spines.top":False,"axes.spines.right":False,
                         "pdf.fonttype":42,"savefig.bbox":"tight"})
    fig, axes = plt.subplots(1,2,figsize=(10.3,3.7),layout="constrained")
    deltas = np.unique(np.r_[0,np.linspace(.002,.5,240),np.linspace(.5,1,70)])
    rows=[]
    for theta,color in [(10,"#087F8C"),(100,"#284B88"),(1000,"#B56027")]:
        values=[optimum(theta,float(d)) for d in deltas]
        axes[0].plot(deltas,np.array(values)/math.sqrt(theta),color=color,lw=2,
                     label=rf"$\theta={theta}$")
        rows += [(theta,float(d),a,a/math.sqrt(theta)) for d,a in zip(deltas,values)]
    axes[0].axvline(.5,color="#999999",lw=1,ls="--")
    axes[0].set(xlabel=r"Risk level $\delta$",ylabel=r"Exact value / $\sqrt{\theta}$",
                title="A. Exact risk-performance curve",xlim=(0,1),ylim=(0,1.04))
    axes[0].legend(frameon=False,loc="lower right")
    theta,delta=100,.25
    a=optimum(theta,delta)
    ts=np.linspace(0,1,501)
    full=np.array([phi(a,delta,float(t)) for t in ts])
    clipped=np.array([phi(a,delta,min(float(t),1-delta)) for t in ts])
    axes[1].plot(ts,full,color="#284B88",lw=2,label="Original optimal quantile")
    axes[1].plot(ts,clipped,color="#C35A30",lw=2,ls="--",label="Clipped optimal quantile")
    axes[1].axvline(1-delta,color="#999999",lw=1,ls=":")
    axes[1].set(xlabel=r"Probability quantile $t$",ylabel="Sale threshold / L",
                title=r"B. Two optimizers: $\theta=100,\ \delta=1/4$",xlim=(0,1))
    axes[1].legend(frameon=False,loc="upper left",fontsize=8.6)
    axes[0].grid(alpha=.16)
    axes[1].grid(alpha=.16)
    for suffix in ("png","pdf"):
        fig.savefig(ROOT/f"figures/value_and_quantiles.{suffix}",dpi=200)
    plt.close(fig)
    with (ROOT/"results/illustrative_curves.csv").open("w",newline="") as stream:
        writer=csv.writer(stream)
        writer.writerow(["theta","delta","numerical_optimum","ratio_to_deterministic"])
        writer.writerows(rows)
    print("Created illustrative figure and CSV; these are not exact certificates.")


if __name__=="__main__":
    main()
