"""Conditional-strip quadrature cross-checks for the limiting profiles."""
import json
import math

import numpy as np
from scipy.integrate import quad
from scipy.special import ndtr, ndtri


def density(z):
    return math.exp(-z * z / 2) / math.sqrt(2 * math.pi)


def normal_interval(low, high, mean=0, sd=1):
    if sd < 1e-14:
        return float(low < mean < high)
    return float(ndtr((high - mean) / sd) - ndtr((low - mean) / sd))


def rectangle(intervals, means, residuals):
    (lo, hi), (left, right) = intervals
    mu, eta = means
    sd = float(np.linalg.norm(residuals[0]))
    if sd < 1e-14:
        if not lo < mu < hi:
            return 0.0
        return normal_interval(left, right, eta, np.linalg.norm(residuals[1]))
    direction = residuals[0] / sd
    slope = float(residuals[1] @ direction)
    remaining = float(np.linalg.norm(residuals[1] - slope * direction))
    a, b = (lo - mu) / sd, (hi - mu) / sd
    if remaining < 1e-14:
        if abs(slope) < 1e-14:
            return normal_interval(a, b) if left < eta < right else 0.0
        l, r = sorted(((left - eta) / slope, (right - eta) / slope))
        a, b = max(a, l), min(b, r)
        return normal_interval(a, b) if a < b else 0.0
    a, b = max(a, -10), min(b, 10)
    if a >= b:
        return 0.0
    centers = [(value - eta) / slope for value in (left, right)] if abs(slope) > 1e-14 else []
    points = sorted(set(c for c in centers if a < c < b))
    integrand = lambda z: density(z) * normal_interval(left, right, eta + slope * z, remaining)
    return quad(integrand, a, b, points=points, epsabs=2e-11, limit=150)[0]


def acceptance_slope(rows, h):
    q = 1 - h
    A, B, C = (float(ndtri(1 - q / k)) for k in (6, 3, 2))
    total = 0.0
    for i in range(3):
        others = [j for j in range(3) if j != i]
        linear = rows[others] @ rows[i]
        residuals = rows[others] - linear[:, None] * rows[i]
        allowed = [[(-A, -C), (C, A)] if j < i else [(-A, A)] for j in others]
        both_above = [(-A, -B), (B, A)]

        def strip_integrand(x):
            means = C * x * linear
            outer = sum(rectangle((p, r), means, residuals) for p in allowed[0] for r in allowed[1])
            remove = sum(rectangle((p, r), means, residuals) for p in both_above for r in both_above)
            return density(C * x) * (outer - remove)

        total += C * quad(strip_integrand, -1, 1, epsabs=2e-9, limit=150)[0]
    return total / h


def limiting_pair(r, beta, gamma, scale):
    A0, B0 = float(ndtri(5 / 6)), float(ndtri(2 / 3))
    v = math.sqrt(1 - r * r)
    single = 2 * normal_interval(-A0, A0, sd=v) + normal_interval(-B0, B0, sd=v)
    if scale == 0:
        return single - normal_interval(-A0, A0, sd=v)
    maximum = min(2 / scale, 10)
    if abs(beta) > 1e-14 and gamma < 1e-14:
        maximum = min(maximum, A0 / abs(beta))
    overlap = 2 * quad(
        lambda z: density(z) * (1 - scale * z / 2) * normal_interval(-A0, A0, beta * z, gamma),
        0, maximum, epsabs=1e-12,
    )[0]
    return single - overlap


def limiting_triple(a, b):
    # Residuals 0, aV and -bV have ordered successive gaps a|V| and b|V|.
    return 1 + sum(
        quad(lambda z: min(2, gap * z) * density(z), 0, 10, points=[2 / gap], epsabs=1e-12)[0]
        for gap in (a, b)
    )


def main():
    output = []
    for h in (0.002, 0.0002):
        C = float(ndtri((1 + h) / 2))
        models = []
        for r, beta, scale in [(0.4, 0.5, 0.2), (0.4, 0.5, 2.0), (0.4, 0.5, 7.0), (0.35, math.sqrt(1 - 0.35**2), 2.0)]:
            gamma_squared = 1 - r*r - beta*beta
            gamma = math.sqrt(gamma_squared) if gamma_squared > 1e-14 else 0.0
            s = scale * C
            rows = np.array([[math.sqrt(1-s*s), s, 0], [1, 0, 0], [r, beta, gamma]])
            models.append((f"pair-r{r:.2f}-scale{scale:g}", rows, limiting_pair(r, beta, gamma, scale)))
        a, b = 0.7, 1.2
        rows = np.array([[1, 0, 0], [math.sqrt(1-(a*C)**2), a*C, 0], [math.sqrt(1-(b*C)**2), -b*C, 0]])
        models.append(("triple-all-finite-ratios", rows, limiting_triple(a, b)))
        for label, rows, target in models:
            estimate = acceptance_slope(rows, h)
            if abs(estimate - target) > (0.02 if h > 0.001 else 0.003):
                raise AssertionError((label, h, estimate, target))
            output.append({"scenario": label, "h": h, "finite_slope": round(estimate, 7), "limit": round(target, 7)})
    print(json.dumps({"method": "deterministic Gaussian conditional-strip quadrature", "checks": output}, indent=2))


if __name__ == "__main__":
    main()
