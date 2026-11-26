"""Reference implementation of the original-alphabet hard-sign holdout test."""

import math

import numpy as np


def fit(train_p, train_q, k, n, rng):
    """Fit one frozen Boolean map from two reserved training blocks of size 2n."""
    requested_p, requested_q = rng.poisson(n, size=2)
    if max(requested_p, requested_q) > 2 * n:
        return np.zeros(k, dtype=bool)
    counts_p = np.bincount(train_p[:requested_p], minlength=k)
    counts_q = np.bincount(train_q[:requested_q], minlength=k)
    tied_decision = rng.integers(0, 2, size=k, dtype=np.int8).astype(bool)
    return (counts_p > counts_q) | ((counts_p == counts_q) & tied_decision)


def test(samples_p, samples_q, k, delta, rng=None):
    """Use prefixes of length 3n with n=floor(minimum stream length/3).

    The two one-dimensional streams must contain integers in [0, k).
    The confidence parameter controls the holdout threshold. Choose the input
    budget using Theorem 1 for the desired alternative separation.
    """
    if not isinstance(k, int) or k < 2 or not 0 < delta <= 0.25:
        raise ValueError("Expected integer k >= 2 and 0 < delta <= 1/4.")
    p = np.asarray(samples_p)
    q = np.asarray(samples_q)
    for stream in (p, q):
        if stream.ndim != 1 or stream.dtype.kind not in "iu":
            raise ValueError("Each sample stream must be a one-dimensional integer array.")
        if np.any(stream < 0) or np.any(stream >= k):
            raise ValueError("Sample labels must lie in [0, k).")
    n = min(len(p), len(q)) // 3
    if n == 0:
        raise ValueError("Each stream requires at least three samples.")
    rng = np.random.default_rng() if rng is None else rng
    mask = fit(p[:2 * n].astype(np.intp), q[:2 * n].astype(np.intp), k, n, rng)
    mass_difference = float(mask[p[2 * n:3 * n]].mean() - mask[q[2 * n:3 * n]].mean())
    threshold = 4 * math.sqrt(math.log(16) / n - math.log(delta) / n)
    return mass_difference > threshold, mass_difference, mask
