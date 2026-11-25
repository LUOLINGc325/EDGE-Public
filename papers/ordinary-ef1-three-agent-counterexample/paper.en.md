# A Minimal Three-Agent Counterexample to EF1 with Additive Externalities

**Research draft — 24 November 2026.** AI-assisted research; not externally peer reviewed. Target audience: researchers and graduate students in algorithmic game theory.

## Abstract

We give an instance of fair division with additive externalities, three agents, and three items that admits no allocation envy-free up to one item (EF1). All item-recipient utilities belong to $\{0,1,2,4\}$ and are nonnegative. The instance is invariant under cyclic relabeling of agents: every agent values receiving the three items herself at $(2,1,2)$, values the third item at four when it is assigned to her successor, and has no other external utility. The third item is a chore under the externalities definition, despite every utility being nonnegative. We prove nonexistence by nine explicit comparisons, determine an exact four-parameter family around the example, and prove simultaneous minimality in agent and item counts. Two agents always admit EF1, and any number of agents with at most two items admit EF1, even for arbitrary signed additive utilities. The result addresses the small-counterexample and minimum-agent questions for the unrestricted additive model. It does not settle the corresponding binary or no-chores questions.

## 1. Question and relationship to existing results

In additive externalities models, a person's utility depends on who receives an item. Envy is assessed by comparing the current allocation with the allocation obtained by swapping two agents' bundles. An EF1 guarantee permits deleting any one item before making that comparison.

Connor, Dupré la Tour, Narayan, and Schierreich [1] establish large-instance nonexistence results, including binary no-chores examples. Their Section 7 asks for a small explicit counterexample and for the largest number of agents at which EF1 is universally guaranteed in the various utility domains. The present result gives a minimum-scale answer to the small-counterexample question for unrestricted additive utilities: three agents already suffice, and three items are necessary and sufficient for a counterexample. We determine the smallest possible failing agent count; we do not separately construct counterexamples for every larger fixed number of agents.

The prior three-agent obstruction in the unified author manuscript of Aziz et al. [2, Theorem 3.5] concerns EFX, a stronger requirement, and uses seven items with no chores. An EFX obstruction need not obstruct EF1. The counterexample here violates EF1 itself but uses a chore; it does not strengthen that no-chores result in the utility-domain direction. Binary/no-chores existence statements are also outside our conclusion.

## 2. Definitions and a direct verification criterion

Let $N=[n]$ and let $M$ be a finite set of items. The real number $u_i(j,x)$ is agent $i$'s utility from item $x$ when recipient $j$ receives it. Utilities are additive:

$$
U_i(A)=\sum_{j=1}^n\sum_{x\in A_j}u_i(j,x).
$$

An allocation $A=(A_1,\ldots,A_n)$ is a complete partition of $M$, and empty bundles are allowed. Let $A^{i\leftrightarrow j}$ denote the allocation with bundles $i,j$ swapped. For a deletion set $S$, write $A\setminus S=(A_1\setminus S,\ldots,A_n\setminus S)$.

An allocation is **EF1** if for every ordered pair $i\ne j$ there is $S\subseteq M$ with $|S|\le1$ such that

$$
U_i(A\setminus S)\ge U_i((A\setminus S)^{i\leftrightarrow j}). \tag{1}
$$

The deletion set can depend on the ordered pair and may contain an item from any bundle. This is the full externalities definition in [1, 2]; we impose no extra restriction on allowed deletions.

Define the signed difference row

$$
v_{ij}(x)=u_i(i,x)-u_i(j,x).
$$

The current envy gap, positive when $i$ envies $j$, is

$$
g_{ij}(A)
=U_i(A^{i\leftrightarrow j})-U_i(A)
=v_{ij}(A_j)-v_{ij}(A_i). \tag{2}
$$

For an item $x$, deleting it reduces this gap by

$$
d_{ij,A}(x)=
\begin{cases}
v_{ij}(x),&x\in A_j,\\
-v_{ij}(x),&x\in A_i,\\
0,&x\notin A_i\cup A_j.
\end{cases}
$$

Hence the least remaining gap after zero or one deletion is exactly

