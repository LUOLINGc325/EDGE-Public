#!/usr/bin/env python3
"""Plot proved bounds, not estimates of the exact finite-order divergence."""
from pathlib import Path
import numpy as np
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt


def lift(a,c,b,alpha):
    scale=a/c
    d1=1+alpha*(scale*scale-1)
    d2=1+alpha*(1/(scale*scale)-1)
    if min(d1,d2)<=0:
        return .5
    return min(.5,b*b*(1-1/scale)**2/(2*d2)
               -np.log(d1*d2)/(2*alpha*(alpha-1)))


def main():
    plt.rcParams.update({"font.family":"DejaVu Sans","font.size":10,
                         "axes.spines.top":False,"axes.spines.right":False,
                         "svg.fonttype":"none"})
    counts=np.geomspace(1,100000,600)
    fig,axes=plt.subplots(1,2,figsize=(11.8,4.2),constrained_layout=True)
    b=2.0
    for alpha,color in [(2,"#24698a"),(8,"#5d7d35"),(32,"#ae6732")]:
        bounds=[max(lift(x+1,x,b,alpha),lift(x,x+1,b,alpha)) for x in counts]
        axes[0].loglog(counts,bounds,color=color,label=rf"$\alpha={alpha}$: both directions")
    axes[0].axhline(.25,color="#a13446",ls="--",lw=1.7,label="All-order zCDP floor = 1/4")
    axes[0].set(xlabel="Count x",ylabel=r"Bound on $D_\alpha/\alpha$",
                title="A fixed finite order can miss the floor",ylim=(1e-10,.75))
    axes[0].legend(fontsize=8,loc="lower left")
    axes[0].grid(which="major",alpha=.17)
    kappas=np.geomspace(1e-5,.99,800)
    upper=[]
    for x in counts:
        values=1/(2*(2-kappas))+(b*b/(2*kappas)+2/(kappas*(2-kappas)))/(x*x)
        upper.append(min(.5,float(values.min())))
    axes[1].semilogx(counts,upper,color="#24698a",label="Uniform upper bound over all orders")
    axes[1].axhline(.25,color="#a13446",ls="--",lw=1.7,label="Exact high-order lower bound")
    axes[1].fill_between(counts,.25,upper,color="#24698a",alpha=.10)
    axes[1].set(xlabel="Count x",ylabel="Outward all-order coefficient",
                title=r"The outward optimum tends to $1/4$",ylim=(.225,.525))
    axes[1].legend(fontsize=8,loc="upper right")
    axes[1].grid(alpha=.17)
    fig.suptitle(r"Gaussian-product release: $\sigma=1$, $r=1/2$, adjacent counts $x$ and $x+1$",fontsize=13)
    base=Path(__file__).resolve().parents[1]/"figures"/"privacy_bounds"
    fig.savefig(base.with_suffix(".png"),dpi=180)
    fig.savefig(base.with_suffix(".svg"))
    plt.close(fig)
    print("Created figures/privacy_bounds.png and figures/privacy_bounds.svg")


if __name__=="__main__":
    main()
