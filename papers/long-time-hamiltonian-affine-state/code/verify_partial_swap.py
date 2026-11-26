#!/usr/bin/env python3
"""Independent full-state and exact symbolic checks for the main partial-SWAP channel.

The checks cover n=1,2 only. They verify the implemented gate sequence, output
partial trace, centering, and finite-mixture readout. They do not certify the
general theorem or replace its analytic proof.
"""
from __future__ import annotations

import itertools
import math
import numpy as np
from scipy.linalg import expm
import sympy as sp

SEED = 202611241139
TOL = 2e-10
HAD = np.array([[1, 1], [1, -1]], complex) / math.sqrt(2)
PAULI = [
    np.eye(2, dtype=complex),
    np.array([[0, 1], [1, 0]], complex),
    np.array([[0, -1j], [1j, 0]], complex),
    np.diag([1.0, -1.0]).astype(complex),
]
BASES = [np.linalg.eigh(p)[1] for p in PAULI[1:]]


def check(condition, message):
    if not condition:
        raise RuntimeError(message)


def tensor(matrices):
    result = np.array([[1]], complex)
    for matrix in matrices:
        result = np.kron(result, matrix)
    return result


def controlled_full_swap(vector, choi_dimension):
    result = vector.reshape(2, choi_dimension, choi_dimension).copy()
    result[1] = result[1].T
    return result.reshape(2, -1)


def partial_swap_circuit(x, y, sign):
    """Two known controlled-full-SWAPs, with an uncomputed ancilla."""
    c = len(x)
    vector = np.zeros((2, c * c), complex)
    vector[0] = np.kron(x, y)
    vector = HAD @ vector
    vector = controlled_full_swap(vector, c)
    vector = HAD @ vector
    phase = np.diag(
        [np.exp(1j * sign * math.pi / 4), np.exp(-1j * sign * math.pi / 4)]
    )
    vector = phase @ vector
    vector = HAD @ vector
    vector = controlled_full_swap(vector, c)
    return HAD @ vector


def output_state(hamiltonian, baseline, shift, sign):
    d = len(hamiltonian)
    u0 = expm(-1j * baseline * hamiltonian)
    u1 = expm(-1j * (baseline + shift) * hamiltonian)
    x, y = u0.reshape(-1) / math.sqrt(d), u1.reshape(-1) / math.sqrt(d)
    full = partial_swap_circuit(x, y, sign)
    retained = full[0].reshape(d, -1)
    return retained @ retained.conj().T, full, x, y


def pauli_readout_moments(state, n, scale):
    """Enumerate actual Born probabilities for all random local-Pauli settings."""
    d = 2**n
    labels = list(itertools.product(range(4), repeat=n))[1:]
    first = np.zeros(len(labels))
    second = np.zeros(len(labels))
    normalization = 0.0
    for bases in itertools.product(range(3), repeat=n):
        basis = tensor([BASES[b] for b in bases])
        for outcome in range(d):
            eigenvalues = [
                -1 if ((outcome >> (n - 1 - i)) & 1) == 0 else 1
                for i in range(n)
            ]
            vector = basis[:, outcome]
            probability = float(np.vdot(vector, state @ vector).real) / (3**n)
            normalization += probability
            for index, label in enumerate(labels):
                support = [i for i, p in enumerate(label) if p]
                if all(bases[i] + 1 == label[i] for i in support):
                    score = (
                        scale * (3 ** len(support))
                        * math.prod(eigenvalues[i] for i in support)
                    )
                    first[index] += probability * score
                    second[index] += probability * score**2
    expected = np.array(
        [
            scale * np.trace(tensor([PAULI[p] for p in label]) @ state).real
            for label in labels
        ]
    )
    expected_second = np.array(
        [scale**2 * 3 ** sum(p != 0 for p in label) for label in labels]
    )
    return {
        "coordinates": len(labels),
        "normalization_error": abs(normalization - 1),
        "first_moment_error": float(np.max(np.abs(first - expected))),
        "second_moment_error": float(np.max(np.abs(second - expected_second))),
    }


