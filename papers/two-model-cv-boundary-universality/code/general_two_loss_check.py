#!/usr/bin/env python3
"""Exact finite checks for the two-loss CV identities and Gaussian constants.

Run:
    python general_two_loss_check.py --output general_two_loss_check.json

The finite checks use Fraction arithmetic and enumerate every ordered sample.
They check identities, not the asymptotic theorem or its novelty.  The contrast
has three values, is asymmetric, and the common loss is random conditional on
the contrast and correlated with it.  Numerical integration is explicitly
separate from the exact rational computations.  No simulation is used.
"""

from __future__ import annotations

import argparse
from collections import defaultdict
from fractions import Fraction as F
from functools import lru_cache
from itertools import combinations, product
import json
import math
import platform
from pathlib import Path
import sys


# Each observation is (A, X), with losses L0=A+X/2 and L1=A-X/2.
# Two different A values are possible conditional on X=-2 and on X=1.
STATES = ((2, -2), (4, -2), (1, 0), (2, 1), (3, 1))
LAWS = (
    ("zero_margin", (1, 1, 2, 3, 1)),
    ("positive_margin", (1, 1, 2, 4, 2)),
    ("negative_margin", (2, 1, 2, 2, 1)),
)
DESIGNS = ((2, 1), (3, 1), (4, 1), (4, 2), (6, 1), (6, 2), (6, 3))


def q(x: int | F) -> int:
    """The manuscript convention: equality chooses L0, hence sign(0)=-1."""
    return 1 if x > 0 else -1


def fjson(x: F) -> dict[str, str | float]:
    return {"exact": str(x), "decimal": float(x)}


def d(t: int, u: int, m: int) -> F:
    if t > 0:
        return F(u, m) if u >= t else F(0)
    return F(-u, m) if u < t else F(0)


@lru_cache(None)
def subsets(n: int, m: int) -> tuple[tuple[int, ...], ...]:
    return tuple(combinations(range(n), m))


@lru_cache(None)
def balanced_partitions(indices: tuple[int, ...], m: int):
    """All unordered balanced partitions, each exactly once."""
    if not indices:
        return ((),)
    first, rest = indices[0], indices[1:]
    ans = []
    for chosen in combinations(rest, m - 1):
        block = (first,) + chosen
        chosen_set = set(block)
        remaining = tuple(i for i in indices if i not in chosen_set)
        for tail in balanced_partitions(remaining, m):
            ans.append((block,) + tail)
    return tuple(ans)


@lru_cache(None)
def conditional_partition_statistics(sorted_xs: tuple[int, ...], m: int):
    """Exact permutation statistics, independently using partitions/subsets.

    Abar is constant over partitions, so only the X-dependent offset is needed.
    Unordered partitions can be used for the symmetric CV statistic.  Ordered
    pairs of disjoint subsets are used for the labeled-fold covariance.
    """
    n, t = len(sorted_xs), sum(sorted_xs)
    k = n // m
    offsets = []
    for partition in balanced_partitions(tuple(range(n)), m):
        block_sums = [sum(sorted_xs[i] for i in block) for block in partition]
        offsets.append(F(-sum(u * q(t - u) for u in block_sums), 2 * n))
    offset_mean = sum(offsets, F(0)) / len(offsets)
    variance = sum((b - offset_mean) ** 2 for b in offsets) / len(offsets)

    ds = []
    pair_products = []
    subset_sign_sum = 0
    for first in subsets(n, m):
        first_set = set(first)
        u = sum(sorted_xs[i] for i in first)
        du = d(t, u, m)
        ds.append(du)
        subset_sign_sum += u * q(t - u)
        remainder = tuple(i for i in range(n) if i not in first_set)
        for second in combinations(remainder, m):
            v = sum(sorted_xs[i] for i in second)
            pair_products.append(du * d(t, v, m))
    mean_d = sum(ds, F(0)) / len(ds)
    mean_d2 = sum(v * v for v in ds) / len(ds)
    mean_pair = sum(pair_products, F(0)) / len(pair_products)
    pair_covariance = mean_pair - mean_d**2
    subset_offset = F(-subset_sign_sum, 2 * m * len(ds))
    variance_from_covariance = (
        (mean_d2 - mean_d**2) / k + F(k - 1, k) * pair_covariance
    )
    assert offset_mean == subset_offset
    assert variance == variance_from_covariance
    assert pair_covariance <= 0
    assert variance <= mean_d2 / k
    return {
        "offset_mean": offset_mean,
        "variance": variance,
        "pair_covariance": pair_covariance,
        "variance_bound_slack": mean_d2 / k - variance,
        "mean_d": mean_d,
        "partitions": len(offsets),
    }


