#!/usr/bin/env python3
"""Finite validation of the secondary SLP representation proofs.

Rules are epsilon, one letter, or concatenation of two earlier rules. Exact
expansion has an explicit cap. This is not an implementation of Plandowski's
algorithm and is not a polynomial-time compressed certificate checker.
Boolean graph-relation evaluation does operate directly on the grammar.
"""
from __future__ import annotations

import argparse
import hashlib
from itertools import product
import json
from pathlib import Path
import random

from compressed_witnesses import counter_trace


EXPANSION_CAP = 200_000


def validate_and_lengths(rules, alphabet):
    """Reject noncanonical shapes and any reference that is not earlier."""
    lengths = []
    for index, rule in enumerate(rules):
        if rule.get("kind") == "epsilon" and set(rule) == {"kind"}:
            length = 0
        elif rule.get("kind") == "letter" and set(rule) == {"kind", "letter"}:
            if rule["letter"] not in alphabet:
                raise ValueError("letter outside alphabet")
            length = 1
        elif rule.get("kind") == "concat" and set(rule) == {"kind", "left", "right"}:
            left, right = rule["left"], rule["right"]
            if not (type(left) is int and type(right) is int and
                    0 <= left < index and 0 <= right < index):
                raise ValueError("concatenation must reference earlier rules")
            length = lengths[left] + lengths[right]
        else:
            raise ValueError("invalid rule shape")
        lengths.append(length)
    return lengths


def expand(rules, alphabet, cap=EXPANSION_CAP):
    """Expand only when every rule value is at most cap letters."""
    lengths = validate_and_lengths(rules, alphabet)
    if any(length > cap for length in lengths):
        raise ValueError("explicit expansion cap exceeded")
    words = []
    for rule in rules:
        if rule["kind"] == "epsilon":
            word = ()
        elif rule["kind"] == "letter":
            word = (rule["letter"],)
        else:
            word = words[rule["left"]] + words[rule["right"]]
        words.append(word)
    return words


def expand_root(rules, alphabet, root, cap=EXPANSION_CAP):
    """Expand one root iteratively, without storing all intermediate words."""
    lengths = validate_and_lengths(rules, alphabet)
    if type(root) is not int or not 0 <= root < len(rules):
        raise ValueError("invalid root")
    if lengths[root] > cap:
        raise ValueError("explicit expansion cap exceeded")
    answer, stack = [], [root]
    while stack:
        current = stack.pop()
        if lengths[current] == 0:
            continue
        rule = rules[current]
        if rule["kind"] == "letter":
            answer.append(rule["letter"])
        elif rule["kind"] == "concat":
            stack.extend((rule["right"], rule["left"]))
    assert len(answer) == lengths[root]
    return tuple(answer)


def counter_grammar(k):
    """The exact 3*2^k+2 rule construction in Lemma S3."""
    if type(k) is not int or k < 2:
        raise ValueError("k must be an integer >= 2")
    rules = [{"kind": "epsilon"}, {"kind": "letter", "letter": "0"},
             {"kind": "letter", "letter": "1"},
             {"kind": "concat", "left": 1, "right": 1},
             {"kind": "concat", "left": 1, "right": 2}]
    blocks = {("0",): 3, ("1",): 4}
    for length in range(2, k+1):
        for block in product(("0", "1"), repeat=length):
            rules.append({"kind": "concat", "left": blocks[block[:-1]],
                          "right": blocks[block[-1:]]})
            blocks[block] = len(rules)-1
    order = [blocks[tuple(str((number >> bit) & 1) for bit in range(k))]
             for number in range(1 << k)]
    root = order[0]
    for block_root in order[1:]:
        rules.append({"kind": "concat", "left": root, "right": block_root})
        root = len(rules)-1
    rules.append({"kind": "letter", "letter": "$"})
    rules.append({"kind": "concat", "left": root, "right": len(rules)-1})
    return rules, {"epsilon": 0, "certificate_word": len(rules)-1}


