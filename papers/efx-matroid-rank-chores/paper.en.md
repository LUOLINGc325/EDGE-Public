# Exact chore EFX for matroid ranks with common independent anchors

24 November 2026

## Abstract

Complete envy-freeness up to any chore (EFX) remains open for heterogeneous binary submodular costs. We give an exact constructive criterion based on disjoint sets that are independent in every agent’s matroid. It yields EFX for arbitrary heterogeneous matroid ranks if at least one agent has rank at most two, even with individual loops, and for heterogeneous paving matroids of unrestricted ranks. For personalized two-color rank costs and enough chores, we construct an envy-free allocation with nonempty bundles minimizing total own cost among such allocations. The minimum is the number of agents plus one if all binary signatures appear, and is the number of agents otherwise.

## 1. Model and results

There are $n\ge1$ agents and a finite set $M$ of $m$ indivisible chores. Agent $i$ has normalized monotone cost $c_i$, so $c_i(\varnothing)=0$ and $c_i(S)\le c_i(T)$ for $S\subseteq T$. A complete allocation $(X_1,\ldots,X_n)$ partitions $M$, with empty bundles allowed. It is envy-free (EF) if $c_i(X_i)\le c_i(X_j)$ for all $i,j$. Here EFX requires
$$
c_i(X_i\setminus\{g\})\le c_i(X_j)
\quad(i,j\in[n],\ g\in X_i).
$$
The condition includes chores whose marginal cost in $X_i$ is zero.

A matroid rank is a normalized, monotone, submodular cost whose single-element increments are zero or one. An independent set has rank equal to its size. A loop has singleton rank zero, and a circuit is a minimal dependent set.

**Theorem 1 (independent anchors).** Each agent has a matroid rank cost $r_i$. Suppose there are $n$ pairwise disjoint sets $A_1,\ldots,A_n$, each of size $t\ge0$ and independent in every agent's matroid. If a distinguished agent $p$ has total rank at most $t+1$, a complete EFX allocation exists, and $p$ can be exactly envy-free.

**Corollary 1 (one low rank).** Complete EFX exists whenever at least one of the heterogeneous matroids has rank at most two. Individual matroids may have loops.

**Corollary 2 (paving).** Complete EFX exists for heterogeneous paving matroid ranks, including different ranks across the agents. More generally, if the minimum rank is $r\ge2$, it suffices that every set of size at most $r-1$ be independent in every matroid. Thus any counterexample must have minimum rank $r\ge3$ and some circuit of size at most $r-1$.

**Theorem 2.** Suppose each agent $i$ has a map $b_i:M\to\{0,1\}$ and $c_i(S)=|\{b_i(g):g\in S\}|$. Let $B=\{(b_1(g),\ldots,b_n(g)):g\in M\}$ be the set of signatures. If $m\ge n$, there is an EF allocation with all bundles nonempty attaining the minimum total cost over such allocations, namely
$$
n+\mathbf 1\{B=\{0,1\}^n\}.
$$
When every signature occurs, any chosen agent can be the sole agent with own cost two. If $0<m<n$, complete EF is impossible because an owner of a chore envies any empty bundle. Complete EFX still exists, and the empty instance is EF.

## 2. Matching independent anchors to extra chores

Assign a disjoint anchor $A_i$ to every agent provisionally. Write $E=M\setminus\bigcup_i A_i$ for the extras. Treat the anchors as labeled sets, so that when $t=0$ the $n$ empty anchors still have distinct labels. Call a pair $(A_i,e)$ extending if $r_p(A_i\cup\{e\})=t+1$. Greedily take disjoint extending pairs, using each anchor and each extra at most once, until $n-1$ pairs are chosen or none can be added. Give the matched bundles $A_i\cup\{e\}$ to distinct agents other than $p$. Assign the unmatched anchors one per remaining agent, including $p$. Give all remaining extras to $p$.

Every bundle contains a common independent anchor and hence costs at least $t$ to every observer. Each agent other than $p$ receives at most $t+1$ chores. After any deletion, matroid rank is at most the number of chores, hence at most $t$. If $n-1$ extending pairs were chosen, all other bundles cost $t+1$ to $p$, which is at least the cost of her own bundle. If the process stops earlier, fix the unmatched anchor $A$ given to $p$. Every remaining extra $e$ satisfies $r_p(A\cup\{e\})=t$, so it belongs to the closure of $A$ in the distinguished matroid. Adding all remaining extras therefore leaves rank $t$. In both cases $p$ is EF, and the allocation is EFX for all. This proves Theorem 1. Given the anchors, at most $n|E|$ rank queries construct the graph of extending pairs. A greedy scan of its edges suffices.

For Corollary 1 let $U=\{e:r_i(\{e\})=1\text{ for every }i\}$. If $|U|\ge n$, take $n$ distinct singleton anchors from $U$ and apply Theorem 1 with $t=1$. If $|U|<n$, use Tao et al. [1, the first case in the proof of Theorem D.1]. That case guarantees a complete exact EFX allocation for arbitrary normalized submodular binary-marginal costs with fewer than $n$ universally costly chores, which includes this matroid-rank profile. Their separate case $|U|\ge n$ gives a factor-two guarantee for arbitrary ranks.

