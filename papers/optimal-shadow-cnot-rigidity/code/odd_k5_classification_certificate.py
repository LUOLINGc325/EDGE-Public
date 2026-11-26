#!/usr/bin/env python3
"""Complete k=5 optimizer classification by exact finite enumeration.

The necessary and sufficient criterion at k=5 is symplecticity with every
physical 2x2 block invertible.  Local input/output GL(2,2) changes dephase
the first block row and column to identity.  The remaining four rows form
an unordered four-clique in an explicitly enumerated compatibility graph.

Equivalence after dephasing consists of independent row/column permutations,
followed by dephasing again, and a common GL(2,2) conjugation.  Choosing the
new first row, permuting columns, conjugating, and sorting the other four
rows therefore examines the entire equivalence relation.  The certificate
finds forty normalized unordered row sets and two classes, of sizes ten
and thirty in that finite universe.  Permutations define a classification
equivalence here; they are not free gates in the circuit resource model.

Uses only Python's standard library and exact integer arithmetic.  The
argument establishing the normalization and its completeness is in
proofs/odd_optimizer_classification.md, Sections 3-5.
"""
from collections import Counter, defaultdict
from itertools import permutations, product
from pathlib import Path
import hashlib
import json

K = 5
# Columns are two-bit vectors; bit zero is x and bit one is z.
GL = [(a, b) for a in (1, 2, 3) for b in (1, 2, 3) if a != b]
IDENTITY = GL.index((1, 2))


def action(matrix, vector):
    return ((matrix[0] if vector & 1 else 0)
            ^ (matrix[1] if vector & 2 else 0))


PRODUCT = [[GL.index((action(left, right[0]), action(left, right[1])))
            for right in GL] for left in GL]
INVERSE = [next(j for j in range(6) if PRODUCT[i][j] == IDENTITY)
           for i in range(6)]
ENCODED = [a | (b << 2) for a, b in GL]


def xor(values):
    answer = 0
    for value in values:
        answer ^= value
    return answer


def row_product_sum(left, right):
    return xor(ENCODED[PRODUCT[a][INVERSE[b]]] for a, b in zip(left, right))


def enumerate_normalized():
    # Inversion is linear on determinant-one binary 2x2 matrices, so the
    # zero matrix-sum is equivalent to orthogonality against the all-I row.
    rows = [(IDENTITY,) + tail for tail in product(range(6), repeat=K-1)
            if xor(ENCODED[a] for a in ((IDENTITY,) + tail)) == 0]
    adjacent = [{j for j in range(i+1, len(rows))
                 if row_product_sum(row, rows[j]) == 0}
                for i, row in enumerate(rows)]
    cliques = []

    def visit(chosen, candidates):
        if len(chosen) == K-1:
            cliques.append(chosen)
            return
        need = K-1-len(chosen)
        for t, i in enumerate(candidates):
            if len(candidates)-t < need:
                break
            visit(chosen + [i], [j for j in candidates[t+1:]
                                 if j in adjacent[i]])

    visit([], list(range(len(rows))))
    matrices = [((IDENTITY,)*K,) + tuple(rows[i] for i in clique)
                for clique in cliques]
    assert len(matrices) == 40
    for matrix in matrices:
        assert all(row[0] == IDENTITY for row in matrix)
        for i in range(K):
            for j in range(K):
                expected = ENCODED[IDENTITY] if i == j else 0
                assert row_product_sum(matrix[i], matrix[j]) == expected
    return matrices, len(rows)


def dephase(matrix):
    first = [[PRODUCT[matrix[i][j]][INVERSE[matrix[0][j]]]
              for j in range(K)] for i in range(K)]
    return tuple(tuple(PRODUCT[INVERSE[first[i][0]]][first[i][j]]
                       for j in range(K)) for i in range(K))


def canonical(matrix):
    best = None
    for top in range(K):
        row_order = [matrix[top]] + [matrix[i] for i in range(K) if i != top]
        for column_order in permutations(range(K)):
            normalized = dephase([[row[j] for j in column_order]
                                  for row in row_order])
            for g in range(6):
                conjugated = [tuple(PRODUCT[PRODUCT[g][a]][INVERSE[g]]
                                    for a in row) for row in normalized]
                key = tuple([conjugated[0]] + sorted(conjugated[1:]))
                if best is None or key < best:
                    best = key
    return best


