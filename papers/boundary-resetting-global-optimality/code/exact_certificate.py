#!/usr/bin/env python3
"""Exact rational checks for a bounded beta=2 improving perturbation.

This certificate checks finite polynomial algebra and a rigorous remainder bound.
It does not by itself certify the analytic global-optimality theorem.
Uses only the Python standard library.
"""
from fractions import Fraction as F
import argparse
import json
from pathlib import Path


def trim(p):
    p = list(map(F, p))
    while len(p) > 1 and p[-1] == 0:
        p.pop()
    return p


def add(p, q):
    z = [F(0)] * max(len(p), len(q))
    for i, v in enumerate(p): z[i] += v
    for i, v in enumerate(q): z[i] += v
    return trim(z)


def scale(p, c):
    return trim([F(c) * x for x in p])


def mul(p, q):
    z = [F(0)] * (len(p) + len(q) - 1)
    for i, a in enumerate(p):
        for j, b in enumerate(q): z[i+j] += a*b
    return trim(z)


def integral(p, a, b):
    a, b = F(a), F(b)
    return sum((v * (b**(i+1)-a**(i+1)) / (i+1)
                for i, v in enumerate(p)), F(0))


def weighted_tail(p):
    """Polynomial x -> integral_x^1 (t-x) p(t) dt."""
    out = [F(0)] * (len(p)+2)
    for k, v in enumerate(p):
        out[0] += v / (k+2)
        out[1] -= v / (k+1)
        out[k+2] += v / ((k+1)*(k+2))
    return trim(out)


def rational(x):
    return str(F(x))


def build_certificate():
    # P is the full symmetric target density restricted to positive positions.
    p = [F(3,4), F(0), F(-3,4)]
    normalization = 2*integral(p, 0, 1)
    m1half = integral(mul([0,1],p), 0, 1)
    tail = weighted_tail(p)
    mu = mul([0,F(1,2)], add(mul([1,1],tail),
                                  scale([1,-2,1], -m1half)))
    factored = scale(mul(mul([0,0,1],[1,-2,1]),[-1,3,1]), F(-1,32))
    assert normalization == 1
    assert mu == factored
    low, high = F(3,4), F(7,8)
    derivative = 2*integral(mu, low, high)
    assert derivative == F(-438807,1174405120)
    baseline = integral(mul([0,1,1], p), 0, 1)
    assert baseline == F(23,80)
    green_bound, perturbation_bound = F(9,8), F(2)
    operator_bound = green_bound*perturbation_bound
    epsilon = F(1,100000)
    contraction = epsilon*operator_bound
    assert contraction < 1
    remainder_constant = green_bound*operator_bound**2
    assert remainder_constant == F(729,128)
    remainder_bound = epsilon**2*remainder_constant/(1-contraction)
    first_order = epsilon*derivative
    cost_gap_upper_bound = first_order+remainder_bound
    assert cost_gap_upper_bound < 0
    return {
        'status':'passed',
        'arithmetic':'fractions.Fraction; no floating-point decisions',
        'scope':'polynomial identity, exact band derivative, and Neumann remainder certificate; analytic operator premises are proved in the manuscript',
        'density_full_positive_half_coefficients':list(map(rational,p)),
        'density_normalization':rational(normalization),
        'mu_coefficients_in_increasing_powers':list(map(rational,mu)),
        'mu_factorization':'-x^2 (1-x)^2 (x^2+3x-1)/32',
        'band':[rational(low),rational(high)],
        'band_convention':'r_epsilon(x)=epsilon for 3/4 <= |x| <= 7/8, and zero otherwise',
        'baseline_cost':rational(baseline),
        'first_variation':rational(derivative),
        'green_operator_sup_norm_bound':rational(green_bound),
        'K_operator_sup_norm_bound':rational(perturbation_bound),
        'GK_operator_sup_norm_bound':rational(operator_bound),
        'epsilon':rational(epsilon),
        'neumann_contraction_bound':rational(contraction),
        'second_order_constant':rational(remainder_constant),
        'first_order_cost_change':rational(first_order),
        'absolute_remainder_bound':rational(remainder_bound),
        'cost_change_strict_negative_upper_bound':rational(cost_gap_upper_bound),
        'certified_improvement_at_least':rational(-cost_gap_upper_bound),
        'decimal_orientation_only':{
            'first_variation':float(derivative),
            'first_order_cost_change':float(first_order),
            'absolute_remainder_bound':float(remainder_bound),
            'cost_change_upper_bound':float(cost_gap_upper_bound),
        },
        'checks':{
            'density_normalized':normalization==1,
            'mu_factorization_exact':mu==factored,
            'band_derivative_exact':derivative==F(-438807,1174405120),
            'baseline_exact':baseline==F(23,80),
            'neumann_contraction':contraction<1,
            'strict_improvement':cost_gap_upper_bound<0,
        },
    }


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output',type=Path)
    args=parser.parse_args()
    text=json.dumps(build_certificate(),indent=2,ensure_ascii=False)+'\n'
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(text,encoding='utf-8')
    print(text,end='')


if __name__=='__main__': main()
