#!/usr/bin/env python3
"""Independent finite checks for the null-diluted grid construction.

Run from the case directory:
    python code/verify_secondary.py --local-only

Exact checks use only the Python standard library.  Matplotlib, if available,
produces the supplementary numerical quantile figure.  No network, proof
assistant, external optimizer, or original verifier is used.

Finite computation verifies certificates and selected instances.  The uniform
N>=250 argument and the general probabilistic identities also require the
written derivation; asymptotic plots are numerical diagnostics, not proofs.
"""

from __future__ import annotations

import argparse
from collections import defaultdict
from decimal import Decimal as D, localcontext
from fractions import Fraction as F
import hashlib
import itertools
import json
from math import comb, factorial
from pathlib import Path
import platform


def rational(x):
    return str(F(x))


def decimal_fraction(x, precision=90):
    x = F(x)
    with localcontext() as context:
        context.prec = precision
        return str(D(x.numerator) / D(x.denominator))


def decimal_text(x, digits=55):
    return format(x, f".{digits}g")


def stirling_second(n, k):
    row = [1] + [0] * k
    for _ in range(n):
        row = [0] + [row[j - 1] + j * row[j] for j in range(1, k + 1)]
    return row[k]


def falling(d, j):
    answer = 1
    for t in range(j):
        answer *= d - t
    return answer


def original_compatible_probability(d, r, n):
    if n == 0:
        return F(1)
    numerator = sum(falling(d, j) * stirling_second(n, j) * r**j
                    for j in range(1, min(d, n) + 1))
    return F(numerator, (d * r)**n)


def binomial_mixture(d, r, n, q):
    return sum((F(comb(n, k)) * q**k * (1 - q)**(n - k)
                * original_compatible_probability(d, r, k)
                for k in range(n + 1)), F(0))


def closed_probability(d, r, n, q):
    return sum((F(comb(d, j) * r**j * (1 - r)**(d - j))
                * (1 - q + F(j, d * r) * q)**n
                for j in range(d + 1)), F(0))


def state_counts(d, r, q, max_n):
    """Independent weighted integer enumeration by coordinate assignments.

    A compatible state stores the observed value of each coordinate, zero
    meaning not observed.  None is an absorbing incompatible state.  Every
    elementary outcome has integer weight under a common denominator.
    """
    denominator = d * r * q.denominator
    active_weight = q.numerator
    null_weight = d * r * (q.denominator - q.numerator)
    assert null_weight + d * r * active_weight == denominator
    counts = {(0,) * d: 1}
    output = [{"N": 0, "compatible_weight": 1, "total_weight": 1,
               "state_count": 1, "probability": F(1)}]
    transitions = {}
    for n in range(1, max_n + 1):
        nxt = defaultdict(int)
        for state, weight in counts.items():
            if state is None:
                nxt[None] += denominator * weight
                continue
            nxt[state] += null_weight * weight
            if state not in transitions:
                choices = []
                for ell in range(d):
                    for a in range(1, r + 1):
                        if state[ell] not in (0, a):
                            choices.append(None)
                        else:
                            child = list(state)
                            child[ell] = a
                            choices.append(tuple(child))
                transitions[state] = choices
            for child in transitions[state]:
                nxt[child] += active_weight * weight
        counts = {s: w for s, w in nxt.items() if w}
        total = denominator**n
        assert sum(counts.values()) == total
        compatible = sum(w for s, w in counts.items() if s is not None)
        output.append({"N": n, "compatible_weight": compatible,
                       "total_weight": total, "state_count": len(counts),
                       "probability": F(compatible, total)})
    return output


def direct_grid_intersections(d, r, n, q):
    """Literal ordered-sequence enumeration using allowed grid-point sets."""
    grid = frozenset(itertools.product(range(1, r + 1), repeat=d))
    allowed = [grid]
    for ell in range(d):
        for a in range(1, r + 1):
            allowed.append(frozenset(u for u in grid if u[ell] == a))
    denominator = d * r * q.denominator
    weights = [d * r * (q.denominator - q.numerator)] + [q.numerator] * (d * r)
    good = 0
    total = 0
    for sample in itertools.product(range(d * r + 1), repeat=n):
        weight = 1
        possible = grid
        for symbol in sample:
            weight *= weights[symbol]
            possible = possible.intersection(allowed[symbol])
        total += weight
        if possible:
            good += weight
    assert total == denominator**n
    return F(good, total), (d * r + 1)**n


