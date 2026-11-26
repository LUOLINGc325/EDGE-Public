#!/usr/bin/env python3
"""Exact finite checks in the qubit depolarizing specialization."""

from fractions import Fraction as F
from json import dumps


def survival(gamma, last):
    values = [F(1)]
    for n in range(1, last + 1):
        values.append(values[-1] * (1 - gamma / n))
    return values


def physical_error(gamma, delta, last):
    s = survival(gamma, last)
    p = [F(0)] + [s[i - 1] - s[i] for i in range(1, last + 1)]
    event = [F(1)]
    for t in range(1, last + 1):
        event.append((1 - delta) * sum(p[l] * event[t - l] for l in range(1, t + 1)))
    return [sum(s[t - l] * event[l] for l in range(t + 1)) for t in range(last + 1)]


def inverse_series(gamma, delta, last):
    """Extract coefficients by the exact convolution identity in Section 6."""
    u = [F(1)]
    for j in range(1, last + 1):
        u.append(u[-1] * (gamma + j - 1) / j)
    f = [F(1)]
    for t in range(1, last + 1):
        f.append(1 - delta * sum(u[l] * f[t - l] for l in range(1, t + 1)))
    return f


def main():
    last = 64
    gammas = [F(1, 4), F(1, 2), F(2, 3), F(7, 8)]
    deltas = [F(1, 20), F(1, 2), F(9, 10)]
    for gamma in gammas:
        for delta in deltas:
            f = physical_error(gamma, delta, last)
            assert f == inverse_series(gamma, delta, last)
            s = survival(gamma, last)
            assert all(0 < current <= 1 for current in f)
            assert all(a >= b for a, b in zip(f, f[1:]))
            assert all(f[t] >= s[t] for t in range(last + 1))
    s = survival(F(1, 2), last + 1)
    assert physical_error(F(1, 2), F(1, 2), last) == [2 * v for v in s[1:]]
    for t in range(last + 1):
        assert 2 * (s[t + 1] - s[t]) == -s[t] / (t + 1)
    print(dumps({"time_inclusive": last, "rational_gamma_delta_pairs": len(gammas) * len(deltas),
                 "independent_coefficient_comparisons": len(gammas) * len(deltas) * (last + 1),
                 "half_gamma_half_delta_exact_identity": "f_t=2*s_(t+1)",
                 "half_case_checks": last + 1}, indent=2))


if __name__ == "__main__":
    main()
