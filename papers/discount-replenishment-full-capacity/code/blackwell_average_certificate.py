#!/usr/bin/env python3
"""Exact Blackwell and average-cost certificate for one inventory instance.

Parameters: lambda=mu=h=1, b=4, K=6, k=1, and P(R=1)=P(R=2)=1/2.
The fixed exact action interval is [-6,6] for 0<alpha<=1.
Uses fractions.Fraction and Sympy.  No floating-point signs are used.
The analytic finite-reduction and average-cost verification theorems are
separate written results; this executable certifies the specified instance.
"""

from __future__ import annotations

import argparse
from fractions import Fraction as Q
from math import comb
import json
from pathlib import Path

import sympy as sp

from exact_finite_certificate import require, solve_linear, qs


L, U = -6, 6
XS = list(range(L, U + 1))
N = len(XS)
INDEX = {x: i for i, x in enumerate(XS)}
K, KDISCOUNT = Q(6), Q(1)
NU = Q(2)
ALPHA_REF = Q(1, 100)


def sr(x: Q) -> sp.Rational:
    return sp.Rational(x.numerator, x.denominator)


def fq(x) -> Q:
    x = sp.Rational(x)
    return Q(int(x.p), int(x.q))


def fee(x: int, y: int, r: int) -> Q:
    return Q(0) if y <= x else (KDISCOUNT if y <= x + r else K)


def running_cost(x: int) -> Q:
    return Q(max(x, 0) + 4 * max(-x, 0))


def events(x: int):
    return [(Q(1), x - 1, 0, "demand"),
            (Q(1, 2), x, 1, "capacity_1"),
            (Q(1, 2), x, 2, "capacity_2")]


def greedy_target(g: list[Q], x: int, r: int) -> int:
    return min(XS, key=lambda y: (fee(x, y, r) + g[INDEX[y]], y))


def exact_reference_policy():
    policy = {x: [0, 0, 0] for x in XS}
    for iteration in range(1, 501):
        mat = [[Q(0) for _ in XS] for _ in XS]
        rhs = [running_cost(x) for x in XS]
        for i, x in enumerate(XS):
            mat[i][i] = NU + ALPHA_REF
            for target, (weight, state, r, _) in zip(policy[x], events(x)):
                mat[i][INDEX[target]] -= weight
                rhs[i] += weight * fee(state, target, r)
        g = solve_linear(mat, rhs)
        new_policy = {x: [greedy_target(g, state, r) for _, state, r, _ in events(x)] for x in XS}
        residuals = []
        for i, x in enumerate(XS):
            fg = (running_cost(x) + sum(weight * (fee(state, target, r) + g[INDEX[target]])
                                       for target, (weight, state, r, _) in zip(new_policy[x], events(x)))) / (NU + ALPHA_REF)
            residuals.append(fg - g[i])
        if all(value == 0 for value in residuals):
            return g, new_policy, iteration
        policy = new_policy
    raise ValueError("exact policy iteration exceeded its guard")


def polynomial_coefficients(poly: sp.Poly) -> list[Q]:
    if poly.is_zero:
        return [Q(0)]
    return [fq(poly.nth(i)) for i in range(poly.degree() + 1)]