def verify():
    rng = np.random.default_rng(SEED)
    rows = []
    stored_hamiltonians = []
    for n in (1, 2):
        d = 2**n
        for h_index in range(8):
            raw = rng.normal(size=(d, d)) + 1j * rng.normal(size=(d, d))
            h = (raw + raw.conj().T) / 2 + rng.normal() * np.eye(d)
            baseline = float(rng.uniform(101, 151))
            shift = float(rng.uniform(0.1, 3))
            us = expm(-1j * shift * h)
            a = np.trace(us) / d
            f = a.conjugate() * us
            g = -(f - f.conj().T) / (2j)
            if h_index < 2:
                stored_hamiltonians.append((n, h_index, h))
            for sign in (-1, 1):
                out, full, x, y = output_state(h, baseline, shift, sign)
                explicit = (np.kron(x, y) + 1j * sign * np.kron(y, x)) / math.sqrt(2)
                expected = (np.eye(d) + sign * g) / d
                row = {
                    "n": n, "hamiltonian_index": h_index, "sign": sign,
                    "baseline": baseline, "shift": shift,
                    "ancilla_one_norm": float(np.linalg.norm(full[1])),
                    "circuit_vector_error": float(np.linalg.norm(full[0] - explicit)),
                    "output_matrix_error": float(np.linalg.norm(out - expected, 2)),
                    "minimum_output_eigenvalue": float(np.linalg.eigvalsh(out)[0]),
                    "trace_error": float(abs(np.trace(out) - 1)),
                }
                for key in (
                    "ancilla_one_norm", "circuit_vector_error",
                    "output_matrix_error", "trace_error",
                ):
                    check(row[key] < TOL, f"Partial-SWAP check failed: {key}: {row}")
                check(row["minimum_output_eigenvalue"] > -TOL, f"Nonphysical output: {row}")
                rows.append(row)

    # Exact rational output, derived from full algebraic state vectors.
    imaginary = sp.I
    u0 = sp.diag((1 - imaginary) / sp.sqrt(2), (1 + imaginary) / sp.sqrt(2))
    u1 = sp.diag(-imaginary, imaginary)
    x = sp.Matrix([u0[0, 0], 0, 0, u0[1, 1]]) / sp.sqrt(2)
    y = sp.Matrix([u1[0, 0], 0, 0, u1[1, 1]]) / sp.sqrt(2)
    vector = (
        sp.kronecker_product(x, y) + imaginary * sp.kronecker_product(y, x)
    ) / sp.sqrt(2)
    reshaped = sp.Matrix(2, 8, list(vector))
    exact_output = (reshaped * reshaped.conjugate().T).applyfunc(sp.simplify)
    check(
        exact_output == sp.diag(sp.Rational(3, 4), sp.Rational(1, 4)),
        f"Exact partial-SWAP certificate failed: {exact_output}",
    )

    mixtures = []
    for n, h_index, h in stored_hamiltonians:
        d = len(h)
        norm = float(np.linalg.norm(h, 2))
        bandwidth = 2 * norm
        epsilon = bandwidth / 10
        cutoff = math.ceil(math.sqrt(8 * bandwidth / epsilon))
        baseline = 101 + 1 / bandwidth
        js = np.arange(1, cutoff + 1, dtype=float)
        ds = np.array(
            [1 if j % 2 else (-2 if j % 4 == 2 else 0)
             for j in range(1, cutoff + 1)], float,
        )
        coefficients = (32 * bandwidth / math.pi**3) * ds / js**3
        coefficient_norm = float(np.abs(coefficients).sum())
        mixture = np.zeros((d, d), complex)
        for index, coefficient in enumerate(coefficients, 1):
            if coefficient == 0:
                continue
            shift = index * math.pi / (2 * bandwidth)
            out, _, _, _ = output_state(
                h, baseline, shift, 1 if coefficient > 0 else -1
            )
            mixture += abs(coefficient) / coefficient_norm * out
        recovered = coefficient_norm * (d * mixture - np.eye(d))
        centered = h - np.trace(h) / d * np.eye(d)
        tail_bound = 32 * bandwidth / (math.pi**3 * cutoff**2)
        error = float(np.linalg.norm(recovered - centered, 2))
        check(error < tail_bound + TOL, f"Finite mixture tail exceeded: {error}, {tail_bound}")
        moments = pauli_readout_moments(mixture, n, coefficient_norm)
        for key in ("normalization_error", "first_moment_error", "second_moment_error"):
            check(moments[key] < TOL, f"Main-state readout failed: {key}: {moments}")
        mixtures.append({
            "n": n, "hamiltonian_index": h_index, "bandwidth": bandwidth,
            "epsilon": epsilon, "cutoff": cutoff,
            "coefficient_norm": coefficient_norm,
            "centered_hamiltonian_operator_error": error,
            "proved_tail_bound": tail_bound,
            "readout": moments,
        })

    maxima = {
        key: max(row[key] for row in rows)
        for key in (
            "ancilla_one_norm", "circuit_vector_error",
            "output_matrix_error", "trace_error",
        )
    }
    return {
        "status": "passed",
        "scope": (
            "Main-channel checks: complete known-gate partial-SWAP circuit and "
            "output partial trace for n=1,2; one exact symbolic certificate; "
            "finite mixtures and complete local-Pauli Born enumeration. "
            "This finite evidence does not replace the general analytic proof."
        ),
        "seed": SEED, "tolerance": TOL, "circuit_cases": len(rows),
        "max_errors": maxima,
        "exact_qubit_certificate": {
            "H": "diag(1,-1)", "baseline": "pi/4", "shift": "pi/4", "sign": 1,
            "output": [["3/4", "0"], ["0", "1/4"]], "symbolic_verified": True,
        },
        "finite_mixture_cases": len(mixtures),
        "main_readout_coordinate_checks": sum(x["readout"]["coordinates"] for x in mixtures),
        "mixtures": mixtures, "circuit_records": rows,
    }


if __name__ == "__main__":
    import json
    print(json.dumps(verify(), indent=2))

