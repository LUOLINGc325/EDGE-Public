#!/usr/bin/env python3
"""Independent checks of the three-state entropy-range manuscript.

This verifier was written by a distinct reviewing agent, without reading an
author-side checker. Random embeddings are built by general real similarities
on the zero-sum plane, rather than by the manuscript's (x,y,z,c) construction.
Their exponentials, stationary distributions, and entropy rates are then
computed directly from the full matrices. Exact algebra and the manuscript's
explicit boundary family are checked separately.

The finite checks supplement the written proof. They do not prove a universal
theorem, establish novelty, or constitute proof-assistant verification.
"""
from __future__ import annotations

if not __debug__:
    raise RuntimeError("Verification requires assertions; run Python without -O.")

import argparse
import hashlib
import json
import platform
import random
from datetime import datetime, timezone
from pathlib import Path

import mpmath as mp
import sympy as sp


mp.mp.dps = 90
TOL = mp.mpf("1e-65")
SEED = 2026112403
ONE = mp.matrix([[mp.mpf(1) / 3] * 3 for _ in range(3)])
EYE = mp.eye(3)
E = mp.matrix([
    [1 / mp.sqrt(2), 1 / mp.sqrt(6)],
    [-1 / mp.sqrt(2), 1 / mp.sqrt(6)],
    [0, -2 / mp.sqrt(6)],
])
J = mp.matrix([[0, -1], [1, 0]])
SHIFT = mp.matrix([[0, 1, 0], [0, 0, 1], [1, 0, 0]])


def maxabs(a):
    return max(abs(a[i, j]) for i in range(a.rows) for j in range(a.cols))


def show(x):
    return mp.nstr(x, 35)


def stationary(q):
    equations = q.T.copy()
    for j in range(3):
        equations[2, j] = 1
    return mp.lu_solve(equations, mp.matrix([0, 0, 1]))


def raw_entropy(q, pi):
    """Definition using directed stationary fluxes, independently of parameters."""
    value = mp.mpf(0)
    for i in range(3):
        for j in range(3):
            if i == j:
                continue
            f, b = pi[i] * q[i, j], pi[j] * q[j, i]
            if f > 0 and b == 0:
                return mp.inf
            if f > 0:
                assert b > 0
                value += f * mp.log(f / b)
    return value


def reciprocal(q):
    return all((q[i, j] > 0) == (q[j, i] > 0)
               for i in range(3) for j in range(i + 1, 3))


def gap(u, omega):
    return 2 * omega / mp.sqrt(3) * mp.log(
        (u + mp.sqrt(3) * omega) / (u - mp.sqrt(3) * omega))


def inspect(q, u, omega, t, sign, *, positive=True):
    lam = sign * mp.exp(-u * t)
    expected = lam * EYE + (1 - lam) * ONE
    if positive:
        assert all(q[i, j] > 0 for i in range(3) for j in range(3) if i != j)
        assert reciprocal(q)
    else:
        assert all(q[i, j] >= 0 for i in range(3) for j in range(3) if i != j)
    assert max(abs(sum(q[i, j] for j in range(3))) for i in range(3)) < TOL
    assert max(abs(sum(q[i, j] for i in range(3))) for j in range(3)) < TOL
    p = mp.expm(t * q)
    # Scaling by |lambda| makes this meaningful even for very strongly mixed P.
    exp_error = maxabs(p - expected) / abs(lam)
    assert exp_error < TOL, ("matrix exponential", show(exp_error))
    pi = stationary(q)
    stationary_error = max(abs(pi[i] - mp.mpf(1) / 3) for i in range(3))
    assert stationary_error < TOL
    activity = sum(pi[i] * sum(q[i, j] for j in range(3) if j != i)
                   for i in range(3))
    activity_error = abs(activity - 2 * u / 3)
    assert activity_error < TOL
    entropy = raw_entropy(q, pi)
    if positive:
        paired = sum(
            (pi[i] * q[i, j] - pi[j] * q[j, i])
            * mp.log((pi[i] * q[i, j]) / (pi[j] * q[j, i]))
            for i in range(3) for j in range(i + 1, 3))
        assert abs(paired - entropy) < TOL
        assert entropy + TOL >= gap(u, omega)
    return entropy, exp_error, stationary_error, activity_error


