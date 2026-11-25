---
title: "The sharp peripheral Jordan order of monitored quantum kernels"
fontsize: 11pt
geometry: margin=1.1in
abstract: |
  On a \(d\)-dimensional Hilbert space, a completely positive map can have peripheral Jordan order \(2d-1\). We prove the bound and show that saturation forces a simultaneous upper-triangular Kraus representation with a common scalar diagonal in each Kraus operator. For a monitored time-homogeneous Lindblad first-count Laplace kernel this Kraus algebra is incompatible with the loss term. The sharp physical bound is \(2d-2\) for every \(d\ge2\), including hidden jumps. We construct an all-counted zero-Hamiltonian process that attains the bound and retains the highest Jordan term in the ordinary full-trace first-passage transform.
---

## 1. Setting and results

Let \(T:M_d(\mathbb C)\to M_d(\mathbb C)\) be completely positive, written as \(T(X)=\sum_a A_aXA_a^\dagger\). We consider its ordinary complex spectrum. A peripheral eigenvalue has modulus \(\rho(T)\), the spectral radius, and its order is the largest size of a Jordan block there.

For a monitored time-homogeneous Lindblad system, let \(L_j\) be its counted jumps, \(U_i\) its hidden jumps, and \(H\) its Hermitian Hamiltonian. The no-count evolution and the one-count kernel at \(s>0\) are
\[
\begin{split}
K&=-iH-\tfrac12\Big(\sum_jL_j^\dagger L_j+\sum_iU_i^\dagger U_i\Big),\\
\mathcal L_0(X)&=KX+XK^\dagger+\sum_iU_i XU_i^\dagger,\qquad
\mathcal J(X)=\sum_j L_j X L_j^\dagger,\\
\mathcal R_s&=\int_0^\infty e^{-st}\mathcal J e^{t\mathcal L_0}\,dt.
\end{split}
\tag{1}
\]
There are finitely many jumps, which may be absent in either class. The no-count semigroup is completely positive and trace nonincreasing, since its trace derivative on positive inputs is minus the counted rate. Thus the integral converges. For the \(n\)-th count time from an initial state \(\sigma\), the ordinary Laplace transform is \(\operatorname{Tr}\mathcal R_s^n(\sigma)\), with zero weight for an infinite count time [1,2].

**Theorem 1 (abstract completely positive maps).** If \(\rho(T)>0\), every peripheral block has size at most \(2d-1\). This is sharp. If a block has size \(2d-1\), it occurs at the positive eigenvalue \(\rho(T)\), and in some orthonormal basis the Choi support is contained in
\[
\mathcal A_d=\mathbb C I+\{B:B\text{ is strictly upper triangular}\},
\tag{2}
\]
viewed as a space of vectorized matrices. If \(\rho(T)=0\), the nilpotence index is at most \(d\).

**Theorem 2 (monitored kernels).** For \(d\ge2\) and \(s>0\), the largest possible peripheral block of (1) has size exactly \(2d-2\). The upper bound permits arbitrary finite hidden jumps. A zero-Hamiltonian all-counted process attains it at any prescribed \(s>0\), with a nonzero full-trace coefficient on the highest Jordan term.

The pinned qubit result [1] gives the case \(d=2\) and a single-jump extremizer there. The separate inverse-realization paper [2] constructs visible subdominant order \(d^2-1\) in every dimension. Together with Theorem 2, it yields \(d^2-1\) as the sharp unrestricted spectral maximum, since a block of size \(d^2\) would occupy the entire spectrum and hence be peripheral. This subdominant construction is imported. Our new result distinguishes the leading spectrum from the unrestricted spectrum in arbitrary dimension.

## 2. Growth of a completely positive map

For positive spectral radius divide \(T\) by \(\rho(T)\), so that \(\rho(T)=1\). Take a largest common invariant flag for the Kraus operators,
\[
0=\mathcal H_0\subset\mathcal H_1\subset\cdots\subset\mathcal H_b=\mathbb C^d .
\]
In an orthonormal basis adapted to its successive quotients, all Kraus operators are upper block triangular. The diagonal Kraus family on each quotient has no common proper nonzero invariant subspace, because otherwise the original flag could be refined. The operator \(T\) maps a matrix block \((i,j)\) into blocks \((p,q)\) with \(p\le i,q\le j\). Ordering the pairs by the sum of the two indices gives a block-triangular representation. In particular the completely positive diagonal action
\[
T_i(X)=\sum_a A_{a,ii}X A_{a,ii}^\dagger
\]
has its spectrum in that of \(T\), so \(\rho(T_i)\le1\).

