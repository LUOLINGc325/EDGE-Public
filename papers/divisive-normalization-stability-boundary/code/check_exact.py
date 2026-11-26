#!/usr/bin/env python3
"""Exact algebra checks for the manuscript; not a proof-assistant certificate.

All assertions use rational or symbolic arithmetic. Inequality conclusions still
depend on the hypotheses and mathematical arguments stated in the manuscript.
No sampling or floating-point eigensolver is used here.
"""

from __future__ import annotations

import hashlib
import json
import platform
from pathlib import Path

import sympy as sp

CASE = Path(__file__).resolve().parents[1]
CHECKS: list[dict] = []


def check(name: str, condition: bool, **details) -> None:
    CHECKS.append({"name": name, "passed": bool(condition), **details})


def zero(name: str, expression, **details) -> None:
    if isinstance(expression, sp.MatrixBase):
        residual = expression.applyfunc(sp.simplify)
        passed = all(v == 0 for v in residual)
    else:
        residual = sp.simplify(expression)
        passed = residual == 0
    check(name, passed, **details, residual=str(residual))


def strings(matrix: sp.MatrixBase) -> list[list[str]]:
    return [[str(matrix[i, j]) for j in range(matrix.cols)] for i in range(matrix.rows)]


def full_field(y, a, u, c, R, W, ty, ta):
    """Smooth positive-inhibitor branch, valid near every equilibrium."""
    ry = R * y
    fy = sp.Matrix([(-y[i] + u[i] + (1-sp.sqrt(a[i]))*ry[i])/ty[i]
                    for i in range(len(y))])
    fa = sp.Matrix([(-a[i] + c[i] + sum(W[i, j]*a[j]*y[j]**2
                     for j in range(len(y))))/ta[i] for i in range(len(y))])
    return fy.col_join(fa)


def witness_checks():
    q = sp.Rational
    ones = sp.ones(2, 1)
    all_ones = sp.ones(2)
    R_a = all_ones/2
    W_a = 16*all_ones
    u_a = sp.Matrix([q(3, 4), q(1, 4)])
    P0 = sp.eye(2)-R_a
    zero("A: recurrence is a symmetric orthogonal projection", R_a*R_a-R_a)
    zero("A: recurrence symmetric", R_a-R_a.T)
    check("A: recurrence norm is one via spectrum", R_a.eigenvals() == {sp.Integer(0): 1, sp.Integer(1): 1},
          eigenvalues={str(k): v for k, v in R_a.eigenvals().items()})
    zero("A: exact kernel projection", P0*u_a-sp.Matrix([q(1, 4), -q(1, 4)]))
    beta = (16*(P0*u_a).dot(P0*u_a))
    check("A: kernel budget excludes an equilibrium", beta == 2 and beta >= 1,
          kernel_budget=str(beta), implication="1 = 1/s^2 + 16||y||^2 > 2 is impossible for s>0")
    check("A: source input norm and strict positivity", u_a.dot(u_a) == q(5, 8)
          and u_a.dot(u_a) < 1 and all(v > 0 for v in list(R_a)+list(W_a)+list(u_a)),
          input_norm_squared=str(u_a.dot(u_a)))

    R_b = sp.Matrix([[q(1, 4), q(3, 4)], [q(3, 4), q(1, 4)]])
    W_b = 30*all_ones
    u_b = ones/2
    ys = sp.Matrix(sp.symbols("y1:3", real=True))
    av = sp.Matrix(sp.symbols("a1:3", positive=True))
    field = full_field(ys, av, u_b, ones, R_b, W_b, ones, ones)
    at_b = dict(zip(list(ys)+list(av), [q(1, 8), q(1, 8), 16, 16]))
    zero("B: full equilibrium equations", field.subs(at_b))
    check("B: recurrence norm is one via symmetric spectrum", R_b == R_b.T
          and R_b.eigenvals() == {sp.Integer(1): 1, -q(1, 2): 1},
          eigenvalues={str(k): v for k, v in R_b.eigenvals().items()})
    check("B: source input norm and strict positivity", u_b.dot(u_b) == q(1, 2)
          and all(v > 0 for v in list(R_b)+list(W_b)+list(u_b)),
          input_norm_squared=str(u_b.dot(u_b)))
    s, r = sp.symbols("s r", real=True)
    zero("B: synchronous inhibitor root", s**2-1-60*s**2*(q(1, 2)/s)**2-(s**2-16))
    zero("B: singular-pole obstruction", (1+60*9*(q(1, 6)**2+r**2)-9)-(7+540*r**2))
    J = field.jacobian(ys.col_join(av)).subs(at_b)
    t = sp.Symbol("t")
    expected = (t-q(1, 2))*(t+1)*(t**2+q(65, 16)*t+4)
    zero("B: full 4 by 4 characteristic polynomial", J.charpoly(t).as_expr()-expected,
         jacobian=strings(J), characteristic_polynomial=str(sp.expand(expected)),
         factorization=str(expected))
    zero("B: exact symmetric-block discriminant", q(65, 16)**2-16-q(129, 256))
    check("B: hyperbolic unstable direction", J.det() == -2 and J.eigenvals().get(q(1, 2)) == 1,
          determinant=str(J.det()), positive_eigenvalue="1/2")


