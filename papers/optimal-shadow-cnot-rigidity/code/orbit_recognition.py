#!/usr/bin/env python3
"""Exact recognition, certificates, and counting for shadow optimizer matrices.

The optimizer API has the proved scope k >= 6.  It relies on the all-order
classification in proofs/odd_optimizer_classification.md and
proofs/even_optimizer_classification.md.  It does not evaluate the exponential
shadow score, minimize a circuit, or identify physical permutations with free
gates.  Everything uses exact arithmetic over F_2 and the Python standard
library.

A 2x2 matrix is encoded by its two column vectors: a + (b << 2), where the
low bit of a vector is its x coordinate.  A block matrix is a k by k list of
these four-bit integers.  A positive certificate is

    M[i][j] = left[i] * (T if j == matching[i] else I) * right[j],

with T=R for odd k and T=K for even k.  The matching contains physical column
labels and is not a free circuit operation.

Run `python3 orbit_recognition.py --self-test` for independently checkable
structural and adversarial checks, or pass a JSON block matrix with --input.
"""

from __future__ import annotations

import argparse
from collections import Counter
from itertools import permutations, product
import json
from math import factorial
from pathlib import Path
import random
from typing import Any


def act(a: int, x: int) -> int:
    return (a & 3 if x & 1 else 0) ^ ((a >> 2) & 3 if x & 2 else 0)


def mul(a: int, b: int) -> int:
    return act(a, b & 3) | (act(a, (b >> 2) & 3) << 2)


def transpose(a: int) -> int:
    return (a & 1) | ((a & 4) >> 1) | ((a & 2) << 1) | (a & 8)


def det(a: int) -> int:
    return ((a & 1) & ((a >> 3) & 1)) ^ (((a >> 1) & 1) & ((a >> 2) & 1))


I, J, R, K = 9, 6, 14, 15
G = tuple(a for a in range(16) if det(a))
INV = {a: next(b for b in G if mul(a, b) == I) for a in G}


def matrix_rank(a: int) -> int:
    return 2 if det(a) else int(a != 0)


def normal_matrix(k: int, matching: list[int] | None = None) -> list[list[int]]:
    """Return the normalized dual-axis matrix, including smaller test orders."""
    if matching is None:
        matching = list(range(k))
    if sorted(matching) != list(range(k)):
        raise ValueError("matching must be a permutation of physical columns")
    t = R if k % 2 else K
    return [[t if j == matching[i] else I for j in range(k)] for i in range(k)]


def optimizer_count(k: int) -> int:
    """Number of labelled binary symplectic optimizers, excluding Clifford phases."""
    if k < 6:
        raise ValueError("the all-optimizer counting theorem requires k >= 6")
    return 6 ** (2 * k) * factorial(k) // (3 if k % 2 else 2)


def _valid_blocks(m: Any) -> bool:
    return (
        isinstance(m, list)
        and bool(m)
        and all(isinstance(row, list) and len(row) == len(m) for row in m)
        and all(type(a) is int and 0 <= a < 16 for row in m for a in row)
    )


def verify_certificate(m: list[list[int]], certificate: dict[str, Any]) -> bool:
    """Check a positive certificate in O(k^2), independently of the recognizer."""
    if not _valid_blocks(m) or len(m) < 6 or not isinstance(certificate, dict):
        return False
    k = len(m)
    p, left, right = (certificate.get(key) for key in ("matching", "left", "right"))
    if any(not isinstance(v, list) or len(v) != k for v in (p, left, right)):
        return False
    if any(type(a) is not int for a in p + left + right):
        return False
    if sorted(p) != list(range(k)) or any(a not in G for a in left + right):
        return False
    t = R if k % 2 else K
    if certificate.get("diagonal") != t:
        return False
    return all(
        m[i][j] == mul(mul(left[i], t if j == p[i] else I), right[j])
        for i in range(k)
        for j in range(k)
    )


