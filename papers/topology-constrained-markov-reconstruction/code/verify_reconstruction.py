"""Reproduce deterministic numerical illustrations of the proved graph theorem.

Run: python code/verify_reconstruction.py
Outputs: results/reconstruction.json and figures/reconstruction.{png,pdf}
No external data, stochastic services, or network calls. All noise is synthetic.
"""
from __future__ import annotations
import json, math, platform
from pathlib import Path
import numpy as np
import scipy
from scipy.linalg import expm, logm
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
from reconstruct import (generator_from_rates, commutator_system, reconstruct,
                         noise_certificate, entropy_production)

ROOT=Path(__file__).resolve().parents[1]
SEED=20261124


def directed(edges):return [(i,j) for a,b in edges for i,j in ((a,b),(b,a))]

def cycle(n):return [(i,(i+1)%n) for i in range(n)]


def spectral_separation(p):
    vals=np.linalg.eigvals(p)
    return float(min(abs(vals[i]-vals[j]) for i in range(len(vals)) for j in range(i)))


def models():
    ring=cycle(5)
    ring_rates=np.array([r for pair in zip([2.0,1.2,2.2,1.6,2.6],[.5,.6,.4,.7,.3]) for r in pair])
    path=[(0,1),(1,2),(2,3),(3,4)]
    petersen=cycle(5)+[(i,i+5) for i in range(5)]+[(i+5,(i+2)%5+5) for i in range(5)]
    data=[("Heterogeneous C5",5,ring,ring_rates),
          ("Path on 5 states",5,path,np.array([.2+(7*k)%13/20 for k in range(8)])),
          ("Petersen network",10,petersen,np.array([.2+(7*k)%13/20 for k in range(30)]))]
    return [(name,n,edges,rates,generator_from_rates(n,directed(edges),rates)) for name,n,edges,rates in data]


def exact_data_row(name,n,edges,rates,q,delta):
    p=expm(delta*q)
    principal=np.asarray(logm(p))/delta
    principal_error=float(np.linalg.norm(principal-q,"fro")/np.linalg.norm(q,"fro"))
    mask=np.ones((n,n),dtype=bool);np.fill_diagonal(mask,False)
    for i,j in directed(edges):mask[i,j]=False
    row={"model":name,"delta":delta,"max_escape_rate":float(max(-np.diag(q))),
         "fast_sampling_sufficient_condition":bool(delta*max(-np.diag(q))<math.pi),
         "propagator_rowsum_residual":float(np.max(np.abs(p.sum(axis=1)-1))),
         "propagator_eigenvalue_min_separation_numerical":spectral_separation(p),
         "principal_log_relative_frobenius_error":principal_error,
         "principal_log_imaginary_frobenius_norm":float(np.linalg.norm(principal.imag)),
         "principal_log_forbidden_edge_frobenius_norm":float(np.linalg.norm(principal[mask])),
         "principal_log_min_allowed_real_rate":float(min(principal[i,j].real for i,j in directed(edges))),
         "true_entropy_rate":entropy_production(q,edges)}
    try:
        result=reconstruct(p,directed(edges),delta)
        row.update({"reconstruction_status":"computed",
                    "reconstruction_relative_frobenius_error":float(np.linalg.norm(result.generator-q,"fro")/np.linalg.norm(q,"fro")),
                    "reconstruction_rate_l2_error":float(np.linalg.norm(result.rates-rates)),
                    "sigma_min_augmented":float(result.singular_values[-1]),
                    "linear_residual":result.linear_residual,"exponential_residual":result.exponential_residual,
                    "minimum_reconstructed_rate":float(result.rates.min()),
                    "reconstructed_entropy_rate":entropy_production(result.generator,edges) if result.rates.min()>0 else None})
    except ValueError as exc:
        row.update({"reconstruction_status":"numerically_unresolved","reason":str(exc)})
    return row


