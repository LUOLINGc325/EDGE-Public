# Information composition and sharp barriers in stable matching

**Research manuscript — revised 25 November 2026 (Asia/Shanghai).** Mathematical proofs, finite executable certificates and Lean supplements are verified separately. This manuscript is not a claim of external peer review or a completed doctoral thesis.

## Abstract

The risk-avoiding truthfulness degree is the fewest other agents whose reports can make a fixed lie harmless under every remaining completion and beneficial under at least one. We prove that every deterministic stable matching selector has degree at most three under unrestricted acceptability and at most four under complete reports, subject to the necessary side-size thresholds. A complete three-by-three selector, invariant under independent relabeling of both sides, attains four; its entire table and executable certificate accompany the paper. We also classify deferred acceptance for every finite market size in both report domains. Under unrestricted acceptability its degree is three whenever both sides contain at least two agents. With complete reports, its degree is three when the proposing side has at least three members and does not outnumber the receiving side, but falls to one when proposers outnumber at least two receivers. The remaining thin cases are strategyproof. More precisely, a receiving agent's fixed knowledge set can support a safe profitable lie for some report values exactly when it contains at least two proposers and at least one other receiver in the first two nontrivial regimes, or at least one other receiver in the proposer-surplus complete regime. Two constructive lower-bound methods establish these frontiers: a delayed-disagreement argument that keeps every proposer's report fixed, and a first-disagreement argument that stops unknown proposers by truncation or confines them by capacity. The proofs explain why information from the two sides cannot generally substitute for one another. We also give an ordinal lottery extension and state the unresolved larger-size extremal-selector problem.

**Keywords:** stable matching; partial information; safe manipulation; risk-avoiding truthfulness; deferred acceptance; computer-assisted proof.

## 1. Source problem and contribution

Hartman, Segal-Halevi and Tao introduced the known-agent measure and asked whether a stable matching mechanism can have risk-avoiding truthfulness degree growing linearly with population [HST, §3 and Open Question 8.1]. Their DA bounds are one from below, three from above when truncation is allowed, and five from above when reports must be complete.

A profitable lie at a fully specified profile need not be safe when other reports are unknown. Even if local outcomes belong to a two-element set, a selector can switch between those outcomes as a function of outsiders' reports. The universal complete-list proof fixes an additional trigger whose report forces the manipulator's true first choice throughout the information cylinder.

Write p=|M|, q=|W| and N=p+q.

| Mechanism and domain | Sizes | Result |
|---|---|---|
| Every deterministic stable selector; unrestricted acceptability | p,q ≥ 2 | R ≤ 3 |
| Every deterministic stable selector; complete reports | p,q ≥ 3 | R ≤ 4 |
| An independently relabeling-invariant complete stable selector | p=q=3 | R=4 |
| Men-proposing DA; unrestricted acceptability | p,q ≥ 2 | R=3 |
| Men-proposing DA; complete reports | 3 ≤ p ≤ q | R=3 |
| Men-proposing DA; complete reports | p>q ≥ 2 | R=1 |
| Men-proposing DA; unrestricted / complete thin cases | min(p,q)≤1 / p≤2 or q≤1 | R=N |
| Stable lotteries with the ordinal definition in §7 | Same thresholds as the first two rows | Bounds 3 and 4 |

The bounds exclude linear growth on balanced markets and on any family eventually satisfying the indicated lower bounds on both side sizes. A literal statement over all market shapes would be false: a one-person side has a strategyproof stable rule with degree N. On complete markets, choosing a side of size at most two to propose also gives a strategyproof stable rule.

The four-person cycle is classical, particularly in Roth's stable-matching impossibility argument [R82]. The contributions are the completion-uniform universal bounds, finite sharpness at four, and the exact two-domain DA classifications with necessary and sufficient information composition. The lower bounds preserve arbitrary fixed known rows: one construction holds all proposer reports fixed while modifying only other receivers, and the other holds every receiver report fixed while modifying only unknown proposers. On complete lists, a capacity invariant replaces the unavailable truncation step. These are structural statements for arbitrary finite markets, independent of the finite sharpness search. The cycle, classical DA properties and truncation as an operation are not claimed as new.

Roth and Rothblum [RR99] study stochastic dominance under symmetric beliefs; their label substitutions need not preserve arbitrary fixed proposer rows. Fernandez [F] studies regret with inference sets conditioned on observed outcomes, and Chen and Möller [CM24] study a school-choice mechanism with consent and cutoff feedback. Their information domains differ from the full product cylinders used here. Coles and Shorrer [CS12] optimize truncation payoffs under beliefs, allowing a risk of remaining unmatched. We compare exact assumptions and conclusions, rather than identifying these notions of incomplete information.

## 2. Model and information quantifiers

Let M and W be disjoint finite labeled sets. Each agent has a strict total order over opposite-side agents and the unmatched outcome ∅. A matching consists of reciprocal partial partner maps. It is individually rational when each matched agent prefers the partner to ∅. A pair (m,w) blocks a matching μ when each strictly prefers the other to their current assignment. Stability means individual rationality and no blocking pair.

In the unrestricted domain U, ∅ can appear anywhere. In the complete domain C, ∅ is last. True reports, lies and unknown completions all remain in the specified domain. A stable selector f returns a stable matching at every profile in that domain. No locality, neutrality or independence from outsiders is assumed in the universal bounds.

Fix a manipulator i, a true report t, a permitted lie ℓ, a set K of other agents, and their reports r. The remaining reports Q vary over the entire remaining product domain. The same certificate is safe and profitable precisely when

\[
\forall Q:\quad f(\ell,r,Q)(i)\succeq_t f(t,r,Q)(i),
\qquad
\exists Q_0:\quad f(\ell,r,Q_0)(i)\succ_t f(t,r,Q_0)(i).
\tag{2.1}
\]

The two runs compared for each Q use exactly the same reports of everyone except i. The true report, lie, known set and known reports are fixed across all Q. Own information is not counted. R(f) is the least |K| satisfying (2.1), or N if no certificate exists, following [HST].

**Padding observation.** If a certificate with fewer than k known agents exists, fix additional reports from one profitable completion until exactly k reports are known. Safety persists on the smaller cylinder and that profitable completion remains. Thus excluding all k-known certificates excludes smaller certificates, provided enough other agents exist.

The Lean model uses injective natural-number ranks on opposite-side agents together with 'none', with lower values preferred. Rank gaps are unrestricted. 'SafeManipulation' includes the manipulator's own true report in its agreement condition. 'RATAtMost f D k' asserts existence of a certificate with at most k known reports. It is equivalent to the numerical inequality R(f)≤k when k<N; at k=N the strategyproofness convention needs separate treatment. All formalized constant bounds below satisfy k<N. Finite permutation tables require an ordinal normalization bridge to cover arbitrary valid rank encodings; that bridge is recorded separately.

## 3. A robust four-person core

Choose distinct men a,b and distinct women x,y. Define

\[
X=\{(a,y),(b,x)\},\qquad Y=\{(a,x),(b,y)\}.
\]

Displayed prefixes stand above every omitted object, including ∅. Outside reports are otherwise arbitrary.

**Lemma 3.1 (female core).** Suppose

\[
a:y\succ x\succ\text{rest},\quad
b:x\succ y\succ\text{rest},\quad
y:b\succ a\succ\text{rest},\quad
x:a\succ\text{rest}.
\]

Every stable matching restricts to X or Y on these four agents. The order reported by x below a is arbitrary. If x rejects b, only Y is possible.

**Proof.** Suppose x is with neither a nor b. If b is not with y, then b, unable to be with x, prefers y to his assignment, and y ranks b first: (b,y) blocks. Hence b must be with y. Then a is with neither x nor y, so (a,x) blocks. Therefore x is with a or b.

If x is with a, the same (b,y) argument forces b with y, giving Y. If x is with b but a is not with y, then a ranks y first; y cannot be with b and ranks a above every remaining possibility. Thus (a,y) blocks, so the matching must be X. Rejection of b excludes X by individual rationality. ∎

**Lemma 3.2 (male core).** If b ranks x,y first, x ranks a,b first, y ranks b,a first, and a ranks y first, every stable matching also restricts to X or Y. If a rejects x, only X is possible.

**Proof.** Exchange the two sides in Lemma 3.1. Stability is invariant under that exchange. ∎

The truthful cycle fixes a:y>x, b:x>y, x:a>b, y:b>a. Woman x prefers Y and man a prefers X. Although every completion has one of these core outcomes, the mechanism may select between them using arbitrary outside reports.

## 4. Universal bounds

**Theorem 4.1.** For p,q ≥ 2, every deterministic selector stable throughout U satisfies R(f) ≤ 3.

**Proof.** Fix complete true reports with the displayed cycle at the top; complete truth is allowed in U. Complete the other reports to one profile P⁰. Its stable core outcome is X or Y.

If it is X, let x manipulate, know a,b,y, and report that only a is acceptable. For every completion, Lemma 3.1 and individual rationality force the reported outcome Y. Thus x always obtains her true first choice a. The lie is harmless against any truthful outcome and strictly profitable at P⁰, where truth gives b.

If the core is Y, let a manipulate, know b,x,y, and accept only y. Lemma 3.2 forces X under every completion, gives a his true first choice, and strictly improves at P⁰. The existential choice of the branch depends on f and P⁰; once selected, the certificate is fixed over all unknown completions. Each branch knows exactly three reports. ∎

**Lemma 4.2 (complete-list triggers).** Under the female core hypotheses, let a third man c rank x first. If x reports a>c>b>rest>∅, every stable core is Y. Symmetrically, under the male core hypotheses, if a third woman z ranks a first and a reports y>z>x>rest>∅, every stable core is X.

**Proof.** The first deviation preserves x's first choice a, so Lemma 3.1 allows only X,Y. Under X, x receives b while c is elsewhere; (c,x) blocks. The second case excludes Y by (a,z). The trigger's own assignment need not be fixed. ∎

**Theorem 4.3.** For p,q ≥ 3, every deterministic selector stable throughout C satisfies R(f) ≤ 4.

**Proof.** Choose complete true reports with the truthful cycle, c outside {a,b} ranking x first, and z outside {x,y} ranking a first. Complete all reports to P⁰.

If f(P⁰) has core X, use manipulator x, known set {a,b,y,c}, and the female deviation of Lemma 4.2. Every consistent completion gives x her true first choice a after the lie; P⁰ witnesses strict improvement. If the core is Y, use manipulator a, known set {b,x,y,z}, and the symmetric deviation. It forces true first choice y for every completion and improves at P⁰. The female certificate does not know z's report; the male certificate does not know c's. Both use four reports. ∎

Only seven top positions of the other agents are used in either certificate: two each for three core agents and one for the trigger. This is a partial-report upper certificate, not a minimal-position theorem or a seven-bit bound.

Leaving the trigger unknown does not prove a universal bound of three. The reported core could still be the unfavorable endpoint at some completion, even if truth selects the favorable endpoint there. Section 5 supplies a stable mechanism of degree four, so the proposed universal three-bound is actually false on complete markets.

## 5. Sharpness: a complete three-by-three selector of degree four

**Theorem 5.1.** There is a complete 3×3 stable selector with R=4, commuting with every independent permutation of the two sides' labels.

This is a finite computer-assisted theorem. The full object, its exact predicates and an executable check are supplied; ordinary exact computation is not described as a Lean proof.

### 5.1 Encoding

Enumerate partner orders lexicographically: 0:012, 1:021, 2:102, 3:120, 4:201, 5:210. A profile has six report digits r₀,…,r₅ ordered m₀,m₁,m₂,w₀,w₁,w₂, with index

\[
I=7776r_0+1296r_1+216r_2+36r_3+6r_4+r_5.
\]

A matching code is the lexicographic permutation of women assigned to m₀,m₁,m₂; women's partners form its inverse. Any complete balanced stable matching is perfect: otherwise an unmatched man and woman would block. These six codes therefore cover all stable possibilities.

The selector table has 46,656 entries. Its digit-stream SHA-256 is

8c88f980b103329ff14edaf81914aa40abf0727d2985100619c44bd4b07bbb8e.

The complete digits appear in the executable appendix. A checksum binds the object; it does not prove its properties. The certificate fixes the digit stream independently of any JSON whitespace or other serialization choices.

### 5.2 Exhaustive predicates and proof

An independent verifier reconstructs rankings, inverse matchings, profile indices, information cylinders and label actions without importing the synthesis program.

