# Algebraic Squareness of Cartesian Products

*A complete criterion for products of two nonsquare graphs*

24 November 2026

# Abstract

An algebraic square with nonempty core is a graph obtained by gluing two copies of a partially labeled graph along their common labeled vertices. Collins, Galvin, Kelley, McMillon, and Redlich asked when two nonsquare graphs can have a square product. We resolve the Cartesian-product branch of that question for all finite nonempty simple graphs. For connected nonsquare graphs $G$ and $H$, the product $G\square H$ is square exactly when $G$ and $H$ have a common even-order path as a Cartesian factor. The proof gives a stronger structural statement: a connected graph is square precisely when one of its Cartesian prime factors is square or a path prime factor occurs at least twice. Every witnessing involution acts on just one orbit of prime coordinates. A two-coordinate orbit can witness squareness only when its common factor is a path; the obstruction for every other connected factor is the connectivity of the ordered two-token configuration graph. We give an explicit square root, count all witnessing involutions, and derive a linear-time decision algorithm for connected inputs promised to be nonsquare. For disconnected inputs, one additional and necessary mechanism appears: two isomorphic component products can be exchanged while a nonempty remainder is fixed. The result concerns the Cartesian product only. The manuscript is a research draft with written proofs and internal verification, without a claim of external peer review or proof-assistant certification.

# 1. The question and its exact scope

The gluing algebra multiplies partially labeled graphs by identifying equally labeled vertices. In its square case, two identical copies are joined along a common labeled core. This notion is different from taking graph distances at most two. It is also different from the notation $G\square G$ for a Cartesian self-product.

Collins, Galvin, Kelley, McMillon, and Redlich [1] develop a structural account of algebraic squares. Their Theorem 5.2 proves that a Cartesian product is square when one factor is square. The example $K_2\square K_2=C_4$ shows that the converse does not hold. Their Question 6.3 asks, for four standard graph products, when two nonsquare factors can produce a square.

We answer that question for the Cartesian product, including disconnected factors. The statements retain the nonempty fixed-core condition in [1, Observation 2.2]. The corresponding questions for the direct, strong, and lexicographic products are outside the scope of this paper.

The contribution is a necessity theorem. Standard Cartesian prime factorization and its coordinate automorphisms are the starting point. A connectivity argument then rules out every square involution acting on two or more coordinate orbits. The only possible new witness from exchanging two prime factors is a swap of two paths. Under the promise that the original connected factors are nonsquare, those paths must have even order and must occur in different factors.

There is substantial earlier work on roots of particular Cartesian products. Garg, Raymond, and Redlich [3, Section 2.3, Theorems 10–11] construct roots of $H\square C_{2k}$ for $k\ge2$, and classify its roots when $H$ is connected and $k\ge3$. Those results concern an even-cycle factor that is already square. We do not claim that Cartesian root constructions or classifications first appear here. Our distinction is the necessary and sufficient mechanism when both original factors are nonsquare.

The configuration-space connectivity used below is also classical. Barnett and Farber [4, pp. 595–596] describe a discrete deleted-product complex whose one-skeleton is the ordered-token graph used here, and recall its connectivity for a connected graph other than a topological interval, attributing that result to Patty. Section 4 supplies a short discrete proof for completeness; its connectivity dichotomy is not claimed as a new theorem.

## 1.1. Graphs, products, and the nonempty core

All graphs are finite, nonempty, simple, and undirected. We write $P_n$ for the path on $n$ vertices. In particular, $P_2=K_2$. The Cartesian product $G\square H$ has vertex set $V(G)\times V(H)$, with
$$
(g,h)\sim(g',h')
\quad\Longleftrightarrow\quad
\bigl(g=g'\text{ and }h\sim h'\bigr)
\ \text{or}\
\bigl(h=h'\text{ and }g\sim g'\bigr).
$$
The graph $K_1$ is the identity for this product.

**Definition 1.1 (algebraic square).** A graph $X$ is an algebraic square with nonempty core, or simply a *square*, if there is an involutive automorphism $\phi$ and a partition
$$
V(X)=F\mathbin{\dot\cup}A\mathbin{\dot\cup}B
$$
such that
$$
F=\operatorname{Fix}(\phi)\ne\varnothing,\qquad
A\ne\varnothing,\qquad
\phi(A)=B,
$$
and no edge joins $A$ to $B$. We call $\phi$ a *butterfly involution*.

