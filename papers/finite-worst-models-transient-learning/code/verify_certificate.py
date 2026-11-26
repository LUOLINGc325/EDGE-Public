#!/usr/bin/env python3
"""Recompute exact, finite certificates for the transient-learning manuscript.

Run from the case directory:
    python code/verify_certificate.py --output results/exact_certificate.json
    python code/verify_certificate.py --check results/exact_certificate.json

This verifier uses Fraction arithmetic, graph reachability, rational Gaussian
elimination, and complete short-horizon distribution enumeration.  It checks:

* a three-model communicating example with multichain cross-policy kernels;
* its four-state extension with multichain reference policies and an additional
  absorbing state, so weak communication itself is absent;
* a separate model-safe example with multichain reference policies and a signed
  deficit, showing the more general theorem's assumptions are not vacuous;
* all recurrent-class safe means, harmonic long-run gains, explicit Poisson
  inequalities, and the posterior controller on every enumerated path;
* action-factor cancellation, strict threshold semantics, zero-support behavior;
* two independent finite calculations of the symmetric two-model errors, plus
  exact finite Green-potential telescoping identities.

The output is a reproducible finite certificate, not a Lean proof, an exhaustive
verification of arbitrary MDPs, or a numerical proof of an infinite-horizon
theorem.  The general theorems and the infinite Green limit require the written
proofs.  No randomized simulation is used.  Output has no timestamps or timing
fields and is byte-deterministic for unchanged sources.
"""

from __future__ import annotations

import argparse
from collections import defaultdict
from fractions import Fraction as F
from hashlib import sha256
from math import comb, isqrt
from pathlib import Path
import json

from controller import ControllerState, ImpossibleObservation, StickyPosteriorController


def require(condition, message):
    """A verification assertion that also remains active under python -O."""
    if not condition:
        raise AssertionError(message)


def dot(x, y):
    return sum((a * b for a, b in zip(x, y)), F(0))


def solve(matrix, vector):
    """Solve a nonsingular square rational system by exact Gauss elimination."""
    n = len(vector)
    require(len(matrix) == n and all(len(row) == n for row in matrix), "square system")
    a = [[F(value) for value in row] + [F(rhs)]
         for row, rhs in zip(matrix, vector)]
    for col in range(n):
        pivot = next((row for row in range(col, n) if a[row][col]), None)
        require(pivot is not None, "singular rational system")
        a[col], a[pivot] = a[pivot], a[col]
        scale = a[col][col]
        a[col] = [value / scale for value in a[col]]
        for row in range(n):
            if row == col:
                continue
            scale = a[row][col]
            a[row] = [v - scale * w for v, w in zip(a[row], a[col])]
    result = tuple(a[row][-1] for row in range(n))
    require(all(dot(row, result) == rhs for row, rhs in zip(matrix, vector)), "solve residual")
    return result


def closed_classes(kernel):
    """Find closed strongly connected classes directly from positive support."""
    n = len(kernel)
    graph = [{j for j, p in enumerate(row) if p > 0} for row in kernel]
    reach = []
    for start in range(n):
        seen, todo = {start}, [start]
        while todo:
            for nxt in graph[todo.pop()] - seen:
                seen.add(nxt)
                todo.append(nxt)
        reach.append(seen)
    remaining, result = set(range(n)), []
    while remaining:
        s = min(remaining)
        component = {t for t in remaining if t in reach[s] and s in reach[t]}
        remaining -= component
        if all(graph[t] <= component for t in component):
            result.append(tuple(sorted(component)))
    require(bool(result), "a finite stochastic kernel must have a closed class")
    return tuple(result)


def stationary(kernel, component):
    """Solve pi K = pi and sum pi = 1 on one closed irreducible class."""
    size = len(component)
    matrix = [[kernel[component[row]][component[col]] - F(row == col)
               for row in range(size)] for col in range(size - 1)]
    matrix.append([F(1)] * size)
    weights = solve(matrix, [F(0)] * (size - 1) + [F(1)])
    require(min(weights) > 0 and sum(weights) == 1, "positive stationary law")
    require(all(sum(weights[row] * kernel[component[row]][s] for row in range(size))
                == weights[col] for col, s in enumerate(component)), "stationarity")
    return weights


