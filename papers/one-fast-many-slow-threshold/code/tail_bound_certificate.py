#!/usr/bin/env python3
"""Exact rational witnesses for coupling_route.md, Theorem B3.

This script certifies the arithmetic assumptions of the proved sufficient tail
bound.  It does not solve the ordered-occupancy conjecture, certify an optimal
transition location, or remove the stated fast-work-conserving restriction.

Generation:
    python code/tail_bound_certificate.py
Verification of an existing artifact without a search:
    python code/tail_bound_certificate.py --verify results/tail_bound_certificate.json

Only Python's standard library is used.  Every comparison affecting a witness
uses fractions.Fraction.  Decimal strings are previews, never proof inputs.
"""

from __future__ import annotations

import argparse
import hashlib
import json
from decimal import Decimal, localcontext
from fractions import Fraction
from pathlib import Path
from typing import Any


CASE_ROOT = Path(__file__).resolve().parents[1]
DEFAULT_OUTPUT = CASE_ROOT / "results" / "tail_bound_certificate.json"

CASES = (
    {
        "id": "one_slow_no_arrivals",
        "m": 1,
        "lambda": "0",
        "a": "2",
        "b": "1",
        "alpha": "1",
    },
    {
        "id": "three_slow_low_load",
        "m": 3,
        "lambda": "1",
        "a": "4",
        "b": "1",
        "alpha": "1",
    },
    {
        "id": "eight_slow_positive_arrivals",
        "m": 8,
        "lambda": "10",
        "a": "10",
        "b": "1",
        "alpha": "2",
    },
    {
        "id": "two_slow_small_discount",
        "m": 2,
        "lambda": "9",
        "a": "10",
        "b": "1",
        "alpha": "21/100",
    },
)


def require(condition: bool, message: str) -> None:
    """Do not rely on assertions, which python -O can disable."""
    if not condition:
        raise ValueError(message)


