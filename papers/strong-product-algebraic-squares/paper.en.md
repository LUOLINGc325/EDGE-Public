# Algebraic squares of strong products and repair along a fixed core

**Abstract.** A graph is an algebraic square when it can be assembled from two isomorphic copies glued along a common nonempty labeled core with two nonempty anticomplete wings. A connected strong product is a square exactly when one of its factors is, while disconnected products have an additional component-multiplicity obstruction. The recognition theorem extends to any number of equal wings, with explicit maximum-wing and fixed-core formulas. For local repair by deleting individual vertices outside a protected core, we give a complexity boundary on cluster graphs. Two equal wings can be repaired in polynomial time by weighted matching. Three-wing repair is NP-complete even when the components outside the core have order at most three. In that reduction, the local calculation for any specified group is just a multiset intersection. Hardness comes from selecting disjoint groups.

## 1. The exact question and conventions

All graphs in the main statements are finite, nonempty, simple, and undirected. A graph $X$ is an **algebraic square** if there are an automorphism $\phi$, a nonempty fixed set $F=\operatorname{Fix}(\phi)$, and nonempty disjoint sets $A,B$ such that

$$
V(X)=F\mathbin{\dot\cup}A\mathbin{\dot\cup}B,
\qquad \phi^2=\mathrm{id},\qquad \phi(A)=B,
\qquad E_X(A,B)=\varnothing. \tag{1}
$$

Thus $\phi$ is nonidentity. We call $(\phi,A,B)$ a butterfly witness. The induced graph $X[F\cup A]$, with every vertex of $F$ distinctly labelled, is a square root: gluing two copies along those labels reconstructs $X$. Conversely, the exchange of the two copies gives (1). The common-neighbour condition in [1, Observation 2.2] follows from (1): a common neighbour of a moved vertex and its image must be fixed, and every fixed neighbour is a neighbour of both.

The nonempty-core condition matters. Two disjoint copies of a connected nonsquare graph are not squares under this convention; exchanging the copies has no fixed vertex. Some prior work uses a square convention that permits an empty core [6]. We do not import its disconnected criterion without this qualification. This problem is also different from the usual graph square defined by distance at most two.

For distinct vertices $(g,h),(g',h')$, the strong product is defined by

$$
(g,h)\sim_{G\boxtimes H}(g',h')
\quad\Longleftrightarrow\quad
(g=g'\ \text{or}\ g\sim_Gg')\ \text{and}\
(h=h'\ \text{or}\ h\sim_Hh'). \tag{2}
$$

In [1, Theorem 5.6], a square factor is already proved sufficient. Question 6.3 asks when two nonsquares can produce a square under each of four graph products. The present paper treats the entire strong-product branch. The separate repository case on Cartesian products [7] does not settle this branch: the extra diagonal edges in (2) change the answer. We do not claim a solution of the direct or lexicographic branches, or of the general Sidorenko or positive-graph conjectures.

## 2. Main results

### Theorem 1. Connected factor rigidity

For finite nonempty connected simple graphs $G,H$,

$$
\begin{aligned}
& G\boxtimes H\text{ is an algebraic square}\\
&\Longleftrightarrow G\text{ is an algebraic square or }H\text{ is an algebraic square}.
\end{aligned} \tag{3}
$$

No thinness, primeness, twin-freeness, or nontrivial-size assumption is imposed. In particular, $K_1$ is allowed and is nonsquare.

### Theorem 2. All finite nonempty inputs

Write the connected components as

$$
G=\mathop{\dot\bigcup}_{i=1}^{a}C_i,
\qquad H=\mathop{\dot\bigcup}_{j=1}^{b}D_j.
$$

Then $G\boxtimes H$ is a square if and only if at least one of the following holds:

1. Some $C_i$ or some $D_j$ is a square.
2. $ab\ge3$ and there are distinct index pairs $(i,j)\ne(k,\ell)$ with
   $$C_i\boxtimes D_j\cong C_k\boxtimes D_\ell. \tag{4}$$

The pairs refer to component occurrences; they need not refer to different isomorphism types. If both $G$ and $H$ are nonsquare, the first condition is impossible. Consequently, condition 2 alone is the complete answer for two nonsquare inputs. The isomorphism comparison in (4) is an exact structural criterion; no general polynomial-time graph-isomorphism algorithm is being claimed.

### Corollary 3. Connected multiplier and strong powers

If $G$ is connected and $G,H$ are both nonsquare, then $G\boxtimes H$ is nonsquare even when $H$ is disconnected. If $G$ is connected and $r\ge1$, then

$$
G^{\boxtimes r}\text{ is square}\quad\Longleftrightarrow\quad G\text{ is square}. \tag{5}
$$

We prove the first assertion by cancellation in Section 6 and the second by induction from Theorem 1.

## 3. Retracts and rectangular subsets

A **strict graph retraction** onto an induced subgraph $X[R]$ is a map $r:V(X)\to R$ that fixes $R$ pointwise and maps every edge to an edge. Because the graph has no loops, such a map cannot collapse an edge. In particular, if $v\ne r(v)$ then $v$ and $r(v)$ cannot be adjacent: otherwise the edge $\{v,r(v)\}$ would map to a loop.