def noise_row(model,delta,epsilon):
    name,n,edges,rates,q=model
    p=expm(delta*q)
    rng=np.random.default_rng(SEED)
    e=rng.normal(size=(n,n));e-=e.mean(axis=1,keepdims=True)
    e*=epsilon/np.linalg.norm(e,2)
    observed=p+e
    row={"model":name,"delta":delta,"epsilon":epsilon,"actual_operator_error":float(np.linalg.norm(e,2)),
         "minimum_observed_entry":float(observed.min()),"rowsum_residual":float(np.max(abs(observed.sum(axis=1)-1)))}
    try:
        result=reconstruct(observed,directed(edges),delta)
        cert=noise_certificate(observed,directed(edges),delta,epsilon)
        err=float(np.linalg.norm(result.rates-rates))
        row.update({"status":"computed","rate_l2_error":err,"certificate":cert,
                    "bound_satisfied_with_1e-10_roundoff_slack":None if cert['rate_l2_bound'] is None else bool(err<=cert['rate_l2_bound']+1e-10)})
    except ValueError as exc:row.update({"status":"numerically_unresolved","reason":str(exc)})
    return row


def alias_example():
    n=6;edges=cycle(n);delta=1.0
    a0,b0=5.5,4.5;step=2*math.pi/math.sqrt(3)
    a1,b1=a0+step,b0-step
    rates0=np.tile([a0,b0],n);rates1=np.tile([a1,b1],n)
    q0=generator_from_rates(n,directed(edges),rates0)
    q1=generator_from_rates(n,directed(edges),rates1)
    p0,p1=expm(q0),expm(q1)
    result={"n":n,"delta":delta,"a0":a0,"b0":b0,"a1":a1,"b1":b1,
            "analytic_shift":"a1=a0+2*pi/sqrt(3), b1=b0-2*pi/sqrt(3)",
            "propagator_difference_frobenius":float(np.linalg.norm(p0-p1,"fro")),
            "min_eigenvalue_separation_numerical":spectral_separation(p0),
            "entropy_rate_0":entropy_production(q0,edges),"entropy_rate_1":entropy_production(q1,edges),
            "entropy_analytic_0":(a0-b0)*math.log(a0/b0),"entropy_analytic_1":(a1-b1)*math.log(a1/b1),
            "principal_log_error_to_q0":float(np.linalg.norm(logm(p0)-q0,"fro")),
            "principal_log_error_to_q1":float(np.linalg.norm(logm(p0)-q1,"fro")),
            "proof":"Fourier modes have imaginary shifts 0 or +/-2*pi, so exponentials coincide exactly. Their modulus classes are 1, exp(-5), exp(-15), exp(-20); paired phases are +/-sqrt(3)/2, so the six eigenvalues are distinct.",
            "boundary":"Both generators are on the same homogeneous six-cycle, have strictly positive bidirectional rates, and have different entropy production. They are outside the rigidity class."}
    assert result['propagator_difference_frobenius']<1e-12
    assert b1>0 and result['entropy_rate_1']>result['entropy_rate_0']
    assert result['min_eigenvalue_separation_numerical']>0
    return result


