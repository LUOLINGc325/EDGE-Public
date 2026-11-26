"""Independent certificate checker: no simplex or exact_ldp import.

Checks rational primal/dual inequalities directly.  Its prototype generator
uses coordinate words with a zero symbol, independently of reproduce.py.
"""

from fractions import Fraction as F
from itertools import product
import json
from pathlib import Path


HERE = Path(__file__).resolve().parent


def prototypes(k, e):
    result = set()
    if e == 1:
        for word in product([0, 1], repeat=k):
            if sum(word):
                result.add(tuple(F(x, sum(word)) for x in word))
        return result
    for word in product(range(-1, k), repeat=k):
        heights = {x for x in word if x >= 0}
        if not heights or heights != set(range(max(heights) + 1)):
            continue
        support_size = sum(x >= 0 for x in word)
        if len(heights) == 1 and support_size != 1:
            continue
        values = [e**x if x >= 0 else F(0) for x in word]
        total = sum(values)
        result.add(tuple(x / total for x in values))
    return result


def pos(x):
    return max(F(0), x)


def verify_lp(c):
    k, e = c["k"], F(c["E"])
    r = [tuple(map(F, ray)) for ray in c["rays"]]
    assert len(r) == len(set(r)) and set(r) == prototypes(k, e)
    x = list(map(F, c["primal"]))
    lam = list(map(F, c["dual_equalities"]))
    beta = list(map(F, c["dual_inequalities"]))
    pp = [tuple(p) for p in c["ordered_pairs"]]
    delta = list(map(F, c["budgets"]))
    assert pp == [(i, j) for i in range(k) for j in range(k) if i != j]
    assert len(x) == len(r) and len(lam) == k
    assert len(beta) == len(delta) == k * (k - 1)
    assert all(a >= 0 for a in x) and all(b >= 0 for b in beta)
    assert all(sum(a * ray[i] for a, ray in zip(x, r)) == 1 for i in range(k))
    assert all(
        sum(a * pos(ray[i] - e * ray[j]) for a, ray in zip(x, r)) <= d
        for (i, j), d in zip(pp, delta)
    )
    utility = [sum(z * z for z in ray) for ray in r]
    dual_columns = [
        sum(lam[i] * ray[i] for i in range(k))
        + sum(b * pos(ray[i] - e * ray[j]) for (i, j), b in zip(pp, beta))
        for ray in r
    ]
    assert all(a >= b for a, b in zip(dual_columns, utility))
    primal_value = sum(a * u for a, u in zip(x, utility))
    dual_value = sum(lam) + sum(b * d for b, d in zip(beta, delta))
    assert primal_value == dual_value == F(c["objective"])
    assert primal_value - 1 == F(c["chi_square_mutual_information"])
    assert sum(a > 0 for a in x) <= k * k


def verify_channel(c, common=True):
    k, e = c["k"], F(c["E"])
    columns = [tuple(map(F, v)) for v in c["columns"]]
    assert all(len(v) == k and all(x >= 0 for x in v) for v in columns)
    assert all(sum(v[i] for v in columns) == 1 for i in range(k))
    losses = {(i, j): sum(pos(v[i] - e * v[j]) for v in columns)
              for i in range(k) for j in range(k) if i != j}
    if common:
        assert set(losses.values()) == {F(c["common_delta"])}
    else:
        assert losses == {(i, j): F(d) for i, j, d in c["losses"]}
    for v in columns:
        support = {i for i in range(k) if v[i] > 0}
        if not support:
            continue
        reached = {next(iter(support))}
        while True:
            extended = reached | {
                j for i in reached for j in support
                if v[i] == e * v[j] or v[j] == e * v[i]
            }
            if extended == reached:
                break
            reached = extended
        assert reached == support


def main():
    result = json.loads((HERE.parent / "results" / "certificates.json").read_text())
    for c in result["ray_enumeration"]:
        assert len(prototypes(c["k"], F(c["E"]))) == c["candidate_count"]
    for c in result["utility_lp_certificates"]:
        verify_lp(c)
    verify_channel(result["three_level_orbit_example"])
    verify_channel(result["three_level_cyclic_example"], common=False)
    for c in result["all_prototype_channels"]:
        if "columns" in c:
            verify_channel(c)
    print("PASS: independent rational verification of all LP primal/dual certificates,")
    print("all listed prototype counts, the explicit three-level examples, and stored all-prototype channels.")


if __name__ == "__main__":
    main()
