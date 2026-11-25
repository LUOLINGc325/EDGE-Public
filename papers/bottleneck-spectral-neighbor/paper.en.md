---
title: "The bottleneck spectral neighbor of a balanced complete tripartite graph"
lang: en
geometry: margin=0.85in
---

# Abstract

For \(n\ge3\), consider all simple graphs on \(3n\) vertices other than the balanced complete tripartite graph. We determine the uniquely closest graph in the maximum coordinate difference of the ordered adjacency spectra. It is the paw graph expanded into independent parts of sizes \(n-1,n,n,1\), with the leaf attached to the first part. This extends the archived nearest-neighbor result for the sum of absolute differences and for the sum of squared differences. We also prove a sharp middle-spectrum bound for every adjacency matrix of rank at least five. After excluding the top eigenvalue and the bottom two, some remaining eigenvalue has magnitude at least \((\sqrt5-1)/2\). Three forbidden induced subgraphs force the graph structure below the threshold. An exact inertia certificate and an integer quartic comparison settle the remaining finite and large orders.

# 1. Results and scope

All graphs are finite, simple and undirected. Write the adjacency eigenvalues of an \(N\)-vertex graph \(H\) as \(\lambda_1(H)\ge\cdots\ge\lambda_N(H)\), with multiplicities. For \(N=3n\) put \(G_n=K_{n,n,n}\), whose ordered spectrum is \(2n\), then \(3n-3\) zeros, then two copies of \(-n\). Define the bottleneck distance
\[
 D_\infty(H)=\max_{1\le i\le3n}|\lambda_i(H)-\lambda_i(G_n)|.
\]

The **paw** is a triangle with one pendant leaf. An independent-set expansion replaces each vertex of a core graph by an independent part, with complete adjacency across two parts when the core vertices are adjacent. For the paw write \((a,b,c,d)\) for the sizes of the triangle part incident to the leaf, the other triangle parts, and the leaf part.

**Theorem 1.** For every \(n\ge3\), the unique minimizer of \(D_\infty(H)\) over graphs \(H\) on \(3n\) vertices with \(H\not\cong G_n\) is, up to isomorphism, the paw expansion \(H_n=(n-1,n,n,1)\), with no isolated vertices.

**Theorem 2.** For any \(N\)-vertex graph of adjacency rank at least five,
\[
 \max_{2\le i\le N-2}|\lambda_i(H)|\ \ge\ \varphi,\qquad
 \varphi=(\sqrt5-1)/2 .
\]
This constant is sharp. Consequently \(D_\infty(H)\ge\varphi\) at every such rank for the reference \(G_n\).

# 2. A structural proof of the middle-spectrum gap

Suppose \(\max_{2\le i\le N-2}|\lambda_i(H)|<\varphi\), for \(N\ge4\). Then \(H\) has no induced \(P_4\), \(2K_2\), or \(K_4\). The second eigenvalue of \(P_4\) is \(\varphi\), as follows from its polynomial \(t^4-3t^2+1\). The second eigenvalue of \(2K_2\) is \(1\), and the third eigenvalue of \(K_4\) from the bottom is \(-1\). In each case Cauchy interlacing places an eigenvalue of at least the corresponding magnitude in the middle of the full spectrum. The exclusion of \(2K_2\) implies that at most one connected component contains an edge.

We use the following decomposition of induced-\(P_4\)-free graphs. A connected such graph with at least two vertices has disconnected complement. To prove it by induction, the two-vertex case is immediate. Delete a vertex \(v\) whose deletion leaves the graph connected, for instance a leaf of a spanning tree. By induction the complement of the remaining graph has components \(X_1,\ldots,X_k\), with \(k\ge2\). All cross pairs of these components are edges of the original graph. If the full complement were connected, \(v\) would have a nonneighbor in every \(X_i\). Since \(v\) also has a neighbor, one \(X_i\) then contains a neighbor and a nonneighbor of \(v\). On a complement path between them take consecutive vertices \(x,y\) with \(x\) adjacent to \(v\) and \(y\) not adjacent to \(v\). Choose a nonneighbor \(z\) of \(v\) in a different \(X_j\). The vertices in order \(v,x,z,y\) induce a \(P_4\), a contradiction.

