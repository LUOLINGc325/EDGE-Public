#!/usr/bin/env python3
"""Assemble the complete, editable manuscript from reviewed proof parts."""
from pathlib import Path
import re

ROOT = Path(__file__).resolve().parents[1]
parts = [
    ("A", "fixed_order.md"),
    ("B", "growing_order.md"),
    ("C", "critical_window.md"),
    ("D", "high_order_interior.md"),
    ("E", "endpoint.md"),
]


def prefix_tags(s, prefix):
    s = re.sub(r"\\tag\{([^}]*)\}", lambda m: r"\tag{" + prefix + "." + m[1] + "}", s)
    s = re.sub(r"\((\d+\.\d+[a-z]?)\)", lambda m: "(" + prefix + "." + m[1] + ")", s)
    return s


def main():
    m = ROOT / "manuscript"
    text = (m / "overview.en.md").read_text()
    for letter, filename in parts:
        text += "\n\n" + prefix_tags((m / "parts" / filename).read_text(), letter)
    text += "\n\n" + (m / "references_and_validation.md").read_text()
    (m / "manuscript.en.md").write_text(text)
    print(f"Complete manuscript: {len(text)} characters; all five proof parts included.")


if __name__ == "__main__":
    main()
