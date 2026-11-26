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

## Calculations accompanying the research manuscripts

- [Two-class clearing-system reward threshold](two-class-clearing-reward-threshold/REPRODUCTION.md)
- [Repeated majority cross-validation](repeated-majority-cross-validation/REPRODUCTION.md)
- [First capacity transition of the Cauchy channel](cauchy-channel-capacity-transition/REPRODUCTION.md)

## Supplementary calculations and data

These files document finite exact-arithmetic checks and numerical examples. The imbalance calculation and the classifier reference implementation use NumPy. Run companion scripts from their code directory.

| Manuscript | Programs | Recorded outputs |
|---|---|---|
| [annealed frequency reduction](annealed-frequency-reduction/paper.en.md) | — | [exact_certificate.txt](annealed-frequency-reduction/results/exact_certificate.txt) |
| [cactus replica rationality](cactus-replica-rationality/paper.zh.md) | — | [exact_certificate.txt](cactus-replica-rationality/results/exact_certificate.txt) |
| [chern simons four cycle](chern-simons-four-cycle/paper.zh.md) | — | [exact_certificate.txt](chern-simons-four-cycle/results/exact_certificate.txt) |
| [chern simons order three](chern-simons-order-three/paper.zh.md) | — | [exact_certificate.txt](chern-simons-order-three/results/exact_certificate.txt) |
| [chordal bipartite edge open packing](chordal-bipartite-edge-open-packing/paper.zh.md) | — | [exact_certificate.txt](chordal-bipartite-edge-open-packing/results/exact_certificate.txt) |
| [chordal unique vertex cover preassignment](chordal-unique-vertex-cover-preassignment/paper.zh.md) | — | [exact_certificate.txt](chordal-unique-vertex-cover-preassignment/results/exact_certificate.txt), [interval_certificate.txt](chordal-unique-vertex-cover-preassignment/results/interval_certificate.txt) |
| [class domination coloring cluster deletion](class-domination-coloring-cluster-deletion/paper.zh.md) | — | [exact_certificate.txt](class-domination-coloring-cluster-deletion/results/exact_certificate.txt) |
| [class domination coloring treewidth](class-domination-coloring-treewidth/paper.zh.md) | — | [compressed_certificate.txt](class-domination-coloring-treewidth/results/compressed_certificate.txt), [exact_certificate.txt](class-domination-coloring-treewidth/results/exact_certificate.txt) |
| [classifier accuracy augmented gof](classifier-accuracy-augmented-gof/paper.en.md) | — | [exact_certificate.txt](classifier-accuracy-augmented-gof/results/exact_certificate.txt) |
| [complete bipartite tar rigidity](complete-bipartite-tar-rigidity/paper.zh.md) | — | [exact_certificate.txt](complete-bipartite-tar-rigidity/results/exact_certificate.txt) |
| [composite sequential test induction](composite-sequential-test-induction/paper.en.md) | — | [exact_certificate.txt](composite-sequential-test-induction/results/exact_certificate.txt) |
| [detailed balance frequency reduction](detailed-balance-frequency-reduction/paper.en.md) | — | [exact_certificate.txt](detailed-balance-frequency-reduction/results/exact_certificate.txt) |
| [directed cycle two season witness](directed-cycle-two-season-witness/paper.en.md) | — | [exact_certificate.txt](directed-cycle-two-season-witness/results/exact_certificate.txt) |
| [nonhermitian skin imbalance](nonhermitian-skin-imbalance/paper.zh.md) | [certificate.py](nonhermitian-skin-imbalance/code/certificate.py), [verify_imbalance.py](nonhermitian-skin-imbalance/code/verify_imbalance.py) | [exact_certificate.txt](nonhermitian-skin-imbalance/results/exact_certificate.txt), [numerical_check.csv](nonhermitian-skin-imbalance/results/numerical_check.csv) |
| [online conformal parabolic evaluation](online-conformal-parabolic-evaluation/paper.zh.md) | [check_truncation.py](online-conformal-parabolic-evaluation/code/check_truncation.py) | [exact_certificate.txt](online-conformal-parabolic-evaluation/results/exact_certificate.txt) |
| [original alphabet hard classifier](original-alphabet-hard-classifier/paper.en.md) | [check_protocol.py](original-alphabet-hard-classifier/code/check_protocol.py), [hard_classifier.py](original-alphabet-hard-classifier/code/hard_classifier.py), [verify_exact.py](original-alphabet-hard-classifier/code/verify_exact.py) | [exact_certificate.json](original-alphabet-hard-classifier/results/exact_certificate.json), [protocol_examples.txt](original-alphabet-hard-classifier/results/protocol_examples.txt) |
| [perfect tensor renyi multientropy](perfect-tensor-renyi-multientropy/paper.zh.md) | — | [exact_certificate.txt](perfect-tensor-renyi-multientropy/results/exact_certificate.txt) |
| [risk transfer and finite horizon](risk-transfer-and-finite-horizon/paper.en.md) | [independent_identity_check.py](risk-transfer-and-finite-horizon/code/independent_identity_check.py) | — |

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

- [Rényi product order phase](renyi-product-order-phase/formalization/) — 139 source files, including the asymptotic regime development; final matching-source full verification is not asserted.

- [Detailed-balance frequency reduction](detailed-balance-frequency-reduction/formalization/): two auxiliary real-analysis lemmas, not a formalization of the entire paper.
- [Chern–Simons four-cycle](chern-simons-four-cycle/formalization/): algebraic consequences of the partition-count formulas, not a formalization of the complete replica-matrix argument.

Each Lean directory contains a toolchain and a pinned mathlib dependency. Run `lake build` from the corresponding directory. No new execution or Lean compilation result is asserted by this page.

以上程序为有限精确算术校验；完整证明包与辅助引理包的数学范围见各项说明。迁移不代表在本仓库重新编译或重新完成公理核验。

## Partial formal proof packages

- [Three-task pinwheel scheduling](finite-pinwheel-three-task/formalization/README.md) — Rank formula for positive integers excluding multiples of 3 and the three deadline inequalities for the (2, 3, c) family.

## Supplementary material by project

Each row links to a manuscript and the available programs, recorded results, or figures. Program dependencies vary by project. Archived numerical outputs and finite calculations illustrate or check specific claims. The manuscripts state the scope of the proofs.

