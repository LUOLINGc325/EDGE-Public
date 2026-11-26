#!/usr/bin/env python3
"""Reproduce exact certificates for AC line congestion geometry.

Run: python cases/ac-line-congestion-geometry/code/verify_exact.py
Requires Python 3 and SymPy. No floating-point arithmetic enters an assertion.

Convention throughout: C = diag(q)L + Ldiag(q), B = C[free, free].
Consequently K(D) = A(B + A.T D A)^(-1)A.T. Some preliminary audit
notes used C/2; this script does NOT use that preliminary convention.

These are independently reconstructed symbolic and rational certificates,
not Lean code or a replacement for the manuscript's analytical proof.
"""

import hashlib
import json
import platform
from pathlib import Path

import sympy as s


R = s.Rational
CERTIFICATES = {}


def zero(expression):
    """Exact rational-function identity, scalar or matrix."""
    if isinstance(expression, s.MatrixBase):
        assert expression.applyfunc(s.cancel) == s.zeros(*expression.shape)
    else:
        assert s.cancel(expression) == 0


def network(resistances, voltages):
    conductances = [1 / s.sympify(r) for r in resistances]
    n = len(conductances)
    L = s.zeros(n)
    for i, g in enumerate(conductances):
        L[i, i] += g
        if i:
            L[i - 1, i - 1] += g
            L[i - 1, i] -= g
            L[i, i - 1] -= g
    V = s.Matrix(voltages)
    b = s.Matrix([conductances[0]] + [0] * (n - 1))
    tau = (b - L * V).applyfunc(s.cancel)
    lam = s.diag(*V) * tau
    J = s.diag(*tau) - s.diag(*V) * L
    return L, V, b, tau, lam, J


def supporting_matrix(L, q):
    return s.diag(*q) * L + L * s.diag(*q)


def kernel(A, B, diagonal):
    M = B + A.T * s.diag(*diagonal) * A
    return (A * M.inv() * A.T).applyfunc(s.factor)


def check_three_load_rational():
    L, V, b, tau, lam, J = network(
        [R(1, 4), R(1, 4), R(5, 2)],
        [R(3, 5), R(7, 12), R(13, 25)],
    )
    q = s.Matrix([R(390, 2129), R(546, 2129), 1])
    C = supporting_matrix(L, q)
    A, B = J[:, :2], C[:2, :2]
    assert tau == s.Matrix([R(23, 15), R(31, 750), R(19, 750)])
    assert lam == s.Matrix([R(23, 25), R(217, 9000), R(247, 18750)])
    assert J.T * q == s.Matrix([0, 0, -R(196123, 1596750)])
    minors = [s.factor(C[:i, :i].det()) for i in (1, 2, 3)]
    assert minors == [R(6240, 2129), R(15964416, 4532641), R(100232086656, 48249963445)]
    assert all(x > 0 for x in minors)
    alpha = [R(1, 2), R(1, 100), R(1, 2)]
    K = kernel(A, B, [alpha[i] * q[i] / lam[i] for i in range(3)])
    derivative = s.factor(alpha[0] * q[0] * K[2, 0])
    assert derivative == R(1709054997, 1920098879500) > 0
    zero(K * q)
    # General middle-exponent identity also checks the sign boundary.
    a = s.symbols("middle_exponent", positive=True)
    Ka = kernel(A, B, [q[0] / lam[0], a * q[1] / lam[1], q[2] / lam[2]])
    exact_K13 = R(930373, 25) * (2046 - 104321 * a) / (89165968723 * a + 6469765100)
    zero(Ka[0, 2] - exact_K13)
    CERTIFICATES["three_load_finite_at_zero"] = {
        "voltages": [str(x) for x in V],
        "loads": [str(x) for x in lam],
        "alpha": [str(x) for x in alpha],
        "C_leading_principal_minors": [str(x) for x in minors],
        "terminal_normal": str((J.T * q)[2]),
        "dp3_dz1": str(derivative),
        "middle_exponent_K13_identity": str(exact_K13),
        "all_utilities_finite_at_zero": True,
    }


