# Interpolation, spectra, and exact phase-covariant tensorization for quantum chi-square contractions

## Abstract

For the fixed-reference quantum chi-square contraction coefficient, we prove a universal mean-alpha tensorization interval, describe tensorizing mixtures and reciprocal duals, and give exact extremal envelopes at fixed midpoint. A complete spectrum for products of phase-covariant qubit channels enables a necessary-and-sufficient differential test for all heterogeneous products in that class. For the mean-alpha family, the threshold is the same as for identical amplitude damping even when the references, population-flow directions and coherence transmissions differ. We also evaluate the exact replacement-noise region of an endpoint witness. The classification over unrestricted finite CPTP channels is open outside the known uniform positive and negative intervals. Lean verification is delivered separately.

## Problem, definitions, and prior work

Let $\mathcal K$ consist of positive operator-monotone-decreasing functions $\kappa:(0,\infty)\to(0,\infty)$ satisfying $\kappa(1)=1$ and $x\kappa(x)=\kappa(1/x)$. For a faithful density matrix $\sigma$, let $L_\sigma(X)=\sigma X$, $R_\sigma(X)=X\sigma$, and $\Omega_\sigma^\kappa=R_\sigma^{-1}\kappa(L_\sigma R_\sigma^{-1})$. Define
$$D_\kappa(\rho\Vert\sigma)=\operatorname{Tr}(\rho-\sigma)\Omega_\sigma^\kappa(\rho-\sigma),\qquad
\eta_\kappa(E,\sigma)=\sup_{\rho\ne\sigma}\frac{D_\kappa(E\rho\Vert E\sigma)}{D_\kappa(\rho\Vert\sigma)}.$$
All channels are finite-dimensional, completely positive and trace preserving (CPTP); both input and output references are faithful. Input and output dimensions may differ. A one-dimensional input has coefficient zero by convention.

The coefficient is exactly the squared induced norm on traceless Hermitian matrices. Indeed every state difference is such a matrix, and for any nonzero Hermitian traceless $H$, the state $\sigma+\varepsilon H$ is positive for sufficiently small real $\varepsilon\ne0$. The ratio is homogeneous in $\varepsilon$. This tangent-space characterization is established prior work [S1, S4]; the argument explains why no unphysical tangent witness is being substituted for a state.

The general question is to characterize all $\kappa\in\mathcal K$ for which
$$\eta_\kappa(E_1\otimes E_2,\sigma_1\otimes\sigma_2)
=\max\{\eta_\kappa(E_1,\sigma_1),\eta_\kappa(E_2,\sigma_2)\}$$
holds for every such pair. It concerns a fixed reference, not the additional supremum over references, complete contraction coefficients with a side system, quantum relative entropy, or capacities.

Cao and Lu [S1] proved universal tensorization at $\kappa(x)=x^{-1/2}$ and a broader result for quantum-classical channels. Cao [S2] gave a mean-alpha endpoint counterexample and failure in a neighborhood of zero. These results are reproduced or extended here; they are not claimed as discoveries of this project. Hiai et al. [S3] supply the monotone-metric framework and reciprocal kernel duality. George and Tomamichel [S4] explicitly distinguish Hermitian contraction from complex correlation problems and use complex interpolation in Lemma 54; Lemma 56 concerns complex power-family correlations and Corollary 63 gives geometric-mean contraction tensorization. Interpolation and recovery methods themselves are also established in [S5].

## Results at a glance

For $\kappa_\alpha(x)=(x^{-\alpha}+x^{\alpha-1})/2$:

| Quantifiers | Established result | Unresolved part |
|---|---|---|
| All finite CPTP pairs | Exact tensorization for $1/3\le\alpha\le1/2$ | Necessity of the endpoint $1/3$ is not shown |
| Heterogeneous phase-covariant qubit channels with faithful diagonal references, including identical amplitude damping | Exact threshold $\alpha_c=1/2-[2\sqrt{6\sqrt3-9}]^{-1}$ | This is not a threshold for all channels |
| All finite CPTP pairs | Counterexamples for every $0\le\alpha<\alpha_c$ | The universal interval $[\alpha_c,1/3)$ remains undecided |
| Probability mixtures supported in $[1/3,1/2]$ and their reciprocal duals | Universal tensorization | No claim that this exhausts $\mathcal K$ |
| Fixed midpoint coefficient $r$ | Exact physical comparison infimum and supremum, including fixed mixtures at their essential endpoint | No joint saturation claim for the product bound |
| All admissible kernels | Full spectrum for the stated phase-covariant product family | For the heterogeneous differential criterion require the stated finite-argument derivative hypothesis |

The spectrum and identical-family threshold are developed first, followed by the replacement-noise formula and heterogeneous classification.

## Weighted interpolation and a universal mean-alpha interval

The argument below proves a positive interval and a quantitative product estimate. It does not classify the entire reserved kernel class.

### Weighted complex spaces

For a faithful density matrix $\sigma$, let
$$
Q_{\alpha,\sigma}(X)
=\operatorname{Tr}X^\dagger\sigma^{-\alpha}X\sigma^{\alpha-1}
=\|\sigma^{-\alpha/2}X\sigma^{(\alpha-1)/2}\|_2^2,
\qquad0\le\alpha\le\tfrac12.
$$
Let $V_\sigma=\{X:\operatorname{Tr}X=0\}$, a complex vector space (the notation records its metric). For $\tau=E(\sigma)>0$, define
$$
\widehat\eta_\alpha(E,\sigma)
=\sup_{0\ne X\in V_\sigma}
\frac{Q_{\alpha,\tau}(E X)}{Q_{\alpha,\sigma}(X)}.
$$
On Hermitian matrices, $Q_{\alpha,\sigma}$ is exactly the chi-square metric with kernel
$$
\kappa_\alpha(x)=\tfrac12(x^{-\alpha}+x^{\alpha-1}).
$$
Thus $\eta_\alpha\le\widehat\eta_\alpha$. The equality is automatic at $\alpha=1/2$: the weighted transformation and the channel preserve Hermiticity, and writing $X=A+iB$ with Hermitian $A,B$ splits both squared norms additively. The trace-zero condition splits in the same way.

The map
$$
\Pi_\sigma(X)=X-\sigma\operatorname{Tr}X
$$
is the orthogonal projection onto $V_\sigma$ for **every** $Q_{\alpha,\sigma}$. Indeed, $\langle\sigma,X\rangle_{\alpha,\sigma}=\operatorname{Tr}X$ and $Q_{\alpha,\sigma}(\sigma)=1$. Consequently the squared norm of $T=E\Pi_\sigma$ on the full weighted complex spaces is exactly $\widehat\eta_\alpha$.

### Endpoint complex contraction

The endpoint $\alpha=0$ is contractive on all complex matrices. To verify this directly, write the weighted representative of $E$ on Hilbert--Schmidt space as
$$
T_0(X)=E(X\sigma^{1/2})\tau^{-1/2}.
$$
Its Hilbert--Schmidt adjoint is
$$
T_0^*(Y)=E^*(Y\tau^{-1/2})\sigma^{1/2}.
$$
The adjoint channel $E^*$ is unital and completely positive, so the Schwarz inequality gives
$$
\begin{aligned}
\|T_0^*(Y)\|_2^2
&=\operatorname{Tr}\sigma
E^*(Y\tau^{-1/2})^\dagger E^*(Y\tau^{-1/2})\\
&\le\operatorname{Tr}\sigma
E^*(\tau^{-1/2}Y^\dagger Y\tau^{-1/2})\\
&=\operatorname{Tr}\tau\tau^{-1/2}Y^\dagger Y\tau^{-1/2}
=\|Y\|_2^2.
\end{aligned}
$$
Hence $\|E\|_{Q_0\to Q_0}\le1$, and the orthogonal projection yields $\|E\Pi_\sigma\|_{Q_0\to Q_0}\le1$.

### Explicit complex interpolation

Put $r=\eta_{1/2}(E,\sigma)$. Assume initially $r>0$. On the strip $0\le\Re z\le1$, define the analytic operator family on Hilbert--Schmidt matrices
$$
F(z)(X)=\tau^{-z/4}
T\bigl(\sigma^{z/4}X\sigma^{1/2-z/4}\bigr)
\tau^{z/4-1/2}.
$$
All matrix powers are defined spectrally; finite dimensionality and faithfulness make $F$ analytic and uniformly bounded on the strip. On a vertical boundary, the imaginary powers multiply $F(0)$, respectively $F(1)$, on the left and right by Hilbert--Schmidt unitaries. Therefore
$$
\|F(it)\|\le1,\qquad
\|F(1+it)\|=\sqrt r
\quad(t\in\mathbb R).
$$
Applying the scalar three-lines theorem to $\langle Y,F(z)X\rangle$ for unit Hilbert--Schmidt vectors gives
$$
\|F(2\alpha)\|\le r^\alpha,
\qquad
\widehat\eta_\alpha(E,\sigma)\le r^{2\alpha}.
$$
The case $r=0$ means $E\Pi_\sigma=0$, so all coefficients vanish and can be handled directly. At $\alpha=0$, the displayed upper bound is interpreted as the endpoint contraction bound; the tensorization theorem below uses only $\alpha\ge1/3$.

### Petz reverse and the lower comparison

Let
$$
R(Y)=\sigma^{1/2}E^*(\tau^{-1/2}Y\tau^{-1/2})\sigma^{1/2}.
$$
It is CPTP, satisfies $R(\tau)=\sigma$, and is the adjoint of $E$ for the midpoint metric. Hence on trace-zero tangent spaces:

