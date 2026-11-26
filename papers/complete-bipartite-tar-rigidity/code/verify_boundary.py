"""Check the finite boundary-constraint formula using Z3's C API."""

import ctypes
from itertools import combinations
import sys


def conjunction(terms):
    return "(and " + " ".join(terms) + ")" if terms else "true"


def disjunction(terms):
    return "(or " + " ".join(terms) + ")" if terms else "false"


def negation(term):
    return f"(not {term})"


def edge(left, right):
    first, second = sorted((left, right))
    return f"e_{first}_{second}"


def matches_complete_bipartite(side, pairs):
    return conjunction([
        edge(a, b) if (a in side) != (b in side) else negation(edge(a, b))
        for a, b in pairs
    ])


def generate(left_size, right_size):
    vertices = range(left_size + right_size)
    left, right = set(vertices[:left_size]), set(vertices[left_size:])
    pairs = list(combinations(vertices, 2))
    output = ["(set-option :timeout 40000)", "(set-logic QF_BV)"]
    conditions = []
    for a, b in pairs:
        output.append(f"(declare-const {edge(a, b)} Bool)")
    for v in vertices:
        conditions.append(disjunction([edge(v, u) for u in vertices if u != v]))

    block = 0
    for side, other in ((left, right), (right, left)):
        for pair in combinations(sorted(side), 2):
            outside = sorted(side - set(pair))
            inside = sorted(other | set(pair))
            inner = {v: f"inner_{block}_{v}" for v in inside}
            for v in inside:
                no_exterior_edges = conjunction([negation(edge(v, w)) for w in outside])
                output.append(f"(define-fun {inner[v]} () Bool {no_exterior_edges})")
            for v in inside:
                neighbors = [conjunction([edge(v, w), inner[w]]) for w in inside if w != v]
                at_least_two = disjunction([conjunction([a, b]) for a, b in combinations(neighbors, 2)])
                conditions.append(disjunction([inner[v], at_least_two]))
            block += 1

    output.extend(f"(assert {condition})" for condition in conditions)
    complete = matches_complete_bipartite(left, pairs)
    output.extend(["(push)", f"(assert {complete})", "(check-sat)", "(pop)"])
    if left_size == right_size == 3:
        # Every pair is a minimum PD set. More than one labelling of
        # the underlying K_3,3 therefore obeys the prescribed family.
        for candidate in combinations(vertices, 3):
            if 0 in candidate:
                isomorphic = matches_complete_bipartite(set(candidate), pairs)
                output.append(f"(assert {negation(isomorphic)})")
    else:
        output.append(f"(assert {negation(complete)})")
    output.append("(check-sat)")
    return "\n".join(output) + "\n"


def solve(program):
    lib = ctypes.CDLL("libz3.so.4")
    lib.Z3_mk_config.restype = ctypes.c_void_p
    lib.Z3_del_config.argtypes = [ctypes.c_void_p]
    lib.Z3_mk_context.argtypes = [ctypes.c_void_p]
    lib.Z3_mk_context.restype = ctypes.c_void_p
    lib.Z3_del_context.argtypes = [ctypes.c_void_p]
    lib.Z3_eval_smtlib2_string.argtypes = [ctypes.c_void_p, ctypes.c_char_p]
    lib.Z3_eval_smtlib2_string.restype = ctypes.c_char_p
    config = lib.Z3_mk_config()
    context = lib.Z3_mk_context(config)
    lib.Z3_del_config(config)
    try:
        return lib.Z3_eval_smtlib2_string(context, program.encode()).decode().split()
    finally:
        lib.Z3_del_context(context)


def main():
    explicitly_selected = [tuple(map(int, sys.argv[1:]))] if len(sys.argv) == 3 else None
    dimensions = explicitly_selected or [(s, t) for s in range(3, 7) for t in range(s, 9)]
    for s, t in dimensions:
        assert 3 <= s <= t
        statuses = solve(generate(s, t))
        assert statuses == ["sat", "unsat"], (s, t, statuses)
        print(f"K_{{{s},{t}}}  labelled graph: SAT  alternative: UNSAT", flush=True)


if __name__ == "__main__":
    main()
