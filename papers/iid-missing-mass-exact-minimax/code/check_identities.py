#!/usr/bin/env python3
"""Finite exact checks and numerical sanity checks for the missing-mass draft.

This script uses only the Python standard library. All finite-distribution
identities use Fraction; transcendental calculations use Decimal at 110 digits.
"""

from decimal import Decimal, localcontext
from fractions import Fraction
from hashlib import sha256
from itertools import product
import json
from pathlib import Path
import platform


ROOT = Path(__file__).resolve().parent.parent
OUTPUT = ROOT / "results" / "identity_checks.json"
MANUSCRIPT = ROOT / "paper.md"
ZERO = Fraction(0)
ONE = Fraction(1)
MAX_SAMPLE_SIZE = 6

DISTRIBUTIONS = {
    "one_atom": (ONE,),
    "boundary_two_atoms": (ONE, ZERO),
    "uniform_two": (Fraction(1, 2), Fraction(1, 2)),
    "rare_atom_two": (Fraction(1, 17), Fraction(16, 17)),
    "uniform_three": (Fraction(1, 3),) * 3,
    "unequal_three": (Fraction(1, 2), Fraction(1, 3), Fraction(1, 6)),
    "zero_atom_three": (ZERO, Fraction(1, 4), Fraction(3, 4)),
    "unequal_four": (Fraction(1, 10), Fraction(1, 5),
                     Fraction(3, 10), Fraction(2, 5)),
    "uniform_four": (Fraction(1, 4),) * 4,
}


def fraction_text(x):
    return str(x.numerator) if x.denominator == 1 else f"{x.numerator}/{x.denominator}"


def decimal_text(x):
    return format(x, ".85f")


def require_equal(left, right, context):
    if left != right:
        raise AssertionError(f"{context}: {left} != {right}")


def error_from_counts(counts, n, p):
    """Directly calculate G_n-M_n from its definition, not an increment formula."""
    singleton_count = sum(count == 1 for count in counts)
    missing_mass = sum((p[i] for i, count in enumerate(counts) if count == 0), ZERO)
    return Fraction(singleton_count, n) - missing_mass


def exact_risk_formula(n, p):
    """Right side of manuscript equation (3.3), with ordered i != j."""
    diagonal_singleton = sum((pi * (ONE - pi) ** (n - 1) / n for pi in p), ZERO)
    diagonal_missing = sum((pi * pi * (ONE - pi) ** n for pi in p), ZERO)
    off_negative = ZERO
    off_positive = ZERO
    for i, pi in enumerate(p):
        for j, pj in enumerate(p):
            if i == j:
                continue
            base = (ONE - pi - pj) ** (n - 2)
            off_negative -= pi * pj * base / n
            off_positive += pi * pj * (pi + pj) ** 2 * base
    return diagonal_singleton + diagonal_missing + off_negative + off_positive


