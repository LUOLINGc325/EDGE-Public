"""Rational enclosures for bivariate Gaffke endpoint and optimizer formulas."""
from dataclasses import dataclass
from fractions import Fraction as F
from math import isqrt


@dataclass(frozen=True)
class I:
    lo: F
    hi: F

    def __add__(self, other):
        other = as_interval(other)
        return I(self.lo + other.lo, self.hi + other.hi)

    __radd__ = __add__

    def __neg__(self):
        return I(-self.hi, -self.lo)

    def __sub__(self, other):
        return self + (-as_interval(other))

    def __rsub__(self, other):
        return as_interval(other) + (-self)

    def __mul__(self, other):
        other = as_interval(other)
        candidates = [a * b for a in (self.lo, self.hi) for b in (other.lo, other.hi)]
        return I(min(candidates), max(candidates))

    __rmul__ = __mul__

    def __truediv__(self, other):
        other = as_interval(other)
        assert other.lo > 0
        return self * I(1 / other.hi, 1 / other.lo)


def as_interval(value):
    return value if isinstance(value, I) else I(F(value), F(value))


def root(value):
    value = as_interval(value)
    assert value.lo >= 0
    scale = 2**180

    def floor_root(a):
        return isqrt(a.numerator * scale**2 // a.denominator)

    return I(F(floor_root(value.lo), scale), F(floor_root(value.hi) + 1, scale))


def lower_endpoints(alpha, x, y):
    if x >= alpha * y:
        endpoint = root(alpha * x * y)
        return endpoint, endpoint
    s = root(1 - alpha)
    u = 1 - s
    old = y - s * root(y * (y - x))
    improved = (u * y + root(u * u * y**2 + 4 * u * s * x * y)) / 2
    return old, improved


def p_values(x, y, theta):
    a, b = x / theta, y / theta
    if b <= 1:
        return as_interval(1), as_interval(1)
    if a >= 1:
        ans = as_interval(1 / (a * b))
        return ans, ans
    old = as_interval(1 - (b - 1)**2 / (b * (b - a)))
    tau = (b * (1 + a) + root(b**2 * (1 + a)**2 - 4 * a * b)) / 2
    inv = as_interval(1) / tau
    return old, 2 * inv - inv * inv


def gain_and_derivative(alpha, r):
    s, r = root(1 - alpha), as_interval(r)
    u = 1 - s
    w, z = root(u * u + 4 * u * s * r), root(1 - r)
    gain = (u + w) / 2 - 1 + s * z
    deriv = u * s / w - s / (2 * z)
    return gain, deriv


def optimizer(alpha):
    lo, hi = F(0), alpha

    def sign(r):
        gain, deriv = gain_and_derivative(alpha, r)
        return (1 + r) * deriv - gain

    assert sign(lo).lo > 0 and sign(hi).hi < 0
    for _ in range(85):
        middle = (lo + hi) / 2
        sg = sign(middle)
        if sg.lo > 0:
            lo = middle
        elif sg.hi < 0:
            hi = middle
        else:
            break
    r = I(lo, hi)
    g, _ = gain_and_derivative(alpha, r)
    return r, 2 * g / (1 + r)


def decimal_interval(a, precision=12):
    scale = 10**precision
    lo, hi = a.lo * scale, a.hi * scale
    left_int = lo.numerator // lo.denominator
    right_int = -(-hi.numerator // hi.denominator)

    def render(integer):
        assert integer >= 0
        return f"{integer // scale}.{integer % scale:0{precision}d}"

    return f"[{render(left_int)}, {render(right_int)}]"


def main():
    alpha = F(1, 40)
    r, maximum = optimizer(alpha)
    print(f"One-sided alpha={alpha}; sharp maximizing ratio {decimal_interval(r)}")
    print(f"Sharp equal-tail width gain {decimal_interval(maximum)}")
    x = r / (1 + r)
    print(f"Sorted maximizer coordinates {decimal_interval(x)} and {decimal_interval(1-x)}")
    count = 0
    for a in range(21):
        for b in range(a, 21):
            x, y = F(a, 20), F(b, 20)
            low = lower_endpoints(alpha, x, y)
            high = lower_endpoints(alpha, 1 - y, 1 - x)
            gain_l, gain_u = low[1] - low[0], high[1] - high[0]
            if 0 < x < alpha * y:
                assert gain_l.lo > 0
            else:
                assert gain_l.lo <= 0 <= gain_l.hi
            if 0 < 1 - y < alpha * (1 - x):
                assert gain_u.lo > 0
            else:
                assert gain_u.lo <= 0 <= gain_u.hi
            assert (gain_l + gain_u).hi < maximum.lo
            if y > 0:
                for i, endpoint in enumerate(low):
                    left = endpoint.lo - F(1, 10**20)
                    right = endpoint.hi + F(1, 10**20)
                    assert 0 < left < right < 1
                    pv_left = p_values(x, y, left)[i]
                    pv_right = p_values(x, y, right)[i]
                    assert pv_left.hi < alpha < pv_right.lo
            count += 1
    print(f"Exact rational sample-grid checks at alpha={alpha}: {count}")


if __name__ == "__main__":
    main()