### Lemma 4. The two halves of a butterfly are retracts

Under (1), both $F\cup A$ and $F\cup B$ are images of strict retractions.

**Proof.** Define $r_A$ to fix $F\cup A$ and send $b\in B$ to $\phi(b)$. Edges within $F\cup A$ are unchanged. Edges within $B$ are preserved by $\phi$, and an edge between $B$ and $F$ is preserved because $\phi$ fixes $F$. There are no edges between $A$ and $B$. Thus every edge is preserved. Interchanging $A,B$ gives $r_B$. Both images are proper and nonempty. $\square$

### Lemma 5. Rectangularity of a connected strong-product retract

If $G,H$ are connected and $R$ is the image of a strict retraction of $G\boxtimes H$, then

$$
R=U\times W,
\qquad U=p_G(R),\quad W=p_H(R). \tag{6}
$$

Consequently the induced retract is $G[U]\boxtimes H[W]$. This is the theorem of Imrich and Klavžar [2, Theorem 2.2]. The following proof expands its local rectangle argument; it does not claim a new retract theorem.

**Proof.** First suppose $(a,x),(b,y)\in R$ are adjacent. We show that both cross corners $(a,y),(b,x)$ lie in $R$. Only $a\ne b$ and $x\ne y$ need consideration. If $v=(b,x)\notin R$, put $r(v)=(c,z)$. Since $v$ is adjacent to both fixed vertices $(a,x),(b,y)$, its image is adjacent to both. Adjacency to $(b,y)$ gives $c=b$ or $c\sim b$; adjacency to $(a,x)$ gives $z=x$ or $z\sim x$. Since $r(v)\ne v$, (2) now gives $v\sim r(v)$, which is impossible for a strict retraction. The other corner follows symmetrically. The statement is automatic if a coordinate is equal.

The image $R$ is connected: a path in the connected product maps to a walk in $R$. Consider any finite path in $R$. Inductively, the Cartesian product of the two coordinate sets encountered along its prefix is contained in $R$. This is trivial for a one-vertex prefix. Suppose the old coordinate sets are $U_0,W_0$, their product is in $R$, and the next vertex $(b,y)$ is adjacent to the previous vertex $(a,x)\in U_0\times W_0$. The local corner argument gives $(a,y),(b,x)\in R$.

