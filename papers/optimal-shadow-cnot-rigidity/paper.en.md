# Optimizer rigidity and a sharp tree resource boundary for optimal Clifford shadows

## Abstract

The statistical optimum of two-sided locally randomized Clifford shadows is known, but an optimal score alone does not specify which circuits attain it or their entangling-gate cost. We characterize every optimizing binary symplectic map. At every order $k\ge6$, the optimizer set is exactly the dual-axis family under input and output local Clifford transformations and independent site permutations; orders four and five each have one additional class. We determine the number of labelled optimizing matrices and give a quadratic-time recognizer with an explicit local-factorization certificate.

We then turn equality structure into a topology-sensitive resource obstruction. Every optimizer implemented on any $k$-vertex tree requires at least $3k-4$ CNOTs at odd order and $3k-5$ at even order. The proof controls the chronology of transfer across bridges, including arbitrary interleaved local gates. For every odd $k\ge3$, an explicit star circuit attains $3k-4$. Thus the best cost over all tree topologies is exactly $3k-4$ at every odd order. With arbitrary nonnegative star-edge costs $w_j$, the exact odd-order cost is $3\sum_jw_j-\max_jw_j$. A separate symbolic construction leaves a one-CNOT interval at every even star order.

Supporting synthesis results include a nine-CNOT five-site dual-axis seed, an improved complete-graph upper bound $3k-6$ for every $k\ge4$, and the exact labelled-path minima $g_{P_5}=12$, $g_{P_6}=16$. The path lower bounds use a self-contained cut-assignment invariant and exhaustive finite searches with separately checked coverage. All arbitrary-order assertions have analytic proofs; finite replays are implementation checks. Exact complete-graph and path minima at every larger order remain open under the unchanged original problem. The manuscript includes all proofs, the historical proof dependencies, and explicit boundaries of computational and formal verification.

## 1. Problem, resource model and contribution

Let $V_k=(\mathbb F_2^2)^k$, with one physical pair $(x_i,z_i)$ per labelled qubit and $k\ge2$. Write $\operatorname{wt}(p)$ for the number of nonzero physical pairs of $p$. A Clifford, after ignoring Pauli signs and global phase, acts by $M\in\operatorname{Sp}(2k,2)$. Define

```math
\mathcal F_k=(\mathbb F_2^2\setminus\{0\})^k,
\qquad S_k(M)=\sum_{p\in\mathcal F_k}3^{k-\operatorname{wt}(Mp)}.
```

Nie, Zhang, Wu and Chen [1] prove that the maximum is

```math
s_k=\begin{cases}
(3\cdot5^k+3^k-6)/4,&k\text{ odd},\\
(3\cdot5^k-3^k+2)/4,&k\text{ even}.
\end{cases}
```

Their dual-axis Clifford $U_*=\exp(i\pi X^{\otimes k}/4)\exp(i\pi Z^{\otimes k}/4)$ attains it. The corresponding optimal squared shadow norm is $9^k/s_k$. These statistical facts and this optimizing family are inputs from [1], not new results of this manuscript. Our questions concern the complete equality set and the least implementation cost over that entire set.

For a connected physical interaction graph $G$, let $g_G(k)$ be the smallest CNOT count among all maps with score $s_k$. Circuits use exactly the $k$ labelled qubits, no ancillary qubits, arbitrary interleaved single-qubit Cliffords at zero cost, and CNOTs in either direction along edges of $G$. A physical SWAP or wire permutation has its actual implementation cost. Measurements, feed-forward and non-Clifford middle gates are outside this model. For edge weights $w_e\ge0$, the weighted objective is the sum of CNOT-edge costs with multiplicity, rather than the count of distinct used edges.

Input and output site permutations preserve the score and therefore produce legitimate optimization targets. This does not permit free intermediate physical permutations. Our lower bounds cover every target permutation, and our upper bounds are literal gate lists on the specified graph. This distinction is essential on a labelled path.

The equality classification is complete. The exact CNOT minima on complete graphs and labelled paths are determined at the orders listed in Section 5. The general minima and the even-star optimum remain open.

The principal new resource boundary is operational: for any odd number of qubits, no tree hardware can attain the known statistical optimum below $3k-4$ entangling gates, and one specified tree attains that cost exactly. Its weighted version identifies the cheapest optimal implementation on a fixed star, including unequal and zero edge costs. This establishes a necessary and sufficient budget on that family, rather than the cost of one unproved or potentially suboptimal compiler output. It does not establish robustness to noise or a new shot-complexity bound.

## 2. Complete equality classification and efficient recognition

Put

```math
q(x,z)=x+z+xz,\quad
R=\begin{pmatrix}0&1\\1&1\end{pmatrix},\quad
K=\begin{pmatrix}1&1\\1&1\end{pmatrix}.
```

Let $N_k$ have every off-diagonal physical block equal to $I_2$, and every diagonal block equal to $R$ at odd order or $K$ at even order. These are local normalizations of the dual-axis map. A physical block always means a $2\times2$ block; all matrix arithmetic is over $\mathbb F_2$.

**Theorem 1 (complete optimizer set).** For symplectic $M$, the following criteria are equivalent to $S_k(M)=s_k$.

| Order | Necessary and sufficient criterion |
|---|---|
| $k=2,4$ | The rank-one blocks form exactly one matching, with one in every block row and column; all other blocks are invertible. |
| $k=3,5$ | Every physical block is invertible. |
| Every $k\ge6$ | $M=L_{\mathrm{out}}P_{\mathrm{out}}N_kP_{\mathrm{in}}L_{\mathrm{in}}$, with site-local invertible blocks $L$ and site permutations $P$. |

There is one local/permutation class at orders two and three, two at each of orders four and five, and one at every order at least six. The all-order normal form and small-order equality criteria are analytic. Exhaustive integer certificates determine the two class counts at four and five. The rank conditions remain necessary at every order, but they cease to be sufficient above the stated small-order ranges; explicit six- and nine-site counterexamples are included in the appendices.

The structural proof retains equality information in the product-measure quadratic estimate used by [1]. For

```math
\mu(0)=\tfrac12,\qquad\mu(v)=\tfrac16\ (v\ne0),
\qquad \mu=\tfrac13\delta_0+\tfrac23\operatorname{Unif}(\mathbb F_2^2),
```

equality on an even number of projected pairs forces a rank-two anisotropic quotient $q(\sum_i A_i y_i)$, with all $A_i$ invertible. On an odd number of pairs, the integer-rounded optimum has exactly one unit of slack, forcing exactly one rank-one summand. The actual affine parity shift is retained. A separate avoidance lemma requires every counted projected point to lift to nonzero physical outputs; it reduces each output coordinate to a coordinate form or a common sum form. Every such type has positive odd multiplicity.

Deleting any three input sites leaves one triple type and all other types single. Exactly three output-row pairs become proportional. For any fixed output-row pair, symplecticity bounds the number of deleted triples producing proportionality by $k-2$. The saturated incidence identity

```math
3\binom{k}{3}=\binom{k}{2}(k-2)
```

forces every pair to saturate. This aligns the local block ratios globally. The odd proof starts at seven sites; the even proof includes the affine three-variable boundary at six. Appendices A–D give every equality, lifting and boundary argument.

**Theorem 2 (counting and recognition).** For every $k\ge6$, the number $a_k$ of labelled optimizing binary symplectic matrices is

```math
a_k=\begin{cases}
6^{2k}k!/2,&k\text{ even},\\
6^{2k}k!/3,&k\text{ odd}.
\end{cases}
```

This counts matrices, not signed Clifford unitaries or global phases. Given an arbitrary binary $2k\times2k$ matrix, without a symplecticity promise, an exact algorithm recognizes membership in the optimizer set in $O(k^2)$ operations on constant-size blocks. An accepted input comes with the local factors and matching permutation; their verification also takes $O(k^2)$. The certificate requires $O(k\log k)$ bits.

At even order the rank-one positions identify the unique matching. At odd order, for two block rows $i,h$, the ratios $M_{ij}M_{hj}^{-1}$ have multiplicities $k-2,1,1$. Their two exceptional positions are exactly the two matching positions. Intersecting two such exception sets identifies one matching value and recovers all the others. After fixing the matching, the remaining local gauge is the common centralizer of the canonical diagonal block. Its order is two at even order and three at odd order, giving the formula above. Constant-size local-factor tests then validate every block, including failures of the necessary rank pattern to be sufficient. The same constant-fiber parameterization yields a uniform sampler. Appendix N gives the stabilizer, algorithm and proof in full.

## 3. A chronological obstruction on trees and bridges

The universal necessary block patterns in Theorem 1 suffice for the lower bound. Call the odd pattern O: all blocks are invertible. Call the even pattern E: one rank-one block in each row and column and every other block invertible. In this section pattern O requires $k\ge3$, and pattern E requires $k\ge4$; the one-CNOT two-qubit baseline is excluded. The arguments apply to every symplectic target with the respective pattern and size, not only a chosen normal-form representative.

**Theorem 3 (bridge transfer).** For a pattern-O target on $k\ge3$ sites or a pattern-E target on $k\ge4$ sites, in any circuit on a connected graph each bridge is crossed by at least two CNOTs. For a pattern-O target, at most one bridge is used exactly twice. For a pattern-E target, at most two bridges are used exactly twice; if there are two, both must be pendant bridges isolating individual vertices.

The first assertion follows from two-directional information transfer. To prove the stronger obstruction, remove two bridges and call their outer components $A,C$. Of their first crossing gates, one occurs before information from the other outer component can have reached it. If both bridges are used only twice, only one crossing remains to supply that distant information. The corresponding final corner transfer matrix therefore has binary rank at most one. Pattern O forbids every such corner. Pattern E permits it only when both outer components are single vertices and their locations belong to the rank-one matching. Three twice-used pendant edges are impossible: the leaf with earliest first use would have rank-one transfer blocks from two different leaves in a single output block row. This violates the matching condition. Arbitrary local operations inside components do not create transfer across a bridge and are fully allowed in this argument.

Let $B$ be the set of bridges, $W=\sum_{e\in B}w_e$, and let $B_{\rm pend}$ be the pendant bridges. The weighted consequences are

```math
\operatorname{cost}\ge 3W-\max\bigl(\{0\}\cup\{w_e:e\in B\}\bigr)
\quad\text{in pattern O},
```

and

```math
\operatorname{cost}\ge3W-
\max\bigl(\{0\}\cup\{w_e:e\in B\}
\cup\{w_e+w_f:e\ne f,\ e,f\in B_{\rm pend}\}\bigr)
\quad\text{in pattern E}.
```

The singleton option in the even bound includes internal bridges: a single heavy internal edge may be the sole twice-used exception. Omitting that option would give an invalid weighted statement. Nonbridge gates only contribute additional nonnegative cost. For any $k$-vertex tree with unit edge costs, the bounds specialize to

```math
g_T(k)\ge3k-4\quad(k\ge3\text{ odd}),\qquad
g_T(k)\ge3k-5\quad(k\ge4\text{ even}).
```

Appendix K proves the statements with all component and timing cases. The conclusion is stronger than summing isolated cut ranks: it constrains which cuts can simultaneously attain their individual two-gate minima.

## 4. Exact star cost and the best odd-order tree

**Theorem 4 (sharp odd stars).** For every odd $k\ge3$,

```math
g_{K_{1,k-1}}(k)=3k-4,
\qquad \min_{T\text{ a labelled }k\text{-vertex tree}}g_T(k)=3k-4.
```

For arbitrary nonnegative star-edge costs,

```math
g_{K_{1,k-1},w}(k)=3\sum_{j=1}^{k-1}w_j-\max_jw_j.
```

To attain these bounds, take center zero and a pivot leaf one. For nonzero Pauli labels $a,b$, let $G_{ij}(a,b)$ be the pure controlled-Pauli gate

```math
p_i'=p_i+aB(b,p_j),\qquad p_j'=p_j+bB(a,p_i),
```

with both right sides evaluated before the gate. It costs one CNOT up to free locals. In chronological order perform a sweep of $G_{0j}(X,X)$ over the ordinary leaves $j\ge2$, then $G_{01}(Y,X)$, a sweep of $G_{0j}(Z,Z)$, then $G_{01}(Y,Z)$, and a sweep of $G_{0j}(X,Y)$. The pivot edge is used twice and each ordinary edge three times.

For center coordinates $(x,z)$, pivot $(y,w)$, ordinary leaves $(u_j,v_j)$, and $U=\sum_{j\ge2}u_j$, $V=\sum_{j\ge2}v_j$, direct evaluation at odd order gives

```math
\begin{aligned}
p_0'&=(x+y+U,\ x+z+y+w+U+V),\\
p_1'&=(x+z+y+V,\ x+w+U+V),\\
p_j'&=(u_j+x+y+w+U+V,\ v_j+z+y+U).
\end{aligned}
```

Write $\widehat R=R^2=\left(\begin{smallmatrix}1&1\\1&0\end{smallmatrix}\right)$, $H=\left(\begin{smallmatrix}0&1\\1&0\end{smallmatrix}\right)$, and let $\widehat N_k$ have diagonal $\widehat R$ and off-diagonal $I$. The exact matrix identity is

```math
F=\operatorname{diag}(H,\widehat R,I,\ldots,I)\,
\widehat N_k\,\operatorname{diag}(I,\widehat R,\widehat R,\ldots,\widehat R).
```

Thus the circuit is locally equivalent to the known optimizing dual-axis family at every odd order. The theorem is not inferred from all blocks being invertible, a condition that alone would be insufficient at larger orders. The tree lower bound proves sharpness. For weighted edges choose a maximum-weight edge as pivot. This changes the chosen endpoints of the literal gates; it does not insert a free wire permutation.

**Theorem 5 (even stars).** For every even $k\ge4$,

```math
3k-5\le g_{K_{1,k-1}}(k)\le3k-4.
```

The upper construction changes the second pivot gate to $G_{01}(X,Z)$ and the final sweep to $G_{0j}(Y,Y)$. Its separate even-parity symbolic calculation and exact local normalization are given in Appendix L, Section 7. This proves an arbitrary-order upper bound, but neither endpoint is asserted to be the exact even-star minimum. If $w_{(1)}\ge w_{(2)}$ are the two largest star-edge weights, the weighted interval is

```math
3\sum_jw_j-w_{(1)}-w_{(2)}
\le g_{K_{1,k-1},w}(k)
\le3\sum_jw_j-w_{(1)}.
```

## 5. Complete connectivity and exact finite path results

**Theorem 6 (uniform complete-graph construction).** For every $k\ge4$,

```math
g_{K_k}(k)\le3k-6.
```

The even case is the construction of [1]. The new odd case starts with a five-site dual-axis optimizer costing nine CNOTs. Previously the nine-CNOT witness at five sites belonged to the exceptional class, so it did not establish this seed. A complete local-factor certificate identifies the new seed's dual-axis coset; the old complete eight-gate exclusion proves that this coset has minimum nine. This is not a claim that the specifically unpermuted displayed $U_*$ has nine-gate cost.

A three-CNOT encoder on sites $a,b,c$, in order $a\to b$, $c\to a$, $b\to c$, sends both logical $X_a$ and $Z_a$ to their three-site full products. Balanced iteration creates any odd-size support with $3(r-1)/2$ CNOTs. Conjugating the seed by this encoder on $r=k-4$ sites yields $9+3(r-1)=3k-6$ CNOTs. An exact three-coefficient Fourier identity verifies the optimal score at all odd sizes; its coefficients for the seed are $(1875,81,-6)$. The all-order proof is in Appendix M. The same construction gives a CNOT-depth upper bound $6\lceil\log_3(k-4)\rceil+7$ at odd $k\ge5$; no depth optimum is claimed.

Comparing the complete construction with Theorem 3 shows a strict advantage over every tree for $k\ge4$. In particular, any optimal-shadow circuit below the tree floor must use a cycle in its actual simple interaction graph. At odd $k\ge5$, the exhibited complete circuit is two gates cheaper than the best tree. The exact complete-graph advantage may be larger because its minimum is still unknown beyond the listed finite orders.

**Theorem 7 (finite labelled paths).**

```math
g_{P_5}(5)=12,\qquad g_{P_6}(6)=16.
```

The upper circuits were already supplied by the path family with $4k-8$ gates. The new exclusions of budgets eleven and fifteen use an exact assignment-aware cut invariant. For output prefixes $A_i=\{1,\ldots,i\}$, set

```math
H(F)=\min_{\substack{\varnothing=S_0\subset\cdots\subset S_k=[k]\\|S_i|=i}}
\sum_{i=1}^{k-1}\operatorname{rank}_{\mathbb F_2}F[A_i,[k]\setminus S_i].
```

A terminal local-permutation matrix determines a nested assignment $S_i$ and makes each rank zero. A physical adjacent CNOT changes only the summand at its own cut, by at most one. Free locals preserve all summands. Therefore $H(F)$ lower-bounds every path reduction to the terminal family. It is invariant under right input locals and permutations and left output locals; it vanishes exactly on the local-permutation matrices. A subset dynamic program evaluates it in $O(k2^k)$ predecessor operations plus binary-rank calculations.

The finite search generates all nine weight-two Pauli transvections on each physical edge. It normalizes output local planes without sorting output sites; input planes may be normalized and sorted on the right because these symmetries commute with all future physical left gates. At five sites, all 120 output placements of both optimizer classes are included. At six, the symmetric normal form lets a target output permutation be absorbed into a terminal input permutation. These facts establish coverage without free intermediate SWAPs. Appendix L gives the full equivalence argument, cache soundness and explicit interruption semantics.

| Exhaustive exclusion | Starting classes | Recursive visits | Completion |
|---|---:|---:|---|
| $k=5$, budget 11, dual-axis | 3 reduced starts from all placements | 10,582 | Exhausted |
| $k=5$, budget 11, exceptional | 18 reduced starts from all placements | 1,354 | Exhausted |
| $k=6$, budget 15, dual-axis | 1 symmetric start | 486,363 | Exhausted |

The lower-bound runs were independently recompiled and repeated. The six-site count was reproduced with the external LMC pruning entirely disabled, using only $H$. A seven-site budget-19 exploration reached its two-million-visit cap and was interrupted; it proves no exclusion. The distinction between exhaustive failure and interruption is part of the stored results.

The combined exact values and remaining intervals are:

| Size | Complete graph | Labelled path | Star |
|---|---:|---:|---:|
| $2$ | $1$ | $1$ | $1$ |
| $3$ | $4$ | $5$ | $5$ |
| $4$ | $6$ | $7$ | $[7,8]$ |
| $5$ | $9$ | $12$ | $11$ |
| $6$ | $[8,12]$ | $16$ | $[13,14]$ |
| Odd $k\ge7$ | $[2k-2,3k-6]$ | $[3k-4,4k-8]$ | $3k-4$ |
| Even $k\ge8$ | $[3k/2-1,3k-6]$ | $[3k-5,4k-8]$ | $[3k-5,3k-4]$ |

Order-two and order-three values are reproduced prior baselines [1,3]. The proofs and exhaustive certificates for the four-site complete/path pair and five-site complete value appear in Appendices D and G–I. The complete-graph lower-bound method uses Jørgensen's link-middle-cut framework [2] with explicit credit. We do not claim to have invented its determinant or support-component bounds.

## 6. Closest work, novelty and evidential limits

The closest direct paper [1] supplies the statistical optimum, the dual-axis witness, complete-graph constructions $3k-6$ at even orders and $3k-5$ at odd orders, and a path construction $4k-6$. Its synthesis question does not characterize all optimizing maps or provide the sharp odd-star/best-tree boundary established here. The present classification prevents a lower-bound proof from silently treating one chosen optimizer as the whole equality set. The bridge chronology and matching star circuit then connect score saturation to an exact hardware resource budget.

Reference [2] supplies general link, middle and cut counting tools for Clifford synthesis, including minimization over permutation cosets. Our pre-existing complete lower bounds and small-order complete searches use those tools. The new bridge chronology restricts simultaneous near-minimal use of distinct bridges; the path assignment invariant handles unknown terminal placements and is proved here directly. Neither is presented as a replacement for the wider synthesis framework of [2].

