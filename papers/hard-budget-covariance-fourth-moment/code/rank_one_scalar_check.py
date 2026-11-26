"""Small deterministic checks for the two-scalar-block rank-one upper protocol.

No Monte Carlo rate experiment is performed. Exact arbitrary-real rank-one
support is a theorem assumption, not a property certified by floating point.
"""

from __future__ import annotations

import json
import math
from pathlib import Path

import numpy as np

from hard_budget_covariance import clip_covariance


def local_factor(paired: np.ndarray) -> tuple[float, int | None]:
    positions = np.flatnonzero(paired != 0)
    if not len(positions):
        return 0.0, None
    first = int(positions[0])
    return float(np.sign(paired[first]) * np.sqrt(np.mean(paired**2))), first


def scalar_encode(value: float, scale: float, budget: int) -> str:
    """A grid with at most 2^B points, including zero, inside [-scale,scale].

    For B>=1 the grid is {-scale + 2*scale*j/2^B : 0<=j<2^B}.
    Its covering radius is at most 2*scale/2^B. For B=0 use {0}.
    """
    if budget == 0:
        return ""
    count = 1 << budget
    coordinate = count * (value + scale) / (2 * scale)
    index = min(count - 1, max(0, math.floor(coordinate + 0.5)))
    return format(index, f"0{budget}b")


def scalar_decode(bits: str, scale: float, budget: int) -> float:
    assert len(bits) == budget
    if budget == 0:
        return 0.0
    return scale * (2 * int(bits, 2) / (1 << budget) - 1)


def main() -> None:
    scale = 1.0
    directions = [np.array([0.6, -0.8]), np.array([0.0, 1.0]), np.array([-1.0, 0.0])]
    signal_cases = [
        ("all_zero", np.zeros(5), 0.4),
        ("negative_first_low_energy", np.array([0., 0., -.25, .5, -.75]), 0.4),
        ("negative_first_clipped", np.array([0., 0., -8., 2., 5.]), 0.7),
        ("matching_energy", np.array([0., .5, -.5, .5, -.5]), 0.2),
        ("positive_first_clipped", np.array([0., 1., -1., 1., -1.]), 0.1),
    ]
    budget_pairs = [(0, 0), (0, 4), (2, 3), (6, 8)]
    mean = np.array([13.25, -8.5])
    checks = []
    for direction in directions:
        for name, signals, population_variance in signal_cases:
            n = len(signals)
            samples = np.empty((2*n, 2))
            samples[0::2] = mean + signals[:, None] * direction / math.sqrt(2)
            samples[1::2] = mean - signals[:, None] * direction / math.sqrt(2)
            paired = (samples[0::2] - samples[1::2]) / math.sqrt(2)
            local = [local_factor(paired[:, k]) for k in range(2)]
            v = np.array([item[0] for item in local])
            nonzero_indices = [item[1] for item in local if item[1] is not None]
            assert len(set(nonzero_indices)) <= 1
            assert np.allclose(np.outer(v, v), paired.T @ paired / n, atol=2e-12, rtol=2e-12)
            sample_variance = float(np.mean(signals**2))
            truth = population_variance * np.outer(direction, direction)
            w = np.clip(v, -scale, scale)
            projection_error = float(np.linalg.norm(np.outer(w, w) - truth, ord=2))
            assert projection_error <= abs(sample_variance - population_variance) + 2e-11
            for budgets in budget_pairs:
                bits = [scalar_encode(float(w[k]), scale, budgets[k]) for k in range(2)]
                z = np.array([scalar_decode(bits[k], scale, budgets[k]) for k in range(2)])
                assert all(len(bits[k]) == budgets[k] for k in range(2))
                assert all(abs(z[k] - w[k]) <= 2 * scale * 2**(-budgets[k]) + 1e-12
                           for k in range(2))
                estimate = clip_covariance(np.outer(z, z), scale**2)
                error = float(np.linalg.norm(estimate - truth, ord=2))
                upper = 2 * abs(sample_variance - population_variance) + 32 * max(
                    2**(-budgets[0]), 2**(-budgets[1])
                )
                assert error <= upper + 2e-11
                assert error <= scale**2 + 1e-12
                if name == "all_zero":
                    assert np.array_equal(estimate, np.zeros((2, 2)))
                checks.append({
                    "case": name,
                    "direction": direction.tolist(),
                    "budgets": list(budgets),
                    "first_nonzero_indices": [item[1] for item in local],
                    "sample_variance": sample_variance,
                    "population_variance_for_identity": population_variance,
                    "projection_error": projection_error,
                    "absolute_variance_error": abs(sample_variance - population_variance),
                    "decoded_error": error,
                    "message_lengths": [len(word) for word in bits],
                })
    certificate = {
        "status": "DETERMINISTIC_MECHANISM_CHECKS_PASSED",
        "cases_checked": len(checks),
        "statistical_rate_simulation": False,
        "scope": "Two scalar feature blocks only; floating-point diagnostic.",
        "checked_properties": [
            "Common first nonzero index for nonzero local blocks.",
            "Zero blocks and all-zero paired samples.",
            "Local factors reproduce the paired empirical rank-one covariance.",
            "Product-ball clipping error is at most the scalar variance error.",
            "Exact fixed message lengths, including zero-bit budgets.",
            "Finite-grid quantization and spectral-clipping error bounds.",
        ],
        "records": checks,
    }
    output = Path(__file__).resolve().parent.parent / "results" / "RANK_ONE_SCALAR_CERTIFICATE.json"
    output.write_text(json.dumps(certificate, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"cases_checked": len(checks), "output": str(output)}, indent=2))


if __name__ == "__main__":
    main()
