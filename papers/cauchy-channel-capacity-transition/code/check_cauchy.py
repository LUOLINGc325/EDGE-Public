#!/usr/bin/env python3
"""Independent, reproducible checks for the first Cauchy capacity transition.

Exact sections use fractions.Fraction and symbolic algebra.  The mpmath
sections are high precision diagnostics, not substitutes for analytic proofs.
The calculations check the identities and finite examples described in the manuscript.

Run: python check_cauchy.py > check_output.json
Dependencies: Python 3, SymPy, mpmath.
"""

from fractions import Fraction as F
import json
import platform

import mpmath as mp
import sympy as sy


def fracstr(x):
    return str(x.numerator) + "/" + str(x.denominator)


def decimal(x, digits=35):
    return mp.nstr(mp.mpf(x.numerator) / x.denominator, digits)


def rational_polynomial(coeffs, x):
    """Coefficients in descending order."""
    ans = F(0)
    for c in coeffs:
        ans = ans * x + c
    return ans


def log_bounds(r, n=4):
    """Exact bounds for log(r), r>1, using 2*atanh((r-1)/(r+1)).

    S_n = 2 sum_{j=0}^{n-1} z^(2j+1)/(2j+1).
    0 < log(r)-S_n <= 2 z^(2n+1)/((2n+1)(1-z^2)).
    This follows by bounding each remaining denominator below by 2n+1.
    """
    assert r > 1
    z = (r - 1) / (r + 1)
    assert 0 < z < 1
    low = 2 * sum((z ** (2 * j + 1) / (2 * j + 1) for j in range(n)), F(0))
    tail = 2 * z ** (2 * n + 1) / ((2 * n + 1) * (1 - z * z))
    return low, low + tail


def root_sign_certificate(s):
    ratio = 8 * s * (s + 1) / (s * s + 3) ** 2
    lo, hi = log_bounds(ratio)
    h = (s - 1) / (2 * s * s)
    lo -= h
    hi -= h
    return {
        "s": fracstr(s),
        "f_lower_exact": fracstr(lo),
        "f_upper_exact": fracstr(hi),
        "f_lower_decimal": decimal(lo),
        "f_upper_decimal": decimal(hi),
        "strict_sign": "positive" if lo > 0 else "negative" if hi < 0 else "unresolved",
    }


def exact_checks():
    left = F(1467, 1250)  # 1.1736
    right = F(11737, 10000)  # 1.1737
    cap = F(47, 40)
    low_cert = root_sign_certificate(left)
    high_cert = root_sign_certificate(right)
    assert low_cert["strict_sign"] == "positive"
    assert high_cert["strict_sign"] == "negative"
    assert 1 < left < right < cap
    B = rational_polynomial([-2, -2, 2, 10], cap)
    V = rational_polynomial([1, 2, 1, -4, -2], cap)
    Cleft = rational_polynomial([-6, -15, -12, 22, 18, 9], left)
    assert B > 0 and V < 0 and Cleft < 0
    # T(s)>0 on the certified root interval, by termwise interval enclosure.
    Tcoeffs = [2, 6, -2, -11, -19, 11, 15, 6]
    Tlo = sum((F(c) * (left if c >= 0 else right) ** (7-i)
               for i, c in enumerate(Tcoeffs)), F(0))
    Thi = sum((F(c) * (right if c >= 0 else left) ** (7-i)
               for i, c in enumerate(Tcoeffs)), F(0))
    assert Tlo > 0
    return {
        "root_bracket": [low_cert, high_cert],
        "analytic_interval_proofs": {
            "B_decreasing": "B'(s)=2-4s-6s^2 <= -8 for s>=1",
            "B_at_47_over_40": fracstr(B),
            "Q_at_p": "Q_s(s^2-1)=-8s V(s), V=s^4+2s^3+s^2-4s-2",
            "V_increasing": "V'(s)=4s^3+6s^2+2s-4 >= 8 for s>=1",
            "V_at_47_over_40": fracstr(V),
            "C_decreasing": "C'(1)=-64; C''(s)=44-72s-180s^2-120s^3 <= -328 for s>=1",
            "C_at_left_root_bound": fracstr(Cleft),
            "R_increasing": "R'(1)=30; R''(s)=48s^2+54s-4 >=98 for s>=1",
            "T_root_interval_lower_exact": fracstr(Tlo),
            "T_root_interval_upper_exact": fracstr(Thi),
            "T_root_interval_lower_decimal": decimal(Tlo),
            "T_root_interval_upper_decimal": decimal(Thi),
        },
    }


