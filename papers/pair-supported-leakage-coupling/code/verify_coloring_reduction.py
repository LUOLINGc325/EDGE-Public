"""Independent finite audit of the author's 3COL-to-coupling reduction.

Compares separate graph-coloring backtracking and incidence exact-cover
search. The resulting finite agreement does not replace the universal proof.
"""
from fractions import Fraction as F
from functools import lru_cache
from itertools import combinations
import json
from pathlib import Path


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def coloring(v, edges):
    adj = [set() for _ in range(v)]
    for a, b in edges:
        adj[a].add(b)
        adj[b].add(a)
    order = sorted(range(v), key=lambda x: -len(adj[x]))
    labels = [-1] * v
    def visit(j):
        if j == v:
            return tuple(labels)
        a = order[j]
        bad = {labels[b] for b in adj[a]}
        for c in range(3):
            if c not in bad:
                labels[a] = c
                result = visit(j + 1)
                if result is not None:
                    return result
        labels[a] = -1
        return None
    return visit(0)


def channel(v, edges):
    rows = [tuple(3*i+c for c in range(3)) for i in range(v)]
    for j, (a, b) in enumerate(edges):
        rows += [(3*a+c, 3*b+c, 3*v+3*j+c) for c in range(3)]
    return rows, 3*(v+len(edges))


def exact_cover(rows, m):
    columns = [sum(1 << i for i, row in enumerate(rows) if y in row) for y in range(m)]
    all_rows = (1 << len(rows)) - 1
    @lru_cache(None)
    def visit(covered):
        if covered == all_rows:
            return True
        options = None
        for i, row in enumerate(rows):
            if not covered & (1<<i):
                available = [y for y in row if not columns[y] & covered]
                if not available:
                    return False
                if options is None or len(available) < len(options):
                    options = available
        return any(visit(covered | columns[y]) for y in options)
    return visit(0), columns


def verify(v, edges):
    rows, m = channel(v, edges)
    graph_witness = coloring(v, edges)
    cover, columns = exact_cover(rows, m)
    require(cover == (graph_witness is not None), '3COL / exact-cover disagreement')
    require(max(c.bit_count() for c in columns) <= 5, 'support bound wrong')
    require(all(len(set(row)) == 3 for row in rows), 'row support wrong')
    if graph_witness is not None:
        atoms = []
        for shift in range(3):
            col = [(x+shift)%3 for x in graph_witness]
            atom = [3*i+col[i] for i in range(v)]
            for j, (a, b) in enumerate(edges):
                for c in range(3):
                    atom.append(3*a+c if col[a] == c else 3*b+c if col[b] == c else 3*v+3*j+c)
            require(len(set(atom)) == v+len(edges), 'incorrect yes cost')
            atoms.append(atom)
        for i, row in enumerate(rows):
            require(sorted(atom[i] for atom in atoms) == sorted(row), 'wrong cyclic marginal')
        # The same common-label mixture exactly realizes dense smoothing.
        N = len(rows)
        eps = F(1, 10*N)
        for i, row in enumerate(rows):
            for y in range(m):
                actual = (1-eps)*sum(F(atom[i] == y, 3) for atom in atoms) + eps/F(m)
                prescribed = (1-eps)*F(y in row, 3) + eps/F(m)
                require(actual == prescribed, 'wrong smoothed marginal')
        cost = (1-eps)*(v+len(edges)) + eps
        require(cost == m*((1-eps)/3+eps/m), 'wrong smoothed leakage equality')
    return cover


def main():
    total, yes, no = 0, 0, 0
    for v in range(1, 6):
        pairs = list(combinations(range(v), 2))
        for mask in range(1<<len(pairs)):
            edges = [e for j, e in enumerate(pairs) if mask & (1<<j)]
            result = verify(v, edges)
            total += 1
            yes += int(result)
            no += int(not result)
    report = {'method': 'independent graph coloring vs incidence exact cover',
              'graphs': total, 'colorable': yes, 'not_colorable': no, 'vertices': '1 through 5',
              'max_input_degree': 4, 'failures': 0,
              'finite_checks_only': True, 'dense_yes_couplings': 'exact Fraction marginals checked for every yes instance'}
    results = Path(__file__).resolve().parents[1] / 'results'
    results.mkdir(exist_ok=True)
    (results / 'COLORING_REDUCTION_CHECKS.json').write_text(json.dumps(report, indent=2)+'\n')
    print(json.dumps(report))


if __name__ == '__main__':
    main()
