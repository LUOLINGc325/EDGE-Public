"""Finite checks of reconstructed-tree likelihood and exact weak-contrast alternatives."""
from math import factorial

import numpy as np
from scipy.integrate import quad, solve_ivp


T = 1.4
TARGET = 0.52
BETA = 0.75
B = 0.83
LAMBDA = 0.98
MU = 0.78
RHO = (0.37, 0.86)
EPSILON = 0.06


def baseline(time, a, rho):
    """Return the pulled curve for a constant-rate birth–death population."""
    net = a * LAMBDA - B * MU
    primitive = time if net == 0 else np.expm1(net * time) / net
    survival = rho * np.exp(net * time) / (1 + a * LAMBDA * rho * primitive)
    return a * LAMBDA * survival


def bump(x, order):
    if abs(x) >= 1:
        return 0.0, 0.0, 0.0
    edge = 1 - x * x
    y = edge**6
    dy = -12 * x * edge**5
    ddy = -12 * edge**5 + 120 * x * x * edge**4
    monomial = x**order / factorial(order)
    slope = x**(order - 1) / factorial(order - 1)
    curvature = float(order == 2)
    return (
        monomial * y,
        slope * y + monomial * dy,
        curvature * y + 2 * slope * dy + monomial * ddy,
    )


def exp_average(x, offset):
    """Evaluate the series for integral_0^1 r^offset exp(r*x) dr."""
    assert abs(x) < 0.1
    return sum(x**k / (factorial(k) * (k + offset + 1)) for k in range(9))


def alternative(time, a1, a2, bandwidth, order):
    d = a2 - a1
    values = bump((time - TARGET) / bandwidth, order)
    u, du, ddu = (
        value * EPSILON * bandwidth ** (BETA + 2 - j)
        for j, value in enumerate(values)
    )
    p2 = baseline(time, a2, RHO[1])
    dp2 = p2 * (a2 * LAMBDA - B * MU - p2)
    e = d * u
    average = exp_average(e, 0)
    difference = du + p2 * u * average
    derivative = ddu + (dp2 * u + p2 * du) * average + p2 * u * d * du * exp_average(e, 1)
    new_birth = LAMBDA + difference
    new_death = MU + (derivative / new_birth + a1 * difference) / B
    return new_birth, new_death, e


def check_compensation():
    largest = 0.0
    for contrast in (0, 1e-7, 0.01, 0.7):
        a1 = 0.81
        a2 = a1 + contrast
        for h in (0.14, 0.07, 0.035):
            times = np.unique(np.r_[np.linspace(0, T, 201), TARGET, TARGET-h, TARGET+h])
            for order in (1, 2):
                birth, death, _ = alternative(TARGET, a1, a2, h, order)
                if order == 1:
                    assert np.isclose(birth - LAMBDA, EPSILON * h ** (BETA + 1))
                else:
                    assert np.isclose(death - MU, EPSILON * h**BETA / (B * LAMBDA))
                for j, a in enumerate((a1, a2)):
                    def survival_equation(t, s):
                        birth, death, _ = alternative(t, a1, a2, h, order)
                        return (a * birth * (1 - s) - B * death) * s

                    solution = solve_ivp(
                        survival_equation, (0, T), [RHO[j]], t_eval=times,
                        rtol=3e-11, atol=3e-12, max_step=h / 12,
                    )
                    assert solution.success
                    different = np.array([alternative(t, a1, a2, h, order) for t in times])
                    actual = a * different[:, 0] * solution.y[0]
                    prediction = baseline(times, a, RHO[j]) * np.exp(j * different[:, 2])
                    largest = max(largest, np.max(np.abs(actual - prediction)))
    assert largest < 3e-9
    print(f"48 independently integrated arm curves, maximum defect {largest:.3g}")


def check_likelihood():
    """Check the no-split and one-split masses for two nonconstant curves."""
    for a, rho in zip((0.8, 1.6), RHO):
        total = quad(lambda t: baseline(t, a, rho), 0, T, epsabs=1e-12)[0]
        no_split = np.exp(-total)

        def one_split_density(time):
            elapsed = quad(lambda t: baseline(t, a, rho), 0, time, epsabs=1e-12)[0]
            return baseline(time, a, rho) * np.exp(-total - elapsed)

        one_split = quad(one_split_density, 0, T, epsabs=1e-12)[0]
        assert np.isclose(one_split, no_split * (1 - no_split), atol=1e-11, rtol=0)
    print("conditional likelihood masses agree with the pure-birth tip-count laws")


if __name__ == "__main__":
    check_compensation()
    check_likelihood()
