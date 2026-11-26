#!/usr/bin/env python3
"""Finite oblivious full-information game with uniform expected switch budget.

Reconstructed after an executor restart. Version 2 stores an exact rational
model description and uses SciPy only to discover candidate primal/dual points.
The standard-library verifier is independent of this module.
"""
from __future__ import annotations
import argparse
from fractions import Fraction as F
from itertools import product
import json
from pathlib import Path
import numpy as np
from scipy.optimize import linprog
from scipy.sparse import csr_matrix


def model(horizon: int, path_budget, switch_budget, family: str) -> dict:
    actions = [F(-1, 2), F(0), F(1, 2)]
    table = [[F(1, 2) + sign*x/2 + (x*x/2 if family == 'quadratic' else 0)
              for x in actions] for sign in [-1, 1]]
    return {'horizon': horizon, 'path_budget': str(F(str(path_budget))),
            'switch_budget': str(F(str(switch_budget))), 'family': family,
            'actions': list(map(str, actions)),
            'loss_table': [[str(x) for x in row] for row in table]}


def comparator_dp(word, actions, table, budget):
    states = {(i, F(0)): table[word[0]][i] for i in range(len(actions))}
    for loss in word[1:]:
        new = {}
        for (old, spent), value in states.items():
            for j, action in enumerate(actions):
                used = spent + abs(action-actions[old])
                if used <= budget:
                    key = (j, used)
                    candidate = value + table[loss][j]
                    if key not in new or candidate < new[key]:
                        new[key] = candidate
        states = new
    return min(states.values())


def build(data):
    T = data['horizon']; actions = list(map(F, data['actions']))
    table = [[F(v) for v in row] for row in data['loss_table']]
    n = len(actions); k = len(table); P = F(data['path_budget']); B = F(data['switch_budget'])
    histories = [h for depth in range(T) for h in product(range(k), repeat=depth)]
    marginals = {}; joints = {}; cursor = 1
    for h in histories:
        marginals[h] = tuple(range(cursor, cursor+n)); cursor += n
        if h:
            joints[h] = {(i,j): cursor+i*n+j for i in range(n) for j in range(n)}
            cursor += n*n
    eq = [{j:F(1) for j in marginals[()]}]; beq = [F(1)]
    for h in histories[1:]:
        for i in range(n):
            row = {joints[h][i,j]:F(1) for j in range(n)}
            row[marginals[h[:-1]][i]] = F(-1); eq.append(row); beq.append(F(0))
        for j in range(n):
            row = {joints[h][i,j]:F(1) for i in range(n)}
            row[marginals[h][j]] = F(-1); eq.append(row); beq.append(F(0))
    ub = []; bub = []
    words = list(product(range(k), repeat=T))
    for word in words:
        lossrow = {0:F(-1)}; switchrow = {}
        for t in range(T):
            h = word[:t]
            for i in range(n):
                j = marginals[h][i]; lossrow[j] = lossrow.get(j,F(0)) + table[word[t]][i]
            if t:
                for (i,j), index in joints[h].items():
                    if i != j: switchrow[index] = F(1)
        ub.append(lossrow); bub.append(comparator_dp(word, actions, table, P))
        ub.append(switchrow); bub.append(B)
    cost = [F(1)] + [F(0)]*(cursor-1)
    return {'nvars':cursor, 'eq':eq, 'beq':beq, 'ub':ub, 'bub':bub, 'cost':cost,
            'marginals':marginals, 'joints':joints, 'words':words}


def sparse(rows, width):
    r = []; c = []; v = []
    for i, row in enumerate(rows):
        for j, coefficient in row.items():
            if coefficient:
                r.append(i);c.append(j);v.append(float(coefficient))
    return csr_matrix((v,(r,c)),shape=(len(rows),width))


def solve(data):
    game = build(data); width = game['nvars']
    solution = linprog(np.array(game['cost'],dtype=float),
                      A_eq=sparse(game['eq'],width), b_eq=np.array(game['beq'],dtype=float),
                      A_ub=sparse(game['ub'],width), b_ub=np.array(game['bub'],dtype=float),
                      bounds=[(None,None)]+[(0,None)]*(width-1), method='highs')
    if not solution.success: raise RuntimeError(solution.message)
    return game, solution


def diagnostics(max_horizon):
    rows = []
    for T in range(2,max_horizon+1):
        for family in ['linear','quadratic']:
            for P in [0,F(1,2),1]:
                for B in sorted({F(0),F(1,2),F(1),F(T-1)}):
                    data = model(T,P,B,family); game,solution = solve(data)
                    rows.append({'model':data,'value':float(solution.fun),
                                 'nvars':game['nvars'],
                                 'max_flow_residual':float(np.max(np.abs(solution.eqlin.residual))),
                                 'max_constraint_excess':float(max(0,-np.min(solution.ineqlin.residual))),
                                 'certificate_status':'floating_point_diagnostic_only'})
    return {'schema':'finite-game-diagnostics-v2','count':len(rows),'games':rows,
            'limitation':'No finite experiment establishes the continuum asymptotic minimax frontier.'}


if __name__ == '__main__':
    parser = argparse.ArgumentParser(); parser.add_argument('--max-horizon',type=int,default=5)
    parser.add_argument('--output',type=Path,required=True); args = parser.parse_args()
    result = diagnostics(args.max_horizon)
    args.output.parent.mkdir(parents=True,exist_ok=True)
    args.output.write_text(json.dumps(result,indent=2)+'\n')
    print(json.dumps({'count':result['count'],'output':str(args.output)}))
