# Exact CVaR-competitive one-max search at every risk level


## Abstract {.unnumbered}

One-max search asks an online algorithm to sell one item after observing an adversarial sequence of prices in a known positive interval. Christianson, Sun, Low and Wierman introduced a competitive ratio based on the lower-tail conditional value-at-risk of the algorithm's reward and constructed a threshold algorithm through a delay differential equation. They proved asymptotic optimality at vanishing risk and determined the deterministic phase, while leaving the exact optimum across all risk levels open. We prove that their algorithm is minimax optimal for every risk level. The lower bound applies to arbitrary randomized online algorithms, including horizon-aware policies evaluated uniformly over all finite horizons. Its main ingredient is an integral upper bound on every feasible threshold quantile, with atoms and gaps allowed. An explicit finite-grid argument extends this bound to all online policies without a limit of probability measures. The optimum is the unique root of a finite polynomial at every positive risk level below one, and of the familiar exponential equation at risk zero. We also determine the first-order small-risk correction and the quadratic approach to the deterministic phase. An explicit risk-and-price transformation connects the same optimum to the more recent exact theorem for static zero-fallback posted pricing.

## Problem, scope and attribution

Let $0<L\le U$ be known. A finite sequence of prices in $[L,U]$ is presented online. The algorithm may accept one price irrevocably. If it accepts none, its compulsory terminal payoff is $L$, as in [1]. The offline optimum is the maximum price. Dividing every price by $L$, we work on $[1,\theta]$, where $\theta=U/L$. The same result also holds under the forced-last-price convention: the upper-bound proof only requires a terminal payoff of at least $L$, while every hard input in our lower bound ends with $L$.

For a bounded random reward $Y$, let $Q_Y$ denote its generalized quantile. For $0\le \delta<1$, define the lower-tail reward functional

\[
\mathcal R_\delta(Y)
 =\frac{1}{1-\delta}\int_0^{1-\delta}Q_Y(s)\,ds,
\qquad
\mathcal R_1(Y)=\operatorname{ess\,inf}Y.
\tag{1.1}
\]

Thus the worst $1-\delta$ fraction of rewards is averaged. For an online algorithm $A$, its competitive ratio is

\[
C_\delta(A)
 =\sup_I\frac{\max I}{\mathcal R_\delta(A(I))},
\qquad
c_\delta(\theta)=\inf_A C_\delta(A),
\tag{1.2}
\]

where the supremum ranges over all finite price sequences. The randomness in (1.1) is the algorithm's internal randomness. There is no distributional assumption or prediction about the input. The adversary does not observe the realized random seed. In the horizon-aware extension, the policy may depend on the announced length $T$, but the competitive guarantee is still uniform over every finite $T$. We do not assert the same minimax value for each fixed small horizon; the case $T=1$, for example, has value 1.

This is the one-max-search problem of [1, Sections 2.3 and 5]. That paper's Lemma 11 gives the quantile identity used below; its Theorem 12 constructs the delay-equation threshold policy. Its equation (7) gives the corresponding finite series. Those ingredients, the risk-neutral value and the transition at $\delta=1/2$ are prior results. Section 6(a) of [1] leaves the exact all-risk optimum open. Our contribution is a matching lower bound for every policy and the resulting exact characterization; we do not claim a new threshold construction. The increasing-grid prefix argument in Section 4 refines the argument of [1, Appendix A.2] by using equal-length inputs and retaining an explicit mesh error. The step that closes the gap is the quantile envelope for the positive-fallback payoff, valid for arbitrary probability laws, together with its terminal constraint at the actual maximum price.

A close methodological precedent is Nekouyan, Sun, Boutaba and Tan [2, Theorem 2 and Appendices C.1, C.3], who characterize optimal fully static posted pricing with zero welfare from unsold units. Their analysis already uses inverse quantiles, a monotone integral comparison and a delay equation. Section 7 gives an explicit transformation of risk, prices and probability mass that connects their static theorem to the positive-fallback problem here; combined with the finite-grid passage, it yields the same minimax value. We therefore claim neither the general quantile/delay-equation/comparison methodology nor its standard Gronwall form as new. Our contribution is the direct proof for the original one-max model, its treatment of atoms and arbitrary policies, the explicit finite-input obstruction, and the stated connection and corollaries.

