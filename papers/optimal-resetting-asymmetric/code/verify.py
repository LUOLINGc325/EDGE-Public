#!/usr/bin/env python3
"""Reproduce beta-logistic examples and check the density and dual certificate."""
from dataclasses import dataclass
import json
from pathlib import Path

import mpmath as mp


def logistic(x):
    return 1 / (1 + mp.exp(-x))


def increasing_zero(f):
    """Bracket and bisect a continuous, strictly increasing scalar function."""
    lo, hi = mp.mpf(-1), mp.mpf(1)
    for _ in range(20):
        if f(lo) <= 0 and f(hi) >= 0:
            break
        lo *= 2
        hi *= 2
    else:
        raise ValueError("Failed to bracket a root")
    for _ in range(185):
        mid = (lo + hi) / 2
        if f(mid) <= 0:
            lo = mid
        else:
            hi = mid
    return (lo + hi) / 2


@dataclass(frozen=True)
class BetaLogistic:
    left_slope: mp.mpf
    right_slope: mp.mpf

    @property
    def normalizer(self):
        return mp.beta(self.left_slope, self.right_slope)

    def potential(self, x):
        return (
            self.left_slope * mp.log1p(mp.exp(-x))
            + self.right_slope * mp.log1p(mp.exp(x))
        )

    def gradient(self, x):
        return (self.left_slope + self.right_slope) * logistic(x) - self.left_slope

    def curvature(self, x):
        return (self.left_slope + self.right_slope) * logistic(x) * logistic(-x)

    def q(self, x):
        return mp.exp(-self.potential(x)) / self.normalizer

    def tilted_left(self, x, alpha):
        if alpha >= self.left_slope:
            return mp.inf
        incomplete = mp.betainc(
            self.left_slope - alpha, self.right_slope + alpha, 0, logistic(x)
        )
        return mp.exp(alpha * x) * incomplete / self.normalizer

    def tilted_right(self, x, alpha):
        if alpha >= self.right_slope:
            return mp.inf
        incomplete = mp.betainc(
            self.right_slope - alpha, self.left_slope + alpha, 0, logistic(-x)
        )
        return mp.exp(-alpha * x) * incomplete / self.normalizer

    def h_left(self, x, alpha):
        return alpha * self.tilted_left(x, alpha) / self.q(x)

    def h_right(self, x, alpha):
        return alpha * self.tilted_right(x, alpha) / self.q(x)

    def balanced_atom(self, alpha):
        assert alpha < min(self.left_slope, self.right_slope)
        return increasing_zero(
            lambda x: self.tilted_left(x, alpha) - self.tilted_right(x, alpha)
        )

    def critical_alpha(self):
        hi = min(self.left_slope, self.right_slope) / 2
        lo = mp.mpf(0)
        for _ in range(150):
            mid = (lo + hi) / 2
            x = self.balanced_atom(mid)
            if self.h_left(x, mid) <= 1:
                lo = mid
            else:
                hi = mid
        return (lo + hi) / 2


@dataclass
class ResetLaw:
    target: BetaLogistic
    alpha: mp.mpf
    left: mp.mpf
    right: mp.mpf
    center: mp.mpf | None

    def __post_init__(self):
        if self.center is not None:
            self.scale = None
            self.atoms = [(self.center, mp.mpf(1))]
            return
        a, b = self.left, self.right
        z = mp.quad(self.h, [a, b])
        if mp.isfinite(a):
            z += self.h(a) / self.alpha
        if mp.isfinite(b):
            z += self.h(b) / self.alpha
        self.scale = 1 / z
        self.atoms = []
        if mp.isfinite(a):
            self.atoms.append((
                a, self.p(a) * (self.alpha + self.target.gradient(a) / 2) / self.alpha**2
            ))
        if mp.isfinite(b):
            self.atoms.append((
                b, self.p(b) * (self.alpha - self.target.gradient(b) / 2) / self.alpha**2
            ))

    def h(self, x):
        return mp.sqrt(self.target.q(x))

    def kernel(self, x):
        return self.alpha / 2 * mp.exp(-self.alpha * abs(x))

    def p(self, x):
        if self.center is not None:
            return self.kernel(x - self.center)
        if x < self.left:
            return self.scale * self.h(self.left) * mp.exp(-self.alpha * (self.left - x))
        if x > self.right:
            return self.scale * self.h(self.right) * mp.exp(-self.alpha * (x - self.right))
        return self.scale * self.h(x)

    def density(self, x):
        if self.center is not None or x < self.left or x > self.right:
            return mp.mpf(0)
        v1, v2 = self.target.gradient(x), self.target.curvature(x)
        return self.p(x) * (1 + v2 / (2 * self.alpha**2) - v1**2 / (4 * self.alpha**2))

    def split(self, *extra):
        return sorted({-mp.inf, self.left, self.right, mp.inf, *extra})

    def mass(self):
        continuous = mp.mpf(0) if self.center is not None else mp.quad(
            self.density, [self.left, self.right]
        )
        return continuous + sum(weight for _, weight in self.atoms)

    def reconstruction(self, x):
        value = sum(weight * self.kernel(x - y) for y, weight in self.atoms)
        if self.center is None:
            points = sorted({self.left, self.right, max(self.left, min(self.right, x))})
            value += mp.quad(lambda y: self.kernel(x - y) * self.density(y), points)
        return value

    def objective(self):
        return mp.quad(lambda x: self.target.q(x) / self.p(x), self.split())

    def certificate(self, x):
        return mp.quad(
            lambda y: self.kernel(x - y) * self.target.q(y) / self.p(y)**2, self.split(x)
        )