Each nonzero \(T_i\) has a positive definite eigenmatrix \(P_i\) with a nonnegative eigenvalue at most one. To see existence, the irreducible diagonal Kraus family has no common kernel, since such a kernel would be invariant. Thus \(X\mapsto T_i(X)/\operatorname{Tr}T_i(X)\) is continuous on the density matrices and maps the set to itself. A fixed point exists by Brouwer. The support of any resulting positive eigenmatrix is invariant under each Kraus operator, by the positivity of the summands, so it is the entire quotient. A zero diagonal action is possible in a one-dimensional irreducible quotient and can be treated directly. From \(I_i\le c_iP_i\) and positivity we obtain a uniform bound
\[
\sum_{a_1,\ldots,a_\ell}
\|A_{a_\ell,ii}\cdots A_{a_1,ii}\|_F^2
=\operatorname{Tr}T_i^\ell(I_i)\le C_i
\qquad(\ell\ge0),
\tag{3}
\]
where \(\|\cdot\|_F\) is the Frobenius norm. In the zero case (3) holds since every nonempty product is zero.

Consider the full Kraus word \(B_{\boldsymbol a}=A_{a_n}\cdots A_{a_1}\). In any of its blocks, each product term follows a weakly decreasing sequence of block indices. There are at most \(b-1\) strict changes. For fixed indices at the changes and fixed change times, the term is a product of diagonal words and single off-diagonal blocks, on disjoint sets of time positions. Its Frobenius norm is at most the product of the norms of these factors. In the sum of its squared norms over all Kraus words, the bounds factor across these disjoint sets. Apply (3) to diagonal factors and \(\sum_a\|A_{a,ij}\|_F^2<\infty\) to off-diagonal factors. The resulting squared sum is uniformly bounded, independent of \(n\).

There are \(O(n^{b-1})\) schedules of strict changes, counting all block-index chains in this fixed map. Apply the triangle inequality in the space of word-indexed Frobenius vectors. For each block the square root of its total word energy is \(O(n^{b-1})\), and summing over the finitely many blocks gives
\[
\sum_{\boldsymbol a}\|B_{\boldsymbol a}\|_F^2=O(n^{2b-2}).
\tag{4}
\]
The norm of \(T^n\) as an operator in Frobenius norm is at most this sum. A unit-modulus Jordan block of size \(p\) has growth of order \(n^{p-1}\) on its longest chain. Thus \(p\le2b-1\le2d-1\).

If \(\rho(T)=0\), some power \(T^h=0\). Positivity of \(T^h(I)\) as a sum of squared Kraus products implies every word of length \(h\) is zero. Write \(V_\ell\) for the span of the ranges of the words of length \(\ell\), with \(V_0=\mathbb C^d\). The recurrence \(V_{\ell+1}=\sum_a A_aV_\ell\) gives a decreasing sequence, and equality at a nonzero step would persist forever. The dimension therefore drops at every step up to zero, so \(T^d=0\).

## 3. Rigidity at maximal abstract order

Suppose a peripheral block has size \(2d-1\), still with normalized radius one. The bound \(2b-1\) forces \(b=d\). Hence all Kraus matrices are upper triangular with scalar diagonal entries \(a_{u,ii}\). Put \(v_i=(a_{u,ii})_u\). In the matrix-unit basis the diagonal coefficient at \((i,j)\) is
\[
g_{ij}=\sum_u a_{u,ii}\overline{a_{u,jj}} .
\]
In particular \(g_{ii}=\|v_i\|^2\le1\). Write \(T=D+N\) with \(D\) diagonal in that basis and \(N\) mapping each pair only to pairs with lower sum of indices. For \(z\) off the spectrum, the inverse of \(zI-T\) is the finite geometric expansion in \(N(zI-D)^{-1}\), preceded by \((zI-D)^{-1}\). An entry of this expansion is a sum over paths of pair indices, each step decreasing at least one coordinate and increasing neither. A path term has one factor \((z-g_{ij})^{-1}\) for each visited pair. The pole order at an eigenvalue is therefore at most the largest number of equal-eigenvalue nodes on one path.

