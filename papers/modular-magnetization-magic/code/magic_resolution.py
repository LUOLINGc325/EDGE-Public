"""Leading SRE density of a binomial state conditioned on excitation sectors.

The general theorem is an analytic proof in manuscript/manuscript.en.md.
This evaluator uses ordinary floating-point arithmetic, not interval certification.
All entropies use base-two logarithms. No state vector of size 2**N is constructed.
"""
from __future__ import annotations

import argparse
import json
import math
from functools import lru_cache
from fractions import Fraction


def binary_entropy(x: float) -> float:
    if not 0.0 <= x <= 1.0:
        raise ValueError("Filling must lie in [0,1].")
    if x in (0.0, 1.0):
        return 0.0
    return -x * math.log2(x) - (1-x) * math.log2(1-x)


def binary_kl(f: float, p: float) -> float:
    if not (0 <= f <= 1 and 0 < p < 1):
        raise ValueError("Need f in [0,1] and p in (0,1).")
    return -binary_entropy(f) - f*math.log2(p) - (1-f)*math.log2(1-p)


def tilted_tau(f: float) -> float:
    if not 0 < f < 1:
        raise ValueError("The finite tilt requires 0 < f < 1.")
    if f > 0.5:
        return 1 / tilted_tau(1-f)
    b = 7 * (1-2*f)
    return 2*f / (b + math.sqrt(b*b + 4*f*(1-f)))


def dicke_density(f: float) -> float:
    if not 0 <= f <= 1:
        raise ValueError("Filling must lie in [0,1].")
    if f in (0.0, 1.0):
        return 0.0
    # Reflection avoids very large tilts near one.
    if f > 0.5:
        return dicke_density(1-f)
    t = tilted_tau(f)
    H = math.log2(1+14*t+t*t) - 2*f*math.log2(t)
    return 4*binary_entropy(f)-H


def coherent_density(p: float) -> float:
    if not 0 <= p <= 1:
        raise ValueError("Latitude must lie in [0,1].")
    q = p*(1-p)
    return -math.log2(1-4*q+16*q*q)


def moment_filling(p: float) -> float:
    """Unique minimizer of alpha(f)+4 D(f||p)."""
    if not 0 < p < 1:
        raise ValueError("Need p in (0,1).")
    a = 1-p
    return (7*p*p*a*a+p**4)/(a**4+14*p*p*a*a+p**4)


def effective_rate(f: float, p: float) -> float:
    return dicke_density(f)+4*binary_kl(f,p)


def nearby_indices(target: float, N: int, K: int, r: int) -> list[int]:
    last = (N-r)//K
    u = (N*target-r)/K
    return sorted({max(0,min(last,j)) for j in (math.floor(u),math.ceil(u))})


def leading_density(N: int, K: int, r: int, p: float) -> dict:
    if N < 1 or K < 1 or not 0 < p < 1:
        raise ValueError("Need N,K positive and 0<p<1.")
    r %= K
    if r > N:
        raise ValueError("The conditioning event has no accessible number sector.")
    moment_candidates = [r+j*K for j in nearby_indices(moment_filling(p),N,K,r)]
    norm_candidates = [r+j*K for j in nearby_indices(p,N,K,r)]
    nm = min(moment_candidates,key=lambda n:effective_rate(n/N,p))
    nz = min(norm_candidates,key=lambda n:binary_kl(n/N,p))
    V = effective_rate(nm/N,p)-4*binary_kl(nz/N,p)
    result = {"N":N,"K":K,"r":r,"p":p,"sector_count":(N-r)//K+1,
              "leading_density_bits":V,"moment_sector":nm,"normalization_sector":nz,
              "moment_candidates":moment_candidates,"normalization_candidates":norm_candidates,
              "arithmetic":"floating point; candidate reduction is proved analytically"}
    if N >= 28:
        ell = math.log2(N+1)
        E = N*binary_entropy(14/N)+14*math.log2(15)+16*ell
        result["proven_entropy_lower_bound"] = N*V-16*ell
        result["proven_entropy_upper_bound"] = N*V+E+8*ell
        result["bound_evaluation_note"] = "Bounds are rigorous formulas; displayed decimals are not outward-rounded intervals."
    return result


@lru_cache(None)
def kraw_row(total: int, negative: int) -> tuple[int,...]:
    """Integer coefficients of (1-z)**negative (1+z)**(total-negative)."""
    return tuple(sum((-1)**j * math.comb(negative,j)*math.comb(total-negative,k-j)
                     for j in range(max(0,k-(total-negative)),min(negative,k)+1))
                 for k in range(total+1))


def moment_by_pauli_types(weights: tuple[int,...]) -> Fraction:
    """Exact moment for a real symmetric state with integer per-string amplitudes.

    Group Pauli strings by their numbers of X,Y,Z,I factors; use binomial
    generating functions for expectations. Independent of the column-count code.
    """
    N = len(weights)-1
    norm = sum(math.comb(N,n)*weights[n]**2 for n in range(N+1))
    if N < 0 or norm == 0:
        raise ValueError("Need a nonzero amplitude vector.")
    total = 0
    for flip in range(N+1):
        for y in range(0,flip+1,2):
            left = kraw_row(flip,y)
            for z in range(N-flip+1):
                right = kraw_row(N-flip,z)
                expectation = sum(left[u]*right[v]*weights[u+v]*weights[flip-u+v]
                                  for u in range(flip+1) for v in range(N-flip+1))
                multiplicity = math.comb(N,flip)*math.comb(flip,y)*math.comb(N-flip,z)
                total += multiplicity*expectation**4
    return Fraction(total,2**N*norm**4)


@lru_cache(None)
def fourth_kraw_total(total: int, degree: int) -> int:
    return sum(math.comb(total,u)*kraw_row(total,u)[degree]**4 for u in range(total+1))


@lru_cache(None)
def dicke_moment(N: int, n: int) -> Fraction:
    """Existing Krawtchouk formula, Kwan Appendix C, evaluated with integers."""
    if not 0 <= n <= N:
        raise ValueError("Invalid Dicke index.")
    numerator = sum(math.comb(N,2*h)*fourth_kraw_total(2*h,h)*fourth_kraw_total(N-2*h,n-h)
                    for h in range(min(n,N-n)+1))
    return Fraction(numerator,2**N*math.comb(N,n)**4)


if __name__ == "__main__":
    parser=argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--N",type=int,default=10000)
    parser.add_argument("--K",type=int,default=1000)
    parser.add_argument("--r",type=int,default=500)
    parser.add_argument("--p",type=float,default=0.25)
    args=parser.parse_args()
    print(json.dumps(leading_density(args.N,args.K,args.r,args.p),indent=2))
