# The exact loss of covariance intersection under graph-structured uncertainty

## Abstract

An undirected graph specifies which sensor-error cross-covariances may be nonzero. We determine the worst loss of safe scalar covariance inflation against all conservative linear unbiased estimators. For every fixed graph the worst optimized trace ratio equals the least uniform Loewner factor. Both equal an explicit finite-dimensional maximum of a mixed-to-directional quadratic ratio, stabilize in a dimension of order the square root of the number of sensors, and are computable real algebraic numbers. A state-coordinate change converts an extremal mixed covariance witness into an ordinary trace example without rounding. Clique inequalities characterize safety precisely on perfect graphs. Over the class of perfect graphs with clique number at most $k$, the sharp universal factor is $k/(1+(k-1)2/\pi)$. For $k\ge2$ this factor is sharp even over connected graphs with intersecting maximal cliques. For any fixed graph the limit over disjoint copies is an exact finite Gaussian variational formula and is attained asymptotically in dimension at most the size of one copy. The scalar inflation family is lossless precisely for one complete bipartite component with arbitrary isolated vertices, including the graph with no edges. The three minimal obstructions already have strict trace loss in dimension two.

## Reading guide

Covariance intersection estimates a common state from measurements whose errors can be correlated. Each scalar weight inflates one known sensor covariance before applying the best linear unbiased rule. A weight is safe when its inflated independent model dominates every joint covariance permitted by the graph. The four-vertex path gives a concrete example with overlapping groups. For nonnegative weights, its three edge inequalities \(w_1+w_2\le1\), \(w_2+w_3\le1\), and \(w_3+w_4\le1\) describe all safe weights. Nevertheless, Section 4 constructs a conservative estimator whose reported trace is strictly smaller than that of any safe inflation.

The exact price of a graph compares the two optimized traces over all admissible observation models. The same number is the least factor for which each conservative estimator can be matched by some safe inflation rule in every state direction at once. Section 2 compares a single state direction with a positive semidefinite mixture of directions. Section 6 shows how to turn a worst mixture into an actual observation model and makes the two meanings of the price agree. Sections 7 and 8 determine sharp bounds for overlapping cliques and for many disjoint copies of an arbitrary graph, respectively. The auxiliary Gaussian vectors in these proofs describe state directions. The sensor errors themselves only need the stated covariance constraints.

## 1. Covariance uncertainty and the inflation family

For $i=1,\ldots,m$, observe $y_i=H_i x+e_i$ in a finite-dimensional real space. The errors have zero mean and fixed marginals $P_i\succ0$. The stacked observation matrices have full column rank $n$. An undirected simple graph $G$ specifies that a cross block $\mathbb E e_i e_j^\top$ is zero for each nonedge. The other cross blocks can be arbitrary subject to positive semidefiniteness of the joint covariance. An unbiased estimator uses gains $K_i$ satisfying $\sum_iK_iH_i=I_n$. A conservative pair $(K,B)$ has a reported covariance $B$ that dominates $K P K^\top$ for every admissible joint covariance $P$. Since the independent covariance is admissible and $K$ has full row rank, $B\succ0$.

Let $\mathcal R_G$ be the set of real positive-semidefinite correlation matrices with unit diagonal and zero entries on the nonedges of $G$. For positive weights $w_i$, call a weight vector safe if
\[
 R\preceq\operatorname{diag}(1/w_i)\qquad(R\in\mathcal R_G).
\tag{1}
\]
A zero weight discards that observation and applies (1) to the active principal subgraph. The reported covariance is
\[
 B_G(w)=\left(\sum_i w_i H_i^\top P_i^{-1}H_i\right)^{-1}
\tag{2}
\]
whenever the information matrix is positive definite. The estimator is the best linear unbiased rule in the fictitious independent observation model with active covariances $P_i/w_i$. Safety of (1) for vector observation blocks follows below. For the complete graph this is ordinary covariance intersection.

**Theorem 1.** The following conditions on $G$ are equivalent.

1. For every state dimension, every observation model and every conservative unbiased pair $(K,B)$, a safe weight in (2) satisfies $B_G(w)\preceq B$.
2. For every observation model in state dimension two, the infimum of the reported trace in (2) equals the infimum over conservative unbiased pairs.
3. The graph has at most one component with edges, and that component is complete bipartite.
4. $G$ has no induced triangle, four-vertex path or pair of disjoint edges.

Each forbidden graph has a two-dimensional strict witness. The ratio of the optimal inflated trace to the optimal conservative trace is at least $9/8$ on the triangle and at least $112/111$ on the path and disjoint edges. All three witnesses extend to graphs containing them as induced subgraphs. In dimension one every graph is lossless.

## 2. Exact relaxation and witness rank

For nonnegative $a=(a_i)$ put $f_G(a)=\max_{R\in\mathcal R_G}\sqrt{a^\top R a}$. If $a_i=\|P_i^{1/2}K_i^\top v\|$, the worst variance of $v^\top\sum_iK_i e_i$ equals $f_G(a)^2$. Indeed, the covariance of the unit marginal projections is a member of $\mathcal R_G$. Conversely, choose any such scalar correlation for those projections and fill the remaining whitened coordinates with independent noise of identity covariance on the orthogonal complements. This realizes all the scalar correlations. Zero $a_i$ can use any unit projection. The same argument for a vector on the stacked observation space shows that (1) is equivalent to domination of the active joint covariance by $\operatorname{diag}(P_i/w_i)$ for any given block dimensions and positive-definite marginals. Equation (2) is consequently conservative.