The definition is equivalent to gluing two copies of $X[F\cup A]$ along the labeled set $F$. Indeed, $\phi$ identifies the two induced copies, and their intersection is exactly $F$. Conversely, the exchange of two glued copies fixes the core and interchanges the two wings.

The neighborhood condition included in [1, Observation 2.2] follows from Definition 1.1. For a moved vertex $u\in A$, a common neighbor of $u$ and $\phi(u)$ cannot lie in $A$ or $B$, since one of its incident edges would join the two wings. Every neighbor of $u$ in $F$ is also adjacent to $\phi(u)$, because $\phi$ fixes $F$ pointwise. Hence
$$
N(u)\cap N(\phi(u))=N(u)\cap F.
$$

The requirement $F\ne\varnothing$ matters. For example, $2K_1$ is nonsquare under this convention. Interchanging its two vertices fixes no vertex. More generally, if $C$ is a connected nonsquare graph, then $2C$ is nonsquare, whereas $3C$ is square by interchanging two components and fixing the third.

An unrestricted gluing algebra also permits an empty label set. The repeated-component construction in [3, Lemma 3] includes that case. Throughout this manuscript we retain the nonempty-core condition in Definition 1.1; in particular, the empty-core construction of $2C$ does not make $2C$ square here when $C$ is connected and nonsquare. The remainder condition in Theorem C records this convention explicitly.

## 1.2. Main statements

A connected graph of order at least two is *Cartesian prime* if it cannot be expressed as a Cartesian product of two graphs of order at least two. Every connected graph has a Cartesian prime factorization, unique up to the order and isomorphism types of its factors [2]. For $K_1$, the prime-factor multiset is empty.

**Theorem A (connected prime-factor criterion).** Let $X$ be connected, and let
$$
X\cong Q_1\square\cdots\square Q_t
$$
be its Cartesian prime factorization. Then $X$ is square if and only if at least one of the following holds:

1. Some $Q_i$ is square.
2. For some $n\ge2$, the path $P_n$ occurs at least twice among the factors $Q_i$.

The first condition is inherited squareness. The second is the only additional mechanism.

**Theorem B (connected nonsquare factors).** Let $G,H$ be connected nonsquare graphs. Then $G\square H$ is square if and only if there is an integer $r\ge1$ and connected graphs $G',H'$ such that
$$
G\cong P_{2r}\square G',
\qquad
H\cong P_{2r}\square H'.
$$
Either residual factor is allowed to be $K_1$.

Thus the condition is equality of an even path order in the two prime-factor lists. It does not require that $G,H$ be paths or that they be isomorphic.

For a connected graph $C$, let $\mathcal P(C)$ denote the multiset of isomorphism types of its nontrivial Cartesian prime factors. Write $\uplus$ for multiset union.

**Theorem C (arbitrary nonsquare factors).** Let $G,H$ be nonempty nonsquare graphs, with connected-component decompositions
$$
G=\bigsqcup_{i=1}^{a}C_i,
\qquad
H=\bigsqcup_{j=1}^{b}D_j.
$$
Then $G\square H$ is square if and only if at least one of the following holds:

1. Some pair $C_i,D_j$ has a common even-order path Cartesian factor.
2. $ab\ge3$, and for two different index pairs $(i,j)\ne(k,\ell)$,
   $$
   \mathcal P(C_i)\uplus\mathcal P(D_j)
   =
   \mathcal P(C_k)\uplus\mathcal P(D_\ell).
   $$

In the second condition, multiset equality is equality up to graph isomorphism of the prime factors. Equivalently, two distinct component products $C_i\square D_j$ and $C_k\square D_\ell$ are isomorphic.

The proof of Theorem A occupies Sections 2–5. Section 6 derives Theorem B, constructs a root, and gives the connected-input algorithm. Section 7 proves Theorem C. Section 8 counts the butterfly involutions.

# 2. Coordinate structure of Cartesian involutions

We first record the standard coordinate normal form and explain how it follows from the intrinsic prime edge relation. This makes explicit the external structural input.

**Lemma 2.1 (coordinate normal form).** Suppose
$$
X=Q_1\square\cdots\square Q_t
$$
is a Cartesian prime factorization of a connected graph. Every automorphism $\phi$ of $X$ has the form
$$
\phi(x)_i=\alpha_i\bigl(x_{\pi(i)}\bigr),
\tag{2.1}
$$
where $\pi$ is a permutation of $\{1,\ldots,t\}$, and
$$
\alpha_i:Q_{\pi(i)}\longrightarrow Q_i
$$
is an isomorphism.

