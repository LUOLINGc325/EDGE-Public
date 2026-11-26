#!/usr/bin/env python3
"""Polynomial forced-prefix candidates for promised strong-PC targets.

The candidate construction is polynomial. Deciding the target's path-
completeness promise is a separate task: by default this small prototype
checks it exactly by subset reachability, which can be exponential. Use
--assume-path-complete only when that promise is supplied independently.
The subsequent list-CSP search is exact but can take exponential time.

Input and positive output use certificate_solver.py's JSON schema. Every
positive output is checked by verify_certificate.py's raw-equation checker.
"""
from __future__ import annotations

import argparse
from collections import deque
from functools import lru_cache
from hashlib import sha256
from itertools import product
import json
from pathlib import Path

from certificate_solver import Graph, canonical, normalized_instance, parse_instance
from verify_certificate import verify_certificate

Candidate = tuple[int, tuple[int, ...]]


class PromiseError(ValueError):
    """The graph does not satisfy a declared prerequisite."""


class ResourceLimit(RuntimeError):
    """A practical allowance was exhausted; no negative decision follows."""


def strongly_connected(graph: Graph) -> bool:
    if graph.nodes == 0:
        return False
    def reached(reverse=False):
        adjacent = [set() for _ in range(graph.nodes)]
        for a, b, _ in graph.edges:
            adjacent[b if reverse else a].add(a if reverse else b)
        seen = {0}
        stack = [0]
        while stack:
            for b in adjacent[stack.pop()]:
                if b not in seen:
                    seen.add(b)
                    stack.append(b)
        return len(seen) == graph.nodes
    return reached() and reached(True)


def path_complete(graph: Graph, max_subsets=100_000) -> dict:
    """Exact all-start/all-final NFA universality; separate from construction."""
    initial = frozenset(range(graph.nodes))
    if not initial:
        return {"path_complete": False, "missing_word": [], "subsets": 1}
    table = {}
    for a, b, i in graph.edges:
        table.setdefault((a, i), set()).add(b)
    parent = {initial: None}
    queue = deque([initial])
    while queue:
        states = queue.popleft()
        for i in range(graph.alphabet_size):
            nxt = frozenset(b for a in states for b in table.get((a, i), ()))
            if not nxt:
                word = [i]
                current = states
                while parent[current] is not None:
                    current, previous_letter = parent[current]
                    word.append(previous_letter)
                word.reverse()
                return {"path_complete": False, "missing_word": word,
                        "subsets": len(parent)}
            if nxt not in parent:
                if max_subsets is not None and len(parent) >= max_subsets:
                    raise ResourceLimit("path-completeness validation exceeded the subset budget")
                parent[nxt] = (states, i)
                queue.append(nxt)
    return {"path_complete": True, "subsets": len(parent)}


def check_promise(target: Graph, assume_path_complete=False) -> dict:
    if target.alphabet_size < 2:
        raise PromiseError("the forced-prefix bound requires at least two labels")
    if not strongly_connected(target):
        raise PromiseError("the target must be nonempty and strongly connected")
    if assume_path_complete:
        return {"strong_connectivity": "checked", "path_completeness": "assumed",
                "decision_scope": "conditional on the supplied path-completeness promise"}
    report = path_complete(target)
    if not report["path_complete"]:
        raise PromiseError("target is not path complete; missing word " + str(report["missing_word"]))
    return {"strong_connectivity": "checked", "path_completeness": "checked",
            "path_complete_subsets": report["subsets"],
            "decision_scope": "the required target promise was checked exactly"}


def forced_prefixes(target: Graph) -> dict:
    """Construct h_q and P_H; requires the strong-PC promise and m>=2.

    No path-completeness test is performed here. This function itself consists
    of at most n*B edge scans and has polynomial output size.
    """
    n, m = target.nodes, target.alphabet_size
    if n < 1 or m < 2:
        raise PromiseError("forced prefixes require n>=1 and m>=2")
    logarithm = 0
    power = 1
    while power * m <= n:
        power *= m
        logarithm += 1
    B = n - 1 + logarithm
    words = []
    for q in range(n):
        frontier = {q}
        word = []
        for _ in range(B):
            outgoing = [(b, i) for a, b, i in target.edges if a in frontier]
            labels = {i for _, i in outgoing}
            if not labels:
                raise PromiseError("empty outgoing frontier contradicts the required target promise")
            if len(labels) > 1:
                break
            word.append(next(iter(labels)))
            frontier = {b for b, _ in outgoing}
        words.append(tuple(word))
    prefixes = {word[:length] for word in words for length in range(len(word) + 1)}
    assert len(prefixes) <= n * (B + 1)
    return {"bound": B, "floor_log": logarithm, "forced_words": tuple(words),
            "prefix_union": tuple(sorted(prefixes, key=lambda w: (len(w), w)))}


