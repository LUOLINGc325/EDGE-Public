"""Reference hard-budget covariance protocol with private integer rounding.

The mathematical protocol is described in ../manuscript/ENCODING_AND_SUBGAUSSIAN.md.
This implementation uses finite floating-point inputs and pseudorandom coins.
It is not a proof of arbitrary-real computation or a finite-precision minimax
theorem. The gamma codec and frame lengths use exact Python integers/strings.
Metadata in EncodingRecord is diagnostic only; the decoder receives only bits.
"""

from __future__ import annotations

from dataclasses import dataclass
import math
from typing import Sequence

import numpy as np


CAP_BITS_PER_COORDINATE_PAIR = 16
OVERFLOW_BASE = 25 / 128


def signed_to_positive(value: int) -> int:
    value = int(value)
    return 2 * value + 1 if value >= 0 else -2 * value


def positive_to_signed(value: int) -> int:
    if value <= 0:
        raise ValueError("The gamma alphabet consists of positive integers.")
    return (value - 1) // 2 if value & 1 else -value // 2


def gamma_length_signed(value: int) -> int:
    return 2 * signed_to_positive(value).bit_length() - 1


def gamma_encode_signed(value: int) -> str:
    binary = format(signed_to_positive(value), "b")
    return "0" * (len(binary) - 1) + binary


def gamma_decode_signed(bits: str, offset: int = 0) -> tuple[int, int]:
    """Decode one signed gamma word; return (integer, first unused offset)."""
    if offset < 0 or offset >= len(bits):
        raise ValueError("Missing gamma word.")
    one = offset
    while one < len(bits) and bits[one] == "0":
        one += 1
    if one == len(bits) or bits[one] != "1":
        raise ValueError("Unterminated gamma prefix.")
    zero_count = one - offset
    end = one + zero_count + 1
    if end > len(bits):
        raise ValueError("Truncated gamma word.")
    binary = bits[one:end]
    if any(bit not in "01" for bit in binary):
        raise ValueError("Nonbinary gamma word.")
    return positive_to_signed(int(binary, 2)), end


def randomized_integer(value: float, rng: np.random.Generator) -> int:
    """Unbiased real-valued rounding in theory; floating-point reference here."""
    if not math.isfinite(value):
        raise ValueError("Reference implementation requires finite normalized data.")
    lower = math.floor(value)
    fraction = value - lower
    return lower + int(rng.random() < fraction)


def effective_pairs(m: int, dimensions: Sequence[int], budgets: Sequence[int]) -> int:
    if m < 0 or len(dimensions) != len(budgets) or not dimensions:
        raise ValueError("Invalid public parameters.")
    if any(int(p) != p or p <= 0 for p in dimensions):
        raise ValueError("Feature blocks must have positive integer dimensions.")
    if any(int(b) != b or b < 0 for b in budgets):
        raise ValueError("Budgets must be nonnegative integers.")
    return min(
        m // 2,
        *(max(int(b) - 1, 0) // (CAP_BITS_PER_COORDINATE_PAIR * int(p))
          for p, b in zip(dimensions, budgets)),
    )


@dataclass(frozen=True)
class EncodingRecord:
    budget_bits: int
    transmitted_bits: int
    payload_bits_checked: int
    integers_checked: int
    expected_integers: int
    overflow: bool


def encode_local(
    local_samples: np.ndarray,
    n: int,
    scale: float,
    budget: int,
    rng: np.random.Generator,
) -> tuple[str, EncodingRecord]:
    """Encode only one agent's coordinates; no other block is accessible.

    Stops on the first codeword that would exceed the payload cap. For a failed
    frame payload_bits_checked is a lower bound on the virtual full length.
    """
    samples = np.asarray(local_samples, dtype=float)
    if samples.ndim != 2 or samples.shape[1] < 1:
        raise ValueError("Expected a nonempty local coordinate block.")
    if n < 0 or n * 2 > samples.shape[0] or int(budget) != budget or budget < 0:
        raise ValueError("Invalid sample count or budget.")
    if scale < 0 or not math.isfinite(scale):
        raise ValueError("Scale must be finite and nonnegative.")
    budget = int(budget)
    count = 2 * n * samples.shape[1]
    if n == 0 or scale == 0 or budget == 0:
        bits = "0" * budget
        return bits, EncodingRecord(budget, budget, 0, 0, count, False)
    payload_cap = budget - 1
    payload_bits = 0
    checked = 0
    pieces: list[str] = []
    for i in range(n):
        paired = (samples[2 * i] - samples[2 * i + 1]) / math.sqrt(2)
        for _replica in range(2):
            for coordinate in paired:
                q = randomized_integer(float(coordinate / scale), rng)
                payload_bits += gamma_length_signed(q)
                checked += 1
                if payload_bits > payload_cap:
                    return "0" * budget, EncodingRecord(
                        budget, budget, payload_bits, checked, count, True
                    )
                pieces.append(gamma_encode_signed(q))
    bits = "1" + "".join(pieces) + "0" * (payload_cap - payload_bits)
    return bits, EncodingRecord(budget, len(bits), payload_bits, checked, count, False)


