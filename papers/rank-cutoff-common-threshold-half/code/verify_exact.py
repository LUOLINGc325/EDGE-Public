#!/usr/bin/env python3
"""Deterministic exact-arithmetic checks for the rank-cutoff threshold case.

Only the Python standard library is used. All probabilities and revenues are
fractions.Fraction objects. The primary independent engines are (i) full
Plackett--Luce permutation enumeration, including the outside option, and (ii)
first-step conditioning on the next ranked item. A third prefix-set formula
checks the probability interface proposed in the research discovery note.

These finite calculations do not prove the universal theorems, establish
novelty, or certify an unseen/frozen manuscript. No formalization code is used.

Run from any working directory:
    python /absolute/path/to/code/verify_exact.py
The result is written to ../results/exact_checks.json by default.
"""

from __future__ import annotations

import argparse
from collections import Counter
from fractions import Fraction as F
from functools import lru_cache
import hashlib
from itertools import permutations
import json
from pathlib import Path


ZERO = F(0)
ONE = F(1)
HALF = F(1, 2)


class Audit:
    """Assertions are active even if Python is invoked with -O."""

    def __init__(self) -> None:
        self.counts: Counter[str] = Counter()

    def require(self, condition: bool, category: str, detail: str) -> None:
        self.counts[category] += 1
        if not condition:
            raise AssertionError(f"{category}: {detail}")

    def equal(self, actual, expected, category: str, detail: str) -> None:
        self.require(
            actual == expected,
            category,
            f"{detail}; actual={actual!r}; expected={expected!r}",
        )


def bit_items(mask: int, n: int):
    return (i for i in range(n) if mask & (1 << i))


def subset_masks(mask: int):
    current = mask
    while True:
        yield current
        if current == 0:
            break
        current = (current - 1) & mask


def mask_products(mask: int, n: int) -> list[int]:
    return [i + 1 for i in bit_items(mask, n)]


def total_weight(v: tuple[F, ...], mask: int) -> F:
    return sum((v[i] for i in bit_items(mask, len(v))), ZERO)


def weighted_revenue(v: tuple[F, ...], r: tuple[F, ...], mask: int) -> F:
    return sum((v[i] * r[i] for i in bit_items(mask, len(v))), ZERO)


def revenue(probabilities: tuple[F, ...], r: tuple[F, ...]) -> F:
    # Entry zero denotes the outside option. Product i has entry i+1.
    return sum((r[i] * probabilities[i + 1] for i in range(len(r))), ZERO)


def threshold_mask(r: tuple[F, ...], threshold: F) -> int:
    return sum(1 << i for i, value in enumerate(r) if value >= threshold)


def threshold_for_reference(v: tuple[F, ...], r: tuple[F, ...], s: int):
    if s == 0:
        # The normative theorem uses N for zero-revenue reference cases.
        return None, (1 << len(v)) - 1
    threshold = weighted_revenue(v, r, s) / (2 * total_weight(v, s))
    return threshold, threshold_mask(r, threshold)


def all_threshold_masks(r: tuple[F, ...]) -> list[int]:
    return sorted({threshold_mask(r, level) for level in r})


def combine_atoms(atoms: list[tuple[int, F]]) -> dict[int, F]:
    answer: dict[int, F] = {}
    for k, probability in atoms:
        answer[k] = answer.get(k, ZERO) + probability
    return dict(sorted(answer.items()))


def mixtures_for_n(n: int) -> dict[str, dict[int, F]]:
    # K=n and K=n+1 agree on purchases for nonempty assortments. Keeping both
    # in the tests detects off-by-one errors in how the outside option ranks.
    triangular_total = F((n + 1) * (n + 2), 2)
    return {
        "uniform_all_ranks": {k: F(1, n + 1) for k in range(1, n + 2)},
        "extreme_ranks": combine_atoms([(1, F(2, 3)), (n + 1, F(1, 3))]),
        "triangular_all_ranks": {
            k: F(k) / triangular_total for k in range(1, n + 2)
        },
        "one_or_n": combine_atoms([(1, F(9, 10)), (n, F(1, 10))]),
        "zero_or_full": {0: F(1, 5), n + 1: F(4, 5)},
        "never_purchase": {0: ONE},
    }