def class_information(kernel, rewards):
    """Compute all class means and all-start Cesaro reward gains exactly."""
    components = closed_classes(kernel)
    gains = [None] * len(kernel)
    records = []
    for component in components:
        weights = stationary(kernel, component)
        mean = dot(weights, [rewards[s] for s in component])
        for s in component:
            gains[s] = mean
        records.append({"states": component, "stationary": weights, "mean": mean})
    transient = [s for s, value in enumerate(gains) if value is None]
    if transient:
        matrix = [[F(s == t) - kernel[s][t] for t in transient] for s in transient]
        rhs = [sum((kernel[s][t] * gains[t] for t in range(len(kernel))
                    if gains[t] is not None), F(0)) for s in transient]
        values = solve(matrix, rhs)
        for s, value in zip(transient, values):
            gains[s] = value
    require(all(dot(row, gains) == gains[s] for s, row in enumerate(kernel)), "harmonic gains")
    return records, tuple(gains)


def exact_sqrt(value):
    value = F(value)
    n, d = isqrt(value.numerator), isqrt(value.denominator)
    require(n * n == value.numerator and d * d == value.denominator,
            "this finite verifier expects rational square roots")
    return F(n, d)


def deterministic_models(successors):
    """Convert [model][action][state] successors into model tensors."""
    n = len(successors[0][0])
    return tuple(tuple(tuple(tuple(F(t == model[a][s]) for t in range(n))
                             for a in range(len(model)))
                       for s in range(n)) for model in successors)


def constant_policies(count, states, actions):
    return tuple(tuple(tuple(F(a == j) for a in range(actions))
                       for _ in range(states)) for j in range(count))


def induced(controller, true_model, candidate):
    return tuple(tuple(sum((controller.policies[candidate][s][a]
                            * controller.models[true_model][s][a][t]
                            for a in range(controller.k)), F(0))
                       for t in range(controller.n)) for s in range(controller.n))


