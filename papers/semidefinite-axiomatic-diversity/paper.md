# An Axiomatic Diversity Measure from Threshold Semidefinite Programs

## Abstract

We construct a diversity functional on arbitrary symmetric nonnegative dissimilarity matrices whose zero entries represent genuine duplicates. It satisfies strict coordinatewise monotonicity, strict preference for replacing a duplicate by a new object, and continuity, without a triangle inequality or a Euclidean embedding assumption. The construction integrates a weighted semidefinite optimum over distance thresholds. Its central property is exact invariance under merging duplicate coordinates: aggregation preserves the moment matrix constraint and the objective. At small positive thresholds the optimum becomes the sum of distances between distinct objects, which gives strictness even when a coordinatewise increase splits duplicate classes. We prove explicit strictness margins, a Lipschitz estimate, scale covariance, and diameter bounds. The square root of the functional is homogeneous of degree one and globally Lipschitz. Evaluation reduces to at most \(\binom n2\) semidefinite programs with an explicit rational interior ball. Consequently, rational inputs admit deterministic relative approximation in time polynomial in the input length and the logarithm of the inverse accuracy. This is an approximation result for an exact axiomatic functional; exact symbolic evaluation is not asserted.

## 1. Introduction and scope

Mironov and Prokhorenkova [MP25] formulated three requirements for diversity on dissimilarity matrices: strict increase when distances increase, strict preference for a new object over a duplicate, and continuity. Their question asks whether all three can coexist with feasible computation. We use their full input domain, including duplicated objects and dissimilarities that need not satisfy a triangle inequality.

Threshold integration already appears in [MP25], and semidefinite lifting and numerical optimization are classical [LS91, GW95, VB96]. The contribution here is a particular entrywise-nonnegative, pair-weighted semidefinite functional whose feasible points admit exact duplicate aggregation. Together with a positive-length interval on which the quotient threshold graph is complete, that identity delivers all three strict axioms and a quantitative deterministic evaluation guarantee on the full domain. The argument does not require solving a maximum clique problem.

Ban, Roh, Shun, and Lakshman [BRSL26] recently introduced Geometric Kernel Diversity for Euclidean-realizable inputs. Their abstract states exact polynomial-time algorithms in dimensions at most three and randomized relative approximation in arbitrary dimension. Our domain is the unrestricted dissimilarity domain, and our approximation guarantee is deterministic in the rational bit model. The methods differ: their construction uses geometric unions, whereas ours uses threshold semidefinite programs. We make no claim about practical speed relative to their geometric algorithms.

The exact functional and its numerical approximation must be distinguished. Every axiom proved here concerns the exact real-valued function. An approximate numerical output need not preserve comparisons separated by arbitrarily small margins. Section 3 gives margins with which comparisons can instead be certified at a chosen precision. Section 6 gives a rational input with an irrational exact value.

### Theorem 1.1. Main result

For every \(n\geq1\), the functional \(\Phi_n\) defined in Section 2 is permutation invariant and satisfies the three Mironov–Prokhorenkova axioms on \(\mathcal D_n\). It is invariant under adding or removing duplicates, including changes in the number of indexed objects. For \(m=\binom n2\), \(D,E\in\mathcal D_n\), and
\[
R=\max\{R(D),R(E)\},\qquad
\|D-E\|_{1,\triangle}=\sum_{i < j}|d_{ij}-e_{ij}|,
\]
it satisfies
\[
|\Phi_n(D)-\Phi_n(E)|
\leq (m+1)R\|D-E\|_{1,\triangle},
\qquad
R(D)^2\leq\Phi_n(D)\leq mR(D)^2.
\tag{1.1}
\]
The lower bound is interpreted as \(0\leq0\) when \(n=1\). Moreover,
\[
\Phi_n(cD)=c^2\Phi_n(D)\qquad(c\geq0).
\tag{1.2}
\]
Consequently \(\Psi_n=\sqrt{\Phi_n}\) satisfies the same three axioms, is homogeneous of degree one, and obeys the global estimate
\[
|\Psi_n(D)-\Psi_n(E)|
\leq(m+1)\|D-E\|_{1,\triangle}.
\tag{1.3}
\]
For rational \(D\) and an integer precision request \(p\geq1\), put \(\varepsilon=2^{-p}\). A deterministic algorithm returns a rational \(\widehat\Phi\) such that
\[
(1-\varepsilon)\Phi_n(D)\leq\widehat\Phi\leq\Phi_n(D)
\tag{1.4}
\]
in time polynomial in \(n\), the binary encoding length of \(D\), and \(p\).

The structural and regularity assertions are proved in Sections 2–4. Section 5 treats the computational assertion.

## 2. Domain and construction

### 2.1. Dissimilarities and duplicate classes

Let \(\mathcal H_n\) be the set of symmetric nonnegative real \(n\times n\) matrices with zero diagonal. Let \(\mathcal D_n\subseteq\mathcal H_n\) consist of those matrices satisfying
\[
d_{ij}=0\quad\Longrightarrow\quad
d_{ik}=d_{jk}\quad\text{for every }k.
\tag{2.1}
\]
Thus zero distance identifies objects with identical distances to every object. No further geometric condition is imposed. Set
\[
R(D)=\max_{i < j}d_{ij}
\]
when \(n\geq2\), and set \(R(D)=0\) when \(n=1\).

