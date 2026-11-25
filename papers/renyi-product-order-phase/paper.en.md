# Rényi contraction of repeated symmetric channels

*Sharp constants, optimal priors, and order-dependent phase transitions*

AI-assisted research manuscript

25 November 2026

# Abstract

We determine sharp asymptotics of the distribution-independent Rényi divergence contraction coefficient of a finite, strictly positive, nonconstant binary-input output-symmetric channel under repeated independent use. An existing support-reduction theorem reduces the channel optimization to a binary-mixture likelihood-ratio functional. Our contribution is the global optimization of that functional, including prior weights approaching either boundary at arbitrary speeds.

For fixed finite orders $\alpha\ge2$, the deficit has a sharp $n^{-1/2}e^{-nC}$ asymptotic. In the nonarithmetic case every optimal binary-mixture prior converges to the same number $q_*=0.2031878699\ldots$, independently of the channel and the order. Arithmetic laws instead require an explicit periodic sum. For exponentially growing order, the asymptotic changes at the KL divergence and at the maximum log-likelihood ratio. We obtain tilted sharp constants below KL, a Gaussian variational limit in its critical window, an inverse-Rényi constant above KL, a Lambert $W$ expression at the maximum-likelihood endpoint, and saturation of the infinite-order value above that endpoint.

All optimization statements include proofs excluding escaping parameters. The analytic statements are classical proofs; the accompanying Lean supplement verifies explicitly delimited algebraic ingredients only. External peer review and global priority are not claimed.

# Problem and attribution

Let $K:\{0,1\}\to\mathcal Y$ have finite output alphabet and rows $P,Q$, with

$$
P(y)>0,\quad Q(y)>0,\quad P\ne Q,\qquad
Q(y)=P(\tau(y)),\quad \tau^2=\mathrm{id}.
\tag{1}
$$

This is a binary-input output-symmetric (BISO) channel; its output alphabet need not be binary. For $\alpha>1$, define

$$
D_\alpha(\nu\|\mu)
=\frac1{\alpha-1}\log\sum_x\nu(x)^\alpha\mu(x)^{1-\alpha},
\qquad
\eta_\alpha(K)=
\sup_{0<D_\alpha(\nu\|\mu)<\infty}
\frac{D_\alpha(\nu K\|\mu K)}{D_\alpha(\nu\|\mu)}.
\tag{2}
$$

The reference distribution is optimized. This coefficient must be distinguished from a coefficient at a prescribed product reference.

