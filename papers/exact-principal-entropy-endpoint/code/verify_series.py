"""Check the sixth-order endpoint and third-order optimizer in exact symbolic arithmetic."""
import json

import sympy as sp


def trim(expression, variable, order):
    return sp.series(expression, variable, 0, order).removeO().expand()


def main():
    r, k, eta = sp.symbols("r k eta")
    relative_log_radius = trim(sp.log(1 + 2 * k * r**2 + r**2) / 2, r, 6)
    phase_tangent = trim(r * sp.sqrt(1 - k**2 * r**2) / (1 + k * r**2), r, 7)
    phase = trim(sp.atan(phase_tangent), r, 7)
    damping_ratio = 1 - eta * relative_log_radius
    phase2 = trim(phase**2, r, 8)
    phase4 = trim(phase2**2, r, 8)
    series = trim(
        phase2 / damping_ratio + eta**2 * phase4 / damping_ratio**3
        + sp.Rational(9, 5) * eta**4 * r**6, r, 8
    )
    leading_optimizer = -1 + eta / 2
    quartic = sp.expand(series.coeff(r, 4).subs(k, leading_optimizer))
    sextic = sp.expand(series.coeff(r, 6).subs(k, leading_optimizer))
    cubic_optimizer = sp.expand(sp.diff(series.coeff(r, 6), k).subs(k, leading_optimizer) / 2)

    assert series.coeff(r, 2) == 1
    assert [series.coeff(r, q) for q in (1, 3, 5, 7)] == [0] * 4
    assert sp.diff(series.coeff(r, 4), k, 2) == -2
    assert sp.diff(series.coeff(r, 4), k).subs(k, leading_optimizer) == 0
    assert quartic == sp.Rational(1, 3) - eta / 2 + 5 * eta**2 / 4
    assert sextic == (sp.Rational(8, 45) - 5 * eta / 12 + 7 * eta**2 / 6
                      - 15 * eta**3 / 8 + 117 * eta**4 / 40)
    assert cubic_optimizer == -eta / 6 + 5 * eta**3 / 8
    limiting_series = trim(sp.asin(r)**2, r, 8)
    assert limiting_series == r**2 + quartic.subs(eta, 0) * r**4 + sextic.subs(eta, 0) * r**6
    assert sp.Rational(320, 2**12) < sp.Rational(1, 8)
    assert sp.Rational(1500, 2**12) < 2

    result = {
        "scale": "L t M_epsilon / 4",
        "leading_optimizer": str(leading_optimizer),
        "cubic_optimizer": str(cubic_optimizer),
        "quartic_endpoint": str(quartic),
        "sextic_endpoint": str(sextic),
        "eta_zero_check": str(limiting_series),
        "explicit_relative_radius": "1/4096",
        "scope": "Exact symbolic and rational checks of intermediate coefficients and thresholds."
    }
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
