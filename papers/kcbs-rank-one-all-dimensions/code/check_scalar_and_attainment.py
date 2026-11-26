"""Independent exact checks supporting the KCBS manuscript review.

These checks verify polynomial/radical identities, not the analytic implications
or the general theorem.  Positivity, domains, and limits are reviewed separately.
"""
from pathlib import Path
import json
import sympy as S

x, y, z, r, u, p, s = S.symbols("x y z r u p s", real=True)
k = (1-x)*(1-z)
F = lambda t: k*((1-t)*u*(u+2)+(1-t)**2+t*(x+z))-t
checks = {}
checks["scalar_endpoint_difference"] = S.expand(
    F(y)-F(r)-(r-y)*(1+k*(u*(u+2)+2-x-z-y-r))) == 0
case_a = S.Poly(S.expand(F(k)-k*(u+1)*(2*u-k*(u+1))), u)
checks["case_a_endpoint_factorization"] = S.rem(
    case_a, S.Poly(u*u-x*z*k, u)).is_zero
checks["case_a_auxiliary_factorization"] = S.expand(
    (1-2*r)*(2-r)**2-(1-r)-(3-2*r)*(r*r-3*r+1)) == 0

xx = 1-p
B = 2-3*p+2*p*p
f = p*s*(B+xx*(p*p-1)*s-p*p*xx*s*s+2*p*u)-xx
case_b = S.Poly(S.expand(F(x).subs({x:xx,z:1-s})-f), u)
checks["case_b_endpoint_expansion"] = S.rem(
    case_b, S.Poly(u*u-xx*p*s*(1-s), u)).is_zero
R = 3*p**5-5*p**4+2*p**3+4*p*p-5*p+2
bern = (2*(1-p)**5+5*p*(1-p)**4+4*p*p*(1-p)**3
        +4*p**3*(1-p)**2+p**4*(1-p)+p**5)
checks["case_b_positive_polynomial_expansion"] = S.expand(R-bern)==0

# Final, derivative-free replacement for the case-B argument.
ell = xx/p
g = p*s*(B+xx*(p*p-1)*s-p*p*xx*s*s+2*p*p*xx)-xx
checks["case_b_sqrt_lower_bound_identity"] = S.expand(
    xx*p*s*(1-s)-xx*xx*p*p-xx*p*(s-xx)*(p-s))==0
slope = B+xx*(p*p-1)*(s+ell)-p*p*xx*(s*s+s*ell+ell*ell)+2*p*p*xx
checks["case_b_polynomial_difference"] = S.cancel(
    g-g.subs(s,ell)-p*(s-ell)*slope)==0
checks["case_b_slope_lower_bound_identity"] = S.expand(
    B+2*p*xx*(p*p-1)-3*p**4*xx-R)==0
checks["case_b_lower_endpoint"] = S.cancel(
    g.subs(s,ell)-xx*xx*(p*p+p-1)/p)==0

# Verify the explicit Gram matrix over the exact algebraic number field.
rr = (S.sqrt(5)-1)/2
ss = S.sqrt(rr)
V = S.Matrix([[1,0,rr,rr,0],[0,0,ss,-rr*ss,ss],[0,1,0,rr,rr]])
G = V.T*V
checks["attainment_unit_vectors"] = all(S.simplify(G[i,i]-1)==0 for i in range(5))
checks["attainment_cyclic_orthogonality"] = all(S.simplify(G[i,(i+1)%5])==0 for i in range(5))
checks["attainment_all_chord_overlaps"] = all(S.simplify(G[i,(i+2)%5]-rr)==0 for i in range(5))
checks["attainment_row_sums"] = all(S.simplify(sum(G[i,j] for j in range(5))-S.sqrt(5))==0 for i in range(5))
checks["attainment_score_product"] = S.simplify(rr**2*(1-rr**2)-(S.sqrt(5)-2))==0

order = [0,2,4,1,3]
mapped = {frozenset((order[j],order[(j+2)%5])) for j in range(5)}
crossing = {frozenset((i,(i+1)%5)) for i in range(5)}
checks["cycle_disjoint_edges_to_original_crossing_pairs"] = mapped==crossing

assert all(checks.values()), checks
report = {
    "status":"PASS",
    "checks":checks,
    "scope":"Exact identities and explicit finite example; not a kernel proof of the continuous theorem."
}
Path(__file__).with_name("scalar_attainment_audit.json").write_text(json.dumps(report,indent=2)+"\n")
print(json.dumps(report,indent=2))
