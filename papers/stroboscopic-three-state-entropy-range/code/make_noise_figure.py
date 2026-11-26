#!/usr/bin/env python3
"""Plot proved bounds and a numerically evaluated scalar variational endpoint."""
from pathlib import Path
import json
import numpy as np
from scipy.optimize import minimize_scalar
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/"figures"
OUT.mkdir(exist_ok=True)
u=12.0
t=1.0
ell=np.exp(-u*t)
w=2*np.pi/t
def gap(a,b):
    return 2*b/np.sqrt(3)*np.log((a+np.sqrt(3)*b)/(a-np.sqrt(3)*b))
g0=gap(u,w)
ga=-4*w*w/(u*u-3*w*w)
gb=2/np.sqrt(3)*np.log((u+np.sqrt(3)*w)/(u-np.sqrt(3)*w))+4*u*w/(u*u-3*w*w)
slope=np.hypot(ga,gb)/(np.sqrt(2)*t)
ratios=np.linspace(0,.25,151)
low=[];upper=[];high=[];safe=[]
for eta in ratios:
    eps=eta*ell
    d=-np.log1p(-eta)/t
    c=2/(np.sqrt(3)*t)*np.arcsin(eta/(2*np.sqrt(2)))
    low.append(2*c*np.log((u+3*c)/(u-3*c)) if eta else 0)
    upper.append(2*d*d/(u-3*d))
    r=eps/np.sqrt(2)
    if eta:
        def objective(phi):
            z=ell+r*np.exp(1j*phi)
            return gap(-np.log(abs(z))/t,(2*np.pi-np.angle(z))/t)
        result=minimize_scalar(objective,bounds=(0,np.pi),method="bounded",
                               options={"xatol":1e-13})
        if not result.success:
            raise RuntimeError("Scalar minimization did not converge")
        high.append(result.fun)
    else:
        high.append(g0)
    safe.append(gap(-np.log(ell-r)/t,(2*np.pi-np.arcsin(r/ell))/t))
low=np.array(low);upper=np.array(upper);high=np.array(high);safe=np.array(safe)
if not np.all(upper<safe):
    raise RuntimeError("Displayed interval includes an unverified separation regime")

plt.rcParams.update({"font.family":"DejaVu Sans","font.size":10,
                    "axes.spines.top":False,"axes.spines.right":False,
                    "savefig.bbox":"tight"})
fig,ax=plt.subplots(1,2,figsize=(10,3.8))
ax[0].fill_between(ratios,low,upper,color="#c8dfea",alpha=.9,label=r"Proved bracket for $M_\varepsilon$")
ax[0].plot(ratios,low,color="#1a617e",lw=1.8,label="Attained lower witness")
ax[0].plot(ratios,upper,color="#1a617e",lw=1.8,ls=":",label="Universal upper bound")
ax[0].plot(ratios,2*ratios**2/(u*t*t),color="#b65422",ls="--",lw=1.5,
           label=r"Sharp quadratic term")
ax[0].set(title="Low-entropy interval: quadratic opening",ylabel="Entropy-production rate",
          xlabel=r"Relative matrix tolerance $\varepsilon/|\lambda|$",xlim=(0,.25))
ax[0].legend(frameon=False,fontsize=8,loc="upper left")
ax[1].plot(ratios,high,color="#1a617e",lw=2,label=r"$m_\varepsilon$: scalar minimization")
ax[1].plot(ratios,g0-slope*ratios,color="#b65422",ls="--",lw=1.5,label="Sharp linear term")
ax[1].plot(ratios,safe,color="#6c7e88",ls=":",lw=1.5,label="Explicit safe lower bound")
ax[1].set(title="High-entropy interval: moving threshold",ylabel="Entropy-production rate",
          xlabel=r"Relative matrix tolerance $\varepsilon/|\lambda|$",xlim=(0,.25))
ax[1].legend(frameon=False,fontsize=8,loc="lower left")
for a in ax: a.grid(alpha=.18)
fig.suptitle(r"Finite-resolution entropy bands at $t=1$, $u=12$, $\lambda=e^{-12}$",fontsize=13,y=1.04)
fig.tight_layout()
fig.savefig(OUT/"finite_resolution_bands.pdf")
fig.savefig(OUT/"finite_resolution_bands.png",dpi=180)
data={"u":u,"t":t,"lambda":ell,"numerical_endpoint_method":"SciPy bounded scalar minimization; not an interval certificate",
      "M_epsilon_note":"Only a bracket is plotted; M is not asserted to equal either curve.",
      "relative_tolerance":ratios.tolist(),"low_witness":low.tolist(),"low_upper_bound":upper.tolist(),
      "high_minimum_numerical":high.tolist(),"high_safe_lower_bound":safe.tolist()}
(ROOT/"results"/"noise_figure_data.json").write_text(json.dumps(data,indent=2)+"\n")
print("Saved finite-resolution figure and its numerical data.")
