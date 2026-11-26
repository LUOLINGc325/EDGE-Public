"""Check an exact split-graph transitivity identity without using its proof."""

from functools import cache
from itertools import combinations
from random import Random


def make_split(order, edges):
    clique_size = 2 * order
    full_clique = (1 << clique_size) - 1
    adjacency = [full_clique ^ (1 << i) for i in range(clique_size)]
    for copy in range(2):
        for u, v in edges:
            u += copy * order
            v += copy * order
            new_bit = 1 << len(adjacency)
            adjacency[u] |= new_bit
            adjacency[v] |= new_bit
            adjacency.append((1 << u) | (1 << v))
    return adjacency


def full_partition_search(adjacency):
    """Enumerate ordered total dominating partitions over every residual mask."""
    n = len(adjacency)
    all_vertices = (1 << n) - 1
    dominated = [0] * (all_vertices + 1)
    for mask in range(1, all_vertices + 1):
        vertex_bit = mask & -mask
        dominated[mask] = dominated[mask ^ vertex_bit] | adjacency[vertex_bit.bit_length() - 1]

    @cache
    def best(remaining):
        if not remaining:
            return 0
        if dominated[remaining] & remaining != remaining:
            return -n
        answer = 1
        maximum = remaining.bit_count() // 2
        block = remaining
        while block:
            if dominated[block] & remaining == remaining:
                answer = max(answer, 1 + best(remaining ^ block))
                if answer == maximum:
                    break
            block = (block - 1) & remaining
        return answer

    return best(all_vertices)


def minimum_cover(order, edges):
    for size in range(order + 1):
        for vertices in combinations(range(order), size):
            chosen = set(vertices)
            if all(u in chosen or v in chosen for u, v in edges):
                return chosen
    raise AssertionError("full vertex set is always a cover")


def check(order, edges):
    graph = make_split(order, edges)
    cover = minimum_cover(order, edges)
    expected = 1 + order - len(cover)
    assert full_partition_search(graph) == expected, (order, edges, expected)

    first = sorted(cover | {v + order for v in cover}) + list(range(2 * order, len(graph)))
    rest = sorted(set(range(2 * order)) - set(first))
    blocks = [first] + [rest[i:i + 2] for i in range(0, len(rest), 2)]
    assert len(blocks) == expected
    assert sorted(v for block in blocks for v in block) == list(range(len(graph)))
    for rank, block in enumerate(blocks):
        for later_block in blocks[rank:]:
            for vertex in later_block:
                assert any(graph[vertex] & (1 << neighbor) for neighbor in block)


def main():
    totals = []
    for order in range(2, 5):
        possible_edges = tuple(combinations(range(order), 2))
        count = 0
        for size in range(1, min(3, len(possible_edges)) + 1):
            for edges in combinations(possible_edges, size):
                check(order, edges)
                count += 1
        totals.append(count)
    rng = Random(20261124)
    possible_edges = tuple(combinations(range(5), 2))
    for _ in range(32):
        edges = rng.sample(possible_edges, rng.randrange(1, 4))
        check(5, edges)
    for order in range(2, 5):
        check(order, tuple(combinations(range(order), 2)))
    print("Labelled source graphs at orders 2 through 4 with 1 to 3 edges:", totals)
    print("Seeded order-5 source graphs: 32. Complete source graphs: 3.")
    print("Exact optimum and constructed partitions both verified.")


if __name__ == "__main__":
    main()
