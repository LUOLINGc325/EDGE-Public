# Reproducing the stability calculations

Run the following commands from this directory.

```sh
python -m pip install sympy numpy scipy
python code/check_exact.py
python code/check_independent.py
python code/diagnostics.py
```

The programs record the manuscript digest and create JSON reports in `results/`. The exact checks cover the rational counterexamples, block Jacobians, the kernel budget, the quadratic coordinate change at the critical boundary, and the scalar threshold derivative. The independent check uses only the Python standard library. The numerical diagnostics illustrate finite-dimensional cases. The [manuscript](paper.en.md) contains the proofs and their scope.
