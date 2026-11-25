# Sharp KCBS pentagon bounds from scalar or operator overlap data

## Abstract

Let $P_0,\ldots,P_4$ be rank-one orthogonal projectors on a finite-dimensional complex Hilbert space, with $P_iP_{i+1}=0$, where indices are taken modulo five. We prove
$$
\lambda_{\max}\!\left(\sum_{i=0}^4P_i\right)-2
\leq
\max_i\|[P_i,P_{i+2}]\|\,\|[P_{i+1},P_{i+3}]\|.
$$
This settles the arbitrary-dimensional rank-one sector of Wu's pentagon conjecture. The proof gives a stronger local statement: in the five-cycle of allowed off-diagonal Gram entries, any locally smallest edge selects a single pair of disjoint edges whose commutator scores already bound the violation. A comparison of two endpoint resolvents of a four-vertex path reduces the result to a scalar inequality. The comparison is valid for complex entries directly, and a positive-definite approximation includes singular Gram matrices and zero overlaps. An explicit three-dimensional configuration attains equality. At higher ranks we determine the exact envelope for a prescribed chord and the exact condition for all completions of a prescribed three-chord path. The crossing-product bound applies when the three path blocks split into scalar sectors with the central overlap locally smallest. The other two blocks can mix the sectors. An irreducible rank-two construction shows the coefficient remains sharp.

## 1. Problem and scope

The KCBS scenario consists of five projectors with cyclic exclusivity, and its noncontextual probability bound is
$$
\sum_{i=0}^{4}\langle P_i\rangle\leq2
$$
[1]. For binary Lüders measurements, the optimized total-variation distance between the two measurement orders equals the norm of the projector commutator. Wu [2, Theorem 10 and Conjecture 2] proved the resulting crossing-chord bound for rank-one qutrit projectors and proposed its extension to arbitrary ranks and dimensions.

The present result removes the dimension restriction for rank-one projectors. In addition, it identifies one sufficient crossing pair by a local comparison of three overlaps. The proof uses neither real-vector assumptions nor a reduction to three-dimensional realizations. The five vectors can span dimensions three, four, or five; embedding their span into a larger finite-dimensional Hilbert space changes none of the quantities considered.

Throughout, $\|\cdot\|$ is the operator norm, $A^*$ is the conjugate transpose, and $A\succeq0$ means that the Hermitian matrix $A$ is positive semidefinite. Inner products are conjugate-linear in the first argument. All indices on a pentagon are taken modulo five.

## 2. Commutator scores and the main theorem

For orthogonal projectors $P,Q$, define
$$
\mathcal T(P,Q):=\|[P,Q]\|.
\tag{2.1}
$$
This is the quantity in the source conjecture. Its known measurement-order interpretation from [2, Theorem 1] motivates the terminology; the proof here uses the operator-norm definition (2.1) directly. No optimization over Lüders records is a hypothesis or a separately proved result of this paper.

### Lemma 2.1. Rank-one commutator score

If $P=vv^*$ and $Q=ww^*$ for unit vectors $v,w$, and
$z=|\langle v,w\rangle|^2$, then
$$
\mathcal T(P,Q)=\sqrt{z(1-z)}.
\tag{2.2}
$$

**Proof.**
Choose the phase of $w$ so that $\langle v,w\rangle=c\geq0$. This does not change $Q$. If $0<c<1$, write
$w=cv+\sqrt{1-c^2}\,e$, with $e$ a unit vector orthogonal to $v$. On their two-dimensional span the commutator is
$$
[P,Q]=
\begin{pmatrix}
0&c\sqrt{1-c^2}\\
-c\sqrt{1-c^2}&0
\end{pmatrix},
$$
and it vanishes on the orthogonal complement. Its norm is
$c\sqrt{1-c^2}$. The cases $c=0$ and $c=1$ give zero directly. Since $z=c^2$, formula (2.2) follows. $\square$

### Theorem 2.2. Rank-one pentagon bound in every finite dimension

Let $v_0,\ldots,v_4\in\mathbb C^d$ be unit vectors satisfying
$\langle v_i,v_{i+1}\rangle=0$, and let $P_i=v_iv_i^*$. Then
$$
\boxed{
\lambda_{\max}\!\left(\sum_{i=0}^{4}P_i\right)-2
\leq
\max_i\mathcal T(P_i,P_{i+2})\,
             \mathcal T(P_{i+1},P_{i+3}).
}
\tag{2.4}
$$
Consequently the same right-hand side bounds
$\operatorname{Tr}(\rho\sum_iP_i)-2$ for every density matrix $\rho$.

The pairs $(i,i+2)$ and $(i+1,i+3)$ are crossing diagonals of the original pentagon. The proof of Theorem 2.2 follows from the matrix theorem below.

## 3. A stronger local theorem for a complex five-cycle

