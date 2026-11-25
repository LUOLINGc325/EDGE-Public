# Every finite graph has a clique dually conformal induced extension

24 November 2026

## Abstract

We give an affirmative answer to Question 1 of Boros, Gurvich, Milanič, Tikhanovsky, and Uno, which asks whether every graph is an induced subgraph of a clique dually conformal graph. For a nonempty finite simple graph with $n$ vertices and $c$ maximal cliques, the extension has exactly $2n+c$ vertices. It is obtained by adding a private leaf at each original vertex and one simplicial vertex for each original maximal clique. We determine all maximal cliques and all inclusion-minimal clique transversals of the extension, and prove directly that its clique-dual has precisely those transversals as its maximal cliques. The result concerns all nonempty finite simple graphs. The size bound depends on the number of maximal cliques and is not a polynomial-size guarantee in $n$.

## 1. Problem and scope

All graphs in this manuscript are finite, simple, undirected, and nonempty, following the convention in [1]. A clique is a set whose distinct vertices are adjacent. A maximal clique is maximal under inclusion, not necessarily of maximum cardinality. We write $\mathcal C(G)$ for the family of maximal cliques of a graph $G$.

A clique transversal meets every member of $\mathcal C(G)$. A minimal clique transversal is minimal under inclusion. The **clique-dual** $G^{\mathrm c}$ has the same vertex set as $G$; two distinct vertices are adjacent exactly when some minimal clique transversal contains both. A graph is **clique dually conformal**, abbreviated CDC, when the maximal cliques of $G^{\mathrm c}$ are exactly the minimal clique transversals of $G$. This is the equivalent formulation in Observation 3.1 of [1].

Question 1 in Section 9 of [1] asks:

> Is every graph an induced subgraph of a CDC graph?

Corollary 6.7 of [1] already gives a positive answer for triangle-free graphs by adding one private leaf per vertex. The theorem below removes the triangle-free restriction. It does not settle the recognition complexity of CDC graphs or the other questions in Section 9 of [1].

**Theorem 1 (induced extension).** Let $G$ be any nonempty finite simple undirected graph. There is a finite simple undirected CDC graph $H$ in which the original vertices induce exactly $G$. The construction below has

$$
|V(H)|=2|V(G)|+|\mathcal C(G)|.
$$

Theorem 1 is the complete target of this work. The descriptions in Lemmas 2 and 3 and Proposition 4 establish it without assuming any further property of $G$.

## 2. The construction and its maximal cliques

Write $V=V(G)$. Use three disjoint kinds of vertices:

$$
V(H)=\{o_v:v\in V\}\;\dot\cup\;\{\ell_v:v\in V\}
\;\dot\cup\;\{t_C:C\in\mathcal C(G)\}.
$$

The original vertices $o_v$ inherit the edges of $G$. The leaf $\ell_v$ is adjacent only to $o_v$. The tip $t_C$ is adjacent exactly to the original vertices $o_v$ with $v\in C$. There are no edges between added vertices. These rules define a simple undirected graph, and $v\mapsto o_v$ is an injective map preserving both adjacency and nonadjacency. The three tagged vertex sets give the cardinality in Theorem 1.

For $v\in V$ and $C\in\mathcal C(G)$, put

$$
P_v=\{o_v,\ell_v\},\qquad
E_C=\{o_v:v\in C\}\cup\{t_C\}.
$$

**Lemma 2 (complete clique list).** The maximal cliques of $H$ are exactly the sets $P_v$ and $E_C$.

*Proof.* Each $P_v$ is a clique and cannot be enlarged, because $\ell_v$ has only the neighbor $o_v$. Each $E_C$ is a clique and cannot be enlarged, because all neighbors of $t_C$ are already in $E_C$.

Conversely, a clique containing a leaf $\ell_v$ is contained in $P_v$. A clique containing a tip $t_C$ is contained in $E_C$. A clique containing only original vertices corresponds to a clique of $G$. Since $G$ is finite, that clique extends to a maximal clique $C$ of $G$, and adding $t_C$ strictly enlarges it in $H$. Consequently no clique consisting only of original vertices is maximal in $H$. This proves completeness of the list. $\square$

Finiteness in the extension step can be seen directly: among all cliques of $G$ containing the given clique, choose one of largest cardinality. It is maximal under inclusion. Isolated original vertices cause no exception: their singleton maximal cliques receive their own tips.

## 3. Every minimal transversal in closed form

For every subset $X\subseteq V$, define

$$
T_X=\{o_v:v\in X\}
\cup\{\ell_v:v\notin X\}
\cup\{t_C:C\in\mathcal C(G),\ C\cap X=\varnothing\}.
$$

