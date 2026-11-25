---
title: "Thermodynamic boundary charge in the two-track non-Hermitian fermion chain"
lang: en
geometry: margin=1in
fontsize: 11pt
---

## Abstract

The open two-track non-Hermitian chain has a half-filled state whose ordinary particle imbalance is bounded even though its individual right eigenstates accumulate at one boundary. We compute the thermodynamic imbalance as a scalar Fourier integral and prove exponential convergence in the distance between the cut and the chain ends. The bulk density converges to one particle per cell, and the limiting boundary charges are equal and opposite. The right boundary charge is strictly positive for rightward hopping bias. We derive a sharp quadratic weak-coupling expansion and a strict upper bound. An exact covariance identity also proves that the finite-size half-chain imbalance increases strictly with the hopping bias, including outside the analytic regime used for the thermodynamic formula.

## 1. Model and results

Let the open chain have \(L\ge2\) cells, each with two orbitals. Set \(S_L e_j=e_{j+1}\) for \(j<L\) and \(S_L e_L=0\). For \(r>0\), \(\varepsilon>0\), and \(\delta>2\), put
\[
A_L=rS_L+r^{-1}S_L^\dagger,\qquad
C=r+r^{-1},\qquad
q=\frac{\varepsilon C}{\delta}.
\]
The one-particle Hamiltonian on the two orbitals is
\[
H_L=
\begin{pmatrix}
 A_L+\delta I & \varepsilon A_L\\
 \varepsilon A_L & A_L-\delta I
\end{pmatrix}.
\]
This is the two-track chain of [1]. Its open-boundary eigenvalues at the spatial eigenvalue \(x\in(-2,2)\) are \(x\pm\sqrt{\delta^2+\varepsilon^2x^2}\). Hence at half filling the occupied subspace consists of all \(L\) negative-energy right modes. We normalize the corresponding Slater state in the ordinary Hilbert inner product. We write \(n_{j,L}\) for the expectation of the total density in the two orbitals at cell \(j\). These ordinary expectations are different observables from biorthogonal density expectations.

For a cut \(1\le h<L\), let \(Q_h\) project onto the cells \(j>h\) and write
\[
B_L(h)=\sum_{j>h}(n_{j,L}-1).
\]
For even \(L\), the half-chain particle-number imbalance of [1] is \(I_L=2B_L(L/2)\), because the total particle number is \(L\).

Define
\[
f(z)=-\frac{\varepsilon z}{\delta+\sqrt{\delta^2+\varepsilon^2z^2}},
\qquad
z(k)=r e^{ik}+r^{-1}e^{-ik},\qquad
\varphi(k)=f(z(k)).
\]
For complex arguments the square root is the branch positive at zero. In the analytic regime \(q<1\), this branch is well defined along the full curve \(z(k)\).

