"""Portable offline reproduction of finite symbolic/numerical certificates.

Use --quick for exact_minimum, amplitude_threshold and baseline_regression.
Full mode also runs 75 amplitude-spectrum cases and 1,100 interpolation
stress cases. All scripts must remain beside this runner. Generated JSON
and logs go to --output-dir. No network or dependency installation is used.
"""
from __future__ import annotations

import argparse
import ast
from datetime import datetime, timezone
from fractions import Fraction
import hashlib
import importlib.metadata
import json
import math
import os
from pathlib import Path
import platform
import subprocess
import sys
import time

DEPENDENCIES = ("numpy", "scipy", "sympy", "mpmath")
QUICK_STEPS = (
    ("exact_minimum", "exact_minimum_witness.py", "exact_minimum_witness.json"),
    ("amplitude_threshold", "amplitude_threshold_certificate.py", "amplitude_threshold_certificate.json"),
    ("baseline_regression", "quantum_sdpi.py", "regression.json"),
)
FULL_STEPS = QUICK_STEPS + (
    ("amplitude_full_spectrum", "amplitude_full_spectrum_regression.py", "amplitude_full_spectrum_regression.json"),
    ("interpolation_stress", "interpolation_stress.py", "interpolation_stress.json"),
)


def utc_now() -> str:
    return datetime.now(timezone.utc).isoformat()


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def qualified_name(node: ast.AST) -> str:
    if isinstance(node, ast.Name):
        return node.id
    if isinstance(node, ast.Attribute):
        prefix = qualified_name(node.value)
        return f"{prefix}.{node.attr}" if prefix else node.attr
    return ""


def source_review(source: Path) -> dict:
    """Narrow AST and text review; not an exhaustive security certification."""
    paths = [source / "reproduce.py"] + [source / item[1] for item in FULL_STEPS]
    reviewed, unexpected = [], []
    network_roots = {"requests", "urllib", "http", "socket", "ftplib", "aiohttp", "httpx"}
    dynamic_calls = {"eval", "exec", "__import__", "os.system", "os.popen"}
    for path in paths:
        tree = ast.parse(path.read_text(encoding="utf-8"), filename=path.name)
        imports, star_imports, subprocess_calls = set(), [], []
        for node in ast.walk(tree):
            if isinstance(node, ast.Import):
                imports.update(alias.name for alias in node.names)
            elif isinstance(node, ast.ImportFrom):
                imports.add(node.module or "")
                if any(alias.name == "*" for alias in node.names):
                    star_imports.append(node.lineno)
            elif isinstance(node, ast.Call):
                call = qualified_name(node.func)
                if call in dynamic_calls:
                    unexpected.append({"file": path.name, "line": node.lineno, "call": call})
                if call.startswith("subprocess."):
                    shell_values = [kw.value for kw in node.keywords if kw.arg == "shell"]
                    no_shell = len(shell_values) == 1 and isinstance(shell_values[0], ast.Constant) and shell_values[0].value is False
                    subprocess_calls.append({"line": node.lineno, "call": call, "shell_explicitly_false": no_shell})
                    if path.name != "reproduce.py" or not no_shell:
                        unexpected.append({"file": path.name, "line": node.lineno, "call": call})
        network_imports = sorted(name for name in imports if name.split(".")[0] in network_roots)
        if network_imports:
            unexpected.append({"file": path.name, "network_imports": network_imports})
        reviewed.append({"file": path.name, "sha256": sha256(path), "ast_parse": "passed",
                         "imports": sorted(imports), "wildcard_import_lines": star_imports,
                         "network_imports": network_imports, "subprocess_calls": subprocess_calls})
    lean = source / "ScalarCertificates.lean"
    lean_review = {"present": lean.exists(), "compiled_by_runner": False}
    if lean.exists():
        lean_review.update({"file": lean.name, "sha256": sha256(lean)})
    return {
        "scope": "AST syntax, listed import/call patterns, and hashes only; not an exhaustive security audit",
        "files": reviewed, "unexpected_findings": unexpected,
        "observations": [
            "The runner executes fixed local script names using argument lists and shell=False.",
            "No listed network imports or dynamic eval/exec calls were found when unexpected_findings is empty.",
            "Existing scripts write fixed JSON names relative to subprocess cwd; reruns overwrite known outputs.",
            "interpolation_stress.py uses a wildcard import from bundled quantum_sdpi; retained unchanged.",
            "Compiled numerical dependencies are outside this source review.",
            "Source assertions remain enabled because subprocess optimization is disabled.",
        ],
        "lean": lean_review,
    }


def require(condition: bool, explanation: str) -> None:
    if not condition:
        raise ValueError(explanation)


