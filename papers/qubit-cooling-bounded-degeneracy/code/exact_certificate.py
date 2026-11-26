#!/usr/bin/env python3
"""Independent finite exact checks for geometric harmonic capacity.

The general statements are proved in the manuscript. These checks audit finite
identities, boundary cases, and small physical permutation models. All arithmetic
used in inequalities and PSD decisions is fractions.Fraction. No assert is used.
"""
from __future__ import annotations

import argparse
from collections import Counter, defaultdict
from fractions import Fraction as Q
import hashlib
import itertools
import json
from pathlib import Path
import random


COUNTS = Counter()
TRANSCRIPT = hashlib.sha256()


def canonical(value):
    return json.dumps(value, sort_keys=True, separators=(",", ":"), ensure_ascii=False)


def check(condition, category, witness):
    if not condition:
        raise RuntimeError("FAILED " + category + ": " + canonical(witness))
    COUNTS[category] += 1
    TRANSCRIPT.update((category + "\n" + canonical(witness) + "\n").encode())


def sd(n, t):
    s = sum((Q(a) * t ** i for i, a in enumerate(n)), Q(0))
    h = sum((t ** i * Q(a * b, a + b)
             for i, (a, b) in enumerate(zip(n, n[1:]))), Q(0))
    return s, s - (1 + t) * h


def quadratic_d(n, t):
    a = [Q(v) * t ** i for i, v in enumerate(n)] + [Q(0)]
    energy = sum(((x - y) ** 2 / (t * x + y)
                  for x, y in zip(a, a[1:])), Q(0))
    return t * (a[0] + energy) / (1 + t)


def composition(total):
    if total == 0:
        yield ()
        return
    for first in range(1, total + 1):
        for rest in composition(total - first):
            yield (first,) + rest


def witness(n, t, **extra):
    return {"n": list(n), "t": str(t), **extra}


def blocks(indices):
    indices = list(indices)
    if not indices:
        return
    a = b = indices[0]
    for j in indices[1:]:
        if j == b + 1:
            b = j
        else:
            yield a, b
            a = b = j
    yield a, b


def binary_checks():
    ts = (Q(1, 2), Q(3, 5), Q(3, 4), Q(9, 10), Q(1))
    chains = 0
    for length in range(2, 11):
        for rest in itertools.product((1, 2), repeat=length - 1):
            n = (1,) + rest
            chains += 1
            for t in ts:
                s, d = sd(n, t)
                d0 = (1 + t ** (length - 1)) / 2
                formula = d0
                for a, b in blocks(i for i, x in enumerate(n) if x == 2):
                    delta = ((2 * t - 1) * t ** (a - 1)
                             + (2 - t) * t ** b) / 6
                    if b == length - 1:
                        delta += (1 + t) * t ** b / 6
                    formula += delta
                check(d == formula, "binary_block_identity", witness(n, t))
                check(d >= s / sum(n), "binary_target", witness(n, t))
                check(d == quadratic_d(n, t), "quadratic_identity", witness(n, t))
    return {"distinct_chains": chains, "lengths": [2, 10],
            "initial_multiplicity": 1, "multiplicities": [1, 2],
            "t_values": [str(t) for t in ts]}


def bounded_height_checks():
    inputs = []
    for mass in range(2, 11):
        for n in composition(mass):
            if n[0] == 1:
                inputs.append(n)
    rng = random.Random(202611240511)
    for _ in range(700):
        length = rng.randint(2, 25)
        height = rng.randint(2, 35)
        inputs.append((1,) + tuple(rng.randint(1, height) for _ in range(length - 1)))
    for n in inputs:
        hmax = max(n)
        threshold = Q(hmax - 1, hmax)
        ts = (threshold, (1 + threshold) / 2, Q(1)) if hmax > 1 else (Q(1, 2), Q(3, 4), Q(1))
        for t in ts:
            s, d = sd(n, t)
            m = sum(n)
            d0 = (1 + t ** (len(n) - 1)) / 2
            current = [1] * len(n)
            for h in range(2, hmax + 1):
                for a, b in blocks(i for i, x in enumerate(n) if x >= h):
                    _, before = sd(current, t)
                    for j in range(a, b + 1):
                        current[j] += 1
                    _, after = sd(current, t)
                    delta = after - before
                    lower = (t ** (a - 1) * ((h * t - h + 1)
                             + (h - (h - 1) * t) * t ** (b - a + 1))
                             / (2 * (2 * h - 1)))
                    weighted = sum((t ** i for i in range(a, b + 1)), Q(0))
                    w = witness(n, t, height=h, block=[a, b])
                    check(delta >= lower, "superlevel_increment_lower", w)
                    check(delta >= (weighted - (b - a + 1) * d0) / m,
                          "superlevel_target_comparison", w)
            check(tuple(current) == n, "superlevel_reconstruction", witness(n, t))
            check(d >= s / m, "bounded_height_target", witness(n, t))
    return {"input_count": len(inputs), "enumerated_masses": [2, 10],
            "random_inputs": 700, "seed": 202611240511,
            "random_lengths": [2, 25], "random_maximum_allowed_height": 35,
            "t_rule": "(H-1)/H, its midpoint with 1, and 1; H=1 uses 1/2,3/4,1"}


