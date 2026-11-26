"""Exact diagnosis of the proposed common-coordinate positive-circuit hypothesis.

The Petersen graph and its hypohamiltonicity are classical.  This file checks
the proposed subspace consequence and computes the auxiliary one-anchor game.
It does NOT disprove the regression Gamma conjecture, or its k=1 game bound.

No floating point and no optimization solver are used.  Cycle completeness is
checked a second way by an independent subset dynamic program.
"""
from __future__ import annotations

import argparse
from collections import Counter, defaultdict
from fractions import Fraction
import hashlib
import json
from pathlib import Path

import sympy as sp


def petersen_edges():
    edges = set()
    for i in range(5):
        edges.add(tuple(sorted((i, (i + 1) % 5))))
        edges.add((i, 5 + i))
        edges.add(tuple(sorted((5 + i, 5 + (i + 2) % 5))))
    return sorted(edges)


def adjacency(edges):
    result = {i: [] for i in range(10)}
    for a, b in edges:
        result[a].append(b)
        result[b].append(a)
    return {i: sorted(neighbors) for i, neighbors in result.items()}


def undirected_simple_cycles(edges):
    """DFS enumerator; each cycle is identified up to rotation and reversal."""
    neighbors = adjacency(edges)
    result = set()
    for start in range(10):
        def visit(path):
            for nxt in neighbors[path[-1]]:
                if nxt == start and len(path) >= 3:
                    direct = tuple(path)
                    reverse = (start,) + tuple(reversed(path[1:]))
                    result.add(min(direct, reverse))
                elif nxt > start and nxt not in path:
                    visit(path + [nxt])
        visit([start])
    return sorted(result, key=lambda cycle: (len(cycle), cycle))


def independent_directed_cycle_counts(edges):
    """Independent subset DP counting directed simple cycles, not DFS lists.

    The smallest vertex is the unique starting point.  A two-arc cycle occurs
    once; cycles of length >=3 distinguish their two orientations.
    """
    neighbors = adjacency(edges)
    counts = Counter()
    for start in range(10):
        layers = {(1 << start, start): 1}
        for length in range(1, 11):
            next_layer = defaultdict(int)
            for (mask, last), count in layers.items():
                if length >= 2 and start in neighbors[last]:
                    counts[length] += count
                for nxt in neighbors[last]:
                    if nxt > start and not mask & (1 << nxt):
                        next_layer[(mask | (1 << nxt), nxt)] += count
            layers = next_layer
    return dict(sorted(counts.items()))


def directed_cycle_list(edges, undirected):
    cycles = [tuple(edge) for edge in edges]
    for cycle in undirected:
        cycles.append(cycle)
        cycles.append((cycle[0],) + tuple(reversed(cycle[1:])))
    return sorted(cycles, key=lambda cycle: (len(cycle), cycle))


def reduced_incidence(edges):
    arcs = sorted((a, b) for x, y in edges for a, b in [(x, y), (y, x)])
    matrix = sp.zeros(9, len(arcs))
    for j, (tail, head) in enumerate(arcs):
        if tail < 9:
            matrix[tail, j] -= 1
        if head < 9:
            matrix[head, j] += 1
    return arcs, matrix


def rank_payoff(anchor_vertices, target_vertices):
    """dim(U_target)-dim(U_anchor intersect U_target) in sum-zero space."""
    a, c = set(anchor_vertices), set(target_vertices)
    return len(c) - 1 - max(len(a & c) - 1, 0)


