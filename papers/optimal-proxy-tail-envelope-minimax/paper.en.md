# Sharp contamination and inference frontiers for the optimal sub-Gaussian variance proxy

**Full research manuscript - 25 November 2026**

This version contains the clean foundation and every proof used by the new contamination, adaptation, and confidence results. No external peer review or machine-checked formalization is asserted by the manuscript.

## Abstract

The optimal sub-Gaussian variance proxy is a global moment-generating-function functional that can be altered by tail mass missing from an entire sample. We characterize how sampling uncertainty, arbitrary contamination, and honest inference interact for this functional. For each fixed continuous increasing exponential-moment envelope, define $B(s)=K^2\sup_{u\ge s}\Phi^{-1}(u)^2/u$. When $B$ is finite, under iid Huber contamination with known proportion $\epsilon_n\to0$, arbitrary contaminating distributions and unknown unrestricted clean location, the minimax expected absolute error is $(1/4+o(1))B(\log[1/(\epsilon_n+1/n)])$. The result covers every joint sampling-contamination regime without convexity or regular variation of the envelope. Its proof constructs a globally trimmed positive-remainder statistic and controls the error from estimating its center. The associated total-variation modulus has sharp constant $1/2$, including the unrestricted location family.

With the center and envelope known but contamination unknown, we determine a different sharp frontier. Among estimators attaining the clean first-order minimax constant, one contamination-independent procedure has exact worst risk $b_\epsilon/2-b_0/4+o(b_\epsilon)$, where $b_\epsilon=B(\log[1/(\epsilon_n+1/n)])$ and $b_0=B(\log n)$; every clean-optimal procedure obeys the matching lower bound. The upper construction caps empirical tails by the envelope and separates clean underestimation from contaminated overestimation. For clean data and unknown location, we also give explicit finite-sample honest intervals and upper bounds at each fixed coverage level $1-\alpha\in(0,1)$. Their deterministic minimax expected size or positive excess has constant $1/2$, independent randomization changes it to $(1-\alpha)/2$, and time-uniform upper coverage retains the deterministic first-order constant. Honest adaptation can fail even at a point mass. An independent held-out test illustrates both valid calibration and a precise limitation of a global-proxy pipeline. Established modulus, indistinguishability, centering, and stitching principles are explicitly separated from the sharp functional-specific conclusions.

## Overview: models, conclusions, and proof organization

Let $K>0$, $M>1$, and let $\Phi:[0,\infty)\to[0,\infty)$ be continuous, strictly increasing and unbounded, with $\Phi(0)=0$. The full location class is

```math
\mathcal C=\{P:\mu_P=E_PX\in\mathbb R,\quad E_P e^{\Phi(|X-\mu_P|/K)}\le M\},
\qquad v(P)=\sup_{t\ne0}\frac{2\log E_Pe^{t(X-\mu_P)}}{t^2}.
```

The known-center subclass has $\mu_P=0$. The parameter is the **squared** optimal proxy, and point risk uses expected absolute loss. All logarithms are natural. All asymptotics fix the entire envelope $(\Phi,K,M)$. Classwise remainders are uniform over clean and, where specified, contaminating laws; they do not assert uniformity over envelopes. Contamination is an iid mixture, not an adversarial replacement model. We use

```math
\operatorname{TV}(P,Q)=\sup_{A\ \mathrm{Borel}}|P(A)-Q(A)|,
\qquad b_0=B(\log n),\qquad b_\epsilon=B\!\left(\log\frac1{\epsilon_n+1/n}\right).
```

The following statements refer to finite $B$. The infinite-$B$ finite-sample impossibility and the consistency classification are also proved in the body.

| Statistical experiment | Sharp conclusion | Complete proof location |
|---|---|---|
| Clean, known center and envelope | Point risk $b_0/4$ | Part I, THM-01 |
| Known contamination, unknown clean location | Point risk $b_\epsilon/4$ | Part II, R4 and R29 |
| TV modulus, including unknown location | $B(\log(1/h))/2$ | Part II, R33 and R35 |
| Unknown contamination; known center and envelope; clean-optimal procedures | Risk $b_\epsilon/2-b_0/4$ | Part II, AD1-AD17 |
| Clean, unknown location | Known-envelope point risk $b_0/4$; one envelope-independent statistic has worst risk $b_0/2$ | Part III, LC-B |
| Clean, fixed honest coverage $1-\alpha$, deterministic procedures | Expected interval length and upper positive excess $b_0/2$ | Part III, LC-D and LC-F |
| Same confidence problem, independent randomization allowed | Expected criterion $(1-\alpha)b_0/2$ | Part III, LC-F |
| Clean time-uniform upper coverage | Same first-order upper-excess constant $1/2$ | Part III, LC-G |

Entries suppress their explicitly proved little-oh remainders. The unknown-contamination theorem is not asserted for unknown location. The confidence results are clean-data results. A robust point estimator cannot be substituted for an honest upper bound without a separate coverage theorem. These information regimes are distinct throughout the paper.

A centered support radius $K$, meaning $|X-\mu_P|\le K$, gives the respective point-risk scales $K^2/(4\log n)$ and $K^2/(4\log[1/(\epsilon_n+1/n)])$. A fixed **raw** interval $[a,b]$ of width $w=b-a$ with unknown mean is a different clean experiment: its sharp point risk is $w^2/(4\log n)$. The corresponding sharp confidence lower bound is forced at an endpoint point mass; it is not asserted with that same $w^2$ constant at every interior point mass.

### Contribution relative to the clean foundation

Part I retains the earlier clean known-center theory as a complete foundation. Its new contribution is not recounted as a second result of this continuation. The main additional content is a pair of exact robust decision theorems: known contamination has risk $b_\epsilon/4$, whereas maintaining the clean sharp constant without knowing contamination has risk $b_\epsilon/2-b_0/4$. Their efficiency ratio is

```math
2-\frac{b_0}{b_\epsilon}+o(1).
```

The robust upper proof combines a two-sided relative tail event, fractional rank trimming, a center with controlled error, and stability of a positive exponential remainder. It preserves the logarithmic visibility scale through every joint limit. The adaptation upper proof uses an envelope-capped empirical law that may have continuous Stieltjes pieces. Its two asymmetric comparisons distinguish clean underestimation from contamination-induced overestimation. These constructions, their sharp constants, and their irregular-envelope quantifiers are essential to the result; a generic contamination lower bound or a generic factor-two statement does not establish them.

The honest-inference theory supplies a complementary distinction. A point estimator can be first-order optimal while failing to be an honest concentration certificate. The deterministic constant $1/2$, the randomized qualification, and the failure of honest adaptation identify that difference within the same nonlinear experiment. The time-uniform and held-out testing results are consequences, not claims of new general stitching or testing principles.

### Relationship to checked prior work

Liu, Xu and Xing [1] study this same optimal proxy under assumptions on a truncation-gap function. Their empirical estimator already centers observations and their regular-model theory includes pointwise asymptotic confidence intervals. The clean foundation here uses a prescribed exponential moment rather than their full truncation-gap class; neither it nor the continuation resolves their general conjecture. The new inference theorem is uniform over classes containing sparse and degenerate distributions, with explicit finite-sample coverage and matching size constants. Unknown centering or the mere existence of a proxy confidence interval is not claimed as new.

Mies [2] studies empirical Luxemburg-Orlicz norms. Leskela and Zhukov [3] compare such norms with the square root of the optimal proxy, but multiplicative norm comparisons do not transfer exact additive risks. Arbel, Marchal and Nguyen [4] and Atouani, Marchal and Arbel [5] analyze optimal bounded or three-mass proxies. Lieber [6] already uses centered empirical MGFs and rare all-zero samples in concentration-parameter inference. These sources delimit the clean foundation and the sparse mechanisms reused below.

Chen, Gao and Ren [7, Section 5] formulate the general total-variation modulus lower principle in robust covariance and scatter estimation. Their general Huber decision theory [10] also studies adaptive robust procedures. We use that established geometry. The additional result here is its exact evaluation for a nonlinear global MGF functional, together with an attaining estimator that retains the constant across the sampling-contamination transition and unknown location. It does not subsume their matrix estimation results.

Liu and Gao [11, Sections 4.2-4.3] study adaptation in contaminated density estimation. Their lower-bound reasoning already permits the same observed law to have a clean and a contaminated interpretation. Jain, Orlitsky and Ravindrakumar [12, Section 2] provide a generic factor-two conversion for unknown corruption and a matching abstract obstruction. Our adaptation claim is the full constrained curve $2-b_0/b_\epsilon$, including the sharp clean constant and the subtractive risk term, achieved for the present iid functional by the envelope-capped construction. The underlying indistinguishability principle and factor-two phenomenon are not counted as new methods.

Cai and Low [8] characterize adaptive honest intervals for linear functionals in Gaussian experiments through between-class moduli. The present functional is a supremum of exponential moments under iid sampling, and its explicit full-class calibration and sharp constants require different calculations. Luo and Gao [13] study unknown-contamination honest intervals for location parameters, including logarithmic rates and tail-shape dependence. Our robust point-risk theorem and clean confidence theorem do not replace those robust intervals, and we do not claim to first reveal contamination adaptation or tail-dependent uncertainty quantification.

Howard and coauthors [9] provide established time-uniform confidence-sequence methodology; our dyadic error spending retains a sharp constant because the proxy scale changes slowly. Wang and Ramdas [14] treat robust sequential mean inference. Neither precedent makes a point-risk bound an honest bound for this proxy. Phipson and Smyth [15] supply valid Monte Carlo p-value methods. The obstruction in Part IV is restricted to a deterministic honest-global-proxy plus additive-coverage-correction pipeline at its specified sparse sample and held-out observation; it is not a universal lower bound for p-values or a refutation of an entire permutation procedure.

The cited literature was checked through primary author, journal, proceedings, or university sources. A bounded search found no identical theorem with the same functional, arbitrary-envelope class, sharp constants, and information regime. This is not a global priority certificate. One current mean-inference neighbor, arXiv:2610.15799, was available only at abstract level; no stronger comparison to it is asserted.

## Part I. Complete clean known-center foundation

This part gives the clean known-center foundation in full. Its section references, numbered equations and scope remarks apply within this part. Parts II and III address contamination and unknown location, respectively.

### I.2. Statistical model and main statements

#### 2.1. Definitions

**[DEF-01] Envelope class.** Throughout the main theorem, $K>0$ and $M>1$ are fixed constants. The function

```math
\Phi:[0,\infty)\longrightarrow[0,\infty)
```

is continuous, strictly increasing and unbounded, with $\Phi(0)=0$. Its inverse $a=\Phi^{-1}$ is therefore defined and continuous on $[0,\infty)$. Let

```math
\mathcal P_{\Phi,K,M}
=\left\{P:\ E_PX=0,\quad E_Pe^{\Phi(|X|/K)}\le M\right\}.
\tag{2.1}
```

The requirement $E_PX=0$ includes integrability and is known to the estimator. The observations $X_1,\ldots,X_n$ are independent with common law $P$.

**[DEF-02] Target and risk.** For a mean-zero law with finite sub-Gaussian proxy, define

```math
L_P(t)=\frac{2}{t^2}\log E_Pe^{tX}\quad(t\ne0),
\qquad L_P(0)=E_PX^2,
\qquad v(P)=\sup_{t\in\mathbb R}L_P(t).
\tag{2.2}
```

Thus $v(P)$, often denoted $\xi_*^2$, is the **squared** proxy; it is not $\sqrt{v(P)}$. For a class $\mathcal C$ of finite-proxy laws, put

```math
\mathcal R_n(\mathcal C)
=\inf_{T_n}\sup_{P\in\mathcal C}E_P|T_n-v(P)|,
\tag{2.3}
```

where the infimum is over real-valued measurable estimators. Allowing an independent randomization variable does not change any lower bound below. Write $\mathcal P_{\Phi,K,M}^{\mathrm{fin}}$ for the finite-proxy subfamily when the entire envelope class need not have finite proxies.

**[DEF-03] Envelope profile.** For $s>0$, let

```math
B(s)=B_{\Phi,K}(s)
=K^2\sup_{u\ge s}\frac{a(u)^2}{u}\in(0,\infty].
\tag{2.4}
```

All logarithms are natural. Asymptotic statements hold with $\Phi,K,M$ fixed. Remainders in bounds for a class are uniform over its distributions; they are not asserted to be uniform over all choices of envelope.

#### 2.2. Main theorem

**[THM-01] Exact minimax risk for arbitrary envelopes.** Under [DEF-01], the following alternatives hold.

1. If $B(s_0)<\infty$ for one $s_0>0$, every distribution in $\mathcal P_{\Phi,K,M}$ has a uniformly bounded finite proxy, and

   ```math
   \lim_{n\to\infty}
   \frac{\mathcal R_n(\mathcal P_{\Phi,K,M})}{B(\log n)}
   =\frac14.
   \tag{2.5}
   ```

2. If $B(s_0)=\infty$ for one $s_0>0$, then for every positive integer $n$,

   ```math
   \mathcal R_n(\mathcal P_{\Phi,K,M}^{\mathrm{fin}})=\infty.
   \tag{2.6}
   ```

   The same conclusion holds if this subfamily is further restricted to finite-support distributions.

No convexity, differentiability, regular variation, or monotonicity of $\Phi(x)/x^2$ is assumed.

**[COR-01] Estimability classification.** In the finite case, uniform consistency in expected absolute error is possible if and only if

```math
\frac{\Phi(x)}{x^2}\longrightarrow\infty.
\tag{2.7}
```

More precisely, if

```math
q_*:=\liminf_{x\to\infty}\frac{\Phi(x)}{x^2}\in(0,\infty),
```

then $\mathcal R_n\to K^2/(4q_*)$. If $q_*=0$, the finite-sample risk in (2.6) is infinite. These statements concern uniform risk, and do not preclude pointwise consistency at individual distributions.

**[THM-02] Fixed support.** Let

```math
\mathcal B_K=\{P:\ E_PX=0,\quad P(|X|\le K)=1\},\qquad K>0.
```

Then

```math
\lim_{n\to\infty}\frac{\log n}{K^2}\mathcal R_n(\mathcal B_K)=\frac14.
\tag{2.8}
```

The same limit holds after intersecting $\mathcal B_K$ with any fixed constraint $v(P)\le\Xi$, where $\Xi>0$.

The estimator proving [THM-01] uses $B$. Section 8 proves that a single estimator independent of $\Phi,K,M$ attains the exact worst-risk constant $1/2$ on every fixed finite-$B$ class. A corresponding lower bound shows that this factor two is necessary when adaptation requires a faster risk on another class.

### I.3. Deterministic envelope and exponential-remainder facts

#### 3.1. The tail supremum

**[LEM-01] Properties of $B$.** The profile is positive and nonincreasing. It is finite either at every positive argument or at none. In the finite case, for $s>0$, $h\ge0$,

```math
\frac{s}{s+h}B(s)\le B(s+h)\le B(s).
\tag{3.1}
```

It is continuous on $(0,\infty)$, and any nonnegative $h_s=o(s)$ satisfies $B(s+h_s)/B(s)\to1$. Moreover,

```math
sB(s)\ge K^2a(s)^2\longrightarrow\infty.
\tag{3.2}
```

Finiteness is equivalent to $q_*>0$, with $q_*=\infty$ allowed, and

```math
\lim_{s\to\infty}B(s)=K^2/q_*,
\tag{3.3}
```

where $1/\infty=0$.

*Proof.* The continuous function $a(u)^2/u$ is bounded on every compact subinterval of $(0,\infty)$; therefore finiteness of its tail supremum is independent of the positive starting point. Monotonicity and positivity are immediate. To prove the lower inequality in (3.1), fix $u\ge s$. If $u\ge s+h$, its ratio already occurs in $B(s+h)$. Otherwise,

```math
\frac{a(s+h)^2}{s+h}
\ge\frac{u}{s+h}\frac{a(u)^2}{u}
\ge\frac{s}{s+h}\frac{a(u)^2}{u}.
```

Take the supremum. Applying (3.1) on both sides of a point gives continuity and the stated shift stability. Equation (3.2) follows by choosing $u=s$ and using unboundedness of $a$. Finally, substitute $u=\Phi(x)$: the ratios in the tail supremum are $x^2/\Phi(x)$. Their limiting tail supremum is $1/q_*$, which proves the remaining claims. $\square$

**[LEM-02] A uniform finite proxy bound.** Suppose $H=B(s_0)<\infty$. Let

```math
C=M+e^{s_0},\qquad V_*=2CH.
\tag{3.4}
```

Uniformly over $\mathcal P_{\Phi,K,M}$,

```math
Ee^{X^2/H}\le C,\qquad 0\le v(P)\le V_*.
\tag{3.5}
```

*Proof.* For $x\ge Ka(s_0)$, put $u=\Phi(x/K)\ge s_0$ in the definition of $B$ to obtain

