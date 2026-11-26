#!/usr/bin/env python3
"""Exact finite witnesses for the log-minus-quadratic phase diagram.

Uses only the Python standard library. All decisions use fractions.Fraction.
The log term is enclosed using a positive series with an explicit rational
tail bound. Decimal strings are display-only. No finite check is presented
as a substitute for the analytic all-dimension proof.
"""

from decimal import Decimal, localcontext
from fractions import Fraction as F
from itertools import product
from pathlib import Path
import json


def dot(a, b):
    return sum((x * y for x, y in zip(a, b)), F(0))


def square_norm(a):
    return dot(a, a)


def text_fraction(q):
    return str(q.numerator) if q.denominator == 1 else f"{q.numerator}/{q.denominator}"


def decimal_display(q):
    with localcontext() as ctx:
        ctx.prec = 28
        return str(Decimal(q.numerator) / Decimal(q.denominator))


def encoded(q):
    return {"exact": text_fraction(q), "decimal_display_only": decimal_display(q)}


def quadratic_expected_value(prior, channels):
    """Direct Bayes enumeration, without using any differential identity.

    Each channel is the vector of its plus-outcome likelihoods. The channels
    are independent conditional on the state. Returns E sum_i posterior_i^2.
    """
    total = F(0)
    for outcomes in product((0, 1), repeat=len(channels)):
        unnormalized = []
        for i, pi in enumerate(prior):
            joint = pi
            for outcome, channel in zip(outcomes, channels):
                joint *= channel[i] if outcome else 1 - channel[i]
            unnormalized.append(joint)
        mass = sum(unnormalized, F(0))
        assert mass > 0
        total += sum((u * u for u in unnormalized), F(0)) / mass
    return total


def quadratic_interaction(prior, a, b):
    return (
        quadratic_expected_value(prior, [a, b])
        - quadratic_expected_value(prior, [a])
        - quadratic_expected_value(prior, [b])
        + quadratic_expected_value(prior, [])
    )


def joint_signal_masses(prior, a, b):
    return [
        sum(
            (
                prior[i]
                * (a[i] if alpha else 1 - a[i])
                * (b[i] if beta else 1 - b[i])
                for i in range(len(prior))
            ),
            F(0),
        )
        for alpha, beta in product((0, 1), repeat=2)
    ]


def validate(prior, a, b):
    assert len(prior) == len(a) == len(b)
    assert all(pi > 0 for pi in prior)
    assert sum(prior, F(0)) == 1
    assert all(0 < ai < 1 for ai in a)
    assert all(0 < bi < 1 for bi in b)
    assert dot(prior, a) == F(1, 2)
    assert dot(prior, b) == F(1, 2)


def log_mutual_information_bounds(r, terms=3):
    """Enclose J(r)=((1+r)log(1+r)+(1-r)log(1-r))/2.

    J(r)=sum_{k>=1} r^(2k)/((2k)(2k-1)), |r|<1.
    The positive tail after K terms is at most its first coefficient times
    the remaining geometric series. This proof is independent of float logs.
    """
    assert abs(r) < 1 and terms >= 1
    lower = sum((r ** (2 * k) / ((2 * k) * (2 * k - 1))
                 for k in range(1, terms + 1)), F(0))
    tail = r ** (2 * terms + 2) / (
        (2 * terms + 2) * (2 * terms + 1) * (1 - r * r)
    )
    return lower, lower + tail


def certify(prior, a, b, c, terms=3):
    """Positive interaction means a strict failure of submodularity."""
    validate(prior, a, b)
    masses = joint_signal_masses(prior, a, b)
    r = 4 * masses[3] - 1
    assert masses == [(1 + r) / 4, (1 - r) / 4,
                      (1 - r) / 4, (1 + r) / 4]
    dq = quadratic_interaction(prior, a, b)
    jlo, jhi = log_mutual_information_bounds(r, terms)
    # Under conditional independence, the log-score interaction is -I(A;B).
    # This identity is exact, not a numerical cancellation of large log terms.
    gaplo = -jhi - c * dq / 2
    gaphi = -jlo - c * dq / 2
    return {
        "dimension": len(prior),
        "c": text_fraction(c),
        "prior": [text_fraction(q) for q in prior],
        "a_plus_likelihoods": [text_fraction(q) for q in a],
        "b_plus_likelihoods": [text_fraction(q) for q in b],
        "joint_signal_masses_00_01_10_11": [text_fraction(q) for q in masses],
        "r": text_fraction(r),
        "quadratic_interaction": encoded(dq),
        "log_mi_lower": encoded(jlo),
        "log_mi_upper": encoded(jhi),
        "interaction_lower": encoded(gaplo),
        "interaction_upper": encoded(gaphi),
        "log_series_terms": terms,
        "strict_submodularity_violation_certified": gaplo > 0,
    }, gaplo


def negative_c_exact(n):
    prior = [F(1, n)] * n
    a = [F(3, 4), F(1, 4)] + [F(1, 2)] * (n - 2)
    b = [F(5, 8), F(5, 8), F(1, 4)] + [F(1, 2)] * (n - 3)
    validate(prior, a, b)
    assert joint_signal_masses(prior, a, b) == [F(1, 4)] * 4
    dq = quadratic_interaction(prior, a, b)
    assert dq == F(1, 32 * n * n)
    report, lower = certify(prior, a, b, F(-1, 4))
    assert lower == F(1, 256 * n * n)
    report["symbolic_gap_for_arbitrary_negative_c"] = f"-c/{64*n*n}"
    return report


