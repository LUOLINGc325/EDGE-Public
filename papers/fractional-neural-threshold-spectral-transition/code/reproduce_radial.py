#!/usr/bin/env python3
"""Finite spectral-count checks for atomic and mixed radial distributions.

No claim of numerical proof of equidistribution or asymptotic convergence is made.
The Gaussian component is computed using the independent finite-degree ridge
quadrature in reproduce.py, never replaced by its limiting coefficient.
"""
from __future__ import annotations

import json
import math
import platform
import warnings
from pathlib import Path

import matplotlib
matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np
import scipy
from scipy.integrate import IntegrationWarning, quad

from reproduce import chi_density, scaled_eigenvalue

ROOT = Path(__file__).resolve().parents[1]
PI2 = math.pi**2


def rational_cycle(a: int, b: int):
    assert 0 < a < b and math.gcd(a, b) == 1
    # Multiplication and reduction are integral. Exactly zero residues remain
    # exactly zero, rather than becoming spurious positive floating-point spectra.
    def coefficient(j):
        residue=(a*j)%b
        if residue == 0:
            return 0.0
        if b == 2:
            return 1/PI2
        if b == 3:
            return 3/(4*PI2)
        return math.sin(math.pi*residue/b)**2/PI2
    return np.array([coefficient(j) for j in range(b)])


def rational_count_periodic(t: float, a: int, b: int):
    cycle = rational_cycle(a,b)
    degrees = 0
    for residue in range(1,b):
        bound = math.sqrt(cycle[residue]/t)
        degrees += max(0,math.ceil((bound-residue)/b))
    # Degree zero is present, with multiplicity one.
    return 2*degrees + int((a/b)**2 > t)


def atomic_check(name: str, thresholds, *, a=None, b=None, alpha=None):
    rational = a is not None
    alpha = a/b if rational else float(alpha)
    c = -math.cos(math.pi*alpha)
    D = 2/(math.pi*b)/math.tan(math.pi/(2*b)) if rational else 4/PI2
    rows=[]
    for t in thresholds:
        last = math.ceil(1/(math.pi*math.sqrt(t)))
        degree = np.arange(1,last+1,dtype=np.int64)
        if rational:
            leading = rational_cycle(a,b)[degree%b]
            exact_zero_count = int(np.count_nonzero(degree%b==0))
        else:
            # Reducing before sine avoids large-argument trigonometric reduction.
            phase = np.remainder(degree*alpha,1.0)
            leading = np.sin(math.pi*phase)**2/PI2
            exact_zero_count = 0  # irrational theorem says none; no numerical zero test
        eigenvalues = leading / degree.astype(float)**2
        N = 2*int(np.count_nonzero(eigenvalues>t)) + int(alpha**2>t)
        periodic = rational_count_periodic(t,a,b) if rational else None
        rows.append({"t":t,"max_degree_evaluated":last,"count_including_degree_zero":N,
                     "sqrt_t_times_count":math.sqrt(t)*N,
                     "relative_error_to_D":(math.sqrt(t)*N-D)/D,
                     "t_times_count_squared":t*N*N,
                     "exact_zero_degrees_in_prefix":exact_zero_count,
                     "periodic_formula_count":periodic,
                     "periodic_count_matches":periodic==N if rational else None,
                     "omitted_tail_bound":"mu_l <= 1/(pi^2 l^2); l above the evaluated bound cannot exceed t"})
    return {"name":name,"radial_law":"delta_1","d":2,"p":0,
            "angle_fraction":f"{a}/{b}" if rational else name,
            "angle_fraction_double":alpha,"c":c,
            "D":D,"W":D*D,
            "rational":rational,"period_b":b,
            "wrong_average_first_W":2/PI2,
            "rows":rows}


def gaussian_zero_degree(c:float):
    # At positive c, every angular response is one for r<c.
    outside=1-math.exp(-c*c/2)
    inside,error=quad(lambda r:(math.acos(-c/r)/math.pi)**2*chi_density(r,2),
                      c,math.inf,epsabs=1e-12,epsrel=1e-12,limit=400)
    return outside+inside,error


