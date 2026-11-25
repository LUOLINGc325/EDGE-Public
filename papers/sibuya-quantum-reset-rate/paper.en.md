# Sharp Sibuya Rates for Noncommuting Quantum Renewal Channels

*Full peripheral amplitudes and matched-state sharpness*

Research manuscript v1 · 24 November 2026

**Audience:** doctoral researchers in mathematical physics, probability and quantum information.  
**Status:** complete written proof with exact and numerical checks; not externally peer reviewed.

## Abstract

A quantum system evolves by a fixed channel between independent renewal events, at which a second channel acts. The event channel need not erase the state or commute with the free channel. An existing reduction theorem shows, under a unit-circle nonresonance condition (W), that this process becomes asymptotically equivalent to complete resetting at an effective state, but leaves its rate under a Sibuya clock open. We prove that, for every finite-dimensional pair of channels satisfying the same condition and every Sibuya parameter $0<\gamma<1$, the trace-norm reduction error is $O(t^{-\gamma})$. We identify its full leading oscillatory term and obtain a remainder $O(t^{-\min\{2\gamma,1\}})$. The proof uses the ordered renewal generating function, the finite peripheral spectrum of a channel, and a coefficient estimate proved by contour deformation. A noncommuting qubit example attains the exponent even when both processes start in the effective state. A second example consists entirely of unitary histories and satisfies (W) without a contracting word. The result concerns the error in the effective-reset description, which can decay faster than the effective process approaches its stationary state. All implied constants are for fixed channels and fixed $\gamma$; no uniform bound near failure of (W) is claimed.

## Plain-language overview

Random resets are useful for controlling a quantum system. A real reset may leave some of the old state behind, and the order of the reset and ordinary evolution can matter. An earlier theorem says that, after sufficiently many steps, such imperfect resets can often be represented by perfect resets to a different, effective state. That theorem does not say how quickly the representation becomes accurate.

We answer this question for a heavy-tailed family of waiting times. In this family the probability of an event after $n$ ordinary steps is $\gamma/(n+1)$, and the average waiting time is infinite. For sufficiently large $t$, the approximation error is bounded by a constant times $t^{-\gamma}$, with an explicit leading term determined by the channels. We also construct an imperfect-reset example that actually has this error scale, so the exponent cannot be improved for the class under study.

This is an asymptotic accuracy theorem. It does not, by itself, provide a numerical certificate that a particular device has reached a specified error after a given number of steps. That would additionally require a numerical bound on the constants for that device.

## 1. Problem, source and contribution

Wald, Yao, Platini, Hooley and Carollo studied discrete-time quantum dynamics interrupted by resets whose probabilities depend on the time since the last reset [2]. Their convention is that an event occupies a step: the event operation replaces the ordinary gate operation at that step. This convention matters for every formula below.

The research manuscript *Renewal resetting of quantum dynamics: a classification for complete resets, a reduction for jump channels, and critical time scales* [1] proves a general qualitative reduction for jump channels. Its Theorem 5.1 uses a nonresonance condition on the unit circle, denoted (W). Its Section 9, “Scope and open problems” (p. 24), explicitly leaves the Sibuya rate for that theorem open. The source is an unrefereed research manuscript, not an established external peer-review certification.

Our target is precisely this quantitative question. We retain its finite-dimensional setting, arbitrary completely positive trace-preserving channels, event-step convention and condition (W). Our contribution consists of:

1. the rate $O(t^{-\gamma})$ for the reduction error;
2. every leading peripheral-frequency coefficient, with a strictly smaller remainder;
3. a sharp noncommuting example with the same initial effective state in both processes.

The ordered renewal representation and qualitative reduction are inherited from [1] and the quantum renewal framework of [3]. The coefficient-extraction method belongs to classical singularity analysis [4]; a sufficient contour estimate is proved here to make the argument self-contained. We do not claim a new general renewal formalism or a new general transfer method. Within the literature checked, we did not identify an earlier statement of the result proved here. This is a bounded literature comparison, not a worldwide priority guarantee.

Algebraic tails in noncommuting quantum renewal dynamics are themselves established prior phenomena. Erdoğan and Savacı [5] analyse a continuous-time transmon model with Markovian dephasing, transverse unitary kicks and a Prabhakar waiting law. Under their specified pole and contour conditions, Section IV D, equations (96)–(97), and Appendix C6, equations (C37)–(C38), give directional response tails of orders $t^{-\alpha}$ and $t^{-1-\alpha}$. Those results estimate particular response components of that qubit model. The present theorem estimates the difference between an arbitrary finite-dimensional jump-channel process and its effective complete-reset process, for the discrete Sibuya clock under (W). The distinction is the estimated object, the channel class and the hypotheses; we make no claim to have discovered quantum-renewal power laws.

