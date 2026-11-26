#!/usr/bin/env python3
"""Independent, exact verifier for the product-RR blanket comparison.

This implementation reads cases.json, but not verify_exact.py.  It builds the
joint law of the two likelihood factors by coordinate recursion with integer
multiplicities, rather than by enumeration of product-alphabet output vectors.
It then uses Fraction arithmetic and sparse convolution.  All subset inclusions
are checked at every stop-loss breakpoint of the compared sum distributions.

Run from any directory:
    python3 code/verify_independent.py

The output is results/independent_checks.json unless --output is supplied.
Finite checks validate the configured instances; the written general proof is
in reviews/proposer_derivation.md.  No assertion is used as a checking gate.
"""

from __future__ import annotations

import argparse
from bisect import bisect_right
from collections import defaultdict
from fractions import Fraction
import hashlib
import json
from pathlib import Path
from typing import Iterable


Law = dict[Fraction, Fraction]
JointCounts = dict[tuple[Fraction, Fraction], int]


class VerificationFailure(RuntimeError):
    """An exact invariant or comparison failed."""


def require(condition: bool, message: str) -> None:
    if not condition:
        raise VerificationFailure(message)


def product(values: Iterable[Fraction | int]) -> Fraction:
    result = Fraction(1)
    for value in values:
        result *= value
    return result


def canonical_law(law: Law) -> list[list[str]]:
    return [[str(value), str(probability)] for value, probability in sorted(law.items())]


def law_sha256(law: Law) -> str:
    serialized = json.dumps(canonical_law(law), separators=(",", ":")).encode()
    return hashlib.sha256(serialized).hexdigest()


def clean_law(law: Law) -> Law:
    return {value: probability for value, probability in law.items() if probability != 0}


def validate_law(law: Law, expected_mean: Fraction, context: str) -> None:
    require(bool(law), f"{context}: empty support")
    require(all(probability > 0 for probability in law.values()),
            f"{context}: nonpositive mass in stored support")
    require(sum(law.values(), Fraction(0)) == 1, f"{context}: total mass != 1")
    mean = sum((value * probability for value, probability in law.items()), Fraction(0))
    require(mean == expected_mean,
            f"{context}: mean {mean}, expected {expected_mean}")


def joint_factor_counts(k: list[int], r: list[Fraction], mask: int) -> JointCounts:
    """Accumulate (P,Q) multiplicities using at most three local factor types.

    No full product-alphabet vector is generated.  Equal partial factors are
    merged after every coordinate.  Counts stay integral even when r is rational.
    """
    counts: JointCounts = {(Fraction(1), Fraction(1)): 1}
    total_outputs = 1
    for coordinate, (alphabet_size, ratio) in enumerate(zip(k, r)):
        local: dict[tuple[Fraction, Fraction], int] = defaultdict(int)
        if mask & (1 << coordinate):
            local[(ratio, Fraction(1))] += 1
            local[(Fraction(1), ratio)] += 1
            local[(Fraction(1), Fraction(1))] += alphabet_size - 2
        else:
            local[(ratio, ratio)] += 1
            local[(Fraction(1), Fraction(1))] += alphabet_size - 1
        next_counts: dict[tuple[Fraction, Fraction], int] = defaultdict(int)
        for (left, right), count in counts.items():
            for (left_factor, right_factor), multiplicity in local.items():
                if multiplicity:
                    next_counts[(left * left_factor, right * right_factor)] += (
                        count * multiplicity
                    )
        counts = dict(next_counts)
        total_outputs *= alphabet_size
        require(sum(counts.values()) == total_outputs,
                f"mask={mask}, coordinate={coordinate}: joint count total is wrong")
    return counts


def gparv_law(counts: JointCounts, k: list[int], r: list[Fraction],
              alpha: Fraction) -> Law:
    output_count = product(k)
    denominator = product(ratio + size - 1 for size, ratio in zip(k, r))
    gamma = output_count / denominator
    require(0 < gamma <= 1, f"invalid blanket mass {gamma}")
    law: dict[Fraction, Fraction] = defaultdict(Fraction)
    law[Fraction(0)] += 1 - gamma
    # gamma / output_count = 1 / denominator.  Keep this bridge explicit.
    for (left, right), count in counts.items():
        law[left - alpha * right] += gamma * Fraction(count) / output_count
    return clean_law(dict(law))


def convolve(left: Law, right: Law) -> Law:
    out: dict[Fraction, Fraction] = defaultdict(Fraction)
    for left_value, left_probability in left.items():
        for right_value, right_probability in right.items():
            out[left_value + right_value] += left_probability * right_probability
    return clean_law(dict(out))


