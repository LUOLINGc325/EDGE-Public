#!/usr/bin/env python3
"""Finite exact certificates and numerical diagnostics for coalescent costs.

No proof assistant is invoked. Exact checks use fractions.Fraction. Floating
stop-loss checks only inspect a stated finite collection of chains/thresholds.
They are not proofs for arbitrary measures, costs, sample sizes, or Xi models.
"""
from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import math
from pathlib import Path
import platform
import random
import sys
from fractions import Fraction as F

import numpy as np
import scipy
from scipy.linalg import expm
import mpmath as mp

SEED = 20261126
NUM_TOL = 2.0e-10


def C(n: int) -> int:
    return n * (n - 1) // 2


def checked_costs(costs: dict[int, F]) -> int:
    n = max(costs)
    if costs.get(1) != 0 or set(costs) != set(range(1, n + 1)):
        raise ValueError("Costs must have contiguous states and c_1=0")
    if any(costs[b] <= 0 for b in range(2, n + 1)):
        raise ValueError("Transient-state costs must be strictly positive")
    return n


def binary(n: int) -> dict[int, dict[int, F]]:
    return {b: {b - 1: F(C(b))} for b in range(2, n + 1)}


def star(n: int) -> dict[int, dict[int, F]]:
    return {b: {1: F(1)} for b in range(2, n + 1)}


def lambda_rates(n: int, measure: list[tuple[F, F]]) -> dict[int, dict[int, F]]:
    assert sum(w for _, w in measure) == 1
    assert all(0 <= x <= 1 and w >= 0 for x, w in measure)
    return {
        b: {
            b - k + 1: F(math.comb(b, k)) * sum(
                w * x ** (k - 2) * (1 - x) ** (b - k)
                for x, w in measure
            )
            for k in range(2, b + 1)
        }
        for b in range(2, n + 1)
    }


def random_pair_chain(n: int, rng: random.Random) -> dict[int, dict[int, F]]:
    result = {}
    for b in range(2, n + 1):
        weights = [rng.randrange(1, 10) for _ in range(2, b + 1)]
        total = sum(weights)
        result[b] = {
            b - k + 1: F(C(b) * weight, C(k) * total)
            for k, weight in zip(range(2, b + 1), weights)
        }
    return result


def moments(q: dict[int, dict[int, F]], costs: dict[int, F]):
    n = checked_costs(costs)
    v, second = {1: F(0)}, {1: F(0)}
    for b in range(2, n + 1):
        assert all(1 <= m < b and rate >= 0 for m, rate in q[b].items())
        rate = sum(q[b].values())
        assert rate > 0
        v[b] = (costs[b] + sum(r * v[m] for m, r in q[b].items())) / rate
        second[b] = (
            2 * costs[b] * v[b] + sum(r * second[m] for m, r in q[b].items())
        ) / rate
    return v, second


def cones(costs: dict[int, F]):
    n = checked_costs(costs)
    a, h = {1: F(0)}, {1: F(0)}
    for b in range(2, n + 1):
        a[b] = costs[b] / C(b)
        h[b] = h[b - 1] + a[b]
    lower, upper, simultaneous = [], [], []
    for b in range(2, n + 1):
        for m in range(1, b):
            k = b - m + 1
            lower.append((b, m, C(k) * a[b] - (h[b] - h[m])))
            upper.append((b, m, costs[b] * F(C(b) - C(k), C(b)) - costs[m]))
            simultaneous.append((b, m, wmin(b, m) * a[b] - (h[b] - h[m])))
    return {"L": lower, "U": upper, "LS": simultaneous}, a, h


def wmin(b: int, groups: int) -> int:
    size, remainder = divmod(b, groups)
    return groups * C(size) + remainder * size


def partitions(n: int, maximum: int | None = None):
    if n == 0:
        yield ()
        return
    maximum = n if maximum is None else min(maximum, n)
    for first in range(maximum, 0, -1):
        for tail in partitions(n - first, first):
            yield (first,) + tail


