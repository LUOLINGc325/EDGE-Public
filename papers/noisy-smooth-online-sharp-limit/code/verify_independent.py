#!/usr/bin/env python3
"""Independent, finite-grid certificate for the k-th insertion-distance bound.

This uses exhaustive Bellman optimization on capped occupancy counts, without
importing the project's other verifier or using its coloring construction.
The dynamic program uses integer distances on an equally spaced grid. Fractions
are used for the certified value, theorem comparison, and independent replay.

Coverage: all finite/infinite input sequences on each listed finite grid, after
any unscored block of k observations. This does NOT prove the continuum theorem.

Why the finite state space covers arbitrarily long sequences:
    (1) Occupancies may be capped at k, since larger occupancies cannot alter any
        k-th nearest distance.
    (2) Inserting at a coordinate already holding k observations has distance
        zero and leaves this capped state unchanged; it can be removed.
    (3) Every remaining transition increments a coordinate smaller than k, so
        the state graph is acyclic and has at most (k+1)^m states.
    (4) Nonnegative rewards mean extending a path until all counts are k cannot
        lower its reward. Thus a finite Bellman recurrence computes the exact
        supremum, including sequences that stop early or continue forever.

The single-nearest-neighbor constant is a known result (Kimber--Long, 1995;
Geneson--Zhou, 2023, Lemma 2.18). This certificate makes no novelty claim.
"""

from __future__ import annotations

import argparse
from fractions import Fraction
import hashlib
import json
from pathlib import Path
import sys


EXPONENTS = (2, 3, 4, 8)
GRID_CASES = (
    (3, 1), (3, 2), (3, 3), (3, 5),
    (5, 1), (5, 2), (5, 3), (5, 5),
    (7, 1), (7, 2), (7, 3),
)


def require(condition: bool, message: str) -> None:
    """Keep all certificate checks active under `python -O`."""
    if not condition:
        raise RuntimeError(message)


def fraction_record(value: Fraction) -> dict[str, int | str]:
    return {
        "numerator": value.numerator,
        "denominator": value.denominator,
        "text": str(value),
    }


def decode(code: int, base: int, size: int) -> tuple[int, ...]:
    values = []
    for _ in range(size):
        code, value = divmod(code, base)
        values.append(value)
    require(code == 0, "State code does not fit the requested occupancy vector")
    return tuple(values)


def kth_integer_radius(counts: tuple[int, ...], position: int, k: int) -> int:
    """Radius in grid-step units, computed by expanding shells."""
    seen = counts[position]
    if seen >= k:
        return 0
    for radius in range(1, len(counts)):
        if position - radius >= 0:
            seen += counts[position - radius]
        if position + radius < len(counts):
            seen += counts[position + radius]
        if seen >= k:
            return radius
    raise RuntimeError("A defined k-th nearest radius was not found")


def replay_with_fractions(
    m: int, k: int, exponent: int, initial: tuple[int, ...], actions: list[int]
) -> Fraction:
    """Independent definition-based replay: explicit multiset and full sorting.

    This does not use the shell search or integer Bellman radius calculation.
    """
    grid = [Fraction(j, m - 1) for j in range(m)]
    observed = [grid[j] for j, copies in enumerate(initial) for _ in range(copies)]
    require(len(observed) == k, "Replay must have exactly k unscored observations")
    loss = Fraction(0)
    for j in actions:
        require(0 <= j < m, "Witness position outside grid")
        x = grid[j]
        distances = sorted(abs(x - y) for y in observed)
        loss += distances[k - 1] ** exponent
        observed.append(x)
    return loss


