"""Exact finite checks for the majority and Poisson-mixture proof identities."""
from fractions import Fraction
from itertools import product
from math import comb, factorial
import json


def majority(trials, probability):
    minority = 1 - probability
    result = sum(
        comb(trials, successes) * probability**successes * minority**(trials - successes)
        for successes in range(trials // 2 + 1, trials + 1)
    )
    if trials % 2 == 0:
        half = trials // 2
        result += Fraction(comb(trials, half), 2) * (probability * minority)**half
    return result


def alternative_pair_chi_square(count, theta):
    departure = Fraction(0)
    for labels in product(range(4), repeat=count):
        mixture_likelihood = sum(
            product_value(1 + (sign if label < 2 else -sign) * theta for label in labels)
            for sign in (-1, 1)
        ) / 2
        departure += (mixture_likelihood - 1)**2
    return departure / 4**count


def product_value(values):
    result = Fraction(1)
    for value in values:
        result *= value
    return result


def main():
    majority_checks = []
    for denominator in (2, 3, 5, 9):
        for numerator in range(denominator + 1):
            probability = Fraction(numerator, denominator)
            for even_trials in range(2, 22, 2):
                assert majority(even_trials, probability) == majority(even_trials - 1, probability)
                assert majority(even_trials, probability) + majority(even_trials, 1 - probability) == 1
                majority_checks.append((even_trials, probability))
    mixture_checks = []
    for count in range(6):
        for theta in (Fraction(1, 8), Fraction(1, 4), Fraction(1, 2)):
            exact = alternative_pair_chi_square(count, theta)
            formula = ((1 + theta**2)**count + (1 - theta**2)**count) / 2 - 1
            assert exact == formula
            assert 0 <= exact <= 2**count * theta**4
            if count <= 1:
                assert exact == 0
            mixture_checks.append((count, theta))

    tail_checks = []
    for denominator in (4, 5, 8, 16, 32, 64):
        eta = Fraction(1, denominator)
        x = 16 * eta**2
        # After the term of degree 2, each ratio is at most 1/3.
        bound = Fraction(3, 4) * x**2
        partial_sum = sum(x**power / factorial(power) for power in range(2, 13))
        assert partial_sum < bound
        assert bound == 192 * eta**4
        tail_checks.append(eta)

    result = {
        "majority_deletion_and_symmetry_pairs": len(majority_checks),
        "conditional_chi_square_enumerations": len(mixture_checks),
        "rational_exponential_tail_grid": len(tail_checks),
        "result": "passed",
        "scope": "Finite exact checks of auxiliary identities. Uniform inequalities are proved in the manuscript."
    }
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
