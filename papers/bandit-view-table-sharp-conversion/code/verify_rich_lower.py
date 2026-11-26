#!/usr/bin/env python3
"""Exact finite verification of the rich-reward attaining construction.

This is a reproducible finite experiment, not a universal theorem prover.
All probability and hockey-stick computations use integers or Fraction.
The input-class reduction for arbitrary real streams is justified in the
accompanying mathematical proof, not inferred from enumeration.
"""

from __future__ import annotations

import argparse
import hashlib
import itertools
import json
from fractions import Fraction
from math import lcm
from pathlib import Path


F = Fraction


def qstr(x: F | int) -> str:
    return str(F(x))


def decode_reward(reward: F, k: int) -> tuple[int, int] | None:
    if reward.denominator != 1 or not 0 <= reward.numerator < 2 * k:
        return None
    return divmod(reward.numerator, 2)


def classify(stream: tuple[F, ...], k: int, changed: int):
    decoded = tuple(decode_reward(x, k) for x in stream)
    if any(x is None for x in decoded):
        return None
    return tuple(x[0] for x in decoded), decoded[changed][1]


def terminal_p0(prefix: tuple[int, ...], stream: tuple[F, ...],
                k: int, changed: int, a: F) -> F:
    decoded = tuple(decode_reward(x, k) for x in stream)
    if any(x is None or x[0] != action
           for action, x in zip(prefix, decoded)):
        return F(1, 2)
    sign = 1 if decoded[changed][1] else -1
    return F(1, 2) + sign * a


def stream_law(prefixes, stream, k, changed, a):
    """Full nonzero transcript PMF; other terminal actions have mass zero."""
    m = len(prefixes)
    result = []
    for prefix in prefixes:
        p = terminal_p0(prefix, stream, k, changed, a)
        result.extend((p / m, (1 - p) / m))
    return tuple(result)


def table_law(prefixes, table, k, changed, a):
    m = len(prefixes)
    result = []
    for prefix in prefixes:
        stream = tuple(table[t][act] for t, act in enumerate(prefix))
        p = terminal_p0(prefix, stream, k, changed, a)
        result.extend((p / m, (1 - p) / m))
    return tuple(result)


def integer_laws(laws):
    denominator = lcm(*(p.denominator for law in laws for p in law))
    result = [tuple(int(p * denominator) for p in law) for law in laws]
    for law in result:
        assert min(law) >= 0
        assert sum(law) == denominator
    return result, denominator


def defect_numerator(p, q, lam):
    return sum(max(lam.denominator * x - lam.numerator * y, 0)
               for x, y in zip(p, q))


def check_decoder(k, n):
    valid_streams = tuple(itertools.product(tuple(map(F, range(2 * k))), repeat=n))
    expected = 2 * k ** n
    for changed in range(n):
        classes = {classify(s, k, changed) for s in valid_streams}
        assert len(classes) == expected and None not in classes
        # One invalid position forces the baseline for every valid setting
        # of all remaining positions. All invalid real values obey the same
        # decoder branch; enumeration alone does not prove that statement.
        for t in range(n):
            for rest in itertools.product(tuple(map(F, range(2 * k))), repeat=n - 1):
                s = rest[:t] + (F(1, 2),) + rest[t:]
                assert classify(s, k, changed) is None
    return {"valid_streams_per_changed_row": len(valid_streams),
            "changed_rows_checked": n,
            "induced_classes_including_baseline": expected + 1,
            "invalid_representative": "1/2"}


