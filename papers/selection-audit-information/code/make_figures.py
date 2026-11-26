#!/usr/bin/env python3
"""Render numerical certificates and analytic stopping-time bounds."""
from pathlib import Path
import json
import numpy as np
import mpmath as mp
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt

ROOT=Path(__file__).resolve().parents[1]
mp.mp.dps=60
P,Q=mp.mpf('.2'),mp.mpf('.5')
def kl(x,y):
    return x*mp.log(x/y)+(1-x)*mp.log((1-x)/(1-y))
def coarse(a,rho=mp.mpf('.3')):
    r=(1-a)*rho
    if Q-P<=r:return mp.mpf(0)
    return (Q-r)*mp.log((Q-r)/P)+(1-Q)*mp.log((1-Q)/(1-P-r))

def main():
    (ROOT/'figures').mkdir(exist_ok=True)
    data=json.loads((ROOT/'results'/'verified_bounds.json').read_text())['cases']
    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10,
       'axes.spines.top':False,'axes.spines.right':False,
       'axes.labelcolor':'#203342','text.color':'#203342',
       'axes.edgecolor':'#78909c','savefig.facecolor':'white'})
    # A single column keeps tick labels legible at manuscript text width.
    fig,axes=plt.subplots(3,1,figsize=(6.4,7.2),constrained_layout=True)
    for ax,rho,title,color in zip(axes,[.4,.3,.2],
         ['Overlap: gap < hiding cap','Contact: gap = hiding cap','Separated: gap > hiding cap'],
         ['#167d8d','#c36b36','#425aa7']):
        rows=[r for r in data if float(mp.mpf(r['rho']))==rho]
        x=np.array([float(mp.mpf(r['a'])) for r in rows])
        val=np.array([float(r['information_upper']) for r in rows])
        if rho==.4:
            d=Q-P;rr=mp.mpf('.4');lo,hi=mp.mpf(0),rr-d
            for _ in range(240):
                m=(lo+hi)/2
                g=mp.log((m+d)*(rr-m)/(m*(rr-m-d)))-d*(1/m+1/(rr-m))
                if g<0:lo=m
                else:hi=m
            v=(lo+hi)/2
            target=float(rr*kl((v+d)/rr,v/rr))
            y=val/x;label=r'$I_a/a$'
        elif rho==.3:
            target=rho/2;y=val/(x*np.log(1/x));label=r'$I_a/[a\log(1/a)]$'
        else:
            rr=mp.mpf('.2')
            i0=float((Q-rr)*mp.log((Q-rr)/P)+(1-Q)*mp.log((1-Q)/(1-P-rr)))
            target=rho;y=(val-i0)/(x*np.log(1/x));label=r'$(I_a-I_0)/[a\log(1/a)]$'
        ax.semilogx(x,y,'o-',color=color,lw=1.8,markersize=4,label='Certified finite-a values')
        ax.axhline(target,color='#7b858a',ls='--',lw=1.2,label=f'Theorem limit = {target:.6g}')
        ax.set_title(title,fontsize=10.5,loc='left',pad=7)
        ax.set_xlabel('Audit probability a');ax.set_ylabel(label)
        ax.invert_xaxis();ax.grid(True,alpha=.15);ax.legend(fontsize=8.5,frameon=False)
    fig.suptitle('Sharp information asymptotics   |   p = 0.2, q = 0.5',fontsize=12,x=.01,ha='left')
    for ext in ['png','pdf']:fig.savefig(ROOT/'figures'/f'information_regimes.{ext}',dpi=180)
    plt.close(fig)
    alpha=mp.mpf('.05');b=-mp.log(alpha);rho=mp.mpf('.3');d=kl(Q,P)
    aa=np.logspace(-3,-1,180)
    flo=[];fhi=[];clo=[];chi=[]
    for af in aa:
        a=mp.mpf(str(af));ib=coarse(a)
        flo.append(float((1-alpha)/(a*rho)))
        fhi.append(float((b+mp.log(Q/P))/(a*d)))
        clo.append(float(b/ib));chi.append(float((b+mp.log(1+a*rho/P))/ib))
    fig,ax=plt.subplots(figsize=(8,4.5),constrained_layout=True)
    ax.fill_between(aa,flo,fhi,color='#167d8d',alpha=.20,label='Provenance retained: minimax lower/upper bounds')
    ax.loglog(aa,flo,color='#167d8d',ls='--',lw=1)
    ax.loglog(aa,fhi,color='#167d8d',lw=1.8)
    ax.fill_between(aa,clo,chi,color='#c36b36',alpha=.3)
    ax.loglog(aa,clo,color='#c36b36',lw=2,label='Provenance discarded: tight minimax bounds')
    ax.loglog(aa,chi,color='#c36b36',ls='--',lw=1)
    ax.invert_xaxis();ax.grid(True,which='major',alpha=.18)
    ax.set_xlabel('Audit probability a (rarer audits to the right)')
    ax.set_ylabel('Worst-case expected raw observations')
    ax.set_title('Keeping the source flag changes the sample-complexity order\np = 0.2, q = 0.5, hiding cap = 0.3, false-alarm level = 0.05',loc='left',fontsize=12,pad=12)
    ax.legend(loc='upper left',fontsize=8,frameon=False)
    for ext in ['png','pdf']:fig.savefig(ROOT/'figures'/f'provenance_sample_cost.{ext}',dpi=180)
    plt.close(fig)
    rows=[]
    for s in ['0.1','0.01','0.001']:
        a=mp.mpf(s);ib=coarse(a)
        rows.append({'audit_probability':s,
          'full_lower':mp.nstr((1-alpha)/(a*rho),18),
          'full_upper':mp.nstr((b+mp.log(Q/P))/(a*d),18),
          'coarsened_lower':mp.nstr(b/ib,18),
          'coarsened_upper':mp.nstr((b+mp.log(1+a*rho/P))/ib,18),
          'coarsened_information':mp.nstr(ib,24)})
    (ROOT/'results'/'operational_bounds.json').write_text(json.dumps({
        'parameters':{'p':'0.2','q':'0.5','rho':'0.3','alpha':'0.05'},
        'interpretation':'Analytic minimax bounds, not simulated stopping times; decimal displays are approximate.',
        'cases':rows},indent=2)+'\n')
    print(json.dumps(rows,indent=2))

if __name__=='__main__':main()