| Check | Exhaustive count | Result |
|---|---:|---|
| Actual selected matching stability | 46,656 profiles | No blocking pair |
| All profile–candidate matching pairs | 279,936 | Stable-set histogram: 34,080 with one; 11,484 with two; 1,092 with three |
| Three-known information cylinders | 388,800 | No safe profitable cylinder |
| Comparisons inside those cylinders | 13,996,800 | Every profitable cylinder has a harmful completion |
| Independent side relabelings | 1,679,616 profile–relabeling pairs | No equivariance failure |

The cylinder count is 6 agents × 6 truths × 5 different lies × 10 known triples × 216 known-report combinations, with 36 completions each. Of the cylinders, 99,036 have both gain and loss, 251,100 have loss but no gain, and 38,664 have neither. The padding observation excludes all certificates with at most three known reports.

For the upper witness, m₀ truthfully reports 012 and lies with 021. Know m₁:012, m₂:120, w₀:201 and w₁:021. Only w₂ is unknown. For her six reports in lexicographic order, the change in m₀'s true rank, lie minus truth, is

\[
(-1,0,-1,-1,0,0).
\]

Thus the lie is harmless and sometimes profitable. At w₂:012 the men's partner vector changes from (1,2,0) to (0,2,1), improving m₀ from w₁ to w₀. The truthful and reported profile indices are 798 and 8574; adding u=0,…,5 varies the only unknown report. This proves R=4.

For arbitrary injective complete rank functions, normalize each row to its ordered permutation. Strict and weak comparisons are preserved. Reports fixed in the original information set remain fixed after normalization, and every unknown permutation has a legal representative. A rule depending only on normalized orders cannot acquire a profitable manipulation by changing numerical gaps alone. When lifting a normalized completion back to a raw-rank information cylinder, restore the exact original own and known rows; ordinal equivalence alone is not equality of reports. The Lean supplement records this bridge as a distinct obligation.

### 5.3 Construction and scope

The discovery program used 1,300 profile orbits under independent side relabelings, with 352 orbits admitting multiple equivariant stable choices. It constrained choices to stable outcomes invariant under orbit stabilizers. Each observed safe profitable three-known cylinder generated the disjunction: some completion must be harmful, or no completion may be profitable. The retained run used six refinement rounds and 666 such constraints. Correctness relies on the subsequently verified full table, not on the solver reporting satisfiability.

Theorems 4.3 and 5.1 show that four is the least constant bounding all complete stable selectors at all sizes with p,q ≥ 3. This does not establish attainability at every larger individual size. Adding outsiders can introduce new low-information manipulations, so preservation of a lower bound requires a new proof.


## 6. Deferred acceptance: exact degrees and information composition

### 6.1. Model and classification

Let `M` and `W` be disjoint finite sets of men and women, with sizes `p` and `q`, and put `N=p+q`. Every report is a strict order of the opposite side together with the unmatched outcome `∅`. An agent is acceptable precisely when ranked above `∅`. In the **complete domain** `C`, all opposite-side agents are acceptable. In the **unrestricted domain** `U`, `∅` may appear anywhere. True reports, deviations, known reports and unknown completions all belong to the specified domain. Write `DA` for men-proposing deferred acceptance.

Fix an agent `i`, her or his true report `R_i`, a possible report `L_i`, a set `K` of other agents, and one report for each member of `K`. For a completion `V` of all still-unknown reports, let `P^R(V)` and `P^L(V)` be the profiles with the same other reports and with `i` reporting `R_i` and `L_i`, respectively. The deviation is **safe and profitable** precisely when

\[
\forall V,\quad \operatorname{DA}(P^L(V))(i)
\succeq_{R_i}\operatorname{DA}(P^R(V))(i),
\tag{D1}
\]

and the inequality is strict for at least one completion `V`. The reports of `i` and of the known agents are fixed before the universal quantifier. A completion need not yield a strict gain. The agent's own report is not counted as known information. In domain `U`, a partner below `∅` is worse than being unmatched in the true comparison, even if accepted under the lie.

The RAT-degree is the minimum `|K|` for which such a certificate exists. If no certificate exists, we use the source convention `R(DA)=N`; this convention also defines the value for empty markets.

**Theorem D1 (all market shapes).** For nonnegative integers `p,q`, the exact degrees are as follows. The complete-domain rows constitute (D2), and the unrestricted-domain rows constitute (D2U).

| Domain | Market sizes | Exact RAT-degree |
|---|---|---|
| Complete `C` | `p≤2` or `q≤1` | `N=p+q` (strategyproof) |
| Complete `C` | `p>q≥2` | `1` |
| Complete `C` | `3≤p≤q` | `3` |
| Unrestricted `U` | `min(p,q)≤1` | `N=p+q` (strategyproof) |
| Unrestricted `U` | `p,q≥2` | `3` |

Each regime with value `N` is strategyproof for all agents, so the sentinel records absence of any profitable manipulation even under complete information.

There is a sharper statement than the minimum total number of known reports. Fix a woman `x`, a set `K_M⊆M` of known men, and a set `K_W⊆W\{x}` of known other women. Their identities are fixed. Let

\[
\mathcal E_x^{\mathcal D}(K_M,K_W),\qquad\mathcal D\in\{C,U\},
\]

mean that there **exist** a true report and a lie for `x`, and reports for exactly those known agents in the indicated domain, for which (D1) and strict profitability hold in that domain.

**Theorem D2 (information composition).** For every fixed `x,K_M,K_W`, the existence statement is characterized by the following necessary and sufficient conditions. The complete-domain rows constitute (D3), and the unrestricted-domain row constitutes (D3U).

| Domain | Market sizes | Necessary and sufficient condition for `E_x` |
|---|---|---|
| Complete `C` | `3≤p≤q` | At least two known men and at least one known other woman |
| Complete `C` | `p>q≥2` | At least one known other woman; any number of known men |
| Unrestricted `U` | `p,q≥2` | At least two known men and at least one known other woman |

In each domain's strategyproof regime, the corresponding `E_x` is false for every pair of sets. Thus the minimal information-composition pair is `(2,1)` throughout the nontrivial unrestricted domain, and is `(2,1)` without proposer surplus or `(0,1)` with proposer surplus in the complete domain. The equivalent statements for budgets `k_M,k_W` use “at most” these numbers of known reports. These are existence statements over report values; knowing an arbitrary collection of report values with these counts need not permit manipulation.

### 6.2. DA facts used in the proofs

In sequential DA, an enabled man is free and has an untried acceptable woman. He proposes to his highest-ranked such woman. She retains her preferred acceptable man among the proposer and her current holder. Each pair is considered at most once, so the procedure terminates. Under complete reports, a woman who receives a proposal becomes occupied and never becomes vacant again. Holders improve according to the woman's report; rejected men do not return.

We also use DA on an auxiliary profile in which one woman accepts only a prefix. Its outcome is stable and proposer-optimal. Here is the standard rejection argument. Fix any stable matching `σ`. If a pair of `σ` is rejected, take the earliest such rejection, at which `w` rejects `m=σ(w)` while retaining a man `m'` she prefers. Individual rationality of `σ` excludes rejection solely because `m` is unacceptable. Before proposing to `w`, man `m'` was rejected by every woman he prefers to `w`. By earliest choice, his `σ`-partner is not among them; and it is not `w`, which is assigned to `m`. Thus `m'` prefers `w` to his `σ`-partner, and `(m',w)` blocks `σ`, a contradiction. No pair of a stable matching is rejected.

The terminal result is individually rational. If a man preferred another woman to his terminal result, she rejected him; her terminal holder is at least as good in her reported order, so they do not block. The result is therefore stable. A man who preferred his partner in another stable matching would have been rejected by that partner, contradicting the preceding argument. This proves proposer optimality. Strict male orders imply uniqueness of a proposer-optimal stable matching, and hence independence of the legal proposal schedule.

Finally, we use the classical proposer-strategyproofness theorem: no man gains by changing his own report in men-proposing DA, with all other reports fixed [R82, Theorem 5 and §5]. Accordingly all possible safe profitable manipulators in this chapter are women. Stability, proposer optimality, schedule independence and proposer strategyproofness are classical ingredients, not new contributions.

### 6.3. Capacity confinement and at most one known man

**Lemma D3 (capacity confinement).** Suppose the domain is `C` and `p≤q`. At any state of a sequential DA execution, let `H` be its occupied women and `F=W\H`. Consider a collection of men whose still-untried suffix, at that state, begins with every member of `F`. None of these men can subsequently propose outside `F`.

**Proof.** Every woman of `H` remains occupied. If one of the specified men first proposed outside `F`, he would be free after already proposing to every member of `F`. Every member of `F` would then also be occupied. All `q` women would hold distinct men while this man remained free, requiring at least `q+1` men. This contradicts `p≤q`. The argument is independent of preferences within `F`, of later changes of its holders, and of releases of men from `H`. ∎

**Theorem D4 (complete lists: one known proposer is insufficient).** Suppose `p≤q` and the domain is `C`. A woman cannot have a safe profitable lie if at most one man's report is known, even if arbitrarily many other women's reports are known.

**Proof.** Fix her true report `R`, lie `L`, and all known reports. If no completion gives different outcomes, the lie cannot be profitable. Otherwise choose one that does, and couple two legal sequential executions until their first different decision. If a known man `c` exists, always process him whenever he is free and enabled before selecting an unknown man.

Only the manipulating woman `x` can make the first different decision. She already holds a man, since both complete reports accept a sole proposer. Let `a,b` be the two men in that comparison, named so that truth retains `a`, the lie retains `b`, and `a≻_R b`. A free man cannot have exhausted his complete list when `p≤q`: all `q` women would then be occupied while he remained free. Every free man other than the new proposer is therefore unknown: when that proposer is unknown the priority rule makes `c` held, and when it is `c` there is no other known man. In particular, if `c` is outside `{a,b}`, he is held elsewhere.

Let `F` be the women still vacant immediately before this decision. They have never received a proposal. Thus every member of `F` lies in every man's untried suffix. The presence of a free proposer and `p≤q` imply `F` is nonempty. For every unknown man, keep his report through the last proposal in the common prefix, including the proposal that triggers the different decision, and put all of `F`, in any one fixed order, at the front of his remaining suffix. Leave every woman's report unchanged; leave `c`'s report unchanged if he exists.

These edits define one complete profile that preserves both common histories and every known report. In each continuation, Lemma D3 confines every unknown man to `F` after the decisive comparison. The lemma also covers an unknown man who is held at that moment and released later.

If `c` does not exist, no man can propose to the already occupied `x` again. If `c` is outside the decisive pair, he is held at a woman in `H`; a first subsequent rejection of `c` would require an unknown man to propose to that woman, contrary to confinement. So `c` stays held. If `c` belongs to the decisive pair, he has already proposed to `x`. If later free, he cannot propose to her twice. Any unknown man he displaces elsewhere is still confined to `F`. Thus in every case no new proposal reaches `x`.

Her truthful and lying terminal partners at this single edited completion are consequently `a` and `b`. The lie is strictly harmful, contradicting safety. All women other than `x` retained their original reports, so the argument permits any number of known women. ∎

**Theorem D4U (unrestricted lists: one known proposer is insufficient at every size).** In domain `U`, for arbitrary `p,q`, a woman cannot have a safe profitable lie knowing at most one man's report, even if arbitrarily many other women's reports are known.

**Proof.** Fix a completion at which her truthful and lying outcomes differ. Couple executions until their first different decision, always processing the sole known man `c`, if present, whenever he is free and enabled. At the different decision, `x` chooses between the new proposer, her old holder if any, and `∅`. Let the truthful and lying choices be `a,b∈M∪{∅}`. They are different, and truthful choice from this common candidate set gives `a≻_R b`. A nonempty old holder is acceptable under both reports, since the preceding history is common. The different decision may therefore involve `∅`, including when `x` first accepts a proposal under only one report.

For every unknown man, retain exactly his already-proposed prefix, including the proposal that triggers the different decision when he is that proposer. Put `∅` immediately after this prefix, and place every remaining woman below `∅`, preserving their relative order. All women in the retained prefix were acceptable when approached; the edit preserves their order and acceptability, and hence the common history. Leave the known man's report and every woman's report unchanged. This is one legal completion in domain `U`.

No unknown man can make any new proposal after the decisive step: if held, his current woman remains acceptable, but after a later rejection he has no untried acceptable woman. If `c` is not involved in the decisive comparison, the priority rule makes him either held or already exhausted. In the held case no unknown man can make a new proposal to release him; in the exhausted case he cannot act. If `c` is involved, he has already proposed to `x`, whether he is the proposer or the previous holder. If subsequently free, he cannot return to `x`; any unknown man he releases elsewhere has no further acceptable proposal. Thus no new proposal reaches `x`, whose final results remain `a,b`. The lie is strictly harmful.