def shared_jacobian_checks():
    # Dimension three exposes diagonal, off-diagonal, and inhibitor quotient
    # terms. These symbolic checks verify the displayed component formulas;
    # finite dimension checks are not a replacement for the general proof.
    n = 3
    y = sp.Matrix(sp.symbols("y0:3", real=True))
    a = sp.Matrix(sp.symbols("a0:3", positive=True))
    u = sp.Matrix(sp.symbols("u0:3", real=True))
    R = sp.Matrix(n, n, sp.symbols("R0:9", real=True))
    k, c, ty, ta, s = sp.symbols("k c tau_y tau_a s", positive=True)
    field = full_field(y, a, u, c*sp.ones(n, 1), R, k*sp.ones(n),
                       ty*sp.ones(n, 1), ta*sp.ones(n, 1))
    full_J = field.jacobian(y.col_join(a)).subs({a[i]: s**2 for i in range(n)})
    K = sp.eye(n)-(1-s)*R
    expected = (-K/ty).row_join(-sp.diag(*(R*y))/(2*s*ty)).col_join(
        (2*k*s**2*sp.ones(n, 1)*y.T/ta).row_join(
            (-sp.eye(n)+k*sp.ones(n, 1)*sp.Matrix([v**2 for v in y]).T)/ta))
    zero("shared: full positive-inhibitor Jacobian component formula", full_J-expected,
         symbolic_dimension=n)
    zero("shared: exact inhibitor-difference dynamics",
         sp.Matrix([field[n+i]-field[n] + (a[i]-a[0])/ta for i in range(1, n)]))

    A = sp.Symbol("A", positive=True)
    reduced = sp.Matrix([(-y[i]+u[i]+(1-sp.sqrt(A))*(R*y)[i])/ty for i in range(n)]
                        + [(-A+c+k*A*y.dot(y))/ta])
    reduced_J = reduced.jacobian(y.col_join(sp.Matrix([A]))).subs(A, s**2)
    reduced_expected = (-K/ty).row_join(-R*y/(2*s*ty)).col_join(
        (2*k*s**2*y.T/ta).row_join(sp.Matrix([[-c/(s**2*ta)]])))
    # The only substitution needed is the equilibrium normalization equation.
    difference = (reduced_J-reduced_expected).applyfunc(sp.simplify)
    zero("shared: reduced response and off-diagonal blocks", difference[:n, :])
    zero("shared: reduced inhibitor row coupling", difference[n:, :n])
    zero("shared: reduced inhibitor diagonal uses equilibrium equation",
         difference[n, n] - (c/s**2+k*y.dot(y)-1)/ta)

    # An explicit change of coordinates uses a0 as the common coordinate,
    # and ai-a0 as quotient coordinates. The lower-left block must vanish.
    T = sp.eye(2*n)
    for i in range(1, n):
        T[n+i, n] = -1
    transformed = T*full_J*T.inv()
    zero("shared: full Jacobian quotient has no incoming coupling", transformed[n+1:, :n+1])
    zero("shared: quotient eigenvalues are minus inverse tau_a",
         transformed[n+1:, n+1:] + sp.eye(n-1)/ta)


