#!/usr/bin/env python3
"""Independently implemented, standard-library-only checker for one fixed DAG.

It imports no author checker, Z3, solver binding, or replay-bundle Python module.
The accepted fragment is deliberately narrow: Real constants/variables, unary
minus, addition, scalar multiplication, <=, >=, and propositional connectives.
All input ASTs are compared before any arithmetic/Boolean normalization is used.

Soundness invariant for a checked proof node: the bound source assertions and
its recorded active hypotheses entail its conclusion.  Each rule below either
preserves the union of premise hypotheses or explicitly discharges all of them.
The final node must conclude literal False with an empty hypothesis set.

This checks a rational-arithmetic UNSAT certificate for the exact SMT instance.
It is not a Lean check or a proof of the external temporal-EF1 encoding bridge.
"""

from __future__ import annotations

import argparse
from collections import Counter
from datetime import datetime, timezone
from fractions import Fraction
import hashlib
import json
import math
from pathlib import Path
import re
import sys
import time


SOURCE_SHA256 = "ff9bb4ca88db0497699be272409d58c187ac14c8d3df0424bbef05d7a375377c"
CERTIFICATE_SHA256 = "fc56a793107dc5d60a2767b9e530d901c077bc3badf7d69befffa0c7623fc2f6"
EXPECTED_RULES = {
    "asserted": 715, "def-axiom": 1385, "hypothesis": 2254, "lemma": 7285,
    "mp": 706, "rewrite": 706, "th-lemma": 7906, "unit-resolution": 105952,
}
VARIABLES = [f"x_{i}_{j}" for i in range(3) for j in range(7)]
RULE_KINDS = {
    "asserted": 1282, "hypothesis": 1302, "lemma": 1303, "mp": 1284,
    "rewrite": 1295, "def-axiom": 1308, "unit-resolution": 1304,
    "th-lemma": 1320,
}
TERM_SIGNATURES = {
    "+": (518, ("Real", "Real"), "Real", 2, None),
    "-": (520, ("Real",), "Real", 1, 1),
    "*": (521, ("Real", "Real"), "Real", 2, 2),
    "<=": (514, ("Real", "Real"), "Bool", 2, 2),
    ">=": (515, ("Real", "Real"), "Bool", 2, 2),
    "not": (265, ("Bool",), "Bool", 1, 1),
    "and": (261, ("Bool", "Bool"), "Bool", 2, None),
    "or": (262, ("Bool", "Bool"), "Bool", 2, None),
    "=": (258, ("Bool", "Bool"), "Bool", 2, 2),
    "false": (257, (), "Bool", 0, 0),
    "true": (256, (), "Bool", 0, 0),
}
RATIONAL = re.compile(r"-?(?:0|[1-9][0-9]*)(?:/[1-9][0-9]*)?\Z")
SOURCE_NUMERAL = re.compile(r"(?:0|[1-9][0-9]*)(?:\.[0-9]+)?\Z")
SYMBOL = re.compile(r"[A-Za-z_][A-Za-z0-9_!]*\Z")
RESERVED = set(TERM_SIGNATURES) | {"let", "assert", "check-sat", "set-logic", "declare-fun"}


class Rejected(ValueError):
    """An unsupported or invalid purported certificate is never accepted."""


def require(condition, message):
    if not condition:
        raise Rejected(message)


def sha(data):
    return hashlib.sha256(data).hexdigest()


def exact_integer(value):
    return type(value) is int


def fraction_token(value):
    require(isinstance(value, str) and RATIONAL.fullmatch(value),
            "non-rational or malformed annotation/numeral")
    return Fraction(value)


def unique_object(pairs):
    result = {}
    for key, value in pairs:
        require(key not in result, f"duplicate JSON key: {key}")
        result[key] = value
    return result


def json_document(raw):
    try:
        return json.loads(raw, object_pairs_hook=unique_object,
                          parse_constant=lambda value: (_ for _ in ()).throw(
                              Rejected(f"non-finite JSON value: {value}")))
    except (UnicodeError, json.JSONDecodeError) as exc:
        raise Rejected(f"invalid JSON: {exc}") from exc


