#!/usr/bin/env python3
"""Independent numerical checks and figures; no numerical proof claims."""
from __future__ import annotations

import argparse
import json
import platform
from pathlib import Path
import numpy as np
import scipy
from scipy.special import gammaln
import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def clock(gamma, n):
    s = np.ones(n+1)
    u = np.ones(n+1)
    p = np.zeros(n+1)
    for k in range(1, n+1):
        p[k] = gamma*s[k-1]/k
        s[k] = (1-gamma/k)*s[k-1]
        u[k] = (k-1+gamma)*u[k-1]/k
    return s, u, p


def scalar_example(gamma, c, n):
    """Direct age-chain evolution, vectorised; no renewal resolvent used."""
    s, u, _ = clock(gamma, n)
    xstar = (1-c)/(1+c-c*2**gamma)
    amplitude = c*(2**gamma-2)*xstar/(1+c)
    masses = np.zeros(n+1)
    moments = np.zeros(n+1)
    masses[0], moments[0] = 1, xstar
    states = np.empty(n+1)
    states[0] = xstar
    hazards = gamma/np.arange(1, n+2)
    max_mass_error = 0.
    for t in range(n):
        h = hazards[:t+1]
        m0 = h @ masses[:t+1]
        x0 = h @ (c*moments[:t+1]+(1-c)*masses[:t+1])
        masses[1:t+2] = (1-h)*masses[:t+1]
        moments[1:t+2] = -(1-h)*moments[:t+1]
        masses[0], moments[0] = m0, x0
        states[t+1] = np.sum(moments[:t+2])
        max_mass_error = max(max_mass_error, abs(np.sum(masses[:t+2])-1))
    # Scalar complete-reset multiplier from its separate exact recurrence.
    f = np.convolve(s * (-1.)**np.arange(n+1), u)[:n+1]
    errors = states-xstar*f
    predicted = amplitude*s*(-1.)**np.arange(n+1)
    require(max_mass_error < 2e-11, "mass drift")
    require(np.max(np.abs(states)) <= 1+1e-11, "Bloch positivity")
    ratio = errors[-1]/predicted[-1]
    require(abs(ratio-1) < 0.08, "sharpness leading term not approached")
    return {"gamma": gamma, "c": c, "horizon": n,
            "effective_x": xstar, "leading_amplitude": amplitude,
            "max_mass_error": max_mass_error,
            "last_error_over_prediction": ratio,
            "last_trace_norm_error": abs(errors[-1]),
            "last_scaled_trace_norm_error": n**gamma*abs(errors[-1]),
            "asymptotic_scaled_error": abs(amplitude)*np.exp(-gammaln(1-gamma))}, errors, predicted