def main():
    (ROOT/'results').mkdir(exist_ok=True);(ROOT/'figures').mkdir(exist_ok=True)
    mm=models();lags=[.1,.25,.5,.75,1.,1.25,1.5,2.,2.5,3.,4.]
    rows=[exact_data_row(*model,d) for model in mm for d in lags]
    noise=[noise_row(mm[0],d,1e-8) for d in [.1,.25,.5,.75,1.,1.25,1.5,2.,2.5,3.,4.]]
    alias=alias_example()
    # Concrete verification gates, rather than treating the illustrations as proof.
    usable=[r for r in rows if r['reconstruction_status']=='computed' and r['delta']<=2]
    assert usable and max(r['reconstruction_relative_frobenius_error'] for r in usable)<1e-7
    assert any(not r['fast_sampling_sufficient_condition'] for r in usable)
    assert all(r['bound_satisfied_with_1e-10_roundoff_slack'] is not False for r in noise if r['status']=='computed')
    report={"schema_version":1,"seed":SEED,"convention":"row generator: Q*1=0; row transition matrix P=expm(delta*Q)",
            "environment":{"python":platform.python_version(),"numpy":np.__version__,"scipy":scipy.__version__,"matplotlib":matplotlib.__version__},
            "models":[{"name":name,"states":n,"undirected_edges":edges,"directed_edge_order":directed(edges),"rates":rates.tolist()} for name,n,edges,rates,q in mm],
            "exact_data_illustrations":rows,"synthetic_noise_illustrations":noise,"six_cycle_alias":alias,
            "scope":{"universal_theorem_proved_by":"written graph/matrix arguments in manuscript",
                     "numerical_illustration_only":True,"interval_arithmetic_verified":False,
                     "noise_epsilon_is":"known synthetic operator-norm perturbation; not a confidence bound inferred from trajectories",
                     "simple_spectrum_numeric_values":"diagnostic only; exact theorem hypotheses are separate"}}
    (ROOT/'results'/'reconstruction.json').write_text(json.dumps(report,indent=2)+'\n')
    plt.rcParams.update({'font.size':10,'axes.titlesize':11,'axes.labelsize':10,'legend.fontsize':8,'figure.dpi':150})
    fig,axs=plt.subplots(2,2,figsize=(11.8,8.2))
    colors=['#17628f','#bd5d27','#4d7d3a']
    for model,color in zip(mm,colors):
        name=model[0];rr=[r for r in rows if r['model']==name and r['reconstruction_status']=='computed']
        xx=[r['delta'] for r in rr]
        axs[0,0].semilogy(xx,[max(1e-16,r['reconstruction_relative_frobenius_error']) for r in rr],color=color,marker='o',ms=3,label=name+' / support')
        axs[0,0].semilogy(xx,[max(1e-16,r['principal_log_relative_frobenius_error']) for r in rr],color=color,ls='--',lw=1.3,label=name+' / principal log')
        axs[0,1].semilogy(xx,[r['sigma_min_augmented'] for r in rr],color=color,marker='o',ms=3,label=name)
    axs[0,0].set(title='A  Exact-data reconstruction in floating point',xlabel='Sampling interval Δ',ylabel='Relative generator error (Frobenius)')
    axs[0,0].legend(loc='upper left',ncol=1)
    axs[0,1].set(title='B  Conditioning of the supported linear system',xlabel='Sampling interval Δ',ylabel='Smallest singular value of A(P)')
    axs[0,1].legend(loc='lower left')
    good=[r for r in noise if r['status']=='computed'];valid=[r for r in good if r['certificate']['rate_l2_bound'] is not None]
    axs[1,0].semilogy([r['delta'] for r in good],[r['rate_l2_error'] for r in good],'o-',color='#17628f',label='Observed rate error')
    axs[1,0].semilogy([r['delta'] for r in valid],[r['certificate']['rate_l2_bound'] for r in valid],'s--',color='#bd5d27',label='A posteriori upper bound')
    axs[1,0].set(title='C  Synthetic noise: heterogeneous C5, ε = 10⁻⁸',xlabel='Sampling interval Δ',ylabel='Directed-rate error (Euclidean norm)')
    axs[1,0].legend(loc='upper left')
    vals=[alias['entropy_rate_0'],alias['entropy_rate_1']]
    axs[1,1].bar(['Generator Q₀','Generator Q₁'],vals,color=['#17628f','#bd5d27'],width=.48)
    for i,y in enumerate(vals):axs[1,1].text(i,y+.4,f'{y:.6f}',ha='center',va='bottom',fontsize=10)
    axs[1,1].set(title='D  Exact six-cycle alias: same P, different dissipation',ylabel='Entropy production rate',ylim=(0,max(vals)*1.3))
    axs[1,1].text(.5,.96,'Δ = 1; all rates positive; P has simple spectrum',transform=axs[1,1].transAxes,ha='center',va='top',fontsize=8)
    for ax in axs.ravel():ax.grid(alpha=.2,axis='y');ax.spines['top'].set_visible(False);ax.spines['right'].set_visible(False)
    fig.text(.5,.012,'Numerical illustrations support, but do not replace, the written proofs. The noise bound assumes a separately justified ε.',ha='center',fontsize=9)
    fig.tight_layout(rect=(0,.035,1,1))
    fig.savefig(ROOT/'figures'/'reconstruction.png',dpi=220)
    fig.savefig(ROOT/'figures'/'reconstruction.pdf')
    plt.close(fig)
    print(json.dumps({'written':'results/reconstruction.json','exact_data_cases':len(rows),'noise_cases':len(noise),'max_relative_error_delta_le_2':max(r['reconstruction_relative_frobenius_error'] for r in usable),'alias':alias,'figures':['figures/reconstruction.png','figures/reconstruction.pdf']},indent=2))

if __name__=='__main__':main()
