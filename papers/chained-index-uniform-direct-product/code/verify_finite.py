#!/usr/bin/env python3
"""Independent finite checks; these computations do not prove universal theorems.

Uses exact rational arithmetic for an adaptive two-stage protocol and counting.
Uses floating point only for the explicitly labelled analytic spot checks.
"""
from __future__ import annotations

import argparse
from collections import Counter, defaultdict
from fractions import Fraction
from hashlib import sha256
from itertools import combinations, product
import json
import math
from pathlib import Path
import random


def slice_rows(n):
    return tuple(frozenset(s) for s in combinations(range(n), n // 2))


def matrix_channel(n, r, b):
    rows = slice_rows(n)
    inputs = tuple(product(rows, repeat=r))
    outputs = tuple(product(range(n), repeat=r))
    incidence = []
    for j in outputs:
        incidence.append([int(all((j[t] in x[t]) == bool(b[t]) for t in range(r)))
                          for x in inputs])
    return inputs, outputs, incidence


def norm_checks(seed=20261125):
    rng = random.Random(seed)
    maximum_ratio = 0.0
    maximum_kl_ratio = 0.0
    cases = 0
    exhaustive = 0
    for n, r in [(2, 1), (4, 1), (6, 1), (8, 1), (4, 2)]:
        b = tuple((j % 2) for j in range(r))
        inputs, outputs, incidence = matrix_channel(n, r, b)
        d = len(inputs)
        p = 1 + 2 / n
        functions = [[1.0] * d]
        if n == 4 and r == 1:
            for mask in range(1, 1 << d):
                functions.append([float((mask >> t) & 1) for t in range(d)])
                exhaustive += 1
        for _ in range(120):
            functions.append([rng.expovariate(1) ** 3 for _ in range(d)])
            functions.append([rng.uniform(-3, 3) for _ in range(d)])
        for f in functions:
            tf = [(2 ** r) * sum(v * z for v, z in zip(f, row)) / d
                  for row in incidence]
            left = math.sqrt(sum(v * v for v in tf) / len(tf))
            right = (sum(abs(v) ** p for v in f) / d) ** (1 / p)
            ratio = left / right if right else 0.0
            assert ratio <= 1 + 2e-12, (n, r, ratio)
            maximum_ratio = max(maximum_ratio, ratio)
            cases += 1
            if min(f) >= 0 and sum(f) > 0:
                mean = sum(f) / d
                ff = [v / mean for v in f]
                gg = [v / mean for v in tf]
                di = sum(v * math.log2(v) for v in ff if v) / d
                do = sum(v * math.log2(v) for v in gg if v) / len(gg)
                assert do <= (2 / n) * di + 5e-12, (n, r, di, do)
                if di > 1e-10:
                    maximum_kl_ratio = max(maximum_kl_ratio, do / ((2 / n) * di))
    return {"kind": "floating_point_spot_checks_not_a_proof", "seed": seed,
            "norm_cases": cases, "all_nonempty_indicator_cells_N4": exhaustive,
            "max_norm_ratio": maximum_ratio,
            "max_normalized_KL_ratio": maximum_kl_ratio,
            "absolute_tolerance": 5e-12}


def stable_cell(x, history, alphabet):
    data = repr((tuple(tuple(sorted(s)) for s in x), history)).encode()
    return alphabet[int.from_bytes(sha256(data).digest()[:8], "big") % len(alphabet)]


def protocol_check():
    """N=4,r=2,k=2; adaptive prefix code, including a valid empty codebook.

    Stage 1 uses {0,10,11}. Stage 2 uses {0,1} only after word 0 and
    an odd sum of public indices; otherwise its only word is empty.
    Every input path costs at most two bits. B is not used by any encoder.
    """
    n, r = 4, 2
    rows = slice_rows(n)
    inputs = tuple(product(rows, repeat=r))
    all_j = tuple(product(range(n), repeat=r))
    all_b = tuple(product(range(2), repeat=r))
    q = {(): Fraction(1)}
    laws = {b: {(): Fraction(1)} for b in all_b}
    discount_moments = []
    for stage in range(2):
        nq = defaultdict(Fraction)
        np = {b: defaultdict(Fraction) for b in all_b}
        for history, qh in q.items():
            if stage == 0:
                alphabet = ("0", "10", "11")
            elif history[0][0] == "0" and sum(history[0][1]) % 2:
                alphabet = ("0", "1")
            else:
                alphabet = ("",)
            cells = defaultdict(list)
            for x in inputs:
                cells[stable_cell(x, history, alphabet)].append(x)
            for msg, cell in cells.items():
                a = Fraction(len(cell), len(inputs))
                for j in all_j:
                    nh = history + ((msg, j),)
                    nq[nh] += qh * a / (n ** r)
                    for b in all_b:
                        good = sum(all((j[t] in x[t]) == bool(b[t]) for t in range(r))
                                   for x in cell)
                        transition = Fraction(good, len(inputs) * (n // 2) ** r)
                        np[b][nh] += laws[b].get(history, Fraction(0)) * transition
        q = dict(nq)
        laws = {b: dict(v) for b, v in np.items()}
        assert sum(q.values()) == 1
        for law in laws.values():
            assert sum(law.values()) == 1
        eta = Fraction(4, n + 2)
        moments = []
        for b in all_b:
            z = sum(float(laws[b].get(h, 0) ** 2 / qh)
                    * 2 ** (-float(eta) * sum(len(m) for m, _ in h))
                    for h, qh in q.items())
            assert z <= 1 + 2e-12
            moments.append(z)
        discount_moments.append(moments)
    max_cost = max(sum(len(m) for m, _ in h) for h in q)
    assert max_cost == 2
    raw_moments = [sum(laws[b].get(h, 0) ** 2 / qh for h, qh in q.items())
                   for b in all_b]
    guess = sum(max(laws[b].get(h, Fraction(0)) for b in all_b)
                for h in q) / len(all_b)
    theorem_bound = 2 ** (-r / 2 + 2 * max_cost / (n + 2))
    assert float(guess) <= theorem_bound + 2e-12
    return {"kind": "exact_rational_enumeration_with_float_power_comparisons",
            "N": n, "copies": r, "stages": 2, "worst_case_cost": max_cost,
            "reference_leaf_count": len(q), "all_probability_masses_exactly_one": True,
            "optimal_guess_probability_exact": str(guess),
            "optimal_guess_probability": float(guess),
            "strong_product_bound": theorem_bound,
            "per_B_second_moments_exact": list(map(str, raw_moments)),
            "discounted_second_moments_by_stage": discount_moments}


def tuple_count_checks():
    checks = 0
    for k in range(1, 9):
        for c in range(9):
            # Dynamic count, independent of the closed stars-and-bars expression.
            counts = [1] + [0] * c
            for _ in range(k):
                counts = [sum(counts[t - ell] * 2 ** ell for ell in range(t + 1))
                          for t in range(c + 1)]
            exact = sum(counts)
            formula = sum(2 ** ell * math.comb(k + ell - 1, ell)
                          for ell in range(c + 1))
            upper = 2 ** c * math.comb(k + c, c)
            assert exact == formula <= upper
            checks += 1
    return {"kind": "exact_integer_checks", "cases": checks,
            "independent_dynamic_count_matches_formula": True}


def silent_parameters():
    cases = 0
    largest_factor = 0.0
    for n in range(2, 101):
        ks = {1, n, 63*n, 64*n, 65*n}
        ks.update(n * 2 ** j for j in range(1, 3*n+3, max(1,n//8)))
        for k in ks:
            q = k / n
            f = max(1, n / math.log2(2 + q))
            if q < 64:
                cost = n
            else:
                t = min(n, int(math.floor(math.log2(q) / 2)))
                cost = math.ceil(4 * n / t)
                mu = k * 2.0 ** (-t)
                assert t >= 2 and mu >= 2 * cost - 1e-10
                assert math.exp(-mu/8) + math.exp(-cost*t/n) < 1/3
            assert cost <= 18 * f + 1e-10
            largest_factor = max(largest_factor, cost/f)
            cases += 1
    return {"kind": "finite_parameter_spot_checks_not_a_proof", "cases": cases,
            "largest_observed_cost_over_F": largest_factor,
            "claimed_universal_upper_factor": 18,
            "error_bound_exp_minus_2_plus_exp_minus_4": math.exp(-2)+math.exp(-4)}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path, default=Path("results/finite_checks.json"))
    args = parser.parse_args()
    report = {"scope": "Finite consistency checks only; written proofs establish universal claims.",
              "norms": norm_checks(), "adaptive_protocol": protocol_check(),
              "message_tuple_count": tuple_count_checks(),
              "silent_upper_bound": silent_parameters()}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