Define the theta body, in the convention with orthogonality on nonedges, by
\[
 \mathcal T_G=\left\{z:\begin{pmatrix}1&z^\top\\z&Z\end{pmatrix}\succeq0,\
              Z_{ii}=z_i,\ Z_{ij}=0\text{ on nonedges}\right\}.
\]
It is convex and compact with $0\le z_i\le1$. Let the leading Gram vector be a unit vector $h$. For $z_i>0$ divide the $i$th Gram vector by $\sqrt{z_i}$ to get a unit vector $u_i$ with $\langle h,u_i\rangle=\sqrt{z_i}$. Zero coordinates can be assigned fresh orthogonal unit vectors. Conversely, any unit Gram representation on nonedges gives $z_i=\langle h,u_i\rangle^2$, using signed multiples of the unit vectors in the Gram matrix defining $\mathcal T_G$. Maximizing over $h$ in the norm of $\sum_i a_i u_i$, with signs free, gives
\[
 f_G(a)=\max_{z\in\mathcal T_G}\sum_i a_i\sqrt{z_i}.
\tag{3}
\]
For a fixed representation (1) means the operator norm of the map with columns $\sqrt{w_i}u_i$ is at most one. Equivalently, every unit $h$ satisfies $\sum_iw_i\langle h,u_i\rangle^2\le1$. Thus the full safe set, including its zero weights, is
\[
 \mathcal W_G=\{w\ge0:\ w^\top z\le1\ \text{for every }z\in\mathcal T_G\}.
\tag{4}
\]
The projection onto an induced subgraph gives exactly its safe set when all other weights are zero. To check necessity in the restriction, extend its Gram vectors with fresh orthogonal directions for the omitted vertices.

Let $A_i\succeq0$ be real $n$-by-$n$ matrices with at least one nonzero block. Write
\[
 D_G^2=\max_{\|v\|=1} f_G\bigl((\sqrt{v^\top A_i v})_i\bigr)^2,\qquad
 M_G^2=\max_{X\succeq0,\ {\rm tr}(X)=1} f_G\bigl((\sqrt{{\rm tr}(A_iX)})_i\bigr)^2 .
\]
The exact relaxation is
\[
 M_G^2=\min_{w\in\mathcal W_G}\lambda_{\max}\left(\sum_{i:A_i\ne0} A_i/w_i\right).
\tag{5}
\]
For positive definite matrices, let $(X_*,z_*)$ maximize $\sum_i\sqrt{s_i z_i}$, where $s_i={\rm tr}(A_iX_*)$. Every $z_i$ is positive. If $z_i=0$, moving toward the $i$th coordinate vector in $\mathcal T_G$ gives square-root gain against losses of order of the mixing mass. Differentiation in $z$ shows that $w_i=\sqrt{s_i/z_i}/M_G$ satisfies (4). Differentiation in $X$ gives
\[
 S=\sum_i\sqrt{z_i/s_i}\,A_i\preceq M_G I,\qquad {\rm tr}(SX_*)=M_G .
\]
Hence $\sum_i A_i/w_i=M_GS\preceq M_G^2 I$. For every safe $w$, Cauchy–Schwarz gives $\sum_i s_i/w_i\ge(\sum_i\sqrt{s_i z_i})^2$ since $w^\top z\le1$. This proves (5). In the general case omit zero blocks and then add $\epsilon I$ to the others. The augmented objectives converge uniformly in $X,z$. Bounded objective values force weights of original nonzero $A_i$ away from zero because $\lambda_{\max}(\sum_j A_j/w_j)\ge\lambda_{\max}(A_i)/w_i$. Compactness proves (5) and attainment.

A maximizing witness can be chosen of rank $r$ satisfying $r(r+1)/2\le m_{\rm a}$, the number of nonzero blocks. In the regularized problem it is supported on $\ker(M_G I-S)$. Inside that eigenspace, fix the $m_{\rm a}$ moments $s_i$. The trace condition follows from the linear combination $S$. The resulting positive-semidefinite moment set is compact. An extreme point of larger rank would allow a nonzero symmetric perturbation on its support preserving every moment, since the dimension of the symmetric matrices on that support exceeds the constraint count. Both signs of a sufficiently small perturbation preserve positive semidefiniteness, contrary to extremality. The rank bound passes to the limit, by closedness of the upper rank constraint.

For a witness of rank $r$ put
\[
 C_r=\frac{\pi\Gamma((r+1)/2)^2}{r\Gamma(r/2)^2}.
\]
Then $M_G^2\le C_rD_G^2$. Use the same maximizing $z$ from (3) and a centered Gaussian $g$ of covariance $X_*$. Concavity on the simplex of normalized eigenvalues of $X_*^{1/2}A_iX_*^{1/2}$ gives $\mathbb E\sqrt{g^\top A_i g}\ge\sqrt{2/\pi}\sqrt{s_i}$. At every simplex vertex the corresponding expectation is $\mathbb E|N(0,1)|$. Also permutation averaging the eigenvalues of $X_*$ gives $\mathbb E\|g\|\le \mathbb E\|N_r(0,I)\|/\sqrt r$. By (3), $\sum_i \sqrt{z_i}\sqrt{g^\top A_ig}\le D_G\|g\|$. The Gaussian mean norm gives the bound, with a zero moment contributing zero.

For a conservative pair use $A_i=B^{-1/2}K_iP_iK_i^\top B^{-1/2}$. The directional identity gives $D_G^2\le1$. Use the minimizing weights from (5) and the best linear unbiased rule (2). Completing the square using unbiasedness shows its inflated covariance is at most the covariance of the original gains under the same inflated model. Hence
\[
 B_G(w)\preceq M_G^2B .
\tag{6}
\]
The active observations identify the state because the omitted gains vanish and the remaining gains satisfy unbiasedness. A rank-one witness gives $M_G=D_G$, so (6) is lossless. This proves the assertion in state dimension one.


## 3. Complete multipartite components and independent pairs

