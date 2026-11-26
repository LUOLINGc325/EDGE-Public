# Comparison with Lai's solver

Save the [pinned third-party source](https://github.com/cylai-nycu/quantum-code-lp/blob/20ed01cf79cf49ccaf8eea524a40d451e7d536ca/refined_lp/binary/binary_RXxRY_stabilizer_reference_realLP.py) as `code/source_RXxRY.py` in this project. Its SHA-256 is `1ff6c96aa79dd70b06e3e51b05eb7b567af10ad89b501270a996fdfc58d2b1b5`. Use the dependencies specified by that source, including the solver bindings, NumPy and SciPy.

Run `python3 code/run_b2_hxrx_reference6.py` for the smaller reference-weight diagnostic and `python3 code/scale_hxrx_diagnostic.py` for its row-scaled comparison. The full diagnostic is `python3 code/run_b2_reference6.py`. These are numerical comparisons for one reference weight.