def random_simultaneous_chain(n: int, rng: random.Random):
    q, events = {}, {}
    for b in range(2, n + 1):
        types = [pi for pi in partitions(b) if len(pi) < b]
        weights = [rng.randrange(1, 10) for _ in types]
        total = sum(weights)
        q[b] = {}
        events[b] = []
        for pi, weight in zip(types, weights):
            w = sum(C(size) for size in pi)
            rate = F(C(b) * weight, w * total)
            groups = len(pi)
            q[b][groups] = q[b].get(groups, F(0)) + rate
            events[b].append((pi, rate))
        assert sum(rate * sum(C(size) for size in pi) for pi, rate in events[b]) == C(b)
    return q, events


def serialized_vector(v):
    return {str(b): str(value) for b, value in sorted(v.items())}


def exact_suite(rng: random.Random):
    report = {"arithmetic": "fractions.Fraction; every assertion is exact"}
    n = 12
    costs = {1: F(0), **{b: F(b) for b in range(2, n + 1)}}
    points = [F(0), F(1, 7), F(1, 4), F(1, 2), F(2, 3), F(4, 5), F(1)]
    measures = [[(x, F(1))] for x in points]
    for _ in range(40):
        chosen = rng.sample(points, 4)
        raw = [rng.randrange(1, 20) for _ in chosen]
        measures.append([(x, F(w, sum(raw))) for x, w in zip(chosen, raw)])
    vk, mk = moments(binary(n), costs)
    vs, ms = moments(star(n), costs)
    checked_rows = checked_moments = 0
    for measure in measures:
        q = lambda_rates(n, measure)
        v, second = moments(q, costs)
        first_mu = sum(w * x for x, w in measure)
        second_mu = sum(w * x * x for x, w in measure)
        assert v[2] == 2 and second[2] == 8
        assert v[3] == 3
        assert second[3] == (42 - 24 * first_mu) / (3 - 2 * first_mu)
        assert v[4] == (22 - 28 * first_mu + 10 * second_mu) / (6 - 8 * first_mu + 3 * second_mu)
        for b in range(2, n + 1):
            budget = sum(C(b - m + 1) * rate for m, rate in q[b].items())
            assert budget == C(b)
            assert 1 <= sum(q[b].values()) <= C(b)
            checked_rows += 1
            assert vk[b] <= v[b] <= b
            assert mk[b] <= second[b] <= 2 * b * v[b] <= 2 * b * b
            checked_moments += 1
    assert lambda_rates(n, [(F(0), F(1))]) == {
        b: {m: F(C(b)) if m == b - 1 else F(0) for m in range(1, b)}
        for b in range(2, n + 1)
    }
    report["lambda"] = {
        "max_sample_size": n, "pure_measures": 7, "finite_mixtures": 40,
        "budget_rows": checked_rows, "moment_comparison_rows": checked_moments,
        "endpoint_means": {"binary": serialized_vector(vk), "star": serialized_vector(vs)},
        "endpoint_second_moments": {"binary": serialized_vector(mk), "star": serialized_vector(ms)},
    }
    for b in range(2, n + 1):
        harmonic = sum(F(1, j) for j in range(1, b))
        variance = 4 * sum(F(1, j * j) for j in range(1, b))
        assert vk[b] == 2 * harmonic and mk[b] == vk[b] ** 2 + variance
        assert vs[b] == b and ms[b] == 2 * b * b

    partition_count = pair_count = 0
    for b in range(2, 13):
        by_groups = {}
        for pi in partitions(b):
            if len(pi) == b:
                continue
            by_groups.setdefault(len(pi), []).append(sum(C(size) for size in pi))
            partition_count += 1
        for groups, values in by_groups.items():
            assert min(values) == wmin(b, groups)
            assert max(values) == C(b - groups + 1)
            assert min(values) >= b - groups
            pair_count += 1
    report["partition_budget_geometry"] = {
        "max_state": 12, "partition_types_checked": partition_count,
        "state_group_pairs_checked": pair_count,
        "minimum_and_maximum_pair_weight_formula": "exactly_verified_on_enumerated_types",
    }

    # Exhaust all positive integer cost vectors in {1,...,6}^4 at N=5.
    counts = {"cost_vectors": 0, "L": 0, "U": 0, "LS": 0,
              "L_failure_witnesses": 0, "U_failure_witnesses": 0, "LS_failure_witnesses": 0}
    for values in itertools.product(range(1, 7), repeat=4):
        c = {1: F(0), **{b: F(x) for b, x in zip(range(2, 6), values)}}
        conditions, _, h = cones(c)
        accepted = {name: all(slack >= 0 for _, _, slack in rows)
                    for name, rows in conditions.items()}
        counts["cost_vectors"] += 1
        for name, yes in accepted.items():
            counts[name] += int(yes)
        assert not accepted["U"] or accepted["L"]
        assert not accepted["LS"] or accepted["L"]
        for name, rows in conditions.items():
            for b, m, slack in rows:
                if slack >= 0:
                    continue
                q = star(5) if name == "U" else binary(5)
                weight = wmin(b, m) if name == "LS" else C(b - m + 1)
                q[b] = {m: F(C(b), weight)}
                v, _ = moments(q, c)
                assert v[b] > c[b] if name == "U" else v[b] < h[b]
                counts[name + "_failure_witnesses"] += 1
    report["cost_cones_exhaustive_finite_check"] = {
        "N": 5, "positive_integer_cost_range": [1, 6], **counts,
        "note": "Finite exhaustive check only; the universal cone equivalences require the manuscript proof.",
    }

    # The bounded integer box above need not contain LS-positive vectors.
    # Verify explicit nonempty LS families and their exact moment comparisons.
    simultaneous_rows = 0
    for power in (3, 4):
        c = {1: F(0), **{b: F(b**power) for b in range(2, 9)}}
        cond, _, _ = cones(c)
        assert all(slack >= 0 for rows in cond.values() for _, _, slack in rows)
        lower_v, lower_second = moments(binary(8), c)
        for _ in range(20):
            q, events = random_simultaneous_chain(8, rng)
            v, second = moments(q, c)
            for b in range(2, 9):
                assert lower_v[b] <= v[b] <= c[b]
                assert lower_second[b] <= second[b] <= 2 * c[b] * v[b]
                simultaneous_rows += 1
    report["simultaneous_positive_cone_examples"] = {
        "integer_power_costs": [3, 4], "max_state": 8,
        "independent_chain_cost_instances": 40, "exact_moment_rows": simultaneous_rows,
        "all_L_U_LS_conditions_hold": True,
        "scope": "finite partition-type chains, not a test of infinite Xi models",
    }

    counterexamples = {}
    c = {1: F(0), 2: F(2), 3: F(3), 4: F(37, 10)}
    cond, _, h = cones(c)
    assert all(s >= 0 for _, _, s in cond["L"])
    assert any(s < 0 for _, _, s in cond["U"])
    q = binary(4)
    q[4] = {2: F(2)}
    v, second = moments(q, c)
    assert v[4] == F(77, 20) and second[4] == F(4449, 200)
    assert v[4] > c[4]
    counterexamples["L_does_not_imply_U"] = {
        "costs": serialized_vector(c), "q_4_to_2": "2", "q_2_to_1": "1",
        "binary_mean": str(h[4]), "witness_mean": str(v[4]),
        "star_mean": str(c[4]), "witness_second_moment": str(second[4]),
        "upper_mean_violation": str(v[4] - c[4]),
        "scope": "single-group pair-budget chain; not claimed sampling-consistent",
    }
    c = {1: F(0), 2: F(2), 3: F(4), 4: F(5)}
    cond, _, _ = cones(c)
    assert all(s >= 0 for _, _, s in cond["U"])
    assert c[3] / 3 > c[4] / 4
    assert any(s < 0 for _, _, s in cond["LS"])
    counterexamples["normalized_cost_monotonicity_not_necessary"] = {
        "costs": serialized_vector(c), "U_holds": True, "L_holds": True,
        "LS_holds": False, "c_3_over_3": str(c[3] / 3), "c_4_over_4": str(c[4] / 4),
    }
    c = {1: F(0), **{b: F(b) for b in range(2, 5)}}
    q = binary(4)
    q[4] = {2: F(3)}
    v, second = moments(q, c)
    vk4, mk4 = moments(binary(4), c)
    assert v[4] == F(10, 3) and vk4[4] == F(11, 3)
    assert second[4] == F(152, 9) and mk4[4] == F(170, 9)
    assert 3 * (C(2) + C(2)) == C(4)
    assert 3 * C(3) != C(4)  # Incorrect single-group encoding would change the budget.
    matchings = [((0, 1), (2, 3)), ((0, 2), (1, 3)), ((0, 3), (1, 2))]
    restrictions = 0
    for size in (2, 3):
        for selected in itertools.combinations(range(4), size):
            pair_rates = {pair: 0 for pair in itertools.combinations(selected, 2)}
            for pi in matchings:
                for block in pi:
                    kept = tuple(x for x in block if x in selected)
                    if len(kept) == 2:
                        pair_rates[kept] += 1
            assert all(rate == 1 for rate in pair_rates.values())
            restrictions += 1
    counterexamples["simultaneous_two_pairs"] = {
        "event_type": [2, 2], "total_event_rate_at_4": "3", "pair_budget": "6",
        "witness_mean": str(v[4]), "binary_mean": str(vk4[4]),
        "witness_second_moment": str(second[4]), "binary_second_moment": str(mk4[4]),
        "lower_mean_violation": str(vk4[4] - v[4]),
        "label_restrictions_checked": restrictions,
        "scope": "exchangeable family consistent only through sample size four; not an infinite Xi counterexample",
    }
    report["exact_examples"] = counterexamples

    positive_cases = 0
    for c2 in (F(1, 10**6), F(1), F(2), F(10**6)):
        c = {1: F(0), 2: c2}
        cond, _, _ = cones(c)
        assert all(slack == 0 for rows in cond.values() for _, _, slack in rows)
        v, second = moments(binary(2), c)
        assert v[2] == c2 and second[2] == 2 * c2**2
        positive_cases += 1
    rejected = 0
    for bad in (F(0), F(-1)):
        try:
            moments(binary(2), {1: F(0), 2: bad})
        except ValueError:
            rejected += 1
        else:
            raise AssertionError("Nonpositive transient cost should be rejected")
    report["cost_domain_boundary"] = {
        "N2_positive_cost_equalities": positive_cases,
        "nonpositive_transient_costs_rejected": rejected,
        "absorbing_state_cost": "0",
        "note": "c_b=0 for b>=2 is outside the theorem; no limiting cost-time generator is silently used.",
    }
    return report