Vandenbroucque, Esposito and Gastpar [1, Theorem 6(b)] prove that for finite channels and $\alpha\ge2$, the supremum can be restricted to a point mass $\nu=\delta_x$ and a reference $\mu=q\delta_x+(1-q)\delta_{x'}$. Their Theorem 7 gives the infinite-order formula; Corollary 3 gives general product bounds. We use these results with attribution, and do not claim their support reduction as new.

Polyanskiy and Wu [2] already obtain the BSC product KL/TV Chernoff exponent up to logarithmic corrections using repetition inputs. Jin, Esposito and Gastpar [3] study Rényi contraction and order-two supports. Hirche and Shaya [4] give BISO channel comparisons and a KL coefficient formula. Moore and Esposito [5] study fixed-reference Rényi contraction, power contraction and communication converses. The present target is the sharp optimized product asymptotic and the specified joint order/blocklength regimes; a bare Chernoff exponent is not its novelty claim.

## Exact scope

The scalar optimizer $q_*$ also appears in the Fisher-information design problem of Lucchese et al. [9, Lemma 1]. The numerical constant and its scalar root equation are therefore not new. Here the new assertion is its universal role as the asymptotically optimal binary-mixture mass for the specified nonarithmetic BISO product channels, established by a global optimization argument.

The channel is fixed, finite, fully positive and satisfies (1). The order regimes are: every fixed finite $\alpha\ge2$; $b_n=\alpha_n-1=e^{nr}$ for each fixed $r>0$; and the specified KL critical window. We do not assert a theorem for all subexponential order sequences, variable alphabets, simultaneous vanishing-noise limits, $1<\alpha<2$, or all unrestricted extremizing input measures. The case $r=0$ in $b=e^{nr}$ means $\alpha=2$ only; all other fixed orders are treated separately.

# Main results

Under $P$, put

$$
Y=\log(Q/P),\quad S_n=\sum_{j=1}^nY_j,\quad
\psi(s)=\log\mathbb E_Pe^{sY},\quad
I(x)=\sup_s\{sx-\psi(s)\}.
\tag{3}
$$

Symmetry gives $\psi(s)=\psi(1-s)$. Define

$$
C=-\psi(1/2),\quad D=-\psi'(0)=D(P\|Q),\quad
M=-\min Y=D_\infty(P\|Q),
\tag{4}
$$

$$
\sigma_C^2=\psi''(1/2),\quad
\sigma_P^2=\psi''(0),\quad
p_*=P\{Y=-M\},\quad \ell=-\log p_*.
\tag{5}
$$

All variances are positive, $C>0$, $0<D<M$, and $0<p_*<1$. For $b>0,a>0,U=\log(1+a)$, let

$$
A_{n,b}(a)=\mathbb E_{P^n}(1+ae^{S_n})^{-b},\quad
L_{n,b}(a)=-\log A_{n,b}(a),\quad
F_{n,b}(a)=\frac{L_{n,b}(a)}{b\log(1+a)}.
\tag{6}
$$

The prior is $q=(1+a)^{-1}=e^{-U}$. For $b\ge1$,

$$
\delta_{n,b}:=1-\eta_{b+1}(K^{\otimes n})
=\min_{a>0}F_{n,b}(a).
\tag{7}
$$

In every optimizer-convergence statement below, $a_n$ denotes an arbitrary
choice of an exact global minimizer in (7), with
$U_n=\log(1+a_n)$ and $q_n=(1+a_n)^{-1}$, unless an explicit construction
or a weaker notion of asymptotic optimality is stated.

## Theorem 1: exact reduction and fixed-order sharp constants

The minimum in (7) is attained. Antipodal input strings attain the optimal value within the point-mass/two-point family. Every extremizer in that family must have Hamming distance $n$. This does not classify all unrestricted input optimizers.

If $Y$ is nonarithmetic and $b\ge1$ is fixed, then

$$
\delta_{n,b}=
\frac{e^{-nC}}{\sqrt n}
\left[
\frac{\sqrt2\,\Gamma(b+1/2)}{\sigma_C\Gamma(b+1)}
\frac{\sqrt{a_*}}{\log(1+a_*)}+o(1)
\right].
\tag{8}
$$

Every exact optimizing binary prior converges to $q_*=(1+a_*)^{-1}$, where

$$
(1+a_*)\log(1+a_*)=2a_*,
\qquad -\tfrac12\log q_*=1-q_*,
\qquad q_*=0.2031878699799799\ldots.
\tag{9}
$$

The limiting optimizer is unique; finite-$n$ uniqueness is not asserted.

For an arithmetic law, let $h$ be its **maximal span**, $Y\in a_0+h\mathbb Z$, and $v_n=na_0\bmod h$. Define

$$
\mathcal K_b(v,a)=
\frac{h}{b\sigma_C\sqrt{2\pi}\log(1+a)}
\sum_{k\in\mathbb Z}
e^{-(v+kh)/2}
\{1-(1+ae^{v+kh})^{-b}\}.
\tag{10}
$$

The series converges absolutely. Then

$$
\sqrt n e^{nC}\delta_{n,b}
-\min_{a>0}\mathcal K_b(v_n,a)\longrightarrow0.
\tag{11}
$$

BISO symmetry implies $a_0=0$ or $h/2$ modulo $h$, so at fixed order there is one phase or two parity phases. On each fixed phase, optimizing priors approach its global argmin set. A BSC is arithmetic: (8)-(9) do not apply to it.

## Theorem 2: exponential orders below KL

Fix $0<r<D$, put $b_n=e^{nr}$, and define the unique
$\theta_r\in(0,1/2)$ by

$$
\psi'(\theta_r)=-r,\quad
\sigma_r^2=\psi''(\theta_r),\quad
I_r=-r\theta_r-\psi(\theta_r),\quad J_r=r+I_r.
\tag{12}
$$

In the nonarithmetic case,

$$
\delta_{n,b_n}=
\frac{e^{-nJ_r}}{\sqrt n}
\left[
\frac{\Gamma(1-\theta_r)}
{\theta_r\sigma_r\sqrt{2\pi}}\,
\frac{a_{\theta_r}^{\theta_r}}
{\log(1+a_{\theta_r})}+o(1)
\right],
\tag{13}
$$

and every exact optimizer satisfies $a_n\to a_{\theta_r}$, where

$$
\theta(1+a_\theta)\log(1+a_\theta)=a_\theta,
\qquad -\theta\log q_\theta=1-q_\theta.
\tag{14}
$$

For an arithmetic law with maximal span $h$, set
$w_n=n(a_0+r)\bmod h$ and

$$
\mathcal K_r(v,a)=
\frac{h}{\sigma_r\sqrt{2\pi}\log(1+a)}
\sum_{k\in\mathbb Z}e^{-\theta_r(v+kh)}
\{1-\exp[-ae^{v+kh}]\}.
\tag{15}
$$

Then

$$
\sqrt n e^{nJ_r}\delta_{n,b_n}
-\min_{a>0}\mathcal K_r(w_n,a)\longrightarrow0.
\tag{16}
$$

Here the centering $nr$ permits a rotating phase. The optimized value is asymptotically the phase minimum; along a subsequence $w_n\to w$, every optimizer limit point belongs to $\operatorname{argmin}\mathcal K_r(w,\cdot)$. We do not assert distance to the argmin at the moving current phase, since competing minima can exchange optimality.

## Theorem 3: the KL critical window

Let $\zeta\in\mathbb R$ be fixed and

$$
b_n=\exp(nD+\zeta\sigma_P\sqrt n),\qquad
\kappa(\zeta)=\min_{t>0}\frac{-\log\Phi(-\zeta-t)}t.
\tag{17}
$$

For both arithmetic and nonarithmetic laws,

$$
b_n\sigma_P\sqrt n\,\delta_{n,b_n}\to\kappa(\zeta),
\qquad
\frac{U_n}{\sigma_P\sqrt n}\to t_\zeta,
\tag{18}
$$

where $t_\zeta$ is the unique minimizer in (17). At $\zeta=0$,

$$
t_0=1.330695845160533\ldots,\qquad
\kappa(0)=1.795930844817563\ldots.
\tag{19}
$$

The decimal evaluations are supplementary; the exact variational definitions are the theorem.

## Theorem 4: the inverse-Rényi interior

Fix $D<r<M$, $b_n=e^{nr}$. There is a unique $\beta(r)>0$ with

$$
\psi(-\beta)=r\beta
\quad\Longleftrightarrow\quad
D_{1+\beta}(P\|Q)=r.
\tag{20}
$$

Then, without an arithmetic restriction,

$$
b_n\delta_{n,b_n}\to\beta(r),\qquad
\frac{U_n}n\to
u_r=-\psi'(-\beta(r))-r\in(0,M-r).
\tag{21}
$$

## Theorem 5: the maximum-likelihood endpoint

Fix exactly $b_n=e^{nM}$ and let

$$
U_n^L=1+W_0((n\ell-1)/e).
\tag{22}
$$

Then

$$
b_n\delta_{n,b_n}
=e^{U_n^L}+o(1/\log n)
\sim\frac{n\ell}{\log n}.
\tag{23}
$$

Every exact optimizer obeys $U_n-U_n^L\to0$, hence
$q_n\sim\log n/(n\ell)$. A relatively asymptotically optimal sequence is only claimed to satisfy $U_n/\log n\to1$; relative near-optimality alone does not give the finer additive localization.

## Theorem 6: saturation above the endpoint

For fixed $r>M$, $b_n=e^{nr}$,

$$
\delta_{n,b_n}\sim e^{-nM}.
\tag{24}
$$

An explicit asymptotically optimal construction is

$$
U_n=\sqrt{2n\ell e^{-n(r-M)}},\qquad q_n=e^{-U_n}\to1.
\tag{25}
$$

No characterization of all optimizers is asserted in this regime.

## Consequences and boundaries

For each fixed $r>0$, (11), (16) and (18)-(24) imply

$$
\lim_{n\to\infty}-\frac1n\log\delta_{n,e^{nr}}
=
\begin{cases}
r+I(-r),&0<r<D,\\
r,&D\le r\le M,\\
M,&r>M.
\end{cases}
\tag{26}
$$

This also holds in the arithmetic case: after extracting $a^\theta$, the periodic sums are positive continuous periodic functions, uniformly bounded above and away from zero; their optimized constants therefore have the same property.

At every fixed finite order the exponent is $C$, whereas at infinite order [1, Theorem 7] gives exactly $e^{-nM}$. Thus the two iterated normalized-exponent limits differ. The theorems describe specified paths between them, without claiming uniformity for arbitrary paths. In particular, merely assuming $\log b_n/n\to M$ is insufficient for the exact endpoint law (23).

The analytical statements for the scalar oriented experiment often extend beyond symmetry. In particular, for general positive $P,Q$, the fixed-order nonarithmetic constant replaces $1/2$ by the Chernoff minimizer $\theta_0\in(0,1)$:

$$
\frac{\Gamma(1-\theta_0)\Gamma(b+\theta_0)}
{\theta_0\Gamma(b+1)\sigma_0\sqrt{2\pi}}\,
\frac{a_{\theta_0}^{\theta_0}}{\log(1+a_{\theta_0})}.
\tag{27}
$$

This is a statement about an oriented pair. Identifying it with the full coefficient of an arbitrary nonsymmetric product channel would require an additional comparison over competing row pairs, which is not claimed.

# Proof structure and notation in the technical parts

The iterated-limit statement also uses continuity towards infinite order
at fixed blocklength. This follows directly from the atomic sandwich
proved in Part E: for fixed $n,a>0$,
$$
e^{-nM}\le\delta_{n,b}\le
\frac{n\ell}{b\log(1+a)}
+\frac{\log(1+ae^{-nM})}{\log(1+a)}.
$$
First let $b\to\infty$, then $a\downarrow0$. The two bounds give
$\lim_{b\to\infty}\delta_{n,b}=e^{-nM}$, justifying the order-first
normalized-exponent limit without an unstated continuity assumption.

The complete proofs follow in this same document. The constituent proofs are kept as independently checkable technical parts. Each part restates its local notation. In Parts A-C, $S_n=\sum\log(Q/P)$; the critical-window and fixed-order arithmetic calculations sometimes use its negative, $\sum\log(P/Q)$, explicitly as stated. The functional is always the same (6), so this sign convention changes no theorem.

The proofs have three essential ingredients beyond the cited support reduction: compact-uniform local-limit asymptotics; global coercivity preventing the optimized prior from escaping to zero or one; and a separate variational argument at each boundary. Arithmetic formulas use a maximal span and the lattice local limit theorem, not a density approximation.

## Exact antipodal reduction: a direct verification

For $\nu=\delta_x$, $\mu=q\delta_x+(1-q)\delta_{x'}$, the input divergence is $-\log q$. Common input coordinates cancel from the output divergence; differing coordinates are transformed to $P,Q$ by the output involution. For Hamming distance $m$,

$$
D_{b+1}(P^m\|qP^m+(1-q)Q^m)
=U+\frac1b\log A_{m,b}(a).
\tag{28}
$$

For fixed $a$, let $X=e^{S_m}$ and let $V=Q(Y)/P(Y)$ be an independent extra observation under $P$. Then $\mathbb EV=1$, and $V$ is nonconstant. Strict convexity of $v\mapsto(1+aXv)^{-b}$ gives
$A_{m+1,b}(a)>A_{m,b}(a)$. Hence $F_{m+1,b}(a)<F_{m,b}(a)$. The maximum allowed Hamming distance $n$ gives (7) and the within-family extremizer claim. This proof also explains the strict finite-dimensional inequalities checked in the companion rational certificates.

## Completing the arithmetic optimization

The fixed-order arithmetic sum follows by the Chernoff tilt and the lattice local limit theorem. The growing-order arithmetic extension uses
$T_n=S_n+nr$, whose allowed lattice is $n(a_0+r)+h\mathbb Z$, and the compact kernel limit

$$
e^{-\theta s}\{1-(1+ae^s/b_n)^{-b_n}\}
\longrightarrow e^{-\theta s}(1-e^{-ae^s}).
\tag{29}
$$

Both kernels have a summable common envelope, uniformly on compact prior sets. The lattice local limit theorem bounds every atom by $C/\sqrt n$ and approximates its mass uniformly at bounded locations by $h/(\sigma\sqrt{2\pi n})$. Truncating the tails, applying the uniform atom estimate, and then removing the truncation yields compact-uniform convergence to (10) and (15), uniformly also in the residue phase.

For global confinement in an arithmetic law, replace each unit window in the nonarithmetic proofs below by a window longer than $2h$. Round its location to an allowed atom; the displacement is bounded by $h$, so every kernel lower bound changes only by a fixed factor. The chosen locations are $O(\log n)$, where the local limit theorem gives mass at least $c/\sqrt n$. The direct bound for arbitrarily large $a$ is unchanged. Thus all optimizing priors lie in one compact set, simultaneously over phases. Taking the minimum proves (11) and (16).

For optimizer limits, compactness and continuity suffice at a fixed phase or along a subsequence of converging phases. They do not justify closeness to a moving current-phase argmin without an additional stability property. That stronger conclusion is intentionally absent.

For precision, the uniform bounds on the limiting phase objectives follow
from an exact factorization. If
$j_{\theta,b}(t)=e^{-\theta t}\{1-(1+e^t)^{-b}\}$ at fixed order, or
$j_\theta(t)=e^{-\theta t}(1-e^{-e^t})$ at growing order, define
$H(v)=h\sum_{k\in\mathbb Z}j(v+kh)$. Then the corresponding objective is
$$
\mathcal K(v,a)=
\frac{a^\theta H(v+\log a)}
{c\,\sigma\sqrt{2\pi}\log(1+a)},
\tag{30}
$$
where $c=b,\theta=1/2$ in (10), and $c=1,\theta=\theta_r$ in (15).
The exponential tails give locally uniform convergence of the sum. Thus
$H$ is continuous, strictly positive and $h$-periodic, and there are
constants $0<m_H\le H(v)\le M_H<\infty$ for every phase. Since
$a^\theta/\log(1+a)\to\infty$ at both ends, every phase objective has its
minimizers in one common compact interval. The exact normalized objectives
have their own common compact interval by the window estimates. Enlarge
the two intervals to a single compact $J$. The uniform approximation
error on $J$ bounds the difference between the two global minimum
values: $|\min f_n-\min\mathcal K(v_n,\cdot)|\le
\sup_{a\in J}|f_n(a)-\mathcal K(v_n,a)|\to0$.
This proves the value claim without presuming stability of a moving
argmin set.



# Proof A: Fixed order and global prior confinement

## 1. Statement proved

Let $P$ and $Q$ be distinct strictly positive probability distributions on a finite alphabet. In the principal symmetric case, an output involution interchanges $P$ and $Q$. Let $b=\alpha-1\ge1$, and put

$$
 Z=\sum_y\sqrt{P(y)Q(y)},\qquad C=-\log Z>0,
 \qquad R(y)=\sqrt{P(y)Q(y)}/Z,
$$
$$
 Y(y)=\log\frac{Q(y)}{P(y)},\quad
 S_n=Y_1+\cdots+Y_n,\quad
 \sigma^2=\operatorname{Var}_R(Y)>0.
$$

The involution makes the law of $Y$ under $R$ symmetric, so its mean is zero. Assume that this law is nonarithmetic: it is not supported by any affine lattice $c+h\mathbb Z$ with $h>0$. All expectations involving $S_n$ below specify whether the sampling measure is $P$ or $R$.

For $a>0$ define

$$
 A_n(a)=\mathbb E_{P^n}(1+a e^{S_n})^{-b},
 \quad B_n(a)=1-A_n(a),
 \quad F_n(a)=\frac{-\log A_n(a)}{b\log(1+a)}.
$$

The mixture notation is $a=(1-q)/q$, so $\log(1+a)=-\log q$.

**Theorem.** For every $n\ge1$, $F_n$ has an interior global minimum, and all its values lie strictly between zero and one. If $a_n$ is any choice of global minimizer, then

$$
 a_n\longrightarrow a_*=3.92155363456750509245\ldots,
 \qquad q_n\longrightarrow q_*=0.20318786997997995383\ldots,
$$

where $a_*$ is the unique positive solution of

$$
 (1+a_*)\log(1+a_*)=2a_*,
$$

equivalently $q_*$ is the unique solution in $(0,1)$ of

$$
 -\tfrac12\log q_*=1-q_*.
$$

Moreover,

$$
 \inf_{a>0}F_n(a)
 =\frac{e^{-nC}}{\sqrt n}\left[
 \frac{2\sqrt\pi\,\Gamma(b+\tfrac12)}
 {\Gamma(b+1)\,\sigma\sqrt{2\pi}}
 \frac{\sqrt{a_*}}{\log(1+a_*)}+o(1)\right].
$$

The minimizer is independent of $b$ at this leading order. The same convergence holds for asymptotically minimizing sequences whose rescaled objective differs from the infimum by $o(1)$. No finite-$n$ uniqueness is asserted.

The essential additional result, beyond fixed-$a$ asymptotics, is the following sequential coercivity:

$$
 a_n\to0\text{ or }a_n\to\infty
 \quad\Longrightarrow\quad
 \sqrt n e^{nC}F_n(a_n)\to\infty.
$$

Sections 4 and 5 prove this with explicit bounds, so the infimum/asymptotic exchange does not assume that $q$ is fixed.

## 2. Exact tilt and elementary inequalities

Since $P(y)=ZR(y)e^{-Y(y)/2}$,

$$
 B_n(a)=e^{-nC}\mathbb E_{R^n}h_a(S_n),
 \qquad
 h_a(s)=e^{-s/2}\{1-(1+a e^s)^{-b}\}.
 \tag{A.2.1}
$$

For $z\ge0$ and $b\ge1$,

$$
 \frac{z}{1+z}\le 1-(1+z)^{-b}\le bz.
 \tag{A.2.2}
$$

The lower bound follows from $(1+z)^{-b}\le(1+z)^{-1}$; the upper bound is the tangent inequality for the convex function $(1+z)^{-b}$. Also

$$
 -\log(1-u)\ge u\quad(0<u<1).
$$

Consequently, with $r_n=\sqrt n\,e^{nC}$,

$$
 r_nF_n(a)\ge
 \frac{\sqrt n}{b}\mathbb E_{R^n}
 \frac{h_a(S_n)}{\log(1+a)}.
 \tag{A.2.3}
$$

This lower bound remains valid even when $a$ depends on $n$ or the deficit $B_n$ is not small.

## 3. The only probabilistic input needed

Stone's interval local limit theorem, in the mean-zero one-dimensional nonarithmetic case, states that for every fixed $\ell>0$,

$$
 \sup_{x\in\mathbb R}\left|
 \sqrt n\,R^n\{S_n\in[x,x+\ell)\}
 -\frac{\ell}{\sigma\sqrt{2\pi}}
   e^{-x^2/(2n\sigma^2)}
 \right|\longrightarrow0.
 \tag{A.3.1}
$$

In particular, for any fixed $D,E>0$, there exist $c_0>0$, $C_0<\infty$ and $N$ such that for $n\ge N$:

$$
 \frac{c_0}{\sqrt n}\le
 R^n\{S_n\in[x,x+1)\}
 \quad\text{whenever }|x|\le D\log(n+1)+E,
 \tag{A.3.2}
$$

and

$$
 \sup_x R^n\{S_n\in[x,x+1)\}\le C_0/\sqrt n.
 \tag{A.3.3}
$$

For (A.3.2), $x/\sqrt n$ tends to zero uniformly on the stated logarithmic window. Thus only intervals very near the central scale are used; no moderate- or large-deviation approximation is needed.

**Primary-source provenance.** Charles Stone, *On local and ratio limit theorems*, Proceedings of the Fifth Berkeley Symposium, volume II, part II, pp. 217-224, Corollary 1 on p. 218, supplies the finite-covariance interval LLT with a remainder uniform in location. The theorem/corollary passage was retrieved through indexed primary-source text from the Berkeley collection. Direct PDF opening returned HTTP 403, so this note does not claim a locally downloaded/full-PDF inspection. Source: [Berkeley primary-source PDF](https://digicoll.lib.berkeley.edu/nanna/record/113081/files/math_s5_v2_p2_article-15.pdf?registerDownload=1&version=1&withMetadata=0&withWatermark=0). The related original 1965 paper has DOI 10.1214/aoms/1177700165; its full text was not retrieved here.

## 4. Excluding $a\to0$, including arbitrarily fast escape

Write $a=e^{-t}$, $t\ge2$, and $n\ge2$. Set

$$
 x=\min(t/2,\log n).
$$

On $I=[x,x+1)$, we have

$$
 a e^s\le e^{-t/2+1}\le1,
 \qquad \log(1+a)\le a.
$$

Applying (A.2.2),

$$
 \frac{h_a(s)}{\log(1+a)}
 \ge \frac{e^{-s/2}\,a e^s}{2a}
 =\tfrac12 e^{s/2}
 \ge\tfrac12e^{x/2}.
$$

The interval location is at most $\log n$, uniformly in $t$, so (A.3.2) applies. Thus for all sufficiently large $n$ and all $t\ge2$,

$$
 r_nF_n(e^{-t})\ge
 \frac{c_0}{2b}e^{\min(t/2,\log n)/2}
 =\frac{c_0}{2b}\min(e^{t/4},\sqrt n).
 \tag{A.4.1}
$$

This tends to infinity for every $t_n\to\infty$, regardless of its speed. In particular it covers $a_n$ exponentially or superexponentially small. No lower cutoff on $a$ is assumed.

## 5. Excluding $a\to\infty$

Let $M=\max_y|Y(y)|>0$. Then $|S_n|\le nM$ pointwise. Write $a=e^t$.

### 5.1. Very large $t$: a direct finite-support bound

For every sample,

$$
 (1+e^{t+S_n})^{-b}\le e^{-b(t+S_n)}
 \le e^{-b(t-nM)}.
$$

Therefore

$$
 F_n(e^t)\ge\frac{t-nM}{\log(1+e^t)}.
$$

If $t\ge2nM+1$, then $nM\le(t-1)/2$ and $\log(1+e^t)\le t+\log2$. Consequently

$$
 F_n(e^t)\ge\frac{t+1}{2(t+\log2)}\ge\tfrac12,
 \qquad t\ge2nM+1.
 \tag{A.5.1}
$$

Its rescaled value is at least $r_n/2$, which tends to infinity.

### 5.2. Remaining large $t$: a logarithmically displaced central window

Assume $20\le t\le2nM+1$ and choose

$$
 I_t=[-4\log t-1,-4\log t).
$$

For $s$ in this interval,

$$
 e^{t+s}\ge e^t t^{-4}e^{-1}\ge1,
 \qquad e^{-s/2}\ge t^2,
$$

where the final inequality in the first line follows because $t-4\log t-1>0$ at $t=20$ and increases thereafter. By $b\ge1$ and $\log(1+e^t)\le2t$,

$$
 \frac{h_{e^t}(s)}{\log(1+e^t)}
 \ge \frac{t^2/2}{2t}=\frac t4.
$$

The interval lies within a logarithmic distance of zero:

$$
 |{-4\log t-1}|
 \le4\log(n+1)+4\log(2M+1)+1.
$$

Thus a single choice of $D,E$ in (A.3.2) works for every such $t$. Combining with (A.2.3),

$$
 r_nF_n(e^t)\ge\frac{c_0t}{4b},
 \qquad20\le t\le2nM+1,
 \tag{A.5.2}
$$

for all sufficiently large $n$. Equations (A.5.1)-(A.5.2) imply, for $t\ge20$,

$$
 r_nF_n(e^t)\ge
 \min\left(\frac{c_0t}{4b},\frac{r_n}{2}\right).
 \tag{A.5.3}
$$

Every sequence $t_n\to\infty$ therefore has rescaled objective tending to infinity. This is the required other half of sequential coercivity.

## 6. Finite-$n$ existence and endpoint behavior

Continuity of $F_n$ on $(0,\infty)$ is immediate from the finite sum defining $A_n$. Let $X=e^{S_n}$ under $P^n$. Then $X>0$ and $\mathbb E_P X=1$. Since $P\ne Q$, $X$ is nonconstant for every $n\ge1$.

The map $x\mapsto(1+ax)^{-b}$ is strictly convex. Strict Jensen gives

$$
 A_n(a)>(1+a\mathbb E X)^{-b}=(1+a)^{-b}.
$$

Also $A_n(a)<1$. Hence $0<F_n(a)<1$.

For fixed $n$ and $a\to0$, Taylor expansion of the finite sum gives

$$
 A_n(a)=1-ba\mathbb E X+O_n(a^2)
 =1-ba+O_n(a^2),
$$

so $F_n(a)\to1$. At the other endpoint, because $X$ has a finite strictly positive support,

$$
 A_n(a)=a^{-b}\{\mathbb E X^{-b}+o(1)\},
$$

and therefore

$$
 -\log A_n(a)=b\log a-\log\mathbb E X^{-b}+o(1),
$$

which again gives $F_n(a)\to1$ as $a\to\infty$. Choosing any interior $a_0$ gives $F_n(a_0)<1$; the endpoint limits force the global infimum into a compact interior interval. By continuity, the infimum is attained. These endpoint limits alone are not a uniform-in-$n$ argument; Sections 4-5 supply that missing step.

## 7. Compact-uniform asymptotics

Fix $K=[a_-,a_+]$ contained in $(0,\infty)$. For every $a\in K$, (A.2.2) gives the common exponential envelope

$$
 h_a(s)\le
 \begin{cases}
 e^{-s/2},&s\ge0,\\
 b a_+ e^{s/2},&s<0.
 \end{cases}
 \tag{A.7.1}
$$

Stone's theorem implies vague convergence of the measures $\sqrt n\,\operatorname{Law}_R(S_n)$ to $ds/(\sigma\sqrt{2\pi})$. On each bounded interval, the functions $h_a$ form a jointly continuous compact family, so this convergence is uniform in $a\in K$, by a finite uniform-continuity net. The bound (A.3.3), applied to unit intervals together with (A.7.1), makes both tails uniformly negligible. Hence

$$
 \sup_{a\in K}\left|
 \sqrt n\,\mathbb E_R h_a(S_n)
 -\frac{1}{\sigma\sqrt{2\pi}}\int_{\mathbb R}h_a(s)\,ds
 \right|\longrightarrow0.
 \tag{A.7.2}
$$

For completeness, the needed uniform-continuity control can also be obtained from

$$
 \partial_a h_a(s)=b e^{s/2}(1+a e^s)^{-b-1}.
$$

For $s\le0$ this is at most $be^{s/2}$; for $s\ge0$ it is at most $b a_-^{-b-1}e^{-(b+1/2)s}$. The unit-interval concentration bound ensures that $\sqrt n\,\mathbb E_R|h_a-h_{a'}|$ is bounded by a constant times $|a-a'|$, uniformly on $K$ and in large $n$. This justifies the finite-net step explicitly.

Substitute $u=ae^s$ and integrate by parts:

$$
 \int_{\mathbb R}h_a(s)\,ds
 =\sqrt a\int_0^\infty u^{-3/2}\{1-(1+u)^{-b}\}\,du
$$
$$
 =2b\sqrt a\int_0^\infty u^{-1/2}(1+u)^{-b-1}\,du
 =\frac{2\sqrt\pi\,\Gamma(b+\tfrac12)}{\Gamma(b)}\sqrt a.
 \tag{A.7.3}
$$

Both boundary terms vanish: near zero the bracket is $O(u)$, and at infinity it is bounded. By (A.2.1) and (A.7.2), $B_n=O(e^{-nC}/\sqrt n)$ uniformly on $K$. Thus $-\log(1-B_n)=B_n+O(B_n^2)$, uniformly, and the rescaled quadratic error tends to zero. Since $b\log(1+a)$ is bounded away from zero on $K$,

$$
 \sup_{a\in K}\left|r_nF_n(a)-G_b(a)\right|\longrightarrow0,
$$
$$
 G_b(a)=
 \frac{2\sqrt\pi\,\Gamma(b+\tfrac12)}
 {\Gamma(b+1)\sigma\sqrt{2\pi}}
 \frac{\sqrt a}{\log(1+a)}.
 \tag{A.7.4}
$$

This confirms the prefactor used in the main theorem, including the factor 2 from the reciprocal half exponent and the factor $b$ absorbed into $\Gamma(b+1)$.

## 8. Passing the infimum and convergence of all optimizers

Choose any fixed $a_0>0$. Equation (A.7.4) shows $r_n\inf F_n\le r_nF_n(a_0)$ remains bounded. By the sequential coercivity in Sections 4-5, a sequence of minimizing $a_n$ cannot approach zero or infinity. Therefore every minimizing sequence is eventually contained in some fixed compact subset of $(0,\infty)$. Otherwise a subsequence outside larger and larger compact intervals would have a further subsequence tending to an endpoint, contradicting the bounded objective.

On that compact set, uniform convergence (A.7.4) applies. If $a_{n_j}\to a_{\mathrm{bar}}$, then

$$
 G_b(a_{\mathrm{bar}})
 =\lim_j r_{n_j}F_{n_j}(a_{n_j})
 \le \lim_jr_{n_j}F_{n_j}(a)=G_b(a)
$$

for every fixed $a>0$. Thus every subsequential limit minimizes $G_b$. Its $a$-dependent part is $g(a)=\sqrt a/\log(1+a)$, whose derivative has the sign of

$$
 u(a)=(1+a)\log(1+a)-2a.
$$

Here $u(0)=0$ and $u'(a)=\log(1+a)-1$. Hence $u$ first decreases, then strictly increases to infinity, and has exactly one positive zero $a_*$. This proves uniqueness of the limiting minimizer, convergence of all $a_n$, and the stated asymptotic minimum. The same proof applies to rescaled $o(1)$-approximate minimizers.

The numerical values above were independently recomputed with mpmath at 70 decimal digits; the analytic uniqueness argument does not depend on that computation. Also

$$
 \frac{\sqrt{a_*}}{\log(1+a_*)}
 =1.2426337563300258622014300773955966\ldots.
$$

## 9. Stronger general binary-pair version

The proof does not fundamentally need output symmetry. For distinct positive $P,Q$, let $\theta\in(0,1)$ be the unique minimizer of

$$
 Z(\theta)=\sum_yP(y)^{1-\theta}Q(y)^\theta.
$$

Existence, interiority and uniqueness follow from strict convexity of $\log Z$, its derivatives $-D(P\|Q)<0$ at zero and $D(Q\|P)>0$ at one, and nonconstancy of $\log(Q/P)$. Set $C=-\log Z(\theta)$, $R=P^{1-\theta}Q^\theta/Z(\theta)$, $Y=\log(Q/P)$, and $\sigma^2=\operatorname{Var}_R(Y)$. Then $\mathbb E_RY=0$, and $P=Z(\theta)Re^{-\theta Y}$.

For the same oriented binary-mixture function $F_n$, replace $h_a(s)$ by

$$
 h_{a,\theta}(s)=e^{-\theta s}\{1-(1+a e^s)^{-b}\}.
$$

Assuming the tilted log-likelihood is nonarithmetic, the complete result becomes

$$
 \inf_{a>0}F_n(a)
 =\frac{e^{-nC}}{\sqrt n}\left[
 \frac{\Gamma(1-\theta)\Gamma(b+\theta)}
 {\theta\Gamma(b+1)\sigma\sqrt{2\pi}}
 \min_{a>0}\frac{a^\theta}{\log(1+a)}+o(1)\right].
 \tag{A.9.1}
$$

The unique $a$-dependent minimizer satisfies

$$
 \theta(1+a_\theta)\log(1+a_\theta)=a_\theta,
$$

or, with $q_\theta=1/(1+a_\theta)$,

$$
 -\theta\log q_\theta=1-q_\theta.
$$

The integration step is

$$
 \int h_{a,\theta}(s)\,ds
 =a^\theta\int_0^\infty u^{-\theta-1}\{1-(1+u)^{-b}\}\,du
 =\frac{\Gamma(1-\theta)\Gamma(b+\theta)}
 {\theta\Gamma(b)}a^\theta.
$$

The compact-uniform envelope is $e^{-\theta s}$ for $s\ge0$ and $ba_+e^{(1-\theta)s}$ for $s<0$. Small-$a$ coercivity uses the same $x=\min(t/2,\log n)$, giving

$$
 r_nF_n(e^{-t})\ge\frac{c_0}{2b}
 e^{(1-\theta)\min(t/2,\log n)}.
$$

For large $a=e^t$ with $t\le2nM+1$, take the window

$$
 [-(2/\theta)\log t-1,-(2/\theta)\log t).
$$

For $t$ above a $\theta$-dependent fixed threshold, $e^{t+s}\ge1$ and $e^{-\theta s}\ge t^2$. The same bound $c_0t/(4b)$ follows. The very-large-$t$ bound $F_n\ge\tfrac12$ is unchanged. Thus all uniformity arguments are valid for every fixed $\theta\in(0,1)$.

This section is an oriented-pair analytic theorem. Connecting it to a nonsymmetric channel contraction coefficient may require comparing both row orientations and other input pairs; that channel reduction is a separate obligation. Reversing $P,Q$ replaces $\theta$ by $1-\theta$, preserves $C$ and $\sigma$, and may change the prefactor and optimal mixing weight.



# Proof B: Exponentially growing orders below KL

## 1. Hypotheses and result

For the main theorem, let $P,Q$ be distinct positive probability laws on a finite set,
and assume an output involution interchanges $P$ and $Q$. Section 9 states the
separate nonsymmetric extension. Write

$$
 Y(y)=\log\frac{Q(y)}{P(y)},\qquad
 \psi(\theta)=\log\sum_yP(y)^{1-\theta}Q(y)^\theta.
$$

For the symmetric-channel case, an involution interchanges $P,Q$, so $\psi(\theta)=\psi(1-\theta)$. Let $D=D(P\|Q)>0$. Fix a growth rate

$$
 0<r<D,
$$

and define $b_n=e^{nr}$, $\alpha_n=1+b_n$. There is a unique $\theta=\theta_r\in(0,\tfrac12)$ with $\psi'(\theta)=-r$. Define

$$
 R_\theta(y)=P(y)^{1-\theta}Q(y)^\theta e^{-\psi(\theta)},
 \quad \sigma_r^2=\psi''(\theta)>0,
$$
$$
 I_r=-\theta r-\psi(\theta)>0,
 \quad J_r=r+I_r.
$$

Assume the law of $Y$ is nonarithmetic, meaning its support is not contained in an affine lattice. Under $R_\theta$ its support is the same, hence it is still nonarithmetic.

For $S_n=\sum_{i=1}^nY_i$ define

$$
 A_n(a)=\mathbb E_{P^n}(1+a e^{S_n})^{-b_n},\quad
 B_n(a)=1-A_n(a),\quad
 F_n(a)=\frac{-\log A_n(a)}{b_n\log(1+a)}.
$$

**Theorem.** Every $F_n$ attains its minimum in $(0,\infty)$. Let $a_n$ be any minimizing sequence (or an approximate minimizer with rescaled additive error $o(1)$). Then $a_n\to a_\theta$, where $a_\theta$ is the unique positive root

$$
 \theta(1+a_\theta)\log(1+a_\theta)=a_\theta.
$$

Equivalently $q_n=1/(1+a_n)$ converges to the unique interior $q_\theta$ satisfying

$$
 -\theta\log q_\theta=1-q_\theta.
$$

The exact first-order strong asymptotic is

$$
 \inf_{a>0}F_n(a)
 =\frac{e^{-nJ_r}}{\sqrt n}\left[
 \frac{\Gamma(1-\theta_r)}
 {\theta_r\sigma_r\sqrt{2\pi}}
 \frac{a_{\theta_r}^{\theta_r}}
 {\log(1+a_{\theta_r})}
 +o(1)\right].
 \tag{B.1.1}
$$

The proof covers all sequences $a_n$, including those exponentially or superexponentially close to either endpoint. It does not assume a fixed mixing weight before optimizing.

## 2. Existence of the saddle

On a finite positive alphabet, $\psi$ is smooth and strictly convex because its second derivative is the variance of the nonconstant $Y$ under the corresponding positive tilt. Also

$$
 \psi'(0)=-D(P\|Q)=-D<0,
 \qquad \psi'(1/2)=0
$$

in the symmetric case. Therefore the stipulated $\theta_r$ exists uniquely in $(0,\tfrac12)$. Its tilted mean is $-r$. Strict convexity gives

$$
 \psi(\theta)>\psi(0)+\theta\psi'(0),
$$

and the Legendre representation at a point $-r$ strictly above the $P$-mean shows $I_r>0$. Directly, the tangent line at $\theta$ lies strictly below $\psi(0)=0$:

$$
 0>\psi(\theta)-\theta\psi'(\theta)
 =\psi(\theta)+\theta r=-I_r.
$$

All parameters $\theta_r$, $I_r$ and $\sigma_r$ are fixed with $n$. No endpoint limit $r\to0$ or $r\to D$ is included in the theorem.

## 3. Exact centered tilt and the growing-order kernel

Under $R_\theta$, put

$$
 T_n=S_n+nr=\sum_{i=1}^n(Y_i+r).
$$

The summands have mean zero and variance $\sigma_r^2$. The density identity is

$$
 \frac{dP^n}{dR_\theta^n}
 =e^{n\psi(\theta)-\theta S_n}
 =e^{-nI_r}e^{-\theta T_n}.
$$

Because $b_n=e^{nr}$, $e^{S_n}=e^{T_n}/b_n$. For $b\ge1$ and $z\ge0$ define

$$
 g_b(z)=1-(1+z/b)^{-b}.
$$

Then

$$
 B_n(a)=e^{-nI_r}\mathbb E_{R_\theta^n}
 \big[e^{-\theta T_n}g_{b_n}(a e^{T_n})\big].
 \tag{B.3.1}
$$

The following uniform estimates are crucial:

$$
 \frac{z}{1+z}\le g_b(z)\le\min(z,1),
 \qquad b\ge1,
 \tag{B.3.2}
$$

and hence

$$
 g_b(z)\ge\tfrac12\min(z,1).
 \tag{B.3.3}
$$

For the lower bound, Bernoulli's inequality for real $b\ge1$ gives $(1+z/b)^b\ge1+z$. For the upper bound, the convex function $(1+z/b)^{-b}$ lies above its tangent $1-z$ at zero. For $z$ in any compact interval, $g_b(z)\to1-e^{-z}$ uniformly as $b\to\infty$, using $b\log(1+z/b)\to z$ uniformly.

Let

$$
 \rho_n=b_n\sqrt n e^{nI_r}
 =\sqrt n e^{nJ_r}.
$$

The exact logarithmic gap obeys

$$
 \rho_nF_n(a)
 \ge\frac{\sqrt n}{\log(1+a)}
 \mathbb E_{R_\theta^n}
 \big[e^{-\theta T_n}g_{b_n}(a e^{T_n})\big],
 \tag{B.3.4}
$$

since $-\log(1-B_n)\ge B_n$. In particular the factor $b_n$ has completely canceled in this lower bound; ignoring this cancellation would give incorrect endpoint estimates.

## 4. Local-limit estimates

Apply the ordinary nonarithmetic interval LLT to the fixed centered summand $Y+r$ under $R_\theta$. For any fixed $D_0,E_0>0$ there are $c_0>0$ and $N$ such that

$$
 R_\theta^n\{T_n\in[x,x+1)\}\ge c_0/\sqrt n
 \tag{B.4.1}
$$

whenever $n\ge N$ and $|x|\le D_0\log(n+1)+E_0$. There is also a uniform bound over all $x$ of the same form with a finite upper constant $C_0$. The proof only uses these central-window consequences of Stone's theorem; no uniform large-deviation estimate is imported.

## 5. Uniform exclusion of $a\to0$

Take $a=e^{-t}$, $t\ge2$, and $x=\min(t/2,\log n)$. On $[x,x+1)$, $z=ae^s\le1$ and $\log(1+a)\le a$. By (B.3.3),

$$
 \frac{e^{-\theta s}g_{b_n}(a e^s)}{\log(1+a)}
 \ge\tfrac12 e^{(1-\theta)s}
 \ge\tfrac12 e^{(1-\theta)x}.
$$

Combining (B.3.4) and (B.4.1) yields the bound, uniform over $t\ge2$,

$$
 \rho_nF_n(e^{-t})
 \ge\frac{c_0}{2}
 \exp\big[(1-\theta)\min(t/2,\log n)\big].
 \tag{B.5.1}
$$

For $t=t_n\to\infty$ this tends to infinity. The proof includes arbitrarily rapid decay of $a_n$.

## 6. Uniform exclusion of $a\to\infty$

Write $a=e^t$ and let $M=\max_y|Y(y)|$. We use the original, uncentered log-likelihood $S_n$ for the extreme regime. This prevents an artificial loss from separately estimating the growing kernel.

### 6.1. $t\ge2nM+1$

As $|S_n|\le nM$,

$$
 A_n(e^t)=\mathbb E_P(1+e^{t+S_n})^{-b_n}
 \le e^{-b_n(t-nM)}.
$$

Thus

$$
 F_n(e^t)\ge\frac{t-nM}{\log(1+e^t)}\ge\tfrac12
 \quad(t\ge2nM+1).
 \tag{B.6.1}
$$

This inequality is exact for every $b_n>0$. It remains valid when $a$ is doubly exponential in $n$. In this regime the normalized gap is at least $\rho_n/2$, and therefore diverges. No comparison involving $e^{-nM}$ is needed.

### 6.2. $T_\theta\le t\le2nM+1$

Choose a fixed $T_\theta$ large enough that

$$
 t-(2/\theta)\log t-1\ge0
$$

for all $t\ge T_\theta$; such a threshold exists. Use the interval

$$
 I_t=[-(2/\theta)\log t-1,-(2/\theta)\log t).
$$

There $ae^s\ge1$, $e^{-\theta s}\ge t^2$, $g_{b_n}(ae^s)\ge\tfrac12$, and $\log(1+e^t)\le2t$ once $t\ge1$. Consequently

$$
 \frac{e^{-\theta s}g_{b_n}(e^{t+s})}{\log(1+e^t)}
 \ge t/4.
$$

Because $t\le2nM+1$, the interval center is $O(\log n)$ uniformly. Thus (B.4.1) applies with constants depending only on the fixed channel, $r$ and $\theta$:

$$
 \rho_nF_n(e^t)\ge c_0t/4.
 \tag{B.6.2}
$$

Together (B.6.1)-(B.6.2) give

$$
 \rho_nF_n(e^t)\ge\min(c_0t/4,\rho_n/2)
 \qquad(t\ge T_\theta)
 \tag{B.6.3}
$$

for all sufficiently large $n$. Every $t_n\to\infty$ has diverging normalized objective. This closes global coercivity at both endpoints.

## 7. Compact-uniform kernel limit and prefactor

Fix a compact interval $K=[a_-,a_+]$ in $(0,\infty)$, and put

$$
 h_{n,a}(s)=e^{-\theta s}g_{b_n}(a e^s),
 \qquad h_a(s)=e^{-\theta s}(1-e^{-a e^s}).
$$

On every compact $s$ interval, $h_{n,a}\to h_a$ uniformly jointly in $a\in K$. By (B.3.2), both families have the common envelope

$$
 \begin{cases}
 e^{-\theta s},&s\ge0,\\
 a_+e^{(1-\theta)s},&s<0.
 \end{cases}
$$

This envelope is summable over unit intervals since $0<\theta<1$. The uniform concentration upper bound from the LLT controls its tails uniformly after multiplication by $\sqrt n$. On compact $s$ intervals, joint uniform convergence of the kernels and the interval LLT establish convergence of the expectations. A finite $a$-net, or joint uniform continuity, makes it uniform on $K$. Therefore

$$
 \sup_{a\in K}\left|
 \sqrt n\,\mathbb E_R h_{n,a}(T_n)
 -\frac1{\sigma_r\sqrt{2\pi}}\int_{\mathbb R}h_a(s)\,ds
 \right|\longrightarrow0.
 \tag{B.7.1}
$$

The integral is elementary:

$$
 \int_{\mathbb R}h_a(s)\,ds
 =a^\theta\int_0^\infty u^{-\theta-1}(1-e^{-u})\,du
 =\frac{\Gamma(1-\theta)}{\theta}a^\theta.
 \tag{B.7.2}
$$

Integration by parts is legitimate: near zero the boundary term is $O(u^{1-\theta})$, and at infinity it is $O(u^{-\theta})$. Because $I_r>0$, (B.3.1) and (B.7.1) imply $B_n=O(e^{-nI_r}/\sqrt n)$ uniformly on $K$. Expanding $-\log(1-B_n)$ shows that its quadratic remainder contributes only $O(e^{-nI_r}/\sqrt n)$ to the normalized objective. Hence

$$
 \sup_{a\in K}|\rho_nF_n(a)-G_r(a)|\longrightarrow0,
$$
$$
 G_r(a)=\frac{\Gamma(1-\theta_r)}
 {\theta_r\sigma_r\sqrt{2\pi}}
 \frac{a^{\theta_r}}{\log(1+a)}.
 \tag{B.7.3}
$$

## 8. Optimization and finite-$n$ existence

For each $n$, $b_n$ is a finite positive number. Strict Jensen for $x\mapsto(1+ax)^{-b_n}$, applied to $X=e^{S_n}$ with $\mathbb E_P X=1$ and $X$ nonconstant, gives $0<F_n(a)<1$. The fixed-$n$ limits as $a\to0$ and $a\to\infty$ are both one, by the same finite-sum expansions as in the fixed-order note. Thus an interior global minimizer exists for every $n$.

Evaluating at one fixed $a$ gives a bounded sequence $\rho_n\inf F_n$. Sections 5-6 then force every optimizing or normalized-$o(1)$-approximate optimizing sequence into a fixed compact subset of $(0,\infty)$. Compact-uniform convergence (B.7.3) therefore permits passage of the infimum and transfers every subsequential optimizer to a minimizer of $G_r$.

For $g_\theta(a)=a^\theta/\log(1+a)$, the derivative has the sign of

$$
 u_\theta(a)=\theta(1+a)\log(1+a)-a.
$$

Now $u_\theta(0)=0$, $u_\theta'(a)=\theta\log(1+a)+\theta-1$, and $u_\theta''(a)=\theta/(1+a)>0$. Thus $u_\theta$ initially decreases, then strictly increases to infinity, with exactly one positive zero. Also $g_\theta$ tends to infinity at both endpoints. Consequently this root is the unique global minimizer, all minimizing $a_n$ converge to it, and (B.1.1) follows.

## 9. Nonsymmetric extension and boundaries

The same oriented-pair theorem applies to nonsymmetric $P,Q$. Let $\theta_0\in(0,1)$ be the zero of $\psi'$. For any fixed $0<r<D(P\|Q)$, the saddle $\theta_r\in(0,\theta_0)$ is defined by $\psi'(\theta_r)=-r$. Every proof above uses only $0<\theta_r<1$, finite positive support and nonarithmeticity; output symmetry only places the saddle below one half.



# The critical Kullback--Leibler window

## Statement and notation

Let $P$ and $Q$ be distinct, strictly positive probability distributions on a finite alphabet. In this section we use the log-likelihood ratio

$$
Z=\log\frac{P(X)}{Q(X)},
\qquad X\sim P.
$$

Thus $Z=-Y$ if $Y=\log(Q/P)$ is used elsewhere. Define

$$
D=\mathbb E_P Z=D(P\|Q)>0,
\qquad
\sigma^2=\operatorname{Var}_P(Z)>0,
\qquad
S_n=\sum_{i=1}^{n}Z_i,
$$

where the $Z_i$ are independent copies of $Z$. The variance is positive because a constant log-likelihood ratio, together with normalization, would force $P=Q$.

Fix $\zeta\in\mathbb R$, and set

$$
b_n=\exp\bigl(nD+\zeta\sigma\sqrt n\bigr),
\qquad
\alpha_n=1+b_n.
$$

For $U>0$, write

$$
c(U)=e^U-1,
\qquad
A_n(U)=\mathbb E_P\left[(1+c(U)e^{-S_n})^{-b_n}\right],
\qquad
K_n(U)=-\log A_n(U),
\qquad
G_n(U)=\frac{K_n(U)}{b_nU}.
$$

Let $\Phi$ and $\phi$ denote the standard normal distribution function and density, respectively. Then

$$
\lim_{n\to\infty}b_n\sigma\sqrt n\inf_{U>0}G_n(U)
=\kappa(\zeta),
\qquad
\kappa(\zeta)=\min_{t>0}\frac{-\log\Phi(-\zeta-t)}{t}.
$$

The limiting objective has a unique minimizer $t_\zeta$. Every sequence of exact minimizers $U_n$, and every sequence satisfying

$$
b_n\sigma\sqrt n
\left(G_n(U_n)-\inf_{U>0}G_n(U)\right)\longrightarrow0,
$$

obeys

$$
\frac{U_n}{\sigma\sqrt n}\longrightarrow t_\zeta.
$$

For a finite, strictly positive binary-input symmetric-output channel $W$ with rows $P,Q$, the support and antipodal reductions identify the optimized binary-mixture gap with the tensor-power contraction deficit. Consequently,

$$
b_n\sigma\sqrt n
\left[1-\eta_{\alpha_n}\left(W^{\otimes n}\right)\right]
\longrightarrow\kappa(\zeta).
$$

No nonlattice assumption is required: the same critical-window law holds for lattice and nonlattice log-likelihood ratios. At $\zeta=0$, numerical evaluation gives

$$
t_0\approx1.330695845160533,
\qquad
\kappa(0)\approx1.7959308448.
$$

## Uniform convergence on compact intervals

Define

$$
X_n=\frac{S_n-nD}{\sigma\sqrt n},
\qquad
U=t\sigma\sqrt n.
$$

Fix $0<t_-<t_+<\infty$ and $\varepsilon>0$. For $t\in[t_-,t_+]$, consider the random kernel

$$
k_n(X_n,t)=\left(1+c(U)e^{-S_n}\right)^{-b_n}.
$$

On the event $X_n\ge\zeta+t+\varepsilon$,

$$
b_nc(U)e^{-S_n}
\le e^{-\varepsilon\sigma\sqrt n}.
$$

The inequalities $\log(1+x)\le x$ and $e^{-x}\ge1-x$ therefore imply

$$
k_n(X_n,t)\ge1-e^{-\varepsilon\sigma\sqrt n}.
$$

On the event $X_n\le\zeta+t-\varepsilon$, for all sufficiently large $n$, uniformly over the stated interval of $t$,

$$
b_nc(U)e^{-S_n}
\ge\frac12e^{\varepsilon\sigma\sqrt n}.
$$

For every $b>0$ and $x\ge0$,

$$
b\log(1+x)\ge\min\left\{\frac{bx}{2},\,b\log2\right\}.
$$

It follows that, on this second event,

$$
k_n(X_n,t)
\le
\exp\left[-\min\left\{
\frac14e^{\varepsilon\sigma\sqrt n},\,b_n\log2
\right\}\right].
$$

Both errors tend to zero uniformly in $t\in[t_-,t_+]$. The central limit theorem and continuity of $\Phi$ give

$$
\sup_{x\in\mathbb R}
\left|\mathbb P(X_n\le x)-\Phi(x)\right|\longrightarrow0.
$$

Sandwiching the expectation of the kernel between the normal-tail approximations at $\zeta+t+\varepsilon$ and $\zeta+t-\varepsilon$, and then letting $\varepsilon\downarrow0$, yields

$$
\sup_{t\in[t_-,t_+]}
\left|A_n(t\sigma\sqrt n)-\Phi(-\zeta-t)\right|
\longrightarrow0.
$$

The limit is bounded away from zero on this compact interval. Applying $-\log$ and dividing by $t$ thus preserves uniform convergence:

$$
\sup_{t\in[t_-,t_+]}
\left|
\frac{K_n(t\sigma\sqrt n)}{t}
-\frac{-\log\Phi(-\zeta-t)}{t}
\right|\longrightarrow0.
$$

## Excluding the small-$U$ boundary

For fixed $n$, regard the logarithmic transform as a function of $c\ge0$:

$$
\mathcal K_n(c)
=-\log\mathbb E_P\left[(1+cR)^{-b_n}\right],
\qquad R=e^{-S_n}>0.
$$

Thus $K_n(U)=\mathcal K_n(c(U))$. Let $\mathbb E_c$ denote expectation under weights proportional to $(1+cR)^{-b_n}$, and put $V=R/(1+cR)$. Differentiation of the finite sum gives

$$
\mathcal K_n'(c)=b_n\mathbb E_cV>0,
$$

$$
\mathcal K_n''(c)
=-b_n\mathbb E_c(V^2)-b_n^2\operatorname{Var}_c(V)<0.
$$

Hence $\mathcal K_n$ is increasing and concave, with $\mathcal K_n(0)=0$. At $U=1$, the same threshold argument, now with $\log c(U)=O(1)$, gives

$$
K_n(1)\longrightarrow k_\zeta:=-\log\Phi(-\zeta)>0.
$$

For $0<U\le1$, concavity and $c(U)\ge U$ imply

$$
\frac{K_n(U)}{U}
\ge\frac{K_n(1)}{e-1}.
$$

Therefore $\sigma\sqrt n K_n(U)/U$ diverges uniformly on this interval. If $1<U=o(\sqrt n)$, monotonicity instead gives

$$
\sigma\sqrt n\frac{K_n(U)}{U}
\ge\sigma\sqrt n\frac{K_n(1)}{U}
\longrightarrow\infty.
$$

These two bounds exclude every sequence with $U/\sqrt n\to0$, including sequences for which $U$ tends to zero exponentially or faster.

## Excluding the large-$U$ boundary

Let

$$
z_{\min}=\min Z,
\qquad M=\max Z,
\qquad R_Z=M-z_{\min}>0,
$$

and fix $C>2M+2$. For $U\ge1$, split the expectation at

$$
H_n(U)=\log b_n+\log c(U)-\frac U2.
$$

If $S_n<H_n(U)$, then $b_nc(U)e^{-S_n}\ge e^{U/2}$. The elementary logarithmic bound used above gives

$$
A_n(U)
\le\mathbb P\left(S_n\ge H_n(U)\right)
+\exp\left[-\min\left\{\frac12e^{U/2},\,b_n\log2\right\}\right].
$$

Suppose $U/\sqrt n\to\infty$ and $U\le Cn$. Since $\zeta$ is fixed and

$$
\log c(U)=U+\log(1-e^{-U}),
$$

eventually $H_n(U)\ge nD+U/3$. Hoeffding's inequality yields

$$
\mathbb P\left(S_n\ge H_n(U)\right)
\le\exp\left(-\frac{2U^2}{9nR_Z^2}\right).
$$

Along every such sequence, the second term in the bound for $A_n(U)$ is eventually smaller than this quantity: $b_n$ grows exponentially in $n$, $e^{U/2}$ grows faster than every polynomial, and $U^2/n\le C^2n$. With $k=2/(9R_Z^2)$, it follows that

$$
K_n(U)\ge\frac{kU^2}{n}-\log2,
$$

and hence

$$
\sigma\sqrt n\frac{K_n(U)}{U}
\ge
\frac{k\sigma U}{\sqrt n}
-\frac{\sigma\sqrt n\log2}{U}
\longrightarrow\infty.
$$

For $U>Cn$, use the pointwise bound $S_n\le nM$. Since $\log c(U)\ge U-\log2$ for $U\ge\log2$, for all sufficiently large $n$,

$$
b_n\log\left(1+c(U)e^{-S_n}\right)
\ge b_n\bigl[\log c(U)-nM\bigr]
\ge\frac{b_nU}{2}.
$$

Thus $K_n(U)\ge b_nU/2$, and the normalized objective is at least $b_n\sigma\sqrt n/2\to\infty$. This covers arbitrarily fast growth of $U$.

## Convergence of minima and optimizers

For each fixed $n$, the normalized objective

$$
b_n\sigma\sqrt n\,G_n(U)
=\sigma\sqrt n\frac{K_n(U)}{U}
$$

is continuous for $U>0$ and tends to $b_n\sigma\sqrt n$ at both endpoints. At $U\downarrow0$, this uses $\mathbb E_Pe^{-S_n}=1$; at $U\to\infty$, it follows from the finite positive alphabet.

A fixed comparison point $U=t\sigma\sqrt n$ gives a bounded normalized value for all sufficiently large $n$. The two boundary exclusions show that every minimizing or asymptotically minimizing sequence remains in a compact subset of the rescaled variable $t=U/(\sigma\sqrt n)$. Uniform convergence on compact sets therefore proves convergence of the minima and convergence of optimizers to the limiting minimizer set.

## Uniqueness of the limiting optimizer

Write

$$
h(x)=-\log\Phi(-x),
\qquad
\lambda(x)=\frac{\phi(x)}{\Phi(-x)}.
$$

Then

$$
h'(x)=\lambda(x)>0,
\qquad
h''(x)=\lambda(x)\bigl[\lambda(x)-x\bigr]>0.
$$

For $x\le0$, the last inequality is immediate. For $x>0$,

$$
\Phi(-x)=\int_x^\infty\phi(u)\,du
<\frac1x\int_x^\infty u\phi(u)\,du
=\frac{\phi(x)}{x},
$$

so $\lambda(x)>x$. The derivative of $h(\zeta+t)/t$ has numerator

$$
N(t)=t\,h'(\zeta+t)-h(\zeta+t),
\qquad
N'(t)=t\,h''(\zeta+t)>0.
$$

As $t\downarrow0$, $N(t)\to-h(\zeta)<0$. The Gaussian Chernoff bound gives $h(x)\ge x^2/2$ for $x\ge0$, so $h(\zeta+t)/t\to\infty$ as $t\to\infty$. Its strictly increasing derivative numerator cannot remain nonpositive. Therefore $N$ has exactly one zero $t_\zeta$, which is the unique minimizer. It is characterized by

$$
t_\zeta
\frac{\phi(\zeta+t_\zeta)}{\Phi(-\zeta-t_\zeta)}
=-\log\Phi(-\zeta-t_\zeta).
$$

The theorem is for fixed $\zeta\in\mathbb R$; it makes no uniform assertion for unbounded $\zeta$.


# The high-order interior regime

## Statement and notation

Let $P,Q$ be distinct, strictly positive probability distributions on a finite alphabet. Under $P$, define

$$
Y=\log\frac{Q(X)}{P(X)},
\qquad X\sim P,
\qquad
S_n=\sum_{i=1}^{n}Y_i,
$$

where the $Y_i$ are independent copies of $Y$. Write

$$
\psi(\theta)=\log\mathbb E_Pe^{\theta Y},
\qquad
D=-\psi'(0)>0,
\qquad
M=-\min Y>0,
\qquad
\ell=-\log\mathbb P_P(Y=-M)>0.
$$

Fix $r\in(D,M)$, and put $b_n=e^{nr}$. For $a>0$, let

$$
U=\log(1+a),
\qquad
A_n(a)=\mathbb E_P\left[(1+ae^{S_n})^{-b_n}\right],
\qquad
L_n(a)=-\log A_n(a).
$$

The optimized binary-mixture contraction gap is

$$
\inf_{a>0}\frac{L_n(a)}{b_n\log(1+a)}.
$$

There is a unique $\beta>0$ such that

$$
\psi(-\beta)=r\beta,
\qquad\text{equivalently}\qquad
D_{1+\beta}(P\|Q)=r.
$$

Define

$$
u_*=-\psi'(-\beta)-r.
$$

Then $0<u_*<M-r$, and

$$
\lim_{n\to\infty}\inf_{a>0}
\frac{L_n(a)}{\log(1+a)}=\beta.
$$

Every sequence of exact minimizers, and every sequence $a_n>0$ satisfying

$$
\frac{L_n(a_n)}{\log(1+a_n)}
-\inf_{a>0}\frac{L_n(a)}{\log(1+a)}
\longrightarrow0,
$$

obeys

$$
\frac{\log(1+a_n)}{n}\longrightarrow u_*.
$$

In particular, the corresponding reference mass satisfies

$$
q_n=\frac{1}{1+a_n}
=\exp\bigl[-nu_*+o(n)\bigr].
$$

The result holds for arithmetic and nonarithmetic log-likelihood ratios. For a finite, strictly positive binary-input symmetric-output channel $W$ with rows $P,Q$, the support and antipodal reductions identify the displayed infimum with

$$
b_n\left[1-\eta_{b_n+1}\left(W^{\otimes n}\right)\right].
$$

## The rate function and its tangent solution

Let

$$
I(x)=\sup_{\theta\in\mathbb R}\bigl\{\theta x-\psi(\theta)\bigr\}.
$$

On the interior of the convex hull of the support of $Y$, the rate function $I$ is smooth and strictly convex, with its unique minimum at $-D$. The function

$$
\beta\longmapsto\frac{\psi(-\beta)}{\beta},
\qquad\beta>0,
$$

is strictly increasing, since it is the secant slope from the origin of the strictly convex function $\beta\mapsto\psi(-\beta)$. Its limits at zero and infinity are $D$ and $M$, respectively. Thus the stated $\beta$ exists uniquely for every $D<r<M$.

Strict convexity also gives

$$
-\psi'(-\beta)
>\frac{\psi(-\beta)}{\beta}=r,
$$

while finite support and strict positivity imply $-\psi'(-\beta)<M$. Hence $0<u_*<M-r$.

For every $0<u\le M-r$, evaluating the Legendre transform at $-\beta$ gives

$$
I(-r-u)
\ge\beta(r+u)-\psi(-\beta)
=\beta u.
$$

Equality holds exactly when $u=u_*$. At the endpoint,

$$
I(-M)=\ell,
\qquad
\frac{\ell}{M-r}>\beta,
$$

because the unique equality point is interior. Therefore $u_*$ uniquely minimizes

$$
u\longmapsto\frac{I(-r-u)}{u},
\qquad 0<u\le M-r,
$$

without requiring differentiability of $I$ at the endpoint.

## The soft-threshold Laplace limit

Suppose $U_n/n\to u\in(0,M-r)$, with $a_n=e^{U_n}-1$. We claim that

$$
\frac{L_n(a_n)}{n}\longrightarrow I(-r-u).
$$

### Lower bound

Fix $\delta>0$ small enough that $-r-u+\delta<-D$. For all sufficiently large $n$, on the event

$$
\frac{S_n}{n}\ge-r-u+\delta,
$$

the quantity $x=a_ne^{S_n}$ satisfies $b_nx\ge e^{n\delta/2}$. Since

$$
\log(1+x)\ge\min\{x/2,\log2\},
$$

the kernel on this event is at most

$$
(1+x)^{-b_n}
\le\exp\left[-\min\left\{\frac12e^{n\delta/2},\,b_n\log2\right\}\right].
$$

Consequently,

$$
A_n(a_n)
\le\mathbb P\left(\frac{S_n}{n}<-r-u+\delta\right)
+\exp\left[-\min\left\{\frac12e^{n\delta/2},\,b_n\log2\right\}\right].
$$

The remainder is superexponentially small in $n$. The finite-alphabet Cramér upper bound therefore yields

$$
\liminf_{n\to\infty}\frac{L_n(a_n)}{n}
\ge I(-r-u+\delta).
$$

Letting $\delta\downarrow0$ proves the required lower bound.

### Upper bound

For sufficiently small $\delta>0$, the threshold $-r-u-\delta$ remains in the interior of the support interval. On the event

$$
\frac{S_n}{n}\le-r-u-\delta,
$$

we have, for all sufficiently large $n$,

$$
b_na_ne^{S_n}\le e^{-n\delta/2}.
$$

Using $\log(1+x)\le x$, the kernel is at least

$$
(1+a_ne^{S_n})^{-b_n}
\ge\exp\bigl[-e^{-n\delta/2}\bigr].
$$

Apply the Cramér lower bound to an open left interval ending just below $-r-u-\delta$. After an arbitrarily small adjustment of the interval endpoint, this gives

$$
\limsup_{n\to\infty}\frac{L_n(a_n)}{n}
\le I(-r-u-\delta).
$$

Letting $\delta\downarrow0$ proves the claimed limit. This argument uses the standard finite-alphabet large-deviation principle, which also follows from multinomial type bounds, and applies equally to arithmetic and nonarithmetic laws.

### The support endpoint

If instead $U_n/n\to M-r$, the lower-bound argument gives

$$
\liminf_{n\to\infty}\frac{L_n(a_n)}{n}\ge I(-M)=\ell.
$$

Only this endpoint lower bound is needed; no uniform equality at the endpoint is assumed.

## Concavity excludes all $U_n=o(n)$

For fixed $n$, set $X=e^{S_n}>0$. Let $\mathbb E_a$ denote expectation under weights proportional to $(1+aX)^{-b_n}$, and write $V=X/(1+aX)$. Differentiation of the finite sum gives

$$
L_n'(a)=b_n\mathbb E_aV>0,
$$

$$
L_n''(a)
=-b_n\mathbb E_a(V^2)-b_n^2\operatorname{Var}_a(V)<0.
$$

Thus $L_n$ is increasing and concave, with $L_n(0)=0$. The same soft-threshold argument at the fixed value $a=1$ yields

$$
\frac{L_n(1)}{n}\longrightarrow I(-r)>0.
$$

When $0<a\le1$, concavity gives $L_n(a)\ge aL_n(1)$, while $\log(1+a)\le a$. Hence

$$
\frac{L_n(a)}{\log(1+a)}\ge L_n(1)\longrightarrow\infty.
$$

When $a\ge1$ but $U=\log(1+a)=o(n)$, monotonicity gives

$$
\frac{L_n(a)}{U}\ge\frac{L_n(1)}{U}\longrightarrow\infty.
$$

These bounds exclude every sequence $U_n=o(n)$, including those for which $a_n$ tends to zero at an arbitrary rate.

## Finite support excludes large $U_n/n$

Since $S_n\ge-nM$ pointwise,

$$
L_n(a)\ge b_n\log(1+ae^{-nM}).
$$

For $0<c<1$, the function

$$
a\longmapsto\frac{\log(1+ca)}{\log(1+a)}
$$

is increasing. Indeed, with $U=\log(1+a)$, the numerator becomes

$$
f(U)=\log(1-c+ce^U).
$$

This function is convex and satisfies $f(0)=0$, so $f(U)/U$ is increasing for $U>0$.

Fix $\delta>0$. For every $U\ge n(M-r+\delta)$, the preceding bounds and monotonicity imply

$$
\frac{L_n(a)}{U}
\ge
\frac{b_n\log\left(1+
\left(e^{n(M-r+\delta)}-1\right)e^{-nM}\right)}
{n(M-r+\delta)}.
$$

If $0<\delta<r$, the right-hand side is asymptotic to

$$
\frac{e^{n\delta}}{n(M-r+\delta)},
$$

which diverges. If $\delta\ge r$, use any smaller positive $\delta'<r$; the same divergence holds uniformly on the original region. Thus every near-minimizing sequence with bounded objective has $U_n/n$ bounded away from zero and satisfies

$$
\frac{U_n}{n}\le M-r+o(1).
$$

## Convergence of the infimum and the optimizer

The trial sequence $U_n=nu_*$ gives

$$
\limsup_{n\to\infty}\inf_{a>0}
\frac{L_n(a)}{\log(1+a)}
\le\frac{I(-r-u_*)}{u_*}=\beta.
$$

Take any minimizing or asymptotically minimizing sequence. The preceding exclusions place every subsequential limit $u$ of $U_n/n$ in $(0,M-r]$. The soft-threshold lower bound, including its endpoint form, gives along that subsequence

$$
\liminf_{n\to\infty}\frac{L_n(a_n)}{U_n}
\ge\frac{I(-r-u)}{u}\ge\beta.
$$

Equality is possible only at $u=u_*$. Compactness therefore proves both convergence of the infimum to $\beta$ and convergence of every near-minimizing $U_n/n$ to $u_*$.


# Proof E: Maximum-likelihood endpoint and saturation

## 1. Scope and definitions

Let $P$ and $Q$ be distinct strictly positive probability distributions on a finite alphabet $Y$. No output symmetry or nonlattice condition is needed for the analytic statements below. Set

$$
R(y)=\frac{Q(y)}{P(y)},\qquad
M=-\log\min_y R(y)=D_\infty(P\|Q)>0.
$$

Write

$$
\rho=e^{-M},\quad
\mathcal A=\{y:R(y)=\rho\},\quad
p_*=P(\mathcal A),\quad \ell=-\log p_*.
$$

Because $P$ and $Q$ are distinct, $0<\rho<1$ and $0<p_*<1$. In particular $M$ and $\ell$ are positive and finite. For iid samples $Y_1,\ldots,Y_n$ from $P$ define

$$
R_n=\prod_{j=1}^nR(Y_j),\qquad \varepsilon_n=\rho^n=e^{-nM}.
$$

For $b>0$, $a>0$ and $U=\log(1+a)$, let

$$
A_{n,b}(a)=\mathbb E_{P^n}(1+aR_n)^{-b},\qquad
L_{n,b}(a)=-\log A_{n,b}(a),
$$

$$
G_{n,b}(a)=\frac{L_{n,b}(a)}{b\log(1+a)},
\qquad g_{n,b}=\inf_{a>0}G_{n,b}(a).
$$

The relation to the two-row order-$\alpha$ Renyi coefficient uses $b=\alpha-1$ and $q=\exp(-U)=1/(1+a)$. For $\nu=\delta_P$ and $\mu=q\delta_P+(1-q)\delta_Q$, direct substitution gives the contraction defect $G$. The Dirac/two-point support reduction is inherited from Vandenbroucque, Esposito and Gastpar, arXiv:2609.34570, Theorem 6. Identifying this two-row optimization with a particular full product-channel coefficient must be justified separately by the BISO reduction proved above. The results here establish the complete optimization over $a$ for the displayed functional; they do not silently substitute a candidate prior for the infimum.

## 2. Two elementary global lemmas

### Lemma 1: atomic sandwich

For every $n$, $b$ and $a$,

$$
b\log(1+a\varepsilon_n)
\ \le L_{n,b}(a)\ \le
n\ell+b\log(1+a\varepsilon_n). \tag{E.2.1}
$$

**Proof.** Since $R_n\ge\varepsilon_n$, every kernel in the expectation is at most $(1+a\varepsilon_n)^{-b}$. This proves the lower bound on $L$. The event that every $Y_j$ lies in $\mathcal A$ has probability $p_*^n$ and $R_n=\varepsilon_n$ there. Keeping this event in the expectation proves the upper bound. This reasoning includes all other atoms rather than assuming they are negligible. QED.

In particular, for $0<\varepsilon_n<1$, concavity of the logarithm yields

$$
\log(1+a\varepsilon_n)
\ge \varepsilon_n\log(1+a),
$$

and hence

$$
g_{n,b}\ge\varepsilon_n. \tag{E.2.2}
$$

### Lemma 2: monotonicity and concavity of L

For fixed $n,b$, $L(a)$ is increasing and concave on $[0,\infty)$, with $L(0)=0$. Consequently, for $0<a\le1$,

$$
\frac{L(a)}{\log(1+a)}\ge L(1). \tag{E.2.3}
$$

**Proof.** Use the tilted probability weights proportional to $P^n(y)(1+aR_n(y))^{-b}$, and write $\mathbb E_a$ for expectation under those weights and $T_a=R_n/(1+aR_n)$. Finite alphabet differentiation gives

$$
L'(a)=b\mathbb E_aT_a>0,
$$

$$
L''(a)=-b\mathbb E_aT_a^2-b^2\operatorname{Var}_a(T_a)\le0.
$$

Concavity implies $L(a)\ge aL(1)$ for $a\in[0,1]$, while $\log(1+a)\le a$. QED.

### Lemma 3: an increasing logarithmic ratio

For $b>1$ the function

$$
h_b(a)=\frac{\log(1+a/b)}{\log(1+a)}
$$

is strictly increasing on $(0,\infty)$.

**Proof.** The ratio of derivatives of numerator and denominator is $(1+a)/(b+a)$, strictly increasing. Equivalently, $h_b(a)$ is the average of that increasing function on $[0,a]$ with positive weight $1/(1+x)$. Differentiating this weighted average proves the assertion. QED.

## 3. Endpoint theorem: b_n = exp(nM)

### Theorem E

If $b_n=\exp(nM)=\varepsilon_n^{-1}$, then

$$
b_n g_{n,b_n}\sim\frac{n\ell}{\log n}. \tag{E.3.1}
$$

Every relatively asymptotically optimal sequence $a_n$, meaning

$$
G_{n,b_n}(a_n)/g_{n,b_n}\longrightarrow1,
$$

satisfies

$$
\frac{\log(1+a_n)}{\log n}\longrightarrow1. \tag{E.3.2}
$$

An explicit asymptotically optimal construction is

$$
U_n=1+W_0\!\left(\frac{n\ell-1}{e}\right),\qquad
a_n=e^{U_n}-1,\qquad q_n=e^{-U_n}, \tag{E.3.3}
$$

for all sufficiently large $n$, where $W_0$ is the real principal Lambert $W$ function. For this construction $q_n\sim\log n/(n\ell)$. That last equivalent is asserted for this explicit construction; (E.3.2) alone does not assert the same finer equivalent for every optimal prior.

In fact, the endpoint value admits the stronger expansion

$$
b_ng_{n,b_n}=e^{U_n}+o(1/\log n). \tag{E.3.3a}
$$

Every **exact** minimizing prior, written $\widehat U_n=\log(1+\widehat a_n)$, satisfies

$$
\widehat U_n-U_n\longrightarrow0,\qquad
\widehat q_n/e^{-U_n}\longrightarrow1. \tag{E.3.3b}
$$

Thus its mass satisfies $\widehat q_n\sim\log n/(n\ell)$. Exactness of minimization matters in (E.3.3b): an arbitrary relatively asymptotically optimal sequence is only asserted to satisfy (E.3.2). Sections 3.1-3.5 first prove the coarse asymptotic and tightness, after which Section 3.6 proves the sharpening without circular localization.

### 3.1. Control of the non-minimal atoms

The key estimate is

$$
L_{n,b_n}(1)=n\ell+O((\log n)^2). \tag{E.3.4}
$$

Let

$$
\tau=\min_{y\notin\mathcal A}\frac{R(y)}\rho>1,
\quad
K_n=\#\{j:Y_j\notin\mathcal A\}.
$$

Then $K_n$ has the binomial distribution with parameters $n$ and $1-p_*$, and

$$
R_n/\varepsilon_n\ge\tau^{K_n}.
$$

Take $k_n=\lceil3\log n/\log\tau\rceil$. For large $n$, $k_n<n$ and $\tau^{k_n}$ lies between $n^3$ and $\tau n^3$. Splitting at $K_n<k_n$ gives

$$
A_{n,b_n}(1)
\le\mathbb P(K_n<k_n)
+(1+\tau^{k_n}/b_n)^{-b_n}. \tag{E.3.5}
$$

Let $B=\max\{1,(1-p_*)/p_*\}$. The first term is bounded by

$$
p_*^n k_n(nB)^{k_n}
=\exp\{-n\ell+O((\log n)^2)\}. \tag{E.3.6}
$$

Since $b_n$ is exponential in $n$ while $\tau^{k_n}=O(n^3)$, $\log(1+x)\ge x/2$ applies to $x=\tau^{k_n}/b_n$ for large $n$. Thus the second term in (E.3.5) is at most $\exp(-n^3/2)$. This proves the needed upper bound on $A$. Conversely, its all-minimal-atom contribution gives

$$
A_{n,b_n}(1)\ge p_*^n(1+1/b_n)^{-b_n}
\ge e^{-n\ell-1}. \tag{E.3.7}
$$

Together, (E.3.5)-(E.3.7) establish (E.3.4). In particular, the possible combinatorial multiplicity of near-minimal product atoms is included in the estimate.

### 3.2. Explicit upper bound

Write $F_n(a)=b_nG_{n,b_n}(a)=L(a)/\log(1+a)$. By Lemma 1 and $\log(1+x)\le x$,

$$
F_n(e^U-1)\le\frac{n\ell+e^U-1}{U}. \tag{E.3.8}
$$

The $U_n$ in (E.3.3) solves $e^{U_n}(U_n-1)=n\ell-1$. Therefore the right side of (E.3.8) equals $e^{U_n}$. The defining equation implies $U_n/\log n\to1$ and

$$
e^{U_n}=\frac{n\ell-1}{U_n-1}
\sim\frac{n\ell}{\log n}. \tag{E.3.9}
$$

This proves the global infimum's limsup bound. No asymptotic evaluation of $A$ at this prior is necessary for the upper bound.

### 3.3. Uniform exclusion of small priors in a coordinates

Fix $\delta\in(0,1)$. If $0<a\le1$, Lemma 2 and (E.3.4) give $F_n(a)\ge n\ell+O((\log n)^2)$, which is much larger than the upper bound (E.3.9). If $1\le a\le n^{1-\delta}$, monotonicity of $L$ gives

$$
F_n(a)\ge\frac{L(1)}{\log(1+n^{1-\delta})}
=\left(\frac1{1-\delta}+o(1)\right)
\frac{n\ell}{\log n}. \tag{E.3.10}
$$

Hence no relatively asymptotically optimal sequence can have $a_n\le n^{1-\delta}$ infinitely often. This includes $a_n$ tending to zero at an arbitrary rate.

### 3.4. Uniform exclusion of all large-a escapes

For $a\ge n^{1+\delta}$, Lemmas 1 and 3 imply

$$
F_n(a)\ge b_nh_{b_n}(a)
\ge b_nh_{b_n}(n^{1+\delta})
\sim\frac{n^{1+\delta}}{(1+\delta)\log n}. \tag{E.3.11}
$$

The last expression is much larger than (E.3.9). This bound is uniform all the way to $a=\infty$; it does not assume $a$ is polynomial or smaller than $b_n$.

### 3.5. Completion of the lower bound and optimizer scale

The preceding exclusions imply (E.3.2) for any relatively asymptotically optimal sequence. For such a sequence, $a_n\ge1$ eventually, and therefore

$$
F_n(a_n)\ge\frac{L(1)}{\log(1+a_n)}
\sim\frac{n\ell}{\log n}.
$$

Combined with (E.3.9), this proves (E.3.1). One may work with approximate minimizers without assuming attainment. Alternatively, for each $n$ the limits of $F_n(a)$ at both $a\downarrow0$ and $a\to\infty$ equal $b_n$, whereas (E.3.9) is smaller than $b_n$ for all large $n$; continuity therefore gives interior minimizers in that range. QED.

### 3.6. Uniform atomic approximation and sharp Lambert W law

By the already-proved coarse localization with $\delta=1/2$, every exact minimizer belongs to

$$
I_n=[n^{1/2},n^{3/2}]
$$

for all sufficiently large $n$. The explicit Lambert $W$ candidate also belongs to this interval. We now establish the uniform absolute estimate

$$
L_{n,b_n}(a)=n\ell+a+o(1),\qquad a\in I_n. \tag{E.3.12}
$$

Write $T=R_n/\varepsilon_n$. The ratio of a product atom's kernel to the all-minimal kernel is exactly

$$
\frac{(1+aT/b_n)^{-b_n}}{(1+a/b_n)^{-b_n}}
=\left(1+\frac{a(T-1)}{b_n+a}\right)^{-b_n}. \tag{E.3.13}
$$

For large $n$, all $a\in I_n$ satisfy $a\le b_n$. Put $x=a(T-1)/(b_n+a)$. If $x\le1$, then $\log(1+x)\ge x/2$ and $b_n/(b_n+a)\ge1/2$, so (E.3.13) is at most

$$
e^{-a(T-1)/4}
\le e^{-a K_n(\tau-1)/4}. \tag{E.3.14}
$$

The last inequality follows from $T\ge\tau^{K_n}$ and $\tau^k-1\ge k(\tau-1)$. If $x>1$, (E.3.13) is at most $2^{-b_n}$.

Let $h=(1-p_*)/p_*$ and $c_0=(\tau-1)/4$. Divide the whole expectation by its all-minimal contribution. The sum of all other atoms, using the two preceding bounds and allowing overcounting, is at most

$$
\delta_n=
\left(1+h e^{-c_0\sqrt n}\right)^n-1
+e^{n\ell-b_n\log2}\longrightarrow0, \tag{E.3.15}
$$

uniformly for $a\in I_n$. Hence, for some $\Delta_n(a)\in[0,\delta_n]$,

$$
A_{n,b_n}(a)=p_*^n(1+a/b_n)^{-b_n}
\bigl(1+\Delta_n(a)\bigr). \tag{E.3.16}
$$

Using $x-x^2/2\le\log(1+x)\le x$ for $x\ge0$ and $\log(1+\Delta)\le\Delta$ gives the explicit uniform sandwich

$$
n\ell+a-E_n\le L_{n,b_n}(a)\le n\ell+a,
\qquad
E_n=\frac{n^3}{2b_n}+\delta_n\longrightarrow0. \tag{E.3.17}
$$

This proves (E.3.12). Define

$$
H_n(U)=\frac{n\ell+e^U-1}{U}.
$$

Its derivative has the sign of $e^U(U-1)-(n\ell-1)$, whose derivative is $Ue^U>0$. Thus $H_n$ has a unique minimizer $U_n$ from (E.3.3), and its minimum is $e^{U_n}$. The actual infimum and this surrogate infimum both have minimizing arguments in $I_n$. Applying (E.3.17) at a true minimizer and the upper bound at the surrogate minimizer gives

$$
0\le e^{U_n}-b_ng_{n,b_n}
\le\frac{E_n}{\log(1+\sqrt n)}
=o(1/\log n). \tag{E.3.18}
$$

This proves (E.3.3a).

For the optimizer, the same comparison shows that $H_n(\widehat U_n)-H_n(U_n)$ tends to zero. The identity

$$
H_n(U_n+d)-H_n(U_n)
=\frac{e^{U_n}(e^d-1-d)}{U_n+d},\qquad U_n+d>0, \tag{E.3.19}
$$

follows directly from $e^{U_n}(U_n-1)=n\ell-1$. For any fixed positive $\delta$, the right side at $d=\delta$ or $d=-\delta$ tends to infinity. Since $H_n$ is strictly decreasing before $U_n$ and strictly increasing after $U_n$, an exact optimizer cannot have $\lvert\widehat U_n-U_n\rvert\ge\delta$ for infinitely many $n$. This proves (E.3.3b), and concludes the sharpened endpoint theorem. QED.

## 4. Superendpoint theorem: r > M

### Theorem S

Fix $r>M$ and $b_n=\exp(nr)$. Then

$$
g_{n,b_n}\sim e^{-nM}. \tag{E.4.1}
$$

An explicit asymptotically optimal prior is given by

$$
v_n=b_n\varepsilon_n=e^{n(r-M)},\quad
U_n=\sqrt{\frac{2n\ell}{v_n}},\quad
q_n=e^{-U_n},\quad a_n=e^{U_n}-1. \tag{E.4.2}
$$

In particular $q_n\to1$. This construction has the quantitative sandwich

$$
1\le\frac{g_{n,b_n}}{\varepsilon_n}
\le\frac{G_{n,b_n}(a_n)}{\varepsilon_n}
\le\frac{U_n}{2}+\frac{e^{U_n}-1}{U_n}
=1+U_n+O(U_n^2). \tag{E.4.3}
$$

**Proof.** The lower bound is (E.2.2), valid for every $a$ and hence for the infimum. The upper part of (E.2.1) yields

$$
\frac{G_{n,b_n}(a_n)}{\varepsilon_n}
\le\frac{n\ell}{v_n U_n}
+\frac{\log(1+a_n\varepsilon_n)}{\varepsilon_n U_n}
\le\frac{U_n}{2}+\frac{a_n}{U_n}.
$$

Since $r>M$, $U_n\to0$. Expanding $\exp(U_n)$ gives (E.4.3) and (E.4.1). The argument treats all competing priors through a global lower bound and all non-minimal product atoms through the atomic sandwich; no unverified domination approximation is used. QED.



# Reproducibility and verification boundaries

The executable finite checks are separated from the proofs of general claims.

- The rational certificate section of the primary program uses Python fractions to check 1,020 row pairs, 30 strict Hamming comparisons and 81 reciprocal-convexity identities. Those counts describe finite instances only.
- Floating diagnostics evaluate finite binomial or multinomial sums using logarithmic arithmetic. A grid with local refinement is explicitly labelled numerical optimization; it is not a certified global minimizer.
- An independent reviewer checked the likelihood-ratio reduction and the six asymptotic regimes, including all prior-boundary arguments, and recomputed selected examples with a separate program.
- The Lean supplement verifies the finite weighted reciprocal-convexity core. Its scope is identified by the exact declaration map and real compiler/axiom reports.

Full-paper Lean coverage remains unfinished. In particular, no Lean result is claimed for the cited support reduction, probability limit theorems, growing-order phase diagram, or asymptotic optimizer convergence. A successful algebraic-core build does not establish the paper's full formalization. This edition contains no Lean source or new build verification.

The two normal-window decimals were independently recomputed at high precision. The exact root and variational definitions, rather than rounded decimals, govern the mathematical statements.

# References

1. A. Vandenbroucque, A. R. Esposito and M. Gastpar. *Contraction of Rényi Divergences for Discrete Channels*. arXiv:2609.34570v1, 2026. Theorem 6(b), Theorem 7 and Corollary 3. <https://arxiv.org/html/2609.34570v1>.

2. Y. Polyanskiy and Y. Wu. *Strong data-processing inequalities for channels and Bayesian networks*. arXiv:1508.06025; author's published-version manuscript, particularly the product-BSC discussion and equations (39)-(41). <https://people.lids.mit.edu/yp/homepage/data/simple-IMA.pdf>.

3. L. Jin, A. R. Esposito and M. Gastpar. *Properties of the Strong Data Processing Constant for Rényi Divergence*. arXiv:2403.10656. <https://arxiv.org/abs/2403.10656>.

4. C. Hirche and O. Shaya. *Partial orders and contraction for BISO channels*. arXiv:2504.16726v2, 2026. <https://arxiv.org/html/2504.16726v2>.

5. R. H. Moore and A. R. Esposito. *Beyond Hypercontractivity: Stronger Communication Converses via Rényi Contraction*. arXiv:2610.13030, 2026. <https://arxiv.org/abs/2610.13030>.

6. C. Stone. *On local and ratio limit theorems*. Proceedings of the Fifth Berkeley Symposium on Mathematical Statistics and Probability, vol. II, part II, pp. 217-224. Corollary 1 on p. 218 supplies a location-uniform interval local limit theorem. Original indexed theorem text was retrieved; direct full-PDF retrieval was restricted. Related paper: *A local limit theorem for nonlattice multi-dimensional distribution functions*, Annals of Mathematical Statistics 36 (1965), 546-551, DOI:10.1214/aoms/1177700165. <https://digicoll.lib.berkeley.edu/nanna/record/113081/files/math_s5_v2_p2_article-15.pdf?registerDownload=1&version=1&withMetadata=0&withWatermark=0>.

7. R. R. Bahadur and R. Ranga Rao. *On deviations of the sample mean*. Annals of Mathematical Statistics 31 (1960), 1015-1027, DOI:10.1214/aoms/1177705674. Historical context for strong large-deviation asymptotics; the proof here explicitly uses the local-limit and finite-alphabet large-deviation arguments it states. <https://repository.ias.ac.in/27001/>.

8. W. Hoeffding. *Probability inequalities for sums of bounded random variables*. Journal of the American Statistical Association 58 (1963), 13-30, DOI:10.1080/01621459.1963.10500830. The bounded independent-sum inequality is used in the critical-window proof. <https://www.tandfonline.com/doi/abs/10.1080/01621459.1963.10500830>.

9. R. Lucchese, D. Varagnolo, J.-C. Delvenne and J. M. Hendrickx. *Network cardinality estimation using max consensus: the case of Bernoulli trials*. Proceedings of the 54th IEEE Conference on Decision and Control, 2015, pp. 895-901, DOI:10.1109/CDC.2015.7402342. Lemma 1 and equations (11)-(13) exhibit the same scalar optimizer $0.2031878699\ldots$ in a Fisher-information design problem. The inspected author PDF has a sign misprint in equation (9); the stated value and the objective and derivative in (11)-(13) determine the intended equation. <https://perso.uclouvain.be/julien.hendrickx/availablepublications/CDC15_1700_FI.pdf>.

The literature comparison is limited to the sources actually inspected. Lack of a matching result in the inspected sources is a bounded novelty assessment, not proof of global priority. The work is an AI-assisted research draft and has not been externally peer-reviewed. The Lean supplement is not included in this edition.