def integer_sum_masses(weights: tuple[int, ...], length: int) -> dict[int, int]:
    """Unnormalized convolution: sum(masses) = sum(weights)**length."""
    atom_masses = defaultdict(int)
    for (_, x), weight in zip(STATES, weights):
        atom_masses[x] += weight
    result = {0: 1}
    for _ in range(length):
        next_result = defaultdict(int)
        for old_sum, old_mass in result.items():
            for x, mass in atom_masses.items():
                next_result[old_sum + x] += old_mass * mass
        result = dict(next_result)
    return result


def law_moments(weights: tuple[int, ...]):
    denominator = sum(weights)
    a = sum(F(w * aa, denominator) for (aa, _), w in zip(STATES, weights))
    mu = sum(F(w * x, denominator) for (_, x), w in zip(STATES, weights))
    va = sum(F(w, denominator) * (aa - a) ** 2 for (aa, _), w in zip(STATES, weights))
    vx = sum(F(w, denominator) * (x - mu) ** 2 for (_, x), w in zip(STATES, weights))
    gamma = sum(
        F(w, denominator) * (aa - a) * (x - mu)
        for (aa, x), w in zip(STATES, weights)
    )
    return a, mu, va, vx, gamma


def check_design(name: str, weights: tuple[int, ...], n: int, m: int):
    denominator = sum(weights)
    k = n // m
    a, mu, va, vx, gamma = law_moments(weights)
    names = (
        "Z0_mean", "Z0_square", "G_square", "Z0_G", "MSE_single",
        "MSE_complete", "partition_variance", "partition_residual_square",
        "partition_residual_cross", "D_mean", "D_square",
    )
    accumulated = {key: F(0) for key in names}
    all_mass = 0
    full_ties = fold_ties = 0
    min_pair_covariance = F(0)
    max_pair_covariance = None
    min_bound_slack = None
    pointwise_checks = 0

    for word in product(range(len(STATES)), repeat=n):
        sample = [STATES[i] for i in word]
        weight = math.prod(weights[i] for i in word)
        all_mass += weight
        asum = sum(aa for aa, _ in sample)
        xs = tuple(x for _, x in sample)
        t = sum(xs)
        us = [sum(xs[j * m:(j + 1) * m]) for j in range(k)]
        qs = [q(t - u) for u in us]
        qt = q(t)
        cv = F(asum, n) - F(sum(u * sign for u, sign in zip(us, qs)), 2 * n)
        fullrisk = a - mu * qt / 2
        error = cv - fullrisk
        z0 = F(asum, n) - a - sum(
            (u - m * mu) * sign for u, sign in zip(us, qs)
        ) / (2 * n)
        g = mu * (qt - F(sum(qs), k)) / 2
        crossing = sum((d(t, u, m) for u in us), F(0)) / k
        baseline = F(asum, n) - a - qt * (F(t, n) - mu) / 2

        # Direct selected-loss evaluation is independent of the compact CV formula.
        loss_sum_times_two = 0
        for j, sign in enumerate(qs):
            for aa, x in sample[j * m:(j + 1) * m]:
                loss_sum_times_two += 2 * aa - sign * x
        cv_direct = F(loss_sum_times_two, 2 * n)
        selected_loss_expectation = sum(
            F(w, denominator) * F(2 * aa - qt * x, 2)
            for (aa, x), w in zip(STATES, weights)
        )
        assert cv == cv_direct
        assert fullrisk == selected_loss_expectation
        assert error == z0 + g
        assert error == baseline + crossing
        assert crossing >= 0
        pointwise_checks += 5

        stats = conditional_partition_statistics(tuple(sorted(xs)), m)
        complete = F(asum, n) + stats["offset_mean"]
        residual = cv - complete
        min_pair_covariance = min(min_pair_covariance, stats["pair_covariance"])
        max_pair_covariance = stats["pair_covariance"] if max_pair_covariance is None else max(
            max_pair_covariance, stats["pair_covariance"]
        )
        min_bound_slack = stats["variance_bound_slack"] if min_bound_slack is None else min(
            min_bound_slack, stats["variance_bound_slack"]
        )
        assert complete - (a - mu * qt / 2) == baseline + stats["mean_d"]
        pointwise_checks += 1
        values = (
            z0, z0**2, g**2, z0 * g, error**2,
            (complete - fullrisk)**2, stats["variance"], residual**2,
            residual * (complete - fullrisk), crossing, crossing**2,
        )
        for key, value in zip(names, values):
            accumulated[key] += weight * value
        full_ties += weight * (t == 0)
        fold_ties += weight * sum(sign_sum == 0 for sign_sum in (t - u for u in us))

    assert all_mass == denominator**n
    moments = {key: value / all_mass for key, value in accumulated.items()}
    training_mass = integer_sum_masses(weights, n - m)
    expected_training_sign = F(
        sum(mass * q(value) for value, mass in training_mass.items()),
        denominator**(n - m),
    )
    block_mass = integer_sum_masses(weights, m)
    remainder_mass = integer_sum_masses(weights, n - 2 * m)
    score_square = F(0)
    for w, mass_w in remainder_mass.items():
        score = sum(
            F(mass_u, denominator**m) * (u - m * mu) * q(w + u)
            for u, mass_u in block_mass.items()
        )
        score_square += F(mass_w, denominator**(n - 2 * m)) * score**2
    diagonal = (va + vx / 4 - gamma * expected_training_sign) / n
    off_diagonal = F(k - 1, 4 * k * m * m) * score_square
    covariance_rhs = diagonal + off_diagonal
    identity_residuals = {
        "centered_Z0_mean": moments["Z0_mean"],
        "exact_common_loss_covariance": moments["Z0_square"] - covariance_rhs,
        "fullrisk_Z0_plus_G_MSE": moments["MSE_single"] - moments["Z0_square"]
            - 2 * moments["Z0_G"] - moments["G_square"],
        "single_complete_variance": moments["MSE_single"] - moments["MSE_complete"]
            - moments["partition_variance"],
        "residual_equals_conditional_variance": moments["partition_residual_square"]
            - moments["partition_variance"],
        "partition_mean_orthogonality": moments["partition_residual_cross"],
    }
    assert all(value == 0 for value in identity_residuals.values())
    assert diagonal >= 0
    assert max_pair_covariance <= 0
    assert min_bound_slack >= 0

    # Independent conditional formula for the average of two iid partitions.
    mse_r2 = moments["MSE_complete"] + moments["partition_variance"] / 2
    return {
        "law": name, "n": n, "m": m, "k": k,
        "ordered_samples_enumerated": len(STATES)**n,
        "pointwise_assertions": pointwise_checks,
        "balanced_partitions_per_sample": len(balanced_partitions(tuple(range(n)), m)),
        "identity_residuals_exact": {key: str(value) for key, value in identity_residuals.items()},
        "centered_covariance_diagonal": fjson(diagonal),
        "centered_covariance_off_diagonal": fjson(off_diagonal),
        "centered_covariance_LHS": fjson(moments["Z0_square"]),
        "MSE_single": fjson(moments["MSE_single"]),
        "MSE_complete": fjson(moments["MSE_complete"]),
        "MSE_two_independent_repeats_conditional_formula": fjson(mse_r2),
        "mean_partition_variance": fjson(moments["partition_variance"]),
        "full_target_drift_square": fjson(moments["G_square"]),
        "full_target_drift_cross": fjson(moments["Z0_G"]),
        "common_loss_covariance_term": fjson(-gamma * expected_training_sign / n),
        "full_sample_tie_probability": fjson(F(full_ties, all_mass)),
        "expected_number_of_training_ties": fjson(F(fold_ties, all_mass)),
        "conditional_pair_covariance_minimum": fjson(min_pair_covariance),
        "conditional_pair_covariance_maximum": fjson(max_pair_covariance),
        "conditional_variance_bound_minimum_slack": fjson(min_bound_slack),
    }


