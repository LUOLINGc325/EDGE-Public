# The nine-chore threshold and fixed-parameter tractability of temporal EF1

## Abstract

We study additive nonnegative chore costs with a fixed arrival order known before play. For three agents, we prove that every instance of at most eight chores admits an allocation that is envy-free up to one own chore at every prefix. Combined with Teh’s nine-chore counterexample, this determines the exact failure threshold. The universal eight-chore result uses a certificate over linear real arithmetic with two independently implemented exact replays. For arbitrary numbers of agents, we prove that feasibility is fixed-parameter tractable in the excess \(k=m-n\) alone. If \(m=n+k\) and \(n\ge2^{C(k+1)^3}\) for an absolute constant \(C\), every instance admits such an allocation. Thus a failure family with an increasing number of agents necessarily has \(k=\Omega((\log n)^{1/3})\). Matching over bundles containing multiple chores also gives explicit exact algorithms and infeasibility certificates.

## 1. Model and three-agent threshold

The first six sections concern three agents. Let the agent set be \(N=\{0,1,2\}\), and let the chores arrive in the order \(0,\ldots,m-1\). Agent \(i\)'s cost for chore \(k\) is \(c_{ik}\geq0\); her cost for a set is the sum of its individual costs. The complete instance and arrival order are known in advance. An assignment \(a(k)\in N\), once made, cannot be changed.

At a prefix of length \(t\), agent \(j\)'s bundle is

\[
A_j^t=\{k<t:a(k)=j\}.
\]

The prefix satisfies chore EF1 exactly when, for every pair \(i,j\), deleting at most one chore from agent \(i\)'s own bundle leaves cost no greater than her evaluation of agent \(j\)'s bundle:

\[
\exists r\in A_i^t\cup\{\bot\},\qquad
\sum_{k\in A_i^t\setminus\{r\}}c_{ik}
\leq\sum_{k\in A_j^t}c_{ik}.
\]

Here \(\bot\) denotes no deletion. Temporal EF1, abbreviated TEF1, requires this condition at every prefix \(t=0,\ldots,m\). The allocations at different prefixes must be consistent restrictions of one assignment. The algorithm has complete foresight.

**Theorem 1.** For three agents with nonnegative additive costs, every instance of at most eight chores admits TEF1, and an instance of nine chores can fail. Teh’s §7 poses the exact failure threshold as an open question [1]. The paper also asks how many chores are needed for a family of instances to have unbounded optimal approximation factors. Teh’s parameterized construction supplies the separate unbounded-factor examples.

## 2. Reducing the eight-chore problem to seven chores

Call agent \(i\) completely unenvying at a prefix if

\[
\sum_{k\in A_i}c_{ik}\leq\sum_{k\in A_j}c_{ik}
\quad\text{for every }j.
\]

This describes agent \(i\)'s own comparisons. It does not mean that the other agents do not envy her.

### 2.1 A sufficient recipient for the next chore

If the current prefix is EF1 and agent \(i\) is completely unenvying, assigning any new chore to \(i\) preserves EF1.

To see this, delete the newly received chore in agent \(i\)'s next EF1 comparison. Her remaining bundle is exactly her old bundle, whose cost is no greater than any comparison bundle's old cost. Every other agent keeps her own bundle, so her previous deletion witness remains available. Her evaluation of agent \(i\)'s bundle can only increase, and her evaluations of the remaining bundles do not change. This step uses nonnegativity of the new chore's costs. All comparisons therefore remain valid.

Consequently, the following seven-chore property suffices for universal existence with eight chores:

> **Seven-chore covering lemma.** Every three-agent, seven-chore instance with nonnegative real additive costs has a TEF1 path whose final prefix contains at least one completely unenvying agent.

### 2.2 The reverse implication

Universal eight-chore existence also implies this seven-chore property. Given a seven-chore instance, append an eighth chore with cost \(1+\sum_{k<7}c_{ik}\) for agent \(i\). In any eight-chore TEF1 allocation, the appended chore is the most costly own chore of its recipient. Deleting a most costly chore minimizes the remaining cost, so the final EF1 comparisons also hold after this deletion. The remaining cost is precisely the recipient's own bundle cost at the seven-chore prefix. Thus she was completely unenvying at that prefix.

This equivalence shows that searching for a safe final recipient preserves the difficulty of the original problem. It does not restrict arbitrary costs to a special family. The actual certificate only needs to address the 21 real costs of the first seven chores.

## 3. Finite candidates and the exact arithmetic formula

We use only candidates that assign the first three chores to distinct agents. At each of the first three prefixes, every agent has at most one chore, so EF1 holds automatically for nonnegative costs. Each of the remaining four chores has three possible recipients, giving

\[
3!\,3^4=486
\]

seven-step paths. Designating an agent \(u\) as a candidate recipient of the eighth chore gives 1,458 candidates. For zero-cost instances this family does not contain every feasible path. The proof only needs it to be a sufficient covering family. The independent review explicitly checked this distinction.

