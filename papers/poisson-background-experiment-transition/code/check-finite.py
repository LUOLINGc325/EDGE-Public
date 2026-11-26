"""Rational inequalities for the exact continuum Poisson deficiency."""
from fractions import Fraction as Q
from math import factorial


def decay(t):
    """Strict Taylor enclosure of exp(-t), or equality at t=0."""
    polynomial = sum((-t) ** k / factorial(k) for k in range(33))
    return polynomial - t ** 33 / factorial(33), polynomial


def h(t, gamma):
    lam = 2 + 2 * t
    factor = sum(lam ** k / factorial(k) for k in range(4))
    factor += gamma * lam ** 4 / 24
    el, eu = decay(lam)
    return 1 - eu * factor, 1 - el * factor


def f(t, gamma):
    el, eu = decay(t)
    hl, hu = h(t, gamma)
    return 1 - eu - hu, 1 - el - hl


def derivative(t, gamma):
    lam = 2 + 2 * t
    factor = 2 * ((1 - gamma) * lam ** 3 / 6 + gamma * lam ** 4 / 24)
    fl, fu = decay(lam)
    el, eu = decay(t)
    return el - factor * fu, eu - factor * fl


g0, g1 = Q(266, 1000), Q(267, 1000)
l, r = Q(909, 1000), Q(910, 1000)
D_lower = Q(1187, 10000)
assert h(Q(0), g1)[0] > D_lower
for gamma in (g0, g1):
    assert derivative(l, gamma)[0] > 0
    assert derivative(r, gamma)[1] < 0
    assert f(Q(1), gamma)[0] > 0
assert f(l, g0)[1] + (r - l) * derivative(l, g0)[1] < h(Q(0), g0)[0]
assert f(r, g1)[0] > h(Q(0), g1)[1]
assert 2 * decay(Q(2))[1] * Q(51, 25) ** 3 / 6 < Q(2, 5)
assert decay(Q(1, 50))[0] * (1 - Q(1, 50) ** 2 / 2) > Q(9, 10)

for j in range(1001):
    t = Q(j, 1000)
    lo, hi = decay(t)
    Emin = [lo, lo * t, lo * t ** 2 / 2]
    for gamma in (g0, g1):
        hl, hu = h(t, gamma)
        Kmax = [1 - hl, Q(7, 10) * hu, Q(3, 10) * hu]
        for mask in (2, 4, 3, 5, 7, 6):
            if mask == 6 and j < 20:
                continue
            if mask == 7:
                upper = 1 - sum(Emin)
            else:
                upper = sum(
                    Kmax[i] - Emin[i] for i in range(3) if mask & 1 << i
                )
            assert upper + Q(4, 1000) < D_lower, (j, gamma, mask)

print("Verified root bracket and all required continuum-surplus certificates.")
