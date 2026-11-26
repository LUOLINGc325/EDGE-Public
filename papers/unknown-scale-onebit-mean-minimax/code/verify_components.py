#!/usr/bin/env python3
"""Finite exact checks for the unknown-scale one-bit mean-estimation proof.

Only the Python standard library is used. Every mathematical calculation and
comparison uses integers or fractions.Fraction. The script contains no Monte
Carlo experiments and draws no random numbers. All Rademacher coordinates that
affect each tested decoder are exhaustively enumerated; other bank coordinates
are analytically irrelevant because a fixed observation lies in at most one
grid cell.

These finite checks can expose implementation mistakes and counterexamples at
the tested parameters. They do NOT prove the universal mathematical theorem,
the Gaussian information inequality, a PAC guarantee, or global originality.

Usage:
    python3 code/verify_components.py --output results/verification.json
"""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
import platform
import sys
import time
from collections import Counter
from dataclasses import dataclass
from fractions import Fraction as F
from pathlib import Path
from typing import Any, Iterable


class CheckFailure(AssertionError):
    def __init__(self, label: str, context: dict[str, Any]):
        self.label = label
        self.context = context
        super().__init__(label)


class Ledger:
    def __init__(self) -> None:
        self.assertions = 0

    def check(self, condition: bool, label: str, **context: Any) -> None:
        self.assertions += 1
        if not condition:
            raise CheckFailure(label, context)


def exact_json(value: Any) -> Any:
    if isinstance(value, F):
        return {"numerator": value.numerator, "denominator": value.denominator}
    if isinstance(value, Cell):
        return {
            "level": value.level,
            "index": value.index,
            "base": value.base,
            "left": value.left,
            "right": value.right,
        }
    if isinstance(value, set):
        return sorted(value)
    raise TypeError(f"Cannot JSON-encode {type(value).__name__}")


def floor(x: F) -> int:
    return x.numerator // x.denominator


def ceil(x: F) -> int:
    return -floor(-x)


def clip(x: F, radius: F) -> F:
    return max(-radius, min(x, radius))


def floor_log2(x: F) -> int:
    if x <= 0:
        raise ValueError("floor_log2 needs a positive fraction")
    k = x.numerator.bit_length() - x.denominator.bit_length()
    power = F(2**k) if k >= 0 else F(1, 2 ** (-k))
    if power > x:
        k -= 1
    return k