def verify_case(m: int, k: int) -> list[dict]:
    require(m >= 2 and k >= 1, "Bad grid or neighbor count")
    base = k + 1
    states = base ** m
    require(states <= 300_000, "The exhaustive certificate budget was exceeded")
    increments = [base ** j for j in range(m)]
    full_code = states - 1

    # F_s(c) is measured in units of 1/(m-1)^s, so every DP entry is an integer.
    scores = [[0] * states for _ in EXPONENTS]
    choices = [[-1] * states for _ in EXPONENTS]
    maxima = [-1] * len(EXPONENTS)
    best_initial_codes = [-1] * len(EXPONENTS)
    eligible_states = 0
    initial_states = 0
    transitions = 0

    # Incrementing one count increases the mixed-radix state code, hence this
    # decreasing traversal visits every child before its parent.
    for code in range(full_code, -1, -1):
        counts = decode(code, base, m)
        total = sum(counts)
        if total < k:
            continue
        eligible_states += 1
        moves = []
        for j, copies in enumerate(counts):
            if copies < k:
                radius = kth_integer_radius(counts, j, k)
                require(radius > 0, "An unsaturated coordinate had zero radius")
                child = code + increments[j]
                require(child > code and child < states, "Invalid acyclic transition")
                moves.append((j, child, radius))
        transitions += len(moves)
        for h, exponent in enumerate(EXPONENTS):
            best_value = 0
            best_move = -1
            for j, child, radius in moves:
                candidate = radius ** exponent + scores[h][child]
                if candidate > best_value:
                    best_value, best_move = candidate, j
            scores[h][code] = best_value
            choices[h][code] = best_move
            if total == k and (
                best_value > maxima[h]
                or (best_value == maxima[h] and code < best_initial_codes[h])
            ):
                maxima[h], best_initial_codes[h] = best_value, code
        if total == k:
            initial_states += 1

    results = []
    for h, exponent in enumerate(EXPONENTS):
        start = best_initial_codes[h]
        require(start >= 0, "No initial occupancy found")
        initial = decode(start, base, m)
        require(sum(initial) == k, "Maximizer has wrong initial occupancy")
        actions = []
        code = start
        while code != full_code:
            j = choices[h][code]
            require(0 <= j < m, "Nonterminal state lacks a Bellman action")
            counts = decode(code, base, m)
            require(counts[j] < k, "Witness attempted a saturated transition")
            child = code + increments[j]
            radius = kth_integer_radius(counts, j, k)
            require(
                scores[h][code] == radius ** exponent + scores[h][child],
                "Bellman witness equality failed",
            )
            actions.append(j)
            code = child
            require(len(actions) <= m * k, "Witness did not reach saturation")
        require(len(actions) == (m - 1) * k, "Wrong saturated path length")

        optimum = Fraction(maxima[h], (m - 1) ** exponent)
        replay = replay_with_fractions(m, k, exponent, initial, actions)
        require(replay == optimum, "Independent fractional replay disagrees with DP")
        bound = k * (Fraction(1) + Fraction(1, 2 ** exponent - 2))
        require(optimum <= bound, "Finite grid violates the proposed continuum bound")

        # Endpoint-only initial history provides a second, fixed starting-state
        # check; this is not used to compute the unrestricted initial maximum.
        endpoint_start = k  # c_0 = k, all other counts zero.
        endpoint_optimum = Fraction(scores[h][endpoint_start], (m - 1) ** exponent)
        require(endpoint_optimum <= optimum, "Endpoint start exceeds global initial maximum")

        results.append({
            "grid_size": m,
            "k": k,
            "s": exponent,
            "grid": [str(Fraction(j, m - 1)) for j in range(m)],
            "state_space_size": states,
            "states_with_at_least_k_observations": eligible_states,
            "initial_occupancy_states": initial_states,
            "nonzero_reward_transitions": transitions,
            "maximum_scaled_integer_energy": maxima[h],
            "distance_power_denominator": (m - 1) ** exponent,
            "exact_grid_optimum": fraction_record(optimum),
            "continuum_bound": fraction_record(bound),
            "strict_slack": fraction_record(bound - optimum),
            "endpoint_initial_optimum": fraction_record(endpoint_optimum),
            "witness": {
                "initial_counts": list(initial),
                "scored_position_indices": actions,
                "independent_fraction_replay": fraction_record(replay),
            },
            "checks_passed": True,
        })
    return results


def make_certificate() -> dict:
    results = []
    for m, k in GRID_CASES:
        results.extend(verify_case(m, k))
    require(len(results) == len(GRID_CASES) * len(EXPONENTS), "Missing certificate case")
    return {
        "certificate_kind": "exact exhaustive finite-grid Bellman optimization",
        "arithmetic": "Python integers with Fraction value comparison and independent replay",
        "independence": "No imports from the main verifier; no coloring argument used in the DP",
        "scope": (
            "For each listed grid, k, and s, exactly optimizes the sum of the s-th powers "
            "of the k-th nearest prior-observation distances over every initial block of k "
            "observations and every subsequent sequence, including repeated positions and "
            "arbitrarily long zero-reward tails. This does not prove the real-interval theorem."
        ),
        "geometric_bound": "k * (1 + 1 / (2**s - 2))",
        "source_attribution": (
            "The k=1 geometric constant is known from Kimber--Long (1995), as restated in "
            "Geneson--Zhou (2023), Lemma 2.18. No novelty is claimed by this verifier."
        ),
        "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
        "case_count": len(results),
        "all_checks_passed": all(row["checks_passed"] for row in results),
        "cases": results,
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "--output", type=str,
        default=str(Path(__file__).resolve().parents[1] / "results" / "independent_certificate.json"),
        help="Certificate JSON path; use '-' for standard output",
    )
    args = parser.parse_args()
    certificate = make_certificate()
    payload = json.dumps(certificate, ensure_ascii=False, indent=2, sort_keys=True) + "\n"
    if args.output == "-":
        sys.stdout.write(payload)
        return
    destination = Path(args.output)
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(payload, encoding="utf-8")
    print(f"PASS: {certificate['case_count']} exhaustive finite-grid cases; exact witnesses replayed.")
    print(f"Certificate: {destination}")
    print("Coverage is finite grids only; the continuum theorem is proved in the manuscript.")


if __name__ == "__main__":
    main()