For \(D\in\mathcal D_n\), the relation \(i\sim_Dj\) defined by \(d_{ij}=0\) is an equivalence relation. Reflexivity and symmetry are immediate. If \(d_{ij}=d_{jk}=0\), condition (2.1) gives \(d_{ik}=d_{jk}=0\), proving transitivity. Distances are constant between any two equivalence classes, and distances between different classes are positive. Write \(\overline D\) for the matrix obtained by retaining one representative of each class. If there are \(q(D)\) classes, define
\[
U(D)=\sum_{1\leq a < b\leq q(D)}\overline d_{ab}.
\tag{2.2}
\]
Neither \(\overline D\) up to simultaneous permutation nor \(U(D)\) depends on the representatives. For \(D\ne0\), let
\[
\rho(D)=\min\{d_{ij}:d_{ij}>0\}.
\tag{2.3}
\]

We use the following precise forms of the three axioms.

1. If \(A,B\in\mathcal D_n\), \(A\geq B\) entrywise, and \(A\ne B\), the diversity of \(A\) is strictly larger.
2. Fix \(n-1\) indexed objects. Appending an object distinct from all of them has strictly greater diversity than appending a duplicate of any one of them.
3. The diversity is continuous on \(\mathcal D_n\) in the relative topology inherited from real matrices.

The second axiom permits the distances from the new object to be smaller than the corresponding distances from the duplicate it replaces. The remaining \(n-1\) objects may themselves contain duplicates.

### 2.2. A graph-dependent semidefinite body

For a simple graph \(G=([n],E)\), define
\[
\begin{split}
\mathcal K(G)=\bigg\{(x,X):\;&x\in\mathbb R^n,\quad X=X^\top\in\mathbb R^{n\times n},\\
&M(x,X):=
\begin{pmatrix}1&x^\top\\x&X\end{pmatrix}\succeq0,\\
&X_{ii}=x_i\quad(1\leq i\leq n),\\
&X_{ij}\geq0\quad(i < j),\\
&X_{ij}=0\quad(\{i,j\}\notin E,\ i\ne j)
\bigg\}.
\end{split}
\tag{2.4}
\]
The nonnegativity inequalities are essential for the comparison arguments.

For \(D\in\mathcal H_n\) and \(t>0\), let
\[
G_t(D)=([n],\{\{i,j\}:i < j,\ d_{ij}\geq t\})
\tag{2.5}
\]
and define
\[
V_t(D)=
\max_{(x,X)\in\mathcal K(G_t(D))}
\sum_{i < j}d_{ij}X_{ij}.
\tag{2.6}
\]
Finally, set
\[
\Phi_n(D)=\int_0^\infty V_t(D)\,dt,
\qquad
\Psi_n(D)=\sqrt{\Phi_n(D)}.
\tag{2.7}
\]
The value at the single threshold \(t=0\) is immaterial. We usually suppress the subscript \(n\).

### Lemma 2.1. Compactness and elementary bounds

The set \(\mathcal K(G)\) is nonempty and compact. Every feasible point satisfies
\[
0\leq x_i\leq1,\qquad 0\leq X_{ij}\leq1.
\tag{2.8}
\]
Consequently, for \(D\in\mathcal H_n\),
\[
0\leq V_t(D)\leq\sum_{i < j}d_{ij}\leq mR(D).
\tag{2.9}
\]
The optimum is attained. It is zero for \(t>R(D)\) and is constant in \(t\) between successive distinct positive entries of \(D\). Thus the integral in (2.7) is finite.

**Proof.** The pair \((0,0)\) is feasible. The principal submatrix of \(M\) on coordinates \(0,i\) has determinant \(x_i-x_i^2\geq0\), which gives \(0\leq x_i\leq1\). The principal submatrix of \(X\) on \(i,j\) gives
\[
X_{ij}^2\leq X_{ii}X_{jj}=x_ix_j\leq1.
\]
Together with entrywise nonnegativity, this proves (2.8). The defining conditions are closed, so boundedness implies compactness. The objective is continuous, which proves attainment and (2.9). If \(t>R(D)\), every off-diagonal entry of \(X\) is forced to zero. Between thresholds the graph, and hence the optimization problem, is unchanged. \(\square\)

### Lemma 2.2. Permutations, restriction, and weak monotonicity

The functions \(V_t\), \(\Phi\), and \(\Psi\) are invariant under simultaneous permutations of rows and columns. If \(C\) is a principal submatrix of \(D\), then
\[
V_t(C)\leq V_t(D).
\tag{2.10}
\]
If \(A,B\in\mathcal H_n\) and \(A\geq B\), then
\[
V_t(A)\geq V_t(B)\qquad(t>0).
\tag{2.11}
\]

**Proof.** A permutation acts on \(M(x,X)\) by a congruence and preserves every constraint and the objective. To prove (2.10), extend a feasible point for \(C\) by zero in all missing coordinates; the resulting moment matrix is positive semidefinite and has the same objective.

For (2.11), every edge of \(G_t(B)\) is an edge of \(G_t(A)\). Thus \(\mathcal K(G_t(B))\subseteq\mathcal K(G_t(A))\). For a point feasible for the smaller body,
\[
\sum_{i < j}a_{ij}X_{ij}
\geq\sum_{i < j}b_{ij}X_{ij}
\]
because \(X_{ij}\geq0\). Taking maxima proves the claim. \(\square\)

