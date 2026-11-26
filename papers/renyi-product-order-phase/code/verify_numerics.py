#!/usr/bin/env python3
"""Reproducible diagnostics for the Renyi product-order phase manuscript.

Numerical results do not certify continuum optimization or asymptotic theorems.
The exact Fraction checks are explicitly separated from floating diagnostics.
"""
from __future__ import annotations

import argparse
from fractions import Fraction
from itertools import product
import json
import math
from pathlib import Path

import numpy as np
from scipy.optimize import brentq, minimize_scalar
from scipy.special import gammaln, logsumexp, log_ndtr


def log_softplus(x):
    x = np.asarray(x, dtype=float)
    out = np.empty_like(x)
    lo = x < -35
    out[lo] = x[lo]
    out[~lo] = np.log(np.logaddexp(0, x[~lo]))
    return out


def log_one_minus_exp_minus_exp(v):
    v = np.asarray(v, dtype=float)
    out = np.empty_like(v)
    lo, hi = v < -35, v > 4
    out[lo] = v[lo]
    out[hi] = np.log1p(-np.exp(-np.exp(np.minimum(v[hi], 700))))
    mid = ~(lo | hi)
    out[mid] = np.log(-np.expm1(-np.exp(v[mid])))
    return out


def bsc_law(n, p):
    k = np.arange(n + 1, dtype=float)
    logp = gammaln(n + 1) - gammaln(k + 1) - gammaln(n - k + 1)
    logp += k * math.log(p) + (n - k) * math.log1p(-p)
    logp -= logsumexp(logp)
    # Z_n = log(Q^n/P^n), where P emits a correct symbol with 1-p.
    z = (2 * k - n) * math.log((1 - p) / p)
    return logp, z


def nonlattice_law(n):
    # P=(1/3,1/6,3/8,1/8), Q swaps each adjacent pair.
    # log-likelihood support = {+-log 2,+-log 3}, nonarithmetic.
    probs = np.array([1 / 3, 1 / 6, 3 / 8, 1 / 8])
    zz = np.array([-math.log(2), math.log(2), -math.log(3), math.log(3)])
    logs, vals = [], []
    for k0 in range(n + 1):
        for k1 in range(n - k0 + 1):
            k2 = np.arange(n - k0 - k1 + 1)
            k3 = n - k0 - k1 - k2
            ll = gammaln(n + 1) - gammaln(k0 + 1) - gammaln(k1 + 1)
            ll = ll - gammaln(k2 + 1) - gammaln(k3 + 1)
            ll += k0 * np.log(probs[0]) + k1 * np.log(probs[1])
            ll += k2 * np.log(probs[2]) + k3 * np.log(probs[3])
            logs.append(ll)
            vals.append(k0 * zz[0] + k1 * zz[1] + k2 * zz[2] + k3 * zz[3])
    logp, z = np.concatenate(logs), np.concatenate(vals)
    logp -= logsumexp(logp)
    return logp, z, probs, zz


def log_L(U, logb, logp, z):
    if not U > 0:
        return float('inf')
    loga = U + math.log(-math.expm1(-U))
    v = logb + log_softplus(loga + z)
    # Evaluate A for large L and its complement for small L, avoiding 1-A.
    t = np.exp(np.minimum(v, 700))
    logA = float(logsumexp(logp - t))
    if logA < -0.1:
        return math.log(-logA)
    logB = float(logsumexp(logp + log_one_minus_exp_minus_exp(v)))
    if logB < -35:
        return logB
    return math.log(-math.log1p(-math.exp(logB)))


def optimize(logb, logp, z, n, r=0):
    left = -min(700.0, max(18.0, 0.5*max(logb-float(np.max(np.abs(z))), 0)+20))
    right = math.log(max(20, 3 * float(np.max(np.abs(z))) + 10))
    grid = np.linspace(left, right, 601)

    def f(v):
        U = math.exp(v)
        return log_L(U, logb, logp, z) - logb - v

    vals = np.array([f(v) for v in grid])
    idx = [i for i in range(1, len(grid) - 1)
           if vals[i] <= vals[i - 1] and vals[i] <= vals[i + 1]]
    candidates = [(float(vals[0]), float(grid[0])), (float(vals[-1]), float(grid[-1]))]
    for i in idx:
        res = minimize_scalar(f, bounds=(grid[i-1], grid[i+1]), method='bounded',
                              options={'xatol': 2e-11})
        candidates.append((float(res.fun), float(res.x)))
    score, v = min(candidates)
    U = math.exp(v)
    return {'n': n, 'log_b': logb, 'U': U, 'q': math.exp(-U), 'log_gap': score,
            'local_minima_detected': len(idx), 'optimizer_claim': 'numerical_grid_and_local_refinement_only'}


def lattice_constant(p, b, parity, U):
    m = math.log((1-p)/p)
    h = 2*m
    phase = m if parity else 0.0
    loga = U + math.log(-math.expm1(-U))
    # z is log(Q/P); direct kernel avoids sign conventions in the Fourier form.
    k = np.arange(-max(200, int(100/h)), max(200, int(100/h)) + 1)
    z = phase + h*k
    v = math.log(b) + log_softplus(loga + z)
    logs = -z/2 + log_one_minus_exp_minus_exp(v)
    logH = math.log(h) + float(logsumexp(logs))
    return math.exp(logH - math.log(b*U*m*math.sqrt(2*math.pi)))