The proof does not require `p≤q`. It uses the ability to stop unknown male lists immediately after their common history, an edit unavailable on the complete domain. ∎

### 6.4. No known other woman: preserve every male report

**Theorem D5 (fixed proposer reports, either domain).** In either `C` or `U`, for arbitrary finite `p,q`, fix all male reports `P_M` and two reports `R,L` of a woman `x`. If the two DA outcomes for `x` differ at some vector `Q` of other women's reports in that domain, there is another vector `Q*` in the same domain for which

\[
\operatorname{DA}(P_M,R,Q^*)(x)
\succ_R
\operatorname{DA}(P_M,L,Q^*)(x).
\tag{D4}
\]

In particular, with no known other woman's report there is no safe profitable lie, even if every male report is known.

**Proof.** Start at a vector `Q` where the outcomes differ. Build a common execution prefix as follows. At any common state, execute an enabled proposal if the receiving woman's decision would be the same under `R` and `L`; defer every proposal that would yield different decisions. Only a proposal to `x` can be deferred. Every executed step consumes a new pair, so this process stops.

Let `D` be the enabled free men at the stopping state. It is nonempty: otherwise that state would be terminal in both executions, contrary to their different DA outcomes and schedule independence. Every man of `D` has `x` as his next untried acceptable woman. Let `h` denote her holder, or `∅` if she is vacant. Because the preceding history is common, `h⪰∅` under both reports. For every `d∈D`, comparing `d` with `h` gives opposite results under the two reports. Every other free man has exhausted his acceptable list; write `E` for this set. In domain `C`, nonemptiness of `D` forces `h≠∅`; in domain `U`, `h=∅` is allowed.

For each occupied woman `y≠x`, move her current holder `h_y` to the top of her report, preserving the order of all other alternatives, including `∅`. Leave the other female reports and all male reports unchanged. This defines `Q*` in the same domain and preserves the entire common prefix. Before `h_y` proposed, all her comparisons involved other alternatives. At his unique proposal she accepted him, and she never rejected him afterwards, since he is still her holder at the stopping state. Promoting him preserves all these decisions. Hence the same modified reports support both prefixes. Subsequently every such woman permanently retains her holder.

Now let all members of `D` propose to `x`, once each, without interleaving other proposals. This is legal because each is free until his own turn and has `x` next. After the batch, her result is the `R`-best alternative `a` in `S=D∪{h,∅}` under truth, and the `L`-best alternative `b` in `S` under the lie. These maxima differ. Since `h⪰∅` in both orders, a common maximum outside `D` could only be `h` (including `h=∅`); it would place every `d∈D` below `h` in both orders. A common maximum in `D` would be above `h` in both orders. Either possibility contradicts the reversal for that man, and `D` is nonempty. Therefore `a≻_R b`. This comparison of the whole fixed set remains valid when the holder changes during the batch.

Immediately after the batch, every free man outside `E` is a rejected member of `D`, or the previous nonempty holder `h`; all have already proposed to `x`. Men in `E` are permanently unable to act, because their male reports are unchanged and no untried acceptable woman remains. They need not have proposed to `x` in domain `U`. Men held by other originally occupied women can never be released, because those holders were promoted to first place. Women originally vacant can only accept and later release men from the active population that already proposed to `x`; their ability to reject unacceptable men does not add any new active man. Inductively, every subsequently active man has already approached `x`, and no second proposal to her is possible. Her results remain `a` and `b`, possibly including `∅`, to termination. This proves (D4).

For a known set containing only men, take a profitable completion and apply this construction with its entire male vector fixed. The harmful completion preserves all known reports. No inequality between `p` and `q` was used. ∎

### 6.5. Two known men and one known woman suffice

**Proposition D6 (complete-list certificate).** If `p≥3,q≥2`, a safe profitable complete-list deviation exists with two known men and one known other woman.

**Proof.** Choose distinct men `a,b,c` and women `x,y`. Every displayed prefix is followed by all remaining agents in a fixed strict order, then `∅`. Fix

| Agent | True or known report | Role |
|---|---|---|
| `x` | `a ≻ b ≻ c ≻ rest` | Manipulator |
| `a` | `y ≻ x ≻ rest` | Known man |
| `b` | `x ≻ y ≻ rest` | Known man |
| `y` | `b ≻ a ≻ rest` | Known woman |

Let `x` report `a≻c≻b≻rest`. The man `c` is unknown.

For any completion, choose a legal schedule that first lets `a` propose to `y` and `b` to `x`. Under truth, these holdings are permanent. No outside man outranks `b` at `x` or `a` at `y`. The only men who could break the holdings are the two held men themselves, and neither is free. Thus the truthful partner of `x` is always `b`.

Under the lie, the same holdings persist until `c` proposes to `x`. If he never does, her partner remains `b`. If he does, she keeps `c` and rejects `b`. Man `b` next proposes to `y`, who ranks him first and releases `a`; man `a` next proposes to `x`, who ranks him first and keeps him permanently. Thus her lying partner is either `b` or `a`, always weakly better in her true order. Choosing the unknown report of `c` to rank `x` first ensures the second case and strict gain. The known set is exactly `{a,b,y}`. ∎

**Proposition D6U (truncation certificate).** If `p,q≥2`, domain `U` admits a safe profitable deviation with two known men and one known other woman.

**Proof.** Choose men `a,b` and women `x,y`. Use the same reports for `a,b,y` as in Proposition D6, and let `x`'s true report start `a≻b≻rest≻∅`. These four fixed reports are complete, which is allowed in domain `U`; all other reports may have arbitrary acceptability. Let `x` report only `a` acceptable, placing `∅` immediately after `a` and every other man below it.

The truthful holdings `x-b,y-a` form and remain closed against all outsiders exactly as in Proposition D6. Under the lie, `x` rejects `b`; his next proposal to `y` displaces `a`, whose next proposal to `x` is accepted permanently. Other men are unacceptable to `x` and cannot disrupt the chain, while `y` ranks `b` first. Thus every completion gives the strict improvement `b` to `a`. This is the familiar two-by-two truncation certificate, recalled to establish the sufficiency side and attributed to the existing DA bound in [HST, §8.1]. ∎

### 6.6. One known woman suffices with proposer surplus

The stronger certificate in this regime needs two elementary lemmas.

**Lemma D7 (stable rank bound).** If `p≥q≥1`, every woman in every stable matching at a complete profile is matched to one of her first `q` men.

**Proof.** An unmatched woman would coexist with an unmatched man and they would block. If her partner were outside her first `q` men, all these preferred men would have to be matched elsewhere, since an unmatched one would block with her. There are only `q-1` other women, a contradiction. ∎

**Lemma D8 (common-prefix invariance).** Suppose `p≥q≥1`, only a woman `x` changes her complete report, and the two reports share an ordered prefix `A`. If both DA partners of `x` lie in `A`, the entire two DA matchings are identical.

**Proof.** Let the two matchings be `μ,ν`. Form an auxiliary report for `x` that accepts only `A`, in its common order, and let `ρ` be DA at that auxiliary profile. The matching `μ` remains stable there: its assignment to `x` is acceptable, and deleting acceptability below that assignment creates no blocking pair. Proposer optimality makes `ρ` weakly better than `μ` for every man.

By Lemma D7, `μ` matches all `q` women. Its `q` matched men must remain matched in `ρ`, because their unchanged complete reports rank any partner above being unmatched. Hence `ρ` also matches all women, and its individual rationality gives `ρ(x)∈A`. Restoring the first complete report creates no blocking pair for `ρ`: every newly acceptable man is below `ρ(x)` in `x`'s order. Therefore `ρ` is stable at the original profile. Proposer optimality there makes `μ` weakly better than `ρ` for every man. Strict male orders imply `μ=ρ`. Applying the same argument to the second complete report gives `ν=ρ`, so `μ=ν`. The auxiliary truncation is used only in this proof; the actual deviation is complete. ∎

**Proposition D9 (one-receiver certificate).** If `p>q≥2`, there is a safe profitable deviation knowing one other woman's report and no man's report.

**Proof of safety.** Choose `q+1` distinct men

\[
a_1,\ldots,a_{q-1},c,d
\]

and two women `x,y`. Let `A` denote the ordered prefix `(a_1,…,a_{q-1})`. Fix `x`'s true report and the only known report as

\[
R_x:A\succ c\succ d\succ\text{rest},\qquad
R_y:c\succ A\succ d\succ\text{rest}.
\]

The lie is `L_x:A≻d≻c≻rest`. All unspecified tails are fixed and complete. For any completion, write `μ,ν` for truthful and lying DA. Lemma D7 gives

\[
\mu(x)\in A\cup\{c\},\qquad
\nu(x)\in A\cup\{d\}.
\]

In fact `ν(x)≠d`. Otherwise every man of `A` must be matched away from `x`, since an unmatched one would block with her. These `q-1` men fill all `q-1` other women, including `y`. Man `c` is then unmatched, while `y` ranks him first; `(c,y)` blocks `ν`. Thus `ν(x)∈A`.

If `μ(x)∈A`, Lemma D8 gives `μ=ν`. If `μ(x)=c`, the lying partner in `A` is strictly better. This proves safety for all unknown male and female reports, including the possibility that the truthful result is already in the common prefix.

**Strict gain at every such size.** Name the remaining women `z_2,…,z_{q-1}`, with no such women when `q=2`. Choose unknown reports with

\[
a_1:y\succ x\succ\text{rest},\qquad
c:x\succ y\succ\text{rest},\qquad
d:x\succ y\succ\text{rest}.
\]

For `2≤j≤q-1`, make `a_j` and `z_j` mutual first choices. Every remaining man ranks `x` first; all unused positions are filled strictly and completely. The pairs `(a_j,z_j)` form permanently. The extra men are below the core men at `x,y` and cannot displace a first-choice holder at any `z_j`.

Under truth, `x` keeps `c` and `y` keeps `a_1`; these holdings remain closed against all later proposals. Under the lie, `x` first keeps `d` and rejects `c`; then `c` proposes to `y`, who releases `a_1`; finally `a_1` proposes to `x`, who keeps him as her first choice. Thus the deviation changes `x`'s outcome from `c` to `a_1`, a strict gain. Only `y` was known. ∎

### 6.7. Thin markets and completion of the classification

**Lemma D10 (strategyproof boundaries).** In domain `C`, men-proposing DA is strategyproof for all agents if `p≤2` or `q≤1`. In domain `U`, it is strategyproof for all agents if `min(p,q)≤1`.

**Proof.** Proposers are strategyproof by the classical theorem. In domain `C`, consider a receiving woman when `p≤2`, and couple two runs until her first different decision. If none occurs, the outcomes coincide. Otherwise she must compare two distinct men, because both complete reports accept a first proposal. These are all the men in the market. Her truthful run therefore keeps her true first choice forever, so the lying run cannot improve her final outcome. For `p≤1` there cannot even be such a comparison.

If `q=1` in domain `C`, every man proposes to the unique woman; truth gives her her first choice, and each man has a unique complete order.

For domain `U`, if there is just one man, a woman's two possible outcomes are that man and `∅`. If she truly finds him unacceptable, truth always gives `∅`, her best possible outcome. If she finds him acceptable, a report that retains that acceptability changes no decision, and declaring him unacceptable cannot yield a better outcome. The man's strategyproofness remains classical. If there is just one woman, the set of men willing to propose to her is fixed by their reports; truth selects her best alternative among these men and `∅`, which no lie can improve. Proposers again cannot gain. If either side is empty, everyone remains unmatched regardless of reports. ∎

**Proof of Theorems D1 and D2.** In domain `C` with `3≤p≤q`, Theorem D4 requires at least two known men and Theorem D5 requires at least one known other woman. Proposition D6 attains both requirements simultaneously. Hence the minimum total knowledge is three.

For `p>q≥2` in domain `C`, Theorem D5 excludes every knowledge set containing no other woman, irrespective of how many men it contains. Proposition D9 attains the lower bound with one known woman, giving total degree one. In domain `U` with `p,q≥2`, Theorems D4U and D5 require at least two known men and one known other woman; Proposition D6U attains both requirements, giving total degree three. Lemma D10 gives strategyproofness and the sentinel `N` in the remaining regimes, proving (D2) and (D2U).

