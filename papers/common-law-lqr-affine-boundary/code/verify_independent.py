#!/usr/bin/env python3
"""Independent exact checks; finite checks supplement, and do not prove, the theorem.

Run from anywhere with: python verify_independent.py --local-only
Dependencies: Python 3.11+ and SymPy. No network, no randomness, no file writes.
"""

from __future__ import annotations

import argparse
from fractions import Fraction as F
from itertools import combinations, product
from math import comb
import json

import sympy as sp


def u3(xs):
    return sum((xs[i] * xs[j] * xs[k] for i, j, k in combinations(range(len(xs)), 3)), F(0)) / comb(len(xs), 3)


def enum_moments(values, probabilities, n):
    totals = [F(0)] * 4
    for inds in product(range(len(values)), repeat=n):
        xs = tuple(values[i] for i in inds)
        mass = F(1)
        for i in inds:
            mass *= probabilities[i]
        v = u3(xs)
        bar = sum(xs, F(0)) / n
        for j, term in enumerate((v, bar * v, v * v, (F(3, 7) * bar - sum(vv * pp for vv, pp in zip(values, probabilities))) * v)):
            totals[j] += mass * term
    return totals


def check_distinct_sample_moments():
    laws = [
        ((F(-1), F(1)), (F(1, 4), F(3, 4))),
        ((F(-2), F(1)), (F(1, 3), F(2, 3))),
        ((F(-3), F(1), F(2)), (F(1, 7), F(2, 7), F(4, 7))),
    ]
    count = 0
    for values, probs in laws:
        mu = sum(v * p for v, p in zip(values, probs))
        m2 = sum(v * v * p for v, p in zip(values, probs))
        y = m2 - mu * mu
        for n in range(3, 8):
            got = enum_moments(values, probs, n)
            expected_second = (
                mu**6
                + F(9, n) * mu**4 * y
                + F(18, n * (n - 1)) * mu * mu * y * y
                + F(6, n * (n - 1) * (n - 2)) * y**3
            )
            expected_overlap = sum(
                F(comb(3, k) * (comb(n - 3, 3 - k) if 0 <= 3 - k <= n - 3 else 0), comb(n, 3))
                * m2**k * mu ** (6 - 2 * k)
                for k in range(4)
            )
            expected = [
                mu**3,
                mu**4 + F(3, n) * y * mu * mu,
                expected_second,
                (F(3, 7) - 1) * mu**4 + F(3, 7) * F(3, n) * y * mu * mu,
            ]
            assert got == expected
            assert expected_overlap == expected_second
            count += 1
    return count


def check_common_support_posteriors():
    r, m = F(5, 3), F(1, 2)
    x, y = m * m, r * r - m * m
    n3_gap = F(0)
    histories = 0
    for n in range(4):
        affine_risk = F(0)
        bayes_risk = F(0)
        for signs in product((-1, 1), repeat=n):
            likelihoods = []
            for theta_sign in (-1, 1):
                prob = F(1)
                for z in signs:
                    prob *= (1 + theta_sign * m * z / r) / 2
                likelihoods.append(prob)
            marginal = sum(likelihoods) / 2
            posterior = m * (likelihoods[1] - likelihoods[0]) / sum(likelihoods)
            affine = F(0) if n == 0 else F(n) * x / (y + n * x) * (r * sum(signs) / n)
            if n <= 2:
                assert posterior == affine
            else:
                n3_gap += marginal * (posterior - affine) ** 2
            for k, theta_sign in enumerate((-1, 1)):
                affine_risk += likelihoods[k] / 2 * (affine - theta_sign * m) ** 2
                bayes_risk += likelihoods[k] / 2 * (posterior - theta_sign * m) ** 2
            histories += 1
        assert affine_risk == (x if n == 0 else x * y / (y + n * x))
        if n <= 2:
            assert affine_risk == bayes_risk
        else:
            assert affine_risk - bayes_risk == n3_gap > 0
    return histories