@dataclass(frozen=True, order=True)
class Cell:
    level: int
    index: int
    base: F

    @property
    def length(self) -> F:
        return self.base * 2**self.level

    @property
    def left(self) -> F:
        return self.index * self.length

    @property
    def right(self) -> F:
        return (self.index + 1) * self.length

    def distance(self, center: F) -> F:
        # The infimum distance is zero at the excluded right endpoint too.
        return max(self.left - center, center - self.right, F(0))

    def contains(self, x: F) -> bool:
        return self.left <= x < self.right

    def meets_closed(self, low: F, high: F) -> bool:
        return self.left <= high and self.right > low

    def parent(self) -> "Cell":
        # Python integer // implements the required floor also for negatives.
        return Cell(self.level + 1, self.index // 2, self.base)


def bank(base: F, level: int, radius: F) -> tuple[Cell, ...]:
    length = base * 2**level
    low = -radius - 3 * length
    high = radius + 3 * length
    return tuple(
        Cell(level, j, base)
        for j in range(floor(low / length), floor(high / length) + 1)
    )


def cover(base: F, center: F, terminal_level: int) -> tuple[Cell, ...]:
    truncation = base * 2**terminal_level
    low, high = center - truncation, center + truncation
    selected: set[Cell] = set()
    for j in range(floor(low / base), floor(high / base) + 1):
        current = Cell(0, j, base)
        if current.distance(center) >= current.length:
            while True:
                parent = current.parent()
                if parent.distance(center) < parent.length:
                    break
                current = parent
                if current.level > terminal_level + 3:
                    raise CheckFailure(
                        "admissible ancestor search did not terminate",
                        {"base": base, "center": center, "m": terminal_level},
                    )
        selected.add(current)
    return tuple(sorted(selected, key=lambda c: (c.left, c.right)))


def filters(
    cells: Iterable[Cell], center: F, level: int
) -> tuple[Cell, ...]:
    if level == 0:
        return ()
    return tuple(c for c in cells if c.distance(center) < c.length)


def verify_geometry(ledger: Ledger) -> dict[str, Any]:
    stats: Counter[str] = Counter()
    max_cover_count = 0
    max_filter_count = 0
    max_endpoint_ratio = F(0)
    max_tail_ratio = F(0)
    min_bank_cardinality_slack: F | None = None
    min_strict_endpoint_slack: F | None = None
    base_values = (F(1, 3), F(1), F(5, 2))
    radius_multiples = (F(1), F(7, 2), F(9))
    for base, radius_multiple in itertools.product(base_values, radius_multiples):
        radius = base * radius_multiple
        center_indices = range(-floor(4 * radius_multiple), floor(4 * radius_multiple) + 1)
        for quarter_index in center_indices:
            center = base * F(quarter_index, 4)
            ledger.check(abs(center) <= radius, "center outside mean range")
            for m in range(7):
                stats["cover_parameter_cases"] += 1
                truncation = base * 2**m
                low, high = center - truncation, center + truncation
                selected = cover(base, center, m)
                stats["selected_cells_checked"] += len(selected)
                ledger.check(bool(selected), "empty cover")
                ledger.check(selected[0].left <= low, "left truncation not covered")
                ledger.check(selected[-1].right > high, "closed right truncation not covered")
                for left_cell, right_cell in zip(selected, selected[1:]):
                    ledger.check(
                        left_cell.right == right_cell.left,
                        "cover gap or overlap",
                        center=center,
                        m=m,
                        left=left_cell,
                        right=right_cell,
                    )
                for cell in selected:
                    ell = cell.length
                    ledger.check(cell.level <= m, "queried ancestor beyond terminal level")
                    ledger.check(cell.meets_closed(low, high), "selected cell misses window")
                    distance = cell.distance(center)
                    if distance >= ell:
                        ledger.check(distance < 3 * ell, "admissible cell too far", cell=cell)
                        ledger.check(
                            cell.parent().distance(center) < 2 * ell,
                            "selected admissible parent remains admissible",
                            cell=cell,
                        )
                    else:
                        ledger.check(cell.level == 0, "inadmissible nonfinest cover cell")
                    for endpoint in (cell.left, cell.right):
                        ratio = abs(endpoint - center) / ell
                        max_endpoint_ratio = max(max_endpoint_ratio, ratio)
                        slack = 4 * ell - abs(endpoint - center)
                        min_strict_endpoint_slack = (
                            slack if min_strict_endpoint_slack is None
                            else min(min_strict_endpoint_slack, slack)
                        )
                        ledger.check(slack > 0, "strict endpoint bound failed", cell=cell)
                        stats["cover_endpoint_checks"] += 1
                    ledger.check(
                        cell in bank(base, cell.level, radius),
                        "cover cell absent from pre-issued bank",
                        cell=cell,
                        radius=radius,
                    )
                for i in range(m + 1):
                    stats["level_geometry_cases"] += 1
                    ell = base * 2**i
                    grid_bank = bank(base, i, radius)
                    level_cover = tuple(c for c in selected if c.level == i)
                    level_filter = filters(grid_bank, center, i)
                    slack = 2 * radius / ell + 8 - len(grid_bank)
                    min_bank_cardinality_slack = (
                        slack if min_bank_cardinality_slack is None
                        else min(min_bank_cardinality_slack, slack)
                    )
                    ledger.check(slack >= 0, "bank cardinality exceeds bound")
                    max_cover_count = max(max_cover_count, len(level_cover))
                    max_filter_count = max(max_filter_count, len(level_filter))
                    ledger.check(len(level_cover) <= 9, "more than nine cover cells")
                    ledger.check(len(level_filter) <= 3, "more than three filter cells")
                    ledger.check(
                        not set(level_cover).intersection(level_filter),
                        "filter intersects selected cover",
                    )
                    if i > 0:
                        expected_count = 2 if center / ell == floor(center / ell) else 3
                        ledger.check(
                            len(level_filter) == expected_count,
                            "filter endpoint count differs",
                            center=center,
                            ell=ell,
                        )
                    for cell in grid_bank:
                        ledger.check(
                            cell.meets_closed(-radius - 3 * ell, radius + 3 * ell),
                            "bank contains a cell not meeting its closed window",
                        )
                probes: set[F] = {low, high, center, low - base / 8, high + base / 8}
                for cell in selected:
                    probes.update((cell.left, cell.right, (cell.left + cell.right) / 2))
                for x in probes:
                    membership = sum(cell.contains(x) for cell in selected)
                    ledger.check(membership <= 1, "probe double-counted by cover", x=x)
                    if low <= x <= high:
                        ledger.check(membership == 1, "closed-window probe omitted", x=x)
                    if membership == 0:
                        ledger.check(abs(x - center) > truncation, "omitted probe inside truncation")
                    stats["coverage_and_truncation_probes"] += 1
                z_values: set[F] = {F(0), base / 2, -base / 2}
                for i in range(m + 1):
                    ell = base * 2**i
                    for magnitude in (ell - base / 8, ell, ell + base / 8):
                        z_values.update((magnitude, -magnitude))
                for z in z_values:
                    tail_sum = sum(
                        ((base * 2**i) ** 2 for i in range(1, m + 1) if abs(z) >= base * 2**i),
                        F(0),
                    )
                    ledger.check(tail_sum <= F(4, 3) * z * z, "pointwise geometric tail bound")
                    if z:
                        max_tail_ratio = max(max_tail_ratio, tail_sum / (z * z))
                    truncated = abs(z) if abs(z) > truncation else F(0)
                    ledger.check(truncated <= z * z / truncation, "truncation moment inequality")
                    stats["pointwise_tail_and_bias_cases"] += 1
    return {
        "counts": dict(stats),
        "parameter_grid": {
            "base_values": base_values,
            "radius_over_base": radius_multiples,
            "centers": "every quarter-base grid point within each mean interval",
            "terminal_levels_inclusive": [0, 6],
        },
        "max_cover_cells_at_one_level": max_cover_count,
        "max_filter_cells_at_one_level": max_filter_count,
        "max_endpoint_distance_over_cell_length": max_endpoint_ratio,
        "min_strict_endpoint_slack": min_strict_endpoint_slack,
        "min_bank_cardinality_slack": min_bank_cardinality_slack,
        "max_geometric_tail_sum_over_squared_argument": max_tail_ratio,
        "claimed_tail_constant": F(4, 3),
    }


def exact_decoder_moments(
    ledger: Ledger,
    level_cover: tuple[Cell, ...],
    level_filter: tuple[Cell, ...],
    grid_bank: tuple[Cell, ...],
    center: F,
    x: F,
    zeta: F,
    orientation: str,
    stats: Counter[str],
) -> tuple[F, F, F]:
    sample_cell = next((cell for cell in grid_bank if cell.contains(x)), None)
    active = False
    if sample_cell is not None:
        split = sample_cell.left + zeta * sample_cell.length
        active = (
            sample_cell.left <= x < split if orientation == "left"
            else split <= x < sample_cell.right
        )
    weights = {
        cell: (cell.left if orientation == "left" else cell.right) - center
        for cell in level_cover
    }
    p_filter = F(1, 2 ** len(level_filter))
    relevant = set(level_cover).union(level_filter)
    if sample_cell is not None:
        relevant.add(sample_cell)
    variables = tuple(sorted(relevant))
    position = {cell: index for index, cell in enumerate(variables)}
    first_sum = F(0)
    second_sum = F(0)
    nonzero_values = 0
    for signs in itertools.product((-1, 1), repeat=len(variables)):
        h = all(signs[position[cell]] == -1 for cell in level_filter)
        y = active and sample_cell is not None and signs[position[sample_cell]] == 1
        value = F(0)
        if h and y:
            weighted_sum = sum(
                (weight * signs[position[cell]] for cell, weight in weights.items()), F(0)
            )
            value = 2 * weighted_sum / p_filter
        first_sum += value
        second_sum += value * value
        if value:
            nonzero_values += 1
            if grid_bank[0].level > 0:
                ledger.check(
                    abs(x - center) >= grid_bank[0].length,
                    "nonzero decoder inside filtered near region",
                    x=x,
                    center=center,
                )
    assignments = 2 ** len(variables)
    first, second = first_sum / assignments, second_sum / assignments
    eligible = active and sample_cell not in level_filter
    expected_first = weights.get(sample_cell, F(0)) if eligible else F(0)
    expected_second = (
        2 / p_filter * sum((weight * weight for weight in weights.values()), F(0))
        if eligible else F(0)
    )
    ledger.check(
        first == expected_first,
        "Rademacher first moment identity",
        x=x, center=center, zeta=zeta, direction=orientation,
        actual=first, expected=expected_first,
    )
    ledger.check(
        second == expected_second,
        "Rademacher second moment identity",
        x=x, center=center, zeta=zeta, direction=orientation,
        actual=second, expected=expected_second,
    )
    ell = grid_bank[0].length
    tail_indicator = grid_bank[0].level == 0 or abs(x - center) >= ell
    bound = 2304 * ell * ell if tail_indicator else F(0)
    ledger.check(second <= bound, "tail-local conditional second-moment bound")
    if sample_cell is None:
        category = "outside_bank"
    elif not active:
        category = "inactive_subinterval"
    elif sample_cell in level_filter:
        category = "active_filter"
    elif sample_cell in level_cover:
        category = "active_cover"
    else:
        category = "active_noncover_unfiltered"
    stats[category] += 1
    stats["conditional_moment_cases"] += 1
    stats["sign_assignments_enumerated"] += assignments
    stats["nonzero_decoder_values"] += nonzero_values
    stats["left_orientation_cases" if orientation == "left" else "right_orientation_cases"] += 1
    stats["maximum_relevant_sign_count"] = max(stats["maximum_relevant_sign_count"], len(variables))
    return first, second, second / (ell * ell)


def verify_rademacher(ledger: Ledger) -> dict[str, Any]:
    stats: Counter[str] = Counter()
    max_second_ratio = F(0)
    configurations = (
        (F(1), F(0), 3, F(4)),
        (F(2, 3), F(-1, 2), 3, F(5)),
        (F(5, 4), F(3, 2), 2, F(4)),
        (F(1), F(-2), 0, F(3)),
    )
    for base, center, m, radius in configurations:
        selected = cover(base, center, m)
        for level in range(m + 1):
            stats["geometric_configurations"] += 1
            ell = base * 2**level
            grid_bank = bank(base, level, radius)
            level_cover = tuple(c for c in selected if c.level == level)
            level_filter = filters(grid_bank, center, level)
            if not level_cover:
                stats["empty_cover_levels"] += 1
            noncover = tuple(c for c in grid_bank if c not in level_cover and c not in level_filter)
            chosen_cells = list(level_cover)
            if level_filter:
                chosen_cells.extend((level_filter[0], level_filter[-1]))
            if noncover:
                chosen_cells.extend((noncover[0], noncover[-1]))
            chosen_cells = sorted(set(chosen_cells))
            conditional_cases: set[tuple[F, F, str]] = set()
            for cell in chosen_cells:
                for zeta in (F(0), F(1, 3), F(1, 2), F(1)):
                    split = cell.left + zeta * ell
                    points = (cell.left, split, cell.right - ell / 5, cell.right)
                    for x, orientation in itertools.product(points, ("left", "right")):
                        conditional_cases.add((x, zeta, orientation))
            for x in (grid_bank[0].left - ell / 3, grid_bank[-1].right, grid_bank[-1].right + ell / 3):
                for orientation in ("left", "right"):
                    conditional_cases.add((x, F(1, 3), orientation))
            for x, zeta, orientation in sorted(conditional_cases):
                _, _, ratio = exact_decoder_moments(
                    ledger, level_cover, level_filter, grid_bank,
                    center, x, zeta, orientation, stats,
                )
                max_second_ratio = max(max_second_ratio, ratio)

            # Exact integration over the uniform split: the fixed-x integrand
            # changes only at the rational relative position within its cell.
            integration_points: set[F] = {grid_bank[0].left - ell / 3, grid_bank[-1].right}
            for cell in chosen_cells:
                integration_points.update((cell.left, cell.left + ell / 3, cell.right))
            for x in sorted(integration_points):
                sample_cell = next((c for c in grid_bank if c.contains(x)), None)
                knots = {F(0), F(1)}
                if sample_cell is not None:
                    knots.add((x - sample_cell.left) / ell)
                ordered_knots = sorted(knots)
                integrated_first = F(0)
                for left, right in zip(ordered_knots, ordered_knots[1:]):
                    if left == right:
                        continue
                    zeta = (left + right) / 2
                    for orientation in ("left", "right"):
                        first, _, ratio = exact_decoder_moments(
                            ledger, level_cover, level_filter, grid_bank,
                            center, x, zeta, orientation, stats,
                        )
                        integrated_first += (right - left) * first
                        max_second_ratio = max(max_second_ratio, ratio)
                        stats["split_integration_piece_orientation_cases"] += 1
                expected = x - center if any(c.contains(x) for c in level_cover) else F(0)
                ledger.check(
                    integrated_first == expected,
                    "uniform-split two-orientation unbiasedness",
                    x=x, center=center, level=level,
                    actual=integrated_first, expected=expected,
                )
                stats["uniform_split_integrations"] += 1
    for category in (
        "active_cover", "active_noncover_unfiltered", "active_filter",
        "inactive_subinterval", "outside_bank",
    ):
        ledger.check(stats[category] > 0, "missing Rademacher test category", category=category)
    return {
        "counts": dict(stats),
        "configurations_base_center_terminal_radius": configurations,
        "arithmetic": "complete exact sign enumeration and exact piecewise uniform-split integration",
        "max_conditional_second_moment_over_cell_length_squared": max_second_ratio,
        "claimed_second_moment_constant": 2304,
        "minimum_normalized_second_moment_margin": 2304 - max_second_ratio,
        "maximum_first_moment_identity_error": F(0),
        "maximum_second_moment_identity_error": F(0),
        "maximum_uniform_split_identity_error": F(0),
        "irrelevant_bank_signs": "summed out exactly; only signs affecting the fixed-sample decoder are enumerated",
    }


def verify_hard_pairs(ledger: Ledger) -> dict[str, Any]:
    stats: Counter[str] = Counter()
    per_pair = []
    max_ratio = F(0)
    min_margin: F | None = None
    worst_case: dict[str, Any] | None = None
    for m in range(1, 7):
        multipliers = [F(9, 16), F(3, 4), F(15, 16)]
        if m >= 2:
            multipliers.append(F(1))
        for multiplier in multipliers:
            t = multiplier / 2 ** (m + 1)
            # tau=1, a=t. Actual s^2=1-t^2, and r^2=t^2/[4(1-t^2)].
            s_squared = 1 - t * t
            r_squared = t * t / (4 * s_squared)
            ledger.check(r_squared <= F(1, 64), "hard pair outside r<=1/8 range")
            ledger.check(floor_log2(1 / (2 * t)) == m, "hard-pair M definition")
            support = [F(0)]
            plus = [F(1)]
            minus = [F(1)]
            for j in range(1, m + 1):
                x = F(2**j)
                q = F(1, 2 * m * 4**j)
                d = t / (2 * m * x)
                ledger.check(0 < d <= q / 2, "invalid hard-pair mass ratio")
                support.extend((x, -x))
                plus.extend((q + d, q - d))
                minus.extend((q - d, q + d))
                plus[0] -= 2 * q
                minus[0] -= 2 * q
            ledger.check(sum(plus) == sum(minus) == 1, "hard-pair normalization")
            ledger.check(plus[0] == minus[0] and plus[0] >= F(2, 3), "hard-pair atom at zero")
            ledger.check(all(p > 0 for p in plus + minus), "hard-pair nonpositive atom")
            means = []
            variances = []
            for masses, mean_target in ((plus, t), (minus, -t)):
                mean = sum((x * p for x, p in zip(support, masses)), F(0))
                raw_second = sum((x * x * p for x, p in zip(support, masses)), F(0))
                variance = sum(((x - mean) ** 2 * p for x, p in zip(support, masses)), F(0))
                ledger.check(mean == mean_target, "hard-pair mean")
                ledger.check(raw_second == 1, "hard-pair raw second moment")
                ledger.check(variance == s_squared, "hard-pair exact actual variance")
                means.append(mean)
                variances.append(variance)
                stats["distribution_moment_checks"] += 1
            bound = 32 * t * t / m
            subset_count = 2 ** len(support)
            subset_plus = [F(0)] * subset_count
            subset_minus = [F(0)] * subset_count
            pair_maximum = F(0)
            pair_max_ratio = F(0)
            for mask in range(subset_count):
                if mask:
                    low_bit = mask & -mask
                    index = low_bit.bit_length() - 1
                    prior = mask ^ low_bit
                    subset_plus[mask] = subset_plus[prior] + plus[index]
                    subset_minus[mask] = subset_minus[prior] + minus[index]
                p, q = subset_plus[mask], subset_minus[mask]
                if q == 0 or q == 1:
                    ledger.check(p == q, "singular Bernoulli query with differing supports")
                    chi_squared = F(0)
                    stats["constant_queries"] += 1
                else:
                    chi_squared = (p - q) ** 2 / (q * (1 - q))
                ledger.check(
                    chi_squared <= bound,
                    "all-support-set binary chi-square upper bound",
                    m=m, t=t, mask=mask, actual=chi_squared, bound=bound,
                )
                ratio = chi_squared / bound
                margin = bound - chi_squared
                pair_maximum = max(pair_maximum, chi_squared)
                pair_max_ratio = max(pair_max_ratio, ratio)
                min_margin = margin if min_margin is None else min(min_margin, margin)
                if ratio > max_ratio:
                    max_ratio = ratio
                    worst_case = {
                        "M": m, "a_over_tau": t,
                        "selected_support": [x for i, x in enumerate(support) if mask & (1 << i)],
                        "chi_squared": chi_squared, "upper_bound": bound,
                    }
                stats["binary_support_set_queries"] += 1
            stats["hard_distribution_pairs"] += 1
            per_pair.append({
                "M": m, "a_over_tau": t, "support_size": len(support),
                "query_subsets_enumerated": subset_count, "means": means,
                "actual_variances": variances, "r_squared": r_squared,
                "max_chi_squared": pair_maximum, "bound": bound,
                "max_ratio_to_bound": pair_max_ratio,
            })
    return {
        "counts": dict(stats),
        "per_pair": per_pair,
        "max_chi_squared_to_claimed_bound_ratio": max_ratio,
        "minimum_absolute_bound_margin": min_margin,
        "minimum_normalized_bound_margin": 1 - max_ratio,
        "worst_case": worst_case,
        "KL_scope": "KL is not evaluated numerically; the exactly checked chi-square bound implies its standard upper bound",
    }


def residue_encode(x: F, shift: F, base: F, level: int) -> int:
    return floor((x + shift) / base) % (2**level)


def nearest_lift(representative: F, center: F, period: F) -> F:
    k = floor((center - representative) / period + F(1, 2))
    return representative + k * period


def exact_square_wave_mismatch(mu: F, x: F, ell: F) -> F:
    period = 2 * ell
    knots = {F(0), period}
    for location in (mu, x):
        first = floor(location / ell) - 1
        last = floor((location + period) / ell) + 1
        for k in range(first, last + 1):
            boundary = k * ell - location
            if 0 < boundary < period:
                knots.add(boundary)
    ordered = sorted(knots)
    mismatch_length = F(0)
    for left, right in zip(ordered, ordered[1:]):
        shift = (left + right) / 2
        left_bit = floor((mu + shift) / ell) % 2
        right_bit = floor((x + shift) / ell) % 2
        if left_bit != right_bit:
            mismatch_length += right - left
    return mismatch_length / period


def verify_periodic(ledger: Ledger) -> dict[str, Any]:
    stats: Counter[str] = Counter()
    max_high_bit_error_ratio = F(0)
    min_nearest_lift_gap: F | None = None
    max_mismatch_bound_ratio = F(0)
    for base, level in itertools.product((F(1, 3), F(1), F(5, 2)), (4, 6, 11)):
        modulus = 2**level
        period = modulus * base
        radius = 4 * period
        means = sorted({
            -radius, -radius + base / 3, -3 * period, -period,
            -period + base / 3, -base / 3, F(0), base / 3,
            period - base / 3, period, period + base / 3,
            3 * period, radius - base / 3, radius,
        })
        for mu in means:
            boundary_shift = -mu - base * floor(-mu / base)
            shifts = sorted({
                F(0), base / 3, base / 2, period / 2,
                period - base / 2, period - base / 3, boundary_shift,
            })
            for shift in shifts:
                ledger.check(0 <= shift < period, "shift outside half-open period")
                raw = floor((mu + shift) / base)
                residue = raw % modulus
                ledger.check(0 <= residue < modulus, "negative floor modulo overflow")
                rebuilt = sum(((residue >> j) & 1) * 2**j for j in range(level))
                ledger.check(rebuilt == residue, "binary residue reconstruction")
                stats["floor_modulo_reconstruction_cases"] += 1
                for sample in (mu, -radius, radius, -2 * radius, 2 * radius):
                    encoded = residue_encode(clip(sample, radius), shift, base, level)
                    ledger.check(0 <= encoded < modulus, "clipped sample residue overflow")
                    stats["clipped_endpoint_encoding_cases"] += 1
                for q in sorted({0, 1, 2, 3, min(4, level - 1), level - 1}):
                    low_modulus = 2**q
                    low_values = (
                        range(low_modulus) if q <= 4
                        else sorted({0, 1, low_modulus // 2, low_modulus - 2, low_modulus - 1})
                    )
                    for low_value in low_values:
                        decoded_residue = (residue // low_modulus) * low_modulus + low_value
                        ledger.check(0 <= decoded_residue < modulus, "corrupted low bits overflow")
                        ledger.check(
                            all(((decoded_residue >> j) & 1) == ((residue >> j) & 1)
                                for j in range(q, level)),
                            "constructed high bits do not agree",
                        )
                        representative = base * decoded_residue - shift
                        true_lift = representative + (raw // modulus) * period
                        error = abs(true_lift - mu)
                        ell = base * low_modulus
                        ledger.check(error < ell, "high-bit lift distance bound", mu=mu, shift=shift, q=q)
                        max_high_bit_error_ratio = max(max_high_bit_error_ratio, error / ell)
                        stats["high_bit_lift_cases"] += 1
                        for center in (
                            clip(mu - period / 8, radius), mu,
                            clip(mu + period / 8, radius),
                        ):
                            if abs(true_lift - center) < period / 2:
                                lifted = nearest_lift(representative, center, period)
                                ledger.check(lifted == true_lift, "nearest-lift uniqueness")
                                gap = period / 2 - abs(true_lift - center)
                                min_nearest_lift_gap = (
                                    gap if min_nearest_lift_gap is None else min(min_nearest_lift_gap, gap)
                                )
                                ledger.check(
                                    abs(clip(lifted, radius) - mu) <= error,
                                    "projection increases mean error",
                                )
                                stats["unique_nearest_lift_cases"] += 1
                            if abs(center - mu) + ell < period / 2:
                                ledger.check(
                                    nearest_lift(representative, center, period) == true_lift,
                                    "coarse-radius sufficient condition for lift",
                                )
                                stats["coarse_radius_sufficient_condition_cases"] += 1
                        for sign in (-1, 1):
                            near_tie = true_lift + sign * (period / 2 - base / 7)
                            ledger.check(
                                nearest_lift(representative, near_tie, period) == true_lift,
                                "near-tie nearest-lift case",
                            )
                            tie = true_lift + sign * period / 2
                            expected = true_lift if sign == -1 else true_lift + period
                            ledger.check(
                                nearest_lift(representative, tie, period) == expected,
                                "specified exact-tie rounding convention",
                            )
                            stats["near_tie_and_exact_tie_pairs"] += 1
                for multiple in (-3, -1, 0, 1, 3):
                    ledger.check(
                        residue_encode(mu + multiple * period, shift, base, level) == residue,
                        "unclipped periodic encoder identity",
                    )
                    stats["unclipped_period_identity_cases"] += 1

    # Integrate the bit mismatch over one complete square-wave period exactly.
    # A full shift period D is an integer multiple of every such period.
    for base, level in itertools.product((F(1, 3), F(1), F(5, 2)), (3, 4, 6)):
        period = base * 2**level
        for mu in (-2 * period, -period + base / 3, -base / 2, F(0), base / 3, period):
            differences = (
                F(0), base / 3, -base / 3, base, -base,
                3 * base / 2, -3 * base / 2,
                period / 2, period - base / 3, period + base / 3,
            )
            for difference in differences:
                x = mu + difference
                for j in range(level):
                    ell = base * 2**j
                    exact_probability = exact_square_wave_mismatch(mu, x, ell)
                    bound = min(F(1), abs(difference) / ell)
                    ledger.check(
                        exact_probability <= bound,
                        "uniform-shift bit mismatch bound",
                        mu=mu, x=x, ell=ell,
                    )
                    shift_residue = difference - 2 * ell * floor(difference / (2 * ell))
                    triangular_probability = min(shift_residue, 2 * ell - shift_residue) / ell
                    ledger.check(
                        exact_probability == triangular_probability,
                        "exact square-wave mismatch measure",
                    )
                    if bound:
                        max_mismatch_bound_ratio = max(max_mismatch_bound_ratio, exact_probability / bound)
                    stats["exact_uniform_shift_mismatch_integrals"] += 1
    return {
        "counts": dict(stats),
        "max_high_bit_lift_error_over_ell_q": max_high_bit_error_ratio,
        "min_nearest_lift_distance_to_half_period_boundary": min_nearest_lift_gap,
        "max_exact_mismatch_probability_over_bound": max_mismatch_bound_ratio,
        "negative_integer_convention": "floor, then Euclidean residue in [0,2^L)",
        "tie_rule": "floor((center-representative)/D+1/2); exact ties select the larger lift",
        "low_bit_enumeration": "all patterns for q<=4; five boundary/middle patterns for larger q",
    }


def verify_coarse_code_scores(ledger: Ledger) -> dict[str, Any]:
    stats: Counter[str] = Counter()
    for n in range(1, 7):
        mass_vectors = [
            [F(1, n)] * n,
            [F(1)] + [F(0)] * (n - 1),
            [F(2**j, 2**n - 1) for j in range(n)],
        ]
        for probabilities in mass_vectors:
            for candidate in range(n):
                total = F(0)
                for row in itertools.product((0, 1), repeat=n):
                    total += sum(
                        (p for j, p in enumerate(probabilities) if row[j] != row[candidate]), F(0)
                    )
                    stats["code_row_candidate_enumerations"] += 1
                mean = total / 2**n
                ledger.check(
                    mean == (1 - probabilities[candidate]) / 2,
                    "coarse-code exact population score",
                )
                stats["population_score_cases"] += 1
    threshold = F(43, 108)
    gap = F(5, 108)
    ledger.check(threshold - F(19, 54) == gap, "coarse anchor threshold gap")
    ledger.check(F(4, 9) - threshold == gap, "coarse far-bin threshold gap")
    ledger.check(2 * gap * gap == F(25, 5832), "coarse Hoeffding exponent")
    return {
        "counts": dict(stats),
        "threshold": threshold,
        "one_sided_gap": gap,
        "hoeffding_exponent_coefficient": 2 * gap * gap,
        "scope": "exact finite random-code population scores and rational constants; no numerical concentration approximation",
    }


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, help="write the same JSON report to this path")
    args = parser.parse_args()
    started = time.perf_counter()
    ledger = Ledger()
    report: dict[str, Any] = {
        "status": "running",
        "verification_kind": "deterministic finite exact arithmetic checks",
        "arithmetic": "Python integers and fractions.Fraction; no random sampling",
        "scope_warning": (
            "Finite calculations do not prove universal geometric or probabilistic assertions. "
            "This run is reproducible component validation, not a formal proof or empirical PAC certification."
        ),
        "not_verified_by_this_script": [
            "all real parameter values and arbitrary probability distributions",
            "Gaussian smoothing, heat-entropy integration, or the scale-integrated information bound",
            "universal confidence guarantees or the full minimax theorem",
            "novelty, significance, or completeness of the literature search",
        ],
        "python_version": platform.python_version(),
        "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "sections": {},
    }
    sections = (
        ("dyadic_geometry", verify_geometry),
        ("rademacher_decoder", verify_rademacher),
        ("equal_variance_hard_pairs", verify_hard_pairs),
        ("periodic_localizer", verify_periodic),
        ("coarse_random_code", verify_coarse_code_scores),
    )
    try:
        for name, function in sections:
            report["sections"][name] = function(ledger)
        report["status"] = "passed"
    except CheckFailure as failure:
        report["status"] = "failed"
        report["counterexample"] = {
            "check": failure.label,
            "context": failure.context,
        }
    report["assertions_checked"] = ledger.assertions
    report["elapsed_seconds_metadata_only"] = time.perf_counter() - started
    serialized = json.dumps(report, default=exact_json, ensure_ascii=False, indent=2)
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(serialized + "\n", encoding="utf-8")
    print(serialized)
    return 0 if report["status"] == "passed" else 1


if __name__ == "__main__":
    sys.exit(main())
