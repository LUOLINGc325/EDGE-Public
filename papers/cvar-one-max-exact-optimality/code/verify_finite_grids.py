#!/usr/bin/env python3
"""Strict rational certificates for independent finite-grid OMS optima.

Generation uses SciPy LP; verification uses only Python standard-library exact
arithmetic.  No delay equation, analytic phi policy, or claimed optimum is read.
Enumerate all monotone lower-CVaR breakpoint choices.  A rational feasible dual
for every resulting LP certifies a global upper bound on reciprocal ratio.
One rational primal gives the reverse bound.  Both normally coincide exactly.
"""
from __future__ import annotations

import argparse
import json
import time
from fractions import Fraction as F
from pathlib import Path


PARAMETERS = [
    ("4", "0", None), ("4", "1/10", None), ("4", "1/4", None),
    ("4", "49/100", None), ("4", "1/2", None), ("4", "3/4", None),
    ("16", "1/4", [1, 2, 3, 4, 6, 10, 16]),
]


def require(condition, message):
    if not condition:
        raise ValueError(message)


def breakpoint_patterns(size):
    """k_j<=j and k_j<=k_(j+1); these are all Catalan-size choices."""
    def rec(j, last, prefix):
        if j == size:
            yield prefix
        else:
            for k in range(last, j+1):
                yield from rec(j+1, k, prefix+(k,))
    yield from rec(0, 0, ())


def data_rows(prices, delta, continuous, pattern):
    n = len(prices)
    h = 1-delta
    out = []
    for j, k in enumerate(pattern):
        values = [prices[i] if i <= j else F(1) for i in range(n)]
        pivot = prices[k]
        coeff = [max(pivot-value, F(0))/h for value in values]
        benchmark = prices[j+1] if continuous else prices[j]
        out.append((coeff, benchmark, pivot))
    return out


def frac(x):
    return F(float(x)).limit_denominator(10**10)


def build_case(theta, delta, continuous, prices=None):
    from scipy.optimize import linprog
    started = time.monotonic()
    theta, delta = F(theta), F(delta)
    if prices is None:
        prices = [F(1)+(theta-1)*i/6 for i in range(7)]
    prices = list(map(F, prices))
    n = len(prices)
    size = n-1 if continuous else n
    duals = []
    best_primal = None
    best_rho = None
    global_upper = None
    for pattern in breakpoint_patterns(size):
        rows = data_rows(prices, delta, continuous, pattern)
        matrix = [[float(v) for v in coeff]+[float(benchmark)]
                  for coeff, benchmark, pivot in rows]
        right = [float(pivot) for coeff, benchmark, pivot in rows]
        result = linprog([0.0]*n+[-1.0], A_ub=matrix, b_ub=right,
                         A_eq=[[1.0]*n+[0.0]], b_eq=[1.0],
                         bounds=[(0.0, None)]*n+[(None, None)], method="highs")
        if result.status != 0:
            raise RuntimeError(f"LP failed {pattern}: {result.message}")
        y = [max(frac(-v), F(0)) for v in result.ineqlin.marginals]
        normalizer = sum(row[1]*v for row, v in zip(rows, y))
        if normalizer <= 0:
            raise RuntimeError("dual normalization failed")
        y = [v/normalizer for v in y]
        mu = max(-sum(rows[j][0][i]*y[j] for j in range(size)) for i in range(n))
        upper = sum(rows[j][2]*y[j] for j in range(size))+mu
        global_upper = upper if global_upper is None else max(global_upper, upper)
        duals.append({"pattern": list(pattern), "y": list(map(str, y)), "mu": str(mu)})
        masses = [max(frac(v), F(0)) for v in result.x[:n]]
        mass_sum = sum(masses)
        masses = [v/mass_sum for v in masses]
        rho = min((pivot-sum(c*p for c,p in zip(coeff,masses)))/benchmark
                  for coeff, benchmark, pivot in rows)
        if best_rho is None or rho > best_rho:
            best_rho = rho
            best_primal = {"pattern": list(pattern), "masses": list(map(str,masses)),
                           "rho": str(rho)}
    return {"theta": str(theta), "delta": str(delta), "prices": list(map(str,prices)),
            "game": "continuum_grid_supported" if continuous else "finite_grid",
            "breakpoint_patterns": len(duals), "duals": duals,
            "best_primal": best_primal,
            "certified_rho_interval": [str(best_rho), str(global_upper)],
            "certified_ratio_interval": [str(1/global_upper),str(1/best_rho)],
            "elapsed_seconds_generation": time.monotonic()-started}


def direct_sort_cvar(prices, masses, h, j):
    outcomes = [(prices[i] if i<=j else F(1), masses[i]) for i in range(len(prices))]
    outcomes.sort()
    remaining = h
    total = F(0)
    for value, probability in outcomes:
        take = min(remaining, probability)
        total += take*value
        remaining -= take
        if remaining == 0:
            break
    if remaining != 0:
        raise AssertionError("invalid probability total")
    return total/h


