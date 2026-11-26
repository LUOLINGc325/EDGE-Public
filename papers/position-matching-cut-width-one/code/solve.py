"""Exact algorithms for Position Matching and 2-Visits."""

from heapq import merge
from itertools import combinations, groupby


def discretize(sorted_deadlines):
    """ICALP 2026, Definition 8. The input must be nondecreasing."""
    primary = list(sorted_deadlines)
    for i in range(len(primary) - 2, -1, -1):
        primary[i] = min(primary[i], primary[i + 1] - 1)
    return primary


def _aligned_counts(deadlines, primary):
    counts = []
    j = 0
    for x in primary:
        start = j
        while j < len(deadlines) and deadlines[j] == x:
            j += 1
        counts.append(j - start)
    return counts


def _width(counts):
    surplus = width = 0
    for copies in reversed(counts):
        surplus += copies - 1
        width = max(width, surplus)
    return width


def cut_width(deadlines):
    """Return the maximum surplus at a cut in the discretized sequence."""
    deadlines = sorted(deadlines)
    return _width(_aligned_counts(deadlines, discretize(deadlines)))


def _cuts(primary, targets, counts):
    """At x, yield the active surplus and threshold demands in (2*y, 2*x]."""
    remaining = len(targets)
    support = surplus = completed = 0
    for i in range(len(primary) - 1, -1, -1):
        x = primary[i]
        copies = counts[i]
        surplus += copies - 1
        support += int(copies > 0)
        completed += int(copies == 0)
        checks = []
        while remaining and (i == 0 or targets[remaining - 1] > 2 * primary[i - 1]):
            t = targets[remaining - 1]
            remaining -= 1
            need = len(targets) - remaining - support - completed
            if need > 0:
                checks.append((t, need))
        yield i, surplus, checks


def _width_one(primary, cuts, *, arcs=None):
    """Evaluate each positive-surplus block by increasing-order reachability."""
    block = []
    for i, surplus, checks in cuts:
        if any(need > surplus for _, need in checks):
            return False
        if surplus:
            block.append((primary[i], checks))
            continue
        if not block:
            continue

        # The current coordinate closes the block and is reachable from itself.
        highest = primary[i]
        required = None
        predecessors = []
        for x, thresholds in reversed(block):
            if thresholds:
                required = thresholds[0][0]
            if required is None or x + highest >= required:
                if arcs is not None:
                    predecessors.append((x, highest))
                highest = x
        if highest != block[0][0]:
            return False
        if arcs is not None:
            for x, predecessor in reversed(predecessors):
                if x == highest:
                    arcs.append((x, predecessor))
                    highest = predecessor
        block.clear()
    return True


def _state_groups(states, x):
    """Project to open arcs carried unchanged and one arrival flag."""
    groups = []
    for state in states:
        arrival = bool(state and state[-1][0] == x)
        carried = state[:-1] if arrival else state
        groups.append((carried, arrival))
    return (group for group, _ in groupby(sorted(groups)))


def _advance(primary, i, copies, states, checks):
    x = primary[i]
    accepted = []
    for carried, arrival in _state_groups(states, x):
        if copies == 0 and not arrival:
            continue
        outgoing = copies - 1 + arrival
        if outgoing > i - len(carried):
            continue

        if outgoing:
            # Merge against the sorted occupied destinations in linear time.
            occupied = iter(q for q, _ in carried)
            next_occupied = next(occupied, None)
            choices = []
            for j in range(i):
                q = primary[j]
                if q == next_occupied:
                    next_occupied = next(occupied, None)
                else:
                    choices.append(q)
        else:
            choices = ()

        for destinations in combinations(choices, outgoing):
            arcs = tuple((q, x) for q in destinations)
            state = tuple(sorted(carried + arcs))
            capacities = tuple(p + q for q, p in state)
            if all(sum(value >= target for value in capacities) >= need
                   for target, need in checks):
                accepted.append(state)
    return accepted


def _prepare(deadlines, targets):
    deadlines = sorted(deadlines)
    targets = sorted(targets)
    if (len(deadlines) != len(targets)
            or any(d <= 0 for d in deadlines) or any(t <= 0 for t in targets)):
        raise ValueError("Positive targets and deadlines of equal size required")
    return deadlines, targets


def position_matching(deadlines, targets, *, fast=True):
    """Decide Position Matching; fast=False uses the general DP at all widths."""
    deadlines, targets = _prepare(deadlines, targets)
    if not deadlines:
        return True

    primary = discretize(deadlines)
    if targets[-1] > 2 * primary[-1]:
        return False
    counts = _aligned_counts(deadlines, primary)
    cuts = _cuts(primary, targets, counts)
    if fast and _width(counts) <= 1:
        return _width_one(primary, cuts)

    states = [()]
    for i, surplus, checks in cuts:
        if any(need > surplus for _, need in checks):
            return False
        states = _advance(primary, i, counts[i], states, checks)
        if not states:
            return False
    return True


def width_one_assignment(deadlines, targets):
    """Return triples for the width-at-most-one class, or None if infeasible."""
    deadlines, targets = _prepare(deadlines, targets)
    if not deadlines:
        return []
    primary = discretize(deadlines)
    counts = _aligned_counts(deadlines, primary)
    if _width(counts) > 1:
        raise ValueError("Width at most one required")
    arcs = []
    if targets[-1] > 2 * primary[-1] or not _width_one(
        primary, _cuts(primary, targets, counts), arcs=arcs
    ):
        return None

    arrivals = iter(q for _, q in reversed(arcs))
    next_arrival = next(arrivals, None)
    identities = []
    for x, copies in zip(primary, counts):
        if x == next_arrival:
            next_arrival = next(arrivals, None)
        elif copies:
            identities.append((x, x))
    pairs = merge(reversed(arcs), identities, key=lambda pair: pair[0] + pair[1])
    return [(d, a, t) for (d, a), t in zip(pairs, targets)]


def two_visits(deadlines, *, fast=True):
    """Decide 2-Visits using the ICALP 2026, Corollary 11 reduction."""
    deadlines = sorted(deadlines)
    if any(d <= 0 for d in deadlines):
        raise ValueError("Positive deadlines required")
    while deadlines and deadlines[-1] > 2 * len(deadlines):
        deadlines.pop()
    if not deadlines:
        return True

    primary = discretize(deadlines)
    if primary[0] < 1:
        return False
    occupied = iter(primary)
    next_occupied = next(occupied, None)
    targets = []
    for x in range(1, 2 * len(deadlines) + 1):
        if x == next_occupied:
            next_occupied = next(occupied, None)
        else:
            targets.append(x)
    return position_matching(deadlines, targets, fast=fast)
