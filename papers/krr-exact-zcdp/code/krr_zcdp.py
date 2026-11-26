#!/usr/bin/env python3
"""High-precision exact-characterization solver for k-RR zCDP.

The theorem gives the exact implicit characterization. This mpmath
implementation returns high-precision approximations, not certified bounds.
Use exact_certificate.py for selected rational-interval certificates.
"""
from __future__ import annotations

import argparse
import json
from dataclasses import dataclass

import mpmath as mp


def curvature_threshold(t):
    """C(t); the continuous extension at zero equals 2."""
    t = mp.mpf(t)
    if t == 0:
        return mp.mpf(2)
    if t < 0:
        raise ValueError("t must be nonnegative")
    return (mp.sinh(t) * mp.cosh(t) - t) / (t * mp.cosh(t) - mp.sinh(t))


def alphabet_threshold(epsilon):
    epsilon = mp.mpf(epsilon)
    if epsilon < 0:
        raise ValueError("epsilon must be nonnegative")
    a = epsilon / 2
    return 2 + 2 * mp.exp(a) * curvature_threshold(a)


def log_z(t, c):
    """log(c+cosh(t)) evaluated without exponential overflow."""
    return t - mp.log(2) + mp.log1p(2 * c * mp.exp(-t) + mp.exp(-2*t))


def slope(t, a, c):
    if t == a:
        return mp.sinh(a) / (2*a*(c + mp.cosh(a)))
    return (log_z(t, c) - log_z(a, c)) / (t*t - a*a)


def stationarity(t, a, c):
    """Positive before the unique interior maximum, negative afterwards."""
    np = mp.sinh(t) / (c + mp.cosh(t))
    return (t*t - a*a) * np - 2*t*(log_z(t, c) - log_z(a, c))


def rdp_ratio(alpha, k, epsilon):
    """D_alpha(P||Q)/alpha, directly from the original finite distribution."""
    epsilon, alpha = mp.mpf(epsilon), mp.mpf(alpha)
    if alpha < 1:
        raise ValueError("alpha must be at least one")
    if epsilon == 0:
        return mp.mpf(0)
    if alpha == 1:
        return epsilon * mp.expm1(epsilon) / (mp.exp(epsilon) + k - 1)
    terms = [alpha*epsilon, (1-alpha)*epsilon]
    if k > 2:
        terms.append(mp.log(k-2))
    z = max(terms)
    numerator = z + mp.log(sum(mp.exp(v-z) for v in terms))
    denominator = mp.log(mp.exp(epsilon) + k - 1)
    return (numerator - denominator) / (alpha*(alpha-1))


@dataclass
class Result:
    k: int
    epsilon: str
    regime: str
    rho: str
    alpha: str | None
    t: str | None
    t_bracket: list[str] | None
    k_threshold: str
    kl_value: str
    precision_digits: int


def solve(k, epsilon, digits=60):
    if isinstance(k, bool) or not isinstance(k, int) or k < 2:
        raise ValueError("k must be an integer >= 2")
    if digits < 20:
        raise ValueError("digits must be >= 20")
    with mp.workdps(digits + 40):
        e = mp.mpf(epsilon)
        if e < 0 or not mp.isfinite(e):
            raise ValueError("epsilon must be finite and nonnegative")
        fmt = lambda v: mp.nstr(v, digits)
        if e == 0:
            return Result(k, "0", "zero", "0", None, None, None, "6", "0", digits)
        # Extra digits protect cancellation in C(epsilon/2) for tiny epsilon.
        extra = max(0, int(-mp.log10(e))) * 4
        with mp.workdps(digits + 40 + extra):
            a = e / 2
            c = mp.mpf(k-2) / (2*mp.exp(a))
            threshold = alphabet_threshold(e)
            kl = rdp_ratio(1, k, e)
            if c <= curvature_threshold(a):
                return Result(k, fmt(e), "boundary", fmt(kl), "1", fmt(a), None,
                              fmt(threshold), fmt(kl), digits)
            B = mp.log(2*(c + mp.cosh(a)))
            lo, hi = a, B + mp.sqrt(B*B - a*a)
            if stationarity(hi, a, c) >= 0:
                raise ArithmeticError("proved upper bracket failed numerically; increase precision")
            tolerance = mp.power(10, -digits-5)
            for _ in range(20*digits + 200):
                mid = (lo + hi) / 2
                if stationarity(mid, a, c) > 0:
                    lo = mid
                else:
                    hi = mid
                if hi-lo <= tolerance * max(1, abs(mid)):
                    break
            else:
                raise ArithmeticError("bisection did not converge")
            t = (lo + hi) / 2
            rho = e*e*mp.sinh(t) / (2*t*(c + mp.cosh(t)))
            return Result(k, fmt(e), "interior", fmt(rho), fmt(t/e + mp.mpf('0.5')),
                          fmt(t), [mp.nstr(lo, digits+10), mp.nstr(hi, digits+10)],
                          fmt(threshold), fmt(kl), digits)


def transition_epsilon(k, digits=60):
    """Unique positive epsilon with K(epsilon)=k, for integer k>=7."""
    if not isinstance(k, int) or isinstance(k, bool) or k < 7:
        raise ValueError("a positive transition requires integer k>=7")
    with mp.workdps(digits + 30):
        lo, hi = mp.mpf(0), mp.mpf(1)
        while alphabet_threshold(hi) < k:
            hi *= 2
        for _ in range(4*digits + 80):
            mid = (lo+hi)/2
            if alphabet_threshold(mid) < k:
                lo = mid
            else:
                hi = mid
        return mp.nstr((lo+hi)/2, digits)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("k", type=int)
    parser.add_argument("epsilon", help="decimal string; do not pre-round through a float")
    parser.add_argument("--digits", type=int, default=60)
    args = parser.parse_args()
    print(json.dumps(solve(args.k, args.epsilon, args.digits).__dict__, indent=2))
