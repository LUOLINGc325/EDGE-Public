"""Exact finite computations for approximate-LDP likelihood-column geometry.

All certificates use fractions.Fraction.  No floating-point arithmetic is used.
This module checks finite instances; it does not replace the general proofs.
"""

from __future__ import annotations

from fractions import Fraction as F
from itertools import combinations, permutations, product


def canonical_rays(k: int, multiplier: F):
    """Generate the proposed normalized prototype family, removing duplicates."""
    e = F(multiplier)
    if k < 1 or e < 1:
        raise ValueError("Require k >= 1 and multiplier >= 1")
    ans = set()
    for s in range(1, k + 1):
        for support in combinations(range(k), s):
            if e == 1:
                r = [F(0)] * k
                for i in support:
                    r[i] = F(1, s)
                ans.add(tuple(r))
                continue
            if s == 1:
                r = [F(0)] * k
                r[support[0]] = F(1)
                ans.add(tuple(r))
                continue
            for m in range(1, s):
                for heights in product(range(m + 1), repeat=s):
                    if len(set(heights)) != m + 1:
                        continue
                    values = [e**h for h in heights]
                    total = sum(values)
                    r = [F(0)] * k
                    for i, value in zip(support, values):
                        r[i] = value / total
                    ans.add(tuple(r))
    return sorted(ans)


def rref(matrix, ncols=None):
    a = [[F(x) for x in row] for row in matrix]
    n = ncols if ncols is not None else (len(a[0]) if a else 0)
    pivot_columns = []
    target = 0
    for col in range(n):
        found = next((i for i in range(target, len(a)) if a[i][col]), None)
        if found is None:
            continue
        a[target], a[found] = a[found], a[target]
        divisor = a[target][col]
        a[target] = [v / divisor for v in a[target]]
        for i in range(len(a)):
            if i != target and a[i][col]:
                factor = a[i][col]
                a[i] = [x - factor * y for x, y in zip(a[i], a[target])]
        pivot_columns.append(col)
        target += 1
        if target == len(a):
            break
    return a, pivot_columns


def normalized_nonnegative_kernel_ray(matrix, k):
    a, pivots = rref(matrix, k)
    if len(pivots) != k - 1:
        return None
    free = next(j for j in range(k) if j not in pivots)
    v = [F(0)] * k
    v[free] = F(1)
    for row, pivot in zip(a, pivots):
        v[pivot] = -row[free]
    if all(x <= 0 for x in v):
        v = [-x for x in v]
    if any(x < 0 for x in v):
        return None
    total = sum(v)
    return tuple(x / total for x in v)


def arrangement_rays(k: int, multiplier: F):
    """Independent rank enumeration of nonnegative one-dimensional faces.

    Enumerates (k-1)-sets of boundaries v_i=0 and v_i=E*v_j, without
    assuming a geometric-height representation.  The returned dictionary
    records one exact active-row rank certificate for every found ray.
    """
    e = F(multiplier)
    normals = set()
    for i in range(k):
        a = [F(0)] * k
        a[i] = F(1)
        normals.add(tuple(a))
    for i in range(k):
        for j in range(k):
            if i == j:
                continue
            a = [F(0)] * k
            a[i] = F(1)
            a[j] = -e
            first = next(x for x in a if x)
            normals.add(tuple(x / first for x in a))
    normals = sorted(normals)
    found = {}
    for indices in combinations(range(len(normals)), k - 1):
        rows = tuple(normals[i] for i in indices)
        ray = normalized_nonnegative_kernel_ray(rows, k)
        if ray is not None:
            found.setdefault(ray, rows)
    return found


def pairs(k):
    return [(i, j) for i in range(k) for j in range(k) if i != j]


def positive_part(x):
    return max(F(0), x)


def ray_losses(ray, multiplier):
    e = F(multiplier)
    return {(i, j): positive_part(ray[i] - e * ray[j]) for i, j in pairs(len(ray))}


def channel_rows(columns):
    if not columns:
        raise ValueError("A channel requires nonempty columns")
    k = len(columns[0])
    return [sum(v[i] for v in columns) for i in range(k)]


def channel_losses(columns, multiplier):
    k = len(columns[0])
    e = F(multiplier)
    return {
        (i, j): sum(positive_part(v[i] - e * v[j]) for v in columns)
        for i, j in pairs(k)
    }