def modal_checks():
    t = sp.Symbol("t")
    s, c, w, ty, ta, r = sp.symbols("s c w tau_y tau_a r", positive=True)
    x, lam = sp.symbols("x lambda", real=True)
    J3 = sp.Matrix([[-s/ty, 0, -x/(2*s*ty)],
                    [0, 0, -lam*r/(2*s*ty)],
                    [2*w*s**2*x/ta, 2*w*s**2*r/ta, -c/(s**2*ta)]])
    L, d = s/ty, c/(s**2*ta)
    g, h = w*s*x**2/(ty*ta), -lam*w*s*r**2/(ty*ta)
    polynomial = t**3+(L+d)*t**2+(L*d+g-h)*t-L*h
    zero("modal: exact 3 by 3 characteristic polynomial", J3.charpoly(t).as_expr()-polynomial,
         characteristic_polynomial="t^3+(L+d)t^2+(Ld+g-h)t-Lh")
    zero("modal: determinant is positive under lambda<0", J3.det()-(-lam)*w*s**2*r**2/(ty**2*ta))

    LL, dd, gg, hh, root = sp.symbols("L d g h positive_root", positive=True)
    p = t**3+(LL+dd)*t**2+(LL*dd+gg-hh)*t-LL*hh
    g_at_root = hh-LL*dd-root**2-(LL+dd)*root+LL*hh/root
    quotient = t**2+(LL+dd+root)*t+LL*hh/root
    zero("modal: remaining pair has negative sum and positive product",
         p.subs(gg, g_at_root)-(t-root)*quotient,
         pair_sum="-(L+d+positive_root)<0", pair_product="L*h/positive_root>0")
    patterns = [[1, 1, 1, -1], [1, 1, 0, -1], [1, 1, -1, -1]]
    changes = []
    for pattern in patterns:
        nonzero = [v for v in pattern if v]
        changes.append(sum(a*b < 0 for a, b in zip(nonzero, nonzero[1:])))
    check("modal: all middle-coefficient sign cases have one Descartes variation",
          changes == [1, 1, 1], sign_patterns=patterns, variations=changes)
    mu = sp.Symbol("mu", real=True)
    zero("modal: pole response eigenvalue", -1+(1-(1-1/lam))*mu-(mu/lam-1))
    # Count algebra: three radial-block modes, n-2 remaining response modes,
    # and n-1 inhibitor quotient modes total 2n.
    n, q, multiplicity = sp.symbols("n q multiplicity", integer=True)
    zero("modal: full index counts add to full state dimension",
         (q+1)+(multiplicity-1)+(2*n-q-multiplicity)-2*n)

    J2 = sp.Matrix([[-s/ty, -x/(2*s*ty)], [2*w*s**2*x/ta, -c/(s**2*ta)]])
    zero("synchronous: determinant under equilibrium relation",
         J2.det().subs(c, s**2*(1-w*x**2))-s/(ty*ta))


def psd_lyapunov_checks():
    k, s, c, ty, ta, l1, l2 = sp.symbols("k s c tau_y tau_a lambda1 lambda2", positive=True)
    y1, y2 = sp.symbols("y1 y2", real=True)
    g1, g2 = 1-l1+l1*s, 1-l2+l2*s
    J = sp.Matrix([[-g1/ty, 0, -l1*y1/(2*s*ty)],
                   [0, -g2/ty, -l2*y2/(2*s*ty)],
                   [2*k*s**2*y1/ta, 2*k*s**2*y2/ta, -c/(s**2*ta)]])
    p1, p2 = 4*k*s**3*ty/(l1*ta), 4*k*s**3*ty/(l2*ta)
    P = sp.diag(p1, p2, 1)
    zero("PSD: diagonal Lyapunov cross terms cancel exactly",
         P*J+J.T*P-sp.diag(-2*p1*g1/ty, -2*p2*g2/ty, -2*c/(s**2*ta)),
         hypotheses="0<lambda1,lambda2<=1; k,s,c,tau_y,tau_a>0; y unrestricted")
    zero("PSD: zero-recurrence mode has no inhibitor feedback", (-l1*y1/(2*s*ty)).subs(l1, 0))
    zero("PSD: zero-recurrence mode eigenvalue", (-g1/ty).subs(l1, 0)+1/ty)
    u, lam = sp.symbols("u lambda", real=True)
    Fterm = c/s**2+k*u**2/(1-lam+lam*s)**2
    zero("PSD: scalar normalization derivative",
         sp.diff(Fterm, s)+2*c/s**3+2*k*lam*u**2/(1-lam+lam*s)**3,
         sign_scope="strictly negative for c>0, 0<=lambda<=1, s>0")


