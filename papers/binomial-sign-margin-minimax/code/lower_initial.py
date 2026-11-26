#!/usr/bin/env python3
"""Exact rational finite certificates for lower_initial.md.

This program does not numerically evaluate a weighted best-approximation dual.
Its explicit finite-difference witnesses are a separate family. All probability,
moment, margin and channel comparisons below use fractions, never floating point.
The analytical all-parameter theorem is proved in the manuscript.
"""

from __future__ import annotations

import argparse
from fractions import Fraction as F
from math import comb
from pathlib import Path
import json


def sgn(x: F) -> int:
    return (x > 0) - (x < 0)


def add_atom(law: dict[F, F], x: F, mass: F) -> None:
    law[x] = law.get(x, F(0)) + mass


def moment(law: dict[F, F], j: int) -> F:
    return sum((p * x**j for x, p in law.items()), F(0))


def target(law: dict[F, F]) -> F:
    return sum((p * sgn(x) for x, p in law.items()), F(0))


def channel(law: dict[F, F], n: int) -> list[F]:
    ans = []
    for k in range(n + 1):
        ans.append(
            sum(
                (
                    p
                    * comb(n, k)
                    * ((1 + x) / 2) ** k
                    * ((1 - x) / 2) ** (n - k)
                    for x, p in law.items()
                ),
                F(0),
            )
        )
    return ans


def margin_check(law: dict[F, F], beta: int) -> list[dict[str, str]]:
    assert all(p >= 0 for p in law.values())
    assert sum(law.values(), F(0)) == 1
    assert all(-1 <= x <= 1 for x in law)
    assert law.get(F(0), F(0)) == 0
    rows = []
    # A finite law's centered mass is constant between its support radii.
    # Therefore these checks establish the margin bound for every real t>0.
    for t in sorted({abs(x) for x, p in law.items() if p > 0}):
        mass = sum((p for x, p in law.items() if abs(x) <= t), F(0))
        assert mass <= t**beta
        rows.append({"radius": str(t), "mass": str(mass), "bound": str(t**beta)})
    return rows


def finite_difference_pair(beta: int, d: int, s: int) -> dict:
    assert beta >= 1 and d >= 2 and d % 2 == 0 and s >= 1
    n = d * s * s
    h = F(1, 8 * s)
    assert h * h == F(d, 64 * n)
    q = d + 1  # odd: the finite-difference signed measure is odd
    raw_plus: dict[F, F] = {}
    raw_minus: dict[F, F] = {}
    for j in range(q + 1):
        x = h * F(2 * j - q, q)
        mass = F(comb(q, j), 2 ** (q - 1))
        add_atom(raw_plus if j % 2 == 0 else raw_minus, x, mass)
    assert sum(raw_plus.values(), F(0)) == sum(raw_minus.values(), F(0)) == 1
    if target(raw_plus) < 0:
        raw_plus, raw_minus = raw_minus, raw_plus
    assert target(raw_plus) > 0
    assert raw_minus == {-x: p for x, p in raw_plus.items()}
    radii = sorted({abs(x) for x in raw_plus} | {abs(x) for x in raw_minus})
    cap = []
    for t in radii:
        mass_plus = sum((p for x, p in raw_plus.items() if abs(x) <= t), F(0))
        mass_minus = sum((p for x, p in raw_minus.items() if abs(x) <= t), F(0))
        assert mass_plus == mass_minus
        if mass_plus:
            cap.append(t**beta / mass_plus)
    alpha = min([F(1)] + cap)
    plus = {x: alpha * p for x, p in raw_plus.items()}
    minus = {x: alpha * p for x, p in raw_minus.items()}
    for law in (plus, minus):
        add_atom(law, F(-1), (1 - alpha) / 2)
        add_atom(law, F(1), (1 - alpha) / 2)
    margin_rows = margin_check(plus, beta)
    margin_check(minus, beta)
    assert minus == {-x: p for x, p in plus.items()}
    b = target(plus)
    assert b > 0 and target(minus) == -b
    deltas = [moment(plus, j) - moment(minus, j) for j in range(n + 1)]
    assert all(deltas[j] == 0 for j in range(d + 1))
    p_plus, p_minus = channel(plus, n), channel(minus, n)
    assert sum(p_plus, F(0)) == sum(p_minus, F(0)) == 1
    central = [F(comb(n, k), 2**n) for k in range(n + 1)]
    chi_lhs = sum(((p - qv) ** 2 / r for p, qv, r in zip(p_plus, p_minus, central)), F(0))
    chi_rhs = sum((comb(n, j) * deltas[j] ** 2 for j in range(n + 1)), F(0))
    assert chi_lhs == chi_rhs
    denominator_ratio = min((p + qv) / r for p, qv, r in zip(p_plus, p_minus, central))
    assert denominator_ratio > 0
    # H^2 <= sum (p-q)^2/(p+q) <= central quadratic / denominator_ratio.
    # This exact certificate is much more compact than adding many unrelated
    # rational denominators in the triangular discrimination itself.
    hellinger_upper = chi_lhs / denominator_ratio
    if hellinger_upper == 0:
        assert p_plus == p_minus
        Q = 10**6
        q_note = "Any Q is valid because the count laws coincide; one example is recorded."
    else:
        Q = (F(1, 4) / hellinger_upper).__floor__()
        assert Q >= 1
        q_note = "Largest integer certified by Q times this rational Hellinger upper bound <= 1/4."
    assert Q * hellinger_upper <= F(1, 4)
    if n == d:
        assert hellinger_upper == 0
    return {
        "beta": beta,
        "L": 1,
        "n": n,
        "matched_degree": d,
        "s": s,
        "h": str(h),
        "local_mass": str(alpha),
        "plus_atoms": [{"z": str(x), "mass": str(p)} for x, p in sorted(plus.items())],
        "minus_is_reflection": True,
        "binding_radius_margin_checks": margin_rows,
        "target_plus": str(b),
        "target_minus": str(-b),
        "moments_match_through_degree": d,
        "central_binomial_quadratic_lhs": str(chi_lhs),
        "central_binomial_quadratic_rhs": str(chi_rhs),
        "pointwise_denominator_ratio_to_central_binomial": str(denominator_ratio),
        "hellinger_squared_upper": str(hellinger_upper),
        "certified_Q": Q,
        "Q_selection_note": q_note,
        "Q_times_hellinger_squared_upper": str(Q * hellinger_upper),
        "certified_minimax_decision_risk_lower": str(b / 4),
        "all_checks_exact": True,
    }