A technically relevant published comparison is Ippoliti, Li, Rakovszky and Khemani, *Physical Review Letters* **130**, 230403 (2023), DOI [10.1103/PhysRevLett.130.230403](https://doi.org/10.1103/PhysRevLett.130.230403) [4]. It links shadow norms to operator-weight dynamics and gives logarithmic-depth sampling improvements, with explicit distinctions between rigorous bounds and one-dimensional mean-field predictions. Our setting instead fixes two-sided local randomization around a deterministic Clifford and proves the entire equality set and an exact CNOT budget on an infinite hardware family. This is a concrete comparison of problems and conclusions, not a claim to reproduce [4]'s dynamical theory or inherit its publication status.

The comparison with [5] uses its bibliographic record and abstract. The analysis uses version 2 of [1], and the full texts of [2] and [4]. The comparison with AFTD OP-757 [3] is limited to the public catalogue entry because its separately linked general statement was inaccessible.

The bounded source search found no retrieved primary work establishing this complete equality classification or the exact odd-star/best-tree boundary. This is not a global priority guarantee and does not exclude unindexed or private work.

## 7. Reproducibility and what the manuscript does not claim

The analytic conclusions are proved in the appended modules. The four- and five-site class enumerations and the finite exact synthesis exclusions additionally depend on exhaustive integer computations, with stated normalized universes and complete generator coverage. Literal H/S/CNOT witnesses are checked by direct Pauli-label propagation, independently of the producers' row-update routines. Multiple large-size star and complete-family checks test implementations; they are not evidence replacing arbitrary-order symbolic proofs.

The new independent replay checks the seed's 25 physical blocks, its 324 exact Fourier coefficients and 64 convolution values, the star symbolic maps and local factors for both parities, cut-bound invariance, and the finite lower-bound results. The finite certificates and check programs are linked in the appendices. Optional heuristic probes and capped seven-site searches are explicitly excluded from lower-bound claims.

This manuscript contains written proofs and finite certificates. It has not undergone external peer review or formal proof-assistant verification.

The unresolved mathematical questions are the exact complete-graph minimum from six sites onward, the exact labelled-path minimum from seven sites onward, and exact even-star costs. We have not proved $g_{P_k}=4k-8$ in general, nor $g_{K_k}=3k-6$ in general. We have not established noise tolerance, experimental performance, ancilla-assisted optima, non-Clifford optima, or minimum depth.

## 8. Complete-proof organization

Appendices A–J give the preliminary proofs and small-order results. Appendices K–N give the bridge theorem, path and star results, complete-graph construction, and orbit recognition. Sections 2–7 state the combined results and their remaining limitations.

The appendices use their own theorem numbering. Sections 2–7 state the proved and unresolved scope.

## References

1. Xiaotian Nie, Tao Zhang, Yadong Wu and Linghui Chen. *Exact Clifford Optimality for Two-Sided Locally Randomized Classical Shadows*. [arXiv:2610.04621v2](https://arxiv.org/abs/2610.04621v2), 2026. Original optimum and dual-axis constructions. Current author-text access: [version-displaying mirror](https://arxiv.cnoctave.top/pdf/2610.04621).
2. Søren Fuglede Jørgensen. *Link-middle-cut lower bounds for Clifford circuit synthesis*. [arXiv:2609.16208v1](https://arxiv.org/html/2609.16208v1), 2026. Existing support and determinant tools, especially Theorems 6.2 and 6.3.
3. AFTD. [Problem catalogue, OP-757](https://rainwangphy.github.io/aftd-platform/problems/). Inspected 25 November 2026. Public catalogue evidence is not locally recompiled Lean verification.
4. Matteo Ippoliti, Yaodong Li, Tibor Rakovszky and Vedika Khemani. *Operator Relaxation and the Optimal Depth of Classical Shadows*. **Physical Review Letters 130**, 230403 (2023). DOI [10.1103/PhysRevLett.130.230403](https://doi.org/10.1103/PhysRevLett.130.230403); [author full text](https://arxiv.org/html/2212.11963v3).
5. Christian Bertoni, Jonas Haferkamp, Marcel Hinsche, Marios Ioannou, Jens Eisert and Hakop Pashayan. *Shallow Shadows: Expectation Estimation Using Low-Depth Random Clifford Circuits*. **Physical Review Letters 133**, 020602 (2024). DOI [10.1103/PhysRevLett.133.020602](https://doi.org/10.1103/PhysRevLett.133.020602). Bibliographic and abstract-level comparison only in this round.


---

## Appendix A. Product-measure equality

**Scope note.** This appendix presents a preliminary result. Sections 2–7 state the combined conclusions.


### Equality in the product-measure quadratic-phase bound

This lemma gives the equality conditions used in the optimizer classification. The inequality and its product-measure proof are from
Nie–Zhang–Wu–Chen, arXiv:2610.04621v2, Appendix C; the purpose here is to
unpack its equality condition explicitly.

#### 1. Setup

Let ℓ≥1, V=(F₂²)^ℓ, and R:V→F₂ be quadratic with R(0)=0. On each physical
pair take the probability measure

    μ(0)=1/2,  μ(v)=1/6 for v≠0,
    μ=(1/3)δ₀+(2/3)Unif(F₂²).

Write Q_aniso(a,b)=a+b+ab; it is zero at zero and one at each of the three
nonzero vectors. The known inequality is

    E_(μ^⊗ℓ) (-1)^R ≥ −1/2+(3/2)·3^(−ℓ).                  (R1)

#### 2. Equality characterization

**Lemma.** Equality in (R1) holds if and only if there exist invertible
linear maps A_i:F₂²→F₂² such that

    R(p_1,...,p_ℓ)=Q_aniso(Σ_i A_i p_i).                    (R2)

**Proof.** Expand μ^⊗ℓ as a mixture of uniform measures on the coordinate
subspaces V_S, S⊆{1,...,ℓ}. Every mixture weight is strictly positive; the
empty subspace has weight 3^(−ℓ). For any quadratic form vanishing at zero,
its uniform phase average is either zero or ±2^(−r/2), where r is the even
rank of its polar form. The average is zero if its restriction to the
polar radical is a nonzero linear function. If that restriction vanishes,
the form descends to a nondegenerate quotient and the usual quadratic
Gauss sum gives the stated value. At rank zero the possible averages are
zero and one. Thus every nonempty subspace average is at least −1/2.

The weighted sum reaches (R1) precisely when every nonempty V_S has average
−1/2. In particular, the full-space average is −1/2. Hence the polar form
of R has rank two, R vanishes on its polar radical, and its induced
two-dimensional nondegenerate quadratic form has negative Gauss sum.
The latter form is the anisotropic plane: all three nonzero quotient
vectors have value one. Choose a quotient isomorphism L:V→F₂²; then
R=Q_aniso∘L. Decompose the linear map as L(p)=Σ_i A_i p_i.

The average on a single physical pair V_{ {i} } is the average of
(-1)^Q_aniso over the image of A_i. If rank A_i is zero, that average is
one. If rank A_i is one, the two image values are 0 and one, giving average
zero. Rank two gives (1−3)/4=−1/2. The required singleton averages therefore
force every A_i to be invertible.

Conversely, suppose (R2) holds. On every nonempty coordinate subspace V_S,
the map Σ_(i∈S) A_i p_i is surjective because at least one summand is
invertible. A uniform input pushes forward to the uniform law on F₂².
Each nonempty-subspace phase average is therefore −1/2, while the empty
one is one. Averaging proves equality in (R1). □

The restriction ℓ≥1 matters. At ℓ=0 the bound is the trivial equality 1=1
and there is no rank-two quotient.

#### 3. Compatibility with the source's nondegenerate quadratic form

In the opposite-sign lemma the auxiliary function is R=Q*+Q₀, where Q*
has nondegenerate polar form and

    Q₀(p)=Σ_i Q_aniso(p_i).

Assume equality (R2). Make the invertible local changes y_i=A_i p_i.
Every GL(2,2) matrix preserves Q_aniso, because it permutes the three
nonzero vectors. Hence in the y coordinates

    Q*(y)=Σ_i Q_aniso(y_i)+Q_aniso(Σ_i y_i).                 (R3)

Let J=[[0,1],[1,0]]. The polar form of (R3), evaluated at y,z, is

    Σ_i y_i^T J z_i + (Σ_i y_i)^T J (Σ_i z_i).

A vector y is in its radical exactly when, for every j,

    y_j + Σ_i y_i = 0.

Thus every y_j is one common vector a, and the same equation becomes
(1+ℓ)a=0 in F₂². If ℓ is even, it forces a=0 and the polar form is
nondegenerate. If ℓ is odd, every a is possible, producing a two-dimensional
radical. Therefore nondegeneracy of Q* is compatible with exact equality
in the **unrounded** bound precisely for even ℓ.

This is an explicit parity obstruction, not an additional assumption. For
odd ℓ, the source takes an integer floor in its opposite-sign count; the
rounded optimum can be attained without equality in (R1). Its structural
analysis therefore requires a near-equality classification, and the lemma
above cannot simply be reused as an equality theorem for that case.

#### 4. Use of the equality condition

1. The source applies the opposite-sign argument after choosing a paired
   information set in each affine preimage H^(−1)(δ_H+V_T). Equality in the
   projected count also requires that the relevant projected labels lift
   to full-support inputs. Formula (R2) alone does not ensure this.
2. Equality must hold compatibly for all support sets T contributing with
   positive coefficient to the total score. Separate normal forms on
   different subspaces need not glue to a global symplectic normal form.
3. For even k, those support sizes are odd, so the integer-rounding gap and
   its possible equality patterns must be characterized.
4. Even a complete optimizer classification must be connected to CNOT
   lower bounds against arbitrary allowed circuits, not just decompositions
   that follow U_*'s displayed two-rotation form.
5. The cut-rank obstruction for one fixed U_* is insufficient for the
   minimum over all optimizers. The k=2 alternative U_Z is a concrete
   counterexample to that shortcut.

Accordingly, this note is a proved starting lemma and a map of the remaining
obligations. It is not a claim that the full problem is solved, nor a claim
of external novelty for an equality analysis that follows the source's
proof closely. Its value would come from the eventual compatible global
classification and exact resource theorem, if those can be established.


---

## Appendix B. Necessary physical block ranks

**Scope note.** This appendix presents a preliminary result. Sections 2–7 state the combined conclusions.


### Necessary block ranks for every shadow-optimal Clifford

This appendix proves necessary
structure and nonsharp gate bounds. It does not determine the exact all-k
minimum or a sufficient optimizer classification. The source score identities
and support-count bounds are credited to Nie–Zhang–Wu–Chen,
[arXiv:2610.04621v2](https://arxiv.org/abs/2610.04621v2), equations (17), (20),
(22) and (24).

#### 1. Notation and saturation

Use interleaved binary coordinates $(x_1,z_1,\ldots,x_k,z_k)$, with

```math
J=\operatorname{diag}(J_2,\ldots,J_2),\quad
J_2=\begin{pmatrix}0&1\\1&0\end{pmatrix},\qquad
Q_0(p)=\sum_j(x_j+z_j+x_jz_j).
```

Thus $Q_0(p)$ is Pauli support parity, its polar form is
$B(p,q)=p^TJq$, and $Q_0(Jp)=Q_0(p)$. Let $M$ attain the source
maximum $s_k$, and put $H=M^{-1}$. The source defines the unique shift
$\delta=\delta_H$ by

```math
Q_0(H^{-1}y)+Q_0(y)=B(\delta,y).
\tag{1}
```

For $T\subseteq[k]$, let

```math
N_T=\#\{p\in(\mathbb F_2^2\setminus\{0\})^k:
                    Hp+\delta\text{ is supported inside }T\}.
```

The published score identity is

```math
S_k(M)=3^k+
2\sum_{\substack{T\subseteq[k]\\ k-|T|\ {\rm odd}}}
2^{k-|T|}N_T.
\tag{2}
```

Each summand is bounded above by the source's equation (22); inserting all
those upper bounds yields exactly $s_k$. Their coefficients are positive.
Therefore $S_k(M)=s_k$ forces equality in each relevant count, in particular
for $T=[k]\setminus\{i\}$:

```math
N_{[k]\setminus\{i\}}=
\begin{cases}
(3^k-3)/4,& k\text{ odd},\\
(3^k-5)/4,& k\text{ even}.
\end{cases}
\tag{3}
```

This use of simultaneous saturation is a consequence of the published proof,
not an independently new upper bound.

#### 2. The parity shift fixes all Fourier signs

Let $r_x,r_z$ be the two rows of $H$ at site $i$. Since $H$ is
symplectic,

```math
H^{-1}=JH^TJ,\qquad B(r_x,r_z)=1.
```

Evaluating (1) at $e_{z,i}$ and at $e_{x,i}$, respectively, gives

```math
\delta_{x,i}=Q_0(r_x)+1,\qquad
\delta_{z,i}=Q_0(r_z)+1.
\tag{4}
```

For example $H^{-1}e_{z,i}=Jr_x^T$, so the first equality uses
$Q_0(Jr_x^T)=Q_0(r_x)$. The dot-product and symplectic pairing conventions
must be kept distinct in this step.

For $u=(u_x,u_z)\in\mathbb F_2^2\setminus\{0\}$, define the integer
```math
w_u=\operatorname{wt}(u_xr_x+u_zr_z).
```
Its parity is
```math
w_u=u_xQ_0(r_x)+u_zQ_0(r_z)+u_xu_z\pmod2.
```
Combining with (4) proves

```math
u\cdot\delta_i+w_u=u_x+u_z+u_xu_z=1\pmod2.
\tag{5}
```

Thus the three nontrivial Fourier signs are all negative. Allowing an
arbitrary affine shift would lose this restriction and create spurious
positive-sign alternatives. The actual shift in the source is fixed by (1).

Fourier orthogonality on the output pair, followed by independent summation
over the three nonzero labels of each input pair, now gives the exact identity

```math
N_{[k]\setminus\{i\}}
=\frac14\left(3^k-\sum_{u\ne0}3^{k-w_u}\right).
\tag{6}
```

Indeed, the local character sum is $3$ when the corresponding input
functional vanishes and $-1$ otherwise; its sign together with the affine
character is precisely (5).

#### 3. Necessary block-rank pattern

Partition $H$ into $2\times2$ blocks $H_{ij}$.

**Proposition.** For any maximizing symplectic map $M$, the following hold
for $H=M^{-1}$, and equivalently for $M$ itself:

- If $k\ge3$ is odd, every $2\times2$ block is invertible.
- If $k\ge2$ is even, every block has rank one or two. The rank-one blocks
  occupy exactly one position in every block row and every block column.

*Proof.* Comparing (3) with (6) gives

```math
\sum_{u\ne0}3^{k-w_u}=
\begin{cases}3,&k\text{ odd},\\5,&k\text{ even}.\end{cases}
\tag{7}
```

All three exponents are nonnegative integers. In the odd case all three are
zero. Thus for every nonzero $u$, the row $uH_{ij}$ is nonzero at every
input block $j$; each $H_{ij}$ has trivial left kernel.

In the even case the exponents are a permutation of $(0,0,1)$, because
the only expression of 5 as a sum of three nonnegative powers of 3 is
$3+1+1$. A rank-zero block contributes three missing characters, a rank-one
block one, and an invertible block none. There is exactly one missing
character in total. Hence each block row has exactly one rank-one block
and all remaining blocks are invertible.

For any block column $j$, the diagonal block of $H^TJH=J$ says

```math
\sum_i H_{ij}^TJ_2H_{ij}=J_2,\qquad
\sum_i\det(H_{ij})=1\quad\text{in }\mathbb F_2.
\tag{8}
```

If $r_j$ is its number of rank-one blocks, this is $k-r_j=1\pmod2$.
For even $k$, each $r_j$ is a positive odd integer. There are exactly
$k$ rank-one blocks altogether and $k$ columns, so every $r_j=1$.

Finally $H_{ij}=J_2M_{ji}^TJ_2$, which preserves rank. Transposition of
the block pattern transfers both assertions to $M$. $\square$

The proposition is **necessary**, not sufficient. In particular it does not
establish that all optimizers belong to the dual-axis circuit's local
equivalence class.

#### 4. Universal, nonsharp CNOT consequences

**Corollary.** For $k\ge3$, every optimizer has cross-block rank at least
two across every nontrivial physical bipartition. Consequently its ancilla-free
implementation with free single-qubit Cliffords satisfies

```math
g_{P_k}(k)\ge2(k-1),\qquad g_{K_k}(k)\ge k.
\tag{9}
```

*Proof.* For odd $k$, any $2\times2$ block in a nontrivial cross rectangle
is invertible. For even $k\ge4$, the rank-one entries form a permutation
pattern. If one side of the cut has at least two sites, a row or column of
the cross rectangle contains an invertible block; a rectangle consisting
of just one block would require $k=2$. In either case the full cross
matrix has rank at least two.

For any two matrices and bipartition $A|B$,
```math
(XY)_{AB}=X_{AA}Y_{AB}+X_{AB}Y_{BB},\quad
\operatorname{rank}(XY)_{AB}
\le\operatorname{rank}X_{AB}+\operatorname{rank}Y_{AB}.
```
A local gate or CNOT inside a part has cross rank zero, while a CNOT across
the cut has cross rank one. Therefore at least two CNOT gates cross every
cut. On a path each of its $k-1$ edges is the sole edge crossing its
associated prefix cut, giving the first bound. On complete connectivity,
each singleton cut has degree at least two in the interaction multigraph;
counting the two endpoints of every CNOT gives the second bound. $\square$

The $k=2$ exception remains $g_{K_2}(2)=g_{P_2}(2)=1$, already known from
the source's one-CNOT optimizer. These general lower bounds need not be
sharp: the finite $k=3$ enumeration gives 4 and 5, respectively, exceeding
the displayed lower bounds 3 and 4.

#### 5. Scope of the block-rank criterion

The necessary rank criterion and the product-measure equality lemma in
Appendix A are inputs to the classification. The compatibility constraints
for larger support sets appear in Appendices C and D. Sharp synthesis
bounds require separate proofs.


---

## Appendix C. Complete odd-order classification

**Scope note.** This appendix presents a preliminary result. Sections 2–7 state the combined conclusions.


### Complete odd-order optimizer classification

This appendix proves the odd-order structural classification, with a finite
exact certificate for the exceptional five-qubit case. Appendix D treats even
orders. The counterexamples below explain the limits of the rank criterion
before the global theorem in Sections 7–10.

The score identity and upper bounds used here are those of
Nie–Zhang–Wu–Chen, [arXiv:2610.04621v2](https://arxiv.org/abs/2610.04621v2),
equations (17), (20), (22), and (24). Their specialization and the necessary
block-rank theorem are recorded in Appendix B.
All new calculations below are over the binary field unless otherwise stated.

#### 1. Setup and the precise remaining question

Let $M\in\operatorname{Sp}(2k,2)$, partitioned into physical $2\times2$
blocks, and let $H=M^{-1}$. Write

```math
q(x,z)=x+z+xz,\qquad Q_0(p)=\sum_iq(p_i),\qquad
J_2=\begin{pmatrix}0&1\\1&0\end{pmatrix}.
```

The score is
```math
S_k(M)=\sum_{p\in(\mathbb F_2^2\setminus\{0\})^k}
                   3^{k-\operatorname{wt}(Mp)}.
```
For odd $k$, the known maximum is
```math
s_k=\frac{3\cdot5^k+3^k-6}{4}.
```
For the parity-correction shift $\delta_H$ specified by the source, put
```math
N_T=\#\{p\text{ of full support}:Hp+\delta_H\in V_T\}.
```
When $k$ is odd, only even $|T|$ enter the positive-coefficient score
identity. Its sharp termwise bounds are
```math
N_T\le f(|T|),\qquad f(\ell)=\frac{3^{\ell+1}-3}{4}
\quad(\ell\text{ even}).                                      \tag{1}
```
Consequently, attaining every bound in (1) is sufficient and necessary for
optimality. The previous necessary-rank result shows that every block of
an odd-order optimizer is invertible.

Our aim here is to extract additional structure, rather than rename the
simultaneous conditions (1) as a classification.

#### 2. Every dense-block symplectic map has zero parity shift

Call a symplectic map **dense in physical blocks** when every one of its
$2\times2$ blocks is invertible. This is only a shorthand for this
explicit algebraic property.

**Lemma 1.** If $k$ is odd and $M$ is dense in physical blocks, then
$Q_0(Mp)=Q_0(p)$ for every $p$, and $\delta_H=0$.

*Proof.* The polar forms of $Q_0\circ M$ and $Q_0$ agree because
$M$ is symplectic. Their difference is therefore linear. Each binary
basis vector has support one, while its image under $M$ has support
$k$, since every block in the relevant block column is invertible.
The two quadratic forms agree on every basis vector because $k$ is odd.
The linear difference vanishes identically. The defining equation for
$\delta_H$ now gives zero. $\square$

In particular,
```math
N_T=\#\{y\in V_T:My\text{ has full support}\}.                 \tag{2}
```
The inverse is also dense, because
$H_{ij}=J_2M_{ji}^{\mathsf T}J_2$.

#### 3. Two-site counts are automatically sharp at every odd order

**Lemma 2.** Let $k\ge3$ be odd and let $M$ be symplectic and dense
in physical blocks. For every two-element support set $T$,
```math
N_T=6.                                                        \tag{3}
```

*Proof.* Write the two selected block columns as $(A_j)_j$ and
$(B_j)_j$. Thus the output at physical site $j$ of an input
$(u,v)\in V_T$ is $A_ju+B_jv$. Every $A_j,B_j$ is invertible.
Column symplectic orthogonality gives
```math
\sum_jA_j^{\mathsf T}J_2B_j=0.
```
For a binary invertible $2\times2$ matrix,
$A_j^{\mathsf T}J_2=J_2A_j^{-1}$. Therefore, with
$C_j=A_j^{-1}B_j$,
```math
\sum_j C_j=0.                                                \tag{4}
```
If exactly one of $u,v$ is nonzero, the output has full support. This
accounts for six inputs. If both are nonzero, each $C_jv$ is one of the
three nonzero binary two-vectors, and their sum is zero by (4). If their
multiplicities are $n_1,n_2,n_3$, the zero-sum condition says that all
three multiplicities have the same parity. Their sum is the odd number
$k$, so all three multiplicities are odd and hence positive. One of
these vectors is $u$; for its index $j$,
$A_ju+B_jv=A_j(u+C_jv)=0$. Such an input cannot have full output
support. The zero input also fails. This proves (3). $\square$

**Theorem 3 (complete criterion at orders one, three, and five).** For
$k\in\{1,3,5\}$, a symplectic map is shadow-optimal if and only if all
of its physical $2\times2$ blocks are invertible.

*Proof.* Necessity is the previous block-rank theorem (and is automatic
for $k=1$). For sufficiency, Lemma 1 gives $N_\varnothing=0=f(0)$.
Lemma 2 gives $N_T=6=f(2)$ when $|T|=2$. The marginal Fourier
identity from the necessary-rank proof gives
```math
N_{[k]\setminus\{i\}}=(3^k-3)/4=f(k-1)
```
whenever every block is invertible. These account for every even support
size below $k$ when $k=1,3,5$: respectively $0$, $0,2$, and
$0,2,4$. Hence every contributing source bound is attained. $\square$

This is a sufficient structural criterion in these orders, rather than a
restatement of the support-count equalities. Section 6 shows exactly why
it cannot be extrapolated to all odd orders.

#### 4. A five-qubit optimizer outside the dual-axis local class

Let
```math
I=\begin{pmatrix}1&0\\0&1\end{pmatrix},\quad
A=\begin{pmatrix}1&1\\0&1\end{pmatrix},\quad
B=\begin{pmatrix}0&1\\1&0\end{pmatrix},\quad
C=\begin{pmatrix}1&0\\1&1\end{pmatrix}.
```
The three matrices $A,B,C$ are the transpositions in
$\operatorname{GL}(2,2)\cong S_3$. They satisfy
```math
A^2=B^2=C^2=I,\qquad A+B+C=0.
```
Products of distinct members are the two order-three matrices $R,R^2$,
and $I+R+R^2=0$. Consider the following $5\times5$ block matrix:
```math
K=\begin{pmatrix}
I&I&I&I&I\\
I&I&A&B&C\\
I&A&I&C&B\\
I&B&C&I&A\\
I&C&B&A&I
\end{pmatrix}.                                               \tag{5}
```

**Proposition 4.** The matrix $K$ is symplectic and optimal, but cannot
be transformed into the source's dual-axis optimizer by input and output
single-qubit Cliffords, even if independent input and output qubit
permutations are additionally allowed for the purpose of comparison.

*Proof of symplecticity and optimality.* For block rows $r,s$, the
symplectic product is
$\sum_j K_{rj}K_{sj}^{-1}J_2$. A row with itself gives $5J_2=J_2$.
The first row with any other gives
$(I+I+A+B+C)J_2=0$. For two different rows among the last four, the
sum of matrix products is $I+D+D+R+R^2=0$, where $D$ is one of the
three transpositions. Thus $KJK^{\mathsf T}=J$. Every block is
invertible, so Theorem 3 proves optimality. In particular,
```math
S_5(K)=s_5=2403.
```

*Proof of inequivalence.* For $D\in\operatorname{GL}(2,2)$, write
$\epsilon(D)\in\mathbb F_2$ for the parity of its permutation of the
three nonzero labels. It is a homomorphism. For a dense-block matrix
$M$, form its binary block-sign matrix $e_{ij}=\epsilon(M_{ij})$.
A local input/output change sends
```math
e_{ij}\longmapsto e_{ij}+a_i+b_j.
```
Therefore every rectangle parity
```math
\rho_{ih;jl}=e_{ij}+e_{il}+e_{hj}+e_{hl}                       \tag{6}
```
is unchanged. Independent row and column permutations only relabel the
rectangle parities, so the statement that all rectangle parities vanish
is also invariant under such permutations.

For odd $k$, the source's dual-axis map
$x_i'=x_i+\sum_jz_j+\sum_jx_j$,
$z_i'=z_i+\sum_jx_j$
has order-three blocks on and off the diagonal. All their permutation
parities are zero, so every rectangle parity is zero. For $K$, the
first block row and column contain only $I$, whereas $K_{23}=A$
has parity one. The rectangle on rows $1,2$ and columns $1,3$
therefore has parity one. This proves inequivalence. $\square$

This invariant concerns equivalence classes of matrices only. Permutations
have **not** been declared free gates in the circuit resource model.
Indeed, the inequivalence statement remains true after granting more
freedom for comparison than the synthesis model permits.

#### 5. An exhaustive finite certificate at order five

A separate exact enumeration supports the stronger finite statement that
there are exactly **two** equivalence classes at $k=5$ under local
input/output Cliffords and independent input/output qubit permutations.
One contains the dual-axis map, and the other contains (5). This section
is explicitly a finite computational certificate; no all-order theorem
is inferred from it.

Here is why the enumeration is complete. Left and right multiplication by
local $\operatorname{GL}(2,2)$ matrices can make the first block row
and first block column all $I$. All remaining rows begin with $I$
and have four arbitrary entries from the six-element group. Orthogonality
to the first row is precisely that the five matrices sum to zero; inversion
on $2\times2$ determinant-one matrices is linear, so using the matrices
rather than their inverses in this zero-sum test is equivalent. Two such
rows are symplectically orthogonal exactly when
$\sum_j r_js_j^{-1}=0$. Self-pairing is automatically correct because
there are five invertible blocks. Consequently, unordered four-cliques
in this finite row-compatibility graph enumerate all normalized matrices
up to permutation of the last four rows.

The enumeration finds 40 such cliques, hence 960 ordered normalized
matrices. Equivalence under row/column permutations and the remaining
common conjugation reduces the 40 representatives to classes of sizes
10 and 30. The first has zero rectangle parities; the second does not.
For (5), independently summing all 243 full-support inputs gives the
output-weight histogram
```math
\#\{p:\operatorname{wt}(Kp)=w\}=
\begin{cases}15,&w=1,\\120,&w=3,\\108,&w=5,\\0,&\text{otherwise.}\end{cases}
```
This verifies $15\cdot81+120\cdot9+108=2403$.

The following standard-library Python certificate can be executed as
written. It constructs all six group elements itself, checks completeness
through the stated clique construction, and performs the entire finite
equivalence reduction. It does not depend on a heuristic synthesis or a
floating-point score calculation.

```python
from itertools import product, permutations
from collections import defaultdict, Counter

# Matrix columns are two-bit integers; bit 0 is x, bit 1 is z.
G = [(a, b) for a in (1, 2, 3) for b in (1, 2, 3) if a != b]
I = G.index((1, 2))
def act(A, x):
    return (A[0] if x & 1 else 0) ^ (A[1] if x & 2 else 0)
P = [[G.index((act(a, b[0]), act(a, b[1]))) for b in G] for a in G]
inv = [next(j for j in range(6) if P[i][j] == I) for i in range(6)]
enc = [a | (b << 2) for a, b in G]
def xor(values):
    s = 0
    for x in values:
        s ^= x
    return s

k = 5
rows = [(I,) + tail for tail in product(range(6), repeat=k-1)
        if xor(enc[x] for x in ((I,) + tail)) == 0]
def orth(r, s):
    return xor(enc[P[a][inv[b]]] for a, b in zip(r, s)) == 0
adj = [{j for j in range(i+1, len(rows)) if orth(r, rows[j])}
       for i, r in enumerate(rows)]
cliques = []
def visit(chosen, candidates):
    if len(chosen) == k-1:
        cliques.append(chosen)
        return
    need = k-1-len(chosen)
    for t, i in enumerate(candidates):
        if len(candidates)-t < need:
            break
        visit(chosen+[i], [j for j in candidates[t+1:] if j in adj[i]])
visit([], list(range(len(rows))))
mats = [((I,)*k,) + tuple(rows[i] for i in c) for c in cliques]
assert len(mats) == 40

def dephase(m):
    x = [[P[m[i][j]][inv[m[0][j]]] for j in range(k)] for i in range(k)]
    return tuple(tuple(P[inv[x[i][0]]][x[i][j]] for j in range(k))
                 for i in range(k))
def canonical(m):
    best = None
    for top in range(k):
        r = [m[top]] + [m[i] for i in range(k) if i != top]
        for cp in permutations(range(k)):
            d = dephase([[row[j] for j in cp] for row in r])
            for g in range(6):
                z = [tuple(P[P[g][a]][inv[g]] for a in row) for row in d]
                key = tuple([z[0]] + sorted(z[1:]))
                if best is None or key < best:
                    best = key
    return best
orbits = defaultdict(list)
for m in mats:
    orbits[canonical(m)].append(m)
assert sorted(map(len, orbits.values())) == [10, 30]

A, B, C = (G.index(x) for x in ((1,3), (2,1), (3,2)))
K = ((I,I,I,I,I), (I,I,A,B,C), (I,A,I,C,B),
     (I,B,C,I,A), (I,C,B,A,I))
hist = Counter()
for p in product((1,2,3), repeat=k):
    out = [xor(act(G[a], v) for a,v in zip(row,p)) for row in K]
    hist[sum(x != 0 for x in out)] += 1
assert hist == {1:15, 3:120, 5:108}
assert sum(n * 3**(k-w) for w,n in hist.items()) == 2403
print('normalized row-cliques:', len(mats))
print('equivalence-class sizes:', sorted(map(len, orbits.values())))
print('second-class output-weight histogram:', dict(sorted(hist.items())))
```

#### 6. A nine-qubit counterexample to all-order rank sufficiency

Let $\mathbb F_4=\{0,1,\omega,\omega^2\}$, where
$\omega^2+\omega+1=0$, and identify one binary physical pair with
$\mathbb F_4$. The alternating pairing is
$B(a,b)=\operatorname{Tr}_{\mathbb F_4/\mathbb F_2}(a\bar b)$.
Let
```math
F=\begin{pmatrix}1&1&1\\1&\omega&\omega^2\\1&\omega^2&\omega\end{pmatrix},
\qquad L=F\otimes F.                                         \tag{7}
```
Here conjugation exchanges $\omega$ and $\omega^2$. Directly,
$FF^\dagger=I$: diagonal inner products are $1+1+1=1$, and
other inner products are $1+\omega+\omega^2=0$. Thus $L$ is
unitary over $\mathbb F_4$ and preserves the displayed binary
symplectic form. Every matrix entry is nonzero, so multiplication by it
is an invertible binary $2\times2$ block. This gives a dense-block
symplectic map on nine qubits.

Index its sites by $(r,s)\in\{0,1,2\}^2$, and choose the four-site
input support set
```math
T=\{(0,0),(0,1),(0,2),(1,0)\}.
```
An input supported in $T$ has values $(a,b,c)$ in its first row and
value $d$ at $(1,0)$. If
$(A_0,A_1,A_2)^{\mathsf T}=F(a,b,c)^{\mathsf T}$, its output is
```math
(Ly)_{r,s}=A_s+\lambda_r d,\qquad
(\lambda_0,\lambda_1,\lambda_2)=(1,\omega,\omega^2).
```
When $d=0$, full support is equivalent to all three $A_s\ne0$,
giving exactly 27 inputs because $F$ is invertible. When $d\ne0$,
the three values $\lambda_rd$ exhaust the three nonzero field
elements. Full support for every $r$ therefore requires each
$A_s=0$, and this gives exactly three inputs, one for each nonzero
$d$. Consequently,
```math
N_T=27+3=30<60=f(4).                                         \tag{8}
```
By Lemma 1 there is no affine shift to account for. The positive coefficient
of this count in the source score identity makes $L$ strictly
suboptimal. Thus invertibility of every block, even together with exact
symplecticity and preservation of support parity, is insufficient in
general.

For an optional numerical cross-check using only finite field arithmetic,
its full-input output-weight histogram is
```math
(w,n_w)=(1,27),(3,216),(5,4860),(7,11664),(9,2916),
```
and hence $S_9(L)=836163<1469763=s_9$. The proof of strict
suboptimality is the direct count (8), so it does not rely on this larger
enumeration.

#### 7. A linear avoidance lemma

The equality and lifting conditions yield more than the block ranks when
an information set has at least three sites.

**Lemma 5 (linear avoidance).** Let $\ell\ge3$, let
$B_i:\mathbb F_2^2\to\mathbb F_2^2$ be linear, and suppose that
```math
\left[\ y_i\ne0\ (1\le i\le\ell),\quad
              \sum_i B_i y_i=0\ \right]
       \Longrightarrow \sum_i y_i=0.                         \tag{9}
```
Then exactly one of the following forms holds, for some
$C\in\operatorname{GL}(2,2)$:
```math
\sum_iB_i y_i=C y_j\quad\text{for one }j,
\qquad\text{or}\qquad
\sum_iB_i y_i=C\sum_i y_i.                                   \tag{10}
```
Conversely, both forms satisfy (9).

*Proof.* The image of the three nonzero local labels under a matrix of
rank zero, one, or two is respectively
$\{0\}$, $\{0,a\}$ for a nonzero $a$, or the three nonzero
vectors. The sum of two rank-two image sets is the whole plane, as is
the sum of a rank-two image set with a rank-one image set.

Suppose first that some $B_j=0$. If a full-support zero of
$F(y)=\sum_iB_i y_i$ existed, changing its nonzero value $y_j$
would keep $F(y)=0$ but change $\sum_i y_i$. This contradicts
(9). Thus $F$ has no full-support zero. The image-set observations
show that this happens precisely when there is one rank-two block and
all other blocks are zero. With no rank-two block, choose local kernel
vectors to obtain zero; with two rank-two blocks, or a rank-two block
and a rank-one block, the sum image contains zero. This proves the first
form in (10) in this case.

Now suppose every $B_i\ne0$ and some $B_i$ has rank one. Let
$a_i$ be its nonzero image vector. A full-support zero with
$B_i y_i=a_i$ is impossible: its two local preimages are both nonzero
and differ by the nonzero kernel vector, so they give the same $F$
but different total sums. If any other block is invertible, there is a
third, nonzero block because $\ell\ge3$. Their image sets already
sum to the whole plane, and adding any further image sets leaves the
whole plane. They can therefore cancel $a_i$, a contradiction.
Hence all blocks would have rank one. Their image vectors must then
satisfy
$a_i\notin\operatorname{span}\{a_j:j\ne i\}$ for every $i$,
again because a representation of $a_i$ by other image vectors would
produce the forbidden zero. This would make at least three vectors
linearly independent in a two-dimensional space, which is impossible.
Thus every block is invertible.

Write $z_i=B_i y_i$ and $C_i=B_i^{-1}$. Condition (9) says
$\sum_i C_i z_i=0$ whenever every $z_i\ne0$ and
$\sum_i z_i=0$. Fix distinct indices $i,j$ and distinct nonzero
vectors $a,b$. Fill the other $\ell-2$ positions by nonzero
vectors summing to $a+b$. This is possible for one remaining position
and for every larger number: any prescribed nonzero total can be written
as a sum of that many nonzero binary two-vectors. Compare the resulting
zero-sum tuple with the tuple obtained by swapping $a,b$ at $i,j$.
The two identities imply
```math
(C_i+C_j)(a+b)=0.
```
Every nonzero vector arises as such a sum $a+b$, so $C_i=C_j$.
All $B_i$ are therefore one common invertible matrix. The converse
in (10) is immediate. $\square$

The restriction $\ell\ge3$ is essential. At $\ell=2$, two
rank-one blocks with a common kernel and independent image lines also
satisfy (9). These extra possibilities are compatible with the exceptional
five-qubit optimizer class in Section 4.

#### 8. Equality forces repeated coordinate or sum forms

Two surjective two-vector-valued linear maps are called proportional here
when one is an invertible $2\times2$ left multiple of the other.
This is an equivalence relation; it concerns binary linear maps, not
complex scalar multiples.

**Lemma 6 (local form and odd multiplicities).** Let $k$ be odd and
let $M$ be optimal. Fix an even-size input support set $T$ of
size $\ell\ge4$. There are coordinates
$y_1,\ldots,y_\ell\in\mathbb F_2^2$ on $MV_T$, obtained from a
paired information set followed by local invertible changes, in which
every physical output coordinate is an invertible left multiple of
exactly one of
```math
y_1,\ldots,y_\ell,\quad s=\sum_{i=1}^{\ell}y_i.              \tag{11}
```
Each of these $\ell+1$ forms occurs an odd number of times.

*Proof.* The physical-block criterion makes $\delta_H=0$, and the
source's paired information-set lemma supplies an invertible projection
of $MV_T$ onto $\ell$ physical pairs. Let $Q$ be the parity
quadratic expressed in those projected coordinates. It is nondegenerate,
vanishes at zero, and has Gauss sign $(-1)^\ell=1$. Optimality makes
both inequalities in the source's projection/opposite-sign bound equalities.
By the equality lemma in Appendix A, local
invertible changes make its Fourier dual
```math
Q^*(y)=Q_{\mathrm{std}}(y)
 :=\sum_i q(y_i)+q\left(\sum_i y_i\right).                    \tag{12}
```

For completeness, $Q_{\mathrm{std}}$ is its own normalized Fourier
dual under the physical symplectic pairing when $\ell$ is even.
The linear map associated with its polar form relative to that pairing
is $\mathcal T(y)_i=y_i+s$; it is an involution because $\ell$
is even. Moreover
$Q_{\mathrm{std}}(\mathcal T y)=Q_{\mathrm{std}}(y)$, using
$\sum_i B(y_i,s)=B(s,s)=0$. The source's normalized dual is the
original quadratic composed with the inverse of this polar map, proving
the claim. Local $\operatorname{GL}(2,2)$ changes preserve the
physical pairing, so duality commutes with those changes. Consequently
$Q$ itself is (12).

A projected full-support label has $\sum_iq(y_i)=\ell=0\pmod2$.
The projected opposite-sign points counted by the source are therefore
exactly
```math
y_i\ne0\ \text{for every }i,\qquad \sum_i y_i\ne0.
```
Equality in the projection bound says that every such point lifts to a
full-support point of $MV_T$. Each physical coordinate map $F$
thus obeys (9). Lemma 5 gives the forms (11), up to invertible left
multiples.

Let $m_i$ be the multiplicity of $y_i$, and let $m_0$ be the
multiplicity of $s$. Each $m_i$ for $i\ge1$ is positive
because that coordinate is present in the information set. As every
local invertible map preserves $q$, the parity identity on $MV_T$
becomes
```math
\sum_i(m_i\bmod2)q(y_i)+(m_0\bmod2)q(s)
       =\sum_iq(y_i)+q(s).                                   \tag{13}
```
Cross terms between two distinct physical variables force $m_0$ odd.
Restricting the remaining identity to each single variable then forces
every $m_i$ odd. In particular, the sum form also occurs. The forms
in (11) are distinct up to invertible left multiplication when
$\ell\ge2$. This proves the claim. $\square$

This lemma includes the lifting requirement that was absent from the
starting quadratic equality statement. It is the step that converts
separate quadratic equalities into restrictions on the actual physical
rows of $M$.

#### 9. All odd orders at least seven have the dual-axis normal form

**Theorem 7.** Let $k\ge7$ be odd. A symplectic map is optimal if and
only if it is obtained from the source's dual-axis map by local input and
output $\operatorname{GL}(2,2)$ transformations and input/output qubit
permutations.

*Proof: three coincident rows for every deleted input triple.* Take any
three-element input set $C$, and put $T=[k]\setminus C$. Then
$\ell=k-3$ is even and at least four, so Lemma 6 applies. There are
$\ell+1=k-2$ proportionality classes of physical coordinate maps
restricted to $V_T$, each of odd positive size, whose sizes sum to
$k$. Exactly one class has size three and every other class has size
one. Thus precisely three unordered pairs of physical rows become
proportional on $T$.

*Proof: a sharp double count for each pair of rows.* Fix two distinct
block rows $r,s$, and set
```math
C_j=M_{sj}M_{rj}^{-1}\in\operatorname{GL}(2,2),\qquad
n_D=\#\{j:C_j=D\}.
```
The ratio is well defined because every block is invertible. Row
symplectic orthogonality gives
```math
\sum_j C_j=0.                                               \tag{14}
```
For example, multiply the $(s,r)$ off-diagonal block of
$MJM^{\mathsf T}=J$ on the right by $J_2$, and use
$J_2M_{rj}^{\mathsf T}J_2=M_{rj}^{-1}$.

No $n_D$ can be $k$ or $k-1$. The first case makes (14)
$D=0$; the second leaves a single nonzero matrix after the even
number $k-1$ of equal terms cancel. Thus $n_D\le k-2$.
The pair $r,s$ is proportional on the complement of a deleted
triple exactly when all its $k-3$ ratios there are the same. Its
number of such input triples is therefore
```math
a_{rs}=\sum_{D\in\operatorname{GL}(2,2)}\binom{n_D}{k-3}.
```
Since $k\ge7$, two different counts cannot both be at least
$k-3$: their sum would exceed $k$. It follows that
```math
a_{rs}\le\binom{k-2}{k-3}=k-2,                              \tag{15}
```
with equality precisely when one $n_D=k-2$.

Counting the pairs over all deleted triples in the previous paragraph
gives
```math
\sum_{r \lt s}a_{rs}=3\binom{k}{3}
                =\binom{k}{2}(k-2).
```
This equals the sum of the individual upper bounds (15), so every pair
attains equality. For **every** two physical rows, their ratios are
constant on exactly $k-2$ columns and different on the remaining two.

*Proof: normalize the first row and locate a common star.* Right local
transformations make the first block row all $I$. For every other
row, a left local transformation makes its majority value $I$.
These local changes preserve every pair-ratio multiplicity, because each
ratio is transformed by the same left and right invertible factors.
The normalized row then has $I$ in exactly $k-2$ columns and two exceptional
entries $D,E$. By (14),
```math
I+D+E=0.
```
Since $D,E$ are invertible and not $I$, they are the two
order-three elements $R,R^2$ of $\operatorname{GL}(2,2)$.
Let $E_r$ be this row's exceptional two-element column set.

If two such sets are disjoint, the two rows' ratios equal $I$ at
$k-4$ positions and each of $R,R^2$ at two positions. This
contradicts the just-proved existence of a value occurring $k-2$
times. If the sets meet in one position but the entries there differ,
the ratios equal $I$ at $k-3$ positions and one nonidentity
order-three value at three positions, again a contradiction because
$k-2\ge5$. Therefore distinct sets intersect, and their common
position carries the same order-three entry.

Repeated exceptional sets also cannot occur. With the same assignment
of $R,R^2$, two block rows would be identical, contradicting
invertibility of $M$. With opposite assignments, any third row
would have to share one of their two columns and agree at the shared
position with two different entries, which is impossible; a disjoint
set is already excluded, and reusing the same set duplicates one of the
first two rows. There are at least six rows after the first, so this
exhausts the possibilities and excludes repetitions.

We have at least four distinct, pairwise-intersecting two-element sets.
Such a family has a common element: if $\{a,b\}$ and $\{a,c\}$
are present and a set avoids $a$, it must be $\{b,c\}$; no fourth
distinct two-element set can intersect all three. Hence the exceptional
sets form a star. There are exactly $k-1$ such rows, so their sets
are $\{c,j\}$ for every $j\ne c$. All entries at the common
center $c$ are the same order-three matrix, say $R$, and their
entries at their respective leaves are $R^2$.

Match the first block row with column $c$, and every other block row
with its unique leaf. Right-multiply column $c$ by $R^{-1}$.
The resulting matrix has $I$ off the diagonal and $R^2$ on the
diagonal. This is a local normalization of the odd-order dual-axis map:
its diagonal and off-diagonal blocks are the two order-three elements,
and a common right local factor makes the off-diagonal blocks $I$.
The two choices of the generator $R$ are related by conjugation with
any transposition in $\operatorname{GL}(2,2)$. This proves the
necessary normal form.

Conversely, the source proves that the dual-axis map is optimal. Local
input/output transformations and qubit permutations preserve the score:
input transformations permute the full-support labels, while output
transformations preserve every output support size. Hence every matrix
in the stated family is optimal. $\square$

The proof obtains a sufficient global normal form; it does not leave
higher support equalities as unclassified conditions.

#### 10. Complete odd-order classification and remaining resource obligations

For $k=3$, the normal form can also be obtained without enumeration.
Normalize the first block row and column to $I$. Each remaining row
is $(I,D,E)$, with $I+D+E=0$, and therefore is either
$(I,R,R^2)$ or $(I,R^2,R)$. The two rows must be different. This
is the single dual-axis class. At $k=1$, every map is local.

Combining this argument, Theorem 3, the complete certificate in Section 5,
and Theorem 7 gives the following classification under local input/output
Cliffords and independent input/output qubit permutations:

| Odd order | All optimizer classes |
|---|---|
| $k=1$ | One local class |
| $k=3$ | One class, represented by the dual-axis map |
| $k=5$ | Exactly two classes: the dual-axis map and (5) |
| Every odd $k\ge7$ | One class, represented by the dual-axis map |

The $k=5$ exhaustion is a finite exact certificate with a proved
normalization and equivalence reduction; the all-$k\ge7$ statement
is the analytic theorem above. No generic sampling or extrapolation
is used for the table.

The input/output permutation factors remain explicit in this structural
classification. They are **not** free gates in the circuit model. A
minimum over all optimizers must allow any member of the classified
family and still charge for every CNOT used to realize its actual
physical map. In particular, the classification by itself does not
transfer a synthesis lower bound for one fixed circuit to every class
member or prove an exact CNOT minimum.

Appendix D gives the even-order classification, including its exceptional
four-site case.
The standalone five-site certificate is
[odd_k5_classification_certificate.py](code/odd_k5_classification_certificate.py),
with its exact output in
[odd_k5_classification.json](results/odd_k5_classification.json).
The structural classification alone does not determine exact all-order
CNOT minima.


---

## Appendix D. Complete even-order classification

**Scope note.** This appendix presents a preliminary result. Sections 2–7 state the combined conclusions.


### Even-order optimizer classification and its four-site exception

**Status.** This note proves that every optimal Clifford at every even
`k>=6` lies in the dual-axis class under local input/output Cliffords and
independent input/output qubit permutations. The proof includes the exact
integer-rounded quadratic equality, its affine lifting condition, and a
global compatibility argument. At `k=2,4`, optimality is instead exactly
the rank-one-permutation/rank-two-elsewhere block criterion. A displayed
four-site optimizer is outside the dual-axis class even with independent
input/output permutations, so the low-order exception is essential.
An exact all-order CNOT gate-count theorem is **not** claimed here.

The score identity, optimal score and support-count bound used below are
from Nie–Zhang–Wu–Chen, [arXiv:2610.04621v2](https://arxiv.org/abs/2610.04621v2),
Section III and Appendix C. The non-rounded equality proof and the actual
parity-shift block-rank theorem are proved in Appendices A and B.

#### 1. Setup and the exact rounded equality level

Let `ell` be a positive odd integer, let

```math
V=(\mathbb F_2^2)^\ell,\qquad
q(a,b)=a+b+ab,\qquad Q_0(x)=\sum_iq(x_i),
```

and put `mu(0)=1/2`, `mu(v)=1/6` for the three nonzero local vectors. Suppose
`R:V -> F_2` is quadratic with `R(0)=0`, and write

```math
Z(R)=\mathbb E_{\mu^{\otimes\ell}}(-1)^{R}.
```

The source's real-valued lower bound is

```math
Z(R)\ge -\frac12+\frac32\,3^{-\ell}.
\tag{1}
```

For a nondegenerate quadratic function `Q`, normalize its constant term
without translating the physical arguments, and let `Q*` be the Fourier-dual
quadratic in source Eq. (C6). Then `Q*(0)=0`, `R=Q*+Q_0`, and the opposite-sign
count is

```math
C(Q)=\frac{3^\ell}{2}\bigl(1-Z(R)\bigr).
\tag{2}
```

For odd `ell`, equality in the source's **integer-rounded** bound

```math
C(Q)=\frac{3^{\ell+1}-5}{4}
```

is therefore equivalent to

```math
Z(R)=-\frac12+\frac52\,3^{-\ell}.
\tag{3}
```

The excess above (1) is exactly `3^(-ell)`. Replacing (3) by equality in (1)
would incorrectly exclude the even-`k` optimum.

#### 2. Classification of every rounded equality case

**Theorem 1 (one rank-one summand).** For positive odd `ell`, a quadratic
`R` vanishing at zero satisfies (3) if and only if there are linear maps
`A_i:F_2^2 -> F_2^2` such that

```math
R(x)=q\left(\sum_{i=1}^{\ell}A_i x_i\right),
\tag{4}
```

exactly one `A_i` has rank one and every other `A_i` is invertible. For
`ell=1`, this says precisely that `R` is a nonzero linear function.

*Proof.* Expand each local measure as

```math
\mu=\frac13\delta_0+\frac23\operatorname{Unif}(\mathbb F_2^2).
```

For `S subseteq [ell]`, let `a_S` be the uniform phase average of `R` on
the coordinate subspace `V_S`. Then

```math
Z(R)=3^{-\ell}\sum_{S\subseteq[\ell]}2^{|S|}a_S,
\qquad a_\varnothing=1.
\tag{5}
```

A quadratic phase average on a space of dimension `2s`, with zero constant
term, is zero or `+/- 2^(-r/2)`, where `r` is an even polar rank at most
`2s`. At rank zero the possible averages are zero and one. Hence, for
nonempty `S`,

```math
d_S:=2^{|S|}(a_S+1/2)
```

is a nonnegative integer. Subtracting the mixture's lower bound (1) from
(5) shows that (3) is exactly

```math
\sum_{\varnothing\ne S\subseteq[\ell]}d_S=1.
\tag{6}
```

There is exactly one exceptional nonempty set `S_0`, with `d_(S_0)=1`;
all other nonempty restrictions have average `-1/2`. If `s=|S_0|`, then

```math
a_{S_0}=-\frac12+2^{-s}.
```

For `s=1`, this is zero. For `s=2`, it is `-1/4`. For `s>=3`, it lies
strictly between `-1/2` and `-1/4`, so it is not an allowed quadratic
Gauss average. Thus `|S_0|` is one or two.

Suppose first that `ell>=3`. Its oddness means that the full set cannot
be this exception. The full-space phase average is `-1/2`, so `R` has
polar rank two, vanishes on its polar radical, and descends to the
anisotropic two-dimensional quadratic form `q`. Therefore `R=q o L`
for a surjective linear map `L:V -> F_2^2`; write
`L(x)=sum_i A_i x_i`. The average on a singleton coordinate is one, zero,
or `-1/2` according as the corresponding `A_i` has rank zero, one, or two.

If the exception were a pair, every singleton would have average `-1/2`,
so every `A_i` would be invertible. The map on that exceptional pair
would then be surjective as well, forcing its average to be `-1/2`, a
contradiction. The exception is consequently a singleton; its map has
rank one, while all other maps are invertible.

For `ell=1`, the equality value in (3) is `Z(R)=1/3`. Equation (5) then
gives zero for the uniform average `a_{ {1} }`. On the two-dimensional space, a quadratic form
with polar rank two has average `+/-1/2`. Average zero therefore means
polar rank zero and a nonzero linear function. Such a function can be
written `q(A_1 x_1)` with `A_1` any rank-one map onto a nonzero line whose
coefficient is that linear function.

Conversely, in (4) the exceptional singleton has average zero. Every
other nonempty coordinate subspace contains an invertible summand and
therefore maps onto `F_2^2`, giving average `-1/2`. Equation (5) then gives
exactly (3). This also covers `ell=1`. QED.

##### 2.1 Compatibility with the nondegenerate source quadratic

The condition in Theorem 1 automatically makes `Q*=Q_0+R` nondegenerate
when `ell` is odd. This is a useful consistency check, not an additional
assumption on the classified forms.

Let `J_2=[[0,1],[1,0]]`, let `D=diag(J_2,...,J_2)`, and write
`L=[A_1 ... A_ell]`. The polar matrix of `Q*` is

```math
K=D+L^TJ_2L.
```

If `Kv=0` and `s=Lv`, then `v_i=J_2 A_i^T J_2 s`. Therefore

```math
s=\sum_i A_iJ_2A_i^TJ_2s
 =\left(\sum_i\det A_i\right)s=0,
```

because there are `ell-1` invertible summands, an even number. It follows
that `v=0`. The argument uses the two-dimensional identity
`A J_2 A^T=(det A)J_2`, valid also for singular `A`.

##### 2.2 The separate lifting condition remains necessary

For an optimal symplectic map, the source counts full-support points in
an affine symplectic subspace and projects onto a paired information set.
The bound is a chain

```math
N_T\le C(Q)\le\frac{3^{\ell+1}-5}{4}.
```

When the endpoints are equal, Theorem 1 applies to **every** choice of
paired information set, and every projected opposite-sign point must
lift to a full-support point. Conversely, a rounded equality form for
one projected quadratic does not by itself verify that lifting property
or compatibility across different supports.

#### 3. A necessary condition on all odd paired minors

Partition a symplectic optimizer `M` into physical `2 x 2` blocks. For
even `k`, the previously proved necessary rank pattern has one rank-one
block in every block row and column and all other blocks invertible.
Permute the block columns so that the rank-one blocks are on the diagonal.
This relabeling preserves the optimization problem; it is **not** a free
circuit operation in a gate-cost claim.

For sets `I,T subseteq [k]`, `M_(I,T)` denotes the matrix with both
coordinates of every chosen input/output site retained.

**Theorem 2 (odd information sets differ by one site).** Let `k` be even
and let `M` be optimal with the rank-one positions on the diagonal. If
`|I|=|T|=ell` is odd and the paired minor `A=M_(I,T)` is invertible, then

```math
|I\setminus T|=|T\setminus I|=1.
\tag{7}
```

*Proof.* Put `H=M^(-1)` and use the source affine subspace
`M(delta_H+V_T)`. Invertibility of `A` makes projection onto the physical
pairs `I` an affine bijection. Write the projected quadratic as `Q`.
Its polar matrix is

```math
K=A^{-T}J_TA^{-1},
```

because its unprojected parameter has quadratic parity `Q_0` on `T`.
The source uses the physical symplectic pairing for Fourier duality, so
the dual quadratic has polar matrix

```math
K^*=J_IK^{-1}J_I=J_IAJ_TA^TJ_I.
```

Consequently the polar matrix of `R=Q*+Q_0` is

```math
B_R=J_I+J_IAJ_TA^TJ_I
   =J_IM_{I,T^c}J_{T^c}M_{I,T^c}^TJ_I.
\tag{8}
```

The last identity is the `I x I` principal part of `MJM^T=J`.
Optimality saturates the source count for this odd `ell`, and therefore
saturates the projected opposite-sign count as explained in Section 2.2.
Theorem 1 implies that the `ell` diagonal `2 x 2` blocks of `B_R` consist
of exactly one zero block and `ell-1` copies of `J_2`.

On the other hand, (8) and the determinant identity give, for `i in I`,

```math
(B_R)_{ii}=
\left(\sum_{j\in T^c}\det M_{ij}\right)J_2.
```

Since `|T^c|=k-ell` is odd and the only zero determinant in block row `i`
is at `j=i`, this diagonal block is zero precisely when `i in T^c`.
There must be exactly one such `i`, proving (7). QED.

Thus any odd-order paired submatrix whose row and column sets are equal,
disjoint, or differ in at least two sites is singular. The disjoint case
has a one-site exception: a `1 x 1` off-diagonal block is invertible and
its sets do differ by exactly one site. For `ell=3`, the theorem excludes
invertibility when the two three-site sets have intersection zero, one,
or three. This restriction first adds information beyond the existing
block-rank pattern when `k>=6`.

Equation (8) contains additional information beyond (7): whenever such
an odd minor is invertible and `ell>=3`, its complementary Gram matrix
has rank exactly two and an anisotropic quadratic refinement, with one
rank-one local summand in the representation of Theorem 1. The rank-only
or determinant-only statements should not replace that refinement when
attempting sufficiency.

#### 4. The actual parity shifts have full support

For any symplectic map `H` with the even-`k` block-rank pattern, the
source's shift satisfies

```math
\delta_{H,i} = \text{the nonzero image vector of the unique rank-one
block in row }i.
\tag{9}
```

Indeed, write that block as `a b^T` with `a,b` nonzero. Each of the other
`k-1` blocks is invertible, so its first row and second row are both
nonzero. The first full row of `H` has support parity `1+a_x`, and the
second has support parity `1+a_z`. The actual-shift formulas
`delta_(i,x)=Q_0(r_x)+1` and `delta_(i,z)=Q_0(r_z)+1` give `delta_(H,i)=a`.
In particular, `delta_H` has full physical support.

Also,

```math
M\delta_H=\delta_M,\qquad M=H^{-1}.
\tag{10}
```

To see this, substitute `H x` for `y` in the defining shift identity,
and use symplectic invariance of the pairing. The linear function
`Q_0(Hx)+Q_0(x)` is represented by both `M delta_H` and `delta_M`.
Nondegeneracy of the pairing proves (10). The inverse has the same
rank pattern, so `delta_M` has full support too. Consequently the point

```math
p=\delta_M\in F_k
```

has affine output `Hp+delta_H=0`. It belongs to every support count, so
`N_T>=1` for every `T`.

##### 4.1 A complete small-size sufficiency statement

**Corollary 3.** For `k=2` or `k=4`, a symplectic map is optimal if and
only if its blocks have rank one exactly on a permutation pattern and
rank two elsewhere.

Necessity is the prior theorem. For `k=2`, the contributing support
sizes are only `ell=1`; for `k=4`, they are `ell=1,3`. The counts with
`ell=k-1` saturate by the exact Fourier formula in
Appendix B. At `ell=1`, the source cap is one and the
full-support shift point above already supplies one. Thus every term
in the positive score expansion reaches its cap. This proves
sufficiency, without an exhaustive symplectic-group enumeration.

This corollary is used below to certify a counterexample. It is not
presented as the intended all-`k` research outcome.

#### 5. Exact counterexample to the universal dual-axis normal form

Use interleaved `(x_1,z_1,...,x_4,z_4)` coordinates and let

```math
C=\begin{pmatrix}
0&1&1&1&0&1&1&0\\
0&0&0&1&1&1&0&1\\
0&1&1&0&0&1&0&1\\
1&0&1&0&1&1&1&1\\
1&1&1&0&0&0&1&0\\
0&1&1&1&1&0&0&1\\
0&1&0&1&1&1&0&0\\
1&1&1&1&0&1&0&1
\end{pmatrix}.
\tag{11}
```

For reproducibility its bit-packed rows, with coordinate zero the least
significant bit, are `(110,184,166,245,71,158,58,175)`.

Direct binary multiplication gives `C J C^T=J`. The diagonal `2 x 2`
blocks have rank one, while all twelve off-diagonal blocks are
invertible. Corollary 3 therefore proves that `C` is optimal. Independent
direct evaluation over the `3^4=81` full-support input labels gives

```math
S_4(C)=449=s_4.
```

For even `k`, the standard dual-axis symplectic map can be written

```math
D_k=I_{2k}+\mathbf 1\mathbf 1^T\otimes J_2.
\tag{12}
```

Its diagonal blocks are `I_2+J_2` of rank one, and its off-diagonal
blocks are `J_2`. If a matrix with the rank-one pattern already on the
diagonal were equivalent to `D_k` under arbitrary left/right local
Cliffords and independent input/output qubit permutations, its blocks
off the diagonal would necessarily have the form

```math
C_{ij}=L_iJ_2R_j\quad(i\ne j),\qquad L_i,R_j\in GL(2,2).
\tag{13}
```

The reason independent permutations do not evade this condition is
that the unique rank-one matching must be taken to the diagonal. Once
that is done, the remaining qubit permutation is simultaneous on rows
and columns, under which `D_k` is invariant.

For two rows `a,b` and two columns `c,d`, all avoiding the diagonal,
(13) forces the block ratio identity

```math
C_{ac}^{-1}C_{ad}=R_c^{-1}R_d
                  =C_{bc}^{-1}C_{bd}.
\tag{14}
```

Matrix (11) violates (14) already at `(a,b,c,d)=(1,2,3,4)` in
one-based indexing:

```math
C_{13}=C_{23}=C_{24}=
\begin{pmatrix}0&1\\1&1\end{pmatrix},\qquad
C_{14}=I_2.
```

The two ratios are respectively

```math
\begin{pmatrix}1&1\\1&0\end{pmatrix}
\quad\text{and}\quad I_2,
```

which are different. Hence this optimal `C` is outside the entire
dual-axis equivalence class, even when independent input and output
qubit permutations are allowed for the classification.

The same obstruction is visible in the rank-four cross submatrix
`C_({1,2},{3,4})`. In the normalized dual-axis local class such a cross
matrix factors through a two-dimensional space and has rank at most
two. Thus the proposed rank-two global coupling, with the rank-one
matching supplying the local diagonal, is also disproved by (11).

##### 5.1 How the counterexample was checked

The witness was found by a deterministic seeded walk through symplectic
transvections and then normalized by its unique rank-one matching. Its
validity does not depend on any claim that the walk samples uniformly or
exhausts the group. The displayed matrix itself is the certificate.
The checks are exact binary arithmetic: symplecticity, all sixteen block
ranks, the score sum of 81 integer terms, and the unequal two block
ratios above. An additional finite check found that its canonical left-
local representative is absent from the 648 representatives obtained by
exhausting all right-local actions on `D_4`; this numerical check is
redundant because (14) gives the analytic inequivalence proof.

#### 6. A six-qubit obstruction to block-rank sufficiency

The rank pattern becomes insufficient already at `k=6`. The following
construction supplies a counterexample that can be disproved using
Theorem 2, without enumerating all full-support input labels.

Take the four-qubit matrix `N` with bit-packed rows

```
(91,191,223,173,251,181,218,253).
```

It is a local input/output change of (11); alternatively, direct
calculation verifies its symplecticity. Its diagonal blocks are all

```math
K=\begin{pmatrix}1&1\\1&1\end{pmatrix},\qquad K^2=0,
```

and every off-diagonal block is invertible. Its two actual parity shifts
are both `(11,11,11,11)`. In particular it is another optimal four-site
matrix by Corollary 3.

Let `E:(F_2^2)^4 -> (F_2^2)^6` repeat the first physical coordinate
three times and leave the remaining three coordinates once each:

```math
E(v_1,v_2,v_3,v_4)=(v_1,v_1,v_1,v_2,v_3,v_4).
```

Then `E^T E=I_8` and `E^T J_6 E=J_4`. The space is the symplectic
orthogonal direct sum of `im E` and `ker E^T`. Define

```math
F=I_{12}+E(N+I_8)E^T.
\tag{15}
```

On these summands, `F` acts as `N` and the identity, respectively, so
`F` is symplectic. Its diagonal physical blocks are `K`, the off-diagonal
blocks within the repeated group are `K+I_2`, and all remaining
off-diagonal blocks are off-diagonal blocks of `N`. Since `K+I_2` is
invertible, `F` has exactly the same necessary rank-one-diagonal/rank-two-
off-diagonal pattern. Its bit-packed rows are

```
(1451,3031,1454,3037,1466,3061,
 3583,2773,4031,2901,3498,4053).
```

Choose the paired row set `I={1,2,4}` and column set `T={1,3,5}`
(one-based physical-site labels). The resulting `6 x 6` binary minor
has bit-packed rows

```
(27,55,26,53,31,37).
```

Binary elimination gives rank six, so this minor is invertible, but
`|I\T|=2`. It violates Theorem 2 and proves that `F` is not optimal.
An independent direct integer score calculation gives the compatible
strict inequality

```math
S_6(F)=10769<11537=s_6.
```

This example also prevents a different shortcut: an odd replication of
sites preserves symplecticity and the necessary block pattern, but does
**not** in general preserve optimality. The full higher-support equality
conditions matter even when every one-site marginal condition is met.

#### 7. An affine avoidance lemma, including the three-variable boundary

The remaining proof converts the rounded quadratic equality into global
row structure. Let `ell>=3`, let `P:F_2^2 -> F_2^2` have rank one, and
let `v` be any fixed vector. Distinguish coordinate zero from the
`ell-1` regular coordinates. Put

```math
G(a)=P a_0+\sum_{i=1}^{\ell-1}a_i,\qquad
\mathcal E=\{a:\ a_i\ne0\text{ for every }i,\ G(a)\ne v\}.
```

**Lemma 4 (affine avoidance).** Suppose

```math
F(a)=c+\sum_{i=0}^{\ell-1}B_i a_i
```

has linear part of rank two and is nonzero on every point of `E`.
Then one of the following holds for an invertible two-dimensional `C`:

```math
F(a)=C a_j\quad\text{for one coordinate }j,
\qquad\text{or}\qquad
F(a)=C(G(a)+v).
\tag{16}
```

Both forms satisfy the avoidance property.

*Proof: the case of no full-support zero.* The image of the three
nonzero local inputs under a coefficient of rank zero, one, or two is
respectively `{0}`, a line `{0,b}`, or the three nonzero vectors. Two
rank-two image sets sum to the whole plane, as do a rank-two image set
and a nonzero rank-one image set. Two distinct rank-one image lines
also sum to the whole plane. Since the entire linear map has rank two,
the only way for `F` to have no zero on the full-support product is
therefore exactly one invertible coefficient, all other coefficients
zero, and `c=0`. This is the coordinate form in (16).

*Proof: nonempty zero fiber forces invertible regular coefficients.*
Suppose now that some full-support input has `F=0`. Every such input
must have `G=v`. No coefficient `B_i` can be zero: varying a nonzero
input at a regular coordinate changes `G`; at coordinate zero, its
three nonzero inputs have two different images under the nonzero map
`P`, which gives the same contradiction.

Suppose a regular `B_i` has rank one, with nonzero image vector `b`.
Any zero of `F` must then use the unique nonzero kernel vector at that
coordinate. Indeed, the two nonzero preimages of `b` differ by a
nonzero vector, so if either occurred at a zero of `F`, switching to
the other would preserve `F=0` and change `G`.

Let `S_i` be the set of sums of the other coefficient images on their
nonzero inputs. The existence of a zero, and the preceding prohibition,
say respectively `c in S_i` and `c+b notin S_i`. There are at least two
other nonzero coefficients. The image-set facts show that `S_i` could
fail to be the whole plane only if every other coefficient has rank one
with a common image line `L`. Thus `S_i=L`, `c in L`, and `b notin L`.
Choose another regular index `j!=i`, which exists because `ell>=3`.
In the sum excluding `j`, the coefficient `B_i` has image outside `L`
and the still-present special coefficient `B_0` has image `L`. Their
images already sum to the whole plane. This contradicts the same
prohibition for the rank-one regular coefficient `B_j`. Hence every
regular `B_i` is invertible.

*Proof: the regular coefficients are all equal.* Write
`z_i=B_i a_i` and `C_i=B_i^(-1)` at the regular coordinates. Fix a
nonzero `a_0`. For every tuple of nonzero regular inputs satisfying

```math
\sum_{i\ge1}z_i=t:=c+B_0a_0,
```

the zero-fiber condition gives

```math
\sum_{i\ge1}C_i z_i=v+P a_0.
\tag{17}
```

If there are at least three regular coordinates, fix two of them and
swap distinct nonzero vectors `u,w` at these positions. One can choose
the other nonzero coordinates to have the required sum whenever at
least two of them remain. If exactly one remains, choosing `a_0`
appropriately gives the argument below as well; to keep the boundary
explicit, it suffices here to apply the lemma in the odd `ell` values
used by the theorem, where either there are at least four regular
coordinates or exactly two.

For at least four regular coordinates, any prescribed sum is realized
by the remaining at least two nonzero vectors. Subtracting (17) for
the swapped tuples yields `(C_i+C_j)(u+w)=0`. Every nonzero vector can
be written `u+w` with distinct nonzero `u,w`, so all `C_i` are equal.

At the boundary `ell=3`, there are two regular coordinates. Because
`B_0!=0`, the set of values `t=c+B_0a_0` for nonzero `a_0` contains at
least two distinct vectors. If it contains zero, (17) with `z_1=z_2`
ranging over all three nonzero vectors makes `(C_1+C_2)z_1` constant.
A linear map constant on those three vectors must be zero, so
`C_1=C_2`. If the set of `t` values does not contain zero, it contains
two different nonzero vectors. For each such `t`, the two distinct
nonzero summands `z_1,z_2` with `z_1+z_2=t` can be swapped in (17),
giving `(C_1+C_2)t=0`. Those two `t` vectors span the plane, again
proving equality.

For completeness, the only remaining case in the statement is `ell=4`,
with three regular coordinates. In the swapping argument, the one
remaining coordinate must equal `t+u+w`, and is forbidden only if
`t=u+w`. For every nonzero `u+w`, the set of possible `t` has at least
two values, so choose a nonzero `a_0` giving a different `t`. The swap
argument again applies. Thus the conclusion holds for every `ell>=3`.

Let the common regular coefficient be `C`. The sum of at least two
nonzero regular vectors can be any vector. Hence every nonzero `a_0`
occurs in a full-support zero of `F`, and the corresponding value of
`G` is

```math
(P+C^{-1}B_0)a_0+C^{-1}c=v.
```

A linear map constant on all three nonzero vectors is zero. Therefore
`B_0=CP` and `c=Cv`, giving the second form in (16). The converse is
immediate. QED.

The rank-two hypothesis is used: a nonzero constant map, for example,
also avoids zero, but cannot represent any physical row in the
information-set application below.

#### 8. The rounded quadratic and odd multiplicities of affine row types

**Lemma 5 (affine row types).** Let `k` be even and let `M` be optimal.
Fix an odd-size input support `T` of size `ell>=3`. On the source affine
subspace `M(delta_H+V_T)`, choose a paired information set and local
invertible changes of its physical coordinates. In suitable such
coordinates `a_0,...,a_(ell-1)`, every physical output coordinate is an
invertible left multiple of exactly one of

```math
a_0,a_1,\ldots,a_{\ell-1},\quad
P a_0+\sum_{i\ge1}a_i+v,
\qquad
P=\begin{pmatrix}1&0\\0&0\end{pmatrix},\quad v=(1,0).
\tag{18}
```

Every one of these `ell+1` affine types occurs an odd positive number
of times.

*Proof: determine the actual projected quadratic.* Theorem 1 and local
changes of physical coordinates put the normalized Fourier dual in
the form

```math
Q^*(a)=Q_0(a)+q(L a),\qquad L a=P a_0+\sum_{i\ge1}a_i.
\tag{19}
```

The rank-one summand can be brought to `P` by an invertible quotient
change and an invertible change of its input coordinate. The quotient
change preserves `q` and is absorbed into the invertible changes at
the regular coordinates.

The polar map of (19), relative to the physical pairing, is

```math
\mathcal T(a)_0=a_0+(I+P)L a,\qquad
\mathcal T(a)_i=a_i+L a\quad(i\ge1).
```

Since `ell-1` is even and `P J_2 P^T=0`, this is an involution and
`L T(a)=L a`. A direct quadratic expansion gives its normalized dual

```math
Q_{\mathrm{norm}}(a)=Q^*(\mathcal T a)
                    =Q_0(a)+q(L a+v)+1.
\tag{20}
```

Here `q((I+P)b)=b_z` and
`q(b+v)=q(b)+1+b_z` give the final constant and linear terms explicitly.
There is no translation of the physical full-support domain in this
calculation.

The Gauss sign of (19), and hence of its normalized dual, is positive.
For an explicit check, the Fourier identity of the anisotropic plane
is

```math
(-1)^{q(b)}=-\frac12\sum_{u\in\mathbb F_2^2}
                  (-1)^{q(u)+B(u,b)}.
```

Using it in (19), the `ell-1` regular factors contribute an even
number of `q(u)` phases, while the special dual linear coefficient
contributes `u_z`. Thus the Gauss sum is

```math
-\frac12(-2)^\ell
       \sum_u(-1)^{q(u)+u_z}
=-(-2)^\ell=2^\ell,
```

because `sum_u(-1)^(q(u)+u_z)=2` and `ell` is odd. The source's
**actual** projected parity quadratic has Gauss sign `(-1)^ell=-1`.
It is therefore (20) plus one, namely

```math
Q_{\mathrm{actual}}(a)=Q_0(a)+q(L a+v).
\tag{21}
```

On projected full-support inputs, `Q_0(a)=1`. Their physical parity
must be zero because `k` is even, so the counted opposite-sign points
are exactly `E={all a_i!=0: L a!=v}`. Equality in the source projection
bound says that every one of these points lifts to full physical
support.

*Proof: classify the physical affine maps and their multiplicities.*
Every physical coordinate map on this affine subspace has linear rank
two: its restriction to the original `V_T` contains an invertible
physical block, since `|T|>=3` and a block row has only one rank-one
block. The coordinate change used to parametrize the subspace does
not alter that rank. Its avoidance of zero on `E` therefore invokes
Lemma 4, giving exactly the affine forms (18).

Let their multiplicities be `m_0,...,m_(ell-1)` for the coordinates
and `m_s` for the affine sum form. Each coordinate type is present
because it occurs in the information set. As local invertible maps
preserve `q`, physical parity and (21) give

```math
\sum_i(m_i\bmod2)q(a_i)
 +(m_s\bmod2)q(L a+v)
 =\sum_iq(a_i)+q(L a+v).
\tag{22}
```

The cross polar term between two different regular coordinates forces
`m_s` odd. After canceling that term, restriction to each single
coordinate makes every `m_i` odd. In particular the sum type is
present. All `ell+1` affine types are inequivalent under invertible
left multiplication: coordinate types use distinct variables, and the
sum type has nonzero constant term as well as contributions from at
least two regular variables. QED.

#### 9. Global rigidity at every even order at least six

**Theorem 6.** For every even `k>=6`, a symplectic map is optimal if and
only if it belongs to the dual-axis class under local input/output
Cliffords and independent input/output physical-site permutations.

*Proof: normalize the matching and both actual shifts.* Permute columns
so the unique rank-one matching is diagonal. Independently apply local
input/output transformations so that both actual shifts are

```math
\delta_M=\delta_H=(w,\ldots,w),\qquad w=(1,1).
```

This is possible because both shifts have full support. Their
transformation rules under `M -> A M B` are
`delta_M -> A delta_M` and `delta_H -> B^(-1) delta_H`.
Equation (10) then gives `M(w,...,w)=(w,...,w)`.
The image of each diagonal rank-one block is `span(w)`. Applying the
same image statement to its inverse counterpart
`J_2 M_ii^T J_2` shows that its kernel is `span(w)`. Over the binary
field it is therefore the unique matrix

```math
K=w w^T J_2=\begin{pmatrix}1&1\\1&1\end{pmatrix}.
\tag{23}
```

Every off-diagonal block remains invertible.

*Proof: exactly three coincident affine row pairs per deleted triple.*
For a deleted input triple `C`, put `T=[k]\C`. Then `ell=k-3` is odd
and at least three. Lemma 5 gives `ell+1=k-2` classes of proportional
physical affine coordinate maps on `M(delta_H+V_T)`, all of odd positive
size. The sizes sum to `k`, so exactly one class has size three and all
others have size one. Hence exactly three unordered pairs of physical
affine rows are proportional on each such `T`.

*Proof: the rank-one positions make a sharp double count.* For a row
pair `r!=s`, the affine maps in the original `V_T` parameter are

```math
f_r(y)=w+M_{r,T}y,\qquad f_s(y)=w+M_{s,T}y.
```

They are proportional exactly when, for some invertible `C`,
`Cw=w` and `M_sj=C M_rj` at every `j in T`. A proportionality cannot
hold at column `r` or column `s`, because one of the two blocks there
has rank one and the other rank two. The deleted triple must therefore
contain both `r,s`. There are only `k-2` such triples.

Count pairs over all deleted triples. Lemma 5 gives the total

```math
3\binom{k}{3}=\binom{k}{2}(k-2),
```

which is exactly the sum of these `k-2` bounds over all row pairs.
Every pair attains its bound. Thus, for every third deleted site
`t notin {r,s}`, there is a proportionality on the complement of
`{r,s,t}`.

The proportionality matrix is independent of `t`: two such complements
overlap in `k-4>=2` columns, at each of which both blocks are invertible.
Comparing one common column identifies the matrix uniquely. Denote it
by `C_sr`. It fixes `w`, and

```math
M_{sj}=C_{sr}M_{rj}\quad\text{for every }j\notin\{r,s\}.
\tag{24}
```

*Proof: remove the row factors and recover the dual-axis map.* For
three distinct rows `r,s,t`, choose a column outside them. Equation
(24) at that invertible block gives the cocycle identity

```math
C_{tr}=C_{ts}C_{sr}.
```

Choose a base row and left-multiply each row by its corresponding
inverse factor. These local maps all fix `w`, so preserve `K` and the
normalized shifts. They make the off-diagonal blocks in each column
identical: for some invertible `B_j`,

```math
M_{ii}=K,\qquad M_{ij}=B_j\quad(i\ne j).
\tag{25}
```

Since `M(w,...,w)=(w,...,w)` and `Kw=0`, every block row satisfies
`sum_(j!=i) B_j w=w`. Comparing two rows shows that all vectors
`B_j w` are the same. There are `k-1` terms, an odd number, so the
common vector is `w`. Each `B_j` consequently fixes `w`.

Right-multiply physical column `j` by `B_j^(-1)`. The diagonal stays
`K` because a two-dimensional symplectic matrix fixing `w` preserves
both the image and functional in `K=w w^T J_2`. All off-diagonal
blocks become `I_2`. Finally, the even dual-axis matrix (12) has
diagonal `K` and off-diagonal `J_2`; the same local `J_2` on every
output site sends it to (25) with every `B_j=I_2`. This proves the
necessary normal form.

Conversely, the source dual-axis matrix is optimal. Every local
input/output transformation and independent input/output site
permutation preserves the score, by permuting full-support inputs and
preserving output support sizes. The full stated class is optimal. QED.

#### 10. Complete even-order criterion and remaining resource obligations

The completed structural conclusions are:

| Even order | Necessary and sufficient optimizer description |
|---|---|
| `k=2,4` | Rank-one physical blocks occupy one permutation matching, and all other blocks are invertible. |
| Every even `k>=6` | The dual-axis local input/output and independent input/output permutation class. |

The first row is the algebraic criterion of Corollary 3, not a claim
that all its matrices lie in one local class. Matrix (11) proves that
`k=4` includes at least one additional class. At `k=2`, column
permutations also relate the familiar one-CNOT and displayed dual-axis
representatives for purposes of this enlarged classification; such a
permutation remains a physical cost in synthesis.

The global theorem now combines the rounded equality, a complete
affine avoidance proof, and the lifting and compatibility conditions;
it does not leave higher support equalities as unclassified conditions.
The counterexample (15) illustrates why the marginal block pattern
alone was insufficient to reach that conclusion.

The structural permutations remain explicit. They are not free gates
in the resource model. A CNOT lower bound for one fixed dual-axis
matrix does not automatically hold for every separately permuted
member of its optimizer class. Exact all-order synthesis minima still
require a proof that handles all such members and matching physical
circuits.

#### 11. A complete finite classification of the four-site exception

The rank criterion at `k=4` permits an especially small exhaustive
certificate. It confirms that there are **exactly two** optimizer
classes under local input/output Cliffords and independent input/output
site permutations: the dual-axis class and one exceptional class.

##### 11.1 Why the normalized enumeration is complete

Every four-site optimizer can first have its unique rank-one matching
put on the diagonal, and then have both actual shifts set to
`(w,w,w,w)`, where `w=(1,1)`. The proof at the start of Theorem 6
applies without any lower bound on `k` and gives diagonal blocks `K`
from (23), invertible off-diagonal blocks, and `M(w,w,w,w)=(w,w,w,w)`.

For each physical row, its three off-diagonal block images of `w`
must sum to `w`. The three nonzero images are either all `w`, or two
copies of one other nonzero vector and one `w`. There are
`1+2*3=7` such image sequences. Each specified image of `w` has two
preimages in `GL(2,2)`, so there are exactly `7*2^3=56` possible
physical rows with diagonal block `K`.

Each candidate row has the correct symplectic self-pairing, because its
three invertible blocks contribute three copies of `J_2` and the
rank-one diagonal contributes zero. Pairwise symplectic orthogonality
between four selected physical rows therefore is exactly the condition
`MJM^T=J`; it also guarantees invertibility of the assembled matrix.
The certificate enumerates all choices by precomputing the pairwise
compatibility relation and intersecting the compatible choices. It
finds 896 normalized symplectic matrices. By Corollary 3, all are
optimal, and by the normalization argument no optimizer class is
missing.

##### 11.2 Why the residual orbit calculation is complete

An equivalence between two normalized matrices must preserve the
intrinsic actual shifts. Every residual local factor therefore fixes
`w`, so is either `I_2` or `J_2`. The diagonal rank-one matching is
also intrinsic; input and output site permutations must consequently
be the same permutation once both matchings are on the diagonal.
These transformations are sufficient as well: they preserve all the
normalization conditions.

Left residual local factors swap the two binary rows at each site.
Sorting each pair removes this free action, leaving `896/16=56`
representatives. No physical row pair has equal rows, because its
symplectic pairing is one, so this division by 16 is exact. On these
representatives, four input `J_2` actions and three adjacent simultaneous
row/column swaps generate the entire remaining equivalence relation.
The certificate closes their orbits by exhaustive breadth-first search,
checking at every step that the successor remains in the enumerated
normalized universe.

The two residual orbits have sizes 8 and 48, corresponding to 128 and
768 normalized matrices before quotienting by output locals. Their
lexicographically least bit-packed representatives are:

| Class | Representative rows | Residual orbit size |
|---|---|---:|
| Dual axis | `(87,171,93,174,117,186,213,234)` | 8 |
| Exceptional | `(87,191,173,223,185,247,214,253)` | 48 |

The first is directly the output-row-normalized dual-axis matrix.
Matrix (11) belongs to the second. The two classes cannot be merged by
any unexamined local or permutation operation, by the intrinsic-shift
and matching argument above.

##### 11.3 Resource witness and reproduction

The actual seven-CNOT path circuit in
`code/new_resource_witnesses.json`, named `k4_path_7`, has rank-one
matching `(3,2,1,0)` in zero-based indexing. Normalizing that matching
and both shifts gives bit-packed rows

```
(155,239,109,191,186,253,229,251).
```

This lies in the exceptional orbit of size 48. The normalization is
used only to identify the matrix class; no gate in the physical
seven-CNOT implementation is replaced by a free wire permutation.
The accompanying `code/new_verify_resource_witnesses.py` replays the actual gate list. Together with the universal path
lower bound, it proves the four-site path optimum seven. Thus the
exceptional class has a concrete resource role, beyond inequivalence
as an abstract matrix.

The entire enumeration and membership check use only Python's standard
library and exact integer arithmetic:

```
python code/even_k4_classification_certificate.py
```

It writes `results/even_k4_classification.json`, including the universe
size, class representatives, class sizes and the seven-CNOT witness's
normalization. This is a complete finite computational certificate,
separate from the analytic all-even-`k>=6` theorem.

At `k=2`, the same normalization makes the two diagonal blocks `K`.
The fixed global shift forces each off-diagonal block to fix `w`.
Independent output factors from `{I_2,J_2}` then make both off-diagonal
blocks identity while preserving the diagonal. Thus `k=2` has one
class under the enlarged local-and-independent-permutation equivalence.
The complete even-order class table is consequently: one class at
`k=2`, two classes at `k=4`, and one dual-axis class at every even
`k>=6`.


---

## Appendix E. Finite baseline and search coverage

**Scope note.** This appendix presents a preliminary result. Sections 2–7 state the combined conclusions.


### Structural feasibility probe: minimum CNOT cost of optimal shadow Cliffords

Date: 2026-11-25. Status: bounded exact computation and structural route
analysis. This is not a solution of the all-k open problem.

#### 1. Synthesis problem and source

The proposed question minimizes the number of CNOT gates over **all**
k-qubit Cliffords attaining the optimal two-sided locally randomized
full-support shadow score, with no ancillas, arbitrary free single-qubit
Cliffords, and either all-to-all connectivity or a fixed nearest-neighbor
chain. Input and output qubit permutations are not free gates in this model.

The primary source is Nie, Zhang, Wu and Chen, *Exact Clifford Optimality for
Two-Sided Locally Randomized Classical Shadows*,
[arXiv:2610.04621v2](https://arxiv.org/abs/2610.04621v2). The PDF was read through
[this arXiv mirror](https://arxiv.cnoctave.top/pdf/2610.04621) when the official
web extraction endpoint was unavailable. Source equations (7)–(9) give

```math
S_k(M)=\sum_{p\in\{X,Y,Z\}^{k}}3^{k-|\operatorname{supp}(Mp)|},\qquad
s_k=\begin{cases}
(3\cdot5^k+3^k-6)/4,&k\text{ odd},\\
(3\cdot5^k-3^k+2)/4,&k\text{ even}.
\end{cases}
```

The source proves attainment by the dual-axis Clifford
$U_*=e^{i\pi X^{\otimes k}/4}e^{i\pi Z^{\otimes k}/4}$, but that does not
classify every optimizer or establish its minimum gate cost. In particular,
at k=2 a one-CNOT optimizer exists. The displayed unpermuted dual-axis
map has cross-rank two and requires two CNOTs. Appendix D, Section 10
describes the equivalence of these targets when independent site
permutations are allowed for classification.

The public AFTD OP-757 catalogue lists an all-to-all lower-bound statement
and partial three-site complete-graph and path witnesses. The k=3 complete-
graph and path enumerations here are finite baselines.

#### 2. Exact finite results

The standalone standard-library program is [`probe.py`](code/probe.py). Its full
output, including gate witnesses and all breadth-first layer counts, is
[`finite_probe.json`](results/finite_probe.json). Run:

```bash
python code/probe.py --full --output results/finite_probe.json
```

| k | Connectivity | Output-local orbits exhaustively scored | Optimal orbits | Minimum CNOT count in this finite enumeration |
|---|---|---:|---:|---:|
| 2 | All-to-all | 20 | 18 | 1 |
| 2 | Chain | 20 | 18 | 1 |
| 3 | All-to-all | 6,720 | 72 | 4 |
| 3 | Chain | 6,720 | 72 | 5 |

For k=3 the maximum score among maps at exact minimum CNOT distance d is:

| d | All-to-all: number of orbits | All-to-all: maximum score | Chain: number of orbits | Chain: maximum score |
|---:|---:|---:|---:|---:|
| 0 | 1 | 27 | 1 | 27 |
| 1 | 27 | 51 | 18 | 51 |
| 2 | 432 | 75 | 153 | 75 |
| 3 | 2,784 | 91 | 839 | 83 |
| 4 | 3,042 | 99 | 3,015 | 91 |
| 5 | 432 | 75 | 2,457 | 99 |
| 6 | 2 | 27 | 236 | 67 |
| 7 | — | — | 1 | 27 |

All 72 optimal k=3 output-local orbits lie at distance four in the all-to-all
graph and at distance five in the chain graph. The complete graph counts
match the expected group quotient sizes independently of connectivity.
The recorded runtime of this bounded probe was below one second on the
present machine; no scalability inference is drawn from that number.

#### 3. Why the quotient search is complete for its stated finite scope

Ignore Pauli phases and use binary coordinates
$(x_1,z_1,\ldots,x_k,z_k)$. A Clifford acts by an invertible symplectic
matrix. Its rows are stored as bit masks. Pauli phases are irrelevant to the
score and can be changed by free single-qubit Pauli gates, so phase omission
does not change the CNOT minimum in this gate model.

##### 3.1. Canonical representatives of free output locals

On one output qubit, a single-qubit Clifford applies any element of
$\mathrm{Sp}(2,2)=\mathrm{GL}(2,2)$ to its two rows a,b. The three nonzero
vectors in their two-dimensional row space are a,b,a+b. There are precisely
six ordered bases, all realizable by a free local Clifford. The program sorts
these three bit masks and chooses the first two. Thus `canonical` is a unique
representative of each orbit under output single-qubit Cliffords.

This canonicalization does not identify different qubits, permute wires,
discard a nonlocal operation, or change any output support. It preserves the
score. The local action on symplectic matrices is free: if LM=M, invertibility
of M implies L=I. Consequently the total number of such orbits is

```math
\frac{|\mathrm{Sp}(2k,2)|}{6^k}
=\frac{2^{k^2}\prod_{j=1}^k(4^j-1)}{6^k},
```

namely 20 for k=2 and 6,720 for k=3. Both complete graph traversals obtain
exactly these counts.

##### 3.2. One-CNOT edges with arbitrary local frames

For a weight-two Pauli label p, the binary action of
$e^{i\pi P/4}$ is the transvection

```math
T_p(y)=y+B(y,p)p.
```

It is implementable with one CNOT and free single-qubit Cliffords: rotate
each nonidentity Pauli factor to Z and use the local equivalence between
$e^{i\pi ZZ/4}$, controlled-Z and CNOT. Conversely, every CNOT with
arbitrary local frames is represented, modulo free output locals, by one
of the nine transvections obtained from the three nonzero Pauli labels at
each endpoint. The program uses all nine on every allowed undirected edge.
Both CNOT directions are covered by this local equivalence.

To check that canonicalization loses no future paths, suppose L is a free
output local. Then
$T_p L = L T_{L^{-1}p}$. The label $L^{-1}p$ is another weight-two
Pauli on the same edge, and that generator is also enumerated. Therefore all
choices of the local representative lead to the same quotient adjacency.
Free local gates at the beginning are included because the identity's entire
local orbit has a single representative. Free input local gates are not
silently assumed to be free *after* fixing a target: the breadth-first search
starts with all free initial locals already in that identity orbit.

Every graph edge consequently costs one CNOT, every physical circuit projects
to a graph path of the same CNOT length, and every graph path lifts to such a
circuit. Breadth-first distance is therefore the exact minimum CNOT count
for a scored output-local orbit. This argument establishes completeness of
the finite search; it is not a classification theorem at arbitrary k.

##### 3.3. Witness format

Each witness step records the weight-two Pauli mask, the free local row
actions applied after it, and the resulting canonical symplectic rows.
A local row-action pair `[a,b]` uses masks 1,2,3 to select the old first row,
old second row, or their sum. The two masks are distinct and nonzero, hence
specify an invertible single-qubit Clifford action. These records permit
exact replay without guessing unrecorded local frames.

One minimum all-to-all k=3 witness uses edge supports 01,02,12,01. One
minimum chain witness uses 01,12,01,12,01. This shows why the four-CNOT
all-to-all witness cannot simply be treated as a four-CNOT chain circuit.

#### 4. Local-equivalence structure visible at k=2 and k=3

The program independently forms U_* from its two global transvections,
enumerates all $6^k$ input local Clifford frames, and canonicalizes the
outputs. No wire permutation is used in this operation.

At k=2 its double-local orbit contains nine output-local orbits. The
one-CNOT double-local orbit contains another nine; they are disjoint and
together comprise all eighteen optimizers. Their singleton cross-rank
patterns are respectively (2,2) and (1,1).

At k=3 the U_* double-local orbit contains exactly 72 output-local orbits,
and these are exactly all 72 optimizers in the full enumeration. Thus the
k=3 data require no input or output qubit permutation to relate an optimizer
to U_*: local input and output Cliffords suffice. All three singleton
cross-ranks equal two for every such optimizer.

This provides a concrete rigidity route at k>=3, but it does not justify
asserting rigidity for larger k. The failure at k=2 demonstrates that an
induction needs an explicit base exception and cannot assume uniqueness
without deriving equality conditions from the source proof.

#### 5. What cut ranks prove, and what they miss

For a bipartition A|B, write a symplectic matrix in blocks. The rank of its
cross block $M_{AB}$ lower-bounds the number of CNOTs crossing that cut.
Indeed, for a product MN,

```math
(MN)_{AB}=M_{AA}N_{AB}+M_{AB}N_{BB},
\qquad
\operatorname{rank}(MN)_{AB}
\le\operatorname{rank}M_{AB}+\operatorname{rank}N_{AB}.
```

A gate entirely within one side has cross rank zero, and a CNOT across the
cut has cross rank one. The inequality follows by induction over gates.
This direct binary-matrix argument does not need an operator-Schmidt-rank
formula or a choice of phases.

For the **particular** U_* circuit, every nontrivial cross block has rank two.
It follows that its chain implementation needs at least 2(k-1) CNOTs, and
its all-to-all interaction multigraph must have no cut with fewer than two
gates. These facts alone do not apply to all optimizers without additional
rigidity, and they are not generally sharp even for an optimizer known to
have those cross ranks.

The k=3 data show both limitations concretely. The cut-rank chain bound gives
four, but the exact chain minimum is five. Temporal ordering and the transfer
of independent binary directions create an additional obstruction. Thus
proving universal cross-rank two would be useful, but would not by itself
solve the requested synthesis problem.

#### 6. Updated all-dimensional starting theorem

The initial exploration allowed general affine character signs. The source shift is not arbitrary: its exact quadratic-duality identity forces all three nonzero marginal Fourier signs to be negative. The apparent positive-sign alternatives are therefore eliminated, not assumed away.

The complete derivation is in Appendix B. Every optimizing map has all 2-by-2 blocks invertible for odd k; for even k its rank-one blocks form a permutation pattern and all others are invertible. This is necessary structure, not sufficient classification. It implies at least two crossing CNOTs across every nontrivial cut when k>=3, hence lower bounds k on complete connectivity and 2(k-1) on a path.

These bounds remain nonsharp even at k=3. Appendices C and D prove compatibility of the higher-support equalities.


---

## Appendix F. Credited complete-graph lower bounds

**Scope note.** This appendix presents a preliminary result. Sections 2–7 state the combined conclusions.


### Complete-connectivity lower bounds from the existing LMC framework

The link/determinant tools below are
due to Jorgensen, *Link-middle-cut lower bounds for Clifford circuit
synthesis*, [arXiv:2609.16208v1](https://arxiv.org/abs/2609.16208v1), especially
Definitions 3.1 and 3.4, Theorem 3.5, Lemma 4.3 and Theorems 4.5–4.8.
The contribution here is their specialization to the optimizer block pattern
proved in Appendix B. No new general synthesis invariant or
general LMC theorem is claimed.

**Corollary.** In the ancilla-free CNOT plus free single-qubit Clifford
model, every shadow-optimal k-qubit circuit satisfies

```math
g_{K_k}(k)\ge
\begin{cases}
2k-2,& k\ge3\text{ odd},\\
\frac{3k}{2}-1,& k\ge4\text{ even}.
\end{cases}
```

These are lower bounds over every optimizer. They do not require a sufficient
optimizer classification or equivalence to one chosen dual-axis circuit.
They need not be sharp. The known k=2 value one is treated separately.

#### 1. At least k-1 support links

At a binary symplectic tableau F, form the undirected graph on the physical
sites, joining i and j when at least one of the two physical blocks F_ij and
F_ji is nonzero. Initially it has k components. Free single-qubit Cliffords
do not change any block rank or this graph. A CNOT changes its number of
components by at most one. A gate that decreases the number is a
block-support link in the source's terminology.

Every optimizer in the present k>=3 range has no zero physical block, by the
necessary rank theorem. Thus its final graph is connected. Every synthesis
must contain at least k-1 links, even if other gates temporarily split
components. This is the source's Theorem 3.5 with final vertex-component
count one.

#### 2. Determinantal middle gates are disjoint from links

Let D(F) be the k-by-k binary matrix with D_ij=det(F_ij). One-qubit Cliffords
preserve D because every invertible binary two-by-two local matrix has
determinant one.

For a CNOT with control c and target t, the scalar row updates are

```math
x_t\leftarrow x_t+x_c,\qquad z_c\leftarrow z_c+z_t.
```

Expanding each block determinant over F_2 gives

```math
D(F')=D(F)+(e_c+e_t)r^T,
\qquad r_j=\det\begin{pmatrix}x_c|_j\\z_t|_j\end{pmatrix}.
\tag{1}
```

This is the source's determinantal rank-one update. A determinantal middle
gate is one with r nonzero. Each such gate changes at most two rows of D and
changes D by a matrix of rank at most one.

If the CNOT is a support link, c and t belonged to distinct support
components before the gate. For each input site j, the restrictions x_c|_j
and z_t|_j cannot both be nonzero, since otherwise j would connect those
components. Therefore r_j=0 for every j. Links and determinantal middles are
disjoint classes of CNOTs, as proved in the source. Their lower bounds may
be added without counting a gate twice.

#### 3. Odd number of qubits

For odd k every physical optimizer block is invertible, so D(F)=J_k, the
all-ones matrix. Initially D=I_k. Summing (1) over all determinantal middle
gates and using rank subadditivity gives

```math
\#\{\text{middle gates}\}\ge\operatorname{rank}(J_k+I_k)=k-1.
```

Indeed, (J_k+I_k)v=0 implies v=(sum_i v_i)1, and for odd k the all-ones
vector is in that kernel. The kernel is exactly one-dimensional. This is
the source's Theorem 4.5 specialized to the optimizer.

Adding the k-1 links proves the odd lower bound 2k-2.

#### 4. Even number of qubits

For even k the rank-one blocks occupy a permutation pattern, all other
blocks being invertible. Consequently

```math
D(F)=J_k+P
```

for some permutation matrix P, over F_2. Relative to the initial determinant
matrix, Q=D(F)+I_k has row

```math
Q_{i,\cdot}=1^T+e_{\pi(i)}^T+e_i^T.
```

Its weight is k if pi(i)=i and k-2 otherwise. For k>=4 every row is nonzero.
Thus every row of D must have been changed by at least one determinantal
middle gate. Each such gate changes only its two incident rows, by (1), so
there must be at least k/2 middle gates. This is a direct row-coverage
specialization of the source's determinantal-middle framework; its more
general row-multiplicity bound yields the same universal floor here.

Adding the disjoint k-1 links proves k-1+k/2=3k/2-1.

#### 5. Scope and finite refinements

The same gate-count inequalities remain true under restricted connectivity,
but the separate path timing theorem gives stronger path bounds. At k=4 the
complete-graph corollary only gives five; the complete finite two-class
search excludes five and, with a six-gate construction, gives six. At k=5
the odd corollary gives eight; the completed finite two-class search excludes
eight and the explicit nine-gate exceptional-class witness gives nine.
Those finite refinements are separate audited computational arguments, not
consequences silently attributed to this general corollary.


---

## Appendix G. Exact four-site complete minimum

**Scope note.** This appendix presents a preliminary result. Sections 2–7 state the combined conclusions.


### Four-qubit complete connectivity: six CNOTs

This note depends on the
separate complete even-case classification of four-qubit optimizers into two classes
under local input/output Cliffords and independent input/output permutations.
It uses the same exact complete-connectivity quotient argument as
Appendix H.

**Finite conclusion:** g_(K4)(4)=6. The [primary source's Appendix F](https://arxiv.org/abs/2610.04621v2) construction
supplies the six-CNOT upper bound for its dual-axis optimizer. The finite
lower bound below excludes every optimizer with five or fewer CNOTs.

#### Representatives and legal quotient

The two representatives have row masks

```text
(87,171,93,174,117,186,213,234),
(87,191,173,223,185,247,214,253).
```

The search canonicalizes each output two-row plane and then sorts the four
planes. This quotients output local Clifford gates and output permutations.
It is legitimate for the minimum over the whole optimizer family on complete
connectivity: input permutations can be moved to the output by relabelling
an entire circuit, preserving its allowed edges and its CNOT count. This is
not a declaration that SWAP is free, and the same quotient is not used for
labelled-path lower bounds.

Every allowed weight-two Pauli transvection is a one-CNOT edge; all
$\binom42\cdot9=54$ are generated. Free local/output permutation frames
conjugate this set into itself. Thus every physical circuit projects to a
quotient path and every quotient path lifts to a physical circuit ending in
the permitted target family.

#### A stronger published pruning bound

Write e(F) for the number of bipartite block-support components and D(F) for
the determinant-block matrix. [Jorgensen, arXiv:2609.16208v1](https://arxiv.org/abs/2609.16208v1), Theorem 6.2 gives
the following lower bound for synthesis up to output permutation:

```math
h(F)=4-e(F)+\max\{\min_P m_{\rm det}(PF),\min_P d_{\rm diag}(PF)\}.
```

All 24 output permutations P are enumerated exactly. For Q=D(PF)+I,

```math
m_{\rm det}(PF)=\max\{\operatorname{rank}Q,
\lceil4-c_{\rm row}(Q)\rceil,
\lceil4-c_{\rm row}(Q^T)\rceil\},
```

where c_row(Q)=(4+2 Emp(Q)+Dup(Q))/3, Emp counts zero rows, and Dup counts the
maximum number of disjoint equal nonzero row pairs. The diagonal term is
the ceiling of one half of the sum of the four diagonal block rank
deficiencies. These are precisely the source's definitions.

The integer implementation of the row bound is

```text
(2*4 - 2*Emp - Dup + 2) // 3.
```

The independent minima in the theorem are retained; the program does not
mistakenly assume that one permutation simultaneously attains both minima.
Both initial representatives have h=5. A branch is pruned only when this
admissible bound exceeds the remaining gate budget. Failed states are
memoized with their remaining budget.

#### Completed exhaustive results

The code is [`new_lmc_four_search.cpp`](code/new_lmc_four_search.cpp).
Its fixed outputs and source hash are in
[`new_lmc_k4_exhaustion.json`](code/new_lmc_k4_exhaustion.json).

| Representative | Recursive visits | Failed states at remaining 3 | At remaining 4 | At remaining 5 | Outcome |
|---|---:|---:|---:|---:|---|
| First | 253 | 108 | 36 | 1 | Complete exhaustion, no circuit |
| Second | 133 | 54 | 24 | 1 | Complete exhaustion, no circuit |

Both runs terminated normally far below their explicit ten-million-call
ceiling, with `interrupted=false` and `exhaustive_failure=true`. Their small
size reflects the exact LMC pruning; it is not a restricted or random sample
of circuits. The classification ensures that both rows of this table exhaust
the optimizer family up to the stated equivalences. Together with the known
six-gate witness, they establish the finite conclusion.

Reproduce from the directory containing the accompanying code:

```bash
g++ -O3 -std=c++17 code/new_lmc_four_search.cpp -o /tmp/new_lmc_four_search
/tmp/new_lmc_four_search 1 5 10000000
/tmp/new_lmc_four_search 2 5 10000000
```

This is a finite computational proof. It supplies no general-k gate formula.


---

## Appendix H. Exact five-site complete minimum

**Scope note.** This appendix presents a preliminary result. Sections 2–7 state the combined conclusions.


### Five-qubit complete connectivity: a nine-CNOT optimum

The constructive upper
bound uses a literal H,S,CNOT circuit. The matching lower bound uses the
separate complete five-qubit optimizer classification and two completed
finite searches with a proved admissible bound. It is not an all-k resource
formula or a Lean/kernel certificate. Recompilation reproduced both exhaustive runs with identical visit and
failed-state counts.

#### 1. Statement and dependencies

Using the completeness of the two five-qubit optimizer classes and the
finite searches below,

```math
g_{K_5}(5)=9.
```

The complete odd-case classification
gives the dual-axis class and the exceptional
five-qubit class. Input/output single-qubit Clifford frames and independent
input/output site permutations occur in the structural classification. The
gate model itself does **not** declare SWAP free. Section 3 explains why an
output-permutation quotient is nevertheless exact for minimizing over the
entire optimizer family on complete connectivity.

The source paper supplies the optimal statistical score s_5=2403 and a
ten-CNOT construction for its displayed dual-axis circuit. That construction
is an upper bound, not a theorem asserting ten is necessary for every
optimizer. No published source theorem is contradicted here. Any comparison
with a stronger pending external formal statement must quote that statement
and its status precisely.

#### 2. A literal nine-CNOT upper-bound witness

The bit-packed final symplectic rows are

```math
(426,757,443,749,358,729,409,630,494,695).
```

The complete physical gate list is the `k5_complete_9` entry in
[`new_resource_witnesses.json`](code/new_resource_witnesses.json).
It contains only H,S,CNOT operations, with nine actual CNOT entries, no
ancillas and no wire-permutation operation. The verifier
[`new_verify_resource_witnesses.py`](code/new_verify_resource_witnesses.py)
replays those physical gates, checks the final matrix and its symplecticity,
and enumerates every full-support input to obtain the exact score 2403.

For reference, the compact transvection word before its recorded free local
normalizations has entries (i,j,a,b), with zero-based physical endpoints and
nonzero Pauli labels a,b in {1,2,3}:

```text
(2,3,2,3), (1,4,1,1), (3,4,2,1),
(0,4,2,2), (0,1,1,1), (0,2,3,3),
(2,3,3,3), (1,2,3,3), (3,4,3,3).
```

Each transvection is implemented by one CNOT and the explicitly stored free
local gates. The nonzero rectangular sign invariant places this target in
the exceptional class, rather than the dual-axis class. Class membership
alone is not the certificate of its score: the direct exact score is also
checked.

#### 3. Why the permutation quotient is legitimate here

Let G consist of free output single-qubit Clifford transformations and
arbitrary output site permutations. An equivalence class under G is
represented by the unordered collection of its k nondegenerate two-row
planes. Inside each plane the three nonzero rows are sorted and the first
two chosen as a basis; then the k row pairs are sorted. The program uses
exactly this canonicalization.

The input classification permits matrices of the form

```math
L_{\rm out}P_{\rm out}M_cP_{\rm in}L_{\rm in},
```

where M_c is one of the two representatives. Free local gates can be removed
without changing CNOT cost. If a circuit for P_out M_c P_in uses t CNOTs,
conjugating the entire circuit by P_in merely relabels all gate endpoints.
On a complete interaction graph every relabelled edge is allowed and the
CNOT count stays t. The resulting target is P_in P_out M_c. Thus the
minimum over both input and output permutations equals the minimum over
the output-permutation coset alone. This reasoning does not synthesize a
SWAP at zero cost and is not valid on a labelled path with arbitrary
permutations.

The same point makes the quotient search exact. A weight-two Pauli
transvection is locally equivalent to one CNOT. Conjugating it by an element
of G gives another weight-two Pauli transvection on some pair, and all such
pairs and axes are included. Intermediate free permutations/local frames can
therefore be propagated to the endpoint while relabelling subsequent
allowed gates. Every quotient edge costs one physical CNOT, and every
permitted one-CNOT step has a quotient edge. The graph is undirected.

The identity orbit consists precisely of local Clifford transformations
and site permutations. A path of length at most eight from a representative
to that orbit exists if and only if its coset contains a target achievable
with at most eight CNOTs. Including all right local frames is automatic:
the reverse quotient path begins at the whole free identity orbit.

#### 4. A published admissible bound

For a symplectic matrix F, let D(F) be its k-by-k matrix of two-by-two block
determinants over F_2. Let e(F) be the number of connected components of its
bipartite block-support graph, whose row-site and column-site vertices are
connected whenever the corresponding block is nonzero.

Jorgensen, *Link-middle-cut lower bounds for Clifford circuit synthesis*,
[arXiv:2609.16208v1](https://arxiv.org/abs/2609.16208v1), Theorem 6.3, proves
the bound

```math
h(F)=2k-e(F)-\operatorname{rank}_{F_2}D(F)
```

for synthesis up to an output permutation, with free single-qubit Cliffords.
Both terms are unchanged by the output-local/permutation canonicalization.
Consequently a state with h(F)>r cannot reach the identity orbit in r further
CNOT steps. This is the only nontrivial pruning bound used in the code.

Both five-qubit optimal representatives have all blocks invertible, hence
D is the all-ones matrix and e=1, giving h=10-1-1=8 at the root. The search
does not infer impossibility merely from this lower bound; it explicitly
exhausts every sequence still allowed by it.

If h(F)=0, both e(F) and rank D(F) must equal k because each is at most k.
Every block-support component then has one row and one column site, so F is
a local-block permutation and belongs to the free identity orbit. This
justifies the code's successful-terminal test.

#### 5. Completed bounded enumeration

The code is [`new_lmc_tight_search.cpp`](code/new_lmc_tight_search.cpp).
At every nonterminal state it generates all
$\binom52\cdot9=90$ possible weight-two transvections, canonicalizes and
deduplicates the successor states, and retains every successor with
h<=remaining-1. It recursively explores all of them. A failed state is
memoized together with its remaining gate budget; a state from a different
budget is not incorrectly reused. A separate global budget flag makes any
interrupted run explicit, and an interrupted run is never recorded as an
exhaustive failure.

The dual-axis target is initialized directly from the source's binary
formula. The exceptional target is the verified nine-CNOT matrix above.
Both completed searches had initial gate budget eight and a ten-million
recursive-call ceiling:

| Representative | Recursive visits | Failed states at remaining 4 | At remaining 5 | At remaining 6 | At remaining 7 | At remaining 8 | Result |
|---|---:|---:|---:|---:|---:|---:|---|
| Exceptional five-qubit class | 3,393,061 | 1,852,620 | 152,940 | 4,755 | 90 | 1 | Fully exhausted, no circuit |
| Dual-axis class | 3,655,981 | 2,001,120 | 161,580 | 4,815 | 90 | 1 | Fully exhausted, no circuit |

Neither run reached its ceiling. The measured runtimes were about 57 and 61
seconds on the current machine; runtime is not part of the mathematical
claim. The exact outputs, source hash, commands and explicit completion flags
are in [`new_lmc_k5_exhaustion.json`](code/new_lmc_k5_exhaustion.json).

Reproduce from the directory containing the accompanying code:

```bash
g++ -O3 -std=c++17 code/new_lmc_tight_search.cpp -o /tmp/new_lmc_tight_search
/tmp/new_lmc_tight_search 1 8 10000000
/tmp/new_lmc_tight_search 2 8 10000000
python code/new_verify_resource_witnesses.py
```

The complete two-class optimizer theorem and the two exhaustive failures
exclude every optimizer with eight or fewer CNOTs. The physical nine-CNOT
witness supplies the reverse inequality. That proves the stated finite
minimum with an exhaustive finite search. It does not replace
the still separate all-k synthesis problem or supply a Lean/kernel proof.


---

## Appendix I. Historical path chronology

**Scope note.** This appendix presents a preliminary result. Sections 2–7 state the combined conclusions.


### A temporal obstruction for two twice-used path cuts

This proves stronger necessary CNOT
lower bounds for every shadow-optimal Clifford on a labelled path. It does
not yet provide matching constructions or settle the exact resource target.
It uses the all-optimizer block-rank theorem in
Appendix B.

#### 1. Gate model and a transfer lemma

There are k physical qubits on the labelled path 1,...,k. CNOTs may use either
direction of an adjacent edge; arbitrary single-qubit Cliffords are free.
There are no ancillas. We represent the action on Pauli labels by a binary
symplectic matrix acting on column vectors, and append gates by left
multiplication. Blocks are indexed by output and input physical sites.

For sets of output sites A and original input sites C, let M[A,C] be the
binary matrix of coefficients of the original C variables in the current A
variables. This matrix can be rectangular. A gate inside A left-multiplies
its rows by an invertible matrix; a gate outside A leaves them unchanged.
Neither operation increases its rank. A CNOT with one endpoint in A changes
exactly one scalar row belonging to A by adding one scalar row from outside.
It therefore increases rank M[A,C] by at most one, independently of direction
and of all local Clifford frames.

**Transfer lemma.** Suppose no original C input variable reaches any A wire
before a particular cut-crossing gate, and that this gate itself adds no C
coefficient to A. If at most r later CNOTs cross the boundary of A, the final
rank of M[A,C] is at most r.

This is immediate from the preceding row-update facts, starting at rank zero.
It permits arbitrary internal gates and arbitrary free local Cliffords
between the crossing gates. It is a statement about linear dependence on
original input coordinates, not a count of visibly supported Pauli strings.

#### 2. Two cuts used exactly twice

Choose distinct path edges e_i=(i,i+1) and e_j=(j,j+1), with i< j, and write

```math
A=\{1,\ldots,i\},\quad
B=\{i+1,\ldots,j\},\quad
C=\{j+1,\ldots,k\}.
```

All three sets are nonempty. Suppose exactly two CNOTs use e_i and exactly
two use e_j. Order gates chronologically, including any free local gates.

**Two-cut obstruction.** At least one of the final corner matrices M[A,C]
and M[C,A] has rank at most one.

*Proof.* Suppose the first use of e_i occurs before the first use of e_j.
Until e_j is used, the path separates C from A union B, so no row on A union
B has any coefficient from an original C coordinate. In particular the first
e_i gate adds no C coefficient to A. After that gate there is only one further
crossing of the boundary of A, namely the second e_i gate. The transfer lemma
gives rank M[A,C]<=1. If the first e_j gate occurs earlier, exchange left and
right and obtain rank M[C,A]<=1. These are the only possibilities in a
chronological gate sequence. Gates that act on disjoint edges can be ordered
arbitrarily; the conclusion is unaffected. QED.

The proof does not assume that the middle region B is a single site, that
the circuit is layered, that its target is the dual-axis optimizer, or that
the two uses of an edge have the same CNOT direction.

#### 3. Stronger all-optimizer path lower bounds

Let g_P(k) be the smallest number of CNOTs among all optimizers in the stated
gate model on the labelled path.

**Theorem.** Every implementation of every shadow-optimal Clifford satisfies

```math
g_P(k)\ge
\begin{cases}
3k-4,&k\ge3\text{ odd},\\
3k-5,&k\ge4\text{ even}.
\end{cases}
```

*Proof.* The previously proved cut-rank consequence ensures that every path
edge is used at least twice for every k>=3. Let n_i be its number of uses.

For odd k, every two-by-two physical block of an optimizer is invertible.
Thus every nonempty corner matrix M[A,C] and M[C,A] contains an invertible
block and has rank at least two. The two-cut obstruction shows that no two
distinct edges can both have n_i=2. At most one edge is used twice and every
other edge at least three times, giving

```math
\sum_{i=1}^{k-1}n_i\ge 2+3(k-2)=3k-4.
```

For even k>=4, the rank-one physical blocks occupy a permutation pattern;
all other blocks have rank two. A rectangular block array with at least two
blocks in a row, or at least two in a column, therefore contains a rank-two
block. Hence both corner matrices in the obstruction have rank at least two
unless |A|=|C|=1. That exceptional situation occurs only for the pair of end
edges e_1 and e_(k-1).

Consequently any two edges used twice must be precisely the two end edges.
There can be at most two such edges, and all other edges are used at least
three times. Therefore

```math
\sum_{i=1}^{k-1}n_i\ge 2+2+3(k-3)=3k-5.
```

This also covers circuits with fewer than the maximal permitted number of
twice-used edges, because those circuits have a larger sum. QED.

The k=2 optimum remains one CNOT and is excluded explicitly. At k=3 the
bound is five, matching the already known finite chain optimum. That base
case match is not a claim of priority for the known three-qubit result.

#### 4. Mandatory schedules if equality is attained

Equality in the odd bound requires exactly one edge used twice and every
other edge used exactly three times. Call the twice-used edge the pivot.
For any other edge, its first use must precede the pivot's first use:
otherwise the proof of the obstruction would force a rank-one corner through
the twice-used pivot. Applying the same reasoning to the inverse circuit
(which reverses time and preserves the necessary block-rank pattern) shows
that its last use must follow the pivot's last use. Thus all other edges have
at least one use before the pivot begins and one after it ends. This is a
necessary schedule restriction, not yet a construction.

Equality in the even bound requires both end edges to be used twice and all
interior edges exactly three times. The same first/last argument forces every
interior edge to have a use before each end edge begins and after each end
edge finishes. The pair of end edges itself can evade the two-corner rank-two
test through the exceptional one-by-one corners. Again these conditions are
necessary; local Pauli axes and full global optimality must still be checked.

#### 5. Present scope

The theorem closes a specific gap in the previous cut-only analysis by using
the chronology of gates on two separators. It applies to all optimizers
through the proved necessary rank pattern, without assuming a global normal
form or local equivalence to one selected optimizer.

No matching all-k construction has yet been supplied in this note. Existing
source upper bounds on the path are 4k-6 for the displayed dual-axis circuit;
the remaining interval is narrower but not closed. Any later construction
must respect labelled nearest-neighbor edges, count every CNOT and physical
SWAP, and verify the exact score or a sufficient optimizer criterion.


---

## Appendix J. Uniform path upper construction

**Scope note.** This appendix presents a preliminary result. Sections 2–7 state the combined conclusions.


### A uniform optimal-shadow path construction with 4k-8 CNOTs

All labels below refer to physical
sites of a fixed nearest-neighbor path. No ancillas, free SWAPs, or free wire
permutations are used. One-qubit Clifford gates are free.

**Theorem.** For every k>=4, there is a shadow-optimal Clifford on the labelled
path with exactly 4k-8 CNOT gates. Consequently

```math
g_{P_k}(k)\le4k-8\qquad(k\ge4).
```

The four-qubit bound can separately be improved to seven and matched by the
temporal lower bound. The present uniform family uses eight at k=4 because
that seed admits a particularly simple extension. No assertion of sharpness
for all k is made.

The source's displayed dual-axis implementation uses 4k-6 path CNOTs. The
bound here is a different explicit construction, with a constant improvement
of two CNOTs. The source establishes an upper bound and poses the minimum
problem; it is not contradicted by a cheaper circuit.

#### 1. A four-CNOT three-site encoder

Use interleaved binary coordinates with the first site indexed 0. There is a
three-site nearest-neighbor Clifford C with four CNOTs whose binary rows are

```math
(9,42,25,62,17,22).
\tag{1}
```

The numbers are six-bit row masks with the least significant pair belonging
to site 0. Its first block column consists of three identity matrices:
$C_{00}=C_{10}=C_{20}=I_2$. In particular it sends the initial site's X,Z
pair to the same X,Z pair on every output site, with phases irrelevant to
support. Since C is symplectic, its inverse's first block row also consists
of identities.

Here is a compact complete circuit specification. For a Pauli mask p,
apply its weight-two transvection, then the listed free local row changes.
A row-change pair (a,b) selects the first old row, the second old row, or
their sum using masks 1,2,3, respectively.

| Pauli mask | Local changes at sites 0,1,2 |
|---:|---|
| 5 | (2,3), (3,2), (1,2) |
| 24 | (1,2), (1,3), (3,2) |
| 5 | (2,1), (3,1), (1,2) |
| 36 | (1,2), (3,2), (3,2) |

Finish with local changes (1,3), (1,3), (2,3). The transvection supports are
01,12,01,12. Each is locally equivalent to one CNOT on its indicated edge.
The script `code/new_path_family.py` expands every step into actual H,S,CNOT
gates and checks (1); thus the row-change notation hides no nonlocal gate.

For any odd r>=1, concatenate copies of C at the currently leftmost active
site and two new sites to its left. The resulting encoder C_r acts on a path
of r sites, has 2(r-1) CNOTs, and has identity blocks throughout the column
of the original site. This follows inductively: each copy replaces one
identity block in that column by three identity blocks and leaves all other
sites untouched. Reversing the encoder implements its inverse with the same
CNOT count; physical S inverses are represented by S^3 in the supplied code.

#### 2. Inflating a seed endpoint

Let M be an s-site seed Clifford whose distinguished endpoint is site 0.
Replace that endpoint by an odd number r of sites, placing the other s-1
sites to their right. Apply

```math
\widetilde M_r=C_r(M\oplus I_{2(r-1)})C_r^{-1}.
\tag{2}
```

The direct sum in (2) means that the original endpoint remains at the
rightmost site of the new r-site group; the added sites are otherwise idle
during the seed circuit. This is implemented by fixed physical positions,
not a wire-permutation gate. The seed's original adjacent edges remain
adjacent after the extension.

Write the group inputs as p_1,...,p_r in F_2^2 and the outside inputs as
q_1,...,q_(s-1). Let v=sum_a p_a and put

```math
t(v,q)=M_{00}v+\sum_{j=1}^{s-1}M_{0j}q_j,\qquad
c(v,q)=t(v,q)+v.
```

The output at each group site a is

```math
p_a+c(v,q),
\tag{3}
```

and the outside output at i>=1 is

```math
M_{i0}v+\sum_{j=1}^{s-1}M_{ij}q_j.
\tag{4}
```

To prove these formulas, write the embedded seed as identity plus its
original-site correction. In the expanded group, the first block column of
C_r and the corresponding inverse block row are both all identities. The
group-group blocks in (2) are therefore

```math
\delta_{ab}I_2+(M_{00}+I_2),
```

while group-outside and outside-group blocks are the repeated seed blocks
M_(0j) and M_(i0). The outside-outside block is unchanged. This establishes
(3)–(4) without any assumption about the unspecified auxiliary blocks of C_r.

If the seed uses c_s CNOTs, the physical implementation uses

```math
c_s+4(r-1)
\tag{5}
```

CNOTs. It remains to prove that the selected seeds retain the exact optimal
statistical score for every odd r. Necessary block ranks alone would not
justify that claim.

#### 3. An exact three-coefficient score identity

For c,v in F_2^2 define

```math
W_r(c,v)=\sum_{\substack{p_1,...,p_r\ne0\\\sum_a p_a=v}}
                    \prod_{a=1}^r3^{\mathbf1\{p_a=c\}}.
\tag{6}
```

For fixed nonzero outside inputs q, let G(q,v) be 3 raised to the number of
zero outside outputs in (4). Equations (3)–(4) give

```math
S(\widetilde M_r)=\sum_{q\in(F_2^2\setminus\{0\})^{s-1}}
                 \sum_{v\in F_2^2}G(q,v)W_r(c(v,q),v).
\tag{7}
```

Use ordinary binary characters chi_u(v)=(-1)^(u dot v). Character
orthogonality proves, for odd r,

```math
4W_r(0,v)=3^r-\sum_{u\ne0}\chi_u(v).
\tag{8}
```

For c nonzero, the Fourier transform of the one-site weights is 5 at u=0,
1 at the unique nonzero u satisfying u dot c=0, and -3 at the other two
nonzero characters. Thus

```math
4W_r(c,v)=5^r+
 \sum_{\substack{u\ne0\\u\cdot c=0}}\chi_u(v)
 -3^r\sum_{\substack{u\ne0\\u\cdot c=1}}\chi_u(v).
\tag{9}
```

It follows that three integers determined entirely by the fixed seed satisfy

```math
S(\widetilde M_r)=\frac{C_5\,5^r+C_3\,3^r+C_0}{4}
\qquad\text{for every odd }r\ge1.
\tag{10}
```

They are obtained by the finite sums in (7)–(9), with no approximation.
Checking those fixed integers is sufficient for all odd r; checking finitely
many inflated sizes alone would not be sufficient.

#### 4. Two explicit seeds and exact coefficient certificates

The normalized even seed has s=4, c_s=8 and row masks

```math
(119,219,126,163,47,153,102,143).
\tag{11}
```

The normalized odd seed has s=5, c_s=12 and row masks

```math
(603,501,511,598,487,634,439,730,346,685).
\tag{12}
```

Both are generated by explicit adjacent-edge CNOT circuits with free H,S
gates in `new_path_family.py`. The latter is the fixed twelve-CNOT
five-qubit witness followed by one free endpoint Hadamard. The even seed is
independently given by an eight-transvection word, together with explicit
free input/output endpoint normalizations. All physical gate sequences are
emitted by the constructor and replayed against (11)–(12).

The following tables give the exact contributions to (C_5,C_3,C_0), grouped
by v. They are exhaustive evaluations of only 27 times 4 or 81 times 4
terms in the explicit sums, respectively. Their reproducible integer
certificate is the `coefficients` function, not a statistical simulation.

| Even seed v | Contribution to C_5 | Contribution to C_3 | Contribution to C_0 |
|---:|---:|---:|---:|
| 0 | 107 | -208 | 89 |
| 1 | 80 | 69 | -11 |
| 2 | 80 | 69 | -11 |
| 3 | 108 | 43 | -65 |
| **Total** | **375** | **-27** | **2** |

For k=r+3, which is even, (10) therefore becomes

```math
\frac{375\,5^r-27\,3^r+2}{4}
=\frac{3\cdot5^k-3^k+2}{4}=s_k.
\tag{13}
```

| Odd seed v | Contribution to C_5 | Contribution to C_3 | Contribution to C_0 |
|---:|---:|---:|---:|
| 0 | 468 | -915 | 405 |
| 1 | 469 | 332 | -137 |
| 2 | 469 | 332 | -137 |
| 3 | 469 | 332 | -137 |
| **Total** | **1875** | **81** | **-6** |

For k=r+4, which is odd, the score is

```math
\frac{1875\,5^r+81\,3^r-6}{4}
=\frac{3\cdot5^k+3^k-6}{4}=s_k.
\tag{14}
```

The coefficient identity proves exact shadow optimality for every size in
the respective parity branch. Finally, (5) gives 8+4(r-1)=4k-8 in the even
case and 12+4(r-1)=4k-8 in the odd case. This proves the theorem.

#### 5. Verification and remaining gap

The supplied code independently replays actual H,S,CNOT lists, checks all
CNOTs are adjacent, compares the resulting matrix with (3)–(4), checks
symplecticity, and verifies the exact fixed seed coefficients. Finite direct
score checks at k=4,...,9 agree with the symbolic formula; k=12 was also
constructed and checked through the exact symbolic matrix and coefficient
identity. These are supporting arithmetic checks. The all-k proof is the
encoder induction and character expansion, not extrapolation from those
finite runs.

Together with the temporal lower bound, the established intervals are

```math
3k-4\le g_{P_k}(k)\le4k-8\quad(k\ge5\text{ odd}),
```

```math
3k-5\le g_{P_k}(k)\le4k-8\quad(k\ge6\text{ even}).
```

The known k=3 value is five, and the separate new four-qubit witness with
the general temporal lower bound gives seven. The remaining gaps are real.
The exceptional five-qubit complete-graph witness in Appendix H does not
directly extend by this construction: its single-site inflation has
different coefficients and fails to retain optimality. No such unsupported closure is
assumed here.

Reproduce a requested finite circuit from the directory containing the accompanying code with:

```bash
python code/new_path_family.py --k 7 --output path_family_k7.json
```

The output contains a full physical gate list. It is an upper-bound witness,
not a claim that its CNOT count is minimal at that size.


---

## Appendix K. General bridge and tree transfer obstruction

### A chronological transfer obstruction on every tree

Research extension, 25 November 2026. This note preserves the original complete-
graph and labelled-path optimization questions. It enlarges the proved hardware
scope; it does not replace either original exact-minimum requirement.

#### 1. A general theorem stated without shadow terminology

Let a circuit on `n` labelled binary symplectic coordinate pairs use free
single-site invertible maps and CNOT gates along a fixed connected graph `G`.
There are no auxiliary coordinate pairs. Write its final tableau as `M`, with
physical two-by-two blocks `M[u,v]`.

Assume one of the following final rank patterns:

- **O:** every physical block has rank two (`n >= 3`).
- **E:** every block has rank one or two, and the rank-one positions form a
  permutation matrix (`n >= 4`).

Let `B` be the set of bridges of `G`, and let `m_e` count the actual CNOTs on
bridge `e`. Then:

1. Every bridge has `m_e >= 2`.
2. Under O, at most one bridge has `m_e = 2`.
3. Under E, at most two bridges have `m_e = 2`. If two do, both are pendant
   bridges: their deletion isolates a single physical vertex on one side.

The assertion concerns all allowable local frames and both CNOT directions.
It does not assume that intermediate tableaux have either final rank pattern.
For a disconnected allowed graph these dense final patterns are impossible.

##### Proof of the rank-transfer fact

Fix output vertices `A` and original input vertices `C`. Keep the matrix of
the current coefficients of the original `C` coordinates on the `A` wires.
A gate wholly inside `A` multiplies its rows by an invertible matrix; a gate
wholly outside `A` leaves it unchanged. Neither changes its rank. A crossing
CNOT changes one scalar row in `A` by adding one scalar row outside, so it
increases that rank by at most one. A local gate inside `A` also acts by an
invertible row operation. These observations prove the assertion for every
partial circuit, not only its endpoint.

For a bridge partition `A | C`, the initial cross matrix is zero. Its final
rank is at least two under O. Under E, a nontrivial cross rectangle has at
least two blocks in a row or column, since `n >= 4`. The permutation-pattern
condition makes at least one such block invertible. The entire rectangle
therefore has rank at least two. Every bridge must be crossed at least twice.

##### Two distinct twice-used bridges

Delete two distinct bridges `e` and `f`. There are three connected components
(internal cycles within the components are harmless). Call the two outer
components `A` and `C`, and the middle component `D`; the quotient is
`A --e-- D --f-- C`. All three are nonempty. If the first use of `e` precedes
the first use of `f`, no original `C` variable has entered `A union D` at
that first `e` gate. It consequently adds no `C` coefficient to `A`. Only
one later gate crosses the boundary of `A`, so

`rank M[A,C] <= 1`.

If `f` is first, the same argument gives `rank M[C,A] <= 1`. This is exactly
the two-cut transfer mechanism proved earlier for paths, now with arbitrary
outer and middle components.

Under O either rectangle contains an invertible block, a contradiction.
Under E either rectangle contains an invertible block whenever `|A| > 1`
or `|C| > 1`: fix a block column or block row with two entries and use its
unique rank-one position. Thus `|A| = |C| = 1` is necessary for two twice-used
bridges. Both bridges must be pendant.

##### Why three pendant exceptions are impossible

Suppose three twice-used pendant bridges isolate distinct vertices `u,v,w`.
Choose `u` whose bridge has the earliest first gate. At that gate neither
the original `v` input nor the original `w` input has left its singleton
component. Only one subsequent gate can bring their coefficients to `u`.
Apply the rank-transfer fact separately to `C={v}` and `C={w}`. It gives

`rank M[u,v] <= 1` and `rank M[u,w] <= 1`.

Under E all blocks are nonzero, so both are rank one. This contradicts the
single rank-one position in row `u`. The three bridges cannot exist. This
proves the theorem. Notice that a pairwise graph argument alone would not
exclude a directed three-cycle of deficient blocks; the first-use chronology
is essential for this last step.

#### 2. Weighted bridge and tree bounds

Assign each allowed edge a nonnegative physical cost `w_e` per CNOT. Define

`W_B = sum_{e in B} w_e`,

`A_O = max({0} union {w_e : e in B})`,

and

`A_E = max({0} union {w_e : e in B}
           union {w_e+w_f : e,f are distinct pendant bridges})`.

Then the circuit's total weighted CNOT cost is at least

`3 W_B - A_O` under O, and `3 W_B - A_E` under E.

Indeed, write the bridge contribution as a three-use baseline. A bridge
used twice saves exactly `w_e`; a bridge used at least three times saves
nothing and may add nonnegative cost. The theorem characterizes the allowed
one- or two-element exception sets. Gates on nonbridges also have nonnegative
cost. Taking the largest permissible saving gives the bounds.

The single-edge term in `A_E` is necessary: if only one bridge is used twice,
the two-bridge argument does not force it to be pendant. A heavy internal
edge cannot be excluded from the possible saving.

If `G=T` is a tree, all edges are bridges. With unit costs the theorem yields

```math
g_T(n)\ge
\begin{cases}
3n-4,&\text{pattern O},\\
3n-5,&\text{pattern E}.
\end{cases}
```

For a general graph with `b` bridges, the bridge-only unit-cost bounds are
`max(0,3b-1)` and `max(0,3b-2)`, respectively. The weighted expression can be
strictly stronger if no eligible pendant pair exists. No lower bound on
additional nonbridge gates is silently added to these formulas.

#### 3. Application to optimal Clifford shadows

The baseline necessary-block-rank theorem proves O for every odd-order
shadow optimizer and E for every even-order optimizer. Consequently, for
every labelled tree with `n >= 3` odd or `n >= 4` even, the preceding bounds
hold over **every** optimizer, including arbitrary input/output local frames
and site permutations. The proof uses the physical block pattern of the
actual target and never turns a permutation into a free physical gate.

This strictly enlarges the baseline path theorem to all trees, all weighted
trees, and the bridges of arbitrary connected hardware graphs. The two-cut
rank argument on paths appears in Appendix I. The theorem here extends that
argument to arbitrary bridges and imposes the chronological and weighted
constraints above.

##### A necessary role for interaction cycles

Take any complete-connectivity circuit and form its **simple interaction
graph**: put an undirected edge wherever it uses at least one CNOT. Every
optimizer under O or E has a connected interaction graph; otherwise the
tableau would be block diagonal across a disconnected partition. If that
graph were a tree, the tree bound would apply to the circuit itself.

It follows that a circuit with fewer than `3n-4` CNOTs under O, or fewer
than `3n-5` under E, must use an interaction cycle. This is a statement
about which physical couplings actually occur, not the ambient availability
of complete connectivity.

In particular the previously sourced complete-graph constructions use
`3n-5` for odd `n >= 3` and `3n-6` for even `n >= 4`. They are strictly below
the respective tree floors. Thus all-order resource-efficient saturation
within those budgets necessarily exploits cyclic connectivity. The statement
remains true if a cheaper construction is later found. It does not show
that a single cycle suffices, bound the number of independent cycles, or
prove a sharp complete-graph or tree cost.

The known exceptional five-qubit nine-CNOT optimizer also necessarily has a
cycle, since every five-vertex tree requires at least eleven CNOTs. This is
a consequence of the uniform theorem, not a new finite enumeration.

#### 4. Scope and limitations

This proof is analytic and independent of a numerical search. It uses only
the earlier exact necessary rank pattern and elementary ranks of changing
rows; no unverified circuit experiment is promoted into a universal bound.
The scalar/local transfer fact and its two-cut version were already in
Appendix I. Their all-optimizer input is in
Appendix B. The source upper bounds are from
Nie–Zhang–Wu–Chen, arXiv:2610.04621v2, Appendix F.4.

The original exact all-order minimum questions for the complete graph and
path remain separate obligations. The tree extension establishes a hardware lower bound.


---

## Appendix L. Exact finite paths and sharp odd stars

### Exact path minima at five and six sites, and sharp odd-star synthesis

This appendix gives a computationally assisted lower bound with a
self-contained pruning invariant and analytic star constructions.

#### 1. Scope and result

Use exactly the pre-existing gate model: no ancillary qubits, free one-qubit
Cliffords, CNOTs only between adjacent sites of a fixed labelled path. The
optimization is over every statistically optimal Clifford, including all
permitted input/output local frames and site permutations in the previously
proved optimizer classification. A physical wire permutation is not a free
intermediate operation.

**Finite theorem (computation-assisted).** The least CNOT counts are

```math
g_{P_5}(5)=12,\qquad g_{P_6}(6)=16.
```

The upper bounds are already proved by Appendix J and
its literal H/S/CNOT constructors. The new part is complete rejection of
budgets 11 and 15, respectively. Both five-site optimizer classes are
covered; at six sites the previous all-order classification supplies the
single dual-axis class. The only computational pruning needed is the cut
assignment invariant below. The optional pre-existing LMC bound can be
disabled without changing the five-site traversal statistics.

#### 2. A cut assignment lower bound

Let F be any binary symplectic 2k-by-2k matrix, with two coordinates at each
physical output site. Let A_i={1,...,i}. A terminal local-permutation matrix
assigns some set S_i of i original input sites to these first i physical
outputs. Such assignments form a nested chain

```math
\varnothing=S_0\subset S_1\subset\cdots\subset S_k=[k],
\qquad |S_i|=i.
```

For a fixed assignment define

```math
H_S(F)=\sum_{i=1}^{k-1}
\operatorname{rank}_{\mathbb F_2}F[A_i,[k]\setminus S_i],
\qquad H(F)=\min_S H_S(F).
```

Here each selected site includes both binary coordinates.

**Lemma 1.** Every labelled-path circuit reducing F to an arbitrary
local-permutation matrix uses at least H(F) CNOTs.

*Proof.* Fix the terminal assignment of that circuit. At termination every
summand of H_S is zero. A CNOT on edge (j,j+1) leaves every other summand
unchanged: on any other prefix its action is either wholly outside the
prefix, or an invertible row operation inside it. On its own prefix it
changes one scalar row by a row from outside, so its rank changes by at
most one. Free one-site Clifford gates preserve every rank. Hence a circuit
of t CNOTs has H_S(F)<=t, and therefore H(F)<=t. QED.

This argument also applies to a weight-two Pauli transvection on an
adjacent edge, since it is locally equivalent to one CNOT and its update on
one side of a cut has rank at most one.

**Lemma 2.** H is invariant under arbitrary right input-site permutations,
right one-site symplectic transformations, and left one-site symplectic
transformations. H(F)=0 if and only if F is a local-permutation matrix.

*Proof.* Right input permutations only relabel the minimizing nested chain;
right local maps are invertible column operations within the selected input
sites. Left local maps act inside each output prefix. These prove
invariance. A local-permutation matrix has H=0 by its own assignment.
Conversely H=0 supplies a nested chain making F block lower triangular
after permuting input sites. Its first two rows have support on one input
site; symplecticity makes their two-by-two restriction invertible. Every
other output row is symplectically orthogonal to this complete pair, so its
restriction to the same input site vanishes. Remove that input/output pair
and repeat inductively. The result is block diagonal with invertible
two-by-two blocks, before undoing the input permutation. QED.

**Exact subset recurrence.** For S subseteq[k] with |S|=i< k put

```math
c(S)=\operatorname{rank}F[A_i,[k]\setminus S],
\quad d(\varnothing)=0,
\quad d(S)=c(S)+\min_{j\in S}d(S\setminus\{j\}).
```

Use c([k])=0. Then d([k])=H(F). Every chain ends in exactly one of the
listed predecessor subsets, so induction proves the recurrence without
relaxing the nested assignment constraint. It uses O(2^k k) predecessor
operations and a polynomial-size binary rank calculation for each subset.
No continuous numerical calculation or sampled lower bound is involved.

#### 3. Search state and sound reductions

The state is the complete 2k binary rows of F. A one-CNOT step is represented
by any of the nine Pauli transvections on each adjacent edge. Conjugation
by a free local Clifford only permutes these nine generators. This covers
all choices of CNOT direction and all interspersed local gates.

After each step the implementation may perform these zero-cost symmetry
reductions:

1. On each physical output site, replace its two rows by a deterministically
   chosen basis of their same two-dimensional row plane. Output sites stay
   in their physical order.
2. On each input site, choose a basis of its two-column plane and sort these
   input column planes. This is a RIGHT action by input local maps and an
   input permutation, not an output wire swap.

The code performs a fixed two passes of these operations. It does not need
or assert a unique representative of the entire double orbit. Every
reduction is an invertible allowed symmetry of the search problem: right
actions commute with every future physical left gate and preserve the
terminal monomial goal; left local gauges conjugate the complete adjacent
transvection generator set into itself. Thus every genuine circuit has a
path in the reduced search. Residual duplicate representatives affect
runtime, not completeness. No output permutation is inserted between
physical gates, and no complete-graph quotient is reused on the path.

The depth-first search enumerates every generated next state whose H value
does not exceed its remaining budget. A state is cached as failed only
after all its children finish unsuccessfully. A node limit immediately
propagates an `interrupted` result; it cannot produce an exhaustive-failure
certificate. The `NO_LMC` compilation flag makes H the sole pruning bound.

#### 4. Coverage of every optimizer placement

Let K be one of the complete class representatives from the existing
optimizer classification. Every target in its class is

```math
U=L_{\rm out}P_{\rm out}K P_{\rm in}L_{\rm in},
```

where the L factors are site-local and the P factors are site permutations.
If U has a physical path circuit, its inverse followed by the free output
local adjustment reduces P_out K to a local-permutation matrix on the
right. More explicitly, if C is the physical circuit matrix realizing U,

```math
C^{-1}L_{\rm out}(P_{\rm out}K)
   =L_{\rm in}^{-1}P_{\rm in}^{-1}.
```

In chronological gate order the free L_out adjustment acts first on
P_out K and then the reversed circuit acts; its CNOT cost is unchanged.
Conversely any such reduction realizes an optimizer in this class.
Thus it is sufficient and necessary to search all output placements of K,
with arbitrary terminal local-permutation matrices. Input permutations are
choices of the optimizer, not free physical gates in the implementing
circuit.

At k=5 the program explicitly enumerates all 5! output permutations for
each of the two independently established classes. The deterministic
reductions leave 3 dual-axis starting matrices and 18 exceptional starting
matrices. These counts are not assumed to be orbit counts; exhaustiveness
comes from the literal 120-element loop before reduction.

At k>=6 there is only the dual-axis class. Its representative has the same
diagonal block at every site and the same off-diagonal block at every
ordered pair. Therefore it commutes with every simultaneous site
permutation: P K=K P. Every output placement can be absorbed into the
terminal input permutation; a single fixed representative suffices. This
is a symmetry of the target family, not permission to relabel physical
edges during search.

#### 5. Reproduction and measured finite scope

From the directory containing the accompanying code and results:

```bash
g++ -O3 -std=c++17 -DNO_LMC code/path_exact_search.cpp -o /tmp/path_exact5
/tmp/path_exact5 0 11 10000000
/tmp/path_exact5 1 11 10000000
/tmp/path_exact5 0 12 10000000
g++ -O3 -std=c++17 -DNO_LMC -DTARGET_K=6 code/path_exact_search.cpp -o /tmp/path_exact6
/tmp/path_exact6 0 15 10000000
```

The first two runs finish all starts and report exhaustive failure, with
10,582 and 1,354 recursive visits. The budget-12 positive search finds a
terminal local-permutation goal. The six-site budget-15 run with the
optional LMC bound reports 486,363 visits and normal exhaustive failure;
the sole-H reproduction is recorded separately in
`results/independent_path_k6_no_lmc.json` and has the same 486,363 visits.

The finite search is not a Lean kernel certificate. Its mathematical
inputs are the previously proved optimizer class completeness and the
explicit elementary search arguments above. The general formula
g_{P_k}(k)=4k-8 remains unproved outside the separately verified sizes;
this file must not be used to claim that formula for all k.

#### 6. A sharp resource law on every odd star

Let K_{1,k-1} have center site 0 and leaves 1,...,k-1. The physical
interaction graph is this fixed star; there are no leaf-to-leaf CNOTs.
The tree lower bound proved separately in Appendix K applies to
every shadow-optimal Clifford on every k-vertex tree.

**Theorem (all odd stars).** For every odd k>=3,

```math
g_{K_{1,k-1}}(k)=3k-4.
```

In particular the star attains the minimum possible unweighted tree cost
at every odd order. This is an all-order symbolic theorem; the finite
checks in the constructor merely verify its implementation.

##### 6.1 Explicit physical interaction word

Write the nonzero Pauli labels as X=(1,0), Z=(0,1), Y=(1,1). For physical
sites i,j and nonzero labels a,b, let G_{ij}(a,b) be the pure controlled-
Pauli Clifford with binary action

```math
p_i\longmapsto p_i+a B(b,p_j),\qquad
p_j\longmapsto p_j+b B(a,p_i),
```

where B(a,p)=a_x p_z+a_z p_x and both right sides use the old variables.
Its diagonal blocks are I. This gate is locally Clifford-equivalent to CZ,
so exactly one physical CNOT suffices. Equivalently, if T_v is the Pauli
transvection, G_{ij}(a,b)=T_{a_i+b_j}T_{a_i}T_{b_j}; the latter two are
free local gates and the first is one CNOT up to local gates.

Distinguish leaf 1 as the pivot. In chronological order use:

1. G_{0j}(X,X) once for each ordinary leaf j=2,...,k-1.
2. G_{01}(Y,X).
3. G_{0j}(Z,Z) once for each ordinary leaf.
4. G_{01}(Y,Z).
5. G_{0j}(X,Y) once for each ordinary leaf.

Gates within each listed sweep commute, so any fixed leaf order is valid.
This literal star word has 3(k-2)+2=3k-4 one-CNOT interactions. No output
permutation or hidden SWAP is present.

##### 6.2 Symbolic calculation for arbitrary odd size

Let the input center coordinates be (x,z), the pivot coordinates be (y,w),
and the ordinary leaf coordinates be (u_j,v_j). Put

```math
U=\sum_{j=2}^{k-1}u_j,\qquad V=\sum_{j=2}^{k-1}v_j.
```

The number m=k-2 of ordinary leaves is odd. The first sweep sends the
center to (x+V,z) and each ordinary leaf to (u_j+z,v_j). Applying the
first pivot gate, second sweep, second pivot gate and third sweep in order
gives the final variables

```math
\begin{aligned}
p_0'&=(x+y+U,\;x+z+y+w+U+V),\\
p_1'&=(x+z+y+V,\;x+w+U+V),\\
p_j'&=(u_j+x+y+w+U+V,\;v_j+z+y+U),\qquad j\ge2.
\end{aligned}
\tag{S1}
```

Every cancellation here uses m=1 in F_2 and is independent of the size of
the star. For example immediately before the last sweep the center is
(y+w+z, x+z+y+w+U+V); the last sweep adds
U+z+V+x+V+w to its first coordinate, giving x+y+U.

Define the two-by-two matrices

```math
R=\begin{pmatrix}1&1\\1&0\end{pmatrix},\qquad
H=\begin{pmatrix}0&1\\1&0\end{pmatrix},\qquad R^3=I.
```

Let N_k have diagonal blocks R and off-diagonal blocks I. The matrix F
in (S1) satisfies the exact block identity

```math
F=\operatorname{diag}(H,R,I,\ldots,I)\;N_k\;
       \operatorname{diag}(I,R,R,\ldots,R).
\tag{S2}
```

To verify (S2), the ordinary rows have blocks I in the center column, R in
the pivot column, R^2 at their own column and R at every other ordinary
column. The pivot row has blocks R, I, R^2,...,R^2. The center row has the
same block HR at every column. These are exactly (S1).

For odd k the published dual-axis map has diagonal blocks R^2 and
off-diagonal blocks R. Left multiplication by the site-local matrix R^2
at every output converts it to N_k. Thus (S2) proves that the displayed
star circuit is shadow-optimal for every odd k. This proof uses the
source-optimal dual-axis family, not the false assertion that full block
ranks alone suffice at all orders.

The tree transfer theorem supplies the matching lower bound 3k-4 and
therefore proves exactness. At k=3 the value 5 agrees with the known
three-site path/star baseline; the new assertion is the uniform sharp
star law, with every physical gate and the arbitrary-size normalization
specified.

**Exact weighted corollary.** Give the star edges arbitrary nonnegative
CNOT costs w_1,...,w_{k-1}. For every odd k>=3 the minimum total cost is

```math
3\sum_{j=1}^{k-1}w_j-\max_j w_j.
\tag{S3}
```

Choose a heaviest leaf as the pivot in the same literal word. Its edge is
used twice; each other edge is used three times, giving (S3). The weighted
odd-tree transfer bound in Appendix K supplies the reverse
inequality for every circuit. Choosing a different pivot only relabels
the actual endpoints of the listed star gates; it inserts no SWAP. Zero
edge costs are permitted and cause no change in the argument.

##### 6.3 Constructor and limits

`code/path_star_family.py` expands each G into H/S/CNOT gates, checks that
every CNOT has center 0 as one endpoint, compares the full binary matrix
with both (S1) and (S2), and records the exact count. Direct full-support
score checks at small sizes provide an additional implementation check.

The star theorem does not prove the path formula for larger k and does
not replace the original complete/path targets. Even-star sharpness is
a distinct question, treated with an explicit remaining gap below.

#### 7. Uniform even-star construction with a one-CNOT gap

For every even k>=4 there is an optimal-shadow star circuit with 3k-4
CNOTs. Together with the tree lower bound this gives

```math
3k-5\le g_{K_{1,k-1}}(k)\le3k-4.
\tag{S4}
```

It is not asserted here that either endpoint of this interval is sharp.

Use the same center 0, pivot leaf 1 and ordinary leaves as before, but
change the five stages to:

1. G_{0j}(X,X) on each ordinary leaf.
2. G_{01}(Y,X).
3. G_{0j}(Z,Z) on each ordinary leaf.
4. G_{01}(X,Z).
5. G_{0j}(Y,Y) on each ordinary leaf.

The number m=k-2 of ordinary leaves is now even. In the notation of
(S1), direct symbolic application of the five stages yields

```math
\begin{aligned}
p_0'&=(z+y+w+U+V,\;z+w+V),\\
p_1'&=(x+z+y+V,\;z+U),\\
p_j'&=(u_j+z+y+U,\;v_j+x+y+w+U+V),\qquad j\ge2.
\end{aligned}
\tag{S5}
```

For example the second sweep leaves the center at
(x+V+w,z+w+U); the second pivot gate changes this to
(y+w+z,z+w+U), and the last sweep adds U+V to both coordinates.
Every ordinary leaf gains y+U at that last stage. These identities use
m=0 in F_2 and so hold at every even size.

Put

```math
S=\begin{pmatrix}1&0\\1&1\end{pmatrix},\quad
Q=\begin{pmatrix}1&1\\0&1\end{pmatrix},\quad
D=\begin{pmatrix}0&0\\1&0\end{pmatrix}.
```

Let N_D have diagonal blocks D and off-diagonal blocks I. The full matrix
of (S5) is

```math
F_{\rm even}=\operatorname{diag}(R^2,R,I,\ldots,I)\;N_D\;
       \operatorname{diag}(H,S,S,\ldots,S).
\tag{S6}
```

Indeed, ordinary rows have blocks H at the center, S at the pivot and
other ordinary leaves, and D at their own leaf. The pivot row has blocks
Q at the center, diag(1,0) at the pivot and H elsewhere. The center row
has its diagonal block [[0,1],[0,1]] and Q at every leaf. These are
precisely the blocks in (S5) and (S6).

The source even dual-axis map has diagonal blocks K=I+H and off-diagonal
blocks H. Left multiplication by H at each site gives diagonal K and
off-diagonal I. Since Q K Q^{-1}=D, simultaneous site-local conjugation
by Q gives N_D. Thus (S6) is a local equivalence to the source-optimal
even family and proves the uniform upper bound in (S4).

With nonnegative star edge weights the same choice of a heaviest pivot
has cost 3 sum_j w_j-max_j w_j. The available weighted tree lower bound
is 3 sum_j w_j minus the sum of the two largest leaf weights, so the
remaining weighted gap is at most the second-largest edge weight. This
is a bound, not an exact weighted-even formula.

The attempted two-pivot three-sweep ansatz at cost 3k-5 produced no
witness among its 98,415 tested parameter settings. That finite failure
does not exclude other words, arbitrary interleavings, or other local
frames and is not used in (S4). It is retained only as research history.


---

## Appendix M. Uniform complete-graph improvement

### A nine-CNOT dual-axis coset and an improved all-odd-size construction

This note preserves the original ancilla-free CNOT plus free one-qubit
Clifford model. Physical wire permutations are not free. The exact resource
law at arbitrary size is **not** claimed to be closed.

#### 1. Statements

Let `g_K(k)` minimize the CNOT count over all symplectic maps attaining the
source-optimal two-sided locally randomized shadow score. The present
increment proves

```math
g_K(k)\le 3k-6\qquad\text{for every odd }k\ge5.
\tag{1}
```

The previous uniform odd-size upper bound was `3k-5`. Together with the
existing even-size construction, (1) gives the unified upper bound
`g_K(k)<=3k-6` for **every** `k>=4`. The new construction does not improve the
leading linear coefficient from three, and no such improvement is claimed.

The seed is a nine-CNOT circuit in the **dual-axis** local/input-output
permutation class at five qubits. The previous nine-CNOT witness in this
case was in the exceptional class. Combining this new witness with the
exhaustive exclusion of eight CNOTs in the dual-axis
coset proves that the minimum over that coset is exactly nine.

This is not a nine-CNOT synthesis claim for the particular unpermuted
unitary `U_*`. The circuit's final matrix has a nontrivial output-placement
permutation relative to a locally normalized dual-axis matrix. It is itself
an eligible optimizer and contains no wire-permutation gate.

The same gate count can be obtained with CNOT depth at most

```math
6\left\lceil\log_3(k-4)\right\rceil+7.
\tag{2}
```

The convention is that the logarithmic term is zero for `k=5`. This depth
upper bound is not asserted optimal. It uses a balanced ternary encoder
and is included as a constructive consequence of the new seed.

#### 2. Exact seed and physical circuit

Coordinates are `(x_0,z_0,...,x_4,z_4)`. A pair `(a,b)` denotes the two
bit-packed rows of a binary two-by-two matrix. Thus

```math
I=(1,2),\quad R=(2,3),\quad R^2=(3,1).
```

The bounded discovery probe returned the compact word

```text
(3,4,2,2), (0,1,2,3), (0,2,3,1),
(2,4,3,1), (1,2,2,1), (2,3,3,1),
(0,3,2,2), (0,1,3,3), (3,4,3,3).
```

Each entry is a weight-two Pauli transvection followed by the specified
canonical free local normalization. The `transvection_word_gates` routine
expands this word into
literal H, S, and CNOT gates. Each entry contributes exactly one CNOT. The
unmodified word replays to rows

```math
(430,601,427,598,442,613,341,767,490,661).
```

Relabel **the physical circuit** simultaneously by exchanging wire names
0 and 2, and append the free local row action `(1,3)` at site 0. This gives
the seed matrix `M` used below, with rows

```math
(427,1021,442,613,430,601,341,767,490,661).
\tag{3}
```

Simultaneously relabelling an actual complete-graph circuit merely changes
the allowed endpoints written on its gates. It does not execute a SWAP.
The literal gate list is in `results/complete_dual_seed.json`; the
deterministic constructor is `code/complete_dual_family.py`.

##### Explicit dual-axis class membership

Let `N_5` have diagonal physical blocks `R` and off-diagonal blocks `I`, as
in the original classification. Put

```math
\pi=(0)(1\ 2)(3\ 4),
```

and take local matrices, written by their packed rows,

```math
\begin{aligned}
(A_0,A_1,A_2,A_3,A_4)&=((2,3),(2,1),(2,1),(1,3),(2,1)),\\
(B_0,B_1,B_2,B_3,B_4)&=((1,2),(1,2),(1,2),(1,2),(2,1)).
\end{aligned}
```

All ten matrices are invertible over the binary field. Direct two-by-two
multiplication in each of the 25 blocks gives

```math
M_{ij}=A_i(N_5)_{\pi(i),j}B_j.
\tag{4}
```

Thus the seed is in the dual-axis class. Its source score is exactly
`2403`, independently verified by evaluating all `3^5=243` full-support
input labels. Equation (4) is a complete finite algebraic certificate of
class membership, stronger than relying only on a sign-invariant test.

The old dual-axis eight-gate exclusion remains the lower-bound input:
Appendix H, Section 5, and
`code/new_lmc_k5_exhaustion.json`. That search covered the correct
complete-graph local/permutation coset and completed normally. Hence

```math
\min_{M\text{ in the five-qubit dual-axis coset}}c_{K_5}(M)=9.
\tag{5}
```

Equation (5) uses an existing finite exhaustive certificate plus a new
physical witness; it is not an all-size lower-bound theorem.

#### 3. A three-CNOT encoder for an odd repeated plane

On three sites `(a,b,c)`, apply in chronological order

```math
\operatorname{CNOT}_{a\to b},\qquad
\operatorname{CNOT}_{c\to a},\qquad
\operatorname{CNOT}_{b\to c}.
\tag{6}
```

For `(a,b,c)=(0,1,2)` the symplectic rows are
`(17,10,5,34,21,42)`. The two columns belonging to input site `a` have
the identity block at every output site. Equivalently, the local Pauli
plane at `a` is sent to

```math
X_a\longmapsto X_aX_bX_c,\qquad
Z_a\longmapsto Z_aZ_bZ_c.
\tag{7}
```

The equality follows either by applying the three CNOT conjugation rules
or multiplying the six-by-six binary matrices. The circuit has three
physical CNOTs and no extra site. The edge `c->a` is valid on complete
connectivity; this three-gate construction is not being claimed on a
three-site labelled path.

For any odd `r`, a full ternary tree with `r` leaves has `(r-1)/2` internal
vertices. At each vertex use (6) on the representatives of its three child
groups, and then apply the three child encoders in their disjoint groups.
Induction on the tree gives an encoder `C_r` carrying the distinguished
local plane to the repeated plane on all `r` sites. Its CNOT count is

```math
3(r-1)/2.
\tag{8}
```

No qubit is initialized as an ancilla. The encoder is a reversible Clifford
on the original sites, and is applied to arbitrary input data.

For the depth statement choose balanced odd child sizes. If `r<=3^h`,
three positive odd sizes summing to `r` can be chosen with each at most
`3^(h-1)`. The root takes three CNOT layers, while child encoders execute
on disjoint sets. Thus `C_r` has depth at most `3 ceil(log_3 r)`.

#### 4. Inflation identity

Replace site 0 of the seed by `r` sites, where `r` is odd, and keep its
other four sites. The total size is `k=r+4`. Embed the seed at the
distinguished site of the repeated group and the four outside sites, and
use the actual circuit

```math
C_r\,(M\oplus I)\,C_r^{-1}.
\tag{9}
```

The chronological physical list is therefore `inverse(encoder)`, then the
seed gates, then `encoder`. The unspecified identity acts on the other
sites of the repeated group; this notation adds no ancillary system.

For input labels `p_1,...,p_r` in the repeated group, put

```math
v=p_1+\cdots+p_r.
```

Apply the five-site seed matrix to `(v,y)`, where `y` consists of the four
outside labels. Write its output as `(z,w)` and set `c=z+v`. The output of
(9) is exactly

```math
(p_1+c,\ldots,p_r+c,w).
\tag{10}
```

To prove (10), let `E` embed the distinguished two-dimensional plane as the
repeated plane. Because `r` is odd, `E` is symplectic. Its symplectic adjoint
is the sum map on the repeated group. Conjugating `M` by an encoder of this
plane acts as the identity on the orthogonal complement and changes the
repeated coordinates by the common increment `z-v=z+v`. This proves
(10). The same argument is the general inflation identity already proved
in Appendix J; the new ingredient here is the cheaper
complete-graph encoder and the different inflatable seed.

#### 5. Exact all-size score from a four-character identity

For `v,c` in the four-element additive group, define

```math
F_r(v,c)=\sum_{\substack{p_i\ne0\\\sum_i p_i=v}}
3^{\#\{i:p_i+c=0\}}.
```

Let `chi_u(v)=(-1)^(u dot v)` be its four characters. Fourier inversion
gives, for odd `r`,

```math
F_r(v,0)=\frac{3^r-\sum_{u\ne0}\chi_u(v)}4,
\tag{11}
```

while for nonzero `c`,

```math
F_r(v,c)=\frac14\left(
5^r-3^r\!\sum_{\substack{u\ne0\\\chi_u(c)=-1}}\chi_u(v)
+\!\sum_{\substack{u\ne0\\\chi_u(c)=1}}\chi_u(v)
\right).
\tag{12}
```

Indeed, the local weight on a nonzero label is one if `c=0`; its nontrivial
Fourier coefficients are `-1`. If `c!=0`, the weight is three at `c` and one
at the two other nonzero labels. Its Fourier coefficients are five at the
trivial character and `2 chi_u(c)-1` otherwise, hence are one or minus
three. Raising these coefficients to an odd power proves (11)-(12).

For each of the `81` outside full-support labels `y` and each of the four
values `v`, compute `(z,w)=M(v,y)`. Weight (11) or (12), with `c=z+v`, by
`3^(number of zero labels in w)`. This leaves a polynomial expression

```math
S_k=\frac{C_5 5^r+C_3 3^r+C_0}{4}.
```

The complete integer certificate for the seed (3) is

| Repeated-group sum `v` | contribution to `C_5` | contribution to `C_3` | contribution to `C_0` |
|---|---:|---:|---:|
| `0` | 468 | -915 | 405 |
| `1` | 469 | 332 | -137 |
| `2` | 469 | 332 | -137 |
| `3` | 469 | 332 | -137 |
| Total | **1875** | **81** | **-6** |

Every entry is the exact finite sum specified above; the constructor
recomputes it using integers. Consequently

```math
S_k=\frac{1875\,5^r+81\,3^r-6}{4}
=\frac{3\,5^{r+4}+3^{r+4}-6}{4}=s_k.
\tag{13}
```

This proves exact statistical optimality for **every** odd `k>=5`.
The finite arithmetic determines the coefficients in a proved symbolic
identity; it is not a finite-size experiment extrapolated to arbitrary `k`.

By (8), the CNOT count in (9) is

```math
9+2\cdot\frac{3(r-1)}2=3r+6=3k-6,
```

proving (1). The seed's entangling depth is at most seven by scheduling its
nine CNOTs subject to the order on each wire. Combining this with the
balanced encoder proves (2).

#### 6. Reproduction and limitations

From the directory containing the accompanying code:

```bash
python code/complete_dual_family.py --k 7 --output /tmp/dual-k7.json
python code/complete_dual_family.py --k 9 --output /tmp/dual-k9.json
```

The constructor emits actual physical gate lists, counts all CNOTs,
replays the exact binary tableau, checks symplecticity, compares with
(10), and recomputes all 324 seed coefficient contributions. For the
requested small sizes it additionally evaluates the full score directly.
The literal seed and symbolic identity supply the proof.

The nine-CNOT seed was found by a bounded heuristic restricted to the
dual-axis sign class; the proof rests on its literal circuit, (4), and
(11)-(13). Bounded searches at `k=6`, budget eleven, and `k=7`, budget
fourteen, found no witness within five million iterations each. These
negative searches establish no lower bound and are not evidence of
minimality. The original all-size lower-versus-upper gap remains open.

The general Clifford score optimum and the old even-size upper bound
remain attributed to Nie--Zhang--Wu--Chen, arXiv:2610.04621v2. The old
eight-CNOT exclusion uses Jorgensen's LMC bound as its admissible heuristic,
arXiv:2609.16208v1, Theorem 6.3. No new general LMC theorem, optimal leading
gate coefficient, external peer review, or Lean validation is claimed.


---

## Appendix N. Exact orbit count and recognition

### Exact optimizer counts and quadratic-time recognition

The orbit count and recognition algorithm use the all-order classification
in Appendices C and D.

#### 1. Setting and statements

Work over $\mathbb F_2$, with labelled physical input and output sites.
Write a $2k\times2k$ binary matrix as a $k\times k$ array of
$2\times2$ blocks. Let

```math
G=\operatorname{GL}(2,2)=\operatorname{Sp}(2,2),\quad |G|=6,
\qquad
I=\begin{pmatrix}1&0\\0&1\end{pmatrix},
\quad J=\begin{pmatrix}0&1\\1&0\end{pmatrix},
```
```math
R=\begin{pmatrix}0&1\\1&1\end{pmatrix},\qquad
K=\begin{pmatrix}1&1\\1&1\end{pmatrix}.
```

Thus $R^3=I$, $R\ne I$, $I+R+R^2=0$, and
$K\ne0$, $K^2=0$. Put $T=R$ for odd $k$, and $T=K$
for even $k$. For a permutation $\pi\in S_k$, define

```math
N^\pi_{ij}=\begin{cases}T&j=\pi(i),\\I&j\ne\pi(i).\end{cases}
\tag{1}
```

Appendix C, Theorem 7, and Appendix D, Section 9, establish that, for every $k\ge6$, the shadow-score maximizers are exactly
the matrices

```math
M_{ij}=A_iN^\pi_{ij}B_j,\qquad
A_1,\ldots,A_k,B_1,\ldots,B_k\in G,
\quad\pi\in S_k.
\tag{2}
```

The odd statement is therefore used only for odd $k\ge7$. Both choices
of an order-three generator give the same family, since they are
conjugate in $G$. The permutations in (2) describe labelled matrices;
they are not treated as free physical circuit operations.

**Theorem 1 (intrinsic matching and stabilizer).** For $k\ge6$, the
matching $\pi$ in (2) is uniquely determined by the matrix $M$,
even when $k$ is odd and every block is invertible. For a fixed
matching, exactly $|C_G(T)|$ local-factor tuples represent any given
matrix, where

```math
C_G(R)=\{I,R,R^2\},\quad |C_G(R)|=3,
\qquad C_G(K)=\{I,J\},\quad |C_G(K)|=2.
\tag{3}
```

Under the full action by independent input/output local groups and
input/output site permutations, the stabilizer of $N^{\mathrm{id}}$
is isomorphic to $C_G(T)\times S_k$. There are no additional
stabilizers using unmatched row and column permutations.

**Corollary 2 (exact counts).** The number $a_k$ of distinct labelled
binary symplectic shadow optimizers is

```math
\boxed{
a_k=\begin{cases}
6^{2k}k!/2,&k\ge6\text{ even},\\[2pt]
6^{2k}k!/3,&k\ge7\text{ odd}.
\end{cases}}
\tag{4}
```

This counts matrices, not signed Clifford tableaus or unitaries with
arbitrary global phase. No phase factor is implicitly included.

**Theorem 3 (recognition and certificate).** For every $k\ge6$, an
arbitrary binary $2k\times2k$ matrix can be tested for optimality
using $O(k^2)$ operations on constant-size blocks. A positive answer
produces $\pi,A_1,\ldots,A_k,B_1,\ldots,B_k$ satisfying (2), which
can be independently verified in $O(k^2)$ operations. The certificate
uses $O(k\log k)$ bits. No prior symplecticity promise and no
enumeration of the $3^k$ full-support Pauli labels are required.

The running time is optimal in the dense-block input model, in which a
generic $\Theta(k^2)$-block input must be read. This is an exact
decision procedure on binary data, not a noisy-data identification
claim.

#### 2. The matching is visible in intrinsic rectangles

##### 2.1 Even order

In (2), local factors preserve each block's rank. The blocks at the
matching positions have rank one; every other block has rank two.
Consequently the rank-one positions directly recover $\pi$.
This is a necessary condition on arbitrary input, but it is not the
complete recognition test: the previously proved six-site counterexample
has this rank pattern and is not optimal.

##### 2.2 Odd order

Every block is invertible. For distinct rows $i,h$, put

```math
X_j=M_{ij}M_{hj}^{-1}.
```

In a representation (2), column factors cancel and

```math
X_j=A_iN^\pi_{ij}(N^\pi_{hj})^{-1}A_h^{-1}
=\begin{cases}
A_iRA_h^{-1},&j=\pi(i),\\
A_iR^{-1}A_h^{-1},&j=\pi(h),\\
A_iA_h^{-1},&j\notin\{\pi(i),\pi(h)\}.
\end{cases}
\tag{5}
```

The three displayed values are distinct. Hence the multiplicities are
exactly $k-2,1,1$. Since $k\ge7$, the repeated value is unique,
and the set of its two exceptions is the intrinsic set

```math
E_{ih}=\{\pi(i),\pi(h)\}.
\tag{6}
```

More invariantly, define the rectangle product

```math
H_{ih;j\ell}
=M_{ij}M_{hj}^{-1}M_{h\ell}M_{i\ell}^{-1}
=X_jX_\ell^{-1}.
\tag{7}
```

It is conjugated by the local factor on row $i$, and is unaffected
by column locals. Therefore $H_{ih;j\ell}=I$ is invariant under
arbitrary independent local factors. The equivalence relation on columns
given by this equality has one class of size $k-2$ and two singleton
classes. Those two singletons are precisely (6). One need not compute
all $O(k^4)$ rectangles: grouping the $k$ ratios $X_j$ gives
the same relation in $O(k)$ time for a chosen row pair.

Choose three distinct reference rows, labelled $0,1,2$. Then

```math
\{\pi(0)\}=E_{01}\cap E_{02},\qquad
\{\pi(i)\}=E_{0i}\setminus\{\pi(0)\}\quad(i\ne0).
\tag{8}
```

Thus the matching is uniquely determined by the matrix. Only $k-1$
row pairs are used, so its extraction costs $O(k^2)$ block
operations. This rules out the proposed hidden freedom of moving the
diagonal matching by independent row and column permutations while
absorbing the change into local matrices. Such an equivalence would
give a different matching for the same intrinsic sets (6), contrary to
(8).

The argument for matching uniqueness in the odd normal-form family
actually works for every $k\ge4$. That observation does not assert
that this family exhausts shadow optimizers below the stated scope.
At $k=5$ there is a second optimizer class. At $k=3$, all three
values in (5) have multiplicity one, so the matching is not recovered
this way and the count (4) does not extend. Section 6 checks that this
exception reflects a real extra stabilizer rather than a proof defect.

#### 3. All remaining gauge freedom is global

Fix a matching and relabel it to the diagonal for this argument. Suppose
two local-factor tuples represent the same matrix. Their quotient is
a family $U_i,V_j\in G$ satisfying

```math
U_iN^{\mathrm{id}}_{ij}V_j=N^{\mathrm{id}}_{ij}
\quad\text{for every }i,j.
\tag{9}
```

For $i\ne j$, equation (9) says $U_iV_j=I$. Given any two
rows $i,h$, choose a column $j\notin\{i,h\}$, possible for
$k\ge3$. Then $U_iV_j=U_hV_j=I$, so $U_i=U_h$.
All $U_i$ therefore have one common value $U$, and all $V_j$
are $U^{-1}$. At a matching block, (9) becomes

```math
UTU^{-1}=T.
\tag{10}
```

Conversely, every $U\in C_G(T)$ gives exactly this gauge. Hence
each fixed-matching factorization has exactly $|C_G(T)|$ lifts.

For $R$, a direct computation in the six-element group gives the
three powers of $R$. Equivalently, the invertible matrices commuting
with a matrix with irreducible minimal polynomial $x^2+x+1$ are the
three nonzero elements of $\mathbb F_4$. For $K$, its nonzero
nilpotent Jordan form has commutant $\{aI+bK:a,b\in\mathbb F_2\}$,
whose invertible elements are $I$ and $I+K=J$. This proves (3).

Every pair of site permutations preserving the intrinsic diagonal
matching is simultaneous: after fixing the relabelling convention, its
row and column permutations coincide. Every simultaneous permutation
fixes $N^{\mathrm{id}}$, and commutes with the common local gauge.
This proves the stabilizer statement. Alternatively, count (2)
directly: its $k!$ distinct matchings give disjoint sets, and each
has $6^{2k}/|C_G(T)|$ distinct matrices. This proves (4) without
relying on a convention for writing permutation matrices on the right.

For clarity, the full action group has cardinality
$6^{2k}(k!)^2$, and its stabilizer has cardinality
$|C_G(T)|k!$. Their ratio agrees with (4).

#### 4. A constructive recognition algorithm

The procedure below runs on arbitrary binary blocks. Necessity follows
from (2); sufficiency follows from the factorization it returns.

##### Step 1: recover a candidate matching

For even $k$, require exactly one rank-one block in each row and each
column, with all other blocks invertible. Their positions give $\pi$.
Reject if this fails.

For odd $k$, require every block invertible. For each $i\ne0$,
compute the $k$ ratios $M_{0j}M_{ij}^{-1}$ and require their
multiplicities to be $k-2,1,1$. Use the exception sets and (8) to
recover $\pi$. Require the indicated intersections to be singletons,
all exception sets to contain the recovered center, and the resulting
$\pi$ to be a permutation. Reject otherwise.

These tests use constant-size inverses only. The even rule's rank test
also guarantees that all off-matching blocks used below are invertible.

##### Step 2: factor all off-matching blocks

Seek $A_i,B_j\in G$ with $M_{ij}=A_iB_j$ for
$j\ne\pi(i)$. Fix the global gauge $A_0=I$. Set

```math
B_j=M_{0j}\qquad(j\ne\pi(0)).
\tag{11}
```

For each $i\ne0$, choose any
$c_i\notin\{\pi(0),\pi(i)\}$, and set

```math
A_i=M_{i c_i}B_{c_i}^{-1}.
\tag{12}
```

Fill the remaining column factor using any $h\ne0$, for example
$h=1$:

```math
B_{\pi(0)}=A_h^{-1}M_{h,\pi(0)}.
\tag{13}
```

Finally verify $M_{ij}=A_iB_j$ at all $k(k-1)$ off-matching
positions. The assignments (11)--(13) are a spanning-tree normalization
of the bipartite graph $K_{k,k}$ with the matching removed; its
remaining equations check the global compatibility of the rectangle
relations. Choosing a few anchors without verifying all remaining
positions would not be a valid recognition algorithm.

If a genuine factorization exists, choosing $A_0=I$ merely changes
its common gauge. Equations (11)--(13) then reconstruct that
factorization, so the verification cannot falsely reject an orbit
member.

##### Step 3: check the normalized matching residuals

Compute

```math
C_i=A_i^{-1}M_{i,\pi(i)}B_{\pi(i)}^{-1}.
\tag{14}
```

Require all $C_i$ to have a common value $C$, and require
$C$ to be conjugate to $T$ in $G$. These are constant-size
tests: enumerate the six possible $g\in G$ and find one with
$g^{-1}Cg=T$. Equivalently, the odd residual must have order three;
the even residual must be nonzero with square zero. Uniform enumeration
avoids introducing a separate convention for either conjugacy class.

Replace

```math
A_i\leftarrow A_i g,\qquad B_j\leftarrow g^{-1}B_j.
\tag{15}
```

Off-matching products are unchanged, and matching products now contain
the fixed matrix $T$. Thus (2) holds at every block. Return this
factorization as a positive certificate.

##### Why no separate symplecticity check is needed

Every local factor and every site permutation is symplectic. The
normalized $N^{\mathrm{id}}$ is also symplectic at its indicated
parity. This can be checked without an appeal to the score theorem:
for a block row, the sum of block determinants is one. For two distinct
rows, the odd cross pairing is

```math
RJ+JR^{\mathsf T}+(k-2)J
=(R+R^{-1}+I)J=0,
```

and the even cross pairing is

```math
KJ+JK^{\mathsf T}+(k-2)J=K+K=0.
```

Thus $NJN^{\mathsf T}=J$, where the ambient $J$ is block
diagonal. A verified factorization therefore implies symplecticity as
well as optimizer membership under the existing classification.

All blocks of the input are read a constant number of times; products,
inverses, ranks, and conjugacy tests on $2\times2$ binary matrices
have constant cost. The runtime is $O(k^2)$. Besides the stored
input, the matching, ratio counts, and factor arrays require $O(k)$
constant-size entries plus the $O(k\log k)$-bit matching labels.
The independent verifier only evaluates the right side of (2) at each
position.

#### 5. An exact sampler as a direct corollary

Choose $\pi$ uniformly from $S_k$, and all $A_i,B_j$
independently and uniformly from $G$; output (2). Theorem 1 proves
that every optimizer has exactly the same number $|C_G(T)|$ of
preimages under this parameterization. The resulting distribution is
therefore exactly uniform on labelled optimizer matrices.

This gives a direct sampler that does not use rejection from the full
symplectic group or score computation. It samples matrices, and its
local/permutation certificate does not specify a minimum-CNOT
implementation. The implementation uses Python's seeded pseudorandom
generator for reproducibility; cryptographic randomness is not claimed.

#### 6. Exact checks and limits of the executable evidence

The standalone standard-library implementation is
[orbit_recognition.py](code/orbit_recognition.py). Reproduce the
saved checks from the directory containing the accompanying code with:

```sh
python3 code/orbit_recognition.py --self-test --output code/orbit_checks.json
```

The harness separates the analytic proof from several independent
finite checks:

1. It enumerates the centralizers in the six-element group and directly
   checks symplecticity of the normalized representatives for
   $2\le k\le17$.
2. For odd $k=3,5,7$, it exhausts every relative matching and all
   residual global conjugations after normalizing the first row and
   column to identity. This uses a dense dephasing algorithm independent
   of the new matching recognizer. At $k=5,7$, only the identity
   relative matching is locally equivalent to the identity matching,
   as the theorem predicts. At $k=3$, all six relative matchings
   are equivalent, explicitly detecting the extra symmetry outside
   the theorem's scope.
3. For even $k=4,6$, it exhausts the local factors fixing the
   normalized parity-shift direction, namely $\{I,J\}^{2k}$.
   There are $2^{2k-1}$ distinct matrices, checking the predicted
   two-element global gauge independently of recognition.
4. For each $k=6,7,8,9,12,17$, it recognizes 80 independently
   generated orbit members and verifies the returned factorization and
   matching. It alters one block of each matrix, checks that the old
   certificate fails, and runs the new recognizer on the altered
   matrix. Any acceptance must carry a new valid certificate.
5. It rejects the exact symplectic six-site and nine-site
   counterexamples to rank-pattern sufficiency from the earlier
   proofs. The former has the necessary rank-one matching; the latter
   has every block invertible. Thus the recognizer is checked against
   mathematically meaningful non-optimizers that pass the first rank
   screening.

The exact output is [orbit_checks.json](code/orbit_checks.json).
Finite checks corroborate the formulas and implementation; the
all-order proof is Sections 2--4. The counting and recognition results do not determine the general sharp
resource minima.
