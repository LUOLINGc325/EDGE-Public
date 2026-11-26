#!/usr/bin/env python3
"""Exact certificate for the two-update Glauber activity counterexample.

Only the Python standard library is required. All comparisons use Fraction;
Decimal is used exclusively for display. The analytic bridge-family theorem
is proved in the manuscript and is not claimed to follow from this finite run.
"""
from __future__ import annotations

import argparse
from decimal import Decimal, localcontext
from fractions import Fraction as Q
import json
from pathlib import Path

ENERGY = (0, 0, 0, 0, 1, 11, 11, 11, 11, 10)
EDGES = ((0, 2), (0, 3), (1, 2), (1, 3), (2, 3), (0, 4), (1, 4),
         (5, 7), (5, 8), (6, 7), (6, 8), (7, 8), (5, 9), (6, 9), (4, 9))
Q_SCHEDULE = (Q(10001, 10000), Q(5, 4), Q(100))
N = len(ENERGY)
D = 3


def record(x):
    x = Q(x)
    with localcontext() as ctx:
        ctx.prec = 50
        decimal = str(Decimal(x.numerator) / Decimal(x.denominator))
    scale = 10**14
    lower = (x.numerator * scale) // x.denominator
    return {"numerator": str(x.numerator), "denominator": str(x.denominator),
            "decimal_50_significant_digits": decimal,
            "enclosure": {"lower_numerator": str(lower),
                          "upper_numerator": str(lower + 1),
                          "denominator": str(scale), "upper_strict": True}}


def gibbs(q):
    weights = [q**(-e) for e in ENERGY]
    total = sum(weights, Q(0))
    return [w / total for w in weights]


def transition(q):
    p = [[Q(0) for _ in range(N)] for _ in range(N)]
    for u, v in EDGES:
        p[v][u] = 1 / (D * (1 + q**(ENERGY[v] - ENERGY[u])))
        p[u][v] = 1 / (D * (1 + q**(ENERGY[u] - ENERGY[v])))
    for j in range(N):
        p[j][j] = 1 - sum(p[i][j] for i in range(N) if i != j)
    return p


def dot(a, b):
    return sum((x*y for x, y in zip(a, b)), Q(0))


def mv(p, v):
    return [dot(row, v) for row in p]


def exits(p):
    return [1-p[j][j] for j in range(N)]


def tv(p, r):
    return sum((abs(x-y) for x, y in zip(p, r)), Q(0))/2


def run():
    checks = []

    def require(ok, label):
        if not ok:
            raise ValueError(label)
        checks.append(label)

    require(len(EDGES) == 15 and len(set(EDGES)) == 15, "15 distinct edges")
    neighbors = [set() for _ in range(N)]
    for u, v in EDGES:
        require(0 <= u < v < N, "valid simple edge")
        neighbors[u].add(v)
        neighbors[v].add(u)
    require(all(len(v) == D for v in neighbors), "3-regular")
    seen, stack = {0}, [0]
    while stack:
        u = stack.pop()
        for v in neighbors[u] - seen:
            seen.add(v)
            stack.append(v)
    require(len(seen) == N, "connected")
    require(1 < Q_SCHEDULE[0] < Q_SCHEDULE[1] < Q_SCHEDULE[2],
            "positive finite strictly cooling temperatures")

    matrices = [transition(q) for q in Q_SCHEDULE]
    equilibria = [gibbs(q) for q in Q_SCHEDULE]
    uniform = [Q(1, N)] * N
    for p, pi in zip(matrices, equilibria):
        require(sum(pi) == 1 and min(pi) > 0, "Gibbs probability vector")
        for j in range(N):
            require(sum(p[i][j] for i in range(N)) == 1, "column normalization")
            require(p[j][j] > 0, "positive holding probability")
            for i in range(N):
                require(p[i][j] >= 0, "nonnegative transition")
                require(p[i][j] * pi[j] == p[j][i] * pi[i], "detailed balance")
        require(mv(p, pi) == pi, "Gibbs stationarity")
        a = exits(p)
        f = [2*x-1 for x in a]
        require(sum(f) == 0, "zero-sum exit bias")
        require(mv(p, uniform) == [(1-x)/N for x in f], "uniform update identity")
        require(dot(a, uniform) == Q(1, 2), "uniform first activity")
        require(dot(a, pi) <= Q(1, 2), "equilibrium activity bound")

    p0 = equilibria[0]
    p1 = mv(matrices[1], p0)
    p2 = mv(matrices[2], p1)
    a1, a2 = exits(matrices[1]), exits(matrices[2])
    act0, act1 = dot(a1, p0), dot(a2, p1)
    mean = (act0+act1)/2
    for state in (p0, p1, p2):
        require(sum(state) == 1 and min(state) > 0, "run probability vector")
    mean_energies = [dot(state, ENERGY) for state in (p0, p1, p2)]
    require(mean_energies[0] > mean_energies[1] > mean_energies[2],
            "actual mean energy strictly decreases")
    require(act0 < Q(1, 2), "Gibbs first-update bound")
    require(act1 > Q(1, 2) + Q(1, 400), "analytic pointwise margin")
    require(mean > Q(1, 2) + Q(3, 3200), "analytic average margin")
    require(act1 > Q(5033, 10000), "sharper certified pointwise margin")
    require(mean > Q(5016, 10000), "sharper certified average margin")

    f1, f2 = ([2*x-1 for x in a] for a in (a1, a2))
    bias_inner = dot(f1, f2)
    uniform_act1 = dot(a2, mv(matrices[1], uniform))
    require(uniform_act1 == Q(1, 2)-bias_inner/(2*N), "cross-temperature identity")
    require(bias_inner < -Q(1051, 16362), "analytic bias bound")
    require(uniform_act1-Q(1, 2) > Q(1, 320), "uniform margin bound")
    perturbation = tv(p0, uniform)
    require(perturbation <= (Q_SCHEDULE[0]**11-1)/2 < Q(11, 19978) < Q(1, 1600),
            "finite Gibbs-start total variation bound")
    require(abs(act1-uniform_act1) <= perturbation, "contraction comparison")

    return {
        "status": "passed", "arithmetic": "exact rational",
        "model": {"states": N, "degree": D, "connected": True,
                  "edges": EDGES, "energies": ENERGY,
                  "q_exp_beta": [record(q) for q in Q_SCHEDULE],
                  "probability_convention": "column vectors; next temperature, pre-update distribution"},
        "activities": {"A0": record(act0), "A1": record(act1),
                       "two_step_average": record(mean)},
        "states": [[record(x) for x in p] for p in (p0, p1, p2)],
        "exit_biases": [[record(x) for x in f] for f in (f1, f2)],
        "bias_inner_product": record(bias_inner),
        "uniform_start_A1": record(uniform_act1),
        "gibbs_start_total_variation": record(perturbation),
        "mean_energies": [record(x) for x in mean_energies],
        "margins": {"A1_minus_half": record(act1-Q(1, 2)),
                    "mean_minus_half": record(mean-Q(1, 2))},
        "checks_passed": len(checks),
        "check_categories": sorted(set(checks)),
        "scope": "One finite exact counterexample and its algebraic identities. The general bridge theorem is a separate analytic proof.",
        "formal_proof_assistant_used": False
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1]/"results/exact_certificate.json")
    args = parser.parse_args()
    result = run()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2)+"\n", encoding="utf-8")
    print(json.dumps({"status": result["status"], "checks": result["checks_passed"],
                      "activities": {k: v["decimal_50_significant_digits"]
                                     for k, v in result["activities"].items()},
                      "output": str(args.output)}, indent=2))
