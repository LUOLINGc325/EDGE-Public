---
title: "Three Items with Additive Externalities: Oriented Obstructions and Binary Existence"
lang: en-US
---

# Abstract

For complete allocations with additive externalities, three items suffice to rule out envy-freeness up to one item (EF1) at every agent count $n\ge3$. We classify all signs of the recipient effects that obstruct EF1 in an open domain of ordered, recipient-specific differences. The obstructing graphs are exactly directed cycle covers without cycles of length one or two. In the binary utility domain, allowing relative chores, we prove EF1 existence for any number of agents and at most three items. We also certify several finite size bounds beyond three items by exact constraints, including binary existence for three agents and six items. An exact finite certificate also shows that three-agent, three-item nonexistence requires at least four distinct raw utility levels.

## 1. Model

Let $M$ be the set of items and $N=[n]$ the set of agents. The utility $u_i(j,x)$ is the contribution to observer $i$ when item $x$ is assigned to recipient $j$. Observer utility is additive, and an allocation $A=(A_i)_{i\in N}$ is a complete partition with empty bundles allowed. Agent $i$ envies $j$ if swapping $A_i,A_j$ would strictly increase $i$'s utility. EF1 means that for each ordered pair one may delete zero or one item from the allocation so that the observer no longer envies the target. This deletion precedes the swap and may differ across pairs.

Put $v_{ij}(x)=u_i(i,x)-u_i(j,x)$ for $i\ne j$. For fixed $A,i,j$, an item contributes $w_x=v_{ij}(x)$ if assigned to $j$, $w_x=-v_{ij}(x)$ if assigned to $i$, and zero otherwise. Thus the envy gap after the best possible optional deletion is

$$
\rho_{ij}(A)=\sum_{x\in M}w_x-\max\bigl(\{0\}\cup\{w_x:x\in M\}\bigr).
\tag{1}
$$

This is the standard asymmetric comparison form of the externalities model. Arbitrary real rows $v_{ij}(x)$ can be realized even with nonnegative $u_i(j,x)$: for each $i,x$, choose $u_i(i,x)=\max(0,\max_{j\ne i}v_{ij}(x))$ and subtract $v_{ij}(x)$ to obtain the other entries. No chores means $v_{ij}(x)\ge0$ for every ordered pair and item. Binary means $u_i(j,x)\in\{0,1\}$ for every observer, recipient, and item. Equivalently for each $(i,x)$ the differences all lie either in $\{0,1\}$ or in $\{0,-1\}$. In such a binary instance each $w_x$ is $0,1$, or $-1$; (1) is violated exactly when $\sum_xw_x\ge2$.

## 2. Exact obstruction with inhomogeneous three-item weights

Let the items be $a,b,c$, let $n\ge3$, and assume for every distinct ordered pair

$$
v_{ij}(a)>v_{ij}(b)>0,\qquad |v_{ij}(c)|>v_{ij}(b).
\tag{2}
$$

The quantities in different ordered pairs may be completely different. Draw an arc $i\to j$ exactly when $v_{ij}(c)>0$. Write $O_p$ and $I_p$ for the sets of out-neighbors and in-neighbors of $p$ in this graph.

**Theorem 1.** In (2) an EF1 allocation fails to exist if and only if the directed graph is a vertex-disjoint collection of directed cycles, each of length at least three, covering all $n$ agents. Every such choice of signs obstructs EF1 for all magnitudes satisfying (2).

**Proof.** Fix the owner $p$ of $c$. We analyze all possible bundle shapes.

- **Three singleton bundles.** Let $q,r$ be the owners of $a,b$. The allocation is EF1 exactly when $q,r\in O_p$. If one is outside $O_p$, $p$'s comparison toward that holder has two strictly positive contributions: the target's item and keeping $c$ in $p$'s bundle. Both cannot be removed. If both are inside $O_p$, every comparison has at most one positive term. In particular the two holders of $a,b$ each have a negative contribution from their own item in any comparison, and empty observers face at most one target item.
- **$\{a,c\}$ at $p$, $\{b\}$ at $q$.** This is EF1 exactly when $I_p$ is empty. If $i\in I_p$, her comparison toward $p$ has two positive target contributions, each larger than the possible own subtraction $v_{ip}(b)$. If there is no such $i$, each other observer sees at most one positive target contribution from $p$. For $p$'s comparison toward $q$, deletion of $c$ leaves $v_{pq}(b)-v_{pq}(a)<0$. For $p$'s comparison toward an empty bundle, deleting $c$ also suffices.
- **$\{b,c\}$ at $p$, $\{a\}$ at $q$.** This is EF1 exactly when $I_p\subseteq\{q\}$ and $q\in O_p$. Any empty $i\in I_p$ sees two positive terms in the bundle at $p$. The observer $q$, even if in $I_p$, can delete $c$, because her own $a$ outweighs $b$. If $q\notin O_p$, $p\to q$ has two positive terms larger than the sole subtraction from $b$, so it fails EF1. If $q\in O_p$, $p$ can delete the target's $a$ and will not envy. Every remaining comparison has a valid deletion.
- **$\{a,b\}$ at $q\ne p$.** An empty agent exists and strictly envies $q$ after either item is removed.
- **All items at $p$.** This is EF1 exactly when $I_p$ is empty. For an empty observer with a positive arc to $p$, two positive terms survive any deletion. Otherwise, deleting $a$ leaves $v_{ip}(b)+v_{ip}(c)<0$ for every empty observer $i$. The owner $p$ can delete $c$ when comparing against an empty bundle.