def exact_algebra():
    x, y, z, c, h, u, w, d, s = sp.symbols("x y z c h u w d s", real=True)
    q = sp.Matrix([[-x-z, x+c, z-c],
                   [x-c, -x-y, y+c],
                   [z+c, y-c, -y-z]])
    delta = x*x + y*y + z*z - x*y - y*z - z*x
    expected = h * ((h+x+y+z)**2 - delta + 3*c*c)
    assert sp.expand((h*sp.eye(3)-q).det() - expected) == 0
    assert q * sp.ones(3, 1) == sp.zeros(3, 1)
    assert sp.ones(1, 3) * q == sp.zeros(1, 3)
    # Re-derive all balanced off-diagonal rates from six unconstrained symbols.
    a, b, f, g, k, ell = sp.symbols("a b f g k ell", real=True)
    raw = sp.Matrix([[-a-f, a, f], [b, -b-k, k], [g, ell, -g-ell]])
    balances = list(sp.ones(1, 3) * raw)
    solution = sp.solve(balances, (g, ell), dict=True)
    assert solution == [{g: a-b+f, ell: -a+b+k}]
    assert sp.simplify(delta.subs({x: u/3-2*d, y: u/3+d, z: u/3+d})) == 9*d*d
    assert sp.simplify(3*(w*w/3+3*d*d)-9*d*d-w*w) == 0
    positive_c, positive_s = sp.symbols("C S", positive=True)
    fcs = sp.log((positive_s+positive_c)/(positive_s-positive_c))
    curvature = 4*positive_c*positive_s/(positive_s**2-positive_c**2)**2
    assert sp.simplify(sp.diff(fcs, positive_s, 2)-curvature) == 0
    bound = 2*positive_c*sp.log((u+3*positive_c)/(u-3*positive_c))
    derivative = (2*sp.log((u+3*positive_c)/(u-3*positive_c))
                  +12*u*positive_c/(u*u-9*positive_c**2))
    assert sp.simplify(sp.diff(bound, positive_c)-derivative) == 0
    return {
        "characteristic_polynomial": "exact symbolic identity verified",
        "row_and_column_balance": "exact symbolic identities verified",
        "six_rate_balance_solution": {str(k): str(v) for k, v in solution[0].items()},
        "boundary_family_spectral_invariant": "exact symbolic identity verified",
        "entropy_convexity_and_monotonicity_derivatives": "exact symbolic identities verified",
    }


def randomized_similarity_checks():
    rng = random.Random(SEED)
    worst = [mp.mpf(0)] * 3
    smallest_excess = mp.inf
    nonnormal_count = 0
    accepted = rejected = 0
    blocks = []
    for sign, multipliers in ((1, (2, 4)), (-1, (1, 3))):
        for frequency_multiplier in multipliers:
            for factor_text in ("1.05", "1.2", "2.0"):
                t = mp.mpf("1.7")
                omega = frequency_multiplier * mp.pi / t
                u = mp.mpf(factor_text) * mp.sqrt(3) * omega
                count = 0
                attempts = 0
                while count < 12:
                    attempts += 1
                    assert attempts < 10000
                    scale = .04 if factor_text == "1.05" else .25
                    aa, bb, cc = [mp.mpf(repr(rng.uniform(-scale, scale))) for _ in range(3)]
                    transform = mp.matrix([[mp.exp(aa), bb], [cc, mp.exp(-aa)]])
                    b = -u * mp.eye(2) + omega * transform * J * transform**-1
                    q = E * b * E.T
                    if min(q[i, j] for i in range(3) for j in range(3) if i != j) <= 0:
                        rejected += 1
                        continue
                    entropy, *errors = inspect(q, u, omega, t, sign)
                    worst = [max(a, b) for a, b in zip(worst, errors)]
                    smallest_excess = min(smallest_excess, entropy-gap(u, omega))
                    if maxabs(q*q.T-q.T*q) > mp.mpf("1e-20"):
                        nonnormal_count += 1
                    accepted += 1
                    count += 1
                blocks.append({"lambda_sign": sign, "frequency_pi_over_t": frequency_multiplier,
                               "u_over_threshold": factor_text, "accepted": count})
    return {"accepted": accepted, "rejected_non_generators": rejected,
            "nonnormal_accepted": nonnormal_count, "blocks": blocks,
            "max_exponential_error_divided_by_abs_lambda": show(worst[0]),
            "max_stationary_probability_error": show(worst[1]),
            "max_activity_error": show(worst[2]),
            "smallest_observed_entropy_minus_branch_bound": show(smallest_excess)}