def symbolic_checks():
    s, t, y, a, u, v = sy.symbols("s t y a u v", positive=True)
    p = s*s - 1
    b = (s+1)**2
    N = t*t + (8-2*p)*t + (p+4)**2
    lam = 1 / (2*s*s*(s+1))
    Q = t*t + (10+2*s-2*s*s-2*s**3)*t + 9+18*s+22*s*s-12*s**3-15*s**4-6*s**5
    R = 4*s**4+9*s**3-2*s*s-9*s-6
    T = 2*s**7+6*s**6-2*s**5-11*s**4-19*s**3+11*s*s+15*s+6
    f = sy.log(8*s*(s+1)/(s*s+3)**2) - (s-1)/(2*s*s)
    fp = -(s-1)*R/(4*s**4*(s+1)*(s*s+3))
    records = []

    def check(name, expr):
        result = sy.factor(sy.together(expr))
        assert result == 0, (name, result)
        records.append({"identity": name, "reduced_difference": "0"})

    binq = ((1/(1+(y-a)**2)) + (1/(1+(y+a)**2)))/2
    check("binary_output_rational_form", binq - (y*y+1+a*a)/((y*y+1+a*a)**2-4*a*a*y*y))
    check("binary_mutual_information_exponential", (N/(4*(t+b))).subs(t,p) - 2*s/(s+1))
    check("binary_capacity_slope", sy.diff(sy.log(2*s/(s+1)),s)/(2*s) - lam)
    check("binary_gap_derivative_factorization", lam-sy.diff(N,t)/N+1/(t+b) - (t-p)*Q/(2*s*s*(s+1)*N*(t+b)))
    check("Q_evaluated_at_p", Q.subs(t,p) + 8*s*(s**4+2*s**3+s*s-4*s-2))
    check("f_prime_factorization", sy.diff(f,s)+(s-1)*R/(2*s**3*(s+1)*(s*s+3)))
    check("f_power_derivative", sy.diff(f,s)/(2*s)-fp)
    check("zero_power_gap_derivative", (lam-sy.diff(N,t)/N+1/(t+b)).subs(s,1) - t/(4*(t+4)))

    D = (y*y+1+a*a)**2-4*a*a*y*y
    ternaryq = u/(y*y+1) + (1-u)*(y*y+1+a*a)/D
    numerator = y**4+(2+a*a-3*u*a*a)*y*y+(1+a*a)*(1+u*a*a)
    check("three_atom_output_numerator", ternaryq - numerator/((y*y+1)*D))

    # Derivatives of alpha=r_1^2 and beta=r_2^2 at u=0.
    alphau, betau = v+4, -4*(v+1)
    check("root_sum_derivative", alphau+betau+3*v)
    check("root_product_derivative", alphau*(1+v)+betau-v*(1+v))
    check("k1_derivative", 2*alphau-2*(v+4))
    check("k2_derivative", ((1+s)/s)*betau.subs(v,p)+4*s*(s+1))
    du = -2*(p+4)/(t+4)+4*s*(s+1)/(t+b)
    check("density_u_at_outer_atom", du.subs(t,p))
    check("density_tu_at_outer_atom", sy.diff(du,t).subs(t,p) - (2/(p+4)-1/(s*(s+1))))
    A_u = du.subs(t,p)-du.subs(t,0)-p*sy.diff(du,t).subs(t,p)
    A_u_closed = (s-1)**3*(s+3)*(s*s+s+2)/(2*s*(s+1)*(s*s+3))
    check("Aeq_partial_u", A_u-A_u_closed)
    H_closed = (s-1)**2*T/(4*s**4*(s+1)*(s*s+3))
    check("fixed_power_H_u", A_u+p*fp-H_closed)
    check("kappa_formula", fp*fp/(2*H_closed)-R*R/(8*s**4*(s+1)*(s*s+3)*T))

    z = sy.symbols("z", nonnegative=True)
    den = (z+1+v)**2-4*v*z
    q = (z+1+v)/den
    qdot = v*v*(v*v-6*v*z+2*v+5*z*z-10*z+1)/((z+1)*den**2)
    check("fixed_power_output_velocity", 1/(z+1)-q+v*sy.diff(q,v)-qdot)
    return records


def polyadd(*polys):
    """Ascending-order coefficients."""
    out = [mp.mpf(0)] * max(map(len, polys))
    for poly in polys:
        for i, c in enumerate(poly):
            out[i] += c
    return out


def polymul(*polys):
    out = [mp.mpf(1)]
    for poly in polys:
        new = [mp.mpf(0)] * (len(out)+len(poly)-1)
        for i, a in enumerate(out):
            for j, b in enumerate(poly):
                new[i+j] += a*b
        out = new
    return out


