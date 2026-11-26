"""Verify the optimum identity with exact integer state enumeration."""

from itertools import combinations_with_replacement, product
import json
import random


def require(condition, details):
    if not condition:
        raise AssertionError(details)


def load_range(loads):
    return max(loads) - min(loads)


def best_cumulative(goods, agents):
    greedy_loads = [0] * agents
    feasible_cost = 0
    for value in goods:
        recipient = min(range(agents), key=greedy_loads.__getitem__)
        greedy_loads[recipient] += value
        feasible_cost += load_range(greedy_loads)
    costs = {(0,) * agents: 0}
    transition_count = 0
    for value in goods:
        next_costs = {}
        for loads, prefix_cost in costs.items():
            previous_load = None
            for receiver, load in enumerate(loads):
                if load == previous_load:
                    continue
                previous_load = load
                updated = list(loads)
                updated[receiver] += value
                state = tuple(sorted(updated))
                cost = prefix_cost + state[-1] - state[0]
                if cost > feasible_cost:
                    continue
                old_cost = next_costs.get(state)
                if old_cost is None or cost < old_cost:
                    next_costs[state] = cost
                transition_count += 1
        costs = next_costs
    return min(costs.values()), transition_count


def low_discrepancy(goods, agents):
    penalties = []
    for recipients in product(range(agents), repeat=len(goods)):
        loads = [0] * agents
        for recipient, value in zip(recipients, goods):
            loads[recipient] += value
        loads.sort()
        penalty = (agents - 2) * (loads[-1] - loads[0]) + loads[1] - loads[0]
        penalties.append(penalty)
    return min(penalties)


def gadget(low_goods, agents, unit):
    opening = [unit * level for level in range(1, agents)]
    middle = []
    for value in low_goods:
        middle.append(value)
        middle.extend([agents * unit] * (agents - 1))
    return opening + middle + opening[::-1] + [0] * (agents - 2)


def baseline(unit, agents, count):
    return ((agents - 1) ** 2 + count * agents * (agents - 1)) * unit


def block_checks():
    rng = random.Random(624125)
    count = 0
    repeated_receivers = 0
    for agents in range(2, 9):
        for _ in range(300):
            loads = [rng.randrange(-100, 101) for _ in range(agents)]
            starting_range = load_range(loads)
            receivers = [rng.randrange(agents) for _ in range(agents - 1)]
            sizes = [rng.randrange(1, 50) for _ in receivers]
            cost = starting_range
            for receiver, size in zip(receivers, sizes):
                loads[receiver] += size
                cost += load_range(loads)
            require(cost >= sum(sizes), (agents, receivers, sizes, cost))
            count += 1
            repeated_receivers += len(set(receivers)) < len(receivers)
    return {"blocks": count, "blocks_with_repeated_recipients": repeated_receivers}


def main():
    families = {
        2: [items for size in range(1, 5) for items in combinations_with_replacement(range(1, 5), size)],
        3: [items for size in range(1, 4) for items in combinations_with_replacement(range(1, 4), size)],
        4: [(2,), (1, 1), (2, 1, 3), (3, 3, 3, 3), (1, 2, 4)],
        5: [(1,), (2, 1)],
    }
    count = transitions = positive_checks = exact_decision_checks = 0
    samples = []
    for agents, lists in families.items():
        for low in lists:
            unit = 1 + agents * sum(low)
            goods = gadget(low, agents, unit)
            reference = baseline(unit, agents, len(low))
            expected_penalty = low_discrepancy(low, agents)
            original, step_count = best_cumulative(goods, agents)
            require(original == reference + expected_penalty, (agents, low, original, reference, expected_penalty))
            transitions += step_count
            zeros = agents - 2
            if zeros:
                error = zeros * (zeros + 1) // 2
                scale = 2 * error + 1
                positive_goods = [value * scale if value else 1 for value in goods]
                positive, step_count = best_cumulative(positive_goods, agents)
                require((positive + error) // scale == original, (agents, low, positive, original))
                transitions += step_count
                positive_checks += 1
            small_unit = 1 + sum(low)
            smaller, step_count = best_cumulative(gadget(low, agents, small_unit), agents)
            small_reference = baseline(small_unit, agents, len(low))
            require(smaller >= small_reference, (agents, low, smaller, small_reference))
            require((smaller == small_reference) == (expected_penalty == 0), (agents, low, smaller))
            transitions += step_count
            exact_decision_checks += 1
            count += 1
            if (agents, low) in {(2, (1, 2, 4)), (3, (1, 1, 1)), (4, (2, 1, 3)), (5, (2, 1))}:
                samples.append({"agents": agents, "low_values": low, "baseline": reference, "optimum": original, "excess": expected_penalty})
    print(json.dumps({
        "optimum_identity_checks": count,
        "positive_tail_rounding_checks": positive_checks,
        "low_scale_decision_checks": exact_decision_checks,
        "integer_dynamic_program_transitions": transitions,
        "block_lower_bound_checks": block_checks(),
        "examples": samples,
    }, indent=2))


if __name__ == "__main__":
    main()