def bernstein_coefficients(coeff: list[Q], epsilon: Q) -> list[Q]:
    """p(epsilon*u) in the degree-n Bernstein basis on 0<=u<=1."""
    n = len(coeff) - 1
    return [sum((coeff[j] * epsilon**j * Q(comb(k, j), comb(n, j))
                 for j in range(k + 1)), Q(0)) for k in range(n + 1)]


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, required=True)
    args = parser.parse_args()

    g_ref, policy, iterations = exact_reference_policy()
    alpha = sp.Symbol("alpha", positive=True)
    mat = sp.zeros(N)
    rhs = sp.zeros(N, 1)
    rate_matrix = [[Q(0) for _ in XS] for _ in XS]
    for i, x in enumerate(XS):
        mat[i, i] = alpha + sr(NU)
        rhs[i] = sr(running_cost(x))
        for target, (weight, state, r, _) in zip(policy[x], events(x)):
            mat[i, INDEX[target]] -= sr(weight)
            rate_matrix[i][INDEX[target]] += weight
            rhs[i] += sr(weight * fee(state, target, r))
    require(all(sum(row, Q(0)) == NU for row in rate_matrix), "fixed policy event rates must sum to nu")
    gs = [sp.cancel(value) for value in mat.inv(method="DM") * rhs]
    require(all(sp.cancel(value.subs(alpha, sr(ALPHA_REF)) - sr(exact)) == 0
                for value, exact in zip(gs, g_ref)), "symbolic and reference policy evaluations disagree")
    require(all(sp.cancel(value) == 0 for value in mat * sp.Matrix(gs) - rhs), "symbolic policy equation failed")

    # A common denominator from the actual policy matrix.  Its positive
    # coefficients provide an exact proof of positivity for every alpha>0.
    denominator = sp.Poly(sp.expand(mat.det(method="domain-ge")), alpha)
    den_coeff = polynomial_coefficients(denominator)
    require(all(value >= 0 for value in den_coeff) and any(value > 0 for value in den_coeff),
            "common policy determinant does not have the claimed positive-coefficient certificate")

    # Every possible initial (x,r) produces a contiguous 0/k/K tariff vector.
    # There are (N+1)(N+2)/2 such vectors, indexed by zero and discount counts.
    patterns = []
    inequalities: dict[tuple[Q, ...], dict] = {}
    for a in range(N + 1):
        for b in range(a, N + 1):
            tariffs = [Q(0) if j < a else (KDISCOUNT if j < b else K) for j in range(N)]
            selected = min(range(N), key=lambda j: (tariffs[j] + g_ref[j], XS[j]))
            ids = []
            for j in range(N):
                difference = gs[j] - gs[selected] + sr(tariffs[j] - tariffs[selected])
                polynomial = sp.Poly(sp.cancel(difference * denominator.as_expr()), alpha)
                coefficients = polynomial_coefficients(polynomial)
                key = tuple(coefficients)
                if key not in inequalities:
                    if all(value == 0 for value in coefficients):
                        zero_order = None
                        reduced = [Q(0)]
                    else:
                        zero_order = next(i for i, value in enumerate(coefficients) if value)
                        reduced = coefficients[zero_order:]
                        require(reduced[0] > 0,
                                "reference action is not optimal as alpha approaches zero: " + str((a, b, XS[selected], XS[j])))
                    inequalities[key] = {
                        "id": f"P{len(inequalities):04d}",
                        "coefficients": coefficients,
                        "zero_order": zero_order,
                        "reduced": reduced,
                    }
                ids.append(inequalities[key]["id"])
            patterns.append({
                "zero_target_count": a,
                "zero_or_discount_target_count": b,
                "representative_initial_inventory": L + a - 1,
                "representative_capacity": b - a,
                "canonical_target": XS[selected],
                "competitor_certificate_ids_in_target_order": ids,
            })
    require(len(patterns) == (N + 1) * (N + 2) // 2, "incomplete global tariff enumeration")

    # Rational halving is only a search for a readable interval.  The proof
    # consists of the exact nonnegative Bernstein coefficients subsequently
    # checked and saved for every distinct action inequality.
    epsilon = ALPHA_REF
    for _ in range(101):
        if all(all(value >= 0 for value in bernstein_coefficients(row["reduced"], epsilon))
               for row in inequalities.values()):
            break
        epsilon /= 2
    else:
        raise ValueError("failed to find a Bernstein-certified Blackwell interval")

    proofs = []
    for row in inequalities.values():
        bernstein = bernstein_coefficients(row["reduced"], epsilon)
        require(all(value >= 0 for value in bernstein), "negative Bernstein coefficient")
        if row["zero_order"] is not None:
            require(all(value > 0 for value in bernstein), "strict action inequality not certified on the closed interval")
        proofs.append({
            "id": row["id"],
            "numerator_coefficients_ascending": [qs(value) for value in row["coefficients"]],
            "factor_alpha_power": row["zero_order"],
            "reduced_bernstein_coefficients_on_0_epsilon": [qs(value) for value in bernstein],
            "identically_zero": row["zero_order"] is None,
        })

    S = XS[min(range(N), key=lambda j: (g_ref[j], XS[j]))]
    rho = sp.limit(alpha * gs[INDEX[S]], alpha, 0, dir="+")
    require(rho.is_Rational is True, "average-cost rate is not finite rational")
    hs = [sp.limit(value - gs[INDEX[S]], alpha, 0, dir="+") for value in gs]
    require(all(value.is_Rational is True for value in hs), "bias does not have finite rational limits")
    hq = [fq(value) for value in hs]
    require(min(hq) == 0, "bias must be normalized at its global minimum")
    average_residual = []
    for i, x in enumerate(XS):
        e = running_cost(x) + sum(weight * min(fee(state, target, r) + hq[INDEX[target]] for target in XS)
                                  for weight, state, r, _ in events(x)) - NU * hq[i]
        average_residual.append(e)
    require(all(value == fq(rho) for value in average_residual), "average optimality residuals are not identical")

    # A second exact calculation of the achieved average cost uses the
    # stationary law of the fixed-policy finite event chain.
    mass_symbols = sp.symbols(f"mass0:{N}")
    q_matrix = sp.Matrix([[sr(value) for value in row] for row in rate_matrix])
    stationarity_equations = list((q_matrix.T - sr(NU) * sp.eye(N)) * sp.Matrix(mass_symbols))
    stationarity_equations.append(sum(mass_symbols) - 1)
    stationary_solutions = sp.linsolve(stationarity_equations, mass_symbols)
    require(len(stationary_solutions) == 1, "stationary distribution is not uniquely determined")
    stationary = list(next(iter(stationary_solutions)))
    require(all(value.is_Rational is True and value >= 0 for value in stationary), "invalid exact stationary mass")
    achieved_average = sp.cancel(sum(mass * cost for mass, cost in zip(stationary, rhs)))
    require(achieved_average == rho, "stationary average cost disagrees with the Bellman limit")
    for pattern in patterns:
        x, r, y = (pattern[key] for key in ("representative_initial_inventory", "representative_capacity", "canonical_target"))
        all_costs = [fee(x, target, r) + hq[INDEX[target]] for target in XS]
        require(fee(x, y, r) + hq[INDEX[y]] == min(all_costs), "Blackwell action fails average-cost greediness")
        pattern["average_all_optimal_targets"] = [target for target, value in zip(XS, all_costs) if value == min(all_costs)]

    binding = []
    for pattern in patterns:
        x, r, y = (pattern[key] for key in ("representative_initial_inventory", "representative_capacity", "canonical_target"))
        if x in INDEX and r in (1, 2) and x < y == x + r < S:
            costs = [fee(x, target, r) + hq[INDEX[target]] for target in XS]
            margin = min(value for target, value in zip(XS, costs) if target != y) - costs[INDEX[y]]
            if margin > 0:
                binding.append({"x": x, "r": r, "target": y, "S": S,
                                "average_bias_action_cost": qs(costs[INDEX[y]]),
                                "strict_average_action_gap": qs(margin)})
    require(bool(binding), "the selected example has no actual binding-capacity effect")

    result = {
        "schema": "inventory-blackwell-average-exact-v1",
        "scope": "One nontrivial unit-demand inventory instance; finite and all-initial-state tariff inequalities certified exactly; no Lean execution",
        "parameters": {"lambda": "1", "mu": "1", "h": "1", "b": "4", "K": "6", "k": "1",
                       "R": {"1": "1/2", "2": "1/2"}, "alpha": "symbolic"},
        "uniform_exact_action_interval_for_0_alpha_le_1": {"L": L, "U": U, "states": N},
        "reference_discount": qs(ALPHA_REF),
        "reference_policy_iterations": iterations,
        "certified_blackwell_discount_interval": {"lower": "0", "lower_open": True, "upper": qs(epsilon), "upper_closed": True},
        "common_denominator_coefficients_ascending": [qs(value) for value in den_coeff],
        "common_denominator_factorization": str(sp.factor(denominator.as_expr())),
        "G_alpha": {str(x): str(gs[INDEX[x]]) for x in XS},
        "reference_G": {str(x): qs(g_ref[INDEX[x]]) for x in XS},
        "smallest_discounted_minimizer": S,
        "discounted_global_minimizers_on_certified_interval": [x for x in XS if sp.cancel(gs[INDEX[x]] - gs[INDEX[S]]) == 0],
        "policy_event_targets": {str(x): {event[3]: target for target, event in zip(policy[x], events(x))} for x in XS},
        "policy_event_rate_matrix": [[qs(value) for value in row] for row in rate_matrix],
        "policy_running_cost_vector": [str(value) for value in rhs],
        "global_tariff_pattern_count": len(patterns),
        "all_initial_state_tariff_patterns": patterns,
        "distinct_action_inequality_count": len(proofs),
        "action_inequality_certificates": proofs,
        "average_cost_rate_rho": str(rho),
        "stationary_postdecision_distribution": {str(x): str(stationary[INDEX[x]]) for x in XS},
        "stationary_cost_rate": str(achieved_average),
        "normalized_bias_H": {str(x): str(hs[INDEX[x]]) for x in XS},
        "average_bias_minimizers": [x for x in XS if hq[INDEX[x]] == 0],
        "average_Bellman_residuals_e": {str(x): qs(average_residual[INDEX[x]]) for x in XS},
        "average_residual_span": qs(max(average_residual) - min(average_residual)),
        "strict_binding_capacity_examples": binding,
        "verification": {"symbolic_policy_equations": "exact_zero", "all_discounted_action_inequalities": "nonnegative_exact_Bernstein_coefficients",
                         "all_global_initial_tariff_patterns": "covered", "average_Bellman_equations": "exact", "arithmetic": "rational; no floating point", "sympy_version": sp.__version__},
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(args.output), "epsilon": qs(epsilon), "rho": str(rho), "S": S,
                      "patterns": len(patterns), "inequalities": len(proofs), "average_residual_span": "0", "binding_examples": binding}, ensure_ascii=False))


if __name__ == "__main__":
    main()
