#!/usr/bin/env python3
"""Finite diagnostics for Chained Index proofs; these do not prove theorems."""
import hashlib
import itertools
import json
import math
from pathlib import Path

import numpy as np

SEED = 20261125
rng = np.random.default_rng(SEED)
report = {"seed": SEED, "status": "running", "checks": {}, "scope":
          "Independent finite diagnostics, not exhaustive theorem verification or Lean."}


def mark(name, value):
    report["checks"][name] = value


def slice_data(n):
    subsets = list(itertools.combinations(range(n), n // 2))
    inc = np.zeros((len(subsets), n))
    for a, subset in enumerate(subsets):
        inc[a, list(subset)] = 1
    return inc


def norm(x, p):
    return float(np.mean(np.abs(x) ** p) ** (1 / p))


def divergence_density(f):
    f = np.asarray(f)
    positive = f > 0
    return float(np.sum(f[positive] * np.log2(f[positive])) / f.size)


def image_density(f, inc, b):
    transforms = [(2 / len(inc)) * (inc if bit else 1-inc).T for bit in b]
    if len(b) == 1:
        return transforms[0] @ f
    if len(b) == 2:
        return transforms[0] @ f @ transforms[1].T
    raise ValueError("Diagnostic only implements one or two copies")


norm_count = 0
kl_count = 0
norm_excess = -math.inf
kl_excess = -math.inf
for n in (2, 4, 6, 8):
    inc = slice_data(n)
    s = len(inc)
    p = 1 + 2 / n
    q = 1 + n / 2
    for trial in range(100):
        g = rng.normal(size=n)
        if trial % 10 == 0:
            g += trial / 10
        lhs = norm((2/n) * inc @ g, q)
        rhs = norm(g, 2)
        assert lhs <= rhs + 1e-10 * max(1, rhs)
        norm_excess = max(norm_excess, lhs-rhs)
        norm_count += 1
    for r in (1, 2):
        shape = (s,) * r
        for trial in range(65):
            if trial == 0:
                f = np.ones(shape)
            elif trial == 1:
                f = np.zeros(shape)
                f.flat[0] = f.size
            elif trial == 2 and r == 2:
                f = np.eye(s) * s
            elif trial == 3 and r == 2:
                f = np.fliplr(np.eye(s)) * s
            else:
                f = np.exp(rng.normal(size=shape) * (trial % 5 + 1))
                f /= np.mean(f)
            for b in itertools.product((0, 1), repeat=r):
                out = image_density(f, inc, b)
                assert abs(np.mean(out)-1) < 1e-10
                lhs, rhs = norm(out, 2), norm(f, p)
                assert lhs <= rhs + 1e-10 * max(1, rhs)
                norm_excess = max(norm_excess, lhs-rhs)
                norm_count += 1
                lhs, rhs = divergence_density(out), (2/n)*divergence_density(f)
                assert lhs <= rhs + 1e-10 * max(1, rhs)
                kl_excess = max(kl_excess, lhs-rhs)
                kl_count += 1
mark("slice_norm_and_correlated_tensor", {"tests": norm_count,
     "N": [2,4,6,8], "r": [1,2], "max_lhs_minus_rhs": norm_excess})
mark("KL_contraction_and_correlated_tensor", {"tests": kl_count,
     "max_lhs_minus_rhs": kl_excess})


encoder_count = 0
encoder_excess = -math.inf
reference_identity_error = 0
for n in (2,4,6):
    inc = slice_data(n)
    s = len(inc)
    for r in (1,2):
        shape = (s,) * r
        answers = list(itertools.product((0,1), repeat=r))
        for trial in range(40):
            W = rng.uniform(size=(s**r, 3))
            W /= W.sum(axis=1, keepdims=True)
            if trial % 5 == 0:
                W = np.eye(3)[rng.integers(0,3,size=s**r)]
            prior = rng.uniform(size=2**r)
            if r == 2 and trial % 3 == 0:
                prior = np.array([0.8,0,0,0.2])
            prior /= prior.sum()
            a = W.mean(axis=0)
            ixm = 0.0
            ibmj = 0.0
            for m in range(3):
                if a[m] == 0:
                    continue
                cell_density = (W[:,m]/a[m]).reshape(shape)
                ixm += a[m] * divergence_density(cell_density)
                outputs = np.stack([image_density(cell_density,inc,b).reshape(-1)
                                    for b in answers])
                mixture = prior @ outputs
                mutual = 0.0
                reference = 0.0
                for j, weight in enumerate(prior):
                    if weight == 0:
                        continue
                    w = outputs[j]
                    pos = w > 0
                    mutual += weight * float(np.sum(w[pos]*np.log2(w[pos]/mixture[pos]))/w.size)
                    reference += weight * divergence_density(w)
                reference_identity_error = max(reference_identity_error,
                    abs(reference-mutual-divergence_density(mixture)))
                ibmj += a[m] * mutual
            assert ibmj <= (2/n)*ixm + 1e-10
            encoder_excess = max(encoder_excess, ibmj-(2/n)*ixm)
            encoder_count += 1
mark("arbitrary_prior_stochastic_encoder_budget", {"tests": encoder_count,
     "N": [2,4,6], "r": [1,2], "includes_correlated_supported_prior": True,
     "max_lhs_minus_rhs": encoder_excess,
     "max_reference_identity_error": reference_identity_error})


cell_count = 0
max_discounted = 0.0
inc = slice_data(4)
eta = 4/6
for mask in range(1,2**len(inc)-1):
    cell = np.array([(mask>>j)&1 for j in range(len(inc))], dtype=bool)
    for b in ((0,), (1,)):
        total = 0.0
        for chosen in (cell, ~cell):
            a = chosen.mean()
            f = chosen.astype(float)/a
            w = image_density(f, inc, b)
            assert np.mean(w*w) <= a**(-eta)+1e-10
            total += a * np.mean(w*w) * 2**(-eta)
        assert total <= 1+1e-10
        max_discounted = max(max_discounted,total)
        cell_count += 1
mark("all_N4_binary_message_cells", {"tests": cell_count,
     "max_discounted_second_moment": max_discounted})


# Exact, deliberately hostile reference-support example: N=2,k=3.
# Two one-bit messages reveal the current singleton. Under Q the inferred
# answer bits can disagree. Only those impossible prefixes incur 101 bits.
q_expected_L2 = 0.0
q_expected_discounted_L2 = 0.0
q_max_cost = 0
positive_likelihood_max_cost = 0
for b,m1,j1,m2,j2,m3,j3 in itertools.product((0,1),repeat=7):
    decoded1 = int(m1 == j1)
    decoded2 = int(m2 == j2)
    impossible = decoded1 != decoded2
    cost = 103 if impossible else 2
    # When reachable, final message is the empty singleton; m3 is redundant
    # enumeration, accounted for by the same factor 1/2 in both branches.
    L = 4.0 if decoded1 == b and decoded2 == b else 0.0
    mass = 2**(-7)
    q_expected_L2 += mass * L*L
    q_expected_discounted_L2 += mass * L*L * 2**(-cost)
    q_max_cost = max(q_max_cost,cost)
    if L > 0:
        positive_likelihood_max_cost = max(positive_likelihood_max_cost,cost)
assert positive_likelihood_max_cost == 2 and q_max_cost == 103
assert q_expected_discounted_L2 <= 1+1e-12
assert q_expected_L2 <= 2**positive_likelihood_max_cost+1e-12
mark("reference_support_cost_counterexample", {
     "N":2,"k":3,"legal_cost_cap":2,"Q_max_cost":q_max_cost,
     "positive_likelihood_max_cost":positive_likelihood_max_cost,
     "E_joint_Q_L_squared":q_expected_L2,
     "E_joint_Q_discounted_L_squared":q_expected_discounted_L2,
     "purpose":"Q need not obey legal-input cost cap; positive likelihood support does."})


tuple_count_tests = 0
for k in range(1,26):
    for C in range(26):
        exact = sum(2**ell * math.comb(k+ell-1,ell) for ell in range(C+1))
        upper = 2**C * math.comb(k+C,C)
        assert exact <= upper
        tuple_count_tests += 1
mark("slot_tuple_count_bound", {"tests":tuple_count_tests,"max_k":25,"max_C":25})


grid = 0
worst_cost_ratio = 0.0
for n in list(range(2,201))+[255,256,511,512,1000,10000]:
    for exponent in list(np.linspace(-12,20,129))+[2*n,2*n+2]:
        # k>=1; preserve the parameter comparisons in log space for huge k.
        logq = max(float(exponent), -math.log2(n))
        if logq < 6:
            q = 2**logq
            L = math.log2(2+q)
            F = max(1,n/L)
            cost = n
        else:
            t = min(n,math.floor(logq/2))
            assert t >= 2
            cost = math.ceil(4*n/t)
            L = logq + math.log2(1+2**(1-logq))
            F = max(1,n/L)
            assert cost <= 5*n/t+1e-10
            assert cost <= 2.5*n+1e-10
            # mu/n=2^(logq-t)>=8; avoids huge exponentiation.
            assert logq-t >= 3-1e-10
            assert cost <= 4*n
            if t < n:
                assert t >= logq/3-1e-10
                assert L <= (7/6)*logq+1e-10
        assert cost <= 18*F+1e-9
        worst_cost_ratio = max(worst_cost_ratio,cost/F)
        grid += 1
assert math.exp(-2)+math.exp(-4)<1/3
mark("silent_upper_parameter_grid", {"tests":grid,
     "max_n":10000,"includes_exponential_chain_regime":True,
     "maximum_cost_over_F":worst_cost_ratio,
     "failure_bound":math.exp(-2)+math.exp(-4)})


inversion_tests = 0
max_ratio = 0.0
for logt in np.linspace(-100,100,1001):
    t = 2**logt
    L = math.log2(2+t)
    a = 1/2048
    x = a/L
    value = x*(1+math.log2(math.e)+math.log2(1+t/x))
    assert value <= 1/128+1e-12
    max_ratio = max(max_ratio,value)
    inversion_tests += 1
mark("silent_lower_uniform_inversion", {"tests":inversion_tests,
     "log2_k_over_n_range":[-100,100],"max_f_value":max_ratio,
     "proved_comparison":1/128,"required_threshold":1/45})


root = Path(__file__).resolve().parents[1]
sources = [root / 'manuscript' / name for name in (
    'strong_direct_product.en.md','free_slots.en.md','information_budget.en.md')]
report['source_sha256'] = {str(path.relative_to(root)):hashlib.sha256(path.read_bytes()).hexdigest() for path in sources}
report['status'] = 'pass'
out = root / 'results' / 'independent_diagnostics.json'
out.parent.mkdir(parents=True, exist_ok=True)
out.write_text(json.dumps(report,indent=2)+'\n')
print(json.dumps(report,indent=2))
