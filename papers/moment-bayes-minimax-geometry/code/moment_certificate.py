"""Independent exact certificates for subset moment decompositions.

All exact routines use SymPy rational arithmetic.  They verify a finite input
certificate; they do not replace the paper's general existence or minimax proof.
The numerical routine at the end is an optional floating-point diagnostic.

Classes are numbered 0, ..., k-1.  Moment matrices have the convention
    A = integral [1; x] [1; x]^T dQ(x),
where Q is a class subprobability measure, so A[0,0] is its prior probability.
"""

from __future__ import annotations

from itertools import combinations
from typing import Iterable, Mapping, Sequence

import sympy as sp

R = sp.Rational
Subset = tuple[int, ...]
Point = tuple[sp.Rational, ...]
AtomicMeasure = dict[Point, sp.Rational]


def subsets(k: int) -> list[Subset]:
    return [s for n in range(1, k + 1) for s in combinations(range(k), n)]


def rational_matrix(data) -> sp.Matrix:
    matrix = sp.Matrix(data)
    if any(not entry.is_Rational for entry in matrix):
        raise ValueError("An exact certificate must have rational entries.")
    return matrix


def exact_psd_decomposition(data) -> list[tuple[sp.Rational, sp.Matrix]]:
    """Return rational rank-one factors of a rational PSD matrix.

    This is an exact symmetric elimination with explicit zero-pivot checks.
    On success, M = sum_j weight_j vector_j vector_j^T, weight_j > 0.
    Reconstructing the matrix is part of the check.  No eigenvalue tolerance is
    used.  Zero diagonal with a nonzero row is rejected, as PSD requires.
    """
    matrix = rational_matrix(data)
    if matrix.rows != matrix.cols or matrix != matrix.T:
        raise ValueError("Expected a symmetric square matrix.")
    residual = matrix.copy()
    factors: list[tuple[sp.Rational, sp.Matrix]] = []
    for j in range(matrix.rows):
        pivot = residual[j, j]
        if pivot < 0:
            raise ValueError("Negative exact Schur-complement pivot.")
        if pivot == 0:
            if any(residual[j, ell] != 0 for ell in range(matrix.rows)):
                raise ValueError("A zero PSD pivot has a nonzero row.")
            continue
        vector = residual[:, j] / pivot
        factors.append((pivot, vector))
        residual -= pivot * vector * vector.T
    if residual != sp.zeros(matrix.rows):
        raise AssertionError("PSD decomposition left a nonzero remainder.")
    reconstructed = sum(
        (weight * vector * vector.T for weight, vector in factors),
        sp.zeros(matrix.rows),
    )
    if reconstructed != matrix:
        raise AssertionError("PSD decomposition does not reconstruct its input.")
    return factors


def moment_matrix(prior, mean: Sequence, covariance) -> sp.Matrix:
    prior = R(prior)
    if prior <= 0:
        raise ValueError("This construction requires a positive class prior.")
    mu = rational_matrix(mean)
    if mu.cols != 1:
        raise ValueError("Mean must be a vector.")
    cov = rational_matrix(covariance)
    if cov.shape != (mu.rows, mu.rows):
        raise ValueError("Covariance shape mismatch.")
    exact_psd_decomposition(cov)
    return prior * sp.Matrix.vstack(
        sp.Matrix.hstack(sp.ones(1, 1), mu.T),
        sp.Matrix.hstack(mu, cov + mu * mu.T),
    )


def add_atom(measure: AtomicMeasure, point: Iterable, mass) -> None:
    point = tuple(R(v) for v in point)
    mass = R(mass)
    if mass < 0:
        raise ValueError("Negative atom mass.")
    if mass:
        measure[point] = measure.get(point, R(0)) + mass


def atomic_moment(measure: Mapping[Point, sp.Rational], dimension: int) -> sp.Matrix:
    result = sp.zeros(dimension + 1)
    for point, mass in measure.items():
        if len(point) != dimension or mass < 0:
            raise ValueError("Invalid atom.")
        z = sp.Matrix([1, *point])
        result += mass * z * z.T
    return result


