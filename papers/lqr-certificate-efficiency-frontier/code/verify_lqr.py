#!/usr/bin/env python3
"""Exact checks and labelled diagnostics for the LQR certificate frontier.

This is a reproducibility check, not Lean and not a proof of the general theorem.
Includes a general scalar convexity identity, a certified one-parameter example,
and the two-unknown-parameter Fisher-realizable coefficient.
Run from this case directory: python code/verify_lqr.py --output results/lqr_checks.json
"""

from __future__ import annotations

import argparse
from dataclasses import dataclass
from datetime import datetime, timezone
from fractions import Fraction as F
from math import isqrt
from pathlib import Path
import json
import platform
import sys

import mpmath as mp
import sympy as sp


Q = F(4, 3)
K0 = F(-2, 3)


def fraction_text(x: F) -> str:
    return str(x.numerator) if x.denominator == 1 else f"{x.numerator}/{x.denominator}"


def approximate(x: F, digits: int = 30) -> str:
    return mp.nstr(mp.mpf(x.numerator) / x.denominator, digits)


@dataclass(frozen=True)
class Interval:
    lo: F
    hi: F

    def __post_init__(self) -> None:
        if self.lo > self.hi:
            raise ValueError("invalid interval")

    def __sub__(self, other: "Interval") -> "Interval":
        return Interval(self.lo - other.hi, self.hi - other.lo)


def sqrt_rational_enclosure(x: F, digits: int = 160) -> Interval:
    """A rigorous enclosure using integer square root; no floating arithmetic."""
    if x < 0:
        raise ValueError("negative radicand")
    denominator = 10**digits
    floor_scaled_square = (x.numerator * denominator**2) // x.denominator
    lower_integer = isqrt(floor_scaled_square)
    lo = F(lower_integer, denominator)
    hi = F(lower_integer + 1, denominator)
    assert lo * lo <= x <= hi * hi
    return Interval(lo, hi)


def riccati_enclosure(a: F) -> Interval:
    z = a * a + Q - 1
    root = sqrt_rational_enclosure(z * z + 4 * Q)
    return Interval((z + root.lo) / 2, (z + root.hi) / 2)


def cost(k: F, a: F) -> F:
    denominator = 1 - (a + k) ** 2
    if denominator <= 0:
        raise ValueError("closed loop is not Schur")
    return (Q + k * k) / denominator


def cost_k(k: F, a: F) -> F:
    closed = a + k
    denominator = 1 - closed * closed
    return 2 * k / denominator + 2 * closed * (Q + k * k) / denominator**2


def regret_enclosure(k: F, a: F) -> Interval:
    p = riccati_enclosure(a)
    c = cost(k, a)
    return Interval(c - p.hi, c - p.lo)


def endpoint_difference(k: F, rho: F) -> Interval:
    return regret_enclosure(k, 1 + rho) - regret_enclosure(k, 1 - rho)