def rare_atom_case(beta: int, h: F) -> dict:
    n = 3
    rho = h**beta
    plus = {F(-1): (1 - rho) / 2, F(1): (1 - rho) / 2, h: rho}
    minus = {-x: p for x, p in plus.items()}
    margin_check(plus, beta)
    margin_check(minus, beta)
    p, q = channel(plus, n), channel(minus, n)
    inner_triangle = sum(((p[k] - q[k]) ** 2 / (p[k] + q[k]) for k in (1, 2)), F(0))
    assert inner_triangle == F(3, 2) * rho * (1 - h * h) * h * h
    exact_rational_lower = inner_triangle / 2
    assert exact_rational_lower >= F(9, 16) * rho * h * h
    # (sqrt(p)+sqrt(q))^2 <= 2(p+q), so H^2 >= triangle/2.
    return {
        "beta": beta,
        "n": n,
        "h": str(h),
        "rho": str(rho),
        "hellinger_squared_lower": str(exact_rational_lower),
        "lower_divided_by_rho_h_squared": str(exact_rational_lower / (rho * h * h)),
        "lower_divided_by_rho_squared_h_squared": str(exact_rational_lower / (rho * rho * h * h)),
        "interpretation": "The final ratio diverges as h tends to zero; quadratic-in-local-mass Hellinger scaling cannot be presumed.",
        "all_checks_exact": True,
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results" / "lower_initial.json")
    args = parser.parse_args()
    finite = [finite_difference_pair(beta, d, s) for beta in (1, 2, 3) for d in (2, 4, 6, 8) for s in (1, 2, 3)]
    rare = [rare_atom_case(beta, F(1, 2**j)) for beta in (1, 2, 3) for j in (1, 2, 3, 4)]
    report = {
        "status": "PASS_EXACT_RATIONAL_CHECKS",
        "arithmetic": "Python standard-library fractions.Fraction; no floating point is used.",
        "scope": "Explicit finite-support examples and exact algebraic identities only. The manuscript proves the uniform theorem using a stated prior weighted-approximation input.",
        "finite_difference_witness_count": len(finite),
        "rare_atom_witness_count": len(rare),
        "finite_difference_witnesses": finite,
        "rare_atom_witnesses": rare,
        "not_claimed": [
            "Numerical solution of the weighted best-approximation dual",
            "The full minimax rate or original spectral conjecture",
            "A numerical proof of a theorem over all real beta and all Q,n",
        ],
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"status": report["status"], "finite_difference_witnesses": len(finite), "rare_atom_witnesses": len(rare), "output": str(args.output)}))


if __name__ == "__main__":
    main()
