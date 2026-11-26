#!/usr/bin/env python3
"""Construct explicit finite odd profiles for the Euclidean median reduction.

This module implements the cyclic-orbit construction in exact_reduction.md.
Support sizes, multiplicities, and the median certificate are exact integers.
Input contact coordinates and radii are parsed as rational numbers. A real
coordinate is represented exactly by radius / sqrt(support_size).

The reported cost and ratio values use binary64 arithmetic and are diagnostics.
They do not certify a contact equation or solve the all-p contact branches.

Example:
    python geometric_witness.py --a 1/10 --b 1 --radius-a 3/2 \
        --radius-b 2 --dimension 20 --replications 3 --p 1.3 \
        --lambda-value 0.7 --check-explicit

Self-check:
    python geometric_witness.py --self-check
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass
from fractions import Fraction
import json
import math
from pathlib import Path
from typing import Iterator, Sequence


HALF = Fraction(1, 2)


def rational(value: str | int | Fraction) -> Fraction:
    """Parse fractions or finite decimal strings without binary64 rounding."""
    if isinstance(value, Fraction):
        return value
    return Fraction(value)


def floor_fraction(value: Fraction) -> int:
    return value.numerator // value.denominator


def ceil_fraction(value: Fraction) -> int:
    return -((-value.numerator) // value.denominator)


@dataclass(frozen=True)
class Orbit:
    support_size: int
    radius: Fraction
    base_copies: int


@dataclass(frozen=True)
class Profile:
    dimension: int
    replications: int
    orbits: tuple[Orbit, ...]
    construction: str

    @property
    def base_agents(self) -> int:
        return self.dimension * sum(orbit.base_copies for orbit in self.orbits)

    @property
    def agents(self) -> int:
        return self.replications * self.base_agents + 1

    @property
    def support_labels_per_coordinate(self) -> int:
        return self.replications * sum(
            orbit.base_copies * orbit.support_size for orbit in self.orbits
        )

    @property
    def positive_agents_per_coordinate(self) -> int:
        # A radius-zero vector has no positive coordinate, whatever its label.
        return self.replications * sum(
            orbit.base_copies * orbit.support_size
            for orbit in self.orbits if orbit.radius > 0
        )

    def integer_certificate(self) -> dict:
        half_base = (self.agents - 1) // 2
        assert self.dimension >= 2 and self.dimension % 2 == 0
        assert self.agents >= 3 and self.agents % 2 == 1
        assert self.support_labels_per_coordinate == half_base
        assert self.positive_agents_per_coordinate <= half_base
        return {
            "agents": self.agents,
            "odd": True,
            "base_agents": self.base_agents,
            "assigned_support_labels_per_coordinate":
                self.support_labels_per_coordinate,
            "strictly_positive_agents_per_coordinate":
                self.positive_agents_per_coordinate,
            "zero_agents_per_coordinate":
                self.agents - self.positive_agents_per_coordinate,
            "required_zeros_for_odd_median_zero": half_base + 1,
            "coordinate_median": "the zero vector",
            "proof": (
                "All coordinates are nonnegative. Each coordinate belongs to k "
                "of the d cyclic shifts of a support of size k. The stated "
                "integer count leaves at least (n+1)/2 zero coordinates."
            ),
        }

    def specification(self) -> dict:
        result = {
            "format": "euclidean-median-cyclic-profile-v1",
            "dimension": self.dimension,
            "replications": self.replications,
            "construction": self.construction,
            "reference": "each coordinate equals 1/sqrt(dimension)",
            "orbits": [
                {
                    "support_size": orbit.support_size,
                    "radius": str(orbit.radius),
                    "base_copies": orbit.base_copies,
                    "shifts": {"first": 0, "last": self.dimension - 1, "step": 1},
                    "coordinate_rule": (
                        "For shift t, coordinates (t+j) mod dimension, "
                        "j=0,...,support_size-1, equal radius/sqrt(support_size); "
                        "all other coordinates equal zero."
                    ),
                }
                for orbit in self.orbits
            ],
            "append_zero_vectors": 1,
            "integer_certificate": self.integer_certificate(),
        }
        return result

    def iter_points(self) -> Iterator[list[float]]:
        """Materialize the real formula in binary64, for small diagnostic checks."""
        d = self.dimension
        for _ in range(self.replications):
            for orbit in self.orbits:
                value = float(orbit.radius) / math.sqrt(orbit.support_size)
                for _ in range(orbit.base_copies):
                    for shift in range(d):
                        point = [0.0] * d
                        for j in range(orbit.support_size):
                            point[(shift + j) % d] = value
                        yield point
        yield [0.0] * d


def make_profile(
    a: str | Fraction,
    b: str | Fraction,
    radius_a: str | Fraction,
    radius_b: str | Fraction,
    dimension: int,
    replications: int = 1,
) -> Profile:
    """Build exact multiplicities from two support contacts around 1/2.

    At a=b=1/2, use radius_a. If exactly one contact equals 1/2, use
    its radius and discard the contact of zero mixing weight. For strict
    contacts a<1/2<b, use k_a=max(1,floor(d*a)) and k_b=ceil(d*b).
    In particular a=0 with radius_a>0 is approximated using k_a=1.
    """
    a, b = rational(a), rational(b)
    ra, rb = rational(radius_a), rational(radius_b)
    if not (0 <= a <= HALF <= b <= 1):
        raise ValueError("Require 0 <= a <= 1/2 <= b <= 1.")
    if ra < 0 or rb < 0:
        raise ValueError("Radii must be nonnegative.")
    if not isinstance(dimension, int) or dimension < 2 or dimension % 2:
        raise ValueError("Dimension must be an even integer at least 2.")
    if not isinstance(replications, int) or replications < 1:
        raise ValueError("Replications must be a positive integer.")
    d = dimension
    if a == HALF:
        profile = Profile(
            d, replications, (Orbit(d // 2, ra, 1),), "single contact at 1/2"
        )
    elif b == HALF:
        profile = Profile(
            d, replications, (Orbit(d // 2, rb, 1),), "single contact at 1/2"
        )
    else:
        if d < 4:
            raise ValueError("Strict two-contact construction needs dimension >= 4.")
        ka = max(1, floor_fraction(d * a))
        kb = ceil_fraction(d * b)
        copies_a, copies_b = kb - d // 2, d // 2 - ka
        assert 1 <= ka < d // 2 < kb <= d
        assert copies_a > 0 and copies_b > 0
        profile = Profile(
            d,
            replications,
            (Orbit(ka, ra, copies_a), Orbit(kb, rb, copies_b)),
            "two contacts with exact rational support balance",
        )
    profile.integer_certificate()
    return profile


def logsumexp(values: Sequence[float]) -> float:
    finite = [value for value in values if value != -math.inf]
    if not finite:
        return -math.inf
    largest = max(finite)
    return largest + math.log(math.fsum(math.exp(v - largest) for v in finite))


def power_term_log(count: int, value: float, p: float) -> float:
    if value == 0:
        return -math.inf
    return math.log(count) + p * math.log(value)


def finite_exp(value: float) -> float | None:
    if value == -math.inf:
        return 0.0
    if value > math.log(float.fromhex("0x1.fffffffffffffp+1023")):
        return None
    return math.exp(value)


def cost_diagnostics(profile: Profile, p: float, lambda_value: float | None = None) -> dict:
    if not math.isfinite(p) or p < 1:
        raise ValueError("p must be finite and at least 1.")
    if lambda_value is not None and not (0 <= lambda_value < 1):
        raise ValueError("lambda must lie in [0,1).")
    numerator_logs: list[float] = []
    denominator_logs: list[float] = [0.0]  # appended zero has distance 1 from f
    d = profile.dimension
    for orbit in profile.orbits:
        r = float(orbit.radius)
        if not math.isfinite(r) or (orbit.radius > 0 and r == 0):
            raise ValueError("Radius is outside the supported binary64 diagnostic range.")
        count = profile.replications * orbit.base_copies * d
        s = orbit.support_size / d
        # Stable formula for sqrt(r^2+1-2*r*sqrt(s)).
        distance = math.hypot(r - math.sqrt(s), math.sqrt(1.0 - s))
        numerator_logs.append(power_term_log(count, r, p))
        denominator_logs.append(power_term_log(count, distance, p))
    log_numerator = logsumexp(numerator_logs)
    log_denominator = logsumexp(denominator_logs)
    ratio = 0.0 if log_numerator == -math.inf else math.exp(
        (log_numerator - log_denominator) / p
    )
    result = {
        "arithmetic": "binary64 diagnostic; exact integer median certificate is separate",
        "p": p,
        "median_power_cost": finite_exp(log_numerator),
        "reference_power_cost": finite_exp(log_denominator),
        "log_median_power_cost": None if log_numerator == -math.inf else log_numerator,
        "log_reference_power_cost": log_denominator,
        "ratio_using_reference_cost": ratio,
        "ratio_interpretation": (
            "For a nonconstant profile, the actual approximation ratio is at least "
            "this reference-cost ratio because the optimal cost is no larger than "
            "the cost at the specified reference point."
        ),
        "profile_nonconstant": any(orbit.radius > 0 for orbit in profile.orbits),
    }
    if lambda_value is not None:
        log_scaled_numerator = (
            -math.inf
            if lambda_value == 0 or log_numerator == -math.inf
            else log_numerator + p * math.log(lambda_value)
        )
        scale = max(log_denominator, log_scaled_numerator)
        normalized_energy = (
            math.exp(log_denominator - scale)
            - (0.0 if log_scaled_numerator == -math.inf
               else math.exp(log_scaled_numerator - scale))
        )
        result["lambda"] = lambda_value
        result["energy_divided_by_larger_power_cost"] = normalized_energy
        result["energy_interpretation"] = (
            "Numerical value of (reference cost - lambda^p * median cost) "
            "divided by the larger of these two nonnegative quantities."
        )
    return result


def explicit_check(profile: Profile, p: float, entry_limit: int = 2_000_000) -> dict:
    """Check a small profile by directly computing its vectors and order statistics."""
    if profile.agents * profile.dimension > entry_limit:
        raise ValueError("Explicit check exceeds entry limit; use the integer certificate.")
    points = list(profile.iter_points())
    assert len(points) == profile.agents
    d, n = profile.dimension, profile.agents
    median = [sorted(point[j] for point in points)[n // 2] for j in range(d)]
    assert all(value == 0.0 for value in median)
    positive_counts = [sum(point[j] > 0 for point in points) for j in range(d)]
    assert all(count == profile.positive_agents_per_coordinate for count in positive_counts)
    reference_coordinate = 1.0 / math.sqrt(d)
    direct_numerator = math.fsum(math.hypot(*point) ** p for point in points)
    direct_denominator = math.fsum(
        math.hypot(*(value - reference_coordinate for value in point)) ** p
        for point in points
    )
    aggregate = cost_diagnostics(profile, p)
    expected_numerator = aggregate["median_power_cost"]
    expected_denominator = aggregate["reference_power_cost"]
    assert expected_numerator is not None and expected_denominator is not None
    numerator_error = abs(direct_numerator - expected_numerator) / max(1.0, direct_numerator)
    denominator_error = abs(direct_denominator - expected_denominator) / max(1.0, direct_denominator)
    assert numerator_error <= 1e-11
    assert denominator_error <= 1e-11
    return {
        "passed": True,
        "agents": n,
        "dimension": d,
        "p": p,
        "max_abs_coordinate_median": max(map(abs, median)),
        "strictly_positive_count_per_coordinate": positive_counts[0],
        "relative_numerator_error": numerator_error,
        "relative_denominator_error": denominator_error,
    }


def self_check() -> dict:
    cases = [
        ("zero_support_positive_radius", "0", "1", "2", "1/2", 12, 2),
        ("zero_radius", "1/4", "3/4", "0", "17/10", 12, 1),
        ("single_contact", "1/2", "1/2", "4/5", "4/5", 8, 3),
        ("left_contact_has_full_weight", "1/2", "1", "7/5", "2", 8, 1),
        ("right_contact_has_full_weight", "0", "1/2", "2", "7/5", 8, 1),
        ("strict_rational_contacts", "1/10", "7/10", "13/10", "11/5", 14, 2),
        ("both_radii_zero", "0", "1", "0", "0", 6, 1),
        ("p_2_to_4_anchor", "0", "1", "0", "2", 16, 3),
    ]
    checks = []
    for name, a, b, ra, rb, d, repetitions in cases:
        profile = make_profile(a, b, ra, rb, d, repetitions)
        for p in (1.0, 1.5, 2.0, 3.0, 4.0, 6.0):
            checks.append({"case": name, **explicit_check(profile, p)})
    return {
        "method": "direct vector enumeration versus aggregate formulas",
        "checks": checks,
        "all_passed": True,
        "count": len(checks),
        "scope": "geometric construction and median/count identities; no scalar-branch certification",
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--a", default="0")
    parser.add_argument("--b", default="1")
    parser.add_argument("--radius-a", default="0")
    parser.add_argument("--radius-b", default="2")
    parser.add_argument("--dimension", type=int, default=20)
    parser.add_argument("--replications", type=int, default=1)
    parser.add_argument("--p", type=float, default=2.0)
    parser.add_argument("--lambda-value", type=float)
    parser.add_argument("--check-explicit", action="store_true")
    parser.add_argument("--self-check", action="store_true")
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    if args.self_check:
        result = self_check()
    else:
        profile = make_profile(
            args.a, args.b, args.radius_a, args.radius_b,
            args.dimension, args.replications,
        )
        result = {
            "profile": profile.specification(),
            "costs": cost_diagnostics(profile, args.p, args.lambda_value),
        }
        if args.check_explicit:
            result["explicit_check"] = explicit_check(profile, args.p)
    output = json.dumps(result, indent=2, ensure_ascii=False, allow_nan=False) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(output, encoding="utf-8")
    else:
        print(output, end="")


if __name__ == "__main__":
    main()