**Proof.** Each edge of a Cartesian product changes exactly one coordinate. The prime factorization therefore partitions $E(X)$ into prime coordinate classes. The uniqueness and intrinsic nature of this prime product relation are stated in [2, Lemma 2.3]; the distance-based description in [2, Theorem 3.1] gives another way to see that automorphisms preserve the relation. Thus an automorphism permutes its equivalence classes.

Let $\pi(i)$ be the input coordinate class mapped to output class $i$. Along every edge changing an input coordinate other than $\pi(i)$, the $i$-th output coordinate of $\phi$ remains unchanged. Fixing $x_{\pi(i)}$ gives a connected fiber: it is the Cartesian product of all the remaining connected factors. Hence $\phi(x)_i$ depends only on $x_{\pi(i)}$, defining a map $\alpha_i$.

A layer obtained by varying only coordinate $\pi(i)$ is a connected component of the subgraph consisting of edges of that coordinate class. Its image is a layer of output coordinate $i$. Restricting $\phi$ to these layers is an isomorphism, so $\alpha_i$ is a graph isomorphism $Q_{\pi(i)}\to Q_i$. This proves (2.1). $\square$

**Lemma 2.2 (involution blocks).** If $\phi$ in Lemma 2.1 satisfies $\phi^2=\mathrm{id}$, then
$$
\pi^2=\mathrm{id},
\qquad
\alpha_i\circ\alpha_{\pi(i)}=\mathrm{id}.
\tag{2.2}
$$
Consequently, the prime coordinates can be partitioned into singleton and two-element orbits on which $\phi$ acts independently.

**Proof.** Applying (2.1) twice gives
$$
\phi^2(x)_i
=\alpha_i\!\left(\alpha_{\pi(i)}
  \bigl(x_{\pi^2(i)}\bigr)\right).
$$
If $\pi^2(i)\ne i$, varying $x_i$ while holding the other coordinates fixed changes $x_i$ but does not change the displayed expression. This contradicts $\phi^2(x)_i=x_i$, since every prime factor has at least two vertices. Thus $\pi^2(i)=i$, and the remaining identity is exactly the second equation in (2.2). $\square$

For a singleton orbit $\{i\}$, the block graph is $Q_i$, with involution $\alpha_i$. For a two-element orbit $\{i,j\}$, the block graph is $Q_i\square Q_j$, with involution
$$
(u,v)\longmapsto
\bigl(\alpha_i(v),\alpha_j(u)\bigr),
\qquad
\alpha_j=\alpha_i^{-1}.
\tag{2.3}
$$
The change of coordinates
$$
(u,v)\longmapsto \bigl(u,\alpha_i(v)\bigr)
$$
conjugates (2.3) to the ordinary swap
$$
\tau(u,w)=(w,u)
$$
on $Q_i\square Q_i$. In particular, all possible isomorphism twists of a two-coordinate involution are covered by the ordinary-swap analysis.

Call a block *active* when its induced involution is not the identity. If the global fixed set is nonempty, the fixed set in every block is nonempty. For an active block, that fixed set is also proper.

# 3. Two connectivity lemmas

The first criterion is standard: Coregliano [5, Remark 2.3] gives the same condition for completing a cut-involution of a bigraph to a fold. We state and prove the underlying uncolored-graph form so that the exact wing condition is explicit.

The next lemmas isolate the obstruction to having more than one active block.

**Lemma 3.1 (component criterion).** Let $\phi\ne\mathrm{id}$ be an involutive automorphism of a graph $X$, with nonempty fixed set $F$. Then $\phi$ is a butterfly involution if and only if no connected component of $X-F$ is preserved setwise by $\phi$.

**Proof.** If wings $A,B$ exist, every connected component of $X-F$ is wholly contained in one wing. Its image lies in the other wing, so the component is not preserved.

Conversely, $\phi$ permutes the connected components of $X-F$ in orbits of size one or two. By hypothesis, all these orbits have size two. Choose one component from each pair to form $A$, and take their images to form $B$. There are no edges between different components, so no edge joins $A$ to $B$. Nonidentity of $\phi$ makes $X-F$, and hence both wings, nonempty. $\square$

In particular, an involution with nonempty, connected moved-vertex subgraph cannot be a butterfly involution.

