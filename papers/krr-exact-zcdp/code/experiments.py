#!/usr/bin/env python3
"""Reproduce diagnostic tables and publication figures (not proof by sampling)."""
from __future__ import annotations

import csv
import json
from pathlib import Path

import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import mpmath as mp
import numpy as np

from krr_zcdp import solve, transition_epsilon, rdp_ratio

ROOT = Path(__file__).resolve().parent.parent


def prior_upper(k,e):
    """Minimum of valid HM2026 Cor.18/Thm19 and pure-DP bounds.

    The numerical comparison is used at epsilon=1, where the logarithm
    in Thm19's stated expression is positive.
    """
    z = mp.exp(e)+k-1
    return min(e*mp.expm1(e)/(mp.exp(e)-1+min(k,6)),
               e*e*max(1/mp.log(mp.sqrt(z)/e),1/mp.sqrt(z)),
               e*mp.tanh(e/2))


def main():
    mp.mp.dps=75
    (ROOT/'results').mkdir(exist_ok=True)
    (ROOT/'figures').mkdir(exist_ok=True)
    samples=[(2,'1'),(6,'0.1'),(7,'0.1'),(7,'0.5'),(10,'1'),
             (14,'2'),(100,'1'),(1000,'1'),(1000000,'1')]
    rows=[]
    for k,e in samples:
        result=solve(k,e,60).__dict__
        if e=='1':
            result['previous_valid_upper']=mp.nstr(prior_upper(k,mp.mpf(e)),50)
        rows.append(result)
    transitions=[{'k':k,'epsilon_transition':transition_epsilon(k,60)}
                 for k in [7,8,10,16,100,1000]]
    (ROOT/'results/numerical_tables.json').write_text(json.dumps(
        {'scope':'High precision diagnostics; rigorous examples are separate',
         'samples':rows,'transitions':transitions},indent=2)+'\n')

    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10,
                         'axes.spines.top':False,'axes.spines.right':False,
                         'axes.titleweight':'bold','figure.dpi':130})
    fig,axs=plt.subplots(1,2,figsize=(11.6,4.25))
    colors=['#245a81','#b65f20','#29806c']
    for k,color in zip([6,10,100],colors):
        orders=np.linspace(1,18,260)
        vals=[float(rdp_ratio(str(x),k,1)) for x in orders]
        result=solve(k,'1',40)
        axs[0].plot(orders,vals,color=color,label=f'k = {k}')
        axs[0].plot(float(result.alpha),float(result.rho),'o',color=color,ms=6)
    axs[0].set(xlabel=r'Renyi order $\alpha$',ylabel=r'$D_\alpha/\alpha$',
               title=r'A  Unique optimizer ($\varepsilon=1$)',xlim=(1,18))
    axs[0].legend(frameon=False)
    axs[0].grid(alpha=.16)
    ks=np.unique(np.rint(np.geomspace(2,1e6,90)).astype(int))
    values=[]
    for k in ks:
        r=solve(int(k),'1',35)
        values.append([int(k),float(r.rho),float(r.kl_value),float(prior_upper(int(k),1)),
                       1/(4*np.log(k))])
    values=np.asarray(values)
    axs[1].loglog(values[:,0],values[:,1],color='#245a81',lw=2,label='Exact characterization')
    axs[1].loglog(values[:,0],values[:,3],color='#b65f20',ls='--',label='Earlier valid upper bound')
    axs[1].loglog(values[:,0],values[:,2],color='#29806c',ls=':',label=r'KL endpoint (lower bound)')
    axs[1].loglog(values[:,0],values[:,4],color='#777777',ls='-.',label=r'$1/(4\log k)$ asymptotic')
    axs[1].set(xlabel='Alphabet size k',ylabel=r'zCDP parameter $\rho$',
               title=r'B  Sharp large-alphabet constant ($\varepsilon=1$)')
    axs[1].legend(frameon=False,fontsize=8,loc='lower left')
    axs[1].grid(alpha=.16,which='major')
    fig.tight_layout(pad=1.5)
    for ext in ['pdf','png']:
        fig.savefig(ROOT/f'figures/bounds_and_optima.{ext}',bbox_inches='tight',dpi=190)
    with (ROOT/'results/figure_data.csv').open('w',newline='') as f:
        out=csv.writer(f)
        out.writerow(['k','rho','kl_endpoint','previous_upper','asymptotic'])
        out.writerows(values)
    print(f'Wrote {len(rows)} table rows, {len(transitions)} transitions, {len(ks)} plot points.')


if __name__=='__main__':
    main()
