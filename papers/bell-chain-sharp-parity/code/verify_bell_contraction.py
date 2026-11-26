#!/usr/bin/env python3
"""Independently reconstruct finite Bell-chain branches with exact arithmetic.

This route enumerates input basis tuples and contracts the Bell bras directly.
It does not use cumulative shifts or the correlation formula to construct the
physical output. Those formulas are evaluated separately for comparison.
Complex phases are represented in Q[zeta_L], L=lcm(d,4), using the cyclotomic
polynomial. All scalar arithmetic uses fractions.Fraction; no floats are used.

The script was authored in the same AI-assisted project as the manuscript.
"Independent" describes the computational route, not a separate human author.
"""

from __future__ import annotations

import argparse
from fractions import Fraction as Q
from functools import lru_cache
from hashlib import sha256
from itertools import product
import json
from math import isqrt, lcm, prod
from pathlib import Path


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ValueError(message)


def qs(x: Q) -> str:
    return str(x.numerator) if x.denominator == 1 else f"{x.numerator}/{x.denominator}"


def trim(p: list[Q]) -> list[Q]:
    while len(p) > 1 and p[-1] == 0:
        p.pop()
    return p


def exact_poly_division(a: tuple[Q, ...], b: tuple[Q, ...]) -> tuple[Q, ...]:
    remainder = list(a)
    quotient = [Q(0)] * (len(a) - len(b) + 1)
    for k in range(len(quotient) - 1, -1, -1):
        coefficient = remainder[k + len(b) - 1] / b[-1]
        quotient[k] = coefficient
        for j, value in enumerate(b):
            remainder[k + j] -= coefficient * value
    require(all(value == 0 for value in remainder), "Polynomial division not exact.")
    return tuple(trim(quotient))


@lru_cache(maxsize=None)
def cyclotomic_polynomial(n: int) -> tuple[Q, ...]:
    polynomial = (Q(-1),) + (Q(0),) * (n - 1) + (Q(1),)
    for divisor in range(1, n):
        if n % divisor == 0:
            polynomial = exact_poly_division(polynomial, cyclotomic_polynomial(divisor))
    return polynomial


class Cyclotomic:
    def __init__(self, order: int):
        self.order = order
        self.polynomial = cyclotomic_polynomial(order)
        self.degree = len(self.polynomial) - 1
        self.zero = (Q(0),) * self.degree
        self.one = (Q(1),) + (Q(0),) * (self.degree - 1)
        self.powers = [self.reduce([Q(0)] * exponent + [Q(1)])
                       for exponent in range(order)]

    def reduce(self, values: list[Q]) -> tuple[Q, ...]:
        values = list(values)
        while len(values) > self.degree:
            top = values[-1]
            shift = len(values) - 1 - self.degree
            if top:
                for j, coefficient in enumerate(self.polynomial):
                    values[shift + j] -= top * coefficient
            values.pop()
        values.extend([Q(0)] * (self.degree - len(values)))
        return tuple(values)

    def root(self, exponent: int) -> tuple[Q, ...]:
        return self.powers[exponent % self.order]

    def add(self, a: tuple[Q, ...], b: tuple[Q, ...]) -> tuple[Q, ...]:
        return tuple(x + y for x, y in zip(a, b))

    def scale(self, scalar: Q, a: tuple[Q, ...]) -> tuple[Q, ...]:
        return tuple(scalar * x for x in a)

    def multiply(self, a: tuple[Q, ...], b: tuple[Q, ...]) -> tuple[Q, ...]:
        values = [Q(0)] * (2 * self.degree - 1)
        for i, x in enumerate(a):
            if x:
                for j, y in enumerate(b):
                    if y:
                        values[i + j] += x * y
        return self.reduce(values)

    def conjugate(self, a: tuple[Q, ...]) -> tuple[Q, ...]:
        result = self.zero
        for j, coefficient in enumerate(a):
            if coefficient:
                result = self.add(result, self.scale(coefficient, self.root(-j)))
        return result

    @lru_cache(maxsize=None)
    def squared_modulus(self, a: tuple[Q, ...]) -> Q:
        value = self.multiply(a, self.conjugate(a))
        require(all(x == 0 for x in value[1:]), "Expected rational squared modulus.")
        require(value[0] >= 0, "Negative squared modulus.")
        return value[0]

    @lru_cache(maxsize=None)
    def modulus(self, a: tuple[Q, ...]) -> Q:
        squared = self.squared_modulus(a)
        numerator, denominator = isqrt(squared.numerator), isqrt(squared.denominator)
        require(numerator ** 2 == squared.numerator and
                denominator ** 2 == squared.denominator,
                "Test instance has a nonrational modulus.")
        return Q(numerator, denominator)