def prefix_checks():
    ts = (Q(1, 2), Q(2, 3), Q(4, 5), Q(19, 20), Q(1))
    for mass in range(0, 8):
        for tail in composition(mass):
            for t in ts:
                n = (1, 1) + tail
                sp, dp = sd(n[1:], t)
                s, d = sd(n, t)
                m = sum(n)
                check(s == 1 + t * sp and d == (1 - t) / 2 + t * dp,
                      "11_identity", witness(n, t))
                check(t * sp >= (m - 1) - (1 - t) * (m - 1) * m / 2,
                      "11_bernoulli_moment", witness(n, t))
                check((dp < sp / (m - 1)) or d >= s / m,
                      "11_implication", witness(n, t))

                n = (1, 2, 1) + tail
                smaller = (1, 1, 1) + tail
                s, d = sd(n, t)
                sp, dp = sd(smaller, t)
                delta = (4 * t - 1 - t ** 2) / 6
                check(s - sp == t and d - dp == delta,
                      "121_identity", witness(n, t))
                check(delta >= t / sum(n), "121_increment_bound", witness(n, t))
                check((dp < sp / sum(smaller)) or d >= s / sum(n),
                      "121_implication", witness(n, t))

                n = (1, 2, 2) + tail
                smaller = (1, 2) + tail
                s, d = sd(n, t)
                sp, dp = sd(smaller, t)
                check(s == t * sp + 1 + t and d == t * dp + (1 - t ** 2) / 3,
                      "122_identity", witness(n, t))
    return {"tail_masses": [0, 7], "tails": "all ordered compositions",
            "t_values": [str(t) for t in ts]}


def ternary_checks():
    """Independent direct-D checks of root's parent-child amortization."""
    middle_ts = (Q(5, 8), Q(31, 48), Q(2, 3))
    outside_ts = (Q(1, 10), Q(1, 2), Q(9, 10), Q(1))
    chains = 0
    for length in range(2, 9):
        for rest in itertools.product((1, 2, 3), repeat=length - 1):
            n = (1,) + rest
            chains += 1
            m = sum(n)
            lower = [min(v, 2) for v in n]
            for t in middle_ts:
                s, d = sd(n, t)
                _, d_lower = sd(lower, t)
                d0 = (1 + t ** (length - 1)) / 2
                for a, b in blocks(i for i, v in enumerate(n) if v >= 2):
                    x = t ** (a - 1)
                    parent_only = [1] * length
                    for j in range(a, b + 1):
                        parent_only[j] = 2
                    _, parent_d = sd(parent_only, t)
                    parent_weight = sum((t ** j for j in range(a, b + 1)), Q(0))
                    parent_margin = (parent_d - d0
                                     - (parent_weight - (b - a + 1) * d0) / m)
                    w = witness(n, t, parent=[a, b])
                    check(parent_margin >= x / 24, "ternary_parent_credit", w)
                    margin = parent_margin
                    start_sum = Q(0)
                    for ca, cb in blocks(j for j in range(a, b + 1) if n[j] == 3):
                        child_only = lower[:]
                        for j in range(ca, cb + 1):
                            child_only[j] = 3
                        _, child_d = sd(child_only, t)
                        weighted = sum((t ** j for j in range(ca, cb + 1)), Q(0))
                        r = (weighted - (cb - ca + 1) * d0) / m
                        child_margin = child_d - d_lower - r
                        cx = t ** (ca - 1)
                        start_sum += cx
                        cw = witness(n, t, parent=[a, b], child=[ca, cb])
                        if r > 0:
                            check(child_margin >= 0, "ternary_positive_target_child", cw)
                        else:
                            check(child_margin >= -cx / 80, "ternary_nonpositive_target_child", cw)
                        margin += child_margin
                    check(start_sum <= x / (1 - t ** 2), "ternary_child_start_geometric_bound", w)
                    check(margin >= Q(23, 1200) * x, "ternary_grouped_margin", w)
                check(d >= s / m, "ternary_target", witness(n, t))
            for t in outside_ts:
                s, d = sd(n, t)
                check(d >= s / m, "ternary_target", witness(n, t))

    for c in tuple(range(65)) + (127, 1024, 10 ** 6):
        for t in (Q(1, 2), Q(11, 20), Q(3, 5), Q(5, 8)):
            a = 1 - t + t ** 2 - 3 * t ** 3
            p = a * c ** 2 + (2 - 4 * t) * c + 12 * t
            lower = Q(17, 512) * c ** 2 - Q(c, 2) + 6
            check(p >= lower > 0, "five_eighths_uniform_quadratic",
                  {"c": c, "t": str(t)})
    return {"distinct_chains": chains, "lengths": [2, 8],
            "initial_multiplicity": 1, "multiplicities": [1, 2, 3],
            "middle_t_values": [str(t) for t in middle_ts],
            "other_t_values": [str(t) for t in outside_ts],
            "low_ratio_tail_masses": "0..64,127,1024,1000000",
            "scope": "finite exact audit of parent-child credit, global target, and the 5/8 polynomial bound"}