def solve(target, alpha):
    have_left = target.left_slope > 2 * alpha
    have_right = target.right_slope > 2 * alpha
    if have_left and have_right:
        center = target.balanced_atom(alpha)
        if target.h_left(center, alpha) <= 1:
            return ResetLaw(target, alpha, center, center, center)
    a = increasing_zero(lambda x: target.h_left(x, alpha) - 1) if have_left else -mp.inf
    b = increasing_zero(lambda x: 1 - target.h_right(x, alpha)) if have_right else mp.inf
    if not a < b:
        raise ArithmeticError("The candidate interval is empty")
    return ResetLaw(target, alpha, a, b, None)


def decimal(value, digits=17):
    return None if not mp.isfinite(value) else mp.nstr(value, digits)


def check_law(target, alpha, label):
    law = solve(target, alpha)
    assert all(weight > 0 for _, weight in law.atoms)
    tol = mp.mpf("1e-37")
    assert abs(law.mass() - 1) < tol
    objective = law.objective()
    finite = [x for x in (law.left, law.right) if mp.isfinite(x)]
    points = {mp.mpf(-4), mp.mpf(-1), mp.mpf(0), mp.mpf(1), mp.mpf(4)}
    for x in finite:
        points.update({x - mp.mpf(1) / 2, x, x + mp.mpf(1) / 2})
    error = max(abs(law.reconstruction(x) - law.p(x)) for x in points)
    assert error < tol
    for x in points:
        value = law.certificate(x)
        if law.left <= x <= law.right:
            assert abs(value - objective) < tol
        else:
            assert value < objective
    return {
        "case": label, "alpha": decimal(alpha),
        "left": decimal(law.left), "right": decimal(law.right),
        "center": None if law.center is None else decimal(law.center),
        "atoms": [[decimal(x), decimal(w)] for x, w in law.atoms],
        "objective": decimal(objective),
        "maximum_sampled_reconstruction_error": decimal(error),
    }


def check_cubic(target, critical):
    bc = target.balanced_atom(critical)
    kappa = target.gradient(bc) / (2 * critical)
    coefficient = target.q(bc) / (6 * critical**2 * (1 - kappa**2))
    rows = []
    for offset in map(mp.mpf, ("1e-2", "1e-3", "1e-4", "1e-5")):
        alpha = critical + offset
        center = target.balanced_atom(alpha)
        epsilon = target.h_left(center, alpha) - 1
        law = solve(target, alpha)
        assert law.left < center < law.right
        difference = mp.quad(
            lambda x: target.q(x) * (law.kernel(x - center) - law.p(x))**2
            / (law.kernel(x - center) * law.p(x)**2),
            law.split(center),
        )
        atom_objective = (2 / alpha) * (
            target.tilted_left(center, alpha) + target.tilted_right(center, alpha)
        )
        assert abs(atom_objective - law.objective() - difference) < mp.mpf("1e-37")
        rows.append({
            "alpha_minus_critical": decimal(offset),
            "epsilon": decimal(epsilon),
            "objective_gain": decimal(difference),
            "gain_over_epsilon_cubed": decimal(difference / epsilon**3),
        })
    assert abs(mp.mpf(rows[-1]["gain_over_epsilon_cubed"]) / coefficient - 1) < mp.mpf("0.002")
    return {"critical_center": decimal(bc), "predicted_coefficient": decimal(coefficient), "rows": rows}


def main():
    mp.mp.dps = 55
    target = BetaLogistic(mp.mpf(1), mp.mpf(3))
    reflected = BetaLogistic(mp.mpf(3), mp.mpf(1))
    critical = target.critical_alpha()
    cases = [
        check_law(target, critical / 2, "single atom"),
        check_law(target, (critical + mp.mpf("0.5")) / 2, "bounded interval"),
        check_law(target, mp.mpf("0.5"), "left slope at equality"),
        check_law(target, mp.mpf("0.8"), "left boundary absent"),
        check_law(reflected, mp.mpf("0.8"), "right boundary absent"),
        check_law(target, mp.mpf("1.6"), "both boundaries absent"),
    ]
    assert cases[0]["center"] is not None and len(cases[1]["atoms"]) == 2
    assert cases[2]["left"] is None and len(cases[2]["atoms"]) == 1
    assert cases[3]["left"] is None and cases[4]["right"] is None
    assert not cases[-1]["atoms"]
    result = {
        "precision_decimal_digits": mp.mp.dps,
        "target_slopes": [1, 3],
        "critical_alpha": decimal(critical),
        "cases": cases,
        "cubic_gain": check_cubic(target, critical),
        "scope": "High-precision numerical checks, without interval arithmetic.",
    }
    destination = Path(__file__).resolve().parents[1] / "results" / "verification.json"
    destination.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(destination.name)


if __name__ == "__main__":
    main()
