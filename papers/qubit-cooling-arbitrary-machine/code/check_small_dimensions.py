#!/usr/bin/env python3
"""Integer shell-capacity certificate for machine dimensions two through eighteen."""
from math import comb, lcm


def compositions(total):
    """List all positive ordered compositions via subsets of cut positions."""
    for cuts in range(1 << (total - 1)):
        result = []
        run = 1
        for index in range(total - 1):
            if (cuts >> index) & 1:
                result.append(run)
                run = 1
            else:
                run += 1
        yield (*result, run)


def shifted_coefficients(level_counts):
    """Coefficients of denominator-cleared G(1+z) in ascending order."""
    levels = len(level_counts)
    total = sum(level_counts)
    neighbors = tuple(zip(level_counts, level_counts[1:]))
    scale = lcm(total, *(left + right for left, right in neighbors))
    terms = [scale * (total - 1) * count // total for count in level_counts]
    for index, (left, right) in enumerate(neighbors):
        harmonic = scale * left * right // (left + right)
        terms[index] -= harmonic
        terms[index + 1] -= harmonic
    return tuple(sum(comb(i, k) * terms[i] for i in range(k, levels))
                 for k in range(levels))


def main():
    if not __debug__:
        raise RuntimeError("Run with assertions enabled")
    count = 0
    coefficient_count = 0
    for dimension in range(2, 19):
        checked = 0
        for counts in compositions(dimension):
            coefficients = shifted_coefficients(counts)
            assert min(coefficients) >= 0, (counts, coefficients)
            checked += 1
            coefficient_count += len(coefficients)
        assert checked == 1 << (dimension - 1)
        print(f"dimension {dimension}: {checked} compositions")
        count += checked
    assert count == 262142
    print(f"total: {count} compositions, {coefficient_count} nonnegative coefficients")


if __name__ == "__main__":
    main()