def critical_checks():
    S, w, ty, ta, c, theta = sp.symbols("S w tau_y tau_a c theta", positive=True)
    x0, r, z1, z2 = sp.symbols("x0 r z1 z2", real=True)
    A2, B2 = -w*x0/2, w*S/2
    c_boundary = S**2*(1-w*x0**2)
    zero("critical: first quadratic coefficient cancellation", S*A2+x0*B2)
    zero("critical: second quadratic coefficient cancellation",
         2*w*S**2*x0*A2-2*S*(1-w*x0**2)*B2+w*S**2)
    M = sp.Matrix([[-S/ty, -x0/ty], [w*S*x0/ta, -c/(ta*S**2)]])
    P = sp.diag(w*S*ty, ta)
    zero("critical: explicit diagonal Lyapunov identity",
         M.T*P+P*M-sp.diag(-2*w*S**2, -2*c/S**2),
         P=strings(P), negative_diagonal=["-2*w*S^2", "-2*c/S^2"])
    xx, ss = x0+A2*r**2+z1, S+B2*r**2+z2
    rdot = theta*(ss-S)*r
    zdot = sp.Matrix([(-ss*xx+S*x0)/ty-2*A2*r*rdot,
                      (c_boundary-ss**2+w*ss**2*(xx**2+r**2))/(2*ta*ss)-2*B2*r*rdot])
    M_boundary = M.subs(c, c_boundary)
    F = (zdot-M_boundary*sp.Matrix([z1, z2])).applyfunc(sp.factor)
    zero("critical: exact cubic radial equation", rdot-theta*B2*r**3-theta*z2*r,
         kappa="theta*w*S/2>0")
    F1_explicit = -(A2*B2/ty+2*A2*theta*B2)*r**4-B2*r**2*z1/ty \
                  -(A2/ty+2*A2*theta)*r**2*z2-z1*z2/ty
    zero("critical: full explicit first remainder component", F[0]-F1_explicit)
    origins = {r: 0, z1: 0, z2: 0}
    zero("critical: transformed linear stable block",
         zdot.jacobian(sp.Matrix([z1, z2])).subs(origins)-M_boundary)
    for i in range(2):
        numerator, denominator = sp.fraction(sp.cancel(F[i]))
        monomials = sp.Poly(numerator, r, z1, z2).monoms()
        def allowed(exponents):
            er, e1, e2 = exponents
            ez = e1+e2
            return ez >= 2 or (ez >= 1 and er >= 2) or er >= 4
        check(f"critical: remainder {i+1} has only allowed Taylor monomials",
              all(allowed(m) for m in monomials), monomials=[list(m) for m in monomials],
              denominator=str(denominator),
              bound_scope="O(r^4+r^2||z||+||z||^2), on a compact neighborhood s>=S/2")
    zero("critical: zero input is included without division by input",
         (M_boundary.T*P+P*M_boundary).subs(x0, 0)-sp.diag(-2*w*S**2, -2))
    zero("critical: pole relation", -1+(1-S)*(-1/(S-1)))


