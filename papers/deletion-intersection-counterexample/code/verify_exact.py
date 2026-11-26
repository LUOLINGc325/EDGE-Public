#!/usr/bin/env python3
"""Reproduce the finite counterexample using three exact methods.

Default mode recomputes and byte-compares the checked-in certificate files.
Use --write to regenerate them, optionally into a separate --output-dir.
Python's -O flag does not disable any verification checks.
"""

from __future__ import annotations

import argparse
from functools import lru_cache
from itertools import combinations, product
import json
from math import comb
from pathlib import Path


X = "0101010100110"
Y = "1001101010101"
N = 13
T = 5
EXPECTED_COUNTS = (1, 2, 4, 8, 16, 32, 64, 122, 155, 94, 20, 0, 0, 0)
SOURCE = "https://arxiv.org/html/2601.06503v2"


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ValueError(message)


def binary_words(length: int):
    for word in product("01", repeat=length):
        yield "".join(word)


def index_subsequences(word: str, length: int) -> set[str]:
    """All distinct outputs, by every increasing tuple of source indices."""
    if length < 0 or length > len(word):
        return set()
    return {
        "".join(word[i] for i in indices)
        for indices in combinations(range(len(word)), length)
    }


def deletion_ball(word: str, deletions: int) -> set[str]:
    if deletions < 0 or deletions > len(word):
        return set()
    return index_subsequences(word, len(word) - deletions)


def greedy_embedding(word: str, source: str) -> tuple[int, ...] | None:
    """Canonical earliest embedding, independent of index enumeration."""
    after = 0
    indices = []
    for symbol in word:
        i = source.find(symbol, after)
        if i == -1:
            return None
        indices.append(i)
        after = i + 1
    return tuple(indices)


def next_occurrences(word: str) -> tuple[tuple[int | None, int | None], ...]:
    result = []
    for i in range(len(word) + 1):
        row = []
        for symbol in "01":
            found = word.find(symbol, i)
            row.append(None if found == -1 else found + 1)
        result.append(tuple(row))
    return tuple(result)


def common_subsequence_dp(x: str, y: str):
    """Generating polynomials for distinct common subsequences of suffixes.

    A state (i,j) uses the suffixes x[i:], y[j:].  A transition labelled a
    jumps to just after the first a in each suffix.  Hence a word has exactly
    one path.  Constant coefficient 1 counts the empty word at every state.
    """
    next_x, next_y = next_occurrences(x), next_occurrences(y)
    polynomials: dict[tuple[int, int], tuple[int, ...]] = {}
    transitions: dict[tuple[int, int], tuple[tuple[int, int] | None, ...]] = {}

    @lru_cache(None)
    def visit(i: int, j: int) -> tuple[int, ...]:
        coefficients = [1]
        targets = []
        for symbol in range(2):
            p, q = next_x[i][symbol], next_y[j][symbol]
            if p is None or q is None:
                targets.append(None)
                continue
            target = (p, q)
            targets.append(target)
            child = visit(*target)
            if len(coefficients) < len(child) + 1:
                coefficients.extend([0] * (len(child) + 1 - len(coefficients)))
            for degree, count in enumerate(child):
                coefficients[degree + 1] += count
        result = tuple(coefficients)
        polynomials[i, j] = result
        transitions[i, j] = tuple(targets)
        return result

    root = visit(0, 0)
    return root, polynomials, transitions, next_x, next_y


def source_D(n: int, t: int) -> int:
    """The source's binomial formula, with SIGNED zero conventions."""
    if n < 0 or t < 0 or t > n:
        return 0
    return sum(comb(n - t, i) for i in range(min(t, n - t) + 1))


def conjectured_M(n: int, t: int) -> int:
    return (
        6 * source_D(n - 6, t - 3)
        + 4 * source_D(n - 8, t - 3)
        + 6 * source_D(n - 9, t - 3)
        + 4 * source_D(n - 11, t - 3)
        + 2 * source_D(n - 13, t - 5)
        + source_D(n - 13, t - 6)
    )


def exhaustive_small_D(n: int, t: int) -> int:
    """Independently check all small inputs needed to evaluate M(13,5)."""
    if n < 0 or t < 0 or t > n:
        return 0
    return max(len(deletion_ball(word, t)) for word in binary_words(n))


