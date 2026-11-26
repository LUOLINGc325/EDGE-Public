#!/usr/bin/env python3
"""Independent direct-kernel checks of the log-concave resetting theorem.

This script does not import the author's verification code. It independently:
  * solves the scalar boundary equation using adaptive quadrature;
  * reconstructs p from the proposed continuous measure and endpoint atoms;
  * evaluates the global certificate by direct convolution on the whole line;
  * checks the exact gap identity for asymmetric atomic competitors;
  * checks the failure of the point mass above the transition.

Numerical quadrature is a diagnostic, not a mathematical proof. All assertions
have explicit tolerances and the JSON report records actual errors. Requires
Python 3.10+, NumPy, and SciPy. Run from any directory, for example:

    python code/independent_review.py --output results/independent_numeric_results.json
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass
import json
import math
from pathlib import Path
from typing import Callable

import numpy as np
from scipy.integrate import quad
from scipy.optimize import brentq
from scipy.special import logsumexp


ABS_TOL = 2e-10
REL_TOL = 2e-10
CHECK_TOL = 2e-7


def exp_nonoverflow(log_value: float) -> float:
    if log_value < -745 or log_value == -math.inf:
        return 0.0
    return math.exp(log_value)


def positive_integral(f: Callable[[float], float], breaks=()) -> float:
    points = [0.0] + sorted({float(v) for v in breaks if v > 0}) + [math.inf]
    return sum(
        quad(f, lo, hi, epsabs=ABS_TOL, epsrel=REL_TOL, limit=300)[0]
        for lo, hi in zip(points[:-1], points[1:])
    )


def real_integral(f: Callable[[float], float], breaks=()) -> float:
    points = [-math.inf] + sorted({float(v) for v in breaks}) + [math.inf]
    return sum(
        quad(f, lo, hi, epsabs=ABS_TOL, epsrel=REL_TOL, limit=300)[0]
        for lo, hi in zip(points[:-1], points[1:])
    )


@dataclass
class Target:
    name: str
    V: Callable[[float], float]
    Vprime: Callable[[float], float]
    Vsecond: Callable[[float], float]


GAUSSIAN = Target("gaussian", lambda x: x*x/2, lambda x: x, lambda x: 1.0)
QUARTIC = Target("pure_quartic", lambda x: x**4/4, lambda x: x**3, lambda x: 3*x*x)
MIXED = Target("quadratic_quartic", lambda x: x*x/2 + x**4/4,
               lambda x: x+x**3, lambda x: 1+3*x*x)


def safe_cosh_potential(x: float) -> float:
    return math.inf if abs(x) > 700 else math.cosh(x)-1


COSH = Target("cosh", safe_cosh_potential, math.sinh, math.cosh)


class Candidate:
    def __init__(self, target: Target, alpha: float):
        self.target = target
        self.alpha = float(alpha)
        self.Z = 2*positive_integral(lambda x: exp_nonoverflow(-target.V(x)))
        self.logZ = math.log(self.Z)
        self.A = self.J(0.0)
        # A numerically constructed critical case may differ from 1 by a few ulps.
        self.is_delta = self.A <= 1 + 1e-11
        if self.is_delta:
            self.a = 0.0
            self.c = None
            self.atom_mass = 1.0  # total mass at the single location zero
            self.F_formula = 4*math.exp(self.logq(0))*self.A/self.alpha**2
        else:
            upper = 1.0
            while self.J(upper) > 1:
                upper *= 2
            self.a = brentq(lambda a: self.J(a)-1, 0, upper,
                            xtol=2e-12, rtol=1e-13)
            h_boundary = math.exp(self.logq(self.a)/2)
            denominator = 2*quad(lambda x: math.exp(self.logq(x)/2), 0, self.a,
                                 epsabs=ABS_TOL, epsrel=REL_TOL)[0]
            denominator += 2*h_boundary/self.alpha
            self.c = 1/denominator
            self.atom_mass = self.c*h_boundary*(
                self.alpha-target.Vprime(self.a)/2)/self.alpha**2
            self.F_formula = denominator**2

    def J(self, a: float) -> float:
        Va = self.target.V(a)
        return self.alpha*positive_integral(
            lambda u: exp_nonoverflow(-self.target.V(a+u)+Va+self.alpha*u))

    def logq(self, x: float) -> float:
        return -self.target.V(x)-self.logZ

    def logp(self, x: float) -> float:
        x = abs(x)
        if self.is_delta:
            return math.log(self.alpha/2)-self.alpha*x
        if x <= self.a:
            return math.log(self.c)+self.logq(x)/2
        return math.log(self.c)+self.logq(self.a)/2-self.alpha*(x-self.a)

    def density(self, x: float) -> float:
        if self.is_delta or abs(x) >= self.a:
            return 0.0
        t = self.target
        coefficient = 1+t.Vsecond(x)/(2*self.alpha**2)
        coefficient -= t.Vprime(x)**2/(4*self.alpha**2)
        return self.c*math.exp(self.logq(x)/2)*coefficient

    def kernel(self, z: float) -> float:
        return self.alpha/2*math.exp(-self.alpha*abs(z))

    def reconstruct(self, x: float) -> float:
        if self.is_delta:
            return self.kernel(x)
        points = [-self.a]
        if -self.a < x < self.a:
            points.append(x)
        points.append(self.a)
        result = sum(
            quad(lambda z: self.kernel(x-z)*self.density(z), lo, hi,
                 epsabs=ABS_TOL, epsrel=REL_TOL, limit=200)[0]
            for lo, hi in zip(points[:-1], points[1:])
        )
        return result+self.atom_mass*(self.kernel(x-self.a)+self.kernel(x+self.a))

    def potential(self, z: float, delta: bool = False) -> float:
        """Direct convolution G(z), exploiting only the known evenness of w."""
        z = abs(z)

        def integrand(x: float) -> float:
            lp = (math.log(self.alpha/2)-self.alpha*x) if delta else self.logp(x)
            lw = self.logq(x)-2*lp
            lk = math.log(self.alpha/2)
            return (exp_nonoverflow(lw+lk-self.alpha*abs(z-x))
                    + exp_nonoverflow(lw+lk-self.alpha*(z+x)))

        return positive_integral(integrand, (self.a, z))


def check_case(target: Target, alpha: float) -> dict:
    candidate = Candidate(target, alpha)
    c = candidate
    a = c.a
    F = 2*positive_integral(lambda x: exp_nonoverflow(c.logq(x)-c.logp(x)), (a,))
    mass = (1.0 if c.is_delta else
            2*quad(c.density, 0, a, epsabs=ABS_TOL, epsrel=REL_TOL)[0]
            + 2*c.atom_mass)
    extent = max(a+4/alpha, 4.0)
    grid = np.linspace(-extent, extent, 43)
    reconstruction_errors = [abs(c.reconstruct(float(x))/math.exp(c.logp(float(x)))-1)
                             for x in grid]
    positive_grid = list(np.linspace(0, extent, 55)) + [a, a+0.15/alpha, a+1/alpha]
    potentials = [(float(x), c.potential(float(x))) for x in sorted(set(positive_grid))]
    support_grid = [0.0] if c.is_delta else list(np.linspace(0, a, 13))
    support_error = max(abs(c.potential(float(x))/F-1) for x in support_grid)
    maximum_excess = max(value/F-1 for _, value in potentials)
    outside_gap = 1-c.potential(a+1/alpha)/F
    minimum_density = (None if c.is_delta else
                       min(c.density(float(x)) for x in np.linspace(-0.999*a, 0.999*a, 61)))

    assert abs(mass-1) < CHECK_TOL, (target.name, "mass", mass)
    assert abs(F/c.F_formula-1) < CHECK_TOL, (target.name, "objective", F, c.F_formula)
    assert max(reconstruction_errors) < CHECK_TOL, (target.name, "convolution")
    assert maximum_excess < CHECK_TOL, (target.name, "global certificate", maximum_excess)
    assert support_error < CHECK_TOL, (target.name, "support certificate", support_error)
    assert outside_gap > 0, (target.name, "strict outer certificate")
    if not c.is_delta:
        assert target.Vprime(a) < 2*alpha
        assert c.atom_mass > 0 and minimum_density > 0

    competitors = []
    specifications = [
        ([-2.1, -0.35, 0.8, 2.7], [0.15, 0.20, 0.40, 0.25]),
        ([0.73], [1.0]),
    ]
    for locations, weights in specifications:
        logweights = np.log(np.asarray(weights))
        positions = np.asarray(locations)

        def logpnu(x: float) -> float:
            return float(logsumexp(logweights+math.log(alpha/2)-alpha*np.abs(x-positions)))

        breaks = locations+[-a, 0.0, a]
        Fnu = real_integral(lambda x: exp_nonoverflow(c.logq(x)-logpnu(x)), breaks)

        def square_integrand(x: float) -> float:
            lpnu = logpnu(x)
            logratio = lpnu-c.logp(x)
            return exp_nonoverflow(c.logq(x)-lpnu)*math.expm1(logratio)**2

        square_term = real_integral(square_integrand, breaks)
        potential_term = sum(w*(F-c.potential(z)) for z, w in zip(locations, weights))
        difference = Fnu-F
        residual = abs(difference-square_term-potential_term)/max(1, abs(difference))
        assert difference >= -CHECK_TOL
        assert square_term >= 0 and potential_term >= -CHECK_TOL
        assert residual < CHECK_TOL, (target.name, "gap identity", residual)
        competitors.append({
            "locations": locations, "weights": weights,
            "F_competitor": Fnu, "objective_gap": difference,
            "square_term": square_term, "potential_term": potential_term,
            "normalized_gap_identity_residual": residual,
        })

    delta_failure = None
    if not c.is_delta:
        Fdelta = 4*math.exp(c.logq(0))*c.A/alpha**2
        z = 0.2*min(1, 1/alpha)
        while c.potential(z, delta=True) <= Fdelta and z > 1e-5:
            z /= 2
        derivative = Fdelta-c.potential(z, delta=True)
        assert derivative < 0, (target.name, "delta necessity")
        delta_failure = {"delta_objective": Fdelta, "perturbation_location": z,
                         "directional_derivative": derivative}

    boundary_expansion = None
    if not c.is_delta or abs(c.A-1) < 1e-9:
        step = 0.02*min(1, 1/alpha)
        predicted = alpha**2*F*(2*alpha-target.Vprime(a))/6
        observed = (F-c.potential(a+step))/step**3
        boundary_expansion = {"step": step, "predicted_cubic_coefficient": predicted,
                              "finite_step_ratio": observed,
                              "relative_difference": observed/predicted-1}

    return {
        "target": target.name, "alpha": alpha, "A": c.A,
        "regime": "delta" if c.is_delta else "interval_with_endpoint_atoms",
        "a": a, "Vprime_a": target.Vprime(a), "mass": mass,
        "endpoint_atom_each": None if c.is_delta else c.atom_mass,
        "minimum_sampled_interior_density": minimum_density,
        "F_direct": F, "F_formula": c.F_formula,
        "objective_relative_error": abs(F/c.F_formula-1),
        "maximum_reconstruction_relative_error": max(reconstruction_errors),
        "maximum_certificate_relative_excess": maximum_excess,
        "maximum_support_certificate_relative_error": support_error,
        "outer_certificate_relative_gap_at_a_plus_inverse_alpha": outside_gap,
        "asymmetric_competitors": competitors,
        "point_mass_failure_test": delta_failure,
        "boundary_cubic_diagnostic": boundary_expansion,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    critical_alpha = brentq(
        lambda alpha: alpha*positive_integral(lambda u: math.exp(-u*u/2+alpha*u))-1,
        0.1, 1.0, xtol=2e-13, rtol=1e-13)
    cases = [
        (GAUSSIAN, 0.25), (GAUSSIAN, critical_alpha), (GAUSSIAN, 1.0),
        (GAUSSIAN, 1.7), (QUARTIC, 1.0), (MIXED, 1.5), (COSH, 1.2),
    ]
    results = [check_case(target, alpha) for target, alpha in cases]
    report = {
        "status": "PASS",
        "review_scope": "Independent direct-kernel numerical diagnostics; not a proof",
        "quadrature_absolute_tolerance": ABS_TOL,
        "quadrature_relative_tolerance": REL_TOL,
        "assertion_tolerance": CHECK_TOL,
        "gaussian_critical_alpha": critical_alpha,
        "number_of_cases": len(results),
        "cases": results,
    }
    payload = json.dumps(report, indent=2, allow_nan=False)+"\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(payload, encoding="utf-8")
    print(json.dumps({
        "status": report["status"],
        "cases": len(results),
        "gaussian_critical_alpha": critical_alpha,
        "worst_reconstruction_relative_error": max(
            case["maximum_reconstruction_relative_error"] for case in results),
        "worst_certificate_relative_excess": max(
            case["maximum_certificate_relative_excess"] for case in results),
        "worst_gap_identity_residual": max(
            comp["normalized_gap_identity_residual"]
            for case in results for comp in case["asymmetric_competitors"]),
        "output": str(args.output) if args.output else None,
    }, indent=2))


if __name__ == "__main__":
    main()
