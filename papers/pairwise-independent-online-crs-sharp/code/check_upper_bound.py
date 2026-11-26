"""Exact finite checks for the actual masked greedy family and bad-set calculation.

All probabilities use fractions. These checks complement, and do not replace,
the uniform-in-instance proofs in manuscript/manuscript.en.md.
"""
from fractions import Fraction as F
from math import comb
from itertools import combinations
import json


def subsets(mask):
    s = mask
    while True:
        yield s
        if s == 0:
            break
        s = (s - 1) & mask


def product_law(n, q):
    return {s: q ** s.bit_count() * (1-q) ** (n-s.bit_count())
            for s in range(1 << n)}


def pi_check(n, law):
    assert sum(law.values()) == 1 and min(law.values()) >= 0
    x = [sum(p for s,p in law.items() if s & (1 << i)) for i in range(n)]
    for i,j in combinations(range(n), 2):
        pair = sum(p for s,p in law.items() if s & (1 << i) and s & (1 << j))
        assert pair == x[i] * x[j]
    return x


def thinned_law(n, law, q):
    masks = product_law(n,q)
    out = {s:F(0) for s in range(1 << n)}
    for a,p in law.items():
        for s,v in masks.items():
            out[a&s] += p*v
    return out


def partition(n, thinned, good_capacity, threshold):
    y = pi_check(n,thinned)
    bad = 0
    for i in range(n):
        if not y[i]:
            continue
        joint = sum(p for s,p in thinned.items()
                    if s & (1 << i) and s.bit_count() > good_capacity)
        if joint > threshold * y[i]:
            bad |= 1 << i
    return bad


def check_actual_small_families():
    n=4
    laws = [
        ('independent_fair',product_law(n,F(1,2))),
        ('even_parity', {s:F(1,8) for s in range(1<<n) if s.bit_count()%2==0}),
        ('odd_parity', {s:F(1,8) for s in range(1<<n) if s.bit_count()%2==1}),
        ('zero_and_unit_marginals',{4:F(1,4),5:F(1,4),6:F(1,4),7:F(1,4)}),
    ]
    report=[]
    total=0
    for name,law in laws:
        x=pi_check(n,law)
        for q in [F(1,2),F(2,3)]:
            masks=product_law(n,q)
            dprime=thinned_law(n,law,q)
            for h,g in [(0,2),(1,1),(2,0)]:
                bad=partition(n,dprime,g,F(2,3))
                good=((1<<n)-1)^bad
                succ=[F(0)]*n
                for active,p in law.items():
                    for mask,v in masks.items():
                        feasible=lambda s: (s & ~mask == 0 and
                            (s & bad).bit_count() <= h and
                            (s & good).bit_count() <= g)
                        assert feasible(0)
                        for s in range(1<<n):
                            if feasible(s):
                                assert s.bit_count()<=h+g
                                assert all(feasible(t) for t in subsets(s))
                        witness_sets=[s for s in subsets(active) if feasible(s)]
                        for i in range(n):
                            bit=1<<i
                            core=bool(active&bit) and all(feasible(s|bit) for s in witness_sets)
                            bucket,capacity=(bad,h) if bad&bit else (good,g)
                            formula=bool(active&mask&bit) and (active&mask&bucket).bit_count()<=capacity
                            assert core==formula,(name,q,h,g,active,mask,i)
                            succ[i]+=p*v*core
                            total+=1
                report.append({'law':name,'retention':str(q),'good_capacity':g,
                  'bad_capacity':h,'bad_indices':[i for i in range(n) if bad&(1<<i)],
                  'conditional_selectability':[str(succ[i]/x[i]) if x[i] else None for i in range(n)]})
    return {'instances':len(report),'actual_core_event_checks':total,'samples':report}


def binomial_tail(n, threshold, q):
    return sum((F(comb(n,j))*q**j*(1-q)**(n-j)
                for j in range(max(0,threshold),n+1)),F(0))


def probability_record(x):
    return {'exact':str(x),'decimal':float(x)}