## 3. Duplicate contraction and the strict axioms

### Lemma 3.1. Exact duplicate contraction

Let \(D\in\mathcal D_n\), and let \(\overline D\) retain one representative of each zero-distance class. For every \(t>0\),
\[
V_t(D)=V_t(\overline D).
\tag{3.1}
\]
In particular,
\[
\Phi_n(D)=\Phi_{q(D)}(\overline D).
\tag{3.2}
\]

**Proof.** Let \(C_1,\ldots,C_q\) be the classes, and let \(P\in\{0,1\}^{q\times n}\) have \(P_{ai}=1\) exactly when \(i\in C_a\). From a feasible \((x,X)\), form
\[
\overline x=Px,\qquad \overline X=PXP^\top.
\]
Then
\[
M(\overline x,\overline X)=
\begin{pmatrix}1&0\\0&P\end{pmatrix}
M(x,X)
\begin{pmatrix}1&0\\0&P^\top\end{pmatrix}\succeq0.
\tag{3.3}
\]
If \(i,j\) are distinct indices in one class, \(d_{ij}=0 < t\), so \(X_{ij}=0\). Therefore
\[
\overline X_{aa}
=\sum_{i,j\in C_a}X_{ij}
=\sum_{i\in C_a}x_i
=\overline x_a.
\]
Cross-class entries are nonnegative. When \(\overline d_{ab} < t\), every \(d_{ij}\) with \(i\in C_a,j\in C_b\) is below \(t\), so \(\overline X_{ab}=0\). Hence the aggregate is feasible for the quotient.

Distances are constant between classes, and within-class distances are zero. Consequently,
\[
\sum_{i < j}d_{ij}X_{ij}
=\sum_{a < b}\overline d_{ab}
\sum_{i\in C_a,\ j\in C_b}X_{ij}
=\sum_{a < b}\overline d_{ab}\overline X_{ab}.
\tag{3.4}
\]
This proves \(V_t(D)\leq V_t(\overline D)\).

For the reverse inequality, choose one index per class and place a quotient feasible point on these coordinates, with all other coordinates zero. This is a positive semidefinite zero extension, is feasible for \(D\), and preserves the objective. Integration gives (3.2). \(\square\)

### Lemma 3.2. The low-threshold identity

If \(D\in\mathcal D_n\) is nonzero and \(0 < t\leq\rho(D)\), then
\[
V_t(D)=U(D).
\tag{3.5}
\]
If \(D=0\), then \(V_t(D)=0=U(D)\) for every \(t>0\).

**Proof.** By Lemma 3.1, it suffices to consider \(\overline D\), whose off-diagonal entries are positive. At the stated thresholds its graph is complete. The point
\[
x=\mathbf1,\qquad X=\mathbf1\mathbf1^\top
\]
is feasible, and its objective is the sum of all entries above the diagonal. No point can have a larger objective because \(X_{ij}\leq1\). If \(D=0\), the objective in (2.6) is identically zero. \(\square\)

### Lemma 3.3. Quantitative increase of the quotient sum

Let \(A,B\in\mathcal D_n\), \(A\geq B\), and \(A\ne B\). Then
\[
U(A)-U(B)\geq
\Delta(A,B):=\max_{i < j}(a_{ij}-b_{ij})>0.
\tag{3.6}
\]

**Proof.** Every \(A\)-class is contained in a \(B\)-class: if \(a_{ij}=0\), then \(0\leq b_{ij}\leq a_{ij}=0\). Choose \(i,j\) attaining the positive maximum \(\Delta\).

If \(b_{ij}>0\), choose one representative of every \(B\)-class, including both \(i\) and \(j\). These representatives lie in different \(A\)-classes. Extend them to a full set of \(A\)-class representatives. The sum over pairs of the original representatives, evaluated using \(A\), is at least \(U(B)+\Delta\). Every additional pair contributes a nonnegative value, so (3.6) follows.

If \(b_{ij}=0\), then \(a_{ij}=\Delta>0\). Choose \(B\)-class representatives including \(i\), and extend them to \(A\)-class representatives including \(j\). The original pair sum is at least \(U(B)\); the additional pair \(\{i,j\}\) contributes \(\Delta\). Again all remaining terms are nonnegative. \(\square\)

### Theorem 3.4. Strict monotonicity with a margin

Let \(A,B\in\mathcal D_n\), \(A\geq B\), and \(A\ne B\). Define
\[
\alpha(A,B)=
\min\bigl(\{a_{ij}:a_{ij}>0\}
\cup\{b_{ij}:b_{ij}>0\}\bigr).
\tag{3.7}
\]
The set in (3.7) is nonempty, and
\[
\Phi(A)-\Phi(B)
\geq\alpha(A,B)[U(A)-U(B)]
\geq\alpha(A,B)\Delta(A,B)>0.
\tag{3.8}
\]

**Proof.** Lemma 2.2 gives \(V_t(A)\geq V_t(B)\) for every threshold. For \(0 < t\leq\alpha(A,B)\), Lemma 3.2 applies to each nonzero matrix, and also to the zero matrix under its separate clause. The difference of the optima is therefore \(U(A)-U(B)\) throughout this interval. Integrate there and use nonnegativity of the difference elsewhere. Lemma 3.3 completes the proof. \(\square\)

