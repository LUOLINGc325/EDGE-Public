"""Exact rational checks for the Gaussian cosine and packet witnesses."""

from fractions import Fraction


def scaled_variance(dimension, radius):
    """Use radius = 2*pi*sigma*R to express the Gaussian formula rationally."""
    radius_squared = radius**2
    second_moment = Fraction(1, (1 + 2 * radius_squared) ** (dimension // 2))
    mean_squared = Fraction(1, (1 + radius_squared) ** dimension)
    return radius**dimension * (second_moment - mean_squared)


def check_packet_witness():
    # pi^2 is between 9 and 10. Use exp(-x) >= 1-x and exp(-x) <= 1/(1+x).
    product_lower = Fraction(1, 2) * (1 - Fraction(2 * 10, 25))
    mean_product_upper = Fraction(1, 1) / (1 + 4 * 9 * Fraction(9, 10) ** 2)
    assert product_lower - mean_product_upper > Fraction(1, 16)

    # alpha=1/4, r_i=4^(-i), R_i=r_i^(-5/4), and C>=1 for m_i=C*r_i^2/i^2.
    packet_indices = (2, 8, 16, 32, 64)
    for index in packet_indices:
        r = Fraction(1, 4**index)
        epsilon = Fraction(1, 2 ** (index // 2))
        assert epsilon**4 == r
        lower_variance = r**2 / (16 * index**4)
        old_bound_scale = (r * epsilon) ** 2
        ratio = lower_variance / old_bound_scale
        assert ratio == Fraction(2**index, 16 * index**4)
        print(f"packet i={index:2d} lower_ratio_to_R^-2={ratio}")
    assert ratio > 10**6


def main():
    radii = (1, 2, 8, 32, 128)
    for dimension in (2, 4, 6, 8):
        limit = Fraction(1, 2 ** (dimension // 2))
        previous = Fraction(0)
        print(f"d={dimension} limit={limit}")
        for radius in radii:
            value = scaled_variance(dimension, radius)
            assert previous < value < limit
            # Use 1-(1+x)^(-p) <= p*x and (1+r^2)^(-d) <= r^(-2d).
            bound = limit * Fraction(dimension, 4 * radius**2) + Fraction(
                1, radius**dimension
            )
            assert limit - value <= bound
            print(f"  r={radius:3d} scaled={float(value):.12f} error_bound={float(bound):.12f}")
            previous = value
    check_packet_witness()
    print("EXACT_RATIONAL_CHECKS_OK")


if __name__ == "__main__":
    main()