$$
\rho_{ij}(A)=g_{ij}(A)-\max\left(0,\max_{x\in M}d_{ij,A}(x)\right). \tag{3}
$$

The allocation fails EF1 if and only if $\rho_{ij}(A)>0$ for at least one ordered pair. Formula (3) explicitly checks all permissible deletions, including an item in the observer's own bundle when the difference valuation is negative.

## 3. The three-by-three counterexample

The agents are indexed cyclically, with successor $i+1$ and predecessor $i-1$ modulo three. There are three items $a,b,c$. For each observer $i$, set

| Recipient relative to $i$ | $a$ | $b$ | $c$ |
| --- | ---: | ---: | ---: |
| $i$ herself | 2 | 1 | 2 |
| Successor $i+1$ | 0 | 0 | 4 |
| Predecessor $i-1$ | 0 | 0 | 0 |

Thus the difference row toward a successor is

$$
v_{i,i+1}=(2,1,-2),
$$

and the difference row toward a predecessor is

$$
v_{i,i-1}=(2,1,2). \tag{4}
$$

Every entry in the utility profile is nonnegative. Nevertheless $c$ is a chore for each agent under the externalities convention: the agent obtains more utility from her successor receiving $c$ than from receiving it herself, since $4>2$. Nonnegative utilities and the no-chores condition are different properties.

### Theorem 1. No complete allocation is EF1

The utility profile (4) admits no EF1 allocation.

**Proof.** Cyclic symmetry allows us to assume that item $c$ is assigned to agent 1. There are nine remaining possibilities for the recipients of $a$ and $b$. The table gives an ordered comparison whose gap remains positive even after the best allowed deletion. Its columns are the gap $g$ in (2), the largest possible reduction $d^*$ from zero or one deletion, and the residual $\rho=g-d^*$.

| Recipient of $a$ | Recipient of $b$ | Witness $i\to j$ | $g$ | $d^*$ | $\rho$ |
| ---: | ---: | :---: | ---: | ---: | ---: |
| 1 | 1 | $2\to1$ | 5 | 2 | 3 |
| 1 | 2 | $2\to1$ | 3 | 2 | 1 |
| 1 | 3 | $2\to1$ | 4 | 2 | 2 |
| 2 | 1 | $1\to2$ | 3 | 2 | 1 |
| 2 | 2 | $1\to2$ | 5 | 2 | 3 |
| 2 | 3 | $1\to2$ | 4 | 2 | 2 |
| 3 | 1 | $2\to1$ | 3 | 2 | 1 |
| 3 | 2 | $1\to2$ | 3 | 2 | 1 |
| 3 | 3 | $2\to3$ | 3 | 2 | 1 |

For illustration, when $A_1=\{a,c\}$ and $A_2=\{b\}$, row $v_{21}=(2,1,2)$ gives gap $4-1=3$. Deleting $a$ or $c$ reduces the gap by two; deleting $b$ increases it by one. Envy therefore remains after every deletion. When $A_1=\{b,c\}$ and $A_2=\{a\}$, row $v_{12}=(2,1,-2)$ gives gap $2-(1-2)=3$. Deleting $a$ or $c$ reduces it by two, again leaving positive envy.

The same direct calculation gives every row of the table. They exhaust all nine allocations with $c$ assigned to agent 1 and, after cyclic relabeling, all $3^3=27$ allocations. Every residual is positive, proving the theorem. $\square$

The nine cases are a complete proof by finite exhaustion. The accompanying program additionally checks all 27 allocations directly from the full utility tensor, all six ordered comparisons, and all four deletion options, rather than relying only on the displayed difference rows.

## 4. An exact parameter family

The construction is not confined to isolated coefficients. Let $\alpha,\beta,\gamma,\zeta>0$. Set the self-recipient utility vector to $(\alpha,\beta,\gamma)$, the successor-recipient vector to $(0,0,\gamma+\zeta)$, and the predecessor-recipient vector to zero. The difference rows are now

$$
v_{i,i+1}=(\alpha,\beta,-\zeta),\qquad
v_{i,i-1}=(\alpha,\beta,\gamma). \tag{5}
$$

### Theorem 2. Exact nonexistence region

The family (5) has no EF1 allocation if and only if

