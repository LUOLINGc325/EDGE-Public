#!/usr/bin/env python3
"""Exhaustive finite certificates for prime-field product Pauli axes."""

from collections import Counter, defaultdict
from itertools import product
import json


def audit(q, n):
    local = tuple(product(range(q), repeat=2))
    points = tuple(product(local, repeat=n))
    zero = points[0]
    index = {point: i for i, point in enumerate(points)}
    axes = [(1, slope) for slope in range(q)] + [(0, 1)]
    choices = tuple(product(axes, repeat=n))

    def pairing(left, right):
        return sum(a * d - b * c for (a, b), (c, d) in zip(left, right)) % q

    def full(point):
        return all(axis != (0, 0) for axis in point)

    def coset_add(left, right, scalar):
        return index[tuple(((a + scalar * c) % q, (b + scalar * d) % q)
                           for (a, b), (c, d) in zip(left, right))]

    orthogonal = [frozenset(j for j, y in enumerate(points) if pairing(x, y) == 0)
                  for x in points]
    additions = [[coset_add(x, y, 1) for y in points] for x in points]
    multiples = [[coset_add(zero, x, scale) for scale in range(q)] for x in points]
    masks = [sum(1 << j for j, setting in enumerate(choices)
                 if all((a * d - b * c) % q == 0
                        for (a, b), (c, d) in zip(point, setting)))
             for point in points]
    support = [[i for i, axis in enumerate(point) if axis != (0, 0)] for point in points]
    levels = {frozenset({0}): frozenset(range(len(points)))}
    report = []
    for rank in range(n):
        next_level = {}
        counts = Counter()
        phase_ranges = defaultdict(Counter)
        lower = q ** rank
        upper = (q + 1) ** n - q ** (rank + 1) * (q + 1) ** (n - rank - 1)
        for stabilizer, perp in levels.items():
            unseen = set(perp - stabilizer)
            logical = {}
            while unseen:
                g = min(unseen)
                coset = {additions[g][s] for s in stabilizer}
                unseen.difference_update(coset)
                cover = 0
                for x in coset:
                    cover |= masks[x]
                    logical[x] = (g, coset)
                count = cover.bit_count()
                assert lower <= count <= upper
                assert (count == lower) == all(full(points[x]) for x in coset)
                if rank:
                    second = (q + 1) * q ** (rank - 1)
                    local_factors = {support[s][0] for s in stabilizer if len(support[s]) == 1}
                    runnerup = any(all(i in support[x] for x in coset for i in range(n) if i != j)
                                   for j in local_factors)
                    assert (count == second) == runnerup
                    assert count == lower or count >= second
                d = rank + 1
                one_site_reps = {support[x][0] for x in coset if len(support[x]) == 1}
                assert (count == upper) == (len(one_site_reps) == d)
                counts[count] += 1
                if rank + 1 < n:
                    enlarged = frozenset(additions[x][s] for x in multiples[g] for s in stabilizer)
                    next_level.setdefault(enlarged, perp & orthogonal[g])
            if (q, n) in {(2, 2), (2, 3), (3, 2)}:
                reps = sorted({g for g, _ in logical.values()})
                c_masks = {}
                for g in reps:
                    get_coset = logical[g][1]
                    mask = 0
                    for x in get_coset:
                        mask |= masks[x]
                    c_masks[g] = mask
                for z, x in product(reps, repeat=2):
                    if x in orthogonal[z]:
                        continue
                    slopes = set()
                    union = 0
                    for multiple in multiples[z]:
                        v = logical[additions[x][multiple]][0]
                        assert v not in slopes and not (union & c_masks[v])
                        slopes.add(v)
                        union |= c_masks[v]
                    f = union.bit_count()
                    assert f >= q ** (rank + 1)
                    phase_ranges[rank][f] += 1
        assert min(counts) == lower and max(counts) == upper
        if rank:
            assert min(c for c in counts if c > lower) == (q + 1) * q ** (rank - 1)
        if phase_ranges[rank]:
            assert min(phase_ranges[rank]) == q ** (rank + 1)
        report.append({"rank": rank, "stabilizer_spaces": len(levels),
                       "visible_setting_histogram": dict(sorted(counts.items())),
                       "phase_setting_histogram": dict(sorted(phase_ranges[rank].items()))})
        levels = next_level
    return {"field": q, "sites": n, "settings": len(choices), "data": report}


if __name__ == "__main__":
    parameters = [(2, n) for n in range(1, 5)] + [(3, n) for n in (1, 2)] + [(5, 2)]
    print(json.dumps([audit(q, n) for q, n in parameters], indent=2))
