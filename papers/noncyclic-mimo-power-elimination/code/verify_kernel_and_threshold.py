#!/usr/bin/env python3
"""Exact Schur-identity and two-channel threshold boundary calculations.

The threshold audit is conditional on the cyclic feasibility theorem and the
operational bridge, which this script does not purport to prove.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path

import sympy as sp


def tail_threshold(poles, noise_variances):
    poles = list(map(sp.Rational, poles))
    nu1, nu2 = map(sp.Rational, noise_variances)
    assert 0 < nu1 <= nu2
    assert all(abs(pole) > 1 for pole in poles)
    D = sp.sympify(sp.prod(pole**2 for pole in poles))
    L = max([sp.Integer(1)] + [pole**2 for pole in poles])
    unconstrained = sp.sqrt(D * nu2 / nu1)
    q = min(D, max(L, unconstrained))
    value = sp.simplify(nu1 * (q - 1) + nu2 * (D / q - 1))
    assert q >= L and q >= sp.sqrt(D) and q <= D
    return D, L, q, value


def checks() -> dict:
    s, c, t, u = sp.symbols("s c t u")
    kernel = lambda x, y: (x*y-c)/(1-x*y)
    lhs = kernel(t, u) - kernel(s, t) * kernel(s, u) / kernel(s, s)
    rhs = (s**2 * (1-c)/(s**2-c) * (s-t)/(1-s*t) * (s-u)/(1-s*u)
           * (t*u-c/s**2)/(1-t*u))
    assert sp.factor(lhs-rhs) == 0

    q, D, nu1, nu2 = sp.symbols("q D nu1 nu2", positive=True)
    objective = nu1*(q-1) + nu2*(D/q-1)
    assert sp.diff(objective, q) == nu1 - D*nu2/q**2
    assert sp.diff(objective, q, 2) == 2*D*nu2/q**3

    cases = [
        ("empty_tail", [], [1, 1], 1, 0),
        ("one_singleton", [2], [1, 1], 4, 3),
        ("negative_singleton_same_power", [-2], [1, 1], 4, 3),
        ("dominant_pole_equal_noise", [3, 2], [1, 1], 9, 11),
        ("interior_water_filling_known_old_example", [2, sp.Rational(5, 4)], [1, 4], 5, 5),
        ("interior_equal_noise_three_distinct_poles", [2, 3, 4], [1, 1], 24, 46),
        ("pole_water_filling_switch", [3, 2], [1, sp.Rational(9, 4)], 9, sp.Rational(59, 4)),
        ("water_filling_shutoff_switch", [3, 2], [1, 36], 36, 35),
        ("strict_weak_channel_shutoff", [3, 2], [1, 49], 36, 35),
    ]
    results = []
    for name, poles, noise, expected_q, expected_value in cases:
        d, ell, qq, value = tail_threshold(poles, noise)
        assert qq == expected_q and value == expected_value
        results.append({
            "name": name, "poles": list(map(str, poles)),
            "noise_variances": list(map(str, noise)),
            "D": str(d), "L": str(ell), "q": str(qq),
            "gamma2": str(sp.simplify(d/qq)), "tail_threshold": str(value),
        })

    ell = sp.symbols("L", positive=True)
    # At the dominant-pole/water-filling switch, nu2=nu1*L^2/D.
    pole_value = nu1*(ell-1) + nu1*ell**2/D*(D/ell-1)
    water_value_at_pole = 2*nu1*ell - nu1 - nu1*ell**2/D
    assert sp.factor(pole_value-water_value_at_pole) == 0
    # At the water-filling/shutoff switch, nu2=nu1*D.
    assert sp.expand((2*nu1*D-nu1-nu1*D) - nu1*(D-1)) == 0

    a, b = sp.symbols("a b", positive=True)
    repeated = a**2*(b**2+1)-2
    cyclic_limit = 2*a**2*b-2
    assert sp.factor(repeated-cyclic_limit-a**2*(b-1)**2) == 0
    repeated_family = repeated.subs(a, b**2)
    cyclic_family = cyclic_limit.subs(a, b**2)
    ratio = sp.factor(repeated_family/cyclic_family)
    assert sp.limit(ratio/b, b, sp.oo) == sp.Rational(1, 2)
    assert sp.factor(repeated_family-(b/2)*cyclic_family-(b**4+b-2)) == 0
    assert repeated.subs({a: 3, b: 2}) == 43
    assert cyclic_limit.subs({a: 3, b: 2}) == 34

    return {
        "schema_version": 1,
        "status": "pass",
        "arithmetic": "symbolic rational identities and exact algebraic numbers",
        "sympy_version": sp.__version__,
        "schur_identity_residual": "0",
        "schur_identity_domain": "0<|s|<1, 0<c<s^2, |t|<1, |u|<1, t!=s, u!=s",
        "objective_first_derivative": str(sp.diff(objective, q)),
        "objective_second_derivative": str(sp.diff(objective, q, 2)),
        "global_minimizer": "q=min(D,max(L,sqrt(D*nu2/nu1)))",
        "objective_domain": "D=product(singleton_pole^2), L=max(1,singleton_pole^2), 0<nu1<=nu2, q in [max(L,sqrt(D)),D]",
        "threshold_cases": results,
        "transition_identities": {
            "dominant_to_water_filling": "0",
            "water_filling_to_shutoff": "0",
        },
        "merger": {
            "repeated_threshold": str(repeated),
            "cyclic_limit": str(cyclic_limit),
            "gap": str(sp.factor(repeated-cyclic_limit)),
            "a_equals_b_squared_ratio": str(ratio),
            "ratio_divided_by_b_limit": "1/2",
            "family_positivity_domain": "b>1; a=b^2>b",
            "three_two_example_repeated": "43",
            "three_two_example_simple_spectrum_limit": "34",
        },
        "limits": [
            "The scalar Schur identity does not by itself prove the all-dynamic-LTI converse.",
            "The closed-form calculation assumes the established cyclic feasibility conditions.",
            "All thresholds are infima; boundary strict-feasibility and covariance closure need their mathematical proofs.",
        ],
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).with_name("kernel_threshold_checks.json"))
    args = parser.parse_args()
    result = checks()
    args.output.write_text(json.dumps(result, indent=2, ensure_ascii=False) + "\n")
    print(json.dumps({"status": result["status"],
                      "exact_boundary_cases": len(result["threshold_cases"]),
                      "output": str(args.output)}, ensure_ascii=False))


if __name__ == "__main__":
    main()