## 2. Model and notation

### 2.1 Channels and occupied event steps

Let $\mathcal H$ be a complex Hilbert space of finite dimension, and let $\Phi$ and $R$ be completely positive trace-preserving linear maps on its matrix algebra. The system starts at a density matrix $\rho_0$, at age zero. At each step, an ordinary step applies $\Phi$ and increases the age by one; an event applies $R$ and resets the age to zero. No additional $\Phi$ is applied during an event step.

The waiting times $L_1,L_2,\ldots$ between events are independent and identically distributed, independent of the quantum state, and take values in the positive integers. Conditional on a waiting time $\ell$, a complete cycle acts by

$$
B_\ell=R\Phi^{\ell-1}.
\tag{2.1}
$$

Write $\rho_t^{\mathrm{par}}$ for the density matrix averaged over all event histories at laboratory time $t\in\mathbb N_0$. The superscript identifies the jump-channel process; an event need not be a complete reset.

### 2.2 The Sibuya clock

Fix $0<\gamma<1$. The clock considered here has

$$
p_\ell=\Pr(L=\ell)=(-1)^{\ell-1}\binom\gamma\ell,
\qquad \ell\ge1,
\tag{2.2}
$$

and generating function

$$
P(w)=\sum_{\ell\ge1}p_\ell w^\ell=1-(1-w)^\gamma,
\qquad |w|<1.
\tag{2.3}
$$

Its survival and renewal sequences are

$$
s_n=\Pr(L>n)=\frac{(1-\gamma)_n}{n!},
\qquad
u_n=\frac{(\gamma)_n}{n!},
\tag{2.4}
$$

where $(a)_0=1$ and $(a)_n=a(a+1)\cdots(a+n-1)$. In particular $s_0=u_0=1$. The renewal recursion is

$$
u_n=\sum_{\ell=1}^n p_\ell u_{n-\ell},\qquad n\ge1.
\tag{2.5}
$$

These statements follow directly from

$$
\sum_{n\ge0}s_nw^n=(1-w)^{\gamma-1},\qquad
\sum_{n\ge0}u_nw^n=\frac1{1-P(w)}=(1-w)^{-\gamma}.
\tag{2.6}
$$

The conditional event probability at age $n$ is $p_{n+1}/s_n=\gamma/(n+1)$. Every positive waiting time has positive probability. The clock is therefore proper and aperiodic. Its mean is infinite because $s_n\sim n^{-\gamma}/\Gamma(1-\gamma)$.

### 2.3 Complete-reset comparison

For a density matrix $\rho$, define

$$
F_t(\rho)=\sum_{n=0}^t s_nu_{t-n}\Phi^n(\rho).
\tag{2.7}
$$

This is the averaged state of complete resetting to $\rho$, starting at $\rho$, under the same clock. Indeed, $u_{t-n}s_n$ is the probability that the last event was at $t-n$ and that no subsequent event occurred. Time zero is counted as an initial event. The coefficients sum to one, since their generating function is

$$
(1-w)^{\gamma-1}(1-w)^{-\gamma}=(1-w)^{-1}.
$$

The mean embedded channel is

$$
\overline B=\sum_{\ell\ge1}p_\ell R\Phi^{\ell-1}.
\tag{2.8}
$$

We will show that (W) makes its fixed density $\rho_{\mathrm{eff}}$ unique. The error of interest is

$$
E_t=\rho_t^{\mathrm{par}}-F_t(\rho_{\mathrm{eff}}).
\tag{2.9}
$$

The initial state $\rho_0$ in the first process is arbitrary. Section 6 proves optimality even with $\rho_0=\rho_{\mathrm{eff}}$.

### 2.4 Affine coordinates and the original condition (W)

Let $\mathcal V$ be the real vector space of traceless Hermitian matrices, and let $\mathcal V_{\mathbb C}$ be its complexification. Choose any fixed density $\sigma$ of $\Phi$, and write

$$
\begin{aligned}
T&=\Phi|_{\mathcal V},\qquad A=R|_{\mathcal V},\\
b&=R(\sigma)-\sigma,\qquad x_0=\rho_0-\sigma,\qquad c=x_0-b.
\end{aligned}
\tag{2.10}
$$

A fixed density exists: the Cesàro means $N^{-1}\sum_{j=0}^{N-1}\Phi^j(\omega)$, starting from any density $\omega$, have a convergent subsequence by compactness, and their images under $\Phi-I$ tend to zero. The same argument applies to $\overline B$.