```math
\Phi(x/K)\ge x^2/H.
\tag{3.6}
```

Below that threshold, $x^2/H\le s_0$. Splitting the expectation proves the first inequality of (3.5).

For $|t|\le H^{-1/2}$, use mean zero and the Taylor remainder to get

```math
Ee^{tX}\le1+\frac{t^2}{2}E[X^2e^{|tX|}].
```

The inequalities $|tX|\le X^2/(2H)+1/2$ and $z e^{z/2}\le(2/e)e^z$, $z\ge0$, imply $E[X^2e^{|tX|}]\le2HC$. Thus $L_P(t)\le2HC$. For $|t|\ge H^{-1/2}$, completing the square gives

```math
Ee^{tX}\le C e^{Ht^2/4},\qquad
L_P(t)\le H(1/2+2\log C)\le2HC.
```

Here $C>2$. Jensen's inequality gives $L_P(t)\ge0$. These estimates also imply all exponential integrability and weighted moments subsequently used. $\square$

#### 3.2. Positive exponential remainders

**[LEM-03] Remainder identities, measurability, and a deterministic sample bound.** Define

```math
g_t(x)=e^{tx}-1-tx,\qquad
f_t(x)=\begin{cases}2g_t(x)/t^2,&t\ne0,\\x^2,&t=0.\end{cases}
\tag{3.7}
```

Then

```math
f_t(x)=2x^2\int_0^1(1-z)e^{ztx}\,dz\ge0,
\qquad
|\partial_t f_t(x)|\le\frac{|x|^3}{3}e^{T|x|}\quad(|t|\le T).
\tag{3.8}
```

Let $P_n$ denote the empirical measure and define

```math
A_n(t)=1+P_ng_t=P_n(e^{tX}-tX),
\quad
\widehat L_n(t)=\begin{cases}2\log A_n(t)/t^2,&t\ne0,\\P_nX^2,&t=0,\end{cases}
\quad
\widehat V_n=\sup_{t\in\mathbb R}\widehat L_n(t).
\tag{3.9}
```

For every finite real sample, $\widehat L_n$ is continuous, nonnegative, and tends to zero at both infinities. The supremum is a finite measurable random variable and

```math
0\le\widehat V_n\le2\max_iX_i^2.
\tag{3.10}
```

For every mean-zero population in the finite-$B$ class,

```math
1+Pg_t=M_P(t):=Ee^{tX},\qquad EA_n(t)=M_P(t),
\tag{3.11}
```

and

```math
|\widehat L_n(t)-L_P(t)|\le|(P_n-P)f_t|
\tag{3.12}
```

for all $t$, including zero.

Finally, let $R=\max_i|X_i|$ and $m_2=P_nX^2$. If $R=0$, then $\widehat V_n=0$. Otherwise $m_2>0$, and the supremum in (3.9) is attained on the finite interval $[-T_{\mathrm{data}},T_{\mathrm{data}}]$, where

```math
T_{\mathrm{data}}=\frac{4R}{m_2}+
\sqrt{\frac{4\log2}{m_2}},
\qquad
RT_{\mathrm{data}}\le4n+2\sqrt{n\log2}.
\tag{3.13}
```

*Proof.* Taylor's integral formula gives (3.8); differentiation under the finite integral gives its derivative estimate because $2\int_0^1z(1-z)\,dz=1/3$. Nonnegativity makes all logarithm arguments at least one, and the Taylor expansion at zero gives the asserted continuity.

For the deterministic bound, write $R=\max_i|X_i|$ and $u=|t|R$. On $[-u,u]$, the function $e^y-y$ has its maximum at an endpoint. The positive endpoint dominates since $e^u-e^{-u}-2u\ge0$. Hence $A_n(t)\le e^u-u$. If $0\le u\le1$,

```math
e^u-1-u\le(e-2)u^2\le u^2,
```

so $\log(e^u-u)\le u^2$. For $u\ge1$, the same conclusion follows from $\log(e^u-u)\le u\le u^2$. This proves (3.10). Also $A_n(t)\le2e^{|t|R}$, which proves decay of $\widehat L_n(t)$ as $|t|\to\infty$. Continuity shows that its supremum equals the supremum over rational arguments; each rational evaluation is measurable.

Mean zero gives (3.11). The map $z\mapsto\log z$ is 1-Lipschitz on $[1,\infty)$. Apply it to $1+(t^2/2)P_nf_t$ and $1+(t^2/2)Pf_t$, then divide by $t^2/2$, to obtain (3.12). The statement at zero follows directly.

For (3.13), use the preceding bound $A_n(t)\le2e^{|t|R}$. Whenever $|t|\ge T_{\mathrm{data}}$,

```math
\widehat L_n(t)\le\frac{2R}{|t|}+\frac{2\log2}{t^2}
\le m_2=\widehat L_n(0).
```

Continuity therefore places a maximizer inside the stated compact interval. Since $m_2\ge R^2/n$, multiplying the definition of $T_{\mathrm{data}}$ by $R$ gives its final bound. $\square$

The identity in (3.11) is why the known mean matters. The estimator is not the uncentered empirical MGF divided by $t^2$, and no population mean is estimated in this construction.

### I.4. A relative tail bound

**[LEM-04] Simultaneous empirical tail domination.** For arbitrary iid real observations, $0<\eta\le1$, $0<\beta<1$, set

```math
d_0=\frac{8\log(4(n+1)/\beta)}{n\eta},\qquad d=d_0+1/n.
\tag{4.1}
```

With probability at least $1-\beta$, for every real $x$,

```math
P(X>x)\le(1+\eta)P_n(X>x)+d,
\qquad
P(X \lt x)\le(1+\eta)P_n(X \lt x)+d.
\tag{4.2}
```

This includes distributions with atoms.

*Proof.* First, if $Y\sim\mathrm{Bin}(n,p)$ and $0 \lt r \lt p$, exponential Markov inequality gives

```math
P(Y\le n(p-r))\le\exp[-nr^2/(2p)].
\tag{4.3}
```

Indeed, put $\delta=r/p$, use $E e^{-tY}\le\exp\{np(e^{-t}-1)\}$, and choose $e^{-t}=1-\delta$. The resulting exponent is $-np[\delta+(1-\delta)\log(1-\delta)]$, which is at most $-np\delta^2/2$; the latter inequality follows by integrating $-\log(1-\delta)\ge\delta$.

Represent the observations as $X_i=F^{-1}(U_i)$ with independent uniforms. Consider the uniform empirical probability $\widehat p$ at each grid probability $p=k/n$, separately for the two tail directions. If $p\le d_0$, the desired grid bound is automatic. Otherwise its failure implies

```math
\widehat p<\frac{p-d_0}{1+\eta}.
```

Apply (4.3) with $r=(\eta p+d_0)/(1+\eta)$. Since $(\eta p+d_0)^2\ge4\eta p d_0$ and $(1+\eta)^2\le4$, the failure probability is at most $\exp(-n\eta d_0/2)$. A union bound over the $n+1$ grid points and two directions is smaller than $\beta$ for the value in (4.1).

For an arbitrary $p\in[0,1]$, choose the grid point $\lfloor np\rfloor/n$. Monotonicity of the empirical probability and a rounding error of at most $1/n$ prove the bound with $d$. Taking one-sided limits supplies both strict and non-strict uniform endpoint versions on the same event. Under the quantile representation, $\{U_i>F(x)\}=\{X_i>x\}$ and $\{U_i \lt F(x-)\}\subseteq\{X_i \lt x\}$, while the corresponding population probabilities are $1-F(x)$ and $F(x-)$. These identities and inclusions hold simultaneously for all $x$, so the uniform-probability bounds imply (4.2), including at atoms. $\square$

### I.5. The sharp upper bound

#### 5.1. Deterministic scales and estimator

Fix $s_0>0$ with finite $H=B(s_0)$, and use $V_*$ from [LEM-02]. For sufficiently large $n$, put

```math
N=\log n,\quad \ell=\log N,\quad b=B(N),\quad
S=N+10\ell,\quad r=\sqrt{S B(S)},
\tag{5.1}
```

```math
\eta=N^{-2},\quad\beta=N^{-8},\quad
d_0=\frac{8\log(4(n+1)/\beta)}{n\eta},\quad d=d_0+1/n,\quad D=\log(1/d),
\tag{5.2}
```

```math
c_n=\frac{r^2}{2D},\qquad
\tau=\frac{\ell}{\sqrt b},\qquad
T=\frac{r\ell}{b},\qquad
\Delta=\frac1{rN^2}.
\tag{5.3}
```

These quantities are positive for all sufficiently large $n$. The estimator can be set to zero before the parameters are valid. Let $\Pi_{[0,V_*]}$ denote metric projection onto the interval and define

```math
\widetilde V_n=\min\{V_*,\widehat V_n\},\qquad
\widehat v_n=
\Pi_{[0,V_*]}
\left(\frac{\widetilde V_n+\max\{\widetilde V_n,c_n\}}2\right).
\tag{5.4}
```

It is a measurable estimator by [LEM-03]. It uses the supplied envelope through $B$ and a finite uniform target bound.

**[LEM-05] Scale relations and the sample-support event.** The quantities above satisfy

```math
Nb\le r^2\le Sb,\qquad r\ge Ka(S),\qquad
c_n/b\longrightarrow1/2,
\tag{5.5}
```

```math
\tau r\le\sqrt S\ell=o(S),\qquad
Nb\longrightarrow\infty,\qquad b\le H
\tag{5.6}
```

for all sufficiently large $n$. On $x\ge r$,

```math
\Phi(x/K)\ge Sx^2/r^2.
\tag{5.7}
```

The event $\mathcal E_r=\{\max_i|X_i|\le r\}$ has failure probability at most $MN^{-10}$, uniformly over the class.

*Proof.* Equations (5.5)-(5.7), except the limit for $c_n$, follow directly from [LEM-01] and the argument for (3.6). Since

```math
d=8N^3n^{-1}(1+o(1)),\qquad
D=N-3\log N-\log8+o(1),
```

the remaining limit follows by sandwiching $r^2/b$ between $N$ and $S$. Finally, Markov inequality and a union bound give

```math
P(\mathcal E_r^c)\le nM e^{-\Phi(r/K)}\le nM e^{-S}=MN^{-10}.
```

$\square$

#### 5.2. Small arguments without a singularity at zero

**[LEM-06] An empirical-process bound by the fundamental theorem of calculus.** Let $T_0\ge0$. Whenever $EX^4<\infty$ and $EX^6e^{2T_0|X|}<\infty$,

```math
E\sup_{|t|\le T_0}|(P_n-P)f_t|
\le\frac1{\sqrt n}
\left\{(EX^4)^{1/2}+
\frac{2T_0}{3}(EX^6e^{2T_0|X|})^{1/2}\right\}.
\tag{5.8}
```

*Proof.* Write $(P_n-P)f_t$ as its value at zero plus the integral of its derivative along the interval from zero to $t$. Taking the supremum and enlarging that interval to $[-T_0,T_0]$ bounds the supremum by

```math
|(P_n-P)X^2|+
\int_{-T_0}^{T_0}|(P_n-P)\partial_t f_t|\,dt.
```

For any square-integrable $h$, independence gives $E|(P_n-P)h|\le(Eh^2/n)^{1/2}$. Apply this inequality, (3.8), and Tonelli. The displayed weighted moment justifies differentiation under the population integral and all preceding integrals. $\square$

**[LEM-07] Uniform small-argument comparison.** With the tuning in (5.1)-(5.3), uniformly over $P$,

```math
E\sup_{|t|\le\tau}|\widehat L_n(t)-L_P(t)|
\le b\exp\{-N/2+O(\sqrt N\log N)\}.
\tag{5.9}
```

In particular,

```math
\mathcal E_0=
\left\{\sup_{|t|\le\tau}|\widehat L_n(t)-L_P(t)|\le b/N\right\}
\tag{5.10}
```

has failure probability $o(N^{-A})$ for every fixed $A>0$.

*Proof.* These are bounds for the full population and full sample; the observations are not assumed bounded. Split at $r$. For $m=6$, the envelope and (5.7) give

```math
E[|X|^m e^{2\tau|X|}\mathbf1_{\{|X|>r\}}]
\le M r^m\sup_{y\ge1} y^m e^{2\tau r y-Sy^2}.
```

The logarithmic derivative is $m/y+2\tau r-2Sy$. By (5.6), it is negative for all $y\ge1$ for sufficiently large $n$. The supremum is therefore attained at one. The same argument with $m=4$ and no exponential weight proves

```math
EX^6e^{2\tau|X|}\le r^6e^{2\tau r}(1+Me^{-S}),\qquad
EX^4\le r^4(1+Me^{-S}).
\tag{5.11}
```

Use [LEM-06], (3.12), and $r^2/b\le S$. The left side of (5.9), divided by $b$, is at most

```math
\frac{S\sqrt{1+Me^{-S}}}{\sqrt n}
\left(1+\frac{2\sqrt S\ell}{3}e^{\sqrt S\ell}\right).
\tag{5.12}
```

Its logarithm is bounded above by $-N/2+O(\sqrt N\log N)$. Markov inequality at threshold $b/N$ gives (5.10). $\square$

#### 5.3. Controlling empirical overestimation

**[LEM-08] Uniform upper control of the empirical supremum.** There is a deterministic $e_{1,n}=O(b/\ell)=o(b)$ such that

```math
\widehat V_n\le v(P)+e_{1,n}
\tag{5.13}
```

on an event of failure probability $O(N^{-8})$, uniformly over the class.

*Proof.* On $\mathcal E_r$,

```math
|\partial_t\log A_n(t)|\le2r.
\tag{5.14}
```

Indeed, $A_n'(t)=P_n[X(e^{tX}-1)]$, and the elementary scalar inequality $|e^u-1|\le2(e^u-u)$ gives (5.14) after averaging. For $u\le0$, the inequality follows from $|e^u-1|\le1\le e^u-u$. For $u\ge0$, it is equivalent to $e^u+1-2u\ge0$, which follows from $e^u\ge1+u+u^2/2$.

Place a deterministic grid with spacing $\Delta$ on the magnitudes in $[\tau,T]$, for both signs, and include an endpoint beyond $T$ if necessary. Its number of points is

```math
G_n=O(T/\Delta)=O(N^3\ell).
```

At a grid point, (3.11) and Markov inequality yield

```math
P\{A_n(t_j)>e^{16\ell}M_P(t_j)\}\le N^{-16}.
```

The union failure probability is $O(N^{-12})$. On the complementary event, every grid value satisfies

```math
\widehat L_n(t_j)\le v(P)+32b/\ell.
\tag{5.15}
```

For a magnitude $u$ between grid points, choose the point of magnitude immediately below $u$, with the same sign. Its logarithm is nonnegative. Thus replacing its denominator by $u^2$ can only decrease its contribution, and (5.14) bounds the remaining increase by $4r\Delta/\tau^2=4b/(N^2\ell^2)$.

For $|t|>T$, the sample-support event implies $A_n(t)\le2e^{|t|r}$, hence

```math
\widehat L_n(t)\le\frac{2r}{|t|}+\frac{2\log2}{t^2}
\le\frac{2b}{\ell}+O\left(\frac{b}{N\ell^2}\right).
\tag{5.16}
```

Combine this estimate, the grid bound, and [LEM-07]. Since $v(P)\ge0$, the estimate for $|t|>T$ also gives an upper bound of the form in (5.13). The stated failure probability includes $\mathcal E_r^c$ and $\mathcal E_0^c$. $\square$

#### 5.4. A sharp floor for the unidentified tail

**[LEM-09] Population comparison.** On the intersection of the tail-band event from [LEM-04], $\mathcal E_r$, and $\mathcal E_0$,

```math
v(P)\le\max\{\widehat V_n,c_n\}+e_{2,n},
\qquad e_{2,n}=O(b/\ell^2+b/N)=o(b).
\tag{5.17}
```

*Proof.* Introduce $Y=\operatorname{clip}_r(X)$ only as an auxiliary population variable. The function $g_t$ vanishes at zero and increases away from zero on each of the two rays. Integration of the two inequalities in (4.2) against its nonnegative ray derivatives gives

```math
Pg_t(Y)\le(1+\eta)P_ng_t(\operatorname{clip}_r X)
+d\{g_t(r)+g_t(-r)\}.
\tag{5.18}
```

For example, the positive-ray term is $\int_0^r g_t'(x)P(X>x)\,dx$; the negative-ray term uses $-g_t'(-x)P(X<-x)$. Endpoint conventions at atoms do not affect these integrals. On $\mathcal E_r$, the empirical clipped term equals $P_ng_t(X)$.

Furthermore,

```math
0\le g_t(X)-g_t(Y)
\le e^{|t||X|}\mathbf1_{\{|X|>r\}}.
```

The last inequality follows from $g_t(x)\le e^{|t||x|}$, including negative $tx$. Using (5.7),

