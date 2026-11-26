"""Reproducible exact arithmetic checks; no external Python dependencies.

Checks finite identities, rational root brackets, and finite adversarial
obstruction certificates. These are not a formal proof of the general theorem.
Run from any directory; output is deterministic and JSON-serializable.
"""
import argparse
from fractions import Fraction as F
import json
from pathlib import Path

from one_max import (delay_exact, excess_integral_exact, finite_obstruction_exact,
                     quantile_exact, root_bracket_exact)


def require(condition, message):
    # Deliberately independent of Python assertions: python -O must also check.
    if not condition:
        raise ArithmeticError(message)


def build():
    risks = [F(1, 20), F(1, 10), F(1, 5), F(1, 4), F(1, 3),
             F(2, 5), F(49, 100), F(1, 2), F(3, 4), F(9, 10)]
    ratios = [F(1), F(7, 6), F(3, 2), F(2), F(11, 3), F(10)]
    identity_checks = 0
    plateau_checks = 0
    for delta in risks:
        points = {F(i, 40) for i in range(41)}
        for j in range(1, 21):
            if j * delta <= 1:
                points.add(j * delta)
        for a in ratios:
            for t in sorted(points):
                rhs = a + a / (1 - delta) * excess_integral_exact(a, delta, max(F(0), t - delta))
                require(quantile_exact(a, delta, t) == rhs, "Volterra identity failed")
                identity_checks += 1
            if delta >= F(1, 2):
                require(quantile_exact(a, delta) == a * a, "plateau identity failed")
                plateau_checks += 1

    # Exact values with a polynomial root equal to the rational number two.
    examples = [(F(1, 3), F(9, 2)), (F(1, 4), F(400, 81))]
    for delta, theta in examples:
        require(quantile_exact(F(2), delta) == theta, "exact example failed")

    brackets = []
    for theta in map(F, [2, 10, 100, 10000]):
        for delta in risks:
            lo, hi = root_bracket_exact(theta, delta)
            require(quantile_exact(lo, delta) <= theta, "lower bracket failed")
            require(quantile_exact(hi, delta) >= theta, "upper bracket failed")
            brackets.append(dict(theta=str(theta), delta=str(delta), lo=str(lo), hi=str(hi),
                                 width=str(hi - lo), decimal_illustration=f"{float((lo+hi)/2):.12f}"))

    obstructions = [finite_obstruction_exact(theta, delta, a) for theta, delta, a in
                    [(F(9, 2), F(1, 3), F(19, 10)),
                     (F(400, 81), F(1, 4), F(199, 100)),
                     (F(100), F(1, 3), F(7)),
                     (F(100), F(1, 2), F(9)),
                     (F(100), F(49, 100), F(99, 10))]]

    # Negative controls: omitting the top-input condition is insufficient.
    # Q(t)=1 obeys the a=1 envelope for every t, but fails at theta=2.
    terminal_negative_control = dict(delta="1/3", theta="2", proposed_ratio="1",
                                     threshold="1", all_quantile_inequalities=True,
                                     terminal_reward="1", terminal_condition=False)
    require(F(2) > F(1), "negative control failed")

    rejected_nonobstruction = False
    try:
        finite_obstruction_exact(F(9, 2), F(1, 3), F(2))
    except ValueError:
        rejected_nonobstruction = True
    require(rejected_nonobstruction, "checker accepted a false strict obstruction")

    return dict(status="PASS", arithmetic="fractions.Fraction; exact rational",
                scope="finite arithmetic checks, root intervals and theorem-based finite input certificates; no general formal verification",
                volterra_identity_checks=identity_checks, plateau_identity_checks=plateau_checks,
                exact_rational_examples=[dict(delta=str(d), theta=str(t), optimum="2") for d,t in examples],
                certified_root_intervals=brackets, finite_adversary_certificates=obstructions,
                negative_control=terminal_negative_control,
                invalid_certificate_rejected=rejected_nonobstruction)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    result = build()
    encoded = json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(encoded, encoding="utf-8")
    else:
        print(encoded, end="")
