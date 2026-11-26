#!/usr/bin/env python3
"""Independent finite verifier for paths in self-deleting undirected graphs.

This program uses only the Python standard library.  Its separating family is
an exhaustive finite family, NOT an implementation of the efficient GLP
construction.  It checks the theorem's interface and state recurrence against
an independent oracle that enumerates simple paths and actual deleted edges.
Finite checks do not establish the general theorem or its running-time bound.
"""

from __future__ import annotations

import argparse
from collections import deque
from dataclasses import dataclass
from functools import lru_cache
from hashlib import sha256
from itertools import combinations, product
import json
from pathlib import Path
import random
import sys


class VerificationFailure(RuntimeError):
    pass


def require(condition, message):
    # Deliberately independent of Python's removable assert statement.
    if not condition:
        raise VerificationFailure(message)


@dataclass(frozen=True)
class Instance:
    n: int
    edges: tuple
    deleted: tuple
    adjacency: tuple

    @property
    def m(self):
        return len(self.edges)

    @property
    def mu(self):
        return max((mask.bit_count() for mask in self.deleted), default=0)


def make_instance(n, edges, deleted):
    edges = tuple(edges)
    require(len(deleted) == n, "deletion list has incorrect size")
    require(len(edges) == len(set(edges)), "duplicate edge")
    adjacency = [[] for _ in range(n)]
    for index, (u, v) in enumerate(edges):
        require(0 <= u < v < n, "edge is not a canonical simple edge")
        adjacency[u].append((v, index))
        adjacency[v].append((u, index))
    require(all(0 <= mask < (1 << len(edges)) for mask in deleted),
            "deletion mask refers outside the edge universe")
    return Instance(n, edges, tuple(deleted), tuple(tuple(a) for a in adjacency))


def conforming(instance, vertices):
    """Direct model semantics, without colors or state masks."""
    if not vertices:
        return False
    edge_index = {edge: i for i, edge in enumerate(instance.edges)}
    unavailable = instance.deleted[vertices[0]]
    for u, v in zip(vertices, vertices[1:]):
        edge = (min(u, v), max(u, v))
        index = edge_index.get(edge)
        if index is None or unavailable & (1 << index):
            return False
        # Arrival takes place before the arriving vertex's deletion action.
        unavailable |= instance.deleted[v]
    return True


def simple_path_oracle(instance, source, target, max_vertices):
    """Enumerate simple paths; preserve the actual deleted-edge union."""
    if max_vertices < 1:
        return None
    stack = [(source, 1 << source, instance.deleted[source], (source,))]
    while stack:
        vertex, used, unavailable, path = stack.pop()
        if vertex == target:
            return path
        if len(path) == max_vertices:
            continue
        for nxt, edge in instance.adjacency[vertex]:
            if used & (1 << nxt) or unavailable & (1 << edge):
                continue
            stack.append((nxt, used | (1 << nxt),
                          unavailable | instance.deleted[nxt], path + (nxt,)))
    return None


def color_state_bfs(instance, source, target, max_vertices, colors, p):
    """State is (vertex, remaining colors AFTER this vertex's deletions)."""
    if max_vertices < 1:
        return None
    if source == target:
        return (source,)
    if max_vertices == 1:
        return None
    forbidden_colors = []
    for deleted in instance.deleted:
        mask = 0
        for edge, color in enumerate(colors):
            if deleted & (1 << edge) and color < p:
                mask |= 1 << color
        forbidden_colors.append(mask)
    first = (source, ((1 << p) - 1) & ~forbidden_colors[source])
    queue = deque([(first, 0)])
    parent = {first: None}
    while queue:
        (vertex, remaining), depth = queue.popleft()
        if depth == max_vertices - 1:
            continue
        for nxt, edge in instance.adjacency[vertex]:
            color = colors[edge]
            if color >= p or not (remaining & (1 << color)):
                continue
            state = (nxt, remaining & ~forbidden_colors[nxt])
            if state in parent:
                continue
            parent[state] = (vertex, remaining)
            if nxt == target:
                result = []
                cursor = state
                while cursor is not None:
                    result.append(cursor[0])
                    cursor = parent[cursor]
                return tuple(reversed(result))
            queue.append((state, depth + 1))
    return None


