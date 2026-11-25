---
title: "Weighted Regression Selection: Structured Bounds, Exact Certificates and Attainment of Worst-Case Data"
author: "Research manuscript"
date: "2026-11-25"
lang: en
---

# Abstract

We study sparse selection of original examples for a fixed minimum-Euclidean-norm
weighted least-squares learner, while preserving the original evaluation loss.
First, we give a support-aware adaptation of the classical sign-cell description
of weighted least-squares outputs, including strict-cell closure and rational
decision certificates. An explicit graph reduction then gives NP-completeness
of exact selected-risk threshold decisions and an inverse-polynomial risk gap,
already for uniformly evaluated integer datasets with a selection budget of one
row above dimension. The graph and positive-spanning hardness mechanisms are
classical; the scope claimed here is their exact minimum-norm risk-gap transfer.

Second, we derive a balanced-anchor interface from circuit geometry to actual
full-rank selected fits. A finite hypergraph minimax inequality yields the sharp
one-surplus-row constant for systems whose maximal positive-circuit spans are
coordinate subspaces in one common linear basis. The max-log optimization
principle and the attaining two-block construction are prior mechanisms. We
state and prove the exact residual-root hypothesis, the zero-residual quotient
condition, and the original minimum-norm sharpness argument.

Third, exact Fano and seven-dimensional shared-root matching configurations
disprove the proposed coarse multi-anchor and single-anchor rank-game bounds.
These are counterexamples to sufficient proof mechanisms, not counterexamples
to the regression conjecture. Retaining projected circuit coefficients gives a
uniform risk bound below the conjectured constant for a specified noncoordinate
shared-root scale family; a different four-parameter family admits twelve
explicit fit branches and a stronger bound. Exact rational, symbolic and graph
checks accompany these statements. Three elementary algebraic lemmas have been
compiled and independently replayed in Lean; the remaining formal obligations
are explicitly outstanding.

For the unrestricted model, we prove that the worst-case value at every
\(n\ge d\) is attained by a uniformly evaluated real-algebraic dataset with
at most \((d+1)(d+2)/2\) rows. Quantifier elimination determines the exact
algebraic value and decides strict exceedance of the conjectured bound at
a specified pair. Separately, an exact orthogonal budget formula handles
deficient and unselected blocks under the original learner. The general
closed-form frontier remains open.

# 1. Frozen problem, model and contribution boundaries

## 1.1 Original objective and learner

Let a nonempty finite dataset consist of scalar-response pairs
\((x_i,y_i)\in\mathbb R^d\times\mathbb R\). The fixed evaluation loss is

\[
 L_D(w)=\sum_{i=1}^N p_i(x_i^\top w-y_i)^2,
 \qquad p_i>0,\quad\sum_i p_i=1.
\]

Uniform evaluation has \(p_i=1/N\). A selector chooses a nonempty support of
at most \(n\) original rows and nonnegative training weights with positive sum,
normalized to sum to one. The learner returns the Euclidean minimum-norm
minimizer of that selected weighted training objective. The training weights
never replace the evaluation probabilities. All risk values below use the
original full-data evaluation loss.

Write \(L_D^*=\min_w L_D(w)\). For \(L_D^*>0\), let the dataset's selected
risk ratio be the infimum of \(L_D(w)/L_D^*\) over admissible selections, and
let \(F_w(d,n)\) be its supremum over finite datasets in dimension \(d\).
At zero full-data loss, an observed-feature basis reproduces the full
minimum-norm optimum at the budgets studied here; the ratio convention is one.
An infimum is used throughout: zero training weights may arise at a limit and
the minimum need not be attained on an initially fixed positive support.

The fixed positive evaluation notation is convenient and does not change the
real-input problem. An instance with probabilities \(p_i\) is represented by
\(N\) uniformly evaluated rows
\(\widetilde x_i=\sqrt{Np_i}\,x_i\),
\(\widetilde y_i=\sqrt{Np_i}\,y_i\). Replacing training weights
\(\alpha_i\) by weights proportional to \(\alpha_i/(Np_i)\) preserves
the selected quadratic objective up to a common factor, hence its whole
minimizer set and its Euclidean minimum-norm member. The complexity reduction
below uses uniform rational integer data directly and does not rely on this
potentially irrational representation.

For \(1\le k\le d-1\), define

\[
\Gamma_{d,k}
=\max_{k+1\le s\le d}
\frac{s-k}{(s-a_s)/q_s+a_s/(q_s+1)},
\qquad d=q_s s+a_s,\quad 0\le a_s<s.
\]

The frozen main target is the remaining unrestricted statement

\[
 F_w(d,d+k)=1+\Gamma_{d,k},
\]

either by proving the missing universal upper bound or by giving an exact
admissible original-regression counterexample. The known simplex-block lower
bound, solved budget ranges and benchmark values are not new claims. In
particular, \(\Gamma_{d,1}=\lfloor d^2/4\rfloor/d\).

## 1.2 Prior work and the unresolved part

Hanneke, Moran, Shlimovich and Yehudayoff [HMSY25] posed the fixed-learner data
selection problem. Zhang [Z26, v2] derived the exact simplex-block frontier,
lower bounds and finite-support tools, and proposed the all-parameter
conjecture. Liu and Wang [LW26] proved the upper-half range
\(\lceil3d/2\rceil\le n\le2d-1\) and the five-dimensional one-surplus-row
case. Their circuit-plane random-vertex method is the direct starting point
of the anchor constructions here. This manuscript does not reclassify those
results as unsolved or claim them as new.

Classical weighted-regression estimate-set geometry [GL83, F96], layered
least-squares limits [KT09], rational quadratic-program certificates [V90],
minimum positive-spanning hardness [BMK94] and positive-spanning/digraph
correspondences [CKR25] are explicit neighboring results. The hypergraph
argument applies classical log-utility / optimal-design first-order
conditions [KW60, KMT98]. The Petersen graph's hypohamiltonian property is
classical [AMW97]. Exact source versions, access limitations and read scopes
are in Historical source catalog; claim-by-claim comparisons are in Historical claim-by-claim comparison.

## 1.3 What is proved, and at what scope

| Result | Exact scope | Relation to the main target |
|---|---|---|
| Sign cells and rational upper-threshold witnesses | Arbitrary rational finite data, all nonempty sparse supports, including deficient rank | Classical geometry adapted to the learner; a computational certificate, not a universal risk bound |
| Explicit hardness transfer | Uniform integer data, dimension \(v-1\), budget \(v\), risks \(1\) versus at least \(1+1/W\), \(W\le mv\) | Resolves a supporting complexity question at a precise model; leaves the worst-case frontier open |
| Sharp coordinate-span theorem | Maximal positive-circuit spans are simultaneous coordinate subspaces; with the stated projected-root condition for zero residuals | Actual \(d+1\)-row worst-case ratio \(1+\lfloor d^2/4\rfloor/d\) within this subclass |
| Fano obstruction | \(d=7,k=2\): rank game \(6/7>4/5\) | Rejects a coarse sufficient inequality; an actual fit has excess \(5/14\) |
| Shared-root matching obstruction | \(d=7,k=1\): rank game \(2>12/7\), and noncoordinate maximal spans | Rejects the unrestricted single-anchor rank-game route; the canonical data admit excess \(2/5\) |
| Coefficient-sensitive repair | Only the shared root is scaled by \(\tau>0\); arbitrary compatible positive centered evaluation probabilities | Actual eight-row excess at most \(6\tau/(4\tau+1)<3/2<12/7\) |
| Four-parameter constructive family | Fixed gradient columns, four strictly positive group masses \(c_u,c_a,c_b,c_h\) | Twelve explicit full-rank fits give excess below \(2/3\); this is a different restricted family |
| Orthogonal allocation | Any row budget \(n\ge1\), including unselected blocks and rank-deficient supports | Exact loss identity under the original learner |
| Attainment and algebraic decision | Arbitrary datasets when \(n\ge d\) | Worst data exist with quadratic row bound, and a fixed conjecture cell is decidable |

The auxiliary game is an upper-bound certificate. Its value has never been
proved equal to the selected-risk optimum. None of its counterexamples can
be promoted to a counterexample to \(F_w=1+\Gamma\). No finite random or
targeted scan proves a universal assertion over real input data.

There is an additional minimum-norm distinction in the unshifted centered
root examples with all responses one: selecting any balanced positive circuit
already makes zero the minimum-norm output, so their unrestricted selected-risk
optimum is one. Values such as \(2/5\) and \(5/14\) are therefore only
explicit full-rank feasible excesses, not positive optimal excesses. The
full-rank constructions remain useful under arbitrary label translations
\(y_i\mapsto y_i+x_i^\top a\): their unique outputs translate by \(a\)
and their excesses remain unchanged. This exact transfer is proved for the
four-parameter construction below. No such translation equivariance is
assumed for deficient-rank minimum-norm outputs.

The subsequent parts contain full mathematical derivations. Each retains
local section/theorem numbering. References to named component files refer
to the historical component manuscripts. Reproduction commands are in the [historical reproduction guide](evidence/README.md).

# 2. Exact support certificates and a uniform risk-gap reduction

Final auxiliary statement, 2026-11-25. Results for the frozen weighted-regression frontier problem.
The universal Gamma conjecture is **not resolved** by this document. Geometry in Section 1
has strong classical precedents and is recorded as a self-contained adaptation, not as a new
polyhedral-set theorem. The proposed additional content is the exact learner-aware complexity
transfer and its uniform inverse-polynomial risk gap. Independent novelty/value judgments
are recorded separately in the case reviews; no priority guarantee is made here.

### 1. Exact support and residual-sign description

Let a finite dataset be `(x_i,y_i)`, with `x_i` in R^d, and let evaluation probabilities
`p_i>0` sum to one. Training weights can be arbitrary nonnegative numbers on at most `n`
original rows. Their common scale is irrelevant. The learner returns the Euclidean minimum-norm
minimizer. The dataset and the training support are nonempty, and n>=1; the positive
training weights may be normalized to sum to one. Write `r_i(w)=x_i^T w-y_i`,
`U_S=span{x_i:i in S}`, and `L(w)=sum_i p_i r_i(w)^2`.

**Proposition 1 (support-aware sign cells; classical geometry adapted to minnorm).**
Fix a support S and a sign vector `s in {-1,0,1}^S`. Put `J={i:s_i != 0}`.
Call the sign vector balanced if J is empty, or if there are `beta_i>0` for all i in J
with `sum_J beta_i s_i x_i=0`. Define

`P°(S,s)={w in U_S: r_i(w)=0 if s_i=0; s_i r_i(w)>0 otherwise}`.

The exact set of outputs obtainable using strictly positive weights on every row of S
is the union of these cells over balanced signs. Empty cells contribute nothing.

Proof. Every weighted normal equation reads `sum_S alpha_i r_i(w) x_i=0`.
For its residual signs take `beta_i=alpha_i |r_i(w)|>0` on J.
Every minimum-norm minimizer lies in U_S, since the orthogonal complement of U_S is
precisely the nullspace of all selected measurements. Conversely, for a point in a balanced
cell choose `alpha_i=beta_i/|r_i(w)|` on J and any positive alpha on its complement.
The normal equation holds. The weighted quadratic is strictly convex on U_S:
for a nonzero u in U_S, not all `x_i^T u` vanish. Thus w is the unique minimizer in U_S
and consequently the Euclidean minimum-norm minimizer in the ambient space. If J is empty,
all selected equations interpolate and the same reasoning applies with arbitrary positive weights.
This also handles zero feature rows, zero residuals, and rank-deficient supports. QED.

For each nonempty cell P°, its closure is exactly the polyhedron P obtained by changing
strict inequalities to weak inequalities and keeping all equalities. Indeed, if w0 belongs
to P and w1 belongs to P°, then `(1-epsilon)w0+epsilon w1` belongs to P° for `0<epsilon<=1`
and tends to w0. The converse follows from continuity. This assertion must **not** be used for
an empty strict cell. Since there are finitely many supports and signs, the closure of all
budget-n outputs is precisely the union of these closed P over nonempty supports.

**Corollary 2 (exact rational infima and decision certificates).**
For rational input data and rational positive evaluation probabilities, the infimum of L over
all budget-n training selections is a rational number of polynomial encoding length in the
input length. It can be computed by finitely many rational convex quadratic programs. The
decision problem `inf L <= tau`, for rational tau, is in NP.

Details. If U_S is zero-dimensional, its only point is w=0; every nonempty cell has this
same rational point and rational loss, so the claims are immediate. Otherwise obtain a
rational basis B for U_S and write w=Bz. The reduced Hessian
`B^T(sum_all p_i x_i x_i^T)B` is positive definite, because U_S is a subspace of the full
row span. Every nonempty closed cell therefore has a unique minimum. At that minimum choose
a maximal linearly independent set of active affine constraints (including the defining
equalities); the gradient is normal to their affine hull. The corresponding equality-constrained
KKT system has a unique rational solution for z, and the resulting value is rational. Rational
Gaussian elimination, determinant bounds and clearing denominators give polynomial bit length.
All dimensions and coefficient lengths in that system are polynomial in the original input.
There may be exponentially many such systems; polynomial bit length is not polynomial runtime.

For the NP witness supply S, s, a strictly positive balanced rational beta when J is nonempty,
a rational point w1 in the strict cell, and a rational point w0 in its closure with L(w0)<=tau.
Positive beta can be scaled so every beta_i>=1. Strict feasibility has a short rational witness:
maximize a common slack t subject to the linear equalities, signed inequalities >=t, and
0<=t<=1; a nonempty strict cell gives positive optimum and a rational basic solution of
polynomial size (free directions may be fixed by independent rational equalities).
The verifier uses exact rational linear algebra and arithmetic. Completeness follows by choosing
an optimal closed cell and its rational minimizer. For an empty J omit beta entirely.
This is a polynomial-size certificate of an upper
threshold, **not** a polynomial-size certificate that no other support does better.