class ExactPL:
    def __init__(self, v: tuple[F, ...], outside: F, audit: Audit):
        self.v = tuple(v)
        self.n = len(v)
        self.full = (1 << self.n) - 1
        self.outside = outside
        self.audit = audit
        audit.require(outside > 0, "parameter_domain", "outside weight positive")
        audit.require(all(x > 0 for x in v), "parameter_domain", "product weights positive")

        @lru_cache(maxsize=None)
        def recurse(s: int, remaining: int, k: int) -> tuple[F, ...]:
            # First-step conditioning. We do not use permutation probabilities
            # or the common-factor/prefix formula in this engine.
            if k == 0:
                return (ONE,) + (ZERO,) * self.n
            denominator = outside + total_weight(self.v, remaining)
            answer = [ZERO] * (self.n + 1)
            answer[0] = outside / denominator
            for i in bit_items(remaining, self.n):
                chance = self.v[i] / denominator
                if s & (1 << i):
                    answer[i + 1] += chance
                else:
                    continuation = recurse(s, remaining ^ (1 << i), k - 1)
                    for j, probability in enumerate(continuation):
                        answer[j] += chance * probability
            return tuple(answer)

        self._recurse = recurse

    def recursive(self, s: int, k: int) -> tuple[F, ...]:
        return self._recurse(s, self.full, k)

    def recursive_mixture(self, s: int, mixture: dict[int, F]) -> tuple[F, ...]:
        self._check_mixture(mixture)
        return tuple(
            sum((mass * self.recursive(s, k)[j] for k, mass in mixture.items()), ZERO)
            for j in range(self.n + 1)
        )

    def _check_mixture(self, mixture: dict[int, F]) -> None:
        self.audit.equal(sum(mixture.values(), ZERO), ONE, "mixture_domain", "mass sums to one")
        self.audit.require(
            bool(mixture) and all(k >= 0 and mass >= 0 for k, mass in mixture.items()),
            "mixture_domain",
            "nonnegative integer cutoff and independent mixture mass",
        )

    def enumerate_all(self) -> tuple[dict[tuple[int, int], tuple[F, ...]], int]:
        # Complete permutations include outside item 0 and product items 1..n.
        weights = (self.outside,) + self.v
        initial_total = sum(weights, ZERO)
        table = {
            (s, k): [ZERO] * (self.n + 1)
            for s in range(self.full + 1)
            for k in range(self.n + 2)
        }
        mass_sum = ZERO
        permutation_count = 0
        for order in permutations(range(self.n + 1)):
            probability = ONE
            remaining_total = initial_total
            for item in order:
                probability *= weights[item] / remaining_total
                remaining_total -= weights[item]
            mass_sum += probability
            permutation_count += 1
            for s in range(self.full + 1):
                # The first item in S union {0} determines whether purchase is
                # possible before the cutoff. All earlier items are unoffered.
                for rank, item in enumerate(order, start=1):
                    if item == 0 or (s & (1 << (item - 1))):
                        first_rank, first_item = rank, item
                        break
                for k in range(self.n + 2):
                    chosen = first_item if first_rank <= k else 0
                    table[s, k][chosen] += probability
        self.audit.equal(mass_sum, ONE, "pl_permutation_normalization", "complete permutation mass")
        return {key: tuple(value) for key, value in table.items()}, permutation_count

    def mixed_enumeration(
        self,
        table: dict[tuple[int, int], tuple[F, ...]],
        mixture: dict[int, F],
    ) -> dict[int, tuple[F, ...]]:
        self._check_mixture(mixture)
        return {
            s: tuple(
                sum((mass * table[s, k][j] for k, mass in mixture.items()), ZERO)
                for j in range(self.n + 1)
            )
            for s in range(self.full + 1)
        }

    def prefix_factor(self, s: int, mixture: dict[int, F]) -> F:
        total = self.outside + total_weight(self.v, self.full)

        @lru_cache(maxsize=None)
        def coefficient(a: int) -> F:
            if a == 0:
                return ONE / total
            numerator = sum(
                (self.v[j] * coefficient(a ^ (1 << j)) for j in bit_items(a, self.n)),
                ZERO,
            )
            return numerator / (total - total_weight(self.v, a))

        answer = ZERO
        for a in subset_masks(self.full ^ s):
            survival = sum(
                (mass for k, mass in mixture.items() if k >= a.bit_count() + 1),
                ZERO,
            )
            answer += coefficient(a) * survival
        return answer


def audit_probabilities(
    model: ExactPL,
    table: dict[int, tuple[F, ...]],
    r: tuple[F, ...],
    audit: Audit,
) -> dict:
    n, full, v = model.n, model.full, model.v
    factors: dict[int, F] = {}
    values = {s: revenue(table[s], r) for s in range(full + 1)}
    for s in range(full + 1):
        probabilities = table[s]
        audit.equal(sum(probabilities, ZERO), ONE, "choice_normalization", f"S={s}")
        audit.require(all(p >= 0 for p in probabilities), "choice_nonnegativity", f"S={s}")
        for i in range(n):
            if not s & (1 << i):
                audit.equal(probabilities[i + 1], ZERO, "unoffered_zero", f"S={s}, i={i}")
        if s:
            first = next(bit_items(s, n))
            q = probabilities[first + 1] / v[first]
            factors[s] = q
            for i in bit_items(s, n):
                audit.equal(probabilities[i + 1], v[i] * q, "proportionality", f"S={s}, i={i}")
            audit.equal(probabilities[0], ONE - total_weight(v, s) * q, "outside_factor", f"S={s}")
            audit.equal(values[s], q * weighted_revenue(v, r, s), "revenue_factor", f"S={s}")

    inclusion_pairs = 0
    for u in range(full + 1):
        for s in subset_masks(u):
            inclusion_pairs += 1
            audit.require(table[u][0] <= table[s][0], "outside_regularity", f"S={s}, U={u}")
            audit.require(
                ONE - table[u][0] >= ONE - table[s][0],
                "purchase_regularity",
                f"S={s}, U={u}",
            )
            for i in bit_items(s, n):
                audit.require(table[u][i + 1] <= table[s][i + 1], "product_regularity", f"S={s}, U={u}, i={i}")
            if s:
                audit.require(factors[u] <= factors[s], "factor_regularity", f"S={s}, U={u}")
                audit.require(
                    total_weight(v, u) * factors[u] >= total_weight(v, s) * factors[s],
                    "weighted_factor_regularity",
                    f"S={s}, U={u}",
                )

    threshold_rows = []
    positive_ratios = []
    zero_reference_count = 0
    threshold_tie_count = 0
    minimum_margin = None
    for s in range(full + 1):
        threshold, h = threshold_for_reference(v, r, s)
        margin = 2 * values[h] - values[s]
        audit.require(margin >= 0, "reference_threshold_half", f"S={s}, H={h}")
        minimum_margin = margin if minimum_margin is None else min(minimum_margin, margin)
        if values[s] > 0:
            positive_ratios.append((values[h] / values[s], s, h))
        else:
            zero_reference_count += 1
        if threshold is not None:
            threshold_tie_count += sum(value == threshold for value in r)
            audit.require(h != 0, "nonempty_reference_has_threshold", f"S={s}")
            u = s | h
            audit.require(
                weighted_revenue(v, r, h) >= threshold * total_weight(v, u),
                "union_weight_inequality",
                f"S={s}, H={h}, U={u}",
            )
        threshold_rows.append({
            "S": mask_products(s, n),
            "t": threshold,
            "H": mask_products(h, n),
            "R_S": values[s],
            "R_H": values[h],
            "twice_R_H_minus_R_S": margin,
        })
    optimum = max(values.values())
    thresholds = all_threshold_masks(r)
    best_threshold = max(values[h] for h in thresholds)
    audit.require(2 * best_threshold >= optimum, "best_threshold_half_opt", "all assortments vs all thresholds")
    minimum_ratio = min(positive_ratios) if positive_ratios else None
    return {
        "assortments_checked": full + 1,
        "inclusion_pairs_checked": inclusion_pairs,
        "zero_revenue_references_checked": zero_reference_count,
        "exact_threshold_ties_encountered": threshold_tie_count,
        "minimum_twice_R_H_minus_R_S": minimum_margin,
        "minimum_positive_reference_ratio": None if minimum_ratio is None else {
            "ratio": minimum_ratio[0],
            "S": mask_products(minimum_ratio[1], n),
            "H": mask_products(minimum_ratio[2], n),
        },
        "OPT": optimum,
        "best_threshold_revenue": best_threshold,
        "distinct_nonempty_thresholds": len(thresholds),
        "all_reference_threshold_checks": threshold_rows,
    }