- $\eta_{1/2}(R,\tau)=r$.
- $RE$ is a positive self-adjoint operator for the midpoint inner product with largest eigenvalue $r$.
- It has a nonzero traceless Hermitian eigenvector with eigenvalue $r$: a complex eigenvector can be decomposed into Hermitian and anti-Hermitian parts, at least one of which is nonzero and remains an eigenvector.

Evaluating $RE$ on that eigenvector in **any** mean-alpha metric gives
$$
r^2\le\eta_\alpha(RE,\sigma)
\le\eta_\alpha(E,\sigma)\eta_\alpha(R,\tau)
\le\eta_\alpha(E,\sigma)r^{2\alpha}.
$$
Thus
$$
\boxed{\quad
r^{2(1-\alpha)}\le\eta_\alpha(E,\sigma)
\le\widehat\eta_\alpha(E,\sigma)\le r^{2\alpha}.
\quad}
$$
The lower inequality is independent of diagonalization of $E$ in the alpha metric; it uses a genuine eigenvector of $RE$, which avoids a nonnormality gap.

### Product decomposition and theorem

The full complex matrix space has the $Q_\alpha$-orthogonal decomposition
$$
\mathbb C\sigma_i\oplus V_{\sigma_i}.
$$
Because the unsymmetrized norm factors exactly,
$$
Q_{\alpha,\sigma_1\otimes\sigma_2}
=Q_{\alpha,\sigma_1}\otimes Q_{\alpha,\sigma_2}
$$
as Hilbert-space forms. The trace-zero space on the product therefore decomposes orthogonally as
$$
(V_{\sigma_1}\otimes\mathbb C\sigma_2)
\oplus(\mathbb C\sigma_1\otimes V_{\sigma_2})
\oplus(V_{\sigma_1}\otimes V_{\sigma_2}).
$$
All three projections preserve Hermiticity. For a Hermitian product tangent, the first two components have respective exact squared contraction constants $\eta_1,\eta_2$, where $\eta_i=\eta_\alpha(E_i,\sigma_i)$. The third component lies in the complex tensor product of trace-zero spaces, so its squared contraction is at most
$$
\widehat\eta_\alpha(E_1,\sigma_1)
\widehat\eta_\alpha(E_2,\sigma_2)
\le(r_1r_2)^{2\alpha}
\le(\eta_1\eta_2)^{\alpha/(1-\alpha)}.
$$
If $m=\max(\eta_1,\eta_2)$, then for $1/3\le\alpha\le1/2$,
$$
(\eta_1\eta_2)^{\alpha/(1-\alpha)}
\le m^{2\alpha/(1-\alpha)}\le m,
$$
since $0\le m\le1$ and $2\alpha/(1-\alpha)\ge1$. Orthogonality is preserved at the output because each channel maps its reference to the corresponding output reference and preserves trace. It follows that the total squared contraction is at most $m$. Embedding a maximizing one-factor tangent as $H_1\otimes\sigma_2$ or $\sigma_1\otimes H_2$ proves the reverse inequality.

Therefore, for every finite-dimensional CPTP pair and faithful references and outputs,
$$
\boxed{\eta_{\kappa_\alpha}(E_1\otimes E_2,\sigma_1\otimes\sigma_2)
=\max_i\eta_{\kappa_\alpha}(E_i,\sigma_i),
\qquad\alpha\in[1/3,1/2].}
$$
Induction gives any finite number of factors.


### Quantitative product estimate outside the positive interval

The same proof, before its final exponent comparison, gives for every $0<\alpha\le1/2$:
$$\max\{a,b\}\le\eta_\alpha(E_1\otimes E_2,\sigma_1\otimes\sigma_2)
\le\max\{a,b,(ab)^{\alpha/(1-\alpha)}\},$$
where $a,b$ are the two local physical coefficients. This inequality is an upper bound, not an assertion that its correlation term is attainable simultaneously with the local lower comparisons.


## Reciprocal transfer by the ordinary Petz reverse

### Setting

Let $E:M_d\to M_e$ be CPTP, let $\sigma>0$ be a density matrix, and assume $\tau=E(\sigma)>0$. All spaces are finite dimensional. For $\kappa\in\mathcal K$, put
$$
c_\kappa(a,b)=\frac{\kappa(a/b)}b,
\qquad
\Omega^\kappa_\sigma(E_{ij})=c_\kappa(s_i,s_j)E_{ij}
$$
in an eigenbasis $\sigma=\operatorname{diag}(s_i)$. The real tangent space is
$$
\mathsf H_0(d)=\{H\in M_d:H=H^\dagger,\operatorname{Tr}H=0\},
$$
with inner product $\langle H,K\rangle_{\kappa,\sigma}=\operatorname{Tr}H\Omega^\kappa_\sigma(K)$. The contraction coefficient is
$$
\eta_\kappa(E,\sigma)=\|E:\mathsf H_0(d)\to\mathsf H_0(e)\|_{\kappa,\sigma\to\kappa,\tau}^2.
$$
If a tangent space is zero-dimensional, use the convention that its induced contraction coefficient is zero.

Define
$$
\kappa^\dagger(x)=\frac1{x\kappa(x)}=\frac1{\kappa(x^{-1})},
\qquad
\Gamma_\sigma(X)=\sigma^{1/2}X\sigma^{1/2},
$$
and the ordinary Petz reverse
$$
R_{E,\sigma}=\Gamma_\sigma E^*\Gamma_\tau^{-1}.
$$
The Petz reverse is CPTP: complete positivity is immediate from the formula, while
$$
\operatorname{Tr}R(Y)
=\operatorname{Tr}\tau^{-1/2}Y\tau^{-1/2}E(\sigma)
=\operatorname{Tr}Y.
$$
Also $R(\tau)=\sigma$.

### Lemma 1: admissibility and involution

If $\kappa\in\mathcal K$, then $\kappa^\dagger\in\mathcal K$, and $(\kappa^\dagger)^\dagger=\kappa$.

**Proof.** Positivity and normalization are immediate. For positive definite matrices $A\le B$, inversion gives $A^{-1}\ge B^{-1}$. Since $\kappa$ is operator monotone decreasing,
$$
\kappa(A^{-1})\le\kappa(B^{-1}).
$$
Inverting once more yields
$$
[\kappa(A^{-1})]^{-1}\ge[\kappa(B^{-1})]^{-1}.
$$
Spectral functional calculus identifies these two sides with $\kappa^\dagger(A)$ and $\kappa^\dagger(B)$, so $\kappa^\dagger$ is operator monotone decreasing. The symmetry relation is
$$
x\kappa^\dagger(x)=\frac1{\kappa(x)}
=\kappa^\dagger(x^{-1}).
$$
Finally the pointwise formula gives the involution. $\square$

This is an elementary verification of HKPR's existing reciprocal operation, included to make the transfer proof self-contained.

### Lemma 2: a real tangent-space isometry

Set
$$
U_\sigma=\Gamma_\sigma\Omega^\kappa_\sigma.
$$
Then $U_\sigma$ restricts to a bijective real-linear isometry
$$
(\mathsf H_0(d),\langle\cdot,\cdot\rangle_{\kappa,\sigma})
\longrightarrow
(\mathsf H_0(d),\langle\cdot,\cdot\rangle_{\kappa^\dagger,\sigma}).
$$

**Proof.** In a $\sigma$-eigenbasis, $U_\sigma$ multiplies matrix entry $(i,j)$ by
$$
u_{ij}=\sqrt{s_is_j}\,c_\kappa(s_i,s_j).
$$
These numbers are positive, real, symmetric in $i,j$, and $u_{ii}=1$. Thus $U_\sigma$ is invertible and preserves Hermiticity and trace. Its inverse has the same preservation properties. Furthermore,
$$
c_{\kappa^\dagger}(a,b)
=\frac1{ab\,c_\kappa(a,b)}.
$$
Consequently
$$
u_{ij}^2c_{\kappa^\dagger}(s_i,s_j)=c_\kappa(s_i,s_j),
$$
which proves the norm equality entry by entry and the inner-product equality by real polarization. Equivalently,
$$
U_\sigma^*\Omega^{\kappa^\dagger}_\sigma U_\sigma
=\Omega^\kappa_\sigma.
$$
Here the star denotes the Hilbert--Schmidt adjoint. In fact $U_\sigma$ is Hilbert--Schmidt self-adjoint because it is a real Schur multiplier in this basis. $\square$

### Theorem: exact coefficient transfer

Under the assumptions above,
$$
\boxed{
\eta_\kappa(E,\sigma)
=\eta_{\kappa^\dagger}(R_{E,\sigma},\tau).
}
$$

**Proof.** The adjoint of $E$ in the $\kappa$-weighted Hilbert spaces is
$$
E^{\sharp,\kappa}
=(\Omega^\kappa_\sigma)^{-1}E^*\Omega^\kappa_\tau.
$$
It preserves Hermiticity because each factor does. It preserves trace as well: using $(\Omega^\kappa_\sigma)^{-1}(I)=\sigma$, self-adjointness of the weighting maps, and $\Omega^\kappa_\tau(\tau)=I$,
$$
\begin{aligned}
\operatorname{Tr}E^{\sharp,\kappa}(Y)
&=\operatorname{Tr}\sigma E^*(\Omega^\kappa_\tau Y)\\
&=\operatorname{Tr}\tau\Omega^\kappa_\tau(Y)
=\operatorname{Tr}Y.
\end{aligned}
$$
It therefore maps $\mathsf H_0(e)$ to $\mathsf H_0(d)$, and its restriction is the real Hilbert adjoint of the restriction of $E$. Complete positivity of $E^{\sharp,\kappa}$ is neither assumed nor needed.