**Lemma 3.2 (complement of a product of subsets).** Let $B_1,\ldots,B_s$ be nonempty connected graphs, and let $\varnothing\ne F_i\subseteq V(B_i)$. If at least two of the subsets $F_i$ are proper, then the induced graph
$$
\left(B_1\square\cdots\square B_s\right)
-
\left(F_1\times\cdots\times F_s\right)
\tag{3.1}
$$
is connected.

**Proof.** Relabel two proper subsets as $F_1,F_2$, and choose
$$
a_1\in V(B_1)\setminus F_1,
\qquad
a_2\in V(B_2)\setminus F_2.
$$
Choose arbitrary base values in the remaining coordinates. We show that any vertex $x$ of (3.1) reaches this common base vertex with first two coordinates $a_1,a_2$.

Some coordinate $j$ of $x$ lies outside $F_j$. If $j\ne1$, move coordinate 1 along a path in $B_1$ until it equals $a_1$, retaining coordinate $j$ throughout. Every vertex of this walk lies outside the deleted product.

If $j=1$, first move coordinate 2 to $a_2$, retaining coordinate 1 outside $F_1$. Then move coordinate 1 to $a_1$, retaining coordinate 2 outside $F_2$.

In either case, coordinate 1 now equals $a_1$. Keeping it fixed, move every other coordinate to its base value. The walk again avoids the deleted product. Every vertex reaches the same base vertex, proving connectedness. $\square$

No connectivity assumption is made on an individual difference $B_i-F_i$. The second proper coordinate supplies a route even when the first difference has many components.

# 4. The ordered two-token obstruction

For a connected graph $Q$ of order at least two, define
$$
\mathcal D(Q)
=(Q\square Q)\bigl[\{(u,v):u\ne v\}\bigr].
$$
Its vertices are placements of two distinguishable tokens on distinct vertices of $Q$. An edge moves exactly one token along one edge of $Q$, without collision. The swap $\tau(u,v)=(v,u)$ acts on $\mathcal D(Q)$.

**Lemma 4.1 (path dichotomy).** If $Q=P_n$, then $\mathcal D(Q)$ has exactly two connected components, exchanged by $\tau$. If $Q$ is not a path, then $\mathcal D(Q)$ is connected.

**Proof.**

First suppose $Q=P_n$, with vertices $1,\ldots,n$ in path order. Every allowed move changes one coordinate by one. The sign of $u-v$ cannot change without a collision. Thus the regions $u<v$ and $u>v$ have no connecting edge. Each region is connected: from $u<v$, decrease $u$ to 1 and then increase $v$ to $n$, preserving the inequality at every step. The other region is symmetric. The swap exchanges the two regions.

Now consider arbitrary connected $Q$. The unordered two-token graph $\mathcal F_2(Q)$ has the two-element subsets of $V(Q)$ as vertices, with a move replacing one occupied vertex by an adjacent unoccupied vertex. This graph is connected. To see this, take a pair $\{u,v\}$ and move one token along a shortest $u$-$v$ path until the two occupied vertices are adjacent. For adjacent distinct edges $uv$ and $vw$, the two configurations $\{u,v\}$ and $\{v,w\}$ are connected by
$$
\{u,v\},\quad\{u,w\},\quad\{v,w\}.
$$
The line graph of a connected graph with an edge is connected. Thus all adjacent-pair configurations communicate, and every configuration communicates with one of them.

The map
$$
\mathcal D(Q)\longrightarrow \mathcal F_2(Q),
\qquad (u,v)\longmapsto\{u,v\},
\tag{4.1}
$$
is a two-sheeted graph covering. Given the labels of the two tokens and one unordered move, the moving token is uniquely determined. Consequently, each path in $\mathcal F_2(Q)$ has a unique lift from either ordering of its starting pair.

Because the base graph is connected, it remains to exhibit a path in $\mathcal D(Q)$ that exchanges the labels of one configuration. Such a path makes the two lifts communicate. Lifting paths to and from that configuration then connects all ordered configurations.

Every finite connected nonpath has either a vertex of degree at least three or, if all degrees are at most two, is a cycle.

In the first case, choose a vertex $o$ with three distinct neighbors $a,b,c$. The sequence
$$
(a,b),\ (o,b),\ (c,b),\ (c,o),\
(c,a),\ (o,a),\ (b,a)
\tag{4.2}
$$
is a collision-free path that exchanges the tokens. Each step uses one of the three chosen incident edges. Additional edges among these vertices do not invalidate the path.