def exact_checks():
    totals = {"distributions": len(DISTRIBUTIONS),
              "sequences_enumerated": 0,
              "risk_identity_cases_3_3": 0,
              "pointwise_increment_cases_5_2": 0,
              "conditional_drift_cases_5_3": 0,
              "bias_formula_cases": 0,
              "expected_drift_cases_5_4": 0}
    distribution_results = []
    for name, p in DISTRIBUTIONS.items():
        require_equal(sum(p, ZERO), ONE, f"{name}: normalization")
        if any(pi < 0 for pi in p):
            raise AssertionError(f"{name}: negative probability")
        alphabet_size = len(p)
        direct_bias = {}
        expected_z = {}
        risk_rows = []
        bias_rows = []
        for n in range(1, MAX_SAMPLE_SIZE + 1):
            total_probability = ZERO
            risk = ZERO
            bias = ZERO
            z_mean = ZERO
            sequence_count = 0
            for sequence in product(range(alphabet_size), repeat=n):
                sequence_count += 1
                counts = [0] * alphabet_size
                weight = ONE
                for symbol in sequence:
                    counts[symbol] += 1
                    weight *= p[symbol]
                total_probability += weight
                error = error_from_counts(counts, n, p)
                risk += weight * error * error
                bias += weight * error
                if n == MAX_SAMPLE_SIZE:
                    continue

                gt = Fraction(sum(count == 1 for count in counts), n)
                missing = sum((p[i] for i in range(alphabet_size)
                               if counts[i] == 0), ZERO)
                singleton_mass = sum((p[i] for i in range(alphabet_size)
                                      if counts[i] == 1), ZERO)
                unseen_square_mass = sum((p[i] ** 2 for i in range(alphabet_size)
                                          if counts[i] == 0), ZERO)
                z_value = missing - singleton_mass - gt + (n + 1) * unseen_square_mass
                conditional_increment = ZERO
                for next_symbol in range(alphabet_size):
                    after = list(counts)
                    after[next_symbol] += 1
                    direct_increment = error_from_counts(after, n + 1, p) - error
                    is_unseen = int(counts[next_symbol] == 0)
                    is_singleton = int(counts[next_symbol] == 1)
                    formula_increment = ((is_unseen - is_singleton - gt) / (n + 1)
                                         + p[next_symbol] * is_unseen)
                    require_equal(direct_increment, formula_increment,
                                  f"(5.2), {name}, n={n}, seq={sequence}, next={next_symbol}")
                    conditional_increment += p[next_symbol] * direct_increment
                    totals["pointwise_increment_cases_5_2"] += 1
                require_equal(conditional_increment, z_value / (n + 1),
                              f"(5.3), {name}, n={n}, seq={sequence}")
                totals["conditional_drift_cases_5_3"] += 1
                z_mean += weight * z_value

            require_equal(total_probability, ONE, f"{name}, n={n}: sequence weights")
            totals["sequences_enumerated"] += sequence_count
            direct_bias[n] = bias
            expected_z[n] = z_mean
            formula_bias = sum((pi ** 2 * (ONE - pi) ** (n - 1) for pi in p), ZERO)
            require_equal(bias, formula_bias, f"bias, {name}, n={n}")
            totals["bias_formula_cases"] += 1
            bias_rows.append({"n": n, "sequences": sequence_count,
                              "enumerated_bias": fraction_text(bias),
                              "formula_bias": fraction_text(formula_bias),
                              "residual": "0"})
            if n >= 4:
                rhs = exact_risk_formula(n, p)
                require_equal(risk, rhs, f"(3.3), {name}, n={n}")
                totals["risk_identity_cases_3_3"] += 1
                risk_rows.append({"n": n, "sequences": sequence_count,
                                  "enumerated_mse": fraction_text(risk),
                                  "identity_mse": fraction_text(rhs),
                                  "residual": "0"})

        drift_rows = []
        for n in range(1, MAX_SAMPLE_SIZE):
            bias_difference = (n + 1) * (direct_bias[n + 1] - direct_bias[n])
            cubic_formula = -(n + 1) * sum((pi ** 3 * (ONE - pi) ** (n - 1)
                                          for pi in p), ZERO)
            require_equal(expected_z[n], bias_difference, f"(5.4) bias, {name}, n={n}")
            require_equal(expected_z[n], cubic_formula, f"(5.4) cubic, {name}, n={n}")
            totals["expected_drift_cases_5_4"] += 1
            drift_rows.append({"n": n, "enumerated_E_Z": fraction_text(expected_z[n]),
                               "scaled_bias_difference": fraction_text(bias_difference),
                               "cubic_formula": fraction_text(cubic_formula),
                               "residual": "0"})
        distribution_results.append({"name": name, "probabilities": [fraction_text(pi) for pi in p],
                                     "risk_identity_3_3": risk_rows,
                                     "bias_formula": bias_rows,
                                     "expected_drift_5_4": drift_rows})
    return {"status": "PASS", "all_checked_residuals_exactly_zero": True,
            "totals": totals, "distributions": distribution_results}


