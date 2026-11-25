# Deterministic paths in self-deleting graphs via minimal separating families

**AI-assisted research draft · 24 November 2026**

## Abstract

A self-deleting graph assigns a set of edges to each vertex; those edges become unavailable when that vertex is visited. Given a vertex budget $k$ and a maximum deletion-set size $\mu$, we give a deterministic algorithm for finding a shortest conforming $s$-$t$ path within the budget in time $2^{O(k\log(\mu+2))}(n+m)\log(n+2)$. This supplies the parameter dependence conjectured by Dvořák et al. at ISAAC 2025. The argument combines their color-state search with the existing minimal separating families of Gabizon, Lokshtanov and Pilipczuk. The required family preserves distinct colors for at most $k-1$ path edges while mapping all relevant off-path deletions to one unused color. Dummy labels handle paths strictly shorter than the budget without modifying the graph. We prove soundness, completeness, witness recovery and the uniform running-time bound, and obtain the corresponding deterministic bound parameterized by vertex cover. The contribution is this application and parameter analysis; neither the separating-family construction nor the color-state search is claimed as new.

## 1. Problem and main result

Let $G=(V,E)$ be a finite simple undirected graph with $n=|V|$ and $m=|E|$. Its deletion function is $f:V\to 2^E$. Write

$$
\mu=\max_{v\in V}|f(v)|,
\qquad
F=\sum_{v\in V}|f(v)|.
$$

The graph and all deletion sets are given explicitly. A walk

$$
W=(v_0,e_1,v_1,\ldots,e_\ell,v_\ell)
$$

is **conforming** if

$$
e_i\notin f(v_j)
\quad\text{for every }1\le i\le\ell
\text{ and }0\le j<i. \tag{1}
$$

Thus the starting vertex deletes its edges before the first move. A destination vertex may delete the edge just used to reach it. Deletions at the final vertex do not affect a walk that terminates there. This is exactly the convention in Dvořák et al. [D]. A path has no repeated vertices.

The input also specifies $s,t\in V$ and a positive integer $k$. The task is to find a shortest conforming $s$-$t$ path among those with at most $k$ vertices, or to report that none exists. In particular, the task includes the decision version called *Shortest Self-Deleting $s$-$t$-Path* in [D]. All logarithms in running-time expressions have base two.

Dvořák et al. give a randomized $2^{O(k\log\bar\mu)}\operatorname{poly}(n)$ algorithm, where $\bar\mu=\max\{\mu,2\}$, and deterministic bounds with exponents $O(k\mu)$ and $O(k\log(k\bar\mu))$. Their published conclusion asks whether the randomized parameter dependence can be obtained deterministically [D, §6; full version §7].

**Theorem 1.** There is a deterministic algorithm for the stated problem with running time

$$
2^{O(k\log(\mu+2))}
(n+m+F)\log(n+m+2). \tag{2}
$$

Since $F\le n\mu$ and $G$ is simple, the same bound can be written as

$$
2^{O(k\log(\mu+2))}(n+m)\log(n+2). \tag{3}
$$

The constants in the asymptotic notation are independent of both $k$ and $\mu$. The algorithm reconstructs a shortest conforming path whenever one exists within the budget.

For $\mu\ge1$, $\log(\mu+2)=\Theta(\log\bar\mu)$. Consequently (3) answers the conjecture in its full parameter range. The case $\mu=0$ is ordinary graph search.

The proof uses one external construction theorem, stated in Section 2. The color-state search is the search underlying [D, Lemma 4.13]; we rederive its correctness to make the application self-contained. The source already defines the asymmetric half-rainbow condition [D, Definition 4.11]: path edges are injectively colored and separated from off-path deletions. Our step is to satisfy that existing condition, with terminal deletions omitted when no move remains, by applying a known minimal separating family at the required parameters.

## 2. The existing separating-family theorem

For an integer $p\ge1$, write $[p]=\{1,\ldots,p\}$. A family of maps

$$
\mathcal H\subseteq\{h:[N]\to[p+1]\}
$$

is **$(p,K)$-minimal separating** if, whenever $C,B\subseteq[N]$ satisfy