def verify_case(name, successors, state_rewards, benchmark, certificates, biases=None):
    models = deterministic_models(successors)
    m, n, k = len(models), len(models[0]), len(models[0][0])
    policies = constant_policies(m, n, k)
    controller = StickyPosteriorController(models, policies)
    rewards = tuple(F(x) for x in state_rewards)
    benchmark = F(benchmark)
    safety, pairs = [], []
    for j in range(m):
        classes, gains = class_information(induced(controller, j, j), rewards)
        require(all(item["mean"] >= benchmark for item in classes), "model-safe class mean")
        require(min(gains) >= benchmark, "model-safe all-start gain")
        safety.append({"model": j, "classes": classes, "all_start_gain": gains})
    for i in range(m):
        for j in range(m):
            kernel, reference = induced(controller, i, j), induced(controller, j, j)
            deficit = tuple(benchmark - value for value in rewards)
            d = tuple(1 - sum((exact_sqrt(x * y) for x, y in zip(row, ref)), F(0))
                      for row, ref in zip(kernel, reference))
            c, potential = certificates[i][j]
            c, potential = F(c), tuple(F(x) for x in potential)
            require(c >= 0, "nonnegative information multiplier")
            slack = tuple(c * d[s] + potential[s] - dot(kernel[s], potential) - deficit[s]
                          for s in range(n))
            require(min(slack) >= 0, "Poisson certificate inequality")
            classes, _ = class_information(kernel, rewards)
            for item in classes:
                states, weights = item["states"], item["stationary"]
                mean_d = dot(weights, [d[s] for s in states])
                mean_a = dot(weights, [deficit[s] for s in states])
                require(mean_a <= c * mean_d, "stationary certificate necessity")
                if mean_d == 0:
                    require(mean_a <= 0, "zero-information class is safe")
            pairs.append({"true_model": i, "candidate": j, "kernel": kernel,
                          "closed_classes": classes, "deficit": deficit, "d": d,
                          "c": c, "potential": potential, "slack": slack})
    bellman = None
    if biases is not None:
        count = 0
        for i in range(m):
            h = tuple(F(x) for x in biases[i])
            for s in range(n):
                action_values = [rewards[s] + dot(models[i][s][a], h) for a in range(k)]
                require(benchmark + h[s] == max(action_values), "optimal Bellman equation")
                require(action_values[i] == max(action_values), "candidate Bellman optimality")
                count += 1
        bellman = {"biases": biases, "state_equalities_checked": count,
                   "action_inequalities_checked": m * n * k}
    trajectories = []
    switch_bound = F(2 * m * (m - 1))
    for i in range(m):
        row = [pairs[i * m + j] for j in range(m)]
        # sqrt(2m) <= 2m gives an explicitly rational upper bound for this check.
        rational_bound = (2 * m * sum(item["c"] for item in row)
                          + (1 + switch_bound)
                          * max(max(item["potential"]) - min(item["potential"]) for item in row))
        for initial_state in range(n):
            for horizon in (1, 2, 4, 8, 12):
                data = enumerate_controller(controller, rewards, benchmark, i, initial_state, horizon)
                require(data["expected_regret"] <= rational_bound, "finite regret versus certificate bound")
                require(data["expected_switches"] <= switch_bound, "finite switch bound")
                data["rational_certificate_bound"] = rational_bound
                trajectories.append(data)
    return {"name": name, "models": models, "policies": policies, "rewards": rewards,
            "benchmark": benchmark, "safe_policy_checks": safety, "bellman_checks": bellman,
            "pair_certificates": pairs, "enumerated_runs": trajectories,
            "switch_bound": switch_bound}


def enumerate_controller(controller, rewards, benchmark, true_model, initial_state, horizon):
    """Enumerate the full law, merging histories with identical controller state."""
    distribution = {(initial_state, controller.initial()): F(1)}
    cumulative_reward, transitions, max_nodes = F(0), 0, 1
    for _ in range(horizon):
        updated = defaultdict(F)
        for (s, information), mass in distribution.items():
            selected, actions = controller.decide(information, s)
            require(selected.posterior[selected.active] >= controller.threshold, "active threshold")
            for action, action_probability in enumerate(actions):
                if not action_probability:
                    continue
                cumulative_reward += mass * action_probability * rewards[s]
                for nxt, transition_probability in enumerate(controller.models[true_model][s][action]):
                    if not transition_probability:
                        continue
                    posterior = controller.observe(selected, s, action, nxt)
                    require(posterior.posterior[true_model] > 0, "realizable true model survives")
                    require(all(old > 0 or new == 0 for old, new in
                                zip(selected.posterior, posterior.posterior)), "zeros stay zero")
                    updated[(nxt, posterior)] += mass * action_probability * transition_probability
                    transitions += 1
        distribution = dict(updated)
        require(sum(distribution.values()) == 1, "full probability mass")
        max_nodes = max(max_nodes, len(distribution))
    switches = sum((mass * information.switches for (_, information), mass in distribution.items()), F(0))
    return {"true_model": true_model, "initial_state": initial_state, "horizon": horizon,
            "expected_reward": cumulative_reward,
            "expected_regret": benchmark * horizon - cumulative_reward,
            "expected_switches": switches, "terminal_nodes": len(distribution),
            "max_nodes": max_nodes, "positive_transition_branches": transitions}


