#!/usr/bin/env python3
"""Finite certificate for the split isometric-path-cover reduction."""

from itertools import combinations, product
from random import Random


def indices(mask):
    while mask:
        bit = mask & -mask
        yield bit.bit_length() - 1
        mask ^= bit


def source_solution(q, triples):
    for chosen in combinations(range(len(triples)), q):
        if all(len({triples[i][column] for i in chosen}) == q for column in range(3)):
            return chosen
    return None


def split_model(q, triples):
    """Split graph represented by the ordered independent vertices' clique neighborhoods."""
    count = len(triples)
    top_count = 2 * q + 2 * count
    real_count = 2 * q + count
    real = [0] * top_count
    intended = set()
    for x in range(q):
        real[x] = 1 << x
    for i, (x, y, z) in enumerate(triples):
        p, g, c = 2 * q + 2 * i, 2 * q + 2 * i + 1, 2 * q + i
        real[p] = (1 << c) | (1 << (q + y))
        real[g] = 1 << c
        real[q + z] |= 1 << c
        intended.add((x, p))

    actual = list(real)
    next_clique = real_count
    for u, v in combinations(range(top_count), 2):
        if (u, v) not in intended:
            bit = 1 << next_clique
            actual[u] |= bit
            actual[v] |= bit
            next_clique += 1
    for u in range(top_count):
        actual[u] |= 1 << next_clique
        next_clique += 1

    dummies = next_clique - real_count
    filler_mask = ((1 << dummies) - 1) << real_count
    actual.extend([filler_mask] * (2 * dummies))
    return actual, real, next_clique, dummies, intended


def real_path_masks(neighborhoods, real):
    """Enumerate geodesics with two core endpoints and only real internal vertices."""
    masks = set()
    top_count = len(real)
    for u, v in combinations(range(top_count), 2):
        endpoints = (1 << u) | (1 << v)
        shared = neighborhoods[u] & neighborhoods[v]
        if shared:
            for middle in indices(real[u] & real[v]):
                masks.add(endpoints | (1 << (top_count + middle)))
        else:
            for a, b in product(indices(real[u]), indices(real[v])):
                masks.add(endpoints | (1 << (top_count + a)) | (1 << (top_count + b)))
    return masks


def exact_path_partition(size, paths):
    """Exact-cover search over the graph's admissible core geodesics."""
    all_vertices = (1 << size) - 1
    containing = [[] for _ in range(size)]
    for path in paths:
        for vertex in indices(path):
            containing[vertex].append(path)
    failed = set()

    def visit(used):
        if used == all_vertices:
            return True
        if used in failed:
            return False
        viable = [
            [path for path in containing[vertex] if not path & used]
            for vertex in indices(all_vertices ^ used)
        ]
        options = min(viable, key=len)
        if any(visit(used | path) for path in options):
            return True
        failed.add(used)
        return False

    return visit(0)


def check_witness(q, triples, chosen, neighborhoods, real, clique_count, dummies):
    top_count = len(neighborhoods)
    real_count = clique_count - dummies
    core_count = len(real)
    chosen = set(chosen)
    paths = []
    for i, (x, y, z) in enumerate(triples):
        p, g, c = 2 * q + 2 * i, 2 * q + 2 * i + 1, top_count + 2 * q + i
        if i in chosen:
            paths.extend(((x, top_count + x, top_count + q + y, p), (g, c, q + z)))
        else:
            paths.append((p, c, g))
    for j in range(dummies):
        paths.append((core_count + 2 * j, top_count + real_count + j, core_count + 2 * j + 1))

    assert len(paths) == top_count // 2
    assert set(range(top_count + clique_count)) == {v for path in paths for v in path}
    for path in paths:
        a, b = path[0], path[-1]
        distance = 2 if neighborhoods[a] & neighborhoods[b] else 3
        assert len(path) - 1 == distance
        assert neighborhoods[a] & (1 << (path[1] - top_count))
        assert neighborhoods[b] & (1 << (path[-2] - top_count))


def check(q, triples):
    neighborhoods, real, clique_count, dummies, intended = split_model(q, triples)
    core_count = len(real)
    assert len(neighborhoods) == 2 * (len(triples) + q + dummies)
    assert clique_count == len(neighborhoods) // 2 + q
    for u, v in combinations(range(core_count), 2):
        assert (neighborhoods[u] & neighborhoods[v] == 0) == ((u, v) in intended)
    common_filler = neighborhoods[-1]
    assert all(n & common_filler for n in neighborhoods)

    known = source_solution(q, triples)
    paths = real_path_masks(neighborhoods, real)
    exists = exact_path_partition(core_count + clique_count - dummies, paths)
    assert exists == (known is not None), (q, triples)
    if exists:
        check_witness(q, triples, known, neighborhoods, real, clique_count, dummies)
    return exists


def main():
    total, feasible = 0, 0
    for q in (1, 2):
        candidates = tuple(product(range(q), repeat=3))
        for mask in range(1 << len(candidates)):
            triples = [triplet for i, triplet in enumerate(candidates) if mask & (1 << i)]
            total += 1
            feasible += check(q, triples)
    print(f"exhaustive 3DM sources: {total} passed; {feasible} satisfiable", flush=True)

    rng = Random(7242024)
    feasible = 0
    for _ in range(160):
        q = rng.choice((3, 4))
        candidates = tuple(product(range(q), repeat=3))
        density = rng.choice((0.10, 0.20, 0.28))
        triples = [t for t in candidates if rng.random() < density]
        feasible += check(q, triples)
    print(f"seeded 3DM sources: 160 passed; {feasible} satisfiable")


if __name__ == "__main__":
    main()
