#!/usr/bin/env python3
"""Reproduce the delayed-cooling optimum using high-precision method of steps.

These calculations are checks and illustrations, not the mathematical proof.
All times and temperatures are dimensionless. No external data are needed.
"""
from __future__ import annotations

import argparse
import json
from pathlib import Path

import mpmath as mp


def bisect(fun, lo, hi, iterations=180):
    lo, hi = mp.mpf(lo), mp.mpf(hi)
    flo, fhi = fun(lo), fun(hi)
    if flo == 0:
        return lo
    if fhi == 0:
        return hi
    if flo * fhi >= 0:
        raise ValueError("Bisection requires a sign-changing bracket")
    for _ in range(iterations):
        mid = (lo + hi) / 2
        fm = fun(mid)
        if fm == 0:
            return mid
        if fm * flo > 0:
            lo, flo = mid, fm
        else:
            hi = mid
    return (lo + hi) / 2


class Cooling:
    def __init__(self, tau):
        self.tau = mp.mpf(tau)
        if not 0 < self.tau <= 1 / mp.e:
            raise ValueError("Expected 0 < tau <= 1/e")
        self.kappa = mp.re(-mp.lambertw(-self.tau) / self.tau)

    def r(self, t):
        """Fundamental kernel: zero prehistory, r(0)=1."""
        t = mp.mpf(t)
        if t < 0:
            return mp.mpf(0)
        n = int(mp.floor(t / self.tau))
        return mp.fsum([mp.mpf(1)] + [
            (-1)**j * (t-j*self.tau)**j / mp.factorial(j)
            for j in range(1, n+1)
        ])

    def E(self, t):
        """Step response with constant unit prehistory."""
        t = mp.mpf(t)
        if t <= 0:
            return mp.mpf(1)
        # Evaluate the independent method-of-steps polynomial for E.
        n = int(mp.floor(t / self.tau))
        return mp.fsum([mp.mpf(1)] + [
            (-1)**(j+1) * (t-j*self.tau)**(j+1) / mp.factorial(j+1)
            for j in range(n+1)
        ])

    def delta(self, t, w):
        return 2*self.E(t+w)-self.E(t)

    def optimum(self):
        """Solve balance and peak stationarity together, then validate."""
        w0 = mp.log(2)/self.kappa
        w1 = bisect(lambda w: self.E(w)-mp.mpf('0.5'), 0, 1)
        # The optimum is far from the limiting w0 endpoint. A multidimensional
        # high-precision root solve is subsequently checked against exact bounds.
        w_guess = w1-(w1-w0)/3
        t_guess = self.tau*mp.mpf('1.1')
        equations = lambda w,t: (
            self.delta(0,w)+self.delta(t,w),
            self.r(t)-2*self.r(t+w),
        )
        w, peak_time = mp.findroot(equations, (w_guess,t_guess),
                                  tol=mp.mpf('1e-60'), maxsteps=80)
        if not (w0 < w < w1 and peak_time > self.tau):
            raise AssertionError("Computed root lies outside proven admissible interval")
        crossing = bisect(lambda t:self.delta(t,w), 0, peak_time)
        magnitude = self.delta(0,w)
        checks = {
            'balance_residual': abs(magnitude+self.delta(peak_time,w)),
            'stationarity_residual': abs(self.r(peak_time)-2*self.r(peak_time+w)),
            'crossing_residual': abs(self.delta(crossing,w)),
            'peak_delay_identity_residual': abs(peak_time-crossing-self.tau),
            'kernel_tail_identity_residual': max(abs(self.E(t)-self.r(t+self.tau))
                for t in [0,self.tau/2,self.tau,2*self.tau,1,3]),
        }
        if max(checks.values()) > mp.mpf('1e-45'):
            raise AssertionError(checks)
        return dict(tau=self.tau, kappa=self.kappa, w0=w0, w1=w1,
                    waiting_time=w, crossing_time=crossing,
                    peak_time=peak_time, magnitude=magnitude,
                    checks=checks)


def as_strings(obj):
    if isinstance(obj, dict):
        return {k: as_strings(v) for k,v in obj.items()}
    if isinstance(obj, list):
        return [as_strings(v) for v in obj]
    if isinstance(obj, mp.mpf):
        return mp.nstr(obj, 55)
    return obj


def make_figure(model, record, destination):
    import numpy as np
    import matplotlib
    matplotlib.use('Agg')
    import matplotlib.pyplot as plt
    plt.rcParams.update({'font.family':'DejaVu Sans','font.size':10,
                         'axes.spines.top':False,'axes.spines.right':False})
    w=float(record['waiting_time']); peak=float(record['peak_time'])
    m=float(record['magnitude']); crossing=float(record['crossing_time'])
    ts=np.linspace(0,2.2,501)
    ya=np.array([float(model.E(mp.mpf(float(t))+record['waiting_time'])) for t in ts])
    yb=np.array([float(model.E(mp.mpf(float(t)))) for t in ts])-ya
    delta=ya-yb
    fig,axes=plt.subplots(1,2,figsize=(10.4,3.75),layout='constrained')
    axes[0].plot(ts,ya,color='#C35C3C',lw=2.4,label='A: initially hotter')
    axes[0].plot(ts,yb,color='#16688D',lw=2.4,label='B: initially cooler')
    axes[0].axvline(crossing,color='#999999',lw=1,ls=':')
    axes[0].set(xlabel='Time after the final quench',ylabel='Normalized temperature',
                title='Optimal preparation, delay = 0.36',ylim=(0,.6))
    axes[0].legend(frameon=False,loc='upper right')
    axes[1].plot(ts,delta,color='#244C55',lw=2.4)
    axes[1].axhline(0,color='#999999',lw=1)
    axes[1].axhline(m,color='#C35C3C',lw=1,ls='--')
    axes[1].axhline(-m,color='#16688D',lw=1,ls='--')
    axes[1].scatter([0,peak],[m,-m],color=['#C35C3C','#16688D'],s=35,zorder=5)
    axes[1].annotate(f'Balanced magnitude = {m:.8f}',xy=(peak,-m),
                     xytext=(.88,-.11),arrowprops=dict(arrowstyle='-',color='#666666'))
    axes[1].set(xlabel='Time after the final quench',ylabel='Temperature A - temperature B',
                title='Equal initial and reversed separations',ylim=(-.13,.13))
    fig.savefig(destination.with_suffix('.pdf'))
    fig.savefig(destination.with_suffix('.png'),dpi=180)
    plt.close(fig)


def main():
    parser=argparse.ArgumentParser()
    parser.add_argument('--output',type=Path,default=Path(__file__).parent)
    args=parser.parse_args()
    mp.mp.dps=85
    records=[]
    for tau in ['0.05','0.10','0.20','0.30','0.36',1/mp.e]:
        model=Cooling(tau)
        record=model.optimum()
        records.append(record)
        print('tau=',mp.nstr(record['tau'],12),
              'w*=',mp.nstr(record['waiting_time'],16),
              'M*=',mp.nstr(record['magnitude'],16),flush=True)
        if isinstance(tau,str) and tau=='0.36':
            selected_model,selected_record=model,record
    (args.output/'results').mkdir(parents=True,exist_ok=True)
    (args.output/'figures').mkdir(parents=True,exist_ok=True)
    payload={'precision_decimal_digits':mp.mp.dps,
             'status':'numerical corroboration, not interval-certified proof',
             'records':as_strings(records)}
    (args.output/'results'/'optima.json').write_text(json.dumps(payload,indent=2)+'\n')
    make_figure(selected_model,selected_record,args.output/'figures'/'optimal_cooling')


if __name__=='__main__':
    main()
