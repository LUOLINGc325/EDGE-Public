#!/usr/bin/env python3
"""Reproducible finite checks for manuscript/hardness.md.

Uses only Python's standard library. The bounded graph solver knows neither
the marker-pinning lemma nor the intended automaton interpretation: it checks
all source images and all words up to the stated bound against the literal
chronological equation u_a p = label u_b.

Run from the case directory:
    python code/hardness_gadgets.py --output results/hardness_checks.json

Finite tests are error detection, not a substitute for the manuscript proofs.
"""

from __future__ import annotations

import argparse
from collections import defaultdict, deque
from dataclasses import dataclass
from functools import lru_cache
import hashlib
from itertools import product
import json
from pathlib import Path
import random


Word = tuple[str, ...]
StateWord = tuple[str, Word]


@dataclass(frozen=True)
class Automaton:
    states: tuple[int, ...]
    alphabet: tuple[str, ...]
    initials: frozenset[int]
    accepts: frozenset[int]
    edges: frozenset[tuple[int, str, int]]


@dataclass(frozen=True)
class Graph:
    vertices: tuple[str, ...]
    alphabet: tuple[str, ...]
    edges: frozenset[tuple[str, str, str]]


def transition_table(edges):
    table = defaultdict(set)
    for source, label, target in edges:
        table[source, label].add(target)
    return {key: frozenset(value) for key, value in table.items()}


def partial_deterministic(graph: Graph) -> bool:
    return all(len(value) <= 1 for value in transition_table(graph.edges).values())


def shortest_common_word(automata: tuple[Automaton, ...]) -> Word | None:
    """BFS of the ordinary product NFA, including arbitrary initial sets."""
    assert automata and all(a.alphabet == automata[0].alphabet for a in automata)
    tables = [transition_table(a.edges) for a in automata]
    starts = tuple(product(*(sorted(a.initials) for a in automata)))
    queue = deque((state, ()) for state in starts)
    seen = set(starts)
    while queue:
        state, word = queue.popleft()
        if all(q in a.accepts for q, a in zip(state, automata)):
            return word
        for letter in automata[0].alphabet:
            successors = product(*(sorted(tables[i].get((q, letter), ()))
                                   for i, q in enumerate(state)))
            for successor in successors:
                if successor not in seen:
                    seen.add(successor)
                    queue.append((successor, word + (letter,)))
    return None


def direct_gadget(automata: tuple[Automaton, ...]) -> tuple[Graph, Graph]:
    assert len(automata) >= 2
    base = automata[0].alphabet
    assert all(a.alphabet == base for a in automata)
    k = len(automata)
    markers = tuple(label for i in range(k) for label in (f"r{i}", f"s{i}"))
    assert not set(base) & set(markers + ("#", "$"))
    alphabet = base + markers + ("#", "$")
    anchors = tuple(f"a{i}" for i in range(k))
    copied = tuple(f"q{i}:{q}" for i, a in enumerate(automata) for q in a.states)
    vertices = anchors + copied + ("terminal",)
    source_edges = set()
    target_edges = set()
    for i, automaton in enumerate(automata):
        for letter in (f"r{i}", f"s{i}"):
            source_edges.add((f"a{i}", letter, f"a{i}"))
            target_edges.add((f"x{i}", letter, f"x{i}"))
        source_edges.update((f"a{i}", "#", f"q{i}:{q}") for q in automaton.initials)
        source_edges.update((f"q{i}:{q}", letter, f"q{i}:{p}")
                            for q, letter, p in automaton.edges)
        source_edges.update((f"q{i}:{q}", "$", "terminal") for q in automaton.accepts)
        target_edges.add((f"x{i}", "#", "z"))
    source = Graph(vertices, alphabet, frozenset(source_edges))
    target = Graph(tuple(f"x{i}" for i in range(k)) + ("z",), alphabet,
                   frozenset(target_edges))
    return source, target


