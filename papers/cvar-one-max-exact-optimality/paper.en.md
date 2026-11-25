# Exact CVaR Optimality and the Full Threshold Family for One-Max Search

**AI-assisted research manuscript.** Prepared 24 November 2026. No external peer review or Lean certification is claimed.

## Abstract

Consider one-max search with prices in a known interval $[L,U]$, an unknown finite horizon, and compulsory reward $L$ if no price is accepted. Performance is measured by the largest, over deterministic input sequences, ratio of the maximum price to the lower-tail conditional value-at-risk of the algorithm's reward. Christianson, Sun, Low and Wierman proposed a randomized threshold rule described by a delay differential equation, but established its optimality only at the endpoints, beyond a risk transition, and asymptotically at small risk. We prove that their rule is exactly minimax optimal for every risk level, including against arbitrary randomized algorithms that depend on the observed history. The missing lower bound follows from a quantile comparison valid for atomic and singular distributions. We also characterize every optimal threshold law, identify an optimal law with the smallest possible upper support endpoint, and prove an integral deficit bound for near-optimal laws. The exact value yields a first-order small-risk expansion, quadratic loss of the randomization advantage at the known transition, and an explicit sequence of power-law exponents as $U/L$ grows. The delay equation, its explicit solution, and the transition location are prior results; the contribution is a matching lower bound and the resulting structural conclusions.

## 1. Problem, prior result, and contribution

In one-max search, an algorithm owns one indivisible item. At each step it observes a price and may either sell once at that price or continue. Prices lie in $[L,U]$, where $0<L\le U$ is known. The length of the sequence is unknown in advance. If the sequence ends before the algorithm sells, its compulsory reward is $L$. The input is chosen without observing the algorithm's random choices. This is precisely the model in [1, Section 2.3]. The fallback convention matters: we do not consider an announced final opportunity with compulsory sale at its revealed price.

For a bounded reward $Y$, write $Q_Y$ for its generalized quantile and define

$$
\mathcal R_\delta(Y)=\frac{1}{1-\delta}\int_0^{1-\delta}Q_Y(s)\,ds,
\qquad 0\le\delta<1.
\tag{1.1}
$$

At $\delta=1$, set $\mathcal R_1(Y)=\operatorname{ess\,inf}Y$. Thus the risk measure averages the **lowest** $1-\delta$ fraction of rewards. The objective is

$$
C_\delta(A)=\sup_{\sigma}\frac{\max\sigma}{\mathcal R_\delta(A(\sigma))},
\qquad V_\delta(L,U)=\inf_A C_\delta(A),
\tag{1.2}
$$

where $\sigma$ ranges over all finite price sequences and $A$ ranges over admissible randomized online algorithms. The randomness inside $\mathcal R_\delta$ is the algorithm's randomness on the fixed input, not a distributional forecast of future inputs.

Christianson et al. [1, Theorem 12 and equation (7)] constructed a threshold distribution through a delay equation and gave an explicit solution. They proved a risk transition at $\delta=1/2$ and matching small-risk orders [1, Theorem 13]. Immediately after Theorem 12 they explicitly leave global optimality of their proposed rule unresolved. We supply that lower bound without changing their model. The other main result is a complete classification of optimal **threshold distributions**, rather than a classification of every possible history-dependent optimizer.

Related work on prediction-based one-max search has different information and objectives. The CVaR in [2, Sections 2.2 and 4.2] is taken across input distributions consistent with a forecast, while [3] and [4] study prediction-dependent consistency, robustness, and smoothness. These do not provide the lower bound in (1.2). The literature comparison is limited to the sources inspected; no global priority is claimed.

Scale prices by $L$ and put $\theta=U/L$. Henceforth $L=1$ and $U=\theta$. The case $\theta=1$ has value $1$, so assume $\theta>1$.

## 2. Exact minimax value

Fix $0\le\delta<1$ and set $h=1-\delta$. For $a\ge1$, let $\phi_{a,\delta}$ be the continuous solution of

