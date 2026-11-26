#!/usr/bin/env python3
"""Reproduce exact birth-and-death mean hitting diagnostics.
Evaluate finite birth-and-death mean hitting sums in floating point.
Requires Python 3, NumPy, and SciPy.
"""
from pathlib import Path
import csv
import json
import math
import numpy as np
from scipy.optimize import brentq
from scipy.special import gammaln, logsumexp, gamma

OUT = Path(__file__).resolve().parent.parent / "results"
OUT.mkdir(exist_ok=True)
SIZES = [256, 1024, 4096, 16384, 65536, 262144]
J = math.sqrt(math.pi) * 2.0**(1.0/3.0) * float(gamma(1.0/6.0)) / (3.0*math.sqrt(3.0))

def parameters(p, r):
    beta = 1.0/(p*(p-1)*r**(p-2)*(1-r*r))
    h = math.atanh(r)-p*beta*r**(p-1)
    return beta, h

def potential_maximum(p, beta, h):
    def hp(x):
        return p*beta*x**(p-1)+h-np.arctanh(x)
    def hpp(x):
        return p*(p-1)*beta*x**(p-2)-1/(1-x*x)
    grid = np.linspace(-1+1e-10, 1-1e-10, 20001)
    vals = hp(grid)
    maxima = []
    for i in range(len(grid)-1):
        if vals[i] == 0:
            root = float(grid[i])
        elif vals[i]*vals[i+1] < 0:
            root = float(brentq(hp, grid[i], grid[i+1], xtol=1e-14))
        else:
            continue
        if hpp(root) < -1e-8 and all(abs(root-r)>1e-7 for r in maxima):
            maxima.append(root)
    if len(maxima) != 1:
        raise RuntimeError(f"Expected unique stable maximum, got {maxima}")
    return maxima[0]

def local_constant(p, r):
    h3 = ((p-2)-p*r*r)/(r*(1-r*r)**2)
    return J/(1-r*r)*(6.0/abs(h3))**(2.0/3.0)

def make_cases():
    cases = []
    for name, r in [("A_p3_r08", 0.8), ("B_p3_r04", 0.4)]:
        beta, h = parameters(3, r)
        cases.append(dict(case=name, p=3, beta=beta, h=h, inflections=[r]))
    r = float(brentq(lambda x: math.atanh(x)-x/(3*(1-x*x)), 0.82, 0.95, xtol=1e-14))
    beta, _ = parameters(4, r)
    cases.append(dict(case="C_p4_double", p=4, beta=beta, h=0.0, inflections=[-r, r]))
    for c in cases:
        mstar = potential_maximum(c["p"], c["beta"], c["h"])
        c["mstar"] = mstar
        c["predicted_left"] = sum(local_constant(c["p"], r) for r in c["inflections"] if r<mstar)
        c["predicted_right"] = sum(local_constant(c["p"], r) for r in c["inflections"] if r>mstar)
        c["predicted_max"] = max(c["predicted_left"], c["predicted_right"])
    return cases

def arrays(N, case, dynamics):
    p, beta, h = case["p"], case["beta"], case["h"]
    k = np.arange(N+1, dtype=float)
    m = 2*k/N-1
    f = beta*m**p+h*m
    g = p*beta*m**(p-1)+h
    logw = gammaln(N+1)-gammaln(k+1)-gammaln(N-k+1)+N*f
    logb = np.full(N+1, -np.inf)
    logd = np.full(N+1, -np.inf)
    if dynamics == "HB":
        delta = N*np.diff(f)
        logb[:-1] = np.log1p(-k[:-1]/N)-np.logaddexp(0, -delta)
        logd[1:] = np.log(k[1:]/N)-np.logaddexp(0, delta)
    elif dynamics == "FM":
        logb[:-1] = np.log1p(-k[:-1]/N)-np.logaddexp(0, -2*g[:-1])
        logd[1:] = np.log(k[1:]/N)-np.logaddexp(0, 2*g[1:])
        correction = np.empty(N+1)
        correction[0] = 0.0
        correction[1:] = np.cumsum(g[:-1]+g[1:]-N*np.diff(f))
        logw = logw + np.logaddexp(g, -g)-math.log(2.0)+correction
    else:
        raise ValueError(dynamics)
    logw = logw-np.max(logw)
    residual = np.max(np.abs((logw[:-1]+logb[:-1])-(logw[1:]+logd[1:])))
    pi = np.exp(logw-logsumexp(logw))
    target = int(np.searchsorted(np.cumsum(pi), 0.5))
    if target>N:
        raise RuntimeError("Numerical median outside state space")
    return logw, logb, logd, target, float(residual)