def recognize_optimizer(m: list[list[int]]) -> dict[str, Any]:
    """Decide optimum membership for any binary block matrix, k >= 6.

    Positive answers carry a factorization certificate.  Negative answers
    identify a concrete necessary condition that failed.  No symplecticity
    promise is required: positive factorization itself implies symplecticity.
    """
    if not _valid_blocks(m):
        return {"accepted": False, "reason": "input is not a square four-bit block matrix"}
    k = len(m)
    if k < 6:
        raise ValueError("optimizer recognition here requires k >= 6")

    def reject(reason: str, **witness: Any) -> dict[str, Any]:
        return {"accepted": False, "reason": reason, "witness": witness}

    if k % 2:
        for i in range(k):
            for j in range(k):
                if m[i][j] not in INV:
                    return reject("odd-order optimizer has an invertible block at every position", row=i, column=j)
        exceptions: list[set[int]] = [set()]
        for i in range(1, k):
            ratios = [mul(m[0][j], INV[m[i][j]]) for j in range(k)]
            counts = Counter(ratios)
            if sorted(counts.values()) != [1, 1, k - 2]:
                return reject("row-ratio multiplicities are not k-2,1,1", rows=[0, i], counts=dict(counts))
            majority = next(a for a, count in counts.items() if count == k - 2)
            exceptions.append({j for j, a in enumerate(ratios) if a != majority})
        center = exceptions[1] & exceptions[2]
        if len(center) != 1:
            return reject("first two row-ratio exception sets do not determine one column", exceptions=[sorted(exceptions[1]), sorted(exceptions[2])])
        p0 = next(iter(center))
        p = [p0]
        for i in range(1, k):
            if p0 not in exceptions[i]:
                return reject("row-ratio exception sets have no common center", row=i, center=p0, exceptions=sorted(exceptions[i]))
            p.append(next(iter(exceptions[i] - {p0})))
        if sorted(p) != list(range(k)):
            return reject("recovered matching is not a permutation", matching=p)
    else:
        p = []
        for i in range(k):
            singular = []
            for j in range(k):
                rank = matrix_rank(m[i][j])
                if rank == 0:
                    return reject("optimizer has no zero block", row=i, column=j)
                if rank == 1:
                    singular.append(j)
            if len(singular) != 1:
                return reject("even-order row lacks exactly one rank-one block", row=i, singular_columns=singular)
            p.append(singular[0])
        if sorted(p) != list(range(k)):
            return reject("rank-one positions do not form a permutation matching", matching=p)

    # Normalize all off-matching blocks to identity, fixing the global gauge A_0=I.
    # The three-step construction is a spanning tree of K_{k,k} minus a matching.
    left = [I] * k
    right = [I] * k
    for j in range(k):
        if j != p[0]:
            right[j] = m[0][j]
    for i in range(1, k):
        anchor = next(j for j in range(k) if j not in (p[0], p[i]))
        left[i] = mul(m[i][anchor], INV[right[anchor]])
    right[p[0]] = mul(INV[left[1]], m[1][p[0]])
    for i in range(k):
        for j in range(k):
            if j != p[i] and m[i][j] != mul(left[i], right[j]):
                return reject("off-matching block factorization failed", row=i, column=j, expected=mul(left[i], right[j]), actual=m[i][j])

    residuals = [mul(mul(INV[left[i]], m[i][p[i]]), INV[right[p[i]]]) for i in range(k)]
    if len(set(residuals)) != 1:
        return reject("matching blocks have different normalized residuals", residuals=residuals)
    t = R if k % 2 else K
    common = residuals[0]
    conjugators = [g for g in G if mul(mul(INV[g], common), g) == t]
    if not conjugators:
        return reject("common matching residual is outside the required conjugacy class", residual=common, required=t)
    g = conjugators[0]
    certificate = {
        "diagonal": t,
        "matching": p,
        "left": [mul(a, g) for a in left],
        "right": [mul(INV[g], b) for b in right],
    }
    return {"accepted": True, "certificate": certificate}


