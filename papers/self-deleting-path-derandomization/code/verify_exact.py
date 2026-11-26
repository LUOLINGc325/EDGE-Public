#!/usr/bin/env python3
"""Exact finite checks for the self-deleting-path derandomization interface.

The efficient separating-family construction is a cited mathematical theorem.
The support-enumeration family below is ONLY a small-instance verifier and does
NOT implement or benchmark the asymptotic running time proved in the paper.
All comparisons use integers, sets, and exhaustive enumeration, with no floats.
"""

from __future__ import annotations

import argparse
from collections import Counter, deque
from dataclasses import dataclass
from hashlib import sha256
from itertools import combinations, product
import json
from pathlib import Path
import random


def require(condition, detail):
    if not condition:
        raise RuntimeError(detail)


@dataclass(frozen=True)
class Instance:
    n: int
    edges: tuple[tuple[int, int], ...]
    deletions: tuple[frozenset[int], ...]

    def adjacency(self):
        adj = [[] for _ in range(self.n)]
        for edge_id, (u, v) in enumerate(self.edges):
            adj[u].append((v, edge_id))
            adj[v].append((u, edge_id))
        return adj


def subsets(items):
    items = tuple(items)
    for size in range(len(items) + 1):
        yield from combinations(items, size)


def oracle_path(inst, source, target, k, colors=None):
    """Independent direct simple-path enumeration; no color-state DP."""
    if k < 1:
        return None
    adj = inst.adjacency()
    best = None

    def visit(path, banned):
        nonlocal best
        u = path[-1]
        if u == target:
            if best is None or len(path) < len(best):
                best = path
            return
        if len(path) >= k or (best is not None and len(path) >= len(best)):
            return
        if colors is None:
            banned_now = banned | inst.deletions[u]
        else:
            banned_now = banned | frozenset(colors[e] for e in inst.deletions[u])
        for v, e in adj[u]:
            label = e if colors is None else colors[e]
            if v in path or label in banned_now or (colors is not None and label == 0):
                continue
            visit(path + (v,), banned_now)

    visit((source,), frozenset())
    return best


def erase_cycles(walk):
    path = []
    position = {}
    for v in walk:
        if v in position:
            cut = position[v]
            for removed in path[cut + 1:]:
                del position[removed]
            del path[cut + 1:]
        else:
            position[v] = len(path)
            path.append(v)
    return tuple(path)


def valid_walk(inst, walk, colors=None):
    if not walk:
        return False
    edge_index = {frozenset(edge): i for i, edge in enumerate(inst.edges)}
    banned = set()
    for u, v in zip(walk, walk[1:]):
        edge = edge_index.get(frozenset((u, v)))
        if edge is None:
            return False
        if colors is None:
            banned.update(inst.deletions[u])
            if edge in banned:
                return False
        else:
            banned.update(colors[e] for e in inst.deletions[u])
            if colors[edge] == 0 or colors[edge] in banned:
                return False
    return True


def color_bfs(inst, source, target, k, colors, p):
    """BFS on (physical vertex, already forbidden active-color mask)."""
    if k < 1:
        return None
    active = (1 << p) - 1
    edge_bits = tuple(0 if color == 0 else 1 << (color - 1) for color in colors)
    ban = []
    for deleted in inst.deletions:
        mask = 0
        for edge in deleted:
            mask |= edge_bits[edge]
        ban.append(mask & active)
    start = (source, ban[source])
    queue = deque([start])
    distance = {start: 0}
    predecessor = {start: None}
    adj = inst.adjacency()
    while queue:
        state = queue.popleft()
        u, blocked = state
        if u == target:
            walk = []
            while state is not None:
                walk.append(state[0])
                state = predecessor[state]
            return erase_cycles(tuple(reversed(walk)))
        if distance[state] >= k - 1:
            continue
        for v, edge in adj[u]:
            bit = edge_bits[edge]
            if not bit or blocked & bit:
                continue
            nxt = (v, blocked | ban[v])
            if nxt not in distance:
                distance[nxt] = distance[state] + 1
                predecessor[nxt] = state
                queue.append(nxt)
    return None


def finite_support_colorings(m, p):
    """Slow complete family for verification: enumerate active supports.

    Selecting an actual support A of size a <= p corresponds to augmenting A
    with p-a dummy labels. Color A injectively and every other actual edge 0.
    The unused active colors can be placed on the dummy labels. Its size is
    sum_{a<=p} binom(m,a), not the efficient family size in the theorem.
    """
    for size in range(min(m, p) + 1):
        for support in combinations(range(m), size):
            colors = [0] * m
            for color, edge in enumerate(support, 1):
                colors[edge] = color
            yield tuple(colors)