A pole of order \(2d-1\) forces a path of \(2d-1\) nodes from \((d,d)\) to \((1,1)\), decreasing one coordinate by one at each step, with all its diagonal coefficients equal to the eigenvalue. Its ends show that the eigenvalue is positive, hence one in the normalization. At each node \(g_{ij}=1\) and the norm bounds imply \(v_i=v_j\) and both have norm one, by equality in Cauchy--Schwarz. When an index occurs for the first time on the path, the other coordinate has already occurred, since only one coordinate changes. Thus all \(v_i\) are equal. This says precisely that each Kraus matrix belongs to (2), and their span is its Choi support. Undoing the normalization gives the rigidity statement.

For sharpness take the single Kraus matrix \(A=I+J_d\), where \(J_d\) shifts each basis vector to the preceding one and kills the first. The conjugation map has all eigenvalues one. With left multiplication by \(J_d\) and right multiplication by \(J_d^\dagger\) denoted by \(L,R\), its nilpotent part is \(L+R+LR\). The two operators commute and each has index \(d\). The power \(2d-2\) equals \(\binom{2d-2}{d-1}L^{d-1}R^{d-1}\ne0\), and the next is zero. This proves sharpness.

## 4. The restriction imposed by Lindblad dynamics

The Choi path observation used for qubits in [1] holds in every dimension. Expand \(e^{t\mathcal L_0}\) by iterating variation of constants for the sum of the no-jump evolution \(X\mapsto e^{Kt}Xe^{K^\dagger t}\) and the hidden-jump map. The path operators, after the counted jump, have the form
\[
L_j e^{Kv_\ell}U_{i_\ell}e^{Kv_{\ell-1}}\cdots U_{i_1}e^{Kv_0},
\tag{5}
\]
where the durations are nonnegative. After incorporating \(t\) in (1), each sequence of hidden types contributes an integral of vectorized path outer products over independent durations, with weight \(e^{-s\sum_\nu v_\nu}\). The finite-time series converges and its Choi terms are positive. A vector perpendicular to the Choi support of \(\mathcal R_s\) has zero integral of its squared inner product with every such path. Since the weight is positive and the paths vary continuously, the inner product vanishes for all positive durations and then at every zero-duration boundary. Thus each operator (5) is in the Choi support.

Suppose \(\mathcal R_s\) attains peripheral order \(2d-1\). Its spectral radius is positive by the nilpotent bound for \(d\ge2\). In the basis of Theorem 1, all paths are in \(\mathcal A_d\). With no hidden events and zero duration this gives \(L_j\in\mathcal A_d\) for every counted jump.

Some counted \(L_j\) is invertible. Indeed, the singular elements of \(\mathcal A_d\) are strictly upper triangular. If all \(L_j\) were singular, every output would be supported in the span of the first \(d-1\) basis vectors. The quotient by its matrix algebra would then carry the zero map. Every nonzero generalized eigenspace would belong to that matrix algebra, because the restriction of \(\mathcal R_s\) to that generalized eigenspace is invertible and maps into the output algebra. The restriction on that algebra is completely positive and has the same positive spectral radius. Its peripheral order would be at most \(2(d-1)-1\), a contradiction.

The algebra \(\mathcal A_d\) is unital and closed under inversion of invertible elements, by the finite geometric series for the strictly upper triangular part. Fix an invertible \(L_j\). Differentiating \(L_j e^{Kt}\) at zero gives \(L_jK\in\mathcal A_d\). A path with one hidden jump at zero durations gives \(L_jU_i\in\mathcal A_d\). Multiplying by \(L_j^{-1}\) shows \(K,U_i\in\mathcal A_d\).

Each jump in \(\mathcal A_d\) has the form \(aI+B\) with \(B\) strictly upper triangular. The first column has squared norm \(|a|^2\), and the \(j\)-th column has squared norm \(|a|^2+\sum_{i<j}|B_{ij}|^2\). But \(K\) has equal diagonal entries, so its Hermitian part in (1) forces equality of the total squared column norms of all jumps. For each column this eliminates every strict upper-triangular entry of every jump. All jumps are scalar, and \(K\) then has a scalar Hermitian part. An upper triangular matrix with equal diagonal and scalar Hermitian part is scalar. Thus \(K,H,\mathcal J,\mathcal L_0\) and the resulting kernel act as scalars on their respective spaces. This contradicts the proposed block size. The abstract bound leaves peripheral order at most \(2d-2\) at positive radius, and the nilpotent bound \(d\le2d-2\) covers zero radius.

