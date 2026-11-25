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

- [lexicographic-swap-rounding-counterexample](lexicographic-swap-rounding-counterexample/formalization/) — The fixed lexicographic swap-rounding counterexample for all positive real parameters, including the uniform-matroid model, actual rounding definitions, and the parametric failure of one-negative association. The archived release reports complete coverage of the original manuscript.

- [glauber-annealing-activity-counterexample](glauber-annealing-activity-counterexample/formalization/) — Ten-state counterexample to Glauber annealing activity, including finite regular Gibbs/Glauber models, bias identities and first-step bounds, total-variation estimates, three-temperature limits for regular bridge graphs, distinct-energy perturbations, and finite-parameter stability. The archived release records full coverage for this manuscript.

- [glauber-activity-counterexample](glauber-activity-counterexample/formalization/) — The eight-state cubic Glauber activity counterexample, explicit graph families for each degree in the stated range, energies, cooling schedule, parameter interval, limits and first-step bound. The archived release records full coverage of the original mathematical manuscript. Its dependency has been relocated to a public commit containing the identical prerequisite source; a new compilation is still required.

- [lueders-coarse-graining-tv](lueders-coarse-graining-tv/formalization/) — The coarse-graining counterexample for Lüders measurement order total-variation scores on complex qubit density matrices, including square-root uniqueness, exact normalized probabilities, complex trace semantics, and the exact optima 1/30 and 9/250. The archived release records full coverage of this mathematical manuscript.

- [two-box-pure-search-conjecture21](two-box-pure-search-conjecture21/formalization/) — The optimal deterministic and mixed two-location search strategies of Conjecture 21, with geometric first-success expectation, conditional continuation cost, first-deviation bounds, almost-optimal prefixes, finite witnesses and asymptotics. The archived release records full mathematical manuscript coverage.

- [variety-jump-subcubic-potential](variety-jump-subcubic-potential/formalization/) — Two-vacancy variety jump games on finite simple undirected subcubic graphs, including strict potential descent, labelled moves, reachable equilibrium, linear improvement-path bounds and a nonvacuity witness. The archived release records complete coverage of this stated subcubic result; general graphs are outside its scope.

- [reciprocal-reward-counterexamples](reciprocal-reward-counterexamples/formalization/) — Reciprocal-reward search counterexamples and sharp graph guarantee, including four-vertex examples, continuous reward perturbations, graph and hypergraph families, fractional matchings, odd-cycle supports and the sharp 5/6 bound. The archived release records complete coverage of the original mathematical manuscript.

- [independent-e-merging-beyond-martingales](independent-e-merging-beyond-martingales/formalization/) — Independent e-value merging beyond reordered martingales, including randomized input models, all-domain and three-point optimal capital, exact product capital for finite adaptive interleavings, and smooth strictly monotone separation. The archived release records complete coverage of the original mathematical manuscript.

- [finite-n-prediction-scheduling](finite-n-prediction-scheduling/formalization/) — The exact optimal frontier for finite-job prediction scheduling, including the scheduling model, dimension and snapshot arguments, explicit frontier construction, guarantees, examples and rational complexity bounds. The archived release records full coverage of the frozen mathematical manuscript.

- [efx-binary-partition-nullity](efx-binary-partition-nullity/formalization/) — Worst approximate EFX factor for two-class partition-matroid nullity chores, including the rank/nullity cost model, matching and allocation criteria, exact factor and capacity algorithms, finite and asymptotic probability bounds, and the 18-agent 53-chore instance. The archived release records complete coverage of the original mathematical manuscript.

These packages preserve the original Lean sources and dependencies; migration is not a fresh compilation or independent review.

## Auxiliary Lean source

- [Detailed-balance frequency reduction](detailed-balance-frequency-reduction/formalization/): two auxiliary real-analysis lemmas, not a formalization of the entire paper.
- [Chern–Simons four-cycle](chern-simons-four-cycle/formalization/): algebraic consequences of the partition-count formulas, not a formalization of the complete replica-matrix argument.

Each Lean directory contains a toolchain and a pinned mathlib dependency. Run `lake build` from the corresponding directory. No new execution or Lean compilation result is asserted by this page.

以上程序为有限精确算术校验；完整证明包与辅助引理包的数学范围见各项说明。迁移不代表在本仓库重新编译或重新完成公理核验。
