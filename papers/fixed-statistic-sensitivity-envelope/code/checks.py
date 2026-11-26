"""Exact rational checks for the fixed-statistic Gaffke envelopes when N is Exp(1)."""

from fractions import Fraction as Q
from math import factorial
from random import Random
import json


def require(condition, context):
    if not condition:
        raise RuntimeError(str(context))


def fixed_profile(coefficients):
    laplace = Q(1)
    slope = Q(0)
    for a in coefficients:
        laplace /= 1+a
        slope += a/(1+a)
    return 1-laplace*(1+slope), laplace*slope


def rate_ratio_enclosure(q, d, bits=78):
    # For the common-rate gamma profile, z=lambda/(1+lambda) and
    # D=1-z^q[1+q(1-z)] decreases strictly on (0, 1).
    lo, hi = Q(0), Q(1)
    for _ in range(bits):
        mid = (lo+hi)/2
        test = 1-mid**q*(1+q*(1-mid))
        if test > d:
            lo = mid
        else:
            hi = mid
    return lo, hi


def delta_enclosure(q, d):
    lo, hi = rate_ratio_enclosure(q, d)
    return 1-hi**q-d, 1-lo**q-d


def verify_unequal():
    rng = Random(20261125)
    cases = 0
    for _ in range(96):
        q = rng.randrange(2, 8)
        coefficients = [Q(rng.randrange(1, 13), rng.randrange(1, 13))
                        for _ in range(q)]
        if len(set(coefficients)) == 1:
            coefficients[-1] += 1
        d, delta = fixed_profile(coefficients)
        _, lower_max = delta_enclosure(1, d)
        upper_min, _ = delta_enclosure(q, d)
        require(lower_max < delta < upper_min, (q, coefficients, "strict envelopes"))
        cases += 1
    return cases


def verify_monotonicity():
    checked = 0
    for d in (Q(1, 10), Q(1, 4), Q(1, 2), Q(3, 4), Q(9, 10)):
        before = delta_enclosure(1, d)
        for q in range(2, 17):
            after = delta_enclosure(q, d)
            require(before[1] < after[0], (q, d, "strict gamma ladder"))
            before = after
            checked += 1
    return checked


def verify_leading_gap():
    # For the alternating exponential series, odd and even partial sums
    # enclose exp(-1). Here the limiting quantile is exactly one.
    e_lo = sum(Q((-1)**k, factorial(k)) for k in range(60))
    e_hi = e_lo + Q(1, factorial(60))
    d_lo, d_hi = 1-2*e_hi, 1-2*e_lo
    witnesses = []
    for q in (8, 16, 32, 64, 128):
        z_lo, _ = rate_ratio_enclosure(q, d_hi)
        _, z_hi = rate_ratio_enclosure(q, d_lo)
        scaled_lo, scaled_hi = q*(z_lo**q-e_hi), q*(z_hi**q-e_lo)
        require(0 < scaled_lo <= scaled_hi, (q, "positive finite gap"))
        if q >= 32:
            require(Q(17, 100) < scaled_lo < scaled_hi < Q(20, 100),
                    (q, "leading gap numerical enclosure"))
        witnesses.append({"q": q, "scaled_gap_times_1000000":
                          [int(scaled_lo*10**6), int(scaled_hi*10**6)+1]})
    return {"scaled_gaps": witnesses, "limiting_coefficient_times_1000000":
            [int(e_lo*500000), int(e_hi*500000)+1]}


print(json.dumps({"strict_unequal_profiles": verify_unequal(),
                  "strict_shape_comparisons": verify_monotonicity(),
                  "sharp_limit_example": verify_leading_gap()}, indent=2))