def exact_checks():
    p=Fraction(1,5)
    counts={'row_pair_checks':0,'strict_hamming_checks':0,'scalar_identity_checks':0}
    cert=[]
    for n in range(1,5):
        words=list(product((0,1),repeat=n))
        def row(x):
            return [math.prod(p if xx!=yy else 1-p for xx,yy in zip(x,y)) for y in words]
        rows={x:row(x) for x in words}
        for q in [Fraction(1,5),Fraction(1,2),Fraction(4,5)]:
            a=(1-q)/q
            by_m={}
            for x in words:
                for y in words:
                    m=sum(xx!=yy for xx,yy in zip(x,y))
                    A=sum(px*px/(px+a*qx) for px,qx in zip(rows[x],rows[y]))
                    if m in by_m and by_m[m]!=A:
                        raise AssertionError('Hamming reduction failed')
                    by_m[m]=A; counts['row_pair_checks']+=1
            ordered=[by_m[i] for i in range(n+1)]
            if any(ordered[i]>=ordered[i+1] for i in range(n)):
                raise AssertionError('Strict repeat monotonicity failed')
            counts['strict_hamming_checks']+=n
            cert.append({'n':n,'q':str(q),'A_by_hamming':[str(x) for x in ordered]})
    for w in [Fraction(1,5),Fraction(1,2),Fraction(4,5)]:
        for a,x,y in product([Fraction(1,3),Fraction(2),Fraction(5)], repeat=3):
            mu=w*x+(1-w)*y
            lhs=w/(1+a*x)+(1-w)/(1+a*y)-1/(1+a*mu)
            rhs=a*a*w*(1-w)*(x-y)**2/((1+a*x)*(1+a*y)*(1+a*mu))
            if lhs!=rhs or lhs<0:
                raise AssertionError('Reciprocal convexity identity failed')
            counts['scalar_identity_checks']+=1
    return {'arithmetic':'fractions.Fraction, exact','counts':counts,'certificates':cert,
            'scope':'Finite checks only; no asymptotic or all-parameter theorem is certified by these counts.'}


def main():
    parser=argparse.ArgumentParser();parser.add_argument('--out',type=Path,default=Path('results/numerics.json'))
    args=parser.parse_args();args.out.parent.mkdir(parents=True,exist_ok=True)
    qstar=math.exp(-brentq(lambda u:0.5*u+math.expm1(-u),0.01,5))
    out={'method':'Stable finite binomial/multinomial sums; floating diagnostics are not rigorous certificates.',
         'qstar':qstar,'exact':exact_checks(),'fixed_bsc':[],'nonlattice':[],'phase':[],'critical':[]}
    p=.2;M=math.log((1-p)/p);D=(1-2*p)*M;C=-math.log(2*math.sqrt(p*(1-p)))
    sigma=2*M*math.sqrt(p*(1-p));ell=-math.log(1-p)
    def psi(t):return float(logsumexp([math.log(1-p)-t*M,math.log(p)+t*M]))
    for b in [1,2,4]:
        for n in [40,41,100,101,240,241]:
            logp,z=bsc_law(n,p);v=optimize(math.log(b),logp,z,n)
            v['alpha']=b+1;v['scaled_gap']=math.exp(v['log_gap']+n*C+0.5*math.log(n))
            v['lattice_predicted']=lattice_constant(p,b,n%2,v['U'])
            out['fixed_bsc'].append(v)
    for n in [20,40,70]:
        logp,z,P,zz=nonlattice_law(n);Q=P[[1,0,3,2]];rho=np.sqrt(P*Q);zz0=rho.sum();R=rho/zz0
        sig=math.sqrt(float(np.dot(R,zz*zz)));cn=-math.log(zz0);b=2
        v=optimize(math.log(b),logp,z,n)
        v['scaled_gap']=math.exp(v['log_gap']+n*cn+0.5*math.log(n))
        Ustar=-math.log(qstar);astar=math.expm1(Ustar)
        v['nonlattice_predicted']=math.sqrt(2)*math.exp(gammaln(b+.5)-gammaln(b+1))/sig*math.sqrt(astar)/Ustar
        out['nonlattice'].append(v)
    for r in [.3,1.0,M,1.7]:
        for n in [40,100,240,500]:
            logp,z=bsc_law(n,p);v=optimize(n*r,logp,z,n,r)
            v['r']=r;v['rate_estimate']=-v['log_gap']/n
            if D<r<M:
                beta=brentq(lambda x:psi(-x)/x-r,1e-7,100)
                v['b_gap']=math.exp(v['log_gap']+n*r);v['predicted_b_gap']=beta
            elif r==M:
                v['endpoint_scaled']=math.exp(v['log_gap']+n*M)*math.log(n)/(n*ell)
            elif r>M:
                v['infinity_scaled']=math.exp(v['log_gap']+n*M)
            out['phase'].append(v)
    for zeta in [-1,0,1]:
        res=minimize_scalar(lambda t:-float(log_ndtr(-zeta-t))/t,bounds=(.01,15),method='bounded')
        for n in [40,100,240,500]:
            logb=n*D+zeta*sigma*math.sqrt(n);logp,z=bsc_law(n,p)
            v=optimize(logb,logp,z,n,logb/n);v['zeta']=zeta
            v['scaled_gap']=math.exp(v['log_gap']+logb)*sigma*math.sqrt(n)
            v['predicted']=float(res.fun);v['t']=v['U']/(sigma*math.sqrt(n));v['tstar']=float(res.x)
            out['critical'].append(v)
    out['parameters']={'p':p,'C':C,'D':D,'M':M,'sigma_P':sigma,'ell':ell}
    args.out.write_text(json.dumps(out,indent=2,allow_nan=False)+'\n')
    print(json.dumps({'output':str(args.out),'exact_counts':out['exact']['counts'],
                      'floating_cases':sum(len(out[k]) for k in ['fixed_bsc','nonlattice','phase','critical'])}))


if __name__=='__main__':main()
