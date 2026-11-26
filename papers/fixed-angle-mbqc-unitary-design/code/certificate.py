#!/usr/bin/env python3
"""Exact Pauli-overlap certificate and symbolic open-graph compiler."""

import argparse
from dataclasses import dataclass, field
from fractions import Fraction as F
from itertools import product
import json

# Pauli labels are binary symplectic coordinates (I, X, Z, Y).
I, X, Z, Y = range(4)
SCHEMES = {
    "minus": ((X, X), (Y, Y), (Z, Z)),
    "plus_two": ((X, X), (Y, Y)),
    "plus_many": ((Z, I, X), (I, Z, Z)),
}


def transvection(pauli, axis):
    parity = sum(
        symbol != I and factor != I and symbol != factor
        for symbol, factor in zip(pauli, axis)
    )
    if parity % 2 == 0:
        return pauli
    return tuple(symbol ^ factor for symbol, factor in zip(pauli, axis))


def count_masks(axes):
    width = len(axes[0])
    entries = tuple(product(range(4), repeat=width))
    result = []
    for mask in product((0, 1), repeat=len(axes)):
        a_mass = b_mass = 0
        for source in entries:
            target = source
            for active, axis in zip(mask, axes):
                if active:
                    target = transvection(target, axis)
            if target[-1] == I:
                a_mass += source[-1] == I
                b_mass += all(symbol == I for symbol in source[:-1])
        result.append((mask, a_mass, b_mass))
    return result


def times_linear(poly, constant, slope):
    result = [F(0)] * (len(poly) + 1)
    for degree, coefficient in enumerate(poly):
        result[degree] += coefficient * constant
        result[degree + 1] += coefficient * slope
    return result


def expected_counts(masks, rates):
    result = [[F(0)] * (len(rates) + 1) for _ in range(2)]
    for mask, a_mass, b_mass in masks:
        weight = [F(1)]
        for selected, rate in zip(mask, rates):
            weight = times_linear(weight, 1 - selected, (2 * selected - 1) * rate)
        for out, mass in zip(result, (a_mass, b_mass)):
            for degree, coefficient in enumerate(weight):
                out[degree] += coefficient * mass
    return result


def evaluate(poly, x):
    return sum(coefficient * x**degree for degree, coefficient in enumerate(poly))


def root_bracket(poly):
    lower, upper = F(0), F(1)
    assert evaluate(poly, lower) > 0 > evaluate(poly, upper)
    assert all(
        evaluate(poly, F(j, 32)) > evaluate(poly, F(j + 1, 32))
        for j in range(32)
    )
    for _ in range(32):
        middle = (lower + upper) / 2
        if evaluate(poly, middle) >= 0:
            lower = middle
        else:
            upper = middle
    assert evaluate(poly, lower) >= 0 > evaluate(poly, upper)
    return [str(lower), str(upper)]


def residual(pair, p, active_a, sign):
    local_a, from_b = pair
    spectators = p * p // 4**active_a
    poly = [
        4 * spectators * a + sign * 2 * p * b
        for a, b in zip(local_a, from_b)
    ]
    poly[0] -= F(2 * p * (p + sign * 2)**2, 2 * p + sign)
    while len(poly) > 1 and poly[-1] == 0:
        poly.pop()
    return poly


def angle_expression(name):
    return {
        "minus": "c/(p+sqrt(p*p-(p-2)*c)), c=2*(p*p-1)/(2*p-1)",
        "plus_two": "(3-3/sqrt(5))/2",
        "plus_many": "2*(1-sqrt((p*p+2*p+3)/(2*p*(2*p+1))))",
    }[name]