@lru_cache(maxsize=None)
def exhaustive_restricted_family(m, p):
    """One canonical injective map per p-subset of m+p labels.

    Real edges are labels 0,...,m-1; the final p labels are dummy labels.
    Color p is forbidden.  Duplicate restrictions to real edges are removed.
    This family is exhaustive in the universe size, hence is not GLP-fast.
    """
    restrictions = set()
    for selected in combinations(range(m + p), p):
        colors = [p] * m
        for color, label in enumerate(selected):
            if label < m:
                colors[label] = color
        restrictions.add(tuple(colors))
    return tuple(sorted(restrictions))


def erase_repeated_vertices(walk):
    kept = []
    positions = {}
    for vertex in walk:
        if vertex in positions:
            cut = positions[vertex]
            for removed in kept[cut + 1:]:
                del positions[removed]
            del kept[cut + 1:]
        else:
            positions[vertex] = len(kept)
            kept.append(vertex)
    return tuple(kept)


def finite_family_solver(instance, source, target, max_vertices, counts):
    max_vertices = min(max_vertices, instance.n)
    if max_vertices < 1:
        return None
    if source == target:
        return (source,)
    if max_vertices == 1 or instance.m == 0:
        return None
    p = max_vertices - 1
    for colors in exhaustive_restricted_family(instance.m, p):
        counts["color_state_bfs_calls"] += 1
        walk = color_state_bfs(instance, source, target, max_vertices, colors, p)
        if walk is None:
            continue
        require(conforming(instance, walk), "state BFS produced an invalid walk")
        path = erase_repeated_vertices(walk)
        require(conforming(instance, path), "walk erasure broke conformity")
        require(len(set(path)) == len(path), "walk erasure did not give a path")
        require(path[0] == source and path[-1] == target, "wrong witness endpoints")
        require(len(path) <= max_vertices, "witness exceeds vertex budget")
        counts["accepted_witness_checks"] += 1
        return path
    return None


def witness_separation_check(instance, path, max_vertices, counts):
    """Check the tighter p*mu budget with terminal vertex excluded."""
    if len(path) == 1 or max_vertices <= 1:
        return
    max_vertices = min(max_vertices, instance.n)
    p = max_vertices - 1
    universe_size = instance.m + p
    K = min(universe_size, p * (instance.mu + 1))
    index = {edge: i for i, edge in enumerate(instance.edges)}
    path_edges = {
        index[(min(u, v), max(u, v))] for u, v in zip(path, path[1:])
    }
    bad = set()
    for vertex in path[:-1]:  # t has no outgoing traversal in the witness.
        bad.update(i for i in range(instance.m)
                   if instance.deleted[vertex] & (1 << i))
    bad.difference_update(path_edges)
    padding = set(range(instance.m, instance.m + p - len(path_edges)))
    chosen = path_edges | padding
    require(len(chosen) == p, "padding did not produce p labels")
    require(not (chosen & bad), "good and bad label sets overlap")
    require(len(bad) <= K - p, "tighter bad-set budget failed")
    full_colors = [p] * universe_size
    for color, label in enumerate(sorted(chosen)):
        full_colors[label] = color
    require({full_colors[i] for i in chosen} == set(range(p)),
            "chosen labels do not have all allowed colors")
    require(all(full_colors[i] == p for i in bad), "bad label not forbidden")
    colors = tuple(full_colors[:instance.m])
    require(colors in exhaustive_restricted_family(instance.m, p),
            "witness coloring absent from finite family")
    require(color_state_bfs(instance, path[0], path[-1], max_vertices, colors, p)
            is not None, "separated witness did not survive state BFS")
    counts["witness_separation_checks"] += 1
    if padding:
        counts["dummy_padded_witness_checks"] += 1


