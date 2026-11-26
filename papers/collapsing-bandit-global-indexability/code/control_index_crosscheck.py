"""Exact index evaluator plus an independent truncated-chain Bellman diagnostic.

The theorem is proved in the manuscript/research notes. Float diagnostics are
not substituted for proof or represented as Lean verification.
"""
from __future__ import annotations

from fractions import Fraction as Q
from pathlib import Path
import json
import math

import numpy as np


def sign(x):
    return (x > 0) - (x < 0)


def exact_index(rho, stationary, beta, r0, r1, mu0, mu1, belief):
    """All arguments and atom weights are Fraction; output is exact Fraction."""
    sigma = sign(r1)
    if sigma == 0:
        return r0, {"flat": True}
    if sigma * (belief - stationary) >= 0:
        c = belief
    else:
        tau_b = stationary + rho * (belief - stationary)
        c = (belief - beta * tau_b) / (1 - beta)

    def atom_value(x):
        if sigma * (belief - stationary) >= 0:
            value = max(Q(0), sigma * (x - belief))
            return value, (0 if value else None)
        if sigma * (x - belief) < 0 and sigma * (stationary - belief) <= 0:
            return Q(0), None
        k = 0
        z = x
        e = Q(1)
        while sigma * (z - belief) < 0:
            z = stationary + rho * (z - stationary)
            e *= beta
            k += 1
        value = e * sigma * (z - c)
        assert value >= 0
        return value, k

    atom_data = {}
    for x, _ in mu0 + mu1:
        atom_data[x] = atom_value(x)
    g0 = sum((weight * atom_data[x][0] for x, weight in mu0), Q(0))
    g1 = sum((weight * atom_data[x][0] for x, weight in mu1), Q(0))
    denominator = 1 - beta * sigma * (g1 - g0)
    assert denominator >= 1 - beta
    index = r0 + abs(r1) * (sigma * c + beta * g0) / denominator
    return index, {
        "flat": False,
        "c": str(c),
        "denominator": str(denominator),
        "waiting_times": {str(x): atom_data[x][1] for x in sorted(atom_data)},
    }


def bellman_diagnostic(rho, stationary, beta, r0, r1, mu0, mu1, belief, subsidy):
    """Independent value iteration; the final passive tails jump to stationary.

    The displayed tail estimate comes from Lip(H)<=|r1|/(1-beta).
    This routine uses ordinary floating point and is a diagnostic, not interval
    arithmetic or an exact infinite-state certificate.
    """
    r, s, disc, g0, g1, b, m = map(float, (rho, stationary, beta, r0, r1, belief, subsidy))
    target = 1e-10
    if r == 0:
        depth = 2
    else:
        tail_factor = disc * abs(g1) / (1 - disc) ** 2
        depth = max(2, int(math.ceil(math.log(target / max(tail_factor, 1e-30)) / math.log(r))))
    origins = sorted({float(x) for x, _ in mu0 + mu1} | {b})
    states = []
    heads = {}
    for origin in origins:
        heads[origin] = len(states)
        states.extend(s + r ** k * (origin - s) for k in range(depth))
    stationary_index = len(states)
    states.append(s)
    states = np.array(states, dtype=float)
    next_index = np.arange(len(states), dtype=np.int64) + 1
    for origin in origins:
        next_index[heads[origin] + depth - 1] = stationary_index
    next_index[stationary_index] = stationary_index
    atom_index0 = np.array([heads[float(x)] for x, _ in mu0], dtype=np.int64)
    atom_weight0 = np.array([float(w) for _, w in mu0])
    atom_index1 = np.array([heads[float(x)] for x, _ in mu1], dtype=np.int64)
    atom_weight1 = np.array([float(w) for _, w in mu1])
    values = np.zeros(len(states))
    residual = math.inf
    for iteration in range(1, 100000):
        e0 = float(atom_weight0 @ values[atom_index0])
        e1 = float(atom_weight1 @ values[atom_index1])
        active = g0 + g1 * states - m + disc * (e0 + states * (e1 - e0))
        passive = disc * values[next_index]
        updated = np.maximum(active, passive)
        residual = float(np.max(np.abs(updated - values)))
        values = updated
        if residual <= target * (1 - disc):
            break
    else:
        raise AssertionError("value iteration did not meet its declared residual")
    at = heads[b]
    e0 = float(atom_weight0 @ values[atom_index0])
    e1 = float(atom_weight1 @ values[atom_index1])
    active_at_b = g0 + g1 * b - m + disc * ((1 - b) * e0 + b * e1)
    passive_at_b = disc * values[next_index[at]]
    advantage = float(active_at_b - passive_at_b)
    return {
        "advantage": advantage,
        "depth": depth,
        "iterations": iteration,
        "bellman_iteration_residual": residual,
        "nominal_value_error_from_iteration": residual / (1 - disc),
        "nominal_value_error_from_tail": disc * abs(g1) * r ** depth / (1 - disc) ** 2,
    }


