#!/usr/bin/env python3
"""Exact axial-mode certificate and symbolic path word compiler."""

import argparse
from fractions import Fraction
import json
from math import comb


def legendre_value_sequence(degree, x):
    values = [Fraction(1)]
    if degree:
        values.append(x)
    for j in range(1, degree):
        values.append(((2 * j + 1) * x * values[-1] - j * values[-2]) / (j + 1))
    return values


def variations_at(degree, x):
    nonzero = [value > 0 for value in legendre_value_sequence(degree, x) if value]
    return sum(a != b for a, b in zip(nonzero, nonzero[1:]))


def isolate_largest_positive_root(degree):
    lower, upper = Fraction(0), Fraction(1)
    steps = 0
    while steps < 35 or lower == 0 or upper == 1 or variations_at(degree, lower) != 1:
        steps += 1
        middle = (lower + upper) / 2
        if variations_at(degree, middle):
            lower = middle
        else:
            upper = middle
    assert variations_at(degree, lower) == 1
    assert variations_at(degree, upper) == 0
    assert 0 < lower < upper < 1
    return [str(lower), str(upper)]


def exact_zonal_polynomial(degree):
    return [
        Fraction(
            (-1)**((degree - j) // 2)
            * comb(degree, (degree - j) // 2)
            * comb(degree + j, degree),
            2**degree,
        )
        if (degree - j) % 2 == 0 else Fraction(0)
        for j in range(degree + 1)
    ]


def via_spin_matrix_element(degree):
    # Coefficient of z^degree w^degree under a planar SU(2) rotation
    # on the homogeneous-polynomial model of spin degree.
    coefficients = [0] * (degree + 1)
    for flips in range(degree + 1):
        scale = (-1)**flips * comb(degree, flips)**2
        for positive in range(degree - flips + 1):
            for negative in range(flips + 1):
                coefficients[positive + negative] += (
                    scale * comb(degree - flips, positive)
                    * comb(flips, negative) * (-1)**negative
                )
    return [Fraction(value, 2**degree) for value in coefficients]


def v2(value):
    return (value & -value).bit_length() - 1


def word(t):
    turns = t.bit_length() - 1
    axis = ["0", "0"]
    for j in range(1, turns + 1):
        axis.extend((f"pi/{2**(j+1)}", "0"))
    angles = axis.copy()
    descriptors = {}
    for degree in range(2, t + 1, 2):
        parameter = f"x_{degree}"
        angles.extend(("0", f"acos({parameter})"))
        angles.extend(axis)
        descriptors[parameter] = {
            "polynomial_ascending": list(map(str, exact_zonal_polynomial(degree))),
            "root": "largest positive",
            "dyadic_root_bracket": isolate_largest_positive_root(degree),
        }
    r = t // 2
    assert len(angles) == 2 * (r + 1) * (turns + 1) + 2 * r
    return {
        "t": t,
        "input": 0,
        "output": len(angles),
        "path_edges": [[index, index + 1] for index in range(len(angles))],
        "measurement_angles_in_path_order": angles,
        "root_parameters": descriptors,
        "basis": "(|0> + (-1)^s exp(-i*phi)|1>)/sqrt(2)",
    }


def certificate():
    for degree in range(33):
        assert exact_zonal_polynomial(degree) == via_spin_matrix_element(degree)
    records = []
    for t in (1, 2, 3, 4, 5, 7, 8, 16, 31, 32, 33, 64, 65):
        k = t.bit_length() - 1
        for m in range(2, t + 1, 2):
            j = v2(m)
            assert 1 <= j <= k
            assert Fraction(m, 2**(j + 1)).denominator == 2
        path = word(t)
        records.append({
            "t": t,
            "even_nonzero_weights_annihilated": t // 2,
            "certified_root_brackets": len(path["root_parameters"]),
            "measurements": path["output"],
        })
    return {
        "method": "exact dyadic frequency indices, binomial polynomials, and Legendre Sturm sequence",
        "spin_coefficients_compared": 33,
        "orders": records,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--word", type=int, help="compile the exact symbolic measurement path")
    args = parser.parse_args()
    if args.word is not None and args.word < 1:
        parser.error("design order must be positive")
    print(json.dumps(certificate() if args.word is None else word(args.word), indent=2))


if __name__ == "__main__":
    main()
