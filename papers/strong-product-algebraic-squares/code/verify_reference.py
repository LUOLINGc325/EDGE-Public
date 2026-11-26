#!/usr/bin/env python3
"""Exact independent method: enumerate cores, then pair boundary-coloured components.

This implementation does not import the involution enumerator and does not assume
the product theorem. All arithmetic is Boolean/integer. NetworkX supplies only the
published finite graph atlas, product construction, and exact graph isomorphism.
"""
from __future__ import annotations

import argparse
import itertools
import json
import time
from pathlib import Path

import networkx as nx


def normalized(g):
    return nx.convert_node_labels_to_integers(g)


def graph_key(g):
    return nx.to_graph6_bytes(normalized(g), header=False).strip().decode()


def components(masks, active):
    result = []
    while active:
        bit = active & -active
        active ^= bit
        pending = bit
        block = bit
        while pending:
            bit = pending & -pending
            pending ^= bit
            vertex = bit.bit_length() - 1
            new = masks[vertex] & active
            active ^= new
            pending |= new
            block |= new
        result.append(block)
    return result


def square_by_cores(g):
    """Return an actual butterfly permutation, or None after exhaustive search."""
    g = normalized(g)
    n = len(g)
    full = (1 << n) - 1
    masks = [sum(1 << v for v in g[u]) for u in g]
    # A moved set must have even cardinality. The core is proper and nonempty.
    for core in range(1, full):
        if (n - core.bit_count()) % 2:
            continue
        blocks = components(masks, full ^ core)
        if len(blocks) < 2 or len(blocks) % 2:
            continue
        classes = []
        maps = []
        for block in blocks:
            vertices = [u for u in range(n) if block >> u & 1]
            sub = g.subgraph(vertices).copy()
            nx.set_node_attributes(sub, {u: masks[u] & core for u in vertices}, 'boundary')
            matched = False
            for c, representative in enumerate(classes):
                if len(sub) != len(representative):
                    continue
                matcher = nx.algorithms.isomorphism.GraphMatcher(
                    representative, sub,
                    node_match=lambda x, y: x['boundary'] == y['boundary'])
                if matcher.is_isomorphic():
                    maps[c].append(dict(matcher.mapping))
                    matched = True
                    break
            if not matched:
                classes.append(sub)
                maps.append([{u: u for u in vertices}])
        if any(len(group) % 2 for group in maps):
            continue
        phi = list(range(n))
        for group in maps:
            for first, second in zip(group[::2], group[1::2]):
                for u in first:
                    phi[first[u]] = second[u]
                    phi[second[u]] = first[u]
        assert sorted(phi) == list(range(n))
        assert any(phi[u] == u for u in range(n))
        assert any(phi[u] != u for u in range(n))
        assert all(phi[phi[u]] == u for u in range(n))
        assert all(g.has_edge(u, v) == g.has_edge(phi[u], phi[v])
                   for u, v in itertools.combinations(range(n), 2))
        for block in blocks:
            assert not any((block >> phi[u] & 1) for u in range(n) if block >> u & 1)
        return phi
    return None


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--output', default='results/reference_certificate.json')
    args = parser.parse_args()
    start = time.monotonic()
    atlas = [normalized(g) for g in nx.graph_atlas_g() if 0 < len(g) <= 7]
    known = {graph_key(g): square_by_cores(g) is not None for g in atlas}
    small = [g for g in atlas if len(g) <= 5]
    rows = []
    for i, g in enumerate(small):
        for h in small[i:]:
            if len(g) * len(h) > 12:
                continue
            x = normalized(nx.strong_product(g, h))
            witness = square_by_cores(x)
            factor_components = [normalized(g.subgraph(c)) for c in nx.connected_components(g)]
            factor_components += [normalized(h.subgraph(c)) for c in nx.connected_components(h)]
            component_square = any(square_by_cores(c) is not None for c in factor_components)
            product_components = [x.subgraph(c).copy() for c in nx.connected_components(x)]
            collision = len(product_components) >= 3 and any(
                nx.is_isomorphic(c, d) for c, d in itertools.combinations(product_components, 2))
            expected = component_square or collision
            assert (witness is not None) == expected, (graph_key(g), graph_key(h))
            if nx.is_connected(g) and nx.is_connected(h):
                assert expected == (known[graph_key(g)] or known[graph_key(h)])
            rows.append({'g': graph_key(g), 'h': graph_key(h), 'vertices': len(x),
                         'square': expected, 'square_factor_component': component_square,
                         'component_collision_with_remainder': collision, 'witness': witness})
    # Directed checks attack the nonempty-core and true-twin restrictions.
    p3 = nx.path_graph(3)
    k2 = nx.complete_graph(2)
    paw = nx.Graph([(0, 1), (1, 2), (1, 3), (2, 3)])
    two_edges = nx.disjoint_union(k2, k2)
    targeted = [
        ('P3', p3, True),
        ('K2_strong_K2', nx.strong_product(k2, k2), False),
        ('P3_strong_K2', nx.strong_product(p3, k2), True),
        ('unequal_true_twin_weights', paw, False),
        ('two_identical_connected_components_empty_core', two_edges, False),
        ('same_pair_plus_fixed_component', nx.disjoint_union(two_edges, nx.empty_graph(1)), True),
    ]
    target_rows = []
    for name, graph, answer in targeted:
        witness = square_by_cores(graph)
        assert (witness is not None) == answer, name
        target_rows.append({'name': name, 'expected': answer, 'witness': witness})
    result = {'method': 'Enumerate every nonempty proper core; pair exact boundary-coloured component isomorphism classes.',
              'atlas_nonempty_graphs': len(atlas),
              'atlas_square_graphs': sum(known.values()),
              'atlas_connected_graphs': sum(nx.is_connected(g) for g in atlas),
              'atlas_connected_square_graphs': sum(known[graph_key(g)] for g in atlas if nx.is_connected(g)),
              'factor_max_vertices': 5, 'product_max_vertices': 12,
              'product_pairs': len(rows), 'mismatches': 0,
              'targeted_checks': target_rows, 'product_rows': rows,
              'networkx_version': nx.__version__}
    Path(args.output).write_text(json.dumps(result, ensure_ascii=False, indent=2) + '\n')
    print(json.dumps({k: v for k, v in result.items() if k not in ['product_rows', 'targeted_checks']}, indent=2))
    print('elapsed_seconds', round(time.monotonic() - start, 3))


if __name__ == '__main__':
    main()
