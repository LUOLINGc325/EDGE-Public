#!/usr/bin/env python3
"""Exact rational evaluations of proved analytic bounds; no quadrature.

This does not exactly evaluate a Renyi integral. The density inequalities and
Gaussian data-processing argument are proved in the accompanying manuscript.
Only the finite rational substitutions below are machine checked here.
"""
from fractions import Fraction as F
import json
from pathlib import Path


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def fraction_text(value):
    value = F(value)
    return f"{value.numerator}/{value.denominator}"


def high_order_limit(a, c, b):
    ds = [abs(a + s*b) - abs(c + s*b) for s in (1, -1)]
    return max(F(0), *ds)**2 / 4


def tail_certificate(a, c, b, alpha, sign=1):
    require(alpha > 1 and sign in (-1, 1), "invalid order or sign")
    penalty = (a*a + b*b)/2 + abs(a) + abs(b) + 3
    lp, lq = abs(a + sign*b), abs(c + sign*b)
    coefficient = lq + alpha*(lp-lq)
    require(coefficient >= 2, "the certified interval must lie in |y| >= 1")
    bound = max(F(0), (coefficient**2/4 - 1 - alpha*penalty)/(alpha*(alpha-1)))
    # Input Gaussian data processing is an independent analytic upper bound.
    require(bound <= (a-c)**2/2, "certificate exceeds Gaussian data processing")
    return {
        "a": fraction_text(a), "c": fraction_text(c), "b": fraction_text(b),
        "alpha": fraction_text(alpha), "tail_sign": sign,
        "A": fraction_text(penalty), "B": fraction_text(coefficient),
        "normalized_renyi_lower_bound": fraction_text(bound),
        "directed_high_order_limit": fraction_text(high_order_limit(a,c,b)),
    }


def rational_lift_bound(a, c, b, alpha, scale):
    """Bound D_alpha/alpha, replacing -log(D) by (1-D)/D."""
    require(alpha > 1 and scale > 0, "invalid order or scale")
    d1 = 1 + alpha*(scale**2 - 1)
    d2 = 1 + alpha*(1/scale**2 - 1)
    require(d1 > 0 and d2 > 0, "Gaussian lift is not integrable at this order")
    determinant = d1*d2
    require(determinant == 1-alpha*(alpha-1)*(scale-1/scale)**2,
            "determinant identity failed")
    require(0 < determinant <= 1, "invalid determinant")
    bound = ((a-c*scale)**2/(2*d1)
             + b*b*(1-1/scale)**2/(2*d2)
             + (scale-1/scale)**2/(2*determinant))
    return min((a-c)**2/2, bound)


def run():
    tails = []
    # This includes the original source's sigma=10, r=0.3, large-count setting.
    for sigma, relative in [(F(1),F(1)), (F(2),F(1,3)), (F(10),F(3,10))]:
        b = 1/relative
        for count in (0, 1, 100, 10000):
            a, c = F(count+1)/sigma, F(count)/sigma
            target = F(1)/(4*sigma*sigma)
            require(high_order_limit(a,c,b) == target, "upward limit identity")
            for order in (10**8, 10**10, 10**12):
                row = tail_certificate(a,c,b,F(order))
                row.update(count=count, sigma=fraction_text(sigma),
                           relative_noise=fraction_text(relative))
                tails.append(row)
    # Directional boundary checks: x=0, the kink x=sigma/r, and mid-edge crossing.
    directional = []
    for b in [F(1,2),F(1),F(2),F(10,3)]:
        for c in [F(0),F(1,4),F(1),F(3),F(10)]:
            h = F(1)
            up = high_order_limit(c+h,c,b)
            down = high_order_limit(c,c+h,b)
            require(up == F(1,4), "upward constant must equal 1/4")
            require(down == max(F(0),abs(c-b)-abs(c+h-b))**2/4,
                    "reverse boundary formula")
            directional.append({"count":fraction_text(c),"b":fraction_text(b),
                                "upward":fraction_text(up),"downward":fraction_text(down)})
    finite = []
    for b in [F(1,2),F(2),F(10,3)]:
        for count in (1000,10000,100000):
            c, a = F(count), F(count+1)
            for order in (2,8,32,128):
                alpha = F(order)
                up = rational_lift_bound(a,c,b,alpha,a/c)
                down = rational_lift_bound(c,a,b,alpha,c/a)
                upper = max(up,down)
                require(upper < F(1,4), "finite-order bound should fall below zCDP floor")
                finite.append({"count":count,"b":fraction_text(b),"alpha":order,
                               "upward_normalized_upper":fraction_text(up),
                               "downward_normalized_upper":fraction_text(down),
                               "both_directions_upper":fraction_text(upper),
                               "all_orders_floor":"1/4"})
    payload = {
        "kind":"exact rational substitution into analytically proved bounds",
        "not_an_exact_renyi_integral":True,
        "tail_certificates":tails,"directional_boundary_checks":directional,
        "finite_order_lift_certificates":finite,
        "counts":{"tail_certificates":len(tails),"directional_checks":len(directional),
                  "finite_order_certificates":len(finite)},
    }
    return payload


if __name__ == "__main__":
    result = run()
    target = Path(__file__).resolve().parents[1]/"results"/"exact_certificates.json"
    target.write_text(json.dumps(result,ensure_ascii=False,indent=2)+"\n")
    print(json.dumps({"status":"PASS",**result["counts"]},sort_keys=True))
