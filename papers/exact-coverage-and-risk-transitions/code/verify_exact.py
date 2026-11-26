"""Finite exact checks for the two-observation Gaffke coverage frontier."""

from fractions import Fraction as F
from itertools import product
from math import isqrt
import json


ZERO, ONE = F(0), F(1)


def lower_reject(x, y, theta, alpha):
    """Strict rejection from the two-piece endpoint test, with no radicals."""
    x, y = sorted((x, y))
    if y <= theta:
        return False
    if x >= theta:
        return theta**2 < alpha * x * y
    left = y * (theta - (1 - alpha) * x) - theta**2
    right = y * (theta - x)
    return left > 0 and left**2 > (1 - alpha) * right**2


def two_point(a, b, mean):
    """Return the two atoms and their exact probabilities."""
    assert a < mean < b
    return ((a, (b - mean) / (b - a)), (b, (mean - a) / (b - a)))


def evaluate(a, c, b, d, mean, alpha):
    outcomes = []
    for (x, p), (y, q) in product(two_point(a, c, mean), two_point(b, d, mean)):
        below = lower_reject(x, y, mean, alpha)
        above = lower_reject(1 - x, 1 - y, 1 - mean, alpha)
        assert not (below and above)
        outcomes.append((below, above, p * q))
    return outcomes


def loss(outcomes):
    return sum(weight for below, above, weight in outcomes if below or above)


def pure_bound_ok(value, alpha):
    """Test value <= alpha + (1-sqrt(alpha))^2 with integer comparisons."""
    left = 1 + 2 * alpha - value
    return left >= 0 and left**2 >= 4 * alpha


def d_threshold(a, mean, s):
    return mean**2 / ((1 - s) * (mean + s * a))


def mixing_polynomial(mean, alpha, s):
    return (1 + 2 * s) * mean**2 - (alpha + 2 * s) * mean + s**3


def check_corner_bound(a, c, b, d, mean, s):
    alpha = 1 - s**2
    out = evaluate(a, c, b, d, mean, alpha)
    value = loss(out)
    lower = tuple(i for i, (below, _, _) in enumerate(out) if below)
    upper = tuple(i for i, (_, above, _) in enumerate(out) if above)
    assert sum(out[i][2] for i in lower) <= alpha
    assert sum(out[i][2] for i in upper) <= alpha
    if not lower or not upper:
        assert value <= alpha
        return 'single_side'
    assert mean**2 < alpha and (1 - mean)**2 < alpha and alpha > F(1, 4)
    if lower == (3,) and upper == (0,):
        assert pure_bound_ok(value, alpha)
        return 'two_orthants'
    if len(upper) > 1:
        # Complement both coordinates to put the mixed event on the lower side.
        mean = 1 - mean
        a, c, b, d = 1 - c, 1 - a, 1 - d, 1 - b
        out = evaluate(a, c, b, d, mean, alpha)
        lower = tuple(i for i, (below, _, _) in enumerate(out) if below)
        upper = tuple(i for i, (_, above, _) in enumerate(out) if above)
        assert loss(out) == value
    assert upper == (0,) and lower in ((1, 3), (2, 3))
    if lower == (2, 3):
        a, c, b, d = b, d, a, c
    assert mean < alpha
    at_edge = 1 - (1 - mean)**2 / alpha
    assert a < at_edge < mean and d > d_threshold(a, mean, s)
    assert (d_threshold(at_edge, mean, s) < 1) == (mixing_polynomial(mean, alpha, s) < 0)
    envelope = 1 - (1 - alpha / (1 - mean)) * s * (1 - (1 - s) * at_edge / mean)
    assert value <= envelope
    return 'mixed_and_orthant'


