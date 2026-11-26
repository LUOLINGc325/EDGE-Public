"""Independent small-system checks for modular projection and arbitrary bra bounds.

Uses computational basis and explicit Pauli matrices, not branch-sum formula.
This finite computation is a falsification probe, not a proof of asymptotics.
"""
from functools import lru_cache
from itertools import product
import math, json
from pathlib import Path
import numpy as np

BOUND_TOL = 1e-10
PROBABILITY_ATOL = 1e-12
PROBABILITY_RTOL = 1e-10
FIDELITY_TOL = 1e-10


def require(condition, label, **context):
    """Fail independently of Python optimization flags."""
    if not condition:
        raise RuntimeError({"check": label, **context})


def require_finite(label, *values):
    for value in values:
        require(bool(np.all(np.isfinite(value))), "non-finite " + label)

@lru_cache(None)
def paulis(n):
    if n==0: return np.ones((1,1,1),dtype=complex)
    one=np.array([[[1,0],[0,1]],[[0,1],[1,0]],[[0,-1j],[1j,0]],[[1,0],[0,-1]]],complex)
    return np.stack([np.kron(p,q) for p in paulis(n-1) for q in one])

def moment(v):
    v=np.asarray(v,complex)
    require(v.ndim == 1 and len(v)>0 and len(v)&(len(v)-1)==0,
            "state dimension must be a positive power of two")
    require_finite("moment input", v)
    norm=float(np.linalg.norm(v))
    require_finite("moment norm", norm)
    require(norm>0, "zero state passed to moment")
    v=v/norm
    n=int(round(np.log2(len(v))))
    coef=np.einsum('i,pij,j->p',v.conj(),paulis(n),v)
    require_finite("Pauli expectations", coef)
    require(float(np.max(np.abs(coef.imag)))<=BOUND_TOL,
            "Hermitian Pauli expectation has an imaginary part")
    value=float(np.sum(np.abs(coef)**4)/len(v))
    require_finite("Pauli fourth moment", value)
    require(0<value<=1+BOUND_TOL, "Pauli fourth moment outside pure-state range", value=value)
    return value

def modular(L,K,r,p,phi):
    w=np.array([i.bit_count() for i in range(2**L)])
    v=np.power(p,w/2)*np.power(1-p,(L-w)/2)*np.exp(1j*phi*w)
    v[w%K!=r]=0
    Z=float(np.vdot(v,v).real)
    require_finite("modular state and norm", v, Z)
    require(Z>0, "empty modular conditioning event", L=L, K=K, r=r)
    return v/np.sqrt(Z),Z

def kron_many(vecs):
    v=np.ones(1,complex)
    for z in vecs:v=np.kron(v,z)
    return v

def main():
    rows=[];worst_lo=0.;worst_hi=0.;filt_err=0.
    for L in range(1,6):
      for K in range(1,L+2):
       for r in range(K):
        for p,phi in [(0.25,0.0),(0.37,0.239),(0.5,0.0)]:
          if r>L:continue
          psi,Z=modular(L,K,r,p,phi)
          phases=phi+2*np.pi*np.arange(K)/K
          branches=[np.array([np.sqrt(1-p),np.sqrt(p)*np.exp(1j*z)]) for z in phases]
          alphas=np.array([-np.log2(moment(v)) for v in branches]);target=int(np.argmin(alphas));a=float(alphas[target])
          t=K-1
          eta=kron_many([np.array([np.sqrt(p),-np.sqrt(1-p)*np.exp(1j*phases[j])]) for j in range(K) if j!=target])
          out=eta.conj()@psi.reshape(2**t,2**(L-t))
          q=float(np.vdot(out,out).real)
          expected=(p*(1-p))**t/Z
          require_finite("root-filter probability", out, q, expected)
          context={'L':L,'K':K,'r':r,'p':p,'phi':phi}
          require(q>0 and expected>0, "nonpositive root-filter probability", **context)
          err=abs(q-expected)
          require(err<=PROBABILITY_ATOL+PROBABILITY_RTOL*abs(expected),
                  "root-filter probability identity", error=err, expected=expected, **context)
          target_vec=kron_many([branches[target]]*(L-t))
          fidelity=abs(np.vdot(target_vec,out))**2/q
          require_finite("root-filter fidelity", fidelity)
          require(abs(1-fidelity)<=FIDELITY_TOL,
                  "root-filter output branch fidelity", fidelity=float(fidelity), **context)
          filt_err=max(filt_err,err,abs(1-fidelity))
          m=-np.log2(moment(psi))
          lower=L*a+4*np.log2(Z)
          upper=(L-t)*a+t-4*np.log2(expected)
          require_finite("modular entropy bounds", alphas, m, lower, upper)
          require(lower-m<=BOUND_TOL, "modular lower bound", violation=float(lower-m), **context)
          require(m-upper<=BOUND_TOL, "modular upper bound", violation=float(m-upper), **context)
          worst_lo=max(worst_lo,lower-m);worst_hi=max(worst_hi,m-upper)
          rows.append({'L':L,'K':K,'r':r,'p':p,'phi':phi,'M2':m,'lower':lower,'upper':upper,'q':q,'q_formula':expected,'fidelity':fidelity})
    rng=np.random.default_rng(20261124)
    arbitrary=[]
    for L in range(2,6):
      for t in range(1,L):
       for trial in range(8):
        psi=rng.normal(size=2**L)+1j*rng.normal(size=2**L);psi/=np.linalg.norm(psi)
        eta=rng.normal(size=2**t)+1j*rng.normal(size=2**t);eta/=np.linalg.norm(eta)
        out=eta.conj()@psi.reshape(2**t,2**(L-t));q=float(np.vdot(out,out).real)
        require_finite("arbitrary-bra probability", out, q)
        require(q>0, "zero arbitrary-bra output", L=L, t=t, trial=trial)
        ratio=q**4*moment(out)/(2**t*moment(psi))
        require_finite("arbitrary-bra ratio", ratio)
        require(0<=ratio<=1+BOUND_TOL, "arbitrary-bra inequality", ratio=ratio, L=L, t=t, trial=trial)
        arbitrary.append({'L':L,'t':t,'trial':trial,'ratio_le_1':ratio})
    summary={'status':'PASS','all_checks_passed':True,
             'method':'Explicit computational-basis states and Pauli matrices',
             'modular_cases':len(rows),'arbitrary_bra_cases':len(arbitrary),
             'max_lower_bound_violation':worst_lo,'max_upper_bound_violation':worst_hi,
             'max_filter_probability_or_fidelity_error':filt_err,
             'max_arbitrary_bra_ratio':max(r['ratio_le_1'] for r in arbitrary),
             'tolerances':{'entropy_bounds_absolute':BOUND_TOL,
                           'filter_probability_absolute':PROBABILITY_ATOL,
                           'filter_probability_relative':PROBABILITY_RTOL,
                           'filter_fidelity_absolute':FIDELITY_TOL,
                           'arbitrary_bra_ratio_absolute':BOUND_TOL},
             'pass_criteria':'All evaluated quantities finite; every probability identity, fidelity, entropy bound and arbitrary-bra inequality within the declared tolerance. Explicit RuntimeError checks remain active under python -O.',
             'scope':'Finite numerical falsification probes; not an asymptotic proof or interval certificate.'}
    (Path(__file__).resolve().parents[1] / 'results' / 'complex_independent.json').write_text(json.dumps({'summary':summary,'modular':rows,'arbitrary_bra':arbitrary},indent=2,allow_nan=False)+'\n')
    print(json.dumps(summary,indent=2))

if __name__=='__main__':main()