def positive_expectation(law: Law) -> Fraction:
    return sum((value * probability for value, probability in law.items() if value > 0),
               Fraction(0))


class StopLoss:
    """Exact values E[(X-threshold)_+] from suffix mass and first moment."""

    def __init__(self, law: Law) -> None:
        ordered = sorted(law.items())
        self.support = [value for value, _ in ordered]
        length = len(ordered)
        self.tail_mass = [Fraction(0)] * (length + 1)
        self.tail_moment = [Fraction(0)] * (length + 1)
        for index in range(length - 1, -1, -1):
            value, probability = ordered[index]
            self.tail_mass[index] = self.tail_mass[index + 1] + probability
            self.tail_moment[index] = self.tail_moment[index + 1] + value * probability

    def at(self, threshold: Fraction) -> Fraction:
        index = bisect_right(self.support, threshold)
        return self.tail_moment[index] - threshold * self.tail_mass[index]


def verify_inclusions(laws: dict[int, Law], context: str) -> tuple[int, int, int]:
    """Check all D subset E, including identity, at every support breakpoint."""
    transforms = {mask: StopLoss(law) for mask, law in laws.items()}
    inclusion_count = 0
    proper_inclusion_count = 0
    breakpoint_count = 0
    for old_mask in sorted(laws):
        for new_mask in sorted(laws):
            if old_mask & ~new_mask:
                continue
            inclusion_count += 1
            if old_mask != new_mask:
                proper_inclusion_count += 1
            old, new = transforms[old_mask], transforms[new_mask]
            thresholds = sorted(set(old.support) | set(new.support))
            for threshold in thresholds:
                old_value, new_value = old.at(threshold), new.at(threshold)
                require(old_value <= new_value,
                        f"{context}, D={old_mask}, E={new_mask}, threshold={threshold}: "
                        f"stop-loss {old_value} > {new_value}")
                breakpoint_count += 1
            require(positive_expectation(laws[old_mask]) <=
                    positive_expectation(laws[new_mask]),
                    f"{context}, D={old_mask}, E={new_mask}: main bound reverses")
    return inclusion_count, proper_inclusion_count, breakpoint_count


def validate_case(case: dict, used_ids: set[str]) -> tuple[list[int], list[Fraction],
                                                           list[Fraction], list[int]]:
    case_id = case.get("id")
    require(isinstance(case_id, str) and bool(case_id), "case id must be a nonempty string")
    require(case_id not in used_ids, f"duplicate case id {case_id}")
    used_ids.add(case_id)
    k = case.get("k")
    require(isinstance(k, list) and bool(k), f"{case_id}: k must be a nonempty list")
    require(all(isinstance(size, int) and not isinstance(size, bool) and size >= 2 for size in k),
            f"{case_id}: each alphabet size must be an integer >= 2")
    r = [Fraction(value) for value in case.get("r", [])]
    require(len(k) == len(r) and all(ratio >= 1 for ratio in r),
            f"{case_id}: r must match k and satisfy r_j >= 1")
    alphas = [Fraction(value) for value in case.get("lambda", [])]
    require(bool(alphas) and all(alpha >= 0 for alpha in alphas),
            f"{case_id}: lambda must be nonempty and nonnegative")
    require(len(set(alphas)) == len(alphas), f"{case_id}: duplicate lambda")
    ns = case.get("n")
    require(isinstance(ns, list) and bool(ns) and
            all(isinstance(n, int) and not isinstance(n, bool) and n >= 1 for n in ns),
            f"{case_id}: n must contain positive integers")
    require(len(set(ns)) == len(ns), f"{case_id}: duplicate n")
    return k, r, alphas, ns


