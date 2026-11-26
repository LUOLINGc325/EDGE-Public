"""Independent operator-level checks; no proof functions imported from the project."""
from __future__ import annotations

import hashlib
import json
import math
import sys
from pathlib import Path

import numpy as np
import scipy
from scipy.sparse import csr_matrix, eye


def pauli(letters):
    """Site zero is the least significant computational-basis bit."""
    dim = 1 << len(letters)
    columns = np.arange(dim, dtype=np.int64)
    rows = columns.copy()
    values = np.ones(dim, dtype=np.complex128)
    for site, letter in enumerate(letters):
        bits = (columns >> site) & 1
        if letter in "XY":
            rows ^= 1 << site
        if letter in "ZY":
            values *= 1 - 2 * bits
        if letter == "Y":
            values *= 1j
    return csr_matrix((values, (rows, columns)), shape=(dim, dim))


def majoranas(modes):
    matrices = []
    for site in range(modes):
        for last in "XY":
            letters = ["Z"] * site + [last] + ["I"] * (modes - site - 1)
            matrices.append(pauli(letters))
    return matrices


def physical_battery(m):
    vertices = 2 * m
    edges = [(a, b) for a in range(vertices) for b in range(a + 1, vertices)]
    stars = []
    for vertex in range(vertices):
        letters = ["X" if a == vertex else "Z" if b == vertex else "I" for a, b in edges]
        stars.append(pauli(letters))
    matching = []
    for r in range(m):
        letters = ["Y" if edge == (2 * r, 2 * r + 1) else "I" for edge in edges]
        matching.append(pauli(letters))
    a = [(stars[2 * r] + stars[2 * r + 1]) / math.sqrt(2) for r in range(m)]
    r_ops = [1j * a[r] @ matching[r] for r in range(m)]
    return a, r_ops, matching


def reduced_battery(m):
    gamma = majoranas(m)
    a, r_ops = gamma[::2], gamma[1::2]
    matching = [-1j * a[r] @ r_ops[r] for r in range(m)]
    return a, r_ops, matching


def normalize(vector):
    norm = np.linalg.norm(vector)
    assert norm > 1e-10
    return vector / norm


def covariance(ops, vector):
    count = len(ops)
    out = np.zeros((count, count))
    for r in range(count):
        for s in range(r + 1, count):
            value = np.vdot(vector, 1j * (ops[r] @ (ops[s] @ vector)))
            assert abs(value.imag) < 1e-10
            out[r, s], out[s, r] = value.real, -value.real
    return out


def max_abs(matrix):
    return float(np.max(np.abs(matrix.data))) if matrix.nnz else 0.0


