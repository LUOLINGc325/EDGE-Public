#!/usr/bin/env python3
"""Finite diagnostics for M-ary mean estimation; not a universal proof.

Only the Python standard library is required. Distribution, partition, and
encoder checks use exact fractions. The separate bit-budget grid uses binary64
and is explicitly labelled a numerical diagnostic.
"""

from __future__ import annotations

import argparse
from fractions import Fraction as F
from itertools import combinations
import json
from math import expm1, lcm, log, log2
from pathlib import Path


def rational(value: F) -> str:
    return str(value)


def require(condition: bool, message: str) -> None:
    if not condition:
        raise AssertionError(message)


def hard_pair(levels: int, epsilon: F) -> tuple[list[F], list[F], list[F]]:
    """The Lau--Scarlett geometric hard pair, written directly as two laws."""
    xs = [F(0)]
    p0 = [F(0)]
    p1 = [F(0)]
    for j in range(1, levels + 1):
        x = F(2**j)
        q = F(1, 2 * levels * 4**j)
        d = 3 * epsilon / (2 * levels * 2**j)
        xs.extend([-x, x])
        p0.extend([q, q])
        p1.extend([q - d, q + d])
    p0[0] = 1 - sum(p0[1:])
    p1[0] = p0[0]
    return xs, p0, p1


def partition_checks(levels: int, epsilon: F) -> dict:
    xs, p0, p1 = hard_pair(levels, epsilon)
    require(all(p > 0 for p in p0 + p1), "Positive atom masses")
    require(sum(p0) == sum(p1) == 1, "Probability mass normalization")
    mean0 = sum(x * p for x, p in zip(xs, p0))
    mean1 = sum(x * p for x, p in zip(xs, p1))
    second0 = sum(x * x * p for x, p in zip(xs, p0))
    second1 = sum(x * x * p for x, p in zip(xs, p1))
    raw_chi2 = sum((v - u) ** 2 / u for u, v in zip(p0, p1))
    require(mean0 == 0 and mean1 == 3 * epsilon, "Hard-pair means")
    require(second0 == second1 == 1, "Hard-pair second moments")
    require(raw_chi2 == 9 * epsilon**2, "Raw chi-square identity")

    # A common denominator makes recursive cell aggregation cheap and exact.
    deltas = [v - u for u, v in zip(p0, p1)]
    denominator = lcm(*(v.denominator for v in p0 + deltas))
    q_weights = [int(v * denominator) for v in p0]
    d_weights = [int(v * denominator) for v in deltas]
    counts: dict[int, int] = {}
    maxima: dict[int, F] = {}
    witnesses: dict[int, list[list[int]]] = {}
    total = 0
    block_q: list[int] = []
    block_d: list[int] = []
    block_indices: list[list[int]] = []

    def visit(index: int) -> None:
        nonlocal total
        if index == len(xs):
            m = len(block_q)
            chi2 = sum(
                (F(d * d, q * denominator) for q, d in zip(block_q, block_d)),
                F(0),
            )
            cell_bound = 36 * (m - 1) * epsilon**2 / levels
            require(chi2 <= cell_bound, f"M-cell bound at L={levels}, M={m}")
            require(chi2 <= raw_chi2, f"Raw-data bound at L={levels}, M={m}")
            counts[m] = counts.get(m, 0) + 1
            if m not in maxima or chi2 > maxima[m]:
                maxima[m] = chi2
                witnesses[m] = [list(block) for block in block_indices]
            total += 1
            return

        # Restricted-growth construction: every unlabeled set partition once.
        for block in range(len(block_q)):
            block_q[block] += q_weights[index]
            block_d[block] += d_weights[index]
            block_indices[block].append(index)
            visit(index + 1)
            block_indices[block].pop()
            block_d[block] -= d_weights[index]
            block_q[block] -= q_weights[index]
        block_q.append(q_weights[index])
        block_d.append(d_weights[index])
        block_indices.append([index])
        visit(index + 1)
        block_indices.pop()
        block_d.pop()
        block_q.pop()

    visit(0)
    expected_bell = {3: 877, 4: 21147}[levels]
    require(total == expected_bell, "Exhaustive partition count")
    # Independent Stirling-number recurrence audits the per-M counts.
    stirling = [1]
    for atom_count in range(1, len(xs) + 1):
        previous = stirling
        stirling = [0] * (atom_count + 1)
        for m in range(1, atom_count + 1):
            stirling[m] = previous[m - 1]
            if m < len(previous):
                stirling[m] += m * previous[m]
    require(all(counts[m] == stirling[m] for m in counts), "Stirling counts")
    by_m = []
    for m in sorted(counts):
        cell_bound = 36 * (m - 1) * epsilon**2 / levels
        by_m.append(
            {
                "M": m,
                "partition_count": counts[m],
                "maximum_chi_square": rational(maxima[m]),
                "M_cell_bound": rational(cell_bound),
                "maximum_ratio_to_M_cell_bound": (
                    rational(maxima[m] / cell_bound) if cell_bound else None
                ),
                "maximum_ratio_to_raw_bound": rational(maxima[m] / raw_chi2),
                "maximizing_partition_atom_indices": witnesses[m],
            }
        )
    return {
        "L": levels,
        "sigma": "1",
        "epsilon": rational(epsilon),
        "epsilon_choice": (
            "1/256, within the final manuscript epsilon range"
            if levels == 3
            else "1/(3*4^L)"
        ),
        "atom_count": len(xs),
        "atoms": [
            {"x": rational(x), "P0": rational(u), "P1": rational(v)}
            for x, u, v in zip(xs, p0, p1)
        ],
        "mean_P0": rational(mean0),
        "mean_P1": rational(mean1),
        "second_moment_P0": rational(second0),
        "second_moment_P1": rational(second1),
        "raw_chi_square": rational(raw_chi2),
        "partition_count": total,
        "expected_Bell_number": expected_bell,
        "by_output_alphabet_size": by_m,
        "status": "passed_exact_finite_enumeration",
    }