Given an optimal closed-cell point and a strict point, the interpolation above and the
weights from Proposition 1 supply an explicit rational approaching sequence. Attainment
can be checked separately by enumerating the minimizers of every globally minimizing closed
cell and asking whether at least one belongs to any actual strict cell. No blanket claim
that the optimizing weights always exist is made.

Prior work: Gilstein--Leamer, 1983, DOI 10.1080/01621459.1983.10477044,
describes the weighted regression estimate set using bounded
polyhedra. Forsgren, 1996, DOI 10.1137/S0895479895284014, explicitly reports the previously
known finite relative-interior polytope description for positive diagonal weights. Their
fixed full-rank setting transfers to U_S; the present proof is included for precise sparse
support and minimum-norm conventions, not to claim that geometry was first discovered here.
Convex rational-QP certificate theory is also classical. Layered least-squares limits were
already studied by Vavasis--Ye and Kitahara--Tsuchiya (2009), DOI 10.1137/080725787.

### 2. Explicit uniform-data risk gap from directed Hamiltonian cycle

**Theorem 3 (quantitative learner-aware hardness transfer).**
There is a polynomial-time construction taking a strongly connected loopless directed graph G
with v>=2 vertices and m arcs to a uniformly evaluated scalar-regression dataset with
dimension d=v-1, W<=mv rows, integer features in {-1,0,1}, and labels in {1,1-v,1+v} such that:

1. The full design has rank d and its optimal loss is exactly 1.
2. For training budget n=v=d+1, if G has a directed Hamiltonian cycle, the optimal selected
   risk is 1 and is attained.
3. If G has no directed Hamiltonian cycle, **every** permissible minimum-norm selected fit
   has risk at least `1+1/W`. The same inequality holds for the infimum and every limit.

Here loopless means no self-loop; opposite arcs are allowed. Parallel copies can be merged.
The theorem is a transfer from a classical NP-complete graph problem; positive spanning and
strong connectivity, and minimum positive-spanning hardness, are established prior work.

Construction. Fix vertex v as reference, and let b_e be the reduced incidence row for arc
e=(u,t), with +1 at u, -1 at t, and the reference coordinate removed. For each arc choose
a simple directed path from its head t to its tail u, of length at most v-1; it exists by
strong connectivity. Add one unit of flow on e and that path. Summing these m closed walks
produces an integer circulation c with every c_e>=1 and

`sum_e c_e b_e=0`, `W=sum_e c_e<=mv`.

Let `a=v*(1,...,1)` in R^(v-1). Include c_e copies of
`(x_e,y_e)=(b_e, 1+b_e^T a)`, evaluated uniformly on all W copies. The labels have the
announced three values. For w=a+delta,

`L(w)=1+(1/W) sum_e c_e (b_e^T delta)^2`.                       (1)

This follows by expanding `(b_e^T delta-1)^2` and using the circulation identity. The
underlying undirected graph is connected, so the reduced incidence matrix has full rank.
Thus a is the unique full optimum and L*=1.

YES case. Select the v arcs of a Hamiltonian cycle, one copy each, with equal positive
training weights. Their incidence rows span R^(v-1), and their sum is zero. At a all selected
residuals equal -1, so the normal equation holds; full rank gives unique output a.

NO case: full-rank selected support. Merge duplicated arcs by adding their training weights,
so the selected arc set S has at most v arcs with positive weights alpha. If there is an arc
e in S with `b_e^T delta>=1`, formula (1) gives excess at least `c_e/W>=1/W`.
Otherwise every selected residual is negative. The normal equation implies

`sum_(e in S) alpha_e(1-b_e^T delta)b_e=0`,

a strictly positive circulation on every selected arc. Full rank implies that the selected
underlying graph is connected on all v vertices. Each arc of a strictly positive circulation
lies on a directed cycle: otherwise consider the acyclic condensation graph and its source
component, or use conservation on a reachable cut. Hence weak connectivity forces strong
connectivity. A strongly connected loopless spanning graph has at least v arcs; if it has
at most v, each vertex has exactly one incoming and one outgoing arc, so it is a single
Hamiltonian cycle. This contradicts the NO assumption. Therefore the first branch occurs.

NO case: rank-deficient support. Include isolated vertices when taking weak components.
Some component C does not contain reference v. Every selected incidence row has coordinate
sum zero over C, and the minimum-norm output w belongs to the span of these rows, so
`sum_(i in C) w_i=0`. Since `a_i=v`, the average of delta_i on C is -v; choose i with
`delta_i<=-v`. Set delta_v=0. A simple undirected path in the full graph from i to v has
length ell<=v-1. By Cauchy--Schwarz and telescoping,

`sum_(e on path) (b_e^T delta)^2 >= delta_i^2/ell >= v^2/(v-1)`.

Each path arc appears in the evaluation set at least once, whence (1) gives
`L(w)-1 >= v^2/[W(v-1)] >= 1/W`. A support consisting only of zero-weight rows is
not an admissible normalized selection and is not needed in this argument.
The bound is uniform, so passage to infima introduces no gap. QED.

**Corollary 4 (decision and approximation consequences).**
The rational decision problem `inf L<=tau` is NP-complete, already for the restricted
datasets of Theorem 3 at tau=1. Moreover, distinguishing risk 1 from risk at least 1+1/W is
NP-hard. No FPTAS returning a feasible training selection with the usual multiplicative
guarantee for L can exist unless P=NP: run it with epsilon=1/(2W) and compare its certified
risk with 1+1/W. Both W and 1/epsilon are polynomial in the explicit input size. The same
reduction excludes any finite multiplicative-factor approximation for excess risk L-L*,
since its YES optimum is zero. These statements assume the algorithm outputs a solution
whose risk can be evaluated in polynomial time, such as rational training weights.

Directed Hamiltonian cycle remains hard under the strong-connectivity promise: a graph
not strongly connected is immediately a NO instance and can be mapped to any fixed
strongly connected non-Hamiltonian graph (for example the bidirected three-vertex path).
One can alternatively use the usual restriction directly. This avoids a hidden promise gap.

### 3. Checks and limitations

- Theorem 3 deliberately fixes the original uniform evaluation distribution; training
  reweighting never changes the objective distribution.
- The shift a is explicit and polynomially bounded. No generic-position oracle, hidden
  exponential replication, real-number encoding or perturbation limit is used.
- The rank-deficient branch is necessary; simply translating the full optimum to zero
  would make zero obtainable from lower-dimensional positive circuits and invalidate hardness.
- Theorem 3 does not imply any lower bound above Gamma on the worst-case frontier.
- Theorem 3's base combinatorics are near Baraff--Mattikalli--Khosla's 1994 minimum-positive-
  spanning NP-completeness theorem and Cornaz--Kerleau--Royer's positive-spanning/digraph bridge.
  The novelty audit therefore limits the proposed contribution to this exact learner-aware
  risk-gap transfer, rather than the underlying graph or positive-spanning hardness.
- This draft contains mathematical proofs, not a full Lean certification. The unfinished
  universal frontier and all missing formal obligations remain explicit.

# 3. Balanced-anchor geometry and the Fano obstruction

### Status and attribution

The original target `F_w(d,d+k)=1+Gamma_{d,k}` remains **unresolved**. The result below proves a conditional geometric interface and then disproves the proposed universal estimate for that interface at `(d,k)=(7,2)`. It does not disprove the original regression conjecture. An explicit low-risk fit is supplied for the symmetric dataset used in the obstruction.

The interface develops the circuit-plane random-vertex argument in Liu–Wang, *Weighted Data Selection: Sharp Upper-Half and Five-Dimensional Laws*, arXiv:2610.00101, §3.2 and Appendix B.1. That source already proves the one-circuit training realization and its five-dimensional graph specialization. Zhang, *Exact Risk Ratios for Weighted Data Selection in Linear Regression*, arXiv:2608.28007v2, Appendices G and I, supplies the other comparison examples. No novelty claim is made for the elementary normalization, circuit decomposition, or one-circuit realization. The new exploratory question tested here is the universal multi-anchor **rank-game** bound; that proposed bound fails.

### 1. Normalized root system and admissible anchors

Let `v_1,...,v_N` be a finite family in `R^d`, allowing zero roots. Suppose positive numbers `lambda_i` satisfy

\[
\sum_i\lambda_i=1,\qquad
\sum_i\lambda_i v_i=0,\qquad
\sum_i\lambda_i v_i v_i^\top=I_d. \tag{1}
\]

The normalized training objective on a support `S` is

\[
\sum_{i\in S}w_i(v_i^\top z-1)^2,\qquad w_i>0.
\]

When `S` spans `R^d`, its minimizer is unique; its original normalized evaluation risk is `1+||z||^2`.

A balanced anchor is a nonempty support `A` with coefficients `a_i>0` such that

\[
\sum_{i\in A}a_iv_i=0.
\]

Write `P_A=span{v_i:i in A}`, `r_A=dim P_A`, and `nu_A=|A|-r_A`. For budget `d+k`, permit every balanced anchor with `nu_A<=k`. This definition uses actual support nullity. A union of `k` circuits is not automatically permitted: overlap of their spans can make its nullity exceed `k`.

A positive circuit is a support-minimal nonzero nonnegative dependence, normalized to have coefficients summing to one. A circuit of rank `r` has `r+1` elements. A singleton zero root is a rank-zero circuit.

### 2. The polar slice is a compact polytope

For a balanced anchor define

\[
K_A=\{z\in P_A^\perp:v_i^\top z\le1\text{ for all }i\}. \tag{2}
\]

The roots positively span `R^d`. Indeed, if a linear functional is nonnegative on every root, its average under the strictly positive centered measure is zero, so it vanishes on every root; (1) then makes the functional zero. Equivalently, zero lies in the relative interior of the convex hull, and the covariance makes the span full.

The orthogonal projections of the roots positively span `P_A^perp`. Consequently, no nonzero vector in that space has all root evaluations nonpositive. The recession cone of (2) is therefore `{0}`, proving boundedness. The set is closed and nonempty, hence compact. It contains a neighborhood of zero relative to `P_A^perp`, because finitely many inequalities all have strict slack at zero. Its relative dimension is `d-r_A`.

For a vertex `z` of (2), the active projected normals span `P_A^perp`: otherwise a nonzero direction annihilating all active normals would allow a sufficiently small displacement in both signs, contradicting extremality. Select `d-r_A` independent active rows and call their indices `J`. None belongs to `A`, since anchor evaluations are zero, whereas active evaluations equal one.

### 3. Every slice vertex is an actual full-rank selected fit

Fix a vertex `z` and the set `J` above. Give the anchor rows their positive balancing weights `a_i` and give the rows in `J` arbitrary positive weights. At `z`, all anchor evaluations are zero and all rows in `J` interpolate their response one. Thus the selected gradient is

\[
2\sum_{i\in A}a_i(0-1)v_i+
2\sum_{j\in J}w_j(1-1)v_j=0.
\]

The anchor spans `P_A`; the rows in `J` are independent modulo `P_A`. Their union spans `R^d`. Its positively weighted Gram matrix is positive definite, so stationarity makes `z` its unique minimizer. Its support size is

\[
|A|+|J|=|A|+d-r_A=d+\nu_A\le d+k. \tag{3}
\]

This vertex construction has exact positive weights and requires no limiting argument.

Since zero belongs to the compact polytope, it is a finite convex combination of its vertices. Choose any such representation, and let `Z_A` be the corresponding random vertex. Then

\[
\mathbb E Z_A=0,\qquad v_i^\top Z_A\le1\quad\text{for every }i. \tag{4}
\]

Every value of this random variable is an actual legal selected fit satisfying (3). If `r_A=d`, the polytope consists only of zero and the same assertions apply with `J` empty.

### 4. Circuit-wise second-moment bound, including projected degeneracies

Let `C` be an original positive circuit with normalized coefficients `beta_i>0`. Put

\[
u_i=\Pi_{P_A^\perp}v_i\quad(i\in C),\qquad
\rho(A,C)=\operatorname{rank}\{u_i:i\in C\}
=\operatorname{rank}(A\cup C)-\operatorname{rank}(A). \tag{5}
\]

The coefficients `beta` remain a nonnegative zero relation among the projected roots, even if some projected roots vanish. Consider the compact polytope

\[
Q=\{b\ge0:\sum_{i\in C}b_i=1,\ \sum_{i\in C}b_i u_i=0\}.
\]

Its vertices are precisely normalized positive circuits of the projected configuration. To see this, a non-minimal support admits a nontrivial null perturbation preserving both the vector relation and coefficient sum, so cannot be extreme. Conversely, a support-minimal nonnegative relation has a one-dimensional kernel: if the kernel had dimension at least two, perturb a strictly positive relation in a non-proportional null direction until one coefficient first vanishes, contradicting minimality. Normalization therefore makes the relation a vertex. This argument includes singleton zero roots.

Decompose `beta` as a convex combination `sum_t tau_t alpha^(t)` of these vertices. For one projected circuit with coefficients `alpha_i>0`, let `s` be its support size and put `T_i=v_i^T Z_A=u_i^T Z_A`. Pointwise,

\[
T_i\le1,\qquad\sum_i\alpha_iT_i=0,
\qquad T_i\ge-\frac{1-\alpha_i}{\alpha_i}.
\]

Moreover `E T_i=0` by (4). If `b_i=(1-alpha_i)/alpha_i`, then `(T_i+b_i)(T_i-1)<=0`, hence

