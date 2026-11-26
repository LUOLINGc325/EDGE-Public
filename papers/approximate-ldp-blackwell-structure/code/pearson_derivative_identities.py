"""Exact symbolic transcription checks for the candidate Pearson proof.

This checks only displayed polynomial identities, not the hypotheses, signs,
canonical reduction, or complete theorem. It is not a formal-proof receipt.
"""

import json
from pathlib import Path

import sympy as sp


ell, v, u, d, K, gamma = sp.symbols("ell v u d K gamma")
a, b, E = sp.symbols("a b E")
S = ell + u
V = v + u**2 - d
multiplier = S**2 + V - 2 * S
substituted_derivative = u * (
    K * S * (S**2 - V) - (K * ell + gamma * d / u) * multiplier
)
B0 = (ell**2 - v + 2 * ell) * u - 2 * ell * (v - ell)
B1 = (
    (K - 2 * gamma) * u**2
    + 2 * (K - gamma) * ell * u
    + 2 * gamma * u
    - gamma * (ell**2 + v - 2 * ell)
)
derivative_residual = sp.expand(
    substituted_derivative - (K * u * B0 + d * B1 + gamma * d**2)
)

ell_ab = a + b * E
v_ab = a + b * E**2
constant_at_boundary = (
    (ell_ab**2 - v_ab + 2 * ell_ab) * E**2
    - 2 * ell_ab * (v_ab - ell_ab)
)
constant_certificate = E * (
    a * (a + 1) * E
    + 2 * a * b * (E**2 - E + 1)
    + b * (b - 1) * E * ((E - 1) ** 2 + 1)
    + 2 * b * E
)
constant_residual = sp.expand(constant_at_boundary - constant_certificate)

result = {
    "kind": "exact_symbolic_identity_check_only",
    "derivative_expansion_residual": str(derivative_residual),
    "positive_constant_certificate_residual": str(constant_residual),
    "both_identities_zero": derivative_residual == 0 and constant_residual == 0,
    "does_not_certify": [
        "sign_hypotheses",
        "canonical_decomposition",
        "global_extremum_argument",
        "equality_classification",
        "Lean_formalization",
        "literature_priority",
    ],
}
assert result["both_identities_zero"]
output = Path(__file__).with_suffix(".results.json")
output.write_text(json.dumps(result, indent=2) + "\n")
print(json.dumps(result))