def graph_components(ray, multiplier, active_pairs=None):
    e = F(multiplier)
    allowed = set(pairs(len(ray))) if active_pairs is None else set(active_pairs)
    support = {i for i, x in enumerate(ray) if x > 0}
    adjacency = {i: set() for i in support}
    for i, j in allowed:
        if i in support and j in support and ray[i] == e * ray[j]:
            adjacency[i].add(j)
            adjacency[j].add(i)
    remaining = set(support)
    components = []
    while remaining:
        stack = [min(remaining)]
        component = set()
        while stack:
            i = stack.pop()
            if i in component:
                continue
            component.add(i)
            stack.extend(adjacency[i] - component)
        remaining -= component
        components.append(sorted(component))
    return components


def exact_maximality_check(columns, multiplier, budgets):
    """Check the proposed criterion; the output is not a proof of equivalence."""
    losses = channel_losses(columns, multiplier)
    active = [p for p in losses if losses[p] == budgets[p]]
    comps = [graph_components(v, multiplier, active) for v in columns if any(v)]
    return {
        "stochastic": channel_rows(columns) == [F(1)] * len(columns[0]),
        "feasible": all(losses[p] <= budgets[p] for p in losses),
        "active_pairs": active,
        "components": comps,
        "all_nonzero_column_graphs_connected": all(len(c) == 1 for c in comps),
    }


def orbit_channel(values):
    raw = sorted(set(permutations(map(F, values))))
    k = len(values)
    column_scale = F(k, len(raw)) / sum(map(F, values))
    return [tuple(column_scale * x for x in ray) for ray in raw]


def all_prototype_channel(k, multiplier):
    rays = canonical_rays(k, multiplier)
    scale = F(k, len(rays))
    return [tuple(scale * x for x in ray) for ray in rays]


def chi_square_column(column):
    """Homogeneous column utility, whose channel sum minus one is chi-square MI."""
    total = sum(column)
    return sum(x * x for x in column) / total if total else F(0)


class ExactLP:
    """Two-phase rational primal simplex, with exact primal/dual certificates.

    Input: maximize c*x subject to equality rows Aeq*x=beq,
    inequality rows Aub*x<=bub, x>=0.  All right-hand sides must be >=0.
    Bland entering/leaving choices make degeneracy deterministic.
    """

    def __init__(self, c, aeq, beq, aub, bub):
        self.c = list(map(F, c))
        self.n = len(c)
        self.eq = len(aeq)
        self.ineq = len(aub)
        self.original_rows = self.eq + self.ineq
        self.original_a = [list(map(F, row)) for row in list(aeq) + list(aub)]
        self.original_b = list(map(F, list(beq) + list(bub)))
        if any(b < 0 for b in self.original_b):
            raise ValueError("This implementation requires nonnegative RHS")
        if any(len(row) != self.n for row in self.original_a):
            raise ValueError("Wrong row dimension")
        self.nonart = self.n + self.ineq
        width = self.nonart + self.eq
        self.a = [row + [F(0)] * (width - self.n) for row in self.original_a]
        self.b = list(self.original_b)
        self.basis = []
        for i in range(self.eq):
            j = self.nonart + i
            self.a[i][j] = F(1)
            self.basis.append(j)
        for i in range(self.ineq):
            j = self.n + i
            self.a[self.eq + i][j] = F(1)
            self.basis.append(j)
        self.transform = [
            [F(i == j) for j in range(self.original_rows)]
            for i in range(self.original_rows)
        ]
        self.pivots = 0

    def pivot(self, row, col):
        p = self.a[row][col]
        self.a[row] = [x / p for x in self.a[row]]
        self.b[row] /= p
        self.transform[row] = [x / p for x in self.transform[row]]
        for i in range(len(self.a)):
            if i == row or not self.a[i][col]:
                continue
            f = self.a[i][col]
            self.a[i] = [x - f * y for x, y in zip(self.a[i], self.a[row])]
            self.b[i] -= f * self.b[row]
            self.transform[i] = [
                x - f * y for x, y in zip(self.transform[i], self.transform[row])
            ]
        self.basis[row] = col
        self.pivots += 1

    def simplex(self, cost):
        for _ in range(10000):
            reduced = [
                cost[j] - sum(cost[basic] * row[j] for basic, row in zip(self.basis, self.a))
                for j in range(len(cost))
            ]
            enter = next((j for j, x in enumerate(reduced) if x > 0), None)
            if enter is None:
                return sum(cost[j] * b for j, b in zip(self.basis, self.b))
            choices = [
                (self.b[i] / row[enter], self.basis[i], i)
                for i, row in enumerate(self.a) if row[enter] > 0
            ]
            if not choices:
                raise ValueError("LP unbounded")
            leave = min(choices)[2]
            self.pivot(leave, enter)
        raise RuntimeError("Simplex iteration limit reached")

    def solve(self):
        phase1 = [F(0)] * self.nonart + [F(-1)] * self.eq
        phase1_opt = self.simplex(phase1)
        if phase1_opt != 0:
            raise ValueError("LP infeasible, exact phase-I value " + str(phase1_opt))
        for i in reversed(range(len(self.a))):
            if self.basis[i] < self.nonart:
                continue
            enter = next((j for j in range(self.nonart) if self.a[i][j]), None)
            if enter is not None:
                self.pivot(i, enter)
            else:
                assert self.b[i] == 0
                del self.a[i], self.b[i], self.basis[i], self.transform[i]
        self.a = [row[:self.nonart] for row in self.a]
        cost = self.c + [F(0)] * self.ineq
        optimum = self.simplex(cost)
        primal = [F(0)] * self.nonart
        for j, b in zip(self.basis, self.b):
            primal[j] = b
        dual = [
            sum(cost[basic] * t[j] for basic, t in zip(self.basis, self.transform))
            for j in range(self.original_rows)
        ]
        certificate = {
            "primal": primal[:self.n],
            "dual_equalities": dual[:self.eq],
            "dual_inequalities": dual[self.eq:],
            "objective": optimum,
            "pivots": self.pivots,
        }
        self.verify(certificate)
        return certificate

    def verify(self, certificate):
        x = certificate["primal"]
        y = certificate["dual_equalities"] + certificate["dual_inequalities"]
        assert len(x) == self.n and all(t >= 0 for t in x)
        lhs = [sum(a * b for a, b in zip(row, x)) for row in self.original_a]
        assert lhs[:self.eq] == self.original_b[:self.eq]
        assert all(a <= b for a, b in zip(lhs[self.eq:], self.original_b[self.eq:]))
        assert all(t >= 0 for t in y[self.eq:])
        assert all(
            sum(y[i] * self.original_a[i][j] for i in range(self.original_rows)) >= self.c[j]
            for j in range(self.n)
        )
        primal_value = sum(a * b for a, b in zip(self.c, x))
        dual_value = sum(a * b for a, b in zip(y, self.original_b))
        assert primal_value == dual_value == certificate["objective"]
        return True