$$
\alpha\ne\beta
\quad\text{and}\quad
\min(\alpha,\beta)<\min(\gamma,\zeta). \tag{6}
$$

**Proof.** Swapping the names of $a,b$ allows us to assume $\alpha\ge\beta$. Fix $c$ at agent 1 by cyclic symmetry.

Seven of the nine recipient pairs in Theorem 1's table always fail EF1 for strictly positive parameters. For $(1,1)$, comparison $2\to1$ sees three positive contributions; any one deletion leaves two positive contributions. For $(1,3)$ and $(3,1)$, comparison $2\to1$ sees two positive contributions and an empty own bundle. For $(2,2)$, $(2,3)$ and $(3,2)$, comparison $1\to2$ contains the positive contribution from retaining the chore in the observer's bundle and at least one positive contribution from the target. For $(3,3)$, comparison $2\to3$ has two positive target contributions and an empty own bundle. Every listed comparison retains a positive gap after every single deletion.

It remains to inspect two allocations. In

$$
X=(\{a,c\},\{b\},\varnothing),
$$

the comparison $2\to1$ fails EF1 precisely when

$$
\alpha+\gamma-\beta>\max(\alpha,\gamma),
$$

equivalently $\beta<\min(\alpha,\gamma)$. The reverse comparison $1\to2$ could fail only if $\alpha<\min(\beta,\zeta)$, which is impossible under $\alpha\ge\beta$. Every other comparison is EF1: it either involves at most one relevant item, has nonpositive gap, or has one positive and one negative contribution whose positive term can be deleted. Therefore $X$ is EF1 exactly when $\alpha=\beta$ or $\gamma\le\beta$.

For

$$
Y=(\{b,c\},\{a\},\varnothing),
$$

comparison $1\to2$ fails precisely when $\beta<\min(\alpha,\zeta)$. Its reverse could fail only if $\alpha<\min(\beta,\gamma)$, again impossible. The remaining comparisons are EF1 by the same direct check. Thus $Y$ is EF1 exactly when $\alpha=\beta$ or $\zeta\le\beta$.

Both exceptional allocations fail exactly when $\alpha>\beta$, $\gamma>\beta$, and $\zeta>\beta$. Restoring the symmetry between $a,b$ yields (6). This also proves existence on the complement of (6), because $X$ or $Y$ is then an explicit EF1 allocation. $\square$

In particular, the inequalities in (6) are strict: equality is on the existence side. The integer example in Section 3 is $(\alpha,\beta,\gamma,\zeta)=(2,1,2,2)$.

## 5. Minimality

### Lemma 3. At most two items always permit EF1

For any number of agents and arbitrary real additive externalities, an instance with at most two items has an EF1 allocation.

**Proof.** With zero or one item, delete that item if necessary. Suppose there are two items $a,b$. Assign both initially to any fixed agent $p$. If this is EF1, we are done.

Otherwise some ordered pair involving $p$ has envy that cannot be removed by one deletion. In its difference row the values of $a,b$ must have the same strict sign: both are positive if the observer has the empty bundle, or both are negative if the observer has the full bundle. Let $q$ be the other agent in this witnessing comparison.

Now assign one item to each of $p,q$ and leave all other bundles empty. For a same-sign row, neither orientation of this split can fail EF1: deleting the item contributing positively to the gap removes all positive envy. In the reverse difference row, failure for one orientation requires one entry to be strictly positive and the other strictly negative in a particular order. Failure for the opposite orientation requires the reverse sign pattern. Both cannot occur. Choose an orientation that is EF1 for that reverse row. It is already EF1 for the same-sign row.

Every other ordered comparison involves at most one item in its two bundles. Deleting that item makes their difference zero; items in third-party bundles cancel in (2). Hence all comparisons are EF1. $\square$

### Lemma 4. Two agents always permit EF1

For two agents and arbitrary real additive externalities, an EF1 allocation exists.

