#!/usr/bin/env python3
"""Independent finite check by labelled allocation enumeration, not load-state DP.

The universal claim is proved analytically; this finite check is corroboration.
"""
from itertools import product
import json


def run():
    result = {
        "base_instances": 0, "base_allocations": 0,
        "positive_instances": 0, "positive_allocations": 0, "checks": [],
    }
    for m in range(1, 4):
        for a in product(range(1, 4), repeat=m):
            if sum(a) % 2:
                continue
            T = sum(a) // 2
            M = m + 1
            K = M * T
            partition = any(
                sum(a[i] for i in range(m) if mask >> i & 1) == T
                for mask in range(1 << m)
            )
            values = (T,) + a + (T,)
            optimum = None
            for assignment in product(range(4), repeat=len(values)):
                loads = [0] * 4
                cost = 0
                for value, agent in zip(values, assignment):
                    loads[agent] += value
                    cost += max(loads) - min(loads)
                R = max(loads) - min(loads)
                cost += m * R
                if 4 * (cost - K) < M * R:
                    raise RuntimeError(("inequality", a, assignment))
                optimum = cost if optimum is None else min(optimum, cost)
                result["base_allocations"] += 1
            if (optimum <= K) != partition:
                raise RuntimeError(("base", a, optimum, K))
            result["base_instances"] += 1
            B = m * (m + 1) // 2
            Q = 2 * B + 1
            positive_threshold = Q * K + B
            positive_values = tuple(Q * v for v in values) + (1,) * m
            positive_optimum = None
            for assignment in product(range(4), repeat=len(positive_values)):
                loads = [0] * 4
                cost = 0
                for value, agent in zip(positive_values, assignment):
                    loads[agent] += value
                    cost += max(loads) - min(loads)
                positive_optimum = cost if positive_optimum is None else min(positive_optimum, cost)
                result["positive_allocations"] += 1
            if (positive_optimum <= positive_threshold) != partition:
                raise RuntimeError(("positive", a, positive_optimum, positive_threshold))
            result["positive_instances"] += 1
            result["checks"].append({
                "a": list(a), "partition": partition,
                "base_optimum": optimum, "base_threshold": K,
                "positive_optimum": positive_optimum,
                "positive_threshold": positive_threshold,
            })
    return result


if __name__ == "__main__":
    import argparse
    from pathlib import Path
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=Path(__file__).resolve().parents[1] / "results" / "independent_enumeration.json")
    args = parser.parse_args()
    output = json.dumps(run(), indent=2) + "\n"
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(output, encoding="utf-8")
    print(output, end="")