def compare(instance, source, target, max_vertices, counts, category):
    expected = simple_path_oracle(instance, source, target, max_vertices)
    actual = finite_family_solver(instance, source, target, max_vertices, counts)
    require((expected is None) == (actual is None),
            f"decision mismatch: {instance}, s={source}, t={target}, k={max_vertices}")
    counts[category] += 1
    counts["decision_comparisons"] += 1
    if expected is not None:
        witness_separation_check(instance, expected, max_vertices, counts)


def all_graphs(n):
    possible = tuple(combinations(range(n), 2))
    for mask in range(1 << len(possible)):
        yield tuple(edge for i, edge in enumerate(possible) if mask & (1 << i))


def minimum_cover_size(n, edges):
    for size in range(n + 1):
        for chosen in combinations(range(n), size):
            chosen = set(chosen)
            if all(u in chosen or v in chosen for u, v in edges):
                return size
    raise VerificationFailure("vertex-cover enumeration failed")


def longest_simple_path_size(n, edges):
    graph = [[] for _ in range(n)]
    for u, v in edges:
        graph[u].append(v)
        graph[v].append(u)
    best = 0
    for source in range(n):
        stack = [(source, 1 << source)]
        while stack:
            vertex, used = stack.pop()
            best = max(best, used.bit_count())
            for nxt in graph[vertex]:
                if not (used & (1 << nxt)):
                    stack.append((nxt, used | (1 << nxt)))
    return best


def targeted_checks(counts):
    cases = []

    # The source acts before the very first edge traversal.
    graph = make_instance(2, ((0, 1),), (1, 0))
    compare(graph, 0, 1, 2, counts, "targeted_decisions")
    require(simple_path_oracle(graph, 0, 1, 2) is None, "source deletion semantics")
    cases.append("source_deletes_first_edge")

    # The target can delete the edge just used to enter it.
    graph = make_instance(2, ((0, 1),), (0, 1))
    compare(graph, 0, 1, 2, counts, "targeted_decisions")
    require(color_state_bfs(graph, 0, 1, 2, (0,), 1) == (0, 1),
            "terminal incoming-edge deletion incorrectly rejected")
    cases.append("target_deletes_entering_edge")

    # A later vertex may delete a past edge.  Color aliasing can wrongly block
    # the next edge, so injection on witness edges is a real proof obligation.
    graph = make_instance(4, ((0, 1), (1, 2), (2, 3)), (0, 1, 0, 0))
    compare(graph, 0, 3, 4, counts, "targeted_decisions")
    require(color_state_bfs(graph, 0, 3, 4, (0, 0, 0), 3) is None,
            "expected color-conflict obstruction absent")
    require(color_state_bfs(graph, 0, 3, 4, (0, 1, 2), 3) == (0, 1, 2, 3),
            "distinct colors failed to preserve deletion of a past edge")
    cases.extend(("later_deletes_past_edge", "past_future_color_conflict"))

    # An off-path deletion can have the same color as a legal first edge.
    graph = make_instance(4, ((0, 1), (1, 2), (1, 3)), (4, 0, 0, 0))
    compare(graph, 0, 2, 3, counts, "targeted_decisions")
    require(color_state_bfs(graph, 0, 2, 3, (0, 1, 0), 2) is None,
            "off-path color-conflict test failed")
    require(color_state_bfs(graph, 0, 2, 3, (0, 1, 2), 2) == (0, 1, 2),
            "forbidden off-path color failed to preserve the witness")
    cases.append("off_path_color_conflict")

    # A one-edge witness must survive a much larger vertex budget via dummies.
    graph = make_instance(5, ((0, 4),), (0, 0, 0, 0, 1))
    compare(graph, 0, 4, 5, counts, "targeted_decisions")
    witness_separation_check(graph, (0, 4), 5, counts)
    cases.append("short_witness_dummy_padding")

    # Independent explicit closed-subwalk erasure, including legal past-edge
    # deletion; this does not depend on shortest BFS witnesses having repeats.
    graph = make_instance(4, ((0, 1), (1, 2), (1, 3)), (0, 1, 1, 0))
    walk = (0, 1, 2, 1, 3)
    require(conforming(graph, walk), "explicit repeated walk is not conforming")
    erased = erase_repeated_vertices(walk)
    require(erased == (0, 1, 3) and conforming(graph, erased),
            "explicit closed-subwalk erasure failed")
    counts["explicit_walk_erasure_checks"] += 1
    cases.append("repeated_walk_erasure")

    # For a star, the full-graph vertex-cover bound is nontrivial: n=7, tau=1.
    edges = tuple((0, v) for v in range(1, 7))
    graph = make_instance(7, edges, (0, 0, 0, 0, 0, 0, 0))
    compare(graph, 1, 6, 3, counts, "targeted_decisions")
    require(minimum_cover_size(7, edges) == 1, "star cover check failed")
    require(longest_simple_path_size(7, edges) == 3, "star length bound failed")
    cases.append("full_graph_vertex_cover_bound_star")
    return cases


