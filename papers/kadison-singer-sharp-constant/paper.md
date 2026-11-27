# Matrix discrepancy on two-dimensional subspaces and sharp variance-profile bounds

## Abstract

We prove an anisotropic determinant comparison for paired rank-one differential operators. If a Hermitian background lies above a positive definite probe's inverse plus a linear covariance term, the resulting polynomial is positive and its logarithmic matrix gradient is bounded by the probe. Both statements hold on the closed matrix inequality. The proof uses a sharp contraction inequality derived from mixed Hodge–Riemann relations and a Schur expansion that allows the update planes to overlap. Interlacing then yields a choice from the original supports of independent finite Hermitian laws. Each law varies by Hermitian operators supported on a fixed complex subspace of dimension at most two, and its support differences satisfy a determinant condition. For rectangular rank-one coefficients and arbitrary independent finite complex scalar laws, this gives a weighted spectral-norm bound and a comparison with a circular operator with the same scalar variances. With prescribed, possibly asymmetric row- and column-type variance caps, the variational bound is exactly the worst-case supremum. Finite real fair-sign examples on weighted bipartite trees approach it.

## Plain-language summary

Suppose independent random choices each produce a matrix from a finite list. Can we pick one matrix from each list so that their sum is close to the sum of the means? For the Hermitian result, the difference between any two values of a given choice acts on a fixed complex subspace of dimension at most two and vanishes on its orthogonal complement. Each list may contain several distinct matrices. On a two-dimensional subspace, every pairwise difference must have nonpositive determinant when restricted to that subspace.

For rectangular contributions that are scalar multiples of fixed rank-one matrices, the bound uses how variance is distributed across row and column types. When the available information is a table of variance caps, the best universal bound is the infimum of an explicit function of one positive number per type. That bound applies to every finite instance, and finite tree examples can come as close to it as desired.

## 1. Matrix comparison

### Notation and reading guide

All matrix spaces in §§1–4 are finite dimensional over $\mathbb C$. The notation $X\succeq Y$ means $X-Y$ is positive semidefinite, and $X\succ Y$ means it is positive definite. We use $\|\cdot\|$ for the operator norm, $\lambda_{\max}$ for the largest Hermitian eigenvalue, and $X^*$ for the adjoint. An empty determinant equals one. The positivity and order assertions for gradients on the zero space are vacuous. Largest-eigenvalue statements use nonzero spaces unless an empty block is explicitly allowed. An identity $I$ acts on the space specified by its argument or block.

For the selection and profile statements, readers need only the trace pairing, positive semidefinite order, the Schur complement, and the variational characterization of the largest eigenvalue. Section 2 states the needed consequence of mixed Hodge–Riemann relations and translates it into derivatives of determinants. Section 3 isolates a single row and column of the matrix and applies that inequality to the terms involving the off-diagonal block. Section 4 passes from the expected characteristic polynomial to an original support point. Section 5 obtains the rectangular bound by Hermitian dilation and explains its circular norm through the adjacency operator of a tree. Section 6 uses a related tree to prove sharpness of each variance profile.

### Statement

Let $W$ be a finite-dimensional complex Hilbert space. We write $D_H$ for differentiation in the matrix direction $H$ and use the trace pairing $D_H f=\operatorname{tr}((\nabla f)H)$. Derivatives on Hermitian matrices extend complex linearly to all matrices. For arbitrary vectors $l_i,r_i\in W$, put $L_i=l_i l_i^*$ and $R_i=r_i r_i^*$. Given $w_i\geq0$, define

$$
p(A)=\prod_i(1-w_iD_{L_i}D_{R_i})\det A,\qquad
\mathcal K(G)=\sum_i w_i\big[(r_i^*G r_i)L_i+(l_i^*G l_i)R_i
 -(l_i^*G r_i)l_i r_i^*-(r_i^*G l_i)r_i l_i^*\big].
$$

The two vectors of a pair can be dependent, and the planes of different pairs can overlap. Writing $\alpha_i=u^*l_i$ and $\delta_i=u^*r_i$ gives

$$
u^*\mathcal K(G)u
=\sum_i w_i(\alpha_i r_i-\delta_i l_i)^*G(\alpha_i r_i-\delta_i l_i).
\tag{1}
$$

**Matrix comparison.** For every $G\succ0$ and every Hermitian $A$ satisfying

$$
A\succeq G^{-1}+\mathcal K(G),
$$

we have $p(A)>0$ and $0\prec\nabla\log p(A)\preceq G$ in positive dimension. Both conclusions hold on the stated closed matrix inequality. In particular they do not require $A$ to be scalar.

The probe $G$ can distinguish directions of the background $A$. Section 3 proves the comparison using the contraction inequality in §2.

## 2. A sharp contraction inequality for derivatives of a mixed determinant

On $N$-dimensional complex space take positive semidefinite directions $T_1,\ldots,T_k$, with $h=D_{T_1}\cdots D_{T_k}\det$ nonzero and of degree $D=N-k\geq3$. Let $X$ belong to the open hyperbolicity cone of $h$ containing the identity. Put $H=\nabla h(X)$. In any orthonormal basis, for arbitrary complex matrices $M_b$, set

