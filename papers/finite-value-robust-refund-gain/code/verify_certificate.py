"""Independent exact checker for the three-state refund certificate.

This file deliberately uses generic two-dimensional line intersections, not the
certificate producer's posterior-vertex routine.  It is an analysis script, not
formalization code or a statement of a value-gate decision.
"""

from fractions import Fraction as F
from itertools import combinations
from pathlib import Path
import hashlib
import json
import time
import argparse


ROOT = Path(__file__).resolve().parents[1]


def rational_log_bounds(z, terms=64):
    """Enclose log(z) for rational z>=1 via the atanh series.

    If y=(z-1)/(z+1), the omitted positive tail after terms is at most
    2*y**(2*terms+1)/((2*terms+1)*(1-y*y)).  Every operation here is rational.
    """
    assert z >= 1
    y = (z - 1) / (z + 1)
    lower = 2 * sum((y ** (2*j + 1)) / (2*j + 1) for j in range(terms))
    upper = lower + 2 * y ** (2*terms + 1) / ((2*terms + 1) * (1 - y*y))
    return lower, upper


def parse_and_check(source):
    raw = Path(source).read_bytes()
    data = json.loads(raw)
    vals = tuple(map(F, data["values"]))
    prior = tuple(map(F, data["prior"]))
    cost = F(data["cost"])
    refund = F(data["refund"])
    lam = tuple(map(F, data["minorant"]))
    offers = [(F(o["price"]), None if o["refund"] is None else F(o["refund"]), F(o["weight"])) for o in data["offers"]]
    assert vals == (F(0), F(1, 2), F(1))
    assert prior == (F(1, 4), F(1, 2), F(1, 4))
    assert cost == 1 and refund == F(49, 100)
    assert sum(prior) == 1 and all(p > 0 for p in prior)
    assert sum(w for _, _, w in offers) == 1
    assert all(w > 0 for _, _, w in offers)
    assert all(0 <= p <= vals[-1] and (r is None or 0 < r <= p) for p, r, _ in offers)
    assert all(r is None or (r == refund and r not in vals) for _, r, _ in offers)
    guarantee = sum(x * y for x, y in zip(lam, prior))
    assert guarantee == F(data["guaranteed"])

    # Independent exact enclosure of both nonrefund candidate roots.  For
    # t=1/2, S(t)=3/8; for t=1, S(t)=1/2.  U_t(x)=x(1+log(t/x))
    # is strictly increasing for x<t, so these signs certify the benchmark.
    r_lower = F(191201784801, 10**12)
    r_upper = F(191201784802, 10**12)
    t = F(1, 2)
    _, lo_log_upper = rational_log_bounds(t / r_lower)
    hi_log_lower, _ = rational_log_bounds(t / r_upper)
    whole_log_lower, _ = rational_log_bounds(F(1) / r_lower)
    assert r_lower * (1 + lo_log_upper) < F(3, 8)
    assert r_upper * (1 + hi_log_lower) > F(3, 8)
    assert r_lower * (1 + whole_log_lower) > F(1, 2)
    assert guarantee > r_upper
    strict_gap = guarantee - r_upper

    # Coordinates x=q_1, y=q_2, so q_0=1-x-y.  A line is A*x+B*y=C.
    lines = [(F(1), F(0), F(0), "edge_q1_zero"),
             (F(0), F(1), F(0), "edge_q2_zero"),
             (F(1), F(1), F(1), "edge_q0_zero")]
    for p, r, _ in offers:
        value = vals if r is None else tuple(max(v, r) for v in vals)
        lines.append((value[1] - value[0], value[2] - value[0], p - value[0], "no_refund" if r is None else "refund"))
    vertices = set()
    nonparallel_pairs = 0
    feasible_pairs = 0
    origins = {}
    for first, second in combinations(lines, 2):
        a, b, z, tag1 = first
        c, d, w, tag2 = second
        determinant = a * d - b * c
        if determinant == 0:
            continue
        nonparallel_pairs += 1
        x = (z * d - b * w) / determinant
        y = (a * w - z * c) / determinant
        if x < 0 or y < 0 or x + y > 1:
            continue
        feasible_pairs += 1
        q = (1 - x - y, x, y)
        vertices.add(q)
        origins.setdefault(q, set()).add(tuple(sorted((tag1, tag2))))

    smallest = None
    smallest_points = []
    tie_vertex_count = 0
    refund_tie_vertex_count = 0
    double_family_vertex_count = 0
    total_tie_incidence = 0
    negative_refund_tie_incidence = 0
    zero_slack_count = 0
    strict_constraint_count = 0
    tie_constraint_count = 0
    for q in sorted(vertices):
        mean = sum(v * x for v, x in zip(vals, q))
        total = F(0)
        tied_families = set()
        for p, r, weight in offers:
            if r is None:
                willing = mean
                if willing > p:
                    profit = p
                elif willing < p:
                    profit = F(0)
                else:
                    profit = F(0)  # min(reject=0, buy=p)
                    tied_families.add("no_refund")
                    total_tie_incidence += 1
            else:
                willing = sum(max(v, r) * x for v, x in zip(vals, q))
                low_prob = sum(x for v, x in zip(vals, q) if v < r)
                bought_profit = p - (r + cost) * low_prob
                if willing > p:
                    profit = bought_profit
                elif willing < p:
                    profit = F(0)
                else:
                    profit = min(F(0), bought_profit)
                    tied_families.add("refund")
                    total_tie_incidence += 1
                    if bought_profit < 0:
                        negative_refund_tie_incidence += 1
            total += weight * profit
        lower = sum(x * y for x, y in zip(lam, q))
        slack = total - lower
        if slack < 0:
            raise AssertionError(f"Invalid lower certificate at {q}: {slack}")
        if smallest is None or slack < smallest:
            smallest = slack
            smallest_points = [q]
        elif slack == smallest:
            smallest_points.append(q)
        zero_slack_count += slack == 0
        if tied_families:
            tie_vertex_count += 1
            tie_constraint_count += 1
        else:
            strict_constraint_count += 1
        refund_tie_vertex_count += "refund" in tied_families
        double_family_vertex_count += len(tied_families) == 2

    nedge = sum(any(x == 0 for x in q) for q in vertices)
    pure = sum(sum(x > 0 for x in q) == 1 for q in vertices)
    edge_interior = nedge - pure
    interior = len(vertices) - nedge
    report = {
        "source_sha256": hashlib.sha256(raw).hexdigest(),
        "algorithm": "all pairs of two-dimensional purchase and simplex-boundary lines; exact Fraction determinants",
        "offer_count": len(offers),
        "no_refund_count": sum(r is None for _, r, _ in offers),
        "positive_refund_count": sum(r is not None for _, r, _ in offers),
        "positive_refund_weight": str(sum(w for _, r, w in offers if r is not None)),
        "weight_sum": str(sum(w for _, _, w in offers)),
        "positive_weight_check": True,
        "line_count": len(lines),
        "nonparallel_line_pairs": nonparallel_pairs,
        "feasible_line_pairs_with_multiplicity": feasible_pairs,
        "vertex_count": len(vertices),
        "claimed_vertex_count": data["vertex_count"],
        "claimed_vertex_count_agrees": len(vertices) == data["vertex_count"],
        "pure_vertices": pure,
        "edge_interior_vertices": edge_interior,
        "edge_q0_zero_interior_vertices": sum(q[0] == 0 and q[1] > 0 and q[2] > 0 for q in vertices),
        "edge_q1_zero_interior_vertices": sum(q[1] == 0 and q[0] > 0 and q[2] > 0 for q in vertices),
        "edge_q2_zero_interior_vertices": sum(q[2] == 0 and q[0] > 0 and q[1] > 0 for q in vertices),
        "interior_vertices": interior,
        "purchase_tie_vertices": tie_vertex_count,
        "refund_tie_vertices": refund_tie_vertex_count,
        "both_family_tie_vertices": double_family_vertex_count,
        "purchase_tie_incidences": total_tie_incidence,
        "negative_refund_purchase_tie_incidences": negative_refund_tie_incidence,
        "strict_only_vertex_constraints": strict_constraint_count,
        "tie_vertex_constraints": tie_constraint_count,
        "all_vertex_constraints_nonnegative": True,
        "zero_slack_vertices": zero_slack_count,
        "minimum_vertex_slack": str(smallest),
        "minimum_vertex_slack_float": float(smallest),
        "minimum_slack_points": [[str(z) for z in q] for q in smallest_points],
        "minorant": [str(x) for x in lam],
        "guarantee": str(guarantee),
        "guarantee_float": float(guarantee),
        "guarantee_equals_minorant_at_prior": True,
        "no_refund_benchmark_lower_strict": str(r_lower),
        "no_refund_benchmark_upper_strict": str(r_upper),
        "benchmark_verification": "64-term rational atanh log series with a geometric rational remainder bound; root for t=1 is below lower endpoint; root for t=1/2 is inside interval",
        "strict_improvement_lower_bound": str(strict_gap),
        "strict_improvement_lower_bound_float": float(strict_gap),
    }
    assert report["claimed_vertex_count_agrees"], "Producer and independent arrangement counts differ"
    return report


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--certificate", type=Path, default=ROOT / "results/certificate.json")
    parser.add_argument("--output", type=Path, default=ROOT / "results/exact_check.json")
    args = parser.parse_args()
    started = time.perf_counter()
    result = parse_and_check(args.certificate)
    result["elapsed_seconds"] = time.perf_counter() - started
    args.output.parent.mkdir(parents=True, exist_ok=True)
    args.output.write_text(json.dumps(result, indent=2) + "\n")
    print(json.dumps(result, indent=2))