Apply this decomposition to the unique edge-containing component, if it exists. It is a join of at least two complement components, meaning that all vertices in different factors are adjacent. Its clique number is the sum of the clique numbers of the factors, and it is at most three by the exclusion of \(K_4\). If all factors are independent sets, the graph is complete bipartite or complete tripartite. The remaining case is a join of an independent set with a triangle-free induced-\(P_4\)-free factor. By the same decomposition, each edge-containing component of the latter factor is complete bipartite. There is just one such component, because \(2K_2\) is induced by selecting one edge from each of two such components. The remaining vertices of the factor are isolated in it. The join is then a complete tripartite graph if there are no such isolates, or a paw expansion if there are any. Thus, below the threshold, the entire graph is edgeless, complete bipartite, complete tripartite or a paw expansion, allowing isolates outside the indicated nontrivial component.

These graphs have rank at most four, since each row of their adjacency matrix is constant on the parts and equal to all rows from its own part. This proves the lower bound of Theorem 2 in all orders. The constant is attained by \(C_5\), whose two middle eigenvalues are \(\varphi\). It is also attained at rank six by a triangle with a leaf attached to each vertex. In that graph each eigenvalue \(\mu\) of the triangle contributes the two roots of \(t^2-\mu t-1\). For \(\mu=2,-1,-1\) the three middle values are \(\varphi,\varphi,1-\sqrt2\). Adding isolated vertices to either example preserves the middle maximum.

## Independent finite check in the quadratic ring

Enumerate every labeled graph of order \(m\) by the bits of its upper triangular adjacency matrix. For its matrix \(A\), compute the monic characteristic polynomial \(P(t)=t^m+c_1t^{m-1}+\cdots+c_m\) from
\[
 c_k=-\frac1k\sum_{j=1}^k c_{k-j}\operatorname{tr}(A^j),
 \qquad c_0=1.
\]
Discard \(c_m=0\), so only nonsingular graphs remain. For the two signs process \(P(\varphi+x)\) and \(P(-\varphi-x)\) in \(\mathbb Z[\varphi][x]\), with \(\varphi^2=1-\varphi\). If a coefficient is \(a+b\varphi\), its sign is obtained from \((2a-b)+b\sqrt5\). When the two terms have different signs, compare the integer squares \((2a-b)^2\) and \(5b^2\). This gives exact coefficient signs, including zero.

For a real-rooted polynomial, the number of strictly positive roots is the number of sign changes in the ordered nonzero coefficients. Indeed Descartes' rule gives an upper bound for both positive and negative roots using that polynomial and its sign-reversed argument. The two variation counts sum to at most the degree after any zero roots are factored out. For consecutive nonzero degrees with odd gap they contribute one across the two sign lists, and with positive even gap they contribute at most two. As all roots are real, both bounds are equalities. Add the initial zero coefficient multiplicity to count roots at zero. Thus the two substitutions give counts for \(\lambda\ge\varphi\) and \(\lambda\le-\varphi\), respectively. The included verifier checks the claimed alternative for all \(268\) nonsingular labeled graphs of order five and \(15848\) of order six.

# 3. The reference neighbor and rank three

For a paw with sizes \((a,b,c,d)\), the four nonzero eigenvalues are the roots of
\[
 F(t)=t^4-(ab+ac+bc+ad)t^2-2abc\,t+abcd .                                \tag{1}
\]
This is the determinant of the weighted quotient with off-diagonal entries \(\sqrt{a_i a_j}\) on core edges. Its determinant is positive and the triangle submatrix has two negative eigenvalues. It therefore has two positive and two negative eigenvalues. All other eigenvalues of the graph are zero, including those from isolated vertices.

For \(H_n=(n-1,n,n,1)\) the negative roots are \(-n\) and \(-n+z\), where \(0<z<2/(3n)\). The latter follows by writing
\[
 F(-n+z)=z[-2n+(3n^2+n+1)z-4nz^2+z^3]
\]
and checking opposite signs of the bracket at zero and \(2/(3n)\). The smaller positive root \(x\) lies in \((0,1/2)\), because \(F(0)>0>F(1/2)\). The trace gives its top root \(2n-x-z\). Thus \(D_\infty(H_n)=x+z\). It is strictly below \(q_0=61/100\) for \(n\ge7\) by the displayed bounds and for \(3\le n\le6\) by the finite certificate in Section 6. Also \(D_\infty(H_n)<1/\sqrt3\) for \(n\ge9\) from the same bounds, and for \(5\le n\le8\) by the finite certificate.