Define the matrix-valued functions

$$
\begin{aligned}
M(w)&=\sum_{\ell\ge1}p_\ell w^\ell T^{\ell-1},\\
K(w)&=AM(w),\qquad H(w)=(I-K(w))^{-1}.
\end{aligned}
\tag{2.11}
$$

The assumption is exactly

$$
\boxed{\det_{\mathcal V_{\mathbb C}}(I-K(w))\ne0
\quad\text{for every }|w|=1.}
\tag{W}
$$

It excludes a traceless mode that persists through the averaged cycle with a phase locked to laboratory time. It does not require each cycle, or any finite product of cycles, to contract strictly. Section 7 gives an example where every history is unitary and (W) nevertheless holds.

All norms of density-matrix differences below are the trace norm $\|\cdot\|_1$, without the factor $1/2$ sometimes included in the definition of trace distance.

## 3. Main results

### Theorem 3.1 — Sharp reduction rate

Under the hypotheses of Section 2 and condition (W), the channel $\overline B$ has a unique fixed density $\rho_{\mathrm{eff}}$. For every initial density $\rho_0$,

$$
\boxed{\|E_t\|_1=O((t+1)^{-\gamma}).}
\tag{3.1}
$$

For each fixed $\Phi,R,\gamma$, the implied constant may be chosen uniformly over initial densities. The exponent $\gamma$ cannot be increased for this class, even if the two channels do not commute and $\rho_0=\rho_{\mathrm{eff}}$.

No extra hypothesis is imposed beyond the finite-dimensional channel model, the Sibuya clock and the original (W).

### Theorem 3.2 — Full leading term

Let $\Lambda$ be the set of peripheral eigenvalues of $T$, and $Q_\lambda$ their spectral projectors. Peripheral eigenvalues are semisimple, as proved in Section 4. Put

$$
H_*=H(1),\qquad H_\lambda=H(\lambda^{-1}),\qquad
\beta=\min\{2\gamma,1\}.
\tag{3.2}
$$

For $\lambda\in\Lambda\setminus\{1\}$, define

$$
D_\lambda=Q_\lambda\left[
H_\lambda c+(1-\lambda^{-1})^{-\gamma}(H_\lambda-H_*)b
\right].
\tag{3.3}
$$

If $1\in\Lambda$, define

$$
D_1=Q_1H_*c-Q_1H_*AQ_1H_*b.
\tag{3.4}
$$

The $D_1$ term is omitted when $1\notin\Lambda$. Complex powers use the branch reached from the open unit disc. Then

$$
\boxed{E_t=s_t\sum_{\lambda\in\Lambda}\lambda^tD_\lambda
 +O((t+1)^{-\beta})}
\tag{3.5}
$$

in trace norm. Equivalently, for $t\ge1$,

$$
E_t=\frac{t^{-\gamma}}{\Gamma(1-\gamma)}
\sum_{\lambda\in\Lambda}\lambda^tD_\lambda
+O(t^{-\beta}).
\tag{3.6}
$$

Since $\beta>\gamma$, the remainder is smaller than a nonzero leading term. Empty peripheral sums are allowed. Vanishing coefficients are also allowed: the theorem does not assert that every system attains the worst-case exponent. Although affine coordinates use a choice of $\sigma$, the state difference and resulting leading expansion are independent of that choice.

## 4. Ordered renewal representation and analytic structure

### 4.1 Exact generating function for the error

Let $\Omega_n$ be the unnormalised average state immediately after an event at time $n$, with $\Omega_0=\rho_0$. Independence and the occupied-step convention give

$$
\Omega_n=\sum_{\ell=1}^n p_\ell R\Phi^{\ell-1}(\Omega_{n-\ell}),
\qquad \operatorname{tr}\Omega_n=u_n.
\tag{4.1}
$$

Set $v_n=\Omega_n-u_n\sigma$. Since $\Phi(\sigma)=\sigma$,

$$
v_0=x_0,\qquad
v_n=u_nb+\sum_{\ell=1}^n p_\ell AT^{\ell-1}v_{n-\ell}
\quad(n\ge1).
\tag{4.2}
$$

The term $u_nb$ uses the renewal identity (2.5); it would be incorrect to replace it by a constant forcing at each time. Taking generating functions yields

$$
\widehat v(w)=H(w)\bigl[(1-w)^{-\gamma}b+c\bigr].
\tag{4.3}
$$

Let

$$
Z(w)=\sum_{n\ge0}s_nw^nT^n=(I-wT)^{\gamma-1}.
\tag{4.4}
$$

