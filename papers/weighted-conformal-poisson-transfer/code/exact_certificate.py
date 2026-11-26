"""Recompute the lattice-tie witnesses and Gaussian transfer coefficient."""
from fractions import Fraction as F
from math import comb, pi, sqrt


def clip(x, lo=F(0), hi=F(1)):
    return min(hi, max(lo, x))


def null_mass(t, g, zeta, kappa, k, omega):
    light_below = min(g, t * (1 + k))
    light_above = clip(t * (1 + k) - k, g, 1 - zeta) - g
    heavy = clip((t * (1 + k + kappa) - g) / (k + kappa))
    return (light_below + light_above + omega * heavy) / (1 + omega)


def verify_witness(q, kappa, poisson_mean, g, v, zeta, r, masses, jump):
    t1, t2 = q / 2, q
    k = kappa * r
    omega = poisson_mean * kappa
    assert (v + k) / (1 + k) == t2
    assert v > t1 and g < v < 1 - zeta
    assert tuple(null_mass(t, g, zeta, kappa, k, omega) for t in (t1, t2)) == masses
    assert (masses[1] - 2 * masses[0]) * zeta / (1 + omega) == jump
    print(f"Resonance r={r}: null masses {masses[0]}, {masses[1]}; inclusive minus exclusive {jump}")


def count_probabilities(grid):
    """Distribution of the BH count for a forced zero plus iid test values."""
    m = len(grid)
    endpoints = [F(0), *grid, F(1)]
    bands = [hi - lo for lo, hi in zip(endpoints, endpoints[1:])]
    assert all(b >= 0 for b in bands)
    result = [F(0)] * (m + 1)

    def add(band, used, greatest, probability):
        if band == m:
            result[greatest] += probability * bands[band] ** (m - 1 - used)
            return
        for count in range(m - used):
            cumulative = used + count
            new_greatest = band + 1 if 1 + cumulative >= band + 1 else greatest
            add(
                band + 1, cumulative, new_greatest,
                probability * comb(m - 1 - used, count) * bands[band] ** count,
            )

    add(0, 0, 0, F(1))
    assert sum(result) == 1 and result[0] == 0
    return result[1:]


def example_13():
    q, m, g, omega, zeta = F(1, 10), 8, F("0.018418"), F("0.086271"), F("0.91847")
    grid = [q * k / m for k in range(1, m + 1)]
    v_inf = q * (1 + omega) - omega
    assert 0 < g < v_inf < 1 - zeta < 1
    assert (1 - zeta + omega) / (1 + omega) > q

    def region(t, s):
        w = s + omega
        assert t not in (s * g / w, (s * g + omega) / w)
        if t < s * g / w:
            return 0
        if t > (s * g + omega) / w:
            return 1
        return 2

    def count_jump(decoy_mass):
        include = count_probabilities(grid[:-1] + [grid[-1] + decoy_mass])
        exclude = count_probabilities(grid)
        return [lhs - rhs for lhs, rhs in zip(include, exclude)]

    w_inf = 1 + omega
    d = [
        t / w_inf if region(t, F(1)) == 0 else
        (t - 1) / w_inf if region(t, F(1)) == 1 else
        (g - t) / (omega * w_inf)
        for t in grid
    ]
    jump_inf = count_jump(zeta / w_inf)
    weighted_derivative = -m / q * sum(
        jump * slope / k for k, (jump, slope) in enumerate(zip(jump_inf, d), 1)
    )
    assert weighted_derivative > 0
    exact_limit_numeric = float(weighted_derivative) * sqrt(float(omega) / (2 * pi))
    print(f"Exact rational factor of sqrt(omega/(2*pi)): {weighted_derivative}")
    print(f"Lim Example 13 coefficient, rounded: {exact_limit_numeric:.8f}")

    for weight in (10, 100, 1000):
        b = F(weight)
        s, w = 1 - omega / b, 1 + omega - omega / b
        gamma = s / w
        v = (q * w - omega) / s
        assert g < v < 1 - zeta
        assert (s * (1 - zeta) + omega) / w > q
        a_d = (1 - q) / (s * w)
        assert a_d == (1 - q + (q - v) / b) / w
        variance = a_d**2 * omega * s + gamma**2 * v * (1 - v) / (b * s)
        covariances = []
        for t in grid:
            current_region = region(t, s)
            if current_region == 2:
                y = g
                a = (g - t) / (omega * w)
                assert a == (t * (1 - 1 / b) + g / b - (t * w - s * g) / omega) / w
            else:
                indicator = current_region
                y = (t * w - indicator * omega) / s
                a = (t - indicator) / (s * w)
                assert a == (t * (1 - 1 / b) + y / b - indicator) / w
            covariances.append(a * a_d * omega * s - gamma**2 * (min(y, v) - y * v) / (b * s))
        weighted_covariance = -m / q * sum(
            jump * cov / k for k, (jump, cov) in enumerate(zip(count_jump(gamma * zeta), covariances), 1)
        )
        assert weighted_covariance > 0 and variance > 0
        number = float(weighted_covariance) / sqrt(2 * pi * float(variance))
        print(f"Fixed-weight coefficient at B={weight}, rounded: {number:.8f}")


def main():
    verify_witness(
        F(3, 10), F(1, 5), F(1, 2), F(1, 20), F(4, 25), F(2, 5), 1,
        (F(9, 110), F(101, 440)), F(29, 1210),
    )
    verify_witness(
        F(1, 2), F(1, 16), F(2), F(1, 16), F(1, 2), F(1, 4), 0,
        (F(1, 3), F(5, 9)), F(-2, 81),
    )
    example_13()


if __name__ == "__main__":
    main()
