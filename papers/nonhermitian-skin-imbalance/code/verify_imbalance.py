#!/usr/bin/env python3
"""Finite-size checks from a stable graph and a direct orbital QR."""
import numpy as np


def occupied_graph(weighted_shift, mixing_ratio, terms=24):
    matrix = weighted_shift * mixing_ratio
    square = matrix @ matrix
    power = matrix.copy()
    half_binomial = 0.5
    result = -half_binomial * power
    for m in range(2, terms + 1):
        half_binomial *= (1.5 - m) / m
        power = power @ square
        result -= half_binomial * power
    return result


def right_excess(projector, size):
    diagonal = projector.diagonal()
    density = diagonal[:size] + diagonal[size:]
    assert np.isclose(density.sum(), size)
    return float(density[size // 2:].sum() - density[:size // 2].sum())


def direct_orbital_qr(shift, mixing, detuning):
    """Evaluate each exact sine orbital in floating point, then orthonormalize."""
    size = len(shift)
    theta = np.arange(1, size + 1) * np.pi / (size + 1)
    positions = np.arange(1, size + 1)
    sine_modes = np.sin(positions[:, None] * theta) * 3.0 ** (positions[:, None] - size)
    energies = 2 * np.cos(theta)
    negative = energies - np.sqrt(detuning**2 + mixing**2 * energies**2)
    spinor_top = -mixing * energies / (detuning + np.sqrt(detuning**2 + mixing**2 * energies**2))
    orbitals = np.vstack((sine_modes * spinor_top, sine_modes))
    eye = np.eye(size)
    hamiltonian = np.block([
        [shift + detuning * eye, mixing * shift],
        [mixing * shift, shift - detuning * eye],
    ])
    assert np.max(np.abs(hamiltonian @ orbitals - orbitals * negative)) < 5e-12
    assert np.all(negative < -0.5)
    basis, _ = np.linalg.qr(orbitals)
    return basis @ basis.T


def main():
    bound = 45 / 512
    mixing = 1 / 4
    detuning = 5 / 2
    print("L,imbalance,trace_identity_error,direct_orbital_QR_error")
    for size in [2, 4, 8, 12, 24, 40, 64, 128]:
        lower_shift = np.diag(np.ones(size - 1), -1)
        shift = 3 * lower_shift + lower_shift.T / 3
        graph = occupied_graph(shift, mixing / detuning)
        eye = np.eye(size)
        gram_inverse = np.linalg.solve(eye + graph.T @ graph, eye)
        occupied = np.vstack((graph, eye))
        projector = occupied @ gram_inverse @ occupied.T
        assert np.max(np.abs(projector @ projector - projector)) < 5e-12
        imbalance = right_excess(projector, size)
        right_half = np.diag((np.arange(size) >= size // 2).astype(float))
        commutator = right_half @ graph - graph @ right_half
        from_cut = 2 * np.trace(commutator @ gram_inverse @ graph.T)
        trace_error = abs(imbalance - from_cut)
        assert trace_error < 5e-12
        assert abs(imbalance) < bound + 5e-12
        if size <= 12:
            reference = direct_orbital_qr(shift, mixing, detuning)
            qr_error = np.max(np.abs(projector - reference))
            assert qr_error < 5e-10
            print(f"{size},{imbalance:.12f},{trace_error:.3g},{qr_error:.3g}")
        else:
            print(f"{size},{imbalance:.12f},{trace_error:.3g},-")


if __name__ == "__main__":
    main()
