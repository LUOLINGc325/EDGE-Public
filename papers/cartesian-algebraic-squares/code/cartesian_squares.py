"""Exact reference routines for algebraic squares under a nonempty-core convention.

The prime-factor routine implements the classical polynomial relation of Feder,
as stated in Imrich--Peterin, Theorem 3.1. It is NOT their linear-time algorithm.
The direct square detector enumerates all automorphisms; it is a small-case
verification oracle, not a polynomial-time general square recognizer.
"""
from __future__ import annotations

from collections import Counter
from functools import lru_cache
from itertools import combinations
import networkx as nx


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def normalized(graph):
    return nx.convert_node_labels_to_integers(graph, ordering="default")


def graph6(graph):
    return nx.to_graph6_bytes(normalized(graph), header=False).decode().strip()


def is_path(graph):
    n = len(graph)
    return n >= 2 and nx.is_connected(graph) and graph.number_of_edges() == n - 1 and max(dict(graph.degree()).values()) <= 2


def butterfly_witness(graph, phi):
    """Check a supplied permutation directly against the definition."""
    vertices = set(graph)
    if set(phi) != vertices or set(phi.values()) != vertices:
        return None
    if any(phi[phi[v]] != v for v in graph):
        return None
    if any(not graph.has_edge(phi[u], phi[v]) for u, v in graph.edges()):
        return None
    fixed = {v for v in graph if phi[v] == v}
    if not fixed or fixed == vertices:
        return None
    components = list(nx.connected_components(graph.subgraph(vertices - fixed)))
    owner = {v: i for i, component in enumerate(components) for v in component}
    images = [owner[phi[next(iter(component))]] for component in components]
    if any(i == j for i, j in enumerate(images)):
        return None
    wing = set()
    chosen = set()
    for i, j in enumerate(images):
        if i not in chosen:
            wing.update(components[i])
            chosen.update((i, j))
    other = vertices - fixed - wing
    require({phi[v] for v in wing} == other, "witness does not exchange wings")
    require(not any(graph.has_edge(u, v) for u in wing for v in other), "cross-wing edge")
    return {"fixed": sorted(fixed), "wing": sorted(wing), "other": sorted(other)}


@lru_cache(maxsize=None)
def direct_count(encoded):
    graph = nx.from_graph6_bytes(encoded.encode())
    count = 0
    automorphisms = 0
    first = None
    for phi in nx.algorithms.isomorphism.GraphMatcher(graph, graph).isomorphisms_iter():
        automorphisms += 1
        witness = butterfly_witness(graph, phi)
        if witness is not None:
            count += 1
            if first is None:
                first = {"phi": [phi[v] for v in range(len(graph))], **witness}
    return {"butterfly_involutions": count, "automorphisms_examined": automorphisms, "first_witness": first}


@lru_cache(maxsize=None)
def direct_square(encoded):
    graph = nx.from_graph6_bytes(encoded.encode())
    for phi in nx.algorithms.isomorphism.GraphMatcher(graph, graph).isomorphisms_iter():
        if butterfly_witness(graph, phi) is not None:
            return True
    return False


def prime_factors(graph):
    """Return factor layers using sigma=(Theta union tau)^* (Feder)."""
    graph = normalized(graph)
    require(len(graph) > 0 and nx.is_connected(graph), "factorization needs a nonempty connected graph")
    if len(graph) == 1:
        return []
    edges = list(graph.edges())
    parent = list(range(len(edges)))

    def find(i):
        while parent[i] != i:
            parent[i] = parent[parent[i]]
            i = parent[i]
        return i

    def union(i, j):
        i, j = find(i), find(j)
        if i != j:
            parent[j] = i

    dist = dict(nx.all_pairs_shortest_path_length(graph))
    neighbors = {v: set(graph[v]) for v in graph}
    for i, (x, y) in enumerate(edges):
        for j in range(i):
            u, v = edges[j]
            if dist[x][u] + dist[y][v] != dist[x][v] + dist[y][u]:
                union(i, j)
            common = {x, y} & {u, v}
            if len(common) == 1:
                c = next(iter(common))
                a = y if x == c else x
                b = v if u == c else u
                if neighbors[a] & neighbors[b] == {c}:
                    union(i, j)
    classes = {}
    for i, edge in enumerate(edges):
        classes.setdefault(find(i), []).append(edge)
    factors = []
    for edge_class in classes.values():
        colored = nx.Graph()
        colored.add_nodes_from(graph)
        colored.add_edges_from(edge_class)
        layer = nx.node_connected_component(colored, 0)
        factors.append(normalized(colored.subgraph(layer)))
    return factors


def factor_product(factors):
    result = nx.empty_graph(1)
    for factor in factors:
        result = normalized(nx.cartesian_product(result, factor))
    return result


def predicted_count_connected(graph):
    factors = prime_factors(graph)
    inherited = sum(direct_count(graph6(factor))["butterfly_involutions"] for factor in factors)
    paths = Counter(len(factor) for factor in factors if is_path(factor))
    return inherited + 2 * sum(k * (k - 1) // 2 for k in paths.values())


def even_path_orders(graph):
    return {len(factor) for factor in prime_factors(graph) if is_path(factor) and len(factor) % 2 == 0}


def nonsquare_product_criterion(left, right):
    """Exact structural test; both input graphs are PROMISED nonsquare.

    The disconnected repeated-component check uses exact graph isomorphism.
    This simple reference implementation materializes component products.
    """
    require(len(left) > 0 and len(right) > 0, "empty graphs are excluded")
    cc_left = [normalized(left.subgraph(c)) for c in nx.connected_components(left)]
    cc_right = [normalized(right.subgraph(c)) for c in nx.connected_components(right)]
    orders_left = [even_path_orders(c) for c in cc_left]
    orders_right = [even_path_orders(c) for c in cc_right]
    if any(a & b for a in orders_left for b in orders_right):
        return True, "common_even_path"
    if len(cc_left) * len(cc_right) >= 3:
        products = [normalized(nx.cartesian_product(a, b)) for a in cc_left for b in cc_right]
        for a, b in combinations(products, 2):
            if len(a) == len(b) and a.number_of_edges() == b.number_of_edges() and nx.is_isomorphic(a, b):
                return True, "repeated_product_component"
    return False, "neither_condition"


def ordered_tokens(graph):
    result = nx.Graph()
    result.add_nodes_from((u, v) for u in graph for v in graph if u != v)
    for u, v in list(result):
        for w in graph[u]:
            if w != v:
                result.add_edge((u, v), (w, v))
        for w in graph[v]:
            if w != u:
                result.add_edge((u, v), (u, w))
    return result


def glued_root(graph, witness):
    fixed = set(witness["fixed"])
    wing = set(witness["wing"])
    root = graph.subgraph(fixed | wing)
    result = nx.Graph()

    def lifted(v, copy):
        return (0, v) if v in fixed else (copy + 1, v)

    for copy in range(2):
        result.add_nodes_from(lifted(v, copy) for v in root)
        result.add_edges_from((lifted(u, copy), lifted(v, copy)) for u, v in root.edges())
    return normalized(result)
