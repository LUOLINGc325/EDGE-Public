#!/usr/bin/env python3
"""Recompute deterministic finite checks independently of the analytic proof.

This checks graph adjacency and full automorphism enumerations, not real-valued
approximations. It does not constitute a formal proof of the unbounded theorem.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from itertools import combinations_with_replacement
from pathlib import Path
import sys
import networkx as nx
from cartesian_squares import (
    butterfly_witness, direct_count, direct_square, even_path_orders,
    factor_product, glued_root, graph6, is_path, nonsquare_product_criterion,
    normalized, ordered_tokens, predicted_count_connected, prime_factors, require,
)


def stable_digest(rows):
    return hashlib.sha256(json.dumps(rows, sort_keys=True, separators=(",", ":")).encode()).hexdigest()


def run():
    atlas = [normalized(g) for g in nx.graph_atlas_g() if len(g)]
    connected = [g for g in atlas if nx.is_connected(g)]
    counts = {graph6(g): direct_count(graph6(g)) for g in atlas}
    atlas_rows, token_rows = [], []
    composite_count = 0
    root_checks = 0
    for g in connected:
        key = graph6(g)
        factors = prime_factors(g)
        require(nx.is_isomorphic(g, factor_product(factors)), "prime reconstruction failed: " + key)
        composite_count += len(factors) >= 2
        predicted = predicted_count_connected(g)
        observed = counts[key]["butterfly_involutions"]
        require(predicted == observed, "connected involution count failed: " + key)
        atlas_rows.append([key, observed, predicted, len(factors)])
        if len(g) >= 2:
            configuration = ordered_tokens(g)
            cc = list(nx.connected_components(configuration))
            expected = 2 if is_path(g) else 1
            require(len(cc) == expected, "ordered-token connectivity failed: " + key)
            if expected == 2:
                require({(v, u) for u, v in cc[0]} == cc[1], "path components not exchanged")
            token_rows.append([key, len(cc)])

    # The disconnected component lemma is checked against full automorphisms.
    disconnected_rows = []
    for g in atlas:
        key = graph6(g)
        components = [normalized(g.subgraph(c)) for c in nx.connected_components(g)]
        component_square = any(direct_square(graph6(c)) for c in components)
        repeated = len(components) >= 3 and any(
            nx.is_isomorphic(components[i], components[j])
            for i in range(len(components)) for j in range(i)
        )
        predicted = component_square or repeated
        observed = counts[key]["butterfly_involutions"] > 0
        require(predicted == observed, "component lemma failed: " + key)
        if not nx.is_connected(g):
            disconnected_rows.append([key, observed, predicted])
        witness = counts[key]["first_witness"]
        if witness is not None:
            require(nx.is_isomorphic(g, glued_root(g, witness)), "root gluing failed: " + key)
            root_checks += 1

    # Full counts on all unordered pairs of connected atlas inputs of order <=4.
    small_connected = [g for g in connected if len(g) <= 4]
    product_rows = []
    for a, b in combinations_with_replacement(small_connected, 2):
        product = normalized(nx.cartesian_product(a, b))
        observed = direct_count(graph6(product))["butterfly_involutions"]
        predicted = predicted_count_connected(product)
        require(observed == predicted, "product count failed: " + graph6(a) + "/" + graph6(b))
        product_rows.append([graph6(a), graph6(b), observed, predicted])

    # All unordered nonsquare atlas input pairs of orders <=5 with product <=12.
    nonsquare = [g for g in atlas if len(g) <= 5 and not counts[graph6(g)]["butterfly_involutions"]]
    promise_rows = []
    for a, b in combinations_with_replacement(nonsquare, 2):
        if len(a) * len(b) > 12:
            continue
        observed = direct_square(graph6(nx.cartesian_product(a, b)))
        predicted, reason = nonsquare_product_criterion(a, b)
        require(observed == predicted, "nonsquare product criterion failed")
        promise_rows.append([graph6(a), graph6(b), observed, predicted, reason])

    # Targeted cases outside the basic order range.
    special = []
    examples = [
        ("P4_box_P4", nx.path_graph(4), nx.path_graph(4), True),
        ("P2_box_P4", nx.path_graph(2), nx.path_graph(4), False),
        ("K3_box_K3", nx.complete_graph(3), nx.complete_graph(3), False),
        ("K1_plus_K3_squared", nx.disjoint_union(nx.empty_graph(1), nx.complete_graph(3)), nx.disjoint_union(nx.empty_graph(1), nx.complete_graph(3)), True),
        ("two_K3_times_K1", nx.disjoint_union(nx.complete_graph(3), nx.complete_graph(3)), nx.empty_graph(1), False),
        ("two_K3_times_two_K1", nx.disjoint_union(nx.complete_graph(3), nx.complete_graph(3)), nx.empty_graph(2), True),
        ("nonisomorphic_factors_P2K3_P2K4", nx.cartesian_product(nx.path_graph(2), nx.complete_graph(3)), nx.cartesian_product(nx.path_graph(2), nx.complete_graph(4)), True),
    ]
    for name, a, b, expected in examples:
        require(not direct_square(graph6(a)) and not direct_square(graph6(b)), "special-case promise violated")
        predicted, reason = nonsquare_product_criterion(a, b)
        product = normalized(nx.cartesian_product(a, b))
        observed = direct_square(graph6(product))
        require(predicted == observed == expected, "special case failed: " + name)
        special.append({"name": name, "vertices": len(product), "square": observed, "reason": reason})

    hypercubes = []
    for dimension in range(1, 5):
        g = normalized(nx.hypercube_graph(dimension))
        observed = direct_count(graph6(g))["butterfly_involutions"]
        expected = dimension * (dimension - 1)
        require(observed == expected, "hypercube count failed")
        hypercubes.append({"dimension": dimension, "count": observed})

    groups = {
        "connected_atlas_count_formula": atlas_rows,
        "ordered_token_connectivity": token_rows,
        "disconnected_atlas_component_lemma": disconnected_rows,
        "small_connected_product_count_formula": product_rows,
        "nonsquare_product_full_criterion": promise_rows,
    }
    return {
        "status": "PASS",
        "arithmetic": "finite graph adjacency, exact permutations and integer counts; no floating point",
        "networkx_version": nx.__version__,
        "atlas_nonempty_graphs": len(atlas),
        "atlas_connected_graphs": len(connected),
        "atlas_composite_connected_graphs": composite_count,
        "atlas_automorphisms_examined": sum(v["automorphisms_examined"] for v in counts.values()),
        "atlas_square_graphs_with_root_reconstruction": root_checks,
        "groups": {name: {"cases": len(rows), "sha256": stable_digest(rows)} for name, rows in groups.items()},
        "targeted_cases": special,
        "hypercube_counts": hypercubes,
        "scope": "All nonempty NetworkX atlas graphs (up to seven vertices); explicitly specified product families only. The finite checks do not prove the unrestricted theorems.",
        "algorithm_scope": "Reference prime factorization is polynomial, direct automorphism enumeration is potentially exponential; the manuscript's linear bound is an external-algorithm-based promise result.",
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path, default=Path("results/exact_certificate.json"))
    args = parser.parse_args()
    result = run()
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2, sort_keys=True) + "\n")
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
