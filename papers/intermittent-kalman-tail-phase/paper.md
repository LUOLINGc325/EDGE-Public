---
title: "Exact tail phases of intermittent Kalman filtering"
subtitle: "Jordan geometry and hidden angular laws under partial observation"
date: "26 November 2026"
lang: en
---

## Abstract

We determine the leading tail shape of the optimal, time-varying Kalman error in two complementary intermittent-observation models. First, for an arbitrary real state matrix of spectral radius $\rho>1$ and full column rank observation, we obtain a convergent matrix phase family which retains every peripheral Jordan block and all reachable eigenvalue phases. With largest peripheral Jordan size $r$, $m=r-1$, and loss probability $q$, the tail is of order $x^{-\alpha}(\log x)^{\alpha m}$, $\alpha=-\log q/\log\rho$, with an explicit all-threshold coefficient and phase-dependent quantile asymptotics. In the scalar case, a Fourier–Mellin criterion characterizes constant coefficients; all positive noise variances give nonconstant modulation when the absolute multiplier is at least $\sqrt2$. Second, for scalar-expansion dynamics $A=aI$ and randomly selected, nonorthogonal sensors of rank $d-1$ with distinct null lines, no individual observation is full rank. A switching-run decomposition produces exact line-supported angular measures whose amplitudes retain the unbounded Palm covariance and a future-dependent Gaussian smoothing correction. Successively removing dominant null directions exposes further phase measures, followed by a positive full-dimensional hidden measure at the erasure-only exponent. The proofs control unbounded reception laws using an extra-moment gap or measured-subspace bounds, rather than a fictitious deterministic reset. We give explicit coefficient formulas, directional classification, moment boundaries, and a sharp consequence for iid sensor routing. The two models have separate hypotheses; arbitrary state dynamics with general partial observation is not claimed.

## 1. Introduction and relation to earlier work

Packet losses can turn a Gaussian filtering problem into a stationary mixture with heavy tails. A moment threshold or a logarithmic tail exponent identifies one aspect of this phenomenon. It does not determine the error probability at a specified large threshold. A periodic coefficient can remain visible at arbitrarily large thresholds, and a nontrivial Jordan block can multiply the power law by a growing power of the logarithm. These effects matter when translating a stationary error law into a high-confidence error threshold.

This paper determines that leading shape in two complementary regimes. Sections 2–8 treat the genuinely time-varying optimal Kalman filter under independent Bernoulli losses and full column rank observation. The state matrix may be singular, nonnormal, or have several dominant eigenvalues and Jordan blocks. Sections 9–16 treat scalar-expansion dynamics with truly partial, nonorthogonal randomly selected sensors. Neither regime requires a non-overlap condition on its Riccati maps.

The proof first keeps the covariance at the last reception as a random variable. Uniform contraction at reception times constructs its invariant Palm law. At an ordinary time, that covariance is independent of a geometric age. A Jordan expansion of propagation over this age produces a matrix-valued spectral phase. Summing the conditional Gaussian tails over all ages yields a bilateral series which retains both the geometric clock and the peripheral spectral phases.

### 1.1. What is inherited and what is proved here

Mo and Sinopoli [1] analyze covariance-tail logarithmic exponents and moment thresholds for nondegenerate, diagonalizable systems under Gilbert–Elliott losses. Their observation assumptions can be weaker than ours. We do not claim a broader general intermittently observable class or a new critical-probability formula. Our result concerns the leading error-tail shape, its Jordan correction, and its spectral-phase dependence under the stated full-rank observation assumption.

Pezzutto, Schenato, and Dey [2] study the actual estimation-error distribution and establish heavy-tail conclusions. In their exact power-law analysis they adopt a constant-gain recursion and apply renewal theory; the arithmetic case is explicitly distinguished. Our scalar result is not a claim that arithmetic tails were previously overlooked. It gives an explicit coefficient and a sharp constancy criterion for the true time-varying Riccati filter.

Kar, Sinopoli, and Moura [3] establish invariant covariance distributions and weak convergence in a substantially more general filtering setting. Censi [4] describes invariant covariance distributions geometrically and gives distribution formulas under a non-overlap condition. Stationarity, Gaussian mixing, and fractal Riccati supports are therefore background. Section 3 supplies a restricted self-contained contraction argument because its uniformity is also useful for computing the tail coefficient.

Arithmetic renewal theory already contains log-periodic asymptotics; see Kevei [5]. Classical Jordan expansion and Fourier uniqueness are also standard tools. The contribution here is their precise combination with the optimal Riccati Palm law to obtain a complete matrix phase family, an all-threshold formula and its inversion, and the scalar classification with a verifiable nonconstant parameter range. Eigenvalue cycles in intermittently observed systems have a different but related role in the critical-probability analysis of Park and Sahai [6]; we do not claim the spectral-phase mechanism itself as a new discovery.

Later stability analyses already allow non-diagonalizable state matrices, including Marelli, Sui, Rohr, and Fu [7]. Our Jordan result concerns the explicit logarithmic tail correction and its joint phase law, rather than a first treatment of non-diagonalizable filtering. Rohr, Marelli, and Fu [8] also give arbitrarily tight computable bounds on covariance distributions for general systems. Accordingly, neither numerical computability of a Riccati distribution nor the use of finite reception histories is claimed as new. Section 8 explains how to evaluate the particular asymptotic phase family proved here.

### 1.2. Coupled partial observations and hidden angular layers

The full-rank argument cannot simply be reused when every sensor misses a direction: reception covariances need not be bounded. For $A=aI$, we analyze a finite family of rank-$d-1$ sensors with distinct null lines and arbitrary positive noise covariances. The true Riccati updates generally remain coupled. A run of repeated use of one sensor type retains a hidden direction, and its exact asymptotic amplitude depends on both the switch Palm covariance and all observations later in the run. A Gaussian Schur-complement formula identifies that amplitude.

The resulting tail law is stratified. Its leading angular measure lies on the null lines with the slowest run decay. On cones excluding those lines, smaller routing probabilities expose their own exact geometric-phase measures. Away from every sensor null line, an unbounded ordinary reception Palm law nevertheless gives a positive full-dimensional measure at the erasure-only exponent: the relevant measured-subspace covariance is uniformly bounded. This last argument does not estimate a remainder of the dominant line law; it directly establishes the stronger normalization on its own restricted space.

Cai and Lau [9] study MSE tails for remote estimation over multiantenna random-access channels, including full-rank and rank-deficient observation cases according to the official indexed description. The full text of that paper was not available in the present comparison, so we do not assert a theorem-by-theorem exclusion of its results. Damek and Mentemeier [10] give hidden regular variation for stochastic recursions with diagonal matrices under their stated nonarithmetic assumptions. The limits here are explicit tail measures under geometric scaling for nonlinear, generally noncommuting Riccati updates. They are described as an arithmetic hidden-tail hierarchy, without asserting ordinary regular variation at every real scale. The exponent of an unobservable pattern and the idea of hidden tail strata are not claimed as new by themselves.

The paper is a research manuscript supported by written proofs. Formal verification is not claimed.

## 2. Model I: general dynamics and full-rank observations

Consider the real linear Gaussian system

$$
x_{t+1}=Ax_t+w_t,\qquad y_t=Cx_t+v_t. \tag{2.1}
$$

Here $A\in\mathbb R^{d\times d}$, $C\in\mathbb R^{h\times d}$, all noise vectors $(w_t)$ and $(v_t)$ are mutually independent across all times, with $w_t\sim N(0,Q)$ and $v_t\sim N(0,R)$, and the initial state is Gaussian and independent of the noises. Assume

$$
\rho=\rho(A)>1,\qquad Q\succ0,\qquad R\succ0,\qquad
\operatorname{rank}C=d. \tag{2.2}
$$

The receipt indicators $\gamma_t$ are iid, independent of the state and noises, with

$$
\mathbb P(\gamma_t=1)=p\in(0,1),\qquad q=1-p. \tag{2.3}
$$

The estimate is the conditional mean given received measurements and receipt indicators. The **posterior** covariance, after processing the observation at the current time, obeys

$$
P_t=
\begin{cases}
D(P_{t-1}),&\gamma_t=0,\\
O(D(P_{t-1})),&\gamma_t=1,
\end{cases} \tag{2.4}
$$

where

$$
H=C^\mathsf TR^{-1}C,\qquad
D(X)=AXA^\mathsf T+Q,\qquad
O(X)=(X^{-1}+H)^{-1}. \tag{2.5}
$$

All matrix inequalities are in Loewner order. We use the Euclidean norm for the error and the corresponding operator norm for matrices. A prime or ${}^\mathsf T$ denotes transpose; complex spectral projectors are used only as intermediate notation, and every final covariance is real.

Let $r$ be the largest Jordan block size among the eigenvalues of modulus $\rho$, and set

$$
m=r-1,\qquad
b_n=\rho^n n^m\quad(n\ge1),\qquad
\alpha=-\frac{\log q}{\log\rho}>0. \tag{2.6}
$$

The variable $E$ will denote the limiting posterior-error marginal. It is a centered Gaussian covariance mixture. Its existence does not assert existence of a stationary state $x_t$, which generally fails for the unstable system.

Full column rank of $C$, positivity of $Q$, and independence of losses are substantive restrictions. Stable and singular subdominant modes of $A$ are allowed. General partial observation is outside Sections 2–8; the separately specified Model II in Section 9 assumes scalar-expansion dynamics. Markov losses, state-dependent transmission, non-Gaussian noise, and stationary controlled-state laws remain outside both models.

## 3. A bounded reception law and an exact age decomposition

Put

$$
L=(Q^{-1}+H)^{-1},\qquad M=H^{-1},\qquad
\mathcal K=\{B:L\preceq B\preceq M\}. \tag{3.1}
$$

Every covariance immediately after a reception belongs to $\mathcal K$. This compact interval will carry the Palm law, namely the covariance law at a reception.

### Lemma 3.1. Uniform contraction at receptions

For positive definite matrices define the Thompson metric

$$
d_T(X,Y)=\inf\{\log a:a\ge1,\ X\preceq aY,\ Y\preceq aX\}. \tag{3.2}
$$

Let

$$
\delta=\lambda_{\min}(H^{1/2}QH^{1/2}),\qquad
\kappa=(1+\delta)^{-1}\lt 1. \tag{3.3}
$$

The map $D$ is nonexpansive in $d_T$, and $O$ is $\kappa$-contractive on the region $X\succeq Q$. Consequently every reception-to-reception map

$$
G_k=O\circ D^{k+1},\qquad k\ge0, \tag{3.4}
$$