def ceil_fraction(value: Fraction) -> int:
    return -(-value.numerator // value.denominator)


def exact(value: Fraction) -> str:
    return str(value)


def decimal_preview(value: Fraction) -> str:
    with localcontext() as ctx:
        ctx.prec = 24
        return str(Decimal(value.numerator) / Decimal(value.denominator))


def derived(parameters: dict[str, Any]) -> dict[str, Fraction]:
    m = parameters["m"]
    require(isinstance(m, int) and not isinstance(m, bool) and m >= 1, "m >= 1")
    lam = Fraction(parameters["lambda"])
    a = Fraction(parameters["a"])
    b = Fraction(parameters["b"])
    alpha = Fraction(parameters["alpha"])
    require(lam >= 0, "lambda >= 0")
    require(a > b > 0, "a > b > 0")
    require(alpha > 0, "alpha > 0")
    gamma = lam + a + m * b
    D = alpha + gamma
    rho = gamma / D
    q = alpha / D
    p = lam / gamma
    L = Fraction(m - 1) / q + p * rho / q**2
    M = (1 + p) / q
    return {
        "Gamma": gamma,
        "D": D,
        "rho": rho,
        "q": q,
        "p": p,
        "L": L,
        "M": M,
        "b_over_2D": b / (2 * D),
        "b_over_2D_squared": b / (2 * D**2),
    }


def make_case(spec: dict[str, Any]) -> dict[str, Any]:
    parameters = {key: spec[key] for key in ("m", "lambda", "a", "b", "alpha")}
    d = derived(parameters)
    rho, q, L, M = (d[key] for key in ("rho", "q", "L", "M"))
    K_start = max(2, ceil_fraction(rho / q))
    K = K_start
    rho_power = rho**K
    error = rho_power * (L + M * K)
    threshold = d["b_over_2D"]
    while error > threshold:
        K += 1
        rho_power *= rho
        error = rho_power * (L + M * K)

    # Explicit independent exponentiation guards the incremental search result.
    require(error == rho**K * (L + M * K), "search/exponentiation mismatch")
    previous = None if K == K_start else rho ** (K - 1) * (L + M * (K - 1))
    witness = {
        "id": spec["id"],
        "parameters": parameters,
        "derived_exact": {key: exact(value) for key, value in d.items()},
        "K_scan_start": K_start,
        "K": K,
        "H": parameters["m"] + K - 1,
        "E_K_exact": exact(error),
        "E_K_decimal_preview": decimal_preview(error),
        "threshold_minus_E_K_exact": exact(threshold - error),
        "q_times_K_minus_rho_exact": exact(q * K - rho),
        "previous_admissible_E_exact": None if previous is None else exact(previous),
        "checks": {
            "parameters_satisfy_scope": True,
            "K_at_least_two": K >= 2,
            "ratio_monotonicity_condition": q * K >= rho,
            "error_at_most_b_over_2D": error <= threshold,
            "previous_admissible_integer_fails": previous is None or previous > threshold,
            "H_at_least_m_plus_one": parameters["m"] + K - 1 >= parameters["m"] + 1,
        },
    }
    return witness


def verify_case(witness: dict[str, Any]) -> None:
    """Check a supplied witness by direct exact arithmetic, with no tail search."""
    parameters = witness["parameters"]
    d = derived(parameters)
    require(
        witness["derived_exact"] == {key: exact(value) for key, value in d.items()},
        "derived rational fields differ from the parameters",
    )
    K = witness["K"]
    require(isinstance(K, int) and not isinstance(K, bool), "K is an integer")
    rho, q, L, M = (d[key] for key in ("rho", "q", "L", "M"))
    start = max(2, ceil_fraction(rho / q))
    require(witness["K_scan_start"] == start, "incorrect scan start")
    require(K >= start, "K does not satisfy the monotonicity/start condition")
    require(witness["H"] == parameters["m"] + K - 1, "incorrect H")
    error = rho**K * (L + M * K)
    threshold = d["b_over_2D"]
    require(Fraction(witness["E_K_exact"]) == error, "incorrect E_K")
    require(error <= threshold, "tail error exceeds the sufficient bound")
    require(
        Fraction(witness["threshold_minus_E_K_exact"]) == threshold - error >= 0,
        "invalid nonnegative error margin",
    )
    require(
        Fraction(witness["q_times_K_minus_rho_exact"]) == q * K - rho >= 0,
        "invalid monotonicity margin",
    )
    if K == start:
        require(witness["previous_admissible_E_exact"] is None, "unexpected previous K")
    else:
        previous = rho ** (K - 1) * (L + M * (K - 1))
        require(
            Fraction(witness["previous_admissible_E_exact"]) == previous > threshold,
            "reported K is not the first passing admissible integer",
        )
    # Above the scan start, E_(k+1)/E_k <= rho*(1+1/k) <= 1.
    # This algebraic condition, not an unbounded numerical scan, covers all n >= H.
    require(
        rho * (1 + Fraction(1, K)) <= 1,
        "geometric-linear error is not certified nonincreasing beyond K",
    )
    require(
        witness["checks"]
        == {
            "parameters_satisfy_scope": True,
            "K_at_least_two": True,
            "ratio_monotonicity_condition": True,
            "error_at_most_b_over_2D": True,
            "previous_admissible_integer_fails": True,
            "H_at_least_m_plus_one": True,
        },
        "checks are absent, false, or unexpected",
    )
    # A decimal preview is neither parsed nor used to certify an inequality.


def verify_document(document: dict[str, Any]) -> None:
    require(document["schema_version"] == 1, "unsupported schema")
    require(document["kind"] == "exact_rational_discounted_tail_bound", "wrong kind")
    require(len(document["cases"]) == 4, "expected the four declared parameter cases")
    expected_ids = [spec["id"] for spec in CASES]
    require([item["id"] for item in document["cases"]] == expected_ids, "case IDs/order")
    for supplied, specification in zip(document["cases"], CASES):
        expected_parameters = {
            key: specification[key] for key in ("m", "lambda", "a", "b", "alpha")
        }
        require(supplied["parameters"] == expected_parameters, "case parameters changed")
        verify_case(supplied)


def build_document() -> dict[str, Any]:
    document = {
        "schema_version": 1,
        "kind": "exact_rational_discounted_tail_bound",
        "theorem": "manuscript/coupling_route.md, Theorem B3",
        "generator": {
            "path": "code/tail_bound_certificate.py",
            "sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            "dependencies": "Python standard library only",
            "arithmetic": "fractions.Fraction; exact comparisons; no float decision",
        },
        "scope": {
            "model": "one fast server and m identical slow servers",
            "policy_class": "fast-work-conserving, nonpreemptive, genuine-event decisions",
            "discount": "strictly positive",
            "V": "D times enlarged-potential-event committed post-decision value",
            "physical_bridge": "U_real = QV/D; maximum minimizing selector is idempotent",
            "announced_guarantee": (
                "For every n >= H, V(n,y)-V(n,m) >= b/(2D) for y < m. "
                "At a genuine decision, any subfull first dispatch in the specified "
                "class has physical action cost at least b/(2D^2) above full dispatch."
            ),
            "unproved_here": [
                "losslessness of the fast-work-conserving restriction for arbitrary m",
                "ordered optimal slow occupancy below H",
                "average-cost passage as discount tends to zero",
            ],
            "not_claimed": [
                "H is an optimal-policy transition location",
                "V/D equals every physical committed post-decision value",
                "an arbitrary finite-buffer numerical truncation is exact",
            ],
        },
        "certificate_rule": {
            "K_start": "max(2, ceil(rho/q))",
            "K_condition": "rho^K * (L + M*K) <= b/(2D)",
            "H": "m + K - 1",
            "all_later_levels": (
                "k=n-m+1 >= K; E_(k+1)/E_k <= rho*(1+1/k) <= 1; "
                "E(n,k)=rho^k*(L+M*k)"
            ),
        },
        "cases": [make_case(spec) for spec in CASES],
    }
    verify_document(document)
    return document


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=DEFAULT_OUTPUT)
    parser.add_argument("--verify", type=Path, help="check an existing JSON without rewriting")
    args = parser.parse_args()
    if args.verify is not None:
        document = json.loads(args.verify.read_text(encoding="utf-8"))
        verify_document(document)
        verb = "verified"
    else:
        document = build_document()
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(
            json.dumps(document, ensure_ascii=False, indent=2) + "\n",
            encoding="utf-8",
        )
        verb = "generated and verified"
    for case in document["cases"]:
        print(
            f"{verb}: {case['id']}: K={case['K']}, H={case['H']}, "
            f"E_K≈{case['E_K_decimal_preview']} <= "
            f"{case['derived_exact']['b_over_2D']}"
        )


if __name__ == "__main__":
    main()