def run_small_enumerations(audit: Audit) -> list[dict]:
    specifications = [
        ("one_product", (F(2, 3),), F(5, 4), (F(3),)),
        ("two_products_zero_revenue", (F(2), F(3, 2)), ONE, (ZERO, F(5))),
        ("threshold_equalities", (ONE, ONE, ONE), ONE, (ONE, F(2), F(3))),
        ("all_zero_revenues", (ONE, F(2), F(4)), F(3, 2), (ZERO, ZERO, ZERO)),
        ("heavy_product", (ONE, ONE, F(97)), ONE, (ONE, ONE, F(1, 100))),
        ("four_rational_weights", (HALF, F(2), F(5, 3), F(7, 4)), F(3, 2), (ZERO, F(2), F(2), F(5))),
        ("five_products", (ONE, F(2), F(3), F(4), F(5)), F(2, 3), (F(9), F(5, 2), ZERO, F(7), F(7))),
    ]
    output = []
    for name, v, outside, r in specifications:
        model = ExactPL(v, outside, audit)
        enumeration, number_of_permutations = model.enumerate_all()
        for (s, k), observed in enumeration.items():
            recursive = model.recursive(s, k)
            for j in range(model.n + 1):
                audit.equal(observed[j], recursive[j], "enumeration_vs_first_step", f"{name}: S={s}, K={k}, item={j}")
        for s in range(1, model.full + 1):
            denominator = outside + total_weight(v, s)
            ordinary_mnl = tuple(
                [outside / denominator]
                + [v[i] / denominator if s & (1 << i) else ZERO for i in range(model.n)]
            )
            for k in (model.n, model.n + 1, model.n + 3):
                audit.equal(model.recursive(s, k), ordinary_mnl, "cutoff_saturation_at_n", f"{name}: S={s}, K={k}")
        mixture_rows = []
        for mixture_name, mixture in mixtures_for_n(model.n).items():
            mixed = model.mixed_enumeration(enumeration, mixture)
            for s in range(model.full + 1):
                recursive = model.recursive_mixture(s, mixture)
                for j in range(model.n + 1):
                    audit.equal(mixed[s][j], recursive[j], "mixed_enumeration_vs_first_step", f"{name}/{mixture_name}: S={s}, item={j}")
                if s:
                    q = model.prefix_factor(s, mixture)
                    for i in bit_items(s, model.n):
                        audit.equal(mixed[s][i + 1], v[i] * q, "prefix_formula_vs_enumeration", f"{name}/{mixture_name}: S={s}, i={i}")
            mixture_rows.append({
                "name": mixture_name,
                "cutoff_distribution": mixture,
                "checks": audit_probabilities(model, mixed, r, audit),
            })
        output.append({
            "name": name,
            "n": model.n,
            "v": v,
            "outside_weight": outside,
            "revenues": r,
            "complete_permutations_enumerated": number_of_permutations,
            "deterministic_cutoffs_enumerated": list(range(model.n + 2)),
            "additional_saturation_cutoff_checked": model.n + 3,
            "mixtures": mixture_rows,
        })
    return output


def run_shared_scenarios(audit: Audit) -> dict:
    v = (ONE, F(2), F(3), F(4))
    r = (ZERO, ONE, F(3), F(9, 2))
    n, full = len(v), (1 << len(v)) - 1
    specifications = [
        ("cutoff_one", ONE, {1: ONE}),
        ("cutoff_two", ONE, {2: ONE}),
        ("complete_choice", ONE, {4: ONE}),
        ("larger_outside_mixed", F(5, 2), {1: F(1, 4), 3: HALF, 5: F(1, 4)}),
        ("large_outside_rare_deep_cutoff", F(7), {1: F(9, 10), 4: F(1, 10)}),
    ]
    values: dict[str, dict[int, F]] = {}
    scenarios = []
    model_cache = {}
    for name, outside, mixture in specifications:
        if outside not in model_cache:
            model = ExactPL(v, outside, audit)
            table, count = model.enumerate_all()
            model_cache[outside] = (model, table, count)
        model, table, count = model_cache[outside]
        mixed = model.mixed_enumeration(table, mixture)
        for s in range(full + 1):
            audit.equal(mixed[s], model.recursive_mixture(s, mixture), "scenario_enumeration_vs_first_step", f"{name}, S={s}")
        checks = audit_probabilities(model, mixed, r, audit)
        values[name] = {s: revenue(mixed[s], r) for s in range(full + 1)}
        scenarios.append({
            "name": name,
            "outside_weight": outside,
            "cutoff_distribution": mixture,
            "permutations_per_weight_configuration": count,
            "checks": checks,
        })
    robust = {s: min(by_s[s] for by_s in values.values()) for s in range(full + 1)}
    witnesses = []
    for s in range(full + 1):
        threshold, h = threshold_for_reference(v, r, s)
        margins = {}
        for name, by_s in values.items():
            margins[name] = 2 * by_s[h] - by_s[s]
            audit.require(margins[name] >= 0, "shared_threshold_every_scenario", f"S={s}, H={h}, theta={name}")
        audit.require(2 * robust[h] >= robust[s], "shared_threshold_max_min", f"S={s}, H={h}")
        witnesses.append({
            "S": mask_products(s, n),
            "t": threshold,
            "one_common_H": mask_products(h, n),
            "scenario_margins": margins,
            "worst_case_R_S": robust[s],
            "worst_case_R_H": robust[h],
        })
    thresholds = all_threshold_masks(r)
    optimum = max(robust.values())
    threshold_optimum = max(robust[h] for h in thresholds)
    audit.require(2 * threshold_optimum >= optimum, "robust_best_threshold_half_opt", "finite shared-weight scenario family")
    return {
        "shared_v": v,
        "shared_revenues": r,
        "scenarios": scenarios,
        "every_reference_common_witness": witnesses,
        "robust_OPT": optimum,
        "robust_optimal_assortments": [mask_products(s, n) for s in robust if robust[s] == optimum],
        "best_threshold_worst_case_revenue": threshold_optimum,
        "robust_optimal_thresholds": [mask_products(h, n) for h in thresholds if robust[h] == threshold_optimum],
        "best_threshold_to_robust_OPT": threshold_optimum / optimum if optimum else None,
        "scope": "Finite scenario arithmetic only. The arbitrary-family infimum statement is a separate proof claim.",
    }


