#!/usr/bin/env python3
"""Exact constructive implementation of the common pair-dominating theorem.

Only a three-agent/seven-good residual allocation is found by enumeration.
The four-agent answer is produced by the exchanges in common_dominant_theorem.txt.
All arithmetic is integral. The optional residual-shape preference is solely a
deterministic branch-coverage aid; every nonempty residual allocation remains
eligible, and a general residual EFX allocation is retained as fallback.
"""
from __future__ import annotations

import itertools
import json
from pathlib import Path

from construct_common_dominant import efx

ROOT = Path(__file__).resolve().parent


def bits(mask):
    while mask:
        bit = mask & -mask
        yield bit
        mask ^= bit


def subsets_of_size(mask, size):
    for selected in itertools.combinations(list(bits(mask)), size):
        yield sum(selected)


def validate_tables(v):
    if len(v) != 4 or any(len(row) != 256 for row in v):
        raise ValueError("Expected four valuations on eight goods")
    for row in v:
        if any(type(value) is not int for value in row):
            raise ValueError("All values must be exact integers")
        if row[0] != 0 or any(value < 0 for value in row):
            raise ValueError("Valuations must be normalized and nonnegative")
        if any(row[s] > row[s | (1 << h)]
               for s in range(256) for h in range(8)):
            raise ValueError("Valuation is not monotone under inclusion")


def pair_condition(v, g):
    outside = 255 ^ (1 << g)
    return all(v[i][1 << g] >= v[i][s]
               for i in range(4)
               for size in (1, 2)
               for s in subsets_of_size(outside, size))


def checked_local(v, agents, allocation, floors):
    assert all(allocation[i] for i in agents)
    assert efx(v, allocation, agents)
    assert all(v[i][allocation[i]] >= floors[i] for i in agents)
    return allocation


def lemma_a(v, p, q, a, b, z):
    """Two singleton bundles plus one individually small good."""
    assert a.bit_count() == b.bit_count() == z.bit_count() == 1
    assert not (a & b or a & z or b & z)
    assert v[p][z] <= v[p][a] and v[q][z] <= v[q][b]
    floors = {p: v[p][a], q: v[q][b]}
    out = [0] * len(v)
    out[p], out[q] = a, b
    swapped = v[p][b] > v[p][a] and v[q][a] > v[q][b]
    if swapped:
        out[p], out[q] = out[q], out[p]
    receiver = p if v[q][out[p]] <= v[q][out[q]] else q
    out[receiver] |= z
    checked_local(v, (p, q), out, floors)
    return out, {"lemma": "A", "swapped_singletons": swapped,
                 "extra_item_receiver": receiver}


def lemma_b(v, p, q, pair, a, z):
    """An EFX pair/singleton allocation plus one individually small good."""
    assert pair.bit_count() == 2 and a.bit_count() == z.bit_count() == 1
    assert not (pair & a or pair & z or a & z)
    assert v[p][pair] >= v[p][z]
    assert all(v[q][a] >= v[q][x] for x in bits(pair | z))
    floors = {p: v[p][pair], q: v[q][a]}
    out = [0] * len(v)
    triple = pair | z
    if v[p][pair] >= v[p][a]:
        out[p], out[q] = pair, a | z
        branch = "B1_pair_beats_other_singleton"
    else:
        improving = next((s for s in subsets_of_size(triple, 2)
                          if v[p][s] > v[p][a]), None)
        if improving is not None:
            assert improving != pair and improving & z
            out[p], out[q] = improving, a | (triple ^ improving)
            branch = "B2_cross_pair_beats_singleton"
        elif v[q][triple] >= v[q][a]:
            out[p], out[q] = a, triple
            branch = "B3_singleton_holder_takes_triple"
        else:
            out[p], out[q] = triple, a
            branch = "B4_pair_holder_takes_triple"
    checked_local(v, (p, q), out, floors)
    return out, {"lemma": "B", "branch": branch}


def lemma_c(v, p, q, a, b, z, w):
    """Two singleton bundles plus two individually small goods."""
    assert all(v[p][x] <= v[p][a] and v[q][x] <= v[q][b]
               for x in (z, w))
    floors = {p: v[p][a], q: v[q][b]}
    intermediate, trace_a = lemma_a(v, p, q, a, b, z)
    pair_holder = p if intermediate[p].bit_count() == 2 else q
    singleton_holder = q if pair_holder == p else p
    final, trace_b = lemma_b(v, pair_holder, singleton_holder,
                            intermediate[pair_holder],
                            intermediate[singleton_holder], w)
    checked_local(v, (p, q), final, floors)
    return final, {"lemma": "C", "steps": [trace_a, trace_b]}


