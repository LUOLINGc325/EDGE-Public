"""Independently compare every SMT candidate clause with chore EF1 semantics.

Standard library only. This checks construction of the input formula, not its
unsatisfiability. It does not import any author encoder or SMT package.
"""
from fractions import Fraction
from itertools import permutations, product
from pathlib import Path
import hashlib
import json
import re

ROOT = Path(__file__).resolve().parents[1]
INPUT = ROOT / 'proof/problem_wlog.smt2'
VARS = [f'x_{i}_{t}' for i in range(3) for t in range(7)]
WIDTH = len(VARS) + 1  # constant coefficient is last
ZERO = (Fraction(0),) * WIDTH


def top_expressions(text):
    stack = []
    for match in re.finditer(r'\(|\)|[^\s()]+', text):
        token = match.group()
        if token == '(':
            stack.append([])
        elif token == ')':
            node = stack.pop()
            if stack:
                stack[-1].append(node)
            else:
                yield node
        else:
            if not stack:
                raise ValueError('Unexpected top-level atom: ' + token)
            stack[-1].append(token)
    if stack:
        raise ValueError('Unbalanced SMT parentheses')


def plus(left, right):
    return tuple(a + b for a, b in zip(left, right))


def scale(q, value):
    return tuple(q * x for x in value)


def let_environment(bindings, env):
    extended = dict(env)
    # SMT-LIB let binding values see the outer, not the extended environment.
    for name, value in bindings:
        extended[name] = (value, env)
    return extended


def linear(node, env):
    if isinstance(node, str):
        if node in env:
            value, scope = env[node]
            return linear(value, scope)
        out = list(ZERO)
        if node in VARS:
            out[VARS.index(node)] = Fraction(1)
        else:
            out[-1] = Fraction(node)
        return tuple(out)
    op, *args = node
    if op == 'let':
        return linear(args[1], let_environment(args[0], env))
    if op == '+':
        out = ZERO
        for value in args:
            out = plus(out, linear(value, env))
        return out
    if op == '-':
        if len(args) == 1:
            return scale(-1, linear(args[0], env))
        out = linear(args[0], env)
        for value in args[1:]:
            out = plus(out, scale(-1, linear(value, env)))
        return out
    if op == '*':
        out = ZERO[:-1] + (Fraction(1),)
        for value in args:
            value = linear(value, env)
            if all(x == 0 for x in out[:-1]):
                out = scale(out[-1], value)
            elif all(x == 0 for x in value[:-1]):
                out = scale(value[-1], out)
            else:
                raise ValueError('Nonlinear expression')
        return out
    raise ValueError('Unsupported arithmetic operator: ' + op)


def dnf(node, env):
    """Canonical DNF whose atoms are exact coefficient vectors for L > 0."""
    if isinstance(node, str):
        if node == 'false':
            return frozenset()
        if node == 'true':
            return frozenset([frozenset()])
        value, scope = env[node]
        return dnf(value, scope)
    op, *args = node
    if op == 'let':
        return dnf(args[1], let_environment(args[0], env))
    if op == 'or':
        out = frozenset()
        for term in args:
            out |= dnf(term, env)
        return out
    if op == 'and':
        out = frozenset([frozenset()])
        for term in args:
            child = dnf(term, env)
            out = frozenset(a | b for a in out for b in child)
        return out
    if op == 'not':
        child = args[0]
        while isinstance(child, str) and child in env:
            child, env = env[child]
        if isinstance(child, list) and child[0] == '<=':
            atom = plus(linear(child[1], env), scale(-1, linear(child[2], env)))
            return frozenset([frozenset([atom])])
    if op == '<':
        atom = plus(linear(args[1], env), scale(-1, linear(args[0], env)))
        return frozenset([frozenset([atom])])
    raise ValueError('Unsupported Boolean form: ' + repr(node)[:200])


def difference(i, positive, negative):
    out = list(ZERO)
    for t in positive:
        out[7*i+t] += 1
    for t in negative:
        out[7*i+t] -= 1
    return tuple(out)


def semantic_clause(a):
    """a[:7] is a path; a[7] is the proposed envy-free final agent."""
    bundles = [set(), set(), set()]
    disjuncts = set()
    for t, recipient in enumerate(a[:7]):
        bundles[recipient].add(t)
        if t < 3 or len(bundles[recipient]) < 2:
            continue
        for other in range(3):
            if other == recipient:
                continue
            disjuncts.add(frozenset(
                difference(recipient, bundles[recipient] - {removed}, bundles[other])
                for removed in bundles[recipient]
            ))
    recipient = a[7]
    for other in range(3):
        if other != recipient:
            disjuncts.add(frozenset([
                difference(recipient, bundles[recipient], bundles[other])
            ]))
    return frozenset(disjuncts)


def run():
    text = INPUT.read_text()
    expressions = top_expressions(text)
    declared = []
    assertions = []
    for e in expressions:
        if e[0] == 'declare-fun':
            assert e[2:] == [[], 'Real']
            declared.append(e[1])
        elif e[0] == 'assert':
            assertions.append(e[1])
        else:
            raise ValueError('Unexpected input command: ' + e[0])
    assert declared == VARS
    assert len(assertions) == 21 + 1458 + 11
    for name, formula in zip(VARS, assertions[:21]):
        assert formula == ['>=', name, '0.0']
    candidates = [p + q for p in permutations(range(3))
                  for q in product(range(3), repeat=5)]
    assert len(candidates) == 1458
    for index, (a, formula) in enumerate(zip(candidates, assertions[21:-11])):
        actual = dnf(formula, {})
        expected = semantic_clause(a)
        if actual != expected:
            raise AssertionError(f'Candidate mismatch {index}, allocation={a}')
    wlog = [['<=', 'x_0_0', f'x_{i}_{t}'] for i in range(3) for t in range(3)]
    wlog.extend([['<=', 'x_0_1', 'x_0_2'], ['<=', 'x_1_0', 'x_2_0']])
    assert assertions[-11:] == wlog
    return {
        'input': str(INPUT),
        'input_sha256': hashlib.sha256(text.encode()).hexdigest(),
        'cost_variables': 21,
        'cost_domain': 'all nonnegative reals, no upper bound or normalization',
        'nonnegativity_assertions': 21,
        'candidate_paths': 486,
        'final_agent_choices_per_path': 3,
        'candidate_assertions_checked': len(candidates),
        'initial_three_symmetry_assertions': 11,
        'total_assertions': len(assertions),
        'result': 'all candidate Boolean formulas match independently reconstructed prefix-deletion semantics',
        'not_established': 'unsatisfiability, completeness of proof replay, or the universal eight-chore theorem',
    }


if __name__ == '__main__':
    result = run()
    output = Path(__file__).with_name('wlog_encoding_review.json')
    output.write_text(json.dumps(result, indent=2) + '\n')
    print(json.dumps(result))