def realize_moment(data) -> AtomicMeasure:
    """Realize a rational PSD moment matrix with rational atoms and masses.

    Positive mass is necessary except for the zero matrix.  For covariance
    C = sum delta_j v_j v_j^T, take radius r = 1 + sum delta_j.  Put probability
    delta_j/(2r^2) at mean +/- r v_j and the remaining probability at the mean.
    Since s/(1+s)^2 <= 1 for s >= 0, all probabilities are nonnegative.
    This avoids square roots and works for singular covariance matrices.
    """
    matrix = rational_matrix(data)
    exact_psd_decomposition(matrix)
    mass = matrix[0, 0]
    dimension = matrix.rows - 1
    if mass == 0:
        if matrix != sp.zeros(matrix.rows):
            raise ValueError("A nonzero zero-mass PSD matrix has no measure realization.")
        return {}
    if mass < 0:
        raise ValueError("Negative mass.")
    mean = matrix[1:, 0] / mass
    covariance = matrix[1:, 1:] / mass - mean * mean.T
    factors = exact_psd_decomposition(covariance)
    total_pivot = sum((weight for weight, _ in factors), R(0))
    radius = 1 + total_pivot
    measure: AtomicMeasure = {}
    add_atom(measure, mean, mass * (1 - total_pivot / radius**2))
    for weight, vector in factors:
        atom_mass = mass * weight / (2 * radius**2)
        add_atom(measure, mean + radius * vector, atom_mass)
        add_atom(measure, mean - radius * vector, atom_mass)
    if atomic_moment(measure, dimension) != matrix:
        raise AssertionError("Exact atomic moment identity failed.")
    return measure


def canonical_blocks(
    moments: Sequence, blocks: Mapping[Subset, sp.Matrix]
) -> dict[Subset, sp.Matrix]:
    k = len(moments)
    matrices = [rational_matrix(a) for a in moments]
    if not matrices or any(a.shape != matrices[0].shape for a in matrices):
        raise ValueError("Inconsistent class moment matrices.")
    valid_keys = set(subsets(k))
    if set(blocks) - valid_keys:
        raise ValueError("Invalid class subset key.")
    dim = matrices[0].rows
    result = {s: rational_matrix(blocks.get(s, sp.zeros(dim))) for s in subsets(k)}
    for matrix in matrices:
        exact_psd_decomposition(matrix)
        if matrix[0, 0] <= 0:
            raise ValueError("Every class prior must be positive.")
    for matrix in result.values():
        if matrix.shape != matrices[0].shape:
            raise ValueError("Block shape mismatch.")
        exact_psd_decomposition(matrix)
    for i, target in enumerate(matrices):
        actual = sum((matrix for s, matrix in result.items() if i in s), sp.zeros(dim))
        if actual != target:
            raise ValueError("A class moment equality is not satisfied.")
    return result


def objective(blocks: Mapping[Subset, sp.Matrix]) -> sp.Rational:
    return sum(((len(s) - 1) * matrix[0, 0] for s, matrix in blocks.items()), R(0))


def repair_blocks(
    moments: Sequence, blocks: Mapping[Subset, sp.Matrix], mixing
) -> dict[Subset, sp.Matrix]:
    """Perform the positive-singleton mixture and rank-one compression.

    Mix the input with the feasible decomposition having only singleton A_i.
    Compress every nonsingleton block to the rank-one matrix with the same
    mass and first moments.  Add its zero-mass PSD remainder to *each* member's
    singleton block.  This last multiplicity is essential for moment balance.
    """
    matrices = [rational_matrix(a) for a in moments]
    source = canonical_blocks(matrices, blocks)
    mixing = R(mixing)
    if not 0 < mixing < 1:
        raise ValueError("mixing must lie strictly between zero and one.")
    size = matrices[0].rows
    output = {s: (1 - mixing) * matrix for s, matrix in source.items()}
    for i, matrix in enumerate(matrices):
        output[(i,)] += mixing * matrix
    for s in subsets(len(matrices)):
        if len(s) == 1:
            continue
        matrix = output[s]
        mass = matrix[0, 0]
        if mass:
            compressed = matrix[:, 0] * matrix[:, 0].T / mass
        else:
            if matrix[:, 0] != sp.zeros(size, 1):
                raise AssertionError("A zero-mass PSD matrix had nonzero first moments.")
            compressed = sp.zeros(size)
        remainder = matrix - compressed
        exact_psd_decomposition(remainder)
        if remainder[:, 0] != sp.zeros(size, 1):
            raise AssertionError("Compression did not preserve first moments.")
        output[s] = compressed
        for i in s:
            output[(i,)] += remainder
    canonical_blocks(matrices, output)
    if objective(output) != (1 - mixing) * objective(source):
        raise AssertionError("Objective scaling identity failed.")
    for i, matrix in enumerate(matrices):
        if output[(i,)][0, 0] < mixing * matrix[0, 0]:
            raise AssertionError("Positive singleton reserve is missing.")
    return output


