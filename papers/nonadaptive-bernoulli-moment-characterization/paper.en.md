# Finite moments of nonadaptive Bernoulli factories: an exact approximation criterion

**Research manuscript, 25 November 2026.** Written mathematical results. This work has not undergone external peer review. Full Lean formalization has not been completed.

## Abstract

Let a Bernoulli factory choose its random input budget before observing any coins, independently of the unknown input bias and of the entire input sequence. For every positive real $r$ and every continuous $f:[0,1]\to(0,1)$, we prove that an exact factory with finite $r$-th input-cost moment exists if and only if

$$
A_r(f):=\sum_{j=0}^{\infty}2^{2rj}E_{2^j}(f)<\infty,
$$

where $E_m$ is best uniform approximation by ordinary algebraic polynomials of degree at most $m$ on the whole closed interval. With a fixed margin from zero and one, the optimal regularized cost is comparable to $1+A_r(f)$. The sufficiency proof converts a signed approximation expansion into a single-branch probability mixture, using degree-uniform inverse Bernstein estimates. The converse applies to every nonadaptive randomized rule. A localized lacunary Chebyshev family gives an exact logarithmic transition at the critical moment. Separately, a Jensen certificate and a cumulative-tail Abel identity resolve the finite-variance question for the original power-law-truncated estimator of Koskela, Karvonen, Łatuszyński, and Spanò under explicit coefficient-order assumptions, and sharpen its guarantees for the specified Holtz--Nazarov--Peres coefficient family.

**Keywords:** exact simulation; Bernoulli factory; nonadaptive input complexity; polynomial approximation; moment summability; unbiased estimation.

## 1. Model, main theorem, and relation to prior work

### 1.1. What is charged

The input is an infinite sequence of independent Bernoulli variables with an unknown common parameter $x\in[0,1]$. A rule first draws an integer $N\ge0$ with a law depending on the known function $f$, but independent of $x$ and of the entire input sequence. It then reads exactly $N$ input coins and returns a bit. The decision may depend on their order and on auxiliary randomness. The same rule must have success probability $f(x)$ for every $x$, including both endpoints.

Only calls to the unknown input coin are charged. Independent exact randomization with specified real probabilities is available. This is an input-call existence model; effective computation needs representations of the approximation data and sampling probabilities. Section 3.6 states a certified-data implementation and its limits. No uniform algorithm for arbitrary noncomputable continuous functions is asserted.

For $m\ge0$, let $\Pi_m$ be the real algebraic polynomials of degree at most $m$, and write

$$
E_m(f)=\inf_{P\in\Pi_m}\|f-P\|_{\infty,[0,1]},\qquad
\mathcal C_r(f)=\inf_{\text{admissible exact rules}}\mathbb E(1+N)^r.
\tag{M.1}
$$

An empty infimum is $+\infty$. The regularization includes the zero-input case. Finiteness of $\mathbb E(1+N)^r$ and of $\mathbb EN^r$ is equivalent for every $r>0$.

### 1.2. Exact characterization

**Theorem M (all positive moments).** Fix $r>0$ and a continuous $f:[0,1]\to(0,1)$. There is an admissible exact factory with $\mathbb E(1+N)^r<\infty$ if and only if $A_r(f)<\infty$. More quantitatively, for every $0<\varepsilon\le1/2$ there are positive finite constants $c_r$ and $C_{r,\varepsilon}$ such that

$$
c_r\bigl(1+A_r(f)\bigr)
\le\mathcal C_r(f)
\le C_{r,\varepsilon}\bigl(1+A_r(f)\bigr)
\quad\text{whenever }\varepsilon\le f\le1-\varepsilon.
\tag{M.2}
$$

The constants do not depend on $f$. The upper bound is constructive from certified polynomial approximation data and a finite bound on their weighted error sum. No moment order, including integer $2r$, is excluded. Compactness supplies some positive $\varepsilon$ for every target in the stated class.

The condition is a summability criterion, stronger than a rate bound $E_m(f)=O(m^{-2r})$. Section 4 exhibits functions with

$$
E_{2^j}(f)\asymp2^{-\alpha j}j^{-\beta},
$$

for which the critical moment $r=\alpha/2$ is possible exactly when $\beta>1$. The result is stated in its own approximation norm; we do not identify it with an ordinary unweighted Besov space on $[0,1]$ without a separate endpoint-equivalence theorem.

### 1.3. Why these two directions meet

A rule of budget $n$ produces a degree-$n$ Bernstein polynomial with coefficients in $[0,1]$. Such a polynomial can be approximated at the smaller degree scale $\sqrt n$. This gives the converse after a dyadic sum. In the other direction, a polynomial of degree $m$ and bounded supremum norm has uniformly controlled Bernstein coefficients after elevating its degree to a constant times $m^2$. The two degree scales match. A positive baseline absorbs the signed approximation increments, turning them into a valid countable probability mixture.

Sections 2 and 3 prove the two directions independently. The lower bound also explains why improving a particular construction cannot evade the logarithmic obstruction in Section 4. Section 5 concerns a different, fixed estimator: its output moments and its input moments must be distinguished.

### 1.4. Prior work and exact contribution boundary

Holtz, Nazarov, and Peres [HNP11, Theorem 8] relate noninteger Hölder smoothness to adaptive simulation tail rates and explicitly raise a finite-moment characterization question in their Section 7. Their cost convention also accounts for fair coins. Theorem M treats the restricted nonadaptive, input-call model above; it does not solve that full adaptive question. Fixed-budget Bernstein representation is due to prior work [GS12]. Positive Bernstein coefficients and their degree elevation are classical, including [QRR11] and the approximation estimates in [DZ93]. These ingredients are not claimed as new theorems here.

The proposed main increment is the complete function-level, all-$r$ equivalence with quantitative optimal-cost comparison and explicit critical summability examples. The separate increment in Section 5 concerns the unchanged estimator in [KKLŚ26, equation (7)]. That paper's latest checked version is arXiv:2510.01941v2, revised 1 September 2026. We prove finite-variance guarantees without assuming the square-integrability needed by the variance identity discussed there. The new estimator bounds retain the original power-law distribution of the integer truncation.

The literature search also inspected a public source archive [TT] containing cusp and critical-moment lower bounds; those individual obstruction principles are not claimed here. Keane--O'Brien's original publisher full text was not accessible in this session, so no priority claim depends on excluding its unseen contents. The literature comparison is limited to the actual sources and versions examined.

## 2. Necessity for the whole nonadaptive class

### 2.1. Mixture representation

Conditional on $N=n$, average the rule's conditional output probability over all strings with $k$ heads. This gives coefficients $b_{n,k}\in[0,1]$, independent of $x$, such that

$$
f(x)=\sum_{n=0}^{\infty}p_nQ_n(x),\qquad
Q_n(x)=\sum_{k=0}^{n}b_{n,k}\binom nkx^k(1-x)^{n-k},
\quad p_n=\Pr(N=n).
\tag{N.1}
$$

For $p_n=0$, choose any coefficient vector. The series converges uniformly because $0\le Q_n\le1$ and $\sum p_n=1$. At $x=0,1$, the same identity follows directly from the conditional decision on the all-zero or all-one string. This averaging is a representation of an arbitrary order-sensitive rule, not a restriction imposed on it. Conversely, every representation (N.1) gives a rule by sampling $n$, reading its inputs, and returning a coefficient coin. Conditional auxiliary seeds may depend on $n$ while remaining independent of the input sequence.

### 2.2. Approximation of a Bernstein atom

**Lemma N1 (uniform atom estimate).** For each integer $K\ge1$ there is $C_K<\infty$ such that, for every $n\ge1$, $m\ge1$, and Bernstein polynomial $Q_n$ with $|b_{n,k}|\le1$,

$$
E_m(Q_n)\le C_K\min\{1,(\sqrt n/m)^K\}.
\tag{N.2}
$$

**Proof.** Put $F(z)=Q_n((1+\cos z)/2)$. This is entire, even, and $2\pi$-periodic. For $z=u+iv$, the ellipse identity is

$$
\left|\frac{1+\cos z}{2}\right|+
\left|\frac{1-\cos z}{2}\right|=\cosh v.
\tag{N.3}
$$

It follows directly as well from the half-angle squares: the two moduli are $|\cos(z/2)|^2$ and $|\sin(z/2)|^2$. Thus

$$
|F(u+iv)|\le(\cosh v)^n\le e^{nv^2/2}.
$$

