"""Rational enclosures of the coefficients and the analytic transient bounds."""

from dataclasses import dataclass
from fractions import Fraction
import json
from math import comb, isqrt

Q = Fraction


@dataclass(frozen=True)
class Bounds:
    lo: Fraction
    hi: Fraction

    @staticmethod
    def point(value):
        return Bounds(Q(value), Q(value))

    @staticmethod
    def coerce(value):
        return value if isinstance(value, Bounds) else Bounds.point(value)

    def __add__(self, other):
        other = self.coerce(other)
        return Bounds(self.lo + other.lo, self.hi + other.hi)

    __radd__ = __add__

    def __neg__(self):
        return Bounds(-self.hi, -self.lo)

    def __sub__(self, other):
        return self + (-self.coerce(other))

    def __rsub__(self, other):
        return self.coerce(other) + (-self)

    def __mul__(self, other):
        other = self.coerce(other)
        products = [
            self.lo * other.lo, self.lo * other.hi,
            self.hi * other.lo, self.hi * other.hi,
        ]
        return Bounds(min(products), max(products))

    __rmul__ = __mul__

    def __truediv__(self, other):
        other = self.coerce(other)
        if other.lo <= 0:
            raise ValueError("positive divisor interval required")
        return self * Bounds(1 / other.hi, 1 / other.lo)

    def square_root(self):
        scale = 10 ** 32

        def floor_root(value):
            return isqrt(value.numerator * scale ** 2 // value.denominator)

        return Bounds(Q(floor_root(self.lo), scale), Q(floor_root(self.hi) + 1, scale))

    def encode(self):
        scale = 10 ** 12
        low_scaled = self.lo * scale
        high_scaled = self.hi * scale
        return {
            "lower": low_scaled.numerator // low_scaled.denominator,
            "upper": -((-high_scaled.numerator) // high_scaled.denominator),
            "unit_denominator": scale,
        }


def arctan_box(x, terms=24):
    partial = sum((-1) ** j * x ** (2 * j + 1) / (2 * j + 1) for j in range(terms))
    adjacent = partial + (-1) ** terms * x ** (2 * terms + 1) / (2 * terms + 1)
    return Bounds(min(partial, adjacent), max(partial, adjacent))


def arcsin_box(x, terms=30):
    partial = sum(
        Q(comb(2 * j, j), 4 ** j * (2 * j + 1)) * x ** (2 * j + 1)
        for j in range(terms)
    )
    return Bounds(partial, partial + x ** (2 * terms + 1) / (1 - x * x))


def check_oracle_expansion():
    """Exact K^3 computation on representative rational center parameters."""
    checked = 0
    for numerator in range(-8, 9):
        mu = Q(numerator, 8)
        endpoint2 = (1 + mu ** 2) / 2
        endpoint4 = (1 + 6 * mu ** 2 + mu ** 4) / 8
        mean2 = (Q(1, 3) + mu ** 2) / 2
        mean4 = (Q(1, 5) + 2 * mu ** 2 + mu ** 4) / 8
        if mean2 - endpoint2 != Q(-1, 3):
            raise ArithmeticError("oracle linear term differs")
        cubic = endpoint4 - mean4 + mean2 ** 2 - mean2 * endpoint2
        if cubic != Q(2, 45) + mu ** 2 / 3:
            raise ArithmeticError("oracle cubic term differs")
        checked += 1
    return checked


def main():
    pi = 16 * arctan_box(Q(1, 5)) - 4 * arctan_box(Q(1, 239))
    asin_third = arcsin_box(Q(1, 3))
    sqrt_pi = pi.square_root()
    sqrt2 = Bounds.point(2).square_root()
    sqrt3 = Bounds.point(3).square_root()
    h_mean = Bounds.point(1) / sqrt_pi
    h_at_zero = sqrt2 / sqrt_pi
    h_x2 = h_mean * (2 * asin_third / pi)
    covariance = h_x2 - h_mean / 3
    third = (sqrt2 - 2 * sqrt3 + 2) / (pi * sqrt_pi)
    j_lower = (Q(2, 3) * h_at_zero - h_mean + h_x2) / 3
    j_upper = -covariance
    baseline = 8 * third - 2 * covariance
    beta_lower, beta_upper = baseline + j_lower, baseline + j_upper
    if not (Q(902, 10_000) < beta_lower.lo < beta_upper.hi < Q(1264, 10_000)):
        raise ArithmeticError("analytic bounds did not certify the stated interval")
    print(json.dumps({
        "stationary_quadratic_term": baseline.encode(),
        "heat_transient_analytic_lower": j_lower.encode(),
        "heat_transient_analytic_upper": j_upper.encode(),
        "full_quadratic_coefficient": Bounds(beta_lower.lo, beta_upper.hi).encode(),
        "exact_oracle_center_checks": check_oracle_expansion(),
    }, indent=2))


if __name__ == "__main__":
    main()
