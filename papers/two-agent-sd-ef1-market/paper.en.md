---
title: "Two-Agent Ordinal Fair Division with an Independent Market Valuation"
subtitle: "Subjective SD-EF1, market EF1, and shortest complementary exchange paths"
date: "Research manuscript v1 · 24 November 2026"
lang: en
---

## Abstract

We consider the allocation of indivisible goods to two agents with possibly different subjective rankings, together with an arbitrary nonnegative additive market valuation shared by both agents. We prove that a complete allocation always exists that is stochastically-dominant envy-free up to one good (SD-EF1) for the subjective rankings and envy-free up to one good (EF1) for the market valuation. The allocation is balanced, permits weak rankings and zero values, and can be computed from the rankings and rational market weights in polynomial time. This establishes the two-agent subcase of Open Question 1 in Barman, Ebadian, Latifian, and Shah's *Fair Division with Market Values*. The argument starts from the known complementary SD-EF1 partitions of Cookson, Ebadian, and Shah. After padding to an even number of goods, we prove that the balanced allocations satisfying the two directional ordinal constraints form a connected single-exchange graph. A greedy construction joins complementary seed bundles by exactly half the padded number of goods in exchanges, which is the shortest possible length. Along this path, a crossing of half the total market value has a market-EF1 endpoint. The reference implementation uses $O(m^2)$ core operations under the usual constant-time membership model. Reproducibility materials include 52,528 exact finite checks and a partial Lean verification of 11 supporting lemmas. Neither the finite checks nor the partial formalization replaces the general mathematical proof.

## 1. Introduction