def symbolic_derivatives() -> dict:
    a, k = sp.symbols("a k", real=True)
    q = sp.Rational(4, 3)
    z = a**2 + q - 1
    p = (z + sp.sqrt(z**2 + 4*q)) / 2
    gain = -a*p/(1+p)
    c = (q + k**2)/(1-(a+k)**2)
    nominal = {a: 1, k: sp.Rational(-2, 3)}
    hessian = sp.simplify(sp.diff(c, k, 2).subs(nominal))
    gain_prime = sp.simplify(sp.diff(gain, a).subs(a, 1))
    cubic = sp.simplify((sp.diff(c, a, 3).subs(nominal)
                        - sp.diff(p, a, 3).subs(a, 1))/6)
    got = {
        "P0": sp.simplify(p.subs(a, 1)),
        "K0": sp.simplify(gain.subs(a, 1)),
        "feedback_hessian": hessian,
        "gain_prime": gain_prime,
        "gain_second": sp.simplify(sp.diff(gain, a, 2).subs(a, 1)),
        "fixed_gain_regret_cubic": cubic,
        "quadratic_displacement": sp.simplify(cubic/(hessian*gain_prime)),
        "regret_aa_at_nominal": sp.simplify(sp.diff(c, a, 2).subs(nominal)
                                           - sp.diff(p, a, 2).subs(a, 1)),
    }
    expected = {
        "P0": sp.Integer(2), "K0": sp.Rational(-2,3),
        "feedback_hessian": sp.Rational(27,4),
        "gain_prime": sp.Rational(-5,6),
        "gain_second": sp.Rational(-19,48),
        "fixed_gain_regret_cubic": sp.Rational(1035,256),
        "quadratic_displacement": sp.Rational(-23,32),
        "regret_aa_at_nominal": sp.Rational(75,16),
    }
    assert got == expected
    # A second, independent algebraic identity proves scalar feedback convexity.
    f = a + k
    partial_fraction = -1 + (q+(a-1)**2)/(2*(1-f)) + (q+(a+1)**2)/(2*(1+f))
    assert sp.cancel(c-partial_fraction) == 0
    second_formula = (q+(a-1)**2)/(1-f)**3 + (q+(a+1)**2)/(1+f)**3
    assert sp.cancel(sp.diff(c,k,2)-second_formula) == 0
    # Derive the parameter-curvature formula without numerical differentiation.
    p_second_formula = 1 + z/sp.sqrt(z*z+4*q) + 8*q*a*a/(z*z+4*q)**sp.Rational(3,2)
    assert sp.simplify(sp.diff(p,a,2)-p_second_formula) == 0
    return {"results": {key: str(value) for key,value in got.items()},
            "exact_equalities_passed": len(expected)+3,
            "method": "SymPy exact symbolic differentiation and rational identities"}


def rectangle_certificate() -> dict:
    """Exact analytic bounds on a whole rectangle, not a grid test."""
    a_lo,a_hi = F(9,10),F(11,10)
    k_lo,k_hi = F(-4,5),F(-11,20)
    f_lo,f_hi = a_lo+k_lo,a_hi+k_hi
    assert 0 < f_lo <= f_hi < 1
    z_lo = a_lo*a_lo+Q-1
    squared_root_margin = z_lo*z_lo+4*Q-F(5,2)**2
    assert squared_root_margin > 0
    # P''=1+z/s+8Qa²/s³, 0<z/s<1 and s>5/2 on this rectangle.
    p_aa_upper = 2 + 8*Q*a_hi*a_hi/F(5,2)**3
    # C_aa=2(Q+k²)(1+3f²)/(1-f²)^3 >= 2(Q+k²).
    c_aa_lower = 2*(Q+k_hi*k_hi)
    gap = c_aa_lower-p_aa_upper
    assert gap == F(11141,25000) and gap > 0
    return {
        "a_interval": [fraction_text(a_lo),fraction_text(a_hi)],
        "k_interval": [fraction_text(k_lo),fraction_text(k_hi)],
        "closed_loop_interval": [fraction_text(f_lo),fraction_text(f_hi)],
        "riccati_sqrt_gt_5_over_2_squared_margin": fraction_text(squared_root_margin),
        "C_aa_lower_bound": fraction_text(c_aa_lower),
        "P_aa_upper_bound": fraction_text(p_aa_upper),
        "regret_aa_lower_bound": fraction_text(gap),
        "strict_parameter_convexity_on_entire_rectangle": True,
        "feedback_convexity": "Exact partial fractions give C_kk=(Q+(a-1)^2)/(1-a-k)^3+(Q+(a+1)^2)/(1+a+k)^3>0 throughout the Schur interval.",
        "method": "Analytic inequalities evaluated with fractions.Fraction"
    }