All results concern the finite-price-interval, one-item, lower-tail-CVaR model just defined. They do not assert analogous bounds for multiple sales, input-distribution CVaR, prediction-based objectives or an adversary that sees the algorithm's realized randomness.

## Exact optimal value

Write $q=1-\delta$. For $a\ge 1$ and $0\le t\le 1$, define

\[
E_{a,\delta}(t)=
\begin{cases}
e^{at},&\delta=0,\\[2mm]
1+\displaystyle\sum_{j=1}^{\lfloor1/\delta\rfloor}
\frac{a^j(t-j\delta)_+^j}{(1-\delta)^j j!},&0<\delta<1,
\end{cases}
\tag{2.1}
\]

where $x_+=\max\{x,0\}$. Terms with $t=j \delta$ are zero. Put

\[
\phi_{a,\delta}(t)=1+(a-1)E_{a,\delta}(t),
\qquad
H_\delta(a)=\phi_{a,\delta}(1).
\tag{2.2}
\]

**Theorem 2.1 (exact minimax value).** Suppose $\theta>1$. For every $0\le \delta<1$, the optimal competitive ratio over all randomized online algorithms is the unique $a>1$ satisfying

\[
\boxed{\theta=H_\delta(a).}\tag{2.3}
\]

An optimal policy draws $S$ uniformly on $[0,1]$, sets $X=\phi_{a,\delta}(S)$, and accepts the first price at least $X$. The lower bound also holds for horizon-aware policies with the uniform-over-horizons guarantee specified in Section 1. At $\delta=1$, the optimum is $\sqrt{\theta}$, achieved by that deterministic threshold. For $\theta=1$, the optimum is 1 for every $\delta$.

For positive $\delta$, equation (2.3) is a finite polynomial equation. Its specification is unambiguous: $H_\delta$ is continuous and strictly increasing for $a\ge 1$, equals 1 at $a=1$, and diverges as $a$ increases. These facts follow directly from its nonnegative coefficients and the factor $a-1$ in (2.2).

The next three sections prove the theorem. No regularity condition is imposed on a competing threshold law, and the general lower bound does not assume that an arbitrary online policy has a globally equivalent threshold representation.

## Quantile identity and comparison principle

Let $X$ be any random variable supported on $[1,\theta]$, with CDF $F$ and generalized quantile

\[
Q(t)=\inf\{x:F(x)\ge t\},\qquad 0<t\le1.
\]

The value at zero is irrelevant to all integrals. For a maximum price $v$, define the threshold payoff

\[
Z_v=X\mathbf1_{\{X\le v\}}+\mathbf1_{\{X>v\}}.
\]

### Lemma 3.1 (quantile formula, including atoms) {.unnumbered}

For $0\le \delta<1$,

\[
\mathcal R_\delta(Z_v)
 =1+\frac1q\int_0^{(F(v)-\delta)_+}(Q(s)-1)\,ds.
\tag{3.1}
\]

**Proof.** The reward distribution has fallback mass $1-F(v)$ at 1. Its remaining mass consists of the lowest $F(v)$ quantiles of $X$. If the fallback mass is at least $q$, the lower-tail reward is 1. Otherwise, the bottom $q$ mass contains all the fallback mass and the lowest $F(v)-\delta$ quantiles of $X$. Its unnormalized integral is

\[
1-F(v)+\int_0^{F(v)-\delta}Q(s)\,ds.
\]

Subtracting and adding the baseline contribution gives (3.1). This argument permits atoms: the quantile integral includes the required fraction of an atom. It also permits support gaps and atoms at 1. This is [1, Lemma 11] in a baseline-subtracted form. ∎

Direct integration of the series in (2.1) gives

\[
\phi_{a,\delta}(t)
 =a+\frac a q\int_0^{(t-\delta)_+}
    (\phi_{a,\delta}(s)-1)\,ds.
\tag{3.2}
\]

