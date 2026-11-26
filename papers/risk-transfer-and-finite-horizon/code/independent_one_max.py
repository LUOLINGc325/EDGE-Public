#!/usr/bin/env python3
"""Independent finite tests of the proposed one-max lower-CVaR optimum.

Only Python's standard library is required.  This program does not constitute
a proof over all randomized online algorithms.  It checks the threshold model
R_v(X)=X if X<=v, otherwise 1, including adversarial left limits.

Two separate checks are made:
1. Exhaust all rational probability vectors on specified finite threshold
   grids, calculating lower-tail CVaR by sorting the actual rewards and
   retaining exactly the worst (1-delta) mass.  These calculations are exact.
2. Construct independently optimized equal-weight n-atom threshold policies
   from their sequential endpoint inequalities.  Check each resulting policy
   again by sorting its actual rewards.  This convergence check uses floats.
"""

from __future__ import annotations

import argparse
from decimal import Decimal, localcontext
from fractions import Fraction as F
from itertools import islice
import json
import math
from pathlib import Path
import time


def compositions(total, length, prefix=()):
    if length == 1:
        yield prefix + (total,)
        return
    for first in range(total + 1):
        yield from compositions(total - first, length - 1, prefix + (first,))


def lower_cvar_exact(reward_count_pairs, denominator, delta):
    """Sort actual rewards and truncate the lower tail using integer mass units."""
    # Probability count/denominator becomes count*delta.denominator units.
    # Kept mass is exactly denominator*(1-delta.numerator/delta.denominator).
    mass_unit = delta.denominator
    target = denominator * (delta.denominator - delta.numerator)
    left = target
    retained_reward = F(0)
    for reward, count in sorted(reward_count_pairs):
        take = min(left, count * mass_unit)
        retained_reward += take * reward
        left -= take
        if left == 0:
            return retained_reward / target
    raise ArithmeticError("Probability vector has insufficient total mass")


def competitive_ratio_exact(thresholds, counts, theta, delta):
    denominator = sum(counts)
    worst = F(1)
    worst_prefix = None
    n = len(thresholds)
    # Prefix j corresponds to a maximum immediately below threshold[j].
    # At j=n the maximum is theta and every threshold succeeds.
    # Checking prefixes containing zero-mass points is redundant but harmless.
    for j in range(n + 1):
        offline = thresholds[j] if j < n else theta
        rewards = [(thresholds[i] if i < j else F(1), counts[i])
                   for i in range(n)]
        cvar = lower_cvar_exact(rewards, denominator, delta)
        ratio = offline / cvar
        if ratio > worst:
            worst = ratio
            worst_prefix = j
    return worst, worst_prefix


def terminal_exact(alpha, delta):
    """Evaluate the claimed finite polynomial exactly when delta>0."""
    if delta <= 0:
        raise ValueError("Use rational exponential lower bound for delta=0")
    total = F(1)
    rate = alpha / (1 - delta)
    j = 1
    while j * delta < 1:
        total += rate**j * (1-j*delta)**j / math.factorial(j)
        j += 1
    return 1 + (alpha-1) * total


def claimed_root(theta, delta):
    """High-precision bisection, independent of either policy implementation."""
    with localcontext() as ctx:
        ctx.prec = 70
        d = Decimal(delta.numerator) / Decimal(delta.denominator)
        target = Decimal(theta.numerator) / Decimal(theta.denominator)

        def terminal(a):
            if not delta:
                return 1 + (a-1) * a.exp()
            rate = a / (1-d)
            total = Decimal(1)
            j = 1
            while j * delta < 1:
                total += rate**j * (1-j*d)**j / Decimal(math.factorial(j))
                j += 1
            return 1 + (a-1) * total

        lower, upper = Decimal(1), target.sqrt()
        for _ in range(225):
            mid = (lower+upper) / 2
            if terminal(mid) < target:
                lower = mid
            else:
                upper = mid
        return str((lower+upper)/2)


def certify_not_better(alpha, theta, delta):
    """Exact positive polynomial/Taylor certificate that alpha>=claimed root."""
    if delta:
        residual = terminal_exact(alpha, delta) - theta
        return residual >= 0, str(residual), "exact finite polynomial"
    # e^alpha >= its positive Taylor truncation for alpha>=0.
    term = F(1)
    lower_exp = term
    for j in range(1, 61):
        term *= alpha / j
        lower_exp += term
    residual = 1 + (alpha-1) * lower_exp - theta
    return residual >= 0, str(residual), "exact degree-60 exponential lower bound"


def exhaustive_check(theta, thresholds, delta, denominator):
    best = None
    best_counts = None
    tested = 0
    for counts in compositions(denominator, len(thresholds)):
        ratio, _ = competitive_ratio_exact(thresholds, counts, theta, delta)
        tested += 1
        if best is None or ratio < best:
            best, best_counts = ratio, counts
    certified, residual, method = certify_not_better(best, theta, delta)
    if not certified:
        raise AssertionError((theta, delta, best, residual))
    return {
        "theta": str(theta), "delta": str(delta),
        "threshold_grid": [str(x) for x in thresholds],
        "probability_denominator": denominator,
        "distributions_exhausted": tested,
        "best_ratio_exact": str(best), "best_ratio_float": float(best),
        "best_counts": best_counts,
        "claimed_optimum": claimed_root(theta, delta),
        "no_better_grid_policy_certificate": method,
        "certificate_residual_exact": residual,
        "certificate_nonnegative": certified,
    }