In the absence of any solution, the first and second shapes require every vertex to have out-degree at most one and in-degree at least one. Counting arcs forces both degrees to equal one at every vertex. The third shape succeeds in this situation precisely when the unique predecessor is also the successor, which is a two-cycle. Therefore no EF1 allocation exists exactly for the stated cycle covers. Conversely all the shapes listed fail for such a graph. $\square$

For any $n\ge3$ this yields an unrestricted counterexample by taking a single directed $n$-cycle. Together with the known two-agent existence theorem and the preceding fixed three-agent paper's existence result for at most two items, three is the precise minimum item count for failure at each fixed $n\ge3$. On three vertices the one-cycle witnesses are the two orientations of the old cyclic pattern. Formula (2) permits independent changes in every directed pair while the graph classification remains exact.

The number of failing oriented sign patterns equals the number of permutations with neither fixed points nor transpositions, namely

$$
n!\,[z^n]\frac{\exp(-z-z^2/2)}{1-z}.
\tag{3}
$$

Indeed cycles of length at least three form a permutation with exponential generating function $\exp(\sum_{k\ge3}z^k/k)$. Alternatively, inclusion–exclusion for forbidden one- and two-cycles gives the coefficient $\sum_{a+2b\le n}(-1)^{a+b}/(a!\,2^b b!)$. Its limit is $e^{-3/2}$, by absolute convergence. Under independent fair signs on the $n(n-1)$ ordered pairs the exact probability of failure on (2) is therefore asymptotic to $e^{-3/2}n!/2^{n(n-1)}$, independent of the choice of magnitudes.

## 3. Binary existence with three items and any number of agents

**Theorem 2.** For an arbitrary number of agents, every binary externalities instance on at most three items admits EF1, including instances with relative chores.

**Proof.** The known two-agent case and at-most-two-item result handle those boundary sizes. Assume $n\ge3$ and three items. Construct a bipartite graph between the agents and items with an edge from $i$ to $x$ if $u_i(i,x)=1$. Say an item is *globally zero on the diagonal* if it has no incident edge. The following elementary facts follow from binarity. A matched item held by its incident agent gives that agent a nonnegative difference against every target. An item with no edge incident to an observer gives that observer a nonpositive difference against every target. In a singleton allocation, any agent holding an incident item can delete the sole target item to remove envy. Any agent with no incident items can delete her own singleton to remove envy.

If the matching number is three, give each matched item to its matched agent. The foregoing facts and the singleton targets prove EF1. If the matching number is zero, allocate all three as distinct singletons. There is no positive target contribution, and each observer can delete her own item.

If the matching number is one and at least two items have incident edges, all edges are incident to one agent. In fact any two nonempty item neighborhoods must be the same singleton, or a size-two matching exists. Give that agent a privately valued singleton and distribute the other items as different singletons. If just one item $a$ has any incident edge, give it to a neighboring agent $j$ along with one globally zero item. Give the other globally zero item to any distinct agent $i$. Let $i$ choose the one with larger $v_{ij}$ from the two zero items. On $i\to j$, the other zero item in $j$'s bundle contributes at most the comparison value of the one held by $i$, so deleting $a$ removes any envy. Every other empty observer sees at most one positive contribution from $j$'s double. From $j$ toward $i$ or an empty bundle, the only possible positive term is keeping the zero item in $j$'s bundle. Thus all comparisons are EF1.

