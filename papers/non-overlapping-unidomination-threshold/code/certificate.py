"""Exact arithmetic and finite graph checks for the threshold classification."""

from fractions import Fraction
from itertools import combinations, combinations_with_replacement
from math import isqrt
from random import Random


def threshold(c, n):
    radicand = c.numerator ** 2 * n
    base = isqrt(radicand) // c.denominator
    return base + int((base * c.denominator) ** 2 < radicand)


def calibration(c, order, target):
    def difference(t):
        return threshold(c, order + t) - target - t

    initial = difference(0)
    assert initial > 0
    lower, upper = 0, 2 * initial + 2
    assert difference(upper) <= 0
    while upper - lower > 1:
        middle = (lower + upper) // 2
        if difference(middle) > 0:
            lower = middle
        else:
            upper = middle
    assert difference(upper) == 0 and difference(upper - 1) == 1
    return upper


def check_threshold(c, order, target):
    extra = calibration(c, order, target)
    new_order = order + extra
    for delta in range(-3, 4):
        cost = target + delta + extra
        actual = (c.denominator * cost) ** 2 >= c.numerator ** 2 * new_order
        assert actual == (delta >= 0)
    if extra <= 200:
        assert all(0 <= threshold(c, order + j + 1) - threshold(c, order + j) <= 1
                   for j in range(extra))


def tuning_checks():
    tested = 0
    for p in (1, 8, 9, 16, 31, 100):
        for c in map(Fraction, ("1.0001", "1.01", "1.1", "1.5", "2", "2.25",
                                "2.5", "2.9", "3.5", "3.99", "4", "6.25")):
            q = 2
            while q < c or (c - 1) * q < 8 * p:
                q *= 2
            check_threshold(c, p ** 2 + q ** 2 + q + 1, 4 * p + q + 2)
            tested += 1
            if c > 2:
                q = max(1, threshold(c, 1), threshold(8 * p / (c - 2), 1))
                check_threshold(c, p ** 2 + q ** 2 + q, 4 * p + 2 * q)
                tested += 1
    return tested


def field_multiply(a, b, order, modulus):
    result = 0
    while b:
        if b & 1:
            result ^= a
        a <<= 1
        if a & order:
            a ^= modulus
        b >>= 1
    return result


def check_polarity(order, modulus):
    points = ([(1, x, y) for x in range(order) for y in range(order)]
              + [(0, 1, y) for y in range(order)] + [(0, 0, 1)])
    multiplication = [[field_multiply(a, b, order, modulus) for b in range(order)]
                      for a in range(order)]
    closed = [1 << u for u in range(len(points))]
    for u, v in combinations(range(len(points)), 2):
        a, b, c = points[u]
        x, y, z = points[v]
        if multiplication[a][x] ^ multiplication[b][y] ^ multiplication[c][z] == 0:
            closed[u] |= 1 << v
            closed[v] |= 1 << u
    assert len(points) == order ** 2 + order + 1
    assert max(mask.bit_count() for mask in closed) == order + 2
    assert all(a & b for a, b in combinations(closed, 2))


def split_closed(k, incidence_masks):
    n = k + len(incidence_masks)
    clique_mask = (1 << k) - 1
    closed = [clique_mask] * k
    for i, mask in enumerate(incidence_masks, k):
        closed.append(mask | (1 << i))
        for u in range(k):
            if mask & (1 << u):
                closed[u] |= 1 << i
    assert len(closed) == n
    return closed


def exhaustive_packing(closed):
    def recurse(vertex, used):
        if vertex == len(closed):
            return used.bit_count()
        result = recurse(vertex + 1, used)
        if not closed[vertex] & used:
            result = max(result, recurse(vertex + 1, used | closed[vertex]))
        return result

    return recurse(0, 0)


def split_optimum_oracle(k, masks):
    """Unrestricted exact oracle on distinct high-degree neighborhood types."""
    isolates = masks.count(0)
    types = set(masks) - {0}
    leaves = {mask for mask in types if mask.bit_count() == 1}
    high = [mask for mask in types if mask.bit_count() >= 2]

    def recurse(i, occupied, score):
        if i == len(high):
            return score + 2 * sum(not mask & occupied for mask in leaves)
        best = recurse(i + 1, occupied, score)
        mask = high[i]
        if not occupied & mask:
            best = max(best, recurse(i + 1, occupied | mask, score + 1 + mask.bit_count()))
        return best

    maximum_incidence = max(sum(bool(mask & (1 << v)) for mask in masks) for v in range(k))
    return isolates + max(k + maximum_incidence, recurse(0, 0, 0))


