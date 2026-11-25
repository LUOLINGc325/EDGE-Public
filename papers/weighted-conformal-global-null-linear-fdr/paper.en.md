# A linear finite-sample bound for the global-null FDR of weighted conformal BH

## Abstract

For Benjamini–Hochberg (BH) applied to randomized weighted split-conformal p-values, a shared calibration sample can make the false discovery rate (FDR) exceed the nominal level. Under the global null and independent test units, we prove that the relative excess is at most $C(q)mB/(n+1)$, where $n$ is the calibration size, $m$ the number of tests, $B$ the weight ratio bound, and $C(q)$ depends only on the testing level. This answers the linear upper-bound question in Lim (2026), Remark 18 and Section 7, for arbitrary score laws including atoms. The proof localizes atypical calibration to each BH threshold. It also gives an explicit bound, uniform in $m$, for the binomial series in Lim's Theorem 78.

## 1. Setup and results

Let $n,m \ge 1$ and $0<q<1$. Let the calibration units be i.i.d. from $P$; let the test units be i.i.d. from $Q$, independent of the calibration units. The known weight $w$ satisfies $1 \le w \le B$ after a common rescaling and $dQ/dP = w/E_P w$. An independent preliminary fit can be conditioned upon throughout. Fix a measurable real score $V$. Write $S=\sum_i w_i$, $S_{<}(v)=\sum_i w_i 1\{V_i<v\}$, and $S_{=}(v)=\sum_i w_i 1\{V_i=v\}$, where the sums are over calibration units. For a test unit with observed score $v_j$, weight $w_j$, and auxiliary $U_j \sim \operatorname{Unif}[0,1]$, its randomized p-value is

$$p_j=\frac{S_{<}(v_j)+U_j\,[S_{=}(v_j)+w_j]}{S+w_j}. \tag{1}$$

The auxiliaries are i.i.d. and independent of all units. For an oracle-null p-value $p_j^*$, take $v_j=V(Z_j)$ where $Z_j\sim Q$. More generally, when every null is true, take any reported p-values satisfying $p_j\ge p_j^*$ coordinatewise. In the selective-inference setup of Jin and Candès (2026) this comparison follows from the null inequality and the stipulated score monotonicity. In the global null the FDR equals the probability that BH rejects at least one hypothesis, so it suffices throughout to upper bound the oracle FDR. Write $t_k=qk/m$ for the BH grid, $\tau=B/(n+1)$, $\kappa=B/n$, and $\bar{B}=\operatorname{ess\,sup}_P(w)/E_P w \le B$.

**Theorem 1 (finite-sample linear rate).** For each $0<q<1$ there is a finite, explicit $C(q)$ such that, for every $n,m,B$ and every score law and weight as above,

$$\mathrm{FDR}\le q\Bigl[1+C(q)\frac{mB}{n+1}\Bigr]. \tag{2}$$

**Theorem 2 (explicit calibration bound).** For $m\ge 2$, choose $\rho >1+\kappa$ with $\alpha=\rho q<1$, put $\delta=\rho m\tau$, and define

$$
A(\alpha,\delta)=\frac{\exp(2(1-\alpha)+\delta(1/\alpha-1))}{(1-\alpha e^{1-\alpha})^2},\qquad
a=\frac{nq(\rho-1-\kappa)^2}{2\bar{B}m(3\rho-2-2\kappa)}.
$$

Then

$$
\frac{\mathrm{FDR}}q
\le 1+2(m-1)\tau\,A(\alpha,\delta)+(\exp(a)-1)^{-2}. \tag{3}
$$

The last term depends on the scale $n/(m\bar{B})$ through $a$. The bound (2) matches the order of the linear-in-$m$ excess exhibited by Lim's Poisson-window examples in their stated sequential limit.

## 2. A window bound with marginal uniformity

For a vector $y$ of length $m-1$, set