Now suppose the matching number is two. If all three items have incident edges, Hall's theorem gives two possibilities. Some two items may have the same lone neighbor $j$. Give those two to $j$, and give the third item to an incident agent different from $j$, who exists because the matching number is two. Every other observer has nonpositive differences on both items held by $j$, and $j$ has nonnegative differences on both of her items. The remaining comparisons involve singleton targets or empty bundles and satisfy EF1. If no two items share a lone neighbor, the Hall-deficient set is all three items, whose joint neighborhood has at most two agents. Give two matched singletons to those agents, and the third item as a singleton to an agent outside the neighborhood. The latter observer has no positive target difference, and every other comparison between singletons or with an empty bundle is EF1 by the same facts.

Finally, if there is a globally zero item $c$, match the other two items $a,b$ to $j,k$, respectively. Try adding $c$ to either matched bundle. For the allocation with $c$ at $j$, the only possible EF1 violation is $j\to k$. An empty observer sees at most one positive term in the double. Holder $k$'s matched singleton gives no positive own term, and $j$'s comparison with an empty agent has at most the single positive term from retaining $c$. Likewise the placement of $c$ at $k$ can fail only on $k\to j$. If both attempts fail, the binary gap condition forces

$$
\begin{aligned}
v_{jk}(b)&=1, & v_{jk}(a)&=0, & v_{jk}(c)&=-1,\\
v_{kj}(a)&=1, & v_{kj}(b)&=0, & v_{kj}(c)&=-1.
\end{aligned}
$$

The first and fourth equalities give $u_j(j,b)=u_k(k,a)=1$. Swapping the two matched items maintains the matching. Give $c$ to $j$ in that swapped matching. Then $j\to k$ has target contribution $v_{jk}(a)=0$, and the other comparisons remain feasible by the same single-positive-term bounds. This yields EF1 in every case. $\square$

The proof works directly with the recipient tensor. Allowing arbitrary signs independently on each ordered-pair difference, while only bounding the magnitudes by one, is a larger domain. The binary theorem uses the common diagonal entry of an observer and item.

## 4. The minimum utility alphabet for three agents and three items

The size of the alphabet here is the number of distinct entries in the entire raw utility tensor. The earlier three-agent example uses the four levels $\{0,1,2,4\}$. We show that four is minimal at this agent and item count.

Normalize an arbitrary globally three-level alphabet by a common increasing affine map to $\{0,1,t\}$, with $t>1$. This preserves the sign of every residual gap (1), since the shift cancels in each observer's comparison and the scale is positive. Each relevant difference has sign determined by the order of its two levels and has nonzero absolute value in $\{1,t-1,t\}$. With at most three items, a failure in (1) requires at least two strictly positive contributions. With three strictly positive contributions, failure is automatic. With two positives and a third contribution nonpositive or absent, failure is equivalent to the smaller positive exceeding the magnitude of that third contribution. Thus the answer for any pattern of level labels depends only on whether $t-1<1$, $t-1=1$, or $t-1>1$. Representatives of these three cases are the affine normalization of $\{0,2,3\}$, the alphabet $\{0,1,2\}$, and the alphabet $\{0,1,3\}$.

For every representative we generate an exact Boolean counterexample formula. Each raw entry is encoded by three one-hot indicators. For each allocation and ordered pair there is a candidate violation indicator. Each local level assignment on the pair's relevant items is evaluated by (1). Whenever that local assignment is EF1, a truth-table clause forbids the candidate indicator from being true on that assignment. The disjunction of violation indicators for each of the $3^3$ allocations requires all allocations to fail. Hence the formula is satisfiable exactly if a counterexample exists. All three formulas are unsatisfiable, with DRAT certificates checked against the generated CNF. The two-level case was proved in Theorem 2. The four-level example follows from Theorem 1 itself. On three agents use a directed three-cycle and the difference rows $(2,1,2)$ on its arcs and $(2,1,-2)$ otherwise. Take self utilities $(2,1,2)$, set the two other recipients' utilities on $a,b$ to zero, and set their utilities on $c$ to zero on an arc and four off an arc. The global alphabet is $\{0,1,2,4\}$. This is the earlier cyclic obstruction up to the choice of orientation. [Ternary CNF generator](evidence/ternary_cnf.py)

## 5. The no-chores boundary and exact size checks

For any $n$ and at most $n+1$ items, a no-chores instance has a complete EF1 allocation. At most $n$ items can be placed as different singletons. With $n+1$ items, designate one agent $j$ to receive the last two. Each other agent $i$ takes in turn an item maximizing $v_{ij}$ over the remaining items. Both items eventually given to $j$ have $v_{ij}$-value at most that of $i$'s chosen singleton. Deleting one of $j$'s items therefore removes any envy toward $j$. All other targets are empty or singletons, so optional deletion of the target singleton suffices because there are no chores.