Let $H$ be a Hermitian $5\times5$ matrix with zero diagonal and support contained in a five-cycle. Write its cyclic edge entries as $h_0,\ldots,h_4$, so that
$$
H_{j,j+1}=h_j,\qquad H_{j+1,j}=\overline{h_j}.
$$
Let $a_j=|h_j|$. If $I+H\succeq0$, its $2\times2$ principal minors give $0\leq a_j\leq1$.

### Theorem 3.1. A locally smallest edge selects a sufficient pair

Assume $I+H\succeq0$. If
$$
a_j\leq a_{j-1}\quad\text{and}\quad a_j\leq a_{j+1},
\tag{3.1}
$$
then
$$
H\preceq
\left[
1+
a_{j-1}a_{j+1}
\sqrt{(1-a_{j-1}^2)(1-a_{j+1}^2)}
\right]I.
\tag{3.2}
$$
In particular,
$$
\lambda_{\max}(H)-1
\leq
\max_j
a_ja_{j+2}\sqrt{(1-a_j^2)(1-a_{j+2}^2)}.
\tag{3.3}
$$

The two edges adjoining the locally smallest edge are disjoint. Existence of at least one such edge follows by selecting a globally smallest $a_j$. Condition (3.1) uses overlap magnitudes, rather than the order scores, which need not be monotone in those magnitudes.

We first establish the scalar inequality used in its proof.

## 4. The scalar inequality

### Lemma 4.1

Let $x,z\in[0,1]$, and set
$$
k=(1-x)(1-z),\qquad u=\sqrt{xzk}.
$$
For $0\leq y\leq\min(x,z,k)$, define
$$
F(y)=
k\left[(1-y)u(u+2)+(1-y)^2+y(x+z)\right]-y.
\tag{4.1}
$$
Then $F(y)\geq0$.

**Proof.**
If $k=0$, then $u=y=0$, and the assertion is immediate. Assume $k>0$. Let $r=\min(x,z,k)$. The identity
$$
F(y)-F(r)
=(r-y)
\left[
1+k\{u(u+2)+2-x-z-y-r\}
\right]
\tag{4.2}
$$
shows that $F(y)\geq F(r)$. Indeed,
$y,r\leq k\leq1-x,1-z$, whence
$x+z+y+r\leq2$. It therefore suffices to consider the three possible choices of $r$.

**Case A: $k\leq x,z$.**
Using $x+z=1+xz-k$ and $u^2=xzk$, we obtain
$$
F(k)=k(u+1)\,[2u-k(u+1)].
\tag{4.3}
$$
Put $q=xz$. The inequality $(x-k)(z-k)\geq0$ gives
$$
q(1-k)\geq k(1-2k).
\tag{4.4}
$$
Also
$$
k=(1-x)(1-z)\leq(1-k)^2,
$$
so $k^2-3k+1\geq0$. The assumptions exclude $k=1$. Consequently
$$
\begin{aligned}
q(2-k)^2-k
&\geq
\frac{k\{(1-2k)(2-k)^2-(1-k)\}}{1-k}\\
&=
\frac{k(3-2k)(k^2-3k+1)}{1-k}
\geq0.
\end{aligned}
\tag{4.5}
$$
Multiplication by $k$, followed by taking nonnegative square roots, gives
$$
u(2-k)\geq k.
$$
This is exactly $2u\geq k(u+1)$. Equation (4.3) proves $F(k)\geq0$.

**Case B: $x\leq z,k$.**
If $x=0$, then $u=0$ and $F(x)=k\geq0$. Suppose $x>0$, and put
$$
p=1-x,\qquad s=1-z.
$$
The domain becomes
$$
0<p<1,\qquad \frac{x}{p}\leq s\leq p.
\tag{4.6}
$$
Here
$$
k=ps,\qquad u=\sqrt{xp\,s(1-s)}.
$$
The relation $s\geq x/p\geq x$ and $s\leq p$ give
$$
u^2-x^2p^2=xp(s-x)(p-s)\geq0,
$$
so $u\geq xp$. Put $\ell=x/p$ and $B=2-3p+2p^2$. Expanding $F(x)$ and then using the nonnegative coefficient of $u$ yields
$$
\begin{aligned}
F(x)
&=ps\left[B+x(p^2-1)s-p^2xs^2+2pu\right]-x\\
&\geq g(s),
\end{aligned}
\tag{4.7}
$$
where
$$
g(s)=ps\left[B+x(p^2-1)s-p^2xs^2+2p^2x\right]-x.
$$
The exact difference factorization is
$$
\begin{aligned}
g(s)-g(\ell)
=p(s-\ell)\bigl[&B+x(p^2-1)(s+\ell)\\
&-p^2x(s^2+s\ell+\ell^2)+2p^2x\bigr].
\end{aligned}
\tag{4.8}
$$
Both $s$ and $\ell$ lie in $[0,p]$. Because $p^2-1\leq0$, the bracket in (4.8) is bounded below by
$$
B+2px(p^2-1)-3p^4x+2p^2x=R(p)+2p^2x,
$$
where
$$
R(p)=3p^5-5p^4+2p^3+4p^2-5p+2.
$$
This lower bound is nonnegative: $x\geq0$, and
$$
\begin{aligned}
R(p)={}&2(1-p)^5+5p(1-p)^4+4p^2(1-p)^3\\
&+4p^3(1-p)^2+p^4(1-p)+p^5\geq0.
\end{aligned}
\tag{4.9}
$$
Since $s\geq\ell$, equation (4.8) proves $g(s)\geq g(\ell)$. Finally,
$$
g(\ell)=\frac{x^2(p^2+p-1)}p\geq0,
\tag{4.10}
$$
because $\ell\leq p$ is equivalent to $x\leq p^2$, or $p^2+p-1\geq0$. Thus $F(x)\geq0$, using only polynomial identities and nonnegative square roots.