| Research project | Programs | Data and results | Figures |
|---|---|---|---|
| [adaptive erasure feedback law](adaptive-erasure-feedback-law/paper.en.md) | — | [results](adaptive-erasure-feedback-law/results/) | — |
| [adaptive exponential kernel confidence](adaptive-exponential-kernel-confidence/paper.en.md) | — | [results](adaptive-exponential-kernel-confidence/results/) | — |
| [all clique saturation](all-clique-saturation/paper.en.md) | [code](all-clique-saturation/code/) | [results](all-clique-saturation/results/) | — |
| [approximate dp epower exponent](approximate-dp-epower-exponent/paper.en.md) | — | [results](approximate-dp-epower-exponent/results/) | — |
| [approximate ldp blackwell structure](approximate-ldp-blackwell-structure/paper.en.md) | [code](approximate-ldp-blackwell-structure/code/) | [results](approximate-ldp-blackwell-structure/results/) | — |
| [bell chain sharp parity](bell-chain-sharp-parity/paper.en.md) | [code](bell-chain-sharp-parity/code/) | [results](bell-chain-sharp-parity/results/) | — |
| [binary markov gray dispersion](binary-markov-gray-dispersion/paper.en.md) | [code](binary-markov-gray-dispersion/code/) | [results](binary-markov-gray-dispersion/results/) | — |
| [binary renyi order monotonicity](binary-renyi-order-monotonicity/paper.en.md) | [code](binary-renyi-order-monotonicity/code/) | [results](binary-renyi-order-monotonicity/results/) | [figures](binary-renyi-order-monotonicity/figures/) |
| [binomial sign margin minimax](binomial-sign-margin-minimax/paper.zh.md) | [code](binomial-sign-margin-minimax/code/) | [results](binomial-sign-margin-minimax/results/) | — |
| [boundary resetting global optimality](boundary-resetting-global-optimality/paper.en.md) | [code](boundary-resetting-global-optimality/code/) | [results](boundary-resetting-global-optimality/results/) | [figures](boundary-resetting-global-optimality/figures/) |
| [bounded hop independent set approximation](bounded-hop-independent-set-approximation/paper.en.md) | [code](bounded-hop-independent-set-approximation/code/) | [results](bounded-hop-independent-set-approximation/results/) | — |
| [cartesian algebraic squares](cartesian-algebraic-squares/paper.en.md) | [code](cartesian-algebraic-squares/code/) | [results](cartesian-algebraic-squares/results/) | [figures](cartesian-algebraic-squares/figures/) |
| [certified symmetric corridor](certified-symmetric-corridor/paper.zh.md) | [code](certified-symmetric-corridor/code/) | [results](certified-symmetric-corridor/results/) | — |
| [chained index uniform direct product](chained-index-uniform-direct-product/paper.en.md) | [code](chained-index-uniform-direct-product/code/) | [results](chained-index-uniform-direct-product/results/) | — |
| [chordal bipartite edge open packing](chordal-bipartite-edge-open-packing/paper.zh.md) | [code](chordal-bipartite-edge-open-packing/code/) | — | — |
| [chordal unique vertex cover preassignment](chordal-unique-vertex-cover-preassignment/paper.zh.md) | [code](chordal-unique-vertex-cover-preassignment/code/) | — | — |
| [ci score quadratic rigidity](ci-score-quadratic-rigidity/paper.zh.md) | [code](ci-score-quadratic-rigidity/code/) | [results](ci-score-quadratic-rigidity/results/) | — |
| [class domination coloring cluster deletion](class-domination-coloring-cluster-deletion/paper.zh.md) | [code](class-domination-coloring-cluster-deletion/code/) | — | — |
| [class domination coloring treewidth](class-domination-coloring-treewidth/paper.zh.md) | [code](class-domination-coloring-treewidth/code/) | — | — |
| [classifier accuracy augmented gof](classifier-accuracy-augmented-gof/paper.en.md) | [code](classifier-accuracy-augmented-gof/code/) | — | — |
| [clique dually conformal induced extension](clique-dually-conformal-induced-extension/paper.en.md) | [code](clique-dually-conformal-induced-extension/code/) | [results](clique-dually-conformal-induced-extension/results/) | — |
| [collapsing bandit global indexability](collapsing-bandit-global-indexability/paper.en.md) | [code](collapsing-bandit-global-indexability/code/) | [results](collapsing-bandit-global-indexability/results/) | — |
| [common law lqr affine boundary](common-law-lqr-affine-boundary/paper.en.md) | [code](common-law-lqr-affine-boundary/code/) | [results](common-law-lqr-affine-boundary/results/) | — |
| [commuting effect threshold](commuting-effect-threshold/paper.en.md) | [code](commuting-effect-threshold/code/) | [results](commuting-effect-threshold/results/) | — |
| [composite sequential test induction](composite-sequential-test-induction/paper.en.md) | [code](composite-sequential-test-induction/code/) | — | — |
| [conditional information power boundaries](conditional-information-power-boundaries/paper.en.md) | — | [results](conditional-information-power-boundaries/results/) | — |
| [conjugate resetting global optimality](conjugate-resetting-global-optimality/paper.en.md) | [code](conjugate-resetting-global-optimality/code/) | [results](conjugate-resetting-global-optimality/results/) | [figures](conjugate-resetting-global-optimality/figures/) |
| [continuous high risk prefactor](continuous-high-risk-prefactor/paper.en.md) | [code](continuous-high-risk-prefactor/code/) | [results](continuous-high-risk-prefactor/results/) | — |
| [convex scenario compression transfer](convex-scenario-compression-transfer/paper.en.md) | [code](convex-scenario-compression-transfer/code/) | [results](convex-scenario-compression-transfer/results/) | — |
| [cvar one max exact optimality](cvar-one-max-exact-optimality/paper.en.md) | [code](cvar-one-max-exact-optimality/code/) | [results](cvar-one-max-exact-optimality/results/) | [figures](cvar-one-max-exact-optimality/figures/) |
| [dca sharp finite horizon](dca-sharp-finite-horizon/paper.en.md) | [code](dca-sharp-finite-horizon/code/) | [results](dca-sharp-finite-horizon/results/) | — |
| [delayed newton cooling optimal preparation](delayed-newton-cooling-optimal-preparation/paper.en.md) | [code](delayed-newton-cooling-optimal-preparation/code/) | [results](delayed-newton-cooling-optimal-preparation/results/) | [figures](delayed-newton-cooling-optimal-preparation/figures/) |
| [deletion intersection counterexample](deletion-intersection-counterexample/paper.en.md) | [code](deletion-intersection-counterexample/code/) | [results](deletion-intersection-counterexample/results/) | — |
| [directed cycle two season witness](directed-cycle-two-season-witness/paper.en.md) | [code](directed-cycle-two-season-witness/code/) | — | — |
| [domination packing split rectangle](domination-packing-split-rectangle/paper.zh.md) | [code](domination-packing-split-rectangle/code/) | [results](domination-packing-split-rectangle/results/) | — |
| [efx binary partition nullity](efx-binary-partition-nullity/paper.en.md) | [code](efx-binary-partition-nullity/code/) | [results](efx-binary-partition-nullity/results/) | — |
| [efx four agents eight goods](efx-four-agents-eight-goods/paper.zh.md) | [reproduction](efx-four-agents-eight-goods/reproduction/) | — | — |
| [efx matroid rank chores](efx-matroid-rank-chores/paper.en.md) | [code](efx-matroid-rank-chores/code/) | — | — |
| [euclidean median all p sharp](euclidean-median-all-p-sharp/paper.en.md) | [code](euclidean-median-all-p-sharp/code/) | [results](euclidean-median-all-p-sharp/results/) | — |
| [even cycle replica branch separation](even-cycle-replica-branch-separation/paper.zh.md) | [code](even-cycle-replica-branch-separation/code/) | [results](even-cycle-replica-branch-separation/results/) | — |
| [exact convex profile capital](exact-convex-profile-capital/paper.en.md) | [code](exact-convex-profile-capital/code/) | [results](exact-convex-profile-capital/results/) | — |
| [exchangeable arithmetic merging improvement](exchangeable-arithmetic-merging-improvement/paper.zh.md) | [code](exchangeable-arithmetic-merging-improvement/code/) | [results](exchangeable-arithmetic-merging-improvement/results/) | — |
| [faster edge open packing](faster-edge-open-packing/paper.zh.md) | [code](faster-edge-open-packing/code/) | [results](faster-edge-open-packing/results/) | — |
| [faster isometric paths chain](faster-isometric-paths-chain/paper.zh.md) | [code](faster-isometric-paths-chain/code/) | [results](faster-isometric-paths-chain/results/) | — |
| [faster isometric paths cographs](faster-isometric-paths-cographs/paper.zh.md) | [code](faster-isometric-paths-cographs/code/) | [results](faster-isometric-paths-cographs/results/) | — |
| [finite n prediction scheduling](finite-n-prediction-scheduling/paper.en.md) | [code](finite-n-prediction-scheduling/code/) | [results](finite-n-prediction-scheduling/results/) | — |
| [first passage kernel inverse realization](first-passage-kernel-inverse-realization/paper.zh.md) | [code](first-passage-kernel-inverse-realization/code/) | [results](first-passage-kernel-inverse-realization/results/) | — |
| [fixed agent cumulative envy](fixed-agent-cumulative-envy/paper.en.md) | [code](fixed-agent-cumulative-envy/code/) | [results](fixed-agent-cumulative-envy/results/) | [figures](fixed-agent-cumulative-envy/figures/) |
| [fixed angle mbqc unitary design](fixed-angle-mbqc-unitary-design/paper.zh.md) | [code](fixed-angle-mbqc-unitary-design/code/) | [results](fixed-angle-mbqc-unitary-design/results/) | — |
| [floquet many frequency optima](floquet-many-frequency-optima/paper.en.md) | [code](floquet-many-frequency-optima/code/) | [results](floquet-many-frequency-optima/results/) | — |
| [four qubit fredkin exact entangling power](four-qubit-fredkin-exact-entangling-power/paper.en.md) | [code](four-qubit-fredkin-exact-entangling-power/code/) | — | — |
| [fractional advice paw transfer](fractional-advice-paw-transfer/paper.en.md) | [code](fractional-advice-paw-transfer/code/) | — | — |
| [full cover unidomination chordal](full-cover-unidomination-chordal/paper.zh.md) | [code](full-cover-unidomination-chordal/code/) | [results](full-cover-unidomination-chordal/results/) | — |
| [full domain capital tensorization](full-domain-capital-tensorization/paper.en.md) | [code](full-domain-capital-tensorization/code/) | [results](full-domain-capital-tensorization/results/) | — |
| [gaffke bivariate interval inversion](gaffke-bivariate-interval-inversion/paper.en.md) | [code](gaffke-bivariate-interval-inversion/code/) | [results](gaffke-bivariate-interval-inversion/results/) | — |
| [gaffke delta sharp bound](gaffke-delta-sharp-bound/paper.en.md) | [code](gaffke-delta-sharp-bound/code/) | [results](gaffke-delta-sharp-bound/results/) | — |
| [gaffke ordered iid interval](gaffke-ordered-iid-interval/paper.en.md) | [code](gaffke-ordered-iid-interval/code/) | [results](gaffke-ordered-iid-interval/results/) | — |
| [gamma calibration unknown dispersion](gamma-calibration-unknown-dispersion/paper.zh.md) | [code](gamma-calibration-unknown-dispersion/code/) | [results](gamma-calibration-unknown-dispersion/results/) | — |
| [gaussian frequency gradient variance](gaussian-frequency-gradient-variance/paper.zh.md) | [code](gaussian-frequency-gradient-variance/code/) | [results](gaussian-frequency-gradient-variance/results/) | — |
| [gaussian product privacy floor](gaussian-product-privacy-floor/paper.en.md) | [code](gaussian-product-privacy-floor/code/) | [results](gaussian-product-privacy-floor/results/) | [figures](gaussian-product-privacy-floor/figures/) |
| [gaussian product sharp zcdp](gaussian-product-sharp-zcdp/paper.en.md) | [code](gaussian-product-sharp-zcdp/code/) | [results](gaussian-product-sharp-zcdp/results/) | — |
| [gaussian simes high level trivariate](gaussian-simes-high-level-trivariate/paper.en.md) | [code](gaussian-simes-high-level-trivariate/code/) | [results](gaussian-simes-high-level-trivariate/results/) | — |
| [ghz pauli readout depth](ghz-pauli-readout-depth/paper.zh.md) | [code](ghz-pauli-readout-depth/code/) | [results](ghz-pauli-readout-depth/results/) | — |
| [glauber activity counterexample](glauber-activity-counterexample/paper.en.md) | [code](glauber-activity-counterexample/code/) | [results](glauber-activity-counterexample/results/) | — |
| [glauber annealing activity counterexample](glauber-annealing-activity-counterexample/paper.en.md) | [code](glauber-annealing-activity-counterexample/code/) | [results](glauber-annealing-activity-counterexample/results/) | [figures](glauber-annealing-activity-counterexample/figures/) |
| [graph burning long path forests](graph-burning-long-path-forests/paper.en.md) | [code](graph-burning-long-path-forests/code/) | [results](graph-burning-long-path-forests/results/) | — |
| [high temperature gibbs weak noise](high-temperature-gibbs-weak-noise/paper.zh.md) | [code](high-temperature-gibbs-weak-noise/code/) | — | — |
| [independent e merging beyond martingales](independent-e-merging-beyond-martingales/paper.en.md) | [code](independent-e-merging-beyond-martingales/code/) | [results](independent-e-merging-beyond-martingales/results/) | — |
| [independent winners bias extremizers](independent-winners-bias-extremizers/paper.en.md) | [code](independent-winners-bias-extremizers/code/) | [results](independent-winners-bias-extremizers/results/) | — |
| [isometric path cover split](isometric-path-cover-split/paper.zh.md) | [code](isometric-path-cover-split/code/) | [results](isometric-path-cover-split/results/) | — |
| [johnson triangle chain parity](johnson-triangle-chain-parity/paper.zh.md) | [code](johnson-triangle-chain-parity/code/) | [results](johnson-triangle-chain-parity/results/) | — |
| [krr exact zcdp](krr-exact-zcdp/paper.en.md) | [code](krr-exact-zcdp/code/) | [results](krr-exact-zcdp/results/) | [figures](krr-exact-zcdp/figures/) |
| [leave one out mean strong duality](leave-one-out-mean-strong-duality/paper.en.md) | [code](leave-one-out-mean-strong-duality/code/) | [results](leave-one-out-mean-strong-duality/results/) | — |
| [lexicographic swap rounding counterexample](lexicographic-swap-rounding-counterexample/paper.en.md) | [code](lexicographic-swap-rounding-counterexample/code/) | [results](lexicographic-swap-rounding-counterexample/results/) | — |
| [loo continuous dual closure gap](loo-continuous-dual-closure-gap/paper.en.md) | [code](loo-continuous-dual-closure-gap/code/) | [results](loo-continuous-dual-closure-gap/results/) | — |
| [loo countable measurable duality](loo-countable-measurable-duality/paper.en.md) | [code](loo-countable-measurable-duality/code/) | [results](loo-countable-measurable-duality/results/) | — |
| [lueders coarse graining tv](lueders-coarse-graining-tv/paper.en.md) | [code](lueders-coarse-graining-tv/code/) | [results](lueders-coarse-graining-tv/results/) | — |
| [maximum total transitivity split](maximum-total-transitivity-split/paper.zh.md) | [code](maximum-total-transitivity-split/code/) | [results](maximum-total-transitivity-split/results/) | — |
| [mbqc nine measurement five design](mbqc-nine-measurement-five-design/paper.zh.md) | [code](mbqc-nine-measurement-five-design/code/) | [results](mbqc-nine-measurement-five-design/results/) | — |
| [minimizer rigidity stability](minimizer-rigidity-stability/paper.en.md) | [code](minimizer-rigidity-stability/code/) | [results](minimizer-rigidity-stability/results/) | — |
| [minimum fill in chordal bipartite](minimum-fill-in-chordal-bipartite/paper.zh.md) | [code](minimum-fill-in-chordal-bipartite/code/) | [results](minimum-fill-in-chordal-bipartite/results/) | — |
| [minimum fill in perfect elimination bipartite](minimum-fill-in-perfect-elimination-bipartite/paper.zh.md) | [code](minimum-fill-in-perfect-elimination-bipartite/code/) | [results](minimum-fill-in-perfect-elimination-bipartite/results/) | — |
| [minimum maximal acyclic matching chordal](minimum-maximal-acyclic-matching-chordal/paper.zh.md) | [code](minimum-maximal-acyclic-matching-chordal/code/) | [results](minimum-maximal-acyclic-matching-chordal/results/) | — |
| [minimum maximal acyclic matching chordal bipartite](minimum-maximal-acyclic-matching-chordal-bipartite/paper.zh.md) | [code](minimum-maximal-acyclic-matching-chordal-bipartite/code/) | [results](minimum-maximal-acyclic-matching-chordal-bipartite/results/) | — |
| [modular magnetization magic](modular-magnetization-magic/paper.en.md) | [code](modular-magnetization-magic/code/) | [results](modular-magnetization-magic/results/) | [figures](modular-magnetization-magic/figures/) |
| [moment conformal misspecification](moment-conformal-misspecification/paper.zh.md) | [code](moment-conformal-misspecification/code/) | [results](moment-conformal-misspecification/results/) | — |
| [near linear edge open packing](near-linear-edge-open-packing/paper.zh.md) | [code](near-linear-edge-open-packing/code/) | [results](near-linear-edge-open-packing/results/) | — |
| [noiseless codes few binary measurements](noiseless-codes-few-binary-measurements/paper.en.md) | [code](noiseless-codes-few-binary-measurements/code/) | [results](noiseless-codes-few-binary-measurements/results/) | — |
| [noisy qubit design parity](noisy-qubit-design-parity/paper.zh.md) | [code](noisy-qubit-design-parity/code/) | [results](noisy-qubit-design-parity/results/) | — |
| [noisy smooth online sharp limit](noisy-smooth-online-sharp-limit/paper.en.md) | [code](noisy-smooth-online-sharp-limit/code/) | [results](noisy-smooth-online-sharp-limit/results/) | — |
| [non overlapping unidomination threshold](non-overlapping-unidomination-threshold/paper.zh.md) | [code](non-overlapping-unidomination-threshold/code/) | [results](non-overlapping-unidomination-threshold/results/) | — |
| [nonadaptive bernoulli moment characterization](nonadaptive-bernoulli-moment-characterization/paper.en.md) | [code](nonadaptive-bernoulli-moment-characterization/code/) | [results](nonadaptive-bernoulli-moment-characterization/results/) | — |
| [noncommuting pell aliases](noncommuting-pell-aliases/paper.en.md) | [code](noncommuting-pell-aliases/code/) | [results](noncommuting-pell-aliases/results/) | — |
| [odd cycle exact complexity](odd-cycle-exact-complexity/paper.en.md) | — | [results](odd-cycle-exact-complexity/results/) | — |
| [odd qudit replica phase reflection](odd-qudit-replica-phase-reflection/paper.zh.md) | [code](odd-qudit-replica-phase-reflection/code/) | [results](odd-qudit-replica-phase-reflection/results/) | — |
| [online conformal critical known oracle](online-conformal-critical-known-oracle/paper.zh.md) | [code](online-conformal-critical-known-oracle/code/) | [results](online-conformal-critical-known-oracle/results/) | — |
| [online conformal critical variational limit](online-conformal-critical-variational-limit/paper.zh.md) | — | [results](online-conformal-critical-variational-limit/results/) | — |
| [online conformal fixed corridor](online-conformal-fixed-corridor/paper.zh.md) | [code](online-conformal-fixed-corridor/code/) | [results](online-conformal-fixed-corridor/results/) | — |
| [online conformal minimax dp](online-conformal-minimax-dp/paper.zh.md) | [code](online-conformal-minimax-dp/code/) | [results](online-conformal-minimax-dp/results/) | — |
| [online conformal sharp constant](online-conformal-sharp-constant/paper.en.md) | [code](online-conformal-sharp-constant/code/) | [results](online-conformal-sharp-constant/results/) | — |
| [online conformal wide corridor asymptotic](online-conformal-wide-corridor-asymptotic/paper.zh.md) | [code](online-conformal-wide-corridor-asymptotic/code/) | [results](online-conformal-wide-corridor-asymptotic/results/) | — |
| [optimal resetting asymmetric](optimal-resetting-asymmetric/paper.en.md) | [code](optimal-resetting-asymmetric/code/) | — | — |
| [optimal resetting logconcave](optimal-resetting-logconcave/paper.en.md) | [code](optimal-resetting-logconcave/code/) | [results](optimal-resetting-logconcave/results/) | — |
| [order seven sharp erasure](order-seven-sharp-erasure/paper.en.md) | [code](order-seven-sharp-erasure/code/) | [results](order-seven-sharp-erasure/results/) | — |
| [order six sharp erasure](order-six-sharp-erasure/paper.en.md) | [code](order-six-sharp-erasure/code/) | [results](order-six-sharp-erasure/results/) | — |
| [ordinal causal benefit sharp bounds](ordinal-causal-benefit-sharp-bounds/paper.en.md) | [code](ordinal-causal-benefit-sharp-bounds/code/) | [results](ordinal-causal-benefit-sharp-bounds/results/) | — |
| [ordinal only frontier](ordinal-only-frontier/paper.en.md) | — | [results](ordinal-only-frontier/results/) | — |
| [ordinary ef1 three agent counterexample](ordinary-ef1-three-agent-counterexample/paper.en.md) | [code](ordinary-ef1-three-agent-counterexample/code/) | [results](ordinary-ef1-three-agent-counterexample/results/) | — |
| [pairwise independent online crs sharp](pairwise-independent-online-crs-sharp/paper.en.md) | [code](pairwise-independent-online-crs-sharp/code/) | [results](pairwise-independent-online-crs-sharp/results/) | — |
| [pauli lindblad pec parity](pauli-lindblad-pec-parity/paper.en.md) | [code](pauli-lindblad-pec-parity/code/) | [results](pauli-lindblad-pec-parity/results/) | [figures](pauli-lindblad-pec-parity/figures/) |
| [pauli mub phase rigidity](pauli-mub-phase-rigidity/paper.en.md) | [code](pauli-mub-phase-rigidity/code/) | [results](pauli-mub-phase-rigidity/results/) | — |
| [position matching cut width one](position-matching-cut-width-one/paper.zh.md) | [code](position-matching-cut-width-one/code/) | — | — |
| [posthoc closed stake admissibility](posthoc-closed-stake-admissibility/paper.en.md) | [code](posthoc-closed-stake-admissibility/code/) | [results](posthoc-closed-stake-admissibility/results/) | — |
| [posthoc finite stake admissibility](posthoc-finite-stake-admissibility/paper.en.md) | [code](posthoc-finite-stake-admissibility/code/) | [results](posthoc-finite-stake-admissibility/results/) | — |
| [posthoc randomized admissibility](posthoc-randomized-admissibility/paper.en.md) | [code](posthoc-randomized-admissibility/code/) | [results](posthoc-randomized-admissibility/results/) | — |
| [ppt squared toroidal mixing](ppt-squared-toroidal-mixing/paper.en.md) | [code](ppt-squared-toroidal-mixing/code/) | [results](ppt-squared-toroidal-mixing/results/) | — |
| [precise mergers without symmetry](precise-mergers-without-symmetry/paper.en.md) | [code](precise-mergers-without-symmetry/code/) | [results](precise-mergers-without-symmetry/results/) | — |
| [processing oracle two phase](processing-oracle-two-phase/paper.en.md) | [code](processing-oracle-two-phase/code/) | [results](processing-oracle-two-phase/results/) | — |
| [prophet secretary stockout](prophet-secretary-stockout/paper.en.md) | [code](prophet-secretary-stockout/code/) | [results](prophet-secretary-stockout/results/) | [figures](prophet-secretary-stockout/figures/) |
| [pspin curie weiss spinodal](pspin-curie-weiss-spinodal/paper.zh.md) | [code](pspin-curie-weiss-spinodal/code/) | [results](pspin-curie-weiss-spinodal/results/) | — |
| [pure entanglement three measurement exclusion](pure-entanglement-three-measurement-exclusion/paper.en.md) | [code](pure-entanglement-three-measurement-exclusion/code/) | [results](pure-entanglement-three-measurement-exclusion/results/) | — |
| [quantum battery separable initialization](quantum-battery-separable-initialization/paper.en.md) | [code](quantum-battery-separable-initialization/code/) | [results](quantum-battery-separable-initialization/results/) | [figures](quantum-battery-separable-initialization/figures/) |
| [quantum renyi45 erasure bound](quantum-renyi45-erasure-bound/paper.en.md) | [code](quantum-renyi45-erasure-bound/code/) | [results](quantum-renyi45-erasure-bound/results/) | — |
| [quantum transport polygon exactness](quantum-transport-polygon-exactness/paper.en.md) | [code](quantum-transport-polygon-exactness/code/) | [results](quantum-transport-polygon-exactness/results/) | — |
| [qubit cooling arbitrary machine](qubit-cooling-arbitrary-machine/paper.zh.md) | [code](qubit-cooling-arbitrary-machine/code/) | [results](qubit-cooling-arbitrary-machine/results/) | — |
| [qubit cooling bernstein certificate](qubit-cooling-bernstein-certificate/paper.en.md) | [code](qubit-cooling-bernstein-certificate/code/) | [results](qubit-cooling-bernstein-certificate/results/) | — |
| [qubit cooling bounded degeneracy](qubit-cooling-bounded-degeneracy/paper.en.md) | [code](qubit-cooling-bounded-degeneracy/code/) | [results](qubit-cooling-bounded-degeneracy/results/) | — |
| [ququart swapping fixed resource range](ququart-swapping-fixed-resource-range/paper.zh.md) | [code](ququart-swapping-fixed-resource-range/code/) | [results](ququart-swapping-fixed-resource-range/results/) | — |
| [qutrit ecqc sharp bound](qutrit-ecqc-sharp-bound/paper.en.md) | [code](qutrit-ecqc-sharp-bound/code/) | [results](qutrit-ecqc-sharp-bound/results/) | [figures](qutrit-ecqc-sharp-bound/figures/) |
| [random occupancy threshold](random-occupancy-threshold/paper.en.md) | — | [results](random-occupancy-threshold/results/) | — |
| [randomized weighted two job robustness](randomized-weighted-two-job-robustness/paper.en.md) | [code](randomized-weighted-two-job-robustness/code/) | [results](randomized-weighted-two-job-robustness/results/) | — |
| [rank two permutation sharp constant](rank-two-permutation-sharp-constant/paper.en.md) | [code](rank-two-permutation-sharp-constant/code/) | [results](rank-two-permutation-sharp-constant/results/) | — |
| [rank two scale classification](rank-two-scale-classification/paper.en.md) | — | [results](rank-two-scale-classification/results/) | — |
| [rb all tensor contractivity](rb-all-tensor-contractivity/paper.zh.md) | [code](rb-all-tensor-contractivity/code/) | [results](rb-all-tensor-contractivity/results/) | — |
| [reciprocal reward counterexamples](reciprocal-reward-counterexamples/paper.en.md) | [code](reciprocal-reward-counterexamples/code/) | [results](reciprocal-reward-counterexamples/results/) | [figures](reciprocal-reward-counterexamples/figures/) |
| [record constrained prophet gap](record-constrained-prophet-gap/paper.en.md) | [code](record-constrained-prophet-gap/code/) | [results](record-constrained-prophet-gap/results/) | — |
| [reflecting diffusion frequency classification](reflecting-diffusion-frequency-classification/paper.zh.md) | [code](reflecting-diffusion-frequency-classification/code/) | [results](reflecting-diffusion-frequency-classification/results/) | — |
| [renyi product order phase](renyi-product-order-phase/paper.en.md) | [code](renyi-product-order-phase/code/) | [results](renyi-product-order-phase/results/) | — |
| [renyi three channel frontier](renyi-three-channel-frontier/paper.en.md) | — | [results](renyi-three-channel-frontier/results/) | — |
| [replicable conformal pilot ranks](replicable-conformal-pilot-ranks/paper.en.md) | [code](replicable-conformal-pilot-ranks/code/) | [results](replicable-conformal-pilot-ranks/results/) | — |
| [reversible environment weak response](reversible-environment-weak-response/paper.en.md) | — | [results](reversible-environment-weak-response/results/) | — |
| [risk sensitive ski rental](risk-sensitive-ski-rental/paper.en.md) | [code](risk-sensitive-ski-rental/code/) | [results](risk-sensitive-ski-rental/results/) | [figures](risk-sensitive-ski-rental/figures/) |
| [risk transfer and finite horizon](risk-transfer-and-finite-horizon/paper.en.md) | [code](risk-transfer-and-finite-horizon/code/) | [results](risk-transfer-and-finite-horizon/results/) | [figures](risk-transfer-and-finite-horizon/figures/) |
| [robust crt fixed channel exact design](robust-crt-fixed-channel-exact-design/paper.en.md) | [code](robust-crt-fixed-channel-exact-design/code/) | [results](robust-crt-fixed-channel-exact-design/results/) | — |
| [robust secretary acceptance thinning](robust-secretary-acceptance-thinning/paper.zh.md) | [code](robust-secretary-acceptance-thinning/code/) | [results](robust-secretary-acceptance-thinning/results/) | — |
| [schmidt reference renyi half counterexample](schmidt-reference-renyi-half-counterexample/paper.en.md) | [code](schmidt-reference-renyi-half-counterexample/code/) | [results](schmidt-reference-renyi-half-counterexample/results/) | — |
| [selection audit information](selection-audit-information/paper.en.md) | [code](selection-audit-information/code/) | [results](selection-audit-information/results/) | [figures](selection-audit-information/figures/) |
| [self deleting path derandomization](self-deleting-path-derandomization/paper.en.md) | [code](self-deleting-path-derandomization/code/) | [results](self-deleting-path-derandomization/results/) | — |
| [sequential ldp autocovariance minimax](sequential-ldp-autocovariance-minimax/paper.en.md) | [code](sequential-ldp-autocovariance-minimax/code/) | [results](sequential-ldp-autocovariance-minimax/results/) | — |
| [sequential target recalculation](sequential-target-recalculation/paper.en.md) | [code](sequential-target-recalculation/code/) | [results](sequential-target-recalculation/results/) | — |
| [sharp minimal failures](sharp-minimal-failures/paper.en.md) | [code](sharp-minimal-failures/code/) | [results](sharp-minimal-failures/results/) | — |
| [sharp nonmonotone correlation gap](sharp-nonmonotone-correlation-gap/paper.en.md) | [code](sharp-nonmonotone-correlation-gap/code/) | [results](sharp-nonmonotone-correlation-gap/results/) | [figures](sharp-nonmonotone-correlation-gap/figures/) |
| [sharp two step activity](sharp-two-step-activity/paper.en.md) | [code](sharp-two-step-activity/code/) | [results](sharp-two-step-activity/results/) | — |
| [sibuya quantum reset rate](sibuya-quantum-reset-rate/paper.en.md) | [code](sibuya-quantum-reset-rate/code/) | [results](sibuya-quantum-reset-rate/results/) | [figures](sibuya-quantum-reset-rate/figures/) |
| [simes band curvature](simes-band-curvature/paper.zh.md) | [code](simes-band-curvature/code/) | [results](simes-band-curvature/results/) | — |
| [single qubit fixed angle all orders](single-qubit-fixed-angle-all-orders/paper.zh.md) | [code](single-qubit-fixed-angle-all-orders/code/) | [results](single-qubit-fixed-angle-all-orders/results/) | — |
| [single qubit marginal first passage ep3](single-qubit-marginal-first-passage-ep3/paper.zh.md) | [code](single-qubit-marginal-first-passage-ep3/code/) | [results](single-qubit-marginal-first-passage-ep3/results/) | — |
| [six cycle even replica factorization](six-cycle-even-replica-factorization/paper.zh.md) | [code](six-cycle-even-replica-factorization/code/) | [results](six-cycle-even-replica-factorization/results/) | — |
| [six cycle odd index entropy rises](six-cycle-odd-index-entropy-rises/paper.zh.md) | — | [results](six-cycle-odd-index-entropy-rises/results/) | — |
| [six cycle replica arithmetic](six-cycle-replica-arithmetic/paper.zh.md) | [code](six-cycle-replica-arithmetic/code/) | [results](six-cycle-replica-arithmetic/results/) | — |
| [slack null induction complexity](slack-null-induction-complexity/paper.en.md) | — | [results](slack-null-induction-complexity/results/) | — |
| [speed limited harmonic equilibration](speed-limited-harmonic-equilibration/paper.en.md) | [code](speed-limited-harmonic-equilibration/code/) | [results](speed-limited-harmonic-equilibration/results/) | — |
| [stroboscopic three state entropy range](stroboscopic-three-state-entropy-range/paper.en.md) | [code](stroboscopic-three-state-entropy-range/code/) | [results](stroboscopic-three-state-entropy-range/results/) | [figures](stroboscopic-three-state-entropy-range/figures/) |
| [subsampled max power lqrt](subsampled-max-power-lqrt/paper.zh.md) | [code](subsampled-max-power-lqrt/code/) | [results](subsampled-max-power-lqrt/results/) | — |
| [three qubit depolarizing majorization](three-qubit-depolarizing-majorization/paper.en.md) | [code](three-qubit-depolarizing-majorization/code/) | [results](three-qubit-depolarizing-majorization/results/) | — |
| [three state mlsi certificate](three-state-mlsi-certificate/paper.zh.md) | — | [results](three-state-mlsi-certificate/results/) | — |
| [topology constrained markov reconstruction](topology-constrained-markov-reconstruction/paper.en.md) | [code](topology-constrained-markov-reconstruction/code/) | [results](topology-constrained-markov-reconstruction/results/) | [figures](topology-constrained-markov-reconstruction/figures/) |
| [triangular windmill proper hat](triangular-windmill-proper-hat/paper.en.md) | [code](triangular-windmill-proper-hat/code/) | [results](triangular-windmill-proper-hat/results/) | — |
| [tripartite nearest spectral](tripartite-nearest-spectral/paper.zh.md) | [code](tripartite-nearest-spectral/code/) | [results](tripartite-nearest-spectral/results/) | — |
| [tripartite spectral rank](tripartite-spectral-rank/paper.zh.md) | — | [results](tripartite-spectral-rank/results/) | — |
| [two agent sd ef1 market](two-agent-sd-ef1-market/paper.en.md) | [code](two-agent-sd-ef1-market/code/) | [results](two-agent-sd-ef1-market/results/) | [figures](two-agent-sd-ef1-market/figures/) |
| [two box pure search conjecture21](two-box-pure-search-conjecture21/paper.en.md) | [code](two-box-pure-search-conjecture21/code/) | [results](two-box-pure-search-conjecture21/results/) | [figures](two-box-pure-search-conjecture21/figures/) |
| [two visits duplicate midpoint](two-visits-duplicate-midpoint/paper.zh.md) | [code](two-visits-duplicate-midpoint/code/) | [results](two-visits-duplicate-midpoint/results/) | — |
| [unidomination thresholds planar bipartite](unidomination-thresholds-planar-bipartite/paper.zh.md) | [code](unidomination-thresholds-planar-bipartite/code/) | [results](unidomination-thresholds-planar-bipartite/results/) | — |
| [unknown scale onebit mean minimax](unknown-scale-onebit-mean-minimax/paper.en.md) | [code](unknown-scale-onebit-mean-minimax/code/) | — | — |
| [upper clique transversal helly circular arc](upper-clique-transversal-helly-circular-arc/paper.zh.md) | [code](upper-clique-transversal-helly-circular-arc/code/) | [results](upper-clique-transversal-helly-circular-arc/results/) | — |
| [upper clique transversal incidence equality](upper-clique-transversal-incidence-equality/paper.zh.md) | [code](upper-clique-transversal-incidence-equality/code/) | [results](upper-clique-transversal-incidence-equality/results/) | — |
| [upper clique transversal strongly chordal](upper-clique-transversal-strongly-chordal/paper.zh.md) | [code](upper-clique-transversal-strongly-chordal/code/) | [results](upper-clique-transversal-strongly-chordal/results/) | — |
| [variety jump subcubic potential](variety-jump-subcubic-potential/paper.en.md) | [code](variety-jump-subcubic-potential/code/) | [results](variety-jump-subcubic-potential/results/) | [figures](variety-jump-subcubic-potential/figures/) |
| [wasserstein barycenter threshold two](wasserstein-barycenter-threshold-two/paper.en.md) | [code](wasserstein-barycenter-threshold-two/code/) | [results](wasserstein-barycenter-threshold-two/results/) | — |
| [weighted conformal explicit sample threshold](weighted-conformal-explicit-sample-threshold/paper.en.md) | [code](weighted-conformal-explicit-sample-threshold/code/) | [results](weighted-conformal-explicit-sample-threshold/results/) | — |
| [weighted conformal fixed cap curvature](weighted-conformal-fixed-cap-curvature/paper.en.md) | [code](weighted-conformal-fixed-cap-curvature/code/) | [results](weighted-conformal-fixed-cap-curvature/results/) | — |
| [weighted conformal global null linear fdr](weighted-conformal-global-null-linear-fdr/paper.en.md) | [code](weighted-conformal-global-null-linear-fdr/code/) | [results](weighted-conformal-global-null-linear-fdr/results/) | — |
| [weighted conformal poisson transfer](weighted-conformal-poisson-transfer/paper.en.md) | [code](weighted-conformal-poisson-transfer/code/) | [results](weighted-conformal-poisson-transfer/results/) | — |
| [weighted conformal spectral rkhs](weighted-conformal-spectral-rkhs/paper.zh.md) | [code](weighted-conformal-spectral-rkhs/code/) | [results](weighted-conformal-spectral-rkhs/results/) | — |

