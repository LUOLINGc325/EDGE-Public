"""High-precision checks of entropy derivatives and Hessian identities."""
import mpmath as mp

mp.mp.dps = 75


def parameters(r, u, v):
    a, b, aa, bb = [mp.atanh(z) for z in (u, v, r*u, r*v)]
    den = (u-r*v)*a + (r*u-v)*b
    s = ((r*u-v)*aa + (u-r*v)*bb)/den
    kappa = (1-r*u*v)*(a*aa-b*bb)/den
    return s, kappa


def objective(r, s, kappa, u, v):
    d = 1+r*u*v
    probs = [[(1+r*x*y)*(1+u*x)*(1+v*y)/(4*d)
              for y in (-1, 1)] for x in (-1, 1)]
    entropy = lambda p: -sum(q*mp.log(q) for q in p)
    joint = entropy([q for row in probs for q in row])
    hx = entropy([sum(row) for row in probs])
    hy = entropy([sum(row[j] for row in probs) for j in range(2)])
    corr = (r+u*v)/d
    return (1+s)*joint-hx-hy+((1+s)*mp.atanh(r)-kappa)*(corr-r)


def check(r, u, v):
    s, kappa = parameters(r, u, v)
    d, m0 = 1+r*u*v, 1-r*u*v
    p = (1-u*u)*(1-v*v)
    q = (1-r*r*u*u)*(1-r*r*v*v)
    mu = r*mp.sqrt(p/q)
    fun = lambda a, b: objective(r, s, kappa, a, b)
    grad = [mp.diff(fun, (u, v), (1, 0)), mp.diff(fun, (u, v), (0, 1))]
    hessian = [mp.diff(fun, (u, v), (2, 0)),
               mp.diff(fun, (u, v), (1, 1)),
               mp.diff(fun, (u, v), (0, 2))]
    predicted = [((1-r*r*v*v)/(1-u*u)*(mu*mu-s))/d**2,
                 (r*(1-s)-kappa*(1-r*r)*d/m0)/d**2,
                 ((1-r*r*u*u)/(1-v*v)*(mu*mu-s))/d**2]
    residual = max([abs(x) for x in grad]
                   + [abs(x-y) for x,y in zip(hessian, predicted)])
    lower = r*(1+mu)*(mu-s)/(mu*(1-r*r)*d)
    upper = r*(1-mu)*(mu+s)/(mu*(1-r*r)*d)
    lam = kappa/m0
    assert s > mu*mu and s < r*r and kappa > 0
    assert lower < lam < upper
    assert hessian[0] < 0 and hessian[0]*hessian[2]-hessian[1]**2 > 0
    # The fixed-product derivative identity is checked at a different parameter.
    ss = s*mp.mpf('0.73')
    kk = kappa*mp.mpf('1.19')
    z = u*v
    a, b = mp.atanh(u), mp.atanh(v)
    den = (u-r*v)*a + (r*u-v)*b
    direct = mp.diff(lambda x: objective(r, ss, kk, x, z/x), u)
    predicted_derivative = den/(u*d)*(s-ss)
    residual = max(residual, abs(direct-predicted_derivative))
    return residual


if __name__ == '__main__':
    largest = mp.mpf(0)
    count = 0
    for rr in ('0.01', '0.1', '0.6', '0.9', '0.99', '0.9999'):
        for uu, vv in [('0.03', '0.01'), ('0.8', '0'), ('0.8', '0.4'),
                       ('0.8', '-0.4'), ('0.8', '0.799'),
                       ('0.8', '-0.799'), ('0.999', '0.87')]:
            largest = max(largest, check(*map(mp.mpf, (rr, uu, vv))))
            count += 1
    # A diagnostic threshold for these finite 75-digit computations only.
    if not mp.isfinite(largest) or largest >= mp.mpf('1e-60'):
        raise AssertionError('Identity residual exceeds the diagnostic tolerance 1e-60')
    print('independent entropy/Hessian/derivative checks:', count)
    print('maximum absolute identity residual:', mp.nstr(largest, 8))
    print('All numerical checks support identities; no numerical proof claimed.')