```math
E[e^{|t||X|}\mathbf1_{\{|X|>r\}}]
\le M\sup_{x>r}e^{|t|x-\Phi(x/K)}
\le M e^{t^2B(S)/4}.
\tag{5.19}
```

No smoothness of $\Phi$ is involved: the last inequality maximizes a quadratic over a larger domain.

The empirical tail error obeys

```math
d\{g_t(r)+g_t(-r)\}
\le e^{|t|r-D}
\le e^{t^2r^2/(4D)}=e^{t^2c_n/2}.
\tag{5.20}
```

Here the middle inequality is completion of the square. Since $D \lt S$ eventually, $B(S)/2\le c_n$. Combining (3.11), (5.18)-(5.20), and discarding a negative $-\eta$ term yields

```math
M_P(t)\le(1+\eta)A_n(t)+(1+M)e^{t^2c_n/2}.
\tag{5.21}
```

Therefore for $t\ne0$,

```math
L_P(t)\le\max\{\widehat L_n(t),c_n\}
+\frac{2\log(2+M+\eta)}{t^2}.
\tag{5.22}
```

The extra term is $O(b/\ell^2)$ for $|t|\ge\tau$. For smaller arguments use $\mathcal E_0$. Taking the supremum gives (5.17). No centered-MGF identity has been used for $Y$; the centered identity is used only for the original population in (3.11). $\square$

The maximum in (5.17) is essential. The unidentified tail can raise the proxy to an approximately $b/2$ floor; this result does not add $b/2$ to an arbitrary visible proxy.

#### 5.5. Midpoint decision and expected loss

**[LEM-10] Sharp expected-risk upper bound.** The estimator (5.4) satisfies

```math
\sup_{P\in\mathcal P_{\Phi,K,M}}
E_P|\widehat v_n-v(P)|\le(1/4+o(1))B(\log n).
\tag{5.23}
```

*Proof.* Combine the support, small-argument, grid, and tail-band events. Their total failure probability is $O(N^{-8})$, uniformly in $P$. On this event, [LEM-08] and [LEM-09] imply

```math
\widehat V_n-e_{1,n}\le v(P)
\le\max\{\widehat V_n,c_n\}+e_{2,n}.
```

Replacing $\widehat V_n$ by $\widetilde V_n$ preserves both bounds. For the upper bound, if clipping acts, $v(P)\le V_*=\widetilde V_n$ is already sufficient. The midpoint of $[\widetilde V_n,\max\{\widetilde V_n,c_n\}]$ has error at most

```math
\frac{c_n}{2}+\max\{e_{1,n},e_{2,n}\}=(1/4+o(1))b.
```

The outer projection can only improve absolute loss because $v(P)\in[0,V_*]$. On the exceptional event, its loss is at most $V_*$, and $V_*O(N^{-8})=o(b)$ by (3.2). This proves (5.23). $\square$

At the point mass $\delta_0$, $\widehat V_n=0$ exactly. For large $n$, the midpoint estimator equals $c_n/2\sim b/4$. Thus its optimal uniform risk deliberately includes a nonzero upward error at $\delta_0$. This feature is part of the minimax decision, not a confidence-bound guarantee.

### I.6. Matching lower bounds

**[LEM-11] Sparse laws and a common-event bound.** For any $u>0$ with $\epsilon=(M-1)/(e^u-1)<1$, define

```math
A=Ka(u),\qquad
Q_u=(1-\epsilon)\delta_0+\frac\epsilon2(\delta_A+\delta_{-A}).
\tag{6.1}
```

Then $Q_u\in\mathcal P_{\Phi,K,M}$, its envelope expectation is exactly $M$, and

```math
v(Q_u)\ge\frac{K^2a(u)^2}{2\log(2/\epsilon)}.
\tag{6.2}
```

For every estimator $T_n$,

```math
\max\{E_{\delta_0}|T_n|,
E_{Q_u}|T_n-v(Q_u)|\}
\ge\frac12(1-\epsilon)^n v(Q_u).
\tag{6.3}
```

*Proof.* Symmetry gives mean zero, and the envelope expectation is $1+\epsilon(e^u-1)=M$. Finite support gives a finite proxy. Put $d=\log(2/\epsilon)$ and $t=2d/A$. One term of the MGF gives $E_{Q_u}e^{tX}\ge(\epsilon/2)e^{2d}=e^d$, proving (6.2).

Under $\delta_0$, the sample is all zero. Under $Q_u$, this same sample has probability $q=(1-\epsilon)^n$. If $T_n$ takes value $z$ there, the two risks are bounded below by $|z|$ and $q|z-v(Q_u)|$. Their sum is at least $qv(Q_u)$, proving (6.3). For a randomized estimator, condition on the data and integrate the same triangle inequality with respect to its common output distribution at the zero sample. $\square$

**[LEM-12] Sharp lower bound and the infinite case.** If $B$ is finite, then

```math
\liminf_{n\to\infty}\frac{\mathcal R_n(\mathcal P_{\Phi,K,M})}{B(\log n)}\ge\frac14.
\tag{6.4}
```

If $B$ is infinite, the risk on finite-support laws is infinite at each fixed $n\ge1$.

*Proof.* In the finite case, use $S=N+10\log N$. Choose a finite $u_n\ge S$ with

```math
K^2a(u_n)^2/u_n\ge(1-1/N)B(S).
\tag{6.5}
```

The supremum need not be attained; its finiteness guarantees such an approximate choice. For $\epsilon_n=(M-1)/(e^{u_n}-1)$,

```math
n\epsilon_n=O_M(N^{-10}),\qquad
\log(2/\epsilon_n)=u_n+\log\frac2{M-1}+\log(1-e^{-u_n})
=u_n+O_M(1),
\tag{6.6}
```

uniformly over $u_n\ge S$. Thus $v(Q_{u_n})\ge(1-o(1))B(S)/2$, while the common-sample probability tends to one. Equation (6.3) gives a lower bound $(1-o(1))B(S)/4$. By (3.1), $B(S)/B(N)\to1$.

If $B$ is infinite, continuity of $a(u)^2/u$ on compact positive intervals gives a sequence $u_j\to\infty$ with $K^2a(u_j)^2/u_j\to\infty$. Use the same laws with these $u_j$ and keep $n$ fixed. Their all-zero sample probabilities tend to one, whereas (6.2) tends to infinity. Equation (6.3) proves infinite worst risk for every estimator. All laws used have finite support. $\square$

*Proof of [THM-01] and [COR-01].* Combine [LEM-10] and [LEM-12]. Finiteness of the target is [LEM-02]; the consistency criterion and limiting nonzero risk follow from [LEM-01]. $\square$

The value $q_*=\liminf\Phi(x)/x^2$ describes the limiting risk and its consistency classification. The finite-sample asymptotic normalization remains $B(\log n)$; the single number $q_*$ does not specify a vanishing rate or its oscillations.

### I.7. Fixed support and the distinction from growing support

*Proof of [THM-02].* This case requires its own substitutions; it is not a literal finite-$\Phi$ limit. Put

```math
r=K,\qquad b=K^2/N,\qquad
\tau=\ell/\sqrt b,\qquad T=r\ell/b,
\tag{7.1}
```

and retain $\eta,\beta,d,D,\Delta$ from (5.2)-(5.3), with this $r$. Set $c_n=K^2/(2D)$, so $c_n/b\to1/2$. The sample-support event holds surely, and all population exterior-tail terms are zero. The deterministic argument in [LEM-03], applied under expectation, gives $v(P)\le2K^2$; hence $V_*=2K^2$ is sufficient.

For small arguments, $EX^4\le K^4$ and $EX^6e^{2\tau|X|}\le K^6e^{2\tau K}$. Since $\tau K=\sqrt N\ell$, [LEM-06] again gives an error divided by $b$ of order $\exp\{-N/2+O(\sqrt N\log N)\}$. The grid has $O(N^3\ell)$ points and the large-argument estimate (5.16) remains valid. The tail-band integration (5.18) gives (5.21) with its exterior-tail term omitted, so the same floor $c_n$ is valid.

Here $Nb=K^2$, which does **not** tend to infinity. The required exceptional-risk estimate still holds directly: $N^{-8}=o(K^2/N)=o(b)$. Thus the midpoint argument proves the upper constant $1/4$.

For the lower bound, take

```math
Q_n=(1-\epsilon_n)\delta_0+
\frac{\epsilon_n}{2}(\delta_K+\delta_{-K}),\qquad
\epsilon_n=1/(nN^2).
```

The common-event argument and a single MGF evaluation yield

```math
\mathcal R_n(\mathcal B_K)
\ge\frac12(1-\epsilon_n)^n
\frac{K^2}{2\log(2/\epsilon_n)}
=(1/4-o(1))K^2/N.
\tag{7.2}
```

To justify the additional constraint $v(P)\le\Xi$, write $L=\log(1/\epsilon)$ for the sparse law at $\pm K$. If $|t|K\le L/2$, the remainder estimate gives $L_Q(t)\le\epsilon K^2e^{|t|K}\le K^2\sqrt\epsilon$. If $|t|K\ge L/2$, bounded support gives $L_Q(t)\le2K/|t|\le4K^2/L$. Therefore $v(Q)\to0$ as $\epsilon\to0$, so the lower-bound laws eventually satisfy every fixed $\Xi>0$. $\square$

The second remark after Theorem 1 of [1, v2] asserts an inverse-square-root-log order even after restriction to fixed support $[-1,1]$. Theorem [THM-02] contradicts that particular fixed-support assertion. The relevant construction in [1, Appendix A.1] permits atoms at $\pm a_n$ outside $[-1,1]$; a lower bound using growing support does not establish the stated fixed-support lower bound. This comparison does not invalidate the main theorem of [1] on its larger classes.

### I.8. An estimator independent of the envelope and its exact adaptation cost

#### 8.1. The universal estimator

**[THM-03] Exact risk of the positive-remainder estimator.** The estimator $\widehat V_n$ in (3.9), without any envelope-dependent clipping or midpoint correction, satisfies, for each fixed finite-$B$ envelope class,

```math
\lim_{n\to\infty}
\frac{\sup_{P\in\mathcal P_{\Phi,K,M}}
E_P|\widehat V_n-v(P)|}{B(\log n)}=\frac12.
\tag{8.1}
```

It uses neither $\Phi$, $K$, nor $M$, but it uses the known mean zero. The same result holds on $\mathcal B_K$ with denominator $K^2/\log n$.

*Proof.* On the good event used in [LEM-10], (5.13) and (5.17) give absolute error at most $(1/2+o(1))b$. To remove the envelope-dependent projection in expected loss, write $R_n^{\max}=\max_i|X_i|$. From (3.5),

```math
P((R_n^{\max})^2>y)\le\min\{1,nCe^{-y/H}\}.
```

Integrating this tail at $y_0=H\log(nC)$ gives the explicit bound

```math
E(R_n^{\max})^4
\le H^2\{(N+\log C)^2+2(N+\log C)+2\}.
\tag{8.2}
```

By (3.10), Cauchy-Schwarz, and the $O(N^{-8})$ exceptional probability,

```math
E[(\widehat V_n+v(P))\mathbf1_{\mathrm{bad}}]
\le2\{E(R_n^{\max})^4\}^{1/2}P(\mathrm{bad})^{1/2}
+V_*P(\mathrm{bad})
=O(N^{-3})=o(b).
\tag{8.3}
```

This proves the upper bound. For the sparse law from [LEM-12], the all-zero sample has probability tending to one, $\widehat V_n$ equals zero there, and its target is at least $(1/2-o(1))b$. This gives the matching lower bound directly, without the factor $1/2$ in the general two-estimator-risk argument. For fixed support, use Section 7 and $R_n^{\max}\le K$; the same upper and lower arguments apply. $\square$

#### 8.2. A risk tradeoff at the zero distribution

**[PROP-01] The zero-distribution tradeoff.** Let $T_n$ be any sequence of estimators, possibly randomized, and set $r_{0,n}=E_{\delta_0}|T_n|$. On any fixed finite-$B$ envelope class, if

```math
r_{0,n}/B(\log n)\longrightarrow c\in[0,\infty),
```

then

```math
\liminf_n
\frac{\sup_{P\in\mathcal P_{\Phi,K,M}}E_P|T_n-v(P)|}
{B(\log n)}
\ge\max\{c,1/2-c\}.
\tag{8.4}
```

In particular, $r_{0,n}=o(B(\log n))$ forces the lower constant $1/2$.

*Proof.* Membership of $\delta_0$ gives the lower bound $r_{0,n}$. Let $Q_n$ be the sparse law used for (6.4), with all-zero sample probability $q_n\to1$. The output distribution of a randomized estimator conditional on this sample is the same under both laws. Therefore

```math
E_{Q_n}|T_n-v(Q_n)|
\ge q_n E_{\delta_0}|T_n-v(Q_n)|
\ge q_n\{v(Q_n)-r_{0,n}\}.
\tag{8.5}
```

Divide by $B(\log n)$, use $v(Q_n)\ge(1/2-o(1))B(\log n)$, and combine the two bounds. $\square$

**[THM-04] Sharp factor-two price of adaptation to a faster class.** Consider two fixed finite-$B$ envelope classes, with profiles $b_{j,n}=B_j(\log n)$, such that $b_{2,n}=o(b_{1,n})$. If an estimator satisfies

```math
\sup_{P\in\mathcal P_2}E_P|T_n-v(P)|=O(b_{2,n}),
\tag{8.6}
```

then

```math
\liminf_n
\frac{\sup_{P\in\mathcal P_1}E_P|T_n-v(P)|}{b_{1,n}}\ge\frac12.
\tag{8.7}
```

The estimator $\widehat V_n$ attains the constant $1/2$ on both classes. Thus, relative to the known-envelope constant $1/4$, the smallest possible leading risk factor on the harder class, among estimators attaining the faster rate on the easier class, is two.

*Proof.* Both classes contain $\delta_0$, so (8.6) implies $r_{0,n}=O(b_{2,n})=o(b_{1,n})$. Apply [PROP-01]. Attainment is [THM-03]. $\square$

Nesting is not needed for this implication; [EX-03] supplies a nested example. The tradeoff also explains the midpoint estimator's error at $\delta_0$: the minimum of $\max\{c,1/2-c\}$ is $1/4$, attained at $c=1/4$.

**[COR-02] A bounded subclass already forces the adaptation cost.** Fix any finite-$B$ envelope class and set $k_0=K\Phi^{-1}(\log M)>0$. Then $\mathcal B_{k_0}\subseteq\mathcal P_{\Phi,K,M}$ and

```math
\frac{k_0^2/\log n}{B(\log n)}\longrightarrow0.
\tag{8.8}
```

Consequently, any estimator with worst expected absolute risk $O(1/\log n)$ on this fixed bounded subclass has normalized worst risk at least $1/2$ on the larger envelope class. The single estimator $\widehat V_n$ attains both the bounded-subclass rate and the exact larger-class constant $1/2$.

*Proof.* For $|X|\le k_0$, $e^{\Phi(|X|/K)}\le M$, proving the inclusion. From (3.2),

```math
\frac{k_0^2/N}{B(N)}
\le\frac{\Phi^{-1}(\log M)^2}{\Phi^{-1}(N)^2}\longrightarrow0.
```

The subclass contains $\delta_0$, so its assumed risk rate implies $r_{0,n}=o(B(N))$. Apply [PROP-01]; attainment follows from both parts of [THM-03]. $\square$

These are point-estimation statements. Neither estimator is asserted to be an honest upper confidence bound, and no validity of plug-in $p$-values is inferred.

### I.9. Examples and irregular envelopes

**[EX-01] Power envelopes.** For $\Phi(x)=x^\alpha$, $\alpha>2$, the ratio $a(u)^2/u=u^{2/\alpha-1}$ is decreasing. Hence

```math
\mathcal R_n\sim\frac{K^2}{4}(\log n)^{2/\alpha-1}.
\tag{9.1}
```

For $\alpha=2$, $B(s)=K^2$ and $\mathcal R_n\to K^2/4$. For $0<\alpha<2$, $B(s)=\infty$ and the fixed-sample risk is infinite on the finite-support subfamily. The critical case is a nonvanishing limit, not a consistency rate.

**[EX-02] An oscillatory inverse envelope.** Define $a(0)=0$ and, for $u>0$,

```math
a(u)^2=u^{4/5}\left(1+\frac12\sin\log u\right).
\tag{9.2}
```

This function is continuous, strictly increasing from zero to infinity. Indeed, the derivative of its square is

```math
u^{-1/5}
\left\{\frac45+\frac25\sin\log u+\frac12\cos\log u\right\},
```

whose bracket is at least $4/5-\sqrt{41}/10>0$. Let $\Phi=a^{-1}$. The derivative of $a(u)^2/u$ has the sign of $-1/5-(1/10)\sin\log u+(1/2)\cos\log u$, which takes both signs arbitrarily far out. Consequently $\Phi(x)/x^2=1/[a(\Phi(x))^2/\Phi(x)]$ is not eventually nondecreasing. For every $s>0$,