## Additional supplements

Each row links to a manuscript and the available programs, recorded results, or figures. Program dependencies vary by project. Archived numerical outputs and finite calculations illustrate or check specific claims. The manuscripts state the scope of the proofs.

| Research project | Programs | Data and results | Figures |
|---|---|---|---|
| [anisotropic qubit fidelity composition](anisotropic-qubit-fidelity-composition/paper.en.md) | [code](anisotropic-qubit-fidelity-composition/code/) | — | — |
| [announced fixed horizon](announced-fixed-horizon/paper.en.md) | [code](announced-fixed-horizon/code/) | — | — |
| [approximate dp epower exponent](approximate-dp-epower-exponent/paper.en.md) | — | [results](approximate-dp-epower-exponent/results/) | — |
| [bandit view table sharp conversion](bandit-view-table-sharp-conversion/paper.en.md) | [code](bandit-view-table-sharp-conversion/code/) | — | — |
| [binary reliability exponents](binary-reliability-exponents/paper.en.md) | [code](binary-reliability-exponents/code/) | [results](binary-reliability-exponents/results/) | — |
| [bottleneck spectral neighbor](bottleneck-spectral-neighbor/paper.en.md) | [code](bottleneck-spectral-neighbor/code/) | [results](bottleneck-spectral-neighbor/results/) | — |
| [bounded edge deleters](bounded-edge-deleters/paper.en.md) | [code](bounded-edge-deleters/code/) | — | — |
| [complete fixed count classification](complete-fixed-count-classification/paper.en.md) | [code](complete-fixed-count-classification/code/) | [results](complete-fixed-count-classification/results/) | — |
| [complete multipartite potentials and weighted cycles](complete-multipartite-potentials-and-weighted-cycles/paper.zh.md) | [code](complete-multipartite-potentials-and-weighted-cycles/code/) | — | — |
| [composition multiple orders](composition-multiple-orders/paper.en.md) | — | [results](composition-multiple-orders/results/) | — |
| [continuous star partition optimality](continuous-star-partition-optimality/paper.en.md) | [code](continuous-star-partition-optimality/code/) | — | — |
| [counted feedback additive frontier](counted-feedback-additive-frontier/paper.en.md) | — | [results](counted-feedback-additive-frontier/results/) | — |
| [critical sparse audit stopping limits](critical-sparse-audit-stopping-limits/paper.en.md) | [code](critical-sparse-audit-stopping-limits/code/) | — | — |
| [dominant jordan order limit](dominant-jordan-order-limit/paper.en.md) | [code](dominant-jordan-order-limit/code/) | [results](dominant-jordan-order-limit/results/) | — |
| [exact coverage and risk transitions](exact-coverage-and-risk-transitions/paper.en.md) | [code](exact-coverage-and-risk-transitions/code/) | [results](exact-coverage-and-risk-transitions/results/) | — |
| [exact finite power plateau](exact-finite-power-plateau/paper.en.md) | [code](exact-finite-power-plateau/code/) | [results](exact-finite-power-plateau/results/) | — |
| [exact principal entropy endpoint](exact-principal-entropy-endpoint/paper.en.md) | [code](exact-principal-entropy-endpoint/code/) | [results](exact-principal-entropy-endpoint/results/) | — |
| [finite cardinality profile](finite-cardinality-profile/paper.en.md) | [code](finite-cardinality-profile/code/) | [results](finite-cardinality-profile/results/) | — |
| [finite common preparation](finite-common-preparation/paper.en.md) | — | [results](finite-common-preparation/results/) | — |
| [finite reversible certificates and spectral criteria](finite-reversible-certificates-and-spectral-criteria/paper.zh.md) | [code](finite-reversible-certificates-and-spectral-criteria/code/) | — | — |
| [finite worst models transient learning](finite-worst-models-transient-learning/paper.en.md) | [code](finite-worst-models-transient-learning/code/) | [results](finite-worst-models-transient-learning/results/) | — |
| [first count tomography](first-count-tomography/paper.en.md) | [code](first-count-tomography/code/) | [results](first-count-tomography/results/) | — |
| [fixed population sharp deficit](fixed-population-sharp-deficit/paper.en.md) | — | [results](fixed-population-sharp-deficit/results/) | — |
| [fixed statistic sensitivity envelope](fixed-statistic-sensitivity-envelope/paper.en.md) | [code](fixed-statistic-sensitivity-envelope/code/) | [results](fixed-statistic-sensitivity-envelope/results/) | — |
| [four qubit pauli mub obstruction and robustness](four-qubit-pauli-mub-obstruction-and-robustness/paper.en.md) | [code](four-qubit-pauli-mub-obstruction-and-robustness/code/) | — | — |
| [general qutrit cooling](general-qutrit-cooling/paper.zh.md) | [code](general-qutrit-cooling/code/) | — | — |
| [gray critical endpoint](gray-critical-endpoint/paper.en.md) | — | [results](gray-critical-endpoint/results/) | — |
| [growing round blocklength](growing-round-blocklength/paper.en.md) | — | [results](growing-round-blocklength/results/) | — |
| [haar schmidt magic](haar-schmidt-magic/paper.zh.md) | [code](haar-schmidt-magic/code/) | — | — |
| [heavy ball planar cycle domain](heavy-ball-planar-cycle-domain/paper.zh.md) | [code](heavy-ball-planar-cycle-domain/code/) | [results](heavy-ball-planar-cycle-domain/results/) | — |
| [high order parity gap](high-order-parity-gap/paper.en.md) | — | [results](high-order-parity-gap/results/) | — |
| [integer order projection law](integer-order-projection-law/paper.en.md) | — | [results](integer-order-projection-law/results/) | — |
| [kcbs rank one all dimensions](kcbs-rank-one-all-dimensions/paper.en.md) | [code](kcbs-rank-one-all-dimensions/code/) | — | — |
| [linear threshold path forest burning](linear-threshold-path-forest-burning/paper.en.md) | [code](linear-threshold-path-forest-burning/code/) | — | — |
| [logconcave band smooth minimax](logconcave-band-smooth-minimax/paper.en.md) | [code](logconcave-band-smooth-minimax/code/) | — | — |
| [low order failure and minimal permutation dimension](low-order-failure-and-minimal-permutation-dimension/paper.zh.md) | [code](low-order-failure-and-minimal-permutation-dimension/code/) | — | — |
| [markov missing mass minimax](markov-missing-mass-minimax/paper.zh.md) | [code](markov-missing-mass-minimax/code/) | — | — |
| [mixed null square root boundary](mixed-null-square-root-boundary/paper.en.md) | — | [results](mixed-null-square-root-boundary/results/) | — |
| [moment bayes minimax geometry](moment-bayes-minimax-geometry/paper.zh.md) | [code](moment-bayes-minimax-geometry/code/) | — | — |
| [narrow corridor expansion](narrow-corridor-expansion/paper.en.md) | [code](narrow-corridor-expansion/code/) | [results](narrow-corridor-expansion/results/) | — |
| [nongreedy exchangeable rank optimality](nongreedy-exchangeable-rank-optimality/paper.en.md) | — | [results](nongreedy-exchangeable-rank-optimality/results/) | — |
| [one fast many slow threshold](one-fast-many-slow-threshold/paper.en.md) | [code](one-fast-many-slow-threshold/code/) | [results](one-fast-many-slow-threshold/results/) | — |
| [online unbounded knapsack minimax](online-unbounded-knapsack-minimax/paper.en.md) | [code](online-unbounded-knapsack-minimax/code/) | — | — |
| [optimal charging entanglement](optimal-charging-entanglement/paper.en.md) | [code](optimal-charging-entanglement/code/) | [results](optimal-charging-entanglement/results/) | — |
| [ordinal query secretary upper bound](ordinal-query-secretary-upper-bound/paper.en.md) | [code](ordinal-query-secretary-upper-bound/code/) | [results](ordinal-query-secretary-upper-bound/results/) | — |
| [path drift switch budget](path-drift-switch-budget/paper.en.md) | [code](path-drift-switch-budget/code/) | [results](path-drift-switch-budget/results/) | — |
| [polynomial exact phase sweep](polynomial-exact-phase-sweep/paper.en.md) | [code](polynomial-exact-phase-sweep/code/) | [results](polynomial-exact-phase-sweep/results/) | — |
| [post conjugation anisotropic parity](post-conjugation-anisotropic-parity/paper.en.md) | — | [results](post-conjugation-anisotropic-parity/results/) | — |
| [private slot coalescence](private-slot-coalescence/paper.en.md) | [code](private-slot-coalescence/code/) | — | — |
| [proper interval linear weighted](proper-interval-linear-weighted/paper.en.md) | [code](proper-interval-linear-weighted/code/) | [results](proper-interval-linear-weighted/results/) | — |
| [quantum channel product bound universality](quantum-channel-product-bound-universality/paper.en.md) | [code](quantum-channel-product-bound-universality/code/) | — | — |
| [quantum chi2 tensorization regions](quantum-chi2-tensorization-regions/paper.en.md) | [code](quantum-chi2-tensorization-regions/code/) | — | — |
| [quantum code n23 m3 b2](quantum-code-n23-m3-b2/paper.zh.md) | — | [data](quantum-code-n23-m3-b2/data/) | — |
| [quaternary sum entropy](quaternary-sum-entropy/paper.en.md) | [code](quaternary-sum-entropy/code/) | — | — |
| [queue routing logarithmic regret](queue-routing-logarithmic-regret/paper.en.md) | [code](queue-routing-logarithmic-regret/code/) | — | — |
| [scalar lq global learning bifurcations](scalar-lq-global-learning-bifurcations/paper.en.md) | [code](scalar-lq-global-learning-bifurcations/code/) | [results](scalar-lq-global-learning-bifurcations/results/) | — |
| [serial service frontier](serial-service-frontier/paper.en.md) | — | [results](serial-service-frontier/results/) | — |
| [sharp amplification and pointwise monotonicity](sharp-amplification-and-pointwise-monotonicity/paper.en.md) | [code](sharp-amplification-and-pointwise-monotonicity/code/) | — | — |
| [sharp conditional ranks under tilts](sharp-conditional-ranks-under-tilts/paper.en.md) | [code](sharp-conditional-ranks-under-tilts/code/) | — | — |
| [sharp peripheral jordan order](sharp-peripheral-jordan-order/paper.en.md) | [code](sharp-peripheral-jordan-order/code/) | [results](sharp-peripheral-jordan-order/results/) | — |
| [sharp poisson binomial density ratio](sharp-poisson-binomial-density-ratio/paper.en.md) | — | — | [figures](sharp-poisson-binomial-density-ratio/figures/) |
| [sharp qubit separable gap](sharp-qubit-separable-gap/paper.en.md) | [code](sharp-qubit-separable-gap/code/) | [results](sharp-qubit-separable-gap/results/) | — |
| [shuffle rr hamming extremality](shuffle-rr-hamming-extremality/paper.en.md) | [code](shuffle-rr-hamming-extremality/code/) | — | — |
| [sibuya reset error certificates](sibuya-reset-error-certificates/paper.en.md) | [code](sibuya-reset-error-certificates/code/) | [results](sibuya-reset-error-certificates/results/) | — |
| [single frequency inverse identification](single-frequency-inverse-identification/paper.en.md) | — | [results](single-frequency-inverse-identification/results/) | — |
| [smooth gibbs oracle minimax](smooth-gibbs-oracle-minimax/paper.zh.md) | [code](smooth-gibbs-oracle-minimax/code/) | [results](smooth-gibbs-oracle-minimax/results/) | — |
| [stabilizer logical pauli visibility](stabilizer-logical-pauli-visibility/paper.en.md) | [code](stabilizer-logical-pauli-visibility/code/) | [results](stabilizer-logical-pauli-visibility/results/) | — |
| [strong product algebraic squares](strong-product-algebraic-squares/paper.en.md) | [code](strong-product-algebraic-squares/code/) | — | — |
| [temporal ef1 nine chores threshold](temporal-ef1-nine-chores-threshold/paper.en.md) | [code](temporal-ef1-nine-chores-threshold/code/) | [results](temporal-ef1-nine-chores-threshold/results/) | — |
| [thermodynamic boundary charge](thermodynamic-boundary-charge/paper.en.md) | — | [results](thermodynamic-boundary-charge/results/) | — |
| [three coordinate extension frontier](three-coordinate-extension-frontier/paper.en.md) | [code](three-coordinate-extension-frontier/code/) | [results](three-coordinate-extension-frontier/results/) | — |
| [transitive composition lift complexity](transitive-composition-lift-complexity/paper.en.md) | [code](transitive-composition-lift-complexity/code/) | [results](transitive-composition-lift-complexity/results/) | — |
| [triangular windmill proper hat](triangular-windmill-proper-hat/paper.en.md) | — | — | [figures](triangular-windmill-proper-hat/figures/) |
| [two quadrant complexity](two-quadrant-complexity/paper.en.md) | — | [results](two-quadrant-complexity/results/) | — |
| [two three agent complexity](two-three-agent-complexity/paper.en.md) | [code](two-three-agent-complexity/code/) | [results](two-three-agent-complexity/results/) | — |
| [two weight qutrit sharp cooling](two-weight-qutrit-sharp-cooling/paper.en.md) | [code](two-weight-qutrit-sharp-cooling/code/) | — | — |
| [uniform bin minimum rate](uniform-bin-minimum-rate/paper.en.md) | [code](uniform-bin-minimum-rate/code/) | [results](uniform-bin-minimum-rate/results/) | — |
| [uniform endpoint singular correlations](uniform-endpoint-singular-correlations/paper.en.md) | [code](uniform-endpoint-singular-correlations/code/) | [results](uniform-endpoint-singular-correlations/results/) | — |
| [universal fixed degree positivity](universal-fixed-degree-positivity/paper.en.md) | — | [results](universal-fixed-degree-positivity/results/) | — |
| [unknown budget robust pricing](unknown-budget-robust-pricing/paper.zh.md) | [code](unknown-budget-robust-pricing/code/) | [results](unknown-budget-robust-pricing/results/) | — |
| [unknown gap adaptation boundary](unknown-gap-adaptation-boundary/paper.en.md) | [code](unknown-gap-adaptation-boundary/code/) | — | — |
| [unknown reference hard sign classifier](unknown-reference-hard-sign-classifier/paper.en.md) | [code](unknown-reference-hard-sign-classifier/code/) | [results](unknown-reference-hard-sign-classifier/results/) | — |
| [unrestricted correlation boundary](unrestricted-correlation-boundary/paper.en.md) | — | [results](unrestricted-correlation-boundary/results/) | — |
| [upper clique transversal simultaneous xp](upper-clique-transversal-simultaneous-xp/paper.en.md) | [code](upper-clique-transversal-simultaneous-xp/code/) | — | — |
| [vanishing epsilon two scales](vanishing-epsilon-two-scales/paper.en.md) | — | [results](vanishing-epsilon-two-scales/results/) | — |
| [weighted bivariate tail](weighted-bivariate-tail/paper.en.md) | [code](weighted-bivariate-tail/code/) | [results](weighted-bivariate-tail/results/) | — |
| [weighted interval inapproximability](weighted-interval-inapproximability/paper.en.md) | — | [results](weighted-interval-inapproximability/results/) | — |
| [weighted maxcut feedback](weighted-maxcut-feedback/paper.zh.md) | [code](weighted-maxcut-feedback/code/) | [results](weighted-maxcut-feedback/results/) | — |
| [weighted regression selection frontier](weighted-regression-selection-frontier/paper.en.md) | [code](weighted-regression-selection-frontier/code/) | [results](weighted-regression-selection-frontier/results/) | — |

