#!/usr/bin/env python3
"""Independent Pauli/Kraus checks of the three-qubit majorization manuscript.

Numerical tests are diagnostics, not a proof of a continuum statement.
Run: python verify_independent.py --output independent_review.json
Dependencies: Python >=3.11, NumPy.
"""
from __future__ import annotations
import argparse
from fractions import Fraction
import hashlib
import itertools
import json
import math
from pathlib import Path
import platform
import numpy as np

I2 = np.eye(2, dtype=complex)
X = np.array([[0, 1], [1, 0]], dtype=complex)
Y = np.array([[0, -1j], [1j, 0]], dtype=complex)
Z = np.diag([1., -1.]).astype(complex)
PAULIS = (I2, X, Y, Z)
LABELS = tuple(itertools.product(range(4), repeat=3))
P = np.array([np.kron(np.kron(PAULIS[a], PAULIS[b]), PAULIS[c]) for a,b,c in LABELS])
WEIGHTS = np.array([sum(x != 0 for x in lab) for lab in LABELS])
I8 = np.eye(8, dtype=complex)
SPINFLIP = np.kron(np.kron(Y, Y), Y)
TOL = 2e-12
SEED = 20261124031


def state(psi):
    psi = np.asarray(psi, complex)
    psi = psi / np.linalg.norm(psi)
    return np.outer(psi, psi.conj())


def random_state(rng, rank):
    z = rng.standard_normal((8, rank)) + 1j*rng.standard_normal((8, rank))
    rho = z @ z.conj().T
    return rho / np.trace(rho)


def bits(i):
    return tuple((i >> (2-j)) & 1 for j in range(3))


def reduced(rho, keep):
    """Index-definition partial trace, independent of tensor reshape conventions."""
    keep = tuple(keep)
    gone = tuple(i for i in range(3) if i not in keep)
    out = np.zeros((2**len(keep), 2**len(keep)), complex)
    for i in range(8):
        bi = bits(i)
        ii = sum(bi[k] << (len(keep)-1-j) for j,k in enumerate(keep))
        for j in range(8):
            bj = bits(j)
            if all(bi[k] == bj[k] for k in gone):
                jj = sum(bj[k] << (len(keep)-1-h) for h,k in enumerate(keep))
                out[ii,jj] += rho[i,j]
    return out


def embed(op, keep):
    """Embed op with an UNNORMALIZED identity on the complement."""
    keep = tuple(keep)
    gone = tuple(i for i in range(3) if i not in keep)
    out = np.zeros((8,8), complex)
    for i in range(8):
        bi = bits(i)
        ii = sum(bi[k] << (len(keep)-1-j) for j,k in enumerate(keep))
        for j in range(8):
            bj = bits(j)
            if all(bi[k] == bj[k] for k in gone):
                jj = sum(bj[k] << (len(keep)-1-h) for h,k in enumerate(keep))
                out[i,j] = op[ii,jj]
    return out


def marginal_sums(rho):
    s1 = sum((embed(reduced(rho, (i,)), (i,)) for i in range(3)), np.zeros((8,8),complex))
    s2 = sum((embed(reduced(rho, keep), keep) for keep in itertools.combinations(range(3),2)), np.zeros((8,8),complex))
    return s1, s2


def depolarize_kraus(rho, lam):
    """64 Pauli unitary conjugations with the physical Kraus probabilities."""
    probabilities = np.array([(1+3*lam)/4, (1-lam)/4, (1-lam)/4, (1-lam)/4])
    if probabilities.min() < -TOL:
        raise ValueError('not a completely positive qubit depolarizing channel')
    weights = np.array([math.prod(probabilities[j] for j in lab) for lab in LABELS])
    return np.einsum('a,aij,jk,alk->il', weights, P, rho, P.conj(), optimize=True)


def coefficients(rho):
    return np.einsum('aij,ji->a', P, rho) / 8


def from_pauli(coeff, multipliers):
    return np.einsum('a,a,aij->ij', coeff, multipliers, P)


