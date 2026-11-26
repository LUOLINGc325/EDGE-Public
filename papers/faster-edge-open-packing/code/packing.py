"""Exact reference algorithms. Vertices are numbered from 0, except X in convex()."""

from collections import defaultdict
from itertools import combinations


def elimination_order(adjacency):
    """Simple MCS implementation for the finite certificate, with a PEO check."""
    unused = set(range(len(adjacency)))
    weights = [0] * len(adjacency)
    chosen = []
    while unused:
        vertex = max(unused, key=lambda v: (weights[v], -v))
        unused.remove(vertex)
        chosen.append(vertex)
        for other in adjacency[vertex] & unused:
            weights[other] += 1
    order = chosen[::-1]
    rank = {vertex: i for i, vertex in enumerate(order)}
    later = [sorted((u for u in adjacency[v] if rank[u] > i), key=rank.get)
             for i, v in enumerate(order)]
    for neighbors in later:
        if neighbors and any(v not in adjacency[neighbors[0]] for v in neighbors[1:]):
            raise ValueError("graph is not chordal")
    return order, rank, later


def chordal(adjacency):
    """Return an optimal packing using the separator projection recurrence."""
    order, rank, later = elimination_order(adjacency)
    children = [[] for _ in order]
    roots = []
    for i, neighbors in enumerate(later):
        if neighbors:
            children[rank[neighbors[0]]].append(i)
        else:
            roots.append(i)

    # A boundary key is (centre, leaf, leaf_degree); None denotes absence.
    # Use the global order of coordinates for role agreement across bags.
    tables = []
    history = []
    for i, vertex in enumerate(order):
        bag = [vertex, *later[i]]
        values = {(None, None, 0): 0}
        for u in bag:
            values[(u, None, 0)] = 0
            values[(None, u, 0)] = 0
        for u, v in combinations(bag, 2):
            values[(u, v, 1)] = 1
            values[(v, u, 1)] = 1

        stages = []
        for child in children[i]:
            sep = set(later[child])
            projected = {}
            for (centre, leaf, degree), value in tables[child].items():
                keep_centre = centre if centre in sep else None
                keep_leaf = leaf if leaf in sep else None
                key = keep_centre, keep_leaf, degree if keep_leaf is not None else 0
                if key not in projected or value > projected[key][0]:
                    projected[key] = value, (centre, leaf, degree)

            merged = {}
            back = {}
            for (centre, leaf, degree), value in values.items():
                keep_centre = centre if centre in sep else None
                keep_leaf = leaf if leaf in sep else None
                duplicate = int(keep_centre is not None and keep_leaf is not None)
                for child_degree in range(2 if keep_leaf is not None else 1):
                    entry = projected.get((keep_centre, keep_leaf, child_degree))
                    if entry is None:
                        continue
                    new_degree = degree + child_degree - duplicate
                    if new_degree > 1:
                        continue
                    state = centre, leaf, new_degree
                    combined = value + entry[0] - duplicate
                    if state not in merged or combined > merged[state]:
                        merged[state] = combined
                        back[state] = (centre, leaf, degree), entry[1]
            stages.append((child, back))
            values = merged
        tables.append(values)
        history.append(stages)

    optimum = sum(max(tables[root].values()) for root in roots)
    pending = [(root, max(tables[root], key=tables[root].get)) for root in roots]
    selected = set()
    while pending:
        node, state = pending.pop()
        selected.update(v for v in state[:2] if v is not None)
        for child, back in reversed(history[node]):
            state, child_state = back[state]
            pending.append((child, child_state))
    result = {(v, u) for v in selected for u in adjacency[v] & selected if v < u}
    assert len(result) == optimum
    return result


def convex(p, intervals):
    """Return an optimal set of (X-index, Y-index) edges from ordered intervals."""
    # Intervals are closed subintervals of [1,p]. Isolated Y vertices are omitted.
    by_end = [[] for _ in range(p + 1)]
    neighbors = [[] for _ in range(p + 1)]
    counts = [[0] * (p + 1) for _ in range(p + 1)]
    for y, (left, right) in enumerate(intervals):
        by_end[right].append((left, y))
        counts[left][right] += 1
        for index in range(left, right + 1):
            neighbors[index].append(y)
    for a in range(1, p + 1):
        for b in range(1, p + 1):
            counts[a][b] += counts[a - 1][b] + counts[a][b - 1] - counts[a - 1][b - 1]

    def weight(i, a, q):
        return counts[i][q] - counts[a][q] - counts[i][i - 1] + counts[a][i - 1]

    imp = float("-inf")
    value = [[imp] * (p + 1) for _ in range(p + 1)]
    predecessor = {}
    prefix_col = [[(imp, 0)] * (p + 1) for _ in range(p + 1)]
    prefix_row = [(imp, 0)] * (p + 1)
    square = [(imp, 0, 0)] * (p + 1)
    value[0][0] = 0

    def update(a, b, score, witness):
        if score > value[a][b]:
            value[a][b] = score
            predecessor[a, b] = witness

    def launch(i):
        candidates = [a for a in range(i) if prefix_row[a][0] != imp]

        def search(q_lo, q_hi, c_lo, c_hi):
            if q_lo > q_hi:
                return
            q = (q_lo + q_hi) // 2
            best_c = max(range(c_lo, c_hi + 1),
                         key=lambda j: (prefix_row[candidates[j]][0] + weight(i, candidates[j], q), -j))
            a = candidates[best_c]
            previous, b = prefix_row[a]
            added = weight(i, a, q)
            update(i, q, previous + added, (a, b, "X", i))
            search(q_lo, q - 1, best_c, c_hi)
            search(q + 1, q_hi, c_lo, best_c)

        if candidates:
            search(i, p, 0, len(candidates) - 1)

    for b in range(p + 1):
        for left, y in by_end[b]:
            best, from_a, from_b = square[left]
            best -= left - 1
            for q in range(left, b + 1):
                if q > left:
                    source, a = prefix_col[left][q - 1]
                    if source - (q - 1) > best:
                        best, from_a, from_b = source - (q - 1), a, q - 1
                update(q, b, best + q, (from_a, from_b, "Y", y))
        best = imp, 0
        for a in range(p + 1):
            prefix_col[a][b] = best
            best = max(best, (value[a][b], a))
            prefix_row[a] = max(prefix_row[a], (value[a][b], b))
        if b < p:
            square[b + 1] = max((prefix_row[a][0], a, prefix_row[a][1])
                                for a in range(b + 1))
            launch(b + 1)

    optimum, a, b = max((value[a][b], a, b) for a in range(p + 1) for b in range(p + 1))
    result = set()
    while (a, b) != (0, 0):
        from_a, from_b, role, centre = predecessor[a, b]
        if role == "X":
            result.update((centre, y) for y in neighbors[centre]
                          if from_a < intervals[y][0] and intervals[y][1] <= b)
        else:
            left, _ = intervals[centre]
            result.update((i, centre) for i in range(max(left, from_b + 1), a + 1))
        a, b = from_a, from_b
    assert len(result) == optimum
    return result
