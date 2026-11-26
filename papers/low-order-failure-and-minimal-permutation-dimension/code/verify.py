"""Replay the exact Walsh sums and the complete three-bit half-order certificate."""

import argparse
import json
from fractions import Fraction
from itertools import combinations_with_replacement, permutations, product
from pathlib import Path


def character(left, right):
    return (-1) ** ((left & right).bit_count() % 2)


def walsh(values):
    return tuple(
        sum(value * character(k, x) for x, value in enumerate(values))
        for k in range(len(values))
    )


def correlations(amplitudes):
    return tuple(
        walsh(tuple(value * amplitudes[x ^ shift] for x, value in enumerate(amplitudes)))
        for shift in range(len(amplitudes))
    )


def half_sum(amplitudes):
    return sum(abs(value) for row in correlations(amplitudes) for value in row)


def additive(weights):
    return tuple(
        sum(weight * character(x, 1 << bit) for bit, weight in enumerate(weights))
        for x in range(1 << len(weights))
    )


def finite_coefficients(values):
    dimension = len(values)
    first = walsh(values)
    second = tuple(sum(abs(row[k]) for row in correlations(values)) for k in range(dimension))
    assert all(values[x ^ (dimension - 1)] == -value for x, value in enumerate(values))
    assert all(first[k] == 0 for k in range(1, dimension) if k.bit_count() % 2 == 0)
    assert all(second[k] == 0 for k in range(1, dimension) if k.bit_count() % 2 == 1)
    return first, second, (dimension * sum(abs(w) for w in first[1:]), sum(second[1:]))


def check_coefficients():
    three = additive((1, 1, 1))
    three_sorted = tuple(sorted(three, reverse=True))
    first, _, pair = finite_coefficients(three)
    first_sorted, _, pair_sorted = finite_coefficients(three_sorted)
    assert sorted(abs(x) for x in first if x) == [8, 8, 8]
    assert sorted(abs(x) for x in first_sorted if x) == [4, 4, 4, 12]
    assert (pair, pair_sorted) == ((192, 192), (192, 144))

    four = additive((2, 3, 6, 10))
    four_sorted = tuple(sorted(four, reverse=True))
    assert four_sorted == (21, 17, 15, 11, 9, 5, 3, 1, -1, -3, -5, -9, -11, -15, -17, -21)
    first, second, pair = finite_coefficients(four)
    first_sorted, second_sorted, pair_sorted = finite_coefficients(four_sorted)
    assert first == (0, 32, 48, 0, 96, 0, 0, 0, 160, 0, 0, 0, 0, 0, 0, 0)
    assert first_sorted == (0, 28, 44, 0, 92, 0, 0, -4, 164, 0, 0, 4, 0, 4, 4, 0)
    frequencies = (3, 5, 6, 9, 10, 12, 15)
    assert tuple(second[k] for k in frequencies) == (1536, 3072, 4608, 5120, 7680, 15360, 0)
    assert tuple(second_sorted[k] for k in frequencies) == (1232, 2576, 4048, 4592, 7216, 15088, 656)
    assert (pair, pair_sorted) == ((5376, 37376), (5504, 35408))
    for epsilon in (Fraction(1, 1000), Fraction(1, 42), Fraction(1, 21)):
        original = tuple(1 + epsilon * value for value in four)
        reference = tuple(1 + epsilon * value for value in four_sorted)
        difference = half_sum(reference) - half_sum(original)
        assert difference == 128 * epsilon - 1968 * epsilon**2 > 0

    original = tuple(42 + value for value in four)
    reference = tuple(sorted(original, reverse=True))
    auxiliary = (103, 102, 101, 100)
    product_original = tuple(x * y for x in original for y in auxiliary)
    product_reference = tuple(x * y for x in reference for y in auxiliary)
    assert all(left > right > 0 for left, right in zip(product_reference, product_reference[1:]))
    assert half_sum(product_original) == half_sum(original) * half_sum(auxiliary)
    assert half_sum(product_reference) == half_sum(reference) * half_sum(auxiliary)
    return {
        "three_bit_half_coefficients": {"additive": [192, 192], "sorted": [192, 144]},
        "four_bit_half_coefficients": {"additive": [5376, 37376], "sorted": [5504, 35408]},
        "verified_positive_epsilons": ["1/1000", "1/42", "1/21"],
        "six_bit_tensor_multiplicativity": True,
    }


def normalized_layouts():
    return {
        (0,) + tail
        for tail in permutations(range(1, 8))
        if tail[:2] == (1, 2) and tail[3] == min(tail[3:])
    }


def all_linear_maps():
    return {
        (0, a, b, a ^ b, c, a ^ c, b ^ c, a ^ b ^ c)
        for a, b, c in permutations(range(1, 8), 3)
        if c != a ^ b
    }


def order_matrix(layout):
    return tuple(
        tuple(sum(character(k, x) for x, original_label in enumerate(layout) if original_label <= j)
              for j in range(7))
        for k in range(1, 8)
    )


def signed_columns(matrix, signs):
    return tuple(sum(sign * row[col] for sign, row in zip(signs, matrix)) for col in range(7))


def dominates(upper, lower):
    return all(a >= b for a, b in zip(upper, lower))


def check_zero_shift(representatives):
    signs = tuple(product((-1, 1), repeat=7))
    base = order_matrix(tuple(range(8)))
    targets = [signed_columns(base, sign) for sign in signs if all(sign[i] == 1 for i in (0, 1, 3))]
    checked = 0
    for layout in representatives:
        matrix = order_matrix(layout)
        competitors = [signed_columns(matrix, sign) for sign in signs]
        for target in targets:
            assert any(dominates(competitor, target) for competitor in competitors)
            checked += 1
    assert checked == 480
    return checked


