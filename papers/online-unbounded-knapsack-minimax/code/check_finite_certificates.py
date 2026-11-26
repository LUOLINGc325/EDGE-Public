"""Exact finite diagnostics for the written prefix and partition certificates.

Only Python's standard library is needed. All checked quantities are rational.
This does not certify continuum, arbitrary-horizon, or entropy theorems.
"""
from fractions import Fraction as F
import argparse
import json
from pathlib import Path
import random


def check_prefix(n):
    sizes = [F(n+i+1, 2*n+1) for i in range(n+1)]
    weights = [sizes[0]*(1/sizes[i]-1/sizes[i+1]) for i in range(n)] + [sizes[0]]
    assert all(w > 0 for w in weights) and sum(weights) == 1
    for i, size in enumerate(sizes):
        assert size*sum(weights[i:]) == sizes[0]
    bound = 1+sum((F(1, j) for j in range(n+2, 2*n+2)), F(0))
    offline = sum((w*s for w, s in zip(weights, sizes)), F(0))
    assert offline == sizes[0]*bound
    acceptance = [1/bound] + [(sizes[i]-sizes[i-1])/(bound*sizes[i]) for i in range(1,n+1)]
    assert sum(acceptance) == 1
    running = F(0)
    for probability, size in zip(acceptance, sizes):
        running += probability*size
        assert running == size/bound
    return n+1


def check_partition(knots):
    thresholds = knots[:-1]
    weights = [(v-u)/u for u,v in zip(knots,knots[1:])]
    weights[0] += 1
    mass = sum(weights)
    assert mass >= F(3,2)
    assert sum(w*t for w,t in zip(weights,thresholds)) == 1
    running = F(0)
    for i,(w,t) in enumerate(zip(weights,thresholds)):
        running += w*t
        assert running == knots[i+1]
    for numerator in range(61,121):
        maximum = F(numerator,120)
        truncated = sum((w*t for w,t in zip(weights,thresholds) if t <= maximum),F(0))
        assert truncated >= maximum
    checked = 0
    for numerator in range(41,61):
        small = F(numerator,120)
        a,b = 1-small,2*small
        clipped = sum((w*min(b,max(a,t)) for w,t in zip(weights,thresholds)),F(0))
        lower = 1+(1-b)*(b-F(1,2))
        assert clipped >= lower >= 1
        checked += 1
    return checked


def run():
    prefix_positions = sum(check_prefix(n) for n in range(1,65))
    rng = random.Random(20261125)
    partitions = [[F(1,2),F(1)]]
    for _ in range(127):
        interior = sorted(rng.sample(range(51,100),rng.randrange(1,13)))
        partitions.append([F(1,2)]+[F(x,100) for x in interior]+[F(1)])
    clip_count = sum(check_partition(knots) for knots in partitions)
    return {
        "result":"PASSED_ALL_LISTED_FINITE_CERTIFICATES",
        "arithmetic":"fractions.Fraction, exact rational arithmetic",
        "prefix_families":64,
        "deterministic_acceptance_positions":prefix_positions,
        "partitions":len(partitions),
        "large_maximum_checks":len(partitions)*60,
        "clipping_checks":clip_count,
        "seed":20261125,
        "limitations":["Finite certificate diagnostics only", "No continuum or entropy proof certification", "No Lean kernel verification"]
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--out",type=Path)
    args = parser.parse_args()
    result = run()
    if args.out:
        args.out.write_text(json.dumps(result,indent=2)+"\n",encoding="utf-8")
    print(json.dumps(result))
