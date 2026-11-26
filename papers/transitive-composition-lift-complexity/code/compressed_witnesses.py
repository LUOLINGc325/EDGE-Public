#!/usr/bin/env python3
"""Counter-trace DFA family for the secondary representation theorem.

This does not implement a polynomial compressed-word equality algorithm or
estimate a minimum grammar.  It checks the explicit forcing construction,
the entire reachable product component for the recorded k values, exact graph
counts, and positive graph certificates with an independent raw-path checker.
The universal SLP lower bound is a manuscript proof, not a finite-test claim.
"""
from __future__ import annotations

import argparse
import hashlib
from itertools import product
import json
from pathlib import Path
import random

from hardness_gadgets import Automaton, fixed_four_gadget, partial_deterministic
from verify_certificate import verify_certificate


def counter_trace_automata(k: int) -> tuple[Automaton, ...]:
    """A_r checks bit r of consecutive least-significant-bit-first blocks."""
    if k < 2:
        raise ValueError("the unanchored family requires k >= 2")
    states = tuple(product(range(k), (0, 1), (0, 1), (0, 1)))
    index = {state: i for i, state in enumerate(states)}
    answer = []
    for r in range(k):
        edges = set()
        for pos, expected, carry, last in states:
            for bit in (0, 1):
                new_expected, new_carry, new_last = expected, carry, last
                if pos < r:
                    new_carry = carry & bit
                elif pos == r:
                    if bit != expected:
                        continue
                    new_expected = bit ^ carry
                    new_last = bit
                new_pos = (pos + 1) % k
                if new_pos == 0:
                    new_carry = 1
                edges.add((index[pos, expected, carry, last], str(bit),
                           index[new_pos, new_expected, new_carry, new_last]))
        accepts = frozenset(index[s] for s in states if s[0] == 0 and s[3] == 1)
        answer.append(Automaton(tuple(range(8 * k)), ("0", "1"),
                                frozenset({index[0, 0, 1, 0]}), accepts,
                                frozenset(edges)))
    return tuple(answer)


def counter_trace(k: int) -> tuple[str, ...]:
    """Independent arithmetic specification: 0,...,2^k-1 in k LSB-first bits."""
    return tuple(str((number >> bit) & 1)
                 for number in range(1 << k) for bit in range(k))


def deterministic_tables(automata):
    tables = []
    for automaton in automata:
        table = {}
        for source, label, target in automaton.edges:
            assert (source, label) not in table
            table[source, label] = target
        tables.append(table)
    return tables


def accepts_all(automata, tables, word) -> bool:
    for automaton, table in zip(automata, tables):
        state = next(iter(automaton.initials))
        for label in word:
            state = table.get((state, label))
            if state is None:
                return False
        if state not in automaton.accepts:
            return False
    return True


def product_component(automata, tables):
    """Explore without arithmetic counter knowledge; fail on branching/deadlock.

    Every allowed next symbol is obtained by checking all DFA transition
    tables. Repetition terminates the exact reachable-product exploration.
    """
    state = tuple(next(iter(a.initials)) for a in automata)
    seen = {}
    letters, accepting_positions = [], []
    while state not in seen:
        seen[state] = len(letters)
        if all(q in a.accepts for q, a in zip(state, automata)):
            accepting_positions.append(len(letters))
        options = []
        for label in ("0", "1"):
            successor = tuple(table.get((q, label)) for q, table in zip(state, tables))
            if None not in successor:
                options.append((label, successor))
        assert len(options) == 1, (state, options)
        label, state = options[0]
        letters.append(label)
    return {"reachable_states": len(seen), "preperiod": seen[state],
            "period": len(letters) - seen[state],
            "accepting_positions_before_repetition": accepting_positions,
            "generated_word": tuple(letters)}


def raw_positive_certificate(source, target, encoded_trace):
    """Produce the literal edge-by-edge witness, without a lift solver."""
    gi = {v: i for i, v in enumerate(source.vertices)}
    hi = {v: i for i, v in enumerate(target.vertices)}
    ai = {a: i for i, a in enumerate(source.alphabet)}
    gedges = sorted([gi[a], gi[b], ai[c]] for a, c, b in source.edges)
    hedges = sorted([hi[a], hi[b], ai[c]] for a, c, b in target.edges)
    instance = {"alphabet_size": len(ai),
                "source": {"nodes": len(gi), "edges": gedges},
                "target": {"nodes": len(hi), "edges": hedges}}
    normalized = dict(instance, anchors={})
    digest = hashlib.sha256(json.dumps(normalized, sort_keys=True,
                                      separators=(",", ":")).encode()).hexdigest()
    k = len(target.vertices) - 1
    assignment = [gi[f"a{i}"] for i in range(k)] + [gi["terminal"]]
    words = [[] for _ in range(k)] + [[ai[x] for x in encoded_trace + ("$",)]]
    table = {(a, label): b for a, b, label in gedges}
    assert len(table) == len(gedges)
    paths = []
    for a, b, label in hedges:
        rhs = [label] + words[b]
        assert rhs[:len(words[a])] == words[a]
        path_word = rhs[len(words[a]):]
        vertices = [assignment[a]]
        for symbol in path_word:
            vertices.append(table[vertices[-1], symbol])
        paths.append({"target_edge": [a, b, label], "word": path_word,
                      "vertices": vertices})
    certificate = {"input_sha256": digest, "result": "sat",
                   "source_assignment": assignment, "words": words,
                   "source_paths": paths, "max_word_depth": max(map(len, words))}
    return instance, certificate


