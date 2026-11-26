"""Exact finite reference checks for edge-frequency self-deleting paths."""

from collections import defaultdict, deque
from itertools import combinations, product
from random import Random
import json


def require(condition, context):
    if not condition:
        raise RuntimeError(str(context))


def edge(a, b):
    return tuple(sorted((a, b)))


def adjacency(n, edges):
    adj = [[] for _ in range(n)]
    for v, w in edges:
        adj[v].append(w)
        adj[w].append(v)
    return adj


def conforming(path, edges, deleters):
    seen = set()
    for v, w in zip(path, path[1:]):
        seen.add(v)
        e = edge(v, w)
        if e not in edges or not seen.isdisjoint(deleters.get(e, ())):
            return False
    return len(set(path)) == len(path)


def brute_search(n, edges, deleters, s, t, k):
    adj = adjacency(n, edges)
    if k == 0:
        return None
    todo = deque([(s,)])
    while todo:
        path = todo.popleft()
        v = path[-1]
        if v == t:
            return path
        if len(path) == k:
            continue
        for w in adj[v]:
            e = edge(v, w)
            if w not in path and all(d not in path for d in deleters.get(e, ())):
                todo.append(path + (w,))
    return None


def colored_search(n, edges, deleters, colors, s, t, k):
    adj = adjacency(n, edges)
    if colors[s] == k:
        return None
    mask = {e: sum(1 << c for c in {colors[d] for d in deleters.get(e, ())}
                   if c < k) for e in edges}
    start = (s, 1 << colors[s])
    todo = deque([start])
    parents = {start: None}
    while todo:
        state = todo.popleft()
        v, used = state
        if v == t:
            path = []
            while state is not None:
                path.append(state[0])
                state = parents[state]
            return tuple(reversed(path))
        for w in adj[v]:
            bit = 1 << colors[w]
            following = (w, used | bit)
            if colors[w] < k and not (bit & used) and not (mask[edge(v, w)] & used):
                if following not in parents:
                    parents[following] = state
                    todo.append(following)
    return None


def verify_coloring():
    rng = Random(20261125)
    colorings = feasible = 0
    for trial in range(96):
        n = rng.randrange(2, 8)
        k = rng.randrange(1, n+1)
        edges = {e for e in combinations(range(n), 2) if rng.randrange(3)}
        deleters = {e: rng.sample(range(n), rng.randrange(min(4, n+1)))
                    for e in edges}
        s, t = rng.randrange(n), rng.randrange(n)
        brute = brute_search(n, edges, deleters, s, t, k)
        best = None
        # Finite checker only. Isolating every subset directly is expensive.
        # The proved production bound uses the explicit GLP family instead.
        for size in range(1, k+1):
            for selected in combinations(range(n), size):
                colors = [k] * n
                for c, v in enumerate(selected):
                    colors[v] = c
                got = colored_search(n, edges, deleters, colors, s, t, k)
                colorings += 1
                if got is not None:
                    require(got[0] == s and got[-1] == t and len(got) <= k
                            and conforming(got, edges, deleters), (trial, got))
                    if best is None or len(got) < len(best):
                        best = got
        require((None if best is None else len(best))
                == (None if brute is None else len(brute)), ("optimality", trial))
        feasible += int(brute is not None)
    return {"instances": 96, "colorings": colorings, "feasible": feasible}


def sat_reduction(p, clauses):
    edges, deleters, cursor, last_exit = set(), {}, 0, None
    variable_branches = []

    def add_paths(paths):
        for path in paths:
            for a, b in zip(path, path[1:]):
                edges.add(edge(a, b))

    def add_bridge(entrance):
        if last_exit is not None:
            edges.add(edge(last_exit, entrance))

    for _ in range(p):
        a, true, false, b = range(cursor, cursor+4)
        cursor += 4
        add_bridge(a)
        add_paths(((a, true, b), (a, false, b)))
        variable_branches.append((true, false))
        last_exit = b
    for clause in clauses:
        a, p1, p2, p3, u, l2, l3, v, b = range(cursor, cursor+9)
        cursor += 9
        add_bridge(a)
        add_paths(((a, p1, p2, p3, b), (a, u, l2, v, b), (a, u, l3, v, b)))
        marks = [edge(p1, p2), edge(u, l2), edge(u, l3)]
        for literal, marked in zip(clause, marks):
            true, false = variable_branches[abs(literal)-1]
            deleters[marked] = (false if literal > 0 else true,)
        last_exit = b
    return cursor, edges, deleters, 0, last_exit, 3*p+5*len(clauses)


def verify_reduction():
    rng = Random(4906)
    formulas = [(1, [[1, 1, 1]]), (1, [[1, 1, 1], [-1, -1, -1]])]
    for _ in range(58):
        p = rng.randrange(1, 4)
        clauses = [[rng.choice((-1, 1))*rng.randrange(1, p+1) for _ in range(3)]
                   for _ in range(rng.randrange(1, 5))]
        formulas.append((p, clauses))
    sat_count = max_frontier = 0
    for p, clauses in formulas:
        n, edges, deleters, s, t, k = sat_reduction(p, clauses)
        require(n == 4*p+9*len(clauses) and len(deleters) == 3*len(clauses),
                "linear-size construction")
        require(max(map(len, deleters.values())) == 1, "single deleter")
        adj = adjacency(n, edges)
        require(max(map(len, adj)) <= 3, "subcubic")
        bipartition = {0: 0}
        todo = deque([0])
        while todo:
            v = todo.popleft()
            for w in adj[v]:
                if w not in bipartition:
                    bipartition[w] = 1-bipartition[v]
                    todo.append(w)
                require(bipartition[v] != bipartition[w], "bipartite")
        require(len(bipartition) == n, "connected")
        width = max(sum(any(w >= cut for w in adj[v]) for v in range(cut))
                    for cut in range(n+1))
        require(width <= 3, "given ordering pathwidth")
        max_frontier = max(max_frontier, width)
        sat = any(all(any(assignment[abs(literal)-1] == (literal > 0)
                          for literal in clause) for clause in clauses)
                  for assignment in product((False, True), repeat=p))
        answer = brute_search(n, edges, deleters, s, t, k)
        require((answer is not None) == sat, (p, clauses, answer))
        if answer is not None:
            require(len(answer) == k and conforming(answer, edges, deleters),
                    (p, clauses, "exact witness"))
        sat_count += int(sat)
    return {"formulas": len(formulas), "satisfiable": sat_count,
            "unsatisfiable": len(formulas)-sat_count, "max_frontier": max_frontier}


print(json.dumps({"color_search": verify_coloring(),
                  "sat_reduction": verify_reduction()}, indent=2))