def certified_minimax(rho: F) -> dict:
    """Locate the equal-loss point numerically, then certify a rational bracket."""
    if not 0 < rho <= F(1,10):
        raise ValueError("rho out of certified rectangle range")
    rr = mp.mpf(rho.numerator)/rho.denominator
    qq = mp.mpf(4)/3
    def p(a):
        z=a*a+qq-1
        return (z+mp.sqrt(z*z+4*qq))/2
    def c(k,a):
        return (qq+k*k)/(1-(a+k)**2)
    def difference(k):
        return c(k,1+rr)-p(1+rr)-c(k,1-rr)+p(1-rr)
    seed = -mp.mpf(2)/3 - mp.mpf(23)/32*rr*rr
    root = mp.findroot(difference, (seed-rr**3,seed+rr**3), solver="secant",
                       tol=mp.mpf("1e-110"), maxsteps=100)
    center = F(mp.nstr(root,92))
    width = F(1,10**88)
    left,right = center-width,center+width
    assert F(-4,5) < left < right < F(-11,20)
    g_left,g_right = endpoint_difference(left,rho),endpoint_difference(right,rho)
    assert g_left.hi < 0 < g_right.lo
    # Each endpoint loss is strictly convex on the common stable interval.
    # Its gradient is increasing; these exact inequalities hold at every root
    # inside [left,right], so 0 lies in the max-envelope subdifferential there.
    lower_branch_gradient_upper = cost_k(right,1-rho)
    upper_branch_gradient_lower = cost_k(left,1+rho)
    assert lower_branch_gradient_upper < 0 < upper_branch_gradient_lower
    stable_bound = max(abs(1-rho+left),abs(1+rho+right))
    assert stable_bound < 1
    ratio_lo,ratio_hi=(left-K0)/(rho*rho),(right-K0)/(rho*rho)
    standard_shift_lo,standard_shift_hi=(left-K0)/rho,(right-K0)/rho
    row = {
        "rho": fraction_text(rho),
        "certified_gain_bracket": [fraction_text(left),fraction_text(right)],
        "gain_decimal": mp.nstr(root,40),
        "root_bracket_width": fraction_text(2*width),
        "endpoint_difference_at_left_upper": fraction_text(g_left.hi),
        "endpoint_difference_at_right_lower": fraction_text(g_right.lo),
        "left_difference_negative_exact": True,
        "right_difference_positive_exact": True,
        "minus_endpoint_gradient_upper": approximate(lower_branch_gradient_upper),
        "plus_endpoint_gradient_lower": approximate(upper_branch_gradient_lower),
        "opposite_gradient_signs_exact": True,
        "all_parameter_closed_loops_Schur_exact": True,
        "absolute_closed_loop_upper": approximate(stable_bound),
        "displacement_over_rho_squared": [approximate(ratio_lo,45),approximate(ratio_hi,45)],
        "target_quadratic_coefficient": "-23/32",
        "coefficient_error": mp.nstr((root+mp.mpf(2)/3)/rr**2+mp.mpf(23)/32,30),
        "critical_radius_N_equals_rho_minus_4": fraction_text(rho**-4),
        "critical_rootN_displacement": [approximate(ratio_lo),approximate(ratio_hi)],
        "standard_radius_N_equals_rho_minus_2": fraction_text(rho**-2),
        "standard_rootN_displacement": [approximate(standard_shift_lo),approximate(standard_shift_hi)],
        "global_scalar_minimax_certificate": True,
        "reason": "Exact root bracket and opposing endpoint gradients certify the unique global minimizer of their convex maximum; the analytic parameter-convexity rectangle shows the full interval maximum equals those endpoints there, while the endpoint maximum lower-bounds the full objective everywhere."
    }
    return row


