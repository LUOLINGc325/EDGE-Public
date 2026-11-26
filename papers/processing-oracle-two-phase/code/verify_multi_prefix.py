#!/usr/bin/env python3
"""Check the new three-block regret formula against physical schedules.

Small cases are exhaustive over both words and binary inputs. The arbitrary
n theorem is analytic; the finite checks below do not prove its quantifiers.
The large-family checks evaluate the exact finite maxima, never 2^n inputs.
"""
from fractions import Fraction
from itertools import product
from pathlib import Path
import json


def physical_regret(bits,a,b,p,x):
    n=len(bits);time=0;total=0;pending=[]
    for j in range(b):
        time+=p+x*bits[j];total+=time
    for j in range(b,b+a):
        time+=1
        if bits[j]:pending.append(j)
        else:time+=p;total+=time
    for j in range(b+a,n):
        time+=p+x*bits[j];total+=time
    for j in pending:
        time+=p+x*bits[j];total+=time
    opttime=0;opt=0
    for bit in sorted(bits):
        opttime+=p+x*bit;opt+=opttime
    return total-opt


def exact_formula(n,a,b,x):
    c=n-a-b
    def candidate(h):
        hterm=max(x*h*s-s*(s-1)//2 for s in range(a+1))
        tail=x*max((h+k)*(c-k) for k in range(c+1))
        return x*h*(b-h)+hterm+tail
    values=[candidate(h) for h in range(b+1)]
    return a*(n-b)+max(values),values


def main():
    words=inputs=0
    for x in (3,4):
        for n in range(1,10):
            patterns=list(product((0,1),repeat=n))
            for b in range(n+1):
                for a in range(n-b+1):
                    expected,by_h=exact_formula(n,a,b,x)
                    actual=max(physical_regret(bits,a,b,7,x) for bits in patterns)
                    assert actual==expected,(n,a,b,x,actual,expected)
                    if n-a-b>=2*b:
                        assert all(v<w for v,w in zip(by_h,by_h[1:]))
                    words+=1;inputs+=len(patterns)
    family=[]
    for k in range(1,7):
        value,by_h=exact_formula(150*k,54*k,6*k,3)
        assert value==14850*k*k+9*k
        assert by_h[-1]==max(by_h)
        bound=15000*k*k
        family.append({'k':k,'n':150*k,'word_block_counts':[6*k,54*k,90*k],
                       'exact_word_regret':value,
                       'physical_two_phase_regret_from_analytic_theorem':bound,
                       'regret_gap':bound-value,
                       'sufficient_p_threshold':str(Fraction(3*value,bound-value))})
    x=Fraction(3);beta=(x-2)/(x**3-2);alpha=x*x*beta
    gamma=(x-2)**2/(2*x*(x**3-2));base=1-1/x
    assert (beta,alpha,gamma)==(Fraction(1,25),Fraction(9,25),Fraction(1,150))
    assert x*(base-gamma)/gamma==297
    result={'kind':'physical_schedule_check_of_three_block_regret_formula',
            'status':'passed','small_case_word_parameter_combinations':words,
            'physical_input_schedules_evaluated':inputs,'n_range':[1,9],'x_values':[3,4],
            'large_family_evaluation':'exact finite count maxima, not exhaustive binary inputs',
            'large_family':family,
            'universal_claim_basis':'analytic proof in the manuscript, not these finite checks',
            'formalization_status':'not_started'}
    out=Path(__file__).resolve().parents[1]/'results'/'multi_prefix_check.json'
    out.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({k:v for k,v in result.items() if k!='large_family'},indent=2))


if __name__=='__main__':main()
