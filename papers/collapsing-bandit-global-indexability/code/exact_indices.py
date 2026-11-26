#!/usr/bin/env python3
"""Exact rational reproduction of the paper; no Lean/formalization code.

Run from the case directory:
    python3 code/exact_indices.py
All reported equalities and inequalities use fractions.Fraction.
The finite checks are diagnostics, not substitutes for the general proofs.
"""
from dataclasses import dataclass
from fractions import Fraction as Q
from pathlib import Path
import json


@dataclass(frozen=True)
class Arm:
    p0: Q
    p1: Q
    a0: Q
    a1: Q

    def __post_init__(self):
        assert 0 < self.p0 < self.p1 < 1
        assert 0 < self.a0 < self.a1 < 1
        assert self.p0 < self.a0 and self.p1 < self.a1

    @property
    def rho(self):
        return self.p1 - self.p0

    @property
    def alpha(self):
        return self.a1 - self.a0

    @property
    def delta(self):
        return self.alpha - self.rho

    @property
    def s(self):
        return self.p0 / (1 - self.rho)

    def tau(self, x):
        return self.p0 + self.rho * x

    def iterate(self, x, k):
        return self.s + self.rho ** k * (x - self.s)


def sign(x):
    return 1 if x > 0 else -1 if x < 0 else 0


def peak(arm, beta, sigma, c, x):
    """Return F_c(x), one exact maximizing k (None means never), and ties.

    The finite branch terminates because 0<rho<1 and the target is positive.
    No floating point logarithm or finite-chain approximation is used.
    """
    assert 0 < beta < 1 and sigma in (-1, 1) and 0 <= x <= 1
    A = sigma * (arm.s - c)
    B = sigma * (x - arm.s)
    if B >= 0:
        value = max(Q(0), sigma * (x - c))
        return value, (0 if value > 0 else None), []
    if A <= 0:
        return Q(0), None, []
    target = (1 - beta) * A / ((1 - beta * arm.rho) * (-B))
    power = Q(1)
    k = 0
    while power > target:
        power *= arm.rho
        k += 1
    value = beta ** k * (A + B * power)
    assert value > 0
    ties = [k + 1] if power == target else []
    return value, k, ties


def subsidy(arm, beta, c):
    """Subsidy M_beta(c) and scale w for delta != 0."""
    sigma = sign(arm.delta)
    assert sigma
    r0 = beta * (arm.a0 - arm.p0) / (1 - beta * arm.rho)
    r1 = beta * arm.delta / (1 - beta * arm.rho)
    f0, _, _ = peak(arm, beta, sigma, c, arm.a0)
    f1, _, _ = peak(arm, beta, sigma, c, arm.a1)
    den = 1 - beta * sigma * (f1 - f0)
    assert 1 - beta * arm.alpha <= den <= 1
    scale = abs(r1) / den
    m = r0 + scale * (sigma * c + beta * f0)
    return m, scale, den


def threshold_parameter(arm, beta, b):
    sigma = sign(arm.delta)
    assert sigma
    if sigma * (b - arm.s) >= 0:
        return b
    return (b - beta * arm.tau(b)) / (1 - beta)


def index(arm, beta, b):
    assert 0 < beta < 1 and 0 <= b <= 1
    if arm.delta == 0:
        return beta * (arm.a0 - arm.p0) / (1 - beta * arm.rho)
    return subsidy(arm, beta, threshold_parameter(arm, beta, b))[0]


def first_entry(arm, sigma, boundary, x):
    """Finite crossing-side hitting time, including an equality at the boundary."""
    k = 0
    while sigma * (x - boundary) < 0:
        x = arm.tau(x)
        k += 1
    return k, x


def average_index(arm, b):
    """Exact pointwise limit of discounted indices, as proved in the paper."""
    assert 0 <= b <= 1
    h = 1 - arm.rho
    r0 = (arm.a0 - arm.p0) / h
    if arm.delta == 0:
        return r0
    sigma = sign(arm.delta)
    r1 = arm.delta / h
    d = b - arm.s
    if sigma * d >= 0:
        f0 = max(Q(0), sigma * (arm.a0 - b))
        f1 = max(Q(0), sigma * (arm.a1 - b))
        den = 1 - sigma * (f1 - f0)
        assert den >= 1 - arm.alpha
        return r0 + abs(r1) * (sigma * b + f0) / den
    n0, t0 = first_entry(arm, sigma, b, arm.a0)
    n1, t1 = first_entry(arm, sigma, b, arm.a1)
    num = t0 + h * d * (n0 + 1)
    den = 1 - t1 + t0 + h * d * (n0 - n1)
    assert den >= 1 - arm.alpha
    return r0 + r1 * num / den


