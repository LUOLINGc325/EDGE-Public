#!/usr/bin/env python3
"""Cross-check independent hardness constructions with the full automaton."""
import argparse
import json
from pathlib import Path

from hardness_gadgets import Automaton, counter_automata, direct_gadget, fixed_four_gadget
from certificate_solver import solve_instance
from verify_certificate import verify_certificate


def convert(pair):
    g, h = pair[:2]
    gi = {v: i for i, v in enumerate(g.vertices)}
    hi = {v: i for i, v in enumerate(h.vertices)}
    ai = {a: i for i, a in enumerate(g.alphabet)}
    return {"alphabet_size": len(ai),
            "source": {"nodes": len(gi), "edges": [[gi[a], gi[b], ai[c]] for a, c, b in sorted(g.edges)]},
            "target": {"nodes": len(hi), "edges": [[hi[a], hi[b], ai[c]] for a, c, b in sorted(h.edges)]}}


def singleton(length):
    return Automaton(tuple(range(length + 1)), ("a",), frozenset({0}), frozenset({length}),
                     frozenset((i, "a", i + 1) for i in range(length)))


def check():
    cases = [
        ("direct_counter_2", direct_gadget(counter_automata(2)), "sat", 4),
        ("direct_disjoint_singletons", direct_gadget((singleton(1), singleton(2))), "unsat", None),
        ("fixed_four_singleton", fixed_four_gadget((singleton(1), singleton(1))), "sat", 3),
    ]
    records = []
    for name, pair, expected, depth in cases:
        raw = convert(pair)
        result = solve_instance(raw, max_states=1_000_000)
        assert result["result"] == expected, (name, result)
        if depth is not None:
            assert result["max_word_depth"] == depth, (name, result)
            verify_certificate(raw, result)
        records.append({"name": name, "result": result["result"],
                        "max_word_depth": result.get("max_word_depth"),
                        "assignments_tested": result["search"]["assignments_tested"],
                        "ordinary_states_visited": result["search"]["ordinary_states_visited"]})
    return {"status": "passed",
            "method": "general synchronous BFS, independent of hardness gadget interpretation; positive raw-path verification",
            "instances": records}


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    rendered = json.dumps(check(), indent=2, sort_keys=True) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered)
    print(rendered, end="")
