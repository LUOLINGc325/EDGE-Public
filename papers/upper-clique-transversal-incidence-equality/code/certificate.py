"""Finite exact checks for domination equality and the two reductions."""
from functools import lru_cache
from itertools import combinations
from random import Random


def make_graph(order, edges):
    adjacency = [0] * order
    for u, v in edges:
        adjacency[u] |= 1 << v
        adjacency[v] |= 1 << u
    return adjacency


def indices(mask):
    while mask:
        bit = mask & -mask
        yield bit.bit_length() - 1
        mask ^= bit


def closed(adjacency):
    return [neighbors | (1 << v) for v, neighbors in enumerate(adjacency)]


def domination(adjacency, independent=False):
    neighborhoods = closed(adjacency)
    all_vertices = (1 << len(adjacency)) - 1
    failure = len(adjacency) + 1

    @lru_cache(None)
    def search(covered, forbidden):
        if covered == all_vertices:
            return 0
        uncovered = all_vertices ^ covered
        choices = min((neighborhoods[u] & ~forbidden for u in indices(uncovered)),
                      key=int.bit_count)
        return min((1 + search(covered | neighborhoods[v],
                               forbidden | neighborhoods[v] if independent else 0)
                    for v in indices(choices)), default=failure)

    return search(0, 0)


def is_domination_certificate(adjacency, dominating, packing):
    neighborhoods = closed(adjacency)
    if len(dominating) != len(packing):
        return False
    dominated = 0
    for vertex in dominating:
        dominated |= neighborhoods[vertex]
    if dominated != (1 << len(adjacency)) - 1:
        return False
    used = 0
    for vertex in packing:
        if used & neighborhoods[vertex]:
            return False
        used |= neighborhoods[vertex]
    return True


def exact_clique_upper(adjacency):
    order = len(adjacency)
    cliques = []
    for mask in range(1, 1 << order):
        if all((adjacency[v] | (1 << v)) & mask == mask for v in indices(mask)):
            cliques.append(mask)
    maximal = [mask for mask in cliques
               if not any(mask != other and mask & other == mask for other in cliques)]
    maximum = 0
    for chosen in range(1 << order):
        if all(chosen & mask for mask in maximal):
            if all(any(chosen & mask == 1 << v for mask in maximal)
                   for v in indices(chosen)):
                maximum = max(maximum, chosen.bit_count())
    return maximum, maximal


def exact_incidence_matching(order, cliques):
    edges = [(u, c) for c, clique in enumerate(cliques) for u in indices(clique)]

    def compatible(first, second):
        u, c = first
        v, d = second
        return not (cliques[c] & (1 << v) or cliques[d] & (1 << u))

    for size in range(min(order, len(cliques)), -1, -1):
        for part in combinations(edges, size):
            if all(compatible(a, b) for a, b in combinations(part, 2)):
                return size
    raise AssertionError("the empty matching exists")


def connect(adjacency, eligible=None):
    order = len(adjacency)
    edges = [(u, v) for u, row in enumerate(adjacency)
             for v in indices(row) if u < v]
    remaining = (1 << order) - 1
    components = []
    while remaining:
        component = remaining & -remaining
        frontier = component
        while frontier:
            new_frontier = 0
            for vertex in indices(frontier):
                new_frontier |= adjacency[vertex]
            frontier = new_frontier & ~component
            component |= frontier
        remaining ^= component
        components.append(component)
    anchors = [next(v for v in indices(component)
                    if eligible is None or v in eligible) for component in components]
    a_vertices, b_vertices, c_vertices = [], [], []
    for offset, anchor in enumerate(anchors):
        a, b, c = (order + 3 * offset + delta for delta in range(3))
        edges.extend([(anchor, a), (a, b), (b, c)])
        a_vertices.append(a)
        b_vertices.append(b)
        c_vertices.append(c)
    edges.extend(zip(a_vertices, a_vertices[1:]))
    return make_graph(order + 3 * len(anchors), edges), b_vertices, c_vertices


def verify_coloring(adjacency, connected=False):
    color = {}
    components = 0
    for start in range(len(adjacency)):
        if start in color:
            continue
        components += 1
        color[start] = 0
        stack = [start]
        while stack:
            u = stack.pop()
            for v in indices(adjacency[u]):
                if v in color:
                    assert color[u] != color[v]
                else:
                    color[v] = 1 - color[u]
                    stack.append(v)
    if connected:
        assert components == 1


