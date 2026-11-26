#!/usr/bin/env python3
"""Exact certificates for the additional witness n=15,t=5 with n>t+8.

Enumerates retained-position subsets and all possible output words separately.
Default mode rebuilds and byte-compares every n15 artifact; --write regenerates.
"""

from __future__ import annotations

import argparse
import json
from pathlib import Path

from verify_exact import (
    SOURCE, binary_words, conjectured_M, exhaustive_small_D,
    greedy_embedding, index_subsequences, require, source_D,
)


X = "010101010100110"
Y = "100110101010101"
N = 15
T = 5
EXPECTED_BY_DELETIONS = {0: 0, 1: 0, 2: 0, 3: 20, 5: 324}


def indices_field(indices) -> str:
    return "-" if indices is None else ",".join(map(str, indices))


def verify_and_render() -> tuple[dict[str, str], dict]:
    require(len(X) == len(Y) == N, "Input lengths differ from 15")
    require(set(X + Y) <= {"0", "1"}, "Nonbinary input")
    require(T >= 5 and N > T + 8, "Conjectured domain or strict length inequality fails")

    common = {}
    for deletions, expected_count in EXPECTED_BY_DELETIONS.items():
        length = N - deletions
        by_positions = index_subsequences(X, length) & index_subsequences(Y, length)
        by_outputs = {
            word for word in binary_words(length)
            if greedy_embedding(word, X) is not None
            and greedy_embedding(word, Y) is not None
        }
        require(by_positions == by_outputs, f"Two methods disagree at s={deletions}")
        require(len(by_positions) == expected_count, f"Unexpected count at s={deletions}")
        common[deletions] = sorted(by_positions)
    require(all(not common[s] for s in (0, 1, 2)), "Distance below three")
    require(bool(common[3]), "Missing distance-three witness")

    parameters = [(6, 9, 2), (4, 7, 2), (6, 6, 2), (4, 4, 2), (2, 2, 0), (1, 2, -1)]
    terms = []
    for coefficient, n, t in parameters:
        value = source_D(n, t)
        require(value == exhaustive_small_D(n, t), f"D({n},{t}) enumeration disagrees")
        terms.append({
            "coefficient": coefficient, "D_n": n, "D_t": t,
            "D_value": value, "term_value": coefficient * value,
        })
    m = conjectured_M(N, T)
    require(source_D(2, -1) == 0, "Negative deletion count was truncated")
    require(m == sum(row["term_value"] for row in terms) == 322, "M(15,5) is not 322")
    require(len(common[5]) == 324 > m, "No strict counterexample")

    embeddings = []
    for word in common[5]:
        ix, iy = greedy_embedding(word, X), greedy_embedding(word, Y)
        require(ix is not None and iy is not None, "Missing embedding")
        require(len(ix) == len(iy) == N - T, "Embedding length mismatch")
        for source, indices in ((X, ix), (Y, iy)):
            require(all(a < b for a, b in zip(indices, indices[1:])), "Indices not increasing")
            require("".join(source[i] for i in indices) == word, "Incorrect embedded word")
        embeddings.append({"word": word, "x_indices_0_based": ix, "y_indices_0_based": iy})

    membership = []
    for word in binary_words(N - T):
        ix, iy = greedy_embedding(word, X), greedy_embedding(word, Y)
        membership.append({
            "word": word, "in_x": ix is not None, "in_y": iy is not None,
            "common": ix is not None and iy is not None,
            "x_indices_0_based": ix, "y_indices_0_based": iy,
        })
    require(len(membership) == 1024, "Incomplete length-ten output table")
    require(sum(row["common"] for row in membership) == 324, "Truth table count mismatch")

    distance_witness = common[3][0]
    certificate = {
        "format_revision": 1,
        "scope": "one additional witness with n>t+8; no global optimum or infinite family asserted",
        "source": SOURCE,
        "source_claim": "Conjecture 1, t >= 5 and n >= t+8",
        "n": N, "t": T, "x": X, "y": Y,
        "strict_domain_margin_n_minus_t_minus_8": N - T - 8,
        "common_counts_by_deletion_number": EXPECTED_BY_DELETIONS,
        "deletion_distance": 3,
        "longest_common_subsequence_length": 12,
        "distance_witness": {
            "word": distance_witness,
            "x_indices_0_based": greedy_embedding(distance_witness, X),
            "y_indices_0_based": greedy_embedding(distance_witness, Y),
        },
        "conjectured_M_terms": terms,
        "conjectured_M": m,
        "certified_lower_bound_for_N_15_3_5": 324,
        "strict_gap": 324 - m,
        "methods": ["source-index-subset enumeration", "output-word enumeration"],
        "common_subsequences_by_deletion_number": common,
        "length10_embeddings": embeddings,
        "all_length10_output_membership": membership,
    }
    outputs = {
        "n15_exact_certificate.json": json.dumps(certificate, indent=2, ensure_ascii=False) + "\n",
        "n15_common_length10.tsv": "word\tx_indices_0_based\ty_indices_0_based\n" + "".join(
            f"{row['word']}\t{indices_field(row['x_indices_0_based'])}\t"
            f"{indices_field(row['y_indices_0_based'])}\n" for row in embeddings
        ),
        "n15_all_length10_membership.tsv": (
            "word\tin_x\tin_y\tcommon\tx_indices_0_based\ty_indices_0_based\n" + "".join(
                f"{row['word']}\t{int(row['in_x'])}\t{int(row['in_y'])}\t{int(row['common'])}\t"
                f"{indices_field(row['x_indices_0_based'])}\t{indices_field(row['y_indices_0_based'])}\n"
                for row in membership
            )
        ),
        "n15_verification.txt": (
            "PASS: exact integer verification of the witness with strict length inequality.\n"
            f"x={X}\ny={Y}\nn=15, t=5\n"
            "Conjecture 1 v2 domain: 5>=5 and 15>5+8; strict length inequality holds.\n"
            "Intersections at deletions s=0,1,2,3,5 have sizes 0,0,0,20,324.\n"
            "The two methods agree as complete sets at every checked deletion count.\n"
            "No common lengths 15,14,13; common length 12 exists; deletion distance is 3.\n"
            "All 1024 possible length-ten outputs are classified; all 324 common words have checked embeddings.\n"
            "M(15,5)=174+64+66+16+2+0=322; D(2,-1)=0.\n"
            "All small D values also checked by exhaustive binary-input enumeration.\n"
            "Conclusion: N(15,3,5)>=324>322. No global optimum or infinite family is asserted.\n"
        ),
    }
    return outputs, certificate


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write", action="store_true", help="regenerate checked files")
    parser.add_argument("--output-dir", type=Path, default=Path(__file__).resolve().parents[1] / "results")
    args = parser.parse_args()
    outputs, _ = verify_and_render()
    if args.write:
        args.output_dir.mkdir(parents=True, exist_ok=True)
        for filename, text in outputs.items():
            (args.output_dir / filename).write_text(text, encoding="utf-8")
    else:
        for filename, text in outputs.items():
            path = args.output_dir / filename
            require(path.is_file(), f"Missing certificate: {path}")
            require(path.read_bytes() == text.encode("utf-8"), f"Certificate mismatch: {path}")
    print(outputs["n15_verification.txt"], end="")


if __name__ == "__main__":
    main()
