"""Finite checks for the common-highest-item EFX manuscript."""

import argparse
import itertools
import json
import random
from collections import Counter
from functools import cache
from pathlib import Path


def subsets(items, size):
    return list(itertools.combinations(items, size))


def valid(allocation, values, factor):
    for person, own_bundle in enumerate(allocation):
        own = factor * values[person](own_bundle)
        for bundle in allocation:
            for item in bundle:
                if own < values[person](bundle - {item}):
                    return False
    return True


def construct(values, goods, top, factor):
    remaining = set(goods) - {top}
    people = set(range(len(values)))
    bundles = [frozenset() for _ in people]
    top_values = [value({top}) for value in values]

    def favorite_pair(person, pool):
        return set(max(subsets(sorted(pool), 2), key=values[person]))

    while len(people) > 1:
        for person in sorted(people):
            pair = favorite_pair(person, remaining)
            if values[person](pair) >= top_values[person]:
                bundles[person] = pair
                remaining.difference_update(pair)
                people.remove(person)
                break
        else:
            break
    if len(people) == 1:
        bundles[next(iter(people))] = remaining | {top}
        assert valid(bundles, values, 1)
        return bundles, "all_pairs"

    for top_holder in sorted(people):
        trial = list(bundles)
        trial[top_holder] = {top}
        pool = set(remaining)
        ordinary_people = sorted(people - {top_holder})
        for person in ordinary_people[:-1]:
            trial[person] = favorite_pair(person, pool)
            pool.difference_update(trial[person])
        assert len(pool) == 3
        trial[ordinary_people[-1]] = pool
        if valid(trial, values, factor):
            return trial, "singleton_and_triple"
    raise AssertionError("No verified fallback despite the stated promise.")


def lower_conditions(value, ordinary, scale):
    highest = max(value({item}) for item in ordinary)
    every_pair = all(scale * value(pair) >= highest for pair in subsets(ordinary, 2))
    every_triple = all(scale * value(triple) >= highest for triple in subsets(ordinary, 3))
    every_five = all(any(scale * value(pair) >= highest for pair in subsets(five, 2))
                     for five in subsets(ordinary, 5))
    return every_pair, every_triple, every_five


def sampled_value(rng, ordinary, top, scale, force_fallback, exceptional):
    singles = {item: rng.randrange(8) for item in ordinary}
    highest = max(singles.values())
    singles[top] = 30 if force_fallback else highest + 1
    bad_triangle = set(rng.sample(ordinary, 3))
    pairs = {}
    triples = {}
    for pair in subsets(ordinary, 2):
        if not exceptional and not set(pair) <= bad_triangle:
            pairs[pair] = (highest + scale - 1) // scale
        if rng.randrange(3) == 0 and not force_fallback:
            pairs[pair] = max(pairs.get(pair, 0), rng.randrange(10, 20))
    for triple in subsets(ordinary, 3):
        if not exceptional:
            triples[triple] = (highest + scale - 1) // scale + rng.randrange(4)

    def value(bundle):
        return evaluate(tuple(sorted(bundle)))

    @cache
    def evaluate(bundle):
        value = max((singles[item] for item in bundle), default=0)
        value = max(value, max((pairs.get(pair, 0) for pair in itertools.combinations(bundle, 2)), default=0))
        return max(value, max((triples.get(triple, 0) for triple in itertools.combinations(bundle, 3)), default=0))

    return value


def check_constructive():
    rng = random.Random(35487)
    stats = Counter()
    for n in range(2, 8):
        goods = tuple(range(2 * n))
        ordinary, top = goods[:-1], goods[-1]
        for numbered in range(24):
            scale = 1 if numbered % 3 else 2
            exception = numbered % n if numbered % 2 else None
            values = [sampled_value(rng, ordinary, top, scale, numbered % 2 == 1, person == exception)
                      for person in range(n)]
            assert all(v({top}) >= max(v({item}) for item in ordinary) for v in values)
            conditions = [lower_conditions(v, ordinary, scale) for v in values]
            assert sum(not (triple and five) for pair, triple, five in conditions) <= 1
            allocation, branch = construct(values, goods, top, scale)
            assert set().union(*allocation) == set(goods)
            assert sum(map(len, allocation)) == len(goods)
            assert valid(allocation, values, scale)
            stats[branch] += 1
            stats["some_double_bound_fails"] += not all(row[0] for row in conditions)
            stats["genuine_exception"] += any(not (row[1] and row[2]) for row in conditions)
    assert stats["all_pairs"] and stats["singleton_and_triple"] and stats["genuine_exception"]
    return stats


def group_by_owner(owners, n):
    bundles = [set() for _ in range(n)]
    for item, index in enumerate(owners):
        bundles[index].add(item)
    return bundles


