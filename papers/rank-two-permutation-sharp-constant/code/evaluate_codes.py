#!/usr/bin/env python3
"""Numerical reproduction of metric-grid codes; no claim of numerical proof.

The exact check program is separate. Numerical results use actual Bernoulli-sum
kernels, not a Gaussian replacement. Default workload is intentionally bounded.
"""
import json
from pathlib import Path
import numpy as np
from scipy.integrate import quad
from scipy.signal import fftconvolve
from scipy.stats import binom, norm


def length(a,b):
    return 2*(b-a)/(np.sqrt(a*(1-a))+np.sqrt(b*(1-b)))


def h(q,a,b):
    # Rationalized antiderivative remains stable when a+b is near 1.
    q=np.asarray(q)
    return 2*(q-a)/(np.sqrt(a*(1-a))+np.sqrt(a*b+(1-a-b)*q))


def inverse_h(t,a,b):
    # v(a) positive and v affine: the inverse is a quadratic polynomial.
    return a+np.sqrt(a*(1-a))*t+(1-a-b)*t*t/4


def make_types(n,m,a,b):
    if m==1: return np.array([0],dtype=int)
    qs=inverse_h(np.linspace(0,length(a,b),m),a,b)
    ws=np.rint(n*(qs-a)/(b-a)).astype(int)
    if len(np.unique(ws))!=m: raise ValueError('rounded codewords collide')
    return ws


def exact_count_float(n,w,a,b):
    lo=binom.pmf(np.arange(n-w+1),n-w,a)
    hi=binom.pmf(np.arange(w+1),w,b)
    p=fftconvolve(lo,hi)
    if np.min(p)<-1e-12: raise ArithmeticError('excessive negative convolution error')
    p=np.maximum(p,0); p/=p.sum()
    return p


def evaluate(n,m,a,b):
    types=make_types(n,m,a,b)
    means=np.sqrt(n)*h(a+(b-a)*types/n,a,b)
    observed=np.sqrt(n)*h(np.arange(n+1)/n,a,b)
    thresholds=(means[:-1]+means[1:])/2
    decisions=np.searchsorted(thresholds,observed,side='right')
    ps=np.array([exact_count_float(n,int(w),a,b) for w in types])
    errors=[1-float(ps[j,decisions==j].sum()) for j in range(m)]
    return {"n":n,"M":m,"types":types.tolist(),
            "max_error_metric_decoder":max(errors),
            "average_error_metric_decoder":float(np.mean(errors)),
            "optimal_average_error_for_this_code":1-float(ps.max(axis=0).sum())/m,
            "asymptotic_error_curve":0.0 if m==1 else float(2*norm.cdf(-length(a,b)*np.sqrt(n)/(2*m))),
            "finite_gaussian_average_error":0.0 if m==1 else float(2*(m-1)/m*norm.cdf(-length(a,b)*np.sqrt(n)/(2*(m-1))))}


def multivariate_length(p0,p1):
    p0=np.asarray(p0,dtype=float);p1=np.asarray(p1,dtype=float);v=p1-p0
    def root_j(theta):
        q=(1-theta)*p0+theta*p1
        fisher=np.sum(v*v/q)
        return np.sqrt(fisher/(1-theta*(1-theta)*fisher))
    value,error=quad(root_j,0,1,epsabs=1e-12,epsrel=1e-12)
    return value,error


def main():
    channels=[(.1,.9),(.05,.4),(.15,.93)]
    out=[]
    for a,b in channels:
        eps=.1; coefficient=length(a,b)/(2*norm.ppf(1-eps/2))
        rows=[]
        for n in [64,256,1024,4096]:
            predicted=max(2,int(np.floor(coefficient*np.sqrt(n))))
            candidates=[]
            for m in range(max(2,predicted-3),predicted+4):
                row=evaluate(n,m,a,b); candidates.append(row)
            feasible=[x for x in candidates if x['max_error_metric_decoder']<=eps]
            rows.append({"n":n,"predicted_coefficient":coefficient,
                         "best_feasible_grid_M_in_searched_window":max([x['M'] for x in feasible],default=None),
                         "candidates":candidates})
        out.append({"a":a,"b":b,"epsilon":eps,"L":length(a,b),"coefficient":coefficient,"rows":rows})
    families=[]
    for p0,p1 in [([.5,1/3,1/6],[1/6,1/3,.5]),([.1,.2,.3,.4],[.4,.3,.2,.1])]:
        val,err=multivariate_length(p0,p1)
        families.append({"p0":p0,"p1":p1,"L":val,"quadrature_error_estimate":err,
                         "coefficient_at_epsilon_point1":val/(2*norm.ppf(.95))})
    result={"binary_channels":out,"rank_two_examples":families,
            "numerical_scope":"double precision FFT kernels and quadrature; finite experiments only, not proofs"}
    path=Path(__file__).resolve().parents[1]/'results'/'numerical_codes.json'
    path.parent.mkdir(exist_ok=True);path.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({"status":"completed","channels":len(out),"blocklengths":[64,256,1024,4096],
                      "rank_two_examples":families},indent=2))


if __name__=='__main__': main()
