#!/usr/bin/env python3
"""Replay the paper's finite arithmetic certificate using exact fractions.

No third-party package, optimizer, network access, random sampling, or
floating-point arithmetic is used. The manuscript supplies the mathematical
reductions and probability inequalities; this script checks their finite data
and constants. This is an arithmetic verifier, not a formal proof assistant.

Examples:
    python code/verify_exact.py
    python code/verify_exact.py --output results/exact_certificate.json
"""

import argparse
from fractions import Fraction as F
from itertools import permutations, product
import json
from pathlib import Path


COS = (1, 0, -1, 0)
SIN = (0, 1, 0, -1)
SIGN = (1, -1, 1, -1)
X = [(160 * COS[j], 160 * SIN[j], 180 * SIGN[j]) for j in range(4)]
Y = [
    [(96 * COS[j] - 126 * SIN[j],
      96 * SIN[j] + 126 * COS[j], 255 * SIGN[j]) for j in range(4)],
    [(288 * COS[j], 288 * SIN[j], 30 * SIGN[j]) for j in range(4)],
    [(96 * COS[j] + 126 * SIN[j],
      96 * SIN[j] - 126 * COS[j], 255 * SIGN[j]) for j in range(4)],
]
Z = [(-180 * SIN[j], 180 * COS[j], 160 * SIGN[j]) for j in range(4)]
ALPHA = F(1, 10)
BETA = F(19, 10)
DELTA = BETA - ALPHA

EXPECTED_MARGINS = [
    [F(28570, 9), F(7640, 9), F(391450, 9)],
    [F(59200, 9), F(43520, 9), F(59200, 9)],
    [F(391450, 9), F(7640, 9), F(28570, 9)],
]
EXPECTED_ORBITS = [
    [58000, 34476, 48672, 7596],
    [38912, 34476, 58000, 11436],
    [33424, 6060, 48672, 11436],
    [38912, 6060, 25744, 7596],
]
Q_MONOMIALS = [(2, 0, 0), (1, 1, 0), (1, 0, 1),
               (0, 2, 0), (0, 1, 1), (0, 0, 2)]
BH_MONOMIALS = [(0, 0), (1, 0), (0, 1), (2, 0), (1, 1), (0, 2)]


def dot(a, b):
    return sum(x * y for x, y in zip(a, b))


def norm_squared(a):
    return dot(a, a)


def subtract(a, b):
    return tuple(x - y for x, y in zip(a, b))


def mean(vectors):
    return tuple(sum(F(v[d], len(vectors)) for v in vectors) for d in range(3))


def rotation(v):
    return (-v[1], v[0], -v[2])


def assignment_certificate(a, b):
    """All 4! extreme assignments for the uniform four-point OT problem."""
    matrix = [[norm_squared(subtract(x, y)) for y in b] for x in a]
    values = [
        (sum(matrix[j][p[j]] for j in range(4)) / F(4), p)
        for p in permutations(range(4))
    ]
    minimum = min(value for value, _ in values)
    return {
        "squared_distance_matrix": matrix,
        "assignments_enumerated": len(values),
        "minimum_mean_cost": minimum,
        "optimal_permutations": [p for value, p in values if value == minimum],
    }


# Sparse multivariate polynomials: exponent tuple -> exact Fraction.
# Identities are compared coefficient by coefficient, never at sampled points.
def pconstant(value, arity):
    return {(0,) * arity: F(value)} if value else {}


def pvariable(index, arity):
    exponent = [0] * arity
    exponent[index] = 1
    return {tuple(exponent): F(1)}


def padd(*polynomials):
    result = {}
    for polynomial in polynomials:
        for exponent, coefficient in polynomial.items():
            result[exponent] = result.get(exponent, F(0)) + coefficient
    return {e: c for e, c in result.items() if c}


def pscale(polynomial, scalar):
    return {e: c * scalar for e, c in polynomial.items() if c * scalar}


