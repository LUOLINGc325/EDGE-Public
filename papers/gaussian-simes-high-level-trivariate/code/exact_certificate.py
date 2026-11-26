"""Rational enclosures for the Gaussian Simes endpoint proof."""
from fractions import Fraction as Q
from math import factorial, isqrt


def bracket(a, b):
    return min(a, b), max(a, b)


def sqrt_bounds(x, scale=10**24):
    lower = isqrt((x.numerator * scale**2) // x.denominator)
    return Q(lower, scale), Q(lower + 1, scale)


def atan_bounds(x, n=24):
    total = sum((-1)**j * x**(2*j + 1) / (2*j + 1) for j in range(n))
    next_term = (-1)**n * x**(2*n + 1) / (2*n + 1)
    return bracket(total, total + next_term)


def density_at_zero_bounds():
    a, b = atan_bounds(Q(1, 5)), atan_bounds(Q(1, 239))
    pi_lo, pi_hi = 16*a[0] - 4*b[1], 16*a[1] - 4*b[0]
    return 1 / sqrt_bounds(2*pi_hi)[1], 1 / sqrt_bounds(2*pi_lo)[0]


C0 = density_at_zero_bounds()


def normal_center_bounds(x, n=28):
    total = sum((-1)**j * x**(2*j + 1) / (2**j * factorial(j) * (2*j + 1))
                for j in range(n))
    next_term = (-1)**n * x**(2*n + 1) / (2**n * factorial(n) * (2*n + 1))
    lo, hi = bracket(total, total + next_term)
    return 2*C0[0]*lo, 2*C0[1]*hi


def exp_negative_bounds(x, n=28):
    total = sum((-x)**j / factorial(j) for j in range(n))
    return bracket(total, total + (-x)**n / factorial(n))


def normal_second_moment_magnitude(lo, hi):
    return (
        2*lo*C0[0]*exp_negative_bounds(hi**2 / 2)[0],
        2*hi*C0[1]*exp_negative_bounds(lo**2 / 2)[1],
    )


def enclosure(bounds, lo, hi):
    assert Q(lo) < bounds[0] <= bounds[1] < Q(hi)
    return f"[{lo}, {hi}]"


def main():
    a0 = (Q("0.967421566101"), Q("0.967421566102"))
    b0 = (Q("0.430727299295"), Q("0.430727299296"))
    for interval, target in [(a0, Q(2, 3)), (b0, Q(1, 3))]:
        assert normal_center_bounds(interval[0])[1] < target
        assert normal_center_bounds(interval[1])[0] > target
    print("A0 and B0: certified normal-quantile intervals, width 10^-12")

    a_lo, a_hi = normal_second_moment_magnitude(*a0)
    b_lo, b_hi = normal_second_moment_magnitude(*b0)
    k0 = (
        2*(a_lo+b_lo)/3 + 2*a_lo*b_lo - b_hi**2,
        2*(a_hi+b_hi)/3 + 2*a_hi*b_hi - b_lo**2,
    )
    print("Independence quadratic endpoint coefficient k0:", enclosure(k0, "0.73582", "0.73584"))

    scale_lo, scale_hi = sqrt_bounds(Q(3, 4))
    # The singular -1/2 equicorrelation residuals are signed copies.
    s_sing = (
        3*normal_center_bounds(b0[0] / scale_hi)[0],
        3*normal_center_bounds(b0[1] / scale_lo)[1],
    )
    print("Singular equicorrelation -1/2 endpoint coefficient:", enclosure(s_sing, "1.14319", "1.14320"))

    delta0, h0 = Q(1, 10**13), Q(1, 10**60)
    assert 3*Q(2, 5)*4*11*4 + 3*Q(16, 6) < 250
    assert 432 + 3*(9*176 + 12*Q(1, 10)) < 6000
    assert 128*3*Q(11, 4)**12 < 10**8
    assert 192*10**8 < 2*10**10
    assert Q(1, 40)-6000*Q(1, 10**6) > Q(1, 80)
    assert Q(1, 160) - 2*10**10*delta0 > 0
    assert 250*h0 < delta0**4/90000
    print("All explicit cutoff and domination comparisons passed in rational arithmetic")


if __name__ == "__main__":
    main()
