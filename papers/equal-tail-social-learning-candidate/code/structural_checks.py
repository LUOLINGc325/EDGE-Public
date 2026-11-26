#!/usr/bin/env python3
"""Finite diagnostics for the unbounded-reversal construction.

This is NOT an infinite-horizon proof, simulation of the full
signal model, or a general proof. Exact arithmetic checks the finite
scale inequalities used in the author's proof. Decimal values are descriptive
diagnostics, not directed-rounding interval certificates.

Only the Python standard library is used. The construction is analyzed in the manuscript.
"""

from __future__ import annotations

import hashlib
import json
import math
from decimal import Decimal, localcontext
from fractions import Fraction
from pathlib import Path


OUT = Path(__file__).resolve().parents[1] / "results/structural_checks.json"
NOTE = Path(__file__).resolve().parents[1] / "paper.md"
PRECISION = 100


def dfrac(value: Fraction) -> Decimal:
    return Decimal(value.numerator) / Decimal(value.denominator)


def scientific(value: Decimal, digits: int = 22) -> str:
    return format(value, f".{digits}E")


def exact_fraction(value: Fraction) -> str:
    if value.denominator == 1:
        return str(value.numerator)
    return f"{value.numerator}/{value.denominator}"


def ceil_sqrt(value: int) -> int:
    root = math.isqrt(value)
    return root if root * root == value else root + 1


