#!/usr/bin/env python3
"""Finite quantile LPs with independently checkable rational bounds.

This computes fixed-horizon, all-distribution bounds. It does not certify
the infimum over unbounded horizons. SciPy discovers a solution; all saved
bound certificates are checked using only exact fractions and weak duality.

Example:
  python code/minimax_quantile_lp.py --n 4 --m 64 --output results/minimax_n4_m64.json
  python code/minimax_quantile_lp.py --verify results/minimax_n4_m64.json
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass
from fractions import Fraction as Q
import json
from pathlib import Path
from typing import Iterable


def qjson(x: Q) -> dict:
    return {"numerator": str(x.numerator), "denominator": str(x.denominator), "decimal": float(x)}


def qload(x: dict) -> Q:
    return Q(int(x["numerator"]), int(x["denominator"]))


def rounded(x: float, denominator: int) -> Q:
    return Q(round(float(x) * denominator), denominator)


@dataclass
class RationalLP:
    n: int
    m: int
    mode: str
    variable_count: int
    objective_index: int
    upper_bound: Q
    prophet_weights: list[Q]
    ub_rows: list[dict[int, Q]]
    eq_rows: list[dict[int, Q]]


def build_lp(n: int, m: int, mode: str) -> RationalLP:
    if n < 1 or m < 1 or mode not in ("strict", "weak"):
        raise ValueError("n,m must be positive and mode strict or weak")

    def value(r: int) -> int:
        return r - 1

    def w(k: int, r: int) -> int:
        assert 1 <= k < n and 1 <= r <= m
        return m + (k - 1) * m + r - 1

    def s(k: int, r: int) -> int:
        assert 1 <= k <= n and 1 <= r <= m
        return n * m + (k - 1) * m + r - 1

    def row(terms: Iterable[tuple[int, Q | int]]) -> dict[int, Q]:
        result: dict[int, Q] = {}
        for index, coefficient in terms:
            result[index] = result.get(index, Q(0)) + coefficient
        return {i: Q(x) for i, x in result.items() if x}

    weights = [Q(j**n - (j - 1)**n, m**n) for j in range(1, m + 1)]
    equations = [{value(r): weights[r - 1] for r in range(1, m + 1)}]
    inequalities = [row([(value(r), 1), (value(r + 1), -1)]) for r in range(1, m)]

    for k in range(1, n + 1):
        for r in range(1, m + 1):
            suffix = [(s(k, r), -1)]
            if r < m:
                suffix.append((s(k, r + 1), 1))
            inequalities.append(row(suffix + [(value(r), Q(1, m))]))
            continuation = [] if k == 1 else [(w(k - 1, r), Q(1, m))]
            inequalities.append(row(suffix + continuation))

    for k in range(1, n):
        for r in range(1, m + 1):
            terms = [(w(k, r), 1)]
            factor = Q(r if mode == "strict" else r - 1, m)
            if k > 1:
                terms.append((w(k - 1, r), -factor))
            if mode == "weak":
                terms.append((s(k, r), -1))
            elif r < m:
                terms.append((s(k, r + 1), -1))
            equations.append(row(terms))

    return RationalLP(n, m, mode, 2 * n * m, s(n, 1), 1 / weights[-1],
                      weights, inequalities, equations)


def bellman(values: list[Q], n: int, mode: str) -> Q:
    """Exact full-history optimum in the finite label problem."""
    m = len(values)
    previous = [Q(0)] * m
    for k in range(1, n + 1):
        choices = [max(value, future) for value, future in zip(values, previous)]
        suffix = [Q(0)] * (m + 1)
        for r in range(m - 1, -1, -1):
            suffix[r] = suffix[r + 1] + choices[r] / m
        if k == n:
            return suffix[0]
        if mode == "strict":
            previous = [Q(r + 1, m) * previous[r] + suffix[r + 1] for r in range(m)]
        elif mode == "weak":
            previous = [Q(r, m) * previous[r] + suffix[r] for r in range(m)]
        else:
            raise ValueError(mode)
    raise AssertionError("positive horizon required")


def certify_dual(lp: RationalLP, inequality_multipliers: list[Q],
                 equality_multipliers: list[Q]) -> tuple[Q, dict]:
    """Exact residual-compensated weak duality on the box [0,B].

    The first equation is prophet normalization, with right-hand side one.
    All other right-hand sides vanish. No floating-point feasibility test
    enters the validity of this bound.
    """
    if len(inequality_multipliers) != len(lp.ub_rows) or len(equality_multipliers) != len(lp.eq_rows):
        raise ValueError("dual dimensions do not match the declared LP")
    if any(y > 0 for y in inequality_multipliers):
        raise ValueError("multipliers for <= constraints must be nonpositive")
    residual = [Q(0)] * lp.variable_count
    residual[lp.objective_index] = Q(1)
    for rows, multipliers in ((lp.ub_rows, inequality_multipliers), (lp.eq_rows, equality_multipliers)):
        for row, multiplier in zip(rows, multipliers):
            if multiplier:
                for index, coefficient in row.items():
                    residual[index] -= multiplier * coefficient
    negative_sum = sum((x for x in residual if x < 0), Q(0))
    raw = equality_multipliers[0]
    lower = raw + lp.upper_bound * negative_sum
    return max(Q(0), lower), {
        "raw_dual_objective": qjson(raw),
        "negative_residual_sum": qjson(negative_sum),
        "box_bound": qjson(lp.upper_bound),
        "compensated_lower_bound": qjson(lower),
        "negative_residual_columns": sum(x < 0 for x in residual),
    }


def verify_mode(n: int, m: int, mode: str, certificate: dict) -> dict:
    lp = build_lp(n, m, mode)
    denom = int(certificate["dual_denominator"])
    ys = [Q(int(x), denom) for x in certificate["inequality_multiplier_numerators"]]
    zs = [Q(int(x), denom) for x in certificate["equality_multiplier_numerators"]]
    lower, diagnostics = certify_dual(lp, ys, zs)
    vdenom = int(certificate["value_denominator"])
    values = [Q(int(x), vdenom) for x in certificate["value_numerators"]]
    if len(values) != m or any(x < 0 for x in values) or values != sorted(values):
        raise ValueError("candidate values are not a sorted nonnegative m-vector")
    prophet = sum((p * v for p, v in zip(lp.prophet_weights, values)), Q(0))
    if prophet <= 0:
        raise ValueError("candidate prophet must be positive")
    reward = bellman(values, n, mode)
    upper = reward / prophet
    if not Q(0) <= lower <= upper <= Q(1):
        raise ValueError(f"invalid rational LP bounds: {lower}, {upper}")
    return {"lower_bound": qjson(lower), "upper_bound": qjson(upper),
            "candidate_reward": qjson(reward), "candidate_prophet": qjson(prophet),
            "dual_diagnostics": diagnostics}


def solve_mode(n: int, m: int, mode: str, dual_denominator: int, value_denominator: int) -> dict:
    import numpy as np
    from scipy.optimize import linprog
    from scipy.sparse import csr_matrix

    lp = build_lp(n, m, mode)

    def matrix(rows: list[dict[int, Q]]):
        rr, cc, vv = [], [], []
        for i, row in enumerate(rows):
            for j, coefficient in row.items():
                rr.append(i)
                cc.append(j)
                vv.append(float(coefficient))
        return csr_matrix((vv, (rr, cc)), shape=(len(rows), lp.variable_count))

    objective = np.zeros(lp.variable_count)
    objective[lp.objective_index] = 1.0
    rhs = np.zeros(len(lp.eq_rows))
    rhs[0] = 1.0
    result = linprog(objective, A_ub=matrix(lp.ub_rows), b_ub=np.zeros(len(lp.ub_rows)),
                     A_eq=matrix(lp.eq_rows), b_eq=rhs, bounds=(0.0, float(lp.upper_bound)),
                     method="highs", options={"dual_feasibility_tolerance": 1e-9,
                                              "primal_feasibility_tolerance": 1e-9})
    if not result.success:
        raise RuntimeError(f"{mode} LP failed: {result.message}")
    ys = [min(Q(0), rounded(y, dual_denominator)) for y in result.ineqlin.marginals]
    zs = [rounded(z, dual_denominator) for z in result.eqlin.marginals]
    values: list[Q] = []
    for x in result.x[:m]:
        values.append(max(Q(0), values[-1] if values else Q(0), rounded(x, value_denominator)))
    certificate = {
        "dual_denominator": str(dual_denominator),
        "inequality_multiplier_numerators": [str(y * dual_denominator) for y in ys],
        "equality_multiplier_numerators": [str(z * dual_denominator) for z in zs],
        "value_denominator": str(value_denominator),
        "value_numerators": [str(v * value_denominator) for v in values],
    }
    verification = verify_mode(n, m, mode, certificate)
    return {"floating_solver_objective": float(result.fun), "solver_iterations": int(result.nit),
            "variable_count": lp.variable_count, "inequality_count": len(lp.ub_rows),
            "equality_count": len(lp.eq_rows), "certificate": certificate, **verification}


def bounds_from_modes(n: int, m: int, strict: dict, weak: dict) -> dict:
    rho = Q(m, n) * (1 - Q(m - 1, m)**n)
    delta = Q(n - 1, m)
    alo, ahi = qload(strict["lower_bound"]), qload(strict["upper_bound"])
    blo, bhi = qload(weak["lower_bound"]), qload(weak["upper_bound"])
    # a <= b <= a+delta permits safe cross-strengthening of solver bounds.
    lower = rho * max(Q(0), alo, blo - delta)
    upper = min(Q(1), bhi, ahi + delta)
    if lower > upper:
        raise ValueError("inconsistent all-distribution bounds")
    return {
        "rho": qjson(rho), "weak_strict_gap_bound": qjson(delta),
        "fixed_horizon_lower_bound": qjson(lower), "fixed_horizon_upper_bound": qjson(upper),
        "certified_interval_width": qjson(upper - lower),
        "exact_lp_discretization_width_bound": qjson(1 - rho + delta),
        "simple_discretization_width_bound": qjson(Q(3 * (n - 1), 2 * m)),
    }


def verify_result(data: dict) -> dict:
    if data.get("schema") != "record-quantile-lp-certificate-v1":
        raise ValueError("unsupported certificate schema")
    n, m = int(data["n"]), int(data["m"])
    checked = {mode: verify_mode(n, m, mode, data[mode]["certificate"])
               for mode in ("strict", "weak")}
    for mode in checked:
        for key in ("lower_bound", "upper_bound", "candidate_reward", "candidate_prophet"):
            if qload(checked[mode][key]) != qload(data[mode][key]):
                raise ValueError(f"stored {mode}.{key} differs from exact verification")
    bounds = bounds_from_modes(n, m, checked["strict"], checked["weak"])
    for key, value in bounds.items():
        if qload(value) != qload(data["bounds"][key]):
            raise ValueError(f"stored aggregate bound {key} differs from exact verification")
    return {"verified": True, "n": n, "m": m,
            "lower": bounds["fixed_horizon_lower_bound"]["decimal"],
            "upper": bounds["fixed_horizon_upper_bound"]["decimal"],
            "width": bounds["certified_interval_width"]["decimal"]}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--n", type=int)
    parser.add_argument("--m", type=int)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--dual-denominator", type=int, default=10**12)
    parser.add_argument("--value-denominator", type=int, default=10**12)
    parser.add_argument("--verify", type=Path)
    args = parser.parse_args()
    if args.verify:
        print(json.dumps(verify_result(json.loads(args.verify.read_text())), indent=2))
        return
    if args.n is None or args.m is None or args.output is None:
        parser.error("supply --n, --m, --output, or use --verify")
    data = {
        "schema": "record-quantile-lp-certificate-v1", "n": args.n, "m": args.m,
        "scope": "Fixed n, every nonnegative iid law with positive finite expected maximum; weak records, arbitrary causal randomized policies.",
        "limitation": "No effective truncation of the infimum over all horizons is provided by this certificate.",
        "exact_certificate_method": "Rational weak duality with box-residual compensation, and rational Bellman evaluation of a sorted candidate vector.",
    }
    for mode in ("strict", "weak"):
        data[mode] = solve_mode(args.n, args.m, mode, args.dual_denominator, args.value_denominator)
    data["bounds"] = bounds_from_modes(args.n, args.m, data["strict"], data["weak"])
    verification = verify_result(data)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(data, indent=2) + "\n")
    print(json.dumps(verification, indent=2))


if __name__ == "__main__":
    main()