For $\delta=0$, the same identity follows from the exponential expression. For $\delta>0$, $\phi=a$ on $[0,\delta]$; when $a>1$, it is strictly increasing thereafter. Differentiating (3.2) beyond the initial interval recovers the delay equation in [1, Theorem 12].

For a mesh parameter $h\ge 0$, set

\[
\psi_{a,h,\delta}(t)=1+(a+h-1)E_{a,\delta}(t).
\]

It satisfies

\[
\psi(t)=a+h+\frac a q\int_0^{(t-\delta)_+}(\psi(s)-1)\,ds.
\tag{3.3}
\]

### Lemma 3.2 (quantile envelope) {.unnumbered}

If a bounded measurable $Q:[0,1]\to [1,\infty)$ satisfies

\[
Q(t)\le a+h+\frac a q\int_0^{(t-\delta)_+}(Q(s)-1)\,ds,
\tag{3.4}
\]

then $Q(t)\le \psi_{a,h,\delta}(t)$ wherever (3.4) holds, provided it holds almost everywhere elsewhere.

**Proof.** For $\delta>0$, first use the constant bound on $[0,\delta]$, then apply (3.4) successively on intervals of length $\delta$. The integral at each new interval only involves already controlled values. For $\delta=0$, subtract (3.3), let $D=(Q-\psi)_+$ and $B(t)=\int_0^t D(s)\,ds$. Then $D(t)\le a B(t)$ and $B'(t)\le a B(t)$ almost everywhere. Since $B(0)=0$, the nonnegative absolutely continuous function $e^{-at}B(t)$ is nonincreasing and therefore vanishes. Substitution in (3.4) gives the pointwise conclusion. ∎

The envelope is useful without continuity assumptions. Suppose a threshold distribution obeys $v\le a\mathcal R_\delta(Z_v)$ for every $v$. For any $v<Q(t)$, the quantile definition implies $F(v)<t$. Formula (3.1) and its nonnegative integrand imply

\[
v\le a+\frac a q\int_0^{(t-\delta)_+}(Q(s)-1)\,ds.
\]

Letting $v$ tend to $Q(t)$ from below yields (3.4) with $h=0$; the case $Q(t)=1$ is immediate. Thus $Q\le \phi$. Crucially, at the actual maximum allowed price,

\[
\theta\le a+\frac a q\int_0^q(Q(s)-1)ds
\le\phi_{a,\delta}(1).
\tag{3.5}
\]

This terminal condition uses $\theta$, not the top of the threshold support. It remains valid even when that support ends strictly below $\theta$.

## Universal lower bound through finite inputs

We now refine the increasing-grid prefix construction of [1, Appendix A.2] to prove the lower bound for every online algorithm. Padding all prefixes to the same length handles announced horizons, and keeping the mesh error avoids a probability-measure limit. The new quantile envelope then gives the following finite obstruction.

### Proposition 4.1 (finite-grid obstruction) {.unnumbered}

Fix $\theta>1$, $0\le \delta<1$ and $a\ge 1$. If an online algorithm is $a$-competitive on every input, then, for every positive integer $N$ and $h=(\theta-1)/N$,

\[
\boxed{\theta\le H_\delta(a)+h\big(E_{a,\delta}(1)-1\big).}\tag{4.1}
\]

**Proof.** Define $v_i=1+i h$ for $i=0,\ldots,N$. Consider the master input

\[
(v_0,v_1,\ldots,v_N,1).
\]

For each $i$, take its prefix through $v_i$ and append enough 1s to obtain the common length $N+2$. Call this input $I_i$. These are valid oblivious inputs with maximum $v_i$. Their common length also makes the argument valid for a policy informed of that horizon.

Fix a random seed, coupling the algorithm's decisions on identical prefixes. Let $X_N$ be the first grid price it accepts on the master input. If it accepts none of the grid prices, replace that outcome by $X_N=\theta$. On $I_i$, an acceptance on the grid at or before $i$ gives exactly that accepted price. Otherwise the reward is 1. The replacement of never-accepted outcomes by threshold $\theta$ changes nothing for $i<N$ and can only improve the reward for $i=N$. Hence, in this coupling,