The last inequality follows by integrating $\tanh v\le v$ for $v\ge0$ and using symmetry. Cauchy's formula on a disk of radius $n^{-1/2}$ centered at a real point gives

$$
\|F^{(K)}\|_{\infty,\mathbb R}\le e^{1/2}K!n^{K/2}.
\tag{N.4}
$$

Periodic Jackson approximation supplies a trigonometric polynomial $T_m$ of degree at most $m$ with

$$
\|F-T_m\|_\infty\le J_Km^{-K}\|F^{(K)}\|_\infty.
\tag{N.5}
$$

Here is a direct justification of the version needed. Choose an integer $s$ with $2s>K+1$. When $m\ge s$, let $M=\lfloor m/s\rfloor+1$ and normalize

$$
J(t)\ \propto\ \left(\frac{\sin(Mt/2)}{\sin(t/2)}\right)^{2s},\qquad -\pi\le t\le\pi,
$$

to have integral one. Its degree is $s(M-1)\le m$. Its normalization has order $M^{2s-1}$; the bound on the ratio by $\min(M,\pi/|t|)$ and an integral split at $1/M$ show that $\int |t|^KJ(t)\,dt\le C_Km^{-K}$. Integrate $J(t)$ against

$$
\sum_{a=1}^{K}(-1)^{a+1}\binom Ka F(u+at).
$$

For a Fourier mode of frequency $\ell$, the kernel coefficient has frequency $a\ell$, so all modes with $|\ell|>m$ vanish. The error is a $K$-th finite difference of $F$, bounded by $|t|^K\|F^{(K)}\|_\infty$. This proves (N.5) for $m\ge s$. When $1\le m<s$, take the constant mean of $F$. For any periodic differentiable $G$, integrating $G(u)-G(v)$ gives $\|G-\operatorname{mean}G\|_\infty\le2\pi\|G'\|_\infty$. Derivatives have zero mean, so iteration gives $\|F-\operatorname{mean}F\|_\infty\le(2\pi)^K\|F^{(K)}\|_\infty$. Enlarge $J_K$ by a constant depending only on $K$.

Average $T_m(u)$ with $T_m(-u)$ and take the real part. These operations preserve the error bound and produce an even real trigonometric polynomial. It has the form $P_m((1+\cos u)/2)$ with $P_m\in\Pi_m$. The angular map covers the entire interval, so the norms agree. Combining (N.4)--(N.5) and $E_m(Q_n)\le1$ proves (N.2). For $n=0$ the atom is constant, and $E_m(Q_0)=0$. $\square$

This proof keeps the endpoints. As an alternative classical source route, [HNP11, Lemma 17] and [DZ93, Theorem 3.3] give the same scale through weighted derivatives and Jackson approximation.

### 2.3. Summability and the universal lower bound

**Lemma N2 (atom cost bound).** For every $r>0$ there is $D_r<\infty$ such that

$$
A_r(Q_n)\le D_r n^r\quad(n\ge1),\qquad A_r(Q_0)=0.
\tag{N.6}
$$

Choose an integer $K>2r$ and $J=\lfloor\log_2\sqrt n\rfloor$. For $j\le J$ use $E_{2^j}(Q_n)\le1$. The resulting geometric sum is at most a constant times $n^r$. For $j>J$, Lemma N1 bounds the sum by

$$
C_K n^{K/2}\sum_{j>J}2^{(2r-K)j}\le D'_r n^r.
$$

This proves the lemma, including $n=1$.

Distance to $\Pi_m$ is subadditive, absolutely homogeneous, and 1-Lipschitz in the uniform norm. Apply these properties to finite partial mixtures in (N.1) and then pass to their uniform limit. The tail bound $\sum_{n>M}p_n\to0$ gives

$$
E_m(f)\le\sum_{n=0}^{\infty}p_nE_m(Q_n).
$$

Tonelli's theorem for the nonnegative double series and (N.6) now yield

$$
A_r(f)\le D_r\mathbb EN^r.
\tag{N.7}
$$

Therefore $1+A_r(f)\le(1+D_r)\mathcal C_r(f)$, proving the lower half of Theorem M. No interchange of an infimum and an infinite sum has been used. The argument applies to every admissible randomized rule, so divergence of $A_r(f)$ is an obstruction for the entire model.

## 3. Sufficiency and quantitative construction

### 3.1. Statement and model

Write

$$
 E_m(f)=\inf_{P\in\Pi_m}\|f-P\|_{\infty,[0,1]},\qquad
 A_r(f)=\sum_{j=0}^{\infty}4^{rj}E_{2^j}(f),
$$

where $\Pi_m$ denotes real polynomials of degree at most $m$. Fix $r>0$ and $0<\varepsilon\le 1/2$. Assume

$$
 \varepsilon\le f(x)\le1-\varepsilon\qquad(0\le x\le1).
$$

**Theorem S.** If $A_r(f)<\infty$, there is an exact Bernoulli factory which samples its input budget $N$ before observing any input coins, with the budget law independent of the unknown bias $x$, and satisfies

$$
 \mathbb E(1+N)^r\le C_{r,\varepsilon}\bigl(1+A_r(f)\bigr).
$$

Here the expectation has no dependence on $x$. Only calls to the input coin are charged. Auxiliary exact randomness and the specified real probability tables are available in the model. In particular, this is a theorem about input-call complexity, with no assertion of uniformly efficient computation of the tables or of their real-number representations.

We prove a stronger data-dependent version. Suppose that for every $j\ge0$, a polynomial $P_j\in\Pi_{2^j}$ and a nonnegative error certificate $e_j$ are supplied, with

$$
 \|f-P_j\|_\infty\le e_j,\qquad
 S:=\sum_{j=0}^{\infty}4^{rj}e_j<\infty.
 \tag{S.1}
$$

Then the construction below gives

$$
\begin{split}
 \mathbb E(1+N)^r
 &\le 4^r\left(\frac{8\pi^2}{\varepsilon}+2\right)^r
       \left(1+\frac{16S}{\varepsilon}\right)\\
 &\quad+4(2\pi^2+2)^r(4^r+1)S.
\end{split}
\tag{S.2}
$$

Thus one possible constant in Theorem S is

$$
 C_{r,\varepsilon}
 =4^r\left(\frac{8\pi^2}{\varepsilon}+2\right)^r
       \left(1+\frac{16}{\varepsilon}\right)
  +4(2\pi^2+2)^r(4^r+1).
 \tag{S.3}
$$

These constants are intentionally conservative. All dependence on degree is explicit.

### 3.2. A uniformly stable inverse Bernstein operator

For an integer $n\ge1$, define

$$
 b_{n,k}(x)=\binom nkx^k(1-x)^{n-k},\qquad
 (B_np)(x)=\sum_{k=0}^n p(k/n)b_{n,k}(x).
$$

We use only the following two classical polynomial inequalities in the self-contained argument below:

1. **Markov inequality on $[0,1]$:** if $p\in\Pi_m$, then
   $\|p'\|_\infty\le2m^2\|p\|_\infty$.
2. **Bernstein inequality for trigonometric polynomials:** if $F$ has trigonometric degree at most $m$, then
   $\|F''\|_\infty\le m^2\|F\|_\infty$, by applying its first-derivative version twice.

These are classical tools, not proposed original results. An independent primary-literature route to the same scale is available in [DZ93, equations (3.1) and (5.1)].

#### Lemma S.1: polynomial error of the Bernstein operator

For every integer $m\ge1$, $n\ge1$, and $p\in\Pi_m$,

$$
 \|B_np-p\|_\infty\le\frac{\pi^2m^2}{n}\|p\|_\infty.
 \tag{S.4}
$$

**Proof.** Set

$$
 F(\theta)=p\left(\frac{1+\cos\theta}{2}\right),\qquad0\le\theta\le\pi.
$$

This is the restriction of an even trigonometric polynomial of degree at most $m$, and its supremum norm on the circle equals $\|p\|_{\infty,[0,1]}$. Fix $0<x<1$, let $K\sim\operatorname{Bin}(n,x)$, and write

$$
 Y=K/n,\qquad \theta=\arccos(2x-1),\qquad
 \eta=\arccos(2Y-1),\qquad D=\eta-\theta.
$$

We first check the angle estimate with constants uniform up to the endpoints. Since

$$
 (\sqrt x,\sqrt{1-x})=(\cos(\theta/2),\sin(\theta/2)),
$$

and similarly for $Y,\eta$, their squared chord distance is