def mixed_law_checks():
    ds, rs, qs = (2, 3, 4), (2, 3, 5), (F(1, 7), F(2, 7), F(3, 4))
    rows = []
    for d, r, q in itertools.product(ds, rs, qs):
        states = state_counts(d, r, q, 8)
        assert states[0]["probability"] == closed_probability(d, r, 0, q) == 1
        for n in range(1, 9):
            mixture = binomial_mixture(d, r, n, q)
            closed = closed_probability(d, r, n, q)
            state = states[n]
            assert mixture == closed == state["probability"]
            assert 0 <= closed <= 1
            rows.append({"d": d, "r": r, "N": n, "q": rational(q),
                         "risk_if_compatible": rational(q * F(r - 1, r)),
                         "closed_probability": rational(closed),
                         "binomial_mixture": rational(mixture),
                         "state_probability": rational(state["probability"]),
                         "state_compatible_integer_weight": state["compatible_weight"],
                         "state_total_integer_weight": state["total_weight"],
                         "reachable_state_count": state["state_count"]})
    assert len(rows) == 3 * 3 * 3 * 8 == 216

    direct = []
    for r, q in itertools.product((2, 3), qs):
        states = state_counts(2, r, q, 4)
        for n in range(5):
            value, sample_count = direct_grid_intersections(2, r, n, q)
            assert value == states[n]["probability"]
            direct.append({"d": 2, "r": r, "N": n, "q": rational(q),
                           "ordered_sequence_count": sample_count,
                           "probability": rational(value)})
    assert len(direct) == 30

    boundaries = []
    for d, r, q in itertools.product((2, 3), (2, 3), (F(0), F(1))):
        states = state_counts(d, r, q, 3)
        for n in range(4):
            a = closed_probability(d, r, n, q)
            b = binomial_mixture(d, r, n, q)
            assert a == b == states[n]["probability"]
            if q == 0 or n == 0:
                assert a == 1
            boundaries.append({"d": d, "r": r, "N": n, "q": rational(q),
                               "compatibility_probability": rational(a)})
    assert len(boundaries) == 32
    return rows, direct, boundaries


def polynomial_second_order_checks():
    rows = []
    for r in (2, 3, 5):
        a = F(r - 1, r)
        b = 1 - F(1, 2 * r)
        for n in range(2, 21):
            # Construct the full two polynomials coefficient by coefficient.
            qp = [F(comb(n, k)) * (r*r*(-a)**k
                  - 2*r*(r-1)*(-b)**k + (r-1)**2*(-F(1))**k)
                  for k in range(n + 1)]
            bp = [F(comb(n, k)) * (-a)**k for k in range(n + 1)]
            for k in range(1, n + 1):
                bp[k] += n * a * comb(n - 1, k - 1) * (-a)**(k - 1)
            gap = [x - y for x, y in zip(qp, bp)]
            expected = F(comb(n, 2) * (r - 1) * (r - 2), 2*r*r)
            assert gap[0] == gap[1] == 0
            assert gap[2] == expected
            if r > 2:
                assert expected > 0
            if r == 3:
                assert expected == F(comb(n, 2), 9)
                # The manuscript uses the strictly smaller threshold 3q/5.
                threshold_slope = F(3, 5)
                benchmark_inner = [F(comb(n, k)) * (-threshold_slope)**k
                                   for k in range(n + 1)]
                for k in range(1, n + 1):
                    benchmark_inner[k] += n * threshold_slope * comb(n - 1, k - 1) * (-threshold_slope)**(k - 1)
                inner_gap = [x-y for x, y in zip(qp, benchmark_inner)]
                assert inner_gap[0] == inner_gap[1] == 0
                assert inner_gap[2] == F(2, 75) * comb(n, 2) > 0
            probe = F(2, 7)
            assert sum((c * probe**k for k, c in enumerate(qp)), F(0)) == closed_probability(2, r, n, probe)
            row = {"r": r, "N": n,
                   "q0_coefficient": rational(gap[0]),
                   "q1_coefficient": rational(gap[1]),
                   "q2_coefficient": rational(gap[2]),
                   "formula": rational(expected)}
            if r == 3:
                row["epsilon_equals_3q_over_5_gap_q2_coefficient"] = rational(inner_gap[2])
                row["epsilon_equals_3q_over_5_expected_q2_coefficient"] = rational(F(2, 75)*comb(n,2))
            rows.append(row)
    assert len(rows) == 57
    return rows