This argument includes increases that split one duplicate class into several classes. It does not assume that the duplicate partitions remain fixed.

### Theorem 3.5. Uniqueness with a margin

Let \(C\in\mathcal D_{n-1}\), where \(n\geq2\). Let \(B\in\mathcal D_n\) append to \(C\) a duplicate of one of its objects. Let \(A\in\mathcal D_n\) append an object whose distances to every object of \(C\) are positive. Choose one representative \(r_a\) of each of the \(q(C)\) classes of \(C\), and write \(z_a=a_{r_a,n}>0\). Then
\[
\Phi_n(A)-\Phi_n(B)
\geq \rho(A)\sum_{a=1}^{q(C)}z_a>0.
\tag{3.9}
\]

**Proof.** Lemma 3.1 gives \(V_t(B)=V_t(C)\). Zero extension gives \(V_t(A)\geq V_t(C)\) for every \(t>0\). The new object forms a single new class, so
\[
U(A)-U(C)=\sum_{a=1}^{q(C)}z_a.
\]
For \(0 < t\leq\rho(A)\), all positive distances in \(C\) also exceed or equal \(t\), so Lemma 3.2 gives
\[
V_t(A)-V_t(C)=\sum_a z_a.
\]
Integration and the nonnegative difference at other thresholds prove (3.9). \(\square\)

Theorem 3.5 proves the replacement axiom directly. It also shows that appending a distinct object strictly increases the unnormalized diversity, while appending a duplicate leaves it unchanged.

## 4. Continuity, scale, and bounds

### Proposition 4.1. Quantitative continuity on the larger domain

For every \(D,E\in\mathcal H_n\), with
\[
L=\|D-E\|_{1,\triangle},\qquad
R=\max\{R(D),R(E)\},\qquad m=\binom n2,
\]
one has
\[
|\Phi(D)-\Phi(E)|\leq(m+1)RL.
\tag{4.1}
\]
In particular,
\[
|\Phi(D)-\Phi(E)|
\leq m(m+1)R\|D-E\|_{\max}.
\tag{4.2}
\]

**Proof.** The case \(R=0\) is immediate. Let \(J\subseteq(0,R]\) be the union, over \(i < j\), of the intervals between \(d_{ij}\) and \(e_{ij}\). Endpoint choices do not affect its measure, and
\[
|J|\leq\sum_{i < j}|d_{ij}-e_{ij}|=L.
\]
Outside \(J\), the two threshold graphs are identical, apart from a finite set of endpoints. The feasible bodies are therefore identical. For any feasible point, (2.8) gives
\[
\left|\sum_{i < j}(d_{ij}-e_{ij})X_{ij}\right|\leq L,
\]
so the two optimum values differ by at most \(L\).

On \(J\), both values belong to \([0,mR]\), giving a difference of at most \(mR\). Both vanish above \(R\). Hence
\[
|\Phi(D)-\Phi(E)|
\leq RL+mR|J|
\leq(m+1)RL.
\]
The inequality \(L\leq m\|D-E\|_{\max}\) gives (4.2). \(\square\)

The proof allows changing threshold order and creating or removing zero distances. Thus no continuity of a selected optimizer, or a fixed graph over nearby inputs, is assumed.

### Proposition 4.2. Diameter bounds

For every \(D\in\mathcal H_n\),
\[
R(D)^2\leq\Phi(D)
\leq\sum_{i < j}d_{ij}^2
\leq mR(D)^2.
\tag{4.3}
\]
For \(D\in\mathcal D_n\), the upper bound sharpens to
\[
\Phi(D)\leq\sum_{a < b}\overline d_{ab}^{\,2}
\leq R(D)U(D)
\leq \binom{q(D)}2R(D)^2.
\tag{4.4}
\]
For nonzero \(D\in\mathcal D_n\), one also has
\[
\Phi(D)\geq\rho(D)U(D).
\tag{4.5}
\]

**Proof.** If \(R(D)=0\), all claims are immediate. Otherwise choose \(i,j\) with \(d_{ij}=R(D)\). For every \(0 < t\leq R(D)\), let \(u\) be the indicator of \(\{i,j\}\). The rank-one point \(x=u,\ X=uu^\top\) is feasible, because its only nonzero off-diagonal pair is an allowed edge. Its objective is \(R(D)\). Integrating over an interval of length \(R(D)\) gives the lower bound.

The zero constraints and \(X_{ij}\leq1\) give
\[
V_t(D)\leq\sum_{i < j}d_{ij}\mathbf1_{\{t\leq d_{ij}\}}.
\]
Integrating this bound proves (4.3). For \(D\in\mathcal D_n\), first contract duplicates and then apply the same bound to the quotient. The remaining inequalities in (4.4) follow from \(\overline d_{ab}\leq R(D)\). Integrating the identity in Lemma 3.2 over \((0,\rho(D)]\) proves (4.5). \(\square\)

### Proposition 4.3. Homogeneity and the globally Lipschitz score

For \(D\in\mathcal H_n\) and \(c\geq0\),
\[
\Phi(cD)=c^2\Phi(D),\qquad
\Psi(cD)=c\Psi(D).
\tag{4.6}
\]
For \(D,E\in\mathcal H_n\),
\[
|\Psi(D)-\Psi(E)|
\leq(m+1)\|D-E\|_{1,\triangle}.
\tag{4.7}
\]
Both functions satisfy all three axioms on \(\mathcal D_n\).