def pmultiply(a, b):
    result = {}
    for ea, ca in a.items():
        for eb, cb in b.items():
            exponent = tuple(x + y for x, y in zip(ea, eb))
            result[exponent] = result.get(exponent, F(0)) + ca * cb
    return {e: c for e, c in result.items() if c}


def pnorm_squared(vector):
    return padd(*(pmultiply(v, v) for v in vector))


def weighted_vector(vectors, weights):
    return tuple(
        padd(*(pscale(weight, vector[d])
               for weight, vector in zip(weights, vectors)))
        for d in range(3)
    )


def dense_coefficients(polynomial, monomials):
    return [polynomial.get(exponent, F(0)) for exponent in monomials]


def encode(value):
    if isinstance(value, F):
        return value.numerator if value.denominator == 1 else str(value)
    if isinstance(value, (list, tuple)):
        return [encode(item) for item in value]
    if isinstance(value, dict):
        return {str(key): encode(item) for key, item in value.items()}
    return value


def verify():
    checked = []

    def require(condition, label):
        # Deliberately not an "assert" statement: python -O must not skip checks.
        if not condition:
            raise AssertionError(label)
        checked.append(label)

    require(0 < ALPHA <= BETA and DELTA < 2, "regularity parameter range")
    require(DELTA == F(9, 5), "regularity width")
    require(F(1, 1) / DELTA == F(5, 9), "conjugate strong convexity")
    require(ALPHA + DELTA == BETA, "potential smoothness")
    require(ALPHA <= 1 <= BETA, "identity anchor regularity")
    for j in range(4):
        require(rotation(X[j]) == X[(j + 1) % 4], "template symmetry")
        require(rotation(Z[j]) == Z[(j + 1) % 4], "competitor symmetry")
        for i in range(3):
            require(rotation(Y[i][j]) == Y[i][(j + 1) % 4], "source symmetry")
        require(mean([Y[i][j] for i in range(3)]) == X[j],
                "diagonal mean identity")
        require(mean([Y[0][j], Y[1][(j + 1) % 4],
                      Y[2][(j + 2) % 4]]) == Z[j],
                "competing mean identity")
        require(norm_squared(X[j]) == 58000, "template norm")
        require(norm_squared(Z[j]) == 58000, "competitor norm")
        require(ALPHA * norm_squared(X[j]) / 2 == 2900,
                "conjugate intercept")

    transformed_gradients = [
        [tuple(F(Y[i][j][d]) - ALPHA * X[j][d] for d in range(3))
         for j in range(4)] for i in range(3)
    ]
    margins = {}
    for i, j, k in product(range(3), range(4), range(4)):
        if j == k:
            continue
        dx = subtract(X[j], X[k])
        dq = subtract(transformed_gradients[i][j], transformed_gradients[i][k])
        margin = (-dot(Y[i][k], dx) - ALPHA * norm_squared(dx) / 2
                  - norm_squared(dq) / (2 * DELTA))
        margins[(i, j, k)] = margin
        require(margin > 0, "strict full interpolation inequality")
        require(margin == EXPECTED_MARGINS[i][(j - k) % 4 - 1],
                "interpolation margin table")
    require(len(margins) == 36, "all ordered interpolation pairs")
    require(min(margins.values()) == F(7640, 9), "minimum interpolation margin")

    # Independent finite-data check for the explicit maximum-of-quadratics H_i.
    for i, j, k in product(range(3), range(4), range(4)):
        if j == k:
            continue
        qj = transformed_gradients[i][j]
        dq = subtract(qj, transformed_gradients[i][k])
        branch_gap = dot(qj, subtract(X[j], X[k])) - norm_squared(dq) / (2 * DELTA)
        require(branch_gap == margins[(i, k, j)] and branch_gap > 0,
                "strict conjugate active-branch certificate")

    orbit_moments = [[None] * 4 for _ in range(4)]
    for a, b in product(range(4), range(4)):
        value = norm_squared(mean([Y[0][0], Y[1][a], Y[2][b]]))
        orbit_moments[a][b] = value
        require(value == EXPECTED_ORBITS[a][b], "orbit moment table")
        require(value <= 58000, "global tuple upper bound")
        require((value == 58000) == ((a, b) in ((0, 0), (1, 2))),
                "exactly two maximizing orbit types")
        # Check every one of the 64 tuples, rather than trusting only the quotient.
        for shift in range(4):
            shifted = mean([Y[0][shift], Y[1][(a + shift) % 4],
                            Y[2][(b + shift) % 4]])
            require(norm_squared(shifted) == value, "all tuple orbit reductions")
    gap = min(58000 - v for row in orbit_moments for v in row if v < 58000)
    require(gap == 9328, "strict gap to all other orbits")

    assignments = {}
    for i in range(3):
        assignments["nu_to_mu" + str(i)] = assignment_certificate(X, Y[i])
        assignments["nu_prime_to_mu" + str(i)] = assignment_certificate(Z, Y[i])
    assignments["nu_to_nu_prime"] = assignment_certificate(X, Z)
    for certificate in assignments.values():
        require(certificate["assignments_enumerated"] == 24, "complete OT enumeration")
    costs_x = [assignments["nu_to_mu" + str(i)]["minimum_mean_cost"] for i in range(3)]
    costs_z = [assignments["nu_prime_to_mu" + str(i)]["minimum_mean_cost"] for i in range(3)]
    require(costs_x == [25597, 38884, 25597], "transport costs from nu")
    require(costs_z == [21157, 47764, 21157], "transport costs from nu prime")
    contrast = [b - a for a, b in zip(costs_x, costs_z)]
    require(contrast == [-4440, 8880, -4440], "sourcewise contrast")
    require(sum(contrast) == 0, "centered contrast")
    variance = sum(costs_x) / F(3)
    contrast_variance = sum(v * v for v in contrast) / F(3)
    separation = assignments["nu_to_nu_prime"]["minimum_mean_cost"]
    require(variance == 30026, "population variance")
    require(contrast_variance == 39427200, "positive contrast variance")
    require(separation == 58400, "barycenter separation")

    # Expand all scores directly from the integer support vectors.
    q = [pvariable(i, 3) for i in range(3)]
    scores = [[None] * 4 for _ in range(4)]
    for a, b in product(range(4), range(4)):
        scores[a][b] = pnorm_squared(weighted_vector([Y[0][0], Y[1][a], Y[2][b]], q))
    score_q = padd(scores[1][2], pscale(scores[0][0], -1))
    expected_q = {(1, 1, 0): F(-13320), (1, 0, 1): F(26640),
                  (0, 1, 1): F(-13320)}
    require(score_q == expected_q, "score polynomial in q: all coefficients")

    b, h = pvariable(0, 2), pvariable(1, 2)
    one = pconstant(1, 2)
    q_bh = [pscale(padd(one, pscale(b, -1), h), F(1, 2)),
            b,
            pscale(padd(one, pscale(b, -1), pscale(h, -1)), F(1, 2))]
    diagonal_bh = weighted_vector([Y[0][0], Y[1][0], Y[2][0]], q_bh)
    competitor_bh = weighted_vector([Y[0][0], Y[1][1], Y[2][2]], q_bh)
    expected_diagonal = (
        padd(pconstant(96, 2), pscale(b, 192)),
        pscale(h, 126),
        padd(pconstant(255, 2), pscale(b, -225)),
    )
    expected_competitor = (
        pscale(h, 96),
        padd(pconstant(126, 2), pscale(b, 162)),
        padd(pconstant(255, 2), pscale(b, -285)),
    )
    require(diagonal_bh == expected_diagonal, "diagonal mean polynomial coefficients")
    require(competitor_bh == expected_competitor, "competing mean polynomial coefficients")
    score_bh = padd(pnorm_squared(competitor_bh), pscale(pnorm_squared(diagonal_bh), -1))
    expected_bh = {(0, 0): F(6660), (1, 0): F(-26640),
                   (2, 0): F(19980), (0, 2): F(-6660)}
    require(score_bh == expected_bh, "score polynomial in b,h: all coefficients")

    t, u, v = [pvariable(i, 3) for i in range(3)]
    q_minimum = [padd(t, u), t, padd(t, v)]
    diagonal_minimum = weighted_vector([Y[0][0], Y[1][0], Y[2][0]], q_minimum)
    competitor_minimum = weighted_vector([Y[0][0], Y[1][1], Y[2][2]], q_minimum)
    score_minimum = pscale(
        padd(pnorm_squared(competitor_minimum), pscale(pnorm_squared(diagonal_minimum), -1)),
        F(1, 13320),
    )
    require(score_minimum == {(1, 1, 0): F(1), (1, 0, 1): F(1),
                             (0, 1, 1): F(2)},
            "minimum-count score t(u+v)+2uv: all coefficients")
    score_derivative_b = expected_bh[(1, 0)] + 2 * expected_bh[(2, 0)] / 3
    require(score_derivative_b == -13320, "score derivative at population weights")
    require(score_derivative_b ** 2 * F(2, 9) == contrast_variance,
            "CLT variance constant")

    # Elementary finite-sample proof constants; radicals are compared by squares.
    radius_squared = max(norm_squared(point) for source in Y for point in source)
    require(radius_squared == 90117, "source radius squared")
    infinity_radius = F(1, 150)
    l1_radius = 3 * infinity_radius
    require(l1_radius == F(1, 50), "frequency norm conversion")
    stable_gap = gap - 4 * radius_squared * l1_radius
    require(stable_gap == F(52966, 25) and stable_gap > 0, "finite-neighborhood orbit gap")
    require(radius_squared * l1_radius ** 2 < 7 ** 2, "R/50 < 7 by squaring")
    require(separation > 240 ** 2, "sqrt(58400) > 240 by squaring")
    require(240 - 7 == 233 and 233 ** 2 > 50000, "separation exceeds 50000")
    require(F(1, 3) - infinity_radius == F(49, 150) > 0, "positive minimum count")
    chebyshev_coefficient = 3 * F(2, 9) / infinity_radius ** 2
    require(chebyshev_coefficient == 15000, "three-count Chebyshev constant")
    n_threshold = 90000
    event_probability = F(1, 3) - chebyshev_coefficient / n_threshold
    require(event_probability == F(1, 6), "favorable frequency event bound")
    no_anchor_lower_bound = F(1, 2)
    require(1 - F(1, 2) == no_anchor_lower_bound, "Bernoulli no-anchor floor for n>=2")
    risk_lower_bound = 50000 * event_probability * no_anchor_lower_bound
    require(risk_lower_bound == F(50000, 12) == F(12500, 3) > 4000,
            "finite-sample risk lower bound")
    denominator_gap_squared = (2 - BETA + ALPHA) ** 2
    require(denominator_gap_squared == F(1, 25), "conjectured denominator")
    require(variance / denominator_gap_squared == 750650, "conjectured RHS coefficient")
    require(separation / 2 == 29200, "asymptotic risk constant")

    payload = {
        "schema_version": 1,
        "status": "PASS",
        "certificate_scope": "Exact finite arithmetic; analytic and probabilistic reductions are in the manuscript.",
        "arithmetic": "Python fractions.Fraction and integer polynomial coefficient dictionaries",
        "checks_passed": len(checked),
        "parameters": {"dimension": 3, "alpha": ALPHA, "beta": BETA, "delta": DELTA},
        "support": {"x": X, "y": Y, "z": Z},
        "interpolation": {
            "ordered_pairs_checked": len(margins),
            "margins_by_source_and_cyclic_difference_1_2_3": EXPECTED_MARGINS,
            "minimum_margin": min(margins.values()),
            "transformed_gradients": transformed_gradients,
            "conjugate_maximum_intercept": 2900,
            "conjugate_strong_convexity": F(5, 9),
            "conjugate_active_branch_gaps_checked": 36,
        },
        "population_coupling": {
            "tuple_count": 64,
            "orbit_moments_by_row_a_and_column_b": orbit_moments,
            "optimal_orbits": [[0, 0], [1, 2]],
            "other_orbit_minimum_gap": gap,
        },
        "optimal_transport": assignments,
        "risk_data": {
            "costs_from_nu": costs_x,
            "costs_from_nu_prime": costs_z,
            "contrast": contrast,
            "contrast_variance": contrast_variance,
            "population_variance": variance,
            "barycenter_separation_squared": separation,
        },
        "polynomials": {
            "verification": "Every coefficient is compared exactly; no sampled evaluations are used.",
            "q_variables": ["q0", "q1", "q2"],
            "q_monomials": ["q0^2", "q0*q1", "q0*q2", "q1^2", "q1*q2", "q2^2"],
            "all_orbit_score_coefficients_by_row_a_and_column_b":
                [[dense_coefficients(scores[a][b], Q_MONOMIALS) for b in range(4)]
                 for a in range(4)],
            "score_difference_q_coefficients": dense_coefficients(score_q, Q_MONOMIALS),
            "bh_variables": ["b", "h"],
            "bh_monomials": ["1", "b", "h", "b^2", "b*h", "h^2"],
            "score_difference_bh_coefficients": dense_coefficients(score_bh, BH_MONOMIALS),
            "minimum_count_substitution": "q0=t+u, q1=t, q2=t+v",
            "minimum_count_score_divided_by_13320": "t*u+t*v+2*u*v",
            "score_derivative_b_at_population": score_derivative_b,
        },
        "finite_sample_constants": {
            "radius_squared": radius_squared,
            "frequency_infinity_radius": infinity_radius,
            "frequency_l1_radius": l1_radius,
            "remaining_other_orbit_gap": stable_gap,
            "radius_bound_verified": "R/50 < 7",
            "separation_bound_verified": "sqrt(58400) > 240",
            "squared_risk_on_favorable_event_strictly_exceeds": 50000,
            "chebyshev_numerator": chebyshev_coefficient,
            "n_threshold": n_threshold,
            "additional_n_condition": "n is not divisible by 3",
            "frequency_event_probability_lower_bound": event_probability,
            "no_anchor_probability_lower_bound": no_anchor_lower_bound,
            "risk_lower_bound": risk_lower_bound,
            "risk_lower_bound_strictly_exceeds": 4000,
            "conjectured_denominator_gap_squared": denominator_gap_squared,
            "conjectured_rhs_C_over_n_coefficient_before_1_minus_n_inverse_squared": 750650,
        },
        "asymptotic_constant": {
            "score_CLT_variance": contrast_variance,
            "risk_limit": F(29200),
            "population_sequence": "P_epsilon with epsilon=n^(-2)",
        },
    }
    return payload


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, help="Write the complete deterministic JSON certificate here.")
    args = parser.parse_args()
    payload = verify()
    if args.output is not None:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(
            json.dumps(encode(payload), indent=2, sort_keys=True) + "\n",
            encoding="utf-8",
        )
    summary = {
        "status": payload["status"],
        "checks_passed": payload["checks_passed"],
        "minimum_interpolation_margin": payload["interpolation"]["minimum_margin"],
        "maximum_orbit_moment": 58000,
        "finite_sample_risk_lower_bound": payload["finite_sample_constants"]["risk_lower_bound"],
        "risk_limit": payload["asymptotic_constant"]["risk_limit"],
    }
    if args.output is not None:
        summary["certificate_written"] = str(args.output)
    print(json.dumps(encode(summary), sort_keys=True))


if __name__ == "__main__":
    main()

