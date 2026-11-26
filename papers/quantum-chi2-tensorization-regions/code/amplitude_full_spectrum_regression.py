"""75 deterministic full tangent eigensolves for the amplitude spectrum.

Numerical agreement is diagnostic, not a proof. The output JSON is written
to the current working directory. Sources must remain beside quantum_sdpi.py.
"""
from __future__ import annotations

import json
import numpy as np
from scipy.special import expit
from quantum_sdpi import amplitude_damping, eta, tensor_channel


def run() -> dict:
    rows = []
    for copies in (2, 3, 4):
        for t, tprime in ((-2, -1), (-2, 1), (-1, 2), (0, 1), (0.5, 1.7)):
            for alpha in (0, 0.05, 0.1, 0.4, 0.5):
                sigma = np.diag([expit(t), expit(-t)])
                gamma = 1 - (1 + np.exp(t)) / (1 + np.exp(tprime))
                channel = amplitude_damping(gamma)
                product_channel, product_sigma = channel, sigma
                for _ in range(copies - 1):
                    product_channel = tensor_channel(product_channel, channel)
                    product_sigma = np.kron(product_sigma, sigma)
                actual = eta(product_channel, product_sigma, "mean", alpha)
                beta = 0.5 - alpha
                sectors = [
                    np.exp(-k * (tprime - t) / 2)
                    * np.cosh(k * beta * tprime)
                    / np.cosh(k * beta * t)
                    for k in range(1, copies + 1)
                ]
                predicted = float(max(sectors))
                error = abs(actual - predicted)
                if not np.isfinite(error) or error >= 5e-9:
                    raise AssertionError((copies, t, tprime, alpha, actual, predicted, error))
                rows.append(dict(n=copies, t=t, tprime=tprime, alpha=alpha,
                                 actual=actual, predicted=predicted, error=error))
    return {
        "cases": rows,
        "maximum_absolute_error": max(row["error"] for row in rows),
        "tolerance": 5e-9,
        "scope": "75 numerical cross-checks of the complete Hermitian traceless tangent eigenproblem against the scalar spectrum formula; not a proof",
    }


if __name__ == "__main__":
    result = run()
    with open("amplitude_full_spectrum_regression.json", "w", encoding="utf-8") as output:
        json.dump(result, output, indent=2, allow_nan=False)
    print("cases", len(result["cases"]),
          "maximum absolute error", result["maximum_absolute_error"])
