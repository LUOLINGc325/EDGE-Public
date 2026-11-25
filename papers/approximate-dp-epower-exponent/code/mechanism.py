#!/usr/bin/env python3
"""Finite-n checks for the truncated root-lattice histogram mechanism.

All probabilities, directed privacy divergences, shell counts, normalization,
e-value validity and method-of-types sandwiches are checked with Fraction.
Reported KL values and the variational solver use floating-point logarithms;
they are numerical comparisons, not certificates for the asymptotic theorem.

Default run: python3 code/mechanism.py --output results/mechanism_checks.json
Only Python's standard library is required. No data or network is used.
"""
from __future__ import annotations

import argparse
from collections import defaultdict
from fractions import Fraction
from itertools import product
import json
import math
from pathlib import Path
import platform
import sys
import time


def compositions(n: int, m: int):
    if m == 1:
        yield (n,)
        return
    for first in range(n + 1):
        for tail in compositions(n - first, m - 1):
            yield (first, *tail)


def lattice_norm(z: tuple[int, ...]) -> int:
    if sum(z) != 0:
        raise ValueError('A noise vector must have zero coordinate sum.')
    return sum(abs(x) for x in z) // 2


def shell_count(m: int, k: int) -> int:
    """Exact sign-support/positive-composition count, Proposition A.1."""
    if k == 0:
        return 1
    if k < 0 or m < 2:
        raise ValueError('Expected m >= 2 and k >= 0.')
    total = 0
    for a in range(1, m):
        for b in range(1, m - a + 1):
            if a > k or b > k:
                continue
            signs = math.comb(m, a) * math.comb(m - a, b)
            total += signs * math.comb(k - 1, a - 1) * math.comb(k - 1, b - 1)
    return total


def boundary_cap_count(m: int, radius: int) -> int:
    """Exact cap size: norm(z)=r, z_1<=0, z_2>=0."""
    total = 0
    for a in range(m - 1):
        for b in range(m - 1 - a):
            if a > radius or b > radius:
                continue
            signs = math.comb(m - 2, a) * math.comb(m - 2 - a, b)
            total += signs * math.comb(radius, a) * math.comb(radius, b)
    return total


def choose_radius_sufficient(m: int, t: Fraction, delta: Fraction) -> int:
    """Select by an exact rational sufficient shell bound, not a float test.

    epsilon = -log(t); r starts beyond the derivative threshold of
    epsilon*r - (m-2)*log(r). The displayed bound then decreases.
    """
    if not 0 < t < 1 or not 0 < delta < Fraction(1, 2):
        raise ValueError('Need 0 < exp(-epsilon) < 1 and 0 < delta < 1/2.')
    epsilon = -math.log(float(t))
    degree = m - 2
    radius = max(2, math.floor(degree / epsilon) + 1)
    while Fraction(3 ** m * radius ** degree) * t ** radius > delta:
        radius += 1
    return radius


def choose_radius(m: int, t: Fraction, delta: Fraction) -> int:
    """Smallest certified radius using exact cap counts, without enumerating noise.

    The search uses exact rational comparisons; no assumption that early
    boundary leakage is monotone is required.
    """
    if not 0 < t < 1 or not 0 < delta < Fraction(1, 2):
        raise ValueError('Need 0 < exp(-epsilon) < 1 and 0 < delta < 1/2.')
    radius = 0
    normalizer = Fraction(1)
    weight = Fraction(1)
    while Fraction(boundary_cap_count(m, radius)) * weight > delta * normalizer:
        radius += 1
        weight *= t
        normalizer += Fraction(shell_count(m, radius)) * weight
    return radius


def noise_weights(m: int, radius: int, t: Fraction):
    """Return unnormalized weights and exact normalizer on the finite ball."""
    weights = {}
    counts = defaultdict(int)
    powers = [t ** k for k in range(radius + 1)]
    for prefix in product(range(-radius, radius + 1), repeat=m - 1):
        z = (*prefix, -sum(prefix))
        k = lattice_norm(z)
        if k <= radius:
            weights[z] = powers[k]
            counts[k] += 1
    for k in range(radius + 1):
        assert counts[k] == shell_count(m, k), ('shell count mismatch', m, k)
    normalizer = sum(weights.values(), Fraction(0))
    assert normalizer == sum((Fraction(shell_count(m, k)) * powers[k]
                              for k in range(radius + 1)), Fraction(0))
    return weights, normalizer


