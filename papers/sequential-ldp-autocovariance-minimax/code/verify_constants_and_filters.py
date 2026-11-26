#!/usr/bin/env python3
"""Finite checks accompanying the written proof; not a proof assistant.

Uses exact rational arithmetic for the conservative induction constants and
exhaustive latent/transcript enumeration for a small adaptive binary model.
The binary model checks the filtering logic, not the Gaussian minimax theorem.
"""
from fractions import Fraction as F
from itertools import product
from math import tanh, isclose
import argparse
import json
from pathlib import Path


def exact_constants():
    kappa = F(1, 256)
    posterior_ratio = F(3) / (1 - 9 * kappa)
    derivative_factor = F(9) + 3 * 2 * (1 + 8)
    prediction_ratio = posterior_ratio / (1 - derivative_factor * kappa)
    assert posterior_ratio < 4
    assert derivative_factor == 63
    assert derivative_factor * kappa < 1
    assert prediction_ratio < 6
    assert 72**2 == 5184 < 8192
    assert F(8192, 4) == 2048
    return {
        'posterior_over_delta': str(posterior_ratio),
        'posterior_derivative_factor': str(derivative_factor),
        'prediction_derivative_over_L_delta': str(prediction_ratio),
        'score_over_L_alpha_squared': 72,
        'information_coefficient_before_rounding': 5184,
        'information_coefficient_used': 8192,
        'status': 'passed_exact_rational_checks',
    }


def channel(x, z, history, alpha, adaptive):
    """Every history gives a binary alpha-LDP channel.

    If beta is its bias, |lambda| <= tanh(alpha/2)*(1-|beta|)
    implies both output likelihood ratios are at most exp(alpha).
    """
    if adaptive and history:
        parity = product_sign(history)
        beta = 0.2 * parity
        strength = (0.4, 0.7, 1.0)[(sum(t > 0 for t in history) + len(history)) % 3]
    else:
        beta, strength = 0.0, 1.0
    lam = tanh(alpha / 2) * (1 - abs(beta)) * strength
    return (1 + z * (beta + lam * x)) / 2


def product_sign(values):
    out = 1
    for value in values:
        out *= value
    return out


def raw_probability_and_score(x, h, theta):
    p, score = 1.0, 0.0
    for i, current in enumerate(x):
        if i < h:
            p *= 0.5
        else:
            cross = current * x[i - h]
            p *= (1 + theta * cross) / 2
            score += cross / (1 + theta * cross)
    return p, score


def direct_transcript(z, h, theta, alpha, adaptive):
    pz, derivative = 0.0, 0.0
    for x in product((-1, 1), repeat=len(z)):
        p, score = raw_probability_and_score(x, h, theta)
        for i in range(len(z)):
            p *= channel(x[i], z[i], z[:i], alpha, adaptive)
        pz += p
        derivative += p * score
    return pz, derivative


def filter_transcript(z, h, theta, alpha, adaptive):
    # Posterior means and their derivatives suffice for a two-state chain.
    means, derivatives = {}, {}
    pz, score = 1.0, 0.0
    for i, observed in enumerate(z):
        c = i % h
        if c in means:
            prediction = theta * means[c]
            prediction_derivative = means[c] + theta * derivatives[c]
        else:
            prediction = prediction_derivative = 0.0
        qm = channel(-1, observed, z[:i], alpha, adaptive)
        qp = channel(1, observed, z[:i], alpha, adaptive)
        normalizer = ((1 - prediction) * qm + (1 + prediction) * qp) / 2
        numerator = (-(1 - prediction) * qm + (1 + prediction) * qp) / 2
        da = prediction_derivative * (qp - qm) / 2
        dn = prediction_derivative * (qp + qm) / 2
        means[c] = numerator / normalizer
        derivatives[c] = (dn * normalizer - numerator * da) / normalizer**2
        pz *= normalizer
        score += da / normalizer
    return pz, pz * score, score


def enumerate_case(n, h, theta, alpha, adaptive):
    total, mean_score, information, error = 0.0, 0.0, 0.0, 0.0
    for z in product((-1, 1), repeat=n):
        pd, dd = direct_transcript(z, h, theta, alpha, adaptive)
        pf, df, score = filter_transcript(z, h, theta, alpha, adaptive)
        error = max(error, abs(pd-pf), abs(dd-df))
        assert isclose(pd, pf, rel_tol=2e-12, abs_tol=2e-14)
        assert isclose(dd, df, rel_tol=2e-11, abs_tol=2e-14)
        total += pd
        mean_score += dd
        information += pd * score**2
    count = max(n-h, 0)
    bound = 8192 * count * alpha**4
    assert abs(total-1) < 2e-12
    assert abs(mean_score) < 2e-12
    assert information <= bound + 1e-14
    if count == 0:
        assert information < 1e-25
    return {'n': n, 'h': h, 'theta': theta, 'alpha': alpha,
            'adaptive': adaptive, 'transcripts': 2**n,
            'maximum_direct_filter_error': error,
            'total_probability': total, 'mean_score': mean_score,
            'fisher_information': information, 'theorem_bound': bound,
            'information_over_N_alpha4': information / (count*alpha**4) if count else None}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', type=Path)
    args = parser.parse_args()
    rows = []
    for n, h in [(4,1), (5,2), (6,3), (3,3), (3,5)]:
        for theta in [-1/256, 0.0, 1/256]:
            for alpha in [0.05, 0.2, 1.0]:
                for adaptive in [False, True]:
                    rows.append(enumerate_case(n,h,theta,alpha,adaptive))
    result = {'status': 'passed', 'scope': 'exact induction constants and finite binary filtering checks only',
              'not_covered': ['Gaussian continuum theorem by computation', 'all possible channels by enumeration', 'Lean verification'],
              'constants': exact_constants(), 'case_count': len(rows),
              'maximum_direct_filter_error': max(x['maximum_direct_filter_error'] for x in rows),
              'cases': rows}
    payload = json.dumps(result, indent=2, allow_nan=False) + '\n'
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(payload)
    print(json.dumps({k: result[k] for k in ['status','scope','case_count','maximum_direct_filter_error']}))


if __name__ == '__main__':
    main()
