#!/usr/bin/env python3
"""Reproduce quantitative examples for the analytic resetting theorem.

This is numerical evidence, not a proof or interval-arithmetic certificate.
Run from any directory: python3 code/verify.py
"""
from __future__ import annotations

import csv
import json
import math
from dataclasses import dataclass
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
from scipy.integrate import quad
from scipy.optimize import brentq
from scipy.special import erfcx

ROOT = Path(__file__).resolve().parents[1]
OUT = ROOT / "results"


@dataclass
class Target:
    """V(x)=beta*x^2+gamma*x^4, covering Gaussian and non-Gaussian tests."""
    beta: float
    gamma: float = 0.0

    def __post_init__(self):
        if self.beta < 0 or self.gamma < 0 or self.beta + self.gamma <= 0:
            raise ValueError("Require beta,gamma>=0 and beta+gamma>0")
        self.Z = 2 * quad(lambda x: math.exp(-self.V(x)), 0, np.inf,
                          epsabs=2e-12, epsrel=2e-12)[0]

    def V(self, x):
        return self.beta*x*x + self.gamma*x**4

    def dV(self, x):
        return 2*self.beta*x + 4*self.gamma*x**3

    def ddV(self, x):
        return 2*self.beta + 12*self.gamma*x*x

    def q(self, x):
        return math.exp(-self.V(x))/self.Z

    def h(self, x):
        return math.exp(-self.V(x)/2)/math.sqrt(self.Z)


class OptimalLaw:
    def __init__(self, target: Target, alpha: float = 1.0):
        if alpha <= 0:
            raise ValueError("alpha must be positive")
        self.t, self.alpha = target, alpha
        self.A = self.H(0)
        self.collapsed = self.A <= 1
        if self.collapsed:
            self.a, self.atom, self.c = 0.0, 0.5, None
            self.F = 4*self.A/(target.Z*alpha**2)
        else:
            hi = 1.0
            while target.dV(hi) < 2*alpha:
                hi *= 2
            b = brentq(lambda x: target.dV(x)-2*alpha, 0, hi, xtol=5e-15)
            self.a = brentq(lambda x: self.H(x)-1, 0, b, xtol=5e-15)
            h_a = target.h(self.a)
            inv_c = 2*quad(target.h, 0, self.a, epsabs=2e-12)[0]+2*h_a/alpha
            self.c = 1/inv_c
            self.atom = self.c*h_a*(alpha-target.dV(self.a)/2)/alpha**2
            self.F = inv_c**2

    def H(self, a):
        if self.t.gamma == 0:
            beta = self.t.beta
            return self.alpha*math.sqrt(math.pi)/(2*math.sqrt(beta))*float(
                erfcx((2*beta*a-self.alpha)/(2*math.sqrt(beta))))
        return self.alpha*quad(
            lambda u: math.exp(-self.t.V(a+u)+self.t.V(a)+self.alpha*u),
            0, np.inf, epsabs=2e-12, epsrel=2e-12)[0]

    def density(self, x):
        if self.collapsed or abs(x) > self.a:
            return 0.0
        a = self.alpha
        return self.c*self.t.h(x)*(1+self.t.ddV(x)/(2*a*a)-self.t.dV(x)**2/(4*a*a))

    def p(self, x):
        a = self.alpha
        if self.collapsed:
            return a/2*math.exp(-a*abs(x))
        if abs(x) <= self.a:
            return self.c*self.t.h(x)
        return self.c*self.t.h(self.a)*math.exp(-a*(abs(x)-self.a))

    def logp(self, x):
        if self.collapsed:
            return math.log(self.alpha/2)-self.alpha*abs(x)
        if abs(x) <= self.a:
            return math.log(self.c)-math.log(self.t.Z)/2-self.t.V(x)/2
        return (math.log(self.c)-math.log(self.t.Z)/2-self.t.V(self.a)/2
                -self.alpha*(abs(x)-self.a))

    def w(self, x):
        return math.exp(-self.t.V(x)-math.log(self.t.Z)-2*self.logp(x))

    def dual(self, z):
        """Direct kernel quadrature; do not substitute claimed constant plateau."""
        cuts = sorted(set([-self.a, 0.0, self.a, float(z)]))
        cuts = [-np.inf] + cuts + [np.inf]
        f = lambda x: self.alpha/2*math.exp(-self.alpha*abs(x-z))*self.w(x)
        return sum(quad(f, l, u, epsabs=1e-10, epsrel=2e-11)[0]
                   for l, u in zip(cuts[:-1], cuts[1:]))

    def convolved(self, x):
        if self.collapsed:
            return self.alpha/2*math.exp(-self.alpha*abs(x))
        kernel = lambda y: self.alpha/2*math.exp(-self.alpha*abs(x-y))
        pts = [x] if -self.a < x < self.a else None
        return (quad(lambda y: kernel(y)*self.density(y), -self.a, self.a,
                     points=pts, epsabs=1e-11, epsrel=1e-11)[0]
                + self.atom*(kernel(-self.a)+kernel(self.a)))