def run_discovery_sharpness(audit: Audit) -> dict:
    rows = []
    for epsilon in (ONE, HALF, F(1, 4), F(1, 8), F(1, 16), F(1, 32), F(1, 100), F(1, 1000)):
        v = (ONE / (ONE + epsilon + epsilon * epsilon), ONE / epsilon**2, ONE / epsilon)
        r = (ONE + epsilon + ONE / epsilon, ONE + epsilon, ONE)
        model = ExactPL(v, ONE, audit)
        enumeration, count = model.enumerate_all()
        table = {s: enumeration[s, 2] for s in range(8)}
        for s in range(8):
            audit.equal(table[s], model.recursive(s, 2), "sharpness_enumeration_vs_first_step", f"epsilon={epsilon}, S={s}")
        total = ONE + sum(v, ZERO)
        revenues = {s: revenue(table[s], r) for s in range(8)}
        scaled = {s: total * revenues[s] for s in range(8)}
        f = epsilon**-2 / (ONE + v[0] + epsilon**-1)
        g = epsilon**-1 / (ONE + v[0] + epsilon**-2)
        formulas = {
            1: epsilon**-1 * (ONE + f + g),
            3: (epsilon**-1 + (ONE + epsilon) * epsilon**-2) * (ONE + g),
            7: 2 * epsilon**-1 + (ONE + epsilon) * epsilon**-2,
            5: 2 * epsilon**-1 * (ONE + f),
        }
        for s, expected in formulas.items():
            audit.equal(scaled[s], expected, "sharpness_scaled_formula", f"epsilon={epsilon}, S={s}")
        thresholds = all_threshold_masks(r)
        audit.equal(set(thresholds), {1, 3, 7}, "sharpness_threshold_family", f"epsilon={epsilon}")
        optimum = max(revenues.values())
        best_threshold = max(revenues[h] for h in thresholds)
        audit.require(2 * best_threshold >= optimum, "sharpness_finite_half_bound", f"epsilon={epsilon}")
        audit.require(optimum >= revenues[5], "sharpness_reference_below_opt", f"epsilon={epsilon}")
        rows.append({
            "epsilon": epsilon,
            "v": v,
            "revenues": r,
            "K": 2,
            "complete_permutations_enumerated": count,
            "f": f,
            "g": g,
            "epsilon_times_f": epsilon * f,
            "scaled_J": {str(mask_products(s, 3)): scaled[s] for s in (1, 3, 7, 5)},
            "threshold_J_over_J_13": {str(mask_products(s, 3)): scaled[s] / scaled[5] for s in thresholds},
            "OPT": optimum,
            "optimal_assortments": [mask_products(s, 3) for s in revenues if revenues[s] == optimum],
            "best_threshold_revenue": best_threshold,
            "best_threshold_over_OPT": best_threshold / optimum,
            "best_threshold_over_R_13": best_threshold / revenues[5],
        })
    return {
        "attribution": "Bai, Feldman, Topaloglu and Wagner, Operations Research 72(4), Appendix D; DOI 10.1287/opre.2021.0060.",
        "note": "Exact rational sample points reproduce the attributed construction. Convergence to 1/2 requires the algebraic limit proof; this table is not that proof.",
        "rows": rows,
    }


