"""Reproducible event simulation; diagnostics, not a proof of asymptotic claims.

Both examples use the four-edge graph with lambda=(.4,.6), mu=(3,3),
epsilon=1. Server caps are redundant, so the robust LP certificate reduces
exactly to two row comparisons. No abandoned jobs or reward-at-arrival shortcut.
"""
from __future__ import annotations

import argparse
from collections import deque
import json
import math
from pathlib import Path

import numpy as np


LAMBDA = np.array([.4, .6])
MU = np.array([3., 3.])
THETA0 = np.array([[4., 1.], [2., 3.]])


def simulate(mode: str, horizon: int, seed: int, beta: float = 32., alternate=False):
    rng = np.random.default_rng(seed)
    theta = (np.array([[.95, .05], [.05, .95]]) if mode == "certificate"
             else (np.array([[4., 5.], [2., 3.]]) if alternate else THETA0.copy()))
    queues = [deque(), deque()]
    in_service = [None, None]
    completion = [math.inf, math.inf]
    arrivals = np.zeros((2, 2), dtype=np.int64)
    departures = np.zeros((2, 2), dtype=np.int64)
    reward_sum = np.zeros((2, 2), dtype=float)
    target = None
    x0 = np.array([[.4, 0.], [0., .6]])
    q0 = np.column_stack((LAMBDA / 2, LAMBDA / 2))
    latest = np.column_stack((LAMBDA, np.zeros(2)))
    rates = latest.copy()
    next_arrival = float(rng.exponential(1.))
    next_slot = 0. if mode == "certificate" else math.inf
    checkpoints = sorted(set([0, horizon] + [min(horizon, int(x)) for x in np.geomspace(1, horizon, 70)]))
    checkpoint_index = 0
    next_record = float(checkpoints[0])
    time = 0.
    assignment_loss = 0.
    explored_time = 0.
    active_time = 0.
    exploration_slots = 0
    certificate_refreshes = 0
    first_certificate = None
    records = []
    optimum_rate = float(np.sum(LAMBDA * np.max(theta, axis=1)))

    def choose_target():
        nonlocal target
        target = None
        for i in range(2):
            for j in range(2):
                n = int(departures[i, j])
                if n and abs(reward_sum[i, j] / n - THETA0[i, j]) > n ** (-.25):
                    target = (i, j)
                    return

    def start_service(j, now):
        if in_service[j] is not None or not queues[j]:
            return
        pos = 0
        if target is not None and target[1] == j:
            wanted = target[0]
            for index, (i, _) in enumerate(queues[j]):
                if i == wanted:
                    pos = index
                    break
        job = queues[j][pos]
        del queues[j][pos]
        in_service[j] = job
        completion[j] = now + float(rng.exponential(1. / MU[j]))

    def pending():
        counts = np.zeros((2, 2), dtype=np.int64)
        for j in range(2):
            for i, _ in queues[j]:
                counts[i, j] += 1
            if in_service[j] is not None:
                counts[in_service[j][0], j] += 1
        assert np.array_equal(arrivals - departures, counts), "exact flow conservation failed"
        return counts

    exploring = False
    while time <= horizon:
        event_time = min(next_arrival, min(completion), next_slot, next_record, float(horizon))
        dt = event_time - time
        assert dt >= -1e-10
        if mode == "certificate":
            assignment_loss += dt * (optimum_rate - float(np.sum(theta * rates)))
            explored_time += dt * exploring
        else:
            if target is not None:
                assignment_loss += dt * (optimum_rate - float(np.sum(theta * q0)))
                active_time += dt
            else:
                # Exact integral of p(s)=1/((e+s)log(e+s)) on the segment.
                integral_p = math.log(math.log(math.e + event_time)) - math.log(math.log(math.e + time))
                assignment_loss += dt * (optimum_rate - float(np.sum(theta * x0)))
                assignment_loss += integral_p * float(np.sum(theta * (x0 - q0)))
        time = event_time

        if next_record == event_time:
            q = pending()
            # This path statistic weights completed counts by the true means.
            # It is not the realized payoff sum and can be negative on a path.
            # Only its expectation equals the expected completion regret.
            records.append({"time": time, "assignment_integral": assignment_loss,
                            "mean_weighted_completion_regret_path": time * optimum_rate - float(np.sum(theta * departures)),
                            "queue_reward": float(np.sum(theta * q)), "queue_size": int(q.sum()),
                            "exploration_time": explored_time, "active_time": active_time,
                            "departures": departures.tolist()})
            checkpoint_index += 1
            next_record = (float(checkpoints[checkpoint_index])
                           if checkpoint_index < len(checkpoints) else math.inf)
        if time == horizon:
            break

        if next_slot == event_time:
            n = int(next_slot)
            estimates = np.divide(reward_sum, departures, out=np.zeros_like(reward_sum), where=departures > 0)
            radius = np.minimum(1., np.sqrt(8. * math.log(n + 2) / np.maximum(1, departures)))
            lower = np.maximum(0., estimates - radius)
            upper = np.minimum(1., estimates + radius)
            upper[departures == 0] = 1.
            lower[departures == 0] = 0.
            best = np.argmax(estimates, axis=1)
            certified = all(lower[i, best[i]] > upper[i, 1 - best[i]] for i in range(2))
            coin = rng.random() < min(1., beta / math.sqrt(n + 1))
            if certified:
                latest = np.zeros((2, 2))
                latest[np.arange(2), best] = LAMBDA
                certificate_refreshes += 1
                if first_certificate is None:
                    first_certificate = n
            exploring = not certified and coin
            rates = q0 if exploring else latest
            exploration_slots += int(exploring)
            next_slot += 1.

        if next_arrival == event_time:
            i = int(rng.random() >= LAMBDA[0])
            if mode == "certificate":
                prob0 = rates[i, 0] / LAMBDA[i]
            elif target is not None:
                prob0 = .5
            else:
                p = 1. / ((math.e + time) * math.log(math.e + time))
                prob0 = ((1. - p) * x0[i, 0] + p * q0[i, 0]) / LAMBDA[i]
            j = int(rng.random() >= prob0)
            arrivals[i, j] += 1
            queues[j].append((i, time))
            start_service(j, time)
            next_arrival = time + float(rng.exponential(1.))

        for j in range(2):
            if completion[j] != event_time:
                continue
            i, _ = in_service[j]
            in_service[j] = None
            completion[j] = math.inf
            departures[i, j] += 1
            reward_sum[i, j] += (float(rng.random() < theta[i, j]) if mode == "certificate"
                                 else float(rng.poisson(theta[i, j])))
            if mode == "counterexample":
                # Freeze the chosen target until its own next departure.
                if target is None or target == (i, j):
                    choose_target()
            start_service(j, time)
        pending()

    return {"mode": mode, "seed": seed, "horizon": horizon, "beta": beta,
            "alternate_environment": alternate, "theta": theta.tolist(),
            "first_certificate": first_certificate, "certificate_refreshes": certificate_refreshes,
            "exploration_slots": exploration_slots, "active_time": active_time,
            "arrivals": arrivals.tolist(), "departures": departures.tolist(),
            "flow_conservation_passed": True, "records": records}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--horizon", type=int, default=50000)
    parser.add_argument("--seeds", type=int, default=8)
    parser.add_argument("--beta", type=float, default=32.)
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results" / "simulation.json")
    args = parser.parse_args()
    runs = []
    for mode, alternate in [("certificate", False), ("counterexample", False), ("counterexample", True)]:
        for seed in range(args.seeds):
            runs.append(simulate(mode, args.horizon, 20261125 + seed, args.beta, alternate))
    result = {"scope": "Monte Carlo diagnostic only; asymptotic results require the written proof",
              "feedback": "sampled and revealed at actual service completion", "runs": runs}
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({"runs": len(runs), "horizon": args.horizon,
                      "all_flow_checks_passed": all(x["flow_conservation_passed"] for x in runs),
                      "output": str(args.output)}, indent=2))


if __name__ == "__main__":
    main()