def mixed_checks(thresholds, rhos):
    c=.5
    last=math.ceil(1/(math.pi*math.sqrt(min(thresholds))))
    degree=np.arange(1,last+1,dtype=np.int64)
    gaussian=np.zeros(last)
    gaussian_errors=np.zeros(last)
    for i,l in enumerate(degree):
        result=scaled_eigenvalue(int(l),0.,2,[c],[1.])
        gaussian[i]=result["eigenvalue"]
        gaussian_errors[i]=result["radial_quadrature_error_estimate"]/int(l)**2
    gzero,gzero_error=gaussian_zero_degree(c)
    # sin^2(2*pi*l/3) is exactly 0 or 3/4; no approximate sine is used.
    atom=np.where(degree%3==0,0.,3/(4*PI2))/degree.astype(float)**2
    result=[]
    for rho in rhos:
        base=(1-rho)*math.exp(-c*c/2)/(2*PI2)
        nonzero=base+3*rho/(4*PI2)
        D=2/3*(math.sqrt(base)+2*math.sqrt(nonzero))
        eigenvalues=(1-rho)*gaussian+rho*atom
        zero=(1-rho)*gzero+rho*4/9
        error_est=(1-rho)*gaussian_errors
        rows=[]
        for t in thresholds:
            N=2*int(np.count_nonzero(eigenvalues>t))+int(zero>t)
            rows.append({"t":t,"count_including_degree_zero":N,
                         "sqrt_t_times_count":math.sqrt(t)*N,
                         "relative_error_to_D":(math.sqrt(t)*N-D)/D,
                         "t_times_count_squared":t*N*N,
                         "degrees_with_threshold_margin_within_quadrature_estimate":
                            int(np.count_nonzero(np.abs(eigenvalues-t)<=error_est)),
                         "minimum_absolute_threshold_margin":float(np.min(np.abs(eigenvalues-t)))})
        result.append({"rho":rho,"radial_law":"(1-rho)*chi_2 + rho*delta_1",
                       "c":c,"d":2,"p":0,"period_b":3,
                       "base_coefficient":base,"nonzero_residue_coefficient":nonzero,
                       "D":D,"W":D*D,
                       "wrong_average_first_W":4*(base+rho/(2*PI2)),
                       "zero_degree_eigenvalue":zero,"rows":rows})
    raw={"degrees":degree.tolist(),"gaussian_eigenvalues":gaussian.tolist(),
         "gaussian_quadrature_error_estimates":gaussian_errors.tolist(),
         "atomic_eigenvalues":atom.tolist(),"gaussian_zero_degree":gzero,
         "gaussian_zero_degree_quadrature_error_estimate":gzero_error,
         "max_degree":last,
         "complete_count_cutoff_reason":"All mixture eigenvalues satisfy mu_l <= 1/(pi^2*l^2)."}
    return result,raw


def make_figure(report):
    (ROOT/"figures").mkdir(parents=True,exist_ok=True)
    plt.rcParams.update({"font.size":10,"axes.spines.top":False,
                         "axes.spines.right":False,"svg.fonttype":"none",
                         "svg.hashsalt":"radial-count-checks"})
    fig,axes=plt.subplots(1,2,figsize=(10.2,3.8),constrained_layout=True)
    ax=axes[0]
    for case,color,label in [(report["atomic_cases"][1],"#285C9E",r"$\theta/\pi=2/3$"),
                              (report["atomic_cases"][4],"#B9542D",r"$\theta/\pi=(\sqrt{5}-1)/2$")]:
        ax.plot([r["t"] for r in case["rows"]],[r["sqrt_t_times_count"] for r in case["rows"]],
                color=color,marker="o",markersize=4,label=label)
        ax.axhline(case["D"],color=color,linestyle="--",linewidth=1)
    ax.axhline(math.sqrt(2)/math.pi,color="#555555",linestyle=":",linewidth=1,
               label="Averaging before square root")
    ax.set_title("Unit-radius atomic law")
    ax=axes[1]
    for case,color in zip(report["mixed_cases"],["#285C9E","#578353","#B9542D"]):
        ax.plot([r["t"] for r in case["rows"]],[r["sqrt_t_times_count"] for r in case["rows"]],
                color=color,marker="o",markersize=4,label=rf"$\rho={case['rho']}$")
        ax.axhline(case["D"],color=color,linestyle="--",linewidth=1)
    ax.set_title(r"$(1-\rho)\chi_2+\rho\delta_1$, threshold $c=1/2$")
    for ax in axes:
        ax.set_xscale("log"); ax.invert_xaxis()
        ax.set_xlabel(r"Eigenvalue cutoff $t$")
        ax.set_ylabel(r"$\sqrt{t}\,N(t)$")
        ax.grid(alpha=.18)
        ax.legend(frameon=False,fontsize=8)
    fig.savefig(ROOT/"figures"/"radial_spectrum_checks.svg",metadata={"Date":None,
                "Description":"Finite spectral counts; dashed lines are analytic count constants. No extrapolation is fitted."})
    fig.savefig(ROOT/"figures"/"radial_spectrum_checks.png",dpi=180)
    plt.close(fig)


