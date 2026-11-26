#!/usr/bin/env python3
"""Finite diagnostics for real Haar reciprocal MSTs; never an asymptotic proof.

Run from the case directory:
  OPENBLAS_NUM_THREADS=1 python code/diagnostics.py --output results/diagnostics.json
The exact finite-graph checks use rational arithmetic. Random diagnostics report
quantiles, not estimates of a heavy-tail population mean or confidence intervals.
"""
import argparse
import itertools
import json
import math
import platform
from fractions import Fraction
from pathlib import Path

import numpy as np
import scipy
from scipy.integrate import quad
from scipy.sparse.csgraph import minimum_spanning_tree
from scipy.special import erf, ellipkm1, gammaln


def prufer_tree(code, n):
    degree = [1] * n
    for x in code:
        degree[x] += 1
    edges = []
    for x in code:
        leaf = next(i for i in range(n) if degree[i] == 1)
        edges.append(tuple(sorted((leaf, x))))
        degree[leaf] -= 1
        degree[x] -= 1
    edges.append(tuple(i for i in range(n) if degree[i] == 1))
    return edges


def exact_graph_checks():
    n = 4
    edges = list(itertools.combinations(range(n), 2))
    trees = [prufer_tree(c, n) for c in itertools.product(range(n), repeat=n - 2)]
    assertions = 0
    for values in itertools.product([1, 2, 3], repeat=len(edges)):
        costs = dict(zip(edges, values))
        mst = min(sum(costs[e] for e in tree) for tree in trees)
        rowmins = [min(costs[tuple(sorted((i, j)))] for j in range(n) if i != j)
                   for i in range(n)]
        for root in range(n):
            assert sum(rowmins) - rowmins[root] <= mst
            assertions += 1
        tri_mins = [min(costs[tuple(sorted((i, j)))] for j in range(3) if i != j)
                    for i in range(3)]
        upper = sum(tri_mins) + min(costs[(i, 3)] for i in range(3))
        assert mst <= upper
        assertions += 1
        # Rowwise nonnegative U-L is the ingredient used when radii are capped.
        assert tri_mins[0] >= 0
        assert all(tri_mins[i] >= rowmins[i] for i in [1, 2])
        assert min(costs[(i, 3)] for i in range(3)) >= rowmins[3]
        assertions += 3
    star_checks = 0
    for coordinates in itertools.permutations([Fraction(1, 2), Fraction(1),
                                               Fraction(3, 2), Fraction(3)]):
        costs = {e: 1 / (coordinates[e[0]] * coordinates[e[1]]) for e in edges}
        mst = min(sum(costs[e] for e in tree) for tree in trees)
        hub = max(range(n), key=lambda i: coordinates[i])
        star = sum(1 / (coordinates[i] * coordinates[hub]) for i in range(n) if i != hub)
        assert mst == star
        star_checks += 1
    return dict(weighted_graphs=3 ** len(edges), trees_per_graph=len(trees),
                exact_inequality_checks=assertions, rational_star_checks=star_checks)


def b_m(m):
    """E[max of m Gamma(1/2,1) variables]^(-1/2), m>=2."""
    def integrand(t):
        if t == 0:
            return 8 / math.pi if m == 2 else 0.0
        f = float(erf(t))
        if f == 0:
            return 0.0
        return 2 * m / math.sqrt(math.pi) * math.exp(-t * t) * f ** (m - 1) / t
    return quad(integrand, 0, 12, epsabs=1e-10, epsrel=1e-10, limit=200)


def finite_mean_envelopes():
    """Bounds relative to the elliptic leading term; K cancels exactly.

    These are deterministic numerical evaluations of proved inequalities, not
    certified interval arithmetic. Their quadrature errors are recorded.
    """
    dims = [8, 16, 32, 64, 128, 256, 512]
    vals = {m: b_m(m) for m in range(2, max(dims))}
    result = []
    for d in dims:
        n, k = d - 1, (d - 2) / 2
        g = math.exp(gammaln(n / 2) - gammaln((n - 1) / 2))
        beta_lower = math.sqrt(math.pi) * math.exp(gammaln(k + 1) - gammaln(k + .5))
        beta_upper = k * math.sqrt(math.pi) * math.exp(gammaln(k - .5) - gammaln(k))
        common = 2 / math.pi * math.sqrt(math.pi * math.log(d)) / d ** 2
        lower = n * g * vals[n][0] * beta_lower * common
        upper = g * (3 * vals[2][0] + sum(vals[m][0] for m in range(3, n + 1))) * beta_upper * common
        assert lower <= upper
        result.append(dict(dimension=d, lower_ratio=lower, upper_ratio=upper,
                           b_n=vals[n][0], b_n_quadrature_error=vals[n][1],
                           beta_ratio=beta_upper / beta_lower))
    return result