$$
\phi_{a,\delta}(t)
=a\left[1+\frac1h\int_0^{(t-\delta)_+}
\bigl(\phi_{a,\delta}(s)-1\bigr)\,ds\right],
\qquad 0\le t\le1.
\tag{2.1}
$$

Equivalently, it equals $a$ on $[0,\delta]$ and satisfies
$\phi'_{a,\delta}(t)=a\bigl(\phi_{a,\delta}(t-\delta)-1\bigr)/h$ afterwards. The known explicit solution [1] is

$$
\phi_{a,\delta}(t)
=1+(a-1)\sum_{j\ge0}
\frac{a^j(t-j\delta)_+^j}{h^j j!}.
\tag{2.2}
$$

The $j=0$ term is defined as $1$. When $\delta>0$, terms with $j\ge1$ and $j\delta\ge t$ vanish. When $\delta=0$, the sum is $e^{at}$.

**Theorem 1 (exact value).** For $\theta>1$ and $0\le\delta<1$, the value $V_\delta(1,\theta)$ is the unique $a_\delta>1$ satisfying

$$
\boxed{\theta=\phi_{a_\delta,\delta}(1)
=1+(a_\delta-1)\sum_{j\ge0}
\frac{a_\delta^j(1-j\delta)_+^j}{(1-\delta)^j j!}.}
\tag{2.3}
$$

The threshold rule with quantile $\phi_{a_\delta,\delta}$ attains this value. The lower bound holds for all history-dependent randomized online algorithms. At $\delta=1$, the value is $\sqrt\theta$.

The theorem upgrades the existing upper bound in [1] to an exact optimum; it does not introduce a new delay-equation algorithm. We give a full proof, including the reduction to arbitrary online algorithms.

### 2.1. Threshold laws, atoms, and finite input sequences

Let $X$ have an arbitrary probability law on $[1,\theta]$, with CDF $F$ and quantile

$$
q(t)=\inf\{x\in[1,\theta]:F(x)\ge t\},\qquad 0<t\le1.
$$

Atoms, support gaps, and singular continuous distributions are allowed. Its threshold policy accepts the first price at least $X$. For $1\le v\le\theta$, define

$$
Y_v=\mathbf1_{\{X>v\}}+X\mathbf1_{\{X\le v\}},
\qquad R(v)=\mathcal R_\delta(Y_v).
$$

The exact competitive ratio of this policy is

$$
C_\delta(X)=\sup_{1\le v\le\theta}\frac{v}{R(v)}.
\tag{2.4}
$$

Indeed, on an input of maximum $v$, its actual reward is at least $Y_v$ under the same threshold. Conversely, reveal an increasing grid from $1$ to $v$, including $v$, with largest spacing $\varepsilon$. Its actual reward is at most $Y_v+\varepsilon$: a successful sale occurs at a price between $X$ and $X+\varepsilon$, and failure pays $1$ in both models. Monotonicity and translation equivariance of $\mathcal R_\delta$ give the reverse bound after $\varepsilon\downarrow0$. Only finite sequences are used.

The reward formula of [1, Lemma 11] simplifies to

$$
\boxed{R(v)=1+\frac1h\int_0^{(F(v)-\delta)_+}(q(s)-1)\,ds.}
\tag{2.5}
$$

To see this directly, reward $1$ has at least the failure mass $1-F(v)$. If that mass is at least $h$, the lower-tail average is $1$. Otherwise, the remaining portion of the lowest $h$ mass consists of the bottom $F(v)-\delta$ quantile mass of $X$. This argument permits fractional inclusion of an atom and remains valid when $X$ has mass at $1$ or $v$.

### 2.2. The comparison inequality

Suppose $C_\delta(X)\le a$. For every $0<t\le1$,

$$
q(t)\le a\left[1+\frac1h\int_0^{(t-\delta)_+}(q(s)-1)\,ds\right].
\tag{2.6}
$$

If $q(t)=1$, this is immediate. Otherwise choose $1\le v<q(t)$. The generalized inverse definition gives $F(v)<t$. By (2.4), (2.5), and $q\ge1$,

$$
v\le aR(v)
\le a\left[1+\frac1h\int_0^{(t-\delta)_+}(q(s)-1)\,ds\right].
$$