def privacy_check(m: int, radius: int, t: Fraction, delta: Fraction,
                  weights: dict, normalizer: Fraction):
    divergences = []
    caps = []
    zero = Fraction(0)
    for i in range(m):
        for j in range(m):
            if i == j:
                continue
            divergence = zero
            cap_mass = zero
            cap_count = 0
            for z, weight in weights.items():
                shifted = list(z)
                shifted[i] -= 1
                shifted[j] += 1
                shifted = tuple(shifted)
                difference = weight - weights.get(shifted, zero) / t
                if difference > 0:
                    divergence += difference
                if lattice_norm(shifted) > radius:
                    cap_mass += weight
                    cap_count += 1
            divergence /= normalizer
            cap_mass /= normalizer
            assert divergence == cap_mass
            assert divergence <= delta
            assert divergence <= Fraction(shell_count(m, radius)) * t ** radius / normalizer
            assert cap_count == boundary_cap_count(m, radius)
            if m == 2:
                assert cap_count == 1
            if m == 3:
                assert cap_count == 2 * radius + 1
            divergences.append(divergence)
            caps.append(cap_count)
    assert len(set(divergences)) == 1, 'coordinate permutation symmetry failed'
    return {
        'ordered_neighbor_directions_checked': len(divergences),
        'maximum_hockey_stick': str(max(divergences)),
        'maximum_hockey_stick_decimal': float(max(divergences)),
        'cap_cardinality': caps[0],
        'shell_cardinality': shell_count(m, radius),
        'all_directions_within_delta_exact': True,
        'privacy_equals_boundary_cap_exact': True,
    }


def multinomial_probability(hist: tuple[int, ...], p: tuple[Fraction, ...]) -> Fraction:
    n = sum(hist)
    coefficient = math.factorial(n)
    for count in hist:
        coefficient //= math.factorial(count)
    result = Fraction(coefficient)
    for count, probability in zip(hist, p):
        result *= probability ** count
    return result


def divergence_exponential(hist: tuple[int, ...], p: tuple[Fraction, ...]) -> Fraction:
    """Exactly exp(-n*KL(hist/n || p)), without logarithms."""
    n = sum(hist)
    result = Fraction(1)
    for count, probability in zip(hist, p):
        if count:
            result *= (Fraction(n, count) * probability) ** count
    return result


def output_law(n: int, p: tuple[Fraction, ...], weights: dict, normalizer: Fraction):
    m = len(p)
    type_count = math.comb(n + m - 1, m - 1)
    unnormalized = defaultdict(Fraction)
    largest_type_exponential = {}
    histogram_total = Fraction(0)
    for hist in compositions(n, m):
        probability = multinomial_probability(hist, p)
        peak = divergence_exponential(hist, p)
        assert peak / type_count <= probability <= peak
        histogram_total += probability
        for z, weight in weights.items():
            output = tuple(x + y for x, y in zip(hist, z))
            unnormalized[output] += probability * weight
            term = peak * weight
            if term > largest_type_exponential.get(output, 0):
                largest_type_exponential[output] = term
    assert histogram_total == 1
    assert sum(unnormalized.values(), Fraction(0)) == normalizer
    for output, probability in unnormalized.items():
        peak = largest_type_exponential[output]
        # This checks Proposition B.1 simultaneously at every finite output.
        assert peak / type_count <= probability <= peak * type_count
    return {output: probability / normalizer for output, probability in unnormalized.items()}


def log_fraction(value: Fraction) -> float:
    return math.log(value.numerator) - math.log(value.denominator)


def kl_float(q, p) -> float:
    return math.fsum(float(x) * math.log(float(x / y)) for x, y in zip(q, p) if x)


def tv(x, y) -> float:
    return math.fsum(abs(a - b) for a, b in zip(x, y)) / 2