Now take a competitor with \(D_\infty(H)\le D_\infty(H_n)\). Theorem 2 rules out rank at least five, since \(\varphi>61/100\). A bipartite graph has symmetric spectrum, so its largest and smallest eigenvalues alone give \(D_\infty(H)\ge n/2\). By Section 2, the remaining forms are complete tripartite graphs and paw expansions, with possible isolates. We compare them in turn.

For triangle parts \(a\le b\le c\) the quotient is \(ww^{\mathsf T}-\operatorname{diag}(a,b,c)\) with \(w=(\sqrt a,\sqrt b,\sqrt c)^{\mathsf T}\). For any unit \(y\), the sum of the three squared coordinates of \(\operatorname{diag}(w)y\) is at least a third of the square of their sum. Thus the top eigenvalue is at most \(2(a+b+c)/3\). Any isolates would give deviation at least \(2/3>q_0\). Positive rank-one interlacing places \(-b\) between the two negative roots, which both lie within \(q_0<1\) of \(-n\). Hence \(b=n\), and the other parts are \(n-k,n+k\) for integer \(k\ge0\).

Their characteristic polynomial is \((t-2n)(t+n)^2+k^2(t+2n)\). The larger negative root has the form \(-n+z\) with \(0\le z<n\), so
\[
 k^2=(3n-z)z^2/(n+z).
\]
Since \(z<q_0\), this is less than \(3q_0^2<2\). The value \(k=0\) gives the excluded reference graph. For \(k=1\) it implies \(z>1/\sqrt3\), excluding the candidate for \(n\ge5\). At \(n=3,4\), the right side is increasing in \(z\in[0,n]\) and is less than one at \(z=61/100\), as checked strictly by rational arithmetic. Thus \(z>q_0\) in those cases. This excludes all rank-three competitors.

# 4. Rank-four structure

We record why for \(n\ge7\) such a competitor must have \(d=1\) and no isolates. Use \(q=4/5\), an upper bound on every deviation, and let \(x<2/3\) be its smaller positive eigenvalue. Since the triangle count is \(abc\), comparison of the cube trace at the allowed eigenvalues gives \(abc\ge n^3-3qn^2-q^3/2\). If any triangle part has size at most two, then \(abc\le(3n-2)^2/2\) by maximizing the other two parts' product at given sum. This contradicts the lower bound at \(n\ge7\), so \(a,b,c\ge3\).

Eliminating the leaf position at root \(x>0\) gives the three-dimensional matrix \(ww^{\mathsf T}-\operatorname{diag}(a+x-ad/x,b+x,c+x)\) with determinant zero. If its first diagonal parameter were zero, the determinant would be \(a(b+x)(c+x)>0\), so all three parameters are nonzero. The determinant lemma gives
\[
 d=x\left(1+\frac xa+\frac1{s_x}\right),\qquad
 s_x=\frac b{b+x}+\frac c{c+x}-1\ge\frac7{11}.
\]
It follows that \(d<(2/3)(1+2/9+11/7)<2\), so \(d=1\). Deleting the triangle attachment coordinate in the quotient leaves a submatrix with bottom eigenvalue \(-\sqrt{bc}\). Interlacing at the two bottom eigenvalues gives \(\sqrt{bc}\ge n-q\), so \(b+c\ge2(n-q)\). If there is at least one isolate, \(a\le n+2q-2=n-2/5\). Let \(\ell\ge2n-q\) be the top eigenvalue. Eliminating the leaf at \(\ell\) makes it an eigenvalue of the triangle quotient plus \((a/\ell)e_1e_1^{\mathsf T}\). The rank-three top bound used earlier then gives
\(\ell\le2(a+b+c)/3+a/\ell\le2n-4/3+1/2<2n-q\), a contradiction.

# 5. The large-order paw comparison