def realize_blocks(
    moments: Sequence, blocks: Mapping[Subset, sp.Matrix]
) -> list[AtomicMeasure]:
    source = canonical_blocks(moments, blocks)
    k = len(moments)
    dimension = sp.Matrix(moments[0]).rows - 1
    measures: list[AtomicMeasure] = [{} for _ in range(k)]
    for s, matrix in source.items():
        common_measure = realize_moment(matrix)
        for i in s:
            for point, mass in common_measure.items():
                add_atom(measures[i], point, mass)
    for actual, target in zip(measures, moments):
        if atomic_moment(actual, dimension) != sp.Matrix(target):
            raise AssertionError("A realized class has wrong moments.")
    if bayes_error(measures) < objective(source):
        raise AssertionError("Bayes error is below the subset-overlap objective.")
    return measures


def bayes_error(measures: Sequence[Mapping[Point, sp.Rational]]) -> sp.Rational:
    support = set().union(*(set(measure) for measure in measures))
    result = R(0)
    for point in support:
        masses = [measure.get(point, R(0)) for measure in measures]
        result += sum(masses) - max(masses)
    return result


def check_dual(
    moments: Sequence, dual: Sequence, max_subset_size: int | None = None
) -> sp.Rational:
    k = len(moments)
    if len(dual) != k:
        raise ValueError("Wrong number of dual matrices.")
    matrices = [rational_matrix(y) for y in dual]
    e00 = sp.zeros(matrices[0].rows)
    e00[0, 0] = 1
    for s in subsets(k):
        if max_subset_size is not None and len(s) > max_subset_size:
            continue
        slack = sum((matrices[i] for i in s), sp.zeros(e00.rows)) - (len(s) - 1) * e00
        exact_psd_decomposition(slack)
    return sum((sp.trace(y * sp.Matrix(a)) for y, a in zip(matrices, moments)), R(0))


def barycentric_simplex_certificate(k: int, weights: Mapping[Subset, sp.Rational] | None = None):
    """Construct a rational primal/dual optimum for every finite k >= 2.

    The centers are 0,e_1,...,e_(k-1); G=I+11^T gives all squared distances 2.
    For nonempty S, its barycenter minimizes sum_{i in S} ||x-c_i||_G^2,
    and the minimum is |S|-1.  Hence all subset constraints have explicit
    quadratic certificates.  This function checks those identities exactly.
    Nonnegative subset weights must give every class a positive prior.
    """
    if k < 2:
        raise ValueError("At least two classes are required.")
    dimension = k - 1
    centers = [sp.zeros(dimension, 1)] + [sp.eye(dimension)[:, j] for j in range(dimension)]
    metric = sp.eye(dimension) + sp.ones(dimension)
    raw = {s: R(1) if weights is None else R(weights.get(s, 0)) for s in subsets(k)}
    if any(w < 0 for w in raw.values()):
        raise ValueError("Negative subset weight.")
    normalization = sum((len(s) * w for s, w in raw.items()), R(0))
    if normalization <= 0:
        raise ValueError("No mass.")
    blocks = {}
    for s, w in raw.items():
        mean = sum((centers[i] for i in s), sp.zeros(dimension, 1)) / len(s)
        z = sp.Matrix([1, *mean])
        blocks[s] = (w / normalization) * z * z.T
    moments = [sum((x for s, x in blocks.items() if i in s), sp.zeros(k)) for i in range(k)]
    dual = []
    for center in centers:
        dual.append(sp.Matrix.vstack(
            sp.Matrix.hstack(center.T * metric * center, -center.T * metric),
            sp.Matrix.hstack(-metric * center, metric),
        ))
    e00 = sp.zeros(k)
    e00[0, 0] = 1
    for s in subsets(k):
        mean = sum((centers[i] for i in s), sp.zeros(dimension, 1)) / len(s)
        expected = len(s) * sp.Matrix.vstack(
            sp.Matrix.hstack(mean.T * metric * mean, -mean.T * metric),
            sp.Matrix.hstack(-metric * mean, metric),
        )
        actual = sum((dual[i] for i in s), sp.zeros(k)) - (len(s) - 1) * e00
        if actual != expected:
            raise AssertionError("A simplex subset quadratic identity failed.")
    canonical_blocks(moments, blocks)
    value = objective(blocks)
    if check_dual(moments, dual) != value:
        raise AssertionError("Simplex primal and dual values disagree.")
    return moments, blocks, dual