$$
C\cap B=\varnothing,\quad |C|=p,\quad |B|\le K-p,
$$

some $h\in\mathcal H$ satisfies

$$
h(C)=[p],\qquad h(B)\subseteq\{p+1\}. \tag{4}
$$

The equality $h(C)=[p]$ implies that $h$ is injective on $C$.

**Lemma 2 (Gabizon-Lokshtanov-Pilipczuk).** For integers $1\le p\le K\le N$ and $N\ge2$, a $(p,K)$-minimal separating family can be constructed deterministically with size

$$
K^{O(1)}
\left(\frac Kp\right)^{2p}
2^{O(p)}\log N, \tag{5}
$$

in time bounded by (5) multiplied by $N$.

This is [GLP, Definition 2.4 and Theorem 3.1] with parameters renamed. The source's notation $O_K$ hides only a polynomial factor $K^{O(1)}$, as specified at the start of its Section 2. Its Section 4 proves the construction. We use this established theorem and make no new claim about constructing separating families.

The distinction between the two sets is important. Only the elements of $C$ need distinct colors. The potentially much larger set $B$ may all receive the same color. Here $C$ will contain the path edges, while $B$ will contain deleted edges that do not lie on the path.

## 3. A separating witness for every short path

We first handle elementary cases. If $s=t$, the single-vertex path is optimal. If $k=1$ and $s\ne t$, no solution exists. When $\mu=0$, ordinary breadth-first search solves the problem, including the budget check. If $m=0$ and $s\ne t$, no solution exists. We may replace $k$ by $\min\{k,n\}$: doing so excludes no simple path.

For the rest of the proof, $2\le k\le n$, $\mu\ge1$ and $m\ge1$. Put

$$
p=k-1.
$$

Adjoin a set $Z$ of $p$ dummy labels to the edge labels. The dummies are not vertices or edges of a graph, and they belong to no deletion set. The label universe is

$$
U=E\mathbin{\dot\cup}Z,
\qquad N=m+p.
$$

After numbering $U$ by $[N]$, set

$$
K=\min\{N,p(\mu+1)\}. \tag{6}
$$

In particular, $1\le p\le K\le N$. Construct the family from Lemma 2 on $U$. Restrict each map to the real edge set when it is used by the search algorithm. Colors in $[p]$ are allowed for traversal; color $p+1$ is excluded.

**Lemma 3 (preserving a conforming path).** For every conforming simple $s$-$t$ path $P$ with at most $k$ vertices, the constructed family contains a map $h$ such that:

1. the edges of $P$ have distinct colors in $[p]$;
2. for each edge $e_i$ of $P$, its color has not been deleted by any preceding vertex of $P$.

**Proof.** Write

$$
P=(v_0,e_1,v_1,\ldots,e_\ell,v_\ell),
\qquad v_0=s,\quad v_\ell=t,\quad \ell\le p.
$$

Define the off-path deletion set using only vertices before the terminal vertex:

$$
B=\left(\bigcup_{j=0}^{\ell-1} f(v_j)\right)
\setminus E(P). \tag{7}
$$

There are $\ell$ such vertices, so

$$
|B|\le\ell\mu\le p\mu. \tag{8}
$$

Enlarge $E(P)$ with exactly $p-\ell$ distinct dummy labels to form a set $C$. Then $|C|=p$ and $C\cap B=\varnothing$. Since both sets lie in $U$, also $|B|\le N-p$. Combining the two bounds gives

$$
|B|\le\min\{p\mu,N-p\}=K-p. \tag{9}
$$

Lemma 2 provides $h$ satisfying (4). Therefore all path edges have distinct allowed colors.

Suppose a path edge $e_i$ had the same color as an edge $a\in f(v_j)$ for some $j<i$. If $a\notin E(P)$, then $a\in B$ by (7), so $h(a)=p+1$ while $h(e_i)\in[p]$. If $a\in E(P)$, injectivity on $E(P)$ implies $a=e_i$, contrary to conformity (1). Both cases are impossible. This proves the second assertion. $\square$