Suppose $G$ has one nontrivial complete multipartite component with parts $I_1,\ldots,I_k$ and arbitrary isolated vertices. Let $A^{(j)}=\sum_{i\in I_j}A_i$ and $C=\sum_{i\ {\rm isolated}}A_i$. Projection squares sum to at most one in each part by orthogonality. A clique with one representative from each part can have all its vectors aligned. Thus (4) on the component is equivalent to $\sum_j\max_{i\in I_j}w_i\le1$, with separate bounds $w_i\le1$ on isolates. For the graph directional norm on the component, Bessel's inequality gives $\sum_j\sqrt{\sum_{i\in I_j}a_i^2}$. It is attained by choosing an orthonormal family in each part whose projections on a common handle are proportional to the $a_i$ in that part. The different parts can use disjoint auxiliary spaces off the handle, and the isolated vectors contribute independently. Therefore
\[
 M_G^2=\max_{{\rm tr}(X)=1,\ X\succeq0}
 \left[{\rm tr}(CX)+\left(\sum_{j=1}^k\sqrt{{\rm tr}(A^{(j)}X)}\right)^2\right].
\tag{7}
\]
When there are no isolates, this is ordinary covariance intersection on the pooled observations, both at the conservative and inflated levels. The original uncertainty and grouped uncertainty are identical after pooling. All weights in a part can be raised to the part maximum without changing feasibility, and the part's marginal is the known block-diagonal covariance.

An optimizing witness in (7) can be chosen with $r(r+1)/2\le k$. To see it, regularize the group matrices so that $s_j={\rm tr}(A^{(j)}X)>0$ at a maximizer. Put $w_j=\sqrt{s_j}/\sum_i\sqrt{s_i}$. Its first-order linear matrix is $C+\sum_j A^{(j)}/w_j$, whose top eigenspace supports the maximizer. Inside that eigenspace keep the trace one and the $k-1$ ratios $s_j/s_1$ by linear equations. In this compact set the optimal group weights stay fixed and the expression in (7) is the same linear evaluation. The extreme-point proof uses at most $k$ constraints. Remove regularization by compactness. Zero groups can be deleted. The case $k=2$ gives a rank-one witness and hence (6) is lossless. The edgeless case is independent least squares. This proves $(3)\Rightarrow(1)$ in Theorem 1.

If $G$ instead consists of $k$ disjoint edges and isolated vertices, the corresponding mixed objective is
\[
 \max_{{\rm tr}(X)=1,\ X\succeq0}
 \left[{\rm tr}(CX)+\sum_{ij\ {\rm edge}}
 \bigl(\sqrt{{\rm tr}(A_iX)}+\sqrt{{\rm tr}(A_jX)}\bigr)^2\right].
\]
Both the scalar covariance and the safe weights separate by component. The top-eigenspace argument now keeps one moment ratio per edge and the trace. It gives $r(r+1)/2\le k+1$. As proved next, two independent edges can force rank two and a positive gap, although every single edge can be rounded exactly.

## 4. Three minimal obstructions

Suppose $w^*$ is positive and safe, $\sum_i A_i/w_i^*=\kappa I_n$, and $w^*$ minimizes $\sum_i{\rm tr}(A_i)/(n w_i)$ on $\mathcal W_G$. Put $P_i=I$ and $H_i=A_i^{1/2}/w_i^*$. The minimum reported trace is $n/\kappa$. Indeed, the first-order condition for the convex scalar weight objective gives
\[
 \sum_i w_i\frac{{\rm tr}(A_i)}{(w_i^*)^2}\le
 \sum_i\frac{{\rm tr}(A_i)}{w_i^*}=n\kappa \qquad(w\in\mathcal W_G).
\]
The left side is the trace of the information matrix in (2). Its inverse has trace at least $n/\kappa$, and equality holds at $w^*$. The gains $K_i=A_i^{1/2}/\kappa$ are unbiased and their conservative covariance can be taken as $(D_G^2/\kappa^2)I_n$. This gives a trace ratio of at least $\kappa/D_G^2$. For positive-definite $A_i$, invert the corresponding observation matrix to obtain a full-state observation with marginal $(w_i^*)^2 A_i^{-1}$. These transformations preserve the known zero cross-covariances.

**Triangle.** Let $v_1,v_2,v_3$ have projective angles $0,\pi/3,2\pi/3$, and set $A_i=(2/3)v_iv_i^\top$, $w_i^*=1/3$. Their sum is $I_2$ and $\kappa=3$. Equal traces give the optimal scalar weights on the simplex. The largest squared length of a signed sum of the $v_i$ is four, by evaluating the four sign patterns modulo common sign. The directional maximum is thus $D_G^2=8/3$, giving $9/8$.

**Path and disjoint edges.** Number the path $1-2-3-4$ and use edges $12,34$ for the disjoint-edge graph. Put $p=1/4$, $q=3/4$, $H=\operatorname{diag}(1,-1)$ and $J=\begin{pmatrix}0&1\\1&0\end{pmatrix}$. Define
\[
 \begin{array}{ll}
 A_1=q^2(I+H/6),& A_2=p^2(I-H/2),\\
 A_3=p^2(I-J/2),& A_4=q^2(I+J/6),
 \end{array}
 \qquad w^*=(q,p,p,q).
\tag{8}
\]
The two inflated edge sums separately equal $I_2$. The weights are safe for both graphs. In fact on a forest the safe weights are precisely $w_i\le1$ and $w_i+w_j\le1$ on edges. For sufficiency, peel a leaf of a positive-semidefinite matrix supported on a forest. When the leaf diagonal is positive, subtract the rank-one positive-semidefinite matrix on the leaf and its neighbor that agrees with the leaf row. The Schur complement of the leaf is positive semidefinite and supported on the smaller forest. If the leaf diagonal vanishes, its row is zero. Repetition decomposes the matrix into positive-semidefinite edge and singleton pieces. On an edge, Cauchy–Schwarz bounds a quadratic form by $(w_i+w_j)\sum_{\ell=i,j}R_{\ell\ell}a_\ell^2/w_\ell$, where $R_{\ell\ell}$ is the diagonal of the piece. Sum over the pieces and use the original unit diagonals. Necessity follows from perfect correlation of a single edge and from the singleton constraints. Restriction covers zero weights.