**Theorem 1 (locality and exact thermodynamic imbalance).** Suppose \(r>1\) and \(q<1\). Then
\[
\mathcal I=
\frac{1}{\pi}\int_0^{2\pi}
\frac{\operatorname{Im}(\overline{\varphi(k)}\,\varphi'(k))}
{1+|\varphi(k)|^2}\,dk
\tag{1}
\]
is the thermodynamic limit of \(I_L\). More generally, for every fixed \(1<\rho<q^{-1}\),
\[
B_L(h)=\mathcal I/2+O(\rho^{-\min(h,L-h)}),\qquad
|n_{j,L}-1|\le C_\rho\rho^{-\min(j-1,L-j)} .
\tag{2}
\]
The constants are independent of the chain length and cut or cell. For each fixed distance from either edge, the density has a half-line limit. Summing its excess over the right edge gives \(\mathcal I/2\), while the left edge gives \(-\mathcal I/2\).

**Theorem 2 (sign, weak coupling, and finite-bias monotonicity).** In the regime of Theorem 1,
\[
0<\mathcal I<1-\sqrt{1-q^2}.
\tag{3}
\]
For fixed \(r>1,\delta>2\) and \(\varepsilon\downarrow0\),
\[
\mathcal I=\frac{\varepsilon^2}{2\delta^2}(r^2-r^{-2})+O(\varepsilon^4).
\tag{4}
\]
At every finite even size and for every \(r>0\), \(\delta>2\), and \(\varepsilon>0\), the ordinary imbalance \(I_L\) is a strictly increasing function of \(\log r\), with \(I_L=0\) at \(r=1\). No smallness restriction on \(q\) is needed for this finite-size statement. The densities also obey \(n_{j,L}+n_{L+1-j,L}=2\).

The source [1] proves a uniform bound on \(|I_L|\) in its line-gap counterexample. The results here determine the nonzero limit behind that bound and show how its charge is distributed.

## 2. Occupied graph and trace identities

Let \(D_r e_j=r^j e_j\). Then \(A_L=D_r(S_L+S_L^\dagger)D_r^{-1}\), so \(A_L\) is diagonalizable with real eigenvalues in \((-2,2)\). Solving the two-orbital eigenvector equation in an eigenspace of \(A_L\) shows that the occupied graph is
\[
\mathcal V_L=\{(F_Lv,v):v\in\mathbb C^L\},\qquad F_L=f(A_L).
\]
At arbitrary \(q\) this matrix function is defined on the real spectrum by the displayed real values of \(f\). These values can equivalently be represented by a real interpolating polynomial for each finite \(L\). When \(q<1\) the same matrix function is given by its power series.

Write \(M_L=(I+F_L^\dagger F_L)^{-1}\) and \(K_L=M_L F_L^\dagger\). The orthogonal projection onto the graph has diagonal blocks \(F_L M_L F_L^\dagger\) and \(M_L\). The one-particle density matrix of the ordinarily normalized Slater state is that orthogonal projection, as follows by using an orthonormal basis of the occupied space. Therefore
\[
n_{j,L}-1=(F_L K_L-F_L^\dagger F_L M_L)_{jj}.
\tag{5}
\]
The cut excess is
\[
B_L(h)=\operatorname{Tr}([Q_h,F_L]K_L).
\tag{6}
\]
Indeed \(I-M_L=F_L^\dagger F_L M_L\), and moving the factors cyclically in the right-cut trace of (5) gives (6). This identity is also used in [1].

Let \(R_L\) reverse the cell order. Since \(A_L^\dagger=R_L A_L R_L\) and the polynomial interpolation of \(f\) can be real, \(F_L^\dagger=R_L F_L R_L\). The identity \(F_L M_L F_L^\dagger=I-(I+F_L F_L^\dagger)^{-1}\) then makes (5) the \(j\)th diagonal entry of \(M_L-R_L M_L R_L\). This proves the exact reflection relation for every finite chain.

## 3. Exponential approximation by the bilateral cut

The proof uses convergent expansions in nearest-neighbor matrix products. Take \(X_L=A_L/C\), so \(\|X_L\|\le1\) and \(X_L\) has bandwidth one. We also use \(X_\infty=(rS_\infty+r^{-1}S_\infty^\dagger)/C\) on the bilateral chain \(\ell^2(\mathbb Z)\), and the compressions to each half-line. All have norm at most one and the same interior hopping coefficients.

For \(|w|<1\) write
\[
\phi(w)=\frac{1-\sqrt{1+w^2}}{w},\qquad \phi(0)=0 .
\]
Then \(F_L=\phi(qX_L)\). The absolute coefficient sum of the series for \(\phi\), evaluated at \(0<a<1\), is \((1-\sqrt{1-a^2})/a<1\), by the binomial expansion. Fix \(1<\rho<q^{-1}\). Thus the coefficients of the \(X_L\)-power expansion of \(F_L\) have sum of absolute values weighted by \(\rho^{\text{degree}}\) strictly less than one. Call that sum \(b\). Adjoint powers have the same bound.

The weighted absolute sum is submultiplicative under concatenation of words in \(X_L,X_L^\dagger\). It follows that the Neumann series \(M_L=\sum_{u\ge0}(-1)^u(F_L^\dagger F_L)^u\) has a word expansion with weighted absolute sum at most \(1/(1-b^2)\). The same assertion holds for \(K_L\) and the expressions in (5), with finite constants uniform in \(L\) and for the bilateral and half-line operators. Products of a fixed word of length \(d\) have matrix entries supported within distance \(d\).

### 3.1. Cut trace convergence

For an interior cut, \(\|[Q_h,X_L]\|_1=1\), because the two nonzero crossing entries have singular values \(r/C,r^{-1}/C\). The same is true at the bilateral cut. Telescoping powers gives \(\|[Q_h,X_L^i]\|_1\le i\). Consequently the trace of a term \([Q_h,X_L^i]V_L\), with \(V_L\) a word of length \(d\), has absolute value at most \(i\). This ensures absolute convergence of the trace expansion in (6), also on the bilateral chain. For the coefficient series of \(F_L\), inserting the factor \(i\) preserves the weighted summability since \(\rho q<1\).

Move the cut to between cell labels zero and one. Then the finite sites are \(\{1-h,\ldots,L-h\}\). In a trace term \([Q_h,X_L^i]V_L\), expand the matrix entries into closed nearest-neighbor walks of length \(i+d\). The commutator multiplies the walk weight by the difference of the right-side indicators at the endpoints of its first \(i\) steps. Every nonzero contribution therefore crosses the cut and visits both cells zero and one. A contributing closed walk of length \(\ell=i+d\) lies entirely in \([1-\ell,\ell]\), since it visits both anchor cells and moves at most one cell per step. If \(\ell\le\min(h,L-h)\), these walks, including their signs, are exactly the same as in the bilateral trace. In the difference of the traces only longer terms survive. Their total is at most a constant times \(\rho^{-\min(h,L-h)}\), by the weighted coefficient sums and the trace-norm bound. Hence
\[
B_L(h)=\operatorname{Tr}([Q_\infty,F_\infty]K_\infty)
+O(\rho^{-\min(h,L-h)}),
\tag{7}
\]
where \(Q_\infty\) projects onto cells \(j\ge1\) of the bilateral chain.

### 3.2. Local density and the edges

For a diagonal entry of (5), words of length at most \(\min(j-1,L-j)\) agree with the corresponding bilateral entries. On the bilateral chain, \(F_\infty\) is a Laurent operator and is normal, so the operator in (5) vanishes there. The remaining longer words have sum bounded by \(C_\rho\rho^{-\min(j-1,L-j)}\). This proves the density estimate in (2).

For fixed distance \(d\) from the right edge, compare the same words with the half-line \(j\le0\), with the rightmost site shifted to zero. Every fixed-length word eventually agrees, and the uniform coefficient tail converges to zero. Thus \(n_{L-d,L}-1\) has a limit as \(L\to\infty\). The left limit follows in the same way or by reflection. For the right half with \(0\le d<L/2\), the bound just proved is at most \(C_\rho\rho^{-d}\). Dominated summation and (7) identify the sum of the right-edge profile with the bilateral cut trace. The left sum is its negative.

## 4. Fourier evaluation and sign

Use the convention \(e_j\mapsto e^{ijk}\), so \(S_\infty\) multiplies by \(e^{ik}\). The symbols of \(F_\infty\) and \(K_\infty\) are \(\varphi(k)\) and \(\overline{\varphi(k)}/(1+|\varphi(k)|^2)\), respectively. Let their Fourier coefficients be \(\varphi_n,\kappa_n\) with expansion in \(e^{ink}\). The bandwidth and weighted expansions above give exponential coefficient decay. The trace in (7) can therefore be evaluated entrywise:
\[
\operatorname{Tr}([Q_\infty,F_\infty]K_\infty)
=\sum_{n\in\mathbb Z} n\,\varphi_n\kappa_{-n}
=\frac1{2\pi i}\int_0^{2\pi}
\frac{\varphi'(k)\overline{\varphi(k)}}{1+|\varphi(k)|^2}\,dk.
\]
For the first equality the signed number of index pairs with difference \(n\) crossing the half-line cut is \(n\). More explicitly,
\(\sum_j[\mathbf 1_{\{j+n\ge1\}}-\mathbf 1_{\{j\ge1\}}]=n\).
The real part of the numerator divided by \(1+|\varphi|^2\) is half the derivative of \(\log(1+|\varphi|^2)\), whose integral vanishes. Doubling the cut trace gives (1), with the sign attached to the chosen rightward hopping convention. This completes Theorem 1.

To determine its sign, let \(w(k)=(\varepsilon/\delta)z(k)=a\cos k+i b_0\sin k\), with \(a=q\) and \(b_0=(\varepsilon/\delta)(r-r^{-1})\). Thus \(0<b_0<a<1\). The nonzero function \(\varphi=\phi(w)\) has logarithmic derivative
\[
\frac{\varphi'}{\varphi}=\frac{w'/w}{\sqrt{1+w^2}} .
\]
The imaginary part of \(w'/w\) is \(a b_0/|w|^2>0\). Its real part is \((b_0^2-a^2)\sin k\cos k/|w|^2\), opposite in sign to \(\operatorname{Im}(w^2)\) when nonzero. The inverse square root has positive real part, since \(\operatorname{Re}(1+w^2)>0\), and its imaginary part is also opposite in sign to \(\operatorname{Im}(w^2)\). Hence the imaginary part of the product is strictly positive at every \(k\). This is the derivative of the phase of \(\varphi\).

The ellipse \(w(k)\) winds once positively, and \(1+\sqrt{1+w^2}\) stays in the right half plane. The phase derivative of \(\varphi\) therefore integrates to \(2\pi\). Also
\[
|\varphi|\le\frac{q}{1+\sqrt{1-q^2}},\qquad
\frac{|\varphi|^2}{1+|\varphi|^2}\le\frac{1-\sqrt{1-q^2}}{2}.
\]
The first bound uses \(\operatorname{Re}\sqrt{1+w^2}\ge\sqrt{1-q^2}\). It is strict almost everywhere in \(k\), since \(|w|<q\) apart from the ends of the major axis. Formula (1) is the integral of this weight times the strictly positive phase derivative, divided by \(\pi\). This proves (3).

For fixed \(r,\delta\), as \(\varepsilon\downarrow0\) we have \(\varphi=-w/2+O(\varepsilon^3)\) and \(\varphi'=-w'/2+O(\varepsilon^3)\), uniformly in \(k\). The imaginary part of \(\overline w w'\) equals \(a b_0\). Substitution into (1) gives \(\mathcal I=a b_0/2+O(\varepsilon^4)\), exactly (4).

## 5. Finite-size monotonicity from the Slater covariance

This argument uses the real finite-chain spectrum and needs no upper bound on \(q\). Write \(s=\log r\) and label the individual orbitals by \(a\), with cell position \(x_a\). The full Hamiltonian at bias \(r\) is obtained from its value at \(r=1\) by conjugating with \(D_r\oplus D_r\). Consequently, amplitudes of a Slater configuration are multiplied by \(\exp(sX)\), where \(X=\sum_a x_a N_a\) and \(N_a\) is the configuration's occupation indicator at orbital \(a\). In the ordinary norm, its probability is tilted by \(\exp(2sX)\), followed by normalization. Thus for the count \(N_{\mathrm{R}}=\sum_{x_a>L/2}N_a\),
\[
\frac{d}{ds}\mathbb E_s N_{\mathrm{R}}=2\operatorname{Cov}_s(N_{\mathrm{R}},X).
\]
At bias \(r\) let \(P\) denote the orthogonal occupied projection. For a Slater state, \(\operatorname{Cov}(N_a,N_b)=-|P_{ab}|^2\) for distinct orbitals, from the two-site determinant of the one-particle density. For the diagonal, \(\operatorname{Var}(N_a)=P_{aa}(1-P_{aa})=\sum_{b\ne a}|P_{ab}|^2\), by \(P^2=P\). Substituting these relations cancels terms within the right half in opposite pairs. It gives the exact derivative
\[
\frac{d I_L}{ds}
=4\sum_{x_a>L/2,\ x_b\le L/2}(x_a-x_b)|P_{ab}|^2 .
\tag{8}
\]
Every coefficient of a crossing matrix element is positive.

There must be a nonzero crossing element. If there were none, the occupied projection would commute with \(Q_{L/2}\oplus Q_{L/2}\). Its range, the graph of \(F_L\), would be invariant under that block cut projection, forcing \(Q_{L/2}F_L=F_LQ_{L/2}\). But \(f\) is strictly decreasing on the real axis, so it is injective on the finite spectrum of \(A_L\). Diagonalizability and polynomial interpolation then express \(A_L\) as a polynomial in \(F_L\). Thus \(A_L\) would commute with the cut projection, contrary to its nonzero hopping across the cut. Equation (8) is strictly positive. At \(r=1\) the state density is reflection invariant and the half-chain imbalance is zero. This proves the finite-size part of Theorem 2.

## 6. Relation to the pinned counterexample

The occupied graph and uniform bounded imbalance come from [1]. We use the ordinary density projection of that work. The new ingredients are the exponential control of cut and density errors, the evaluation and sign of the residual boundary charge, and the bias derivative at finite size. The periodic spectral-intersection assumptions of [1] select a subfamily of these open-chain calculations. The new formulas do not require such an intersection. They concern the ordinary half-filled state and give no corresponding assertion about other fillings or biorthogonal occupations.

## Reference

1. *Periodic spectral line gaps and the many-body skin effect: a rigorous counterexample* (Chinese manuscript), earlier research manuscript at  (archived version), especially Sections 2–4.