Fix a candidate path \(a\). For chore index \(t\in\{3,4,5,6\}\), only the recipient \(i=a(t)\) can newly violate an EF1 comparison upon this arrival. The preceding EF1 conditions and nonnegativity preserve the other agents' comparisons. Let \(O\) be the recipient's bundle at this point and \(J\) the bundle of another agent \(j\). The set \(O\) is nonempty because it contains the newly assigned chore. Failure of this EF1 comparison is equivalent to

\[
\bigwedge_{r\in O}
\left(\sum_{k\in O\setminus\{r\}}c_{ik}
      -\sum_{k\in J}c_{ik}>0\right).
\]

The requirement that strict envy remain after every possible own-chore deletion is a conjunction. With nonnegative costs, deleting nothing cannot improve the comparison, so this formula also captures the at-most-one-deletion definition. Replacing this conjunction by a disjunction would change the problem. The author formula and an independent standard-library reconstruction have been compared symbolically, with exact arithmetic, for all 1,458 candidates.

For the designated final agent \(u\), failure of the completely unenvying condition is

\[
\bigvee_{j\ne u}
\left(\sum_{k\in A_u^7}c_{uk}
      -\sum_{k\in A_j^7}c_{uk}>0\right).
\]

Take the disjunction of the failed comparisons from rounds four through seven and the failed final comparisons. This gives the candidate-failure formula \(F_{a,u}(c)\). Some cost instance is not covered by this restricted candidate family exactly when the following formula is satisfiable:

\[
\Phi(c)=
\left(\bigwedge_{i<3,\,k<7}c_{ik}\geq0\right)
\wedge\left(\bigwedge_{(a,u)}F_{a,u}(c)\right).
\]

This is a formula of quantifier-free linear real arithmetic. The variables are not restricted to integers or a grid, and no floating-point tolerance is introduced. A satisfying model of \(\Phi\) would show only that this restricted family fails to cover the instance: a TEF1 path outside the family, also ending with a completely unenvying agent, might still exist. Such a model cannot automatically be called a counterexample to the original problem. In the other direction, unsatisfiability of \(\Phi\) suffices to give a required candidate for every cost instance, and hence the seven-chore property and eight-chore existence. Sections 4 and 6 supply the symmetry bridge and complete exact certificate replay for this formula.

## 4. Valid symmetry reduction on the initial block

Agent labels may be renamed arbitrarily. In the candidate paths, the first three chores are assigned to distinct agents. Their relative order can therefore also be used for symmetry reduction: the first three prefixes remain fair because bundles are singletons or empty, and every later prefix contains the same three initial chores. The arrival order of the remaining four chores cannot be changed arbitrarily in this way.

Choose a global minimum in the initial \(3\times3\) cost block and move it to position \((0,0)\). Next, if necessary, interchange columns 1 and 2 so that \(c_{01}\leq c_{02}\), and interchange rows 1 and 2 so that \(c_{10}\leq c_{20}\). These latter operations fix column 0 and row 0, respectively, and do not destroy the earlier conditions. We obtain

\[
c_{00}\leq c_{ij}\quad(i,j<3),\qquad
c_{01}\leq c_{02},\qquad c_{10}\leq c_{20}.
\]

There are \(3!\,3!=36\) row/column relabelings. Ties do not omit any instance: choose any minimizer and make swaps according to weak inequalities.

