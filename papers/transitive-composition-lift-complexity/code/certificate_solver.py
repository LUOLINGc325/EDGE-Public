#!/usr/bin/env python3
"""Exact finite-state solver for transitive forward-composition certificates.

All words are chronological.  For every target edge (a,b,i), a certificate
chooses a source path s[a] --p--> s[b] satisfying u[a] + p == [i] + u[b].
Only Python's standard library is required.  This is a mathematical prototype;
its explicit BFS can be exponentially large.  Hitting --max-states raises a
resource-limit result and is never reported as mathematical unsatisfiability.

Usage:
  python3 certificate_solver.py instance.json --output certificate.json
  python3 certificate_solver.py --self-test --output checks.json
"""
from __future__ import annotations

import argparse
from collections import deque
from dataclasses import dataclass
from hashlib import sha256
from itertools import product
import json
from pathlib import Path
import random
from typing import Any, Iterable

PAD = -1
State = tuple[tuple[int, ...], tuple[int, ...]]


class SearchLimit(RuntimeError):
    """The explicit implementation exhausted a stated resource allowance."""


def canonical(value: Any) -> str:
    return json.dumps(value, sort_keys=True, separators=(",", ":"))


@dataclass(frozen=True)
class Graph:
    nodes: int
    alphabet_size: int
    edges: tuple[tuple[int, int, int], ...]

    @classmethod
    def make(cls, nodes: int, alphabet_size: int,
             edges: Iterable[Iterable[int]]) -> "Graph":
        if type(nodes) is not int or nodes < 0:
            raise ValueError("nodes must be a nonnegative integer")
        if type(alphabet_size) is not int or alphabet_size < 1:
            raise ValueError("alphabet_size must be a positive integer")
        converted = []
        for raw in edges:
            e = tuple(raw)
            if len(e) != 3 or any(type(x) is not int for x in e):
                raise ValueError("each edge must contain three integer indices")
            a, b, i = e
            if not (0 <= a < nodes and 0 <= b < nodes and
                    0 <= i < alphabet_size):
                raise ValueError("edge index outside graph or alphabet")
            converted.append(e)
        return cls(nodes, alphabet_size, tuple(sorted(set(converted))))

    def as_dict(self) -> dict[str, Any]:
        return {"nodes": self.nodes, "edges": [list(e) for e in self.edges]}


def parse_instance(raw: dict[str, Any]) -> tuple[Graph, Graph, dict[int, int]]:
    m = raw["alphabet_size"]
    source = Graph.make(raw["source"]["nodes"], m, raw["source"]["edges"])
    target = Graph.make(raw["target"]["nodes"], m, raw["target"]["edges"])
    raw_anchors = raw.get("anchors", {})
    if isinstance(raw_anchors, list):
        if len(raw_anchors) != target.nodes:
            raise ValueError("anchor list has wrong length")
        raw_anchors = {q: s for q, s in enumerate(raw_anchors) if s is not None}
    if not isinstance(raw_anchors, dict):
        raise ValueError("anchors must be a dictionary or a list")
    anchors: dict[int, int] = {}
    for q, s in raw_anchors.items():
        if isinstance(q, str):
            if not q.isdecimal():
                raise ValueError("target anchor keys must be indices")
            q = int(q)
        if type(q) is not int or type(s) is not int:
            raise ValueError("anchors must be integer indices")
        if not (0 <= q < target.nodes and 0 <= s < source.nodes):
            raise ValueError("anchor outside graph")
        if q in anchors and anchors[q] != s:
            raise ValueError("conflicting anchors")
        anchors[q] = s
    return source, target, anchors


def normalized_instance(source: Graph, target: Graph,
                        anchors: dict[int, int]) -> dict[str, Any]:
    return {"alphabet_size": source.alphabet_size,
            "source": source.as_dict(), "target": target.as_dict(),
            "anchors": {str(q): s for q, s in sorted(anchors.items())}}


def state_bound(source: Graph, target: Graph) -> int:
    # The empty target is handled explicitly, including the empty source.
    if target.nodes == 0:
        return 1
    if source.nodes == 0:
        return 0
    return source.nodes ** len(target.edges) * (source.alphabet_size + 1) ** target.nodes


def _columns(previous: tuple[int, ...] | None, n: int, m: int):
    values = tuple(range(m)) + (PAD,)
    choices = [((PAD,) if previous is not None and previous[q] == PAD else values)
               for q in range(n)]
    return product(*choices)


