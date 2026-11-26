"""Deterministic midpoint solver and independent exact feasibility comparators."""

from bisect import bisect_left
from collections import Counter
from functools import lru_cache
from itertools import combinations, combinations_with_replacement
from random import Random


def discretize(deadlines):
    slots = sorted(deadlines)
    for i in range(len(slots) - 2, -1, -1):
        slots[i] = min(slots[i], slots[i + 1] - 1)
    return slots


def midpoint_position_matching(deadlines, targets):
    """Use a sorted source multiset and a sorted distinct destination tuple as state."""
    assert len(deadlines) == len(targets)
    multiplicity = Counter(deadlines)
    slots = discretize(deadlines)
    support = set(multiplicity)
    coordinates = set(slots)
    assert support <= coordinates
    vertex = {2 * slot: slot for slot in slots}
    demand = Counter(targets)
    targets = sorted(targets)
    baseline = sorted(2 * value for value in support)
    events = set(vertex) | set(targets)
    for high in support:
        events.update(high + low for low in slots if low < high)
    states = {((), ())}
    ended = 0
    live = 0
    for threshold in sorted(events, reverse=True):
        slot = vertex.get(threshold)
        if slot is not None:
            if slot in support:
                live += multiplicity[slot] - 1
            else:
                ended += 1
                live -= 1

        required = 0
        if threshold in demand:
            required = len(targets) - bisect_left(targets, threshold)
            required -= len(baseline) - bisect_left(baseline, threshold)
            required -= ended

        next_states = set()
        for sources, destinations in states:
            if slot is not None:
                incoming = slot in destinations
                if slot not in support and not incoming:
                    continue
                if incoming:
                    destinations = tuple(point for point in destinations if point != slot)
                if slot in support:
                    count = multiplicity[slot] - 1 + incoming
                    sources = tuple(sorted(sources + (slot,) * count))

            occupied = set(destinations)
            candidates = [
                (high, threshold - high) for high in sorted(set(sources))
                if threshold - high < high
                and threshold - high in coordinates and threshold - high not in occupied
            ]
            for count in range(max(0, required - len(destinations)), len(candidates) + 1):
                for chosen in combinations(candidates, count):
                    remaining = list(sources)
                    for high, _ in chosen:
                        remaining.remove(high)
                    after = tuple(sorted(destinations + tuple(low for _, low in chosen)))
                    next_states.add((tuple(remaining), after))
        assert all(len(sources) + len(destinations) == live
                   for sources, destinations in next_states)
        states = next_states
        if not states:
            return False
    return ((), ()) in states


def two_visits(deadlines):
    trimmed = sorted(deadlines)
    while trimmed and trimmed[-1] > 2 * len(trimmed):
        trimmed.pop()
    slots = set(discretize(trimmed))
    if slots and min(slots) < 1:
        return False
    targets = sorted(set(range(1, 2 * len(trimmed) + 1)) - slots)
    return midpoint_position_matching(trimmed, targets)


def independent_position_matching(deadlines, slots, targets):
    """Enumerate every assignment of a deadline and target to the next slot."""
    deadlines = tuple(sorted(deadlines))
    targets = tuple(sorted(targets))

    @lru_cache(None)
    def search(index, remaining_d, remaining_t):
        if index == len(slots):
            return True
        slot = slots[index]
        for j, deadline in enumerate(remaining_d):
            if deadline < slot or (j and deadline == remaining_d[j - 1]):
                continue
            for k, target in enumerate(remaining_t):
                if target > deadline + slot:
                    break
                if k and target == remaining_t[k - 1]:
                    continue
                if search(index + 1, remaining_d[:j] + remaining_d[j + 1:],
                          remaining_t[:k] + remaining_t[k + 1:]):
                    return True
        return False

    return search(0, deadlines, targets)


def independent_direct_schedule(deadlines):
    """Assign both visit times directly, without discretization."""
    deadlines = tuple(sorted(deadlines))
    n = len(deadlines)

    @lru_cache(None)
    def search(index, free):
        if index == n:
            return True
        deadline = deadlines[index]
        for first in range(1, min(deadline, 2 * n) + 1):
            if not free & (1 << first):
                continue
            for second in range(first + 1, min(first + deadline, 2 * n) + 1):
                if free & (1 << second):
                    remaining = free ^ (1 << first) ^ (1 << second)
                    if search(index + 1, remaining):
                        return True
        return False

    return search(0, (1 << (2 * n + 1)) - 2)


def main():
    exhaustive = 0
    for n in range(6):
        for deadlines in combinations_with_replacement(range(1, 2 * n + 1), n):
            expected = independent_direct_schedule(deadlines)
            assert two_visits(deadlines) == expected, deadlines
            exhaustive += 1

    rng = Random(902147)
    position_cases = 1400
    for trial in range(position_cases):
        n = rng.randrange(1, 8)
        shift = 10 ** 30 if trial % 11 == 0 else 0
        deadlines = [rng.randrange(1, n + 6) + shift for _ in range(n)]
        targets = [rng.randrange(1, 2 * (n + 6)) + 2 * shift for _ in range(n)]
        slots = discretize(deadlines)
        expected = independent_position_matching(deadlines, slots, targets)
        assert midpoint_position_matching(deadlines, targets) == expected, (deadlines, targets)

    seeded_schedules = 350
    for _ in range(seeded_schedules):
        n = rng.randrange(1, 8)
        deadlines = [rng.randrange(1, 3 * n + 1) for _ in range(n)]
        assert two_visits(deadlines) == independent_direct_schedule(deadlines), deadlines

    forced_chain = (3, 4, 4, 5, 6)
    direct_capacities = [6, 6, 8, 10, 12]
    targets = sorted(set(range(1, 11)) - set(discretize(forced_chain)))
    assert any(limit < target for limit, target in zip(direct_capacities, targets))
    assert two_visits(forced_chain) and independent_direct_schedule(forced_chain)

    k = 40
    single_chain_width = [k + 2 * j for j in range(1, k + 1) for _ in range(2)]
    assert two_visits(single_chain_width)

    print(f"Exhaustive 2-Visits instances (n <= 5, d <= 2n): {exhaustive}")
    print(f"Seeded 2-Visits instances with removable large deadlines: {seeded_schedules}")
    print(f"Seeded Position Matching instances (n <= 7): {position_cases}")
    print("Direct schedule search and independent triple assignment agree with the midpoint solver.")
    print("Position Matching cases include repeated targets and translations by 10^30.")
    print("The (3,4,4,5,6) instance requires an intermediate support point.")
    print("The overlap-one family is feasible at 40 extra deadline copies.")


if __name__ == "__main__":
    main()
