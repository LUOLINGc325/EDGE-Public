#!/usr/bin/env python3
"""Render manuscript figures from the reference formulas and saved experiments."""
from pathlib import Path
import hashlib, json
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from lq_game import branch_value, thresholds

ROOT=Path(__file__).resolve().parent.parent
OUT=ROOT/'results/figures'
OUT.mkdir(parents=True,exist_ok=True)
plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10,'axes.spines.top':False,
                     'axes.spines.right':False,'savefig.bbox':'tight','pdf.fonttype':42})

n=5; th=thresholds(n,1,1); a0=th['coalescence']
fig,axes=plt.subplots(1,2,figsize=(11,4.4),gridspec_kw={'width_ratios':[1.25,1]})
colors=['#243c5a','#007f86','#a05b30','#9276a8','#6b7280','#d27474']
t=np.linspace(0,3,1200)
for m in range(n+1):
    aa=branch_value(t,n,m,1)
    keep=aa<8
    axes[0].plot(aa[keep],t[keep],label=f'm = {m}',color=colors[m],lw=1.7)
for item in th['folds']:
    axes[0].scatter(item['A'],item['t'],s=26,color=colors[item['m']],zorder=5)
axes[0].axvline(a0,color='#777777',ls=':',lw=1)
axes[0].set(xlim=(0,8),ylim=(0,3),xlabel=r'$A=|a|/\sqrt{\sigma}$',ylabel=r'Branch coordinate $t$',title='All branches (N = 5, gamma = sigma = 1)')
axes[0].legend(ncol=2,frameon=False,fontsize=8,loc='upper left')
a1=th['folds'][0]['A']; a2=th['folds'][1]['A']
segments=[(0,a1,1,1),(a1,a2,11,6),(a2,a0,31,6),(a0,8,31,5)]
for lo,hi,total,stable in segments:
    axes[1].hlines(total,lo,hi,color='#243c5a',lw=2)
    axes[1].hlines(stable,lo,hi,color='#007f86',lw=2)
for x,tot,stable in [(a1,6,1),(a2,21,6),(a0,16,5)]:
    axes[1].scatter([x],[tot],color='#243c5a',s=28,zorder=5)
    axes[1].scatter([x],[stable],color='#007f86',s=28,zorder=5)
axes[1].plot([],[],color='#243c5a',label='Distinct equilibria')
axes[1].plot([],[],color='#007f86',label='Attracting equilibria (continuous BR flow)')
axes[1].set(xlim=(0,8),ylim=(0,34),xlabel=r'$A=|a|/\sqrt{\sigma}$',ylabel='Number of profiles',title='Exact count formula; dots mark boundary values')
axes[1].legend(frameon=False,loc='upper left',fontsize=8)
for ax in axes: ax.grid(alpha=.15)
fig.tight_layout()
for suffix in ['pdf','png']: fig.savefig(OUT/f'bifurcation_counts.{suffix}',dpi=180)
plt.close(fig)

evidence=json.loads((ROOT/'results/verification.json').read_text())
fig,ax=plt.subplots(figsize=(7.3,4.5))
for item in evidence['learning']['traces']:
    h=item['history']
    ax.semilogy([x['cycle'] for x in h],[max(x['residual'],1e-13) for x in h],lw=1.6,label=f"N = {item['N']}")
ax.set(xlabel='Completed cyclic sweeps',ylabel=r'$\|B(k)-k\|_2$',title='Representative heterogeneous learning runs')
ax.axhline(1e-9,color='#777777',ls=':',lw=1,label='Prespecified tolerance')
ax.grid(alpha=.17); ax.legend(frameon=False,fontsize=9,ncol=2)
fig.tight_layout()
for suffix in ['pdf','png']: fig.savefig(OUT/f'cyclic_learning.{suffix}',dpi=180)
receipt=dict(source_sha256={str(p.relative_to(ROOT)):hashlib.sha256(p.read_bytes()).hexdigest()
                           for p in [Path(__file__),ROOT/'code/lq_game.py',ROOT/'results/verification.json']},
             outputs={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(OUT.glob('*'))})
(ROOT/'results/figure_build_status.json').write_text(json.dumps(receipt,indent=2)+'\n')
print(json.dumps({'figures':['bifurcation_counts','cyclic_learning'],'count_thresholds':th},indent=2))