def one_case(m, physical, rng):
    a, r_ops, y = physical_battery(m) if physical else reduced_battery(m)
    db = a[0].shape[0]
    identity_b = eye(db, format="csr", dtype=complex)
    b = sum(a) / math.sqrt(m)
    hb = math.sqrt(2 * m) * b
    # A physical parity completion uses an even number of Majoranas.
    auxiliary_modes = (m + 2) // 2
    aux_gamma = majoranas(auxiliary_modes)
    c = [1j * aux_gamma[0] @ aux_gamma[r + 1] for r in range(m)]
    da = c[0].shape[0]
    parity = pauli(["Z"] * auxiliary_modes)
    q = m // 2
    wb = [1j * r_ops[2 * j] @ r_ops[2 * j + 1] for j in range(q)]
    wa = [1j * c[2 * j] @ c[2 * j + 1] for j in range(q)]

    algebra_errors = [max_abs(b @ b - identity_b)]
    clifford = a + r_ops
    for j, operator in enumerate(clifford):
        algebra_errors.append(max_abs(operator @ operator - identity_b))
        for other in clifford[j + 1:]:
            algebra_errors.append(max_abs(operator @ other + other @ operator))
    for operator in c:
        algebra_errors.append(max_abs(operator @ parity - parity @ operator))
    assert max(algebra_errors) < 1e-12

    def random_vector(d):
        return rng.normal(size=d) + 1j * rng.normal(size=d)

    def ground_vector():
        v = random_vector(db)
        return normalize(v - b @ v)

    def parity_vector():
        v = random_vector(da)
        return normalize(v + parity @ v)

    battery = ground_vector()
    for operator in wb:
        battery = normalize(battery - operator @ battery)
    auxiliary = parity_vector()
    for operator in wa:
        auxiliary = normalize(auxiliary + operator @ auxiliary)
    assert np.linalg.norm(b @ battery + battery) < 1e-11
    assert np.linalg.norm(parity @ auxiliary - auxiliary) < 1e-11

    gamma_b, gamma_a = covariance(r_ops, battery), covariance(c, auxiliary)
    a_m = 1 + 2 * q / m
    k_covariance = 1 - np.sum(gamma_b * gamma_a) / m

    def hc_action(matrix):
        return sum((operator @ matrix) @ aux.toarray().T for operator, aux in zip(y, c))

    initial = np.outer(battery, auxiliary)
    hc_initial = hc_action(initial)
    excited = (hc_initial + b @ hc_initial) / 2
    k_direct = float(np.vdot(excited, excited).real)
    assert abs(k_direct - a_m) < 1e-10
    assert abs(k_covariance - a_m) < 1e-10
    assert np.linalg.norm(hc_action(hc_initial) - m * initial) < 1e-10
    maximum_formula_error = 0.0
    for time in (0.0, 0.137, math.pi / (4 * math.sqrt(m)), math.pi / (2 * math.sqrt(m))):
        theta = math.sqrt(m) * time
        evolved = math.cos(theta) * initial - 1j * math.sin(theta) / math.sqrt(m) * hc_initial
        energy = float(np.vdot(evolved, hb @ evolved).real)
        power = float(-2 * np.vdot(hc_action(evolved), hb @ evolved).imag)
        expected_energy = -math.sqrt(2 * m) + 2 * math.sqrt(2 * m) * (a_m / m) * math.sin(theta) ** 2
        expected_power = 2 * math.sqrt(2) * a_m * math.sin(2 * theta)
        maximum_formula_error = max(maximum_formula_error, abs(energy - expected_energy), abs(power - expected_power))
    assert maximum_formula_error < 1e-9

    random_product_k = []
    for _ in range(12):
        bv, av = ground_vector(), parity_vector()
        gb, ga = covariance(r_ops, bv), covariance(c, av)
        assert np.linalg.norm(gb, 2) <= 1 + 1e-11
        assert np.linalg.norm(ga, 2) <= 1 + 1e-11
        actual = 1 - np.sum(gb * ga) / m
        assert actual <= a_m + 1e-10
        random_product_k.append(actual)

    # Mixed products and separable mixtures are checked by their actual ensembles,
    # without constructing exponentially larger dense density matrices.
    b_vectors = [ground_vector() for _ in range(3)]
    a_vectors = [parity_vector() for _ in range(3)]
    b_weights = (0.2, 0.3, 0.5)
    a_weights = (0.1, 0.6, 0.3)
    gb_mix = sum(weight * covariance(r_ops, vector) for weight, vector in zip(b_weights, b_vectors))
    ga_mix = sum(weight * covariance(c, vector) for weight, vector in zip(a_weights, a_vectors))
    mixed_k_cov = 1 - np.sum(gb_mix * ga_mix) / m
    mixed_k_direct = 0.0
    separable_k_direct = 0.0
    for i, bv in enumerate(b_vectors):
        for j, av in enumerate(a_vectors):
            charge = hc_action(np.outer(bv, av))
            excitation = (charge + b @ charge) / 2
            value = float(np.vdot(excitation, excitation).real)
            mixed_k_direct += b_weights[i] * a_weights[j] * value
            if i == j:
                separable_k_direct += b_weights[i] * value
    assert abs(mixed_k_direct - mixed_k_cov) < 1e-10
    assert mixed_k_direct <= a_m + 1e-10
    assert separable_k_direct <= a_m + 1e-10

    # Independent check of dynamics for an entangled, arbitrary ground-sector vector.
    joint = random_vector(db * da).reshape(db, da)
    joint = normalize(joint - b @ joint)
    joint = normalize(joint + joint @ parity.toarray().T)
    hc_joint = hc_action(joint)
    e_joint = (hc_joint + b @ hc_joint) / 2
    k_joint = float(np.vdot(e_joint, e_joint).real)
    theta = math.pi / 4
    evolved_joint = (joint - 1j * hc_joint / math.sqrt(m)) / math.sqrt(2)
    power_joint = float(-2 * np.vdot(hc_action(evolved_joint), hb @ evolved_joint).imag)
    assert abs(power_joint - 2 * math.sqrt(2) * k_joint) < 1e-9

    return {
        "m": m,
        "M": 2 * m,
        "representation": "physical_complete_graph" if physical else "faithful_reduced_clifford",
        "battery_dimension": db,
        "auxiliary_dimension": da,
        "auxiliary_parity": "+1",
        "a_m": a_m,
        "constructed_k_direct": k_direct,
        "constructed_k_covariance": float(k_covariance),
        "unscaled_peak": 2 * math.sqrt(2) * a_m,
        "charged_fraction": a_m / m,
        "maximum_algebra_entry_error": max(algebra_errors),
        "maximum_energy_power_formula_error": maximum_formula_error,
        "random_product_trials": len(random_product_k),
        "random_product_k_range": [min(random_product_k), max(random_product_k)],
        "mixed_product_k_direct": mixed_k_direct,
        "mixed_product_k_covariance": float(mixed_k_cov),
        "separable_mixture_k_direct": separable_k_direct,
        "random_joint_k": k_joint,
        "random_joint_power_formula_error": abs(power_joint - 2 * math.sqrt(2) * k_joint),
    }


def main():
    rng = np.random.default_rng(20261124)
    cases = []
    for m in range(1, 7):
        cases.append(one_case(m, False, rng))
        print("reduced", m, "passed", flush=True)
    for m in (1, 2, 3):
        cases.append(one_case(m, True, rng))
        print("physical", m, "passed", flush=True)
    report = {
        "status": "passed",
        "source_script": "code/verify_independent.py",
        "source_script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "seed": 20261124,
        "software": {"python": sys.version.split()[0], "numpy": np.__version__, "scipy": scipy.__version__},
        "scope": "Numerical operator-level audit; not an all-m proof or Lean verification",
        "source": "Mathew arXiv:2609.06104v1, equations (13), (15), (17)",
        "cases": cases,
    }
    case_root = Path(__file__).resolve().parents[1]
    path = case_root / "results" / "independent_verification.json"
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(report, indent=2) + "\n")
    print(path.relative_to(case_root))


if __name__ == "__main__":
    main()
