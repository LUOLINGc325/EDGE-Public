"""Exact finite checks of causal acceptance simulation and rate balancing.

Uses exhaustive two-coin enumeration at fixed identity order and clocks.
This is a regression check of the written proof, not a universal proof.
"""
from fractions import Fraction as F
from itertools import permutations, product
from collections import defaultdict
from pathlib import Path
import json


def probability(bits, rates):
    value = F(1)
    for bit, rate in zip(bits, rates):
        value *= rate if bit else 1-rate
    return value


def would_select(identity, retained, t, n):
    # A deterministic ordinal/time rule. It uses no future acceptance labels.
    relative = 1+sum(j < identity for j in retained)
    thresholds = (F(1,3), F(2,3), F(4,5), F(9,10))
    return F(t,n+1) >= thresholds[min(relative-1,3)]


def check_switching(n, order, rates, sample):
    masses = defaultdict(F)
    comparisons = 0
    tail = [i for i in order if i not in sample]
    tail_rates = [rates[i-1] for i in tail]
    for raw in product((0,1), repeat=2*len(tail)):
        actual, private = raw[::2], raw[1::2]
        mass = probability(actual,tail_rates)*probability(private,tail_rates)
        retained = list(sample)
        chosen = None
        labels = []
        for j, identity in enumerate(tail):
            t = order.index(identity)+1
            action = chosen is None and would_select(identity,retained,t,n)
            bit = actual[j] if action or chosen is not None else private[j]
            labels.append(bit)
            if chosen is None and bit:
                if action:
                    chosen = identity
                else:
                    retained.append(identity)
        masses[tuple(labels)] += mass
        virtual_history = list(sample)
        virtual_chosen = None
        for identity, bit in zip(tail,labels):
            if bit:
                if would_select(identity,virtual_history,order.index(identity)+1,n):
                    virtual_chosen = identity
                    break
                virtual_history.append(identity)
        assert chosen == virtual_chosen
        comparisons += 1
    for bits in product((0,1), repeat=len(tail)):
        assert masses[bits] == probability(bits,tail_rates)
    assert sum(masses.values(),F(0)) == 1
    return comparisons, len(masses)


def check_categories(rates, q, delta):
    """Independent sample retention p_i/q balances heterogeneous category laws."""
    n=len(rates)
    a=delta/(delta+(1-delta)*q)
    retained_mass=defaultdict(F)
    joint={}
    for categories in product((0,1,2),repeat=n):  # absent, sample, online
        mass=F(1)
        for category,p in zip(categories,rates):
            local=(1-delta*p/q-(1-delta)*p,delta*p/q,(1-delta)*p)
            assert all(0<=x<=1 for x in local)
            mass*=local[category]
        key=tuple(j for j,c in enumerate(categories) if c)
        retained_mass[key]+=mass
        joint[categories]=(key,mass)
    count=0
    for categories,(key,mass) in joint.items():
        expected=retained_mass[key]*a**categories.count(1)*(1-a)**categories.count(2)
        assert mass==expected
        count+=1
    assert sum(retained_mass.values(),F(0))==1
    for k in range(1,n+1):
        original=1-probability([0]*k,rates[:k])
        online=1-probability([0]*k,[(1-delta)*p for p in rates[:k]])
        assert online >= (1-delta)*original
    return count


def main():
    counts={"switching_instances":0,"two_coin_paths":0,
            "product_law_equalities":0,"category_equalities":0,
            "heterogeneous_tail_bounds":0}
    for n in range(1,5):
        configurations=[[F(1,3)]*n,[F((i%3)+1,4) for i in range(n)],
                        [F(0) if i%2 else F(1) for i in range(n)]]
        for rates in configurations:
            for order in permutations(range(1,n+1)):
                for prefix in (0,n//2,n):
                    paths,labels=check_switching(n,order,rates,order[:prefix])
                    counts["switching_instances"]+=1
                    counts["two_coin_paths"]+=paths
                    counts["product_law_equalities"]+=labels
    for n in range(1,6):
        for q in (F(1,5),F(1,2),F(1)):
            for rates in ([q]*n,[q*F(i+1,n+1) for i in range(n)],
                          [q if i%2 else F(0) for i in range(n)]):
                for delta in (F(1,4),F(1,2),F(2,3)):
                    counts["category_equalities"]+=check_categories(rates,q,delta)
                    counts["heterogeneous_tail_bounds"]+=n
    report={"status":"PASS","arithmetic":"fractions.Fraction",
            "counts":counts,
            "scope":"Finite exact conditional switching, selected-identity coupling, heterogeneous category balancing and tail thinning; does not replace the analytical theorem or numerically verify the imported DOS theorem."}
    dest=Path(__file__).resolve().parents[1]/"results/causal_sampling_verification.json"
    dest.write_text(json.dumps(report,indent=2)+"\n")
    print(json.dumps(report,indent=2))


if __name__=="__main__":
    main()
