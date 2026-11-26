"""Rational certificates for the binary moment examples, without floating point."""

from fractions import Fraction as Q


def log_interval(ratio, terms=20):
    """Outward envelope for 2*atanh((ratio-1)/(ratio+1))."""
    assert ratio > 0
    scaled = (ratio - 1) / (ratio + 1)
    polynomial = 2 * sum(scaled**(2*i+1) / (2*i+1) for i in range(terms))
    error = 2 * abs(scaled)**(2*terms+1) / ((2*terms+1) * (1-scaled**2))
    return polynomial - error, polynomial + error


def bernoulli_kl_interval(p, q):
    left = log_interval(p / q)
    right = log_interval((1-p) / (1-q))
    return tuple(p*a+(1-p)*b for a, b in zip(left, right))


def budget(true_mean, error):
    variance = true_mean * (1-true_mean)
    eta = abs(error) / min(true_mean, 1-true_mean)
    return error**2 / (2 * variance * (1-eta))


def population_checks():
    count = 0
    for tau in (Q(1, 10), Q(1, 4), Q(1, 2), Q(3, 4), Q(9, 10)):
        for direction in (-1, 1):
            for scale in (16, 32, 64):
                error = direction * min(tau, 1-tau) / scale
                reported = tau + error
                if error > 0:
                    coverage = tau**2 / reported
                else:
                    coverage = tau - error*(1-tau)/(1-reported)
                assert (coverage-tau)*error < 0
                assert abs(coverage-tau+error) <= error**2 / min(tau, 1-tau)

                coverage_upper = bernoulli_kl_interval(coverage, tau)[1]
                projection_lower, projection_upper = bernoulli_kl_interval(tau, reported)
                assert coverage_upper <= projection_lower <= projection_upper <= budget(tau, error)
                count += 1
    print(f"exact_population_cases={count}")


def sample_checks():
    count = 0
    for n in (16, 32, 64):
        for first_cell in (n//2, 3*n//4):
            mean = Q(first_cell, n)
            for direction in (-1, 1):
                for alpha in (Q(1, 4), Q(1, 5)):
                    error = direction * min(mean, 1-mean)/16
                    reported = mean + error
                    level = Q(n+1, n)*(1-alpha)
                    assert 0 < level < 1
                    cdf = Q(0)
                    for index in range(n):
                        before = cdf
                        cdf += (reported / first_cell if index < first_cell
                                else (1-reported) / (n-first_cell))
                        if cdf >= level:
                            break
                    assert before < level <= cdf
                    empirical_left, empirical = Q(index, n), Q(index+1, n)
                    test_coverage = Q(index+1, n+1)
                    assert empirical - empirical_left == Q(1, n)
                    assert abs(test_coverage-empirical) <= Q(1, n+1)
                    projection_upper = bernoulli_kl_interval(mean, reported)[1]
                    assert projection_upper <= budget(mean, error)
                    if empirical < level:
                        assert bernoulli_kl_interval(empirical, level)[1] <= projection_upper
                    if empirical_left > level:
                        assert bernoulli_kl_interval(empirical_left, level)[1] <= projection_upper
                    count += 1
    print(f"exact_finite_calibration_cases={count}")


if __name__ == "__main__":
    population_checks()
    sample_checks()
    print("EXACT_RATIONAL_CHECKS_OK")