def explicit_three_state_witness():
    prior = [F(49, 50), F(1, 100), F(1, 100)]
    z = [F(1), F(1, 5), F(-491, 5)]
    v = [F(2460, 1476), F(-2465, 1476), F(5, 1476)]
    assert dot(prior, z) == 0 and sum(v, F(0)) == 0 and dot(v, z) == 1
    y = [vi * zi for vi, zi in zip(v, z)]
    curvature_ratio = 3 * square_norm(prior) - square_norm(
        [yi - 2 * pi for yi, pi in zip(y, prior)]
    )
    assert curvature_ratio == F(433343573, 170201250)
    c = F(2, 5)
    assert c * curvature_ratio - 1 == F(7840448, 425503125) > 0
    s = t = F(1, 200)
    a = [(1 + s * zi) / 2 for zi in z]
    b = [(1 + t * vi / pi) / 2 for vi, pi in zip(v, prior)]
    assert a == [F(201, 400), F(1001, 2000), F(509, 2000)]
    assert b == [F(593, 1176), F(487, 5904), F(2957, 5904)]
    report, lower = certify(prior, a, b, c)
    assert lower > F(1, 200000000000)  # More than 5e-12, by exact comparison.
    report["local_curvature_ratio"] = encoded(curvature_ratio)
    report["half_matrix_curvature"] = encoded(c * curvature_ratio - 1)
    report["posterior_split_s"] = text_fraction(s)
    report["posterior_split_t"] = text_fraction(t)
    return report


def projected_rational_directions(n, small_b):
    """Rational directions converging to the sharp n>=3 obstruction.

    The projection minimizes ||y-2p||^2 under sum y=1 and sum y_i/x_i=0.
    Its two-by-two Gram solve uses rational arithmetic throughout.
    """
    assert n >= 3 and 0 < small_b < F(1, n)
    big_a = 1 - (n - 1) * small_b
    prior = [big_a] + [small_b] * (n - 1)
    middle = F(n - 2, 2 * n - 1)
    x = [F(1)] + [middle] * (n - 2)
    x += [-(big_a + (n - 2) * small_b * middle) / small_b]
    reciprocal = [1 / xi for xi in x]
    rsum, rsq = sum(reciprocal, F(0)), square_norm(reciprocal)
    determinant = n * rsq - rsum * rsum
    assert determinant > 0
    rhs0, rhs1 = F(-1), -2 * dot(prior, reciprocal)
    lam = (rhs0 * rsq - rhs1 * rsum) / determinant
    mu = (n * rhs1 - rsum * rhs0) / determinant
    y = [2 * pi + lam + mu * ri for pi, ri in zip(prior, reciprocal)]
    v = [yi / xi for yi, xi in zip(y, x)]
    assert dot(prior, x) == 0
    assert sum(y, F(0)) == 1 and dot(y, reciprocal) == 0
    assert sum(v, F(0)) == 0 and dot(v, x) == 1
    ratio = 3 * square_norm(prior) - square_norm([yi - 2*pi for yi, pi in zip(y, prior)])
    assert ratio <= 3 * square_norm(prior) - F(1, n)
    return prior, x, v, ratio


def generic_positive_witness(n, c):
    """Construct a finite certificate when c>n/(3n-1), n>=3.

    Termination follows from the analytic limits proved in the accompanying
    notes. Loop ceilings are only defensive limits for this executable.
    """
    assert n >= 3 and c > F(n, 3 * n - 1)
    for exponent in range(2, 50):
        b0 = F(1, 10 ** exponent)
        if b0 >= F(1, n):
            continue
        prior, x, v, ratio = projected_rational_directions(n, b0)
        if c * ratio > 1:
            break
    else:
        raise RuntimeError("No local witness within defensive search budget")
    bound = max(max(abs(xi) for xi in x), max(abs(vi / pi) for vi, pi in zip(v, prior)))
    step = 1 / (2 * (1 + bound))
    for shrink_count in range(80):
        a = [(1 + step * xi) / 2 for xi in x]
        b = [(1 + step * vi / pi) / 2 for vi, pi in zip(v, prior)]
        report, lower = certify(prior, a, b, c)
        if lower > 0:
            report["rational_small_b"] = text_fraction(b0)
            report["local_curvature_ratio"] = encoded(ratio)
            report["threshold"] = text_fraction(F(n, 3*n-1))
            report["common_split_step"] = text_fraction(step)
            report["shrink_count"] = shrink_count
            return report
        step /= 2
    raise RuntimeError("No finite witness within defensive search budget")


def main():
    negative = [negative_c_exact(n) for n in (3, 4, 7, 10)]
    explicit = explicit_three_state_witness()
    generated = [generic_positive_witness(n, c) for n, c in (
        (3, F(2, 5)), (4, F(3, 8)), (5, F(9, 25)), (10, F(7, 20)), (30, F(17, 50)),
    )]
    report = {
        "method": "Exact Bayesian enumeration and rational bounds on the log MI series",
        "floating_point_used_for_certification": False,
        "formal_proof_assistant_used": False,
        "theorem_scope_warning": "Finite witnesses certify failures; sufficiency and all-n sharpness use the analytic proof, not enumeration.",
        "negative_c_exact_witnesses": negative,
        "explicit_positive_c_three_state_witness": explicit,
        "generic_positive_c_witnesses": generated,
        "all_certificates_pass": all(r["strict_submodularity_violation_certified"]
                                     for r in negative + [explicit] + generated),
    }
    assert report["all_certificates_pass"]
    out = Path(__file__).resolve().parent.parent / 'results' / "phase_certificates.json"
    out.parent.mkdir(parents=True, exist_ok=True)
    out.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n")
    print("All 10 exact finite witnesses certified.")
    print("Explicit n=3, c=2/5 gap lower:", explicit["interaction_lower"]["exact"])
    print("Display only:", explicit["interaction_lower"]["decimal_display_only"])
    print("Written:", out.name)


if __name__ == "__main__":
    main()
