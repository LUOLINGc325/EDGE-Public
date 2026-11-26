#!/usr/bin/env python3
"""Actual fixed-composition codes for positive, numerically rank-two channels.

Run the two nonbinary examples, using exact categorical count sampling:

    python code/rank2_codec.py --replicates 5000 --seed 20261124 \
        --blocklengths 1024 4096 --epsilon 0.1 \
        --output results/general_codec.json

For another channel, --channel-file accepts a JSON matrix, or an object with
"name" and "matrix" fields. The programmatic interface is:

    channel = RankTwoChannel(W)
    code = RankTwoCode(channel, n=4096, message_count=25)
    input_word = code.encode(0)  # original input-symbol indices
    message = code.decode_counts(full_output_counts)

Each row of W is one conditional output distribution. Tiny row-sum roundoff is
normalized only after an explicit stochasticity check. Affine rank and endpoint
membership are numerical checks with exposed tolerances, not exact algebraic
certificates. Distinct rounded types are required; a too-dense grid is rejected.

The decoder implements manuscript (13), then compares the one-step estimate to
inverse-H metric midpoints. This avoids a quadrature for each observation while
being equivalent to nearest-H decoding. H is integrated from the fixed-type
covariance, not the iid-mixture covariance. Numerical quadrature error estimates
are diagnostics, not certified enclosures or finite-blocklength error bounds.

Monte Carlo draws are sums of two independent multinomial counts with fixed
endpoint sample sizes. No Gaussian surrogate or randomized input composition is
sampled. Reported Gaussian curves are asymptotic references only. The empirical
maximum error is a noisy maximum; simultaneous Clopper--Pearson intervals cover
the true per-codebook maximum, under independent sampling, with at least 95%
confidence. Average-error intervals use Hoeffding's inequality. Neither interval
is a certificate of global code optimality or of the theorem's asymptotic limit.
"""

from __future__ import annotations

import argparse
from dataclasses import asdict, dataclass
import json
import math
from pathlib import Path
from typing import Any

import numpy as np
import scipy
from scipy.integrate import quad
from scipy.optimize import brentq
from scipy.stats import beta, norm


@dataclass(frozen=True)
class NumericalTolerances:
    row_atol: float = 2e-12
    row_rtol: float = 2e-12
    rank_atol: float = 1e-12
    rank_rtol: float = 1e-10
    segment_atol: float = 2e-12
    segment_rtol: float = 2e-10
    quad_atol: float = 1e-12
    quad_rtol: float = 1e-12
    root_xtol: float = 1e-13
    root_rtol: float = 1e-12