\[
A(I_i)\le X_N\mathbf1_{\{X_N\le v_i\}}+
\mathbf1_{\{X_N>v_i\}}=:Z^{(N)}_{v_i}.
\]

The lower-tail reward is monotone under pointwise domination. The competitive guarantee therefore implies

\[
v_i\le a\mathcal R_\delta(Z^{(N)}_{v_i})
\quad (0\le i\le N).
\tag{4.2}
\]

Let $Q_N$ and $F_N$ be the quantile and CDF of $X_N$. If $Q_N(t)>1$, its grid predecessor $v=Q_N(t)-h$ satisfies $F_N(v)<t$. Applying (4.2), then (3.1), gives

\[
Q_N(t)\le h+a+\frac a q
\int_0^{(t-\delta)_+}(Q_N(s)-1)\,ds.
\tag{4.3}
\]

If $Q_N(t)=1$, this inequality holds automatically. Lemma 3.2 implies $Q_N\le \psi_{a,h,\delta}$. Applying (4.2) at $v_N=\theta$ and then (3.3),

\[
\begin{aligned}
\theta
&\le a+\frac a q\int_0^q(Q_N(s)-1)ds\\
&\le a+\frac a q\int_0^q(\psi_{a,h,\delta}(s)-1)ds\\
&=\psi_{a,h,\delta}(1)-h\\
&=H_\delta(a)+h(E_{a,\delta}(1)-1).
\end{aligned}
\]

This is (4.1). ∎

Letting $N$ tend to infinity in (4.1) gives $\theta\le H_\delta(a)$. Its strict monotonicity shows that every algorithm has competitive ratio at least the root (2.3). Only a scalar mesh tends to zero; the argument does not take a limit of threshold distributions or interchange CVaR with weak convergence.

There is also a finite certificate of infeasibility for every $a$ below the root. Since $H_\delta(a)<\theta$, choose $N$ so large that

\[
h<\frac{\theta-H_\delta(a)}{E_{a,\delta}(1)-1}.
\tag{4.4}
\]

At least one of the finitely many inputs $I_i$ then violates $a$-competitiveness. For rational $a,\delta,\theta$ with $\delta>0$, this bound involves only rational arithmetic. The violating input may depend on the algorithm's distribution, but not on its realized random seed; the adversary remains oblivious.

## Attainment and endpoints

Choose the root $a$ in (2.3) and the threshold $X=\phi_{a,\delta}(S)$ of Theorem 2.1. The function $\phi$ is a valid quantile, starts at $a$, ends at $\theta$, and is constant on $[0,\delta]$. Thus the distribution has an atom of mass $\delta$ at $a$, followed by a continuous increasing quantile. At $\delta=0$ there is no such atom.

For $1\le v<a$, the payoff $Z_v$ equals 1. At $v=a$, the threshold CDF satisfies $F(a)=\delta$ and (3.1) again gives lower-tail reward 1. For $a<v\le \theta$, there is a unique $t\in(\delta,1]$ with $v=\phi(t)$, and $F(v)=t$. Consequently,

\[
\mathcal R_\delta(Z_v)
 =1+\frac1q\int_0^{t-\delta}(\phi(s)-1)ds
 =\frac{\phi(t)}a=\frac va.
\tag{5.1}
\]

On any actual input with maximum $v$, whenever $X\le v$ the first accepted price is at least $X$; otherwise the reward is at least 1. Its payoff therefore dominates $Z_v$. This proves ratio at most $a$, matching Section 4.

If $\theta=1$, every payoff is 1. For $1/2\le \delta<1$, only the constant and linear terms of (2.1) contribute at $t=1$, so $E(1)=1+a$ and $H_\delta(a)=a^2$. At $\delta=1$, monotonicity of the lower-tail reward in $\delta$ implies that every algorithm has ratio at least its ratio at $\delta=1/2$, and hence at least $\sqrt{\theta}$. The deterministic threshold $\sqrt{\theta}$ attains that value: before reaching the threshold the offline maximum is at most it, and after reaching it the accepted value is at least it. The proof of Theorem 2.1 is complete. ∎

