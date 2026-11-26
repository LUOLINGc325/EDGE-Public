"""Exact finite check of the class-domination coloring tree-decomposition recurrences."""

from itertools import combinations, product
from random import Random

PENDING = -1
INTERIOR = -2


def nice_decomposition(adjacency, order):
    """Get a nice decomposition from the filled bags of a supplied elimination order."""
    filled = [set(neighbors) for neighbors in adjacency]
    rank = {vertex: i for i, vertex in enumerate(order)}
    bags = {}
    children = {v: [] for v in order}
    roots = []
    for i, v in enumerate(order):
        later = sorted((u for u in filled[v] if rank[u] > i), key=rank.get)
        bags[v] = frozenset([v, *later])
        for a, b in combinations(later, 2):
            filled[a].add(b)
            filled[b].add(a)
        if later:
            children[later[0]].append(v)
        else:
            roots.append(v)

    def lift(node, target):
        bag = node[0]
        for v in sorted(bag - target):
            bag = bag - {v}
            node = bag, (node,)
        for v in sorted(target - bag):
            bag = bag | {v}
            node = bag, (node,)
        return node

    def build(v):
        bag = bags[v]
        branches = [lift(build(u), bag) for u in children[v]]
        if not branches:
            return lift((frozenset(), ()), bag)
        node = branches[0]
        for branch in branches[1:]:
            node = bag, (node, branch)
        return node

    empty = frozenset()
    if not roots:
        return empty, ()
    root = lift(build(roots[0]), empty)
    for v in roots[1:]:
        root = empty, (root, lift(build(v), empty))
    return root


def solve(adjacency, order):
    """Return optimal cost with closed neighborhoods, checking actual DP transitions."""
    isolates = sum(not neighbors for neighbors in adjacency)
    order = [v for v in order if adjacency[v]]
    # All nonisolated vertices and their labels keep their original indices.
    tree = nice_decomposition(adjacency, order)
    palette = max_bag(tree)

    def recurse(node):
        bag, children = node
        ordered = sorted(bag)
        if not children:
            assert not bag
            return {(): 0}
        tables = [recurse(child) for child in children]
        result = {}

        def keep(state, value):
            key = tuple(state[v] for v in ordered)
            if key not in result or value < result[key]:
                result[key] = value

        if len(children) == 2:
            for state1, cost1 in tables[0].items():
                for state2, cost2 in tables[1].items():
                    joined = {}
                    for v, (c1, d1, m1), (c2, d2, m2) in zip(ordered, state1, state2):
                        if c1 != c2:
                            break
                        if d1 >= 0 or d2 >= 0:
                            if d1 != d2:
                                break
                            d = d1
                        elif d1 == d2 == INTERIOR:
                            break
                        else:
                            d = min(d1, d2)
                        joined[v] = c1, d, m1 | m2
                    else:
                        keep(joined, cost1 + cost2)
            return result

        child_bag = children[0][0]
        child_order = sorted(child_bag)
        if child_bag < bag:
            (new,) = bag - child_bag
            for state, cost in tables[0].items():
                old = dict(zip(child_order, state))
                eligible = [u for u in child_order if old[u][1] == PENDING and u in adjacency[new]]
                for choices in product((False, True), repeat=len(eligible)):
                    updated = old.copy()
                    for u, choice in zip(eligible, choices):
                        if choice:
                            c, _, mask = old[u]
                            updated[u] = c, new, mask
                    for color in range(palette):
                        for target in [PENDING, *(adjacency[new] & child_bag)]:
                            updated[new] = color, target, 0
                            if all(v not in adjacency[u] or updated[u][1] < 0
                                   or updated[u][:2] != updated[v][:2]
                                   for u, v in combinations(ordered, 2)):
                                keep(updated, cost)
        else:
            (removed,) = child_bag - bag
            for state, cost in tables[0].items():
                updated = dict(zip(child_order, state))
                color, target, mask = updated.pop(removed)
                if target == PENDING:
                    continue
                for u, (c, d, m) in updated.items():
                    if d == removed:
                        mask |= 1 << c
                        updated[u] = c, INTERIOR, m
                if target >= 0:
                    c, d, m = updated[target]
                    updated[target] = c, d, m | (1 << color)
                keep(updated, cost + mask.bit_count())
        return result

    return isolates + recurse(tree)[()]


def max_bag(node):
    return max([len(node[0]), *(max_bag(child) for child in node[1])])


def optimum_partition(adjacency):
    """Independent oracle. Enumerate proper closed-neighborhood-supported partitions."""
    n = len(adjacency)
    masks = [sum(1 << u for u in ns) for ns in adjacency]
    feasible = [False] * (1 << n)
    for group in range(1, 1 << n):
        feasible[group] = (
            all(not (group & masks[v]) for v in range(n) if group & (1 << v))
            and any(group & ~(masks[v] | (1 << v)) == 0 for v in range(n))
        )
    optimum = [0] + [n + 1] * ((1 << n) - 1)
    for mask in range(1, 1 << n):
        low = mask & -mask
        part = mask
        while part:
            if part & low and feasible[part]:
                optimum[mask] = min(optimum[mask], 1 + optimum[mask ^ part])
            part = (part - 1) & mask
    return optimum[-1]


def run():
    cases = 0
    for n in range(5):
        pairs = tuple(combinations(range(n), 2))
        for mask in range(1 << len(pairs)):
            adjacency = [set() for _ in range(n)]
            for i, (u, v) in enumerate(pairs):
                if mask & (1 << i):
                    adjacency[u].add(v)
                    adjacency[v].add(u)
            value = optimum_partition(adjacency)
            assert solve(adjacency, range(n)) == value
            assert solve(adjacency, reversed(range(n))) == value
            cases += 1
    print(f"Exhaustive labelled graphs through n=4: {cases}, two elimination orders each")

    rng = Random(20261124)
    for _ in range(100):
        n = 7
        adjacency = [set() for _ in range(n)]
        # A fixed two-vertex separator with several potential join branches.
        adjacency[0].add(1)
        adjacency[1].add(0)
        for v in range(2, n):
            for u in (0, 1):
                if rng.getrandbits(1):
                    adjacency[u].add(v)
                    adjacency[v].add(u)
        order = [2, 3, 4, 5, 6, 0, 1]
        assert solve(adjacency, order) == optimum_partition(adjacency)
    print("Seeded width-at-most-two separator instances: 100")
    print("Exact dynamic-programming and partition optima agree.")


if __name__ == "__main__":
    run()
