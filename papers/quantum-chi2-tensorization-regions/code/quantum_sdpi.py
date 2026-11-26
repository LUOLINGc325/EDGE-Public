"""Finite-dimensional fixed-reference chi-square SDPI diagnostics.

Numerical exploration only: no floating-point output is a proof certificate.
All tangent matrices are Hermitian and traceless; the Gram method avoids
assuming tensor factorization of the metric under investigation.
"""
from __future__ import annotations

import numpy as np
from scipy.linalg import eigh
from functools import lru_cache


@lru_cache(None)
def tangent_basis(d: int) -> np.ndarray:
    """Hilbert-Schmidt orthonormal Hermitian traceless basis."""
    bs = []
    for i in range(d):
        for j in range(i + 1, d):
            x = np.zeros((d, d), dtype=complex)
            x[i, j] = x[j, i] = 1 / np.sqrt(2)
            bs.append(x)
            y = np.zeros((d, d), dtype=complex)
            y[i, j] = -1j / np.sqrt(2)
            y[j, i] = 1j / np.sqrt(2)
            bs.append(y)
    for k in range(1, d):
        z = np.zeros((d, d), dtype=complex)
        z[np.arange(k), np.arange(k)] = 1 / np.sqrt(k * (k + 1))
        z[k, k] = -k / np.sqrt(k * (k + 1))
        bs.append(z)
    return np.array(bs)


def kappa(x, family="mean", alpha=0.5):
    x = np.asarray(x)
    if family == "mean":
        return 0.5 * (x ** (-alpha) + x ** (alpha - 1))
    if family == "minimum":
        return 2 / (1 + x)
    if family == "bkm":
        a = np.log(x)
        return np.divide(a, x-1, out=np.ones_like(a), where=np.abs(x-1)>1e-12)
    if family == "wy":
        return 4 / (1 + np.sqrt(x)) ** 2
    if family == "harmonic_mix":
        # Extreme rays of the normalized symmetric monotone-metric simplex.
        t = alpha
        return (1+t)/2 * (1/(x+t)+1/(1+t*x))
    raise ValueError(family)


def apply(kraus, x):
    return np.einsum("rai,...ij,rbj->...ab", np.asarray(kraus), x,
                     np.asarray(kraus).conj(), optimize=True)


def metric_gram(sigma, matrices, family="mean", alpha=0.5):
    lam, u = eigh(sigma, check_finite=False)
    if lam[0] <= 0:
        raise ValueError(f"Reference not faithful: min eigenvalue {lam[0]}")
    v = np.einsum("ia,nij,jb->nab", u.conj(), matrices, u, optimize=True)
    weights = kappa(lam[:, None] / lam[None, :], family, alpha) / lam[None, :]
    g = np.einsum("aij,ij,bij->ab", v.conj(), weights, v, optimize=True).real
    return (g+g.T)/2


def eta(kraus, sigma, family="mean", alpha=0.5, witness=False):
    basis = tangent_basis(sigma.shape[0])
    out = apply(kraus, sigma)
    moved = apply(kraus, basis)
    g = metric_gram(sigma, basis, family, alpha)
    q = metric_gram(out, moved, family, alpha)
    n = len(basis)
    if witness:
        vals, vecs = eigh(q, g, subset_by_index=[n-1, n-1], check_finite=False)
        h = np.einsum("n,nij->ij", vecs[:, 0], basis)
        residual = np.linalg.norm(q @ vecs[:, 0] - vals[0] * g @ vecs[:, 0])
        return float(vals[0]), h, float(residual)
    return float(eigh(q, g, eigvals_only=True, subset_by_index=[n-1,n-1],
                      check_finite=False)[0])


def tensor_channel(k1, k2):
    return np.array([np.kron(a,b) for a in k1 for b in k2])


def tensor_gap(k1, s1, k2, s2, family="mean", alpha=0.5, witness=False):
    e1, e2 = eta(k1,s1,family,alpha), eta(k2,s2,family,alpha)
    joint = eta(tensor_channel(k1,k2), np.kron(s1,s2),family,alpha,witness)
    ej = joint[0] if witness else joint
    return {"eta1":e1,"eta2":e2,"eta_joint":ej,"gap":ej-max(e1,e2),
            "ratio":ej/max(e1,e2)}, joint if witness else None


def amplitude_damping(gamma):
    return np.array([[[1,0],[0,np.sqrt(1-gamma)]],
                     [[0,np.sqrt(gamma)],[0,0]]],dtype=complex)


def diagonal_qubit(s):
    return np.diag([(1+s)/2,(1-s)/2]).astype(complex)


def random_channel(rng, dim_in=2, dim_out=2, rank=4):
    z = rng.normal(size=(dim_out*rank,dim_in)) + 1j*rng.normal(size=(dim_out*rank,dim_in))
    q,_ = np.linalg.qr(z)
    return q.reshape(rank,dim_out,dim_in)


def random_state(rng, d=2, condition_log10=1):
    z = rng.normal(size=(d,d))+1j*rng.normal(size=(d,d))
    u,_ = np.linalg.qr(z)
    lam = 10 ** rng.uniform(-condition_log10,0,d)
    lam /= lam.sum()
    return (u*lam) @ u.conj().T


def channel_checks(ks):
    ks = np.asarray(ks)
    din = ks.shape[2]
    tp = np.einsum("rai,raj->ij",ks.conj(),ks)
    choi = sum(np.outer(k.flatten(),k.flatten().conj()) for k in ks)
    return {"tp_error":float(np.linalg.norm(tp-np.eye(din))),
            "choi_min_eigenvalue":float(eigh(choi,eigvals_only=True)[0])}


def serialize_complex(z):
    z = np.asarray(z)
    return {"real":z.real.tolist(),"imag":z.imag.tolist()}


def deserialize_complex(z):
    return np.array(z["real"])+1j*np.array(z["imag"])


def regression():
    rng = np.random.default_rng(20261125)
    base_errors=[]
    for d in (2,3,4):
        b=tangent_basis(d)
        base_errors.append(float(np.max(np.abs(np.einsum("aij,bij->ab",b.conj(),b)-np.eye(len(b))))))
    midpoint=[]
    for j in range(12):
        d1,d2=2,2 if j<10 else 3
        k1=random_channel(rng,d1,d1,d1+1)
        k2=random_channel(rng,d2,d2,d2+1)
        s1=random_state(rng,d1,2)
        s2=random_state(rng,d2,2)
        g,_=tensor_gap(k1,s1,k2,s2)
        midpoint.append(g)
    gamma,s=.5,.5
    ks=amplitude_damping(gamma)
    sig=diagonal_qubit(s)
    g,h=tensor_gap(ks,sig,ks,sig,"mean",0,True)
    f=gamma+(1-gamma)*s
    e=(1-gamma)*(1-s*s)/(1-f*f)
    r=(1-gamma)**2*(1+f*f)*(1-s*s)**2/((1+s*s)*(1-f*f)**2)
    return {"basis_errors":base_errors,"midpoint_cases":midpoint,
            "midpoint_max_abs_gap":max(abs(x["gap"]) for x in midpoint),
            "cao_endpoint":g,"cao_single_formula":e,"cao_tensor_rayleigh_formula":r,
            "cao_generalized_eigen_residual":h[2],
            "cao_channel_checks":channel_checks(ks),"seed":20261125}


if __name__ == "__main__":
    import json
    ans=regression()
    with open("regression.json","w") as f:
        json.dump(ans,f,indent=2)
    print(json.dumps(ans,indent=2))