def negative_identity_checks():
    c, d, q, v, ty, ta = sp.symbols("c d q v tau_y tau_a", positive=True)
    h = q*(2-sp.sqrt(c)/sp.sqrt(1-d*q**2))
    zero("negative identity: ceiling derivative",
         sp.diff(h, q)-(2-sp.sqrt(c)*(1-d*q**2)**sp.Rational(-3, 2)))
    # t=(c/4)^(1/3), 0<t<1. This substitution avoids implicit radical choices.
    t = sp.Symbol("t", positive=True)
    qstar = sp.sqrt(1-t)/sp.sqrt(d)
    zero("negative identity: ceiling maximizer derivative",
         (2-sp.sqrt(c)*(1-d*q**2)**sp.Rational(-3, 2)).subs({c: 4*t**3, q: qstar}),
         domain="0<t<1; c=4*t^3; d>0")
    zero("negative identity: exact maximum value",
         h.subs({c: 4*t**3, q: qstar})-2*(1-t)**sp.Rational(3, 2)/sp.sqrt(d))
    y, s, w = sp.symbols("y s w", real=True)
    J = sp.Matrix([[(s-2)/ty, y/(2*s*ty)],
                   [2*w*s**2*y/ta, (-1+w*y**2)/ta]])
    zero("negative identity: scalar determinant before normalization",
         J.det()-(2*(1-w*y**2)-s)/(ty*ta))
    zero("negative identity: scalar determinant equals weighted ceiling derivative",
         ((2*v-sp.sqrt(c)/sp.sqrt(v))/(ty*ta))
         -v*(2-sp.sqrt(c)*v**sp.Rational(-3, 2))/(ty*ta),
         substitution="v=1-w*y^2>0; s=sqrt(c)/sqrt(v)")

    # Symbolic n=2 instance with independent heterogeneous time constants and
    # arbitrary nonnegative pooling entries checks every block/sign type.
    n = 2
    xs = sp.Matrix(sp.symbols("x0:2", positive=True))
    us = sp.Matrix(sp.symbols("u0:2", positive=True))
    tys = sp.Matrix(sp.symbols("ty0:2", positive=True))
    tas = sp.Matrix(sp.symbols("ta0:2", positive=True))
    W = sp.Matrix(2, 2, sp.symbols("W0:4", nonnegative=True))
    yy = sp.Matrix(sp.symbols("yy0:2", real=True))
    aa = sp.Matrix(sp.symbols("aa0:2", positive=True))
    cc = sp.Matrix(sp.symbols("cc0:2", positive=True))
    ss = sp.Matrix([2+us[i]/xs[i] for i in range(n)])
    jac = full_field(yy, aa, us, cc, -sp.eye(n), W, tys, tas).jacobian(yy.col_join(aa))
    substitution = {yy[i]: -xs[i] for i in range(n)} | {aa[i]: ss[i]**2 for i in range(n)}
    jac = jac.subs(substitution).applyfunc(sp.simplify)
    A = sp.diag(*(us[i]/(xs[i]*tys[i]) for i in range(n)))
    B = sp.diag(*(-xs[i]/(2*ss[i]*tys[i]) for i in range(n)))
    C = sp.Matrix(n, n, lambda i, j: -2*W[i, j]*ss[j]**2*xs[j]/tas[i])
    D = sp.Matrix(n, n, lambda i, j: (-int(i == j)+W[i, j]*xs[j]**2)/tas[i])
    zero("negative identity: heterogeneous full Jacobian blocks", jac-A.row_join(B).col_join(C.row_join(D)))
    signature = sp.diag(1, 1, -1, -1)
    metzler = (signature*jac*signature).applyfunc(sp.factor)
    off_diagonals = [metzler[i, j] for i in range(2*n) for j in range(2*n) if i != j]
    check("negative identity: sign conjugation has nonnegative off-diagonals",
          all(e.is_nonnegative is True for e in off_diagonals),
          symbolic_dimension=n,
          hypotheses="x_i,u_i,tau_yi,tau_ai>0 and W_ij>=0",
          limitation="Checks signs and identities; the spectral bound uses the manuscript's Perron-Frobenius argument.")
    zero("negative identity: sign conjugation is an invertible involution", signature*signature-sp.eye(2*n))
    u, x, diag_w = sp.symbols("u x diag_w", positive=True)
    zero("negative identity: strict response-diagonal lower-bound identity",
         u/(x*ty)-u*sp.sqrt(diag_w)/ty-u*(1-x*sp.sqrt(diag_w))/(x*ty),
         positivity_requirement="0<x<1/sqrt(diag_w)")


def main():
    witness_checks()
    shared_jacobian_checks()
    modal_checks()
    psd_lyapunov_checks()
    critical_checks()
    negative_identity_checks()
    passed = sum(item["passed"] for item in CHECKS)
    manuscript = CASE/"paper.en.md"
    report = {
        "kind": "exact symbolic algebra checks",
        "status": "passed" if passed == len(CHECKS) else "failed",
        "scope": "Finite exact algebra certificates support, but do not replace, the written general proofs or independent mathematical review.",
        "formal_verification": False,
        "manuscript_sha256_at_run": hashlib.sha256(manuscript.read_bytes()).hexdigest(),
        "environment": {"python": platform.python_version(), "sympy": sp.__version__},
        "summary": {"checks": len(CHECKS), "passed": passed, "failed": len(CHECKS)-passed},
        "checks": CHECKS,
    }
    output = CASE/"results"/"exact.json"
    output.parent.mkdir(parents=True, exist_ok=True)
    output.write_text(json.dumps(report, indent=2, ensure_ascii=False)+"\n")
    print(json.dumps({"status": report["status"], **report["summary"], "output": str(output)}))
    if passed != len(CHECKS):
        for item in CHECKS:
            if not item["passed"]:
                print(json.dumps(item, ensure_ascii=False))
        raise SystemExit(1)


if __name__ == "__main__":
    main()
