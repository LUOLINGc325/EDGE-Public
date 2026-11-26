"""Exact stopping-enumeration and martingale certificates."""
from fractions import Fraction as Q
from itertools import combinations, product
from random import Random


def nodes(depth):
    return [bits for level in range(depth + 1) for bits in product((0, 1), repeat=level)]


def descendants(law, node):
    return [leaf for leaf in law if leaf[:len(node)] == node]


def mass(law, node):
    return sum(law[leaf] for leaf in descendants(law, node))


def conditional(law, values, node):
    return sum(law[leaf] * values[leaf] for leaf in descendants(law, node)) / mass(law, node)


def stopping_policies(node, depth):
    yield (node,)
    if len(node) < depth:
        left = stopping_policies((*node, 0), depth)
        right = list(stopping_policies((*node, 1), depth))
        for a, b in product(left, right):
            yield (*a, *b)


def stopping_value(law, test, depth):
    return max(sum(mass(law, v) * test[v] for v in policy)
               for policy in stopping_policies((), depth))


def construct_majorant(law, test, depth, level):
    ordered = nodes(depth)
    snell = {}
    for v in reversed(ordered):
        if len(v) == depth:
            snell[v] = test[v]
        else:
            child_mean = sum(mass(law, (*v, j)) * snell[(*v, j)] for j in (0, 1))
            snell[v] = max(test[v], child_mean / mass(law, v))
    assert snell[()] == stopping_value(law, test, depth) == level

    martingale = {(): level}
    for v in ordered:
        if len(v) == depth:
            continue
        children = ((*v, 0), (*v, 1))
        p = [mass(law, w) / mass(law, v) for w in children]
        baseline = sum(pj * snell[w] for pj, w in zip(p, children))
        if baseline == 1:
            for w in children:
                martingale[w] = Q(1)
        else:
            fraction = (martingale[v] - baseline) / (1 - baseline)
            for w in children:
                martingale[w] = snell[w] + fraction * (1 - snell[w])
        assert martingale[v] == sum(pj * martingale[w] for pj, w in zip(p, children))
    assert all(0 <= test[v] <= martingale[v] <= 1 for v in ordered)
    return martingale


def simple_grid_optimum(p1, p2, fixed, level, alternative):
    constraints = [(-1, 0, Q(0)), (0, -1, Q(0)), (1, 0, Q(1)), (0, 1, Q(1))]
    for p in (p1, p2):
        for stop_left, stop_right in product((False, True), repeat=2):
            left = mass(p, (0,)) if stop_left else Q(0)
            right = mass(p, (1,)) if stop_right else Q(0)
            remaining = sum(p[leaf] * fixed[leaf] for leaf in p
                            if not (stop_left if leaf[0] == 0 else stop_right))
            constraints.append((left, right, level - remaining))
    best = None
    for (a, b, c), (d, e, f) in combinations(constraints, 2):
        determinant = a*e - b*d
        if determinant == 0:
            continue
        x, y = (c*e - b*f)/determinant, (a*f - c*d)/determinant
        if all(a*x + b*y <= c for a, b, c in constraints):
            score = mass(alternative, (0,))*x + mass(alternative, (1,))*y
            best = max(best, (score, x, y)) if best else (score, x, y)
    return best


def exact_examples():
    leaves = list(product((0, 1), repeat=2))
    p1 = dict(zip(leaves, (Q(3, 16), Q(1, 16), Q(1, 16), Q(11, 16))))
    p2 = dict(zip(leaves, (Q(1, 20), Q(9, 20), Q(1, 100), Q(49, 100))))
    alternative = dict(zip(leaves, (Q(3, 8), Q(1, 24), Q(1, 8), Q(11, 24))))
    fixed = dict(zip(leaves, map(Q, (1, 0, 1, 0))))
    level = Q(1, 4)

    a, b = (0,), (1,)
    common = (min(conditional(p, fixed, v) for p in (p1, p2)) for v in (a,b))
    assert sum(mass(alternative, v) * g for v, g in zip((a,b), common)) == Q(4, 75)
    optimum, g_a, g_b = simple_grid_optimum(p1, p2, fixed, level, alternative)
    assert (optimum, g_a, g_b) == (Q(2, 9), Q(5, 12), Q(1, 12))
    clip = dict(zip(leaves, (Q(1), Q(19, 54), Q(1), Q(19, 294))))
    assert conditional(p2, clip, ()) == level
    assert tuple(conditional(p2, clip, v) for v in (a, b)) == (g_a, g_b)
    assert stopping_value(p2, {(): level, a: Q(12, 25), b: Q(1, 12), **fixed}, 2) == Q(169, 600)
    print("Two-stage optimum: 2/9 versus common-terminal induction 4/75")
    print("Separate node maxima infeasible jointly: null stopping risk 169/600 > 1/4")

    p1, p2, alt = (Q(2, 5),Q(1, 10),Q(1, 2)), (Q(1, 10),Q(2, 5),Q(1, 2)), (Q(3, 10),Q(3, 10),Q(2, 5))
    level = Q(1, 10)
    individual = [max(range(3), key=lambda j: alt[j]/p[j]) for p in (p1, p2)]
    assert individual == [1, 0] and all(p[j] == level for p, j in zip((p1,p2), individual))
    selected = (Q(1, 5), Q(1, 5), Q(0))
    assert all(sum(w*x for w,x in zip(p, selected)) == level for p in (p1, p2))
    assert sum(w*x for w,x in zip(alt, selected)) == Q(3, 25)
    print("Three-leaf example: min of simple NP optima has power 0; joint optimum 3/25")


def constructed_cases():
    rng = Random(20261124)
    depth = 3
    ordered = nodes(depth)
    leaves = [v for v in ordered if len(v) == depth]
    for _ in range(36):
        p = []
        for _ in range(3):
            weights = [rng.randrange(1, 20) for _ in leaves]
            p.append(dict(zip(leaves, (Q(w, sum(weights)) for w in weights))))
        fixed = {v: Q(rng.randrange(1, 4), 4) for v in leaves}
        level = max(conditional(law, fixed, ()) for law in p)
        baseline = {v: min(conditional(law, fixed, v) for law in p) for v in ordered}
        baseline[()] = level
        singled = (0, 1)
        cap = min([Q(1)] + [conditional(law, fixed, singled)
                            + (level - conditional(law, fixed, ())) / mass(law, singled)
                            for law in p])
        test = {
            v: (baseline[v] + (cap if v == singled else Q(0))) / 2
            for v in ordered if len(v) < depth
        }
        test.update(fixed)
        test[()] = level
        components = [construct_majorant(law, test, depth, level) for law in p]
        induced = {v: min(m[v] for m in components) for v in ordered}
        assert all(induced[v] == fixed[v] for v in leaves)
        assert all(induced[v] >= test[v] for v in ordered)
        assert all(stopping_value(law, induced, depth) == level for law in p)
    print("36 three-stage test families, each checked against all 26 stopping rules per null")


if __name__ == "__main__":
    exact_examples()
    constructed_cases()