```math
B(s)=K^2s^{-1/5}H(\log s),\qquad
H(\theta)=\sup_{z\ge0}e^{-z/5}
\left(1+\frac12\sin(\theta+z)\right).
\tag{9.3}
```

The function $H$ is periodic, and $1/2\le H\le3/2$. Consequently $B(s)\to0$ and this class is uniformly estimable. At phases $\theta=3\pi/2\pmod{2\pi}$, the local ratio factor equals $1/2$, but choosing $z=\pi$ gives

```math
H(\theta)\ge\frac32e^{-\pi/5}>\frac12.
\tag{9.4}
```

At phases $\theta=\pi/2\pmod{2\pi}$, $H(\theta)=3/2$: the value at $z=0$ already equals the upper bound. Write $q(s)=K^2a(s)^2/s$. Therefore $B(s)/q(s)=1$ at this phase, whereas at the phase in (9.4) it is at least $3e^{-\pi/5}>1$. Rounding $e^{s_j}$ to an integer, with $\log s_j$ on either phase sequence, changes $\log\log n$ by a quantity tending to zero. The continuity and shift comparison in [LEM-01], together with continuity of the displayed $q$, make this rounding harmless. Hence $\mathcal R_n/q(\log n)$ tends to $1/4$ along the first subsequence, while its liminf on the second is at least $(3/4)e^{-\pi/5}>1/4$.

The pointwise inverse-envelope ratio therefore cannot replace the tail supremum for an exact limiting constant. In this example it still gives the same order, since both $H$ and $1+\tfrac12\sin(\log s)$ lie between $1/2$ and $3/2$.

**[EX-03] A nested pair with separated rates.** With the same $K,M$, take $\Phi_1(x)=x^4$ and $\Phi_2(x)=x^4+x^6$. Since $\Phi_2\ge\Phi_1$, $\mathcal P_2\subseteq\mathcal P_1$. For the first class, $B_1(s)=K^2s^{-1/2}$. For the second, $\Phi_2(x)/x^2=x^2+x^4$ is strictly increasing; its inverse ratio is therefore decreasing and its tail supremum equals the value at $s$. Since $s=x^4+x^6\sim x^6$ as $x\to\infty$, this yields $B_2(s)\sim K^2s^{-2/3}$. In particular, $B_2(s)/B_1(s)\sim s^{-1/6}\to0$, providing a nondegenerate instance of [THM-04].

### I.10. Scope, limitations, and interpretation

The assumption $M>1$ is necessary. If $M=1$, strict increase of $\Phi$ implies $X=0$ almost surely and the risk is zero. If $M<1$, the class is empty. The stated asymptotics keep $M$, $K$, and the entire envelope fixed; they do not address a sequence of changing classes.

Known mean zero is part of the experiment. Formula (3.11) uses it exactly. Unknown mean under a centered-tail envelope would require an additional centering argument. Unknown mean under a raw support constraint $[-K,K]$ is another experiment; the centered support need not remain $[-K,K]$. None of the constants here is silently transferred to those models.

The loss is expected absolute error of $v$. Estimation of $\sqrt v$, relative error near zero, high-confidence loss, and sequential confidence guarantees are separate problems. The midpoint construction optimizes a worst-case point-estimation criterion. It is not a justified replacement for a conservative concentration parameter in another inferential procedure.

The statistical estimators are measurable. The data-dependent interval in [LEM-03] reduces the empirical supremum to a finite one-dimensional optimization. This does not establish a numerical complexity guarantee, and computing the envelope tail supremum $B$ for an arbitrary supplied continuous function requires a separate representation and analysis. The envelope-independent estimator does not need to evaluate $B$.

The lower argument uses a classical common-event testing mechanism. The contribution established by the proofs is the matching sharp upper analysis, the resulting exact envelope-dependent characterization, and its exact adaptation tradeoff. The present statements neither establish global priority over all possible literature nor resolve the general conjecture in [1].


## Part II. Sharp robust estimation and contamination adaptation

Local section references in this part refer to Part II. Equations R1-R35 concern robustness and the modulus; AD1-AD17 concern unknown-contamination adaptation. Lemmas called original or foundational below are proved in Part I.

### II.1. Model, normalization, and claims

Fix the original envelope $(\Phi,K,M)$: $K>0$, $M>1$, and a continuous, strictly increasing, unbounded $\Phi:[0,\infty)\to [0,\infty)$ with $\Phi(0)=0$. Write $a=\Phi^{-1}$ and

```math
B(s)=K^2\sup_{u\ge s}\frac{a(u)^2}{u}.
```

Assume first $B(s_0)<\infty$. Part I proves that $B$ is positive, nonincreasing, and

```math
\frac{s}{s+h}B(s)\le B(s+h)\le B(s),\qquad sB(s)\longrightarrow\infty.
\tag{R1}
```

Let $C$ be the location family of all real laws $P$ with finite mean $\mu_P$ and

```math
E_P\exp\{\Phi(|X-\mu_P|/K)\}\le M.
```

The parameter is

```math
v(P)=\sup_{t\ne0}\frac{2}{t^2}\log E_Pe^{t(X-\mu_P)}.
```

Neither $\mu_P$ nor a bound on its magnitude is known. The observations are iid from

```math
H=(1-\epsilon_n)P+\epsilon_n Q,
\tag{R2}
```

where $Q$ is an arbitrary Borel probability measure; it need not have any moments. The proportion $\epsilon_n$ is known, is nonnegative, and tends to zero. Include $\epsilon_n=0$. Define

```math
\rho_n=\epsilon_n+n^{-1},\quad s_n=\log(1/\rho_n),\quad b_n=B(s_n).
\tag{R3}
```

For all sufficiently large $n$, $s_n>0$. The theorem is

```math
\inf_{T_n}\sup_{P\in C}\sup_Q
 E_{[(1-\epsilon_n)P+\epsilon_nQ]^{\otimes n}}
 |T_n-v(P)|
 =\left(\frac14+o(1)\right)b_n.
\tag{R4}
```

The little-oh is uniform in $P,Q$ along every prescribed sequence $\epsilon_n \to  0$; the envelope remains fixed. It is not a claim of uniformity over envelopes or over arbitrary finite values of $\epsilon$.

The same limit holds when the mean is known. For the centered fixed-support class $P(|X-\mu_P|\le K)=1$, replace $b_n$ by $K^2/s_n$. Thus the unknown location costs no first-order efficiency under the stated models.

The target and loss are the variance proxy and expected absolute error. Squared, relative, and square-root losses are not identified by this theorem.

### II.2. A two-sided relative empirical-tail event

Let $H_n$ be the empirical law of arbitrary iid real observations from $H$. For $0<\eta\le 1$, $0<\beta<1$, set

```math
d_0=\frac{16\log(8(n+1)/\beta)}{n\eta},\qquad d=d_0+2/n.
\tag{R5}
```

With probability at least $1-\beta$, simultaneously for every real threshold $x$ and for each of the tails $(x,\infty)$ and $(-\infty,x)$,

```math
H(A)\le(1+\eta)H_n(A)+d,
\qquad
H_n(A)\le(1+\eta)H(A)+d.
\tag{R6}
```

This statement includes atoms and both endpoint limits.

Here is a self-contained extension of Part I Lemma 04. If $Y\sim \operatorname{Bin}(n,p)$, exponential Markov inequality gives

```math
\Pr\{Y/n\le p-r\}\le e^{-nr^2/(2p)}\quad(0 \lt r \lt p),
```

and

```math
\Pr\{Y/n\ge p+r\}\le e^{-nr^2/[2(p+r)]}\quad(r>0).
```

For the latter, optimizing the exponential moment yields exponent
$-n[(p+r)\log(1+r/p)-r]$; its magnitude is at least $nr^2/[2(p+r)]$, by integrating $\log(1+z)\ge z/(1+z)$. The case $p=0$ is immediate. For upper relative failure put $r=\eta p+d_0$; the inequality

```math
(\eta p+d_0)^2\ge\eta d_0\{(1+\eta)p+d_0\}
```

follows by expansion when $\eta\le 1$. For lower relative failure use
$r=(\eta p+d_0)/(1+\eta)$ and the arithmetic-geometric mean inequality, as in Part I Lemma 04. Both failures have probability at most $\exp(-n \eta d_0/2)$ whenever the event is nonvacuous. Represent the sample by iid uniforms and take a union bound over $p=k/n$, the two directions, and the two inequalities. Extend from the grid by monotonicity; rounding adds at most $2/n$. Taking one-sided endpoint limits gives (R6) for all strict tails of every distribution, including atomic ones. The generous constant 16 makes the union bound at most $\beta$.

### II.3. Global rank trimming, and a location estimate without contamination moments

Work on the event (R6), and abbreviate $\epsilon=\epsilon_n$. Define

```math
k=(1+\eta)\epsilon+d,\qquad
c=(1+\eta)(1-\epsilon).
\tag{R7}
```

For large $n$, $0\le k<1/2$. Let $\nu$ be the empirical measure with exactly mass $k$ removed from each extreme rank, splitting an atom fractionally if needed. Equivalently,

```math
\int f\,d\nu=\int_k^{1-k} f(F_n^{-1}(u))\,du.
```

Then $\nu(\mathbb R)=1-2k$. Its tails satisfy, for every half-line $A$,

```math
\nu(A)\le[H_n(A)-k]_+,
\qquad H_n(A)\le\nu(A)+2k.
\tag{R8}
```

Set $\xi=\nu/c$, a subprobability measure. Indeed,

```math
1-2k\le1-2\epsilon\le(1+\eta)(1-\epsilon)=c.
```

Since $H(A)\le (1-\epsilon)P(A)+\epsilon$, (R6)-(R8) give

```math
\xi(A)\le P(A),
\qquad P(A)\le\alpha\xi(A)+\delta,
\tag{R9}
```

where

```math
\alpha=(1+\eta)^2,\qquad
\delta=\frac{2(1+\eta)k+d}{1-\epsilon}.
\tag{R10}
```

The first inequality is asserted only for the positive and negative outward half-lines relative to the true mean $\mu$, namely $A=(\mu+x,\infty)$ and $A=(-\infty,\mu-x)$ with $x\ge 0$. In fact the algebra gives it for any half-line; no impossible assertion about arbitrary Borel sets is made. The two outward tails can be integrated separately. $\xi$ itself need not have mean $\mu$.

Define the translation-equivariant trimmed mean

```math
\widehat\mu=\frac{\int x\,d\nu(x)}{1-2k}.
\tag{R11}
```

For $Z=X-\mu$, let $P_+(x)=P(Z>x)$ and $P_-(x)=P(Z<-x)$, and use the same notation for the shifted subprobability $\xi$. From (R9), for either sign,

```math
0\le P_\pm(x)-\xi_\pm(x)
\le(\alpha-1)P_\pm(x)+\delta.
```

Split the integrals at an arbitrary $r>0$, using the simpler bound $P_\pm$ beyond $r$. Since $E_PZ=0$, the signed-tail formula for first moments yields

```math
|\widehat\mu-\mu|
\le\frac{c}{1-2k}
\left\{(\alpha-1)E_P|Z|+2\delta r+
\int_r^\infty P(|Z|>x)\,dx\right\}.
\tag{R12}
```

The first tail domination in (R9) ensures that the needed $\xi$ integrals are finite. This is why no moment or support assumption on $Q$ is needed. The inequality is a statement on the high-probability event, not on arbitrary contaminated samples.

### II.4. Positive remainders and stability under an estimated center

Let $g_t(z)=e^{tz}-1-tz$, as in the original paper. For any proposed center $m$, set

```math
A_m(t)=1+\int g_t(\operatorname{clip}_r(x-m))\,d\xi(x),
```

```math
V_m=\sup_{t\ne0}\frac{2\log A_m(t)}{t^2},
\tag{R13}
```

with the second-moment continuation at zero. Missing subprobability mass is understood as an atom at zero **after** subtracting the center and clipping. Thus the additive constant is exactly 1. No centered-MGF identity is assumed for $\xi$.

The function in (R13) is continuous in $t$, tends to zero at both infinities, and has finite measurable supremum over rational $t$; the original finite-support proof applies to these nonnegative weights. In particular $0\le V_m\le 2r^2$.

At the true center, the outward tail dominance $\xi_\pm\le P_\pm$ and monotonicity of $g_t$ away from zero imply

```math
A_\mu(t)\le E_Pe^{tZ},\qquad V_\mu\le v(P).
\tag{R14}
```

Clipping only decreases the outward tails. There is also a deterministic center-stability inequality

```math
|V_m-V_{m'}|\le4r|m-m'|.
\tag{R15}
```

To prove it, note first that, for all real $u$,

```math
|e^u-1|\le2|u|(e^u-u).
\tag{R16}
```

For $u$ between 0 and 1 use $(e^u-1)/u\le e-1<2$ and $e^u-u\ge 1$; for $u\ge 1$ use $e^u-1\le 2(e^u-u)$; for $u\le 0$, use $1-e^u\le \min(1,|u|)$ and $e^u-u\ge 1$. Differentiating with respect to $m$ away from the finitely many clipping points gives

```math
|\partial_m\{2\log A_m(t)/t^2\}|
\le4r\,
\frac{\int(e^{ty}-ty)\,d\xi}{1-\xi(\mathbb R)+\int(e^{ty}-ty)\,d\xi}
\le4r.
```

Here $y=\operatorname{clip}_r(x-m)$, and inactive clipping terms only reduce the numerator. Integrate this almost-everywhere derivative along the center interval; the functions are locally absolutely continuous. The limit at $t=0$ has the same bound. Take suprema to prove (R15).

### II.5. Scales and the sharp unidentified-tail floor

Write $s=s_n$, $b=B(s)$, and $\ell=\log s$. Choose

```math
\eta=s^{-2},\quad\beta=s^{-8},\quad
S=s+10\log s,\quad r^2=S B(S),\quad
\tau=\frac{\ell}{\sqrt b}.
\tag{R17}
```

Let $d,k,c,\delta$ be given by (R5), (R7), (R10), and let

```math
D=\log(1/\delta),\qquad q_n=\frac{r^2}{2D}.
\tag{R18}
```

The original envelope inequalities give

```math
sb\le r^2\le Sb,\qquad
\Phi(x/K)\ge Sx^2/r^2\quad(x\ge r),
\qquad \tau r\le\sqrt S\log s=o(S).
\tag{R19}
```

Further,

```math
\rho_n\le\delta\le C\rho_n s^3,
\quad D=s+O(\log s),\quad
q_n/b\longrightarrow1/2.
\tag{R20}
```

To check the bound uniformly along all joint speeds, note $n\ge \exp(s)$, and that $(\log n)/n\le s \exp(-s)$ for large $s$. Therefore
$d\le C \exp(-s)s^3$; $\epsilon\le \exp(-s)$ and $1-\epsilon\to 1$. The lower bound follows directly from (R10), $k\ge \epsilon$, and $d\ge 2/n$. In particular $D\le s \lt S$ eventually.

Let $V_*$ be the fixed uniform bound from Part I Lemma 02 for centered $P$. Equations (R12) and (R19), together with the Gaussian envelope bound beyond $r$, show

```math
4r|\widehat\mu-\mu|=o(b)
\tag{R21}
```

uniformly on (R6). Explicitly, the three terms after multiplying (R12) by $r$ are bounded by a constant times

```math
\eta r E|Z|,\qquad \delta r^2,
\qquad M B(S)e^{-S}.
```

The first divided by $b$ tends to zero because $sb\to \infty$; the second is $O(\delta S)b=o(b)$; the third is $o(b)$. The ratio $c/(1-2k)$ tends to one. Uniform boundedness of $E|Z|$ follows from the original finite exponential-square moment bound.

At the true center, integrating the second inequality in (R9) along the clipped positive and negative rays gives

```math
P g_t(\operatorname{clip}_r Z)
\le\alpha\int g_t(\operatorname{clip}_r(x-\mu))\,d\xi(x)
+\delta\{g_t(r)+g_t(-r)\}.
\tag{R22}
```

The part beyond $r$ satisfies

```math
E[g_t(Z)-g_t(\operatorname{clip}_rZ)]
\le M e^{t^2B(S)/4}.
\tag{R23}
```

Also

```math
\delta\{g_t(r)+g_t(-r)\}
\le e^{|t|r-D}\le e^{t^2q_n/2}.
\tag{R24}
```

Since $B(S)/2\le q_n$, (R22)-(R24) imply for $|t|\ge \tau$

```math
L_P(t)\le\max\{V_\mu,q_n\}
+\frac{2\log(\alpha+1+M)}{\tau^2}.
\tag{R25}
```

For $|t|\le \tau$, retain the small-$t$ form of the remainder. Taylor's integral identity gives

```math
\frac{2}{t^2}\delta\{g_t(r)+g_t(-r)\}
\le2\delta r^2e^{\tau r},
```