def penalized_projection(p, q, penalty: float):
    """Numerical KL+penalty*TV optimizer via scalar normalization KKT.

    This routine is only a numerical reference, not part of exact checks.
    """
    if penalty <= 0:
        return tuple(p)
    half = penalty / 2
    # r_i = median(c*p_i*exp(-half), q_i, c*p_i*exp(half)).
    lo = -half
    hi = half
    result = list(q)
    for _ in range(100):
        log_c = (lo + hi) / 2
        lower_scale = math.exp(log_c - half)
        upper_scale = math.exp(log_c + half)
        result = [min(max(qi, lower_scale * pi), upper_scale * pi)
                  for pi, qi in zip(p, q)]
        if math.fsum(result) < 1:
            lo = log_c
        else:
            hi = log_c
    return tuple(result)


def variational_rate_numeric(p, q, epsilon: float, radius: float):
    p = tuple(map(float, p))
    q = tuple(map(float, q))
    if radius <= 0:
        return {'value': kl_float(q, p), 'minimizer': list(q), 'tv': 0.0,
                'method': 'endpoint exact formula with floating logarithms'}
    base = penalized_projection(p, q, epsilon)
    if tv(base, q) <= radius + 1e-13:
        selected = base
        penalty = epsilon
    else:
        ratios = [math.log(qi / pi) for pi, qi in zip(p, q)]
        lo = epsilon
        hi = max(epsilon, max(ratios) - min(ratios)) + 1
        for _ in range(100):
            penalty = (lo + hi) / 2
            selected = penalized_projection(p, q, penalty)
            if tv(selected, q) > radius:
                lo = penalty
            else:
                hi = penalty
        penalty = hi
        selected = penalized_projection(p, q, penalty)
    distance = tv(selected, q)
    assert abs(math.fsum(selected) - 1) < 1e-10
    assert distance <= radius + 1e-10
    return {'value': kl_float(selected, p) + epsilon * distance,
            'minimizer': list(selected), 'tv': distance,
            'dual_penalty': penalty, 'method': 'floating-point nested scalar KKT bisection'}


