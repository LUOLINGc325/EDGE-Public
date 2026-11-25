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

## Complete formal proof packages

- [clique-dually-conformal-induced-extension](clique-dually-conformal-induced-extension/formalization/) — The archived release records full coverage of the induced CDC extension theorem, maximal cliques, minimal transversals, dual clique characterization, and exact vertex count. Its 127 module declarations were reported to depend only on propext, Classical.choice and Quot.sound.
- [deletion-intersection-counterexample](deletion-intersection-counterexample/formalization/) — The archived release records formal verification of both fixed-length deletion-ball counterexamples (length 13 and 15), including the deletion-ball definition, exact finite witnesses, and the contradiction to the proposed formula. This does not automatically cover later generalizations.
- [ququart-swapping-fixed-resource-range](ququart-swapping-fixed-resource-range/formalization/) — The archived release records coverage of the explicit four-level Bell swapping protocol, normalized complex inputs, attainable interval, both endpoints, and all intermediate values for real resource parameters in [0,3].

- [schmidt-reference-renyi-half-counterexample](schmidt-reference-renyi-half-counterexample/formalization/) — The archived formal proof covers normalized complex-state counterexamples, actual Pauli expectations, local unitary permutation, exact entropy decrease, and openness of the counterexample family.
- [bell-chain-sharp-parity](bell-chain-sharp-parity/formalization/) — The archived release records complete coverage of the sharp parity coefficient and equality conditions for the specified cyclic Bell swapping chains.
- [johnson-triangle-chain-parity](johnson-triangle-chain-parity/formalization/) — The archived release records exact parity classification of closed triangle chains and optimal representation rank; scope is limited to the archived formal theorems.

- [triangular-windmill-proper-hat](triangular-windmill-proper-hat/formalization/) — Exact 5/6/7 classification for all positive numbers of triangular windmill blades, including unrestricted strategy upper bounds, explicit separation tables, decoding, monotonicity, and the final classification. The archived release reports a full local kernel and independent scope audit; a new public build has not been run.

- [two-agent-sd-ef1-market](two-agent-sd-ef1-market/formalization/) — Two-agent subjective stochastic-dominance EF1 with a common market EF1, adjacent pairing, greedy exchanges, shortest complementary paths, padding removal, market choice, complexity bounds, and the six-good example. The archived release records full manuscript coverage and a successful prior CI replay.

- [pauli-mub-phase-rigidity](pauli-mub-phase-rigidity/formalization/) — Odd-qubit Pauli MUB obstruction for odd n ≥ 5, fourth-root phase rigidity for equimodular even-qubit candidates, and a two-qubit witness. The even-qubit nonexistence question is not resolved. The archived release records complete coverage for this scope.
- [three-qubit-pauli-mub-obstruction](three-qubit-pauli-mub-obstruction/formalization/) — Three-qubit tensor-Pauli orbit obstruction, with arbitrary normalized complex states, full orbit partitions and per-label unit-modulus phases. The archived release records complete coverage for this scope.

These packages preserve the original Lean sources and dependencies; migration is not a fresh compilation or independent review.

## Auxiliary Lean source

- [Detailed-balance frequency reduction](detailed-balance-frequency-reduction/formalization/): two auxiliary real-analysis lemmas, not a formalization of the entire paper.
- [Chern–Simons four-cycle](chern-simons-four-cycle/formalization/): algebraic consequences of the partition-count formulas, not a formalization of the complete replica-matrix argument.

Each Lean directory contains a toolchain and a pinned mathlib dependency. Run `lake build` from the corresponding directory. No new execution or Lean compilation result is asserted by this page.

以上程序为有限精确算术校验；完整证明包与辅助引理包的数学范围见各项说明。迁移不代表在本仓库重新编译或重新完成公理核验。
