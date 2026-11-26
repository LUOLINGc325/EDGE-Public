#!/usr/bin/env python3
"""Independent finite-state DP diagnostics for the logarithmic ball correction."""
import argparse,json,math
from pathlib import Path
import numpy as np

def marked_matrices(p,D):
    rho=1-2*p;g=math.sqrt(rho)/(1-2*D)
    a,b,c=(1+rho+2*g)/4,(1-rho)/4,(1+rho-2*g)/4
    if min(a,b,c)<=0:raise ValueError('Strict Gray interior required')
    return (np.array([[a,b],[b,c]]),np.array([[c,b],[b,a]]))

def ball_mass(x,p,D):
    k=math.floor(len(x)*D);C=marked_matrices(p,D)
    v=np.zeros((2,k+1));v[:,0]=.5
    for bit in x:
        new=C[int(bit)]@v
        if k:new[:,1:]+=C[1-int(bit)]@v[:,:-1]
        v=new
    return float(v.sum())

def sample_path(rng,n,p):
    x=np.empty(n,dtype=np.int8);x[0]=rng.integers(2)
    if n>1:x[1:]=x[0]^np.bitwise_xor.accumulate((rng.random(n-1)<p).astype(np.int8))
    return x

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--samples',type=int,default=80)
    args=ap.parse_args();rng=np.random.default_rng(20261125);rows=[]
    for p,D in [(0.2,0.005),(0.35,0.04),(4/9,0.1)]:
        Dc=(1-2*math.sqrt(1-2*p)/(2-2*p))/2
        assert 0<D<Dc
        h=-D*math.log(D)-(1-D)*math.log1p(-D)
        for n in [32,64,128,256]:
            gaps=[]
            for _ in range(args.samples):
                x=sample_path(rng,n,p);k=int(np.count_nonzero(x[1:]!=x[:-1]))
                info=math.log(2)-k*math.log(p)-(n-1-k)*math.log1p(-p)
                b=ball_mass(x,p,D)
                assert 0<b<=1+1e-12
                gap=-math.log(b)-(info-n*h)
                assert gap>=-1e-9, (p,D,n,gap)
                gaps.append(gap)
            rows.append({'p':p,'D':D,'n':n,'samples':args.samples,
                'gap_min_nats':min(gaps),'gap_median_nats':float(np.median(gaps)),
                'gap_max_nats':max(gaps),'log_n':math.log(n)})
    result={'seed':20261125,'method':'Marked hidden-state dynamic programming; no enumerated codebooks',
       'status':'passed','rows':rows,'scope':'Floating-point diagnostic; does not certify the asymptotic theorem or sharp third-order constant.'}
    path=Path(__file__).resolve().parents[1]/'results'/'ball_diagnostics.json'
    path.write_text(json.dumps(result,indent=2)+'\n');print(json.dumps(result,indent=2))

if __name__=='__main__':main()