def quarter_turn(gamma, n):
    """No contracting history: two noncommuting unitary Bloch rotations."""
    tmat = np.array([[0.,-1.,0.],[1.,0.,0.],[0.,0.,1.]])
    amat = np.array([[1.,0.,0.],[0.,0.,-1.],[0.,1.,0.]])
    x0 = np.array([1.,0.,0.])
    s, u, p = clock(gamma,n)
    powers = np.array([np.linalg.matrix_power(tmat,j) for j in range(4)])
    kernels = np.zeros((n+1,3,3))
    for ell in range(1,n+1):
        kernels[ell]=p[ell]*amat@powers[(ell-1)%4]
    v=np.zeros((n+1,3)); v[0]=x0
    for k in range(1,n+1):
        v[k]=np.einsum("lij,lj->i",kernels[1:k+1],v[k-1::-1])
    states=np.zeros((n+1,3))
    for residue in range(4):
        a=np.zeros(n+1); a[residue::4]=s[residue::4]
        for j in range(3):
            conv=np.convolve(a,v[:,j])[:n+1]
            states += conv[:,None]*powers[residue][:,j][None,:]
    eigenvalues, vectors=np.linalg.eig(tmat.astype(complex))
    inverse=np.linalg.inv(vectors)
    projectors=[np.outer(vectors[:,j],inverse[j,:]) for j in range(3)]
    leading=np.zeros((n+1,3),complex)
    coefficients=[]
    for eigenvalue,q in zip(eigenvalues,projectors):
        w=1/eigenvalue
        # Keep the principal branch reached from inside the unit disc.
        kernel=sum(amat@proj*((1-(1-w*lam)**gamma)/lam)
                   for lam,proj in zip(eigenvalues,projectors))
        h=np.linalg.inv(np.eye(3)-kernel)
        d=q@h@x0
        coefficients.append({"eigenvalue":[float(eigenvalue.real),float(eigenvalue.imag)],
                             "coefficient":[[float(z.real),float(z.imag)] for z in d]})
        leading += s[:,None]*(eigenvalue**np.arange(n+1))[:,None]*d[None,:]
    require(np.max(np.abs(leading.imag))<1e-9,"real state prediction")
    predicted=leading.real
    residual=np.linalg.norm(states-predicted,axis=1)
    require(np.max(np.linalg.norm(states,axis=1))<=1+1e-10,"unitary mixture positivity")
    require(residual[-1]<0.08*np.linalg.norm(predicted[-1]),"quarter-turn asymptotic mismatch")
    # Independent direct-age implementation, short horizon only.
    m=np.array([1.]); a=np.array([x0]); max_gap=0.
    for k in range(min(64,n)):
        h=gamma/np.arange(1,k+2)
        nm=np.empty(k+2); na=np.empty((k+2,3))
        nm[0]=h@m; nm[1:]=(1-h)*m
        na[0]=amat@(h@a); na[1:]=(1-h)[:,None]*(a@tmat.T)
        m,a=nm,na
        max_gap=max(max_gap,float(np.linalg.norm(a.sum(axis=0)-states[k+1])))
    require(max_gap<1e-12,"independent quarter-turn age check")
    return {"gamma":gamma,"horizon":n,"leading_coefficients":coefficients,
            "independent_age_horizon":min(64,n),"independent_age_max_gap":max_gap,
            "last_trace_norm":float(np.linalg.norm(states[-1])),
            "last_remainder_norm":float(residual[-1]),
            "word_contraction":False,
            "W_justification":"Unitary quarter turns have no common traceless eigenvector with the same eigenvalue; proven in manuscript."},states,predicted


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--output",type=Path,default=Path(__file__).resolve().parent.parent)
    parser.add_argument("--horizon",type=int,default=4096)
    args=parser.parse_args(); root=args.output; n=args.horizon
    (root/"results").mkdir(parents=True,exist_ok=True)
    (root/"figures").mkdir(parents=True,exist_ok=True)
    fig,axs=plt.subplots(1,2,figsize=(10.6,4.2),layout="constrained")
    summaries=[]
    for gamma,color in zip([.25,.5,.75],["#227e8c","#c36a31","#7352a0"]):
        summary,err,pred=scalar_example(gamma,.5,n)
        summaries.append(summary)
        times=np.arange(1,n+1)
        use=times>=8
        axs[0].loglog(times[use],abs(err[1:][use]),color=color,label=rf"$\gamma={gamma}$")
        axs[0].loglog(times[use],abs(pred[1:][use]),"--",color=color,lw=1)
    qsum,states,qpred=quarter_turn(.5,n)
    times=np.arange(1,n+1)
    axs[1].semilogx(times,np.sqrt(times)*np.linalg.norm(states[1:],axis=1),color="#227e8c",label="Direct renewal evolution")
    axs[1].semilogx(times,np.sqrt(times)*np.linalg.norm(qpred[1:],axis=1),"--",color="#c36a31",label="Proved leading term")
    axs[0].set(title="Noncommuting sharpness example",xlabel="Laboratory steps t",ylabel="Trace norm of reduction error")
    axs[1].set(title="Unitary jumps: no contracting history",xlabel="Laboratory steps t",ylabel=r"$\sqrt{t}\,\|\rho_t-I/2\|_1$")
    for ax in axs:
        ax.grid(alpha=.2);ax.legend(frameon=False,fontsize=9)
    fig.savefig(root/"figures/rate_comparison.pdf")
    fig.savefig(root/"figures/rate_comparison.png",dpi=180)
    report={"schema_version":1,"status":"passed","arithmetic":"floating point; diagnostic only",
            "scalar_examples":summaries,"quarter_turn":qsum,
            "scope":"Finite numerical corroboration, not proof of limits, (W), or optimality."}
    (root/"results/numerical_checks.json").write_text(json.dumps(report,indent=2,sort_keys=True)+"\n")
    environment={"python":platform.python_version(),"numpy":np.__version__,"scipy":scipy.__version__,"matplotlib":matplotlib.__version__}
    (root/"results/environment.json").write_text(json.dumps(environment,indent=2,sort_keys=True)+"\n")
    print(json.dumps({"status":"passed","horizon":n,"scalar_ratios":[x["last_error_over_prediction"] for x in summaries],"quarter_turn_age_gap":qsum["independent_age_max_gap"],"quarter_turn_remainder":qsum["last_remainder_norm"]},indent=2))


if __name__=="__main__":
    main()