maps $\mathcal K$ into itself and is $\kappa$-contractive there.

**Proof.** The map $D$ preserves order and satisfies $D(aX)\preceq aD(X)$ for $a\ge1$. Applying this in both order comparisons in (3.2) proves nonexpansiveness.

Whiten a matrix $Y\succeq Q$ by $H$, writing $U=H^{1/2}YH^{1/2}$. Then

$$
O(Y)=H^{-1/2}f(U)H^{-1/2},\qquad f(u)=\frac{u}{1+u}. \tag{3.5}
$$

The eigenvalues of $U$ are at least $\delta$. For $a\ge1$ and $u\ge\delta$,

$$
\log\frac{f(au)}{f(u)}
=\int_0^{\log a}\frac{1}{1+e^s u}\,ds
\le\frac{\log a}{1+\delta}.
$$

Functional calculus therefore gives $O(aY)\preceq a^\kappa O(Y)$. The map $O$ is order preserving, as follows by taking two order-reversing inverses in its definition. If $X,Y\succeq Q$ and $d_T(X,Y)\le\log a$, the two order comparisons yield

$$
d_T(O(X),O(Y))\le\kappa d_T(X,Y).
$$

Since $D^{k+1}(B)\succeq Q$, this proves contraction for $G_k$. Finally, $O(Q)\preceq O(D^{k+1}(B))\preceq H^{-1}$, proving invariance of $\mathcal K$. $\square$

### Proposition 3.2. Stationarity, attraction, and geometric age

There is a unique invariant law $\nu$ for the covariance sampled immediately after receptions. The covariance chain at ordinary times has a unique invariant law, and it is the law of

$$
P=D^J(B)
=A^JB(A^\mathsf T)^J+
\sum_{j=0}^{J-1}A^jQ(A^\mathsf T)^j, \tag{3.6}
$$

where

$$
B\sim\nu,\qquad
\mathbb P(J=j)=pq^j,\quad j\ge0,\qquad B\ \text{and}\ J\ \text{are independent}. \tag{3.7}
$$

Starting from any finite positive semidefinite initial covariance, $P_t$ converges weakly to this law. The actual posterior-error marginal converges weakly to

$$
E\mid P\sim N(0,P). \tag{3.8}
$$

**Proof.** The numbers of losses between successive receptions are independent and have law $pq^k$. The maps $G_k$ act on the complete, finite-diameter metric space $(\mathcal K,d_T)$. Backward compositions from any fixed point of $\mathcal K$ are Cauchy: after $N$ common maps, two possible remote starting values differ by at most

$$
\kappa^N\operatorname{diam}_T(\mathcal K).
$$

This constructs a measurable reception covariance from the past gaps. Shift invariance gives an invariant law $\nu$. The same estimate proves uniqueness and attraction for the embedded chain.

Now use a two-sided iid sequence of indicators. Conditional on the last reception before or at time zero being at time $-j$, the covariance at that reception has law $\nu$. It depends only on indicators through $-j$, while the later losses are independent. The probability of this event is $pq^j$. Propagation over the following $j$ losses gives (3.6) and the independence in (3.7). The construction is stationary in ordinary time. Any other stationary covariance process has the same unique reception Palm law and the same last-reception decomposition, so its ordinary-time law agrees.

For weak attraction, couple an arbitrary covariance chain and the stationary one using the same future indicators. A finite positive semidefinite starting matrix becomes positive after one application of $D$. Following the first reception, both chains are in $\mathcal K$. At each subsequent loss their Thompson distance does not increase; at each subsequent reception it is multiplied by at most $\kappa$. Since there are infinitely many receptions almost surely, their Thompson distance tends to zero almost surely.

To turn this metric convergence into weak convergence on the unbounded covariance cone, use tightness of the stationary law. If $d_T(X,Y)\le\varepsilon$, then

$$
e^{-\varepsilon}Y\preceq X\preceq e^\varepsilon Y,
\qquad
\|X-Y\|\le(e^\varepsilon-1)\|Y\|.
$$

The stationary comparison covariance has the same probability law at every time, and is therefore tight. The product on the right converges to zero in probability. Thus the coupled matrices differ by a quantity tending to zero in probability, proving weak convergence.

For each finite Gaussian filtering history, conditional on the receipt indicators the actual posterior error is centered Gaussian with covariance $P_t$. This follows from Gaussian conditioning; the conditional error covariance does not depend on the observed measurement values. Its unconditional characteristic function is

$$
\mathbb E\exp\!\left(-\tfrac12 u^\mathsf TP_tu\right).
$$

Weak convergence of $P_t$ gives convergence of this expression to the characteristic function obtained from (3.8). The latter is continuous at the origin by dominated convergence. The continuity theorem for characteristic functions proves weak convergence of the error marginal. This argument does not require a stationary law for $x_t$. $\square$

## 4. The peripheral spectral phase

For each complex eigenvalue $\lambda$, let $\Pi_\lambda$ be its spectral projector, and let $N_\lambda=(A-\lambda I)\Pi_\lambda$, restricted to its generalized eigenspace. For $|\lambda|=\rho$, define

$$
T_\lambda=
\frac{\lambda^{-m}}{m!}N_\lambda^m\Pi_\lambda. \tag{4.1}
$$

When $m=0$, $N_\lambda^0\Pi_\lambda=\Pi_\lambda$. Blocks smaller than $m+1$ contribute zero to (4.1). Write $\lambda=\rho e^{i\theta_\lambda}$, and set

$$
z_n=(e^{in\theta_\lambda})_{|\lambda|=\rho},\qquad
\mathcal G=\overline{\{z_n:n\in\mathbb Z\}}. \tag{4.2}
$$

The set $\mathcal G$ is a compact subgroup of a finite-dimensional torus. All phase arguments below belong to this **reachable orbit closure**, not to an unconstrained torus. Define

$$
T(z)=\sum_{|\lambda|=\rho}z_\lambda T_\lambda,
\qquad z\in\mathcal G. \tag{4.3}
$$

Conjugate eigenvalues and coordinates are paired on $\mathcal G$, making $T(z)$ real.

### Lemma 4.1. Uniform peripheral geometry

For $n\ge1$,

$$
\frac{A^n}{b_n}=T(z_n)+O(n^{-1}),\qquad
\|A^n\|\le K\rho^n(1+n)^m. \tag{4.4}
$$

The matrices $T(z)$ have a fixed positive rank, a common kernel and a common image $U$. Their nonzero singular values are bounded above and bounded away from zero uniformly on $\mathcal G$.

**Proof.** On a generalized eigenspace,

$$
A^n\Pi_\lambda=
\sum_{j\ge0}\binom nj\lambda^{n-j}N_\lambda^j\Pi_\lambda,
$$

where the sum ends at the nilpotency index. On the spectral circle, the terms with $j=m$ give (4.3), because $\binom nm/n^m\to1/m!$ with an $O(n^{-1})$ remainder. The remaining peripheral terms are of lower polynomial order. All subdominant terms are exponentially smaller after multiplication by a fixed polynomial, even if their Jordan blocks are larger. These observations prove both bounds in (4.4), after enlarging $K$ to cover finitely many initial $n$.

Distinct generalized eigenspaces form a direct sum. Hence $T(z)x=0$ exactly when $T_\lambda\Pi_\lambda x=0$ for every dominant $\lambda$, independently of the nonzero phases. Likewise its image is the direct sum of the fixed images of $T_\lambda$. At least one $T_\lambda$ is nonzero because $r$ is attained. Thus the rank is a fixed positive integer. Continuity on compact $\mathcal G$, with no rank change, gives the uniform singular-value bounds. Conjugate pairing transfers these statements to the common real image $U$. $\square$

For $z\in\mathcal G$ and $B\in\mathcal K$, define

$$
V(z,B)=T(z)BT(z)^\mathsf T+
\sum_{j=1}^\infty \rho^{-2j}
T(zz_{-j})QT(zz_{-j})^\mathsf T. \tag{4.5}
$$

The series converges uniformly. The matrix $V(z,B)$ is supported on $U$ and positive definite there. Its nonzero eigenvalues range in one fixed compact subinterval of $(0,\infty)$: the lower bound follows already from $B\succeq L$ and Lemma 4.1.

Let

$$
S_z(y)=\mathbb E_{B\sim\nu}
\mathbb P\{\|N(0,V(z,B))\|>y\},\qquad y>0. \tag{4.6}
$$

The family $S_z(y)$ is jointly continuous, strictly decreasing in $y$, and tends uniformly to one and zero as $y$ tends to zero and infinity respectively. Moreover, for constants $K,c>0$,

$$
S_z(y)\le K e^{-cy^2}\quad(y\ge1), \tag{4.7}
$$

uniformly in $z$. To justify these properties, express the Gaussian on the fixed subspace $U$. Its covariance eigenvalues have uniform positive lower and finite upper bounds, so its norm has a continuous positive density on every positive radius, uniformly controlled on compact intervals. Gaussian tail and small-ball bounds supply the endpoints. Mixing over $B$ preserves continuity and strict decrease.

### Lemma 4.2. Aged covariance limit

Uniformly for $B\in\mathcal K$,

$$
b_n^{-2}D^n(B)-V(z_n,B)\longrightarrow0. \tag{4.8}
$$

For every fixed integer $k$, also

$$
b_n^{-2}D^{n+k}(B)-\rho^{2k}V(z_{n+k},B)\longrightarrow0. \tag{4.9}
$$

**Proof.** The propagated-$B$ term follows from (4.4). In the noise sum in (3.6), put $j=n-\ell$. For every fixed $j\ge1$,

$$
\frac{A^{n-j}}{b_n}
=\rho^{-j}\left(\frac{n-j}{n}\right)^m
\left(T(z_nz_{-j})+o(1)\right).
$$

The growth bound (4.4) gives a summable constant multiple of $\rho^{-2j}$ for the corresponding covariance term whenever $j\lt n$. The endpoint $\ell=0$ tends to zero after division by $b_n^2$. Splitting at a fixed $j$-cutoff and then letting it increase proves convergence to the series in (4.5), uniformly in $B$. This establishes (4.8). Applying it at $n+k$, and using $b_{n+k}/b_n\to\rho^k$, gives (4.9). $\square$

## 5. The complete tail phase and its inversion

Define the phase family

$$
\Phi(z,y)=p\sum_{k\in\mathbb Z}q^k S_{zz_k}(y\rho^{-k}),
\qquad z\in\mathcal G,\quad y>0. \tag{5.1}
$$

The series converges uniformly for $z\in\mathcal G$ and $y$ in any compact positive interval. The positive indices are dominated by $q^k$; the negative indices are dominated by a constant multiple of