def build_certificate():
    edges = petersen_edges()
    undirected = undirected_simple_cycles(edges)
    directed = directed_cycle_list(edges, undirected)
    arcs, g = reduced_incidence(edges)
    arc_index = {arc: j for j, arc in enumerate(arcs)}
    circuits = []
    for cycle in directed:
        columns = [arc_index[(cycle[j], cycle[(j + 1) % len(cycle)])]
                   for j in range(len(cycle))]
        submatrix = g[:, columns]
        assert submatrix * sp.ones(len(cycle), 1) == sp.zeros(9, 1)
        assert submatrix.rank() == len(cycle) - 1
        circuits.append({"cycle_vertices": list(cycle), "arc_indices": columns,
                         "rank": len(cycle) - 1,
                         "positive_dependence_coefficients": [1] * len(cycle)})
    maximal = []
    representatives = []
    for omitted in range(10):
        indices = [j for j, cycle in enumerate(directed)
                   if len(cycle) == 9 and omitted not in cycle]
        assert indices
        normal = [int(j == omitted) for j in range(9)] if omitted < 9 else [1] * 9
        maximal.append({"omitted_vertex": omitted, "rank": 8, "normal": normal,
                        "circuit_indices": indices,
                        "representative_circuit": indices[0]})
        representatives.append(indices[0])
    normal_matrix = sp.Matrix([entry["normal"] for entry in maximal])
    assert normal_matrix.rank() == 9
    assert all(normal_matrix[[i for i in range(10) if i != omitted], :].det() != 0
               for omitted in range(10))
    primal_values = []
    dual_values = []
    for cycle in directed:
        primal_values.append(sum(Fraction(rank_payoff(directed[j], cycle), 10)
                                 for j in representatives))
        dual_values.append(sum(Fraction(rank_payoff(cycle, directed[j]), 10)
                               for j in representatives))
    assert max(primal_values) == min(dual_values) == Fraction(9, 10)
    rows, pivots = g.rref()
    rank_basis = list(pivots)
    assert len(rank_basis) == 9
    cycle_hash = hashlib.sha256(json.dumps([list(v) for v in directed],
                                           separators=(",", ":")).encode()).hexdigest()
    return {
        "schema": "petersen-positive-circuit-span-v1",
        "scope": "Counterexample to common-coordinate maximal circuit spans only",
        "claim_not_made": "Neither Gamma nor the universal k=1 rank-game bound is refuted",
        "minimal_dimension_claimed": False,
        "dimension": 9, "root_count": 30, "deleted_incidence_row": 9,
        "undirected_edges": [list(edge) for edge in edges],
        "directed_arcs": [list(arc) for arc in arcs],
        "integer_root_matrix": [[int(g[i, j]) for j in range(g.cols)] for i in range(g.rows)],
        "positive_spanning_certificate": {"positive_kernel_vector": [1] * 30,
                                           "rank_basis_columns": rank_basis,
                                           "basis_determinant": int(g[:, rank_basis].det())},
        "undirected_cycle_count": len(undirected),
        "undirected_cycles": [list(v) for v in undirected],
        "directed_cycle_counts_by_length": {str(k): v for k, v in
                                            independent_directed_cycle_counts(edges).items()},
        "positive_circuits": circuits,
        "positive_circuit_list_sha256": cycle_hash,
        "maximal_circuit_spans": maximal,
        "noncoordinate_certificate": {
            "distinct_hyperplane_count": 10,
            "ambient_dimension": 9,
            "fixed_basis_coordinate_hyperplane_count": 9,
            "normal_matrix": [entry["normal"] for entry in maximal],
            "any_nine_normals_independent": True,
        },
        "one_anchor_game": {
            "exact_value": "9/10", "Gamma_9_1": "20/9",
            "Gamma_minus_game": "119/90",
            "primal_anchor_circuit_indices": representatives,
            "primal_weights": ["1/10"] * 10,
            "primal_expected_payoff_for_each_target": list(map(str, primal_values)),
            "dual_target_circuit_indices": representatives,
            "dual_weights": ["1/10"] * 10,
            "dual_expected_payoff_for_each_anchor": list(map(str, dual_values)),
            "maximal_span_payoff_matrix": [[rank_payoff(directed[a], directed[c])
                                             for c in representatives] for a in representatives],
        },
        "primary_sources": [
            {"authors": "R. E. L. Aldred, B. D. McKay, N. C. Wormald",
             "title": "Small Hypohamiltonian Graphs", "year": 1997,
             "journal": "Journal of Combinatorial Mathematics and Combinatorial Computing 23, 143-152",
             "location": "p.143 introduction: Petersen is the smallest hypohamiltonian graph",
             "url": "https://combinatorialpress.com/article/jcmcc/Volume%20023/vol-23-paper%2012.pdf"},
            {"authors": "D. Cornaz, S. Kerleau, C. W. Royer",
             "title": "A characterization of positive spanning sets with ties to strongly edge-connected digraphs",
             "url": "https://arxiv.org/abs/2411.08994",
             "location": "Section 3.2, Theorem 3.1 (prior positive-spanning/incidence correspondence)"},
        ],
    }