def verify_three_dimensional_matching():
    summary = Counter()
    for r in (1, 2):
        n, m = r + 1, 2 * r + 2
        top = m - 1
        choices = list(itertools.product(range(r), repeat=3))
        allocations = []
        for owners in itertools.product(range(n), repeat=m):
            allocation = group_by_owner(owners, n)
            if len(allocation[owners[top]]) >= 2:
                allocations.append(allocation)
        permutations = list(itertools.permutations(range(r)))
        for mask in range(1 << len(choices)):
            triples = {triple for j, triple in enumerate(choices) if mask & (1 << j)}
            perfect = any(all((xs[z], ys[z], z) in triples for z in range(r))
                          for xs in permutations for ys in permutations)
            values = []
            for z in range(n):
                edges = [set((x, r + y)) for x, y, zz in triples if zz == z]

                def value(bundle, edges=edges):
                    bundle = set(bundle)
                    if top in bundle or any(edge <= bundle for edge in edges):
                        return 2
                    return int(bool(bundle))

                values.append(value)
            possible = any(valid(allocation, values, 1) for allocation in allocations)
            assert possible == perfect
            summary["instances"] += 1
            summary["positive_instances"] += possible
            allocation, branch = construct(values, range(m), top, 1)
            assert valid(allocation, values, 1)
            summary["constructive_fallback_despite_perfect_matching"] += possible and branch != "all_pairs"
    assert summary["constructive_fallback_despite_perfect_matching"] > 0
    return summary


def partitions(k):
    def add(remaining, current):
        if not remaining:
            yield tuple(frozenset(block) for block in current)
            return
        item, *rest = remaining
        for j in range(len(current)):
            current[j].add(item)
            yield from add(rest, current)
            current[j].remove(item)
        current.append({item})
        yield from add(rest, current)
        current.pop()

    return add(list(range(k)), [])


def check_formation_counts():
    counts = Counter(len(p) for p in partitions(7))
    assert (counts[1], counts[2], counts[3]) == (1, 63, 301)
    perfect_pair_counts = sum(len(p) == 4 and all(len(b) == 2 for b in p)
                              for p in partitions(8))
    assert perfect_pair_counts == 105
    return {"all_pairs": perfect_pair_counts, "top_singleton_nonempty": counts[3],
            "top_singleton_empties_allowed": counts[1] + counts[2] + counts[3]}


def check_scope_examples():
    top, high = 7, 6
    ordinary = tuple(range(7))

    def old_only(bundle):
        return 3 if top in bundle else 2 if high in bundle else int(bool(bundle))

    def new_only(bundle):
        return 3 if len(bundle) >= 2 else 2 if top in bundle else int(bool(bundle))

    def triples_and_fives_only(bundle):
        bundle = set(bundle)
        if top in bundle:
            return 3
        if high in bundle or {0, 1, 2} <= bundle or len(bundle) >= 2 and not bundle <= {0, 1, 2}:
            return 2
        return int(bool(bundle))

    assert max(old_only(pair) for pair in subsets(ordinary, 2)) <= old_only({top})
    assert lower_conditions(old_only, ordinary, 1) == (False, False, False)
    assert max(new_only(pair) for pair in subsets(ordinary, 2)) > new_only({top})
    assert lower_conditions(new_only, ordinary, 1) == (True, True, True)
    assert lower_conditions(triples_and_fives_only, ordinary, 1) == (False, True, True)
    for n in (3, 4):
        top, high = 2 * n - 1, 2 * n - 2
        for scale in (2, 3):
            def value(bundle):
                return scale + 1 if top in bundle else scale if high in bundle else int(bool(bundle))

            for partition in partitions(2 * n):
                if sorted(map(len, partition)) in ([2] * n, [1] + [2] * (n - 2) + [3]):
                    assert not valid(partition, [value] * n, scale - 1)
            ordinary_items = set(range(2 * n)) - {top, high}
            ordinary_bundles = [{ordinary_items.pop()} for _ in range(n - 3)] + [ordinary_items]
            assert valid([{top}, {high}, *ordinary_bundles], [value] * n, 1)
    return {"incomparable_witnesses": 2, "triple_five_strict_witnesses": 1,
            "sharpness_configurations": 4}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    options = parser.parse_args()
    result = {
        "status": "PASS",
        "sampled_constructive": check_constructive(),
        "three_dimensional_matching": verify_three_dimensional_matching(),
        "partition_counts": check_formation_counts(),
        "scope_witnesses": check_scope_examples(),
    }
    serialized = json.dumps(result, indent=2, sort_keys=True) + "\n"
    if options.output:
        options.output.write_text(serialized)
    print(serialized, end="")


if __name__ == "__main__":
    main()
