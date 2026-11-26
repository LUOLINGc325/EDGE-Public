"""Numerical adversarial search for Wu 2611.24604v1 Conjecture 2 (rank one).

Original labels retained: H[i,(i+2)%5] = r_i (phase only at i=4).
Thus RHS uses cyclically adjacent original r labels, i.e. crossing chords.
Only PSD Gram matrices are evaluated: the whole H is scaled by -1/lambda_min(H).
"""
import json
import time
from pathlib import Path
import numpy as np
from scipy.optimize import differential_evolution, minimize

ROOT = Path(__file__).resolve().parent
rng = np.random.default_rng(202611246)

def make_h(r, theta):
    r = np.asarray(r)
    H = np.zeros((5,5), dtype=complex)
    for i in range(5):
        value = r[i] * (np.exp(1j*theta) if i==4 else 1)
        j = (i+2)%5
        H[i,j] = value
        H[j,i] = value.conjugate()
    return H

def evaluate(x, interior=False):
    r=np.exp(np.r_[x[:4],0.])
    theta=x[4]
    H=make_h(r,theta)
    ev=np.linalg.eigvalsh(H)
    scale=-1/ev[0] * (x[5] if interior else 1.)
    H*=scale
    r*=scale
    vals=1+scale*ev
    T=r*np.sqrt(np.maximum(0,1-r*r))
    products=T*np.roll(T,-1)
    rhs=np.max(products)
    lhs=vals[-1]-2
    ratio=lhs/rhs if rhs>1e-15 else -1e6
    return dict(x=np.asarray(x).tolist(),r=r.tolist(),theta=float(theta),scale=float(scale),eigenvalues=vals.tolist(),lhs=float(lhs),rhs=float(rhs),gap=float(lhs-rhs),ratio=float(ratio),products=products.tolist())

def objective(x,mode='ratio',interior=False):
    d=evaluate(x,interior)
    if mode=='gap': return -d['gap']
    if d['lhs']<1e-6: return 1+abs(d['lhs'])*1e3
    return -d['ratio']

def main():
    best=[]
    start=time.time()
    for theta_mode in ['positive','negative','complex']:
        for mode in ['ratio','gap']:
            for seed in range(5):
                bounds=[(-6,6)]*4+([ (0,0)] if theta_mode=='positive' else [(np.pi,np.pi)] if theta_mode=='negative' else [(0,np.pi)])
                res=differential_evolution(lambda x:objective(x,mode),bounds=bounds,tol=1e-10,popsize=20,maxiter=700,seed=seed+291,polish=False)
                d=evaluate(res.x)
                d.update(mode=mode,theta_mode=theta_mode,seed=seed,nfev=res.nfev,elapsed=time.time()-start)
                best.append(d)
                print(json.dumps(d),flush=True)
                (ROOT/'de_results.json').write_text(json.dumps(best,indent=2))
                if d['gap']>1e-7:
                    print('POTENTIAL VIOLATION',flush=True)
    for seed in range(3):
        res=differential_evolution(lambda x:objective(x,'ratio',True),bounds=[(-5,5)]*4+[(0,np.pi),(.4,1)],tol=1e-9,popsize=25,maxiter=700,seed=seed+113,polish=False)
        d=evaluate(res.x,True)
        d.update(mode='ratio',theta_mode='complex_interior',seed=seed,nfev=res.nfev)
        best.append(d)
        print(json.dumps(d),flush=True)
        (ROOT/'de_results.json').write_text(json.dumps(best,indent=2))

if __name__=='__main__': main()