def check_explicit_uniform_certificate():
    x, s, z = sp.symbols("x s z", real=True)
    R = x / 4 + s**2 / 12 - x * (s**2 - x) / 192 + (x + s**2) ** 3 / 192**2
    dx = sp.diff(R, x)
    assert sp.simplify(dx - (sp.Rational(1, 4) - s**2 / 192 + x / 96 + (x + s**2)**2 / 12288)) == 0
    assert sp.Rational(1, 4) - sp.Rational(16, 192) == sp.Rational(1, 6)
    boundary = sp.expand(R.subs(x, s * (4 - s)))
    assert sp.expand(boundary - (s - s**2 / 12 - 35 * s**3 / 576 + s**4 / 96)) == 0
    P = sp.expand((576 * (sp.Rational(35, 24) - boundary)).subs(s, z + 3))
    expected = 3 + 9*z + 39*z**2 - 37*z**3 - 6*z**4
    assert P == expected
    # On [-3,0], the last two terms TOGETHER are nonnegative.
    assert sp.expand((-37*z**3 - 6*z**4) - (-z**3)*(37+6*z)) == 0
    assert 37 + 6*(-3) == 19 > 0
    assert sp.expand(3 + 9*z + 39*z**2 - (39*(z+sp.Rational(3, 26))**2 + sp.Rational(129, 52))) == 0
    # On [0,1], z^3,z^4 <= z^2; 9z-4z^2 >= 0.
    assert sp.expand(P - (3+9*z-4*z**2) - (37*z**2*(1-z)+6*z**2*(1-z**2))) == 0
    assert sp.Rational(3, 2) - sp.Rational(35, 24) == sp.Rational(1, 24)
    # Affine support certificate on x+(s-2)^2 <= 4.
    residual = 4 - (s-2)**2 - x
    assert sp.expand(sp.Rational(3, 2) - (x/4+s**2/12) - residual/4 - (s-3)**2/6) == 0
    return {"affine_value": "3/2", "nonlinear_certified_upper": "35/24", "certified_gap": "1/24"}


def check_affine_scalar_root_calculus():
    """Verify symbolic identities; uniqueness follows from the written sign proof."""
    x, v, t, s0, delta = sp.symbols("x v t s0 delta", positive=True)
    h, k = sp.symbols("h k", real=True)
    g = x*v/(v+t*x)
    assert sp.simplify(sp.diff(g, x)-v**2/(v+t*x)**2) == 0
    assert sp.simplify(sp.diff(g, v)-t*x**2/(v+t*x)**2) == 0
    Hess = sp.hessian(g, (x, v))
    direction = sp.Matrix([h, k])
    assert sp.simplify((direction.T*Hess*direction)[0]+2*t*(v*h-x*k)**2/(v+t*x)**3) == 0
    boundary = delta**2-(sp.sqrt(v)-s0)**2
    assert sp.simplify(sp.diff(boundary, v, 2)+s0/(2*v**sp.Rational(3, 2))) == 0
    assert sp.simplify(sp.diff(boundary, v).subs(v, s0**2)) == 0
    assert sp.simplify(sp.diff(boundary, v).subs(v, (s0+delta)**2)+delta/(s0+delta)) == 0
    assert sp.simplify(sp.diff(g, x).subs(x, 0)) == 1
    assert sp.simplify(sp.diff(g, v).subs(x, 0)) == 0
    return {"hessian_identity": True, "boundary_second_derivative": True, "endpoint_derivatives": True}


def check_scalar_lqr_embedding():
    values, probs = (F(-1), F(2)), (F(2, 5), F(3, 5))
    mu = sum(v*p for v, p in zip(values, probs))
    m2 = sum(v*v*p for v, p in zip(values, probs))
    expected_cost = expected_advantage = F(0)
    for inds in product(range(2), repeat=4):
        w = [values[i] for i in inds]
        mass = F(1)
        for i in inds:
            mass *= probs[i]
        f3 = sum(w[:3], F(0)) / 6 - w[0]*w[1]*w[2]/192
        u3_control = -f3/2
        cost = 2*u3_control*u3_control + 2*(u3_control+w[3])**2
        expected_cost += mass*cost
        expected_advantage += mass*(f3-mu)**2
    oracle_cost = 2*m2 - mu*mu
    assert expected_cost - oracle_cost == expected_advantage
    M3, H3 = F(4), F(-1, 2)
    assert M3*H3*H3 == 1
    return True