$$
 (\sqrt Y-\sqrt x)^2+
 (\sqrt{1-Y}-\sqrt{1-x})^2=4\sin^2(D/4).
$$

The inequality $\sin u\ge2u/\pi$ for $0\le u\le\pi/2$, together with $|D|\le\pi$, implies

$$
 D^2\le\pi^2\bigl((\sqrt Y-\sqrt x)^2+
                   (\sqrt{1-Y}-\sqrt{1-x})^2\bigr).
$$

Furthermore,

$$
\begin{split}
 \mathbb E(\sqrt Y-\sqrt x)^2
 &\le\frac{\mathbb E(Y-x)^2}{x}=\frac{1-x}{n},\\
 \mathbb E(\sqrt{1-Y}-\sqrt{1-x})^2
 &\le\frac{\mathbb E(Y-x)^2}{1-x}=\frac{x}{n}.
\end{split}
$$

Consequently,

$$
 \mathbb ED^2\le\frac{\pi^2}{n}.
 \tag{S.5}
$$

The mean of $Y$ is $x$, so $\mathbb E\cos\eta=\cos\theta$. Taylor's formula for cosine, with $\|\cos''\|_\infty\le1$, therefore yields

$$
 |\sin\theta\,\mathbb ED|\le\tfrac12\mathbb ED^2.
 \tag{S.6}
$$

Taylor's formula for $F$, the two classical inequalities above, and
$F'(\theta)=-\tfrac12\sin\theta\,p'(x)$ now give

$$
\begin{split}
 |B_np(x)-p(x)|
 &\le |F'(\theta)\mathbb ED|
      +\tfrac12\|F''\|_\infty\mathbb ED^2\\
 &\le\left(\tfrac14\|p'\|_\infty
             +\tfrac12m^2\|p\|_\infty\right)\mathbb ED^2\\
 &\le m^2\|p\|_\infty\mathbb ED^2
 \le\frac{\pi^2m^2}{n}\|p\|_\infty.
\end{split}
$$

At $x=0$ or $x=1$, $Y=x$ almost surely, so the error is zero. This completes the proof. $\square$

#### Lemma S.2: degree elevation and coefficient bounds

Let $m\ge1$, $n\ge m$, and put $\delta=\pi^2m^2/n$. If $\delta<1$, the restriction $T=B_n|_{\Pi_m}$ is invertible. For each $p\in\Pi_m$, its degree-$n$ Bernstein coefficients $c_k^{(n)}(p)$ obey

$$
 \max_{0\le k\le n}|c_k^{(n)}(p)|
 \le\frac{\|p\|_\infty}{1-\delta},
 \tag{S.7}
$$

and

$$
 \max_{0\le k\le n}
   |c_k^{(n)}(p)-p(k/n)|
 \le\frac{\delta}{1-\delta}\|p\|_\infty.
 \tag{S.8}
$$

In particular, if $n\ge2\pi^2m^2$, all coefficients have absolute value at most $2\|p\|_\infty$.

**Proof.** The operator $B_n$ maps $\Pi_m$ into $\Pi_m$. For example, the binomial factorial-moment identities show that $B_n(x^\ell)$ has degree at most $\ell$ for $\ell\le m$. Lemma S.1 gives $\|I-T\|\le\delta<1$ in the supremum norm on this finite-dimensional Banach space. The Neumann series gives

$$
 T^{-1}=\sum_{a=0}^{\infty}(I-T)^a,\qquad
 \|T^{-1}\|\le(1-\delta)^{-1},\qquad
 \|T^{-1}-I\|\le\delta/(1-\delta).
$$

For $q=T^{-1}p$,

$$
 p=B_nq=\sum_{k=0}^n q(k/n)b_{n,k}.
$$

Uniqueness of representation in the degree-$n$ Bernstein basis gives
$c_k^{(n)}(p)=q(k/n)$. The two norm bounds give (S.7) and (S.8). $\square$

**Degree-independence check.** The Neumann argument takes place in $\Pi_m$, but no norm-equivalence constant depending on $m$ is used. The operator norm in (S.4) is bounded explicitly by $\pi^2m^2/n$. This point is essential: a mere fixed-degree inverse-convergence theorem would not suffice for the result.

### 3.3. Construction from approximation certificates

Assume (S.1). Let

$$
 J=\min\left\{j\in\mathbb N_0:
          4^{rj}\ge\max\left(1,\frac{16S}{\varepsilon}\right)\right\}.
 \tag{S.9}
$$

This definition includes $S=0$, when $J=0$. By (S.1),

$$
 e_J\le S4^{-rJ}\le\frac{\varepsilon}{16},\qquad
 \sum_{k\ge J}e_k\le S4^{-rJ}\le\frac{\varepsilon}{16}.
 \tag{S.10}
$$

For each $j>J$, set

$$
 D_j=P_j-P_{j-1},\qquad a_j=e_{j-1}+e_j,
 \qquad w_j=4a_j,
 \qquad n_j=\left\lceil2\pi^2 4^j\right\rceil.
 \tag{S.11}
$$

Then

$$
 \deg D_j\le2^j,\qquad \|D_j\|_\infty\le a_j,
 \qquad
 W:=\sum_{j>J}w_j
 \le8\sum_{k\ge J}e_k\le\frac{\varepsilon}{2}\le\frac14.
 \tag{S.12}
$$

For each index with $a_j>0$, define

$$
 q_j(x)=\frac12+\frac{D_j(x)}{4a_j}.
 \tag{S.13}
$$

By Lemma S.2, every degree-$n_j$ Bernstein coefficient of $D_j$ belongs to $[-2a_j,2a_j]$. Hence every degree-$n_j$ Bernstein coefficient of $q_j$ belongs to $[0,1]$. Indices with $a_j=0$ have $D_j=0$ and $w_j=0$; they are omitted, so (S.13) never requires division by zero.

For the base branch, let

$$
 w_0=1-W,\qquad
 n_0=\left\lceil\frac{8\pi^2}{\varepsilon}4^J\right\rceil,
 \qquad
 q_0(x)=\frac{P_J(x)-W/2}{1-W}.
 \tag{S.14}
$$

Here the subscript $0$ labels the base branch; it is not the scale index $J$. We next verify its coefficient bounds rather than merely its pointwise range.

By (S.10),

$$
 \frac{15\varepsilon}{16}\le P_J(x)
 \le1-\frac{15\varepsilon}{16},\qquad
 \|P_J\|_\infty\le1.
 \tag{S.15}
$$

For $m=2^J$, $n=n_0$, Lemma S.2 has
$\delta\le\varepsilon/8\le1/16$. In particular, (S.8) gives

$$
 \max_k|c_k^{(n_0)}(P_J)-P_J(k/n_0)|
 \le 2\delta\|P_J\|_\infty\le\varepsilon/4.
$$

Combining this with (S.15) yields

$$
 \frac{11\varepsilon}{16}
 \le c_k^{(n_0)}(P_J)
 \le1-\frac{11\varepsilon}{16}.
 \tag{S.16}
$$

Since $W/2\le\varepsilon/4$, this interval is contained in $[W/2,1-W/2]$. Therefore

$$
 0\le c_k^{(n_0)}(q_0)
   =\frac{c_k^{(n_0)}(P_J)-W/2}{1-W}\le1.
 \tag{S.17}
$$

All branches now have a legitimate finite-input realization.

### 3.4. Factory and exactness

Before reading input coins, sample a branch label $I$ independently of the input sequence and of $x$, with

$$
 \mathbb P(I=0)=w_0,\qquad
 \mathbb P(I=j)=w_j\quad(j>J, a_j>0).
$$

These probabilities are nonnegative and sum to one. Set $N=n_I$. After reading exactly $N$ independent $\operatorname{Ber}(x)$ inputs, let $K$ be their number of heads. Use independent auxiliary randomness to output one with conditional probability

$$
 c_K^{(N)}(q_I).
$$

The bounds established in (S.13) and (S.17) show that this is a valid probability. Given $I=i$, the output has success probability

$$
 \sum_{k=0}^{n_i}c_k^{(n_i)}(q_i)b_{n_i,k}(x)=q_i(x).
$$

Different branch labels are allowed to have the same integer budget. The pre-sampled label is retained as auxiliary randomness; alternatively, conditional on a repeated budget, the corresponding coefficient arrays can be averaged with their conditional branch weights. Thus the construction satisfies the model that first samples a budget $N$, then reads $N$ coins.

Because $\sum_j e_j<\infty$, the series $\sum_{j>J}D_j$ converges absolutely in the uniform norm. Its partial sums telescope, and $\|f-P_j\|_\infty\le e_j\to0$, so