def residual_efx(v, g, recipient, preferred_shape=None):
    agents = [i for i in range(4) if i != recipient]
    outside = [h for h in range(8) if h != g]
    fallback = None
    nonempty_checked = 0
    preferred_shape = (tuple(sorted(preferred_shape))
                       if preferred_shape is not None else None)
    for labels in itertools.product(agents, repeat=7):
        allocation = [0] * 4
        allocation[recipient] = 1 << g
        for h, owner in zip(outside, labels):
            allocation[owner] |= 1 << h
        if any(allocation[i] == 0 for i in agents):
            continue
        nonempty_checked += 1
        if not efx(v, allocation, agents):
            continue
        if fallback is None:
            fallback = allocation.copy()
        shape = tuple(sorted(allocation[i].bit_count() for i in agents))
        if preferred_shape is None or shape == preferred_shape:
            return allocation, nonempty_checked, preferred_shape is not None
    if fallback is None:
        raise AssertionError("No residual nonempty EFX: conflicts with the known 3/7 theorem")
    return fallback, nonempty_checked, False


def construct(v, g=None, recipient=0, preferred_residual_shape=None):
    validate_tables(v)
    if recipient not in range(4):
        raise ValueError("Invalid recipient")
    if g is not None and g not in range(8):
        raise ValueError("Invalid common good")
    g = next((h for h in (range(8) if g is None else [g])
              if pair_condition(v, h)), None)
    if g is None:
        return {"status": "condition_not_satisfied"}
    allocation, trials, preferred_found = residual_efx(
        v, g, recipient, preferred_residual_shape)
    initial = allocation.copy()
    agents = [i for i in range(4) if i != recipient]
    base = {"status": "constructed", "common_good": g,
            "recipient": recipient, "initial_allocation": initial,
            "residual_allocations_examined": trials,
            "preferred_residual_shape": preferred_residual_shape,
            "preferred_shape_found": preferred_found,
            "full_four_agent_allocations_enumerated": 0}
    if efx(v, allocation):
        return {**base, "route": "direct_extension", "allocation": allocation,
                "trace": [], "exact_efx_check": True}

    largest = max(agents, key=lambda i: allocation[i].bit_count())
    Q = allocation[largest]
    trace = []
    if Q.bit_count() == 4:
        p = largest
        q = next(i for i in agents if allocation[i].bit_count() == 2)
        r = next(i for i in agents if allocation[i].bit_count() == 1)
        z = next(x for x in bits(Q)
                 if v[recipient][Q ^ x] > v[recipient][1 << g])
        H = Q ^ z
        local, note = lemma_b(v, q, r, allocation[q], allocation[r], z)
        allocation[recipient], allocation[p] = H, 1 << g
        allocation[q], allocation[r] = local[q], local[r]
        route = "four_to_three_exchange"
        trace = [{"large_holder": p, "removed_good": z.bit_length() - 1,
                  "transferred_bundle": H}, note]
    elif Q.bit_count() == 5:
        p = largest
        q, r = [i for i in agents if i != p]
        high_triple = next(((j, T) for j in (recipient, p)
                            for T in subsets_of_size(Q, 3)
                            if v[j][T] > v[j][1 << g]), None)
        if high_triple is not None:
            high_agent, T = high_triple
            common_good_holder = p if high_agent == recipient else recipient
            z, w = list(bits(Q ^ T))
            local, note = lemma_c(v, q, r, allocation[q], allocation[r], z, w)
            allocation[high_agent], allocation[common_good_holder] = T, 1 << g
            allocation[q], allocation[r] = local[q], local[r]
            route = "five_to_triple_exchange"
            trace = [{"large_holder": p, "high_triple_holder": high_agent,
                      "transferred_triple": T}, note]
        else:
            z = next(x for x in bits(Q)
                     if v[recipient][Q ^ x] > v[recipient][1 << g])
            H = Q ^ z
            local, note = lemma_a(v, q, r, allocation[q], allocation[r], z)
            allocation[recipient], allocation[p] = H, 1 << g
            allocation[q], allocation[r] = local[q], local[r]
            route = "five_to_four_exchange"
            trace = [{"large_holder": p, "removed_good": z.bit_length() - 1,
                      "transferred_quartet": H}, note]
    else:
        raise AssertionError("A residual bundle of size <=3 cannot violate pair dominance")

    assert sum(x.bit_count() for x in allocation) == 8
    assert allocation[0] | allocation[1] | allocation[2] | allocation[3] == 255
    assert efx(v, allocation), (route, allocation)
    return {**base, "route": route, "allocation": allocation,
            "trace": trace, "exact_efx_check": True}