def _successors(source: Graph, target: Graph, assignment: tuple[int, ...],
                previous: tuple[int, ...] | None, path_states: tuple[int, ...],
                adjacency: dict[tuple[int, int], tuple[int, ...]]):
    for column in _columns(previous, target.nodes, source.alphabet_size):
        choices: list[tuple[int, ...]] = []
        for e, (a, b, i) in enumerate(target.edges):
            rhs = i if previous is None else previous[b]
            if column[a] != PAD:
                if column[a] != rhs:
                    break
                choices.append((path_states[e],))
            elif rhs == PAD:
                choices.append((path_states[e],))
            else:
                possible = adjacency.get((path_states[e], rhs), ())
                if not possible:
                    break
                choices.append(possible)
        else:
            for new_path_states in product(*choices):
                yield (tuple(column), tuple(new_path_states))


def _reconstruct(source: Graph, target: Graph, assignment: tuple[int, ...],
                 found: State, parent: dict[State, State | None]) -> dict[str, Any]:
    chain = []
    current: State | None = found
    while current is not None:
        chain.append(current)
        current = parent[current]
    chain.reverse()
    words = [[state[0][q] for state in chain if state[0][q] != PAD]
             for q in range(target.nodes)]
    paths = [{"target_edge": list(edge), "vertices": [assignment[edge[0]]], "word": []}
             for edge in target.edges]
    previous = None
    for column, path_states in chain:
        for e, (a, b, i) in enumerate(target.edges):
            rhs = i if previous is None else previous[b]
            if column[a] == PAD and rhs != PAD:
                paths[e]["word"].append(rhs)
                paths[e]["vertices"].append(path_states[e])
        previous = column
    return {"source_assignment": list(assignment), "words": words,
            "source_paths": paths, "max_word_depth": max(map(len, words), default=0),
            "convolution_columns_including_flush": len(chain)}


def _solve_assignment(source: Graph, target: Graph, assignment: tuple[int, ...],
                      adjacency: dict[tuple[int, int], tuple[int, ...]],
                      remaining_states: int | None) -> tuple[dict[str, Any] | None, int]:
    initial_paths = tuple(assignment[a] for a, _, _ in target.edges)
    final_paths = tuple(assignment[b] for _, b, _ in target.edges)
    all_pad = (PAD,) * target.nodes
    parents: dict[State, State | None] = {}
    queue: deque[State | None] = deque([None])
    while queue:
        current = queue.popleft()
        if current is None:
            previous, paths = None, initial_paths
        else:
            previous, paths = current
            # An all-pad column has already flushed the one-column lag.
            # No further input can alter any source path state.
            if previous == all_pad:
                continue
        for nxt in _successors(source, target, assignment, previous, paths, adjacency):
            if nxt in parents:
                continue
            if remaining_states is not None and len(parents) >= remaining_states:
                raise SearchLimit("explicit BFS exceeded --max-states; no unsat claim is made")
            parents[nxt] = current
            if nxt[0] == all_pad and nxt[1] == final_paths:
                return _reconstruct(source, target, assignment, nxt, parents), len(parents)
            queue.append(nxt)
    return None, len(parents)


def solve_instance(raw: dict[str, Any], max_states: int | None = 1_000_000) -> dict[str, Any]:
    """Return an exact yes/no answer, and a minimum-depth witness if yes.

    The source assignment is enumerated, respecting optional anchors.  Each
    assignment uses BFS, and the best depth among assignments is returned.
    A depth-zero solution is globally minimal, so enumeration may stop there.
    The resource limit counts visited ordinary states across assignments.
    """
    source, target, anchors = parse_instance(raw)
    instance = normalized_instance(source, target, anchors)
    base = {"schema": "transitive-composition-certificate-v1",
            "input_sha256": sha256(canonical(instance).encode()).hexdigest()}
    if source.nodes == 0 and target.nodes:
        return {**base, "result": "unsat", "reason": "nonempty target cannot map to empty source",
                "search": {"assignments_tested": 0, "ordinary_states_visited": 0}}
    adjacency_lists: dict[tuple[int, int], list[int]] = {}
    for a, b, i in source.edges:
        adjacency_lists.setdefault((a, i), []).append(b)
    adjacency = {key: tuple(values) for key, values in adjacency_lists.items()}
    choices = [((anchors[q],) if q in anchors else range(source.nodes)) for q in range(target.nodes)]
    total_states = 0
    tested = 0
    best = None
    K = state_bound(source, target)
    for assignment in product(*choices):
        tested += 1
        budget = None if max_states is None else max_states - total_states
        result, count = _solve_assignment(source, target, tuple(assignment), adjacency, budget)
        total_states += count
        if result is not None and (best is None or result["max_word_depth"] < best["max_word_depth"]):
            best = result
            if best["max_word_depth"] == 0:
                break
    stats = {"assignments_tested": tested, "ordinary_states_visited": total_states,
             "ordinary_states_per_assignment_bound": K,
             "universal_max_word_depth_bound": max(0, K - 1),
             "final_flush_column_required": True}
    if best is None:
        return {**base, "result": "unsat", "search": stats}
    return {**base, "result": "sat", **best, "minimum_depth_certified": True, "search": stats}