def run_sharpness(audit: Audit) -> dict:
    rows = []
    for epsilon in (HALF, F(1, 4), F(1, 8), F(1, 16), F(1, 32), F(1, 100), F(1, 1000)):
        v = (ONE, epsilon**-2, epsilon**-1)
        r = (epsilon**-1, ONE, ONE - epsilon)
        model = ExactPL(v, ONE, audit)
        enumeration, count = model.enumerate_all()
        table = {s: enumeration[s, 2] for s in range(8)}
        for s in range(8):
            audit.equal(table[s], model.recursive(s, 2), "normative_sharpness_enumeration_vs_first_step", f"epsilon={epsilon}, S={s}")
        total = ONE + sum(v, ZERO)
        revenues = {s: revenue(table[s], r) for s in range(8)}
        scaled = {s: epsilon**2 * total * revenues[s] for s in range(8)}
        formulas = {
            1: epsilon + ONE / (ONE + 2 * epsilon) + epsilon**2 / (ONE + 2 * epsilon**2),
            3: (ONE + epsilon) * (ONE + epsilon / (ONE + 2 * epsilon**2)),
            7: ONE + 2 * epsilon - epsilon**2,
            5: (2 - epsilon) * (epsilon + ONE / (ONE + 2 * epsilon)),
        }
        for s, expected in formulas.items():
            audit.equal(scaled[s], expected, "normative_sharpness_scaled_formula_5_3", f"epsilon={epsilon}, S={s}")
        thresholds = all_threshold_masks(r)
        audit.equal(set(thresholds), {1, 3, 7}, "normative_sharpness_threshold_family", f"epsilon={epsilon}")
        optimum = max(revenues.values())
        best_threshold = max(revenues[h] for h in thresholds)
        audit.require(2 * best_threshold >= optimum, "normative_sharpness_half_bound", f"epsilon={epsilon}")
        audit.require(best_threshold / optimum <= max(scaled[h] for h in thresholds) / scaled[5], "normative_sharpness_squeeze_upper", f"epsilon={epsilon}")
        rows.append({
            "epsilon": epsilon,
            "v": v,
            "revenues": r,
            "K": 2,
            "complete_permutations_enumerated": count,
            "A_equals_epsilon_squared_D_R": {str(mask_products(s, 3)): scaled[s] for s in (1, 3, 7, 5)},
            "OPT": optimum,
            "optimal_assortments": [mask_products(s, 3) for s in revenues if revenues[s] == optimum],
            "best_threshold_revenue": best_threshold,
            "best_threshold_over_OPT": best_threshold / optimum,
            "squeeze_upper_bound": max(scaled[h] for h in thresholds) / scaled[5],
        })
    return {
        "attribution": "The sharp cutoff-two mechanism is attributed to Bai, Feldman, Topaloglu and Wagner, Appendix D, DOI 10.1287/opre.2021.0060. The exact displayed parametrization is independently checked here; arithmetic alone does not verify historical attribution.",
        "normative_manuscript_family": {
            "parameters": "0<epsilon<1; v=(1,epsilon^-2,epsilon^-1), r=(epsilon^-1,1,1-epsilon), v0=1, K=2.",
            "formula_checked": "Normative manuscript equation (5.3), each of its four rational expressions.",
            "rows": rows,
        },
        "additional_discovery_parametrization": run_discovery_sharpness(audit),
        "note": "All rows are exact rational checks. The universal lower bound and epsilon-to-zero sharpness limit depend on the written proof, not finite sampling.",
    }


def singleton_surrogate(v: tuple[F, ...], r: tuple[F, ...], q) -> tuple[F, list[dict], list[F]]:
    omega = [v[i] * q(1 << i) for i in range(len(v))]
    # Convex piecewise-affine objective; its minimum over tau>=0 occurs at a
    # breakpoint (or a flat interval endpoint). Include zero and all revenues.
    values = []
    for tau in sorted({ZERO, *r}):
        objective = tau + sum((omega[i] * max(r[i] - tau, ZERO) for i in range(len(r))), ZERO)
        values.append({"tau": tau, "objective": objective})
    return min(row["objective"] for row in values), values, omega


def run_surrogate_family(audit: Audit) -> dict:
    rows = []
    for m in (3, 4, 5, 8, 16, 32, 64, 128):
        big_weight = m**3
        denominator = 1 + m + big_weight
        first_mass, deep_mass = ONE - F(2, m), F(2, m)
        a, b = first_mass / denominator, deep_mass
        v = (ONE,) * m + (F(big_weight),)
        r = (ONE,) * m + (F(1, big_weight),)

        def q(s: int) -> F:
            return a + b / (ONE + total_weight(v, s))

        surrogate, breakpoints, omega = singleton_surrogate(v, r, q)
        audit.equal(sum(omega[:m], ZERO), ONE + F(m - 2, denominator), "family_high_singleton_sum", f"m={m}")
        audit.equal(surrogate, ONE, "family_surrogate_one", f"m={m}")
        without, with_extra = [], []
        for k in range(m + 1):
            without.append(F(k) * (a + b / (1 + k)))
            with_extra.append(F(k + 1) * (a + b / (1 + big_weight + k)))
        for k in range(m):
            audit.equal(without[k + 1] - without[k], a + b / ((k + 1) * (k + 2)), "family_without_increment", f"m={m}, k={k}")
            audit.equal(with_extra[k + 1] - with_extra[k], a + b * big_weight / ((big_weight + k + 1) * (big_weight + k + 2)), "family_with_increment", f"m={m}, k={k}")
            audit.require(without[k + 1] > without[k], "family_without_monotonicity", f"m={m}, k={k}")
            audit.require(with_extra[k + 1] > with_extra[k], "family_with_monotonicity", f"m={m}, k={k}")
        expected_without = F(m - 2, denominator) + F(2, m + 1)
        expected_with = F(m + 1, denominator)
        audit.equal(max(without), expected_without, "family_without_optimum_formula", f"m={m}")
        audit.equal(max(with_extra), expected_with, "family_with_optimum_formula", f"m={m}")
        gap_factorization = F((m - 1) * (2 * m * m + 2 * m + 1), denominator * (m + 1))
        audit.equal(expected_without - expected_with, gap_factorization, "family_branch_gap_factorization", f"m={m}")
        audit.require(gap_factorization > 0, "family_without_branch_wins", f"m={m}")
        independent_check = "For larger m, every symmetry class (high-product count and extra-product presence) was checked using exact formulae."
        if m in (3, 4):
            model = ExactPL(v, ONE, audit)
            enumeration, count = model.enumerate_all()
            mixture = {1: first_mass, m + 1: deep_mass}
            mixed = model.mixed_enumeration(enumeration, mixture)
            for s in range(model.full + 1):
                audit.equal(mixed[s], model.recursive_mixture(s, mixture), "family_enumeration_vs_first_step", f"m={m}, S={s}")
                for i in bit_items(s, model.n):
                    audit.equal(mixed[s][i + 1], v[i] * q(s), "family_closed_form_vs_enumeration", f"m={m}, S={s}, i={i}")
            direct_optimum = max(revenue(p, r) for p in mixed.values())
            audit.equal(direct_optimum, expected_without, "family_enumerated_global_optimum", f"m={m}")
            independent_check = f"All {model.full + 1} assortments checked by {count} complete PL permutations, first-step recursion, and the closed form."
        rows.append({
            "m_high_products": m,
            "n": m + 1,
            "extra_weight_M": big_weight,
            "D": denominator,
            "cutoff_distribution": {1: first_mass, m + 1: deep_mass},
            "high_singleton_probability_sum": sum(omega[:m], ZERO),
            "U_star": surrogate,
            "surrogate_breakpoints": breakpoints,
            "maximum_without_extra": expected_without,
            "maximum_with_extra": expected_with,
            "R_star": expected_without,
            "R_star_over_U_star": expected_without / surrogate,
            "positive_branch_gap": gap_factorization,
            "symmetry_classes_checked": 2 * (m + 1),
            "independent_check": independent_check,
        })
    return {
        "family": "Integer m>=3, m unit-weight/unit-revenue products, one product with weight m^3 and revenue m^-3; K=1 with mass 1-2/m and K=m+1 with mass 2/m.",
        "all_m_algebra_to_be_proved_in_manuscript": {
            "U_star": "1",
            "R_star": "(m-2)/(1+m+m^3) + 2/(m+1)",
            "branch_gap": "(m-1)(2m^2+2m+1)/[(1+m+m^3)(m+1)] > 0",
            "limit": "R_star/U_star -> 0 as m -> infinity",
        },
        "note": "The listed finite m values and their symmetry classes are exact checks. They do not prove the quantified statement for every m or its limit.",
        "rows": rows,
    }


