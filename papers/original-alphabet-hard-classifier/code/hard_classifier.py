"""Reference implementation for one trained hard set on the original alphabet."""

from dataclasses import dataclass
import math

import numpy as np


@dataclass(frozen=True)
class HardClassifier:
    membership: np.ndarray
    cutoff: float
    holdout_size: int

    def predict(self, observations):
        """Return one binary label per original symbol, with no prediction coins."""
        indices = np.asarray(observations, dtype=np.int64)
        if indices.ndim != 1 or np.any(indices < 0) or np.any(indices >= self.membership.size):
            raise ValueError('observations must be original-alphabet indices')
        return self.membership[indices]

    def rejects(self, observed_holdout, reference_holdout):
        """Use only the balanced holdout predictions and the trained cutoff."""
        observed = self.predict(observed_holdout)
        reference = self.predict(reference_holdout)
        if observed.size != self.holdout_size or reference.size != self.holdout_size:
            raise ValueError('holdouts must both match the training block size')
        return float(observed.mean() - reference.mean()) >= self.cutoff


def reference_groups(q, boundary):
    """Yield the integer indices, reference upper mass, and log-scale index."""
    light = min(boundary, 1.0 / q.size)
    indices = np.flatnonzero(q <= light)
    if indices.size:
        yield indices, light, 0
    lower = 1.0 / q.size
    limit = min(boundary, 1.0)
    level = 1
    while lower < limit:
        upper = 2.0 * lower
        indices = np.flatnonzero((q > lower) & (q <= min(upper, limit)))
        if indices.size:
            yield indices, upper, level
        lower = upper
        level += 1


def fit_classifier(q, heavy_training, poisson_training, selection, epsilon, delta, rng):
    """Fit before accessing either holdout. Each input sample is independently drawn from p."""
    q = np.asarray(q, dtype=float)
    heavy_training = np.asarray(heavy_training, dtype=np.int64)
    poisson_training = np.asarray(poisson_training, dtype=np.int64)
    selection = np.asarray(selection, dtype=np.int64)
    n = heavy_training.size
    if q.ndim != 1 or q.size < 2 or np.any(~np.isfinite(q)) or np.any(q < 0):
        raise ValueError("q must be a finite nonnegative probability vector")
    if abs(float(q.sum()) - 1.0) > 1e-10:
        raise ValueError("q must sum to one")
    for block in (heavy_training, poisson_training, selection):
        if block.ndim != 1 or np.any(block < 0) or np.any(block >= q.size):
            raise ValueError('training data must contain original-alphabet indices')
    if n < 1 or poisson_training.size != 2 * n or selection.size != n:
        raise ValueError("training blocks must have lengths n, 2n, n")
    if not 0 < epsilon <= 1 or not 0 < delta <= 0.25:
        raise ValueError("separation or confidence outside the theorem range")

    ell = math.log(64.0 / delta)
    boundary = 4096.0 / (n * epsilon ** 2)
    length = rng.poisson(n)
    membership = np.zeros(q.size, dtype=bool)
    if length > 2 * n:
        return HardClassifier(membership, 12.0 * ell / n, n)
    heavy_counts = np.bincount(heavy_training, minlength=q.size)
    poisson_counts = np.bincount(poisson_training[:length], minlength=q.size)
    selection_counts = np.bincount(selection, minlength=q.size)
    heavy = np.flatnonzero(q > boundary)
    sign = heavy_counts[heavy] / n >= q[heavy]

    def fitted_if_passing(indices, local_ell):
        reference_mass = float(q[indices].sum())
        contrast = float(selection_counts[indices].sum()) / n - reference_mass
        radius = math.sqrt(reference_mass * local_ell / n) + local_ell / n
        if abs(contrast) < 40.0 * radius:
            return None
        fitted = np.full(q.size, contrast < 0, dtype=bool)
        fitted[indices] = contrast >= 0
        rare_mass = min(reference_mass, max(0.0, 1.0 - reference_mass))
        cutoff = 12.0 * (math.sqrt(rare_mass * ell / n) + ell / n)
        return HardClassifier(fitted, cutoff, n)

    for indices in (heavy[sign], heavy[~sign]):
        fitted = fitted_if_passing(indices, ell + 4)
        if fitted is not None:
            return fitted

    for indices, upper, level in reference_groups(q, boundary):
        local_ell = ell + 2 * level + 4
        fitted = fitted_if_passing(indices, local_ell)
        if fitted is not None:
            return fitted
        padding = rng.poisson(n * np.maximum(0.0, upper - q[indices]))
        threshold = max(1, math.ceil(n * upper))
        selected = indices[poisson_counts[indices] + padding >= threshold]
        fitted = fitted_if_passing(selected, local_ell)
        if fitted is not None:
            return fitted

    return HardClassifier(membership, 12.0 * ell / n, n)
