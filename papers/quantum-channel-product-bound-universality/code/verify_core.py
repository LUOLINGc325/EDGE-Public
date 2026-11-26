#!/usr/bin/env python3
"""Finite, reproducible checks; this program is not a proof of the CPTP theorem."""
from __future__ import annotations

import argparse
from fractions import Fraction as F
import itertools
import json
from pathlib import Path

import numpy as np
import sympy as sp


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def weak_compositions(total, length):
    if length == 1:
        yield (total,)
        return
    for first in range(total + 1):
        for rest in weak_compositions(total - first, length - 1):
            yield (first,) + rest


def exact_pairs():
    vectors = checks = equality = 0
    for d in range(2, 6):
        for denominator in range(1, 9):
            # The last coordinate is slack, so sum(e_i) ranges over [0,1].
            for comp in weak_compositions(denominator, d + 1):
                e = [F(x, denominator) for x in comp[:-1]]
                r = sum(e, F(0))
                products = sorted((1 - x) * (1 - y) for x in e for y in e)
                total = F(0)
                for k, value in enumerate(products, 1):
                    total += value
                    lower = (1 - r) * (k - r)
                    require(total >= lower, f"pair bound failed: {d=} {e=} {k=}")
                    checks += 1
                    equality += total == lower
                vectors += 1
    # Distinctness really is necessary: this deliberately repeated pair fails.
    repeated_lhs = 2 * F(1, 2) ** 2
    repeated_rhs = (1 - F(1, 2)) * (2 - F(1, 2))
    require(repeated_lhs < repeated_rhs, "distinct-pair negative control failed")
    return {"vectors": vectors, "inequalities": checks, "equalities": equality,
            "dimensions": [2, 3, 4, 5], "denominator_range_inclusive": [1, 8],
            "negative_control_repeated_pairs": "strictly fails, as expected"}


def exact_algebra():
    d, k, r, u, v, lam, t = sp.symbols("d k r u v lam t", real=True)
    s0 = (1 - r) * (k - r)
    expressions = {
        "S0_expansion": s0 - (k - (k + 1) * r + r**2),
        "purity_factorization": lam**2 + (d-lam)**2 - ((d-1)**2+1)
                                - 2*(lam-1)*(lam-d+1),
        "sqrt_monotonicity": (-u**2 + 2*r*u) - (-v**2 + 2*r*v)
                              + (u-v)*(u+v-2*r),
        "small_remainder": (d-r)**2-s0+2*r*v
                            - (d**2-k+r*(k+1-2*d+2*v)),
        "large_remainder_monotonicity": (d-t)**2+t**2-((d-r)**2+r**2)
                                         -2*(r-t)*(d-r-t),
        "threshold_identity": (d-k/(k+1))**2+(k/(k+1))**2-(d**2-k)
                              -k*(2*k-(k+1)*(2*d-k-1))/(k+1)**2,
    }
    for name, expr in expressions.items():
        require(sp.cancel(expr) == 0, f"symbolic identity failed: {name}")
    return {"identities": len(expressions), "all_residuals": 0,
            "names": list(expressions)}


def superop(kraus):
    return sum(np.kron(k, k.conj()) for k in kraus)


def superop_direct(kraus):
    d = kraus[0].shape[0]
    columns = []
    for i, j in itertools.product(range(d), repeat=2):
        e = np.zeros((d, d), complex)
        e[i, j] = 1
        columns.append(sum(k @ e @ k.conj().T for k in kraus).reshape(-1))
    return np.column_stack(columns)


def isometry_channel(rng, d, rank, noise=None):
    z = rng.normal(size=(d*rank, d)) + 1j*rng.normal(size=(d*rank, d))
    if noise is not None:
        z *= noise / np.sqrt(d*rank)
        z[:d] += np.eye(d)
    v, _ = np.linalg.qr(z)
    return [v[a*d:(a+1)*d] for a in range(rank)]


def exact_k0(d):
    # k+1 <=2d and (2d-k-1)^2 >=4k is an integer-only criterion.
    return max(k for k in range(1, 2*d) if 2*d-k-1 >= 0
               and (2*d-k-1)**2 >= 4*k)