In the cycle case, let
$$
v_0,v_1,\ldots,v_{m-1},v_0,\qquad m\ge3,
$$
be the cyclic order. Start from $(v_0,v_1)$. Move the second token successively to $v_2,\ldots,v_{m-1}$; then move the first token from $v_0$ to $v_1$; finally move the second token from $v_{m-1}$ to $v_0$. This reaches $(v_1,v_0)$ without a collision.

Thus every nonpath permits a label exchange, and (4.1) has a connected total graph. $\square$

The ordered graph is essential here. The unordered graph is connected even for paths. Its ordered cover records whether the tokens can pass one another.

# 5. Proof of the prime-factor criterion

We now prove Theorem A.

**Proof of necessity.** Let $\phi$ be a butterfly involution of connected $X$, and use Lemma 2.2 to group its prime coordinates into singleton and two-coordinate blocks. Write the block graphs as $B_1,\ldots,B_s$, their involutions as $\beta_1,\ldots,\beta_s$, and their fixed sets as $F_1,\ldots,F_s$. Then
$$
X=B_1\square\cdots\square B_s,
\qquad
\operatorname{Fix}(\phi)=F_1\times\cdots\times F_s.
\tag{5.1}
$$
The global fixed set is nonempty, so every $F_i$ is nonempty. Since $\phi$ is nonidentity, at least one block is active.

If at least two blocks were active, at least two $F_i$ would be proper. Lemma 3.2 would make $X-\operatorname{Fix}(\phi)$ connected, contradicting Lemma 3.1. Therefore exactly one block is active.

Suppose first that the active block is a singleton coordinate $Q_i$. Let $R$ be the Cartesian product of the other prime factors, with $R=K_1$ allowed. The moved-vertex graph is
$$
\bigl(Q_i-\operatorname{Fix}(\alpha_i)\bigr)\square R.
$$
Because $R$ is connected and fixed pointwise, the connected components of the moved-vertex graph are precisely the components of $Q_i-\operatorname{Fix}(\alpha_i)$, each multiplied by $R$. Lemma 3.1 says that $\alpha_i$ exchanges these components in pairs. Its fixed set is nonempty and its action is nontrivial. It is therefore a butterfly involution of $Q_i$, so $Q_i$ is square.

Suppose instead that the active block has two coordinates. Conjugate its action as in (2.3), so that it becomes the ordinary swap on $Q\square Q$, where $Q$ is the common prime factor. The fixed set is the diagonal. Hence the moved-vertex graph of $X$ is
$$
\mathcal D(Q)\square R
$$
for a connected, pointwise-fixed residual factor $R$. If $Q$ were not a path, Lemma 4.1 would make this graph connected, again contradicting Lemma 3.1. Thus $Q=P_n$ for some $n\ge2$, and the path occurs as two prime factors of $X$.

**Proof of sufficiency.** If some prime factor is square, extend one of its butterfly involutions by the identity on all the other coordinates. The core and wings are the original core and wings multiplied by the residual factor, so the result is square.

If a path $P_n$, $n\ge2$, occurs twice, exchange those two coordinates and fix all other coordinates. The fixed set is their diagonal times the residual factor. Lemma 4.1 supplies the two separated regions $u<v$ and $u>v$, exchanged by the involution. Both are nonempty. Thus the product is square.

For $X=K_1$, there are no nontrivial prime factors and no butterfly involution, so both sides of the criterion are false. This completes the proof. $\square$

The proof also classifies the witnessing involutions themselves: every such involution is either inherited from one prime factor or is a twisted swap of two isomorphic path factors.

# 6. Connected nonsquare factors: decision and construction

## 6.1. Proof of Theorem B

Every $P_n$, $n\ge2$, is Cartesian prime. Indeed, any nontrivial Cartesian product of two connected graphs contains a four-cycle: choose one edge in each factor and take their Cartesian product. A path contains no cycle.

The automorphism group of $P_n$ consists of the identity and reversal. The reversal has a fixed vertex if and only if $n$ is odd. For odd $n\ge3$, the fixed middle vertex separates the two wings, so $P_n$ is square. For even $n$, the reversal has no fixed vertex, so $P_n$ is nonsquare.

Now let $G,H$ be connected and nonsquare. By Theorem A, neither prime-factor multiset contains a square prime or a repeated path prime. The prime-factor multiset of $G\square H$ is their union. Therefore Theorem A makes the product square exactly when the two lists share a path prime. Such a path must have even order, since an odd-order path prime would already make its containing factor square. Conversely, a common even-order path yields a repeated path prime in the product, and therefore a square. $\square$