def run_nine_product_fixture(audit: Audit) -> dict:
    v = (ONE,) * 8 + (F(1024),)
    r = (ONE,) * 8 + (F(1, 1024),)
    model = ExactPL(v, ONE, audit)
    mixture = {1: F(3, 4), 9: F(1, 4)}

    def q(s: int) -> F:
        return F(3, 4132) + ONE / (4 * (ONE + total_weight(v, s)))

    values = {}
    for s in range(model.full + 1):
        recursive = model.recursive_mixture(s, mixture)
        expected = tuple(
            [ONE - total_weight(v, s) * q(s)]
            + [v[i] * q(s) if s & (1 << i) else ZERO for i in range(9)]
        )
        audit.equal(recursive, expected, "n9_first_step_vs_closed_form", f"S={s}")
        values[s] = revenue(recursive, r)
    surrogate, breakpoints, omega = singleton_surrogate(v, r, q)
    without = max(value for s, value in values.items() if not s & (1 << 8))
    with_extra = max(value for s, value in values.items() if s & (1 << 8))
    audit.equal(sum(omega[:8], ZERO), F(1039, 1033), "n9_high_singleton_sum", "eight high products")
    audit.equal(surrogate, ONE, "n9_surrogate", "all breakpoints")
    audit.equal(without, F(2120, 9297), "n9_without_optimum", "all subsets excluding extra")
    audit.equal(with_extra, F(9, 1033), "n9_with_optimum", "all subsets including extra")
    audit.equal(max(values.values()), F(2120, 9297), "n9_global_optimum", "all 512 subsets")
    audit.require(max(values.values()) < surrogate / 2, "n9_half_surrogate_failure", "strict separation")
    return {
        "n": 9,
        "v": v,
        "revenues": r,
        "outside_weight": ONE,
        "cutoff_distribution": mixture,
        "assortments_checked_by_first_step": len(values),
        "full_permutation_enumeration": "Not used at n=9; all 512 assortments were independently checked by first-step recursion against the mixture closed form.",
        "high_singleton_probability_sum": sum(omega[:8], ZERO),
        "U_star": surrogate,
        "surrogate_breakpoints": breakpoints,
        "maximum_without_extra": without,
        "maximum_with_extra": with_extra,
        "R_star": max(values.values()),
        "R_star_less_than_half_U_star": True,
        "optimal_assortments": [mask_products(s, 9) for s, value in values.items() if value == max(values.values())],
    }


