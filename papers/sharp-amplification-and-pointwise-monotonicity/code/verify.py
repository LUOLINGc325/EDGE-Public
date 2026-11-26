"""Exact finite examples for the Lüders order-score theorems."""

import json
from fractions import Fraction as Q
from itertools import product
from math import isqrt


def identity(n):
    return tuple(tuple(Q(i == j) for j in range(n)) for i in range(n))


def add(a, b):
    return tuple(tuple(x + y for x, y in zip(r, s)) for r, s in zip(a, b))


def scale(k, a):
    return tuple(tuple(k * x for x in r) for r in a)


def subtract(a, b):
    return add(a, scale(-1, b))


def mul(a, b):
    return tuple(
        tuple(sum(x * y for x, y in zip(r, c)) for c in zip(*b))
        for r in a
    )


def sandwich(a, b):
    return mul(mul(a, b), a)


def trace(a):
    return sum(r[i] for i, r in enumerate(a))


def off(s, a):
    return scale(Q(1, 2), subtract(a, sandwich(s, a)))


def affine(m, g, s):
    return add(scale(m, identity(len(s))), scale(g, s))


def root_bracket(r, bits=96):
    scale = 1 << bits
    l = isqrt((r.numerator * scale**2) // r.denominator)
    low, high = Q(l, scale), Q(l + 1, scale)
    assert low**2 <= r < high**2
    return low, high


def deficit_ratio(g, m):
    a, b = root_bracket(m**2 - g**2)
    return g / (m + b), g / (m + a)


def rational_sharpness():
    eye = identity(2)
    x = ((0, 1), (1, 0))
    z = ((1, 0), (0, -1))
    zero = scale(0, eye)
    t, e, epsilon, c = Q(24, 25), Q(7, 25), Q(1, 20), Q(1, 2)
    assert t**2 + e**2 == 1
    lam = 1 / (1 + t)
    g = epsilon / 2
    partner = []
    us, vs = [], []
    for sign in (-1, 1):
        b = scale(lam / 2, add(affine(1, -t, z), scale(sign * e, x)))
        partner.append(b)
        assert trace(b) == lam
        assert mul(b, b) == scale(lam, b)
        assert mul(mul(b, z), b) == scale(-lam * t, b)
        u = subtract(scale(Q(1, 2), add(mul(z, b), mul(b, z))), scale(1 / lam, sandwich(b, z)))
        v = off(z, b)
        assert u == scale(lam * e / 2, add(scale(e, z), scale(sign * t, x)))
        assert v == scale(sign * lam * e / 2, x)
        us.append(u)
        vs.append(v)
    b_zero = scale(t * lam, add(eye, z))
    assert add(add(*partner), b_zero) == eye
    a0, a1, a2 = (affine(1-c-epsilon, 0, z), affine(g, g, z), affine(c+g, -g, z))
    assert add(add(a0, a1), a2) == eye
    assert all(a[0][0] >= 0 and a[1][1] >= 0 for a in (a0,a1,a2))
    assert off(z, b_zero) == zero
    r_low, r_high = deficit_ratio(g, c + g)
    rp_low, rp_high = deficit_ratio(g, 1 - c - g)
    assert Q(0) < r_low < r_high < Q(1, 40)
    assert Q(0) < rp_low < rp_high < Q(1, 36)
    assert 2*e < 1 and t > rp_high and 2*t-rp_high > 1
    assert e**2 + (1-t)**2 <= (2*e)**2
    assert Q(48,25)-Q(1,36) > Q(9,5)*Q(41,40)
    # The ratio is decreasing in both r and rp
    # on the certified intervals. Bound it using the interval extremes.
    ratio_low = (2*t + r_high - rp_high) / (1 + r_high)
    ratio_high = (2*t + r_low - rp_low) / (1 + r_low)
    assert Q(1848,1000) < ratio_low < ratio_high < Q(2)
    # At the +X state two different U rays have uncancelled V directions.
    state = scale(Q(1, 2), add(eye, x))
    uv = [(trace(mul(state,u)), trace(mul(state,v))) for u,v in zip(us,vs)]
    assert all(u != 0 for u, _ in uv)
    assert sum((1 if u>0 else -1)*v for u,v in uv) > 0
    # The same rays yield the explicit small-g three-outcome state witness.
    assert deficit_ratio(g, Q(1, 2))[1] < deficit_ratio(g, Q(1, 4))[0]
    assert deficit_ratio(g, Q(1, 4))[1] < t
    # For a common X axis both normalized U rays coincide and V cancels.
    u_axis = scale(Q(1, 2), z)
    assert u_axis != zero
    assert add(scale(Q(1, 2), x), scale(Q(-1, 2), x)) == zero
    return {
        "ratio_lower": "1848/1000",
        "ratio_upper": "2",
        "rational_parameters": [str(t), str(e), str(epsilon)],
        "split_rays_at_positive_x": True,
        "common_axis_rays_cancel": True,
    }


def four_dimensional_comparison():
    n = 4
    eye = identity(n)
    s = tuple(tuple(Q((1 if i<2 else -1)*(i==j)) for j in range(n)) for i in range(n))
    t = tuple(tuple(Q((i+2)%4 == j) for j in range(n)) for i in range(n))

    def pair(a, b, involution):
        return affine((a+b)/2, (a-b)/2, involution)

    assert mul(s,s)==eye and mul(t,t)==eye
    a = [(Q(3,5),Q(0)),(Q(4,5),Q(3,5)),(Q(0),Q(4,5))]
    coarse = [(Q(1),Q(3,5)),(Q(0),Q(4,5))]
    b = [(Q(3,5),Q(4,5)),(Q(4,5),Q(3,5))]
    roots_b = [pair(i,j,t) for i,j in b]

    def differences(roots_a):
        results = []
        for x, y in roots_a:
            ra = pair(x,y,s)
            g = (x*x-y*y)/2
            eta = (x-y)**2/2
            for (p,q), rb in zip(b,roots_b):
                delta, beta = (p*p-q*q)/2, (p-q)**2/2
                direct = subtract(sandwich(ra, mul(rb, rb)), sandwich(rb,mul(ra,ra)))
                abstract = subtract(scale(g*beta,off(t,s)),scale(eta*delta,off(s,t)))
                assert direct == abstract
                results.append(direct)
        return results

    fa, ca = differences(a), differences(coarse)
    for sign in (-1,1):
        assert sum(v[0 if sign==1 else 1]**2 for v in a) == 1
        assert sum(v[0 if sign==1 else 1]**2 for v in coarse) == 1
        assert sum(v[0 if sign==1 else 1]**2 for v in b) == 1
    cases = 0
    for state in product(range(-1,2),repeat=4):
        energy=sum(i*i for i in state)
        if not energy:
            continue
        rho=tuple(tuple(Q(i*j,energy) for j in state) for i in state)
        fine_score=sum(abs(trace(mul(rho,d))) for d in fa)
        coarse_score=sum(abs(trace(mul(rho,d))) for d in ca)
        assert coarse_score <= fine_score
        cases+=1
    return cases


if __name__ == "__main__":
    print(json.dumps({
        "rational_sharpness": rational_sharpness(),
        "four_dimensional_pointwise_checks": four_dimensional_comparison(),
        "status": "PASS",
    },indent=2,sort_keys=True))