Here is a direct matroid proof of that known case. Give each chore outside $U$ to some agent for whom it is a loop. Insert the chores of $U$ one at a time. Maintain that each owner holds at most one universal chore and sees all its other chores as loops. Choose an agent $i$ without a universal chore and insert the new chore there if EFX is preserved. If the insertion fails, there is an agent $j\ne i$ whose bundle has rank zero to $i$, so $j$ holds no universal chore. Transfer that entire bundle to $i$ and give the new universal singleton to $j$. The new owner $i$ has rank zero and $j$ holds a singleton, so both satisfy EFX. Everyone else sees $i$’s bundle weakly grow and sees the new singleton of $j$ at rank one, at least their own rank. The invariants hold by induction.

For Corollary 2 choose a minimum-rank agent. If the minimum rank is at most one, Theorem 1 applies directly with empty anchors. For $r\ge2$ and $m\ge n(r-1)$ partition any $n(r-1)$ chores into anchors of size $r-1$. They are independent by assumption. For $m<n(r-1)$ distribute chores in bundles of sizes $q$ or $q+1$, where $q=\lfloor m/n\rfloor<r-1$. Each bundle contains $q$ independent chores, and a trim has at most $q$ chores. This verifies EFX in the small case. In a paving matroid of rank $r_i$ every set of size less than $r_i$ is independent, so the corollary covers any profile of paving matroids. A simple matroid has no circuits of size one or two, so an all-simple profile of minimum rank three also satisfies the corollary.

A related form applies to normalized monotone costs with constant singleton cost inside each agent. If one agent has loopless rank at most two, the same universal singleton construction works because each trimmed bundle of another agent contains at most one item and each other bundle contains at least one. When $m<n$ give distinct singletons, and when $n\le m<2n-1$ use nonempty bundles of at most two items. Thus this related case also admits complete EFX.

## 3. Exact envy-freeness for two colors

Assume $m\ge n$. Any allocation with nonempty bundles has total own cost at least $n$. Think of a signature as one bit per observer.

**A missing signature.** Choose $u\in\{0,1\}^n\setminus B$. Assign each chore to a coordinate where its signature differs from $u$. Every nonempty own bundle is monochromatic to its owner. While an empty bundle remains, transfer a single chore from a bundle of size at least two. Such a donor exists since $m\ge n$. The donor keeps a nonempty monochromatic bundle and the recipient's singleton is monochromatic. At completion every agent has own cost one and views every bundle as having cost at least one. The allocation is EF and has total cost $n$.

**Every signature occurs.** First suppose all owners could have own cost one in an allocation with nonempty bundles. Their chosen colors would give a word $v\in\{0,1\}^n$. A chore with the complementary word belongs to no owner's chosen color. This contradicts completeness, so the total cost is at least $n+1$.

To attain this bound, choose any distinguished agent $p$. Assign a chore to the first coordinate $i\ne p$ where its bit is one. Send it to $p$ when all coordinates other than $p$ are zero. For each $i\ne p$, the two signatures having only that nonpivot bit equal to one among nonpivot coordinates, and having opposite $p$ bits, both go to $i$. Thus $X_i$ is nonempty, monochromatic in coordinate $i$, and mixed in coordinate $p$. The two words whose nonpivot bits all vanish make $X_p$ mixed in coordinate $p$. Each nonpivot agent has own cost one, and $p$ assigns cost two to every bundle. The allocation is EF and attains $n+1$. The construction works also for $n=1$, when there are no nonpivot coordinates.

A missing word can be found by checking at most $m+1$ words in numeric order against the input signatures, stopping at $2^n$ if that happens first. Each assignment and cost check uses at most polynomially many bit operations. For $m<n$ the distinct singletons used in Theorem 1 are EFX.

For example, two agents with all four signatures $00,01,10,11$ can give $00,01$ to the second coordinate and $10,11$ to the first with bits written in agent order. The first agent pays one, the second pays two, and both bundles are mixed to the second. Omitting $11$ instead lets the two owners pay one each by using the missing-signature rule.

## 4. Scope and prior work

Tao et al. prove exact EFX for binary cancelable costs and factor-two EFX for binary submodular costs [1]. A rank cost with two parallel classes can fail cancelability. For example, choose singletons of opposite colors and add a fresh chore matching the color of one singleton. The initially tied singleton costs become unequal. Lin et al. explicitly leave the binary submodular chore class open [2, §4]. Their nullity costs $S\mapsto |S|-r_i(S)$ can fail EFX even when the underlying matroid is a two-color partition matroid. The present criteria apply to rank costs, allow individual loops in the low-rank corollary, and cover heterogeneous paving matroids. Positive results for additive costs use a different assumption [3]. General binary submodular chores remain open.

The paired verification files check the two-color existence construction and the cross-agent cost inequalities used by the anchor argument. The reproducible enumeration checks both exact fairness guarantees on finite cases and tests the social-cost formula. The general guarantees follow from the constructions above.

## References

1. B. Tao, X. Wu, Z. Yu and S. Zhou, *On the Existence of EFX (and Pareto-Optimal) Allocations for Binary Chores*. [arXiv:2308.12177](https://arxiv.org/abs/2308.12177)
2. Z. Lin, S. Liu, B. Tao and S. Zhou, *Non-Existence of EFX Chore Allocations for Monotone Cost Functions with Binary Marginals*, 2026, §§2–4. [arXiv:2608.10572v1](https://arxiv.org/abs/2608.10572v1)
3. W. He and B. Tao, *EFX for Additive Chores: Nonexistence, Pareto Incompatibility, and Bi-Valued Existence*, 2026. [arXiv:2606.08872v2](https://arxiv.org/abs/2606.08872v2)