$$
 f=P_J+\sum_{j>J}D_j.
$$

Using (S.13) and (S.14), the unconditional success probability is exactly

$$
\begin{split}
 w_0q_0(x)+\sum_{j>J}w_jq_j(x)
 &=P_J(x)-W/2+
   \sum_{j>J}\bigl(w_j/2+D_j(x)\bigr)\\
 &=P_J(x)+\sum_{j>J}D_j(x)=f(x).
\end{split}
\tag{S.18}
$$

The branch distribution is a probability distribution on finite labels, and every $n_i$ is finite. Hence $N<\infty$ almost surely. Its independence of all input outcomes follows from the order of construction.

### 3.5. Quantitative moment bound

Since $4^j\ge1$,

$$
 1+n_j\le(2\pi^2+2)4^j\quad(j>J),
 \qquad
 1+n_0\le\left(\frac{8\pi^2}{\varepsilon}+2\right)4^J.
 \tag{S.19}
$$

The tail branches satisfy

$$
\begin{split}
 \sum_{j>J}w_j(1+n_j)^r
 &\le4(2\pi^2+2)^r
      \sum_{j>J}4^{rj}(e_{j-1}+e_j)\\
 &\le4(2\pi^2+2)^r(4^r+1)S.
\end{split}
\tag{S.20}
$$

The minimality of $J$ in (S.9) implies, also when $J=0$,

$$
 4^{rJ}\le4^r\max\left(1,\frac{16S}{\varepsilon}\right)
 \le4^r\left(1+\frac{16S}{\varepsilon}\right).
 \tag{S.21}
$$

Since $w_0\le1$, the base contribution is therefore at most

$$
 w_0(1+n_0)^r
 \le4^r\left(\frac{8\pi^2}{\varepsilon}+2\right)^r
          \left(1+\frac{16S}{\varepsilon}\right).
 \tag{S.22}
$$

Adding (S.20) and (S.22) proves (S.2). No inequality in this calculation requires $r\ge1$; in particular, all $0<r<1$ are included.

To obtain Theorem S, choose for each $j$ a best uniform approximant $P_j\in\Pi_{2^j}$ and put $e_j=E_{2^j}(f)$. Such minimizers exist because the approximation space is finite dimensional: a minimizing sequence can be taken in a bounded set, which is compact in that space. Then $S=A_r(f)$, proving the stated bound.

For any continuous $f:[0,1]\to(0,1)$, compactness provides some $\varepsilon>0$ with the required strict interior bounds. The uniform quantitative assertion uses a fixed supplied $\varepsilon$.

### 3.6. Meaning of construction from certified data

The formula uses only $r,\varepsilon$, the supplied polynomial/error pairs $(P_j,e_j)$, and a finite upper bound on their weighted sum. Exact knowledge of $S$ is unnecessary: any certified $\overline S\ge S$ can replace $S$ when choosing $J$, and the moment estimate then holds with $\overline S$ in place of $S$.

The infinite tail weight $W$ is not an additional unquantified limit. For every integer $M\ge J$,

$$
 0\le W-\sum_{j=J+1}^{M}w_j
     =4\sum_{j>M}(e_{j-1}+e_j)
 \le8\overline S\,4^{-rM}.
 \tag{S.23}
$$

Thus finite certificate data determine $W$ to arbitrary prescribed accuracy. Each finite coefficient table can be obtained by solving the degree-$m$ linear system $B_nq=p$, or directly by the usual exact basis-conversion identities. The proofs above certify their ranges.

For the arbitrary-real existence theorem, the minima, ceilings, and omission of zero-weight indices in Sections 3.3--3.5 are legitimate mathematical definitions. Its constants (S.2)--(S.3) are unchanged. An effective realization requires more careful choices, since equality and the ceiling of an arbitrary computable real are not uniformly decidable. Assume now that $r,\varepsilon,\overline S$ and the polynomial/error data are computable exact reals, with the stated positive-parameter and error certificates. Use the following conservative choices.

1. Set $L=r^{-1}\log_4\max\{1,16\overline S/\varepsilon\}$. Compute a rational upper enclosure $u$ with $L\le u<L+1$, and set $J_{\rm eff}=\lfloor u\rfloor+1$. The floor is taken only of a known rational number. Thus $L<J_{\rm eff}<L+2$, and the required small-tail inequalities hold without any exact-real equality test.
2. For the tail branches use the integer budgets
   $$
     \widetilde n_j=20\cdot4^j\qquad(j>J_{\rm eff}).
   $$
   The certified inequality $2\pi^2<20$ guarantees the coefficient stability condition.
3. Compute a rational upper enclosure $v$ with
   $8\pi^2/\varepsilon\le v<8\pi^2/\varepsilon+1$, put $B=\lfloor v\rfloor+1$, and use
   $$
     \widetilde n_0=B\cdot4^{J_{\rm eff}}.
   $$
   Then $8\pi^2/\varepsilon<B<8\pi^2/\varepsilon+2$, so the base coefficient bounds still hold. This also avoids the ceiling of a computable real.

Keep all tail indices in the categorical distribution, including those with $w_j=0$; do not attempt to decide which weights vanish. Use a fresh uniform random real and the computable cumulative weights to select the unique positive-width interval containing it. The countably many interval endpoints have probability zero. Every zero-weight branch has an empty interval and is never selected. The draw terminates almost surely, since the interval containing the uniform variate has a finite index, and its strict endpoint comparisons are eventually certified. If a tail branch $j$ is selected, its interval has positive width, which certifies $a_j>0$. Only then compute $a_j^{-1}$, by refining its real approximation until a positive rational lower bound is obtained, and form that branch's coefficient table. There is no uniform test for $a_j=0$ and no division on a zero-probability branch. The base branch has the already certified bound $1-W\ge3/4$.

With these choices,

$$
\begin{split}
 \mathbb E(1+\widetilde N)^r
 &\le4^{2r}\left(\frac{8\pi^2}{\varepsilon}+3\right)^r
       \left(1+\frac{16\overline S}{\varepsilon}\right)\\
 &\quad+4\cdot21^r(4^r+1)\overline S.
\end{split}
\tag{S.24}
$$

Indeed, $1+\widetilde n_0\le(8\pi^2/\varepsilon+3)4^{J_{\rm eff}}$,
$4^{rJ_{\rm eff}}\le4^{2r}\max\{1,16\overline S/\varepsilon\}$, and
$1+\widetilde n_j\le21\cdot4^j$. The mixture proof is otherwise unchanged. Thus the effective variant preserves the same linear dependence on the certified approximation sum, with an honestly increased base constant.

After the branch is selected, comparison with a second independent uniform random real implements its coefficient coin with almost sure termination. Again, equality with a specified computable probability is a null event, including probabilities zero and one. This computational observation does not assert any bound on auxiliary random bits, real-arithmetic work, or table size. It concerns uniform effective realizability only under the additional computable-data hypotheses of this section; the original theorem retains its arbitrary-real existence model.


## 4. Exact logarithmic endpoints and ordinary Hölder examples

Fix $\alpha>0$, $\beta\ge0$, an integer $M>\alpha+1$, and an integer $J\ge1$ with $2^J>4M$. Set $\eta=(1-2^{-\alpha})/4$ and

$$
f_{\alpha,\beta}(x)=\frac12+
\eta[4x(1-x)]^M\sum_{j=J}^{\infty}2^{-\alpha j}j^{-\beta}T_{2^j}(2x-1),
\tag{C.1}
$$

where $T_d(\cos\theta)=\cos(d\theta)$. The series converges uniformly. Since $|T_d|\le1$ and the weight is at most one, $|f_{\alpha,\beta}-1/2|<1/4$. Thus all these targets have a common positive margin, and both endpoint values are $1/2$.

**Theorem C (critical examples).** There are positive constants $c_{\alpha,M}$ and $C_\alpha$, independent of $\ell$ and $\beta\ge0$, such that for every $\ell\ge J$,

$$
c_{\alpha,M}2^{-\alpha\ell}\ell^{-\beta}
\le E_{2^\ell}(f_{\alpha,\beta})
\le C_\alpha2^{-\alpha\ell}\ell^{-\beta}.
\tag{C.2}
$$

Consequently an admissible exact factory has a finite $r$-th input-cost moment for some rule if and only if

$$
r<\frac\alpha2\quad\text{or}\quad
\left(r=\frac\alpha2\text{ and }\beta>1\right).
\tag{C.3}
$$