def high_precision_checks():
    with localcontext() as context:
        context.prec = 110
        two = Decimal(2)
        w = Decimal("0.85")
        for _ in range(40):
            exp_w = w.exp()
            updated = w - (w * exp_w - two) / (exp_w * (1 + w))
            if abs(updated - w) < Decimal("1e-105"):
                w = updated
                break
            w = updated
        root_residual = w * w.exp() - two
        c_closed = w / two + w * w / Decimal(4)
        c_function = (1 + w) * (-w).exp() - (-two * w).exp()
        if abs(root_residual) >= Decimal("1e-100"):
            raise AssertionError("Lambert root residual exceeds tolerance")
        if abs(c_closed - c_function) >= Decimal("1e-100"):
            raise AssertionError("Two constant expressions disagree")
        epsilon_ratios = [Decimal(s) for s in ("0.5", "0.25", "0.1", "0.01",
                                                "0.001", "0.000001", "0.00000001")]
        mixture_rows = []
        centers = [("one_quarter", Decimal("0.25")), ("one_half", Decimal("0.5")),
                   ("w", w), ("one", Decimal(1)), ("two", two)]
        for name, c in centers:
            limit = (1 + c) * (-c).exp() - (-two * c).exp()
            rows = []
            for ratio in epsilon_ratios:
                epsilon = c * ratio
                lower, upper = c - epsilon, c + epsilon
                exp_lower, exp_upper = (-lower).exp(), (-upper).exp()
                # Exact antiderivatives for the continuous uniform mixing law.
                mu = ((lower + 1) * exp_lower - (upper + 1) * exp_upper) / (two * epsilon)
                nu = ((lower * lower + 3 * lower + 3) * exp_lower
                      - (upper * upper + 3 * upper + 3) * exp_upper) / (two * epsilon)
                bound = nu / c - (mu / c) ** 2
                difference = bound - limit
                rows.append({"epsilon_over_c": str(ratio), "epsilon": decimal_text(epsilon),
                             "mu": decimal_text(mu), "nu": decimal_text(nu),
                             "c_sigma_squared": decimal_text(bound),
                             "difference_from_F_c": decimal_text(difference)})
            if abs(Decimal(rows[-1]["difference_from_F_c"])) >= Decimal("1e-12"):
                raise AssertionError(f"Finite numerical convergence check failed at {name}")
            mixture_rows.append({"center_name": name, "c": decimal_text(c),
                                 "F_c": decimal_text(limit), "uniform_mixture_checks": rows})
        return {"status": "PASS", "decimal_working_precision": context.prec,
                "reported_digits_after_decimal": 85,
                "w": decimal_text(w), "w_exp_w_minus_2": str(root_residual),
                "C_star_closed_form": decimal_text(c_closed),
                "C_star_from_F_w": decimal_text(c_function),
                "constant_identity_residual": str(c_closed - c_function),
                "mixture_distribution": "Uniform[c-epsilon,c+epsilon]",
                "mixture_integrals_method": "analytic antiderivatives evaluated with Decimal.exp",
                "finite_convergence_tolerance": "absolute error < 1e-12 at epsilon/c=1e-8",
                "mixtures": mixture_rows}


def main():
    report = {
        "status": "FINITE_ALGEBRA_AND_CONSTANT_CHECKS",
        "purpose": "Reproducible exact algebra checks for equations (3.3), (5.2), (5.3), (5.4), and numerical constants.",
        "limitations": ["Finite examples do not establish universal identities or asymptotic claims.",
                        "The information lower bound is established by the argument in the paper.",
                        "Pointwise checks also include zero-probability sequences; expectation checks weight those sequences by zero."],
        "runtime": {"python": platform.python_version(), "dependencies": "Python standard library only",
                    "modules": ["decimal", "fractions", "hashlib", "itertools", "json", "pathlib", "platform"]},
        "script_sha256": sha256(Path(__file__).read_bytes()).hexdigest(),
        "manuscript_snapshot_sha256": sha256(MANUSCRIPT.read_bytes()).hexdigest() if MANUSCRIPT.exists() else None,
        "scope": {"exact_risk_sample_sizes": [4, 5, 6], "increment_sample_sizes": [1, 2, 3, 4, 5],
                  "bias_sample_sizes": [1, 2, 3, 4, 5, 6],
                  "enumeration": "all ordered sequences on each listed finite alphabet"},
        "exact_checks": exact_checks(),
        "high_precision_checks": high_precision_checks(),
    }
    OUTPUT.parent.mkdir(parents=True, exist_ok=True)
    OUTPUT.write_text(json.dumps(report, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")
    print("PASS: all finite Fraction identities and Decimal sanity checks")
    print(json.dumps(report["exact_checks"]["totals"], sort_keys=True))
    print("w = " + report["high_precision_checks"]["w"])
    print("C_star = " + report["high_precision_checks"]["C_star_closed_form"])
    print("Results: " + str(OUTPUT))


if __name__ == "__main__":
    main()