def path_oracle(source: Graph):
    """Exact residual-word reachability, independently of synchronous states."""
    table = {}
    for a, b, i in source.edges:
        table.setdefault((a, i), []).append(b)

    @lru_cache(maxsize=None)
    def paths(start: int, word: tuple[int, ...]):
        current = {start: (start,)}
        for i in word:
            following = {}
            for a, path in current.items():
                for b in table.get((a, i), ()):
                    following.setdefault(b, path + (b,))
            current = following
        return current

    def edge(left: Candidate, right: Candidate, i: int):
        s, u = left
        t, v = right
        rhs = (i,) + v
        if rhs[:len(u)] != u:
            return None
        return paths(s, rhs[len(u):]).get(t)
    return edge


def finite_witness_graph(raw: dict, assume_path_complete=False) -> dict:
    """Explicitly construct the polynomial graph T(G)[S x P_H]."""
    source, target, _ = parse_instance(raw)
    promise = check_promise(target, assume_path_complete)
    prefix = forced_prefixes(target)
    vertices = tuple((s, word) for s in range(source.nodes) for word in prefix["prefix_union"])
    edge = path_oracle(source)
    edges = [[a, b, i] for a, left in enumerate(vertices)
             for b, right in enumerate(vertices)
             for i in range(source.alphabet_size) if edge(left, right, i) is not None]
    return {"alphabet_size": source.alphabet_size, "nodes": len(vertices),
            "edges": edges,
            "terms": [{"source_vertex": s, "word": list(word)} for s, word in vertices],
            "target_word_bound": prefix["bound"], "promise": promise,
            "scope": "target-dependent induced finite graph; source anchors remain target constraints"}


def solve_instance(raw: dict, assume_path_complete=False, max_search_nodes=1_000_000) -> dict:
    source, target, anchors = parse_instance(raw)
    promise = check_promise(target, assume_path_complete)
    prefix = forced_prefixes(target)
    normalized = normalized_instance(source, target, anchors)
    base = {"schema": "transitive-composition-certificate-v1",
            "input_sha256": sha256(canonical(normalized).encode()).hexdigest(),
            "method": "forced-prefix list CSP", "promise": promise,
            "target_word_bound": prefix["bound"],
            "forced_prefixes": [list(w) for w in prefix["forced_words"]],
            "prefix_union_size": len(prefix["prefix_union"]),
            "finite_witness_graph_vertices": source.nodes * len(prefix["prefix_union"])}
    edge = path_oracle(source)
    domains = []
    for q, word in enumerate(prefix["forced_words"]):
        states = (anchors[q],) if q in anchors else range(source.nodes)
        domains.append({(s, word[:length]) for s in states for length in range(len(word) + 1)})

    # Self-loops are unary constraints: both endpoints use the same candidate.
    for a, b, i in target.edges:
        if a == b:
            domains[a] = {candidate for candidate in domains[a]
                          if edge(candidate, candidate, i) is not None}

    relations = []
    for a, b, i in target.edges:
        if a == b:
            continue
        forward = {left: {right for right in domains[b] if edge(left, right, i) is not None}
                   for left in domains[a]}
        reverse = {right: {left for left in domains[a] if right in forward[left]}
                   for right in domains[b]}
        relations.append((a, b, forward, reverse))

    search_nodes = 0

    def propagate(current):
        changed = True
        while changed:
            if any(not domain for domain in current):
                return None
            changed = False
            for a, b, forward, reverse in relations:
                left = {v for v in current[a] if forward[v] & current[b]}
                right = {w for w in current[b] if reverse[w] & left}
                if not left or not right:
                    return None
                if left != current[a] or right != current[b]:
                    current[a], current[b] = left, right
                    changed = True
        return current

    def search(current):
        nonlocal search_nodes
        if max_search_nodes is not None and search_nodes >= max_search_nodes:
            raise ResourceLimit("list-CSP search exceeded its node budget")
        search_nodes += 1
        current = propagate(current)
        if current is None:
            return None
        unresolved = [q for q, domain in enumerate(current) if len(domain) > 1]
        if not unresolved:
            return tuple(next(iter(domain)) for domain in current)
        q = min(unresolved, key=lambda q: (len(current[q]), q))
        for value in sorted(current[q], key=lambda v: (len(v[1]), v[1], v[0])):
            child = [set(domain) for domain in current]
            child[q] = {value}
            answer = search(child)
            if answer is not None:
                return answer
        return None

    # Searching increasing depths also independently minimizes the witness.
    for depth in range(prefix["bound"] + 1):
        restricted = [{candidate for candidate in domain if len(candidate[1]) <= depth}
                      for domain in domains]
        answer = search(restricted)
        if answer is None:
            continue
        paths = []
        for a, b, i in target.edges:
            s, u = answer[a]
            t, v = answer[b]
            p = ((i,) + v)[len(u):]
            vertices = edge(answer[a], answer[b], i)
            assert vertices is not None
            paths.append({"target_edge": [a, b, i], "word": list(p), "vertices": list(vertices)})
        certificate = {**base, "result": "sat", "source_assignment": [s for s, _ in answer],
                       "words": [list(w) for _, w in answer], "source_paths": paths,
                       "max_word_depth": max(len(w) for _, w in answer),
                       "convolution_columns_including_flush": depth + 1,
                       "minimum_depth_certified": True,
                       "search_nodes": search_nodes}
        verify_certificate(raw, certificate)
        return certificate
    return {**base, "result": "unsat", "search_nodes": search_nodes}