**Proof.** Truncate (C.1) before $j=\ell$. The polynomial has degree at most $2^{\ell-1}+2M\le2^\ell$; at $\ell=J$ it is the constant $1/2$. The tail norm is at most

$$
\eta\sum_{j\ge\ell}2^{-\alpha j}j^{-\beta}
\le\frac{\eta}{1-2^{-\alpha}}2^{-\alpha\ell}\ell^{-\beta}.
$$

For the lower bound, substitute $x=(1+\cos\theta)/2$. The weight becomes $\sin^{2M}\theta$. The $j$-th summand has cosine frequencies in $[2^j-2M,2^j+2M]$. These bands are disjoint because $2^J>4M$. Its highest cosine coefficient, at frequency $k_\ell=2^\ell+2M$, is exactly

$$
\eta(-1)^M2^{-2M}2^{-\alpha\ell}\ell^{-\beta}.
\tag{C.4}
$$

Indeed, the highest cosine coefficient of $\sin^{2M}\theta$ is $(-1)^M2^{1-2M}$, and multiplication by $\cos(2^\ell\theta)$ contributes an additional factor $1/2$. No other band contributes. An algebraic polynomial of degree at most $2^\ell$ has no angular frequency $k_\ell$. Every cosine coefficient of a continuous function is bounded by twice its supremum norm. Hence the approximation error is at least $\eta2^{-2M-1}2^{-\alpha\ell}\ell^{-\beta}$. This proves (C.2). Substituting it into Theorem M reduces the criterion to convergence of $\sum_\ell2^{(2r-\alpha)\ell}\ell^{-\beta}$, proving (C.3). In particular $\beta=1$ diverges harmonically at equality. $\square$

### 4.1. Endpoint-safe ordinary Hölder regularity

If $\alpha=k+\gamma$ is noninteger, with $k\ge0$ and $0<\gamma<1$, every function (C.1) belongs to the ordinary $C^\alpha[0,1]$ class, not merely a Hölder class after a change of variable.

To see this, put $G_d(x)=[4x(1-x)]^MT_d(2x-1)$. For every $0\le a\le k+1$ there is a constant $D_{M,a}$ such that

$$
\|G_d^{(a)}\|_{\infty,[0,1]}\le D_{M,a}d^a\qquad(d\ge1).
\tag{C.5}
$$

In angular coordinates $G_d=\sin^{2M}\theta\cos(d\theta)$ and $d/dx=(-2/\sin\theta)d/d\theta$. Inductively, after $a$ differentiations each term contains a power $d^b$ with $b\le a$, a power of $\sin\theta$ at least $2M-2a$, and bounded sine/cosine factors. Differentiating an oscillatory factor reduces that sine power by only one, so the stated lower bound remains valid. Because $M\ge a$, all such powers are nonnegative. The bound extends to the endpoints by continuity of polynomial derivatives, proving (C.5).

The series of derivatives through order $k$ converges uniformly since $\sum_j2^{(k-\alpha)j}j^{-\beta}<\infty$. For the increment of the $k$-th derivative over a distance $h\in(0,1]$, split at $2^j\le1/h$. The low-frequency part is at most

$$
Ch\sum_{2^j\le1/h}2^{(k+1-\alpha)j}\le C'h^\gamma,
$$

using (C.5) at order $k+1$. The high-frequency part is at most $C\sum_{2^j>1/h}2^{(k-\alpha)j}\le C'h^\gamma$. This proves ordinary Hölder regularity on the closed interval. No identification of integer $C^\alpha$ with a Zygmund space is made.

### 4.2. Consequence for smoothness-only guarantees

For noninteger $\rho>0$, the ordinary Jackson estimate $E_m(f)=O(m^{-\rho})$ and Theorem M give a finite $r$-th cost moment for every strictly interior $C^\rho$ target whenever $r<\rho/2$. At $r=\rho/2$, (C.1) with $\beta\le1$ proves that a guarantee for the entire Hölder class is impossible. At the same critical moment, $\beta>1$ gives examples that do admit a finite moment. For $r>\rho/2$ these examples again obstruct a universal guarantee. For example, at $\alpha=3/2$, the exact boundary is $r=3/4$, with the distinction determined by whether $\beta>1$.

The obstruction statement covers all rules in the nonadaptive model, by (N.7). It is not an assertion about the optimal cost of arbitrary adaptive rules.

## 5. The original debiased estimator: moments and boundedness

We now retain the estimator of [KKLŚ26, equation (7)], including its original integer-valued power-law truncation. This section does not replace it with the factory constructed in Section 3. Throughout, the lower coefficient arrays are ordered under Bernstein degree elevation. That hypothesis is used for nonnegativity; it is not dropped merely because the short statement of [KKLŚ26, Corollary 1] does not restate it.
### 5.1. Results and their exact scope

Throughout the HNP conclusions, the target is a continuous function
$f:[0,1]\to(0,1)$. Compactness therefore supplies a strictly positive
margin from both zero and one; this hypothesis is required for the
coefficient margin in Section 5.6.

First fix a noninteger $\rho>0$, and write
$\beta=\lambda-1>0$ and $a=\rho/2$. For the precise, unrounded
HNP coefficient family constructed at this fixed exponent in Section 5.6,
the original KKLŚ estimator satisfies the following sufficient conditions.

| Assumptions and parameters | Conclusion |
| --- | --- |
| $f\in C^\rho[0,1]$, $\rho>0$, $0<\beta<\rho/2$, sufficiently large initial cutoff $k$ | $0\leq\psi\leq1$, unbiased, uniformly for every input bias $x\in[0,1]$ |
| Same coefficient family, $0<\beta\leq\rho/2$, any fixed valid cutoff | Every finite positive moment of $\psi$ is finite |
| Same family, $p>1$, $(p-1)\beta<p\rho/2$ | $\mathbb E_x\psi^p<\infty$, uniformly in $x$ |
| Same family, $0<\beta<\rho$ | Finite variance |
| Same family, $\rho>1$, $1<\beta<\rho$ | Finite variance and finite mean input cost, without asserting $\psi\leq1$ |
| Same family, $\rho>2$, $1<\beta<\rho/2$, sufficiently large $k$ | $[0,1]$-valued estimator and finite mean input cost |

For integer smoothness $\rho$, use a noninteger construction exponent
$\sigma<\rho$. All strict inequalities in the table extend by choosing
$\sigma$ sufficiently close to $\rho$. In the second row, a single
construction gives every finite moment when $\beta<\rho/2$. At
$\beta=\rho/2$, the third row still gives every fixed finite moment by
choosing $\sigma<\rho$ depending on that moment, but does not provide
one coefficient family that works simultaneously for all moments.
Keep this quantifier distinction if quoting the table.

There is also a result requiring only the abstract coefficient monotonicity
and a function error bound: if $0\leq f-g_m\leq C m^{-a}$, then

$$
 (p-1)\beta<a
 \quad\Longrightarrow\quad
 \sup_{x\in[0,1]}\mathbb E_x\psi^p<\infty
 \qquad(p>1).
$$

In particular, finite variance follows from $1<\lambda<1+\rho/2$ under
the abstract function gap alone. This directly answers the source's
$\rho>2$ finite-variance question, without an assumption of square
integrability and without using its variance identity. If $\rho>2$, the
interval $2<\lambda<1+\rho/2$ additionally gives finite mean input cost.

All displayed parameter boundaries are sufficient conditions. No assertion
that they are necessary for each function or each coefficient family is
made. For example, constant targets have trivial estimators outside these
ranges. The full moment characterization in the main project is a separate
result and must not be conflated with these sufficient conditions for one
particular estimator.

### 5.2. Bernstein elevation and assumptions

For integers $0\leq m\leq n$, let $T_{m,n}$ be the degree-elevation map
on normalized Bernstein coefficients:

$$
 (T_{m,n}c)_s
 =\sum_{i=0}^{m}
   \frac{\binom mi\binom{n-m}{s-i}}{\binom ns}c_i,
 \qquad 0\leq s\leq n.
 \tag{O.2.1}
$$

Use the convention $\binom uv=0$ outside $0\leq v\leq u$.
The denominator is positive for every displayed $s$, including $s=0,n$.
Vandermonde's identity shows that every row is a probability vector.
Consequently the maps are positive, preserve constants, and contract the
coefficient sup norm. They satisfy

$$
 T_{m,n}T_{\ell,m}=T_{\ell,n}\qquad(\ell\leq m\leq n).
 \tag{O.2.2}