def code_binary(automaton: Automaton) -> tuple[Automaton, dict[str, Word]]:
    """Fixed-length coding with phase length >= 2, exactly as Lemma 3."""
    m = len(automaton.alphabet)
    assert m > 0 and len(automaton.initials) == 1
    ell = max(2, (m - 1).bit_length())
    encoding = {letter: tuple(f"{i:0{ell}b}")
                for i, letter in enumerate(automaton.alphabet)}
    decoding = {word: letter for letter, word in encoding.items()}
    prefixes = tuple(word for length in range(ell)
                     for word in product(("0", "1"), repeat=length))
    pairs = tuple((q, prefix) for q in automaton.states for prefix in prefixes)
    index = {pair: i for i, pair in enumerate(pairs)}
    table = transition_table(automaton.edges)
    assert all(len(targets) <= 1 for targets in table.values())
    edges = set()
    for q, prefix in pairs:
        for bit in ("0", "1"):
            extended = prefix + (bit,)
            if len(extended) < ell:
                edges.add((index[q, prefix], bit, index[q, extended]))
            elif extended in decoding:
                for successor in table.get((q, decoding[extended]), ()):
                    edges.add((index[q, prefix], bit, index[successor, ()]))
    coded = Automaton(
        tuple(range(len(pairs))), ("0", "1"),
        frozenset(index[q, ()] for q in automaton.initials),
        frozenset(index[q, ()] for q in automaton.accepts), frozenset(edges))
    assert all(source != target for source, _, target in coded.edges)
    return coded, encoding


def fixed_four_gadget(automata: tuple[Automaton, ...]):
    coded_and_maps = tuple(code_binary(a) for a in automata)
    coded = tuple(item[0] for item in coded_and_maps)
    encoding = coded_and_maps[0][1]
    assert all(mapping == encoding for _, mapping in coded_and_maps)
    k = len(coded)
    assert k >= 2
    alphabet = ("0", "1", "#", "$")
    vertices = (tuple(f"a{i}" for i in range(k)) +
                tuple(f"q{i}:{q}" for i, a in enumerate(coded) for q in a.states) +
                ("terminal",))
    source_edges = set()
    target_edges = set()
    for i, automaton in enumerate(coded):
        for bit in ("0", "1"):
            source_edges.add((f"a{i}", bit, f"a{i}"))
            target_edges.add((f"x{i}", bit, f"x{i}"))
        if i + 1 < k:
            source_edges.add((f"a{i}", "$", f"a{i+1}"))
            target_edges.add((f"x{i}", "$", f"x{i+1}"))
        source_edges.update((f"a{i}", "#", f"q{i}:{q}") for q in automaton.initials)
        source_edges.update((f"q{i}:{q}", letter, f"q{i}:{p}")
                            for q, letter, p in automaton.edges)
        source_edges.update((f"q{i}:{q}", "$", "terminal") for q in automaton.accepts)
        target_edges.add((f"x{i}", "#", "z"))
    source = Graph(vertices, alphabet, frozenset(source_edges))
    target = Graph(tuple(f"x{i}" for i in range(k)) + ("z",), alphabet,
                   frozenset(target_edges))
    assert partial_deterministic(source) and partial_deterministic(target)
    return source, target, encoding


def path_complete_padding(graph: Graph) -> Graph:
    """Adjoin a disjoint complete two-state swap component with no selfloops."""
    assert "pc0" not in graph.vertices and "pc1" not in graph.vertices
    extra = frozenset((f"pc{i}", letter, f"pc{1-i}")
                      for i in (0, 1) for letter in graph.alphabet)
    padded = Graph(graph.vertices + ("pc0", "pc1"), graph.alphabet, graph.edges | extra)
    assert partial_deterministic(padded)
    assert all(source != target for source, _, target in extra)
    return padded


def edge_predicate(source: Graph):
    table = transition_table(source.edges)

    @lru_cache(maxsize=None)
    def reachable(start: str, word: Word):
        states = frozenset((start,))
        for letter in word:
            states = frozenset(q for state in states
                               for q in table.get((state, letter), ()))
            if not states:
                break
        return states

    def holds(left: StateWord, label: str, right: StateWord) -> bool:
        start, prefix = left
        endpoint, tail = right
        rhs = (label,) + tail
        if len(prefix) > len(rhs) or rhs[:len(prefix)] != prefix:
            return False
        path_word = rhs[len(prefix):]
        return endpoint in reachable(start, path_word)

    return holds


