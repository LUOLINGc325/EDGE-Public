# Reproducing the clearing-system calculations

Run the commands from this directory with Python 3.12. The exact diagnostic uses the Python standard library. The symbolic check uses SymPy 1.14.0.

```sh
python3 code/exact_diagnostics.py
python3 -m pip install sympy==1.14.0
python3 code/symbolic_identities.py
```

The [exact diagnostics](results/exact_diagnostics.json) cover a finite grid of rates and rewards. The [worked instances](results/exact_examples.json) include the two-job equality and counterexamples below the threshold. The [symbolic results](results/symbolic_identities.json) verify 13 identities. The proof for all allowed rates and initial populations is in the [manuscript](paper.en.md).
