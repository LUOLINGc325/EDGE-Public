"""Finite diagnostics for the ROC frontier manuscript.

This file verifies finite rational inequalities and independent finite-horizon
calculations. It does not certify infinite series, all policies, or any theorem.
Run with Python 3; the Gaussian diagnostics additionally use scipy.
"""
from fractions import Fraction as F
from itertools import product
from collections import defaultdict
from pathlib import Path
import json
import math
import random


def exact_np_checks():
    # True neutral posterior is uniform on (0,1): A(x)=2x-x^2, C(x)=x^2.
    # Exhaust all deterministic decisions on 12 equal intervals, then sample
    # 200 rational randomized decisions. Test ROC domination by exact squaring.
    m = 12
    weights_l = [2*(F(j+1,m)-F(j,m))-(F(j+1,m)**2-F(j,m)**2) for j in range(m)]
    weights_h = [F(j+1,m)**2-F(j,m)**2 for j in range(m)]
    rng = random.Random(20261126)
    rules = list(product([F(0),F(1)], repeat=m))
    rules += [tuple(F(rng.randrange(8),7) for _ in range(m)) for _ in range(200)]
    min_slack = None
    for d in rules:
        a = sum((x*y for x,y in zip(d,weights_l)), F(0))
        c = sum((x*y for x,y in zip(d,weights_h)), F(0))
        rhs = 2-a-c
        assert F(0)<=a<=1 and F(0)<=c<=1
        # c >= (1-sqrt(1-a))^2 iff 2 sqrt(1-a) >= 2-a-c.
        if rhs > 0:
            slack = 4*(1-a)-rhs*rhs
            assert slack >= 0
            min_slack = slack if min_slack is None else min(min_slack,slack)
    return {"neutral_law":"uniform(0,1)","intervals":m,
            "deterministic_rules":2**m,"rational_randomized_rules":200,
            "checked":len(rules),"all_passed":True,"arithmetic":"fractions.Fraction",
            "minimum_squared_slack":str(min_slack)}


def switch_probability(last, age, state):
    x = F(1,age+2)
    wrong_switch = 2*x-x*x
    correct_switch = x*x
    return correct_switch if last==state else wrong_switch


def enumeration(horizon, state):
    distribution = defaultdict(F)
    for actions in product([0,1], repeat=horizon):
        # Cutoff 1/2 gives a correct first action with probability 3/4.
        prob = F(3,4) if actions[0]==state else F(1,4)
        age = 1
        for k in range(1,horizon):
            p = switch_probability(actions[k-1],age,state)
            if actions[k]!=actions[k-1]:
                prob *= p
                age = 1
            else:
                prob *= 1-p
                age += 1
        distribution[sum(a!=state for a in actions)] += prob
    return dict(distribution)


def dynamic_program(horizon, state):
    # Separate state-space computation for the total number of wrong actions.
    states = {(state,1,0):F(3,4),(1-state,1,1):F(1,4)}
    for _ in range(1,horizon):
        out = defaultdict(F)
        for (last,age,w),mass in states.items():
            x=F(1,age+2)
            # Direct integration of q -> 2q or 2(1-q), independent of
            # the switch_probability implementation above.
            threshold = x if last==1 else 1-x
            low_probability = threshold**2 if state==1 else 2*threshold-threshold**2
            for a,p in [(0,low_probability),(1,1-low_probability)]:
                out[(a,age+1 if a==last else 1,w+(a!=state))] += mass*p
        states=out
    distribution=defaultdict(F)
    for (_,_,w),mass in states.items(): distribution[w]+=mass
    return dict(distribution)


def finite_run_checks():
    rows=[]
    for horizon in [1,2,3,5,8,12]:
        laws=[]
        for state in [0,1]:
            brute=enumeration(horizon,state)
            dynamic=dynamic_program(horizon,state)
            assert brute==dynamic
            assert sum(brute.values(),F(0))==1
            laws.append(brute)
        assert laws[0]==laws[1]
        rows.append({"horizon":horizon,
                     "full_histories_per_state":2**horizon,
                     "expected_errors":str(sum((w*p for w,p in laws[0].items()),F(0))),
                     "state_symmetry":True,"dp_equals_full_enumeration":True})
    # Run L includes its first wrong action: n subsequent continuations means
    # L>n. For x_k=1/(k+2), survival telescopes to (2/(n+2))^2.
    prod=F(1)
    for n in range(1,201):
        x=F(1,n+2)
        prod*=1-(2*x-x*x)
        assert prod==F(4,(n+2)**2)
    return {"arithmetic":"fractions.Fraction","horizons":rows,
            "wrong_run_index_checks":200,"all_passed":True,
            "scope":"finite horizons and a telescoping single-run identity only"}


def gaussian_diagnostics():
    from scipy.special import ndtri_exp, log_ndtr
    import scipy
    rows=[]
    for v,kappa,gamma,zeta,scale in [
        (1.0,math.sqrt(2),0.5,1.0,0.3),
        (1.0,math.sqrt(2),0.5,1.2,0.8),
        (2.0,2.0,0.8,-1.0,0.5),
        (0.5,0.7,-0.3,2.0,0.2),
    ]:
        constant=scale*kappa/2*math.exp((kappa*math.sqrt(2*v)-v)/2)
        for t in [1e3,1e5,1e8]:
            # t=log n; use the derivative equivalent of the increment.
            log_d=-t+kappa*math.sqrt(t)-(gamma+0.5)*math.log(t)-zeta*math.log(math.log(t))+math.log(kappa/2)
            log_a=math.log(scale)+log_d
            z=-float(ndtri_exp(log_a))
            log_roc=float(log_ndtr(-(z+math.sqrt(v))))
            log_shape=-t+(kappa-math.sqrt(2*v))*math.sqrt(t)-(gamma+0.5)*math.log(t)-zeta*math.log(math.log(t))
            relative=math.exp(log_roc-log_shape)/constant
            rows.append({"v":v,"kappa":kappa,"gamma":gamma,"zeta":zeta,
                         "scale":scale,"log_n":t,
                         "ratio_to_predicted_asymptotic_constant":relative})
        assert abs(rows[-1]["ratio_to_predicted_asymptotic_constant"]-1)<0.01
    return {"scipy_version":scipy.__version__,"rows":rows,
            "large_log_n_relative_error_below_one_percent":True,
            "scope":"floating-point diagnostic of Gaussian ROC asymptotics; not an interval certificate"}


def main():
    result={"kind":"finite_mathematical_diagnostics",
            "infinite_horizon_proof":False,
            "np":exact_np_checks(),"run_age":finite_run_checks(),
            "gaussian":gaussian_diagnostics()}
    target=Path(__file__).with_suffix(".json")
    target.write_text(json.dumps(result,ensure_ascii=False,indent=2)+"\n")
    print(json.dumps({"output":str(target),"np_checks":result["np"]["checked"],
                      "run_index_checks":200,"finite_horizon_comparisons":12,
                      "gaussian_diagnostic_rows":len(result["gaussian"]["rows"]),
                      "all_assertions_passed":True},ensure_ascii=False))


if __name__=="__main__":
    main()