def first_large_polynomial(b, c, t):
    d = b - 3
    return (t * d ** 4 + (t ** 2 + t) * c * d ** 3 + 12 * t * d ** 3
            + t ** 2 * c ** 2 * d ** 2 + (8 * t ** 2 + 7 * t) * c * d ** 2
            + 53 * t * d ** 2 + t * (-t ** 2 + 5 * t - 1) * c ** 2 * d
            + (19 * t ** 2 + 13 * t + 1) * c * d + 102 * t * d
            + (1 - t) * (4 * t ** 2 - t + 1) * c ** 2
            + (12 * t ** 2 + 3 * t + 3) * c + 72 * t)


def second_large_polynomial(d, c, t):
    e = d - 4
    terms = {(2, 2): 3 * t ** 3,
             (2, 1): -3 * t ** 4 + 21 * t ** 3 - 8 * t ** 2 - t + 1,
             (2, 0): 6 * (1 - t) * (3 * t + 1) * (t ** 2 - t + 1),
             (1, 3): 3 * t ** 2 * (t + 1),
             (1, 2): 39 * t ** 3 + 25 * t ** 2 - 3 * t + 2,
             (1, 1): 2 * (78 * t ** 3 + 14 * t ** 2 - 9 * t + 10),
             (1, 0): 12 * (16 * t ** 3 - 7 * t ** 2 - t + 4),
             (0, 4): 3 * t ** 2, (0, 3): 54 * t ** 2 - 2 * t + 1,
             (0, 2): 2 * (177 * t ** 2 - 14 * t + 7),
             (0, 1): 4 * (252 * t ** 2 - 29 * t + 16),
             (0, 0): 48 * (22 * t ** 2 - 3 * t + 2)}
    return sum((coef * c ** i * e ** j for (i, j), coef in terms.items()), Q(0)), terms


def polynomial_checks():
    ts = tuple(Q(10 + j, 20) for j in range(11))
    for b in range(3, 11):
        for c in range(0, 16):
            for t in ts:
                a = Q(1, b + 1) + t * b * (Q(b, b + 1) - Q(c) / (b + (1 + t) * c))
                bound = (1 + b * t + c * t ** 2) / (1 + b + c)
                k = (b + 1) * (1 + b + c) * (b + (1 + t) * c)
                p = first_large_polynomial(b, c, t)
                w = {"b": b, "c": c, "t": str(t)}
                check(k * (a - bound) == p, "13plus_polynomial_identity", w)
                check(p > 0, "13plus_polynomial_positive", w)
    for d in range(4, 12):
        for c in range(0, 16):
            for t in ts:
                a = 1 - 2 * (1 + t) / 3 + t * (2 - 2 * d * (1 + t) / (d + 2)
                    + t * (d - Q(d * c) / (d + (1 + t) * c)))
                bound = (1 + 2 * t + d * t ** 2 + c * t ** 3) / (3 + d + c)
                k = 3 * (d + 2) * (d + (1 + t) * c) * (3 + d + c)
                p, coeffs = second_large_polynomial(d, c, t)
                w = {"d": d, "c": c, "t": str(t)}
                check(k * (a - bound) == p, "124plus_polynomial_identity", w)
                check(all(v >= 0 for v in coeffs.values()) and p > 0,
                      "124plus_polynomial_positive", w)
    return {"first_b": [3, 10], "second_d": [4, 11], "tail_mass_c": [0, 15],
            "t_values": [str(t) for t in ts],
            "scope": "finite exact evaluations of the independently expanded symbolic identities"}


