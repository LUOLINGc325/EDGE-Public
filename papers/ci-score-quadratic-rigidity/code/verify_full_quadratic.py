#!/usr/bin/env python3
"""Exact certificates for full symmetric quadratic perturbations.

Run beside verify_phase.py. Both files use only the Python standard library.
All mathematical decisions below use fractions.Fraction, including the log
remainder bounds. The direct Bayesian enumerator does not use the curvature
formula whose consequences it checks.
"""

from fractions import Fraction as F
from itertools import combinations, product
from pathlib import Path
import json

from verify_phase import (
    dot, square_norm, encoded, text_fraction,
    joint_signal_masses, validate, log_mutual_information_bounds,
)


def matvec(matrix, vector):
    return [dot(row, vector) for row in matrix]


def quadratic(matrix, vector):
    return dot(vector, matvec(matrix, vector))


def diagonal(values):
    return [[values[i] if i == j else F(0) for j in range(len(values))]
            for i in range(len(values))]


def determinant(matrix):
    a = [row[:] for row in matrix]
    n, result = len(a), F(1)
    for col in range(n):
        pivot = next((j for j in range(col, n) if a[j][col]), None)
        if pivot is None:
            return F(0)
        if pivot != col:
            a[col], a[pivot] = a[pivot], a[col]
            result = -result
        p = a[col][col]
        result *= p
        for j in range(col + 1, n):
            factor = a[j][col] / p
            for k in range(col + 1, n):
                a[j][k] -= factor * a[col][k]
            a[j][col] = F(0)
    return result


def lmi_report(coefficients, lam):
    n = len(coefficients)
    h = 3 * max(coefficients) - lam
    matrix = [[(coefficients[i] if i == j else 0) - h
               for j in range(n)] for i in range(n)]
    minors = []
    for size in range(1, n + 1):
        for ix in combinations(range(n), size):
            value = determinant([[matrix[i][j] for j in ix] for i in ix])
            minors.append({"indices_zero_based": list(ix), "determinant": text_fraction(value)})
    return {
        "coefficients": [text_fraction(ci) for ci in coefficients],
        "lambda": text_fraction(lam),
        "h": text_fraction(h),
        "matrix": [[text_fraction(q) for q in row] for row in matrix],
        "all_principal_minors": minors,
        "positive_semidefinite_certified": all(F(item["determinant"]) >= 0 for item in minors),
    }


def decompose(matrix):
    """O(n^2) exact structural check. Returns unique a,c or None."""
    n = len(matrix)
    assert n >= 3
    assert all(matrix[i][j] == matrix[j][i] for i in range(n) for j in range(n))
    a = [
        (matrix[0][1] + matrix[0][2] - matrix[1][2]) / 2,
        (matrix[0][1] + matrix[1][2] - matrix[0][2]) / 2,
        (matrix[0][2] + matrix[1][2] - matrix[0][1]) / 2,
    ]
    a += [matrix[0][i] - a[0] for i in range(3, n)]
    if any(matrix[i][j] != a[i] + a[j] for i in range(n) for j in range(n) if i != j):
        return None
    c = [matrix[i][i] - 2 * a[i] for i in range(n)]
    return a, c


def expected_quadratic(prior, channels, matrix):
    total = F(0)
    for outcomes in product((0, 1), repeat=len(channels)):
        unnormalized = []
        for i, pi in enumerate(prior):
            value = pi
            for outcome, channel in zip(outcomes, channels):
                value *= channel[i] if outcome else 1 - channel[i]
            unnormalized.append(value)
        mass = sum(unnormalized, F(0))
        assert mass > 0
        total += quadratic(matrix, unnormalized) / mass
    return total


def quadratic_interaction(prior, a, b, matrix):
    return (expected_quadratic(prior, [a, b], matrix)
            - expected_quadratic(prior, [a], matrix)
            - expected_quadratic(prior, [b], matrix)
            + expected_quadratic(prior, [], matrix))


def general_certificate(prior, a, b, matrix, lam, terms=3):
    validate(prior, a, b)
    masses = joint_signal_masses(prior, a, b)
    r = 4 * masses[3] - 1
    assert masses == [(1+r)/4, (1-r)/4, (1-r)/4, (1+r)/4]
    dq = quadratic_interaction(prior, a, b, matrix)
    lo, hi = log_mutual_information_bounds(r, terms)
    candidates = [-lam * lo - dq/2, -lam * hi - dq/2]
    lower, upper = min(candidates), max(candidates)
    return {
        "dimension": len(prior),
        "lambda": text_fraction(lam),
        "matrix_C": [[text_fraction(q) for q in row] for row in matrix],
        "prior": [text_fraction(pi) for pi in prior],
        "a_plus_likelihoods": [text_fraction(ai) for ai in a],
        "b_plus_likelihoods": [text_fraction(bi) for bi in b],
        "joint_masses_00_01_10_11": [text_fraction(q) for q in masses],
        "correlation_r": text_fraction(r),
        "quadratic_interaction": encoded(dq),
        "log_mi_lower": encoded(lo),
        "log_mi_upper": encoded(hi),
        "interaction_lower": encoded(lower),
        "interaction_upper": encoded(upper),
        "strict_submodularity_violation_certified": lower > 0,
    }, lower