def block_sign(matrix):
    perm = [action(matrix, x)-1 for x in (1, 2, 3)]
    return sum(perm[i] > perm[j] for i in range(3)
               for j in range(i+1, 3)) % 2


def rectangle_signs(matrix):
    signs = [[block_sign(GL[a]) for a in row] for row in matrix]
    return [[signs[i][j] ^ signs[i][0] ^ signs[0][j] ^ signs[0][0]
             for j in range(K)] for i in range(K)]


def bit_rows(matrix):
    result = [0] * (2*K)
    for i in range(K):
        for j in range(K):
            a, b = GL[matrix[i][j]]
            result[2*i] |= ((a & 1) | ((b & 1) << 1)) << (2*j)
            result[2*i+1] |= (((a >> 1) & 1) | (((b >> 1) & 1) << 1)) << (2*j)
    return result


def output_histogram(matrix):
    histogram = Counter()
    for inputs in product((1, 2, 3), repeat=K):
        outputs = [xor(action(GL[a], value) for a, value in zip(row, inputs))
                   for row in matrix]
        histogram[sum(value != 0 for value in outputs)] += 1
    return dict(sorted(histogram.items()))


def main():
    matrices, candidate_count = enumerate_normalized()
    classes = defaultdict(list)
    for matrix in matrices:
        classes[canonical(matrix)].append(matrix)
    assert sorted(map(len, classes.values())) == [10, 30]

    r, r2 = GL.index((2, 3)), GL.index((3, 1))
    dual = tuple(tuple(r if i == j else r2 for j in range(K)) for i in range(K))
    a, b, c = (GL.index(x) for x in ((1, 3), (2, 1), (3, 2)))
    ident = IDENTITY
    exceptional = ((ident, ident, ident, ident, ident),
                   (ident, ident, a, b, c),
                   (ident, a, ident, c, b),
                   (ident, b, c, ident, a),
                   (ident, c, b, a, ident))
    dual_key, exceptional_key = canonical(dual), canonical(exceptional)
    assert dual_key in classes and exceptional_key in classes
    assert dual_key != exceptional_key
    assert len(classes[dual_key]) == 10
    assert len(classes[exceptional_key]) == 30
    assert not any(any(row) for row in rectangle_signs(dual))
    assert any(any(row) for row in rectangle_signs(exceptional))
    histogram = output_histogram(exceptional)
    assert histogram == {1: 15, 3: 120, 5: 108}
    score = sum(count * 3**(K-weight) for weight, count in histogram.items())
    assert score == 2403

    result = {
        "k": K,
        "scope": "complete optimizer classification under local input/output Clifford actions and independent input/output permutations",
        "physical_permutations_free_in_gate_model": False,
        "group_encoding": "2x2 matrices by two binary column masks, x in bit 0",
        "gl2_columns": GL,
        "identity_index": IDENTITY,
        "candidate_rows_after_dephasing": candidate_count,
        "normalized_unordered_row_sets": len(matrices),
        "ordered_normalized_matrices": 24 * len(matrices),
        "number_of_classes": len(classes),
        "classes": [{
            "name": name,
            "normalized_unordered_row_set_count": len(classes[key]),
            "ordered_normalized_matrix_count": 24 * len(classes[key]),
            "canonical_block_group_indices": key,
            "canonical_binary_rows": bit_rows(key),
            "dephased_rectangle_signs": rectangle_signs(key),
        } for name, key in (("dual_axis", dual_key), ("exceptional", exceptional_key))],
        "exceptional_witness": {
            "block_group_indices": exceptional,
            "binary_rows": bit_rows(exceptional),
            "output_weight_histogram": histogram,
            "score": score,
            "source_optimal_score": (3 * 5**K + 3**K - 6) // 4,
        },
        "all_normalized_unordered_row_sets": matrices,
        "certificate_source_sha256": hashlib.sha256(Path(__file__).read_bytes()).hexdigest(),
    }
    case = Path(__file__).resolve().parents[1]
    destination = case / "results" / "odd_k5_classification.json"
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps({
        "candidate_rows": candidate_count,
        "normalized_unordered_row_sets": len(matrices),
        "ordered_normalized_matrices": 24 * len(matrices),
        "number_of_classes": len(classes),
        "class_counts_in_unordered_universe": [10, 30],
        "exceptional_score": score,
        "output": str(destination),
    }, indent=2))


if __name__ == "__main__":
    main()