## Additional mathematical data

| Research project | Data files |
|---|---|
| [bounded edge deleters](bounded-edge-deleters/paper.en.md) | [exact_checks.json](bounded-edge-deleters/results/exact_checks.json) |
| [clique dually conformal induced extension](clique-dually-conformal-induced-extension/paper.en.md) | [hostile_boundary_checks.json](clique-dually-conformal-induced-extension/results/hostile_boundary_checks.json) |
| [dca sharp finite horizon](dca-sharp-finite-horizon/paper.en.md) | [dca_pepit_N2.json](dca-sharp-finite-horizon/results/entry_rerun/dca_pepit_N2.json), [N2_eta0.8_rho-0.6_pepit.json](dca-sharp-finite-horizon/results/pep_initial/N2_eta0.8_rho-0.6_pepit.json) |
| [delayed newton cooling optimal preparation](delayed-newton-cooling-optimal-preparation/paper.en.md) | [optima.json](delayed-newton-cooling-optimal-preparation/results/optima.json) |
| [efx four agents eight goods](efx-four-agents-eight-goods/paper.zh.md) | [common_dominant_example.json](efx-four-agents-eight-goods/reproduction/common_dominant_example.json), [pair_shortcut_obstruction.json](efx-four-agents-eight-goods/reproduction/pair_shortcut_obstruction.json), [partition_counts.json](efx-four-agents-eight-goods/reproduction/partition_counts.json), [quartet_sharpness.json](efx-four-agents-eight-goods/reproduction/quartet_sharpness.json) |
| [exact coverage and risk transitions](exact-coverage-and-risk-transitions/paper.en.md) | [comparisons.json](exact-coverage-and-risk-transitions/results/comparisons.json) |
| [exact finite power plateau](exact-finite-power-plateau/paper.en.md) | [trajectory_certificate.json](exact-finite-power-plateau/results/trajectory_certificate.json) |
| [finite n prediction scheduling](finite-n-prediction-scheduling/paper.en.md) | [snapshot_certificate.py](finite-n-prediction-scheduling/code/snapshot_certificate.py), [unit_profiles.py](finite-n-prediction-scheduling/code/unit_profiles.py) |
| [four qubit fredkin exact entangling power](four-qubit-fredkin-exact-entangling-power/paper.en.md) | [independent_statevector_check.json](four-qubit-fredkin-exact-entangling-power/results/independent_statevector_check.json) |
| [fractional advice paw transfer](fractional-advice-paw-transfer/paper.en.md) | [implementation_equivalence.json](fractional-advice-paw-transfer/results/implementation_equivalence.json) |
| [hard budget covariance fourth moment](hard-budget-covariance-fourth-moment/paper.en.md) | [hard_budget_covariance.py](hard-budget-covariance-fourth-moment/code/hard_budget_covariance.py), [rank_one_scalar_check.py](hard-budget-covariance-fourth-moment/code/rank_one_scalar_check.py) |
| [linear threshold path forest burning](linear-threshold-path-forest-burning/paper.en.md) | [exact_certificate.json](linear-threshold-path-forest-burning/results/exact_certificate.json) |
| [noisy smooth online sharp limit](noisy-smooth-online-sharp-limit/paper.en.md) | [exact_certificate.json](noisy-smooth-online-sharp-limit/results/exact_certificate.json) |
| [optimal resetting logconcave](optimal-resetting-logconcave/paper.en.md) | [discrete_optimization.py](optimal-resetting-logconcave/code/discrete_optimization.py), [independent_review.py](optimal-resetting-logconcave/code/independent_review.py) |
| [pairwise independent online crs sharp](pairwise-independent-online-crs-sharp/paper.en.md) | [upper_checks.json](pairwise-independent-online-crs-sharp/results/upper_checks.json) |
| [private slot coalescence](private-slot-coalescence/paper.en.md) | [exact_checks.json](private-slot-coalescence/results/exact_checks.json) |
| [processing oracle two phase](processing-oracle-two-phase/paper.en.md) | [physical_subsolution_check.json](processing-oracle-two-phase/results/physical_subsolution_check.json) |
| [quantum renyi45 erasure bound](quantum-renyi45-erasure-bound/paper.en.md) | [numerical_checks.json](quantum-renyi45-erasure-bound/results/numerical_checks.json) |
| [qutrit ecqc sharp bound](qutrit-ecqc-sharp-bound/paper.en.md) | [noise_certificate.json](qutrit-ecqc-sharp-bound/results/noise_certificate.json) |
| [renyi product order phase](renyi-product-order-phase/paper.en.md) | [endpoint_diagnostics.json](renyi-product-order-phase/results/endpoint_diagnostics.json), [independent_probe.json](renyi-product-order-phase/results/independent_probe.json) |
| [three state mlsi certificate](three-state-mlsi-certificate/paper.zh.md) | [certify.py](three-state-mlsi-certificate/code/certify.py), [check_uniqueness.py](three-state-mlsi-certificate/code/check_uniqueness.py) |
| [transitive composition lift complexity](transitive-composition-lift-complexity/paper.en.md) | [compressed_counter_k3_slp.json](transitive-composition-lift-complexity/code/instances/compressed_counter_k3_slp.json), [forced_prefix_nonempty.json](transitive-composition-lift-complexity/code/instances/forced_prefix_nonempty.json) |
| [weighted bernoulli entropy curvature](weighted-bernoulli-entropy-curvature/paper.en.md) | [center_hessian.py](weighted-bernoulli-entropy-curvature/code/center_hessian.py), [collision_diagnostics.py](weighted-bernoulli-entropy-curvature/code/collision_diagnostics.py), [entropy_search.py](weighted-bernoulli-entropy-curvature/code/entropy_search.py), [exact_curvature_certificate.py](weighted-bernoulli-entropy-curvature/code/exact_curvature_certificate.py) |
| [weighted regression selection frontier](weighted-regression-selection-frontier/paper.en.md) | [check_gap_reduction.py](weighted-regression-selection-frontier/code/hardness/check_gap_reduction.py) |