Dummy labels are necessary for applying the exact-size requirement $|C|=p$ uniformly when the path is shorter than the budget. They do not change the path problem. Excluding the terminal vertex from (7) is valid because the walk ends on arrival there.

A two-color partition alone would not suffice for this argument. For example, on the path $s,a,t$, take $f(a)=\{\{s,a\}\}$ and all other deletion sets empty. The path is legal: the first edge is deleted after it is used. Assigning the same active color to both path edges would falsely forbid the second move. Distinct colors on the path avoid precisely this collision.

## 4. Searching for a fixed coloring

Fix a map $h:U\to[p+1]$. Define

$$
D_h(v)=\{h(e):e\in f(v)\}\cap[p]. \tag{10}
$$

A walk is **color-compliant** if

$$
h(e_i)\in[p]
\quad\text{and}\quad
h(e_i)\notin D_h(v_j)
\quad(0\le j<i). \tag{11}
$$

Color compliance implies conformity: if a traversed edge itself belonged to an earlier deletion set, its color would violate (11). Lemma 3 states that every conforming path within the budget is color-compliant for at least one map in the family.

### 4.1. The state graph

The states are pairs $(v,R)$, where $v\in V$ and $R\subseteq[p]$. The set $R$ records colors still available **after** processing deletions at the current vertex. The initial state is

$$
(s,[p]\setminus D_h(s)). \tag{12}
$$

For an edge $e=\{u,v\}$, the directed transition

$$
(u,R)\longrightarrow(v,R\setminus D_h(v)) \tag{13}
$$

is present exactly when $h(e)\in R$. Since $R\subseteq[p]$, edges with color $p+1$ are never traversed. For an undirected edge, both orientations are considered separately.

Breadth-first search in this implicit graph finds a shortest route to a state with vertex $t$. We stop expanding a state at distance $p$, since the original budget permits at most $p$ edges. Parent pointers recover a projected walk.

### 4.2. Correctness of the state search

**Lemma 4.** The state search reaches a state with vertex $t$ in at most $p$ transitions if and only if there is a color-compliant $s$-$t$ walk of at most $p$ edges.

**Proof.** Along any state route, repeated application of (12)-(13) gives

$$
R_i=[p]\setminus\bigcup_{j=0}^{i}D_h(v_j), \tag{14}
$$

where $R_i$ is the available set at $v_i$. An edge $e_{i+1}$ is traversed only when its color is in $R_i$. Thus its color belongs to none of the deletion masks of previously visited vertices, including $v_i$, proving (11).

Conversely, given a color-compliant walk, define its state sequence by (14). Each traversed edge has its color in the preceding available set by (11), and the available set at its destination is exactly that given in (13). The sequence therefore follows state transitions. Its number of transitions equals the number of edges of the walk. $\square$

**Lemma 5 (loop erasure).** Every conforming walk contains a conforming simple path with the same endpoints and no more edges. The statement also holds for color-compliant walks.

**Proof.** Suppose $v_a=v_b$ with $a<b$. Remove the closed subwalk between these occurrences, identifying the remaining occurrence with $v_a$. The result is a walk with the same endpoints; if $v_b$ was the final vertex, simply terminate at $v_a$. Every retained edge keeps its original orientation and has only a subset of its previous predecessor vertices. Consequently an edge that was not deleted before its original use cannot become deleted by erasing this subwalk. The same reasoning applies to deletion masks in (11). Repeat until no vertex is repeated. Each erasure strictly decreases the number of edges. $\square$

Combining the lemmas, every accepted state route yields a valid answer to the original problem. This argument does not assume that projecting a simple state route gives a simple graph path: the physical vertex can recur with a different available-color set.

### 4.3. Complete algorithm

The following pseudocode specifies the main procedure after the elementary cases in Section 3. The graph remains unchanged throughout.

```text
p = k - 1
U = real edge labels plus p new dummy labels
N = |U|
K = min(N, p * (mu + 1))
H = construct the GLP (p, K)-minimal separating family on U
best = none

for h in H:
    for v in V:
        D[v] = active colors assigned by h to edges in f(v)
    start = (s, [p] minus D[s])
    run BFS from start on states (v, R), to depth at most p
    from (u, R), for each real edge e = {u, v}:
        if h(e) is in R:
            successor = (v, R minus D[v])
    if BFS reaches a state whose vertex is t:
        retain a shortest such state route if it improves best

if best is none:
    return NO
return loop_erasure(project best to the original graph)
```

