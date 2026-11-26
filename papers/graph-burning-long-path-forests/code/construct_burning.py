"""Construct an odd partition certifying optimal burning of a sufficiently long path forest."""

from heapq import heapify, heapreplace
from math import isqrt


def threshold(path_count):
    if path_count < 1:
        raise ValueError("a forest must have at least one nonempty path")
    if path_count == 1:
        return 1
    b = (path_count - 1).bit_length() + 8
    return 4096 * path_count * b * b


def odd(index):
    return 2 * index - 1


def build_banks(n, rounds):
    """A bank consists of its toggle index and three ordered copies of binary index gaps."""
    k = rounds.bit_length() - 1
    max_used = (n - 1) * (6 * k + 1)
    base_limit = 2 * max_used + 1
    assert rounds >= 4 * max_used + 2
    used = bytearray(rounds + 1)
    for index in range(1, n):
        used[index] = 1
    banks = []
    for toggle in range(1, n):
        pairs = []
        for _ in range(3):
            copy = []
            for bit in range(k):
                gap = 1 << bit
                base = next(a for a in range(1, base_limit + 1)
                            if not used[a] and not used[a + gap])
                assert base + gap <= rounds
                used[base] = used[base + gap] = 1
                copy.append((base, base + gap))
            pairs.append(copy)
        banks.append((toggle, pairs))
    return banks, used


def initial_bank_totals(toggle, pairs):
    lower = sum(odd(lo) for copy in pairs for lo, _ in copy)
    total = odd(toggle) + sum(odd(lo) + odd(hi) for copy in pairs for lo, hi in copy)
    left = lower + odd(toggle) - 1
    return left, total - left


def orient_bank(toggle, pairs, shortfall):
    h = odd(toggle)
    offset = h - 1 + shortfall
    left, right = [], []
    if offset % 2:
        left.append(toggle)
        offset -= h
    else:
        right.append(toggle)
    assert offset >= 0
    units = offset // 2
    copy_max = (1 << len(pairs[0])) - 1
    for copy in pairs:
        part = min(units, copy_max)
        units -= part
        for bit, (lo, hi) in enumerate(copy):
            if part & (1 << bit):
                left.append(hi)
                right.append(lo)
            else:
                left.append(lo)
                right.append(hi)
    assert units == 0
    return left, right


def exact_odd_partition(square_orders):
    """Return lists of positive odd-item indices; the weight of index j is 2j-1."""
    targets = list(square_orders)
    n = len(targets)
    initial_rounds = isqrt(sum(targets))
    if initial_rounds ** 2 != sum(targets):
        raise ValueError("the sum of the target orders must be square")
    cutoff = threshold(n)
    if min(targets) < cutoff:
        raise ValueError("the sufficient minimum path order exceeds the supplied minimum")
    if n == 1:
        return [list(range(1, initial_rounds + 1))], {'rounds': initial_rounds, 'peeled': 0}

    groups = [[] for _ in targets]
    longest = [(-length, i) for i, length in enumerate(targets)]
    heapify(longest)
    rounds = initial_rounds
    while -longest[0][0] - odd(rounds) >= cutoff:
        _, i = longest[0]
        targets[i] -= odd(rounds)
        groups[i].append(rounds)
        heapreplace(longest, (-targets[i], i))
        rounds -= 1
    banks, used = build_banks(n, rounds)
    base_budget = [0] * n
    for i, bank in enumerate(banks):
        left, right = initial_bank_totals(*bank)
        base_budget[i] += left
        base_budget[i + 1] += right
    residual = [target - base for target, base in zip(targets, base_budget)]
    assert min(residual) >= 0
    free = [j for j in range(1, rounds + 1) if not used[j]]
    # Both the targets and the free-weight prefix sum are monotone.
    free_at = 0
    target_prefix = 0
    free_prefix = 0
    shortfalls = []
    for i, subtotal in enumerate(residual):
        target_prefix += subtotal
        while free_at < len(free) and free_prefix + odd(free[free_at]) <= target_prefix:
            groups[i].append(free[free_at])
            free_prefix += odd(free[free_at])
            free_at += 1
        shortfalls.append(target_prefix - free_prefix)
    assert free_at == len(free) and shortfalls[-1] == 0
    assert all(0 <= x <= 2 * rounds - 2 for x in shortfalls)
    for i, bank in enumerate(banks):
        left, right = orient_bank(*bank, shortfalls[i])
        groups[i].extend(left)
        groups[i+1].extend(right)
    return groups, {
        'rounds': initial_rounds, 'terminal_rounds': rounds, 'peeled': initial_rounds - rounds,
        'reserved_indices': used.count(1), 'largest_shortfall': max(shortfalls),
        'largest_baseline_spend': max(base_budget), 'cutoff': cutoff,
    }


def projected_centers(orders):
    """Give radius-indexed, one-dimensional ball centers covering the original path forest."""
    orders = list(orders)
    if not orders or min(orders) < 1:
        raise ValueError("expected a nonempty sequence of positive path lengths")
    total = sum(orders)
    rounds = isqrt(total - 1) + 1
    padded = orders.copy()
    padded[-1] += rounds * rounds - total
    partition, stats = exact_odd_partition(padded)
    centers = [None] * rounds
    for path, indices in enumerate(partition):
        position = 0
        for j in indices:
            radius = j - 1
            center = min(position + radius, orders[path] - 1)
            centers[radius] = (path, center)
            position += odd(j)
        assert position == padded[path]
    assert all(center is not None for center in centers)
    stats['padding'] = rounds * rounds - total
    return centers, partition, stats


def verify_cover(orders, centers):
    """Check all intervals by an independent left-to-right sweep of each original path."""
    intervals = [[] for _ in orders]
    for radius, (path, center) in enumerate(centers):
        if path not in range(len(orders)) or not 0 <= center < orders[path]:
            return False
        intervals[path].append((max(0, center - radius), min(orders[path] - 1, center + radius)))
    for order, cover in zip(orders, intervals):
        next_vertex = 0
        for a, b in sorted(cover):
            if a > next_vertex:
                return False
            next_vertex = max(next_vertex, b + 1)
        if next_vertex != order:
            return False
    return True