def scale(c, poly):
    return [c*x for x in poly]


def density_params(u, v):
    aa = 2+v-3*u*v
    bb = (1+v)*(1+u*v)
    discriminant = aa*aa-4*bb
    assert discriminant > 0
    alpha = (aa-mp.sqrt(discriminant))/2
    beta = (aa+mp.sqrt(discriminant))/2
    assert 0 < alpha < beta
    return (1+mp.sqrt(alpha))**2, (1+mp.sqrt(beta))**2


def density(u, v, t):
    k1, k2 = density_params(u, v)
    nn = t*t+(8-2*v)*t+(v+4)**2
    return mp.log((t+4)*nn/(4*(t+k1)*(t+k2)))


def density_t(u, v, t):
    k1, k2 = density_params(u, v)
    nn = t*t+(8-2*v)*t+(v+4)**2
    return 1/(t+4)+(2*t+8-2*v)/nn-1/(t+k1)-1/(t+k2)


def H(p, u):
    v = p/(1-u)
    return density(u,v,v)-density(u,v,0)-v*density_t(u,v,v)


def J(p, u):
    v = p/(1-u)
    return u*density(u,v,0)+(1-u)*density(u,v,v)


def B(p):
    s = mp.sqrt(1+p)
    return mp.log(2*s/(s+1))


def critical_polynomial(u, v, lam):
    """Numerator of lambda-d_t in t.  All denominators are positive for t>=0."""
    k1,k2 = density_params(u,v)
    nn = [(v+4)**2, 8-2*v, mp.mpf(1)]
    nnprime = [8-2*v,mp.mpf(2)]
    l0 = [mp.mpf(4),mp.mpf(1)]
    l1 = [k1,mp.mpf(1)]
    l2 = [k2,mp.mpf(1)]
    return polyadd(scale(lam,polymul(l0,nn,l1,l2)),
                   scale(-1,polymul(nn,l1,l2)),
                   scale(-1,polymul(nnprime,l0,l1,l2)),
                   polymul(l0,nn,l2), polymul(l0,nn,l1))


def number(x):
    return mp.nstr(x, 82)


