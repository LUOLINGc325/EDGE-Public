"""Exact small-instance validation of the modulator-branch and assignment model."""

from itertools import combinations, product
from random import Random


def graph_from_edges(n, edges):
    adjacency = [set() for _ in range(n)]
    for u, v in edges:
        adjacency[u].add(v)
        adjacency[v].add(u)
    return adjacency


def cluster_components(adjacency, vertices):
    remaining = set(vertices)
    clusters = []
    while remaining:
        v = min(remaining)
        clique = {v} | (adjacency[v] & remaining)
        if any(adjacency[u] & remaining != clique - {u} for u in clique):
            raise ValueError("the supplied modulator leaves a noncluster graph")
        clusters.append(tuple(sorted(clique)))
        remaining -= clique
    return clusters


def independent_partitions(adjacency, vertices):
    if not vertices:
        yield ()
        return
    v, *rest = vertices
    for partition in independent_partitions(adjacency, rest):
        yield ((v,), *partition)
        for i, group in enumerate(partition):
            if adjacency[v].isdisjoint(group):
                yield (*partition[:i], (v, *group), *partition[i + 1:])


def assignment_matching(choices):
    """Integral flow of unit nonfallback assignments after expanding capacity slots."""
    slot_owner = {}

    def augment(v, visited):
        for slot in choices[v]:
            if slot in visited:
                continue
            visited.add(slot)
            previous = slot_owner.get(slot)
            if previous is None or augment(previous, visited):
                slot_owner[slot] = v
                return True
        return False

    for v in choices:
        augment(v, set())
    return {v: slot for slot, v in slot_owner.items()}


def solve_model(adjacency, modulator, closed):
    n = len(adjacency)
    x = tuple(sorted(modulator))
    clients = sorted(set(range(n)) - set(x))
    clusters = cluster_components(adjacency, clients)
    location = {v: i for i, clique in enumerate(clusters) for v in clique}
    neighborhood = [neighbors | ({v} if closed else set())
                    for v, neighbors in enumerate(adjacency)]
    if not closed and any(not neighbors for neighbors in adjacency):
        return None

    candidate = None
    best = n + 1
    for partition in independent_partitions(adjacency, x):
        options = []
        for group in partition:
            witnesses = tuple(d for d in x if set(group) <= neighborhood[d])
            external = {d for d in clients if set(group) <= neighborhood[d]}
            options.append((*witnesses, None) if external else witnesses)
        for branch in product(*options):
            special = [[] for _ in range(n)]
            for i, (group, d) in enumerate(zip(partition, branch)):
                if d is None:
                    supported = {location[w] for w in clients if set(group) <= neighborhood[w]}
                for v in clients:
                    if not adjacency[v].isdisjoint(group):
                        continue
                    if d is None and location[v] in supported:
                        special[v].append((0, i, -1, 0))
                    if d is not None and v in neighborhood[d]:
                        special[v].append((0, i, location[v], 0))

            max_load = max(map(len, clusters), default=0)
            for counts in product(range(max_load + 1), repeat=len(x)):
                allocated = len(partition) + sum(counts)
                if allocated >= best:
                    continue
                choices = {v: list(special[v]) for v in clients}
                for d, count in zip(x, counts):
                    for v in clients:
                        if v in neighborhood[d]:
                            for j in range(count):
                                choices[v].append((1, d, location[v], j))
                assigned = assignment_matching(choices)
                value = allocated + len(clients) - len(assigned)
                if value >= best:
                    continue

                groups = {(0, i, 0): set(group) for i, group in enumerate(partition)}
                for v in clients:
                    slot = assigned.get(v)
                    if slot is None:
                        groups[2, v, 0] = {v}
                    else:
                        kind, owner, _, j = slot
                        groups.setdefault((kind, owner, j), set()).add(v)
                candidate = tuple(groups.values())
                best = value

    assert candidate is not None
    assert best == len(candidate)
    assert sum(map(len, candidate)) == n
    assert set().union(*candidate) == set(range(n))
    for group in candidate:
        assert all(v not in adjacency[u] for u, v in combinations(group, 2))
        assert any(group <= neighbors for neighbors in neighborhood)
    return best


def brute_partition(adjacency, closed):
    n = len(adjacency)
    masks = [sum(1 << v for v in neighbors) for neighbors in adjacency]
    covers = [mask | (1 << v) if closed else mask for v, mask in enumerate(masks)]
    admissible = [False] * (1 << n)
    for group in range(1, 1 << n):
        admissible[group] = (
            all(not (group & masks[v]) for v in range(n) if group & (1 << v))
            and any(group & ~cover == 0 for cover in covers)
        )
    values = [0] + [n + 1] * ((1 << n) - 1)
    for mask in range(1, 1 << n):
        low_bit = mask & -mask
        group = mask
        while group:
            if group & low_bit and admissible[group]:
                values[mask] = min(values[mask], 1 + values[mask ^ group])
            group = (group - 1) & mask
    return values[-1] if values[-1] <= n else None


def check(adjacency, modulator):
    for closed in (False, True):
        assert solve_model(adjacency, modulator, closed) == brute_partition(adjacency, closed), (
            adjacency, modulator, closed)


def main():
    exhaustive = 0
    for n in range(5):
        pairs = tuple(combinations(range(n), 2))
        for mask in range(1 << len(pairs)):
            graph = graph_from_edges(n, (edge for i, edge in enumerate(pairs) if mask & (1 << i)))
            for choice in range(1 << n):
                x = [v for v in range(n) if choice & (1 << v)]
                try:
                    cluster_components(graph, set(range(n)) - set(x))
                except ValueError:
                    continue
                check(graph, x)
                exhaustive += 1
    print(f"Exhaustive graph-modulator pairs through n=4: {exhaustive}")

    rng = Random(20261124)
    for _ in range(300):
        n = rng.randint(3, 9)
        k = rng.randint(0, min(3, n))
        x = list(range(k))
        residual_labels = {v: rng.randrange(4) for v in range(k, n)}
        edges = []
        for u, v in combinations(range(n), 2):
            if u < k and rng.getrandbits(1):
                edges.append((u, v))
            elif u >= k and residual_labels[u] == residual_labels[v]:
                edges.append((u, v))
        check(graph_from_edges(n, edges), x)
    print("Seeded cluster-modulator graph pairs: 300")
    print("Open and closed optimum values and every recovered feasible coloring agree with the oracle.")


if __name__ == "__main__":
    main()
