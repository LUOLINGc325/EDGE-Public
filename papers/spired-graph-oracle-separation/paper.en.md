# Coherent recovery of hidden cubic graphs and an exponential oracle separation

**AI-assisted research manuscript. Version 2, 25 November 2026. Full Lean verification is unfinished.**

## Abstract

Wocjan's spired-graph oracle hides a regular base graph below exponentially large trees and leaf connections. We give a uniform quantum algorithm that reconstructs every finite simple connected cubic base of known order $n$ on its actual apex labels, from one seed, for every allowed weld realization and every even $r=L+1\ge4$. For rational $0<\delta<1/4$, it uses $O(n^2r^4\delta^{-1}\log^4(nr/\delta))$ queries and polynomially many finite gates, with failure probability at most $\delta$. The key is a stable central Jacobi branch and coherent entrance-weight correction: compression of a computable spectral function onto the degree-marked apex space implements $h(A_G)/(2r)$. Choosing $h(\mu)=\mu/3$ gives a uniform actual hidden-base neighbour in the ideal heralded branch. The finite implementation approximates this conditional distribution with a controlled error, permitting complete adaptive reconstruction without a spectral distinction between candidates. On the classical side, conditioned Hamiltonian-cycle switching and a common transcript coupling bound every randomized adaptive algorithm's advantage by $32(D+1)^2t^2/D^L$ for arbitrary same-order, same-degree regular bases. This proves the source's classical Conjecture 11.1. A separate faster quantum witness algorithm distinguishes odd prisms and Mobius ladders at $L=2m-1$ using $O(m^5\log m)$ queries, compared with the classical $\Omega(6^{m-1/2})$ lower bound. All quantum error and postselection budgets are finite and include gate synthesis. The results concern the specified reversible neighbour-set oracle; the sharper single-time return-amplitude conjecture and an unrelativized complexity separation are not claimed.

## 1. Problem, contributions, and prior work

We study a finite hidden-base-graph oracle introduced by Wocjan [W26]. Each vertex of a regular base is replaced by a large leaf cluster; independently sampled regular bipartite connections join clusters corresponding to base edges; complete rooted trees cover the clusters; and a uniformly random injection replaces all vertex names. The algorithm receives one tree apex and can request all neighbours of any chosen name. The complete source distribution uses a single alternating Hamiltonian cycle on each pair of adjacent clusters when the thickening parameter is two.

Our frozen target retains every quantifier of [W26, Conjecture 11.1]: all odd $m\ge5$, every height $L\ge1$, arbitrary randomized adaptive classical algorithms, and arbitrary queries including guesses of previously unseen names. In addition, at $L=2m-1$ we require a uniform polynomial-query quantum algorithm in precisely the same oracle model. The resulting separation is unconditional within that model. Its quantum upper bound is deliberately a different algorithmic claim from [W26, Conjecture 10.1].

The mathematical contributions are a uniform classical theorem for any same-order, same-degree pair of simple regular bases; a quantitative stable central spectral branch; a finite-error implementation from the actual graph oracle; and a general local spectral readout theorem. The arbitrary-base classical statement and the local spectral sampler give reusable forms of the two arguments. The quantum statements hold for every allowed weld and labelling realization. The classical theorem bounds the distribution over independently sampled welds and labels.

The closest classical predecessor must be distinguished carefully. Ben-David, Childs, Gilyén, Kretschmer, Podder, and Wang [BD24, §§6.3.2–6.3.3] already prove $O(t^2 2^{-k})$ bounds for binary welded and self-welded trees, and already use a common simulator for identification and graph-property testing. The birthday order, the last-weld decomposition, and the concept of an oracle separation are established prior work. Our proof supplies the exact multi-spire conditional-exposure argument and the corresponding arbitrary-base statement. Balasubramanian, Li, and Harrow [BLH25, §5] give broad hierarchical-graph indistinguishability results; their small/large-layer parameters do not directly yield the precise $t^2/D^L$ bound required here. The original welded-tree separation is due to Childs et al. [C03].

On the quantum side, [W26] already supplies the level-state quotient, Jacobi matrices, Chebyshev equation, and entrance spectral weights. We prove uniform quantitative separation and weight bounds on a central branch and supply a different algorithm whose full query budget is justified. Reflection walks [S04], phase estimation [CEMM98], and finite-gate compilation [DN06] remain established ingredients. We explicitly derive their needed spectral and error identities to expose the oracle assumptions. We use only invariance of the level-state space; it need not equal the cyclic Krylov space generated by one apex.

### Main separation theorem

Let $Y_m$ be the prism $C_m\square K_2$, and let $M_m$ be the cycle $C_{2m}$ with its antipodal matching. In Wocjan's six-ary, single-apex, randomly labelled spired oracle, for every odd $m\ge5$ and every $L\ge1$, a classical $t$-query algorithm has

$$
\operatorname{Adv}\le1568\,t^2/6^L.
$$

For $L=2m-1$, a uniform quantum algorithm succeeds with probability at least $2/3$ on every realization, using $O(m^5\log m)$ oracle queries and $O(m^6(\log m)^5)$ nonoracle gates over an explicitly fixed inverse-closed Clifford+$T$ set. In particular, success $2/3$ classically requires

$$
t\ge\sqrt{6^L/9408},
$$

which is exponential in $m$ under the specified height. No claim is made that the polynomial exponent or the absolute constant is optimal.

The proof is organized into a classical part (C1–C6) and a quantum part (Q0–Q6). All probability and algorithmic statements are finite. Numerical experiments are diagnostics only. Kernel verification and actual academic-value assessment are reported separately from the mathematical claims.


### Second-round coherent reconstruction

The first-round local spectral sampler was completed before the separate actual-value review required one secondary research round. Part R is the substantive extension: it preserves off-diagonal matrix elements on the entire apex space and retrieves actual new apex labels. It proves full connected cubic-base reconstruction with $O(n^2r^4\delta^{-1}\log^4(nr/\delta))$ queries and finite polynomial gate cost, without a spectral-gap or local-spectrum distinction between candidates.

This addresses the exit-finding direction raised in [W26, §12] within the connected cubic and even-$r$ scope. Deterministic coined-walk welded-tree traversal [LLL24], the author's later seminar [WS26], and graph learning in different input models [MS22] remain credited. Optional polynomial-time isomorphism comparison after reconstruction uses Luks [L82], not a new isomorphism theorem.

All probability and algorithmic claims have written proofs and internal independent review. Numerical diagnostics and the small compiled Lean auxiliary group do not constitute full-paper formalization. The verification record reports the exact compiled scope and document checks. This research manuscript has not undergone external peer review.

# Uniform classical indistinguishability

This chapter gives the internally reviewed written proof of the classical bound. Full Lean verification is incomplete. The model retains one uniformly sampled **single alternating Hamiltonian cycle** on every base edge. The sharp binary welded-tree exponent, last-weld analysis and common-simulator method are credited to Ben-David et al., SIAM J. Comput. (2024), §§6.3.2–6.3.3, DOI 10.1137/23M1573975. The theorem below handles an arbitrary network of independent cycle types without revealing those types to the algorithm.

## 1. Model and finite theorem

Let $G$ be a finite simple $d$-regular base graph with $n$ vertices and a distinguished vertex $u$, where $d\ge1$. Set $D=2d$ and $N=D^L$, with $L\ge1$. At each base vertex attach a complete rooted $D$-ary tree of depth $L$. For every base edge independently choose a uniform undirected alternating Hamiltonian cycle between the $N$ leaves of its two endpoint trees. All nonapex vertices then have degree $D+1$, and every apex has degree $D$. The number of vertices is $M=n(D^{L+1}-1)/(D-1)$. Labels are a uniform injection into a fixed universe $X$ of size $Q\ge M^2$. The oracle returns the entire unordered neighbour-label set, or an invalid symbol on unused labels. The algorithm initially has one apex label; it can query any label, use arbitrary computation, and adapt or randomize freely.

**Theorem C.** For any two such base graphs of the same $n,d,L$ and any roots, any classical algorithm using at most $t$ queries, with a fair prior on the two graphs, satisfies

\[
\operatorname{Adv}\le C_D\frac{t^2}{N},\qquad C_D=32(D+1)^2.
\]

The statement includes $t=0$ and unqueried-label guesses. For $d=3$ it proves Wocjan Conjecture 11.1 with $C=1568$, for all the stated odd $m$ and every $L$. In fact neither prism structure, root symmetry nor oddness is needed for this classical theorem. No matching upper bound or unconditional quantum conclusion follows from this part alone.

## 2. A switching bound for an incompletely exposed Hamiltonian cycle

Let A,B be two fixed disjoint sets of size N. Let H be an exposed edge set contained in at least one alternating Hamiltonian cycle on A union B, with at most s edges. Conditional on H, the full cycle C is uniform among its Hamiltonian completions. Let x belong to A. A new requested cycle neighbour of x means a neighbour along an edge not already in H; if no such edge exists the request is void. For any $F\subseteq B$, its landing probability obeys

\[
\Pr(\text{requested neighbour}\in F\mid H)\le\frac{4|F|}{N-s-2}.\tag{C.1}
\]

provided the denominator is positive. The choice of one of the free neighbours may be uniform, or any rule whose success is contained in the event that a free neighbour belongs to F. This upper bound needs no uniformity assumption about vertices already exposed through **other** cycle types.

### Switching proof

Write $\Omega(H)$ for the finite set of completions. Let $\Omega_F$ be those completions with at least one edge xy not in H and y in F; choose one such y by a fixed deterministic rule. For each C in $\Omega_F$, choose any z in B that is untouched by H and is not a neighbour of x in C. There are at least $N-s-2$ such choices, since at most s vertices of B are touched by H.

Delete xy from C and view the result as a Hamiltonian path from x to y. The vertex z is internal. Let w be the neighbour of z on this path toward x. Replace xy and wz by xz and wy. The result C' is a **single** alternating Hamiltonian cycle: the two subpaths separated by wz are reconnected crosswise into one cycle. All four vertices are distinct. The new edges did not already belong to C, and neither removed edge belongs to H: this is stipulated for xy, and z was untouched by H. Consequently C' belongs to $\Omega(H)$.

