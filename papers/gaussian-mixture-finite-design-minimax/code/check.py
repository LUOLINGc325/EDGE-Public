"""Exact small checks of mixed-moment recovery and signed gain cancellation."""

from fractions import Fraction as Q
from itertools import combinations
from math import comb, factorial


def even_normal_moment(order):
    """Return E[Z**(2*order)] for a standard Gaussian Z."""
    return factorial(2 * order) // (2 ** order * factorial(order))


def normal_moment(power, mean, variance):
    return sum(
        comb(power, 2 * j)
        * mean ** (power - 2 * j)
        * variance ** j
        * even_normal_moment(j)
        for j in range(power // 2 + 1)
    )


def paired_estimator_expectation(p, q, mean, variance, gain):
    lam = gain / 2
    result = Q(0)
    for j in range(p // 2 + 1):
        coef = Q(factorial(p), 2 ** j * factorial(j) * factorial(p - 2 * j))
        result += coef * (-lam) ** j * normal_moment(
            p - 2 * j, mean, lam * variance
        ) * variance ** (q + j)
    return result


def centered_uniform_moments(width, maximum_degree):
    return [
        Q(0) if degree % 2 else (width / 2) ** degree / (degree + 1)
        for degree in range(maximum_degree + 1)
    ]


def moments_of_sum(left, right):
    return [
        sum(comb(j, k) * left[k] * right[j - k] for k in range(j + 1))
        for j in range(len(left))
    ]


def box_spline_moments(count, width, shift, degree):
    result = [shift ** j for j in range(degree + 1)]
    uniform = centered_uniform_moments(width, degree)
    for _ in range(count):
        result = moments_of_sum(result, uniform)
    return result


def signed_moment(p, q, gain_list, location, variance):
    """Integrate mu**p * v**q against the signed measure in (6)."""
    k = len(gain_list)
    result = Q(0)
    for number_location in range(k + 1):
        number_variance = k - number_location
        location_degree = 2 * number_location
        if location_degree > p or number_variance > q:
            continue
        location_factor = factorial(p) // factorial(p - location_degree)
        variance_factor = factorial(q) // factorial(q - number_variance)
        for used in combinations(gain_list, number_location):
            coefficient = Q(1)
            for gain in used:
                coefficient *= gain / 2
            result += (
                (-1) ** number_variance
                * coefficient
                * location_factor
                * variance_factor
                * location[p - location_degree]
                * variance[q - number_variance]
            )
    return result


for mu, v, a in [(Q(-2, 3), Q(3, 2), Q(5, 4)), (Q(1), Q(2), Q(3, 4))]:
    for p in range(9):
        for q in range(9):
            assert paired_estimator_expectation(p, q, mu, v, a) == mu ** p * v ** q

gains = (Q(3, 4), Q(1), Q(5, 4))
k = len(gains)
location = box_spline_moments(2 * k, Q(1, k), Q(0), 18)
variance = box_spline_moments(k, Q(1, 3 * k), Q(7, 6), 18)


def response_moment(power, gain):
    return sum(
        comb(power, 2 * j) * gain ** j * even_normal_moment(j)
        * signed_moment(power - 2 * j, j, gains, location, variance)
        for j in range(power // 2 + 1)
    )


for a in gains:
    for degree in range(19):
        assert response_moment(degree, a) == 0

off_menu = Q(7, 8)
exact_difference = Q(factorial(2 * k))
for a in gains:
    exact_difference *= (a - off_menu) / 2
assert response_moment(2 * k, off_menu) == exact_difference != 0

within_pair_difference = (
    even_normal_moment(k) * (2 * gains[0]) ** k
    * signed_moment(0, k, gains, location, variance)
)
assert within_pair_difference == (
    (-1) ** k * factorial(k) * even_normal_moment(k) * (2 * gains[0]) ** k
) != 0
print("Verified exact paired recovery, listed and off-menu moments, and paired separation.")