def check_vector_lqr_indefinite_costs():
    """Exact 2-state/2-control Bellman telescoping for a nonlinear causal policy."""
    T = 4
    A = sp.Matrix([[sp.Rational(1, 2), sp.Rational(1, 4)], [0, sp.Rational(1, 3)]])
    B = sp.Matrix([[1, 0], [sp.Rational(1, 5), 1]])
    Xi = sp.Matrix([1, 2])
    Q = sp.diag(-sp.Rational(1, 8), sp.Rational(1, 3))
    R = sp.Matrix([[3, sp.Rational(1, 2)], [sp.Rational(1, 2), 2]])
    D = sp.diag(sp.Rational(1, 10), -sp.Rational(1, 10))
    terminal = sp.Matrix([[2, sp.Rational(1, 3)], [sp.Rational(1, 3), 1]])
    S, P, N, G = [None]*(T+1), [None]*(T+1), [None]*(T+1), [None]*(T+1)
    Ms, Ks, Hs = [None]*T, [None]*T, [None]*T
    S[T], P[T], N[T], G[T] = terminal, sp.zeros(2, 1), sp.Rational(0), sp.Rational(0)
    for t in reversed(range(T)):
        M = R + B.T*S[t+1]*B
        assert M[0, 0] > 0 and M.det() > 0
        C = B.T*S[t+1]*A + D.T
        K = -M.inv()*C
        H = -M.inv()*B.T*(S[t+1]*Xi+P[t+1])
        S[t] = Q+A.T*S[t+1]*A-C.T*M.inv()*C
        P[t] = (A+B*K).T*(S[t+1]*Xi+P[t+1])
        N[t] = N[t+1]+(Xi.T*S[t+1]*Xi)[0]+2*(P[t+1].T*Xi)[0]-(H.T*M*H)[0]
        G[t] = G[t+1]+(Xi.T*S[t+1]*Xi)[0]
        Ms[t], Ks[t], Hs[t] = M, K, H
    assert Q[0, 0] < 0  # This check does not silently assume positive stage costs.
    values = (-sp.Rational(1), sp.Rational(2))
    probs = (sp.Rational(2, 5), sp.Rational(3, 5))
    mu = sum(v*p for v, p in zip(values, probs))
    variance = sum(v*v*p for v, p in zip(values, probs))-mu**2
    x0 = sp.Matrix([sp.Rational(1, 3), -sp.Rational(1, 4)])
    V0 = (x0.T*S[0]*x0)[0]+2*mu*(x0.T*P[0])[0]+mu**2*N[0]+variance*G[0]
    J, advantage = sp.Rational(0), sp.Rational(0)
    for inds in product(range(2), repeat=T):
        ws = [values[i] for i in inds]
        mass = sp.prod(probs[i] for i in inds)
        state = x0
        total, adv = sp.Rational(0), sp.Rational(0)
        for t in range(T):
            hist = ws[:t]
            multi = sp.prod(hist) if hist else sp.Rational(0)
            last = hist[-1] if hist else sp.Rational(0)
            u = sp.Matrix([sp.Rational(1, 7)+sum(hist, sp.Rational(0))/(t+1)+multi/13,
                           -sp.Rational(2, 5)+last/11-multi/17])
            total += (state.T*Q*state)[0]+2*(state.T*D*u)[0]+(u.T*R*u)[0]
            eta = u-Ks[t]*state-Hs[t]*mu
            adv += (eta.T*Ms[t]*eta)[0]
            # M-orthogonal scalar projection is a pointwise identity.
            v = u-Ks[t]*state
            weight = (Hs[t].T*Ms[t]*Hs[t])[0]
            if weight > 0:
                f = (Hs[t].T*Ms[t]*v)[0]/weight
                residual = v-Hs[t]*f
                assert sp.simplify((eta.T*Ms[t]*eta)[0]-weight*(f-mu)**2-(residual.T*Ms[t]*residual)[0]) == 0
            state = A*state+B*u+Xi*ws[t]
        total += (state.T*terminal*state)[0]
        J += mass*total
        advantage += mass*adv
    assert sp.simplify(J-V0-advantage) == 0
    return {"state_dimension": 2, "control_dimension": 2, "scalar_noise": True, "negative_stage_state_cost": True, "histories": 16}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--local-only", action="store_true")
    args = parser.parse_args()
    if not args.local_only:
        parser.error("pass --local-only to document offline reproduction")
    report = {
        "status": "passed",
        "arithmetic": "exact rational enumeration and symbolic polynomial identities",
        "distinct_sample_moment_cases": check_distinct_sample_moments(),
        "posterior_histories": check_common_support_posteriors(),
        "uniform_example": check_explicit_uniform_certificate(),
        "affine_scalar_root_calculus": check_affine_scalar_root_calculus(),
        "scalar_lqr_embedding": check_scalar_lqr_embedding(),
        "vector_lqr_identity": check_vector_lqr_indefinite_costs(),
        "limitation": "Finite enumerations do not prove the infinite-dimensional minimax theorem; see the written independent review.",
    }
    print(json.dumps(report, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
