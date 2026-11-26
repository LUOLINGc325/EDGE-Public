"""Check single exchanges and the chordal Set Cover reduction in exact arithmetic."""

from functools import lru_cache
from itertools import combinations, product
from random import Random


GADGET_EDGES = ((0, 1), (0, 2), (0, 4), (1, 2), (1, 3), (2, 3))
GADGET_MARK = 1


def indices(mask):
    while mask:
        first = mask & -mask
        yield first.bit_length() - 1
        mask ^= first


def graph_from_edges(n, edges):
    adjacency = [0] * n
    for u, v in edges:
        adjacency[u] |= 1 << v
        adjacency[v] |= 1 << u
    return tuple(adjacency)


def is_chordal(graph):
    # Test the reverse of a maximum-cardinality-search order.
    n = len(graph)
    score = [0] * n
    remaining = (1 << n) - 1
    order = []
    while remaining:
        u = max(indices(remaining), key=lambda v: (score[v], -v))
        order.append(u)
        remaining ^= 1 << u
        for v in indices(remaining & graph[u]):
            score[v] += 1
    remaining = (1 << n) - 1
    for u in reversed(order):
        remaining ^= 1 << u
        neighbors = graph[u] & remaining
        for v in indices(neighbors):
            if neighbors & ~(graph[v] | (1 << v)):
                return False
    return True


def maximum_sets(graph):
    @lru_cache(None)
    def optimum(mask):
        if not mask:
            return 0
        u = max(indices(mask), key=lambda v: (graph[v] & mask).bit_count())
        rest = mask ^ (1 << u)
        return max(optimum(rest), 1 + optimum(rest & ~graph[u]))

    def enumerate_optima(mask):
        if not mask:
            yield 0
            return
        u = max(indices(mask), key=lambda v: (graph[v] & mask).bit_count())
        rest = mask ^ (1 << u)
        best = optimum(mask)
        if optimum(rest) == best:
            yield from enumerate_optima(rest)
        if 1 + optimum(rest & ~graph[u]) == best:
            for chosen in enumerate_optima(rest & ~graph[u]):
                yield chosen | (1 << u)

    return tuple(enumerate_optima((1 << len(graph)) - 1))


def exchanges(graph, chosen):
    return sum(1 << u for u, neighbors in enumerate(graph)
               if not chosen & (1 << u) and (neighbors & chosen).bit_count() == 1)


@lru_cache(None)
def minimum_transversal(parts):
    if not parts:
        return 0
    smallest = min(parts, key=int.bit_count)
    return 1 + min(minimum_transversal(tuple(part for part in parts if not part & (1 << u)))
                   for u in indices(smallest))


def verify(graph, force_check):
    assert is_chordal(graph)
    optima = maximum_sets(graph)
    if not force_check:
        return min(exchanges(graph, chosen).bit_count() for chosen in optima)
    best = len(graph)
    for chosen in optima:
        compulsory = exchanges(graph, chosen)
        alternative_differences = tuple(sorted({alt & ~chosen for alt in optima if alt != chosen}))
        assert all(other & compulsory for other in alternative_differences)
        singletons = sum(other for other in alternative_differences if other.bit_count() == 1)
        assert singletons == compulsory
        assert minimum_transversal(alternative_differences) == compulsory.bit_count()
        best = min(best, compulsory.bit_count())
    return best


def reduction(n_elements, sets):
    s = len(sets)
    copies = 2 * s + 2
    base_size = n_elements * copies + 1
    edges = list(combinations(range(base_size), 2))
    for i, covered in enumerate(sets):
        offset = base_size + 5 * i
        edges.extend((offset + u, offset + v) for u, v in GADGET_EDGES)
        edges.extend((u, offset + GADGET_MARK)
                     for element in indices(covered)
                     for u in range(1 + copies * element, 1 + copies * (element + 1)))
    return graph_from_edges(base_size + 5 * s, edges)


def minimum_cover(universe, sets):
    for size in range(len(sets) + 1):
        for selection in combinations(sets, size):
            covered = 0
            for item in selection:
                covered |= item
            if covered == universe:
                return size
    return None


def main():
    h = graph_from_edges(5, GADGET_EDGES)
    costs = {(tuple(indices(chosen)), exchanges(h, chosen).bit_count()) for chosen in maximum_sets(h)}
    assert costs == {((0, 3), 1), ((1, 4), 2), ((2, 4), 2), ((3, 4), 3)}
    print("Five-vertex gadget: maximum independent size 2, inactive cost 1, active cost 2.")

    chordal_counts = []
    for n in range(6):
        pairs = tuple(combinations(range(n), 2))
        count = 0
        for mask in range(1 << len(pairs)):
            graph = graph_from_edges(n, (pairs[e] for e in indices(mask)))
            if is_chordal(graph):
                verify(graph, force_check=True)
                count += 1
        chordal_counts.append(count)
    print("Chordal labelled inputs through n=5:", chordal_counts, "total", sum(chordal_counts))

    checked = 0
    for n_el in range(1, 4):
        universe = (1 << n_el) - 1
        for s in range(1, 4):
            for sets in product(range(1, universe + 1), repeat=s):
                if tuple(sorted(sets)) != sets:
                    continue
                cover_cost = minimum_cover(universe, sets)
                if cover_cost is None:
                    continue
                graph = reduction(n_el, sets)
                assert verify(graph, force_check=False) == s + cover_cost
                checked += 1
    rng = Random(201008)
    extra = 0
    for _ in range(30):
        n_el = 4
        universe = (1 << n_el) - 1
        sets = tuple(rng.randrange(1, universe + 1) for _ in range(4))
        cover_cost = minimum_cover(universe, sets)
        if cover_cost is not None:
            assert verify(reduction(n_el, sets), force_check=False) == len(sets) + cover_cost
            extra += 1
    print("Reduction checked on", checked, "exhaustive and", extra, "seeded covered set systems.")
    print("All single-exchange and exact optimum checks passed.")


if __name__ == "__main__":
    main()