class RankTwoChannel:
    """Extract actual endpoint rows and evaluate the fixed-type geometry."""

    def __init__(
        self, matrix: Any, tolerances: NumericalTolerances | None = None
    ) -> None:
        self.tolerances = tolerances or NumericalTolerances()
        tol = self.tolerances
        values = tuple(asdict(tol).values())
        if any(not np.isfinite(value) or value <= 0 for value in values):
            raise ValueError("Every numerical tolerance must be finite and positive.")
        if tol.root_rtol < 4 * np.finfo(float).eps:
            raise ValueError("root_rtol must be at least four machine epsilons.")
        W = np.asarray(matrix, dtype=float)
        if W.ndim != 2 or min(W.shape) < 2:
            raise ValueError("A channel must have at least two input and output symbols.")
        if not np.all(np.isfinite(W)) or not np.all(W > 0):
            raise ValueError("All channel entries must be finite and strictly positive.")
        sums = W.sum(axis=1)
        if not np.allclose(sums, 1.0, atol=tol.row_atol, rtol=tol.row_rtol):
            raise ValueError("Channel rows do not sum to one within the stated tolerances.")
        self.row_normalization_max_change = float(np.max(np.abs(W / sums[:, None] - W)))
        self.W = W = W / sums[:, None]
        self.input_size, self.output_size = W.shape
        centered = W - W[0]
        _, singular_values, vh = np.linalg.svd(centered, full_matrices=False)
        rank_threshold = tol.rank_atol + tol.rank_rtol * singular_values[0]
        if singular_values[0] <= rank_threshold:
            raise ValueError("Channel is numerically rank one, or too close to it.")
        if np.any(singular_values[1:] > rank_threshold):
            raise ValueError("Channel rows have numerical affine dimension greater than one.")
        projections = centered @ vh[0]
        endpoints = sorted((int(np.argmin(projections)), int(np.argmax(projections))))
        self.endpoint_indices = tuple(endpoints)
        self.p0, self.p1 = W[endpoints[0]].copy(), W[endpoints[1]].copy()
        self.d = self.p1 - self.p0
        squared_length = float(self.d @ self.d)
        if squared_length <= tol.rank_atol**2:
            raise ValueError("Numerical endpoint separation is too small.")
        coordinates = (W - self.p0) @ self.d / squared_length
        reconstructed = self.p0 + coordinates[:, None] * self.d
        residual = float(np.max(np.abs(W - reconstructed)))
        segment_threshold = tol.segment_atol + tol.segment_rtol * float(np.max(W))
        coordinate_slack = segment_threshold / math.sqrt(squared_length)
        if residual > segment_threshold or np.any(coordinates < -coordinate_slack) or np.any(
            coordinates > 1 + coordinate_slack
        ):
            raise ValueError("A row does not lie on the detected endpoint segment.")
        self.row_coordinates = np.clip(coordinates, 0.0, 1.0)
        self.affine_singular_values = singular_values
        self.max_segment_residual = residual
        self.segment_threshold = segment_threshold
        self.u = self.d[:-1]
        self.C0 = np.diag(self.p0[:-1]) - np.outer(self.p0[:-1], self.p0[:-1])
        self.C1 = np.diag(self.p1[:-1]) - np.outer(self.p1[:-1], self.p1[:-1])
        self.preliminary_direction = self.u / float(self.u @ self.u)
        self.min_endpoint_covariance_eigenvalue = float(
            min(np.linalg.eigvalsh(self.C0)[0], np.linalg.eigvalsh(self.C1)[0])
        )
        if self.min_endpoint_covariance_eigenvalue <= 0:
            raise ValueError("Endpoint covariance is not numerically positive definite.")
        self.max_quad_error_estimate = 0.0
        self.L = self._integral(0.0, 1.0)
        if not np.isfinite(self.L) or self.L <= 0:
            raise ValueError("Computed channel length is not finite and positive.")

    def covariance(self, theta: Any) -> np.ndarray:
        t = np.asarray(theta, dtype=float)
        return self.C0 + t[..., None, None] * (self.C1 - self.C0)

    def J(self, theta: float) -> float:
        """Primary metric, from the fixed-composition covariance matrix."""
        answer = float(self.u @ np.linalg.solve(self.covariance(theta), self.u))
        if not np.isfinite(answer) or answer <= 0:
            raise FloatingPointError("Numerical fixed-type information is not positive.")
        return answer

    def J_identity(self, theta: float) -> float:
        """Independent cross-check via the full-coordinate Fisher identity."""
        q = self.p0 + theta * self.d
        information = float(np.sum(self.d * self.d / q))
        denominator = 1.0 - theta * (1.0 - theta) * information
        if denominator <= 0:
            raise FloatingPointError("Fisher-identity denominator lost positivity numerically.")
        return information / denominator

    def _integral(self, a: float, b: float) -> float:
        value, error = quad(
            lambda t: math.sqrt(self.J(t)),
            a,
            b,
            epsabs=self.tolerances.quad_atol,
            epsrel=self.tolerances.quad_rtol,
            limit=150,
        )
        self.max_quad_error_estimate = max(self.max_quad_error_estimate, float(error))
        return float(value)

    def H(self, theta: float) -> float:
        """Intrinsic coordinate, with the manuscript's linear endpoint extension."""
        if theta <= 0:
            return theta * math.sqrt(self.J(0.0))
        if theta >= 1:
            return self.L + (theta - 1) * math.sqrt(self.J(1.0))
        return self._integral(0.0, theta)

    def inverse_H(self, arc_position: float) -> float:
        if arc_position <= 0:
            return arc_position / math.sqrt(self.J(0.0))
        if arc_position >= self.L:
            return 1 + (arc_position - self.L) / math.sqrt(self.J(1.0))
        return float(
            brentq(
                lambda t: self.H(t) - arc_position,
                0.0,
                1.0,
                xtol=self.tolerances.root_xtol,
                rtol=self.tolerances.root_rtol,
            )
        )