def posterior_semantics():
    models = (
        (((F(3, 4), F(1, 4)), (F(1, 4), F(3, 4))),) * 2,
        (((F(1, 2), F(1, 2)), (F(1, 2), F(1, 2))),) * 2,
    )
    policies = (((F(1, 3), F(2, 3)),) * 2,) * 2
    controller = StickyPosteriorController(models, policies)
    selected, actions = controller.decide(controller.initial(), 0)
    result = controller.observe(selected, 0, 1, 1)
    joint = tuple(selected.posterior[j] * actions[1] * models[j][0][1][1] for j in range(2))
    require(result.posterior == tuple(value / sum(joint) for value in joint) == (F(3, 5), F(2, 5)),
            "observed action factor cancels exactly")
    equal = ControllerState((F(1, 4), F(3, 4)), 0)
    below = ControllerState((F(1, 5), F(4, 5)), 0)
    require(controller.select(equal) == equal, "strictly below threshold triggers switch")
    require(controller.select(below) == ControllerState(below.posterior, 1, 1), "threshold switch")
    require(controller.select(controller.initial()).active == 0, "deterministic tie break")
    zero = StickyPosteriorController(deterministic_models((((0, 0),),)), (((F(1),),) * 2,))
    before, _ = zero.decide(zero.initial(), 0)
    try:
        zero.observe(before, 0, 0, 1)
    except ImpossibleObservation:
        pass
    else:
        raise AssertionError("all-zero evidence must raise, not reset")
    require(before == ControllerState((F(1),), 0, 0), "failed update leaves immutable state unchanged")
    # Enumerate a stochastic randomized-policy case to exercise all action and
    # successor branches, independently of the deterministic main witnesses.
    random_runs = [enumerate_controller(controller, (F(0), F(1)), F(0), i, 0, 5)
                   for i in range(2)]
    return {"action_conditioned_posterior": result.posterior,
            "exact_joint_likelihood_posterior": tuple(value / sum(joint) for value in joint),
            "threshold_equality_retains": True, "below_threshold_switches": True,
            "zero_evidence_raises": True, "floating_point_input_not_used": True,
            "randomized_policy_exact_runs": random_runs}


def two_model_green():
    """Independent binomial and path recursions, with exact finite tail potential."""
    rows = []
    for delta in (F(1, 5), F(1, 3), F(1, 2), F(3, 5), F(3, 4)):
        p, q = (1 + delta) / 2, (1 - delta) / 2
        target = 1 / (2 * delta * delta)
        def potential(position):
            return (target - F(position) / delta if position <= 0
                    else target * (q / p) ** position)
        for position in range(-30, 31):
            loss = F(1) if position < 0 else F(1, 2) if position == 0 else F(0)
            require(potential(position) - p * potential(position + 1)
                    - q * potential(position - 1) == loss, "Green potential recurrence")
        law, accumulated, errors = {0: F(1)}, F(0), []
        for n in range(25):
            error = sum((mass * (1 if position < 0 else F(1, 2) if position == 0 else 0)
                         for position, mass in law.items()), F(0))
            binomial = sum((F(comb(n, successes)) * p ** successes * q ** (n - successes)
                            * (1 if 2 * successes < n else F(1, 2) if 2 * successes == n else 0)
                            for successes in range(n + 1)), F(0))
            require(error == binomial, "path distribution equals binomial risk")
            tail = sum((mass * potential(position) for position, mass in law.items()), F(0))
            require(accumulated + tail == target, "finite Green telescoping identity")
            errors.append(error)
            accumulated += error
            nxt = defaultdict(F)
            for position, mass in law.items():
                nxt[position + 1] += mass * p
                nxt[position - 1] += mass * q
            law = dict(nxt)
        for k in range(1, 13):
            require(errors[2 * k] == errors[2 * k - 1], "even-odd risk identity")
        final_tail = sum((mass * potential(position) for position, mass in law.items()), F(0))
        require(accumulated + final_tail == target, "final exact remainder")
        rows.append({"delta": delta, "tested_n": [0, 24], "tested_potential_states": [-30, 30],
                     "sum_25_errors": accumulated, "exact_remaining_potential": final_tail,
                     "theoretical_infinite_error_sum": target,
                     "theoretical_learning_regret": 1 / (2 * delta)})
    return {"scope": "Finite exact identities; the infinite limit is justified in the manuscript, not by truncation.",
            "parameter_cases": rows}


