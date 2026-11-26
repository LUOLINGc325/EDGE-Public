"""Quadrature for the scalar one-sided Pareto scale experiment and Gaussian/Cauchy information.
Run with Python 3, NumPy and SciPy. All reported losses use natural logarithms or squared error.
"""

import json
import math

import numpy as np
from scipy.integrate import quad
from scipy.special import log_ndtr, ndtr, voigt_profile

LOG_SQRT_2PI = 0.5 * math.log(2 * math.pi)


def log_gaussian_second_tail(z):
    """Log integral of g² phi(g) over g > z, stable at large positive z."""
    if z <= 0:
        return math.log(ndtr(-z) + z * math.exp(-z * z / 2 - LOG_SQRT_2PI))
    return float(np.logaddexp(log_ndtr(-z), math.log(z) - z * z / 2 - LOG_SQRT_2PI))


def risk_over_epsilon_power(exponent, log_inverse_scale, threshold):
    """Integrate the exact hard-threshold risk divided by epsilon**exponent."""
    def central(log_r):
        r = math.exp(log_r)
        miss = ndtr(threshold - r) - ndtr(-threshold - r)
        log_detect_loss = np.logaddexp(
            log_gaussian_second_tail(threshold - r), log_gaussian_second_tail(threshold + r)
        )
        return exponent * (
            math.exp((2 - exponent) * log_r) * miss
            + math.exp(log_detect_loss - exponent * log_r)
        )

    end = threshold + 14
    cuts = sorted({-log_inverse_scale, 0.0, math.log(threshold),
                   math.log(end), math.log(max(threshold - 12, 1))})
    central_loss = sum(quad(central, a, b, epsabs=2e-10, epsrel=2e-11)[0]
                       for a, b in zip(cuts, cuts[1:]))

    def far(u):
        r = end * u ** (-1 / exponent)
        miss = ndtr(threshold - r) - ndtr(-threshold - r)
        detect_loss = math.exp(log_gaussian_second_tail(threshold - r))
        detect_loss += math.exp(log_gaussian_second_tail(threshold + r))
        return (r * r * miss + detect_loss) / end ** exponent

    return central_loss + quad(far, 0, 1, epsabs=1e-12)[0]


def scaled_truncated_moment(exponent, log_inverse_scale):
    t = math.sqrt(2 * exponent * log_inverse_scale)
    if exponent == 2:
        return 2 * (math.log(t) + log_inverse_scale)
    return exponent * (t ** (2 - exponent) - math.exp(-(2 - exponent) * log_inverse_scale)) / (2 - exponent)


def cauchy_information(epsilon):
    def entropy_density(x):
        f = voigt_profile(x, 1.0, epsilon)
        return -f * math.log(f)

    t = math.sqrt(2 * math.log(1 / epsilon))
    area = quad(entropy_density, 0, t, epsabs=1e-14, epsrel=1e-13)[0]
    area += quad(lambda v: 2 * t * entropy_density(t / v**2) / v**3,
                 0, 1, epsabs=1e-14, epsrel=1e-13)[0]
    info = 2 * area - (LOG_SQRT_2PI + 0.5)
    equivalent = 2 * math.atan(epsilon / t) * t * t / math.pi
    return {"epsilon": epsilon, "information": info, "asymptotic_ratio": info / equivalent}


def main():
    estimates = []
    for light, heavy in ((1.7, 0.65), (2.0, 1.0)):
        predicted = (light / heavy) ** (1 - heavy / 2)
        for log_inverse in (30, 150, 800, 3500):
            u = light * log_inverse
            threshold = math.sqrt(2 * u + 14 * math.log(2 + u))
            row = {"light": light, "heavy": heavy, "log_inverse_scale": log_inverse,
                   "sharp_penalty": predicted}
            for name, exponent in (("calibration", light), ("heavier", heavy)):
                row[name + "_risk_over_own_asymptotic_oracle"] = (
                    risk_over_epsilon_power(exponent, log_inverse, threshold)
                    / scaled_truncated_moment(exponent, log_inverse)
                )
            estimates.append(row)
        assert abs(estimates[-1]["calibration_risk_over_own_asymptotic_oracle"] - 1) < 0.02
        assert abs(estimates[-1]["heavier_risk_over_own_asymptotic_oracle"] / predicted - 1) < 0.02
    cauchy = [cauchy_information(10.0**-k) for k in (2, 3, 4, 5, 6, 7)]
    assert all(1 < v["asymptotic_ratio"] < 2 for v in cauchy)
    assert cauchy[-1]["asymptotic_ratio"] < cauchy[0]["asymptotic_ratio"]
    print(json.dumps({"pareto_threshold_risks": estimates, "cauchy_information": cauchy}, indent=2))


if __name__ == "__main__":
    main()