def main():
    thresholds=[10.**(-k) for k in range(3,13)]
    mixed_t=[1e-3,3e-4,1e-4,3e-5,1e-5,3e-6,1e-6,3e-7,1e-7]
    report={"kind":"finite_spectral_count_checks_not_proof",
            "normalization":"S^1 probability measure; positive spectrum with multiplicity 2 for every l>=1 and multiplicity 1 for l=0; N(t) counts eigenvalues strictly greater than t.",
            "versions":{"python":platform.python_version(),"numpy":np.__version__,
                        "scipy":scipy.__version__,"matplotlib":matplotlib.__version__},
            "warnings":[],"notes":[
                "The finite counts do not prove limiting equidistribution, Haar measure formulas, or asymptotic laws.",
                "Rational phase zeros use integer modular residues; irrational phases use double precision after reduction modulo one.",
                "Quadrature error estimates are numerical diagnostics, not rigorous interval enclosures."]}
    with warnings.catch_warnings(record=True) as caught:
        warnings.simplefilter("always",IntegrationWarning)
        report["atomic_cases"]=[
            atomic_check("rational_1_2",thresholds,a=1,b=2),
            atomic_check("rational_2_3",thresholds,a=2,b=3),
            atomic_check("rational_2_5",thresholds,a=2,b=5),
            atomic_check("rational_5_7",thresholds,a=5,b=7),
            atomic_check("golden_conjugate",thresholds,alpha=(math.sqrt(5)-1)/2),
            atomic_check("sqrt2_minus_one",thresholds,alpha=math.sqrt(2)-1)]
        report["mixed_cases"],report["mixed_raw_coefficients"]=mixed_checks(mixed_t,[.2,.5,.8])
        report["warnings"]=[str(w.message) for w in caught]
    report["finite_checks_pass"]=bool(
        all(row["periodic_count_matches"] for case in report["atomic_cases"] if case["rational"] for row in case["rows"])
        and all(abs(case["rows"][-1]["relative_error_to_D"])<2e-4 for case in report["atomic_cases"])
        and all(abs(case["rows"][-1]["relative_error_to_D"])<.01 for case in report["mixed_cases"])
        and not any(row["degrees_with_threshold_margin_within_quadrature_estimate"] for case in report["mixed_cases"] for row in case["rows"])
        and not report["warnings"])
    path=ROOT/"results"/"radial_checks.json"
    path.write_text(json.dumps(report,ensure_ascii=False,indent=2)+"\n")
    make_figure(report)
    print(json.dumps({"file":str(path),"finite_checks_pass":report["finite_checks_pass"],
                      "warnings":report["warnings"],"mixed_max_degree":report["mixed_raw_coefficients"]["max_degree"],
                      "atomic_final_relative_errors":{c["name"]:c["rows"][-1]["relative_error_to_D"] for c in report["atomic_cases"]},
                      "mixed_final_relative_errors":{str(c["rho"]):c["rows"][-1]["relative_error_to_D"] for c in report["mixed_cases"]}},indent=2))


if __name__=="__main__":
    main()
