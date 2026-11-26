"""Exercise the hard-classifier interface on three explicit training examples."""

import numpy as np

from hard_classifier import fit_classifier, reference_groups


def require(condition):
    if not condition:
        raise ValueError("classifier protocol check failed")


def verify(q, n, symbol, epsilon, seed):
    rng = np.random.default_rng(seed)
    train = np.full(n, symbol)
    classifier = fit_classifier(q, train, np.full(2 * n, symbol), train, epsilon, 0.2, rng)
    labels = np.arange(q.size)
    first = classifier.predict(labels)
    require(first.dtype == np.bool_ and first.shape == q.shape)
    require(np.array_equal(first, classifier.predict(labels)))
    require(bool(first[symbol]))
    ref = np.zeros(n, dtype=np.int64)
    require(classifier.rejects(train, ref))
    require(not classifier.rejects(ref, ref))
    boundary = 4096.0 / (n * epsilon ** 2)
    groups = list(reference_groups(q, boundary))
    covered = np.sort(np.concatenate([indices for indices, _, _ in groups]))
    require(np.array_equal(covered, np.flatnonzero(q <= boundary)))
    return int(first.sum())


if __name__ == "__main__":
    heavy = verify(np.array([0.9, 0.1]), 100_000, 1, 0.5, 81)
    dense = verify(np.full(64, 1.0 / 64), 4000, 4, 0.6, 82)
    sparse = verify(np.full(10_000, 0.0001), 5000, 43, 0.6, 83)
    print(f"selected symbols in heavy, dense and sparse examples: {heavy}, {dense}, {sparse}")