def verify_case(case):
    prices = list(map(F,case["prices"]))
    delta = F(case["delta"])
    require(case["game"] in ("continuum_grid_supported", "finite_grid"),
            "unknown game type")
    continuous = case["game"] == "continuum_grid_supported"
    n = len(prices)
    require(n >= 2 and prices[0] == 1 and prices[-1] == F(case["theta"]),
            "invalid price endpoints")
    require(all(a < b for a,b in zip(prices,prices[1:])), "nonincreasing prices")
    require(0 <= delta < 1, "invalid risk parameter")
    size = n-1 if continuous else n
    expected = set(breakpoint_patterns(size))
    actual = [tuple(row["pattern"]) for row in case["duals"]]
    require(case["breakpoint_patterns"] == len(actual), "incorrect pattern count")
    require(len(actual) == len(set(actual)), "duplicate breakpoint pattern")
    require(set(actual) == expected, "incomplete breakpoint coverage")
    upper_values = []
    for cert in case["duals"]:
        rows = data_rows(prices,delta,continuous,tuple(cert["pattern"]))
        y = list(map(F,cert["y"]))
        mu = F(cert["mu"])
        require(len(y) == size and all(v>=0 for v in y), "invalid dual weights")
        require(sum(rows[j][1]*y[j] for j in range(size)) == 1,
                "dual rho coefficient is not exactly one")
        for i in range(n):
            require(sum(rows[j][0][i]*y[j] for j in range(size))+mu >= 0,
                    "dual probability coefficient is negative")
        upper_values.append(sum(rows[j][2]*y[j] for j in range(size))+mu)
    global_upper = max(upper_values)
    primal = case["best_primal"]
    primal_pattern = tuple(primal["pattern"])
    require(len(primal_pattern) == size and primal_pattern in expected,
            "primal breakpoint pattern is not an admissible full pattern")
    masses = list(map(F,primal["masses"]))
    rho = F(primal["rho"])
    require(len(masses) == n and all(p>=0 for p in masses) and sum(masses)==1,
            "invalid primal probabilities")
    rows = data_rows(prices,delta,continuous,primal_pattern)
    for coeff, benchmark, pivot in rows:
        require(sum(c*p for c,p in zip(coeff,masses))+benchmark*rho <= pivot,
                "primal inequality failed")
    require(rho > 0 and rho <= global_upper, "invalid primal-dual order")
    require(rho == global_upper, "certificate does not prove an exact optimum")
    claimed = list(map(F,case["certified_rho_interval"]))
    require(claimed == [rho,global_upper], "incorrect claimed interval")
    require(list(map(F,case["certified_ratio_interval"])) == [1/global_upper,1/rho],
            "incorrect claimed ratio interval")
    direct_ratios = []
    for j in range(size):
        benchmark = prices[j+1] if continuous else prices[j]
        direct_ratios.append(benchmark/direct_sort_cvar(prices,masses,1-delta,j))
    direct_ratio = max(direct_ratios)
    require(direct_ratio <= 1/rho, "sorted CVaR contradicts primal bound")
    if rho == global_upper:
        require(direct_ratio == 1/rho, "sorted CVaR disagrees with certified optimum")
    return {"theta": str(case["theta"]), "delta": str(delta), "game": case["game"],
            "price_points": n, "dual_certificates": len(actual),
            "optimal_ratio_lower": str(1/global_upper),
            "optimal_ratio_upper": str(1/rho),
            "exact_optimum": rho == global_upper,
            "decimal_lower": float(1/global_upper),
            "decimal_upper": float(1/rho),
            "independent_direct_sort_ratio": str(direct_ratio)}


def verify_bundle(bundle):
    require(bundle.get("schema") == "oms_exact_grid_v1", "incorrect certificate schema")
    expected = {
        (F(theta), F(delta), game)
        for theta, delta, prices in PARAMETERS
        for game in ("finite_grid", "continuum_grid_supported")
    }
    cases = bundle.get("cases")
    require(isinstance(cases, list) and len(cases) == 14,
            "the complete certificate bundle must contain exactly fourteen games")
    identities = [(F(c["theta"]), F(c["delta"]), c["game"]) for c in cases]
    require(len(set(identities)) == 14, "duplicate parameter/game case")
    require(set(identities) == expected, "missing or unexpected parameter/game case")
    return [verify_case(case) for case in cases]


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--output",type=Path)
    parser.add_argument("--verify",type=Path)
    args=parser.parse_args()
    if args.verify:
        bundle=json.loads(args.verify.read_text())
        summaries = verify_bundle(bundle)
        for summary in summaries:
            print(json.dumps(summary))
        total = sum(row["dual_certificates"] for row in summaries)
        print(f"ALL EXACT RATIONAL CERTIFICATES VERIFIED: {len(summaries)} games, {total} dual certificates")
        return
    if not args.output:
        parser.error("--output or --verify is required")
    cases=[]
    # Includes the endpoint delta=0, an interior point, both sides of the
    # phase transition, and a wider price range.
    for theta,delta,prices in PARAMETERS:
        for continuous in (False,True):
            case=build_case(theta,delta,continuous,prices)
            cases.append(case)
            summary=verify_case(case)
            print(json.dumps(summary),flush=True)
            args.output.write_text(json.dumps({"schema":"oms_exact_grid_v1",
                "scope":"finite price games and grid-supported policies; independent of analytic phi",
                "cases":cases},indent=2)+"\n")


if __name__=="__main__":
    main()
