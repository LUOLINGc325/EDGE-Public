#!/usr/bin/env python3
"""Independent finite rational checks for majority cross-validation.

Only the Python standard library is used. The reference computations enumerate
actual label vectors and evaluate majority prediction and held-out mistakes
directly. They do not generate the reference values from the hypergeometric
conditional-mean formula that is being checked.

Default reproduction:
    python code/exact_checks.py

This is a finite computational check, not a proof of the all-n statements or
their asymptotics. No Lean/formal-verification claim is made.
"""

from __future__ import annotations

import argparse
from collections import Counter
from fractions import Fraction
from hashlib import sha256
from itertools import combinations
import json
from math import comb
from pathlib import Path
import sys


PROBABILITIES = (Fraction(1, 3), Fraction(1, 2), Fraction(2, 3))
TIES = (-1, 1)
MIXTURE_WEIGHTS = (Fraction(1, 3), Fraction(2, 3))


class Checks:
    def __init__(self) -> None:
        self.counts: Counter[str] = Counter()
        self.operations: Counter[str] = Counter()

    def require(self, condition: bool, category: str, context: object) -> None:
        self.counts[category] += 1
        if not condition:
            raise AssertionError({"category": category, "context": context})


def binom(n: int, r: int) -> int:
    return comb(n, r) if 0 <= r <= n else 0


def sign(s: int, tie: int) -> int:
    return 1 if s > 0 else -1 if s < 0 else tie


def rational(value: Fraction) -> str:
    return f"{value.numerator}/{value.denominator}"