## 6.2. An explicit square root

Suppose
$$
G=P_n\square G',
\qquad H=P_n\square H',
\qquad n=2r,
$$
and put $R=G'\square H'$. Reorder coordinates to write
$$
G\square H\cong P_n\square P_n\square R.
$$
Define $T_n(R)$ to be the induced subgraph on
$$
\{(i,j,z):1\le i\le j\le n,\ z\in V(R)\}.
$$
Label precisely the vertices with $i=j$. Two copies of $T_n(R)$, glued along those diagonal labels, produce $P_n\square P_n\square R$: the second copy is identified with the region $i\ge j$ by coordinate exchange.

No edge joins the strict upper and lower triangular regions. A Cartesian edge changes only one coordinate by one, so it cannot change $i<j$ into $i>j$. Thus this construction supplies both a root and a direct adjacency-level verification of the gluing.

The root and core sizes are
$$
|V(T_n(R))|=\frac{n(n+1)}2\,|V(R)|,
\qquad
|\text{core}|=n\,|V(R)|.
\tag{6.1}
$$
For the promised nonsquare factors in Theorem B, $n$ is even; the triangular construction itself is valid for every $n\ge2$.

The diagonal vertices of $P_4\square P_4$ form the fixed gluing core; the two triangular regions form its wings.

## 6.3. A linear-time promised-input decision algorithm

**Corollary 6.1.** Given connected graphs $G,H$ promised to be nonsquare, whether $G\square H$ is square can be decided in
$$
O\bigl(|V(G)|+|E(G)|+|V(H)|+|E(H)|\bigr)
$$
time and space in the adjacency-list model, using a connected Cartesian prime factorization algorithm.

**Proof.** Apply the linear-time, linear-space prime factorization algorithm of Imrich and Peterin [2] to each input. For each extracted prime factor, test whether it is a path and, if so, record its even order. A connected graph of order at least two is a path exactly when two vertices have degree one and all the others have degree two.

These factors can be inspected within the input-size budget. The prime edge partition gives, through a fixed root vertex, one connected layer for each prime factor. An edge belongs to only one prime coordinate class, so obtaining and scanning those root layers uses no more than a linear number of edge incidences. The sum of the orders of the nontrivial prime factors is at most the order of the product.

The recorded path orders are integers bounded by the input graph orders. Boolean arrays indexed by those orders decide whether the two sets intersect in linear time and space. Theorem B proves correctness.

No general graph-isomorphism test is needed: two path factors are isomorphic exactly when their orders are equal. $\square$

This is a decision algorithm under an explicit nonsquare-input promise. It does not claim a linear-time algorithm for recognizing arbitrary algebraic squares. It also does not include the cost of printing the product or its root, whose size can exceed the combined input size. Once factor coordinates have been provided or recovered, Section 6.2 gives an explicit root at its natural output cost.

The finite reference verifier accompanying this manuscript enumerates automorphisms directly. Its purpose is independent checking on small graphs; its running time is not the bound in Corollary 6.1.

# 7. Disconnected factors

The nonempty-core convention introduces a component-exchange mechanism that is absent from the connected statement.

**Lemma 7.1 (component criterion for squareness).** A nonempty graph $X$ is square if and only if at least one of the following holds:

1. A connected component of $X$ is square.
2. Two connected components of $X$ are isomorphic and their union does not contain all vertices of $X$.

**Proof.** For the first sufficient condition, extend a butterfly involution of one component by fixing all remaining vertices. For the second, exchange the two isomorphic components through a chosen isomorphism and its inverse, and fix all other vertices. The latter fixed set is nonempty by assumption.

For necessity, let $\phi$ be a butterfly involution of $X$. It permutes the connected components. Suppose some component $C$ is preserved setwise and $\phi$ acts nontrivially on it. Its fixed set inside $C$ cannot be empty: otherwise $C$ would be a connected component of $X-\operatorname{Fix}(\phi)$ preserved by $\phi$, contrary to Lemma 3.1. The restriction to $C$ has nonempty core and separated wings, so $C$ is square.

If no preserved component has a nontrivial restriction, every preserved component is fixed pointwise. Since $\phi$ is nonidentity, it must exchange a pair of entire connected components. Those components are isomorphic. Since the global fixed set is nonempty and neither exchanged component contains a fixed vertex, a vertex remains outside their union. $\square$

