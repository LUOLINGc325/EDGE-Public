"""Exact rational checks for a five-support local exploration cycle."""
from pathlib import Path
import json

import sympy as s


def strings(matrix):
    return [[str(matrix[i, j]) for j in range(matrix.cols)]
            for i in range(matrix.rows)]


def kernel(support):
    clipped = [max(s.Integer(10), x) for x in support]
    return s.Matrix(len(support), len(support),
                    lambda i, j: (clipped[i] - clipped[j]) /
                    (1 + clipped[i] + clipped[j]))


def bernoulli_columns(highs):
    result = s.zeros(len(highs) + 1, len(highs))
    for j, high in enumerate(highs):
        result[0, j] = 1 - 1 / high
        result[j + 1, j] = 1 / high
    return result


def policy_costs(support, p, q):
    """Compute all three epoch costs directly from geometric durations."""
    first_p = s.Rational(0)
    first_q = s.Rational(0)
    both = s.Rational(0)
    for i, x in enumerate(support):
        for j, y in enumerate(support):
            probability = p[i] * q[j]
            best_sum = sum(sorted((x, y, s.Integer(10), s.Integer(5)),
                                  reverse=True)[:2])
            clairvoyant_reward = best_sum / (1 + best_sum)
            known_after_p, known_after_q = max(10, x), max(10, y)
            first_single_epoch = 12 * clairvoyant_reward - 11
            after_p = ((2 + known_after_p) * clairvoyant_reward
                       - (1 + known_after_p))
            after_q = ((2 + known_after_q) * clairvoyant_reward
                       - (1 + known_after_q))
            first_both_epoch = s.Rational(3, 2) * clairvoyant_reward - 1
            first_p += probability * (first_single_epoch + after_p)
            first_q += probability * (first_single_epoch + after_q)
            both += probability * (first_both_epoch + (after_p + after_q) / 2)
    gap = first_q - first_p
    assert gap > 0
    assert both - first_p >= s.Rational(17, 640)
    assert both - first_q >= s.Rational(17, 640)
    value = min(first_p, first_q, both)
    both_first_action_gap = s.Rational(2, 3) * (both - value)
    assert both_first_action_gap >= s.Rational(17, 960)
    return {
        "epoch_regret_first_i": str(first_p),
        "epoch_regret_first_j": str(first_q),
        "epoch_regret_both": str(both),
        "epoch_comparison_j_minus_i": str(gap),
        "epoch_both_minus_i": str(both - first_p),
        "epoch_both_minus_j": str(both - first_q),
        "wrong_singleton_first_action_bellman_gap": str(gap / 12),
        "both_first_action_bellman_gap": str(both_first_action_gap),
    }


