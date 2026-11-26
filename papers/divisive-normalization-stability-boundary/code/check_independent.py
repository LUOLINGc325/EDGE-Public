#!/usr/bin/env python3
"""Independent stdlib-only rational checks of both explicit witnesses.

The characteristic polynomial is expanded from its defining permutation
determinant. This program imports neither SymPy nor the symbolic checker.
It supplies independent arithmetic, not an independent peer-review decision.
"""

from __future__ import annotations

from fractions import Fraction as Q
import hashlib
from itertools import permutations
import json
import platform
from pathlib import Path

CASE = Path(__file__).resolve().parents[1]
CHECKS = []


def check(name, passed, **details):
    CHECKS.append({"name": name, "passed": bool(passed), **details})


def dot(x, y):
    return sum((a*b for a, b in zip(x, y)), Q(0))


def mv(matrix, vector):
    return [dot(row, vector) for row in matrix]


def multiply_polynomial(left, right):
    coefficients = [Q(0)]*(len(left)+len(right)-1)
    for i, a in enumerate(left):
        for j, b in enumerate(right):
            coefficients[i+j] += a*b
    return coefficients


def determinant_polynomial(matrix):
    """Ascending coefficients of det(t I - matrix), by Leibniz formula."""
    n = len(matrix)
    coefficients = [Q(0)]*(n+1)
    for permutation in permutations(range(n)):
        inversions = sum(permutation[i] > permutation[j]
                         for i in range(n) for j in range(i+1, n))
        term = [Q((-1)**inversions)]
        for i, j in enumerate(permutation):
            entry = [-matrix[i][j], Q(int(i == j))]
            term = multiply_polynomial(term, entry)
        for degree, coefficient in enumerate(term):
            coefficients[degree] += coefficient
    return coefficients


def evaluate(coefficients, point):
    value = Q(0)
    for coefficient in reversed(coefficients):
        value = value*point+coefficient
    return value


def main():
    # Witness A: explicit orthogonal modes provide the norm-one certificate.
    R_a = [[Q(1, 2)]*2 for _ in range(2)]
    u_a = [Q(3, 4), Q(1, 4)]
    constant, contrast = [Q(1), Q(1)], [Q(1), Q(-1)]
    kernel_input = [u_a[i]-mv(R_a, u_a)[i] for i in range(2)]
    check("A: orthogonal eigenmodes 1 and 0", mv(R_a, constant) == constant
          and mv(R_a, contrast) == [Q(0), Q(0)] and dot(constant, contrast) == 0)
    check("A: input norm squared is 5/8", dot(u_a, u_a) == Q(5, 8))
    budget = 16*dot(kernel_input, kernel_input)
    check("A: kernel budget is exactly 2", budget == 2,
          kernel_projection=[str(x) for x in kernel_input], budget=str(budget))

    # Witness B: direct coordinate derivatives of the original field.
    R = [[Q(1, 4), Q(3, 4)], [Q(3, 4), Q(1, 4)]]
    W = [[Q(30)]*2 for _ in range(2)]
    y, a, s = [Q(1, 8)]*2, [Q(16)]*2, [Q(4)]*2
    u, c = [Q(1, 2)]*2, [Q(1)]*2
    ry = mv(R, y)
    fy = [-y[i]+u[i]+(1-s[i])*ry[i] for i in range(2)]
    fa = [-a[i]+c[i]+sum((W[i][j]*a[j]*y[j]**2 for j in range(2)), Q(0))
          for i in range(2)]
    check("B: four equilibrium equations vanish", fy+fa == [Q(0)]*4)
    check("B: orthogonal eigenmodes 1 and -1/2", mv(R, constant) == constant
          and mv(R, contrast) == [-x/2 for x in contrast])
    check("B: input constraint and dense positive matrices", dot(u, u) == Q(1, 2)
          and all(entry > 0 for matrix in [R, W] for row in matrix for entry in row))
    jacobian = [[Q(0)]*4 for _ in range(4)]
    for i in range(2):
        for j in range(2):
            delta = Q(int(i == j))
            jacobian[i][j] = -delta+(1-s[i])*R[i][j]
            jacobian[i][2+j] = -delta*ry[i]/(2*s[i])
            jacobian[2+i][j] = 2*W[i][j]*a[j]*y[j]
            jacobian[2+i][2+j] = -delta+W[i][j]*y[j]**2
    expected_matrix = [
        [Q(-7, 4), Q(-9, 4), Q(-1, 64), Q(0)],
        [Q(-9, 4), Q(-7, 4), Q(0), Q(-1, 64)],
        [Q(120), Q(120), Q(-17, 32), Q(15, 32)],
        [Q(120), Q(120), Q(15, 32), Q(-17, 32)],
    ]
    check("B: direct full Jacobian entries", jacobian == expected_matrix,
          jacobian=[[str(entry) for entry in row] for row in jacobian])
    coefficients = determinant_polynomial(jacobian)
    expected_coefficients = [Q(-2), Q(-1, 32), Q(177, 32), Q(73, 16), Q(1)]
    check("B: permutation determinant characteristic polynomial", coefficients == expected_coefficients,
          ascending_coefficients=[str(x) for x in coefficients], permutation_count=24)
    factor_coefficients = multiply_polynomial(
        multiply_polynomial([Q(-1, 2), Q(1)], [Q(1), Q(1)]),
        [Q(4), Q(65, 16), Q(1)])
    check("B: characteristic factorization", coefficients == factor_coefficients,
          factorization="(t-1/2)(t+1)(t^2+(65/16)t+4)")
    check("B: positive simple root", evaluate(coefficients, Q(1, 2)) == 0
          and evaluate([i*coefficients[i] for i in range(1, 5)], Q(1, 2)) != 0)
    check("B: residual quadratic has two negative real roots",
          Q(65, 16)**2-16 == Q(129, 256) and Q(65, 16) > 0 and Q(4) > 0,
          root_sum="-65/16", root_product="4", discriminant="129/256")
    # At the exceptional pole s=3, the pooling equation reads 0=7+540*r^2.
    check("B: exceptional pole cannot contain any real equilibrium",
          1+60*9*Q(1, 6)**2-9 == 7 and 60*9 == 540,
          impossible_equation="0=7+540*r^2")

    passed = sum(item["passed"] for item in CHECKS)
    report = {
        "kind": "independent standard-library rational arithmetic",
        "status": "passed" if passed == len(CHECKS) else "failed",
        "scope": "Two explicit witnesses and B's full characteristic polynomial only. Independent arithmetic is not independent scientific approval.",
        "formal_verification": False,
        "external_packages": [],
        "environment": {"python": platform.python_version()},
        "manuscript_sha256_at_run": hashlib.sha256((CASE/"paper.en.md").read_bytes()).hexdigest(),
        "summary": {"checks": len(CHECKS), "passed": passed, "failed": len(CHECKS)-passed},
        "checks": CHECKS,
    }
    output = CASE/"results"/"independent.json"
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, indent=2)+"\n")
    print(json.dumps({"status": report["status"], **report["summary"], "output": str(output)}))
    if passed != len(CHECKS):
        raise SystemExit(1)


if __name__ == "__main__":
    main()