\[
\mathbb E T_i^2\le b_i,
\qquad
\mathbb E\sum_i\alpha_iT_i^2
\le\sum_i(1-\alpha_i)=s-1.
\]

For a singleton zero root the same formula gives zero. In all cases `s-1` is the rank of that projected circuit and is at most `rho(A,C)`. Recombining the convex decomposition gives

\[
\mathbb E\sum_{i\in C}\beta_i(v_i^\top Z_A)^2
\le\sum_t\tau_t\operatorname{rank}(\operatorname{supp}\alpha^{(t)})
\le\rho(A,C). \tag{6}
\]

The first inequality is a potentially stronger coefficient-sensitive bound. The final inequality discards both coefficient information and the masses of zero projected roots. This loss matters in the obstruction below.

### 5. Conditional rank-game risk theorem

Decompose the centered probability vector `lambda` into original normalized positive circuits:

\[
\lambda=\sum_C\omega_C\beta^C,
\qquad\omega_C\ge0,\quad\sum_C\omega_C=1.
\]

The same compact-polytope argument proves existence. By isotropy (1), and then (6),

\[
\mathbb E\|Z_A\|^2
=\sum_i\lambda_i\mathbb E(v_i^\top Z_A)^2
\le\sum_C\omega_C\rho(A,C). \tag{7}
\]

Choose any distribution `theta` on permitted anchors, and mix their finite vertex distributions. Every mixed output is legal and full rank. Its mean risk obeys

\[
\mathbb E\|Z\|^2
\le\sum_{A,C}\theta_A\omega_C\rho(A,C)
\le\max_C\sum_A\theta_A\rho(A,C).
\]

Some output in this finite distribution attains at most its mean. Therefore, defining

\[
g_k(V)=\min_{\theta\in\Delta(\mathcal A_k)}
\max_{C\in\mathcal C}\sum_A\theta_A\rho(A,C), \tag{8}
\]

there is a genuine full-rank selection with at most `d+k` rows and excess at most `g_k(V)`. The LP minimum is attained because the permitted finite anchor family and the probability simplex are finite and compact.

The program (8) is a sufficient certificate. It has **not** been identified with the selected-risk optimum. Its value depends only on the positive circuits and ranks of unions; the original selection problem also depends on metric and coefficient data discarded in (6).

#### Exhaustive enumeration of permitted anchors

Every permitted balanced support `A` can be expressed as a union of at most `nu_A` positive circuits. Its nonnegative relation cone lies in a vector space of dimension `nu_A`; conic Carathéodory writes a strictly positive relation as a nonnegative combination of at most `nu_A` extreme rays. Their supports cover `A`. Thus enumerating unions of at most `k` original circuits and retaining only those with actual nullity at most `k` enumerates every permitted support. An implementation may include dominated supersets; it must not omit a support merely because a particular circuit decomposition uses too many rays.

### 6. Transfer to ordinary weighted regression and its limits

If every nonzero-feature row has nonzero residual at the full-data optimum, the standard normalization gives (1), with `v_i=xi_i/eta_i` and `lambda_i=p_i eta_i^2`. Pure-residual rows give zero roots and are already allowed. A root training weight `w_i` corresponds to original training weight proportional to `w_i/eta_i^2`. Selected features remain full rank, so whitening does not alter a tie rule: the selected minimizer is unique.

For zero-residual nonzero-feature rows, let `H` be their feature span and choose a basis of `r` such rows. Project all other features onto `H^perp`. The projected covariance is the identity there; projected roots, including zero roots, obey (1) in dimension `d-r`. Apply an available geometric bound in that dimension and lift by a finite penalty on the `r` zero-residual rows. To check convergence explicitly, write the selected non-anchor Gram matrix in `H plus H^perp` blocks. If its quotient block is `B_EE` and the anchor Gram matrix is `A_H` positive definite on `H`, the penalized solution satisfies

\[
x_t=(tA_H+B_{HH}-B_{HE}B_{EE}^{-1}B_{EH})^{-1}
(b_H-B_{HE}B_{EE}^{-1}b_E),
\qquad
y_t=B_{EE}^{-1}(b_E-B_{EH}x_t).
\]

The Schur complement is positive semidefinite, so `x_t` tends to zero and `y_t` tends to the quotient output. Every finite `t>0` gives a positive definite full selected Gram matrix. The row count is at most `r+(d-r+k)=d+k`, and the excess converges to the quotient excess. This proves an infimum bound with arbitrary positive tolerance, not exact attainment in this branch.

If the actual observed rank is smaller than ambient `d`, first use orthonormal coordinates on the observed feature span, which preserve the original Euclidean minimum-norm rule. The original budget remains `d+k`; a universal ambient Gamma statement still requires the appropriate bound for this intrinsic rank and budget. This note does not claim that additional comparison has been proved. If full optimum loss is zero, a basis of the observed feature span reproduces the full optimum and has the same minimum-norm solution.

### 7. Exact counterexample to the proposed multi-anchor Gamma inequality

Let `d=7` and use the seven Fano lines

\[
\mathcal L=\{012,034,056,135,146,236,245\}.
\]

Every line has three points, every point lies on three lines, and two distinct lines meet in exactly one point. Take fourteen roots:

\[
v_i=e_i\quad(0\le i<7),\qquad
v_{7+j}=-\sum_{i\in L_j}e_i\quad(0\le j<7). \tag{9}
\]

A nonnegative dependence is determined by its seven coefficients `b_j` on negative roots: its coefficient on `e_i` must equal `sum_{j:i in L_j} b_j`. Hence the nonnegative relation cone is a linear image of the nonnegative orthant, with its seven extreme rays corresponding exactly to

\[
C_j=\{i:i\in L_j\}\cup\{7+j\}.
\]

These are all the positive circuits and each has rank three. A strictly balanced support consists of some negative roots indexed by `J` and exactly the positive basis roots in `U=union_{j in J}L_j`. Its rank is `|U|`, its support size is `|U|+|J|`, and its nullity is `|J|`. For `k=2`, all permitted anchors therefore use one or two lines. A two-line anchor spans five coordinate directions.

Use the uniform distribution on target circuits as a dual certificate. If the anchor covers `U`, its expected rank loss is

\[
\frac17\sum_{L\in\mathcal L}|L\setminus U|
=\frac37(7-|U|).
\]

For one line this is `12/7`; for two lines it is `6/7`. Thus every permitted anchor has expected loss at least `6/7` and `g_2(V)>=6/7`.

Conversely, choose the uniform distribution on the 21 unordered pairs of distinct lines. A fixed point is missed exactly when both lines are among the four lines not containing it, which has probability `choose(4,2)/choose(7,2)=2/7`. Each target circuit has three coordinate directions, so its expected rank loss is `3*(2/7)=6/7`. This is a primal certificate, proving

\[
g_2(V)=\frac67.
\]

The known block frontier at `(d,k)=(7,2)` is `Gamma_{7,2}=4/5` (balanced four-block dimensions `2,2,2,1`). Consequently,

\[
g_2(V)-\Gamma_{7,2}=\frac67-\frac45=\frac{2}{35}>0. \tag{10}
\]

The proposed universal bound `g_k(V)<=Gamma_{d,k}` is false. The root system can be made isotropic by an invertible whitening map; all circuit supports and ranks in (5) are unchanged, so this obstruction is within the normalized setting.

#### The symmetric dataset is explicitly cheap for regression

Use evaluation mass `3/28` on each positive root and `1/28` on each negative root, with all responses one. The mean feature vector is zero, so the full optimum is zero and its loss is one. Its evaluation Hessian is

\[
M=\frac{5I_7+\mathbf1\mathbf1^\top}{28}.
\]

Complete lines `012` and `034` using root training weights 2 on root 0 and 1 on roots `1,2,3,4,7,8`. Add roots 5 and 11 with weight one. This is a support of size nine with total weight ten. Its unique fit is

\[
t=(0,0,0,0,0,1,-1).
\]

The anchor rows evaluate to zero and their gradient weights balance exactly. Root 5 and root 11 (the negative line `146`) both evaluate to one. The anchor spans the first five coordinate directions and these two added roots complete full rank. Its excess is

\[
t^\top Mt=\frac5{14}<\frac45.
\]

Thus this finite dataset is not a counterexample to the regression conjecture. Equation (10) only rejects the rank-only multi-anchor certificate.

### 8. Exact checks and current consequence

`circuit_game.py` enumerates every positive circuit using rational nullspaces, enumerates every permitted anchor as above, solves primal and dual LPs numerically, then verifies the distributions and all payoff inequalities in rational arithmetic. Matching rational upper and lower values certify the game optimum; a solver status or floating-point match alone is not treated as proof.

The resulting exact values are:

| Root configuration | k | Certified game value | Gamma | Meaning |
|---|---:|---:|---:|---|
| Zhang rectangle, d=4 | 1 | 1 | 1 | Covers the earlier energy-dichotomy obstruction |
| Zhang connected example, d=6 | 1 | 6/5 | 3/2 | Does not make the false connectedness/excess-one claim |
| Two independent 3-dimensional simplex blocks | 1 | 3/2 | 3/2 | Sharp known block comparison |
| Three independent 2-dimensional simplex blocks | 2 | 2/3 | 2/3 | Sharp known block comparison |
| Fano roots, d=7 | 1 | 12/7 | 12/7 | Sharp for the rank-game at this budget |
| Fano roots, d=7 | 2 | 6/7 | 4/5 | Exact obstruction to the proposed sufficient inequality |

A continuation would need to retain coefficient-sensitive projected circuit information, optimize the vertex distributions using the evaluation metric, or introduce other realizable fits. None of those stronger mechanisms has been proved sufficient here. The original all-parameter Gamma target must remain marked **open / blocked on the universal upper bound**.

# 4. A sharp one-surplus-row theorem for coordinate circuit spans

### Scope

This theorem proves the conjectured one-surplus-row constant for every normalized root configuration whose **maximal positive-circuit spans** are coordinate subspaces in one common linear basis. It does not establish this structural hypothesis for arbitrary positively spanning configurations. In fact, `MATCHING_FAMILY_OBSTRUCTION.md` disproves the general `k=1` rank-game inequality. The original full Gamma target remains unresolved.

This is the permitted R1 branch of `reviews/SECONDARY_IDEA_COLLISION.md`. The max-log marginal argument is an application of classical proportional fairness / optimal-design first-order conditions, not a new optimization principle. See Kiefer–Wolfowitz (1960), DOI `10.4153/CJM-1960-030-4`, and Kelly–Maulloo–Tan (1998), DOI `10.1057/palgrave.jors.2600523`. The contribution claimed here is restricted to the exact hypergraph payoff bound and the resulting precisely defined regression subclass. Zhang’s orthogonal-block lower bound and the Liu–Wang circuit-vertex training interface remain prior results.

The transfer from the rank game to actual weighted least-squares outputs is proved in §3, local §§1–5, with zero-residual and minimum-norm caveats in its local §6. The theorem here supplies an unconditional combinatorial bound for the stated family of span configurations.

### 1. A finite hypergraph minimax theorem

Let `H` be a nonempty finite family of nonempty subsets of `[d]` whose union is `[d]`. Set

\[
g(H)=\min_{\theta\in\Delta(H)}\max_{C\in H}
\sum_{A\in H}\theta_A|C\setminus A|.
\]

Then

\[
g(H)\le\frac{\lfloor d^2/4\rfloor}{d}. \tag{1}
\]

This constant is the exact worst case over all such families.

#### Proof

Let `P=conv{1_A:A in H}` be the polytope of possible coverage marginals. Since the family covers all coordinates, the uniform distribution on all its members gives a point of `P` with every coordinate positive. Maximize

\[
f(u)=\sum_{i=1}^d\log u_i
\]

over the positive part of `P`. A maximum exists with every coordinate positive: `P` is compact, and if any coordinate tends to zero, the objective tends to minus infinity, whereas a finite feasible value is available. Coordinates equal to one cause no difficulty.

Let `u` be a maximizer. For every `C in H`, the segment from `u` to `1_C` lies in `P`. Its one-sided derivative at `u` is nonpositive, so

\[
\sum_{i\in C}\frac1{u_i}\le d. \tag{2}
\]

Write `r=|C|`. Cauchy–Schwarz gives

\[
\left(\sum_{i\in C}u_i\right)
\left(\sum_{i\in C}\frac1{u_i}\right)\ge r^2,
\qquad
\sum_{i\in C}u_i\ge\frac{r^2}{d}. \tag{3}
\]

Choose any probability distribution `theta` on `H` realizing the coverage marginals `u`. By linearity,

\[
\mathbb E_\theta|C\setminus A|
=\sum_{i\in C}(1-u_i)
\le r-\frac{r^2}{d}
=\frac{r(d-r)}d
\le\frac{\lfloor d^2/4\rfloor}{d}.
\]

The same distribution works for every `C`, proving (1). No rounding of the marginals or distribution is needed for the mathematical existence result.

For sharpness when `d>=2`, partition `[d]` into two nonempty sets of sizes `a=floor(d/2)` and `b=ceil(d/2)`, and use just these two edges. If the first anchor is chosen with probability `p`, the two target losses are `a(1-p)` and `bp`. Their minimum possible maximum is `ab/(a+b)=floor(d^2/4)/d`, attained at `p=a/d`. This proves the exact worst case. For `d=1`, the only relevant maximal edge is the full singleton and the game value is zero, consistent with the formula. \(\blacksquare\)

### 2. Consequence for positive-circuit spans

Let `V` be a normalized root configuration as in (1) of §3. Suppose its maximal positive-circuit spans are `P_A`, indexed by circuits in a finite family `M`, and there is a linear basis `b_1,...,b_d` and supports `S_A subset [d]` such that

\[
P_A=\operatorname{span}\{b_i:i\in S_A\}
\qquad(A\in M).
\]