def main():
    # Verify the closed Bernoulli comparison by an independent kernel expansion.
    x, y = s.symbols("x y", positive=True)
    symbolic_support = [s.Integer(0), x, y]
    symbolic_clipped = [s.Integer(10), x, y]
    symbolic_kernel = s.Matrix(3, 3, lambda i, j:
        (symbolic_clipped[i] - symbolic_clipped[j]) /
        (1 + symbolic_clipped[i] + symbolic_clipped[j]))
    ex = s.Matrix([1 - 1 / x, 1 / x, 0])
    ey = s.Matrix([1 - 1 / y, 0, 1 / y])
    polynomial = ((x + y) * (x - 10) * (y - 10)
                  - 210 * (x + y + 1))
    formula = -(x - y) * polynomial / (
        x * y * (x + 11) * (y + 11) * (x + y + 1))
    assert s.factor((ex.T * symbolic_kernel * ey)[0] - formula) == 0

    highs = [s.Integer(11), s.Rational(34, 3),
             s.Rational(35, 3), s.Integer(12)]
    support = [s.Integer(0)] + highs
    k = kernel(support)
    elementary = bernoulli_columns(highs)
    b = elementary.T * k * elementary
    expected_b = s.Matrix([
        [0, -s.Rational(5479, 4823665), -s.Rational(4439, 2044658),
         -s.Rational(227, 72864)],
        [s.Rational(5479, 4823665), 0, -s.Rational(2245, 2168656),
         -s.Rational(22715, 11474286)],
        [s.Rational(4439, 2044658), s.Rational(2245, 2168656), 0,
         -s.Rational(4591, 4860912)],
        [s.Rational(227, 72864), s.Rational(22715, 11474286),
         s.Rational(4591, 4860912), 0],
    ])
    assert b == expected_b
    pfaffian = b[0, 1] * b[2, 3] - b[0, 2] * b[1, 3] + b[0, 3] * b[1, 2]
    assert pfaffian == s.Rational(576277, 11666681437487408640)
    assert b.det() == pfaffian ** 2 and b.rank() == 4

    # Verify the explicit rank-two index identity on the three-high subfamily.
    rank_two = b[:3, :3]
    t, bottom = 2, 0
    a = rank_two[:, bottom]
    d = rank_two[t, :].T + a
    assert rank_two.rank() == 2 and min(d) > 0
    assert a * d.T - d * a.T == rank_two[t, bottom] * rank_two

    # A uniform full-support mixture is a rational interior baseline.
    mixture_baseline = s.ones(4, 1) / 4
    constraints = s.ones(1, 4).col_join((b * mixture_baseline).T)
    null_vectors = constraints.nullspace()
    assert len(null_vectors) == 2
    u, v = null_vectors
    pairing = (u.T * b * v)[0]
    assert pairing != 0
    if pairing < 0:
        v = -v
        pairing = -pairing
    directions = s.Matrix.hstack(u, v, -u - v)
    assert constraints * directions == s.zeros(2, 3)
    target = s.Matrix([[0, 1, -1], [-1, 0, 1], [1, -1, 0]])
    assert directions.T * b * directions == pairing * target
    eta = s.Rational(1, 16)
    maximum_relative_direction = max(
        abs(directions[i, j]) / mixture_baseline[i]
        for i in range(4) for j in range(3))
    epsilon = eta / (2 * (1 + maximum_relative_direction))
    mixture_priors = s.Matrix.hstack(*[
        mixture_baseline + epsilon * directions[:, j] for j in range(3)])
    assert min(mixture_priors) > 0
    assert all(sum(mixture_priors[:, j]) == 1 for j in range(3))
    baseline = elementary * mixture_baseline
    priors = elementary * mixture_priors
    scale = epsilon ** 2 * pairing
    comparisons = priors.T * k * priors
    assert comparisons == scale * target and scale > 0
    assert min(priors) > 0
    for j in range(3):
        assert sum(priors[:, j]) == 1
        assert sum(support[i] * priors[i, j] for i in range(5)) == 1
        assert all(abs(priors[i, j] / baseline[i] - 1) < eta
                   for i in range(5))
    exact_max_relative_deviation = max(
        abs(priors[i, j] / baseline[i] - 1)
        for i in range(5) for j in range(3))
    pair_checks = {}
    for i, j in ((0, 1), (1, 2), (2, 0)):
        check = policy_costs(support, priors[:, i], priors[:, j])
        assert s.Rational(check["epoch_comparison_j_minus_i"]) == scale
        pair_checks[f"{i + 1}>{j + 1}"] = check

    result = {
        "status": "all_exact_rational_assertions_passed",
        "symbolic_B_identity": True,
        "support": [str(value) for value in support],
        "elementary_B_matrix": strings(b),
        "elementary_B_rank": 4,
        "elementary_B_pfaffian": str(pfaffian),
        "rank_two_subfamily_plucker_index_identity": True,
        "mixture_baseline": [str(value) for value in mixture_baseline],
        "mixture_directions": strings(directions),
        "mixture_perturbation_epsilon": str(epsilon),
        "mixture_priors_columns": strings(mixture_priors),
        "attraction_baseline": [str(value) for value in baseline],
        "attraction_priors_columns": strings(priors),
        "common_mean": "1",
        "relative_neighborhood_radius_eta": str(eta),
        "max_relative_deviation_from_attraction_baseline":
            str(exact_max_relative_deviation),
        "equal_positive_comparison_gap_lambda": str(scale),
        "exact_comparison_matrix": strings(comparisons),
        "cyclic_policy_checks": pair_checks,
    }
    destination = Path(__file__).resolve().parents[1] / "results" / "indexability_certificate.json"
    destination.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({
        "status": result["status"],
        "support_size": len(support),
        "elementary_B_rank": b.rank(),
        "pfaffian": str(pfaffian),
        "cycle_has_equal_positive_gaps": True,
        "relative_neighborhood_radius": str(eta),
        "output": str(destination),
    }, indent=2))


if __name__ == "__main__":
    main()
