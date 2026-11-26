"""Independent exact recomputation of the finite certificates.

The constants were independently transcribed from rational_obstruction_note.md,
rather than imported from the author's verifier. This is arithmetic checking,
not a Lean or other proof-assistant certificate.
"""
from fractions import Fraction as F
from itertools import product, permutations
import json

if not __debug__:
    raise RuntimeError("Run without -O: this reviewer cross-check uses assert statements.")

def dot(a, b):
    return sum(x*y for x, y in zip(a, b))

def add(*vectors):
    return tuple(sum(v[k] for v in vectors) for k in range(3))

def sub(a, b):
    return tuple(x-y for x, y in zip(a, b))

def scale(a, t):
    return tuple(t*x for x in a)

def transform(a):
    u, v, w = a
    return (-v, u, -w)

def orbit(a):
    result = [a]
    for _ in range(3):
        result.append(transform(result[-1]))
    assert transform(result[-1]) == a
    return result

def distance(a, b):
    candidates = []
    for p in permutations(range(4)):
        value = F(sum(dot(sub(a[j], b[p[j]]),
                          sub(a[j], b[p[j]]))
                      for j in range(4)), 4)
        candidates.append(value)
    return min(candidates)

def main():
    x = orbit((160, 0, 180))
    source = [orbit((96,126,255)),
              orbit((288,0,30)),
              orbit((96,-126,255))]
    z = orbit((0,180,160))
    alpha, beta = F(1,10), F(19,10)
    width = beta-alpha
    margins = []
    for i, j, k in product(range(3),range(4),range(4)):
        if j == k:
            continue
        h = sub(x[j], x[k])
        g = sub(source[i][j],source[i][k])
        # Expanded form of the Taylor-Hendrickx-Glineur criterion.
        rhs = dot(source[i][k],h)
        rhs += (dot(g,g) + alpha*beta*dot(h,h)
                - 2*alpha*dot(g,h))/(2*width)
        margins.append(-rhs)
    assert len(margins) == 36
    assert min(margins) == F(7640,9)

    # All 64 tuples, without assuming any coupling symmetry.
    all_scores = {}
    for j0,j1,j2 in product(range(4),repeat=3):
        mean = scale(add(source[0][j0],source[1][j1],
                         source[2][j2]),F(1,3))
        all_scores[(j0,j1,j2)] = dot(mean,mean)
    optimal = [k for k,v in all_scores.items() if v == 58000]
    assert max(all_scores.values()) == 58000
    assert set(optimal) == {(j,j,j) for j in range(4)} | {
        (j,(j+1)%4,(j+2)%4) for j in range(4)}
    assert 58000-max(v for v in all_scores.values() if v<58000)==9328
    for j in range(4):
        assert scale(add(*(source[i][j] for i in range(3))),F(1,3)) == x[j]
        assert scale(add(*(source[i][(j+i)%4] for i in range(3))),F(1,3)) == z[j]

    cx = [distance(x, yi) for yi in source]
    cz = [distance(z, yi) for yi in source]
    assert cx == [25597,38884,25597]
    assert cz == [21157,47764,21157]
    assert distance(x,z) == 58400
    assert sum(cx)/3 == 30026
    contrasts = [b-a for a,b in zip(cx,cz)]
    assert contrasts == [-4440,8880,-4440]
    assert sum(v*v for v in contrasts)/3 == 39427200

    # Polynomial coefficients of B_alt-B_diag in q0,q1,q2.
    diagonal = [source[i][0] for i in range(3)]
    alternate = [source[i][i] for i in range(3)]
    square_coefficients = [
        dot(alternate[i],alternate[i])-dot(diagonal[i],diagonal[i])
        for i in range(3)]
    cross_coefficients = [
        2*(dot(alternate[i],alternate[j])-dot(diagonal[i],diagonal[j]))
        for i,j in [(0,1),(0,2),(1,2)]]
    assert square_coefficients == [0,0,0]
    assert cross_coefficients == [-13320,26640,-13320]

    # Exact constants in the author's elementary finite-n alternative.
    radius_squared = max(dot(v,v) for yi in source for v in yi)
    assert radius_squared == 90117
    assert F(4*radius_squared,50) < 9328
    assert radius_squared < (50*7)**2
    assert 58400 > 240**2
    assert (240-7)**2 > 50000
    assert F(2,9)*150**2 == 5000
    assert F(15000,90000) == F(1,6)
    assert F(1,3)-F(1,6) == F(1,6)
    assert F(50000,12) > 4000
    assert F(30026)/(2-beta+alpha)**2 == 750650

    print(json.dumps({
        "status":"all_exact_arithmetic_checks_passed",
        "frozen_manuscript_sha256":"762f47ad02dc906554077c70da4e721eb2a87405eb193b2ec1f405d4b9704675",
        "discovery_note_sha256":"63bc8206e8080a53ef1a3d3c12819f5ae849d5dfd44e59ea9f26774cfc1c521e",
        "method":"standard-library Fraction; all 64 tuples; all 24 pair assignments; exact coefficient expansion",
        "taylor_inequalities":len(margins),
        "taylor_minimum":str(min(margins)),
        "maximizing_tuples":optimal,
        "other_tuple_gap":9328,
        "costs_nu":[str(v) for v in cx],
        "costs_nu_prime":[str(v) for v in cz],
        "squared_separation":58400,
        "variance":30026,
        "contrast_variance":39427200,
        "cross_coefficients":cross_coefficients,
        "radius_squared":radius_squared,
        "finite_n_constants_checked":True,
        "proof_assistant_validation":False
    },indent=2))

if __name__ == "__main__":
    main()

