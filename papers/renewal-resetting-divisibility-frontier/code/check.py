"""Exact finite-law suffix checks and a numerical passive-reference check of (8)."""
from fractions import Fraction as F
from itertools import product
import json
import numpy as np


def check_suffixes(weights, length):
    words = list(product(range(2), repeat=length))
    mass = {w: F(m, sum(weights)) for w, m in zip(words, weights)}
    suffix_masses = []
    for width in range(length):
        joint = {}
        for word, weight in mass.items():
            past = word[length-1-width:-1]
            vals = joint.setdefault(past, [F(0), F(0)])
            vals[word[-1]] += weight
        suffix_masses.append(joint)
    increments = []
    marginal = suffix_masses[0][()]
    for width in range(1, length):
        peaks = []
        for w, vals in suffix_masses[width].items():
            prob = sum(vals)
            if not prob:
                continue
            shorter = suffix_masses[width-1][w[1:]]
            coeff = prob/sum(shorter)
            b = [a-coeff*b0 for a, b0 in zip(vals, shorter)]
            # Implement the independent bit transitions directly on the full words.
            before, after = F(0), F(0)
            for word, weight in mass.items():
                prefix = word[length-1-width:-1]
                gain = (F(prefix[0] == w[0])-coeff)*int(prefix[1:] == w[1:])
                before += weight*gain
                last = b[word[-1]]
                after += weight*gain*(int(last > 0)-int(last < 0))
            assert before == 0 and after == sum(map(abs,b))
            peaks.append(after)
        increments.append(max(peaks, default=F(0)))
    full = sum(sum(abs(v-sum(vals)*m) for v,m in zip(vals,marginal)) for vals in suffix_masses[-1].values())
    assert (full == 0) == (max(increments, default=0) == 0)
    for k in range(length):
        tail = F(0)
        for prefix, vals in suffix_masses[-1].items():
            if not sum(vals):
                continue
            key = prefix[len(prefix)-k:]
            coarse = suffix_masses[k][key]
            tail += sum(abs(v-sum(vals)*c/sum(coarse)) for v,c in zip(vals,coarse))
        assert full <= tail+sum((2**j)*v for j,v in enumerate(increments[:k],1))


def test_matrices():
    rng = np.random.default_rng(20261126)
    cases = 0
    for dim in (2,3):
        joint_dim=dim*dim
        for size in (2,4,8,16):
            walsh=np.array([[(-1)**((i & j).bit_count()) for j in range(size)] for i in range(size)])
            assert np.array_equal(walsh.T@walsh,size*np.eye(size))
            for trial in range(5):
                matrix=walsh if trial==0 else rng.choice([-1,1], size=(size,size))
                # Maximally entangled starting state with different unitary prefixes on the active register.
                phi=np.eye(dim).reshape(joint_dim)/np.sqrt(dim)
                states=[]
                for _ in range(size):
                    V=np.linalg.qr(rng.normal(size=(dim,dim))+1j*rng.normal(size=(dim,dim)))[0]
                    psi=np.kron(V,np.eye(dim))@phi
                    states.append(np.outer(psi,psi.conj()))
                q=np.einsum('xy,xij->yij',matrix,states)/size
                trace_bound=np.mean([np.sum(np.abs(np.linalg.eigvalsh(mat))) for mat in q])
                rhs=dim*np.linalg.norm(matrix,2)/size
                assert trace_bound <= rhs+1e-11
                cases+=1
    return cases


if __name__=='__main__':
    tables=0
    for values in product((0,1), repeat=8):
        if any(values):
            check_suffixes(values,3)
            tables+=1
    rng=np.random.default_rng(593)
    for _ in range(120):
        check_suffixes(list(map(int,rng.integers(0,11,size=16))),4)
        tables+=1
    print(json.dumps({'rational_joint_laws':tables,'passive_reference_sign_matrices':test_matrices(),'status':'passed'}))