## Exact regimes and asymptotics

### Corollary 6.1 (risk-neutral and deterministic values) {.unnumbered}

At $\delta=0$,

\[
c_0(\theta)=1+W_0\!\left(\frac{\theta-1}{e}\right).
\tag{6.1}
\]

For $\delta\ge 1/2$, $c_\delta(\theta)=\sqrt{\theta}$. For $\theta>1$ and $\delta<1/2$, the optimal value is strictly smaller than $\sqrt{\theta}$.

**Proof.** The first formula solves $\theta=1+(a-1)e^a$. The deterministic phase was established in Section 5. Below $1/2$, the quadratic term of (2.1) is positive, so $H_\delta(a)>a^2$ for $a>1$; at zero use $e^a>1+a$. ∎

The first two conclusions are known from [1] and are recovered here as endpoint checks. The exact formula fills the interval between those previously established cases.

### Corollary 6.2 (cubic regime and approach to the plateau) {.unnumbered}

For $1/3\le \delta<1/2$, the exact optimum is the unique $a>1$ satisfying

\[
\theta=a^2+
\frac{(1-2\delta)^2}{2(1-\delta)^2}a^2(a-1).
\tag{6.2}
\]

If $R=\sqrt{\theta}>1$ and $\varepsilon=1/2-\delta$ tends to zero from above, then

\[
R-c_\delta(\theta)
 =4R(R-1)\varepsilon^2+O_\theta(\varepsilon^3).
\tag{6.3}
\]

**Proof.** Only terms through $j=2$ contribute in (2.1). Write $b=(1-2\delta)^2/[2(1-\delta)^2]=8\varepsilon^2/(1+2\varepsilon)^2$. Equation (6.2) gives

\[
R-a=\frac{b\,a^2(a-1)}{R+a}.
\]

It first implies $R-a=O(\varepsilon^2)$, since $1<a\le R$. Substituting $a=R+O(\varepsilon^2)$ and $b=8\varepsilon^2+O(\varepsilon^3)$ gives (6.3). ∎

For example, $\delta=1/3$ and $\theta=9/2$ give the exact optimum 2. At $\delta=1/4$, equation (2.3) becomes

\[
\theta=1+(a-1)\left(1+a+\frac{2a^2}{9}+\frac{a^3}{162}\right),
\]

so $\theta=400/81$ again gives optimum 2.

### Corollary 6.3 (first small-risk correction) {.unnumbered}

For fixed $\theta>1$, let $a_0=c_0(\theta)$. Then

\[
c_\delta(\theta)
 =a_0+a_0(a_0-1)\delta+O_\theta(\delta^2)
 \qquad(\delta\downarrow0).
\tag{6.4}
\]

**Proof.** Write the sum in (2.1) at $t=1$ as an infinite series with zero positive-part terms. For $j\ge 1$, its coefficient is

\[
b_j(\delta)=\left(\frac{(1-j\delta)_+}{1-\delta}\right)^j.
\]

At zero, $b_j(0)=1$ and $b'_j(0)=-j(j-1)$. To control the remainder, fix $0<\epsilon<1$ and let $0\le\delta\le\epsilon$. On the positive branch, put $r=(1-j\delta)/(1-\delta)$. Then $0\le r\le1$ and

\[
r'=\frac{1-j}{(1-\delta)^2},\qquad
r''=\frac{2(1-j)}{(1-\delta)^3}.
\]

For $j\ge2$, differentiation yields, almost everywhere,

\[
\begin{aligned}
|b_j''(\delta)|
&\le j(j-1)|r'|^2+j|r''|\\
&\le\frac{j(j-1)^3}{(1-\epsilon)^4}
   +\frac{2j(j-1)}{(1-\epsilon)^3}
\le C_\epsilon j^4.
\end{aligned}
\]