```math
\frac{2}{t^2}E[g_t(Z)-g_t(\operatorname{clip}_rZ)]
\le E[Z^2e^{\tau|Z|}1_{|Z|>r}]
\le M r^2e^{\tau r-S}.
\tag{R26}
```

The last inequality follows by maximizing $y^2 \exp(\tau r y-Sy^2)$ over $y\ge 1$; its logarithmic derivative is negative for large $n$. Limits at $t=0$ are included.

There is no hidden exponentially large $\eta$ error: for $\alpha\ge 1$ and $z\ge 0$, Bernoulli's convexity inequality says $1+\alpha z\le (1+z)^\alpha$. Hence (R22) implies

```math
L_P(t)\le\alpha L_{\xi,\mu}(t)
+r^2e^{\tau r}(2\delta+Me^{-S})
\le V_\mu+(\alpha-1)V_*+o(b).
\tag{R27}
```

Here (R14) was used, and the last remainder divided by $b$ is
$\exp(-s+O(\sqrt{s}\log s))$. Equations (R25)-(R27) yield

```math
V_\mu\le v(P)\le\max\{V_\mu,q_n\}+e_n,
\qquad e_n=o(b),
\tag{R28}
```

uniformly in the original and contamination laws. Combining (R15), (R21), and (R28) gives the same interval with $V_{\widehat\mu}$ and an additional $o(b)$ on each side.

### II.6. The estimator and its risk

Let

```math
W_n=\min\{V_*,V_{\widehat\mu}\},\qquad
T_n=\Pi_{[0,V_*]}
\frac{W_n+\max\{W_n,q_n\}}2.
\tag{R29}
```

For the finitely many $n$ for which the scales are invalid, use $T_n=0$. All weights, quantiles, clipping operations and rational suprema are measurable; contamination values remain finite real observations, even when $Q$ has no moments. At $\epsilon=0$ this is a well-defined location-invariant clean estimator.

On (R6), (R28) and center stability show

```math
|T_n-v(P)|\le q_n/2+o(b)=(1/4+o(1))b.
```

On its complement the projected loss is at most $V_*$. Since $\beta=s^{-8}$ and $sb\to \infty$, $\beta V_*=o(b)$. This proves the upper bound in (R4). No empirical-total-variation approximation has been used; a conventional additive $n^{-1/2}$ CDF band would lose the sharp logarithmic sample scale.

For a fixed support radius $K$ about the unknown mean, take $r=K$, $b=K^2/s$, keep all other scales, and omit the external-tail terms. Then $q_n/b\to 1/2$, $r|\widehat\mu-\mu|=O(\eta)+O(\delta)=o(b)$, and the same proof applies.

### II.7. Sharp lower bound and phase consequences

Both lower bounds use only the known-mean-zero subclass. The original clean lower bound remains valid because choosing $Q=P$ makes the observed law equal to $P$:

```math
R_{n,\epsilon_n}\ge(1/4-o(1))B(\log n).
\tag{R30}
```

For $\epsilon>0$, two Huber neighborhoods at proportion $\epsilon$ intersect exactly when

```math
\operatorname{TV}(P_0,P_1)\le\epsilon/(1-\epsilon).
\tag{R31}
```

For completeness, write their common dominating density as $(1-\epsilon)\max(p_0,p_1)$ plus arbitrary remaining mass. Its integral is $(1-\epsilon)(1+\operatorname{TV})$, which is at most one exactly under (R31). This proves sufficiency; necessity follows because a common observed measure must dominate both clean measures multiplied by $1-\epsilon$.

Take $P_0=\delta_0$ and the symmetric sparse laws from Part I Lemma 11,

```math
P_u=(1-p_u)\delta_0+\frac{p_u}{2}(\delta_{Ka(u)}+\delta_{-Ka(u)}),
\quad p_u=\frac{M-1}{e^u-1}.
```

Set $L=\log(1/\epsilon)$, choose $u\ge L+10\log L$ close to the tail supremum defining $B(L+10\log L)$, and use the original proxy evaluation. Then $p_u\le \epsilon/(1-\epsilon)$ eventually and

```math
v(P_u)\ge(1-o(1))B(L)/2.
```

Under a common observed law, the triangle inequality gives maximum expected error at least $v(P_u)/2$, for every sample size and also for randomized estimators. Consequently

```math
R_{n,\epsilon_n}\ge(1/4-o(1))B(\log(1/\epsilon_n)).
\tag{R32}
```

When $\epsilon_n=0$, simply omit (R32). The maximum of the profiles in (R30) and (R32) equals $B(\min(\log n,\log(1/\epsilon_n)))$. Its argument differs from $s_n=\log(1/(\epsilon_n+1/n))$ by at most $\log 2$; (R1) makes their ratio tend to one. This proves (R4), including sequences with zero terms or alternating dominance regimes.

For fixed support, choose the three-point law on $\{-K,0,K\}$ with sufficiently small mass and repeat the same argument to obtain $K^2/(4s_n)$.

If $B$ is infinite, the original clean finite-support lower bound already gives infinite minimax risk at every fixed sample size, even with contamination absent. If $B$ is finite but has a positive limit, the robust risk has the same nonzero limiting floor. With contamination tending to zero, uniform consistency remains equivalent to $\Phi(x)/x^2 \to  \infty$.

For $\Phi(x)=x^p$, $p>2$,

```math
R_{n,\epsilon_n}\sim\frac{K^2}{4}
\left[\log\frac1{\epsilon_n+1/n}\right]^{2/p-1}.
```

For $\epsilon_n=n^{-\gamma}$, $0<\gamma<1$, the ratio to the clean minimax risk tends to $\gamma^{-(1-2/p)}$; for centered fixed support it tends to $\gamma^{-1}$. These are direct consequences, not separately counted theorems. A fixed positive contamination level generally prevents consistency; no exact finite-epsilon constant is claimed here.

### II.8. Exact total-variation modulus for the known-center class

Let $C_0$ be the original known-mean-zero envelope class and

```math
\omega(h)=\sup\{|v(P)-v(Q)|:P,Q\in C_0,
\operatorname{TV}(P,Q)\le h\}.
```

Then, as $h \downarrow 0$,

```math
\omega(h)=\left(\frac12+o(1)\right)B(\log(1/h)).
\tag{R33}
```

The sparse law and the point mass prove the lower bound as in Section 7. For the upper bound, use $s=\log(1/h)$, $b=B(s)$, $S=s+10\log s$, $r^2=SB(S)$, $\tau=\log(s)/\sqrt{b}$. The tail inequalities $P_\pm\le Q_\pm+h$ replace (R9), with no multiplicative factor. Integrating them up to $r$, and adding the envelope tail of $P$, gives

```math
M_P(t)\le M_Q(t)+e^{t^2r^2/(4s)}+Me^{t^2B(S)/4}.
```

For $|t|\ge \tau$, this yields

```math
L_P(t)\le\max\{v(Q),r^2/(2s)\}+O(b/(\log s)^2).
```

For smaller $t$, the remainder bound (R26), with $\delta=h$, gives $L_P(t)\le v(Q)+o(b)$. Thus

```math
v(P)\le\max\{v(Q),(1/2+o(1))b\}+o(b),
\tag{R34}
```

uniformly over the pair. Reverse $P,Q$; since both proxies are nonnegative, their difference is at most $(1/2+o(1))b$. This proves (R33). Equation (R34) is stronger than an additive modulus inequality: contamination cannot asymptotically add the full rare-tail floor on top of an already larger visible proxy.

For centered fixed support, $\omega(h)\sim K^2/[2\log(1/h)]$. The present derivation of (R33) is for the known-center class. The unknown-location robust theorem in Sections 1-7 does not require an unproved unknown-location modulus extension.

### II.9. Relation to existing robust theory and boundaries

The general use of total-variation moduli and common Huber neighborhoods is established prior work, not an innovation asserted here. Chen, Gao and Ren's general decision theory appeared in *Electronic Journal of Statistics* 10 (2016), 3752-3774, DOI 10.1214/16-EJS1216; their *Annals of Statistics* 46 (2018), 1932-1960 paper on robust covariance and scatter estimation, DOI 10.1214/17-AOS1607, contains the general modulus lower-bound formulation used for comparison here. The source metadata are independently visible on the author's university page and the IMS issue contents.

The additional mathematical work above is the matching sharp upper construction for this functional, arbitrary fixed exponential envelopes, all joint vanishing contamination/sample regimes, and unknown location. The global rank trimming, positive remainders, exact location stability and multiplicative tail comparison all require verification; they cannot be replaced by merely substituting a sparse law into a general lower-bound theorem.

This part makes no claim to an efficient numerical method for optimizing an arbitrary given continuous envelope, no adversarial fixed-fraction replacement theorem, no vector-directional extension, and no formal verification.

### II.10. The exact price of not knowing the contamination proportion

The following theorem concerns **known mean zero and a known envelope**. It does not assert that the estimator can simultaneously avoid knowing the mean, the envelope, and the contamination level.

Let $N=\log n$, $b_n^0=B(N)$, and retain $b_n^\epsilon=B(\log(1/(\epsilon_n+1/n)))$. An estimator sequence is clean first-order minimax if

```math
\sup_{P\in C_0}E_{P^{\otimes n}}|T_n-v(P)|
\le(1/4+o(1))b_n^0.
\tag{AD1}
```

There exists a **single estimator not using $\epsilon_n$** that is clean first-order minimax and, along every sequence $\epsilon_n\ge 0$ tending to zero, has exact worst robust risk

```math
\sup_{P\in C_0}\sup_Q E_{[(1-\epsilon_n)P+\epsilon_nQ]^{\otimes n}}
 |T_n-v(P)|
 =\frac12 b_n^\epsilon-\frac14 b_n^0+o(b_n^\epsilon).
\tag{AD2}
```

Moreover, every estimator sequence satisfying (AD1) obeys the corresponding lower bound in (AD2). Thus (AD2) is an exact efficiency frontier subject to the clean minimax requirement, not simply a rate-adaptation claim.

Relative to the known-contamination optimum, its efficiency loss is

```math
2-\frac{b_n^0}{b_n^\epsilon}+o(1).
\tag{AD3}
```

The ratio lies asymptotically between 1 and 2. It tends to 2 when $b_n^0/b_n^\epsilon\to 0$, and to 1 when the contamination and clean scales agree. The known-contamination optimum remains $b_n^\epsilon/4$ by Sections 1-7.

### II.11. An envelope-capped empirical law

Let the observations again have arbitrary law $H=(1-\epsilon)P+\epsilon Q$, but do not use $\epsilon$ in the estimator. For $x\ge 0$, put

```math
w(x)=\min\{1,M e^{-\Phi(x/K)}\},
\qquad
\zeta_+(x)=\min\{H_n((x,\infty)),w(x)\},
\quad
\zeta_-(x)=\min\{H_n((-\infty,-x)),w(x)\}.
\tag{AD4}
```

The two nonnegative nonincreasing right-continuous tails define a probability law $\zeta$, with the missing mass placed at zero. Indeed their values at zero sum to at most one. Their support is bounded by the finite observed sample maximum, even when the contamination law has no moments. The operation can also introduce continuous Stieltjes pieces where $w$ lies below an empirical step; it is not generally a mere reweighting of observed atoms.

Define

```math
A_\zeta(t)=1+\int g_t(x)\,d\zeta(x),\qquad
W_n=\sup_{t\ne0}\frac{2\log A_\zeta(t)}{t^2}.
\tag{AD5}
```

This is a positive-remainder functional, not an unjustified centered MGF of $\zeta$. Measurability follows either from the ray-integral formula and rational suprema, or from the explicit empirical-tail construction.

There is a deterministic finite constant $V_{\rm cap}$, depending only on the envelope, such that $W_n\le V_{\rm cap}$ for every possible sample. To see this, fix $H_0=B(s_0)<\infty$, $r_0=K a(s_0)$. For $x\ge r_0$,

```math
\zeta(|X|>x)\le2M e^{-x^2/H_0}.
```

Layer-cake integration gives

```math
E_\zeta e^{X^2/(2H_0)}\le C_0:=e^{s_0/2}+2M.
\tag{AD6}
```

Let $D_0=2H_0$. For $|t|\le D_0^{-1/2}$, Taylor's formula bounds (AD5) by $2D_0 C_0$. For $|t|\ge D_0^{-1/2}$, write $z=|t|\sqrt{D_0}\ge 1$ and use

```math
A_\zeta(t)=E_\zeta e^{tX}-tE_\zeta X
\le C_0e^{z^2/4}+z\sqrt{C_0}
\le2C_0e^{z^2/2}.
```

Thus $W_n\le D_0[1+2\log(2C_0)]\le 4D_0 C_0$; one may take $V_{\rm cap}=8H_0 C_0$. This bound uses no mean-zero property of $\zeta$.

For the estimator's clean tuning, set

```math
\eta_n=N^{-2},\quad\beta_n=N^{-8},\quad
 d_n=\frac{16\log(8(n+1)/\beta_n)}{n\eta_n}+2/n,
```

```math
S_0=N+10\log N,\quad r_0(n)^2=S_0B(S_0),\quad
c_n^0=\frac{r_0(n)^2}{2\log(1/d_n)}.
\tag{AD7}
```

Then $c_n^0\sim b_n^0/2$. Use the all-sample estimator

```math
T_n^{\rm ad}=\Pi_{[0,V_*]}
\left(\max\{W_n,c_n^0\}-\frac{c_n^0}{2}\right).
\tag{AD8}
```

Set it to zero before the tuning parameters are valid. In particular this is nonnegative: its unprojected value is at least $c_n^0/2$.

### II.12. One-sided underestimation remains on the clean scale

On the two-sided relative-tail event (R6) with $(\eta_n,\beta_n,d_n)$, the true tails obey

```math
P_\pm(x)\le a_n\zeta_\pm(x)+d'_n,
\qquad a_n=\frac{1+\eta_n}{1-\epsilon},
\quad d'_n=\frac{d_n}{1-\epsilon}.
\tag{AD9}
```

If the minimum in (AD4) chooses $H_n$, this follows from $H\ge (1-\epsilon)P$ and (R6). If it chooses $w$, the inequality follows from the deterministic bound $P_\pm\le w$. Thus capping does not silently remove the population's allowed tail.

Repeat the clipped comparison (R22)-(R27) with radius $r_0(n)$, slope cutoff $\log N/\sqrt{b_n^0}$, coefficient $a_n$ and additive error $d'_n$. The additive error has logarithm

```math
\log(1/d'_n)=\log(1/d_n)+\log(1-\epsilon),
```

so its floor differs from $c_n^0$ by $o(b_n^0)$ as $\epsilon\to 0$. The same small-argument Bernoulli inequality, now bounded using $W_n\le V_{\rm cap}$, controls the multiplicative error by $(a_n-1)V_{\rm cap}=O(\eta_n+\epsilon)$. Consequently

```math
v(P)\le\max\{W_n,c_n^0\}+o(b_n^0)+O(\epsilon).
\tag{AD10}
```

For every fixed envelope, $\epsilon=o(b_n^\epsilon)$ along the sequences considered: write $s=\log(1/(\epsilon+1/n))$, note $b_n^\epsilon\ge c/s$ for a fixed $c>0$ and all large $s$, and use $\epsilon\le e^{-s}$. Thus the remainder in (AD10) is $o(b_n^\epsilon)$. At $\epsilon=0$ it is $o(b_n^0)$. This distinction is essential; we do not claim an $o(b_n^0)$ location/dilution error for slowly decreasing contamination.

### II.13. Contamination can only lift the estimate to the larger tail floor

The other relative inequality gives

```math
\zeta_\pm(x)\le(1+\eta_n)P_\pm(x)+\kappa_n,
\qquad\kappa_n=(1+\eta_n)\epsilon+d_n.
\tag{AD11}
```

In addition $\zeta_\pm\le w$. Write $s=\log(1/(\epsilon+1/n))$, $b=b_n^\epsilon$, $S=s+10\log s$, $r^2=SB(S)$, and $\tau=\log s/\sqrt{b}$. For all joint speeds, $n\ge \exp(s)$ and

```math
\epsilon+n^{-1}\le\kappa_n\le C e^{-s}s^3.
\tag{AD12}
```

The upper bound uses $d_n=O((\log n)^3/n)$ and the fact that $x^3 e^{-x}$ is decreasing for large $x$, with $\log n\ge s$. Put

```math
q_n^\epsilon=\frac{r^2}{2\log(1/\kappa_n)};
\qquad q_n^\epsilon/b\longrightarrow1/2.
```

Integrate (AD11) only up to $r$. For the part beyond $r$, use the **capped tail**, rather than an exponential moment not possessed by $\zeta$. For $t\ge 0$, the sum of the positive and negative outward derivatives of $g_t$ is $t(e^{tx}-e^{-tx})\le t e^{tx}$. Since $w(x)\le M \exp(-x^2/B(S))$ for $x\ge r$,