def endpoint_and_minimizer_checks():
    records = []
    for sign, multiplier in ((1, 2), (-1, 1)):
        t = mp.mpf("0.8")
        omega = multiplier * mp.pi / t
        u = mp.mpf("1.4") * mp.sqrt(3) * omega
        for orientation in (-1, 1):
            clockwise = u/3 + orientation*omega/mp.sqrt(3)
            counterclockwise = u/3 - orientation*omega/mp.sqrt(3)
            q = clockwise*SHIFT + counterclockwise*SHIFT.T - 2*u/3*EYE
            entropy, exp_error, _, _ = inspect(q, u, omega, t, sign)
            assert abs(entropy-gap(u, omega)) < TOL
            records.append({"lambda_sign": sign, "orientation": orientation,
                            "entropy": show(entropy), "analytic_minimum": show(gap(u, omega)),
                            "scaled_exponential_error": show(exp_error)})
        critical_u = mp.sqrt(3)*omega
        directed = 2*critical_u/3*(SHIFT-EYE)
        entropy, err, _, _ = inspect(directed, critical_u, omega, t, sign, positive=False)
        assert not reciprocal(directed)
        assert entropy == mp.inf
        records.append({"lambda_sign": sign, "threshold_boundary": True,
                        "reciprocal_support": False, "entropy": "infinite, excluded",
                        "scaled_exponential_error": show(err)})
    # The positive-spectrum zero branch is evaluated with its own full matrix.
    for ut in ("0.1", "5", "20"):
        t, u = mp.mpf("2.3"), mp.mpf(ut)/mp.mpf("2.3")
        q = u*(ONE-EYE)
        target = mp.exp(-u*t)*EYE + (1-mp.exp(-u*t))*ONE
        assert maxabs(mp.expm(t*q)-target)/mp.exp(-u*t) < TOL
        assert abs(raw_entropy(q, stationary(q))) < TOL
    return {"minimizers_and_critical_boundaries": records, "zero_branch_cases": 3}


def boundary_family_checks():
    records = []
    for sign, multiplier in ((1, 2), (-1, 1)):
        t = mp.mpf(1)
        omega = multiplier*mp.pi
        u = 2*mp.sqrt(3)*omega
        endpoint = 2*u/3-mp.sqrt(u*u+omega*omega)/mp.sqrt(3)
        assert 0 < endpoint < u/6
        previous = -mp.inf
        for exponent in (None, 1, 2, 5, 10, 20, 40):
            d = mp.mpf(0) if exponent is None else endpoint*(1-mp.mpf(10)**(-exponent))
            x, y, z = u/3-2*d, u/3+d, u/3+d
            c = mp.sqrt(omega*omega/3+3*d*d)
            q = mp.matrix([[-x-z, x+c, z-c],
                           [x-c, -x-y, y+c],
                           [z+c, y-c, -y-z]])
            entropy, exp_error, _, activity_error = inspect(q, u, omega, t, sign)
            assert entropy > previous
            previous = entropy
            # Compare the raw stationary-flux calculation with the claimed formula.
            formula = 2*c/3*sum(mp.log((v+c)/(v-c)) for v in (x, y, z))
            assert abs(entropy-formula) < TOL
            records.append({"lambda_sign": sign,
                            "remaining_fraction_of_delta_interval": "1" if exponent is None else "1e-"+str(exponent),
                            "minimum_directed_rate": show(min(q[i, j] for i in range(3) for j in range(3) if i != j)),
                            "entropy_from_stationary_fluxes": show(entropy),
                            "activity": show(2*u/3),
                            "scaled_exponential_error": show(exp_error),
                            "activity_error": show(activity_error)})
    return records