def check_three_load_classification():
    sv, tv, uv, g1, g2, g3 = s.symbols("s t u R B G", positive=True)
    a = (1 - 2 * sv) * g1 + (tv - 2 * sv) * g2
    b, c = sv * g2, tv * g2
    d = (sv - 2 * tv) * g2 + (uv - 2 * tv) * g3
    e = uv * g3
    A = s.Matrix([[a, b], [c, d], [0, e]])
    q2 = -a / c  # q1=1; terminal normalization changes only positive scale.
    B = s.Matrix([[2 * (g1 + g2), -g2 * (1 + q2)],
                  [-g2 * (1 + q2), 2 * q2 * (g2 + g3)]])
    N = A * B.adjugate() * A.T
    p12 = (
        2 * g2**3 * (sv - tv)**2 * (2 * sv + tv)
        + g2**2 * g3 * (4 * sv * uv * (sv - tv) + 2 * tv**3)
        + 2 * g2**2 * g1 * (sv**3 - 3 * sv * (1 - sv) * (sv - tv) + (sv - tv)**2)
        + g2 * g3 * g1 * (uv * (8 * sv**2 - 4 * sv * tv - 4 * sv + tv) + 2 * tv**2)
        + g2 * g1**2 * sv * (2 * sv - 1)**2
        + g3 * g1**2 * uv * (2 * sv - 1)**2
    )
    zero(-tv * N[0, 1] - p12)
    x, y, z, h, k = s.symbols("x y z h k", nonnegative=True)
    shifted = s.Poly(s.expand(p12.subs({g1: 1, g2: h, g3: k,
                                       uv: R(1, 2) + x,
                                       tv: R(1, 2) + x + y,
                                       sv: R(1, 2) + x + y + z})), x, y, z, h, k)
    assert len(shifted.terms()) == 84
    assert min(shifted.coeffs()) == R(1, 4)
    assert all(coefficient > 0 for coefficient in shifted.coeffs())
    # The remote-pair bound is a one-line positive-gap identity.
    ratio = g1 / g2
    p13 = tv * (ratio + tv) - (ratio * (1 - 2 * sv) + tv - 2 * sv)**2
    zero(N[0, 2] / e - g2**2 * p13 / tv)
    endpoint = ratio * (sv * (3 - 4 * sv) - ratio * (2 * sv - 1)**2)
    zero(endpoint - p13 - (sv - tv) * (ratio * (4 * sv - 1) + 4 * sv))
    # The adjacent-pair bound has a strictly positive current slack.
    tau1 = g1 * (1 - sv) - g2 * (sv - tv)
    expression23 = g1 * g2 * (3 - 4 * tv) - 2 * (2 * tv - uv) * g3 * (g1 + g2) - 4 * g2 * tau1
    zero(N[1, 2] / e - expression23)
    # Curvature terms: use independent generic rows and a generic 2x2 B.
    aa, bb, cc, dd, ee, b11, b12, b22, D1, D2, D3 = s.symbols("a b c d e b11 b12 b22 D1 D2 D3")
    Ag = s.Matrix([[aa, bb], [cc, dd], [0, ee]])
    Bg = s.Matrix([[b11, b12], [b12, b22]])
    Mg = Bg + Ag.T * s.diag(D1, D2, D3) * Ag
    Ng = Ag * Bg.adjugate() * Ag.T
    difference = Ag * Mg.adjugate() * Ag.T - Ng
    delta = aa * dd - bb * cc
    zero(difference[0, 1] - D3 * ee**2 * aa * cc)
    zero(difference[0, 2] + D2 * ee * cc * delta)
    zero(difference[1, 2] - D1 * ee * aa * delta)
    # Sharpness family for any fixed 1/2<v<3/4.
    eps, floor = s.symbols("epsilon v", positive=True)
    family_p13 = p13.subs({sv: floor + 2 * eps**2, tv: floor + eps**2,
                           g1: 1, g2: 1 / eps})
    sharp_limit = s.limit(family_p13 / eps, eps, 0, dir="+")
    zero(sharp_limit - floor * (3 - 4 * floor))
    CERTIFICATES["three_load_three_quarters"] = {
        "B12_positive_expansion_monomials": len(shifted.terms()),
        "B12_minimum_positive_coefficient": str(min(shifted.coeffs())),
        "B13_positive_gap_identity_verified": True,
        "B23_current_slack_identity_verified": True,
        "three_generic_curvature_numerators_verified": True,
        "sharp_family_P13_over_epsilon_limit": str(s.factor(sharp_limit)),
        "scope": "regular face with only terminal lower voltage active and slack caps",
    }