```math
\int g_t\,d\zeta-\int g_t(\operatorname{clip}_r x)\,d\zeta
\le M|t|\sqrt{\pi B(S)}\,e^{t^2B(S)/4}.
\tag{AD13}
```

The same formula holds for negative $t$ by swapping rays. Thus, for $|t|\ge \tau$,

```math
\frac{2\log A_\zeta(t)}{t^2}
\le\max\{v(P),q_n^\epsilon\}
+\frac{2\log(2+\eta_n+M\sqrt\pi|t|\sqrt{B(S)})}{t^2}.
\tag{AD14}
```

The supremum of the last term is $O(b \log \log s/(\log s)^2)=o(b)$: substitute $u=|t|\sqrt{b}\ge \log s$, use $B(S)\le b$, and observe that $\log(3+Cu)/u^2$ is decreasing for all sufficiently large $u$.

For small $t$, the combined outward derivatives of $2g_t/t^2$ are bounded by $4x \exp(\tau x)$. Therefore the capped-tail error is at most

```math
4M\int_r^\infty x e^{\tau x-x^2/B(S)}\,dx
\le 4M B(S)e^{\tau r-S}.
\tag{AD15}
```

For the last bound use $\tau r\le S$ and, after $x=ry$,
$\tau r y-Sy^2 \le  \tau r-S-(S/2)(y^2-1)$ for $y\ge 1$. The interior additive error is at most $2\kappa_n r^2 \exp(\tau r)$. Both are $o(b)$ uniformly. The coefficient $1+\eta_n$ in (AD11) contributes at most $\eta_n V_*$, by the Bernoulli inequality. Consequently

```math
W_n\le\max\{v(P),b_n^\epsilon/2\}+o(b_n^\epsilon).
\tag{AD16}
```

Together, (AD10) and (AD16) are an asymmetric pair of max-floor bounds: population underestimation is on the clean floor; contamination overestimation is on the effective robust floor. A generic symmetric continuity bound would obscure this distinction and the exact adaptation frontier.

### II.14. Attainment of the exact adaptation frontier

Let $q=b_n^\epsilon/2$ and $c=c_n^0\sim b_n^0/2$. Because $b_n^\epsilon\ge b_n^0$, one has $q\ge c-o(b_n^\epsilon)$. Before the harmless projection in (AD8), (AD10) gives

```math
v(P)-T_n^{\rm ad}\le c/2+o(b_n^\epsilon),
```

whereas (AD16) gives

```math
T_n^{\rm ad}-v(P)
\le\max\{v(P),q,c\}-v(P)-c/2+o(b_n^\epsilon)
\le q-c/2+o(b_n^\epsilon).
```

Since $q\ge c$ to first order, the larger error is at most

```math
\frac12 b_n^\epsilon-\frac14 b_n^0+o(b_n^\epsilon).
```

The exceptional event contributes at most $V_* \beta_n=o(b_n^0)\le o(b_n^\epsilon)$. This proves the upper bound in (AD2), including clean optimality when $\epsilon=0$.

### II.15. Matching adaptation lower bound

Take any estimator sequence satisfying (AD1). For $\epsilon_n>0$, let $L=\log(1/\epsilon_n)$, and choose the same sparse clean law $P_{u_n}$ with $u_n\ge L+10\log L$ close to the profile supremum. Then its off-zero mass $p_n\le \epsilon_n$ and

```math
v(P_{u_n})\ge(1-o(1))B(L)/2.
```

The law $P_{u_n}$ itself has two interpretations: it is a clean member of $C_0$, and it equals $(1-\epsilon_n)\delta_0+\epsilon_n Q_n$ for a suitable probability $Q_n$. The observation distribution, hence the entire sample distribution, is identical in the two interpretations. Therefore

```math
E_{P_{u_n}^{\otimes n}}|T_n|
\ge v(P_{u_n})-
 E_{P_{u_n}^{\otimes n}}|T_n-v(P_{u_n})|
\ge\frac12B(L)-\frac14b_n^0-o(B(L)+b_n^0).
\tag{AD17}
```

This is a contamination-risk lower bound. If $\epsilon_n\ge 1/n$, then $B(L)\ge b_n^0$, and (AD17) gives the lower bound in (AD2), since the effective log differs from $L$ by at most $\log 2$. If $\epsilon_n<1/n$ or is zero, the clean minimax lower bound applies because $Q=P$ is allowed, and $b_n^\epsilon/b_n^0\to 1$; it again gives (AD2). Taking the two cases separately covers arbitrary alternating sequences. This proof also covers randomized estimators, by integrating the same triangle inequality under their common output distribution.

For fixed centered support, use $w(x)=1_{[0,K)}(x)$, so (AD4) simply clips the observations to $[-K,K]$. Set $r=K$ in all comparisons and omit external-tail integrals. The same exact frontier follows with $b_n^0=K^2/\log n$ and $b_n^\epsilon=K^2/\log(1/(\epsilon_n+1/n))$. For polynomial contamination $\epsilon_n=n^{-\gamma}$, $0<\gamma<1$, the efficiency ratio is $2-\gamma$ for fixed support and $2-\gamma^{1-2/p}$ for $\Phi(x)=x^p$, $p>2$.

**Scope of the new adaptation statement.** It is adaptation to the contamination proportion on one fixed known envelope class, under clean first-order minimaxity. It differs from the Part I's adaptation across unknown envelope classes. It neither claims adaptive honest confidence bounds nor extrapolates the zero-centered capped-tail construction to unknown means. No unproved assertion is needed for (AD1)-(AD17).

### II.16. Modulus for the unrestricted location family

The exact modulus (R33) also holds for the full location family $C$ of Section 1. This follows from the already-proved robust estimation theorem without introducing a direct and potentially false comparison between tails centered at different unknown means.

For any $P,Q\in C$ with $\operatorname{TV}(P,Q)\le h$, put $\epsilon=h/(1+h)$. Their Huber neighborhoods intersect by (R31), so there is a common observed law $H$. Let

```math
n(h)=\left\lceil\exp\{(\log(1/h))^2\}\right\rceil.
```

Apply the single known-contamination, unknown-location estimator (R29) to iid samples from $H$. The uniform upper bound in (R4) gives expected error at most
$(1/4+o(1))B(\log(1/h))$ for either clean interpretation $P$ or $Q$, because $1/n(h)=o(h)$ and replacing $h$ by $h/(1+h)$ changes the logarithm by $o(1)$. The triangle inequality under that same sample law implies

```math
|v(P)-v(Q)|\le(1/2+o(1))B(\log(1/h)),
```

uniformly over the pair. The known-center sparse subfamily supplies the matching lower bound. Therefore

```math
\sup_{P,Q\in C:\operatorname{TV}(P,Q)\le h}|v(P)-v(Q)|
\sim\frac12 B(\log(1/h)).
\tag{R35}
```

For fixed centered support radius $K$, the same reasoning gives $K^2/[2\log(1/h)]$. The dependency is noncircular: (R4)'s upper proof is Sections 2-6, and its lower proof uses the explicit sparse construction and neighborhood overlap, not the modulus statement. Section 16 extends Section 8's modulus conclusion; the elementary max-floor pair comparison (R34) itself remains a known-center statement.

## Part III. Unknown location and honest inference for clean observations

This part uses the complete clean foundation in Part I. Its confidence statements do not use the contamination model of Part II. Local section references refer to Part III.

### III.1. Model and precise contribution

For fixed $K>0,M>1$ and continuous strictly increasing unbounded $\Phi$
with $\Phi(0)=0$, let
```math
 \mathcal C_{\Phi,K,M}=
 \{P:\mu_P=E_PX\in\mathbb R,\quad
       E_P e^{\Phi(|X-\mu_P|/K)}\le M\}.
```
The mean is unknown and unrestricted. The target is
```math
 v(P)=\sup_{t\ne0}\frac{2}{t^2}
              \log E_P e^{t(X-\mu_P)}.
```
Write $a=\Phi^{-1}$ and
```math
 B(s)=K^2\sup_{u\ge s}\frac{a(u)^2}{u}.
```
When $B$ is finite, fix $s_0>0$, and set
```math
 H=B(s_0),\qquad C=M+e^{s_0},\qquad V_*=2CH.
 \tag{LC.1}
```
Part I Lemmas 1--2 give, uniformly over the centered laws,
```math
 0\le v(P)\le V_*,\qquad E e^{(X-\mu_P)^2/H}\le C,
 \qquad B(s+h)\in [sB(s)/(s+h),B(s)].
 \tag{LC.2}
```
The observable empirical centered proxy is
```math
 V_n^{c}=\sup_{t\ne0}
  \frac{2}{t^2}\log\left(\frac1n\sum_{i=1}^n
                    e^{t(X_i-\bar X_n)}\right),
 \tag{LC.3}
```
with its empirical-variance value at zero.

The results below are:

1. Unknown location preserves the exact point-risk constants $1/4$ with
   known envelope and $1/2$ for the same envelope-independent statistic
   $V_n^c$.
2. For any fixed coverage $1-\alpha\in(0,1)$, deterministic honest upper
   bounds have exact minimax expected positive-excess constant $1/2$;
   deterministic honest intervals have exact minimax expected-length constant
   $1/2$. Both constants are relative to $B(\log n)$.
3. A dyadic construction is honest simultaneously at every time and retains
   the same $1/2$ first-order constant.
4. Honesty over a larger envelope class prevents width or upper-excess
   adaptation to a faster class even at a point mass. This is stronger than
   the factor-two cost of point estimation.

Unknown-mean centering and pointwise confidence intervals themselves are
already present in Liu--Xu--Xing, arXiv:2606.06384v2, Sections 3 and 3.4.
Their displayed inference requires a unique strictly curved maximizer and a
strict truncation gap. The increment claimed here is full-class finite-sample
honesty, matching exact worst-case constants, and the time-uniform conclusion
on the stated moment-envelope classes. No claim is made that the general idea
of nonadaptive honest confidence sets or sparse-mixture lower bounds is new.

All results in this note concern clean iid observations. They do not by
themselves extend to unknown-location data under arbitrary Huber contamination.
The sample mean in (LC.3) is not a robust center.

### III.2. A deterministic centering lemma

#### Lemma LC-A

For a finite real sample $y_1,\ldots,y_n$, let
```math
 R=\max_i|y_i|,\qquad m=n^{-1}\sum_i y_i,
```
and, for every real $c$, define
```math
 A_c(t)=n^{-1}\sum_i\{e^{t(y_i-c)}-t(y_i-c)\},\qquad
 W_c=\sup_{t\in\mathbb R} \frac{2\log A_c(t)}{t^2},
```
using $n^{-1}\sum_i(y_i-c)^2$ at zero. Then all these suprema are finite and
measurable, and
```math
 |W_m-W_0|\le 4R|m|+2m^2\le 6R|m|.
 \tag{LC.4}
```
Moreover $W_m$ is exactly the proxy of the empirically centered sample.

**Proof.** For every real $u$,
```math
 |e^u-1|\le 2|u|(e^u-u).
 \tag{LC.5}
```
For $u=-z\le0$, use $1-e^{-z}\le z$ and $e^{-z}+z\ge1$.
For $u\ge0$, the difference
```math
 f(u)=2u(e^u-u)-(e^u-1)
```
vanishes at zero and has derivative
```math
 f'(u)=e^u(2u+1)-4u
       \ge (1+u)(2u+1)-4u=1-u+2u^2>0.
```
Also $e^u-u\ge1$, so $A_c(t)\ge1$. If
$R_c=\max_i|y_i-c|$, differentiation and (LC.5) give
```math
 \left|\partial_c\frac{2\log A_c(t)}{t^2}\right|
 =\frac2{|t|}
   \frac{|1-n^{-1}\sum_i e^{t(y_i-c)}|}{A_c(t)}
 \le 4R_c,\qquad t\ne0.
```
At zero the derivative is $-2(m-c)$ and the same bound is valid.
Along the segment from zero to $m$, $R_c\le R+|c|$. Integrating the uniform
bound gives $4R|m|+2m^2$; taking suprema preserves it.
The second inequality uses $|m|\le R$.

The Part I elementary finite-sample remainder bound gives
$0\le W_c\le 2R_c^2$; continuity in $t$, including at zero, shows that
the supremum over real $t$ equals the supremum over rational $t$, so it is
measurable. Finally the empirical mean of $y_i-m$ is zero, hence its
linear remainder vanishes after averaging. This identifies $W_m$.
$\square$

The same proof gives the more general shift bound
```math
 |W_{c_1}-W_{c_0}|
 \le4R_{c_0}|c_1-c_0|+2(c_1-c_0)^2.
 \tag{LC.6}
```
It is useful whenever a separate argument controls a center.

### III.3. Exact point-risk transfer to unknown location

#### Theorem LC-B

For every fixed finite-$B$ envelope class,
```math
 \inf_{T_n}\sup_{P\in\mathcal C_{\Phi,K,M}}
       E_P|T_n-v(P)|\sim\frac14B(\log n),
 \tag{LC.7}
```
and
```math
 \sup_{P\in\mathcal C_{\Phi,K,M}}
       E_P|V_n^c-v(P)|\sim\frac12B(\log n).
 \tag{LC.8}
```
The midpoint estimator in the Part I, with $V_n^c$ substituted
for the positive-remainder statistic, attains (LC.7).
The statistic in (LC.8) uses none of $\mu_P,\Phi,K,M$.
If $B$ is infinite, the finite-sample minimax risk is infinite even on
finite-support members. The Part I uniform-consistency classification is
unchanged.

**Proof.** Put $Y_i=X_i-\mu_P$, $R_n=\max_i|Y_i|$,
and $m=\bar X_n-\mu_P$. The Part I positive-remainder statistic applied to the
unobserved centered sample is $W_0$; the observable $V_n^c$ is $W_m$.
By (LC.2),
```math
 E R_n^2\le H\{\log(nC)+1\},\qquad E m^2\le V_*/n.
```
Thus Lemma LC-A and Cauchy--Schwarz give the explicit uniform bound
```math
 E|V_n^c-W_0|
 \le4\sqrt{\frac{HV_*\{\log(nC)+1\}}n}+\frac{2V_*}n.
 \tag{LC.9}
```
This is $o(B(\log n))$, because
$(\log n)B(\log n)\ge K^2a(\log n)^2\to\infty$.
The clipping and midpoint maps of the old estimator are each 1-Lipschitz
in their empirical argument. Therefore the old upper constants transfer
without any change.

The lower bounds use the mean-zero sparse laws already inside the larger
location class. For (LC.8), $V_n^c=0$ on a constant sample, so the sparse
lower bound gives $1/2$ directly. Infinite risk follows from the same
finite-support lower construction. Translation invariance of the observable
statistic makes all upper bounds uniform over unrestricted $\mu_P$.
$\square$

#### Corollary LC-C: two distinct bounded experiments

For the class with unknown location and known centered support radius,
```math
 \mathcal C_K^{\mathrm{cent}}
 =\{P:P(|X-\mu_P|\le K)=1\},
```
the exact minimax expected absolute risk is $K^2/(4\log n)$, and
$V_n^c$ has exact worst risk $K^2/(2\log n)$.
Indeed (LC.9) becomes $4K^2/\sqrt n+2K^2/n$.

For the different class with a known raw interval $[a,b]$, $w=b-a>0$,
and unrestricted mean,
```math
 \inf_{T_n}\sup_{P:P([a,b])=1}E_P|T_n-v(P)|
 \sim \frac{w^2}{4\log n}.
 \tag{LC.10}
```
The same constant remains after imposing any fixed positive proxy cap.

**Proof of (LC.10).** Centering a law on $[a,b]$ puts its centered support
inside $[-w,w]$, giving the upper bound by the preceding result.
For a lower bound compare $\delta_a$ with
```math
 Q_\epsilon=(1-\epsilon)\delta_a+\epsilon\delta_b,\qquad
 \epsilon_n=\{n(\log n)^2\}^{-1}.
```
Set $d=\log(1/\epsilon)$ and evaluate the centered MGF at $t=2d/w$.
The upper atom alone gives
```math
 v(Q_\epsilon)\ge \frac{w^2(1-2\epsilon)}{2d}.
 \tag{LC.11}
```
The constant sample $a,\ldots,a$ has probability
$(1-\epsilon_n)^n\to1$, so the common-event bound gives $w^2/(4\log n)$.
For the proxy-cap statement, the centered variance is at most $\epsilon w^2$.
When $|t|w\le d/2$, the positive-remainder bound gives
$L_{Q_\epsilon}(t)\le w^2\sqrt\epsilon$.
When $|t|w\ge d/2$, bounded centered support gives
$L_{Q_\epsilon}(t)\le4w^2/d$.
Thus $v(Q_\epsilon)\to0$, and the lower laws eventually meet any fixed cap.
$\square$

