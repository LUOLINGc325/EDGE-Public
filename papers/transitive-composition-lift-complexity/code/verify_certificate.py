#!/usr/bin/env python3
"""Independent direct checker for a positive composition-lift certificate.

The checker does not import the solver and uses no synchronous automaton.
It verifies every recorded source path and the original word equations.
It certifies existence only; solver claims of minimality/unsatisfiability are
not accepted as proof objects by this checker.
"""
from __future__ import annotations

import argparse
from hashlib import sha256
import json
from pathlib import Path


def verify_certificate(instance: dict, certificate: dict) -> dict:
    def require(condition, message):
        if not condition:
            raise ValueError(message)

    m = instance["alphabet_size"]
    N = instance["source"]["nodes"]
    n = instance["target"]["nodes"]
    require(type(m) is int and m > 0, "invalid alphabet")
    require(type(N) is int and N >= 0 and type(n) is int and n >= 0, "invalid graph size")
    gedges = {tuple(e) for e in instance["source"]["edges"]}
    hedges = sorted({tuple(e) for e in instance["target"]["edges"]})
    for count, edges in [(N, gedges), (n, hedges)]:
        for e in edges:
            require(len(e) == 3 and all(type(x) is int for x in e), "invalid edge")
            require(0 <= e[0] < count and 0 <= e[1] < count and 0 <= e[2] < m,
                    "invalid edge index")
    raw_anchors = instance.get("anchors", {})
    if isinstance(raw_anchors, list):
        require(len(raw_anchors) == n, "anchor list length")
        raw_anchors = {q: s for q, s in enumerate(raw_anchors) if s is not None}
    require(isinstance(raw_anchors, dict), "anchors must be a dictionary or list")
    anchors = {}
    for q, s in raw_anchors.items():
        if isinstance(q, str):
            require(q.isdecimal(), "invalid anchor key")
            q = int(q)
        require(type(q) is int and type(s) is int, "invalid anchor index type")
        require(0 <= q < n and 0 <= s < N, "anchor outside graph")
        require(str(q) not in anchors or anchors[str(q)] == s, "conflicting anchors")
        anchors[str(q)] = s
    normalized = {"alphabet_size": m,
                  "source": {"nodes": N, "edges": [list(e) for e in sorted(gedges)]},
                  "target": {"nodes": n, "edges": [list(e) for e in hedges]},
                  "anchors": dict(sorted(anchors.items(), key=lambda kv: int(kv[0])))}
    digest = sha256(json.dumps(normalized, sort_keys=True, separators=(",", ":")).encode()).hexdigest()
    require(certificate.get("input_sha256") == digest, "certificate bound to a different instance")
    require(certificate.get("result") == "sat", "only positive witnesses are independently checked")
    assignment = certificate["source_assignment"]
    words = certificate["words"]
    paths = certificate["source_paths"]
    require(len(assignment) == n and len(words) == n, "incorrect assignment length")
    require(all(type(s) is int and 0 <= s < N for s in assignment), "source state out of range")
    for q, s in anchors.items():
        require(0 <= int(q) < n and assignment[int(q)] == s, "anchor violated")
    for word in words:
        require(isinstance(word, list) and all(type(i) is int and 0 <= i < m for i in word),
                "invalid word")
    require(len(paths) == len(hedges), "incorrect path count")
    total_path_length = 0
    for (a, b, i), path in zip(hedges, paths):
        require(path["target_edge"] == [a, b, i], "target edge order or identity differs")
        p = path["word"]
        vertices = path["vertices"]
        require(isinstance(p, list) and all(type(j) is int and 0 <= j < m for j in p), "invalid path word")
        require(len(vertices) == len(p) + 1, "path length and word length differ")
        require(all(type(s) is int and 0 <= s < N for s in vertices), "invalid path vertex")
        require(vertices[0] == assignment[a] and vertices[-1] == assignment[b], "path endpoints differ")
        for j, label in enumerate(p):
            require((vertices[j], vertices[j + 1], label) in gedges, "source path uses a missing edge")
        require(words[a] + p == [i] + words[b], "raw word equation fails")
        total_path_length += len(p)
    depth = max(map(len, words), default=0)
    require(certificate["max_word_depth"] == depth, "reported word depth differs")
    return {"status": "verified", "target_vertices": n, "target_edges": len(hedges),
            "max_word_depth": depth, "total_source_path_length": total_path_length,
            "scope": "existence and exact raw equations; not minimality or unsatisfiability"}


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("instance", type=Path)
    parser.add_argument("certificate", type=Path)
    args = parser.parse_args()
    result = verify_certificate(json.loads(args.instance.read_text()), json.loads(args.certificate.read_text()))
    print(json.dumps(result, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