def rational_unit(d: int, support: tuple[int, ...]) -> tuple[Q, ...]:
    a = [Q(0)] * d
    if len(support) == 1:
        a[support[0]] = Q(1)
    else:
        parameters = [Q(j + 2) for j in support[1:]]
        total = sum(t * t for t in parameters)
        a[support[0]] = (total - 1) / (total + 1)
        for j, t in zip(support[1:], parameters):
            a[j] = 2 * t / (total + 1)
    require(sum(x * x for x in a) == 1, "Input not normalized.")
    return tuple(a)


def two_point(d: int, gap: int) -> tuple[Q, ...]:
    a = [Q(0)] * d
    a[0], a[gap] = Q(3, 5), Q(4, 5)
    return tuple(a)


def check_bell_orthogonality(d: int) -> dict:
    ring = Cyclotomic(lcm(d, 4))
    basis = {}
    for p, q in product(range(d), repeat=2):
        basis[p, q] = {((p + k) % d, k): ring.root(q * k * (ring.order // d))
                       for k in range(d)}
    checks = 0
    for label, vector in basis.items():
        for other_label, other in basis.items():
            inner = ring.zero
            for position in vector.keys() & other.keys():
                inner = ring.add(inner, ring.multiply(ring.conjugate(vector[position]),
                                                     other[position]))
            target = ring.scale(Q(d), ring.one) if label == other_label else ring.zero
            require(inner == target, "Scaled Bell basis is not orthogonal.")
            checks += 1
    return {"dimension": d, "cyclotomic_order": ring.order,
            "degree": ring.degree, "inner_products_checked": checks}


def contraction_case(name: str, inputs: tuple[tuple[Q, ...], ...]) -> dict:
    d, m = len(inputs[0]), len(inputs)
    ring = Cyclotomic(lcm(d, 4))
    # Nontrivial, deterministic Gaussian-unit phases on the input amplitudes.
    phases = tuple(tuple(((ell + 1) * j + j * j) % 4 for j in range(d))
                   for ell in range(m))
    for a in inputs:
        require(len(a) == d and sum(x * x for x in a) == 1, "Bad input state.")
    denominator = Q(d ** (m - 1))
    total_probability = Q(0)
    operational_average = Q(0)
    branches = zero_branches = vector_matches = 0
    p_labels = tuple(product(range(d), repeat=m - 1))
    q_labels = tuple(product(range(d), repeat=m - 1))

    for p in p_labels:
        # Direct tensor contraction: impose each Bell bra's delta constraint.
        terms = []
        for labels in product(range(d), repeat=m):
            if any(labels[t] != (p[t] + labels[t + 1]) % d for t in range(m - 1)):
                continue
            amplitude = prod(inputs[ell][labels[ell]] for ell in range(m))
            if not amplitude:
                continue
            input_phase = sum(phases[ell][labels[ell]] for ell in range(m))
            terms.append(((labels[0], labels[-1]), amplitude, input_phase, labels[1:]))
        for q in q_labels:
            actual = {}
            for position, amplitude, input_phase, right_labels in terms:
                exponent = input_phase * (ring.order // 4)
                exponent -= sum(q[t] * right_labels[t] for t in range(m - 1)) * (
                    ring.order // d)
                term = ring.scale(amplitude, ring.root(exponent))
                actual[position] = ring.add(actual.get(position, ring.zero), term)
            actual = {position: value for position, value in actual.items() if value != ring.zero}

            # Independently evaluate the manuscript's cumulative-shift formula.
            shifts = [0] * m
            for t in range(m - 2, -1, -1):
                shifts[t] = (p[t] + shifts[t + 1]) % d
            predicted = {}
            for k in range(d):
                labels = [(k + shifts[ell]) % d for ell in range(m)]
                amplitude = prod(inputs[ell][labels[ell]] for ell in range(m))
                if amplitude:
                    exponent = sum(phases[ell][labels[ell]] for ell in range(m)) * (
                        ring.order // 4)
                    exponent -= sum(q[t] * ((k + shifts[t + 1]) % d)
                                    for t in range(m - 1)) * (ring.order // d)
                    predicted[((k + shifts[0]) % d, k)] = ring.scale(amplitude,
                                                                 ring.root(exponent))
            require(actual == predicted, "Complex branch vector formula disagrees.")
            vector_matches += 1
            # Verify that the actual matrix is in Schmidt form up to label permutations.
            rows = {position[0] for position in actual}
            columns = {position[1] for position in actual}
            require(len(rows) == len(columns) == len(actual),
                    "Actual output is not supported on a row-column matching.")
            moduli = [ring.modulus(value) for value in actual.values()]
            squared_norm = sum((ring.squared_modulus(value) for value in actual.values()), Q(0))
            probability = squared_norm / denominator
            if squared_norm == 0:
                require(not actual, "A zero-norm branch contains a nonzero amplitude.")
                entanglement = Q(0)
                contribution = Q(0)
                zero_branches += 1
            else:
                off_diagonal = sum(moduli[j] * moduli[k]
                                   for j in range(len(moduli))
                                   for k in range(len(moduli)) if j != k)
                entanglement = off_diagonal / squared_norm
                contribution = probability * entanglement
                require(contribution == off_diagonal / denominator,
                        "Born probability failed to cancel normalization.")
            total_probability += probability
            operational_average += contribution
            branches += 1

    correlations = [[sum(a[j] * a[(j + r) % d] for j in range(d))
                     for r in range(d)] for a in inputs]
    correlation_value = sum(prod(correlations[ell][r] for ell in range(m))
                            for r in range(1, d))
    resources = [sum(a[j] * a[k] for j in range(d) for k in range(d) if j != k)
                 for a in inputs]
    resource_product = prod(resources)
    kappa = Q(1) if d % 2 == 0 else Q(1, 2 ** (m - 1))
    require(total_probability == 1, "All Bell outcome probabilities do not sum to one.")
    require(operational_average == correlation_value, "Physical and correlation averages differ.")
    require(operational_average <= kappa * resource_product, "Sharp bound failed.")
    return {
        "name": name, "dimension": d, "links": m,
        "cyclotomic_order": ring.order, "cyclotomic_degree": ring.degree,
        "input_moduli": [[qs(x) for x in a] for a in inputs],
        "input_i_phase_exponents": phases,
        "branches": branches, "zero_probability_branches": zero_branches,
        "complex_branch_vector_matches": vector_matches,
        "total_probability": qs(total_probability),
        "input_entanglements": [qs(x) for x in resources],
        "operational_average": qs(operational_average),
        "correlation_average": qs(correlation_value),
        "ratio": qs(operational_average / resource_product) if resource_product else None,
        "sharp_coefficient": qs(kappa),
    }


def run() -> dict:
    orthogonality = [check_bell_orthogonality(d) for d in range(2, 8)]
    specs = []
    for d in range(2, 8):
        gap = d // 2 if d % 2 == 0 else 1
        specs.append((f"sharp_d{d}_m2", (two_point(d, gap),) * 2))
    for d, m in ((2, 3), (3, 3), (4, 3), (5, 3), (2, 4), (3, 4)):
        gap = d // 2 if d % 2 == 0 else 1
        specs.append((f"sharp_d{d}_m{m}", (two_point(d, gap),) * m))
    specs.extend([
        ("odd_full_support_d3_m3", tuple(rational_unit(3, (0, 1, 2)) for _ in range(3))),
        ("even_full_support_d6_m3", tuple(rational_unit(6, (0, 1, 2, 3, 4, 5))
                                         for _ in range(3))),
        ("disjoint_differences_d5_m2", (two_point(5, 1), two_point(5, 2))),
        ("disjoint_differences_d4_m2", (two_point(4, 1), two_point(4, 2))),
        ("product_link_d3_m3", (two_point(3, 1), rational_unit(3, (2,)), two_point(3, 1))),
    ])
    cases = [contraction_case(name, inputs) for name, inputs in specs]
    return {
        "status": "PASS",
        "arithmetic": "Exact Fraction arithmetic in Q[zeta_lcm(d,4)]",
        "physical_route": "Input tensor basis enumeration and local Bell-bra delta contraction",
        "independence_scope": "Different computational route; same AI-assisted research project",
        "finite_scope": "These finite cases do not replace the universal proof.",
        "script_sha256": sha256(Path(__file__).read_bytes()).hexdigest(),
        "bell_orthogonality": orthogonality,
        "cases": cases,
        "totals": {
            "input_families": len(cases),
            "bell_inner_products": sum(x["inner_products_checked"] for x in orthogonality),
            "physical_branches": sum(x["branches"] for x in cases),
            "complex_vector_matches": sum(x["complex_branch_vector_matches"] for x in cases),
            "zero_probability_branches": sum(x["zero_probability_branches"] for x in cases),
            "probability_normalization_checks": len(cases),
            "operational_factorization_checks": len(cases),
        },
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] /
                        "results" / "bell_contraction_certificate.json")
    args = parser.parse_args()
    report = run()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n")
    print(json.dumps({"status": report["status"], **report["totals"]}, sort_keys=True))


if __name__ == "__main__":
    main()