def layer_of(x: F, sigma: F, last_layer: int) -> tuple[int, F, int] | None:
    """Return (signed-layer index, endpoint magnitude, sign), excluding tails."""
    if x == 0 or abs(x) > sigma * 2**last_layer:
        return None
    magnitude = abs(x)
    layer = 0
    while magnitude > sigma * 2**layer:
        layer += 1
    sign = 1 if x > 0 else -1
    # Both central signs have their own public layer label.
    label = 2 * layer + (0 if sign > 0 else 1)
    return label, sigma * 2**layer, sign


def exact_encoder_case(name: str, law: dict[F, F]) -> dict:
    sigma = F(1)
    last_layer = 2
    radius = sigma * 2**last_layer
    layer_count = 2 * (last_layer + 1)
    require(sum(law.values()) == 1, "Encoder-law normalization")
    require(all(p >= 0 for p in law.values()), "Encoder-law nonnegativity")
    second = sum(x * x * p for x, p in law.items())
    require(second <= sigma**2, "Finite encoder law is in moment ball")
    mean = sum(x * p for x, p in law.items())
    truncated_mean = sum(x * p for x, p in law.items() if abs(x) <= radius)
    endpoint_moment = F(0)
    for x, px in law.items():
        info = layer_of(x, sigma, last_layer)
        if info is not None:
            _, endpoint, _ = info
            endpoint_moment += px * endpoint * abs(x)
    require(endpoint_moment <= 3 * sigma**2, "Center-plus-tail moment bound")
    require(abs(mean - truncated_mean) <= second / radius, "Truncation bound")

    rows = []
    for selected_count in range(1, layer_count + 1):
        public_subsets = list(combinations(range(layer_count), selected_count))
        subset_probability = F(1, len(public_subsets))
        first_out = F(0)
        second_out = F(0)
        transmission_probability = F(0)
        for selected in public_subsets:
            for x, px in law.items():
                info = layer_of(x, sigma, last_layer)
                if info is None:
                    continue
                label, endpoint, sign = info
                if label not in selected:
                    continue
                send_probability = abs(x) / endpoint
                require(0 <= send_probability <= 1, "Valid stochastic rounding")
                decoded = F(layer_count, selected_count) * sign * endpoint
                joint_probability = px * subset_probability * send_probability
                transmission_probability += joint_probability
                first_out += joint_probability * decoded
                second_out += joint_probability * decoded**2
        expected_second = F(layer_count, selected_count) * endpoint_moment
        upper_second = 3 * sigma**2 * F(layer_count, selected_count)
        require(0 <= transmission_probability <= 1, "Valid total message probability")
        require(first_out == truncated_mean, "Exact truncated unbiasedness")
        require(second_out == expected_second, "Exact second-moment identity")
        require(second_out <= upper_second, "Moment upper bound")
        rows.append(
            {
                "r": selected_count,
                "M_needed": selected_count + 1,
                "public_subset_count": len(public_subsets),
                "nonzero_symbol_probability": rational(transmission_probability),
                "decoded_mean": rational(first_out),
                "decoded_second_moment": rational(second_out),
                "predicted_second_moment": rational(expected_second),
                "second_moment_upper_bound": rational(upper_second),
            }
        )
    return {
        "name": name,
        "purpose": "Exact encoder identities at small J=2; not a PAC accuracy or sample-complexity experiment.",
        "law": [{"x": rational(x), "p": rational(p)} for x, p in sorted(law.items())],
        "sigma": rational(sigma),
        "last_layer_J": last_layer,
        "signed_layer_count_B": layer_count,
        "truncation_radius": rational(radius),
        "raw_mean": rational(mean),
        "raw_second_moment": rational(second),
        "truncated_mean": rational(truncated_mean),
        "truncation_bias": rational(abs(mean - truncated_mean)),
        "bias_upper_bound": rational(second / radius),
        "rows": rows,
        "status": "passed_exact_finite_sum",
    }


