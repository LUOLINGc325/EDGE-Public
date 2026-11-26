"""Exact continuum upper certificates; Python standard library only.

These are ordinary reproducibility calculations, not formal proof-assistant code.
The manuscript proves that the finite breakpoint test is exact.
"""
from fractions import Fraction as Q
from pathlib import Path
import json


def kernel(z, x):
    z, x = Q(z), Q(x)
    if not (0 < z < 1 and 0 <= x <= 1):
        raise ValueError("This finite certificate requires interior seeds.")
    if x <= z:
        return 1 / (1 - x)
    if x <= 2 * z:
        return (1 - x + z) / (1 - z)
    return (1 - z) / (1 - x + z)


def certificate(seeds, masses, target):
    if sum(masses) != 1 or min(masses) < 0:
        raise AssertionError("Invalid probability vector")
    points = sorted({Q(0), Q(1)} | {
        b for z in seeds for b in (z, 2*z, 1-z, 2*(1-z)) if 0 <= b <= 1
    })
    rows = []
    for x in points:
        left = sum((p*kernel(z, x) for z, p in zip(seeds, masses)), Q(0))
        right = sum((p*kernel(1-z, x) for z, p in zip(seeds, masses)), Q(0))
        if max(left, right) > target:
            raise AssertionError((x, left, right, target))
        rows.append({"x": str(x), "left": str(left), "right": str(right),
                     "slack_left": str(target-left), "slack_right": str(target-right)})
    attained = [r["x"] for r in rows if max(Q(r["left"]), Q(r["right"])) == target]
    if not attained:
        raise AssertionError("Claimed exact worst case is not attained")
    return {"seeds": list(map(str, seeds)), "masses": list(map(str, masses)),
            "exact_worst": str(target), "decimal_for_display_only": float(target),
            "attaining_boundary_endpoints": attained, "rows": rows,
            "certificate_basis": "piecewise convexity on the full continuous boundary domain"}


def main():
    five = certificate([Q(k, 10) for k in range(3, 8)],
                       [Q(v, 97) for v in (14, 12, 45, 12, 14)], Q(176, 97))
    thirteen = certificate([Q(k, 30) for k in range(9, 22)],
                           [Q(v, 2000) for v in (245, 61, 48, 132, 55, 55, 808,
                                                55, 55, 132, 48, 61, 245)],
                           Q(2340000389, 1293292000))
    lower = Q(3617, 2000)
    gap = Q(thirteen["exact_worst"]) - lower
    if not (0 < gap < Q(837, 1000000) and Q(thirteen["exact_worst"]) < Q(181, 100)):
        raise AssertionError("Comparison certificate failed")
    result = {"status": "passed", "arithmetic": "exact rational", "five_atom": five,
              "thirteen_atom": thirteen, "lower": str(lower), "certified_gap": str(gap),
              "gap_decimal_for_display_only": float(gap)}
    destination = Path(__file__).resolve().parents[1] / "results" / "upper_certificate.json"
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_text(json.dumps(result, indent=2) + "\n", encoding="utf-8")
    print(json.dumps({"status": "passed", "five_atom": five["exact_worst"],
                      "thirteen_atom": thirteen["exact_worst"],
                      "breakpoints": [len(five["rows"]), len(thirteen["rows"])],
                      "gap": str(gap)}, indent=2))


if __name__ == "__main__":
    main()
