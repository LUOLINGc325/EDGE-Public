"""Reproduce exact list matchings, separating stars, and edge decompositions."""

from collections import deque
from fractions import Fraction
from itertools import combinations, permutations, product
from math import comb, ceil, log2
import json


def require(condition, detail):
    if not condition:
        raise AssertionError(detail)


def local_view(colors, player):
    return colors[:player] + colors[player+1:]


def perfect_lists(palette, budgets, forbidden=None):
    full = list(permutations(palette, len(budgets)))
    right = {}
    neighbors = []
    for colors in full:
        adjacent = []
        for i, count in enumerate(budgets):
            view = local_view(colors, i)
            for slot in range(count):
                key = (i, view, slot)
                if key not in right:
                    right[key] = len(right)
                if forbidden is not None and slot == 0 and colors[i] == forbidden:
                    continue
                adjacent.append(right[key])
        neighbors.append(adjacent)
    require(len(right) == len(full), ("balanced matching", len(right), len(full)))
    mate_left = [-1]*len(full)
    mate_right = [-1]*len(right)

    def search(left):
        for rr in neighbors[left]:
            previous = mate_right[rr]
            if previous == -1 or (dist[previous] == dist[left]+1 and search(previous)):
                mate_left[left] = rr
                mate_right[rr] = left
                return True
        dist[left] = -1
        return False

    while -1 in mate_left:
        dist = [-1]*len(full)
        queue = deque()
        for i, mt in enumerate(mate_left):
            if mt == -1:
                dist[i] = 0
                queue.append(i)
        while queue:
            left = queue.popleft()
            for rr in neighbors[left]:
                previous = mate_right[rr]
                if previous >= 0 and dist[previous] == -1:
                    dist[previous] = dist[left]+1
                    queue.append(previous)
        progressed = False
        for i, mt in enumerate(mate_left):
            if mt == -1 and search(i):
                progressed = True
        require(progressed, "no augmenting path")
    return full, {key: full[mate_right[idx]][key[0]] for key, idx in right.items()}


def clique_checks():
    certificate = []
    for budgets in ((3,), (0, 3), (1, 2, 2), (1, 1, 1, 1)):
        q = len(budgets)-1+sum(budgets)
        full, table = perfect_lists(tuple(range(q)), budgets)
        for colors in full:
            correct = sum(colors[i] == table[(i, local_view(colors, i), slot)]
                          for i, count in enumerate(budgets) for slot in range(count))
            require(correct == 1, ("clique coverage", budgets, colors))
        certificate.append({"budgets": budgets, "palette": q, "verified_injections": len(full)})
    return certificate


def separating_stars():
    results = []
    for d in range(1, 5):
        q = 3*d+1
        palette = tuple(range(2, q))
        base, table = perfect_lists(palette, (2,)*d, forbidden=2)
        swap = {1: 2, 2: 1}
        for (i, view, slot), guess in table.items():
            if slot == 0:
                require(guess != 2, ("forbidden guess", i, view))
        for hub in (1, 2):
            allowed = tuple(color for color in range(1, q) if color != hub)
            for colors in permutations(allowed, d):
                successes = 0
                for i in range(d):
                    view = local_view(colors, i)
                    if 1 not in view:
                        center_guess = table[(i, view, 0)]
                    else:
                        translated = tuple(swap.get(c, c) for c in view)
                        target = table[(i, translated, 0)]
                        center_guess = swap.get(target, target)
                    if hub == 1:
                        leaf_guess = table[(i, view, 1)]
                    else:
                        translated = tuple(swap.get(c, c) for c in view)
                        target = table[(i, translated, 1)]
                        leaf_guess = swap.get(target, target)
                    successes += (center_guess == colors[i]) + (leaf_guess == colors[i])
                require(successes == 1, (d, hub, colors))
        results.append({"peripheral_clique": d, "pairs_separated": 2, "verified_injections_per_pair": len(base)})

    for d in range(1, 81):
        alpha = Fraction(1, 2*d-1)
        beta = Fraction(1, d)-alpha
        require(beta >= 0 and d*(alpha+beta) == 1, ("fractional rows", d))
        require((2*d-1)*alpha == 1 and (2*d-1)*beta+Fraction(1, d) == 1, ("fractional columns", d))
        require(Fraction(1, d)+2*(d-1)*Fraction(1, 2*d) == 1, ("second row type", d))
    return results


