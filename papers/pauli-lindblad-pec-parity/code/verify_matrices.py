"""Independent small quantum-matrix checks of the binary representation.

This builds actual complex Pauli matrices and their conjugation superoperators,
then reshuffles to a normalized Choi matrix.  This is floating-point numerical
verification, not a proof and not an exact certificate.
"""
import json
from pathlib import Path
import random

import numpy as np

from pec_exact import inverse_coefficients

ROOT = Path(__file__).resolve().parents[1]
I2 = np.eye(2, dtype=complex)
X = np.array([[0, 1], [1, 0]], dtype=complex)
Y = np.array([[0, -1j], [1j, 0]], dtype=complex)
Z = np.diag([1, -1]).astype(complex)


def pauli(n, label):
    result = np.ones((1, 1), dtype=complex)
    for j in range(n):
        x, z = (label >> j) & 1, (label >> (n + j)) & 1
        factor = Y if x and z else X if x else Z if z else I2
        result = np.kron(result, factor)
    return result


def run():
    rng = random.Random(20261124)
    maximum_coefficient_error = 0.0
    maximum_choi_cost_error = 0.0
    maximum_hermiticity_error = 0.0
    checked = 0
    for n in (1, 2, 3):
        d = 1 << n
        for repetition in range(12):
            count = min((1 << (2 * n)) - 1, 3 + repetition % 5)
            labels = rng.sample(range(1, 1 << (2 * n)), count)
            parameters = [2 + j % 2 for j in range(count)]
            identity = np.eye(d * d, dtype=complex)
            superoperator = identity.copy()
            for label, parameter in zip(labels, parameters):
                matrix = pauli(n, label)
                conjugation = np.kron(matrix.conjugate(), matrix)
                inverse_factor = ((1 + parameter) * identity - (parameter - 1) * conjugation) / 2
                superoperator = inverse_factor @ superoperator
            target = inverse_coefficients(labels, parameters)
            for label in range(1 << (2 * n)):
                matrix = pauli(n, label)
                conjugation = np.kron(matrix.conjugate(), matrix)
                recovered = np.vdot(conjugation, superoperator) / (d * d)
                error = abs(recovered - float(target.get(label, 0)))
                maximum_coefficient_error = max(maximum_coefficient_error, float(error))
                assert error < 2e-10
            choi = np.empty((d * d, d * d), dtype=complex)
            for i in range(d):
                for j in range(d):
                    for k in range(d):
                        for ell in range(d):
                            choi[i * d + k, j * d + ell] = superoperator[k + ell * d, i + j * d] / d
            hermitian_error = float(np.max(abs(choi - choi.conjugate().T)))
            maximum_hermiticity_error = max(maximum_hermiticity_error, hermitian_error)
            assert hermitian_error < 2e-10
            assert abs(np.trace(choi) - 1) < 2e-10
            quantum_cost = float(np.sum(abs(np.linalg.eigvalsh(choi))))
            exact_cost = float(sum(map(abs, target.values())))
            cost_error = abs(quantum_cost - exact_cost)
            maximum_choi_cost_error = max(maximum_choi_cost_error, cost_error)
            assert cost_error < 2e-9
            checked += 1
    result = {
        'status': 'passed', 'instances': checked, 'qubits': [1, 2, 3],
        'seed': 20261124, 'numerics': 'complex128; no quantum hardware',
        'coefficient_tolerance': 2e-10, 'choi_cost_tolerance': 2e-9,
        'max_coefficient_error': maximum_coefficient_error,
        'max_choi_cost_error': maximum_choi_cost_error,
        'max_hermiticity_error': maximum_hermiticity_error,
        'scope': 'Numerical tests of actual Pauli superoperators and normalized Choi matrices; not a general proof.',
        'numpy_version': np.__version__,
    }
    (ROOT / 'results' / 'matrix_verification.json').write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result, indent=2))


if __name__ == '__main__':
    run()
