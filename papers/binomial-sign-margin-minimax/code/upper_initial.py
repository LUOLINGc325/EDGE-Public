#!/usr/bin/env python3
"""Initial upper-bound diagnostics; this is not a proof of a minimax rate.

Jackson inverse coefficients are computed as exact rational multiples of 4/pi.
Polynomial reproduction and antisymmetry are checked in rational arithmetic.
Binomial second moments, running maxima and exponent comparisons use IEEE
double arithmetic. Their printed values and mesh brackets are NOT certified
interval-arithmetic certificates. The analytic mesh bound is proved in the
companion manuscript, but rounding error is not enclosed by this script.

Run from any directory:
  python code/upper_initial.py --output results/upper_initial.json
The default modest grid is sufficient for this initial research checkpoint.
"""

from __future__ import annotations

import argparse
from fractions import Fraction
from functools import lru_cache
import json
import math
from pathlib import Path

import numpy as np
from scipy.stats import binom


def convolution(a: list[int], b: list[int]) -> list[int]:
    out = [0] * (len(a) + len(b) - 1)
    for i, x in enumerate(a):
        for j, y in enumerate(b):
            out[i + j] += x * y
    return out


def jackson_weights(degree_budget: int, r: int) -> tuple[int, list[Fraction]]:
    """Fourier coefficients of the normalized r-th power of a Fejer kernel.

    The sign approximant is (4/pi) sum_{j odd} w[j] (-1)^((j-1)/2) T_j/j.
    Its degree is at most d=r*(m-1)<=degree_budget and its norm is at most one
    by positive normalized convolution, a known Jackson construction.
    """
    m = 1 + degree_budget // r
    if m < 2:
        return 0, [Fraction(0)]
    triangular = [m - abs(j) for j in range(-(m - 1), m)]
    powered = [1]
    for _ in range(r):
        powered = convolution(powered, triangular)
    d = r * (m - 1)
    normalizer = powered[d]
    return d, [Fraction(powered[d + j], normalizer) for j in range(d + 1)]


