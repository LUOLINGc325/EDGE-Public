#!/usr/bin/env python3
"""Exact algebraic checks for the single secondary research round.

Run from the case directory: python3 code/verify_secondary.py --local-only
These finite calculations do not prove minimax compactness or the full theorem.
"""
import argparse
import json
from itertools import product
from pathlib import Path
import sympy as s


def steep_face_identity():
    rho, beta, u = s.symbols('rho beta u', positive=True)
    alpha = (rho+beta)*u
    fourth_mu = 3*alpha*u/(rho+3*beta)
    mu2_m2 = alpha*u-(beta-1)*fourth_mu
    m2_squared = alpha**2-2*alpha*(beta-1)*u+(beta-1)**2*fourth_mu
    m4 = (rho+1)*((rho+2)*mu2_m2-m2_squared)
    target = -2*rho*(rho+2)*u**2*(beta-1)*(rho+beta)/(rho+3*beta)
    assert s.factor(m4-m2_squared-target) == 0
    example = target.subs({rho: 1, beta: 2, u: s.Rational(1, 3)})
    assert example == -s.Rational(2, 7)
    return {'expected_conditional_variance': str(target), 'steep_example_impossible_value': str(example)}


def flat_binary_posterior():
    low, high = (2-s.sqrt(2))/4, (2+s.sqrt(2))/4
    means = [s.sqrt(low), -s.sqrt(low), s.sqrt(high), -s.sqrt(high)]
    assert s.simplify(sum(m*m for m in means)/4-s.Rational(1, 2)) == 0
    assert s.simplify(sum(m**4 for m in means)/4-s.Rational(3, 8)) == 0
    count = 0
    for n in range(4):
        for history in product([-1, 1], repeat=n):
            # Expand before substituting radical means: only even moments survive.
            r = s.Symbol('r')
            likelihood = s.Poly(s.prod((1+r*y)/2 for y in history), r)
            moments = {0:s.Integer(1), 1:s.Integer(0), 2:s.Rational(1, 2),
                       3:s.Integer(0), 4:s.Rational(3, 8)}
            mass = sum(coeff*moments[power[0]] for power, coeff in likelihood.terms())
            numerator = sum(coeff*moments[power[0]+1] for power, coeff in likelihood.terms())
            assert s.simplify(numerator/mass-s.Rational(sum(history), n+1)) == 0
            count += 1
    return {'histories':count, 'value': '3/16', 'face_interval':'[(2-sqrt(2))/4,(2+sqrt(2))/4]'}


def multilinear_prior_recurrences():
    rho, beta, alpha = s.symbols('rho beta alpha', positive=True)
    moments = [s.Integer(1)]
    for k in range(12):
        moments.append(s.factor(moments[-1]*(2*k+1)*alpha/((2*k+1)*beta+rho)))
    for k in range(12):
        cross = (2*k+1)*alpha*moments[k]-((2*k+1)*beta+rho)*moments[k+1]
        assert s.cancel(cross) == 0
    r=s.Symbol('r', positive=True)
    t=s.Symbol('t', positive=True)
    derivative=s.diff((r*r-beta*t)/(t+r)**2,r)
    assert s.factor(derivative-2*t*(r+beta)/(t+r)**3) == 0
    return {'odd_orders_checked':list(range(1,24,2)), 'triangle_saddle_root_derivative':'2*t*(rho+beta)/(t+rho)^3'}


def narrow_face_certificate():
    x,v,z,eps = s.symbols('x v z eps', real=True)
    p=(z-s.Rational(1,4))*(s.Rational(3,4)-z)
    g0,g1=1-2*z,3*z-4*z*z
    assert s.expand(p+s.Rational(1,16)+g0/8-g1/4) == 0
    assert s.Rational(1,2)-s.Rational(3,8)-s.Rational(3,16) == -s.Rational(1,16)
    cross=(x-v)/32+(3*x*v-x*x)/16
    assert s.expand(cross.subs(v,1-x)-(p+s.Rational(1,16)).subs(z,x)/4) == 0
    a=s.Rational(3,4)+eps/8
    b=-eps/4
    risk=x/8+(a-1)**2*x+a*a*v/3+2*b*((a-1)*x*x+a*x*v)+b*b*(x+v)**3
    second=(x+v/3)/64-(x*x+x*v)/16+(x+v)**3/16
    assert s.expand(risk-(s.Rational(3,16)*(x+v)-2*eps*cross+eps**2*second)) == 0
    # Rectangle extrema of the linear partial derivatives.
    cx,cv=s.diff(cross,x),s.diff(cross,v)
    corners=[{x:i,v:j} for i in [0,s.Rational(3,4)] for j in [0,s.Rational(3,4)]]
    assert max(abs(cx.subs(c)) for c in corners)==s.Rational(11,64)
    assert max(abs(cv.subs(c)) for c in corners)==s.Rational(7,64)
    step=s.Rational(1,16)
    upper=s.Rational(3,16)-step/32+9*step**2/64
    assert upper == s.Rational(3049,16384)
    assert s.Rational(3,16)-upper == s.Rational(23,16384)
    assert s.Rational(3,16)-11*step/32>0
    return {'affine_value':'3/16','uniform_nonlinear_upper':str(upper),'gap':'23/16384',
            'estimator':'(97/128)*sample_mean-(1/64)*X1*X2*X3',
            'moment_localizer_expectation':'-1/16'}


def main():
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--local-only',action='store_true')
    args=parser.parse_args()
    if not args.local_only:
        parser.error('pass --local-only for offline verification')
    report={'status':'passed','arithmetic':'exact symbolic and rational',
            'steep_face':steep_face_identity(),'flat_face':flat_binary_posterior(),
            'multilinear_barrier':multilinear_prior_recurrences(),
            'narrow_face':narrow_face_certificate(),
            'limitation':'No numerical check establishes weak compactness, minimax exchange, or full-class optimality. Those require the written proof and independent review.'}
    out=Path(__file__).resolve().parents[1]/'results/secondary_certificate.json'
    out.parent.mkdir(parents=True,exist_ok=True)
    out.write_text(json.dumps(report,ensure_ascii=False,indent=2)+'\n')
    print(json.dumps(report,ensure_ascii=False,indent=2))


if __name__=='__main__':
    main()
