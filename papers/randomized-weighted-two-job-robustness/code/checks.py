"""Exact arithmetic checks for weighted two-job scheduling."""
from fractions import Fraction as Q
from itertools import product


def fixed_share_passage(u, v, share):
    if share == 0:
        return v
    if share == 1:
        return u
    return min(u/share, v/(1-share))


def check_kernel():
    for index in range(1001):
        share = Q(index, 1000)
        first = max(share, (1-share)/3)
        second = max(share/3, 1-share)
        kernel = (1/first + 1/second)/2
        assert kernel == (
            fixed_share_passage(1, 3, share) + fixed_share_passage(3, 1, share)
        )/2
        assert Q(1, 4) <= first <= 1 and Q(1, 4) <= second <= 1
        assert kernel >= 2
        assert (kernel == 2) == (share in (0, Q(1, 2), 1))
    return 1001


def simulate(w1, w2, u, v, share):
    x1, x2 = u/w2, v/w1
    raw1, raw2 = share/w2, (1-share)/w1
    rate1, rate2 = raw1/(raw1+raw2), raw2/(raw1+raw2)
    finish1 = x1/rate1 if rate1 else None
    finish2 = x2/rate2 if rate2 else None
    if finish2 is None or (finish1 is not None and finish1 <= finish2):
        first_time = finish1
        physical_cost = w1*first_time + w2*(x1+x2)
    else:
        first_time = finish2
        physical_cost = w1*(x1+x2) + w2*first_time
    virtual_time = (w2*rate1 + w1*rate2)*first_time
    return physical_cost, virtual_time


def check_weighted_mixture():
    weights = [Q(1, 5), Q(1, 2), Q(1), Q(2), Q(7)]
    sizes = [Q(1, 89), Q(1, 3), Q(2, 3), Q(1), Q(3), Q(5)]
    count = 0
    for w1, w2, u, v in product(weights, weights, sizes, sizes):
        a, b = w1/w2, w2/w1
        d = 2*(a+b) + 1
        modes = [(Q(0), b/d), (Q(1), a/d), (Q(1, 2), (a+b+1)/d)]
        assert sum(probability for _, probability in modes) == 1
        base = a*u + b*v
        optimum = base + min(u, v)
        expected = Q(0)
        for share, probability in modes:
            physical_cost, virtual_time = simulate(w1, w2, u, v, share)
            assert virtual_time == fixed_share_passage(u, v, share)
            assert physical_cost == base + virtual_time
            expected += probability * physical_cost
        assert expected / optimum == 1 + 1/d
        assert (base+u)/optimum <= 1 + max(a, b)
        assert (base+v)/optimum <= 1 + max(a, b)
        count += 1
    return count


if __name__ == "__main__":
    print(f"{check_kernel()} exact kernel and equality checks")
    print(f"{check_weighted_mixture()} exact two-job weighted instances")