def check():
    records = []
    rng = random.Random(20261125)
    for k in range(2, 11):
        automata = counter_trace_automata(k)
        tables = deterministic_tables(automata)
        trace = counter_trace(k)
        assert all(len(a.states) == 8*k and len(a.edges) == 16*k-8 and
                   len(a.accepts) == 4 for a in automata)
        component = product_component(automata, tables)
        assert component["preperiod"] == k
        assert component["period"] == k*(1 << k)
        assert component["reachable_states"] == k*((1 << k)+1)
        assert component["accepting_positions_before_repetition"] == [len(trace)]
        assert component["generated_word"] == trace + trace[:k]
        for power in (1, 2, 3):
            assert accepts_all(automata, tables, trace*power)
        assert not accepts_all(automata, tables, ())
        assert not accepts_all(automata, tables, trace[:-1])
        assert not accepts_all(automata, tables, trace + ("0",))
        positions = sorted(set(rng.randrange(len(trace)) for _ in range(64)))
        for position in positions:
            changed = list(trace)
            changed[position] = str(1-int(changed[position]))
            assert not accepts_all(automata, tables, changed)
        source, target, encoding = fixed_four_gadget(automata)
        assert encoding == {"0": ("0", "0"), "1": ("0", "1")}
        assert partial_deterministic(source) and partial_deterministic(target)
        assert len(source.vertices) == 24*k*k+k+1
        assert len(source.edges) == 32*k*k-1
        assert len(target.vertices) == k+1
        assert len(target.edges) == 4*k-1
        encoded = tuple(bit for letter in trace for bit in encoding[letter])
        instance, certificate = raw_positive_certificate(source, target, encoded)
        raw_result = verify_certificate(instance, certificate)
        assert raw_result["max_word_depth"] == 2*k*(1 << k)+1
        component.pop("generated_word")
        records.append({"k": k, "dfa_count": k, "states_per_dfa": 8*k,
                        "transitions_per_dfa": 16*k-8, "accepts_per_dfa": 4,
                        "product": component, "single_bit_mutations_rejected": len(positions),
                        "source_vertices": len(source.vertices),
                        "source_edges": len(source.edges),
                        "target_vertices": len(target.vertices),
                        "target_edges": len(target.edges),
                        "independent_raw_certificate": raw_result})
    exhaustive = []
    for k, maximum in ((2, 16), (3, 12)):
        automata = counter_trace_automata(k)
        tables = deterministic_tables(automata)
        trace = counter_trace(k)
        checked = accepted = 0
        for length in range(maximum+1):
            for word in product(("0", "1"), repeat=length):
                actual = accepts_all(automata, tables, word)
                expected = length > 0 and length % len(trace) == 0 and word == trace*(length//len(trace))
                assert actual == expected, (k, word)
                checked += 1
                accepted += int(actual)
        exhaustive.append({"k": k, "maximum_length": maximum,
                           "words_checked": checked, "accepted": accepted})
    canonical = json.dumps({"families": records, "exhaustive": exhaustive},
                           sort_keys=True, separators=(",", ":")).encode()
    return {"status": "passed", "seed": 20261125,
            "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
            "records_sha256": hashlib.sha256(canonical).hexdigest(),
            "families": records, "exhaustive": exhaustive,
            "scope": ["Exact entire reachable product component for k=2,...,10",
                      "Exhaustive bounded binary membership checks for the recorded small ranges",
                      "Exact gadget counts and partial determinism",
                      "Independent literal source-path/word-equation verification of positive graph witnesses"],
            "not_certified_by_finite_tests": ["All-k language characterization",
                                              "Every-certificate statement",
                                              "Minimum SLP lower bound",
                                              "Polynomial compressed equality implementation",
                                              "Minimum graph depth from a complete unanchored graph search"]}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    result = check()
    rendered = json.dumps(result, indent=2, sort_keys=True)+"\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered)
    print(rendered, end="")