The supports cover `[d]`, since the roots positively span `R^d` and every root belongs to a positive circuit. For two maximal spans,

\[
\rho(A,C)=\dim P_C-\dim(P_A\cap P_C)=|S_C\setminus S_A|.
\]

The hypergraph theorem supplies a distribution on these actual anchor circuits with expected rank loss at most `floor(d^2/4)/d` against every maximal circuit span.

Every other positive circuit `C` has its span contained in some maximal circuit span `P_D`, by finiteness. Orthogonal projection cannot increase rank under inclusion, so

\[
\rho(A,C)\le\rho(A,D).
\]

The same distribution therefore controls every positive circuit. The actual-selection interface yields a positive-weight full-rank selection on at most `d+1` original rows with excess at most

\[
\Gamma_{d,1}=\frac{\lfloor d^2/4\rfloor}{d}.
\]

This is an exact selected fit in the nonzero-residual normalized root case. The original-data statement, including its hypotheses for zero residuals and deficient observed rank, is given in §6 below. No unconditional preservation of the coordinate-span property under quotienting is asserted.

### 3. A broad explicit family

Consider roots consisting of a linear basis `e_1,...,e_d` and vectors

\[
-\sum_{i\in S_j}a_{ij}e_i,
\qquad a_{ij}>0,
\qquad\bigcup_j S_j=[d].
\]

Every nonnegative relation is determined by its coefficients on the negative roots. The coefficient on each positive basis root is then the corresponding nonnegative sum. The relation cone is an injective linear image of a nonnegative orthant; its extreme rays correspond exactly to one negative root together with the positive basis roots on its support. Thus the positive-circuit spans are coordinate subspaces, for arbitrary positive coefficients, arbitrary hypergraph, and arbitrary legal evaluation masses.

In matrix notation this explicit family is `[I_d,-M]`, where `M` is entrywise nonnegative, every negative column is nonzero, and every row of `M` contains a positive entry. For coefficients `(x,t)` on the positive and negative columns, respectively, the nonnegative relation cone is exactly

\[
\{(x,t)\ge0:x-Mt=0\}
=\{(Mt,t):t\ge0\}.
\]

The map from `t` is injective. It identifies extreme rays with individual coordinate rays of the nonnegative orthant. This proves the complete circuit description, including arbitrary unequal positive entries of `M`, not merely zero-one incidence columns. Repeated negative columns do not change the argument. An optional zero root gives a rank-zero circuit and does not affect maximal spans.

Common invertible coordinate transformations and individual positive root rescalings preserve the circuit supports, their ranks, and the common-coordinate-span property. The transformation need not be orthogonal. Consequently the same conclusion applies to their whitened realizations. This contains the rectangle, simplex-block, and Fano-hypergraph configurations, but not every positively spanning root system has this form.

The word **roots** is essential: the condition concerns the residual/projective roots calculated from the full-data optimum, not just the raw feature matrix. An arbitrary change of evaluation weights or responses can change that optimum and reverse residual signs. No assertion is made that a fixed raw feature matrix of the form `[I,-M]` satisfies the theorem for every response vector without checking its resulting residual roots.

### 4. Why a log-determinant substitution does not prove the general case

For arbitrary subspaces, one may be tempted to replace coverage marginals by `M=sum_A theta_A Pi_A`, maximize `log det M`, and use first-order trace inequalities. Those inequalities control quantities involving `tr(Pi_A Pi_C)`. The required payoff involves `dim(P_A intersect P_C)`.

For orthogonal projectors,

\[
\operatorname{tr}(\Pi_A\Pi_C)\ge\dim(P_A\cap P_C),
\]

with strict inequality when nonzero non-right principal angles occur. The resulting trace overlap gives a lower bound on the rank loss, in the wrong direction for the desired upper bound. Literal orthonormal-coordinate projections have equality, but the present theorem does **not** assume that the original Euclidean projectors commute: its common basis may be nonorthogonal. Its proof uses the invariant linear-algebra identity `dim(P_A intersect P_C)=|S_A intersect S_C|`, not a trace identity in the original metric. A proof for arbitrary positive circuits must use further structure or another realizable selection mechanism; the determinant calculation alone leaves a gap.

### 5. Multi-anchor obstruction remains

The one-anchor theorem does not extend by replacing one random edge with an arbitrary budget of `k` edges and asserting the full Gamma frontier. The Fano example in §3, local §7, is already a coordinate-span configuration, but its two-anchor game is `6/7`, strictly above `Gamma_{7,2}=4/5`. Thus the one-anchor entropy argument identifies a valid subcase without removing the exact obstruction to the coarse multi-anchor method.

### 6. Exact original-data scope

Let `D={(x_i,y_i,p_i)}` be any finite real scalar-response regression dataset, with `p_i>0` and `sum p_i=1`, in ambient dimension `d>=2`. Evaluation always uses these fixed original weights. Let `m` be its observed feature rank. Its full-data learner and selected learner both use the Euclidean minimum-norm least-squares convention. The selection budget is at most `d+1` effective positive-weight rows.

If the optimal loss is zero, a basis of the observed feature span reproduces the full optimum. The selected and full minimum-norm solutions coincide because they have the same feature span. If `m=0`, predictions are identically zero and every selection has the same evaluation loss. Both cases have ratio one under the stated zero-loss conventions.

Suppose now `m>0` and `L*>0`. First use an orthonormal basis of the observed feature span, preserving the original Euclidean minimum-norm rule. In these `m` coordinates put

\[
H=\sum_i p_i x_i x_i^\top,\quad
\xi_i=H^{-1/2}x_i,\quad
\eta_i=(y_i-x_i^\top w^*)/\sqrt{L^*},\quad
z=H^{1/2}(w-w^*)/\sqrt{L^*}.
\]

Then

\[
\sum_i p_i\xi_i\xi_i^\top=I_m,\quad
\sum_i p_i\eta_i\xi_i=0,\quad
\sum_i p_i\eta_i^2=1,\quad
L_D(w)/L^*=1+\|z\|^2. \tag{4}
\]

#### No featureful zero-residual rows

Assume `eta_i=0` implies `xi_i=0`. Rows with both entries zero may be removed; pure-residual rows remain. For every remaining row let

\[
v_i=\xi_i/\eta_i,\qquad\lambda_i=p_i\eta_i^2.
\]

These roots and probabilities satisfy the centered isotropic identities. If their maximal positive-circuit spans admit a common coordinate basis, §§1–2 supply a strictly positive full-rank root objective on at most `m+1` rows with excess at most

\[
c_m=\frac{\lfloor m^2/4\rfloor}{m},\qquad c_1=0.
\]

A root training weight `w_i` becomes original training weight proportional to `w_i/eta_i^2`. This uses no change to the evaluation probabilities `p_i`. The selected features span the entire observed feature span, so the selected minimizer there is unique; extension back to the ambient space uses the same minimum-norm convention. The number of selected rows is at most `m+1<=d+1`.

For `m=2q`, `c_m=q/2`; for `m=2q+1`, `c_m=q(q+1)/(2q+1)`. Direct subtraction shows these values increase with `m`. Thus the selected original-data risk is at most `1+c_m<=1+c_d`.

This quantifies over arbitrary original positive evaluation weights and arbitrary responses **subject to the stated residual-root structure**. It neither reweights the evaluation loss nor asserts that the structure is invariant under arbitrary changes of those inputs.

#### Featureful zero-residual rows

Let `Z=span{xi_i:eta_i=0}` and `z_0=dim Z`. Choose `z_0` independent zero-residual rows. Let `Q` be orthogonal projection onto `Z^perp`, whose dimension is `m'=m-z_0`. If `m'=0`, the zero-residual basis recovers the full optimum exactly.

Otherwise impose the following explicit additional hypothesis: the maximal positive-circuit spans of the projected roots

\[
\widetilde v_i=Q\xi_i/\eta_i\quad(\eta_i\ne0),
\qquad\lambda_i=p_i\eta_i^2,
\]

are simultaneously coordinate in a common basis of `Z^perp`. Zero projected roots are retained. The weights sum to one, the roots are centered, and their second moment is the identity on `Z^perp`; this follows by projecting (4), since zero-residual features project to zero.

Apply the theorem in dimension `m'`, then use the full-rank finite-penalty lifting proved in §3, local §6. The lifted support has at most `z_0+(m'+1)=m+1<=d+1` rows, and its original-data excess approaches at most `c_{m'}`. Thus the selected-risk infimum is at most `1+c_{m'}<=1+c_d`.

The hypothesis is on the **projected** system. Common coordinate spans before projection are not assumed automatically to remain common coordinate spans afterward. This restriction is part of the theorem, not a technicality that has been omitted from its claim.

### 7. Sharp minimax value within this regression subclass

The upper bound above is sharp for the subclass already with full observed rank, no zero residuals, positive rational evaluation weights, and the explicit `[I,-M]` form. The lower construction is the known two-simplex-block example from Zhang (arXiv:2608.28007v2, Appendices C–D) / Liu–Wang (arXiv:2610.00101, Appendix D); it is included to verify that the present subclass and the original minimum-norm rule meet the same sharp bound, not claimed as a new lower-bound construction.

Put `a=floor(d/2)`, `b=ceil(d/2)`, and split the coordinates orthogonally into dimensions `a` and `b`. In a block of dimension `r`, use its `r` standard basis vectors and their negative sum, so the block has `r+1` feature rows. Give the first block total evaluation mass `ell_a=b/d`, the second `ell_b=a/d`, equally divided among the rows within each block. Their feature means vanish separately.

Choose a vector `h` outside every proper span of a subset of these finitely many feature rows. Such a vector exists because a finite union of proper linear subspaces cannot cover `R^d`; with rational feature rows one may choose `h` rational. For a sufficiently large finite `T>0`, set all labels to

\[
y_i=x_i^\top(Th)+1.
\]

The full optimum is `w*=Th`, every residual is one, and `L*=1`. The evaluation Hessian is positive definite and block diagonal; in a block of dimension `r` and mass `ell`, it is `ell(I_r+11^T)/(r+1)`.

A full-rank selected support must retain at least `r` independent rows in each block. If exactly `r` are retained, they form a basis facet and interpolate their labels uniquely, regardless of their positive training weights. Every such facet has block excess `r ell`: deleting the negative-sum row gives displacement `1`; deleting the j-th basis row gives displacement 1 in the other coordinates and `-r` in coordinate j. In both cases the stated Hessian gives excess `r ell`.

At budget `d+1`, at most one of the two blocks can be complete. Hence every full-rank selection has excess at least

\[
\min\{a\ell_a,b\ell_b\}=ab/d=c_d.
\]

Completing one block with its balanced weights and retaining a basis facet in the other attains this value with exactly `d+1` rows.

For a deficient support `S`, its selected minimum-norm output lies in its proper feature span `U_S`, for every choice of positive training weights. Let `dist_H` be distance in the positive definite evaluation metric. The finite set of deficient supports satisfies

\[
\sigma=\min_{S\text{ deficient}}\operatorname{dist}_H(h,U_S)>0.
\]

Its original evaluation excess is therefore at least `T^2 sigma^2`. Choose a finite `T` with `T^2 sigma^2>c_d`. Every deficient selection is then worse than the attaining full-rank selection. This proves the exact original-data optimum, over **all** allowed supports and nonnegative weights, is `1+c_d`.

The full-data residuals remain one after translation. Thus the residual roots are a common invertible whitening of `[I,-M]`, with two disjoint negative-support columns, and belong to the claimed subclass. Consequently its minimax selected-risk ratio at budget `d+1` is exactly `1+floor(d^2/4)/d`.

### References and novelty boundary

- J. Kiefer and J. Wolfowitz, *The Equivalence of Two Extremum Problems*, Canadian Journal of Mathematics 12 (1960), 363–366. https://doi.org/10.4153/CJM-1960-030-4 . The log-determinant directional optimality mechanism is classical.
- F. P. Kelly, A. K. Maulloo, D. K. H. Tan, *Rate control for communication networks: shadow prices, proportional fairness and stability*, JORS 49 (1998), 237–252. https://doi.org/10.1057/palgrave.jors.2600523 . Sum-log maximization and proportional-fair first-order inequalities are classical.
- G. Zhang, *Exact Risk Ratios for Weighted Data Selection in Linear Regression*, arXiv:2608.28007v2. https://arxiv.org/html/2608.28007v2 . The simplex-block lower frontier and minimum-norm translation device are prior results.
- Z. Liu and H. Wang, *Weighted Data Selection: Sharp Upper-Half and Five-Dimensional Laws*, arXiv:2610.00101. https://arxiv.org/abs/2610.00101 . The realizable circuit-vertex mechanism is the direct starting point.

The exact unrestricted Gamma conjecture is not proved here. This theorem gives a sharp, explicitly delimited one-budget regression subclass and must be assessed at that scope.

# 5. Noncoordinate matching roots and coefficient-sensitive recovery

### Status

This note belongs to the permitted R3 branch of the single secondary research cycle, following `reviews/SECONDARY_IDEA_COLLISION.md`. It establishes three precise statements:

1. A seven-dimensional family has one-anchor rank-game value exactly `2`, above the conjectured regression excess `Gamma_{7,1}=12/7`.
2. Its maximal positive-circuit spans cannot all be coordinate subspaces in one common linear basis.
3. Keeping projected circuit coefficients recovers a genuine eight-row regression excess bound `6 tau/(4 tau+1)<3/2<12/7`, uniformly over the stated positive scale `tau` and every compatible positive evaluation measure.

The first two statements reject auxiliary proof mechanisms. They are not regression counterexamples. The third is a proved bound for one explicit noncoordinate family, not a solution of the full Gamma conjecture. The bound is not claimed sharp.