def split_boundary(k, masks):
    n = k + len(masks)
    isolates = masks.count(0)
    degrees = [sum(bool(mask & (1 << v)) for mask in masks) for v in range(k)]
    d = max(degrees)
    clique_score = isolates + k + d
    if clique_score ** 2 >= 4 * n:
        return True, False
    if k < 16:
        return exhaustive_packing(split_closed(k, masks)) ** 2 >= 4 * n, False

    deficit = k * d - (len(masks) - isolates)
    assert 4 * deficit < 4 * k - (k - d) ** 2
    leaves = {mask for mask in masks if mask.bit_count() == 1}
    bad = ((1 << k) - 1) ^ sum(leaves)
    assert bad.bit_count() * d <= 2 * deficit
    assert bad.bit_count() < 4
    usable = {mask for mask in masks if mask.bit_count() > 1 and mask & bad}

    best = clique_score
    for size in range(bad.bit_count() + 1):
        for choice in combinations(usable, size):
            occupied = 0
            score = isolates
            for mask in choice:
                if occupied & mask:
                    break
                occupied |= mask
                score += 1 + mask.bit_count()
            else:
                score += 2 * sum(not occupied & mask for mask in leaves)
                best = max(best, score)
    return best ** 2 >= 4 * n, True


def check_split_boundary():
    exhaustive = 0
    for k in range(2, 5):
        for side in range(5):
            for masks in combinations_with_replacement(range(1 << k), side):
                exact = exhaustive_packing(split_closed(k, masks))
                assert exact == split_optimum_oracle(k, masks)
                found, _ = split_boundary(k, masks)
                assert found == (exact ** 2 >= 4 * (k + side))
                assert (exact + 1) ** 2 >= 4 * (k + side)
                exhaustive += 1
    rng = Random(20261124)
    seeded = 0
    inspected_boundary = 0
    seen_truth = set()
    for k in (16, 17, 18, 19, 20, 24, 30):
        for desired_degree in (k - 2, k - 1, k, k + 1, k + 2):
            for _ in range(12):
                incidences = [0] * k
                high_masks = []
                if rng.random() < .6:
                    for _ in range(desired_degree):
                        other = rng.randrange(1, k)
                        high_masks.append(1 | (1 << other))
                        incidences[0] += 1
                        incidences[other] += 1
                else:
                    for _ in range(rng.randrange(5)):
                        u, v = rng.sample(range(k), 2)
                        high_masks.append((1 << u) | (1 << v))
                        incidences[u] += 1
                        incidences[v] += 1
                masks = list(high_masks)
                for vertex, amount in enumerate(incidences):
                    copies = desired_degree - amount
                    masks.extend([1 << vertex] * copies)
                masks.extend([0] * rng.randrange(3))
                expected = split_optimum_oracle(k, masks) ** 2 >= 4 * (k + len(masks))
                found, used_boundary = split_boundary(k, masks)
                assert found == expected
                if used_boundary:
                    seen_truth.add(found)
                    inspected_boundary += 1
                seeded += 1
    assert seen_truth == {False, True}
    return exhaustive, seeded, inspected_boundary


def compatible_sets(masks, weights):
    def recurse(i, union):
        if i == len(masks):
            return 0
        best = recurse(i + 1, union)
        if not union & masks[i]:
            best = max(best, weights[i] + recurse(i + 1, union | masks[i]))
        return best

    return recurse(0, 0)


def check_split_join():
    count = 0
    rng = Random(177)
    for _ in range(60):
        k, q = rng.randrange(3, 6), rng.randrange(1, 4)
        base = [rng.randrange(1, 1 << k) for _ in range(rng.randrange(5))]
        filler = [1 << u for u in range(k, k + q) for _ in range(q)]
        masks = base + filler
        old_best = compatible_sets(base, [1 + mask.bit_count() for mask in base])
        joined_clique = max(mask.bit_count() for mask in split_closed(k + q, masks)[:k + q])
        expected = max(joined_clique, old_best + 2 * q)
        assert exhaustive_packing(split_closed(k + q, masks)) == expected
        count += 1
    return count


def main():
    tunings = tuning_checks()
    for order, modulus in ((2, 0b11), (4, 0b111), (8, 0b1011), (16, 0b10011)):
        check_polarity(order, modulus)
    full, seeded, difficult = check_split_boundary()
    joins = check_split_join()
    print("Exact rational threshold calibrations:", tunings)
    print("Explicit polarity graph orders q: 2, 4, 8, 16")
    print("Exhaustive small split instances:", full)
    print("Seeded large split instances:", seeded, "including boundary branch:", difficult)
    print("Exact split clique joins:", joins)
    print("All threshold, polarity and split packing checks passed.")


if __name__ == "__main__":
    main()