def beta_tail(d, n, eps):
    return sum((F(comb(n, j)) * eps**j * (1 - eps)**(n - j)
                for j in range(d)), F(0))


def fixed_nine_dimensional_checks():
    rows = []
    first_positive = None
    for n in range(3, 81):
        q = F(3, n)
        eps = F(2, n) - F(1, n*n)
        probability = closed_probability(2, 3, n, q)
        benchmark = beta_tail(2, n, eps)
        gap = probability - benchmark
        assert q <= 1 and 0 < eps < F(2, n)
        if gap > 0 and first_positive is None:
            first_positive = n
        rows.append({"N": n, "q": rational(q), "epsilon": rational(eps),
                     "gap_positive": gap > 0, "gap_decimal": decimal_fraction(gap, 40)})
    assert first_positive == 12
    assert all(row["gap_positive"] == (row["N"] >= 12) for row in rows)

    n = 250
    q = F(3, n)
    eps = F(2, n) - F(1, n*n)
    probability = closed_probability(2, 3, n, q)
    benchmark = beta_tail(2, n, eps)
    gap = probability - benchmark
    assert gap > 0

    # Rational certificates used by the written uniform analytic proof.
    exp1_lower_partial = sum((F(1, factorial(k)) for k in range(5)), F(0))
    exp1_upper_series = sum((F(1, factorial(k)) for k in range(3)), F(0)) + F(1, factorial(3)) / (1-F(1,4))
    half_exp_upper_series = sum((F(1, 2**k * factorial(k)) for k in range(4)), F(0)) + F(1, 2**4 * factorial(4)) / (1-F(1,10))
    exp1_paper_upper = exp1_lower_partial + F(1, factorial(5)) / (1-F(1,6))
    assert exp1_lower_partial > F(27, 10)
    assert exp1_upper_series < F(11, 4)
    assert half_exp_upper_series < F(33, 20)
    assert exp1_paper_upper == F(1631, 600) < F(11, 4)
    assert exp1_paper_upper < F(33, 20)**2
    normalized_limit_lower = 6*F(27, 10)-12*F(33, 20)+4
    assert normalized_limit_lower == F(2, 5)
    bracket = normalized_limit_lower - F(66, 248) - F(18, 247)
    assert bracket == F(9341, 153140) > 0
    exp_minus_three_lower = F(4, 11)**3
    uniform_gap_lower = exp_minus_three_lower * bracket
    assert gap > uniform_gap_lower > 0
    return rows, {
        "check_range": "N=3,...,80",
        "first_positive_in_checked_range": first_positive,
        "scope": "Finite diagnostic only; no claim that N=12 is the sharp uniform cutoff.",
    }, {
        "N": n, "d": 2, "r": 3, "ambient_dimension": 9,
        "scenario_type_count_including_null": 7,
        "q": rational(q), "risk_if_compatible": rational(F(2, n)),
        "epsilon": rational(eps),
        "probability_exact": rational(probability),
        "beta_tail_exact": rational(benchmark), "gap_exact": rational(gap),
        "probability_decimal": decimal_fraction(probability),
        "beta_tail_decimal": decimal_fraction(benchmark),
        "gap_decimal": decimal_fraction(gap),
    }, {
        "range": "all integers N>=250, justified by the companion written inequalities",
        "exp1_lower_series_partial": rational(exp1_lower_partial),
        "exp1_upper_series_majorant": rational(exp1_upper_series),
        "exp_half_upper_series_majorant": rational(half_exp_upper_series),
        "exp1_manuscript_upper_series_majorant": rational(exp1_paper_upper),
        "exp1_coarse_lower": "27/10", "exp1_coarse_upper": "11/4",
        "exp_half_coarse_upper": "33/20",
        "normalized_limit_gap_coarse_lower": rational(normalized_limit_lower),
        "normalized_uniform_gap_lower": rational(bracket),
        "exp_minus_three_rational_lower": rational(exp_minus_three_lower),
        "uniform_gap_rational_lower": rational(uniform_gap_lower),
        "uniform_gap_rational_lower_decimal": decimal_fraction(uniform_gap_lower),
        "scope": "The script verifies the rational constants. Uniformity over N and the log/series estimates are proved in the companion derivation, not by finite enumeration or a proof assistant.",
    }


