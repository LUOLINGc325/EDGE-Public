#!/usr/bin/env python3
"""Finite numerical diagnostics for the path-value recovery theorem.

Only the simulator receives GLV parameters. recover() receives time nodes and
relative abundances. Gaussian quadrature and floating-point SVD are numerical
diagnostics, not certified integral evaluation or a substitute for the proof.
"""
from __future__ import annotations
import argparse
import json
from pathlib import Path
import numpy as np
from numpy.polynomial.legendre import leggauss
from scipy.integrate import solve_ivp
from scipy.optimize import minimize


def segment_nodes(t, p, order=8):
    a, w = leggauss(order)
    a = (a + 1) / 2
    w = w / 2
    dt = np.diff(t)
    dp = np.diff(p, axis=0)
    tq = t[:-1, None] + dt[:, None] * a
    pq = p[:-1, None, :] + a[None, :, None] * dp[:, None, :]
    return a, w, dt, dp, tq, pq


def lifted_matrix(t, p, windows=18, order=8):
    n = p.shape[1]
    m = n - 1
    pairs = [(i, j) for i in range(m) for j in range(i + 1, m)]
    a, w, dt, dp, tq, pq = segment_nodes(t, p, order)
    dl = dp[:, None, :m] / pq[:, :, :m] - dp[:, None, -1:] / pq[:, :, -1:]
    oneform = np.einsum('q,sqk,sqi->sik', w, pq, dl)
    ordinary = dt[:, None] * (p[:-1] + p[1:]) / 2
    cuts = np.linspace(0, len(dt), windows + 1).round().astype(int)
    rows = []
    for lo, hi in zip(cuts[:-1], cuts[1:]):
        I = oneform[lo:hi].sum(axis=0)
        J = ordinary[lo:hi].sum(axis=0)
        for pair_index, (i, j) in enumerate(pairs):
            row = np.zeros(m * n + len(pairs) * n)
            row[j*n:(j+1)*n] += I[i]
            row[i*n:(i+1)*n] -= I[j]
            offset = m*n + pair_index*n
            row[offset:offset+n] = -J
            rows.append(row)
    return np.asarray(rows), pairs


def recover(t, p, windows=18, order=8):
    """Recovery from path values alone; no true derivatives or parameters."""
    t = np.asarray(t, dtype=float)
    p = np.asarray(p, dtype=float)
    if np.min(p) <= 0 or not np.allclose(p.sum(axis=1), 1):
        raise ValueError('Input must be a strictly positive composition.')
    n = p.shape[1]
    m = n - 1
    K, pairs = lifted_matrix(t, p, windows, order)
    _, singular, vt = np.linalg.svd(K, full_matrices=False)
    v = vt[-1]
    U = v[:m*n].reshape(m, n)
    C = v[m*n:].reshape(len(pairs), n)
    H = []
    for i, j in pairs:
        for k in range(n):
            row = np.zeros(m)
            row[i] = U[j, k]
            row[j] = -U[i, k]
            H.append(row)
    a = np.linalg.lstsq(np.asarray(H), C.ravel(), rcond=None)[0]
    nodes, weights, dt, dp, tq, pq = segment_nodes(t, p, order)
    dl = dp[:, None, :m]/pq[:, :, :m] - dp[:, None, -1:]/pq[:, :, -1:]

    def compute_path(U):
        u = np.einsum('sqk,ik->sqi', pq, U)
        u2 = np.sum(u*u, axis=2)
        dtau = np.sum(u * (dl-a[None,None,:]*dt[:,None,None]), axis=2)/u2
        tau_increment = np.einsum('q,sq->s', weights, dtau)
        j_increment = np.einsum('q,sq,sqk->sk', weights, dtau, pq)
        return u2, dtau, tau_increment, j_increment

    u2, dtau, tau_inc, j_inc = compute_path(U)
    if tau_inc.sum() < 0:
        U = -U
        C = -C
        v = -v
        u2, dtau, tau_inc, j_inc = compute_path(U)
    J = np.vstack([np.zeros(n), np.cumsum(j_inc, axis=0)])
    tau = np.r_[0., np.cumsum(tau_inc)]
    # Within each segment, integrate the same one-form to each quadrature node.
    Jq = np.empty_like(pq)
    for j, end in enumerate(nodes):
        partial_nodes = end * nodes
        ppart = p[:-1,None,:] + partial_nodes[None,:,None]*dp[:,None,:]
        dlp = end * (dp[:,None,:m]/ppart[:,:,:m]-dp[:,None,-1:]/ppart[:,:,-1:])
        upart = np.einsum('sqk,ik->sqi', ppart, U)
        dta = np.sum(upart*(dlp-a[None,None,:]*dt[:,None,None]*end),axis=2)/np.sum(upart*upart,axis=2)
        Jq[:,j,:] = J[:-1] + np.einsum('q,sq,sqk->sk', weights,dta,ppart)
    g = np.concatenate([np.ones(tq.shape+(1,)), (tq-t[0])[:,:,None], Jq],axis=2)
    measure = dt[:,None]*weights[None,:]/pq[:,:,-1]
    moment = np.einsum('q,sq,sqi->i',weights,dtau,g)
    gram = np.einsum('sq,sqi,sqj->ij',measure,g,g)
    eig, vec = np.linalg.eigh(gram)
    if eig[0] <= 0:
        raise ValueError('Convex feature Gram is numerically singular.')
    W = (vec/np.sqrt(eig)) @ vec.T
    z = g @ W
    zmoment = W @ moment
    def evaluate(phi, hessian=False):
        arg = z @ phi
        if np.max(arg) > 690:
            return (np.inf, np.full_like(phi,np.nan)) if not hessian else np.eye(len(phi))*np.inf
        e = np.exp(arg)*measure
        if hessian:
            return np.einsum('sq,sqi,sqj->ij',e,z,z)
        return float(e.sum()-phi@zmoment), np.einsum('sq,sqi->i',e,z)-zmoment
    theta0 = np.zeros(n+2)
    theta0[0] = np.log(max(tau[-1],1e-15)/measure.sum())
    phi0 = np.linalg.solve(W,theta0)
    fit = minimize(lambda q:evaluate(q),phi0,jac=True,hess=lambda q:evaluate(q,True),method='trust-exact',options={'gtol':1e-11,'maxiter':300})
    theta = W @ fit.x
    r = np.r_[theta[1]+a, theta[1]]
    A = np.vstack([theta[2:]+U,theta[2:]])
    gn = np.column_stack([np.ones(len(t)),t-t[0],J])
    xref = np.exp(gn@theta)
    x = p * (xref/p[:,-1])[:,None]
    return {'r':r,'A':A,'x':x,'U':U,'a':a,'theta':theta,
            'kernel_singular_values':singular,'gram_eigenvalues':eig,
            'min_u_norm':float(np.sqrt(np.min(u2))),
            'gradient_norm_whitened':float(np.linalg.norm(evaluate(fit.x)[1])),
            'optimization_success':bool(fit.success),'optimization_message':str(fit.message),
            'tau_total':float(tau[-1]),'min_tau_increment':float(np.min(tau_inc))}