In particular the raw interval $[-K,K]$ has constant $K^2/\log n$,
whereas the known-centered-radius experiment has constant
$K^2/(4\log n)$. These models must not be conflated.

### III.4. An explicit finite-sample honest confidence construction

This construction provides a conservative bound for every sample size. Its
large-$n$ constants are sharp. It does not assert computational efficiency
for an arbitrarily represented continuous $\Phi$.

Take $0<\beta<1/5$, $n\ge3$, and write
```math
 N=\log n,\quad \ell=\log N,\quad b_n=B(N),\quad
 S=\log(nM/\beta),\quad r=\sqrt{S B(S)},\quad \eta=N^{-2},
```
```math
 d=\frac{8\log\{4(n+1)/\beta\}}{n\eta}+\frac1n,\quad
 D=\log(1/d),\quad
 \tau=\ell/\sqrt{b_n},\quad T=r\ell/b_n,\quad
 \Delta=(rN^2)^{-1}.
 \tag{LC.12}
```
Use the following formulas only if
```math
 0<\eta\le1,\quad \ell>0,\quad d<1,\quad T\ge\tau,\quad
 6+2\tau r\le2S.
 \tag{LC.13}
```
Otherwise return the interval $[0,V_*]$ and upper bound $V_*$.
Every condition is deterministic and holds eventually for the schedules
used below.

When (LC.13) holds, define
```math
 c=\max\left\{\frac{r^2}{2D},\frac{B(S)}2\right\},\qquad
 G=2\left(\left\lceil\frac{T-\tau}{\Delta}\right\rceil+1\right),
```
```math
 a_0=
 \frac{\sqrt{1+Me^{-S}}}{\beta\sqrt n}
 \left(r^2+\frac{2\tau r^3}{3}e^{\tau r}\right),
```
```math
 a_1=\max\left\{
 a_0,\ 
 \frac{2\log(G/\beta)+4r\Delta}{\tau^2},\
 \frac{2r}{T}+\frac{2\log2}{T^2}
 \right\},
\qquad
 a_2=\max\left\{a_0,\frac{2\log(2+M+\eta)}{\tau^2}\right\},
```
```math
 q=\sqrt{\frac{2V_*\log(2/\beta)}n},\qquad
 e_c=4rq+2q^2.
 \tag{LC.14}
```
Let $\Pi(z)=\min\{V_*,\max\{0,z\}\}$, and compute
```math
 L^0_n=\Pi(V_n^c-e_c-a_1),\qquad
 U^0_n=\Pi\left(\max\{V_n^c+e_c,c\}+a_2\right).
 \tag{LC.15}
```
The upper confidence bound is $U_n=U_n^0$.
The interval is $[L_n^0,U_n^0]$ when the endpoints are in the correct order,
and $[0,V_*]$ otherwise.

#### Theorem LC-D: finite-sample honesty and expected size

For every $P\in\mathcal C_{\Phi,K,M}$,
```math
 P\{v(P)\in I_n\}\ge1-5\beta,\qquad
 P\{v(P)\le U_n\}\ge1-5\beta.
 \tag{LC.16}
```
For valid parameters (LC.13),
```math
 \sup_P E_P|I_n|
 \le c+2e_c+a_1+a_2+5\beta V_*,
```
```math
 \sup_P E_P(U_n-v(P))_+
 \le c+2e_c+a_1+a_2+5\beta V_*.
 \tag{LC.17}
```

**Proof.** Work with the unobserved iid centered sample $Y_i=X_i-\mu_P$
only inside the proof. Let $W_0$ be its positive-remainder statistic.
We exhibit five failure events of probability at most $\beta$ each.

**Support.** Since $r\ge Ka(S)$,
```math
 P\{\max_i|Y_i|>r\}\le nM e^{-S}=\beta.
```
For $x\ge r$, the profile definition gives
$\Phi(x/K)\ge Sx^2/r^2$.

**Small arguments.** The Part I empirical fundamental-theorem-of-calculus
bound for
```math
 f_t(y)=2\{e^{ty}-1-ty\}/t^2,\qquad f_0(y)=y^2,
```
is
```math
 E\sup_{|t|\le\tau}|(P_n-P)f_t|
 \le n^{-1/2}\{(EY^4)^{1/2}
        +(2\tau/3)(EY^6e^{2\tau|Y|})^{1/2}\}.
```
The last condition in (LC.13) implies
```math
 EY^4\le r^4(1+Me^{-S}),\quad
 EY^6e^{2\tau|Y|}\le r^6e^{2\tau r}(1+Me^{-S}).
```
For the exterior integral, maximize
$y^m e^{2\tau ry-Sy^2}$ over $y\ge1$; its logarithmic derivative is
nonpositive for $m=6$ by (LC.13), and for $m=4,\tau=0$ as well.
The logarithm is 1-Lipschitz on $[1,\infty)$, so this also bounds the
small-$t$ proxy difference. Markov's inequality at $a_0$ gives failure
probability at most $\beta$.

**Empirical upper comparison.** Put grid points of magnitudes
$\tau+j\Delta$, for $j=0,\ldots,\lceil(T-\tau)/\Delta\rceil$, on both
rays. At each point the positive-remainder MGF has expectation equal to the
true centered MGF. Markov's inequality with factor $G/\beta$ and a union
bound give a further failure probability $\beta$.
On the support event, its logarithmic derivative in $t$ is at most $2r$
in absolute value. Choosing the grid point immediately below the target
magnitude and using nonnegativity of its logarithm gives the interpolation
error $4r\Delta/\tau^2$. For $|t|>T$, the elementary bound
$A_0(t)\le2e^{r|t|}$ gives
$2r/T+2\log2/T^2$. Consequently
```math
 W_0\le v(P)+a_1.
 \tag{LC.18}
```

**Population lower comparison.** The Part I relative empirical-tail lemma
with $\eta,\beta$ gives both strict tail inequalities, simultaneously for
all real cutoffs, with failure probability $\beta$. Integrating them against
the two nonnegative ray derivatives of $g_t(y)=e^{ty}-1-ty$, clipping at
$\pm r$ only inside the population comparison, yields on the support event
```math
 M_P(t)
 \le(1+\eta)A_0(t)
       +d\{g_t(r)+g_t(-r)\}
       +M\exp\{t^2B(S)/4\}.
```
Here the discarded additive term is $-\eta\le0$.
Completing the square gives
```math
 d\{g_t(r)+g_t(-r)\}
 \le e^{r|t|-D}\le e^{t^2r^2/(4D)}.
```
By the definition of $c$,
```math
 M_P(t)\le(1+\eta)A_0(t)+(1+M)e^{t^2c/2}.
```
For $|t|\ge\tau$, take logarithms and use the larger of the two exponential
terms. For $|t|\le\tau$, use the small-argument event. This proves
```math
 v(P)\le\max\{W_0,c\}+a_2.
 \tag{LC.19}
```

**Center.** The true centered law is sub-Gaussian with proxy at most $V_*$.
The Chernoff bound gives
```math
 P\{|\bar X_n-\mu_P|>q\}\le2e^{-nq^2/(2V_*)}=\beta.
```
On this and the support events, Lemma LC-A yields
$|V_n^c-W_0|\le e_c$.

The union of the five failure events has probability at most $5\beta$.
Equations (LC.18)--(LC.19), the centering bound, and $v(P)\in[0,V_*]$
give the coverage statements after clipping. On this event the endpoint
ordering is valid, and interval length and upper positive excess are at most
$c+2e_c+a_1+a_2$. On its complement both quantities are at most $V_*$.
This proves (LC.17). If (LC.13) fails the fallback is certainly valid.
$\square$

#### Corollary LC-E: sharp upper constants

For fixed $0<\alpha<1$, use
```math
 \beta_n=\min\{\alpha/10,(\log n)^{-12}\}
```
in the preceding construction. It is honest at level $1-\alpha$ for every
$n$, with the trivial fallback for $n<3$. Moreover
```math
 \sup_P E_P|I_n|\le(1/2+o(1))B(\log n),\qquad
 \sup_P E_P(U_n-v(P))_+\le(1/2+o(1))B(\log n).
 \tag{LC.20}
```

**Proof.** Eventually $\beta_n=N^{-12}$,
$S=N+12\log N+\log M$, $D=N-3\log N+O(1)$, and
$Nb_n\le r^2\le Sb_n$. Thus
```math
 c/b_n\to1/2,\quad \tau r=O(\sqrt N\log N),\quad
 G=O(N^3\log N).
```
All validity conditions hold eventually.
The explicit formulas give $a_0=o(b_n/N^A)$ for every fixed $A$,
$a_1=O(b_n/\log N)$, and $a_2=O(b_n/(\log N)^2)$.
Furthermore $e_c=o(b_n)$, since
```math
 \frac{e_c}{b_n}
 =O\left(\sqrt{\frac{N\log N}{nb_n}}
             +\frac{\log N}{nb_n}\right)=o(1),
```
and $b_n\ge c_0/N$ eventually for a positive constant $c_0$.
Finally $\beta_n V_*=o(b_n)$. Apply (LC.17).
$\square$

For centered bounded support radius $K$, use $r=K$,
$b_n=K^2/N$, $V_*=2K^2$, and $c=K^2/(2D)$.
Set the support-failure term to zero. In $a_0$, remove the factor
$\sqrt{1+Me^{-S}}$; in $a_2$, replace $2+M+\eta$ by $2+\eta$.
The same proof gives (LC.20) with $K^2/\log n$.
For raw support $[a,b]$, use centered radius $w=b-a$, giving the
corresponding upper size $w^2/(2\log n)$.

### III.5. Exact lower constants, including the role of randomization

Let $\mathfrak U_{n,\alpha}$ denote nonrandomized measurable upper bounds
with uniform coverage at least $1-\alpha$ over
$\mathcal C_{\Phi,K,M}$. Let $\mathfrak I_{n,\alpha}$ denote
nonrandomized measurable intervals with the same honest coverage.
Their losses are respectively $E(U-v)_+$ and $E|I|$.

#### Theorem LC-F

For every fixed finite-$B$ envelope and fixed $0<\alpha<1$,
```math
 \inf_{U\in\mathfrak U_{n,\alpha}}\sup_P E_P(U-v(P))_+
       \sim \tfrac12 B(\log n),
```
```math
 \inf_{I\in\mathfrak I_{n,\alpha}}\sup_P E_P|I|
       \sim \tfrac12 B(\log n).
 \tag{LC.21}
```
For the full location envelope class, the lower bounds are forced already by
the expected loss at any single point mass. The analogous centered-radius
and raw-support constants are $K^2/(2\log n)$ and
$w^2/(2\log n)$, respectively. The arbitrary-point-mass statement also
holds for the translation-invariant centered-radius class. For a fixed raw
interval $[a,b]$, the $w^2/(2\log n)$ lower bound is forced at
$\delta_a$ or $\delta_b$; no assertion of the same pointwise constant at
every interior point mass is made.

**Proof.** In the old sparse construction choose
$u_n\ge\log n+10\log\log n$ approximating the tail supremum.
The resulting symmetric mean-zero finite-support law $Q_n$ obeys
```math
 q_n=Q_n^{\otimes n}\{0,\ldots,0\}\to1,\qquad
 v(Q_n)\ge(1/2-o(1))B(\log n).
```
For large $n$, $q_n>\alpha$. If a deterministic upper bound at the all-zero
data is less than $v(Q_n)$, its coverage under $Q_n$ is at most
$1-q_n<1-\alpha$, a contradiction. Thus $U_n(0,\ldots,0)\ge v(Q_n)$.
Under $\delta_0$ this is exactly its positive-excess loss.

A deterministic honest interval must contain zero at the all-zero data,
because this data has probability one under $\delta_0$.
The same argument forces it also to contain $v(Q_n)$, hence its length is
at least $v(Q_n)$.
Translate the laws for a general point mass only in the unrestricted-location
or centered-radius experiments. For centered bounded support use the old
symmetric sparse laws; for a fixed raw interval use the one-sided laws in
(LC.11), based at an endpoint $\delta_a$, or reflect them to use $\delta_b$.
The upper bounds are Corollary LC-E.
$\square$

**Optional randomization changes this particular expected-size criterion.**
If an independent random seed is permitted, both constants in (LC.21) become
$(1-\alpha)/2$. This reduction is caused by deliberately declining to
cover on a small random fraction of experiments, not by extracting additional
information from the sample.

For upper bounds, honesty and the all-zero probability imply
```math
 P_{\delta_0,R}\{U_n\ge v(Q_n)\}\ge1-\alpha/q_n,
```
so the expected positive excess at $\delta_0$ is at least
$(1-\alpha/q_n)v(Q_n)$.
For intervals, use the continuum of laws obtained by multiplying the sparse
amplitudes by $\sqrt\theta$, $0<\theta\le1$. Their envelope costs do not
increase, their all-zero probabilities remain $q_n$, and their targets
are $\theta v(Q_n)$. At $\theta=0$, the law is $\delta_0$, whose
all-zero probability is one; honesty then gives inclusion of zero with
probability at least $1-\alpha\ge1-\alpha/q_n$.
Consequently honesty implies
```math
 P_R\{z\in I_n(0,\ldots,0;R)\}\ge1-\alpha/q_n
 \quad (0\le z\le v(Q_n)).
```
Tonelli's theorem, integrating in $z$, gives the same expected-length lower
bound. To attain it asymptotically, use the base construction with failure
bound $5\beta_n=o(1)$ with independent probability
$(1-\alpha)/(1-5\beta_n)$, and otherwise output $U=0$, or $I=[0,0]$.
Coverage is at least $1-\alpha$ and the expected size has the claimed limit.
The ordinary deterministic construction is preferable when deliberate
random noncoverage is not the intended loss criterion.

### III.6. Time-uniform confidence bounds without a first-order penalty

#### Theorem LC-G

For every fixed finite-$B$ envelope and $0<\alpha<1$, there is a
nonrandomized observable sequence of finite upper bounds $\mathcal U_n$
such that
```math
 \inf_{P\in\mathcal C_{\Phi,K,M}}
 P\{\forall n\ge1:\ v(P)\le\mathcal U_n\}\ge1-\alpha,
```
```math
 \limsup_{n\to\infty}
 \frac{\sup_P E_P(\mathcal U_n-v(P))_+}{B(\log n)}
 \le\frac12.
 \tag{LC.22}
```
One can take $\mathcal U_n$ nonincreasing. Honest intervals at every time
with the same expected-length first-order upper bound also exist.
The constant $1/2$ is optimal among deterministic time-uniform procedures.

**Proof.** At checkpoints $n_j=2^j$, $j\ge1$, apply Theorem LC-D with
```math
 \beta_j=\min\left\{\frac{\alpha}{20(j+1)^2},
                         (\log n_j)^{-12}\right\}.
```
Use the fallback whenever necessary. The total failure probability is at most
```math
 \sum_{j\ge1}5\beta_j
 \le\frac\alpha4\sum_{j\ge1}(j+1)^{-2}<\alpha.
```
Between successive checkpoints hold the last interval and upper bound
fixed; before the first checkpoint use $[0,V_*]$ and $V_*$.
The resulting family is jointly honest by the union bound, without requiring
independence between checkpoints.

Eventually $\beta_j=(\log n_j)^{-12}$, so the preceding asymptotic upper
analysis applies at the checkpoints. If $n_j\le n \lt n_{j+1}$, then
$0\le\log n-\log n_j<\log2$, and (LC.2) gives
```math
 B(\log n_j)/B(\log n)\to1.
```
Hence holding the bound constant between checkpoints has no first-order cost.
For a nonincreasing upper sequence, replace the held bound by its minimum
over all checkpoints so far; the simultaneous-coverage event is preserved
and positive-excess loss only decreases.

Any time-uniform procedure is honest at each fixed time, so Theorem LC-F
supplies the matching deterministic lower constant.
$\square$

This result is an ordinary stitched confidence sequence for a fixed
distributional functional. It makes no claim that the stitching method is new.
It does not justify plugging in the empirical proxy without the upper
correction, and does not give a distribution-free bound without the supplied
envelope.

### III.7. Honest adaptation obstruction and absence of a tail envelope

#### Corollary LC-H: no faster honest width at a point mass

Let $\mathcal C_1$ be a fixed finite-$B$ class, and let a second class
$\mathcal C_2$ contain a point mass $\delta_\mu$. Suppose its natural
point-estimation scale satisfies $b_{2,n}=o(B_1(\log n))$.
Every deterministic interval or upper bound honest on $\mathcal C_1$ has
respectively
```math
 E_{\delta_\mu}|I_n|\ge(1/2-o(1))B_1(\log n),\qquad
 E_{\delta_\mu}(U_n-v(\delta_\mu))_+
       \ge(1/2-o(1))B_1(\log n).
 \tag{LC.23}
```
Thus its expected size cannot be $O(b_{2,n})$ uniformly on $\mathcal C_2$.
The statement also applies to time-uniform procedures.
With independent randomization the lower factor is $(1-\alpha)/2$,
which still precludes faster-rate adaptation.