**Case C: $z\leq x,k$.**
This is Case B with $x$ and $z$ exchanged. All possibilities for $r$ have been covered. Together with (4.2), they establish the lemma. $\square$

## 5. Proof of the matrix theorem

Relabel the cycle so that the locally smallest edge is the middle edge of a path on the first four vertices. The matrix has the form
$$
H=
\begin{pmatrix}
0&\alpha&0&0&\varepsilon\\
\overline\alpha&0&\beta&0&0\\
0&\overline\beta&0&\gamma&0\\
0&0&\overline\gamma&0&\delta\\
\overline\varepsilon&0&0&\overline\delta&0
\end{pmatrix},
\qquad
|\beta|\leq|\alpha|,|\gamma|.
\tag{5.1}
$$
All five entries may be complex. No simultaneous choice of their phases is required.

We first assume $I+H\succ0$. Let $P$ be the leading $4\times4$ path matrix, and set
$$
x=|\alpha|^2,\quad y=|\beta|^2,\quad z=|\gamma|^2,
\quad q=\alpha\beta\gamma.
$$
Define
$$
k=(1-x)(1-z),\quad D=k-y,\quad
u=\sqrt{xzk},\quad L=1+u.
\tag{5.2}
$$
Positivity of the $2\times2$, $3\times3$, and $4\times4$ principal submatrices gives
$$
0\leq x,y,z<1,\qquad
x+y<1,\quad y+z<1,\quad D>0.
\tag{5.3}
$$
Together with the local-minimum assumption, these imply
$0\leq y\leq\min(x,z,k)$.

Let
$$
J=\operatorname{diag}(1,-1,1,-1).
$$
Because $P$ is supported on a path,
$$
I-P=J(I+P)J\succ0.
$$
Consequently
$$
LI-P=(I-P)+uI\succ0.
\tag{5.4}
$$
Its determinant is
$$
D_L=L^4-(x+y+z)L^2+xz>0.
\tag{5.5}
$$

### 5.1. Endpoint inverse blocks

Let $B$ and $C$ be the submatrices on the first and fourth coordinates of $(I+P)^{-1}$ and $(LI-P)^{-1}$, respectively. Cofactor expansion gives
$$
B=
\frac1D
\begin{pmatrix}
1-y-z&-q\\
-\overline q&1-x-y
\end{pmatrix},
\tag{5.6}
$$
and
$$
C=
\frac1{D_L}
\begin{pmatrix}
L(L^2-y-z)&q\\
\overline q&L(L^2-x-y)
\end{pmatrix}.
\tag{5.7}
$$
We will prove
$$
M:=LB-C\succeq0.
\tag{5.8}
$$

Both diagonal entries of $M$ are nonnegative. For the first, clearing the positive denominator $DD_L$ gives
$$
\begin{aligned}
DD_L M_{11}
&=
L\bigl[(1-y-z)D_L-(L^2-y-z)D\bigr]\\
&=
L(L^2-1)
\bigl[(L^2-y-z)(1-y-z)+xy\bigr]
\geq0.
\end{aligned}
\tag{5.9}
$$
The second is obtained by exchanging $x$ and $z$.

For completeness, the determinant computation can be checked entirely by the following polynomial identity. Put
$$
U=(1-y-z)D_L-(L^2-y-z)D,
$$
$$
W=(1-x-y)D_L-(L^2-x-y)D.
$$
Then
$$
L^2UW-xyz(LD_L+D)^2=(L+1)^2DD_L\,N,
\tag{5.10}
$$
where
$$
N=
u^2\left[(1-y)u(u+2)+(1-y)^2+y(x+z)\right]-xyz.
\tag{5.11}
$$
The identity uses only $L=1+u$. Since $|q|^2=xyz$, it follows that
$$
\det M=\frac{(L+1)^2N}{DD_L}.
\tag{5.12}
$$
Using $u^2=xzk$, equation (5.11) becomes
$$
N=xz\,F(y).
$$
Lemma 4.1 therefore gives $\det M\geq0$. A Hermitian $2\times2$ matrix with nonnegative diagonal entries and nonnegative determinant is positive semidefinite. This proves (5.8), including the case $u=0$.