def sqrt_interval(value, scale=10**14):
    lo = isqrt(value.numerator * scale**2 // value.denominator)
    return F(lo, scale), F(lo + 1, scale)


def fixed_risk_witnesses():
    witnesses = []
    # At 1/4, the two directions never both reject. Just above it,
    # the Bernoulli construction gives a value approaching 1/2.
    for alpha in (F(1, 10), F(1, 4), F(250001, 10**6), F(2, 5), F(47, 100)):
        qlo, qhi = sqrt_interval(alpha)
        mean = qlo - F(1, 10**10)
        actual = loss(evaluate(ZERO, ONE, ZERO, ONE, mean, alpha))
        if alpha <= F(1, 4):
            assert alpha - F(1, 10**8) < actual < alpha
        else:
            upper = alpha + (1 - qlo)**2
            lower = alpha + (1 - qhi)**2
            assert lower - F(1, 10**8) < actual < upper
        witnesses.append({'alpha': str(alpha), 'bernoulli_loss': str(actual)})
    return witnesses


def mixed_witnesses():
    witnesses = []
    for s in (F(723, 1000), F(18, 25), F(71, 100)):
        alpha = 1 - s**2
        vertex = (alpha + 2 * s) / (2 * (1 + 2 * s))
        left, right = vertex, alpha
        assert mixing_polynomial(left, alpha, s) < 0 < mixing_polynomial(right, alpha, s)
        for _ in range(36):
            middle = (left + right) / 2
            if mixing_polynomial(middle, alpha, s) < 0:
                left = middle
            else:
                right = middle
        mean = left - F(1, 10**8)
        at_edge = 1 - (1 - mean)**2 / alpha
        assert 0 < at_edge < mean and d_threshold(at_edge, mean, s) < 1
        a = at_edge - F(1, 10**12)
        d = (1 + d_threshold(a, mean, s)) / 2
        out = evaluate(a, ONE, ZERO, d, mean, alpha)
        assert tuple(i for i, (x, _, _) in enumerate(out) if x) == (1, 3)
        assert tuple(i for i, (_, y, _) in enumerate(out) if y) == (0,)
        actual = loss(out)
        assert alpha + right - F(1, 10**6) < actual < alpha + right
        witnesses.append({'alpha': str(alpha), 'loss_decimal': round(float(actual), 10),
                          'root_upper_error_below': '1/1000000'})
    return witnesses


def critical_enclosure():
    def cubic(s):
        return 1 + 3 * s - s**2 - 7 * s**3

    lower = F(723078468333508, 10**15)
    upper = F(723078468333509, 10**15)
    assert cubic(lower) > 0 > cubic(upper)
    alpha_lower = 1 - upper**2
    alpha_upper = 1 - lower**2
    assert F(477157528632466, 10**15) < alpha_lower < alpha_upper < F(477157528632469, 10**15)
    assert F(7, 16) < alpha_lower < alpha_upper < F(1, 2)
    return ['0.477157528632466', '0.477157528632469']


def expected_gain_checks():
    """Enclose the gain of an explicit mean-preserving near-extremizing law."""
    checked = 0
    for alpha in (F(1, 40), F(1, 100), F(1, 1000), F(1, 100000)):
        low, high = 3 * alpha / 8, 1 - 3 * alpha / 8
        ratio = low / high
        s_lo, s_hi = sqrt_interval(1 - alpha)
        u_lo, u_hi = 1 - s_hi, 1 - s_lo
        radicand_lo = u_lo**2 + 4 * u_lo * s_lo * ratio
        radicand_hi = u_hi**2 + 4 * u_hi * s_hi * ratio
        gain_lo = (u_lo + sqrt_interval(radicand_lo)[0]) / 2 - 1 + s_lo * sqrt_interval(1 - ratio)[0]
        gain_hi = (u_hi + sqrt_interval(radicand_hi)[1]) / 2 - 1 + s_hi * sqrt_interval(1 - ratio)[1]
        assert 0 < gain_lo < gain_hi
        for mean in [F(i, 20) for i in range(21)] + [low / 2, 1 - low / 2]:
            target = alpha * mean * (1 - mean) / 4
            if low <= mean <= high:
                p = (mean - low) / (high - low)
                low_bound = 4 * p * (1 - p) * high * gain_lo
                high_bound = 4 * p * (1 - p) * high * gain_hi
            else:
                # A degenerate marginal at this mean has exactly zero gain.
                low_bound, high_bound = ZERO, ZERO
            assert target - 2 * alpha**2 <= low_bound <= high_bound <= target + 2 * alpha**2
            checked += 1
    return checked


def main():
    counts = {'single_side': 0, 'two_orthants': 0, 'mixed_and_orthant': 0}
    base_grid = [F(i, 20) for i in range(21)]
    for s in (F(19, 20), F(7, 8), F(4, 5), F(3, 4), F(723, 1000), F(18, 25), F(71, 100)):
        alpha = 1 - s**2
        for mean in [F(i, 20) for i in range(1, 20)]:
            grid = sorted(set([*base_grid, mean / 2, (1 + mean) / 2]))
            laws = list(product((a for a in grid if a < mean), (b for b in grid if b > mean)))
            for (a, c), (b, d) in product(laws, repeat=2):
                category = check_corner_bound(a, c, b, d, mean, s)
                counts[category] += 1
    assert counts['mixed_and_orthant'] > 0
    illustrative = evaluate(F(1, 4), ONE, ZERO, F(99, 100), F(2, 5), F(301, 625))
    assert loss(illustrative) == F(436, 495)
    print(json.dumps({'status': 'pass', 'exact_grid_cases': counts,
                      'alpha_c_enclosure': critical_enclosure(),
                      'bernoulli_witnesses': fixed_risk_witnesses(),
                      'asymmetric_witnesses': mixed_witnesses(),
                      'illustrative_asymmetric_loss': str(loss(illustrative)),
                      'expected_gain_enclosures': expected_gain_checks(),
                      'scope': 'Rational evaluations and brackets. General coverage uses the written proof.'}, indent=2))


if __name__ == '__main__':
    main()