@lru_cache(maxsize=None)
def chebyshev_bernstein(n: int, j: int) -> tuple[Fraction, ...]:
    """Exact coefficients of T_j(2p-1) in the degree-n Bernstein basis."""
    assert 0 <= j <= n
    row = []
    n_choose = [math.comb(n, k) for k in range(n + 1)]
    small_choose = [math.comb(n - j, k) for k in range(n - j + 1)]
    even_choose = [math.comb(2 * j, 2 * ell) for ell in range(j + 1)]
    for k in range(n // 2 + 1):
        lo, hi = max(0, k - (n - j)), min(j, k)
        numerator = sum(
            (-1 if (j - ell) % 2 else 1)
            * even_choose[ell]
            * small_choose[k - ell]
            for ell in range(lo, hi + 1)
        )
        row.append(Fraction(numerator, n_choose[k]))
    parity = -1 if j % 2 else 1
    return tuple(row + [parity * row[n - k] for k in range(len(row), n + 1)])


@lru_cache(maxsize=None)
def jackson_inverse(n: int, degree_budget: int, r: int):
    d, weights = jackson_weights(degree_budget, r)
    rational = [Fraction(0) for _ in range(n + 1)]
    for j in range(1, d + 1, 2):
        multiplier = weights[j] * Fraction((-1) ** ((j - 1) // 2), j)
        for k, value in enumerate(chebyshev_bernstein(n, j)):
            rational[k] += multiplier * value
    assert all(rational[n - k] == -rational[k] for k in range(n + 1))
    return d, tuple(weights), tuple(rational)


def chebyshev_at(j: int, x: Fraction) -> Fraction:
    if j == 0:
        return Fraction(1)
    prev, cur = Fraction(1), x
    for _ in range(1, j):
        prev, cur = cur, 2 * x * cur - prev
    return cur


def check_reproduction(n: int, d: int, weights, a_rational) -> int:
    count = 0
    for z in [Fraction(-3, 4), Fraction(-1, 2), Fraction(0), Fraction(1, 2), Fraction(3, 4)]:
        p = (1 + z) / 2
        lhs = sum(
            a_rational[k] * math.comb(n, k) * p**k * (1 - p)**(n - k)
            for k in range(n + 1)
        )
        rhs = sum(
            weights[j] * Fraction((-1) ** ((j - 1) // 2), j) * chebyshev_at(j, z)
            for j in range(1, d + 1, 2)
        )
        assert lhs == rhs
        count += 1
    return count


def diagnostics(n: int, degree_budget: int, r: int, betas: list[float], mesh: int) -> dict:
    d, weights, rational = jackson_inverse(n, degree_budget, r)
    identity_count = check_reproduction(n, d, weights, rational)
    a = np.array([float(q) * (4 / math.pi) for q in rational], dtype=float)
    radii = np.linspace(0.0, 1.0, mesh + 1)
    probability = binom.pmf(np.arange(n + 1)[None, :], n, ((1 + radii) / 2)[:, None])
    values = probability @ (a * a)
    suffix_argmax = np.empty(mesh + 1, dtype=int)
    best = mesh
    for j in range(mesh, -1, -1):
        if values[j] >= values[best]:
            best = j
        suffix_argmax[j] = best
    suffix_max = values[suffix_argmax]
    lip = n * float(np.max(np.abs(np.diff(a * a)))) / 2 if n else 0.0
    log_kappa = (
        math.lgamma(n - d + 1) + math.lgamma(n + d + 2)
        - math.lgamma(n + 1) - math.lgamma(n + 2)
    ) / 2
    max_coeff = float(np.max(np.abs(a)))
    rows = []
    for beta in betas:
        assert 2 * r - 1 > beta
        cdf_cap = radii**beta  # L=1 in the numerical diagnostic only.
        increment = np.diff(cdf_cap, prepend=0.0)
        mass = np.bincount(suffix_argmax, weights=increment, minlength=mesh + 1)
        # This finite-grid distribution is feasible for every radius, not only
        # at grid points: its CDF is a step function bounded at each jump.
        residual = float(np.max(np.cumsum(mass) - cdf_cap))
        assert residual <= 2e-12
        variance_grid = float(np.dot(increment, suffix_max))
        uniform_coeff_bound = max_coeff * max_coeff
        D = d * d / n
        # An exploratory normalisation suggested by the lower-bound route.
        # No assertion or theorem is based on these quantities.
        localized_prefactor = (d / n)**beta
        positive_excess = max(0.0, variance_grid - 1.0)
        slope = math.log(positive_excess / localized_prefactor) / D if positive_excess else None
        significant = np.flatnonzero(mass > 0.01)
        rows.append({
            "beta": beta,
            "L": 1.0,
            "grid_robust_variance": variance_grid,
            "analytic_mesh_error_bound_evaluated_in_float": lip / mesh,
            "grid_to_sup_coefficient_square_ratio": variance_grid / uniform_coeff_bound,
            "grid_to_kappa_square_ratio": variance_grid * math.exp(-2 * log_kappa),
            "candidate_localized_prefactor": localized_prefactor,
            "candidate_log_excess_over_prefactor_divided_by_D": slope,
            "cdf_cap_max_float_violation": residual,
            "large_atoms_in_grid_optimizer": [
                {"radius": float(radii[j]), "radial_mass": float(mass[j])}
                for j in significant
            ],
            "continuum_certification": False,
        })
    return {
        "n": n,
        "degree_budget": degree_budget,
        "kernel_power_r": r,
        "actual_degree_bound_d": d,
        "D_d_squared_over_n": d * d / n,
        "exact_reproduction_checks": identity_count,
        "exact_antisymmetry": True,
        "max_abs_inverse_coefficient_float": max_coeff,
        "proved_U1_bound_float": 3 * math.exp(2 * d * d / n),
        "old_source_bound_sqrt_n_plus_1_kappa_float": math.sqrt(n + 1) * math.exp(log_kappa),
        "kappa_float": math.exp(log_kappa),
        "conditional_second_moment_at_zero_float": float(values[0]),
        "conditional_second_moment_at_one_float": float(values[-1]),
        "radius_of_max_conditional_second_moment_on_grid": float(radii[np.argmax(values)]),
        "margin_diagnostics": rows,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results/upper_initial.json")
    parser.add_argument("--mesh", type=int, default=1600)
    parser.add_argument("--extended", action="store_true")
    args = parser.parse_args()
    pairs = [(32, 8), (32, 16), (64, 16), (64, 32), (128, 16), (128, 32), (128, 64), (256, 32), (256, 64)]
    if args.extended:
        pairs += [(256, 128), (512, 64), (512, 128), (1024, 64), (1024, 128)]
    results = []
    for n, d in pairs:
        for r, betas in [(2, [0.5, 1.0, 2.0]), (3, [4.0])]:
            row = diagnostics(n, d, r, betas, args.mesh)
            results.append(row)
            print(f"n={n}, degree<={row['actual_degree_bound_d']}, r={r}: exact identities pass", flush=True)
    payload = {
        "status": "initial_research_diagnostics_not_a_minimax_proof",
        "scope": "Known positive Jackson convolution; exact rational-times-4/pi inverse coefficients; margin-constrained variance diagnostic for L=1.",
        "arithmetic": {
            "exact": "Fraction-based kernel weights, Chebyshev/Bernstein conversion, antisymmetry, and reproduction identities before multiplication by 4/pi.",
            "floating_point": "All evaluated coefficients containing pi, binomial probabilities, variance integrals, exponential comparisons, and mesh-bound numbers.",
            "certified_interval_arithmetic": False,
        },
        "mesh_intervals": args.mesh,
        "total_exact_reproduction_checks": sum(x["exact_reproduction_checks"] for x in results),
        "total_exact_antisymmetry_checks": len(results),
        "candidate_localized_variance_bound_proved": False,
        "original_conjecture_resolved": False,
        "rows": results,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + "\n")
    print(f"Wrote {args.output}; {len(results)} polynomial cases.")


if __name__ == "__main__":
    main()