The maps $\Gamma_\sigma$ and $\Omega^\kappa_\sigma$ commute, as do their inverses, because they are Schur multipliers in the same basis. Direct cancellation gives
$$
\begin{aligned}
U_\sigma E^{\sharp,\kappa}U_\tau^{-1}
&=\Gamma_\sigma\Omega^\kappa_\sigma
(\Omega^\kappa_\sigma)^{-1}E^*\Omega^\kappa_\tau
(\Omega^\kappa_\tau)^{-1}\Gamma_\tau^{-1}\\
&=\Gamma_\sigma E^*\Gamma_\tau^{-1}
=R_{E,\sigma}.
\end{aligned}
$$
By Lemma 2, the two $U$-maps are isometries between the respective real tangent spaces. Therefore
$$
\begin{aligned}
\eta_\kappa(E,\sigma)^{1/2}
&=\|E\|_{\kappa,\sigma\to\kappa,\tau}
=\|E^{\sharp,\kappa}\|_{\kappa,\tau\to\kappa,\sigma}\\
&=\|R_{E,\sigma}\|_{\kappa^\dagger,\tau\to\kappa^\dagger,\sigma}
=\eta_{\kappa^\dagger}(R_{E,\sigma},\tau)^{1/2}.
\end{aligned}
$$
Squaring proves the claim. Equality of a Hilbert-space operator norm and its adjoint norm holds for rectangular operators, so no equality of input and output dimensions is needed. $\square$

### Corollary: tensorization is invariant under reciprocal duality

For product channels and product references,
$$
R_{E_1\otimes E_2,\sigma_1\otimes\sigma_2}
=R_{E_1,\sigma_1}\otimes R_{E_2,\sigma_2}.
$$
This follows directly from the tensor factorization of $\Gamma$ and of the Hilbert--Schmidt adjoint. Consequently $\kappa$ has universal fixed-reference SDPI tensorization if and only if $\kappa^\dagger$ does. Indeed, apply the coefficient identity to the product and to the two factors, then use tensorization for the reversed channels. The reverse implication follows by the involution.

The correspondence is physical in both directions: the Petz reverse of $(R_{E,\sigma},\tau)$ is $E$. Explicitly,
$$
\Gamma_\tau R_{E,\sigma}^*\Gamma_\sigma^{-1}=E.
$$
Thus every counterexample for one kernel produces an actual CPTP counterexample for its reciprocal dual with exactly the same one-factor and product coefficients. In particular the known endpoint pair
$$
\frac{1+x^{-1}}2
\quad\longleftrightarrow\quad
\frac2{1+x}
$$
is covered, as is the prior-art Heinz/mean-alpha pairing
$$
\frac{x^{-\alpha}+x^{\alpha-1}}2
\quad\longleftrightarrow\quad
\frac2{x^\alpha+x^{1-\alpha}}.
$$


## Probability-mixture classes and exact fixed-midpoint envelopes

### 2. The probability-mixture class

Let $0<a_0\le1/2$, and let $\mu$ be a Borel probability measure supported on $[a_0,1/2]$. Define
$$
\kappa_\mu(x)=\int_{[a_0,1/2]}\kappa_\alpha(x)\,d\mu(\alpha).
\tag{2.1}
$$
The main positive result will use $a_0\ge1/3$.

#### Lemma 2.1: admissibility and the precise quadratic representation

The function $\kappa_\mu$ belongs to $\mathcal K$. For every faithful state $\sigma$ and Hermitian $H$,
$$
q_{\kappa_\mu,\sigma}(H)
=\int Q_{\alpha,\sigma}(H)\,d\mu(\alpha).
\tag{2.2}
$$

**Proof.** Each $\kappa_\alpha$ is positive, normalized at one, symmetric in the sense $x\kappa_\alpha(x)=\kappa_\alpha(x^{-1})$, and operator monotone decreasing. These properties pass to a probability integral. For the operator-order assertion, if $A\le B$ are positive definite matrices, integrate $\kappa_\alpha(A)\ge\kappa_\alpha(B)$; finite-dimensional spectral functional calculus commutes with the scalar integral. The metric operator depends linearly on $\kappa$, giving (2.2). All integrands are continuous in $\alpha$ on a compact interval and finite because $\sigma$ is faithful. $\square$

#### Lemma 2.2: common midpoint comparison for mixtures

For every channel and faithful input/output pair, with $r=\eta_{1/2}(E,\sigma)$,
$$
\boxed{\quad
r^{2(1-a_0)}\le\eta_{\kappa_\mu}(E,\sigma)\le r^{2a_0}.
\quad}
\tag{2.3}
$$

**Proof.** For a Hermitian trace-zero $H$, the comparison lemma gives
$$
Q_{\alpha,\tau}(EH)
\le r^{2\alpha}Q_{\alpha,\sigma}(H)
\le r^{2a_0}Q_{\alpha,\sigma}(H),
$$
because $r\in[0,1]$ and $\alpha\ge a_0$. Integrating proves the upper bound. Apply this upper bound to the Petz reverse $R$, whose midpoint coefficient is also $r$. The Hermitian trace-zero eigenvector of $RE$ with eigenvalue $r$ can be evaluated in the mixture metric, so
$$
r^2\le\eta_{\kappa_\mu}(RE,\sigma)
\le\eta_{\kappa_\mu}(E,\sigma)\eta_{\kappa_\mu}(R,\tau)
\le\eta_{\kappa_\mu}(E,\sigma)r^{2a_0}.
$$
For $r>0$, division gives the lower bound. The case $r=0$ was handled above. $\square$

#### Theorem 2.3: mixture product bound and universal tensorization

Let $E_i$ be finite-dimensional CPTP maps with faithful reference states $\sigma_i$ and faithful output states $\tau_i=E_i\sigma_i$. Put
$$
b_i=\eta_{\kappa_\mu}(E_i,\sigma_i).
$$
Then
$$
\max\{b_1,b_2\}
\le\eta_{\kappa_\mu}(E_1\otimes E_2,\sigma_1\otimes\sigma_2)
\le\max\left\{b_1,b_2,(b_1b_2)^{a_0/(1-a_0)}\right\}.
\tag{2.4}
$$
In particular, if $a_0\ge1/3$,
$$
\boxed{\quad
\eta_{\kappa_\mu}(E_1\otimes E_2,\sigma_1\otimes\sigma_2)
=\max\{b_1,b_2\}.
\quad}
\tag{2.5}
$$
The same identity holds for every finite number of factors.

**Proof.** Let $V_i=\{X:\operatorname{Tr}X=0\}$ as a complex vector space. For each $\alpha$,
$$
M_{d_i}=\mathbb C\sigma_i\oplus V_i
$$
is an orthogonal decomposition in $Q_{\alpha,\sigma_i}$. The unsymmetrized power metric factors:
$$
Q_{\alpha,\sigma_1\otimes\sigma_2}
=Q_{\alpha,\sigma_1}\otimes Q_{\alpha,\sigma_2}.
\tag{2.6}
$$
For a Hermitian trace-zero $H$ on the product, set
$$
A=\operatorname{Tr}_2H,\quad B=\operatorname{Tr}_1H,\quad
C=H-A\otimes\sigma_2-\sigma_1\otimes B.
$$
The three summands are Hermitian; $A,B$ are trace zero and both partial traces of $C$ vanish. Thus $C\in V_1\otimes V_2$. They are mutually orthogonal in every $Q_\alpha$, hence also in the integrated mixture metric. The channels map these three subspaces to the corresponding three orthogonal output subspaces.

The first two components have exact squared contraction bounds $b_1,b_2$. For the third, write $r_i=\eta_{1/2}(E_i,\sigma_i)$. The complex tensor-product operator norm and the comparison lemma imply, for each $\alpha$,
$$
\begin{aligned}
Q_{\alpha,\tau_1\otimes\tau_2}((E_1\otimes E_2)C)
&\le\widehat\eta_\alpha(E_1,\sigma_1)
\widehat\eta_\alpha(E_2,\sigma_2)
Q_{\alpha,\sigma_1\otimes\sigma_2}(C)\\
&\le(r_1r_2)^{2\alpha}
Q_{\alpha,\sigma_1\otimes\sigma_2}(C)\\
&\le(r_1r_2)^{2a_0}
Q_{\alpha,\sigma_1\otimes\sigma_2}(C).
\end{aligned}
\tag{2.7}
$$
Integrating gives the same bound for $q_{\kappa_\mu}$. The integration uses the **same** $\alpha$ on the two tensor factors:
$$
q_{\kappa_\mu,\sigma_1\otimes\sigma_2}(C)
=\int(Q_{\alpha,\sigma_1}\otimes Q_{\alpha,\sigma_2})(C)\,d\mu(\alpha).
\tag{2.8}
$$
It does **not** replace this by the tensor product of the two integrated forms. Such a replacement would generally be false and is not used.

By (2.3), $r_i^{2(1-a_0)}\le b_i$, hence
$$
(r_1r_2)^{2a_0}\le(b_1b_2)^{a_0/(1-a_0)}.
\tag{2.9}
$$
Orthogonality yields the upper bound in (2.4). Its lower bound follows by embedding a one-factor Hermitian maximizer as $A\otimes\sigma_2$ or $\sigma_1\otimes B$. If $m=\max(b_1,b_2)$ and $a_0\ge1/3$, then
$$
(b_1b_2)^{a_0/(1-a_0)}
\le m^{2a_0/(1-a_0)}\le m,
$$
which proves (2.5). Induction proves the finite-product statement. $\square$

### 3. Reciprocal-dual positive class