def cost_generator(q, costs):
    n = max(costs)
    matrix = np.zeros((n - 1, n - 1))
    for b in range(2, n + 1):
        matrix[b - 2, b - 2] = -float(sum(q[b].values())) / float(costs[b])
        for m, rate in q[b].items():
            if m >= 2:
                matrix[b - 2, m - 2] += float(rate) / float(costs[b])
    return matrix


def numerical_suite(rng: random.Random):
    records = []
    n = 8
    points = [F(0), F(1, 7), F(1, 4), F(1, 2), F(2, 3), F(4, 5), F(1)]
    pair_chains = [("binary", binary(n)), ("star", star(n))]
    pair_chains += [("arbitrary_pair_budget", random_pair_chain(n, rng)) for _ in range(20)]
    for x in points:
        pair_chains.append(("pure_lambda", lambda_rates(n, [(x, F(1))])))
    for _ in range(20):
        raw = [rng.randrange(1, 10) for _ in points]
        measure = [(x, F(w, sum(raw))) for x, w in zip(points, raw)]
        pair_chains.append(("finite_lambda_mixture", lambda_rates(n, measure)))
    for power in (1, 2, 3):
        c = {1: F(0), **{b: F(b**power) for b in range(2, n + 1)}}
        for kind, q in pair_chains:
            records.append((kind, f"b^{power}", q, c, True, True))
    for _ in range(20):
        q, _ = random_simultaneous_chain(n, rng)
        c = {1: F(0), **{b: F(b**3) for b in range(2, n + 1)}}
        records.append(("arbitrary_simultaneous_partitions", "b^3", q, c, True, True))
        c_linear = {1: F(0), **{b: F(b) for b in range(2, n + 1)}}
        records.append(("arbitrary_simultaneous_partitions", "b", q, c_linear, False, True))
    for c in ({1: F(0), 2: F(2), 3: F(3), 4: F(37, 10)},
              {1: F(0), 2: F(2), 3: F(4), 4: F(5)}):
        cond, _, _ = cones(c)
        upper = all(s >= 0 for _, _, s in cond["U"])
        for _ in range(15):
            records.append(("arbitrary_pair_budget", "special_N4", random_pair_chain(4, rng), c, True, upper))

    fractions = np.array([0, 1e-8, 1e-5, 0.001, 0.01, 0.03, 0.1, 0.25,
                          0.5, 0.75, 1, 1.5, 2, 3, 4, 6, 8], dtype=float)
    max_errors = {"lower_order_violation": 0.0, "star_upper_violation": 0.0,
                  "mean_refined_upper_violation": 0.0,
                  "negative_stoploss": 0.0, "mean_equation_residual": 0.0,
                  "stoploss_derivative_identity_residual": 0.0,
                  "binary_explicit_transform_error": 0.0}
    checked = lower_checks = upper_checks = 0
    kinds = {}
    for kind, cost_name, q, c, lower, upper in records:
        size = max(c)
        A = cost_generator(q, c)
        v_exact, _ = moments(q, c)
        v = np.array([float(v_exact[b]) for b in range(2, size + 1)])
        cvec = np.array([float(c[b]) for b in range(2, size + 1)])
        vk_exact, _ = moments(binary(size), c)
        vk = np.array([float(vk_exact[b]) for b in range(2, size + 1)])
        Ak = cost_generator(binary(size), c)
        scale = max(1.0, float(np.max(cvec)), float(np.max(v)))
        tolerance = NUM_TOL * scale
        residual = float(np.max(np.abs(A @ v + np.ones(size - 1))))
        max_errors["mean_equation_residual"] = max(max_errors["mean_equation_residual"], residual)
        assert residual <= NUM_TOL
        kinds[kind] = kinds.get(kind, 0) + 1
        for s in fractions * np.max(cvec):
            semigroup = expm(s * A)
            W = semigroup @ v
            survival = semigroup @ np.ones(size - 1)
            Fk = expm(s * Ak) @ vk
            negative = float(max(0, -np.min(W)))
            derivative = float(np.max(np.abs(A @ W + survival)))
            max_errors["negative_stoploss"] = max(max_errors["negative_stoploss"], negative)
            max_errors["stoploss_derivative_identity_residual"] = max(
                max_errors["stoploss_derivative_identity_residual"], derivative)
            assert negative <= tolerance and derivative <= NUM_TOL * 10
            checked += size - 1
            if lower:
                error = float(max(0, np.max(Fk - W)))
                max_errors["lower_order_violation"] = max(max_errors["lower_order_violation"], error)
                assert error <= tolerance
                lower_checks += size - 1
            if upper:
                endpoint = cvec * np.exp(-s / cvec)
                refined = v * np.exp(-s / cvec)
                err1 = float(max(0, np.max(W - endpoint)))
                err2 = float(max(0, np.max(W - refined)))
                max_errors["star_upper_violation"] = max(max_errors["star_upper_violation"], err1)
                max_errors["mean_refined_upper_violation"] = max(max_errors["mean_refined_upper_violation"], err2)
                assert err1 <= tolerance and err2 <= tolerance
                upper_checks += size - 1
            if cost_name == "b^1":
                for b in range(2, size + 1):
                    explicit = 2 * sum(
                        (-1) ** (j + 1) * math.comb(b - 1, j) * math.exp(-j * s / 2) / j
                        for j in range(1, b)
                    )
                    err = abs(explicit - Fk[b - 2])
                    max_errors["binary_explicit_transform_error"] = max(
                        max_errors["binary_explicit_transform_error"], err)
                    assert err <= tolerance
    # Explicit survival crossing: icx cannot be upgraded to ordinary stochastic order.
    crossing = []
    for s in (F(1, 10), F(20)):
        t = float(s)
        ksurv = 2 * math.exp(-t / 2) - math.exp(-t)
        ssurv = math.exp(-t / 3)
        crossing.append({"threshold": str(s), "binary_survival": ksurv,
                         "star_survival": ssurv, "difference": ksurv - ssurv})
    assert crossing[0]["difference"] > 0 and crossing[1]["difference"] < 0
    return {
        "method": "scipy.linalg.expm on finite killed cost-time generators",
        "seed": SEED, "chain_cost_instances": len(records), "instances_by_family": kinds,
        "maximum_state": n, "thresholds_per_instance": len(fractions),
        "threshold_definition": "listed fractions times maximum transient state cost in each instance",
        "threshold_fractions": fractions.tolist(), "state_threshold_values": checked,
        "lower_comparisons": lower_checks, "upper_and_mean_refined_comparisons_each": upper_checks,
        "relative_scale_tolerance": NUM_TOL, "tolerance_rule": "2e-10 * max(1,max(c),max(v))",
        "max_absolute_errors_or_violations": max_errors,
        "ordinary_stochastic_order_crossing": crossing,
        "status": "all finite floating diagnostics within declared tolerance",
        "limitation": "Finite diagnostics, not proof; arbitrary infinite Xi models are not sampled or verified.",
    }


