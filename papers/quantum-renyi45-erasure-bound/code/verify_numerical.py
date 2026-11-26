#!/usr/bin/env python3
"""Independent dense-matrix checks for quantum BEC bounds at orders 4 and 5.

Inputs are subnormalized cq blocks P[0], P[1], with total trace one.
The primary entropy calculations use the original blocks, dense XOR/CNOT
outputs, and spectral matrix powers.  They do not use the moment formula.
Moment and tensor formulas are computed separately and compared afterwards.

This is a deterministic floating-point experiment, not a universal proof.
It requires only NumPy.  Run from any directory, optionally with --output.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import math
import platform
from collections import Counter
from pathlib import Path

import numpy as np


SEED = 202611240504
ORDERS = (4, 5)
SUPPORT_RELATIVE_CUTOFF = 1e-12
ABSOLUTE_TOLERANCE = 2e-10
RELATIVE_TOLERANCE = 2e-10
LOG_TWO = math.log(2.0)


def hermitian(a):
    return (a + a.conj().T) / 2


def real_trace(a):
    z = np.trace(a)
    if abs(z.imag) > 2e-9 * (1 + abs(z.real)):
        raise ArithmeticError(f"Unexpected imaginary trace {z!r}")
    return float(z.real)


class SpectralPowers:
    """Functional calculus with a documented, relative support threshold."""

    def __init__(self):
        self.calls = 0
        self.zero_matrices = 0
        self.discarded_eigenvalues = 0
        self.largest_discarded_relative_eigenvalue = 0.0
        self.smallest_retained_relative_eigenvalue = 1.0
        self.most_negative_relative_eigenvalue = 0.0

    def __call__(self, a, exponent):
        self.calls += 1
        values, vectors = np.linalg.eigh(hermitian(a))
        scale = max(float(np.max(np.abs(values))), 0.0)
        if scale == 0.0:
            self.zero_matrices += 1
            return np.zeros_like(a)
        negative_tolerance = 128 * np.finfo(float).eps * len(values) * scale
        if float(np.min(values)) < -negative_tolerance:
            raise ArithmeticError("Matrix is not positive semidefinite at PSD tolerance")
        relative = values / scale
        self.most_negative_relative_eigenvalue = min(
            self.most_negative_relative_eigenvalue, float(np.min(relative))
        )
        keep = values > SUPPORT_RELATIVE_CUTOFF * scale
        self.discarded_eigenvalues += int(np.count_nonzero(~keep))
        if np.any(~keep):
            self.largest_discarded_relative_eigenvalue = max(
                self.largest_discarded_relative_eigenvalue,
                float(np.max(np.maximum(relative[~keep], 0.0))),
            )
        if np.any(keep):
            self.smallest_retained_relative_eigenvalue = min(
                self.smallest_retained_relative_eigenvalue, float(np.min(relative[keep]))
            )
        powered = np.zeros_like(values)
        powered[keep] = values[keep] ** exponent
        return hermitian((vectors * powered) @ vectors.conj().T)

    def summary(self):
        return dict(self.__dict__)


def integer_trace_power(a, order):
    return real_trace(np.linalg.matrix_power(a, order))


def direct_check_entropy(blocks, order, power):
    marginal = blocks[0] + blocks[1]
    inverse = power(marginal, (1 - order) / (2 * order))
    sandwiched = [hermitian(inverse @ p @ inverse) for p in blocks]
    k = sum(integer_trace_power(a, order) for a in sandwiched)
    if not k > 0:
        raise ArithmeticError("Nonpositive entropy exponential")
    return -math.log(k) / (order - 1), k, sandwiched


def direct_variable_entropy(joint_blocks, order, power):
    # Classical z is part of the conditioning system.  The partial trace over
    # x2 is a direct sum over z, so its trace power is the following sum.
    value = 0.0
    for z in (0, 1):
        summed_roots = power(joint_blocks[z][0], 1 / order) + power(
            joint_blocks[z][1], 1 / order
        )
        value += integer_trace_power(summed_roots, order)
    if not value > 0:
        raise ArithmeticError("Nonpositive Petz-Arimoto exponential")
    return math.log(value) / (order - 1), value


def direct_input_arimoto(blocks, order, power):
    roots = [power(p, 1 / order) for p in blocks]
    value = integer_trace_power(roots[0] + roots[1], order)
    return math.log(value) / (order - 1), value, roots


def separate_moments(sandwiched, order):
    a, b = sandwiched
    s, d = a + b, a - b
    if order == 4:
        moments = np.array(
            [real_trace(s @ s @ d @ d), real_trace(s @ d @ s @ d),
             real_trace(d @ d @ d @ d)]
        )
        weights = np.array([4.0, 2.0, 1.0])
    elif order == 5:
        moments = np.array(
            [real_trace(s @ s @ s @ d @ d), real_trace(s @ s @ d @ s @ d),
             real_trace(s @ d @ d @ d @ d)]
        )
        weights = np.array([5.0, 5.0, 5.0])
    else:
        raise ValueError(order)
    return moments, weights, integer_trace_power(s, order)


def random_state(rng, dimension, rank=None):
    if rank is None:
        rank = dimension
    g = rng.normal(size=(dimension, rank)) + 1j * rng.normal(size=(dimension, rank))
    state = g @ g.conj().T
    state /= real_trace(state)
    # The floor keeps intended full-rank spectra away from the support cutoff.
    if rank == dimension:
        state = 0.97 * state + 0.03 * np.eye(dimension) / dimension
    return hermitian(state)


def random_frame(rng, dimension, rank):
    g = rng.normal(size=(dimension, rank)) + 1j * rng.normal(size=(dimension, rank))
    q, _ = np.linalg.qr(g)
    return q


def cq_pair(rng, dimension, prior=0.5, rank=None):
    return (prior * random_state(rng, dimension, rank),
            (1 - prior) * random_state(rng, dimension, rank))


def embedded_pair(rng, dimension, rank, prior):
    q = random_frame(rng, dimension, rank)
    return tuple(q @ a @ q.conj().T for a in cq_pair(rng, rank, prior))


def erasure_pair(epsilon):
    return (np.diag([(1 - epsilon) / 2, 0.0, epsilon / 2]).astype(complex),
            np.diag([0.0, (1 - epsilon) / 2, epsilon / 2]).astype(complex))


def cases(rng):
    def item(group, number, first, second, equality=False, extra=None):
        return dict(label=f"{group}-{number:03d}", group=group,
                    blocks=(first, second), erasure_equality_expected=equality,
                    extra=extra or {})

    for j in range(144):
        yield item("full_rank_uniform", j, cq_pair(rng, 1 + j % 6),
                   cq_pair(rng, 1 + (j * 5 + 2) % 6))
    for j in range(112):
        p, q = rng.uniform(0.01, 0.99, 2)
        yield item("full_rank_biased", j, cq_pair(rng, 1 + j % 6, p),
                   cq_pair(rng, 1 + (j * 3 + 1) % 6, q))
    for j in range(68):
        p, q = (0.5, 0.5) if j % 2 == 0 else rng.uniform(0.03, 0.97, 2)
        yield item("rank_one", j, cq_pair(rng, 2 + j % 5, p, 1),
                   cq_pair(rng, 2 + (j * 3 + 1) % 5, q, 1))
    for j in range(64):
        d, e = 3 + j % 5, 3 + (j * 3 + 1) % 5
        r, s = 1 + j % (d - 1), 1 + (j + 1) % (e - 1)
        p, q = (0.5, 0.5) if j % 2 == 0 else rng.uniform(0.05, 0.95, 2)
        yield item("singular_common_support", j,
                   embedded_pair(rng, d, r, p), embedded_pair(rng, e, s, q),
                   extra={"intended_marginal_ranks": [r, s]})
    for j in range(24):
        d = 4 + j % 4
        q = random_frame(rng, d, d)
        r = d // 2
        p = 0.17 + 0.61 * (j % 7) / 6
        first = (p * q[:, :r] @ random_state(rng, r) @ q[:, :r].conj().T,
                 (1 - p) * q[:, r:] @ random_state(rng, d-r) @ q[:, r:].conj().T)
        yield item("orthogonal_supports", j, first, cq_pair(rng, 2 + j % 5), True)
    for j in range(32):
        d = 1 + j % 6
        sigma = random_state(rng, d, 1 if j % 2 else None)
        if j % 4 == 0:
            first = (sigma, np.zeros_like(sigma))
        elif j % 4 == 1:
            first = (np.zeros_like(sigma), sigma)
        elif j % 4 == 2:
            first = (sigma / 2, sigma / 2)
        else:
            first = (0.27 * sigma, 0.73 * sigma)
        yield item("prior_and_entropy_endpoints", j, first,
                   cq_pair(rng, 1 + (j + 3) % 6, 0.5 if j % 2 else 0.37),
                   equality=j % 4 != 3)
    grid = (0.0, 0.0001, 0.125, 0.5, 0.875, 0.9999, 1.0)
    for j, eps1 in enumerate(grid):
        for k, eps2 in enumerate(grid):
            yield item("bec_grid", 7 * j + k, erasure_pair(eps1),
                       erasure_pair(eps2), True,
                       {"erasure_probabilities": [eps1, eps2]})
    for j in range(32):
        eps = float(rng.uniform())
        second = cq_pair(rng, 2 + j % 5, 0.5 if j % 2 else 0.21)
        yield item("one_bec_one_arbitrary", j, erasure_pair(eps), second, True)


class Metrics:
    def __init__(self):
        self.maximum_errors = {}
        self.minimum_slacks = {}
        self.failures = []

    def error(self, name, value, label, scale=1.0):
        value = abs(float(value))
        old = self.maximum_errors.get(name, {"value": -1})
        if value > old["value"]:
            self.maximum_errors[name] = {"value": value, "case": label}
        if value > ABSOLUTE_TOLERANCE + RELATIVE_TOLERANCE * abs(scale):
            self.failures.append(dict(case=label, check=name, error=value, scale=float(scale)))

    def lower_bound(self, name, slack, label, scale=1.0):
        slack = float(slack)
        old = self.minimum_slacks.get(name, {"value": math.inf})
        if slack < old["value"]:
            self.minimum_slacks[name] = {"value": slack, "case": label}
        if slack < -(ABSOLUTE_TOLERANCE + RELATIVE_TOLERANCE * abs(scale)):
            self.failures.append(dict(case=label, check=name, slack=slack, scale=float(scale)))


def run(output):
    rng = np.random.default_rng(SEED)
    power = SpectralPowers()
    metrics = {order: Metrics() for order in ORDERS}
    categories = Counter()
    dimensions = set()
    prior_endpoints = Counter()
    noncommuting_input_count = 0
    both_noncommuting_cases = 0
    records = []
    equality_cases = 0
    for case in cases(rng):
        label = case["label"]
        first, second = case["blocks"]
        categories[case["group"]] += 1
        dimensions.add((len(first[0]), len(second[0])))
        priors = [real_trace(first[0]), real_trace(second[0])]
        noncommuting = []
        for pair, prior in zip((first, second), priors):
            if abs(sum(real_trace(p) for p in pair) - 1) > 1e-12:
                raise ArithmeticError("Invalid total trace")
            prior_endpoints["zero" if abs(prior) < 1e-12 else
                            "one" if abs(prior - 1) < 1e-12 else "interior"] += 1
            flag = np.linalg.norm(pair[0] @ pair[1] - pair[1] @ pair[0], ord="fro") > 1e-8
            noncommuting_input_count += int(flag)
            noncommuting.append(bool(flag))
        both_noncommuting_cases += int(all(noncommuting))
        # Direct dense tensor outputs, built before any moment calculation.
        joint = [[np.kron(first[z ^ x], second[x]) for x in (0, 1)] for z in (0, 1)]
        xor = tuple(joint[z][0] + joint[z][1] for z in (0, 1))
        row = {"case": label, "dimensions": [len(first[0]), len(second[0])],
               "priors": priors, "noncommuting_inputs": noncommuting,
               "erasure_equality_expected": case["erasure_equality_expected"],
               **case["extra"], "orders": {}}
        equality_cases += int(case["erasure_equality_expected"])
        for order in ORDERS:
            met = metrics[order]
            h1, k1, sandwich1 = direct_check_entropy(first, order, power)
            h2, k2, sandwich2 = direct_check_entropy(second, order, power)
            hx, kx, sandwichx = direct_check_entropy(xor, order, power)
            denominator = 2 ** (order - 1)
            delta = 1 / denominator
            kb = delta + (k1 - delta) * (k2 - delta) / (1 - delta)
            entropy_bound = -math.log(kb) / (order - 1)
            met.lower_bound("check_node_K_gap", kx - kb, label)
            met.lower_bound("check_node_entropy_slack", entropy_bound - hx, label)
            mom1, weights, norm1 = separate_moments(sandwich1, order)
            mom2, _, norm2 = separate_moments(sandwich2, order)
            momx, _, normx = separate_moments(sandwichx, order)
            for name, norm in (("first", norm1), ("second", norm2), ("xor", normx)):
                met.error(f"{name}_normalization", norm - 1, label)
            for name, k, mom in (("first", k1, mom1), ("second", k2, mom2), ("xor", kx, momx)):
                met.error(f"{name}_moment_identity", k - (1 + float(weights @ mom)) / denominator, label)
                met.lower_bound(f"{name}_a_minus_b", mom[0] - mom[1], label)
                met.lower_bound(f"{name}_b_minus_c", mom[1] - mom[2], label)
                met.lower_bound(f"{name}_c", mom[2], label)
            met.error("tensor_moments", np.max(np.abs(momx - mom1 * mom2)), label)
            covariance_gap = sum(
                weights[i] * weights[j] * (mom1[i] - mom1[j]) * (mom2[i] - mom2[j])
                for i in range(3) for j in range(i + 1, 3)
            ) / (denominator * sum(weights))
            met.error("positive_gap_identity", kx - kb - covariance_gap, label)
            for name, h in (("first", h1), ("second", h2), ("xor", hx)):
                met.lower_bound(f"{name}_entropy_nonnegative", h, label)
                met.lower_bound(f"{name}_entropy_at_most_log2", LOG_TWO - h, label)
            hb1, ell1, roots1 = direct_input_arimoto(first, order, power)
            hb2, ell2, roots2 = direct_input_arimoto(second, order, power)
            hp, ellp = direct_variable_entropy(joint, order, power)
            ell_bound = 1 + (ell1 - 1) * (ell2 - 1) / (denominator - 1)
            hp_bound = math.log(ell_bound) / (order - 1)
            met.lower_bound("variable_node_L_gap", ellp - ell_bound, label, ell_bound)
            met.lower_bound("variable_node_entropy_slack", hp - hp_bound, label)
            # A secondary comparison tests the tensor-root identity independently
            # of the dense functional calculus used for the primary variable node.
            ell_factored = sum(integer_trace_power(
                np.kron(roots1[z], roots2[0]) + np.kron(roots1[z ^ 1], roots2[1]), order
            ) for z in (0, 1))
            met.error("dense_vs_factored_variable_trace", ellp - ell_factored, label, ellp)
            if case["erasure_equality_expected"]:
                met.error("expected_erasure_check_equality", kx - kb, label)
                met.error("expected_erasure_variable_equality", ellp - ell_bound, label, ell_bound)
            if case["group"] == "bec_grid":
                eps1, eps2 = case["extra"]["erasure_probabilities"]
                met.error("bec_input_K_closed_form", k1 - (1 - (1 - delta) * eps1), label)
                met.error("bec_input_L_closed_form", ell1 - (1 + (denominator - 1) * eps1), label, ell1)
                met.error("bec_variable_L_closed_form", ellp - (1 + (denominator - 1) * eps1 * eps2), label, ellp)
            row["orders"][str(order)] = {
                "check_entropies": [h1, h2, hx], "check_K_gap": kx - kb,
                "arimoto_input_entropies": [hb1, hb2], "variable_entropy": hp,
                "variable_L_gap": ellp - ell_bound,
            }
        records.append(row)
    failures = [dict(order=order, **finding) for order, met in metrics.items() for finding in met.failures]
    report = {
        "status": "PASS" if not failures else "FAIL",
        "scope": "Finite floating-point checks; no universal proof, interval certificate, Lean certification, or external peer review.",
        "definition_sources": {
            "original": "Hirche, Guan and Tomamichel, arXiv:2305.02589v1, IV.1-IV.2 and V.1-V.8",
            "core_note": "Related order-four calculation in the manuscript.",
            "primary_computation": "Original cq blocks; dense XOR/CNOT output; independent spectral matrix powers",
            "biased_prior_scope": "Additional algebraic extension checked here; the cited paper states its channel conjecture for equiprobable bits.",
        },
        "orders": list(ORDERS), "logarithm_base": "e", "seed": SEED,
        "cases": len(records), "order_case_checks": len(records) * len(ORDERS),
        "category_counts": dict(categories), "dimension_pairs": sorted(map(list, dimensions)),
        "largest_dense_output_dimension": max(a * b for a, b in dimensions),
        "noncommuting_input_count": noncommuting_input_count,
        "both_noncommuting_case_count": both_noncommuting_cases,
        "prior_endpoint_counts": dict(prior_endpoints), "expected_erasure_equality_cases": equality_cases,
        "numerical_policy": {
            "absolute_tolerance": ABSOLUTE_TOLERANCE, "relative_tolerance": RELATIVE_TOLERANCE,
            "comparison_rule": "abs(error) <= atol + rtol*abs(scale), or inequality slack >= -(atol+rtol*abs(scale))",
            "support_relative_cutoff": SUPPORT_RELATIVE_CUTOFF,
            "support_rule": "For every PSD power, diagonalize the Hermitian part; eigenvalues <= 1e-12*largest_abs_eigenvalue are set to zero. Negative powers act only on the retained support.",
            "psd_rule": "Reject eigenvalues < -128*machine_epsilon*dimension*largest_abs_eigenvalue.",
            "positive_spectrum_rule": "Intended full-rank random states receive 0.03*I/d spectral regularization; constructed singular states have exact support zeros before floating-point embedding.",
            "arithmetic": "IEEE float64/complex128 NumPy dense linear algebra; no rigorous rounding enclosure",
            "spectral_diagnostics": power.summary(),
        },
        "environment": {"python": platform.python_version(), "numpy": np.__version__,
                        "platform": platform.platform()},
        "verifier_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "metrics_by_order": {str(order): {"maximum_errors": met.maximum_errors,
                                          "minimum_slacks": met.minimum_slacks}
                             for order, met in metrics.items()},
        "failures": failures, "case_records": records,
    }
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, ensure_ascii=False, indent=2, allow_nan=False) + "\n", encoding="utf-8")
    print(json.dumps({"status": report["status"], "cases": len(records),
                      "orders": list(ORDERS), "failures": len(failures),
                      "output": str(output)}, ensure_ascii=False))
    if failures:
        raise SystemExit(1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results" / "numerical_checks.json")
    run(parser.parse_args().output)