def run_nonaffine_fixture(audit: Audit) -> dict:
    v = (ONE, ONE, F(97))
    r = (ONE, ONE, F(1, 100))
    model = ExactPL(v, ONE, audit)
    mixture = {1: F(9, 10), 3: F(1, 10)}
    enumeration, count = model.enumerate_all()
    table = model.mixed_enumeration(enumeration, mixture)
    q_values = {}
    for s in range(1, 8):
        audit.equal(table[s], model.recursive_mixture(s, mixture), "nonaffine_enumeration_vs_first_step", f"S={s}")
        q = F(9, 1000) + ONE / (10 * (ONE + total_weight(v, s)))
        q_values[s] = q
        for i in bit_items(s, 3):
            audit.equal(table[s][i + 1], v[i] * q, "nonaffine_closed_form", f"S={s}, i={i}")
    expected = {1: F(59, 1000), 3: F(127, 3000), 5: F(991, 99000), 7: F(1, 100)}
    for s, value in expected.items():
        audit.equal(q_values[s], value, "nonaffine_named_q", f"S={s}")
    cross_difference = ONE / q_values[7] + ONE / q_values[1] - ONE / q_values[3] - ONE / q_values[5]
    audit.equal(cross_difference, F(-48800700, 7425563), "nonaffine_cross_difference", "D(123)+D(1)-D(12)-D(13)")
    audit.require(cross_difference != 0, "nonaffine_obstruction", "affine denominator would have zero cross difference")
    omega = tuple(table[1 << i][i + 1] for i in range(3))
    auxiliary = {
        s: sum((r[i] * omega[i] for i in bit_items(s, 3)), ZERO)
        / (ONE + sum((omega[i] for i in bit_items(s, 3)), ZERO))
        for s in range(8)
    }
    tau = max(auxiliary.values())
    audit.equal(tau, F(59, 559), "nonaffine_auxiliary_mnl_threshold", "all auxiliary assortments")
    h = sum(1 << i for i, ri in enumerate(r) if ri > tau)
    audit.equal(h, 3, "nonaffine_odds_threshold_set", "strict revenue comparison")
    odds = table[h][1] / table[h][0]
    audit.equal(odds, F(127, 2746), "nonaffine_odds", "product 1 in assortment {1,2}")
    audit.require(odds < omega[0], "nonaffine_odds_condition_failure", "odds less than singleton acceptance")
    actual_purchase_12 = ONE - table[3][0]
    independent_union = omega[0] + omega[1] - omega[0] * omega[1]
    forced_intersection = omega[0] + omega[1] - actual_purchase_12
    audit.equal(actual_purchase_12, F(127, 1500), "nonaffine_actual_union", "purchase {1,2}")
    audit.equal(independent_union, F(114519, 1000000), "nonaffine_independent_union", "hypothetical independent singletons")
    audit.equal(forced_intersection, F(1, 30), "nonaffine_forced_intersection", "inclusion-exclusion")
    audit.require(forced_intersection != omega[0] * omega[1], "nonaffine_independence_obstruction", "forced intersection differs from product")
    return {
        "v": v,
        "revenues_for_odds_check": r,
        "outside_weight": ONE,
        "cutoff_distribution": mixture,
        "complete_permutations_enumerated": count,
        "q": {str(mask_products(s, 3)): q_values[s] for s in expected},
        "reciprocal_q_cross_difference": cross_difference,
        "difference_is_nonzero": True,
        "auxiliary_MNL_optimum": tau,
        "auxiliary_threshold_assortment": mask_products(h, 3),
        "product_one_odds_at_threshold": odds,
        "product_one_singleton_probability": omega[0],
        "odds_sufficient_condition_fails": True,
        "actual_purchase_probability_12": actual_purchase_12,
        "independent_singleton_union_probability": independent_union,
        "forced_intersection_probability": forced_intersection,
        "independent_intersection_probability": omega[0] * omega[1],
        "scope": "Arithmetic witnesses exclude the specified direct affine-denominator and odds/independent-acceptance representations. They do not prove absence of all possible indirect reductions.",
    }


def run_search_cost_certificate(audit: Audit) -> dict:
    attractions = (F(11), F(8), F(7))
    cost_base = F(7, 4)
    rows = []
    for s, expected_by_size, expected_psi in (
        (6, (ONE, F(36, 7), F(256, 49)), 6),
        (7, (ONE, F(48, 7), F(320, 49), F(1728, 343)), 1),
    ):
        objectives = {
            t: (ONE + total_weight(attractions, t)) / cost_base**t.bit_count()
            for t in subset_masks(s)
        }
        best_by_size = tuple(
            max(value for t, value in objectives.items() if t.bit_count() == size)
            for size in range(s.bit_count() + 1)
        )
        audit.equal(best_by_size, expected_by_size, "search_cost_cardinality_objectives", f"S={s}")
        maximum = max(objectives.values())
        maximizers = [t for t, value in objectives.items() if value == maximum]
        audit.equal(maximizers, [expected_psi], "search_cost_unique_consideration_set", f"S={s}")
        purchase = total_weight(attractions, expected_psi) / (ONE + total_weight(attractions, expected_psi))
        rows.append({
            "S": mask_products(s, 3),
            "best_objective_by_size": best_by_size,
            "unique_consideration_set": mask_products(expected_psi, 3),
            "purchase_probability": purchase,
        })
    audit.equal(rows[0]["purchase_probability"], F(15, 16), "search_cost_purchase_small", "S={2,3}")
    audit.equal(rows[1]["purchase_probability"], F(11, 12), "search_cost_purchase_large", "S=N")
    audit.require(rows[0]["purchase_probability"] > rows[1]["purchase_probability"], "search_cost_outside_regularity_failure", "strict purchase decrease under expansion")
    cutoff_model = ExactPL((ONE, ONE), ONE, audit)
    cutoff_table, permutation_count = cutoff_model.enumerate_all()
    for s in (1, 2, 3):
        for i in bit_items(s, 2):
            audit.equal(cutoff_table[s, 1][i + 1], F(1, 3), "cutoff_one_constant_incumbent_probability", f"S={s}, i={i}")
    return {
        "attribution": "Wang and Sahin homogeneous search-cost Example 2; see manuscript Section 6.3 for the model and source scope.",
        "attractions": attractions,
        "outside_attraction": ONE,
        "transformed_cost": F(3, 4),
        "objective": "(1+sum_{i in T} a_i)/(7/4)^|T| for T subset S",
        "all_subset_maximizations": rows,
        "purchase_probability_decrease": rows[0]["purchase_probability"] - rows[1]["purchase_probability"],
        "two_product_cutoff_one_counterdirection": {
            "weights_including_outside": [ONE, ONE, ONE],
            "complete_permutations_enumerated": permutation_count,
            "every_offered_product_probability": F(1, 3),
        },
        "scope": "Finite arithmetic certificates support the two stated noninclusions. They do not rule out arbitrary heterogeneous mixtures of search-cost models.",
    }


