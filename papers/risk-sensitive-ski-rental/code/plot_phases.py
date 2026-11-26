"""Plot formulas from the exact rational phase table; no fitted curves."""
from pathlib import Path
from fractions import Fraction as F
import json
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

ROOT=Path(__file__).resolve().parent.parent
rows=json.loads((ROOT/'results/exact_phase_tables.json').read_text())
by_B={r['B']:r for r in rows}

def value(B,delta):
    row=by_B[B];q=1-delta
    if q<=float(F(row['q_critical'])):return 2-1/B
    for p in row['pieces']:
        if float(F(p['q_lo']))-1e-12<=q<=float(F(p['q_hi']))+1e-12:
            return float(F(p['ratio_constant']))+float(F(p['ratio_inverse_q']))/q
    raise ValueError((B,delta))

plt.rcParams.update({'font.size':10,'axes.spines.top':False,'axes.spines.right':False,'font.family':'DejaVu Sans','pdf.fonttype':42})
fig,axes=plt.subplots(1,2,figsize=(10.2,3.65),layout='constrained')
colors=['#1C4E80','#008777','#B76521','#7B55A3']
x=np.linspace(0,1,501)
for B,col in zip([2,3,4,8],colors):
    dc=float(F(by_B[B]['delta_critical']))
    axes[0].plot(x,[value(B,d) for d in x],color=col,label=f'B = {B}',lw=2)
    axes[0].plot(dc,2-1/B,'o',color=col,ms=5)
axes[0].set(xlabel=r'Risk level $\delta$',ylabel='Optimal CVaR competitive ratio',title='Exact value curves and their plateaus',xlim=(0,1),ylim=(1.28,1.91))
axes[0].legend(frameon=False,ncol=2,loc='lower right');axes[0].grid(alpha=.16)
dc=5/11;xx=np.linspace(0,dc,301);qs=1-xx
ps=[np.where(xx<=4/19,4/19,(2*qs+2)/17),np.where(xx<=4/19,6/19,(3*qs+3)/17),np.where(xx<=4/19,9/19,(12-5*qs)/17)]
for j,(yy,col) in enumerate(zip(ps,colors)):
    axes[1].plot(xx,yy,color=col,lw=2,label=f'Buy on day {j+1}')
    axes[1].plot(dc,yy[-1],'o',color=col,ms=5)
axes[1].plot([dc],[1],marker='D',mfc='white',mec='#27313D',ms=6)
axes[1].plot([dc],[0],marker='D',mfc='white',mec='#27313D',ms=6)
axes[1].axvline(dc,color='#777777',lw=.8,ls='--')
axes[1].annotate('Deterministic day-3 policy\nalso optimal at the threshold',xy=(dc,1),xytext=(.025,.87),arrowprops={'arrowstyle':'-','color':'#777777'},fontsize=8.5)
axes[1].set(xlabel=r'Risk level $\delta$',ylabel='Purchase probability',title='B = 3: the unique randomized branch',xlim=(0,.50),ylim=(-.035,1.05))
axes[1].legend(frameon=False,loc='center left',bbox_to_anchor=(.02,.66),fontsize=8.5)
axes[1].grid(alpha=.16)
fig.savefig(ROOT/'figures/risk_phases.pdf')
fig.savefig(ROOT/'figures/risk_phases.png',dpi=200)
print('Saved risk_phases.pdf and risk_phases.png')
