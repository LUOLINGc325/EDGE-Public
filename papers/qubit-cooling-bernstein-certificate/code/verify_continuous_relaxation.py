#!/usr/bin/env python3
"""Exact certificate that the real-valued relaxation of the shell bound fails.

Uses only the Python standard library.  Every inequality used as a certificate
is checked with fractions.Fraction; Decimal is used only for human-readable
output.  Run from the case directory: python code/verify_continuous_relaxation.py
"""

from decimal import Decimal, localcontext
from fractions import Fraction as Q


def decimal_string(value: Q, precision: int = 40) -> str:
    with localcontext() as context:
        context.prec = precision
        return str(Decimal(value.numerator) / Decimal(value.denominator))


def main() -> None:
    length = 150
    f = [Q(max(0, i - 75) * (150 - i), 70300) for i in range(151)]
    n = [1 + value for value in f]
    r = Q(45001, 44998)
    m = sum(n, Q(0))
    powers = [r**i for i in range(length + 1)]
    s = sum((a * weight for a, weight in zip(n, powers)), Q(0))
    h = [n[i] * n[i + 1] / (n[i] + n[i + 1]) for i in range(length)]
    d = s - (1 + r) * sum(
        (edge * weight for edge, weight in zip(h, powers)), Q(0)
    )
    gap = m * d / s - 1

    # These are short, exact rational bounds on the full exact computation.
    lower = Q(-1093803967, 10**15)
    upper = Q(-1093803966, 10**15)
    assert all(value >= 1 for value in n)
    assert n[0] == n[-1] == 1
    assert any(value.denominator > 1 for value in n)
    assert sum(f, Q(0)) == 1
    assert m == 152
    assert r > 1 and s > 0
    assert lower < gap < upper < 0
    assert m * d < s

    # Independent exact check of the identity used in the analytic expansion.
    energy = sum(
        (powers[i] * (n[i] - r * n[i + 1]) ** 2 / (n[i] + n[i + 1])
         for i in range(length)), Q(0)
    )
    assert (1 + r) * d == r * n[0] + n[-1] * powers[-1] + energy

    # Along n_i(eps)=1+eps*f_i and r(eps)=1+eps*theta,
    # m(eps)*D(eps)/S(eps)-1 = quadratic*eps**2 + O(eps**3).
    n_shells = length + 1
    theta = Q(3, 44998)
    e = sum(((f[i + 1] - f[i]) ** 2 for i in range(length)), Q(0))
    moment = sum(((Q(i) - Q(length, 2)) * f[i]
                  for i in range(n_shells)), Q(0))
    c = Q(length * (length - 1), 12)
    assert e == Q(1, 35150)
    assert moment == Q(75, 2)
    assert theta == moment / (2 * c * n_shells)
    quadratic = e / 4 - theta * moment / n_shells + c * theta**2
    assert quadratic == Q(1, 140600) - Q(225, 27178792)
    assert quadratic < 0

    print("All certificate comparisons below use exact rational arithmetic.")
    print(f"L = {length}; m = {m}; r = {r}")
    print("n_i = 1 + max(0, i-75)*(150-i)/70300, 0 <= i <= 150")
    print("All n_i >= 1; n_0 = n_150 = 1; some n_i are nonintegers.")
    print(f"Exact gap enclosure: {lower} < m*D/S - 1 < {upper} < 0")
    print(f"m*D/S - 1 = {decimal_string(gap)} (display only)")
    print(f"m*D/S = {decimal_string(1 + gap)} (display only)")
    print(f"Quadratic coefficient = {quadratic} < 0")
    print("PASS: the real-valued relaxation fails even with integer total m=152.")
    print("This does not violate the positive-integer shell-degeneracy claim.")


if __name__ == "__main__":
    main()