**Proof of Theorem C.** Since $G,H$ are nonsquare, Lemma 7.1 implies that every connected component $C_i,D_j$ is nonsquare. The connected components of $G\square H$ are exactly
$$
E_{ij}=C_i\square D_j,
\qquad 1\le i\le a,\quad 1\le j\le b.
$$
There are $ab$ such indexed components.

By Theorem B, $E_{ij}$ is square exactly when $C_i,D_j$ share an even-order path Cartesian factor. This gives the first condition.

By Lemma 7.1, the remaining way for $G\square H$ to be square is to have two isomorphic components with a nonempty remainder. Because every component is nonempty, the remainder condition is exactly $ab\ge3$. By uniqueness of connected Cartesian prime factorization [2],
$$
E_{ij}\cong E_{k\ell}
\quad\Longleftrightarrow\quad
\mathcal P(C_i)\uplus\mathcal P(D_j)
=\mathcal P(C_k)\uplus\mathcal P(D_\ell).
$$
This is the second condition. $\square$

**Example 7.2 (why connectedness cannot simply be omitted).** Let
$$
G=H=K_1\sqcup K_3.
$$
Each input is nonsquare: neither connected component is square, and its two components are not isomorphic. The product has components
$$
K_1,\quad K_3,\quad K_3,\quad K_3\square K_3.
$$
Exchanging the two $K_3$ components and fixing the others witnesses squareness. No component of either input has an even-order path factor.

Theorem C is a structural classification for arbitrary nonempty nonsquare inputs. Unlike Corollary 6.1, it is not presented as a linear-time algorithm. Comparing the relevant component products can require isomorphism comparisons between arbitrary connected prime factors.

# 8. Counting all butterfly involutions

For a connected graph $X$, let $b(X)$ be the number of automorphisms of its given vertex set that are butterfly involutions. Isomorphic graphs have the same count.

**Corollary 8.1 (exact count).** Let
$$
X=Q_1\square\cdots\square Q_t
$$
be a connected Cartesian prime factorization, and let $m_n$ be the multiplicity of the path $P_n$ among the factors. Then
$$
b(X)=\sum_{i=1}^{t} b(Q_i)
      +2\sum_{n\ge2}\binom{m_n}{2}.
\tag{8.1}
$$
For $X=K_1$, both sums are empty and $b(X)=0$.

**Proof.** The proof of Theorem A shows that every butterfly involution has exactly one active coordinate orbit.

If that orbit is a singleton $\{i\}$, its restriction is one of the $b(Q_i)$ butterfly involutions of $Q_i$; all other coordinates are fixed. These contribute the first sum.

If the orbit is $\{i,j\}$, both factors must be paths of the same order. Choose the isomorphism $\alpha:Q_j\to Q_i$. The involution is uniquely specified as
$$
(u,v)\longmapsto\bigl(\alpha(v),\alpha^{-1}(u)\bigr)
$$
on the two coordinates and as the identity elsewhere. Two paths of order at least two have exactly two isomorphisms. Each unordered pair of equal-order path factors therefore contributes exactly two involutions.

The coordinate normal form distinguishes the singleton and two-coordinate cases and distinguishes their active index sets, so no involution is counted twice. This proves (8.1). $\square$

For instance, the $d$-dimensional hypercube has prime factorization $K_2^{\square d}$, and $b(K_2)=0$. Thus
$$
b(K_2^{\square d})=d(d-1).
$$
For $q\ge3$, the complete graph $K_q$ is nonsquare and Cartesian prime. It is nonsquare because every two nonempty wings in a complete graph have an edge between them. It is prime because a nontrivial Cartesian product has two vertices differing in both factors and hence nonadjacent. Therefore the Hamming graph $K_q^{\square d}$ has no butterfly involution for $q\ge3$.

These consequences illustrate that repeated prime factors alone do not create squareness. Repetition creates a new witness precisely for path factors.

# 9. Verification, attribution, and limitations

The arguments above are finite graph-theoretic proofs. They do not rely on the outcome of numerical optimization or on a finite search being extrapolated to all graphs. The small-graph verifier is intended to test the coordinate classification, the ordered-token lemma, and the involution count through direct adjacency-based enumeration.

The reported finite computational scope is stated below; the general scope of Theorems A–C follows from the written proofs. Computation files and raw outputs are not included in this edition. The linear-time result invokes the established algorithm in [2] and is not a claim about the exhaustive reference verifier.

