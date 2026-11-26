#!/usr/bin/env python3
"""Exact certificate for fixed-lexicographic CVZ SwapRound on U_{3,6}.

Run with Python 3.11+; standard library only.  This program is a computational
certificate for specified rational weights.  The all-positive-real-weight
theorem is proved in the accompanying manuscript, not inferred from this run.
"""
from collections import defaultdict
from fractions import Fraction
from itertools import combinations
import json


F = Fraction
BASES = (frozenset((1, 2, 3)), frozenset((1, 2, 4)), frozenset((3, 5, 6)))
GROUND = frozenset(range(1, 7))
RANK = 3


def legal_base(b):
    return b <= GROUND and len(b) == RANK


def merge_bases(left, right, left_weight, right_weight):
    """Literal CVZ elementary mutations, retaining an auditable path log."""
    assert legal_base(left) and legal_base(right)
    assert left_weight > 0 and right_weight > 0
    if left == right:
        return [(left, F(1), ())]
    i = min(left - right)
    j = min(right - left)
    right_next = (right - {j}) | {i}
    left_next = (left - {i}) | {j}
    assert legal_base(right_next) and legal_base(left_next)
    assert len(left ^ right_next) == len(left ^ right) - 2
    assert len(left_next ^ right) == len(left ^ right) - 2
    p = left_weight / (left_weight + right_weight)
    out = []
    for b, q, path in merge_bases(left, right_next, left_weight, right_weight):
        out.append((b, p*q, ((i, j, "retain_left_element"),)+path))
    for b, q, path in merge_bases(left_next, right, left_weight, right_weight):
        out.append((b, (1-p)*q, ((i, j, "retain_right_element"),)+path))
    assert sum((q for _, q, _ in out), F(0)) == 1
    return out


def distribution(weights):
    a, b, c = weights
    assert min(weights) > 0 and sum(weights) == 1
    out = defaultdict(F)
    paths = []
    for intermediate, p, first_path in merge_bases(BASES[0], BASES[1], a, b):
        for result, q, second_path in merge_bases(intermediate, BASES[2], a+b, c):
            out[result] += p*q
            paths.append({
                "intermediate": sorted(intermediate),
                "final": sorted(result),
                "probability": str(p*q),
                "first_merge": first_path,
                "second_merge": second_path,
            })
    assert sum(out.values()) == 1
    return dict(out), paths


def expected_distribution(weights):
    """Closed-form eleven-atom law, derived by the two conditional branches."""
    a, b, c = weights
    s = a+b
    rows = [
        ((1,2,3), a*s),
        ((1,2,4), b*s*s),
        ((1,2,6), b*s*c),
        ((1,3,6), a*c),
        ((1,4,5), b*s*c),
        ((1,5,6), b*c*c),
        ((2,3,4), b*s*c),
        ((2,3,5), a*c),
        ((2,3,6), b*c*c),
        ((3,4,5), b*c*c),
        ((3,5,6), c*c*(a+c)),
    ]
    return {frozenset(base):prob for base,prob in rows}


def event_probability(law, selected=(), excluded=()):
    selected, excluded = frozenset(selected), frozenset(excluded)
    return sum((p for b,p in law.items() if selected <= b and not (excluded & b)), F(0))


def check(weights):
    a,b,c = weights
    law, paths = distribution(weights)
    assert law == expected_distribution(weights)
    marginals = {j:event_probability(law,(j,)) for j in GROUND}
    target = {j:sum((w for B,w in zip(BASES,weights) if j in B),F(0)) for j in GROUND}
    assert marginals == target
    pi = event_probability(law,(3,))
    pf = event_probability(law,(2,5))
    pif = event_probability(law,(2,3,5))
    gap = pif-pi*pf
    assert pi == a+c
    assert pf == pif == a*c
    assert gap == a*b*c > 0
    conditional_zero = event_probability(law,(2,5),(3,))/(1-pi)
    conditional_one = pif/pi
    assert conditional_zero == 0
    assert conditional_one == a*c/(a+c) > 0
    # Exhaust the exact cylinder inequalities on this six-element instance.
    # Their validity highlights why the stronger singleton-vs-event property
    # cannot be substituted for the original theorem's cylinder property.
    cylinder_count = 0
    for size in range(7):
        for subset in combinations(sorted(GROUND),size):
            rhs_one = rhs_zero = F(1)
            for j in subset:
                rhs_one *= marginals[j]
                rhs_zero *= 1-marginals[j]
            assert event_probability(law,subset) <= rhs_one
            assert event_probability(law,excluded=subset) <= rhs_zero
            cylinder_count += 2
    return {
        "weights": [str(w) for w in weights],
        "marginals": {str(k):str(v) for k,v in sorted(marginals.items())},
        "event_probability": str(pf),
        "joint_probability": str(pif),
        "covariance": str(gap),
        "conditional_event_given_X3_zero": str(conditional_zero),
        "conditional_event_given_X3_one": str(conditional_one),
        "distinct_output_bases": len(law),
        "execution_paths": len(paths),
        "cylinder_inequalities_checked": cylinder_count,
        "law": [{"base":sorted(b),"probability":str(p)} for b,p in sorted(law.items(),key=lambda item:tuple(sorted(item[0])))],
    },paths


def main():
    samples = (
        (F(1,3),F(1,3),F(1,3)),
        (F(1,6),F(1,3),F(1,2)),
        (F(1,2),F(1,4),F(1,4)),
        (F(2,7),F(3,7),F(2,7)),
    )
    results=[]
    first_paths=None
    for weights in samples:
        result, paths=check(weights)
        results.append(result)
        if first_paths is None:first_paths=paths
    report={
        "result":"PASS",
        "matroid":"U_{3,6}",
        "ordered_bases":[sorted(b) for b in BASES],
        "exchange_rule":"i=min(left-right); j=min(right-left)",
        "probability_rule":"replace right j by left i with probability left_weight/(left_weight+right_weight); otherwise replace left i by right j",
        "witness":"Cov(X3, X2*X5) = a*b*c > 0 for a,b,c>0 and a+b+c=1",
        "proof_scope":"Four rational instances checked here; the accompanying analytic proof establishes the whole positive simplex.",
        "samples":results,
        "equal_weight_execution_tree":first_paths,
    }
    print(json.dumps(report,ensure_ascii=False,indent=2))


if __name__ == "__main__":
    main()