def sample_optimizer(k: int, rng: random.Random) -> tuple[list[list[int]], dict[str, Any]]:
    """Exactly uniform provided rng's shuffle and choice are uniform.

    This is not a cryptographic sampler.  Equal-size centralizer fibers make
    independent uniform local factors and a matching uniform over matrices.
    """
    if k < 6:
        raise ValueError("sampling all optimizers here requires k >= 6")
    p = list(range(k))
    rng.shuffle(p)
    left = [rng.choice(G) for _ in range(k)]
    right = [rng.choice(G) for _ in range(k)]
    t = R if k % 2 else K
    m = [[mul(mul(left[i], t if j == p[i] else I), right[j]) for j in range(k)] for i in range(k)]
    return m, {"diagonal": t, "matching": p, "left": left, "right": right}


def is_symplectic(m: list[list[int]]) -> bool:
    """Direct O(k^3) independent test; used only by the test harness."""
    k = len(m)
    for i in range(k):
        for h in range(k):
            total = 0
            for j in range(k):
                total ^= mul(mul(m[i][j], J), transpose(m[h][j]))
            if total != (J if i == h else 0):
                return False
    return True


def from_bit_rows(rows: list[int]) -> list[list[int]]:
    """Convert interleaved x,z bit-packed rows to the four-bit block encoding."""
    if len(rows) % 2:
        raise ValueError("an even number of binary rows is required")
    k = len(rows) // 2
    return [[
        ((rows[2 * i] >> (2 * j)) & 1)
        | (((rows[2 * i + 1] >> (2 * j)) & 1) << 1)
        | (((rows[2 * i] >> (2 * j + 1)) & 1) << 2)
        | (((rows[2 * i + 1] >> (2 * j + 1)) & 1) << 3)
        for j in range(k)] for i in range(k)]


def _dephase_dense(m: list[list[int]]) -> tuple[int, ...]:
    """Put first row and column at I; residual equivalence is common conjugacy."""
    k = len(m)
    x = [[mul(m[i][j], INV[m[0][j]]) for j in range(k)] for i in range(k)]
    return tuple(mul(INV[x[i][0]], x[i][j]) for i in range(k) for j in range(k))


def _conjugates(d: tuple[int, ...]) -> set[tuple[int, ...]]:
    return {tuple(mul(mul(INV[g], a), g) for a in d) for g in G}