For the fixed-identity sufficiency in (D3) and (D3U), choose the required `a,b` and `y` within the given `K_M,K_W`, or just `y` in the complete surplus regime. Relabel the corresponding certificate and choose one of its strictly profitable profiles in the indicated domain. Reveal every additional report required by the given knowledge sets from that same profitable profile. The resulting information set is a subset of the original safe set of completions, so safety persists, and the chosen strict-gain profile remains a possible completion. This proves sufficiency for exactly the prescribed sets. The lower theorems hold for every report value and therefore give the stated necessity. ∎

The complete-domain classification depends on the direction of proposals. In particular, two men proposing to three women is strategyproof, whereas three men proposing to two women has degree one. Dependence only on the smaller side's size would miss this distinction. The unrestricted lower proof explains the different surplus behavior of the two domains: it can halt every unknown man's future proposals by moving `∅` after his used prefix, while the complete-domain proof must use capacity confinement and therefore requires `p≤q`.

### 6.8. Relation to primary sources

The known-report definition is from Hartman, Segal-Halevi and Tao [HST, §§3,8]. The mathematical additions here are the market-shape classification, the information-composition frontier, and the completion constructions proving their necessity. Classic rejection arguments, proposer strategyproofness, and manipulation by complete-list permutations retain their original attribution. The inspected neighboring results below do not by themselves establish these fixed-report information frontiers; this bounded comparison is not a claim of exhaustive global priority.

Teo, Sethuraman and Tan [TST01, §2, pp. 1255–1256; §2.2] study optimal permutation manipulation under complete knowledge. Their proposal-observation discussion allows rejection and repeated computation. A fixed lie safe under every unknown completion imposes different quantifiers. Roth and Rothblum [RR99, §§4–5, especially pp. 32–34, Corollary 2 and Theorem 2] use symmetry of beliefs and stochastic dominance; an arbitrary fixed vector of known reports need not satisfy that symmetry. Fernandez [F, §4, §5.3, Appendix A.1] conditions regret on an observed matching and constructs alternative profiles using both sides' reports and acceptability changes. Those constructions do not directly preserve the arbitrary fixed male vector required by Theorem D5.

## 7. Certificate transfer and stable lotteries

**Proposition 7.1 (finite certificate transfer).** Let O be a nonempty finite set of baseline local outcomes. For each candidate deviation d, specify its agent, fixed true report, fixed lie, at most k known other reports, and deviating outcome set O_d. Assume every completion of that candidate's information cylinder yields a baseline outcome in O and a deviating outcome in O_d. Assume that candidate's true preference weakly favors every outcome in O_d over every outcome in O.

Suppose a common legal profile P⁰ belongs to every candidate's true-report information cylinder, **including its manipulator's own fixed true report**, and that every o∈O has some candidate strictly preferring all of O_d to o. Any rule satisfying these response conditions has degree at most k.

**Proof.** Nonemptiness of O and the coverage hypothesis ensure that at least one candidate exists. Since P⁰ belongs to its true cylinder, the response condition puts the baseline outcome at P⁰ in O. Choose a candidate covering that outcome. Its response ranges give safety; membership of P⁰ in that same candidate's true cylinder gives strict gain. ∎

The common-profile condition cannot be weakened to agreement on known others alone. The concrete matching lemmas prove the response ranges before this abstraction is applied; the universal theorem does not hide its conclusion in a response axiom.

**Theorem 7.2 (ordinal lottery extension).** A stable lottery rule assigns a distribution over the finite matching set, with probability one on stable matchings. Define safety as weak first-order stochastic dominance of the deviating partner distribution for every completion, and profitability as strict improvement at at least one preference cutoff for some completion. Under this definition, the bounds three and four hold with the same size conditions as Theorems 4.1 and 4.3.

**Proof.** The same deviations give the manipulator her true first choice with probability one under every completion. They weakly dominate the truthful partner lottery regardless of how selection probabilities depend on reports. At the common witness let the probability of core X be s and of Y be 1−s. The female certificate removes probability s of her worse endpoint; the male certificate removes probability 1−s of his worse endpoint. One is at least 1/2, giving strict dominance. ∎

For any utility consistent with the chosen agent's true order, her expected gain at the common witness is at least half her endpoint utility gap. The factor 1/2 is sharp for selecting between these two fixed certificates when s=1/2; no global optimum over all deviations is asserted. Because the deviating assignment is the true best partner almost surely, safety also holds almost surely under every coupling of truthful and reported outcomes. This is an explicitly defined extension of the deterministic measure.

## 8. Optimal information robustness and remaining problems

For each report domain D and fixed market size, define

\[
R_D^*(p,q)=\max_{f\text{ stable on }D} R_D(f).
\]

This maximum exists: DA makes the mechanism class nonempty, and degrees take values in the finite set of integers from zero to N. Choosing the proposal direction is permitted when maximizing over mechanisms.

**Corollary 8.1 (unrestricted optimum at every size).** On U, the best possible degree among stable deterministic mechanisms is three whenever p,q≥2, and N when min(p,q)≤1.

**Proof.** Theorem 4.1 bounds every rule by three, while the unrestricted DA classification in §6 attains three at each such size. Thin-side strategyproofness gives N in the remaining cases. ∎

**Corollary 8.2 (complete-domain extremal bounds).** On C, the optimum is N when min(p,q)≤2. When p,q≥3 it lies between three and four, and at p=q=3 it is four.

**Proof.** If the smaller side has at most two members, let it propose: the thin-market theorem in §6 makes this stable rule strategyproof. Otherwise let the smaller side propose; its size is at least three and does not exceed the receiving side, so the exact DA theorem gives degree three. Theorem 4.3 supplies the upper bound four, and Theorem 5.1 attains it at 3×3. ∎

The unrestricted universal bound is therefore sharp at every individual nonthin size. For complete markets, attaining the best uniform constant at one size does not establish attainability at every size. Padding a finite selector with outsiders can create low-information manipulations by old or new agents.

The principal remaining mathematical targets are:

- decide, for each p,q≥3 beyond 3×3, whether the optimal complete stable-selector degree is three or four;
- find a structural construction or obstruction for degree-four selectors, including the role of neutrality;
- determine the optimal amount of partial-report information in a model that counts specified positions rather than entire agents' reports;
- extend the completion arguments to capacities or other substitutable-choice environments under explicitly stated domains.

These targets are not counted as completed contributions. The exact DA degrees in both strict report domains and every market shape are established in §6; they are no longer open items in this manuscript.

Independent finite checks additionally recover complete 3×3 DA degree three and unrestricted 2×2 DA degree three. The latter uses all 6⁴=1,296 strict profiles, including order below the unmatched option; the former uses 6⁶=46,656 profiles. Both agents' sides and all true/false reports are checked. These computations are consistency checks on the general classification, not the basis for extrapolating its lower bounds.

## 9. Verification, source comparison and academic scope

### 9.1 What establishes each conclusion

The universal constant bounds and the complete two-domain DA classifications have written proofs for arbitrary finite markets. Their quantifiers range over every unknown completion. The trace constructions modify only permitted unknown rows and compare truth and the same fixed lie at a single common completion. The finite degree-four selector is a computer-assisted existence theorem: the full digit table, stability predicate, all information-cylinder comparisons, a concrete four-known witness and every independent relabeling test appear in the self-contained executable appendix. Its verification uses only the Python standard library and does not import the synthesis program or require a solver.

Separate implementations attack the completion constructions, including first disagreement with the unmatched option, initially vacant receivers, exhausted free men, and both population imbalances. The author unrestricted run has 100,000 sampled inputs and zero failed construction assertions. The independent targeted run checks both domains and both lower-bound routes. These sampled checks can expose errors but do not establish the infinite families; the proofs in §6 do.

### 9.2 Formalization is a separate delivery

The Lean development uses actual reciprocal partner maps, individual rationality and blocking pairs. The compiled terminal declarations 'unrestricted_barrier' and 'complete_barrier' assume only that the rule is stable on the specified domain and construct an actual safe profitable manipulation. No hypothesis supplies the desired deviation. The ordinal-normalization bridge restores the exact original own and known rows when lifting a canonical completion. Finite semantic modules connect the table predicates to this same 'SafeManipulation' definition.

The supplement's source, complete declaration inventory, transitive-axiom audit and verification scope are versioned separately. Compiling a finite check, an abstract interface or the universal upper bounds does not certify every DA theorem, neutrality theorem or lottery statement. This manuscript makes no full-manuscript Lean claim. A released Lean supplement must identify its exact scope, audit all private and compiler-generated auxiliary declarations as well as named theorems, and pass independent source review and recompilation of the published source. The only admitted logical axioms are 'Classical.choice', 'Quot.sound' and 'propext'.

### 9.3 Relation to the research question

The bounded literature review, updated during 24–25 November 2026 in Asia/Shanghai, covers the source open question and appendix, primary neighboring papers, and the private and public case catalogs. The latest retrieved arXiv record for [HST] is version 3, dated 6 January 2026. Its matching table gives DA bounds one to three under unrestricted acceptability and one to five under complete reports. The present results close the first interval, replace the complete upper bound by three for DA, identify the complete-domain population transition, and rule out growing information robustness for all stable selectors once both sides satisfy the stated size thresholds.

The fixed-proposer lower bound preserves every male report under the harmful completion, including arbitrarily asymmetric report vectors. Barberà and Dutta [BD95] establish protective truth-telling in the all-unknown setting; their harmful-profile construction changes proposer reports. That result does not itself give our fixed-knowledge-set thresholds. This preservation condition is not supplied by the label-swapping and belief-symmetry arguments in [RR99]. Our report cylinders are also different from the observed-outcome inference domains in [F] and the school-choice consent model in [CM24]. Optimal manipulation with all other reports known [TST01], belief-based expected truncation [CS12], and complete-information equilibrium structure [KK16] do not give the same safety quantifiers. Sirguiado [S26] compares the number of manipulators at each profile rather than the reports one agent must know. The scope of the material actually accessed is recorded in the source audit; the publisher abstract and introduction of [KK16] were available, while a direct full-text request was blocked.

A further close source is Ehlers [E04], whose publisher abstract describes knowledge of impossible, possible and certain proposals and uncertainty about proposals following a rejection. The full text was not obtained despite alternate-source searches. Consequently we do not exclude the possibility that some completion tools follow from results in that paper, and we do not claim priority for the tools on the basis of an abstract comparison. No identical two-domain information-composition classification or the same universal sharp constant result was identified in the material actually retrieved. This is a bounded novelty finding, not a global-priority certificate. Classical stability, proposer optimality, proposer strategyproofness, the four-person cycle and the availability of truncation remain attributed to prior work. The research contribution is assessed from the proved structural statements and their relation to those sources; neither manuscript length nor formalization volume substitutes for academic value. Independent internal review and external peer review are distinct.

## References

[HST] Eden Hartman, Erel Segal-Halevi and Biaoshuai Tao. *It's Not All Black and White: Degree of Truthfulness for Risk-Avoiding Agents*. EC 2025; arXiv:2502.18805v3, 6 January 2026. [Full text](https://arxiv.org/html/2502.18805v3), [PDF with appendices](https://arxiv.org/pdf/2502.18805v3), [DOI](https://doi.org/10.1145/3736252.3742658).