def psd_exact(matrix):
    """Exact symmetric Schur complements, including singular matrices."""
    a = [row[:] for row in matrix]
    while a:
        if any(a[i][j] != a[j][i] for i in range(len(a)) for j in range(len(a))):
            raise RuntimeError("Non-symmetric input to PSD check")
        if any(a[i][i] < 0 for i in range(len(a))):
            return False
        positive = next((i for i in range(len(a)) if a[i][i] > 0), None)
        if positive is None:
            return all(v == 0 for row in a for v in row)
        order = [positive] + [i for i in range(len(a)) if i != positive]
        a = [[a[i][j] for j in order] for i in order]
        pivot = a[0][0]
        a = [[a[i][j] - a[i][0] * a[0][j] / pivot
              for j in range(1, len(a))] for i in range(1, len(a))]
    return True


def physical_checks():
    rng = random.Random(202611240512)
    models = 0
    for mass in range(2, 7):
        for n in composition(mass):
            if len(n) == 1:
                continue
            for t in (Q(1, 2), Q(2, 3), Q(1)):
                levels = [i for i, count in enumerate(n) for _ in range(count)]
                s = sum((t ** i for i in levels), Q(0))
                q = [t ** i / s for i in levels]
                p = (1 / (1 + t), t / (1 + t))
                shells = defaultdict(list)
                for x in range(2):
                    for y in range(mass):
                        shells[p[x] * q[y]].append((x, y))
                for trial in range(3):
                    mapping = {}
                    for shell in shells.values():
                        sources = shell[:]
                        if trial == 0:
                            sources = sources[1:] + sources[:1]
                        else:
                            rng.shuffle(sources)
                        mapping.update(zip(shell, sources))
                    e = [[Q(0) for _ in range(mass)] for _ in range(mass)]
                    avg = [[Q(0) for _ in range(mass)] for _ in range(2)]
                    for (x, y), (_, source_y) in mapping.items():
                        v = [Q(0) for _ in range(mass)]
                        v[source_y] += 1
                        v[y] -= 1
                        for i in range(mass):
                            avg[x][i] += q[y] * v[i]
                            for j in range(mass):
                                e[i][j] += p[x] * q[y] * v[i] * v[j]
                    matrix = [[Q(mass - 1, mass) * e[i][j]
                               - sum((p[x] * avg[x][i] * avg[x][j] for x in range(2)), Q(0))
                               for j in range(mass)] for i in range(mass)]
                    check(psd_exact(matrix), "physical_permutation_psd",
                          witness(n, t, trial=trial,
                                  permutation=[list(mapping[(x, y)]) for x in range(2) for y in range(mass)]))
                    models += 1
    return {"matrix_models": models, "machine_dimensions": [2, 6],
            "multiplicities": "all ordered compositions, excluding one-layer chains",
            "t_values": ["1/2", "2/3", "1"], "permutations_per_model": 3,
            "permutation_rule": "one cyclic shell shift and two seeded independent shell shuffles",
            "seed": 202611240512,
            "claim": "PSD for all real perturbation directions in each listed finite permutation model; not all permutations or all dimensions"}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    scopes = {"binary": binary_checks(), "bounded_height": bounded_height_checks(),
              "prefixes": prefix_checks(), "ternary": ternary_checks(), "polynomials": polynomial_checks(),
              "physical": physical_checks()}
    result = {"status": "PASS", "arithmetic": "Python standard-library fractions.Fraction",
              "assert_statements_used": False,
              "checks": dict(sorted(COUNTS.items())), "total_checks": sum(COUNTS.values()),
              "scopes": scopes, "check_transcript_sha256": TRANSCRIPT.hexdigest(),
              "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              "general_proofs": "written analytic proofs; this finite certificate is not a substitute",
              "formal_proof_assistant_certification": False}
    result["certificate_payload_sha256"] = hashlib.sha256(canonical(result).encode()).hexdigest()
    text = json.dumps(result, indent=2, ensure_ascii=False) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(text, encoding="utf-8")
    print(text, end="")


if __name__ == "__main__":
    main()
