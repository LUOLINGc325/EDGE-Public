"""Topology-constrained reconstruction of row-stochastic CTMC generators.

All conventions are row based: Q 1 = 0, P=exp(delta Q), pi Q=0.
The supported-commutant method is prior art; see the manuscript for its explicit
high-girth identifiability theorem and source attribution. Floating-point output
is a numerical implementation, not interval-certified arithmetic.
"""
from __future__ import annotations

from dataclasses import dataclass
from typing import Sequence
import math
import numpy as np
from scipy.linalg import expm


@dataclass
class Reconstruction:
    generator: np.ndarray
    rates: np.ndarray
    normalized_rates: np.ndarray
    total_rate: float
    singular_values: np.ndarray
    augmented_rank: int
    linear_residual: float
    exponential_residual: float


def generator_basis(n: int, directed_edges: Sequence[tuple[int, int]]) -> np.ndarray:
    """Return B_e=E_ij-E_ii in the explicit supplied directed-edge order."""
    if n < 2 or not directed_edges:
        raise ValueError("At least two states and one directed edge are required")
    if len(set(directed_edges)) != len(directed_edges):
        raise ValueError("Repeated directed edges are not allowed")
    basis = np.zeros((len(directed_edges), n, n), dtype=float)
    for k, (i, j) in enumerate(directed_edges):
        if i == j or not (0 <= i < n and 0 <= j < n):
            raise ValueError("Every directed edge must connect distinct valid states")
        basis[k, i, j] = 1.0
        basis[k, i, i] = -1.0
    return basis


def generator_from_rates(n: int, directed_edges: Sequence[tuple[int, int]], rates) -> np.ndarray:
    """Build a generator. Positivity is a caller-specified model constraint."""
    rates = np.asarray(rates, dtype=float)
    if rates.shape != (len(directed_edges),):
        raise ValueError("There must be exactly one rate per directed edge")
    if not np.all(np.isfinite(rates)):
        raise ValueError("Rates must be finite")
    return np.einsum("e,eij->ij", rates, generator_basis(n, directed_edges))


def commutator_system(observed: np.ndarray, directed_edges) -> np.ndarray:
    """Stack vec([B_e,P]) and a final sum-normalization row.

    Vectorization is C-order throughout; choosing a different consistent order
    merely permutes rows and leaves the least-squares problem unchanged.
    """
    observed = np.asarray(observed, dtype=float)
    if observed.ndim != 2 or observed.shape[0] != observed.shape[1]:
        raise ValueError("Observed matrix must be square")
    if not np.all(np.isfinite(observed)):
        raise ValueError("Observed matrix must be finite")
    basis = generator_basis(observed.shape[0], directed_edges)
    columns = [(b @ observed - observed @ b).ravel() for b in basis]
    return np.vstack((np.column_stack(columns), np.ones(len(directed_edges))))


def reconstruct(observed: np.ndarray, directed_edges, delta: float) -> Reconstruction:
    """Recover total scale by log determinant and normalized rates by least squares.

    Exact-data correctness needs the manuscript hypotheses or an independently
    justified full-rank supported system. A tiny floating-point singular value is
    not an exact identifiability proof. Positivity/embedding residuals are returned
    for inspection, not imposed through an unreported optimization step.
    """
    observed = np.asarray(observed, dtype=float)
    if not math.isfinite(delta) or delta <= 0:
        raise ValueError("Sampling interval must be finite and positive")
    design = commutator_system(observed, directed_edges)
    rhs = np.zeros(design.shape[0]); rhs[-1] = 1.0
    uhat, _, rank, sv = np.linalg.lstsq(design, rhs, rcond=None)
    if rank != len(directed_edges):
        raise ValueError(f"Supported system is numerically rank deficient ({rank}/{len(directed_edges)})")
    sign, logdet = np.linalg.slogdet(observed)
    if sign <= 0 or not math.isfinite(logdet):
        raise ValueError("A positive finite determinant is required for real total rate")
    tauhat = -float(logdet) / delta
    if tauhat <= 0:
        raise ValueError("Recovered total rate must be positive")
    rates = tauhat * uhat
    qhat = generator_from_rates(observed.shape[0], directed_edges, rates)
    return Reconstruction(
        generator=qhat, rates=rates, normalized_rates=uhat,
        total_rate=tauhat, singular_values=sv, augmented_rank=int(rank),
        linear_residual=float(np.linalg.norm(design @ uhat - rhs)),
        exponential_residual=float(np.linalg.norm(expm(delta*qhat) - observed, "fro")),
    )


def noise_certificate(observed: np.ndarray, directed_edges, delta: float, epsilon: float) -> dict:
    """Observable deterministic error bounds, conditional on ||Ptilde-P||_2<=epsilon.

    This function does not estimate epsilon, does not give a statistical confidence
    level, and does not account for floating-point roundoff. For a formal numerical
    certificate, enclose every norm, singular value, inverse and logarithm using
    directed interval arithmetic. The theorem itself is exact real arithmetic.
    """
    if not math.isfinite(epsilon) or epsilon < 0:
        raise ValueError("epsilon must be finite and nonnegative")
    result = reconstruct(observed, directed_edges, delta)
    smin = float(result.singular_values[-1])
    normalized_bound = 2.0*math.sqrt(2.0)*epsilon/smin
    h = float(np.linalg.norm(np.linalg.inv(observed), 2)*epsilon)
    scale_bound = -observed.shape[0]/delta * math.log1p(-h) if h < 1 else None
    total_bound = result.total_rate*normalized_bound+scale_bound if scale_bound is not None else None
    return {
        "assumed_operator_error_epsilon":epsilon,
        "observed_augmented_sigma_min":smin,
        "normalized_rate_l2_bound":normalized_bound,
        "inverse_error_product_h":h,
        "total_rate_scale_bound":scale_bound,
        "rate_l2_bound":total_bound,
        "scale_condition_h_lt_one":bool(h < 1),
        "confidence_level":None,
        "interval_arithmetic_verified":False,
        "interpretation":"Deterministic real-arithmetic theorem evaluated in ordinary floating point; epsilon must be justified separately.",
    }


def stationary_distribution(generator: np.ndarray) -> np.ndarray:
    """Solve pi Q=0, sum(pi)=1 for an irreducible row generator."""
    generator = np.asarray(generator, dtype=float)
    design=generator.T.copy(); design[-1,:]=1.0
    rhs=np.zeros(generator.shape[0]); rhs[-1]=1.0
    return np.linalg.solve(design,rhs)


def entropy_production(generator: np.ndarray, undirected_edges) -> float:
    """Sum (pi_i q_ij - pi_j q_ji) log(pi_i q_ij/(pi_j q_ji)) over edges."""
    pi=stationary_distribution(generator)
    if np.any(pi <= 0):
        raise ValueError("Stationary distribution must be strictly positive")
    total=0.0
    for i,j in undirected_edges:
        f=float(pi[i]*generator[i,j]); b=float(pi[j]*generator[j,i])
        if f <= 0 or b <= 0:
            raise ValueError("Entropy calculation needs positive rates in both directions")
        total += (f-b)*math.log(f/b)
    return total
