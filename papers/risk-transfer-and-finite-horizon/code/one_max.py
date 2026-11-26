"""Exact polynomial arithmetic for the CVaR one-max minimax formula.

The delay-polynomial strategy is from Christianson et al. (2024), Eq. (7).
The accompanying manuscript supplies its missing all-parameter lower bound.
All functions with suffix _exact use Fraction arithmetic and require delta>0.
The plotting helpers are explicitly floating-point, not proof certificates.
"""
from fractions import Fraction as F
from math import ceil, exp, factorial, lgamma, log


def _check(a, delta, t):
    if not (a >= 1 and 0 < delta < 1 and 0 <= t <= 1):
        raise ValueError("require a>=1, 0<delta<1, and 0<=t<=1")


def delay_exact(a, delta, t=F(1)):
    """E_{a,delta}(t), with the zeroth summand explicitly equal to one."""
    a, delta, t = F(a), F(delta), F(t)
    _check(a, delta, t)
    total, j = F(1), 1
    while j * delta < t:
        total += (a * (t - j * delta) / (1 - delta)) ** j / factorial(j)
        j += 1
    return total


def quantile_exact(a, delta, t=F(1)):
    a = F(a)
    return 1 + (a - 1) * delay_exact(a, delta, t)


def excess_integral_exact(a, delta, z):
    """Integral_0^z [phi_{a,delta}(s)-1] ds, by exact integration."""
    a, delta, z = F(a), F(delta), F(z)
    _check(a, delta, z)
    total, j = z, 1
    while j * delta < z:
        total += (a / (1 - delta)) ** j * (z - j * delta) ** (j + 1) / factorial(j + 1)
        j += 1
    return (a - 1) * total


def root_bracket_exact(theta, delta, bits=60):
    """Certified rational interval: H(lo)<=theta<=H(hi)."""
    theta, delta = F(theta), F(delta)
    if theta < 1 or not 0 < delta < 1 or bits < 1:
        raise ValueError("invalid theta, delta or precision")
    if theta == 1:
        return F(1), F(1)
    lo, hi = F(1), theta
    for _ in range(bits):
        mid = (lo + hi) / 2
        value = quantile_exact(mid, delta)
        if value == theta:
            return mid, mid
        if value < theta:
            lo = mid
        else:
            hi = mid
    if not quantile_exact(lo, delta) <= theta <= quantile_exact(hi, delta):
        raise ArithmeticError("invalid root bracket")
    return lo, hi


def finite_obstruction_exact(theta, delta, a):
    """Certificate that a finite family defeats any proposed ratio <=a.

    Uses Proposition 4.1 of the manuscript; this computes the scalar certificate,
    not an enumeration over online algorithms. All N+1 inputs have length N+2.
    """
    theta, delta, a = F(theta), F(delta), F(a)
    e = delay_exact(a, delta)
    h_value = 1 + (a - 1) * e
    if theta <= h_value:
        raise ValueError("a is not strictly below the minimax root")
    required = (theta - 1) * (e - 1) / (theta - h_value)
    n = max(1, required.numerator // required.denominator + 1)
    mesh = (theta - 1) / n
    residual = theta - h_value - mesh * (e - 1)
    if residual <= 0:
        raise ArithmeticError("nonpositive obstruction residual")
    return dict(theta=str(theta), delta=str(delta), proposed_ratio=str(a),
                E=str(e), H=str(h_value), N=n, mesh=str(mesh),
                input_family_size=n + 1, common_horizon=n + 2,
                positive_residual=str(residual))


def delay_float(a, delta, t=1.0):
    if delta == 0:
        return exp(a * t)
    if not 0 < delta < 1:
        raise ValueError("require 0<=delta<1")
    total = 1.0
    for j in range(1, ceil(t / delta)):
        x = a * max(t - j * delta, 0.0) / (1 - delta)
        if x > 0:
            total += exp(j * log(x) - lgamma(j + 1))
    return total


def root_float(theta, delta):
    if theta < 1 or not 0 <= delta <= 1:
        raise ValueError("invalid parameter")
    if theta == 1:
        return 1.0
    if delta >= 0.5:
        return theta ** 0.5
    lo, hi = 1.0, max(2.0, 1.0 + log(theta))
    while 1 + (hi - 1) * delay_float(hi, delta) < theta:
        hi *= 2
    for _ in range(70):
        mid = (lo + hi) / 2
        if 1 + (mid - 1) * delay_float(mid, delta) < theta:
            lo = mid
        else:
            hi = mid
    return (lo + hi) / 2