def logarithmic_tail(kind, d, c):
    """Return -log(tail), using high precision and avoiding tiny probabilities."""
    dd = D(d)
    if kind == "lower":
        return c - dd * (1 + c/dd).ln()
    if kind == "upper":
        return c - dd - dd * (c/dd).ln()
    if kind == "gamma":
        series = sum((c**j / D(factorial(j)) for j in range(d)), D(0))
        return c - series.ln()
    raise ValueError(kind)


def numerical_quantile(kind, d, b):
    lo = D(d) if kind == "upper" else D(0)
    hi = max(D(2*d), 2*b + 2*d)
    while logarithmic_tail(kind, d, hi) < b:
        hi *= 2
    for _ in range(360):
        midpoint = (lo + hi)/2
        if logarithmic_tail(kind, d, midpoint) < b:
            lo = midpoint
        else:
            hi = midpoint
    answer = (lo + hi)/2
    assert abs(logarithmic_tail(kind, d, answer) - b) < D("1e-70")
    return answer


def asymptotic_numerical_checks():
    rows = []
    with localcontext() as context:
        context.prec = 95
        for d, b_int in itertools.product((2, 3, 5), (10, 25, 50, 100, 250, 500, 1000)):
            b = D(b_int)
            lower = numerical_quantile("lower", d, b)
            upper = numerical_quantile("upper", d, b)
            gamma = numerical_quantile("gamma", d, b)
            base = b + d*b.ln() - d*D(d).ln()
            gamma_base = b + (d-1)*b.ln() - D(factorial(d-1)).ln()
            shift_error = upper - lower - d
            assert abs(shift_error) < D("1e-70")
            rows.append({
                "d": d, "b_log_inverse_beta": b_int,
                "beta_decimal": decimal_text((-b).exp()),
                "lower_quantile": decimal_text(lower),
                "known_upper_envelope_quantile": decimal_text(upper),
                "gamma_d_quantile": decimal_text(gamma),
                "lower_asymptotic_expression": decimal_text(base),
                "lower_asymptotic_residual": decimal_text(lower-base),
                "upper_asymptotic_residual": decimal_text(upper-base-d),
                "gamma_asymptotic_residual": decimal_text(gamma-gamma_base),
                "lower_minus_gamma": decimal_text(lower-gamma),
                "predicted_lower_minus_gamma": decimal_text(base-gamma_base),
                "upper_lower_exact_shift_residual_numeric": decimal_text(shift_error),
            })
        e = D(1).exp()
        limit = 9*(-D(2)).exp()-12*(-D(5)/2).exp()+4*(-D(3)).exp()
        beta = 3*(-D(2)).exp()
        constants = {
            "decimal_working_precision": context.prec,
            "e": decimal_text(e, 80),
            "sqrt_e": decimal_text((D(1)/2).exp(), 80),
            "fixed_D9_tail_limit": decimal_text(limit, 80),
            "fixed_D9_beta_tail_limit": decimal_text(beta, 80),
            "fixed_D9_gap_limit": decimal_text(limit-beta, 80),
            "fixed_D9_tail_ratio_limit": decimal_text(limit/beta, 80),
            "normalized_gap_6e_minus_12sqrt_e_plus_4": decimal_text(6*e-12*(D(1)/2).exp()+4, 80),
        }
    return rows, constants


