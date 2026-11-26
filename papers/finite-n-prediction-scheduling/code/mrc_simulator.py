#!/usr/bin/env python3
"""Exact event-driven replay of Algorithm 1 of arXiv:2610.32503v2.

This is an experimental implementation, not a proof of a uniform performance
guarantee.  It also admits the proposed finite-n parameter range
R >= 2*n/(n+1); that extension is explicitly checked at each executed event.
Processing times are known to the simulator solely to trigger completion
events, never to the rate-selection rule.  Every arithmetic assertion in
``simulate_exact`` uses Fraction, including endpoint and derivative checks.
"""

from __future__ import annotations

import argparse
import json
from dataclasses import dataclass
from fractions import Fraction
from typing import Sequence


def rational(value: int | float | str | Fraction) -> Fraction:
    return value if isinstance(value, Fraction) else Fraction(str(value))


def phi(elapsed: Sequence[Fraction]) -> Fraction:
    """SPT optimum for the frozen instance, including completed jobs."""
    return sum(((len(elapsed) - i) * x for i, x in enumerate(sorted(elapsed))), Fraction(0))


def phi_right_derivative(elapsed: Sequence[Fraction], rates: Sequence[Fraction]) -> Fraction:
    answer = sum(rates, Fraction(0))
    for i in range(len(elapsed)):
        for j in range(i + 1, len(elapsed)):
            if elapsed[i] < elapsed[j]:
                answer += rates[i]
            elif elapsed[j] < elapsed[i]:
                answer += rates[j]
            else:
                answer += min(rates[i], rates[j])
    return answer


@dataclass
class ExactRun:
    sizes: list[Fraction]
    order: list[int]
    robustness: Fraction
    completion_times: list[Fraction]
    cost: Fraction
    optimum: Fraction
    trace: list[dict]

    @property
    def ratio(self) -> Fraction:
        return self.cost / self.optimum

    def as_dict(self) -> dict:
        return {
            "sizes": [str(x) for x in self.sizes],
            "predicted_order": self.order,
            "R": str(self.robustness),
            "completion_times": [str(x) for x in self.completion_times],
            "cost": str(self.cost),
            "optimum": str(self.optimum),
            "ratio_exact": str(self.ratio),
            "ratio_decimal": float(self.ratio),
            "events": self.trace,
            "claims": "Exact replay of this finite instance only; not a general theorem.",
        }


def simulate_exact(
    processing_times: Sequence[int | float | str | Fraction],
    robustness: int | float | str | Fraction,
    predicted_order: Sequence[int] | None = None,
    keep_trace: bool = True,
) -> ExactRun:
    if not __debug__:
        raise RuntimeError("Run exact replay without Python -O; exact assertions are required.")
    p = [rational(x) for x in processing_times]
    n = len(p)
    if not p or any(x <= 0 for x in p):
        raise ValueError("All processing times must be strictly positive.")
    R = rational(robustness)
    if R < Fraction(2 * n, n + 1):
        raise ValueError("Parameter outside proposed finite-n feasible range.")
    order = list(range(n)) if predicted_order is None else list(predicted_order)
    if sorted(order) != list(range(n)):
        raise ValueError("predicted_order must be a permutation of the jobs.")
    e = [Fraction(0) for _ in p]
    completions: list[Fraction | None] = [None] * n
    t = Fraction(0)
    F = Fraction(0)
    trace = []
    for step in range(20 * n * n + 20):
        unfinished = [i for i in order if completions[i] is None]
        if not unfinished:
            break
        N, j = len(unfinished), unfinished[0]
        waiting = unfinished[1:]
        completed = [i for i in range(n) if completions[i] is not None]
        D = F - R * phi(e)
        assert D <= 0, ("frozen-instance invariant violated", D, e)
        gc = Fraction(1 + sum(x > e[j] for x in e))
        gr: Fraction | None = None
        level: Fraction | None = None
        if N == 1:
            a = Fraction(1)
            b = Fraction(0)
            branch = "last_job"
        else:
            level = e[waiting[0]]
            assert all(e[i] == level for i in waiting), ("waiting levels differ", e)
            assert e[j] >= level, ("committed job below level", e)
            gr = Fraction(1 + sum(e[i] > level for i in range(n) if i != j)) + Fraction(N, 2)
            if D < 0 or gc >= Fraction(N, 1) / R:
                a = Fraction(1)
                branch = "commit"
            else:
                assert gr > gc, ("nonpositive mixing denominator", gr, gc)
                a = (gr - Fraction(N, 1) / R) / (gr - gc)
                branch = "mix"
            b = (1 - a) / (N - 1)
            assert 0 <= b <= a <= 1, ("invalid or order-reversing rates", a, b)
        rates = [Fraction(0) for _ in p]
        rates[j] = a
        for i in waiting:
            rates[i] = b
        assert sum(rates, Fraction(0)) == 1
        dp = phi_right_derivative(e, rates)
        if gr is not None:
            assert dp == a * gc + (1 - a) * gr, ("rate formula mismatch", dp, gc, gr, a)
        else:
            assert dp == gc
        dD = N - R * dp
        if D == 0:
            assert dD <= 0, ("infeasible boundary derivative", dD)
        candidates: list[tuple[Fraction, str]] = []
        for i in unfinished:
            if rates[i] > 0:
                candidates.append(((p[i] - e[i]) / rates[i], f"complete:{i}"))
        if D < 0 and dD > 0:
            candidates.append((-D / dD, "slack_zero"))
        for i in completed:
            if p[i] > e[j] and a > 0:
                candidates.append(((p[i] - e[j]) / a, f"committed_reaches_completed:{i}"))
            if level is not None and p[i] > level and b > 0:
                candidates.append(((p[i] - level) / b, f"level_reaches_completed:{i}"))
        assert candidates and all(dt > 0 for dt, _ in candidates)
        dt = min(dt for dt, _ in candidates)
        event_names = [label for when, label in candidates if when == dt]
        next_e = [e[i] + rates[i] * dt for i in range(n)]
        assert all(next_e[i] <= p[i] for i in range(n)), ("processing overshoot", next_e, p)
        next_F = F + N * dt
        next_t = t + dt
        next_D = next_F - R * phi(next_e)
        assert next_D == D + dD * dt, ("missed slope-change event", D, next_D, dt, dD)
        assert next_D <= 0
        finished = [i for i in unfinished if next_e[i] == p[i]]
        if keep_trace:
            trace.append({
                "step": step, "time_start": str(t), "time_end": str(next_t),
                "unfinished": unfinished, "committed": j, "branch": branch,
                "elapsed_start": [str(x) for x in e],
                "elapsed_end": [str(x) for x in next_e],
                "rates": [str(x) for x in rates],
                "gamma_commit": str(gc), "gamma_round_robin": str(gr) if gr is not None else None,
                "slack_start": str(D), "slack_end": str(next_D),
                "cost_start": str(F), "cost_end": str(next_F),
                "events": event_names, "completed_now": finished,
            })
        for i in finished:
            completions[i] = next_t
        e, F, t = next_e, next_F, next_t
    else:
        raise AssertionError("event limit exceeded")
    assert all(x is not None for x in completions)
    cs = [x for x in completions if x is not None]
    assert sum(cs, Fraction(0)) == F
    optimum = phi(p)
    assert F <= R * optimum
    return ExactRun(p, order, R, cs, F, optimum, trace)