By (8), $\operatorname{tr}(A_i)/(2(w_i^*)^2)=1$. The edges $12,34$ imply $\sum_iw_i\le2$, with equality at $w^*$. By the scalar convex first-order condition, the scalar objective in the transfer is minimized at $w^*$, and $\kappa=2$. For a unit $v$, write $h=v^\top H v$ and $j=v^\top Jv$, so $h^2+j^2=1$. The two-edge optimum uses, within each edge, weights proportional to the square roots of the two directional numerators $v^\top A_i v$. Each low endpoint has numerator at most $3/32$ and its high partner has numerator at least $15/32$. Thus each low endpoint has weight at most $1/(1+\sqrt5)$, and the joining edge $23$ also satisfies its weight constraint. These directional choices give the same bound on both graphs. For the first edge, the difference between its inflated quadratic form at $w^*$ and the optimized form is
\[
 pq\bigl(\sqrt{1+h/6}-\sqrt{1-h/2}\bigr)^2
 = \frac{pq (2h/3)^2}{(\sqrt{1+h/6}+\sqrt{1-h/2})^2}
 \ \ge\ \frac{h^2}{56}.
\]
The denominator is at most $2(2-h/3)\le14/3$. The other edge gives the same inequality with $j$ in place of $h$. Summing yields $D_G^2\le2-1/56=111/56$, so the trace ratio is at least $112/111$. All four matrices are positive definite, and the full-state marginals obtained by inverting the observations are rational.

For any graph containing a forbidden induced subgraph, set the extra $H_i$ to zero. The achievable information matrices on the informative vertices are unchanged by the exact projection property of (4). The candidate conservative estimate still ignores all other observations. This proves $(2)\Rightarrow(4)$. Also $(1)\Rightarrow(2)$ by conservativeness and matrix order.

Finally, a connected triangle-free graph with edge $ab$ and no induced four-vertex path is complete bipartite. If a vertex is adjacent to neither $a$ nor $b$, take a shortest path to $\{a,b\}$. A distance of at least three gives a four-vertex induced path. At distance two, append the other vertex of $ab$ to the shortest path. Its intermediate vertex cannot be adjacent to both $a,b$ by triangle-freeness. Thus the appended path is induced. All remaining vertices are adjacent to exactly one of $a,b$ and can be assigned to the corresponding side. Triangle-freeness forbids edges within each side. A missing cross edge gives an induced path through $ab$. Two distinct components containing edges would give two disjoint induced edges. This proves $(4)\Rightarrow(3)$.

## 5. A sharp price for independent correlation groups

For a union of cliques, errors in different groups have zero cross-covariance; within a group all admissible cross-covariances are unknown. Let $k\ge1$ be an upper bound for the number of sensors in any group. We allow any finite number of groups, any observation dimension and positive-definite marginals.

**Theorem 2.** For every conservative unbiased pair $(K,B)$, some safe scalar inflation has
$$
 B_G(w)\preceq \kappa_k B,\qquad
 \kappa_k=\frac{k}{1+(k-1)2/\pi}.
$$
This constant is sharp even for the ratio of the two optimized reported traces. For any $k$ and any positive tolerance it can be approached by finitely many groups of exactly $k$ sensors in state dimension $k$. One may restrict all sensors to invertible full-state observations with positive-definite marginal covariances. Thus two correlated sensors in each of many mutually uncorrelated groups have exact uniform price $2\pi/(\pi+2)$; a single pair on its own is lossless. As the allowed group size grows the prices increase to $\pi/2$.

*Upper bound.* Within one clique the scalar Gram vectors may all be equal, and different cliques use mutually orthogonal representations. Thus
$$
 f_G(a)^2=\sum_C\Big(\sum_{i\in C}a_i\Big)^2.
$$
For a mixed witness $X\succeq0$ with trace one, write $s_i=\operatorname{tr}(A_iX)$ and let $g=X^{1/2}Z$, $Z$ a standard normal vector. For each nonzero moment diagonalize $X^{1/2}A_iX^{1/2}=\sum_a\lambda_{ia}u_{ia}u_{ia}^\top$. Set $p_{ia}=\lambda_{ia}/s_i$. By root mean square versus arithmetic mean,
$$
 \sqrt{g^\top A_i g}\ge\sqrt{s_i}\sum_a p_{ia}|u_{ia}^\top Z|.
$$
For any unit vectors with correlation $c$, the absolute product of their Gaussian projections has expectation $(2/\pi)(\sqrt{1-c^2}+c\arcsin c)\ge2/\pi$. Indeed in their plane use polar Gaussian coordinates: average $|\cos\theta\cos(\theta-\arccos c)|$ on one period and multiply by the mean squared radius two. Splitting at the two zeros gives the formula, including $|c|=1$ by continuity. It follows that each mixed product in a clique has expectation at least $(2/\pi)\sqrt{s_i s_j}$. Each diagonal expectation is exactly $s_i$. Since $\sum_{i\in C}s_i\ge k^{-1}(\sum_{i\in C}\sqrt{s_i})^2$, we obtain
$$
 D_G^2 E\|g\|^2\ \ge\ E f_G\big((\sqrt{g^\top A_i g})_i\big)^2
 \ \ge\ \kappa_k^{-1}\sum_C\Big(\sum_{i\in C}\sqrt{s_i}\Big)^2 .
$$
Zero moments follow directly. Maximizing over $X$ and applying (6) proves the claimed matrix guarantee.

*Sharpness after optimizing the estimator.* For fixed $n=k\ge2$, let a single clique correspond to an orthonormal frame $u_1,\ldots,u_k$ in $\mathbb R^k$, with $A_i=u_i u_i^\top$. For $v$ a unit vector and a Haar-random frame,
$$
 E\Big(\sum_i |\langle v,u_i\rangle|\Big)^2
 =1+(k-1)2/\pi .