$$
v=\sum_b(D_{M_b}H)e_b,\qquad
S=\sum_{a,b}e_a^* (D_{M_a^*}D_{M_b}H)e_b.
$$

Here and below derivatives of a gradient are taken before evaluation. Then

$$
H\succeq0,\qquad v\in\operatorname{ran}H,\qquad
S\leq\frac{D-2}{D-1}\,v^*H^\dagger v ,
\tag{2}
$$

where $H^\dagger$ is the Moore–Penrose inverse. The factor is optimal, including for the determinant itself.

### Proof of the derivative contraction

The open hyperbolicity cone is the component of $\{X\colon h(X)>0\}$ containing the identity. The differentiated determinant is hyperbolic in the identity direction, and the cone contains all positive definite matrices. Its closure contains all positive semidefinite matrices. The polarization used here is the symmetric multilinear form associated with the homogeneous polynomial $h$.

To see the range assertion, let $Y$ vary over the same open cone. Mixed hyperbolic polarizations are nonnegative on its closure, which contains the positive semidefinite directions. Consequently $\nabla h(Y)\succeq0$. If $z\in\ker H$, choose $\epsilon>0$ with $X-\epsilon Y$ in the cone. Multilinearity and positivity give $0=D_{zz^*} h(X)\geq\epsilon^{D-1}D_{zz^*}h(Y)$. Thus $z^*\nabla h(Y)=0$ throughout the cone. Differentiation and complex linearity imply $z^*v=0$.

We use exterior forms to package the remaining derivatives. Write $\omega_M=i\sum M_{ab}dz_a\wedge d\bar z_b$, $\Theta=\prod_j\omega_{T_j}$ and $\Omega=\Theta\,\omega_X^{D-3}$. Products here are exterior products. Brackets denote the coefficient against the volume $\prod_a i\,dz_a\wedge d\bar z_a$. The nonzero polynomial $h$ satisfies $h(X)=[\Theta\omega_X^D]/D!$, so its cone is the cone of $\Theta$. Li's Theorem 3.1 and Corollary 3.5 for products of semipositive forms give

$$
\gamma\Omega\omega_X=0,\quad \gamma\in\Lambda^{2,1}
\quad\Longrightarrow\quad [i\gamma\bar\gamma\Omega]\leq0.
$$

Indeed the primitive pairing in Li's convention is $-[i\gamma\bar\gamma\Omega]$ and is positive definite on the quotient by the annihilator of $\Theta$. This gives the indicated weak sign on all forms, even when some $T_j$ is singular. [Li, Theorem 3.1, Corollary 3.5 and equation (2.12)](https://arxiv.org/pdf/2611.03124v6)

For $\beta=\sum_b dz_b\wedge\omega_{M_b}$ and $\alpha_z=\sum_b z_b dz_b$, exterior multiplication and differentiation of $h$ give

$$
\begin{aligned}
[i\beta\bar\beta\Omega]&=(D-3)!S,\\
[i\beta\bar\alpha_z\Omega\omega_X]&=(D-2)!\,z^*v,\\
[i\alpha_z\bar\alpha_z\Omega\omega_X^2]&=(D-1)!\,z^*Hz .
\end{aligned}
\tag{3}
$$

For example the first expansion uses $\omega_{E_{ba}}\omega_{M_b}\omega_{M_a^*}$ and $D_{E_{ba}}h=H_{ab}$. Choose $c=H^\dagger v/(D-1)$. The second and polarized third identities show that $\beta-\omega_X\alpha_c$ pairs to zero against each $\omega_X\alpha_z$. Exterior duality makes it primitive, since the pairing with every $\alpha_z$ tests the entire exterior product $(\beta-\omega_X\alpha_c)\Omega\omega_X$. Expanding its nonpositive square gives
$$
(D-3)!\,S\leq (D-1)!\,c^*Hc
=\frac{(D-1)!}{(D-1)^2}\,v^*H^\dagger v,
$$
which is (2). For sharpness take $M_b=z_bX$ with $z^*Hz>0$. By homogeneity $v=(D-1)Hz$ and $S=(D-1)(D-2)z^*Hz$.

## 3. One Schur expansion for overlapping pairs

### Proof of the matrix comparison

We first prove the matrix comparison with $G=I$ by induction on $n=\dim W$. The empty determinant is one. In dimension one every paired second derivative is zero and $A\succeq I$ gives the assertion. For the induction step take $n\geq2$. For a unit vector $u$, write

$$
A=\begin{pmatrix}a&z^*\\ z&B\end{pmatrix},\quad
l_i=(\alpha_i,l'_i),\quad r_i=(\delta_i,r'_i)
$$

in $W=\mathbb Cu\oplus W'$. Let $q(B)$ be the polynomial for the projected pairs on $W'$ and $Q=\nabla q(B)$. Formula (1) shows that the variance matrix for the compressed data is bounded by the compression of $\mathcal K(I)$. In fact it replaces each $\alpha r_i-\delta l_i$ in a test direction in $W'$ by its orthogonal projection. Thus $B\succeq I+\mathcal K_{\rm comp}(I)$. Induction gives $q>0$ and $0\prec Q\preceq q I$.

Set $h_i=l'_i\bar\alpha_i$, $k_i=r'_i\bar\delta_i$, $L'_i=l'_i l_i'^*$ and $R'_i=r'_i r_i'^*$. Define