### 5.2. The two Schur complements

Write $w=(\varepsilon,\delta)^T$; its entries may have arbitrary complex phases. Since the fifth vertex couples only to the endpoints of the path, the Schur complement of $I+P$ in $I+H$ gives
$$
w^*Bw\leq1.
\tag{5.13}
$$
Equation (5.8) now yields
$$
w^*Cw\leq Lw^*Bw\leq L.
\tag{5.14}
$$
By (5.4), the leading block $LI-P$ is positive definite. Taking its Schur complement in $LI-H$, equation (5.14) is precisely
$$
LI-H\succeq0.
$$
This proves (3.2) under the positive-definite assumption.

These Schur-complement steps use the elementary identity, valid for $K\succ0$,
$$
\begin{aligned}
\begin{pmatrix}v\\t\end{pmatrix}^{\!*}
\begin{pmatrix}K&r\\r^*&s\end{pmatrix}
\begin{pmatrix}v\\t\end{pmatrix}
&=
(v+K^{-1}rt)^*K(v+K^{-1}rt)\\
&\quad +(s-r^*K^{-1}r)|t|^2.
\end{aligned}
\tag{5.15}
$$
Thus the argument is valid over $\mathbb C$, without any restriction on the phase around the cycle.

### 5.3. All semidefinite and zero-overlap boundaries

For a general $I+H\succeq0$, choose $0<t<1$. Then
$$
I+tH=(1-t)I+t(I+H)\succ0.
$$
Multiplication of every edge magnitude by $t$ preserves the local-minimum condition. The result already proved gives
$$
tH\preceq
\left[
1+t^2\sqrt{xz(1-t^2x)(1-t^2z)}
\right]I.
\tag{5.16}
$$
The radicands are nonnegative because $x,z\leq1$. Letting $t$ increase to one proves (3.2): for each vector, the corresponding quadratic-form inequality passes to the limit by continuity. This includes singular Gram matrices, zero edges, unit-modulus overlaps, and the case where the desired right-hand side above one vanishes. No inverse at a singular endpoint is used. Finally, choose a globally smallest edge to obtain (3.3). $\square$

## 6. From the Gram matrix to the pentagon theorem

Let $V$ be the matrix with columns $v_0,\ldots,v_4$. Then
$$
\sum_iP_i=VV^*,\qquad G=V^*V\succeq0.
$$
The diagonal of $G$ is one, and cyclic exclusivity makes its entries at $(i,i+1)$ zero.

Reorder the columns in the order
$$
(0,2,4,1,3).
\tag{6.1}
$$
In this order the Gram matrix is $I+H$, where $H$ is supported on a five-cycle. The five edge labels, expressed as original chord indices $i$ for the pair $(i,i+2)$, are
$$
(0,2,4,1,3).
\tag{6.2}
$$
Two disjoint edges of this cycle are exactly two crossing chords of the original pentagon. Therefore the maximum in (3.3) equals the right-hand side of (2.4), by Lemma 2.1.

The positive eigenvalues of $VV^*$ and $V^*V$ coincide. One can see this directly: for an eigenvector of $V^*V$ with eigenvalue $\lambda>0$, multiplication by $V$ gives a nonzero eigenvector of $VV^*$ with the same eigenvalue, and conversely by $V^*$. Since $G$ has trace five, its largest eigenvalue is positive. Hence
$$
\lambda_{\max}\!\left(\sum_iP_i\right)
=\lambda_{\max}(G)
=1+\lambda_{\max}(H).
$$
Combining this identity with (3.3) proves Theorem 2.2. The bound for every state follows from the variational characterization of the largest eigenvalue. $\square$

The argument also retains the stronger local conclusion. In the ordering (6.1), any edge whose overlap magnitude is no greater than both neighboring edge magnitudes selects the two flanking edges. Their single score product bounds the violation, without taking the maximum over all five crossing pairs.

## 7. Exact attainment

Let
$$
r=\frac{\sqrt5-1}{2},\qquad s=\sqrt r.
$$
The identities $r^2+r=1$ and $r^3=2r-1$ will be used repeatedly. In $\mathbb R^3\subset\mathbb C^3$, define
$$
\begin{aligned}
v_0&=(1,0,0)^T,&
v_1&=(0,0,1)^T,\\
v_2&=(r,s,0)^T,&
v_3&=(r,-rs,r)^T,\\
v_4&=(0,s,r)^T.
\end{aligned}
\tag{7.1}
$$
Each vector has norm one. For $v_3$, this follows from
$2r^2+r^3=1$; the other norm identities use $r^2+r=1$.
Successive vectors are orthogonal, and every chord overlap is $r$.