## Lean source from the archive

The table gives the local check status of each supplement. Compiled entries cover the listed Lean declarations. The manuscripts state the scope of the mathematical results.

| Research project | Source | Local verification |
|---|---|---|
| [adaptive erasure feedback law](adaptive-erasure-feedback-law/paper.en.md) | [Modules](adaptive-erasure-feedback-law/formalization/README.md) | Compiled and checked |
| [adaptive exponential kernel confidence](adaptive-exponential-kernel-confidence/paper.en.md) | [Modules](adaptive-exponential-kernel-confidence/formalization/README.md) | Compiled and checked |
| [all clique saturation](all-clique-saturation/paper.en.md) | [Modules](all-clique-saturation/formalization/README.md) | Compiled and checked |
| [aoj general service indexability](aoj-general-service-indexability/paper.en.md) | [Modules](aoj-general-service-indexability/formalization/README.md) | Compiled and checked |
| [bandit view table sharp conversion](bandit-view-table-sharp-conversion/paper.en.md) | [Modules](bandit-view-table-sharp-conversion/formalization/README.md) | Compiled and checked |
| [binary markov gray dispersion](binary-markov-gray-dispersion/paper.en.md) | [Modules](binary-markov-gray-dispersion/formalization/README.md) | Source snapshot |
| [binary renyi order monotonicity](binary-renyi-order-monotonicity/paper.en.md) | [Modules](binary-renyi-order-monotonicity/formalization/README.md) | Source snapshot |
| [binomial sign margin minimax](binomial-sign-margin-minimax/paper.zh.md) | [Modules](binomial-sign-margin-minimax/formalization/README.md) | Compiled and checked |
| [boundary resetting global optimality](boundary-resetting-global-optimality/paper.en.md) | [Modules](boundary-resetting-global-optimality/formalization/README.md) | Source snapshot |
| [chained index uniform direct product](chained-index-uniform-direct-product/paper.en.md) | [Modules](chained-index-uniform-direct-product/formalization/README.md) | Compiled and checked |
| [ci score quadratic rigidity](ci-score-quadratic-rigidity/paper.zh.md) | [Modules](ci-score-quadratic-rigidity/formalization/README.md) | Source snapshot |
| [collapsing bandit global indexability](collapsing-bandit-global-indexability/paper.en.md) | [Modules](collapsing-bandit-global-indexability/formalization/README.md) | Compiled and checked |
| [common law lqr affine boundary](common-law-lqr-affine-boundary/paper.en.md) | [Modules](common-law-lqr-affine-boundary/formalization/README.md) | Compiled and checked |
| [commuting effect threshold](commuting-effect-threshold/paper.en.md) | [Modules](commuting-effect-threshold/formalization/README.md) | Source snapshot |
| [composite sequential test induction](composite-sequential-test-induction/paper.en.md) | [Modules](composite-sequential-test-induction/formalization/README.md) | Compiled and checked |
| [conditional information power boundaries](conditional-information-power-boundaries/paper.en.md) | [Modules](conditional-information-power-boundaries/formalization/README.md) | Compiled and checked |
| [conjugate resetting global optimality](conjugate-resetting-global-optimality/paper.en.md) | [Modules](conjugate-resetting-global-optimality/formalization/README.md) | Compiled and checked |
| [cvar one max exact optimality](cvar-one-max-exact-optimality/paper.en.md) | [Modules](cvar-one-max-exact-optimality/formalization/README.md) | Source snapshot |
| [dca sharp finite horizon](dca-sharp-finite-horizon/paper.en.md) | [Modules](dca-sharp-finite-horizon/formalization/README.md) | Source snapshot |
| [delayed newton cooling optimal preparation](delayed-newton-cooling-optimal-preparation/paper.en.md) | [Modules](delayed-newton-cooling-optimal-preparation/formalization/README.md) | Source snapshot |
| [directed cycle two season witness](directed-cycle-two-season-witness/paper.en.md) | [Modules](directed-cycle-two-season-witness/formalization/README.md) | Compiled and checked |
| [efx four agents eight goods](efx-four-agents-eight-goods/paper.zh.md) | [Modules](efx-four-agents-eight-goods/formalization/README.md) | Source snapshot |
| [efx matroid rank chores](efx-matroid-rank-chores/paper.en.md) | [Modules](efx-matroid-rank-chores/formalization/README.md) | Source snapshot |
| [euclidean median all p sharp](euclidean-median-all-p-sharp/paper.en.md) | [Modules](euclidean-median-all-p-sharp/formalization/README.md) | Source snapshot |
| [even cycle replica branch separation](even-cycle-replica-branch-separation/paper.zh.md) | [Modules](even-cycle-replica-branch-separation/formalization/README.md) | Compiled and checked |
| [exact convex profile capital](exact-convex-profile-capital/paper.en.md) | [Modules](exact-convex-profile-capital/formalization/README.md) | Compiled and checked |
| [exchangeable arithmetic merging improvement](exchangeable-arithmetic-merging-improvement/paper.zh.md) | [Modules](exchangeable-arithmetic-merging-improvement/formalization/README.md) | Compiled and checked |
| [fixed angle mbqc unitary design](fixed-angle-mbqc-unitary-design/paper.zh.md) | [Modules](fixed-angle-mbqc-unitary-design/formalization/README.md) | Source snapshot |
| [full domain capital tensorization](full-domain-capital-tensorization/paper.en.md) | [Modules](full-domain-capital-tensorization/formalization/README.md) | Compiled and checked |
| [gaffke delta sharp bound](gaffke-delta-sharp-bound/paper.en.md) | [Modules](gaffke-delta-sharp-bound/formalization/README.md) | Source snapshot |
| [gaffke ordered iid interval](gaffke-ordered-iid-interval/paper.en.md) | [Modules](gaffke-ordered-iid-interval/formalization/README.md) | Source snapshot |
| [gamma calibration unknown dispersion](gamma-calibration-unknown-dispersion/paper.zh.md) | [Modules](gamma-calibration-unknown-dispersion/formalization/README.md) | Source snapshot |
| [gaussian frequency gradient variance](gaussian-frequency-gradient-variance/paper.zh.md) | [Modules](gaussian-frequency-gradient-variance/formalization/README.md) | Compiled and checked |
| [gaussian product sharp zcdp](gaussian-product-sharp-zcdp/paper.en.md) | [Modules](gaussian-product-sharp-zcdp/formalization/README.md) | Compiled and checked |
| [general qutrit cooling](general-qutrit-cooling/paper.zh.md) | [Modules](general-qutrit-cooling/formalization/README.md) | Compiled and checked |
| [graph burning long path forests](graph-burning-long-path-forests/paper.en.md) | [Modules](graph-burning-long-path-forests/formalization/README.md) | Compiled and checked |
| [haar schmidt magic](haar-schmidt-magic/paper.zh.md) | [Modules](haar-schmidt-magic/formalization/README.md) | Compiled and checked |
| [hard budget covariance fourth moment](hard-budget-covariance-fourth-moment/paper.en.md) | [Modules](hard-budget-covariance-fourth-moment/formalization/README.md) | Compiled and checked |
| [independent winners bias extremizers](independent-winners-bias-extremizers/paper.en.md) | [Modules](independent-winners-bias-extremizers/formalization/README.md) | Source snapshot |
| [krr exact zcdp](krr-exact-zcdp/paper.en.md) | [Modules](krr-exact-zcdp/formalization/README.md) | Source snapshot |
| [loo continuous dual closure gap](loo-continuous-dual-closure-gap/paper.en.md) | [Modules](loo-continuous-dual-closure-gap/formalization/README.md) | Compiled and checked |
| [minimizer rigidity stability](minimizer-rigidity-stability/paper.en.md) | [Modules](minimizer-rigidity-stability/formalization/README.md) | Compiled and checked |
| [modular magnetization magic](modular-magnetization-magic/paper.en.md) | [Modules](modular-magnetization-magic/formalization/README.md) | Source snapshot |
| [moment bayes minimax geometry](moment-bayes-minimax-geometry/paper.zh.md) | [Modules](moment-bayes-minimax-geometry/formalization/README.md) | Source snapshot |
| [noiseless codes few binary measurements](noiseless-codes-few-binary-measurements/paper.en.md) | [Modules](noiseless-codes-few-binary-measurements/formalization/README.md) | Source snapshot |
| [noisy qubit design parity](noisy-qubit-design-parity/paper.zh.md) | [Modules](noisy-qubit-design-parity/formalization/README.md) | Compiled and checked |
| [nonadaptive bernoulli moment characterization](nonadaptive-bernoulli-moment-characterization/paper.en.md) | [Modules](nonadaptive-bernoulli-moment-characterization/formalization/README.md) | Source snapshot |
| [noncommuting pell aliases](noncommuting-pell-aliases/paper.en.md) | [Modules](noncommuting-pell-aliases/formalization/README.md) | Compiled and checked |
| [odd cycle exact complexity](odd-cycle-exact-complexity/paper.en.md) | [Modules](odd-cycle-exact-complexity/formalization/README.md) | Compiled and checked |
| [odd qudit replica phase reflection](odd-qudit-replica-phase-reflection/paper.zh.md) | [Modules](odd-qudit-replica-phase-reflection/formalization/README.md) | Compiled and checked |
| [online conformal parabolic evaluation](online-conformal-parabolic-evaluation/paper.zh.md) | [Modules](online-conformal-parabolic-evaluation/formalization/README.md) | Source snapshot |
| [online unbounded knapsack minimax](online-unbounded-knapsack-minimax/paper.en.md) | [Modules](online-unbounded-knapsack-minimax/formalization/README.md) | Source snapshot |
| [optimal resetting asymmetric](optimal-resetting-asymmetric/paper.en.md) | [Modules](optimal-resetting-asymmetric/formalization/README.md) | Source snapshot |
| [order seven sharp erasure](order-seven-sharp-erasure/paper.en.md) | [Modules](order-seven-sharp-erasure/formalization/README.md) | Compiled and checked |
| [order six sharp erasure](order-six-sharp-erasure/paper.en.md) | [Modules](order-six-sharp-erasure/formalization/README.md) | Compiled and checked |
| [ordinal causal benefit sharp bounds](ordinal-causal-benefit-sharp-bounds/paper.en.md) | [Modules](ordinal-causal-benefit-sharp-bounds/formalization/README.md) | Source snapshot |
| [ordinal only frontier](ordinal-only-frontier/paper.en.md) | [Modules](ordinal-only-frontier/formalization/README.md) | Compiled and checked |
| [ordinary ef1 three agent counterexample (extended source)](ordinary-ef1-three-agent-counterexample/paper.en.md) | [Modules](ordinary-ef1-three-agent-counterexample/lean/extended/README.md) | Source snapshot |
| [pairwise independent online crs sharp](pairwise-independent-online-crs-sharp/paper.en.md) | [Modules](pairwise-independent-online-crs-sharp/formalization/README.md) | Compiled and checked |
| [path drift switch budget](path-drift-switch-budget/paper.en.md) | [Modules](path-drift-switch-budget/formalization/README.md) | Compiled and checked |
| [pauli lindblad pec parity](pauli-lindblad-pec-parity/paper.en.md) | [Modules](pauli-lindblad-pec-parity/formalization/README.md) | Source snapshot |
| [posthoc finite stake admissibility](posthoc-finite-stake-admissibility/paper.en.md) | [Modules](posthoc-finite-stake-admissibility/formalization/README.md) | Compiled and checked |
| [ppt squared toroidal mixing](ppt-squared-toroidal-mixing/paper.en.md) | [Modules](ppt-squared-toroidal-mixing/formalization/README.md) | Source snapshot |
| [precise mergers without symmetry](precise-mergers-without-symmetry/paper.en.md) | [Modules](precise-mergers-without-symmetry/formalization/README.md) | Compiled and checked |
| [processing oracle two phase](processing-oracle-two-phase/paper.en.md) | [Modules](processing-oracle-two-phase/formalization/README.md) | Source snapshot |
| [prophet secretary stockout](prophet-secretary-stockout/paper.en.md) | [Modules](prophet-secretary-stockout/formalization/README.md) | Source snapshot |
| [quantum channel product bound universality](quantum-channel-product-bound-universality/paper.en.md) | [Modules](quantum-channel-product-bound-universality/formalization/README.md) | Source snapshot |
| [quantum code n23 m3 b2](quantum-code-n23-m3-b2/paper.zh.md) | [Modules](quantum-code-n23-m3-b2/formalization/README.md) | Compiled and checked |
| [quantum transport polygon exactness](quantum-transport-polygon-exactness/paper.en.md) | [Modules](quantum-transport-polygon-exactness/formalization/README.md) | Source snapshot |
| [qubit cooling bernstein certificate](qubit-cooling-bernstein-certificate/paper.en.md) | [Modules](qubit-cooling-bernstein-certificate/formalization/README.md) | Compiled and checked |
| [random occupancy threshold](random-occupancy-threshold/paper.en.md) | [Modules](random-occupancy-threshold/formalization/README.md) | Compiled and checked |
| [random occupancy threshold (extended source)](random-occupancy-threshold/paper.en.md) | [Modules](random-occupancy-threshold/lean/extended/README.md) | Source snapshot |
| [randomized weighted two job robustness](randomized-weighted-two-job-robustness/paper.en.md) | [Modules](randomized-weighted-two-job-robustness/formalization/README.md) | Source snapshot |
| [rank two scale classification](rank-two-scale-classification/paper.en.md) | [Modules](rank-two-scale-classification/formalization/README.md) | Compiled and checked |
| [record constrained prophet gap](record-constrained-prophet-gap/paper.en.md) | [Modules](record-constrained-prophet-gap/formalization/README.md) | Source snapshot |
| [replicable conformal pilot ranks](replicable-conformal-pilot-ranks/paper.en.md) | [Modules](replicable-conformal-pilot-ranks/formalization/README.md) | Compiled and checked |
| [reversible environment weak response](reversible-environment-weak-response/paper.en.md) | [Modules](reversible-environment-weak-response/formalization/README.md) | Source snapshot |
| [risk sensitive ski rental](risk-sensitive-ski-rental/paper.en.md) | [Modules](risk-sensitive-ski-rental/formalization/README.md) | Compiled and checked |
| [selection audit information](selection-audit-information/paper.en.md) | [Modules](selection-audit-information/formalization/README.md) | Source snapshot |
| [sequential ldp autocovariance minimax](sequential-ldp-autocovariance-minimax/paper.en.md) | [Modules](sequential-ldp-autocovariance-minimax/formalization/README.md) | Source snapshot |
| [sequential target recalculation](sequential-target-recalculation/paper.en.md) | [Modules](sequential-target-recalculation/formalization/README.md) | Source snapshot |
| [sharp amplification and pointwise monotonicity](sharp-amplification-and-pointwise-monotonicity/paper.en.md) | [Modules](sharp-amplification-and-pointwise-monotonicity/formalization/README.md) | Compiled and checked |
| [sharp conditional ranks under tilts](sharp-conditional-ranks-under-tilts/paper.en.md) | [Modules](sharp-conditional-ranks-under-tilts/formalization/README.md) | Compiled and checked |
| [sharp minimal failures](sharp-minimal-failures/paper.en.md) | [Modules](sharp-minimal-failures/formalization/README.md) | Compiled and checked |
| [sharp two step activity](sharp-two-step-activity/paper.en.md) | [Modules](sharp-two-step-activity/formalization/README.md) | Compiled and checked |
| [shifted coefficient boundary](shifted-coefficient-boundary/paper.zh.md) | [Modules](shifted-coefficient-boundary/formalization/README.md) | Compiled and checked |
| [six cycle even replica factorization](six-cycle-even-replica-factorization/paper.zh.md) | [Modules](six-cycle-even-replica-factorization/formalization/README.md) | Compiled and checked |
| [six cycle replica arithmetic](six-cycle-replica-arithmetic/paper.zh.md) | [Modules](six-cycle-replica-arithmetic/formalization/README.md) | Compiled and checked |
| [slack null induction complexity](slack-null-induction-complexity/paper.en.md) | [Modules](slack-null-induction-complexity/formalization/README.md) | Compiled and checked |
| [speed limited harmonic equilibration](speed-limited-harmonic-equilibration/paper.en.md) | [Modules](speed-limited-harmonic-equilibration/formalization/README.md) | Source snapshot |
| [stroboscopic three state entropy range](stroboscopic-three-state-entropy-range/paper.en.md) | [Modules](stroboscopic-three-state-entropy-range/formalization/README.md) | Source snapshot |
| [strong product algebraic squares](strong-product-algebraic-squares/paper.en.md) | [Modules](strong-product-algebraic-squares/formalization/README.md) | Source snapshot |
| [subsampled max power lqrt](subsampled-max-power-lqrt/paper.zh.md) | [Modules](subsampled-max-power-lqrt/formalization/README.md) | Source snapshot |
| [ternary pairwise moment](ternary-pairwise-moment/paper.zh.md) | [Modules](ternary-pairwise-moment/formalization/README.md) | Compiled and checked |
| [topology constrained markov reconstruction](topology-constrained-markov-reconstruction/paper.en.md) | [Modules](topology-constrained-markov-reconstruction/formalization/README.md) | Compiled and checked |
| [transitive composition lift complexity](transitive-composition-lift-complexity/paper.en.md) | [Modules](transitive-composition-lift-complexity/formalization/README.md) | Compiled and checked |
| [two visits duplicate midpoint](two-visits-duplicate-midpoint/paper.zh.md) | [Modules](two-visits-duplicate-midpoint/formalization/README.md) | Compiled and checked |
| [two weight qutrit sharp cooling](two-weight-qutrit-sharp-cooling/paper.en.md) | [Modules](two-weight-qutrit-sharp-cooling/formalization/README.md) | Source snapshot |
| [unknown gap adaptation boundary](unknown-gap-adaptation-boundary/paper.en.md) | [Modules](unknown-gap-adaptation-boundary/formalization/README.md) | Source snapshot |
| [weighted bernoulli entropy curvature](weighted-bernoulli-entropy-curvature/paper.en.md) | [Modules](weighted-bernoulli-entropy-curvature/formalization/README.md) | Source snapshot |
| [weighted conformal explicit sample threshold](weighted-conformal-explicit-sample-threshold/paper.en.md) | [Modules](weighted-conformal-explicit-sample-threshold/formalization/README.md) | Source snapshot |
| [weighted conformal fixed cap curvature](weighted-conformal-fixed-cap-curvature/paper.en.md) | [Modules](weighted-conformal-fixed-cap-curvature/formalization/README.md) | Compiled and checked |
| [weighted conformal poisson transfer](weighted-conformal-poisson-transfer/paper.en.md) | [Modules](weighted-conformal-poisson-transfer/formalization/README.md) | Compiled and checked |
| [weighted maxcut feedback](weighted-maxcut-feedback/paper.zh.md) | [Modules](weighted-maxcut-feedback/formalization/README.md) | Compiled and checked |
| [weighted regression selection frontier](weighted-regression-selection-frontier/paper.en.md) | [Modules](weighted-regression-selection-frontier/formalization/README.md) | Compiled and checked |

