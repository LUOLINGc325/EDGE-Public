#!/usr/bin/env python3
"""Exact finite checks for the written theorem, not a substitute for it.

All checked arithmetic uses fractions.Fraction and integer powers. Reproduction
is deterministic. --check compares against a previously saved JSON certificate;
--output writes a certificate. No asserts are used, so python -O is supported.
"""

from __future__ import annotations

import argparse
from fractions import Fraction as F
import hashlib
from itertools import combinations_with_replacement, product
import json
from pathlib import Path
from random import Random

from nearest_median import NearestMedian, geometric_trace


def require(condition, detail):
    if not condition:
        raise RuntimeError(detail)


def frac(x):
    x = F(x)
    return str(x.numerator) if x.denominator == 1 else f"{x.numerator}/{x.denominator}"


def power_bound(k, s):
    return k * (1 + F(1, 2**s - 2))


def local_median_checks():
    truthful = tuple(map(F, (-1, F(-1, 2), 0, F(1, 2), 1)))
    corrupt = tuple(map(F, (-100, -2, 0, 2, 100)))
    count = 0
    for eta in range(4):
        k = 2 * eta + 1
        for bad in range(eta + 1):
            for good_reports in combinations_with_replacement(truthful, k - bad):
                for bad_reports in combinations_with_replacement(corrupt, bad):
                    median = sorted(good_reports + bad_reports)[eta]
                    require(-1 <= median <= 1, "median escaped truthful interval")
                    count += 1
    return {"checked_multisets": count, "eta": [0, 1, 2, 3], "status": "passed"}


def split_and_potential_checks():
    grid = [F(i, 8) for i in range(9)]
    split_count = 0
    for s in (2, 3, 4, 8):
        for u, v in product(grid, repeat=2):
            if u + v <= 1:
                delta = (u + v) ** s - u**s - v**s
                require(delta >= (2**s - 2) * min(u, v)**s, "split inequality")
                split_count += 1
    rng = Random(20261124)
    colour_comparisons = 0
    potential_comparisons = 0
    sequence_count = 0
    for k in (1, 2, 3, 5, 7):
        for _ in range(36):
            points = [rng.choice(grid) for _ in range(50)]
            colours, trace = geometric_trace(points, k)
            require(all(r <= d for _, r, _, d in trace), "colour radius domination")
            colour_comparisons += len(trace)
            for s in (2, 3, 4, 8):
                total = sum((r**s for _, r, _, _ in trace), F(0))
                require(total <= power_bound(k, s), "full geometric bound")
                for c in range(k):
                    subseq = [x for x, colour in zip(points, colours) if colour == c]
                    distinct = [subseq[0]]
                    boundary_energy = F(0)
                    interior_energy = F(0)
                    decrements = F(0)
                    for x in subseq[1:]:
                        if x in distinct:
                            continue
                        if x < distinct[0] or x > distinct[-1]:
                            d = min(abs(x - a) for a in distinct)
                            boundary_energy += d**s
                        else:
                            left = max(a for a in distinct if a < x)
                            right = min(a for a in distinct if a > x)
                            u, v = x - left, right - x
                            interior_energy += min(u, v)**s
                            decrements += (u + v)**s - u**s - v**s
                        distinct.append(x)
                        distinct.sort()
                        phi = sum(((v - u)**s for u, v in zip(distinct, distinct[1:])), F(0))
                        require(phi == boundary_energy - decrements, "potential identity")
                        potential_comparisons += 1
                    require(boundary_energy <= 1, "boundary energy")
                    require((2**s - 2) * interior_energy <= decrements, "interior charging")
            sequence_count += 1
    return {
        "split_checks": split_count,
        "sequence_count": sequence_count,
        "colour_comparisons": colour_comparisons,
        "potential_identities": potential_comparisons,
        "integer_exponents": [2, 3, 4, 8],
        "status": "passed",
    }


def dyadic_sharpness_checks():
    examples = []
    for k in (1, 2, 3, 5):
        for depth in range(7):
            points = [F(0)] * k + [F(1)] * k
            for level in range(1, depth + 1):
                for odd in range(1, 2**level, 2):
                    points.extend([F(odd, 2**level)] * k)
            _, trace = geometric_trace(points, k)
            for s in (2, 3, 4, 8):
                actual = sum((r**s for _, r, _, _ in trace), F(0))
                expected = k * (1 + (1 - F(1, 2**((s - 1) * depth))) / (2**s - 2))
                require(actual == expected, "finite dyadic equality")
                examples.append({"k": k, "depth": depth, "s": s, "energy": frac(actual)})
    digest = hashlib.sha256(json.dumps(examples, sort_keys=True).encode()).hexdigest()
    return {"exact_equalities": len(examples), "examples_sha256": digest, "last_example": examples[-1], "status": "passed"}