def check_case(k, t, lam, delta):
    n = t - 1
    prefixes = tuple(itertools.product(range(k), repeat=n))
    m = len(prefixes)
    eta = min(m * delta, F(1))
    a = (eta + (lam - 1) / 2) / (lam + 1)
    assert 0 <= a <= F(1, 2)
    assert (lam + 1) * a - (lam - 1) / 2 == eta

    # Every fixed real stream induces baseline or one (prefix, sign) law.
    streams = [(F(1, 2),) * n]
    for prefix in prefixes:
        for sign in (0, 1):
            s = tuple(F(2 * x) for x in prefix)
            streams.append((s[0] + sign,) + s[1:])
    laws = [stream_law(prefixes, s, k, 0, a) for s in streams]
    integral, denominator = integer_laws(laws)
    common = lam.denominator * denominator
    max_num = -1
    maximizer = None
    checked = 0
    # These are all ordered pairs, including equal laws/classes, so the
    # reverse inequality and every possible challenge replacement appear.
    for i, p in enumerate(integral):
        for j, q in enumerate(integral):
            value = defect_numerator(p, q, lam)
            assert F(value, common) <= eta / m <= delta
            if value > max_num:
                max_num, maximizer = value, [i, j]
            checked += 1
    max_view = F(max_num, common)
    assert max_view == eta / m

    row_witnesses = []
    for changed in range(n):
        minus = tuple(tuple(F(2 * i) for i in range(k)) for _ in range(n))
        plus = tuple(tuple(F(2 * i + (row == changed)) for i in range(k))
                     for row in range(n))
        assert sum(x != y for x, y in zip(plus, minus)) == 1
        p = table_law(prefixes, plus, k, changed, a)
        q = table_law(prefixes, minus, k, changed, a)
        (ip, iq), den = integer_laws([p, q])
        forward = F(defect_numerator(ip, iq, lam), lam.denominator * den)
        reverse = F(defect_numerator(iq, ip, lam), lam.denominator * den)
        event0 = sum(p[::2]) - lam * sum(q[::2])
        event1 = sum(q[1::2]) - lam * sum(p[1::2])
        assert forward == reverse == event0 == event1 == eta
        # Canonical neighboring streams attain the exact View defect at
        # each possible influential changed row.
        s0 = (F(0),) * n
        s1 = tuple(F(row == changed) for row in range(n))
        (iv0, iv1), vd = integer_laws([
            stream_law(prefixes, s0, k, changed, a),
            stream_law(prefixes, s1, k, changed, a)])
        assert F(defect_numerator(iv0, iv1, lam), lam.denominator * vd) == eta / m
        row_witnesses.append({"changed_row_one_based": changed + 1,
                              "forward_table_defect": qstr(forward),
                              "reverse_table_defect": qstr(reverse),
                              "terminal_action_events_attain": True})

    return {
        "K": k, "T": t, "M": m, "lambda": qstr(lam), "delta": qstr(delta),
        "eta": qstr(eta), "a": qstr(a), "input_classes": len(laws),
        "nonzero_output_coordinates": 2 * m,
        "ordered_class_pairs_checked": checked,
        "exact_max_view_defect": qstr(max_view),
        "expected_max_view_defect": qstr(eta / m),
        "one_maximizing_class_pair": maximizer,
        "all_laws_normalized_and_nonnegative": True,
        "row_witnesses": row_witnesses,
        "final_reward_used": False,
        "status": "pass"
    }


def run():
    dimensions = [(2, 2), (2, 3), (2, 4), (2, 5),
                  (3, 2), (3, 3), (3, 4), (4, 2), (4, 3)]
    lambdas = [F(1), F(5, 4), F(2), F(7)]
    records = []
    decoders = []
    for k, t in dimensions:
        m = k ** (t - 1)
        decoders.append({"K": k, "T": t, **check_decoder(k, t - 1)})
        deltas = list(dict.fromkeys([F(0), F(1, 8 * m), F(1, 2 * m),
                                    F(1, m), min(F(2, m), F(1)), F(1)]))
        for lam in lambdas:
            for delta in deltas:
                records.append(check_case(k, t, lam, delta))
    return {
        "schema": "rich_lower_exact_verification_v1",
        "status": "pass",
        "arithmetic": "Exact Python integers and fractions.Fraction; no floating-point comparisons",
        "scope": "Finite parameter grid only. Every ordered pair of induced real-stream law classes is enumerated for each case; the exhaustive class reduction is a mathematical lemma, not an empirical inference.",
        "not_a_universal_proof": True,
        "parameter_grid": {
            "K_T_pairs": dimensions,
            "lambda_values": list(map(qstr, lambdas)),
            "delta_rule": ["0", "1/(8M)", "1/(2M)", "1/M", "min(2/M,1)", "1"],
            "duplicate_delta_values_removed": True
        },
        "cases_checked": len(records),
        "ordered_class_pairs_checked": sum(x["ordered_class_pairs_checked"] for x in records),
        "table_row_witnesses_checked": sum(len(x["row_witnesses"]) for x in records),
        "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "decoder_checks": decoders,
        "cases": records
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results" / "rich_lower_verification.json")
    args = parser.parse_args()
    report = run()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2) + "\n")
    print(json.dumps({k: report[k] for k in
                      ("status", "cases_checked", "ordered_class_pairs_checked",
                       "table_row_witnesses_checked", "not_a_universal_proof")}, indent=2))


if __name__ == "__main__":
    main()