def depolarize_expansion(rho, s1, s2, lam):
    return lam**3*rho + lam**2*(1-lam)/2*s2 + lam*(1-lam)**2/4*s1 + (1-lam)**3/8*I8


def eigenvalues(a):
    return np.linalg.eigvalsh((a+a.conj().T)/2)[::-1]


def kyfan(a):
    return np.cumsum(eigenvalues(a))


def reference(lam):
    a=(1+abs(lam))/2; b=(1-abs(lam))/2
    return np.array([a**3]+[a*a*b]*3+[a*b*b]*3+[b**3])


def fractional_kyfan(s, u):
    k=int(math.floor(u))
    if k >= len(s): return float(sum(s))
    return float(sum(s[:k])+(u-k)*s[k])


def polynomial_add(p,q):
    r=[Fraction(0)]*max(len(p),len(q))
    for i,x in enumerate(p):r[i]+=x
    for i,x in enumerate(q):r[i]+=x
    return r


def polynomial_mul(p,q):
    r=[Fraction(0)]*(len(p)+len(q)-1)
    for i,x in enumerate(p):
        for j,y in enumerate(q):r[i+j]+=x*y
    return r


def error_polynomial(distance):
    p=[Fraction(1)]
    for _ in range(3-distance):p=polynomial_mul(p,[0,1])
    for _ in range(distance):p=polynomial_mul(p,[1,-1])
    return p


def codewords(M):
    if M==1: return [0]
    if M<=8: return [0,7,1,2,3,4,5,6][:M]
    return list(range(8))+[0]*(M-8)


def decode(y, code):
    # Ties choose the first message; duplicate encodings are allowed.
    return min(range(len(code)), key=lambda m: ((code[m]^y).bit_count(),m))


def classical_code_certificate():
    out={}
    for M in range(1,13):
        code=codewords(M)
        poly=[Fraction(0)]*4
        shells=[Fraction(0)]*4
        for message,c in enumerate(code):
            for y in range(8):
                if decode(y,code)==message:
                    distance=(c^y).bit_count()
                    poly=polynomial_add(poly,[x/Fraction(M) for x in error_polynomial(distance)])
                    shells[distance]+=Fraction(1,M)
        expected=([1,0,0,0] if M==1 else [0,0,Fraction(8-M,M),Fraction(2*M-8,M)] if M<=8 else [0,0,0,Fraction(8,M)])
        expected_shells=([1,3,3,1] if M==1 else [1,Fraction(8-M,M),0,0] if M<=8 else [Fraction(8,M),0,0,0])
        assert poly==[Fraction(x) for x in expected], (M,poly)
        assert shells==[Fraction(x) for x in expected_shells], (M,shells)
        out[str(M)]={'coefficients_in_a_low_to_high':[str(x) for x in poly],
                     'shell_coefficients_q0_q1_q2_q3':[str(x) for x in shells],
                     'exact_identity_checked':True}
    return out


