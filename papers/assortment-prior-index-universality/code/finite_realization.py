"""Construct a rational mean/moment-matched Bellman comparison realization.

This is an exact-arithmetic scientific diagnostic, not formalization code.
"""
from __future__ import annotations

import argparse
import json
from pathlib import Path

import sympy as s


def canonical_alternating_basis(g):
    """Return T, q with T.T*g*T = J_q direct-sum zero, all rational.

    Symplectic Gram-Schmidt uses nonzero off-diagonal pivots; it needs no
    eigenvalue computation or square roots. A fraction-free implementation
    of the same elimination gives the polynomial bit-complexity result.
    """
    assert g == -g.T
    dimension = g.rows
    assert dimension == g.cols
    remaining = [s.eye(dimension)[:, i] for i in range(dimension)]
    paired = []
    while True:
        pivot = None
        for i in range(len(remaining)):
            for j in range(i + 1, len(remaining)):
                value = (remaining[i].T * g * remaining[j])[0]
                if value:
                    pivot = (i, j, value)
                    break
            if pivot is not None:
                break
        if pivot is None:
            break
        i, j, value = pivot
        e = remaining[i]
        f = remaining[j] / value
        paired.extend((e, f))
        next_remaining = []
        for k, vector in enumerate(remaining):
            if k not in (i, j):
                projected = (
                    vector
                    - (vector.T * g * f)[0] * e
                    + (vector.T * g * e)[0] * f
                )
                assert (projected.T * g * e)[0] == 0
                assert (projected.T * g * f)[0] == 0
                next_remaining.append(projected)
        remaining = next_remaining
    columns = paired + remaining
    transform = s.Matrix.hstack(*columns) if columns else s.zeros(0, 0)
    assert transform.rank() == dimension
    standard = s.zeros(dimension)
    for i in range(0, len(paired), 2):
        standard[i, i + 1] = 1
        standard[i + 1, i] = -1
    assert transform.T * g * transform == standard
    return transform, len(paired) // 2


def max_fraction_bits(values):
    result = 0
    for value in values:
        num, den = s.Rational(value).as_numer_denom()
        result = max(result, abs(int(num)).bit_length(), int(den).bit_length())
    return result


def rational_strings(matrix):
    return [[str(matrix[i, j]) for j in range(matrix.cols)]
            for i in range(matrix.rows)]


