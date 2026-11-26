#!/usr/bin/env python3
"""Independent finite verifier using the full configuration graph.

This checker constructs graph distances by Floyd--Warshall, enumerates all
independent sets, and computes exact shortest reconfiguration lengths by BFS.
It does not import the solver's matching, simulation, or state-generation code.
The only imported production function is solve().
"""
from __future__ import annotations
import argparse
from collections import Counter, deque
from fractions import Fraction
from itertools import combinations, permutations
import json
from pathlib import Path
import platform
import random
import sys
import time

def require(condition, message):
    if not condition:
        raise AssertionError(message)

def edges_to_adj(n, edges):
    adj = [set() for _ in range(n)]
    for u, v in edges:
        adj[u].add(v)
        adj[v].add(u)
    return adj

def distances(adj):
    n = len(adj)
    d = [[n + 1] * n for _ in range(n)]
    for i in range(n):
        d[i][i] = 0
        for j in adj[i]:
            d[i][j] = 1
    for h in range(n):
        for i in range(n):
            for j in range(n):
                d[i][j] = min(d[i][j], d[i][h] + d[h][j])
    return d

def bit_vertices(mask):
    while mask:
        bit = mask & -mask
        yield bit.bit_length() - 1
        mask -= bit

def independent(mask, adj):
    return all(not any(mask >> j & 1 for j in adj[i]) for i in bit_vertices(mask))

def is_connected_mask(mask, adj):
    if not mask:
        return False
    first = (mask & -mask).bit_length() - 1
    seen = {first}
    stack = [first]
    while stack:
        for v in adj[stack.pop()]:
            if mask >> v & 1 and v not in seen:
                seen.add(v)
                stack.append(v)
    return len(seen) == mask.bit_count()

def even_hole_free(adj):
    n = len(adj)
    for mask in range(1 << n):
        q = mask.bit_count()
        if q < 4 or q % 2:
            continue
        if all(sum(mask >> j & 1 for j in adj[i]) == 2 for i in bit_vertices(mask)):
            if is_connected_mask(mask, adj):
                return False
    return True

def induced_forest(mask, adj):
    unseen = set(bit_vertices(mask))
    while unseen:
        root = min(unseen)
        unseen.remove(root)
        todo = [(root, -1)]
        while todo:
            u, parent = todo.pop()
            for v in adj[u]:
                if not (mask >> v & 1) or v == parent:
                    continue
                if v not in unseen:
                    return False
                unseen.remove(v)
                todo.append((v, u))
    return True

def all_independent_sets(adj):
    by_size = {}
    for mask in range(1 << len(adj)):
        if independent(mask, adj):
            by_size.setdefault(mask.bit_count(), []).append(mask)
    return by_size

def configuration_graph(states, d, k):
    adjacency = [[] for _ in states]
    for i, x in enumerate(states):
        for j in range(i):
            y = states[j]
            delta = x ^ y
            if delta.bit_count() != 2:
                continue
            u, v = tuple(bit_vertices(delta))
            if d[u][v] <= k:
                adjacency[i].append(j)
                adjacency[j].append(i)
    return adjacency

def bfs(adjacency, start):
    value = [-1] * len(adjacency)
    value[start] = 0
    queue = deque([start])
    while queue:
        u = queue.popleft()
        for v in adjacency[u]:
            if value[v] < 0:
                value[v] = value[u] + 1
                queue.append(v)
    return value

def c_weight(l, k):
    return (l + k - 1) // k

