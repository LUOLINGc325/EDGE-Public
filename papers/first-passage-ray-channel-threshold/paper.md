# Blind first-count calibration with singular quantum jump maps

## Abstract

The Laplace transform of a first-count operation may be measured up to an unknown multiplicative factor at each frequency. We classify the ambiguity of such data for finite-dimensional no-jump Lindblad dynamics with a positive definite total counting rate. On a $d$-dimensional system, $d^2$ distinct positive frequencies determine the jump map and the observed part of the Hamiltonian unless every normalized response is independent of frequency and has scalar total rate. The remaining Hamiltonian shifts are exactly those in the commutant of an explicit observable subspace. The theorem applies when the jump map has rank one as a linear map. In the scalar-rate branch two responses give an explicit calibration identity whenever they differ.

## 1. Model and statement

Let $d\ge2$. All jumps of a finite-dimensional Markovian quantum system are counted, without retaining the jump label. Define
\[
 J(X)=\sum_a L_a X L_a^\dagger,\qquad G=J^*(I)\succ0,\qquad
 K(X)=\tfrac12(GX+XG)+i[H,X],
\]
where $H$ is Hermitian and the adjoint uses the Hilbert–Schmidt pairing. The first-count transform at $u>0$ is
\[
 R_u=J(u\,\mathrm{id}+K)^{-1}.
 \tag{1}
\]
The data at each known frequency are the positive ray $\{cR_u:c>0\}$ of the full map in fixed matrix coordinates. The unknown scale is independent at each frequency. Put $A=K^*$ and $D=d^2$, the dimension of the real space of Hermitian matrices. All subspaces below are real. Define
\[
 \mathcal S=\operatorname{span}\{A^kG:k\ge0\},\qquad
 \mathcal O=\operatorname{span}\{A^k J^*(Y):k\ge0,\ Y=Y^\dagger\}.
 \tag{2}
\]
The commutant of $\mathcal O$ means the Hermitian matrices commuting with every $X\in\mathcal O$.

**Theorem.** Observe $D$ distinct positive-frequency rays for a system with $G\succ0$. Compare it against all physical systems in the given dimension, allowing their rates initially to be merely positive semidefinite.

1. If $G$ is nonscalar, or if $G$ is scalar and the trace-preserving normalized responses are not all equal, the data determine $G,J$, the absolute scales at the sampled frequencies, and $\mathcal O$. The compatible Hamiltonians are exactly $H+V$ with $[V,X]=0$ for all $X\in\mathcal O$.
2. Otherwise every compatible system is of the form $J'=\gamma'\Phi$ with arbitrary $\gamma'>0$ and with $[H',\Phi^*(Y)]=0$ for all Hermitian $Y$. The channel $\Phi$ is the known common trace-preserving normalized response. These systems agree in ray at every positive frequency.

In the first case the compatible systems agree in the calibrated transform at every positive frequency. An open dense subset of the positive rates and Hamiltonians has $\mathcal S$ equal to the whole Hermitian space. For such rates and Hamiltonians the physical system is unique up to a scalar Hamiltonian shift, even on the subclass with $\operatorname{rank}J=1$.

## 2. What the effects determine

Write $Q=G/2+iH$. The no-count evolution sends $X$ to $e^{-tQ}Xe^{-tQ^\dagger}$. It has norm bounded by $e^{-t\lambda_{\min}(G)}$ on Hilbert–Schmidt space, by differentiation of the vector norm under $e^{-tQ}$. Integration after the first jump gives (1). It also shows that $A$ is invertible when $G\succ0$, and that $uI+A$ is invertible for every $u>0$ under any positive semidefinite rate. We use $I$ for the matrix identity and write $\mathrm{id}$ for the identity linear map whenever the distinction is needed.

Each effect is
\[
 B_u=R_u^*(I)=(u\,\mathrm{id}+A)^{-1}G,\qquad
 A(I)=G.
 \tag{3}
\]
For $s_0=\dim\mathcal S$, every $s_0$ distinct resolvents of $G$ at these frequencies give a basis of $\mathcal S$. To see this, multiply a putative linear relation by the product of the $s_0$ resolvent denominators. It gives a polynomial of degree at most $s_0-1$ annihilating $G$. These powers of $A$ applied to $G$ are independent by the definition of the cyclic space. Thus the polynomial vanishes identically, and evaluating it at the distinct negatives of the frequencies proves the claim. Since $A$ is invertible, $I=A^{-1}G\in\mathcal S$.