**Proof.** For \(c>0\), the threshold graph of \(cD\) at \(t\) is the threshold graph of \(D\) at \(t/c\), and the objective is multiplied by \(c\). Thus \(V_t(cD)=cV_{t/c}(D)\); change variables in the integral. The case \(c=0\) is immediate.

If \(R(D)=R(E)=0\), both square roots vanish. Otherwise, by Propositions 4.1 and 4.2,
\[
\begin{split}
|\Psi(D)-\Psi(E)|
&=\frac{|\Phi(D)-\Phi(E)|}{\sqrt{\Phi(D)}+\sqrt{\Phi(E)}}\\
&\leq
\frac{(m+1)\max\{R(D),R(E)\}\|D-E\|_{1,\triangle}}
{R(D)+R(E)}\\
&\leq(m+1)\|D-E\|_{1,\triangle}.
\end{split}
\]
Theorems 3.4 and 3.5 and Proposition 4.1 give the axioms for \(\Phi\). The square root is strictly increasing and continuous on nonnegative reals, so the axioms pass to \(\Psi\). \(\square\)

## 5. Finite computation and conditioning

### Proposition 5.1. A finite threshold formula

Suppose \(D\ne0\), and list its distinct positive off-diagonal entries as
\[
0=s_0 < s_1 < \cdots < s_k=R(D).
\]
Then
\[
\Phi(D)=\sum_{\ell=1}^k
(s_\ell-s_{\ell-1})V_{s_\ell}(D),
\qquad k\leq m.
\tag{5.1}
\]
When \(D=0\), \(\Phi(D)=0\).

**Proof.** On each interval \((s_{\ell-1},s_\ell]\), the condition \(d_{ij}\geq t\) is equivalent to \(d_{ij}\geq s_\ell\). Hence the graph and optimum are constant on that interval. The optimum vanishes above \(s_k\). \(\square\)

Formula (5.1) is exact. There is no numerical quadrature error. Its remaining numerical issue is approximation of finitely many semidefinite optimum values.

### Lemma 5.2. Explicit rational interior and outer bounds

Let \(G=([n],E)\), and use the free coordinates
\[
y=(x_1,\ldots,x_n,(z_{ij})_{\{i,j\}\in E}),\qquad
z_{ij}=X_{ij},
\]
with \(X_{ii}=x_i\) and \(X_{ij}=0\) on nonedges. Their dimension is \(N=n+|E|\leq n^2\). In this coordinate space, \(\mathcal K(G)\) contains the Euclidean ball
\[
B\left(y_0,\frac1{64n^2}\right),
\tag{5.2}
\]
where
\[
x_i=\frac1{4n},\qquad z_{ij}=\frac1{16n^2}.
\tag{5.3}
\]
It is contained in \([0,1]^N\), and hence in \(B(0,n)\). All these data have binary encoding length polynomial in \(n\), uniformly over \(G\).

**Proof.** Set \(\alpha=1/(4n)\), \(\beta=1/(16n^2)=\alpha^2\), and let \(A_G\) be the adjacency matrix. At the stated center,
\[
x_0=\alpha\mathbf1,\qquad X_0=\alpha I+\beta A_G.
\]
The Schur complement of the leading entry of the moment matrix is
\[
S_0=X_0-x_0x_0^\top.
\]
Its diagonal entries are \(\alpha-\beta\); its off-diagonal entries are zero on edges and \(-\beta\) on nonedges. Every diagonal dominance margin is at least
\[
\alpha-\beta-(n-1)\beta
=\frac3{16n}.
\]
Consequently \(S_0\succeq(3/(16n))I\). With
\[
L_0=\begin{pmatrix}1&0\\x_0&I\end{pmatrix},
\]
we have
\[
M_0=L_0\operatorname{diag}(1,S_0)L_0^\top.
\]
Since
\[
\|L_0^{-1}\|_{\mathrm{op}}
\leq1+\|x_0\|_2
\leq\frac54,
\]
it follows that
\[
M_0\succeq\frac3{25n}I.
\tag{5.4}
\]

A perturbation of the free coordinates by \(\delta y=(\delta x,\delta z)\) changes the moment matrix by
\[
\|\delta M\|_{\mathrm F}^2
=3\|\delta x\|_2^2+2\|\delta z\|_2^2
\leq3\|\delta y\|_2^2.
\]
If \(\|\delta y\|_2\leq1/(64n^2)\), (5.4) implies that the perturbed moment matrix remains positive definite. Each allowed off-diagonal coordinate remains at least
\[
\frac1{16n^2}-\frac1{64n^2}
=\frac3{64n^2}>0.
\]
Thus the ball (5.2) is feasible. The outer bound follows from Lemma 2.1. The center and radius are rational with polynomial encoding length. \(\square\)

### Theorem 5.3. Deterministic relative approximation

For rational \(D\in\mathcal H_n\) and an integer precision request \(p\geq1\), the approximation guarantee (1.4), with \(\varepsilon=2^{-p}\), can be attained in time polynomial in \(n\), the binary encoding length of \(D\), and \(p\).

**Proof.** The zero input is detected exactly. Otherwise normalize \(D\) by its positive rational diameter \(R(D)\). The normalized entries and thresholds have polynomial encoding length, and the normalized diameter equals one.