class RankTwoCode:
    """Deterministic endpoint encoder and one-step count decoder."""

    def __init__(self, channel: RankTwoChannel, n: int, message_count: int) -> None:
        if not isinstance(n, (int, np.integer)) or isinstance(n, (bool, np.bool_)) or n < 1:
            raise ValueError("n must be a positive integer.")
        if (
            not isinstance(message_count, (int, np.integer))
            or isinstance(message_count, (bool, np.bool_))
            or message_count < 1
        ):
            raise ValueError("message_count must be a positive integer.")
        if n > 2**53:
            raise ValueError("This float64 implementation requires n <= 2**53.")
        if message_count > n + 1:
            raise ValueError("There cannot be more than n+1 distinct endpoint types.")
        self.channel, self.n, self.M = channel, int(n), int(message_count)
        targets = np.linspace(0.0, channel.L, self.M) if self.M > 1 else np.array([0.0])
        theta = np.array([channel.inverse_H(float(value)) for value in targets])
        self.weights = np.rint(self.n * theta).astype(np.int64)
        if np.any(np.diff(self.weights) <= 0):
            raise ValueError("Rounding merges code types; reduce the requested message count.")
        self.theta = self.weights / self.n
        self.arc_positions = np.array([channel.H(float(t)) for t in self.theta])
        midpoints = (self.arc_positions[:-1] + self.arc_positions[1:]) / 2
        self.theta_boundaries = np.array([channel.inverse_H(float(s)) for s in midpoints])
        self.max_inverse_arc_residual = max(
            [abs(channel.H(float(t)) - float(s)) for t, s in zip(theta, targets)]
            + [abs(channel.H(float(t)) - float(s)) for t, s in zip(self.theta_boundaries, midpoints)]
        )
        self.max_rounding_arc_displacement = float(np.max(np.abs(self.arc_positions - targets)))

    def _message(self, message: int) -> int:
        if (
            not isinstance(message, (int, np.integer))
            or isinstance(message, (bool, np.bool_))
            or not 0 <= message < self.M
        ):
            raise ValueError("message must be an integer in [0, message_count).")
        return int(message)

    def encode(self, message: int) -> np.ndarray:
        """Return an actual input word indexed in the original input alphabet."""
        message = self._message(message)
        w = int(self.weights[message])
        word = np.full(self.n, self.channel.endpoint_indices[0], dtype=np.int64)
        if w:
            word[self.n - w :] = self.channel.endpoint_indices[1]
        return word

    def _one_step_from_proportions(self, proportions: np.ndarray) -> np.ndarray:
        ch = self.channel
        reduced = proportions[..., :-1]
        preliminary = np.clip((reduced - ch.p0[:-1]) @ ch.preliminary_direction, 0.0, 1.0)
        V = ch.covariance(preliminary)
        rhs = np.broadcast_to(ch.u, V.shape[:-1])[..., None]
        solved = np.linalg.solve(V, rhs)[..., 0]
        information = np.sum(solved * ch.u, axis=-1)
        direction = solved / information[..., None]
        residual = reduced - ch.p0[:-1] - preliminary[..., None] * ch.u
        return preliminary + np.sum(direction * residual, axis=-1)

    def estimate_theta(self, full_counts: Any) -> np.ndarray:
        """Accept one or a batch of full, integer, nonnegative count vectors."""
        counts = np.asarray(full_counts)
        if counts.ndim < 1 or counts.shape[-1] != self.channel.output_size:
            raise ValueError("The final count-vector dimension must equal the output alphabet size.")
        if (
            not np.all(np.isfinite(counts))
            or np.any(counts < 0)
            or np.any(counts != np.floor(counts))
            or np.any(counts.sum(axis=-1) != self.n)
        ):
            raise ValueError("Counts must be finite nonnegative integers summing to n.")
        return self._one_step_from_proportions(counts.astype(float) / self.n)

    def decode_counts(self, full_counts: Any) -> int | np.ndarray:
        estimates = self.estimate_theta(full_counts)
        decoded = np.searchsorted(self.theta_boundaries, estimates, side="left")
        return int(decoded) if np.ndim(decoded) == 0 else decoded

    def decode_word(self, output_word: Any) -> int:
        word = np.asarray(output_word)
        if (
            word.shape != (self.n,)
            or not np.all(np.isfinite(word))
            or np.any(word != np.floor(word))
            or np.any(word < 0)
            or np.any(word >= self.channel.output_size)
        ):
            raise ValueError("Output word must have n valid integer output-symbol indices.")
        counts = np.bincount(word.astype(np.int64), minlength=self.channel.output_size)
        return int(self.decode_counts(counts))

    def sample_counts(self, message: int, replicates: int, rng: np.random.Generator) -> np.ndarray:
        """Exact fixed-type law: Mult(n-w,p0) + Mult(w,p1), independently."""
        message = self._message(message)
        if not isinstance(replicates, (int, np.integer)) or replicates < 1:
            raise ValueError("replicates must be a positive integer.")
        w = int(self.weights[message])
        return rng.multinomial(self.n - w, self.channel.p0, size=replicates) + rng.multinomial(
            w, self.channel.p1, size=replicates
        )