Take positive representatives $b_i$ of a basis of the observed effect rays. Define $U:\mathcal S\to\mathcal S$ by $U b_i=u_i b_i$. From (3) the map $A+U$ sends $\mathcal S$ into $\mathbb R G$. In particular,
\[
 U I\in\mathbb R G,\qquad U I\ne0,
 \tag{4}
\]
since $A(I)=G$ and $U$ is invertible. This recovers the positive ray of $G$ from blind data. The same equation holds for any competitor, even before knowing its subspace or whether its rate is positive definite. It follows that its rate $G'$ is a positive multiple of $G$.

Suppose $G$ is nonscalar. The observed space $\mathcal S$ then contains a nonscalar Hermitian matrix $X$. Write $G'-G=cG$. The competing linear map $A'$ satisfies $(A'-A)(X)\in\mathbb R G$. In an eigenbasis of $X$ the diagonal entries of $-i[H'-H,X]$ are zero, while the diagonal entries of the rate part of the difference are $c\,X_{jj}G_{jj}$. Every $G_{jj}$ is positive and $X$ has two distinct eigenvalues. Proportionality to $G$ therefore forces $c=0$. For every $X\in\mathcal S$ the remaining difference is a traceless commutator in $\mathbb R G$, so it vanishes. We have proved uniqueness of both $G$ and $A$ restricted to $\mathcal S$ among all competitors. For each full-map representative, with $b_i$ its adjoint effect, the true scale $q_i$ is now determined by
\[
 q_i (u_i\,\mathrm{id}+A)b_i=G.
 \tag{5}
\]
This calibrates all the sampled full maps.

## 3. Two-frequency calibration at scalar rate

Suppose $G=\gamma I$. Every effect ray is the ray of $I$, and any one such ray forces a competing $G'$ to be scalar. Indeed if $B_u'=aI$ with $a>0$, (3) gives $(1-a)G'=auI$, so necessarily $0 < a < 1$ and $G'$ is scalar.

Let $L=-i[H,\cdot]$, skew-adjoint in the real Hilbert–Schmidt space, and let $\Phi=J/\gamma$ be a trace-preserving channel. Each full-map ray has a unique trace-preserving representative $\widehat R_u$. From (1),
\[
 \widehat R_u^*=(u+\gamma)\bigl((u+\gamma)\,\mathrm{id}+L\bigr)^{-1}\Phi^* .
 \tag{6}
\]
Suppose two such maps at frequencies $s,t$ differ, and take a Hermitian $Y$ for which $x_s=\widehat R_s^*(Y)$ and $x_t=\widehat R_t^*(Y)$ differ. Subtracting the equations for their common input $\Phi^*Y$ gives
\[
 L\left(\frac{x_s}{s+\gamma}-\frac{x_t}{t+\gamma}\right)
 = x_t-x_s.
\]
Taking its real inner product with the quantity in parentheses and using skew-adjointness gives
\[
 \gamma=
 \frac{(s+t)\langle x_s,x_t\rangle-t\|x_s\|_2^2-s\|x_t\|_2^2}
      {\|x_s-x_t\|_2^2}.
 \tag{7}
\]
So $\gamma$ and the scales $\gamma/(u+\gamma)$ are determined. If two normalized maps agree, the same difference equation shows that $L\widehat R_s^*(Y)=0$ for every $Y$. Then $\Phi^*=\widehat R_s^*$. This is equivalent to annihilating the range of $\Phi^*$ by $L$. Formula (6) shows that all compatible data in this constant case have precisely the ambiguity stated in the theorem.

## 4. Observable subspace and all remaining ambiguity

In a calibrated case set $F_i=R_{u_i}^*$. With a fixed index zero,
\[
 A(F_i-F_0)=u_0 F_0-u_iF_i .
 \tag{8}
\]
Take $N$ sampled frequencies, and put $r=\operatorname{rank}J$ and $o=\dim\mathcal O$. The span of the ranges of $F_i-F_0$ for $1\le i\le N-1$ equals $\mathcal O$ whenever $N\ge o-r+2$. This follows directly from
\[
 F_i-F_0=(u_0-u_i)(u_i\,\mathrm{id}+A)^{-1}
                             (u_0\,\mathrm{id}+A)^{-1}J^*.
\]
After applying the common invertible product of the $N$ denominator operators, the ranges span $\operatorname{span}_{0\le k\le N-2} A^k\operatorname{ran}J^*$. The distinct-frequency polynomials obtained by deleting one of the nonzero-index factors are a basis through that degree. The successive Krylov spaces begin with dimension $r$, grow by at least one at each strict step, and are invariant as soon as they stop growing. By the displayed threshold they therefore reach $\mathcal O$. The denominator product and its inverse preserve this invariant space, proving the claim.