def run():
    OUT.mkdir(exist_ok=True)
    critical = brentq(lambda t: math.sqrt(math.pi)*t/2*erfcx(-t/2)-1, .01, 2,
                      xtol=5e-15)
    cases = [(b, 0.0) for b in (.1, .25, .5, 1., 2., 4.)]
    cases += [(0., .05), (0., 1.), (.2, .1), (1., 1.)]
    rows = []
    max_conv, max_plateau, max_violation, max_mass, max_obj = [0.0]*5
    for beta, gamma in cases:
        law = OptimalLaw(Target(beta, gamma))
        mass = (1.0 if law.collapsed else
                2*quad(law.density, 0, law.a, epsabs=1e-11)[0]+2*law.atom)
        obj = 2*quad(lambda x: math.exp(-law.t.V(x)-math.log(law.t.Z)-law.logp(x)),
                     0, np.inf, epsabs=1e-11, epsrel=1e-11)[0]
        xs = np.linspace(-max(2.0, law.a+2), max(2.0, law.a+2), 31)
        conv_err = max(abs(law.p(x)-law.convolved(x)) for x in xs)
        zs = np.unique(np.r_[np.linspace(-law.a, law.a, 9),
                            -law.a-np.linspace(.01, 3, 14),
                            law.a+np.linspace(.01, 3, 14)])
        dual = np.array([law.dual(z) for z in zs])
        plateau_err = max(abs(law.dual(float(z))-law.F)
                          for z in np.linspace(-law.a,law.a,9))
        violation = max(0.0,float(np.max(dual)-law.F))
        max_conv = max(max_conv,conv_err)
        max_plateau = max(max_plateau,plateau_err)
        max_violation = max(max_violation,violation)
        max_mass = max(max_mass,abs(mass-1))
        max_obj = max(max_obj,abs(obj-law.F))
        T0 = (2*law.A/law.t.Z)-1
        Topt = law.F/2-1
        rows.append(dict(beta=beta,gamma=gamma,A=law.A,a=law.a,
                         phase="point" if law.collapsed else "interval_plus_atoms",
                         atom_each=None if law.collapsed else law.atom,
                         central_mass=1.0 if law.collapsed else 0.0,
                         F=law.F,T_opt=Topt,T_origin=T0,
                         relative_time_reduction=1-Topt/T0,
                         convolution_abs_error=conv_err,dual_plateau_abs_error=plateau_err,
                         dual_max_positive_violation=violation,mass_error=abs(mass-1),
                         objective_abs_error=abs(obj-law.F)))
    assert max_conv < 2e-9
    assert max_plateau < 2e-8
    assert max_violation < 2e-8
    assert max_mass < 2e-10
    assert max_obj < 2e-8
    with (OUT/"examples.csv").open("w",newline="") as f:
        writer=csv.DictWriter(f,fieldnames=list(rows[0]));writer.writeheader();writer.writerows(rows)
    summary = dict(evidence="floating-point quadrature, not rigorous enclosures",
                   alpha=1, r=1, D=1, number_of_cases=len(cases),
                   gaussian_critical_alpha_over_sqrt_beta=critical,
                   gaussian_critical_alpha_times_sigma=critical/math.sqrt(2),
                   max_convolution_abs_error=max_conv,max_dual_plateau_abs_error=max_plateau,
                   max_dual_positive_violation=max_violation,max_mass_error=max_mass,
                   max_objective_abs_error=max_obj,all_checks_passed=True)
    (OUT/"verification.json").write_text(json.dumps(summary,indent=2)+"\n")
    draw_figures(critical)
    print(json.dumps(summary,indent=2))


