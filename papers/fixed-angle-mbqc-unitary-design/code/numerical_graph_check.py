import json
import math
from pathlib import Path

import numpy as np

case = Path(__file__).resolve().parents[1] / 'results/two_qubit_graph.json'
with open(case) as fp:
    g = json.load(fp)

weights = {}
for name, descriptor in g['symbolic_weights'].items():
    p = descriptor['p']
    if name.startswith('x_minus_'):
        c = 2*(p*p-1)/(2*p-1)
        val = c/(p+math.sqrt(p*p-(p-2)*c))
    elif name.startswith('x_plus_two_'):
        val = (3-3/math.sqrt(5))/2
    else:
        raise ValueError(name)
    weights[name] = val
    weights[name+'/2'] = val/2

def angle(label):
    fixed = {
        '0': 0,
        'pi/4': math.pi/4,
        'pi/2': math.pi/2,
        '-pi/2': -math.pi/2,
        'acos(1/sqrt(3))': math.acos(1/math.sqrt(3)),
    }
    if label in fixed:
        return fixed[label]
    prefix = '-asin(sqrt('
    assert label.startswith(prefix) and label.endswith('))')
    return -math.asin(math.sqrt(weights[label[len(prefix):-2]]))

I = np.eye(2)
H = np.array([[1, 1], [1, -1]])/np.sqrt(2)
X = np.array([[0, 1], [1, 0]])
CZ = np.diag([1, 1, 1, -1])
units = np.eye(256, dtype=complex).reshape(256, 16, 16)
images = units.copy()
F = np.zeros((16, 16))
for a in range(4):
    for b in range(4):
        F[a*4+b, b*4+a] = 1

def action(U):
    B = np.kron(U, U)
    return B @ images @ B.conj().T

wires = g['vertices_by_wire']
couplings = {tuple(edge) for edge in g['edges']}
wire_of = {}
successor = {}
for j, wire in enumerate(wires):
    wire_of.update((v, j) for v in wire)
    successor.update(zip(wire, wire[1:]))
    for v, w in zip(wire, wire[1:]):
        couplings.remove(tuple(sorted((v, w))))

live = g['inputs'][:]
for v, label in g['measurements_in_program_order']:
    j = wire_of[v]
    edge = tuple(sorted(live))
    assert live[j] == v
    if edge in couplings:
        images = action(CZ)
        couplings.remove(edge)
    phi = angle(label)
    R = np.diag([np.exp(-1j*phi/2), np.exp(1j*phi/2)])
    J = H @ R
    lift = (lambda U: np.kron(U, I)) if j == 0 else (lambda U: np.kron(I, U))
    images = (action(lift(J)) + action(lift(X @ J)))/2
    live[j] = successor[v]
assert not couplings
np.testing.assert_array_equal(live, g['outputs'])
T = np.trace(units, axis1=1, axis2=2)
TF = np.trace(F @ units, axis1=1, axis2=2)
haar = ((T-TF/4)/15)[:, None, None]*np.eye(16) + ((TF-T/4)/15)[:, None, None]*F
error = np.max(np.abs(images-haar))
assert error < 1e-12
print('All 256 matrix units; max absolute error:', format(error, '.6g'))