def encoder_checks() -> list[dict]:
    boundary_points = [F(-5), F(-4), F(-2), F(-1), F(-1, 2), F(1, 3), F(1), F(2), F(4), F(5)]
    boundary_law = {x: F(1, 256) for x in boundary_points}
    boundary_law[F(5)] = F(2, 256)
    boundary_law[F(0)] = 1 - sum(boundary_law.values())
    xs, _, alternative = hard_pair(3, F(1, 256))
    cases = [
        ("zero_atom", {F(0): F(1)}),
        ("small_asymmetric_center", {F(-1, 8): F(2, 5), F(1, 16): F(3, 5)}),
        ("dyadic_boundaries_and_asymmetric_truncated_tails", boundary_law),
        ("hard_pair_alternative_L3", dict(zip(xs, alternative))),
    ]
    return [exact_encoder_case(name, law) for name, law in cases]


def bit_budget_grid() -> dict:
    """A floating-point sanity check, deliberately separated from exact checks."""
    levels_grid = [3, 4, 5, 7, 8, 15, 16, 31, 32, 63, 64, 127, 128, 1023, 1024, 65535, 65536, 2**32]
    tolerance = 1e-12
    maximum_gap = float("-inf")
    maximum_ratio = 0.0
    worst_point = None
    count = 0
    for levels in levels_grid:
        crossover = log2(1 + levels)
        bit_grid = [j / 8 for j in range(513)] + [crossover]
        for bits in bit_grid:
            lhs = min(1.0, expm1(bits * log(2.0)) / levels)
            rhs = bits / crossover
            gap = lhs - rhs
            require(gap <= tolerance, "Numerical bit-budget chord diagnostic")
            if gap > maximum_gap:
                maximum_gap = gap
                worst_point = {"L": levels, "b": bits, "lhs": lhs, "rhs": rhs}
            if rhs > 0:
                maximum_ratio = max(maximum_ratio, lhs / rhs)
            count += 1
    return {
        "status": "passed_floating_point_diagnostic_only",
        "arithmetic": "IEEE-754 binary64; not an exact certificate or proof",
        "inequality": "min(1,(2^b-1)/L) <= b/log2(1+L)",
        "L_grid": levels_grid,
        "b_grid": "0,1/8,...,64 plus the exact floating-point crossover log2(1+L)",
        "grid_point_count": count,
        "tolerance": tolerance,
        "maximum_lhs_minus_rhs": maximum_gap,
        "maximum_ratio_when_rhs_positive": maximum_ratio,
        "worst_gap_point": worst_point,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--output",
        type=Path,
        default=Path(__file__).resolve().parents[1] / "results" / "finite_certificates.json",
    )
    args = parser.parse_args()
    partition_results = [partition_checks(3, F(1, 256)), partition_checks(4, F(1, 3 * 4**4))]
    encoder_results = encoder_checks()
    numerical_result = bit_budget_grid()
    result = {
        "schema_version": 1,
        "status": "passed",
        "scope": "Finite diagnostics only; do not replace the all-parameter written proofs.",
        "exact_arithmetic": "Python standard-library fractions.Fraction",
        "formal_proof_assistant_run": False,
        "hard_pair_partition_checks": partition_results,
        "random_subset_encoder_checks": encoder_results,
        "bit_budget_grid_diagnostic": numerical_result,
        "summary": {
            "enumerated_partitions": sum(x["partition_count"] for x in partition_results),
            "encoder_laws": len(encoder_results),
            "encoder_law_and_r_pairs": sum(len(x["rows"]) for x in encoder_results),
            "floating_point_grid_points": numerical_result["grid_point_count"],
        },
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print(json.dumps({"status": "passed", "output": str(args.output), **result["summary"]}, ensure_ascii=False))


if __name__ == "__main__":
    main()