For each graph in Proposition 5.1, the free-coordinate feasible body is a compact full-dimensional convex set with the explicit inner and outer bounds of Lemma 5.2. It has a polynomial-time rational separation oracle: negative allowed coordinates are separated by coordinate inequalities, and a rational moment matrix that is not positive semidefinite is separated by a rational quadratic-form certificate. Appendix B gives the elimination procedure and its bit-complexity justification. The separation-to-weak-optimization theorem for well-bounded convex bodies [GLS88, Chapter 4] therefore applies.

For completeness, an approximate optimizer supplied by weak optimization can be moved toward the rational interior point to obtain an actually feasible rational point with a controlled objective loss. The quantitative correction is given in Appendix A. For a normalized objective whose nonzero coefficients are distances in \([0,1]\), it yields a feasible rational point with value \(\widehat v_\ell\) satisfying
\[
0\leq V_{s_\ell/R}(D/R)-\widehat v_\ell\leq\varepsilon
\tag{5.5}
\]
using polynomial time and precision. If desired, the zero feasible point replaces any negative objective output.

Here \(s_\ell\) denotes an original threshold of \(D\), so \(s_\ell/R\) is the corresponding normalized threshold. Use (5.1) on \(D/R\), with widths \((s_\ell-s_{\ell-1})/R\), replacing every optimum by \(\widehat v_\ell\), and multiply the result by \(R^2\). The normalized interval widths are nonnegative and sum to one. Hence
\[
0\leq\Phi(D)-\widehat\Phi\leq\varepsilon R^2.
\]
Proposition 4.2 gives \(R^2\leq\Phi(D)\), proving (1.4). There are at most \(m\) optimization calls. Normalization, sorting, and the finite rational weighted sum have polynomial bit complexity. \(\square\)

To obtain a rational relative approximation of \(\Psi\) for nonzero \(D\), first apply Theorem 5.3 at accuracy \(\eta=\varepsilon/2\). If \(q=\sqrt{\widehat\Phi}\), then
\[
(1-\eta)\Psi\leq q\leq\Psi,\qquad q\geq R/2.
\]
The first inequality follows from \(\sqrt{1-\eta}\geq1-\eta\), and the diameter bound gives the second. Bisect the rational interval \([0,nR]\), comparing squared midpoints with \(\widehat\Phi\), until its width is at most \(\eta R/2\). Its lower endpoint \(\widehat\Psi\) satisfies
\[
(1-\varepsilon)\Psi
\leq(1-\eta)^2\Psi
\leq\widehat\Psi\leq\Psi.
\]
The bisection takes \(O(\log(n/\eta))\) steps with polynomial bit lengths. The zero input is returned exactly.

For an arbitrary rational tolerance \(0 < \varepsilon < 1\), one may choose a dyadic tolerance no larger than \(\varepsilon\); the time then also includes reading the supplied tolerance. The precision-request formulation avoids a dependence on redundant encodings of the same requested numerical accuracy. The exact axioms remain assertions about \(\Phi\) and \(\Psi\), rather than about a rounded output.

## 6. Exact calibrations and an irrational value

### Proposition 6.1. Complete and two-object calibrations

If all indexed objects coincide, then \(\Phi=0\). If there are precisely two distinct objects at distance \(r>0\), with arbitrary duplicate multiplicities, then
\[
\Phi=r^2,\qquad \Psi=r.
\tag{6.1}
\]
More generally, if there are \(q\) distinct objects and every distance between distinct objects equals \(r>0\), then
\[
\Phi=\binom q2r^2,\qquad
\Psi=\sqrt{\binom q2}\,r.
\tag{6.2}
\]

**Proof.** Contract duplicates. For \(0 < t\leq r\), the quotient threshold graph is complete and \(V_t=\binom q2r\) by Lemma 3.2. For \(t>r\), the objective vanishes. Integrate. \(\square\)

### Proposition 6.2. A five-cycle input with an irrational value

Let \(n=5\), and put \(d_{ij}=2\) when \(\{i,j\}\) is an edge of a five-cycle and \(d_{ij}=1\) otherwise. Then
\[
\Phi(D)=20-\sqrt5.
\tag{6.3}
\]

**Proof.** For \(0 < t\leq1\), the threshold graph is complete, so \(V_t=5\cdot2+5\cdot1=15\). For \(1 < t\leq2\), the allowed graph is a five-cycle. Let
\[
v=\max_{\mathcal K(C_5)}\sum_{\{i,j\}\in E(C_5)}X_{ij}.
\]
The objective in (2.6) on this interval is \(2v\).