def half_curvature(prior, x, v, matrix, lam):
    assert dot(prior, x) == 0 and sum(v, F(0)) == 0
    d = dot(v, x)
    y = [vi * xi for vi, xi in zip(v, x)]
    w = [pi * xi for pi, xi in zip(prior, x)]
    q = [yi - d*pi for yi, pi in zip(y, prior)]
    return -lam*d*d - quadratic(matrix, q) + 2*d*dot(w, matvec(matrix, v))


def make_finite_witness(prior, x, v, matrix, lam):
    value = half_curvature(prior, x, v, matrix, lam)
    assert value > 0
    s = 1 / (2 * (1 + max(abs(xi) for xi in x)))
    t = 1 / (2 * (1 + max(abs(vi/pi) for vi, pi in zip(v, prior))))
    for count in range(100):
        a = [(1 + s*xi) / 2 for xi in x]
        b = [(1 + t*vi/pi) / 2 for vi, pi in zip(v, prior)]
        report, lower = general_certificate(prior, a, b, matrix, lam)
        if lower > 0:
            report["half_matrix_curvature"] = encoded(value)
            report["split_s"] = text_fraction(s)
            report["split_t"] = text_fraction(t)
            report["shrink_count"] = count
            return report
        s /= 2
        t /= 2
    raise RuntimeError("Witness search exhausted defensive iteration budget")


def cross_perturbation(lam):
    prior = [F(1, 4)] * 4
    epsilon = F(1, 4)
    matrix = [[F(0) for _ in range(4)] for _ in range(4)]
    matrix[0][2] = matrix[2][0] = epsilon
    assert decompose(matrix) is None
    tau = epsilon / (lam + 1)
    x = [F(4), F(-4), tau, -tau]
    v = [F(0), F(0), F(1), F(-1)]
    value = half_curvature(prior, x, v, matrix, lam)
    assert value == F(33, 128) / (lam + 1)**2
    report = make_finite_witness(prior, x, v, matrix, lam)
    report["epsilon"] = text_fraction(epsilon)
    report["tau"] = text_fraction(tau)
    report["four_point_residual_C13_C14_C23_C24"] = text_fraction(epsilon)
    report["global_strict_convexity_lower_bound"] = text_fraction(lam-epsilon)
    assert lam - epsilon > 0
    return report


def affine_projection(target, total, reciprocal, inverse_weights=None):
    n = len(target)
    if inverse_weights is None:
        inverse_weights = [F(1)] * n
    s0 = sum(inverse_weights, F(0))
    s1 = dot(inverse_weights, reciprocal)
    s2 = sum((wi*ai*ai for wi, ai in zip(inverse_weights, reciprocal)), F(0))
    b0 = total - sum(target, F(0))
    b1 = -dot(target, reciprocal)
    det = s0*s2 - s1*s1
    assert det > 0
    alpha = (b0*s2-b1*s1)/det
    beta = (s0*b1-s1*b0)/det
    answer = [ti+wi*(alpha+beta*ai) for ti, wi, ai in zip(target, inverse_weights, reciprocal)]
    assert sum(answer, F(0)) == total
    assert dot(answer, reciprocal) == 0
    return answer


def positive_weighted_failure():
    c = [F(7, 20), F(1, 100), F(1, 5)]
    matrix = diagonal(c)
    harmonic = 1 / sum((1/ci for ci in c), F(0))
    assert harmonic == F(7, 755)
    assert 3*max(c)-harmonic > 1
    r = [harmonic/ci for ci in c]
    y_limit = [2-r[0], -r[1], -r[2]]
    middle = -y_limit[1]/y_limit[0]
    assert middle == F(70, 149)
    for exponent in range(2, 30):
        b0 = F(1, 10**exponent)
        p = [1-2*b0, b0, b0]
        x = [F(1), middle, -(p[0]+b0*middle)/b0]
        recip = [1/xi for xi in x]
        target = [2*pi for pi in p]
        y = affine_projection(target, F(1), recip, [1/ci for ci in c])
        v = [yi/xi for yi, xi in zip(y, x)]
        if half_curvature(p, x, v, matrix, F(1)) > 0:
            break
    else:
        raise RuntimeError("No positive weighted local witness")
    report = make_finite_witness(p, x, v, matrix, F(1))
    report["diagonal_coefficients"] = [text_fraction(ci) for ci in c]
    report["harmonic_beta"] = text_fraction(harmonic)
    report["exact_minimum_lambda"] = text_fraction(3*max(c)-harmonic)
    return report


