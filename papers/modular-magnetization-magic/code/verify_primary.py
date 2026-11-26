"""Independent Pauli-type and variational checks; not an asymptotic proof."""
from __future__ import annotations
import importlib.util
import json
import math
import platform
import random
from fractions import Fraction
from pathlib import Path
import mpmath as mp
from magic_resolution import (binary_entropy, binary_kl, coherent_density, dicke_density,
                              dicke_moment, effective_rate, leading_density,
                              moment_by_pauli_types, moment_filling, tilted_tau)

ROOT=Path(__file__).resolve().parents[1]
GRID_TOL=2e-11
DICKE_TOL=1e-10


def require_finite(label, *values):
    if not all(math.isfinite(value) for value in values):
        raise RuntimeError(("Non-finite numerical check", label))


def log_fraction(x):
    if x <= 0:
        raise RuntimeError("Cannot take the logarithm of a nonpositive exact moment.")
    value=math.log2(x.numerator)-math.log2(x.denominator)
    require_finite("log exact fraction", value)
    return value


def main():
    # This implementation groups Pauli strings by X/Y/Z/I counts. The independent
    # checker instead enumerates computational-basis Walsh transforms and columns.
    spec=importlib.util.spec_from_file_location("independent",ROOT/"code"/"verify_exact_independent.py")
    other=importlib.util.module_from_spec(spec)
    spec.loader.exec_module(other)
    rng=random.Random(20261124)
    exact=[]
    for N in range(1,9):
        cases=[]
        for K in sorted({1,2,max(1,N//2),N,N+1}):
            for r in sorted({0,min(K-1,N),min(K-1,N//3)}):
                for a,b in [(2,1),(1,1),(1,2)]:
                    weights=tuple(a**(N-n)*b**n if n%K==r else 0 for n in range(N+1))
                    if any(weights): cases.append((K,r,a,b,weights))
        for K,r,a,b,w in cases:
            grouped=moment_by_pauli_types(w)
            basis=[w[x.bit_count()] for x in range(2**N)]
            direct=other.moment_from_basis(basis)
            if grouped != direct:
                raise RuntimeError(("Pauli-type mismatch",N,K,r,a,b))
            sectors=[n for n in range(N+1) if w[n]]
            norm=sum(math.comb(N,n)*w[n]**2 for n in sectors)
            diagonal=sum(Fraction(math.comb(N,n)*w[n]**2,norm)**4*dicke_moment(N,n)
                         for n in sectors)
            if not diagonal <= grouped <= len(sectors)**7*diagonal:
                raise RuntimeError(("Exact sector inequality",N,K,r,a,b))
            exact.append({"N":N,"K":K,"r":r,"a":a,"b":b,
                          "W_numerator":str(grouped.numerator),"W_denominator":str(grouped.denominator)})
    grid_checks=0
    max_grid_error=0.0
    for _ in range(1200):
        N=rng.randint(1,1200);K=rng.randint(1,N+5);r=rng.randint(0,min(K-1,N));p=rng.uniform(0.001,0.999)
        val=leading_density(N,K,r,p)
        alln=list(range(r,N+1,K))
        full_moment=[effective_rate(n/N,p) for n in alln]
        full_norm=[binary_kl(n/N,p) for n in alln]
        require_finite("grid objectives", *full_moment, *full_norm, val["leading_density_bits"])
        full=min(full_moment)-4*min(full_norm)
        error=abs(full-val["leading_density_bits"])
        require_finite("grid candidate difference", full, error)
        if error>GRID_TOL:
            raise RuntimeError(("Grid candidate reduction",N,K,r,p))
        max_grid_error=max(max_grid_error,error)
        grid_checks+=1
    dicke_checks=[]
    for N in [28,32,40,48,64]:
        for n in sorted({0,1,2,N//8,N//4,N//2,N-2,N-1,N}):
            m=-log_fraction(dicke_moment(N,n)); ell=math.log2(N+1)
            E=N*binary_entropy(14/N)+14*math.log2(15)+16*ell
            target=N*dicke_density(n/N)
            require_finite("uniform Dicke bound", m, ell, E, target)
            if not target-4*ell-DICKE_TOL <= m <= target+E+DICKE_TOL:
                raise RuntimeError(("Uniform Dicke bound",N,n))
            dicke_checks.append({"N":N,"n":n,"M2":m,"leading":target})
    # High precision illustration, explicitly not a root isolation certificate.
    mp.mp.dps=80
    def h(x):
        if x in (0,1):return mp.mpf(0)
        return -x*mp.log(x,2)-(1-x)*mp.log(1-x,2)
    def alpha(f):
        b=7*(1-2*f)
        t=2*f/(b+mp.sqrt(b*b+4*f*(1-f)))
        return 4*h(f)-mp.log(1+14*t+t*t,2)+2*f*mp.log(t,2)
    p=mp.mpf(1)/4
    def D(f):return -h(f)-f*mp.log(p,2)-(1-f)*mp.log(1-p,2)
    critical=mp.findroot(lambda k:alpha(p+k)+4*D(p+k)-alpha(p),(mp.mpf('.10'),mp.mpf('.13')))
    residual=alpha(p+critical)+4*D(p+critical)-alpha(p)
    if not all(mp.isfinite(x) for x in [critical,residual,alpha(p),mp.log(mp.mpf(16)/13,2)]):
        raise RuntimeError("Non-finite high-precision illustration.")
    if not mp.mpf(3)/52<critical<mp.mpf(3)/4 or abs(residual)>mp.mpf('1e-60'):
        raise RuntimeError("High-precision root illustration failed its interval or residual check.")
    values={"p":"1/4","coherent_density":mp.nstr(mp.log(mp.mpf(16)/13,2),60),
            "dicke_density":mp.nstr(alpha(p),60),
            "density_gap":mp.nstr(alpha(p)-mp.log(mp.mpf(16)/13,2),60),
            "certified_gap_lower_bound":"log2(1024/999) > 0",
            "moment_filling":"4/13","critical_linear_modulus":mp.nstr(critical,60),
            "critical_value_status":"80-digit numerical illustration, not interval-certified",
            "critical_equation_absolute_residual":mp.nstr(abs(residual),10)}
    summary={"status":"PASS","all_checks_passed":True,"exact_cross_implementation_cases":len(exact),
             "grid_candidate_checks":grid_checks,"uniform_dicke_bound_checks":len(dicke_checks),
             "max_grid_candidate_error":max_grid_error,
             "tolerances":{"grid_candidate_absolute":GRID_TOL,"uniform_dicke_bound_absolute":DICKE_TOL,
                           "illustrative_root_absolute_residual":"1e-60"},
             "pass_criteria":"Exact Fraction equalities and inequalities are exact; every evaluated numeric objective is finite and checked with the declared tolerance. Explicit RuntimeError checks remain active under python -O.",
             "scope":"finite exact equalities and numerical falsification; general theorem is analytic",
             "python":platform.python_version(),"mpmath":mp.__version__}
    out={"summary":summary,"example_values":values,"exact":exact,"dicke_checks":dicke_checks}
    (ROOT/"results"/"primary_verification.json").write_text(json.dumps(out,indent=2,allow_nan=False)+"\n")
    print(json.dumps({"summary":summary,"example_values":values},indent=2))


if __name__=="__main__":main()
