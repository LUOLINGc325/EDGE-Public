"""Independent exact verification of a CVZ swap-rounding counterexample.

One independent reviewer wrote two implementations: (1) a literal complete
coin tree, using sets and the original two-base update, and (2) direct product
enumeration of the prepaired sorted differences. Neither imports the main
certificate program. The two implementations are not two different reviewers.

All labels are one-based. Only the Python standard library is required.
The parameter checks are exact finite verification, not a proof for all reals.

Reference: CVZ FOCS 2010, Section IV MergeBases and SwapRound.
https://chekuri.cs.illinois.edu/papers/swap-rounding-focs.pdf
"""
from collections import defaultdict
from fractions import Fraction as Q
from hashlib import sha256
from itertools import combinations, product
from pathlib import Path
import argparse
import json

GROUND = frozenset(range(1, 7))
BASES = (frozenset((1, 2, 3)), frozenset((1, 2, 4)), frozenset((3, 5, 6)))


def is_base(basis):
    return basis <= GROUND and len(basis) == 3


def merge_tree(a, left, b, right, trace=()):
    """Literal CVZ MergeBases tree. No truncation or terminal table is used."""
    assert a > 0 and b > 0
    assert is_base(left) and is_base(right)
    if left == right:
        return [(left, Q(1), trace)]
    left_difference, right_difference = left - right, right - left
    assert left_difference and right_difference
    i, j = min(left_difference), min(right_difference)
    assert i in left_difference and j in right_difference
    assert all(i <= value for value in left_difference)
    assert all(j <= value for value in right_difference)
    new_right = right - {j} | {i}
    new_left = left - {i} | {j}
    assert is_base(new_right) and is_base(new_left)
    assert len(left ^ new_right) == len(left ^ right) - 2
    assert len(new_left ^ right) == len(left ^ right) - 2
    right_probability, left_probability = a/(a+b), b/(a+b)
    assert 0 < right_probability < 1 and 0 < left_probability < 1
    assert right_probability + left_probability == 1
    results = []
    for new_l, new_r, coin, probability in (
            (left, new_right, "right<-left", right_probability),
            (new_left, right, "left<-right", left_probability)):
        node = {"left": sorted(left), "right": sorted(right),
                "exchange": [i, j], "coin": coin,
                "coin_probability": str(probability)}
        for basis, prob, history in merge_tree(a, new_l, b, new_r, trace+(node,)):
            assert is_base(basis)
            results.append((basis, probability * prob, history))
    assert all(prob > 0 for _,prob,_ in results)
    assert sum(prob for _, prob, _ in results) == 1
    return results


def tree_round(weights):
    a,b,c = weights
    assert a+b+c == 1
    first = merge_tree(a, BASES[0], b, BASES[1])
    leaves = []
    for intermediate, p, first_trace in first:
        for final, conditional, second_trace in merge_tree(a+b, intermediate, c, BASES[2]):
            leaves.append({"intermediate":sorted(intermediate), "basis":sorted(final),
                           "probability":str(p*conditional),
                           "merge_1_trace":list(first_trace),
                           "merge_2_trace":list(second_trace)})
    distribution = defaultdict(Q)
    for leaf in leaves:
        distribution[tuple(leaf["basis"])] += Q(leaf["probability"])
    assert len(leaves) == 12 and len(distribution) == 11
    assert all(p > 0 for p in distribution.values())
    assert sum(distribution.values()) == 1
    return dict(distribution), leaves


def paired_round(weights):
    """Separate exact product implementation of the fixed minimum rule.

    In one merge, removing the two current minimum differences is independent
    of the coin result: either choice makes the selected labels common/absent.
    Hence sorted differences are paired in advance. This implementation never
    calls merge_tree and never uses the displayed final probability table.
    """
    law = {tuple(sorted(BASES[0])): Q(1)}
    accumulated = weights[0]
    for supplied_basis, supplied_weight in zip(BASES[1:],weights[1:]):
        next_law = defaultdict(Q)
        probability = accumulated/(accumulated+supplied_weight)
        for state, mass in law.items():
            current = frozenset(state)
            intersection = current & supplied_basis
            left = sorted(current - supplied_basis)
            right = sorted(supplied_basis - current)
            assert len(left) == len(right)
            for choices in product((False,True),repeat=len(left)):
                result = set(intersection)
                conditional = Q(1)
                for take_left,i,j in zip(choices,left,right):
                    result.add(i if take_left else j)
                    conditional *= probability if take_left else 1-probability
                assert result <= GROUND and len(result) == 3
                next_law[tuple(sorted(result))] += mass*conditional
        law = dict(next_law)
        accumulated += supplied_weight
        assert sum(law.values()) == 1 and all(p >= 0 for p in law.values())
    return law