$$

One verification of (O.2.2) is to choose an $m$-subset uniformly from an
$n$-set and then an $\ell$-subset uniformly from that subset. The final
subset is uniform among all $\ell$-subsets, and conditioning on the total
number of marked elements gives (O.2.1).

Let $A_n=(a(n,i))_{i=0}^n$ and $B_n=(b(n,i))_{i=0}^n$ satisfy

$$
 0\leq A_n\leq B_n\leq1,
 \qquad T_{m,n}A_m\leq A_n\leq B_n\leq T_{m,n}B_m
 \quad(m\leq n).
 \tag{O.2.3}
$$

All inequalities between coefficient vectors are componentwise. Define

$$
 g_n(x)=\sum_{i=0}^n a(n,i)\binom ni x^i(1-x)^{n-i},
 \qquad
 h_n(x)=\sum_{i=0}^n b(n,i)\binom ni x^i(1-x)^{n-i}.
 \tag{O.2.4}
$$

Assume $g_n(x)\uparrow f(x)$ and $h_n(x)\downarrow f(x)$. In
Sections 5.3 and 5.4, only the lower arrays, their monotonicity, and
$g_n\uparrow f$ are actually needed. The upper arrays are one way to
certify the error $e_n(x):=f(x)-g_n(x)$.

Two error assumptions must remain distinct:

$$
 0\leq e_n(x)\leq h_n(x)-g_n(x)\leq C n^{-a}
 \quad\text{for all }x,
 \tag{FG}
$$

and the stronger coefficient assumption

$$
 \|B_n-A_n\|_{\ell^\infty}\leq C n^{-a}.
 \tag{CG}
$$

(CG) implies (FG), but the proof below never infers (CG) just from (FG).

### 5.3. The unchanged estimator and elementary identities

Fix an integer $k\geq1$, $\lambda=1+\beta>1$, and define

$$
 Z(m)=\sum_{j=m}^\infty j^{-1-\beta},
 \qquad
 \mathbb P(L=\ell)=\frac{\ell^{-1-\beta}}{Z(k)}
 \quad(\ell\geq k).
 \tag{O.3.1}
$$

The random variable $L$ is independent of the input coins. Set

$$
 q_m=\mathbb P(L\geq m)=\frac{Z(m)}{Z(k)},
 \qquad w_m=q_m^{-1}\quad(m\geq k).
 \tag{O.3.2}
$$

In particular $q_k=w_k=1$. For fixed $\ell\geq k$ and
$0\leq s\leq\ell$, put

$$
 y_m=H_\ell(m,s):=(T_{m,\ell}A_m)_s,
 \qquad 0\leq m\leq\ell.
 \tag{O.3.3}
$$

By (O.2.2)--(O.2.3),

$$
 0\leq y_0\leq y_1\leq\cdots\leq y_\ell=a(\ell,s)\leq1.
 \tag{O.3.4}
$$

The original estimator is

$$
 \psi(\ell,s)
 =y_{k-1}+\sum_{m=k}^{\ell}w_m(y_m-y_{m-1}).
 \tag{O.3.5}
$$

For $S_\ell\sim\operatorname{Bin}(\ell,x)$, the hypergeometric
subsampling identity gives

$$
 \mathbb E_x H_\ell(m,S_\ell)=g_m(x),\qquad m\leq\ell.
 \tag{O.3.6}
$$

This is a polynomial identity on the whole closed interval. In particular,
it also holds at $x=0,1$, where $S_\ell$ is deterministic; no conditioning
on a zero-probability event at those endpoints is needed.

Every term of (O.3.5) is nonnegative. Therefore Tonelli's theorem, followed
by (O.3.6), proves in the extended nonnegative sense that

$$
 \begin{aligned}
 \mathbb E_x\psi(L,S_L)
 &=g_{k-1}(x)+\sum_{m=k}^\infty
    \frac{\mathbb P(L\geq m)}{q_m}
       [g_m(x)-g_{m-1}(x)]\\
 &=f(x).
 \end{aligned}
 \tag{O.3.7}
$$

In particular, $\psi$ is integrable and unbiased. This argument does not
assume any second moment. Since $L<\infty$ almost surely and every
$q_m>0$, each realized finite sum (O.3.5) is well defined.

#### 5.3.1. A finite Abel identity with the terminal boundary included

Let $d_m=w_{m+1}-w_m\geq0$. For every finite $\ell\geq k$,

$$
 \boxed{
 \psi(\ell,s)
 =a(\ell,s)+\sum_{m=k}^{\ell-1}d_m
   \bigl[a(\ell,s)-H_\ell(m,s)\bigr].}
 \tag{O.3.8}
$$

To prove it, subtract $y_\ell=y_{k-1}+\sum_{j=k}^\ell(y_j-y_{j-1})$
from (O.3.5). Because $w_k=1$, write
$w_j-1=\sum_{m=k}^{j-1}d_m$, interchange two finite sums, and telescope
$\sum_{j=m+1}^\ell(y_j-y_{j-1})=y_\ell-y_m$. There is no omitted
terminal term and no term at $m=k-1$. When $\ell=k$, the sum is empty
and $\psi(k,s)=a(k,s)$.

By the upper monotonicity in (O.2.3), the cumulative tail satisfies

$$
 \begin{aligned}
 0\leq a(\ell,s)-H_\ell(m,s)
 &\leq (T_{m,\ell}(B_m-A_m))_s\\
 &\leq\|B_m-A_m\|_\infty .
 \end{aligned}
 \tag{O.3.9}
$$

This is the crucial difference from bounding every individual increment
$H_\ell(m)-H_\ell(m-1)$ by the same error bound.

### 5.4. Finite moments from the function gap alone

#### Proposition O4.1. General moment certificate

For every real $p\geq1$, under the lower-array assumptions in Section 5.2,

$$
 \boxed{
 \mathbb E_x\psi^p
 \leq g_{k-1}(x)+\sum_{m=k}^\infty
      q_m^{1-p}[g_m(x)-g_{m-1}(x)]
 =f(x)+\sum_{m=k}^\infty
   [q_{m+1}^{1-p}-q_m^{1-p}]e_m(x).}
 \tag{O.4.1}
$$

The equality and inequality are valid as statements in $[0,\infty]$;
in particular, finiteness of the right side proves, rather than assumes,
the required moment.

**Proof.** Fix $(\ell,s)$. The nonnegative numbers

$$
 y_{k-1},\quad y_m-y_{m-1}\ (k\leq m\leq\ell),\quad 1-y_\ell
$$

sum to one. Regard them as weights attached to the numbers
$1,w_k,\ldots,w_\ell,0$, respectively. Convexity of $t\mapsto t^p$
gives

$$
 \psi(\ell,s)^p
 \leq y_{k-1}+\sum_{m=k}^{\ell}w_m^p(y_m-y_{m-1}).
 \tag{O.4.2}
$$

Apply Tonelli and (O.3.6); independence of $L$ and the coins changes
$w_m^p$ to $q_mw_m^p=q_m^{1-p}$ after taking expectation. This proves
the first inequality in (O.4.1).

For the equality, put $v_m=q_m^{1-p}$, so $v_k=1$. Finite summation
by parts gives

$$
 g_{k-1}+\sum_{m=k}^{M}v_m(g_m-g_{m-1})
 =g_M+\sum_{m=k}^{M-1}(v_{m+1}-v_m)(g_M-g_m).
 \tag{O.4.3}
$$

As $M\to\infty$, every term on the right is nonnegative and increases
to its stated limit. Monotone convergence gives the equality in (O.4.1).
No unverified vanishing boundary term is used. For $p=1$, the differences
of $v_m$ vanish and (O.4.1) recovers (O.3.7). $\square$

For $0<p<1$, integrability (O.3.7) and concavity give
$\mathbb E_x\psi^p\leq f(x)^p$, independently of any error rate.

#### Corollary O4.2. Power-law truncation and a polynomial function gap

If (FG) holds and $p>1$, then $(p-1)\beta<a$ implies a finite
$p$-th moment, uniformly over $x\in[0,1]$. More quantitatively,

$$
 \mathbb E_x\psi^p
 \leq f(x)+
 C(p-1)\beta\,2^{p\beta}
 (1+\beta/k)^{p-1}
 \left(\frac1{a-(p-1)\beta}+\frac1k\right)k^{-a}.
 \tag{O.4.4}
$$

**Proof.** Integral comparison gives, for every integer $m\geq1$,