In the order (6.1), the Gram matrix is
$$
G=I+rA(C_5),
$$
where $A(C_5)$ is the ordinary adjacency matrix of the five-cycle. All row sums equal $1+2r=\sqrt5$, so the all-ones vector is an eigenvector with this eigenvalue. It is also the largest eigenvalue: since the entries of $G$ are nonnegative and symmetric, for every complex vector $c$,
$$
c^*Gc
\leq\sum_{i,j}G_{ij}|c_i||c_j|
\leq\frac12\sum_{i,j}G_{ij}(|c_i|^2+|c_j|^2)
=\sqrt5\,\|c\|^2.
$$
Thus the maximal violation is $\sqrt5-2=r^3$.

All chord scores have square
$$
r^2(1-r^2)=r^3=\sqrt5-2.
$$
Every crossing-pair product therefore equals the violation, proving exact attainment of (2.4) and of the local bound (3.2). An input state attaining the violation is the normalized sum of the five vectors:
$$
\psi=\frac{\sum_i v_i}{\sqrt{5\sqrt5}}.
$$
The Gram row-sum identity verifies both its normalization and
$(\sum_iP_i)\psi=\sqrt5\,\psi$.

Appending zero coordinates gives equality examples in every dimension $d\geq3$. This construction establishes sharpness; no uniqueness classification of equality cases is claimed.

## 8. What the result establishes

The overlap-dependent estimate in Theorem 2.2 is valid for all finite-dimensional complex rank-one realizations with exact cyclic orthogonality. Its coefficient is sharp, and Theorem 3.1 strengthens the maximum bound to a bound from a selected local crossing pair. The proof explains why a three-dimensional parametrization is unnecessary: the relevant comparison takes place in two endpoint blocks of a four-vertex path.

For higher ranks the Gram edges are matrices. Sections 9–10 prove results that use information on either the full principal spectrum of a single chord or all three matrices along a path. Throughout, neighboring projectors remain orthogonal.

## 9. Higher-rank pentagons with five isoclinic chords

Let each projection have equal finite positive rank $r$. Suppose for every nonadjacent pair, its $r$ principal angles are equal, allowing different values on different pairs. In the five-cycle of allowed Gram overlaps, each block then has the form $s_{ij}U_{ij}$ with $0\le s_{ij}\le1$ and $U_{ij}$ unitary, choosing an arbitrary unitary on a zero block. Choose a path through all five vertices. Successive unitary basis changes make the four unitaries on the path the identity. One common unitary basis change at all vertices diagonalizes the remaining unitary. The Gram matrix splits as a direct sum of $r$ scalar Grams, each with the original chord magnitudes. The corresponding ranges are orthogonal across summands because all off-sector inner products vanish. The rank-one bound therefore applies on each summand. The commutator norm for an isoclinic chord is $s_{ij}\sqrt{1-s_{ij}^2}$ on the full space. Taking maxima over orthogonal summands proves the crossing-product bound for this class, including $s_{ij}=0,1$. The next section allows chords with multiple different principal angles.

## 10. Sharp operator completion bounds

Write the Gram matrix of the five exclusive projection ranges in chord-cycle order as $I+H$, with zero diagonal blocks in $H$ and consecutive blocks $A,B,C,D,E$ on its five-cycle. Each vertex has its own range coefficient space, of arbitrary finite dimension. This description is exact: the unit diagonal blocks give isometries $V_i$ upon Gram factorization, adjacency exclusions give orthogonal ranges in the original order, and when the total rank is positive, $\|\sum P_i\|=1+\lambda_{\max}(H)$. If all five projectors vanish the upper claims hold directly. Conversely every such positive Gram matrix is realized, possibly after enlarging the ambient space.

### 10.1. Sharp one-chord envelope for arbitrary ranks

Prescribe the two ranks and all singular values $b\in[0,1]$ of one overlap $B=V_2^*V_3$. Over all realizations of that pair and all choices of the other three projectors and ambient space, the exact maximum of $\lambda_{\max}(\sum_iP_i)$ equals
$$
 2+\max_{b\in{\mathrm{sv}}(B)} u(b),\qquad
 u(b)=\frac{\sqrt{(1-b)^2+4b(1-b)/(1+b)}-(1-b)}2 .
$$
Include zero when one side has unpaired dimensions, using $u(0)=u(1)=0$. Take the maximum with zero if the lists are empty. The value is attained. Thus a single noncommuting chord has a dimension-independent sharp curve, from commutation at the endpoints to the unrestricted maximum at the regular pentagon. No common principal-vector basis across different chords is assumed.

### 10.2. Exact three-chord completion test

Fix *arbitrary matrices* $A,B,C$ for a realizable four-vertex path $P=H|_{1,2,3,4}$. Let $J$ embed the two endpoint coefficient spaces into this path. For any $L>1$, write
$$
 C_L=J^*(LI-P)^{-1}J,\quad B_1=J^*(I+P)^+J,\quad
 \mathcal D=\{z:Jz\in {\mathrm{ran}}(I+P)\}.