def construct(a, moment_order=1, eta=s.Rational(1, 4)):
    a = s.Matrix(a)
    assert a.rows == a.cols and a == -a.T
    assert all(value.is_Rational for value in a)
    assert moment_order >= 1
    assert eta.is_Rational and 0 < eta < 1
    transform_a, pair_count = canonical_alternating_basis(a)
    rank_a = 2 * pair_count
    support_size = rank_a + 2 * moment_order + 4
    # All high atoms use the fixed bounded interval [11,12].
    support = [s.Rational(0)] + [
        s.Rational(11) + s.Rational(j - 1, support_size - 2)
        for j in range(1, support_size)
    ]
    capped = [max(s.Rational(10), x) for x in support]
    kernel = s.Matrix(support_size, support_size,
        lambda i, j: (capped[i] - capped[j]) / (1 + capped[i] + capped[j]))
    assert kernel == -kernel.T
    assert kernel.rank() == support_size
    baseline_tail = [1 / ((support_size - 1) * x) for x in support[1:]]
    baseline = s.Matrix([1 - sum(baseline_tail)] + baseline_tail)
    assert min(baseline) > 0
    assert sum(baseline) == 1
    assert sum(x * p for x, p in zip(support, baseline)) == 1
    moment_rows = s.Matrix([
        [x ** power for x in support]
        for power in range(moment_order + 1)
    ])
    constraints = moment_rows.col_join((kernel * baseline).T)
    null_vectors = constraints.nullspace()
    null_basis = s.Matrix.hstack(*null_vectors)
    assert constraints * null_basis == s.zeros(constraints.rows, null_basis.cols)
    reduced = null_basis.T * kernel * null_basis
    transform_h, available_pairs = canonical_alternating_basis(reduced)
    assert available_pairs >= pair_count
    if rank_a:
        embedding = null_basis * transform_h[:, :rank_a]
        coefficient = transform_a.inv()[:rank_a, :]
        directions = embedding * coefficient
    else:
        directions = s.zeros(support_size, a.cols)
    assert constraints * directions == s.zeros(constraints.rows, a.cols)
    assert directions.T * kernel * directions == a
    relative_maximum = max(
        [abs(directions[i, j]) / baseline[i]
         for i in range(support_size) for j in range(a.cols)] + [s.Rational(0)]
    )
    epsilon = eta / (2 * (1 + relative_maximum))
    scale = epsilon ** 2
    probabilities = s.Matrix.hstack(*[
        baseline + epsilon * directions[:, j] for j in range(a.cols)
    ])
    assert min(probabilities) > 0
    for j in range(a.cols):
        assert sum(probabilities[:, j]) == 1
        assert moment_rows * probabilities[:, j] == moment_rows * baseline
        assert all(abs(probabilities[i, j] / baseline[i] - 1) < eta
                   for i in range(support_size))
        assert sum(abs(probabilities[i, j] - baseline[i]) for i in range(support_size)) / 2 < eta
    exact_comparisons = probabilities.T * kernel * probabilities
    assert exact_comparisons == scale * a
    # A finite-rational instance independently checks the rank lower bound.
    span_rank = probabilities.rank()
    assert span_rank <= support_size - moment_order
    assert exact_comparisons.rank() == rank_a
    assert support_size >= rank_a + moment_order
    # With mean one and high atoms >10, both-until-review domination follows
    # from the proof's explicit lower bound; record its exact prerequisites.
    for j in range(a.cols):
        assert sum(probabilities[i, j] for i in range(1, support_size)) < s.Rational(1, 10)
    return {
        "status": "all_exact_rational_assertions_passed",
        "formalization_performed": False,
        "moment_order": moment_order,
        "eta": str(eta),
        "input_comparison_matrix": rational_strings(a),
        "rank_input_matrix": rank_a,
        "support_size": support_size,
        "support_upper_bound_exact": "rank(A)+2r+4",
        "support_lower_bound_exact_matrix_only": "rank(A)+r",
        "support": [str(x) for x in support],
        "baseline_probabilities": [str(p) for p in baseline],
        "shared_moments_0_through_r": [str(v) for v in moment_rows * baseline],
        "epsilon": str(epsilon),
        "comparison_scale_lambda": str(scale),
        "probability_columns_one_per_prior": rational_strings(probabilities),
        "exact_comparison_matrix": rational_strings(exact_comparisons),
        "constraint_rank": constraints.rank(),
        "restricted_form_rank": 2 * available_pairs,
        "max_probability_numerator_or_denominator_bits": max_fraction_bits(probabilities),
        "lambda_numerator_or_denominator_bits": max_fraction_bits([scale]),
        "epoch_simultaneous_gap_lower_bound": "17/640",
        "first_action_simultaneous_gap_lower_bound": "17/960",
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input", type=Path,
                        help="JSON containing a square rational skew matrix as a list of lists")
    parser.add_argument("--moments", type=int, default=1)
    parser.add_argument("--eta", default="1/4")
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results" / "finite_realization_certificate.json")
    args = parser.parse_args()
    raw = json.loads(args.input.read_text()) if args.input else [
        [0, 1, -1], [-1, 0, 1], [1, -1, 0]
    ]
    matrix = [[s.Rational(value) for value in row] for row in raw]
    result = construct(matrix, moment_order=args.moments, eta=s.Rational(args.eta))
    args.output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({key: result[key] for key in (
        "status", "rank_input_matrix", "support_size", "moment_order",
        "constraint_rank", "restricted_form_rank",
        "max_probability_numerator_or_denominator_bits",
        "lambda_numerator_or_denominator_bits",
    )}, indent=2))


if __name__ == "__main__":
    main()
