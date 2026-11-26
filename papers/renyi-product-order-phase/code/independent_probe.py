"""Independent floating-point checks; no claim of interval certification."""
import json
import math
from pathlib import Path

import numpy as np
from scipy.optimize import brentq, minimize_scalar
from scipy.special import gammaln, logsumexp, log_ndtr, lambertw


def log_expm1(u):
    return u + math.log1p(-math.exp(-u)) if u > 30 else math.log(math.expm1(u))


def grid_min(fun, lo, hi, points=1001):
    xs = np.linspace(lo, hi, points)
    vals = np.array([fun(float(x)) for x in xs])
    candidates = [(vals[0], xs[0]), (vals[-1], xs[-1])]
    for i in range(1, points - 1):
        if vals[i] <= vals[i - 1] and vals[i] <= vals[i + 1]:
            opt = minimize_scalar(fun, bounds=(xs[i - 1], xs[i + 1]), method="bounded", options={"xatol": 1e-12})
            candidates.append((opt.fun, opt.x))
    value, arg = min(candidates)
    return float(value), float(arg)


class BSC:
    def __init__(self, p):
        self.p = p
        self.M = math.log((1-p)/p)
        self.D = (1-2*p)*self.M
        self.sigma = 2*self.M*math.sqrt(p*(1-p))
        self.ell = -math.log1p(-p)

    def psi(self, theta):
        return float(logsumexp([math.log1p(-self.p)-theta*self.M, math.log(self.p)+theta*self.M]))

    def psi_prime(self, theta):
        den = self.psi(theta)
        tilted_plus = math.exp(math.log(self.p)+theta*self.M-den)
        return self.M*(2*tilted_plus-1)

    def exact_logL(self, n, logb, logU):
        U = math.exp(logU)
        loga = log_expm1(U)
        k = np.arange(n+1, dtype=float)
        logp = gammaln(n+1)-gammaln(k+1)-gammaln(n-k+1)+k*math.log(self.p)+(n-k)*math.log1p(-self.p)
        logx = loga + self.M*(2*k-n)
        loglog1pexp = np.empty_like(logx)
        small = logx < -35
        large = logx > 35
        middle = ~(small | large)
        loglog1pexp[small] = logx[small]
        loglog1pexp[large] = np.log(logx[large] + np.log1p(np.exp(-logx[large])))
        loglog1pexp[middle] = np.log(np.log1p(np.exp(logx[middle])))
        loglam = logb + loglog1pexp
        lam = np.exp(np.minimum(loglam, 709))
        logA = float(logsumexp(logp-lam))
        logdef = np.empty_like(lam)
        tiny = loglam < -35
        saturated = loglam > 6
        other = ~(tiny | saturated)
        logdef[tiny] = loglam[tiny]
        logdef[saturated] = 0
        logdef[other] = np.log(-np.expm1(-lam[other]))
        logB = float(logsumexp(logp+logdef))
        if logB < -35:
            return logB
        if logB < -math.log(2):
            return math.log(-math.log1p(-math.exp(logB)))
        return math.log(-logA)

    def exact_min(self, n, r, scale=0):
        val, logU = grid_min(lambda t: self.exact_logL(n,n*r,t)-t+scale, -15, math.log(3*n*self.M+10))
        return math.exp(val), math.exp(logU)

    def lattice_limit(self, r, n):
        theta = brentq(lambda t: self.psi_prime(t)+r,0,.5)
        sigma = math.sqrt(self.M*self.M-r*r)
        I = -theta*r-self.psi(theta)
        h = 2*self.M
        v = n*(-self.M+r) % h
        s = v + h*np.arange(-200,201)
        def logK(logU):
            U = math.exp(logU)
            x = log_expm1(U)+s
            lg = np.empty_like(x)
            small=x < -35
            large=x > 6
            other=~(small|large)
            lg[small]=x[small]
            lg[large]=0
            lg[other]=np.log(-np.expm1(-np.exp(x[other])))
            return math.log(h/(sigma*math.sqrt(2*math.pi)))+float(logsumexp(-theta*s+lg))-logU
        value, logU = grid_min(logK,-10,5)
        return math.exp(value), math.exp(logU), I, v


def main():
    ch=BSC(.1)
    data={"description":"Independent exact binomial sums and multi-start scalar optimization; floating-point checks only", "p":ch.p,"D":ch.D,"M":ch.M}
    low=[]
    r=ch.D/math.sqrt(2)
    for n in (31,62,127,256,511):
        limit,Ulim,I,v=ch.lattice_limit(r,n)
        actual,U=ch.exact_min(n,r,scale=n*I+.5*math.log(n))
        low.append({"n":n,"phase":v,"normalized_exact":actual,"phase_limit":limit,"ratio":actual/limit,"U_exact":U,"U_phase":Ulim})
    data["growing_lattice_rotating_phase"]={"r":r,"rows":low}
    high=[]
    r=(ch.D+ch.M)/2
    beta=brentq(lambda t: ch.psi(-t)/t-r,.00001,100)
    ustar=-ch.psi_prime(-beta)-r
    for n in (20,40,80,160,320):
        value,U=ch.exact_min(n,r)
        high.append({"n":n,"b_gap":value,"limit_beta":beta,"U_per_n":U/n,"limit_u":ustar})
    data["high_order_interior"]={"r":r,"rows":high}
    crit=[]
    tv,logt=grid_min(lambda l: math.log(-float(log_ndtr(-math.exp(l))))-l,-8,4)
    for n in (20,80,320,1280):
        value,U=ch.exact_min(n,ch.D,scale=math.log(ch.sigma)+.5*math.log(n))
        crit.append({"n":n,"normalized_gap":value,"limit_kappa":math.exp(tv),"U_over_sigma_sqrt_n":U/(ch.sigma*math.sqrt(n)),"limit_t":math.exp(logt)})
    data["critical_KL_window"]=crit
    endpoint=[]
    for n in (20,80,320,1280):
        value,U=ch.exact_min(n,ch.M)
        UL=1+float(lambertw((n*ch.ell-1)/math.e).real)
        endpoint.append({"n":n,"b_gap":value,"Lambert_value":math.exp(UL),"value_difference":math.exp(UL)-value,"U_difference":U-UL,"coarse_ratio":value*math.log(n)/(n*ch.ell)})
    data["endpoint_M"]=endpoint
    r=ch.M+.25
    sup=[]
    for n in (20,40,80,160):
        U=math.sqrt(2*n*ch.ell*math.exp(-n*(r-ch.M)))
        ratio=math.exp(ch.exact_logL(n,n*r,math.log(U))-math.log(U)-n*(r-ch.M))
        sup.append({"n":n,"candidate_gap_div_exp_minus_nM":ratio,"upper_bound":U/2+math.expm1(U)/U,"U_candidate":U})
    data["superendpoint"]={"r":r,"rows":sup}
    target=Path(__file__).resolve().parents[1] / "results" / "independent_probe.json"
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(json.dumps(data,ensure_ascii=False,indent=2)+"\n")
    print(json.dumps(data,ensure_ascii=False,indent=2))


if __name__ == "__main__":
    main()