The construction extends the shared-root matching configuration used in Liu–Wang, arXiv:2610.00101, Appendix B.3, from three leaves in each circuit to four. The underlying circuit-vertex moment interface is from that source and is fully rederived in §3. No claim is made that the sum-log principle, positive-circuit decomposition, or the rank-game abstraction by itself is a high-value resolution of the original problem.

### 1. The root family

Work in `R^7` with independent vectors

\[
u,a_0,a_1,a_2,b_0,b_1,b_2.
\]

Define

\[
a_3=-u-a_0-a_1-a_2,\qquad
b_3=-u-b_0-b_1-b_2,\qquad
h_i=-2u-a_i-b_i\quad(0\le i<4).
\]

For `tau>0`, the thirteen roots, in the order used by the certificate script, are

\[
V_\tau=(\tau u,a_0,a_1,a_2,a_3,b_0,b_1,b_2,b_3,h_0,h_1,h_2,h_3). \tag{1}
\]

Only the shared root is rescaled. Arbitrary independent rescalings of every row are **not** included in the uniform risk bound below.

The following positive relations will be denoted `A,B,H,C_0,...,C_3`:

\[
\begin{aligned}
A:&\quad \tau^{-1}(\tau u)+\sum_i a_i=0,\\
B:&\quad \tau^{-1}(\tau u)+\sum_i b_i=0,\\
H:&\quad 6\tau^{-1}(\tau u)+\sum_i h_i=0,\\
C_i:&\quad 2\tau^{-1}(\tau u)+a_i+b_i+h_i=0.
\end{aligned} \tag{2}
\]

The first three have rank four. Each `C_i` has rank three.

### 2. Completeness of the positive-circuit list

Consider any nonnegative zero relation, with coefficient `gamma` on `tau u`, coefficients `alpha_i` on `a_i`, `beta_i` on `b_i`, and `eta_i` on `h_i`. Resolving the independent `a_0,a_1,a_2` and `b_0,b_1,b_2` coordinates shows that there are real numbers `t,s` such that

\[
\alpha_i=\eta_i+t,\qquad
\beta_i=\eta_i+s\qquad(0\le i<4),
\]

and resolving the `u` coordinate gives

\[
\tau\gamma=t+s+2\sum_i\eta_i. \tag{3}
\]

Put `m=min_i eta_i`, `delta_i=eta_i-m`, `t'=t+m`, and `s'=s+m`. Nonnegativity of all original coefficients implies `m,delta_i,t',s'` are nonnegative. Equation (3) becomes

\[
\tau\gamma=t'+s'+2\sum_i\delta_i+6m.
\]

Therefore the original relation is exactly the nonnegative combination

\[
t'A+s'B+mH+\sum_i\delta_i C_i. \tag{4}
\]

Each of the seven listed relations is itself support-minimal. For `A` and `B` this follows from the specified independent coordinate vectors. For `H`, its span is

\[
\operatorname{span}(u,a_0+b_0,a_1+b_1,a_2+b_2),
\]

of dimension four, while its support has five elements and its unique dependence is strictly positive. For `C_i`, the three vectors `u,a_i,b_i` are independent and `h_i` is their stated negative combination. Thus each listed support has one-dimensional kernel and strictly positive coefficients, so no proper support carries a nonzero nonnegative relation.

Equation (4) proves that the nonnegative relation cone is generated by these seven minimal rays. They are all its extreme rays and hence **all** positive circuits of (1). This is an analytic completeness proof; the numerical LP does not supply it.

### 3. Span geometry and the exact one-anchor game

The three large spans have dimension four and intersect pairwise in the same line `Ru`. The cross span is

\[
P_i=\operatorname{span}(u,a_i,b_i).
\]

Its intersection with each large span has dimension two: respectively `span(u,a_i)`, `span(u,b_i)`, and `span(u,a_i+b_i)`. Two distinct cross spans intersect only in `Ru`, because the corresponding distinct leaf directions are independent in each of the two three-dimensional quotient blocks.

Write `rho(X,Y)=dim P_Y-dim(P_X intersect P_Y)`, with the anchor indexing rows and the target circuit indexing columns. In the order `A,B,H,C_0,C_1,C_2,C_3`, the matrix is

\[
R=\begin{pmatrix}
0&3&3&1&1&1&1\\
3&0&3&1&1&1&1\\
3&3&0&1&1&1&1\\
2&2&2&0&2&2&2\\
2&2&2&2&0&2&2\\
2&2&2&2&2&0&2\\
2&2&2&2&2&2&0
\end{pmatrix}. \tag{5}
\]

For surplus one, every nonzero balanced support of nullity at most one is a positive circuit. Thus (5) includes every permitted nontrivial one-anchor support. The empty anchor, if allowed, is dominated by nonempty ones and does not improve the value.

Choose the uniform distribution on `A,B,H` for the anchor. Its payoff is 2 against each large target and 1 against each cross target, proving an upper bound 2. Choose the same uniform distribution for the target. Every large anchor has expected payoff 2, and every cross anchor also has expected payoff 2, proving the matching lower bound. Hence

\[
g_1(V_\tau)=2\quad\text{for every }\tau>0,
\qquad
g_1(V_\tau)-\Gamma_{7,1}=2-\frac{12}{7}=\frac27. \tag{6}
\]

This disproves the proposed universal **rank-game** inequality even at surplus one. It does not disprove the original selected-risk inequality: the rank-game theorem supplies an upper certificate, not an exact risk formula.

### 4. Why the common-coordinate subclass does not cover this family

All three large circuit spans are maximal among positive-circuit spans: they have dimension four, are distinct, and the only remaining circuits have rank three. If they were coordinate subspaces in one common basis, their common intersection `Ru` would also be a coordinate subspace.

Quotient by that common coordinate line. The ambient quotient has dimension six. The three large spans become three three-dimensional coordinate subspaces with pairwise zero intersection. Their coordinate supports would then be pairwise disjoint, requiring nine coordinate directions in a six-dimensional space. This is impossible.

Thus the common-coordinate theorem has a strict structural restriction. The present counterexample is already in dimension seven and is independent of the separate Petersen-graph obstruction. Neither obstruction justifies any conclusion against the actual Gamma risk conjecture.

### 5. A coefficient-sensitive projected-circuit cost

For a general balanced anchor `X` and an original positive circuit `C`, normalize its coefficients `beta^C` to sum to one. Project its roots onto `P_X^perp`. Let `alpha^D` range over the normalized positive circuits of this projected configuration, including singleton zero projected roots with rank zero. Define the finite linear program

\[
\phi(X,C)=\min\left\{
\sum_D t_D\operatorname{rank}(D):
t_D\ge0,\quad
\sum_Dt_D\alpha^D=\beta^C
\right\}. \tag{7}
\]

The coefficient equality implies `sum_D t_D=1`. Feasibility follows from positive-circuit decomposition. The objective is attained on the compact feasible coefficient polytope; variables with identical circuits can be identified if needed.

The proof in §3, local §4, before its last relaxation gives, for every mean-zero polar-vertex distribution belonging to anchor `X`,

\[
\mathbb E\sum_{i\in C}\beta_i^C(v_i^\top Z_X)^2\le\phi(X,C).
\]

This remains true when projected roots vanish. Their original coefficient mass becomes mass on rank-zero singleton circuits and is not discarded or renormalized away. Consequently any distribution `theta` on actual anchors gives an admissible full-rank selected output with excess at most

\[
\max_C\sum_X\theta_X\phi(X,C). \tag{8}
\]

Equation (8) is a coefficient-sensitive sufficient interface. No universal sharp Gamma bound for (8) is claimed. In the following family, explicit decompositions in (7) suffice; it is unnecessary to claim that an approximate LP solve is globally exact.

### 6. A uniform original-risk bound on the noncoordinate family

Take any positive evaluation probabilities `lambda` on (1) with total one and zero mean, and let

\[
M=\sum_i\lambda_i v_i v_i^\top.
\]

The matrix is positive definite because the roots span and every weight is positive. Apply common whitening `M^{-1/2}`. This preserves all positive-relation coefficients and quotient ranks, so the following calculation applies to the whitened root system without changing the original evaluation measure.

Choose the four cross anchors `C_i` with probability `1/4`. Their rank is three and each support has four rows, so a vertex construction uses `4+(7-3)=8` rows and is full rank.

#### A large target of type A or B

In the quotient by `P_i`, the shared root and the matching leaf vanish. The three remaining A leaves are a rank-two positive circuit, with equal coefficients. In the normalized original A circuit, each leaf has mass

\[
\frac1{4+1/\tau}.
\]

The nonzero projected circuit therefore has total mass `3/(4+1/tau)`, and its coefficient cost is

\[
c_A(\tau)=c_B(\tau)=\frac6{4+1/\tau}=\frac{6\tau}{4\tau+1}. \tag{9}
\]

The coefficients on the two vanished roots contribute zero rank cost. This formula holds for every cross anchor.

#### The large target H

Its shared-root coefficient before normalization is `6/tau`, and each leaf coefficient is one. The matching `h_i` and the shared root vanish under the cross anchor; the other three H leaves form a rank-two positive circuit. Thus

\[
c_H(\tau)=\frac6{4+6/\tau}=\frac{6\tau}{4\tau+6}. \tag{10}
\]

#### A cross target

If the anchor is the same cross circuit, its cost is zero. Under any of the other three cross anchors the shared root vanishes, while the remaining three roots form a rank-two positive circuit. Their original normalized masses are each `1/(3+2/tau)`. Averaging over the four anchors gives

\[
\overline c_C(\tau)=\frac34\frac6{3+2/\tau}
=\frac{9\tau}{2(3\tau+2)}. \tag{11}
\]

All the stated projected ranks are exactly two, by the intersections in §3. A further degeneracy would only lower this particular upper bound, but none is needed for the present argument.

The type-A/B cost dominates the other two costs. Explicitly,

\[
c_A-c_H=\frac{30\tau}{(4\tau+1)(4\tau+6)}>0,
\qquad
c_A-\overline c_C=\frac{15\tau}{(4\tau+1)(6\tau+4)}>0.
\]

Every centered evaluation measure decomposes into the seven complete original circuits proved in §2. Therefore (8) yields an actual positive-weight full-rank selection of at most eight rows with

\[
\boxed{\quad
\text{excess}\le\frac{6\tau}{4\tau+1}
<\frac32<\frac{12}{7}=\Gamma_{7,1}
\quad(\tau>0).\quad} \tag{12}
\]

The strict first comparison follows from `3/2-6 tau/(4 tau+1)=3/[2(4 tau+1)]`. The upper bound approaches `3/2` as `tau` tends to infinity. This is a limiting value of the proved bound, not a claim that the optimal regression excess approaches it.

#### Exact scope of the evaluation-measure claim

The probabilities `lambda` above are arbitrary positive **centered root probabilities**. Equivalently, the result applies to any ordinary regression dataset whose normalized residual roots, after a common invertible transformation, are exactly the displayed family with its one shared-root scale, and whose original evaluation measure induces those probabilities. Root training weights convert to original training weights by division by squared residuals. Their selected span is full, so the minimum-norm rule introduces no ambiguity.

It is not a statement that every response vector on a fixed raw feature design yields this residual-root family. Nor is it a uniform claim under arbitrary independent root rescalings. The original evaluation weights are never changed during the proof.

### 7. A small original-data witness and exact verification

At `tau=1`, take all responses one and evaluation weights `2/5` on `u`, `1/20` on each of the other twelve roots. They sum to one and have zero feature mean, so the full optimum is zero and its loss is one.

Select the five A-circuit roots and the three additional roots `b_0,b_1,h_2`, with equal positive training weights. Its unique fit in the independent coordinates is

\[
t=(0,0,0,0,1,1,-1).
\]

The A roots evaluate to zero and their training gradients balance. The three additional roots interpolate one. The support has rank seven and size eight. All B leaves and H leaves evaluate to plus or minus one, while the A leaves and shared root evaluate to zero, so its exact excess is `8/20=2/5`. This is an explicit check that the auxiliary game value 2 is not an original-data lower bound.

From the [evidence directory](evidence/), where the verifier and archived result paths are rooted, run:

```bash
python code/verify_all.py --only matching-projection
```

The underlying checker verifies the symbolic positive relations, the cone parametrization identity, exact ranks, the rank-game primal and dual certificates, every projected three-root circuit, the rational cost formulas and strict-gap identities, and the original-data witness. The unified verifier checks the saved certificate in that directory. These exact algebraic checks supplement the analytic completeness and positivity proofs; they are not reported as a proof assistant formalization.

### 8. Consequence for the research target

The rank-only game fails both for Fano multi-anchors and for the present single-anchor family. The coefficient-sensitive interface repairs the latter uniformly over an entire stated family. The common-coordinate theorem covers a different broad subclass and is sharp there. Their union does not exhaust arbitrary positively spanning root configurations, so none of these results closes the original all-parameter Gamma conjecture.

# 6. Independent finite diagnostics and a four-parameter constructive theorem

本简报绑定原完整 Gamma 目标，仅记录二次门禁允许后的结构诊断与定向真实风险验证。**没有新的 Gamma 反例，也没有完成一般 `k=1` 或完整剩余前沿。** 初轮大规模数值扫描没有继续扩大。

### 1. Petersen：共同坐标化假说失败，但 g1 仍很小

对 Petersen 图每条边取双向弧、构造 incidence 根并删除一个坐标，得到 `9 x 30` 整数矩阵。全一向量是严格正核向量，九个基列行列式非零，故正张成九维空间。

全部正回路恰为有向简单回路。DFS 列举与独立顶点子集动态规划计数一致：共129条，长度分布为