## Additional archived examples

| Research project | Files |
|---|---|
| [conjugate resetting global optimality](conjugate-resetting-global-optimality/paper.en.md) | [radial_resolvent_check.json](conjugate-resetting-global-optimality/results/radial_resolvent_check.json) |
| [euclidean median all p sharp](euclidean-median-all-p-sharp/paper.en.md) | [verify_contact_algebra.py](euclidean-median-all-p-sharp/code/verify_contact_algebra.py) |
| [fixed agent cumulative envy](fixed-agent-cumulative-envy/paper.en.md) | [verify_exact.py](fixed-agent-cumulative-envy/code/verify_exact.py) |
| [four qubit fredkin exact entangling power](four-qubit-fredkin-exact-entangling-power/paper.en.md) | [independent_statevector_check.py](four-qubit-fredkin-exact-entangling-power/code/independent_statevector_check.py), [exact_certificate.json](four-qubit-fredkin-exact-entangling-power/results/exact_certificate.json) |
| [heavy ball planar cycle domain](heavy-ball-planar-cycle-domain/paper.zh.md) | [fan7_certificate.py](heavy-ball-planar-cycle-domain/code/fan7_certificate.py), [fan7_certificate.json](heavy-ball-planar-cycle-domain/results/fan7_certificate.json) |
| [markov missing mass minimax](markov-missing-mass-minimax/paper.zh.md) | [general_counterexample_checks.py](markov-missing-mass-minimax/code/general_counterexample_checks.py) |
| [one fast many slow threshold](one-fast-many-slow-threshold/paper.en.md) | [tail_bound_certificate.json](one-fast-many-slow-threshold/results/tail_bound_certificate.json) |
| [processing oracle two phase](processing-oracle-two-phase/paper.en.md) | [verify_physical_subsolution.py](processing-oracle-two-phase/code/verify_physical_subsolution.py) |
| [pure entanglement three measurement exclusion](pure-entanglement-three-measurement-exclusion/paper.en.md) | [numerical_checks.json](pure-entanglement-three-measurement-exclusion/results/numerical_checks.json) |
| [quantum code n23 m3 b2](quantum-code-n23-m3-b2/paper.zh.md) | [b2_hxrx_reference6_result.json](quantum-code-n23-m3-b2/data/b2_hxrx_reference6_result.json), [comparison_summary.json](quantum-code-n23-m3-b2/data/comparison_summary.json) |
| [quantum renyi45 erasure bound](quantum-renyi45-erasure-bound/paper.en.md) | [verify_numerical.py](quantum-renyi45-erasure-bound/code/verify_numerical.py) |
| [qubit cooling bernstein certificate](qubit-cooling-bernstein-certificate/paper.en.md) | [exact_certificate.py](qubit-cooling-bernstein-certificate/code/exact_certificate.py) |
| [queue routing logarithmic regret](queue-routing-logarithmic-regret/paper.en.md) | [check_counterexample_bases.py](queue-routing-logarithmic-regret/code/check_counterexample_bases.py) |
| [record constrained prophet gap](record-constrained-prophet-gap/paper.en.md) | [sparse_policy_input.json](record-constrained-prophet-gap/results/sparse_policy_input.json) |
| [renyi three channel frontier](renyi-three-channel-frontier/paper.en.md) | [hessian_polynomial_cloud.json](renyi-three-channel-frontier/results/hessian_polynomial_cloud.json) |
| [schmidt reference renyi half counterexample](schmidt-reference-renyi-half-counterexample/paper.en.md) | [full_pauli_certificate.json](schmidt-reference-renyi-half-counterexample/results/full_pauli_certificate.json) |
| [temporal ef1 nine chores threshold](temporal-ef1-nine-chores-threshold/paper.en.md) | [teh_nine.json](temporal-ef1-nine-chores-threshold/results/teh_nine.json) |
| [two weight qutrit sharp cooling](two-weight-qutrit-sharp-cooling/paper.en.md) | [verify_product.py](two-weight-qutrit-sharp-cooling/code/verify_product.py) |

