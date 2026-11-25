# Reproducibility materials / 复现材料

The Python programs below use the standard library for finite exact-arithmetic checks. They are supplementary to the general mathematical arguments, not replacements for the proofs.

| Manuscript | Code |
|---|---|
| Perfect-tensor Rényi multi-entropy | [certificate_ame.py](perfect-tensor-renyi-multientropy/code/certificate_ame.py) |
| Annealed frequency reduction | [check_exact.py](annealed-frequency-reduction/code/check_exact.py) |
| Detailed-balance frequency reduction | [check_exact.py](detailed-balance-frequency-reduction/code/check_exact.py) |
| Chern–Simons four-cycle | [certificate_cycle.py](chern-simons-four-cycle/code/certificate_cycle.py) |
| Chern–Simons order three | [certificate_ternary.py](chern-simons-order-three/code/certificate_ternary.py) |

Run the selected script with Python 3.10 or newer, e.g. `python3 certificate_ame.py` in its code directory.

## Lean source

- [Detailed-balance frequency reduction](detailed-balance-frequency-reduction/formalization/): two auxiliary real-analysis lemmas, not a formalization of the entire paper.
- [Chern–Simons four-cycle](chern-simons-four-cycle/formalization/): algebraic consequences of the partition-count formulas, not a formalization of the complete replica-matrix argument.

Each Lean directory contains a toolchain and a pinned mathlib dependency. Run `lake build` from the corresponding directory. No new execution or Lean compilation result is asserted by this page.

以上程序为有限精确算术校验；Lean 源码仅涵盖所述辅助命题。此页不声称这些源码已在当前仓库重新运行或编译，也不声称整篇论文获得形式化认证。