$$
\begin{aligned}
C&=\sum_i w_i\big(|\alpha_i|^2D_{R'_i}+|\delta_i|^2D_{L'_i}\big),\\
M_b&=\sum_i w_i\big((h_i)_b R'_i+(k_i)_b L'_i\big),\\
J&=\sum_i w_i(h_i k_i^*+k_i h_i^*).
\end{aligned}
$$

Form $v,S$ as in §2 with the gradient $Q$ and these physical matrices $M_b$. The exact cofactor identities are

$$
\begin{aligned}
p(A)&=a q-Cq+\operatorname{tr}(QJ)
        -z^*Qz+2\operatorname{Re}(z^*v)-S,\\
(\nabla p)_{00}&=q,\qquad (\nabla p)_{W',0}=v-Qz .
\end{aligned}
\tag{4}
$$

Here is a derivation which also fixes the complex conjugates. On the determinant the product defining $p$ equals $\exp(-\sum w_iD_{L_i}D_{R_i})$, since the square of each rank-one directional derivative kills the determinant and all its derivatives. Keep the lower column $z$ and the upper row $y^{\mathsf T}$ independent during differentiation. The undifferentiated determinant is $a\det B-y^{\mathsf T}\operatorname{adj}(B)z$. Each $D_{L_i}$ splits into $|\alpha_i|^2\partial_a+D_{L'_i}+h_i\cdot\partial_z+\bar h_i\cdot\partial_y$ and likewise for $r_i$. All operators commute. The pure $B$ part gives $a q-y^{\mathsf T}Qz$. The surviving $\partial_a$ term gives $-Cq$. The mixed $\partial_{y_a}\partial_{z_b}$ term gives $\sum_{ab}J_{ba}Q_{ab}$. The first derivatives in $z,y$ translate each $z_b$ by $-D_{M_b}$ and each $y_a$ by $-D_{M_a^*}$. Expanding this bilinear expression gives (4) upon setting $y=\bar z$. The products involving $\partial_a$ and another nonphysical derivative, or two derivatives on the same row or column, annihilate the initial polynomial. The identity for the gradient column follows by differentiating in the upper row.

The first two derivative terms combine into a single square. With $N_0=Q/q$,

$$
\frac{Cq-\operatorname{tr}(QJ)}q
=\sum_i w_i(\alpha_i r'_i-\delta_i l'_i)^*N_0(\alpha_i r'_i-\delta_i l'_i)
\leq u^*\mathcal K(I)u.
\tag{5}
$$

The displayed vector is the full vector of (1) with its zero $u$ coordinate removed. The estimate uses $0\preceq N_0\preceq I$.

For use of (2) lift the residual problem to $W'\oplus\mathbb C^k$, one auxiliary coordinate for each of the $k$ pairs. Use the positive semidefinite directions and shifted point

$$
T_i=\sqrt{w_i}(L'_i+R'_i)\oplus E_{ii},\qquad
X=\big(B-\sum_i\sqrt{w_i}(L'_i+R'_i)\big)\oplus I_k.
\tag{6}
$$

Let $h=\prod_iD_{T_i}\det$. Its degree is $d=\dim W'$. Then $h(X)=q(B)$ identically in $B$. Indeed the auxiliary factor $1+t_i$ for each derivative supplies the operator $(1+\sqrt{w_i}D)e^{-\sqrt{w_i}D}$, $D=D_{L'_i}+D_{R'_i}$. Acting on the determinant, $D^3=0$ and $D^2=2D_{L'_i}D_{R'_i}$, giving the required product. Along $B+tI$, $t\geq0$, the compressed induction hypothesis gives strict positivity. For large $t$ the point (6) is positive definite. This puts $X$ in the required hyperbolicity cone. The physical block of $\nabla h(X)$ is $Q$. Conjugation by separate scalar phases on the two blocks fixes the directions $T_i$ and each block-diagonal evaluation point. It forces the physical–auxiliary entries of the gradient to vanish identically along physical block variations. Extend the $M_b$ by zero on auxiliary coordinates and set $M_b=0$ for auxiliary indices. Formula (2) then reads $S\leq(d-2)v^*Q^{-1}v/(d-1)$ when $d\geq3$.

Take $u$ to be a largest-eigenvalue direction of $\nabla p(A)$, before division by $p$. By (4), $v=Qz$. For $d\geq3$ the last three terms of the first line of (4) have sum at least $z^*Qz/(d-1)$. For $d=1,2$, $S=0$ because it is a third derivative of a polynomial of degree $d$, and the sum is $z^*Qz$. It follows from (5) and $A\succeq I+\mathcal K(I)$ that $p(A)\geq q(a-u^*\mathcal K(I)u)\geq q>0$. The largest eigenvalue of $\nabla p(A)$ equals $q$, so $\nabla p(A)\preceq p(A)I$. For every unit direction the first cofactor in (4) equals a positive compressed polynomial, proving $\nabla p(A)\succ0$.

For general $G\succ0$ apply this result to $G^{1/2}AG^{1/2}$ and pairs $G^{1/2}l_i,G^{1/2}r_i$. Their variance matrix at $I$ is $G^{1/2}\mathcal K(G)G^{1/2}$, and their polynomial is $\det(G)p(A)$ at the transformed point by congruence and differentiation. If $p_G$ denotes the transformed polynomial, then the trace pairing gives
$$
G^{1/2}\nabla\log p_G(G^{1/2}AG^{1/2})G^{1/2}=\nabla\log p(A).
$$
Congruence sends the gradient bound for $p_G$ back to $0\prec\nabla\log p(A)\preceq G$. This proves §1.

## 4. Selection for finite Hermitian laws on planes

### Selection theorem

Suppose independent Hermitian variables $Y_i$ have finite supports contained in affine translates of the Hermitian operators on subspaces $W_i\subset W$ of dimension at most two. On each two-dimensional $W_i$ assume

$$
\det_{W_i}(Y-Y')\leq 0\quad\text{for every two support points }Y,Y'.
\tag{7}
$$

Write $P_i$ for the orthogonal projection onto $W_i$. If $\dim_{\mathbb C}W_i=2$, let $Q_i$ be the determinant on Hermitian operators restricted to $W_i$ and let $\widetilde Y_i$ be an independent copy of $Y_i$. Define
$$
\tau_i=-\mathbb E Q_i(Y_i-\mathbb EY_i)
      =-\tfrac12\mathbb E Q_i(Y_i-\widetilde Y_i)\geq0.
$$
Indeed $Q_i$ is a quadratic form on the real vector space of Hermitian operators on $W_i$. Independence and centering make its polarized cross term vanish in expectation, and (7) gives the sign. When $\dim_{\mathbb C}W_i$ is zero or one, define $\tau_i=0$. Put

$$
\mathcal K(G)=\sum_i\tau_i\big(\operatorname{tr}(P_iG)P_i-P_iGP_i\big).
\tag{8}
$$

This is §1 in an orthonormal basis of each plane, with $w_i=\tau_i$. For every $A\succeq G^{-1}+\mathcal K(G)$ for some $G\succ0$, there exist original support values $y_i$ such that

$$
A-\sum_i(y_i-\mathbb EY_i)\succ0.
\tag{9}
$$

In positive dimension, for an arbitrary deterministic Hermitian $H_0$, it follows that

$$
\min_{y_i\in\operatorname{supp}Y_i}
\lambda_{\max}\big(H_0+\sum_i(y_i-\mathbb EY_i)\big)
\ \leq\ \inf_{G\succ0}\lambda_{\max}\big(H_0+G^{-1}+\mathcal K(G)\big).
\tag{10}
$$

In positive dimension the value inside the infimum is a strict upper bound for each individual finite probe $G$, including at equality in the probe condition in (9). The optimized assertion in (10) uses a weak inequality and does not require an attaining probe.

### Proof of the selection theorem

On the zero space (9) is automatic. In positive dimension, for an orthonormal basis $l,r$ of a plane the quadratic term in $\det(X-H)$ for $H$ supported on that plane is $\det_{W_i}(H)D_{ll^*}D_{rr^*}\det X$. Expand in the two plane rows to obtain this identity even at singular $X$. After centering, the linear term averages to zero. If $\dim_{\mathbb C}W_i=1$, the centered update is $s uu^*$ for a fixed unit vector $u$ and a real scalar $s$ of mean zero. The determinant is affine in $s$ even at singular $X$, so averaging gives $\det X$. If $\dim_{\mathbb C}W_i=0$, the centered update is identically zero and gives the same expectation. Independence therefore expresses the expected polynomial as $p(A+tI)$ for the data in (8). It is monic and real-rooted for arbitrary Hermitian $A$ and nonnegative weights. Indeed (6) without compression has physical shift direction $e=I_W\oplus 0$ in the closed cone of $h$ and $h(e)=1$ by selecting all auxiliary coordinates. Thus $e$ is interior, since the boundary of the hyperbolicity cone lies in the zero set of $h$. Hyperbolicity in the direction $e$ gives real-rootedness of $h(X+te)$. Every $A+tI$ for $t\geq0$ satisfies the same matrix bound as $A$, so the largest root is strictly negative.

Any convex combination of children in the tree of partial assignments changes the next law on its actual support. Its new mean shifts the deterministic background. On a two-dimensional $W_i$, (7) still gives a nonnegative $\tau_i$. In dimensions zero and one the same constant or affine determinant calculation applies with the new mean. Thus all such combinations are real-rooted, with no variance bound needed after conditioning. The common-interlacing and selection lemmas of Marcus, Spielman and Srivastava give a leaf whose largest root is at most the parent's. A negative largest root means exactly (9). To get (10) use $A=tI-H_0$ with $t=\lambda_{\max}(H_0+G^{-1}+\mathcal K(G))$ for each probe. [Marcus–Spielman–Srivastava, §3](https://doi.org/10.4007/annals.2015.182.1.8)

### Reweighting criterion

For a single two-plane law, (7) is equivalent to real-rootedness of the expected centered characteristic polynomial under every reweighting of its support and every deterministic Hermitian background.

### Proof of the reweighting criterion

Sufficiency is the real-rootedness argument above. If one difference has positive determinant, reweight equally on its two points. On that plane the expected centered characteristic polynomial is $t^2+\det_{W_i}(Y-Y')/4$. The remaining space supplies a power of $t$ at zero background. There are nonreal roots.

### A three-dimensional affine example

A non-scalar example allowed by (7) is the uniform law on four traceless two-by-two Hermitian matrices $\sum_{j=1}^3 v_j\sigma_j$, where $\sigma_j$ are the Pauli matrices
$\left(\begin{smallmatrix}0&1\\1&0\end{smallmatrix}\right)$, $\left(\begin{smallmatrix}0&-i\\i&0\end{smallmatrix}\right)$, and $\left(\begin{smallmatrix}1&0\\0&-1\end{smallmatrix}\right)$, and the vectors $v$ are the four unit vectors with coordinates $(\pm1,\pm1,\pm1)/\sqrt3$ and sign product $+1$. Its differences are traceless, and its affine span has real dimension three. One complex scalar multiplier in a fixed Hermitian dilation has real affine span at most two.

## 5. Rectangular discrepancy and the circular operator

### Rectangular comparison

Let $D_i=l_i r_i^*:F\to E$, and let $\zeta_i$ be independent finitely supported complex scalars. Put $w_i=\mathbb E|\zeta_i-\mathbb E\zeta_i|^2$, $Z=\sum_i(\zeta_i-\mathbb E\zeta_i)D_i$, and define

$$
\Phi(V)=\sum_iw_iD_iVD_i^*,\qquad \Phi^*(U)=\sum_iw_iD_i^*UD_i .
$$

For positive definite probes $U$ on $E$ and $V$ on $F$, suppose the Hermitian matrices $A$ on $E$ and $B$ on $F$ satisfy

$$
A\succeq U^{-1}+\Phi(V),\qquad B\succeq V^{-1}+\Phi^*(U),\qquad U,V\succ0 ,
$$

Then some original support choice satisfies $\|A^{-1/2}ZB^{-1/2}\|<1$. Each requested pair $A,B$ has its own selection guarantee.

The unweighted norm in particular satisfies

$$
\min_{\rm supp}\|Z\|\leq
\inf_{U,V\succ0}\max\left\{
  \lambda_{\max}(U^{-1}+\Phi(V)),
  \lambda_{\max}(V^{-1}+\Phi^*(U))\right\}
=\left\|\sum_i\sqrt{w_i}D_i\otimes c_i\right\| .
\tag{11}
$$

Here the full Fock space is the Hilbert space with an orthonormal basis of all finite words, including the empty word. A left creation isometry $\ell_j$ adds the letter $j$ on the left. The circular operators used in (11) are $c_i=\ell_{i,1}+\ell_{i,2}^*$, with distinct letters for all $i$ and both indices. For an arbitrary complex scalar law the right side is a comparison operator built from the scalar variances $w_i$.

When one of $E,F$ is zero, $Z$ and both covariance maps are zero. In the maximum in (11) omit an empty block, and read the variational value as zero if both blocks are empty. If one block survives, its inverse-probe term tends to zero under scalar rescaling.

### Proof of the rectangular selection

The Hermitian dilation of $Z$ is the operator with off-diagonal blocks $Z,Z^*$ and zero diagonal blocks on $E\oplus F$. Each dilated update lies on the plane spanned by $(l_i,0),(0,r_i)$ and the determinant of a difference is $-|\zeta-\zeta'|^2\|l_i\|^2\|r_i\|^2$. We may discard zero coefficient matrices. For $G=U\oplus V$, the map in (8) is $\Phi(V)\oplus\Phi^*(U)$. Apply (9) with background $A\oplus B$. The resulting positive definite block matrix has off-diagonal blocks $-Z,-Z^*$, so its Schur complement gives $\|A^{-1/2}ZB^{-1/2}\|<1$. Choosing $A$ and $B$ to be $tI$ with $t$ the maximum in (11) proves $\min_{\rm supp}\|Z\| < t$ for each finite probe if at least one block survives. Taking the infimum gives the first inequality in (11).

### A tree variational principle

Take a nonempty finite set of types. A vertex of type $v$ has a prescribed finite list of children, each with a specified type $w$ and a linear edge map $B$ from the nonzero finite-dimensional space at type $v$ to the one at type $w$. An edge contributes $B$ toward the child and $B^*$ toward the parent. Let $\mathcal H_v$ be the self-adjoint adjacency operator on the tree rooted at type $v$, acting on the direct sum of the internal spaces at its vertices. It is bounded by the maximum vertex degree times the maximum edge-map norm, and is zero when there are no edges. Put
$$
F_v(G)=G_v^{-1}+\sum_{v\to w}B^*G_wB .
$$
The sum runs over the prescribed child edges of type $v$, with multiplicity. The maximum upper spectral edge of the $\mathcal H_v$ is $\inf_{G_v\succ0}\max_v\lambda_{\max}(F_v(G))$.

### Proof of the tree variational principle

On a one-type word tree, let $B_j$ be the edge coefficient from $v$ to $jv$. The basic inequality
$$
2\operatorname{Re}\langle x_{jv},B_jx_v\rangle
\leq x_{jv}^*G^{-1}x_{jv}+x_v^*B_j^*GB_jx_v
$$
comes from expanding a square in the positive definite metric $G$. For arbitrary types use $G_w$ at the child of each edge. Each nonroot vertex receives its own inverse-probe term once and the child contributions from all its outgoing edges. The root receives only the latter. Summation on finitely supported vectors bounds every upper edge by $\max_v\lambda_{\max}(F_v(G))$.

Conversely, for $t$ above all the upper edges let $G_v$ be the compression of $(tI-\mathcal H_v)^{-1}$ to the root space of type $v$. It is positive definite. Deleting the root leaves the child trees, which are copies of the rooted trees for their respective types. Taking the Schur complement gives
$$
G_v^{-1}=tI-\sum_{v\to w}B^*G_wB .
$$
Substitution yields $\max_v\lambda_{\max}(F_v(G))=t$. Letting $t$ decrease to the maximum upper edge proves the reverse variational inequality. This also covers isolated roots, for which the adjacency operator is zero.

### Proof of the circular norm identity

For the one-type word tree the operator of the variational principle is $\mathcal H=\sum_j(B_j\otimes\ell_j+B_j^*\otimes\ell_j^*)$. To obtain the Hermitian dilation of the operator in (11), take the internal space $E\oplus F$. For each $i$ use $B_{i,1}$ with sole nonzero block $\sqrt{w_i}D_i$ in the upper-right position, and $B_{i,2}=B_{i,1}^*$. The covariance $\sum B_j^*GB_j$ is block diagonal for every $G$ and depends only on the two diagonal blocks of $G$. Consequently the root equation in the proof above gives block-diagonal probes for all $t$ above the edge. Their two covariance blocks are $\Phi(V)$ and $\Phi^*(U)$ for $G=U\oplus V$. The upper edge of a Hermitian dilation equals the operator norm of its rectangular block. This proves the equality in (11), the circular case of Lehner's variational formula. [Lehner, Corollary 1.6](https://doi.org/10.1353/ajm.1999.0022)

### Marginal variances and positive semidefinite coefficients

For $a=\|\Phi(I)\|>0$ and $b=\|\Phi^*(I)\|>0$, setting $U=I/\sqrt b$ and $V=I/\sqrt a$ gives a finite support value with $\|Z\|<\sqrt a+\sqrt b$. If either marginal variance is zero, both covariance maps vanish, each nonzero coefficient matrix has a deterministic scalar, and $Z=0$ on the whole support. In particular, for Hermitian rank-one $D_i$ and real scalar laws the two marginal variances are both $\|\sum_iw_iD_i^2\|$. When this quantity is positive, every fixed finite instance has a support realization strictly below $2\|\sum_iw_iD_i^2\|^{1/2}$. This includes the rank-one positive semidefinite class of Kyng–Luh–Song. Song and Yue's Theorem 5.1 supplies the matching worst-case lower bound for that positive semidefinite class. Here $\Phi=\Phi^*$. Averaging probes $(U,V)$ and $(V,U)$ by operator convexity of inversion allows the infimum in (11) to be taken over $U=V$. [Song–Yue, Theorem 5.1](https://opencryptology.org/2026/2123/versions/20260924T174659Z.pdf)

## 6. Exact constants for all finite variance profiles

### Profile theorem

Fix two finite sets of types $\mathcal L,\mathcal R$ and finite numbers $s_{uv}\geq0$ on ordered pairs of opposite types. Allow arbitrary finite-dimensional spaces $E=\bigoplus_{u\in\mathcal L}E_u$ and $F=\bigoplus_{v\in\mathcal R}F_v$ with type projections $P_u,P_v$. Impose the operator bounds

$$
\Phi(P_v)\preceq\sum_{u\in\mathcal L}s_{uv}P_u,\qquad
\Phi^*(P_u)\preceq\sum_{v\in\mathcal R}s_{vu}P_v .
\tag{12}
$$

If one of $s_{uv},s_{vu}$ vanishes, replace both by zero. For example $s_{uv}=0$ forces $P_u\Phi(P_v)P_u=0$ and hence $\|P_ul_i\|\|P_vr_i\|=0$ for each positive-weight label. Thus $\Phi^*(P_u)$ annihilates $F_v$ and the reverse cap can be set to zero. The reverse argument is identical. We denote the pruned profile again by $s$ and write

$$
\rho(s)=\inf_{g_u>0}\max_u\left(g_u^{-1}+\sum_v s_{uv}g_v\right).
\tag{13}
$$

**Profile theorem.** The supremum of $\min_{\rm supp}\|Z\|$ over all data satisfying (12) is exactly $\rho(s)$. The same supremum is attained as a limit of finite real fair-sign matrix-unit examples on trees. The profile may be asymmetric across every edge.

The minimum is over the finitely many original scalar support choices in each instance. The supremum ranges over all instances, with arbitrary finite type dimensions, including zero-dimensional types. An isolated type contributes an infimum of zero through its inverse-probe term. If one side has no types then $Z=0$ and $\rho(s)=0$. If both type sets are empty we set the maximum in (13) to zero and take the empty forest as the zero instance.

### Proof of the profile theorem

For the upper bound use $U=\sum_{u\in\mathcal L}g_uP_u$ and $V=\sum_{v\in\mathcal R}g_vP_v$ in (11). Condition (12) bounds the two covariance blocks by the corresponding type-diagonal sums, so taking the infimum over the $g_u$ gives $\min_{\rm supp}\|Z\|\leq\rho(s)$. With no active edge both covariance maps vanish and both sides of the theorem are zero. For the lower bound, apply the tree variational principle of §5 to the internal space $\mathbb C$ at each type $v$, with one child of type $w$ and scalar edge map $\sqrt{s_{vw}}$ whenever $s_{vw}>0$. With $G_v=g_v$, the objective is exactly (13), so the maximum upper spectral edge over all root types equals $\rho(s)$. At each root, density of finitely supported vectors gives the upper edge as the supremum of the largest eigenvalues of its finite root balls. Isolated types contribute edge zero.

Given a root type and depth $h$, take an integer $N$ so large that $d_{vw}=\lfloor N s_{vw}\rfloor\geq2$ on every active directed pair. Grow a finite bipartite tree to depth $h$. At a node of type $v$ allocate $d_{vw}$ children of type $w$, subtracting one if the parent is of type $w$. The root has no subtraction. Use a matrix unit from each right vertex to its left neighbor with weight $1/\sqrt N$ and an independent fair sign. Every vertex, including the boundary, has total incident squared weight towards type $w$ at most $d_{vw}/N\leq s_{vw}$, so (12) holds. All signs can be removed by diagonal signs on vertices along this tree, and every realization has the unsigned adjacency upper edge as its rectangular norm.

Group vertices at each depth by their full type history from the root and use the normalized indicator of each nonempty class. Distinct histories give orthogonal vectors. The adjacency between one history and its extension by $w$ has coefficient $\sqrt{(d_{vw}-\mathbf1_{\{\text{parent type}=w\}})/N}$, with no subtraction at the root. For large $N$ all active histories of depth at most $h$ occur. Their number is fixed for fixed $h$, and the compressed adjacency converges entrywise to the weighted root ball just described. The largest eigenvalue of the compression is a lower bound for the finite tree's norm. Let $N$ tend to infinity at fixed $h$ and root type, then take the supremum over depths and root types. This yields the lower bound $\rho(s)$. For a zero profile with a root type, a single isolated vertex realizes zero.

### Examples

With one left and one right type and positive caps $a,b$, minimizing the maximum of $u^{-1}+av$ and $v^{-1}+bu$ gives $\sqrt a+\sqrt b$. For the lower bound put $y=uv$. The maximum is at least the geometric mean $\sqrt{(1+ay)(1+by)/y}\geq\sqrt a+\sqrt b$. Equality holds at $u=1/\sqrt b,v=1/\sqrt a$. If either cap is zero then the pruned value is zero.

For a connected example take two types on each side and cross array $\left(\begin{smallmatrix}1&1\\1&0\end{smallmatrix}\right)$ in both directions. Averaging the two sides' probe values by convexity of reciprocation allows common probes $p,q$. The objective becomes $\max\{p^{-1}+p+q,\ q^{-1}+p\}$. For each $p$ it is minimized where the two terms meet, so $p=q/(1-q^2)$ with $0 < q < 1$. The remaining minimum of $1/[q(1-q^2)]$ is $3\sqrt3/2$, strictly below the marginal-only constant $2\sqrt2$. The theorem shows both values are optimal for their respective data specifications.

A two-dimensional example improves the variance-only comparison within the original Hermitian positive semidefinite class itself. Use the projectors on $e_1,(e_1+e_2)/\sqrt2,(e_1-e_2)/\sqrt2$ with scalar variances $1,2,2$, respectively. On a diagonal probe with entries $u,v$, $\Phi$ has diagonal entries $2u+v,u+v$ and vanishing off-diagonal entries. The marginal-only bound is $2\sqrt3$. The single probe $(u,v)=(3/5,9/20)$ gives $\max\{199/60,589/180\}=199/60<2\sqrt3$ in (11). The two numbers compare guarantees for the same three projectors.

## 7. The scalar constant and related work

### Proof of the scalar-background specialization

In the original rank-one positive semidefinite problem, every finite instance with positive variance has a support choice with discrepancy strictly below two standard deviations. The examples cited in §5 have minimum discrepancy arbitrarily close to two standard deviations, so two is the smallest universal constant. Normalize $\|\sum_i w_iD_i^2\|=1$ and dilate a Hermitian rank-one family as in §5. The two diagonal blocks of $\mathcal K(I)$ are at most the identity. At a scalar background $xI$ for $x\geq2$ the gradient commutes with the independent scalar phase rotations of the two blocks. A maximum-gradient direction can therefore be chosen in just one block. The scalar background gives $z=0$, the two blocks of each pair give $J=0$, and the gradient column in (4) gives $v=0$. The contraction (2) gives $S\leq0$ for $d\geq3$, and $S=0$ in smaller dimensions. Compression preserves the dilation structure and the bound on $\mathcal K(I)$, so induction at the same $x$ gives $Cq\leq q$ by (5). Hence $p\geq(x-1)q\geq q>0$ and $\nabla\log p\preceq I$. In dimensions zero and one the base cases are the same as in §3. Thus the parent is already strictly positive at every $x\geq2$, including $2$. The support-tree argument of §4 finishes the finite strict upper bound directly.

### Related work and scope

Kyng, Luh and Song proved a four-standard-deviation bound for independent scalar choices multiplying rank-one positive semidefinite matrices. Song and Yue give a worst-case lower bound approaching two standard deviations in that same class and develop a rank-two compression estimate. The scalar-background proof above establishes the finite strict upper bound at positive variance and uses a vanishing first-order vector. In the contraction (2), the first-order vector can be nonzero, and the pseudoinverse handles null directions directly, including for singular mixed directions. Equations (4)–(5) control the terms from overlapping pairs by one covariance map. The closed non-scalar probe region also applies to the plane laws in §4 and to rectangular coefficients in §5. The three-projector calculation in §6 illustrates the comparison of two bounds for a given instance. [Kyng–Luh–Song, Theorem 1.4](https://doi.org/10.1016/j.aim.2020.107366) · [Song–Yue, Theorem 5.1](https://opencryptology.org/2026/2123/versions/20260924T174659Z.pdf)

Wang, Lau and Zhou obtain a general free comparison with a parameter-dependent additive error and give an algorithm for bounded independent Hermitian supports. There is a direct comparison of free models on the subclass of centered scalar laws uniform on $\{1,-1,i,-i\}$, followed by Hermitian dilation. On this subclass the real and imaginary parts of each scalar are uncorrelated and have variance $1/2$. Matching them to independent semicircular variables of variance $1/2$ gives a circular variable of variance one. Thus the covariance-matched Hermitian free model is the dilation of the operator in (11). The bound (11) on that subclass has zero additive error, and the proof is existential. For arbitrary finite complex scalar laws the circular comparison in (11) concerns the centered rectangular sum and uses its scalar variances. The deterministic Hermitian background assertion is (10), with its matrix-probe bound. [Wang–Lau–Zhou, STOC 2026, Theorem 1.5 and full version, Theorem 7.3](https://arxiv.org/html/2601.08111v3)

The mixed Hodge–Riemann theorem for semipositive directions is due to Li. The polynomial selection step uses the interlacing method of Marcus, Spielman and Srivastava, and the circular variational identity is Lehner's. The tree resolvent recursion is standard in spectral theory on trees with finitely many cone types. The role of the tree construction here is to turn the directed caps into exact worst-case matrix discrepancy by approximating that spectral edge within the admissible class of real signed matrix units. Free-probability approaches to matrix concentration and discrepancy give complementary context. [Li, v6](https://arxiv.org/pdf/2611.03124v6) · [Marcus–Spielman–Srivastava](https://doi.org/10.4007/annals.2015.182.1.8) · [Lehner, Corollary 1.6](https://doi.org/10.1353/ajm.1999.0022) · [Keller–Lenz–Warzel](https://arxiv.org/pdf/1001.3600) · [Bandeira–Boedihardjo–van Handel](https://doi.org/10.1007/s00222-023-01204-6) · [Kathuria](https://arxiv.org/pdf/2609.18913)

The numerical variational calculations in §6 can be checked from (11) and (13). The proof gives no polynomial running-time guarantee for finding the selected support values.

## References

- A. S. Bandeira, M. Boedihardjo and R. van Handel. *Matrix concentration inequalities and free probability*. Inventiones Mathematicae 234 (2023), 419–487. [DOI](https://doi.org/10.1007/s00222-023-01204-6)
- M. Keller, D. Lenz and S. Warzel. *On the spectral theory of trees with finite cone type*. Israel Journal of Mathematics 194 (2013), 107–135. [Preprint](https://arxiv.org/pdf/1001.3600)
- R. Kyng, K. Luh and Z. Song. *Four deviations suffice for rank 1 matrices*. Advances in Mathematics 375 (2020), 107366. [DOI](https://doi.org/10.1016/j.aim.2020.107366)
- F. Lehner. *Computing norms of free operators with matrix coefficients*. American Journal of Mathematics 121 (1999), 453–486. [DOI](https://doi.org/10.1353/ajm.1999.0022)
- E. Li. *Hodge–Riemann relations for m-positive and generalized m-positive forms*. arXiv:2611.03124v6. [Preprint](https://arxiv.org/pdf/2611.03124v6)
- A. W. Marcus, D. A. Spielman and N. Srivastava. *Interlacing families II: Mixed characteristic polynomials and the Kadison–Singer problem*. Annals of Mathematics 182 (2015), 327–350. [DOI](https://doi.org/10.4007/annals.2015.182.1.8)
- Zhao Song and Song Yue. *Two Standard Deviations Are Necessary for the Kadison–Singer Problem*. Preprint 2026/2123, version of 24 September 2026. [Preprint](https://opencryptology.org/2026/2123/versions/20260924T174659Z.pdf)
- Robert Wang, Lap Chi Lau and Hong Zhou. *Derandomizing Matrix Concentration Inequalities from Free Probability*. Proceedings of the 58th Annual ACM Symposium on Theory of Computing (STOC 2026). [DOI](https://doi.org/10.1145/3798129.3800763) · [Full version](https://arxiv.org/html/2601.08111v3)
- Tarun Kathuria. *A Walk From Free Probability to Matrix Discrepancy II: Weaver's Problem and the Kadison–Singer Conjecture*. arXiv:2609.18913. [Preprint](https://arxiv.org/pdf/2609.18913)