def full_parameter_derivatives_and_diagnostics() -> dict:
    """Both a and b unknown: exact coefficient plus non-certifying diagnostics."""
    a,b,k,t=sp.symbols("a b k t",real=True)
    q=sp.Rational(4,3)
    z=a*a+b*b*q-1
    p=(z+sp.sqrt(z*z+4*b*b*q))/(2*b*b)
    gain=-b*a*p/(1+b*b*p)
    c=(q+k*k)/(1-(a+b*k)**2)
    loss=c-p
    at={a:1,b:1,k:sp.Rational(-2,3)}
    hessian=sp.simplify(sp.diff(c,k,2).subs(at))
    d=sp.Matrix([sp.simplify(sp.diff(gain,x).subs({a:1,b:1})) for x in (a,b)])
    d2=sp.simplify((d.T*d)[0])
    path=loss.subs({a:1+t*d[0],b:1+t*d[1],k:sp.Rational(-2,3)})
    cubic=sp.simplify(sp.diff(path,t,3).subs(t,0)/6)
    c2=sp.factor(cubic/(hessian*d2*d2))
    c_kww=sp.simplify(sum(d[i]*d[j]*sp.diff(c,k,x,y).subs(at)
                          for i,x in enumerate((a,b)) for j,y in enumerate((a,b))))
    c_kkw=sp.simplify(sum(d[i]*sp.diff(c,k,k,x).subs(at) for i,x in enumerate((a,b))))
    c_kkk=sp.simplify(sp.diff(c,k,3).subs(at))
    direct=sp.factor(-c_kww/(2*hessian*d2)-c_kkw/(2*hessian)-c_kkk*d2/(6*hessian))
    assert d==sp.Matrix([sp.Rational(-5,6),sp.Rational(1,3)])
    assert d2==sp.Rational(29,36)
    assert cubic==sp.Rational(-72529,18432)
    assert c2==direct==sp.Rational(-2501,2784)
    assert c_kww==sp.Rational(285,16)
    assert c_kkw==sp.Rational(-225,16)
    assert c_kkk==sp.Rational(243,16)
    # Each two-step independent trajectory starts with X1=0, Var(U)=Var(W)=1.
    fisher=sp.diag(1+1,2*1)
    assert fisher==2*sp.eye(2)
    symbolic={"gain_gradient":list(map(str,d)),"gradient_norm_squared":str(d2),
              "directional_cubic_along_gradient":str(cubic),
              "C_k_theta_theta_w_w":str(c_kww),"C_kk_theta_w":str(c_kkw),"C_kkk":str(c_kkk),
              "euclidean_radius_quadratic_shift":str(c2),
              "fisher_matrix":[["2","0"],["0","2"]],
              "fisher_radius_quadratic_shift":str(c2/2),
              "equalities_passed":9}
    ell=sp.lambdify((k,a,b),loss,"mpmath")
    ell_a=sp.lambdify((k,a,b),sp.diff(loss,a),"mpmath")
    ell_b=sp.lambdify((k,a,b),sp.diff(loss,b),"mpmath")
    ell_k=sp.lambdify((k,a,b),sp.diff(loss,k),"mpmath")
    phi0=mp.atan2(mp.mpf(1)/3,-mp.mpf(5)/6)
    k0=-mp.mpf(2)/3
    target=-mp.mpf(2501)/2784
    slope=mp.mpf(27)/4*mp.sqrt(mp.mpf(29)/36)
    rows=[]
    for denominator in (20,50,100,200):
        rho=mp.mpf(1)/denominator
        def value(kk,phi):
            return ell(kk,1+rho*mp.cos(phi),1+rho*mp.sin(phi))
        def angle_derivative(kk,phi):
            aa,bb=1+rho*mp.cos(phi),1+rho*mp.sin(phi)
            return rho*(-mp.sin(phi)*ell_a(kk,aa,bb)+mp.cos(phi)*ell_b(kk,aa,bb))
        def equations(phi_plus,phi_minus,coefficient):
            kk=k0+coefficient*rho*rho
            return (angle_derivative(kk,phi_plus)/rho**2,
                    angle_derivative(kk,phi_minus)/rho**2,
                    (value(kk,phi_plus)-value(kk,phi_minus))/rho**3)
        plus,minus,coefficient=mp.findroot(equations,(phi0,phi0+mp.pi,target),
                                          tol=mp.mpf("1e-100"),maxsteps=60)
        kk=k0+coefficient*rho*rho
        branch_values=[value(kk,plus),value(kk,minus)]
        curvature=[mp.diff(lambda ph:angle_derivative(kk,ph),ph) for ph in (plus,minus)]
        gradients=[ell_k(kk,1+rho*mp.cos(ph),1+rho*mp.sin(ph)) for ph in (plus,minus)]
        assert max(curvature)<0 and min(gradients)<0<max(gradients)
        grid_max=max(value(kk,2*mp.pi*j/512) for j in range(512))
        assert grid_max<=max(branch_values)+mp.mpf("1e-100")
        assert abs(1+kk)+rho*mp.sqrt(1+kk*kk)<1
        premium=[]
        for gamma in (mp.mpf("0.5"),mp.mpf(1)):
            adjusted=kk-gamma*target*rho*rho
            ap=mp.findroot(lambda ph:angle_derivative(adjusted,ph),plus,tol=mp.mpf("1e-100"))
            am=mp.findroot(lambda ph:angle_derivative(adjusted,ph),minus,tol=mp.mpf("1e-100"))
            extra=max(value(adjusted,ap),value(adjusted,am))-max(branch_values)
            premium.append({"correction_fraction":mp.nstr(gamma),
                            "premium_over_rho_cubed":mp.nstr(extra/rho**3,35),
                            "theoretical_limit":mp.nstr(slope*abs(gamma*target),35)})
        rows.append({"rho":f"1/{denominator}","gain":mp.nstr(kk,40),
                     "shift_over_rho_squared":mp.nstr(coefficient,40),
                     "coefficient_error":mp.nstr(coefficient-target,25),
                     "angular_second_derivatives_negative":True,
                     "outer_branch_derivatives_opposite":True,
                     "boundary_grid_nodes":512,
                     "grid_exceeds_candidate":False,
                     "all_disk_closed_loops_Schur":True,
                     "premium_diagnostics":premium,
                     "global_numeric_certificate":False})
    return {"symbolic":symbolic,"diagnostics":rows,
            "boundary": "The nine symbolic identities are exact. Circle optimizations and premium limits are high-precision diagnostics supported by the analytic two-branch proof, not interval global-max certificates."}