The reference verifier checks all 1,252 nonempty unlabeled graphs with at most seven vertices (996 connected and 256 disconnected), examines 24,083 automorphisms, and reconstructs a gluing root for each of the 634 square graphs found. It checks the ordered-token connectivity statement on all 995 connected graphs with two to seven vertices, the exact involution count on all 55 unordered pairs of connected graph types of order at most four, and the complete product criterion on 79 nonsquare-input pairs with factor orders at most five and product order at most twelve. Targeted examples include a 48-vertex product. 

A separate verifier enumerates vertex involutions directly with adjacency-preservation pruning and does not assume the coordinate normal form or import the reference implementation. It independently checks the 1,252-graph atlas and the 995 token cases, then tests 139 unordered connected-factor pairs with factor orders at most five and product order at most sixteen, and 120 nonsquare-input pairs under the same size limits. Both reports contain zero mismatches. These are overlapping checks rather than counts of distinct new graph types; only three connected atlas graphs are Cartesian-composite, so the dedicated product tests are significant. 

The structural inputs are the algebraic-square framework and open question in [1], together with connected Cartesian prime factorization and its intrinsic edge relation in [2]. Product closure when one factor is square, the odd/even path examples, and the particular Cartesian root constructions in [3] are existing work. The coordinate normal form is standard; Section 2 provides the deduction needed here from the cited intrinsic relation. The ordered-token connectivity dichotomy is likewise established configuration-space background [4], for which we include a self-contained discrete proof. The component criterion for a fold in [5] is another standard input, not a novelty claim.

The proposed new contribution is the complete necessity classification for the Cartesian branch: a witness has one active coordinate orbit, its two-coordinate case is exactly a path swap, and disconnected factors admit precisely the additional component-exchange alternative. The root construction, promised-input algorithm, and counting formula follow from that classification. No assertion of global priority is made solely from a bounded literature search.

The draft has not received external peer review and does not contain an end-to-end proof-assistant formalization. It does not resolve the other graph-product branches of [1, Question 6.3], nor any general homomorphism-density conjecture motivating the gluing algebra.

# References

[1] Karen L. Collins, David Galvin, Christine A. Kelley, Emily McMillon, and Amanda Redlich. *Characterizing Graphs as Algebraic Squares*. arXiv:2510.05372v1, 6 October 2025. Definition and structural criterion in Section 2, product closure in Theorem 5.2, and the source question in Question 6.3. [Version-pinned full text](https://arxiv.org/html/2510.05372v1). [Abstract and version record](https://arxiv.org/abs/2510.05372v1).

[2] Wilfried Imrich and Iztok Peterin. *Recognizing Cartesian products in linear time*. Discrete Mathematics **307** (2007), 472–483. DOI: [10.1016/j.disc.2005.09.038](https://doi.org/10.1016/j.disc.2005.09.038). The checked author manuscript is dated 12 April 2005; it contains the intrinsic prime relation in Lemma 2.3, the distance characterization in Theorem 3.1, and the linear-time factorization algorithm. [Author-hosted full text](https://mp.feri.um.si/osebne/peterin/clanki/algoritem12.pdf).

[3] Pranav Garg, Annie Raymond, and Amanda Redlich. *Non-trivial squares and Sidorenko's Conjecture*. The Electronic Journal of Combinatorics **32**(4) (2025), #P4.54. DOI: [10.37236/11339](https://doi.org/10.37236/11339). The relevant Cartesian constructions and root classification are in Section 2.3, Theorems 10–11; Lemma 3 gives the repeated-component construction. [Publisher full text](https://www.combinatorics.org/ojs/index.php/eljc/article/download/v32i4p54/pdf/).

[4] Kathryn Barnett and Michael Farber. *Topology of configuration space of two particles on a graph, I*. Algebraic & Geometric Topology **9** (2009), 593–624. DOI: [10.2140/agt.2009.9.593](https://doi.org/10.2140/agt.2009.9.593). Pages 595–596 describe the discrete deleted-product complex and recall the connectivity result. [Publisher full text](https://msp.org/agt/2009/9-1/agt-v9-n1-p26-p.pdf).

[5] Leonardo N. Coregliano. *Left-cut-percolation and induced-Sidorenko bigraphs*. Author manuscript, 17 April 2022. Remark 2.3 characterizes when a cut-involution can be completed to a fold by the action on the components outside its fixed set. [Author-hosted full text](https://www.ias.edu/sites/default/files/Co22.pdf).