Averaging a feasible point over cyclic permutations preserves feasibility and the objective. We may therefore take \(x_i=a\), \(X_{ii}=a\), \(X_{ij}=b\) on cycle edges, and zero on nonedges. Put \(\varphi=(1+\sqrt5)/2\). The Schur complement is
\[
aI+bA_{C_5}-a^2\mathbf1\mathbf1^\top.
\]
Its eigenvalue on the constant vector is \(a+2b-5a^2\). The remaining cycle-adjacency eigenvalues give the conditions \(a-\varphi b\geq0\) and \(a+(\varphi-1)b\geq0\). Since \(b\geq0\), feasibility is equivalent to
\[
a\geq\varphi b,\qquad a+2b\geq5a^2,\qquad b\geq0.
\tag{6.4}
\]
These inequalities imply, for \(a>0\),
\[
5a^2\leq a+\frac{2a}{\varphi}=\sqrt5\,a,
\qquad
b\leq\frac1{\sqrt5\,\varphi}.
\]
The case \(a=0\) has \(b=0\). Equality is attained at
\[
a=\frac1{\sqrt5},\qquad
b=\frac1{\sqrt5\,\varphi}.
\]
Therefore
\[
v=5b=\frac{5-\sqrt5}{2}.
\]
Integrating over the two unit-length intervals gives
\[
\Phi(D)=15+2v=20-\sqrt5.
\]
\(\square\)

This example also distinguishes the semidefinite optimum from a clique optimum: in the unweighted five-cycle the largest clique has one edge, whereas \(v>1\). The construction uses the relaxed value itself as the diversity ingredient. It does not use the value to recover a clique.

## 7. Interpretation and limitations

The duplicate contraction lemma explains why this relaxation is suitable for the axioms. The condition \(X_{ii}=x_i\), together with vanishing within-class off-diagonal entries, makes the diagonal identity survive aggregation. Positive semidefiniteness survives the same aggregation by congruence. Entrywise nonnegativity preserves coordinatewise comparisons, and the rank-one all-ones point fixes the optimum on the complete quotient graph. Integrating over thresholds preserves weak comparisons and assigns positive measure to an interval on which they are strict.

The guarantees concern a mathematical measure on exact dissimilarities. They neither identify a uniquely appropriate measure for a particular application nor establish that satisfying these three axioms predicts an application's empirical notion of diversity. The score is invariant under duplicate multiplicities, so it intentionally measures the represented distinct objects rather than their sampling frequencies. It is not normalized to a fixed range across different numbers of distinct objects.

The evaluation guarantee is polynomial bit complexity for approximation. It does not give a low-degree implementation bound, establish performance on large datasets, or furnish a finite rational representation of every exact optimum. Proposition 6.2 makes the latter distinction explicit. The deterministic approximation theorem gives a positive answer to the computational approximation version of the axiomatic existence question on the full dissimilarity domain.

## Appendix A. From weak optimization to feasible objective approximation

Let \(K\subseteq\mathbb R^N\) be one of the free-coordinate bodies in Lemma 5.2, with interior center \(y_0\) and radius \(\rho=1/(64n^2)\). Both \(K\) and \(y_0\) lie in \(B(0,n)\). Let \(c\) be a normalized objective vector, so \(\|c\|_2\leq n\).

Write \(K^{+\xi}=K+\xi B_2\), and
\[
K^{-\xi}=\{z:z+\xi B_2\subseteq K\}.
\]
The weak-optimization guarantee used here produces a rational \(y\in K^{+\xi}\) such that
\[
c^\top y\geq \max_{z\in K^{-\xi}}c^\top z-\xi.
\tag{A.1}
\]
Choose rational \(0 < \xi < \rho\). If \(x^*\in K\) maximizes \(c^\top x\), then
\[
z=(1-\xi/\rho)x^*+(\xi/\rho)y_0
\]
belongs to \(K^{-\xi}\): the radius-\(\xi\) ball around \(z\) is contained in the corresponding convex combination of \(x^*\) and the radius-\(\rho\) ball around \(y_0\). Also,
\[
c^\top x^*-c^\top z
\leq\frac{\xi}{\rho}\|c\|_2\|x^*-y_0\|_2
\leq128n^4\xi.
\tag{A.2}
\]

Set
\[
\lambda=\frac{\xi}{\rho+\xi},\qquad
w=(1-\lambda)y+\lambda y_0.
\tag{A.3}
\]
There is an \(x\in K\) with \(\|y-x\|_2\leq\xi\). Since \((1-\lambda)\xi=\lambda\rho\),
\[
w=(1-\lambda)x+
\lambda\left(y_0+\frac{1-\lambda}{\lambda}(y-x)\right)
\]
is a convex combination of two points of \(K\). Thus \(w\in K\) exactly, although \(x\) need not be computed. The point \(w\) is rational because \(y,y_0,\lambda\) are rational.

Using \(\|y\|_2\leq n+\xi\) and \(\xi < 1\),
\[
|c^\top(y-w)|
\leq\lambda\|c\|_2\|y-y_0\|_2
\leq192n^4\xi.
\tag{A.4}
\]
Combining (A.1)–(A.4) gives
\[
0\leq\max_{x\in K}c^\top x-c^\top w
\leq(320n^4+1)\xi.
\tag{A.5}
\]
Taking \(\xi=\varepsilon/(1024n^4)\) proves the feasible additive accuracy required in (5.5). This choice is below \(\rho\) for \(0 < \varepsilon < 1\) and \(n\geq1\). Its binary length is polynomial in \(\log n+\log(1/\varepsilon)\).

The separation-to-weak-optimization theorem in [GLS88, Corollary 4.2.7], with the explicit rational inner and outer balls and separation oracle described in Section 5, provides the polynomial-time implementation of (A.1). Its alternative output would assert that \(K^{-\xi}\) is empty; the constructed point \(z\) rules out this alternative. This correction avoids interpreting an approximately feasible weak optimizer as an exactly feasible point.

## Appendix B. Exact rational separation

