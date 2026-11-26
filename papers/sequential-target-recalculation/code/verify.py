#!/usr/bin/env python3
"""Check exact path implications and reproduce finite-horizon Bernoulli diagnostics."""
import json
from math import erfc, log, sqrt
from pathlib import Path

import numpy as np


def rejection_masks(increments, log_target):
    """Return original STaR, fixed, and running-sum decisions for a batch of paths."""
    paths, n = increments.shape
    original = np.full(paths, log_target)
    changed = np.full(paths, (n + 1) * log_target / 2)
    partial_sum = np.zeros(paths)
    maximum = np.zeros(paths)
    threshold = sqrt(n * log_target / 2)
    for index, values in enumerate(increments.T):
        remaining = n - index
        scale = np.sqrt(8 * original / remaining)
        original = np.maximum(0, (1 + 1 / remaining) * original - scale * values)
        changed = np.maximum(
            0, changed - 2 * sqrt(remaining / (remaining + 1)) * np.sqrt(changed) * values
        )
        partial_sum += values
        maximum = np.maximum(maximum, partial_sum)
    star = original == 0
    fixed = partial_sum >= threshold
    crosses = maximum >= threshold
    assert np.array_equal(star, changed == 0)
    assert np.all(~fixed | crosses) and np.all(~crosses | star)
    return star, fixed, crosses


def exhaustive_binary(n, log_target):
    codes = np.arange(2**n, dtype=np.uint32)
    outcomes = (codes[:, None] >> np.arange(n, dtype=np.uint32)) & 1
    masks = rejection_masks(outcomes.astype(float) - 0.5, log_target)
    return {"n": n, "paths": len(codes), **summarize(masks)}


def summarize(masks):
    star, fixed, crosses = masks
    return {
        "star_rejections": int(np.count_nonzero(star)),
        "fixed_rejections": int(np.count_nonzero(fixed)),
        "running_sum_crossings": int(np.count_nonzero(crosses)),
    }


def bernoulli_experiment(rng, n, replication_count, mean, h, log_target):
    sigma = sqrt(mean * (1 - mean))
    candidate = mean - h * sigma / sqrt(n)
    counts = {"star_rejections": 0, "fixed_rejections": 0, "running_sum_crossings": 0}
    batch_size = 512
    for batch_start in range(0, replication_count, batch_size):
        count = min(batch_size, replication_count - batch_start)
        outcomes = rng.random((count, n)) < mean
        masks = rejection_masks(outcomes.astype(float) - candidate, log_target)
        for key, value in summarize(masks).items():
            counts[key] += value
    return {
        "n": n,
        "paths": replication_count,
        "true_mean": mean,
        "local_shift": h,
        **counts,
    }


def lower_endpoints(outcomes, log_target):
    paths, n = outcomes.shape
    left, right = np.zeros(paths), np.ones(paths)
    factors = 2 * np.sqrt(np.arange(n, 0, -1) / np.arange(n + 1, 1, -1))
    for _ in range(23):
        candidate = (left + right) / 2
        distance = np.full(paths, (n + 1) * log_target / 2)
        for factor, values in zip(factors, outcomes.T):
            distance = np.maximum(0, distance - factor * np.sqrt(distance) * (values - candidate))
        rejected = distance == 0
        left = np.where(rejected, candidate, left)
        right = np.where(rejected, right, candidate)
    return (left + right) / 2


def width_experiment(rng, n, paths):
    level = 0.025
    log_target = log(1 / level)
    outcomes = rng.integers(0, 2, size=(paths, n), dtype=np.int8)
    lower = lower_endpoints(outcomes, log_target)
    upper = 1 - lower_endpoints(1 - outcomes, log_target)
    half_width = sqrt(log_target / (2 * n))
    average = outcomes.mean(axis=1)
    ordinary_width = np.minimum(1, average + half_width) - np.maximum(0, average - half_width)
    adapted_width = np.maximum(0, upper - lower)
    assert np.all(adapted_width < ordinary_width + 2e-7)
    return {
        "n": n,
        "paths": paths,
        "mean_fixed_length": float(ordinary_width.mean()),
        "mean_star_length": float(adapted_width.mean()),
        "relative_mean_reduction": float(1 - adapted_width.mean() / ordinary_width.mean()),
    }


def main():
    delta = 0.05
    target = log(1 / delta)
    rng = np.random.default_rng(20261124)
    null_limits = []
    for mean in (0.5, 0.25):
        variance = mean * (1 - mean)
        a = sqrt(target / (2 * variance))
        null_limits.append({
            "true_mean": mean,
            "star_probability": delta ** (1 / (4 * variance)),
            "fixed_probability": erfc(a / sqrt(2)) / 2,
        })
    result = {
        "delta": delta,
        "seed": 20261124,
        "null_limits": null_limits,
        "exhaustive_bernoulli_half": [
            exhaustive_binary(n, target) for n in (8, 12, 16)
        ],
        "monte_carlo": [
            bernoulli_experiment(rng, n, 20480, mean, h, target)
            for mean, h in ((0.5, 0.0), (0.25, 0.0), (0.5, 1.0))
            for n in (64, 256, 1024, 4096)
        ],
        "two_sided_width_lower_bound_for_fair_bernoulli": (1 - 0.025**4) / (4 * log(40)),
        "two_sided_width_monte_carlo": [
            width_experiment(rng, n, 2048) for n in (128, 512, 2048)
        ],
        "scope": "Enumeration uses float64 decisions; larger runs are seeded Monte Carlo.",
    }
    output = Path(__file__).resolve().parents[1] / "results" / "verification.json"
    output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(output.name)


if __name__ == "__main__":
    main()