$$
Then *every* completion satisfies $\lambda_{\max}(\sum P_i)\le1+L$ iff $C_L|_{\mathcal D}\preceq L B_1|_{\mathcal D}$ as quadratic forms. Any violation of this endpoint test is witnessed by a fifth projector of rank one. Indeed $\|P\|\le1$ by bipartite sign symmetry and $I+P\succeq0$. For one new column $Jz$, positivity of the completed Gram is exactly $z\in\mathcal D,\ z^*B_1z\le1$, by completing the square on the support of $I+P$. Positivity of $LI-H$ is exactly $z^*C_Lz\le L$. Scaling any failing vector proves sharpness. An arbitrary block column maps every unit vector to such a feasible $z$; the second positive block criterion is again precisely the bound on all those vectors. The case $\mathcal D=0$ allows only zero couplings. This finite test does not substitute endpoint compression for the commutator norms of the two unprescribed chords.

### 10.3. Proof and attainment of the envelope

First take a strictly positive path Gram. Regroup endpoints versus interior vertices. The endpoint-to-interior block is $T=\mathrm{diag}(A,C^*)$. Set $Q=\left(\begin{smallmatrix}0&B\\B^*&0\end{smallmatrix}\right)$. By the two interior Schur complements,
$$
 B_1^{-1}=I-T(I+Q)^{-1}T^*,\qquad C_L^{-1}=LI-T(LI-Q)^{-1}T^* .
$$
Inverting the endpoint test, and subtracting, shows that it is equivalent to
$$
 T\,\frac{Q}{(I+Q)(LI-Q)}\,T^*\preceq (L-1)I. \tag{1}
$$
The factor $L+1$ cancels. Let $B=U b V^*$ denote a thin positive singular decomposition on its nonzero singular directions, with $b$ now diagonal. The positive spectral space of $Q$ has isometry $W=(U,V)^T/\sqrt2$. Discarding the negative spectral part gives an upper bound in (1). The four-path positivity, after eliminating the endpoints, implies
$$
 \begin{pmatrix} I-A^*A&B\\B^*&I-CC^*\end{pmatrix}\succeq0 .
$$
Test this matrix on $(U v,-Vv)$. It follows that $W^*T^*TW\preceq I-b$. Thus the operator norm of the retained positive term is bounded by
$$
 \max_{b\in{\mathrm{sv}}(B)} \frac{b(1-b)}{(1+b)(L-b)}.
$$
Taking $L>1+\max_b u(b)$ verifies (1). For possibly singular path Grams multiply *all* off-diagonal Gram blocks by $0<t<1$. This gives a positive definite Gram and middle singular values $tb$. The full spectral bound passes to $t\uparrow1$ by continuity, including unit overlaps.

For attainment at $0<b<1$, choose scalar edge magnitudes in cyclic order
$$
 a,\ b,\ a,\ w,\ w,\qquad a=\sqrt{1-b},\quad w=\sqrt{b/(1+b)},
$$
with positive entries. On the antisymmetric pair of endpoint/interior coordinates the path part of $I+H$ is $\left(\begin{smallmatrix}1&a\\a&1-b\end{smallmatrix}\right)\succeq0$. On the symmetric endpoint/interior/fifth coordinates the Gram is $\left(\begin{smallmatrix}1&a&\sqrt2w\\a&1+b&0\\\sqrt2w&0&1\end{smallmatrix}\right)\succeq0$ since $a^2/(1+b)+2w^2=1$. On that latter sector, the characteristic polynomial of $H$ equals $(L+1)[(L-1)(L-b)-b(1-b)/(1+b)]$ in variable $L$. The large root is $1+u(b)$. This scalar qutrit Gram has rank three; at $b=0,1$ the explicit entries still give the claimed value by continuity. Form the orthogonal sum of these realizations for all singular directions and add unpaired directions separately (with their original projection fixed, other free projectors may be zero there). This realizes the prescribed rectangular $B$ up to its two harmless changes of basis. A free orthogonal coinciding non-neighboring pair may attain value two if the prescribed pair is void. In particular the lower construction and the operator upper cover arbitrary prescribed multiplicities.

### 10.4. Wu's crossing product on an irreducible sector

Suppose the three consecutive path edges $A,B,C$ admit bases in which the path is an orthogonal sum of scalar paths, with central magnitudes $b_j\le\min(a_j,c_j)$ on every string (zeros may pad). The two return edges from the fifth vertex are completely arbitrary and may mix all these scalar sectors. Nevertheless Wu's claimed bound holds, indeed the single product $\|[P_1,P_2]\|\,\|[P_3,P_4]\|$ in chord-cycle order suffices. To see this, the rank-one path theorem of §3 gives its scalar endpoint test for each string with $L_j=1+a_j\sqrt{1-a_j^2}\,c_j\sqrt{1-c_j^2}$. For any $L>\max_j L_j$, the left resolvent decreases and the right side increases; combine the scalar tests in direct sum, then apply the arbitrary-rank completion theorem. For singular strings one can instead scale the whole Gram and take the limit. The norm of a chord commutator is the maximum of $s\sqrt{1-s^2}$ over its principal overlaps $s$ (Jordan's two-projection form). Taking the separate maxima yields the assertion. In particular two disjoint isoclinic outer chords and an arbitrary intervening overlap of norm at most either outer magnitude suffice: fix the middle's singular bases, then absorb the outer unitaries independently at the two path endpoints. This criterion imposes no decomposition on the full pentagon.

