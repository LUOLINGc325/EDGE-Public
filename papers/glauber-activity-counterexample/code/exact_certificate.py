#!/usr/bin/env python3
"""Exact finite witness for the Glauber activity conjecture (standard library).

All decisions use Fraction arithmetic. Decimal intervals are outward rounded
integers over 10**12. Python -O does not disable any verification condition.
The script certifies the stated finite witness, not literature priority or the
analytic family theorem in the manuscript.
"""
from __future__ import annotations

import argparse
from fractions import Fraction as F
from hashlib import sha256
from itertools import combinations
import json
from pathlib import Path


def require(condition: bool, description: str) -> None:
    if not condition:
        raise ArithmeticError(description)


def qstr(value: F) -> str:
    return f"{value.numerator}/{value.denominator}"


def interval(value: F, digits: int = 12) -> dict:
    scale = 10 ** digits
    lo = value.numerator * scale // value.denominator
    hi = -((-value.numerator * scale) // value.denominator)
    require(F(lo, scale) <= value <= F(hi, scale), "outward enclosure")
    def decimal(integer: int) -> str:
        sign = "-" if integer < 0 else ""
        whole, tail = divmod(abs(integer), scale)
        return f"{sign}{whole}.{tail:0{digits}d}"
    return {"lower_numerator": lo, "upper_numerator": hi,
            "denominator": scale, "lower_decimal": decimal(lo),
            "upper_decimal": decimal(hi)}


def graph() -> list[list[int]]:
    edges = set(combinations(range(4), 2)) | set(combinations(range(4, 8), 2))
    edges -= {(2, 3), (4, 5)}
    edges |= {(2, 4), (3, 5)}
    adj = [[0] * 8 for _ in range(8)]
    for i, j in sorted(edges):
        adj[i][j] = adj[j][i] = 1
    require(all(sum(row) == 3 for row in adj), "3-regularity")
    require(all(adj[i][i] == 0 for i in range(8)), "no loops")
    require(all(adj[i][j] == adj[j][i] for i in range(8) for j in range(8)),
            "undirected graph")
    seen, pending = {0}, [0]
    while pending:
        i = pending.pop()
        for j in range(8):
            if adj[i][j] and j not in seen:
                seen.add(j)
                pending.append(j)
    require(len(seen) == 8, "connectivity")
    return adj


def gibbs(base: F, energies: list[int]) -> list[F]:
    weights = [base ** (-energy) for energy in energies]
    z = sum(weights, F(0))
    return [w / z for w in weights]


def kernel(base: F, energies: list[int], adj: list[list[int]]) -> list[list[F]]:
    """Column j is the law after a proposal from state j, beta=log(base)."""
    n = len(energies)
    p = [[F(0) for _ in range(n)] for _ in range(n)]
    for j in range(n):
        degree = sum(adj[j])
        for i in range(n):
            if adj[i][j]:
                p[i][j] = F(1, degree) / (1 + base ** (energies[i] - energies[j]))
        p[j][j] = 1 - sum(p[i][j] for i in range(n))
    require(all(x >= 0 for row in p for x in row), "nonnegative kernel")
    require(all(sum(p[i][j] for i in range(n)) == 1 for j in range(n)),
            "column stochasticity")
    stationary = gibbs(base, energies)
    require(mul(p, stationary) == stationary, "Gibbs stationarity")
    require(all(p[i][j] * stationary[j] == p[j][i] * stationary[i]
                for i in range(n) for j in range(n)), "detailed balance")
    return p


def mul(p: list[list[F]], vector: list[F]) -> list[F]:
    return [sum((x * y for x, y in zip(row, vector)), F(0)) for row in p]


def exits(p: list[list[F]]) -> list[F]:
    return [1 - p[j][j] for j in range(len(p))]


def dot(x: list[F], y: list[F]) -> F:
    return sum((a * b for a, b in zip(x, y)), F(0))


def run() -> dict:
    adj = graph()
    energies = [0, 1, 2, 3, 50, 51, 52, 53]
    bases = [F(1001, 1000), F(21, 20), F(32)]
    require(1 < bases[0] < bases[1] < bases[2], "strictly positive cooling schedule")
    require(len(set(energies)) == 8, "distinct energies")
    states = [gibbs(bases[0], energies)]
    kernels = [kernel(b, energies, adj) for b in bases[1:]]
    activities = []
    for p in kernels:
        activities.append(dot(exits(p), states[-1]))
        states.append(mul(p, states[-1]))
    require(all(sum(v, F(0)) == 1 and all(x > 0 for x in v) for v in states),
            "all states are strictly positive probability vectors")
    a0, a1 = activities
    mean = (a0 + a1) / 2
    mean_energies = [dot([F(e) for e in energies], state) for state in states]
    require(mean_energies[0] > mean_energies[1] > mean_energies[2],
            "mean energy decreases at both transitions in this witness")
    inequalities = [
        ("A0 > 249/500", a0 - F(249, 500)),
        ("A0 < 1/2", F(1, 2) - a0),
        ("A1 > 51/100", a1 - F(51, 100)),
        ("two_step_mean > 63/125", mean - F(63, 125)),
    ]
    for label, margin in inequalities:
        require(margin > 0, label)
    # Cross-check the edge form of Eq. (40), without using diagonal entries.
    edge_sums = []
    for step, base in enumerate(bases[1:]):
        v = states[step]
        edge_sum = F(0)
        for i in range(8):
            for j in range(i + 1, 8):
                if adj[i][j]:
                    ratio = base ** (energies[j] - energies[i])
                    edge_sum += (ratio - 1) / (ratio + 1) * (v[i] - v[j])
        require(F(1, 2) - edge_sum / 6 == activities[step], "Eq. (40) edge identity")
        edge_sums.append(edge_sum)
    # Display-only intervals themselves suffice to establish the claimed bounds.
    state_intervals = [[interval(x) for x in v] for v in states]
    exit_intervals = [[interval(x) for x in exits(p)] for p in kernels]
    for value in [a0, a1, mean, *states[1], *exits(kernels[1])]:
        bounds = interval(value)
        require(F(bounds["lower_numerator"], bounds["denominator"]) < value
                < F(bounds["upper_numerator"], bounds["denominator"]),
                "strict enclosure for every quantity printed in the manuscript")
    product_lower_bounds = []
    for k in range(2):
        lower = sum((F(state_intervals[k][i]["lower_numerator"], 10**12)
                     * F(exit_intervals[k][i]["lower_numerator"], 10**12)
                     for i in range(8)), F(0))
        target = F(249, 500) if k == 0 else F(51, 100)
        require(lower > target, "tabulated outward intervals certify strict bound")
        product_lower_bounds.append(qstr(lower))
    return {
        "schema_version": 1,
        "result": "PASS",
        "arithmetic": "Python standard-library fractions.Fraction; exact integer comparisons",
        "vertex_count": 8, "degree": 3,
        "edges": [[i, j] for i in range(8) for j in range(i + 1, 8) if adj[i][j]],
        "energies": energies, "inverse_temperatures": [f"log({qstr(x)})" for x in bases],
        "time_convention": "p(k+1)=P(beta(k+1))p(k); A(k)=offdiag(P(beta(k+1))) dot p(k)",
        "activities": {name: {"exact": qstr(value), "interval": interval(value)}
                       for name, value in [("A0", a0), ("A1", a1), ("two_step_mean", mean)]},
        "state_intervals": state_intervals, "exit_intervals": exit_intervals,
        "table_product_lower_bounds": product_lower_bounds,
        "mean_energy_intervals": [interval(x) for x in mean_energies],
        "edge_form_sums": [qstr(x) for x in edge_sums],
        "inequalities": [{"claim": label, "exact_positive_margin": qstr(value),
                          "margin_numerator_bits": value.numerator.bit_length(),
                          "margin_denominator_bits": value.denominator.bit_length()}
                         for label, value in inequalities],
        "scope": "Finite 8-state, two-transition witness only. General families require the written proof.",
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results/exact_certificate.json")
    args = parser.parse_args()
    result = run()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    data = json.dumps(result, indent=2, sort_keys=True) + "\n"
    args.output.write_text(data, encoding="utf-8")
    print(json.dumps({"result": result["result"],
                      "activities": {k: v["interval"] for k, v in result["activities"].items()},
                      "certificate_sha256": sha256(data.encode()).hexdigest()}, indent=2))


if __name__ == "__main__":
    main()
