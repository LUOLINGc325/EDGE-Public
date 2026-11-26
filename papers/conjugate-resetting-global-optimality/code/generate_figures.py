#!/usr/bin/env python3
"""Generate analytic research figures. No simulation or fitted data."""
from pathlib import Path
import json
import math
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
from scipy.special import erfc
import mpmath as mp

ROOT=Path(__file__).resolve().parents[1]

def main():
    plt.rcParams.update({
        "font.family":"DejaVu Sans","font.size":9,"axes.spines.top":False,
        "axes.spines.right":False,"axes.linewidth":0.7,"savefig.dpi":200
    })
    fig,axs=plt.subplots(1,2,figsize=(8.2,3.55),layout="constrained")
    x=np.linspace(0,12,800)
    exp_prior=2*np.exp(-2*x)
    zsharp=2*(2-math.sqrt(2))/math.sqrt(math.pi)
    sharp_prior=erfc(x/2)**2/zsharp
    # Stable equivalent of 1-x/sqrt(x*x+4).
    heavy_profile=4/(np.sqrt(x*x+4)*(np.sqrt(x*x+4)+x))
    heavy_prior=heavy_profile**2/(4-math.pi)
    for y,label,color,ls in [
        (exp_prior,"Exponential resets","#176b87","-"),
        (sharp_prior,"Deterministic resets","#b65c17","--"),
        (heavy_prior,"Infinite-mean resets","#7554a3","-.")
    ]:
        axs[0].semilogy(x,y,label=label,color=color,ls=ls,lw=1.8)
    axs[0].set(xlabel="Target distance x",ylabel="Normalized target density",
               ylim=(1e-6,4),xlim=(0,12),title="(a) Three conjugate distance priors")
    axs[0].legend(frameon=False,fontsize=8,loc="upper right")
    axs[0].grid(alpha=.16)
    z=np.linspace(.06,1.94,600)
    cost=1/(z*(2-z))
    axs[1].plot(z,cost,color="#176b87",lw=2)
    axs[1].plot([1],[1],"o",color="#b65c17",ms=5,zorder=5)
    axs[1].axhline(1,color="#444444",lw=.7,ls=":")
    axs[1].axvline(2,color="#9f3f3f",lw=1,ls="--")
    axs[1].axvspan(2,2.3,color="#9f3f3f",alpha=.09)
    axs[1].text(2.07,7.7,"Infinite\nmean",ha="center",fontsize=8,color="#7b2f2f")
    axs[1].annotate("Unique minimum",(1,1),(.69,4.2),
                    arrowprops={"arrowstyle":"->","lw":.7},fontsize=8)
    axs[1].set(xlabel="Square root of reset-rate ratio z",
               ylabel="Mean search time / reference mean",
               xlim=(0,2.3),ylim=(.7,10),
               title="(b) Exponential competitors: exact curve")
    axs[1].grid(alpha=.16)
    for ext in ("png","pdf"):
        fig.savefig(ROOT/"figures"/f"conjugate_priors_and_cost.{ext}",bbox_inches="tight")
    plt.close(fig)
    mp.mp.dps=60
    values={
        "status":"generated_from_exact_formulas",
        "diffusion":1,"reference_time_scale":1,
        "exponential_reference_mean":"1",
        "deterministic_reference_mean":str(2*mp.sqrt(2)/3),
        "mixed_exponential_mean":str(4*mp.log(2)-mp.mpf(7)/4),
        "infinite_mean_reset_reference_mean":str(16/(3*(4-mp.pi))),
        "plot_a":"Different target distributions, not a performance comparison on a common target.",
        "plot_b":"Within exponential competitors only; the unrestricted theorem is analytic.",
        "no_simulations":True
    }
    (ROOT/"results"/"analytic_examples.json").write_text(json.dumps(values,indent=2)+"\n")
    print(json.dumps(values))

if __name__=="__main__":
    main()