def utility_lp(k, multiplier, budgets, utility=chi_square_column):
    rays = canonical_rays(k, multiplier)
    costs = [utility(ray) for ray in rays]
    aeq = [[ray[i] for ray in rays] for i in range(k)]
    ordered_pairs = pairs(k)
    aub = [
        [positive_part(ray[i] - F(multiplier) * ray[j]) for ray in rays]
        for i, j in ordered_pairs
    ]
    lp = ExactLP(costs, aeq, [F(1)] * k, aub, [F(budgets[p]) for p in ordered_pairs])
    cert = lp.solve()
    cert["rays"] = rays
    cert["ordered_pairs"] = ordered_pairs
    cert["budgets"] = [F(budgets[p]) for p in ordered_pairs]
    cert["support"] = [i for i, alpha in enumerate(cert["primal"]) if alpha]
    cert["chi_square_mutual_information"] = cert["objective"] - 1
    return cert


def refinement_lp(columns, multiplier, budgets):
    """Best exact quadratic-statistic refinement using the proposed ray set.

    This optimizes all split coefficients directly, without using the active
    graph criterion to constrain or select any feasible refinement.
    """
    k = len(columns[0])
    rays = canonical_rays(k, multiplier)
    n = len(rays)
    ysize = len(columns)
    variables = [(y, r) for y in range(ysize) for r in range(n)]
    costs = [chi_square_column(rays[r]) for y, r in variables]
    aeq, beq = [], []
    for y in range(ysize):
        for i in range(k):
            aeq.append([rays[r][i] if z == y else F(0) for z, r in variables])
            beq.append(columns[y][i])
    pp = pairs(k)
    aub = [
        [positive_part(rays[r][i] - F(multiplier) * rays[r][j]) for y, r in variables]
        for i, j in pp
    ]
    lp = ExactLP(costs, aeq, beq, aub, [budgets[p] for p in pp])
    cert = lp.solve()
    cert["original_statistic"] = sum(chi_square_column(v) for v in columns)
    cert["strict_gain"] = cert["objective"] - cert["original_statistic"]
    return cert


def fraction_json(value):
    if isinstance(value, F):
        return str(value)
    if isinstance(value, dict):
        return {str(k): fraction_json(v) for k, v in value.items()}
    if isinstance(value, (tuple, list)):
        return [fraction_json(v) for v in value]
    return value