def normalize(value):
    if isinstance(value, F):
        return str(value)
    if isinstance(value, dict):
        return {str(key): normalize(item) for key, item in value.items()}
    if isinstance(value, (tuple, list)):
        return [normalize(item) for item in value]
    return value


def build_report():
    R, U, W, E = (1, 1, 1), (2, 1, 1), (2, 1, 2), (2, 0, 0)
    successors = ((R, W, W, E), (W, U, W, E), (W, W, U, E))
    biases = ((-1, 0, -1), (-2, 0, -1), (-2, 0, -1))
    certificates = []
    for i in range(3):
        row = []
        for j in range(3):
            old = (1, 0, 0) if i == 0 and j in (1, 2) else (0, 0, 0)
            # a_old = g-r+h_i-Kh_i.  Therefore the signed g-r certificate
            # uses b_total = b_old-h_i, not b_old+h_i.
            potential = tuple(old[s] - biases[i][s] for s in range(3))
            row.append((int(i != j), potential))
        certificates.append(tuple(row))
    main = verify_case("communicating_three_model_witness", successors, (0, 1, 0), 1,
                       tuple(certificates), biases)
    extended_successors = tuple(tuple(action + (3,) for action in model)
                                for model in successors)
    extended_certificates = tuple(tuple((c, potential + (0,)) for c, potential in row)
                                  for row in certificates)
    extended = verify_case("four_state_noncommunicating_multichain_reference",
                           extended_successors, (0, 1, 0, 1), 1,
                           extended_certificates, tuple(h + (0,) for h in biases))
    # The generalized theorem only assumes a known safe policy in each model.
    # This second example has two own-policy recurrent classes of means 1 and
    # 1/2.  Its deficit (1/2,-1/2,0) is genuinely signed.
    safe, identity = (2, 1, 2), (0, 1, 2)
    safe_certificates = (((0, (F(1, 2), 0, 0)), (F(1, 2), (0, 0, 0))),
                         ((F(1, 2), (0, 0, 0)), (0, (F(1, 2), 0, 0))))
    generalized = verify_case("multichain_model_safe_signed_deficit",
                              ((safe, identity), (identity, safe)), (0, 1, F(1, 2)), F(1, 2),
                              safe_certificates)
    folder = Path(__file__).resolve().parent
    report = {"schema_version": 1, "status": "PASS",
              "arithmetic": "Python standard-library Fraction; no numerical tolerance or random simulation",
              "evidence_scope": "Finite examples, controller semantics, short-horizon complete laws, and exact finite Green identities; not a general or Lean proof",
              "source_sha256": {name: sha256((folder / name).read_bytes()).hexdigest()
                                for name in ("controller.py", "verify_certificate.py")},
              "cases": [main, extended, generalized], "posterior_semantics": posterior_semantics(),
              "two_model_green": two_model_green()}
    return normalize(report)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    group = parser.add_mutually_exclusive_group()
    group.add_argument("--output", type=Path, help="write the deterministic JSON report")
    group.add_argument("--check", type=Path, help="recompute and compare with a stored JSON report")
    args = parser.parse_args()
    report = build_report()
    encoded = json.dumps(report, ensure_ascii=False, sort_keys=True, indent=2) + "\n"
    if args.check is not None:
        require(json.loads(args.check.read_text(encoding="utf-8")) == report, "stored certificate equals recomputation")
        print(json.dumps({"status": "PASS", "stored_certificate_matches": True,
                          "cases": len(report["cases"]),
                          "exact_enumerated_runs": sum(len(case["enumerated_runs"]) for case in report["cases"]),
                          "report_sha256": sha256(encoded.encode()).hexdigest()}, sort_keys=True))
    elif args.output is not None:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(encoded, encoding="utf-8")
        print(json.dumps({"status": "PASS", "written": str(args.output),
                          "report_sha256": sha256(encoded.encode()).hexdigest()}, sort_keys=True))
    else:
        print(encoded, end="")


if __name__ == "__main__":
    main()