def factor_injections(k):
    """Check the displayed pairs, their recovery, and coded distinctness."""
    trace = counter_trace(k)
    factors, encoded_factors = set(), set()
    for x in range(0, (1 << k)-2, 2):
        for r in range(1, k):
            factor = trace[k*x+r:k*x+r+2*k]
            assert len(factor) == 2*k
            first, second = factor[:k], factor[k:]
            mismatch = next(j for j in range(k) if first[j] != second[j])
            recovered_r = k-mismatch
            assert recovered_r == r
            middle = factor[k-r:2*k-r]
            recovered_x = sum(int(bit) << i for i, bit in enumerate(middle))-1
            assert recovered_x == x
            factors.add(factor)
            encoded_factors.add(tuple(b for a in factor for b in ("0", a)))
    expected = (k-1)*((1 << (k-1))-1)
    assert len(factors) == len(encoded_factors) == expected
    return expected


def compose_boolean(left, right):
    """Rows are bitsets; composition follows chronological concatenation."""
    result = []
    for row in left:
        target_row = 0
        remaining = row
        while remaining:
            bit = remaining & -remaining
            target_row |= right[bit.bit_length()-1]
            remaining ^= bit
        result.append(target_row)
    return tuple(result)


def grammar_relations(rules, alphabet, vertex_count, edges):
    """Compute path endpoint relations without expanding the rule values."""
    validate_and_lengths(rules, alphabet)
    adjacency = {letter: [0]*vertex_count for letter in alphabet}
    for source, target, letter in edges:
        if not (0 <= source < vertex_count and 0 <= target < vertex_count and letter in alphabet):
            raise ValueError("invalid graph edge")
        adjacency[letter][source] |= 1 << target
    relations = []
    for rule in rules:
        if rule["kind"] == "epsilon":
            relation = tuple(1 << i for i in range(vertex_count))
        elif rule["kind"] == "letter":
            relation = tuple(adjacency[rule["letter"]])
        else:
            relation = compose_boolean(relations[rule["left"]], relations[rule["right"]])
        relations.append(relation)
    return relations


def explicit_relation(word, vertex_count, edges):
    """Independent set-based path simulation, including zero-length paths."""
    rows = []
    for source in range(vertex_count):
        states = {source}
        for letter in word:
            states = {b for a, b, label in edges if a in states and label == letter}
        rows.append(sum(1 << state for state in states))
    return tuple(rows)


