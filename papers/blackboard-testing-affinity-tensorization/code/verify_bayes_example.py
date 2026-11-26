"""Exact finite Bayes-risk boundary example, using only Python's standard library.

Run: python verify_bayes_example.py
All arithmetic is rational. Exhaustive protocol optimization is an additional
small-instance diagnostic; the explicit tree and nine-entry table suffice for
the stated strict separation.
"""

from fractions import Fraction
from functools import lru_cache
from itertools import product
import json


P = (Fraction(1, 10), Fraction(3, 10), Fraction(6, 10))
Q = (Fraction(3, 10), Fraction(4, 10), Fraction(3, 10))
FULL = 7
PARTITIONS = ((1, 6), (2, 5), (4, 3))


def mass(law, subset):
    return sum((law[i] for i in range(3) if subset & (1 << i)), Fraction(0))


def leaf_risk(s, t):
    return min(mass(P, s) * mass(P, t), mass(Q, s) * mass(Q, t)) / 2


def bipartitions(s):
    """Every unordered nontrivial bipartition exactly once."""
    for a in range(1, s):
        if a & s == a and a & (s & -s):
            yield a, s ^ a


@lru_cache(None)
def optimum(s, t, b1, b2):
    value = leaf_risk(s, t)  # The protocol may stop now.
    if b1:
        for a, c in bipartitions(s):
            value = min(value, optimum(a, t, b1 - 1, b2)
                        + optimum(c, t, b1 - 1, b2))
    if b2:
        for a, c in bipartitions(t):
            value = min(value, optimum(s, a, b1, b2 - 1)
                        + optimum(s, c, b1, b2 - 1))
    return value


matrix = [
    [sum((leaf_risk(s, t) for s, t in product(a, b)), Fraction(0))
     for b in PARTITIONS]
    for a in PARTITIONS
]
all_partitions = PARTITIONS + ((FULL,),)
independent = min(
    sum((leaf_risk(s, t) for s, t in product(a, b)), Fraction(0))
    for a, b in product(all_partitions, repeat=2)
)
# First split X1 into {1,2}|{3}; then split X2 at {1,2} on the
# first branch and at {1} on the second branch.
explicit_leaves = ((3, 3), (3, 4), (4, 1), (4, 6))
explicit_leaf_risks = [leaf_risk(s, t) for s, t in explicit_leaves]
explicit = sum(explicit_leaf_risks, Fraction(0))
interactive = optimum(FULL, FULL, 1, 1)

assert matrix == [
    [Fraction(68, 200), Fraction(79, 200), Fraction(67, 200)],
    [Fraction(79, 200), Fraction(87, 200), Fraction(70, 200)],
    [Fraction(67, 200), Fraction(70, 200), Fraction(67, 200)],
]
assert independent == Fraction(67, 200)
assert explicit_leaf_risks == [Fraction(x, 200) for x in (16, 21, 6, 21)]
assert explicit == interactive == Fraction(8, 25)

print(json.dumps({
    "p": [str(x) for x in P],
    "q": [str(x) for x in Q],
    "partitions": ["{1}|{2,3}", "{2}|{1,3}", "{3}|{1,2}"],
    "matrix": [[str(x) for x in row] for row in matrix],
    "noninteractive_optimum": str(independent),
    "explicit_interactive_leaf_risks": [str(x) for x in explicit_leaf_risks],
    "explicit_interactive_risk": str(explicit),
    "exhaustive_interactive_optimum": str(interactive),
    "strict_gap": str(independent - explicit),
    "protocol_states_evaluated": optimum.cache_info().currsize,
    "arithmetic": "exact rational",
}, indent=2))