def verify_case(weights):
    a,b,c = weights
    exact,leaves = tree_round(weights)
    assert exact == paired_round(weights)
    marginals = [sum(p for basis,p in exact.items() if i in basis) for i in range(1,7)]
    assert marginals == [a+b,a+b,a+c,b,c,c]
    p_event = sum(p for basis,p in exact.items() if {2,5} <= set(basis))
    p_joint = sum(p for basis,p in exact.items() if {2,3,5} <= set(basis))
    covariance = p_joint - marginals[2]*p_event
    assert p_event == p_joint == a*c
    assert covariance == a*b*c and covariance > 0
    assert p_joint/marginals[2] == a*c/(a+c)
    assert (p_event-p_joint)/(1-marginals[2]) == 0
    cylinder_count = 0
    for size in range(7):
        for subset in combinations(range(1,7),size):
            all_in = sum(p for basis,p in exact.items() if set(subset) <= set(basis))
            all_out = sum(p for basis,p in exact.items() if set(subset).isdisjoint(basis))
            product_in = product_out = Q(1)
            for i in subset:
                product_in *= marginals[i-1]
                product_out *= 1-marginals[i-1]
            assert all_in <= product_in and all_out <= product_out
            cylinder_count += 2
    return {
        "weights":list(map(str,weights)),
        "coin_tree_leaves":len(leaves),
        "distinct_outputs":len(exact),
        "law_mass":str(sum(exact.values())),
        "marginals":list(map(str,marginals)),
        "p_event":str(p_event),
        "p_joint":str(p_joint),
        "covariance":str(covariance),
        "conditional_event_given_singleton_0":"0",
        "conditional_event_given_singleton_1":str(p_joint/marginals[2]),
        "known_cylinder_inequalities_checked":cylinder_count,
        "implementations_agree_exactly":True,
        "distribution":[{"basis":list(basis),"probability":str(prob)}
                        for basis,prob in sorted(exact.items())],
        "full_coin_tree":leaves,
    }


def main(output=None):
    cases = [(Q(1,3),Q(1,3),Q(1,3)),
             (Q(1,2),Q(1,3),Q(1,6)),
             (Q(1,7),Q(2,7),Q(4,7)),
             (Q(2,5),Q(1,5),Q(2,5))]
    results = [verify_case(weights) for weights in cases]
    certificate = {
        "status":"pass",
        "scope":"four exact parameter instances; no assertion of exhaustive real-parameter verification",
        "implementation_origin":"two algorithms written by one independent reviewer",
        "algorithm_source":"https://chekuri.cs.illinois.edu/papers/swap-rounding-focs.pdf, Section IV",
        "script_sha256":sha256(Path(__file__).read_bytes()).hexdigest(),
        "input_bases":[sorted(basis) for basis in BASES],
        "label_convention":"one-based, labels 1 through 6",
        "exchange_rule":"minimum left difference, minimum right difference",
        "singleton":3,
        "event_conjunction":[2,5],
        "checks":["every coin branch enumerated", "every intermediate state is a basis",
                  "each selected exchange is legal and minimal", "symmetric difference decreases by two",
                  "every merge subtree has mass one", "no truncation used",
                  "two exact implementations give pointwise identical output laws",
                  "all six marginals equal the prescribed input", "strict positive witness covariance"],
        "parameter_instances":results,
    }
    path = Path(output) if output else Path(__file__).resolve().parent.parent/"results"/"independent_certificate.json"
    path.parent.mkdir(parents=True,exist_ok=True)
    path.write_text(json.dumps(certificate,indent=2)+"\n")
    print(json.dumps({"status":"pass","instances":len(results),
                      "covariances":[x["covariance"] for x in results],
                      "equal_weight_leaf_count":results[0]["coin_tree_leaves"],
                      "equal_weight_support_count":results[0]["distinct_outputs"],
                      "script_sha256":certificate["script_sha256"]},indent=2))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output",help="optional certificate destination")
    args = parser.parse_args()
    main(args.output)
