#!/usr/bin/env python3
"""Exact rounding, weighted PAV, and probability-margin certificates."""

from fractions import Fraction as F
from itertools import product
import json
from math import ceil, factorial, isqrt


def pav_fit(training, target):
    """Weighted isotonic fit with left-step interpolation and clamped endpoints."""
    grouped = {}
    for key, exposure, response in training:
        total, weight = grouped.get(key, (F(0), 0))
        grouped[key] = (total + exposure * response, weight + exposure)
    blocks = []
    for key in sorted(grouped):
        total, weight = grouped[key]
        blocks.append(([key], total, weight))
        while len(blocks) >= 2:
            left, right = blocks[-2:]
            if left[1] * right[2] <= right[1] * left[2]:
                break
            blocks[-2:] = [(left[0] + right[0], left[1] + right[1], left[2] + right[2])]
    fits = {key: total / weight for keys, total, weight in blocks for key in keys}
    chosen = max((key for key in fits if key <= target), default=min(fits))
    return fits[chosen]


def lower_log_e(z, slope, q):
    value = q * slope
    return value * z - value**2/2


def exact_pav_replay():
    L, n = 8, 12
    R = 2*(L+1)
    standardized = [
        (1, 1, F(5,4)), (1, R*R, F(2)),
        (2, 1, F(3,2)), (2, R*R, F(8)),
        (3, 1, F(-3)), (3, R*R, F(15,4)),
        (4, 1, F(1)), (4, 1, F(1)),
        (5, 1, F(4,3)), (5, R*R, F(10,3)),
        (6, 1, F(3,7)), (7, R*R, F(2)),
    ]
    data = [
        (key, exposure, 3*n*key+z/isqrt(exposure))
        for key, exposure, z in standardized
    ]
    checked = []
    for heldout, (key, exposure, z) in enumerate(standardized):
        if exposure == 1 or not 1 <= z <= L:
            continue
        twins = [
            z2 for key2, weight2, z2 in standardized
            if key2 == key and weight2 == 1 and 1 <= z2 <= F(3,2)
        ]
        if len(twins) != 1:
            continue
        training = data[:heldout] + data[heldout+1:]
        mu = pav_fit(training, key)
        slope = (mu-3*n*key)*isqrt(exposure)
        assert slope == R*twins[0]
        maximum = max(lower_log_e(z, slope, F(j,R)) for j in range(1,L+2))
        assert maximum >= z**2/2-F(9,32)
        checked.append({"J":key,"z":str(z),"trained_standardized_slope":str(slope),"log_score":str(maximum)})
    return checked


def rounding_grid():
    cases = 0
    for L in (2,5,12):
        R = 2*(L+1)
        for z,low in product((F(j,8) for j in range(8,8*L+1)),
                             (F(j,8) for j in range(8,13))):
            j = (z/low+F(1,2))//1
            q = F(j,R)
            assert 1 <= j <= L+1
            assert abs(q*R*low-z) <= F(3,4)
            assert lower_log_e(z,R*low,q) >= z**2/2-F(9,32)
            cases += 1
    return cases


def finite_bounds():
    n = 10**12
    alpha = F(99999,100000)
    assert 3**9 < 4**8
    assert F(1,6912) > F(1,10000)+F(1,25000)
    assert F(n,2*25000**2) == 800
    assert 2*n*F(1,10000)**2 == 20000
    assert F(3,n**2)+F(9,2*n**6) <= F(4,n**2)
    score = 1+F(1,40000)-F(4,n**2)
    failure = F(1,n)+F(factorial(3),800**3)+F(factorial(3),20000**3)
    assert score > 1/alpha
    assert failure < 1-alpha
    return {"n":n,"B":n,"nominal_alpha":str(alpha),
            "strict_score_lower_bound":str(score),"failure_upper_bound":str(failure)}


def arbitrary_level_parameters():
    result = []
    for alpha in (F(1,20),F(1,10),F(1,2),F(3,4),F(99999,100000)):
        L = 1 + ceil(F(6912) / alpha)
        assert F(L-1,3456) >= 2/alpha
        mismatch_upper_coefficient = alpha**2*F(5,16)+F(1,32)
        assert mismatch_upper_coefficient < 1
        result.append({
            "nominal_alpha":str(alpha),
            "L":L,
            "exposure_root":2*(L+1),
            "grid_size":L+2,
            "K0_power_of_two_exponent":L*L,
            "scaled_failure_upper_coefficient":str(mismatch_upper_coefficient),
        })
    return result


def main():
    print(json.dumps({
        "rounding_grid_fraction_checks":rounding_grid(),
        "exact_weighted_pav_examples":exact_pav_replay(),
        "two_power_fixture":finite_bounds(),
        "arbitrary_level_parameters":arbitrary_level_parameters()
    },indent=2))


if __name__ == "__main__":
    main()