For an admissible kernel, define the existing reciprocal operation
$$
\kappa^\dagger(x)=\frac1{x\kappa(x)}.
$$
The independently proved real tangent-space transfer lemma is
$$
\eta_\kappa(E,\sigma)
=\eta_{\kappa^\dagger}(R_{E,\sigma},E\sigma).
\tag{3.1}
$$
It uses the isometry $U_\sigma=\Gamma_\sigma\Omega^\kappa_\sigma$, which preserves Hermiticity and trace, and satisfies
$$
U_\sigma E^{\sharp,\kappa}U_\tau^{-1}
=\Gamma_\sigma E^*\Gamma_\tau^{-1}=R_{E,\sigma}.
$$
No identification of the unsymmetrized complex $Q_\alpha$ norm with the symmetric complex $\kappa$-norm is involved. The admissibility and isometry proofs are given in the preceding reciprocal-transfer section.

#### Corollary 3.1

Every kernel
$$
\kappa_\mu^\dagger(x)
=\frac1{x\int\kappa_\alpha(x)\,d\mu(\alpha)},
\qquad\operatorname{supp}\mu\subseteq[1/3,1/2],
\tag{3.2}
$$
has universal fixed-reference tensorization. The common midpoint comparisons (2.3) and the product bound (2.4) also hold for $\kappa_\mu^\dagger$.

**Proof.** The Petz reverse of a product pair is the product of the individual Petz reverses, and each reverse has the same midpoint coefficient as its forward channel. Apply (3.1) to the product and factors, then apply Theorem 2.3 and Lemma 2.2 to the reversed channels. $\square$

This is the reciprocal **of the mixture**; it is generally not the mixture of the reciprocal kernels.

### 4. Explicit continuous example

Take the uniform probability distribution on $[1/3,1/2]$, with density six. Direct integration gives, for $x\ne1$,
$$
\boxed{\quad
\overline\kappa(x)
=6\int_{1/3}^{1/2}\frac{x^{-\alpha}+x^{\alpha-1}}2\,d\alpha
=\frac{3(x^{-1/3}-x^{-2/3})}{\log x}.
\quad}
\tag{4.1}
$$
The continuous value at $x=1$ is one. Its reciprocal dual is
$$
\boxed{\quad
\overline\kappa^\dagger(x)
=\frac{\log x}{3(x^{2/3}-x^{1/3})},\qquad
\overline\kappa^\dagger(1)=1.
\quad}
\tag{4.2}
$$
Both have universal fixed-reference tensorization by Theorem 2.3 and Corollary 3.1.

In logarithmic coordinates,
$$
\overline h(t)=e^{t/2}\overline\kappa(e^t)
=\frac{6\sinh(t/6)}t,\qquad
\overline h^\dagger(t)=\frac{t}{6\sinh(t/6)},
\tag{4.3}
$$
with continuous value one at zero. These formulas also make normalization and reciprocal pairing transparent. The claim is a tensorization property of these explicit kernels, not a claim that their scalar formulas were previously unknown.

### 5. Physical channels with a prescribed midpoint coefficient

Fix $r\in(0,1)$ and $t\in\mathbb R$. Put
$$
p_t=\frac{e^t}{1+e^t},\quad q_t=\frac1{1+e^t},\quad
Z_t=p_t+r^2q_t,\quad \lambda_t=\frac{r^2}{Z_t},\quad
\Delta=-2\log r>0.
\tag{5.1}
$$
Because $r^2<Z_t<1$, the number $\lambda_t$ belongs to $(r^2,1)$. Let $E_t$ be the amplitude-damping CPTP map with Kraus operators
$$
K_{0,t}=\begin{pmatrix}1&0\\0&\sqrt{\lambda_t}\end{pmatrix},\qquad
K_{1,t}=\sqrt{1-\lambda_t}\,|0\rangle\langle1|.
\tag{5.2}
$$
For the faithful reference $\sigma_t=\operatorname{diag}(p_t,q_t)$, its faithful output is
$$
\tau_t=E_t(\sigma_t)
=\operatorname{diag}\left(\frac{p_t}{Z_t},\frac{r^2q_t}{Z_t}\right).
\tag{5.3}
$$
Thus the log-odds shift is exactly
$$
\log\frac{p_t'}{q_t'}=t+\Delta.
\tag{5.4}
$$
The diagonal trace-zero squared contraction is $r^2$, and the midpoint coherence squared contraction is $r$. Therefore
$$
\boxed{\eta_{1/2}(E_t,\sigma_t)=r.}
\tag{5.5}
$$

The ordinary Petz reverse $R_t=R_{E_t,\sigma_t}$ has the explicit Kraus operators
$$
L_{0,t}=\begin{pmatrix}\sqrt{Z_t}&0\\0&1\end{pmatrix},\qquad
L_{1,t}=\sqrt{1-Z_t}\,|1\rangle\langle0|.
\tag{5.6}
$$
For example, $L_{j,t}=\sigma_t^{1/2}K_{j,t}^\dagger\tau_t^{-1/2}$. These Kraus operators satisfy $\sum_jL_{j,t}^\dagger L_{j,t}=I$, and $R_t(\tau_t)=\sigma_t$. Its diagonal and midpoint coherence contractions are again $r^2$ and $r$, so
$$
\boxed{\eta_{1/2}(R_t,\tau_t)=r.}
\tag{5.7}
$$
Every channel and reference in these sequences is finite dimensional and faithful; no singular reference is used at any finite $t$.

### 6. Exact mean-alpha coefficients, including the complex norm