@dataclass
class Graph:
    width: int
    inputs: list = field(init=False)
    frontier: list = field(init=False)
    vertices_by_wire: list = field(init=False)
    edges: set = field(default_factory=set)
    measurements: dict = field(default_factory=dict)
    weights: dict = field(default_factory=dict)
    next_vertex: int = field(init=False)

    def __post_init__(self):
        self.inputs = list(range(self.width))
        self.frontier = list(self.inputs)
        self.vertices_by_wire = [[vertex] for vertex in self.inputs]
        self.next_vertex = self.width

    def add_edge(self, a, b):
        edge = tuple(sorted((a, b)))
        assert edge[0] != edge[1]
        if edge in self.edges:
            self.edges.remove(edge)
        else:
            self.edges.add(edge)

    def measure(self, wire, phi):
        previous = self.frontier[wire]
        fresh = self.next_vertex
        self.next_vertex += 1
        self.add_edge(previous, fresh)
        assert previous not in self.measurements
        self.measurements[previous] = phi
        self.frontier[wire] = fresh
        self.vertices_by_wire[wire].append(fresh)

    def h(self, wire):
        self.measure(wire, "0")

    def rz(self, wire, phi):
        self.measure(wire, phi)
        self.h(wire)

    def cnot(self, control, target):
        self.h(target)
        self.add_edge(self.frontier[control], self.frontier[target])
        self.h(target)

    def pauli_basis(self, wire, label, inverse):
        if label == X:
            self.h(wire)
        elif label == Y:
            if inverse:
                self.rz(wire, "-pi/2")
                self.h(wire)
            else:
                self.h(wire)
                self.rz(wire, "pi/2")

    def pauli_rotation(self, wire_a, wire_b, a, b, weight):
        self.pauli_basis(wire_a, a, inverse=True)
        self.pauli_basis(wire_b, b, inverse=True)
        self.cnot(wire_a, wire_b)
        self.h(wire_b)
        self.h(wire_b)
        self.rz(wire_b, f"-asin(sqrt({weight}))")
        self.cnot(wire_a, wire_b)
        self.pauli_basis(wire_a, a, inverse=False)
        self.pauli_basis(wire_b, b, inverse=False)

    def group(self, name, wires, coefficients, p):
        weight = f"x_{name}_{p}"
        self.weights[weight] = {"p": p, "expression": angle_expression(name)}
        for axis, coefficient in zip(SCHEMES[name], coefficients):
            a, b = [i for i, label in enumerate(axis) if label != I]
            self.pauli_rotation(wires[a], wires[b], axis[a], axis[b], weight + coefficient)

    def design(self, wires):
        if len(wires) == 1:
            for phi in ("0", "pi/4", "acos(1/sqrt(3))", "pi/4", "0"):
                self.measure(wires[0], phi)
            return

        def local():
            self.design(wires[:-1])
            self.design(wires[-1:])

        p = 2**(len(wires) - 1)
        local()
        self.group("minus", wires[:1] + wires[-1:], ("", "", ""), p)
        local()
        if len(wires) == 2:
            self.group("plus_two", wires, ("", "/2"), p)
        else:
            self.group("plus_many", wires[:2] + wires[-1:], ("", ""), p)
        local()

    def record(self):
        assert set(self.measurements).isdisjoint(self.frontier)
        assert set(range(self.next_vertex)) == set(self.measurements) | set(self.frontier)
        assert_schedule(self.vertices_by_wire, self.measurements, self.edges)
        return {
            "n": self.width,
            "inputs": self.inputs,
            "outputs": self.frontier,
            "vertices_by_wire": self.vertices_by_wire,
            "edges": sorted(self.edges),
            "symbolic_weights": self.weights,
            "measurements_in_program_order": list(self.measurements.items()),
            "basis": "(|0> + (-1)^s exp(-i*phi)|1>)/sqrt(2)",
        }


def assert_schedule(wires, measurements, edges):
    horizon = len(measurements)
    applied = {vertex: t for t, vertex in enumerate(measurements)}
    live = {}
    vertical = set(edges)
    for wire in wires:
        live[wire[0]] = (-1, applied.get(wire[0], horizon))
        for old, fresh in zip(wire, wire[1:]):
            vertical.remove(tuple(sorted((old, fresh))))
            live[fresh] = (applied[old], applied.get(fresh, horizon))
    for a, b in vertical:
        assert max(live[a][0], live[b][0]) < min(live[a][1], live[b][1])


def graph(n):
    assert n >= 1
    compiled = Graph(n)
    compiled.design(tuple(range(n)))
    return compiled.record()


def certificate():
    masks = {name: count_masks(axes) for name, axes in SCHEMES.items()}
    rates = {"minus": (1, 1, 1), "plus_two": (1, F(1, 2)), "plus_many": (1, 1)}
    expected = {
        "minus": [[4, -6, 3, 0], [1, 0, 3, 0]],
        "plus_two": [[4, -3, F(1, 2)], [1, 0, F(1, 2)]],
        "plus_many": [[16, -16, 4], [1, 0, 0]],
    }
    polynomials = {name: expected_counts(masks[name], rates[name]) for name in SCHEMES}
    assert polynomials == expected
    entries = []
    for n in (2, 3, 4, 5, 8, 16, 32):
        p = 2**(n - 1)
        minus = residual(polynomials["minus"], p, 1, -1)
        c = F(2 * (p * p - 1), 2 * p - 1)
        expected_minus = [3 * p * c, -6 * p * p, 3 * p * (p - 2)]
        if p == 2:
            expected_minus.pop()
        assert minus == expected_minus
        if n == 2:
            plus = residual(polynomials["plus_two"], p, 1, 1)
            assert plus == [F(36, 5), -12, 4]
        else:
            plus = residual(polynomials["plus_many"], p, 2, 1)
            s = F(p * p + 2 * p + 3, 2 * p * (2 * p + 1))
            assert F(1, 4) < s < 1
            assert plus == [4 * p * p * (1 - s), -4 * p * p, p * p]
        entries.append({
            "n": n,
            "negative_root_32step_bracket": root_bracket(minus),
            "positive_root_32step_bracket": root_bracket(plus),
        })
    graph_counts = []
    for n in range(1, 6):
        record = graph(n)
        graph_counts.append({
            "n": n,
            "measurements": len(record["measurements_in_program_order"]),
            "edges": len(record["edges"]),
            "symbolic_weights": len(record["symbolic_weights"]),
        })
    return {
        "method": "exact fractions and binary Pauli enumeration",
        "independent_Pauli_masks_checked": sum(len(rows) for rows in masks.values()),
        "active_masks": masks,
        "raw_overlap_coefficients_ascending": {
            name: [list(map(str, row)) for row in pair]
            for name, pair in polynomials.items()
        },
        "dimensions_checked": entries,
        "compiled_graphs": graph_counts,
    }


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--graph", type=int, help="print the symbolic fixed graph on n input wires")
    args = parser.parse_args()
    if args.graph is not None and args.graph < 1:
        parser.error("graph width must be positive")
    print(json.dumps(certificate() if args.graph is None else graph(args.graph), indent=2))


if __name__ == "__main__":
    main()
