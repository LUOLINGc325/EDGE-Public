"""Exact finite checks of extremal Jordan orders and the trace-visible kernel."""

from itertools import combinations
from math import comb
import json


def require(condition, context):
    if not condition:
        raise RuntimeError(str(context))


def zeros(d):
    return [[0 for _ in range(d)] for _ in range(d)]


def matrix_unit(d, i, j):
    a = zeros(d)
    a[i][j] = 1
    return a


def shear_nilpotent(a):
    # J A + A J^T + J A J^T, using the source shift J.
    d = len(a)
    def at(i, j):
        return a[i][j] if i < d and j < d else 0
    return [[at(i+1, j)+at(i, j+1)+at(i+1, j+1) for j in range(d)]
            for i in range(d)]


def active(a):
    return any(any(row) for row in a)


def loss(d):
    return [[(4 if i == 0 else 3) if i == j else -int(abs(i-j) == 1)
             for j in range(d)] for i in range(d)]


def trace_product(a, b):
    return sum(a[i][j]*b[j][i] for i in range(len(a)) for j in range(len(a)))


def verify_shifts():
    tested = iterate_checks = 0
    for q in range(1, 11):
        q_matrix = loss(q)
        for i in range(q):
            require(q_matrix[i][i] - sum(abs(q_matrix[i][j])
                     for j in range(q) if i != j) >= 1, (q, "positive loss"))
        for i in range(q):
            for j in range(q):
                a = matrix_unit(q, i, j)
                for _ in range(2*q-2):
                    a = shear_nilpotent(a)
                expected = zeros(q)
                if i == j == q-1:
                    expected[0][0] = comb(2*q-2, q-1)
                require(a == expected and not active(shear_nilpotent(a)),
                        (q, i, j, "top source nilpotent power"))
                tested += 1

        start = matrix_unit(q, q-1, q-1)
        def full_nilpotent(u, a):
            # The matrix of 6 R_s - I on the block-diagonal algebra.
            return trace_product(q_matrix, a), shear_nilpotent(a)

        orbit = [(0, start)]
        for _ in range(2*q):
            orbit.append(full_nilpotent(*orbit[-1]))
        require(orbit[-2] == (4*comb(2*q-2, q-1), zeros(q)),
                (q, "visible highest coefficient"))
        require(orbit[-1] == (0, zeros(q)), (q, "next full nilpotent power"))
        state = orbit[0]
        for n in range(1, 25):
            u, a = state
            nu, na = full_nilpotent(u, a)
            state = (u+nu, [[a[i][j]+na[i][j] for j in range(q)] for i in range(q)])
            actual = state[0] + sum(state[1][i][i] for i in range(q))
            expanded = sum(comb(n, power)*(sink + sum(source[i][i] for i in range(q)))
                           for power, (sink, source) in enumerate(orbit[:n+1]))
            require(actual == expanded and actual > 0, (q, n, "ordinary trace"))
            iterate_checks += 1
    return {"max_hilbert_dimension": 11, "matrix_units": tested,
            "ordinary_trace_iterations": iterate_checks}


def verify_grid_paths():
    checked = 0
    for d in range(2, 9):
        for row_steps in combinations(range(2*d-2), d-1):
            chosen = set(row_steps)
            seen = {d-1}
            i = j = d-1
            for step in range(2*d-2):
                if step in chosen:
                    i -= 1
                    require(j in seen, "shared visited column")
                    seen.add(i)
                else:
                    j -= 1
                    require(i in seen, "shared visited row")
                    seen.add(j)
            require(i == j == 0 and len(seen) == d, "saturated path connectivity")
            checked += 1
    return {"max_dimension": 8, "saturated_paths_checked": checked}


print(json.dumps({"physical_and_abstract_shifts": verify_shifts(),
                  "rigidity_grid": verify_grid_paths()}, indent=2))