def check_geometry_identities():
    # General path identities underlying positive q and positive definite C.
    g = s.symbols("g1:5", positive=True)
    v = s.symbols("V1:5", positive=True)
    q = s.Matrix(s.symbols("q1:5", positive=True))
    L, V, b, tau, lam, J = network([1 / x for x in g], v)
    C = supporting_matrix(L, q)
    zero((-J) * (s.ones(4, 1) - V) - s.diag(*(2 * V - s.ones(4, 1))) * tau)
    zero(C * V - s.diag(*q) * b + J.T * q)
    # A general symmetric four-by-four kernel checks the rank-one update
    # without an inverse, a numerical tolerance, or nonsingularity of K.
    entries = s.symbols("k11 k12 k13 k14 k22 k23 k24 k33 k34 k44")
    k11, k12, k13, k14, k22, k23, k24, k33, k34, k44 = entries
    K = s.Matrix([[k11, k12, k13, k14], [k12, k22, k23, k24],
                  [k13, k23, k33, k34], [k14, k24, k34, k44]])
    d = s.symbols("d", nonnegative=True)
    ell = 1
    E = s.zeros(4)
    E[ell, ell] = 1
    updated = K - d * K[:, ell] * K[ell, :] / (1 + d * K[ell, ell])
    zero(updated * (s.eye(4) + d * E * K) - K)
    zero(updated - updated.T)
    # The energy identity for a symmetric Z-matrix proves positive
    # definiteness after its displayed nonnegative row sums are supplied.
    X = s.Matrix(s.symbols("x1:5"))
    S = s.diag(*V) * C * s.diag(*V)
    row_sums = S * s.ones(4, 1)
    energy = sum(row_sums[i] * X[i]**2 for i in range(4))
    energy += sum(-S[i, j] * (X[i] - X[j])**2 for i in range(4) for j in range(i + 1, 4))
    zero((X.T * S * X)[0] - energy)
    # Arbitrary positive curvature is realizable even with finite utility
    # at zero; the integral of this marginal utility defines u.
    p, pstar, weight, population, curvature, exponent = s.symbols(
        "p pstar weight population curvature exponent", positive=True)
    decay = population * curvature / weight - exponent / pstar
    marginal = weight * (pstar / p)**exponent * s.exp(-decay * (p - pstar))
    zero(marginal.subs(p, pstar) - weight)
    zero(-s.diff(marginal, p).subs(p, pstar) / population - curvature)
    # If exponent=zd*pstar/(2q), decay=zd/(2q)>0. If exponent=1/2,
    # zd*pstar/q>=1, and writing that ratio as 1+w gives decay>0.
    zero(decay.subs(exponent, population * curvature * pstar / (2 * weight))
         - population * curvature / (2 * weight))
    w = s.symbols("nonnegative_slack", nonnegative=True)
    zero(decay.subs({exponent: R(1, 2), curvature: weight * (1 + w) / (population * pstar)})
         - (R(1, 2) + w) / pstar)
    CERTIFICATES["general_geometry"] = {
        "M_positive_vector_identity": "(-J)(1-V)=(2V-1)*tau",
        "C_positive_vector_identity": "CV=diag(q)b-J^Tq",
        "rank_one_update": "K_new=K-d*K[:,ell]*K[ell,:]/(1+d*K[ell,ell])",
        "rank_one_identity_checked_without_inverting_K": True,
        "symmetric_Z_matrix_energy_identity_verified": True,
        "arbitrary_curvature_realization": "u'(p)=q*(pstar/p)^a*exp(-b*(p-pstar)), a=min(1/2,z*d*pstar/(2*q)), b=z*d/q-a/pstar",
        "arbitrary_curvature_marginal_and_second_derivative_identities_verified": True,
        "arbitrary_curvature_endpoint_argument": "0<a<=1/2 makes the marginal integrable at zero; both branches have b>0, so u is strictly increasing, strictly concave and Inada",
        "analytical_positivity_conditions": "1/2<V<1, tau>0, J^Tq=-mu*e_n, mu>0, connected path",
        "analytical_argument": "positive-vector minimum principle gives q>0; connected weighted energy and positive endpoint row sums give C positive definite",
    }