**Lemma 3 (complete transversal list).** A vertex set $T$ is a minimal clique transversal of $H$ if and only if $T=T_X$ for a unique subset $X\subseteq V$.

*Proof: existence and minimality.* The set $T_X$ meets every $P_v$ in exactly one vertex. It also meets every $E_C$: if $C\cap X$ is nonempty, one of the corresponding original vertices is present; otherwise $t_C$ is present.

Every selected original vertex or leaf is the unique selected vertex of its pair $P_v$. Removing it would leave that maximal clique unhit. Every selected tip $t_C$ is the unique selected vertex of $E_C$, because its selection means $C\cap X=\varnothing$. Removing it would likewise leave a maximal clique unhit. Hence $T_X$ is inclusion-minimal.

*Proof: exhaustiveness and uniqueness.* Let $T$ be a minimal clique transversal. Each pair $P_v$ must be hit. Both members cannot belong to $T$: if they did, deleting $\ell_v$, which belongs to no other maximal clique, would preserve the transversal property. Thus exactly one member of each pair is selected. Define

$$
X=\{v\in V:o_v\in T\}.
$$

If $C\cap X=\varnothing$, hitting $E_C$ forces $t_C\in T$. If $C\cap X\ne\varnothing$, a selected $t_C$ could be removed, because it belongs to no maximal clique other than $E_C$, which is already hit by an original vertex. Therefore $t_C\notin T$ in this case. These observations give $T=T_X$. The original vertices of $T_X$ recover $X$, so $X$ is unique. $\square$

## 4. Conformality and the clique-dual

**Proposition 4 (no missing clique in the dual).** Every clique $Q$ in $H^{\mathrm c}$ is contained in some $T_X$. Moreover, the maximal cliques of $H^{\mathrm c}$ are exactly the sets $T_X$.

*Proof.* By Lemma 3, no minimal clique transversal contains both $o_v$ and $\ell_v$. Also, no minimal clique transversal contains both $o_v$ and $t_C$ when $v\in C$. These pairs are consequently nonadjacent in $H^{\mathrm c}$.

Let $Q$ be any clique of $H^{\mathrm c}$ and set $X=\{v:o_v\in Q\}$. Its original vertices belong to $T_X$ by definition. If $\ell_v\in Q$, then $o_v\notin Q$, so $v\notin X$ and $\ell_v\in T_X$. If $t_C\in Q$, no $o_v$ with $v\in C$ can belong to $Q$. Thus $C\cap X=\varnothing$ and $t_C\in T_X$. All vertex types have been covered, proving $Q\subseteq T_X$.

Each $T_X$ is a clique of $H^{\mathrm c}$, since it is itself a minimal transversal. It is maximal: an omitted original vertex is incompatible with its selected leaf; an omitted leaf is incompatible with its selected original vertex; and an omitted tip $t_C$ is incompatible with a selected original vertex belonging to $C\cap X$. Every omitted vertex is therefore excluded from any clique extending $T_X$.

Finally, a maximal clique $Q$ is contained in some clique $T_X$, so it equals $T_X$. This proves the claimed equality of families. $\square$

By the definition of CDC, Proposition 4 proves that $H$ is CDC. The induced embedding and the cardinality calculation from Section 2 complete Theorem 1.

## 5. Verification and provenance

The general proof uses no search assumption or numerical approximation. The companion Lean source formalizes the graph definitions, the construction, the complete clique and transversal descriptions, conformality, the induced embedding, and the cardinality formula. The corresponding Lean source is not included in this release. Computational checks are supplementary and do not replace the quantified proof.

An independent implementation constructs the extension from its adjacency relation, enumerates its maximal cliques, computes their inclusion-minimal hitting sets, and recomputes maximal cliques in the co-occurrence graph. It checks all 1,099 labelled nonempty simple graphs on at most five vertices. The complete script and recorded results accompany the manuscript.

This manuscript does not claim worldwide priority. The archived source comparison uses the full text of arXiv:2405.10789v2; the published article's metadata and indexed question were also checked, but its publisher PDF was not downloaded. This manuscript has not undergone external peer review.

## References

[1] Endre Boros, Vladimir Gurvich, Martin Milanič, Dmitry Tikhanovsky, and Yushi Uno. *Conformality of minimal transversals of maximal cliques*. Discrete Mathematics **349**(1), 114657 (2026). DOI: [10.1016/j.disc.2025.114657](https://doi.org/10.1016/j.disc.2025.114657). Full-text version checked: [arXiv:2405.10789v2](https://arxiv.org/html/2405.10789v2), revised 20 June 2025. Relevant locations: Section 2, Observation 3.1, Corollary 6.7, Section 9 Question 1.