def gaussian_constants():
    import scipy
    from scipy.integrate import quad

    def phi(z):
        return math.exp(-z * z / 2) / math.sqrt(2 * math.pi)

    anchor, anchor_err = quad(lambda z: phi(z)**2, -math.inf, math.inf,
                              epsabs=1e-13, epsrel=1e-13)
    score, score_err = quad(lambda z: (2 * phi(z))**2, -math.inf, math.inf,
                            epsabs=1e-13, epsrel=1e-13)
    anchor_exact = 1 / (2 * math.sqrt(math.pi))
    score_exact = 2 / math.sqrt(math.pi)
    coefficient = 1 / (2 * math.pi * math.sqrt(2))
    from_anchor = anchor / math.sqrt(2 * math.pi)
    from_score = score / (4 * math.sqrt(2 * math.pi))
    _, _, _, sigma0_squared, _ = law_moments(LAWS[0][1])

    profile_checks = []
    for z in (-3.0, -1.0, 0.0, 0.5, 2.0):
        # b_z(G) equals G 1{G>=z} for z>0, and -G 1{G<z} otherwise.
        if z > 0:
            anchor_profile, _ = quad(lambda g: g * phi(g), z, math.inf,
                                      epsabs=1e-13, epsrel=1e-13)
        else:
            anchor_profile, _ = quad(lambda g: -g * phi(g), -math.inf, z,
                                      epsabs=1e-13, epsrel=1e-13)
        below, _ = quad(lambda g: -g * phi(g), -math.inf, -z,
                         epsabs=1e-13, epsrel=1e-13)
        above, _ = quad(lambda g: g * phi(g), -z, math.inf,
                         epsabs=1e-13, epsrel=1e-13)
        score_profile = below + above
        assert abs(anchor_profile - phi(z)) < 1e-12
        assert abs(score_profile - 2 * phi(z)) < 1e-12
        profile_checks.append({
            "z": z,
            "integral_E_b_z_G": anchor_profile,
            "phi_z": phi(z),
            "integral_E_G_sign_G_plus_z": score_profile,
            "two_phi_z": 2 * phi(z),
        })
    assert abs(anchor - anchor_exact) < 1e-12
    assert abs(score - score_exact) < 1e-12
    assert abs(from_anchor - coefficient) < 1e-12
    assert abs(from_score - coefficient) < 1e-12
    return {
        "scipy_version": scipy.__version__,
        "anchor_integral_phi_squared": {
            "numerical": anchor, "closed_form": "1/(2*sqrt(pi))",
            "closed_form_value": anchor_exact, "absolute_difference": abs(anchor - anchor_exact),
            "quadrature_error_estimate": anchor_err,
        },
        "centered_score_integral_two_phi_squared": {
            "numerical": score, "closed_form": "2/sqrt(pi)",
            "closed_form_value": score_exact, "absolute_difference": abs(score - score_exact),
            "quadrature_error_estimate": score_err,
        },
        "universal_singular_coefficient_per_unit_variance": {
            "from_anchor_integral": from_anchor,
            "from_centered_score_integral": from_score,
            "closed_form": "1/(2*pi*sqrt(2))", "closed_form_value": coefficient,
        },
        "zero_margin_example_sigma0_squared": fjson(sigma0_squared),
        "zero_margin_example_singular_coefficient": float(sigma0_squared) * coefficient,
        "truncated_Gaussian_profile_checks": profile_checks,
        "status": "PASS",
        "qualification": "Floating-point quadrature is a consistency check, not a certified enclosure.",
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=None)
    args = parser.parse_args()
    laws = []
    for name, weights in LAWS:
        a, mu, va, vx, gamma = law_moments(weights)
        assert gamma != 0
        laws.append({
            "name": name, "weights": list(weights), "probability_denominator": sum(weights),
            "A_mean": fjson(a), "X_mean": fjson(mu),
            "A_variance": fjson(va), "X_variance": fjson(vx),
            "A_X_covariance": fjson(gamma),
        })
    cases = [check_design(name, weights, n, m)
             for name, weights in LAWS for n, m in DESIGNS]
    result = {
        "status": "PASS",
        "scope": "Exact finite identities and numerical Gaussian constants; no asymptotic theorem or novelty certification.",
        "python_version": platform.python_version(),
        "arithmetic": "fractions.Fraction for every finite-sample assertion",
        "tie_convention": "q(t)=+1 for t>0 and -1 otherwise; choose L0 at empirical equality",
        "states_A_X": [list(state) for state in STATES],
        "loss_definition": "L0=A+X/2; L1=A-X/2",
        "random_A_given_X": True,
        "contrast_is_not_Bernoulli": True,
        "laws": laws,
        "number_of_design_law_cases": len(cases),
        "total_ordered_samples_enumerated": sum(case["ordered_samples_enumerated"] for case in cases),
        "total_pointwise_assertions": sum(case["pointwise_assertions"] for case in cases),
        "all_six_expectation_identity_residuals_zero_in_all_cases": True,
        "all_conditional_disjoint_fold_covariances_nonpositive": True,
        "all_conditional_variance_bounds_hold": True,
        "cases": cases,
        "gaussian_constant_checks": gaussian_constants(),
        "limitations": [
            "Finite cases n in {2,3,4,6} do not prove local limits or uniform asymptotic remainder bounds.",
            "The numerical integration has floating-point, not interval-certified, error estimates.",
            "No data-dependent partition rule is tested or claimed to satisfy the theorem.",
            "The R=2 risk field uses the verified conditional variance identity, not independent enumeration of two partition draws.",
        ],
    }
    payload = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.output is not None:
        args.output.write_text(payload, encoding="utf-8")
    sys.stdout.write(payload)


if __name__ == "__main__":
    main()