def numerical_repair(moments, blocks, mixing: float, tolerance: float = 1e-9):
    """Floating-point version for exploratory inputs, with error diagnostics.

    This is not an exact certificate.  Eigenspectra below -tolerance are
    rejected.  Values within tolerance of zero may be clipped in the *atomic*
    realization, so the returned diagnostics include reconstruction error.
    """
    import numpy as np

    arrays = [np.array(a, dtype=float) for a in moments]
    k, size = len(arrays), arrays[0].shape[0]
    if not 0 < mixing < 1:
        raise ValueError("mixing must lie strictly between zero and one.")
    all_keys = subsets(k)
    if set(blocks) - set(all_keys):
        raise ValueError("Invalid subset key.")
    source = {s: np.array(blocks.get(s, np.zeros((size, size))), dtype=float) for s in all_keys}

    def check_psd(matrix):
        if not np.allclose(matrix, matrix.T, atol=tolerance, rtol=0):
            raise ValueError("Nonsymmetric numerical matrix.")
        if np.linalg.eigvalsh(matrix).min() < -tolerance:
            raise ValueError("Numerical matrix is not PSD within tolerance.")

    for matrix in [*arrays, *source.values()]:
        check_psd(matrix)
    for i, target in enumerate(arrays):
        total = sum((matrix for s, matrix in source.items() if i in s), np.zeros_like(target))
        if np.max(np.abs(total - target)) > tolerance:
            raise ValueError("Numerical class moment equality failed.")
        if target[0, 0] <= 0:
            raise ValueError("Nonpositive class prior.")
    output = {s: (1 - mixing) * matrix for s, matrix in source.items()}
    for i, matrix in enumerate(arrays):
        output[(i,)] = output[(i,)] + mixing * matrix
    for s in all_keys:
        if len(s) == 1:
            continue
        matrix = output[s]
        mass = matrix[0, 0]
        if mass > 0:
            compressed = np.outer(matrix[:, 0], matrix[:, 0]) / mass
        else:
            if np.max(np.abs(matrix[:, 0])) > tolerance:
                raise ValueError("Zero-mass block has nonzero first moments.")
            compressed = np.zeros_like(matrix)
        remainder = (matrix - compressed + (matrix - compressed).T) / 2
        check_psd(remainder)
        output[s] = compressed
        for i in s:
            output[(i,)] = output[(i,)] + remainder

    # Each entry is (point, vector of class-subprobability masses).  Coincident
    # atoms need not be merged: the unmerged Bayes error is a rigorous lower
    # bound in exact arithmetic and avoids arbitrary numerical point matching.
    atoms = []
    for s, matrix in output.items():
        mass = matrix[0, 0]
        if mass <= 0:
            if np.max(np.abs(matrix)) > tolerance:
                raise ValueError("Repair left a nonzero zero-mass block.")
            continue
        mean = matrix[1:, 0] / mass
        cov = matrix[1:, 1:] / mass - np.outer(mean, mean)
        eigenvalues, eigenvectors = np.linalg.eigh((cov + cov.T) / 2)
        if eigenvalues.min(initial=0) < -tolerance:
            raise ValueError("Numerical covariance is not PSD.")
        active = [(max(float(v), 0), eigenvectors[:, j]) for j, v in enumerate(eigenvalues) if v > tolerance]
        label_mass = np.zeros(k)
        label_mass[list(s)] = mass
        if not active:
            atoms.append((mean, label_mass))
        else:
            count = len(active)
            for eigenvalue, vector in active:
                offset = np.sqrt(count * eigenvalue) * vector
                atoms.append((mean + offset, label_mass / (2 * count)))
                atoms.append((mean - offset, label_mass / (2 * count)))
    reconstructed = [np.zeros((size, size)) for _ in range(k)]
    error_lower_bound = 0.0
    for point, label_mass in atoms:
        z = np.concatenate(([1.0], point))
        for i in range(k):
            reconstructed[i] += label_mass[i] * np.outer(z, z)
        error_lower_bound += float(label_mass.sum() - label_mass.max())
    original_value = sum((len(s) - 1) * matrix[0, 0] for s, matrix in source.items())
    return {
        "blocks": output,
        "atoms": atoms,
        "target_objective": float((1 - mixing) * original_value),
        "unmerged_bayes_error_lower_bound": error_lower_bound,
        "max_absolute_moment_error": max(float(np.max(np.abs(a - b))) for a, b in zip(arrays, reconstructed)),
        "tolerance": tolerance,
        "scope": "floating-point diagnostics only; exact certificates use separate rational routines",
    }