For a fixed C' and a fixed y in F, there are at most four possible inverse records: z must be one of the at most two neighbours of x in C', and w one of the at most two neighbours of y in C'. The deleted/added edges then recover C uniquely. Thus

\[
|\Omega_F|(N-s-2)\le4|F|\,|\Omega(H)|.
\]

Division gives (C.1). If F is empty the conclusion is immediate. The argument permits H to have paths of all lengths, vertices exposed in other cycles, and edges already incident to x; it uses no independent-matching approximation.

## 3. The exact leaf profile of a regular tree

Fix a vertex b in a complete D-ary tree of height L, at height $h=L-\operatorname{depth}(b)$ above the leaves. Let $A_\ell(b)$ be the leaves at tree distance l from b. A leaf-to-b nonbacktracking path in the tree is unique whenever it exists. Such leaves exist only for $\ell=h+2j$, $j\ge0$. Their counts are

\[
\begin{aligned}
|A_h(b)|&=D^h,\\
|A_{h+2j}(b)|&=(D-1)D^{h+j-1}&&\text{for }1\le j\le\operatorname{depth}(b),\\
|A_\ell(b)|&=0&&\text{otherwise}.
\end{aligned}\tag{C.2}
\]

For $j\ge1$, the path rises $j$ levels above $b$, takes one of the $D-1$ branches other than the branch containing $b$, and descends to a leaf. This proves the count directly, including the root and leaf cases. In particular

\[
\begin{aligned}
\sum_{\ell\ge0}|A_\ell(b)|D^{-\ell}
&=1+\sum_{j=1}^{\operatorname{depth}(b)}(D-1)D^{-j-1}\\
&\le1+\frac1D\le2.
\end{aligned}\tag{C.3}
\]

The weaker bound $|A_\ell(b)|\le D^{(h+\ell)/2}$ and the resulting geometric-sum bound $D/(D-1)\le2$ would suffice as well. The exact expression (C.3) is useful for independently checking the constants.

## 4. A fixed exploration-tree lemma

Let T be a fixed finite rooted tree with at most D forward children at each vertex, K vertices in all. Map its root to the supplied apex. At the root assign its children uniformly without replacement to graph neighbours; at every later fresh nonapex vertex, assign its children uniformly without replacement to the D neighbours other than the edge just used. Stop at a repeated image (collision) or a nonseed apex. Assignments at fresh vertices are independent conditional on the graph. This is a stopped random nonbacktracking embedding, not an embedding conditioned globally to be injective.

**Lemma C.4.** If $N>2K+2$, then

\[
\Pr(\text{collision or nonseed apex})\le\frac{8K^2}{N-2K-2}+\frac KN.\tag{C.4}
\]

### Collision witnesses and exposure order

If the embedding has a collision, choose a minimal rooted subtree witnessing a repeated image. It is the union of two root paths $P_a$ and $P_b$, with their endpoints having the same image and no other repetition on that union. One endpoint may be an ancestor of the other. The closed portion cannot lie solely within a single spire tree; it contains a weld edge. By ordering the pair (a,b) appropriately, some edge of the unshared tail $P_a\setminus P_b$ is a weld edge.

For each possible ordered pair, expose $P_b$ first and then the unshared tail of $P_a$. This is a marginal of the random embedding of T: at the branching vertex the two selected children are distinct uniform choices, and at later fresh vertices each chosen forward neighbour is uniform among D possibilities. No other branches of T are conditioned upon. Stop if another coincidence or another apex occurs, since then this pair is not the minimal witness being counted.

Conditional on any concrete history of these two paths, the unexplored cycle of each base-edge type is uniform among its Hamiltonian completions containing the exposed edges of that type. To see this, every concrete allowed port choice on the paths has probability 1/D, except a single possible branching choice with denominator D-1 and the root choices. These factors do not depend on the unseen cycle completion. The visited coordinates, whether they are tree or leaf vertices, and the fact that the listed coordinates have not repeated impose no further constraint on untraversed weld edges. Conditioning on the chosen cycle type is solely an analysis step; the algorithm receives no type information. At the next slot, the probability of choosing that type depends only on its remaining incidences and the already used slots, so this conditioning adds no completion-dependent weight. There are fewer than $2K$ exposed weld edges in any one cycle type. In particular a cycle edge that is new for this two-path history is not required to end at a vertex globally unseen through other types.

### Last weld and the tree-only suffix

Fix the image of b at height h in its spire. Partition the event for this ordered pair by l, the number of edges after the last weld on $P_a$'s unshared tail. The position of that last weld is fixed by l; there is no additional summation over positions for a given l.

Conditional on the history just before that edge and on its cycle type, the edge is still unexposed. If it had already been traversed on $P_b$ or the prefix, its source would have repeated earlier, or it would be the already chosen sibling edge at the branching vertex, both excluded by the minimal-witness event. If the destination cluster is not the spire containing b, the event has probability zero. Otherwise its destination must be in $A_\ell(b)$. By (C.1), its conditional probability of landing in that set is at most $4|A_\ell(b)|/(N-2K-2)$.

From a selected destination leaf, the tree-only suffix to b is unique. Before its last vertex it has no repeated image or new apex, so each required forward step has probability 1/D. Its conditional probability is at most $D^{-\ell}$. This remains an upper bound when other vertices on the suffix would violate the minimal-witness conditions. For $\ell=0$ the factor is 1. Therefore this ordered pair has probability at most

\[
\frac4{N-2K-2}\sum_{\ell\ge0}|A_\ell(b)|D^{-\ell}\le\frac8{N-2K-2}.
\]

Average over the exposed history of $P_b$ and sum over at most $K^2$ ordered pairs. This gives the first term of (C.4). The order of exposure is only for the probability proof; it does not assume that the algorithm actually queried in this order.

### New apices

For a given vertex a of T, a path from the seed to a nonseed apex must have a last weld, and the subsequent tree-only nonbacktracking segment has exactly L edges. Its position on $P_a$ is determined by the length of $P_a$; it cannot have a longer simple tree-only suffix starting at a leaf and ending at its own root. Conditional on everything before this suffix, its L upward choices have probability $D^{-L}=1/N$. The destination spire can be arbitrary; there is no union bound over base vertices. Summing over the K candidate endpoints gives $K/N$. Reaching the seed apex again is a collision and has already been counted.

## 5. Adaptive labels and arbitrary name guesses

Construct the following finite portion of a universal labelled-tree simulator only in the nontrivial query regime specified in Section 6. Outside that regime the trivial advantage bound suffices, so no finite-label reservoir is required to support an arbitrarily large abstract tree. Consider the simulator in that nontrivial regime. The initial seed is uniform in X. A query to the seed returns D fresh labels. A query to a discovered nonseed vertex returns its known parent and D fresh labels. The labels are sampled without replacement, excluding earlier labels declared invalid. A query to any previously unseen label returns bottom and excludes that label from future sampling; repeated queries have their remembered answers.

The simulator exposes at most $K=1+Dt$ vertices in t queries. Fix the algorithm's private random tape and all fresh labels sampled by the simulator. Its sequence of explored vertices and its rooted abstract exploration tree T are now fixed, independently of the base graph and weld cycles. This step allows arbitrary numeric comparison of labels and arbitrary adaptivity. The graph embedding is obtained by assigning each newly returned fresh label to a uniformly chosen unused neighbour, independently of the fresh numeric values. Until a collision or nonseed apex, this is exactly the stopped random embedding in Section 4, and it gives the uniform-injection real-oracle law by deferred assignment of labels.

An off-tree query may instead accidentally name an unexposed real vertex. Conditional on any nonfailed history, all remaining labels in the injection are exchangeable. If k graph vertices and b invalid labels have been exposed, the chance for a new guessed name is

\[
\frac{M-k}{Q-k-b}\le\frac M{Q-K-t}.
\]

If $K+t\le Q/2$, the sum over at most t guesses is at most $2tM/Q\le2t/M$. A failed guess removes its name from the reservoir in both experiments. Thus coupling these guesses does not alter the uniform fresh-label construction or reveal a graph-dependent probability before failure. The graph size M is common to both hypotheses.

Consequently, for each base graph G, total variation between the real t-query transcript and the common simulator transcript is at most

\[
\frac{8K^2}{N-2K-2}+\frac KN+\frac{2t}{M}.\tag{C.5}
\]

whenever the displayed denominators and reservoir condition hold. The entire algorithm output can be included in the transcript; data processing cannot increase the distance. Randomized algorithms follow by averaging over their tapes. This proof makes no assumption that the algorithm only traverses previously seen labels.

## 6. Uniform constants and the original conjecture

When $t=0$, only a uniform seed label is observed, so the advantage is zero. Let $t\ge1$ and $C_D=32(D+1)^2$. If $C_Dt^2/N\ge1/2$, the target bound follows from the trivial maximal advantage 1/2. In the other regime,

\[
N>64(D+1)^2t^2,\qquad K=1+Dt\le(D+1)t.
\]

In particular $N-2K-2\ge N/2$ and $K+t\le Q/2$, so (C.5) is at most

\[
\left[16(D+1)^2+(D+1)+2\right]\frac{t^2}{N}\le C_D\frac{t^2}{N}.
\]

For two hypotheses, the triangle inequality gives transcript TV at most twice this bound. Success over a fair prior is at most $(1+\operatorname{TV})/2$, so the advantage is at most $C_Dt^2/N$. This proves Theorem C. The written exposure argument has been reviewed independently; full Lean verification remains incomplete.

For Wocjan's $d=3$, $D=6$, the absolute constant is $C_6=1568$. Success at least 2/3 requires $t\ge\sqrt{6^L/9408}$. For $L=2m-1$ this is an exponential lower bound in m. The seed's location and the prism/Mobius twist play no role in this classical proof, so all source quantifiers are retained and the classical statement is strengthened.

## 7. Scope and attribution

The theorem is a distributional result for random cycle completions and random injective labels. It does not assert a lower bound for every fixed weld realization, and it does not imply an unrelativized complexity separation. The quantum component must be combined with this chapter before claiming the joint oracle separation.