Let $v\uparrow q(t)$. This proves (2.6) without the generally false identity $F(q(t))=t$.

We claim

$$
q(t)\le\phi_{a,\delta}(t),\qquad 0<t\le1.
\tag{2.7}
$$

For $\delta>0$, (2.6) first gives $q\le a$ on $(0,\delta]$. If (2.7) is known up to $k\delta$, every integral in (2.6) with $t\le(k+1)\delta$ uses only that established interval. Substitution into (2.1) proves the next step, and finitely many steps cover $[0,1]$.

For $\delta=0$, put $f=q-1$ and $H(t)=a-1+a\int_0^t f(s)\,ds$. Then $f\le H$, $H(0)=a-1$, and $H'\le aH$ almost everywhere. Thus $H(t)\le(a-1)e^{at}$, proving (2.7) also in this case.

At $v=\theta$, the independent terminal constraint is

$$
\theta\le a\left[1+\frac1h\int_0^h(q(s)-1)\,ds\right]
\le\phi_{a,\delta}(1).
\tag{2.8}
$$

It remains necessary when $X$ has support strictly below $\theta$; one must not substitute the unjustified condition $q(1)=\theta$.

For fixed $\delta$, $\phi_{a,\delta}(1)$ is continuous and strictly increasing on $a\ge1$, starts at $1$, and tends to infinity, as follows directly from (2.2). Hence (2.3) has a unique root and (2.8) gives $a\ge a_\delta$. Also, the $j=0,1$ terms show $\phi_{a,\delta}(1)\ge a^2$, so $a_\delta\le\sqrt\theta$.

### 2.3. Attainment by the known distribution

Write $g=\phi_{a_\delta,\delta}$. It is constant at $a_\delta$ on $[0,\delta]$, then strictly increases to $g(1)=\theta$. It is therefore a valid quantile. Below its smallest threshold, $R(v)=1$ and $v/R(v)<a_\delta$. For $v\ge a_\delta$, if $t=F(v)$, then $g(t)=v$, including the lower atom when $\delta>0$. Equations (2.1) and (2.5) give $R(v)=g(t)/a_\delta=v/a_\delta$. Thus this policy attains $a_\delta$, as already proved in [1]. Together with (2.8), this establishes the value over all threshold laws.

### 2.4. Arbitrary randomized online algorithms

Fix any admissible algorithm $A$ and integer $k\ge1$. Let $\varepsilon=(\theta-1)/k$ and $v_j=1+j\varepsilon$. Run $A$ on the full increasing grid $(v_0,\ldots,v_k)$ and couple all its prefixes using the same complete random tape. For each tape, define $X_k$ as the first grid price accepted; if none is accepted, set $X_k=\theta$. Pre-sampling the tape does not restrict adaptive randomization.

On every proper prefix ending at $v_j$, $j<k$, the reward $Y_{v_j}$ associated with $X_k$ agrees with $A$'s reward. At $j=k$ it can only be larger, on tapes on which $A$ never sells. Unknown horizon ensures identical behavior on identical prefixes. Therefore, writing $R_k$ for the benchmark CVaR,

$$
\frac{v_j}{R_k(v_j)}\le C_\delta(A),\qquad 0\le j\le k.
$$

Between consecutive grid points, the benchmark reward law is constant. Since $R_k\ge1$,

$$
\frac{v}{R_k(v)}\le\frac{v_j}{R_k(v_j)}+\varepsilon
\le C_\delta(A)+\varepsilon
\qquad(v_j\le v<v_{j+1}).
$$

Consequently $a_\delta\le C_\delta(X_k)\le C_\delta(A)+\varepsilon$. Let $k\to\infty$. This proves the general lower bound. It is the finite-grid reduction of [1, Appendix A.2], included explicitly to preserve the horizon and terminal conventions. It requires neither an infinite input nor convergence of the algorithm distributions.

At $\delta=1$, let $m=\operatorname{ess\,inf}X$ and $M=\operatorname{ess\,sup}X$. For every $v<M$, failure has positive probability, so $\mathcal R_1(Y_v)=1$. At $v=\theta$, it equals $m$. Thus