## Additional verification and reproducibility files

| Research project | Files |
|---|---|
| [cactus replica rationality](cactus-replica-rationality/paper.zh.md) | [certificate_cactus.py](cactus-replica-rationality/code/certificate_cactus.py) |
| [clique dually conformal induced extension](clique-dually-conformal-induced-extension/paper.en.md) | [archived-lean-verification.json](clique-dually-conformal-induced-extension/results/archived-lean-verification.json) |
| [complete bipartite tar rigidity](complete-bipartite-tar-rigidity/paper.zh.md) | [verify_boundary.py](complete-bipartite-tar-rigidity/code/verify_boundary.py) |
| [fractional advice paw transfer](fractional-advice-paw-transfer/paper.en.md) | [verify_independent.py](fractional-advice-paw-transfer/code/verify_independent.py) |
| [heavy ball planar cycle domain](heavy-ball-planar-cycle-domain/paper.zh.md) | [reproduce_certificates.py](heavy-ball-planar-cycle-domain/code/reproduce_certificates.py) |
| [krr exact zcdp](krr-exact-zcdp/paper.en.md) | [verify_all.py](krr-exact-zcdp/code/verify_all.py) |
| [modular magnetization magic](modular-magnetization-magic/paper.en.md) | [verify_primary.py](modular-magnetization-magic/code/verify_primary.py) |
| [online conformal critical variational limit](online-conformal-critical-variational-limit/paper.zh.md) | [dp_crosscheck.py](online-conformal-critical-variational-limit/code/dp_crosscheck.py) |
| [pauli mub phase rigidity](pauli-mub-phase-rigidity/paper.en.md) | [archived-lean-verification.json](pauli-mub-phase-rigidity/results/archived-lean-verification.json) |
| [quantum chi2 tensorization regions](quantum-chi2-tensorization-regions/paper.en.md) | [reproduce.py](quantum-chi2-tensorization-regions/code/reproduce.py) |
| [quantum code n23 m3 b2](quantum-code-n23-m3-b2/paper.zh.md) | [run_b2_hxrx_reference6.py](quantum-code-n23-m3-b2/code/run_b2_hxrx_reference6.py), [run_b2_reference6.py](quantum-code-n23-m3-b2/code/run_b2_reference6.py), [scale_hxrx_diagnostic.py](quantum-code-n23-m3-b2/code/scale_hxrx_diagnostic.py), [comparison.md](quantum-code-n23-m3-b2/reproduction/comparison.md) |
| [quantum transport polygon exactness](quantum-transport-polygon-exactness/paper.en.md) | [run_checks.py](quantum-transport-polygon-exactness/code/run_checks.py) |
| [qubit cooling arbitrary machine](qubit-cooling-arbitrary-machine/paper.zh.md) | [check_staircase_independent.py](qubit-cooling-arbitrary-machine/code/check_staircase_independent.py) |
| [rank two permutation sharp constant](rank-two-permutation-sharp-constant/paper.en.md) | [rank2_codec.py](rank-two-permutation-sharp-constant/code/rank2_codec.py) |
| [renyi product order phase](renyi-product-order-phase/paper.en.md) | [runtime_versions.json](renyi-product-order-phase/results/runtime_versions.json) |
| [risk transfer and finite horizon](risk-transfer-and-finite-horizon/paper.en.md) | [make_figures.py](risk-transfer-and-finite-horizon/code/make_figures.py) |
| [robust crt fixed channel exact design](robust-crt-fixed-channel-exact-design/paper.en.md) | [compare.py](robust-crt-fixed-channel-exact-design/code/compare.py), [independent_reference.json](robust-crt-fixed-channel-exact-design/results/independent_reference.json) |
| [scalar lq global learning bifurcations](scalar-lq-global-learning-bifurcations/paper.en.md) | [experiment-design.json](scalar-lq-global-learning-bifurcations/results/experiment-design.json) |
| [selection audit information](selection-audit-information/paper.en.md) | [generate_certificates.py](selection-audit-information/code/generate_certificates.py) |
| [six cycle odd index entropy rises](six-cycle-odd-index-entropy-rises/paper.zh.md) | [certificate_odd_rises.py](six-cycle-odd-index-entropy-rises/code/certificate_odd_rises.py) |
| [temporal ef1 nine chores threshold](temporal-ef1-nine-chores-threshold/paper.en.md) | [REPRODUCTION.md](temporal-ef1-nine-chores-threshold/REPRODUCTION.md), [verify_exact_certificate.py](temporal-ef1-nine-chores-threshold/code/verify_exact_certificate.py), [exact-certificate-problem.txt](temporal-ef1-nine-chores-threshold/results/exact-certificate-problem.txt), [exact-proof-certificate.json](temporal-ef1-nine-chores-threshold/results/exact-proof-certificate.json) |