def clopper_pearson(errors: int, trials: int, alpha: float) -> list[float]:
    lower = 0.0 if errors == 0 else float(beta.ppf(alpha / 2, errors, trials - errors + 1))
    upper = 1.0 if errors == trials else float(beta.ppf(1 - alpha / 2, errors + 1, trials - errors))
    return [lower, upper]


def geometry_checks(channel: RankTwoChannel) -> dict[str, Any]:
    grid = np.linspace(0.0, 1.0, 101)
    matrix_J = np.array([channel.J(float(t)) for t in grid])
    identity_J = np.array([channel.J_identity(float(t)) for t in grid])
    relative_J = float(np.max(np.abs(matrix_J - identity_J) / matrix_J))
    alternate_length, error = quad(
        lambda t: math.sqrt(channel.J_identity(t)), 0, 1,
        epsabs=channel.tolerances.quad_atol, epsrel=channel.tolerances.quad_rtol,
    )
    # A cyclic output permutation changes the deleted coordinate in the matrix formula.
    permuted = RankTwoChannel(np.roll(channel.W, 1, axis=1), channel.tolerances)
    reversed_endpoints = RankTwoChannel(np.stack((channel.p1, channel.p0)), channel.tolerances)
    assert relative_J < 1e-9, "Matrix and scalar information disagree."
    assert abs(channel.L - alternate_length) < 1e-9, "Length formulas disagree."
    assert abs(channel.L - permuted.L) < 1e-9, "Length depends on deleted output coordinate."
    assert abs(channel.L - reversed_endpoints.L) < 1e-9, "Length depends on endpoint orientation."
    return {
        "matrix_vs_identity_max_relative_J_error_on_101_points": relative_J,
        "length_matrix": channel.L,
        "length_scalar_identity": float(alternate_length),
        "length_scalar_quadrature_error_estimate": float(error),
        "length_after_output_permutation": permuted.L,
        "length_after_endpoint_reversal": reversed_endpoints.L,
        "checks_passed": True,
    }


def input_rejection_checks() -> dict[str, bool]:
    invalid = {
        "zero_entry": [[1.0, 0.0], [0.2, 0.8]],
        "nonstochastic_row": [[0.3, 0.3], [0.2, 0.8]],
        "rank_one": [[0.2, 0.8], [0.2, 0.8]],
        "affine_dimension_two": [[0.6, 0.2, 0.2], [0.2, 0.6, 0.2], [0.2, 0.2, 0.6]],
    }
    result = {}
    for label, matrix in invalid.items():
        try:
            RankTwoChannel(matrix)
        except ValueError:
            result[label] = True
        else:
            raise AssertionError(f"Invalid channel was accepted: {label}")
    return result