$$
C_1(X)\ge\max\{M,\theta/m\}\ge\sqrt\theta.
$$

Equality is attained by the deterministic threshold $\sqrt\theta$, and requires $m=M=\sqrt\theta$ among threshold laws. The same grid reduction applies to essential infima, completing Theorem 1.

## 3. Every optimal threshold law

For the remainder of this section, $0\le\delta<1$, $h=1-\delta$, $a=a_\delta$, and $g=\phi_{a,\delta}$.

**Theorem 2 (complete threshold classification).** A probability law on $[1,\theta]$ with generalized quantile $q$ is optimal if and only if

$$
q(t)\le g(t)\quad(0<t\le1),
\qquad
q(t)=g(t)\quad\text{for almost every }t\in(0,h).
\tag{3.1}
$$

In particular, the lower $h$ fraction is fixed. The remaining upper fraction may vary, subject to being a quantile and staying below $g$.

**Proof.** Necessity of $q\le g$ is (2.7). The terminal comparison (2.8), with $g(1)=\theta$, becomes

$$
\theta\le\theta-\frac ah\int_0^h(g(s)-q(s))\,ds.
$$

Its integrand is nonnegative, so the integral vanishes. This proves necessity.

For sufficiency, (2.5) and agreement on $(0,h)$ imply, for $s=F(v)$,

$$
R(v)=1+\frac1h\int_0^{(s-\delta)_+}(g(u)-1)\,du
=\frac{g(s)}a.
\tag{3.2}
$$

If $s<1$, choose $t>s$. Since $F(v)<t$, one has $v<q(t)\le g(t)$. Let $t\downarrow s$ and use continuity of $g$ to obtain $v\le g(s)$. This argument also handles $s=0$ and support gaps. If $s=1$, $v\le\theta=g(1)$. Equation (3.2) gives $v/R(v)\le a$ for every $v$, and Theorem 1 forces equality of the worst-case value. $\square$

**Corollary 3 (smallest upper endpoint).** The clipped quantile

$$
q_{\mathrm{clip}}(t)=g(\min\{t,h\})
\tag{3.3}
$$

is optimal and minimizes $\operatorname{ess\,sup}X$ among all optimal threshold laws. The minimum is $g(h)$, or $L g(h)$ before normalization.

**Proof.** The clipped function satisfies (3.1). Conversely, agreement with continuous $g$ almost everywhere on $(0,h)$ and monotonicity imply that every optimal quantile has upper endpoint at least $g(h)$. $\square$

If $0<\delta<1/2$, the clipped law has an atom of mass $\delta$ at its lower endpoint $a$ and another of mass $\delta$ at $g(h)$, with continuous probability mass $1-2\delta$ between them. For $\delta\ge1/2$, $h\le\delta$, so it collapses to the deterministic threshold $a=\sqrt\theta$. At $\delta=0$, (3.1) fixes the entire distribution: the classical quantile is unique up to null changes. At $\delta=1$, uniqueness among threshold laws follows separately from Section 2.4.

The unmodified profile $g$ and its clipped counterpart are distinct optimizers whenever $0<\delta<1$. Thus the original construction is generally not the unique optimal threshold law. This does not assert uniqueness or nonuniqueness classifications for all history-dependent algorithms.

## 4. A quantitative deficit bound

**Theorem 4.** If a threshold law $q$ has $C_\delta(q)\le b$ for $0\le\delta<1$, then

$$
\boxed{0\le\int_0^h\bigl(\phi_{b,\delta}(s)-q(s)\bigr)\,ds
\le\frac hb\bigl(\phi_{b,\delta}(1)-\theta\bigr).}
\tag{4.1}
$$

**Proof.** The comparison lemma gives the nonnegative integrand. Subtract the terminal inequality (2.8) from the identity (2.1) for $\phi_{b,\delta}(1)$. $\square$

For fixed $\theta,\delta$, the right side is $O_{\theta,\delta}(b-a_\delta)$ as $b\downarrow a_\delta$, because the terminal profile is continuously differentiable in $b$. Since the profiles themselves vary continuously and differentiably in $b$ on compact intervals, (4.1) also gives

