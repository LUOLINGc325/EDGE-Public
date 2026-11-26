#!/usr/bin/env python3
"""Construct allocations and check the chore-EFX and exact EF guarantees."""
from collections import deque
from itertools import product
import json
from pathlib import Path
from random import Random


def balanced_bundles(agent_count, item_count):
    return [list(range(i, item_count, agent_count)) for i in range(agent_count)]


def allocate_rank_two(agent_count, distinguished_classes):
    """Index the distinguished agent by 0, with one class label per chore."""
    item_count = len(distinguished_classes)
    if item_count < 2 * agent_count - 1:
        return balanced_bundles(agent_count, item_count)
    classes = {}
    for item, label in enumerate(distinguished_classes):
        classes.setdefault(label, []).append(item)
    groups = deque(classes.values())
    others = []
    while len(groups) > 1 and len(others) < agent_count - 1:
        first, last = groups[0], groups[-1]
        others.append([first.pop(), last.pop()])
        if not first:
            groups.popleft()
        if not last:
            groups.pop()
    remaining = [item for group in groups for item in group]
    while len(others) < agent_count - 1:
        others.append([remaining.pop()])
    return [remaining, *others]


def allocate_anchors(anchors, extras, pivot_rank):
    """Find greedy rank-extending pairs, giving unmatched extras to agent 0."""
    agent_count = len(anchors)
    size = len(anchors[0])
    used = set()
    unmatched = []
    paired = []
    for anchor in anchors:
        extra = None
        if len(paired) < agent_count - 1:
            extra = next((item for item in extras if item not in used
                          and pivot_rank(anchor + [item]) == size + 1), None)
        if extra is None:
            unmatched.append(anchor)
        else:
            used.add(extra)
            paired.append(anchor + [extra])
    pivot_bundle = unmatched[0] + [item for item in extras if item not in used]
    return [pivot_bundle, *paired, *unmatched[1:]]


def allocate_sparse_universal(agent_count, item_count, costs, universal):
    """Use the zero-cost ownership invariant when there are few universal chores."""
    bundles = [[] for _ in range(agent_count)]
    for item in range(item_count):
        if item not in universal:
            owner = next(i for i, cost in enumerate(costs) if not cost([item]))
            bundles[owner].append(item)
    for item in sorted(universal):
        owner = next(i for i, bundle in enumerate(bundles)
                     if not costs[i](bundle))
        if bundles[owner]:
            witness = next((i for i, bundle in enumerate(bundles)
                            if i != owner and not costs[owner](bundle)), None)
            if witness is not None:
                bundles[owner].extend(bundles[witness])
                bundles[witness] = [item]
                continue
        bundles[owner].append(item)
    return bundles


def allocate_two_colors(agent_count, words):
    """Allocate against two-color costs, using one bit per observing agent."""
    item_count = len(words)
    if item_count < agent_count:
        return balanced_bundles(agent_count, item_count)
    all_bits = (1 << agent_count) - 1
    groups = {}
    support = set(words)
    missing = next((word for word in range(min(item_count + 1, all_bits + 1))
                    if word not in support), None)
    bundles = [[] for _ in range(agent_count)]
    if missing is None:
        for item, word in enumerate(words):
            nonpivot = word & ~1
            recipient = (nonpivot & -nonpivot).bit_length() - 1 if nonpivot else 0
            bundles[recipient].append(item)
        return bundles

    for item, word in enumerate(words):
        different = word ^ missing
        bit = (different & -different).bit_length() - 1
        bundles[bit].append(item)
    donors = deque(i for i, bundle in enumerate(bundles) if len(bundle) > 1)
    for bundle in bundles:
        if not bundle:
            source = bundles[donors[0]]
            bundle.append(source.pop())
            if len(source) == 1:
                donors.popleft()
    return bundles


def check(bundles, costs, item_count, *, full_envy_free=False):
    assert sorted(item for bundle in bundles for item in bundle) == list(range(item_count))
    for i, own in enumerate(bundles):
        if not own:
            continue
        trims = [own[:j] + own[j + 1:] for j in range(len(own))]
        for j, other in enumerate(bundles):
            if i != j:
                if full_envy_free:
                    assert costs[i](own) <= costs[i](other)
                assert max(costs[i](trim) for trim in trims) <= costs[i](other)


