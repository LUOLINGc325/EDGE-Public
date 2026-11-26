#!/usr/bin/env python3
"""Independent density representations and Gaussian-lift cross-checks.

Floating-point diagnostics, not a proof of the general theorem. No Monte Carlo.
The two density routines integrate distinct coordinate representations.
"""
import json
import math
from pathlib import Path
import numpy as np
import scipy
from scipy.integrate import quad
from scipy.optimize import minimize_scalar
from scipy.special import logsumexp, k0e

LOG2PI = math.log(2*math.pi)


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def logcosh(x):
    return float(np.logaddexp(x,-x)-math.log(2))


def scaled_integral(logfun, lo, hi):
    # A grid avoids choosing a single stationary point in a multi-modal integral.
    grid = np.linspace(lo,hi,161)
    vals = np.array([logfun(t) for t in grid])
    j = int(np.argmax(vals))
    opt = minimize_scalar(lambda t:-logfun(t),
                          bounds=(grid[max(j-1,0)],grid[min(j+1,len(grid)-1)]),
                          method="bounded")
    offset = max(float(vals[j]),-float(opt.fun))
    value, error = quad(lambda t:math.exp(logfun(t)-offset),lo,hi,
                        epsabs=2e-12,epsrel=2e-12,limit=250,
                        points=[float(opt.x)])
    require(value > 0 and math.isfinite(value), "nonpositive quadrature")
    return math.log(value)+offset, error/value


def logdensity_rotated(y, a, b):
    """Use UV=(S^2-T^2)/2, then t=sqrt(2|y|) sinh(v)."""
    require(y != 0, "density has a logarithmic singularity at zero")
    sign, z = (1 if y > 0 else -1), abs(y)
    m, n = (a+sign*b)/math.sqrt(2), (a-sign*b)/math.sqrt(2)
    root = math.sqrt(2*z)
    cutoff = math.asinh((abs(m)+abs(n)+24)/root)
    def logfun(v):
        t = root*math.sinh(v)
        return -t*t+n*t+logcosh(m*root*math.cosh(v))
    integral, error = scaled_integral(logfun,-cutoff,cutoff)
    return -z-(a*a+b*b)/2-math.log(math.pi)+integral, error


def logdensity_conditioned(y, a, b):
    """Condition on U and integrate separately over U=+/- exp(v)."""
    require(y != 0, "density is singular at zero")
    z = abs(y)
    cutoff = max(2*math.sqrt(z),abs(a)+24,abs(b)+24)
    lo, hi = math.log(z/cutoff), math.log(cutoff)
    integrals, errors = [], []
    for sign in (-1,1):
        def logfun(v):
            u = sign*math.exp(v)
            return -((u-a)**2+(y/u-b)**2)/2
        value, error = scaled_integral(logfun,lo,hi)
        integrals.append(value)
        errors.append(error)
    return float(logsumexp(integrals))-LOG2PI,max(errors)


def gaussian_renyi_formula(mu, nu, variance, alpha):
    d = alpha*variance+1-alpha
    require(d>0,"Gaussian Renyi integral is infinite")
    return (alpha*(mu-nu)**2/(2*d)
            +(alpha*math.log(variance)-math.log(d))/(2*(alpha-1)))


def gaussian_renyi_direct(mu, nu, variance, alpha):
    # Integrate the powered densities in the original scalar coordinate.
    d = alpha*variance+1-alpha
    width = math.sqrt(variance/d)
    center = (alpha*mu-(alpha-1)*nu/variance)*variance/d
    def logfun(t):
        lp = -(t-mu)**2/2-LOG2PI/2
        lq = -(t-nu)**2/(2*variance)-(LOG2PI+math.log(variance))/2
        return alpha*lp+(1-alpha)*lq
    val,err=scaled_integral(logfun,center-14*width,center+14*width)
    return val/(alpha-1),err


def run():
    rows=[]
    max_difference=0.0
    max_centered_error=0.0
    for a,b in [(0,0),(1,2),(-1,.5),(2,2),(3,-2)]:
        for magnitude in (1e-6,.01,.25,1,9,100,10000):
            for sign in (-1,1):
                y=sign*magnitude
                lr,er=logdensity_rotated(y,a,b)
                lc,ec=logdensity_conditioned(y,a,b)
                difference=abs(lr-lc)
                max_difference=max(max_difference,difference)
                require(difference<2e-8,"density representations disagree")
                if a==0 and b==0:
                    exact=math.log(float(k0e(magnitude)))-magnitude-math.log(math.pi)
                    ce=abs(lr-exact)
                    max_centered_error=max(max_centered_error,ce)
                    require(ce<2e-8,"centered Bessel K0 check failed")
                if magnitude>=1:
                    shape=-magnitude+abs(a+sign*b)*math.sqrt(magnitude)-.5*math.log(magnitude)
                    penalty=(a*a+b*b)/2+abs(a)+abs(b)+3
                    require(shape-penalty-2e-8<=lr<=shape+2e-8,
                            "proved explicit density bounds violated")
                rows.append({"a":a,"b":b,"y":y,"logdensity_rotated":lr,
                             "logdensity_conditioned":lc,"absolute_log_difference":difference})
    gaussian=[]
    for alpha in (1.5,2,8,32):
        for scale in (1-1/(8*alpha),1+1/(8*alpha)):
            a,c,b=3,2.5,2
            left=gaussian_renyi_formula(a,c*scale,scale**2,alpha)
            right=gaussian_renyi_formula(b,b/scale,scale**-2,alpha)
            ln,en=gaussian_renyi_direct(a,c*scale,scale**2,alpha)
            rn,er=gaussian_renyi_direct(b,b/scale,scale**-2,alpha)
            require(abs(left-ln)<2e-9 and abs(right-rn)<2e-9,"Gaussian integral mismatch")
            d1,d2=1+alpha*(scale**2-1),1+alpha*(scale**-2-1)
            combined=((a-c*scale)**2/(2*d1)+b*b*(1-1/scale)**2/(2*d2)
                      -math.log(d1*d2)/(2*alpha*(alpha-1)))
            require(abs((left+right)/alpha-combined)<1e-10,"lift formula mismatch")
            gaussian.append({"alpha":alpha,"scale":scale,
                             "direct_joint_normalized_renyi":(ln+rn)/alpha,
                             "formula_joint_normalized_renyi":combined})
    return {"status":"PASS","kind":"floating-point deterministic cross-checks",
            "not_a_general_proof":True,"numpy":np.__version__,"scipy":scipy.__version__,
            "density_cases":len(rows),"gaussian_lift_cases":len(gaussian),
            "max_density_log_difference":max_difference,
            "max_centered_bessel_log_difference":max_centered_error,
            "density_results":rows,"gaussian_lift_results":gaussian}


if __name__=="__main__":
    result=run()
    path=Path(__file__).resolve().parents[1]/"results"/"numerical_crosscheck.json"
    path.write_text(json.dumps(result,indent=2)+"\n")
    print(json.dumps({k:v for k,v in result.items() if not k.endswith("results")},sort_keys=True))