def make_plot(rows, output_dir):
    try:
        import matplotlib
        matplotlib.use("Agg")
        import matplotlib.pyplot as plt
    except ImportError:
        return {"status": "unavailable", "reason": "Matplotlib not installed"}
    fig, axes = plt.subplots(1, 2, figsize=(11.8, 4.6), constrained_layout=True)
    palette = {2: "#176B87", 3: "#B15A27", 5: "#6E4A99"}
    for d in (2, 3, 5):
        subset = [row for row in rows if row["d"] == d]
        b = [row["b_log_inverse_beta"] for row in subset]
        axes[0].plot(b, [float(row["lower_asymptotic_residual"]) for row in subset],
                     marker="o", color=palette[d], label=f"d = {d}")
        axes[1].plot(b, [float(row["lower_minus_gamma"]) for row in subset],
                     marker="o", color=palette[d], label=f"d = {d}: numerical")
        axes[1].plot(b, [float(row["predicted_lower_minus_gamma"]) for row in subset],
                     linestyle="--", color=palette[d], label=f"d = {d}: asymptotic")
    axes[0].set_title("Lower-envelope quantile remainder")
    axes[0].set_ylabel(r"$c_L-[b+d\log b-d\log d]$")
    axes[1].set_title("Extra correction beyond Gamma(d) calibration")
    axes[1].set_ylabel(r"$c_L-c_{\Gamma(d)}$")
    for ax in axes:
        ax.set_xscale("log")
        ax.set_xlabel(r"$b=\log(1/\beta)$")
        ax.grid(alpha=0.22)
        ax.legend(fontsize=8)
    fig.suptitle("Numerical diagnostics only; finite grids and quantile curves do not prove limits", fontsize=10)
    png = output_dir / "secondary_quantile_asymptotics.png"
    svg = output_dir / "secondary_quantile_asymptotics.svg"
    fig.savefig(png, dpi=180)
    fig.savefig(svg)
    plt.close(fig)
    return {"status": "generated", "png": png.name, "svg": svg.name,
            "matplotlib_version": matplotlib.__version__}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--local-only", action="store_true")
    parser.add_argument("--no-plot", action="store_true")
    parser.add_argument("--output-dir", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results")
    args = parser.parse_args()
    mixed, direct, boundaries = mixed_law_checks()
    polynomial = polynomial_second_order_checks()
    fixed_rows, finite_scan, n250, analytic = fixed_nine_dimensional_checks()
    quantiles, constants = asymptotic_numerical_checks()
    args.output_dir.mkdir(parents=True, exist_ok=True)
    plot = {"status": "omitted_by_flag"} if args.no_plot else make_plot(quantiles, args.output_dir)
    result = {
        "schema": "convex-scenario-secondary-verification-v1",
        "status": "passed",
        "runtime": {"python": platform.python_version(),
                    "verifier_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest()},
        "scope": {
            "mixed_law_grid": {"d": [2,3,4], "r": [2,3,5],
                               "N": list(range(1,9)), "q": ["1/7","2/7","3/4"],
                               "case_count": len(mixed)},
            "count_clarification": "The earlier single-q grid has 3*3*8=72 cases. This three-q grid has 3*3*8*3=216 cases.",
            "literal_sequence_enumeration_case_count": len(direct),
            "empty_sample_and_q_boundary_case_count": len(boundaries),
            "polynomial_second_order_case_count": len(polynomial),
            "manuscript_epsilon_3q_over_5_coefficient_case_count": sum(row["r"] == 3 for row in polynomial),
            "limitations": "Exact finite calculations supplement the written derivation. The all-N analytic inequalities and all asymptotic statements are not machine-proved here. Quantile values and plots are numerical only. No Lean is written or run.",
        },
        "mixed_law_three_way_checks": mixed,
        "literal_sequence_checks": direct,
        "boundary_checks": boundaries,
        "d2_polynomial_second_order_checks": polynomial,
        "fixed_D9_N3_to_N80_diagnostics": fixed_rows,
        "finite_scan_summary": finite_scan,
        "N250_exact_certificate": n250,
        "uniform_N_ge_250_rational_constants": analytic,
        "high_precision_limit_constants": constants,
        "quantile_numerical_diagnostics": quantiles,
        "quantile_plot": plot,
        "known_upper_bound_attribution": {
            "source": "G. O. Berger, arXiv:2501.08884v2, Theorem 2",
            "url": "https://arxiv.org/html/2501.08884v2",
            "status": "Existing upper bound used only for comparison; not claimed as a new theorem.",
        },
    }
    target = args.output_dir / "secondary_verification.json"
    target.write_text(json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True) + "\n")
    print(json.dumps({
        "status": "passed", "output": target.name,
        "sha256": hashlib.sha256(target.read_bytes()).hexdigest(),
        "mixed_law_three_way_case_count": len(mixed),
        "literal_sequence_case_count": len(direct),
        "boundary_case_count": len(boundaries),
        "second_order_case_count": len(polynomial),
        "N250_gap_decimal": n250["gap_decimal"],
        "uniform_N_ge_250_rational_lower": analytic["uniform_gap_rational_lower"],
        "limit_gap_decimal": constants["fixed_D9_gap_limit"],
        "plot": plot,
        "no_lean_run": True,
    }, ensure_ascii=False, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