Let \(y\) be a rational query point in the free coordinates of Lemma 5.2. If an allowed coordinate \(z_{ij}\) is negative, the inequality \(z_{ij}\geq0\) separates \(y\) from the feasible body. Otherwise form the rational symmetric matrix \(M(y)\).

The following recursive elimination either establishes positive semidefiniteness or constructs a rational vector \(w\) with \(w^\top M(y)w < 0\). A negative diagonal entry gives a coordinate-vector witness. If every diagonal entry is zero, a nonzero off-diagonal entry \(h_{ij}\) gives the witness \(e_i-\operatorname{sign}(h_{ij})e_j\); an all-zero matrix is positive semidefinite. In the remaining case, choose a positive diagonal pivot and write the current matrix as
\[
H=\begin{pmatrix}a&r^\top\\r&B\end{pmatrix},\qquad a>0.
\]
Apply the same procedure to the rational Schur complement \(B-rr^\top/a\). A negative witness \(u\) for that complement lifts to
\[
\begin{pmatrix}-r^\top u/a\\u\end{pmatrix},
\]
whose quadratic form under \(H\) equals the negative quadratic form under the complement. If the complement is positive semidefinite, the Schur complement criterion shows that \(H\) is positive semidefinite. Thus zero pivots are not mistaken for a positive-semidefiniteness certificate.

This computation can be performed with polynomial bit complexity. After clearing denominators, fraction-free elimination, or equivalent determinant-ratio formulas, expresses the needed Schur complement entries through minors of a polynomial-size integer matrix. Hadamard's determinant bound makes their encoding lengths polynomial in the original query length. There are at most \(n+1\) pivots. Back substitution in the associated triangular factors constructs the lifted witness by rational operations with the same polynomial encoding bound. Integer-preserving Gaussian elimination is classical; see [B68].

For the resulting witness \(w=(w_0,w_1,\ldots,w_n)\), the inequality
\[
w_0^2+\sum_i(2w_0w_i+w_i^2)x_i
+2\sum_{\{i,j\}\in E}w_iw_jz_{ij}\geq0
\tag{B.1}
\]
holds throughout the feasible body and is violated at \(y\). Its linear coefficient vector is nonzero, since the feasible body is nonempty and the constant term \(w_0^2\) is nonnegative. Dividing by the infinity norm of this rational coefficient vector supplies a rational normalized separator. An exact feasible query is, in particular, within every prescribed positive weak-feasibility tolerance. Therefore this strong separation procedure implements the weak separation oracle used by [GLS88].

## References

[MP25] Mikhail Mironov and Liudmila Prokhorenkova. **Measuring Diversity: Axioms and Challenges.** Proceedings of the 42nd International Conference on Machine Learning, Proceedings of Machine Learning Research 267, 44396–44411, 2025. [Official proceedings](https://proceedings.mlr.press/v267/mironov25a.html); [arXiv:2410.14556v2](https://arxiv.org/html/2410.14556v2).

[BRSL26] Ditbul Ban, Younghun Roh, Julian Shun, and Vihan Lakshman. **Geometric Kernel Diversity: An Axiomatic Diversity Measure in Euclidean Space.** arXiv:2610.19570, 2026. [Primary record](https://arxiv.org/abs/2610.19570). The comparison in Section 1 uses the claims stated in the primary abstract; it does not rely on unverified details of the paper's proofs or computational model.

[GLS88] Martin Grötschel, László Lovász, and Alexander Schrijver. **Geometric Algorithms and Combinatorial Optimization.** Algorithms and Combinatorics 2, Springer, 1988. DOI: [10.1007/978-3-642-97881-4](https://doi.org/10.1007/978-3-642-97881-4). [Author-hosted full text](https://www.zib.de/userpage/groetschel/pubnew/paper/groetschellovaszschrijver1988.pdf).

[LS91] László Lovász and Alexander Schrijver. **Cones of Matrices and Set-Functions and 0–1 Optimization.** SIAM Journal on Optimization 1(2), 166–190, 1991. DOI: [10.1137/0801013](https://doi.org/10.1137/0801013).

[VB96] Lieven Vandenberghe and Stephen Boyd. **Semidefinite Programming.** SIAM Review 38(1), 49–95, 1996. DOI: [10.1137/1038003](https://doi.org/10.1137/1038003). [Author-hosted full text](https://web.stanford.edu/~boyd/papers/pdf/semidef_prog.pdf).

[GW95] Michel X. Goemans and David P. Williamson. **Improved Approximation Algorithms for Maximum Cut and Satisfiability Problems Using Semidefinite Programming.** Journal of the ACM 42(6), 1115–1145, 1995. DOI: [10.1145/227683.227684](https://doi.org/10.1145/227683.227684). [Author-hosted full text](https://math.mit.edu/~goemans/PAPERS/maxcut-jacm.pdf).

[B68] Erwin H. Bareiss. **Sylvester's Identity and Multistep Integer-Preserving Gaussian Elimination.** Mathematics of Computation 22(103), 565–578, 1968. DOI: [10.1090/S0025-5718-1968-0226829-0](https://doi.org/10.1090/S0025-5718-1968-0226829-0). [Official publisher PDF](https://www.ams.org/mcom/1968-22-103/S0025-5718-1968-0226829-0/S0025-5718-1968-0226829-0.pdf).
