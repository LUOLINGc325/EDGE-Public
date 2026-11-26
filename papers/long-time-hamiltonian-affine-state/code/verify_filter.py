#!/usr/bin/env python3
"""Exact symbolic filter certificates and finite numerical checks.

The Fourier coefficient is integrated for a symbolic positive integer index.
The norm/time-moment formulas and rational cutoff inequalities are checked
algebraically. Frequency grids are explicitly only finite numerical evidence.
"""
from __future__ import annotations

from fractions import Fraction
import math
import numpy as np
import sympy as sp


def check(condition, message):
    if not condition:
        raise RuntimeError(message)


def ceil_sqrt_fraction(value):
    result = math.isqrt(value.numerator // value.denominator)
    if Fraction(result * result) < value:
        result += 1
    return result


def verify():
    x = sp.symbols("x", real=True)
    j = sp.symbols("j", integer=True, positive=True)
    left = x
    right = x - 4 / sp.pi * (x - sp.pi / 2)**2
    coefficient = sp.simplify(
        2 / sp.pi * (
            sp.integrate(left * sp.sin(j * x), (x, 0, sp.pi / 2))
            + sp.integrate(right * sp.sin(j * x), (x, sp.pi / 2, sp.pi))
        )
    )
    expected = 16 * (sp.cos(j * sp.pi / 2) - (-1)**j) / (sp.pi**2 * j**3)
    check(sp.simplify(coefficient - expected) == 0, "General Fourier coefficient failed")

    joining = {
        "value_at_zero": sp.simplify(left.subs(x, 0)),
        "value_at_period_endpoint": sp.simplify(right.subs(x, sp.pi)),
        "value_jump_at_half_period": sp.simplify(
            left.subs(x, sp.pi / 2) - right.subs(x, sp.pi / 2)
        ),
        "derivative_jump_at_half_period": sp.simplify(
            sp.diff(left, x).subs(x, sp.pi / 2)
            - sp.diff(right, x).subs(x, sp.pi / 2)
        ),
        "derivative_at_positive_endpoint": sp.simplify(
            sp.diff(right, x).subs(x, sp.pi)
        ),
    }
    for key in (
        "value_at_zero", "value_at_period_endpoint",
        "value_jump_at_half_period", "derivative_jump_at_half_period",
    ):
        check(joining[key] == 0, f"C1 periodic joining failed: {key}")
    check(joining["derivative_at_positive_endpoint"] == -3, "Endpoint derivative failed")

    # Sector sums use zeta(3) and the standard odd reciprocal-square identity.
    odd_cubes = sp.Rational(7, 8) * sp.zeta(3)
    norm_over_L = sp.simplify(
        32 / sp.pi**3 * (1 + sp.Rational(1, 4)) * odd_cubes
    )
    check(
        sp.simplify(norm_over_L - 35 * sp.zeta(3) / sp.pi**3) == 0,
        "Absolute coefficient norm failed",
    )
    first_time_moment = sp.simplify(
        16 / sp.pi**2 * (1 + sp.Rational(1, 2)) * sp.pi**2 / 8
    )
    check(first_time_moment == 3, "First absolute time moment must be exactly three")

    # These rational inequalities certify the elementary constants used in proof.
    norm_ratio_upper = Fraction(35 * 5, 4 * 27)  # zeta(3)<=5/4, pi^3>27
    pi_cubed_upper = Fraction(22, 7)**3
    tail_ratio_upper = Fraction(4, 27)
    check(norm_ratio_upper < 2, "C<2L bound failed")
    check(pi_cubed_upper < 32, "Mean duration bound failed")
    check(tail_ratio_upper < Fraction(1, 4), "Cutoff bias bound failed")

    first_coefficients = []
    for index in range(1, 21):
        actual = sp.simplify(coefficient.subs(j, index))
        sector = 1 if index % 2 else (-2 if index % 4 == 2 else 0)
        wanted = 16 * sector / (sp.pi**2 * index**3)
        check(sp.simplify(actual - wanted) == 0, f"Residue-class coefficient {index} failed")
        first_coefficients.append({"index": index, "value": str(actual), "verified": True})

    finite = []
    for bandwidth_q in (Fraction(1, 3), Fraction(1), Fraction(2), Fraction(17)):
        for ratio in (Fraction(1, 20), Fraction(1, 5), Fraction(1, 2)):
            epsilon_q = ratio * bandwidth_q
            cutoff = ceil_sqrt_fraction(8 * bandwidth_q / epsilon_q)
            check(
                Fraction(cutoff**2) >= 8 * bandwidth_q / epsilon_q,
                "Exact cutoff inequality failed",
            )
            masses = [
                Fraction(1 if index % 2 else (2 if index % 4 == 2 else 0), index**3)
                for index in range(1, cutoff + 1)
            ]
            mass = sum(masses)
            q = [item / mass for item in masses]
            check(sum(q) == 1 and all(v >= 0 for v in q), "Rational sampling law failed")
            check(all((q[index-1] == 0) == (index % 4 == 0)
                      for index in range(1, cutoff+1)), "Zero support mismatch")

            bandwidth, epsilon = float(bandwidth_q), float(epsilon_q)
            indices = np.arange(1, cutoff + 1, dtype=float)
            sectors = np.array(
                [1 if index % 2 else (-2 if index % 4 == 2 else 0)
                 for index in range(1, cutoff + 1)], float,
            )
            coefficients = (32 * bandwidth / math.pi**3) * sectors / indices**3
            shifts = indices * math.pi / (2 * bandwidth)
            frequencies = np.linspace(-bandwidth, bandwidth, 10001)
            grid_error = float(np.max(np.abs(
                np.sin(np.outer(frequencies, shifts)) @ coefficients - frequencies
            )))
            proved_tail = 32 * bandwidth / (math.pi**3 * cutoff**2)
            norm = float(np.abs(coefficients).sum())
            partial_time = float(np.dot(np.abs(coefficients), shifts))
            check(grid_error <= proved_tail + 1e-11, "Finite frequency grid exceeds proved tail")
            check(norm < 2 * bandwidth, "Finite coefficient norm exceeds upper bound")
            check(partial_time <= 3 + 1e-12, "Finite time moment exceeds full moment")
            finite.append({
                "L": str(bandwidth_q), "epsilon": str(epsilon_q), "cutoff": cutoff,
                "distribution_rational": True, "distribution_sum": str(sum(q)),
                "frequency_grid_points": len(frequencies),
                "maximum_grid_error": grid_error, "proved_tail_bound": proved_tail,
                "coefficient_norm": norm,
                "partial_first_absolute_time_moment": partial_time,
            })

    return {
        "status": "passed",
        "scope": (
            "Symbolic integration for every positive integer Fourier index; "
            "exact algebraic norm and first-moment identities; exact rational "
            "constant/cutoff checks. Frequency grids are finite numerical "
            "checks and are not used to prove the uniform spectral theorem."
        ),
        "symbolic_general_coefficient": str(coefficient),
        "symbolic_general_coefficient_verified": True,
        "C1_joining": {key: str(value) for key, value in joining.items()},
        "absolute_coefficient_norm_over_L": str(norm_over_L),
        "first_absolute_time_moment": str(first_time_moment),
        "rational_bounds": {
            "coefficient_norm_over_L_upper": str(norm_ratio_upper),
            "pi_cubed_upper_from_22_over_7": str(pi_cubed_upper),
            "tail_over_epsilon_upper": str(tail_ratio_upper),
        },
        "explicit_coefficients": first_coefficients,
        "finite_cases": len(finite),
        "finite_checks": finite,
    }


if __name__ == "__main__":
    import json
    print(json.dumps(verify(), indent=2))