def validate(step: str, artifact: Path) -> dict:
    data = json.loads(artifact.read_text(encoding="utf-8"))
    if step == "exact_minimum":
        require(data["factorization_verified"] and data["trace_preserving"], "Exact certificate flags failed")
        require(Fraction(data["joint_eta"]) == Fraction(1312, 1377), "Incorrect exact joint coefficient")
        require(Fraction(data["single_eta"]) == Fraction(8, 9), "Incorrect exact single coefficient")
        require(Fraction(data["strict_gap"]) == Fraction(88, 1377), "Incorrect rational gap")
        return {"factorization_verified": True, "exact_gap": data["strict_gap"]}
    if step == "amplitude_threshold":
        require(len(data["thresholds"]) == 99, "Threshold table must cover k=2,...,100")
        require(len(data["explicit_witnesses"]) == 4, "Four scalar witnesses are required")
        require(data["exact_checks"]["M2_squared_identity"] and data["exact_checks"]["stationarity_identity"], "Critical-point identities failed")
        return {"threshold_count": 99, "explicit_witness_count": 4, "alpha_c2": data["alpha_c2"], "numerical_table_interval_certified": False}
    if step == "baseline_regression":
        tol = 1e-9
        require(len(data["midpoint_cases"]) == 12, "Twelve midpoint controls are required")
        values = [data["midpoint_max_abs_gap"], *data["basis_errors"], data["cao_generalized_eigen_residual"], data["cao_channel_checks"]["tp_error"]]
        require(all(math.isfinite(value) and abs(value) < tol for value in values), "Baseline tolerance exceeded")
        require(abs(data["cao_endpoint"]["eta1"] - 6 / 7) < tol, "Cao single control failed")
        require(abs(data["cao_endpoint"]["eta_joint"] - 45 / 49) < tol, "Cao product control failed")
        return {"midpoint_case_count": 12, "midpoint_max_abs_gap": data["midpoint_max_abs_gap"], "cao_single": data["cao_endpoint"]["eta1"], "cao_joint": data["cao_endpoint"]["eta_joint"], "tolerance": tol}
    if step == "amplitude_full_spectrum":
        require(len(data["cases"]) == 75, "Seventy-five spectrum controls are required")
        error = data["maximum_absolute_error"]
        require(math.isfinite(error) and error < 5e-9, "Spectrum tolerance exceeded")
        return {"case_count": 75, "maximum_absolute_error": error, "tolerance": 5e-9}
    if step == "interpolation_stress":
        require(data["pair_count"] == 110 and data["bound_case_count"] == 1100, "Incorrect stress count")
        require(not data["contradiction_candidates"], "Contradiction candidates require investigation")
        require(all(math.isfinite(item["margin"]) and item["margin"] <= data["numerical_tolerance"] for item in data["maximum_violation_margins"].values()), "Stress tolerance exceeded")
        return {"pair_count": 110, "bound_case_count": 1100, "local_comparison_count": data["local_comparison_count"], "positive_interval_case_count": data["positive_interval_case_count"], "convex_kernel_mixture_case_count": data["convex_kernel_mixture_case_count"], "maximum_violation_margins": data["maximum_violation_margins"], "tolerance": data["numerical_tolerance"]}
    raise ValueError("Unknown step")


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--output-dir", type=Path, default=Path("results"), help="Directory for JSON and logs")
    parser.add_argument("--quick", action="store_true", help="Run only the three short exact/scalar/baseline steps")
    args = parser.parse_args()
    source = Path(__file__).resolve().parent
    output = args.output_dir.expanduser().resolve()
    output.mkdir(parents=True, exist_ok=True)
    steps = QUICK_STEPS if args.quick else FULL_STEPS
    report = {"schema_version": 1, "mode": "quick" if args.quick else "full", "started_utc": utc_now(),
              "python_version": platform.python_version(),
              "packages": {name: importlib.metadata.version(name) for name in DEPENDENCIES},
              "network_operations": False,
              "scope": "Exact finite symbolic algebra and numerical diagnostics; this runner certifies no universal theorem or Lean proof",
              "source_review": source_review(source), "steps": [], "status": "running"}
    manifest = output / "reproduction_run.json"
    environment = os.environ.copy()
    environment.pop("PYTHONOPTIMIZE", None)
    environment["PYTHONNOUSERSITE"] = "1"
    for name in ("OPENBLAS_NUM_THREADS", "OMP_NUM_THREADS", "MKL_NUM_THREADS", "NUMEXPR_NUM_THREADS"):
        environment[name] = "1"
    start = time.monotonic()
    try:
        require(not report["source_review"]["unexpected_findings"], "Static review found an unexpected import or call")
        for name, script, artifact_name in steps:
            print(f"Running {name}", flush=True)
            tick = time.monotonic()
            completed = subprocess.run(
                [sys.executable, "-B", str(source / script)], cwd=output,
                env=environment, shell=False, check=False, capture_output=True, text=True,
            )
            record = {"name": name, "script": script, "artifact": artifact_name, "return_code": completed.returncode, "elapsed_seconds": round(time.monotonic() - tick, 6)}
            for stream in ("stdout", "stderr"):
                log_name = f"{name}.{stream}.log"
                log_text = getattr(completed, stream).replace(str(source), "<source>").replace(str(output), "<output>")
                (output / log_name).write_text(log_text, encoding="utf-8")
                record[f"{stream}_log"] = log_name
            report["steps"].append(record)
            require(completed.returncode == 0, f"{name} failed; see saved logs")
            artifact = output / artifact_name
            require(artifact.is_file(), f"{name} did not generate its artifact")
            record["sha256"] = sha256(artifact)
            record["validation"] = validate(name, artifact)
            record["status"] = "passed"
        report["status"] = "passed"
    except (OSError, ValueError, KeyError, TypeError) as error:
        report["status"] = "failed"
        report["error"] = str(error).replace(str(source), "<source>").replace(str(output), "<output>")
    finally:
        report["finished_utc"] = utc_now()
        report["elapsed_seconds"] = round(time.monotonic() - start, 6)
        manifest.write_text(json.dumps(report, indent=2, allow_nan=False) + "\n", encoding="utf-8")
    print(json.dumps({"status": report["status"], "mode": report["mode"], "completed_steps": len(report["steps"]), "manifest": manifest.name, "elapsed_seconds": report["elapsed_seconds"]}, indent=2))
    return 0 if report["status"] == "passed" else 1


if __name__ == "__main__":
    raise SystemExit(main())