For the decision task, the algorithm may return after its first successful coloring. Retaining the best route gives the optimization guarantee in Theorem 1.

**Proposition 6 (shortest witness).** If any conforming path has at most $k$ vertices, the complete algorithm returns a shortest conforming $s$-$t$ path.

**Proof.** Let $d^*\le p$ be the minimum number of edges in such a path. Any successful state route with $d$ transitions projects to a conforming walk, which contains a conforming path of at most $d$ edges by Lemma 5. Hence $d^*\le d$.

Choose a conforming path with $d^*$ edges. Lemma 3 supplies a family member for which it is color-compliant. Lemma 4 supplies a corresponding state route with $d^*$ transitions, so the shortest state route for that member has length at most $d^*$. The minimum retained across the family is therefore exactly $d^*$. Erasing loops cannot produce a path shorter than $d^*$, by the definition of $d^*$. The returned path has exactly $d^*$ edges. If no conforming path exists within the budget, soundness of the state search excludes every acceptance. $\square$

## 5. Uniform running-time analysis

For one map $h$, the state graph contains $n2^p$ states and at most $2m2^p$ directed transitions. Forming all deletion masks costs a polynomial factor in $p$ times $F+n$. Sets of active colors can be represented by bit vectors of length $p$; their operations contribute a polynomial in $p$, which is absorbed in $2^{O(p)}$. Thus one search and mask preprocessing cost

$$
2^{O(p)}(n+m+F). \tag{15}
$$

The factor $F$ is included to account for the explicit deletion-list input. Neither constant-size deletion masks nor a unit-cost operation on arbitrarily long bit vectors is assumed.

Constructing the family and then searching once per map takes at most

$$
K^{O(1)}\left(\frac Kp\right)^{2p}2^{O(p)}
(n+m+F)\log N. \tag{16}
$$

Indeed, the family-construction cost in Lemma 2 is included in (16), since $N=m+p\le m+n$. We have

$$
\frac Kp\le\mu+1,
\qquad
K\le p(\mu+1),
\qquad
p=k-1. \tag{17}
$$

For every absolute constant $c$, the factor $K^c$ is absorbed by $2^{O(k\log(\mu+2))}$: use $\log k\le k$ and $\log(\mu+1)\le\log(\mu+2)$. Substituting (17) into (16) proves (2). The reductions $F\le n\mu$ and $m\le n(n-1)/2$ then give (3), including the costs of reading the input. The elementary cases take polynomial time within the same bound.

The improvement comes from the ratio $K/p$, which is at most $\mu+1$. There is no factor $k^{\Theta(k)}$ from assigning separate colors to all deleted edges. Both $k$ and $\mu$ may grow with the input.

**Known construction refinement.** Bshouty and Gabizon [BG, Appendix B.1, Corollary 1] give a stronger pre-existing minimal separating-family bound with $(K/p)^{p+o(p)}$ in place of $(K/p)^{2p}$, retaining $K^{O(1)}2^{O(p)}\log N$ factors and output-linear construction time. Substituting that established construction in the same algorithm improves the family-size factor in (16). The simpler GLP bound already proves Theorem 1. This refinement is attribution of an existing tool, not an additional construction claim.

## 6. The vertex-cover question

Let $\tau$ be the minimum size of a vertex cover of $G$. The conclusion of [D] also asks for deterministic time $2^{O(\tau\log\bar\mu)}\operatorname{poly}(n)$ for unrestricted conforming $s$-$t$ reachability.

**Corollary 7.** Unrestricted conforming $s$-$t$ reachability, and recovery of a shortest such path, are solvable deterministically in time

$$
2^{O((\tau+1)\log(\mu+2))}(n+m)\log(n+2). \tag{18}
$$

A minimum vertex cover need not be supplied as part of the input.