def verify_certificate(certificate):
    """Check stored integer data; completeness uses the independent DP count."""
    assert certificate["dimension"] == 9 and certificate["root_count"] == 30
    edges = [tuple(edge) for edge in certificate["undirected_edges"]]
    assert edges == petersen_edges()
    arcs, g = reduced_incidence(edges)
    assert arcs == [tuple(arc) for arc in certificate["directed_arcs"]]
    assert g == sp.Matrix(certificate["integer_root_matrix"])
    span = certificate["positive_spanning_certificate"]
    coefficients = sp.Matrix(span["positive_kernel_vector"])
    assert all(v > 0 for v in coefficients)
    assert g * coefficients == sp.zeros(9, 1)
    basis = span["rank_basis_columns"]
    assert len(set(basis)) == 9
    assert g[:, basis].det() == span["basis_determinant"] != 0
    circuits = certificate["positive_circuits"]
    unique = set()
    actual_counts = Counter()
    for circuit in circuits:
        vertices = circuit["cycle_vertices"]
        assert len(vertices) == len(set(vertices)) and len(vertices) >= 2
        assert vertices[0] == min(vertices)
        indices = circuit["arc_indices"]
        assert len(indices) == len(vertices)
        for i, j in enumerate(indices):
            assert arcs[j] == (vertices[i], vertices[(i + 1) % len(vertices)])
        key = tuple(sorted(indices))
        assert key not in unique
        unique.add(key)
        a = g[:, indices]
        positive = sp.Matrix(circuit["positive_dependence_coefficients"])
        assert all(v > 0 for v in positive)
        assert a * positive == sp.zeros(9, 1)
        assert a.rank() == len(indices) - 1 == circuit["rank"]
        actual_counts[len(vertices)] += 1
    # Every listed support is a distinct simple directed cycle, and the DP
    # certifies how many such cycles exist at each length: no omitted support.
    expected = independent_directed_cycle_counts(edges)
    assert dict(actual_counts) == expected
    assert expected == {int(k): v for k, v in certificate["directed_cycle_counts_by_length"].items()}
    assert max(expected) == 9
    assert sum(expected.values()) == len(circuits)
    cycle_hash = hashlib.sha256(json.dumps([c["cycle_vertices"] for c in circuits],
                                           separators=(",", ":")).encode()).hexdigest()
    assert cycle_hash == certificate["positive_circuit_list_sha256"]
    undirected = certificate["undirected_cycles"]
    undirected_keys = {min(tuple(v), (v[0],) + tuple(reversed(v[1:])))
                       for v in (entry["cycle_vertices"] for entry in circuits) if len(v) >= 3}
    assert undirected_keys == set(map(tuple, undirected))
    assert len(undirected) == certificate["undirected_cycle_count"]
    maximal = certificate["maximal_circuit_spans"]
    assert len(maximal) == 10
    normals = []
    for missing, item in enumerate(maximal):
        assert item["omitted_vertex"] == missing and item["rank"] == 8
        expected_ids = [i for i, c in enumerate(circuits)
                        if len(c["cycle_vertices"]) == 9 and missing not in c["cycle_vertices"]]
        assert expected_ids == item["circuit_indices"] and expected_ids
        normal = sp.Matrix(item["normal"])
        normals.append(normal)
        for i in expected_ids:
            a = g[:, circuits[i]["arc_indices"]]
            assert normal.T * a == sp.zeros(1, 9) and a.rank() == 8
        assert item["representative_circuit"] in expected_ids
    assert all(sp.Matrix.hstack(normals[i], normals[j]).rank() == 2
               for i in range(10) for j in range(i))
    normal_matrix = sp.Matrix.vstack(*[normal.T for normal in normals])
    noncoordinate = certificate["noncoordinate_certificate"]
    assert normal_matrix == sp.Matrix(noncoordinate["normal_matrix"])
    assert noncoordinate["distinct_hyperplane_count"] == len(maximal) == 10
    assert noncoordinate["ambient_dimension"] == noncoordinate["fixed_basis_coordinate_hyperplane_count"] == 9
    assert noncoordinate["any_nine_normals_independent"] is True
    assert all(normal_matrix[[i for i in range(10) if i != omitted], :].det() != 0
               for omitted in range(10))
    # Every proper vertex set is contained in a certified 9-vertex span.
    for circuit in circuits:
        missing = min(set(range(10)) - set(circuit["cycle_vertices"]))
        assert normals[missing].T * g[:, circuit["arc_indices"]] == sp.zeros(1, len(circuit["arc_indices"]))
    game = certificate["one_anchor_game"]
    primal_ids = game["primal_anchor_circuit_indices"]
    dual_ids = game["dual_target_circuit_indices"]
    primal_weights = list(map(Fraction, game["primal_weights"]))
    dual_weights = list(map(Fraction, game["dual_weights"]))
    assert sum(primal_weights) == sum(dual_weights) == 1
    assert all(v >= 0 for v in primal_weights + dual_weights)
    primal_values = []
    dual_values = []
    for circuit in circuits:
        vertices = circuit["cycle_vertices"]
        primal_values.append(sum(w * rank_payoff(circuits[j]["cycle_vertices"], vertices)
                                 for j, w in zip(primal_ids, primal_weights)))
        dual_values.append(sum(w * rank_payoff(vertices, circuits[j]["cycle_vertices"])
                               for j, w in zip(dual_ids, dual_weights)))
    assert list(map(str, primal_values)) == game["primal_expected_payoff_for_each_target"]
    assert list(map(str, dual_values)) == game["dual_expected_payoff_for_each_anchor"]
    assert max(primal_values) == min(dual_values) == Fraction(game["exact_value"])
    assert Fraction(game["Gamma_9_1"]) - Fraction(game["exact_value"]) == Fraction(game["Gamma_minus_game"])
    # Independently check the rank-payoff formula on every pair of maximal spans.
    for i, aid in enumerate(primal_ids):
        a = circuits[aid]
        for j, cid in enumerate(dual_ids):
            c = circuits[cid]
            union = sorted(set(a["arc_indices"]) | set(c["arc_indices"]))
            actual = g[:, union].rank() - a["rank"]
            assert actual == rank_payoff(a["cycle_vertices"], c["cycle_vertices"])
            assert actual == game["maximal_span_payoff_matrix"][i][j]
    return {"status": "INTEGER_AND_RATIONAL_CERTIFICATE_VERIFIED",
            "dimension": 9, "positive_circuits": len(circuits),
            "cycle_counts": expected, "maximal_hyperplanes": len(maximal),
            "common_coordinate_hypothesis": "FALSE",
            "one_anchor_game": game["exact_value"], "Gamma_9_1": game["Gamma_9_1"],
            "Gamma_refuted": False, "minimal_dimension_claimed": False}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("command", choices=["build", "verify"])
    parser.add_argument("--file", type=Path,
                        default=Path(__file__).with_name("petersen_span_certificate.json"))
    args = parser.parse_args()
    if args.command == "build":
        certificate = build_certificate()
        result = verify_certificate(certificate)
        args.file.write_text(json.dumps(certificate, indent=2) + "\n")
    else:
        result = verify_certificate(json.loads(args.file.read_text()))
    print(json.dumps(result))


if __name__ == "__main__":
    main()
