"""Compute an optimal edge open packing from an interval or permutation representation."""

from bisect import bisect_left


def unpack(arcs, predecessors, last):
    packing = set()
    while last >= 0:
        packing.add(tuple(sorted(arcs[last])))
        last = predecessors[last]
    return packing


def interval_packing(intervals):
    """Accept closed intervals, including coincident and singleton intervals."""
    positions = sorted({point for interval in intervals for point in interval})
    rank = {point: i for i, point in enumerate(positions)}
    left = [rank[a] for a, _ in intervals]
    right = [rank[b] for _, b in intervals]
    n = len(intervals)
    starts = [[] for _ in positions]
    ends = [[] for _ in positions]
    by_leaf = [[] for _ in intervals]
    for v in range(n):
        if left[v] > right[v]:
            raise ValueError("interval left endpoint exceeds right endpoint")
        starts[left[v]].append(v)
        ends[right[v]].append(v)

    arcs = []
    active = set()
    for x in range(len(positions)):
        for u in starts[x]:
            for v in active:
                by_leaf[v].append(len(arcs))
                arcs.append((u, v))
                by_leaf[u].append(len(arcs))
                arcs.append((v, u))
            active.add(u)
        for u in ends[x]:
            active.remove(u)

    zero = (0, -1)
    global_best = zero
    before = [zero] * len(positions)
    completed = [zero] * len(positions)
    centre_best = [zero] * n
    same_prior = [zero] * len(arcs)
    predecessors = [-1] * len(arcs)
    for x in range(len(positions)):
        before[x] = global_best
        for leaf in starts[x]:
            for edge in by_leaf[leaf]:
                centre, _ = arcs[edge]
                same_prior[edge] = centre_best[centre]
        for leaf in ends[x]:
            for edge in by_leaf[leaf]:
                centre, _ = arcs[edge]
                previous = max(same_prior[edge], before[min(left[centre], left[leaf])])
                predecessors[edge] = previous[1]
                entry = previous[0] + 1, edge
                centre_best[centre] = max(centre_best[centre], entry)
                finish = max(right[centre], right[leaf])
                completed[finish] = max(completed[finish], entry)
        global_best = max(global_best, completed[x])
    return unpack(arcs, predecessors, global_best[1])


class PrefixMax:
    def __init__(self, size):
        self.tree = [(0, -1)] * (size + 1)

    def insert(self, rank, entry):
        i = rank + 1
        while i < len(self.tree):
            self.tree[i] = max(self.tree[i], entry)
            i += i & -i

    def before(self, rank):
        answer = (0, -1)
        i = rank
        while i:
            answer = max(answer, self.tree[i])
            i -= i & -i
        return answer


def inversion_pairs(y):
    """Enumerate inversion edges by merging sorted halves."""
    edges = []

    def split(first, last):
        if last - first < 2:
            return list(range(first, last))
        middle = (first + last) // 2
        left = split(first, middle)
        right = split(middle, last)
        a = b = 0
        ordered = []
        while a < len(left) and b < len(right):
            if y[left[a]] < y[right[b]]:
                ordered.append(left[a])
                a += 1
            else:
                for index in range(a, len(left)):
                    edges.append((left[index], right[b]))
                ordered.append(right[b])
                b += 1
        ordered.extend(left[a:])
        ordered.extend(right[b:])
        return ordered

    split(0, len(y))
    return edges


def permutation_packing(y):
    """Vertex v has coordinates (v, y[v]); y is a permutation of range(n)."""
    n = len(y)
    if sorted(y) != list(range(n)):
        raise ValueError("second order must be a permutation")
    arcs = []
    begins = [[] for _ in y]
    by_leaf = [[] for _ in y]
    ends = [[] for _ in y]
    centre_ys = [[] for _ in y]
    for u, v in inversion_pairs(y):
        for centre, leaf in ((u, v), (v, u)):
            edge = len(arcs)
            arcs.append((centre, leaf))
            begins[u].append(edge)
            by_leaf[leaf].append(edge)
            ends[v].append(edge)
            centre_ys[centre].append(y[leaf])

    for ordinates in centre_ys:
        ordinates.sort()
    local = [PrefixMax(len(ordinates)) for ordinates in centre_ys]
    global_tree = PrefixMax(n)
    prior_other = [(0, -1)] * len(arcs)
    scores = [0] * len(arcs)
    predecessors = [-1] * len(arcs)
    optimum = (0, -1)
    for x in range(n):
        for edge in begins[x]:
            centre, leaf = arcs[edge]
            prior_other[edge] = global_tree.before(min(y[centre], y[leaf]))
        for edge in by_leaf[x]:
            centre, leaf = arcs[edge]
            position = bisect_left(centre_ys[centre], y[leaf])
            before = max(prior_other[edge], local[centre].before(position))
            predecessors[edge] = before[1]
            scores[edge] = before[0] + 1
        for edge in by_leaf[x]:
            centre, leaf = arcs[edge]
            position = bisect_left(centre_ys[centre], y[leaf])
            entry = scores[edge], edge
            local[centre].insert(position, entry)
            optimum = max(optimum, entry)
        for edge in ends[x]:
            centre, leaf = arcs[edge]
            global_tree.insert(max(y[centre], y[leaf]), (scores[edge], edge))
    return unpack(arcs, predecessors, optimum[1])
