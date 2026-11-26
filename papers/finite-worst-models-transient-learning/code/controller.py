"""Exact finite-model Bayesian controller with posterior hysteresis.

Only Python's standard library is used.  A model has shape
``[state][action][next_state]`` and a candidate stationary policy has shape
``[state][action]``.  Every entry must be an int, Fraction, or rational string;
binary floating-point input is rejected to keep the advertised arithmetic exact.

At a decision time, retain the active candidate if its posterior is at least
1/(2m).  Otherwise select the lowest-index posterior maximizer.  The first
selection is not a switch.  The caller samples from the returned distribution,
or enumerates that distribution exactly, and supplies the observed transition.

The update uses the action-conditioned transition likelihood.  Conditional on
the entire observed history, the controller chooses the same action distribution
under every environmental hypothesis.  Its action-probability factor therefore
cancels from Bayes' rule; replacing the transition likelihood by a policy-averaged
kernel after observing the action would be incorrect.

No randomness, environment access, or oracle is hidden in this implementation.
An observation with zero likelihood under every surviving hypothesis raises
ImpossibleObservation.  It never silently resets the posterior.  Such an
observation has probability zero in the stated realizable, positive-prior model.
"""

from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
from typing import Sequence


def rational(value: int | str | Fraction) -> Fraction:
    """Convert explicit rational data, rejecting floats and booleans."""
    if isinstance(value, bool) or not isinstance(value, (int, str, Fraction)):
        raise TypeError("Exact rational input required; floats are not accepted")
    return Fraction(value)


def probability_vector(values: Sequence, length: int | None = None) -> tuple:
    row = tuple(rational(value) for value in values)
    if not row or (length is not None and len(row) != length):
        raise ValueError("Probability-vector dimension mismatch")
    if min(row) < 0 or sum(row) != 1:
        raise ValueError("A probability vector must be nonnegative and sum to one")
    return row


class ImpossibleObservation(ValueError):
    """The observed transition has zero probability in the surviving model set."""


@dataclass(frozen=True)
class ControllerState:
    """An immutable information state, suitable as an exact-enumerator key."""

    posterior: tuple[Fraction, ...]
    active: int | None = None
    switches: int = 0


class StickyPosteriorController:
    """Finite known models and a supplied model-safe policy for each model.

    The constructor checks dimensions and probability simplices.  It does not
    assert that a supplied policy is safe: that mathematical precondition must be
    established separately (the accompanying verifier computes recurrent-class
    means for its concrete examples).
    """

    def __init__(self, models: Sequence, policies: Sequence):
        if not models or not models[0] or not models[0][0]:
            raise ValueError("At least one nonempty model is required")
        self.m = len(models)
        self.n = len(models[0])
        self.k = len(models[0][0])
        normalized = []
        for model in models:
            if len(model) != self.n:
                raise ValueError("All models must have the same states")
            rows = []
            for actions in model:
                if len(actions) != self.k:
                    raise ValueError("All models must have the same actions")
                rows.append(tuple(probability_vector(row, self.n) for row in actions))
            normalized.append(tuple(rows))
        if len(policies) != self.m:
            raise ValueError("Exactly one candidate policy per model is required")
        normalized_policies = []
        for policy in policies:
            if len(policy) != self.n:
                raise ValueError("Policy-state dimension mismatch")
            normalized_policies.append(tuple(
                probability_vector(row, self.k) for row in policy
            ))
        self.models = tuple(normalized)
        self.policies = tuple(normalized_policies)
        self.threshold = Fraction(1, 2 * self.m)

    def initial(self, prior: Sequence | None = None) -> ControllerState:
        """Return a fresh information state; the theorem uses the uniform prior."""
        weights = ((Fraction(1, self.m),) * self.m if prior is None
                   else probability_vector(prior, self.m))
        if min(weights) <= 0:
            raise ValueError("The initial prior must give every model positive mass")
        return ControllerState(weights)

    def _validate(self, current: ControllerState) -> None:
        probability_vector(current.posterior, self.m)
        if current.active is not None and not 0 <= current.active < self.m:
            raise ValueError("Invalid active-candidate index")
        if current.switches < 0:
            raise ValueError("The switch count cannot be negative")

    def select(self, current: ControllerState) -> ControllerState:
        """Apply the threshold before the next action; ties use smallest index."""
        self._validate(current)
        if (current.active is not None
                and current.posterior[current.active] >= self.threshold):
            return current
        largest = max(current.posterior)
        chosen = current.posterior.index(largest)
        increment = int(current.active is not None and chosen != current.active)
        return ControllerState(current.posterior, chosen, current.switches + increment)

    def decide(self, current: ControllerState, state: int) -> tuple:
        """Return the selected information state and its action distribution."""
        if not 0 <= state < self.n:
            raise ValueError("Invalid physical state")
        selected = self.select(current)
        return selected, self.policies[selected.active][state]

    def observe(
        self,
        current: ControllerState,
        state: int,
        action: int,
        next_state: int,
    ) -> ControllerState:
        """Condition on an observed, actually chosen action and its successor.

        No next decision is made here.  In particular the switch count changes
        only on the following call to ``select`` or ``decide``.  Inputs are
        immutable, including on exceptions.
        """
        self._validate(current)
        if current.active is None:
            raise ValueError("Call decide before observing a transition")
        if not (0 <= state < self.n and 0 <= next_state < self.n
                and 0 <= action < self.k):
            raise ValueError("Invalid state or action index")
        if current.posterior[current.active] < self.threshold:
            raise ValueError("The active candidate must be selected before acting")
        if self.policies[current.active][state][action] == 0:
            raise ImpossibleObservation("The chosen action has zero controller probability")
        masses = tuple(
            current.posterior[j] * self.models[j][state][action][next_state]
            for j in range(self.m)
        )
        evidence = sum(masses)
        if evidence == 0:
            raise ImpossibleObservation("Transition outside the surviving model support")
        posterior = tuple(mass / evidence for mass in masses)
        return ControllerState(posterior, current.active, current.switches)