$$
 \frac{m^{-\beta}}\beta
 \leq Z(m)
 \leq \frac{m^{-\beta}}\beta+m^{-1-\beta}.
 \tag{O.4.5}
$$

Since $Z(m)-Z(m+1)=m^{-1-\beta}$, the mean value theorem applied to
$z^{-(p-1)}$, followed by the lower bound in (O.4.5), yields

$$
 \begin{aligned}
 q_{m+1}^{1-p}-q_m^{1-p}
 &\leq (p-1)Z(k)^{p-1}m^{-1-\beta}Z(m+1)^{-p}\\
 &\leq (p-1)Z(k)^{p-1}\beta^p 2^{p\beta}
                  m^{(p-1)\beta-1}.
 \end{aligned}
 \tag{O.4.6}
$$

For $\gamma=a-(p-1)\beta>0$,

$$
 \sum_{m=k}^\infty m^{-1-\gamma}
 \leq k^{-\gamma}\left(\frac1\gamma+\frac1k\right).
 \tag{O.4.7}
$$

Substitute (FG), (O.4.6), (O.4.7), and the upper bound for $Z(k)$ in (O.4.5)
into (O.4.1). This is (O.4.4). $\square$

For $p=2$, (O.4.1) gives the particularly simple certificate

$$
 \operatorname{Var}_x(\psi)
 \leq f(x)(1-f(x))+
   \sum_{m=k}^\infty (q_{m+1}^{-1}-q_m^{-1})[f(x)-g_m(x)].
 \tag{O.4.8}
$$

Thus the KKLŚ finite-variance question does not require importing their
displayed Rhee--Glynn variance formula or checking the questionable limit
in their equation (18).

### 5.5. Strong coefficient gap: boundedness and a larger moment range

Assume (CG) for $m\geq k$. From (O.3.8)--(O.3.9),

$$
 0\leq\psi(\ell,s)
 \leq a(\ell,s)+C\sum_{m=k}^{\ell-1}d_m m^{-a}.
 \tag{O.5.1}
$$

The increment of the reciprocal tail is exactly

$$
 d_m=\frac{Z(k)m^{-1-\beta}}{Z(m)Z(m+1)}.
 \tag{O.5.2}
$$

Consequently, using (O.4.5),

$$
 d_m\leq D_k m^{\beta-1},
 \qquad
 D_k:=2^\beta\beta(1+\beta/k)k^{-\beta}.
 \tag{O.5.3}
$$

#### Theorem O5.1. Uniform boundedness of the original estimator

Suppose additionally that $a(n,i)\leq1-\eta$ for every $n\geq k$
and all $i$, where $\eta>0$. If $0<\beta<a$, then

$$
 \boxed{
 0\leq\psi(\ell,s)\leq 1-\eta+
 C\,2^\beta\beta(1+\beta/k)
 \left(\frac1{a-\beta}+\frac1k\right)k^{-a}
 }
 \tag{O.5.4}
$$

for every finite $\ell\geq k$ and $0\leq s\leq\ell$.
In particular $\psi\in[0,1]$ when $k$ is large enough.

**Proof.** Apply (O.5.3), then (O.4.7) with $\gamma=a-\beta$, to (O.5.1).
The remainder in (O.5.4) tends to zero as $k\to\infty$. All estimates
are deterministic in $(\ell,s)$, so they cover $x=0,1$ as well.
$\square$

An entirely explicit conservative cutoff is any integer $k$ in the
valid coefficient range satisfying

$$
 k^a\geq
 \frac{C\,2^\beta\beta(1+\beta)
              [1+(a-\beta)^{-1}]}\eta.
 \tag{O.5.5}
$$

The constants $C,\eta$ must themselves be certified from the chosen
coefficient family. Formula (O.5.5) does not make the HNP construction
computationally efficient or make its hidden constants automatically
available.

#### Proposition O5.2. Output moments when the cutoff does not ensure $[0,1]$

For any fixed valid $k$, (CG) gives:

* If $\beta<a$, $\psi$ is uniformly bounded, so every finite
  positive output moment exists.
* If $\beta=a$, then
  $\psi(\ell,s)\leq1+CD_k[1+\log(\ell/k)]$. Hence every finite
  positive output moment exists, because (O.3.1) has integrable powers of
  $\log(1+L)$.
* If $\beta>a$, then
  $\psi(\ell,s)\leq1+(CD_k/(\beta-a))\ell^{\beta-a}$.
  Therefore $\mathbb E_x\psi^p<\infty$ whenever
  $p(\beta-a)<\beta$.

**Proof.** In (O.5.1), bound the sum by
$CD_k\sum_{m=k}^{\ell-1}m^{\beta-a-1}$. The first case was treated in
Theorem O5.1. The harmonic sum in the second case is at most
$1+\log(\ell/k)$. For $\gamma=\beta-a>0$, comparison with an
integral on either $[m-1,m]$ or $[m,m+1]$, according to whether
$\gamma\leq1$ or $\gamma\geq1$, gives
$\sum_{m=k}^{\ell-1}m^{\gamma-1}\leq\ell^\gamma/\gamma$.
Finally,

$$
 \mathbb E L^t
 =\frac1{Z(k)}\sum_{\ell=k}^\infty\ell^{t-1-\beta}
 <\infty\quad\Longleftrightarrow\quad t<\beta
 \qquad(t>0).
 \tag{O.5.6}
$$

This proves the last assertion. The estimates are uniform in $s$ and
therefore in $x$. $\square$

For $p>1$, all three cases imply the concise sufficient condition
$(p-1)\beta<pa$. At $p=2$, it is $\beta<2a$.
At equality in this sufficient condition the present bound gives a
harmonic series; it does not prove that the actual estimator diverges.

### 5.6. The precise HNP coefficient family and the degree shift

This section imports specific statements from HNP2011, Section 5,
Steps 4--5, rather than inferring coefficient estimates from the
function-level statement of their Theorem 8.

Let $\rho>0$ be noninteger and $d=\lfloor\rho\rfloor$. HNP choose
an integer $b=2^s$, an initial $n_0$, and levels
$n_j=b^j n_0$. Their corrected polynomials $F_{n_j}$ have degree
at most $n_j+d$. Step 4 gives a number $\delta>0$ such that their
normalized Bernstein coefficients at degree $n_j+d$ lie in
$[\delta,1-\delta]$. Step 5, equations (47)--(48), defines

$$
 \phi_n(x)=\theta_\rho n^{-\rho}
              +[x(1-x)/n]^{\rho/2},
$$

$$
 G_n=F_n-D[x+(1-x)]^d B_n\phi_n,
 \qquad
 U_n=F_n+D[x+(1-x)]^d B_n\phi_n.
 \tag{O.6.1}
$$

Here $B_n$ is the usual Bernstein operator, and the factor
$[x+(1-x)]^d$ means elevation of a degree-$n$ coefficient vector
to degree $n+d$. HNP prove the lower and upper coefficient
monotonicity between consecutive levels. We use these raw real
coefficients; optional rounding for a separate fair-bit implementation
is not part of the present family.

Set $a=\rho/2$. Since elevation is a sup-norm contraction and
$x(1-x)\leq1/4$, the degree-$n+d$ coefficients of the gap in (O.6.1)
satisfy

$$
 \|\operatorname{coeff}_{n+d}(U_n-G_n)\|_\infty
 \leq C_0 n^{-a},
 \qquad C_0=2D(\theta_\rho+4^{-a}).
 \tag{O.6.2}
$$

Choose and retain only sufficiently large levels so that the correction
in each half of (O.6.1) has coefficient sup norm at most $\delta/2$.
Both coefficient vectors then lie in
$[\delta/2,1-\delta/2]$. Relabel the retained initial level as $j=0$.
This discarding of finitely many initial levels does not change the HNP
recursion already used to construct the remaining $F_n$.

Put $M_j=n_j+d$. For every integer $m\geq M_0$, choose the unique
$j$ with $M_j\leq m<M_{j+1}$, and define

$$
 A_m=T_{M_j,m}\operatorname{coeff}_{M_j}(G_{n_j}),
 \qquad
 B_m=T_{M_j,m}\operatorname{coeff}_{M_j}(U_{n_j}).
 \tag{O.6.3}
$$

For $0\leq m<M_0$, set $A_m=0$ and $B_m=1$.
The composition law and HNP's between-level ordering prove (O.2.3)
for every pair of integer degrees, including crossings of a level and
the crossing at $M_0$. On a gap between levels, the represented
polynomials are simply unchanged. Therefore their limits are still
$f$.