def haar_pair(d, rng):
    z = rng.standard_normal((d, 2))
    q, r = np.linalg.qr(z, mode='reduced')
    return q * np.sign(np.diag(r))


def mst_diagnostic(d, epsilon, rng):
    q = haar_pair(d, rng)
    u, v = q[:, 0], q[:, 1]
    h = np.outer(u, u) + epsilon * np.outer(v, v)
    mag = np.abs(h)
    np.fill_diagonal(mag, 0)
    costs = np.divide(1, mag, out=np.full_like(mag, np.inf), where=mag > 0)
    dense = costs.copy()
    np.fill_diagonal(dense, 0)
    mst = float(minimum_spanning_tree(dense).sum())
    lower = float(costs.min(axis=1)[1:].sum())
    upper = float(costs[:3, :3].min(axis=1).sum())
    upper += sum(float(costs[j, :j].min()) for j in range(3, d))
    tol = 1e-9 * max(1, mst)
    assert lower <= mst + tol and mst <= upper + tol
    if epsilon == 0:
        hub = int(np.argmax(np.abs(u)))
        star = float(np.sum(1 / (np.abs(u[hub]) * np.abs(np.delete(u, hub)))))
        assert abs(star - mst) <= tol
    scale = d ** 2 * math.sqrt(math.log(d))
    return mst / scale, lower / scale, upper / scale


def summary(values):
    return dict(median=float(np.median(values)), q25=float(np.quantile(values, .25)),
                q75=float(np.quantile(values, .75)))


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument('--output', default='results/diagnostics.json')
    ap.add_argument('--seed', type=int, default=20261126)
    ap.add_argument('--samples', type=int, default=48)
    args = ap.parse_args()
    rng = np.random.default_rng(args.seed)
    data = dict(seed=args.seed, environment=dict(python=platform.python_version(),
                numpy=np.__version__, scipy=scipy.__version__),
                scope='Finite exact checks and illustrative diagnostics, not proofs of asymptotic limits.',
                exact=exact_graph_checks(), mean_envelopes=finite_mean_envelopes(),
                real_mst=[], gaussian_surrogate=[], rank_one_star=[])
    for d in [24, 48, 96]:
        for alpha in [0.0, .5, 1.0, 2.0, None]:
            epsilon = 0.0 if alpha is None else d ** (-alpha)
            rows = [mst_diagnostic(d, epsilon, rng) for _ in range(args.samples)]
            values = np.asarray(rows)
            data['real_mst'].append(dict(dimension=d, epsilon=epsilon, alpha=alpha,
                samples=args.samples, normalized_mst=summary(values[:, 0]),
                normalized_lower=summary(values[:, 1]), normalized_upper=summary(values[:, 2]),
                typical_asymptote=min(alpha if alpha is not None else math.inf, 1) / math.sqrt(math.pi),
                normalized_mean_leading_term=(float(ellipkm1(epsilon * epsilon)) /
                    (math.sqrt(math.pi) * math.log(d))) if epsilon else 'infinite',
                note='Quantiles only; finite samples cannot validate rare-event expectation constants.'))
    for d in [1000, 10000, 100000]:
        for alpha in [.5, 1., 2.]:
            epsilon = d ** -alpha
            values = []
            for _ in range(160):
                x, y = rng.standard_normal((2, d))
                values.append(float(np.reciprocal(np.hypot(x, epsilon * y)).sum()) /
                              (math.sqrt(2) * d * math.log(d)))
            data['gaussian_surrogate'].append(dict(dimension=d, alpha=alpha, samples=160,
                normalized_sum=summary(values), limit=min(alpha, 1) / math.sqrt(math.pi),
                note='Independent Gaussian radius surrogate only; not a sampled MST.'))
        stars = []
        for _ in range(160):
            x = np.abs(rng.standard_normal(d))
            maximum = float(x.max())
            mst = float(x @ x) / maximum * (float(np.reciprocal(x).sum()) - 1 / maximum)
            stars.append(mst / (d ** 2 * math.sqrt(math.log(d))))
        data['rank_one_star'].append(dict(dimension=d, samples=160,
            normalized_mst=summary(stars), limit=1 / math.sqrt(math.pi),
            population_mean='infinite at every dimension; no mean estimator reported'))
    path = Path(args.output)
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(data, ensure_ascii=False, indent=2, allow_nan=False) + '\n')
    print(json.dumps(dict(output=str(path), exact=data['exact'],
        real_mst_samples=sum(r['samples'] for r in data['real_mst']),
        gaussian_samples=sum(r['samples'] for r in data['gaussian_surrogate']),
        exact_star_samples=sum(r['samples'] for r in data['rank_one_star']))))


if __name__ == '__main__':
    main()