def means_from_formula(logw, logb, logd, target):
    N = len(logw)-1
    prefix = np.logaddexp.accumulate(logw)
    suffix = np.logaddexp.accumulate(logw[::-1])[::-1]
    left = float(np.exp(logsumexp(prefix[:target]-logb[:target]-logw[:target]))) if target else 0.0
    right = float(np.exp(logsumexp(suffix[target+1:]-logd[target+1:]-logw[target+1:]))) if target<N else 0.0
    return left, right

def backward_check(N, case, dynamics):
    logw, logb, logd, a, db = arrays(N, case, dynamics)
    b, d = np.exp(logb), np.exp(logd)
    states = [i for i in range(N+1) if i != a]
    index = {i:j for j, i in enumerate(states)}
    matrix = np.zeros((N, N))
    for i in states:
        j = index[i]
        matrix[j, j] = b[i]+d[i]
        if i+1 in index:
            matrix[j, index[i+1]] = -b[i]
        if i-1 in index:
            matrix[j, index[i-1]] = -d[i]
    solved = np.linalg.solve(matrix, np.ones(N))
    expected = means_from_formula(logw, logb, logd, a)
    independent = (0.0 if a == 0 else float(solved[index[0]]),
                   0.0 if a == N else float(solved[index[N]]))
    absolute = max(abs(x-y) for x,y in zip(expected, independent))
    relative = max(abs(x-y)/max(1.0, abs(x), abs(y)) for x,y in zip(expected, independent))
    if relative > 1e-10:
        raise AssertionError(f"Backward-equation check failed: {absolute=}, {relative=}")
    return dict(case=case["case"], N=N, dynamics=dynamics, target=a,
                max_absolute_error=absolute, max_relative_error=relative,
                detailed_balance_log_residual=db)

def main():
    cases = make_cases()
    checks = [backward_check(31, c, dyn) for c in cases for dyn in ["HB", "FM"]]
    rows = []
    for c in cases:
        for N in SIZES:
            for dyn in ["HB", "FM"]:
                lw, lb, ld, target, residual = arrays(N, c, dyn)
                left, right = means_from_formula(lw, lb, ld, target)
                rows.append(dict(case=c["case"], p=c["p"], beta=c["beta"], h=c["h"],
                    N=N, dynamics=dyn, target_median=target, mean_left=left,
                    mean_right=right, max_mean=max(left,right),
                    scaled_max=max(left,right)/N**(4.0/3.0),
                    predicted_max=c["predicted_max"], detailed_balance_log_residual=residual))
    with (OUT/"hitting_diagnostics.csv").open("w", newline="", encoding="utf-8") as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0]), lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)
    summary = dict(date="2026-11-24",
        status="Floating-point evaluation of exact mean hitting identities",
        dynamics={"HB":"Exact Gibbs heat bath", "FM":"Literal full-magnetization rule with its actual invariant law"},
        time_unit="One uniformly chosen single-site update",
        cases=cases, sizes=SIZES, small_backward_checks=checks,
        max_detailed_balance_log_residual=max(row["detailed_balance_log_residual"] for row in rows),
        largest_size_rows=[row for row in rows if row["N"] == max(SIZES)])
    (OUT/"diagnostics_summary.json").write_text(json.dumps(summary, indent=2, ensure_ascii=False)+"\n", encoding="utf-8")
    print(json.dumps(summary, indent=2, ensure_ascii=False))

if __name__ == "__main__":
    main()