def brute_force(raw: dict[str, Any], depth: int) -> dict[str, Any] | None:
    """Independent bounded search using raw word equations, not convolution.

    Source reachability is evaluated by sets of vertices after reading the
    exact suffix p.  No synchronous automaton or path-state helper is called.
    """
    source, target, anchors = parse_instance(raw)
    words = [w for length in range(depth + 1)
             for w in product(range(source.alphabet_size), repeat=length)]
    choices = [((anchors[q],) if q in anchors else range(source.nodes)) for q in range(target.nodes)]
    reach_cache: dict[tuple[int, tuple[int, ...]], frozenset[int]] = {}
    for assignment in product(*choices):
        for selected in product(words, repeat=target.nodes):
            for a, b, i in target.edges:
                rhs = (i,) + selected[b]
                if rhs[:len(selected[a])] != selected[a]:
                    break
                p = rhs[len(selected[a]):]
                key = (assignment[a], p)
                if key not in reach_cache:
                    possible = {assignment[a]}
                    for label in p:
                        possible = {v for u, v, j in source.edges if u in possible and j == label}
                    reach_cache[key] = frozenset(possible)
                if assignment[b] not in reach_cache[key]:
                    break
            else:
                return {"source_assignment": assignment, "words": selected}
    return None


def _instance(N: int, n: int, m: int, gedges, hedges, anchors=None):
    result = {"alphabet_size": m,
              "source": {"nodes": N, "edges": [list(e) for e in gedges]},
              "target": {"nodes": n, "edges": [list(e) for e in hedges]}}
    if anchors is not None:
        result["anchors"] = anchors
    return result


def _graphs(n: int, m: int):
    all_edges = list(product(range(n), range(n), range(m)))
    for mask in range(1 << len(all_edges)):
        yield [e for j, e in enumerate(all_edges) if mask & (1 << j)]


