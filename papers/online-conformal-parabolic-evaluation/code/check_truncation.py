"""Rational bounds for the two analytic truncation allowances."""
from fractions import Fraction
from math import factorial


def lower_exp_at_integer(value, terms):
    return sum(Fraction(value**k, factorial(k)) for k in range(terms))


def main():
    # alpha=1/2, sigma=1/2, M=2. 2(G(M)-M) <= 4*sigma*phi(4).
    # phi(4) <= exp(-8)/2 since pi>2.
    e8_lower = lower_exp_at_integer(8, 32)
    drift = 1 / e8_lower
    assert drift < Fraction(336, 1_000_000)

    # R=20 log 2, e^(-R/2)=2^-10 and 2*G(0) <= 1.
    tail = Fraction(1, 1024)
    assert tail < Fraction(977, 1_000_000)
    print("alpha=1/2, M=2: drift truncation strictly below 0.000336")
    print("R=20 log 2: discount tail strictly below 0.000977")
    print("These are bounds on analytic truncation, excluding any PDE discretization.")


if __name__ == "__main__":
    main()
