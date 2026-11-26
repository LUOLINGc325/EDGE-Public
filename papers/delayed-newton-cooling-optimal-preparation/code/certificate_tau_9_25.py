"""Exact rational certificate for the delayed-cooling optimum at tau=9/25.

This checks the algebraic root, branch conditions, and outward numerical
enclosures. Global optimality relies on the analytic theorem in the manuscripts;
this script does not purport to prove the infinite-dimensional theorem.
No third-party modules are required.
"""

from decimal import Decimal, ROUND_CEILING, ROUND_FLOOR, localcontext
from fractions import Fraction as F

TAU = F(9, 25)
LOWER = F(22460213487983754014, 10**20)
UPPER = F(22460213487983754015, 10**20)


def poly(z):
    return 1875 * z**4 - 1250 * z**3 - 10200 * z**2 + 10200 * z - 1767


def waiting(z):
    return z**2 - z + 1 - TAU


def crossing(z):
    return -z**2 + 2 * z + 2 * TAU - 1


def magnitude(z):
    w = waiting(z)
    return 1 - 2 * w + (w - TAU)**2


def step_relaxation(t):
    if t < 0:
        return F(1)
    from math import factorial
    return F(1) + sum(
        ((n * TAU - t)**(n + 1) / factorial(n + 1)
         for n in range(t // TAU + 1)), F(0))


def outward_decimal(value, direction):
    with localcontext() as ctx:
        ctx.prec = 24
        ctx.rounding = direction
        return str(Decimal(value.numerator) / Decimal(value.denominator))


def main():
    assert F(224, 1000) < LOWER < UPPER < F(225, 1000)
    assert poly(LOWER) < 0 < poly(UPPER)
    # P'(z)=7500 z^3-3750 z^2-20400 z+10200 is strictly positive
    # throughout [0.224,0.225], using this exact lower bound.
    derivative_lower = 10200 - 3750 * F(225, 1000)**2 - 20400 * F(225, 1000)
    assert derivative_lower > 0

    # w decreases with z and c increases with z on this interval.
    wl, wu = waiting(UPPER), waiting(LOWER)
    cl, cu = crossing(LOWER), crossing(UPPER)
    ml, mu = magnitude(LOWER), magnitude(UPPER)
    assert TAU < wl < wu < 2 * TAU
    assert 0 < cl < cu < TAU
    assert 0 < LOWER < UPPER < TAU
    assert 0 < ml < mu < 1

    # Exact identities at multiple rationals in the interval, as a guard
    # against transcription. The polynomial coefficient expansion is also
    # visible in the manuscript; these sample checks are not its proof.
    for z in (LOWER, (LOWER + UPPER) / 2, UPPER):
        w, c = waiting(z), crossing(z)
        assert 2 * step_relaxation(c + w) - step_relaxation(c) == 0
        balance = magnitude(z) + 2 * step_relaxation(c + TAU + w) - step_relaxation(c + TAU)
        assert balance == poly(z) / 3750

    print("PASS: exact rational sign isolation and monotonicity bounds")
    print("PASS: all method-of-steps branch conditions")
    for name, lower, upper in (
        ("z", LOWER, UPPER),
        ("waiting_time", wl, wu),
        ("crossing_time", cl, cu),
        ("magnitude", ml, mu),
        ("minimum_time", cl + TAU, cu + TAU),
    ):
        print(f"{name}: [{outward_decimal(lower, ROUND_FLOOR)}, "
              f"{outward_decimal(upper, ROUND_CEILING)}]")


if __name__ == "__main__":
    main()