Let \(n\ge20\) and use the preceding reduction \(d=1\) and \(a+b+c=3n-1\). Define integer deviations
\[
 A=a-(n-1),\quad B=b-n,\quad C=c-n,\qquad A+B+C=0,\qquad S=A^2+B^2+C^2.
\]
The edge count is \(e=3n^2-n-1+2A-S/2\). Alternatively, let the errors at the four nonzero positions be \(\Delta_1=\ell-2n,x,z_3,z_4\), with \(z_3,z_4\) the two negative-root deviations from \(-n\). They sum to zero. The square trace gives
\(e=3n^2+n(3\Delta_1+x)+(\Delta_1^2+x^2+z_3^2+z_4^2)/2>3n^2-2n\),
using \(\Delta_1>-q_0\) and \(x>0\). Consequently \(S-4A<2n\) and
\[
 \sqrt S\le 2+\sqrt{2n+4}\le n/2 .
\]
Direct expansion of (1) at \(-n\) gives
\[
 F(-n)=-n^2S/2+n(-A^2+2ABC+A-BC)+ABC-BC.                                 \tag{2}
\]
If \(S=0\) the graph is \(H_n\). Otherwise the zero-sum integer triple has \(S=2\) or \(S\ge6\). For \(S=2\), its entries are \(1,-1,0\) in some order, giving \(-n^2+n+1,-n^2,-n^2-2n\) in (2). For \(S\ge6\),
\[
 |-A^2-BC|\le S,\quad |A|\le S/2,\quad
 |2ABC|\le(2/(3\sqrt3))S^{3/2}<(2/5)S^{3/2},
 \quad |ABC-BC|\le(\sqrt S+1)S/2 .
\]
The sum of the nonleading terms relative to \(n^2 S/2\) is bounded in absolute value by \(3/n+(4/5)\sqrt S/n+(\sqrt S+1)/n^2<3/5\). In either case \(|F(-n)|\ge379n^2/400\).

Factorizing (2) by the four roots gives \(F(-n)=(n+\ell)(n+x)z_3z_4\). The prefactor is less than \((3n+4/5)(n+2/3)<16n^2/5\), so \(|z_3z_4|>379/1280\). But \(D_\infty(H_n)<1/2+2/(3n)\le8/15\), and \((8/15)^2<379/1280\). Thus any such competitor with \(S\ne0\) has a strictly larger bottleneck error. This proves the large-order claim.

# 6. Finite paw comparisons

For \(n=3,\ldots,6\) enumerate every integer \(a,b,c,d\ge1\) with \(b\le c\) and \(a+b+c+d\le3n\), assigning the remainder to isolates. For \(n=7,\ldots,19\) use \(d=1\) and \(a+b+c=3n-1\). The included certificate sets a rational ceiling for the winner's error on a mesh of step \(10^{-4}\), and checks that every other parameter tuple lies strictly above that ceiling. The rational comparisons use inertia. For a noninteger rational test point \(t=u/v\), let \(W=\operatorname{diag}(a,b,c,d)\) and \(A_{\mathrm{paw}}\) be the core adjacency matrix. The matrix
\[
 v W A_{\mathrm{paw}} W-u W
\]
is a positive multiple of a diagonal congruence of the shifted weighted quotient. Its negative inertia is the number of quotient eigenvalues less than \(t\). The weighted quotient and its leading principal blocks are similar to integer matrices, so none has a noninteger rational eigenvalue. All leading minors in this shift are therefore nonzero. Their signs, computed by exact fraction-free elimination, give inertia by the signs of consecutive determinant ratios. The resulting comparisons apply directly to both negative roots, the smaller positive root and the top root.

The verifier checks every finite competitor, covering all remaining orders. Combined with Section 5 it proves Theorem 1, including uniqueness. The finite certificate uses only exact integer and rational operations and is independent of numerical eigensolvers.

# 7. Pinned comparison

The original nearest-spectral case treats the sum of absolute spectral errors and the sum of their squares. The companion rank-gap case gives a sum-of-squares obstruction for ranks at least six. The present work settles the bottleneck distance and uses three induced obstructions to obtain a structural theorem and the sharp golden-ratio threshold for all ranks at least five. The comparison is to the pinned repository cases.