def main(output):
    rng=np.random.default_rng(SEED)
    named={
      'basis000':state([1,0,0,0,0,0,0,0]),
      'basis111':state([0,0,0,0,0,0,0,1]),
      'GHZ':state([1,0,0,0,0,0,0,1]),
      'W':state([0,1,1,0,1,0,0,0]),
      'Bell_AB_tensor_zero':state([1,0,0,0,0,0,1,0]),
      'Bell_AC_tensor_zero':state([1,0,0,0,0,1,0,0]),
      'maximally_mixed':I8/8,
      'GHZ_classical_mixture':np.diag([.5,0,0,0,0,0,0,.5]),
    }
    samples=list(named.items())
    for rank in (1,2,3,4,8):
        samples.extend((f'rank{rank}_{i}',random_state(rng,rank)) for i in range(80))
    lambdas=[-1/3,-.32,-.2,-.01,0.,.01,.2,.5,.8,.99,1.]
    maxima={key:0. for key in ['channel_representation_error','spinflip_spectral_error','S1_positive_kyfan_excess','S2_positive_kyfan_excess','depolarizing_positive_kyfan_excess','exchangeable_positive_kyfan_excess','povm_positive_bound_excess','attainment_error','trace_error']}
    # Strongest interior diagnostic gap: positive excess would refute the claim.
    worst_signed_defect=-float('inf')
    worst_case=None
    for name,rho in samples:
        s1,s2=marginal_sums(rho); coeff=coefficients(rho)
        for key,mat,target in [('S1_positive_kyfan_excess',s1,[3,2,2,2,1,1,1,0]),('S2_positive_kyfan_excess',s2,[3,1,1,1,0,0,0,0])]:
            maxima[key]=max(maxima[key],float(np.max(kyfan(mat)[:7]-np.cumsum(target)[:7])))
        for lam in lambdas:
            out=depolarize_kraus(rho,lam)
            expanded=depolarize_expansion(rho,s1,s2,lam)
            spectral=from_pauli(coeff,lam**WEIGHTS)
            err=max(np.max(np.abs(out-expanded)),np.max(np.abs(out-spectral)))
            maxima['channel_representation_error']=max(maxima['channel_representation_error'],float(err))
            maxima['trace_error']=max(maxima['trace_error'],float(abs(np.trace(out)-1)))
            defects=kyfan(out)[:7]-np.cumsum(reference(lam))[:7]
            maxima['depolarizing_positive_kyfan_excess']=max(maxima['depolarizing_positive_kyfan_excess'],float(max(defects)))
            if float(max(defects))>worst_signed_defect:
                worst_signed_defect=float(max(defects));worst_case={'state':name,'lambda':lam,'rank':int(np.argmax(defects))+1}
            if lam<0:
                pos=depolarize_kraus(rho,-lam)
                flip=SPINFLIP @ pos.T @ SPINFLIP.conj().T
                maxima['spinflip_spectral_error']=max(maxima['spinflip_spectral_error'],float(np.max(abs(out-flip))),float(np.max(abs(eigenvalues(out)-eigenvalues(pos)))))
    exchangeable_weights=[np.eye(4)[i] for i in range(4)]
    exchangeable_weights.extend(rng.dirichlet(np.ones(4),size=100))
    exchangeable_checks=0
    for j,weights in enumerate(exchangeable_weights):
        for name,rho in samples[j%17::17]:
            a0,a1,a2,a3=weights
            s1,s2=marginal_sums(rho)
            out=a0/8*I8+a1/12*s1+a2/6*s2+a3*rho
            factors=np.array([1,a1/3+2*a2/3+a3,a2/3+a3,a3])
            other=from_pauli(coefficients(rho),factors[WEIGHTS])
            maxima['channel_representation_error']=max(maxima['channel_representation_error'],float(np.max(abs(out-other))))
            levels=[a0/8+a1/4+a2/2+a3,a0/8+a1/6+a2/6,a0/8+a1/12,a0/8]
            target=[levels[0]]+[levels[1]]*3+[levels[2]]*3+[levels[3]]
            maxima['exchangeable_positive_kyfan_excess']=max(maxima['exchangeable_positive_kyfan_excess'],float(np.max(kyfan(out)[:7]-np.cumsum(target)[:7])))
            exchangeable_checks+=1
    # Explicit POVMs normalized by conjugation with the inverse square root.
    povm_checks=0
    for M in (2,3,4,5,8,12):
        for trial in range(20):
            lam=lambdas[trial%len(lambdas)]
            pos=[random_state(rng,8) for _ in range(M)]
            total=sum(pos,np.zeros((8,8),complex))
            vals,vecs=np.linalg.eigh(total)
            inv=(vecs*(1/np.sqrt(vals)))@vecs.conj().T
            effects=[inv@x@inv for x in pos]
            success=sum(np.trace(e@depolarize_kraus(random_state(rng,1+(i%4)),lam)).real for i,e in enumerate(effects))/M
            bound=fractional_kyfan(reference(lam),8/M)
            maxima['povm_positive_bound_excess']=max(maxima['povm_positive_bound_excess'],float(success-bound))
            povm_checks+=1
    # Direct quantum/Kraus evaluation of all claimed attaining codes.
    attainment_checks=0
    for lam in lambdas:
        for M in range(1,13):
            code=codewords(M)
            success=0.
            for message,c in enumerate(code):
                rho=np.zeros((8,8),complex);rho[c,c]=1
                out=depolarize_kraus(rho,lam)
                for y in range(8):
                    yy=y^7 if lam<0 else y
                    if decode(yy,code)==message:success+=out[y,y].real/M
            target=fractional_kyfan(reference(lam),8/M)
            maxima['attainment_error']=max(maxima['attainment_error'],float(abs(success-target)))
            attainment_checks+=1
    # Exchangeable-sector channels, including all four simplex vertices.
    exchangeable_attainment_checks=0
    for weights in exchangeable_weights[:24]:
        a0,a1,a2,a3=weights
        factors=np.array([1,a1/3+2*a2/3+a3,a2/3+a3,a3])
        levels=[a0/8+a1/4+a2/2+a3,a0/8+a1/6+a2/6,a0/8+a1/12,a0/8]
        target_spectrum=[levels[0]]+[levels[1]]*3+[levels[2]]*3+[levels[3]]
        for M in range(1,13):
            code=codewords(M); success=0.
            for message,c in enumerate(code):
                rho=np.zeros((8,8),complex);rho[c,c]=1
                out=from_pauli(coefficients(rho),factors[WEIGHTS])
                success+=sum(out[y,y].real for y in range(8) if decode(y,code)==message)/M
            target=fractional_kyfan(target_spectrum,8/M)
            maxima['attainment_error']=max(maxima['attainment_error'],float(abs(success-target)))
            exchangeable_attainment_checks+=1
    # Negative control from Song--Chen: incompatible two-body projectors.
    phis=[state([0,6,-9,-10]),state([-2,-4,-1,5]),state([-6,-1,-4,0])]
    bad=sum((embed(phi,keep) for phi,keep in zip(phis,[(0,1),(0,2),(1,2)])),np.zeros((8,8),complex))
    bad_excess=float(kyfan(bad)[2]-5)
    assert bad_excess>1e-4, ('negative control failed',bad_excess)
    certificate=classical_code_certificate()
    assert all(v<TOL for v in maxima.values()),maxima
    report={
      'status':'passed','seed':SEED,'tolerance':TOL,
      'interpretation':'Numerical diagnostics and exact polynomial code identities; no numerical test proves universal majorization.',
      'environment':{'python':platform.python_version(),'numpy':np.__version__},
      'source_sha256':hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
      'state_count':len(samples),'named_states':list(named),'random_ranks':[1,2,3,4,8],'random_states_per_rank':80,
      'lambda_values':lambdas,'depolarizing_checks':len(samples)*len(lambdas),'proper_KyFan_sums_per_check':7,
      'exchangeable_checks':exchangeable_checks,'povm_checks':povm_checks,'attainment_checks':attainment_checks,'exchangeable_attainment_checks':exchangeable_attainment_checks,
      'maxima':maxima,'worst_signed_depolarizing_defect':worst_signed_defect,'worst_case':worst_case,
      'negative_control':{'source':'https://arxiv.org/html/2603.25410','input':'three incompatible two-body pure states, equations (7)-(9)','K3_of_unnormalized_sum_minus_5':bad_excess,'correctly_rejected':True},
      'exact_code_polynomials':certificate,
    }
    output=Path(output);output.parent.mkdir(parents=True,exist_ok=True)
    output.write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(report,indent=2))

if __name__=='__main__':
    parser=argparse.ArgumentParser();parser.add_argument('--output',default='independent_review.json')
    main(parser.parse_args().output)