def f_weight(l, k):
    return max(1, (l - 2 + k - 3) // (k - 2))

def factor(k):
    return {3: Fraction(3), 4: Fraction(2), 5: Fraction(5, 3)}.get(k, Fraction(3, 2))

def brute_assignments(source, target, d, k, adj):
    a, b = sorted(source - target), sorted(target - source)
    costs_c, objectives_f = [], []
    for perm in permutations(b):
        pairs = list(zip(a, perm))
        costs_c.append(sum(c_weight(d[u][v], k) for u, v in pairs))
        objectives_f.append((sum(f_weight(d[u][v], k) for u, v in pairs),
                             -sum(v in adj[u] for u, v in pairs)))
    return min(costs_c), min(objectives_f)

def check_assignment_dual(matrix, certificate, claimed_value):
    q = len(matrix)
    assignment = certificate["column_for_row"]
    row = certificate["row_potential"]
    col = certificate["column_potential"]
    require(len(row) == len(col) == q and sorted(assignment) == list(range(q)),
            "Assignment dual has wrong dimensions")
    require(all(isinstance(x, int) for x in row + col), "Dual values are not exact integers")
    require(all(row[i] + col[j] <= matrix[i][j] for i in range(q) for j in range(q)),
            "Assignment dual infeasible")
    require(sum(row) + sum(col) == claimed_value, "Assignment dual objective incorrect")
    require(sum(matrix[i][assignment[i]] for i in range(q)) == claimed_value,
            "Primal assignment does not equal dual objective")

def check_one(solve, adj, d, source_mask, target_mask, k, optimum):
    source = set(bit_vertices(source_mask))
    target = set(bit_vertices(target_mask))
    result = solve(adj, source, target, k)
    positions = set(source)
    require(result["differences_forest"] is True, "Missing forest-domain declaration")
    require(result["length"] == len(result["moves"]), "Move count differs from declared length")
    for u, v in result["moves"]:
        require(u in positions and v not in positions, "Move does not replace one occupied vertex")
        require(0 < d[u][v] <= k, "Move exceeds the permitted graph distance")
        positions.remove(u)
        positions.add(v)
        require(all(not (adj[x] & (positions - {x})) for x in positions),
                "An intermediate placement is not independent")
    require(positions == target, "Returned sequence has the wrong endpoint")
    W, objective = brute_assignments(source, target, d, k, adj)
    U, negative_edges = objective
    a, b = sorted(source - target), sorted(target - source)
    lower_matrix = [[c_weight(d[u][v], k) for v in b] for u in a]
    upper_matrix = [[(len(a) + 1) * f_weight(d[u][v], k) - int(v in adj[u]) for v in b] for u in a]
    check_assignment_dual(lower_matrix, result["lower_certificate"], W)
    check_assignment_dual(upper_matrix, result["upper_certificate"], (len(a) + 1) * U + negative_edges)
    require(result["lower_bound"] == W, "Lower-bound assignment differs from brute force")
    require(result["assignment_upper_bound"] == U, "Upper assignment differs from brute force")
    pairs = [tuple(p) for p in result["matching"]]
    require(sorted(u for u, _ in pairs) == sorted(source - target), "Matching left side incorrect")
    require(sorted(v for _, v in pairs) == sorted(target - source), "Matching right side incorrect")
    require(sum(f_weight(d[u][v], k) for u, v in pairs) == U, "Matching has wrong f cost")
    require(-sum(v in adj[u] for u, v in pairs) == negative_edges, "Matching violates secondary objective")
    require(Fraction(result["factor_numerator"], result["factor_denominator"]) == factor(k),
            "Factor differs from the claimed theorem")
    L = result["length"]
    require(optimum >= 0, "Domain theorem predicted reachable endpoints but BFS did not")
    require(W <= optimum <= L <= U, "Exact BFS, path, and assignment certificates disagree")
    require(Fraction(U) <= factor(k) * W, "Pointwise assignment comparison failed")
    if W == 0:
        require(source == target and optimum == L == U == 0, "Zero case invalid")
    return result

def run(solve):
    stats = Counter()
    maximum_ratio = Fraction(1)
    maximum_w_gap = Fraction(1)
    worst = None
    graph_records = []

    def verify_graph(adj, label, all_pairs=True, selected_pairs=None, k_values=None):
        nonlocal maximum_ratio, maximum_w_gap, worst
        n = len(adj)
        d = distances(adj)
        require(all(d[0][v] <= n for v in range(n)), "Generator produced a disconnected graph")
        ehf = even_hole_free(adj) if n <= 12 else None
        stats["graphs"] += 1
        if ehf is True:
            stats["even_hole_free_graphs"] += 1
        elif ehf is False:
            stats["other_connected_graphs"] += 1
        diameter = max(max(row) for row in d)
        if k_values is None:
            k_values = list(range(3, max(4, diameter + 1)))
        if selected_pairs is None:
            by_size = all_independent_sets(adj)
        else:
            requested_sizes = {x.bit_count() for x, _ in selected_pairs}
            by_size = {}
            for q in requested_sizes:
                states = []
                for vs in combinations(range(n), q):
                    mask = sum(1 << v for v in vs)
                    if independent(mask, adj):
                        states.append(mask)
                by_size[q] = states
        for k in k_values:
            for q, states in by_size.items():
                adjacency = configuration_graph(states, d, k)
                state_index = {s: i for i, s in enumerate(states)}
                if selected_pairs is None:
                    queries = [(i, j) for i in range(len(states)) for j in range(len(states))]
                else:
                    queries = [(state_index[s], state_index[t]) for s, t in selected_pairs if s.bit_count() == q]
                cache = {}
                for i, j in queries:
                    x, y = states[i], states[j]
                    if not induced_forest(x ^ y, adj):
                        stats["pairs_outside_forest_domain"] += 1
                        continue
                    if i not in cache:
                        cache[i] = bfs(adjacency, i)
                        stats["full_state_bfs_runs"] += 1
                    opt = cache[i][j]
                    result = check_one(solve, adj, d, x, y, k, opt)
                    stats["instances"] += 1
                    stats["moves_checked"] += result["length"]
                    if x != y:
                        stats["nontrivial_instances"] += 1
                        ratio = Fraction(result["length"], opt)
                        gap = Fraction(opt, result["lower_bound"])
                        maximum_w_gap = max(maximum_w_gap, gap)
                        if ratio > maximum_ratio:
                            maximum_ratio = ratio
                            worst = dict(graph=label, n=n, k=k, source=list(bit_vertices(x)),
                                         target=list(bit_vertices(y)), length=result["length"],
                                         optimum=opt, W=result["lower_bound"], U=result["assignment_upper_bound"])
        graph_records.append(dict(label=label, n=n, edges=sum(map(len, adj)) // 2,
                                  diameter=diameter, even_hole_free=ehf))

    # Exhaustive labeled connected graphs through order five; forest-difference
    # pairs are tested even when the whole graph has an even hole.
    for n in range(1, 6):
        possible = list(combinations(range(n), 2))
        for edge_mask in range(1 << len(possible)):
            adj = edges_to_adj(n, [e for j, e in enumerate(possible) if edge_mask >> j & 1])
            if is_connected_mask((1 << n) - 1, adj):
                verify_graph(adj, f"exhaustive-n{n}-mask{edge_mask}")
    stats["exhaustive_graphs"] = stats["graphs"]

    # Longer induced odd cycles demonstrate the nonchordal part of the domain.
    for n in (7, 9):
        adj = edges_to_adj(n, [(i, (i + 1) % n) for i in range(n)])
        verify_graph(adj, f"odd-cycle-{n}", k_values=[3])

    # Reproducible sparse trees with meaningful distances greater than k.
    rng = random.Random(20261124)
    for n in (7, 8, 9):
        for sample in range(8):
            edges = [(v, rng.randrange(v)) for v in range(1, n)]
            adj = edges_to_adj(n, edges)
            if sample == 0:
                adj = edges_to_adj(n, [(v - 1, v) for v in range(1, n)])
            verify_graph(adj, f"seeded-tree-{n}-{sample}", k_values=[3, 4, 5, 6])

    # Certified relaxation obstruction: for every tested k, W=2 and OPT=3.
    barrier_records = []
    for k in range(3, 21):
        n = 2 * k + 1
        adj = edges_to_adj(n, [(i, i + 1) for i in range(n - 1)])
        source = (1 << 0) | (1 << (k - 1))
        target = (1 << (k - 1)) | (1 << (2 * k))
        verify_graph(adj, f"path-relaxation-barrier-k{k}",
                     selected_pairs=[(source, target)], k_values=[k])
        d = distances(adj)
        states = [sum(1 << v for v in vs) for vs in combinations(range(n), 2)
                  if independent(sum(1 << v for v in vs), adj)]
        cg = configuration_graph(states, d, k)
        opt = bfs(cg, states.index(source))[states.index(target)]
        result = solve(adj, {0, k - 1}, {k - 1, 2 * k}, k)
        require(opt == 3 and result["lower_bound"] == 2, "3/2 relaxation barrier failed")
        barrier_records.append(dict(k=k, vertices=n, W=2, exact_optimum=opt,
                                    output_length=result["length"], U=result["assignment_upper_bound"]))

    # Diagnostic comb instances, finite results only: no general sharpness
    # theorem for the simulation is inferred from these data.
    comb_records = []
    for spine_distance in range(4, 8):
        d0 = spine_distance
        n = 2 * d0
        edges = [(i, i + 1) for i in range(d0)]
        edges += [(i, d0 + i) for i in range(1, d0)]
        adj = edges_to_adj(n, edges)
        common = sum(1 << (d0 + i) for i in range(1, d0))
        source, target = common | 1, common | (1 << d0)
        k_values = list(range(3, min(6, d0) + 1))
        verify_graph(adj, f"comb-spine-{d0}", selected_pairs=[(source, target)], k_values=k_values)
        states = []
        for vs in combinations(range(n), d0):
            mask = sum(1 << v for v in vs)
            if independent(mask, adj):
                states.append(mask)
        d = distances(adj)
        for k in k_values:
            cg = configuration_graph(states, d, k)
            opt = bfs(cg, states.index(source))[states.index(target)]
            comb_records.append(dict(spine_distance=d0, k=k, exact_optimum=opt, simulation_bound=f_weight(d0, k)))

    # Regression against the false uniform k/(k-2) comparison.
    require(f_weight(14, 7) == 3 and c_weight(14, 7) == 2, "Rounding control corrupt")
    require(Fraction(3) > Fraction(7, 5) * 2, "Rounding negative control did not fail")

    return dict(
        status="PASS",
        verifier="independent_full_configuration_graph_bfs",
        production_import="solver.solve only",
        arithmetic="integer graph distances, exhaustive permutations, exact Fraction comparisons",
        environment=dict(python=sys.version.split()[0], implementation=platform.python_implementation()),
        deterministic_seed=20261124,
        scope={
            "exhaustive":"Every connected labeled simple graph with 1<=n<=5; every ordered equal-cardinality independent-set pair having a forest symmetric-difference graph; k=3 through max(3,diameter).",
            "additional":"Odd cycles C7,C9; 24 seeded/path trees of orders 7,8,9 for k=3,4,5,6; 18 path relaxation barriers k=3..20; finite comb diagnostics.",
            "not_claimed":"This finite certificate is not a proof of the universal theorem or an external peer review."
        },
        counts=dict(sorted(stats.items())),
        maximum_observed_algorithm_over_optimum=str(maximum_ratio),
        maximum_observed_optimum_over_W=str(maximum_w_gap),
        worst_algorithm_ratio_instance=worst,
        relaxation_barrier_instances=barrier_records,
        comb_diagnostics=comb_records,
        negative_controls={"false_k_over_k_minus_two_factor":"rejected at k=7,d=14: f=3 > (7/5)*c=14/5"},
        graph_records=graph_records,
    )

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    from solver import solve
    start = time.monotonic()
    result = run(solve)
    # Runtime is reported to stdout only, keeping the saved certificate deterministic.
    serialized = json.dumps(result, ensure_ascii=False, indent=2) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(serialized, encoding="utf-8")
    summary = {k: v for k, v in result.items() if k != "graph_records"}
    summary["elapsed_seconds_observed"] = round(time.monotonic() - start, 3)
    print(json.dumps(summary, ensure_ascii=False, indent=2))

if __name__ == "__main__":
    main()

