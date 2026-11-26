"""Exact rational certificate for a conservative sample threshold in Lim Example 13."""
from fractions import Fraction as F
from math import comb, factorial


def forced_count_law(grid):
    m = len(grid)
    endpoints = [F(0), *grid, F(1)]
    bands = [hi - lo for lo, hi in zip(endpoints, endpoints[1:])]
    assert all(band >= 0 for band in bands)
    result = [F(0)] * (m + 1)

    def visit(band, used, greatest, probability):
        if band == m:
            result[greatest] += probability * bands[band] ** (m - 1 - used)
            return
        for count in range(m - used):
            cumulative = used + count
            next_greatest = band + 1 if 1 + cumulative >= band + 1 else greatest
            visit(
                band + 1, cumulative, next_greatest,
                probability * comb(m - 1 - used, count) * bands[band] ** count,
            )

    visit(0, 0, 0, F(1))
    assert result[0] == 0 and sum(result) == 1
    return result[1:]


def influence_law(p, a, b, y, c, v):
    result = [(p, a * (1 - p), c * (1 - p))]
    endpoints = sorted({F(0), y, v, F(1)})
    for left, right in zip(endpoints, endpoints[1:]):
        score = (left + right) / 2
        psi = -a * p + b * (F(score <= y) - y)
        switch = -c * p + F(score <= v) - v
        result.append(((1 - p) * (right - left), psi, switch))
    assert sum(probability for probability, _, _ in result) == 1
    assert sum(probability * psi for probability, psi, _ in result) == 0
    assert sum(probability * switch for probability, _, switch in result) == 0
    return result


def moments_and_be(law):
    vx = sum(w * x**2 for w, x, y in law)
    vy = sum(w * y**2 for w, x, y in law)
    cov = sum(w * x * y for w, x, y in law)
    determinant = vx * vy - cov**2
    assert vy > 0 and determinant >= 0

    def mahalanobis_squared(x, y):
        if determinant == 0:
            assert x == cov / vy * y
            return y**2 / vy
        return (vy * x**2 - 2 * cov * x * y + vx * y**2) / determinant

    # 480 exceeds 400 * 2**(1/4), and 1 + z**2 >= z**(3/2).
    beta = 480 * sum(w * (1 + mahalanobis_squared(x, y)**2) for w, x, y in law)
    beta_switch = 480 * sum(w * (1 + (y**2 / vy)**2) for w, x, y in law)
    return cov, vy, beta, beta_switch


def main():
    m, q, B = 8, F(1, 10), F(10)
    g, omega, zeta = F("0.018418"), F("0.086271"), F("0.91847")
    p, s = omega / B, 1 - omega / B
    W = s + B * p
    gamma, q_heavy = s / W, B * p / W
    grid = [q * k / m for k in range(1, m + 1)]
    v = (q * W - B * p) / s
    b_heavy, T_heavy = s * g / W, (s * g + B * p) / W
    f_a = (s * (1 - zeta) + B * p) / W
    assert 0 < g < v < 1 - zeta < 1 and f_a > q
    assert all(t not in (b_heavy, T_heavy) for t in grid)

    switch_coefficient = B - v - q * (B - 1)
    Qlow = forced_count_law(grid)
    Qhigh = forced_count_law(grid[:-1] + [q + gamma * zeta])
    jumps = [right - left for left, right in zip(Qlow, Qhigh)]
    assert sum(jumps) == 0
    betas, covariance, light_scores, bounds, variances, betas_switch = [], [], [], [], [], []
    regions = []
    for t in grid:
        if t < b_heavy or t > T_heavy:
            ind = int(t > T_heavy)
            y = (t * W - ind * B * p) / s
            a, b = gamma * B * (t - ind) / s**2, -gamma / s
            assert a == gamma * (t * (B - 1) + y - ind * B) / s
            assert gamma * y + ind * q_heavy == t
            light_scores.append(y)
            regions.append("below" if ind == 0 else "above")
        else:
            y = g
            a, b = q_heavy * (g - t) / (B * p**2), -q_heavy / (B * p)
            N_k = t * W - s * g
            assert a == q_heavy * (t * (B - 1) + g) / (B * p) - q_heavy * N_k / (B * p**2)
            assert gamma * g + q_heavy * N_k / (B * p) == t
            regions.append("window")

        cov, variance, beta, beta_switch = moments_and_be(influence_law(p, a, b, y, switch_coefficient, v))
        covariance.append(cov)
        variances.append(variance)
        betas.append(beta)
        betas_switch.append(beta_switch)
        bounds.append(abs(a) + abs(b))

    assert len(set(variances)) == len(set(betas_switch)) == 1
    var_D, beta_D = variances[0], betas_switch[0]
    num_c0 = -m * sum(jump * cov / k for k, (jump, cov) in enumerate(zip(jumps, covariance), 1))
    lower_c0 = F(18, 100)
    assert num_c0 > 0
    assert num_c0**2 > lower_c0**2 * 2 * F(22, 7) * var_D

    J = 4 * B + 3
    C_h = 4 * B / s**2 + 2 / s
    R = C_h + 1 + 2 / s
    margins = [
        margin for t in grid for margin in (abs(t - b_heavy), abs(t - T_heavy), f_a - t)
    ] + [q - t for t in grid[:-1]]
    delta = min([
        F(1, 2), p / 2, s / 2, min(margins) / (2 * J),
        *(min(y, 1 - y) / (2 * (C_h + 1)) for y in light_scores),
    ])
    c = min(2, s, s / (4 * (R + 2 / s + 1)))
    C_bad = (4 + 4 * m) * factorial(8) / c**8
    C_R = 1 + 7 / s + 8 * B / s**3 + 2 / (B * p**3) + 2 / (B * p**2) + 2 / p
    M = max(1, *bounds)
    C_D_upper = 2 * max(1, 1 / var_D) + 2 * beta_D
    D_Pi = m * (m - 1)
    K_upper = m * sum(F(1, k) for k in range(1, m + 1)) * (
        C_R + (1 + 2 * M) * C_bad + M * D_Pi * (M + C_R)
        + M * (1 + C_D_upper) + 2 * max(betas) + 2 * M**2
    )
    threshold_upper = max(F(2), delta**-3, (2 * K_upper / lower_c0)**10)
    exponent = 0
    while 10**exponent < threshold_upper:
        exponent += 1

    n = 10**40
    assert F(n) >= max(F(2), delta**-3)
    d, e = F(1, 10**16), F(1, 10**24)
    R2 = 8 * B / s**3 + 1 / s + 2 / (B * p**3) + 2 / (B * p**2)
    R1 = 6 / s + 2 / p
    remainder = e + R2 * d**2 + R1 / n
    eta = (4 + 4 * m) * factorial(100) / (c**100 * n**19)
    bracket = (
        remainder + (1 + 2 * M) * eta + M * D_Pi * d * (M * d + remainder)
        + (M * (1 + C_D_upper) + 2 * max(betas) + 2 * M**2) / 10**30
    )
    normalized = 10**20 * m * sum(F(1, k) for k in range(1, m + 1)) * bracket
    assert normalized < F(9, 100)
    print("Lim Example 13 fixed weight B=10")
    print(f"Grid regions: {', '.join(regions)}")
    print("Population grid identities, switch moments and covariance formulas checked exactly.")
    print(f"Gaussian coefficient exceeds {lower_c0}, with a rational upper bound on pi.")
    print(f"Coarse power-only threshold: 10^{exponent}.")
    print("Refined monotone error bound certifies n0 = 10^40.")


if __name__ == "__main__":
    main()
