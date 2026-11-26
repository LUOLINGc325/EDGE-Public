"""Batch random validation; these floating-point searches are not proofs."""
import json
from pathlib import Path
import numpy as np

ROOT=Path(__file__).resolve().parent
rng=np.random.default_rng(2026112407)
summary=[]
for phase_mode in ('positive','complex'):
    for interior in (False,True):
        best_ratio=None
        best_gap=None
        positive=0
        min_eig=1.
        invalid=0
        for batch in range(30):
            n=10000
            r=np.exp(rng.uniform(-4,4,(n,5)))
            theta=np.zeros(n) if phase_mode=='positive' else rng.uniform(0,np.pi,n)
            H=np.zeros((n,5,5),dtype=complex)
            for i in range(5):
                h=r[:,i]*(np.exp(1j*theta) if i==4 else 1)
                H[:,i,(i+2)%5]=h
                H[:,(i+2)%5,i]=h.conj()
            v=np.linalg.eigvalsh(H)
            scale=-1/v[:,0]
            if interior: scale*=rng.uniform(.2,1,n)
            v=1+v*scale[:,None]
            r*=scale[:,None]
            lhs=v[:,-1]-2
            t=r*np.sqrt(np.maximum(0,1-r*r))
            rhs=(t*np.roll(t,-1,axis=1)).max(axis=1)
            gap=lhs-rhs
            ratio=np.divide(lhs,rhs,out=np.full(n,-np.inf),where=rhs>1e-12)
            ratio[lhs<1e-6]=-np.inf
            positive+=int((lhs>1e-6).sum())
            min_eig=min(min_eig,float(v[:,0].min()))
            invalid+=int((v[:,0]<-1e-12).sum())
            for key,arr in [('gap',gap),('ratio',ratio)]:
                k=int(arr.argmax())
                rec=dict(r=r[k].tolist(),theta=float(theta[k]),eigenvalues=v[k].tolist(),lhs=float(lhs[k]),rhs=float(rhs[k]),gap=float(gap[k]),ratio=float(ratio[k]) if np.isfinite(ratio[k]) else None)
                if key=='gap' and (best_gap is None or gap[k]>best_gap['gap']):best_gap=rec
                if key=='ratio' and (best_ratio is None or ratio[k]>best_ratio['ratio']):best_ratio=rec
        row=dict(phase_mode=phase_mode,interior=interior,samples=300000,positive_violation_lhs=positive,min_eigenvalue=min_eig,invalid_psd_count=invalid,best_gap=best_gap,best_ratio=best_ratio)
        summary.append(row)
        print(json.dumps(row),flush=True)
        (ROOT/'random_results.json').write_text(json.dumps(summary,indent=2))
