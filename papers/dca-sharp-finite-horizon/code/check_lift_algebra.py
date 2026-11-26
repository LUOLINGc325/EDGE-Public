"""Exact all-parameter algebra checks accompanying the analytic proofs.

These checks validate rational identities, not inequality assumptions or the
original infinite family of optimization problems. No floating SDP result is
used. Run with Python 3 and SymPy >= 1.13.
"""
import json
import sympy as S

e, r, A, B = S.symbols('eta rho A B', nonzero=True)
a = e-r
T = A-B
An = (A+1+e)/e**2
Bn = (B+1+r)/r**2
U = An-Bn
checks = []


def check(name, expression):
    numerator = S.cancel(expression).as_numer_denom()[0]
    ok = S.expand(numerator) == 0
    checks.append({'identity': name, 'exact_zero': ok})
    if not ok:
        raise AssertionError((name, S.factor(numerator)))


def main():
    WA = 1-r*Bn+(1-e)*T/(2*a)-e*(1+r)*U/(2*a)
    WB = -r*Bn+(1+r)*T/(2*a)+r*(1-e)*U/(2*a)
    WC, WD = e*U/(2*a), -r*U/(2*a)
    W = {(0, 1): WA, (1, 0): WB, (0, 2): WC, (2, 0): WD}
    H = {(0, 1): (2*a+(1-e-r)*T+e*r*U)/(2*a),
         (2, 1): (2*a+(2-e-r)*T-(e*e+e+r*r+r)*U)/(2*a*(e+r)),
         (3, 1): U/(2*a),
         (0, 2): -(T+e*r*U)/(2*a),
         (1, 2): WB+(1+r)*(WA+WB)/a,
         (1, 3): U/(2*a)}
    x = S.symbols('x0:4')
    z = S.symbols('s0:3')
    hv = S.symbols('h0:4')
    qv = S.symbols('q0:3')
    d = [x[j]-x[j+1] for j in range(3)]
    F = [x[j]**2/2+hv[j]-qv[j] for j in range(3)]
    g = [x[j+1]+z[j] for j in range(3)]
    def iq(i, j):
        dx = x[i]-x[j]
        return qv[i]-qv[j]-g[j]*dx-r*dx**2/2-(g[i]-g[j]-r*dx)**2/(2*a)
    def ih(i, j):
        return hv[i]-hv[j]-z[j-1]*(x[i]-x[j])
    def potential(t, b, c, p, pn):
        return (b+c)*p*p/4+t/(2*a)*(e*r*p*p/2+p*pn+pn*pn/2)
    principal = F[0]-F[1]+(e+r)/(2*a)*(-T*(F[0]-F[1])+U*(F[1]-F[2]))
    principal += potential(T, A, B, d[0], d[1])-potential(U, An, Bn, d[1], d[2])
    certificate = sum(w*iq(j, i)+w*(z[i]-z[j])**2/(2*a) for (i, j), w in W.items())
    certificate += sum(w*ih(i, j) for (i, j), w in H.items())
    # Coefficients are rational functions in all curvature and E parameters.
    poly = S.Poly(S.expand(principal-certificate), *x, *z, *hv, *qv)
    for number, coefficient in enumerate(poly.coeffs()):
        check('D2_local_coefficient_%d' % number, coefficient)

    q, t = S.symbols('q t', nonzero=True)
    b = (e*e*(1-q)+e*q*q-e*q+e+q*q-q)/(2*e*e*q*q)
    ca = -(e*e-e-q+1)/(2*e*e*(e+q))
    cb = (e+q*q+q+1)/(2*q*q*(e+q))
    reverse = H[2, 1].subs(r, -q)
    check('reverse_edge_decomposition', reverse-(b+ca*A+cb*B))
    N = -(q*q+q-1)*e*e+(q*q-q+1)*e+q*q-q
    R = N/(2*e*e*q*q*(e+1))
    check('paired_sum_bound_coefficient', R-ca-(1-q)*cb/(1+e))
    n0, n1, n2 = q*q*(1-q*q), (1-q)*(q*q+q+1)/2, (1-q)*(2-q)
    check('Bernstein_positive_representation', N.subs(e, q+(1-q)*t)-(n0*(1-t)**2+2*n1*t*(1-t)+n2*t*t))
    check('nonconvex_reverse_edge_bound', b+R/(e-1)-(e-q)*(e+1-e*q)/(2*q*q*(e*e-1)))

    Tp = e*e*A-r*r*B-a
    PA = 1-r*B+(1-e)*Tp/(2*a)-e*(1+r)*T/(2*a)
    PB = -r*B+(1+r)*Tp/(2*a)+r*(1-e)*T/(2*a)
    hp = PB+(1+r)*(PA+PB)/a
    D = e*e-r*r
    u = 1-r/(e+r)+((1-e)*(e+r)-2*r)*T/(2*D)
    v = -r/(e+r)+((1+r)*(e+r)-2*r)*T/(2*D)
    check('GN_terminal_skip_cancels', T/(2*a)-(e*v+r*u)/a)
    check('GN_terminal_forward', v+(1+r)*(u+v)/a-(T+a)/D)
    check('GN_terminal_total_support', hp+u+r*(u+v)/a-(1+(e*(1+r)-r)*A/(2*a)+(e*(1-r)-r)*B/(2*a)))
    p=(1+e)*(1+r)/(e+r)
    Sk=(-e*e*r*r*U+T+a)/D
    Sp=(-e*e*r*r*T+Tp+a)/D
    check('P_sum_telescoping_increment', Sk-Sp-p-p*(1-e)*(1-r)*T/a)
    print(json.dumps({'kind': 'symbolic_rational_identity_checks',
                      'all_parameters_symbolic': True,
                      'count': len(checks), 'checks': checks}, indent=2))


if __name__ == '__main__':
    main()