At the cutoff $j\delta=1$, the first derivative is continuous for $j\ge2$ and is zero on the other branch. The bound therefore gives a Lipschitz first derivative and a uniform second-order Taylor remainder; the $j=1$ term is constant. In particular,

\[
\left|b_j(\delta)-1+j(j-1)\delta\right|
\le\tfrac12C_\epsilon j^4\delta^2.
\]

For $a$ in a fixed compact interval, the series $\sum_j a^j j^4/j!$ is uniformly summable. Thus the weighted series can be differentiated at zero and its remainder summed, giving

\[
E_{a,0}(1)=e^a,
\qquad
\left.\partial_\delta E_{a,\delta}(1)\right|_{\delta=0}
 =-a^2e^a.
\]

For $H_\delta(a)=1+(a-1)E_{a,\delta}(1)$, we have $\partial_a H_0(a)=a e^a>0$. Differentiating $H_\delta(c_\delta)=\theta$ at zero yields $c'_0=a_0(a_0-1)$, with the stated second-order remainder. ∎

## A risk transfer to zero-fallback posted pricing

The exact static-pricing theorem of [2] is connected to the present result by more than a methodological analogy. We give the transformation explicitly, both to identify that relationship and to separate the direct proof above from a claim of a new general technique.

In this section only, let $\mathcal C_q$ denote the lower-tail mean of mass $q$, so $\mathcal C_q=\mathcal R_{1-q}$. Superscripts $+$ and $0$ indicate ideal threshold rewards with fallback 1 and 0, respectively.

### Proposition 7.1 (risk and price transfer) {.unnumbered}

Suppose $1<a\le\theta$, $0<q\le1$, and a threshold law on $[1,\theta]$ satisfies $\mathcal C_q^+(X;v)\ge v/a$ for every $v\in[1,\theta]$. Define

\[
A=a+1,\qquad q_0=\frac{q(a+1)}{a+q},\qquad
w=\frac{q}{a+q},\qquad r=\frac{a}{a+q},\qquad
\Theta=\frac{\theta-1}{a-1}.
\tag{7.1}
\]

There is a zero-fallback static posted-price law on $[1,\Theta]$ that is $A$-competitive at tail mass $q_0$.

**Proof.** First replace $X$ by $\max\{X,a\}$. For $v<a$, its fallback reward 1 satisfies $1\ge v/a$; for $v\ge a$, its ideal payoff only increases pointwise. Thus feasibility is preserved. Put $\delta=1-q$. The raised law must satisfy $F_X(a)\ge\delta$. Otherwise, when $a<\theta$, right continuity gives a price $v>a$ with $F_X(v)<\delta$, whose lower-tail reward is 1 and violates feasibility. If $a=\theta$, the raised law is concentrated at $a$.

Draw $P=1$ with probability $w$ and draw $(X-1)/(a-1)$ with probability $r$. Since $w+r=1$, this is a valid law. For $u\in[1,\Theta]$, set $v=1+(a-1)u$. We have

\[
F_P(u)=w+rF_X(v),\qquad
1-q_0=r\delta,\qquad \frac{w}{q_0}=\frac1A.
\]

Because $F_X(v)\ge\delta$, the lower tail of the zero-fallback reward includes the whole added mass $w$ at price 1, followed by the lowest $F_X(v)-\delta$ quantiles of the transformed law. Extra atoms at 1 cause no difficulty. Direct integration gives

\[
\begin{aligned}
\mathcal C_{q_0}^{0}(P;u)
&=\frac1{q_0}\left[w+\frac r{a-1}
\int_0^{F_X(v)-\delta}(Q_X(s)-1)ds\right]\\
&=\frac{a\,\mathcal C_q^+(X;v)-1}{A(a-1)}
\ge\frac uA.
\end{aligned}
\tag{7.2}
\]

An actual static posted-price policy obtains welfare at least its ideal threshold payoff whenever it sells, and zero otherwise. This proves the claim for the one-item case of [2]. ∎

For the parameters in (7.1), the initial constant segment in [2, Theorem 2] ends at

\[
b=1-q_0+q_0/A=r\delta+w.
\]