$$
q^k\exp(-c y^2\rho^{-2k}).
$$

Consequently $\Phi$ is continuous and strictly decreasing in $y$. Reindexing gives the phase-shift identity

$$
\Phi(z,\rho y)=q\Phi(zz_1,y). \tag{5.2}
$$

It decreases from infinity to zero. For the first endpoint, retain arbitrarily many negative terms and then let $y\downarrow0$. For the second, apply (5.2) repeatedly and use boundedness on the compact set $\mathcal G\times[1,\rho]$. In particular, $\Phi$ is positive and has uniform positive lower and finite upper bounds on every compact positive $y$-interval.

### Theorem 5.1. Matrix tail phases

For every compact interval $I\subset(0,\infty)$,

$$
\sup_{y\in I}
\left|q^{-n}\mathbb P\{\|E\|>b_ny\}
-\Phi(z_n,y)\right|\longrightarrow0. \tag{5.3}
$$

This holds without convergence of $z_n$.

**Proof.** From (3.6)–(3.8), with age $j=n+k$,

$$
q^{-n}\mathbb P\{\|E\|>b_ny\}
=p\sum_{k\ge-n}q^k
\mathbb E_B\mathbb P\{
\|N(0,b_n^{-2}D^{n+k}(B))\|>y\}. \tag{5.4}
$$

For each fixed $k$, Lemma 4.2 gives convergence to the corresponding term of (5.1), uniformly in $B$ and in $y\in I$. One way to see uniformity of Gaussian norm probabilities is to couple via positive semidefinite square roots, which are continuous on bounded matrix sets. Every limiting covariance belongs to a compact family of fixed positive rank with nonzero eigenvalues bounded away from zero. Its Gaussian norm assigns zero mass to every positive sphere, uniformly over compact intervals of radii. Thus small covariance perturbations change the tail probabilities uniformly.

For $k\ge0$, the summand after omitting the factor $p$ is bounded by $q^k$. For $-n\le k\le0$, write $j=n+k$. Formula (3.6) and (4.4) give

$$
\frac{\|D^j(B)\|}{b_n^2}
\le K\rho^{2k}\left(\frac{1+j}{n}\right)^{2m}
\le K'\rho^{2k}.
$$

A union bound over Gaussian coordinates, using the positive lower endpoint of $I$, therefore bounds this summand by