def decode_local(bits: str, n: int, dimension: int) -> np.ndarray | None:
    """Return an (n, 2, dimension) integer-value array, or None on failure."""
    if n == 0 or not bits or bits[0] == "0":
        return None
    if bits[0] != "1" or any(bit not in "01" for bit in bits):
        raise ValueError("Malformed frame.")
    values: list[int] = []
    offset = 1
    for _ in range(2 * n * dimension):
        value, offset = gamma_decode_signed(bits, offset)
        values.append(value)
    if any(bit != "0" for bit in bits[offset:]):
        raise ValueError("Nonzero padding in a successful frame.")
    # Explicitly reject unrepresentable values instead of silently introducing
    # an extra statistical failure event absent from the mathematical protocol.
    decoded = np.asarray(values, dtype=float).reshape(n, 2, dimension)
    if not np.isfinite(decoded).all():
        raise OverflowError("Decoded integers exceed floating-point range.")
    return decoded


def clip_covariance(matrix: np.ndarray, upper: float) -> np.ndarray:
    matrix = np.asarray(matrix, dtype=float)
    if not np.isfinite(matrix).all():
        raise OverflowError("Reference covariance arithmetic overflowed.")
    symmetric = (matrix + matrix.T) / 2
    eigenvalues, eigenvectors = np.linalg.eigh(symmetric)
    return (eigenvectors * np.clip(eigenvalues, 0.0, upper)) @ eigenvectors.T


def decode_covariance(
    messages: Sequence[str],
    dimensions: Sequence[int],
    budgets: Sequence[int],
    n: int,
    scale: float,
) -> np.ndarray:
    """The server uses public parameters and finite messages only."""
    if len(messages) != len(dimensions) or len(messages) != len(budgets):
        raise ValueError("Mismatched agent parameters.")
    if any(len(word) != budget for word, budget in zip(messages, budgets)):
        raise ValueError("A message violates its public frame length.")
    d = sum(dimensions)
    if n == 0 or scale == 0:
        return np.zeros((d, d))
    blocks = []
    for word, dimension in zip(messages, dimensions):
        block = decode_local(word, n, dimension)
        if block is None:
            return np.zeros((d, d))
        blocks.append(block)
    replicas = scale * np.concatenate(blocks, axis=2)
    z, z_prime = replicas[:, 0, :], replicas[:, 1, :]
    cross = z.T @ z_prime / n
    return clip_covariance((cross + cross.T) / 2, scale**2)


@dataclass(frozen=True)
class ProtocolResult:
    estimate: np.ndarray
    effective_pairs: int
    messages: tuple[str, ...]
    records: tuple[EncodingRecord, ...]


def run_protocol(
    samples: np.ndarray,
    dimensions: Sequence[int],
    budgets: Sequence[int],
    scale: float,
    private_seed: int,
) -> ProtocolResult:
    """Simulation harness; derived seeds are not supplied to the decoder.

    The harness distributes local views and independent pseudorandom streams.
    The theoretical protocol uses genuinely independent private uniform coins.
    """
    samples = np.asarray(samples, dtype=float)
    if samples.ndim != 2 or sum(dimensions) != samples.shape[1]:
        raise ValueError("Feature partition does not match the samples.")
    if not np.isfinite(samples).all():
        raise ValueError("Finite input samples are required by this reference.")
    n = effective_pairs(samples.shape[0], dimensions, budgets)
    if scale == 0:
        n = 0
    seeds = np.random.SeedSequence(private_seed).spawn(len(dimensions))
    messages, records = [], []
    start = 0
    for dimension, budget, seed in zip(dimensions, budgets, seeds):
        word, record = encode_local(
            samples[:, start : start + dimension], n, scale, budget,
            np.random.default_rng(seed),
        )
        messages.append(word)
        records.append(record)
        start += dimension
    estimate = decode_covariance(messages, dimensions, budgets, n, scale)
    return ProtocolResult(estimate, n, tuple(messages), tuple(records))