def power_threshold_suite():
    mp.mp.dps = 80
    alpha = mp.log(2) / mp.log(mp.mpf(4) / 3)
    identity_residual = abs(mp.power(mp.mpf(4) / 3, alpha) - 2)
    assert identity_residual < mp.mpf("1e-75")
    ratios = [math.log1p(2 / (b - 2)) / math.log1p(1 / (b - 1))
              for b in range(4, 10001)]
    assert all(x > y for x, y in zip(ratios, ratios[1:]))
    scans = []
    for offset in (-1e-6, 0.0, 1e-6):
        exponent = float(alpha) + offset
        n = 80
        a = {b: b**exponent / C(b) for b in range(2, n + 1)}
        h = {1: 0.0}
        for b in range(2, n + 1):
            h[b] = h[b - 1] + a[b]
        nontrivial_slacks = []
        for b in range(3, n + 1):
            for groups in range(1, b - 1):
                slack = wmin(b, groups) * a[b] - (h[b] - h[groups])
                nontrivial_slacks.append((slack, b, groups))
        minimum = min(nontrivial_slacks)
        critical = 4**exponent / 6 - 3**exponent / 3
        if offset < 0:
            assert critical < 0
        else:
            assert minimum[0] >= -1e-10
        scans.append({"alpha_offset": offset, "N": n,
                      "nontrivial_LS_inequalities": len(nontrivial_slacks),
                      "minimum_slack": minimum[0], "minimizer_b_K": list(minimum[1:]),
                      "four_block_two_pair_mean_gap": critical})
    power1 = []
    for exponent in (-1, 0, 0.5, 1, 1.5, 2):
        gap = 2**exponent + 3**exponent / 3 - 3**exponent
        assert gap > 0 if exponent < 1 else abs(gap) < 1e-12 if exponent == 1 else gap < 0
        power1.append({"alpha": exponent, "binary_minus_star_mean_at_n3": gap})
    return {
        "alpha_star_80_digit_evaluation": mp.nstr(alpha, 79),
        "identity_residual_80_digit_evaluation": mp.nstr(identity_residual, 10),
        "R_b_monotonicity_checked_for_b": [4, 10000], "R4": ratios[0], "R10000": ratios[-1],
        "LS_finite_scans": scans, "single_group_power_threshold_at_n3": power1,
        "limitation": "Threshold identities and finite scans diagnose the stated proof; they do not replace its all-n argument.",
    }


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", default="results.json")
    args = parser.parse_args()
    rng = random.Random(SEED)
    report = {
        "title": "Finite validation of increasing-convex cost comparisons",
        "seed": SEED, "exact": exact_suite(rng), "numerical": numerical_suite(rng),
        "power_threshold": power_threshold_suite(),
        "environment": {"python": platform.python_version(), "numpy": np.__version__,
                        "scipy": scipy.__version__, "mpmath": mp.__version__},
        "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "overall_status": "PASS: all stated finite checks completed",
        "scope_exclusions": ["No Lean code or compilation", "No proof of arbitrary infinite Xi models",
                             "Finite computed cases only"],
    }
    destination = Path(args.output)
    destination.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n")
    print(json.dumps({"output": str(destination.resolve()), "status": report["overall_status"],
                      "exact_cost_vectors": report["exact"]["cost_cones_exhaustive_finite_check"]["cost_vectors"],
                      "floating_instances": report["numerical"]["chain_cost_instances"],
                      "floating_state_threshold_values": report["numerical"]["state_threshold_values"],
                      "floating_max_errors": report["numerical"]["max_absolute_errors_or_violations"]},
                     indent=2))


if __name__ == "__main__":
    main()