The full written argument has passed internal independent review, including the switching inverse count, cycle-type conditioning, pair-path marginalization, complete-neighbor replies, failed label guesses, and the new-apex suffix. An independently developed exact alternating-cycle completion formula is included below and provides a second check of the conditional probability mechanism. Neither this review nor the auxiliary finite-word Lean lemmas constitute full formal verification. A Lean declaration that assumes the exploration lemma or simulator coupling would not formalize this theorem in full.

The source model and conjecture are in Wocjan, [arXiv:2605.11228v1](https://arxiv.org/html/2605.11228v1). The strong prior sharp collision and simulator argument is Ben-David et al., [SIAM J. Comput. 53(6), 2024](https://epubs.siam.org/doi/10.1137/23M1573975), §§6.3.2–6.3.3. The broader fake-oracle framework for random hierarchical graphs is Balasubramanian–Li–Harrow, [Commun. Math. Phys. 406,209 (2025)](https://link.springer.com/article/10.1007/s00220-025-05370-x), Theorem 5.4. These existing mechanisms are not claimed as newly invented here.

## Appendix A. An independent exact count for conditional cycle completions

This appendix gives the independent counting argument that corroborates the switching lemma. The main theorem above does not rely on this appendix. It does not introduce a second, stronger main-theorem constant.

### A.1. Directed representation and path types

Take disjoint labeled sets $A$ and $B$, both of size $N$. Sample a uniformly random alternating Hamilton cycle and then choose one of its two orientations uniformly. The resulting directed alternating Hamilton cycle is uniform among $N!(N-1)!$ possibilities.

Suppose a set $F$ of $s$ directed edges has been revealed, and $F$ is a union of vertex-disjoint directed paths. Include isolated vertices as paths of length zero. Classify the path components by the parts containing their initial and terminal vertices. Write $h$ for the number of $AA$ components, also $h$ for the number of $BB$ components, $p$ for the number of $AB$ components, and $q$ for the number of $BA$ components.

The $AA$ and $BB$ counts agree because the total numbers of $A$ and $B$ vertices agree. If $s<N$, then
\[
2h+p+q=2N-s,\qquad p+q\le s,
\]
so $h\ge N-s>0$.

### A.2. Exact number of completions

The number of directed alternating Hamilton cycles containing $F$ is
\[
Z(F)=h(h+p-1)!(h+q-1)!.
\tag{A.1}
\]

To prove this, contract each directed path to a block. In a completed cycle, the $AA$ blocks and $BB$ blocks alternate after $AB$ and $BA$ blocks are omitted. There are $h!(h-1)!$ cyclic alternating orders of these labeled $AA$ and $BB$ blocks.

The $p$ labeled $AB$ blocks can be distributed, in arbitrary order, among the $h$ gaps from a $BB$ block to the next $AA$ block. There are
\[
p!\binom{p+h-1}{h-1}=\frac{(p+h-1)!}{(h-1)!}
\]
ways. Independently, the $q$ labeled $BA$ blocks are distributed among the $h$ remaining gaps, with $(q+h-1)!/(h-1)!$ possibilities. Multiplication gives (A.1). Every completion has exactly one such decomposition.

### A.3. Conditional endpoint mass

Conditional on $F$, any specified admissible unrevealed directed edge has probability at most
\[
\frac1h\le\frac1{N-s}.
\tag{A.2}
\]
The edge must leave the terminal vertex of a component and enter the initial vertex of a different component.

It is enough to consider an edge from $A$ to $B$; interchange the two parts for the other direction. A source component ending in $A$ has type $AA$ or $BA$. A target component starting in $B$ has type $BB$ or $BA$.

If an $AA$ component is joined to a $BB$ component, the new counts are $(h-1,p+1,q)$. For $h\ge2$, the ratio of completion counts is
\[
\frac{Z(F+e)}{Z(F)}
=\frac{h-1}{h(h+q-1)}
\le\frac1h.
\]
In all other possible cases, $h$ and $p$ stay fixed and $q$ decreases by one. Such a case requires $q\ge1$, and the ratio is
\[
\frac1{h+q-1}\le\frac1h.
\]
An edge closing a proper component into a cycle is inadmissible and has probability zero. If $h=1$, the bound $1/h$ is trivial, so no formula with $h-1=0$ is needed.

For an undirected revealed history, introduce the uniformly random orientation of the entire cycle as extra information for the analyst, and condition on the directions induced on the revealed paths. Given each resulting directed forest, (A.2) applies. If the source has one unrevealed cycle incidence, its endpoint obeys (A.2). If it has two, a uniformly selected incidence has an endpoint law that is the average of an incoming and an outgoing law, and obeys the same bound. Averaging over the latent orientations preserves the bound.

This does not orient the path components independently. Their joint conditional orientation law is the one induced by the uniformly oriented complete cycle. The bound is uniform over all feasible directed forests, so its mixing weights are immaterial.

Revealing edges of other independent base-edge cycles can identify a candidate endpoint without revealing an edge of the current cycle. Such an endpoint is still covered. If it also has previously revealed incidences of the current cycle, it is an endpoint of a current path component, and the same completion count covers that case. The endpoint need not be an untouched leaf.

### A.4. Exact finite checks

The independent verification program enumerated every directed alternating Hamilton cycle for $N=2,3,4,5$ and every contained directed path forest with at most $\min(N-1,3)$ edges. It compared the actual completion count with (A.1), and every possible one-edge extension probability with $1/(N-s)$, using integers and rational arithmetic.

| $N$ | Maximum exposed edges | Distinct feasible forests | Result |
|---:|---:|---:|---|
| 2 | 1 | 9 | All exact counts and bounds passed |
| 3 | 2 | 127 | All exact counts and bounds passed |
| 4 | 3 | 2,625 | All exact counts and bounds passed |
| 5 | 3 | 11,451 | All exact counts and bounds passed |

The program is verification/independent_cycle_completion_check.py. These checks validate finite combinatorial cases only. They do not replace the general proof or constitute formal verification of the transcript theorem.

# Quantum component: stable central-band readout and polynomial identification

Status: internally reviewed analytic proof. Full-paper Lean verification remains unfinished. This typeset version preserves the mathematical content and all displayed equations of quantum-derivation.md (source SHA-256: c178bbe56f2e024ffadaf6bdeeb9281f182a6c9990d25ff7192e592304a70b6a). The classical indistinguishability proof is separate and was not used in this derivation.

## Q0. Model, normalizations and the conclusion

Let $G$ be a finite simple cubic graph with $n$ vertices and distinguished vertex $u$. Attach a complete six-ary tree of height $L$ to each base vertex, and join the leaves over adjacent base vertices by a two-regular bipartite graph. Each weld may in particular be a single alternating Hamiltonian cycle, as required by the research target. All statements in this quantum component hold for every realization of these welds and every injective labelling; they do not require averaging over the graph distribution.

Use the Hamiltonian $H=A_{\mathrm{spire}}/2$. Write

\[
r=L+1,\qquad \gamma=\sqrt6/2,\qquad \gamma^2=3/2.
\]

For the gate bound in the research target, labels have $a=2\lceil\log_2|V_{\mathrm{spire}}|\rceil$ bits, hence $a=O(L+\log n)$. The query statements also hold for longer labels, with the gate bounds retaining their explicit dependence on $a$.

The main theorem proved below is the following.

**Quantum identification theorem.** For every odd $m\ge5$, let $n=2m$ and $L=2m-1$, so $r=2m$. A uniform quantum algorithm supplied with the one seed-apex label and coherent full-neighbor-set access distinguishes the odd prism $Y_m$ from the Möbius ladder $M_m$ with success at least $2/3$ on every allowed weld and labelling realization. Its query complexity is $O(m^5\log m)$. Over the inverse-closed universal gate set generated by $H$, $T$, $T^\dagger$ and CNOT, its nonoracle gate complexity is $O(m^6(\log m)^5)$; weakening this to $O(m^8)$ is an explicit fixed-polynomial bound if one wishes to avoid displaying logarithmic factors. The algorithm does not assume the single-time return-amplitude conjecture in Wocjan's paper.

For this theorem, standard coherent access means reversible function evaluation $O_F|x,z\rangle=|x,z\mathbin{\mathrm{XOR}}F(x)\rangle$, where $F(x)$ is a fixed-length canonical encoding of the unordered neighbor set, with a distinct invalid-label response. This evaluation oracle is its own inverse. Equivalently, a reversible response-computation unitary and its inverse may each be charged one query. A promise of access only to the forward direction of an arbitrary unknown state-preparation unitary would be a different access model and is not used here. Sorting the at most seven labels costs $O(a)$ elementary reversible gates when labels have $a$ bits. A raw deterministic ordering can instead be sorted reversibly before use. No ordering correlated with hidden vertex coordinates is assumed or supplied. Controlled use of an unknown oracle is not required: controlled reflections are implemented by unconditional unpreparation, a controlled known reflection, and preparation.

## Q1. The exact invariant quotient

For each $v\in V(G)$ and level $\ell\in\{0,\ldots,L\}$, let $|v,\ell\rangle$ be the normalized uniform superposition of the $6^\ell$ labelled vertices at that level of the spire over $v$. These vectors are orthonormal. The subspace $K$ that they span has dimension $nr$ and is invariant under $H$:

\[
H|v,\ell\rangle=
\gamma|v,\ell-1\rangle+\gamma|v,\ell+1\rangle
\quad(0\le\ell<L),
\]

with the absent level -1 term omitted, and

\[
H|v,L\rangle=\gamma|v,L-1\rangle+
\sum_{w\sim_Gv}|w,L\rangle.
\]

Indeed, each tree child has one parent, each parent has six children, and the normalization yields $\sqrt6/2$ on a tree edge. Every leaf has exactly two neighbors in each adjacent base spire, yielding coefficient $2/2=1$ on the leaf-level quotient. These identities are deterministic and hold for each weld realization.

The seed apex is $|u,0\rangle$, so its evolution and spectral measure are confined to $K$. We do not identify $K$ with the full Krylov subspace: the latter can be strictly smaller.

If $A_G$ has spectral decomposition with eigenvalues $\mu$ and projections $P_\mu$, define its local spectral measure at $u$ by

\[
\nu_{G,u}(\mu)=\langle u,P_\mu u\rangle.
\]

It is a probability measure supported in $[-3,3]$. Restricting $H$ to a base eigenspace gives the real symmetric Jacobi matrix

\[
J_r(\mu)=
\begin{pmatrix}
0&\gamma&&&\\
\gamma&0&\gamma&&\\
&\ddots&\ddots&\ddots&\\
&&\gamma&0&\gamma\\
&&&\gamma&\mu
\end{pmatrix}.
\]

Consequently, the spectral measure of $H$ at the seed is the mixture, with weights $\nu_{G,u}(\mu)$, of the spectral measures of $J_r(\mu)$ at its first coordinate. The bound $|\mu|\le3$ follows, for example, by applying the eigenvalue equation at a largest absolute coordinate of a nonzero eigenvector.

## Q2. One branch has uniformly usable weight and sensitivity

Assume throughout this section that $r$ is even and $r\ge4$. Set

\[
\rho_r=2\gamma\sin(\pi/r),\qquad I_r=(0,\rho_r).
\]

**Central-branch lemma.** For every $\mu$ in $[-3,3]$, $J_r(\mu)$ has exactly one eigenvalue $f_r(\mu)$ in $I_r$. The function $f_r$ is continuously differentiable and strictly increasing. Let $w_r(\mu)$ denote the squared first coordinate of its unit eigenvector. Then

\[
\frac1{2r}\le w_r(\mu)\le\frac4r,
\qquad
\frac1{33r}\le f_r'(\mu)\le\frac4r,
\tag{Q2.1}
\]

and its distance from both endpoints of $I_r$ is at least $1/(10r)$. All other eigenvalues of $J_r(\mu)$ lie outside $I_r$.

### Q2.1. Existence, uniqueness, and differentiation

Delete the final coordinate of $J_r(\mu)$. The resulting matrix $B$ is the Dirichlet path of length $r-1$ with offdiagonal $\gamma$. Its eigenvalues are

\[
2\gamma\cos(k\pi/r),\quad 1\le k\le r-1,
\]

as follows by substituting the sine eigenvectors. All eigenvectors have nonzero last coordinate. Since $r$ is even, 0 and $\rho_r$ are consecutive eigenvalues of $B$.

For $\lambda$ in $I_r$, let $e$ be the last coordinate vector in $\mathbb R^{r-1}$, and define

\[
g_r(\lambda)=\lambda-
\gamma^2 e^T(\lambda I-B)^{-1}e.
\tag{Q2.2}
\]

The Schur complement says that $\lambda$ is an eigenvalue of $J_r(\mu)$ precisely when $g_r(\lambda)=\mu$. The derivative is

\[
g_r'(\lambda)=1+
\gamma^2 e^T(\lambda I-B)^{-2}e>0.
\tag{Q2.3}
\]

At the left endpoint 0 the right-hand limit of $g_r$ is minus infinity; at the right endpoint $\rho_r$ the left-hand limit is plus infinity. This follows from the positive, nonzero residues in the spectral expansion of the resolvent. Thus $g_r$ maps $I_r$ bijectively onto $R$, and $f_r$ is its inverse.

The eigenvector with final coordinate one is

\[
z=(\gamma(\lambda I-B)^{-1}e,1).
\]

Equation (Q2.3) gives $g_r'(\lambda)=\|z\|^2$. Therefore

\[
f_r'(\mu)=\frac1{\|z\|^2},
\tag{Q2.4}
\]

the squared final coordinate of the normalized eigenvector. This is a direct Schur-complement derivation, so no unproved parameter-eigenvector regularity assumption is needed. Uniqueness of the zero of the Schur complement also proves the assertion about all other eigenvalues.

### Q2.2. Elementary sine estimates

Write $\lambda=2\gamma\cos\theta$. For $\lambda$ in $I_r$,

\[
\pi/2-\pi/r<\theta<\pi/2,
\quad\hbox{so}\quad \sin^2\theta\ge1/2.
\]

A nonzero eigenvector is

\[
v_k=\sin((k+1)\theta),\qquad 0\le k<r.
\tag{Q2.5}
\]

The sine addition identity proves every interior row. The last row is equivalent to

\[
\mu\sin(r\theta)=\gamma\sin((r+1)\theta),
\qquad
\frac\mu\gamma=\cos\theta+\sin\theta\cot(r\theta).
\tag{Q2.6}
\]

The denominator $\sin(r\theta)$ is nonzero because $\theta$ lies strictly between consecutive path poles. Using $|\mu|\le3$ and $\gamma\ge1$ gives

\[
\cot^2(r\theta)
=\frac{(\mu/\gamma-\cos\theta)^2}{\sin^2\theta}
\le\frac{4^2}{1/2}=32,
\]

and hence

\[
\sin^2(r\theta)\ge1/33.
\tag{Q2.7}
\]

Let $S(\theta)=\sum_{j=1}^r\sin^2(j\theta)$. Certainly $S\le r$. The finite trigonometric sum gives

\[
S(\theta)=\frac r2-
\frac{\sin(r\theta)\cos((r+1)\theta)}{2\sin\theta}.
\tag{Q2.8}
\]

The absolute value of the second term is at most $1/\sqrt2<1$. For $r\ge4$, this implies $S\ge r/2-1\ge r/4$. Now

\[
w_r(\mu)=\frac{\sin^2\theta}{S(\theta)},
\qquad
f_r'(\mu)=\frac{\sin^2(r\theta)}{S(\theta)},
\]

which proves (Q2.1).

Finally, $|\sin(r\theta)|\ge1/\sqrt{33}>1/6$. The sine function is 1-Lipschitz, and it vanishes at both endpoint angles of the central interval after multiplication by $r$. Thus $\theta$ is at distance more than $1/(6r)$ from both endpoint angles. Throughout that angle interval, the absolute derivative of $2\gamma\cos\theta$ is $2\gamma\sin\theta\ge\sqrt2>1$. Therefore $\lambda$ has distance more than $1/(6r)$, and in particular at least $1/(10r)$, from both endpoints of $I_r$. This proves the entire lemma.

### Q2.3. Explicit stability consequences

For $\mu_1\le\mu_2$ in $[-3,3]$, integration gives

\[
\frac{\mu_2-\mu_1}{33r}
\le f_r(\mu_2)-f_r(\mu_1)
\le\frac{4(\mu_2-\mu_1)}r.
\tag{Q2.9}
\]

In particular, $g_r$ restricted to $[f_r(-3),f_r(3)]$ is $33r$-Lipschitz.

The weight as a function of $\lambda$ is also stable. Differentiating (Q2.5)–(Q2.8), one has

\[
|S'(\theta)|\le\sum_{j=1}^r j
=r(r+1)/2\le r^2.
\]

Using $S\ge r/4$ and $|(\sin^2\theta)'|\le1$ shows

\[
\left|\frac{d}{d\theta}\frac{\sin^2\theta}{S(\theta)}\right|
\le 4/r+16\le17.
\]

Since $\left|d\theta/d\lambda\right|=(2\gamma\sin\theta)^{-1}\le1$, the $\lambda$-derivative of the weight is at most 17. Therefore the rejection probability

\[
a_r(\lambda)=\frac1{2r\,w_r(g_r(\lambda))}
\tag{Q2.10}
\]

lies in $[1/8,1]$ and is $34r$-Lipschitz on $[f_r(-3),f_r(3)]$.

## Q3. A separating eigenvalue with polynomial mass

For the odd prism, $Y_m=C_m\square K_2$. Fourier vectors for $C_m$ and the two eigenvectors of $K_2$ give the spectrum

\[
2\cos(2\pi k/m)+s,
\qquad 0\le k<m,\quad s\in\{-1,1\}.
\]

Since $m$ is odd,

\[
\min\operatorname{spec}(A_{Y_m})
=-1-2\cos(\pi/m)=-3+\Delta_m,
\quad
\Delta_m=2(1-\cos(\pi/m))\ge4/m^2.
\tag{Q3.1}
\]

For the last inequality, use $1-\cos x=2\sin^2(x/2)$ and $\sin y\ge2y/\pi$ on $[0,\pi/2]$.

The Möbius ladder $M_m$ is the cycle $C_{2m}$ with the antipodal matching. When $m$ is odd, the parity coloring of the cycle makes all cycle and matching edges cross the bipartition. Thus the normalized alternating-sign vector, which has every coordinate of absolute value $1/\sqrt n$, has adjacency eigenvalue -3. Consequently,

\[
\nu_{M_m,u}(-3)\ge1/n
\tag{Q3.2}
\]

at every root $u$. Equality is true because the graph is connected, but the lower bound suffices and does not require simplicity of the base eigenvalue.

Put $\lambda_*=f_r(-3)$, $r=n=2m$, and

\[
d_m=\frac1{10rm^2},\qquad
\varepsilon_m=\frac1{100rm^2}=d_m/10.
\tag{Q3.3}
\]

The spectral measure of $H$ at the Möbius seed assigns probability at least

\[
p_*\ge\frac1{2nr}
\tag{Q3.4}
\]

to the eigenvalue $\lambda_*$, by (Q2.1) and (Q3.2). Every central-branch eigenvalue in the prism is at least

\[
f_r(-3+\Delta_m)
\ge\lambda_*+\frac{\Delta_m}{33r}
\ge\lambda_*+d_m.
\]

Every noncentral eigenvalue, for either base graph, lies outside $I_r$ and is at distance at least $1/(10r)\ge d_m$ from $\lambda_*$. Thus the entire spectral measure of the prism seed avoids the open $d_m$-neighborhood of $\lambda_*$. This excludes possible competing eigenbranches, including outliers.

### Q3.1. The threshold is uniformly computable

The number $\lambda_*$ is specified without access to the hidden graph. It can be computed to error $\varepsilon_m$ by rational bisection in polynomial time in $r$ and $\log(1/\varepsilon_m)$.

For an explicit implementation, form the Dirichlet characteristic polynomials

\[
p_0(x)=1,\quad p_1(x)=x,\quad
p_j(x)=x p_{j-1}(x)-(3/2)p_{j-2}(x).
\]

Then

\[
g_r(x)=x-(3/2)\,p_{r-2}(x)/p_{r-1}(x).
\tag{Q3.5}
\]

Approximate $\rho_r$ by a rational $\widetilde\rho_r$ with error at most $1/(1000r)$, using Taylor bounds for sine and rational square-root bisection. The rational endpoints

\[
\ell=1/(100r),\qquad
h=\widetilde\rho_r-1/(50r)
\]

lie strictly inside $I_r$, contain $\lambda_*$ between them by the endpoint-distance lemma, and satisfy $g_r(\ell)<-3<g_r(h)$. On this interval the denominator in (Q3.5) is nonzero. Evaluate $g_r$ exactly at rational midpoints, then bisect according to whether it is below or above -3. The number of bisections is $O(\log(r/\varepsilon_m))$, and each evaluation uses $O(r)$ rational operations with polynomially many bits. Store a rational approximation $\widetilde\lambda_*$ with absolute error at most $\varepsilon_m$.

## Q4. Exact quantum access to the seed spectral measure

This section gives the oracle-to-walk construction and its spectral proof, rather than assuming a Hamiltonian-simulation black box. It is a standard reflection-walk construction, with padding adapted to a full-set oracle and to the unequal degrees of the seed and internal vertices. Its general principle is due to the quantized-walk framework; it is not claimed as a newly invented quantum-walk method.

Extend the graph by zero adjacency on invalid $a$-bit labels. Every valid degree is at most seven. On the Hilbert space of two label registers and two flag qubits, define the isometry

\[
T|x\rangle=
\frac1{\sqrt8}\sum_{y\sim x}|x,y,0,0\rangle
\;+
\sqrt{1-\deg(x)/8}\,|x,x,0,1\rangle.
\tag{Q4.1}
\]

For an invalid label, the sum is empty and the padding amplitude is one. The first label register proves that the images of distinct basis states are orthogonal, and the displayed squared amplitudes sum to one. Let $S$ swap the two label registers and also swap the two flag qubits. Then $S$ is a Hermitian involution and

\[
T^*ST=A_{\rm spire}/8=H/4.
\tag{Q4.2}
\]

To verify this, valid-edge terms overlap exactly when two labels are adjacent, contributing $1/8$. The padding term has flag pair 01, while its swapped copy has 10, so padding contributes nothing, even on diagonal entries.

Define

\[
R=2TT^*-I,\qquad W=SR.
\tag{Q4.3}
\]

If $H\psi=\lambda\psi$ with $\|\psi\|=1$, put $a=\lambda/4$, $U=T\psi$ and $V=ST\psi$. Because $\|A_{\mathrm{spire}}\|\le7$, $|a|\le7/8<1$. One has

\[
\langle U,V\rangle=a,\quad
WU=V,\quad WV=2aV-U.
\]

With $Z=(V-aU)/\sqrt{1-a^2}$, the pair $U$,$Z$ is orthonormal and $W$ has the real rotation matrix

\[
\begin{pmatrix}a&-\sqrt{1-a^2}\\
\sqrt{1-a^2}&a\end{pmatrix}.
\tag{Q4.4}
\]

Its eigenphases are plus and minus $\arccos a$, and $U$ has squared overlap $1/2$ with each. Thus quantum phase estimation of $W$ from $T|\mathrm{seed}\rangle$ followed by the map $\omega\mapsto4\cos\omega$ samples, to the phase-estimation accuracy, the spectral measure of $H$ at the seed. No component outside the invariant quotient contributes, because the seed belongs to that invariant subspace.

### Q4.1. Oracle and gate costs

There is a unitary preparation $P$ with $P(|x\rangle\otimes|0\rangle)=T|x\rangle$ using two full-set oracle evaluations: compute the degree and at most seven neighbors, prepare a success/failure amplitude with squared success probability $\deg(x)/8$, prepare a uniform superposition over the $\deg(x)$ distinct neighbors on success, and use the list to erase its temporary index. On failure write the flagged padding state. Uncompute the oracle response. The finitely many degree-dependent rotations have constant dimension. Copying, comparisons, sorting, lookup, and unlookup over at most seven $a$-bit strings use $O(a)$ gates. The inverse preparation has the same cost.

The reflection $R=PR_0P^*$ uses four oracle calls, where $R_0$ reflects about the subspace with all ancillary registers zero. In chronological circuit order, a controlled $R$ is obtained by unpreparing with $P^*$, applying a controlled $R_0$, and preparing with $P$. These preparations remain unconditional, so a controlled unknown oracle is unnecessary. Controlled $S$ is a known register swap. Therefore a controlled $W$ uses four oracle calls and $O(a)$ gates, apart from fixed-dimensional rotations. Extra workspace is returned to zero after each operation. The initial $T|\mathrm{seed}\rangle$ costs two oracle evaluations.

## Q5. A completely specified estimator and decision rule

For clarity the phase-estimation guarantee is proved directly. In a standard $M$-point phase-estimation circuit, $M$ a power of two, an eigenvector with phase $2\pi\phi$ yields outcome $j$ with probability

\[
p_j=\left|\frac1M\sum_{s=0}^{M-1}
e^{2\pi i s(\phi-j/M)}\right|^2.
\tag{Q5.1}
\]

Let $d_j$ be the circular distance from $\phi$ to $j/M$. If $d_j>0$, the geometric sum and $\sin(\pi d_j)\ge2d_j$ give

\[
p_j\le\frac1{4M^2d_j^2}.
\]

The grid has at most two points at scaled distance in each unit interval. Consequently, for any $\eta$ with $M\eta\ge2$,

\[
\Pr(d_j>\eta)
\le\frac12\sum_{k=\lfloor M\eta\rfloor}^\infty k^{-2}
\le\frac1{2(\lfloor M\eta\rfloor-1)}.
\tag{Q5.2}
\]

Choose $\eta=\varepsilon_m/(16\pi)$, and choose the least power of two $M\ge1024\pi/\varepsilon_m$. Then $M\eta\ge64$, so the failure probability is below $1/16$. On the good event, the circular phase error is at most $\varepsilon_m/8$, and hence the real energy $4\cos(2\pi j/M)$ has error at most $\varepsilon_m/2$. Compute the energy expression $4\cos(2\pi j/M)$ to absolute error at most $\varepsilon_m/2$, equivalently computing the cosine to error at most $\varepsilon_m/8$. The resulting energy estimate has error at most $\varepsilon_m$.

To reach per-trial failure at most $\beta$, repeat this phase-estimation procedure $s$ times on the same walk target register, with fresh phase ancillas, and take the median of the real energy estimates. Conditional on a walk eigenphase, these outcomes are independent and identically distributed; their joint probabilities in a superposition are a mixture of those product distributions because all phase-estimation measurement operators are diagonal in $W$. If $s$ is odd, the probability of a bad median is at most

\[
\sum_{k\ge(s+1)/2}\binom{s}{k}(1/16)^k
\le 2^s(1/16)^{s/2}=2^{-s}.
\tag{Q5.3}
\]

Take $s$ to be the least odd integer at least $\log_2(1/\beta)$. A trial therefore costs at most $2+4s(M-1)$ oracle calls and returns an $\varepsilon_m$-accurate sample from the $H$ seed spectral measure except with probability $\beta$. This conclusion holds after mixing over all spectral components.

### Q5.1. The identification algorithm

Set

\[
R_{\rm trials}=8nr=32m^2,
\qquad \beta=1/(100R_{\rm trials}).
\]

1. Compute $\widetilde\lambda_*$ to error at most $\varepsilon_m$ by Q3.1.
2. In each of $R_{\mathrm{trials}}$ independent trials, prepare $T|\mathrm{seed}\rangle$, run the median phase estimator above, and obtain $E$.
3. Output Möbius if any trial satisfies $|E-\widetilde\lambda_*|\le3\varepsilon_m$. Otherwise output prism.

On a good estimate of the Möbius witness eigenvalue, the acceptance inequality holds because the total threshold and estimation error is at most $2\varepsilon_m$. On every good estimate from a prism spectral component, it fails: the true eigenvalue is at distance at least $10\varepsilon_m$ from $\lambda_*$, leaving distance at least $8\varepsilon_m$ after both errors.

For the prism, the false-positive probability is at most $R_{\mathrm{trials}}\beta=1/100$. For the Möbius ladder, the chance that none of the underlying spectral draws is the witness is at most

\[
(1-p_*)^{R_{\rm trials}}
\le\frac1{1+R_{\rm trials}p_*}
\le1/5.
\]

Here the first inequality follows from $(1-p)^{-R}\ge1+Rp$ for $p$ in $[0,1)$, and the endpoint $p=1$ is immediate. Adding the phase-estimation error gives total failure at most $1/5+1/100$. Allowing a further $1/100$ for finite-gate approximation still leaves success at least $39/50>2/3$ for both cases.

### Q5.2. Query and bit complexity

Since $\varepsilon_m^{-1}=100rm^2$, $M=O(rm^2)$, $s=O(\log(nr))$, and $R_{\mathrm{trials}}=8nr$, the query count is

\[
O(nr^2m^2\log(nr))=O(m^5\log m).
\tag{Q5.4}
\]

There are $a=O(L+\log n)=O(m)$ label bits. Each walk step uses $O(a)$ reversible Boolean gates and a constant number of constant-dimensional rotations. Phase-estimation Fourier transforms require $O((\log M)^2)$ additional rotations per experiment, so the ideal nonoracle elementary-gate count is $O(m^6\log m)$.

For the inverse-closed universal gate set generated by $H$, $T$, $T^\dagger$ and CNOT, compile every nonexact fixed-dimensional rotation to operator-norm error at most $1/(1000B)$, where $B$ is an explicit upper bound on the number of rotations in the entire circuit. A telescoping product estimate bounds the total state error by $1/1000$ and hence the variation in output probability by at most $1/100$ after increasing the denominator if necessary. The Solovay–Kitaev construction gives $O(\log^4B)$ gates per rotation (the usual exponent below four is enough), so $O(m^6(\log m)^5)$ gates suffice. All angles and thresholds are computable to $O(\log m)$ precision, with polynomial classical preprocessing. No exponentially sized graph data are prepared or stored.

## Q6. Reusable local spectral readout

The same central branch yields more than this one distinguishing witness. For any simple cubic base, any root, and even $r\ge4$, an ideal exact measurement of $H$ at the seed followed by the following operation returns a sample from the local base spectral measure:

- Reject outcomes outside $I_r$.
- For $\lambda$ in $I_r$, compute $\mu=g_r(\lambda)$.
- Accept with probability $a_r(\lambda)=1/(2r\,w_r(\mu))$, and output $\mu$ on acceptance.

For each base eigenvalue $\mu$, the unconditioned probability mass of its central-branch outcome is $\nu_{G,u}(\mu)w_r(\mu)$. After acceptance this becomes exactly $\nu_{G,u}(\mu)/(2r)$. Thus the total acceptance probability is $1/(2r)$, and the conditional output law is exactly $\nu_{G,u}$. This is an ideal spectral identity; the finite-precision version below avoids claiming total-variation approximation of irrational atoms by rounded numbers.

### Q6.1. Finite-precision version

Fix $0<\varepsilon\le1$ and $0<\delta<1/4$. Define

\[
K=\left\lceil2r\log(4/\delta)\right\rceil,
\quad
\eta=\min\left\{\frac1{100r},\frac\epsilon{100r},
\frac\delta{1000Kr}\right\},
\quad \beta=\delta/(100K).
\tag{Q6.1}
\]

Perform at most $K$ independent attempts. In an attempt estimate the $H$ energy to error $\eta$ with failure probability $\beta$ by Q5 (replace $\varepsilon_m$ by $\eta$). Use the following robust selection procedure.

Compute the deterministic endpoints $f_r(-3)$, $f_r(3)$, and $\rho_r$ to absolute error $\xi$, where $\xi\le\min(\eta,\delta/(1000Kr))$; they can be computed by the same monotone rational bisection as in Q3.1. For membership in the central band use the interval $[1/(20r),\widetilde\rho_r-1/(20r)]$. On a good energy estimate, the endpoint-distance lemma and $\eta\le1/(100r)$ ensure that precisely the central-branch outcomes pass this test. Clamp a retained estimate to the approximate interval $[\widetilde f_r(-3),\widetilde f_r(3)]$ and, if needed for evaluating the formulas, replace the endpoints by inward rational approximations so that the clamped point belongs to the true interval. Such inward endpoints within $2\xi$ exist by bisection. The interval remains nonempty: integrating $f_r'(\mu)\ge1/(33r)$ gives $f_r(3)-f_r(-3)\ge6/(33r)$, whereas the two inward displacements total at most $4\xi\le4/(100r)<6/(33r)$. The resulting clamped point differs from the true energy by at most $\eta+2\xi\le3\eta$.

Evaluate $g_r$ and $a_r$ at that point. Their exact rational evaluations use (Q3.5) and

\[
w_r(g_r(x))=
\left(\sum_{j=0}^{r-1}\frac{p_j(x)^2}{(3/2)^j}\right)^{-1}.
\tag{Q6.2}
\]

The inverse-map bound shows that the output differs from the corresponding exact base eigenvalue by at most $99r\eta$, which is at most $\varepsilon$ by (Q6.1).

The acceptance-probability error is at most $102r\eta$. Approximate its Bernoulli draw with a binary threshold using enough bits that its additional error is at most $\delta/(100K)$. Couple the exact and approximate accept/reject draws using the same uniform random variable. The probability of any disagreement over $K$ attempts is at most

\[
K\bigl(\beta+102r\eta+\delta/(100K)\bigr)
\le 0.122\,\delta.
\]

The ideal process fails to accept in $K$ attempts with probability at most $\exp(-K/(2r))\le\delta/4$. Allocate a further $\delta/4$ to all gate-approximation errors. Therefore the finite algorithm can be coupled to a random variable $\mu$ with law $\nu_{G,u}$ so that it returns a value $\widehat\mu$ satisfying $|\widehat\mu-\mu|\le\varepsilon$ except with probability less than $\delta$; the no-output event is included in that failure probability. The accepted ideal output has law $\nu_{G,u}$ even under the $K$-attempt cutoff, since every ideal attempt has the same success probability and the same conditional output law.

The query count is $O(K\eta^{-1}\log(K/\delta))$, polynomial in $r$, $1/\varepsilon$ and $1/\delta$. The gate count has the same factor times a polynomial in $a$ and the relevant bit precision. This gives a constructive stable local spectral sampler for the actual hidden-base oracle; its guarantee is a coupling in spectral location, not an invalid total-variation claim for rounded atoms.

## Q7. Attribution and limits

The deterministic level-state quotient and the basic Jacobi/ Chebyshev reduction are in Wocjan, arXiv:2605.11228v1, §§3,5–7. The present quantum increment is a uniformly separated central branch with polynomial seed mass, a robust readout/acceptance correction, and a proved polynomial-query distinguisher that supplies the previously conjectural quantum side without using the paper's specific single-time test. Reflection walks, phase estimation and finite-gate compilation are established tools; they are made explicit above so that the oracle model and error budget can be checked.

Primary references verified during derivation:

- Paweł Wocjan, *Quantum Algorithm for Identifying Hidden Graphs: Spectral Theory and Numerical Evidence*, arXiv:2605.11228v1: https://arxiv.org/html/2605.11228v1 .
- Mario Szegedy, *Spectra of Quantized Walks and a square-root-delta-epsilon rule*, arXiv:quant-ph/0401053: https://arxiv.org/abs/quant-ph/0401053 .
- Richard Cleve, Artur Ekert, Chiara Macchiavello and Michele Mosca, *Quantum Algorithms Revisited*, arXiv:quant-ph/9708016: https://arxiv.org/abs/quant-ph/9708016 .
- Christopher M. Dawson and Michael A. Nielsen, *The Solovay–Kitaev algorithm*, arXiv:quant-ph/0505030v2: https://arxiv.org/abs/quant-ph/0505030 .

This quantum theorem alone does not establish the classical lower bound. It proves a different algorithmic upper bound from the sharper single-time Conjecture 10.1, and does not settle that conjecture's detailed amplitude or sample-complexity law. All formalization claims must be supplied separately by actual compiled declarations.

# R. Coherent transfer and complete hidden-base reconstruction

This section is the substantive second research round. The first-round results C1–C6 and Q0–Q6 remain unchanged. In particular, Q6's local spectral probability sampler is an input to the comparison of scope, not a new second-round contribution. The construction below preserves off-diagonal matrix elements on the entire apex space and returns actual, previously unknown apex labels.

## R1. Statement and exact access assumptions

Let $G$ be any finite simple connected cubic graph with known order $n$. Let $r=L+1$ be even and at least four. Give every base vertex a six-ary spire of height $L$, and put an arbitrary two-regular bipartite weld above each base edge. The oracle is the same reversible full-neighbour-set evaluation oracle as in Q0. Its response has a canonical fixed-length encoding, invalid labels have a distinguished empty response, and the input includes one apex label. All conclusions below hold for every allowed weld realization and injective labelling. They do not rely on random labels or random welds on the quantum side.

Let $\mathcal A$ be the span of the actual labelled apex states, let $\Pi_0$ be its projector, and write $\mathcal E|v\rangle=|a_v\rangle$ for the mathematical identification of base coordinates with apex labels. The algorithm is not given $\mathcal E$. It can nevertheless recognize $\mathcal A$: valid apices have degree six, all other valid vertices have degree seven, and invalid labels have degree zero. A reversible evaluation, a degree comparison and uncomputation therefore implement its marking with two oracle calls.

**Theorem R1 (coherent functional transfer).** Let $h:[-3,3]\to\mathbb C$ satisfy $|h|\le1$ and have a supplied Lipschitz bound $K_h$. For every $0<\sigma\le1/10$, there is a heralded quantum operation whose success block $K_{h,\sigma}$ satisfies

$$
\left\|K_{h,\sigma}-\frac1{2r}\mathcal E h(A_G)\mathcal E^*\right\|_{\mathcal A\to\mathcal A}\le\sigma.
\tag{R1.1}
$$

It uses

$$
O\!\left(\frac{r(1+K_h)}{\sigma}\log\frac1\sigma\right)
\tag{R1.2}
$$

graph-oracle queries. If values of $h$ at precision $p$ can be computed uniformly in time polynomial in $p$ and the supplied parameters of $h$, then its classical preprocessing and nonoracle gate counts are polynomial in $r$, $1+K_h$, $1/\sigma$, label length, and those evaluation parameters. The gate set is the fixed inverse-closed set generated by Hadamard, $T$, $T^\dagger$ and CNOT. No unknown controlled oracle is required. The exact spectral identity behind (R1.1) holds for every bounded $h$; Lipschitz continuity and effective evaluation are needed for the stated implementation bound.

For $h(\mu)=e^{-it\mu}$ this gives a coherent, heralded simulation of the whole base walk, with ideal success probability $1/(4r^2)$ on every normalized apex superposition. The theorem is about the unnormalized success block, so it does not silently grant free postselection or an input-independent success probability for every nonunitary $h$.

**Theorem R2 (complete reconstruction).** For every rational $0<\delta<1/4$, a uniform quantum algorithm outputs the complete adjacency list of $G$ on its actual apex labels, with success probability at least $1-\delta$. Its worst-case query count is

$$
O\!\left(\frac{n^2r^4}{\delta}\left(\log\frac{nr}{\delta}\right)^4\right),
\tag{R1.3}
$$

and its nonoracle gate count is polynomial in $n,r,1/\delta$ and the label length. The reconstruction does not assume that candidate graphs have different spectra or different local spectral measures. It does not output paths through the exponentially large spire graph. Connectedness is essential for complete reconstruction from a single seed; on a disconnected base the procedure can recover only the seed component.

## R2. Exact compression on the whole apex space

Use $H=A_{\mathrm{spire}}/2$ and the invariant level space from Q1. The spectral decomposition of $A_G$ gives an orthogonal direct sum of blocks $P_\mu\otimes J_r(\mu)$. Let $f=f_r$ and $w=w_r$ be the central eigenvalue and entrance weight from Q2. Set

$$
J=[a,b]=[f(-3),f(3)],\qquad b_0=\frac1{40r}.
$$

Here $b$ is an interval endpoint, while $b_0$ is a guard width. The interval is nonempty, with length at least $6/(33r)$. It is contained in $I_r=(0,\rho_r)$ and is at distance at least $1/(10r)$ from both endpoints of $I_r$.

Let $q(\lambda)$ be the nearest-point projection onto $J$, and define

$$
\chi(\lambda)=\max\{0,1-\operatorname{dist}(\lambda,J)/b_0\},
\qquad
F_h(\lambda)=\chi(\lambda)
\frac{h(g_r(q(\lambda)))}{2r\,w_r(g_r(q(\lambda)))}.
\tag{R2.1}
$$

This definition is global on the real line. It never evaluates $g_r$ at a path pole. Since $a_r=1/(2rw_r\circ g_r)$ lies in $[1/8,1]$, we have $|F_h|\le1$. The projection is 1-Lipschitz, the taper is $40r$-Lipschitz, and Q2 gives $\operatorname{Lip}(g_r|_J)\le33r$ and $\operatorname{Lip}(a_r|_J)\le34r$. Therefore

$$
\operatorname{Lip}(F_h)\le (74+33K_h)r=:\Lambda_h.
\tag{R2.2}
$$

For each base eigenvalue $\mu\in[-3,3]$, exactly one Jacobi eigenvalue lies in $I_r$, namely $f(\mu)\in J$. Every other Jacobi eigenvalue is outside $I_r$, hence has distance at least $1/(10r)>b_0$ from $J$ and is annihilated by $F_h$. At the surviving eigenvalue,

$$
w(\mu)F_h(f(\mu))=\frac{h(\mu)}{2r}.
$$

Compressing each block to its first coordinate and summing the base spectral projections proves the exact operator identity

$$
\Pi_0 F_h(H)\Pi_0
=\frac1{2r}\mathcal E h(A_G)\mathcal E^*.
\tag{R2.3}
$$

This is an identity of operators on all apex superpositions, not just of diagonal matrix elements or root spectral measures. Degenerate base eigenvalues cause no difficulty: the same scalar multiplies the entire projection $P_\mu$. The projector $\Pi_0$ has range inside the invariant level space, so eigenvectors outside that space cannot contribute to this compression. No claim that the level space is generated cyclically by a single apex is needed.

## R3. Implementing the compression with finite error

### R3.1. A phase-estimation success block is an average

Use the padded walk isometry $T$ and the unitary $W=SR$ of Q4. For every eigenvector $\psi$ of $H$ with eigenvalue $\lambda$, the two-dimensional walk plane generated by $T\psi$ and $ST\psi$ has phases $\omega_\pm=\pm\arccos(\lambda/4)$. Different $H$ eigenspaces give orthogonal planes. The two phases both map to the same energy $4\cos\omega_\pm=\lambda$.

Let $Q$ be a coherent phase-estimation procedure, with fresh work registers for each repetition. Given a $W$ eigenstate of phase $\omega$, write its work output as $\sum_z c_z(\omega)|z\rangle$. Reversibly compute from $z$ the median of the corresponding approximate energies, denoted $E_z$. For each $z$ apply a one-qubit unitary whose success amplitude is $F_h(E_z)$. Reverse the arithmetic, apply $Q^\dagger$, and project the phase workspace and the flag onto their prescribed success values. The resulting scalar on that eigenstate is exactly

$$
\widetilde F(\omega)
=\sum_z |c_z(\omega)|^2 F_h(E_z).
\tag{R3.1}
$$

Indeed the final zero-work amplitude is the inner product of the original work vector with the amplitude-multiplied work vector. This calculation is why the phase workspace must be part of the success event. Discarding it without projection would generally produce a mixed map and would not prove coherent transfer.

The phase-estimation estimate of Q5, including the factor four in the energy evaluation, gives $|E_z-4\cos\omega|\le\eta$ except on work outcomes of total probability at most $\beta$, using $O(\eta^{-1}\log(1/\beta))$ controlled walk applications. Consequently

$$
|\widetilde F(\omega)-F_h(4\cos\omega)|
\le \Lambda_h\eta+2\beta.
\tag{R3.2}
$$

Here the bad-outcome contribution is $2\beta$, rather than a square-root bound: we are estimating the projected block (R3.1), not the norm distance between the full unprojected output states. Coherent repetitions have the same product outcome probabilities conditional on an eigenphase as the corresponding repeated measurements. Overall they remain a mixture across eigenphases, as in Q5; no unconditional independence assumption is used.

Now prepare $T$, perform this filtered walk operation, and unprepare $T$. Project every non-label preparation register onto zero as well. Compression by the isometry $T$ and its adjoint cannot enlarge the operator error. In each walk plane the ideal function takes the same value at both phases, so its compression is exactly $F_h(H)$. The approximating two phase coefficients need not be equal: the uniform bound (R3.2) suffices. Finally apply the degree-six apex test. This implements (R2.3) up to the same error, since all projectors have norm one.

The full success event therefore includes the flag, the zero phase registers, the zero arithmetic registers, the zero non-label preparation registers, and the apex degree test. The degree comparison, Boolean uncomputation and computational-basis success measurements are exact: reversible Boolean gates have exact Clifford+$T$ implementations. Gate-approximation errors below concern only the known rotations and are budgeted before these exact projectors, so an accepted output is still supported on actual apex labels. All inverse walk operations are built from the known swap and the reflection preparation/unpreparation. As in Q4, a controlled reflection uses uncontrolled preparation and unpreparation surrounding a controlled known reflection; it never calls a controlled unknown graph oracle.

### R3.2. Computing the filter without hidden real-number advice

The endpoints $f(\pm3)$ are computed by the rational bisection from Q3. It uses the recurrence

$$
p_0(x)=1,\quad p_1(x)=x,\quad
p_j(x)=x p_{j-1}(x)-\tfrac32p_{j-2}(x),
\quad
g_r(x)=x-\tfrac32p_{r-2}(x)/p_{r-1}(x).
$$

For an endpoint error at most $\xi$, replace $J$ by an inward interval whose endpoints are shifted inward by at most $2\xi$. It remains nonempty whenever $4\xi<6/(33r)$. Its Hausdorff distance from $J$ is at most $2\xi$. Clamping changes by at most $2\xi$, and the taper changes by at most $80r\xi$. Thus the resulting filter differs uniformly from (R2.1) by at most $2\Lambda_h\xi$. Every argument of $g_r$ and $a_r$ stays inside the true $J$, where the proven derivative and denominator bounds apply.

For example, the entrance weight can be evaluated as

$$
w_r(g_r(x))^{-1}
=\sum_{j=0}^{r-1}\frac{p_j(x)^2}{(3/2)^j}.
\tag{R3.3}
$$

This follows by normalizing the recurrence eigenvector with first coordinate one. On $J$, $p_{r-1}(x)=\gamma^{r-1}\sin(r\theta)/\sin\theta$ is nonzero and has magnitude at least $\gamma^{r-1}/\sqrt{33}$. Recurrence values at bounded dyadic $x$ have numerators and denominators with polynomial bit length in $r$ and the input precision. Rational arithmetic therefore suffices for $g_r$ and the weight; no ill-conditioned spectral diagonalization is being assumed.

A simple uniform gate construction avoids an unspecified coherent arithmetic primitive. The phase-estimation grid has $M=O(1/\eta)$ points. Precompute the energy associated with each grid index and the corresponding approximate complex filter value. Order the repeated estimates by their computed energy values, take the median energy, and retain its associated grid index, using a fixed rule for ties. Taking the median of the numeric phase indices would be incorrect because cosine is not monotone on the phase circle. A reversible lookup and controlled one-qubit rotations implement the table. Its size is polynomial in $1/\eta$, not in the exponentially large label universe. Project any rounding of a complex filter value back onto the closed unit disk; metric projection there does not increase its error. A unitary with prescribed first entry $z$, $|z|\le1$, can be chosen as

$$
\begin{pmatrix} z&-\sqrt{1-|z|^2}\\
\sqrt{1-|z|^2}&\overline z\end{pmatrix}.
$$

Square roots and the elementary trigonometric evaluations are computable to any requested bit accuracy by standard interval arithmetic; using twice as many value bits handles the square-root endpoint. For an efficiently evaluable $h$, the whole finite table is computable in polynomial time in the parameters of Theorem R1. In particular this applies to $h(\mu)=\mu/3$ and $h(\mu)=e^{-it\mu}$ with rational $t$ and a complexity polynomial in $1+|t|$.

To make the budget explicit, take $\eta=\sigma/(8\Lambda_h)$ and $\beta=\sigma/16$. Approximate interval endpoints, filter values and energy arithmetic so their combined additional block error is at most $\sigma/8$. Approximate the finite sequence of known gates so its total operator-norm error is at most $\sigma/4$. Telescoping the products of unitaries, followed by contraction under the success projectors, bounds the final block error by the sum of these quantities. Together with (R3.2), it is less than $\sigma$.

If the ideal sequence has $B$ known gates, accuracy $\sigma/(8B)$ per synthesized gate suffices. The inverse-closed Solovay–Kitaev construction [DN06] increases the gate count by a polynomial in $\log(B/\sigma)$. Queries themselves are exact black-box gates and are not approximated. The controlled walk powers and their inverses cost $O(\eta^{-1}\log(1/\beta))$ oracle queries; the remaining preparations and degree tests add only a constant. This proves (R1.1), (R1.2), and the finite-gate claim.

## R4. Direct sampling of a hidden base neighbour

Choose $h(\mu)=\mu/3$. It has $K_h=1/3$, so $\Lambda_h=85r$. The exact success block becomes

$$
K_0=\frac1{6r}\mathcal E A_G\mathcal E^*.
\tag{R4.1}
$$

Starting at a known actual apex label $a_u$, it produces

$$
K_0|a_u\rangle=\frac1{6r}\sum_{v\sim_G u}|a_v\rangle.
$$

The ideal success probability is

$$
p_0=\frac3{36r^2}=\frac1{12r^2},
\tag{R4.2}
$$

and measuring the label conditional on success gives a uniform base neighbour. This returns labels of the adjacent *apices*, not labels of neighbours of the input in the original spire graph. It works even when all local spectral distributions of two candidate bases agree, because the compressed operator retains off-diagonal amplitudes.

Here is the conditioning estimate needed to use an approximate success block. Put $v_0=K_0|a_u\rangle$, $v=K_{h,\sigma}|a_u\rangle$, and $a_0=\|v_0\|=\sqrt3/(6r)$. Then $\|v-v_0\|\le\sigma$, $|\|v\|-a_0|\le\sigma$, and, if $v\ne0$,

$$
\left\|\frac v{\|v\|}-\frac{v_0}{a_0}\right\|
\le\frac{2\sigma}{a_0}.
\tag{R4.3}
$$

To see this, add and subtract $v/a_0$, and use $|\|v\|-a_0|\le\sigma$. Measurement total variation is no larger than the trace distance of the pure states, which is no larger than this vector distance. If $\sigma\le a_0/4$, the actual success probability is at least $(3a_0/4)^2\ge1/(24r^2)$.

Each failed attempt can be discarded and the known computational-basis label $a_u$ prepared again. No cloning or reset of an unknown apex superposition is required. This distinction allows a simple bounded-repeat reconstruction algorithm without using free postselection or an unproved amplitude-amplification subroutine.

## R5. Adaptive breadth-first reconstruction and its full budget

Define

$$
k=\left\lceil3\log\frac{24n}{\delta}\right\rceil,
\qquad T_0=nk,
\qquad \sigma=\frac{\delta}{1000rT_0},
\qquad
B_0=\left\lceil48r^2\log\frac{8T_0}{\delta}\right\rceil.
\tag{R5.1}
$$

The algorithm keeps a dictionary of actual apex labels and a queue, initially containing only the supplied seed. For each queued label it requests $k$ successful samples using R4, allowing at most $B_0$ independent attempts for each requested sample. If this cap is reached without success, it reports failure. It records the distinct returned neighbour labels, places newly discovered labels in the queue, and outputs the resulting adjacency list after processing at most $n$ vertices. It may report failure if a row does not contain exactly three distinct neighbours, if more than $n$ labels occur, or if the final consistency checks fail. These checks never reject on the good event proved below.

The chosen $\sigma$ is smaller than $a_0/4$. Thus each attempt succeeds with probability at least $1/(24r^2)$, and the probability of exhausting the cap for any specified requested sample is at most

$$
\left(1-\frac1{24r^2}\right)^{B_0}
\le e^{-B_0/(24r^2)}
\le\frac{\delta}{8T_0}.
\tag{R5.2}
$$

The attempts start afresh at the known label. Conditional on obtaining a success before the cap, the returned label has the same distribution as one attempt conditioned on success: summing over the possible first-success times only multiplies the same conditional distribution by scalar weights.

By (R4.3), the variation distance of this distribution from an exactly uniform neighbour is at most

$$
\frac{12r\sigma}{\sqrt3}
<\frac{\delta}{100T_0}.
\tag{R5.3}
$$

Couple each requested label with an ideal uniform neighbour until the first discrepancy. The estimate is uniform over every graph and every known apex, so it holds conditionally on every adaptive history on which the coupling has not yet failed. With at most $T_0$ requested samples, the probability of any such discrepancy is at most $\delta/100$. The probability of any cap failure is at most $\delta/8$ by (R5.2).

In the ideal neighbour process, a fixed one of the three neighbours is missed by $k$ independent samples with probability $(2/3)^k\le e^{-k/3}$. A union bound over the three neighbours and at most $n$ processed vertices gives

$$
3n(2/3)^k\le3n e^{-k/3}\le\delta/8.
\tag{R5.4}
$$

On the complement of these three failure events, every processed row is exactly the true set of three adjacent apex labels. Connectedness then ensures that the queue reaches every base vertex and terminates with the complete graph. The total failure probability is at most $\delta/100+\delta/8+\delta/8<\delta$, proving correctness. No independence between different adaptive rows is needed for these conditional union bounds.

For adjacency sampling, (R1.2) gives $O((r/\sigma)\log(1/\sigma))=O((r^2T_0/\delta)\log(rT_0/\delta))$ queries per attempt. There are at most $T_0B_0$ attempts. Since $T_0=O(n\log(n/\delta))$ and $B_0=O(r^2\log(T_0/\delta))$, multiplication yields (R1.3), after bounding all logarithms by a constant multiple of $\log(nr/\delta)$. The finite lookup construction in R3 and the dictionary operations show that the total nonoracle gate and preprocessing counts are polynomial as claimed. The displayed powers are conservative and no optimality is asserted.

## R6. Scope, consequences, and limitations

Theorem R2 is uniform over connected cubic bases; a spectral distinction between candidates is unnecessary. For any base property that can be decided in polynomial time from its adjacency list, the reconstruction provides a polynomial-time quantum decision algorithm. Whenever two same-order cubic bases have different values of such a property, C6 gives the classical lower bound $\operatorname{Adv}\le1568t^2/6^L$ for the corresponding random spired ensembles. If $L$ grows linearly with $n$, this is an exponential quantum–classical oracle separation for that promise problem.

More generally the reconstruction itself permits identification of any two nonisomorphic connected cubic bases with polynomially many oracle queries. Polynomial total time for the final isomorphism comparison additionally follows from Luks's established bounded-valence graph-isomorphism algorithm [L82]; it is not supplied by brute-force permutation enumeration or proved anew here. Applying that algorithm to the recovered cubic adjacency list and the two explicitly given candidates costs polynomial time in $n$ and no further graph-oracle queries. The reconstruction theorem, the original prism–Möbius algorithm, and the polynomial-time-property corollary do not need that extra ingredient.

The method does not recover the names of the exponentially many interior vertices, does not reveal physical paths between apices, and does not claim a separation without an oracle. The even-$r$ restriction is retained because the quantitative branch proof Q2 uses consecutive path poles at zero and $\rho_r$. The complete output concerns the connected seed component; unseen disconnected components cannot be inferred from this access. Full-paper kernel verification remains a separate, unfinished obligation.

# References

**[W26]** Paweł Wocjan. *Quantum Algorithm for Identifying Hidden Graphs: Spectral Theory and Numerical Evidence*. arXiv:2605.11228v1, 11 May 2026. Primary full text and PDF examined, especially Definitions 2.1–2.5, §§3–7 and Conjectures 10.1, 11.1. [Primary text](https://arxiv.org/html/2605.11228v1).

**[BD24]** Shalev Ben-David, Andrew M. Childs, András Gilyén, William Kretschmer, Supartha Podder, and Daochen Wang. *Symmetries, Graph Properties, and Quantum Speedups*. SIAM Journal on Computing 53 (2024). DOI:10.1137/23M1573975. The published §6.3.2, Lemmas 6.11–6.14, and §6.3.3 were examined; the older arXiv numbering and bounds are not substituted for this version. [Published full text](https://epubs.siam.org/doi/full/10.1137/23M1573975).

**[BLH25]** Shankar Balasubramanian, Tongyang Li, and Aram W. Harrow. *Exponential Speedups for Quantum Walks in Random Hierarchical Graphs*. Communications in Mathematical Physics 406, 209 (2025), DOI:10.1007/s00220-025-05370-x; arXiv:2307.15062v2. The hierarchical-graph oracle comparison in §5 was examined for overlap. [Primary preprint](https://arxiv.org/html/2307.15062v2).

**[C03]** Andrew M. Childs, Richard Cleve, Enrico Deotto, Edward Farhi, Sam Gutmann, and Daniel A. Spielman. *Exponential Algorithmic Speedup by a Quantum Walk*. Proceedings of STOC 2003, pp. 59–68; arXiv:quant-ph/0209131. [Primary preprint](https://arxiv.org/abs/quant-ph/0209131).

**[S04]** Mario Szegedy. *Spectra of Quantized Walks and a $\sqrt{\delta\epsilon}$ Rule*. arXiv:quant-ph/0401053. [Primary preprint](https://arxiv.org/abs/quant-ph/0401053).

**[CEMM98]** Richard Cleve, Artur Ekert, Chiara Macchiavello, and Michele Mosca. *Quantum Algorithms Revisited*. Proceedings of the Royal Society A 454 (1998); arXiv:quant-ph/9708016. [Primary preprint](https://arxiv.org/abs/quant-ph/9708016).

**[DN06]** Christopher M. Dawson and Michael A. Nielsen. *The Solovay–Kitaev Algorithm*. Quantum Information and Computation 6 (2006), 81–95; arXiv:quant-ph/0505030v2. The inverse-closed finite-set hypothesis and logarithmic gate bound are used. [Primary preprint](https://arxiv.org/abs/quant-ph/0505030v2).

The literature search is bounded by the actually retrieved sources. No worldwide priority or external peer-review certification is asserted. Unavailable manuscripts were not used as mathematical premises. Details of source versions, actual access, and repository overlap are recorded separately in SOURCES.json and NOVELTY_AUDIT.md.


**[MS22]** Ashley Montanaro and Changpeng Shao. *Quantum Algorithms for Learning a Hidden Graph*. TQC 2022, LIPIcs 232, 1:1–1:22. DOI:10.4230/LIPIcs.TQC.2022.1. Publisher abstract checked for the OR, parity and graph-state access models; unexamined technical results are not premises here. [Publisher](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.TQC.2022.1).

**[LLL24]** Guanzhong Li, Lvzhou Li and Jingquan Luo. *Recovering the Original Simplicity: Succinct and Deterministic Quantum Algorithm for the Welded Tree Problem*. SODA 2024, 2454–2480. DOI:10.1137/1.9781611977912.87. The publisher abstract establishes prior deterministic coined-walk traversal; its internal proof is not used. [Publisher](https://epubs.siam.org/doi/10.1137/1.9781611977912.87).

**[L82]** Eugene M. Luks. *Isomorphism of Graphs of Bounded Valence Can Be Tested in Polynomial Time*. JCSS 25(1), 42–65 (1982). DOI:10.1016/0022-0000(82)90009-5. An established optional postprocessing result, not a new contribution. [Author's PDF](https://ix.cs.uoregon.edu/~luks/iso.pdf).

**[WS26]** Pawel Wocjan. *Identifying Hidden Graphs with Quantum Walks: From BQP-Completeness to an Exponential Separation*. CFT PAN seminar, 15 September 2026. The author's abstract still describes the prism–Mobius separation as conjectural, and mentions a separate BQP connection outside [W26]. A search boundary, not a proof premise. [Host page](https://www.cft.edu.pl/nauka/seminaria/identifying-hidden-graphs-with-quantum-walks-from-bqp-completeness-to-an-exponential-separation/).
