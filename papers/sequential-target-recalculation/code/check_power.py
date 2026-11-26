#!/usr/bin/env python3
"""Invert the exact diffusion hitting-time transform by two methods."""
import json
from math import erfc, exp, sqrt
from pathlib import Path

import mpmath as mp


def laplace_cdf(s, radius, shift):
    """Laplace transform in time, using the analytic continuation of the real integral."""
    k = mp.sqrt(shift**2 + 2 * s)
    b = (1 - shift / k) / 2
    z = 2 * k * radius
    integral = z**2 * mp.gamma(2 - b) * mp.hyperu(2 - b, 3, z)
    return mp.exp((shift - k) * radius) * integral / s


def main():
    mp.mp.dps = 26
    radius = mp.sqrt(2 * mp.log(20))
    a = float(radius)
    rows = []
    for shift in (-1, 0, 1, 2):
        def transform(s):
            return laplace_cdf(s, radius, shift)

        de_hoog = mp.invertlaplace(transform, 1, method="dehoog", degree=28)
        talbot = mp.invertlaplace(transform, 1, method="talbot", degree=32)
        assert abs(de_hoog - talbot) < mp.mpf("1e-13")
        if shift == 0:
            assert abs(de_hoog - mp.mpf("0.05")) < mp.mpf("1e-13")
        fixed = erfc((a - shift) / sqrt(2)) / 2
        barrier = fixed + exp(2 * a * shift) * erfc((a + shift) / sqrt(2)) / 2
        assert float(de_hoog) >= barrier >= fixed
        rows.append({
            "local_shift": shift,
            "star_de_hoog": mp.nstr(de_hoog, 15),
            "star_talbot": mp.nstr(talbot, 15),
            "fixed_hoeffding": fixed,
            "brownian_crossing_lower_bound": barrier,
        })
    result = {
        "alpha": 0.05,
        "limiting_variance": 0.25,
        "time": 1,
        "rows": rows,
    }
    output = Path(__file__).resolve().parents[1] / "results" / "diffusion_power.json"
    output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(output.name)


if __name__ == "__main__":
    main()