$$ R^0(y)=\max\{ k\colon 1+\#\{i:y_i\le t_k\}\ge k\}. $$

The maximum is at least one. If the designated p-value is replaced by zero and the resulting count is $r$, the designated unit is rejected in the actual run iff its p-value is at most $t_r$, and the actual count then equals $r$. Indeed, if the p-value is at most $t_r$, feasibility at $r$ is preserved and no larger count can become feasible by increasing a p-value. If the unit is rejected in the actual run, replacing it with zero leaves the feasibility of every count at least as large as the actual count unchanged.

To describe the augmented sample, take an ordered pool of $n+1$ points with law tilted relative to $P^{n+1}$ by $\sum_i w_i / ((n+1)E_Pw)$. Given the pool, draw index $i$ with probability $w_i / \sum_i w_i$. Use that point as test unit $j$, and all other pool points as calibration. For each possible index the joint density relative to $P^{n+1}$ before normalizing that index is $w_i/((n+1)E_Pw)$. Moving that point to the designated test slot and retaining the order of the others therefore gives precisely the original independent $P^n$ calibration and $Q$ test law. The other test units and all auxiliaries can be drawn independently of this construction.

Conditional on the pool and other test units and their auxiliaries, $p_j^*$ is uniform. Each distinct score in the pool specifies an interval whose length is its group's total weight divided by the pool weight, and whose left endpoint is the fraction of pool weight at smaller scores. Formula (1) gives a uniform draw in that interval for each index in its group. The group selection probability equals the interval length. In particular, every oracle p-value is marginally uniform.

Across two choices of the designated index, the other p-values differ by at most $\tau$ coordinatewise. For one other p-value, the common portion in (1) consists of $n-1$ calibration points plus the other test unit's own term. It has total weight at least $n$. Each of the two possible values is a mixture of the same common average with one calibration contribution in $[0,1]$. Their difference is at most the larger mixing proportion, which is at most $B/(n+B)\le \tau$. For the mixture inequality, if the proportions are $a\ge b$, the difference has the form $a h-b k-(a-b)c$ with $h,k,c\in [0,1]$, so it lies in $[-a,a]$.

Given the pool and the other units and auxiliaries, let $r_{\mathrm{low}},r_{\mathrm{high}}$ be the minimum and maximum possible values of $R^0$ over all choices of the designated index. The designated contribution to $1\{R>0\}$, computed as its rejection indicator divided by the number of rejections when it is rejected, is at most $1\{p_j^*\le t_{r_{\mathrm{high}}}\}/r_{\mathrm{low}}$. Its conditional expectation is at most $(q/m)r_{\mathrm{high}}/r_{\mathrm{low}}$. If $x^{(j)}$ is the actual vector of the other p-values, the coordinatewise perturbation and monotonicity of $R^0$ give

$$
\frac{r_{\mathrm{high}}}{r_{\mathrm{low}}}\le
\frac{R^0(x^{(j)}-\tau)}{R^0(x^{(j)}+\tau)}.
$$

Set $I_k=(t_k-\tau,t_k+\tau]$. For a fixed $x$, write $r_-=R^0(x-\tau)$ and $r_+=R^0(x+\tau)$. If these counts differ then $k=r_-\ge 2$ is feasible for $x-\tau$ and infeasible for $x+\tau$. Thus the $(k-1)$-th order statistic $x_{(k-1)}$ lies in $I_k$, and the ratio minus one is at most $r_--1=k-1$. Summing over potential $k$ bounds the ratio minus one by $\sum_{k=2}^m (k-1) 1\{x_{(k-1)}\in I_k\}$. Therefore, using symmetry across $j$ in the oracle setting,

$$
\frac{\mathrm{FDR}}q-1\le
\sum_{k=2}^m (k-1)\Pr(x^{(1)}_{(k-1)}\in I_k). \tag{4}
$$

This is the oracle-global-null window inequality in Lim's Theorem 76. The proof above makes its use explicit for both atomic and non-atomic scores.

## 3. Concentration at a single threshold

Let $D$ denote the calibration sample and $G_D(b)=\Pr(p_j^*\le b|D)$. For $b\in (0,1)$ and $d>0$, write $s=b(1+\kappa)$. We use the single-threshold bound of Lim, Eq. (15):

$$
\Pr(G_D(b)>s+d)\le
\exp\Bigl(-\frac{nd^2}{2\bar{B}(s+3d)}\Bigr). \tag{5}
$$

Here is a proof that includes score atoms. The case $s+d\ge 1$ has zero probability. Otherwise choose a population quantile pair $(v_0,u_0)$ with $Q(V<v_0)+u_0 Q(V=v_0)=s+d$. Existence follows from the score quantile at mass $s+d$, with $u_0$ specifying the fraction of an atom if present. In lexicographic order of $(v,u)$, points below $(v_0,u_0)$ have total mass $s+d$ under $Q$ and an independent uniform auxiliary. The weighted empirical function $(S_{<}(v)+u S_{=}(v))/S$ is nondecreasing in that order. Formula (1) and $w_j/S\le \kappa$ imply that $p_j^*\le b$ entails empirical function value at most $s$. If the function at $(v_0,u_0)$ exceeds $s$, this entails $G_D(b)\le s+d$.

Put $\chi_i=1\{V_i<v_0\}+u_0 1\{V_i=v_0\}$ and $\eta_i=(w_i/E_Pw)(\chi_i-s)$. The empirical function at $(v_0,u_0)$ is at most $s$ exactly when $\sum_i \eta_i\le 0$. Write $\ell=s+d$. Changing measure gives $E_P\eta_i=d$. Since $\chi_i\in [0,1]$ with mean $\ell$ under $Q$,

$$
\mathrm{Var}_P(\eta_i)
\le \bar{B}\,E_Q[(\chi_i-s)^2]
\le \bar{B}[\ell(1-\ell)+d^2].
$$

Also $d-\eta_i\le d+\bar{B} s\le \bar{B}$, because $\bar{B}\ge 1$ and $s+d<1$. One-sided Bernstein for the independent centered variables $d-\eta_i$ gives a denominator $2 \bar{B}(\ell+d^2+d/3)$ in the exponent $-nd^2$ over that denominator. Since $\ell+d^2+d/3\le s+3d$ for $d\le 1$, this proves (5).

## 4. A per-threshold split and the uniform binomial bound

For each $k\ge 2$, set $b_k=t_k+\tau$, $H_k=\{G_D(b_k)\le \rho b_k\}$, and $W_k=\{x^{(1)}_{(k-1)}\in I_k\}$. On $W_k$, some coordinate lies in $I_k$ and at least $k-2$ of the remaining coordinates are at most $b_k$. Conditional on $D$, the coordinates are i.i.d. with CDF $G_D$. The union bound over the candidate coordinate, followed by monotonicity of the binomial tail on $H_k$, gives

$$
\Pr(W_k\cap H_k)
\le (m-1)\,E[G_D(I_k)]\,
\Pr\{ \mathrm{Bin}(m-2,\min(1,\rho b_k))\ge k-2\}.
$$

Marginal uniformity yields $E[G_D(I_k)]\le 2\tau$, including when the interval is clipped by an endpoint of $[0,1]$. On the complement, (5) at $b_k$ with $d=(\rho-1-\kappa)b_k$ gives

$$
\Pr(W_k\cap H_k^c)\le \Pr(H_k^c)\le e^{-ka}.
$$

Indeed $b_k\ge qk/m$; if $\rho b_k\ge 1$ the event is empty. Crucially, the split is made inside the sum in (4). Inserting each bound into (4) gives

$$
\frac{\mathrm{FDR}}q-1
\le 2(m-1)\tau\,\beta_m(\rho)+\sum_{k=2}^{\infty}(k-1)e^{-ka}
=2(m-1)\tau\,\beta_m(\rho)+(\exp(a)-1)^{-2},
$$

where $\beta_m(\rho)$ is exactly the binomial series in Lim's Theorem 78.

To bound that series, the relevant binomial variable $X_k$ has mean at most $\alpha k+\delta$, even with the success probability capped at one. For $\lambda >1$, exponential Markov and $1+z\le \exp(z)$ give

$$
\Pr(X_k\ge k-2)\le
\lambda^{2-k}\exp((\lambda-1)(\alpha k+\delta)).
$$

Set $\lambda=1/\alpha$. Then $r=\alpha \exp(1-\alpha)<1$ by the strict inequality $\log \alpha <\alpha-1$. The geometric sum $\sum_{k=2}^\infty (k-1)r^k=r^2/(1-r)^2$ proves

$$\beta_m(\rho)\le A(\alpha,\delta). \tag{6}$$

This proves (3) and in particular answers the separate majorant question. For any fixed $\alpha <1$ the bound is uniform in $m$ when $\delta$ is bounded. The proof does not require $\rho (q+m\tau)<1$, because the influence of $\delta$ is taken outside the geometric series.

## 5. Deduction of the all-regime bound

Set $\rho_0=(1+q)/(2q)$, $\alpha_0=(1+q)/2$, $x=mB/(n+1)$ and

$$
x_0=\min\{1,(\rho_0-1)/2\}, \qquad
c=\frac{q(\rho_0-1)^2}{16(3\rho_0-2)}.
$$

For $m\ge 2$ we have $\kappa \le x$. If $0<x\le x_0$ then $\rho_0-1-\kappa \ge (\rho_0-1)/2>0$, and $n/(\bar{B} m)\ge n/(Bm)=[n/(n+1)]/x\ge 1/(2x)$. Thus $a\ge c/x$ and $(\exp(a)-1)^{-2}\le x^2/c^2\le x_0 x/c^2$. Since $\delta \le \rho_0 x_0$, (3) proves (2) in this regime. If $x>x_0$, use $\mathrm{FDR}\le 1$. For $m=1$, marginal uniformity and domination give $\mathrm{FDR}\le q$. In particular one valid constant is

$$
C(q)=\max\Bigl\{
2A(\alpha_0,\rho_0x_0)+x_0/c^2,\frac{1/q-1}{x_0}
\Bigr\}.
$$

## 6. Scope and relation to prior work

Lim's Remark 79 sketches a Chernoff majorant, and Theorem 17 controls the FDR at fixed $m$. If only that majorant is supplied, the original atypical-calibration term is still multiplied by $m-1$. Localizing the atypical term to its own index gives the uniform finite-sample order. The proof uses independence of test units conditional on the calibration data and answers the upper-rate question. Lim's Conjecture 20 about the exact leading constant and Appendix D's band-curvature question are separate.

## References

- Ryan Lim. *Almost Controlled: The FDR of Benjamini–Hochberg on Weighted Conformal p-Values*. arXiv:2611.21509v1, 2026. <https://arxiv.org/abs/2611.21509v1>.
- Ying Jin and Emmanuel J. Candès. *Model-free selective inference under covariate shift via weighted conformal p-values*. Biometrika 113(1), asaf066, 2026. <https://doi.org/10.1093/biomet/asaf066>.