def affine_instance():
    # Over F_257, U,V uniform, regular X_a=1[aU+V<128], rare X_*=1[U=0].
    # The map to any two distinct regular coordinates is invertible; checking
    # (0,1) below is supplemented by this field-linear proof in REPRODUCTION.
    p,a,k=257,128,129
    q,delta=F(3,5),F(1,5)
    h=(k*delta.numerator+delta.denominator-1)//delta.denominator
    g=k-h
    counts=[0]*6
    for u in range(p):
        for v in range(p):
            x0=v<a; x1=(u+v)%p<a; rare=u==0
            for j,b in enumerate([x0,x1,rare,x0 and x1,x0 and rare,x1 and rare]):
                counts[j]+=b
    x,rare_x=F(a,p),F(1,p)
    assert F(counts[0],p*p)==x and F(counts[2],p*p)==rare_x
    assert F(counts[3],p*p)==x*x
    assert F(counts[4],p*p)==x*rare_x and F(counts[5],p*p)==x*rare_x
    assert p*x+rare_x<=k and delta**3*k>=1
    tail257=binomial_tail(257,g,q)
    tail127=binomial_tail(127,g,q)
    conditional_regular=F(1,p)*tail257+F(p-1,p)*tail127
    conditional_rare=F(a,p)*tail257
    assert conditional_regular<=2*delta<conditional_rare
    overload=F(a,p*p)*binomial_tail(258,g+1,q)+F(p-1,p)*binomial_tail(128,g+1,q)
    assert overload<=delta
    bad_mass=q/p
    assert bad_mass<=overload*(1-overload)/(2*delta-overload)**2
    assert bad_mass<=1/delta
    regular_success=q*(1-F(1,p)*binomial_tail(256,g,q)-F(p-1,p)*tail127)
    rare_success=q
    assert min(regular_success,rare_success)>=q*(1-2*delta)
    return {'prime':p,'regular_items':p,'rare_items':1,'capacity':k,
      'regular_marginal':str(x),'rare_marginal':str(rare_x),
      'pairwise_counts_representative_coordinates':counts,
      'retention':str(q),'delta':str(delta),'good_capacity':g,'bad_capacity':h,
      'bad_set':['rare item'],'total_overload_probability':probability_record(overload),
      'conditional_overload_regular':probability_record(conditional_regular),
      'conditional_overload_rare':probability_record(conditional_rare),
      'regular_selectability':probability_record(regular_success),
      'rare_selectability':str(rare_success),'proved_formula_lower_bound':str(q*(1-2*delta))}


def weighted_sufficiency():
    weights=[F(1,10),F(3,5),F(3,5)]
    n=3; capacity=F(1)
    weight=lambda s:sum((weights[i] for i in range(n) if s&(1<<i)),F(0))
    checks=0
    for active in range(1<<n):
        for mask in range(1<<n):
            feasible=lambda s:s&~mask==0 and weight(s)<=capacity
            for i in range(n):
                bit=1<<i
                actual=bool(active&bit) and all(feasible(s|bit) for s in subsets(active) if feasible(s))
                sufficient=bool(active&mask&bit) and weight(active&mask)<=capacity
                assert not sufficient or actual
                checks+=1
    all_set=(1<<n)-1
    assert weight(all_set)>capacity
    assert all(weight(s|1)<=capacity for s in subsets(all_set) if weight(s)<=capacity)
    return {'checks':checks,'necessity_counterexample':{'weights':list(map(str,weights)),
      'capacity':str(capacity),'active_total_weight':str(weight(all_set)),
      'distinguished_item':0,'robust_core_contains_distinguished':True,
      'interpretation':'Pathwise illustration only, outside the small-d theorem range.'}}


if __name__=='__main__':
    print(json.dumps({'status':'passed','arithmetic':'exact rational',
      'scope':'Finite implementation checks, not a substitute for the general proof.',
      'small_families':check_actual_small_families(),
      'nontrivial_affine_bad_set':affine_instance(),
      'weighted_sufficient_event':weighted_sufficiency()},indent=2))