For an explicit irreducible rank-two example and sharpness sequence, let $s_*=(\sqrt5-1)/2$, $s=s_*-\varepsilon$ for $0<\varepsilon<1/50$, and $\delta=\varepsilon/10$. Use on the path $A=C=\mathrm{diag}(s,s-\delta),\ B=\mathrm{diag}(s-2\delta,s-3\delta)$. Use $D=sI_2$ and $E=sI_2+\delta\left(\begin{smallmatrix}0&1\\1&0\end{smallmatrix}\right)$. The base Gram with all edges $sI_2$ has least eigenvalue $1-s/s_*=\varepsilon/s_*$; the perturbation norm is at most $6\delta$ by block row sums. The Gram stays positive definite, and the top eigenvalue is at least $1+2s-6\delta>2$. On the full ten-dimensional Gram span a commuting orthogonal projection restricts via each $V_i$ to a projection $D_i$, satisfying $D_i H_{ij}=H_{ij}D_j$ and its adjoint. The unequal nonsingular diagonal path edges force their incident projections diagonal and equal; the scalar return identifies the fifth with them. The other return's nonzero off-diagonal entries force both diagonal values equal. Only trivial projections remain, hence the pentagon is irreducible. Taking $\varepsilon\downarrow0$ makes the violation-to-Wu-bound ratio tend to one by $s_*^2(1-s_*^2)=\sqrt5-2$. No smaller uniform coefficient works even in this irreducible unequal-angle family.

## 11. Prior results and scope

Wu's Theorem 10 gives the rank-one qutrit crossing bound, and the text immediately after Conjecture 2 extends the qutrit result to their orthogonal direct sums. Proposition 3(b) proves that a commuting chord rules out violation at arbitrary ranks. This is the $u(0)=u(1)=0$ case of the one-chord envelope when all prescribed singular values are 0 or 1. The earlier scalar geometry of Badziąg et al. §2, equations (7)–(9), already implies the same sharp envelope at rank one. In their notation, after fixing $x=1-b^2$, the relevant deficit of the sum of squared overlaps is $x(1-x)y(1-y)/(1-xy)$. Maximizing in $y$ gives $y=1/(1+b)$ and deficit $b^2(1-b)/(1+b)$. Their characteristic equation then yields the scalar value $2+u(b)$. The proof above establishes its sharp operator extension, including any prescribed singular spectrum. [Wu, Theorem 10, Proposition 3(b) and Conjecture 2](https://arxiv.org/html/2611.24604v1) · [Badziąg et al., §2, equations (7)–(9)](https://doi.org/10.1007/s10701-010-9433-3)

The three-matrix completion criterion refers to arbitrary specified path blocks and gives a rank-one fifth-projector witness whenever the test fails. The crossing-product theorem for paths consisting of scalar sectors still allows the return edges to mix these sectors. The explicit rank-two example is irreducible on the span of the ranges, has nonconstant principal overlaps, and attains the sharp uniform coefficient as a limit. The full crossing-product conjecture for configurations with incompatible principal bases on all paths remains open.

The original independent symbolic verifiers reproduce the scalar identities, complex Schur blocks, and the equality pentagon. The operator-valued conclusions use the Schur-complement proofs and explicit Grams above. Lean verification is delivered separately. [Original reproduction guide](evidence/README.md)

## Appendix. Approximate exclusivity at rank one

### Theorem S1: an explicit bound for imperfect exclusivity

Let $v_0,\ldots,v_4$ be unit vectors in any finite-dimensional complex Hilbert
space. Put $P_i=v_iv_i^*$, $G_{ij}=\langle v_i,v_j\rangle$, and let $E$
be the Hermitian matrix which agrees with $G$ exactly at neighboring cyclic
positions $(i,i+1)$ and $(i+1,i)$, and is zero elsewhere. Choose
$\delta\geq\|E\|$, put $t=(1+\delta)^{-1}$, and write
$a_i=|\langle v_i,v_{i+2}\rangle|$. Then

$$
\lambda_{\max}\!\left(\sum_iP_i\right)-2
\leq 2\delta+(1+\delta)
\max_i \left[t a_i\sqrt{1-t^2a_i^2}\right]
           \left[t a_{i+1}\sqrt{1-t^2a_{i+1}^2}\right].
\tag{S1}
$$

The same upper bound holds for $\operatorname{Tr}(\rho\sum_iP_i)-2$ for every
density matrix $\rho$. In particular, if
$|\langle v_i,v_{i+1}\rangle|\leq\varepsilon$, one may use
$\delta=2\varepsilon$. At $\varepsilon=0$, formula (S1) reduces to the
rank-one theorem in §2. No real-vector or nonsingular-Gram assumption is imposed.
When $\varepsilon>0$, the left-hand side is a spectral excess above two and does not by itself certify an experimental violation of the standard exact-exclusive KCBS noncontextual inequality.

