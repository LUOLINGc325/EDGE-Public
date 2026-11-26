"""Optional numerical graph-level replay of the exact order-four fixture."""

from itertools import permutations, product
import json
from math import acos, pi, sqrt
from pathlib import Path

import numpy as np


def tensor_power(matrix, order):
    out = np.ones((1, 1))
    for _ in range(order):
        out = np.kron(out, matrix)
    return out


def permuted_tensor_basis(order):
    labels = tuple(product(range(2), repeat=order))
    indices = {label: index for index, label in enumerate(labels)}
    vectors = []
    for perm in permutations(range(order)):
        matrix = np.zeros((len(labels), len(labels)))
        for i, label in enumerate(labels):
            image = tuple(label[index] for index in perm)
            matrix[indices[image], i] = 1
        vectors.append(matrix.reshape(-1))
    basis, singular_values, _ = np.linalg.svd(np.stack(vectors, axis=1), full_matrices=False)
    return basis[:, singular_values > 1e-12]


def main():
    case = Path(__file__).resolve().parents[1]
    graph = json.loads((case / "results/order_four_word.json").read_text())
    angles = {
        "0": 0,
        "pi/4": pi / 4,
        "pi/8": pi / 8,
        "acos(x_2)": acos(1 / sqrt(3)),
        "acos(x_4)": acos(sqrt((15 + 2 * sqrt(30)) / 35)),
    }
    order = graph["t"]
    dimension = 2**order
    assert order == 4
    assert graph["path_edges"] == [[i, i + 1] for i in range(graph["output"])]
    assert graph["input"] == 0
    images = np.eye(dimension**2, dtype=complex).reshape(-1, dimension, dimension)
    H = np.array([[1, 1], [1, -1]]) / sqrt(2)
    X = np.array([[0, 1], [1, 0]])
    for label in graph["measurement_angles_in_path_order"]:
        phi = angles[label]
        J = H @ np.diag([np.exp(-1j * phi / 2), np.exp(1j * phi / 2)])
        B = tensor_power(J, order)
        C = tensor_power(X @ J, order)
        images = (B @ images @ B.conj().T + C @ images @ C.conj().T) / 2
    basis = permuted_tensor_basis(order)
    assert basis.shape[1] == 14
    haar = basis @ basis.conj().T
    error = np.max(np.abs(images.reshape(-1, dimension**2) - haar))
    assert error < 1e-12
    print(f"All 256 order-four matrix units; Haar rank 14; max absolute error: {error:.6g}")


if __name__ == "__main__":
    main()