BIPARTITE_LAYERS = (
    "04 10 21 23 34 40 52 55",
    "00 01 12 22 35 45 53 54",
    "02 11 24 25 30 33 42 51",
    "03 14 15 20 31 32 43 50",
    "05 13 41 44",
)
CLIQUE_LAYERS = ("01 02 34 35", "04 12 13 45", "05 15 23 24", "03 14 25")


def parse_layers(rows, right_offset):
    return [set((int(e[0]), int(e[1])+right_offset) for e in row.split()) for row in rows]


def check_layer(layer):
    degree = {}
    for a, b in layer:
        degree[a] = 1 + degree.get(a, 0)
        degree[b] = 1 + degree.get(b, 0)
    require(all(value <= 2 for value in degree.values()), layer)
    require(all(min(degree[a], degree[b]) == 1 for a, b in layer), layer)


def round_robin(size):
    if size <= 1:
        return []
    padded = size + size % 2
    layers = []
    for a in range(padded-1):
        pairs = [(a, padded-1)]
        pairs += [((a-j) % (padded-1), (a+j) % (padded-1)) for j in range(1, padded//2)]
        layers.append({tuple(sorted((i, j))) for i, j in pairs if i < size and j < size})
    return layers


def decompositions():
    between = parse_layers(BIPARTITE_LAYERS, 6)
    within = parse_layers(CLIQUE_LAYERS, 0)
    require(set.union(*between) == set(product(range(6), range(6, 12))), "bipartite coverage")
    require(set.union(*within) == set(combinations(range(6), 2)), "clique coverage")
    require(sum(map(len, between)) == 36 and sum(map(len, within)) == 15, "repeated edges")
    for layer in between+within:
        check_layer(layer)
    counts = {}
    for q in (4, 7, 10, 13, 19, 31, 46):
        m = (q+5)//6
        cover = []
        for groups in round_robin(m):
            for template in between:
                cover.append({(6*i+a, 6*j+b-6) for i, j in groups for a, b in template
                              if 6*i+a < q and 6*j+b-6 < q})
        for template in within:
            cover.append({(6*i+a, 6*i+b) for i in range(m) for a, b in template if 6*i+b < q})
        for layer in cover:
            check_layer(layer)
        require(set.union(*cover) == set(combinations(range(q), 2)), q)
        counts[str(q)] = len(cover)
    return counts


def stars_with_list_budgets():
    pair_checks = 0
    for ell in range(1, 33):
        q = 2*(ell+1)
        r = ceil(log2(q))
        mask = (1 << r)-1
        words = [value for k in range(q//2) for value in (k, mask ^ k)]
        require(len(set(words)) == q, (ell, words))
        for a, b in combinations(range(q), 2):
            differing_bit = (words[a]^words[b]) & -(words[a]^words[b])
            a_list = {i for i in range(q) if i != a and bool(words[i]&differing_bit) == bool(words[a]&differing_bit)}
            b_list = {i for i in range(q) if i != b and bool(words[i]&differing_bit) == bool(words[b]&differing_bit)}
            require(len(a_list) == len(b_list) == ell and a_list|b_list == set(range(q))-{a, b}, (ell, a, b))
            pair_checks += 1
    return pair_checks


def volume_check():
    q, d, r, g = 5, 2, 3, 2
    observations = list(permutations(range(q), d))
    expectation = Fraction(sum(min(g, q-len(set().union(*parts))) for parts in product(observations, repeat=r)),
                           len(observations)**r)
    calculated = Fraction(0)
    for j in range(q+1):
        probability = Fraction(0)
        for a in range(q-j+1):
            injections = len(list(permutations(range(q-j-a), d)))
            probability += (-1)**a * comb(q-j, a) * Fraction(injections, len(observations))**r
        calculated += min(g, j)*comb(q, j)*probability
    require(expectation == calculated, "unused-color expectation")
    return str(calculated)


def main():
    print(json.dumps({
        "weighted_clique_matches": clique_checks(),
        "separating_star_checks": separating_stars(),
        "group_decomposition_petal_counts": decompositions(),
        "weighted_star_hub_pair_checks": stars_with_list_budgets(),
        "exact_volume_crosscheck": volume_check(),
    }, indent=2))


if __name__ == "__main__":
    main()
