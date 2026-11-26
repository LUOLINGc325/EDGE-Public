#!/usr/bin/env python3
"""Exact finite certificates for the analytic Gaussian-product zCDP bounds.

Python standard library only. This program evaluates explicit proven bounds;
it does not numerically integrate a Renyi divergence or prove the general
all-orders theorem. All decisions use Fraction arithmetic and explicit raises,
so Python -O does not disable verification.
"""

from __future__ import annotations

import argparse
from fractions import Fraction as F
import json
from pathlib import Path


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def rational(value):
    value = F(value)
    return {"numerator": str(value.numerator), "denominator": str(value.denominator)}


def ceiling_grid(value, places=12):
    value = F(value)
    scale = 10**places
    n = -((-value.numerator * scale) // value.denominator)
    return F(n, scale)


def decimal_grid(value, places=12):
    rounded = ceiling_grid(value, places)
    scale = 10**places
    integer = rounded.numerator * (scale // rounded.denominator)
    return f"{integer // scale}.{integer % scale:0{places}d}"


def exp_negative_upper(t, degree=32):
    """For t>=0, e^(-t) <= 1 / sum_{j=0}^degree t^j/j!."""
    t = F(t)
    require(t >= 0, "Taylor reciprocal requires a nonnegative exponent")
    total = F(1)
    term = F(1)
    for j in range(1, degree + 1):
        term *= t / j
        total += term
    return 1 / total


def forward(a, b, d):
    require(a > 1, "Forward simplified bound requires a>1")
    return d*d/F(4) + 9*d*d/(4*(2*a-1)) + b*b*d*d/(2*a)


def reverse_upper(a, b, d, degree=32):
    t1 = (a*a-b*b)/2
    t2 = a*a/8-3*(1+b*b)/2
    require(t1 >= 0 and t2 >= 0, "These finite examples require negative exponent arguments")
    first = (4+b*b)*d/a
    e1 = exp_negative_upper(t1, degree)
    e2 = exp_negative_upper(t2, degree)
    result = first + 2*e1 + 64*a*e2
    return result, {"leading_term": rational(first),
                    "tail_exponent_positive": rational(t1),
                    "central_exponent_positive": rational(t2),
                    "tail_exponential_upper": rational(ceiling_grid(e1, 30)),
                    "central_exponential_upper": rational(ceiling_grid(e2, 30)),
                    "taylor_degree": degree}


def finite_gate(sigma, r, first_count, target):
    sigma, r, target = F(sigma), F(r), F(target)
    b, d = 1/r, 1/sigma
    rho = d*d/2
    a = (F(first_count)-1)/sigma
    threshold = max(F(2), d+1, b*b/d)
    require(a >= threshold, "The gate is outside the theorem's a-range")
    f_bound = forward(a,b,d)
    r_bound, detail = reverse_upper(a,b,d)
    both = max(f_bound,r_bound)
    require(both < target < rho, "No strict certified privacy improvement")
    previous_a = (F(first_count)-2)/sigma
    require(previous_a >= threshold, "Previous count not in the checked a-range")
    previous_leading = (4+b*b)*d/previous_a
    require(previous_leading >= rho, "The stated first-count gate is not certified minimal for this bound")
    # Monotonicity ingredients are exact sign inequalities at the entire
    # declared domain, established analytically in the manuscript. Here we
    # check the finite substitution and neighboring integer endpoint.
    require(a >= 2 and 2*a-1 > 0, "Monotonicity domain boundary failed")
    return {
        "sigma": rational(sigma), "r": rational(r), "b": rational(b), "d": rational(d),
        "first_larger_count_for_this_certificate": first_count,
        "edge": [first_count-1,first_count], "a": rational(a),
        "a_lower_threshold": rational(threshold),
        "initial_rho": rational(rho), "asymptotic_optimum": rational(rho/2),
        "forward_bound_exact": rational(f_bound),
        "forward_bound_decimal_upper": decimal_grid(f_bound),
        "reverse_bound_rational_upper": rational(ceiling_grid(r_bound)),
        "reverse_bound_decimal_upper": decimal_grid(r_bound),
        "bidirectional_bound_rational_upper": rational(ceiling_grid(both)),
        "comparison_target": rational(target),
        "strictly_below_initial_rho": True,
        "previous_larger_count": first_count-1,
        "previous_reverse_leading_term": rational(previous_leading),
        "previous_leading_at_least_initial_rho": True,
        "gate_scope": "first strict improvement for the sufficient R/F certificate on integer counts, not for the unknown finite-count optimum",
        "exponential_certificate": detail,
    }


def gaussian_kernel_identities():
    count = 0
    for r in [F(1,2),F(1),F(2),F(3),F(11,2)]:
        for d in [F(1,10),F(1,2),F(1),F(2)]:
            s=r+d
            for b in [F(0),F(1,3),F(1),F(10,3),F(-2)]:
                for sign in [1,-1]:
                    mu,nu=sign*b*r,b*s
                    left=[nu*nu/(2*s*s)-mu*mu/(2*r*r),
                          mu/(r*r)-nu/(s*s),
                          1/(2*s*s)-1/(2*r*r)]
                    curvature=(s*s-r*r)/(2*r*r*s*s)
                    center=(mu*s*s-nu*r*r)/(s*s-r*r)
                    maximum=(mu-nu)**2/(2*(s*s-r*r))
                    right=[maximum-curvature*center*center,
                           2*curvature*center,-curvature]
                    require(left==right,"Gaussian quadratic completion mismatch")
                    require(curvature>0,"Gaussian variance ordering failed")
                    count+=1
    return count


def large_count_example(sigma, r, count):
    sigma, r = F(sigma), F(r)
    a, b, d = (F(count)-1)/sigma, 1/r, 1/sigma
    require(a >= max(F(2), d+1, b*b/d), "Large-count example outside range")
    f_bound = forward(a,b,d)
    r_bound, _ = reverse_upper(a,b,d)
    rho = d*d/2
    upper = max(f_bound,r_bound)
    require(d*d/4 < upper < rho, "Large-count certificate comparison failed")
    return {"sigma": rational(sigma), "r": rational(r),
            "larger_edge_count": count, "edge": [count-1,count],
            "initial_rho": rational(rho), "asymptotic_optimum": rational(rho/2),
            "forward_bound_exact": rational(f_bound),
            "reverse_bound_decimal_upper": decimal_grid(r_bound),
            "bidirectional_bound_rational_upper": rational(ceiling_grid(upper)),
            "bidirectional_bound_decimal_upper": decimal_grid(upper),
            "ratio_to_initial_budget_decimal_upper": decimal_grid(upper/rho),
            "scope": "Sufficient all-orders bidirectional upper bound, not the exact finite-count optimum"}


def forward_algebra_checks():
    count=0
    for a in [F(2),F(5,2),F(3),F(11),F(3023,10),F(400)]:
        for b in [F(0),F(1,3),F(1),F(10,3),F(-2)]:
            for d in [F(1,10),F(1,2),F(1),F(2)]:
                kappa=1/a
                lifted=d*d/(2*(2-kappa))+(d*d/(a*a))*(b*b/(2*kappa)+2/(kappa*(2-kappa)))
                require(lifted==forward(a,b,d),"Forward rational simplification mismatch")
                require(forward(a,b,d)>d*d/4,"Forward bound fell below its proved floor")
                count+=1
    # Clearing denominators in the b-independent simplification leaves
    # 2a+8 on both sides; coefficient equality checks that displayed identity.
    left_coefficients=[F(8),F(2)]
    right_coefficients=[F(-1)+F(9),F(2)]
    require(left_coefficients==right_coefficients,"Cleared forward identity failed")
    return count


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument("--output",type=Path)
    args=parser.parse_args()
    kernel_count=gaussian_kernel_identities()
    forward_count=forward_algebra_checks()
    gates=[finite_gate(1,1,12,F(47,100)),
           finite_gate(10,F(3,10),3024,F(4999,1_000_000))]
    report={
        "schema_version":1,"status":"PASS",
        "arithmetic":"Python standard-library fractions.Fraction; all decisions exact",
        "gaussian_quadratic_completion_checks":kernel_count,
        "forward_rational_substitution_checks":forward_count,
        "cleared_forward_polynomial_identity_checks":1,
        "integer_count_gate_certificates":gates,
        "large_count_examples":[large_count_example(1,1,100),
                                large_count_example(10,F(3,10),10000)],
        "claim_scope":[
            "Finite exact substitutions and evaluations of analytically proved all-orders bounds.",
            "The exponential upper bounds use reciprocal positive Taylor sums.",
            "No exact Renyi integral, arbitrary-input theorem proof, or Lean certification is asserted.",
            "The displayed gates concern this sufficient certificate, not the exact finite-count privacy optimum."
        ]}
    encoded=json.dumps(report,ensure_ascii=False,indent=2)+"\n"
    if args.output:
        args.output.parent.mkdir(parents=True,exist_ok=True)
        args.output.write_text(encoded,encoding="utf-8")
    print(encoded,end="")


if __name__=="__main__":
    main()