def verify_and_render() -> tuple[dict[str, str], dict]:
    require(len(X) == len(Y) == N, "Input lengths differ from 13")
    require(set(X + Y) <= {"0", "1"}, "Nonbinary input")
    require(T >= 5 and N >= T + 8, "Outside Conjecture 1 v2's domain")

    root, polynomials, transitions, next_x, next_y = common_subsequence_dp(X, Y)
    dp_counts = root + (0,) * (N + 1 - len(root))
    require(dp_counts == EXPECTED_COUNTS, "Unexpected DP polynomial")

    common = {}
    for length in range(N + 1):
        # Method 2: enumerate every tuple of source positions in each input.
        from_indices = index_subsequences(X, length) & index_subsequences(Y, length)
        # Method 3: enumerate every possible output word, then test membership.
        from_outputs = {
            word for word in binary_words(length)
            if greedy_embedding(word, X) is not None
            and greedy_embedding(word, Y) is not None
        }
        require(from_indices == from_outputs, f"Enumeration disagreement at length {length}")
        require(len(from_indices) == dp_counts[length], f"DP disagreement at length {length}")
        common[length] = sorted(from_indices)

    lcs = max(length for length, words in common.items() if words)
    require(lcs == 10, "Longest common subsequence is not length 10")
    require(N - lcs == 3, "Deletion distance is not three")
    require(not common[11], "A common length-eleven subsequence exists")
    require(len(common[N - T]) == 155, "Common length-eight count is not 155")

    parameters = [(6, 7, 2), (4, 5, 2), (6, 4, 2), (4, 2, 2), (2, 0, 0), (1, 0, -1)]
    terms = []
    for coefficient, n, t in parameters:
        value = source_D(n, t)
        require(value == exhaustive_small_D(n, t), f"D({n},{t}) check failed")
        terms.append({
            "coefficient": coefficient, "D_n": n, "D_t": t,
            "D_value": value, "term_value": coefficient * value,
        })
    m = conjectured_M(N, T)
    require(source_D(0, -1) == 0, "Negative deletion count was truncated")
    require(m == sum(term["term_value"] for term in terms) == 154, "M(13,5) is not 154")
    require(155 > m, "The witness does not contradict the proposed upper bound")

    embeddings = []
    for word in common[8]:
        ix, iy = greedy_embedding(word, X), greedy_embedding(word, Y)
        require(ix is not None and iy is not None, "Missing common-word embedding")
        require(len(ix) == len(iy) == 8, "Embedding length mismatch")
        require(all(a < b for a, b in zip(ix, ix[1:])), "X indices not increasing")
        require(all(a < b for a, b in zip(iy, iy[1:])), "Y indices not increasing")
        require("".join(X[i] for i in ix) == "".join(Y[j] for j in iy) == word, "Bad embedding")
        embeddings.append({"word": word, "x_indices_0_based": ix, "y_indices_0_based": iy})

    # A complete, independently readable truth table of all 2^8 outputs.
    output_membership = []
    for word in binary_words(8):
        ix, iy = greedy_embedding(word, X), greedy_embedding(word, Y)
        output_membership.append({
            "word": word, "in_x": ix is not None, "in_y": iy is not None,
            "common": ix is not None and iy is not None,
            "x_indices_0_based": ix, "y_indices_0_based": iy,
        })
    require(len(output_membership) == 256, "Incomplete output membership table")
    require(sum(row["common"] for row in output_membership) == 155, "Truth table count mismatch")

    state_order = sorted(polynomials, key=lambda state: (sum(state), state), reverse=True)
    state_rows = []
    for i, j in state_order:
        children = transitions[i, j]
        # A separate check of the table identity and acyclicity.
        rebuilt = [1]
        for target in children:
            if target is None:
                continue
            require(target[0] > i and target[1] > j, "DP transition is not acyclic")
            child = polynomials[target]
            rebuilt += [0] * max(0, len(child) + 1 - len(rebuilt))
            for k, value in enumerate(child):
                rebuilt[k + 1] += value
        require(tuple(rebuilt) == polynomials[i, j], "Invalid DP table identity")
        state_rows.append({
            "i": i, "j": j, "next_0": children[0], "next_1": children[1],
            "coefficients_ascending": polynomials[i, j],
        })

    certificate = {
        "format_revision": 1,
        "scope": "one explicit binary pair; all distinct common subsequences; no global optimality claim",
        "source": SOURCE,
        "source_claim": "Conjecture 1, t >= 5 and n >= t+8",
        "n": N, "t": T, "x": X, "y": Y,
        "common_subsequence_counts_by_length": dp_counts,
        "common_subsequence_polynomial_coefficients_ascending": root,
        "total_distinct_common_subsequences_including_empty": sum(root),
        "longest_common_subsequence_length": lcs,
        "deletion_distance": N - lcs,
        "conjectured_M_terms": terms,
        "conjectured_M": m,
        "certified_lower_bound_for_N_13_3_5": 155,
        "strict_gap": 155 - m,
        "methods": ["next-occurrence polynomial DP", "source-index-subset enumeration", "output-word enumeration"],
        "reachable_dp_state_count": len(polynomials),
        "next_x_after_position_0_based": next_x,
        "next_y_after_position_0_based": next_y,
        "common_subsequences_by_length": common,
        "length8_embeddings": embeddings,
        "all_length8_output_membership": output_membership,
        "reachable_dp_states_bottom_up": state_rows,
    }

    outputs = {
        "exact_certificate.json": json.dumps(certificate, indent=2, ensure_ascii=False) + "\n",
        "common_length8.tsv": "word\tx_indices_0_based\ty_indices_0_based\n" + "".join(
            f"{row['word']}\t{','.join(map(str, row['x_indices_0_based']))}\t"
            f"{','.join(map(str, row['y_indices_0_based']))}\n" for row in embeddings
        ),
        "all_length8_membership.tsv": "word\tin_x\tin_y\tcommon\tx_indices_0_based\ty_indices_0_based\n" + "".join(
            f"{row['word']}\t{int(row['in_x'])}\t{int(row['in_y'])}\t{int(row['common'])}\t"
            f"{('-' if row['x_indices_0_based'] is None else ','.join(map(str, row['x_indices_0_based'])))}\t"
            f"{('-' if row['y_indices_0_based'] is None else ','.join(map(str, row['y_indices_0_based'])))}\n"
            for row in output_membership
        ),
        "common_polynomial.tsv": "length\tcount\n" + "".join(
            f"{length}\t{count}\n" for length, count in enumerate(dp_counts)
        ),
        "dp_table.tsv": "i\tj\tnext_0\tnext_1\tcoefficients_ascending\n" + "".join(
            f"{row['i']}\t{row['j']}\t"
            f"{('-' if row['next_0'] is None else ','.join(map(str,row['next_0'])))}\t"
            f"{('-' if row['next_1'] is None else ','.join(map(str,row['next_1'])))}\t"
            f"{','.join(map(str,row['coefficients_ascending']))}\n" for row in state_rows
        ),
        "verification.txt": (
            "PASS: all verification steps used exact integer arithmetic.\n"
            f"x={X}\ny={Y}\nn={N}, t={T}\n"
            "Conjecture 1 v2 domain: t>=5 and n>=t+8, satisfied.\n"
            f"Common counts at lengths 0..13: {','.join(map(str,dp_counts))}\n"
            f"Common-subsequence polynomial has {sum(root)} total distinct words, including empty.\n"
            "No common length-11 word; 20 common length-10 words; deletion distance is 3.\n"
            "155 distinct common length-8 words; all have checked embeddings.\n"
            "M(13,5)=96+28+24+4+2+0=154; D(0,-1)=0.\n"
            "All small D values also checked by exhaustive binary-input enumeration.\n"
            "41 reachable DP states, all recurrence identities verified.\n"
            "Three exact methods agree at every output length 0..13.\n"
            "Conclusion: N(13,3,5)>=155>154. No global optimum is asserted.\n"
        ),
    }
    return outputs, certificate


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--write", action="store_true", help="write deterministic certificate artifacts")
    parser.add_argument("--output-dir", type=Path, default=Path(__file__).resolve().parents[1] / "results")
    args = parser.parse_args()
    outputs, _ = verify_and_render()
    if args.write:
        args.output_dir.mkdir(parents=True, exist_ok=True)
        for name, text in outputs.items():
            (args.output_dir / name).write_text(text, encoding="utf-8")
    else:
        for name, text in outputs.items():
            path = args.output_dir / name
            require(path.is_file(), f"Missing certificate artifact: {path}")
            require(path.read_bytes() == text.encode("utf-8"), f"Certificate artifact differs: {path}")
    print(outputs["verification.txt"], end="")


if __name__ == "__main__":
    main()