def verify_witness(source: Graph, target: Graph, witness: dict[str, StateWord]) -> bool:
    if set(witness) != set(target.vertices):
        return False
    if any(state not in source.vertices or any(x not in source.alphabet for x in word)
           for state, word in witness.values()):
        return False
    holds = edge_predicate(source)
    return all(holds(witness[a], label, witness[b]) for a, label, b in target.edges)


@lru_cache(maxsize=None)
def all_words(alphabet: tuple[str, ...], maximum: int) -> tuple[Word, ...]:
    return tuple(word for length in range(maximum + 1)
                 for word in product(alphabet, repeat=length))


def bounded_unanchored_witness(source: Graph, target: Graph, maximum: int):
    """Finite-domain CSP over ALL source states and full-alphabet words.

    The pruning is generic arc consistency plus backtracking. There is no
    special treatment of anchors, terminal states, markers, or chain edges.
    """
    assert source.alphabet == target.alphabet
    holds = edge_predicate(source)
    candidates = tuple((state, word) for word in all_words(source.alphabet, maximum)
                       for state in source.vertices)
    loops = defaultdict(list)
    edges = []
    for a, label, b in sorted(target.edges):
        if a == b:
            loops[a].append(label)
        else:
            edges.append((a, label, b))
    domains = {q: [candidate for candidate in candidates
                   if all(holds(candidate, label, candidate) for label in loops[q])]
               for q in target.vertices}

    def propagate(current):
        changed = True
        while changed:
            if any(not domain for domain in current.values()):
                return None
            changed = False
            for a, label, b in edges:
                left = [v for v in current[a]
                        if any(holds(v, label, w) for w in current[b])]
                right = [w for w in current[b]
                         if any(holds(v, label, w) for v in left)]
                if not left or not right:
                    return None
                if len(left) != len(current[a]) or len(right) != len(current[b]):
                    changed = True
                current[a], current[b] = left, right
        return current

    def search(current):
        current = propagate(current)
        if current is None:
            return None
        nonsingleton = [q for q in target.vertices if len(current[q]) > 1]
        if not nonsingleton:
            answer = {q: current[q][0] for q in target.vertices}
            assert verify_witness(source, target, answer)
            return answer
        variable = min(nonsingleton, key=lambda q: len(current[q]))
        for value in current[variable]:
            child = {q: list(domain) for q, domain in current.items()}
            child[variable] = [value]
            answer = search(child)
            if answer is not None:
                return answer
        return None

    return search(domains)


def counter_automata(k: int) -> tuple[Automaton, ...]:
    alphabet = tuple(f"c{j}" for j in range(k))
    result = []
    for r in range(k):
        edges = set()
        for j, letter in enumerate(alphabet):
            if j < r:
                edges.update(((0, letter, 0), (1, letter, 1)))
            elif j == r:
                edges.add((0, letter, 1))
            else:
                edges.add((1, letter, 0))
        result.append(Automaton((0, 1), alphabet, frozenset((0,)),
                                frozenset((1,)), frozenset(edges)))
    return tuple(result)