def finite_solver(inst, source, target, k):
    if k < 1:
        return None
    if source == target:
        return (source,)
    k = min(k, inst.n)
    if k <= 1:
        return None
    best = None
    for colors in finite_support_colorings(len(inst.edges), k - 1):
        path = color_bfs(inst, source, target, k, colors, k - 1)
        if path is not None and (best is None or len(path) < len(best)):
            best = path
    return best


def check_pair(inst, source, target, k, counts, all_color_maps=False):
    expected = oracle_path(inst, source, target, k)
    actual = finite_solver(inst, source, target, k)
    require((expected is None) == (actual is None), (inst, source, target, k, expected, actual))
    if actual is not None:
        require(valid_walk(inst, actual), ('invalid reconstructed path', inst, actual))
        require(len(set(actual)) == len(actual), ('not simple', actual))
        require(len(actual) == len(expected), ('nonshortest exhaustive result', expected, actual))
        counts['positive_path_queries'] += 1
    else:
        counts['negative_path_queries'] += 1
    counts['solver_oracle_comparisons'] += 1
    if all_color_maps and k >= 2:
        p = min(k, inst.n) - 1
        for colors in product(range(p + 1), repeat=len(inst.edges)):
            direct = oracle_path(inst, source, target, k, colors)
            state = color_bfs(inst, source, target, k, colors, p)
            require((direct is None) == (state is None), ('colored mismatch', inst, colors, direct, state))
            if state is not None:
                require(valid_walk(inst, state, colors), ('invalid colored path', inst, colors, state))
                require(len(state) == len(direct), ('colored shortest mismatch', direct, state))
            counts['colored_dp_oracle_comparisons'] += 1


def exhaustive_small(counts):
    # Every labelled graph with 1..3 vertices and EVERY possible deletion map.
    # All ordered endpoints; positive k ranges through n+1 to test capping.
    for n in range(1, 4):
        possible = tuple(combinations(range(n), 2))
        for edges in subsets(possible):
            m = len(edges)
            options = tuple(frozenset(x) for x in subsets(range(m)))
            for deletions in product(options, repeat=n):
                inst = Instance(n, tuple(edges), tuple(deletions))
                counts['exhaustive_instances'] += 1
                for source in range(n):
                    for target in range(n):
                        for k in range(1, n + 2):
                            check_pair(inst, source, target, k, counts,
                                       all_color_maps=(k <= n))


def padding_checks(counts):
    # Exhaust every abstract disjoint pair for the small dummy-padded universes.
    # A comprises actual path edges and must have at least one element.
    for m in range(1, 8):
        for p in range(1, 5):
            universe_size = m + p
            for size in range(1, min(m, p) + 1):
                for chosen in combinations(range(m), size):
                    A = set(chosen)
                    for bad in subsets(set(range(m)) - A):
                        B = set(bad)
                        for mu in range(1, 5):
                            if len(B) > size * mu:
                                continue
                            K = min(universe_size, p * (mu + 1))
                            C = A | set(range(m, m + p - size))
                            require(len(C) == p and not C & B, ('padding', A, B, C))
                            require(len(B) <= K - p, ('cap bound', m, p, mu, A, B))
                            require(K <= p * (mu + 1), 'ratio bound')
                            colors = {edge: color for color, edge in enumerate(sorted(C), 1)}
                            require({colors[x] for x in C} == set(range(1, p + 1)), 'injectivity')
                            require(all(colors.get(x, 0) == 0 for x in B), 'separation')
                            counts['padding_and_parameter_checks'] += 1
                            if size < p:
                                counts['strictly_shorter_padding_checks'] += 1
                            if K == universe_size:
                                counts['universe_capped_checks'] += 1


