"""Certify localization and uniqueness of the global mLSI optimizer."""
import certify as base


I = base.Interval
D = base.D
p0_lo, p0_hi = D("0.4765385"), D("0.4767385")
p2_lo, p2_hi = D("0.0234967"), D("0.0235167")
BOX = [
    I(p0_lo, p0_hi),
    I.exact(1) - I(p0_lo, p0_hi) - I(p2_lo, p2_hi),
    I(p2_lo, p2_hi),
]
CANDIDATE_UPPER = I.exact("2.037150367374")
RHO = I(base.LOWER.lo, CANDIDATE_UPPER.hi)


def cert_positive_hessian():
    # Coordinates are (p0,p2) with p1=1-p0-p2.
    basis = [(1, 0), (-1, -1), (0, 1)]
    h = [p / pi for p, pi in zip(BOX, base.PI)]
    hessian = [[I.exact(0) for _ in range(2)] for _ in range(2)]
    for (i, j), weight in base.W.items():
        coeff = weight * (h[i] + h[j])
        reduced = [I.exact(basis[i][k]) / BOX[i] - I.exact(basis[j][k]) / BOX[j]
                   for k in range(2)]
        for u in range(2):
            for v in range(2):
                hessian[u][v] += coeff * reduced[u] * reduced[v]

    scale = I.exact(2) * RHO
    for u in range(2):
        for v in range(2):
            dh = base.isum(I.exact(row[u] * row[v]) / p for row, p in zip(basis, BOX))
            hessian[u][v] -= scale * dh
    det = hessian[0][0] * hessian[1][1] - hessian[0][1] * hessian[1][0]
    assert hessian[0][0].lo > 0
    assert det.lo > 0
    print("hessian", hessian, flush=True)
    print("determinant", det, flush=True)


def inside_box(p):
    return p0_lo <= p[0].lo <= p[0].hi <= p0_hi and p2_lo <= p[2].lo <= p[2].hi <= p2_hi


def certify_exclusion():
    ratio = CANDIDATE_UPPER / base.LOWER
    assert base.EQ_LOWER.lo > CANDIDATE_UPPER.hi
    stats = dict(processed=0, equilibrium=0, box=0, tangent=0, deepest=0)
    stack = [(((1, 0, 0), (0, 1, 0), (0, 0, 1)), 0)]
    while stack:
        corners, depth = stack.pop()
        stats["processed"] += 1
        stats["deepest"] = max(stats["deepest"], depth)
        entries = [base.vertex(coords, depth, strict_local=True) for coords in corners]
        if all(local for _, _, local in entries):
            stats["equilibrium"] += 1
            continue
        if all(inside_box(p) for p, _, _ in entries):
            stats["box"] += 1
            continue
        gradient = base.likelihood_gradient(base.sum_coords(*corners), depth)
        if all(
            (base.isum(coeff * x for coeff, x in zip(gradient, p)) - ratio * scaled_entropy).lo > 0
            for p, scaled_entropy, _ in entries
        ):
            stats["tangent"] += 1
            continue
        if depth >= 32:
            raise RuntimeError((corners, depth))
        for child in base.subdivide(*corners):
            stack.append((child, depth + 1))
    return stats


if __name__ == "__main__":
    assert base.check_upper().hi < CANDIDATE_UPPER.lo
    cert_positive_hessian()
    print("triangles", certify_exclusion(), flush=True)