def run_single_mdm_certificate(audit: Audit) -> dict:
    v = (ONE, ONE, ONE, F(5, 2))
    model = ExactPL(v, ONE, audit)
    mixture = {2: F(9, 10), 3: F(1, 10)}
    enumeration, permutation_count = model.enumerate_all()
    mixed = model.mixed_enumeration(enumeration, mixture)
    for s in range(model.full + 1):
        for k in (2, 3):
            audit.equal(enumeration[s, k], model.recursive(s, k), "mdm_deterministic_enumeration_vs_first_step", f"S={s}, K={k}")
        audit.equal(mixed[s], model.recursive_mixture(s, mixture), "mdm_mixed_enumeration_vs_first_step", f"S={s}")
        if s:
            q = model.prefix_factor(s, mixture)
            for i in bit_items(s, 4):
                audit.equal(mixed[s][i + 1], v[i] * q, "mdm_prefix_formula_vs_enumeration", f"S={s}, i={i}")
    a, b = 7, 9  # A={1,2,3}, B={1,4}; outside option 0 is always available.
    for k in (2, 3):
        audit.equal(enumeration[a, k][1], F(1, 4), "mdm_A_deterministic_q", f"K={k}")
    audit.equal(enumeration[b, 2][1], F(30, 143), "mdm_B_cutoff_two_q", "B={1,4}")
    audit.equal(enumeration[b, 3][1], F(2, 9), "mdm_B_cutoff_three_q", "B={1,4}")
    audit.equal(mixed[a][1], F(1, 4), "mdm_product_one_A", "A={1,2,3}")
    audit.equal(mixed[a][0], F(1, 4), "mdm_outside_A", "A={1,2,3}")
    audit.equal(mixed[b][1], F(1358, 6435), "mdm_product_one_B", "B={1,4}")
    audit.equal(mixed[b][0], F(1682, 6435), "mdm_outside_B", "B={1,4}")
    product_change = mixed[a][1] - mixed[b][1]
    outside_change = mixed[a][0] - mixed[b][0]
    audit.require(product_change > 0 and outside_change < 0, "mdm_common_option_strict_reversal", "product 1 and outside move in opposite directions")
    audit.require(
        all(ZERO < mixed[s][i] < ONE for s in (a, b) for i in (0, 1)),
        "mdm_reversal_strictly_interior",
        "all four witness probabilities are in (0,1)",
    )
    probability_checks = audit_probabilities(model, mixed, (ONE, F(2), F(3), F(4)), audit)
    return {
        "v": v,
        "outside_weight": ONE,
        "cutoff_distribution": mixture,
        "complete_permutations_enumerated": permutation_count,
        "all_assortments_checked": model.full + 1,
        "A": mask_products(a, 4),
        "B": mask_products(b, 4),
        "q2_A": enumeration[a, 2][1],
        "q3_A": enumeration[a, 3][1],
        "q2_B": enumeration[b, 2][1],
        "q3_B": enumeration[b, 3][1],
        "p1_A": mixed[a][1],
        "p0_A": mixed[a][0],
        "p1_B": mixed[b][1],
        "p0_B": mixed[b][0],
        "p1_A_minus_p1_B": product_change,
        "p0_A_minus_p0_B": outside_change,
        "strict_reversal": True,
        "probability_and_threshold_checks_with_test_revenues_1_2_3_4": probability_checks,
        "necessary_condition_source": {
            "title": "A Nonparametric Approach with Marginals for Modeling Consumer Choice",
            "url": "https://arxiv.org/html/2208.06115v6",
            "location": "Assumption 2.2; Theorem 3.1 and its necessity proof; Lemma 3.4(b).",
            "verified_scope": "Fixed single MDM, including outside as an alternative, with absolutely continuous marginals strictly increasing on their supports and integrable absolute utilities. Common positive probabilities must order assortment multipliers consistently.",
        },
        "scope": "The strict reversal excludes a single MDM under the cited assumptions. It does not exclude arbitrary mixed-MDM representations or replace the mathematical necessary-condition argument.",
    }


def json_exact(value):
    if isinstance(value, F):
        return str(value)
    if isinstance(value, dict):
        return {str(key): json_exact(item) for key, item in value.items()}
    if isinstance(value, (tuple, list)):
        return [json_exact(item) for item in value]
    return value


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    default_output = Path(__file__).resolve().parents[1] / "results" / "exact_checks.json"
    parser.add_argument("--output", type=Path, default=default_output)
    arguments = parser.parse_args()
    audit = Audit()
    payload = {
        "schema": "exact_assortment_checks.v1",
        "status": "pass",
        "arithmetic": "Python standard-library fractions.Fraction; no binary floating-point arithmetic in calculations.",
        "fraction_encoding": "JSON strings containing an integer or a reduced numerator/denominator.",
        "randomness": "None. Finite parameter grids, complete stated permutations/subsets/inclusion pairs, and every stated symmetry class are deterministic.",
        "scope": "Independent finite arithmetic reproduction, not a proof, formal verification, novelty review, value approval, or frozen-manuscript mathematical sign-off.",
        "model_semantics": "PL ranks all products and the outside option. Scan up to independent cutoff K; choose the first offered product or the outside option encountered, and use outside if no such item is reached.",
        "outside_item": 0,
        "product_indices": "One-based in JSON; the Python implementation uses bit positions internally.",
        "small_model_enumerations": run_small_enumerations(audit),
        "shared_weight_scenarios": run_shared_scenarios(audit),
        "attributed_cutoff_two_sharpness": run_sharpness(audit),
        "singleton_surrogate_family": run_surrogate_family(audit),
        "nine_product_singleton_fixture": run_nine_product_fixture(audit),
        "nonaffine_denominator_fixture": run_nonaffine_fixture(audit),
        "homogeneous_search_cost_certificate": run_search_cost_certificate(audit),
        "single_MDM_exclusion_certificate": run_single_mdm_certificate(audit),
    }
    payload["checks_by_category"] = dict(sorted(audit.counts.items()))
    payload["total_exact_checks"] = sum(audit.counts.values())
    payload["verification_script_sha256"] = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    arguments.output.parent.mkdir(parents=True, exist_ok=True)
    arguments.output.write_text(json.dumps(json_exact(payload), ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({
        "status": "pass",
        "total_exact_checks": payload["total_exact_checks"],
        "output": str(arguments.output.resolve()),
        "verification_script_sha256": payload["verification_script_sha256"],
    }, indent=2))


if __name__ == "__main__":
    main()
