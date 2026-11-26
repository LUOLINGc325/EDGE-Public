"""Cross-check cactus block counts by independent finite-field matrix ranks."""

from itertools import product
from pathlib import Path
from runpy import run_path


CASES = Path(__file__).resolve().parents[2]
cycle_certificate = run_path(str(
    CASES / "even-cycle-replica-branch-separation" / "code" / "certificate_cycle_branches.py"
))
color_count = cycle_certificate["color_count"]
field = cycle_certificate["field"]
direct_rank = cycle_certificate["direct_rank"]
cycle_prediction = cycle_certificate["prediction"]


def edges_of_block(block):
    if len(block) == 2:
        return (block,)
    return tuple(zip(block, (*block[1:], block[0])))


def matching_table(edges, cycle_masks):
    matchings = []

    def visit(index, used_vertices, mask):
        if index == len(edges):
            cycles = sum(
                1 << cycle_offset for cycle_offset, cycle_mask in enumerate(cycle_masks)
                if (mask & cycle_mask).bit_count() * 2 == cycle_mask.bit_count() and cycle_mask
            )
            matchings.append((mask.bit_count(), mask, cycles))
            return
        visit(index + 1, used_vertices, mask)
        left, right = edges[index]
        endpoints = (1 << left) | (1 << right)
        if not (endpoints & used_vertices):
            visit(index + 1, used_vertices | endpoints, mask | (1 << index))

    visit(0, 0, 0)
    return sorted(matchings, reverse=True)


def predicted_rank_sum(blocks, n, branch, ignore_singular=False):
    edge_blocks = tuple(map(edges_of_block, blocks))
    edges = sum(edge_blocks, ())
    options = []
    masks = []
    start = 0
    for block_index, edgelist in enumerate(edge_blocks):
        length = len(edgelist)
        full = (1 << length) - 1
        even_cycle = length >= 4 and length % 2 == 0
        masks.append(full << start if even_cycle else 0)
        block_options = []
        for support in range(full + 1):
            if length == 1:
                total = n - 1 if support else 1
            else:
                total = color_count(support.bit_count(), n)
            singular = 0
            if even_cycle and support == full and not ignore_singular:
                if length == 4:
                    singular = (n - 1) * (2 * n - 3)
                else:
                    singular = cycle_prediction(length // 2, n, branch)[1]
            assert 0 <= singular <= total
            if total > singular:
                block_options.append((support << start, 0, total - singular))
            if singular:
                block_options.append((support << start, 1 << block_index, singular))
        options.append(block_options)
        start += length

    matchings = matching_table(edges, masks)
    total = 0
    for modes in product(*options):
        support = flags = 0
        weight = 1
        for block_support, flag, multiplicity in modes:
            support |= block_support
            flags |= flag
            weight *= multiplicity
        for cardinality, mask, prohibited in matchings:
            if not (mask & ~support or prohibited & flags):
                total += weight * cardinality
                break
    return total


def direct_rank_sum(blocks, n, degree, modulus):
    edges = sum(map(edges_of_block, blocks), ())
    number_of_vertices = 1 + max(max(edge) for edge in edges)
    multiplication, palette, inverses = field(degree, modulus, n)
    result = 0
    for free_colors in product(palette, repeat=number_of_vertices - 1):
        colors = (1, *free_colors)
        weight_matrix = [[0] * number_of_vertices for _ in range(number_of_vertices)]
        for left, right in edges:
            weight = colors[left] ^ colors[right]
            weight_matrix[left][right] = weight
            weight_matrix[right][left] = weight
        rank = direct_rank(weight_matrix, multiplication, inverses)
        assert rank % 2 == 0
        result += rank // 2
    return result


def main():
    field_data = {
        3: (2, 0b111, "minus"),
        5: (4, 0b10011, "plus"),
        7: (3, 0b1011, "minus"),
    }
    c4 = (0, 1, 2, 3)
    c6 = (0, 1, 2, 3, 4, 5)
    instances = [
        ("square with leaf", (c4, (0, 4)), (3, 5, 7), False),
        ("square with triangle", (c4, (0, 4, 5)), (3, 5), False),
        ("two squares at root", (c4, (0, 4, 5, 6)), (3, 5), False),
        ("hexagon with leaf", (c6, (0, 6)), (3, 5, 7), True),
        ("hexagon with length-two attachment", (c6, (0, 6), (6, 7)), (3, 5), True),
        ("hexagon with triangle", (c6, (0, 6, 7)), (3, 5), True),
        ("hexagon with square", (c6, (0, 6, 7, 8)), (3,), True),
        ("two hexagons at root", (c6, (0, 6, 7, 8, 9, 10)), (3,), True),
    ]
    for name, blocks, numbers, has_long_even_cycle in instances:
        for n in numbers:
            degree, modulus, branch = field_data[n]
            actual = direct_rank_sum(blocks, n, degree, modulus)
            assert actual == predicted_rank_sum(blocks, n, branch)
            print(f"{name}, n={n}: half-rank sum={actual}")
        for formal_n in (5, 7, 11):
            first = predicted_rank_sum(blocks, formal_n, "minus")
            second = predicted_rank_sum(blocks, formal_n, "plus")
            assert first > second if has_long_even_cycle else first == second
    for n in (3, 5, 7):
        attachments = ((c6, (0, 6)), (c6, (0, 6), (6, 7)))
        multipliers = (1, n**2 - n + 1)
        for blocks, multiplier in zip(attachments, multipliers):
            baseline = predicted_rank_sum(blocks, n, "minus", ignore_singular=True)
            assert baseline - predicted_rank_sum(blocks, n, "minus") == (
                multiplier * cycle_prediction(3, n, "minus")[1]
            )
    print("All direct ranks, formal branch separations and attachment checks passed.")


if __name__ == "__main__":
    main()