def run(config_path: Path) -> dict:
    config_bytes = config_path.read_bytes()
    config = json.loads(config_bytes)
    require(config.get("schema") == "exact_rr_blanket_cases_v1", "unsupported configuration schema")
    require(isinstance(config.get("cases"), list) and bool(config["cases"]), "no cases")
    rows: list[dict] = []
    case_statistics: list[dict] = []
    used_ids: set[str] = set()
    total_inclusions = total_proper = total_breakpoints = total_homogeneous_equalities = 0
    for case in config["cases"]:
        k, r, alphas, ns = validate_case(case, used_ids)
        case_id = case["id"]
        dimension = len(k)
        masks = range(1 << dimension)
        joint_counts = {mask: joint_factor_counts(k, r, mask) for mask in masks}
        case_inclusions = case_proper = case_breakpoints = case_homogeneous = 0
        case_row_start = len(rows)
        for alpha in alphas:
            one_laws = {mask: gparv_law(joint_counts[mask], k, r, alpha) for mask in masks}
            sums = {mask: {Fraction(0): Fraction(1)} for mask in masks}
            for n in range(1, max(ns) + 1):
                sums = {mask: convolve(sums[mask], one_laws[mask]) for mask in masks}
                if n not in ns:
                    continue
                context = f"case={case_id}, lambda={alpha}, n={n}"
                for mask in masks:
                    law = sums[mask]
                    validate_law(law, n * (1 - alpha), f"{context}, mask={mask}")
                    bound = positive_expectation(law) / n
                    cutoff = product(r[j] for j in range(dimension) if mask & (1 << j))
                    require((bound == 0) == (alpha >= cutoff),
                            f"{context}, mask={mask}: zero-bound cutoff mismatch")
                    rows.append({
                        "case": case_id,
                        "lambda": str(alpha),
                        "n": n,
                        "mask": mask,
                        "support": len(law),
                        "law_sha256": law_sha256(law),
                        "bound": str(bound),
                    })
                inclusions, proper, breakpoints = verify_inclusions(sums, context)
                case_inclusions += inclusions
                case_proper += proper
                case_breakpoints += breakpoints
                if len(set(k)) == 1 and len(set(r)) == 1:
                    representative: dict[int, Law] = {}
                    for mask in masks:
                        distance = mask.bit_count()
                        if distance in representative:
                            require(sums[mask] == representative[distance],
                                    f"{context}: law depends on more than Hamming distance")
                            case_homogeneous += 1
                        else:
                            representative[distance] = sums[mask]
        total_inclusions += case_inclusions
        total_proper += case_proper
        total_breakpoints += case_breakpoints
        total_homogeneous_equalities += case_homogeneous
        case_statistics.append({
            "case": case_id,
            "law_rows": len(rows) - case_row_start,
            "joint_factor_support_by_mask": {
                str(mask): len(joint_counts[mask]) for mask in masks
            },
            "inclusion_comparisons_including_identity": case_inclusions,
            "proper_inclusion_comparisons": case_proper,
            "stop_loss_breakpoints_checked": case_breakpoints,
            "homogeneous_same_distance_law_equalities": case_homogeneous,
        })
    # A retained equality example ensures the implementation never silently
    # replaces the theorem's weak inequality by a false strict one.
    equality_witness = [row for row in rows
                        if row["case"] == "binary-2" and row["lambda"] == "1"
                        and row["n"] == 1 and row["mask"] in (1, 3)]
    if equality_witness:
        require(len(equality_witness) == 2 and
                all(row["bound"] == "1/3" for row in equality_witness),
                "configured nonstrictness witness did not equal 1/3")
    return {
        "schema": "independent_rr_blanket_checks_v1",
        "status": "passed",
        "arithmetic": "fractions.Fraction; exact rational arithmetic; rounding error 0",
        "construction": "coordinate joint-factor integer-count recursion, then Bernoulli mixture and sparse convolution",
        "configuration_file": "code/cases.json",
        "configuration_sha256": hashlib.sha256(config_bytes).hexdigest(),
        "scope": "configured finite parameter grid; general theorem is proved separately",
        "law_hashed": "unscaled sum of n independent GPARVs; sorted [str(value),str(probability)] pairs with compact JSON",
        "law_rows": len(rows),
        "inclusion_comparisons_including_identity": total_inclusions,
        "proper_inclusion_comparisons": total_proper,
        "stop_loss_breakpoints_checked": total_breakpoints,
        "homogeneous_same_distance_law_equalities": total_homogeneous_equalities,
        "zero_cutoff_checks": len(rows),
        "case_statistics": case_statistics,
        "nonstrictness_witness_rows": equality_witness,
        "rows": rows,
    }


def main() -> None:
    case_root = Path(__file__).resolve().parents[1]
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--config", type=Path, default=case_root / "code" / "cases.json")
    parser.add_argument("--output", type=Path,
                        default=case_root / "results" / "independent_checks.json")
    args = parser.parse_args()
    report = run(args.config)
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n")
    print(json.dumps({key: report[key] for key in (
        "status", "law_rows", "inclusion_comparisons_including_identity",
        "proper_inclusion_comparisons", "stop_loss_breakpoints_checked",
        "homogeneous_same_distance_law_equalities", "zero_cutoff_checks",
    )}, sort_keys=True))


if __name__ == "__main__":
    main()
