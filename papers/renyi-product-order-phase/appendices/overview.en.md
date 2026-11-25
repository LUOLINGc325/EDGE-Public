---
title: "Rényi contraction of repeated symmetric channels"
subtitle: "Sharp constants, optimal priors, and order-dependent phase transitions"
author: "Research manuscript"
date: "25 November 2026"
lang: en
fontsize: 10pt
geometry: margin=24mm
toc: true
numbersections: false
colorlinks: true
---

# Abstract

We determine sharp asymptotics of the distribution-independent Rényi divergence contraction coefficient of a finite, strictly positive, nonconstant binary-input output-symmetric channel under repeated independent use. An existing support-reduction theorem reduces the channel optimization to a binary-mixture likelihood-ratio functional. Our contribution is the global optimization of that functional, including prior weights approaching either boundary at arbitrary speeds.

For fixed finite orders \(\alpha\ge2\), the deficit has a sharp \(n^{-1/2}e^{-nC}\) asymptotic. In the nonarithmetic case every optimal binary-mixture prior converges to the same number \(q_*=0.2031878699\ldots\), independently of the channel and the order. Arithmetic laws instead require an explicit periodic sum. For exponentially growing order, the asymptotic changes at the KL divergence and at the maximum log-likelihood ratio. We obtain tilted sharp constants below KL, a Gaussian variational limit in its critical window, an inverse-Rényi constant above KL, a Lambert \(W\) expression at the maximum-likelihood endpoint, and saturation of the infinite-order value above that endpoint.

All optimization statements include proofs excluding escaping parameters. The analytic statements are classical proofs; the accompanying Lean supplement verifies explicitly delimited algebraic ingredients only. Internal review is not external peer review or certification of global priority.

# Problem and attribution

Let \(K:\{0,1\}\to\mathcal Y\) have finite output alphabet and rows \(P,Q\), with

\[
P(y)>0,\quad Q(y)>0,\quad P\ne Q,\qquad
Q(y)=P(\tau(y)),\quad \tau^2=\mathrm{id}.
\tag{1}
\]

This is a binary-input output-symmetric (BISO) channel; its output alphabet need not be binary. For \(\alpha>1\), define

\[
D_\alpha(\nu\|\mu)
=\frac1{\alpha-1}\log\sum_x\nu(x)^\alpha\mu(x)^{1-\alpha},
\qquad
\eta_\alpha(K)=
\sup_{0<D_\alpha(\nu\|\mu)<\infty}
\frac{D_\alpha(\nu K\|\mu K)}{D_\alpha(\nu\|\mu)}.
\tag{2}
\]

The reference distribution is optimized. This coefficient must be distinguished from a coefficient at a prescribed product reference.

