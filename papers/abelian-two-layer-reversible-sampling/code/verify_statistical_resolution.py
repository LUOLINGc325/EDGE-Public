"""High-precision checks of the statistical-resolution formulas.

This verifies independently constructed 10-state generators against the
Fourier formulas. It is numerical evidence, not an interval proof.
"""

import json
from pathlib import Path

import mpmath as mp


mp.mp.dps = 120
PHI = (1 + mp.sqrt(5)) / 2
THETA = 2 * mp.pi / 5
A = mp.sin(THETA)
C = 2 * mp.pi


def generator(s, d):
    q = mp.zeros(10)
    b = mp.zeros(10)
    for u in range(5):
        for layer, step in enumerate((1, 2)):
            row = 2 * u + layer
            total = s if layer == 0 else PHI**2 * s
            factor = mp.mpf(1) if layer == 0 else PHI
            drift = factor * d
            plus = 2 * ((u + step) % 5) + layer
            minus = 2 * ((u - step) % 5) + layer
            q[row, plus] = (total + drift) / 2
            q[row, minus] = (total - drift) / 2
            q[row, 2 * u + 1 - layer] = C
            q[row, row] = -total - C
            b[row, plus] = factor / 2
            b[row, minus] = -factor / 2
    return q, b


def fourier_formulas(k, ell):
    s = 2 * mp.pi * k / A
    x, y = mp.cos(THETA), mp.cos(2 * THETA)
    r1 = mp.matrix([[s * (x - 1) - C, C],
                    [C, PHI**2 * s * (y - 1) - C]])
    u1 = mp.expm(r1)
    beta, gamma = A / 2, mp.sqrt(5) * A / 2
    r = s * (y - 1) - C
    traceless = mp.matrix([[1j * gamma * s, C],
                          [C, -1j * gamma * s]])
    d1 = -1j * A * u1
    d2 = mp.exp(r) * (
        1j * beta * mp.eye(2)
        - gamma**2 * s / (mp.pi * ell)**2 * traceless
    )
    rho = mp.exp(-2 * C)
    p0 = mp.matrix([[(1 + rho) / 2, (1 - rho) / 2],
                    [(1 - rho) / 2, (1 + rho) / 2]])
    pb = [p0, u1, mp.exp(r) * mp.eye(2), mp.exp(r) * mp.eye(2), u1]
    db = [mp.zeros(2), d1, d2, d2.conjugate(), d1.conjugate()]
    p, derivative = mp.zeros(10), mp.zeros(10)
    for u in range(5):
        for v in range(5):
            for i in range(2):
                for j in range(2):
                    phases = [
                        mp.exp(-2j * mp.pi * z * (v - u) / 5)
                        for z in range(5)
                    ]
                    p[2 * u + i, 2 * v + j] = mp.re(
                        sum(pb[z][i, j] * phases[z] for z in range(5)) / 5
                    )
                    derivative[2 * u + i, 2 * v + j] = mp.re(
                        sum(db[z][i, j] * phases[z] for z in range(5)) / 5
                    )
    return s, p, derivative


def max_abs(matrix):
    return max(abs(x) for x in matrix)


def nstr(value):
    return mp.nstr(value, 35)


def verify_pair(k, ell):
    assert ell * ell - 5 * k * k == -4
    s, p, d = fourier_formulas(k, ell)
    q, b = generator(s, s)
    direct_p = mp.expm(q)

    # exp([[Q, -B], [0, Q]]) has the Frechet derivative in its upper block.
    augmented = mp.zeros(20)
    for i in range(10):
        for j in range(10):
            augmented[i, j] = augmented[i + 10, j + 10] = q[i, j]
            augmented[i, j + 10] = -b[i, j]
    derivative_exp = mp.expm(augmented)
    direct_d = mp.matrix(
        [[derivative_exp[i, j + 10] for j in range(10)] for i in range(10)]
    )
    rows = [
        sum(d[i, j]**2 / p[i, j] for j in range(10))
        for i in range(10)
    ]
    fisher = sum(rows) / 10
    assert max_abs(direct_p - p) < mp.mpf("1e-100")
    assert max_abs(direct_d - d) < mp.mpf("1e-100")

    kl_ratios = {}
    for epsilon in (mp.mpf("1e-3"), mp.mpf("1e-4")):
        qe, _ = generator(s, s - epsilon)
        pe = mp.expm(qe)
        kl = sum(
            p[i, j] * mp.log(p[i, j] / pe[i, j])
            for i in range(10) for j in range(10)
        ) / 10
        kl_ratios[nstr(epsilon)] = nstr(kl / (fisher * epsilon**2 / 2))

    slow = (5 - mp.sqrt(5)) / 4
    fast = PHI**2 * (1 - mp.cos(2 * THETA))
    lambda_plus = -C - (slow + fast) * s / 2 + mp.sqrt(
        ((fast - slow) * s / 2)**2 + C**2
    )
    asymp_refined = 2 * A**2 / (1 + mp.exp(-2 * C)) * mp.exp(2 * lambda_plus)
    asymp_leading = 2 * A**2 / (mp.exp(2 * C) + 1) * mp.exp(-2 * slow * s)

    return {
        "boundary_k": k,
        "boundary_ell": ell,
        "precision_decimal_digits": mp.mp.dps,
        "s": nstr(s),
        "sample_min_entry": nstr(min(p)),
        "fisher_per_transition": nstr(fisher),
        "row_information_layer_0": nstr(rows[0]),
        "row_information_layer_1": nstr(rows[1]),
        "max_sample_formula_residual": nstr(max_abs(direct_p - p)),
        "max_derivative_formula_residual": nstr(max_abs(direct_d - d)),
        "kl_over_quadratic_leading_term": kl_ratios,
        "fisher_over_refined_asymptotic": nstr(fisher / asymp_refined),
        "fisher_over_leading_asymptotic": nstr(fisher / asymp_leading),
        "entropy_prefactor_without_normal_quantiles": nstr(
            1 / (4 * s**2 * PHI**(6 * PHI) * fisher)
        ),
    }


if __name__ == "__main__":
    records = [verify_pair(k, ell) for k, ell in ((2, 4), (5, 11), (13, 29))]
    payload = {
        "status": "high_precision_numerical_check_not_interval_certificate",
        "checks": records,
    }
    target = Path(__file__).resolve().parents[1] / "results/statistical_resolution_verification.json"
    target.parent.mkdir(exist_ok=True)
    target.write_text(json.dumps(payload, indent=2) + "\n")
    print(json.dumps(payload, indent=2))