Its delay is $1-q_0=r\delta$, its coefficient is $A/q_0$, and $1-b=rq$. Thus its terminal series becomes

\[
\begin{aligned}
1+\sum_{j\ge1}\frac{(A/q_0)^j}{j!}
\bigl(1-b-(j-1)(1-q_0)\bigr)_+^j
&=1+\sum_{j\ge1}\frac{(a/q)^j}{j!}(1-j\delta)_+^j\\
&=E_{a,\delta}(1).
\end{aligned}
\tag{7.3}
\]

At $q_0=1$, the zero-delay series is interpreted as the exponential, equivalently using the risk-neutral case [2, Theorem 1]. The source's exact static optimum therefore implies $\Theta\le E_{a,\delta}(1)$, or equivalently $\theta\le H_\delta(a)$. Hence our main threshold lower bound can also be derived from [2] through Proposition 7.1.

For an arbitrary original online algorithm with ratio at most $a$, the grid law from Section 4 obeys the same guarantee at grid maxima. Between consecutive grid prices, its ideal payoff distribution is unchanged, and $v/v_i\le1+h$ because $v_i\ge1$. It is therefore $a_h=a(1+h)$-competitive for continuous maxima. When $a<\theta$, sufficiently fine meshes have $a_h\le\theta$, so the transfer and [2] give $\theta\le H_\delta(a_h)$; continuity and $h\to0$ recover the universal lower bound. Ratios $a\ge\theta$ cannot improve the desired optimum. The direct argument in Section 4 remains self-contained and gives the sharper additive mesh certificate (4.1).

## Interpretation and verification boundary

The delay-equation algorithm was already known from [1]. The exact static theorem [2] also gives the same value after the transfer in Section 7. The self-contained quantile envelope above supplies a direct lower bound for the original positive-fallback model: an algorithm cannot place too much probability at high thresholds without losing on a lower maximum, and these restrictions propagate through the integral equation. The top-price instance then turns the pointwise envelope into the exact minimax condition.

The finite-grid proof is also constructive at the level of impossibility certificates. A proposed ratio strictly better than (2.3) is excluded by finitely many explicit common-horizon inputs, with an explicit mesh bound. This distinction matters because merely comparing smooth threshold densities would leave atomic policies and general adaptive stopping rules untreated.

The proof is analytic and covers all values in the stated model. Finite computations can check polynomial identities, rational examples, atomic distributions and the mesh certificate, but do not replace the universal proof. This manuscript does not claim external peer review, formal verification or global-priority certification. The accompanying novelty and review records must separately document those checks.

### Computational illustration {.unnumbered}

Figure 1 shows the exact value and the historical lower bound [1, Theorem 13] for $\theta=100$. The original algorithm curve [1, Theorem 12] is now the proved optimum. The right panel illustrates the quadratic expansion (6.3). These are floating-point illustrations; the accompanying exact certificate file separately records rational root brackets and finite adversarial obstructions.

*Figure: Exact minimax curve and quadratic approach to the deterministic phase.*{width=100%}

## References {.unnumbered}

[1] Nicolas Christianson, Bo Sun, Steven Low, and Adam Wierman. *Risk-Sensitive Online Algorithms*. arXiv:2405.09859v2, 24 May 2024. Full author manuscript: https://arxiv.org/html/2405.09859v2 . The extended abstract appeared in *Proceedings of the Thirty-Seventh Conference on Learning Theory*, PMLR 247:1140–1141, 2024: https://proceedings.mlr.press/v247/christianson24a.html . Relevant locations: Sections 2.3, 5 and 6(a); Lemma 11; Theorems 12 and 13; equation (7); Appendix A.2.

[2] Hossein Nekouyan, Bo Sun, Raouf Boutaba, and Xiaoqi Tan. *Risk-Sensitive Online Selection with Bounded Adaptivity*. arXiv:2512.02427v2, 12 May 2026. https://arxiv.org/html/2512.02427v2 . Relevant locations: Section 2; Theorem 2; Appendices C.1 and C.3.