Conditioning on the last event, with the latest operations on the left, gives

$$
\sum_{t\ge0}\left(\rho_t^{\mathrm{par}}-\sigma\right)w^t
=Z(w)H(w)\bigl[(1-w)^{-\gamma}b+c\bigr].
\tag{4.5}
$$

At $w=1$, the restriction of $\overline B$ to $\mathcal V$ is $K(1)$. Two fixed densities differ by an element of $\ker(I-K(1))$, which is zero by (W). A fixed density exists by the compactness argument in Section 2. Its affine coordinate $e=\rho_{\mathrm{eff}}-\sigma$ satisfies $e=b+K(1)e$, hence

$$
\rho_{\mathrm{eff}}=\sigma+H_*b.
\tag{4.6}
$$

Positivity in (4.6) follows from the fixed-density construction; it is not an assertion that $H_*$ is a positive map.

The generating function of $F_t|_{\mathcal V}$ is $Z(w)(1-w)^{-\gamma}$. Subtracting its action on $e=H_*b$ from (4.5) gives the central identity

$$
\boxed{\widehat E(w)
=Z(w)(1-w)^{-\gamma}\bigl[H(w)-H_*\bigr]b
 +Z(w)H(w)c.}
\tag{4.7}
$$

Scalar factors commute with matrices; all other factors in (4.7) retain their written order. No commutation of $R$ and $\Phi$ has entered the argument.

### 4.2 Invertibility inside the disc

For $X\in\mathcal V_{\mathbb C}$, use the norm

$$
\|X\|_\sharp=\sup_{\theta\in\mathbb R}
\|\operatorname{Re}(e^{i\theta}X)\|_1.
\tag{4.8}
$$

It is a norm and equals $\|X\|_1$ for Hermitian $X$. A positive trace-preserving map contracts the trace norm on Hermitian matrices: write $X=X_+-X_-$, use positivity and the triangle inequality, and then use preservation of the traces of $X_\pm$. A Hermiticity-preserving map commutes with the real-part operation in (4.8). Thus $T$ and $A$ are contractions in $\|\cdot\|_\sharp$, and

$$
\|K(w)\|_\sharp\le\sum_{\ell\ge1}p_\ell|w|^\ell<1,
\qquad |w|<1.
\tag{4.9}
$$

Consequently $H$ is analytic inside the unit disc. The series for $M$ converges absolutely on its boundary because $\sum p_\ell=1$ and $\|T^n\|_\sharp\le1$. Condition (W) therefore gives an invertible continuous boundary value of $H$ at every point of the circle.

### 4.3 The finite branch-point structure

Power boundedness of $T$ implies that its spectrum lies in the closed unit disc and that each peripheral Jordan block has size one. Otherwise powers of a peripheral Jordan block would grow polynomially, contradicting $\|T^n\|_\sharp\le1$. Stable Jordan blocks are permitted.

It follows that

$$
Z(w)=\sum_{\lambda\in\Lambda}(1-\lambda w)^{\gamma-1}Q_\lambda
 +Z_{\mathrm{st}}(w),
\tag{4.10}
$$

where the stable part is analytic on a disc of radius greater than one. To describe $M$, the scalar function

$$
m_\gamma(w,z)=
\begin{cases}
\bigl[1-(1-wz)^\gamma\bigr]/z,&z\ne0,\\
\gamma w,&z=0
\end{cases}
\tag{4.11}
$$

has a removable singularity at $z=0$. Applying this analytic function to stable Jordan blocks is therefore legitimate, including nilpotent blocks. On the peripheral subspace,

$$
M(w)=\sum_{\lambda\in\Lambda}
\lambda^{-1}\bigl[1-(1-\lambda w)^\gamma\bigr]Q_\lambda
 +M_{\mathrm{st}}(w),
\tag{4.12}
$$

again with a stable part analytic on a disc of radius greater than one.

For each $\zeta=\lambda^{-1}$, make a radial cut from $\zeta$ outwards. The functions in (4.10) and (4.12) extend analytically past the unit circle away from these cuts. The function $M$ has a finite limit at each cut endpoint because $\gamma>0$. Invertibility of $I-K(\zeta)$ and continuity then give an invertible slit neighbourhood of that endpoint. On the remaining compact arcs, (W) and ordinary analyticity give invertible neighbourhoods. A finite subcover and a smaller common outer radius produce an indented disc in which $H$ is analytic and has no additional poles. The factor $(1-w)^{-\gamma}$ in (4.7) adds a cut at $1$ if it is not already present.

This continuation is the quantitative step unavailable from absolute summability alone. The explicit Sibuya functions, finite spectrum and (W) together justify coefficient extraction with a polynomial bound.

