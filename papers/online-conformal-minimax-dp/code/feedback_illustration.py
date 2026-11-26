#!/usr/bin/env python3
"""Midpoint quadrature for two illustrative critical feedback coefficients."""

from math import erf, exp, pi, sqrt


def coefficients(alpha, width, theta, mesh_size):
    sigma = sqrt(alpha * (1 - alpha))
    partition = drift_cost = 0.0
    step = 2 * width / mesh_size
    for cell in range(mesh_size):
        x = -width + (cell + 0.5) * step
        density_weight = exp(-(0.5 + theta) * (x / sigma) ** 2)
        drift = -theta * x
        disagreement = (
            2 * sigma * exp(-0.5 * (drift / sigma) ** 2) / sqrt(2 * pi)
            + drift * erf(drift / (sqrt(2) * sigma))
        )
        partition += density_weight * step
        drift_cost += disagreement * density_weight * step
    boundary_weight = exp(-(0.5 + theta) * (width / sigma) ** 2)
    return 2 * (drift_cost + sigma**2 * boundary_weight) / partition


def main():
    alpha = width = 0.5
    results = []
    for theta in (0.0, 0.5):
        estimate = coefficients(alpha, width, theta, 20000)
        finer = coefficients(alpha, width, theta, 40000)
        assert abs(estimate - finer) < 1e-8
        results.append(finer)
        print(f"alpha=kappa=1/2, theta={theta:.1f}: coefficient ≈ {finer:.6f}")
    assert results[1] < results[0]
    print("Numerical illustration only. The manuscript proves a strict improvement for small positive theta.")


if __name__ == "__main__":
    main()