Let $0\le\alpha\le1/2$ and $\beta=1/2-\alpha$. In the complex trace-zero space, the diagonal direction and the matrix units $E_{01},E_{10}$ are mutually orthogonal for $Q_\alpha$. Their squared contraction factors for $E_t$ are respectively
$$
r^2,\qquad r^{2\alpha},\qquad r^{2(1-\alpha)}.
\tag{6.1}
$$
For example, the $E_{01}$ factor is
$$
\lambda_t
\left(\frac{p_t'}{p_t}\right)^{-\alpha}
\left(\frac{q_t'}{q_t}\right)^{\alpha-1}
=\lambda_t Z_t r^{2\alpha-2}=r^{2\alpha}.
$$
For $R_t$, the two coherence factors in (6.1) are exchanged. Hence the complex interpolation upper bound is attained exactly:
$$
\boxed{\widehat\eta_\alpha(E_t,\sigma_t)
=\widehat\eta_\alpha(R_t,\tau_t)=r^{2\alpha}.}
\tag{6.2}
$$

On the Hermitian trace-zero space, both real and imaginary coherences have the symmetric factor
$$
F_\alpha(t)=r\frac{\cosh(\beta(t+\Delta))}{\cosh(\beta t)}
\tag{6.3}
$$
for $E_t$, while the reverse has
$$
G_\alpha(t)=r\frac{\cosh(\beta t)}{\cosh(\beta(t+\Delta))}
=\frac{r^2}{F_\alpha(t)}.
\tag{6.4}
$$
The elementary inequality
$$
e^{-\beta\Delta}\le
\frac{\cosh(\beta(t+\Delta))}{\cosh(\beta t)}
\le e^{\beta\Delta}
$$
shows both factors are at least $r^{2(1-\alpha)}\ge r^2$. Thus these are the **actual single-channel maxima**, not merely coherence lower bounds:
$$
\boxed{\eta_\alpha(E_t,\sigma_t)=F_\alpha(t),\qquad
\eta_\alpha(R_t,\tau_t)=G_\alpha(t).}
\tag{6.5}
$$

For $\alpha<1/2$, $F_\alpha(t)$ is strictly increasing in $t$, as follows from
$$
F_\alpha(t)=r\bigl[\cosh(\beta\Delta)
+\tanh(\beta t)\sinh(\beta\Delta)\bigr].
\tag{6.6}
$$
In particular, as $t\to+\infty$,
$$
F_\alpha(t)\longrightarrow r^{2\alpha},\qquad
G_\alpha(t)\longrightarrow r^{2(1-\alpha)}.
\tag{6.7}
$$

#### Exact convergence errors

Let $u=e^{-2\beta t}$ and $c=r^{4\beta}$. Then
$$
F_\alpha(t)=r^{2\alpha}\frac{1+cu}{1+u},\qquad
G_\alpha(t)=r^{2(1-\alpha)}\frac{1+u}{1+cu},
\tag{6.8}
$$
so
$$
r^{2\alpha}-F_\alpha(t)
=r^{2\alpha}(1-c)\frac{u}{1+u},
\tag{6.9}
$$
$$
G_\alpha(t)-r^{2(1-\alpha)}
=r^{2(1-\alpha)}(1-c)\frac{u}{1+cu}.
\tag{6.10}
$$
For fixed $r$ and $\alpha<1/2$, the approach is therefore exponential at rate $e^{-(1-2\alpha)t}$. At $\alpha=1/2$, both coefficients equal $r$ identically for every $t$.

### 7. Exact fixed-midpoint extremal envelopes

#### Theorem 7.1

Fix $r\in(0,1)$ and $0\le\alpha\le1/2$. Over all finite-dimensional CPTP maps $E$ and faithful references $\sigma,E\sigma$ satisfying $\eta_{1/2}(E,\sigma)=r$,
$$
\boxed{
\inf\eta_\alpha(E,\sigma)=r^{2(1-\alpha)},\qquad
\sup\eta_\alpha(E,\sigma)=r^{2\alpha}.
}
\tag{7.1}
$$
The supremum and infimum are both approached by the qubit families in the subsection “Physical channels with a prescribed midpoint coefficient”. Moreover,
$$
\sup\widehat\eta_\alpha(E,\sigma)=r^{2\alpha},
\tag{7.2}
$$
and this complex supremum is attained by every $(E_t,\sigma_t)$ in that family.

**Proof.** The universal comparison lemma supplies the lower and upper envelopes. Equations (5.5), (5.7), and (6.7) give sequences with exactly the prescribed midpoint coefficient approaching each envelope. Equation (6.2) gives exact complex attainment. $\square$

Consequently neither exponent in the comparison lemma can be strengthened uniformly: an upper exponent larger than $2\alpha$, or a lower exponent smaller than $2(1-\alpha)$, would contradict (7.1) at any fixed $0<r<1$. This is a statement about the two **individual one-channel bounds**. It gives no assertion that the correlation-sector product estimate and both local comparisons attain equality in the same configuration. In particular it does not prove the universal tensorization cutoff is $1/3$.

### 8. Exact envelopes for a fixed mixture: essential support

This subsection proves, rather than assumes, when the mixture comparison exponents are optimal. Let
$$
a_*:=\operatorname*{ess\,inf}_{\alpha\sim\mu}\alpha,
\qquad b_*:=1/2-a_*.
$$
The essential infimum refers to the fixed measure $\mu$; an arbitrarily chosen lower bound $a_0<a_*$ does not give sharp exponents.

For the logarithmic kernel of the mixture,
$$
H_\mu(t)=e^{t/2}\kappa_\mu(e^t)
=\int\cosh((1/2-\alpha)t)\,d\mu(\alpha).
\tag{8.1}
$$
The same qubit block calculation gives the exact coefficients
$$
\eta_{\kappa_\mu}(E_t,\sigma_t)
=r\frac{H_\mu(t+\Delta)}{H_\mu(t)},\qquad
\eta_{\kappa_\mu}(R_t,\tau_t)
=r\frac{H_\mu(t)}{H_\mu(t+\Delta)}.
\tag{8.2}
$$
To verify they dominate the diagonal value $r^2$, use
$e^{-b_*\Delta}\le H_\mu(t+\Delta)/H_\mu(t)\le e^{b_*\Delta}$; both factors in (8.2) are at least $r^{1+2b_*}=r^{2(1-a_*)}\ge r^2$.

#### Lemma 8.1: fixed-shift asymptotics of the mixture

For every fixed $\Delta>0$,
$$
\lim_{t\to+\infty}\frac{H_\mu(t+\Delta)}{H_\mu(t)}
=e^{b_*\Delta}.
\tag{8.3}
$$

**Proof.** Push $\mu$ forward under $\beta=1/2-\alpha$, obtaining a probability measure $\nu$ on $[0,b_*]$ with essential supremum $b_*$. If $b_*=0$, the claim is immediate. Otherwise introduce the tilted probability measure
$$
d\nu_t(\beta)=\frac{\cosh(\beta t)}{H_\mu(t)}d\nu(\beta).
$$
For $0<\varepsilon<b_*$, the set $[b_*-\varepsilon/2,b_*]$ has mass $m_\varepsilon>0$. For $t\ge0$,
$$
\nu_t([0,b_*-\varepsilon])
\le\frac{2}{m_\varepsilon}e^{-\varepsilon t/2}\longrightarrow0.
\tag{8.4}
$$
Thus $\nu_t$ concentrates at $b_*$. The ratio in (8.3) equals
$$
\int\frac{\cosh(\beta(t+\Delta))}{\cosh(\beta t)}\,d\nu_t(\beta).
$$
The integrand is bounded by $e^{b_*\Delta}$, and on any neighborhood $[b_*-\varepsilon,b_*]$ with $\varepsilon<b_*$, it converges uniformly to $e^{\beta\Delta}$. Combining this uniform convergence, (8.4), and continuity of $e^{\beta\Delta}$, then letting $\varepsilon\downarrow0$, proves (8.3). $\square$

#### Corollary 8.2

For a fixed mixture $\mu$ with $a_*>0$, the exact fixed-midpoint envelopes are
$$
\boxed{
\inf_{\eta_{1/2}=r}\eta_{\kappa_\mu}=r^{2(1-a_*)},\qquad
\sup_{\eta_{1/2}=r}\eta_{\kappa_\mu}=r^{2a_*}.
}
\tag{8.5}
$$
The same envelopes hold for its reciprocal dual. Indeed, (2.3) with $a_0=a_*$ supplies the bounds, and (8.2)--(8.3) supply physical qubit sequences approaching them. Reciprocal-Petz transfer exchanges the forward and reverse sequences for the dual kernel.

For the explicit uniform mixture, $a_*=1/3$, so these envelopes are $r^{4/3}$ and $r^{2/3}$. More quantitatively, for $t>0$,
$$
\eta_{\overline\kappa}(E_t,\sigma_t)
=r^{2/3}\frac{t}{t+\Delta}
\frac{1-e^{-(t+\Delta)/3}}{1-e^{-t/3}},
\tag{8.6}
$$
and the reverse coefficient is $r^2$ divided by (8.6). The continuous mixture approaches its upper and lower envelopes at order $1/t$; this slower rate is compatible with the exponential rates for a single atom because the continuum has weight arbitrarily close to, but no atom at, its extremal exponent.


## Complete product spectrum for phase-covariant qubit channels

This section gives the complete generalized spectrum for a specified physical qubit channel family, for any admissible kernel.

### Definitions

Let $\kappa\in\mathcal K$, and put
$$
c_\kappa(u,v)=v^{-1}\kappa(u/v),\qquad
h(t)=e^{t/2}\kappa(e^t).
$$
Thus $c_\kappa(u,v)=c_\kappa(v,u)$, $c_\kappa(ru,rv)=r^{-1}c_\kappa(u,v)$, and $h$ is even. For a faithful diagonal state $\sigma=\operatorname{diag}(s_x)$, write
$$
\|H\|_{\kappa,\sigma}^2=\sum_{x,y}c_\kappa(s_x,s_y)|H_{xy}|^2.
$$
The fixed-reference contraction coefficient is the squared induced norm on the real vector space of traceless Hermitian matrices. This tangent-space characterization is prior art (Cao--Lu 2019, Lemma 10).

For each $i=1,\dots,n$, assume a qubit CPTP map $E_i$ acts as
$$
E_i(\operatorname{diag}v)=\operatorname{diag}(M_iv),\qquad
E_i(|0\rangle\langle1|)=z_i|0\rangle\langle1|,
$$
where $M_i$ is a column-stochastic matrix. Hermiticity gives the conjugate action on $|1\rangle\langle0|$. Let
$$
\sigma_i=\operatorname{diag}(p_i,q_i),\quad
E_i(\sigma_i)=\operatorname{diag}(p_i',q_i'),\quad
p_i,q_i,p_i',q_i'>0,
$$
and define
$$
t_i=\log(p_i/q_i),\quad t_i'=\log(p_i'/q_i'),\quad
a_i=|z_i|^2\sqrt{\frac{p_iq_i}{p_i'q_i'}},\quad
d_i=(M_{i,00}-M_{i,01})^2\frac{p_iq_i}{p_i'q_i'}.
$$
Both $d_i$ and $a_i$ belong to $[0,1]$: $d_i$ is the binary classical chi-square coefficient; $a_i$ is the offdiagonal Rayleigh quotient for the geometric kernel $x^{-1/2}$, hence is bounded by metric data processing.

### Theorem: full generalized spectrum

For a nonempty subset $S\subseteq[n]$, let $C=[n]\setminus S$. Choose $\varepsilon\in\{-1,1\}^S$, identifying $\varepsilon$ and $-\varepsilon$. Define
$$
r_{S,\varepsilon}
=\left(\prod_{i\in S}a_i\right)
\frac{h(\sum_{i\in S}\varepsilon_it_i')}
{h(\sum_{i\in S}\varepsilon_it_i)}.
$$
The generalized spectrum of the output quadratic form relative to the input quadratic form on traceless Hermitian matrices is the following multiset:

1. In the diagonal sector: $\prod_{j\in J}d_j$ for every nonempty $J\subseteq[n]$, each once.
2. For each nonempty $S$, each orientation $\varepsilon$ modulo global sign, and each $J\subseteq C$:
   $$
   r_{S,\varepsilon}\prod_{j\in J}d_j,
   $$
   each twice, for real and imaginary coherence.

Repeated numerical eigenvalues retain the indicated multiplicities. In particular,
$$
\eta_\kappa\!\left(\bigotimes_iE_i,\bigotimes_i\sigma_i\right)
=\max\left\{\max_i d_i,
\max_{\varnothing\ne S\subseteq[n],\,\varepsilon\in\{-1,1\}^S}
r_{S,\varepsilon}\right\}.
$$

#### Proof

**Binary classical block.** Let $s_i=(p_i,q_i)^T$ and $s_i'=M_is_i$. The input and output Pearson quadratic forms are $v^TD_{s_i}^{-1}v$ and $v^TM_i^TD_{s_i'}^{-1}M_iv$. The direction $s_i$ has generalized eigenvalue one. Its input-metric orthogonal complement is $\{v:\boldsymbol1^Tv=0\}$, which is also orthogonal to the output reference after applying $M_i$. On this one-dimensional complement, $v=(u,-u)^T$ gives the generalized eigenvalue $d_i$. Tensoring these weighted classical matrices yields the eigenvalues $\prod_{j\in J}d_j$; the empty subset is precisely the reference direction and is removed by the trace-zero constraint.

**Offdiagonal blocks.** Fix nonempty $S$ and an orientation $\varepsilon$ modulo global sign. Let $u_i=0,v_i=1$ when $\varepsilon_i=1$, and $u_i=1,v_i=0$ when $\varepsilon_i=-1$. A Hermitian matrix supported on this coherence block is
$$
H(w)=\sum_{x\in\{0,1\}^{C}}
\bigl[w_x|u_S,x\rangle\langle v_S,x|
+\overline{w_x}|v_S,x\rangle\langle u_S,x|\bigr],
\qquad w\in\mathbb C^{2^{|C|}}.
$$
It is automatically traceless. Put
$$
A=\prod_{i\in S}s_i(u_i),\quad B=\prod_{i\in S}s_i(v_i),\quad
s_C(x)=\prod_{j\in C}s_j(x_j).
$$
By homogeneity of $c_\kappa$,
$$
\|H(w)\|_{\kappa,\otimes\sigma_i}^2
=2c_\kappa(A,B)\sum_x\frac{|w_x|^2}{s_C(x)}.
$$
The channel sends $w$ to
$$
Z\left(\bigotimes_{j\in C}M_j\right)w,\qquad
Z=\prod_{i\in S}\begin{cases}z_i,&\varepsilon_i=1,\\\overline{z_i},&\varepsilon_i=-1.\end{cases}
$$
The output metric has the same expression with $A',B',s_C'$. Consequently its generalized spectrum on this block is
$$
|Z|^2\frac{c_\kappa(A',B')}{c_\kappa(A,B)}
\prod_{j\in J}d_j,
\qquad J\subseteq C,
$$
each twice. Multiplication by the complex scalar $Z$ merely rotates and scales the real and imaginary copies, so its phase cannot affect the spectrum. Since $AB=\prod_{i\in S}p_iq_i$ and $\log(A/B)=\sum_{i\in S}\varepsilon_it_i$, the prefactor equals $r_{S,\varepsilon}$.

**Completeness.** Blocks are mutually orthogonal for both quadratic forms because they have disjoint matrix-entry support, and the channel preserves each support. For fixed $S\ne\varnothing$, the total real dimension is
$$
2^{|S|-1}\cdot2\cdot2^{n-|S|}=2^n.
$$
Summing over nonempty $S$ gives $4^n-2^n$. Adding the diagonal trace-zero dimension $2^n-1$ gives $4^n-1$, exactly the entire real tangent-space dimension. Thus no generalized eigenvalues are omitted. Taking the maximum and using $0\le d_j\le1$ proves the coefficient formula. $\square$

### Identical factors

If all factors are identical, write $a,d,t,t'$. For $n=1$,
$$
\eta_\kappa(E,\sigma)=\max\{d,a h(t')/h(t)\}.
$$
For $n\ge2$,
$$
\eta_\kappa(E^{\otimes n},\sigma^{\otimes n})
=\max\left\{d,a^2,\max_{1\le k\le n}a^k\frac{h(kt')}{h(kt)}\right\}.
$$
Indeed, a block with $|S|=k$ and signed sum $m=|\sum_{i\in S}\varepsilon_i|$ contributes $a^kh(mt')/h(mt)$. For $m\ge1$, parity forces $k\ge m$, and $a\le1$ shows this is dominated by the all-aligned block of size $m$. For $m=0$, the smallest admissible size is two and the largest value is $a^2$. This argument also covers $a=0$ without cancellation.

### Amplitude damping specialization

Let $\delta=1-\gamma$, $M=\left(\begin{smallmatrix}1&\gamma\\0&\delta\end{smallmatrix}\right)$, and $z=\sqrt\delta$. Then $p'=p+\gamma q$, $q'=\delta q$,
$$
a=\sqrt{\frac{\delta p}{p'}},\qquad d=\frac{\delta p}{p'}=a^2.
$$
Hence, for every $n\ge1$,
$$
\eta_\kappa(E_\gamma^{\otimes n},\sigma^{\otimes n})
=\max\left\{d,\max_{1\le k\le n}d^{k/2}\frac{h(kt')}{h(kt)}\right\}.
$$
For $\kappa(x)=(x^{-\alpha}+x^{\alpha-1})/2$, one has $h(t)=\cosh((1/2-\alpha)t)$, giving the exact finite-copy coefficient for the entire mean-alpha family. This is stronger than a lower-bound witness, but is confined to the specified channel family.


## The sharp identical-amplitude-damping threshold

This note concerns a restricted channel family, not the universal classification
of all kernels and all CPTP maps in the registered problem. The established
midpoint theorem and Cao's endpoint construction are prior work. The scalar
classification below concerns the restricted channel family only; its independent
review and bounded novelty assessment are preserved with this manuscript.

### 1. Parameters and the local spectrum

Let

$$
 \sigma_t=\operatorname{diag}(p,q),\qquad
 p=\frac{e^t}{1+e^t},\quad q=\frac1{1+e^t},\quad t\in\mathbb R.
$$

Amplitude damping with parameter $0<\gamma<1$ has Kraus matrices
$K_0=\operatorname{diag}(1,\sqrt{1-\gamma})$ and
$K_1=\sqrt\gamma\,|0\rangle\langle1|$. Its output is
$\sigma_{t'}$, where

$$
q'=(1-\gamma)q,\qquad p'=1-q',\qquad t'>t.
$$

Conversely every finite real pair $t<t'$ is realized by
$\gamma=1-(1+e^t)/(1+e^{t'})$, so all references and outputs remain faithful.

For $\alpha\in[0,1/2]$, put $\beta=1/2-\alpha$. The metric weight is

$$
w_\alpha(a,b)=\frac{\kappa_\alpha(a/b)}{b}
 =(ab)^{-1/2}\cosh\!\left(\beta\log\frac ab\right).
$$

Write $\Delta=t'-t>0$ and $a=e^{-\Delta/2}$. The local diagonal
eigenvalue and the two equal transverse eigenvalues are

$$
d=(1-\gamma)^2\frac{pq}{p'q'}=e^{-\Delta}=a^2,
\qquad
r_1=(1-\gamma)\frac{w_\alpha(p',q')}{w_\alpha(p,q)}
=a\frac{\cosh(\beta t')}{\cosh(\beta t)}.
$$

Because $|(\log\cosh(\beta x))'|\le\beta\le1/2$,
$\log r_1\ge-\Delta$, hence $r_1\ge d$. This proves the local SDPI
coefficient is exactly $r_1$, including negative $t$, zero $t$,
and intervals crossing zero. Also $r_1\le1$.

### 2. Tensor sectors and the complete coefficient for n identical factors

Fix $n\ge1$. Matrix units of a tensor product split according to the set
of positions where the row and column labels differ, and to their ordered
orientation in those positions. Let $k$ be the number of differing
positions. Their orientations sum to an integer $m$ with
$|m|\le k$ and $m\equiv k\pmod 2$.

For $k\ge1$, amplitude damping multiplies all those coherent positions by
$(\sqrt{1-\gamma})^k$, and acts on the remaining diagonal positions by the
ordinary two-state stochastic transition. The product reference metric on
this sector factors as a scalar weight times the classical inverse-probability
metric on the spectator coordinates. Therefore the largest generalized
eigenvalue in the sector is

$$
r_{k,m}=a^k\frac{\cosh(\beta m t')}{\cosh(\beta m t)}.
\tag{1}
$$

More fully, the spectator eigenvalues multiply (1) by $d^j$,
$0\le j\le n-k$. The top spectator eigenvalue is one, attained by its
reference probability vector. A coherent sector and its transpose pair into
real and imaginary Hermitian sectors with the same eigenvalues; all such
matrices are traceless. Thus the maximum in (1) is attained by an admissible
Hermitian tangent, not only by a non-Hermitian matrix unit.

The purely diagonal sector is classical. Its nonconstant eigenvalues are
$d^j$, $1\le j\le n$, and its largest traceless value is $d$.
No matrix-unit sector is omitted: each pair of binary words either agrees
everywhere, or has a unique nonempty difference set and orientation.

Set

$$
r_k=a^k\frac{\cosh(k\beta t')}{\cosh(k\beta t)}.
\tag{2}
$$

If $|t'|\ge|t|$, the ratio $\cosh(x|t'|)/\cosh(x|t|)$
is nondecreasing for $x\ge0$. To see this, differentiate its logarithm
and use that $y\mapsto y\tanh(xy)$ is nondecreasing on $y\ge0$.
Hence $r_{k,m}\le r_k$.

If $|t'|<|t|$, every ratio in (1) is at most one. Consequently every
$k\ge2$ sector is at most $a^k\le a^2=d\le r_1$; the $k=1$
sectors equal $r_1$. This covers the entire negative-t and sign-crossing
range, including the possible balanced orientations $m=0$.

It follows in both cases that

$$
\boxed{\eta_{\kappa_\alpha}(E_\gamma^{\otimes n},\sigma_t^{\otimes n})
 =\max_{1\le k\le n} r_k.}
\tag{3}
$$

For example, the value $r_k$ is realized in the k coherent positions by
$|0^k\rangle\langle1^k|+|1^k\rangle\langle0^k|$, tensored with reference
states in all other positions. Equation (3) describes this channel family
only. It does not assert the same formula for arbitrary kernel functions or
arbitrary channels.

### 3. A one-variable criterion for activation of coherence order k

For $k\ge2$, comparison with the local coefficient is

$$
\frac{r_k}{r_1}
=\frac{F_{k,\beta}(t')}{F_{k,\beta}(t)},\qquad
F_{k,\beta}(t)=e^{-(k-1)t/2}
\frac{\cosh(k\beta t)}{\cosh(\beta t)}.
$$

For $\beta>0$,

$$
 (\log F_{k,\beta})'(t)
 =-\frac{k-1}{2}+\beta g_k(\beta t),\qquad
 g_k(u)=k\tanh(ku)-\tanh u.
\tag{4}
$$

The function $g_k$ is odd. For $u>0$, it has a unique maximum at the
unique positive solution $u_k$ of

$$
\cosh(k u_k)=k\cosh u_k.
\tag{5}
$$

Indeed, $g'_k(u)=k^2\operatorname{sech}^2(ku)-\operatorname{sech}^2u$.
The ratio $\cosh(ku)/\cosh u$ increases strictly from one to infinity
for $u>0$, because its logarithmic derivative $g_k(u)>0$.
Thus the derivative changes sign exactly once. Define

$$
M_k=g_k(u_k),\qquad
\alpha_c(k)=\frac12-\frac{k-1}{2M_k}.
\tag{6}
$$

Since $g_k(u)\to k-1$ at infinity and first decreases strictly after
its unique maximum, $M_k>k-1$. Therefore $0<\alpha_c(k)<1/2$.

Equation (4) proves, with no asymptotic or numerical step:

- If $\alpha\ge\alpha_c(k)$, then $F_{k,\beta}$ is nonincreasing
  on the full real line, so $r_k\le r_1$ for every $t<t'$.
- If $0\le\alpha<\alpha_c(k)$, then the derivative in (4) is positive
  at $t=u_k/\beta$. A finite interval $t<t'$ with
  $F_{k,\beta}(t')>F_{k,\beta}(t)$ yields a faithful k-copy channel
  counterexample.
- At the equality threshold, the derivative only vanishes at an isolated
  point and never becomes positive. The threshold itself is not a failure.
- For $\beta=0$, all $r_k=a^k$, recovering the known midpoint result.

### 4. The largest threshold is exactly the two-copy threshold

Extend $k$ continuously to $k>1$. Equation (5) has a smooth positive
solution since its u-derivative at the root is
$k[\sinh(ku_k)-\sinh u_k]>0$. The envelope theorem applied to the
unique maximum of $g_k$ gives

$$
\frac{d}{dk}\frac{M_k}{k-1}
=\frac{-\tanh(ku_k)+\tanh u_k+
 k(k-1)u_k\operatorname{sech}^2(ku_k)}{(k-1)^2}.
$$

At (5),

$$
\operatorname{sech}^2(ku_k)=\frac{\operatorname{sech}^2u_k}{k^2},
\quad
\tanh(ku_k)-\tanh u_k
=\frac{\operatorname{sech}^2u_k}{k}\sinh((k-1)u_k).
$$

Substitution yields the explicit strict sign:

$$
\boxed{
\frac{d}{dk}\frac{M_k}{k-1}
=\frac{\operatorname{sech}^2u_k}{k(k-1)^2}
\big((k-1)u_k-\sinh((k-1)u_k)\big)<0.}
\tag{7}
$$

Thus $\alpha_c(k)$ strictly decreases for $k>1$. Also
$k-1<M_k<k$ implies $\alpha_c(k)\to0$.

For $k=2$, set $z=\tanh u$. Then

$$
 g_2(u)=\frac{z(3-z^2)}{1+z^2},\qquad
 \frac{d}{dz}\frac{z(3-z^2)}{1+z^2}
=\frac{3-6z^2-z^4}{(1+z^2)^2}.
$$

The unique positive critical point is $z^2=2\sqrt3-3$, giving

$$
M_2=\sqrt{6\sqrt3-9},\qquad
\boxed{\alpha_c=\frac12-\frac1{2\sqrt{6\sqrt3-9}}.}
\tag{8}
$$

Combining (3), (6), and (7): for every $n\ge2$, universal exact
tensorization within the identical-amplitude-damping/diagonal-reference
family holds if and only if $\alpha\in[\alpha_c,1/2]$. For each
$\alpha<\alpha_c$, two copies already furnish a counterexample;
additional copies do not enlarge the excluded alpha interval in this family.

### 5. An explicit finite witness below the threshold

For $0\le\alpha<\alpha_c$, let

$$
\beta=\frac12-\alpha,\quad
u_*=\operatorname{artanh}\sqrt{2\sqrt3-3},\quad
\varepsilon=\beta M_2-\frac12>0,
\quad t=\frac{u_*}{\beta},\quad
\delta=\frac{\varepsilon}{10\beta^2},\quad t'=t+\delta.
$$

The second derivative of $\log F_{2,\beta}$ has absolute value at most
$5\beta^2$, since it equals
$\beta^2[4\operatorname{sech}^2(2\beta t)-\operatorname{sech}^2(\beta t)]$.
The first derivative is $\varepsilon$ at $t=u_*/\beta$, so it remains
at least $\varepsilon/2$ throughout $[t,t']$. Therefore

$$
\log\frac{r_2}{r_1}
\ge\frac{\varepsilon^2}{20\beta^2}>0.
$$

Use $\sigma_t$ and
$\gamma=1-(1+e^t)/(1+e^{t'})$. This is an explicit pair of qubit
channels with faithful references and a certified strict Rayleigh gap.

To turn the tangent into an actual state, set
$H=|00\rangle\langle11|+|11\rangle\langle00|$ and
$\rho=\sigma_t^{\otimes2}+(pq/2)H$. The nontrivial 2-by-2 principal
block has diagonal entries $p^2,q^2$ and determinant
$3p^2q^2/4>0$; its other diagonal entries are $pq>0$. Thus
$\rho$ is a faithful density matrix different from the reference, and
its divergence ratio is exactly $r_2>r_1$. For a k-coherence witness,
the same argument uses the perturbation coefficient $(pq)^{k/2}/2$.

### 6. Endpoint amplification and scope

At $\alpha=0$, for any fixed $0<t<t'$, formula (2) simplifies to

$$
r_k=\frac{1+e^{-k t'}}{1+e^{-k t}}\longrightarrow1.
$$

For each finite $k$, $r_k<1$, while the one-copy coefficient
$r_1<1$ stays fixed. Equation (3) hence implies the n-copy coefficient
converges to one. This need not mean $r_k$ is monotone in $k$; (3)
uses a maximum over all available coherence orders.

For $\alpha>0$, the same positive t interval has
$r_k\sim e^{-\alpha k(t'-t)}$, so these individual coherent sectors
decay. The maximum in (3) is attained at a finite coherence order over the
infinite-copy union. This fact does not imply universal tensorization for
arbitrary CPTP maps at those alpha values.

The corresponding reverse-amplitude SLD endpoint construction can also
approach one, but is a separate kernel/channel statement. Neither endpoint
behavior closes the registered full-K criterion.

## Exact minimal-kernel certificate

For $\kappa_{\min}(x)=2/(1+x)$, take
$$\sigma=\operatorname{diag}(9/10,1/10),\quad
K_0=\operatorname{diag}(\sqrt{8/9},1),\quad
K_1=\tfrac13|1\rangle\langle0|.$$
Then $\sum_jK_j^\dagger K_j=I$ and $E(\sigma)=\operatorname{diag}(4/5,1/5)$. The single-copy spectrum is $4/9,8/9,8/9$. The complete two-copy traceless Hermitian generalized spectrum is
$$16/81\ (1),\quad32/81\ (4),\quad4/9\ (4),\quad8/9\ (4),\quad1312/1377\ (2),$$
where parentheses give multiplicities. Thus the exact gap is $1312/1377-8/9=88/1377>0$. This follows either from the product-spectrum theorem or by the exact characteristic-polynomial calculation in `code/exact_minimum_witness.py`. The witness is $|00\rangle\langle11|+|11\rangle\langle00|$; adding $(pq/2)$ times this witness to $\sigma^{\otimes2}$ gives a faithful density matrix because the nontrivial two-by-two determinant becomes $3p^2q^2/4>0$. This finite certificate does not establish general kernel necessity. A transfer from known endpoint examples through reciprocal recovery duality must be considered before claiming independent novelty.

## Exact two-copy region under replacement noise

Keep the minimal-kernel channel, its input $\sigma$ and output $\tau=E(\sigma)$. Write $a=8/9$, $b=1312/1377$. Let $R(X)=\operatorname{Tr}(X)\tau$, $E_i=s_i E+(1-s_i)R$ with $0\le s_i\le1$. The exact coefficient of $E_1\otimes E_2$ at $\sigma^{\otimes2}$ is
$$
 \max\{a s_1^2,\ a s_2^2,\ b s_1^2s_2^2\}.
$$
On each tangent leg the replacement map vanishes, whereas on the reference it returns $\tau$. Thus the non-reference local directions in the phase-covariant spectrum acquire the factor $s_i^2$. In the original spectrum, the largest one-active-leg value is $a$ and the largest two-active-leg value is $b$. This proves the formula for the entire coefficient. In particular the selfadjoint double-coherence witness $|00\rangle\langle11|+|11\rangle\langle00|$ has both partial traces zero and attains the two-active-leg value for every choice of noise. Its reference-state perturbation from the preceding section remains faithful. There is strict failure exactly when $\min_i s_i^2>153/164$, with the no-transmission endpoints included in the coefficient formula. For $s_i=1-t$ this means $0\le t<1-\sqrt{153/164}$. The previous literature gives a mean-alpha parameter neighborhood of failure around an endpoint; the present formula determines the replacement-noise region for this particular channel, reference and kernel. [Cao v2, Proposition 2 and Corollary 3](https://arxiv.org/pdf/2608.13204v2)

## Heterogeneous differential test for phase-covariant qubits

Let $\kappa$ be a normalized symmetric quantum monotone metric kernel as in the opening definitions. Set $h(t)=e^{t/2}\kappa(e^t)$, $f=\log h$, an even smooth function. Suppose $|f'|<1/2$ at finite arguments. A non-strict global Lipschitz bound of $1/2$ follows already from monotonicity of $\kappa$ and the same property at the reciprocal argument. Consider all qubit channels preserving diagonal matrices in a choice of input and output eigenbases of their respective faithful references and sending $E_{01}$ to a complex scalar times $E_{01}$ in those bases. Either basis labeling may be reversed in the model. The finite terms below include the asymmetric case of different reference odds, different damping, additional dephasing, and opposite directions of population flow.

### The differential criterion

Tensorization holds for *every finite list* of such channels and references if and only if, for all $x,y\in\mathbb R$ and independently chosen $s,t\in\{-1,1\}$,
$$
 \frac{1/2-s f'(x+y)}{1/2-s f'(x)}
 +\frac{1/2-t f'(x+y)}{1/2-t f'(y)}\ \ge1. \tag{H}
$$
Every strict failure yields a two-qubit counterexample made of arbitrarily weak amplitude dampings with faithful input and output references. Thus (H) is also necessary for tensorization over unrestricted finite quantum channels.

**Proof.** For a single leg with reference pairs $(p,q)$ and $(p',q')$, take $x=\log(p/q)$ and $x'=\log(p'/q')$. Its coherence factor is $A=a h(x')/h(x)$, with $a=|z|^2\sqrt{pq/(p'q')}$ and $z$ its coherence amplitude. Complete positivity gives $|z|^2\le M_{00}M_{11}$ from the two-by-two principal Choi block. Positivity of the column-stochastic $M$ gives $M_{00}\le\min(1,p'/p)$ and $M_{11}\le\min(1,q'/q)$. Since the two log mass ratios have opposite signs or are both zero, this gives $a\le e^{-|x'-x|/2}$. This maximum is attained for every pair $x,x'$ by amplitude damping toward the increasing-mass level; its diagonal contraction is $e^{-|x'-x|}$, no larger than $A$ by the Lipschitz bound. The two-copy coherence value for orientations fixed positive (other signs absorbed by flipping both odds of a leg) is $a_1a_2 h(x'+y')/h(x+y)$. This follows directly by applying the channel to the Hermitian double matrix unit. More generally a product coherence is given by the same expression with any subset of oriented legs. The complete qubit spectrum proved above shows all other multipliers on a coherence are classical diagonal contractions at most one; purely diagonal sectors tensorize in the classical sense.

For maximal-transmission legs define the positive loss along an oriented segment by
$$
 L(x,x')=|x'-x|/2-[f(x')-f(x)].
$$
The joint loss is $(|x'-x|+|y'-y|)/2-[f(x'+y')-f(x+y)]$. Parameterize the two paths so that each single-leg loss increases at unit rate, hence the speeds are $s/(1/2-s f'(x))$ and $t/(1/2-t f'(y))$. Strict finite-argument bounds justify the parameterization on every compact segment. While both move, the joint loss grows at exactly the left side of (H). Freeze the first leg to finish and move the other to its endpoint; in this remaining time the joint loss is nondecreasing by the Lipschitz bound. Thus the joint loss is at least the lesser single loss, including a trivial zero-length leg. Exponentiation bounds the joint coherence by the larger single coherence. Conversely, a strict violation persists on a short equal-loss path by continuity, giving exactly the claimed physical contradiction. If a leg transmits only a fraction $\nu_i\le1$ of its maximal $a_i$, multiply the joint bound by $\nu_1\nu_2$; it stays below $\max_i \nu_i A_i$ with $A_i$ the maximal-transmission value.

To induct, treat a group of legs as a virtual leg with initial and final odds the oriented sums and multiplicative coefficient $\prod a_i$. This is at most $e^{-|\sum\Delta_i|/2}$ by the triangle inequality, so the two-leg argument applies exactly as for an attenuated leg. Induction gives every subset bound. Embedding a maximizing single tangent tensored with the other references proves the matching lower bound for the whole product coefficient. No realizability assumption on the virtual leg's diagonal sector is needed.

### The exact heterogeneous mean-alpha threshold

For $\kappa_\alpha(x)=(x^{-\alpha}+x^{\alpha-1})/2,\ 0\le\alpha\le1/2$, every such heterogeneous product tensorizes exactly iff
$$
 \alpha\ \ge\ \tfrac12-\frac1{2\sqrt{6\sqrt3-9}} .
$$
To prove this, $f(t)=\log\cosh(\beta t)$, $\beta=1/2-\alpha$, and put $b=2\beta$. The case $b=0$ is immediate. Since $f'$ is increasing, when $x,y\ge0$ both fractions in (H) are minimized with positive signs. When $x\ge0\ge y$, the worst signs are negative for the first and positive for the second; their sum is at least $2/(1+b)$, by replacing both denominators, after multiplication by 2, by $1+b$. Symmetry deals with the other signs of $x,y$. In the positive quadrant let $A=\tanh(\beta x), B=\tanh(\beta y)$. Clearing positive denominators with $\tanh(\beta(x+y))=(A+B)/(1+AB)$, (H) becomes
$$
 1+AB-2b(A+B)+b^2(A^2+B^2+AB-A^2B^2)\ge0.
$$
For fixed $m=(A+B)/2$, this polynomial is concave in $((A-B)/2)^2$, since its quadratic coefficient is $-b^2$. The lower endpoint is the diagonal, and the other endpoint has $A$ or $B$ zero or one. At $A=0$ the polynomial equals $(1-bB)^2$, at $A=1$ it equals $(1+B)(1-b)^2$. On the diagonal the condition is $b\max_{0\le A\le1}[4A/(1+A^2)-A]\le1$ by the original fractions. Setting the derivative to zero gives $A^2=-3+2\sqrt3$ and maximum $\sqrt{6\sqrt3-9}$. All finite-argument denominators are positive even at $b=1$. The boundary values $A=1$ or $B=1$ are used through continuity of the cleared polynomial. Thus heterogeneous and oppositely directed channels cannot lower the activation threshold below that detected by identical dampings, despite the unrestricted reference odds and transmissions.

### Closest results and the open universal interval

Cao–Lu Theorem 1 and George–Tomamichel Corollary 63 prove tensorization at the geometric midpoint. Cao v2 Proposition 2 and Corollary 3 give endpoint and nearby mean-alpha counterexamples using amplitude damping. The identical-channel threshold above already gives the numerical value displayed here. The new claim is that every heterogeneous finite phase-covariant product, with independently chosen faithful references and coherence orientations, obeys the same sharp transition. The differential test applies beyond the mean-alpha family under its derivative hypothesis. For unrestricted CPTP channels the test is a necessary condition, and the interval between the phase-covariant threshold and the universal sufficient endpoint $1/3$ remains open. [Cao–Lu, Theorem 1](https://quantum-journal.org/papers/q-2019-10-28-199/pdf/) · [George–Tomamichel, Corollary 63](https://arxiv.org/pdf/2505.15281v3#page=38) · [Cao v2](https://arxiv.org/pdf/2608.13204v2)

## Reproducibility

The exact rational witness follows from the complete tangent spectrum or the characteristic polynomial in the original computational appendix. The amplitude-threshold certificate checks finite symbolic identities and constructs four scalar witnesses. Other finite scans diagnose proposed inequalities with complete tangent eigensolves. The analytical arguments establish the universal quantifiers, and the numerical scans supplement them. See the original reproduction notes for command and package details. Lean verification is delivered separately. [Original reproduction notes](evidence/README.md)

## References

- [S1] Yu Cao and Jianfeng Lu, *Tensorization of the strong data processing inequality for quantum chi-square divergences*, Quantum 3, 199 (2019). DOI: [10.22331/q-2019-10-28-199](https://doi.org/10.22331/q-2019-10-28-199). Full text: [publisher PDF](https://quantum-journal.org/papers/q-2019-10-28-199/pdf/).
- [S2] Yu Cao, *Counterexamples to the Tensorization Property of Strong Data Processing Inequalities for Quantum Divergences*, [arXiv:2608.13204v2](https://arxiv.org/abs/2608.13204v2), revised 28 October 2026. The endpoint counterexample and its neighborhood are prior work.
- [S3] Fumio Hiai, Hideki Kosaki, Dénes Petz and Mary Beth Ruskai, *Families of completely positive maps associated with monotone metrics*, Linear Algebra and its Applications (2013), DOI: [10.1016/j.laa.2013.05.012](https://doi.org/10.1016/j.laa.2013.05.012); [arXiv:1212.1337v3](https://arxiv.org/abs/1212.1337v3).
- [S4] Ian George and Marco Tomamichel, *A Unified Approach to Quantum Contraction and Correlation Coefficients*, [arXiv:2505.15281v3](https://arxiv.org/abs/2505.15281v3), revised 29 March 2026. In particular Lemmas 54 and 56, Theorem 61, Corollary 63, and Section V.C.
- [S5] Christoph Hirche, Cambyse Rouzé and Daniel Stilck França, *On contraction coefficients, partial orders and approximation of capacities for quantum channels*, Quantum (2022); [arXiv:2011.05949v4](https://arxiv.org/abs/2011.05949v4). Proposition 5.4 is nearby interpolation/recovery methodology, not the tensorization theorem stated here.
- [S6] Li Gao and Lijun Wang, *Quantum Entropy Contraction and Factorization from Hypercontractivity*, [arXiv:2609.20753v2](https://arxiv.org/abs/2609.20753v2), revised 5 October 2026. Adjacent work on entropy and approximate factorization, not a claimed premise of the present proof.