def self_test() -> dict[str, Any]:
    """Exhaustive tiny-graph and reproducible randomized independent checks."""
    from verify_certificate import verify_certificate

    records = []
    total = sat = unsat = 0
    largest_depth = 0
    aggregate_hash = sha256()

    def check(raw, depth=2):
        nonlocal total, sat, unsat, largest_depth
        cert = solve_instance(raw, max_states=500_000)
        total += 1
        if cert["result"] == "sat":
            verify_certificate(raw, cert)
            sat += 1
            largest_depth = max(largest_depth, cert["max_word_depth"])
            assert cert["max_word_depth"] <= cert["search"]["universal_max_word_depth_bound"]
        else:
            unsat += 1
        brute = brute_force(raw, depth)
        expected = cert["result"] == "sat" and cert["max_word_depth"] <= depth
        if (brute is not None) != expected:
            raise AssertionError({"instance": raw, "certificate": cert,
                                  "brute_depth": depth, "brute_result": brute})
        # A solution with reported minimum d must be absent at d-1.
        if cert["result"] == "sat" and 0 < cert["max_word_depth"] <= depth:
            assert brute_force(raw, cert["max_word_depth"] - 1) is None
        aggregate_hash.update(canonical({"instance": raw, "certificate": cert}).encode())
        aggregate_hash.update(b"\n")
        return cert

    families = [(1, 1, 2), (1, 2, 2), (2, 1, 2), (2, 2, 1)]
    for N, n, m in families:
        before = total
        for gedges in _graphs(N, m):
            for hedges in _graphs(n, m):
                check(_instance(N, n, m, gedges, hedges), depth=2)
        records.append({"kind": "exhaustive_graph_pairs", "source_nodes": N,
                        "target_nodes": n, "alphabet_size": m,
                        "instances": total - before, "raw_brute_force_depth": 2})

    curated = [
        ("empty_both", _instance(0, 0, 1, [], []), "sat", 0),
        ("empty_source_nonempty_target", _instance(0, 1, 2, [], []), "unsat", None),
        ("isolated_target", _instance(2, 3, 2, [], []), "sat", 0),
        ("empty_source_paths_chain", _instance(1, 3, 2, [], [(0, 1, 0), (1, 2, 1)]), "sat", 2),
        ("inconsistent_parallel_labels", _instance(1, 2, 2, [], [(0, 1, 0), (0, 1, 1)]), "unsat", None),
        ("anchored_source_path_three", _instance(4, 2, 2, [(0, 1, 0), (1, 2, 1), (2, 3, 0)],
                                                  [(0, 1, 0)], {"0": 0, "1": 3}), "sat", 2),
        ("anchored_source_path_wrong_first", _instance(4, 2, 2, [(0, 1, 1), (1, 2, 1), (2, 3, 0)],
                                                        [(0, 1, 0)], {"0": 0, "1": 3}), "sat", 3),
        ("unary_anchored_path", _instance(4, 2, 1, [(0, 1, 0), (1, 2, 0), (2, 3, 0)],
                                           [(0, 1, 0)], {"0": 0, "1": 3}), "sat", 2),
    ]
    for name, raw, status, minimum in curated:
        cert = check(raw, depth=3)
        assert cert["result"] == status, name
        if minimum is not None:
            assert cert["max_word_depth"] == minimum, (name, cert)
        records.append({"kind": "curated_boundary", "name": name,
                        "result": status, "minimum_depth": minimum})

    rng = random.Random(20261125)
    before = total
    for index in range(120):
        N, n, m = rng.choice([(2, 2, 2), (2, 3, 2), (3, 2, 2), (3, 3, 1)])
        gedges = [e for e in product(range(N), range(N), range(m)) if rng.random() < 0.38]
        hedges = [e for e in product(range(n), range(n), range(m)) if rng.random() < 0.30]
        anchors = {str(q): rng.randrange(N) for q in range(n) if rng.random() < 0.35}
        check(_instance(N, n, m, gedges, hedges, anchors), depth=2)
    records.append({"kind": "seeded_random_graph_pairs", "seed": 20261125,
                    "instances": total - before, "raw_brute_force_depth": 2})

    # Check that a resource cap never becomes a negative mathematical result.
    resource_case = _instance(1, 2, 2, [], [(0, 1, 0)])
    try:
        solve_instance(resource_case, max_states=0)
    except SearchLimit:
        pass
    else:
        raise AssertionError("resource limit did not raise SearchLimit")

    # Check raw verifier rejection of altered, well-shaped witness data.
    original = solve_instance(_instance(1, 3, 2, [], [(0, 1, 0), (1, 2, 1)]))
    bad = json.loads(json.dumps(original))
    bad["words"][0][0] = 1
    try:
        verify_certificate(_instance(1, 3, 2, [], [(0, 1, 0), (1, 2, 1)]), bad)
    except (AssertionError, ValueError):
        pass
    else:
        raise AssertionError("raw checker accepted an altered word equation")

    return {"status": "passed", "method": "explicit automaton BFS versus independent bounded raw-equation search",
            "finite_testing_is_not_a_general_proof": True,
            "graph_instances": total, "sat": sat, "unsat": unsat,
            "largest_minimum_depth_seen": largest_depth,
            "records_sha256": aggregate_hash.hexdigest(), "families": records,
            "resource_limit_check": "passed", "altered_certificate_rejected": True}


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("instance", nargs="?", type=Path)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--max-states", type=int, default=1_000_000)
    parser.add_argument("--self-test", action="store_true")
    args = parser.parse_args()
    if args.self_test:
        result = self_test()
    elif args.instance is not None:
        try:
            result = solve_instance(json.loads(args.instance.read_text()), args.max_states)
        except SearchLimit as exc:
            result = {"result": "unknown_resource_limit", "reason": str(exc)}
    else:
        parser.error("provide an instance or --self-test")
    rendered = json.dumps(result, indent=2, sort_keys=True) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered)
    print(rendered, end="")


if __name__ == "__main__":
    main()