def gamma_tail_integer(power: int, lower: int) -> Decimal:
    """Exact polynomial times exp(-lower), evaluated at Decimal precision.

    It equals the integral of y**power exp(-y) from lower to infinity.
    The polynomial coefficients are integers, and are computed exactly.
    """
    factorial = math.factorial(power)
    polynomial = sum(
        (factorial // math.factorial(j)) * lower**j
        for j in range(power + 1)
    )
    return Decimal(polynomial) * (-Decimal(lower)).exp()


def main() -> None:
    checks: list[dict] = []

    def require(label: str, condition: bool, details: dict | None = None) -> None:
        row = {"label": label, "passed": bool(condition)}
        if details:
            row["details"] = details
        checks.append(row)
        if not condition:
            raise AssertionError(label)

    with localcontext() as ctx:
        ctx.prec = PRECISION
        # No huge exp(exp(.)) is evaluated. Exact rational inequalities and
        # logarithms compare those scales instead.
        ln2 = Decimal(2).ln()
        ln512 = Decimal(512).ln()
        ln64 = Decimal(64).ln()
        ln384 = Decimal(384).ln()
        ln1024 = Decimal(1024).ln()

        # t_k = 2^(4*3^k), so its square root and 3/4 power are integers.
        rows = []
        t = [1 << (4 * 3**k) for k in range(7)]
        a = [1 << (3 * 3**k) for k in range(7)]  # t_k^(3/4)
        s = [1 << (2 * 3**k) for k in range(7)]  # sqrt(t_k)
        for k in range(6):
            require(f"t_recurrence_{k}", t[k + 1] == t[k] ** 3)
            require(f"sqrt_identity_{k}", s[k] ** 2 == t[k])
            require(f"three_quarter_identity_{k}", a[k] ** 4 == t[k] ** 3)

            # Baseline tail <= exp(-t_k^4/2), while the next bump's c-tail
            # has scale exp(-t_k^3-t_k^(3/4)). This integer is their
            # favorable log-ratio margin, ignoring only fixed constants.
            baseline_margin = t[k] ** 4 // 2 - t[k + 1] - a[k]
            require(f"positive_baseline_margin_{k}", baseline_margin > 0)
            require(
                f"baseline_margin_exceeds_t_next_{k}",
                baseline_margin > t[k + 1],
            )

            # Full-support baseline contribution to Q has an upper scale
            # C exp(t_k^(3/4)-t_k^4/2). A displayed C=1024 is conservative;
            # its verification is an analytic bound, not an
            # assertion that a complete bump integral was evaluated here.
            q_baseline_log = ln1024 + Decimal(a[k]) - Decimal(t[k] ** 4) / 2
            require(
                f"q_baseline_log_negative_{k}",
                10 + a[k] - t[k] ** 4 // 2 < 0,
                {"reason": "ln(1024)=10 ln(2)<10; the checked upper exponent is an integer."},
            )

            q_bump_log = (
                Decimal(4).ln()
                - Decimal(t[k] + 1).sqrt()
                + (ln384 + Decimal(a[k])).ln()
            )
            if k >= 1:
                require(
                    f"q_bump_log_negative_{k}",
                    Fraction(s[k] ** 8, math.factorial(8)) > 4 * (9 + a[k]),
                    {"reason": "exp(sqrt(t))>=sqrt(t)^8/8!; ln(384)<9. Bumps start at k=1; k=0 is only a displayed diagnostic."},
                )

            good_run_log = Decimal(a[k]) - Decimal(t[k])
            require(f"good_run_integral_log_negative_{k}", a[k] < t[k])

            mu_log = -a[k]  # mu_(k+1)
            next_mu_ratio_log = -(a[k + 1] - a[k])
            require(
                f"bump_tail_geometric_ratio_{k}",
                a[k + 1] - a[k] >= 1,
                {"reason": "exp(-1)<1/2, so the entire later mass is <=2 times its first term."},
            )
            rows.append(
                {
                    "k": k,
                    "t_k": str(t[k]),
                    "sqrt_t_k": str(s[k]),
                    "t_k_to_three_quarters": str(a[k]),
                    "log_mu_k_plus_1_exact": str(mu_log),
                    "log_next_mass_ratio_exact": str(next_mu_ratio_log),
                    "baseline_to_next_c_tail_log_margin_exact": str(baseline_margin),
                    "q_baseline_upper_log_scale": scientific(q_baseline_log),
                    "q_bump_upper_log_scale": scientific(q_bump_log),
                    "good_run_integral_upper_log_scale_without_constant": str(a[k] - t[k]),
                }
            )

        # Fixed-origin bad-run suppression. For interval [t_k,t_(k+1)],
        # the previous unit interval contributes at least
        # exp(t_(k-1)^(3/4)-sqrt(t_(k-1)+4))/512 to -log survival.
        # We use sqrt <= ceil_sqrt and e^x >= x^8/8!, so this comparison
        # is an exact rational certificate at the listed finite scales.
        moment_orders = [Fraction(1, 1000), Fraction(1, 4), Fraction(1), Fraction(2), Fraction(10), Fraction(100)]
        fixed_origin = []
        for k in range(1, 6):
            exponent_lower = a[k - 1] - ceil_sqrt(t[k - 1] + 4)
            require(f"suppression_exponent_positive_{k}", exponent_lower > 0)
            exp_lower = Fraction(exponent_lower**8, 512 * math.factorial(8))
            next_log2 = 4 * 3 ** (k + 1)
            for p in moment_orders:
                q = max(Fraction(1), p)
                # ln 64<6, ln t_(k+1)<log_2(t_(k+1)).
                clock_log_upper = q * (6 + next_log2 + a[k])
                margin = exp_lower - clock_log_upper
                numeric_log_margin = (
                    Decimal(a[k - 1])
                    - Decimal(t[k - 1] + 4).sqrt()
                    - ln512
                    - (dfrac(q) * (ln64 + Decimal(next_log2) * ln2 + Decimal(a[k]))).ln()
                )
                if k >= 2:
                    require(
                        f"fixed_origin_suppression_dominates_k{k}_p{p}",
                        margin > 0,
                    )
                # k=1 is deliberately left as an uncontrolled finite prefix.
                fixed_origin.append(
                    {
                        "k": k,
                        "p": exact_fraction(p),
                        "integer_lower_exponent": str(exponent_lower),
                        "exp_lower_certificate_method": "exp(x)>=x^8/8!, followed by division by 512",
                        "exact_certificate_margin": exact_fraction(margin),
                        "certificate_dominates": margin > 0,
                        "log_ratio_suppression_to_clock_cost_decimal": scientific(numeric_log_margin),
                        "finite_prefix_allowed": k == 1,
                    }
                )

        # Total-error lower bound: after removing a fixed positive factor,
        # its logarithm is bounded below on the scale
        # (p/2)t_k^(3/2)-t_k-sqrt(t_k+5)+t_k^(3/4)-0.5log(t_k+5).
        # The simpler exact condition p sqrt(t_k)>4 ensures that the
        # leading term alone beats 2t_k. This tests finite instances of
        # the exponent competition, not an expectation of a finite model.
        total_error = []
        orders_total = [Fraction(1, 1000), Fraction(1, 100), Fraction(1, 4), Fraction(1), Fraction(10)]
        for k in range(5):
            for p in orders_total:
                leading_margin = p * s[k] - 4
                reduced_exponent = (
                    dfrac(p) * Decimal(t[k] * s[k]) / 2
                    - Decimal(t[k])
                    - Decimal(ceil_sqrt(t[k] + 5))
                    + Decimal(a[k])
                    - Decimal(t[k] + 5).ln() / 2
                )
                reduced_exponent_exact_lower = (
                    p * Fraction(t[k] * s[k], 2)
                    - t[k]
                    - ceil_sqrt(t[k] + 5)
                    + a[k]
                    - Fraction((t[k] + 5).bit_length(), 2)
                )
                if k >= 2:
                    require(f"total_error_growth_k{k}_p{p}", leading_margin > 0)
                    require(
                        f"total_error_reduced_exponent_positive_k{k}_p{p}",
                        reduced_exponent_exact_lower > 0,
                        {"reason": "sqrt(t+5)<=ceil_sqrt(t+5) and ln(t+5)<bit_length(t+5)."},
                    )
                total_error.append(
                    {
                        "k": k,
                        "p": exact_fraction(p),
                        "exact_leading_margin_p_sqrt_t_minus_4": exact_fraction(leading_margin),
                        "leading_margin_positive": leading_margin > 0,
                        "reduced_log_lower_bound_without_fixed_factor": scientific(reduced_exponent),
                        "exact_rational_lower_bound_on_reduced_exponent": exact_fraction(reduced_exponent_exact_lower),
                        "fixed_factor_omitted": "positive first-correct-action probability, uniform correct-herd delta, and constants depending on p and the fixed splice R",
                    }
                )

        # Two-way KL splice diagnostics. These are upper *component* bounds
        # before the fixed normalizer constants. The true experiment is
        # unchanged throughout; only the perceived tail cutoff moves.
        kl_rows = []
        for t0 in [16, 256, 4096, 65536]:
            R = t0 - 2
            m = math.isqrt(R + 1)
            require(f"kl_lower_endpoint_{t0}", m * m <= R + 1 < (m + 1) ** 2)
            # f(r)dr=e^-y dy for y=sqrt(r+1); (1+r^4)<=1+y^8.
            forward_tail_upper = (-Decimal(m)).exp() + gamma_tail_integer(8, m)
            true_mass_upper = (-Decimal(m)).exp()

            reverse_terms = []
            tk_prev = t0
            # t0 is a power of 16, so all needed fractional powers are exact.
            for j in range(2):
                root = math.isqrt(tk_prev)
                fourth = math.isqrt(root)
                require(f"kl_exact_fourth_root_t{t0}_j{j}", fourth**4 == tk_prev)
                power_three_quarters = fourth**3
                next_t = tk_prev**3
                sqrt_next = math.isqrt(next_t)
                log_term = -Decimal(power_three_quarters) + Decimal(1 + sqrt_next).ln()
                reverse_terms.append(
                    {
                        "index": j + 1,
                        "log_reverse_bump_component": scientific(log_term),
                        "mass_log": str(-power_three_quarters),
                        "sqrt_next_location": str(sqrt_next),
                    }
                )
                tk_prev = next_t
            # For y=t_(k-1)^(3/4), sqrt(t_k)=y^2. For y>=8,
            # e^-y(1+y^2) <= exp(-y/3): check this first boundary
            # numerically below; analytic monotonicity gives the full bound.
            y0 = math.isqrt(math.isqrt(t0)) ** 3
            # Here use an explicit two-term geometric majorant with a
            # conservative exponent 1/3, not the sharper eventual 1/2.
            reverse_series_majorant = 2 * (-Decimal(y0) / 3).exp()
            kl_rows.append(
                {
                    "R": R,
                    "t0": t0,
                    "true_model_changed": False,
                    "m_floor_sqrt_R_plus_1": m,
                    "forward_KL_integral_component_upper": scientific(forward_tail_upper),
                    "true_generator_tail_mass_upper": scientific(true_mass_upper),
                    "reverse_bump_components": reverse_terms,
                    "reverse_series_conservative_majorant": scientific(reverse_series_majorant),
                    "note": "These are entropy-integral components, not fully evaluated KL divergences. Normalizer convergence and the baseline tail are proved analytically in the note.",
                }
            )

        # Supplement the majorant above with finite rational certificates
        # e^(2y/3)>=1+y^2 at the checked y values. Use a positive Taylor
        # partial sum. For the infinite theorem, derivative monotonicity
        # of 2y/3-ln(1+y^2) for y>=8 is the actual argument.
        reverse_majorant_checks = []
        for y in [8, 64, 512, 4096]:
            x = Fraction(2 * y, 3)
            partial = sum((x**j / math.factorial(j) for j in range(13)), Fraction(0))
            require(f"reverse_series_component_majorant_y{y}", partial >= 1 + y * y)
            reverse_majorant_checks.append(
                {"y": y, "exact_Taylor_lower_minus_target": exact_fraction(partial - (1 + y * y))}
            )

        # Correct-specification baseline: B=r+O(1), log T=sqrt r+O(log r).
        # The ordinary J_p exponent p sqrt r-r and WR exponent
        # -r/2+sqrt r are negative at these sufficiently remote scales.
        baseline_rows = []
        for p in [Fraction(1, 100), Fraction(1), Fraction(10), Fraction(100)]:
            sqrt_r = max(16, 4 * math.ceil(p))
            r = sqrt_r * sqrt_r
            j_exponent = p * sqrt_r - r
            wr_exponent = Fraction(-r, 2) + sqrt_r
            require(f"correct_baseline_J_exponent_p{p}", j_exponent < 0)
            require(f"correct_baseline_WR_exponent_p{p}", wr_exponent < 0)
            baseline_rows.append(
                {
                    "p": exact_fraction(p),
                    "r": r,
                    "exact_J_main_exponent": exact_fraction(j_exponent),
                    "exact_WR_main_exponent": exact_fraction(wr_exponent),
                    "R_used": False,
                    "transfer_argument": "Weighted reversal condition WR_p, not bounded restart R.",
                }
            )

    report = {
        "schema": "finite_structural_diagnostics_v1",
        "claim": "Finite arithmetic diagnostics for the smooth unbounded-reversal and two-way-KL tail-splicing construction",
        "proof_status": "Finite exact calculations for the specified parameter choices.",
        "manuscript_sha256": hashlib.sha256(NOTE.read_bytes()).hexdigest(),
        "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "runtime": {"implementation": "Python standard library only", "decimal_precision": PRECISION},
        "exact_checks": {"count": len(checks), "passed": sum(c["passed"] for c in checks), "checks": checks},
        "scale_rows": rows,
        "fixed_origin_suppression_vs_clock": fixed_origin,
        "total_error_lower_bound_competition": total_error,
        "two_way_KL_splice_components": kl_rows,
        "reverse_majorant_exact_certificates": reverse_majorant_checks,
        "correct_specification_baseline": baseline_rows,
        "limitations": [
            "Only finitely many scale parameters and moment orders were checked.",
            "No finite computation proves the stated all-p or infinite-horizon conclusions.",
            "Decimal logarithms are descriptive high-precision values, not interval certificates.",
            "The exact certificates are integer/Fraction inequalities, not integrals over the complete C-infinity bump model.",
            "The KL rows bound entropy-integral components; they do not numerically integrate the entire normalized pair of experiments.",
            "The constants in the actual total-W lower bound include a positive model-dependent factor not evaluated here.",
            "The finite initial interval is allowed to be very costly; no uniform welfare upper bound over the splice family is claimed.",
        ],
    }
    OUT.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"output": str(OUT), "exact_checks": len(checks), "passed": sum(c["passed"] for c in checks)}, ensure_ascii=False))


if __name__ == "__main__":
    main()
