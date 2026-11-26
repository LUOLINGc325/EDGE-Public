#!/usr/bin/env python3
"""Exact finite certificates for the noncommuting sharpness example.

Only Python's standard library is needed. Q(sqrt(2)) arithmetic is represented
by pairs of Fractions. These checks do not prove the infinite-time theorem.
"""
from __future__ import annotations

from fractions import Fraction as F
from pathlib import Path
import argparse
import json


class Q2:
    def __init__(self, a=0, b=0):
        self.a, self.b = F(a), F(b)

    @staticmethod
    def cast(value):
        return value if isinstance(value, Q2) else Q2(value)

    def __add__(self, other):
        other = self.cast(other)
        return Q2(self.a + other.a, self.b + other.b)

    __radd__ = __add__

    def __neg__(self):
        return Q2(-self.a, -self.b)

    def __sub__(self, other):
        return self + -self.cast(other)

    def __rsub__(self, other):
        return self.cast(other) + -self

    def __mul__(self, other):
        other = self.cast(other)
        return Q2(self.a * other.a + 2 * self.b * other.b,
                  self.a * other.b + self.b * other.a)

    __rmul__ = __mul__

    def __truediv__(self, other):
        other = self.cast(other)
        norm = other.a ** 2 - 2 * other.b ** 2
        if norm == 0:
            raise ZeroDivisionError
        return self * Q2(other.a / norm, -other.b / norm)

    def __eq__(self, other):
        other = self.cast(other)
        return self.a == other.a and self.b == other.b

    def record(self):
        return {"rational": str(self.a), "sqrt2": str(self.b)}


def run(horizon=48):
    checks = 0

    def check(condition, label):
        nonlocal checks
        if not condition:
            raise RuntimeError(label)
        checks += 1

    gamma = c = F(1, 2)
    rt2 = Q2(0, 1)
    xstar = Q2(F(3, 7), F(1, 7))
    amplitude = Q2(F(-4, 21), F(1, 21))
    check((Q2(3) - rt2) * xstar == 1, "effective-state equation")
    check(c * (rt2 - 2) * xstar / (1 + c) == amplitude,
          "leading coefficient identity")
    lo, hi = F(1414213562373095048, 10**18), F(1414213562373095049, 10**18)
    check(lo * lo < 2 < hi * hi, "sqrt(2) isolating interval")
    xlo, xhi = F(3, 7) + lo / 7, F(3, 7) + hi / 7
    dlo, dhi = (-4 + lo) / 21, (-4 + hi) / 21
    check(0 < xlo < xhi < 1, "initial density is positive")
    check(dlo < dhi < 0, "leading amplitude is strictly nonzero")
    check(c < 1, "strict jump contraction implies (W)")
    # On the x Bloch axis, Phi(x)=-x and R(x)=cx+1-c.
    check(-(1 - c) != 1 - c, "Phi and R do not commute at x=0")

    s, u, p = [F(1)], [F(1)], [F(0)]
    for n in range(1, horizon + 1):
        s.append(s[-1] * (n - gamma) / n)
        u.append(u[-1] * (n - 1 + gamma) / n)
        p.append(s[n - 1] * gamma / n)

    # Implementation 1: propagate each age sector in laboratory time.
    masses, moments, direct = [F(1)], [xstar], [xstar]
    for t in range(horizon):
        next_m = [F(0)] * (t + 2)
        next_x = [Q2() for _ in range(t + 2)]
        for age in range(t + 1):
            hazard = gamma / (age + 1)
            next_m[0] += hazard * masses[age]
            next_x[0] += hazard * (c * moments[age] + (1 - c) * masses[age])
            next_m[age + 1] = (1 - hazard) * masses[age]
            next_x[age + 1] = -(1 - hazard) * moments[age]
        masses, moments = next_m, next_x
        check(sum(masses) == 1, f"age mass at t={t+1}")
        for age, mass in enumerate(masses):
            check(mass == s[age] * u[t + 1 - age],
                  f"age-renewal identity t={t+1}, age={age}")
        direct.append(sum(moments, Q2()))

    # Implementation 2: ordered event renewal, then last-event convolution.
    v = [xstar]
    renewal = []
    for t in range(horizon + 1):
        if t:
            v.append(Q2((1-c)*u[t]) + sum(
                (p[ell] * c * (-1)**(ell-1) * v[t-ell]
                 for ell in range(1, t+1)), Q2()))
        state = sum((s[n] * (-1)**n * v[t-n] for n in range(t+1)), Q2())
        renewal.append(state)
        check(state == direct[t], f"direct versus event renewal t={t}")

    # Implementation 3: formal generating series H=1/(1-c*((1+w)^gamma-1)).
    k = [F(0)] + [c * (-1)**(ell-1) * p[ell] for ell in range(1, horizon+1)]
    h = [F(1)]
    for n in range(1, horizon + 1):
        h.append(sum(k[ell] * h[n-ell] for ell in range(1, n+1)))
    v_gf = []
    for n in range(horizon+1):
        v_gf.append(Q2(sum(h[j]*u[n-j]*(1-c) for j in range(n+1)))
                    + h[n]*(xstar-(1-c)))
        check(v_gf[n] == v[n], f"affine generating series t={n}")
    error_samples = []
    for t in [0, 1, 2, 8, 16, 32, horizon]:
        if t > horizon:
            continue
        complete = xstar * sum(s[n]*u[t-n]*(-1)**n for n in range(t+1))
        error_samples.append({"time": t, "bloch_error": (direct[t]-complete).record()})
    return {
        "schema_version": 1,
        "arithmetic": "exact rational pairs representing Q(sqrt(2))",
        "gamma": "1/2", "c": "1/2", "initial_state": "rho_eff",
        "horizon": horizon, "checks": checks, "status": "passed",
        "effective_bloch_x": xstar.record(), "leading_bloch_amplitude": amplitude.record(),
        "sqrt2_interval": [str(lo), str(hi)],
        "amplitude_interval": [str(dlo), str(dhi)],
        "error_samples": error_samples,
        "scope": "Finite exact identities, density feasibility, noncommutation, (W) sufficient certificate, and nonzero asymptotic coefficient; not a proof of the asymptotic theorem."
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--horizon", type=int, default=48)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    result = run(args.horizon)
    rendered = json.dumps(result, indent=2, sort_keys=True) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered, encoding="utf-8")
    print(f"PASS: {result['checks']} exact checks, t=0..{args.horizon}")
    print("x_eff=(3+sqrt(2))/7; D_-=(sqrt(2)-4)/21 < 0")
    print("These finite checks do not prove the asymptotic theorem.")
