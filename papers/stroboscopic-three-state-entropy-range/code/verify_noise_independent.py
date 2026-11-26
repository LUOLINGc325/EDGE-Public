#!/usr/bin/env python3
"""Distinct-agent checks of the finite-resolution entropy-band theorem.

Principal candidates are computed by taking a general 2x2 matrix logarithm
on the zero-sum plane. High-frequency candidates use general real similarities
of a rotating 2x2 block and are filtered by their directly computed observed
matrix. Entropy is evaluated from a solved stationary distribution and raw
stationary fluxes. The author's primary noise checker was not consulted.

All verification guards are ordinary conditionals, not Python assert, so -O
does not remove the checks. These finite tests are not a universal proof or a
novelty certification.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import math
import platform
import random
from datetime import datetime, timezone
from pathlib import Path

import mpmath as mp
import sympy as sp


mp.mp.dps = 90
TOL = mp.mpf("1e-60")
SEED = 2026112404
I3, I2 = mp.eye(3), mp.eye(2)
PI = mp.matrix([[mp.mpf(1)/3]*3 for _ in range(3)])
H = I3-PI
U = mp.matrix([[1/mp.sqrt(2), 1/mp.sqrt(6)],
               [-1/mp.sqrt(2), 1/mp.sqrt(6)],
               [0, -2/mp.sqrt(6)]])
J = mp.matrix([[0, -1], [1, 0]])
CYCLE = mp.matrix([[0, 1, -1], [-1, 0, 1], [1, -1, 0]])


def require(condition, message):
    if not condition:
        raise RuntimeError("Verification failed: " + message)


def fmt(x):
    return mp.nstr(x, 35)


def frob(a):
    return mp.sqrt(sum(abs(a[i, j])**2 for i in range(a.rows) for j in range(a.cols)))


def real_matrix(a):
    require(max(abs(mp.im(v)) for v in a) < TOL, "matrix should be real")
    return mp.matrix([[mp.re(a[i, j]) for j in range(a.cols)] for i in range(a.rows)])


def stationary(q):
    equations = q.T.copy()
    for j in range(3):
        equations[2, j] = 1
    return mp.lu_solve(equations, mp.matrix([0, 0, 1]))


def flux_entropy(q, pi):
    result = mp.mpf(0)
    for i in range(3):
        for j in range(3):
            if i != j:
                f, back = pi[i]*q[i, j], pi[j]*q[j, i]
                require(f > 0 and back > 0, "positive reciprocal fluxes")
                result += f*mp.log(f/back)
    return result


def check_generator(q):
    require(min(q[i, j] for i in range(3) for j in range(3) if i != j) > 0,
            "positive off-diagonal rates")
    require(max(abs(sum(q[i, j] for j in range(3))) for i in range(3)) < TOL,
            "zero row sums")
    require(max(abs(sum(q[i, j] for i in range(3))) for j in range(3)) < TOL,
            "zero column sums")
    pi = stationary(q)
    require(max(abs(pi[i]-mp.mpf(1)/3) for i in range(3)) < TOL,
            "uniform stationary law from independent solve")
    return flux_entropy(q, pi)


def envelope(a, b):
    require(a > mp.sqrt(3)*b > 0, "spectral-envelope domain")
    return 2*b/mp.sqrt(3)*mp.log((a+mp.sqrt(3)*b)/(a-mp.sqrt(3)*b))


def gradient(a, b):
    den = a*a-3*b*b
    return (-4*b*b/den,
            2/mp.sqrt(3)*mp.log((a+mp.sqrt(3)*b)/(a-mp.sqrt(3)*b))+4*a*b/den)


def parameters(alpha_text, sign, eta_text, t_text="1.7"):
    alpha, t, eta = mp.mpf(alpha_text), mp.mpf(t_text), mp.mpf(eta_text)
    ell = mp.exp(-alpha)
    epsilon = eta*ell
    beta = (2 if sign > 0 else 1)*mp.pi
    u = alpha/t
    rho = eta/mp.sqrt(2)
    require(epsilon < ell/2, "small radius relative to center")
    require(ell+epsilon/mp.sqrt(2) < mp.exp(-mp.sqrt(3)*beta),
            "entire eigenvalue disk inside reciprocal feasibility region")
    out = {"alpha": alpha, "t": t, "eta": eta, "ell": ell,
           "epsilon": epsilon, "beta": beta, "u": u, "rho": rho,
           "sign": sign, "center": PI+sign*ell*H}
    if sign > 0:
        d = -mp.log(1-eta)/t
        bound = 2*d*d/(u-3*d)
        require(d < u/3, "principal logarithm positivity condition")
        amax = (alpha-mp.log(1-rho))/t
        bmin = (beta-mp.asin(rho))/t
        gap_floor = envelope(amax, bmin)
        require(bound < gap_floor, "explicit separated-band sufficient condition")
        out.update(D=d, B=bound, gap_floor=gap_floor)
    return out


def boundary_generator(p, phi):
    w_scaled = 1+p["rho"]*mp.exp(1j*phi)
    a = (p["alpha"]-mp.log(abs(w_scaled)))/p["t"]
    b = (p["beta"]-mp.arg(w_scaled))/p["t"]
    return -a*H+b/mp.sqrt(3)*CYCLE, a, b


def boundary_entropy(p, phi):
    # Optimize the direct stationary-flux definition, not the G formula.
    q, _, _ = boundary_generator(p, phi)
    return flux_entropy(q, mp.matrix([mp.mpf(1)/3]*3))


def golden_minimum(function, left, right):
    ratio = (mp.sqrt(5)-1)/2
    x1, x2 = right-ratio*(right-left), left+ratio*(right-left)
    f1, f2 = function(x1), function(x2)
    for _ in range(320):
        if f1 > f2:
            left, x1, f1 = x1, x2, f2
            x2 = left+ratio*(right-left)
            f2 = function(x2)
        else:
            right, x2, f2 = x2, x1, f1
            x1 = right-ratio*(right-left)
            f1 = function(x1)
    x = (left+right)/2
    return x, function(x)


def minimize_boundary(p):
    grid = [mp.pi*k/128 for k in range(129)]
    values = [boundary_entropy(p, x) for x in grid]
    candidates = [(grid[0], values[0]), (grid[-1], values[-1])]
    brackets = 0
    for k in range(1, 128):
        if values[k] <= values[k-1] and values[k] <= values[k+1]:
            candidates.append(golden_minimum(lambda phi: boundary_entropy(p, phi),
                                             grid[k-1], grid[k+1]))
            brackets += 1
    phi, value = min(candidates, key=lambda item: item[1])
    require(brackets > 0, "boundary minimizer bracketed")
    q, a, b = boundary_generator(p, phi)
    direct = check_generator(q)
    observed = mp.expm(p["t"]*q)
    distance = frob(observed-p["center"])
    require(abs(distance/p["epsilon"]-1) < TOL, "minimizer on observation sphere")
    require(abs(direct-envelope(a, b)) < TOL, "circulant saturates entropy lower envelope")
    require(abs(direct-value) < TOL, "direct entropy matches optimization objective")
    if p["sign"] > 0:
        require(value >= p["gap_floor"]-TOL, "conservative high-band lower bound")
    return {"phi": phi, "value": value, "a": a, "b": b,
            "sphere_relative_error": abs(distance/p["epsilon"]-1),
            "candidate_brackets": brackets}


def principal_samples(rng, p, count=24):
    minimum_rate = mp.inf
    maximum_entropy = mp.mpf(0)
    max_roundtrip = mp.mpf(0)
    for _ in range(count):
        v = [mp.mpf(repr(rng.gauss(0, 1))) for _ in range(4)]
        block = mp.matrix([[v[0], v[1]], [v[2], v[3]]])
        radial = mp.mpf(repr(rng.random()))**mp.mpf(".25")
        perturbation = p["epsilon"]*radial*block/frob(block)
        # This uses a generic principal matrix-logarithm implementation on the
        # observed 2x2 block, rather than the paper's perturbative log series.
        b = real_matrix(mp.logm(p["ell"]*I2+perturbation)/p["t"])
        q = U*b*U.T
        entropy = check_generator(q)
        expected = p["center"]+U*perturbation*U.T
        observed = mp.expm(p["t"]*q)
        error = frob(observed-expected)/p["epsilon"]
        require(error < TOL, "principal matrix-log/exponential round trip")
        require(frob(observed-p["center"]) <= p["epsilon"]*(1+TOL), "principal observation ball")
        require(frob(q+p["u"]*H) <= p["D"]+TOL, "principal Frobenius log bound")
        require(-TOL <= entropy <= p["B"]+TOL, "universal principal entropy upper bound")
        minimum_rate = min(minimum_rate, min(q[i, j] for i in range(3) for j in range(3) if i != j))
        maximum_entropy = max(maximum_entropy, entropy)
        max_roundtrip = max(max_roundtrip, error)
    return {"samples": count, "minimum_rate": fmt(minimum_rate),
            "maximum_sampled_entropy": fmt(maximum_entropy), "B": fmt(p["B"]),
            "maximum_roundtrip_error_over_epsilon": fmt(max_roundtrip)}


def high_samples(rng, p, minimum, branches, count_per_branch=16):
    records = []
    for branch in branches:
        accepted = rejected_rates = rejected_distance = nonnormal = attempts = 0
        smallest_margin, greatest_distance = mp.inf, mp.mpf(0)
        while accepted < count_per_branch:
            attempts += 1
            require(attempts < 20000, "enough admissible independent high-branch samples")
            radius = p["rho"]*mp.sqrt(mp.mpf(repr(rng.random())))
            phi = 2*mp.pi*mp.mpf(repr(rng.random()))
            w = 1+radius*mp.exp(1j*phi)
            a = (p["alpha"]-mp.log(abs(w)))/p["t"]
            beta = (2*branch if p["sign"] > 0 else 2*branch+1)*mp.pi
            b = (beta-mp.arg(w))/p["t"]
            width = .035 if p["alpha"] < 13 else .16
            aa, bb, cc = [mp.mpf(repr(rng.uniform(-width, width))) for _ in range(3)]
            transform = mp.matrix([[mp.exp(aa), bb], [cc, mp.exp(-aa)]])
            block = -a*I2+b*transform*J*transform**-1
            q = U*block*U.T
            if min(q[i, j] for i in range(3) for j in range(3) if i != j) <= 0:
                rejected_rates += 1
                continue
            observed = mp.expm(p["t"]*q)
            distance = frob(observed-p["center"])
            if distance > p["epsilon"]:
                rejected_distance += 1
                continue
            entropy = check_generator(q)
            require(entropy >= minimum["value"]-TOL, "high-band endpoint for general similarity")
            require(entropy >= envelope(a, b)-TOL, "known spectral entropy bound")
            eigen_disk_distance = mp.sqrt(2)*p["ell"]*abs(w-1)
            require(distance >= eigen_disk_distance-TOL*p["epsilon"], "Schur Frobenius distance inequality")
            if frob(q*q.T-q.T*q) > mp.mpf("1e-25"):
                nonnormal += 1
            smallest_margin = min(smallest_margin, entropy-minimum["value"])
            greatest_distance = max(greatest_distance, distance/p["epsilon"])
            accepted += 1
        records.append({"branch_index": branch, "accepted": accepted,
                        "rejected_negative_rate": rejected_rates,
                        "rejected_outside_ball": rejected_distance,
                        "nonnormal_accepted": nonnormal,
                        "minimum_entropy_excess_above_m": fmt(smallest_margin),
                        "largest_distance_over_epsilon": fmt(greatest_distance)})
    return records


def connecting_segment_checks(p, minimum):
    start = p["rho"]*mp.exp(1j*minimum["phi"])
    values = []
    for fraction in (mp.mpf(0), mp.mpf(".25"), mp.mpf(".5"), mp.mpf(".75"), mp.mpf(1)):
        w = 1+(1-fraction)*start
        a = (p["alpha"]-mp.log(abs(w)))/p["t"]
        b = (p["beta"]-mp.arg(w))/p["t"]
        q = -a*H+b/mp.sqrt(3)*CYCLE
        entropy = check_generator(q)
        ratio = frob(mp.expm(p["t"]*q)-p["center"])/p["epsilon"]
        require(ratio <= 1+TOL, "minimizer-to-center segment stays inside observation ball")
        require(entropy >= minimum["value"]-TOL, "segment entropy not below high minimum")
        values.append({"fraction_to_center": fmt(fraction), "entropy": fmt(entropy),
                       "distance_over_epsilon": fmt(ratio)})
    require(abs(mp.mpf(values[-1]["entropy"])-envelope(p["u"], p["beta"]/p["t"])) < mp.mpf("1e-30"),
            "segment joins known exact-center entropy endpoint")
    return values


def sharp_scaling_checks():
    output = []
    for sign, alpha in ((1, "12"), (-1, "6")):
        for eta in ("0.02", "0.005", "0.001", "0.00001"):
            p = parameters(alpha, sign, eta, "0.8")
            minimum = minimize_boundary(p)
            a, b = p["u"], p["beta"]/p["t"]
            ga, gb = gradient(a, b)
            predicted = mp.sqrt(ga*ga+gb*gb)
            observed = ((envelope(a, b)-minimum["value"])
                        *mp.sqrt(2)*p["ell"]*p["t"]/p["epsilon"])
            record = {"sign": sign, "epsilon_over_abs_lambda": eta,
                      "predicted_high_coefficient": fmt(predicted),
                      "observed_high_coefficient": fmt(observed),
                      "high_relative_error": fmt(abs(observed/predicted-1))}
            if eta == "0.00001":
                require(abs(observed/predicted-1) < mp.mpf("1e-4"), "sharp high-endpoint first-order coefficient")
            if sign > 0:
                c = 2/(mp.sqrt(3)*p["t"])*mp.asin(p["epsilon"]/(2*mp.sqrt(2)*p["ell"]))
                q = -p["u"]*H+c*CYCLE
                low = check_generator(q)
                ratio = frob(mp.expm(p["t"]*q)-p["center"])/p["epsilon"]
                require(abs(ratio-1) < TOL, "low matching family exact noise radius")
                leading = 2*p["epsilon"]**2/(p["u"]*p["ell"]**2*p["t"]**2)
                require(low <= p["B"]+TOL, "low-family entropy bracket")
                record.update(low_L_over_leading=fmt(low/leading), low_B_over_leading=fmt(p["B"]/leading),
                              note="L and B bracket M; M itself is not numerically optimized here")
                if eta == "0.00001":
                    require(abs(low/leading-1) < mp.mpf("1e-6"), "sharp low-endpoint lower coefficient")
                    require(abs(p["B"]/leading-1) < mp.mpf("1e-3"), "sharp low-endpoint upper coefficient")
            output.append(record)
    return output


def symbolic_checks():
    a, b, e, ell, t, u = sp.symbols("a b e ell t u", positive=True)
    g = 2*b/sp.sqrt(3)*sp.log((a+sp.sqrt(3)*b)/(a-sp.sqrt(3)*b))
    ga = -4*b*b/(a*a-3*b*b)
    gb = 2/sp.sqrt(3)*sp.log((a+sp.sqrt(3)*b)/(a-sp.sqrt(3)*b))+4*a*b/(a*a-3*b*b)
    require(sp.simplify(sp.diff(g, a)-ga) == 0, "symbolic G_a")
    require(sp.simplify(sp.diff(g, b)-gb) == 0, "symbolic G_b")
    c = 2/(sp.sqrt(3)*t)*sp.asin(e/(2*sp.sqrt(2)*ell))
    low = 2*c*sp.log((u+3*c)/(u-3*c))
    d = -sp.log(1-e/ell)/t
    upper = 2*d*d/(u-3*d)
    coefficient = 2/(u*ell*ell*t*t)
    require(sp.simplify(sp.limit(low/e**2, e, 0)-coefficient) == 0, "exact lower squeeze coefficient")
    require(sp.simplify(sp.limit(upper/e**2, e, 0)-coefficient) == 0, "exact upper squeeze coefficient")
    return {"gradient_G": "two exact symbolic identities verified",
            "low_band_squeeze": "both exact quadratic coefficients equal 2/(u*ell^2*t^2)"}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--manuscript", type=Path)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    rng = random.Random(SEED)
    cases = []
    for sign, alpha, branches in ((1, "12", (1,)), (1, "30", (1, 2)),
                                  (-1, "6", (0,)), (-1, "20", (0, 1))):
        p = parameters(alpha, sign, "0.02")
        minimum = minimize_boundary(p)
        case = {"sign": sign, "alpha_ut": alpha, "t": fmt(p["t"]),
                "epsilon_over_abs_lambda": fmt(p["eta"]),
                "m_numeric": fmt(minimum["value"]), "minimizing_phi": fmt(minimum["phi"]),
                "boundary_minimizer_brackets": minimum["candidate_brackets"],
                "minimizer_sphere_relative_error": fmt(minimum["sphere_relative_error"]),
                "high_similarity_samples": high_samples(rng, p, minimum, branches),
                "minimizer_to_center_path": connecting_segment_checks(p, minimum)}
        if sign > 0:
            case["principal_samples"] = principal_samples(rng, p)
            case["explicit_gap_check"] = {"B_epsilon": fmt(p["B"]),
                                          "conservative_high_lower_bound": fmt(p["gap_floor"]),
                                          "status": "strictly separated"}
        cases.append(case)
    result = {"status": "PASS", "run_time_utc": datetime.now(timezone.utc).isoformat(),
              "review_role": "same-model distinct-agent independent verifier",
              "python": platform.python_version(), "mpmath": mp.__version__, "sympy": sp.__version__,
              "decimal_precision": mp.mp.dps, "seed": SEED, "tolerance": str(TOL),
              "guards": "ordinary conditional checks; Python -O does not remove them",
              "checker_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              "symbolic_checks": symbolic_checks(), "cases": cases,
              "sharp_endpoint_scalings": sharp_scaling_checks(),
              "scope": ("Finite arbitrary-precision matrix checks and exact symbolic identities. "
                        "The analytic proof establishes completeness of the two intervals. "
                        "Boundary minimization uses a finite bracketing grid and local high-precision "
                        "optimization, not certified interval arithmetic. M_epsilon is not computed exactly."),
              "not_claimed": ["global novelty certification", "external peer review", "cross-model review", "Lean verification"]}
    if args.manuscript:
        result["manuscript_path"] = str(args.manuscript.resolve())
        result["manuscript_sha256"] = hashlib.sha256(args.manuscript.read_bytes()).hexdigest()
    text = json.dumps(result, indent=2, ensure_ascii=False)+"\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(text)
    print(text, end="")


if __name__ == "__main__":
    main()