An allocation can appear fair according to personal preferences while giving the recipients substantially different resale values. The model of fair division with market values represents these two considerations by subjective utilities and a separate common market valuation. Barman et al. ask whether subjective SD-EF1 and market EF1 can always be achieved together [R1, Open Question 1](#reference-1). The distinction between the two fairness strengths matters: their Theorem 1 rules out SD-EF1 on both sides with two agents and seven goods, whereas their Theorem 2 proves that stronger guarantee for two agents and at most six goods. Their Corollary 1 establishes the reverse placement of the stronger condition, namely subjective EF1 and market SD-EF1, for general numbers of agents.

We establish the requested placement of the two conditions for **two agents and every finite number of goods**. Subjective information enters only through rankings; market values can be unrelated to either ranking. The output therefore retains its subjective EF1 guarantee under every nonnegative additive utility function consistent with the respective ranking. The proof also supplies one deletion witness that works for every subjective ranking prefix, rather than a separate deletion choice at each prefix.

The structural step is a connectedness result for a particular allocation family. With an even number $2k$ of goods, represent the first bundle by a $k$-element set $A$. Agent 1's ordinal fairness becomes a lower quota on every even prefix of her ranking. Agent 2's ordinal fairness becomes an upper quota on every even prefix of his ranking. The upper quotas define a nested-capacity matroid. A greedy basis, constructed in the first ranking's order, is reachable from every feasible $A$ by exchanges that never decrease the first ranking's prefix counts. Connecting two complementary feasible seeds through this basis gives a shortest $k$-exchange path.

Market values play no role in constructing the path. Its complementary endpoints have values summing to the total market value, so some vertex or edge reaches or crosses half of that total. A short inequality shows that both endpoints of a crossing edge cannot violate market EF1. This separation makes the dependence on nonnegative market values explicit and yields a direct constructive proof.

The result concerns exactly the two-agent model. It does not establish the general-agent open question, market SD-EF1, heterogeneous market valuations, Pareto optimality, or fairness under additional external feasibility constraints. The mathematical statements and their proofs are given below; the dated literature assessment is recorded separately in [the novelty audit](../NOVELTY_AUDIT.md) and [source metadata](../SOURCES.json).

## 2. Model, quantifiers, and the main theorem

Let $M$ be a finite set of $m$ indivisible goods. The two agents are indexed by $i\in\{1,2\}$. Agent $i$ has a weak ranking induced by a nonnegative additive subjective utility $u_i$. A common market valuation is specified by nonnegative real weights $w(g)$, with

$$
w(S)=\sum_{g\in S}w(g),\qquad W=w(M).
$$

A complete allocation is an ordered partition $(A_1,A_2)$ of $M$. It is balanced if $\bigl||A_1|-|A_2|\bigr|\leq 1$.

### 2.1. Stochastic dominance and a single deletion

For a strict ranking $r=(r_1,\ldots,r_m)$, write $R_\ell=\{r_1,\ldots,r_\ell\}$, including $R_0=\varnothing$. A bundle $X$ stochastically dominates $Y$ under $r$ when

$$
|X\cap R_\ell|\geq |Y\cap R_\ell|
\quad\text{for every }\ell\in\{0,\ldots,m\}.
$$

For a weak ranking, use the upper contour sets obtained by taking all goods in the first one, two, and so on indifference classes. These are the utility-threshold sets in the standard definition [R1, Definitions 2–3](#reference-1).

Subjective SD-EF1 requires, for each ordered pair $i\neq j$, either $A_j=\varnothing$ or

$$
\exists g\in A_j\quad
\forall H\text{ an upper contour set for agent }i:
\quad |A_i\cap H|\geq |(A_j\setminus\{g\})\cap H|.
\tag{1}
$$

The order of the quantifiers is essential: **one good is removed for all contour sets**. For strict rankings the following elementary equivalence handles that quantifier directly.

**Lemma 2.1 (prefix deficits and one witness).** For disjoint bundles $X,Y$ and a strict ranking $r$, $X$ is SD-EF1 relative to $Y$ if and only if

$$
|Y\cap R_\ell|-|X\cap R_\ell|\leq 1
\quad\text{for every }\ell.
\tag{2}
$$

If $Y\neq\varnothing$, its highest-ranked good is a valid single deletion witness.

**Proof.** If a single deletion establishes dominance, it changes every prefix count of $Y$ by at most one, proving (2). Conversely, let $g$ be the highest-ranked good in $Y$. Every prefix containing a good of $Y$ contains $g$, so removing $g$ reduces the count of $Y$ in that prefix by exactly one. Inequality (2) then establishes dominance there. A prefix containing no good of $Y$ already satisfies the required comparison. If $Y$ is empty, both the fairness condition and (2) hold without a deletion. $\square$

The ordinal guarantee implies the usual additive EF1 guarantee. Indeed, let $v(r_1)\geq\cdots\geq v(r_m)\geq0$ be any utilities consistent with the strict ranking, and set $v(r_{m+1})=0$. For nonempty $Y$, fix the witness $g$ from Lemma 2.1 and write $d_\ell=|X\cap R_\ell|-|(Y\setminus\{g\})\cap R_\ell|\geq0$. Summation by parts gives

$$
v(X)-v(Y\setminus\{g\})
=\sum_{\ell=1}^m
\bigl(v(r_\ell)-v(r_{\ell+1})\bigr)d_\ell
\geq0.
\tag{3}
$$

Both factors in each summand are nonnegative. Empty $Y$ makes the fairness comparison automatic. The same conclusion follows for weak rankings after choosing a strict refinement.

### 2.2. Market EF1

Market EF1 requires, for each $i\neq j$ with $A_j\neq\varnothing$, a good $g\in A_j$ such that

$$
w(A_i)\geq w(A_j\setminus\{g\}).
\tag{4}
$$

The market witness may differ from the subjective witness. For any bundle $S$, define

$$
\mu(S)=\max_{g\in S}w(g),\qquad \mu(\varnothing)=0.
$$

For an allocation represented by $A=A_1$ and $A_2=M\setminus A$, condition (4) is equivalent to the two inequalities

$$
2w(A)\leq W+\mu(A),\qquad
W\leq 2w(A)+\mu(M\setminus A).
\tag{5}
$$

For a nonempty envied bundle, deleting a maximum-weight good is optimal. When it is empty, nonnegative market values make the corresponding inequality automatic, so the convention for $\mu(\varnothing)$ is consistent with the definition.

**Theorem 2.2 (two-agent simultaneous fairness).** For every finite set of goods, two weak subjective rankings, and nonnegative additive common market weights, there exists a complete balanced allocation that is subjective SD-EF1 and market EF1. The allocation can be computed using only strict refinements of the two rankings and the market weights. For rational market weights the construction has polynomial bit complexity. Its core implementation uses $O(m^2)$ arithmetic and membership operations under the usual constant-time membership model.

For even $m=2k$, the construction uses a path of exactly $k$ single-good exchanges between complementary subjective-SD-EF1 allocations, preserving subjective SD-EF1 at every vertex. For odd $m$, the same statement applies after adjoining one last-ranked zero-valued dummy good.

## 3. Ordinal feasibility and the complementary seed

Assume for now that the rankings are strict and $|M|=2k>0$. Denote them by $p$ and $q$. Let $P_t$ and $Q_t$ be their respective sets of top $2t$ goods, for $0\leq t\leq k$.

**Lemma 3.1 (even-prefix characterization).** A complete allocation $(A,M\setminus A)$ is subjective SD-EF1 if and only if

$$
|A\cap P_t|\geq t,
\qquad
|A\cap Q_t|\leq t
\quad (1\leq t\leq k).
\tag{6}
$$

In particular, every such allocation has $|A|=k$.

**Proof.** At an even prefix of size $2t$ in the first ranking, Lemma 2.1 reads $2t-2|A\cap P_t|\leq1$. Integrality makes this equivalent to $|A\cap P_t|\geq t$. Applying the same argument to agent 2's own bundle $M\setminus A$ gives $|A\cap Q_t|\leq t$.

Conversely, at a prefix of size $2t+1$, an agent owns at least the $t$ goods guaranteed by the preceding even prefix. The other bundle then contains at most one more good in that odd prefix. This includes the first prefix by using the empty prefix at $t=0$. Hence every prefix has deficit at most one, and Lemma 2.1 supplies the required single deletion. At $t=k$, the two inequalities in (6) give $|A|\geq k$ and $|A|\leq k$. $\square$

Define the feasible family

$$
\mathcal F=
\{A\subseteq M: |A|=k,
\ |A\cap P_t|\geq t,
\ |A\cap Q_t|\leq t\text{ for }1\leq t\leq k\}.
\tag{7}
$$

This family need not be closed under complementation. We require only one complementary pair inside it.

**Lemma 3.2 (known complementary seed).** There exists $C\subseteq M$ such that both $C$ and $M\setminus C$ belong to $\mathcal F$.

**Proof and attribution.** This is the adjacent-pair construction of Cookson, Ebadian, and Shah [R2, Lemma 5](#reference-2). Pair consecutive goods in each ranking. The union of the two perfect matchings is a multigraph of alternating even cycles; a repeated edge forms a two-edge cycle. Two-color each component. Each color class contains one good from every pair in either ranking, hence exactly $t$ goods from every $P_t$ and every $Q_t$. Either color class can be $C$. $\square$

The seed is an existing tool. Our next step enlarges the search from its two labelings to a connected family in which the market valuation can be accommodated.

## 4. A connected exchange graph and a shortest complementary path

Two members of $\mathcal F$ are adjacent if one is obtained from the other by removing one good and adding one good. This is a single exchange between the agents, so bundle sizes are unchanged. We give a direct proof of connectedness rather than relying on an unproved exchange property for an intersection of constraints.

### 4.1. The nested upper-capacity system

Let

$$
\mathcal I=
\{X\subseteq M: |X\cap Q_t|\leq t
\text{ for every }1\leq t\leq k\}.
\tag{8}
$$

**Lemma 4.1 (augmentation).** The system $(M,\mathcal I)$ is a matroid of rank $k$.

**Proof.** The empty set is independent, and subsets of independent sets remain independent. Let $X,Y\in\mathcal I$ with $|X|<|Y|$. Suppose that no $e\in Y\setminus X$ can be added to $X$. For each such $e$, there is a prefix $Q_{t(e)}$ containing $e$ with $|X\cap Q_{t(e)}|=t(e)$; otherwise inserting $e$ would respect every integer capacity. Choose the largest of these tight prefixes, say $Q_s$. Nestedness gives $Y\setminus X\subseteq Q_s$. Thus

$$
|Y\cap Q_s|\leq s=|X\cap Q_s|,
\qquad
Y\setminus Q_s\subseteq X\setminus Q_s.
$$

Adding the two cardinality comparisons contradicts $|Y|>|X|$. Augmentation follows. The terminal constraint bounds every independent set by $k$, while the goods in positions $2,4,\ldots,2k$ of $q$ form an independent set of size $k$. Therefore the rank is $k$. $\square$

Construct $G$ by scanning goods in order $p$, adding a good exactly when its addition preserves membership in $\mathcal I$. A rejected good cannot become addable later: every later selected set contains the independent set present at its rejection, and the violated upper capacity cannot decrease. Thus $G$ is maximal independent. Lemma 4.1 implies $|G|=k$.

### 4.2. An exchange toward the greedy target

**Lemma 4.2 (the first disagreement enters the target).** For any size-$k$ independent set $A\neq G$, the first good in order $p$ belonging to exactly one of $A,G$ lies in $G\setminus A$.

**Proof.** If that first good $e$ lay in $A\setminus G$, all earlier greedy choices would agree with membership in $A$. At the moment $e$ was considered, the selected goods together with $e$ would therefore be a subset of the independent set $A$. The greedy procedure would have accepted $e$, a contradiction. $\square$

**Lemma 4.3 (feasible direct exchange).** Every $A\in\mathcal F$ with $A\neq G$ has a neighbor $A'\in\mathcal F$ such that

$$
|A'\setminus G|=|A\setminus G|-1.
\tag{9}
$$

**Proof.** Let $g\in G\setminus A$ be the first disagreement from Lemma 4.2. Choose the smallest $Q_s$ that contains $g$ and is tight for $A$:

$$
g\in Q_s,\qquad |A\cap Q_s|=s.
\tag{10}
$$

Such a prefix exists because $Q_k=M$ and $|A|=k$. There is a good $a\in(A\setminus G)\cap Q_s$. Otherwise $A\cap Q_s\subseteq G$, and the additional good $g\in G\cap Q_s\setminus A$ would give $|G\cap Q_s|\geq s+1$, contradicting $G\in\mathcal I$.

Set $A'=(A\setminus\{a\})\cup\{g\}$. Consider any upper prefix constraint $Q_t$. If it was not tight for $A$, inserting one good cannot exceed its integer capacity. If it does not contain $g$, its count cannot increase. In the remaining case it contains $g$ and is tight for $A$, so minimality gives $s\leq t$. Consequently $a\in Q_s\subseteq Q_t$, and the insertion is offset by the deletion. All upper constraints are preserved.

Every good of $A\setminus G$, including $a$, occurs later than $g$ in $p$. Replacing $a$ by $g$ cannot decrease the count in any $p$-prefix: before $g$ neither good is counted, between $g$ and $a$ the count increases by one, and after $a$ it is unchanged. Therefore all lower constraints in (6) also hold. The exchange preserves cardinality and removes a good outside $G$ while inserting a good in $G$, proving (9). $\square$

**Theorem 4.4 (connected ordinal-feasible graph).** Every $A\in\mathcal F$ reaches $G$ through exactly $|A\setminus G|$ feasible single exchanges. In particular, $G\in\mathcal F$ and the exchange graph on $\mathcal F$ is connected.

**Proof.** Repeatedly apply Lemma 4.3. The nonnegative integer $|A\setminus G|$ decreases by one each time. When it becomes zero, the two size-$k$ sets are equal. Starting with the seed from Lemma 3.2 proves $G\in\mathcal F$ without assuming the lower constraints for $G$ in advance. Every feasible set reaches this same target, so any two feasible sets can be joined through it. $\square$

### 4.3. The exact number of exchanges

**Corollary 4.5 (shortest complementary path).** Let $C$ be the seed from Lemma 3.2. Concatenating the path $C\to G$ with the reversal of the path $(M\setminus C)\to G$ gives a feasible path from $C$ to $M\setminus C$ of exactly $k$ exchanges. This is a shortest path even when fairness restrictions are removed.

**Proof.** The two branch lengths sum to

$$
|C\setminus G|+|(M\setminus C)\setminus G|
=|M\setminus G|=k.
\tag{11}
$$

Every path from $C$ to its complement must remove all $k$ original members of $C$ from the first bundle. One exchange removes at most one, so at least $k$ exchanges are necessary. The constructed path attains that lower bound. In particular, every original member of $C$ is removed exactly once and every member of its complement is inserted exactly once. $\square$

No monotonicity in market value is asserted. Different exchanges may change market value in different directions; only the complementary endpoint relation is needed below.

## 5. Market crossings and completion of the proof

**Lemma 5.1 (a crossing has an EF1 endpoint).** Let $A$ and $B=(A\setminus\{a\})\cup\{b\}$ be adjacent complete first bundles, with $a\in A$, $b\notin A$, and

$$
w(A)\leq W/2\leq w(B).
\tag{12}
$$

If all market weights are nonnegative, at least one of the two associated allocations is market EF1.

**Proof.** At $A$, only the first agent can envy the second under the common market valuation. If the allocation at $A$ fails EF1, then

$$
W-2w(A)>\mu(M\setminus A).
\tag{13}
$$

At $B$, only the second agent can envy the first. Failure there implies

$$
2w(B)-W>\mu(B).
\tag{14}
$$

The good $b$ belongs to both $M\setminus A$ and $B$. Adding (13) and (14), and using $w(B)-w(A)=w(b)-w(a)$, would give

$$
2\bigl(w(b)-w(a)\bigr)
>\mu(M\setminus A)+\mu(B)
\geq 2w(b).
\tag{15}
$$

This forces $w(a)<0$, contradicting nonnegativity. Thus both endpoints cannot fail. If either endpoint has market value exactly $W/2$, it is already market envy-free. $\square$

**Proof of Theorem 2.2 for strict rankings and even $m>0$.** Construct the path $A^{(0)},\ldots,A^{(k)}$ from Corollary 4.5, with endpoints $C$ and $M\setminus C$. Every vertex is subjective SD-EF1. Moreover,

$$
w(A^{(0)})+w(A^{(k)})=W.
\tag{16}
$$

If a vertex has value $W/2$, select it. Otherwise the endpoint values lie on opposite sides of $W/2$, so some consecutive pair lies on opposite sides as well. Apply Lemma 5.1, naming its lower-valued endpoint $A$ and higher-valued endpoint $B$ regardless of the direction along the path. Select a market-EF1 endpoint. Both subjective ordinal constraints and balancedness are preserved. $\square$

### 5.1. Weak rankings

Choose an arbitrary strict refinement of each weak ranking and apply the construction. Every original upper contour set is a prefix of that refinement. The single good certifying all refined prefixes therefore also certifies all original contour sets. This proves (1) without changing its quantifier order. No numerical separation between tied subjective values is required, and the market weights remain unchanged.

### 5.2. Odd numbers of goods and zero values

For odd $m$, adjoin one dummy good $d$ of zero subjective and market value. Put it last in both strict refinements; when real goods also have zero subjective value, this is a permissible tie-breaking choice. Apply the even construction to the padded set and then delete $d$ from its assigned bundle.

For each original strict prefix, the set of real goods it contains is unchanged and does not include $d$. Therefore both agents' original prefix deficits are unchanged by removing the dummy. Lemma 2.1 proves subjective SD-EF1 for the real allocation, and the preceding refinement argument covers weak rankings. This reasoning avoids an incorrect assumption that any designated deletion witness necessarily survives dummy removal.

Market bundle totals are unchanged. Their maximum weights are also unchanged under the convention that an empty bundle has maximum zero. Hence the two inequalities in (5) remain true. Equivalently, if the dummy itself had been a market deletion witness, its zero value means that comparison was already envy-free, and any remaining good can be removed without harming it. The padded bundles have equal size; deleting one dummy leaves sizes differing by one.

Zero market values elsewhere cause no difficulty. In particular, if $W=0$, every allocation is market envy-free and the selection step can immediately choose the first path vertex. If $m=0$, the empty allocation satisfies all conditions, the path has zero exchanges, and neither comparison needs a deletion. These observations complete the existence part of Theorem 2.2. $\square$

## 6. Algorithm and implementation complexity

The following procedure is implemented in [allocate.py](../code/allocate.py). Goods are indexed by consecutive integers. Its ranking inputs are strict complete order lists; a caller with weak rankings first supplies any strict refinements, since the program does not parse indifference classes. The implementation uses exact rational arithmetic through Python's `fractions.Fraction` and accepts integer or rational-string market inputs.

**Algorithm 1: ordinal path and market selection**

1. Refine subjective ties and append a last-ranked zero dummy if the number of goods is odd.
2. Pair adjacent goods in both rankings and two-color their union to obtain a seed $C$.
3. Scan the first ranking greedily under the second ranking's nested upper capacities, obtaining $G$.
4. From $C$, repeatedly insert the first disagreement with $G$ and remove a good outside $G$ from the smallest tight second-ranking prefix containing the insertion. Repeat separately from $M\setminus C$.
5. Concatenate the first path with the reversal of the second, omitting the duplicated occurrence of $G$.
6. Compute the market values along the resulting $k$-exchange path. Select an equal-half vertex, or a market-EF1 endpoint of an adjacent half-value crossing.
7. Remove the dummy, if any. Return the two bundles and subjective and market deletion witnesses.

Every search in Step 4 succeeds by Lemmas 4.2–4.3. The returned subjective witness for each nonempty other bundle is its highest-ranked real good. The returned market witness is a maximum-weight good of the other bundle. These choices implement the proofs of Lemma 2.1 and characterization (5).

Let $N=m+(m\bmod 2)$ be the padded number of goods. Pair construction and two-coloring use $O(N)$ edges and time. The greedy procedure maintains the counts of the second ranking's even prefixes; testing and updating the affected suffix of this array costs $O(N)$ per considered good, hence $O(N^2)$ overall.

The shipped exchange routine recomputes prefix counts rather than maintaining a more complicated dynamic structure. At each exchange it scans the first ranking for the first disagreement, computes the second ranking's prefix counts, finds the smallest relevant tight prefix, scans that prefix for an outgoing good, and checks feasibility. Each of these tasks takes $O(N)$ operations with constant-time membership. Copying the current set into the stored path also takes $O(N)$. There are exactly $N/2$ exchanges across the two branches, so the total is $O(N^2)$.

Computing every stored vertex's market value uses $O(N^2)$ rational additions. Scanning for a crossing takes $O(N)$ comparisons. Testing the at most two candidate endpoints takes $O(N)$ further operations. Sorting the two final output bundles costs at most $O(N\log N)$, which is within the quadratic bound. Consequently the current core solver, with optional trace serialization disabled, uses $O(m^2)$ arithmetic and membership operations. This uses the usual constant-time hash-set membership model; an equivalent Boolean-array representation gives the same combinatorial operation bound directly. The actual implementation stores all path vertices, using $O(m^2)$ storage for item references, in addition to the storage needed by rational numbers.

There are two implementation qualifications. First, rational arithmetic is not a unit-cost bit operation. If $L$ denotes the total input encoding length, denominators of subset sums divide the product of input denominators, so intermediate bit lengths remain polynomial in $L+\log m$. The algorithm therefore has polynomial bit complexity, without claiming a quadratic bit bound. Second, optional human-readable trace output sorts each stored vertex. Its worst-case comparison-sorting overhead is $O(m^2\log m)$. This display cost is separate from the quadratic core construction.

## 7. A six-good example requiring movement beyond the seed

Take goods $0,\ldots,5$ and rankings

$$
p=(0,1,2,3,4,5),\qquad q=(1,2,3,4,5,0),
$$

with market weights $w=(1,0,1,0,1,0)$. The adjacent-pair graph is a single six-cycle. Its seed bundles are $C=\{0,2,4\}$ and $C^c=\{1,3,5\}$, of market values $3$ and $0$. Both seed labelings fail market EF1: removing one good from the heavier bundle leaves value at least $2$ against value $0$.

The implementation produces the following three-exchange path:

$$
\{0,2,4\}
\longrightarrow\{0,1,4\}
\longrightarrow\{0,1,3\}
\longrightarrow\{1,3,5\}.
\tag{17}
$$

Every vertex satisfies both directional ordinal constraints. Their market values are $3,2,1,0$, and the total is $W=3$. The middle edge crosses $W/2=3/2$. The selected first bundle is $\{0,1,4\}$, with complementary bundle $\{2,3,5\}$ and market values $2$ and $1$. The market difference is eliminated by removing good $0$ or $4$ from the heavier bundle. The subjective deletion witnesses returned for agents 1 and 2 are goods $2$ and $1$, respectively.

![Market values along the six-good example path. The two seed endpoints fail market EF1, while the middle edge crosses half the total market value and supplies a valid endpoint.](../figures/market_crossing.png)

The input is [seed_obstruction.json](../examples/seed_obstruction.json); the complete output is [example_trace.json](../results/example_trace.json). From the project directory it can be reproduced with:

```sh
python code/allocate.py examples/seed_obstruction.json --trace
```

This example also explains why selecting only one of the two known seed labelings is insufficient for an arbitrary independent market valuation.

## 8. Exact checks and partial formal verification

### 8.1. Finite definition-level checks

The general result is proved in Sections 2–5. The separate program [verify_exact.py](../code/verify_exact.py) tests the implementation against the fairness definitions. In particular, its SD-EF1 checker enumerates a candidate removed good and then checks **every** ranking prefix for that same good. It does not reuse the allocator's even-prefix feasibility predicate. Its cardinal EF1 checker also enumerates deletion choices instead of relying on the allocator's maximum-weight test.

The recorded run passed **52,528 instances**, with the following composition [verification record](../results/exact_verification.json).

| Suite | Exact scope | Instances |
|---|---|---:|
| Binary exhaustive | $0\leq m\leq6$; every second strict ranking and every market vector in $\{0,1\}^m$; first ranking fixed by relabeling | 50,363 |
| Additional ternary exhaustive | $0\leq m\leq4$; every second strict ranking and every vector in $\{0,1,2\}^m$ containing a $2$ | 1,685 |
| Rational cases | Seeded cases with $m\in\{7,8,15,31,64,101\}$, zero weights and some large-weight or all-zero cases | 360 |
| Weak-order cases | Seeded tied subjective values, including zero levels, with $m\in\{1,3,7,12,25\}$ | 120 |
| **Total** | | **52,528** |

For the exhaustive suites, fixing the first ranking loses no strict-order pair: relabeling by that ranking transforms the second ranking and market vector into another enumerated instance. The binary count is $\sum_{m=0}^6m!2^m=50{,}363$; the additional ternary count is $\sum_{m=0}^4m!(3^m-2^m)=1{,}685$.

Every case checks a complete balanced partition, final subjective SD-EF1 in both directions, common-market EF1 in both directions, and the exact padded half-size path length. Full independent prefix checks at every path vertex are additionally performed on 24 rational traces and all 120 weak-order traces. Weak-order cases are checked at their actual utility levels as well as at the chosen strict refinements. The six-good example is checked separately and is not added to the total above.

All market comparisons use exact fractions. The random seed is `20261124`; the result file records the transcript SHA-256 and Python version. These deterministic finite checks provide implementation evidence for the specified families, not an exhaustive computational proof for arbitrary $m$. Reproduce them with:

```sh
python code/verify_exact.py
```

### 8.2. What Lean verifies

The [formalization package](../formalization/README.md) uses Lean 4.19.0 with mathlib fixed to commit `c44e0c8ee63ca166450922a373c7409c5d26b00b`. The shipped [CsCore.lean](../formalization/CsCore.lean) has been freshly compiled from the final project directory. Its 11 theorem declarations cover four real-scalar market lemmas and seven natural-number prefix, capacity, and path-length lemmas.

The market statements include the two directed scalar EF1 inequalities at a crossing endpoint. The prefix statements check the deficit/floor-half equivalence, even-to-odd prefix implication, and the fact that replacing a later-ranked item by an earlier one preserves all lower prefix quotas. Another statement checks upper-capacity preservation once the tight-prefix deletion condition is supplied. The final statement checks the natural-number identity underlying the exact complementary path length.

The runner audits the actual source hash, Lean version, mathlib and all transitive dependency revisions, compiler exit code, and all printed axiom sets. The [fresh status](../formalization/verification_status.json) reports 11 checked theorems and no admitted proofs or project-specific axioms. The axiom sets contain only the standard principles `propext`, `Classical.choice`, and `Quot.sound`; the unedited compiler output is retained in [the build log](../formalization/lean-build.log).

This is **partial formal verification**. The pairing graph, the augmentation proof, the existence and termination of the greedy exchanges, the set-theoretic assembly of the full path, and the correspondence with Python are not formalized end to end. In particular, the path-length identity in Lean does not by itself prove the existence of the path. These parts are justified by the manuscript's mathematical proof. The precise verification boundary is part of the reproducibility claim.

## 9. Relation to existing constructions

The original market-values question motivates the conjunction established here. The stronger ordinal condition belongs to each of two potentially different subjective rankings; it cannot be moved from the market side merely by exchanging names of valuation functions.

**Temporal fairness.** The complementary seed is credited in Lemma 3.2. The temporal construction's balancing lemma requires input allocations already fair for the valuation profile being balanced [R2, Lemma 4 and Theorem 3](#reference-2). An independent market profile need not satisfy that premise, as Section 7 shows. Our exchanges leave the two seed labelings while maintaining both original ordinal conditions.

**Allocator preferences.** The revised June 2025 version of Bu et al. establishes polynomial-time doubly EF1 for two additive valuation profiles [R3, Theorem 4.5](#reference-3). That is a cardinal guarantee. Its construction preserves an adjacent-pair condition for one ranking and uses cardinal differences and ordinary-EF1 tests for the remaining comparisons. It does not establish the two subjective SD requirements here. A direct substitution into its bad-allocation independence argument fails: under ranking $1\succ\cdots\succ8$, the four-good bundles $X=\{3,4,5,6\}$ and $Y=\{2,6,7,8\}$ intersect in one good, yet both violate SD-EF1 relative to their complements. The witnessing prefixes have sizes two and four, respectively. Thus ordinary-EF1 bad-set independence cannot simply be relabeled as SD-EF1 bad-set independence.

**Fair-allocation reachability.** Sequential exchanges preserving fairness have been studied directly. Igarashi et al. show that the ordinary EF1 exchange graph can be disconnected even for two agents sharing an ordinal ranking [R7, Theorem 3.1](#reference-7). Our graph is the family satisfying the stronger directional prefix system, and its connectedness is compatible with disconnection of the larger ordinary-EF1 graph. The exact shortest-path claim here concerns the constructed complementary seeds; we do not claim shortest feasible paths between all pairs of vertices.

**External matroid constraints.** Common-matroid feasibility differs from the crossed ranking constraints in (7). Cookson et al. show that external partition constraints can even preclude SD-EF1 [R4, Theorem 6](#reference-4). The 2026 laminar result of Cookson and Shah provides EF1 under a single common feasibility family [R5, Theorem 1](#reference-5). Our two rankings generally induce different nested families, and market EF1 compares entire bundles. The union of the ranking-prefix chains need not itself be laminar, so a common-laminar theorem does not directly supply the present conjunction.

**Path methods.** Local paths and a change of preference along a path are established two-agent proof ideas; the 2026 work of Dupré la Tour explicitly discusses this precedent [R6, Section 1.2](#reference-6). We do not claim that general method or ordinary matroid greedy exchange as new. The contribution is the concrete connected ordinal-feasible family, its shortest complementary path, and the resulting coexistence of two subjective SD-EF1 guarantees with an independent common-market EF1 guarantee.

The literature assessment used the primary papers and current versions listed below. It supports the distinction of the stated two-agent result within the documented search coverage. It is not a claim that all possible publications or unpublished formulations have been exhaustively excluded.

## 10. Further questions

The construction separates a combinatorial feasibility problem from a scalar market-balancing step. This suggests asking whether larger-agent ordinal-feasible families contain a suitably connected collection of allocations on which a common market valuation can also be balanced. The proof here does not provide such a collection. In particular, the union of adjacent-pair matchings and the one-dimensional half-value crossing both use the two-agent structure.

Another question concerns additional guarantees along the path. Our shortest path preserves subjective SD-EF1, but intermediate vertices may fail market EF1, including its endpoints in Section 7. The theorem selects a suitable vertex; it does not produce a redistribution process preserving every fairness condition from start to finish. Likewise, no welfare or incentive property follows merely from the ordinal and market constraints proved here.

For the stated model, the result is complete: every finite two-agent instance admits a balanced allocation with the required simultaneous fairness, and the proof gives an exact algorithm together with explicit deletion witnesses. The remaining limitations concern extensions of the model and the scope of machine verification, not exceptional instances within the theorem.

## References

### Reference 1

Siddharth Barman, Soroush Ebadian, Mohamad Latifian, and Nisarg Shah. **Fair Division with Market Values.** *Proceedings of the AAAI Conference on Artificial Intelligence* 39(13), 13589–13596, 2025. [DOI: 10.1609/aaai.v39i13.33484](https://doi.org/10.1609/aaai.v39i13.33484). [Complete arXiv version 2410.23137v1](https://arxiv.org/abs/2410.23137v1).

### Reference 2

Benjamin Cookson, Soroush Ebadian, and Nisarg Shah. **Temporal Fair Division.** *Proceedings of the AAAI Conference on Artificial Intelligence* 39(13), 13727–13734, 2025. [DOI: 10.1609/aaai.v39i13.33500](https://doi.org/10.1609/aaai.v39i13.33500). [arXiv:2410.23416v1](https://arxiv.org/abs/2410.23416v1). [Author-hosted full paper](https://www.cs.toronto.edu/~nisarg/papers/temporal.pdf).

### Reference 3

Xiaolin Bu, Zihao Li, Shengxin Liu, Jiaxin Song, and Biaoshuai Tao. **Fair Division with Allocator's Preference.** Preliminary version in *Web and Internet Economics*, WINE 2023, 77–94. [DOI: 10.1007/978-3-031-48974-7_5](https://doi.org/10.1007/978-3-031-48974-7_5). The theorem and proof compared here are from [arXiv:2310.03475v2](https://arxiv.org/abs/2310.03475v2), revised 7 June 2025.

### Reference 4

Benjamin Cookson, Soroush Ebadian, and Nisarg Shah. **Constrained Fair and Efficient Allocations.** *Proceedings of the AAAI Conference on Artificial Intelligence* 39(13), 13718–13726, 2025. [DOI: 10.1609/aaai.v39i13.33499](https://doi.org/10.1609/aaai.v39i13.33499). [arXiv:2411.00133v1](https://arxiv.org/abs/2411.00133v1). [Author-hosted full paper](https://www.cs.toronto.edu/~nisarg/papers/constrained-fair-efficient.pdf).

### Reference 5

Benjamin Cookson and Nisarg Shah. **Constrained Fair Allocations via Partition Matroid Reductions.** [arXiv:2608.31121](https://arxiv.org/abs/2608.31121), 2026; accepted to EAAMO 2026. [Author-hosted full paper](https://www.cs.toronto.edu/~nisarg/papers/laminar-ef1.pdf). The author's bibliography also lists the title *Constrained Fair Allocations via Reductions to Simpler Matroids*.

### Reference 6

Max Dupré la Tour. **Balanced Fair Division for Three Agents under General Valuations and Laminar Constraints.** [arXiv:2608.09437v1](https://arxiv.org/abs/2608.09437v1), 10 August 2026. [DOI: 10.48550/arXiv.2608.09437](https://doi.org/10.48550/arXiv.2608.09437).

### Reference 7

Ayumi Igarashi, Naoyuki Kamiyama, Warut Suksompong, and Sheung Man Yuen. **Reachability of Fair Allocations via Sequential Exchanges.** *Algorithmica* 86, 3653–3683, 2024. [DOI and full article: 10.1007/s00453-024-01271-y](https://doi.org/10.1007/s00453-024-01271-y). [arXiv:2312.07241](https://arxiv.org/abs/2312.07241).
