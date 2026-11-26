#!/usr/bin/env python3
"""Exact rational certificate for the bump in the honest-band lower bound.

Uses only Python's standard library. No sampled numerical evidence is used.
The certificate covers polynomial identities, endpoint matching, exact integrals,
and conservative uniform bounds. It does not certify the statistical theorem.
"""
from __future__ import annotations

from fractions import Fraction as F
from math import comb
from pathlib import Path
import argparse
import json

Poly = tuple[F, ...]


def trim(p) -> Poly:
    p = [F(x) for x in p]
    while len(p) > 1 and p[-1] == 0:
        p.pop()
    return tuple(p)


def add(p: Poly, q: Poly) -> Poly:
    return trim([(p[i] if i < len(p) else F(0)) +
                 (q[i] if i < len(q) else F(0))
                 for i in range(max(len(p), len(q)))])


def scale(p: Poly, a: F) -> Poly:
    return trim([a * x for x in p])


def mul(p: Poly, q: Poly) -> Poly:
    out = [F(0)] * (len(p) + len(q) - 1)
    for i, x in enumerate(p):
        for j, y in enumerate(q):
            out[i + j] += x * y
    return trim(out)


def power(p: Poly, n: int) -> Poly:
    out = (F(1),)
    for _ in range(n):
        out = mul(out, p)
    return out


def evaluate(p: Poly, x: F) -> F:
    out = F(0)
    for a in reversed(p):
        out = out * x + a
    return out


def derivative(p: Poly) -> Poly:
    return trim([i * p[i] for i in range(1, len(p))] or [F(0)])


def primitive(p: Poly) -> Poly:
    return (F(0),) + tuple(a / (i + 1) for i, a in enumerate(p))


def integrate(p: Poly, a: F, b: F) -> F:
    q = primitive(p)
    return evaluate(q, b) - evaluate(q, a)


def compose_affine(p: Poly, a: F, b: F) -> Poly:
    """Return p(a + (b-a) z) in the power basis."""
    out = (F(0),)
    affine = (a, b - a)
    for i, c in enumerate(p):
        out = add(out, scale(power(affine, i), c))
    return out


def bernstein(p: Poly, degree: int) -> tuple[F, ...]:
    assert degree >= len(p) - 1
    bs = tuple(sum((p[i] * F(comb(k, i), comb(degree, i))
                    for i in range(min(k, len(p) - 1) + 1)), F(0))
               for k in range(degree + 1))
    # Independently reconstruct the polynomial from the claimed coefficients.
    recon = (F(0),)
    z, one_minus_z = (F(0), F(1)), (F(1), F(-1))
    for k, c in enumerate(bs):
        basis = mul(power(z, k), power(one_minus_z, degree - k))
        recon = add(recon, scale(basis, c * comb(degree, k)))
    assert recon == trim(p)
    return bs


def nonnegative_certificate(p: Poly, a: F, b: F, degree: int) -> dict:
    """Nonnegative Bernstein coefficients certify p >= 0 on [a,b]."""
    assert a < b
    q = compose_affine(p, a, b)
    bs = bernstein(q, degree)
    assert min(bs) >= 0
    return {
        "interval": [str(a), str(b)],
        "degree": degree,
        "minimum_bernstein_coefficient": str(min(bs)),
        "bernstein_coefficients": [str(v) for v in bs],
        "power_basis_reconstructed_exactly": True,
    }


def build_certificate() -> dict:
    one, u = (F(1),), (F(0), F(1))
    p = mul(power((F(1), F(0), F(-4)), 3),
            (F(1), F(0), F(-36)))
    expected = trim([1, 0, -48, 0, 480, 0, -1792, 0, 2304])
    assert p == expected
    d1, d2 = derivative(p), derivative(derivative(p))
    d1_factored = scale(mul(mul(u, power((F(1), F(0), F(-4)), 2)),
                           (F(-1), F(0), F(12))), F(96))
    d2_factored = scale(mul((F(-1), F(0), F(4)),
                           (F(1), F(0), F(-56), F(0), F(336))), F(96))
    assert d1 == d1_factored
    assert d2 == d2_factored
    endpoint_data = {}
    for endpoint in (F(-1, 2), F(1, 2)):
        vals = [evaluate(q, endpoint) for q in (p, d1, d2)]
        assert vals == [F(0), F(0), F(0)]
        endpoint_data[str(endpoint)] = [str(v) for v in vals]
    assert evaluate(p, F(0)) == 1
    assert integrate(p, F(-1, 2), F(1, 2)) == 0
    square_mass = integrate(mul(p, p), F(-1, 2), F(1, 2))
    assert square_mass == F(65536, 255255)
    assert derivative(primitive(p)) == p
    assert derivative(primitive(mul(p, p))) == mul(p, p)

    # p(u) = q(4u^2), where q(z) = (1-z)^3 (1-9z).
    q = mul(power((F(1), F(-1)), 3), (F(1), F(-9)))
    recon = (F(0),)
    for i, c in enumerate(q):
        recon = add(recon, scale(power((F(0), F(0), F(4)), i), c))
    assert recon == p
    bounds = {
        "psi_le_1_via_z_equals_4u2":
            nonnegative_certificate(add(one, scale(q, F(-1))), F(0), F(1), 4),
        "psi_ge_minus_1_via_z_equals_4u2":
            nonnegative_certificate(add(one, q), F(0), F(1), 16),
        "abs_first_derivative_le_96":
            nonnegative_certificate(add((F(96**2),), scale(mul(d1, d1), F(-1))),
                                    F(-1, 2), F(1, 2), 28),
        "abs_second_derivative_le_3456":
            nonnegative_certificate(add((F(3456**2),), scale(mul(d2, d2), F(-1))),
                                    F(-1, 2), F(1, 2), 24),
    }
    return {
        "status": "passed",
        "arithmetic": "fractions.Fraction only; exact rational arithmetic",
        "scope": "Polynomial bump algebra and conservative bounds only; no statistical or full Lean theorem claim.",
        "polynomial_coefficients_ascending": [str(x) for x in p],
        "first_derivative_factorization_checked": True,
        "second_derivative_factorization_checked": True,
        "endpoint_value_first_second_derivative": endpoint_data,
        "center_value": "1",
        "integral_minus_half_to_half": "0",
        "squared_integral_minus_half_to_half": str(square_mass),
        "primitive_coefficients_ascending": [str(x) for x in primitive(p)],
        "square_primitive_coefficients_ascending": [str(x) for x in primitive(mul(p, p))],
        "derivatives_of_both_primitives_checked": True,
        "uniform_bound_certificates": bounds,
        "continuum_justification": (
            "Every listed polynomial is reconstructed exactly from its Bernstein expansion. "
            "On [0,1] each Bernstein basis polynomial is nonnegative; nonnegative coefficients "
            "therefore certify the inequality on the entire interval, not just at sampled points. "
            "Endpoint values of the first two derivatives certify C^2 matching to zero outside "
            "[-1/2,1/2]. The primitive identities and endpoint differences give the integrals."
        ),
    }


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results" / "exact_bump_certificate.json")
    args = parser.parse_args()
    certificate = build_certificate()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(certificate, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"status": certificate["status"], "output": str(args.output),
                      "zero_mass": certificate["integral_minus_half_to_half"],
                      "square_mass": certificate["squared_integral_minus_half_to_half"]}))


if __name__ == "__main__":
    main()