def simulate_code(
    name: str, channel: RankTwoChannel, n: int, epsilon: float,
    replicates: int, seed: np.random.SeedSequence,
) -> dict[str, Any]:
    z = float(norm.ppf(1 - epsilon / 2))
    coefficient = channel.L / (2 * z)
    M = max(1, int(math.floor(coefficient * math.sqrt(n))))
    code = RankTwoCode(channel, n, M)
    rng = np.random.default_rng(seed)
    rows = []
    moment_diagnostic = None
    for message in range(M):
        samples = code.sample_counts(message, replicates, rng)
        decoded = code.decode_counts(samples)
        errors = int(np.count_nonzero(decoded != message))
        rows.append({
            "message": message,
            "endpoint_one_count": int(code.weights[message]),
            "theta": float(code.theta[message]),
            "errors": errors,
            "trials": replicates,
            "empirical_error": errors / replicates,
            "pointwise_95pct_clopper_pearson": clopper_pearson(errors, replicates, 0.05),
            "simultaneous_95pct_bonferroni_clopper_pearson": clopper_pearson(errors, replicates, 0.05 / M),
        })
        # Independently check actual encoder symbols and the noiseless mean statistic.
        word = code.encode(message)
        assert np.count_nonzero(word == channel.endpoint_indices[1]) == code.weights[message]
        expected_proportions = channel.p0 + code.theta[message] * channel.d
        mean_estimate = float(code._one_step_from_proportions(expected_proportions))
        assert abs(mean_estimate - code.theta[message]) < 1e-10
        assert int(np.searchsorted(code.theta_boundaries, mean_estimate, side="left")) == message
        if message == M // 2:
            reduced = samples[:, :-1].astype(float)
            theoretical_covariance = n * channel.covariance(code.theta[message])
            empirical_covariance = np.atleast_2d(np.cov(reduced, rowvar=False, ddof=1))
            moment_diagnostic = {
                "message": message,
                "expected_full_count": (n * expected_proportions).tolist(),
                "empirical_full_count_mean": samples.mean(axis=0).tolist(),
                "fixed_type_reduced_covariance": theoretical_covariance.tolist(),
                "empirical_reduced_covariance": empirical_covariance.tolist(),
                "relative_frobenius_covariance_sampling_error": float(
                    np.linalg.norm(empirical_covariance - theoretical_covariance)
                    / np.linalg.norm(theoretical_covariance)
                ),
            }
    probabilities = np.array([row["empirical_error"] for row in rows])
    average = float(probabilities.mean())
    maximum = float(probabilities.max())
    halfwidth = math.sqrt(math.log(2 / 0.05) / (2 * M * replicates))
    max_interval = [
        max(row["simultaneous_95pct_bonferroni_clopper_pearson"][0] for row in rows),
        max(row["simultaneous_95pct_bonferroni_clopper_pearson"][1] for row in rows),
    ]
    return {
        "name": name, "n": n, "target_epsilon": epsilon,
        "message_count": M,
        "message_count_rule": "max(1, floor(L*sqrt(n)/(2*Phi_inverse(1-epsilon/2))))",
        "asymptotic_fixed_error_coefficient": coefficient,
        "M_over_sqrt_n": M / math.sqrt(n),
        "asymptotic_error_curve_at_M_over_sqrt_n": float(2 * norm.sf(channel.L * math.sqrt(n) / (2 * M))),
        "gaussian_minimum_spacing_two_tail_reference": (
            float(2 * norm.sf(math.sqrt(n) * float(np.min(np.diff(code.arc_positions))) / 2))
            if M > 1 else None
        ),
        "empirical_average_error": average,
        "average_error_95pct_hoeffding_interval": [max(0.0, average - halfwidth), min(1.0, average + halfwidth)],
        "empirical_maximum_error": maximum,
        "true_maximum_error_95pct_simultaneous_interval": max_interval,
        "replicates_per_message": replicates,
        "total_trials": M * replicates,
        "rng": {"bit_generator": type(rng.bit_generator).__name__, "entropy": seed.entropy, "spawn_key": list(seed.spawn_key)},
        "code_weights": code.weights.tolist(),
        "theta_decision_boundaries": code.theta_boundaries.tolist(),
        "max_inverse_arc_residual": code.max_inverse_arc_residual,
        "max_rounding_arc_displacement": code.max_rounding_arc_displacement,
        "midpoint_fixed_type_moment_diagnostic": moment_diagnostic,
        "per_message": rows,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    parser.add_argument("--replicates", type=int, default=5000)
    parser.add_argument("--seed", type=int, default=20261124)
    parser.add_argument("--blocklengths", nargs="+", type=int, default=[1024, 4096])
    parser.add_argument("--epsilon", type=float, default=0.1)
    parser.add_argument("--channel-file", type=Path)
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results/general_codec.json")
    args = parser.parse_args()
    if args.replicates < 2 or any(n < 1 for n in args.blocklengths) or not 0 < args.epsilon < 1 or args.seed < 0:
        parser.error("Need replicates >= 2, positive blocklengths, 0 < epsilon < 1, and a nonnegative seed.")
    if args.channel_file:
        supplied = json.loads(args.channel_file.read_text())
        examples = [(supplied.get("name", "custom_channel"), supplied["matrix"])] if isinstance(supplied, dict) else [("custom_channel", supplied)]
    else:
        first0, first1 = np.array([0.5, 1 / 3, 1 / 6]), np.array([1 / 6, 1 / 3, 0.5])
        second0, second1 = np.array([0.1, 0.2, 0.3, 0.4]), np.array([0.4, 0.3, 0.2, 0.1])
        examples = [
            ("ternary_with_interior_input", np.stack((first0, 0.4 * first0 + 0.6 * first1, first1))),
            ("quaternary_with_interior_input", np.stack((second0, 0.4 * second0 + 0.6 * second1, second1))),
        ]
    seeds = iter(np.random.SeedSequence(args.seed).spawn(len(examples) * len(args.blocklengths)))
    channels = []
    runs = []
    for name, W in examples:
        channel = RankTwoChannel(W)
        checks = geometry_checks(channel)
        for n in args.blocklengths:
            runs.append(simulate_code(name, channel, n, args.epsilon, args.replicates, next(seeds)))
        channels.append({
            "name": name,
            "channel_matrix": channel.W.tolist(),
            "endpoint_input_indices": list(channel.endpoint_indices),
            "endpoint_p0": channel.p0.tolist(), "endpoint_p1": channel.p1.tolist(),
            "input_row_segment_coordinates": channel.row_coordinates.tolist(),
            "numerical_tolerances": asdict(channel.tolerances),
            "row_normalization_max_change": channel.row_normalization_max_change,
            "affine_singular_values": channel.affine_singular_values.tolist(),
            "max_segment_residual": channel.max_segment_residual,
            "segment_acceptance_threshold": channel.segment_threshold,
            "min_endpoint_covariance_eigenvalue": channel.min_endpoint_covariance_eigenvalue,
            "largest_reported_quad_error_estimate": channel.max_quad_error_estimate,
            "geometry_checks": checks,
        })
    result = {
        "schema_version": 1,
        "model": "exact fixed endpoint composition; sum of two independent multinomial count vectors",
        "decoder": "deterministic one-step estimator and inverse-H midpoint thresholds",
        "scope": "Monte Carlo evidence for constructed codes; no finite-error guarantee or global optimality certificate",
        "confidence_scope": "95% intervals are per codebook; maximum uses simultaneous Bonferroni Clopper--Pearson intervals, average uses Hoeffding",
        "software": {"numpy": np.__version__, "scipy": scipy.__version__},
        "seed": args.seed,
        "input_rejection_checks": input_rejection_checks(),
        "channels": channels,
        "runs": runs,
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, allow_nan=False) + "\n")
    print(json.dumps({"output": str(args.output), "runs": [
        {key: run[key] for key in ("name", "n", "message_count", "empirical_average_error", "empirical_maximum_error", "true_maximum_error_95pct_simultaneous_interval")}
        for run in runs
    ]}, indent=2))


if __name__ == "__main__":
    main()
