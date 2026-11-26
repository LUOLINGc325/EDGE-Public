#!/usr/bin/env python3
"""Enumerate all 2^18 inputs of E T^7 E^10 using physical completion times.

This checker independently constructs the actual time line.  It does not
import the Bellman or analytic verifiers and does not use the rank cost
formula to compute the algorithm's objective.
"""

import argparse
import json
from pathlib import Path
import time


def physical_cost(bits, p, x):
    elapsed = 0
    completion_sum = 0
    pending_long = 0
    for index, is_long in enumerate(bits):
        if 1 <= index <= 7:
            elapsed += 1  # Oracle query; this is not a job completion.
            if is_long:
                pending_long += 1
            else:
                elapsed += p
                completion_sum += elapsed
        else:
            elapsed += p+x*is_long
            completion_sum += elapsed
    for _ in range(pending_long):
        elapsed += p+x
        completion_sum += elapsed
    return completion_sum


def run(output):
    started = time.monotonic()
    n,p,x = 18,1260,3
    maxima = [-1,-1]
    maximizing_bits = [[],[]]
    upper_formula_failures = 0
    equality_count = 0
    for mask in range(1<<n):
        bits = tuple((mask>>i)&1 for i in range(n))
        long_count = sum(bits)
        alg = physical_cost(bits,p,x)
        # The offline optimum uses the known shortest-processing-time order.
        sorted_elapsed = 0
        opt = 0
        for is_long in sorted(bits):
            sorted_elapsed += p+x*is_long
            opt += sorted_elapsed
        regret = alg-opt
        first = bits[0]
        shorts_in_tests = 7-sum(bits[1:8])
        longs_in_tail = sum(bits[8:])
        s,k = shorts_in_tests,longs_in_tail
        if first:
            upper = 149+3*s-s*(s-1)//2+3*k*(9-k)
        else:
            upper = 119-s*(s-1)//2+3*k*(10-k)
        if regret>upper:
            upper_formula_failures += 1
        if regret==upper:
            equality_count += 1
        if regret>maxima[first]:
            maxima[first] = regret
            maximizing_bits[first] = [''.join(map(str,bits))]
        elif regret==maxima[first]:
            maximizing_bits[first].append(''.join(map(str,bits)))
        # The common p contribution cancels in the regret; independently
        # check this on every input using a second physical schedule.
        alg_small = physical_cost(bits,1,x)
        opt_small = n*(n+1)//2+x*long_count*(long_count+1)//2
        assert alg_small-opt_small==regret
    assert maxima==[194,215]
    assert upper_formula_failures==0
    result = {
        "status":"PASS",
        "n":n,"x":x,"physical_p_checks":[p,1],
        "strategy":"E T^7 E^10; tested short jobs immediate; tested long jobs at end",
        "inputs_enumerated":1<<n,
        "first_untested_short_max_regret":maxima[0],
        "first_untested_long_max_regret":maxima[1],
        "worst_case_regret":max(maxima),
        "maximizers_by_first_bit":maximizing_bits,
        "formula_upper_bound_violations":upper_formula_failures,
        "formula_equality_inputs":equality_count,
        "bit_convention":"0=short, 1=long; bits ordered by unknown-job processing order",
        "arithmetic":"integer physical schedule completion times",
        "seconds":time.monotonic()-started,
    }
    output.parent.mkdir(parents=True,exist_ok=True)
    output.write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps(result,indent=2))


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output",type=Path,
                        default=Path(__file__).resolve().parents[1]/"results"/"fixed_word_exhaustive.json")
    args=parser.parse_args()
    run(args.output)


if __name__=="__main__":
    main()