## 5. Proof of the leading expansion

### 5.1 Expansion of the resolvent

Fix $\lambda\in\Lambda$, put $\zeta=\lambda^{-1}$, and set $x=1-\lambda w$. In a fixed sector of its slit neighbourhood, (4.12) gives

$$
M(w)=M(\zeta)-\lambda^{-1}Q_\lambda x^\gamma+O(x).
\tag{5.1}
$$

A local Neumann expansion around the invertible matrix $I-K(\zeta)$ yields

$$
H(w)=H_\lambda
-\lambda^{-1}H_\lambda A Q_\lambda H_\lambda x^\gamma
+O(x^\beta),
\qquad \beta=\min\{2\gamma,1\}.
\tag{5.2}
$$

Indeed, the linear perturbation of $I-K$ is $\lambda^{-1}AQ_\lambda x^\gamma+O(x)$; the quadratic inverse remainder is $O(x^{2\gamma})$. Combining it with the analytic $O(x)$ term gives the stated remainder. This is a local expansion near an invertible endpoint and does not assume that $R$ contracts strictly.

### 5.2 The branch point at $1$

Suppose first that $1\in\Lambda$, and let $x=1-w$. Equations (4.10) and (5.2) read

$$
Z(w)=x^{\gamma-1}Q_1+G_1(w),
\quad
H(w)-H_*=-H_*AQ_1H_*x^\gamma+O(x^\beta),
\tag{5.3}
$$

where $G_1$ is analytic near $1$. In the first term of (4.7), the product of $x^{\gamma-1}$ and $x^{-\gamma}$ is $x^{-1}$. Hence that term is

$$
-x^{\gamma-1}Q_1H_*AQ_1H_*b+O(x^{\beta-1}).
\tag{5.4}
$$

The terms involving $G_1$ are bounded or smaller and are included because $\beta\le1$. The second term of (4.7) is

$$
x^{\gamma-1}Q_1H_*c+O(x^{\beta-1}).
\tag{5.5}
$$

Thus

$$
\widehat E(w)=x^{\gamma-1}D_1+O(x^{\beta-1}),
\tag{5.6}
$$

with $D_1$ as in (3.4). The cancellation $H(w)-H_*$ is essential: without it, the product would retain the stronger $x^{-1}$ singularity.

If $1\notin\Lambda$, then $Z$ and $H$ are analytic near $1$, and $H(w)-H_*=O(1-w)$. The first term of (4.7) is $O((1-w)^{1-\gamma})$ and the second is bounded. These are covered by $O((1-w)^{\beta-1})$, with no leading $D_1$ term.

### 5.3 Other peripheral branch points

For $\lambda\ne1$, the scalar factor $(1-w)^{-\gamma}$ is analytic near $\lambda^{-1}$, with value $(1-\lambda^{-1})^{-\gamma}$. The singular part of $Z$ is $x^{\gamma-1}Q_\lambda$. Substitution of (5.2) into (4.7) therefore gives

$$
\widehat E(w)=x^{\gamma-1}D_\lambda+O(x^{\beta-1}).
\tag{5.7}
$$

The next possible product of fractional powers is $x^{2\gamma-1}$; bounded terms and analytic corrections also fit the displayed remainder. This proves the coefficient formula (3.3), including its operator order.

### 5.4 A coefficient estimate with a self-contained proof

**Lemma 5.1.** Let $G(w)$ be analytic on an indented disc of radius greater than one, with only finitely many cut endpoints $\zeta_j$ on the unit circle. Suppose that in sectors adjoining each endpoint,

$$
\|G(w)\|\le C_j|1-w/\zeta_j|^{\eta-1},
\qquad 0<\eta\le1.
\tag{5.8}
$$

Then $\|[w^t]G(w)\|=O((t+1)^{-\eta})$.

**Proof.** It suffices to work coordinatewise. Deform the Cauchy contour outwards except for a small arc around each endpoint and two rays along either side of its outward cut. Choose fixed ray angles strictly less than $\pi/2$ from the outward radial direction, avoiding the cut. At distance $r$ from the endpoint, $|w|\ge1+ar$ for some $a>0$. The contribution of a ray outside radius $1/t$ is bounded by