def piecewise_value(x, slopes, offset=F(0)):
    """Four equal intervals, with rational slopes and a free intercept."""
    out = offset
    for j, slope in enumerate(slopes):
        width = min(F(1, 4), max(F(0), x - F(j, 4)))
        out += slope * width
    return out


def online_corruption_checks():
    slope_lists = [
        (0, 0, 0, 0), (1, 1, 1, 1), (-1, -1, -1, -1),
        (1, 1, -1, -1), (2, 0, 0, 0), (0, 0, 0, -2),
        (F(1, 2), F(-1, 2), F(1, 2), F(-1, 2)),
    ]
    grid = [F(i, 8) for i in range(9)]
    rng = Random(465002)
    round_count = 0
    runs = 0
    max_ratio = F(0)
    for slopes in slope_lists:
        slopes = tuple(map(F, slopes))
        require(sum((v * v / 4 for v in slopes), F(0)) <= 1, "target outside F2")
        for eta in range(5):
            k = 2 * eta + 1
            for scenario in range(12):
                learner = NearestMedian(eta)
                total = F(0)
                bad_indices = set(rng.sample(range(60), eta))
                if eta and scenario == 0:
                    bad_indices = set(range(eta))  # all corruptions in warmup
                for t in range(60):
                    x = rng.choice(grid)
                    truth = piecewise_value(x, slopes, F(17, 3))
                    pred, radius, selected = learner.predict(x)
                    if t >= k:
                        require(len(selected) == k and all(i < t for i in selected), "causality")
                        error = abs(pred - truth)
                        require(error**2 <= radius, "F2 pointwise modulus bound")
                        total += error**4
                        round_count += 1
                    report = truth + (F(1000) if t % 2 else F(-1000)) if t in bad_indices else truth
                    learner.observe(x, report)
                bound = power_bound(k, 2)  # q=2, p=4, alpha*p=2
                require(total <= bound, "global p=4 F2 loss")
                max_ratio = max(max_ratio, total / bound)
                runs += 1
    return {"runs": runs, "scored_rounds": round_count, "targets": len(slope_lists), "eta": list(range(5)), "p": 4, "q": 2, "largest_checked_loss_over_bound": frac(max_ratio), "status": "passed"}


def endpoint_transcript_checks():
    checks = []
    for eta in range(6):
        k = 2 * eta + 1
        for sign in (-1, 1):
            learner = NearestMedian(eta)
            for _ in range(k):
                learner.predict(F(0))
                learner.observe(F(0), F(0))
            errors = []
            reports = [-1] * eta + [1] * eta + [sign]
            for z in reports:
                pred, _, _ = learner.predict(F(1))
                errors.append(abs(pred - sign))
                learner.observe(F(1), F(z))
            require(sum(z != sign for z in reports) == eta, "lower transcript lie count")
            require(errors == [1] * k, "endpoint loss for reference learner")
            checks.append({"eta": eta, "target_sign": sign, "loss_for_every_p": k})
    return {"checks": checks, "status": "passed"}


def certificate():
    return {
        "schema": "noisy-smooth-online-sharp-limit/exact-certificate-v1",
        "arithmetic": "Python standard-library Fraction, integer exponents; no floating-point acceptance thresholds",
        "scope": "Finite checks of implementation, multiplicities, causal prediction, potential identities and sharpness witnesses. General real-parameter theorem is the written proof, not certified by these checks.",
        "median": local_median_checks(),
        "geometry": split_and_potential_checks(),
        "sharpness": dyadic_sharpness_checks(),
        "online": online_corruption_checks(),
        "lower_transcript": endpoint_transcript_checks(),
        "status": "passed",
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--check", type=Path)
    args = parser.parse_args()
    result = certificate()
    encoded = json.dumps(result, indent=2, sort_keys=True) + "\n"
    if args.check:
        expected = json.loads(args.check.read_text(encoding="utf-8"))
        require(result == expected, "saved certificate does not match recomputation")
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(encoded, encoding="utf-8")
    print(encoded, end="")


if __name__ == "__main__":
    main()
