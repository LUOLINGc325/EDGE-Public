"""Independent finite checks of the author's occurrence-copy hardness gadget."""
from itertools import combinations
import json
from pathlib import Path
from verify_coloring_reduction import require, coloring, channel, exact_cover


def copy_channel(old_rows, old_m):
    rows = [list(row) for row in old_rows]
    labels = old_m
    gadgets = []
    copies = {}
    for y in range(old_m):
        occurrences = [(i, j) for i, row in enumerate(old_rows) for j, z in enumerate(row) if z == y]
        if len(occurrences) <= 1:
            copies[y] = [y]
            continue
        new = list(range(labels, labels + len(occurrences)))
        labels += len(occurrences)
        copies[y] = new
        for (i, j), x in zip(occurrences, new):
            rows[i][j] = x
        for a, b in zip(new, new[1:]):
            u, v = labels, labels + 1
            labels += 2
            rows += [[a, u, v], [b, u, v]]
            gadgets.append((y, a, b, u, v))
    active_labels = sorted(set(y for row in rows for y in row))
    renumber = {y: i for i, y in enumerate(active_labels)}
    return [tuple(renumber[y] for y in row) for row in rows], len(active_labels), copies, gadgets


def audit(v, edges):
    old_rows, old_m = channel(v, edges)
    rows, m, copies, gadgets = copy_channel(old_rows, old_m)
    c = coloring(v, edges)
    solved, columns = exact_cover(rows, m)
    require(solved == (c is not None), 'copied exact-cover / coloring disagree')
    require(max(s.bit_count() for s in columns) <= 3, 'column support exceeds 3')
    require(all(len(set(row)) == 3 for row in rows), 'row support no longer 3')
    require(len(rows) == v + 15*len(edges), 'row count unexpected')
    require(m == 3*v + 21*len(edges), 'column count unexpected')
    require(sum(s.bit_count() for s in columns) == 3*len(rows), 'incidence count')
    return solved


def main():
    total = yes = no = 0
    for v in range(1, 5):
        pairs = list(combinations(range(v), 2))
        for mask in range(1<<len(pairs)):
            edges = [e for j, e in enumerate(pairs) if mask & (1<<j)]
            a = audit(v, edges)
            total += 1
            yes += int(a)
            no += int(not a)
    special = [list(combinations(range(5), 2)), [(i, (i+1)%5) for i in range(5)],
               [(0,i) for i in range(1,5)] + [(1,2),(2,3),(3,4),(1,4)]]
    for edges in special:
        a = audit(5, edges)
        total += 1
        yes += int(a)
        no += int(not a)
    report = {'method':'graph coloring vs copied-incidence exact-cover search',
              'graphs':total,'yes':yes,'no':no,'failed_checks':0,
              'finite_checks_only':True,'max_column_support':3,
              'checked_size_formulas':'N=V+15E, M=3V+21E'}
    results = Path(__file__).resolve().parents[1] / 'results'
    results.mkdir(exist_ok=True)
    (results / 'COPY_REDUCTION_CHECKS.json').write_text(json.dumps(report,indent=2)+'\n')
    print(json.dumps(report))


if __name__ == '__main__':
    main()