$$
The squared projections sum to one. For two distinct projections their absolute product has expectation $2/(\pi k)$, by dividing the corresponding independent Gaussian absolute product moment by its independent squared radial expectation $k$. There are finite uniform multisets of frames for which the empirical means of these continuous functions converge uniformly in $v$ to the displayed constant: apply the strong law on a countable dense set of $v$ and the uniform Lipschitz bound $2k$ on the compact sphere. Each frame already has $\sum_iA_i=I$, so no isotropy correction to the first moment is needed.

For $L$ such cliques choose $w_i^*=1/k$. The feasible weights are exactly those with group sums at most one. Equal traces imply that $w^*$ minimizes the scalar trace objective of Section 4 and $\sum_i A_i/w_i^*=kL I$. That section realizes a linear observation model in which the optimized trace ratio is at least $kL/D_G^2$. The preceding uniform convergence sends $D_G^2/L$ to $1+(k-1)2/\pi$. This proves sharpness for optimized traces and hence also for uniform Loewner domination. The case $k=1$ follows from independent estimation. To enforce positive definiteness replace every $A_i$ in the finite construction by $A_i+\epsilon I$. Every trace is still equal and the inflated sum is scalar. The directional objective is continuous uniformly on the compact sphere as $\epsilon\downarrow0$. The observation transformation of Section 4 then gives invertible full-state measurements with positive-definite marginals. Take small $\epsilon$ after fixing the finite family.