def check_instance(n, p, q, t, alpha):
    m = len(p)
    epsilon = -math.log(float(t))
    delta_exponent = max(2, math.ceil(alpha * n))
    delta = t ** delta_exponent
    radius = choose_radius(m, t, delta)
    weights, normalizer = noise_weights(m, radius, t)
    privacy = privacy_check(m, radius, t, delta, weights, normalizer)
    law_p = output_law(n, p, weights, normalizer)
    law_q = output_law(n, q, weights, normalizer)
    assert law_p.keys() == law_q.keys()
    assert sum(law_p.values(), Fraction(0)) == 1
    assert sum(law_q.values(), Fraction(0)) == 1
    e_mean = Fraction(0)
    contributions = []
    ratio_min = min(qi / pi for qi, pi in zip(q, p)) ** n
    ratio_max = max(qi / pi for qi, pi in zip(q, p)) ** n
    for output, probability_q in law_q.items():
        probability_p = law_p[output]
        e_value = probability_q / probability_p
        assert ratio_min <= e_value <= ratio_max
        e_mean += probability_p * e_value
        contributions.append(float(probability_q) * log_fraction(e_value))
    assert e_mean == 1
    output_kl = math.fsum(contributions)
    input_kl = n * kl_float(q, p)
    assert -1e-10 <= output_kl <= input_kl + 1e-10
    target = variational_rate_numeric(p, q, epsilon, alpha)
    effective = variational_rate_numeric(p, q, epsilon, radius / n)
    return {
        'n': n, 'm': m, 'P': list(map(str, p)), 'Q': list(map(str, q)),
        'exp_minus_epsilon': str(t), 'epsilon': epsilon,
        'delta': str(delta), 'delta_exponent_base_t': delta_exponent,
        'limiting_rho_over_epsilon': alpha,
        'selected_radius': radius, 'radius_over_n': radius / n,
        'radius_calibration': 'smallest radius satisfying exact boundary-cap privacy inequality',
        'conservative_shell_bound_radius': choose_radius_sufficient(m, t, delta),
        'noise_support_count': len(weights), 'output_support_count': len(law_p),
        'normalizer': str(normalizer), 'privacy': privacy,
        'probability_normalization_exact': True,
        'all_output_type_sandwiches_exact': True,
        'input_likelihood_ratio_envelope_exact': True,
        'null_e_value_mean_exact': str(e_mean),
        'output_kl_numerical': output_kl,
        'output_kl_per_record_numerical': output_kl / n,
        'nonprivate_kl_per_record_numerical': input_kl / n,
        'asymptotic_variational_reference_numerical': target,
        'current_radius_variational_reference_numerical': effective,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path, default=Path('results/mechanism_checks.json'))
    parser.add_argument('--quick', action='store_true', help='Run one sample per dimension.')
    args = parser.parse_args()
    started = time.monotonic()
    t = Fraction(1, 2)
    count_regressions = []
    for dimension in range(2, 6):
        for test_radius in range(4):
            test_weights, _ = noise_weights(dimension, test_radius, t)
            enumerated = sum(1 for z in test_weights
                             if lattice_norm(z) == test_radius and z[0] <= 0 <= z[1])
            assert enumerated == boundary_cap_count(dimension, test_radius)
            count_regressions.append({'m': dimension, 'radius': test_radius,
                                      'cap_count': enumerated, 'exact_match': True})
    # A regression against the false calibration r=ceil(log(1/delta)/epsilon).
    bad_r = 10
    bad_delta = Fraction(1, 1024)
    bad_normalizer = sum((Fraction(shell_count(3, k)) * t ** k
                          for k in range(bad_r + 1)), Fraction(0))
    bad_leakage = Fraction(boundary_cap_count(3, bad_r)) * t ** bad_r / bad_normalizer
    assert bad_leakage == Fraction(21, 13240)
    assert bad_leakage > bad_delta
    corrected_radius = choose_radius(3, t, bad_delta)
    assert corrected_radius == 11
    specifications = [
        ((Fraction(1, 10), Fraction(9, 10)),
         (Fraction(4, 5), Fraction(1, 5)), [8, 32, 96]),
        ((Fraction(1, 10), Fraction(3, 10), Fraction(3, 5)),
         (Fraction(3, 5), Fraction(3, 10), Fraction(1, 10)), [4, 8, 12]),
    ]
    rows = []
    for p, q, sample_sizes in specifications:
        if args.quick:
            sample_sizes = sample_sizes[:1]
        for alpha in ([0.25] if args.quick else [0.0, 0.25, 1.0]):
            for n in sample_sizes:
                row = check_instance(n, p, q, t, alpha)
                rows.append(row)
                print(f"m={len(p)} n={n} alpha={alpha:g} r={row['selected_radius']} "
                      f"exact checks passed; KL/n={row['output_kl_per_record_numerical']:.9f}", flush=True)
    payload = {
        'schema_version': 1,
        'mechanism': 'independent truncated zero-sum lattice histogram noise',
        'validation_status': 'passed_exact_finite_instance_checks',
        'case_count': len(rows),
        'independent_shell_and_cap_count_enumerations': count_regressions,
        'uncalibrated_radius_counterexample': {
            'm': 3, 'exp_minus_epsilon': '1/2', 'delta': str(bad_delta),
            'naive_radius': bad_r, 'exact_leakage': str(bad_leakage),
            'naive_radius_violates_delta_exact': True,
            'smallest_corrected_radius': corrected_radius,
        },
        'arithmetic': 'fractions.Fraction for all probabilities and privacy/type/e-value checks',
        'numerical_quantities': ['logarithms', 'KL values', 'variational reference minimizers and values'],
        'limitations': [
            'Finite enumerations do not establish the general theorem or asymptotic limit.',
            'Variational numerical references are not directed-rounding certificates.',
            'The general proof is in manuscript/achievability-notes.md.',
            'These checks do not verify the all-mechanism converse.'
        ],
        'environment': {'python': sys.version.split()[0], 'platform': platform.platform()},
        'elapsed_seconds': time.monotonic() - started,
        'cases': rows,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(payload, ensure_ascii=False, indent=2) + '\n', encoding='utf-8')
    print(f"Wrote {args.output}; {len(rows)} finite instances verified.", flush=True)


if __name__ == '__main__':
    main()
