"""Verify the explicit Johnson embedding, including every nonedge."""

from itertools import combinations


def embedding(triangles):
    assert triangles > 0 and triangles % 2 == 1
    half = (triangles + 1) // 2
    circle_size = half + 2
    width = 1 if half <= 2 else 2

    def core(position):
        return frozenset((position + offset) % circle_size for offset in range(width))

    def odd(position):
        return core(position) | core(position + 1)

    chain = [odd(-1)]
    for position in range(half):
        chain.append(core(position) | {circle_size})
        chain.append(odd(position))
    return chain + [odd(half)]


def verify(triangles):
    sets = embedding(triangles)
    chain_size = triangles + 2
    rank = 2 if triangles <= 3 else 3
    assert len(sets) == len(set(sets)) == chain_size + 1
    assert {len(item) for item in sets} == {rank}
    for left, right in combinations(range(len(sets)), 2):
        graph_edge = (
            left in (0, chain_size - 1) if right == chain_size else right - left <= 2
        )
        johnson_edge = len(sets[left] & sets[right]) == rank - 1
        assert graph_edge == johnson_edge, (triangles, left, right)


def main():
    dimensions = tuple(range(1, 200, 2))
    for triangles in dimensions:
        verify(triangles)
    print(f"{len(dimensions)} odd triangle-chain lengths from 1 to 199")
    print("Every vertex has a distinct set of the predicted minimum rank.")
    print("Every edge and every nonedge agrees with the Johnson adjacency rule.")


if __name__ == "__main__":
    main()