Gaussian rounding and the $2/\pi$ constant are classical in positive semidefinite Grothendieck problems. Here keeping the exact diagonal term produces a finite-group interpolation, and frame witnesses survive the optimization over all unbiased estimation rules. Fixed-size group interpolation concerns arbitrarily many independent groups. It does not give the optimal constant for a prescribed single finite graph. [Briët, de Oliveira Filho and Vallentin, The positive semidefinite Grothendieck problem with rank constraint](https://arxiv.org/abs/0910.5765)

## 6. The exact factor for a fixed graph

For a positive integer \(n\), let \(C_{\rm tr}(G;n)\) be the supremum over observation models of state dimension at most \(n\) of the ratio
\[
 \frac{\inf_{w\text{ safe}}\operatorname{tr} B_G(w)}
      {\inf_{(K,B)\text{ conservative}}\operatorname{tr} B}.
\]
The numerator uses weights with nonsingular information and the denominator uses unbiased gains. Let \(C_{\preceq}(G;n)\) be the least \(c\) such that, in all these models, every conservative pair is matched by some safe \(w\) with \(B_G(w)\preceq cB\). The independent admissible joint covariance gives a positive lower bound on the denominator, and positive safe weights give finite values. Write \(F_G(s)=f_G((\sqrt{s_i})_i)^2\) for \(s\ge0\). In particular \(F_G\) is continuous, nonnegative and homogeneous of degree one. By (5) in state dimension one,
\[
 F_G(s)=\inf_{\substack{w\in\mathcal W_G\\ w_i>0}}\sum_i s_i/w_i .
\tag{9}
\]
Weights zero on zero moments can be approximated by mixing with small strictly positive safe weights. Equation (9) also establishes concavity of \(F_G\).

**Theorem 3.** Let \(r_m=\max\{r:r(r+1)/2\le m\}\) and \(d=\min(n,r_m)\). Then
\[
 C_{\rm tr}(G;n)=C_{\preceq}(G;n)=
 \max_{\substack{A_i\succeq0\ \text{in }\mathbb R^{d\times d}\\
                   \sum_i\operatorname{tr} A_i=1}}
              \frac{M_G(A)^2}{D_G(A)^2}.
\tag{10}
\]
The ratio on the right is attained by a linear observation model of state dimension at most \(d\). It can be approached in this dimension bound with \(H_i=I\) and positive-definite marginals at every sensor. In particular the two constants stabilize at \(n=r_m\) for every fixed graph. Their common unrestricted value \(C(G)\), as well as each dimension-restricted value, is a computable real algebraic number.

*Upper bound and dimension.* Equation (6) gives the upper bound by the corresponding matrix ratio in any given dimension. For an arbitrary tuple restrict all the matrices to the support of a maximizing witness \(X_*\) of the rank asserted in Section 2. This restriction preserves \(M_G^2\) because the same witness is feasible, and it can only decrease \(D_G^2\). Pad with zero directions up to \(d\) and normalize the total trace if necessary. Homogeneity and projection onto the nonzero directions show that padding preserves both objectives. On normalized tuples \(D_G^2\ge1/d\), by the admissibility of the independent scalar covariance and the largest eigenvalue of \(\sum_i A_i\). Both objectives are maxima of continuous functions over compact witness sets and therefore continuous. The normalized maximum in (10) exists.

*Realization for optimized ordinary traces.* Take a tuple and a maximizing \(X_*\) for its mixed objective. Set \(\kappa=M_G^2\) and \(s_i=\operatorname{tr}(X_*A_i)\), and choose a minimizer \(w^*\) of (5). We omit zero blocks when forming quotients. For every safe weight \(w\), (9) gives \(\sum_i s_i/w_i\ge\kappa\). The inequality \(\sum_i A_i/w_i^*\preceq\kappa I\) therefore has equality when traced against \(X_*\). The difference is positive semidefinite and annihilates the support \(U\) of \(X_*\). In addition \(w^*\) minimizes the scalar convex objective \(\sum_i s_i/w_i\). Taking the one-sided derivative along the segment from \(w^*\) to any safe \(w\) gives
\[
 \sum_i \frac{s_i w_i}{(w_i^*)^2}\le\sum_i\frac{s_i}{w_i^*}
   =\kappa .
\tag{11}
\]
Every originally nonzero \(A_i\) has \(w_i^*>0\). The derivative is valid even if the endpoint \(w_i=0\).

Restrict to \(U\), denote the compressed matrices by \(\widehat A_i\) and keep the same notation for the trace-one matrix \(X_*\) on \(U\). It is positive definite there. Thus \(s_i=0\) exactly when the compressed block is zero. We may project the weights to the remaining sensors using (4), with omitted coordinates extended by zero as needed. On \(U\) we have
\[
 \sum_i\widehat A_i/w_i^*=\kappa I_U .
\]
Use \(P_i=I_U\), \(H_i=\widehat A_i^{1/2}/w_i^*\) and \(K_i=\widehat A_i^{1/2}/\kappa\) on the retained sensors. Omitted sensors have \(H_i=K_i=0\) and \(P_i=I_U\). The gains are unbiased. Write \(\widehat D^2=D_G(\widehat A)^2\). The directional worst-variance identity proves conservativeness of \(B=(\widehat D^2/\kappa^2)I_U\). For any inflation with positive information \(Q=\sum_i w_i\widehat A_i/(w_i^*)^2\), (11) gives \(\operatorname{tr}(X_*Q)\le\kappa\). In a spectral basis for \(Q\), Cauchy–Schwarz on the diagonal entries of \(X_*\) gives
\[
 \operatorname{tr}(X_*Q^{-1})\ge
 \big(\operatorname{tr}(X_*Q)\big)^{-1}\ge1/\kappa .
\tag{12}
\]
At \(w^*\), \(Q=\kappa I_U\) attains this weighted trace bound. Finally apply the invertible state change \(x'=X_*^{1/2}x\). Ordinary traces of reported covariances in the new coordinates are their \(X_*\)-weighted traces in the old coordinates. The observation covariance uncertainty is unchanged and unbiasedness and conservativeness are preserved by this change of state. The trace ratio in the new model is at least \(\kappa/\widehat D^2\), which is at least the original mixed-to-directional ratio. Apply this to a maximizer in (10) to obtain the lower bound and attainment, since always \(C_{\rm tr}\le C_{\preceq}\). Adding \(\epsilon I\) to all \(A_i\) perturbs the ratio continuously and makes every compressed block positive definite. In that case each square \(H_i\) in the transformed state coordinates is invertible. Inverting it on the corresponding observation yields \(H_i=I\), transforms the marginal covariance by congruence and preserves its positive definiteness and all graph constraints.

*Exact computation.* The predicate that the right side of (10) is at least \(c\) has a finite formula over rational real polynomials with \(c\) a free variable. Existentially choose the normalized tuple, \(X\succeq0\) of trace one, a lifted witness for \(z\in\mathcal T_G\), and \(u_i\ge0\) satisfying \(u_i^2=z_i\operatorname{tr}(A_iX)\). For every unit \(v\), every lifted witness for \(z'\in\mathcal T_G\), and every \(u_i'\ge0\) with \((u_i')^2=z_i'v^\top A_i v\), require \((\sum_i u_i)^2\ge c(\sum_i u_i')^2\). Positive semidefiniteness is a finite set of principal-minor inequalities. Equation (3) proves equivalence to the desired predicate. Real quantifier elimination produces its finite endpoint as a real algebraic number. This computation places no polynomial-time bound in the number of sensors. Formula (10) also gives induced-subgraph monotonicity by adding zero matrices. For example, on two independent edges the two orthonormal frames at relative angle \(\pi/4\) give \(M_G^2=4\) and \(D_G^2=2+\sqrt 2\). For the latter identity the extra directional term is \(|\sin(2\theta)|+|\cos(2\theta)|\); for the former, \(X=I/2\) and \(w_i=1/2\) show matching lower and upper bounds. The trace price of that fixed graph is therefore at least \(4/(2+\sqrt 2)\).

## 7. Overlapping cliques and perfect graphs

**Theorem 4.** Clique inequalities
\[
 w\ge0,\qquad \sum_{i\in C}w_i\le1
       \quad\text{for every clique }C
\tag{13}
\]
characterize safety exactly if \(G\) is perfect. These are also exactly the graphs where every directional worst scalar variance can be attained by a sum of positive semidefinite rank-one matrices supported on individual cliques. Every perfect graph with clique number at most \(k\) satisfies \(C(G)\le\kappa_k\) of Theorem 2. For \(k\ge2\) the bound is sharp over the class even if the graph is connected, has intersecting maximal cliques, and every observation is an invertible full-state observation.

*Safety.* In the usual theta body convention with zeros on edges, \(\mathcal T_G=\operatorname{TH}(\bar G)\), so the theta-body antiblocker identity gives \(\mathcal W_G=\operatorname{TH}(G)\). If \(G\) is perfect, the stable-set polytope and the polytope (13) coincide, and the theta body lies between them. Conversely, if the safe set equals (13), its theta body is polyhedral, which characterizes perfect graphs by the theorem of Grötschel, Lovász and Schrijver. For a concrete failure on \(C_5\), the weights \(w_i=1/2\) meet the clique inequalities, whereas \(R=I+(\sqrt 5-1)A_{C_5}/2\) is an admissible correlation matrix with largest eigenvalue \(\sqrt 5>2\). Its eigenvalues follow from \(2\cos(2\pi j/5)\), the eigenvalues of the cycle adjacency matrix. [Grötschel, Lovász and Schrijver](https://doi.org/10.1016/0095-8956(86)90087-0) · [de Carli Silva and Tunçel](https://doi.org/10.1007/s10107-016-1041-3)

*Directional representation.* Let \(d_{Ci}\ge0\) for every clique \(C\) containing \(i\), including the singletons, and impose \(\sum_{C\ni i}d_{Ci}=1\). Then \(\widetilde F_G\), the worst quadratic form among sums of clique-supported positive semidefinite rank-one matrices with unit total diagonal, is
\[
 \widetilde F_G(s)=\max_d\sum_C
                \left(\sum_{i\in C}\sqrt{s_i d_{Ci}}\right)^2 .
\tag{14}
\]
For nonnegative direction coordinates a sign choice with every summand nonnegative suffices to maximize. Put \(T_{\rm cl}=\operatorname{conv}\{1_C:C\text{ a clique}\}\), including the empty clique. The value of (14) equals \((\max_{z\in T_{\rm cl}}\sum_i\sqrt{s_i z_i})^2\). To see the upper bound, apply Cauchy–Schwarz within each clique at positive weights satisfying (13), then sum over cliques. This bounds (14) by \(\inf_w\sum_i s_i/w_i\) over those weights. For \(s>0\), a maximizing \(z\) has positive coordinates, by the same square-root improvement argument as in Section 2 using singleton indicators. Its derivative shows that \(w_i=\sqrt{s_i/z_i}/\sum_j\sqrt{s_j z_j}\) satisfies (13) and attains the scalar infimum at the squared maximum. For the lower bound write this \(z=\sum_C p_C1_C\) as a convex combination. Assign \(d_{Ci}=p_C/z_i\) for \(i\in C\), and apply Jensen to \(\sum_C p_C(\sum_{i\in C}\sqrt{s_i/z_i})^2\). This gives the squared maximum as a lower bound. The identity extends to nonnegative \(s\) by continuity on the compact sets in each representation.

For a perfect graph, the polytope \(T_{\rm cl}\) equals \(\mathcal T_G\) because the complement of a perfect graph is perfect. Thus (3) gives \(F_G=\widetilde F_G\). Conversely, if these two functions coincide, (14) shows that every positive clique-feasible weight bounds every nonnegative directional variance. Sign invariance of \(\mathcal R_G\) gives the same inequality for arbitrary directions, so the weight is safe. Taking a limit gives safety for all clique-feasible weights. Every safe weight already meets the clique inequalities by considering perfectly correlated scalar errors on the clique, so the safety characterization implies perfection.

*Sharp factor.* For any mixed witness \(X\) of trace one put \(s_i=\operatorname{tr}(A_iX)\) and fix \(d_{Ci}\) maximizing (14). At a Gaussian \(g\) with covariance \(X\), the same assignment \(d\) is feasible in (14). Apply the cross-product estimate from Section 5 with each energy scaled by \(d_{Ci}\). The diagonal contribution is exact and in each clique is at least \(1/k\) times the whole squared sum at \(s\). Consequently
\[
 D_G^2\ \ge\ \mathbb E F_G((g^\top A_i g)_i)
 \ \ge\ \kappa_k^{-1}\sum_C
       \left(\sum_{i\in C}\sqrt{s_i d_{Ci}}\right)^2
 = \kappa_k^{-1}F_G(s).
\]
The first inequality uses \(\mathbb E\|g\|^2=1\). Theorem 3 gives the claimed guarantee. For sharpness, start with the arbitrarily large finite disjoint unions of \(k\)-cliques in Theorem 2. Attach a new vertex to one vertex in each clique and connect the new vertices by a path. With at least two original cliques the graph is connected and has intersecting maximal cliques. All the new edges are bridges, so every induced cycle lies in an original clique. The graph is chordal, hence perfect, and its largest clique still has size \(k\). The old union is an induced subgraph, which preserves its lower bound. The full-state approximation in Theorem 3 allows all the added sensors to be full-state as well. For \(k=1\), the exact factor is one by independence.

## 8. Replicating a correlation graph

For a finite graph \(G\) let \(NG\) denote the disjoint union of \(N\) copies. Let \(\Delta_m\) be the probability simplex and \(\mathcal E_m\) the real correlation matrices on \(m\) coordinates without any zero constraints.

**Theorem 5.** For every graph \(G\), including imperfect graphs,
\[
 \lim_{N\to\infty} C(NG)=
 \max_{\substack{s\in\Delta_m\\ T\in\mathcal E_m}}
 \frac{F_G(s)}
 {\mathbb E_{Z\sim N(0,T)} F_G((s_i Z_i^2)_i)}=:\Gamma(G).
\tag{15}
\]
The limit is unchanged if the state dimension is restricted to at most \(m\), or if in addition all observations are required to be full-state with positive-definite marginals. For a perfect graph it equals \(\kappa_{\omega(G)}\).

The denominator is at least \(\sum_i s_i=1\) because the independent scalar covariance is allowed. Both numerator and denominator are continuous in \((s,T)\). For the denominator, take \(Z=T^{1/2}Z_0\) with standard \(Z_0\), use continuity of the positive semidefinite square root and dominate by a constant times \(\|Z_0\|^2\). Here \(\sum_i s_i\le F_G(s)\le m\sum_i s_i\). Thus the maximum exists. Induced monotonicity makes \(C(NG)\) nondecreasing.

*Upper bound.* For trace-one \(X\succeq0\) and any tuple \(A\) on one copy put \(Q_i=X^{1/2}A_i X^{1/2}\), \(s_i=\operatorname{tr}Q_i\), and let \(Z_0\) be standard normal in its state dimension. The map
\[
 (Q_i)_i\longmapsto
 \mathbb E F_G((Z_0^\top Q_i Z_0)_i)
\]
is jointly concave by (9). Each \(Q_i\) is a convex combination of rank-one matrices \(s_i u_i u_i^\top\) at the same trace, with the zero matrix when \(s_i=0\). Taking product combinations across sensors, the expectation at the original tuple is at least the minimum of these rank-one expectations. At each rank-one tuple the projections \(u_i^\top Z_0\) have some correlation matrix in \(\mathcal E_m\), independent of the constraints on the sensor errors. By (15)'s maximand and homogeneity, each such expectation is at least \(F_G(s)/\Gamma(G)\). Across disjoint copies \(F_{NG}\) adds the copy objectives because the admissible scalar correlation matrix is block diagonal. Apply the inequality on each copy with the same \(g=X^{1/2}Z_0\). Directional maximality gives \(\mathbb E F_{NG}((g^\top A_i g)_i)\le D_{NG}^2\mathbb E\|g\|^2=D_{NG}^2\). Maximizing the resulting bound over \(X\) gives \(M_{NG}^2\le \Gamma(G)D_{NG}^2\).

*Matching construction.* Choose a maximizing \((s,T)\) in (15). Write \(T_{ij}=\langle u_i,u_j\rangle\) with unit vectors in dimension \(d_T=\operatorname{rank} T\le m\). Independently rotate this tuple by Haar orthogonal \(U_\ell\) for copy \(\ell\), and set
\[
 A_{\ell i}=d_T s_i\,U_\ell u_i u_i^\top U_\ell^\top .
\]
The mixed witness \(I/d_T\) gives \(M_{NG}^2\ge NF_G(s)\). For every fixed unit direction \(v\), the expected directional contribution of one copy is the denominator in (15). Indeed \(U_\ell^\top v\) has the distribution of a uniform direction on the unit sphere. Multiply it by the independent Gaussian radial length whose mean square is \(d_T\) and use homogeneity of \(F_G\). The empirical directional means converge uniformly on the sphere to this expectation for a sequence of rotations: the strong law gives simultaneous convergence on a countable dense set, and the functions are uniformly equicontinuous because the fixed quadratic forms and continuous \(F_G\) have uniform moduli on their compact domains. It follows that \(D_{NG}^2/N\) converges to that denominator. Theorem 3 converts the ratio to optimized trace and uniform Loewner factors in dimension at most \(d_T\), with the same full-state approximation. This proves (15). For a perfect graph, disjoint copies remain perfect, so Theorem 4 gives the upper bound \(\kappa_{\omega(G)}\). For the lower bound take \(s\) uniform on one maximum clique and zero elsewhere, and independent Gaussian coordinates on that clique. The squared-sum expectation then gives exactly \(\kappa_{\omega(G)}\).

## 9. Pooling and relation to prior fusion bounds

A sensor can be cloned into mutually uncorrelated sensors with the same neighbors without changing the worst constant \(C(G;n)\) for any \(n\). More generally, let \(G[G_i]\) be the graph obtained by replacing each vertex \(i\) of \(G\) by a nonempty graph \(G_i\) and joining all pairs across modules \(i,j\) precisely when \(ij\) is an edge of \(G\). For a vector \(a\) of nonnegative coordinates grouped by modules,
\[
 f_{G[G_i]}(a)=f_G((f_{G_i}(a_i))_i).
\tag{16}
\]
For the upper bound take a Gram representation for the whole graph and sum the weighted vectors in each module. Module sums for nonadjacent modules are orthogonal, and the norm of each sum is bounded by its \(f_{G_i}\). Coordinates that vanish can be given fresh orthogonal unit vectors, and monotonicity of \(f_G\) follows from (3). For the lower bound take maximizing representations inside the modules and for the base graph. Map each normalized module sum to the corresponding base vector by a linear isometry, putting the residual components in private mutually orthogonal spaces off the span of the base vectors. This preserves all required orthogonalities and attains the base maximum. A module with zero norm has all its direction coordinates zero and can use a fresh representation. For an uncorrelated module, \(f_{G_i}(a_i)=\|a_i\|_2\), so (16) identifies both matrix objectives with those of the base graph after replacing the module matrices by their sum. This establishes equality of the factors via Theorem 3, using zero matrices to represent any base tuple in the enlarged graph and the same equality for each fixed state dimension before taking the supremum.

General conservative linear unbiased estimation under partially specified covariance is established. Partitioned covariance intersection uses known cross-covariance information. Overlapping covariance intersection handles supplied bounds on overlapping projected covariance blocks. In the cited author version, Theorem 1 proves equivalence between the original problem (6) and its inverse-covariance formulation (9), Theorem 2 gives the necessary and sufficient feasibility condition, and Corollary 2 provides a semidefinite program for the Kahan-family optimum. The companion paper specializes family-optimal semidefinite formulations to several covariance intersection variants. Here the uncertainty is the full positive semidefinite cone with fixed marginals and exact graph zeros. Theorems 3 and 5 compute the sharp cross-instance loss of the whole safe scalar marginal-inflation family against optimization over unrestricted conservative unbiased gains. In particular the ordinary trace loss is achieved by an actual observation model, equates to the uniform matrix factor, and is stable at a bounded state dimension. The graph-specific optimization and the exact Gaussian replication formula answer different questions from computing an optimum within a chosen family for a supplied observation model. Split covariance intersection for two estimators can use further known decomposition of the errors. The complete-graph two-source theorem and the three-source counterexample used for comparison in Section 4 are established results. [Forsling et al.](https://doi.org/10.1109/TSP.2022.3179841) · [Pedroso, Batista and Heemels, overlapping covariance intersection](https://doi.org/10.1109/TAC.2026.3728727) · [Pedroso, Heemels and Batista, family-optimal fusion](https://doi.org/10.1109/LCSYS.2026.3698437) · [Cros et al.](https://doi.org/10.1109/TAC.2025.3530854) · [Reinhardt et al.](https://doi.org/10.1109/LSP.2015.2390417) · [Ajgl and Straka](https://doi.org/10.2478/amcs-2018-0040)

The theta-body identities, semidefinite extreme-point rank argument and Gaussian product estimate used here have classical precedents. Positive semidefinite Grothendieck problems optimize a fixed quadratic objective over Gram matrices with rank constraints. In (15) the graph response is itself a maximum over admissible covariance matrices and the Gaussian projection correlation is optimized separately. Theorem 3 gives a finite computation for each graph. Simple closed forms for the factors of many individual graphs, including the complete graph on six sensors, remain to be determined. [Lovász](https://doi.org/10.1109/TIT.1979.1055985) · [Pataki](https://doi.org/10.1287/moor.23.2.339) · [Briët, de Oliveira Filho and Vallentin](https://doi.org/10.1007/978-3-642-14165-2_4)