The following larger finite size bounds were checked by exact unsatisfiability of the corresponding counterexample constraints. Smaller item counts follow by padding with zero items.

| Utility domain | Agents | Largest tested item count certified by the constraints |
| --- | ---: | ---: |
| Binary, including relative chores | 3 | 6 |
| Binary, including relative chores | 4 | 5 |
| Arbitrary no-chores differences | 3 | 6 |
| Arbitrary no-chores differences | 4 | 6 |

Here the search space is all utility profiles in the stated domain, not a sampled library of instances. For fixed $n,m$, post one constraint for each of the $n^m$ owner assignments. Its condition is that at least one ordered pair fails EF1. In the binary case the variables are the raw Boolean utilities $u_i(j,x)$. For a pair and an allocation with $k$ relevant items, each contribution is the sum of two Boolean literals minus one. If $x$ belongs to $j$ the literals are $u_i(i,x)$ and $\neg u_i(j,x)$; for $x$ at $i$ they are reversed in recipient. The violation is that the sum of the $2k$ literals is at least $k+2$. All-one observer/item rows may be normalized to all zero with no effect on any gap.

For the no-chores domain use the $v_{ij}(x)$ as independent nonnegative integer variables. Given a pair with target items, failure means that the gap $g=\sum w_x$ and each $g-v_{ij}(x)$ for target $x$ are strictly positive. Deletion from an own bundle cannot reduce this gap. A real counterexample supplies at least one witness pair per allocation. All required inequalities are strict in the selected witnesses, so nonnegative rational approximation preserves them. Multiplying by a common denominator gives an integer counterexample in which every required gap is at least one. Conversely such an integer instance is a real counterexample. Thus the finite list of formulas exhausts the real no-chores domain as well.

The standard-library checker enumerates all 64 and 4,096 directed sign graphs for $n=3,4$, assigns inhomogeneous positive magnitudes satisfying (2), and checks (1) directly. It also checks obstructing permutations through eight agents and sampled binary profiles. The finite-domain solver checker provides the additional size cases in the table. Its exact solver output is recorded separately from the four DRAT refutations. We additionally certify the three-agent, six-item binary bound with an independently generated CNF and a checked DRAT refutation. The CNF uses a guarded sequential counter for each Boolean threshold and may assume lexicographically sorted item signatures by invariance under relabeling items. The reproduction record gives the exact hashes and checker versions for the four DRAT refutations. [Direct profile checker](evidence/verify_profiles.py) · [Profile output](evidence/profile_results.json) · [Exact constraint checker](evidence/verify_solver.py) · [Binary CNF generator](evidence/binary_cnf.py) · [Reproduction and certificates](evidence/README.md) · [Certificate hashes](evidence/certificate_index.json) · [Exact solver output](evidence/solver_results.json)

## 6. Attribution and remaining scope

Connor, Dupré la Tour, Narayan and Schierreich give the asymmetric comparison representation and a binary no-chores nonexistence bound from discrepancy at large size. Their Section 7 asks for small explicit counterexamples and for agent-count thresholds by valuation domain. The preceding public paper gives a three-agent, three-item unrestricted cyclic obstruction, an exact four-parameter cyclic subfamily, and the minimum joint counts. Theorem 1 gives all recipient-oriented sign patterns within (2) and realizes failure for every fixed $n\ge3$. [Connor et al., IJCAI 2026 §§3.1, 5, 7](https://www.ijcai.org/proceedings/2026/0373.pdf) · Earlier three-agent construction

Aziz et al. prove EF1 existence for three agents when binary valuations have no chores, with no restriction on the number of items. Their two-agent theorem handles general externalities. The parallel complexity paper gives the equivalence of binary EF1 and binary EFX and leaves binary three-agent existence with relative chores as a conjecture. Accordingly the binary finite bounds above concern the domain with chores and do not replace the known unlimited-item no-chores result. The no-chores table concerns arbitrary real weights. [Aziz et al., AAAI 2023 Theorems 5.2 and 6.3](https://ojs.aaai.org/index.php/AAAI/article/download/25680/25452) · [Unified author manuscript §§2, 3, 7](https://cgi.cse.unsw.edu.au/~haziz/externality.pdf) · [Deligkas et al., §§4, 6](https://arxiv.org/pdf/2308.08869)

The results leave general binary existence at each small agent count for arbitrarily many items unresolved. The sign characterization concerns (2), in which the stronger of the two positive items is consistently the same item across ordered pairs. Other three-item magnitude regimes may have different obstructions.