All large-degree coefficients in (O.6.3) lie in
$[\eta,1-\eta]$, where $\eta=\delta/2$. In particular, the lower
coefficients needed by Theorem O5.1 are uniformly separated from one.
Moreover,

$$
 m<M_{j+1}=bn_j+d\leq(b+d)n_j
 \quad(n_j\geq1),
$$

so (O.6.2) and contraction imply

$$
 \|B_m-A_m\|_\infty
 \leq C_0n_j^{-a}
 \leq C_0(b+d)^a m^{-a}
 \qquad(m\geq M_0).
 \tag{O.6.4}
$$

This explicitly accounts for both the $n+d$ degree shift and the
integer degrees between geometric levels. It gives (CG) with
$C=C_0(b+d)^a$. Taking $k\geq M_0$ makes the preceding bounds
applicable. The base index $k-1$, even if it precedes $M_0$, is
defined by the extension above; no nonexistent coefficient is used.

For integer $\rho$, first choose a noninteger $\sigma<\rho$.
The inclusion $C^\rho[0,1]\subset C^\sigma[0,1]$ permits the same
construction with $a=\sigma/2$. For each strict parameter inequality
claimed with $\rho$, choose $\sigma$ sufficiently close to $\rho$
to retain that inequality. A single construction at a single chosen
$\sigma$ must be used throughout any theorem invoking this argument.

### 5.7. Source question resolved and claims that remain separate

KKLŚ v2 Theorem 2 proves boundedness for $\rho>3$ and
$1<\lambda<(\rho-1)/2$. The paragraph following their Corollary 2
asks whether $\rho>2$ suffices for finite variance. Their proposed
route invokes a variance identity whose application itself requires
square integrability.

The present note gives two independent resolutions:

1. Proposition O4.1 is an extended-real Jensen/Tonelli estimate for the
   unchanged estimator. With the source's abstract function gap, it
   proves finite variance for $1<\lambda<1+\rho/2$. This argument
   does not use the HNP coefficient strengthening.
2. The precise HNP coefficients give a stronger conclusion. Abel
   summation of cumulative tails proves $[0,1]$ support for
   $1<\lambda<1+\rho/2$ once $k$ is sufficiently large, for every
   positive noninteger smoothness exponent. They also give finite
   variance for the wider range $1<\lambda<1+\rho$, without asserting
   $[0,1]$ support there.

The elementary probability law (O.3.1) always satisfies
$\mathbb E L^r<\infty$ exactly for $r<\lambda-1$.
Thus the bounded-estimator construction supplies finite input-cost
moment $r$ when $r<\rho/2$ by choosing
$r<\lambda-1<\rho/2$. This is only a sufficient Hölder consequence;
it is not the main project's all-function necessary-and-sufficient
theorem and does not prove sharpness at its boundary.


## 6. Interpretation, verification, and remaining boundaries

Theorem M is a statement about the existence and optimal moment scale of exact nonadaptive factories. Its constants are deliberately conservative; it does not provide the least expected cost for an individual target. The distinction between an input-cost moment and an output moment is essential: a nonnegative unbiased estimator with finite variance can exceed one, so it cannot automatically be used as a probability for a final Bernoulli draw. Section 5 states separately when its output is in $[0,1]$.

The theory permits arbitrary exact auxiliary probabilities. The certified-data construction bounds input calls but does not bound the number of fair bits, the work needed to obtain approximation coefficients, or storage. Targets attaining zero or one, nonextendable targets on an open interval, and adaptive stopping costs are outside Theorem M. No classification of their finite moments is asserted. The familiar optimal-cost bounds for special analytic or positive-power-series factories [Men19] are not subsumed as claims of computational efficiency here.

An exact rational check described in the original manuscript verifies exact rational instances of Bernstein coefficient bounds, the signed-mixture identity, hypergeometric elevation, finite-truncation unbiasedness, Jensen and Abel identities, and the highest-frequency coefficient in (C.4). Its 245 finite estimator states include $x=0$ and $x=1$. It correctly compares a finite truncation to its terminal approximant, not to the infinite target. These checks support transcription and algebraic consistency; the infinite-dimensional and limiting conclusions rely on the written proofs.

Full formalization is incomplete. In particular, citing HNP is acceptable for a written theorem but does not turn its construction into a verified Lean axiom. Computational files and formalization source are not included in this edition; no kernel certification is claimed.

## 7. References and source status

**[HNP11]** O. Holtz, F. Nazarov, and Y. Peres. *New coins from old, smoothly*. Constructive Approximation 33 (2011), 331--363. [arXiv:0808.1936v3](https://arxiv.org/abs/0808.1936v3); [DOI](https://doi.org/10.1007/s00365-010-9108-5). Full text checked, especially Theorem 8, Lemma 17, Section 5 Steps 4--5, and Section 7. Its finite-moment question uses a broader algorithm and cost model.

**[KKLŚ26]** J. Koskela, T. Karvonen, K. Łatuszyński, and D. Spanò. *A debiased Bernoulli factory and unbiased estimation of a probability*. [arXiv:2510.01941v2](https://arxiv.org/html/2510.01941v2), revised 1 September 2026; first submitted in 2025. Full text and version history checked. We use equation (7), the coefficient order, and the question following Corollary 2. Apparent typographical errors in the displayed variance discussion are not used as identities.

**[DZ93]** Z. Ditzian and X. Zhou. *Optimal approximation class for multivariate Bernstein operators*. Pacific Journal of Mathematics 158(1) (1993), 93--120. [Publisher PDF](https://msp.org/pjm/1993/158-1/pjm-v158-n1-p06-p.pdf). The precise classical interfaces are equation (3.1), Theorem 3.3/equation (3.8), and Theorem 5.1/equation (5.1). The relevant PDF pages were visually checked. The elementary proofs above avoid importing an unspecified degree-dependent inverse constant.

**[GS12]** V. Goyal and K. Sigman. *On Simulating a Class of Bernstein Polynomials*. ACM Transactions on Modeling and Computer Simulation 22(2) (2012), Article 12. [Author manuscript](https://www.columbia.edu/~vg2277/simulate_bernstein.pdf); [DOI](https://doi.org/10.1145/2133390.2133396). Theorem 2.3 concerns a fixed, deterministic input budget. The author's PDF carries placeholder journal metadata; the bibliographic DOI is recorded separately.

**[QRR11]** W. Qian, M. D. Riedel, and I. Rosenberg. *Uniform approximation and Bernstein polynomials with coefficients in the unit interval*. European Journal of Combinatorics 32 (2011), 448--463. [Author-hosted publisher PDF](https://www.cctbio.ece.umn.edu/wiki/images/a/ab/Qian_Riedel_Rosenberg_Uniform_Approximation_and_Bernstein_Polynomials_with_Coefficients_in_the_Unit_Interval.pdf); [DOI](https://doi.org/10.1016/j.ejc.2010.11.004). Theorems 1--2 concern degree elevation and eventual positive-coefficient representation of a polynomial, not the random-budget moment criterion.

**[Men19]** L. Mendo. *An asymptotically optimal Bernoulli factory for certain functions that can be expressed as power series*. Stochastic Processes and their Applications 129(11) (2019), 4366--4384. [arXiv:1612.08923v5](https://arxiv.org/pdf/1612.08923v5). The special positive-series construction was checked; its early-stopping input cost should not be silently identified with a padded, fully pre-sampled budget.

**[KO94]** M. S. Keane and G. L. O'Brien. *A Bernoulli factory*. ACM Transactions on Modeling and Computer Simulation 4(2) (1994), 213--219. The publisher full text was inaccessible in this session. It is discussed in the accessible sources above; no proof step or universal novelty claim depends on unread content.

**[TT]** The Omega Institute, public `trureturing` source archive. Inspected files include [BernoulliCommonEndpointCharge.lean](https://github.com/the-omega-institute/trureturing/blob/6e318f328d41e2d09b8bbde8b1a95312cac35bd9/D5/S3/Estimation/SequentialDecisionRisk/BernoulliCommonEndpointCharge.lean) and [NativeBernoulliFactoryCriticalMoment.lean](https://github.com/the-omega-institute/trureturing/blob/51dca4f1542baa532983864568d6a8ca3470e745/D5/S3/Estimation/SequentialDecisionRisk/NativeBernoulliFactoryCriticalMoment.lean). Source inspection only; we did not compile these files or infer peer review. Their cusp and logarithmic endpoint obstructions are recorded as prior neighboring results.