def matrix_checks(seed):
    rng = np.random.default_rng(seed)
    stats = {"channels": 0, "admissible_k_checks": 0, "low_choi": 0,
             "unitary": 0, "small_remainder": 0, "large_remainder": 0}
    worst = {"trace_preservation": 0., "vectorization": 0., "choi_reshuffling": 0.,
             "spectral_reconstruction": 0., "spectral_kraus_orthogonality": 0.,
             "theorem_excess": -float("inf"), "pair_lower_deficit": 0.,
             "bottom_lipschitz_deficit": 0.}
    for d in range(2, 9):
        families = []
        for rank in sorted({1, 2, 3, d}):
            for noise in [None, 0.03, 0.25, 0.7]:
                for _ in range(4):
                    families.append(isometry_channel(rng, d, rank, noise))
        for p in [0., 0.01, 0.25, 0.75, 1.]:
            a = np.eye(d, dtype=complex); a[-1,-1] = np.sqrt(1-p)
            b = np.zeros((d,d), complex); b[0,-1] = np.sqrt(p)
            families.append([a,b])
        for ks in families:
            stats["channels"] += 1
            tp = np.linalg.norm(sum(k.conj().T@k for k in ks)-np.eye(d))
            mat = superop(ks)
            direct = superop_direct(ks)
            jmat = sum(np.outer(k.reshape(-1), k.reshape(-1).conj()) for k in ks)
            vals, vecs = np.linalg.eigh(jmat)
            order = np.argsort(vals)[::-1]
            vals, vecs = vals[order], vecs[:,order]
            require(vals[-1] > -1e-10, "negative Choi eigenvalue")
            sks = [np.sqrt(max(float(lam), 0.))*vecs[:,a].reshape(d,d)
                   for a, lam in enumerate(vals)]
            amat = superop([sks[0]])
            bmat = superop(sks[1:])
            purity = float(np.vdot(mat, mat).real)
            sig = np.linalg.svd(mat, compute_uv=False)
            r = d-float(vals[0])
            bnorm = float(np.linalg.norm(bmat))
            orth = abs(np.vdot(amat,bmat))
            worst["trace_preservation"] = max(worst["trace_preservation"], tp)
            worst["vectorization"] = max(worst["vectorization"], float(np.linalg.norm(mat-direct)))
            worst["choi_reshuffling"] = max(worst["choi_reshuffling"], abs(purity-float(np.vdot(jmat,jmat).real)))
            worst["spectral_reconstruction"] = max(worst["spectral_reconstruction"], float(np.linalg.norm(mat-amat-bmat)))
            worst["spectral_kraus_orthogonality"] = max(worst["spectral_kraus_orthogonality"], float(orth))
            for k in range(1, exact_k0(d)+1):
                stats["admissible_k_checks"] += 1
                q = d*d-k
                top = float(sum(sig[:q]**2))
                worst["theorem_excess"] = max(worst["theorem_excess"],top-q)
                require(top <= q+2e-9, "universal square sum failed")
                if vals[0] <= d-1+1e-11:
                    stats["low_choi"] += 1
                    require(purity <= (d-1)**2+1+2e-9, "low Choi bound failed")
                elif r <= 1e-11:
                    stats["unitary"] += 1
                    require(np.max(abs(sig-1)) < 2e-9, "rank-one Choi unitary check failed")
                else:
                    sa = np.linalg.svd(amat, compute_uv=False)
                    s = float(sum(sa[-k:]**2)); s0=(1-r)*(k-r)
                    h = float(np.linalg.norm(sig[-k:]))
                    worst["pair_lower_deficit"] = max(worst["pair_lower_deficit"],s0-s)
                    worst["bottom_lipschitz_deficit"] = max(worst["bottom_lipschitz_deficit"],max(0,np.sqrt(s)-bnorm)-h)
                    require(s+2e-9 >= s0, "pair bound for spectral Kraus failed")
                    require(h+2e-9 >= max(0,np.sqrt(s)-bnorm), "bottom Lipschitz failed")
                    require(bnorm <= r+2e-9 and orth < 2e-9, "tail orthogonality budget failed")
                    if r <= k/(k+1):
                        stats["small_remainder"] += 1
                        bound=(d-r)**2-s0+2*r*np.sqrt(max(s0,0))
                    else:
                        stats["large_remainder"] += 1
                        bound=(d-r)**2+r*r
                    require(top <= bound+2e-9 and bound <= q+2e-9, "scalar envelope failed")
    # A CPTP map with a negative determinant: equal mixture of the three Pauli conjugations.
    x=np.array([[0,1],[1,0]],complex)
    y=np.array([[0,-1j],[1j,0]],complex)
    z=np.diag([1,-1]).astype(complex)
    neg=float(np.linalg.det(superop([x/np.sqrt(3),y/np.sqrt(3),z/np.sqrt(3)])).real)
    require(abs(neg+1/27)<1e-12,"determinant-sign control failed")
    # An out-of-scope factor count really can fail, even for amplitude damping.
    d=3; p=F(1,4)
    a=np.eye(d,dtype=complex);a[-1,-1]=np.sqrt(1-float(p))
    b=np.zeros((d,d),complex);b[0,-1]=np.sqrt(float(p))
    ss=np.linalg.svd(superop([a,b]),compute_uv=False)
    out=float(np.prod(ss[:(d-1)**2]))
    require(out>1+1e-8,"out-of-scope positive control failed")
    return {"seed":seed,"statistics":stats,"maximum_residuals":worst,
            "negative_determinant_channel":neg,
            "out_of_scope_q_equals_d_minus_1_squared_product":out,
            "scope":"finite floating-point cross-checks; not a universal proof"}


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--output",type=Path,default=Path("results/core_verification.json"))
    parser.add_argument("--seed",type=int,default=20261124)
    args=parser.parse_args()
    result={"status":"passed", "exact_ordered_pair_checks":exact_pairs(),
            "exact_algebra":exact_algebra(), "matrix_checks":matrix_checks(args.seed)}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2,allow_nan=False)+"\n")
    print(json.dumps(result,indent=2,allow_nan=False))


if __name__=="__main__":
    main()