[R82] Alvin E. Roth. *The Economics of Matching: Stability and Incentives*. Mathematics of Operations Research 7(4), 617–628, 1982. [Author's text](https://web.stanford.edu/~alroth/papers/1982_MOR_EconomicsOfMatching.pdf), [DOI](https://doi.org/10.1287/moor.7.4.617).

[GF13] Yannai A. Gonczarowski and Ehud Friedgut. *Sisterhood in the Gale-Shapley Matching Algorithm*. Electronic Journal of Combinatorics 20(2), P12, 2013. [Author's text](https://yannai.gonch.name/scientific/papers/2007-sisterhood-ejc.pdf), [DOI](https://doi.org/10.37236/3267). Cited for classical context, not for the present RAT thresholds.

[S26] Camilo J. Sirguiado. *Minimizing manipulation in matching markets without outside options*. Social Choice and Welfare, published 29 September 2026. [Full text and DOI](https://doi.org/10.1007/s00355-026-01679-1).

[F] Marcelo Ariel Fernandez. *Deferred Acceptance and Regret-Free Truth-Telling*. Author manuscript inspected in this research round; the retrieved version is distinguished from earlier 2018/2020 citations. [Primary text](https://economics.ucdavis.edu/sites/g/files/dgvnsk13091/files/media/documents/Fernandez_DA_regret.pdf). Relevant parts: §4, §5.3 and Appendix A.1.

[RR99] Alvin E. Roth and Uriel G. Rothblum. *Truncation Strategies in Matching Markets—In Search of Advice for Participants*. Econometrica 67(1), 21–43 (1999). [Author's text](https://web.stanford.edu/~alroth/papers/1999_E_TruncationStrategies.pdf). Relevant parts: §§4–6 and Appendix Lemmas A1–A4.

[TST01] Chung-Piaw Teo, Jay Sethuraman and Wee-Peng Tan. *Gale-Shapley Stable Marriage Problem Revisited: Strategic Issues and Applications*. Management Science 47(9), 1252–1267 (2001). [Author's text](https://www.columbia.edu/~js1353/pubs/tst-ms01.pdf), [DOI](https://doi.org/10.1287/mnsc.47.9.1252.9784). Relevant parts: §2 and §2.2.

[CM24] Yiqiu Chen and Markus Möller. *Regret-free truth-telling in school choice with consent*. Theoretical Economics 19(2), 635–666 (2024). [Publisher's text and DOI](https://doi.org/10.3982/TE4979).

[CS12] Peter Coles and Ran Shorrer. *Optimal Truncation in Matching Markets*. Author draft, September 2012. [Inspected primary draft](https://www.hbs.edu/ris/Publication%20Files/optimal_truncation_09_02_2012.pdf). A later journal version is not substituted for the inspected draft.

[KK16] Bettina Klaus and Flip Klijn. *Equilibria of deferred acceptance with complete lists*. Economics Letters 144, 98–101 (2016). [Publisher's abstract and introduction](https://www.sciencedirect.com/science/article/abs/pii/S016517651630146X), [DOI](https://doi.org/10.1016/j.econlet.2016.04.036). Full-paper access was unavailable in the bounded search.

[BD95] Salvador Barberà and Bhaskar Dutta. *Protective behavior in matching models*. Games and Economic Behavior 8(2), 281–296 (1995). [Publisher and DOI](https://doi.org/10.1016/S0899-8256(05)80002-8), [public mirror of the original paper](https://www.academia.edu/88132726/Protective_behavior_in_matching_models). Definition 1 and Theorems 1–2 with their proof were inspected in the original-paper OCR; some symbols are imperfectly recovered.

[E04] Lars Ehlers. *In search of advice for participants in matching markets which use the deferred-acceptance algorithm*. Games and Economic Behavior 48(2), 249–270 (2004). [Publisher and DOI](https://doi.org/10.1016/j.geb.2003.09.007). Only the publisher abstract was retrieved; full-theorem and proof comparison remains unavailable.


## Appendix A. Complete executable finite certificate

Save the following single Python block as a file and run it with Python 3.11 or later, without the optimization flag. It contains the full immutable 46,656-entry object and performs exhaustive checks using the standard library. The proof connecting those checks to degree four is in §5; the script is not a Lean proof. The SHA check identifies the exact supplied table.

```python
# Python 3.11+; standard library only. No optimization flag: assertions are checks.
# Adapted from the independent scalar auditor; exhaustive table predicates only.
import itertools as it
import json, hashlib
P=tuple(it.permutations(range(3)))
PI={v:i for i,v in enumerate(P)}
R=tuple(tuple(v.index(j) for j in range(3)) for v in P)
D=tuple(it.product(range(6),repeat=6))
B=(7776,1296,216,36,6,1)

def idx(v):return sum(a*b for a,b in zip(v,B))


TABLE = (
    "000000111111000000000000111111111111000000111111000000000000111111111111222222222222222222444444444444444444"
    "222222222222222222444444444444444444333333333333555555555555333333555555333333333333555555555555333333555555"
    "000000101000000000000000100100001100000000100000000000000000101100001100222222222222222222424222442222244222"
    "222222222222222222224222442222444222333333333333555555555555333333555555333333333333555555555555333333555555"
    "000000111111000000000000111111111111000000111111000000000000111111111111222222222222222222444444444444444444"
    "222222222222222222444444444444444444333333111111555555555555111111111111333333333333555555444444444444444444"
    "000000111111000000000000111111111111000000111111000000000000111111111111222222222222222222444444444444444444"
    "222222222222222222444444444444444444300300313311050000555000111111111111222322323322255222555444444444444444"
    "000000101000000000000000001100000000000000101100000000000000100000101100222222222222222222424222222222442222"
    "222222222222222222444222444222224222303000000300505000550000300000055000323222223322525222252222322322225222"
    "000000100100000000000000000100101000000000101000000000000000100100001100222222222222222222244222424222242222"
    "222222222222222222424222442222244222003000003300050000505000000000001000222322323222522222552222422222222222"
    "101111111111101100111100111111111111101101111111101110111100111111111111222222222222222222444444444444444444"
    "222222222222222222444444444444444444333333333333553333533353333333353353333333333333553333553353333333333353"
    "101100101100101100101100101100101100101100101100101100101100101100101100222222222222222222424222442222442222"
    "222222222222222222424222442222244222333333333333553333553333333333353353333333333333553333533353333333353353"
    "101101111111101110111110111111111111111110111111101111111100111111111111222222222222222222444444444444444444"
    "222222222222222222444444444444444444111131113113131313511151111111111111333333333333553353554454444444444444"
    "111101111111111110111100111111111111101101111111101110101111111111111111222222222222222222444444444444444444"
    "222222222222222222444444444444444444313301311311151110501110111111111111322222323322522222444444444444444444"
    "101100101100101100101100101100101100101100101100101100101100101100101100222222222222222222424222442222224222"
    "222222222222222222422222244222242222303300303300553300553300303300553300222322322222252222322222322322253222"
    "101100101100101100101100101100101100101100101100101100101100101100101100222222222222222222222222442222244222"
    "222222222222222222444222422222224222101300101300503300101100101100101100223222223322253322542222442222224222"
    "000000111111000000000000111111111111000000111111000000000000111111111111000000222222000000000000444444444444"
    "222222222222555555555555444444555555333333333333555555555555333333555555333333333333555555555555333333555555"
    "000000000100000000000000100000001100000000101000000000000000100100000100000220002000000000000000200202044000"
    "222222222222555555555555444222444555333333333333555555555555333333555555333333333333555555555555333333555555"
    "000000111111000000000000111111111111000000111111000000000000111111111111000000222222000000000000444444444444"
    "222222222222555555555555444444444444333333111111555555555555111111111111333333333333555555555555444444444444"
    "000000111111000000000000111111111111000000111111000000000000111111111111020002222222000000000000444444444444"
    "200000222222050000505000444444444444300300313311550000050000111111111111022020323322005000055000444444444444"
    "000000001100000000000000000100101100000000000100000000000000001000100100220200002002000000000000004222404000"
    "020020222000055000005000022002000000300000300300050000555000003000500000003322020020500000050000003220050000"
    "000000100100000000000000001000000100000000100000000000000000000100101100022200000202000000000000440022004000"
    "200020202200550000050000000202044000303000000000555000055000000100001000320022200220050000500000420002400000"
    "000000111111000000000000111111111111000000111111000000000000111111111111020022121112000000000000411111441141"
    "323322333332555555555555433343445545333333333333555555555555333333555555333333333333555555555555333333555555"
    "000000101000000000000000100100100000000000001000000000000000000100001100020002021022000000000000400100140100"
    "323322323333555555555555343333555555333333333333555555555555333333555555333333333333555555555555333333555555"
    "000000111111000000000000111111111111000000111111000000000000111111111111020022121112000000000000441111411111"
    "323322313131555555555555111141411141333333311311555555555555111111111111333333131111555555555555411111141141"
    "000000111111000000000000111111111111000000111111000000000000111111111111020020111121000000000000411141141111"
    "300322311312555000005000411141141141003000313111055000500000111111111111020302123312055000505000441141111141"
    "000000000100000000000000100100001000000000100100000000000000000100000000020000100120000000000000100000000100"
    "303022000000005000500000020320505000000300303000505000505000300000055000023022003300000000050000020302000000"
    "000000101100000000000000000100100000000000000100000000000000100000101000000022021020000000000000101102000100"
    "023320000002050000050000001000040100003000100300055000555000000000100100300020300300500000055000101022441000"
    "101100111111101111101100111111111111101101111111111100111111111111111111111112121121121111411141141141441111"
    "333322323323323332333343343343433333333333333333333333553333333333353353333333333333553353333353333333553353"
    "101100101100101100101100101100101100101100101100101100101100101100101100121122121122121122441122441122441122"
    "323333333332323332433323433333323333333333333333553333333353333333353353333333333333533353533333333333353333"
    "111110111111111101101110111111111111111100111111111110101100111111111111121112121111111121141111411111441141"
    "313111113322113123411111141111411111111331331113113353151151111111111111331131313111311331111111411141111141"
    "101110111111111110111111111111111111111110111111101110111101111111111111121121111112121111411141141141141141"
    "111122313321311312111111111111411111103110311111101111111110111111111111111111123321313112141141111141141111"
    "101100101100101100101100101100101100101100101100101100101100101100101100121122121122121122441122441122441122"
    "323322323322323322423322443322323322303300303300553300553300303300553300323322323322553322323322323322353322"
    "101100101100101100101100101100101100101100101100101100101100101100101100121122121122121122441122441122141122"
    "323322121122123122441122421122421122101300301300303100501100101100101100121122323322523122151122121122121122"
    "101101111111101110111100111111111111101110111111111110101101111111111111111122111121111111111101411111141141"
    "323323333332353333333333343333443333333333333333353353533333333333533353333333333333553333533353333333353353"
    "101100101100101100101100101100101100101100101100101100101100101100101100101102101102101100101100141122101100"
    "333322333323553333333353433322543333333333333333553333533353333333333333333333333333353333333353333333553353"
    "101111111111111110101100111111111111101110111111111101111110111111111111111111121121111110111101441141411141"
    "133113323311351311151111411111141111111313311133553311111151111111111111131133133111111313511151441111411111"
    "111110111111101111101101111111111111101100111111111110101111111111111111101112111121111111101110411141441141"
    "121112123111103301551101141111411141313101113311101300111110111111111111111311313122111101511110411111411111"
    "101100101100101100101100101100101100101100101100101100101100101100101100121102101102101100101100121120141100"
    "323322303300303300303300343320403300303300303300553300503300303300553300303300323322353300353300303320553300"
    "101100101100101100101100101100101100101100101100101100101100101100101100101120101122101100101100141102401100"
    "123122101300153300101100441120141100103300103100501300151100101100101100101102303320553100501100401122101100"
    "000000111111000000000000111111111111000000111111000000000000111111111111444222444422444244444444444444444444"
    "444224444422444242444444444444444444553355553353555555555555555553555555553355553553555555555555555353555555"
    "000000101000000000000000001100001100000000101000000000000000100100001100444222444222444222444222444222444222"
    "444222444222444222444222444222444222553355553553555555555555555353555555553355553355555555555555555353555555"
    "000000111111000000000000111111111111000000111111000000000000111111111111444224444424444242444444444444444444"
    "444244444422444424444444444444444444553353113313555555555555111111111111454554443443444445544454444444444444"
    "000000111111000000000000111111111111000000111111000000000000111111111111444424444422444442444444444444444444"
    "444224444244444242444444444444444444003000111111005000555000111111111111444324443224555442455444444444444444"
    "000000101000000000000000100000001100000000001000000000000000000100100100444222444222444222444222444222444222"
    "444222444222444222444222444222444222000300005000050000005000500300055000553322553322555222555222553322555222"
    "000000000000000000000000100100001100000000101100000000000000100000001000444222444222444222444222444222444222"
    "444222444222444222444222444222444222550300003100500000550000100000001100553222444222454222454222444222444222"
    "101101111111101110111100111111111111101101111111111100111100111111111111444224444422444242444444444444444444"
    "444422444422444242444444444444444444553353553353553353553353553353553353553353553353553353553353553353553353"
    "101100101100101100101100101100101100101100101100101100101100101100101100444222444222444222444222444222444222"
    "444222444222444222444222444222444222553353553353553353553353553353553353553353553353553353553353553353553353"
    "101111111111101101111101111111111111101100111111101110101110111111111111444242444442444244444444444444444444"
    "444224444224444222444444444444444444513351111313513113151111111111111111543454444344553443454454444444444444"
    "101110111111111110101101111111111111101101111111101110111100111111111111444424444242444224444444444444444444"
    "444224444422444242444444444444444444111311113111551310151111111111111111453324444344454444544444444444444444"
    "101100101100101100101100101100101100101100101100101100101100101100101100444222444222444222444222444222444222"
    "444222444222444222444222444222444222503300503300503300503300503300503300553222553222553222553222553222553222"
    "101100101100101100101100101100101100101100101100101100101100101100101100444222444222444222444222444222444222"
    "444222444222444222444222444222444222551300103300151300551100101100101100454322443322453322554222444222444222"
    "000000111111000000000000111111111111000000111111000000000000111111111111000222444222000000000000444444444444"
    "555225454554555555555555555455544555553555553553555555555555555353555555553355555553555555555555553555555555"
    "000000101100000000000000100100100100000000100000000000000000101000001000000202044022000000000000040220400000"
    "555552544525555555555555445225454555555355555353555555555555555553555555553553553553555555555555553353555555"
    "000000111111000000000000111111111111000000111111000000000000111111111111000222444222000000000000444444444444"
    "555225444424555555555555444444444444553353113313555555555555111111111111553555443443555555555555444444444444"
    "000000111111000000000000111111111111000000111111000000000000111111111111000220444222000000000000444444444444"
    "500222444244505000500000444444444444055300111111005000550000111111111111053000444344055000050000444444444444"
    "000000000100000000000000001000100100000000000100000000000000100100101100000022440202000000000000004002400000"
    "500202000020555000050000044000045000050000050300005000505000503300055000555020500000050000005000505022000000"
    "000000100000000000000000000000101000000000001000000000000000000100101000000200404022000000000000400222040000"
    "055002000000050000055000440000404000050000101000500000000000000000100100005000040202055000050000040220004000"
    "000000111111000000000000111111111111000000111111000000000000111111111111000000111121000000000000111141441141"
    "553523553552555555555555445345455545553355553555555555555555555355555555555553553553555555555555555353555555"
    "000000101000000000000000100100001100000000100100000000000000000100101000000020000002000000000000440102400000"
    "555552453522555555555555455555545555555353553555555555555555553553555555553355553553555555555555555353555555"
    "000000111111000000000000111111111111000000111111000000000000111111111111000000411142000000000000111141441111"
    "555552411121555555555555411141411111553353113113555555555555111111111111555553143313555555555555141141141111"
    "000000111111000000000000111111111111000000111111000000000000111111111111000002111121000000000000441111141141"
    "000020413122505000055000411141411111003000111311550000505000111111111111053320113111055000050000141141411141"
    "000000100100000000000000000100001100000000100000000000000000001000100100000022040020000000000000040122001000"
    "055020543302550000055000000000500000053000003000005000505000050300550000000322550020050000005000500300505000"
    "000000001100000000000000000100100000000000100100000000000000100000101000000022100102000000000000040022400100"
    "000302441320055000005000001102400000500000001000550000055000101000001100050322000000050000500000041000040100"
    "111101111111111110101110111111111111101101111111101111111100111111111111111141111112141112411141411111111141"
    "443322443322443322443343443343443343553353553353553353553353553353553353553353553353553353553353553353553353"
    "101100101100101100101100101100101100101100101100101100101100101100101100141122141122141122141122141122141122"
    "443323443323443323443323443323443323553353553353553353553353553353553353553353553353553353553353553353553353"
    "111110111111101110101100111111111111111110111111111101101110111111111111411112411111141122411141111141141141"
    "141111443141143341111111411111111141551313113311111351151111111111111111113111141313511151511141441141411111"
    "101111111111111101101110111111111111101110111111111110111100111111111111111121411121411112441111111141141141"
    "443111113312141112141141411111111141513111113311513310111101111111111111541322413141111111141111441111411141"
    "101100101100101100101100101100101100101100101100101100101100101100101100141122141122141122141122141122141122"
    "443322443322443322443322443322443322503300503300503300503300503300503300553322553322553322553322553322553322"
    "101100101100101100101100101100101100101100101100101100101100101100101100141122441122141122141122141122441122"
    "441322143122141322141122141122141122553100103300151100551100101100101100151122441322453322151122441122141122"
    "101100111111101111111101111111111111111111111111101110111100111111111111111120441112101111111100141111441111"
    "553353443323553353553353453353453353553353553353553353553353553353553353553353553353553353553353553353553353"
    "101100101100101100101100101100101100101100101100101100101100101100101100101122441102101100101100401102441100"
    "553322453352553353553353453322443353553353553353553353553353553353553353553353553353553353553353553353553353"
    "111101111111111110101101111111111111101111111111111111101101111111111111101101411111111111101110141111111111"
    "511313111141513113111151411141411111153351111113153313511111111111111111111111411341551111151151411111411141"
    "101110111111101111101101111111111111111100111111111110101111111111111111111101141111101101111100441111411141"
    "111111413312511101511110411111141111101310113311513311151110111111111111553102111312111300151111411141111141"
    "101100101100101100101100101100101100101100101100101100101100101100101100101122441120101100101100401100441100"
    "553302403300553300503300453322403300553300503300503300553300503300503300503320553302503300503300503302503300"
    "101100101100101100101100101100101100101100101100101100101100101100101100101120401102101100101100441120101100"
    "553120103102103300551100401122441100151300103100553100101100101100101100101320443120153300551100101122441100"
    "222222222222222222000000111111111111333333333333000000000000333333111111222222222222222222444444444444444444"
    "222222222222222222444444444444444444333333333333555555555555333333555555333333333333555555555555333333555555"
    "222222222222202220022222122122200202333333333333000000000000131133101100222222222222222222242222442222224222"
    "222222222222222222424222242222244222333333333333555555555555333333555555333333333333555555555555333333555555"
    "222222222222222222000000111111111111333333333333000000000000111111111111222222222222222222444444444444444444"
    "222222222222222222444444444444444444333333333333555555555555111111111111333333333333555555444444444444444444"
    "222222222222222002000000111111111111222322323222220222000000111111111111222222222222222222444444444444444444"
    "222222222222222222444444444444444444322222322322022020555000111111111111223322222322255222555444444444444444"
    "222222222222200022022202121222102200322322322222222020020022222222022002222222222222222222442222444222242222"
    "222222222222222222242222244222422222223222222322552200222020222322502220222322323322225222255222223222522222"
    "222222222222002022202202122222221100223322222322220220000222122122202202222222222222222222244222242222422222"
    "222222222222222222224222444222242222222322223222225000200220221222221002323322322322525222222222422222242222"
    "222222222222202200101100111111111111333333333333303330131313133133313333222222222222222222444444444444444444"
    "222222222222222222444444444444444444333333333333553333333353333333533333333333333333533333533353333333353353"
    "222222222222202202122100221222202120333333333333333303133130131333301130222222222222222222444222244222244222"
    "222222222222222222224222422222424222333333333333533353533353333333553353333333333333353333353353333333333353"
    "222222222222202200101100111111111111333333333333303330111110111111111111222222222222222222444444444444444444"
    "222222222222222222444444444444444444333333333333533333511151111111111111333333333333553353554454444444444444"
    "222222222222202220101100111111111111323222223222203200101111111111111111222222222222222222444444444444444444"
    "222222222222222222444444444444444444322322222322522322151111111111111111322222223322352322444444444444444444"
    "222222222222222200201102221222122202323322222322203202222220322122122122222222222222222222242222244222422222"
    "222222222222222222242222444222244222222322322222323320223222222222323200322222323222222322252322322322553222"
    "222222222222202222121200222122201200222322322322322302222222121222221122222222222222222222224222424222222222"
    "222222222222222222422222424222242222322322222322322222202102122222202120223222222222222322424222244222222222"
    "222222222222000000000000111111111111333333333333000000000000333333111111222222222222000000000000444444444444"
    "222222222222555555555555444444555555333333333333555555555555333333555555333333333333555555555555333333555555"
    "222222222222000000000000122122000100333333333333000000000000131133101100222222222222000000000000242222044000"
    "222222222222555555555555444222444555333333333333555555555555333333555555333333333333555555555555333333555555"
    "222222222222000000000000111111111111333333333333000000000000111111111111222222222222000000000000444444444444"
    "222222222222555555555555444444444444333333333333555555555555111111111111333333333333555555555555444444444444"
    "222222222222000000000000111111111111323222322222000000000000111111111111222222222222000000000000444444444444"
    "222222222222505000005000444444444444322322323322550000550000111111111111223322223322055000555000444444444444"
    "222222222222000000000000221222000100322322323222000000000000221122101000222222222222000000000000242222400000"
    "222222222222055000505000424222440000222322322322505000550000222222500000323222223322050000055000223222000000"
    "222222222222000000000000121222101000323222323322000000000000222122001100222222222222000000000000424222404000"
    "222222222222505000555000442222040000223322322222000000555000122222100100222222323322550000005000244222004000"
    "323323333332000000000000333313111111333333333333000000000000331331111111323332323333000000000000313131441141"
    "333332333322555555555555433343445545333333333333555555555555333333555555333333333333555555555555333333555555"
    "333323323323000000000000131123100000333333333333000000000000133133101100333332323332000000000000343332400000"
    "333322323333555555555555423332555555333333333333555555555555333333555555333333333333555555555555333333555555"
    "323333323323000000000000111111111111333333333333000000000000111111111111323322323332000000000000441111441111"
    "333322333322555555555555411141441141333333333333555555555555111111111111333333333333555555555555141141111141"
    "323322323322000000000000111111111111323322323322000000000000111111111111323322323322000000000000441111441111"
    "323322323322505000505000441111411141323322323322550000550000111111111111323322323322550000055000141141141141"
    "323322323322000000000000323122001000323322323322000000000000323122001100323322323322000000000000421122041100"
    "323322323322000000555000323322450000323322323322550000500000323322550000323322323322055000005000323322005000"
    "323322323322000000000000121122000100323322323322000000000000121122100000323322323322000000000000441122040000"
    "323322323322505000500000441122100000323322323322550000055000121122100100323322323322005000050000441122041000"
    "323333323332333333311331333131313311333333333333303303101133133311311333333332333323333332143133441133333131"
    "323322333332333323343333333343433343333333333333553353533333333333553333333333333333533353353333333333533333"
    "333332323322323330303330131323333133333333333333333303301333331133131300323333333332333333321123323122333323"
    "323323323333323332443323333332433332333333333333533353353333333333533333333333333333553353533353333333533333"
    "323323323332333300101101111111111111333333333333333303111110111111111111323332333332333333141111141141441111"
    "333322323323333323111111411111411141333333333333533333151111111111111111333333333333353353551111411141141141"
    "323322323322323320111100111111111111323322323322323320111101111111111111323322323322323322441111441111141111"
    "323322323322323322111141411141111141323322323322353300511100111111111111323322323322323322451111111111441141"
    "323322323322323302301300321122323320323322323322323300323122321322121102323322323322323322341122423122441322"
    "323322323322323322323322343322423322323322323322353320553302323322523300323322323322523322353322323322323322"
    "323322323322303320101100121122121122323322323322323320121122121122101100323322323322323322121122441122141122"
    "323322323322323322121122421122141122323322323322303302151102121122121102323322323322353322521122441122441122"
    "333332333322303330131333333113113313333333333333303333331100113331131333333323333332333303331301331141133113"
    "323332323322353333533333343343333333333333333333533333353333333333533353333333333333553353533333333333333353"
    "323332333332303303333300321332333333333333333333333330131103133333301103333332323332303333133130323333131330"
    "333333333323533353333333333332353353333333333333353353333333333333333353333333333333353353533333333333353333"
    "323322323323333330111100111111111111333333333333303303101101111111111111323333333322303333101110111111441141"
    "323322333333533353111151441111111141333333333333353353151151111111111111333333333333553333511111141141441141"
    "323322323322303300101111111111111111323322323322303300111110111111111111323322323322303300101110441111411141"
    "323322323322553300511101111141411111323322323322553300511111111111111111323322323322553300101111141141141111"
    "323322323322303300101100323122303300323322323322303300303300123122101100323322323322303300301300121322401300"
    "323322323322553300553300423322343300323322323322553300503300323322303300323322323322353300503300323322303300"
    "323322323322303300101100121122101100323322323322303300101100121122101100323322323322303300101100441122441100"
    "323322323322553300501100441122101100323322323322553300551100121122101100323322323322553300101100441122141100"
    "222222222222222000444004441141441444333333333333555000555505331131551551222222222222222222444444444444444444"
    "222222222222222222444444444444444444333333333333555555555555333333555555333333333333555555555555333333555555"
    "222222222222222002422000244122241222333333333333555000555055333333555155222222222222222222424222224222244222"
    "222222222222222222422222442222242222333333333333555555555555333333555555333333333333555555555555333333555555"
    "222222222222222000444004441444441144333333333333555000545445441441444441222222222222222222444444444444444444"
    "222222222222222222444444444444444444333333333333555555444544444141441444333333333333555555455444444444444444"
    "222222222222222020444440444144441441323322322222255200455404444141441441222222222222222222444444444444444444"
    "222222222222222222444444444444444444322322323222252002554004444441441141322322223222522222545444444444444444"
    "222222222222222022244220242222224222322222223222525200222222323222252020222222222222222222242222422222244222"
    "222222222222222222244222222222242222222222222322522000552222222222252002323222323222252222525222322322225222"
    "222222222222222200422020242222444202222322222322552020222202242122422222222222222222222222444222224222242222"
    "222222222222222222242222424222224222223222322322225220255222421122424200322322323322522222254222244222222222"
    "222222222222222222444440441141444441333333333333533350533303331331351131222222222222222222444444444444444444"
    "222222222222222222444444444444444444333333333333333353533353333333353353333333333333553333533333333333353333"
    "222222222222222220222202221222241102333333333333333303531300333133331333222222222222222222424222442222244222"
    "222222222222222222244222424222242222333333333333553333533353333333353353333333333333353353533333333333533353"
    "222222222222222222441401441144444441333333333333333303441440441444441441222222222222222222444444444444444444"
    "222222222222222222444444444444444444333333333333333353554154444144444141333333333333553353544454444444444444"
    "222222222222222202444440444141441144323222322322222220541400441444441441222222222222222222444444444444444444"
    "222222222222222222444444444444444444322322222322552320544444441441444141223322323222522222454444444444444444"
    "222222222222222200222120422222242100223322322322322320553102223222222222222222222222222222244222442222242222"
    "222222222222222222224222244222422222222322322222252200223320323222253222322222323222522322522222223322252322"
    "222222222222222200244202241222222100322322322222252202451120221222442202222222222222222222442222224222242222"
    "222222222222222222244222424222224222222322223222252300222222242122422122223322322322223222422222442222424222"
    "222222222222555005555055441141545445333333333333555505555500331131551551222222222222555050555505444444555554"
    "222222222222555555555555444444455545333333333333555555555555333333555555333333333333555555555555333333555555"
    "222222222222555505555005221222555105333333333333555500555055333333551005222222222222555550555050224222444550"
    "222222222222555555555555444222544555333333333333555555555555333333555555333333333333555555555555333333555555"
    "222222222222555000555005441144441144333333333333555500555500441141441441222222222222555055555050444444444444"
    "222222222222555555555555444444444444333333333333555555555555444441444141333333333333555555555555444444444444"
    "222222222222555000555000441144441144323222323222555000555000441441441144222222222222555000555000444444444444"
    "222222222222555000555000444444444444223322322322555000555000444141444141223322223322555000555000444444444444"
    "222222222222555000555000442122441000222222323322555000555000221322555000222222222222555000555000422222545000"
    "222222222222555000555000442222545000322322322222555000555000322222555000223322223222555000555000223322555000"
    "222222222222555000555000222122441100323222223222555000555000224222441100222222222222555000555000242222444000"
    "222222222222555000555000224222444000322222222322555000555000422122441100223322322322555000555000244222444000"
    "323333323322555050555005431143451545333333333333555550555005333131555155323323323332555055555000431331441551"
    "333323323332555555555555343333545545333333333333555555555555333333555555333333333333555555555555333333555555"
    "323332323323555505555005333133541105333333333333555050555500331333555155333332323332555005555050443132545555"
    "323323333322555555555555343333455555333333333333555555555555333333555555333333333333555555555555333333555555"
    "323323323323555005555500441141441141333333333333555500555500441141441141323332333322555050555050441141441141"
    "333322333322555555555555441141441141333333333333555555555555441141441141333333333333555555555555441141441141"
    "323322323322555000555000441141441141323322323322555000555000441141441141323322323322555000555000441141441141"
    "323322323322555000555000441141441141323322323322555000555000441141441141323322323322555000555000441141441141"
    "323322323322555000555000443122545100323322323322555000555000321122551100323322323322555000555000343122541100"
    "323322323322555000555000443322445000323322323322555000555000323322555000323322323322555000555000323322555000"
    "323322323322555000555000421122441000323322323322555000555000421122441000323322323322555000555000421122441000"
    "323322323322555000555000421122441000323322323322555000555000421122441000323322323322555000555000421122441000"
    "333323323333323323433131341143333333333333333333533333333353333331533153333332333333333333431331341131443333"
    "323323323323323332333343433333343343333333333333353333533353333333533333333333333333333333533333333333533353"
    "323332333322333323333333323132441320333333333333353333531130331133333130323333333332323323433323431133333122"
    "323323323333333322433332343332343333333333333333553333533333333333533353333333333333533353353333333333333353"
    "323322333333333302441141441141441141333333333333553330551101441141441141323333323332323333441141441141441141"
    "333323333322333322441141441141441141333333333333353333541141441141441141333333333333553333541141441141441141"
    "323322323322323300441100441141441141323322323322553320541140441141441141323322323322323322441141441141441141"
    "323322323322323322441141441141441141323322323322523320541100441141441141323322323322553322551141441141441141"
    "323322323322323302441302343122323102323322323322523320321320321322551302323322323322323322321122441322341122"
    "323322323322323322443322323322443322323322323322553302523300323322323300323322323322323322553322323322553322"
    "323322323322323300441120441122421102323322323322553302521122421122441120323322323322323322441122421122421122"
    "323322323322323322421122441122421122323322323322523322541100421122421120323322323322553322521122421122421122"
    "333332333332533330353333443131331333333333333333533333551353331133353131323332333323353300351153333143433343"
    "323322323332533353333333343333433353333333333333333353533333333333553353333333333333353353333353333333533333"
    "323333323332333303551333431333453100333333333333533303331130331133531353333323333332533330353330431132333333"
    "323332333322553333353353333323353333333333333333333353533333333333553333333333333333353353333353333333533353"
    "333323323323333353551100441141441141333333333333333330551100441141441141333332323333353330551100441141441141"
    "323332333322533353551151441141441141333333333333533333551151441141441141333333333333333353551151441141441141"
    "323322323322353300551101441141441141323322323322353300551101441141441141323322323322353300551101441141441141"
    "323322323322353300551101441141441141323322323322353300551101441141441141323322323322353300551101441141441141"
    "323322323322353300553100441322343300323322323322553300351300321122553100323322323322353300353100343322541100"
    "323322323322353300353300443322343300323322323322353300353300323322553300323322323322553300353300323322353300"
    "323322323322353300551100421122441100323322323322353300551100421122441100323322323322353300551100421122441100"
    "323322323322353300551100421122441100323322323322353300551100421122441100323322323322353300551100421122441100"
    "444044441441444404444040441144444141555005555551555500555050551555555151444244444222444222444444444444444444"
    "444422444444444242444444444444444444553353555553555555555555553353555555555555553355555555555555555353555555"
    "444000441100444000444000441100441100555005551550555055555505555055551555444222444222444222444222444222444222"
    "444222444222444222444222444222444222553553553555555555555555555355555555553355555553555555555555555353555555"
    "444440444144444004444044441141441444544450441444545444554400441444444144444442444224444424444444444444444444"
    "444424444222444422444444444444444444455445444444445545545444444441441441554453444343454445445554444444444444"
    "444044441441444040444404444141444141455404444444444400555440441444444444444424444444444224444444444444444444"
    "444224444442444424444444444444444444545404444141444444554040444144444441444244444424544224445444444444444444"
    "444000441100444000444000441100441100555000551000555000555000555000551100444222444222444222444222444222444222"
    "444222444222444222444222444222444222553300555000555000555000555300555000553322553322555222555222553322555222"
    "444000441100444000444000444100441100544000441100555000444000441000441000444222444222444222444222444222444222"
    "444222444222444222444222444222444222543000444300444000555000444000444000545222443222454222455222444222444222"
    "444104441441444441444404444441441444551100551151551100551100551151551151444424444224444442444444444444444444"
    "444244444422444242444444444444444444553353553353553353553353553353553353553353553353553353553353553353553353"
    "444100444100444100444100444100444100551150551150551150551150551150551150444222444222444222444222444222444222"
    "444222444222444222444222444222444222553353553353553353553353553353553353553353553353553353553353553353553353"
    "444100441441441404441444444141444441554141444444444144541141444441441444444224444222444424444444444444444444"
    "444442444224444424444444444444444444443443443441544444454154441444441141454443444344453354554444444444444444"
    "441404441144444440441440444141444441444104444141541144554404444441441444444442444224444244444444444444444444"
    "444424444422444224444444444444444444444444444144453100541441441441441144553424444442543444554444444444444444"
    "444100444100444100444100444100444100551100551100551100551100551100551100444222444222444222444222444222444222"
    "444222444222444222444222444222444222553300553300553300553300553300553300553222553222553222553222553222553222"
    "444100444100444100441100441100444100454100444100451100544100444100444100444222444222444222444222444222444222"
    "444222444222444222444222444222444222551300444300444300451100444100441100444322443322543322554222444222444222"
    "555505544155555505555550545545441155555550555155555000555505551551555551555555455445555055555005555444545545"
    "555252444255555555555555455455554544553553555355555555555555553555555555553353553555555555555555553355555555"
    "555555445050555055555505555550545000555005551150555050555055551505555505555025555225555505555000545555454550"
    "555552455255555555555555454522445555553353553553555555555555553555555555553553555355555555555555553555555555"
    "555555444144555005555505441144444141555550444444555500555050441441441444555522444242555050555005444444444444"
    "555552444424555555555555444444444444555353443344555555555555444141441441553555444344555555555555444444444444"
    "555000441144555000555000444144441144555000444441555000555000444441441441555020444422555000555000444444444444"
    "555020444442555000555000444444444444555000441344555000555000441141444444555322443422555000555000444444444444"
    "555000445100555000555000451100541000555000555000555000555000551000555100555002455222555000555000555020445000"
    "555022545000555000555000444002455000553000555300555000555000555000555000555320553302555000555000553022555000"
    "555000444000555000555000444100441100555000444000555000555000444100441000555220444222555000555000444000444000"
    "555020444000555000555000444222444000555300443000555000555000441100441100555202444302555000555000444002444000"
    "555555451545555505555555551155445145555005555551555050555050555151551555555050541545555550555055555555445151"
    "553555555553555555555555543553555545555555553555555555555555553553555555555355553553555555555555553555555555"
    "555050551550555055555505545500441555555500551505555050555055555155555105555550555555555005555500451120545005"
    "555355443525555555555555545525445555553553555355555555555555555553555555553355553555555555555555553553555555"
    "555055441141555055555005441141441141555500441141555550555500441141441141555502441141555000555555441141441141"
    "553325443342555555555555441141441141553355443141555555555555441141441141555355443141555555555555441141441141"
    "555000441141555000555000441141441141555000441141555000555000441141441141555022441122555000555000441141441141"
    "553320443121555000555000441141441141553300443341555000555000441141441141553020443122555000555000441141441141"
    "555000445000555000555000445100451100555000551100555000555000551100555000555002451102555000555000545002545100"
    "553020455020555000555000453302455000555000553300555000555000553300555000553302553022555000555000555022555000"
    "555000441100555000555000441000441000555000441000555000555000441000441100555022441120555000555000441002441100"
    "553302443000555000555000441120441000553300443000555000555000441000441000553000443122555000555000441020441000"
    "441101441141441141441100441141441141551100551151551100551100551151551151441141441122441142441141441141441141"
    "443322443322443322443343443343443343553353553353553353553353553353553353553353553353553353553353553353553353"
    "441100441100441100441100441100441100551150551150551150551150551150551150441122441122441122441122441122441122"
    "443323443323443323443323443323443323553353553353553353553353553353553353553353553353553353553353553353553353"
    "441141441141441101441140441141441141551140441141451100541101441141441141441142441121441141441141441141441141"
    "441322443142443321441141441141441141453343441341443141551141441141441141541141443341551351451141441141441141"
    "441100441141441100441141441141441141551141441141551140451100441141441141441122441141441122441141441141441141"
    "443321441322443341441141441141441141451300441341541341541140441141441141453141443121451322451141441141441141"
    "441100441100441100441100441100441100551100551100551100551100551100551100441122441122441122441122441122441122"
    "443322443322443322443322443322443322553300553300553300553300553300553300553322553322553322553322553322553322"
    "441100441100441100441100441100441100551100441100541100441100441100441100441122441122441122441122441122441122"
    "443122441122443322441122441122441122553300443300451100551100441100441100441322443322553322551122441122441122"
    "551100541151551101551101441141551151551100551151551150551100551151551151551152541121551151551151551151441141"
    "553323543343553353553353453353453343553353553353553353553353553353553353553353553353553353553353553353553353"
    "551150451150551150551150451100541150551150551150551100551150551150551100551152441102551150551100551152451100"
    "553322553352553353553353543322443353553353553353553353553353553353553353553353553353553353553353553353553353"
    "551151441141551150551101441141441141551151441141551150551100441141441141551121441142551100551100441141441141"
    "551352441343551351551151441141441141553353443143551151551151441141441141551151443141553353551151441141441141"
    "551101441141551101551100441141441141551100441141551101551101441141441141551121441122551101551101441141441141"
    "553320441121553101551101441141441141553100443341551301551100441141441141551121441322553100551101441141441141"
    "551100441100551100551100541100551100551100551100551100551100551100551100551122441122551100551100451100441100"
    "553322553302553300553300443322443300553300553300553300553300553300553300553300553320553300553300553322553300"
    "551100441100551100551100441100441100551100441100551100551100441100441100551122441122551100551100441100441100"
    "553322441120553300551100441102441100553300443300551100551100441100441100553100443322551300551100441122441100"
    "444444444442444400444440444141441444555355555555555050555505551155555155444224444422444242444444444444444444"
    "444424444242444224444444444444444444553355553553555555555555555353555555555353553555555555555555553553555555"
    "444222444222444202444202444222444100553355555553555500555550553155551500444222444222444222444222444222444222"
    "444222444222444222444222444222444222555355555553555555555555553353555555553355553553555555555555555555555555"
    "444424444442444444444040441441441141455344444344544554555044444144441444444424444222444244444444444444444444"
    "444442444424444224444444444444444444454454443443444555544544441444441144553344444443454454445455444444444444"
    "444444444224444204444440441141441441554242443342444004544044441441444144444244444242444424444444444444444444"
    "444424444244444222444444444444444444444442443424454444545400441444441444454222444424545442554444444444444444"
    "444222444222444002444202444122444020555222555222555000555222551222555120444222444222444222444222444222444222"
    "444222444222444222444222444222444222555322555322555222555000553322555220553322553222555222555222553322555222"
    "444222444222444220444200441222444102554322444222544000454222444122441120444222444222444222444222444222444222"
    "444222444222444222444222444222444222543322443222444202555220444222441200453222444322554222544222444222444222"
    "444244444422444420441104441144444144553353553353553353551150551353551353444244444442444222444444444444444444"
    "444224444422444444444444444444444444553353553353553353553353553353553353553353553353553353553353553353553353"
    "444222444222444200441102441122441202553353553353553300551303551153551300444222444222444222444222444222444222"
    "444222444222444222444222444222444222553353553353553353553353553353553353553353553353553353553353553353553353"
    "444444444224444242441444444444444144543454444443453454444441441444441441444424444242444442444444444444444444"
    "444444444242444244444444444444444444443344444343444444451441441441441444554354443444554343444454444444444444"
    "444242444422444442444144441441441144443442443424444444551404444144441444444244444242444224444444444444444444"
    "444424444244444422444444444444444444454422444344543302454404444441441441553444444324454224554444444444444444"
    "444222444222444200441120441122441222553322553222553302551222551222551300444222444222444222444222444222444222"
    "444222444222444222444222444222444222553222553222553220553302553222553202553222553322553322553222553222553222"
    "444222444222444220441202444222441120554222443322543320544202441122441200444222444222444222444222444222444222"
    "444222444222444222444222444222444222554322443322454220541120441122444200543322444222454322544222444222444222"
    "555552455542555550555505544554445541555355553555555005555000555555555151555225454555555505555500554454545554"
    "555255445522555555555555454555554445553353553555555555555555555553555555553555555355555555555555553553555555"
    "555255544525555505555005454525555055553553555555555555555550555353555505555252555522555005555505555555455005"
    "555525444552555555555555445252554555555353553555555555555555555355555555555353555555555555555555555553555555"
    "555255444224555055555500441141444444553553444443555000555555444441441144555525444422555000555050444444444444"
    "555252444242555555555555444444444444553355443444555555555555441141444141555353444343555555555555444444444444"
    "555222444224555000555000441441441144553322443442555000555000441444444441555222444244555000555000444444444444"
    "555222444424555000555000444444444444553322444244555000555000444144444141553322443444555000555000444444444444"
    "555222455222555000555000451222454000553322553322555000555000555122551000555222444222555000555000555222545000"
    "555222555222555000555000444222544000555322553222555000555000555222555000553322553222555000555000555222555000"
    "555222444222555000555000441122441100553322443222555000555000444222441100555222444222555000555000444222444000"
    "555222444222555000555000444222444000553322444222555000555000444122441100553322443322555000555000444222444000"
    "555322445353555005555550551551545551553553555555555000555005551553555155553525555355555505555505455555541145"
    "553555453353555555555555545345445555555353555553555555555555553555555555555553553555555555555555553353555555"
    "553525555325555550555505555555441505553355555353555005555500555355555550555552453355555055555005541322451555"
    "553552445525555555555555453553445555555353555553555555555555553553555555555553553555555555555555553355555555"
    "555325443322555505555055441141441141553553443343555005555500441141441141555553443322555550555050441141441141"
    "555525443322555555555555441141441141555553443343555555555555441141441141553555443343555555555555441141441141"
    "555322443342555000555000441141441141555322443342555000555000441141441141555322443342555000555000441141441141"
    "555322443342555000555000441141441141555322443342555000555000441141441141555322443342555000555000441141441141"
    "555322545322555000555000443122555100555322555322555000555000555122551100555322543322555000555000555122451100"
    "553322455322555000555000543322445000553322555322555000555000555322555000555322555322555000555000553322555000"
    "555322443322555000555000441122441000555322443322555000555000441122441000555322443322555000555000441122441000"
    "555322443322555000555000441122441000555322443322555000555000441122441000555322443322555000555000441122441000"
    "443343443343443303443140441141443343553353553353553350553151551351551353443342443342443322443143443343441141"
    "443323443322443322443343443343443343553353553353553353553353553353553353553353553353553353553353553353553353"
    "443323443322443303441102441322443303553353553353553300553303551153553100443323443323443323441323443123441322"
    "443322443323443323443323443322443323553353553353553353553353553353553353553353553353553353553353553353553353"
    "443322443322443340441101441141441141453343443343453303451151441141441141443323443342443343441141441141441141"
    "443323443322443343441141441141441141553353443343443343541141441141441141443343443343553353541151441141441141"
    "443342443342443340441100441141441141543342443342553320441140441141441141443342443322443342441141441141441141"
    "443342443342443322441141441141441141543322443342443340451100441141441141453342443322543322551141441141441141"
    "443322443322443300441100441122441322553322553322553300553302551122551100443322443322443322441122443322443122"
    "443322443322443322443322443322443322553322553322553322553320553322553300553322553322553322553322553322553322"
    "443322443322443300441100441122441122553322443322553300441120441122441102443322443322443322441122441122441122"
    "443322443322443322441122441122441122453322443322543322551100441122441100443322443322553322551122441122441122"
    "553353443352553350553100541151453353553353553353553303551350553153551153553323543322553353551103551353443143"
    "553352453323553353553353443353543353553353553353553353553353553353553353553353553353553353553353553353553353"
    "553322443353553300551103543122541353553353553353553353553100553153551303553322443352553300551153453153543100"
    "553353543322553353553353453352543353553353553353553353553353553353553353553353553353553353553353553353553353"
    "553323443322553353551100441141441141553353443343553300551100441141441141553353443322553350551100441141441141"
    "553322443322553353551151441141441141553353443343553353551151441141441141553353443343553353551151441141441141"
    "553322443342553300551101441141441141553322443342553300551101441141441141553322443342553300551101441141441141"
    "553322443342553300551101441141441141553322443342553300551101441141441141553322443342553300551101441141441141"
    "553322443322553300551300441122553100553322553322553300553300551122551100553322453322553300551100543322441100"
    "553322553322553300553300443322443300553322553322553300553300553322553300553322553322553300553300553322553300"
    "553322443322553300551100441122441100553322443322553300551100441122441100553322443322553300551100441122441100"
    "553322443322553300551100441122441100553322443322553300551100441122441100553322443322553300551100441122441100"
)

def main():
    assert hashlib.sha256(TABLE.encode()).hexdigest()=="8c88f980b103329ff14edaf81914aa40abf0727d2985100619c44bd4b07bbb8e"
    choices=[int(c) for c in TABLE]
    assert len(choices)==46656 and all(type(c) is int and 0<=c<6 for c in choices)
    matches=[P[c]+R[c] for c in choices]
    for j,t in enumerate(D):
        mu=matches[j]
        for a in range(3):
            for x in range(3):
                assert not (R[t[a]][x]<R[t[a]][mu[a]] and R[t[3+x]][a]<R[t[3+x]][mu[3+x]]),(j,a,x)
    histogram={}
    for t in D:
        count=0
        for candidate in range(6):
            mu=P[candidate]+R[candidate]
            ok=all(not(R[t[a]][x]<R[t[a]][mu[a]] and R[t[3+x]][a]<R[t[3+x]][mu[3+x]]) for a in range(3) for x in range(3))
            count+=ok
        histogram[count]=histogram.get(count,0)+1
    assert histogram=={1:34080,2:11484,3:1092}
    print('all selected matchings stable',flush=True)
    other=tuple(it.product(range(6),repeat=5))
    sets=tuple(it.combinations(range(5),3))
    keys=[tuple((v[k[0]]*6+v[k[1]])*6+v[k[2]] for v in other) for k in sets]
    totals={'columns':0,'comparisons':0,'gain':0,'loss':0,'both':0,'tied':0,'safe_profit':0}
    for agent in range(6):
        coords=[a for a in range(6) if a!=agent]
        bases=[sum(B[a]*v[b] for b,a in enumerate(coords)) for v in other]
        outcomes=[[matches[j+t*B[agent]][agent] for j in bases] for t in range(6)]
        for t in range(6):
            trank=R[t]
            for l in range(6):
                if l==t:continue
                signs=[(1 if trank[y]<trank[x] else 2 if trank[y]>trank[x] else 0) for x,y in zip(outcomes[t],outcomes[l])]
                for key in keys:
                    flags=[0]*216
                    for k,s in zip(key,signs):flags[k]|=s
                    assert 1 not in flags,('safe profitable3known',agent,t,l,flags.index(1))
                    totals['columns']+=216;totals['comparisons']+=7776
                    totals['gain']+=sum(bool(x&1) for x in flags)
                    totals['loss']+=sum(bool(x&2) for x in flags)
                    totals['both']+=flags.count(3);totals['tied']+=flags.count(0)
        print('all knowledge columns checked for agent',agent,flush=True)
    diffs=[]
    for u in range(6):
        t=(0,0,3,4,1,u);l=(1,0,3,4,1,u)
        diffs.append(R[0][matches[idx(l)][0]]-R[0][matches[idx(t)][0]])
    assert max(diffs)<=0 and min(diffs)<0
    neutral=0
    for sm in P:
        for sw in P:
            tm=[PI[tuple(sw[x] for x in row)] for row in P]
            tw=[PI[tuple(sm[a] for a in row)] for row in P]
            mm=[]
            for row in P:
                out=[0]*3
                for a,x in enumerate(row):out[sm[a]]=sw[x]
                mm.append(PI[tuple(out)])
            for j,t in enumerate(D):
                v=[0]*6
                for a in range(3):v[sm[a]]=tm[t[a]]
                for x in range(3):v[3+sw[x]]=tw[t[3+x]]
                assert choices[idx(v)]==mm[choices[j]],('neutrality',j,sm,sw)
                neutral+=1
    print('all neutral relabelings checked',flush=True)
    assert totals['columns']==388800 and totals['comparisons']==13996800
    assert totals['both']==99036 and totals['tied']==38664
    assert neutral==1679616
    assert diffs==[-1,0,-1,-1,0,0]
    print(json.dumps({'selected_profiles':46656,'histogram':histogram,
        'information_cylinders':totals,'four_known_rank_changes':diffs,
        'neutrality_checks':neutral,'status':'all exhaustive predicates passed'},indent=2))

if __name__=='__main__':
    main()
```