$$
K''q^k\exp(-c'\rho^{-2k}).
$$

This is summable over all negative integers, and also controls the omitted tail $k\lt -n$ of the limiting series. Dominated convergence of the bilateral series proves (5.3). $\square$

### Theorem 5.2. An all-threshold formula

For sufficiently large $x$, let $u=u(x)>0$ solve

$$
x=\rho^u u^m. \tag{5.5}
$$

Write $n=\lfloor u\rfloor$ and $s=u-n$. Define

$$
\mathcal H(z,s)=q^{-s}\Phi(z,\rho^s),
\qquad z\in\mathcal G,\quad0\le s\le1. \tag{5.6}
$$

Then

$$
\mathcal H(z,1)=\mathcal H(zz_1,0), \tag{5.7}
$$

and

$$
\frac{\mathbb P\{\|E\|>x\}}
{x^{-\alpha}u(x)^{\alpha m}}
-\mathcal H(z_n,s)\longrightarrow0. \tag{5.8}
$$

The coefficient in (5.8) is uniformly positive and finite. Also,

$$
u(x)=\log_\rho x-m\log_\rho(\log_\rho x)+o(1). \tag{5.9}
$$

**Proof.** The function $u\mapsto\rho^u u^m$ is strictly increasing on $u>0$, so (5.5) defines $u$ uniquely for all sufficiently large $x$. We have

$$
\frac{x}{b_n}=\rho^s\left(\frac{u}{n}\right)^m
=\rho^s+o(1),
\qquad
q^n=x^{-\alpha}u^{\alpha m}q^{-s},
$$

uniformly in $s\in[0,1)$. Apply Theorem 5.1 and uniform continuity of $\Phi$ on a compact interval containing these radii. Equation (5.7) follows from (5.2), so the coefficient is consistent when the integer phase changes. Compactness proves the two uniform coefficient bounds.

Finally, setting $t=\log_\rho x$ in (5.5) gives $u=t-m\log_\rho u$. First $u/t\to1$, and substitution then yields (5.9). $\square$

The logarithmic correction and the drift in (5.9) are both necessary parts of the same formula. A nontrivial Jordan block affects the scale and the position within the geometric clock.

### Corollary 5.3. Sharp tail order and the full moment boundary

As $x\to\infty$,

$$
\mathbb P\{\|E\|>x\}
=\Theta\!\left(x^{-\alpha}(\log x)^{\alpha m}\right). \tag{5.10}
$$

For every $t>0$,

$$
\mathbb E\|E\|^t\lt \infty
\quad\Longleftrightarrow\quad t\lt \alpha. \tag{5.11}
$$

In particular the critical moment $t=\alpha$ diverges.

**Proof.** Equation (5.10) follows from (5.8), the coefficient bounds, and $u(x)\sim\log_\rho x$. For (5.11), a direct check at the endpoint is useful. By Lemma 4.2 and the uniform covariance geometry, for fixed $t>0$ and all sufficiently large $j$,

$$
c_t\rho^{tj}j^{tm}
\le
\mathbb E_B\mathbb E\|N(0,D^j(B))\|^t
\le
C_t\rho^{tj}j^{tm}.
$$

The geometric-age mixture converges exactly when $q\rho^t\lt 1$. At equality its terms are comparable to $j^{tm}$, whose sum diverges, including when $m=0$. This proves (5.11). $\square$

### Corollary 5.4. Phase-dependent quantiles

Let $Q_\varepsilon$ be the unique positive upper-tail quantile defined by
$\mathbb P\{\|E\|>Q_\varepsilon\}=\varepsilon$, $0\lt \varepsilon\lt 1$.
Then

$$
Q_\varepsilon
=\Theta\!\left(
\varepsilon^{-1/\alpha}
(\log(1/\varepsilon))^m
\right). \tag{5.12}
$$

More precisely, for every compact interval $I\subset(0,\infty)$,

$$
\sup_{v\in I}
\left|
\frac{Q_{vq^n}}{b_n}
-\Phi(z_n,\cdot)^{-1}(v)
\right|\longrightarrow0. \tag{5.13}
$$

The quantile in (5.13) is defined for all sufficiently large $n$.

**Proof.** The stationary covariance is positive definite, so its Gaussian-mixture norm tail is continuous and strictly decreasing from one to zero. This proves existence and uniqueness of $Q_\varepsilon$. Monotone inversion of (5.10) gives (5.12).

For (5.13), $\Phi(z,\cdot)$ is continuous, strictly decreasing, and onto $(0,\infty)$. Uniform endpoint behavior gives a compact positive interval containing all inverse values for $z\in\mathcal G$ and $v\in I$. On that interval, continuity and strict decrease, followed by compactness, imply a uniform positive separation of function values at arguments separated by any fixed positive distance. The uniform approximation (5.3) can therefore be inverted uniformly, proving (5.13). $\square$

## 6. Scalar tails: a smooth periodic coefficient and a sharp classification

Suppose $d=1$. Let $a=|A|>1$, let $Q_0>0$ be the process variance, and let $R_0=H^{-1}>0$ be the effective observation variance. Write

$$
c=\frac{Q_0}{a^2-1},\qquad
\alpha=-\frac{\log q}{\log a}. \tag{6.1}
$$

The positive all-reception Riccati fixed point is

$$
v_*=
\frac{-[Q_0+R_0(1-a^2)]
+\sqrt{[Q_0+R_0(1-a^2)]^2+4a^2R_0Q_0}}
{2a^2}. \tag{6.2}
$$

The reception Palm covariance satisfies $v_*\le B\le R_0$ almost surely. Indeed, the all-reception iteration from zero increases to $v_*$. Replacing any reception by a loss can only increase covariance, by monotonicity and $O(X)\le X$. The stationary law thus has the same lower bound.

Put $V=B+c$. The age representation becomes the exact identity in distribution

$$
P=a^{2J}V-c,\qquad
v_*+c\le V\le R_0+c, \tag{6.3}
$$

with $V$ independent of $J$. Let $Z\sim N(0,1)$, independent of $V$, and $h(y)=\mathbb P(|Z|>y)$.

### Theorem 6.1. Exact scalar periodic tail

There is a positive smooth one-periodic function $F$ such that

$$
\mathbb P(|E|>x)
=x^{-\alpha}F(\log_a x)+O(x^{-\alpha-2}). \tag{6.4}
$$

It is given by

$$
F(t)=p\,a^{\alpha t}
\sum_{k\in\mathbb Z}q^k
\mathbb E\!\left[
h\!\left(\frac{a^{t-k}}{\sqrt V}\right)
\right]. \tag{6.5}
$$

The series and each of its fixed finite-order derivatives converge uniformly on compact intervals of $t$.

**Proof.** From (6.3),

$$
\mathbb P(|E|>x)
=p\sum_{j\ge0}q^j
\mathbb E h\!\left(
\frac{x}{a^j\sqrt{V-ca^{-2j}}}
\right). \tag{6.6}
$$

Since $V-ca^{-2j}\ge v_*>0$, differentiation with respect to the variance parameter and the mean-value theorem give constants $K,c_1>0$, independent of $j$, $V$, and large $x$, such that

$$
\left|
h\!\left(\frac{x}{a^j\sqrt{V-ca^{-2j}}}\right)
-h\!\left(\frac{x}{a^j\sqrt V}\right)
\right|
\le Kx a^{-3j}\exp(-c_1x^2a^{-2j}). \tag{6.7}
$$

Multiplying by $pq^j$ and summing yields $O(x^{-\alpha-2})$. Explicitly, write $x=a^{n+t}$, $t\in[0,1)$, and $j=n+k$. After extracting $x^{-\alpha-2}$, the remaining terms are bounded by a bilateral series with geometric decay at positive $k$ and Gaussian double-exponential decay at negative $k$, uniformly in $t$.

The approximating sum with denominator $a^j\sqrt V$ can be extended from $j\ge0$ to all integers at an $O(e^{-c_2x^2})$ cost. Its artificial negative-index terms have double-exponential Gaussian decay which dominates $q^j$. Integer reindexing then identifies the extended sum as $x^{-\alpha}F(\log_a x)$. The same Gaussian estimates bound all fixed-order derivatives of (6.5). Replacing $k$ by $k-1$, and using $q a^\alpha=1$, proves $F(t+1)=F(t)$. Positivity is immediate. $\square$

### Theorem 6.2. Fourier–Mellin criterion and an explicit nonconstant range

For $j\in\mathbb Z$, put $\omega_j=2\pi j/\log a$. With
$\widehat F(j)=\int_0^1F(t)e^{-2\pi ijt}\,dt$,

$$
\widehat F(j)=
\frac{p}{\log a}\,
\frac{
\mathbb E V^{(\alpha-i\omega_j)/2}
\ \mathbb E|Z|^{\alpha-i\omega_j}
}{\alpha-i\omega_j}. \tag{6.8}
$$

Consequently, $F$ is constant if and only if the finite positive measure on the circle defined by

$$
\mu(A)=
\mathbb E\!\left[
V^{\alpha/2}
\mathbf1\{(\log_a\sqrt V)\bmod1\in A\}
\right] \tag{6.9}
$$

equals $\mathbb E V^{\alpha/2}$ times uniform probability measure.

The coefficient is nonconstant whenever

$$
\frac{R_0+c}{v_*+c}\lt a^2. \tag{6.10}
$$

Equivalently, this sufficient range is

$$
Q_0>R_0(1-a^2/2). \tag{6.11}
$$

In particular, $F$ is nonconstant for every $q\in(0,1)$, $Q_0>0$, and $R_0>0$ whenever $a\ge\sqrt2$.

**Proof.** Formula (6.5) is periodization in logarithmic coordinates. Let $W=\sqrt V|Z|$. The absolute integrability needed to interchange the periodized sum and the integral follows from $\alpha>0$ and finiteness of every positive moment of $W$. Changing variables gives

$$
\widehat F(j)
=\frac{p}{\log a}
\int_0^\infty y^{\alpha-i\omega_j-1}
\mathbb P(W>y)\,dy
=\frac{p}{\log a}
\frac{\mathbb E W^{\alpha-i\omega_j}}
{\alpha-i\omega_j}.
$$

The second identity follows by integrating $y^{s-1}$ from zero to $W$, with $\operatorname{Re}s=\alpha>0$, and applying Fubini to the absolute value. Independence yields (6.8).

The Gaussian Mellin transform is

$$
\mathbb E|Z|^s=
\frac{2^{s/2}\Gamma((s+1)/2)}{\sqrt\pi},
\qquad\operatorname{Re}s>-1. \tag{6.12}
$$

It has no zeros in this half-plane because the gamma function has no zeros. Thus all nonzero Fourier coefficients of $F$ vanish exactly when all nonzero Fourier coefficients of the measure (6.9) vanish. Uniqueness of finite measures from their Fourier coefficients, obtained for example by uniform trigonometric approximation of continuous periodic functions, proves the stated equivalence in both directions.

Under (6.10), the support of $\log_a\sqrt V$ lies in an interval of length strictly less than one. Its projection to the circle misses an open arc, which a nonzero uniform measure cannot do. Therefore $\mu$ is not uniform and $F$ is nonconstant.

To check (6.11), condition (6.10) is equivalent to

$$
R_0\lt a^2v_*+Q_0.
$$

At equality, the Riccati fixed-point equation gives $v_*=R_0/2$, and hence $Q_0=R_0(1-a^2/2)$. The quantity $a^2v_*+Q_0$ is strictly increasing in $Q_0$, either from (6.2) or from monotone Riccati iteration. This proves the strict equivalence. If $a\ge\sqrt2$, the right side of (6.11) is nonpositive, while $Q_0>0$. The endpoint $a=\sqrt2$ is included because the inequality is still strict. $\square$

Condition (6.11) is a sufficient nonconstancy region. Outside it, Theorem 6.2 still gives the necessary-and-sufficient weighted phase criterion; we do not assert an explicit parameter classification there.

### Corollary 6.3. When a constant power law fails

The scalar tail is regularly varying with index $-\alpha$ if and only if $F$ is constant. Under (6.10),

$$
0\lt 
\liminf_{x\to\infty}x^\alpha\mathbb P(|E|>x)
\lt 
\limsup_{x\to\infty}x^\alpha\mathbb P(|E|>x)
\lt \infty. \tag{6.13}
$$

Every constant-prefactor approximation $Kx^{-\alpha}$ then has a nonvanishing asymptotic worst-case relative error.

**Proof.** Along $x=a^{n+t}$, (6.4) gives limit $F(t)$. Choosing phases attaining its minimum and maximum proves (6.13). If the tail were regularly varying, its ratio at $cx$ and $x$ would tend to $c^{-\alpha}$ for every $c>0$. The same subsequence formula would force $F(t+\log_a c)=F(t)$ for every $c,t$, so $F$ would be constant. The converse follows directly from (6.4). Finally, a constant cannot uniformly approximate a positive nonconstant continuous function with vanishing relative error. $\square$

## 7. Three exact illustrations of the scope

These illustrations state analytic consequences. They do not use unreported numerical experiments.

### 7.1. A genuinely noisy scalar filter

Take $A=4$, $C=1$, $Q_0=R_0=1$, and $q=1/2$. Then

$$
v_*=\frac{7+\sqrt{65}}{16},\qquad
c=\frac1{15},\qquad\alpha=\frac12.
$$

Theorem 6.2 applies throughout this parameter choice. Thus the true time-varying filter has a nonconstant smooth periodic coefficient in

$$
\mathbb P(|E|>x)
=x^{-1/2}F(\log_4x)+O(x^{-5/2}).
$$

Measurement noise and process noise are both positive. This is not a noiseless resetting model, and the reception covariance retains its invariant random law.

### 7.2. A Jordan block changes high-confidence scaling

Let

$$
A=\begin{pmatrix}2&1\\0&2\end{pmatrix},
\qquad C=I_2,\qquad Q=R=I_2,\qquad q=\frac14.
$$

Here $\rho=2$, $m=1$, $\alpha=2$, and

$$
T=\frac12\begin{pmatrix}0&1\\0&0\end{pmatrix}.
$$

Formula (4.5) reduces to

$$
V(B)=\frac14\left(B_{22}+\frac13\right)
\begin{pmatrix}1&0\\0&0\end{pmatrix}.
$$

The rank-one limiting covariance is legitimate: it describes the dominant amplified direction, while the actual finite-age covariance remains positive definite. The conclusions are

$$
\mathbb P(\|E\|>x)=\Theta(x^{-2}(\log x)^2),
\qquad
Q_\varepsilon=\Theta(\varepsilon^{-1/2}\log(1/\varepsilon)).
$$

The second moment diverges at the critical exponent. The logarithmic factor is absent from the corresponding diagonalizable scale with $m=0$.

### 7.3. A nonnormal rotating phase

Let $S=\operatorname{diag}(2,1)$, choose a planar rotation $R_\theta$ with $\theta/\pi$ irrational, and put $A=2SR_\theta S^{-1}$. Take $C=I_2$ and any positive definite $Q,R$. Then $m=0$, and the reachable phase group is a circle. In real coordinates,

$$
T_\varphi=SR_\varphi S^{-1},
\qquad
V_\varphi(B)=T_\varphi BT_\varphi^\mathsf T+
\sum_{j\ge1}4^{-j}T_{\varphi-j\theta}QT_{\varphi-j\theta}^\mathsf T.
$$

Theorem 5.1 tracks $\varphi=n\theta\bmod2\pi$ through this family without requiring it to converge. This example illustrates why replacing the peripheral spectrum by its radius can discard the leading covariance geometry. We do not claim that every such parameter choice has nonconstant phase dependence; the general theorem permits symmetry-induced cancellations.

## 8. Approximating the phase family by finite operations

The invariant Palm law in (5.1) is not an extra unknown equation assumed solved. Lemma 3.1 gives a finite approximation procedure. The next proposition establishes approximation in the mathematical sense of convergent finite computations with the given matrix parameters; it does not claim polynomial complexity or computability of arbitrary real-number inputs.

### Proposition 8.1. Finite approximation of the coefficient

Fix compact positive $y$-intervals. The functions $S_z(y)$ and $\Phi(z,y)$ can be approximated uniformly in $z\in\mathcal G$ by the following operations:

1. finitely many reception-map compositions;
2. a finite geometric-gap tree;
3. a finite covariance series;
4. a finite bilateral tail sum;
5. finite-dimensional Gaussian probability evaluation to the desired accuracy.

Each truncation has an error tending to zero uniformly. The geometric-gap and tail-sum truncations have the explicit bounds given below.

**Proof.** Couple $B\sim\nu$ to a finite backward composition $B_N$, initialized at any fixed point of $\mathcal K$, using the same $N$ most recent reception gaps. Then

$$
d_T(B_N,B)\le
\kappa^N\operatorname{diam}_T(\mathcal K)=:\eta_N. \tag{8.1}
$$

Because the additional noise term in (4.5) is positive semidefinite, (8.1) implies

$$
e^{-\eta_N}V(z,B)\preceq V(z,B_N)
\preceq e^{\eta_N}V(z,B). \tag{8.2}
$$

The ordered eigenvalues obey the same multiplicative bounds. Coupling squared Gaussian norms by their eigenvalue representations, using common independent $Z_i^2$, places their tails between the corresponding tails at radii multiplied by $e^{\pm\eta_N/2}$. Uniform continuity of the Gaussian norm tails on the compact covariance family proves uniform convergence as $N\to\infty$.

Next replace each reception gap $k$ by $\min(k,K_0)$. The distribution now has finite support $\{0,\ldots,K_0\}$, where the last value absorbs the tail mass. The $N$-fold construction is a finite tree. The chance that any of the $N$ coupled gaps changes is at most

$$
Nq^{K_0+1}. \tag{8.3}
$$

Consequently the expectation of a probability-valued integrand changes by at most this amount.

The covariance-series tail in (4.5), beyond index $L_0$, has operator norm at most

$$
\|Q\|\sup_{z\in\mathcal G}\|T(z)\|^2
\frac{\rho^{-2(L_0+1)}}{1-\rho^{-2}}. \tag{8.4}
$$

The first covariance term already gives a uniform positive lower bound on $U$, so uniform continuity again controls the Gaussian probabilities.

For the bilateral sum (5.1), truncating to $-J_0\le k\le J_0$ loses at most

$$
p\sum_{k>J_0}q^k=q^{J_0+1} \tag{8.5}
$$

at the positive end. If $y\ge y_0>0$, the negative end is bounded by

$$
Kp\sum_{k\lt -J_0}
q^k\exp(-c y_0^2\rho^{-2k}), \tag{8.6}
$$

which tends to zero faster than a geometric sequence. For a fixed finite bilateral sum, its gap-truncation error is at most (8.3) times $p\sum_{|k|\le J_0}q^k$.

All remaining expectations are finite sums of finite-dimensional centered Gaussian norm probabilities. On the fixed support subspace their covariance matrices are nondegenerate and their densities are explicit; integration on a bounded box followed by a Gaussian tail bound gives arbitrary accuracy. Choose $J_0$ first using (8.5)–(8.6), then $N$, $K_0$, and $L_0$ using (8.1)–(8.4). This proves the asserted uniform finite approximation. $\square$

This construction is intended as a reproducibility statement. In practical numerical work, sampling the contractive reception chain can be much cheaper than enumerating its finite tree. Such stochastic computations require their own sampling-error assessment and do not replace the proof.

## 9. Model II: coupled partial observations

Sections 9–16 use a separate sensing model; they do not simultaneously generalize the arbitrary state matrix of Sections 2–8 and its full-rank observation assumption. Let the state dimension be $d\ge2$, and let

$$
x_{t+1}=a x_t+w_t,\qquad a>1,\qquad w_t\sim N(0,Q),\quad Q\succ0.
$$

At each time an iid label $I_t\in\{0,1,\ldots,M\}$ is drawn independently of every state and noise variable. Label zero is an erasure. For $i\ge1$, the observation is

$$
y_t=C_i x_t+v_{i,t},\qquad v_{i,t}\sim N(0,R_i),\quad R_i\succ0,
$$

where $C_i$ has rank $d-1$. Every process noise and observation noise is independent across time and sensor labels. The initial state is Gaussian and independent. The probabilities are

$$
\mathbb P(I_t=0)=p_0\in[0,1),\qquad
\mathbb P(I_t=i)=p_i>0,\qquad
\sum_{i=1}^M p_i=1-p_0=:s.
$$

Assume $M\ge2$ and the one-dimensional nullspaces $\ker C_i$ are pairwise distinct. Thus any two different sensor types have a jointly full-column-rank observation matrix. No individual observation is full rank. Sensors may be nonorthogonal; their Riccati updates generally do not decouple.

Whiten the process noise by $\widetilde x=Q^{-1/2}x$. The dynamics remains $aI$, the process covariance becomes $I_d$, and the sensor matrix becomes $\widetilde C_i=C_iQ^{1/2}$. All proofs below use this whitened coordinate system. Let $u_i$ be a unit vector spanning $\ker\widetilde C_i$, and write $W_i=u_i^\perp$. Let

$$
H_i=\widetilde C_i^\mathsf TR_i^{-1}\widetilde C_i,\qquad
H_0=0,\qquad
D(P)=a^2P+I,\qquad
O_i(X)=(X^{-1}+H_i)^{-1}.
$$

The posterior covariance satisfies $P_t=O_{I_t}(D(P_{t-1}))$, with $O_0$ the identity. The original-coordinate error is $Q^{1/2}E$; its asymptotic angular directions will be the original null lines $\operatorname{span}(Q^{1/2}u_i)=\ker C_i$.

Define

$$
r_i=p_0+p_i\in(0,1),\qquad
\alpha_i=-\frac{\log r_i}{\log a},\qquad
\alpha_0=
\begin{cases}
-\log p_0/\log a,&p_0>0,\\
+\infty,&p_0=0.
\end{cases}
$$

Always $\alpha_i\lt \alpha_0$. The exponent values and their stability implications belong to the comparison with random-measurement stability theory [6,7]; they are not by themselves claimed as the new result. The targets here are the exact angular phase measures, the coupled mark law, and the successive tails exposed after excluding dominant directions.

## 10. Stationarity without any full-rank observation

### Lemma 10.1. A two-sensor reset bound

There are finite constants $K_{ij}$, $i\ne j$, such that if sensor $j$ is observed, then $k$ erasures occur, and sensor $i$ is observed, the posterior covariance at the final time satisfies

$$
P\preceq K_{ij}a^{2(k+1)}I,                         \tag{10.1}
$$

independently of the covariance preceding these observations. Also every posterior covariance after one time step obeys

$$
P\succeq\ell I,\qquad
\ell=(1+\max_i\|H_i\|)^{-1}>0.                     \tag{10.2}
$$

**Proof.** Let the old observation be at time $-k-1$ and the new one at time zero. The stacked matrix

$$
G_{ij}=\begin{pmatrix}\widetilde C_j\\\widetilde C_i\end{pmatrix}
$$

has full column rank because its nullspace is the intersection of two distinct null lines. Multiply the earlier measurement by $a^{k+1}$, and stack it with the current measurement. The resulting vector equals $G_{ij}x_0$ plus a centered Gaussian noise whose covariance norm is at most a constant times $a^{2(k+1)}$. Indeed, the propagated process-noise sum has covariance

$$
\sum_{h=0}^k a^{2h}I=
\frac{a^{2(k+1)}-1}{a^2-1}I,
$$

and the earlier observation noise is multiplied by $a^{k+1}$. A fixed left inverse of $G_{ij}$ gives an estimator of $x_0$ with the stated covariance bound and no dependence on the previous state. The optimal conditional-mean estimator, which uses at least these observations, has no larger error covariance. This proves (10.1). Since $D(P)\succeq I$, monotonicity gives
$O_i(D(P))\succeq(I+H_i)^{-1}\succeq\ell I$, including label zero. $\square$

### Proposition 10.2. Unique stationary covariance and actual error law

The posterior covariance has a unique invariant probability law. From any finite positive semidefinite initial covariance it converges weakly to this law. The true optimal posterior-error marginal converges weakly to the centered Gaussian mixture with this covariance.

**Proof.** All maps $D$ and $O_i$ are nonexpansive in the Thompson metric: each is order preserving and subhomogeneous. Fix two distinct labels $i,j$. Their consecutive occurrence sends every starting covariance into a fixed compact interval $[\ell I,K I]$, by Lemma 10.1 with $k=0$.

On that compact interval, $D$ is strictly contractive with a uniform constant. To prove this directly, put $T=K/\ell$ and $\varepsilon=(a^2K+1)^{-1}$. For $Y\preceq KI$ and $t\ge1$,

$$
D(tY)=tD(Y)-(t-1)I
\preceq[t-\varepsilon(t-1)]D(Y).
$$

For $1\lt t\le T$, the continuous ratio

$$
\frac{\log[t-\varepsilon(t-1)]}{\log t}
$$

has a maximum strictly below one, with limiting value $1-\varepsilon$ at $t=1$. The same comparison in both directions therefore proves a uniform contraction factor $\kappa\lt 1$ for $D$ on the compact interval.

Split time into disjoint blocks of three steps. A block whose first two labels are $i,j$ has positive probability $p_ip_j$. Those first two steps send both members of any coupling into the compact interval, and the prediction of the third step contracts their distance by $\kappa$; the third update cannot increase it. Such blocks occur infinitely often almost surely in forward and backward time. After the first common good block, the distance is bounded by the diameter of the compact interval; every later good block contracts it. Backward compositions are thus Cauchy and independent of their remote starting values.

The limit is finite because the most recent good block is at a finite distance in the past and each intervening map is dominated by propagation $D$. This constructs a stationary covariance as a measurable function of the past labels, and the same coupling proves uniqueness. Forward Thompson distance to a stationary copy tends to zero almost surely. Tightness of the stationary copy converts this to Euclidean convergence in probability of coupled matrices, exactly by
$\|X-Y\|\le(e^{d_T(X,Y)}-1)\|Y\|$.
This implies weak convergence of the covariance law. Gaussian conditioning and characteristic functions then prove convergence of the actual error marginal, as in Proposition 3.2. No stationary unstable-state law is asserted. $\square$

## 11. Switching runs and an unbounded Palm law

Ignore zero labels temporarily. A switch into type $i$ means that the current nonzero label is $i$ and the preceding nonzero label was different from $i$. Let $B_i$ denote the posterior covariance at such a switch, under its stationary Palm law.

At an ordinary time, let $T$ be the type of the latest nonzero label, and let $N$ be the number of time steps since the last switch into that type. The event $T=i,N=n$ requires a switch into $i$ at time $-n$, followed by labels in $\{0,i\}$.

### Lemma 11.1. Exact switching-run decomposition

Write

$$
\lambda_i=\frac{p_i(1-r_i)}{s}.
$$

Then

$$
\mathbb P(T=i,N=n)=\lambda_i r_i^n,\qquad n\ge0.     \tag{11.1}
$$

Conditional on this event, the starting covariance has law $B_i$, independent of the next $n$ labels. Those labels are iid with conditional probabilities

$$
\mathbb P(\widehat I=0)=p_0/r_i,\qquad
\mathbb P(\widehat I=i)=p_i/r_i.                    \tag{11.2}
$$

If $P_n^{(i)}$ is the genuine Riccati covariance after $n$ such allowed labels starting at $B_i$, then for every bounded measurable covariance functional $f$,

$$
\mathbb E f(P)
=\sum_{i=1}^M\lambda_i\sum_{n\ge0}r_i^n
\mathbb E f(P_n^{(i)}).                            \tag{11.3}
$$

The expectation on the right includes both the Palm covariance and the allowed labels.

**Proof.** The preceding nonzero label, viewed just before the current time, has distribution $p_j/s$. It is independent of the current label. The stationary rate of switches into $i$ is consequently

$$
p_i\left(1-\frac{p_i}{s}\right)=\lambda_i.
$$

Future iid labels lie in $\{0,i\}$ for $n$ successive steps with probability $r_i^n$, and conditioning on that event gives (11.2). The past determining $B_i$ is independent of those future labels. Distinct $i,n$ classify the most recent switch uniquely; switches occur infinitely often because at least two nonzero types have positive probability. Finally,
$\sum_n\lambda_i r_i^n=p_i/s$, and summing over $i$ gives one, verifying the normalization. $\square$

### Lemma 11.2. Palm moments beyond the run exponent

If $p_0>0$, then

$$
\mathbb E\|B_i\|^\beta\lt \infty
\quad\text{for every }0\lt \beta\lt \alpha_0/2.            \tag{11.4}
$$

If $p_0=0$, every $B_i$ is supported in a fixed compact covariance interval, so all its moments are finite.

**Proof.** At a switch into $i$, let $K$ be the number of zeros between the previous different nonzero type and the current $i$. Conditional on a switch, this backward zero gap has law
$\mathbb P(K=k)=sp_0^k$. The previous type may vary, but all are different from $i$ and there are finitely many. Lemma 10.1 gives

$$
\|B_i\|\le C_*a^{2(K+1)}
$$

for a finite deterministic constant $C_*$. Its $\beta$-moment is finite when $p_0a^{2\beta}\lt 1$, which is (11.4). If $p_0=0$, the gap is zero and the bound is uniform. $\square$

The Palm covariance is generally unbounded. This is a structural difference from a full-rank reception and prevents directly importing the bounded-reception argument of Section 3. The strict inequality $\alpha_i\lt \alpha_0$ provides exactly the extra moment needed below.

## 12. A coupled mark from the entire future within a run

Let

$$
c=\frac1{a^2-1}.
$$

Start an allowed run of type $i$ at a deterministic covariance $B\succ0$. Couple all finite horizons using one infinite iid sequence with law (11.2), and define

$$
X_n=a^{-2n}(P_n^{(i)}+cI).
$$

### Lemma 12.1. Rank-one limiting covariance

Almost surely,

$$
X_n\downarrow\eta_i u_i u_i^\mathsf T,              \tag{12.1}
$$

in Loewner order and matrix norm. The mark $\eta_i$ depends on $B$ and the entire allowed future, and satisfies

$$
c\le\eta_i\le u_i^\mathsf TBu_i+c.                  \tag{12.2}
$$

The same statements hold with random $B=B_i$, independent of the allowed future.

**Proof.** Since $D(P)+cI=a^2(P+cI)$, and an observation update can only decrease covariance, $X_{n+1}\preceq X_n$. Thus $X_n$ has a positive semidefinite limit and is bounded above by $B+cI$.

The component of each process noise in direction $u_i$ is independent of its component in $W_i$, of the initial state, and of every allowed observation, because $Q=I$ and $\widetilde C_i u_i=0$. The hidden process-noise contribution alone therefore gives

$$
P_n^{(i)}\succeq c(a^{2n}-1)u_i u_i^\mathsf T.
$$

Hence $X_n\succeq c u_i u_i^\mathsf T$.

The allowed sensor is received infinitely often because $p_i/r_i>0$. Immediately after each such reception, the covariance restricted to $W_i$ is uniformly bounded: the restriction of $H_i$ to $W_i$ is positive definite, and the measured posterior covariance is at most its inverse. Multiplication by $a^{-2n}$ makes this restriction vanish along the reception subsequence. Since $X_n$ converges monotonically, its limit has zero restriction to $W_i$. A positive semidefinite matrix with that property has range in $\operatorname{span}u_i$. This proves (12.1), and the upper and lower bounds follow from those for $X_n$. $\square$

The lower bound proves that the limit has a genuine hidden direction. It is not a Gaussian approximation to the entire error: the actual transverse error remains present at finite age, but is of smaller scale on a long type-$i$ run.

### Proposition 12.2. An explicit Schur-complement formula

Use an orthonormal basis with first coordinate $u_i$, and write

$$
B=\begin{pmatrix}b&d^\mathsf T\\d&D_0\end{pmatrix},
\qquad D_0\succ0.
$$

Let $J_n$ be the likelihood information about the initial observed coordinate $z_0\in W_i$ furnished by allowed future observations at times $1,\ldots,n$. Then

$$
0\preceq J_n\uparrow J_\infty\preceq a^2I,          \tag{12.3}
$$

and the mark is

$$
\eta_i
=c+b-d^\mathsf TD_0^{-1}d
+d^\mathsf TD_0^{-1}(D_0^{-1}+J_\infty)^{-1}
D_0^{-1}d.                                        \tag{12.4}
$$

In particular, the mark keeps the correlation between the hidden and measured coordinates and the information supplied by the entire within-run future.

For a finite allowed observation schedule $1\le t_1\lt \cdots\lt t_k\le n$, there is the explicit formula

$$
J_n=\mathcal A^\mathsf T\Omega^{-1}\mathcal A,
\qquad
\mathcal A=\begin{pmatrix}a^{t_1}I\\\vdots\\a^{t_k}I\end{pmatrix},            \tag{12.5}
$$

where the effective measurement covariance on $W_i$ is
$R_i^{\rm eff}=(H_i|_{W_i})^{-1}$, and

$$
\Omega_{j\ell}
=\frac{a^{t_j+t_\ell}-a^{|t_j-t_\ell|}}{a^2-1}I
+\mathbf1_{\{j=\ell\}}R_i^{\rm eff}.                \tag{12.6}
$$

If there are no observations, set $J_n=0$.

**Proof.** A full-rank sufficient statistic on the observed subspace converts the sensor to $z_t+\epsilon_t$ with covariance $R_i^{\rm eff}$. Its finite-horizon likelihood conditional on $z_0$ is Gaussian, with design and noise covariance (12.5)–(12.6), obtained by summing the independent process increments. Gaussian conditioning gives

$$
K_n:=\operatorname{Cov}(z_0\mid\text{allowed future observations})
=(D_0^{-1}+J_n)^{-1}.
$$

Adding observations increases $J_n$ in Loewner order. Also $z_0\to z_1\to$ all observations at positive times is a Markov chain. Observing $z_1$ itself supplies information $a^2I$ about $z_0$, so
$K_n\succeq(D_0^{-1}+a^2I)^{-1}$, equivalently $J_n\preceq a^2I$. Thus $J_n$ converges.

The Gaussian initial coordinate decomposes as

$$
\xi_0=d^\mathsf TD_0^{-1}z_0+\zeta,
\qquad
\operatorname{Var}\zeta=b-d^\mathsf TD_0^{-1}d,
$$

with $\zeta$ independent of $z_0$ and of future observed-coordinate noises. Future hidden-coordinate process noises are also independent of every allowed observation. Therefore, for every finite $n$,

$$
u_i^\mathsf TX_nu_i
=c+b-d^\mathsf TD_0^{-1}d
+d^\mathsf TD_0^{-1}(D_0^{-1}+J_n)^{-1}D_0^{-1}d.
$$

Letting $n\to\infty$ proves (12.4). $\square$

This formula makes the future-dependent mark concrete and computable. The vector $d$ denotes cross-covariance in this block decomposition. Its information benefit is nonnegative, since the formula can also be written

$$
\eta_i=c+b-
d^\mathsf T\!\left[
D_0^{-1}-D_0^{-1}(D_0^{-1}+J_\infty)^{-1}D_0^{-1}
\right]d.
$$

Discarding the cross-covariance and keeping only the hidden marginal would give $c+b$, and therefore overestimates the mark by this nonnegative information benefit. The theorem does not assume that benefit vanishes.

## 13. Exact labelled angular phase measures

Let $Z\sim N(0,1)$ be independent of the Palm covariance and the allowed future. Define

$$
Y_i=\sqrt{\eta_i}\,Z u_i,
$$

with $\eta_i$ distributed according to $B_i$ and (11.2). By Lemmas 11.2 and 12.1, $Y_i$ has a finite $t$-th moment for every $t\lt \alpha_0$, and has no atom at zero.

For a continuous compactly supported function $f$ on $\mathbb R^d\setminus\{0\}$, define

$$
\mu_i(f)=\lambda_i\sum_{k\in\mathbb Z}
r_i^k\,\mathbb E f(a^kY_i).                        \tag{13.1}
$$

This is a locally finite measure on the punctured space. It is supported on the two rays of $\operatorname{span}u_i$, gives them equal weights, and satisfies discrete homogeneity

$$
\mu_i(aA)=r_i\mu_i(A).                              \tag{13.2}
$$

### Theorem 13.1. Complete switching-type tail limit

For every $f$ as above,

$$
r_i^{-n}\,
\mathbb E\!\left[f(a^{-n}E)\mathbf1_{\{T=i\}}\right]
\longrightarrow\mu_i(f).                           \tag{13.3}
$$

For every compact positive interval of $y$, uniformly on that interval,

$$
r_i^{-n}\mathbb P\{\|E\|>a^ny,\ T=i\}
\longrightarrow
\Phi_i(y):=\lambda_i\sum_{k\in\mathbb Z}
r_i^k\mathbb P\{\sqrt{\eta_i}|Z|>ya^{-k}\}.          \tag{13.4}
$$

The function $\Phi_i$ is positive, continuous, strictly decreasing from infinity to zero, and obeys
$\Phi_i(ay)=r_i\Phi_i(y)$.

**Proof.** Conditional on the covariance, the actual error is centered Gaussian. Substitute the exact switching decomposition (11.3), and write run age $j=n+k$. For each fixed $k$, Lemma 12.1 gives

$$
a^{-2n}P_{n+k}^{(i)}
\longrightarrow a^{2k}\eta_i u_i u_i^\mathsf T
$$

almost surely under the common infinite allowed-future coupling. Gaussian weak convergence and bounded convergence yield the corresponding term of (13.1). For the radial tail, the limiting Gaussian-mixture norm has no positive atoms. Continuity of its distribution gives uniform convergence on compact positive radii for each fixed $k$.

The critical issue is the negative-index tail: $B_i$ is unbounded. Choose

$$
\alpha_i\lt t\lt \alpha_0,
$$

which is possible; if $p_0=0$, choose any finite $t>\alpha_i$. By monotonicity in Lemma 12.1,
$P_j^{(i)}\preceq a^{2j}(B_i+cI)$. Gaussian moments and Lemma 11.2 imply, for $y\ge y_0>0$,

$$
\mathbb P\{\|N(0,P_{n+k}^{(i)})\|>a^ny\}
\le C_t y_0^{-t}a^{tk}.
$$

Multiplication by $r_i^k$ gives a summable bound over $k\lt 0$, since $r_i a^t>1$. The same estimate controls any test function supported away from zero. For $k\ge0$, boundedness of the test function or of a probability gives the summable majorant $r_i^k$. Dominated convergence of the bilateral series proves (13.3) and (13.4), including the omitted terms $k\lt -n$.

The remaining properties of $\Phi_i$ follow from its Gaussian-mixture terms, locally uniform convergence, reindexing, and positivity. The proof is the same periodization argument as in Section 5, especially (5.1)–(5.2), but its convergence here uses the strict Palm-moment gap $\alpha_i\lt \alpha_0$, rather than a bounded full-rank reception. $\square$

In original coordinates, replace $Y_i$ by
$\sqrt{\eta_i}ZQ^{1/2}u_i$ and push the measure $\mu_i$ forward by $Q^{1/2}$. No independence of original state coordinates is required.

### Corollary 13.2. Full radial tail and angular concentration

Let

$$
r_*=\max_i r_i,\qquad
\mathcal I_*=\{i:r_i=r_*\},\qquad
\alpha_*=-\log r_*/\log a.
$$

Then, vaguely on the punctured space,

$$
r_*^{-n}\mathbb P(a^{-n}E\in\cdot)
\longrightarrow \sum_{i\in\mathcal I_*}\mu_i.       \tag{13.5}
$$

In particular,

$$
\mathbb P(\|E\|>x)
=x^{-\alpha_*}F_*(\log_a x)+o(x^{-\alpha_*}),       \tag{13.6}
$$

with a positive continuous one-periodic coefficient. The angular mass of extreme errors concentrates on the null lines of the most frequently selected sensor types. Along thresholds $x=a^{n+t}$, a tied type $i\in\mathcal I_*$ has limiting conditional angular weight

$$
w_i(t)=\frac{\Phi_i(a^t)}
{\sum_{j\in\mathcal I_*}\Phi_j(a^t)},
$$

split equally between its two signs. No constancy or nonconstancy of these phase weights is assumed.

**Proof.** Formula (13.4), or its test-function analogue, shows that each type contributes $O(r_i^n)$ on sets bounded away from zero. The terms with $r_i\lt r_*$ vanish after normalization by $r_*^n$, and those with equality converge by Theorem 13.1. For all $x=a^{n+t}$, $0\le t\lt 1$, uniformity in $y=a^t$ yields

$$
F_*(t)=a^{\alpha_*t}\sum_{i\in\mathcal I_*}\Phi_i(a^t),
$$

and discrete homogeneity makes this one-periodic. Positivity and compactness give upper and lower positive bounds. Angular concentration follows because the limiting measure is supported on the displayed finite union of lines; the more precise hidden-cone result below also controls the mass away from them. $\square$

### Corollary 13.3. Moments and a sharp routing consequence

For $t>0$, the actual stationary error has finite $t$-th absolute moment if and only if $t\lt \alpha_*$, with divergence at $t=\alpha_*$. This is a consequence of the exact tail law, not a separate novelty claim about random-measurement stability.

For fixed erasure probability $p_0$ and a fixed family of $M$ pairwise distinct sensor null lines, the largest attainable radial tail exponent among iid routing distributions with positive $p_i$ is

$$
\alpha_{\rm opt}
=-\frac{\log[p_0+(1-p_0)/M]}{\log a}.              \tag{13.7}
$$

It is attained uniquely by equal routing probabilities $p_i=(1-p_0)/M$.

**Proof.** The moment assertion follows by integrating the upper and lower bounds in (13.6). The critical integral has integrand comparable to $1/x$, so it diverges. Since $r_*=p_0+\max_i p_i$, maximizing the exponent amounts to minimizing $\max_i p_i$ under a fixed sum $1-p_0$. Its minimum is $(1-p_0)/M$, with equality exactly when all entries are equal. $\square$

The design statement concerns the exponent only. Sensor geometry, measurement noise, and the coupled Palm law still determine the phase coefficients and finite risk; the result does not say that equal routing minimizes every finite-threshold risk.

## 14. Hidden angular tails after dominant directions are removed

List the distinct values among $r_i$ as

$$
r^{(1)}>r^{(2)}>\cdots>r^{(L)}.
$$

For level $\ell$, remove the more dominant null lines and consider

$$
\mathcal O_\ell
=(\mathbb R^d\setminus\{0\})\setminus
\bigcup_{\{i:r_i>r^{(\ell)}\}}\operatorname{span}u_i,
$$

with zero removed as well. A compact subset of this open cone stays a positive angular distance from every removed line.

### Lemma 14.1. Transverse errors of a run have the erasure-only scale

For each type $i$, let $\Pi_i$ be orthogonal projection onto $W_i$. Then, when $p_0>0$,

$$
\mathbb P\{\|\Pi_i E\|>x,\ T=i\}
=O(x^{-\alpha_0}).                                \tag{14.1}
$$

If $p_0=0$, the left side is bounded by $K e^{-cx^2}$.

**Proof.** Conditional on the most recent actual nonzero observation being type $i$, let $G$ be the number of erasures since it. The exact event has probability $p_i p_0^g$. At the type-$i$ observation, covariance restricted to $W_i$ is bounded by $(H_i|_{W_i})^{-1}$. After $g$ erasures it is bounded by $Ka^{2g}I_{W_i}$, independently of the unobserved covariance and all earlier history. Consequently the joint probability is bounded by

$$
Kp_i\sum_{g\ge0}p_0^g
\exp(-c x^2a^{-2g}).
$$

For $p_0>0$, write $x=a^{n+t}$ and reindex $g=n+k$. The same geometric/double-exponential summation as before bounds this by $Cx^{-\alpha_0}$ uniformly in $t\in[0,1]$. If $p_0=0$, only $g=0$ remains. $\square$

### Theorem 14.2. A complete hierarchy of hidden angular phase measures

For every $\ell$ and every continuous compactly supported test function $f$ on $\mathcal O_\ell$,

$$
(r^{(\ell)})^{-n}\mathbb E f(a^{-n}E)
\longrightarrow
\sum_{\{i:r_i=r^{(\ell)}\}}\mu_i(f).                \tag{14.2}
$$

Thus each smaller routing mass becomes visible at its own exact exponent and phase after the more dominant null directions are excluded. This is a cone-by-cone statement for the unconditional error law, not merely a statement conditional on the label.

**Proof.** Fix such an $f$, and let its support be $K$. It is bounded away from zero and from every removed line. For a removed type $i$, there is $c_K>0$ such that every $x\in K$ satisfies $\|\Pi_i x\|\ge c_K$. Therefore

$$
\left|\mathbb E[f(a^{-n}E)\mathbf1_{\{T=i\}}]\right|
\le\|f\|_\infty\,
\mathbb P\{\|\Pi_iE\|\ge c_K a^n,\ T=i\}.
$$

Lemma 14.1 makes this $O(p_0^n)$ if $p_0>0$, or Gaussian-small if $p_0=0$. Since every $r^{(\ell)}>p_0$, it vanishes after the normalization in (14.2).

For types with $r_i=r^{(\ell)}$, apply Theorem 13.1. Types with $r_i\lt r^{(\ell)}$ have $O(r_i^n)$ contributions and vanish. Summing over the finite set of types proves (14.2). $\square$

### Corollary 14.3. Directional exponents

For a nonzero linear functional $h^\mathsf T E$, suppose at least one $h^\mathsf T u_i\ne0$. Let

$$
r(h)=\max_{\{i:h^\mathsf T u_i\ne0\}}r_i,\qquad
\alpha(h)=-\log r(h)/\log a.
$$

Then

$$
\mathbb P(|h^\mathsf TE|>x)
=x^{-\alpha(h)}F_h(\log_a x)+o(x^{-\alpha(h)}),     \tag{14.3}
$$

with a positive continuous periodic coefficient obtained by replacing
$\sqrt{\eta_i}|Z|$ in (13.4) by
$|h^\mathsf T u_i|\sqrt{\eta_i}|Z|$
and summing the active maximizing types. Types annihilated by $h$ contribute only $O(x^{-\alpha_0})$, or a Gaussian bound for $p_0=0$.

If $h$ annihilates every null line and $p_0>0$, let $B^{\rm rec}$ be the covariance at the latest arbitrary nonzero reception and set

$$
V_h=h^\mathsf TB^{\rm rec}h+c\|h\|^2.
$$

This variable has positive finite deterministic lower and upper bounds. The projected tail has the complete expansion

$$
\mathbb P(|h^\mathsf TE|>x)
=x^{-\alpha_0}F_{h,0}(\log_a x)
+O(x^{-\alpha_0-2}),                              \tag{14.4}
$$

where

$$
F_{h,0}(t)
=s\,a^{\alpha_0t}
\sum_{k\in\mathbb Z}p_0^k
\mathbb P\{\sqrt{V_h}|Z|>a^{t-k}\}.                \tag{14.5}
$$

If $p_0=0$, the projection has a Gaussian tail upper bound and all its positive moments are finite.

**Proof.** For a nonannihilated type, repeat the proof of (13.4) for the one-dimensional projection; its limiting Gaussian variance is $\eta_i(h^\mathsf T u_i)^2>0$. For an annihilated type, $h\in W_i$, so Lemma 14.1 applies. All nonannihilated exponents are strictly below $\alpha_0$; the largest $r_i$ therefore determines (14.3).

If all types are annihilated, $h^\mathsf TB^{\rm rec}h$ is uniformly bounded at any nonzero reception because $h$ belongs to every measured subspace. It is bounded below by $\ell\|h\|^2$. The independent number of following erasures is geometric with probabilities $sp_0^j$, and

$$
h^\mathsf TPh
=a^{2j}V_h-c\|h\|^2.
$$

The bounded-variance periodization and mean-value estimate from Theorem 6.1 apply verbatim, with subtraction constant $c\|h\|^2$, giving (14.4)–(14.5). For $p_0=0$ there is a reception at the current time and the projected variance is uniformly bounded. $\square$

## 15. The full-dimensional hidden layer

The preceding hierarchy successively exposes the null lines of less frequently used sensor types. After all null lines are removed, a different exponent remains. This layer can be obtained directly without estimating remainders of the line-supported limits.

Let

$$
\mathcal H=\mathbb R^d\setminus
\bigcup_{i=1}^M\operatorname{span}u_i.
$$

This open cone excludes zero. Let $B^{\rm rec}$ be the stationary covariance immediately after an arbitrary nonzero observation. Its law is the ordinary reception Palm law, with reception label $i$ having probability $p_i/s$. Unlike a full-rank reception, $B^{\rm rec}$ is not uniformly bounded. However, conditional on reception label $i$,

$$
\Pi_i B^{\rm rec}\Pi_i
\preceq K_i\Pi_i.                                  \tag{15.1}
$$

Since the last nonzero reception is followed only by erasures, the stationary covariance has the exact representation

$$
P=a^{2J}(B^{\rm rec}+cI)-cI,\qquad
\mathbb P(J=j)=sp_0^j,                             \tag{15.2}
$$

where $J$ is independent of $B^{\rm rec}$, with the evident $J=0$ interpretation when $p_0=0$.

### Theorem 15.1. A hidden measure with positive full-dimensional density

Assume $p_0>0$. Let $G_B\mid B\sim N(0,B+cI)$, and define for every continuous compactly supported $f$ on $\mathcal H$,

$$
\mu_0(f)=s\sum_{k\in\mathbb Z}
p_0^k\,\mathbb E f(a^kG_{B^{\rm rec}}).             \tag{15.3}
$$

This is a Radon measure on $\mathcal H$, with a continuous strictly positive full-dimensional density there. It satisfies $\mu_0(aA)=p_0\mu_0(A)$, and

$$
p_0^{-n}\mathbb E f(a^{-n}E)
\longrightarrow\mu_0(f).                          \tag{15.4}
$$

If $p_0=0$, then for each compact $K\subset\mathcal H$,

$$
\mathbb P(a^{-n}E\in K)
\le C_K\exp(-c_Ka^{2n}).                           \tag{15.5}
$$

More generally, (15.4) holds for a radial tail restricted to a spherical sector at positive angular distance from all the null lines, whenever that sector has negligible boundary for spherical surface measure. If the sector has positive spherical surface measure, its tail has exact exponent $\alpha_0$ and a positive geometric-phase coefficient. Zero-measure sectors are permitted in the limit statement but have zero limiting coefficient. For $p_0=0$, every such sector instead has a Gaussian upper envelope.

**Proof.** Representation (15.2) is the usual last-nonzero-reception decomposition; the independent iid future zeros give its geometric factor. Write $J=n+k$ in the Gaussian mixture. For each fixed $k$,

$$
a^{-2n}P
=a^{2k}(B^{\rm rec}+cI)-ca^{-2n}I
\longrightarrow a^{2k}(B^{\rm rec}+cI)
$$

almost surely in $B^{\rm rec}$, so the corresponding test-function term converges by Gaussian weak convergence and bounded convergence.

Let $K$ contain the compact support of $f$. Because $K$ has positive distance from every null line, there is $\delta_K>0$ such that
$\|\Pi_i x\|\ge\delta_K$ for every $x\in K$ and every $i$. Conditional on the reception label $i$, (15.1) shows that the covariance of
$\Pi_i a^{-n}E$ for age $n+k$ is at most
$Ca^{2k}I_{W_i}$, uniformly in the otherwise unbounded $B^{\rm rec}$. A Gaussian tail bound thus gives

$$
\mathbb E|f(a^{-n}E)|
\le C\|f\|_\infty\exp(-c\delta_K^2a^{-2k})
$$

for that conditional component. After multiplication by $p_0^k$, this is summable over $k\lt 0$. For $k\ge0$, the bound $\|f\|_\infty p_0^k$ suffices. Summation over the finitely many possible reception labels proves (15.4), convergence of (15.3), and local finiteness.

Each summand has a positive Gaussian-mixture density. Since $B^{\rm rec}+cI\succeq cI$, the conditional Gaussian density in the hidden direction, given its measured-subspace coordinate, is bounded by a constant depending only on $c$. The measured-subspace marginal has covariance bounded above by (15.1) plus $cI$, and bounded below by $cI$. Consequently, on any compact $K\subset\mathcal H$, the density of the $k$-th scaled summand is bounded for $k\lt 0$ by

$$
C p_0^k a^{-dk}\exp(-c_Ka^{-2k}).
$$

For $k\ge0$, it is bounded by $Cp_0^ka^{-dk}$. Both series converge locally uniformly. Each Gaussian mixture density is continuous by dominated convergence, so their sum is continuous. Every summand is strictly positive everywhere, making the sum strictly positive on $\mathcal H$. Discrete homogeneity follows by reindexing.

If $p_0=0$, the current time itself has a nonzero reception. The measured-subspace covariance is bounded according to its label. The same projection argument gives (15.5).

For the stated radial sectors, membership at radius at least $y>0$ implies a uniform lower bound on every measured-subspace projection. The same negative-index bound therefore applies, while the positive-index terms are bounded by probabilities. Boundaries have zero probability under the full-dimensional limiting Gaussian mixture. Dominated convergence proves the sector version, including local uniformity in positive radial thresholds. Reindexing its bilateral coefficient gives the positive periodic all-threshold formula. $\square$

This provides a complete geometric hierarchy in the stated model: the more frequent sensing type's hidden line appears first, less frequent hidden lines appear on punctured cones at their own exponents, and the full-dimensional region away from all null lines appears at the erasure-only exponent. These are explicit tail-measure limits under geometric scaling. They are an arithmetic counterpart of hidden-tail stratification, rather than an assertion of ordinary regular variation in all real scales.

## 16. Computing the coupled mark and limitations of Model II

The mark is not an unspecified independent scalar reset. It is produced by the stationary switch Palm covariance, followed by an independent allowed future, and has the explicit Schur formula (12.4). A numerical approximation can use:

1. the contractive good-word construction for the stationary covariance;
2. conditional sampling or enumeration of switch histories to obtain $B_i$;
3. the finite information matrix (12.5) and its monotone limit;
4. the positive and negative tails of the bilateral series, controlled by $r_i^k$ and by a $t$-moment with $\alpha_i\lt t\lt \alpha_0$.

No claim of polynomial-time complexity or certified numerical constants is made here. The mathematical statements cover arbitrary positive measurement covariances and arbitrary nonorthogonal sensor hyperplanes. A general finite family of lower-rank sensors whose pairwise union need not be observable is not covered. In that broader setting, flats of the observation matroid and their intersection probabilities could produce further mechanisms; no theorem for that setting is asserted here.

Repeated sensor labels with identical null lines can in principle be grouped into one type, with the within-group measurement precisions retained in the allowed future. The proof uses only a common one-dimensional nullspace, full rank on its orthogonal complement, and finite uniform sensor bounds. This extension is not included in the formal statements here.

The phase measures are discretely homogeneous, so “hidden angular tail” here means the explicit cone hierarchy (14.2), not an unqualified claim of ordinary regular variation. Some phase coefficients may be constant; nonconstancy has not been proved uniformly for this partially observed family.


## 17. Limits of the conclusions


The full matrix theorem gives the phase family and its consistency relation. It does not assert that every matrix system has a nonconstant phase coefficient. Symmetries can remove phase dependence. The scalar theorem gives an exact criterion for constancy, and a broad explicit range where constancy is impossible.

Model I uses full-rank reception to obtain a bounded Palm covariance. Model II changes both the decomposition and the proof: its sensor-switch Palm covariance is generally unbounded, and its hidden amplitude contains future smoothing information. The rank-$d-1$, pairwise-distinct-null-line hypothesis is substantive. A general lower-rank sensor alphabet, correlated erasures, or arbitrary state dynamics combined with partial observation would require a separate analysis; eigenvalue cycles and more complex observability gaps can alter the relevant patterns.

The covariance law is stationary, and the Gaussian posterior-error marginal converges to the mixture analyzed here. No stationary unstable state, almost-sure uniform error bound, or risk guarantee for an implemented physical controller follows automatically.

The finite approximation result provides convergence of a transparent computation, not an efficiency theorem. The logarithmic exponent and the basic heavy-tail mechanism are established background. The novelty claim is limited to the stated exact phase and shape results relative to the literature examined; it is not an absolute priority certification.

## References

1. Y. Mo and B. Sinopoli. “Kalman Filtering With Intermittent Observations: Tail Distribution and Critical Value.” *IEEE Transactions on Automatic Control* **57**(3), 677–689, 2012. DOI: [10.1109/TAC.2011.2166309](https://doi.org/10.1109/TAC.2011.2166309). [Author manuscript](https://yilinmo.github.io/public/papers/journal2009kalman.pdf).

2. M. Pezzutto, L. Schenato, and S. Dey. “Heavy-tails in Kalman filtering with packet losses.” *European Journal of Control* **50**, 62–71, 2019. DOI: [10.1016/j.ejcon.2019.05.003](https://doi.org/10.1016/j.ejcon.2019.05.003). [Repository full text](https://mural.maynoothuniversity.ie/id/eprint/16360/1/out.pdf).

3. S. Kar, B. Sinopoli, and J. M. F. Moura. “Kalman Filtering With Intermittent Observations: Weak Convergence to a Stationary Distribution.” *IEEE Transactions on Automatic Control* **57**(2), 405–420, 2012. DOI: [10.1109/TAC.2011.2161834](https://doi.org/10.1109/TAC.2011.2161834). [Author preprint](https://arxiv.org/abs/0903.2890).

4. A. Censi. “On the performance of Kalman filtering with intermittent observations: a geometric approach with fractals.” *2009 American Control Conference*, 3806–3812, 2009. DOI: [10.1109/ACC.2009.5159869](https://doi.org/10.1109/ACC.2009.5159869). [Conference full text](https://skoge.folk.ntnu.no/prost/proceedings/acc09/data/papers/0127.pdf).

5. P. Kevei. “Implicit renewal theory in the arithmetic case.” *Journal of Applied Probability* **54**(3), 732–749, 2017. DOI: [10.1017/jpr.2017.31](https://doi.org/10.1017/jpr.2017.31). [Author preprint](https://arxiv.org/abs/1609.07339).

6. S. Y. Park and A. Sahai. “Intermittent Kalman Filtering: Eigenvalue Cycles and Nonuniform Sampling.” arXiv:1308.6107, 2013. [Preprint](https://arxiv.org/abs/1308.6107). Used here for the stated eigenvalue-cycle context; no journal-publication status is inferred.

7. D. E. Marelli, T. Sui, E. R. Rohr, and M. Fu. “Stability of Kalman filtering with a random measurement equation: Application to sensor scheduling with intermittent observations.” *Automatica* **99**, 390–402, 2019. DOI: [10.1016/j.automatica.2018.11.003](https://doi.org/10.1016/j.automatica.2018.11.003). [Author manuscript, version 2](https://arxiv.org/pdf/1806.08098v2).

8. E. Rohr, D. Marelli, and M. Fu. “Kalman Filtering with Intermittent Observations: Bounds on the Error Covariance Distribution.” *2011 50th IEEE Conference on Decision and Control and European Control Conference*, 2416–2421, 2011. [Author full text](https://www.eng.newcastle.edu.au/~mf140/home/Papers/Kalman_CDC2012.pdf). The filename contains 2012; the conference and year stated here follow the document's own title-page metadata.


9. S. Cai and V. K. N. Lau. “MSE Tail Analysis for Remote State Estimation of Linear Systems Over Multiantenna Random Access Channels.” *IEEE Transactions on Automatic Control* **65**(5), 2046–2061, 2020. DOI: [10.1109/TAC.2019.2937797](https://doi.org/10.1109/TAC.2019.2937797). [IEEE Communications Society official reading index](https://www.comsoc.org/publications/best-readings/communications-in-wireless-networked-control). The comparison here is limited to verified metadata and the official indexed description; the full text was unavailable.

10. E. Damek and S. Mentemeier. “Hidden regular variation for stochastic recursions with diagonal matrices.” arXiv:2510.23130v1, 2025. [Author preprint](https://arxiv.org/abs/2510.23130). Used with its stated diagonal-affine and nonarithmetic hypotheses.