The formal bridge uses an explicit restoration direction. If the transformed costs are \(c'(i,t)=c(\rho(i),\sigma_{\rm ext}(t))\), where \(\sigma_{\rm ext}\) permutes only the first three indices and fixes all later indices, then the original path restored from a transformed path \(b\) is

\[
a(s)=\rho\bigl(b(\sigma_{\rm ext}^{-1}(s))\bigr).
\]

For prefixes of length at least three, a set bijection preserves the bundle costs. The deletion index is mapped forward by \(\sigma_{\rm ext}\) at the same time. Shorter prefixes are handled directly by injectivity of the first three recipients. A solver's `UNSAT` output does not supply this semantic bridge.

Let \(C(c)\) denote the initial ordering conditions in this section. The formula submitted for verification is \(\Phi_{\rm sym}(c)=\Phi(c)\wedge C(c)\). It has 21 nonnegativity assertions, 1,458 candidate-failure assertions, and 11 ordering assertions. The last group includes the redundant but harmless \(c_{00}\leq c_{00}\), giving 1,490 assertions altogether. Every original cost profile can be moved into this ordering region by the stated permutations, and any successful candidate can be restored to a path for the original instance. Thus proving \(\Phi_{\rm sym}\) unsatisfiable suffices for the target; no additional restriction on the cost domain is being imposed.

## 5. The existing nine-chore upper bound and independent recomputation

The nine-chore counterexample uses Teh’s Table 3 [1].

| Agent | 1 | 2 | 3 | 4 | 5 | 6 | 7 | 8 | 9 |
|---|---:|---:|---:|---:|---:|---:|---:|---:|---:|
| p | 2 | 1 | 2 | 2 | 8 | 8 | 4 | 8 | 8 |
| d | 2 | 3 | 1 | 3 | 3 | 5 | 5 | 5 | 5 |
| q | 5 | 2 | 1 | 2 | 10 | 5 | 10 | 10 | 10 |

The independent checker starts from the empty allocation, tries all three recipients at every step, and tests every possible own-chore deletion according to the original definition. It does not call the author checker. The numbers of surviving prefixes at lengths zero through nine are

\[
1,3,6,6,6,6,5,5,3,0.
\]

Only three paths survive at length eight, and all nine possible final extensions have strict failed comparisons. This finite calculation has been recomputed exactly. The corresponding Lean source uses prefix pruning, a case analysis on the unrestricted deletion index at each failed leaf, and exact integer-valued arithmetic over the reals. Those historical Lean sources do not supply complete current formal verification; only the exact Python recomputation is used in this written proof.

Combining the universal eight-chore existence established here with this attributed nine-chore counterexample gives a minimum of nine. For instances with fewer than eight chores, append zero-cost chores, apply the eight-chore statement, and restrict the resulting path to the original prefix. Thus the theorem includes every smaller number of chores, including zero.

## 6. Complete certificate proof and implementation boundary

### 6.1 Fixed input and complete replay

The [fixed SMT-LIB query](evidence/proof/problem_wlog_query.smt2) and [proof DAG](evidence/proof/certificate_wlog.json) have SHA-256, respectively,

- `ff9bb4ca88db0497699be272409d58c187ac14c8d3df0424bbef05d7a375377c`;
- `fc56a793107dc5d60a2767b9e530d901c077bc3badf7d69befffa0c7623fc2f6`.

The query differs from the independently checked assertion-only file solely by a `QF_LRA` logic declaration and a final `check-sat` command; this byte relation was checked again. The standard-library semantic audit reconstructs every candidate directly from prefix bundles and every possible own deletion. It agrees on all 1,490 assertions, including the 21 domain conditions and 11 symmetry conditions. Separately, the new certificate checker expands SMT `let` bindings with their parallel scope and compares the ordered raw assertion ASTs, before arithmetic normalization, against the certificate. Thus the replay cannot silently certify an easier normalized input or a different finite-grid problem.

The proof graph contains 156,616 nodes in all and 126,909 proof nodes. Every proof node is checked, including any node not used at the final root. The rule inventory is:

| Rule | Nodes |
|---|---:|
| Original assertion | 715 |
| Propositional definition axiom | 1,385 |
| Local hypothesis | 2,254 |
| Hypothesis-discharge lemma | 7,285 |
| Modus ponens | 706 |
| Exact rewrite | 706 |
| Arithmetic lemma | 7,906 |
| Unit resolution | 105,952 |

Only 715 assertion leaves occur in the proof; this does not mean that the 1,490-assertion input was partially bound. All input assertions were bound, and every assertion leaf must refer to one of them. The unused assertions only strengthen an already inconsistent conjunction.

### 6.2 Soundness of the Boolean proof rules

Let \(A\) be the set of bound original assertions, \(\Delta(v)\) the undischarged local assumptions of proof node \(v\), and \(\varphi(v)\) its conclusion. In topological order the invariant is

\[
 (\bigwedge A)\land(\bigwedge\Delta(v))\Longrightarrow\varphi(v).
\]

Assertion leaves must belong to \(A\). A hypothesis node introduces its own conclusion. Ordinary inference nodes keep the union of all premise hypotheses; duplicate formulas may be contracted. Modus ponens checks the actual endpoints of a proved Boolean equivalence. Unit resolution requires a complementary literal for each proved unit and checks that the residual clause is exactly the stated conclusion. A whole compound formula may serve as a literal; this is ordinary propositional substitution, not a new assumption.

A discharge node has one proof premise whose conclusion is false. For every still-active hypothesis, its negation must occur in the output clause, allowing only double-negation elimination and literal treatment of whole compound formulas. If that clause were false, all active hypotheses would hold, contradicting the premise. Hence the clause follows from \(A\) alone and the local assumption set may be emptied. Omitting even one active hypothesis is rejected. The final root concludes literal false with an empty active-assumption set.

Each definition axiom is checked as a propositional tautology by exhaustive truth tables with the raw arithmetic comparisons treated as independent atoms. Each rewrite is checked by exact rational affine normalization, positive rescaling of inequalities, and valid Boolean identities (associativity, commutativity, idempotence, constants, complements, double negation, and equivalence). No arithmetic inequality is accepted merely because a solver labels it a rewrite.

### 6.3 Soundness of every arithmetic lemma

For each arithmetic clause, negate all its literals. In this fixed certificate the arithmetic nodes have no proof premises. Each held inequality is converted exactly to
\(a_\ell\cdot c+b_\ell\le0\), or to its strict version. The supplied weights are rational numbers. For every lemma the checker verifies

\[
 \lambda_\ell\ge0,\qquad
 \sum_\ell\lambda_\ell a_\ell=0,\qquad
 B=\sum_\ell\lambda_\ell b_\ell\ge0.
\]

It requires either \(B>0\), or \(B=0\) with at least one strict inequality whose multiplier is strictly positive. The first case contradicts the nonpositive weighted sum. The second contradicts its strict negativity. A zero-weight strict inequality supplies no strictness. Therefore the original clause is true over all real assignments, not only rational assignments. All 7,906 such combinations were recomputed with exact `Fraction` arithmetic, and their multipliers, residuals and strictness witnesses are recorded individually.

The accepted syntax is deliberately narrow: real numerals and declared variables, addition, unary negation, scalar multiplication, weak comparisons, and the listed Boolean connectives. Division, nonlinear products (including syntactically nonlinear products whose coefficients might cancel), mismatched operator names/kinds, unsupported rules, ill-typed nodes, and forward or cyclic references are rejected. Four acceptance controls and twenty targeted rejection tests exercise the principal soundness risks. Those tests support implementation review; the full-instance replay remains a separate run with the fixed input and certificate hashes enforced.

### 6.4 From the checked contradiction to the threshold

The rule invariant and the empty-assumption false root show that the bound query is unsatisfiable. Sections 3 and 4 identify it as simultaneous failure of every candidate after a valid symmetry reduction. Hence every nonnegative real seven-chore instance has a candidate path and a completely unenvying final agent. Section 2 extends this path to any eighth chore, and Section 5 supplies the attributed nine-chore obstruction. This proves the theorem.

The separate exact-rational constructor [construct_allocation.py](evidence/code/recovery_2026_11_25/construct_allocation.py) enumerates the 486 paths, tests the definition directly, selects a completely unenvying agent, and appends the eighth chore. Shorter inputs are padded with zeros and then restricted. Integers and rational strings are accepted; floating-point inputs, negative costs and more than eight chores are rejected. The constructor supplies witnesses for rational inputs, while the symbolic certificate proof covers arbitrary real inputs. Its finite diagnostic examples are not used as evidence of universal coverage.

### 6.5 What was actually executed and what remains

The exact replay entry point is [independent_certificate_verifier.py](evidence/code/recovery_2026_11_25/independent_certificate_verifier.py), SHA-256 `6539816b2ddcf931e3d8fd21d5a6b75d92c3a6529c57d74736681b4f1cbfbdaa`. It was run with `python -I -S`, imports only the Python standard library, and imports neither the author checker, upstream reconstruction functions, Z3 nor other solver bindings. Its implementation was developed separately with knowledge of the certificate schema; it is not a blind audit. The two implementations were developed independently for the same certificate format.

The trusted boundary includes Python, its exact-integer/rational arithmetic, the inspected checker implementations, their parsers, and the written semantic arguments. Hashes bind this particular evidence; they are not proofs of mathematical correctness. Current raw receipts are under [p1_recovery_2026_11_25](evidence/README.md). Complete Lean formalization is a separate deliverable.

## 7. Arbitrary agent counts and matching certificates

Now let \(n\ge2\) and let \(m\) be arbitrary. Retain the same allocation and prefix definitions. For a bundle \(S\), define
\[
 R_i(S)=\sum_{g\in S}c_i(g)-\max(\{c_i(g):g\in S\}\cup\{0\}).
\]
The temporal condition is \(R_i(A_i^t)\le c_i(A_j^t)\) for every prefix and every distinct \(i,j\). A final bundle is active when it contains at least two chores. With \(m\le n\), allocating each item to a different agent immediately gives TEF1. Assume henceforth that \(m=n+k\), \(k\ge0\).

### 7.1 A matching characterization for a fixed partition

Fix disjoint bundles \(P_1,\ldots,P_n\) partitioning all chores, allowing empty
bundles. Put \(P_b^t=P_b\cap\{0,\ldots,t-1\}\). Join agent \(i\) to bundle
\(b\) exactly when

\[
R_i(P_b^t)\le c_i(P_d^t)
\quad\text{for all }t=0,\ldots,m\text{ and all }d\ne b.
\tag{7.2}
\]

**Lemma 7.1.** A TEF1 recipient map with these final bundles exists if and only
if this graph has a perfect matching. Equivalently, the subgraph induced by the
active bundle vertices has a matching saturating all those vertices.

**Proof.** A bijection assigning bundles to agents is TEF1 precisely when every
selected pair satisfies (7.2). The identity of the agent receiving a comparison
bundle does not occur in (7.2): every comparison uses the observing agent's own
costs. Thus the selected pairs are exactly a perfect matching.

For an empty or singleton final bundle, every prefix bundle is also empty or
singleton, so its residual is zero. All comparison costs are nonnegative.
Consequently every nonactive bundle is adjacent to every agent. Any matching
saturating the active bundles can therefore be extended by an arbitrary
bijection from the remaining agents to the nonactive bundles. The reverse
implication is restriction of a perfect matching. \(\square\)

This explains precisely why the names of singleton recipients may be ignored
once the active bundles and their recipients are fixed. It does not permit
ignoring singleton chores or their arrival times. If a singleton chore has not
arrived, its bundle contributes the comparison value zero. A permanently empty
bundle contributes zero at every prefix.

The edge test may include \(d=b\) without changing it, because
\(R_i(P_b^t)\le c_i(P_b^t)\) always holds. The implementation uses this equivalent
form to compare each residual with the minimum cost of all prefix bundles.

### 7.2 Nonempty normal form, including zero costs

**Lemma 7.2.** If \(S\subseteq T\), then \(R_i(S)\le R_i(T)\).

**Proof.** It suffices to add one chore of cost \(x\ge0\). If the previous largest
cost is \(M\ge0\), the residual increases by
\(x+M-\max(M,x)=\min(M,x)\ge0\). \(\square\)

**Lemma 7.3.** If \(m\ge n\) and a TEF1 allocation exists, a TEF1 allocation with
all final bundles nonempty exists.

**Proof.** Start with any feasible recipient map. If its final bundles are all
nonempty, there is nothing to do. Otherwise choose a finally empty agent \(e\).
For every agent \(i\ne e\), the final comparison against \(e\) gives
\(R_i(A_i^m)\le c_i(\varnothing)=0\). Residuals are nonnegative, so they are zero.
The empty agent also has zero residual. Lemma 7.2 implies that every agent's
residual is zero at every prefix.

Because \(m\ge n\) and some final bundle is empty, another final bundle has at
least two chores. Move one of its chores to agent \(e\) in the recipient map.
The donor's prefix bundles only shrink, so its prefix residuals remain zero by
Lemma 7.2. The new recipient owns at most one chore at every prefix. Every other
agent's own prefix bundle is unchanged. Thus every prefix residual is still
zero, which is no greater than any nonnegative comparison-bundle cost. The new
map is TEF1 and has one fewer empty final bundle. Repeating finishes after at
most \(n-1\) moves. \(\square\)

The moves construct a different map before execution. They do not claim that a
planner may reassign already completed chores during execution. This normal form
concerns final nonemptiness, not distinct recipients for the first \(n\) arrivals.

**Corollary 7.4.** Let \(m=n+k\), and take a nonempty feasible final partition. If
it has \(r\) active bundles containing \(h\) chores in all, then

\[
m=h+(n-r),\qquad h=k+r,\qquad r\le k,\qquad h\le2k.
\tag{7.3}
\]

**Proof.** The other \(n-r\) bundles contain exactly one chore each. Every active
bundle contains at least two, so \(h\ge2r\). Substitute \(h=k+r\). \(\square\)

These bounds apply to the existence of a normalized witness, not to every
feasible allocation. With \(n=m=2q\) and all costs zero, assign two chores to each
of \(q\) agents and nothing to the other \(q\). This path is TEF1 and has \(q\)
active agents although \(k=0\). Lemma 7.3 supplies a different, all-singleton
witness. Even a finally nonempty zero-cost path need not start with distinct
recipients: for \(n=2,m=3\), the path \((0,0,1)\) is an example.

### 7.3 Exact algorithm and complexity

For \(m>n\), enumerate \(r=1,\ldots,\min(n,k)\). Choose a set \(H\) of
\(k+r\) chores and partition \(H\) into \(r\) unlabelled blocks of size at least
two. Make each chore outside \(H\) its own singleton bundle. There are exactly
\(m-(k+r)=n-r\) of those bundles. For each resulting template, construct the graph
in Lemma 7.1 and seek a matching saturating its active bundle vertices.

When such a matching exists, assign the active bundles according to it and the
singleton bundles arbitrarily to the remaining agents. Otherwise continue. A
failed search over all templates returns that no TEF1 allocation exists.

For \(k\ge1\), the number of templates is at most
\[
 T(n,m)=\sum_{r=1}^{\min(n,k)}{m\choose k+r}\,p_{\ge2}(k+r,r)
 \le k\,m^{2k}k^{2k},
 \tag{7.1}
\]
where \(p_{\ge2}(h,r)\) counts partitions of \(h\) labelled positions into \(r\) unlabelled blocks of size at least two.

**Theorem 7.5.** This procedure is correct, with the template bound (7.1).

**Proof.** Lemma 7.1 proves that any returned assignment is TEF1. Conversely, if
any TEF1 map exists, Lemma 7.3 gives a nonempty one. Its active bundles satisfy
(7.3), so their set \(H\) and partition occur in the enumeration. Lemma 7.1 gives a
saturating matching for that template, which the matching algorithm will find.
Therefore the procedure cannot reject a feasible instance.

For fixed \(r\), there are \({m\choose k+r}\) choices of \(H\) and
\(p_{\ge2}(k+r,r)\) partitions. Labelling the blocks only overcounts, giving
\(p_{\ge2}(k+r,r)\le r^{k+r}\). Since \(r\le k\) and \(k+r\le2k\), summing yields
(7.1). The zero-excess case was already handled by distinct recipients.

For each template, a direct edge computation maintains all \(n\) prefix-bundle
costs in each observer row, checking its \(r\) candidate active residuals at every
prefix. This takes \(O(nm(n+r))\) rational arithmetic and comparison operations.
An augmenting-path algorithm finds a maximum matching in \(O(nr^2)\) further
steps. Prefix sums and comparisons of rational input costs have polynomial bit
cost in the input length and \(m,n\). This proves the claimed bound. \(\square\)

For arbitrary real costs the same finite procedure is an arithmetic/comparison
oracle algorithm. The bit-complexity assertion is specifically for exact
rational input. The supplied Python implementation uses `Fraction`, accepts
integer or rational-string data, and rejects floating-point and negative inputs.

### 7.4 Hall certificates of a negative decision

For a template without a saturating matching, Hall's theorem supplies a nonempty
set \(Q\) of active bundles whose neighbor set has size less than \(|Q|\).
The certificate may give any set \(U\) of agents satisfying

\[
\Gamma(Q)\subseteq U,\qquad |U|<|Q|.
\tag{7.4}
\]

To certify the inclusion, for each \(b\in Q\) and \(i\notin U\) give a prefix
\(t\) and another bundle \(d\) such that

\[
R_i(P_b^t)>c_i(P_d^t).
\tag{7.5}
\]

Exact recomputation of (7.5) verifies that \((i,b)\) is absent. Thus no matching can
saturate \(Q\), because its possible recipients are contained in the smaller set
\(U\). One such record for every enumerated template proves a negative decision,
using Lemma 7.3 to cover allocations with finally empty agents as well.

The supplied certificate verifier does not run the matching algorithm or reuse
the edge-computation routine. It checks the complete canonical template sequence,
the strict cardinality deficit, and each prefix inequality directly. It shares
the documented template enumerator with the decision routine; it is not claimed
to be a separately implemented or Lean-kernel verifier of this new algorithm.

The original nine-chore counterexample in Teh's Table 3 [1] was processed by this
algorithm. All 3,025 unlabelled nonempty templates failed and received Hall
certificates; every stored strict prefix witness passed exact recomputation.
This is a new verification representation of an attributed known counterexample,
not a new nonexistence construction or a substitute for the universal eight-chore certificate above.

### 7.5 Validation and boundaries

The recorded tests compare the algorithm with an independent recursive search
using the original existential deletion condition, rather than the residual-max
edge formula. They cover all 256 binary cost matrices of size \(2\times4\), 72
seeded rational matrices, 384 feasible paths subjected to nonempty normalization,
and all relevant singleton-recipient permutations in a four-agent fixture.
Canonical templates were compared with all surjective recipient maps in six
small \((n,m)\) cases. The zero-cost counterexample above, nonuniform zero costs,
prefix-empty singletons, and permanently empty bundles were checked explicitly.
Four damaged Hall certificates were correctly rejected.

For example, with three agents, four chores, and all costs one, the template
\(\{0,1\},\{2\},\{3\}\) is EF1 at the end but cannot be TEF1 under any labelling:
at prefix two its active recipient has residual one and compares against an empty
bundle. The algorithm rejects this template. Omitting those zero comparisons
would make its edge test unsound.

These finite checks support the implementation. Lemmas 7.1–7.3, Corollary 7.4, and Theorem 7.5 establish the
arbitrary-instance statements. Full Lean verification remains a separate deliverable.

## 8. An algorithm for repeated consecutive cost vectors

Partition the positions into \(b\) consecutive runs of equal chore cost vectors. Within a run, consider an adjacent pair in which the first chore goes to a final active bundle and the second goes to a final singleton. Swap these two recipients. The only changed intermediate prefix starts from the earlier feasible prefix and gives one chore to a previously empty agent. The recipient can delete her only chore. Other agents see only increases in her bundle. After the two positions every evaluator sees the same bundle cost multisets. Repeating this exchange puts all singleton positions first in each run.

By Corollary 7.4 the active bundles use at most \(2k\) positions. Enumerate their suffix lengths in the \(b\) runs, with global sum at most \(2k\), and partition the specified positions into unlabelled active groups. Keep only partitions in which the active and singleton counts add to \(n\). The number of guesses is bounded by \((2k+1)^b\max(1,2k)^{2k}\). The matching test of Section 7.1 decides each guess in polynomial time. This gives fixed-parameter tractability in \((k,b)\); nonconsecutive equal cost vectors never need to be brought together.

## 9. An algorithm parameterized by the excess alone

**Theorem 9.1.** For an absolute constant \(C\), when \(m=n+k\) and \(n\ge2^{C(k+1)^3}\), every instance admits a TEF1 allocation. For explicit rational costs, feasibility and witness construction take time \(f(k)\) times a polynomial in the input length. Any sequence of infeasible instances with \(n\) tending to infinity has excess \(k=\Omega((\log n)^{1/3})\).

Give the first \(n\) chores to distinct agents, choosing the bijection as below. All first \(n\) prefixes are EF1. Call those the base chores, and call the remaining \(k\) named chores the tail. We will reserve a small pool of agents who will receive the tail.

**Comparison signatures.** On a set of \(d\le2k+1\) named objects, order all subset sums using one fixed tie-breaking order on abstract subsets. An abstract object may be a common base, a tail chore, or an agent-specific symbol. Two agents with the same signature follow the same ordering, and every comparison in that ordering holds weakly for both costs. There are at most
\[
 P=(3^{2k+1}+1)^{4k+4}
\]
signatures. Each difference between two subset sums is one of at most \(3^d\) linear forms. For an arrangement of \(M\) such hyperplanes, count all signs including ties by first choosing at most \(d\) independent equations among the vanishing forms. Their joint zero set is a linear subspace on which the remaining effective forms have strict signs. For that subspace the number of chambers is bounded by \(\sum_{j=0}^d\binom Mj\): inserting one hyperplane creates at most the number of chambers of the arrangement restricted to it. There are at most this many initial choices of the independent equations as well. The product is bounded by \((M+1)^{2d+2}\), which gives \(P\). Signatures can be obtained for the actual input agents by sorting their subset sums.

**Constructing the pool.** For \(k\ge1\), put \(D=(2k+1)P\) and assume \(n\ge D^{k+1}\). Fix a tie-breaking order on the base chores. Maintain a cohort sharing the first \(c\) least costly base chores in order, a common list denoted \(C_0\). Initially \(c=0\) and the cohort is all agents. For each cohort member \(i\), let \(p_i\) be her cheapest base chore outside \(C_0\) when \(c<k\). If there are fewer than \(D\) distinct \(p_i\), retain a largest cohort with one common \(p_i\), append that chore to \(C_0\), and increase \(c\) by one. After \(c\) such steps the cohort has at least \(n/D^c\) agents.

If \(c=k\), group the cohort by its signature on the \(k\) common base chores and the tail. There are at least \(D\) agents, so there are \(k\) with a common signature. Use those agents as the pool, one per common base chore, and assign the other bases bijectively to the other agents. To every pool agent, every outside base is at least as costly as each common base.

If at some \(c<k\) there are at least \(D\) distinct \(p_i\), take a representative agent for each distinct chore. Form signatures on the \(c\) common bases, the tail, and an extra abstract symbol \(L\), valued by each representative \(i\) at \(c_i(p_i)\). Some signature is shared by at least \(2k+1\) representatives. Select \(c+k\) of that signature as the pool. Give distinct common bases to \(c\) of them and give each of the remaining \(k\) her own \(p_i\). All bases assigned thus far are distinct. Assign the remaining bases bijectively outside the pool.

For every pool agent in this second construction, treat each private base \(p_j\) as \(L\) in comparisons, with separate bundles each holding at most one such base. The agent's own pool bundle cost is exact in this virtual description, whether it contains a common or private base. Each other pool bundle's actual cost is at least its virtual cost, since every private base is outside \(C_0\) and \(p_i\) minimizes cost there for agent \(i\). Every outside singleton is also at least as costly as \(L\).

**Scheduling the tail.** At each tail arrival, select a pool agent whose current virtual bundle is smallest in the common signature. If only common bases were used, these comparisons are all exact. Before every one of the \(k\) steps some pool bundle is untouched and this base costs at most every outside singleton. In the private-base construction some one of the \(k\) private bases is untouched. Thus the selected minimum costs at most \(L\) in the recipient's evaluation and at most every outside singleton. In either construction the virtual inequalities among pool bundles imply the chosen agent's actual comparisons against every pool bundle. She is completely unenvying, so Section 2.1 permits giving her the next tail chore. Induction preserves TEF1. This proof allows all ties and zero costs.

For \(k=0\), distinct recipients suffice. In the other cases, \(\log D=O((k+1)^2)\), which proves the cutoff. Above it, the explicit construction and exact rational comparisons have time \(f(k)\) times the input polynomial. Below the exact cutoff \(D^{k+1}\), the numbers of agents and chores are both bounded in terms of \(k\), and exhaustive search over recipient maps followed by prefix verification suffices. This is a bound on the numbers of residual objects; costs retain their original bit length. The failure size claim is obtained by rearranging the cutoff inequality. \(\blacksquare\)

## 10. Related work and final source comparison

Teh §7 asks for the minimum number of chores for exact nonexistence and for unbounded approximation factors. His §3 Theorem 3.1 and Appendix A.5 construct families with \(n+O(\log n)\) chores for any fixed approximation factor, and his Table 3 gives the nine-chore instance used in Section 5. This paper proves universal existence with eight chores for three agents. The bound of Section 9 rules out exact failure when the excess is below a constant times \((\log n)^{1/3}\) for sufficiently large \(n\). The gap to the logarithmic counterexample scale remains open. Teh §4 Theorem 4.1 and §6 treat fixed agent count and, separately, approximation; they use a different parameter and objective. [Teh, §§3–4, 6–7 and Appendix A](https://arxiv.org/html/2611.25892v1)

Elkind et al. §2 define the informed temporal fairness model and study restrictions with smaller agent counts or restricted preferences. Zhang §4.1 uses a matching criterion for static EFX and §§4–5 use real linear arithmetic for a nearby static problem; the matching method and exact arithmetic are prior tools. Here the edges encode all prefix constraints, and the comparison signatures use a bounded pool for arbitrary costs and agent counts. Chen §§4–5 give temporal guarantees for different fairness notions and a separate three-agent nine-chore impossibility construction. The nine-chore matrix used here comes from Teh. [Elkind et al.](https://www.ifaamas.org/Proceedings/aamas2025/pdfs/p676.pdf) · [Zhang](https://arxiv.org/abs/2609.10585v2) · [Chen](https://arxiv.org/html/2611.23782v1)

The original Teh source and typed-cost work were screened again on 2026-11-25. Choi, Li and Teh §3 give a polynomial algorithm for fixed agent and type counts, while their Theorem 6.1 is pseudopolynomial for a fixed number of agents and bounded integral values. Their typed and integer dynamic programs impose different input restrictions from the excess parameter here. [Choi, Li and Teh, §§3 and 6](https://arxiv.org/html/2608.20033v1) Within the inspected sources, we found neither the universal eight-chore exact prefix guarantee nor an excess-only feasibility algorithm. Full Lean verification remains a separate deliverable.

## Appendix A. Fixed upstream sources and local adaptations

The upstream commit was not recorded at the initial download. During preparation of this record, the official GitHub API was used to inspect commit `c46c64088ad41a47766a27bd2464d222557a5169`. The Git blob SHA values of the following three files at that commit match the source-object identifiers recorded at retrieval. A byte-level check found that each local file has one extra LF newline byte at its end. Removing that byte and recomputing the Git blob SHA gives exactly the official object identifier in each case. The SHA-256 values below refer to the actual retained local files, including the extra newline. This establishes a reproducible content anchor without retrospectively claiming that the initial download was already commit-pinned.

- [`examples/python/proof_certificate.py`](https://github.com/Z3Prover/z3/blob/c46c64088ad41a47766a27bd2464d222557a5169/examples/python/proof_certificate.py)
  Git blob SHA: `6134905d9140213e81643c224443fdc0177c88a9`.
  SHA-256: `26bde2e31bf88382e59017fc8d6d088fb933d3a54d0e7acd16ab3ce403c63c4e`.
- [`examples/python/proof_clause_log.py`](https://github.com/Z3Prover/z3/blob/c46c64088ad41a47766a27bd2464d222557a5169/examples/python/proof_clause_log.py)
  Git blob SHA: `f9e5f92542c82c68c439e160a55a3f0065dfa042`.
  SHA-256: `b313f7daa93ae33e7c3e837c7cd0f63665a4202b18b79d3610c9b05891cbaf6e`.
- [`examples/python/proof_to_lean.py`](https://github.com/Z3Prover/z3/blob/c46c64088ad41a47766a27bd2464d222557a5169/examples/python/proof_to_lean.py)
  Git blob SHA: `dbf2a679e7f460cb2e1bccb6a20f772fe3ab85df`.
  SHA-256: `a03efc5495dfd11b2b104634f7b39f5bd199916a1e672eea2b8f262f24cda188`.

Apart from the documented final newline, the three files retain the upstream code and copyright notices. `adapt_z3_real.py` and `adapt_z3_real_stream.py` remain early Lean export adapters. They are not the current Python proof-checking entry points. The public replay and semantic check are listed with their exact inputs in the reproduction package. The preserved author's dependency is `z3-solver 5.4.1.0`; the independent checker has no external package dependency. Lean 4.19.0 is the historical target toolchain, not a claim that a Lean executable or full build was available in the recovery environment. The missing later historical checker and receipt identities are not reused.

## References

[1] Nicholas Teh. *Closing Gaps in Temporal Fair Division for Chores*. arXiv:2611.25892v1, 19 November 2026. https://arxiv.org/html/2611.25892v1

[2] Edith Elkind, Alexander Lam, Mohamad Latifian, Tzeh Yuan Neoh, and Nicholas Teh. *Temporal Fair Division of Indivisible Items*. AAMAS 2025; arXiv:2410.14593v1. https://www.ifaamas.org/Proceedings/aamas2025/pdfs/p676.pdf

[3] Xinkai Zhang. *EFX Allocations for Three Agents and Seven or Eight Chores*. arXiv:2609.10585v2, 6 October 2026. https://arxiv.org/abs/2609.10585v2

[4] Microsoft Corporation and Z3 contributors. *Native proof-certificate export, clause-log reconstruction, and Lean reconstruction scripts*. `Z3Prover/z3`, `examples/python`, content verified at commit `c46c64088ad41a47766a27bd2464d222557a5169`, accessed 24 November 2026. [Official fixed version](https://github.com/Z3Prover/z3/tree/c46c64088ad41a47766a27bd2464d222557a5169/examples/python). Appendix A records the file identifiers, verification method, and local adaptations.

[5] Tianqi Chen. *Temporal Fair Division: Simultaneous Guarantees for Goods and Chores*. arXiv:2611.23782v1, 18 November 2026, Section 5. https://arxiv.org/html/2611.23782v1