def targeted_checks(counts):
    # Incoming edges can be deleted at arrival, and used edges can be deleted later.
    fixtures = [
        ('source_blocks_departure', Instance(2, ((0, 1),), (frozenset({0}), frozenset())), 2, False),
        ('target_deletes_arrival', Instance(2, ((0, 1),), (frozenset(), frozenset({0}))), 2, True),
        ('delete_only_past_edge', Instance(3, ((0, 1), (1, 2)),
                                         (frozenset(), frozenset({0}), frozenset({0, 1}))), 3, True),
        ('remote_future_deletion', Instance(3, ((0, 1), (1, 2)),
                                           (frozenset({1}), frozenset(), frozenset())), 3, False),
        ('length_budget', Instance(3, ((0, 1), (1, 2)),
                                  (frozenset(), frozenset(), frozenset())), 2, False),
    ]
    for name, inst, k, answer in fixtures:
        found = finite_solver(inst, 0, inst.n - 1, k)
        require((found is not None) == answer, name)
        counts['named_regressions'] += 1
    inst = fixtures[2][1]
    require(color_bfs(inst, 0, 2, 3, (1, 1), 2) is None,
            'binary separation alone must fail when an old edge shares a future color')
    require(color_bfs(inst, 0, 2, 3, (1, 2), 2) == (0, 1, 2),
            'injective active colors preserve the valid path')
    counts['named_regressions'] += 2

    # Repeated vertices are permitted only in the intermediate walk proof.
    cyc = Instance(4, ((0, 1), (1, 2), (0, 2), (0, 3)),
                   (frozenset(), frozenset(), frozenset(), frozenset({3})))
    walk = (0, 1, 2, 0, 3)
    require(valid_walk(cyc, walk), 'cycle fixture is not valid')
    short = erase_cycles(walk)
    require(short == (0, 3) and valid_walk(cyc, short), 'cycle erasure')
    counts['named_regressions'] += 1


def seeded_checks(counts, seed):
    rng = random.Random(seed)
    for _ in range(500):
        n = rng.randrange(4, 8)
        candidates = list(combinations(range(n), 2))
        rng.shuffle(candidates)
        edges = tuple(sorted(candidates[:rng.randrange(1, min(len(candidates), 9) + 1)]))
        m = len(edges)
        deletions = tuple(frozenset(e for e in range(m) if rng.randrange(5) == 0)
                          for _ in range(n))
        inst = Instance(n, edges, deletions)
        s, t = rng.sample(range(n), 2)
        k = rng.randrange(2, n + 2)
        check_pair(inst, s, t, k, counts)
        for _ in range(8):
            p = min(k, n) - 1
            colors = tuple(rng.randrange(p + 1) for _ in edges)
            direct = oracle_path(inst, s, t, k, colors)
            state = color_bfs(inst, s, t, k, colors, p)
            require((direct is None) == (state is None), 'seeded color mismatch')
            if state is not None:
                require(valid_walk(inst, state, colors), 'seeded invalid colored path')
            counts['seeded_colored_dp_comparisons'] += 1
        counts['seeded_instances'] += 1


def cover_checks(counts):
    for n in range(1, 6):
        possible = tuple(combinations(range(n), 2))
        for edges in subsets(possible):
            covers = [set(C) for C in subsets(range(n))
                      if all(u in C or v in C for u, v in edges)]
            tau = min(map(len, covers))
            matched = set()
            for u, v in edges:
                if u not in matched and v not in matched:
                    matched.update((u, v))
            require(len(matched) <= 2 * tau, 'matching approximation')
            require(all(u in matched or v in matched for u, v in edges), 'not a cover')
            adj = [[] for _ in range(n)]
            for u, v in edges:
                adj[u].append(v)
                adj[v].append(u)

            def extend(path):
                require(len(path) <= 2 * tau + 1, 'cover path-length bound')
                counts['simple_paths_in_cover_checks'] += 1
                for v in adj[path[-1]]:
                    if v not in path:
                        extend(path + (v,))

            for s in range(n):
                extend((s,))
            counts['cover_graphs'] += 1


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--output', type=Path,
                        default=Path(__file__).resolve().parents[1] / 'results' / 'exact_certificate.json')
    args = parser.parse_args()
    counts = Counter()
    seed = 202611240928
    exhaustive_small(counts)
    padding_checks(counts)
    targeted_checks(counts)
    seeded_checks(counts, seed)
    cover_checks(counts)
    result = {
        'status': 'PASS',
        'arithmetic': 'integer, Boolean and finite-set operations; no floating point',
        'scope': {
            'exhaustive_original_instances': 'all labelled simple undirected graphs on 1..3 vertices, all deletion maps, all ordered endpoints, k=1..n+1',
            'colored_dp': 'all color maps with p=min(k,n)-1 on the exhaustive instances for 2<=k<=n; independent simple-path oracle',
            'padding': 'm=1..7, p=1..4, mu=1..4, all admissible disjoint actual-edge pairs',
            'vertex_cover': 'all labelled simple undirected graphs on 1..5 vertices and all simple paths',
            'seeded': '500 instances on 4..7 vertices, at most 9 edges',
        },
        'counts': dict(sorted(counts.items())),
        'seed': seed,
        'efficient_GLP_family_implemented': False,
        'finite_checks_prove_asymptotic_bound': False,
        'script_sha256': sha256(Path(__file__).read_bytes()).hexdigest(),
    }
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True) + '\n')
    print(json.dumps(result, ensure_ascii=False, indent=2, sort_keys=True))


if __name__ == '__main__':
    main()
