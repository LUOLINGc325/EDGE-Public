#!/usr/bin/env python3
"""Exact finite regression checks from the sixteen Bell measurement outcomes.

Only Python's standard library is used.  All amplitudes, phases, Born
probabilities, and probability-weighted output entanglements are computed in
the Gaussian rationals.  These finite checks do not prove a universal theorem.
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass
from fractions import Fraction as F
from hashlib import sha256
import json
from math import isqrt
from pathlib import Path
from typing import Sequence


def require(condition: bool, message: str) -> None:
    """A check that remains active under python -O."""
    if not condition:
        raise ArithmeticError(message)


@dataclass(frozen=True)
class Gaussian:
    re: F
    im: F

    def __add__(self, other: Gaussian) -> Gaussian:
        return Gaussian(self.re + other.re, self.im + other.im)

    def __mul__(self, other: Gaussian) -> Gaussian:
        return Gaussian(self.re * other.re - self.im * other.im,
                        self.re * other.im + self.im * other.re)

    def conjugate(self) -> Gaussian:
        return Gaussian(self.re, -self.im)

    def scale(self, factor: F) -> Gaussian:
        return Gaussian(factor * self.re, factor * self.im)

    def norm_square(self) -> F:
        return self.re * self.re + self.im * self.im

    def magnitude(self) -> F:
        """Exact modulus; the root-of-unity test data have rational moduli."""
        square = self.norm_square()
        num = isqrt(square.numerator)
        den = isqrt(square.denominator)
        require(num * num == square.numerator and den * den == square.denominator,
                "This test requires a rational modulus, not a rounded square root")
        return F(num, den)

    def as_json(self) -> dict[str, str]:
        return {"real": str(self.re), "imaginary": str(self.im)}


ZERO = Gaussian(F(0), F(0))
ONE = Gaussian(F(1), F(0))
I_POWERS = (ONE, Gaussian(F(0), F(1)),
            Gaussian(F(-1), F(0)), Gaussian(F(0), F(-1)))
Vector = tuple[F, F, F, F]


def inner_product(left: Sequence[Gaussian], right: Sequence[Gaussian]) -> Gaussian:
    value = ZERO
    for x, y in zip(left, right):
        value = value + x.conjugate() * y
    return value


def bell_vector(shift: int, phase: int) -> tuple[Gaussian, ...]:
    """|B_(p,m)> = (1/2) sum_j i^(m*j) |p+j mod 4, j>."""
    entries = [ZERO for _ in range(16)]
    for j in range(4):
        entries[4 * ((shift + j) % 4) + j] = I_POWERS[(phase * j) % 4].scale(F(1, 2))
    return tuple(entries)


def check_bell_basis() -> tuple[list[tuple[int, int, tuple[Gaussian, ...]]], int]:
    basis = [(p, m, bell_vector(p, m)) for p in range(4) for m in range(4)]
    checks = 0
    for index, (_, _, left) in enumerate(basis):
        for other, (_, _, right) in enumerate(basis):
            require(inner_product(left, right) == (ONE if index == other else ZERO),
                    f"Bell basis is not orthonormal at {index}, {other}")
            checks += 1
    return basis, checks


def project_bell(a: Vector, b: Vector, bell: Sequence[Gaussian]) -> tuple[Gaussian, ...]:
    """Apply <B| on B,C to sum a_i b_j |i,i,j,j>_(A,B,C,D).

    This is a tensor-index projection, independent of transfer/correlation
    identities.  The result has sixteen A,D computational-basis amplitudes.
    """
    output: list[Gaussian] = []
    for ia in range(4):
        for id_ in range(4):
            amplitude = ZERO
            for ib in range(4):
                for ic in range(4):
                    input_amplitude = a[ia] * b[ic] if ia == ib and ic == id_ else F(0)
                    if input_amplitude:
                        amplitude = amplitude + bell[4 * ib + ic].conjugate().scale(input_amplitude)
            output.append(amplitude)
    return tuple(output)


def inspect_outcome(output: Sequence[Gaussian]) -> dict:
    """Born probability and its weighted pure-state Schmidt l1 resource.

    A nonzero branch has matching support (each A and D index occurs once),
    hence its Schmidt amplitudes are the moduli of the nonzero coefficients.
    For probability P and unnormalised coefficients c, P*E is the sum of
    |c_r conjugate(c_s)| over r != s.  No square-root division or float is used.
    The zero-probability outcome contributes zero and has no normalized state.
    """
    active = [(index, z) for index, z in enumerate(output) if z != ZERO]
    require(len({index // 4 for index, _ in active}) == len(active),
            "Output support does not form a Schmidt matching on A")
    require(len({index % 4 for index, _ in active}) == len(active),
            "Output support does not form a Schmidt matching on D")
    probability = sum((z.norm_square() for z in output), F(0))
    weighted = F(0)
    for r, cr in active:
        for s, cs in active:
            if r != s:
                density_entry = cr * cs.conjugate()
                weighted += density_entry.magnitude()
    require(probability >= 0 and weighted >= 0, "Negative probability or entanglement")
    require(weighted <= 3 * probability, "A ququart branch exceeded l1 resource 3")
    if probability == 0:
        require(not active and weighted == 0, "A zero-probability branch carried resource")
        normalized = None
    else:
        normalized = weighted / probability
        require(probability * normalized == weighted, "Born weighting failed")
    return {"probability": probability, "weighted": weighted, "normalized": normalized,
            "active": active}


def entanglement(a: Vector) -> F:
    return sum((a[j] * a[k] for j in range(4) for k in range(4) if j != k), F(0))


def opposite(a: Vector) -> F:
    return 2 * (a[0] * a[2] + a[1] * a[3])


def correlation_sum(a: Vector, b: Vector) -> F:
    return sum((a[(p + j) % 4] * a[(p + k) % 4] * b[j] * b[k]
                for p in range(4) for j in range(4) for k in range(4) if j != k), F(0))


def transfer(e: F, f: F, t: F, u: F) -> F:
    return (e - t) * (f - u) / 2 + t * u


def radius(e: F) -> F:
    return e if e <= 1 else (3 - e) / 2


def compact_bounds(e: F, f: F) -> tuple[F, F]:
    return ((e * f - radius(e) * radius(f)) / 3,
            (e * f + 2 * radius(e) * radius(f)) / 3)


def piecewise_bounds(e: F, f: F) -> tuple[F, F]:
    if e <= 1:
        if f <= 1:
            return F(0), e * f
        return e * (f - 1) / 2, e
    if f <= 1:
        return f * (e - 1) / 2, f
    return (e * f + e + f - 3) / 4, 1 + (e - 1) * (f - 1) / 2


def feasible(e: F, t: F) -> bool:
    return 0 <= e <= 3 and 0 <= t <= 1 and t <= e and e - 1 <= 2 * t


def sphere_vector(x: F, y: F, z: F) -> Vector:
    """Stereographic rational parametrization of the positive unit 3-sphere."""
    q = x * x + y * y + z * z
    require(x >= 0 and y >= 0 and z >= 0 and q <= 1, "Invalid positive-sphere parameters")
    den = 1 + q
    return ((1 - q) / den, 2 * x / den, 2 * y / den, 2 * z / den)


def test_vectors() -> list[tuple[str, Vector]]:
    vectors: list[tuple[str, Vector]] = []
    for index in range(4):
        vectors.append((f"basis_{index}", tuple(F(int(j == index)) for j in range(4))))
    vectors.extend([
        ("two_adjacent", (F(3, 5), F(4, 5), F(0), F(0))),
        ("two_opposite", (F(3, 5), F(0), F(4, 5), F(0))),
        ("two_opposite_shifted", (F(0), F(4, 5), F(0), F(3, 5))),
        ("uniform", (F(1, 2),) * 4),
        ("published_7_1_7_1", (F(7, 10), F(1, 10), F(7, 10), F(1, 10))),
        ("published_permuted_7_7_1_1", (F(7, 10), F(7, 10), F(1, 10), F(1, 10))),
        ("paired_17_7_17_7", (F(17, 26), F(7, 26), F(17, 26), F(7, 26))),
        ("paired_17_17_7_7", (F(17, 26), F(17, 26), F(7, 26), F(7, 26))),
        ("paired_41_1_41_1", (F(41, 58), F(1, 58), F(41, 58), F(1, 58))),
        ("paired_41_41_1_1", (F(41, 58), F(41, 58), F(1, 58), F(1, 58))),
    ])
    parameters = [
        (F(1, 3), F(1, 4), F(1, 5)),
        (F(1, 2), F(1, 3), F(1, 4)),
        (F(1, 2), F(1, 2), F(1, 2)),
        (F(1, 2), F(1, 5), F(1, 7)),
        (F(2, 5), F(1, 4), F(2, 7)),
        (F(1, 7), F(2, 7), F(3, 7)),
        (F(1, 6), F(1, 7), F(1, 8)),
        (F(2, 3), F(1, 5), F(1, 4)),
        (F(3, 5), F(2, 5), F(1, 5)),
        (F(1, 4), F(1, 4), F(3, 4)),
        (F(1, 20), F(1, 30), F(1, 40)),
        (F(1, 40), F(1, 25), F(1, 50)),
    ]
    vectors.extend((f"sphere_{i:02d}", sphere_vector(*row)) for i, row in enumerate(parameters))
    require(len({name for name, _ in vectors}) == len(vectors), "Duplicate vector identifiers")
    require(len({a for _, a in vectors}) == len(vectors), "Duplicate vectors")
    for name, a in vectors:
        require(len(a) == 4 and all(x >= 0 for x in a), f"Invalid amplitudes for {name}")
        require(sum((x * x for x in a), F(0)) == 1, f"Unnormalized vector {name}")
        require(feasible(entanglement(a), opposite(a)), f"Feasibility failure for {name}")
    return vectors


DETAILED_PAIRS = {
    ("basis_0", "basis_0"),
    ("two_adjacent", "two_opposite"),
    ("published_7_1_7_1", "published_7_1_7_1"),
    ("published_7_1_7_1", "published_permuted_7_7_1_1"),
    ("sphere_00", "sphere_11"),
}


def outcome_json(shift: int, phase: int, outcome: dict) -> dict:
    return {
        "shift": shift, "phase": phase,
        "born_probability": str(outcome["probability"]),
        "probability_weighted_output_l1": str(outcome["weighted"]),
        "normalized_output_l1": None if outcome["normalized"] is None else str(outcome["normalized"]),
        "unnormalized_output_amplitudes": [
            {"A": index // 4, "D": index % 4, **z.as_json()}
            for index, z in outcome["active"]
        ],
    }


def check_pair(name_a: str, a: Vector, name_b: str, b: Vector, basis: list) -> dict:
    probabilities, average = F(0), F(0)
    zero_outcomes = 0
    by_shift: dict[int, tuple[F, F]] = {}
    outcomes: list[dict] = []
    for p, m, bell in basis:
        out = inspect_outcome(project_bell(a, b, bell))
        probabilities += out["probability"]
        average += out["weighted"]
        zero_outcomes += int(out["probability"] == 0)
        phase_values = (out["probability"], out["weighted"])
        if p in by_shift:
            require(by_shift[p] == phase_values, f"Unexpected phase dependence: {name_a}, {name_b}, {p}")
        else:
            by_shift[p] = phase_values
        if (name_a, name_b) in DETAILED_PAIRS:
            outcomes.append(outcome_json(p, m, out))
    require(probabilities == 1, f"Born probabilities do not sum to one: {name_a}, {name_b}")
    e, f, t, u = entanglement(a), entanglement(b), opposite(a), opposite(b)
    correlation = correlation_sum(a, b)
    contracted = transfer(e, f, t, u)
    lower, upper = compact_bounds(e, f)
    require(average == correlation == contracted, f"Average formulas disagree: {name_a}, {name_b}")
    require((lower, upper) == piecewise_bounds(e, f), f"Bound formulas disagree: {name_a}, {name_b}")
    require(lower <= average <= upper, f"Attainable bound failure: {name_a}, {name_b}")
    row = {
        "input_A_B": name_a, "input_C_D": name_b,
        "e": str(e), "f": str(f), "t": str(t), "u": str(u),
        "born_probability_sum": str(probabilities),
        "direct_bell_average": str(average),
        "correlation_sum": str(correlation), "transfer": str(contracted),
        "lower": str(lower), "upper": str(upper),
        "distance_from_lower": str(average - lower),
        "distance_from_upper": str(upper - average),
        "zero_probability_outcomes": zero_outcomes,
        "at_lower_endpoint": average == lower,
        "at_upper_endpoint": average == upper,
        "branch_details": outcomes,
    }
    return row


def check_parameter_rectangles() -> dict:
    """Separate rational-parameter checks include e=1 and f=1 explicitly."""
    grid = [F(0), F(1, 5), F(1, 2), F(1), F(3, 2), F(2), F(5, 2), F(3)]
    rows = []
    feasible_points_checked = 0
    for e in grid:
        for f in grid:
            tl, th = max(F(0), (e - 1) / 2), min(e, F(1))
            ul, uh = max(F(0), (f - 1) / 2), min(f, F(1))
            corners = [transfer(e, f, t, u) for t in (tl, th) for u in (ul, uh)]
            lower, upper = compact_bounds(e, f)
            require(min(corners) == lower and max(corners) == upper,
                    f"Corner extrema failed for e={e}, f={f}")
            require((lower, upper) == piecewise_bounds(e, f), "Piecewise endpoint mismatch")
            for t in (tl, (2 * tl + th) / 3, (tl + 2 * th) / 3, th):
                for u in (ul, (2 * ul + uh) / 3, (ul + 2 * uh) / 3, uh):
                    require(feasible(e, t) and feasible(f, u), "Invalid rectangle test point")
                    require(lower <= transfer(e, f, t, u) <= upper, "Interior rectangle bound failure")
                    feasible_points_checked += 1
            rows.append({"e": str(e), "f": str(f), "t_interval": [str(tl), str(th)],
                         "u_interval": [str(ul), str(uh)],
                         "four_corner_values": [str(x) for x in corners],
                         "minimum": str(lower), "maximum": str(upper)})
    return {"parameter_grid": [str(x) for x in grid], "rectangles_checked": len(rows),
            "feasible_points_checked": feasible_points_checked, "rows": rows,
            "scope": "Algebraic parameter checks; not additional direct rational-amplitude Bell experiments."}


def certificate() -> dict:
    basis, orthogonality_checks = check_bell_basis()
    vectors = test_vectors()
    pairs = [check_pair(na, a, nb, b, basis) for na, a in vectors for nb, b in vectors]
    by_pair = {(row["input_A_B"], row["input_C_D"]): row for row in pairs}
    published = by_pair[("published_7_1_7_1", "published_7_1_7_1")]
    endpoint = by_pair[("published_7_1_7_1", "published_permuted_7_7_1_1")]
    require(published["e"] == published["f"] == "39/25", "Published-example input resource changed")
    require(published["direct_bell_average"] == "723/625" and published["at_upper_endpoint"],
            "Published-example upper endpoint changed")
    require(endpoint["direct_bell_average"] == "399/625" and endpoint["at_lower_endpoint"],
            "Fixed-resource lower endpoint changed")
    parameter_checks = check_parameter_rectangles()
    full_support = sum(all(x > 0 for x in a) for _, a in vectors)
    return {
        "schema_version": 1,
        "status": "all_exact_checks_passed",
        "arithmetic": "Python fractions.Fraction and exact Gaussian rational arithmetic; no floating point",
        "script_sha256": sha256(Path(__file__).read_bytes()).hexdigest(),
        "model": {
            "input": "sum_i a_i |i,i>_(A,B) tensor sum_j b_j |j,j>_(C,D)",
            "measurement": "All 16 |B_(p,m)>_(B,C) = (1/2) sum_j i^(m*j) |p+j mod 4,j>",
            "resource": "Pure-state unnormalized Schmidt l1 entanglement E=(sum Schmidt amplitudes)^2-1",
            "averaging": "sum over all outcomes of Born probability times normalized output E",
            "zero_probability": "No normalized state is assigned; contribution to the average is zero.",
        },
        "scope_limits": [
            "Finite exact regressions do not prove the universal attainable-region or interval theorems.",
            "The direct Bell calculation is independent of both correlation_sum and transfer.",
            "Only nonnegative rational input Schmidt amplitudes are tested in the direct Bell calculation.",
            "The boundary e=1 has no rational-amplitude normalized input: sum(a_i) would equal sqrt(2). It is included only in the separate parameter-rectangle checks; the Lean theorem covers it generally.",
            "The published (7,1,7,1)/10 example is a baseline reproduction, not a novelty claim.",
        ],
        "counts": {
            "vectors": len(vectors), "strictly_positive_vectors": full_support,
            "vectors_with_zero_support": len(vectors) - full_support,
            "bell_orthogonality_inner_products": orthogonality_checks,
            "ordered_input_pairs": len(pairs), "outcomes_projected": 16 * len(pairs),
            "zero_probability_outcomes": sum(row["zero_probability_outcomes"] for row in pairs),
            "pairs_attaining_lower_endpoint": sum(row["at_lower_endpoint"] for row in pairs),
            "pairs_attaining_upper_endpoint": sum(row["at_upper_endpoint"] for row in pairs),
            "detailed_outcomes_recorded": sum(len(row["branch_details"]) for row in pairs),
            "parameter_rectangles": parameter_checks["rectangles_checked"],
            "parameter_feasible_points": parameter_checks["feasible_points_checked"],
        },
        "vectors": [{"id": name, "amplitudes": [str(x) for x in a],
                     "e": str(entanglement(a)), "t": str(opposite(a)),
                     "norm_square": str(sum((x * x for x in a), F(0)))} for name, a in vectors],
        "same_fixed_resource_examples": {
            "e": "39/25", "f": "39/25", "lower": "399/625", "upper": "723/625",
            "upper_pair": ["published_7_1_7_1", "published_7_1_7_1"],
            "lower_pair": ["published_7_1_7_1", "published_permuted_7_7_1_1"],
        },
        "pair_results": pairs,
        "parameter_rectangle_checks": parameter_checks,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results" / "exact_certificate.json")
    args = parser.parse_args()
    result = certificate()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True) + "\n",
                           encoding="utf-8")
    print(json.dumps({"status": result["status"], "counts": result["counts"]},
                     ensure_ascii=False, sort_keys=True))


if __name__ == "__main__":
    main()