**Proof.** If $S$ is any vertex cover, then $V\setminus S$ is independent. Along a simple path, at most one vertex outside $S$ can occur before, between or after consecutive vertices of $S$. Therefore every simple path contains at most $2|S|+1$ vertices.

Compute a maximal matching $M$ in linear time and let $S$ be the set of its endpoints. If an edge had both endpoints outside $S$, it could be added to the matching, contradicting maximality; hence $S$ is a vertex cover. Every vertex cover meets all pairwise disjoint edges of $M$, so $|M|\le\tau$ and $|S|=2|M|\le2\tau$.

Invoke Theorem 1 with budget $\min\{n,2|S|+1\}\le4\tau+1$. This budget includes every simple path, and therefore every possible solution. The matching computation and all preprocessing preserve (18). If $\tau=0$, the graph is edgeless, and only the case $s=t$ succeeds. $\square$

## 7. Contribution, verification and limits

The proof resolves the deterministic parameter dependence asked for in [D] by combining two established ingredients at the correct asymmetric parameters. The active-edge/off-path-deletion separation is already present in the half-rainbow condition of [D, Definition 4.11]. The present interface uses short-path padding, a terminal-excluded count, and the uniform substitution $K/p\le\mu+1$ to apply the known minimal separating-family theorem directly to that condition. The GLP family theorem is an external mathematical dependency. The color-state search and its basic use for this problem originate in [D]. The construction refinement in [BG] is also prior work.

The statement covers the original unweighted model with arbitrary explicitly given deletion sets. It does not assert results for edge restoration, nonmonotone changes of edge availability, exact-length paths, or paths that must visit specified intermediate vertices. Loop erasure is valid here because the target is an upper bound on length and deletion is monotone.

This is an AI-assisted research draft, not an externally peer-reviewed paper or a generally Lean-certified theorem. The finite verification reported in the original manuscript (the program is not included in this version) is evidence about the implemented reduction and state semantics. It does not replace Lemma 2, establish its asymptotic construction by experiment, or prove global priority. In particular, enumerating all small separating colorings for a certificate must not be reported as an implementation of the efficient GLP construction.

Within the literature checked as of 24 November 2026, no later paper giving the same result was identified; this is not a global priority claim. The contribution is deliberately limited to the published question above; no new pseudorandom construction or universal derandomization principle is claimed.

## References

**[D]** Michal Dvořák, Dušan Knop, Michal Opler, Jan Pokorný, Ondřej Suchý, and Krisztina Szilágyi. *Pathfinding in Self-Deleting Graphs*. ISAAC 2025, LIPIcs 359, Article 28, 28:1-28:15. [DOI: 10.4230/LIPIcs.ISAAC.2025.28](https://doi.org/10.4230/LIPIcs.ISAAC.2025.28). The published §6 states the question. The [full version, arXiv:2507.12047v2](https://arxiv.org/html/2507.12047v2), dated 17 September 2025, gives the state-graph proof in Appendix C and the question in §7. The published article number is 28; the arXiv metadata's article number 19 and DOI ending in `.19` are not used as the publication identifier.

**[GLP]** Ariel Gabizon, Daniel Lokshtanov, and Michał Pilipczuk. *Fast Algorithms for Parameterized Problems with Relaxed Disjointness Constraints*. ESA 2015, LNCS 9294, 545-556. [DOI: 10.1007/978-3-662-48350-3_46](https://doi.org/10.1007/978-3-662-48350-3_46). The exact construction used here is [arXiv:1411.6756v5](https://arxiv.org/pdf/1411.6756v5), Definition 2.4, Theorem 3.1 and §4. The corresponding theorem in the [24-page author manuscript](https://sites.cs.ucsb.edu/~daniello/papers/multisetrep.pdf) is numbered Theorem 4.

**[BG]** Nader H. Bshouty and Ariel Gabizon. *Almost Optimal Cover-Free Families*. [arXiv:1507.07368v1](https://arxiv.org/pdf/1507.07368v1), dated 27 July 2015. Theorem 1 and Appendix B.1, especially Corollary 1, provide the stronger pre-existing family construction discussed after (17).