def critical_signed_failure(lam=F(100)):
    # One negative coefficient, total reciprocal sum exactly zero.
    # Original order (-1,2,2) is relabeled so a maximum vertex is first.
    c = [F(2), F(-1), F(2)]
    assert sum((1/ci for ci in c), F(0)) == 0
    matrix = diagonal(c)
    # q has sum one, q^T Cq=1-2T; at T=100 and lambda=100 it
    # violates the proposed LMI by exactly -105.
    T = F(100)
    q = [(1-T)/2, T, (1-T)/2]
    assert sum(q, F(0)) == 1
    assert quadratic(matrix, q) == 1-2*T == -199
    h = 3*max(c)-lam
    assert quadratic(matrix, q)-h == -105
    d = F(-1)
    y_limit = q[:]
    y_limit[0] += 2*d
    assert sum(y_limit, F(0)) == d
    middle = -y_limit[1]/y_limit[0]
    for exponent in range(2, 40):
        b0 = F(1, 10**exponent)
        p = [1-2*b0, b0, b0]
        x = [F(1), middle, -(p[0]+b0*middle)/b0]
        reciprocal = [1/xi for xi in x]
        y = affine_projection(y_limit, d, reciprocal)
        v = [yi/xi for yi, xi in zip(y, x)]
        if half_curvature(p, x, v, matrix, lam) > 0:
            break
    else:
        raise RuntimeError("No critical signed local witness")
    report = make_finite_witness(p, x, v, matrix, lam)
    report["reciprocal_sum"] = "0"
    report["unbounded_beta_family"] = "q=((1-T)/2,T,(1-T)/2); q^T Cq=1-2T"
    report["q_at_T_100"] = [text_fraction(qi) for qi in q]
    report["q_lmi_quadratic_value"] = "-105"
    return report


def gauge_invariance_check():
    c = [F(-1, 20), F(1, 5), F(1, 5)]
    gauge = [F(1, 7), F(-2, 9), F(3, 11)]
    d = diagonal(c)
    matrix = [[d[i][j]+gauge[i]+gauge[j] for j in range(3)] for i in range(3)]
    a2, c2 = decompose(matrix)
    assert a2 == gauge and c2 == c
    p = [F(1, 3)]*3
    a = [F(3, 4), F(1, 4), F(1, 2)]
    b = [F(5, 8), F(5, 8), F(1, 4)]
    original = quadratic_interaction(p, a, b, matrix)
    reduced = quadratic_interaction(p, a, b, d)
    assert original == reduced
    return {"matrix_C": [[text_fraction(q) for q in row] for row in matrix],
            "recovered_gauge": [text_fraction(q) for q in a2],
            "recovered_diagonal": [text_fraction(q) for q in c2],
            "direct_bayes_interaction_difference": text_fraction(original-reduced)}


def main():
    admissible_specs = [
        ("equal_n3_endpoint", [F(3,8)]*3, F(1)),
        ("unequal_positive_endpoint", [F(11,93),F(22,93),F(11,31)], F(1)),
        ("signed_interior", [F(-1,20),F(1,5),F(1,5)], F(1)),
        ("signed_endpoint", [F(-1,14),F(2,7),F(2,7)], F(1)),
        ("zero_coefficient_endpoint", [F(1,3),F(0),F(1,7)], F(1)),
        ("affine_trivial_lambda_zero", [F(0)]*3, F(0)),
        ("equal_n4_endpoint", [F(4,11)]*4, F(1)),
    ]
    admissible = []
    for name, c, lam in admissible_specs:
        r = lmi_report(c, lam)
        r["name"] = name
        assert r["positive_semidefinite_certified"]
        admissible.append(r)
    cross = [cross_perturbation(F(1)), cross_perturbation(F(100))]
    weighted = positive_weighted_failure()
    critical = critical_signed_failure()
    report = {
        "method": "Exact principal minors, exact Bayes enumeration, rational log-series enclosures",
        "floating_point_used_for_certification": False,
        "formal_proof_assistant_used": False,
        "scope_warning": "Listed finite certificates do not replace the analytic all-parameter classification.",
        "admissible_lmi_certificates": admissible,
        "cross_perturbation_finite_witnesses": cross,
        "positive_unequal_finite_witness": weighted,
        "critical_signed_finite_witness_lambda_100": critical,
        "affine_gauge_direct_enumeration_check": gauge_invariance_check(),
        "all_certificates_pass": all(r["strict_submodularity_violation_certified"]
                                     for r in cross+[weighted,critical]),
    }
    assert report["all_certificates_pass"]
    path = Path(__file__).resolve().parent.parent / 'results' / "full_quadratic_certificates.json"
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(report, ensure_ascii=False, indent=2)+"\n")
    print("Seven admissible LMI certificates and four strict finite failures certified.")
    for name, r in [("cross_lambda_1",cross[0]), ("cross_lambda_100",cross[1]),
                    ("positive_unequal",weighted), ("signed_critical_lambda_100",critical)]:
        print(name, r["interaction_lower"]["decimal_display_only"], "(display only)")
    print("Written:", path.name)


if __name__ == "__main__":
    main()
