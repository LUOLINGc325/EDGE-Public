"""Exact renewal and causal compensation checks for the support-gap thresholds."""

from fractions import Fraction as F
from math import ceil, isclose, log


def finite_rows(r, t, jump, last=40):
    defect = {j: r * p / t**j for j, p in jump.items()}
    rho = sum(defect.values())
    a = (1 - t) / (1 - r)
    h = [1 - sum(p for j, p in defect.items() if j <= n) for n in range(last + 1)]
    u = [F(1)]
    for n in range(1, last + 1):
        u.append(sum(p * u[n - j] for j, p in defect.items() if j <= n))
    tail = [1 - (1 - rho) * sum(u[:n]) for n in range(last + 1)]
    idle = [a * t**n * h[n] for n in range(last + 1)]
    for n in range(last + 1):
        assert sum(u[k] * h[n - k] for k in range(n + 1)) == 1
    return a, h, u, tail, idle


def examine(d, r, t, jump):
    a, h, u, tail, idle = finite_rows(r, t, jump)
    L = next(k for k, value in enumerate(tail) if value <= a)
    H = next(k for k in range(L, len(u)) if u[k] > 0) - L
    assert u[L - 1] > 0
    gain = tail[L - 1] <= sum(idle[:H + 1])
    last_late = d * L
    next_service = last_late + d * H + 1
    for n in range(len(u)):
        p0 = u[L - 1] * h[n - L + 1] if n >= L - 1 else F(0)
        pgood = sum(u[k] * h[n - k] for k in range(L, n + 1))
        late = p0 + pgood
        assert pgood <= a and late <= tail[L - 1]
        if gain:
            excess = max(F(0), late - a)
            assert excess <= p0
            active_mass = sum(idle[1:H + 1])
            assert excess <= active_mass
            contributions = [late - excess]
            for j in range(1, H + 1):
                contributions.append(excess * idle[j] / active_mass)
                assert last_late + d * j < next_service
            assert sum(contributions) == late
            assert all(0 <= x <= y for x, y in zip(contributions, idle))
    print(f"d={d}, r={r}, t={t}, jumps={jump}: L={L}, H={H}, threshold={d*L + int(not gain)}")
    return d * L + int(not gain)


def main():
    assert examine(2, F(1, 4), F(3, 4), {2: F(1)}) == 6
    assert examine(2, F(1, 10), F(3, 5), {2: F(1)}) == 3
    examine(4, F(1, 8), F(4, 5), {2: F(1, 2), 5: F(1, 2)})
    examine(3, F(1, 5), F(4, 5), {1: F(1, 2), 4: F(1, 2)})
    _, _, _, critical_tail, _ = finite_rows(F(1, 4), F(1, 2), {2: F(1)})
    assert set(critical_tail) == {1}
    for n in (100, 1000, 10000):
        t = 0.5 + 1 / n
        rho = 0.25 / t**2
        a = (1 - t) / 0.75
        L = 2 * (ceil(log(a) / log(rho)) - 1) + 1
        scaled = log(t / 0.5) * (2 * L + 1)
        print(f"t-t_c={1/n:.5g}: scaled upper threshold={scaled:.9f}")
    assert isclose(scaled, 2 * log(1.5), abs_tol=0.001)


if __name__ == "__main__":
    main()
