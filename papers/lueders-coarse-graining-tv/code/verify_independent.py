#!/usr/bin/env python3
"""Independent exact-arithmetic audit of the proposed qubit counterexample.

Only Python's standard library is used. No numerical eigensolver, optimizer,
or author verification module is imported. A positive root is represented by
sqrt(scale2) * matrix, so every sandwich can be evaluated rationally.
"""
from fractions import Fraction as F
from itertools import product
import json
from pathlib import Path
import sys


def mat(a, b, c, d):
    return (F(a), F(b), F(c), F(d))


ZERO = mat(0, 0, 0, 0)
ONE = mat(1, 0, 0, 1)


def add(x, y):
    return tuple(a + b for a, b in zip(x, y))


def scale(c, x):
    return tuple(c * a for a in x)


def sub(x, y):
    return add(x, scale(F(-1), y))


def mul(x, y):
    a, b, c, d = x
    e, f, g, h = y
    return (a * e + b * g, a * f + b * h,
            c * e + d * g, c * f + d * h)


def trace(x):
    return x[0] + x[3]


def det(x):
    return x[0] * x[3] - x[1] * x[2]


def positive_semidefinite(x):
    return x[1] == x[2] and x[0] >= 0 and x[3] >= 0 and det(x) >= 0


def require(condition, message):
    if not condition:
        raise ValueError(message)


def smat(x):
    return [[str(x[0]), str(x[1])], [str(x[2]), str(x[3])]]


def sandwich(root, effect):
    r, k = root
    return scale(r, mul(mul(k, effect), k))


A = [mat(F(2, 3), 0, 0, 0),
     mat(F(5, 18), F(1, 6), F(1, 6), F(1, 2)),
     mat(F(1, 18), F(-1, 6), F(-1, 6), F(1, 2))]
B = [mat(F(16, 25), 0, 0, 1), mat(F(9, 25), 0, 0, 0)]
C = [add(A[0], A[1]), A[2]]
KA = [(F(2, 3), mat(1, 0, 0, 0)),
      (F(1, 468), mat(11, 3, 3, 15)),
      (F(1, 180), mat(1, -3, -3, 9))]
KB = [(F(1), mat(F(4, 5), 0, 0, 1)),
      (F(1), mat(F(3, 5), 0, 0, 0))]
KC = [(F(1), mat(F(29, 30), F(1, 10), F(1, 10), F(7, 10))), KA[2]]
STATES = {"fine": mat(F(1, 2), F(1, 2), F(1, 2), F(1, 2)),
          "coarse": mat(F(1, 5), F(2, 5), F(2, 5), F(4, 5))}
TARGETS = {"fine": F(1, 30), "coarse": F(9, 250)}


def main():
    output = {"method": "independent rational 2x2 matrix arithmetic and exhaustive event sums",
              "matrix_checks": {}, "comparisons": {}}
    for name, effects, roots in [("A", A, KA), ("B", B, KB), ("C", C, KC)]:
        require(sum_matrices(effects) == ONE, name + " effects do not sum to I")
        rows = []
        for i, (e, (r, k)) in enumerate(zip(effects, roots)):
            require(positive_semidefinite(e), name + " effect not PSD")
            require(r > 0 and positive_semidefinite(k), name + " root not PSD")
            require(scale(r, mul(k, k)) == e, name + " root does not square to effect")
            rows.append({"outcome": i, "effect": smat(e), "effect_determinant": str(det(e)),
                         "root_scale_squared": str(r), "root_rational_matrix": smat(k),
                         "root_rational_matrix_determinant": str(det(k))})
        output["matrix_checks"][name] = rows
    for name, effects, roots in [("fine", A, KA), ("coarse", C, KC)]:
        labels = list(product(range(len(effects)), range(len(B))))
        X = [sandwich(roots[a], B[b]) for a, b in labels]
        Y = [sandwich(KB[b], effects[a]) for a, b in labels]
        require(sum_matrices(X) == ONE and sum_matrices(Y) == ONE,
                name + " sequential effects not normalized")
        require(all(positive_semidefinite(x) for x in X + Y),
                name + " sequential effect not PSD")
        D = [sub(x, y) for x, y in zip(X, Y)]
        require(sum_matrices(D) == ZERO, name + " differences not zero-sum")
        require(all(trace(d) == 0 and d[1] == d[2] for d in D),
                name + " difference not real symmetric traceless")
        events = []
        for mask in range(1 << len(D)):
            m = sum_matrices([d for i, d in enumerate(D) if (mask >> i) & 1])
            norm2 = m[0] ** 2 + m[1] ** 2
            require(norm2 <= TARGETS[name] ** 2, name + " event exceeds asserted bound")
            events.append({"mask": mask, "z": str(m[0]), "x": str(m[1]),
                           "norm_squared": str(norm2)})
        rho = STATES[name]
        require(positive_semidefinite(rho) and trace(rho) == 1, name + " state invalid")
        p = [trace(mul(rho, x)) for x in X]
        q = [trace(mul(rho, y)) for y in Y]
        require(sum(p) == 1 and sum(q) == 1 and all(t >= 0 for t in p + q),
                name + " witness probabilities invalid")
        tv = sum(abs(x - y) for x, y in zip(p, q)) / 2
        require(tv == TARGETS[name], name + " witness not attaining target")
        output["comparisons"][name] = {
            "outcome_order": labels,
            "differences": [smat(d) for d in D],
            "event_count": len(events), "events": events,
            "maximum_norm_squared": str(max(F(e["norm_squared"]) for e in events)),
            "maximizing_masks": [e["mask"] for e in events
                                 if F(e["norm_squared"]) == TARGETS[name] ** 2],
            "witness_state": smat(rho), "forward_probabilities": list(map(str, p)),
            "reverse_probabilities": list(map(str, q)), "witness_tv": str(tv)}
    gap = TARGETS["coarse"] - TARGETS["fine"]
    require(gap == F(1, 375) and gap > 0, "strict separation failed")
    output["strict_gap"] = str(gap)
    output["status"] = "all_exact_checks_passed"
    text = json.dumps(output, ensure_ascii=False, indent=2) + "\n"
    if len(sys.argv) > 1:
        Path(sys.argv[1]).write_text(text)
    else:
        print(text, end="")


def sum_matrices(xs):
    total = ZERO
    for x in xs:
        total = add(total, x)
    return total


if __name__ == "__main__":
    main()