def numerical_checks():
    # Extra internal guard digits; print 82 digits so precision is explicit.
    mp.mp.dps = 110
    f = lambda s: mp.log(8*s*(s+1)/(s*s+3)**2)-(s-1)/(2*s*s)
    star = mp.findroot(f,(mp.mpf("1.1736"),mp.mpf("1.1737")))
    pstar = star*star-1
    R = 4*star**4+9*star**3-2*star**2-9*star-6
    T = 2*star**7+6*star**6-2*star**5-11*star**4-19*star**3+11*star**2+15*star+6
    fp = -(star-1)*R/(4*star**4*(star+1)*(star*star+3))
    hh = (star-1)**2*T/(4*star**4*(star+1)*(star*star+3))
    activation = -fp/hh
    kappa = fp*fp/(2*hh)
    assert abs(f(star)) < mp.mpf("1e-105")
    assert fp < 0 and hh > 0 and kappa > 0

    # Independent second-variation integral, using the actual fixed-power output velocity.
    def score_integrand(y):
        z = y*y
        dd = (z+1+pstar)**2-4*pstar*z
        q = (z+1+pstar)/dd
        qdot = pstar**2*(pstar**2-6*pstar*z+2*pstar+5*z*z-10*z+1)/((z+1)*dd**2)
        return qdot*qdot/(mp.pi*q)
    score = 2*mp.quad(score_integrand,[0,1,mp.inf])
    def binary_gap_t(t):
        s = star
        nn = t*t+(8-2*pstar)*t+(pstar+4)**2
        return 1/(2*s*s*(s+1))-(2*t+8-2*pstar)/nn+1/(t+(s+1)**2)
    curvature = mp.diff(binary_gap_t,pstar)
    h_integral = score+pstar*pstar*curvature
    assert curvature > 0 and score > 0
    assert abs(h_integral-hh) < mp.mpf("1e-95")
    assert abs(mp.diff(lambda u:J(pstar,u),0)+H(pstar,0)) < mp.mpf("1e-95")
    assert abs(mp.diff(lambda u:J(pstar,u),0,2)+hh) < mp.mpf("1e-95")

    constants = {
        "s_star":number(star),"p_star":number(pstar),
        "binary_capacity_at_star":number(B(pstar)),
        "f_power_derivative":number(fp),"H_star":number(hh),
        "center_mass_derivative":number(activation),"kappa":number(kappa),
        "capacity_second_derivative_jump":number(2*kappa),
        "binary_gap_t_derivative_at_zero":number(binary_gap_t(0)),
        "binary_gap_second_t_derivative_at_outer_contact":number(curvature),
        "score_integral":number(score),
        "score_plus_p_squared_gap_curvature":number(h_integral),
        "H_identity_absolute_error":number(abs(h_integral-hh)),
    }
    samples=[]
    for delta_string in ["0.000001","0.0001","0.001"]:
        delta=mp.mpf(delta_string)
        p=pstar+delta
        guess=activation*delta
        u=mp.findroot(lambda u:H(p,u),(guess/2,guess*mp.mpf("1.5")),solver="secant")
        v=p/(1-u)
        assert 0 < u < 1 and v > 0
        lam=density_t(u,v,v)
        assert lam>0
        g=lambda t:density(u,v,0)+lam*t-density(u,v,t)
        coeffs=critical_polynomial(u,v,lam)
        roots=mp.polyroots(list(reversed(coeffs)),maxsteps=2000,error=False,extraprec=200)
        assert len(roots)==5
        real_roots=sorted([mp.re(z) for z in roots if abs(mp.im(z))<mp.mpf("1e-80")])
        assert len(real_roots)==5  # Observed, sample-specific property, not assumed theorem.
        nonneg=[r for r in real_roots if r>=0]
        vals=[g(r) for r in nonneg]
        assert all(vv>=-mp.mpf("1e-85") for vv in vals)
        assert abs(g(v))<mp.mpf("1e-95")
        assert abs(H(p,u))<mp.mpf("1e-95")
        assert abs(mp.diff(lambda z:J(p,z),u)+H(p,u))<mp.mpf("1e-90")
        # Product reconstruction confirms that all roots of this degree-five
        # polynomial were numerically returned, not just selected stationary points.
        reconstructed=[mp.mpf(1)]
        for rr in roots:
            reconstructed=polymul(reconstructed,[-rr,mp.mpf(1)])
        reconstruction_error=max(abs(reconstructed[j]*coeffs[-1]-coeffs[j]) for j in range(6))
        assert reconstruction_error<mp.mpf("1e-85")
        residual=max(abs(mp.polyval(list(reversed(coeffs)),rr)) for rr in roots)
        samples.append({
            "delta":delta_string,"power":number(p),"center_mass":number(u),
            "outer_squared_amplitude":number(v),"lambda":number(lam),
            "polynomial_coefficients_ascending":[number(c) for c in coeffs],
            "all_five_real_roots":[number(r) for r in real_roots],
            "nonnegative_critical_points_and_gap":[{"t":number(r),"gap":number(g(r))} for r in nonneg],
            "boundary_gap_t_zero":number(g(0)),
            "outer_contact_gap":number(g(v)),
            "H_residual":number(H(p,u)),
            "maximum_polynomial_root_residual":number(residual),
            "coefficient_reconstruction_absolute_error":number(reconstruction_error),
            "capacity_minus_binary":number(J(p,u)-B(p)),
            "improvement_over_delta_squared":number((J(p,u)-B(p))/(delta*delta)),
            "center_mass_over_delta":number(u/delta),
        })

    # Negative controls: a known strictly negative binary gap must be detected.
    negatives=[]
    for power in [pstar+mp.mpf("0.0001"),mp.mpf("0.5"),mp.mpf("1")]:
        binary_gap_at_zero=f(mp.sqrt(1+power))
        direction=-binary_gap_at_zero
        assert binary_gap_at_zero<0 and direction>0
        # Verify an actual feasible positive-weight perturbation improves I.
        small_u=mp.mpf("1e-8")
        improvement=J(power,small_u)-B(power)
        assert improvement>0
        negatives.append({"power":number(power),"binary_gap_at_zero":number(binary_gap_at_zero),
                          "fixed_power_directional_improvement":number(direction),
                          "tested_center_mass":number(small_u),
                          "actual_mutual_information_improvement":number(improvement)})
    return {"precision_decimal_digits":mp.mp.dps,"constants":constants,
            "three_point_samples":samples,"negative_controls":negatives,
            "status":"PASS; floating-point diagnostics do not certify a nonzero branch radius"}


def main():
    mp.mp.dps=100
    report={"purpose":"Rational, symbolic, and high-precision checks for the Cauchy channel",
            "versions":{"python":platform.python_version(),"sympy":sy.__version__,"mpmath":mp.__version__},
            "exact_rational_certificates":exact_checks(),
            "symbolic_identities":symbolic_checks(),
            "high_precision_diagnostics":numerical_checks()}
    print(json.dumps(report,ensure_ascii=False,indent=2))


if __name__=="__main__":
    main()