def simulate_float(processing_times: Sequence[float], robustness: float) -> float:
    """Fast search oracle; every positive finding needs exact replay.

    Jobs appear in predicted order. Distinct event levels use tight relative
    tolerances; this routine is deliberately never used as a proof certificate.
    """
    p = list(map(float, processing_times))
    n = len(p)
    e = [0.0] * n
    done = [False] * n
    F = 0.0
    for _ in range(30 * n * n + 30):
        active = [i for i in range(n) if not done[i]]
        if not active:
            return F / sum((n - i) * x for i, x in enumerate(sorted(p)))
        N, j = len(active), active[0]
        waiting = active[1:]
        completed = [i for i in range(n) if done[i]]
        frozen = sum((n - i) * x for i, x in enumerate(sorted(e)))
        D = F - robustness * frozen
        tol = 2e-12 * max(1.0, abs(F), abs(robustness * frozen))
        gc = 1 + sum(x > e[j] + 1e-12 * max(1.0, abs(x), abs(e[j])) for x in e)
        level = e[waiting[0]] if waiting else None
        if N == 1:
            a, b = 1.0, 0.0
        else:
            gr = 1 + sum(e[i] > level + 1e-12 * max(1.0, abs(e[i]), abs(level)) for i in range(n) if i != j) + N / 2
            a = 1.0 if D < -tol or gc >= N / robustness - 1e-13 else (gr - N / robustness) / (gr - gc)
            a = min(1.0, max(a, 1 / N))
            b = (1 - a) / (N - 1)
        rates = [0.0] * n
        rates[j] = a
        for i in waiting:
            rates[i] = b
        candidates = [(p[i] - e[i]) / rates[i] for i in active if rates[i] > 0]
        dp = gc if N == 1 else a * gc + (1 - a) * gr
        dD = N - robustness * dp
        if D < -tol and dD > 1e-12:
            candidates.append(-D / dD)
        for i in completed:
            if p[i] > e[j] + 1e-12 * max(1.0, abs(p[i])) and a > 0:
                candidates.append((p[i] - e[j]) / a)
            if level is not None and p[i] > level + 1e-12 * max(1.0, abs(p[i])) and b > 0:
                candidates.append((p[i] - level) / b)
        dt = max(0.0, min(candidates))
        F += N * dt
        for i in active:
            e[i] += rates[i] * dt
            if p[i] - e[i] <= 2e-12 * max(1.0, p[i]):
                e[i] = p[i]
                done[i] = True
    raise ArithmeticError("floating-point event loop did not terminate")


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--sizes", nargs="+", required=True)
    parser.add_argument("--robustness", required=True)
    parser.add_argument("--order", nargs="+", type=int)
    parser.add_argument("--output")
    args = parser.parse_args()
    payload = simulate_exact(args.sizes, args.robustness, args.order).as_dict()
    text = json.dumps(payload, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        with open(args.output, "w", encoding="utf-8") as handle:
            handle.write(text)
    else:
        print(text, end="")


if __name__ == "__main__":
    main()
