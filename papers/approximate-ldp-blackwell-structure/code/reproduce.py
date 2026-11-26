"""Reproduce every finite certificate using only exact rational arithmetic."""

from fractions import Fraction as F
from hashlib import sha256
from itertools import product
import json
from pathlib import Path

from exact_ldp import (
    all_prototype_channel,
    arrangement_rays,
    canonical_rays,
    channel_losses,
    channel_rows,
    chi_square_column,
    exact_maximality_check,
    fraction_json,
    graph_components,
    orbit_channel,
    pairs,
    refinement_lp,
    utility_lp,
)


HERE = Path(__file__).resolve().parent


def main():
    result = {
        "arithmetic": "fractions.Fraction throughout; no floating-point computation",
        "scope": "Finite-instance certificates; not a replacement for universal proofs",
        "ray_enumeration": [],
        "all_prototype_channels": [],
        "utility_lp_certificates": [],
    }
    for e in [F(1), F(3, 2), F(2), F(3)]:
        for k in range(1, 6):
            candidates = canonical_rays(k, e)
            independently_enumerated = arrangement_rays(k, e)
            assert set(candidates) == set(independently_enumerated)
            assert all(len(graph_components(r, e)) == 1 for r in candidates)
            fingerprint = sha256(json.dumps(fraction_json(candidates)).encode()).hexdigest()
            result["ray_enumeration"].append({
                "k": k,
                "E": e,
                "candidate_count": len(candidates),
                "independent_arrangement_count": len(independently_enumerated),
                "sets_equal": True,
                "all_tight_graphs_connected": True,
                "sorted_ray_sha256": fingerprint,
            })
    print("Exact arrangement/prototype equality: 20 instances, k=1..5, E=1,3/2,2,3")

    for e in [F(1), F(2)]:
        for k in range(2, 6):
            columns = all_prototype_channel(k, e)
            losses = channel_losses(columns, e)
            assert channel_rows(columns) == [F(1)] * k
            assert len(set(losses.values())) == 1
            delta = next(iter(losses.values()))
            assert 0 < delta < 1
            check = exact_maximality_check(columns, e, losses)
            assert check["all_nonzero_column_graphs_connected"]
            entry = {
                "k": k,
                "E": e,
                "output_count": len(columns),
                "common_delta": delta,
                "row_sums": channel_rows(columns),
                "all_budgets_tight": len(check["active_pairs"]) == k * (k - 1),
                "all_active_column_graphs_connected": check["all_nonzero_column_graphs_connected"],
                "distinct_normalized_columns": len({tuple(x / sum(v) for x in v) for v in columns}),
            }
            if k == 3:
                entry["columns"] = columns
            result["all_prototype_channels"].append(entry)
    print("All-prototype channels: exact stochasticity, common interior budgets, and active-graph connectivity")

    orbit = orbit_channel([1, 2, 4])
    losses = channel_losses(orbit, F(2))
    assert set(losses.values()) == {F(1, 7)}
    check = exact_maximality_check(orbit, F(2), losses)
    assert check["stochastic"] and check["feasible"]
    assert check["all_nonzero_column_graphs_connected"]
    result["three_level_orbit_example"] = {
        "k": 3,
        "E": F(2),
        "columns": orbit,
        "common_delta": F(1, 7),
        "losses": [[i, j, losses[i, j]] for i, j in pairs(3)],
        "active_graph_components": check["components"],
        "chi_square_mutual_information": sum(chi_square_column(v) for v in orbit) - 1,
    }
    cyclic = [(F(1, 7), F(2, 7), F(4, 7)),
              (F(2, 7), F(4, 7), F(1, 7)),
              (F(4, 7), F(1, 7), F(2, 7))]
    cyclic_loss = channel_losses(cyclic, F(2))
    cyclic_check = exact_maximality_check(cyclic, F(2), cyclic_loss)
    assert cyclic_check["stochastic"] and cyclic_check["all_nonzero_column_graphs_connected"]
    result["three_level_cyclic_example"] = {
        "k": 3, "E": F(2), "columns": cyclic,
        "losses": [[i, j, cyclic_loss[i, j]] for i, j in pairs(3)],
        "active_graph_components": cyclic_check["components"],
    }

    for k, e, d in [
        (2, F(2), F(0)), (2, F(2), F(1, 3)),
        (3, F(1), F(0)), (3, F(1), F(1, 3)), (3, F(1), F(1)),
        (3, F(2), F(0)), (3, F(2), F(1, 7)), (3, F(2), F(1, 2)),
        (3, F(2), F(1)), (4, F(2), F(1, 5)),
    ]:
        budgets = {p: d for p in pairs(k)}
        cert = utility_lp(k, e, budgets)
        assert len(cert["support"]) <= k * k
        cert.update({"k": k, "E": e, "common_delta": d})
        result["utility_lp_certificates"].append(cert)
        print(f"Exact LP k={k}, E={e}, delta={d}: chi-square MI={cert['chi_square_mutual_information']}; support={len(cert['support'])}")

    graph_cases = []
    for e in [F(1), F(2)]:
        for k, grid in [(2, [F(j, 4) for j in range(5)]),
                        (3, [F(0), F(1, 2), F(1)])]:
            for first in product(grid, repeat=k):
                columns = [tuple(first), tuple(1 - x for x in first)]
                actual = channel_losses(columns, e)
                for mode in ["all_tight", "all_loosened", "alternating"]:
                    budgets = {
                        p: actual[p] if mode == "all_tight" or (mode == "alternating" and j % 2 == 0)
                        else (actual[p] + 1) / 2
                        for j, p in enumerate(pairs(k))
                    }
                    graph = exact_maximality_check(columns, e, budgets)
                    optimum = refinement_lp(columns, e, budgets)
                    is_connected = graph["all_nonzero_column_graphs_connected"]
                    assert (optimum["strict_gain"] == 0) == is_connected
                    graph_cases.append({
                        "k": k, "E": e, "first_column": first, "budget_mode": mode,
                        "connected_criterion": is_connected,
                        "exact_refinement_gain": optimum["strict_gain"],
                    })
    result["graph_vs_refinement_lp"] = {
        "case_count": len(graph_cases),
        "all_exact_comparisons_agree": True,
        "cases": graph_cases,
    }
    print(f"Active-graph condition versus independent exact refinement LP: {len(graph_cases)} cases agree")

    out = HERE.parent / "results" / "certificates.json"
    out.write_text(json.dumps(fraction_json(result), ensure_ascii=False, indent=2) + "\n")
    print("Wrote", out)


if __name__ == "__main__":
    main()