Vandenbroucque, Esposito and Gastpar [1, Theorem 6(b)] prove that for finite channels and \(\alpha\ge2\), the supremum can be restricted to a point mass \(\nu=\delta_x\) and a reference \(\mu=q\delta_x+(1-q)\delta_{x'}\). Their Theorem 7 gives the infinite-order formula; Corollary 3 gives general product bounds. We use these results with attribution, and do not claim their support reduction as new.

Polyanskiy and Wu [2] already obtain the BSC product KL/TV Chernoff exponent up to logarithmic corrections using repetition inputs. Jin, Esposito and Gastpar [3] study Rényi contraction and order-two supports. Hirche and Shaya [4] give BISO channel comparisons and a KL coefficient formula. Moore and Esposito [5] study fixed-reference Rényi contraction, power contraction and communication converses. The present target is the sharp optimized product asymptotic and the specified joint order/blocklength regimes; a bare Chernoff exponent is not its novelty claim.

## Exact scope

The scalar optimizer \(q_*\) also appears in the Fisher-information design problem of Lucchese et al. [9, Lemma 1]. The numerical constant and its scalar root equation are therefore not new. Here the new assertion is its universal role as the asymptotically optimal binary-mixture mass for the specified nonarithmetic BISO product channels, established by a global optimization argument.

The channel is fixed, finite, fully positive and satisfies (1). The order regimes are: every fixed finite \(\alpha\ge2\); \(b_n=\alpha_n-1=e^{nr}\) for each fixed \(r>0\); and the specified KL critical window. We do not assert a theorem for all subexponential order sequences, variable alphabets, simultaneous vanishing-noise limits, \(1<\alpha<2\), or all unrestricted extremizing input measures. The case \(r=0\) in \(b=e^{nr}\) means \(\alpha=2\) only; all other fixed orders are treated separately.

# Main results

Under \(P\), put

\[
Y=\log(Q/P),\quad S_n=\sum_{j=1}^nY_j,\quad
\psi(s)=\log\mathbb E_Pe^{sY},\quad
I(x)=\sup_s\{sx-\psi(s)\}.
\tag{3}
\]

Symmetry gives \(\psi(s)=\psi(1-s)\). Define

\[
C=-\psi(1/2),\quad D=-\psi'(0)=D(P\|Q),\quad
M=-\min Y=D_\infty(P\|Q),
\tag{4}
\]

\[
\sigma_C^2=\psi''(1/2),\quad
\sigma_P^2=\psi''(0),\quad
p_*=P\{Y=-M\},\quad \ell=-\log p_*.
\tag{5}
\]

All variances are positive, \(C>0\), \(0<D<M\), and \(0<p_*<1\). For \(b>0,a>0,U=\log(1+a)\), let

\[
A_{n,b}(a)=\mathbb E_{P^n}(1+ae^{S_n})^{-b},\quad
L_{n,b}(a)=-\log A_{n,b}(a),\quad
F_{n,b}(a)=\frac{L_{n,b}(a)}{b\log(1+a)}.
\tag{6}
\]

The prior is \(q=(1+a)^{-1}=e^{-U}\). For \(b\ge1\),

\[
\delta_{n,b}:=1-\eta_{b+1}(K^{\otimes n})
=\min_{a>0}F_{n,b}(a).
\tag{7}
\]

In every optimizer-convergence statement below, \(a_n\) denotes an arbitrary
choice of an exact global minimizer in (7), with
\(U_n=\log(1+a_n)\) and \(q_n=(1+a_n)^{-1}\), unless an explicit construction
or a weaker notion of asymptotic optimality is stated.

## Theorem 1: exact reduction and fixed-order sharp constants

The minimum in (7) is attained. Antipodal input strings attain the optimal value within the point-mass/two-point family. Every extremizer in that family must have Hamming distance \(n\). This does not classify all unrestricted input optimizers.

If \(Y\) is nonarithmetic and \(b\ge1\) is fixed, then

\[
\delta_{n,b}=
\frac{e^{-nC}}{\sqrt n}
\left[
\frac{\sqrt2\,\Gamma(b+1/2)}{\sigma_C\Gamma(b+1)}
\frac{\sqrt{a_*}}{\log(1+a_*)}+o(1)
\right].
\tag{8}
\]

Every exact optimizing binary prior converges to \(q_*=(1+a_*)^{-1}\), where

\[
(1+a_*)\log(1+a_*)=2a_*,
\qquad -\tfrac12\log q_*=1-q_*,
\qquad q_*=0.2031878699799799\ldots.
\tag{9}
\]

The limiting optimizer is unique; finite-\(n\) uniqueness is not asserted.

For an arithmetic law, let \(h\) be its **maximal span**, \(Y\in a_0+h\mathbb Z\), and \(v_n=na_0\bmod h\). Define

\[
\mathcal K_b(v,a)=
\frac{h}{b\sigma_C\sqrt{2\pi}\log(1+a)}
\sum_{k\in\mathbb Z}
e^{-(v+kh)/2}
\{1-(1+ae^{v+kh})^{-b}\}.
\tag{10}
\]

The series converges absolutely. Then

\[
\sqrt n e^{nC}\delta_{n,b}
-\min_{a>0}\mathcal K_b(v_n,a)\longrightarrow0.
\tag{11}
\]

BISO symmetry implies \(a_0=0\) or \(h/2\) modulo \(h\), so at fixed order there is one phase or two parity phases. On each fixed phase, optimizing priors approach its global argmin set. A BSC is arithmetic: (8)-(9) do not apply to it.

## Theorem 2: exponential orders below KL

Fix \(0<r<D\), put \(b_n=e^{nr}\), and define the unique
\(\theta_r\in(0,1/2)\) by

\[
\psi'(\theta_r)=-r,\quad
\sigma_r^2=\psi''(\theta_r),\quad
I_r=-r\theta_r-\psi(\theta_r),\quad J_r=r+I_r.
\tag{12}
\]

In the nonarithmetic case,

\[
\delta_{n,b_n}=
\frac{e^{-nJ_r}}{\sqrt n}
\left[
\frac{\Gamma(1-\theta_r)}
{\theta_r\sigma_r\sqrt{2\pi}}\,
\frac{a_{\theta_r}^{\theta_r}}
{\log(1+a_{\theta_r})}+o(1)
\right],
\tag{13}
\]

and every exact optimizer satisfies \(a_n\to a_{\theta_r}\), where

\[
\theta(1+a_\theta)\log(1+a_\theta)=a_\theta,
\qquad -\theta\log q_\theta=1-q_\theta.
\tag{14}
\]

For an arithmetic law with maximal span \(h\), set
\(w_n=n(a_0+r)\bmod h\) and

\[
\mathcal K_r(v,a)=
\frac{h}{\sigma_r\sqrt{2\pi}\log(1+a)}
\sum_{k\in\mathbb Z}e^{-\theta_r(v+kh)}
\{1-\exp[-ae^{v+kh}]\}.
\tag{15}
\]

Then

\[
\sqrt n e^{nJ_r}\delta_{n,b_n}
-\min_{a>0}\mathcal K_r(w_n,a)\longrightarrow0.
\tag{16}
\]

Here the centering \(nr\) permits a rotating phase. The optimized value is asymptotically the phase minimum; along a subsequence \(w_n\to w\), every optimizer limit point belongs to \(\operatorname{argmin}\mathcal K_r(w,\cdot)\). We do not assert distance to the argmin at the moving current phase, since competing minima can exchange optimality.

## Theorem 3: the KL critical window

Let \(\zeta\in\mathbb R\) be fixed and

\[
b_n=\exp(nD+\zeta\sigma_P\sqrt n),\qquad
\kappa(\zeta)=\min_{t>0}\frac{-\log\Phi(-\zeta-t)}t.
\tag{17}
\]

For both arithmetic and nonarithmetic laws,

\[
b_n\sigma_P\sqrt n\,\delta_{n,b_n}\to\kappa(\zeta),
\qquad
\frac{U_n}{\sigma_P\sqrt n}\to t_\zeta,
\tag{18}
\]

where \(t_\zeta\) is the unique minimizer in (17). At \(\zeta=0\),

\[
t_0=1.330695845160533\ldots,\qquad
\kappa(0)=1.795930844817563\ldots.
\tag{19}
\]

The decimal evaluations are supplementary; the exact variational definitions are the theorem.

## Theorem 4: the inverse-Rényi interior

Fix \(D<r<M\), \(b_n=e^{nr}\). There is a unique \(\beta(r)>0\) with

\[
\psi(-\beta)=r\beta
\quad\Longleftrightarrow\quad
D_{1+\beta}(P\|Q)=r.
\tag{20}
\]

Then, without an arithmetic restriction,

\[
b_n\delta_{n,b_n}\to\beta(r),\qquad
\frac{U_n}n\to
u_r=-\psi'(-\beta(r))-r\in(0,M-r).
\tag{21}
\]

## Theorem 5: the maximum-likelihood endpoint

Fix exactly \(b_n=e^{nM}\) and let

\[
U_n^L=1+W_0((n\ell-1)/e).
\tag{22}
\]

Then

\[
b_n\delta_{n,b_n}
=e^{U_n^L}+o(1/\log n)
\sim\frac{n\ell}{\log n}.
\tag{23}
\]

Every exact optimizer obeys \(U_n-U_n^L\to0\), hence
\(q_n\sim\log n/(n\ell)\). A relatively asymptotically optimal sequence is only claimed to satisfy \(U_n/\log n\to1\); relative near-optimality alone does not give the finer additive localization.

## Theorem 6: saturation above the endpoint

For fixed \(r>M\), \(b_n=e^{nr}\),

\[
\delta_{n,b_n}\sim e^{-nM}.
\tag{24}
\]

An explicit asymptotically optimal construction is

\[
U_n=\sqrt{2n\ell e^{-n(r-M)}},\qquad q_n=e^{-U_n}\to1.
\tag{25}
\]

No characterization of all optimizers is asserted in this regime.

## Consequences and boundaries

For each fixed \(r>0\), (11), (16) and (18)-(24) imply

\[
\lim_{n\to\infty}-\frac1n\log\delta_{n,e^{nr}}
=
\begin{cases}
r+I(-r),&0<r<D,\\
r,&D\le r\le M,\\
M,&r>M.
\end{cases}
\tag{26}
\]

This also holds in the arithmetic case: after extracting \(a^\theta\), the periodic sums are positive continuous periodic functions, uniformly bounded above and away from zero; their optimized constants therefore have the same property.

At every fixed finite order the exponent is \(C\), whereas at infinite order [1, Theorem 7] gives exactly \(e^{-nM}\). Thus the two iterated normalized-exponent limits differ. The theorems describe specified paths between them, without claiming uniformity for arbitrary paths. In particular, merely assuming \(\log b_n/n\to M\) is insufficient for the exact endpoint law (23).

The analytical statements for the scalar oriented experiment often extend beyond symmetry. In particular, for general positive \(P,Q\), the fixed-order nonarithmetic constant replaces \(1/2\) by the Chernoff minimizer \(\theta_0\in(0,1)\):

\[
\frac{\Gamma(1-\theta_0)\Gamma(b+\theta_0)}
{\theta_0\Gamma(b+1)\sigma_0\sqrt{2\pi}}\,
\frac{a_{\theta_0}^{\theta_0}}{\log(1+a_{\theta_0})}.
\tag{27}
\]

This is a statement about an oriented pair. Identifying it with the full coefficient of an arbitrary nonsymmetric product channel would require an additional comparison over competing row pairs, which is not claimed.

# Proof structure and notation in the technical parts

The iterated-limit statement also uses continuity towards infinite order
at fixed blocklength. This follows directly from the atomic sandwich
proved in Part E: for fixed \(n,a>0\),
\[
e^{-nM}\le\delta_{n,b}\le
\frac{n\ell}{b\log(1+a)}
+\frac{\log(1+ae^{-nM})}{\log(1+a)}.
\]
First let \(b\to\infty\), then \(a\downarrow0\). The two bounds give
\(\lim_{b\to\infty}\delta_{n,b}=e^{-nM}\), justifying the order-first
normalized-exponent limit without an unstated continuity assumption.

The complete proofs follow in this same document. The constituent proofs are kept as independently checkable technical parts. Each part restates its local notation. In Parts A-C, \(S_n=\sum\log(Q/P)\); the critical-window and fixed-order arithmetic calculations sometimes use its negative, \(\sum\log(P/Q)\), explicitly as stated. The functional is always the same (6), so this sign convention changes no theorem.

The proofs have three essential ingredients beyond the cited support reduction: compact-uniform local-limit asymptotics; global coercivity preventing the optimized prior from escaping to zero or one; and a separate variational argument at each boundary. Arithmetic formulas use a maximal span and the lattice local limit theorem, not a density approximation.

## Exact antipodal reduction: a direct verification

For \(\nu=\delta_x\), \(\mu=q\delta_x+(1-q)\delta_{x'}\), the input divergence is \(-\log q\). Common input coordinates cancel from the output divergence; differing coordinates are transformed to \(P,Q\) by the output involution. For Hamming distance \(m\),

\[
D_{b+1}(P^m\|qP^m+(1-q)Q^m)
=U+\frac1b\log A_{m,b}(a).
\tag{28}
\]

For fixed \(a\), let \(X=e^{S_m}\) and let \(V=Q(Y)/P(Y)\) be an independent extra observation under \(P\). Then \(\mathbb EV=1\), and \(V\) is nonconstant. Strict convexity of \(v\mapsto(1+aXv)^{-b}\) gives
\(A_{m+1,b}(a)>A_{m,b}(a)\). Hence \(F_{m+1,b}(a)<F_{m,b}(a)\). The maximum allowed Hamming distance \(n\) gives (7) and the within-family extremizer claim. This proof also explains the strict finite-dimensional inequalities checked in the companion rational certificates.

## Completing the arithmetic optimization

The fixed-order arithmetic sum follows by the Chernoff tilt and the lattice local limit theorem. The growing-order arithmetic extension uses
\(T_n=S_n+nr\), whose allowed lattice is \(n(a_0+r)+h\mathbb Z\), and the compact kernel limit

\[
e^{-\theta s}\{1-(1+ae^s/b_n)^{-b_n}\}
\longrightarrow e^{-\theta s}(1-e^{-ae^s}).
\tag{29}
\]

Both kernels have a summable common envelope, uniformly on compact prior sets. The lattice local limit theorem bounds every atom by \(C/\sqrt n\) and approximates its mass uniformly at bounded locations by \(h/(\sigma\sqrt{2\pi n})\). Truncating the tails, applying the uniform atom estimate, and then removing the truncation yields compact-uniform convergence to (10) and (15), uniformly also in the residue phase.

For global confinement in an arithmetic law, replace each unit window in the nonarithmetic proofs below by a window longer than \(2h\). Round its location to an allowed atom; the displacement is bounded by \(h\), so every kernel lower bound changes only by a fixed factor. The chosen locations are \(O(\log n)\), where the local limit theorem gives mass at least \(c/\sqrt n\). The direct bound for arbitrarily large \(a\) is unchanged. Thus all optimizing priors lie in one compact set, simultaneously over phases. Taking the minimum proves (11) and (16).

For optimizer limits, compactness and continuity suffice at a fixed phase or along a subsequence of converging phases. They do not justify closeness to a moving current-phase argmin without an additional stability property. That stronger conclusion is intentionally absent.

For precision, the uniform bounds on the limiting phase objectives follow
from an exact factorization. If
\(j_{\theta,b}(t)=e^{-\theta t}\{1-(1+e^t)^{-b}\}\) at fixed order, or
\(j_\theta(t)=e^{-\theta t}(1-e^{-e^t})\) at growing order, define
\(H(v)=h\sum_{k\in\mathbb Z}j(v+kh)\). Then the corresponding objective is
\[
\mathcal K(v,a)=
\frac{a^\theta H(v+\log a)}
{c\,\sigma\sqrt{2\pi}\log(1+a)},
\tag{30}
\]
where \(c=b,\theta=1/2\) in (10), and \(c=1,\theta=\theta_r\) in (15).
The exponential tails give locally uniform convergence of the sum. Thus
\(H\) is continuous, strictly positive and \(h\)-periodic, and there are
constants \(0<m_H\le H(v)\le M_H<\infty\) for every phase. Since
\(a^\theta/\log(1+a)\to\infty\) at both ends, every phase objective has its
minimizers in one common compact interval. The exact normalized objectives
have their own common compact interval by the window estimates. Enlarge
the two intervals to a single compact \(J\). The uniform approximation
error on \(J\) bounds the difference between the two global minimum
values: \(|\min f_n-\min\mathcal K(v_n,\cdot)|\le
\sup_{a\in J}|f_n(a)-\mathcal K(v_n,a)|\to0\).
This proves the value claim without presuming stability of a moving
argmin set.