def main() -> None:
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output",type=Path,default=Path(__file__).with_name("lqr_checks.json"))
    args=parser.parse_args()
    mp.mp.dps=130
    symbolic=symbolic_derivatives()
    rectangle=rectangle_certificate()
    denominators=[10,20,50,100,200,500,1000,5000]
    rows=[certified_minimax(F(1,m)) for m in denominators]
    full_parameter=full_parameter_derivatives_and_diagnostics()
    aa,bb,kk,qq,rr,ww=sp.symbols('aa bb kk qq rr ww', real=True)
    scalar_cost=ww*(qq+rr*kk**2)/(1-(aa+bb*kk)**2)
    scalar_hessian=ww*((bb**2*qq+rr*(aa-1)**2)/(1-aa-bb*kk)**3
                      +(bb**2*qq+rr*(aa+1)**2)/(1+aa+bb*kk)**3)
    assert sp.cancel(sp.diff(scalar_cost,kk,2)-scalar_hessian)==0
    report={
        "case": "lqr-certificate-efficiency-frontier",
        "scope": "Exact finite scalar certificates plus asymptotic diagnostics; does not replace the proof for all full-matrix LQR systems.",
        "formalization": "No Lean source, kernel verification, or formalization execution.",
        "generated_at_utc": datetime.now(timezone.utc).isoformat(),
        "command": "python code/verify_lqr.py --output results/lqr_checks.json",
        "environment": {"python":sys.version,"platform":platform.platform(),
                        "sympy":sp.__version__,"mpmath":mp.__version__,"mpmath_decimal_precision":mp.mp.dps},
        "symbolic":symbolic,"whole_rectangle":rectangle,"minimax_rows":rows,
        "full_parameter":full_parameter,
        "general_scalar_convexity_identity":{"exact":True,"method":"Symbolic rational identity for arbitrary a,b,k,Q,R,W"},
        "summary":{"symbolic_equalities_passed":symbolic["exact_equalities_passed"]+full_parameter["symbolic"]["equalities_passed"]+1,
                   "certified_scalar_minimax_instances":len(rows),
                   "two_parameter_circle_diagnostics":len(full_parameter["diagnostics"]),
                   "exact_rational_checks_failed":0,
                   "continuous_interval_covered_per_instance":True,
                   "multidimensional_LQR_numerically_certified":False,
                   "last_displacement_over_rho_squared":rows[-1]["displacement_over_rho_squared"],
                   "last_standard_rootN_displacement":rows[-1]["standard_rootN_displacement"]}}
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(report,indent=2,ensure_ascii=False)+"\n",encoding="utf-8")
    print(json.dumps({"output":str(args.output),**report["summary"]},indent=2))


if __name__=="__main__":
    main()
