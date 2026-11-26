#!/usr/bin/env python3
"""Rebuild publication figures from exact formulas and explicit graph data."""
from pathlib import Path
from fractions import Fraction
import csv
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from matplotlib.patches import Circle

ROOT=Path(__file__).resolve().parents[1]
OUT=ROOT/'figures'
OUT.mkdir(exist_ok=True)
plt.rcParams.update({'font.family':'DejaVu Sans','font.size':11,
                     'axes.spines.top':False,'axes.spines.right':False,
                     'pdf.fonttype':42,'savefig.bbox':'tight'})

fig,ax=plt.subplots(figsize=(8.5,3.3))
xy={1:(0,0.65),2:(0,-0.65),3:(1.05,0),4:(2.05,0),5:(3.05,0)}
edges=[(1,2,'1/5'),(1,3,'1/5'),(2,3,'1/5'),(3,4,'0'),(4,5,'2/5')]
for i,j,label in edges:
    a,b=xy[i],xy[j]
    ax.plot([a[0],b[0]],[a[1],b[1]],color='#a5acb6' if label=='0' else '#245a85',
            linewidth=1.8 if label=='0' else (4.5 if label=='2/5' else 2.7),
            linestyle='--' if label=='0' else '-',zorder=1)
    mx,my=(a[0]+b[0])/2,(a[1]+b[1])/2
    if i==1 and j==2: mx-=0.25
    elif j==3: my+=0.17 if i==1 else -0.17
    else: my+=0.2
    ax.text(mx,my,label,ha='center',va='center',color='#1b3247',
            bbox={'facecolor':'white','edgecolor':'none','pad':2},fontsize=12)
for v,(x,y) in xy.items():
    ax.add_patch(Circle((x,y),.13,facecolor='#eef4f8',edgecolor='#245a85',linewidth=1.8,zorder=3))
    ax.text(x,y,str(v),ha='center',va='center',zorder=4,fontweight='bold')
ax.text(1.5,1.06,'A connected graph attaining the sharp 5/6 ratio',ha='center',fontsize=14,fontweight='bold')
ax.text(1.5,-1.05,r'Optimal edge probabilities shown; every vertex has load $2/5$.',ha='center')
ax.text(1.5,-1.32,r'$V=6/5$       $V_{\mathrm{rec}}=1$       $V_{\mathrm{rec}}/V=5/6$',ha='center',fontsize=13)
ax.set_xlim(-.6,3.55);ax.set_ylim(-1.55,1.35);ax.set_aspect('equal');ax.axis('off')
for ext in ('pdf','png'):
    fig.savefig(OUT/f'graph_counterexample.{ext}',dpi=220)
plt.close(fig)

rows=[]
for m in range(3,61):
    d=m*m+2*m-2
    rows.append((m,Fraction(2*m*(m-1),d),Fraction(m,m+1),Fraction(d,2*(m*m-1))))
with (ROOT/'results'/'family_values.csv').open('w',newline='') as f:
    w=csv.writer(f);w.writerow(['m','optimal_value_exact','reciprocal_value_exact','ratio_exact'])
    w.writerows([[m,str(v),str(r),str(ratio)] for m,v,r,ratio in rows])
fig,ax=plt.subplots(figsize=(7.4,3.8))
ax.plot([r[0] for r in rows],[float(r[3]) for r in rows],color='#245a85',linewidth=2.5,
        label=r'$V_{\mathrm{rec}}/V=(m^2+2m-2)/(2m^2-2)$')
ax.scatter([3],[13/16],color='#b44c34',s=38,zorder=3)
ax.annotate(r'$m=3:\ 13/16$',xy=(3,13/16),xytext=(12,.77),
            arrowprops={'arrowstyle':'->','color':'#6c7780'},fontsize=11)
ax.axhline(.5,color='#6b737c',linestyle='--',linewidth=1.3,label='Limit for this family: 1/2')
ax.set_xlabel('Number of leaves m');ax.set_ylabel('Restricted / optimal guarantee')
ax.set_xlim(2,61);ax.set_ylim(.48,.85);ax.grid(alpha=.18)
ax.legend(frameon=False,loc='upper right',fontsize=10)
ax.set_title('The hypergraph family can lose almost half the value',loc='left',fontsize=13,pad=14)
fig.tight_layout()
for ext in ('pdf','png'):
    fig.savefig(OUT/f'family_ratio.{ext}',dpi=220)
plt.close(fig)
print('Built two figures in PDF and PNG; exact data in results/family_values.csv')
