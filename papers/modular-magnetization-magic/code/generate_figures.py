"""Publication figures from proved formulas; no numerical curve is a proof."""
from pathlib import Path
import json
import math
import numpy as np
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
from magic_resolution import dicke_density, coherent_density, effective_rate, moment_filling

ROOT=Path(__file__).resolve().parents[1]


def centered_limit(kappa,p=.25):
    jlo=math.ceil(-p/kappa-1e-12)
    jhi=math.floor((1-p)/kappa+1e-12)
    center=(moment_filling(p)-p)/kappa
    js={max(jlo,min(jhi,math.floor(center))),max(jlo,min(jhi,math.ceil(center)))}
    f,j=min(((min(1,max(0,p+j*kappa)),j) for j in js),key=lambda t:effective_rate(t[0],p))
    return effective_rate(f,p),j,f


def main():
    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10,'axes.spines.top':False,
                        'axes.spines.right':False,'axes.titleweight':'bold','axes.labelsize':10,
                        'axes.titlesize':12,'legend.frameon':False,'savefig.dpi':200})
    navy='#123a5b';teal='#098888';orange='#c65c2c';gray='#708090'
    fig,axes=plt.subplots(3,1,figsize=(7.0,9.0),layout='constrained')
    ps=np.linspace(.0001,.4999,600)
    axes[0].plot(ps,[dicke_density(p) for p in ps],color=navy,lw=2,label='Exact number: Dicke density')
    axes[0].plot(ps,[coherent_density(p) for p in ps],color=teal,lw=2,label='Sublinear modulus density')
    axes[0].fill_between(ps,[coherent_density(p) for p in ps],[dicke_density(p) for p in ps],color=teal,alpha=.12)
    axes[0].set(xlabel='Product-state excitation probability p',ylabel='SRE density (bits / qubit)',title='A  Coarse and exact projections',xlim=(0,.5),ylim=(0,.45))
    axes[0].legend(loc='lower right',fontsize=8)
    kappas=np.linspace(.0006,.22,1600)
    vals=[centered_limit(k) for k in kappas]
    axes[1].plot(kappas,[v[0] for v in vals],color=navy,lw=1.6)
    critical=.1138283909273401
    axes[1].axhline(coherent_density(.25),color=teal,ls='--',lw=1,label='Sublinear limit')
    axes[1].axhline(dicke_density(.25),color=gray,ls=':',lw=1,label='Dicke limit')
    axes[1].axvline(critical,color=orange,lw=1.3,ls='--')
    axes[1].text(critical+.006,.308,r'$\kappa_c\approx0.113828$',color=orange,rotation=90,va='bottom',fontsize=9)
    axes[1].set(xlabel=r'Linear modulus ratio $\kappa=K/N$',ylabel='Limiting density (bits / qubit)',title='B  Centered residue, p = 1/4',xlim=(0,.22),ylim=(.296,.343))
    axes[1].legend(loc='upper left',fontsize=8)
    fs=np.linspace(.2,.42,400)
    rates=np.array([effective_rate(f,.25) for f in fs])
    axes[2].plot(fs,rates,color=navy,lw=2,label=r'$J_p(f)=\alpha(f)+4D(f\Vert p)$')
    axes[2].axvline(.25,color=gray,ls=':',label='Norm-dominant filling p')
    axes[2].axvline(4/13,color=teal,ls='--',label='Moment-dominant filling 4/13')
    allowed=[.25,.35]
    axes[2].scatter(allowed,[effective_rate(f,.25) for f in allowed],color=orange,s=38,zorder=5,label=r'Retained grid, $\kappa=0.10$')
    axes[2].set(xlabel='Retained excitation fraction f',ylabel='Effective fourth-moment rate (bits)',title='C  Rare sectors select the moment',xlim=(.2,.42),ylim=(.29,.50))
    axes[2].legend(loc='upper left',fontsize=7.8,frameon=True,facecolor='white',edgecolor='none',framealpha=.92)
    for ax in axes:ax.grid(alpha=.15)
    fig.savefig(ROOT/'figures'/'resolution_law.png')
    fig.savefig(ROOT/'figures'/'resolution_law.pdf')
    plt.close(fig)
    # Keep machine-readable inputs. These are illustrations of a proved formula.
    rows=[{'kappa':float(k),'density':float(v[0]),'dominant_offset':v[1],'dominant_filling':v[2]}
          for k,v in zip(kappas,vals)]
    (ROOT/'results'/'phase_curve.json').write_text(json.dumps({'status':'numerical illustration of exact limiting formula','p':.25,'rows':rows},indent=2)+'\n')
    print('Wrote resolution_law.png, resolution_law.pdf, and phase_curve.json')


if __name__=='__main__':main()