This is an existing result [2, Theorem 3.4]. For completeness, an elementary existence proof follows. Put $v=v_{12}$ and choose a two-part partition $(S,T)$ minimizing $|v(S)-v(T)|$ among all partitions. Let $g=v(S)-v(T)$, and first assume $g>0$. At least one item contributes a positive number $t>0$ to $g$: either an item in $S$ has positive $v$, or an item in $T$ has negative $v$. Moving such an item to the other bundle changes $g$ to $g-2t$. If $g>t$, then $|g-2t|<g$, contrary to the choice of partition. Thus $g\le t$, and deleting that item eliminates the envy in the orientation where agent 1 receives $T$. In the other orientation she does not envy. The cases $g<0$ and $g=0$ follow by symmetry or immediately. Agent 1 is therefore EF1 whichever bundle she receives. Let agent 2 choose her preferred of the two complete allocations. She has no envy, and agent 1 retains EF1. $\square$

### Corollary 5. Sharp counts in the unrestricted additive model

Three is both the minimum number of agents and the minimum number of items in an instance with no EF1 allocation. The negative example can have all utility entries nonnegative.

**Proof.** Theorem 1 provides three agents and three items. Lemma 3 excludes fewer items for every agent count. Lemma 4 excludes two agents for every item count, and the one-agent case is trivial. $\square$

The item-count minimality is not conditional on using cyclic symmetry, integer utilities, or the particular table in Section 3.

## 6. Stability and verification boundary

Adding a constant $b_{i,x}$ to all recipient values $u_i(j,x)$ for fixed $i,x$ leaves every difference row unchanged. In particular, adding one to every entry gives a strictly positive counterexample with values in $\{1,2,3,5\}$.

The displayed instance is also stable under small independent perturbations. For each of the nine witness comparisons, the gap after any single deletion is at least one, and the undeleted gap is at least three. Perturb each item-recipient utility by less than $\varepsilon$ in absolute value. After a deletion, two items remain and the corresponding swap-gap changes by less than $4\varepsilon$; with no deletion, it changes by less than $6\varepsilon$. Thus every witness persists whenever $\varepsilon<1/4$. Applied to the shifted profile, this gives a neighborhood of strictly positive utility profiles with no EF1 allocation.

The exact verifier uses only Python's standard library. It evaluates the original utilities before and after swapping bundles for all allocations and deletions, checks agreement with (2)--(3), and checks the parameter classification on a finite positive grid including its equality boundaries. Finite testing does not prove Theorem 2 for real parameters or the universal minimality lemmas; their proofs are supplied above.

The result leaves open the smallest counterexample under the no-chores condition, the binary case with chores, and broader questions concerning the exact optimal EF-$k$ relaxation. It makes no coefficient-minimality claim for the alphabet $\{0,1,2,4\}$ and no claim of global bibliographic priority beyond the recorded search.

## References

1. Frank Connor, Max Dupré la Tour, Vishnu V. Narayan, and Šimon Schierreich. *Tight Asymptotic Bounds for Fair Division with Externalities*. IJCAI 2026, pp. 3359–3367. [DOI: 10.24963/ijcai.2026/373](https://doi.org/10.24963/ijcai.2026/373). [Official PDF](https://ijcai.org/proceedings/2026/0373.pdf). [Author version, arXiv:2601.13287v1](https://arxiv.org/html/2601.13287v1). Section 7 poses the small-explicit-counterexample and universal-existence questions.
2. Haris Aziz, Argyrios Deligkas, Eduard Eiben, Viktoriia Korchemna, Šimon Schierreich, Warut Suksompong, Zhaohong Sun, and Toby Walsh. *Fair Allocation of Indivisible Items with Externalities*. Unified author manuscript, 32 pages, accessed 24 November 2026. [Author-hosted full text](https://cgi.cse.unsw.edu.au/~haziz/externality.pdf). Relevant locations: Definition 2.2, Theorems 3.4–3.5, and Section 7. This author manuscript combines the authors' AAAI 2023 and AAAI 2024 papers; its file does not supply a publication date on the title page.
3. Haris Aziz, Warut Suksompong, Zhaohong Sun, and Toby Walsh. *Fairness Concepts for Indivisible Items with Externalities*. AAAI 2023, pp. 5472–5480. [DOI: 10.1609/aaai.v37i5.25680](https://doi.org/10.1609/aaai.v37i5.25680). [arXiv:2110.09066](https://arxiv.org/abs/2110.09066). The general model and earlier EF1 existence results originate here; the updated unified text in [2] was used for full-text comparison.