def check_counter(k: int):
    automata = counter_automata(k)
    tables = [transition_table(a.edges) for a in automata]
    current = (0,) * k
    run = []
    seen = {current}
    while True:
        enabled = []
        for letter in automata[0].alphabet:
            choices = tuple(tables[r].get((current[r], letter), ()) for r in range(k))
            if all(choices):
                enabled.append((letter, tuple(next(iter(choice)) for choice in choices)))
        if not enabled:
            assert current == (1,) * k
            break
        assert len(enabled) == 1
        letter, following = enabled[0]
        assert following not in seen
        assert sum(bit << r for r, bit in enumerate(following)) == len(run) + 1
        seen.add(following)
        run.append(letter)
        current = following
    recursive_word = ()
    for j in range(k):
        recursive_word = recursive_word + (f"c{j}",) + recursive_word
    assert tuple(run) == recursive_word
    assert len(seen) == 2 ** k and len(run) == 2 ** k - 1
    assert shortest_common_word(automata) == tuple(run)
    source, target = direct_gadget(automata)
    witness = {f"x{i}": (f"a{i}", ()) for i in range(k)}
    witness["z"] = ("terminal", tuple(run) + ("$",))
    assert verify_witness(source, target, witness)
    assert partial_deterministic(source) and partial_deterministic(target)
    assert len(source.vertices) == 3 * k + 1
    assert len(source.edges) == (3 * k * k + 7 * k) // 2
    assert len(target.vertices) == k + 1 and len(target.edges) == 3 * k
    assert len(source.alphabet) == 3 * k + 2
    # Deleting the terminal $ or any one position of the forced count must fail.
    truncated = dict(witness)
    truncated["z"] = ("terminal", tuple(run))
    assert not verify_witness(source, target, truncated)
    for deleted in sorted({0, len(run) // 2, len(run) - 1}):
        corrupted = dict(witness)
        corrupted["z"] = ("terminal", tuple(run[:deleted] + run[deleted+1:]) + ("$",))
        assert not verify_witness(source, target, corrupted)
    return {"k": k, "product_states_visited": len(seen), "common_word_length": len(run),
            "composition_depth": len(run) + 1, "source_vertices": len(source.vertices),
            "source_edges": len(source.edges), "target_vertices": len(target.vertices),
            "target_edges": len(target.edges), "alphabet_size": len(source.alphabet)}


def unary_partial_dfas() -> tuple[Automaton, ...]:
    machines = []
    for transitions in product((None, 0, 1), repeat=2):
        edges = frozenset((q, "a", successor) for q, successor in enumerate(transitions)
                          if successor is not None)
        for accepting_mask in range(4):
            machines.append(Automaton((0, 1), ("a",), frozenset((0,)),
                                      frozenset(q for q in (0, 1) if accepting_mask >> q & 1),
                                      edges))
    return tuple(machines)


def check_bounded_pair(automata: tuple[Automaton, ...], maximum: int, fixed: bool):
    common = shortest_common_word(automata)
    if fixed:
        source, target, encoding = fixed_four_gadget(automata)
        coded = None if common is None else tuple(bit for letter in common for bit in encoding[letter])
        expected = coded is not None and len(coded) + 1 <= maximum
    else:
        source, target = direct_gadget(automata)
        expected = common is not None and len(common) + 1 <= maximum
    witness = bounded_unanchored_witness(source, target, maximum)
    assert (witness is not None) == expected, (automata, maximum, fixed, common, witness)
    if witness is not None:
        for i in range(len(automata)):
            assert witness[f"x{i}"] == (f"a{i}", ())
        assert witness["z"][0] == "terminal" and witness["z"][1][-1:] == ("$",)
    return int(expected)


def run_checks():
    direct_count = fixed_count = direct_positive = fixed_positive = 0
    machines = unary_partial_dfas()
    for first, second in product(machines, repeat=2):
        pair = (first, second)
        direct_positive += check_bounded_pair(pair, maximum=2, fixed=False)
        fixed_positive += check_bounded_pair(pair, maximum=3, fixed=True)
        direct_count += 1
        fixed_count += 1

    # Exhaust all one-state NFAs, including empty initial and accepting sets.
    one_state = tuple(Automaton((0,), ("a",), frozenset((0,)) if initial else frozenset(),
                                frozenset((0,)) if accepting else frozenset(),
                                frozenset(((0, "a", 0),)) if loop else frozenset())
                      for initial, accepting, loop in product((False, True), repeat=3))
    nfa_count = nfa_positive = 0
    for pair in product(one_state, repeat=2):
        nfa_positive += check_bounded_pair(pair, maximum=2, fixed=False)
        nfa_count += 1

    # Additional reproducible NFA cases include multiple initial states,
    # branching, and three independent copies. All alphabet words are searched.
    rng = random.Random(20261125)
    randomized_count = randomized_positive = 0
    for index in range(160):
        k = 3 if index % 8 == 0 else 2
        pair = []
        for _ in range(k):
            initials = frozenset(q for q in (0, 1) if rng.randrange(2))
            accepts = frozenset(q for q in (0, 1) if rng.randrange(2))
            edges = frozenset((q, "a", p) for q in (0, 1) for p in (0, 1)
                              if rng.randrange(2))
            pair.append(Automaton((0, 1), ("a",), initials, accepts, edges))
        randomized_positive += check_bounded_pair(tuple(pair), maximum=2, fixed=False)
        randomized_count += 1

    # Deliberately nontrivial code alphabets and accepted words of length >= 2.
    coded_cases = []
    for word in (("a", "b"), ("d", "c", "a"), (), ("b",)):
        alphabet = ("a", "b", "c", "d")
        edges = frozenset((i, letter, i + 1) for i, letter in enumerate(word))
        machine = Automaton(tuple(range(len(word) + 1)), alphabet, frozenset((0,)),
                            frozenset((len(word),)), edges)
        source, target, encoding = fixed_four_gadget((machine, machine, machine))
        coded_word = tuple(bit for letter in word for bit in encoding[letter])
        witness = {f"x{i}": (f"a{i}", ()) for i in range(3)}
        witness["z"] = ("terminal", coded_word + ("$",))
        assert verify_witness(source, target, witness)
        coded_cases.append({"input_word": word, "coded_word": coded_word,
                            "depth": len(coded_word) + 1})

    def singleton_unary(length):
        return Automaton(tuple(range(length + 1)), ("a",), frozenset((0,)),
                         frozenset((length,)),
                         frozenset((i, "a", i + 1) for i in range(length)))

    pc_cases = []
    for first_length, second_length in ((0, 0), (1, 1), (0, 1), (1, 2)):
        pair = (singleton_unary(first_length), singleton_unary(second_length))
        source, target, _ = fixed_four_gadget(pair)
        source, target = path_complete_padding(source), path_complete_padding(target)
        maximum = 3
        witness = bounded_unanchored_witness(source, target, maximum)
        expected = first_length == second_length
        assert (witness is not None) == expected
        if witness is not None:
            assert witness["x0"] == ("a0", ()) and witness["x1"] == ("a1", ())
            assert witness["z"][0] == "terminal"
        # Every word up to length 5 is witnessed from pc0, independently of
        # all original components. The universal property follows from the
        # complete swap transition table, proved in Corollary 4.1.
        table = transition_table(source.edges)
        for word in all_words(source.alphabet, 5):
            states = {"pc0"}
            for letter in word:
                states = {q for state in states for q in table.get((state, letter), ())}
            assert len(states) == 1 and states <= {"pc0", "pc1"}
        pc_cases.append({"first_singleton_word_length": first_length,
                         "second_singleton_word_length": second_length,
                         "bounded_depth": maximum, "satisfiable": expected,
                         "all_source_images_and_words_enumerated": True})

    counters = [check_counter(k) for k in range(2, 13)]
    script_hash = hashlib.sha256(Path(__file__).read_bytes()).hexdigest()
    return {
        "status": "PASS",
        "script_sha256": script_hash,
        "chronological_equation": "u_a ++ p = [label] ++ u_b",
        "verification_scope": "Finite checks support, but do not replace, the manuscript proofs.",
        "direct_gadget_exhaustive_unary_partial_dfa_pairs": {
            "automata": len(machines), "ordered_pairs": direct_count,
            "maximum_composition_depth": 2, "positive": direct_positive,
            "domain": "All source states and all full-alphabet words up to the bound."},
        "four_letter_gadget_exhaustive_unary_partial_dfa_pairs": {
            "ordered_pairs": fixed_count, "maximum_composition_depth": 3,
            "positive": fixed_positive,
            "domain": "All source states and all four-letter words up to the bound."},
        "one_state_nfa_pairs_with_empty_initial_sets": {
            "ordered_pairs": nfa_count, "maximum_composition_depth": 2, "positive": nfa_positive},
        "randomized_two_state_nfas": {
            "seed": 20261125, "instances": randomized_count,
            "copies": "Two or three", "maximum_composition_depth": 2,
            "positive": randomized_positive},
        "additional_four_letter_coded_words": coded_cases,
        "path_complete_padding_generic_csp_checks": pc_cases,
        "binary_counter_families": counters,
        "parameter_warning": "Depth 2^k; explicit binary input size Theta(k^2 log k), not Theta(k).",
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    result = run_checks()
    text = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(text, encoding="utf-8")
    print(text, end="")


if __name__ == "__main__":
    main()
