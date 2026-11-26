#!/usr/bin/env python3
"""Independent finite certificates for the global-trimming/location bridge.

Rational checks verify deterministic inequalities conditional on the stated
two-sided relative tail band. Decimal exponential checks are diagnostics only.
Neither replaces the all-distribution mathematical proof.
"""
from __future__ import annotations

from collections import Counter
from fractions import Fraction as F
from pathlib import Path
import hashlib
import json
import math

import mpmath as mp
import numpy as np


def mix(p, q, eps):
    out = Counter()
    for x, w in p.items():
        out[x] += (1 - eps) * w
    for x, w in q.items():
        out[x] += eps * w
    return dict(out)


def tail(p, x, sign):
    return sum((w for z, w in p.items() if (z > x if sign == 1 else z < x)), F(0))


def trim(p, k):
    out = dict(p)
    for order in (sorted(out), sorted(out, reverse=True)):
        rem = k
        for x in order:
            w = min(out[x], rem)
            out[x] -= w
            rem -= w
            if not rem:
                break
        assert rem == 0
    return {x: w for x, w in out.items() if w}


def thresholds(*laws):
    s = sorted(set().union(*(p.keys() for p in laws)))
    return [s[0] - 1, *s, *[(x + y) / 2 for x, y in zip(s, s[1:])], s[-1] + 1]


def m(v):
    return mp.mpf(v.numerator) / v.denominator if isinstance(v, F) else mp.mpf(v)


def clipped_remainder(weights, center, radius, t):
    terms = [(m(w), m(max(-radius, min(radius, x - center)))) for x, w in weights.items()]
    t = m(t)
    if t == 0:
        return sum(w * x * x for w, x in terms)
    a = 1 + sum(w * (mp.expm1(t * x) - t * x) for w, x in terms)
    return 2 * mp.log(a) / (t * t)


def run():
    rng = np.random.default_rng(20261125)
    mp.mp.dps = 70
    clean = [
        {F(0): F(1)},
        {F(-2): F(1, 100), F(0): F(49, 50), F(2): F(1, 100)},
        {F(-1): F(1, 2), F(1): F(1, 2)},
        {F(-2): F(1, 6), F(0): F(1, 2), F(1): F(1, 3)},
    ]
    contaminants = [
        {F(10**30): F(1)},
        {F(-10**30): F(1)},
        {F(10**30): F(2, 5), F(-1, 3): F(3, 5)},
        {F(-10**30): F(1, 3), F(1, 4): F(2, 3)},
    ]
    eta, d = F(1, 10), F(1, 100)
    counts = Counter()
    rows = []
    for pi, p in enumerate(clean):
        assert sum(p.values()) == 1 and sum(x * w for x, w in p.items()) == 0
        for qi, q in enumerate(contaminants):
            for eps in [F(0), F(1, 1000), F(1, 100), F(1, 10), F(3, 10)]:
                h = mix(p, q, eps)
                k = (1 + eta) * eps + d
                a = (1 + eta) * (1 - eps)
                alpha = (1 + eta) ** 2
                delta = (2 * (1 + eta) * k + d) / (1 - eps)
                assert 0 <= k < F(1, 2)
                for n in [2000, 12000]:
                    for rep in range(3):
                        xs = sorted(h)
                        ns = rng.multinomial(n, [float(h[x]) for x in xs])
                        empirical = {x: F(int(c), n) for x, c in zip(xs, ns) if c}
                        cut = thresholds(h, empirical)
                        band = all(
                            tail(h, x, z) <= (1 + eta) * tail(empirical, x, z) + d
                            and tail(empirical, x, z) <= (1 + eta) * tail(h, x, z) + d
                            for x in cut for z in [-1, 1]
                        )
                        counts['sample_rows'] += 1
                        if not band:
                            counts['outside_conditioning_band'] += 1
                            continue
                        nu = trim(empirical, k)
                        mass = 1 - 2 * k
                        assert sum(nu.values()) == mass
                        xi = {x: w / a for x, w in nu.items()}
                        assert sum(xi.values()) <= 1
                        counts['mass_checks'] += 2
                        for x in thresholds(p, xi, {F(0): F(1)}):
                            # Ray-tail domination only requires x>=0 for the
                            # positive tail and x<=0 for the negative tail.
                            for z in ([1] if x > 0 else [-1] if x < 0 else [-1, 1]):
                                pt, xt = tail(p, x, z), tail(xi, x, z)
                                assert xt <= pt
                                assert pt <= alpha * xt + delta
                                counts['exact_tail_inequalities'] += 2
                        mean = sum(x * w for x, w in nu.items()) / mass
                        p_abs = sum(abs(x) * w for x, w in p.items())
                        xi_abs = sum(abs(x) * w for x, w in xi.items())
                        assert p_abs >= xi_abs
                        assert abs(mean) <= a / mass * (p_abs - xi_abs)
                        counts['mean_integral_checks'] += 2
                        for r in [F(1, 2), F(2), F(4)]:
                            tail_integral = sum(max(abs(x) - r, F(0)) * w for x, w in p.items())
                            budget = a / mass * ((alpha - 1) * p_abs + 2 * delta * r + tail_integral)
                            assert abs(mean) <= budget
                            counts['mean_budget_checks'] += 1
                            if rep == 0:
                                for t in [F(0), F(1, 100), F(-1, 100), F(1), F(-1), F(5), F(-5), F(30), F(-30)]:
                                    f0 = clipped_remainder(xi, F(0), r, t)
                                    fm = clipped_remainder(xi, mean, r, t)
                                    assert abs(fm - f0) <= m(4 * r * abs(mean)) + mp.mpf('1e-50')
                                    counts['center_lipschitz_diagnostics'] += 1
                        # The procedure uses ranks and a normalized trimmed
                        # mean, so an arbitrarily large location is harmless.
                        shift = F(10**12) + F(1, 7)
                        shifted = {x + shift: w for x, w in empirical.items()}
                        shifted_nu = trim(shifted, k)
                        shifted_mean = sum(x * w for x, w in shifted_nu.items()) / mass
                        assert shifted_mean == mean + shift
                        counts['exact_translation_checks'] += 1
                        if rep == 0 and n == 12000:
                            rows.append({
                                'clean_law': pi, 'contaminant': qi,
                                'epsilon': str(eps), 'n': n,
                                'trimmed_mean': str(mean),
                                'retained_mass': str(mass),
                                'extreme_contaminant_size': '10^30',
                            })
    assert counts['sample_rows'] == 480
    assert counts['exact_tail_inequalities'] > 0
    return {
        'status': 'passed', 'seed': 20261125,
        'scope': 'Finite rational conditional-tail certificates and high-precision diagnostics; not a proof of asymptotic minimax theorems.',
        'conditioning': 'Both directions of the simultaneous relative empirical tail band are explicitly checked before conditional conclusions.',
        'counts': dict(counts), 'illustrative_rows': rows,
        'script_sha256': hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }


if __name__ == '__main__':
    result = run()
    destination = Path(__file__).resolve().parents[1] / 'results' / 'trim_certificate.json'
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps({'status': result['status'], 'counts': result['counts'], 'output': str(destination)}, ensure_ascii=False))