def self_test() -> dict[str, Any]:
    assert G == (6, 7, 9, 11, 13, 14)
    assert mul(R, R) == 7 and mul(mul(R, R), R) == I and mul(K, K) == 0
    assert all(mul(mul(a, b), c) == mul(a, mul(b, c)) for a in range(16) for b in range(16) for c in range(16))
    centralizers = {
        "odd": [g for g in G if mul(g, R) == mul(R, g)],
        "even": [g for g in G if mul(g, K) == mul(K, g)],
    }
    assert centralizers == {"odd": [7, 9, 14], "even": [6, 9]}
    assert all(is_symplectic(normal_matrix(k)) for k in range(2, 18))

    # Exhaust all relative matchings and residual gauges at three small odd
    # orders.  This independently detects the hidden k=3 symmetry and verifies
    # uniqueness at k=5,7 without using the recognition algorithm.
    dephased_orbits = []
    for k in (3, 5, 7):
        base = _dephase_dense(normal_matrix(k))
        base_class = _conjugates(base)
        matching_equivalences = 0
        normalized = set()
        for p in permutations(range(k)):
            d = _dephase_dense(normal_matrix(k, list(p)))
            matching_equivalences += int(d in base_class)
            normalized.update(_conjugates(d))
        assert matching_equivalences == (factorial(k) if k == 3 else 1)
        assert len(normalized) == (2 if k == 3 else 2 * factorial(k))
        dephased_orbits.append({
            "k": k,
            "relative_matchings_tested": factorial(k),
            "equivalent_to_identity_matching": matching_equivalences,
            "distinct_dense_dephased_matrices": len(normalized),
        })

    # Independent exhaustive count of the fixed-shift even suborbit.
    even_fixed_shift = []
    for k in (4, 6):
        distinct = set()
        for locals_ in product((I, J), repeat=2 * k):
            left, right = locals_[:k], locals_[k:]
            distinct.add(tuple(mul(mul(left[i], K if j == i else I), right[j]) for i in range(k) for j in range(k)))
        assert len(distinct) == 2 ** (2 * k - 1)
        even_fixed_shift.append({"k": k, "local_factor_tuples_tested": 2 ** (2 * k), "distinct_matrices": len(distinct)})

    rng = random.Random(20261125)
    recognition_checks = []
    for k in (6, 7, 8, 9, 12, 17):
        accepted, tamper_rejected, mutation_accepted, mutation_rejected = 0, 0, 0, 0
        for trial in range(80):
            m, original = sample_optimizer(k, rng)
            result = recognize_optimizer(m)
            assert result["accepted"] and verify_certificate(m, result["certificate"])
            assert result["certificate"]["matching"] == original["matching"]
            if trial < 3:
                assert is_symplectic(m)
            accepted += 1
            altered = [row[:] for row in m]
            altered[rng.randrange(k)][rng.randrange(k)] ^= rng.randrange(1, 16)
            assert not verify_certificate(altered, result["certificate"])
            tamper_rejected += 1
            result2 = recognize_optimizer(altered)
            if result2["accepted"]:
                assert verify_certificate(altered, result2["certificate"])
                mutation_accepted += 1
            else:
                mutation_rejected += 1
        recognition_checks.append({"k": k, "random_orbit_members_accepted": accepted, "altered_matrix_rejected_by_original_certificate": tamper_rejected, "mutations_accepted_with_valid_new_certificate": mutation_accepted, "mutations_rejected": mutation_rejected})

    # The old rank-only shortcut has exact symplectic counterexamples at k=6,9.
    # Six-site rows are Eq.(15) of even_optimizer_classification.md.  Nine-site
    # example is the F_4 tensor construction in odd_optimizer_classification.md.
    even_bad = from_bit_rows([1451, 3031, 1454, 3037, 1466, 3061, 3583, 2773, 4031, 2901, 3498, 4053])
    f = [[I, I, I], [I, R, mul(R, R)], [I, mul(R, R), R]]
    odd_bad = [[mul(f[i // 3][j // 3], f[i % 3][j % 3]) for j in range(9)] for i in range(9)]
    adversarial = []
    for name, m in (("even_k6_same_rank_pattern", even_bad), ("odd_k9_all_blocks_invertible", odd_bad)):
        assert is_symplectic(m)
        if len(m) % 2:
            assert all(a in G for row in m for a in row)
        else:
            assert all(matrix_rank(m[i][j]) == (1 if i == j else 2) for i in range(len(m)) for j in range(len(m)))
        result = recognize_optimizer(m)
        assert not result["accepted"]
        adversarial.append({"example": name, "symplectic": True, "rejection": result})

    return {
        "status": "passed",
        "scope": "all optimizer matrices k>=6; matrix count excludes Clifford phases; no CNOT optimum claim",
        "centralizers": centralizers,
        "dense_dephasing_exhaustion": dephased_orbits,
        "even_fixed_shift_exhaustion": even_fixed_shift,
        "recognition": recognition_checks,
        "adversarial": adversarial,
        "optimizer_counts": {str(k): optimizer_count(k) for k in range(6, 13)},
    }


def main() -> None:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--self-test", action="store_true")
    parser.add_argument("--input", type=Path, help="JSON k by k array of four-bit block integers")
    parser.add_argument("--output", type=Path, help="save exact JSON result as well as printing it")
    args = parser.parse_args()
    if args.self_test == (args.input is not None):
        parser.error("choose exactly one of --self-test or --input")
    result = self_test() if args.self_test else recognize_optimizer(json.loads(args.input.read_text()))
    rendered = json.dumps(result, indent=2, sort_keys=True) + "\n"
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(rendered)
    print(rendered, end="")


if __name__ == "__main__":
    main()