**Proof.** The matrix
$$
G_0=\frac{G-E+\delta I}{1+\delta}
$$
is positive semidefinite because $G\succeq0$ and $\delta I-E\succeq0$.
Its diagonal is one and its neighboring entries vanish. It is therefore the
Gram matrix of five unit vectors with exact cyclic exclusivity. Its chord
magnitudes are $t a_i$. Apply Theorem 2.2 of the rank-one part of this paper to this
Gram matrix. Since
$$
G=(1+\delta)G_0+E-\delta I\preceq(1+\delta)G_0,
$$
the variational characterization of the largest eigenvalue gives (S1).
The nonzero eigenvalues of the Gram matrix and the sum of projectors agree.
For any $z\in\mathbb C^5$,
$$
|z^*Ez|\leq 2\varepsilon\sum_i|z_i||z_{i+1}|
\leq 2\varepsilon\sum_i|z_i|^2,
$$
where each index occurs twice in the last sum of pairwise inequalities.
Thus $\|E\|\leq2\varepsilon$. The state bound follows from its unit trace.
This proof uses no inverse or limit at a singular matrix. $\square$

The stronger local conclusion of the rank-one theorem in §3 transfers as well: after
ordering the nonneighboring Gram entries as the five-cycle, any locally smallest
chord magnitude selects its two flanking edges. Replace the maximum in (S1) by
that selected product. Uniform scaling by $t$ preserves the comparisons used
to select it. This is a rule about overlap magnitudes, not about their possibly
nonmonotone commutator scores.

### Theorem S2: a linear additive obstruction is necessary

For every $0<\varepsilon<1$, there are five rank-one projectors in
$\mathbb C^3$ for which every neighboring overlap has magnitude at most
$\varepsilon$, every crossing product
$\|[P_i,P_{i+2}]\|\,\|[P_{i+1},P_{i+3}]\|$ is zero, but
$$
\lambda_{\max}\!\left(\sum_iP_i\right)-2=2\varepsilon.
\tag{S2}
$$
Consequently an error term depending only on $\varepsilon$, added to the
unmodified crossing-product bound, cannot be $o(\varepsilon)$ uniformly.

**Proof.** In an orthonormal basis $e_1,e_2,e_3$, set
$$
v_0=v_2=e_1,\quad
v_1=v_3=w=\varepsilon e_1+\sqrt{1-\varepsilon^2}\,e_2,
\quad v_4=e_3.
$$
The five neighboring overlap magnitudes are
$(\varepsilon,\varepsilon,\varepsilon,0,0)$. Chord projectors 0 and 2
coincide, as do 1 and 3; chords 2--4 and 4--1 are orthogonal. Thus only the
3--0 chord can have a nonzero commutator, so every product of consecutive chord
scores is zero. The sum is $2P_{e_1}+2P_w+P_{e_3}$. The first two terms
have eigenvalues $2(1+\varepsilon)$ and $2(1-\varepsilon)$ on their
two-dimensional span; the third eigenvalue is one. This proves (S2), and zero
padding extends the example to all dimensions at least three. $\square$

## References

1. A. A. Klyachko, M. A. Can, S. Binicioğlu, and A. S. Shumovsky, “Simple Test for Hidden Variables in Spin-1 Systems,” *Physical Review Letters* **101**, 020403 (2008). DOI: [10.1103/PhysRevLett.101.020403](https://doi.org/10.1103/PhysRevLett.101.020403). Preprint: [arXiv:0706.0126](https://arxiv.org/abs/0706.0126).
2. S. Wu, “Measurement-order dependence bounds uncertainty, contextuality, steering, and Bell nonlocality,” [arXiv:2611.24604v1](https://arxiv.org/abs/2611.24604v1) (18 November 2026), particularly Theorem 1, §VI.2, Theorem 10, and Conjecture 2. [Full text](https://arxiv.org/html/2611.24604v1).
3. A. C. Günhan and Z. Gedik, “Information-Theoretic and Operational Measures of Quantum Contextuality,” *Journal of Physics A: Mathematical and Theoretical* **59**, 195302 (2026). DOI: [10.1088/1751-8121/ae67c0](https://doi.org/10.1088/1751-8121/ae67c0). Preprint: [arXiv:2512.11049v2](https://arxiv.org/html/2512.11049v2). This related work studies a different, state-dependent commutator quantity; it is not used in the proof above.
4. P. Badziąg, I. Bengtsson, A. Cabello, H. Granström, and J.-Å. Larsson, “Pentagrams and paradoxes,” *Foundations of Physics* **41**, 41–55 (2011), especially §2, equations (7)–(9). [DOI](https://doi.org/10.1007/s10701-010-9433-3) · [arXiv:0909.4713](https://arxiv.org/abs/0909.4713).
