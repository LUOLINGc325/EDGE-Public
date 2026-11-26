"""Conditional Gamma calibration evidence based on the two deviance branches."""

import math


def _upper_log(gap):
    if gap < 1e-4:
        return gap / 2 - gap**2 / 24 + gap**4 / 2880
    return math.log(gap) - math.log(-math.expm1(-gap))


def branch_gap(ratio):
    """Return r_plus-r_minus for finite positive Y/mu."""
    if not math.isfinite(ratio) or ratio <= 0:
        raise ValueError("the observed ratio must be positive and finite")
    if ratio == 1:
        return 0.0
    above = ratio > 1
    target = math.log(ratio)
    lo = 0.0
    hi = max(1.0, ratio if above else -2 * target)
    for _ in range(1100):
        middle = lo + (hi-lo)/2
        if middle in (lo, hi):
            break
        upper = _upper_log(middle)
        log_branch = upper if above else upper-middle
        if (log_branch < target) == above:
            lo = middle
        else:
            hi = middle
    return lo + (hi-lo)/2


def null_high_probability(gap):
    """Conditional probability of the upper branch, given its gap."""
    if not math.isfinite(gap) or gap < 0:
        raise ValueError("the branch gap must be nonnegative and finite")
    if gap < 1e-3:
        return 0.5-gap/12+gap**3/720-gap**5/30240
    if gap > 700:
        return 1/gap
    return 1/gap-1/math.expm1(gap)


def _log_add(a, b):
    if math.isinf(b):
        return b if b > 0 else a
    high, low = max(a,b), min(a,b)
    return high + math.log1p(math.exp(low-high))


def log_evidence(ratio, training_slope):
    """Compute log (5) for one ratio and a finite trained slope."""
    if not math.isfinite(training_slope):
        raise ValueError("the trained slope must be finite")
    gap = branch_gap(ratio)
    if gap == 0 or training_slope == 0:
        return 0.0
    p = null_high_probability(gap)
    eta = training_slope*gap
    if ratio > 1:
        return -_log_add(math.log(p), math.log1p(-p)-eta)
    return -_log_add(math.log1p(-p), math.log(p)+eta)