def partitions(size, labels=()):
    """Generate class patterns once, up to relabeling."""
    if len(labels) == size:
        yield labels
        return
    for label in range(max(labels, default=-1) + 2):
        yield from partitions(size, labels + (label,))


def rank_at_most_two(classes):
    return lambda bundle: min(2, len({classes[item] for item in bundle}))


def costs_for_other_observer(observer):
    return lambda bundle: len({item % (observer + 1) for item in bundle}) + (
        observer * len(bundle) * (len(bundle) - 1)
    )


def check_rank_two():
    count = 0
    for n in range(1, 5):
        for m in range(9):
            for classes in partitions(m):
                costs = [rank_at_most_two(classes)]
                costs.extend(costs_for_other_observer(i) for i in range(1, n))
                check(allocate_rank_two(n, classes), costs, m)
                count += 1
    return count


def check_social_cost(bundles, costs, words, agent_count):
    if len(words) >= agent_count:
        optimum = agent_count + (len(set(words)) == 1 << agent_count)
        assert sum(cost(bundle) for cost, bundle in zip(costs, bundles)) == optimum


def check_two_colors():
    count = 0
    for n in range(1, 4):
        for m in range(6):
            for words in product(range(1 << n), repeat=m):
                bundles = allocate_two_colors(n, words)
                costs = [
                    rank_at_most_two(tuple(word >> i & 1 for word in words)) for i in range(n)
                ]
                check(bundles, costs, m, full_envy_free=m >= n)
                check_social_cost(bundles, costs, words, n)
                count += 1
    rng = Random(20261124)
    for n in range(2, 10):
        for words in (list(range(1 << n)), rng.choices(range((1 << n) - 1), k=100)):
            rng.shuffle(words)
            bundles = allocate_two_colors(n, words)
            costs = [
                rank_at_most_two(tuple(word >> i & 1 for word in words)) for i in range(n)
            ]
            check(bundles, costs, len(words), full_envy_free=True)
            check_social_cost(bundles, costs, words, n)
            count += 1
    return count


def paving_cost(rank, forbidden):
    def cost(bundle):
        return rank - 1 if set(bundle) == forbidden else min(rank, len(bundle))
    return cost


def check_matroid_extensions():
    rng = Random(20261125)
    counts = {"paving": 0, "rank_two_with_loops": 0, "sparse_universal": 0}
    for n in range(2, 6):
        for m in range(6, 25):
            for _ in range(12):
                ranks = sorted(rng.choices(range(2, min(m, 8)), k=n))
                costs = [paving_cost(rank, set(rng.sample(range(m), rank))) for rank in ranks]
                size = ranks[0] - 1
                if m >= n * size:
                    anchors = [list(range(i * size, (i + 1) * size)) for i in range(n)]
                    bundles = allocate_anchors(anchors, list(range(n * size, m)), costs[0])
                else:
                    bundles = balanced_bundles(n, m)
                check(bundles, costs, m)
                counts["paving"] += 1

                classes = [rng.choices(range(-1, i + 3), k=m) for i in range(n)]
                costs = [
                    lambda bundle, labels=labels, cap=i + 2: min(
                        cap, len({labels[item] for item in bundle if labels[item] >= 0})
                    )
                    for i, labels in enumerate(classes)
                ]
                universal = {item for item in range(m) if all(row[item] >= 0 for row in classes)}
                if len(universal) >= n:
                    anchors = [[item] for item in sorted(universal)[:n]]
                    chosen = {bundle[0] for bundle in anchors}
                    extras = [item for item in range(m) if item not in chosen]
                    bundles = allocate_anchors(anchors, extras, costs[0])
                    counts["rank_two_with_loops"] += 1
                else:
                    bundles = allocate_sparse_universal(n, m, costs, universal)
                    counts["sparse_universal"] += 1
                check(bundles, costs, m)
    return counts


def main():
    result = {
        "rank_two_unlabeled_partition_cases": check_rank_two(),
        "two_color_cases": check_two_colors(),
        "matroid_extension_cases": check_matroid_extensions(),
        "checks": ["complete disjoint partition", "EFX for all observers",
                   "exact EF and sharp social cost in the two-color case"],
        "scope": "Finite verification of deterministic constructions; proofs apply to all sizes.",
    }
    output = Path(__file__).resolve().parents[1] / "results" / "verification.json"
    output.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(result)


if __name__ == "__main__":
    main()
