"""Cross-check both solvers against direct schedule and assignment enumeration."""

from collections import Counter
from functools import lru_cache
from itertools import combinations, combinations_with_replacement, permutations
from random import Random

from solve import cut_width, discretize, position_matching, two_visits, width_one_assignment


def direct_schedule(deadlines):
    """Assign two ordinary visits in actual schedule slots."""
    n = len(deadlines)

    @lru_cache(None)
    def search(task, free):
        if task == n:
            return True
        d = deadlines[task]
        for first in range(min(d, 2 * n)):
            if not (free >> first) & 1:
                continue
            for second in range(first + 1, min(first + d + 1, 2 * n)):
                if (free >> second) & 1:
                    free_after = free ^ (1 << first) ^ (1 << second)
                    if search(task + 1, free_after):
                        return True
        return False

    return search(0, (1 << (2 * n)) - 1)


def direct_matching(deadlines, slots, targets):
    """Enumerate the distinct basic assignments, then assign targets by DFS."""
    targets = tuple(sorted(targets))

    @lru_cache(None)
    def assign_targets(capacities, free):
        if not capacities:
            return True
        for i, t in enumerate(targets):
            if t <= capacities[0] and (free >> i) & 1:
                if assign_targets(capacities[1:], free ^ (1 << i)):
                    return True
        return False

    for ordering in set(permutations(deadlines)):
        if all(d >= a for d, a in zip(ordering, slots)):
            capacities = tuple(sorted(d + a for d, a in zip(ordering, slots)))
            if assign_targets(capacities, (1 << len(targets)) - 1):
                return True
    return False


def check_pair(deadlines, targets, expected):
    assert position_matching(deadlines, targets, fast=False) == expected, (deadlines, targets)
    assert position_matching(deadlines, targets) == expected, (deadlines, targets)
    if cut_width(deadlines) <= 1:
        witness = width_one_assignment(deadlines, targets)
        assert (witness is not None) == expected, (deadlines, targets)
        if witness is not None:
            check_witness(deadlines, targets, witness)


def check_witness(deadlines, targets, witness):
    assert sorted(d for d, _, _ in witness) == sorted(deadlines)
    assert sorted(a for _, a, _ in witness) == discretize(sorted(deadlines))
    assert sorted(t for _, _, t in witness) == sorted(targets)
    assert all(d >= a and d + a >= t for d, a, t in witness)


def main():
    schedule_widths = Counter()
    for n in range(6):
        for deadlines in combinations_with_replacement(range(1, 2 * n + 1), n):
            expected = direct_schedule(deadlines)
            assert two_visits(deadlines, fast=False) == expected, deadlines
            assert two_visits(deadlines) == expected, deadlines
            schedule_widths[cut_width(deadlines)] += 1

    matching_widths = Counter()
    for n in range(1, 6):
        for deadlines in combinations_with_replacement(range(1, 6), n):
            slots = discretize(deadlines)
            width = cut_width(deadlines)
            for targets in combinations(range(1, 10), n):
                check_pair(deadlines, targets, direct_matching(deadlines, slots, targets))
                matching_widths[width] += 1

    rng = Random(518073)
    for i in range(500):
        n = rng.randint(1, 7)
        shift = 10 ** 30 if i % 2 else 0
        deadlines = tuple(sorted(shift + rng.randint(1, 2 * n + 2) for _ in range(n)))
        slots = discretize(deadlines)
        population = range(1, 4 * n + 6)
        chosen = rng.choices(population, k=n) if i % 4 < 2 else rng.sample(population, n)
        targets = tuple(t + 2 * shift for t in chosen)
        check_pair(deadlines, targets, direct_matching(deadlines, slots, targets))

    deadlines = (3, 4, 5, 5)
    assert cut_width(deadlines) == 1
    check_pair(deadlines, (6, 7, 8, 10), True)  # Only the direct descending arc works.
    check_pair(deadlines, (5, 7, 9, 10), True)  # Both intermediate positions are needed.
    check_pair(deadlines, (6, 7, 9, 10), False)

    excess = 20000
    deadlines = [excess + 2 * j for j in range(1, excess + 1) for _ in range(2)]
    primary = discretize(deadlines)
    assert primary == list(range(excess + 1, 3 * excess + 1))
    assert cut_width(deadlines) == 1
    assert two_visits(deadlines)
    targets = list(range(1, excess + 1)) + list(range(3 * excess + 1, 4 * excess + 1))
    check_witness(deadlines, targets, width_one_assignment(deadlines, targets))

    print(f"Exhaustive schedules: {sum(schedule_widths.values())} cases, widths {dict(sorted(schedule_widths.items()))}")
    print(f"Exhaustive position matchings: {sum(matching_widths.values())} cases, widths {dict(sorted(matching_widths.items()))}")
    print("Seeded position matchings: 500, including 250 with 10**30-scale values and 250 drawn with replacement")
    print("Width-one path checks: two YES modes and one NO mode")
    print(f"Width-one 2-Visits stress case: one cluster, {2 * excess} tasks, {excess} excess copies")


if __name__ == "__main__":
    main()
