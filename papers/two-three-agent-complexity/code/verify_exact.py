"""Exact finite checks of the cumulative-envy reductions and the local inequality."""
import json
from itertools import product


def load_range(loads):
    return max(loads) - min(loads)


def increase(loads, index, val):
    return loads[:index] + (loads[index] + val,) + loads[index + 1:]


def optimize(values, agents):
    """Exact load-state dynamic program with a canonical labeling for identical agents."""
    best = {(0,) * agents: 0}
    for value in values:
        following = {}
        for state, cost in best.items():
            for i, old_load in enumerate(state):
                if i and old_load == state[i - 1]:
                    continue
                updated = tuple(sorted(increase(state, i, value)))
                updated_cost = cost + updated[-1] - updated[0]
                if updated not in following or updated_cost < following[updated]:
                    following[updated] = updated_cost
        best = following
    return min(best.values())


def discrepancy(items):
    possible = {0}
    for item in items:
        possible |= {total + item for total in possible}
    weight = sum(items)
    return min(abs(2 * subtotal - weight) for subtotal in possible)


def two_agent_instance(items):
    b = sum(items) + 1
    values = (b,) + tuple(value for item in items for value in (item, 2 * b)) + (b,)
    return values, (2 * len(items) + 1) * b


def three_agent_instance(items):
    items = tuple(2 * item for item in items)
    small = items + (sum(items) // 2,)
    b = sum(small) + 1
    middle = tuple(value for item in small for value in (item, 3 * b, 3 * b))
    values = (b, 2 * b) + middle + (2 * b, b)
    scaled = tuple(3 * value for value in values) + (1,)
    return scaled, 3 * (6 * len(small) + 4) * b + 1


def main():
    local_count = 0
    for loads in product(range(-2, 3), repeat=3):
        for value in range(4):
            for first, second in product(range(3), repeat=2):
                mid = increase(loads, first, value)
                final = increase(mid, second, value)
                assert load_range(loads) + load_range(mid) + load_range(final) >= 2 * value
                local_count += 1

    two_count = 0
    for length in range(1, 6):
        for items in product(range(1, 5), repeat=length):
            values, base = two_agent_instance(items)
            assert optimize(values, 2) == base + discrepancy(items)
            two_count += 1

    three_count = 0
    three_yes_count = 0
    for length in range(1, 5):
        for items in product(range(1, 4), repeat=length):
            values, threshold = three_agent_instance(items)
            answer = optimize(values, 3)
            three_count += 1
            if discrepancy(items) == 0:
                assert answer == threshold
                three_yes_count += 1
            else:
                assert answer >= threshold + 1

    print(json.dumps({
        "local_three_prefix_checks": local_count,
        "two_agent_discrepancy_reduction_checks": two_count,
        "three_agent_threshold_checks": three_count,
        "three_agent_yes_cases": three_yes_count,
        "three_agent_no_cases": three_count - three_yes_count,
        "scope": "Exact integer finite checks. The manuscript proves the universal statements."
    }, indent=2))


if __name__ == "__main__":
    main()