def check_four_load_family():
    eps, floor = s.symbols("epsilon v", positive=True)
    L, V, b, tau, lam, J = network(
        [1, eps, eps, eps],
        [floor + 6 * eps**2, floor + 3 * eps**2, floor + eps**2, floor],
    )
    assert tau == s.Matrix([1 - floor - 3 * eps - 6 * eps**2, eps, eps, eps])
    q = [s.Integer(1)]
    for j in range(3):
        q.append(s.factor(-sum(J[i, j] * q[i] for i in range(j + 1)) / J[j + 1, j]))
    q = s.Matrix(q)
    A = J[:, :3]
    zero(A.T * q)
    C = supporting_matrix(L, q)
    B = C[:3, :3]
    mu = s.factor(-(J.T * q)[3])
    zero(C * V - b - mu * s.eye(4)[:, 3])
    P = (4 * floor**2 + 2 * floor + (32 * floor**2 - 22 * floor) * eps
         + (24 * floor**2 + 50 * floor + 5) * eps**2
         + (288 * floor - 48) * eps**3 + (192 * floor + 60) * eps**4
         + 432 * eps**5 + 288 * eps**6)
    # Scaling reduces denominators and exposes the coefficient of epsilon.
    U, T = eps * A, eps * B
    cofactor = (U[1, :] * T.adjugate() * U[3, :].T)[0]
    expected = eps**2 * floor * P / ((floor + eps**2) * (floor + 3 * eps**2))
    zero(cofactor - expected)
    T0 = 2 * s.Matrix([[1, -1, 0], [-1, 2, -1], [0, -1, 2]])
    zero(T.applyfunc(lambda value: s.limit(value, eps, 0, dir="+")) - T0)
    assert T0.det() == 8
    limit = s.simplify(s.limit(expected / eps**2, eps, 0, dir="+") / 8)
    assert limit == floor / 2 + R(1, 4)
    assert all(s.limit(qi, eps, 0, dir="+") == 1 for qi in q)
    w = s.symbols("w", nonnegative=True)
    shifted_coefficients = [s.expand(P.coeff(eps, i).subs(floor, w + R(1, 2))) for i in range(7)]
    assert all(c >= 0 for c in s.Poly(shifted_coefficients[0] - 2, w).all_coeffs())
    assert all(c >= 0 for c in s.Poly(shifted_coefficients[1] + 3, w).all_coeffs())
    for coefficient in shifted_coefficients[2:]:
        assert all(c > 0 for c in s.Poly(coefficient, w).all_coeffs())
    # One rational example tests the admissible common-exponent realization,
    # not merely the excluded linear-utility limit.
    sample = {floor: R(999, 1000), eps: R(1, 10000)}
    Vn, ln, qn, Cn, An = [X.subs(sample) for X in (V, lam, q, C, A)]
    alpha = sample[eps]**5
    assert 0 < alpha < 1
    assert all(sample[floor] <= x < 1 for x in Vn)
    assert all(0 < x < 2 for x in ln)
    assert all(x > 0 for x in qn) and mu.subs(sample) > 0
    cminors = [s.factor(Cn[:i, :i].det()) for i in range(1, 5)]
    assert all(x > 0 for x in cminors)
    Dn = [alpha * qn[i] / ln[i] for i in range(4)]
    K = kernel(An, Cn[:3, :3], Dn)
    slope = s.factor(alpha * qn[1] * K[3, 1])
    assert slope > 0
    zero(K * qn)
    # A quantitative common-alpha bound, valid at any positive K0_ij.
    K0n = kernel(An, Cn[:3, :3], [0] * 4)
    k, trace, ratio = K0n[1, 3], s.trace(K0n), max(qn[i] / ln[i] for i in range(4))
    assert k > 0 and trace > 0 and ratio > 0
    safe_alpha = min(R(1, 2), k / (4 * ratio * trace**2))
    assert 0 < safe_alpha < 1
    assert safe_alpha * ratio * trace**2 <= k / 4
    safe_K = kernel(An, Cn[:3, :3], [safe_alpha * qn[i] / ln[i] for i in range(4)])
    assert safe_K[1, 3] > 0
    CERTIFICATES["four_load_arbitrary_high_voltage"] = {
        "tau": [str(x) for x in tau],
        "q_normalization": "q1=1; changing to q4=1 multiplies K by the old q4 and preserves the limit",
        "P": str(P),
        "scaled_cofactor_identity": str(expected),
        "scaled_C_free_determinant_limit": 8,
        "K0_24_over_epsilon_limit": str(limit),
        "P_positive_certificate": "P>2-3*epsilon>0 for 1/2<v<1 and 0<epsilon<=(1-v)/6",
        "common_alpha_asymptotic": "alpha=epsilon^5; max D_i=O(epsilon^4); ||K(D)-K0||=O(epsilon^2)",
        "common_alpha_quantitative_choice": "min(1/2, K0_ij/(4*max(q/lambda)*tr(K0)^2))",
        "exact_rational_sample": {
            "v": str(sample[floor]), "epsilon": str(sample[eps]),
            "common_alpha": str(alpha),
            "all_C_leading_principal_minors_positive": True,
            "normal_positive_terminal_multiplier_positive": True,
            "K24_decimal_for_readability_only": str(s.N(K[1, 3], 20)),
            "dp4_dz2_decimal_for_readability_only": str(s.N(slope, 20)),
            "dp4_dz2_exact": str(slope),
            "dp4_dz2_exact_sign": "strictly positive",
            "safe_common_alpha_exact": str(safe_alpha),
            "safe_common_alpha_K24_exact_sign": "strictly positive",
        },
    }


def main():
    check_three_load_rational()
    check_three_load_classification()
    check_geometry_identities()
    check_four_load_family()
    result = {
        "passed": True,
        "scope": "exact algebraic certificates with one rational high-voltage positive-curvature witness; no numerical optimizer, no random sampling, no Lean",
        "convention": "C=diag(q)L+Ldiag(q), B=C_free, K(D)=A(B+A^T D A)^(-1)A^T",
        "runtime": {"python": platform.python_version(), "sympy": s.__version__},
        "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "certificates": CERTIFICATES,
    }
    destination = Path(__file__).resolve().parents[1] / "results" / "exact_certificate.json"
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(json.dumps(result, ensure_ascii=False, indent=2) + "\n")
    print(json.dumps({"passed": True, "output": str(destination),
                      "certificate_groups": list(CERTIFICATES),
                      "script_sha256": result["script_sha256"]}, indent=2))


if __name__ == "__main__":
    main()
