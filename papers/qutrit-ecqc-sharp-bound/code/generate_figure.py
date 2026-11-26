#!/usr/bin/env python3
"""Illustration from explicit entropy formulas; not part of the proof."""
from pathlib import Path
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

ROOT = Path(__file__).resolve().parent.parent

def h(values):
    a = np.asarray(values, dtype=float)
    a = a[a > 0]
    return -np.sum(a*np.log2(a))

def gap(t):
    p=(4+5*t)/36; q=(1-t)/9; r=(t+2)/6
    s=(4-t)/12; u=(1-t)/3; v=(1+8*t)/9
    classical=2*h([r,s,s])-h([p]*4+[q]*5)
    quantum=2*h([r,r,u])-h([v]+[q]*8)
    return 3*classical-quantum

def main():
    out=ROOT/'figures'; out.mkdir(exist_ok=True)
    x=np.linspace(0,1,1001); y=np.array([gap(t) for t in x])
    alpha=.657878479798763786515
    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10,
                         'axes.spines.top':False,'axes.spines.right':False})
    fig,ax=plt.subplots(figsize=(7.3,3.7),layout='constrained')
    ax.axhline(0,color='#687583',lw=.8)
    ax.axvspan(alpha,1,color='#cce9e4',alpha=.6)
    ax.plot(x,y,color='#126b67',lw=2.2)
    ax.scatter([alpha,2/3,1],[0,gap(2/3),1],color=['#183b56','#ba5b28','#126b67'],s=[25,23,28],zorder=4)
    ax.annotate(r'$\alpha=0.6578784798\ldots$',xy=(alpha,0),xytext=(.33,.29),
                arrowprops={'arrowstyle':'-','color':'#183b56'},color='#183b56')
    ax.text(.78,.49,'ECQC violation',color='#126b67',ha='center',weight='bold')
    ax.text(.3,-.20,'Original inequality holds',color='#687583',ha='center')
    ax.annotate('Pure witness: +1 bit',xy=(1,1),xytext=(.60,.90),
                arrowprops={'arrowstyle':'-','color':'#126b67'},color='#126b67')
    ax.set(xlim=(0,1.015),ylim=(-.26,1.08),xlabel=r'Visibility $t$  (white-noise fraction $1-t$)',
           ylabel=r'Gap $F(t)=J(\rho_t)-Q(\rho_t)$ [bits]')
    ax.set_title('Exact white-noise threshold for the qutrit witness',loc='left',pad=12,weight='bold')
    fig.savefig(out/'white_noise_threshold.png',dpi=200)
    fig.savefig(out/'white_noise_threshold.pdf')
    plt.close(fig)
    print('Wrote figures/white_noise_threshold.{png,pdf}')

if __name__ == '__main__':
    main()
