"""Executable reference for the reduction and Gaussian cycle controller.

The mathematical statements are in the manuscripts.  The controller below uses
floating-point log/sqrt and is a reference implementation, not a certified
finite-precision statistical test.  The exact combinatorial checks exercise the
sample-clock reduction; they do not verify an infinite-horizon regret theorem.
"""
from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from hashlib import sha256
from math import comb, isfinite, log, pi, sqrt
from pathlib import Path
from typing import Callable, Sequence
import argparse
import json


@dataclass(frozen=True)
class PrefixOutcome:
    outcome: str
    first_arm_observations: int
    second_arm_observations: int
    decisions: int


def finite_prefix_test(
    choose_arm: Callable[[tuple[tuple[int, object], ...]], int],
    first_samples: Sequence[object],
    second_prefix: Sequence[object],
    threshold: int,
) -> PrefixOutcome:
    """Decide whether the M-th arm-2 choice occurs within n arm-1 samples.

    The policy must be causal; supply its random seed inside choose_arm.
    At most M-1 arm-2 rewards are needed.  Reaching the M-th arm-2 *choice*
    terminates before its reward is observed.  A request for the (n+1)-st arm-1
    reward certifies that the stopping time exceeds n.
    """
    if type(threshold) is not int or threshold < 1:
        raise ValueError("threshold must be a positive integer")
    if len(second_prefix) < threshold - 1:
        raise ValueError("Need the first M-1 second-arm observations")
    history: list[tuple[int, object]] = []
    n1 = n2 = 0
    while True:
        action = choose_arm(tuple(history))
        if action not in (1, 2):
            raise ValueError("A policy must choose arm 1 or arm 2")
        decisions = len(history) + 1
        if action == 2:
            if n2 + 1 == threshold:
                return PrefixOutcome("threshold_reached", n1, n2, decisions)
            history.append((2, second_prefix[n2]))
            n2 += 1
        else:
            if n1 == len(first_samples):
                return PrefixOutcome("input_exhausted", n1, n2, decisions)
            history.append((1, first_samples[n1]))
            n1 += 1


class GaussianCyclePolicy:
    """Anytime diagnostic/screening policy; no horizon or unknown gap input.

    Baseline means are (0,-1), alternative means (-Delta,0), unit variances.
    A diagnostic phase draws arm 2 until its log likelihood ratio for N(-1,1)
    versus N(0,1) reaches h.  The screening phase draws arm 1 and tests at
    sample sizes 1,2,4,... using a summable error allocation.  A rejection
    restarts a fresh diagnostic phase.
    """

    def __init__(self, h: float, beta: float) -> None:
        if not isfinite(h) or h <= 0:
            raise ValueError("h must be positive and finite")
        if not isfinite(beta) or not 0 < beta < 1:
            raise ValueError("beta must lie in (0,1)")
        self.h = float(h)
        self.beta = float(beta)
        self.phase = "diagnostic"
        self.diagnostic_score = 0.0
        self.screening_sum = 0.0
        self.screening_count = 0
        self.total_arm1 = 0
        self.total_arm2 = 0
        self.screening_rejections = 0

    def next_arm(self) -> int:
        return 2 if self.phase == "diagnostic" else 1

    def observe(self, arm: int, reward: float) -> None:
        if arm != self.next_arm():
            raise ValueError("Observation must match the selected arm")
        if not isfinite(reward):
            raise ValueError("Reward must be finite")
        if arm == 2:
            self.total_arm2 += 1
            self.diagnostic_score += -reward - 0.5
            if self.diagnostic_score >= self.h:
                self.phase = "screening"
                self.screening_sum = 0.0
                self.screening_count = 0
        else:
            self.total_arm1 += 1
            self.screening_count += 1
            self.screening_sum += reward
            n = self.screening_count
            if n & (n - 1) == 0:
                k = n.bit_length() - 1
                log_weight = log(pi * pi / (6 * self.beta)) + 2 * log(k + 1)
                boundary = sqrt(2 * n * log_weight)
                if self.screening_sum <= -boundary:
                    self.screening_rejections += 1
                    self.phase = "diagnostic"
                    self.diagnostic_score = 0.0

    @classmethod
    def from_baseline_budget(cls, budget: float) -> GaussianCyclePolicy:
        """Gaussian overshoot construction with baseline budget C >= 9."""
        if not isfinite(budget) or budget < 9:
            raise ValueError("This displayed parameter formula requires C >= 9")
        return cls(budget / 2 - 3.5, 1 / budget)

    @classmethod
    def from_large_baseline_budget(cls, budget: float) -> GaussianCyclePolicy:
        """Parameters used by the conservative large-budget Gaussian bound."""
        if not isfinite(budget) or budget < 256:
            raise ValueError("This displayed parameter formula requires C >= 256")
        return cls(budget / 2 - 4 * sqrt(budget) - 20, 1 / sqrt(budget))