def sign_sum_mass(n: int, s: int) -> Fraction:
    if (n + s) % 2:
        return Fraction(0)
    return Fraction(binom(n, (n + s) // 2), 2**n)


def hypergeom_mass(n: int, m: int, total_plus: int, fold_plus: int) -> Fraction:
    return Fraction(
        binom(total_plus, fold_plus)
        * binom(n - total_plus, m - fold_plus),
        comb(n, m),
    )


def negative_tie_profile(n: int, m: int, s: int) -> Fraction:
    """Formula under test, evaluated separately from the enumerated data."""
    total_plus = (n + s) // 2
    complement_size = n - m
    epsilon = complement_size % 2
    boundary = (m + s + epsilon) // 2
    masses = [hypergeom_mass(n, m, total_plus, j) for j in range(m + 1)]
    if s > 0:
        tail = sum((masses[j] for j in range(m + 1) if j >= boundary), Fraction(0))
    else:
        tail = sum((masses[j] for j in range(m + 1) if j < boundary), Fraction(0))
    boundary_mass = hypergeom_mass(n, m, total_plus, boundary)
    return (
        Fraction(abs(s), n) * tail
        + Fraction(
            (m + s + epsilon) * (complement_size + epsilon), 2 * m * n
        )
        * boundary_mass
    )


def formula_profile(n: int, m: int, s: int, tie: int) -> Fraction:
    return negative_tie_profile(n, m, s if tie == -1 else -s)


def indices_mask(indices: tuple[int, ...]) -> int:
    return sum(1 << i for i in indices)


def canonical_partitions(indices: tuple[int, ...], m: int):
    """Enumerate every unordered balanced partition exactly once."""
    if not indices:
        yield ()
        return
    first = indices[0]
    for other in combinations(indices[1:], m - 1):
        fold = (first,) + other
        fold_set = set(fold)
        rest = tuple(i for i in indices if i not in fold_set)
        for suffix in canonical_partitions(rest, m):
            yield (indices_mask(fold),) + suffix


def direct_fold_mistakes(
    labels: int, total_plus: int, fold: int, m: int, n: int, tie: int
) -> int:
    """Fit majority on the complement, then count actual test-label errors."""
    fold_plus = (labels & fold).bit_count()
    training_plus = total_plus - fold_plus
    prediction = sign(2 * training_plus - (n - m), tie)
    return m - fold_plus if prediction == 1 else fold_plus


def direct_partition_counts(
    labels: int,
    total_plus: int,
    folds: tuple[int, ...],
    m: int,
    n: int,
    tie: int,
) -> tuple[int, tuple[int, ...]]:
    mistakes = 0
    local_excesses: list[int] = []
    s = 2 * total_plus - n
    full_prediction = sign(s, tie)
    for fold in folds:
        fold_plus = (labels & fold).bit_count()
        v = 2 * fold_plus - m
        training_prediction = sign(s - v, tie)
        mistakes += m - fold_plus if training_prediction == 1 else fold_plus
        local_excesses.append(v * (full_prediction - training_prediction) // 2)
    return mistakes, tuple(local_excesses)


def new_group(m: int) -> dict:
    return {
        "count": 0,
        "fold_plus_histogram": [0] * (m + 1),
        "sum_d": 0,
        "sum_d_squared": 0,
        "sum_d0": 0,
        "sum_d1": 0,
        "sum_d0_squared": 0,
        "sum_d0_d1": 0,
        "estimators": {
            key: {"sum": 0, "sum_squared": 0}
            for key in ("fixed", "shifted", "mixture", "complete", "empirical")
        },
    }


def risk_from_groups(
    groups: list[dict], n: int, denominator: int, key: str, p: Fraction, tie: int
) -> Fraction:
    answer = Fraction(0)
    for total_plus, group in enumerate(groups):
        probability_per_vector = p**total_plus * (1 - p) ** (n - total_plus)
        prediction = sign(2 * total_plus - n, tie)
        true_risk = 1 - p if prediction == 1 else p
        values = group["estimators"][key]
        answer += probability_per_vector * (
            Fraction(values["sum_squared"], denominator**2)
            - 2 * true_risk * Fraction(values["sum"], denominator)
            + group["count"] * true_risk**2
        )
    return answer


def loo_formula(n: int, p: Fraction, tie: int) -> Fraction:
    """Independent exact odd/even LOO identity, including the tie convention."""
    if tie == 1:
        p = 1 - p
    baseline = p * (1 - p) / n
    if n % 2:
        critical_plus = (n + 1) // 2
        q = Fraction(critical_plus, n)
        coefficient = q * (2 * p - q)
    else:
        critical_plus = n // 2
        coefficient = Fraction(3, 4) - p
    critical_mass = (
        comb(n, critical_plus) * p**critical_plus * (1 - p) ** (n - critical_plus)
    )
    return baseline + coefficient * critical_mass


def run_case(n: int, m: int, explicit_max_n: int, checks: Checks) -> dict:
    k = n // m
    fixed = tuple(indices_mask(tuple(range(j * m, (j + 1) * m))) for j in range(k))
    shifted = tuple(
        indices_mask(tuple((i + 1) % n for i in range(j * m, (j + 1) * m)))
        for j in range(k)
    )
    subsets = tuple(indices_mask(indices) for indices in combinations(range(n), m))
    all_partitions = tuple(canonical_partitions(tuple(range(n)), m)) if n <= explicit_max_n else ()
    complete_denominator = m * len(subsets)
    denominators = {
        "fixed": n,
        "shifted": n,
        "mixture": 3 * n,
        "complete": complete_denominator,
        "empirical": n,
    }
    groups_by_tie = {tie: [new_group(m) for _ in range(n + 1)] for tie in TIES}
    profiles = {
        tie: [formula_profile(n, m, 2 * total_plus - n, tie) for total_plus in range(n + 1)]
        for tie in TIES
    }
    checks.operations["parameter_pairs"] += 1
    checks.operations["balanced_partitions_explicitly_enumerated"] += len(all_partitions)

    for labels in range(1 << n):
        total_plus = labels.bit_count()
        s = 2 * total_plus - n
        checks.operations["label_vectors_by_parameter_pair"] += 1
        for tie in TIES:
            context = {"n": n, "m": m, "tie": tie, "labels": labels}
            group = groups_by_tie[tie][total_plus]
            group["count"] += 1
            group["fold_plus_histogram"][(labels & fixed[0]).bit_count()] += 1
            full_prediction = sign(s, tie)
            empirical_count = n - total_plus if full_prediction == 1 else total_plus
            fixed_count, local_d = direct_partition_counts(labels, total_plus, fixed, m, n, tie)
            shifted_count, shifted_d = direct_partition_counts(labels, total_plus, shifted, m, n, tie)
            d_total = sum(local_d)
            complete_count = sum(
                direct_fold_mistakes(labels, total_plus, fold, m, n, tie)
                for fold in subsets
            )
            checks.operations["held_out_subset_predictions"] += len(subsets)
            complete_cv = Fraction(complete_count, complete_denominator)
            direct_complete_excess = complete_cv - Fraction(empirical_count, n)
            checks.require(all(d >= 0 for d in local_d), "nonnegative_local_excess", context)
            checks.require(
                fixed_count - empirical_count == d_total,
                "direct_cv_empirical_excess_identity", context,
            )
            checks.require(
                shifted_count - empirical_count == sum(shifted_d),
                "shifted_cv_empirical_excess_identity", context,
            )
            checks.require(
                direct_complete_excess == profiles[tie][total_plus],
                "direct_complete_vs_hypergeometric_formula", context,
            )
            for p in PROBABILITIES:
                mu = 2 * p - 1
                true_risk = 1 - p if full_prediction == 1 else p
                baseline_error = -full_prediction * (Fraction(s, n) - mu) / 2
                checks.require(
                    Fraction(fixed_count, n) - true_risk
                    == baseline_error + Fraction(d_total, n),
                    "B_plus_D_fixed_each_sample_probability", (context, rational(p)),
                )
                checks.require(
                    Fraction(shifted_count, n) - true_risk
                    == baseline_error + Fraction(sum(shifted_d), n),
                    "B_plus_D_shifted_each_sample_probability", (context, rational(p)),
                )

            if all_partitions:
                all_partition_count = sum(
                    sum(
                        direct_fold_mistakes(labels, total_plus, fold, m, n, tie)
                        for fold in partition
                    )
                    for partition in all_partitions
                )
                checks.operations["explicit_partition_predictions"] += len(all_partitions) * k
                checks.require(
                    Fraction(all_partition_count, n * len(all_partitions)) == complete_cv,
                    "all_balanced_partitions_vs_all_held_out_subsets", context,
                )

            group["sum_d"] += d_total
            group["sum_d_squared"] += d_total**2
            group["sum_d0"] += local_d[0]
            group["sum_d1"] += local_d[1]
            group["sum_d0_squared"] += local_d[0] ** 2
            group["sum_d0_d1"] += local_d[0] * local_d[1]
            counts = {
                "fixed": fixed_count,
                "shifted": shifted_count,
                "mixture": fixed_count + 2 * shifted_count,
                "complete": complete_count,
                "empirical": empirical_count,
            }
            for key, value in counts.items():
                group["estimators"][key]["sum"] += value
                group["estimators"][key]["sum_squared"] += value**2

    conditional_rows = []
    risk_rows = []
    risk_lookup = {}
    for tie in TIES:
        groups = groups_by_tie[tie]
        for total_plus, group in enumerate(groups):
            s = 2 * total_plus - n
            count = group["count"]
            context = {"n": n, "m": m, "tie": tie, "S": s}
            checks.require(count == comb(n, total_plus), "conditional_sample_count", context)
            for fold_plus, observed in enumerate(group["fold_plus_histogram"]):
                checks.require(
                    Fraction(observed, count) == hypergeom_mass(n, m, total_plus, fold_plus),
                    "direct_fold_histogram_vs_hypergeometric_law", (context, fold_plus),
                )
            direct_conditional_excess = Fraction(group["sum_d"], n * count)
            checks.require(
                direct_conditional_excess == profiles[tie][total_plus],
                "conditional_fixed_mean_vs_formula", context,
            )
            covariance = (
                Fraction(group["sum_d0_d1"], count)
                - Fraction(group["sum_d0"], count) * Fraction(group["sum_d1"], count)
            )
            checks.require(covariance <= 0, "conditional_two_fold_covariance_nonpositive", context)
            conditional_variance = (
                Fraction(group["sum_d_squared"], n * n * count)
                - direct_conditional_excess**2
            )
            variance_bound = Fraction(group["sum_d0_squared"], count * k * m * m)
            checks.require(
                0 <= conditional_variance <= variance_bound,
                "conditional_partition_variance_bound", context,
            )
            if tie == -1:
                epsilon = (n - m) % 2
                boundary = (m + s + epsilon) // 2
                ratio_mass = (
                    sign_sum_mass(m, s + epsilon)
                    * sign_sum_mass(n - m, -epsilon)
                    / sign_sum_mass(n, s)
                )
                checks.require(
                    hypergeom_mass(n, m, total_plus, boundary) == ratio_mass,
                    "boundary_hypergeometric_binomial_ratio", context,
                )
            conditional_rows.append({
                "tie": tie,
                "S": s,
                "conditional_sample_count": count,
                "complete_excess": rational(direct_conditional_excess),
                "two_fold_covariance": rational(covariance),
                "partition_variance": rational(conditional_variance),
                "partition_variance_bound": rational(variance_bound),
            })

        for p in PROBABILITIES:
            context = {"n": n, "m": m, "tie": tie, "p": rational(p)}
            risks = {
                key: risk_from_groups(groups, n, denominator, key, p, tie)
                for key, denominator in denominators.items()
            }
            checks.operations["risk_instances"] += 1
            checks.require(risks["fixed"] == risks["shifted"], "partition_exchangeability_risk", context)
            checks.require(
                risks["complete"] <= risks["mixture"] <= risks["fixed"],
                "complete_mixture_fixed_risk_sandwich", context,
            )
            mu = 2 * p - 1
            checks.require(
                risks["empirical"] == (1 - mu * mu) / (4 * n),
                "exact_empirical_risk_identity", context,
            )
            integrated_variance_bound = sum(
                (
                    p**total_plus
                    * (1 - p) ** (n - total_plus)
                    * Fraction(group["sum_d0_squared"], k * m * m)
                    for total_plus, group in enumerate(groups)
                ), Fraction(0),
            )
            checks.require(
                risks["fixed"] - risks["complete"] <= integrated_variance_bound,
                "integrated_partition_variance_bound", context,
            )
            if m == 1:
                checks.require(risks["fixed"] == loo_formula(n, p, tie), "odd_even_loo_identity", context)
            risk_lookup[(tie, p)] = risks
            risk_rows.append({
                "tie": tie,
                "p": rational(p),
                "mu": rational(mu),
                "mse": {key: rational(value) for key, value in risks.items()},
                "fixed_minus_complete": rational(risks["fixed"] - risks["complete"]),
                "variance_bound": rational(integrated_variance_bound),
            })
    for p in PROBABILITIES:
        checks.require(
            risk_lookup[(-1, p)] == risk_lookup[(1, 1 - p)],
            "label_reflection_and_tie_swap_risk", {"n": n, "m": m, "p": rational(p)},
        )
    return {
        "n": n,
        "m": m,
        "k": k,
        "training_parity": "even" if (n - m) % 2 == 0 else "odd",
        "label_vectors": 1 << n,
        "held_out_subsets": len(subsets),
        "all_balanced_partitions_enumerated": len(all_partitions),
        "fixed_partition_masks": list(fixed),
        "shifted_partition_masks": list(shifted),
        "conditional_checks": conditional_rows,
        "risks": risk_rows,
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--max-n", type=int, default=12)
    parser.add_argument("--explicit-partitions-max-n", type=int, default=8)
    parser.add_argument(
        "--output", type=Path,
        default=Path(__file__).resolve().parents[1] / "results" / "exact_checks.json",
    )
    args = parser.parse_args()
    if args.max_n < 2 or args.explicit_partitions_max_n < 0:
        parser.error("max-n must be at least 2; explicit-partitions-max-n must be nonnegative")
    checks = Checks()
    result = {
        "schema_version": 1,
        "status": "running",
        "scope": {
            "n_min": 2,
            "n_max": args.max_n,
            "m": "every positive proper divisor of n (k=n/m >= 2)",
            "ties": list(TIES),
            "probabilities": [rational(p) for p in PROBABILITIES],
            "mixture_weights": [rational(w) for w in MIXTURE_WEIGHTS],
            "all_label_vectors": True,
            "all_held_out_subsets": True,
            "all_unordered_balanced_partitions_when_n_at_most": args.explicit_partitions_max_n,
            "arithmetic": "exact integers and fractions.Fraction only",
        },
        "limitations": [
            "Finite checks do not prove the universal mathematical statements.",
            "Finite checks do not prove asymptotic constants, uniformity, or limit laws.",
            "The two-partition convex mixture is one finite example, not enumeration of all weights.",
            "The all-partition definition is explicitly enumerated only through the stated smaller n cutoff.",
            "No Lean code, compilation, or machine-checked formal proof is supplied.",
        ],
        "independence_of_reference": (
            "Reference CV values fit majority on each actual training complement and count actual "
            "held-out mistakes for every binary label vector. Complete CV enumerates held-out "
            "subsets directly. Hypergeometric expressions are evaluated only as formulas under test."
        ),
        "script_sha256": sha256(Path(__file__).read_bytes()).hexdigest(),
        "python_version": sys.version.split()[0],
        "cases": [],
    }
    try:
        for n in range(2, args.max_n + 1):
            for m in range(1, n // 2 + 1):
                if n % m == 0:
                    result["cases"].append(run_case(n, m, args.explicit_partitions_max_n, checks))
        result["status"] = "passed"
    except AssertionError as error:
        result["status"] = "failed"
        result["failure"] = str(error)
        raise
    finally:
        result["summary"] = {
            "operations": dict(sorted(checks.operations.items())),
            "assertions_total": sum(checks.counts.values()),
            "assertions_by_category": dict(sorted(checks.counts.items())),
            "completed_parameter_pairs": len(result["cases"]),
            "conditional_rows": sum(len(case["conditional_checks"]) for case in result["cases"]),
        }
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(result, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(json.dumps({"status": result["status"], "output": str(args.output), **result["summary"]}, indent=2))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