def random_checks():
    rng = random.Random(20261125)
    alphabet = ("0", "1", "$")
    factor_checks = relation_checks = epsilon_roots = reused_roots = 0
    summaries = []
    for index in range(400):
        rules = [{"kind": "epsilon"}, {"kind": "letter", "letter": "0"},
                 {"kind": "letter", "letter": "1"}]
        lengths = [0, 1, 1]
        for _ in range(rng.randrange(8, 28)):
            kind = rng.randrange(5)
            if kind == 0:
                rule, length = {"kind": "epsilon"}, 0
            elif kind == 1:
                rule, length = {"kind": "letter", "letter": rng.choice(alphabet)}, 1
            else:
                left, right = rng.randrange(len(rules)), rng.randrange(len(rules))
                rule = {"kind": "concat", "left": left, "right": right}
                length = lengths[left]+lengths[right]
            rules.append(rule)
            lengths.append(length)
        words = expand(rules, alphabet, cap=4096)
        binary_rules = sum(rule["kind"] == "concat" for rule in rules)
        roots = list(range(len(rules)))+[len(rules)-1, len(rules)-1]
        reused_roots += 2
        for root in roots:
            word = words[root]
            assert expand_root(rules, alphabet, root, cap=4096) == word
            epsilon_roots += int(not word)
            for length in range(2, min(len(word)+2, 14)):
                distinct = len({word[start:start+length]
                                for start in range(len(word)-length+1)})
                assert distinct <= binary_rules*(length-1)
                factor_checks += 1
        vertex_count = index % 6
        edges = [(a, b, letter) for a in range(vertex_count) for b in range(vertex_count)
                 for letter in alphabet if rng.randrange(4) == 0]
        relations = grammar_relations(rules, alphabet, vertex_count, edges)
        for root in roots:
            assert relations[root] == explicit_relation(words[root], vertex_count, edges)
            relation_checks += 1
        summaries.append([len(rules), max(lengths), vertex_count, len(edges)])
    # An actual exponentially expanded word demonstrates the cap is enforced.
    capped = [{"kind": "letter", "letter": "0"}]
    for j in range(20):
        capped.append({"kind": "concat", "left": j, "right": j})
    try:
        expand(capped, alphabet)
    except ValueError as error:
        assert "cap exceeded" in str(error)
    else:
        raise AssertionError("expansion cap was not enforced")
    for bad in ([{"kind": "concat", "left": 0, "right": 0}],
                [{"kind": "letter", "letter": "outside"}],
                [{"kind": "epsilon", "extra": 1}]):
        try:
            validate_and_lengths(bad, alphabet)
        except ValueError:
            pass
        else:
            raise AssertionError("malformed grammar accepted")
    return {"seed": 20261125, "grammars": len(summaries),
            "factor_bound_comparisons": factor_checks,
            "boolean_relation_comparisons": relation_checks,
            "empty_root_occurrences": epsilon_roots,
            "reused_root_occurrences": reused_roots,
            "graph_vertex_counts": list(range(6)),
            "summary_sha256": hashlib.sha256(json.dumps(summaries,
                separators=(",", ":")).encode()).hexdigest(),
            "explicit_expansion_cap_test": "passed", "malformed_grammar_tests": 3}


def check():
    records = []
    for k in range(2, 13):
        rules, roots = counter_grammar(k)
        trace = counter_trace(k)
        expected = tuple(bit for letter in trace for bit in ("0", letter))+("$",)
        assert expand_root(rules, ("0", "1", "$"), roots["epsilon"]) == ()
        assert expand_root(rules, ("0", "1", "$"), roots["certificate_word"]) == expected
        assert len(rules) == 3*(1 << k)+2
        factor_count = factor_injections(k)
        records.append({"k": k, "rules": len(rules),
                        "expanded_certificate_length": len(expected),
                        "distinct_selected_binary_factors": factor_count,
                        "distinct_selected_encoded_factors": factor_count,
                        "proved_rule_lower_bound": (factor_count+4*k-2)//(4*k-1),
                        "word_sha256": hashlib.sha256("".join(expected).encode()).hexdigest()})
    result = {"status": "passed", "expansion_cap": EXPANSION_CAP,
              "counter_families": records, "random_grammar_checks": random_checks(),
              "script_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
              "scope": ["Finite checks of exact displayed grammar and factor injection",
                        "Explicit-factor checks of classical binary-rule mk bound",
                        "Direct grammar Boolean-relation evaluation against explicit path simulation"],
              "limitations": ["No implementation of Plandowski equality",
                              "No complete polynomial compressed certificate verifier",
                              "Expansion-dependent checks have a cap and are not polynomial in grammar size",
                              "General lower bounds and complexity classifications require manuscript proofs"]}
    return result


def write_example(path):
    rules, roots = counter_grammar(3)
    example = {"kind": "concatenation_slp_word_representation", "k": 3,
               "alphabet": ["0", "1", "$"], "rules": rules, "roots": roots,
               "target_word_roots": {"x0": roots["epsilon"], "x1": roots["epsilon"],
                                     "x2": roots["epsilon"], "z": roots["certificate_word"]},
               "scope": "Word representation only; not a full graph/source-assignment certificate",
               "expected_rules": 26, "expected_expanded_z_length": 49}
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(json.dumps(example, indent=2, sort_keys=True)+"\n")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--write-example", type=Path)
    args = parser.parse_args()
    result = check()
    if args.write_example:
        write_example(args.write_example)
    rendered = json.dumps(result, indent=2, sort_keys=True)+"\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered)
    print(rendered, end="")