def simulate(r,A,x0,t):
    solution=solve_ivp(lambda tt,xx:xx*(r+A@xx),(t[0],t[-1]),x0,t_eval=t,method='DOP853',rtol=3e-13,atol=1e-14)
    if not solution.success:
        raise RuntimeError(solution.message)
    x=solution.y.T
    return x,x/x.sum(axis=1)[:,None]


def diagnostic(r,A,x0,T,steps,noise,seed):
    t=np.linspace(0,T,steps+1)
    x,p=simulate(r,A,x0,t)
    pn=p.copy()
    if noise:
        rng=np.random.default_rng(seed)
        err=rng.uniform(-1,1,size=p.shape)
        err-=err.mean(axis=1)[:,None]
        err*=noise/np.max(np.linalg.norm(err,axis=1))
        pn+=err
    fit=recover(t,pn)
    B=A[:-1]-A[-1]
    avec=r[:-1]-r[-1]
    C=np.asarray([avec[i]*B[j]-avec[j]*B[i] for i in range(len(avec)) for j in range(i+1,len(avec))])
    kappa=1/np.linalg.norm(np.r_[B.ravel(),C.ravel()])
    return {'steps':steps,'mesh':T/steps,'noise_bound':noise,'seed':seed,
            'min_true_composition':float(p.min()),
            'r_error':float(np.linalg.norm(fit['r']-r)),
            'scaled_A_error':float(np.linalg.norm(fit['A']-kappa*A)),
            'scaled_state_sup_error':float(np.max(np.linalg.norm(fit['x']-x/kappa,axis=1))),
            'kernel_gap':float(fit['kernel_singular_values'][-2]),
            'kernel_residual':float(fit['kernel_singular_values'][-1]),
            'convex_gram_min_eigenvalue':float(fit['gram_eigenvalues'][0]),
            'min_u_norm':fit['min_u_norm'],
            'gradient_norm_whitened':fit['gradient_norm_whitened'],
            'optimization_success':fit['optimization_success'],
            'optimization_message':fit['optimization_message']}


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--output',type=Path,default=Path(__file__).resolve().parents[1]/'results/path_diagnostics.json')
    parser.add_argument('--quick',action='store_true')
    args=parser.parse_args()
    A=np.array([[-.12,-1.1,.9],[.9,-.15,-1.0],[-1.0,.9,-.1]])
    r=-A@np.ones(3)
    x0=np.array([.25,2.0,1.2])
    T=16.
    settings=[(1600,0.,731),(3200,0.,731)] if args.quick else [(1600,0.,731),(3200,0.,731),(6400,0.,731),(1600,1e-4,731),(3200,2.5e-5,731),(6400,6.25e-6,731)]
    rows=[diagnostic(r,A,x0,T,*s) for s in settings]
    result={'kind':'finite floating-point diagnostics, not proof or biological validation','model':{'r':r.tolist(),'A':A.tolist(),'x0':x0.tolist(),'T':T},'input_boundary':'recover receives only sample times and positive relative abundance values; simulator values are used only afterward to measure errors','norms':'noise_bound is the maximum Euclidean node error; r uses Euclidean norm, A Frobenius norm, and state the maximum Euclidean node error','quadrature':'8-point Gauss-Legendre on observed polygonal segments; not interval-certified; reported Gram is weighted by 1/p_n','rows':rows}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps(result,indent=2))


if __name__=='__main__':
    main()
