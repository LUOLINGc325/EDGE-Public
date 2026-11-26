#!/usr/bin/env python3
"""Exact algebraic checks and outward rational bounds for Gamma deviance signs."""

from fractions import Fraction as F
from itertools import product
import json
import math

from conditional_gamma import branch_gap, log_evidence, null_high_probability


def log_bracket(value, terms=48):
    if value < 1:
        low, high = log_bracket(1/value, terms)
        return -high, -low
    z = (value-1)/(value+1)
    lower = sum(2*z**(2*j+1)/(2*j+1) for j in range(terms))
    remainder = 2*z**(2*terms+1)/((2*terms+1)*(1-z*z))
    return lower, lower+remainder


def plugin_expectation(k, fitted, relative_mean):
    denominator = 1 - F(fitted,k)*(1-1/relative_mean)
    if denominator <= 0:
        return None
    return relative_mean**(-fitted)*denominator**(-k)


def check_plugin():
    cases = 0
    for k,fitted,relative_mean in product(range(1,6), range(1,10), (F(1,2),F(3,4),F(1),F(3,2),F(2))):
        mean = plugin_expectation(k,fitted,relative_mean)
        if relative_mean == 1 or fitted == k:
            assert mean == 1
        elif fitted < k:
            assert 0 < mean < 1
        else:
            assert mean is None or mean > 1
        cases += 1
    assert plugin_expectation(1,100,F(2)) is None
    assert F(5,4)**50 > 20
    assert log_bracket(F(4))[0] > F(4,3)
    assert sum(F(4**j, math.factorial(j)) for j in range(4)) > 20
    assert F(4,9)-F(3,25) > F(3,10)
    training_lower = sum(F(-3,4)**j / math.factorial(j) for j in range(4))/2
    validation_lower = F(3,10)-F(3,10)**2/2
    assert training_lower == F(59,256)
    assert validation_lower == F(51,200)
    assert training_lower*validation_lower == F(3009,51200) > F(1,20)
    return cases


def check_signs():
    cases = 0
    worst_numeric_error = 0
    for ratio in (F(3,2), F(2), F(5,2), F(3), F(4), F(5), F(6)):
        gap_lower,gap_upper = log_bracket(ratio)
        assert 0 < gap_lower/(ratio-1) < gap_upper/(ratio-1) < 1
        assert ratio*gap_lower/(ratio-1) > 1
        p_lower,p_upper = 1/gap_upper-1/(ratio-1),1/gap_lower-1/(ratio-1)
        assert 0 < p_lower < p_upper < F(1,2)
        gap = (gap_lower+gap_upper)/2
        lower, upper = gap/(ratio-1), ratio*gap/(ratio-1)
        p = (1-lower)/gap
        assert (1-p)*lower+p*upper == 1
        assert ((1-p)*(lower-1)**2+p*(upper-1)**2) == (1-lower)*(upper-1)
        for root in (lower,upper):
            found = branch_gap(float(root))
            worst_numeric_error = max(worst_numeric_error, abs(found-float(gap)))
            assert abs(found-float(gap)) < 5e-14
            assert abs(null_high_probability(found)-float(p)) < 5e-14
            for slope in (-5.0,-0.25,0.0,0.25,5.0):
                exact_style = (slope*float(gap)*(root>1)
                               - math.log1p(float(p)*math.expm1(slope*float(gap))))
                approx = log_evidence(float(root),slope)
                assert abs(exact_style-approx) < 5e-14
                cases += 1
    return cases, worst_numeric_error


def check_bernoulli():
    cases = 0
    for p,truth,fit in product((F(1,10),F(1,3),F(1,2),F(2,3)),
                               (F(1,2),F(2,3),F(1),F(3,2),F(2)),
                               (F(2,3),F(1),F(3,2))):
        truth_prob = p*truth/(1-p+p*truth)
        fit_prob = p*fit/(1-p+p*fit)
        fitted_e = (1-fit_prob)/(1-p), fit_prob/p
        assert (1-p)*fitted_e[0]+p*fitted_e[1] == 1
        if truth == fit:
            continue
        kl_upper = (
            truth_prob * log_bracket(truth_prob/fit_prob)[1]
            + (1-truth_prob)*log_bracket((1-truth_prob)/(1-fit_prob))[1]
        )
        angle_lower = log_bracket(max(truth/fit,fit/truth))[0]
        assert kl_upper <= angle_lower**2/8
        cases += 1
    return cases


def main():
    sign_cases, gap_error = check_signs()
    print(json.dumps({
        "plug_in_gamma_moment_cases": check_plugin(),
        "rational_log_bracket_branch_and_evidence_checks":sign_cases,
        "bernoulli_log_power_regret_intervals":check_bernoulli(),
        "largest_numerical_branch_gap_error": gap_error,
        "size_counterexample":{
            "null": "Gamma(shape=1, rate=1)",
            "trained_shape":100,
            "alternative_mean_factor":2,
            "nominal_alpha":"1/20",
            "actual_size":"20^(-1/50)/4 > 1/5",
            "with_isotonic_train_and_random_alternative_size_lower_bound":"3009/51200 > 1/20"
        }
    },indent=2))


if __name__ == "__main__":
    main()
