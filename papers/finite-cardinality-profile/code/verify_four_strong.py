"""Exact certificate for the non-blocker rays of the four-element cone.

Uses only Python’s standard library and integer arithmetic. The 19 orbits
checked here satisfy the sharp three-element coefficient for every cap.
The remaining orbit is the single-blocker rank-one function.
"""
from functools import cache
from itertools import combinations, combinations_with_replacement, permutations, product
from math import gcd, lcm

N = 4
CUBE = tuple(tuple((mask >> i) & 1 for i in range(N)) + (1,) for mask in range(2**N))
BLOCKER = tuple(int(mask != 0 and not mask & 1) for mask in range(1, 2**N))


def dot(a, b):
    return sum(x*y for x, y in zip(a, b))


def primitive(vector):
    g = gcd(*vector)
    return tuple(x//g for x in vector)


def extreme_ray_orbits():
    """Double description, starting with the orthant and cutting by submodularity."""
    m = len(CUBE)-1
    constraints = []
    for i, j in combinations(range(N), 2):
        for s in range(2**N):
            a, b = 1 << i, 1 << j
            if s & (a | b):
                continue
            row = [0]*m
            for t, sign in ((s | a, 1), (s | b, 1), (s, -1), (s | a | b, -1)):
                if t:
                    row[t-1] += sign
            constraints.append((s.bit_count(), i, j, s, tuple(row)))

    rays = [(tuple(int(i == j) for i in range(m)), (1 << m)-1-(1 << j))
            for j in range(m)]
    for k, (_, _, _, _, row) in enumerate(sorted(constraints), start=m):
        zero, pos, neg = [], [], []
        for ray, tight in rays:
            value = dot(row, ray)
            if value == 0:
                zero.append((ray, tight | (1 << k)))
            elif value > 0:
                pos.append((ray, tight, value))
            else:
                neg.append((ray, tight, value))
        new = zero + [(ray, tight) for ray, tight, _ in pos]
        for (rp, tp, vp), (rn, tn, vn) in product(pos, neg):
            common = tp & tn
            if common.bit_count() < m-2:
                continue
            if any(t & common == common and t not in (tp, tn) for _, t in rays):
                continue
            vector = tuple(vp*x-vn*y for x, y in zip(rn, rp))
            new.append((primitive(vector), common | (1 << k)))
        rays = new

    perms = [tuple(sum(1 << p[j] for j in range(N) if i & (1 << j))-1
                   for i in range(1, 2**N)) for p in permutations(range(N))]
    orbits = {min(tuple(ray[k] for k in p) for p in perms) for ray, _ in rays}
    if len(rays) != 218 or len(orbits) != 20:
        raise ArithmeticError(f"Unexpected cone size: {len(rays)} rays, {len(orbits)} orbits.")
    return sorted(orbits)


@cache
def det(matrix):
    if len(matrix) == 1:
        return matrix[0][0]
    return sum((-1)**j*entry*det(tuple(row[:j]+row[j+1:] for row in matrix[1:]))
               for j, entry in enumerate(matrix[0]) if entry)


def affine_bases():
    """Return invertible five-row cube systems as integer adjugates."""
    bases = []
    for indices in combinations(range(2**N), N+1):
        matrix = tuple(CUBE[i] for i in indices)
        d = det(matrix)
        if not d:
            continue
        adjugate = tuple(tuple((-1)**(i+j)*det(tuple(row[:i]+row[i+1:] for k, row in enumerate(matrix) if k != j))
                               for j in range(N+1)) for i in range(N+1))
        if d < 0:
            adjugate = tuple(tuple(-x for x in row) for row in adjugate)
        bases.append((indices, adjugate, abs(d)))
    return bases


def majorants(values, bases):
    forms = set()
    for indices, adjugate, d in bases:
        rhs = tuple(values[j] for j in indices)
        numerators = tuple(dot(row, rhs) for row in adjugate)
        if all(dot(numerators, x) >= d*f for x, f in zip(CUBE, values)):
            forms.add(primitive(numerators+(d,)))
    if not forms:
        raise ArithmeticError("No affine majorants found.")
    return sorted(forms)


def vertices(rows):
    """A row (a,b) means a·y <= b, with y four dimensional."""
    out = {}
    for basis in combinations(rows, N):
        d = det(tuple(row[:N] for row in basis))
        if not d:
            continue
        point = tuple(det(tuple(row[:j]+(row[-1],)+row[j+1:N] for row in basis))
                      for j in range(N))
        if d < 0:
            point, d = tuple(-x for x in point), -d
        slack = tuple(row[-1]*d-dot(row, point) for row in rows)
        if min(slack) >= 0:
            out[primitive(point+(d,))] = frozenset(i for i, s in enumerate(slack) if s == 0)
    return out


def simplices(rows):
    """Pull simplices using intersections with defining rows."""
    active = vertices(rows)
    keys = sorted(active)
    faces = tuple(frozenset(v for v in keys if k in active[v]) for k in range(len(rows)))

    @cache
    def pull(keys, dim):
        first, *_ = keys
        if not dim:
            return {(first,)}
        relevant = {tuple(v for v in keys if v in face) for face in faces if first not in face}
        return {(first,)+base for face in relevant if len(face) >= dim for base in pull(face, dim-1)}

    if len(keys) >= N+1:
        return [s for s in pull(tuple(keys), N) if det(s)]
    return []


def cells(forms, position):
    """Designate x_position=p and put p last in y."""
    order = tuple(i for i in range(N) if i != position)+(position,)
    cap_rows = [(0, 0, 0, -3, -1), (0, 0, 0, 1, 1)]
    for i in range(N-1):
        unit = tuple(int(i == j) for j in range(N-1))
        cap_rows.extend([tuple(-z for z in unit)+(0, 0), unit+(-1, 0)])
    for L in forms:
        rows = set(cap_rows)
        for M in forms:
            if L != M:
                diff = tuple(L[j]*M[-1]-M[j]*L[-1] for j in order)
                rows.add(diff+(M[-2]*L[-1]-L[-2]*M[-1],))
        yield L, simplices(tuple(sorted(rows))), order


POLARIZATION_SUBSETS = tuple(((-1)**len(s), s)
                            for k in range(1, N+1) for s in combinations(range(N), k))


@cache
def polarizations(vertex_count):
    out = []
    for idx in combinations_with_replacement(range(vertex_count), N):
        counts = {}
        for sign, subset in POLARIZATION_SUBSETS:
            sub = tuple(idx[j] for j in subset)
            counts[sub] = counts.get(sub, 0)+sign
        out.append(tuple((sign, sub) for sub, sign in counts.items() if sign))
    return out


def check(values, L, simplex, order, low_cap=False):
    """Check all homogeneous quartic coefficients by exact polarization."""
    d = lcm(*(v[-1] for v in simplex))
    points = tuple(tuple(v[order.index(j)]*(d//v[-1]) for j in range(N))+(d,)
                   for v in simplex)
    nonzero = tuple((s, f) for s, f in enumerate(values) if f)

    @cache
    def Q(indices):
        z = tuple(sum(points[j][k] for j in indices) for k in range(N+1))
        u = z[-1]
        p = z[order[-1]]
        q = u-p
        product_value = 0
        for s, f in nonzero:
            for j in range(N):
                f *= z[j] if (s >> j) & 1 else u-z[j]
            product_value += f
        C = dot(L[:-1], z)
        if low_cap:
            return 2*L[-1]*product_value - C*q*(2*u-p)*u
        return 4*L[-1]*product_value - C*q*(4*u-q)*u

    return all(sum(sign*Q(sub) for sign, sub in terms) >= 0
               for terms in polarizations(len(simplex)))


def check_low_caps(values):
    """Use the singleton upper bound and multiaffinity on [0,p]^4."""
    L = tuple(values[1 << i] for i in range(N))+(0, 1)
    for point in CUBE[1:]:
        position = point.index(1)
        order = tuple(i for i in range(N) if i != position)+(position,)
        segment = ((0, 0, 0, 0, 3), tuple(point[i] for i in order)+(3,))
        if not check(values, L, segment, order, low_cap=True):
            raise ArithmeticError(f"Negative coefficient on low-cap segment: {values}, {point}.")
    return len(CUBE)-1


def main():
    rays = extreme_ray_orbits()
    bases = affine_bases()
    if BLOCKER not in rays:
        raise ArithmeticError("Single-blocker orbit missing from the cone enumeration.")
    segments = simplices_count = orbits = 0
    print("218 extreme rays in 20 permutation orbits.")
    print("orbit majorants simplices")
    for k, ray in enumerate(rays, start=1):
        if ray == BLOCKER:
            continue
        values = (0,)+ray
        segments += check_low_caps(values)
        orbits += 1
        forms = majorants(values, bases)
        local = 0
        for i in range(N):
            for L, region, order in cells(forms, i):
                for simplex in region:
                    if not check(values, L, simplex, order):
                        raise ArithmeticError(f"Negative coefficient on simplex: {ray}, {L}, {simplex}, {order}.")
                local += len(region)
        if not local:
            raise ArithmeticError(f"No full-dimensional simplices found for orbit {k}.")
        simplices_count += local
        print(k, len(forms), local, flush=True)
    if (segments, simplices_count, orbits) != (285, 2961, 19):
        raise ArithmeticError("Unexpected certificate size.")
    print(f"Certified {segments} segments and {simplices_count} simplices for all {orbits} non-blocker orbits.")


if __name__ == '__main__':
    main()