def exhaustive_walk_erasure_checks(counts):
    # Complete three-vertex graph; every possible deletion function; all
    # conforming walks with at most six vertices, from each possible start.
    edges = ((0, 1), (0, 2), (1, 2))
    for deleted in product(range(8), repeat=3):
        instance = make_instance(3, edges, deleted)
        for source in range(3):
            stack = [(source, instance.deleted[source], (source,))]
            while stack:
                vertex, unavailable, walk = stack.pop()
                erased = erase_repeated_vertices(walk)
                require(conforming(instance, erased), "erasure broke a conforming walk")
                require(len(set(erased)) == len(erased), "erased walk not simple")
                require(erased[0] == walk[0] and erased[-1] == walk[-1],
                        "erasure changed endpoints")
                require(len(erased) <= len(walk), "erasure increased length")
                counts["exhaustive_walk_erasure_checks"] += 1
                if len(walk) == 6:
                    continue
                for nxt, edge in instance.adjacency[vertex]:
                    if not (unavailable & (1 << edge)):
                        stack.append((nxt, unavailable | instance.deleted[nxt],
                                      walk + (nxt,)))


def run():
    count_names = (
        "decision_comparisons", "color_state_bfs_calls", "accepted_witness_checks",
        "witness_separation_checks", "dummy_padded_witness_checks",
        "exhaustive_n_le_3_decisions", "exhaustive_n_4_mu_le_1_decisions",
        "seeded_decisions", "targeted_decisions", "exhaustive_deletion_instances",
        "vertex_cover_graph_checks", "vertex_cover_deletion_decision_checks",
        "explicit_walk_erasure_checks", "exhaustive_walk_erasure_checks",
    )
    counts = dict.fromkeys(count_names, 0)
    targets = targeted_checks(counts)

    # All labeled simple graphs on n<=3, every deletion set at every vertex,
    # every ordered endpoint pair, and k from 1 through n+1.
    for n in range(1, 4):
        for edges in all_graphs(n):
            for deleted in product(range(1 << len(edges)), repeat=n):
                instance = make_instance(n, edges, deleted)
                counts["exhaustive_deletion_instances"] += 1
                for source, target in product(range(n), repeat=2):
                    for k in range(1, n + 2):
                        compare(instance, source, target, k, counts,
                                "exhaustive_n_le_3_decisions")

    # All 64 labeled graphs on four vertices, with each vertex deleting no
    # edge or exactly one edge; fixed endpoints 0,3 and budgets 2,3,4.
    for edges in all_graphs(4):
        possible_deletions = (0,) + tuple(1 << i for i in range(len(edges)))
        tau = minimum_cover_size(4, edges)
        bound = min(4, 2 * tau + 1)
        for deleted in product(possible_deletions, repeat=4):
            instance = make_instance(4, edges, deleted)
            counts["exhaustive_deletion_instances"] += 1
            for k in (2, 3, 4):
                compare(instance, 0, 3, k, counts,
                        "exhaustive_n_4_mu_le_1_decisions")
            unrestricted = simple_path_oracle(instance, 0, 3, 4)
            bounded = simple_path_oracle(instance, 0, 3, bound)
            require((unrestricted is None) == (bounded is None),
                    "vertex-cover reduction changed self-deleting existence")
            counts["vertex_cover_deletion_decision_checks"] += 1

    # Larger seeded inputs exercise deletion sets of several edges.  Their
    # finite family may be exponentially large in the edge universe.
    seed = 2026112409
    rng = random.Random(seed)
    for _ in range(320):
        n = rng.choice((4, 5, 6))
        all_edges = tuple(combinations(range(n), 2))
        m = rng.randrange(min(8, len(all_edges)) + 1)
        edges = tuple(sorted(rng.sample(all_edges, m)))
        deleted = []
        for _vertex in range(n):
            chosen = rng.sample(range(m), rng.randrange(min(m, 3) + 1))
            deleted.append(sum(1 << edge for edge in chosen))
        instance = make_instance(n, edges, deleted)
        source, target = rng.randrange(n), rng.randrange(n)
        k = rng.randrange(1, n + 2)
        compare(instance, source, target, k, counts, "seeded_decisions")
        tau = minimum_cover_size(n, edges)
        unrestricted = simple_path_oracle(instance, source, target, n)
        bounded = simple_path_oracle(instance, source, target, min(n, 2 * tau + 1))
        require((unrestricted is None) == (bounded is None),
                "seeded vertex-cover reduction mismatch")
        counts["vertex_cover_deletion_decision_checks"] += 1

    # Exact structural check over every labeled simple graph through n=5.
    for n in range(1, 6):
        for edges in all_graphs(n):
            tau = minimum_cover_size(n, edges)
            longest = longest_simple_path_size(n, edges)
            require(longest <= 2 * tau + 1, "full-graph vertex-cover length bound")
            counts["vertex_cover_graph_checks"] += 1

    exhaustive_walk_erasure_checks(counts)
    return {
        "schema_version": 1,
        "status": "PASS",
        "script_sha256": sha256(Path(__file__).read_bytes()).hexdigest(),
        "python": ".".join(map(str, sys.version_info[:3])),
        "seed": seed,
        "counts": counts,
        "targeted_cases": targets,
        "finite_family": {
            "construction": "all p-subsets of m+p labels, canonical injection, complement forbidden",
            "duplicate_real_edge_restrictions_removed": True,
            "efficient_GLP_construction_implemented": False,
            "parameters": "p=min(k,n)-1; N=m+p; K=min(N,p*(mu+1)); bad set excludes terminal vertex",
        },
        "scope": [
            "Independent state BFS compared to enumeration of simple paths using actual edge deletions",
            "All graphs n<=3 with every deletion function, ordered endpoints, and k=1,...,n+1",
            "All graphs n=4 with mu<=1, endpoints 0 and 3, and k=2,3,4",
            "320 fixed-seed additional inputs on four to six vertices",
            "All conforming walks through six vertices on K3 under every deletion function, then cycle erasure",
            "Every labeled graph through five vertices for the full-graph vertex-cover length bound",
        ],
        "limitations": [
            "Finite exact combinatorial checks do not replace the general written proof",
            "The exhaustive family is not the efficient GLP construction and does not certify the claimed complexity",
            "No proof-assistant certification or external peer review is implied",
        ],
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path,
                        default=Path(__file__).resolve().parents[1] / "results" / "independent_certificate.json")
    args = parser.parse_args()
    certificate = run()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(certificate, indent=2, ensure_ascii=False) + "\n",
                           encoding="utf-8")
    print(json.dumps({"status": certificate["status"], "counts": certificate["counts"],
                      "output": str(args.output)}, indent=2))


if __name__ == "__main__":
    main()