$$
\int_0^h|q(s)-g(s)|\,ds
=O_{\theta,\delta}(b-a_\delta).
\tag{4.2}
$$

For example, use $|q-g|\le(\phi_{b,\delta}-q)+(\phi_{b,\delta}-g)$, valid because both $q$ and $g$ lie below $\phi_{b,\delta}$. The result controls the portion of the quantile that determines terminal CVaR. It does not control the freely variable upper tail of optimal laws.

## 5. Dependence on risk and price range

The following consequences use the explicit profile already available in [1]; Theorem 1 identifies them as properties of the **optimal value**.

### 5.1. Strict increase and the known transition

For $j\ge2$, define

$$
f_j(\delta)=\left(\frac{(1-j\delta)_+}{1-\delta}\right)^j.
$$

Each is nonincreasing in $\delta$, and $f_2$ is strictly decreasing below $1/2$. The $j=0,1$ coefficients are constant. Thus, for fixed $b>1$, $\phi_{b,\delta}(1)$ strictly decreases for $0\le\delta<1/2$. Its unique root $a_\delta$ strictly increases on that interval. At $\delta\ge1/2$, (2.3) becomes $a_\delta^2=\theta$. Randomization therefore improves the optimum exactly when $\delta<1/2$, recovering the transition proved in [1].

### 5.2. The first small-risk coefficient

Let $a_0$ be the classical root $(a_0-1)e^{a_0}=\theta-1$. Then

$$
\boxed{a_\delta=a_0+a_0(a_0-1)\delta+O_\theta(\delta^2),
\qquad\delta\downarrow0.}
\tag{5.1}
$$

We justify the moving cutoff in (2.3). Set $f_0=f_1=1$. For $j\ge2$, $f_j$ is continuously differentiable on $[0,1/2]$, its derivative is absolutely continuous, and, away from the cutoff,

$$
f_j'(\delta)=-j(j-1)(1-j\delta)^{j-1}(1-\delta)^{-j-1}
$$

where $\delta<1/j$, while it vanishes afterwards. Direct differentiation gives the bound
$|f_j''(\delta)|\le2^{j+3}j^4$ almost everywhere on $[0,1/2]$. Therefore

$$
|f_j(\delta)-1+j(j-1)\delta|
\le2^{j+2}j^4\delta^2.
\tag{5.2}
$$

For every fixed $B$, the sum $\sum_j B^j2^{j+2}j^4/j!$ is finite. Summing (5.2) uniformly for $b\in[1,B]$ gives

$$
\sum_{j\ge0}\frac{b^j}{j!}f_j(\delta)
=e^b-b^2e^b\delta+O_B(\delta^2).
$$

Take $B=\sqrt\theta$. Since the derivative in $b$ of the terminal function is at least $1$, this first gives $a_\delta-a_0=O_\theta(\delta)$. Taylor expansion at $(a_0,0)$, whose derivative in $b$ is $a_0e^{a_0}$, then yields (5.1). The remainder is for fixed $\theta$.

### 5.3. Quadratic disappearance of the randomization gain

For $1/3\le\delta\le1/2$, only $j=0,1,2$ contribute, giving

$$
\theta=a_\delta^2\left[1+(a_\delta-1)
\frac{(1-2\delta)^2}{2(1-\delta)^2}\right].
\tag{5.3}
$$

Put $r=\sqrt\theta$ and $\varepsilon=1/2-\delta$. Rearranging gives the exact identity

$$
r-a_\delta=\frac{8a_\delta^2(a_\delta-1)}{r+a_\delta}
\frac{\varepsilon^2}{(1+2\varepsilon)^2}.
$$

The prefactor is bounded, so $a_\delta=r+O_\theta(\varepsilon^2)$. Substitution back gives

$$
\boxed{a_\delta=\sqrt\theta
-4\sqrt\theta(\sqrt\theta-1)(1/2-\delta)^2
+O_\theta((1/2-\delta)^3).}
\tag{5.4}
$$

For $\delta\ge1/2$ the value is exactly $\sqrt\theta$. The location of the transition is known; (5.4) specifies the exact quadratic coefficient as the gain disappears.

