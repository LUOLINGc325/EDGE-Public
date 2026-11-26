#!/usr/bin/env python3
"""Construct EFX under a common item dominating every outside triple.

For four agents and eight goods. The proof of correctness is in the report.
The only general existence input is the published three-agent/seven-good
theorem; this implementation finds its required allocation by exact enumeration.
"""
from __future__ import annotations

import itertools
import json
import random
from pathlib import Path

ROOT = Path(__file__).resolve().parent


def efx(v, bundles, agents=None):
    agents = list(range(len(v))) if agents is None else list(agents)
    for i in agents:
        for j in agents:
            mask = bundles[j]
            while mask:
                bit = mask & -mask
                mask ^= bit
                if v[i][bundles[i]] < v[i][bundles[j] ^ bit]:
                    return False
    return True


def construct(v, g=None, recipient=0):
    if len(v) != 4 or any(len(row) != 256 for row in v):
        raise ValueError("Expected four tables with 256 entries each")
    for row in v:
        if row[0] != 0 or any(x < 0 for x in row):
            raise ValueError("Values must be normalized and nonnegative")
        if any(row[s] > row[s | (1 << h)] for s in range(256) for h in range(8)):
            raise ValueError("Valuation is not monotone")
    candidates = range(8) if g is None else [g]
    g = next((h for h in candidates
              if all(v[i][1 << h] >= v[i][s]
                     for i in range(4) for s in range(256)
                     if not s & (1 << h) and s.bit_count() == 3)), None)
    if g is None:
        return {"status": "condition_not_satisfied"}
    outside = [h for h in range(8) if h != g]
    agents = [i for i in range(4) if i != recipient]
    a = None
    trials = 0
    for labels in itertools.product(agents, repeat=7):
        b = [0] * 4
        b[recipient] = 1 << g
        for h, owner in zip(outside, labels):
            b[owner] |= 1 << h
        if any(b[i] == 0 for i in agents):
            continue
        trials += 1
        if efx(v, b, agents):
            a = b
            break
    if a is None:
        raise AssertionError("No nonempty residual EFX; inconsistent with published existence input")
    initial = a.copy()
    if efx(v, a):
        return {"status": "constructed", "route": "direct_extension",
                "common_good": g, "initial_allocation": initial,
                "allocation": a, "residual_allocations_examined": trials}

    # Only a five-item residual bundle can cause a violation for the recipient.
    p = next(i for i in agents if a[i].bit_count() == 5)
    q, r = [i for i in agents if i != p]
    Q = a[p]
    z = next(h for h in range(8) if Q & (1 << h)
             and v[recipient][Q ^ (1 << h)] > v[recipient][1 << g])
    H = Q ^ (1 << z)
    a[recipient], a[p] = H, 1 << g
    swapped = False
    if v[q][a[r]] > v[q][a[q]] and v[r][a[q]] > v[r][a[r]]:
        a[q], a[r] = a[r], a[q]
        swapped = True
    receiver = q if v[r][a[q]] <= v[r][a[r]] else r
    a[receiver] |= 1 << z
    if not efx(v, a):
        raise AssertionError("Constructive exchange failed exact EFX verification")
    return {"status": "constructed", "route": "five_to_four_exchange",
            "common_good": g, "initial_allocation": initial,
            "allocation": a, "residual_allocations_examined": trials,
            "five_item_holder": p, "removed_item": z,
            "swapped_singletons": swapped, "extra_item_recipient": receiver}


def run_examples():
    # A nonadditive profile where merely deleting g for agent 0 fails, but
    # the exchange proof succeeds. All four agents satisfy the theorem.
    rows = []
    for i in range(4):
        row = []
        for s in range(256):
            if i == 0:
                value = (10 if s & 1 else 0) + (s & 0b11111110).bit_count()
                if (s & 0b11111000).bit_count() >= 4:
                    value += 1000
            else:
                value = (300 if s & 1 else 0) + (100 if s & 2 else 0) + (100 if s & 4 else 0)
                value += (s & 0b11111000).bit_count()
            row.append(value)
        rows.append(row)
    instance = {"n": 4, "m": 8,
                "goods": ["g", "a", "b", "c1", "c2", "c3", "c4", "c5"],
                "description": "Common triple-dominant item with genuine four-item synergy; exchange branch is required for recipient zero.",
                "valuations": rows}
    (ROOT / "common_dominant_example.json").write_text(json.dumps(instance, indent=2) + "\n")
    exchange = construct(rows, g=0, recipient=0)

    # Deterministic finite sanity check with nonadditive positive hyperedge bonuses.
    # These checks validate the implementation, not the universal theorem.
    rng = random.Random(20261124)
    routes = {}
    samples = 40
    for t in range(samples):
        vv = []
        for i in range(4):
            weights = [100] + [rng.randint(1, 10) for _ in range(7)]
            triples_or_more = [s for s in range(256) if not s & 1 and s.bit_count() == 4]
            bonuses = [(s, rng.randint(20, 300)) for s in rng.sample(triples_or_more, 8)]
            row = [sum(weights[h] for h in range(8) if s & (1 << h)) +
                   sum(w for a, w in bonuses if s & a == a) for s in range(256)]
            vv.append(row)
        result = construct(vv, g=0, recipient=t % 4)
        assert result["status"] == "constructed"
        routes[result["route"]] = routes.get(result["route"], 0) + 1
    result = {"explicit_exchange_example": exchange,
              "deterministic_random_profiles": samples, "seed": 20261124,
              "random_routes": routes,
              "all_outputs_exactly_checked": True,
              "scope": "Implementation checks only; not a proof of the unrestricted EFX question"}
    (ROOT / "common_dominant_construction_results.json").write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    run_examples()
