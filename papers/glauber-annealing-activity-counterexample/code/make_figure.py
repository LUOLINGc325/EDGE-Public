#!/usr/bin/env python3
"""Generate a data-based graph and activity figure; never used for certification."""
from pathlib import Path
import json
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from matplotlib import colors

ROOT = Path(__file__).resolve().parents[1]
data = json.loads((ROOT/"results/exact_certificate.json").read_text())
edges = data["model"]["edges"]
energies = data["model"]["energies"]
pos = {0:(-1.8,0.8),1:(-1.8,-0.8),2:(-3,0.8),3:(-3,-0.8),4:(-0.7,0),
       5:(1.8,0.8),6:(1.8,-0.8),7:(3,0.8),8:(3,-0.8),9:(0.7,0)}
plt.rcParams.update({"font.family":"DejaVu Sans", "font.size":10,
                     "axes.spines.top":False, "axes.spines.right":False,
                     "pdf.fonttype":42, "ps.fonttype":42})
fig, axes = plt.subplots(1,2,figsize=(10,3.9),gridspec_kw={"width_ratios":[1.5,1]})
fig.patch.set_facecolor("white")
ax = axes[0]
for u,v in edges:
    bridge = set((u,v)) == {4,9}
    ax.plot([pos[u][0],pos[v][0]],[pos[u][1],pos[v][1]],
            color="#344b5e" if bridge else "#a0acb5",lw=3 if bridge else 1.4,zorder=1)
cmap = plt.get_cmap("coolwarm")
norm = colors.Normalize(0,11)
for i,(x,y) in pos.items():
    ax.scatter(x,y,s=450,c=[cmap(norm(energies[i]))],edgecolors="#263747",lw=1,zorder=2)
    ax.text(x,y,str(i),ha="center",va="center",color="white" if energies[i] in (0,11) else "#132231",
            fontsize=10,weight="bold",zorder=3)
    ax.text(x,y+(0.37 if y>=0 else -0.37),f"E={energies[i]}",ha="center",va="center",fontsize=9)
ax.text(0,0.23,"bridge",ha="center",fontsize=9,color="#344b5e")
ax.set(xlim=(-3.6,3.6),ylim=(-1.55,1.55),aspect="equal")
ax.axis("off")
ax.set_title("(a) Connected 3-regular proposal graph",loc="left",pad=10,fontsize=11,weight="bold")
ax=axes[1]
keys=["A0","A1","two_step_average"]
values=[float(data["activities"][k]["decimal_50_significant_digits"]) for k in keys]
palette=["#5b7080","#ae342f","#1b7770"]
ax.axhline(.5,color="#677582",lw=1,ls="--")
for j,(y,c) in enumerate(zip(values,palette)):
    ax.vlines(j,.5,y,color=c,lw=2)
    ax.scatter(j,y,c=c,s=65,zorder=3)
    ax.annotate(f"{y:.8f}",(j,y),xytext=(0,10 if j else -20),textcoords="offset points",
                ha="center",color=c,fontsize=9,weight="bold")
ax.set_xticks(range(3),["First update","Second update","Two-step mean"],fontsize=9)
ax.set(xlim=(-.55,2.55),ylim=(.4994,.50415),ylabel="Probability of a state change")
ax.set_yticks([.5,.501,.502,.503,.504])
ax.tick_params(axis="x",length=0,pad=8)
ax.grid(axis="y",color="#e7ecf0",lw=.6)
ax.set_title("(b) Exact finite-temperature example",loc="left",pad=10,fontsize=11,weight="bold")
fig.subplots_adjust(left=.02,right=.99,bottom=.2,top=.88,wspace=.27)
fig.text(.5,.045,r"$e^{\beta_0}=10001/10000,\quad e^{\beta_1}=5/4,\quad e^{\beta_2}=100$",
         ha="center",fontsize=11)
out=ROOT/"figures"
out.mkdir(exist_ok=True)
fig.savefig(out/"graph-and-activity.pdf",bbox_inches="tight")
fig.savefig(out/"graph-and-activity.png",dpi=220,bbox_inches="tight")
print(out/"graph-and-activity.png")