def commands(source):
    """Read ordinary SMT s-expressions; do not implement strings or quoted names."""
    stack = []
    for match in re.finditer(r"[()]|;[^\r\n]*|[^\s();]+", source):
        token = match.group()
        if token.startswith(";"):
            continue
        require('"' not in token and "|" not in token and "\\" not in token,
                "quoted/escaped SMT tokens are outside this fragment")
        if token == "(":
            require(len(stack) < 1000, "excessive SMT nesting")
            stack.append([])
        elif token == ")":
            require(bool(stack), "unmatched closing parenthesis")
            expression = stack.pop()
            if stack:
                stack[-1].append(expression)
            else:
                yield expression
        else:
            require(bool(stack), "SMT command outside parentheses")
            stack[-1].append(token)
    require(not stack, "unclosed SMT expression")


class Checker:
    def __init__(self, source_bytes, certificate):
        self.source_bytes = source_bytes
        self.c = certificate
        self.terms = []              # (operator, payload, children, sort)
        self.term_pool = {}
        self.affines = []            # (sorted variable coefficients, constant)
        self.mentions_variable = []  # syntactic, even when coefficients cancel
        self.term_of_node = []
        self.sort_of_node = []
        self.conclusion = []
        self.active = []
        self.rule_counts = Counter()
        self.norm_pool = {}
        self.norm_keys = []
        self.norm_cache = {}
        self.false_norm = self.norm_intern(("false",))
        self.true_norm = self.norm_intern(("true",))
        self.arithmetic_transcript = []
        self.def_axiom_atoms = Counter()
        self.max_hypotheses = 0
        self.used_assertions = set()

    def intern(self, operator, payload, children, sort):
        key = (operator, payload, tuple(children), sort)
        if key in self.term_pool:
            return self.term_pool[key]
        coefficients = {}
        constant = Fraction(0)
        mentions = False
        if sort == "Real":
            if operator == "var":
                coefficients[payload] = Fraction(1)
                mentions = True
            elif operator == "num":
                constant = payload
            else:
                operands = [self.affines[t] for t in children]
                mentions = any(self.mentions_variable[t] for t in children)
                if operator == "+":
                    for terms, value in operands:
                        constant += value
                        for variable, coefficient in terms:
                            coefficients[variable] = coefficients.get(variable, 0) + coefficient
                elif operator == "-":
                    coefficients = {v: -a for v, a in operands[0][0]}
                    constant = -operands[0][1]
                elif operator == "*":
                    require(sum(self.mentions_variable[t] for t in children) <= 1,
                            "nonlinear multiplication, including cancelled variable operands")
                    (left, left_constant), (right, right_constant) = operands
                    coefficients = {v: a * right_constant for v, a in left}
                    for variable, coefficient in right:
                        coefficients[variable] = coefficients.get(variable, 0) + coefficient * left_constant
                    constant = left_constant * right_constant
                else:
                    raise Rejected(f"unsupported Real operator {operator}")
        index = len(self.terms)
        self.term_pool[key] = index
        self.terms.append(key)
        self.affines.append((tuple(sorted((v, a) for v, a in coefficients.items() if a)), constant)
                            if sort == "Real" else None)
        self.mentions_variable.append(mentions)
        return index

    def validate_declarations(self):
        require(isinstance(self.c, dict), "certificate must be an object")
        expected_keys = {"assertions", "declarations", "format", "format_version", "fragment",
                         "nodes", "proof", "query", "result", "rule_counts", "source_smt2",
                         "verification", "z3_version"}
        require(set(self.c) == expected_keys, "unexpected certificate fields")
        require(self.c["format"] == "z3-native-proof-dag" and exact_integer(self.c["format_version"])
                and self.c["format_version"] == 2,
                "unsupported certificate format")
        require(self.c["fragment"] == "qf_lra" and exact_integer(self.c["query"])
                and self.c["query"] == 0 and self.c["result"] == "unsat", "wrong query metadata")
        require(isinstance(self.c["verification"], str) and isinstance(self.c["z3_version"], str),
                "malformed provenance metadata")
        require(isinstance(self.c["source_smt2"], str)
                and self.c["source_smt2"].encode("utf-8") == self.source_bytes,
                "embedded SMT differs from source bytes")
        require(isinstance(self.c["declarations"], list), "declarations must be a list")
        self.declarations = self.c["declarations"]
        self.variables = set()
        for number, declaration in enumerate(self.declarations):
            require(isinstance(declaration, dict)
                    and set(declaration) == {"domain", "kind", "name", "parameters", "range"},
                    f"bad declaration object {number}")
            name, kind = declaration["name"], declaration["kind"]
            domain, result, parameters = (declaration["domain"], declaration["range"],
                                          declaration["parameters"])
            require(isinstance(name, str) and exact_integer(kind)
                    and isinstance(domain, list) and all(s in ("Bool", "Real", "Proof") for s in domain)
                    and result in ("Bool", "Real", "Proof") and isinstance(parameters, list),
                    f"malformed declaration types {number}")
            if kind == 49167:
                require(SYMBOL.fullmatch(name) and name not in RESERVED and not domain
                        and result == "Real" and not parameters and name not in self.variables,
                        "duplicate/unsupported variable declaration")
                self.variables.add(name)
            elif kind == 512:
                require(not domain and result == "Real" and not parameters,
                        "invalid numeral declaration")
                fraction_token(name)
            elif name in TERM_SIGNATURES:
                expected_kind, expected_domain, expected_result, _, _ = TERM_SIGNATURES[name]
                require((kind, tuple(domain), result, parameters)
                        == (expected_kind, expected_domain, expected_result, []),
                        f"operator kind/signature mismatch: {name}")
            elif name in RULE_KINDS:
                require(kind == RULE_KINDS[name] and result == "Proof",
                        f"proof kind/sort mismatch: {name}")
                if name in ("asserted", "hypothesis", "rewrite", "def-axiom", "th-lemma"):
                    expected_domain = ["Bool"]
                elif name == "lemma":
                    expected_domain = ["Proof", "Bool"]
                elif name == "mp":
                    expected_domain = ["Proof", "Proof", "Bool"]
                else:
                    require(len(domain) >= 3, "unit-resolution needs a clause and a unit")
                    expected_domain = ["Proof"] * (len(domain) - 1) + ["Bool"]
                require(domain == expected_domain, f"invalid proof-rule signature: {name}")
                if name == "th-lemma":
                    require(len(parameters) >= 2 and parameters[0] in ("bound", "farkas"),
                            "unsupported arithmetic annotation")
                    for value in parameters[1:]:
                        fraction_token(value)
                else:
                    require(not parameters, f"unexpected parameters for {name}")
            else:
                raise Rejected(f"unsupported declaration: {name}/{kind}")

    def validate_graph(self):
        self.nodes = self.c["nodes"]
        require(isinstance(self.nodes, list) and self.nodes, "empty/malformed node array")
        for index, node in enumerate(self.nodes):
            require(isinstance(node, dict) and set(node) == {"arguments", "declaration"},
                    f"bad graph node {index}")
            d, arguments = node["declaration"], node["arguments"]
            require(exact_integer(d) and 0 <= d < len(self.declarations)
                    and isinstance(arguments, list), f"invalid declaration/arguments at {index}")
            require(all(exact_integer(a) and 0 <= a < index for a in arguments),
                    f"non-topological node reference at {index}")
            declaration = self.declarations[d]
            name, result, domain = declaration["name"], declaration["range"], declaration["domain"]
            if name in ("+", "and", "or"):
                require(len(arguments) >= 2 and all(self.sort_of_node[a] == domain[0] for a in arguments),
                        f"invalid variadic arity/type at {index}")
            else:
                require(len(arguments) == len(domain)
                        and all(self.sort_of_node[a] == s for a, s in zip(arguments, domain)),
                        f"invalid fixed arity/type at {index}")
            term = None
            if result != "Proof":
                if declaration["kind"] == 49167:
                    operator, payload = "var", name
                elif declaration["kind"] == 512:
                    operator, payload = "num", fraction_token(name)
                else:
                    operator, payload = name, None
                term = self.intern(operator, payload, [self.term_of_node[a] for a in arguments], result)
            self.term_of_node.append(term)
            self.sort_of_node.append(result)
            self.conclusion.append(None)
            self.active.append(None)
        root = self.c["proof"]
        require(exact_integer(root) and 0 <= root < len(self.nodes)
                and self.sort_of_node[root] == "Proof", "invalid proof root")
        require(isinstance(self.c["assertions"], list)
                and all(exact_integer(a) and 0 <= a < len(self.nodes)
                        and self.sort_of_node[a] == "Bool" for a in self.c["assertions"]),
                "malformed asserted-input references")

    def expression(self, expression, environment):
        if isinstance(expression, str):
            if expression in environment:
                return environment[expression]
            if SOURCE_NUMERAL.fullmatch(expression):
                return self.intern("num", Fraction(expression), (), "Real")
            if expression in ("true", "false"):
                return self.intern(expression, None, (), "Bool")
            raise Rejected(f"undeclared/unsupported SMT atom {expression}")
        require(isinstance(expression, list) and expression and isinstance(expression[0], str),
                "malformed SMT expression")
        operator = expression[0]
        if operator == "let":
            require(len(expression) == 3 and isinstance(expression[1], list), "malformed let")
            additions = {}
            for binding in expression[1]:
                require(isinstance(binding, list) and len(binding) == 2
                        and isinstance(binding[0], str) and SYMBOL.fullmatch(binding[0])
                        and binding[0] not in RESERVED and binding[0] not in additions,
                        "bad/duplicate let binding")
                # SMT-LIB let is parallel: every RHS sees the OLD environment.
                additions[binding[0]] = self.expression(binding[1], environment)
            body_environment = dict(environment)
            body_environment.update(additions)
            return self.expression(expression[2], body_environment)
        require(operator in TERM_SIGNATURES and operator not in ("true", "false"),
                f"unsupported source operator: {operator}")
        _, domain, result, minimum, maximum = TERM_SIGNATURES[operator]
        children = [self.expression(child, environment) for child in expression[1:]]
        require(len(children) >= minimum and (maximum is None or len(children) == maximum),
                f"unsupported source arity for {operator}")
        expected = [domain[0]] * len(children) if maximum is None else domain
        require(all(self.terms[child][3] == sort for child, sort in zip(children, expected)),
                f"source type mismatch: {operator}")
        return self.intern(operator, None, children, result)

    def bind_source(self):
        try:
            source = self.source_bytes.decode("ascii")
        except UnicodeError as exc:
            raise Rejected("non-ASCII source outside this fixed fragment") from exc
        environment, assertion_terms, declared = {}, [], []
        logic_seen = False
        query_seen = False
        assertions_started = False
        for command in commands(source):
            require(not query_seen, "commands after check-sat")
            require(command and isinstance(command[0], str), "malformed source command")
            name = command[0]
            if name == "set-logic":
                require(not logic_seen and not environment and not assertion_terms
                        and command == ["set-logic", "QF_LRA"], "wrong/repeated SMT logic")
                logic_seen = True
            elif name == "declare-fun":
                require(logic_seen and not assertions_started and len(command) == 4
                        and isinstance(command[1], str) and SYMBOL.fullmatch(command[1])
                        and command[1] not in RESERVED and command[1] not in environment
                        and command[2:] == [[], "Real"], "unsupported source declaration")
                declared.append(command[1])
                environment[command[1]] = self.intern("var", command[1], (), "Real")
            elif name == "assert":
                require(logic_seen and len(command) == 2, "malformed assert")
                assertions_started = True
                term = self.expression(command[1], environment)
                require(self.terms[term][3] == "Bool", "non-Bool source assertion")
                assertion_terms.append(term)
            elif name == "check-sat":
                require(logic_seen and command == ["check-sat"], "invalid query")
                query_seen = True
            else:
                raise Rejected(f"unsupported source command: {name}")
        require(query_seen, "source has no check-sat")
        require(set(declared) == self.variables, "source/certificate symbol mismatch")
        expected = [self.term_of_node[a] for a in self.c["assertions"]]
        require(len(assertion_terms) == len(expected), "source assertion count mismatch")
        for number, (actual, certified) in enumerate(zip(assertion_terms, expected)):
            require(actual == certified, f"source assertion AST mismatch at ordinal {number}")
        self.assertion_terms = set(expected)
        self.source_variables = declared

    def norm_intern(self, key):
        if key not in self.norm_pool:
            self.norm_pool[key] = len(self.norm_keys)
            self.norm_keys.append(key)
        return self.norm_pool[key]

    def negate_norm(self, term):
        if term == self.false_norm:
            return self.true_norm
        if term == self.true_norm:
            return self.false_norm
        key = self.norm_keys[term]
        return key[1] if key[0] == "not" else self.norm_intern(("not", term))

    def difference(self, left, right):
        lc, lv = self.affines[left]
        rc, rv = self.affines[right]
        coefficients = dict(lc)
        for variable, coefficient in rc:
            coefficients[variable] = coefficients.get(variable, 0) - coefficient
        return {v: a for v, a in coefficients.items() if a}, lv - rv

    def normalize(self, term):
        if term in self.norm_cache:
            return self.norm_cache[term]
        operator, _, children, sort = self.terms[term]
        require(sort == "Bool", "normalizing non-Boolean term")
        if operator in ("true", "false"):
            value = self.true_norm if operator == "true" else self.false_norm
        elif operator in ("<=", ">="):
            left, right = children if operator == "<=" else reversed(children)
            coefficients, constant = self.difference(left, right)
            if not coefficients:
                value = self.true_norm if constant <= 0 else self.false_norm
            else:
                denominator = 1
                for coefficient in [*coefficients.values(), constant]:
                    denominator = math.lcm(denominator, coefficient.denominator)
                integers = {v: int(a * denominator) for v, a in coefficients.items()}
                integral_constant = int(constant * denominator)
                divisor = abs(integral_constant)
                for coefficient in integers.values():
                    divisor = math.gcd(divisor, abs(coefficient))
                # Only POSITIVE scaling preserves the direction of <=.
                value = self.norm_intern(("le", tuple(sorted((v, a // divisor)
                                                             for v, a in integers.items())),
                                          integral_constant // divisor))
        elif operator == "not":
            value = self.negate_norm(self.normalize(children[0]))
        elif operator in ("and", "or"):
            neutral = self.true_norm if operator == "and" else self.false_norm
            absorbing = self.false_norm if operator == "and" else self.true_norm
            elements = set()
            for child in children:
                normalized = self.normalize(child)
                key = self.norm_keys[normalized]
                elements.update(key[1] if key[0] == operator else [normalized])
            elements.discard(neutral)
            if absorbing in elements or any(self.negate_norm(t) in elements for t in elements):
                value = absorbing
            elif not elements:
                value = neutral
            elif len(elements) == 1:
                value = next(iter(elements))
            else:
                value = self.norm_intern((operator, tuple(sorted(elements))))
        elif operator == "=":
            left, right = (self.normalize(t) for t in children)
            if left == right:
                value = self.true_norm
            elif left == self.negate_norm(right):
                value = self.false_norm
            elif left in (self.false_norm, self.true_norm):
                value = right if left == self.true_norm else self.negate_norm(right)
            elif right in (self.false_norm, self.true_norm):
                value = left if right == self.true_norm else self.negate_norm(left)
            else:
                value = self.norm_intern(("iff", *sorted((left, right))))
        else:
            raise Rejected(f"unsupported Boolean normalization: {operator}")
        self.norm_cache[term] = value
        return value

    def literal(self, term):
        positive = True
        while self.terms[term][0] == "not":
            term = self.terms[term][2][0]
            positive = not positive
        return term, positive

    def clause_terms(self, term):
        operator, _, children, _ = self.terms[term]
        if operator == "false":
            return ()
        return children if operator == "or" else (term,)

    def clause(self, term):
        return {self.literal(t) for t in self.clause_terms(term)}

    def truth_table(self, term):
        """All rows, with each raw comparison an independent propositional atom."""
        atoms = set()
        stack = [term]
        seen = set()
        while stack:
            current = stack.pop()
            if current in seen:
                continue
            seen.add(current)
            operator, _, children, _ = self.terms[current]
            if operator in ("<=", ">="):
                atoms.add(current)
            elif operator in ("and", "or", "not", "="):
                stack.extend(children)
            else:
                require(operator in ("true", "false"), "unsupported propositional atom")
        require(len(atoms) <= 12, "def-axiom truth table exceeds deliberately narrow limit")
        atoms = sorted(atoms)
        rows = 1 << len(atoms)
        full = (1 << rows) - 1
        table = {atom: sum(1 << row for row in range(rows) if row & (1 << column))
                 for column, atom in enumerate(atoms)}

        def evaluate(current):
            if current in table:
                return table[current]
            operator, _, children, _ = self.terms[current]
            values = [evaluate(child) for child in children]
            if operator == "false":
                value = 0
            elif operator == "true":
                value = full
            elif operator == "not":
                value = full ^ values[0]
            elif operator == "and":
                value = full
                for child in values:
                    value &= child
            elif operator == "or":
                value = 0
                for child in values:
                    value |= child
            elif operator == "=":
                value = full ^ (values[0] ^ values[1])
            else:
                raise Rejected("truth table encountered an unsupported connective")
            table[current] = value
            return value

        require(evaluate(term) == full, "def-axiom is not a propositional tautology")
        self.def_axiom_atoms[len(atoms)] += 1

    def negated_inequality(self, term):
        """Return affine <=0/<0 under the assumption that a clause literal is false."""
        atom, positive_literal = self.literal(term)
        operator, _, children, _ = self.terms[atom]
        require(operator in ("<=", ">="), "non-inequality in arithmetic lemma")
        left, right = children if operator == "<=" else reversed(children)
        # For a positive A=(L<=R), not A means R-L<0.  For not A, its
        # negation means A and hence L-R<=0.  No strictness from zero weights.
        if positive_literal:
            left, right = right, left
        coefficients, constant = self.difference(left, right)
        return coefficients, constant, positive_literal

    def check_arithmetic(self, node_index, conclusion, parameters):
        literals = self.clause_terms(conclusion)
        multipliers = [fraction_token(x) for x in parameters[1:]]
        require(len(literals) == len(multipliers), "Farkas coefficient/constraint count mismatch")
        require(all(coefficient >= 0 for coefficient in multipliers), "negative Farkas multiplier")
        total = {}
        constant = Fraction(0)
        positive_strict = []
        for position, (literal, multiplier) in enumerate(zip(literals, multipliers)):
            coefficients, value, strict = self.negated_inequality(literal)
            constant += multiplier * value
            for variable, coefficient in coefficients.items():
                total[variable] = total.get(variable, 0) + multiplier * coefficient
            if strict and multiplier > 0:
                positive_strict.append(position)
        require(all(coefficient == 0 for coefficient in total.values()), "Farkas variable residual is nonzero")
        require(constant > 0 or (constant == 0 and positive_strict),
                "Farkas combination gives no contradiction (zero-weight strictness is inert)")
        self.arithmetic_transcript.append({
            "proof_node": node_index, "annotation": parameters[0],
            "conclusion_node": self.nodes[node_index]["arguments"][-1],
            "multipliers": [str(x) for x in multipliers],
            "constraint_count": len(literals), "variable_residual": "0",
            "constant_residual": str(constant),
            "strict_constraints_with_positive_multiplier": positive_strict,
            "contradiction_checked": True,
        })

    def check_proofs(self):
        for index, node in enumerate(self.nodes):
            if self.sort_of_node[index] != "Proof":
                continue
            declaration = self.declarations[node["declaration"]]
            rule = declaration["name"]
            premises = node["arguments"][:-1]
            conclusion = self.term_of_node[node["arguments"][-1]]
            hypotheses = frozenset().union(*(self.active[p] for p in premises))
            try:
                if rule == "asserted":
                    require(conclusion in self.assertion_terms, "asserted leaf not among bound source assertions")
                    self.used_assertions.add(conclusion)
                elif rule == "hypothesis":
                    hypotheses = frozenset([self.literal(conclusion)])
                elif rule == "lemma":
                    require(self.terms[self.conclusion[premises[0]]][0] == "false",
                            "lemma child does not conclude False")
                    disjuncts = self.clause(conclusion)
                    missing = {(atom, not sign) for atom, sign in hypotheses} - disjuncts
                    require(not missing, "lemma silently drops active hypotheses")
                    hypotheses = frozenset()
                elif rule == "unit-resolution":
                    remaining = self.clause(self.conclusion[premises[0]])
                    for premise in premises[1:]:
                        atom, sign = self.literal(self.conclusion[premise])
                        complement = (atom, not sign)
                        require(complement in remaining, "resolution unit has no complementary pivot")
                        remaining.remove(complement)
                    require(remaining == self.clause(conclusion), "resolution conclusion is not the residual clause")
                elif rule == "mp":
                    equivalence = self.terms[self.conclusion[premises[1]]]
                    require(equivalence[0] == "=", "mp requires Boolean equivalence")
                    left, right = equivalence[2]
                    antecedent = self.conclusion[premises[0]]
                    require((antecedent == left and conclusion == right)
                            or (antecedent == right and conclusion == left), "mp endpoints do not match")
                elif rule == "rewrite":
                    equivalence = self.terms[conclusion]
                    require(equivalence[0] == "=", "rewrite must assert Boolean equivalence")
                    left, right = equivalence[2]
                    require(self.normalize(left) == self.normalize(right),
                            "rewrite fails exact affine/propositional normalization")
                elif rule == "def-axiom":
                    self.truth_table(conclusion)
                elif rule == "th-lemma":
                    self.check_arithmetic(index, conclusion, declaration["parameters"])
                else:
                    raise Rejected(f"unimplemented proof rule: {rule}")
            except Rejected as exc:
                raise Rejected(f"proof node {index} ({rule}): {exc}") from exc
            self.conclusion[index] = conclusion
            self.active[index] = hypotheses
            self.max_hypotheses = max(self.max_hypotheses, len(hypotheses))
            self.rule_counts[rule] += 1
        declared_counts = self.c["rule_counts"]
        require(isinstance(declared_counts, dict)
                and all(isinstance(k, str) and exact_integer(v) and v > 0
                        for k, v in declared_counts.items())
                and dict(self.rule_counts) == declared_counts, "rule-count metadata mismatch")
        root = self.c["proof"]
        require(self.terms[self.conclusion[root]][0] == "false", "root conclusion is not literal False")
        require(not self.active[root], "root retains active hypotheses")

    def run(self):
        self.validate_declarations()
        self.validate_graph()
        self.bind_source()
        self.check_proofs()
        reachable = set()
        stack = [self.c["proof"]]
        while stack:
            index = stack.pop()
            if index not in reachable:
                reachable.add(index)
                stack.extend(self.nodes[index]["arguments"])
        return {
            "all_nodes_checked": len(self.nodes), "all_declarations_checked": len(self.declarations),
            "all_proof_nodes_checked": sum(self.rule_counts.values()),
            "rule_counts": dict(sorted(self.rule_counts.items())),
            "root_reachable_nodes": len(reachable),
            "root_reachable_proof_nodes": sum(self.sort_of_node[i] == "Proof" for i in reachable),
            "input_binding": {
                "embedded_source_exact_bytes": True,
                "comparison": "ordered raw AST identity after parallel-let expansion and exact numeral parsing",
                "arithmetic_normalization_used_for_input_binding": False,
                "all_assertions_checked": len(self.c["assertions"]),
                "asserted_leaf_count": self.rule_counts["asserted"],
                "distinct_assertions_used_by_proof": len(self.used_assertions),
                "variables": self.source_variables, "variable_count": len(self.source_variables),
            },
            "propositional_checks": {
                "def_axiom_atom_count_histogram": dict(sorted(self.def_axiom_atoms.items())),
                "exhaustive_truth_table_rows": sum((1 << k) * v for k, v in self.def_axiom_atoms.items()),
                "active_hypotheses_tracked_at_every_proof_node": True,
                "all_lemma_hypotheses_explicitly_discharged": True,
                "maximum_active_hypotheses": self.max_hypotheses,
            },
            "arithmetic_checks": {
                "lemmas_checked": len(self.arithmetic_transcript),
                "exact_arithmetic": "fractions.Fraction",
                "nonnegative_multipliers_required": True,
                "strictness_only_from_positive_multipliers": True,
                "zero_variable_residual_in_every_lemma": True,
                "all_contradictions_checked": True,
                "annotation_counts": dict(Counter(t["annotation"] for t in self.arithmetic_transcript)),
            },
            "root": {"node": self.c["proof"], "conclusion": "False", "active_hypotheses": []},
        }


def verify_bundle(source_bytes, certificate_bytes, *, enforce_pins=True):
    """The CLI always enforces pins; tests may exercise small adversarial DAGs."""
    started = time.perf_counter()
    if enforce_pins:
        require(sha(source_bytes) == SOURCE_SHA256, "source SHA-256 does not match fixed instance")
        require(sha(certificate_bytes) == CERTIFICATE_SHA256, "certificate SHA-256 does not match fixed instance")
    checker = Checker(source_bytes, json_document(certificate_bytes))
    checks = checker.run()
    if enforce_pins:
        require(checks["all_nodes_checked"] == 156616
                and checks["all_proof_nodes_checked"] == 126909
                and checks["input_binding"]["all_assertions_checked"] == 1490
                and checks["input_binding"]["variables"] == VARIABLES
                and checks["rule_counts"] == EXPECTED_RULES,
                "fixed-instance inventory differs from independently expected inventory")
    result = {
        "status": "passed_exact_python_certificate_replay",
        "implementation_identity": "new_independent_standard_library_checker_2026_11_25",
        "historical_ec491_checker_recovered": False,
        "fixed_instance_hash_pins_enforced": enforce_pins,
        "source_sha256": sha(source_bytes), "certificate_sha256": sha(certificate_bytes),
        "checker_sha256": sha(Path(__file__).read_bytes()),
        "python_version": sys.version,
        "python_isolated_mode": bool(sys.flags.isolated),
        "python_site_disabled": bool(sys.flags.no_site),
        "dependencies": "Python standard library only; no author/upstream/Z3 imports",
        "elapsed_seconds": round(time.perf_counter() - started, 6),
        "scope": "UNSAT of exactly the bound QF_LRA input under the checked proof rules",
        "lean_kernel_checked": False,
        "temporal_ef1_semantic_bridge_checked": False,
        "external_peer_review_claimed": False,
        **checks,
    }
    return result, checker.arithmetic_transcript


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", required=True, type=Path)
    parser.add_argument("--certificate", required=True, type=Path)
    parser.add_argument("--report", required=True, type=Path)
    parser.add_argument("--arithmetic-transcript", required=True, type=Path)
    arguments = parser.parse_args()
    try:
        report, transcript = verify_bundle(arguments.source.read_bytes(), arguments.certificate.read_bytes())
        arguments.arithmetic_transcript.parent.mkdir(parents=True, exist_ok=True)
        transcript_bytes = (json.dumps(transcript, indent=2, sort_keys=True) + "\n").encode()
        arguments.arithmetic_transcript.write_bytes(transcript_bytes)
        report["arithmetic_transcript_sha256"] = sha(transcript_bytes)
        report["arithmetic_transcript_file"] = arguments.arithmetic_transcript.name
    except (Rejected, OSError, RecursionError) as exc:
        report = {"status": "failed", "error": str(exc),
                  "checker_sha256": sha(Path(__file__).read_bytes())}
        arguments.report.parent.mkdir(parents=True, exist_ok=True)
        arguments.report.write_text(json.dumps(report, indent=2) + "\n")
        print(json.dumps(report), file=sys.stderr)
        return 1
    arguments.report.parent.mkdir(parents=True, exist_ok=True)
    arguments.report.write_text(json.dumps(report, indent=2, sort_keys=True) + "\n")
    print(json.dumps({key: report[key] for key in ("status", "checker_sha256", "elapsed_seconds",
                                                  "all_nodes_checked", "all_proof_nodes_checked")}, sort_keys=True))
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