def point(x):
    return [(x, Q(1))]


def main():
    cases = []
    original = [
        ("reverse_high_persistence", Q(1, 20), Q(9, 10), Q(3, 50), Q(49, 50), Q(19, 20)),
        ("forward_split_beliefs", Q(1, 20), Q(19, 20), Q(1, 5), Q(49, 50), Q(99, 100)),
        ("forward_both_heads_above_stationary", Q(1, 10), Q(9, 10), Q(3, 5), Q(99, 100), Q(97, 100)),
        ("reverse_both_heads_above_stationary", Q(1, 200), Q(4, 5), Q(3, 100), Q(97, 100), Q(99, 100)),
    ]
    for name, p0, p1, a0, a1, beta in original:
        rho = p1 - p0
        alpha = a1 - a0
        stationary = p0 / (1 - rho)
        r0 = beta * (a0 - p0) / (1 - beta * rho)
        r1 = beta * (alpha - rho) / (1 - beta * rho)
        cases.append((name, rho, stationary, beta, r0, r1, point(a0), point(a1), True))
    cases.append((
        "arbitrary_reset_laws_without_stochastic_order", Q(4, 5), Q(2, 5), Q(97, 100), Q(1, 10), Q(1, 2),
        [(Q(1, 10), Q(1, 5)), (Q(9, 10), Q(4, 5))],
        [(Q(1, 5), Q(4, 5)), (Q(4, 5), Q(1, 5))], False,
    ))
    records = []
    for name, rho, stationary, beta, r0, r1, mu0, mu1, is_original in cases:
        for belief in (Q(1, 10), Q(1, 2), Q(9, 10)):
            index, exact = exact_index(rho, stationary, beta, r0, r1, mu0, mu1, belief)
            checks = []
            for offset in (Q(-1, 1000), Q(0), Q(1, 1000)):
                diag = bellman_diagnostic(rho, stationary, beta, r0, r1, mu0, mu1, belief, index + offset)
                if offset < 0:
                    passed = diag["advantage"] > 1e-7
                elif offset > 0:
                    passed = diag["advantage"] < -1e-7
                else:
                    passed = abs(diag["advantage"]) < 2e-8
                assert passed, (name, belief, offset, diag)
                checks.append({"subsidy_offset": str(offset), "passed": passed, **diag})
            records.append({
                "model": name,
                "original_model": is_original,
                "belief": str(belief),
                "index_exact": str(index),
                "index_decimal": float(index),
                "exact_evaluator": exact,
                "independent_bellman_checks": checks,
            })
    result = {
        "kind": "exact rational index evaluation with independent floating-point Bellman diagnostics",
        "proof_status": "Analytic proofs are in the research notes; these diagnostics are not formal verification.",
        "models": len(cases),
        "index_queries": len(records),
        "bellman_diagnostics": sum(len(r["independent_bellman_checks"]) for r in records),
        "all_diagnostics_passed": True,
        "maximum_absolute_tie_advantage": max(abs(r["independent_bellman_checks"][1]["advantage"]) for r in records),
        "records": records,
    }
    destination = Path(__file__).resolve().parents[1] / "results" / "control_index_crosscheck.json"
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({k: v for k, v in result.items() if k != "records"}, indent=2))


if __name__ == "__main__":
    main()