MONOMIALS = tuple(combinations_with_replacement(range(8), 2))


def rank_product(i, j):
    """Coefficients of a_i a_j in u_p u_q, where a_i = sum_{p>=i} u_p."""
    return tuple(
        int(i <= p and j <= q) + (int(i <= q and j <= p) if p != q else 0)
        for p, q in MONOMIALS
    )


def match_choices(layout, shift):
    edges = [rank_product(layout[x], layout[x ^ shift]) for x in range(8) if x < (x ^ shift)]
    total = tuple(map(sum, zip(*edges)))
    return [tuple(2 * value for value in edge) for edge in edges] + [
        tuple(s - 2 * value for s, value in zip(total, edge)) for edge in edges
    ]


# Each signed coefficient is shifted by 64 into a one-byte lane whose top
# bit is zero. With every top bit set in the upper word, subtraction cannot
# borrow across lanes. The resulting top bits test all 36 inequalities at once.
HIGH_BITS = sum(128 << (8 * lane) for lane in range(len(MONOMIALS)))


def pack(vector):
    assert len(vector) == len(MONOMIALS) and all(-64 <= v < 64 for v in vector)
    return int.from_bytes(bytes(v + 64 for v in vector), "little")


def packed_dominates(upper, lower):
    return (((upper | HIGH_BITS) - lower) & HIGH_BITS) == HIGH_BITS


def maximal(vectors):
    remaining = []
    encoded = []
    for vector in sorted(set(vectors), key=lambda row: (-sum(row), row)):
        packed = pack(vector)
        witness = next((row for row, prior in zip(remaining, encoded)
                        if packed_dominates(prior, packed)), None)
        if witness is None:
            remaining.append(vector)
            encoded.append(packed)
        else:
            assert dominates(witness, vector)
    return remaining


def match_frontier(layout):
    frontier = [(0,) * len(MONOMIALS)]
    for shift in range(1, 8):
        choices = maximal(match_choices(layout, shift))
        frontier = maximal(
            tuple(a + b for a, b in zip(previous, choice))
            for previous in frontier
            for choice in choices
        )
    return frontier


def check_nonzero_shifts(representatives):
    targets = match_frontier(tuple(range(8)))
    assert len(targets) == 1200
    checked = 0
    frontier_sizes = []
    for layout in representatives:
        frontier = match_frontier(layout)
        frontier_sizes.append(len(frontier))
        encoded_frontier = [pack(row) for row in frontier]
        for target in targets:
            encoded_target = pack(target)
            witness = next((row for row, encoded in zip(frontier, encoded_frontier)
                            if packed_dominates(encoded, encoded_target)), None)
            # Check the claimed dominance again on ordinary signed integers.
            assert witness is not None and dominates(witness, target)
            checked += 1
    assert checked == 36000
    return {"coefficientwise_dominance_checks": checked, "competing_frontier_sizes": frontier_sizes,
            "quadratic_monomials": len(MONOMIALS), "sorted_frontier_size": len(targets)}


def check_three_bit_half_order():
    representatives = sorted(normalized_layouts())
    linear = all_linear_maps()
    assert len(representatives) == 30 and len(linear) == 168
    all_orbits = {tuple(layout[x] for x in g) for layout in representatives for g in linear}
    assert len(all_orbits) == 5040
    return {"normalized_layouts": len(representatives), "covered_permutations_fixing_zero": len(all_orbits),
            "zero_shift_sign_checks": check_zero_shift(representatives),
            "nonzero_shifts": check_nonzero_shifts(representatives)}


def check_high_order_construction():
    """Check the midpoint swap and its full Walsh update with doubled weights."""
    checked = []
    for high_bits in (2, 3, 4):
        low_weights = [2 * 3**i for i in range(1, high_bits)]
        high = additive(tuple(low_weights + [sum(low_weights) + 1]))
        for low_bits in (2, 3, 4):
            m, r = 2**low_bits, 2**high_bits
            low = (2,) + (0,) * (m - 2) + (-2,)
            values = tuple(a + b for a in high for b in low)
            n = m * r
            midpoint = n // 2
            assert values[midpoint - 1:midpoint + 1] == (-1, 1)
            reordered = list(values)
            reordered[midpoint - 1], reordered[midpoint] = reordered[midpoint], reordered[midpoint - 1]
            assert reordered == sorted(values, reverse=True)
            original_walsh, sorted_walsh = walsh(values), walsh(reordered)
            assert sum(bool(value) for value in original_walsh) == high_bits + m // 2
            assert sum(bool(value) for value in sorted_walsh) == n // 2
            for frequency, (original, new) in enumerate(zip(original_walsh, sorted_walsh)):
                update = 4 * character(frequency, midpoint - 1) if frequency.bit_count() % 2 else 0
                assert new - original == update
                if 0 < frequency < m and frequency.bit_count() % 2:
                    assert original == 4 * r and new == 4 * (r - 1)
            checked.append([high_bits, low_bits])
    return checked


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output", type=Path)
    args = parser.parse_args()
    data = check_coefficients()
    data["three_bit_half_order"] = check_three_bit_half_order()
    data["high_order_construction_checks"] = check_high_order_construction()
    data["status"] = "PASS"
    result = json.dumps(data, indent=2, sort_keys=True) + "\n"
    if args.output:
        args.output.write_text(result)
    print(result, end="")


if __name__ == "__main__":
    main()
