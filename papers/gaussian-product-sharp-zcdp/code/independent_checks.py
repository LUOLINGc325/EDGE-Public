#!/usr/bin/env python3
"""Exact, falsifiable checks for the Gaussian-product reverse comparison.

This checks specified algebraic proof obligations and an intentionally wrong
negative-branch map. It does not certify the continuum theorem or its novelty.
Only the Python standard library is used; asserts are deliberately avoided.
"""

from fractions import Fraction as F
import json


CHECK_COUNT = 0


def require(condition, label):
    global CHECK_COUNT
    CHECK_COUNT += 1
    if not condition:
        raise RuntimeError("FAILED: " + label)


def gaussian_log_ratio_without_normalization(z, u, v, m, n):
    return -(z - m) ** 2 / (2 * u**2) + (z - n) ** 2 / (2 * v**2)


def quadratic_certificate(u, d, b, branch):
    v = u + d
    m, n = branch * b * u, b * v
    A = (v**2 - u**2) / (2 * u**2 * v**2)
    center = (m * v**2 - n * u**2) / (v**2 - u**2)
    maximum = (m - n) ** 2 / (2 * (v**2 - u**2))
    require(A > 0, "correct reflection/positive map increases variance")
    # Both sides are quadratic. Three distinct exact evaluations identify them.
    for z in (F(-7, 3), F(0), F(13, 5)):
        require(
            gaussian_log_ratio_without_normalization(z, u, v, m, n)
            == maximum - A * (z - center) ** 2,
            "conditional Gaussian square completion",
        )
    if branch == 1:
        require(maximum == b**2 * d / (2 * (2 * u + d)), "positive-branch exponent")
    else:
        require(maximum == b**2 * (2 * u + d) / (2 * d), "reflected-branch exponent")
    return 3


def main():
    count = 0
    for u, d, b in (
        (F(1), F(1), F(0)),
        (F(3, 2), F(2, 3), F(-5, 4)),
        (F(7, 3), F(1, 10), F(11, 6)),
        (F(5), F(9, 7), F(-2)),
    ):
        for branch in (-1, 1):
            count += quadratic_certificate(u, d, b, branch)

    # Reflection is essential: translating a negative first factor towards zero
    # shrinks the conditional variance. With b=0, x=-2 and d=1, the log density
    # ratio has +3 z^2/8, so no finite all-output upper bound is possible.
    wrong_u, wrong_v = F(2), F(1)
    coefficient = 1 / (2 * wrong_v**2) - 1 / (2 * wrong_u**2)
    require(coefficient == F(3, 8), "wrong negative-branch translation is unbounded")
    count += 1

    # Boundary and sign checks for the comparison constants. The threshold below
    # contains exactly the sufficient inequalities used in this check; a release
    # may impose a larger threshold.
    for b, d in ((F(0), F(1)), (F(-3, 2), F(3, 4)), (F(2), F(1, 5))):
        a = max(F(2), d + 1, b**2 / d)
        for u in (a / 2, a / 2 + 1, 2 * a):
            positive_exponent = b**2 * d / (2 * (2 * u + d))
            reflected_exponent = -2 * a * u + b**2 * (2 * u + d) / (2 * d)
            require(positive_exponent <= b**2 * d / (2 * (a + d)), "positive exponent at threshold")
            require(reflected_exponent <= (b**2 - a**2) / 2, "negative exponent at threshold")
            require(1 + d / u <= 1 + 2 * d / a, "normalization ratio at threshold")
            count += 3

    # The low-order passage uses monotonicity D_alpha <= D_2, not monotonicity of
    # D_alpha/alpha. Its multiplicative factors must retain this distinction.
    for alpha in (F(1001, 1000), F(5, 4), F(3, 2), F(1999, 1000)):
        require(1 < alpha < 2 and 1 / alpha < 1, "low-order monotonicity factor")
        count += 1

    # For every real alpha >= 2, alpha/(alpha-1) <= 2 and 1/(alpha-1) <= 1.
    # Rational nonintegral representatives catch accidental floor/factor errors.
    for alpha in (F(2), F(9, 4), F(7, 2), F(101, 3)):
        require(alpha / (alpha - 1) <= 2, "noninteger high-order factor")
        require(1 / (alpha - 1) <= 1, "noninteger norm denominator")
        require(-alpha + (alpha - 1) / 2 + (alpha - 1) / 2 == -1,
                "uniform logarithmic-moment Gaussian exponent")
        n = -(-alpha.numerator // alpha.denominator)
        require(F(n + 1, 2) <= alpha, "noninteger Gamma-moment bound")
        count += 2

    print(json.dumps({
        "status": "passed",
        "exact_checks": CHECK_COUNT,
        "wrong_negative_shift_quadratic_coefficient": "3/8",
        "coverage": [
            "exact quadratic identities at three distinct points",
            "positive and reflected negative conditional Gaussian maps",
            "threshold boundaries and zero/negative second-factor means",
            "low and nonintegral high Renyi-order factors",
        ],
        "limits": "Finite algebra checks only; not a proof certificate for the continuum theorem.",
    }, indent=2))


if __name__ == "__main__":
    main()
