#!/usr/bin/env python3
"""Evaluate the proved single-root prescription; decimals are not interval certificates.

Requires mpmath. The analytic proof, not this program, certifies globality and
uniqueness. No floating-point grid is used to select a contact branch.
"""
from __future__ import annotations
import argparse
import json
from pathlib import Path
import mpmath as mp


def bisect_monotone(fn, left, right, increasing=True):
    sign = 1 if increasing else -1
    fl, fr = sign * fn(left), sign * fn(right)
    if not fl <= 0 <= fr:
        raise ArithmeticError(f"Unbracketed analytic branch: {fl}, {fr}")
    for _ in range(int(mp.mp.dps * 3.5) + 20):
        mid = (left + right) / 2
        if mid == left or mid == right:
            break
        if sign * fn(mid) < 0:
            left = mid
        else:
            right = mid
    return (left + right) / 2


def transition():
    def fn(q):
        return (2*q-1)*mp.log(2-1/q)-mp.log(mp.power(2,q)-1)
    q = bisect_monotone(fn, mp.mpf('1.5'), mp.mpf(2))
    return 2*q/(2*q-1)


def contact(p, k):
    x = (p-4*k)/(2*(p-2))
    r2 = x/k**2
    d = 1+r2*(1-2*k)
    t = (1-k)*mp.power(d/r2,(p-2)/2)
    b = p/(2*k)*mp.power(d,(p-2)/2)
    return x, mp.sqrt(r2), d, t, b


def endpoint(p, t):
    if p == 1:
        return t, mp.mpf(1)
    v = mp.power(t,1/(p-1))
    return mp.power(v/(1-v),p-1), 1/(1-v)


def evaluate(p_text):
    """Return mpmath data at a precision large enough for k close to one."""
    p0 = mp.mpf(str(p_text))
    if not mp.isfinite(p0) or p0 < 1:
        raise ValueError('A finite p >= 1 is required')
    with mp.workdps(max(80, int(2*p0)+50)):
        p = mp.mpf(str(p_text))
        ps = transition()
        if ps <= p <= 2:
            t, b = mp.power(2,-p/2), p
            return dict(p=p, regime='sqrt2_plateau', C=mp.sqrt(2), t=t,
                        b=b, x=mp.mpf('.5'), r=mp.sqrt(2), weight=mp.mpf(1),
                        p_star=ps, precision=mp.mp.dps)
        if 2 < p <= 4:
            t = mp.power(2,1-p)
            return dict(p=p, regime='endpoint_pair', C=mp.power(2,1-1/p),
                        t=t, b=mp.mpf(2), x=mp.mpf(0), r=mp.mpf(0),
                        endpoint_radius=mp.mpf(2), weight=mp.mpf('.5'),
                        p_star=ps, precision=mp.mp.dps)
        if p == 1:
            k = (3-mp.sqrt(3))/4
        else:
            if p < 2:
                lo, hi, inc = p/4, mp.mpf('.5'), False
            else:
                lo = p/4-mp.sqrt(p*(p-2)*(p-4)/(p+2))/4
                hi, inc = mp.mpf(1), True
            def log_residual(k):
                if p < 2 and k == p/4:
                    return mp.inf
                if p > 4 and k == 1:
                    return mp.inf
                x, r, d, t, b = contact(p,k)
                if t >= 1:
                    return -mp.inf  # outside the connected admissible interval
                if t <= 0:
                    return mp.inf
                v = mp.power(t,1/(p-1))
                log_e = (p-1)*(mp.log(v)-mp.log1p(-v))
                return mp.log(b/2)-log_e
            k = bisect_monotone(log_residual,lo,hi,increasing=inc)
        x,r,d,t,b = contact(p,k)
        e,r1 = endpoint(p,t)
        return dict(p=p,regime='low_outer' if p<2 else 'high_outer',
                    C=mp.power(t,-1/p),t=t,b=b,x=x,r=r,k=k,
                    endpoint_radius=r1,weight=1/(2*(1-x)),
                    root_residual=b/2-e,p_star=ps,precision=mp.mp.dps)


def serialize(row):
    return {k: (mp.nstr(v,55) if isinstance(v,mp.mpf) else v)
            for k,v in row.items()}


def finite_reference(row, dimension, replication=1):
    """Compressed exact integer orbit structure with numerical radii/costs."""
    d = int(dimension)
    if d < 4 or d % 2:
        raise ValueError('even dimension >= 4 required')
    with mp.workdps(row['precision']):
        p, x, r = row['p'], row['x'], row['r']
        if row['regime'] == 'sqrt2_plateau':
            ka,kb,A,B,N = d//2,d//2,1,0,d
            sd = mp.power(r,p)
            td = mp.power(r*r+1-2*r/mp.sqrt(2),p/2)
        elif row['regime'] == 'endpoint_pair':
            # Exact endpoint geometry; the zero-radius atom needs no support.
            ka,kb,A,B,N = 0,d,1,1,2
            sd,td = mp.power(2,p)/2,mp.mpf(1)
        else:
            ka,kb = max(1,int(mp.floor(d*x))),d
            A,B = kb-d//2,d//2-ka
            N=d*(A+B)
            w=mp.mpf(A)/(A+B)
            r1=row['endpoint_radius']
            sd=w*mp.power(r,p)+(1-w)*mp.power(r1,p)
            td=w*mp.power(r*r+1-2*r*mp.sqrt(mp.mpf(ka)/d),p/2)
            td+=(1-w)*mp.power(abs(r1-1),p)
        L=int(replication)
        # For endpoint-pair use L points at 2f and L+1 at zero, hence N=2.
        n=L*N+1
        ratio=mp.power(sd/(td+mp.mpf(1)/(L*N)),1/p)
        return dict(p=mp.nstr(p,20),dimension=d,replication=L,agents=n,
                    support_sizes=[ka,kb],orbit_multiplicities=[A,B],
                    median_zero_by_integer_incidence=True,
                    reference_ratio=mp.nstr(ratio,45),
                    C=mp.nstr(row['C'],45),gap=mp.nstr(row['C']-ratio,25),
                    ratio_is_lower_bound_on_true_ratio=True)


def main():
    ap=argparse.ArgumentParser()
    ap.add_argument('--p',nargs='*',default=['1','1.0001','1.05','1.2','1.4',
        '1.4407','1.4408','1.5','1.8','2','2.1','2.5','3','3.5','3.9','4',
        '4.0001','4.1','4.5','5','6','8','12','20','32','64','128'])
    ap.add_argument('--output',type=Path,required=True)
    args=ap.parse_args()
    rows=[evaluate(p) for p in args.p]
    witnesses=[]
    for row in rows:
        for d in [16,64,256,1024,4096]:
            L=d*d if row['regime']=='endpoint_pair' else 16
            witnesses.append(finite_reference(row,d,L))
    data=dict(method='high-precision bisection on proved unique branches',
        arithmetic='mpmath; numerical diagnostics, not certified intervals',
        p_star=serialize(rows[0])['p_star'],values=[serialize(x) for x in rows],
        finite_witnesses=witnesses,
        all_witness_ratios_below_claimed_bound=all(mp.mpf(x['gap'])>0 for x in witnesses),
        scope='All-p proof is in the manuscript. Numerical samples do not establish it.')
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(data,indent=2)+'\n')
    print(json.dumps(dict(values=len(rows),witnesses=len(witnesses),
        witness_gaps_positive=data['all_witness_ratios_below_claimed_bound'],
        p_star=data['p_star']),indent=2))


if __name__=='__main__':
    main()