def assert_bellman(arm, beta, c, b):
    """Check the original, untransformed Bellman identity with exact rationals."""
    sigma = sign(arm.delta)
    m, w, den = subsidy(arm, beta, c)
    def value(x):
        baseline = (arm.s + m) / (1 - beta) + (x - arm.s) / (1 - beta * arm.rho)
        return baseline + w * peak(arm, beta, sigma, c, x)[0]
    v = value(b)
    passive = b + m + beta * value(arm.tau(b))
    active = b + beta * ((1 - b) * value(arm.a0) + b * value(arm.a1))
    assert v == max(passive, active)
    w_b = index(arm, beta, b)
    assert sign(passive - active) == sign(m - w_b)
    return {"b": str(b), "c": str(c), "m": str(m), "denominator": str(den),
            "bellman_value": str(v), "action_gap": str(passive-active)}


def determinant_check(beta, e0, e1, z0, z1):
    original = 1-beta*(e0*(1-z0)+e1*z1)+beta*beta*e0*e1*(z1-z0)
    positive = ((1-beta*e0)*(1-beta*e1)
                +beta*e0*z0*(1-beta*e1)
                +beta*e1*(1-z1)*(1-beta*e0))
    assert original == positive and positive >= (1-beta)**2 > 0


def main():
    beta = Q(19, 20)
    cases = [
        ("reverse_split", Arm(Q(1,20),Q(19,20),Q(2,25),Q(99,100))),
        ("forward_split", Arm(Q(1,20),Q(19,20),Q(3,20),Q(49,50))),
        ("reverse_nib", Arm(Q(1,100),Q(4,5),Q(1,10),Q(99,100))),
        ("forward_nib", Arm(Q(1,100),Q(4,5),Q(1,5),Q(9,10))),
        ("flat", Arm(Q(1,10),Q(4,5),Q(1,5),Q(9,10))),
    ]
    checks = 0
    records = []
    beliefs = [Q(0),Q(1,10),Q(1,4),Q(1,2),Q(3,4),Q(9,10),Q(1)]
    for name, arm in cases:
        points = sorted(set(beliefs+[arm.a0,arm.a1,arm.s]+[
            arm.iterate(a,k) for a in (arm.a0,arm.a1) for k in (1,2,5)]))
        row = {"name":name,"parameters":{k:str(getattr(arm,k)) for k in ("p0","p1","a0","a1")},
               "beta":str(beta),"beta_persistence_sum":str(beta*(arm.rho+arm.alpha)),
               "beyond_2021_sufficient_region":beta*(arm.rho+arm.alpha)>1,
               "indices":[]}
        for b in points:
            row["indices"].append({"b":str(b),"discounted":str(index(arm,beta,b)),
                                   "average_limit":str(average_index(arm,b))})
            if arm.delta:
                c = threshold_parameter(arm,beta,b)
                exact = assert_bellman(arm,beta,c,b)
                assert exact["action_gap"] == "0"
                checks += 1
        if arm.delta:
            sig = sign(arm.delta)
            vals = [index(arm,beta,b) for b in points]
            assert all(sig*(y-x)>0 for x,y in zip(vals,vals[1:]))
            av = [average_index(arm,b) for b in points]
            assert all(sig*(y-x)>=0 for x,y in zip(av,av[1:]))
            for c in [Q(-3),Q(-1),Q(0),arm.s,Q(1,2),Q(1),Q(2),Q(5)]:
                for b in points:
                    assert_bellman(arm,beta,c,b)
                    checks += 1
            mstar = average_index(arm, arm.s)
            row["critical_average_subsidy"] = str(mstar)
        else:
            m = index(arm,beta,Q(1,2))
            assert all(index(arm,beta,b)==m for b in points)
            row["all_actions_tied_at_subsidy"] = str(m)
        records.append(row)
    # Independent finite envelope check, using explicit exact upper bounds on tails.
    envelope_checks = 0
    for _,arm in cases[:-1]:
        sig = sign(arm.delta)
        for c in [Q(-1),Q(0),arm.s-Q(1,100),arm.s,arm.s+Q(1,100),Q(1)]:
            for x in [Q(0),arm.a0,arm.s,arm.a1,Q(1)]:
                answer,k,_ = peak(arm,beta,sig,c,x)
                M = max(Q(0),sig*(x-c),sig*(arm.s-c))
                K = 0
                observed = Q(0)
                if M:
                    while not (observed > 0 and observed >= beta**K*M):
                        observed = max(observed,beta**K*sig*(arm.iterate(x,K)-c))
                        K += 1
                assert observed == answer
                envelope_checks += 1
    # Explicit neighboring maximizer tie from the independent threshold reviewer.
    tie_arm = Arm(Q(1,4),Q(3,4),Q(3,10),Q(9,10))
    f,k,ties=peak(tie_arm,Q(1,2),1,Q(13,32),Q(1,4))
    assert (f,k,ties)==(Q(1,128),2,[3])
    determinant_checks=0
    for e0 in [Q(0),Q(1,3),Q(1)]:
        for e1 in [Q(0),Q(2,3),Q(1)]:
            for z0 in [Q(0),Q(1,4),Q(1)]:
                for z1 in [Q(0),Q(3,4),Q(1)]:
                    determinant_check(beta,e0,e1,z0,z1)
                    determinant_checks+=1
    # The average indifference plateau is exact, not a floating point pattern.
    plateau_arm=cases[2][1]
    plateau=[plateau_arm.s,(plateau_arm.s+plateau_arm.a0)/2,plateau_arm.a0]
    plateau_values=[average_index(plateau_arm,b) for b in plateau]
    assert len(set(plateau_values))==1
    # The two exact examples used in the normative manuscript.
    flat_arm=Arm(Q(1,10),Q(1,2),Q(1,5),Q(3,5))
    flat_beta=Q(1,2)
    flat_m=Q(1,16)
    flat_value=lambda b: Q(1,4)+Q(5,4)*b
    for b in [Q(0),flat_arm.a0,flat_arm.tau(flat_arm.a1),flat_arm.a1,Q(1)]:
        vp=b+flat_m+flat_beta*flat_value(flat_arm.tau(b))
        va=b+flat_beta*((1-b)*flat_value(flat_arm.a0)+b*flat_value(flat_arm.a1))
        assert vp==va==flat_value(b)
    average_example=Arm(Q(1,10),Q(1,5),Q(1,5),Q(1,2))
    example_b=Q(3,20)
    example_m=Q(11,63)
    r0bar=(average_example.a0-average_example.p0)/(1-average_example.rho)
    r1bar=average_example.delta/(1-average_example.rho)
    def average_gap(c):
        u=lambda x: r1bar/(1-average_example.alpha)*max(Q(0),x-c)
        return (r0bar+r1bar*example_b-example_m
                +(1-example_b)*u(average_example.a0)+example_b*u(average_example.a1)
                -u(average_example.tau(example_b)))
    assert average_index(average_example,example_b)==example_m
    assert average_gap(average_example.a0)==-Q(1,63)
    assert average_gap(example_b)==0
    result={"status":"passed","arithmetic":"fractions.Fraction; exact",
            "bellman_and_action_checks":checks,"independent_envelope_checks":envelope_checks,
            "determinant_checks":determinant_checks,
            "adjacent_waiting_tie":{"beta":"1/2","rho":"1/2","s":"1/2","x":"1/4",
                                    "c":"13/32","k":[2,3],"value":"1/128"},
            "average_plateau":{"beliefs":[str(b) for b in plateau],
                               "index":str(plateau_values[0])},
            "manuscript_examples":{
                "flat_dual_policy":{"subsidy":"1/16","reachable_middle_belief":"17/50",
                                    "value_affine_coefficients":["1/4","5/4"]},
                "canonical_average_plateau":{"subsidy":"11/63","belief":"3/20",
                                             "canonical_action_gap":"-1/63",
                                             "alternative_bias_action_gap":"0"}},
            "cases":records,
            "scope":"Finite exact diagnostics of general handwritten theorems; no machine-checked proof."}
    destination=Path(__file__).resolve().parents[1]/"results"/"exact_verification.json"
    destination.parent.mkdir(exist_ok=True)
    destination.write_text(json.dumps(result,indent=2,ensure_ascii=False)+"\n")
    print(json.dumps({k:result[k] for k in ("status","bellman_and_action_checks",
                                         "independent_envelope_checks","determinant_checks")}))


if __name__ == "__main__":
    main()
