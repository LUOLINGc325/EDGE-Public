"""Floating-point diagnostic of endpoint theorems; not a proof certificate."""
import json
import math
import numpy as np
from scipy.optimize import minimize_scalar
from scipy.special import gammaln, logsumexp, lambertw

def log_log1pexp(x):
    x=np.asarray(x,dtype=float)
    out=np.empty_like(x)
    low=x < -35
    high=x > 35
    mid=~(low|high)
    out[low]=x[low]
    out[high]=np.log(x[high])
    out[mid]=np.log(np.logaddexp(0,x[mid]))
    return out

def bscaled_gap(n,p,logb,U):
    # P=(1-p,p), Q=(p,1-p); p<1/2.
    M=math.log((1-p)/p)
    k=np.arange(n+1,dtype=float)
    logpmf=(gammaln(n+1)-gammaln(k+1)-gammaln(n-k+1)
            +(n-k)*math.log1p(-p)+k*math.log(p))
    loga=math.log(math.expm1(U)) if U<700 else U
    logr=(2*k-n)*M
    logpen=logb+log_log1pexp(loga+logr)
    penalty=np.exp(np.minimum(logpen,700))
    L=-float(logsumexp(logpmf-penalty))
    return L/U

def run():
    endpoint=[]
    for p in [.1,.25,.4]:
        M=math.log((1-p)/p); ell=-math.log1p(-p)
        for n in [100,1000,10000]:
            logb=n*M
            opt=minimize_scalar(lambda U:bscaled_gap(n,p,logb,U),bounds=(.01,2*math.log(n)+2),method='bounded',options={'xatol':1e-10})
            explicit=1+float(lambertw((n*ell-1)/math.e).real)
            predicted=n*ell/math.log(n)
            endpoint.append(dict(n=n,p=p,bgap=opt.fun,predicted=predicted,ratio=opt.fun/predicted,U=opt.x,U_over_logn=opt.x/math.log(n),explicit_U=explicit,explicit_bgap=bscaled_gap(n,p,logb,explicit)))
    superendpoint=[]
    p=.25; M=math.log(3); ell=-math.log(.75)
    for n in [10,20,40,80]:
        delta=.2; v=math.exp(n*delta); logb=n*(M+delta)
        U=math.sqrt(2*n*ell/v)
        ratio=bscaled_gap(n,p,logb,U)/v
        upper=U/2+math.expm1(U)/U
        superendpoint.append(dict(n=n,p=p,r=M+delta,U=U,actual_ratio=ratio,lower=1.,upper=upper))
    return {'kind':'floating_point_diagnostic_not_proof','endpoint':endpoint,'superendpoint':superendpoint}

if __name__=='__main__':
    print(json.dumps(run(),indent=2))