## 5. Sharp physical attainment and trace visibility

Take \(s=1\), no hidden jumps, and \(H=0\). Write the Hilbert space as a one-dimensional sink spanned by \(e_0\) and a source of dimension \(q=d-1\) with basis \(e_1,\ldots,e_q\). Let \(J_q\) shift each source basis vector to the preceding one, killing \(e_1\). Use the counted source jump \(L_B=I_q+J_q\), extended by zero at the sink, and the counted sink jump \(L_0=|e_0\rangle\langle e_0|/\sqrt5\). Put
\[
Q=5I_q-L_B^\dagger L_B\succ0,
\]
where the products are on the source. Positivity follows from \(\|I_q+J_q\|\le2\). Add \(q\) counted transfer operators
\[
D_j=|e_0\rangle\langle e_j|Q^{1/2},\qquad 1\le j\le q.
\]
Their total squared loss on the source is \(Q\). The total loss is therefore scalar \(5I_q\) on the source and rate \(1/5\) on the sink.

The kernel kills source–sink coherences since every jump has input supported in one of the two blocks. The no-count propagation has scalar damping on each block. Integrating in (1) gives, on a sink weight \(u\) and source matrix \(X\),
\[
\mathcal R_1(u,X)
=\bigl(\lambda u+g(X),\,T_B(X)\bigr),
\qquad
\lambda=\frac16,\quad g(X)=\frac{\operatorname{Tr}(QX)}6,\quad
T_B(X)=\frac{L_B X L_B^\dagger}6 .
\tag{6}
\]
Indeed, the source integral has denominator \(1+5=6\), and the sink multiplier is \((1/5)/(1+1/5)=1/6\). This block contains only the eigenvalue \(\lambda\). The omitted coherence block is zero, so \(\lambda\) is the positive spectral radius.

Write \(N_B=T_B-\lambda\,\mathrm{id}\). The same two commuting nilpotent multipliers as in Section 3 give
\[
N_B^{2q-2}(X)=\lambda^{2q-2}\binom{2q-2}{q-1}
                         J_q^{q-1}X(J_q^\dagger)^{q-1},
\qquad N_B^{2q-1}=0.
\tag{7}
\]
At \(q=1\) the left power in (7) is the identity, as required. For the nilpotent part \(N=\mathcal R_1-\lambda\,\mathrm{id}\) on the block-diagonal algebra, (6) implies
\[
N^{2q-1}(0,X)=(g(N_B^{2q-2}X),0),\qquad N^{2q}=0.
\]
At \(X=|e_q\rangle\langle e_q|\), the coefficient in the sink is strictly positive because \(Q\succ0\) and (7) maps that matrix to a positive multiple of \(|e_1\rangle\langle e_1|\). Thus the order is \(2q=2d-2\). For this initial state the full trace of \(\mathcal R_1^n\) retains the highest term
\[
\binom n{2q-1}\lambda^{n-(2q-1)}g(N_B^{2q-2}X)
\]
with a nonzero coefficient. This is an ordinary cumulative-count first-passage statistic with no final postselection. At any prescribed \(s=s_*>0\), multiply each jump by \(\sqrt{s_*}\). A change of variables \(t\mapsto s_*t\) in (1) yields the same kernel at that parameter.

## 6. Provenance

The qubit obstruction and the positive-integral Choi support argument are in [1]. The visible subdominant order \(d^2-1\) and its Laplace-parameter splitting are in [2]. The new conclusions concern the peripheral growth exponent, rigidity at the abstract completely positive maximum, the all-dimensional monitored obstruction, and sharp trace-visible peripheral attainment. The present attainment statement concerns the Jordan block and its trace term.

**References**

1. *Sharp Jordan-order limits for monitored qubit first-passage kernels*. earlier research manuscript, fixed commit 6c65c5eac620, Sections 1 and 4.
2. *Inverse realization of quantum first-passage kernels and visible exceptional points in arbitrary dimension*. earlier research manuscript, fixed commit 6c65c5eac620, especially Section 3. The source manifest records both precise source paths and blobs.