def lower_cvar_float(reward_probability_pairs, kept_mass):
    left = kept_mass
    total = 0.0
    for reward, prob in sorted(reward_probability_pairs):
        take = min(left, prob)
        total += take * reward
        left -= take
        if left <= 2e-15:
            break
    if left > 1e-10:
        raise ArithmeticError("insufficient probability mass")
    return total / kept_mass


def direct_policy_ratio(thresholds, theta, delta):
    n = len(thresholds)
    q = float(1-delta)
    worst = 1.0
    for j in range(n + 1):
        offline = thresholds[j] if j < n else float(theta)
        rewards = [(thresholds[i] if i < j else 1.0, 1.0/n)
                   for i in range(n)]
        worst = max(worst, offline/lower_cvar_float(rewards, q))
    return worst


def uniform_endpoint_policy(alpha, delta, n):
    """Optimal endpoint envelope for fixed equal atom weights.

    If j thresholds have succeeded then n-j rewards are 1.  Sorting and
    retaining the worst 1-delta mass retains j-n*delta units among the
    smallest successful thresholds.  Set the next threshold to alpha times
    that retained mean.  Monotonicity makes this the greatest feasible next
    threshold under a given competitive-ratio budget.
    """
    q = float(1-delta)
    values = []
    prefix_sums = [0.0]
    for j in range(n + 1):
        successful_units = F(j) - n*delta
        if successful_units <= 0:
            cvar = 1.0
        else:
            full = successful_units.numerator // successful_units.denominator
            fractional = float(successful_units - full)
            kept_successes = prefix_sums[full]
            if fractional:
                kept_successes += fractional * values[full]
            cvar = ((n-j)/n + kept_successes/n) / q
        endpoint = alpha * cvar
        if j == n:
            return endpoint, values
        values.append(endpoint)
        prefix_sums.append(prefix_sums[-1] + endpoint)


def equal_atom_check(theta, delta, n):
    lo, hi = 1.0, math.sqrt(float(theta)) + 1e-12
    for _ in range(65):
        mid = (lo+hi)/2
        endpoint, _ = uniform_endpoint_policy(mid, delta, n)
        if endpoint < float(theta):
            lo = mid
        else:
            hi = mid
    alpha = hi
    terminal, values = uniform_endpoint_policy(alpha, delta, n)
    direct = direct_policy_ratio(values, theta, delta)
    claim = float(claimed_root(theta, delta))
    if alpha + 1e-10 < claim:
        raise AssertionError(("formula violation",theta,delta,n,alpha,claim))
    if abs(direct-alpha) > 2e-10:
        raise AssertionError(("direct sorted CVaR mismatch", direct, alpha))
    if values[0] < 1 or values[-1] > float(theta) + 1e-10:
        raise AssertionError("threshold outside the trading interval")
    if any(values[i+1] < values[i]-1e-10 for i in range(n-1)):
        raise AssertionError("thresholds not sorted")
    return {"theta":str(theta),"delta":str(delta),"equal_atoms":n,
            "endpoint_budget":alpha,"direct_sorted_reward_ratio":direct,
            "claimed_optimum":claim,"gap_above_claim":alpha-claim,
            "terminal_price_residual":terminal-float(theta),
            "threshold_range":[values[0],values[-1]]}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output",type=Path,default=Path(__file__).with_name("one_max_checks.json"))
    parser.add_argument("--denominator",type=int,default=8)
    args = parser.parse_args()
    start = time.monotonic()
    risks = [F(0),F(1,10),F(1,4),F(2,5),F(1,2),F(3,4),F(9,10)]
    grids = {
        F(2):[F(1),F(6,5),F(7,5),F(8,5),F(9,5),F(2)],
        F(4):[F(1),F(3,2),F(2),F(5,2),F(3),F(7,2),F(4)],
        F(9):[F(1),F(2),F(3),F(4),F(5),F(7),F(9)],
    }
    exact=[]
    for theta, thresholds in grids.items():
        for delta in risks:
            row=exhaustive_check(theta,thresholds,delta,args.denominator)
            exact.append(row)
            print(f"Exact theta={theta} delta={delta}: {row['distributions_exhausted']} distributions; best={row['best_ratio_exact']}",flush=True)
    floating=[]
    for theta in [F(2),F(4),F(9),F(100)]:
        for delta in risks:
            previous=float('inf')
            for n in [8,16,32,64,128,256]:
                row=equal_atom_check(theta,delta,n)
                if row['endpoint_budget']>previous+1e-10:
                    raise AssertionError("doubling atoms worsened the exact envelope optimum")
                previous=row['endpoint_budget']
                floating.append(row)
    report={
        "scope":"Finite verification only; not a proof of the general theorem or of reduction from arbitrary online algorithms.",
        "model":"R_v(X)=X if X<=v, otherwise 1; offline=v; lower CVaR retains worst 1-delta mass",
        "independence":"Written from the theorem statement and direct reward sorting; no parent implementation imported or read.",
        "exact_grid_distributions_total":sum(row['distributions_exhausted'] for row in exact),
        "exact_grid_cases":len(exact),
        "equal_atom_policy_cases":len(floating),
        "exhaustive_exact":exact,"equal_atom_float":floating,
        "finite_checks_passed":True,"elapsed_seconds":time.monotonic()-start,
    }
    args.output.write_text(json.dumps(report,ensure_ascii=False,indent=2)+"\n",encoding="utf-8")
    print(json.dumps({k:report[k] for k in ['exact_grid_distributions_total','exact_grid_cases','equal_atom_policy_cases','finite_checks_passed','elapsed_seconds']}))


if __name__ == "__main__":
    main()