def draw_figures(critical):
    plt.rcParams.update({"font.size":10,"axes.spines.top":False,"axes.spines.right":False,
                         "figure.dpi":160,"savefig.dpi":220})
    law=OptimalLaw(Target(.5))
    fig,axs=plt.subplots(1,2,figsize=(10,3.7),layout="constrained")
    xs=np.linspace(-3,3,700)
    axs[0].plot(xs,[law.t.q(x) for x in xs],color="#8b9bad",label="Target density q")
    axs[0].plot(xs,[law.p(x) for x in xs],color="#167d8d",label="Optimal stationary density p")
    axs[0].plot(xs,[law.density(x) for x in xs],color="#bc572a",label="Continuous reset density")
    axs[0].set(xlabel="Position x",ylabel="Probability density",title="Gaussian target: alpha = 1, sigma = 1")
    axs[0].legend(fontsize=8,loc="upper right")
    for endpoint in [-law.a,law.a]:
        axs[0].axvline(endpoint,alpha=.3,color="#bc572a",linestyle=":")
    axs[0].text(.02,.04,f"Plus atoms at x = +/- {law.a:.4f}\nMass {law.atom:.5f} at EACH endpoint",
                transform=axs[0].transAxes,fontsize=8,bbox=dict(fc="white",ec="#dddddd",alpha=.9))
    zs=np.r_[np.linspace(0,law.a,40),np.linspace(law.a+.001,3.5,80)]
    axs[1].plot(zs,[law.dual(float(z))/law.F for z in zs],color="#167d8d",lw=2)
    axs[1].axhline(1,color="#333333",ls="--",lw=.8)
    axs[1].axvline(law.a,color="#bc572a",ls=":",lw=1)
    axs[1].set(xlabel="Possible reset location z",ylabel="Global certificate G(z) / F*",
               title="Equality on support; strict inequality outside")
    fig.savefig(OUT/"optimal_law_and_certificate.png")
    fig.savefig(OUT/"optimal_law_and_certificate.pdf")
    plt.close(fig)
    ts=np.linspace(.15,2.5,170)
    laws=[OptimalLaw(Target(1.),float(t)) for t in ts]
    fig,axs=plt.subplots(1,2,figsize=(10,3.5),layout="constrained")
    axs[0].plot(ts,[l.a for l in laws],color="#167d8d",lw=2,label="Optimal half-width a sqrt(beta)")
    axs[0].plot(ts,ts,color="#9a9a9a",ls="--",label="Smooth-fit half-width")
    axs[0].axvline(critical,color="#bc572a",ls=":")
    axs[0].set(xlabel="alpha / sqrt(beta)",ylabel="Dimensionless half-width",title="Exact transition and support")
    axs[0].legend(fontsize=8)
    axs[1].plot(ts,[2*l.atom for l in laws],color="#bc572a",lw=2)
    axs[1].axvline(critical,color="#167d8d",ls=":")
    axs[1].set(xlabel="alpha / sqrt(beta)",ylabel="Total atomic mass",ylim=(-.03,1.03),
               title="Central atom splits into two endpoint atoms")
    fig.savefig(OUT/"gaussian_transition.png")
    fig.savefig(OUT/"gaussian_transition.pdf")
    plt.close(fig)


if __name__ == "__main__":
    run()
