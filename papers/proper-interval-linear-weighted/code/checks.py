"""Linear weighted unique domination on proper intervals and exact finite tests."""

from collections import deque
from itertools import combinations
from random import Random
import json


def require(condition, context):
    if not condition:
        raise RuntimeError(str(context))


def prepare(records):
    # Keep an original cheapest representative and sum the group rewards.
    groups = [[None, None, 0, 0, None]]
    ordered = list(enumerate(records))
    if any(ordered[i-1][1][:2] > ordered[i][1][:2]
           for i in range(1, len(ordered))):
        ordered.sort(key=lambda item: item[1][:2])
    for idx, (left, right, reward, cost) in ordered:
        require(left <= right and reward >= 0 and cost >= 0, records)
        prior = groups[-1]
        if prior[:2] == [left, right]:
            prior[2] += reward
            if cost < prior[3]:
                prior[3:] = [cost, idx]
        else:
            require(len(groups) == 1 or (left > prior[0] and right > prior[1]),
                    "input is not a proper interval representation")
            groups.append([left, right, reward, cost, idx])
    n = len(groups)-1
    lower, upper, weights = [0]*(n+1), [0]*(n+1), [0]*(n+1)
    left, right = 1, 0
    for i in range(1, n+1):
        while groups[left][1] < groups[i][0]:
            left += 1
        while right < n and groups[right+1][0] <= groups[i][1]:
            right += 1
        lower[i], upper[i] = left, right
        weights[i] = weights[i-1] + groups[i][2]
    return groups, lower, upper, weights


def evaluate_layer(groups, lower, upper, weights, previous, single, unrestricted):
    n = len(groups)-1
    values = [[None]*(n+1) for _ in range(2)]
    pointers = [[None]*(n+1) for _ in range(2)]
    eligible = values if unrestricted else previous
    maxima = [deque() for _ in range(4)]
    best = None
    for j in range(1, n+1):
        i = j-1
        if i and eligible is not None:
            for pos, queue in enumerate(maxima):
                value = eligible[pos % 2][i]
                if value is None:
                    continue
                if pos >= 2:
                    value -= weights[upper[i]]
                while queue and queue[-1][1] <= value:
                    queue.pop()
                queue.append((i, value))
        for queue in maxima:
            while queue and upper[queue[0][0]] < lower[j]-1:
                queue.popleft()
        for branch in range(2):
            candidates = [(0, 0, 0)] if single and lower[j] == 1 else []
            for option, queue in enumerate(maxima[2*branch:2*branch+2]):
                if queue:
                    pred, value = queue[0]
                    if option == 1:
                        value += weights[lower[j]-1]
                    candidates.append((value, pred, option))
            if not candidates:
                continue
            value, pred, pred_branch = max(candidates, key=lambda record: record[0])
            values[branch][j] = value-groups[j][3]
            pointers[branch][j] = (pred, pred_branch)
            if upper[j] == n:
                final_value = values[branch][j] + (weights[n] if branch else 0)
                if best is None or final_value > best[0]:
                    best = final_value, j, branch
    return values, pointers, best


def solve(records, budget=None):
    groups, lower, upper, weights = prepare(records)
    n = len(groups)-1
    if n == 0:
        return 0, [], [0]*(budget+1) if budget is not None else None
    if budget is None:
        _, pointers, best = evaluate_layer(
            groups, lower, upper, weights, None, True, True)
        value, j, branch = best
        centers = []
        while j:
            centers.append(groups[j][4])
            j, branch = pointers[branch][j]
        return value, centers[::-1], None

    require(budget >= 0, budget)
    layers, previous, best, best_layer = [None], None, None, None
    frontier = [None]
    for h in range(1, min(n, budget)+1):
        previous, pointers, terminal = evaluate_layer(
            groups, lower, upper, weights, previous, h == 1, False)
        layers.append(pointers)
        if terminal is not None and (best is None or terminal[0] > best[0]):
            best, best_layer = terminal, h
        frontier.append(None if best is None else best[0])
    frontier.extend([frontier[-1]]*(budget+1-len(frontier)))
    if best is None:
        return None, [], frontier
    value, j, branch = best
    centers = []
    while j:
        centers.append(groups[j][4])
        j, branch = layers[best_layer][branch][j]
        best_layer -= 1
    return value, centers[::-1], frontier


def score(records, centers):
    neighbors = [sum(records[c][0] <= b and a <= records[c][1] for c in centers)
                 for a, b, _, _ in records]
    if any(count == 0 for count in neighbors):
        return None
    return sum(reward for (_, _, reward, _), count in zip(records, neighbors)
               if count == 1) - sum(records[c][3] for c in centers)


def verify():
    rng = Random(20261125)
    instances = [[], [(1, 1, 2, 9)], [(0, 1, 4, 5), (0, 1, 3, 2), (1, 2, 5, 1)]]
    for trial in range(240):
        n, length = rng.randrange(1, 10), rng.randrange(0, 7)
        starts = [rng.randrange(0, 13) for _ in range(n)]
        records = [(a, a+length, rng.randrange(0, 12), rng.randrange(0, 10))
                   for a in starts]
        rng.shuffle(records)
        instances.append(records)
    subsets = budget_checks = 0
    for records in instances:
        n = len(records)
        exact = [None]*(n+1)
        for h in range(n+1):
            for centers in combinations(range(n), h):
                evaluated = score(records, centers)
                subsets += 1
                if evaluated is not None and (exact[h] is None or evaluated > exact[h]):
                    exact[h] = evaluated
        frontier = []
        best = None
        for value in exact:
            if value is not None and (best is None or value > best):
                best = value
            frontier.append(best)
        got, witness, _ = solve(records)
        require(got == best and score(records, witness) == got, ("unrestricted", records))
        for budget in range(n+2):
            got, witness, front = solve(records, budget=budget)
            expected = frontier[:budget+1] + [frontier[-1]]*max(0, budget-n)
            require(front == expected and got == expected[-1], ("frontier", records, budget))
            if got is not None:
                require(len(witness) <= budget and score(records, witness) == got,
                        ("witness", records, budget))
            budget_checks += 1
    return {"instances": len(instances), "enumerated_original_subsets": subsets,
            "budget_and_witness_checks": budget_checks}


if __name__ == "__main__":
    print(json.dumps(verify(), indent=2))