**Proof.** The point-mass lower proof in Theorem LC-F and its randomized
extension already establish these statements. No nesting is needed for the
pointwise consequence. If nesting is desired, the bounded centered-support
subclass with radius $K\Phi^{-1}(\log M)$ lies in the envelope class and has
scale $1/\log n=o(B_1(\log n))$.
$\square$

#### Proposition LC-I: a finite upper bound cannot be fully envelope-free

At any fixed sample size $n$ and any $0<\alpha<1$, there is no finite-valued
upper confidence bound, even with independent randomization, honest uniformly
over all finite-support laws. The same impossibility holds on the
mean-zero finite-support subfamily. If extended values are permitted,
honesty forces
```math
 P_{\delta_0,R}\{U_n=+\infty\}\ge1-\alpha.
 \tag{LC.24}
```

**Proof.** Fix any sufficiently small $\epsilon>0$ with
$q=(1-\epsilon)^n>\alpha$, and let
```math
 Q_A=(1-\epsilon)\delta_0+
            \frac\epsilon2(\delta_A+\delta_{-A}).
```
For every finite $A$, this is a finite-support mean-zero sub-Gaussian law.
Its target is $A^2v(Q_1)$, which tends to infinity with $A$.
Honesty implies
```math
 P_{\delta_0,R}\{U_n\ge A^2v(Q_1)\}\ge1-\alpha/q.
```
Let $A\to\infty$; if $U_n$ is finite almost surely, the left side tends
to zero, a contradiction. For extended values it gives
$P\{U_n=\infty\}\ge1-\alpha/q$. Finally let $\epsilon\downarrow0$, so
$q\uparrow1$, to obtain (LC.24).
$\square$

The Part I envelope-independent point estimator can be risk-adaptive class by
class. Proposition LC-I shows why that fact cannot yield a finite honest
upper bound over the union of unknown envelope classes. The general
nonparametric-inference mechanism is classical; the exact classwise
calibration and sharp constants above are the project-specific conclusions.

### III.8. Source check and integration limits

The comparison uses the official arXiv HTML for Liu--Xu--Xing v2:
https://arxiv.org/html/2606.06384v2 .
Section 3 defines empirical mean centering. Proposition 5 and Section 3.4
give a pointwise normal limit and an asymptotic confidence interval under
strict maximizer and gap conditions. This supports the limited difference
stated in Section 1; it does not support a claim that centering or proxy
confidence intervals were invented here.

The new statements keep the envelope fixed, including $M>1$, as sample size
increases. The claimed exact confidence constants hold for fixed
$\alpha\in(0,1)$; the all-time construction has fixed total error $\alpha$.
No sharp simultaneous asymptotics for $\alpha=\alpha_n\to0$ are asserted.
No robust honest unknown-location confidence theorem is asserted in this part.


## Part IV. Honest calibration of an independent held-out observation

**Scope.** These are operational consequences and limitations of an honest
upper confidence bound. They are not a new general theory of Monte Carlo
tests, and the elementary conditioning and sparse-event arguments are not
claimed as new methods. The target observation below must be independent of
the calibration data and must follow the clean null law. Reusing calibration
observations as target observations is outside the statement.

### INF1. Validity of a calibrated Chernoff p-value

Let a real law $P$ have known mean zero and optimal variance proxy $v(P)$.
Let $D$ be calibration data, possibly drawn from the Huber model in the robust
theorem, and let a nonnegative statistic $U(D)$ satisfy

```math
\Pr\{U(D)\ge v(P)\}\ge1-\beta,\qquad 0<\beta<1.
```

Let $Y$ be an independent observation from $P$. Define $q(y,u)=1$ for
$y\le 0$; for $y>0$, define $q(y,u)=\exp(-y^2/(2u))$ when $u>0$, and
$q(y,0)=0$. If $u=\infty$, use $q(y,u)=1$. Then

```math
p(D,Y)=\min\{1,\beta+q(Y,U(D))\}
\tag{INF1}
```

is super-uniform under the clean null: for every $0\le \alpha\le 1$,
$\Pr\{p(D,Y)\le\alpha\}\le\alpha$.

**Proof.** For $\alpha<\beta$ the rejection event is empty. For
$\beta\le \alpha<1$, condition on the calibration data on the event
$G=\{U\ge v(P)\}$. The Chernoff inequality and independence give
$\Pr\{q(Y,U)\le\alpha-\beta\mid D\}\le\alpha-\beta$ on $G$. This includes $v(P)=0$,
when $Y=0$ almost surely. Integration over $G$, followed by adding the
probability at most $\beta$ of $G^c$, proves the claim. At $\alpha=1$ it is
immediate. The same proof permits a data collection stopping time, provided
the calibration guarantee holds at that time and $Y$ remains independent.

Thus an estimator with a small expected absolute error is not by itself a
valid substitute in (INF1); the upper coverage guarantee is the needed input.

### INF2. An exact necessary bound at a sparse calibration sample

Let $K>0$, and suppose a **deterministic** statistic $U_n$ has upper coverage
at least $1-\beta$ uniformly over all known-mean-zero laws supported on
$[-K,K]$. Its value on the all-zero sample must satisfy

```math
U_n(0,\ldots,0)\ge
\frac{K^2}{2\log\{2/(1-\beta^{1/n})\}}.
\tag{INF2}
```

**Proof.** For $0 \lt p<1$, let

```math
P_p=(1-p)\delta_0+\tfrac p2(\delta_K+\delta_{-K}).
```

One term of its moment-generating function, evaluated at
$t=2 \log(2/p)/K$, gives

```math
v(P_p)\ge K^2/[2\log(2/p)].
```

Whenever $(1-p)^n>\beta$, a value $U_n(0^n) \lt v(P_p)$ would make the upper
coverage fail on an event of probability greater than $\beta$. Hence
$U_n(0^n)\ge v(P_p)$ for every $p<1-\beta^{1/n}$. Let $p$ increase to that
endpoint in the displayed lower bound. This proves (INF2), without requiring
a closed form for the exact sparse-law proxy.

In particular, applying the pipeline (INF1) at the positive endpoint $Y=K$
gives the necessary lower bound

```math
p(0^n,K)\ge\beta+\frac{1-\beta^{1/n}}2.
\tag{INF3}
```

The right side is at most one for $0<\beta<1$; therefore the truncation in
(INF1) causes no exception. For $n>1$, optimization over the confidence budget
gives

```math
\inf_{0<\beta<1}
\left\{\beta+\frac{1-\beta^{1/n}}2\right\}
=\frac12-\frac{n-1}{2n}(2n)^{-1/(n-1)}
\sim\frac{\log n}{2n}.
\tag{INF4}
```

Indeed, differentiating the objective yields its unique minimum at
$\beta=(2n)^{-n/(n-1)}$. Expanding the last expression gives
$[\log(2n)+1+o(1)]/(2n)$. When $n=1$, the infimum is $1/2$.

This is a necessary restriction on the specific deterministic
**honest-global-proxy plus additive-coverage-correction** procedure. It is
not a lower bound for all valid p-values, all datasets, randomized tests,
or problems with additional distributional structure. In this sparse
configuration, the procedure can be more conservative than an ordinary
rank-based Monte Carlo test. Its role in the present paper is to delimit
what the new upper bounds actually justify, rather than to claim automatic
power improvements or unrestricted tail extrapolation.

The same sparse family lies inside any original moment-envelope class if
$K$ in this section is replaced by a fixed
$k_0=K \Phi^{-1}(\log M)>0$. The bound therefore also supplies an obstruction
inside those larger classes.

### Source relationship

Liu--Xu--Xing, arXiv:2606.06384v2, motivate proxy estimation in part by
tail extrapolation for permutation testing and supply pointwise asymptotic
intervals under regularity. The assertions above concern a separate,
uniformly honest calibration experiment. They do not invalidate that
paper's pointwise asymptotic results or purport to analyze its complete
permutation implementation. Phipson--Smyth (2010), DOI
10.2202/1544-6115.1585, is prior work on exact Monte Carlo p-values and the
dangers of treating a tail estimate as automatically valid. That general
principle is explicitly attributed rather than counted as new here.

## Reproducibility and computational scope

The proofs specify all statistical procedures, tuning constants, fallback rules, event probabilities and lower-bound distributions. Supremum-defined statistics are measurable; an efficient certified solver for every arbitrary input envelope is not claimed.

The exact-arithmetic rank-trimming certificate checks finite atomic tail inequalities, center budgets and translation equivariance. A separate cap diagnostic compares explicit Stieltjes integration with a layer-cake implementation and checks Gaussian kernel bounds. These diagnostics help detect implementation or algebra errors in finite examples; they do not establish the general theorems and are not simulations presented as proofs. No numerical check is described as Lean or kernel verification.

The results do not provide a finite-positive-contamination exact constant, a changing-envelope uniform theorem, an adversarial replacement guarantee, a robust honest interval for simultaneous unknown location and contamination, or a general bandit regret improvement. The randomized confidence improvement spends coverage by intentional random noncoverage; it does not acquire additional information. The held-out application requires independence and valid upper coverage at the selected calibration time.

## References


[1] Jason Liu, Min Xu, and Jinchuan Xing. **Estimation of the sub-Gaussian Parameter.** arXiv:2606.06384v2, 7 October 2026. https://arxiv.org/html/2606.06384v2 .

[2] Fabian Mies. **Empirical Orlicz norms.** arXiv:2510.25408v3, 11 March 2026. https://arxiv.org/html/2510.25408v3 .

[3] Lasse Leskelä and Matvei Zhukov. **Sharp constants relating the sub-Gaussian norm and the sub-Gaussian parameter.** *Electronic Communications in Probability* **31**, 1-11, 2026. DOI: 10.1214/26-ECP761. https://arxiv.org/abs/2507.05928 .

[4] Julyan Arbel, Olivier Marchal, and Hien D. Nguyen. **On strict sub-Gaussianity, optimal proxy variance and symmetry for bounded random variables.** *ESAIM: Probability and Statistics* **24**, 39-55, 2020. DOI: 10.1051/ps/2019018. https://www.numdam.org/item/10.1051/ps/2019018.pdf .

[5] Soufiane Atouani, Olivier Marchal, and Julyan Arbel. **Optimal sub-Gaussian variance proxy for 3-mass distributions.** arXiv:2510.06132, 7 October 2025. https://arxiv.org/abs/2510.06132 .

[6] Jonas Lieber. **Essays on Econometrics and Industrial Organization.** PhD dissertation, University of Chicago, 2023. Chapter 1: *Estimating Concentration Parameters for Bandit Algorithms*. DOI: 10.6082/uchicago.6522. https://knowledge.uchicago.edu/records/2h5r2-f0b89 .


[7] Mengjie Chen, Chao Gao, and Zhao Ren. **Robust covariance and scatter matrix estimation under Huber's contamination model.** *The Annals of Statistics* **46**(5), 1932-1960, 2018. DOI: [10.1214/17-AOS1607](https://doi.org/10.1214/17-AOS1607). Author manuscript: https://arxiv.org/pdf/1506.00691 .

[8] T. Tony Cai and Mark G. Low. **An adaptation theory for nonparametric confidence intervals.** *The Annals of Statistics* **32**(5), 1805-1840, 2004. DOI: [10.1214/009053604000000049](https://doi.org/10.1214/009053604000000049). Journal reprint: https://arxiv.org/pdf/math/0503662 .

[9] Steven R. Howard, Aaditya Ramdas, Jon McAuliffe, and Jasjeet Sekhon. **Time-uniform, nonparametric, nonasymptotic confidence sequences.** *The Annals of Statistics* **49**(2), 1055-1080, 2021. DOI: [10.1214/20-AOS1991](https://doi.org/10.1214/20-AOS1991). Later arXiv revisions are not identified with the published version.

[10] Mengjie Chen, Chao Gao, and Zhao Ren. **A general decision theory for Huber's epsilon-contamination model.** *Electronic Journal of Statistics* **10**(2), 3752-3774, 2016. DOI: [10.1214/16-EJS1216](https://doi.org/10.1214/16-EJS1216). https://arxiv.org/pdf/1511.04144 .

[11] Haoyang Liu and Chao Gao. **Density estimation with contamination: minimax rates and theory of adaptation.** *Electronic Journal of Statistics* **13**(2), 3613-3653, 2019. DOI: [10.1214/19-EJS1617](https://doi.org/10.1214/19-EJS1617). https://arxiv.org/pdf/1712.07801 .

[12] Ayush Jain, Alon Orlitsky, and Vaishakh Ravindrakumar. **Robust estimation algorithms don't need to know the corruption level.** arXiv:2202.05453, 2022. https://arxiv.org/pdf/2202.05453 .

[13] Yuetian Luo and Chao Gao. **Adaptive robust confidence intervals.** *The Annals of Statistics* **54**(3), 1128-1152, 2026. DOI: [10.1214/25-AOS2574](https://doi.org/10.1214/25-AOS2574). Author version: https://arxiv.org/html/2410.22647v2 .

[14] Hongjian Wang and Aaditya Ramdas. **Huber-robust confidence sequences.** *Proceedings of the 26th International Conference on Artificial Intelligence and Statistics*, PMLR **206**, 2023. https://proceedings.mlr.press/v206/wang23p.html .

[15] Belinda Phipson and Gordon K. Smyth. **Permutation P-values Should Never Be Zero: Calculating Exact P-values When Permutations Are Randomly Drawn.** *Statistical Applications in Genetics and Molecular Biology* **9**(1), Article 39, 2010. DOI: [10.2202/1544-6115.1585](https://doi.org/10.2202/1544-6115.1585). Author version: https://gksmyth.github.io/pubs/PermPValuesPreprint.pdf .

## Appendix A. Claim dependencies for a complete proof audit

The identifiers refer to the full statements with every hypothesis and to their complete proofs, including measurability and probabilistic quantifiers. They are not substitutes for those statements.

| Claim | Principal dependencies |
|---|---|
| [LEM-01] Profile and classification | [DEF-01], [DEF-03], inverse monotonicity, real suprema |
| [LEM-02] Finite uniform target bound | [LEM-01], exponential integrability, mean zero |
| [LEM-03] Positive remainder and estimator | Taylor integral identity, scalar bounds, measurable countable suprema, finite data interval |
| [LEM-04] Relative tail band | Binomial exponential Markov bound, quantile representation, finite union bound |
| [LEM-05] Tuning and sample event | [LEM-01], [LEM-02], Markov inequality |
| [LEM-06] Empirical FTC bound | [LEM-03], iid variance identity, Tonelli, Cauchy-Schwarz |
| [LEM-07] Small arguments | [LEM-05], [LEM-06], weighted envelope moments |
| [LEM-08] Empirical upper bound | [LEM-03], [LEM-05], [LEM-07], finite grid and Markov inequality |
| [LEM-09] Tail floor | [LEM-04], [LEM-05], [LEM-07], ray integration and completion of the square |
| [LEM-10] Expected upper risk | [LEM-02], [LEM-08], [LEM-09], projection and exceptional-event control |
| [LEM-11] Sparse common-event bound | [DEF-01], one MGF evaluation, absolute-loss triangle inequality |
| [LEM-12] General lower and infinite case | [LEM-01], [LEM-11], approximate suprema |
| [THM-01], [COR-01] General theorem | [LEM-01], [LEM-02], [LEM-10], [LEM-12] |
| [THM-02] Fixed support | Separate Section 7 substitutions, [LEM-03], [LEM-04], [LEM-06], grid and common-event arguments |
| [THM-03] Universal estimator | [LEM-03], [LEM-08], [LEM-09], [LEM-12], maximal fourth moment |
| [PROP-01], [THM-04], [COR-02] Adaptation | [LEM-01], [LEM-11], [LEM-12], [THM-02], [THM-03], common zero sample |
| [EX-01], [EX-02], [EX-03] Explicit envelopes | [THM-01], inverse-envelope calculations, tail supremum |

### Additional analytic dependencies

The robust upper theorem R4 uses R5-R29 and the envelope facts in Part I; its lower theorem uses the explicit sparse construction and Huber-neighborhood intersection R31. R35 then derives the unknown-location modulus from the already established upper theorem. There is no dependence of that upper theorem on R35.

The adaptation frontier AD2 uses the capped-law construction AD4-AD8, the asymmetric comparisons AD10 and AD16, and the common-observation lower inequality AD17. Its clean-efficiency constraint is AD1. The center is known throughout this branch.

LC-B uses the deterministic center lemma LC-A and the clean foundation. LC-D constructs finite-sample coverage through five specified events and a fallback. LC-F supplies matching deterministic and randomized lower bounds. LC-G uses deterministic checkpoint error spending and the slow profile variation. LC-H and LC-I give the honest-adaptation and unrestricted-class impossibilities. INF1 uses honest upper coverage and independence; INF2-INF4 use a separate bounded sparse family and constrain only the named testing pipeline.