$$
C\int_{1/t}^{r_0}e^{-a'tr}r^{\eta-1}\,dr
=O(t^{-\eta}).
\tag{5.9}
$$

The connecting arc at distance $1/t$ has length $O(1/t)$, function size $O(t^{1-\eta})$, and bounded factor $|w|^{-t-1}$. Its contribution is also $O(t^{-\eta})$. The rest of the contour remains at a fixed distance outside the unit circle and contributes exponentially little. Summing the finitely many contributions proves the claim. The finitely many small values of $t$ are absorbed in the constant. $\square$

This is the particular singularity-analysis estimate needed here; general versions are developed in [4]. The proof includes $\eta=1$, where the local remainder is bounded. In particular no logarithmic correction is required at $\gamma=1/2$, and no asymptotic coefficient is assigned to an analytic constant.

### 5.5 Completion of the proofs

Subtract the explicit leading functions:

$$
G(w)=\widehat E(w)
-\sum_{\lambda\in\Lambda}D_\lambda(1-\lambda w)^{\gamma-1}.
\tag{5.10}
$$

At each endpoint its own leading singularity cancels by (5.6) or (5.7). The other subtracted terms are analytic there and bounded; since $\beta\le1$, they are included in the local $O(|1-w/\zeta|^{\beta-1})$ bound. Lemma 5.1 with $\eta=\beta$ gives $O(t^{-\beta})$ for the coefficients of $G$. Finally,

$$
[w^t](1-\lambda w)^{\gamma-1}=\lambda^t s_t.
\tag{5.11}
$$

This proves (3.5). The gamma-function ratio in (2.4) gives

$$
s_t=\frac{t^{-\gamma}}{\Gamma(1-\gamma)}
\bigl(1+O(t^{-1})\bigr),
\tag{5.12}
$$

and $1+\gamma>\beta$, so (3.6) follows. The leading sum is bounded, which proves the rate (3.1). The matrix functions and contour can be fixed independently of $\rho_0$; dependence on $\rho_0$ is linear through $c$, which is bounded on the compact set of density matrices. This proves the stated uniformity over initial states. Optimality is established next. $\square$

## 6. A noncommuting sharp example with matched initial states

Let $X,Y,Z$ denote the Pauli matrices, and take a qubit with

$$
\Phi=\operatorname{Ad}_Z,\qquad
R(\rho)=a\rho+(1-a)|+\rangle\langle+|,
\qquad 0<a<1.
\tag{6.1}
$$

On arbitrary matrices the second summand is $(1-a)\operatorname{tr}(\rho)|+\rangle\langle+|$. We use $a$, rather than $c$, for this scalar parameter to distinguish it from the affine vector $c$ in (2.10).

The channels do not commute: their two compositions send $I/2$ to states with opposite nonzero $x$-Bloch components. On traceless matrices $A=aI$. Consequently $\|K(w)\|_\sharp\le a<1$ on the unit circle, which proves (W).

Choose $\sigma=I/2$. On the $x$-Bloch direction, $T=-1$, $b_x=1-a$, and

$$
M_x(w)=(1+w)^\gamma-1,\qquad
H_x(w)=\frac1{1+a-a(1+w)^\gamma}.
\tag{6.2}
$$

The effective state is

$$
\rho_{\mathrm{eff}}=\frac{I+x_*X}{2},\qquad
x_*=\frac{1-a}{1+a-a2^\gamma}.
\tag{6.3}
$$

Since $2^\gamma<2$, its denominator exceeds $1-a>0$, so $0<x_*<1$. Set $\rho_0=\rho_{\mathrm{eff}}$. Both processes now start in precisely the same state.

The affine forcing satisfies

$$
c_x=x_*-(1-a)=a(2^\gamma-1)x_*.
\tag{6.4}
$$

The only active frequency is $\lambda=-1$. From (3.3), its leading Bloch amplitude is

$$
\ell_-=\frac{a(2^\gamma-2)x_*}{1+a}<0.
\tag{6.5}
$$

Therefore

$$
E_t=s_t(-1)^t\ell_-\frac X2+O(t^{-\beta}),
\tag{6.6}
$$

and, because $\|X/2\|_1=1$,

$$
\lim_{t\to\infty}t^\gamma\|E_t\|_1
=\frac{|\ell_-|}{\Gamma(1-\gamma)}>0.
\tag{6.7}
$$

This proves sharpness for every $0<\gamma<1$, within noncommuting dynamics and without an initial-state mismatch.

For $a=\gamma=1/2$, the values simplify to

$$
\begin{aligned}
x_*&=\frac{3+\sqrt2}{7},\qquad
\ell_-=\frac{\sqrt2-4}{21},\\
\lim_{t\to\infty}\sqrt t\,\|E_t\|_1
&=\frac{4-\sqrt2}{21\sqrt\pi}.
\end{aligned}
\tag{6.8}
$$

An even simpler consistency check is $\Phi=I$ with a complete-reset channel and an unmatched initial state: then $E_t=s_t(\rho_0-\rho_{\mathrm{eff}})$ exactly. The noncommuting example above shows that the sharp exponent is not merely a first-reset transient from different initial states.

## 7. An example with no contracting history

The theorem's hypotheses are weaker than a strict contraction requirement. Consider unitary qubit channels whose Bloch rotations are quarter turns around the $z$ and $x$ axes:

$$
T=\begin{pmatrix}0&-1&0\\1&0&0\\0&0&1\end{pmatrix},
\qquad
A=\begin{pmatrix}1&0&0\\0&0&-1\\0&1&0\end{pmatrix}.
\tag{7.1}
$$

This type of example is already used to distinguish (W) from word contraction in [1]. We include the argument to verify directly that the rate theorem applies without silently strengthening (W).

Every cycle $AT^{\ell-1}$, and every finite product of cycles, is orthogonal on Bloch vectors. For a traceless Hermitian qubit matrix $v\cdot\boldsymbol\sigma/2$, its trace norm is $|v|$. Hence every such product has contraction coefficient one; there is no strictly contracting history.

Nevertheless, suppose (W) fails. There would be a nonzero complex vector $v$ and $|w|=1$ such that

$$
v=\sum_{\ell\ge1}p_\ell w^\ell AT^{\ell-1}v.
\tag{7.2}
$$

Every vector in this average has Euclidean norm $|v|$. Equality in the norm of their convex average implies that all are equal to $v$. One can verify this without an equality-case assumption by expanding the nonnegative weighted sum of their squared distances from the average. Since $p_1,p_2>0$,

$$
Av=w^{-1}v,\qquad ATv=w^{-2}v,
$$

and invertibility of $A$ gives $Tv=w^{-1}v$. Thus $T$ and $A$ would have a common eigenvector with the same eigenvalue.

Their spectra are $\{1,i,-i\}$. For eigenvalue $1$, the fixed axes are respectively the $z$ and $x$ axes, with zero intersection. For either $i$ or $-i$, an eigenvector of $T$ has zero $z$ coordinate and nonzero $x$ coordinate, whereas an eigenvector of $A$ has zero $x$ coordinate. The eigenspaces again have zero intersection. This contradiction proves (W).

Both channels fix $I/2$, so $b=0$ and uniqueness gives $\rho_{\mathrm{eff}}=I/2$. For initial Bloch vector $x_0$, Theorem 3.2 reduces to

$$
\rho_t^{\mathrm{par}}-I/2
=s_t\sum_{\lambda\in\{1,i,-i\}}\lambda^tQ_\lambda H_\lambda x_0
+O(t^{-\beta}),
\tag{7.3}
$$

where Bloch vectors on the right are identified with their traceless matrices. The surviving leading frequencies can be checked directly against the age recursion. Their decay arises from averaging over event histories, even though no individual history contracts.

## 8. Reproducible checks and their scope

The asymptotic theorem is established by Sections 4–6. The accompanying computations check conventions, exact finite identities, the sharp example and numerical agreement with the predicted leading terms. Finite computations do not prove a limit or the validity of (W) for an arbitrary input.

### 8.1 Exact certificate

An exact certificate calculation uses exact pairs of rational numbers representing $\mathbb Q(\sqrt2)$. For the sharp example $a=\gamma=1/2$, it compares the defining age-chain evolution with the renewal representation through $t=48$, verifies the effective state and relevant algebraic identities, and certifies that the leading amplitude is nonzero. The reported result contains **1,377 checks**, records the exact quantities in (6.8), and gives rational enclosures for $\sqrt2$ and the amplitude.

These checks establish the finite identities encoded by the script. The proof that the amplitude governs the infinite-time asymptotic is Theorem 3.2, not the finite certificate.

### 8.2 Numerical comparison

For the sharpness example, a numerical calculation evolves the age distribution and its Bloch moments directly, separately from the generating-function derivation. The reported run uses horizon 4096, $a=1/2$, and three values of $\gamma$. The code denotes this scalar channel parameter by `c`; it is the parameter $a$ of Section 6, not the vector $c$ of (2.10). At the last step, the signed error divided by its predicted leading term is:

| $\gamma$ | Error / predicted leading term at $t=4096$ |
|---:|---:|
| $1/4$ | 0.9379318586 |
| $1/2$ | 0.9998848950 |
| $3/4$ | 0.9590067785 |

These are finite-time diagnostics, not precision guarantees for an asymptotic limit. The different finite-time discrepancies are compatible with the theorem's parameter-dependent remainder.

The unitary quarter-turn example is also run through 4096 steps at $\gamma=1/2$, starting with Bloch vector $(1,0,0)$. A separate direct age-by-age implementation through 64 steps agrees with the renewal computation to a maximum Euclidean gap of $1.56\times10^{-17}$. At step 4096, the trace norm is approximately $8.3321\times10^{-3}$, and the norm of the difference from the predicted leading vector is approximately $6.69\times10^{-7}$. Condition (W) and the absence of contracting words were proved in Section 7; they are not inferred from these floating-point checks.

The finite-time comparisons corroborate the formulas but do not establish the asymptotic theorem.

### 8.3 Reproduction and verification boundaries

The reported exact-arithmetic and floating-point checks serve different purposes. The computational files and execution reports are not included in this edition.

The present theorem has a written mathematical proof. It is not claimed to be end-to-end Lean formalized, and the numerical scripts are not a substitute for such formalization. The manuscript has not undergone external peer review.

## 9. Interpretation and limitations

The comparison in (3.1) is between two time-dependent processes under the same heavy-tailed clock. It does not assert that the full state reaches its stationary limit with exponent $\gamma$. In particular, the complete-reset Sibuya family can contain a $t^{\gamma-1}$ contribution in addition to an oscillatory $t^{-\gamma}$ contribution [1]. When $\gamma>1/2$, the effective-reset description can therefore become accurate faster than the state equilibrates.

The proof and constants are finite-dimensional. Infinite-dimensional spectra can have accumulation and continuous components, so the finite branch-point contour argument does not transfer without additional work. Waiting times remain independent of the state and of one another; measurement-triggered or correlated clocks are not covered. The channels are fixed and time homogeneous. The theorem concerns the averaged density matrix, not entanglement or other nonlinear statistics of individual trajectories.

Condition (W) remains a sufficient condition. This work does not classify the processes that converge when it fails. Nor does it give a universal finite-time constant for all channel pairs satisfying (W). Close to a unit-circle singularity of $I-K(w)$, resolvent bounds can grow, and near-colliding spectral phases shrink the common contour neighbourhood. The endpoints $\gamma=0,1$ lie outside the theorem and require their own elementary analysis. The leading coefficients can vanish in special systems, permitting faster decay; the remainder in (3.5) is not asserted to be optimal in every such subclass.

A useful next quantitative step is to bound the contour constants in terms of a computable nonresonance margin and spectral separation. That would turn the fixed-system asymptotic estimate into an explicit stopping-time certificate. The present result establishes the optimal exponent and all leading coefficients under the original qualitative hypothesis.

## References

1. **Anonymous.** *Renewal resetting of quantum dynamics: a classification for complete resets, a reduction for jump channels, and critical time scales*. Version 1.0.0-candidate, 23 October 2026. Unrefereed research manuscript. [DOI: 10.5281/zenodo.23580221](https://doi.org/10.5281/zenodo.23580221). [Original manuscript source](https://github.com/ipitchford/renewal-quantum-resetting-equilibration/blob/e3c77d3055f7b80b4962ccf3024446b3e15993f4/paper/paper.tex). [Release and open-problem account](https://www.evidencepress.org/releases/renewal-quantum-resetting-equilibration/).

2. **S. Wald, L. H. Yao, T. Platini, C. Hooley and F. Carollo.** *Stochastic resetting in discrete-time quantum dynamics: steady states and correlations in few-qubit systems*. Quantum **9**, 1742 (2025). [DOI: 10.22331/q-2025-05-13-1742](https://doi.org/10.22331/q-2025-05-13-1742). [arXiv:2410.11497v3](https://arxiv.org/html/2410.11497v3).

3. **B. Vacchini.** *Quantum renewal processes*. Scientific Reports **10**, 5592 (2020). [DOI: 10.1038/s41598-020-62260-z](https://doi.org/10.1038/s41598-020-62260-z).

4. **P. Flajolet and A. Odlyzko.** *Singularity analysis of generating functions*. SIAM Journal on Discrete Mathematics **3**, 216–240 (1990). [DOI: 10.1137/0403019](https://doi.org/10.1137/0403019).

5. **R. U. Erdoğan and F. A. Savacı.** *Directional transfer from coherence to longitudinal polarization and algebraic storage in a transmon with Markovian dephasing and a glassy environment: A non-Markovian fractional renewal model*. arXiv:2609.37270v1, 29 September 2026. [arXiv record](https://arxiv.org/abs/2609.37270). [Original author-manuscript PDF](https://arxiv.org/pdf/2609.37270v1). The author manuscript was obtained from an explicitly linked PDF mirror and then independently downloaded from arXiv; the comparison uses the original model and formulas.