def _terminal_words(n: int, threshold: int):
    """All possible action words up to one of the two censoring boundaries."""
    stack = [(0, 0, ())]
    while stack:
        n1, n2, word = stack.pop()
        for action in (1, 2):
            extended = word + (action,)
            if action == 1 and n1 == n:
                yield extended, "input_exhausted"
            elif action == 2 and n2 + 1 == threshold:
                yield extended, "threshold_reached"
            elif action == 1:
                stack.append((n1 + 1, n2, extended))
            else:
                stack.append((n1, n2 + 1, extended))


def exact_checks() -> dict:
    instances = terminals = 0
    for n in range(7):
        for threshold in range(1, 7):
            instances += 1
            count = 0
            for word, outcome in _terminal_words(n, threshold):
                def policy(history, word=word):
                    return word[len(history)]
                result = finite_prefix_test(
                    policy, tuple(Fraction(k, 7) for k in range(n)),
                    tuple(Fraction(-k, 11) for k in range(threshold - 1)),
                    threshold,
                )
                if result.outcome != outcome:
                    raise ArithmeticError("Sample-clock event mismatch")
                if result.decisions != len(word) or result.decisions > n + threshold:
                    raise ArithmeticError("The n+M decision bound failed")
                if result.second_arm_observations >= threshold:
                    raise ArithmeticError("The M-th arm-2 reward was accessed")
                count += 1
            if count != comb(n + threshold + 1, threshold):
                raise ArithmeticError("Exhaustive action-word count mismatch")
            terminals += count

    geometric = []
    for p in (Fraction(1, 2), Fraction(1, 3), Fraction(1, 5), Fraction(2, 3)):
        g = Fraction(3, 7)
        horizon = 20
        partial = g * sum((1-p)**k for k in range(horizon))
        tail = g * (1-p)**horizon / p
        if partial + tail != g / p:
            raise ArithmeticError("Singular-witness geometric cost identity failed")
        geometric.append({"p": str(p), "g": str(g), "exact_regret": str(g/p)})

    controller = GaussianCyclePolicy(2, .1)
    for _ in range(4):
        if controller.next_arm() != 2:
            raise ArithmeticError("Diagnostic exit happened too early")
        controller.observe(2, -1)
    if controller.next_arm() != 1:
        raise ArithmeticError("Diagnostic phase did not exit")
    controller.observe(1, -10)
    if controller.next_arm() != 2 or controller.screening_rejections != 1:
        raise ArithmeticError("Screening rejection did not restart diagnostics")
    for _ in range(4):
        controller.observe(2, -1)
    for _ in range(16):
        controller.observe(1, 0)
    if controller.next_arm() != 1:
        raise ArithmeticError("Zero data crossed a negative boundary")
    budget_policy = GaussianCyclePolicy.from_baseline_budget(9)
    if budget_policy.h != 1 or budget_policy.beta != 1 / 9:
        raise ArithmeticError("Gaussian budget parameter mapping failed")

    return {
        "status": "PASS",
        "source_sha256": sha256(Path(__file__).read_bytes()).hexdigest(),
        "sample_clock_parameter_pairs": instances,
        "exhaustive_terminal_action_words": terminals,
        "exact_geometric_identities": geometric,
        "controller_checks": "phase transition and reset semantics only",
        "scope": "Exact finite reduction logic and reference-controller semantics",
        "statistical_theorem_verified_by_tests": False,
        "finite_precision_statistical_validity_certified": False,
        "random_simulations_used": False,
    }


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true")
    args = parser.parse_args()
    if args.check:
        print(json.dumps(exact_checks(), indent=2, sort_keys=True))
    else:
        parser.print_help()