| 长度 | 2 | 5 | 6 | 8 | 9 | 10 |
|---|---:|---:|---:|---:|---:|---:|
| 正回路数 | 15 | 24 | 20 | 30 | 40 | 0 |

每个被删顶点都有九回路，因此极大正回路跨度恰为十个不同的八维超平面。其法向是九个标准基向量和全一向量。九维空间在一个固定基下只有九个坐标超平面，故这些极大跨度不能共同坐标化。**没有声称维数最小。**

在十个缺点超平面锚上各取 `1/10` 概率，对目标回路 `C` 的期望秩损失为 `|C|/10<=9/10`。对同样十个目标均匀取权，任意锚回路 `A` 的期望损失为 `9(10-|A|)/10>=9/10`。两边给出精确 primal/dual 证书：

\[
g_1=9/10<\Gamma_{9,1}=20/9.
\]

参见附录 A、[验证程序](evidence/code/computation/petersen_span_obstruction.py)及[精确证书](evidence/results/computation/petersen_span_certificate.json)。JSON 给出完整矩阵、全部129回路、十个极大跨度与全部锚/目标的有理 game 证书。独立 `verify` 已通过。Petersen 的 hypohamiltonian 性属于经典图论，来源为 [Aldred–McKay–Wormald (1997), p.143](https://combinatorialpress.com/article/jcmcc/Volume%20023/vol-23-paper%2012.pdf)；incidence 正张成对应已有 [Cornaz–Kerleau–Royer, §3.2](https://arxiv.org/abs/2411.08994)。本记录的作用是准确阻断候选结构桥梁，不能作为原风险猜想的反例或完成证据。

### 2. Matching tetrahedra：canonical 真实风险超额仅 2/5

采用[确切几何数据](evidence/results/geometry/matching_tetrahedra_d7.json)的十三个根。顺序依次为 $u$、$a_0,\ldots,a_3$、$b_0,\ldots,b_3$ 及 $h_0,\ldots,h_3$，其中

\[
u+\sum_i a_i=0,\quad u+\sum_i b_i=0,\quad
h_i=-2u-a_i-b_i.
\]

几何支线给出的单锚 game 为 `2>Gamma(7,1)=12/7`。为验证这是否威胁原始风险，先取特征恰为上述根、标签均为1、固定评估质量比例

\[
(8,1,\ldots,1),\qquad S=20.
\]

其正平衡保证完整最优点为零，完整最优风险为1。选择支持

\[
\{0,1,2,3,4,5,10,11\},
\]

八个训练权均取1，得到唯一最小二乘输出

\[
q=(0,0,0,0,1,-1,-1).
\]

前五行在 `q` 处评价为零且梯度之和为零，新增三行各自恰插值；选中特征秩为7。完整评估超额是

\[
q^THq=\frac8{20}=\frac25<\frac{12}{7},
\]

故这个 canonical 数据的完整风险比至多 `7/5`。该见证满秩，已避开最小范数 tie breaking 的问题；无需大位移，也不需要证明所有1287个支持的最优值。

这里实际还可作更强但平凡的判断：未平移的中心根数据只需选择任一正回路并用平衡权，其最小范数训练输出就是零，所以该 canonical 数据在原问题中的最优风险比恰为1。`2/5` 的意义仅在于提供显式满秩输出；满秩性使下述任意标签平移仍保持同一超额，而不能把它解释成该未平移数据的最优超额。

### 3. 仅20个定向实例的逐行缩放检验

`matching_risk_witnesses.py` 只检查针对新障碍的20个明确实例：canonical、A/B/H 等回路混合的固定根评价、6个不等三群质量排列、12个单行质量/根缩放扰动。每个实例在420个合法“正回路锚加独立插值行”中挑选一个，再用有理数独立解输出并检验正权正常方程、秩7和完整评价风险。

全部20个实例都有严格低于 `12/7` 的有理可行见证。最高见证为 `2/5`；六个群参数排列的见证均为 `51/464`；十二个逐行扰动的见证均不超过 `10/57`。原始质量、逐行根缩放、支持、正训练权、输出和精确风险都保存在 `matching_risk_witnesses.json`。

这里报告的每个数都是一个**合法输出的上界见证**，不是该数据的最优风险值。没有覆盖全部质量/行缩放，没有证明整个 matching 族的一般风险定理，也没有将辅助 game 值2当成原风险下界。若未来出现所有已知见证均较差的参数，仍必须完整处理全部1287个预算8支持及秩亏 minnorm 输出，才能声称原问题反例。

### 4. 附加四参数子族的可行上界

以下解析结果仅针对固定梯度列比例 `(8,1,...,1)`。令正评估质量为

\[
(c_u,c_a,c_a,c_a,c_a,c_b,c_b,c_b,c_b,c_h,c_h,c_h,c_h),
\quad S=c_u+4(c_a+c_b+c_h),
\]

相应特征分别为 `8u/c_u,a_i/c_a,b_i/c_b,h_i/c_h`，标签1。所有参数严格正，评估平衡保持不变。这包括群尺度变化，但不等于任意正核权或任意逐行缩放族。

更具体地，令 `p_i=c_i/S`，则

\[
\sum_i p_i x_i=S^{-1}(8u+\sum_i a_i+\sum_i b_i+\sum_i h_i)=0.
\]

全部特征包含 `u,a_0,a_1,a_2,b_0,b_1,b_2` 的非零缩放，因此完整协方差正定，完整最优点为零、最优风险为一。风险可写成 `1+q^THq`，其中

\[
H=\frac1S\left(\frac{64}{c_u}uu^T+
\frac1{c_a}\sum_i a_ia_i^T+
\frac1{c_b}\sum_i b_ib_i^T+
\frac1{c_h}\sum_i h_ih_i^T\right).
\]

#### 从锚与插值到真实最小二乘输出

锚 A 的五行是 `u,a_0,...,a_3`。取训练权 `c_u/8,c_a,c_a,c_a,c_a`，则这些权乘对应特征的向量之和为 `u+sum a_i=0`。在其共同零评价空间，`q^Tu=q^Ta_i=0`，从而 `q^Th_i=-q^Tb_i` 且 `sum_i q^Tb_i=0`。余下维数为三。

对前三个指标 `i=0,1,2`，其中 `m` 个选 B 行，其余选 H 行，并令这些行精确插值标签1。它们的约束是 `q^Tb_i=c_b` 或 `q^Tb_i=-c_h`；三个方向在商空间独立。锚约束加这三个约束唯一确定 `q`。给新增三行任意严格正训练权，例如都取1。锚行残差均为 `-1`，新增行残差为0，所以全部训练正常方程严格满足

\[
\sum_{i\in S_{\mathrm{selected}}}\alpha_i x_i(x_i^Tq-1)
=-\left(u+\sum_i a_i\right)+0=0.
\]

所选五锚行张成四维，另三行在商空间独立，故八行满秩七，正权 Gram 矩阵正定。这个 `q` 因而是唯一加权最小二乘输出，也就是规定的最小范数输出，不存在 tie breaking 缺口。

锚 B 采用权 `c_u/8,c_b,c_b,c_b,c_b`，交换 A 与 B 得同样结论。锚 H 则采用权 `3c_u/4,c_h,c_h,c_h,c_h`，因为 `6u+sum h_i=0`；在其共同零评价空间有 `q^Tb_i=-q^Ta_i`，于是从 A/B 行选择三个独立插值方向。三种情形都选恰好八行且满秩，不依赖极限权重。

锚住大回路 A 后，剩余商空间中的 B/H 根是互为相反方向的四点三维单纯形。选三条独立方向，其中 `m` 条来自 B、`3-m` 条来自 H，则它们可以精确插值。四个 B 方向的取值分别为 `m` 个 `x=c_b`、`3-m` 个 `-y=-c_h`，以及其和的相反数，故相应可行超额为 `J(x,y)/S`，其中

\[
J(x,y)=\left(\frac1x+\frac1y\right)
\min_{m=0,1,2,3}\left[mx^2+(3-m)y^2+(mx-(3-m)y)^2\right].
\]

这里的因子 `1/x+1/y` 来自完整评价协方差在该商空间上的 B/H 两组项，而非重新选择评价权。令括号内多项式为 `Q_m(x,y)`，四个覆盖所有正参数的分支为：

| 参数区间 | 选择 m | `Q_m-4xy` 的精确因式分解 |
|---|---:|---|
| `0<x<=y/3` | 3 | `4x(3x-y)<=0` |
| `y/3<=x<=y` | 2 | `2(3x-y)(x-y)<=0` |
| `y<=x<=3y` | 1 | `2(x-y)(x-3y)<=0` |
| `3y<=x` | 0 | `4y(3y-x)<=0` |

因此 `min_m Q_m<=4xy`，进而 `J(x,y)<=4(x+y)`。

分别锚 A、B、H 后的三个上界对应质量对 `(c_b,c_h)`、`(c_a,c_h)`、`(c_a,c_b)`。取其中最小者，得到真实可行选择

\[
\Delta\le\frac{4\min\{c_a+c_b,c_a+c_h,c_b+c_h\}}S
\le\frac{8(c_a+c_b+c_h)}{3S}<\frac23<\frac{12}{7}.
\]

每次锚有5行，另加3个独立插值行，合计8行且满秩。这是本四参数子族的明确上界；不能无条件推广到其余行尺度或用来替代原完整 Gamma 目标。canonical 参数给出 `2/5` 的同一上界，与精确见证一致。

若要求直接表示成原始等权有限数据，对每行取 `tilde_x_i=sqrt(13p_i)x_i`、`tilde_y_i=sqrt(13p_i)`。十三行等权全数据损失恰为上述固定评价风险；训练权相应取 `alpha_i/(13p_i)` 再归一化，保持同一唯一输出。因此这一上界并不依赖允许修改评估测度。

**任意平移的推论。** 对任意固定 `a in R^7`，保持特征与评价质量不变，将标签改为 `y_i=1+x_i^T a`。完整最优点变为 `a`，完整最优损失仍为1。每一个上述满秩选择的唯一训练输出变为 `a+q`：代入后所有训练残差、正常方程和评价超额都与原构造相同。因此同一 `<2/3` 上界对四个正质量参数和任意平移 `a` 一致成立；等权行转换时相应缩放整个新标签即可。秩亏回路在一般平移下不具有这种唯一输出的平移性质，不能由未平移的零解推出这个结论。此推论仍只给出上界，不声称该族的最优风险分类或尖锐性。

`matching_symbolic_certificate.py` 与 `matching_four_parameter_symbolic.json` 对三类锚乘四个 `m` 的全部十二个分支，分别保存并核验符号输出、正训练权、残差、零正常方程、非零七阶特征子式和精确风险公式；还保存四个标量因式分解及 `2/3-bound=2c_u/(3S)>0`。这是符号代数证书，不声称已完成 Lean 形式化。

### 复现

在[复现资料目录](evidence/)运行：

```bash
python code/verify_all.py --only petersen --only matching-witnesses --only matching-symbolic
```

全部新证书只在有理数/整数核验通过后标注为精确。二次诊断仍然支持“主目标未解决”的状态。

# 7. Orthogonal budget allocation for the original learner

Partition the data into nonempty blocks \(D_j\) whose feature rows lie in pairwise orthogonal linear subspaces \(U_j\). Retain the original evaluation probabilities when defining the contribution \(L_j\) of block \(j\) to the full loss. Put \(F_j(0)=L_j(0)\). For \(b\ge1\), let \(F_j(b)\) be the infimum of \(L_j\) over nonempty supports of size at most \(b\) in that block, using free positive training weights and the Euclidean minimum-norm tie rule. For \(n\ge1\) the optimal full-data loss is
\[
 \min_{\substack{0\le b_j\le |D_j|,\ b_j\in\mathbb Z\\1\le\sum_j b_j\le n}}
 \sum_j F_j(b_j).
\]

Decompose \(w=w_\perp+\sum_j w_j\) by orthogonal projection onto the block subspaces. Each training or evaluation term depends only on its block's projection. In a block with positive total training weight, normalizing that weight within the block leaves its minimizer set unchanged. The full minimizer set is the product of the block minimizer sets and the unconstrained orthogonal complement. Its minimum-norm point consists of the block minimum-norm points, with zero in unselected blocks and the orthogonal complement. Thus actual support sizes give the lower bound by their sum of block infima. Conversely, take selections approaching each block infimum in any allowed allocation. Assign each selected block a strictly positive share of training weight and merge. This proves the reverse bound even with unattained block infima. The finite minimum is an integer budget convolution.

Zhang's Theorem G.4 treats strictly convex selections of at least local rank, with label shifts to enforce that restriction. This formula applies directly to the unshifted labels, to budgets below the local observation rank, and to unselected blocks. Orthogonality matters: with feature rows \((1,0)\) and \((1,1)\) in separate subspaces, selecting only the first row with label one gives \(w=(1,0)\), whose prediction on the second row is one. [Zhang v2, Theorem G.4](https://arxiv.org/html/2608.28007v2#A7.SS4)

# 8. Attainment, finite representatives and algebraic decision

**Theorem.** For each pair of integers \(d\ge1\) and \(n\ge d\), the outer supremum defining \(F_w(d,n)\) is attained by a uniformly evaluated dataset with at most \((d+1)(d+2)/2\) rows and real algebraic features and labels. The value is a real algebraic number. Given \((d,n)\), rational real-closed-field quantifier elimination computes its minimal polynomial and a rational isolating interval. In the conjecture range \(d<n<2d\), it decides whether any original instance has optimal risk ratio strictly greater than \(1+\Gamma_{d,n-d}\). The inner infimum over positive weights on a fixed support can still be unattained.

## 8.1 Reduction to full-rank training and compression

Write \(r\le d\) for the observed feature rank. Rank zero has ratio one. If the full loss is zero and \(r\ge1\), choosing \(r\) feature rows forming a basis yields zero full loss: their interpolation equations determine the prediction on the observed subspace. Consider \(r\ge1\) and positive full loss.

Temporarily restrict the selector to supports spanning the observed subspace. This raises or preserves the inner optimum. Work in orthonormal coordinates on that subspace, subtract the full-data least-squares prediction from the labels, and multiply each feature and corresponding residual by \(\sqrt{p_i}\). Free training weights absorb the row multipliers. The weighted residual is orthogonal to the weighted feature columns. Whiten those columns by an invertible parameter change and rescale the residual to unit norm, rescaling the parameter by the same scalar. The resulting full-rank problem has \(W=[U,e]\) with
\[
 U^\top U=I_r,\qquad U^\top e=0,\qquad e^\top e=1.
\]
For a support \(S\) and positive diagonal training-weight matrix \(D_\omega\), the unique fit and its ratio are
\[
 z=(U_S^\top D_\omega U_S)^{-1}U_S^\top D_\omega e_S,
 \qquad \|Uz-e\|^2=1+\|z\|^2.
\]
This whitening uses uniqueness on the observed subspace. Deficient supports will be handled under the original Euclidean rule.

Put \(N_r=(r+1)(r+2)/2\), and write \(b_i=(U_i,e_i)^\top\) for each augmented row as a column. The rank-one matrices satisfy \(\sum_i b_i b_i^\top=I_{r+1}\). In the \(N_r\)-dimensional symmetric matrix space, conic Carathéodory represents this sum with at most \(N_r\) original outer products and strictly positive coefficients \(c_i\). Equivalently, discard zero terms and move nonnegative coefficients along a linear dependence until some coefficient reaches zero, then repeat. Use reduced rows \(\sqrt{c_i}\,b_i^\top\). Their augmented Gram, hence the full evaluation quadratic, is preserved. Every full-rank candidate uses original rows, with the new row scaling absorbed into its free training weights. The feasible fit set can only shrink, so the reduced full-rank value is at least the original full-rank value. Adding all-zero rows to reach exactly \(N_r\) changes no full-rank fit. Thus the outer supremum is bounded above by the maximum of one and the suprema of the full-rank values on the compact families
\[
 \mathcal W_r=\{W\in\mathbb R^{N_r\times(r+1)}:W^\top W=I_{r+1}\},
 \qquad 1\le r\le d .
\]

## 8.2 Attainment and transfer back to minimum norm

Let \(G_r(W)\) be the infimum of \(1+\|z\|^2\) over supports \(r\le |S|\le n\) with \(\operatorname{rank}U_S=r\), and all strictly positive training weights on \(S\). Each matrix admits a basis of \(r\) feature rows, so the infimum is finite. For fixed support and weight, extend its ratio by \(+\infty\) wherever the support fails to span. Every finite strict sublevel set of this extended function is open relative to \(\mathcal W_r\) by continuity on the open full-rank locus. The strict sublevel sets of \(G_r\) are unions of these open sets, so \(G_r\) is upper semicontinuous. Each compact family therefore has a finite maximizer, with value at least one. Choose \(r,W_*\) attaining the largest of these maxima.

Make the rows of \(U\) the uniformly evaluated features, and set labels \(y_i=e_i+U_i a\) for some fixed \(a\in\mathbb R^r\). The full-data parameter is \(a\), and the ratio of \(w\) is \(1+\|w-a\|^2\) since \(1/N_r\) cancels. A full-rank support translates its previous fit \(z\) by \(a\). The minimum-norm solution of any deficient support lies in its feature span \(V_S\), so its ratio is at least \(1+\operatorname{dist}(a,V_S)^2\) for every choice of weights. Choose \(v\) outside the finite union of those proper subspaces. A finite \(M>0\) makes all distances for \(a=Mv\) have squares greater than \(G_r(W_*)-1\). Thus the original selector's infimum is exactly \(G_r(W_*)\). Embedding isometrically in dimension \(d\) preserves the minimum-norm rule. This gives a matching data instance.

## 8.3 Rational quantifier elimination

For fixed \(r,d,n\), enumerate eligible supports. Encode each candidate using positive weights summing to one, positivity of the Gram determinant, the normal equations for \(z\), and the polynomial value \(1+\|z\|^2\). Then \(g=G_r(W)\) precisely if all candidates have value at least \(g\) and for every real \(\epsilon>0\) some candidate has value less than \(g+\epsilon\). With the equations for \(\mathcal W_r\) and the outer attainment and maximality conditions this gives a rational first-order formula defining the unique output \(F_w(d,n)\). Quantifier elimination yields a singleton rational semialgebraic set. Univariate root isolation and rational polynomial factorization give the minimal polynomial and isolating interval. The same formula has a maximizing witness over the real algebraic numbers by real-closed-field equivalence. A rational \(v\) can avoid the finitely many proper spans, and \(M\) may be an integer. The original features and labels thus remain algebraic. Comparison with the rational number \(1+\Gamma_{d,n-d}\) decides strict exceedance.

## 8.4 Four-row example and relation to earlier results

Take \(d=2,n=3\), equally weighted rows \(x=(1,0),(-1,0),(0,1),(0,-1)\), and labels \(y=1+x^\top(2,2)\). The full optimum is \((2,2)\) with loss one, and the risk ratio is \(1+\|w-(2,2)\|^2/2\). Four singletons force unit absolute displacement on one axis and leave displacement two on the other, giving \(7/2\). Two same-axis pairs allow zero displacement on that axis with equal weights and leave the other at two, giving three. Four cross-axis pairs force unit displacement on both axes, giving two. Four triples force unit displacement on the singleton axis, and equal weights on the paired axis give zero there, so the ratio is \(3/2\). Thus this dataset attains the known worst value for the cell. The example exercises the minimum-norm rule on all 14 supports.

Zhang v2 §7.2 verifies explicit extremizers and finite conjecture instances by exact arithmetic. His Theorem G.4 already uses finite label translation to penalize deficient supports. Liu–Wang v1 §4 attains the specific five-dimensional optimum and Appendix A gives fixed-data exact-selection and intrinsic-rank certificates. Maalouf–Jubran–Feldman Algorithm 2 and Theorem 4 preserve a matrix's Gram by reweighting input rows. Here Gram preservation yields a one-direction comparison of all eligible full-rank training fits. Compactness, upper semicontinuity and finite translation give an attained worst instance with a dimension-only row bound. This yields decidability at each fixed pair of integers. The general frontier and a practically efficient exact algorithm remain open. [Zhang v2 §§7.2, G.4](https://arxiv.org/html/2608.28007v2) · [Liu–Wang v1 §4, Appendix A](https://arxiv.org/html/2610.00101v1) · [Maalouf–Jubran–Feldman, Algorithm 2 and Theorem 4](https://arxiv.org/pdf/1906.04705)

# Appendix A. Complete Petersen span diagnostic

### 准确结论

存在一个 `9 x 30` 整数根矩阵，列向量正张成九维空间，其极大正回路跨度恰为十个不同的八维超平面。因此，它们不可能同时由某一个九维线性基的坐标子集张成。

这反驳二次路线中的**普遍共同坐标化假说**。它不反驳一般单锚 game 的 Gamma 界，更不反驳原始加权回归猜想。本例的单锚 game 可以完全精确计算：

\[
 g_1=\frac9{10}<\Gamma_{9,1}=\frac{20}{9}.
\]

没有声称这个反例的环境维数最小。构造与验证是在 `../reviews/SECONDARY_IDEA_COLLISION.md` 允许保留 Petersen 诊断之后完成。

### 1. 既有来源与明确整数矩阵

Petersen 图的 hypohamiltonian 性是经典事实。[Aldred–McKay–Wormald, *Small Hypohamiltonian Graphs*, JCMCC 23 (1997), 143–152](https://combinatorialpress.com/article/jcmcc/Volume%20023/vol-23-paper%2012.pdf) 第143页引言指出 Petersen 是最小 hypohamiltonian 图；该术语指图自身无 Hamilton 回路，而删任一顶点后有 Hamilton 回路。正张成与有向图 incidence 几何的基本对应同样是既有知识，见 [Cornaz–Kerleau–Royer, §3.2, Theorem 3.1](https://arxiv.org/abs/2411.08994)。本记录不将这些事实计为新图论贡献。

给图的顶点编号 `0,...,9`。无向边为

\[
 \{\{i,i+1\pmod5\},\{i,5+i\},\{5+i,5+(i+2\pmod5)\}:0\le i<5\}.
\]

每条边取两个有向弧。对弧 `a -> b` 取 `e_b-e_a in R^{10}`，再删除第9号坐标，得到 `g_ab in Q^9`。按有向弧字典序排列这些列即为所需矩阵。完整的 $9\times30$ 整数矩阵和弧顺序见[精确证书](evidence/results/computation/petersen_span_certificate.json)。定义只用整数。

每对反向弧互为相反数，故全部列之和为零，严格正核向量可以取全一。一个树的九条弧给出行列式为 `+1` 或 `-1` 的基子矩阵，证书保存了实际列号和行列式。因此列满秩且正张成 `R^9`。

### 2. 全部正回路及极大跨度

在有向 incidence 矩阵中，非负核向量是非负循环流。其非零支持中取一条弧并不断沿正流出弧前进；有限性保证遇到有向简单回路。减去该回路上的最小流量后至少去掉一条支持弧，迭代便得到有向简单回路的非负组合。因此支持极小的正依赖恰是有向简单回路，包括反向弧形成的二回路。

脚本一方面逐条 DFS 枚举，另一方面以独立的顶点子集动态规划计数；每条保存回路还以整数矩阵验证全一正关系和秩 `length-1`。结果为：

| 回路长度 | 无向简单回路数 | 正回路数 |
|---|---:|---:|
| 2 | 不作为无向简单回路计数 | 15 |
| 5 | 12 | 24 |
| 6 | 10 | 20 |
| 8 | 15 | 30 |
| 9 | 20 | 40 |
| 10 | 0 | 0 |
| 合计 | 57 | 129 |

全部129条正回路及列支持、正关系和秩均列在 JSON 中；没有用一份不完整的回路清单代替全集。

在十维总和为零的空间

\[
 H=\{z:\sum_{i=0}^9z_i=0\}
\]

中，顶点集为 `S` 的回路跨度为

\[
 U_S=\{z\in H:z_i=0\ (i\notin S)\},\qquad\dim U_S=|S|-1.
\]

每个缺点 `v` 都有九回路，因而十个超平面 `U_{V\setminus\{v\}}` 均出现。任一回路都不是 Hamilton 回路，其顶点集必缺少某个 `v`，故其跨度包含于相应九回路超平面。十个超平面两两不同，又没有更大的正回路跨度，因此它们恰是全部极大跨度。

删除第9号坐标后，这十个超平面的法向可写成

\[
 e_0,e_1,\ldots,e_8,\quad(1,1,\ldots,1).
\]

证书核验任意九个法向线性独立，因此它们确实是十个不同超平面。九维空间固定一个基后，由坐标子集张成的八维超平面只有九个。计数立即证明不能共同坐标化。

### 3. 单锚 game 的有理最优证书

记回路 `A,C` 的顶点集仍为 `A,C`。直接由支撑坐标得到

\[
 \rho(A,C)=\dim U_C-\dim(U_A\cap U_C)
 =|C|-1-\max\{|A\cap C|-1,0\}.
\]

#### 上界

对每个缺点 `v` 选一条九回路，并在这十个锚之间均匀随机。对任意目标回路 `C`，若缺点在 `C` 中则秩损失为1，否则为0。因此

\[
 \mathbb E_A\rho(A,C)=\frac{|C|}{10}\le\frac9{10}.
\]

#### 下界

对同样的十个九回路目标均匀取权。任意锚回路 `A` 设 `|A|=a<=9`。当目标缺点在 `A` 内时损失为 `10-a`，否则为 `9-a`。因此

\[
 \mathbb E_C\rho(A,C)
 =\frac{a(10-a)+(10-a)(9-a)}{10}
 =\frac{9(10-a)}{10}\ge\frac9{10}.
\]

上下界相同，得到 `g_1=9/10`。JSON 包含全部129个目标的 primal 值、全部129个锚的 dual 值及每个策略的精确 `1/10` 权重。十个极大跨度之间的 payoff 矩阵为对角0、非对角1，脚本另用整数矩阵秩直接核对该矩阵。

由此可见：结构桥梁失败，并不自动导致风险常数失败。即使在这个无法共同坐标化的系统中，单锚 game 仍比 `Gamma_{9,1}` 小 `119/90`。

### 4. 复现

在[复现资料目录](evidence/)运行：

```bash
python code/verify_all.py --only petersen
```

该检查只使用整数、有理数和有限枚举，不调用随机搜索或数值优化器。本证书是普遍坐标化路线的反例诊断材料，不能作为原始完整 Gamma 目标完成的证据。

# Appendix B. Initial computation report and exact benchmark certificates

### 结论与范围

本轮没有发现经过认证的 Gamma 反例，也没有证明完整剩余参数区间。完成的是一个 `k=1` 满秩选择的有理证书引擎、两个已有例子的精确回归、结构化有限数值搜索，以及 Fano 候选族的若干真正可行选择上界。所有这些都是主目标的辅助材料；不能把它们升级为已完成原始公开问题。

冻结主目标、现有文献排除区域和价值门槛以 `../PROBLEM.json`、`../EXPECTED_VALUE_REVIEW.json`、`../IDEA_COLLISION.md` 为准。计算开始于门禁 `near` 允许之后。文献中的 adjacent-basis simplex、Gale 参数化与正基正规形均明确保留原作者归属。

### 1. 有理实例与原始学习器的联系

输入为满行秩有理矩阵 `G=[g_1 ... g_N]`，满足 `G 1=0`，以及正有理质量 `c_i`。令

\[
 S=\sum_i c_i,\qquad x_i=g_i/c_i,\quad p_i=c_i/S,\quad y_i=1,
 \qquad H=S^{-1}GC^{-1}G^T.
\]

于是原始评估风险恰为 `1+w^T H w`，完整最优点为零、完整最优风险为一。`p_i` 固定作为评估权，优化只改变训练权。脚本把有理 `p_i` 转成整数重复次数，因此每个被认证实例都是原问题允许的有限等权 multiset。这里只利用这一规范实例族进行攻击，不声称它覆盖了任意数据的所有退化情况。

#### 满秩预算 d+1

固定一个 `d+1` 点满秩支持，按 [Zhang, Lemma G.2](https://arxiv.org/html/2608.28007v2) 枚举删除一个点后仍独立的 `d` 行插值解。其凸包是该支持严格正权最小二乘输出的闭包。`gamma_engine.py` 使用浮点活跃集只建议候选面，然后以有理数解线性 KKT 系统。每个证书包含凸系数、输出 `q`、精确值 `q^T H q` 和对**全部**顶点 `v` 的支撑不等式

\[
 v^T Hq-q^THq\ge0.
\]

该不等式和凸组合可行性共同证明每一支持的全局最小值。`verify_certificate` 重新枚举所有支持及插值顶点，而不是信任保存的目标值或支持列表。满秩 `d` 点支持包含在这些顶点中。

#### 秩亏支持与显式位移

未平移的规范数据常常被一个秩亏正回路以最小范数输出零直接恢复。对此不作忽略。对每个由 `d-1` 个独立特征张成的超平面，保存有理法向 `n`。取有理方向 `h=(1,t,...,t^{d-1})`，遍历整数 `t` 直到每个 `n^T h` 非零。此时

\[
 \operatorname{dist}_H(h,\ker n^T)^2
 =\frac{(n^T h)^2}{n^T H^{-1}n}>0.
\]

选择明确整数 `M`，使 `M^2` 乘所有这些距离的最小值严格超过已认证的满秩最优超额，并令标签变成 `1+x_i^T(Mh)`。每个秩亏支持的最小欧氏范数输出属于其特征张成空间；该真子空间可以扩充为所枚举的某个特征超平面。因此所有秩亏输出的全数据超额都严格超过阈值。全部满秩选择的相对超额在标签位移下不变。

这个步骤是既有 generic-shift 方法的显式有理实现，不作为新主定理。它同时给出原始 minnorm 学习器的可检验有限数据，避免把只有满秩选择的结果误当成原问题的结果。

### 2. 两个精确回归

| 例子 | 满秩预算 d 超额 | 预算 d+1 超额 | 全部 d+1 满秩支持 | 位移认证 |
|---|---:|---:|---:|---|
| Zhang Proposition I.7，d=6 | `192048003/80008000` | `288030000/240094007` | 8 | 是 |
| 两个 rank-3 单纯形块，d=6 | `3` | `3/2` | 8 | 是 |

第一例的两条值均逐字匹配原论文中的有理结果。它在本表示下对应 10001 行等权 multiset；位移为 `(14,14,14,14,14,14)`，21 个不同特征超平面证出秩亏选择超额至少 `8064840000/6618551789`，严格大于预算7的满秩值。

第二例是已知正交回路块下界，`Gamma(6,1)=3/2`。等权 multiset 有8行；位移为 `(5,10,20,40,80,160)`，12 个特征超平面证出秩亏超额至少 `25/16>3/2`。

证书分别为 `regression_I7_certificate.json` 与 `block_3_3_certificate.json`。这些回归检验引擎是否正确处理原论文的耦合例与极值基线，**不构成新的风险常数结果**。

### 3. d=6、k=1 的有限扫描

每个质量评估均扫描该几何的全部 `d+1` 支持，使用邻接插值凸包的浮点最短点。浮点失败只会导致探索状态，不能生成反例证明。全部候选均未出现严格高于 `Gamma=1.5` 的数值值。

| 扫描目录 | 几何数 | 质量评估数 | 最高数值满秩超额 |
|---|---:|---:|---:|
| `critical_scan_d6` | 80 | 1600 | 1.5，已知块例 |
| `critical_polish_d6` | 24 | 9964，含差分进化 | 1.5，已知块例 |
| `critical_crosscone_d6` | 80 | 2400 | 1.5，已知块例 |
| `digraph_scan_d6` | 80 | 2400 | 1.5 |
| `augmented_scan_d6` | 20 | 10160，含差分进化 | 0.5136625127 |

关键构造分别是：同一 critical cone 中的块耦合；可跨 critical cones 的临界线性子空间耦合；由有向耳构造得到的正整数循环流；以及两个 rank-3 回路块添加一对混合方向。前两者基于 [Cornaz–Kerleau–Royer, Theorem 5.2](https://arxiv.org/abs/2411.08994)，有向图和正张成之间的对应同样是既有文献结果。

每个目录都有种子、实际次数、原始整数 `G`、最佳质量、数值状态和范围说明。`numeric_failures` 只统计显式随机质量扫描；差分进化中不通过数值 KKT 的目标被罚值排除，未纳入此失败计数。无论失败计数是否为零，本节始终只是有限浮点搜索。

前两次 `critical` 扫描必须加 `--critical-mode-version 1` 才能重现；扩展跨锥版本使用版本2。所有生成参数记录在 manifest。没有把有限未发现解释为普遍不可能。

### 4. Fano 候选：机制缺口与真正风险的区别

几何代理发现 Fano 根系的多锚覆盖 game 值 `6/7` 高于 `Gamma(7,2)=4/5`。这只反驳某个充分证明机制。我们随即构造真正合法的9点加权最小二乘输出，阻止把 game gap 误报为原猜想反例。

七个正根为 `e_i`，七个负根为 Fano 线的负指示向量；线依次为 `012,034,056,135,146,236,245`。对称评价质量为每正根 `3/28`、每负根 `1/28`。支持 `{0,1,2,3,4,7,8,5,11}`，相应未归一化训练权 `{2,1,1,1,1,1,1,1,1}`，给出唯一输出

\[
 q=(0,0,0,0,0,1,-1),\qquad q^THq=5/14<4/5.
\]

该见证来自几何代理，`fano_witnesses.py` 对其正常方程、正权和满秩进行独立符号核验。

进一步，所有共同尺度比 `beta>0` 的对称族也被明确排除：正特征 `e_i`，负特征 `-beta 1_L`，评估质量

\[
 p_+=\frac{3\beta}{7(3\beta+1)},\qquad
 p_-=\frac{1}{7(3\beta+1)}.
\]

锚住前五个坐标，再加两个正行，可行超额为

\[
 A(\beta)=\frac{2\beta(4\beta+3)}{7(3\beta+1)}.
\]

改加两条独立负行，则可行超额为

\[
 B(\beta)=\frac{2(4\beta+3)}{7\beta(3\beta+1)}.
\]

因为

\[
 \tfrac12-A(\beta)=\frac{(1-\beta)(16\beta+7)}{14(3\beta+1)},\qquad
 \tfrac12-B(\beta)=\frac{3(\beta-1)(7\beta+4)}{14\beta(3\beta+1)},
\]

`beta<=1` 时选 A，`beta>=1` 时选 B，总能达到超额不超过 `1/2`，低于 `4/5`。完整符号见证在 `fano_symmetric_witnesses.json`。

最后，对非对称七条线循环流与十四个残差质量，枚举315个“两回路锚加两独立插值行”真正可行输出。20000次随机参数与21090次差分进化评估中，遇到的最高最小见证成本约为 `0.3613935876`。对应参数被转成有理数，并重新精确验证一个合法权重输出，存于 `fano_nonsymmetric_scan/manifest.json`。这仍然只是一个充分选择机制的有限搜索；它既不是 Fano 全族的普遍上界，也不是原问题的下界。

### 5. 复现命令

在[复现资料目录](evidence/)运行统一精确证书入口：

```bash
python code/verify_all.py --only regression --only fano
```

上述统一入口复查书面结果所用的归档精确证书。

当前实际环境为 NumPy 2.3.5、SciPy 1.17.0、SymPy 1.14.0。随机数和优化器版本变化可以改变探索轨迹，已有有理证书的正确性则不依赖随机轨迹。这里没有 Lean 编译声明，也没有用数值实验替代完整论文中的主命题证明。

# 9. Remaining gap and verification boundaries

The frozen universal Gamma frontier is not proved or refuted. The coordinate
span hypothesis does not hold for arbitrary positively spanning systems, and
the coarse rank game already fails at both of the stated budgets. The
coefficient-sensitive argument succeeds on the specified matching family;
no proof establishes its general Gamma bound. Rank-deficient minimum-norm
outputs and zero-residual quotient structure cannot be omitted from a future
general result.

Sections 2–6 contain the original support, geometry and complexity
results. Sections 7–8 add the original-learner orthogonal allocation law and
the unrestricted attained worst-case characterization. Fixed-cell decision
does not give a single finite certificate for the infinitely many cells.

From the evidence directory, `python code/verify_all.py` verifies the finite rational and symbolic
certificates. Independent checks are also retained. Successful finite checks
support only their stated inputs and identities. The analytic proofs of
existence, completeness and universal quantified statements are in this text;
they have not all been translated to a proof assistant.

The successful Lean checkpoint contains exactly three scalar algebraic lemmas
used in the risk-gap proof. Lean 4.35.0-rc3 with the pinned Mathlib commit
compiled the source, audited every project-owned declaration, and was replayed
independently from source. Only `Classical.choice`, `Quot.sound` and `propext`
occur in the allowed axiom dependency lists. The remaining results have written proofs and accompanying formalization tasks. Neither graph connectivity and hardness nor the geometric and
complexity theorems are implied by this three-lemma checkpoint. The exact
outstanding map and replay commands are in Historical formalization map.

# References

The entries below identify the sources actually used. Historical source catalog records
whether full primary text, an official abstract, or metadata was available.
Unavailable full texts are not treated as evidence that an old claim is new.

- **[HMSY25]** Steve Hanneke, Shay Moran, Alexander Shlimovich, Amir Yehudayoff. *Open Problem: Data Selection for Regression Tasks*. 2025. [Primary source](https://proceedings.mlr.press/v291/hanneke25e.html).

- **[Z26]** Guangjian Zhang. *Exact Risk Ratios for Weighted Data Selection in Linear Regression*. arXiv:2608.28007v2. [arXiv:2608.28007v2](https://arxiv.org/html/2608.28007v2).

- **[LW26]** Zhongxuan Liu, Hongzhi Wang. *Weighted Data Selection: Sharp Upper-Half and Five-Dimensional Laws*. arXiv:2610.00101v1. [arXiv:2610.00101v1](https://arxiv.org/abs/2610.00101).

- **[CKR25]** Denis Cornaz, Sébastien Kerleau, Clément W. Royer. *A characterization of positive spanning sets with ties to strongly connected digraphs*. arXiv:2411.08994v2. [10.1016/j.dam.2025.05.025](https://arxiv.org/abs/2411.08994).

- **[BMK94]** David Baraff, Raju Mattikalli, Pradeep Khosla. *Minimal Fixturing of Frictionless Assemblies: Complexity and Algorithms*. CMU-RI-TR-94-08. [Primary source](https://www.cs.cmu.edu/~baraff/papers/fixture-tr.pdf).

- **[GL83]** C. Zachary Gilstein, Edward E. Leamer. *The Set of Weighted Regression Estimates*. 1983. [10.1080/01621459.1983.10477044](https://www.tandfonline.com/doi/abs/10.1080/01621459.1983.10477044).

- **[F96]** Anders Forsgren. *On Linear Least-Squares Problems with Diagonally Dominant Weight Matrices*. 1996. [10.1137/S0895479895284014](https://epubs.siam.org/doi/10.1137/S0895479895284014).

- **[KT09]** Tomonari Kitahara, Takashi Tsuchiya. *Proximity of Weighted and Layered Least Squares Solutions*. 2009. [10.1137/080725787](https://epubs.siam.org/doi/10.1137/080725787).

- **[V90]** Stephen A. Vavasis. *Quadratic programming is in NP*. 1990. [10.1016/0020-0190(90)90100-C](https://doi.org/10.1016/0020-0190(90)90100-C).

- **[K72]** Richard M. Karp. *Reducibility Among Combinatorial Problems*. 1972. [10.1007/978-1-4684-2001-2_9](https://doi.org/10.1007/978-1-4684-2001-2_9).

- **[KMT98]** F. P. Kelly, A. K. Maulloo, D. K. H. Tan. *Rate control for communication networks: shadow prices, proportional fairness and stability*. 1998. [10.1057/palgrave.jors.2600523](https://www.statslab.cam.ac.uk/~fpk1/rate.html).

- **[AMW97]** R. E. L. Aldred, Brendan D. McKay, Nicholas C. Wormald. *Small Hypohamiltonian Graphs*. 1997. [Primary source](https://users.cecs.anu.edu.au/~bdm/papers/hypo.pdf).

- **[KW60]** J. Kiefer, J. Wolfowitz. *The Equivalence of Two Extremum Problems*. 1960. [10.4153/CJM-1960-030-4](https://doi.org/10.4153/CJM-1960-030-4).

- **[MJF21]** Alaa Maalouf, Ibrahim Jubran, Dan Feldman. *Fast and Accurate Least-Mean-Squares Solvers*. [Author version](https://arxiv.org/pdf/1906.04705) · [Journal version](https://doi.org/10.1109/TPAMI.2021.3139612).