### 5.4. Power-law exponents for a large price range

Fix $0<\delta<1$ and let

$$
m=\lceil1/\delta\rceil-1.
$$

Then $m\ge1$ and $1-m\delta>0$. The terminal polynomial in (2.3) has degree $m+1$, with positive leading coefficient

$$
c_m=\frac{(1-m\delta)^m}{(1-\delta)^m m!}.
$$

As $\theta\to\infty$, its root tends to infinity. Dividing the polynomial by its leading term proves

$$
\boxed{a_\delta(\theta)\sim
\left[\frac{m!(1-\delta)^m}{(1-m\delta)^m}\right]^{1/(m+1)}
\theta^{1/(m+1)}.}
\tag{5.5}
$$

Thus fixed positive risk gives a sequence of exponents determined by $\lceil1/\delta\rceil$, while zero risk has the classical logarithmic scale. At reciprocal values of $\delta$, the vanishing highest-degree term must be omitted; this is why $m$ is defined with the ceiling. The asymptotic is not uniform as $\delta$ approaches a reciprocal boundary or zero. It is an exact-optimum consequence of the prior polynomial profile, not a separate algorithmic construction.

## 6. Verification and scope

The computational programs and raw outputs are not included in this version.

The proofs above are analytic. Computational checks accompanying the case concern exact rational profile identities, certified root brackets at selected rational parameters, atomic distributions, and finite-grid comparisons. They cannot prove the claims for every probability law or every online algorithm; those quantifiers are addressed by Sections 2–4.

For $\theta=100$, selected values are shown below. The displayed decimals are rounded; the certificate file supplies rational enclosures of width less than $10^{-19}$.

| Risk level $\delta$ | Exact optimum, displayed numerically |
| --- | ---: |
| $0$ | 3.6286495970 |
| $1/10$ | 4.6558686720 |
| $1/4$ | 6.4266491394 |
| $2/5$ | 8.4156163627 |
| $49/100$ | 9.9657069811 |
| $1/2$ through $1$ | 10 exactly |

The reduction critically fixes three conventions: the horizon is not announced, the terminal fallback is $L$, and CVaR is evaluated over algorithmic randomness on each fixed input. Altering these conventions, adding forecasts, or allowing multiple sales creates different problems. The threshold classification does not classify all optimal history-dependent algorithms. Neither external peer review nor an end-to-end formal proof is asserted.

## References

[1] Nicolas Christianson, Bo Sun, Steven Low, and Adam Wierman. **Risk-Sensitive Online Algorithms.** arXiv:2405.09859v2, 24 May 2024. COLT 2024 extended abstract, PMLR 247:1140–1141. [Versioned full text](https://arxiv.org/html/2405.09859v2); [proceedings record](https://proceedings.mlr.press/v247/christianson24a.html).

[2] Spyros Angelopoulos, Christoph Dürr, and Georgii Melidi. **Decision-Theoretic Approaches for Improved Learning-Augmented Algorithms.** arXiv:2501.17701v2, 15 September 2025; corresponding ICLR 2026 work. [Versioned full text](https://arxiv.org/html/2501.17701v2); [conference record](https://openreview.net/forum?id=XGEZ9q02Ys).

[3] Ziyad Benomar, Lorenzo Croissant, Vianney Perchet, and Spyros Angelopoulos. **Pareto-Optimality, Smoothness, and Stochasticity in Learning-Augmented One-Max-Search.** ICML 2025, PMLR 267:3776–3805. [Proceedings record](https://proceedings.mlr.press/v267/benomar25a.html); [published paper](https://raw.githubusercontent.com/mlresearch/v267/main/assets/benomar25a/benomar25a.pdf).

[4] Sizhe Li, Nicolas Christianson, and Tongxin Li. **Prediction-Specific Design of Learning-Augmented Algorithms.** arXiv:2510.14887v1, 16 October 2025; POMACS 10(1), Article 18, 2026. The comparison here uses the named arXiv version. [Versioned full text](https://arxiv.org/html/2510.14887v1); [published DOI](https://doi.org/10.1145/3788100).
