"""Certify Taye’s three-state entropy-decay constant using only Python stdlib."""
from dataclasses import dataclass
from decimal import Context, Decimal, ROUND_HALF_EVEN
from functools import lru_cache
import os

CTX = Context(prec=int(os.environ.get('MLSI_CERT_PRECISION', '50')), rounding=ROUND_HALF_EVEN)
D = Decimal


@dataclass(frozen=True, slots=True)
class Interval:
    lo: Decimal
    hi: Decimal

    @staticmethod
    def exact(x):
        x = D(x)
        return Interval(x, x)

    @staticmethod
    def outward(lo, hi):
        # Expand rounded endpoint evaluations to adjacent context numbers.
        return Interval(CTX.next_minus(lo), CTX.next_plus(hi))

    def __add__(self, other):
        return self.outward(CTX.add(self.lo, other.lo), CTX.add(self.hi, other.hi))

    def __sub__(self, other):
        return self.outward(CTX.subtract(self.lo, other.hi), CTX.subtract(self.hi, other.lo))

    def __mul__(self, other):
        corners = [CTX.multiply(a, b) for a in (self.lo, self.hi) for b in (other.lo, other.hi)]
        return self.outward(min(corners), max(corners))

    def __truediv__(self, other):
        assert not (other.lo <= 0 <= other.hi)
        corners = [CTX.divide(a, b) for a in (self.lo, self.hi) for b in (other.lo, other.hi)]
        return self.outward(min(corners), max(corners))

    def exp(self):
        return self.outward(CTX.exp(self.lo), CTX.exp(self.hi))

    def log(self):
        assert self.lo > 0
        return self.outward(CTX.ln(self.lo), CTX.ln(self.hi))

    def sqrt(self):
        assert self.lo >= 0
        return self.outward(CTX.sqrt(self.lo), CTX.sqrt(self.hi))


def isum(xs):
    acc = Interval.exact(0)
    for x in xs:
        acc = acc + x
    return acc


E = [Interval.exact(value) for value in ("0", "0.4", "3.0")]
GAMMA = {
    (0, 1): Interval.exact("1"),
    (0, 2): Interval.exact("4.6"),
    (1, 2): Interval.exact("0.12"),
}
I_ZERO = Interval.exact(0)
I_TWO = Interval.exact(2)
BOLTZMANN = [(I_ZERO - energy).exp() for energy in E]
Z = isum(BOLTZMANN)
PI = [wt / Z for wt in BOLTZMANN]
K = {}
for (i, j), gamma in GAMMA.items():
    K[i, j] = gamma * ((E[i] - E[j]) / I_TWO).exp()
    K[j, i] = gamma * ((E[j] - E[i]) / I_TWO).exp()
W = {(i, j): PI[i] * K[i, j] for i, j in GAMMA}
DIAG = [isum(K[i, j] for j in range(3) if j != i) for i in range(3)]
GAP_SUM = isum(DIAG)
GAP_PRODUCT = isum(DIAG[i] * DIAG[j] - K[i, j] * K[j, i] for i, j in GAMMA)
GAP = (GAP_SUM - (GAP_SUM * GAP_SUM - Interval.exact(4) * GAP_PRODUCT).sqrt()) / I_TWO
LOWER = Interval.exact("2.037150367")
UPPER = Interval.exact("2.037150368")
R2LOW = I_TWO * LOWER
EQUILIBRIUM_FRACTION = Interval.exact("0.004")
EQ_LOWER = GAP * (Interval.exact(1) - EQUILIBRIUM_FRACTION) / (Interval.exact(1) + EQUILIBRIUM_FRACTION)
TRUST_LO = D("0.996")
TRUST_HI = D("1.004")


@lru_cache(maxsize=200000)
def vertex(coords, depth, strict_local=False):
    denom = Interval.exact(1 << depth)
    p = tuple(Interval.exact(x) / denom if x else I_ZERO for x in coords)
    h = tuple(x / pi if n else I_ZERO for n, x, pi in zip(coords, p, PI))
    nl2d = R2LOW * isum(x * likelihood.log() for n, x, likelihood in zip(coords, p, h) if n)
    if strict_local:
        local = all(TRUST_LO < ratio.lo <= ratio.hi < TRUST_HI for ratio in h)
    else:
        local = all(TRUST_LO <= ratio.lo <= ratio.hi <= TRUST_HI for ratio in h)
    return p, nl2d, local


def likelihood_gradient(center, depth):
    denom = Interval.exact(3 * (1 << depth))
    h = [Interval.exact(x) / denom / pi for x, pi in zip(center, PI)]
    logs = [x.log() for x in h]
    gradient = [I_ZERO, I_ZERO, I_ZERO]
    for (i, j), flow in W.items():
        diff = h[i] - h[j]
        log_diff = logs[i] - logs[j]
        gradient[i] = gradient[i] + flow * (log_diff + diff / h[i]) / PI[i]
        gradient[j] = gradient[j] - flow * (log_diff + diff / h[j]) / PI[j]
    return tuple(gradient)


def sum_coords(*vals):
    return tuple(sum(c) for c in zip(*vals))


def subdivide(a, b, c):
    # Child coordinates have twice the parent denominator.
    ab, ac, bc = sum_coords(a, b), sum_coords(a, c), sum_coords(b, c)
    return (
        (sum_coords(a, a), ab, ac),
        (sum_coords(b, b), ab, bc),
        (sum_coords(c, c), ac, bc),
        (ab, ac, bc),
    )


def check_upper():
    p = [Interval.exact(x) for x in ("0.4766385", "0.4998548", "0.0235067")]
    ratio = [x / pi for x, pi in zip(p, PI)]
    log_ratio = [x.log() for x in ratio]
    entropy = isum(x * y for x, y in zip(p, log_ratio))
    production = isum(
        flow * (ratio[i] - ratio[j]) * (log_ratio[i] - log_ratio[j])
        for (i, j), flow in W.items()
    )
    candidate = production / (I_TWO * entropy)
    assert candidate.hi < UPPER.lo
    return candidate


def certify_lower():
    assert EQ_LOWER.lo > LOWER.hi
    stats = dict(processed=0, local=0, tangent=0, deepest=0)
    stack = [(((1, 0, 0), (0, 1, 0), (0, 0, 1)), 0)]
    while stack:
        corners, depth = stack.pop()
        stats["processed"] += 1
        stats["deepest"] = max(stats["deepest"], depth)
        entries = [vertex(coords, depth) for coords in corners]
        if all(local for _, _, local in entries):
            stats["local"] += 1
            continue
        # Homogeneity cancels the intercept of the entropy-production tangent.
        gradient = likelihood_gradient(sum_coords(*corners), depth)
        if all(
            (isum(coeff * x for coeff, x in zip(gradient, p)) - scaled_entropy).lo >= 0
            for p, scaled_entropy, _ in entries
        ):
            stats["tangent"] += 1
            continue
        if depth >= 32:
            raise RuntimeError(f"Lower bound unresolved at depth {depth}: {corners}")
        for child in subdivide(*corners):
            stack.append((child, depth + 1))
    return stats


def main():
    if not __debug__:
        raise RuntimeError('Run the verifier with assert statements enabled')
    upper_check = check_upper()
    print('decimal_precision', CTX.prec, flush=True)
    print("spectral_gap", GAP, flush=True)
    print("local_certificate", EQ_LOWER, flush=True)
    print("candidate", upper_check, flush=True)
    print("triangles", certify_lower(), flush=True)
    print(f"certificate: {LOWER.lo} <= rho < {UPPER.hi}", flush=True)


if __name__ == "__main__":
    main()