def valuation(weights, bonus_mask=0, bonus_threshold=9, bonus_amount=1000):
    return [sum(weights[h] for h in range(len(weights)) if s & (1 << h)) +
            (bonus_amount if (s & bonus_mask).bit_count() >= bonus_threshold else 0)
            for s in range(1 << len(weights))]


def run_examples():
    descriptions = []
    small = [10] + [1] * 7
    large = [300, 100, 100, 1, 1, 1, 1, 1]
    Z = 0b11111000
    descriptions.append(("direct_additive", "Direct extension; no high-order bonuses",
                         [valuation([100] + [1] * 7) for _ in range(4)], None))
    descriptions.append(("quartet_synergy", "Four-low-good complementarity requires the quartet exchange",
                         [valuation(small, Z, 4)] + [valuation(large) for _ in range(3)],
                         [5, 1, 1]))
    descriptions.append(("recipient_triple_synergy", "Recipient has a high triple inside the five-good residual bundle",
                         [valuation(small, Z, 3)] + [valuation(large) for _ in range(3)],
                         [5, 1, 1]))
    descriptions.append(("residual_holder_triple_synergy", "High triple belongs to the old five-good holder; shape preference exercises that valid residual EFX seed",
                         [valuation(small, Z, 4), valuation(large), valuation(large),
                          valuation(large, Z, 3)], [5, 1, 1]))
    four_weights = [300, 100, 10, 11, 1, 1, 1, 1]
    descriptions.append(("four_pair_singleton", "A residual four-good bundle contains three low goods with a recipient synergy",
                         [valuation(small, 0b11110000, 3)] +
                         [valuation(four_weights) for _ in range(3)], [4, 2, 1]))

    examples, results = [], []
    for identifier, description, rows, preference in descriptions:
        result = construct(rows, g=0, recipient=0, preferred_residual_shape=preference)
        examples.append({"id": identifier, "n": 4, "m": 8,
                         "description": description, "common_good": 0,
                         "preferred_residual_shape": preference, "valuations": rows})
        results.append({"id": identifier, **result})

    # Four explicit local checks exercise all branches of the pair/singleton lemma.
    local_profiles = [
        ("B1", valuation([1, 2, 2, 1]), valuation([5, 1, 1, 1])),
        ("B2", valuation([5, 1, 1, 1], 0b1010, 2, 10), valuation([5, 1, 1, 1])),
        ("B3", valuation([10, 1, 1, 1]), valuation([2, 1, 1, 1])),
        ("B4", valuation([10, 1, 1, 1]), valuation([10, 1, 1, 1])),
    ]
    local_checks = []
    for identifier, vp, vq in local_profiles:
        out, note = lemma_b([vp, vq], 0, 1, 0b0110, 0b0001, 0b1000)
        local_checks.append({"id": identifier, "valuations": [vp, vq],
                             "initial_allocation": [0b0110, 0b0001],
                             "incoming_good": 3, "allocation": out, "trace": note,
                             "exact_efx_check": efx([vp, vq], out),
                             "utility_floors_preserved": vp[out[0]] >= vp[6] and
                             vq[out[1]] >= vq[1]})
    a_profile = [valuation([1, 3, 1]), valuation([3, 1, 1])]
    a_out, a_note = lemma_a(a_profile, 0, 1, 1, 2, 4)
    local_checks.append({"id": "A_swap", "valuations": a_profile,
                         "initial_allocation": [1, 2], "incoming_good": 2,
                         "allocation": a_out, "trace": a_note,
                         "exact_efx_check": efx(a_profile, a_out),
                         "utility_floors_preserved": True})

    result_document = {"scope": "Exact implementation checks of a conditional theorem; not a proof of the unrestricted 4/8 problem",
                       "four_agent_examples": results, "local_lemma_checks": local_checks,
                       "coverage_routes": sorted({r["route"] for r in results}),
                       "full_four_agent_allocations_enumerated": 0,
                       "all_outputs_exactly_checked": True}
    (ROOT / "paired_construct_examples.json").write_text(
        json.dumps(examples, indent=2) + "\n", encoding="utf-8")
    (ROOT / "paired_construct_results.json").write_text(
        json.dumps(result_document, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"routes": [{"id": r["id"], "route": r["route"],
                                  "allocation": r["allocation"], "trace": r["trace"]}
                                 for r in results],
                      "local_branches": [x["trace"] for x in local_checks]}, indent=2))


if __name__ == "__main__":
    run_examples()
