"""Exact rational checks for the final simplification to h = 10^-80."""
from fractions import Fraction as F
import json


def require(condition):
    if not condition:
        raise AssertionError("rational cutoff check failed")


def main():
    kappa = F(1, 100)
    gap = F(1, 10**20)
    # The normal density on [0, 1/3] is above 1/4, and phi(3) is above 1/1000.
    k_star = F(1, 10) * F(1, 4) / 160
    d_lower = F(1, 2000)
    require(d_lower**3 < k_star * kappa**2 / 96)
    v_lower = d_lower / 4
    k_lower = v_lower / 1_280_000
    shared_lower = k_lower * v_lower**2 / (8 * 16)
    require(shared_lower == F(1, 83_886_080_000_000_000_000))
    require(shared_lower > gap)
    require(d_lower / 2 > gap and d_lower**2 / 32 > gap)
    require(k_lower * kappa**2 / 32 > gap**3)
    require(v_lower / 1000 > gap and v_lower * F(2, 5000) / 8 > gap)
    require(gap * F(1, 10**60) == F(1, 10**80))
    require(gap / 2 > F(1, 10**80))

    for denominator in range(2, 31):
        for numerator in range(1, denominator):
            q = F(numerator, denominator)
            h = 1 - q
            collapsed = h * ((1 - q / 3) + (1 - 2 * q / 3) - h)
            require(collapsed == h)
    print(json.dumps({
        "normal_density_bounds_used": [">1/4 on [0,1/3]", "phi(3)>1/1000"],
        "triple_neighborhood_lower_bound": str(d_lower),
        "pair_residual_v_lower_bound": str(v_lower),
        "pair_shared_cutoff_lower_bound": str(shared_lower),
        "accepted_endpoint_width": "10^-80",
        "exact_collapsed_equality_checks": 435,
    }, indent=2))


if __name__ == "__main__":
    main()