For $N=D$ this argument applies when $r\ge2$, and also when $r=1$ and $o < D$. If $r=1$ and $o=D$, then $\operatorname{ran}J^*=\mathbb R G$ implies $\mathcal S=\mathcal O$ is the full space. It follows from Section 2 that $G,A$ are already determined. In that case $G$ cannot be scalar because a scalar rate has $\mathcal S=\mathbb R I$.

Thus (8), or full knowledge of $A$ in the last case, recovers $A$ on $\mathcal O$. Then $J^*=(u_i\,\mathrm{id}+A)F_i$ recovers the full jump map. For any candidate with the same data, the differences in (8) and the $F_i$ are the same. Its $A'$ acts identically on $\mathcal O$ and its $J'^*$ is the recovered map. Since rates agree, this is precisely the condition that the Hamiltonian shift commute with $\mathcal O$. Conversely, any such shift agrees with $A$ on $\mathcal O$ and preserves its invariance. The restricted resolvent agrees on $\operatorname{ran}J^*$, which proves equality of every calibrated response. This also establishes that the observed frequencies suffice for comparison against all physical competitors.

## 5. Singular examples and genericity

For any $G\succ0$ and density matrix $\sigma$ the map $J(X)=\sigma\operatorname{tr}(GX)$ is completely positive and of linear rank one. Thus the full-rank jump condition is irrelevant to the theorem.

To show generic identifiability choose distinct complex numbers $\lambda_j=2^j+ij$ for $j=1,\ldots,d$, and let $T=I+\varepsilon \boldsymbol1\boldsymbol1^{\mathsf T}$ for small $\varepsilon>0$. Set $Q=T\operatorname{diag}(\lambda_j)T^{-1}$. Its Hermitian part is strictly positive for sufficiently small $\varepsilon$. If $x_j$ are its right eigenvectors, the eigenvectors $x_i x_j^\dagger$ of $K$ have distinct eigenvalues $\lambda_i+\overline{\lambda_j}$. Distinctness follows from uniqueness of the real sums for unordered pairs, with imaginary parts separating the two orders. All $\langle x_j,x_i\rangle$ are nonzero, since the columns of $T$ have positive mutual inner products. The functional $\operatorname{tr}$ is therefore nonzero on every eigenmode. The Vandermonde determinant implies that $I$ is cyclic for $A$, and hence so is $G=A(I)$. In any real Hermitian basis the determinant of the cyclic vectors $(G,AG,\ldots,A^{D-1}G)$ is polynomial in $G,H$. The example proves it is nonzero on an open dense subset of strictly positive $G$ and Hermitian $H$. The same example allows any $\sigma\succ0$ in the rank-one jump family.

In contrast, a diagonal unequal $G$, a diagonal $H$, and a rank-one prepare map as above have diagonal effect space. All diagonal Hamiltonian shifts are invisible, and the theorem distinguishes this exact ambiguity from the generic case. The upper frequency bound is sufficient. For rank-one prepare maps with a fixed $\sigma$, two blind frequencies are generically insufficient: the analytic map from $G\succ0$ and traceless $H$ has parameter dimension $2D-1$, whereas two normalized effect vectors have total dimension at most $2D-2$. At a point of locally maximal rank, the constant-rank theorem gives a positive-dimensional local fiber. Such points contain an open dense set, by nonvanishing maximal analytic minors. This leaves the sharp generic number between three and $D$ in this subclass.

## References and scope

The quantum jump-time instrument and the calibrated first-passage transforms are established. Gneiting, Rozhkov and Nori describe the jump-time maps, and Menczel et al. relate first passage to tilted counting dynamics, including spectral exceptions. Rational resolvent and observability constructions are standard in state-space realization. The additional physical constraints here are the trace identity in the projective calibration (4), the Hermitian diagonal argument in the nonscalar-rate case, and the skew-adjoint identity (7) at scalar rate. The data are exact maps in fixed coordinates. Statistical reconstruction from physical shot data and general semidefinite total rates are separate regimes.

- C. Gneiting, A. V. Rozhkov and F. Nori, *Jump-time unraveling of Markovian open quantum systems*. [Physical Review A](https://doi.org/10.1103/PhysRevA.104.062212)
- P. Menczel et al., *Full Counting Statistics and First-Passage Times in Quantum Markovian Processes: Ensemble Relations, Metastability, and Fluctuation Theorems*. [PRX Quantum](https://doi.org/10.1103/4hc1-l8w4)
- A. J. Mayo and A. C. Antoulas, *A framework for the solution of the generalized realization problem*. [Linear Algebra and its Applications](https://doi.org/10.1016/j.laa.2007.03.008)