The projection $G[U_0]$ contains a walk from $a$ to each of its vertices. If $y\ne x$, then $y\sim x$. Along such a walk, the two present vertices $(u,y),(u',x)$ are adjacent whenever $u\sim u'$. Applying the local corner argument repeatedly fills $U_0\times\{y\}$. If $y=x$, that strip was already present. Symmetrically, using $a=b$ or $a\sim b$ fills $\{b\}\times W_0$. Together with $(b,y)$ these strips give

$$
(U_0\cup\{b\})\times(W_0\cup\{y\})\subseteq R.
$$

This completes the path induction. Given any two vertices of $R$, a path between them therefore places both of their cross corners in $R$. It follows that every pair in $p_G(R)\times p_H(R)$ belongs to $R$, proving (6). The induced-graph assertion follows directly from (2). $\square$

The argument uses the rectangle identity (6). It does not require a strict retraction from $G$ onto $G[U]$ or from $H$ onto $H[W]$; [2, Section 1] discusses the separate projection question.

### Lemma 6. Two proper rectangles covering a product

Let $P,Q$ be nonempty sets. Suppose two proper rectangles $U_0\times W_0$ and $U_1\times W_1$ cover $P\times Q$. Then either

$$
W_0=W_1=Q,\qquad U_0\cup U_1=P,
\tag{7}
$$

or the symmetric assertion with $P,Q$ interchanged holds. If the intersection of the rectangles is nonempty, the two varying coordinate sets have nonempty intersection.

**Proof.** If $U_0\ne P$, choose $p\notin U_0$. Every $(p,q)$ must lie in the second rectangle, so $W_1=Q$. The second rectangle is proper, hence $U_1\ne P$. Reversing the argument gives $W_0=Q$, and the covering gives $U_0\cup U_1=P$. If instead $U_0=P$, properness gives $W_0\ne Q$. The symmetric argument gives $U_1=P$ and $W_0\cup W_1=Q$. The last assertion follows from the formula for the intersection of two rectangles. $\square$

## 4. Cancellation with a fixed core

The next lemma is a marked form of the standard finite homomorphism-count argument. We include a proof because unmarked cancellation alone would not guarantee that the square root fixes the original core. Homomorphism determination of finite structures originates in Lovász's work [5]; strong-product factorization and cancellation are classical [3]. Neither background principle is claimed as a new theorem here.

For this section only, add a loop to every vertex of a simple graph. We obtain a finite **reflexive symmetric relation**. Its homomorphisms may collapse ordinary edges. This change is used only for counting; the retractions in Section 3 remain strict loopless-graph maps. The categorical product of the reflexive relations, after deleting loops, is the strong product (2).

A finite set of labels $L$ is interpreted by a function $L\to V(T)$. Different labels are allowed to name the same vertex in these auxiliary counting structures. A homomorphism must preserve both the relation and all labels.

### Lemma 7. Finite marked homomorphism counts determine isomorphism

Let $T_0,T_1$ be finite reflexive symmetric relations with the same finite label set. If

$$
\operatorname{hom}_L(S,T_0)=\operatorname{hom}_L(S,T_1)
\quad\text{for every finite labelled reflexive symmetric }S,
\tag{8}
$$

then there is a label-preserving relation isomorphism $T_0\cong T_1$.

**Proof.** Let $\operatorname{inj}_L(S,T)$ count injective label-preserving homomorphisms. Every homomorphism has a unique kernel partition $\pi$ of $V(S)$. The quotient $S/\pi$ has one vertex for each block, an edge whenever some original edge connects the corresponding blocks, and each label names the block containing its original vertex. It is again a reflexive symmetric labelled relation. Factoring through the kernel gives the exact finite identity

$$
\operatorname{hom}_L(S,T)
=\sum_{\pi\in\operatorname{Part}(V(S))}
  \operatorname{inj}_L(S/\pi,T). \tag{9}
$$

The discrete partition contributes $\operatorname{inj}_L(S,T)$. Every other partition has fewer blocks than $|V(S)|$. Induction on $|V(S)|$ applied to (9) and (8) therefore gives equality of the two injective counts for every $S$. Quotients may merge distinct labels; these remain valid auxiliary structures, and give zero counts into a target in which the merged labels are distinct.

Taking $S=T_0$ gives an injective label-preserving homomorphism $T_0\to T_1$, because the identity contributes to $\operatorname{inj}_L(T_0,T_0)$. Taking $S=T_1$ gives one in the reverse direction. The finite vertex sets consequently have equal size, so both maps are bijections. Each injective homomorphism injects the finite set of ordered relation pairs into the other relation. The two inequalities imply equal relation cardinalities. Therefore either bijective homomorphism is also surjective on relation pairs and reflects the relation. It is the required labelled isomorphism. $\square$

### Lemma 8. Cancellation preserving specified vertices

Let $A_0,A_1,H$ be finite nonempty simple graphs, with a specified vertex $a_{r,\lambda}$ of $A_r$ for each label $\lambda\in L$, where $L$ is finite. Fix $h_*\in V(H)$. Suppose an isomorphism

$$
\Psi:A_0\boxtimes H\longrightarrow A_1\boxtimes H
$$

satisfies $\Psi(a_{0,\lambda},h_*)=(a_{1,\lambda},h_*)$ for every label. Then there is an isomorphism $\psi:A_0\to A_1$ satisfying $\psi(a_{0,\lambda})=a_{1,\lambda}$ for every label. In particular, this holds if $\Psi$ fixes a common subset $C\times V(H)$ pointwise.

**Proof.** Add all loops. Label every copy of $\lambda$ in the auxiliary $H$ by the same vertex $h_*$. For every finite labelled reflexive symmetric $S$, projection gives a bijection of homomorphism sets and hence

$$
\operatorname{hom}_L(S,A_r\boxtimes H)
=\operatorname{hom}_L(S,A_r)\operatorname{hom}_L(S,H).
\tag{10}
$$

Here the product on the left means the reflexive relation product. The isomorphism $\Psi$ equates the left sides for $r=0,1$. The constant map to $h_*$ is a labelled homomorphism from every $S$ to the reflexive $H$, so the common factor on the right is a positive integer. Cancelling it gives (8) for $A_0,A_1$. Lemma 7 yields the labelled isomorphism; deleting loops gives the claimed simple-graph isomorphism. The common-core case uses one distinct label for each $c\in C$, with $a_{0,c}=a_{1,c}=c$. $\square$

## 5. Proof of connected factor rigidity

**Proof of Theorem 1.** For sufficiency, suppose $(\phi,A,B)$ witnesses that $G$ is square. The map $(g,h)\mapsto(\phi(g),h)$ is a product automorphism and an involution. Its core is $F\times V(H)$ and its wings are $A\times V(H),B\times V(H)$. These are nonempty, and (2) rules out cross-wing edges. The case of a square $H$ is symmetric. This is the existing sufficient direction of [1, Theorem 5.6].

For necessity, let $(\Phi,A,B)$ be a butterfly witness on $X=G\boxtimes H$, with core $F$. Lemmas 4 and 5 express its two halves as proper rectangles:

$$
F\cup A=U_0\times W_0,
\qquad F\cup B=U_1\times W_1.
$$

They cover the full vertex product and intersect in the nonempty set $F$. By Lemma 6 and symmetry, assume

$$
W_0=W_1=V(H),\quad U_0\cup U_1=V(G),
\quad C=U_0\cap U_1\ne\varnothing.
$$

Then

$$
F=C\times V(H),\quad
A=(U_0\setminus U_1)\times V(H),\quad
B=(U_1\setminus U_0)\times V(H). \tag{11}
$$

Both differences in (11) are nonempty. There are no edges of $G$ between them: an edge would yield an edge between the corresponding product vertices with the same $H$ coordinate, contradicting (1).

The restriction of $\Phi$ is an isomorphism

$$
G[U_0]\boxtimes H\longrightarrow G[U_1]\boxtimes H
$$

that fixes $C\times V(H)$ pointwise. Lemma 8 gives an isomorphism $\psi:G[U_0]\to G[U_1]$ fixing $C$ pointwise. Such an isomorphism sends $U_0\setminus C$ onto $U_1\setminus C$. Define an involution on $G$ by $\psi$ on the first difference, $\psi^{-1}$ on the second difference, and the identity on $C$.

Every edge lies inside at least one of $U_0,U_1$, since there are no edges between their differences. The constructed involution therefore preserves all edges; its inverse is itself, so it is an automorphism. Its fixed set is exactly $C$ and it interchanges the two nonempty anticomplete differences. It witnesses that $G$ is square. In the other case of Lemma 6, the same argument gives a square $H$. $\square$

This proof also gives a useful conclusion about the **halves** of every witness: after choosing its wings, both halves extend across one whole original factor, as in (11), or symmetrically. It does not assert that the original automorphism $\Phi$ itself acts identically on that factor. The labelled cancellation step supplies a possibly different factor witness.

## 6. Disconnected inputs and cancellation consequences

### Lemma 9. The component criterion with a nonempty core

A finite nonempty graph $X$ is square if and only if some connected component is square, or $X$ has at least three connected components and two are isomorphic.

**Proof.** A witness inside a component extends by fixing all other vertices. If two components are isomorphic and a third exists, exchange the pair using an isomorphism and its inverse and fix everything else. The pair are anticomplete wings; the third component supplies a nonempty core.

Conversely, take a witness on $X$. An automorphism permutes its connected components. If some invariant component contains a moved vertex, it must also contain a fixed vertex: otherwise the two wings would separate that connected component into nonempty anticomplete parts. Restricting the witness makes that component square. If no invariant component contains a moved vertex, every invariant component is fixed pointwise. Nonidentity then requires a pair of exchanged, isomorphic components. Since the core is nonempty, at least one other invariant component is present. There are at least three components. $\square$

**Proof of Theorem 2.** The components of the strong product are exactly $C_i\boxtimes D_j$: edges cannot leave such a pair, and each such product is connected because it contains its connected Cartesian spanning graph. By Theorem 1, a component product is square exactly when one of its connected factors is square. Applying Lemma 9 gives the two stated conditions. If an input is nonsquare, none of its components can be square, again by Lemma 9. $\square$

**Proof of Corollary 3.** The unlabelled instance of Lemma 8 gives cancellation

$$
G\boxtimes D_j\cong G\boxtimes D_\ell
\quad\Longrightarrow\quad D_j\cong D_\ell. \tag{12}
$$

If connected nonsquare $G$ and nonsquare $H$ had a square product, Theorem 2 would force at least three components of $H$ and an isomorphic pair by (12). Lemma 9 would make $H$ square, a contradiction. The strong-power statement follows inductively from Theorem 1, since a strong product of nonempty connected graphs is connected. $\square$

The condition in Theorem 2 can occur when both inputs are disconnected. For example, let

$$
G=K_2\mathbin{\dot\cup}K_3,
\qquad H=K_4\mathbin{\dot\cup}K_6.
$$

Both inputs are nonsquare: their complete components are nonsquare and their two components are nonisomorphic. The product has components $K_8,K_{12},K_{12},K_{18}$. Exchanging the two $K_{12}$ components and fixing the others gives a square. This example is a consequence of the criterion, not a separate general phenomenon.

## 7. Weighted true-twin witnesses

The following reduction provides an additional check on the non-thin case and a precise description of all lifts. It is independent of the marked-cancellation proof.

For any simple graph $X$, define $u\equiv_X v$ when $N_X[u]=N_X[v]$. Each class is a clique. Between two distinct classes either all possible edges are present or none are. Let $Q_X$ be the quotient graph and let $w_X(q)$ be the positive integer size of class $q$. The graph $X$ is exactly the clique blow-up of $(Q_X,w_X)$. Moreover $Q_X$ is thin: equality of its closed neighbourhoods would give equality of the corresponding unions of original classes, merging the two classes.

### Lemma 10. Descent and all lifts

A butterfly witness on $X$ descends to a weight-preserving butterfly witness on $Q_X$. Conversely, every weight-preserving butterfly on $Q_X$ lifts to one on $X$ by fixing each fixed class pointwise and, independently for each exchanged pair of classes, choosing a bijection in one direction and its inverse in the other. These are all possible lifts of that quotient witness.

**Proof.** Automorphisms preserve equality of closed neighbourhoods, so they permute classes and preserve their sizes. If a class is invariant under a butterfly automorphism, every vertex of it is fixed: a moved vertex would be adjacent to its distinct image in the same clique, contrary to the anticomplete wings. If a class is exchanged, it has no fixed vertex and lies entirely in one wing, since a clique cannot meet both wings. The quotient therefore inherits the involution, the nonempty core, the two nonempty anticomplete wings, and weight preservation.

Conversely, equal class sizes permit the stated bijections. Adjacency within classes is complete, and adjacency between classes depends only on the quotient. Thus every chosen lift is an automorphism. The inverse choices make it an involution; fixed classes are pointwise fixed, and the quotient wings lift to anticomplete nonempty wings. Necessity of these choices was established in the descent argument. $\square$

For strong products the reduction is compatible with the original factors:

$$
\begin{aligned}
N_{G\boxtimes H}[(g,h)]&=N_G[g]\times N_H[h],\\
Q_{G\boxtimes H}&\cong Q_G\boxtimes Q_H,\\
w_{G\boxtimes H}(q,r)&=w_G(q)w_H(r).
\end{aligned} \tag{13}
$$

Indeed, equality of two products of nonempty neighbourhood sets is equivalent to equality of the two coordinate sets. Class adjacency and sizes then give the remaining identities.

Weights cannot be discarded. The blow-up of $P_3$ with successive weights $(1,1,2)$ has thin quotient $P_3$, which is square, but its only nonidentity quotient automorphism swaps unequal endpoint weights. Lemma 10 shows that the blow-up is nonsquare. Conversely, witnesses on a thick graph need not act coordinatewise: on $P_3\boxtimes K_2$, one may fix the middle two-vertex class and pair opposite endpoint classes with the $K_2$ labels crossed. The resulting witness is valid but is not the endpoint reflection times the identity on $K_2$.

## 8. Equal-root gluing with more than two wings

Write $P_r(X)$ for the existence of a partition of $V(X)$ into a nonempty core $F$ and $r\ge2$ nonempty pairwise anticomplete wings $A_1,\ldots,A_r$, with isomorphisms $X[F\cup A_1]\to X[F\cup A_i]$ fixing $F$ pointwise. Such a partition gives $r$ isomorphic copies glued along the same labeled vertices. Conversely the copies in such a gluing give the partition and rooted isomorphisms. For $r=2$ this is the square convention of Section 1.

Let $\rho(X)$ be the maximum of 1 and all $r$ for which $P_r(X)$ holds. Necessarily $r+1\le |V(X)|$. If $P_r(X)$ and $2\le s\le r$, move the last $r-s$ wings into the core. Because they are anticomplete to the first $s$ wings, the old rooted isomorphisms extend by the identity on the enlarged core. Thus $P_s(X)$ holds exactly for $2\le s\le \rho(X)$. Section 12 treats the distinct problem where the core is fixed.

## 9. Rectangular covers with a common core

**Lemma 11.** Let $P,Q$ be nonempty sets and let $r\ge2$ proper nonempty rectangles $R_i=U_i\times W_i$ cover $P\times Q$. Suppose every pair has the same nonempty intersection $F$, and each $R_i\setminus F$ is nonempty. Then, up to interchanging coordinates, all $W_i=Q$ and $F=C\times Q$, where the $U_i$ cover $P$ and intersect pairwise in $C$.

**Proof.** Projecting $F$ onto both coordinates gives nonempty $C,D$ such that $U_i\cap U_j=C$, $W_i\cap W_j=D$ for $i\ne j$, and $F=C\times D$. If $u\in U_i\setminus C$, no other rectangle has first coordinate $u$. Covering the entire line $\{u\}\times Q$ forces $W_i=Q$, so all $W_j=D$ for $j\ne i$. If any $w\in W_i\setminus D$, covering $P\times\{w\}$ would force $U_i=P$, contradicting that $R_i$ is proper. Thus $W_i=D=Q$ and all $W_j=Q$. If every $U_i=C$, the cover gives $C=P$, which yields the other coordinate direction. $\square$

## 10. Connected strong products at all arities

**Theorem 12.** For finite nonempty connected simple graphs $G,H$ and every $r\ge2$,
$$
P_r(G\boxtimes H)\quad\Longleftrightarrow\quad P_r(G)\ \text{or}\ P_r(H).
\tag{A1}
$$
In particular $\rho(G\boxtimes H)=\max\{\rho(G),\rho(H)\}$.

**Proof.** A witness in one factor lifts by taking the product of each part with the other vertex set and each rooted isomorphism with the identity. Conversely, fix an $r$-wing representation of $G\boxtimes H$. For each $i$, fix its rooted half pointwise and send each other wing there by the composition of its inverse rooted isomorphism with the isomorphism into wing $i$. This is a strict retraction because all edges lie within some rooted half and all these maps fix the common core. The image is nonempty and proper. By retract rectangularity (Lemma 5), the rooted halves are rectangles. They cover the product and intersect pairwise in the common core. Lemma 11 says, after interchanging factors if needed, that their vertex sets are $U_i\times V(H)$, the core is $C\times V(H)$ and the wings are $(U_i\setminus C)\times V(H)$.

Fixing any one vertex in $H$ shows there can be no edge between distinct projected wings in $G$. By marked cancellation (Lemma 8), the given rooted isomorphism from $G[U_1]\boxtimes H$ to $G[U_i]\boxtimes H$ yields an isomorphism $G[U_1]\to G[U_i]$ fixing $C$ pointwise. The sets $C$ and $U_i\setminus C$ are a partition into a nonempty core and $r$ nonempty wings, giving $P_r(G)$. The other coordinate case gives $P_r(H)$. Taking the maximum proves the formula for $\rho$. $\square$

Induction now gives $\rho(G_1\boxtimes\cdots\boxtimes G_k)=\max_i\rho(G_i)$ for connected nonempty factors, so connected strong powers preserve this value.

## 11. Disconnected inputs

**Lemma 13.** Let $X$ have $c$ connected-component occurrences and let $m_T$ count each component isomorphism type $T$. Then $P_r(X)$ holds if and only if some connected component satisfies $P_r$, or $c\ge r+1$ and some $m_T\ge r$. Consequently
$$
\rho(X)=\max\left\{\max_{C\text{ component}}\rho(C),\,\max_T\min(m_T,c-1)\right\}.
\tag{A2}
$$

**Proof.** To lift a witness from one component, put the other components in its core. Alternatively choose $r$ isomorphic components as wings and leave at least one more component for the core. For necessity take an $r$-wing representation. The rooted isomorphism to any wing extends to an automorphism exchanging that wing with the first by using the inverse on the opposite wing and fixing other wings and the core. Each component meeting the core is invariant under these automorphisms, because some vertex of the component is fixed. If such a component contains any wing vertex, the restrictions of the isomorphisms give a witness on that component with all wings nonempty. If no component meeting the core contains a wing vertex, each remaining component lies in one wing, and the wings contain identical multisets of these components. This forces $r$ copies of some type outside the components meeting the nonempty core. Taking maxima gives (A2). $\square$

**Theorem 14.** Write $G=\dot\bigcup_i C_i$ and $H=\dot\bigcup_j D_j$ with $a,b$ component occurrences. Then $P_r(G\boxtimes H)$ holds exactly when some $C_i$ or $D_j$ satisfies $P_r$, or $ab\ge r+1$ and at least $r$ distinct component pairs $(i,j)$ have mutually isomorphic product graphs $C_i\boxtimes D_j$.

**Proof.** These component products are exactly the connected components of $G\boxtimes H$. Apply Theorem 12 inside each component and then Lemma 13. $\square$

If one factor $G$ is connected and both factors fail $P_r$, the product fails $P_r$. Indeed $r$ isomorphic $G\boxtimes D_j$ products require $r$ isomorphic $D_j$ by unmarked cancellation, leaving enough components for a core only if $H$ itself satisfies $P_r$. In contrast, for $G=H=\dot\bigcup_{i=0}^{r-1}K_{2^i}$ both inputs have pairwise nonisomorphic complete components and have no nontrivial wing decomposition. Their product has $r$ isomorphic components of order $2^{r-1}$ indexed by $i+j=r-1$, and $r^2\ge r+1$ total components make the core nonempty. It satisfies $P_r$.

## 12. Recognition at a given core

Fix a nonempty proper vertex set $F$. A vertex $v$ outside $F$ has color $N(v)\cap F$, preserving the identity of every core vertex. Let $m_t(F)$ count the colored connected components of each isomorphism type $t$ in $X-F$. The graph admits $r$ equal nonempty wings along this exact core if and only if $r$ divides all these counts. Each component belongs to just one wing and rooted isomorphisms preserve its color. Conversely, divide copies of each type equally among the wings and use component isomorphisms fixing $F$. Because $F$ is proper, some type occurs, and divisibility gives at least one component in every wing.

It follows that the fixed-core maximum, with 1 as the no-power value, is $\gcd_t m_t(F)$. Maximizing over eligible $F$ gives $\rho(X)$, with value 1 also when there is no eligible core. This is a finite recognition criterion using colored graph isomorphism. It does not assume a polynomial algorithm for general colored isomorphism.

## 13. Counting cores and wing partitions

For a graph $X$, let $\mathcal C(X)$ be its set of possible nonempty proper square cores and let $\mathcal W(X)$ be the set of ordered partitions $(F,A,B)$ that admit a butterfly witness. A partition is counted once even if several involutions realize it. For connected nonempty $G,H$, every possible core and ordered wing partition of the product is obtained from one of the factors by taking its product with the entire vertex set of the other. Indeed the retract and rectangle arguments in Sections 3–5 force the particular halves to have this form. The marked cancellation argument fixes the projected core and certifies the projected partition. Conversely, lift the factor involution by the identity. Projections recover the factor data, and a nonempty proper cylinder $F_G\times V(H)$ cannot equal a cylinder $V(G)\times F_H$ in the other direction. Thus the two families are disjoint even if distinct butterfly maps realize the same partition.

Define $c_X(z)=\sum_{F\in\mathcal C(X)}z^{|F|}$ and $w_X(z)=\sum_{(F,A,B)\in\mathcal W(X)}z^{|F|}$. The cylinder bijections give
$$
c_{G\boxtimes H}(z)=c_G(z^{|V(H)|})+c_H(z^{|V(G)|}),
$$
and the same formula for $w$. Induction gives, for connected factors $G_i$ with orders $n_i$ and $N=\prod_i n_i$, the sum of their respective polynomials at $z^{N/n_i}$. In particular the $k$-fold strong power of a connected graph of order $n$ has polynomial $k\,c_G(z^{n^{k-1}})$ and analogously for $w$. When possible cores exist, the smallest and largest proportions of fixed vertices are the extrema of the corresponding proportions among witnessed factors.

For a fixed nonempty proper core $F$, color outside vertices by their exact neighborhoods in $F$ as in Section 12. Write $m_t$ for the multiplicity of a colored connected type $t$ and $a_t$ for the number of its color-preserving automorphisms. A square witness exists exactly when the multiplicities are even. The number of ordered partitions at that core is $\prod_t\binom{m_t}{m_t/2}$, by selecting half of each type for the first wing. The number of involutions with exactly that fixed set is
$$
\prod_t\frac{m_t!}{2^{m_t/2}(m_t/2)!}\,a_t^{m_t/2}.
$$
For each type first pair its components into unordered pairs, and choose one color-preserving isomorphism on each pair. Its inverse determines the other direction. This counts each map once and fixes no outside vertices. Fixed-core and partition census

## 14. Repair with a protected core

Fix a specified nonempty core $F$ and an integer $r\ge2$. Delete vertices outside $F$ while keeping $F$ pointwise labeled. The result must have a partition into $r$ isomorphic nonempty wings along exactly $F$, in the sense of Section 8. Assign nonnegative deletion costs when specified, or unit cost by default. Minimizing deletion cost is equivalent to maximizing retained outside cost.

When only whole connected components of $G-F$ may be deleted, the exact minimum unit cost is
$$
\sum_t s_t(m_t\bmod r),
$$
provided some type $t$ has $m_t\ge r$. Here $s_t$ is the size of one component of type $t$. With no such type the problem is infeasible. The divisibility criterion in Section 12 forces at least the remainder of each type to be deleted. Removing exactly these remainders keeps a positive multiple of some type and realizes the bound. All costs are positive in this unit-cost formula, so the number of minimizing labeled deletion sets is $\prod_t\binom{m_t}{m_t\bmod r}$. Whole-component repair

With individual outside deletions, the decision problem is NP-complete already at a universal core vertex and two outside components, each initially with a universal vertex. In fact for any fixed $r\ge2$ and a graph $X$ on $n\ge1$ vertices, let $a=rn+1$ and construct $r$ outside components. The first is the join of $X$ with a clique of order $a$, and the other $r-1$ are cliques of order $a+n$. Add a universal core vertex. The optimal edit cost equals $r(n-\omega(X))$. A maximum clique of $X$ together with the added clique in the first component and equal-size subsets of the others realizes that cost. Any solution of no higher cost deletes fewer than $a$ vertices, so every initial outside component still has a universal vertex, is connected and is nonempty. A connected component cannot straddle anticomplete wings. Since there are $r$ components and $r$ nonempty wings, every wing contains exactly one component, and isomorphism with the comparison cliques makes each complete. The first component retains at most $a+\omega(X)$ vertices, so the cost is at least the claimed optimum. The budget $r(n-k)$ therefore decides whether $\omega(X)\ge k$. A retained set, wing partition and rooted isomorphisms give a polynomial certificate.

There is also an exact fixed-parameter algorithm for arbitrary initial outside components in terms of $(b,d,r)$, where $b$ is their maximum order and $d$ the number of different core neighborhoods on outside vertices. Enumerate connected colored types of order at most $b$. Their number $T$ is bounded by $\sum_{j=1}^{b}d^j2^{\binom{j}{2}}$. For each initial component enumerate all retained subsets and tally the colored connected components of each subset into a vector of nonnegative counts. A table scans initial components, retaining the least cost for each type-count vector modulo $r$ and a bit recording whether any vertex has survived. Its initialization is the zero residue with the bit unset. It adds the local vectors modulo $r$ and updates the bit by disjunction. The accepting state has zero residue and bit set. By Section 12 this is equivalent to the existence of $r$ nonempty equal wings. Computing canonical types may use permutations of at most $b$ vertices, so the implementation uses $2r^T$ states and at most $2^b$ local choices per initial component. Rational costs only add polynomial bit operations. This accounts for edits that split components or change colored types. Preliminary local-repair results

## 15. Cluster graphs: matching versus three-set packing

Suppose every initial component of $G-F$ is a clique. For clique $j$ and exact neighborhood color $a$, let $n_{ja}$ be the number of vertices of that color. For every $r$-element set $Q$ of distinct outside cliques, define
$$
t_{Qa}=\min_{j\in Q}n_{ja}.
$$
A tuple is usable if $\sum_a t_{Qa}>0$. Give it the unit-cost retention weight $r\sum_a t_{Qa}$. The maximum number of retained outside vertices equals the maximum weight of a nonempty collection of pairwise disjoint usable tuples. If none exists, the repair is infeasible.

Indeed, a nonempty retained part of an original clique is connected. It appears as one component in one wing and pairs with one equal colored component in each other wing. This groups the surviving original cliques into disjoint tuples, a clique being used at most once. For any such tuple, the well-matched multiplicity of each color cannot exceed $t_{Qa}$. Conversely, for each selected tuple retain exactly $t_{Qa}$ vertices of each color in each clique. Put one member of the tuple in each wing and use color-preserving bijections to obtain isomorphisms that extend by the identity on $F$. Different tuples occupy disjoint components so there is no interaction in the reconstruction.

For $r=2$, make an undirected graph on the starting cliques, with one edge for each usable pair. Its maximum-weight matching gives the optimum. Weights can be computed from the color counts in polynomial time and recovered edits keep the prescribed multiplicities. With nonnegative rational vertex costs, for each color in each clique of a pair keep the $t_{Qa}$ vertices of largest cost. The edge weight is the sum of those costs over both cliques and all colors. Enlarging retention to the full intersection cannot decrease it. If every usable edge has weight zero, choose any usable edge to satisfy the nonempty condition. Thus the algorithm handles arbitrary numbers of neighborhood colors, arbitrary clique sizes and the zero-cost case. [Edmonds's maximum-weight matching theorem](https://doi.org/10.6028/jres.069B.013)

For $r=3$, reduce from Restricted Exact Cover by 3-Sets, which is NP-complete even when each element appears in exactly three sets. Use an instance with distinct triples and universe $E$. For each triple $s$ put its own vertex in $F$, and for each element $e$ put a clique $C_e$ outside $F$. For every $s$ containing $e$, give $C_e$ one vertex whose sole neighbor in the core is $s$. Each outside clique has at most three vertices and each outside vertex has a singleton core neighborhood. Three distinct element cliques share a color exactly when their three elements constitute an input triple, and at most one color can be common to those three cliques. Therefore every usable tuple retains exactly three vertices. The optimal retention is three times the maximum number of pairwise disjoint input triples. It is at least $|E|$ exactly when the input has an exact cover. This is a polynomial reduction with unit costs, and the preceding certificate proves membership in NP. The two- and three-wing results differ on the same cluster graph class, where the calculation for each fixed tuple is a multiset intersection. [Gonzalez, Appendix A, Theorem A.1](https://doi.org/10.1016/0304-3975(85)90224-5)

## 16. Prior work and verification

Collins et al. [1] define the gluing square and ask when graph products of nonsquares can become squares. That question concerns unedited inputs. The present recognition part resolves its strong-product branch and extends the criterion to any arity. Imrich and Klavžar [2] supply retract rectangularity. The finite marked argument used here is a specialization of the classical homomorphism-count approach. The separate deletion problem keeps the core and asks for equal wings after changing the outside graph. Its arbitrary-clique comparison in Section 14 is related to maximum common induced subgraph. Shamir, Sharan and Tsur use restricted exact cover for Cluster Editing and obtain a separate two-versus-three boundary for edge deletion with a prescribed number of clusters. In Section 15 the input is already clustered, the edits delete vertices, and the parameter counts equal wings, each of which may contain several clusters. The new boundary is the matching versus three-set grouping distinction on these inputs. [Abu-Khzam, Bonnet and Sikora](https://perso.ens-lyon.fr/edouard.bonnet/publi/tcs2017.pdf) · [Shamir, Sharan and Tsur, §§2 and 4](https://www.cs.bgu.ac.il/~dekelts/publications/cmod.pdf) · Independent repair review

The original recognition certificates apply to the original scope. The higher-arity and census results have their own finite checks and the repair proof has its own independent written review. No polynomial algorithm is claimed for fixed-core two-wing repair with general outside components of order three. [Recognition reproduction](evidence/README.md) · [Higher-arity finite checks](evidence/supplements/2026-11-25-p1-secondary/verification.json)

## References

[1] K. L. Collins, D. Galvin, C. A. Kelley, E. McMillon, A. Redlich. *Characterizing Graphs as Algebraic Squares*. arXiv:2510.05372v1, 2025. Observation 2.2, Theorem 5.6, Question 6.3. <https://arxiv.org/html/2510.05372v1>.

[2] W. Imrich, S. Klavžar. *Retracts of strong products of graphs*. Discrete Mathematics 109 (1992), 147-154. DOI: 10.1016/0012-365X(92)90285-N. Author-hosted full text, especially Lemma 2.1 and Theorem 2.2. <https://users.fmf.uni-lj.si/klavzar/preprints/STRONG.pdf>.

[3] R. H. Hammack, W. Imrich. *Fast recognition of direct and strong products*. Ars Mathematica Contemporanea 7 (2014), 487-497. <https://richardhammack.github.io/reprints/Fast.pdf>.

[4] S. Soltani, S. Alikhani. *Distinguishing number and distinguishing index of strong product of two graphs*. arXiv:1703.01874v1. Theorem 1.2 states the standard thin strong-product automorphism theorem. This was checked for an alternative route; it is not a dependency of the main proof above. <https://arxiv.org/pdf/1703.01874>.

[5] L. Lovász. *Operations with structures*. Acta Mathematica Academiae Scientiarum Hungaricae 18 (1967), 321-328. The marked finite counting argument needed here is supplied in Lemma 7. The publisher record was used for bibliographic attribution. The original complete text was unavailable.

[6] P. Garg, A. Raymond, A. Redlich. *Non-Trivial Squares and Sidorenko's Conjecture*. arXiv:2206.10058. The disconnected empty-core convention and the Cartesian constructions are compared separately. <https://arxiv.org/abs/2206.10058>.

[7] Repository case: *Cartesian algebraic squares*. The earlier Cartesian classification and its exact scope. [Related manuscript](../cartesian-algebraic-squares/paper.zh.md).