def formula_value(order, formula):
    return max(sum(any((bool(assignment & (1 << (abs(lit) - 1)))) == (lit > 0)
                       for lit in clause) for clause in formula)
               for assignment in range(1 << order))


def sat_graph(order, formula):
    edges = []
    dominating, packing = [], []
    for variable in range(order):
        positive, negative, leaf_positive, leaf_negative = range(4*variable, 4*variable+4)
        dominating.extend((positive, negative))
        packing.extend((leaf_positive, leaf_negative))
        edges.extend(((positive, negative), (positive, leaf_positive),
                      (negative, leaf_negative)))
    for clause_vertex, clause in enumerate(formula, 4*order):
        for literal in clause:
            port = 4*(abs(literal)-1) + (literal < 0)
            edges.append((clause_vertex, port))
    return make_graph(4*order + len(formula), edges), dominating, packing


def unsat_graph(order, formula):
    edges = []
    for variable in range(order):
        base = 6*variable
        edges.extend((base + i, base + (i+1) % 6) for i in range(6))
    h, w, h_leaf1, h_leaf2, a, z = range(6*order, 6*order+6)
    edges.extend(((h, w), (h, h_leaf1), (h, h_leaf2), (w, a), (w, z)))
    for clause_vertex, clause in enumerate(formula, 6*order+6):
        edges.append((clause_vertex, z))
        for literal in clause:
            port = 6*(abs(literal)-1) + 2*(literal < 0)
            edges.append((clause_vertex, port))
    return make_graph(6*order + 6 + len(formula), edges)


def formulas(order, monotone):
    clauses = []
    for size in range(1, min(order, 3)+1):
        for variables in combinations(range(1, order+1), size):
            for signs in range(1 << size):
                clause = tuple(-v if signs & (1 << j) else v
                               for j, v in enumerate(variables))
                if not monotone or signs in (0, (1 << size)-1):
                    clauses.append(clause)
    return clauses


def exhaustive_formulas(order, monotone):
    all_clauses = formulas(order, monotone)
    for selection in range(1 << len(all_clauses)):
        yield tuple(all_clauses[c] for c in indices(selection))


def run():
    checked_triangle_free = 0
    for order in range(1, 6):
        possible = list(combinations(range(order), 2))
        for selector in range(1 << len(possible)):
            adjacency = make_graph(order, (possible[c] for c in indices(selector)))
            if any(adjacency[u] & adjacency[v]
                   for u, row in enumerate(adjacency) for v in indices(row)):
                continue
            isolates = adjacency.count(0)
            upper, cliques = exact_clique_upper(adjacency)
            assert upper == order + isolates - domination(adjacency, True)
            assert exact_incidence_matching(order, cliques) == order + isolates - domination(adjacency)
            checked_triangle_free += 1

    sats = unsats = joined = 0
    seed = Random(249302)
    for monotone in (True, False):
        suite = [(order, formula) for order in (1, 2)
                 for formula in exhaustive_formulas(order, monotone)]
        for order, count in ((3, 40), (4, 20)):
            universe = formulas(order, monotone)
            suite.extend((order, tuple(seed.sample(universe, seed.randrange(0, 9))))
                         for repeat in range(count))
        for trial, (order, formula) in enumerate(suite):
            satisfied = formula_value(order, formula)
            if monotone:
                adjacency, dominating, packing = sat_graph(order, formula)
                assert is_domination_certificate(adjacency, dominating, packing)
                assert domination(adjacency) == 2*order
                assert domination(adjacency, True) == 2*order + len(formula) - satisfied
                sats += 1
            else:
                adjacency = unsat_graph(order, formula)
                assert domination(adjacency) == 2*order + 2 + (satisfied != len(formula))
                assert domination(adjacency, True) == 2*order + 3
                unsats += 1
            verify_coloring(adjacency)
            if trial % 3 == 0:
                linked, adds, leaves = connect(adjacency, set(packing) if monotone else None)
                verify_coloring(linked, connected=True)
                if monotone:
                    assert is_domination_certificate(linked, dominating + adds, packing + leaves)
                for independent in (False, True):
                    assert domination(linked, independent) == domination(adjacency, independent) + len(adds)
                joined += 1

    print(f"Triangle-free graphs with direct transversal and induced matching checks: {checked_triangle_free}")
    print(f"SAT-side reductions: {sats}; UNSAT-side reductions: {unsats}")
    print(f"Connectedness and exact objective shift checks: {joined}")
    print("All exact identities, domination certificates and reduction checks passed.")


if __name__ == "__main__":
    run()