def _raw(N, n, gedges, hedges, anchors=None):
    result = {"alphabet_size": 2, "source": {"nodes": N, "edges": list(gedges)},
              "target": {"nodes": n, "edges": list(hedges)}}
    if anchors is not None:
        result["anchors"] = anchors
    return result


def _graphs(n):
    possible = tuple(product(range(n), range(n), range(2)))
    for mask in range(1 << len(possible)):
        yield [edge for j, edge in enumerate(possible) if mask & (1 << j)]


def reset_chain_instance(length=1):
    """Strong-PC target needing nonempty words; an explicit length-k witness."""
    assert length >= 1
    source_edges = [(a, i, i) for a in range(2) for i in range(2)]
    target_edges = list(source_edges)
    for i in range(2):
        target_edges.append((0, length + 1, i))
    for j in range(1, length + 1):
        target_edges.append((j + 1, 0 if j == 1 else j, 0))
    return _raw(2, length + 2, source_edges, target_edges)


def self_test() -> dict:
    from certificate_solver import solve_instance as general_solve
    records = []
    total = sat = unsat = 0
    digest = sha256()

    def check(raw):
        nonlocal total, sat, unsat
        forced = solve_instance(raw)
        general = general_solve(raw, max_states=500_000)
        assert forced["result"] == general["result"], (raw, forced, general)
        total += 1
        if forced["result"] == "sat":
            sat += 1
            verify_certificate(raw, forced)
            verify_certificate(raw, general)
            assert forced["max_word_depth"] == general["max_word_depth"]
        else:
            unsat += 1
        digest.update(canonical({"instance": raw, "forced": forced,
                                 "general": general}).encode())
        digest.update(b"\n")
        return forced

    before = total
    one_vertex_target = [(0, 0, 0), (0, 0, 1)]
    for N in (1, 2):
        for gedges in _graphs(N):
            check(_raw(N, 1, gedges, one_vertex_target))
    records.append({"kind": "all_sources_one_vertex_complete_target", "instances": total - before})

    before = total
    target_count = 0
    for hedges in _graphs(2):
        h = Graph.make(2, 2, hedges)
        if strongly_connected(h) and path_complete(h)["path_complete"]:
            target_count += 1
            for gedges in _graphs(1):
                check(_raw(1, 2, gedges, hedges))
    records.append({"kind": "all_promised_two_vertex_targets_all_one_vertex_sources",
                    "targets": target_count, "instances": total - before})

    before = total
    selected_targets = [
        [(0, 1, 0), (1, 0, 0), (0, 0, 1), (1, 1, 1)],
        [(0, 0, 0), (0, 1, 1), (1, 0, 0), (1, 1, 1)],
        [(0, 0, 0), (0, 0, 1), (0, 1, 0), (1, 0, 1)],
        list(product(range(2), range(2), range(2))),
    ]
    for hedges in selected_targets:
        for gedges in _graphs(2):
            check(_raw(2, 2, gedges, hedges))
    records.append({"kind": "all_two_vertex_sources_four_promised_targets",
                    "instances": total - before})

    colors = [(a, b, 0) for a in range(3) for b in range(3) if a != b]
    colors += [(a, a, 1) for a in range(3)]
    for n, expected in [(3, "sat"), (4, "unsat")]:
        hedges = [(a, b, 0) for a in range(n) for b in range(n) if a != b]
        hedges += [(a, a, 1) for a in range(n)]
        result = check(_raw(3, n, colors, hedges))
        assert result["result"] == expected
        assert result["forced_prefixes"] == [[] for _ in range(n)]
        records.append({"kind": "fixed_binary_coloring", "target_clique": n,
                        "result": expected, "minimum_depth": result.get("max_word_depth")})

    for length in (1, 3):
        raw = reset_chain_instance(length)
        result = check(raw)
        assert result["result"] == "sat" and result["max_word_depth"] == 1
        assert result["forced_prefixes"][2:] == [[0] * j for j in range(1, length + 1)]
        # Validate a deliberately non-minimal length-k certificate as well.
        source, target, anchors = parse_instance(raw)
        answer = [(0, ()), (1, ())] + [(0, (0,) * j) for j in range(1, length + 1)]
        oracle = path_oracle(source)
        paths = []
        for a, b, i in target.edges:
            u, v = answer[a][1], answer[b][1]
            paths.append({"target_edge": [a, b, i], "word": list(((i,) + v)[len(u):]),
                          "vertices": list(oracle(answer[a], answer[b], i))})
        witness = {"result": "sat", "source_assignment": [s for s, _ in answer],
                   "words": [list(w) for _, w in answer], "source_paths": paths,
                   "max_word_depth": length,
                   "input_sha256": sha256(canonical(normalized_instance(source, target, anchors)).encode()).hexdigest()}
        verify_certificate(raw, witness)
        finite = finite_witness_graph(raw)
        assert finite["nodes"] == 2 * (length + 1)
        records.append({"kind": "nonempty_word_reset_chain", "chain_length": length,
                        "minimum_depth": 1, "explicit_checked_witness_depth": length,
                        "finite_graph_vertices": finite["nodes"], "finite_graph_edges": len(finite["edges"])})

    raw = reset_chain_instance(1)
    raw["anchors"] = {"2": 1}
    assert check(raw)["result"] == "unsat"
    records.append({"kind": "incompatible_anchor", "result": "unsat"})

    # Avoid silently using a structural cutoff when the promise is false.
    bad = _raw(1, 2, [(0, 0, 0), (0, 0, 1)], [(0, 1, 0), (1, 0, 1)])
    try:
        solve_instance(bad)
    except PromiseError:
        pass
    else:
        raise AssertionError("non-path-complete target was not rejected")
    return {"status": "passed", "method": "forced-prefix CSP versus general synchronous BFS",
            "graph_instances": total, "sat": sat, "unsat": unsat,
            "records_sha256": digest.hexdigest(), "families": records,
            "false_promise_rejected": True, "finite_testing_is_not_a_general_proof": True}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("instance", nargs="?", type=Path)
    parser.add_argument("--output", type=Path)
    parser.add_argument("--finite-graph", type=Path)
    parser.add_argument("--assume-path-complete", action="store_true")
    parser.add_argument("--max-search-nodes", type=int, default=1_000_000)
    parser.add_argument("--self-test", action="store_true")
    args = parser.parse_args()
    try:
        if args.self_test:
            result = self_test()
        elif args.instance:
            raw = json.loads(args.instance.read_text())
            result = solve_instance(raw, args.assume_path_complete, args.max_search_nodes)
            if args.finite_graph:
                graph = finite_witness_graph(raw, args.assume_path_complete)
                args.finite_graph.parent.mkdir(parents=True, exist_ok=True)
                args.finite_graph.write_text(json.dumps(graph, indent=2, sort_keys=True) + "\n")
        else:
            parser.error("provide an instance or --self-test")
    except PromiseError as exc:
        result = {"result": "promise_unsatisfied", "reason": str(exc)}
    except ResourceLimit as exc:
        result = {"result": "unknown_resource_limit", "reason": str(exc)}
    rendered = json.dumps(result, indent=2, sort_keys=True) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered)
    print(rendered, end="")


if __name__ == "__main__":
    main()