def extension_checks():
    # Distinct positive spectra: reconstruct a symmetric generator from log(P).
    q = mp.matrix([[-3, 1, 2], [1, -4, 3], [2, 3, -5]])
    t = mp.mpf("0.7")
    p = mp.expm(t*q)
    reconstructed = mp.logm(p)/t
    reconstruction_error = maxabs(reconstructed-q)
    assert reconstruction_error < TOL
    assert abs(raw_entropy(q, stationary(q))) < TOL

    # All entries and all eigenvalues of this P are positive, but log(P) has
    # a negative off-diagonal entry, so the unique real commuting candidate
    # fails the generator condition.
    bad = mp.matrix([[mp.mpf(".70"), mp.mpf(".29"), mp.mpf(".01")],
                     [mp.mpf(".29"), mp.mpf(".42"), mp.mpf(".29")],
                     [mp.mpf(".01"), mp.mpf(".29"), mp.mpf(".70")]])
    bad_log = mp.logm(bad)
    predicted_entry = -mp.log(mp.mpf(".69"))/2 + mp.log(mp.mpf(".13"))/6
    assert predicted_entry < 0
    assert abs(bad_log[0, 2]-predicted_entry) < TOL

    # An unrestricted observational perturbation; these observed kernels are
    # deliberately not symmetric. This cannot support a claim confined to the
    # exactly symmetric subclass.
    u, t = 4*mp.sqrt(3)*mp.pi, mp.mpf(1)
    c = mp.matrix([[0, 1, -1], [-1, 0, 1], [1, -1, 0]])
    base = u*(ONE-EYE)
    observed = mp.exp(-u*t)*EYE+(1-mp.exp(-u*t))*ONE
    previous_entropy = previous_distance = mp.inf
    perturbations = []
    for exponent in (1, 2, 3, 5, 8):
        epsilon = (u/3)*mp.mpf(10)**(-exponent)
        perturbed_q = base+epsilon*c
        pi = stationary(perturbed_q)
        entropy = raw_entropy(perturbed_q, pi)
        formula = 2*epsilon*mp.log((u+3*epsilon)/(u-3*epsilon))
        assert abs(entropy-formula) < TOL
        perturbed_p = mp.expm(t*perturbed_q)
        distance = maxabs(perturbed_p-observed)
        asymmetry = maxabs(perturbed_p-perturbed_p.T)
        assert 0 < entropy < previous_entropy
        assert 0 < distance < previous_distance
        assert asymmetry > 0
        assert abs(sum(pi[i]*(-perturbed_q[i, i]) for i in range(3))-2*u/3) < TOL
        previous_entropy, previous_distance = entropy, distance
        perturbations.append({"epsilon": show(epsilon), "entropy": show(entropy),
                              "kernel_entrywise_distance": show(distance),
                              "observed_kernel_asymmetry": show(asymmetry)})
    return {"distinct_positive_spectrum_log_reconstruction_error": show(reconstruction_error),
            "positive_spectrum_nonembeddable_example_log_entry_13": show(predicted_entry),
            "unrestricted_perturbation_checks": perturbations,
            "perturbation_scope": "The nearby observed kernels are not symmetric."}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    parser.add_argument("--manuscript", type=Path)
    args = parser.parse_args()
    result = {
        "status": "PASS",
        "run_time_utc": datetime.now(timezone.utc).isoformat(),
        "review_role": "same-model distinct-agent mathematical reviewer",
        "not_claimed": ["external peer review", "cross-model review", "Lean verification",
                        "exhaustive numerical coverage", "novelty certification"],
        "python": platform.python_version(), "mpmath": mp.__version__, "sympy": sp.__version__,
        "decimal_precision": mp.mp.dps, "tolerance": str(TOL), "seed": SEED,
        "checker_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "exact_symbolic_checks": exact_algebra(),
        "independent_similarity_samples": randomized_similarity_checks(),
        "endpoint_checks": endpoint_and_minimizer_checks(),
        "explicit_family_direct_matrix_checks": boundary_family_checks(),
        "extension_checks": extension_checks(),
        "scope": ("Exact algebra plus finite arbitrary-precision matrix checks. The analytic proof, "
                  "rather than these samples, establishes exhaustiveness and the unbounded interval."),
    }
    if args.manuscript:
        result["manuscript_path"] = str(args.manuscript.resolve())
        result["manuscript_sha256"] = hashlib.sha256(args.manuscript.read_bytes()).hexdigest()
    text = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(text)
    print(text, end="")


if __name__ == "__main__":
    main()
