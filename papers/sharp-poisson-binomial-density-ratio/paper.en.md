# Poisson Density Ratios of Heterogeneous Bernoulli Sums

## Finite bounds, large-mean stability, and sharp second-order losses

The unrestricted exact-constant problem remains open. The proven results below include the full large-mean constant and the sharp correction with a diverging number of high-probability trials.

### 中文摘要与交付范围

本文研究独立、任意异质的有限伯努利和与同均值泊松分布之间的最大密度比。令均值为 \(\lambda\)、方差为 \(v>0\)，目标是确定
\[
C_*=\sup_{n,p}\sqrt{v/\lambda}\max_k
\frac{\Pr(\sum_i B_i=k)}{e^{-\lambda}\lambda^k/k!}.
\]
本轮严格反驳了已有数值实验提出的 \(\sqrt{e/2}\) 候选值，证明了覆盖整个有限类的非尖锐上界，并确定了均值趋于无穷区域的精确极值及全部近极值结构。进一步，指定严格超过一半的成功率坐标数为 $m$，全向量最优值相对大均值常数的二阶亏损为 $1/(24m)$，而互补对族为 $1/(6m)$。原始全局最优常数及有限等号分类仍未完成。

### Abstract

For a finite sum of independent Bernoulli variables with arbitrary parameters in the closed interval [0,1], write R for the maximum Poisson density ratio multiplied by the square root of variance divided by mean. We give an exactly certified 48-trial counterexample to the empirically suggested constant \(\sqrt{e/2}\). Let
\[
\eta=\max_{x>0}\sqrt{x}e^{-x}I_0(x)
\]
be the previously published sharp Bernoulli concentration constant of Baillon, Cominetti and Vaisman. We prove
\[
\sqrt{2\pi}\eta\le C_*
\le \frac{2e^{3/2}}{(3/2)^{5/2}}\eta,
\]
with approximate endpoints 1.175163372073965 and 1.524936934958596. The upper bound uses a common logistic tilt to normalize every coefficient exceeding one, without assuming that the supremum over dimensions is attained. We also prove that the lower endpoint is the exact asymptotic supremum over the entire large-mean region, and characterize every sequence approaching that value through balanced rare successes and rare failures. With exactly $m$ probabilities above one half and unrestricted dimension, the sharp loss from the large-mean limit is $1/(24m)$ in relative units, versus $1/(6m)$ for $m$ complementary pairs. A variational analysis restricts any finite global attaining vector to counts 2, 3, 4 or 5. Explicit counterexamples identify why several natural smoothing and immigration arguments do not close the remaining bounded-mean problem.

The BCV concentration constant, its Fourier envelope and its complementary-binomial sharpness construction are prior results. Their attribution is retained throughout. The results here do not use the unrefereed 2026 claimed variance theorem as a premise. Scientific novelty is supported by the inspected primary-source corpus, not certified worldwide. The analytic manuscript has internal independent mathematical reviews; its complete Lean formalization and the frozen global exact-constant question remain unfinished.

### Main results and evidence

| Result | Mathematical scope | Verification status |
| --- | --- | --- |
| Finite counterexample | 24 probabilities 1/60 and 24 probabilities 59/60 | Exact integer certificate; two independent reconstructions; partial Lean product-law supplement |
| Uniform upper bound | Every finite heterogeneous Bernoulli vector, including endpoint parameters | Complete written proof and independent review |
| Exact large-mean constant | Supremum over all finite vectors with mean at least L, as L tends to infinity | Complete written proof and independent hostile review |
| Near-extremizer classification | Necessary and sufficient conditions for every diverging-mean sequence | Complete written proof and independent hostile review |
| Finite-attainer restrictions | Necessary conditions if the global supremum is attained at finite dimension | Complete written deductions and independent hostile review |
| Sharp second-order loss | All counts, dimension free with $m$ probabilities above one half, and complementary pair comparison | Analytic upper and lower bounds in Part V |
| Exact unrestricted C* and finite equality cases | Original frozen target | OPEN |

The five proof components below are included in full. Their independently reviewed source versions are preserved separately, with hashes in the review directory. Exploratory extensions and failed routes are kept outside this principal manuscript.

### Numerical illustration

*Figure: The complementary family approaches the exact large-mean constant; the separately marked rational witness exceeds the previous candidate.*

Figure 1 is a 60-digit numerical illustration of the exact family and limit derived in Part I. The marked rational witness uses its own parameter 1/60, while the blue family uses x=x*. Its numerical ordinate is not the proof; the exact integer certificate supplies the strict comparison. Data and plotting code are included.

### Interpretation and limitations

A uniform density-ratio bound controls the probability of every count event under the Bernoulli model by the corresponding Poisson probability times one common factor. It therefore gives a multiplicative guarantee even for rare count events. The variance normalization distinguishes genuinely heterogeneous near-deterministic trials from homogeneous small-probability Poisson regimes.

The decimals in this manuscript describe exact analytical expressions or are explicitly marked as numerical observations. The finite counterexample itself is certified by strict integer arithmetic and an elementary Taylor lower bound. Random and structured searches do not prove any universal inequality.

The original frozen target is preserved verbatim in the workflow problem file. In particular, proving the large-mean theorem does not replace the unrestricted problem. A bounded-mean family, including a Poisson–binomial closure of finite Bernoulli laws, could still exceed the current lower endpoint. The missing inequality and concrete failed proof routes are recorded in the continuation notes.



# Part I. Finite counterexample and limiting lower bound


Status: a complete mathematical refutation of the proposed constant
`sqrt(e/2)`, with an exact finite arithmetic certificate and a rigorous
asymptotic lower bound for the still-undetermined optimal constant.  No
universal upper bound is proved in Part I; Part II provides a uniform upper bound. The analytic statements in this part have not yet been formalized in Lean.

### 1. Definitions

For a finite vector `p` of independent Bernoulli parameters, let

\[
\lambda=\sum_i p_i>0,\qquad v=\sum_i p_i(1-p_i)>0,\qquad
b_k=\Pr\{X=k\},\qquad
\rho=\max_k\frac{b_k}{e^{-\lambda}\lambda^k/k!}.
\]

Let `C_*` be the supremum of `sqrt(v/lambda) rho` over these finite
vectors.  A single coefficient gives a valid lower bound on `rho`; locating
the maximizing coefficient is unnecessary for a counterexample.

### 2. Exact 48-trial counterexample

Take 24 parameters equal to `1/60` and 24 equal to `59/60`.  These are all
strictly between zero and one.  The mean and variance are

\[
\lambda=24,\qquad v=48\frac1{60}\frac{59}{60}=\frac{59}{75}.
\]

Write `X=24+Y-Z`, where `Y,Z` are independent `Bin(24,1/60)` variables.
Consequently,

\[
b_{24}=\Pr\{Y=Z\}=\frac{S}{60^{48}},\qquad
S=\sum_{j=0}^{24}\binom{24}{j}^{\!2}59^{48-2j}.
\]

The exact integer is

```
S = 11742757804561398973078027111607277972077691499417486073297049022225979946227694419100
```

After squaring and cancelling a positive factor `e`, the desired strict
violation is equivalent to

\[
\sqrt{\frac{59}{1800}}\,e^{24}
\frac{24!S}{24^{24}60^{48}}>\sqrt{\frac e2}
\quad\Longleftrightarrow\quad
59e^{47}(24!)^2S^2>900\,24^{48}60^{96}.
\]

The exponential series has strictly positive terms, so

\[
e>\sum_{j=0}^{7}\frac1{j!}=\frac{685}{252}.
\]

It therefore suffices to check the finite integer inequality

\[
\boxed{59\,685^{47}(24!)^2S^2
>900\,24^{48}60^{96}252^{47}.}
\]

That inequality holds.  Its complete integer operands and positive difference
are in `counterexample_24_pairs.json`.  The script
`verify_counterexample.py` independently constructs all 49 atoms of the
48-trial law using integer convolution, verifies normalization and both
moments, verifies the collision identity, and then checks the strict integer
inequality.  All acceptance checks use exact integers and fractions.

For orientation only, floating point evaluation gives

\[
\sqrt{v/\lambda}\,b_{24}/\operatorname{Poi}_{24}(24)
\approx1.166818411205432,
\qquad \sqrt{e/2}\approx1.165821990798562.
\]

These decimal values are not the certificate.  The proof is the finite
integer comparison plus the strict Taylor lower bound.

### 3. Prior work and attribution

The 2026 candidate manuscript, immediately after Proposition 8.1, reports
a scan of 20,000 random parameter vectors and binomials with \(n\le300\).
It records an empirical maximum of \(e^{1/2}/\sqrt2\) for the square-root
normalized ratio and asks whether that ratio admits any universal
constant. Section 2 disproves the empirical value as a global constant.
The manuscript's separate variance theorem concerns the larger factor
\(\lambda/v\). [Archived candidate, §8](https://doi.org/10.5281/zenodo.23913938)
· [Candidate source text](https://raw.githubusercontent.com/ipitchford/poisson-binomial-density-ratio/main/poisson_binomial_density_ratio.tex)

Baillon, Cominetti and Vaisman proved the sharp concentration inequality
`sqrt(v) Pr(X=k) <= eta`, where

\[
\eta=\max_{x>0}\sqrt{x}\,e^{-x}I_0(x),\qquad
I_0(x)=\sum_{j=0}^{\infty}\frac{(x^2/4)^j}{(j!)^2}.
\]

Their proof also identifies the complementary two-binomial family below as
asymptotically extremal.  Both the constant and that family are prior work.
The contribution established here is their transfer to the normalized
Poisson density ratio, an exact finite refutation of the proposed ratio
constant, and the explicit finite approximation bounds in Section 5.

Primary source: J.-B. Baillon, R. Cominetti and J. Vaisman, *A sharp uniform
bound for the distribution of sums of Bernoulli trials*, Combinatorics,
Probability and Computing 25(3) (2016), 352–361,
doi: [10.1017/S0963548315000127](https://doi.org/10.1017/S0963548315000127).
Full primary preprint, Theorem 1 and Remark 1:
[arXiv:0806.2350v4](https://arxiv.org/pdf/0806.2350), pp. 3–4.

### 4. General family and rigorous limiting lower bound

Fix `x>0`.  For an integer `m>x`, take `m` parameters equal to
`p=x/(2m)` and `m` equal to `1-p`.  Denote this sum by `X_m`.  Its mean
and variance are

\[
\lambda_m=m,\qquad v_m=2mp(1-p)
=x\left(1-\frac{x}{2m}\right).
\]

For independent `Y_m,Z_m ~ Bin(m,p)`, the identity
`X_m = m+Y_m-Z_m` in distribution yields the exact central mass

\[
b_m(x):=\Pr\{X_m=m\}
=\sum_{j=0}^m\binom mj^2p^{2j}(1-p)^{2m-2j}.
\]

Fourier inversion of the integer-valued difference gives

\[
b_m(x)=\frac1{2\pi}\int_{-\pi}^{\pi}
\left[1-\frac{x}{m}\left(1-\frac{x}{2m}\right)
\left(1-\cos t\right)\right]^m\,dt.
\]

Equivalently, with `u(t)=1-cos(t)` and
`a_m=(x/m)(1-x/(2m))`, the integrand is `(1-a_m u(t))^m`.
The explicit bounds in Section 5 prove, without interchanging an unjustified
limit and sum, that

\[
b_m(x)\longrightarrow h(x):=e^{-x}I_0(x)
=\frac1{2\pi}\int_{-\pi}^{\pi}e^{-x(1-\cos t)}\,dt.
\]

Stirling's formula now gives

\[
\begin{aligned}
F_m(x)&:=\sqrt{\frac{v_m}{m}}
\frac{b_m(x)}{e^{-m}m^m/m!}\\
&=\sqrt{2\pi v_m}\,e^{r_m}b_m(x)
\longrightarrow\sqrt{2\pi x}\,e^{-x}I_0(x),
\end{aligned}
\]

where `1/(12m+1)<r_m<1/(12m)`.  Every `X_m` is an admissible finite
Bernoulli sum, and `sqrt(v_m/m) rho_m >= F_m(x)`.  It follows that

\[
\boxed{C_*\ge\sqrt{2\pi}\max_{x>0}
\sqrt{x}e^{-x}I_0(x)=\sqrt{2\pi}\,\eta.}
\]

The maximization and existence of the maximum defining `eta` are known from
the cited concentration theorem.  Its approximate numerical values are

\[
x_*\approx0.78997842134356796,\quad
\eta\approx0.46882235549942473,\quad
\sqrt{2\pi}\eta\approx1.17516337207396456.
\]

The last decimal is a high precision numerical evaluation of an exact
analytical lower bound.  This note does not give a rational enclosure of the
optimizer.  The finite counterexample in Section 2 needs neither this
optimizer nor a Bessel-function numerical computation.

### 5. Explicit finite approximation inequalities

For `m>x>0`, put `r=x/m` and

\[
K_m(x)=\frac{x^2}{m}\frac{1-r^2/2}{(1-r)^2}.
\]

Then the following two-sided multiplicative estimate holds:

\[
\boxed{e^{-K_m(x)}h(x)\le b_m(x)
\le e^{x^2/m}h(x).}
\]

**Proof.**  For `0<=z<1`, the logarithm series, or direct integration,
gives

\[
-z-\frac{z^2}{2(1-z)}\le\log(1-z)\le-z.
\]

Take `z=a_m u`, where `0<=u<=2`.  Because
`1-2a_m=(1-r)^2>0`, the expression is defined.  The upper bound gives

\[
m\log(1-a_m u)+xu\le\frac{x^2}{2m}u\le\frac{x^2}{m}.
\]

The lower bound gives

\[
m\log(1-a_m u)+xu
\ge\frac{x^2}{2m}u
-\frac{x^2(1-r/2)^2}{2m(1-r)^2}u^2.
\]

The quadratic on the right is concave in `u`, so on `[0,2]` it is
bounded below by the smaller of its two endpoint values.  Those values are
zero and

\[
\frac{x^2}{m}
\left(1-\frac{2(1-r/2)^2}{(1-r)^2}\right)
=-\frac{x^2}{m}\frac{1-r^2/2}{(1-r)^2}=-K_m(x).
\]

Exponentiating and integrating proves the estimate.  In particular it
directly implies convergence to `h(x)` at a quantified rate.

Combining with Robbins' factorial inequalities yields

\[
\sqrt{2\pi x}\,h(x)\sqrt{1-\frac{x}{2m}}
\exp\left(\frac1{12m+1}-K_m(x)\right)
<F_m(x)<
\sqrt{2\pi x}\,h(x)\sqrt{1-\frac{x}{2m}}
\exp\left(\frac1{12m}+\frac{x^2}{m}\right).
\]

These are uniform in the integral variable and valid for every stated `m,x`.
No asymptotic `O` notation is needed for this non-asymptotic result.

Factorial source: H. Robbins, *A remark on Stirling's formula*, American
Mathematical Monthly 62(1) (1955), 26–29,
doi: [10.2307/2308012](https://doi.org/10.2307/2308012).
[Full primary paper](https://dornsife.usc.edu/sergey-lototsky/wp-content/uploads/sites/211/2024/02/Stirling-Robbins.pdf).

### 6. First-order correction and its scope

For each fixed `x>0`, the above integrand has the uniformly valid expansion

\[
m\log(1-a_m u)
=-xu+\frac{x^2}{2m}(u-u^2)+O_x(m^{-2})
\quad(0\le u\le2).
\]

Uniformity follows by bounding the logarithm remainder
`sum_{j>=3} z^j/j <= z^3/[3(1-z)]` when `m` is sufficiently large.
Thus termwise integration is justified and

\[
b_m(x)=h(x)-\frac{x^2}{2m}\bigl(h'(x)+h''(x)\bigr)
+O_x(m^{-2}).
\]

Differentiation under the finite integral is justified by its bounded smooth
integrand.  Substituting this in the factorial normalization gives

\[
F_m(x)=\sqrt{2\pi x}\,h(x)
\left[1+\frac{d(x)}m+O_x(m^{-2})\right],
\]

where

\[
d(x)=\frac1{12}-\frac{x}{4}
-\frac{x^2}{2}\frac{h'(x)+h''(x)}{h(x)}.
\]

At any positive maximizer `x_*` of `sqrt(x) h(x)`, stationarity and the
Bessel differential equation yield

\[
\frac{h'(x_*)}{h(x_*)}=-\frac1{2x_*},\qquad
\frac{h'(x_*)+h''(x_*)}{h(x_*)}
=\frac{1-x_*}{2x_*^2},
\]

and consequently

\[
\boxed{F_m(x_*)=\sqrt{2\pi}\eta
\left[1-\frac1{6m}+O(m^{-2})\right].}
\]

This describes convergence of this particular family's central ratio.  It
does not establish monotonicity for every `m`, optimality over all finite
Bernoulli vectors, or a universal upper bound equal to `sqrt(2pi) eta`.

### 7. Remaining question

The exact global supremum and its finite equality cases remain unresolved. The arguments of Part I alone do not classify near extremizers; Part III gives a complete classification for sequences whose means diverge. In particular, the known concentration
bound `sqrt(v)b_k <= eta` cannot simply be divided by a Poisson atom:
`Poi_lambda(k)` depends on `k` and may be much smaller than its central
normal approximation.  A valid global upper bound must control that
dependence as well.


# Part II. Uniform bound on the full finite class


Research note, 2026-11-24. This note proves an upper bound for every finite heterogeneous Bernoulli sum. It **does not** determine the exact constant or its equality cases. No result from the anonymous 2026 variance-bound preprint is used.

### Statement

Let `S=sum B_i` be any finite sum of independent Bernoulli variables, with `p_i in [0,1]`,

\[
 \lambda=\sum_i p_i>0,\qquad v=\sum_i p_i(1-p_i)>0,
 \quad b_k=\mathbb P(S=k),\quad
 R_k=\sqrt{v/\lambda}\,b_k/\pi_\lambda(k).
\]

Define the previously published BCV constant

\[
 \eta=\max_{x\ge0}\sqrt{x}\,e^{-x}I_0(x),\qquad
 I_0(x)=\sum_{j=0}^\infty\frac{(x^2/4)^j}{(j!)^2}.
\]

Then

\[
 \boxed{\quad C_*\le
 \frac{2e^{3/2}}{(3/2)^{5/2}}\,\eta
 \approx1.524936934958596.\quad}\tag{U}
\]

Combined with the BCV sharpness construction transferred to density ratios, this gives the nonsharp bracket

\[
 \sqrt{2\pi}\,\eta\le C_*
 \le\frac{2e^{3/2}}{(3/2)^{5/2}}\,\eta.
\]

The lower endpoint is approximately `1.175163372073965`. The numerical decimals are explanatory high-precision evaluations; the theorem is stated through exact expressions.

### 1. Published ingredients and attribution

BCV prove `sqrt(v)b_k<=eta` for every finite Bernoulli convolution. Their Fourier argument actually gives the sharper pointwise bound `b_k<=exp(-v)I_0(v)`. Their paired-small-and-large-probability construction proves sharpness for this concentration inequality.

Primary sources:

- Baillon, Cominetti, Vaisman, *A Sharp Uniform Bound for the Distribution of Sums of Bernoulli Trials*, CPC 25 (2016), 352--361. DOI: https://doi.org/10.1017/S0963548315000127 ; full text: https://arxiv.org/pdf/0806.2350 .
- Dümbgen and Wellner, *The density ratio of Poisson binomial versus Poisson distributions*, Statistics & Probability Letters 165 (2020), 108862. DOI: https://doi.org/10.1016/j.spl.2020.108862 ; full text: https://arxiv.org/pdf/1910.03444 .

The fixed-count-one inequality below follows from the ray concavity established in Section 2.3 and used in the proof of Theorem 2 of Dümbgen--Wellner. Their restriction `lambda<=1` is needed to identify the maximizing count with one, not for the inequality at the fixed count one itself. Thus this ingredient is a consequence of prior work, not claimed as an original theorem.

### 2. Counts zero and one

For count zero,

\[
 b_0=\prod_i(1-p_i)\le e^{-\lambda},\qquad v\le\lambda,
\]

so `R_0<=1`.

For count one, let `Delta=sum p_i^2/lambda=1-v/lambda`. First suppose every `p_i<1`. Along the ordinary scaling ray `t p`, write

\[
 L_1(t)=\log\frac{b_{tp}(1)}{\pi_{t\lambda}(1)}.
\]

Dümbgen--Wellner's ray argument gives concavity of `L_1` on `[0,1]`; also `L_1(0)=0` and `L_1'(0)=Delta`. Hence

\[
 \log\frac{b_1}{\pi_\lambda(1)}=L_1(1)\le\Delta,
\]

for **every** positive mean, not only for `lambda<=1`. If an endpoint parameter equals one, the probability inequality extends by taking finite-dimensional limits; if `b_1=0` it is immediate. Thus

\[
 R_1\le e^\Delta\sqrt{1-\Delta}\le\sqrt{e/2}.\tag{U1}
\]

The last scalar maximum occurs at `Delta=1/2`, since the logarithmic derivative of `exp(Delta)sqrt(1-Delta)` is `1-1/[2(1-Delta)]`.

### 3. Logistic normalization of any count with ratio greater than one

Fix a finite vector and an integer `k` with `R_k>1`. In particular `b_k>0`. Let

\[
 p_i(t)=\frac{p_i e^t}{1-p_i+p_i e^t},\qquad t\in\mathbb R.
\]

Parameters zero and one remain fixed. Put `lambda(t)=sum p_i(t)`, `v(t)=sum p_i(t)(1-p_i(t))`, and let `R_k(t)` be the corresponding normalized ratio at the **same** count `k`. Every finite `t` is still a member of the original finite Bernoulli class.

We first verify that `R_k(t)` attains a maximum at a finite `t`.

As `t` tends to positive infinity, every originally interior parameter tends to one, so `v(t)` tends to zero while `lambda(t)` tends to a positive integer. The Poisson denominator therefore has a positive limit and `R_k(t)` tends to zero.

As `t` tends to negative infinity, let `d` be the number of deterministic-one parameters. If `d>0`, then `lambda(t)` tends to `d` and `v(t)` tends to zero, again giving `R_k(t)` tending to zero. If `d=0`, write `q_i=p_i/(1-p_i)` for the positive interior parameters and `z=e^t`. Then

\[
 \lambda(t)\sim z\sum_iq_i,\qquad v(t)/\lambda(t)\to1,
 \qquad b_k(t)\sim z^k e_k(q),
\]

where `e_k` is the elementary symmetric polynomial. Consequently

\[
 \lim_{t\to-\infty}R_k(t)
 =\frac{k!e_k(q)}{(\sum_iq_i)^k}\le1.
\]

The last inequality follows by expanding the power: the terms with `k` distinct indices give exactly `k!e_k(q)`, while all remaining terms are nonnegative. Since `R_k(0)>1`, continuity and these endpoint limits imply that a maximizing finite parameter `t_*` exists, with `R_k(t_*)>=R_k(0)` and zero derivative.

At any finite point of this logistic path, abbreviate

\[
 \lambda=\lambda(t),\quad v=v(t),\quad
 S_2=\sum_i p_i(t)^2,\quad S_3=\sum_i p_i(t)^3,
 \quad M=S_2-S_3,\quad\Delta=S_2/\lambda.
\]

The logistic path is an exponential tilt of the count distribution. Direct differentiation gives

\[
 \lambda'=v,\quad v'=v-2M,\quad (\log b_k)'=k-\lambda.
\]

For the squared objective

\[
 H_k=R_k^2=v b_k^2 e^{2\lambda}(k!)^2/\lambda^{2k+1},
\]

these identities yield

\[
 (\log H_k)'=\Delta\{1+2(k-\lambda)\}-2M/v.
\]

At the maximizing point,

\[
 k-\lambda+\frac12=\frac{M}{v\Delta}.
\]

Here `M>0` because there is an interior Bernoulli parameter. Cauchy--Schwarz, `S_2^2<=lambda S_3`, gives `M<=v Delta`. Therefore the normalized vector satisfies

\[
 k-\frac12\le\lambda<k+\frac12.\tag{U2}
\]

This normalization does not assume that the arbitrary-dimension supremum is attained. It is performed separately on any finite vector with `R_k>1`.

### 4. A monotone Poisson denominator

For positive integers `k`, define

\[
 d_k=\sqrt{k-1/2}\,\pi_{k-1/2}(k)
 =e^{-(k-1/2)}(k-1/2)^{k+1/2}/k!.
\]

For fixed `k`, the logarithmic derivative of `sqrt(lambda)pi_lambda(k)` is `(k+1/2)/lambda-1`, so (U2) implies

\[
 \sqrt\lambda\,\pi_\lambda(k)\ge d_k.
\]

Moreover `d_(k+1)>d_k`. Indeed, with `A=k+1/2>1`,

\[
 \log(d_{k+1}/d_k)
 =-1-\log(1+1/(2A))-A\log(1-1/A)>0,
\]

using `log(1+y)<y` and `-log(1-x)>x+x^2/2` at the indicated positive arguments. The lower estimates cancel the constant and linear terms exactly and leave a strict positive remainder.

### 5. Completing the uniform bound

Take `k>=2`. If `R_k<=1`, the claimed upper bound is automatic. Otherwise apply Section 3, obtaining a vector with no smaller ratio and satisfying (U2). The published BCV inequality and Section 4 give

\[
 R_k(0)\le R_k(t_*)
 =\frac{\sqrt v\,b_k}{\sqrt\lambda\,\pi_\lambda(k)}
 \le\frac{\eta}{d_k}
 \le\frac{\eta}{d_2}
 =\frac{2e^{3/2}}{(3/2)^{5/2}}\eta.
\]

This also dominates the count-one bound. One exact way to check that comparison is `eta>=f(1)>e^(-1)`, where `f(x)=sqrt(x)e^(-x)I_0(x)`. Thus

\[
 \eta/d_2>2e^{1/2}/(3/2)^{5/2}>\sqrt{e/2},
\]

because the square of the second comparison reduces to `8>(3/2)^5=243/32`. Together with Sections 2--4, this proves (U) for every permitted finite vector and every count.

### 6. What this proves and what it does not

The theorem proves existence of a finite dimension-free square-root multiplier in the frozen heterogeneous finite class, with an explicit constant about `1.525`. It also supplies a useful normalization for any maximizing sequence.

For a sequence that has been normalized as in Section 3 and whose means tend to infinity, the relation `abs(k-lambda)<=1/2` and Stirling's formula give

\[
 \sqrt\lambda\,\pi_\lambda(k)\longrightarrow1/\sqrt{2\pi},
\]

so BCV implies the normalized escape bound `limsup R_k<=sqrt(2pi)eta`. This statement concerns the normalized sequence; it does not silently assume that logistic normalization preserves the original mean.

The exact upper bound `sqrt(2pi)eta`, the possible contribution of bounded-mean Poisson-plus-binomial limits, and all finite equality cases remain unresolved. The gap between the two endpoints of the bracket is substantial. The nonsharp bound above is a theorem-level partial result, not a completion of the original exact-constant problem.


# Part III. Sharp large-mean constant and stability


**Mathematical status.** The arguments below prove an exact asymptotic
extremal theorem over arbitrary finite Bernoulli sums, including parameters
zero and one. They also prove the stated characterization of all sequences
approaching the asymptotic constant. They use the classical Darroch mode
theorem, the Baillon–Cominetti–Vaisman concentration bound, and Robbins'
factorial bounds. The statements are not yet Lean formalizations. The full
unrestricted supremum `C_*` remains open in this work.

### 1. Setup and result

Let `p=(p_1,...,p_n)` have entries in `[0,1]`, and let `X` be the sum of
independent Bernoulli variables with these parameters. Write

\[
\lambda=\sum_i p_i>0,\quad
v=\sum_i p_i(1-p_i)>0,\quad b_k=\Pr\{X=k\},\quad
R(p)=\sqrt{\frac v\lambda}\max_k\frac{b_k}{e^{-\lambda}\lambda^k/k!}.
\]

Define

\[
h(x)=\frac1{2\pi}\int_{-\pi}^{\pi}e^{-x(1-\cos t)}\,dt
=e^{-x}I_0(x),\qquad
\eta=\max_{x>0}\sqrt{x}\,h(x),\qquad C_\infty=\sqrt{2\pi}\eta.
\]

The value `eta` is the known optimal Bernoulli concentration constant of
Baillon–Cominetti–Vaisman (BCV). Numerically `C_infty` is about
`1.17516337207396456`.

**Theorem A (exact large-mean extremal constant).**

\[
\boxed{\lim_{L\to\infty}\sup\{R(p):p\text{ finite},\ \lambda(p)\ge L,
\ v(p)>0\}=C_\infty.}
\]

For every real `L>=1`, the following explicit upper bound is valid:

\[
\boxed{
\sup_{\lambda\ge L}R(p)
\le C_\infty\exp\left(\frac1{12\lfloor L\rfloor}\right)
\left(1+\frac1L\right).}
\]

The BCV complementary rare-event family supplies the matching limit. This
theorem concerns the complete large-mean region, not only that family.

### 2. A correct choice of a ratio-maximizing index

**Lemma 1.** There exists an index maximizing `b_k/Poi_lambda(k)` with

\[
\max(1,\lfloor\lambda\rfloor)\le k\le\lceil\lambda\rceil.
\]

Every maximizing index satisfies the lower bound `lambda<k+1`.

#### 2.1 Existence of a maximizing index at most `ceil(lambda)`

First assume every parameter is strictly less than one. The support of the
law has no internal zero. For `b_{j+1}>0`, let `L` be the random set of
successful indices conditional on `X=j+1`. Put
`s_L=sum_{i in L}p_i` and `t_L=sum_{i notin L}p_i`. Directly expanding
the coefficient sums gives the identity

\[
\frac{b_j}{(j+1)b_{j+1}}
=\mathbb E\left[\frac1{j+1}\sum_{i\in L}
\frac{1-p_i}{p_i+t_L}\ \middle|\ X=j+1\right].
\]

This is Equation (6) of Dümbgen–Wellner (2020); it also follows by counting
each size-`j` success set once for each possible added success and normalizing
by the sum of the added probabilities. All terms with nonzero conditional
weight have strictly positive denominators.

For fixed `t>=0`, the function `(1-y)/(y+t)` is convex where defined.
Writing `bar_p=s_L/(j+1)`, Jensen's inequality therefore gives

\[
\frac1{j+1}\sum_{i\in L}\frac{1-p_i}{p_i+t_L}
\ge\frac{1-\bar p}{\bar p+t_L}
=\frac{1-\bar p}{\lambda-j\bar p}
\ge\frac1\lambda\qquad(j\ge\lambda).
\]

For `j>lambda`, the last inequality is strict. Consequently

\[
\frac{b_{j+1}/\operatorname{Poi}_\lambda(j+1)}
{b_j/\operatorname{Poi}_\lambda(j)}\le1
\quad(j\ge\lambda),
\]

with strict inequality for `j>lambda`. If the next atom vanishes, the
conclusion is immediate. Thus a maximizer can be chosen at or below
`ceil(lambda)`.

For parameters equal to one, replace `p` by `(1-epsilon)p`. The preceding
argument gives a maximizing index at most
`ceil((1-epsilon)lambda)<=ceil(lambda)`. There are only finitely many
possible indices. Choose a subsequence with a fixed index and let
`epsilon` decrease to zero. Each atom and each positive-mean Poisson atom
is continuous in the parameters, so that fixed index remains a maximizer
of the limiting law. This proves the required existence with all boundary
parameters included.

**Integer-mean caution.** The stronger assertion that *every* maximizer is
at most `ceil(lambda)` needs a tie exception. For example, a homogeneous
`Bin(n,p)` with integer `np=lambda` can have equal ratios at `lambda` and
`lambda+1`. The non-strict Jensen inequality above establishes exactly the
existence statement needed here, without relying on the over-strong wording
of Proposition 1 in the Dümbgen–Wellner preprint.

#### 2.2 Lower bound by a different exponential tilt

The ratio at zero is strictly less than one: a positive parameter gives
`1-p<exp(-p)`, and a parameter equal to one makes `b_0=0`. Since the
Poisson-weighted average of all ratios is one, a maximizing index has
`k>=1` and `b_k>0`.

Let `k` be any maximizing index. Its neighboring ratios imply

\[
(k+1)b_{k+1}\le\lambda b_k,\qquad
k b_k\ge\lambda b_{k-1}.
\]

The second inequality is interpreted directly even when `b_{k-1}=0`.
Use the tilt

\[
z=\frac{k+1}{\lambda},\qquad
q_i=\frac{p_i z}{1-p_i+p_i z}.
\]

The tilted probabilities satisfy `b'_j=z^j b_j/G(z)`, where
`G(z)=prod_i(1-p_i+p_i z)>0`. Their neighboring ratios show
`b'_{k+1}<=b'_k` and `b'_k>b'_{k-1}`. A Bernoulli sum has no internal
zero and is log-concave by Newton's inequalities. Its adjacent mass ratios
are consequently nonincreasing on the positive support, so these two
neighboring inequalities imply that `k` is a global mode of the tilted law.

Darroch's theorem says that every mode of a nondegenerate finite Bernoulli
sum differs from its mean by strictly less than one. It remains valid with
zero/one parameters by removing zeros and translating by deterministic
ones. Here the tilted law is nondegenerate because `v>0` ensures at least
one `0<q_i<1`.

If `lambda>=k+1`, then `z<=1`, and

\[
\mu(z):=\sum_i q_i
=\sum_i\frac{p_i z}{1-p_i+p_i z}
\ge z\sum_i p_i=k+1.
\]

This contradicts Darroch's strict mode-mean bound. Hence `lambda<k+1`.
Together with the upper-index existence result this proves Lemma 1.

### 3. A variance-sensitive exponential-tilt upper bound

**Lemma 2.** For every admissible `p` and integer `k>=1`,

\[
\boxed{
\sqrt{\frac v\lambda}\frac{b_k}{\operatorname{Poi}_\lambda(k)}
\le C_\infty\,e^{r_k}\max\left(1,\frac{k}{\lambda}\right),
\qquad \frac1{12k+1}<r_k<\frac1{12k}.}
\]

Here `r_k` is the exact Robbins/Stirling remainder, defined by
`k!=sqrt(2pi k)(k/e)^k exp(r_k)`.

**Proof.** For an arbitrary `z>0`, use the tilted parameters `q_i` from
Section 2 and denote their variance by `v_z`. Direct computation gives

\[
v_z=\sum_i\frac{p_i(1-p_i)z}{[1+p_i(z-1)]^2}
\ge\frac{vz}{\max(1,z)^2}>0.
\]

The estimate holds because each positive denominator lies between
`min(1,z)` and `max(1,z)`. It also covers `p_i=0` or `p_i=1`, whose
individual variance terms are zero. The inequality `log(1+t)<=t` gives

\[
G(z)\le e^{\lambda(z-1)}.
\]

Apply BCV concentration to the tilted law:
`b'_k<=eta/sqrt(v_z)`. Using `b_k=G(z)z^{-k}b'_k`, it follows that

\[
\sqrt{\frac v\lambda}\frac{b_k}{\operatorname{Poi}_\lambda(k)}
\le\eta\frac{\max(1,z)}{\sqrt{\lambda z}}
\frac{e^{\lambda z}k!}{(\lambda z)^k}.
\]

Now choose `z=k/lambda` (distinct from the mode-location tilt used in
Section 2). Substitute Robbins' formula to obtain Lemma 2.

### 4. Proof of Theorem A

Choose the maximizing index from Lemma 1. If `lambda>=L>=1`, then
`k>=floor(L)>=1` and `k/lambda<=1+1/L`. Lemma 2 gives the displayed
non-asymptotic upper bound in Theorem A. Its right side converges to
`C_infty` as `L` tends to infinity.

For the matching lower bound, fix any `x>0` and use `m` copies of
`x/(2m)` together with `m` copies of `1-x/(2m)`. The rigorous family
calculation in Part I, Sections 4–5, gives mean `m`, variance
`x(1-x/(2m))`, and normalized central ratio tending to
`sqrt(2pi x)h(x)`. Taking `x` to maximize `sqrt(x)h(x)` proves that the
supremum for every fixed `L` is at least `C_infty`. Combining both bounds
proves Theorem A.

### 5. Unique maximizer of the Bessel profile

For use in the stability statement, uniqueness can be proved directly.
Set `g(x)=sqrt(x)h(x)` and `I_1=I_0'`. Differentiating the convergent
power series for `I_0` gives the Bessel equation

\[
x^2I_0''+xI_0'-x^2I_0=0.
\]

Consequently, for `R=I_1/I_0`,

\[
R'=1-R/x-R^2,\qquad
\frac{g'}g=f(x):=R(x)-1+\frac1{2x}.
\]

At any zero of `f`, substitution gives

\[
f'(x)=-\frac1{4x^2}<0.
\]

Thus every zero is isolated and crosses from positive to negative. There
cannot be two zeros: on the compact interval between them there would be
finitely many isolated zeros (an accumulation point would force a zero with
zero derivative), and the crossing directions would have to alternate.

Existence of an interior maximum can also be checked without a numerical
optimization. We have `g(x)->0` as `x` decreases to zero. Substitution
`u=sqrt(x)t` in the integral for `h`, with the bound
`1-cos(t)>=2t^2/pi^2` for `|t|<=pi`, gives by dominated convergence

\[
g(x)\longrightarrow\frac1{\sqrt{2\pi}}\qquad(x\to\infty).
\]

Meanwhile `g(1/2)>=1/sqrt(2e)>1/sqrt(2pi)`, using the elementary
`e<pi`. Hence the global maximum is attained inside `(0,infinity)`.
There is exactly one critical point, denoted `x_*`, and it is the unique
global maximizer. This proves the uniqueness required below. No decimal
root approximation is used in the proof.

### 6. Full characterization of large-mean near extremizers

Let `p^{(r)}` be any sequence of finite parameter vectors (lengths may
vary), with means `lambda_r->infinity` and positive variances. For each
vector define

\[
M_r=\#\{i:p_i^{(r)}>1/2\},\qquad
a_r=\sum_{p_i^{(r)}\le1/2}p_i^{(r)},\qquad
b_r=\sum_{p_i^{(r)}>1/2}(1-p_i^{(r)}),
\]

and `q_{r,i}=min(p_i^{(r)},1-p_i^{(r)})`.

**Theorem B (necessary and sufficient conditions).**

\[
R(p^{(r)})\longrightarrow C_\infty
\]

if and only if

\[
\boxed{
\max_i q_{r,i}\longrightarrow0,\qquad
a_r\longrightarrow x_*/2,\qquad
b_r\longrightarrow x_*/2.}
\]

In that event `v_r->x_*`, `lambda_r-M_r->0`, and the unique
ratio-maximizing index is `M_r` for all sufficiently large `r`.

#### 6.1 Necessity: concentration and variance

Choose a ratio-maximizing `k_r` as in Lemma 1. Its distance from
`lambda_r` is at most one. Stirling's formula therefore gives

\[
\frac1{\sqrt{\lambda_r}\operatorname{Poi}_{\lambda_r}(k_r)}
\longrightarrow\sqrt{2\pi}.
\]

This convergence follows directly by writing the logarithm as the
Stirling remainder plus
`lambda-k+(k+1/2)log(k/lambda)`, whose non-remainder part tends to zero
uniformly for `|k-lambda|<=1`. Thus the assumed convergence of `R`
implies

\[
\sqrt{v_r}\,b_{k_r}\longrightarrow\eta.
\]

The BCV proof gives the pointwise bound `sqrt(v)b_k<=g(v)<=eta`.
The uniqueness result in Section 5, together with the strict endpoint
limits there, therefore forces `v_r->x_*`.

#### 6.2 Necessity: all individual trials become rare successes or failures

Write `w_i=p_i(1-p_i)` and `W_2=sum_i w_i^2`. The characteristic
function satisfies

\[
|\phi(t)|=\prod_i\sqrt{1-2w_i(1-\cos t)}.
\]

For `0<=y<1`, the bound `log(1-y)<=-y-y^2/2` yields, with
`u=1-cos(t)`,

\[
|\phi(t)|\le\exp[-vu-W_2u^2].
\]

If a factor vanishes the same bound holds by continuity. Fourier inversion
then shows

\[
b_k\le\frac1{2\pi}\int_{-\pi}^{\pi}
e^{-v(1-\cos t)-W_2(1-\cos t)^2}\,dt.
\]

Since `v_r->x_*>0`, near equality `sqrt(v_r)b_{k_r}->eta`
forces `W_{2,r}->0`. To make the strictness explicit, if `v<=V` and
`W_2>=epsilon`, the gap between the last integral and `h(v)` is at
least

\[
\frac12e^{-2V}(1-e^{-\epsilon})>0,
\]

by integrating over `pi/2<=|t|<=pi`. Such a gap contradicts near
equality. Because `q_i<=2w_i`,

\[
\sum_i q_i^2\le4W_2\longrightarrow0,
\qquad \max_iq_i\longrightarrow0,
\qquad a_r+b_r=v_r+\sum_iq_i^2\longrightarrow x_*.
\]

#### 6.3 Necessity: balance and central index

The centered variable `X_r-M_r` is a sum of Bernoulli rare successes
minus a sum of independent Bernoulli rare failures. Its characteristic
function is

\[
\psi_r(t)=\prod_{p_i\le1/2}[1+q_i(e^{it}-1)]
\prod_{p_i>1/2}[1+q_i(e^{-it}-1)].
\]

Because `max q_i->0` and `sum q_i^2->0`, the Taylor bound
`|log(1+z)-z|<=|z|^2/[2(1-|z|)]` shows uniformly in `t` that

\[
\psi_r(t)-
\exp\{a_r(e^{it}-1)+b_r(e^{-it}-1)\}\longrightarrow0.
\]

The positive means `a_r,b_r` are bounded. Also
`j_r=k_r-M_r=(k_r-lambda_r)+(a_r-b_r)` is a bounded integer sequence.
From any subsequence choose a further subsequence with `a_r->a`,
`b_r->b`, and fixed integer `j_r=j`. Necessarily `a+b=x_*`.
Fourier inversion and uniform convergence yield

\[
b_{k_r}\longrightarrow
\frac1{2\pi}\int_{-\pi}^{\pi}
e^{-x_*(1-\cos t)}
\cos\bigl((a-b)\sin t-jt\bigr)\,dt.
\]

The limit must equal `h(x_*)`. The integrand deficit from `h(x_*)`
is continuous and nonnegative, with a strictly positive weight. It can
integrate to zero only when
`cos((a-b)sin(t)-jt)=1` for every `t`. The phase is continuous and is
zero at zero, so it is identically zero. Its first and third derivatives
at zero give respectively `a-b-j=0` and `a-b=0`. Thus
`a=b=x_*/2` and `j=0`.

Every convergent subsequence has these same limits, proving
`a_r,b_r->x_*/2`. The bounded integer sequence `j_r` has only zero as a
possible subsequential value, so the selected maximizing index equals
`M_r` eventually. To bound possible ties, discard the deterministically zero trials and
write \(\ell\) for the deterministic ones and \(q\) for the number of
interior trials. On the support \(k=\ell+j\), \(0\le j\le q\), factor
\[
\frac{b_{\ell+j}}{\operatorname{Poi}_{\lambda}(\ell+j)}
=\frac{b_{\ell+j}}{\binom qj}
 \frac{\binom qj}{\operatorname{Poi}_{\lambda}(\ell+j)}.
\]
Newton's inequalities make the first factor log-concave. The second
factor has strictly decreasing adjacent ratios
\((q-j)(\ell+j+1)/[\lambda(j+1)]\) for \(0\le j<q\), since \(q-j\)
decreases strictly and \((\ell+j+1)/(j+1)=1+\ell/(j+1)\)
is nonincreasing. Hence the product has at most two consecutive
maximizing indices, as is also immediate for supports of size at most two. A second maximizer could only be `M_r-1` or `M_r+1`. Uniform
characteristic-function convergence shows that either neighboring mass
tends to `e^{-x_*}I_1(x_*)`, whereas the central mass tends to
`e^{-x_*}I_0(x_*)`. The former is strictly smaller: their difference is
the positive integral
`(1/(2pi)) integral exp(-x_*(1-cos t))(1-cos t) dt`.
The relevant Poisson ratios satisfy

\[
\frac{\operatorname{Poi}_{\lambda_r}(M_r+1)}
{\operatorname{Poi}_{\lambda_r}(M_r)}
=\frac{\lambda_r}{M_r+1}\longrightarrow1,\qquad
\frac{\operatorname{Poi}_{\lambda_r}(M_r-1)}
{\operatorname{Poi}_{\lambda_r}(M_r)}
=\frac{M_r}{\lambda_r}\longrightarrow1.
\]

Thus either neighboring density ratio divided by the central density ratio
tends to `I_1(x_*)/I_0(x_*)<1`. A neighboring ratio cannot equal the
central maximum for arbitrarily large `r`. This proves eventual uniqueness without
needing any boundary extension of the upper-index tie statement.

#### 6.4 Sufficiency

Suppose the three boxed conditions in Theorem B hold. Then
`sum q_i^2<=max(q_i)(a_r+b_r)->0`, and hence `v_r->x_*`. The same
uniform characteristic-function calculation gives

\[
\Pr\{X_r=M_r\}\longrightarrow e^{-x_*}I_0(x_*)=h(x_*).
\]

Furthermore `lambda_r-M_r=a_r-b_r->0`, and `M_r->infinity`.
Stirling's formula at `M_r` shows that the normalized central ratio tends
to `C_infty`. The full ratio is at least this central ratio, while
Theorem A gives its limiting upper bound `C_infty`. This proves
sufficiency. The last statements then follow from the necessity proof.

### 7. References and novelty boundaries

1. J. N. Darroch, *On the distribution of the number of successes in
   independent trials*, Annals of Mathematical Statistics 35(3) (1964),
   1317–1321, doi [10.1214/aoms/1177703287](https://doi.org/10.1214/aoms/1177703287).
   The original theorem is also reproduced, together with tilted-ratio
   consequences, in Jim Pitman's primary research paper, *Probabilistic
   bounds on the coefficients of polynomials with only real zeros*, JCTA
   77 (1997), 279–303, pp. 284–286:
   [author PDF](https://www.stat.berkeley.edu/users/pitman/453.pdf).
2. L. Dümbgen and J. A. Wellner, *The density ratio of Poisson binomial
   versus Poisson distributions*, SPL 165 (2020), 108862,
   doi [10.1016/j.spl.2020.108862](https://doi.org/10.1016/j.spl.2020.108862),
   [full preprint](https://arxiv.org/pdf/1910.03444), Equation (6) and
   Proposition 1. The integer-mean tie correction is made explicit above.
3. J.-B. Baillon, R. Cominetti and J. Vaisman, *A sharp uniform bound for
   the distribution of sums of Bernoulli trials*, CPC 25(3) (2016),
   352–361, doi [10.1017/S0963548315000127](https://doi.org/10.1017/S0963548315000127),
   [primary preprint](https://arxiv.org/pdf/0806.2350). The constant,
   Fourier envelope, and asymptotically extremal complementary family are
   prior work. Their transfer to the full large-mean density-ratio
   extremal problem is the result established here.
4. H. Robbins, *A remark on Stirling's formula*, American Mathematical
   Monthly 62(1) (1955), 26–29,
   doi [10.2307/2308012](https://doi.org/10.2307/2308012),
   [primary paper](https://dornsife.usc.edu/sergey-lototsky/wp-content/uploads/sites/211/2024/02/Stirling-Robbins.pdf).

These results do not rule out a finite-mean or bounded-mean limiting family
whose normalized density ratio is greater than `C_infty`. Establishing
that exclusion is still needed to determine the original `C_*`.


# Part IV. Necessary conditions for finite global attainment


This part derives necessary conditions for a hypothetical finite global optimizer. The exact universal constant remains **unproved**. Previously published reduction and concentration results are explicitly distinguished from the deductions below. Part I supplies the exact finite certificate refuting the proposed constant `sqrt(e/2)`.

### 1. Setup and objective

Let independent Bernoulli parameters be `p_i in [0,1]`. Write

\[
 b_k=\mathbb P(S=k),\quad \lambda=\sum_i p_i,\quad
 v=\sum_i p_i(1-p_i),\quad S_r=\sum_i p_i^r.
\]

Assume `lambda>0`, `v>0`, and `b_k>0`. The square of the normalized density ratio at index `k` is

\[
 H_k=v b_k^2 e^{2\lambda}(k!)^2/\lambda^{2k+1}.
\]

Thus

\[
 g_k=\log H_k=\log v+2\log b_k+2\lambda-(2k+1)\log\lambda+2\log(k!).
\]

Zero parameters can always be removed. Parameters equal to one must be retained as deterministic shifts: deleting them changes both the index and the Poisson comparison mean.

### 2. Common logistic perturbation: location of the mean

Set

\[
 p_i(t)=\frac{p_i e^t}{1-p_i+p_i e^t}.
\]

This is a two-sided admissible smooth path even in the presence of `p_i=0` or `1`, which remain fixed. It is an exponential tilt of the full count law. At `t=0`,

\[
 \lambda'=v,\quad v'=\sum_i p_i(1-p_i)(1-2p_i)=v-2M,
 \quad (\log b_k)'=k-\lambda,
\]

where `M=S_2-S_3=sum p_i^2(1-p_i)`. Therefore, with `Delta=S_2/lambda=1-v/lambda`,

\[
 g_k'=\Delta\{1+2(k-\lambda)\}-2M/v.\tag{L1}
\]

At any local maximum along this path,

\[
 k-\lambda+\frac12=\frac{M}{v\Delta}.\tag{L2}
\]

We have `M>0` because `v>0` entails at least one parameter strictly between zero and one. Cauchy--Schwarz gives

\[
 S_2^2\le\lambda S_3,
\]

which is equivalent to

\[
 M\le v\Delta.
\]

Consequently

\[
 k-\frac12\le\lambda<k+\frac12.\tag{L3}
\]

Equality in the left-hand inequality holds exactly when all strictly positive probabilities are equal. Indeed, the Cauchy equality condition for vectors `(sqrt(p_i))` and `(p_i^(3/2))` says that every positive `p_i` has the same value. In particular, this equality cannot occur in a positive-variance vector containing a deterministic one and another positive parameter.

This is a necessary condition for a parameter-vector optimum of the normalized objective. It is not a statement about the maximizing count index of an arbitrary fixed vector.

### 3. Adding a new small Bernoulli: a dimension-extension obstruction

Assume that zero parameters have been removed and that the gradient of `g_k` vanishes at every coordinate with `0<p_i<1`. Coordinates equal to one may remain. Let `n` denote the resulting number of positive parameters. Append a new independent `Bernoulli(epsilon)`, and hold the old parameters and the index fixed. The right derivative at zero is

\[
 D_0:=\left.\frac{d}{d\epsilon}g_k(p_1,\ldots,p_n,\epsilon)\right|_{0+}
 =\frac1v+2\frac{b_{k-1}}{b_k}-\frac{2k+1}{\lambda}.\tag{D1}
\]

To simplify this derivative, vary the old probabilities in the admissible direction `(1-p_i)`. Deterministic ones have zero velocity; all other positive parameters permit this direction in both signs near zero. Standard coefficient identities give

\[
 \sum_i(1-p_i)\,\partial_i b_k
 =(n-k+1)b_{k-1}-(n-k)b_k,
\]

and

\[
 \sum_i(1-p_i)(1-2p_i)=n-\lambda-2v.
\]

The vanishing directional derivative is therefore

\[
 0=\frac{n-\lambda-2v}{v}
 +2\{(n-k+1)b_{k-1}/b_k-(n-k)\}
 +(n-\lambda)\{2-(2k+1)/\lambda\}.
\]

Substitute this into (D1), then use (L2). The exact result is

\[
 D_0=\frac{\lambda-k+1}{n-k+1}
 \frac{2S_3-S_2}{vS_2}.\tag{D2}
\]

All denominators are positive, and (L3) gives `lambda-k+1>=1/2`. Hence any finite parameter vector attaining the global supremum over every dimension must satisfy

\[
 2S_3\le S_2.\tag{D3}
\]

Combining (D3) with `S_2^2<=lambda S_3` yields

\[
 S_2\le\lambda/2,\qquad v\ge\lambda/2.\tag{D4}
\]

This does **not** prove that such finite maximizers exist, nor that (D3) suffices for maximality. It does show that finite stationary paired near-deterministic configurations cannot be global maximizers across all dimensions: their `2S_3-S_2` is positive, so appending a sufficiently small new Bernoulli improves the objective.

### 4. Common scale perturbation, without deterministic ones

If every positive parameter is strictly below one, the direction `p_i'(0)=p_i` is admissible in both signs. Use

\[
 \sum_i p_i\partial_i b_k=k b_k-(k+1)b_{k+1},
 \qquad\sum_i p_i(1-2p_i)=2v-\lambda.
\]

At a stationary point of the full normalized objective this yields

\[
 (k+1)\frac{b_{k+1}}{b_k}
 =\lambda+\frac12-\frac{\lambda}{2v}.\tag{S1}
\]

In particular `v>=lambda/(2lambda+1)`. Equation (S1) is not asserted when deterministic ones are present, because common upward scaling is then inadmissible.

### 5. Pair perturbations: why naive equalization is invalid

Select two coordinates, put `s=p_i+p_j`, `q=p_i p_j`, and let `d_l` denote the pmf with these two coordinates removed. At fixed `s`,

\[
 b_k=A+Dq,
 \quad A=d_k+s(d_{k-1}-d_k),
 \quad D=d_{k-2}-2d_{k-1}+d_k,
\]

and

\[
 v=C+2q,\qquad C=v_{\mathrm{rest}}+s-s^2.
\]

Since the mean is fixed, the relevant objective is

\[
 F(q)=(C+2q)(A+Dq)^2=vb_k^2.
\]

Its derivative is

\[
 F'(q)=2b_k(b_k+vD).
\]

At a positive interior stationary point, `D=-b_k/v<0` and

\[
 F''(q)=6b_kD<0.
\]

Thus an unequal pair can be a strict local maximum under fixed mean. Pair equalization is not a valid universal improvement step. Equivalently,

\[
 \partial_i g_k-\partial_j g_k
 =2(p_j-p_i)\{1/v+D/b_k\}.
\]

### 6. Published two-binomial reduction

Mattner, *Extreme expectations of Bernoulli convolutions given their first few moments are attained at shifted convolutions of as few binomials*, arXiv:2204.06040, Theorems 1.1--1.2, implies: **for each fixed finite `n`**, at fixed `(lambda,v)` a maximizer of `b_k` may be chosen with at most two distinct probabilities in `(0,1)`, together with zero and one parameters. Hence the same reduction is available for `H_k` at that fixed dimension.

This reduction is prior work, not a novel theorem here. It still leaves arbitrary multiplicities, a deterministic shift, and two continuous probabilities. For each fixed finite `n`, the fixed-two-moment feasible set is compact, so an optimizer for that conditional problem exists. The arbitrary-dimension supremum reduces to a supremum over such two-block representatives, but neither compactness nor attainment follows after taking the union over every `n`.

Primary source: https://arxiv.org/pdf/2204.06040

### 7. Published sharp concentration constant and implication for the target

Baillon--Cominetti--Vaisman (BCV), *A Sharp Uniform Bound for the Distribution of Sums of Bernoulli Trials*, CPC 25 (2016), 352--361, prove

\[
 \sqrt v\,b_k\le\eta,
 \qquad\eta=\max_{x\ge0}\sqrt{x}e^{-x}I_0(x)
 \approx0.468822355499.
\]

The Fourier proof bounds `b_k` by `exp(-v) I_0(v)`. Their sharpness family uses `m` parameters `a/m` and `m` parameters `1-a/m`, at `k=m`. Stirling's formula transfers this published construction to the present objective and gives the rigorous lower bound

\[
 C_*\ge\sqrt{2\pi}\,\eta.
\]

BCV's construction and concentration theorem must be credited; their application here is a lower bound, **not** an upper bound for the density-ratio objective. In fact `sqrt(m) Poi_m(m)<1/sqrt(2pi)` at finite `m`, so the direct concentration estimate leaves a possible finite-mean excess.

Primary sources:

- https://doi.org/10.1017/S0963548315000127
- https://arxiv.org/pdf/0806.2350
- https://repositorio.uchile.cl/bitstream/handle/2250/139427/A-Sharp-Uniform-Bound.pdf?sequence=1

### 8. Uncompleted routes and precise remaining obstacle

1. Fixed-mean pair equalization fails by Section 5. A different compression is necessary.
2. BCV plus Stirling does not furnish the sharp upper bound. The finite-size deficit of the concentration numerator has to offset the finite-size deficit of the Poisson denominator.
3. The append-zero obstruction restricts any finite global optimizer to `v/lambda>=1/2`, but no sharp bound in that whole regime has been established here.
4. Even exclusion of all finite maximizers above `sqrt(e/2)` would not alone establish the exact constant: maximizing sequences may have bounded mean and a Poisson immigration limit. Such limits would be analytical devices for the original finite class, not an unauthorized redefinition of its scope.

The candidate `C_*=sqrt(2pi) eta` remains a conjecture in these notes.

### 9. Any finite global maximizer must use count index 2, 3, 4, or 5

This section gives an additional **necessary** condition for an attaining finite vector. It does not establish existence or remove bounded-mean limiting laws containing a Poisson component.

#### 9.1 Stronger mean and variance restrictions

Before using (L2), the calculation leading to (D2) also gives

\[
 D_0=\frac{\lambda-k+1}{n-k+1}
 \left\{\frac1v-\frac{2k+1-2\lambda}{\lambda}\right\}.\tag{D5}
\]

At a finite global maximum, `D_0<=0`. Combining this with (L3) yields

\[
 v\ge\frac{\lambda}{2k+1-2\lambda}.\tag{D6}
\]

For every finite positive-variance nonzero parameter vector, `v<lambda` because `S_2>0`. Thus (D6) forces `2k+1-2lambda>1`, or `lambda<k`. In particular,

\[
 k-\frac12\le\lambda<k,\qquad v\ge\lambda/2.\tag{D7}
\]

The case `k=0` is separately irrelevant to a global maximum above one: `b_0<=exp(-lambda)` and `v<=lambda` give `sqrt(v/lambda)b_0/Poi_lambda(0)<=1`. In fact (D7) itself excludes a positive-mean stationary optimizer at `k=0`.

If `k=1`, (D7) gives `lambda<1`. The published Dümbgen--Wellner theorem `log rho<=Delta` for `lambda<=1` implies

\[
 \sqrt{v/\lambda}\,\rho\le e^{\Delta}\sqrt{1-\Delta}
 \le\sqrt{e/2},
\]

where the last scalar inequality has its maximum at `Delta=1/2`. The theorem is stated for parameters below one; the extension to endpoint ones follows by continuity for finite vectors with positive variance. In the present `lambda<1` case no deterministic one is possible anyway.

#### 9.2 A Bessel monotonicity lemma

Define

\[
 f(x)=\sqrt{x}\,e^{-x}I_0(x),\qquad R(x)=I_1(x)/I_0(x),\quad x>0.
\]

**Lemma.** `f` is strictly decreasing for `x>=1`.

**Proof.** The positive defining series are

\[
 I_0(x)=\sum_{j\ge0}\frac{(x^2/4)^j}{(j!)^2},\qquad
 I_1(x)=\frac{x}{2}\sum_{j\ge0}\frac{(x^2/4)^j}{j!(j+1)!}.
\]

Termwise differentiation, justified by convergence on compact intervals, gives `I_0'=I_1` and `I_1'=I_0-I_1/x`. Therefore

\[
 R'=1-R/x-R^2.
\]

Write `h=R-1+1/(2x)`. Then `f'/f=h`. At any zero of `h`, substitution into the preceding differential equation gives

\[
 h'=-1/(4x^2)<0.
\]

At `x=1`, comparison of the positive series gives `2I_1(1)<I_0(1)` (the `j=0` terms agree and every `j>=1` term on the left is smaller), so `h(1)<0`. If `h` had any zero to the right of one, its first such zero would have derivative at least zero from the left, contradicting the displayed strict negative derivative. Hence `h<0` on `[1,infinity)` and the lemma follows. This proof is elementary; the required analytic facts are the stated convergent series and their termwise derivatives.

#### 9.3 Monotonicity of the minimum Poisson denominator

For a positive integer `k`, put

\[
 d_k=\sqrt{k-1/2}\;\operatorname{Poi}_{k-1/2}(k)
 =\frac{e^{-(k-1/2)}(k-1/2)^{k+1/2}}{k!}.
\]

**Lemma.** `d_(k+1)>d_k` for every positive integer `k`.

**Proof.** Set `A=k+1/2>1`. Then

\[
 \log(d_{k+1}/d_k)
 =-1-\log(1+1/(2A))-A\log(1-1/A).
\]

The elementary strict inequalities `log(1+y)<y` for `y>0` and `-log(1-x)>x+x^2/2` for `0<x<1` imply that the right side is strictly larger than

\[
 -1-1/(2A)+A\{1/A+1/(2A^2)\}=0.
\]

Also, for fixed `k`, the logarithmic derivative of `sqrt(lambda) Poi_lambda(k)` is `(k+1/2)/lambda-1`, which is positive for `lambda<k+1/2`. Consequently (D7) implies

\[
 \sqrt\lambda\,\operatorname{Poi}_\lambda(k)\ge d_k.
\]

#### 9.4 Excluding every `k>=6`

At a putative finite global optimizer with `k>=6`, (D7) gives

\[
 v\ge\lambda/2\ge(k-1/2)/2\ge11/4.
\]

Use the BCV Fourier bound `sqrt(v)b_k<=f(v)`, the decreasing property of `f` on `[1,infinity)`, and the increasing property of `d_k`:

\[
 \sqrt{v/\lambda}\frac{b_k}{\operatorname{Poi}_\lambda(k)}
 \le\frac{f(11/4)}{d_6}
 =\frac{720}{\sqrt2}\frac{e^{11/4}I_0(11/4)}{(11/2)^6}
 <\sqrt{e/2}.\tag{K6}
\]

The last strict inequality has a small exact rational certificate. In the series for `I_0(11/4)`, retain terms `j=0,1,2,3`. The first omitted term is `(121/64)^4/(4!)^2`; each subsequent ratio is at most `121/1600`. Therefore

\[
 I_0(11/4)
 \le\sum_{j=0}^{3}\frac{(121/64)^j}{(j!)^2}
 +\frac{(121/64)^4}{(4!)^2}\frac1{1-121/1600}
 =\frac{892383589993}{223321522176}<4.
\]

For `exp(9/2)`, retain terms of degree zero through seven. The first omitted term is `(9/2)^8/8!`; all subsequent term ratios are at most `1/2`. Hence

\[
 e^{9/2}
 \le\sum_{j=0}^{7}\frac{(9/2)^j}{j!}
 +2\frac{(9/2)^8}{8!}
 =\frac{51932849}{573440}<91.
\]

Finally,

\[
 720^2\cdot91\cdot16=754790400
 <(11/2)^{12}=3138428376721/4096.
\]

Squaring the positive quantities in (K6), dividing by `e/2`, and applying these bounds proves its strict inequality. The numerical value `1.149654179776...` is only an explanatory approximation, not the certificate.

#### 9.5 Consequence and unresolved scope

The BCV lower construction gives `C_*>sqrt(e/2)` (a separate exact finite witness establishes the strict comparison). Therefore, if a finite parameter vector attains `C_*`, any count index realizing its ratio maximum must belong to

\[
 \{2,3,4,5\}.
\]

Its mean lies in `[k-1/2,k)`, and its variance is at least `lambda/(2k+1-2lambda)`. The cases `k=2,3,4,5` remain unproved. This restriction also says nothing by itself about nonattaining bounded-mean maximizing sequences with a Poisson immigration limit; those must be handled before asserting an exact universal constant.

Dependency list: BCV's Fourier bound, Dümbgen--Wellner's small-mean theorem, elementary coefficient identities, the two scalar analytic lemmas proved in this section, and an independent strict lower certificate. No statement from the anonymous 2026 variance-bound preprint is used.

### 10. Boundary and multiplicity restrictions in the remaining cases

The elementary identity

\[
 p^2(2p-1)+p/8=2p(p-1/4)^2\ge0
\]

holds for every `p>=0`. If a finite global optimizer has `r` parameters equal to one, then (D3) implies

\[
 0\ge\sum_i p_i^2(2p_i-1)
 \ge r-(\lambda-r)/8,
\]

so `lambda>=9r`. The remaining indices `k=2,3,4,5` have `lambda<5`; hence they cannot contain even one deterministic-one parameter.

Suppose a two-value reduction has `m` parameters equal to `beta>1/2`. Applying the same lower bound to every other parameter gives

\[
 \lambda\ge m\{\beta+8\beta^2(2\beta-1)\}
 =m\beta(4\beta-1)^2.\tag{M1}
\]

For `lambda<5`, this implies `m<=1` if `beta>=3/4`, and `m<=2` if `beta>=7/10`. This is only a necessary multiplicity restriction, not a full extremal classification.

### 11. A necessary Hessian condition at a heterogeneous interior maximum

Assume `0<p_i,p_j<1`, `p_i!=p_j`, and that the full normalized log objective has a local maximum. Put

\[
 L=\frac{2k+1}{2\lambda}-1-\frac1{2v},
 \qquad K=\frac{2k+1}{\lambda^2}-\frac2v.
\]

First-order stationarity gives `(partial_i b_k)/b_k=L+p_i/v`. The pair-difference identity gives `partial_(ij)b_k=-b_k/v`. Consequently the principal two-by-two Hessian matrix indexed by `i,j` is the kernel

\[
 Q(x,y)=K-\frac{(1-2x)(1-2y)}{v^2}
 -2\left(L+\frac{x}{v}\right)\left(L+\frac{y}{v}\right),
\]

evaluated at `x,y in {p_i,p_j}`. Its determinant is

\[
 \frac{2(p_i-p_j)^2}{v^2\lambda^2}
 \left\{(2k+1-2\lambda)^2-3(2k+1)+\frac{6\lambda^2}{v}\right\}.
\]

Negative semidefiniteness therefore requires

\[
 (2k+1-2\lambda)^2-3(2k+1)+\frac{6\lambda^2}{v}\ge0.\tag{H1}
\]

This algebraic condition has been independently expanded and checked symbolically. It does not by itself eliminate the remaining `k=2,3,4,5` cases.

For repeated equal parameters, the Hessian in the direction `(1,-1)` gives `1/v+D_(ii')/b_k>=0`, where `D_(ii')` is the second difference of the twice-deleted law. For a two-value vector `alpha<beta`, if the alpha block has multiplicity at least two, this says that the third difference after deleting two alphas and one beta is nonnegative. If the beta block has multiplicity at least two, the corresponding third difference after deleting one alpha and two betas is nonpositive. These necessary signs are not a proof that either block has multiplicity one.

### 12. Why straightforward Poissonization does not close the proof

At a stationary finite vector, replace one interior parameter `0<p_i<1` by `p_i-epsilon` and append a new `Bernoulli(epsilon)`, so the mean is preserved. Interior stationarity gives `partial_i g_k=0`. The derivative of the full log objective along this path is

\[
 \partial_{\mathrm{new}}g_k-\partial_i g_k=D_0.
\]

At a hypothetical finite global optimizer, `D_0<=0`. Thus the naive infinitesimal splitting of a small probability is non-improving there (strictly decreasing if `D_0<0`). It cannot be used as an unconditional monotone reduction to Poisson immigration. Any valid such reduction needs an additional compensating parameter variation or a different global argument.

Two attempted routes have therefore reached precise obstructions: fixed-mean pair equalization can have a strict unequal local maximum (Section 5), and naive splitting can decrease the target (this section). The current alternative route is the stationary mean/dimension/Hessian classification above. The exact upper constant and bounded-mean immigration limits remain open in this analysis.

# Part V. Exact finite sections and second-order asymptotics

## 1. The complementary section at fixed size and variance

Let \(S\) be a sum of \(m\) independent pairs with probabilities \(p_j,1-p_j\). Write \(b_k=\Pr(S=k)\) and \(v=2\sum_jp_j(1-p_j)>0\). Its mean is \(m\). At fixed \(m,v\), the highest Poisson ratio can be taken at \(k=m\). Over all complementary vectors of the specified variance, the maximal ratio there is
\[
 \frac{1}{\operatorname{Poi}_m(m)}
 \frac1{2\pi}\int_{-\pi}^{\pi}
       \left[1-\frac{v}{m}(1-\cos t)\right]^m\,dt.
 \tag{F1}
\]
Equality in the choice of complementary parameters holds exactly when each pair has the same variance contribution \(p_j(1-p_j)=v/(2m)\), allowing the order within a pair to vary.

For interior probabilities, the generating polynomial has only negative real roots, so Newton's inequalities make \(b_k/\binom{2m}{k}\) log-concave. This sequence is symmetric about \(m\) and maximized there. The other factor \(\binom{2m}{k}/\operatorname{Poi}_m(k)\) has adjacent ratios \((2m-k)/m\), and is also maximized at \(m\). Multiply the two factors. Endpoints in the probabilities follow by continuity.

The characteristic function centered at \(m\) is \(\prod_j[1-2p_j(1-p_j)(1-\cos t)]\), with nonnegative factors. Their arithmetic mean is \(1-(v/m)(1-\cos t)\). Fourier inversion and arithmetic–geometric mean give the bound (F1), with strictness on \(0<t<\pi\) if two pair variances differ. If all pair variances agree, equality follows pointwise. The variance normalization \(\sqrt{v/m}\) is constant on this section.

The same integral without the Poisson denominator is the sharp maximal **point mass** at variance \(v\) for arbitrary \(2m\) independent Bernoulli trials. Indeed, by Fourier inversion with absolute value, the mass at any integer is bounded by the integral of
\[
 \prod_{i=1}^{2m}\big[1-2p_i(1-p_i)(1-\cos t)\big]^{1/2}.
\]
Arithmetic–geometric mean bounds this by the integrand in (F1). Complementary trials with all equal variances attain the resulting bound at their mean \(m\). For other configurations the Poisson denominator may depend on both \(k\) and \(\lambda\), so the point-mass result alone does not optimize the ratio.

Baillon–Cominetti–Vaisman (BCV), §3.2 equation (15), already gives the finite product envelope in variance-normalized form. Their Lemma 7 maximizes the envelope over variances, and Theorem 8 uses identical complementary pairs to attain it at the central count. Fixing the variance here gives the exact section explicitly, and Newton's inequality resolves the global count comparison within the complementary family. [BCV primary text](https://arxiv.org/pdf/0806.2350)

## 2. The sharp second-order loss with a prescribed number of high-probability trials

For a finite Bernoulli parameter vector \(p\), let \(S,\lambda,v\) be its sum, mean, and variance, with \(v>0\). Define
\[
 R(p)=\sqrt{v/\lambda}\max_{k\ge0}
       \frac{\Pr(S=k)}{\operatorname{Poi}_\lambda(k)}.
\]
Write \(C_m\) for its supremum among all finite vectors with exactly \(m\) probabilities strictly above \(1/2\). The total number of trials, all remaining probabilities, and the optimizing count may vary. Let \(C_m^{\mathrm{pair}}\) be the supremum over all sums of \(m\) complementary pairs, without the additional strict-half requirement. Put \(h(x)=e^{-x}I_0(x)\), \(f(x)=\sqrt{x}\,h(x)\), and let \(x_*\) be the unique maximizer of \(f\), so \(\eta=f(x_*)\) and \(C_\infty=\sqrt{2\pi}\eta\).

**Theorem C.** As \(m\to\infty\),
\[
 m(1-C_m/C_\infty)\longrightarrow \frac1{24},
 \qquad
 m(1-C_m^{\mathrm{pair}}/C_\infty)\longrightarrow \frac16 .
 \tag{F2}
\]
Thus for large \(m\), \(C_m<C_\infty\), and certain noncomplementary vectors strictly exceed the entire complementary family of \(m\) pairs for the optimized density ratio.

**Construction for the lower bound on \(C_m\).** Set \(q=x_*/(2m)\). Take \(m\) trials with probability \(1-q\) and \(m^2\) trials with probability \(q/m\). Their mean is exactly \(m\). If \(s_i=p_i(1-p_i)\) and \(S_2=\sum_i s_i^2\), then \(v=x_*+O(m^{-1})\), \(S_2=x_*^2/(4m)+O(m^{-2})\) and \(\sum_i s_i^3=O(m^{-2})\). Use \(A(t)=1-\cos t\) on \([-\pi,\pi]\). The logarithm of the centered characteristic function's modulus is \(-vA(t)-S_2A(t)^2+O(m^{-2})\), uniformly, by Taylor expansion. The characteristic function is the product of independent rare successes and the negatives of independent rare failures. Its log phase has linear terms \(\pm r\sin t\) for a rare event of probability \(r\), and their total cancels because the two rare intensities are equal. The higher terms have sum \(O(\sum_i r_i^2)=O(m^{-1})\), uniformly. Thus in taking the real part in Fourier inversion, the phase costs only \(O(m^{-2})\). In particular at \(k=m\),
\[
 b_m=h(v)-S_2h''(v)+O(m^{-2}).
 \tag{F3}
\]
Use \(f(v)=\eta+O(m^{-2})\) from stationarity at \(x_*\). The Bessel equation yields \(xh''+(2x+1)h'+h=0\). At \(x_*\), \(h'/h=-1/(2x_*)\), and hence \(h''(x_*)/h(x_*)=1/(2x_*^2)\). Therefore the variance-normalized point mass in (F3) is \(\eta(1-1/(8m)+O(m^{-2}))\). The Poisson denominator satisfies \(\sqrt m\operatorname{Poi}_m(m)=(2\pi)^{-1/2}(1-1/(12m)+O(m^{-2}))\) by Stirling's formula. Their quotient gives the stated lower side and already shows \(\liminf_m C_m\ge C_\infty\).

**Upper bound over all \(m\)-high vectors.** Because \(\lambda\ge m/2\), Theorem A gives the matching first-order upper limit. Choose a vector of value within \(o(m^{-1})\) of \(C_m\) for each \(m\). Theorem B gives \(v\to x_*\), \(\lambda=m+o(1)\), and ultimately \(k=m\) for every maximizing count on this sequence. Also each trial is uniformly close to either zero or one, with both the total rare successes and the total rare failures tending to \(x_*/2\).

The modulus of an individual characteristic function is \([1-2s_i A(t)]^{1/2}\le e^{-s_iA(t)-s_i^2A(t)^2}\). The inequality follows from \(\log(1-u)\le-u-u^2/2\) for \(0\le u<1\) and extends by continuity when the factor vanishes. Therefore \(b_m\le(2\pi)^{-1}\int e^{-vA-S_2A^2}\). Among the \(m\) high probabilities, Cauchy–Schwarz gives
\[
 S_2\ge m^{-1}\left(\sum_{p_i>1/2}s_i\right)^2
       = m^{-1}(x_*^2/4+o(1)).
\]
Their variances sum to \(x_*/2+o(1)\), because subtracting the squared rare failures changes the sum by \(o(1)\). Substituting this lower bound in the decreasing Fourier integral permits Taylor expansion without any upper bound on the actual \(S_2\). In particular,
\[
 \sqrt v\, b_m
 \le f(v)-\frac{x_*^2}{4m}\sqrt{x_*}h''(x_*)+o(m^{-1})
 \le \eta(1-1/(8m)+o(m^{-1})).
\]
Put \(\delta_m=\lambda-m=o(1)\). Compared to the centered Poisson denominator, the log correction in \(\sqrt\lambda\,\operatorname{Poi}_\lambda(m)\) is \((m+1/2)\log(1+\delta_m/m)-\delta_m=o(m^{-1})\). That denominator therefore has the same Stirling correction \(-1/(12m)\). Dividing proves the upper side of the first limit in (F2).

**Complementary pairs.** Their mean is \(m\) and §1 identifies a maximizing central count. Take identical pairs with rare probability \(x_*/(2m)\), so \(v=x_*+O(m^{-1})\), \(S_2=x_*^2/(2m)+O(m^{-2})\), and the log phase cancels exactly. Equation (F3) with this \(S_2\) shows first-order value \(C_\infty\) and normalized numerator loss \(1/(4m)\). Conversely any first-order near maximizer has \(v\to x_*\) by Theorem B and its \(2m\) trials entail \(S_2\ge v^2/(2m)\). Substitute that lower bound into the same integral to get the matching numerator loss. The common denominator correction gives \(1/4-1/12=1/6\). Since \(1/24<1/6\), the explicit noncomplementary construction eventually exceeds \(C_m^{\mathrm{pair}}\).

## 3. Verification and comparison

The source of the concentration constant, finite Fourier envelope and first-order complementary witnesses is BCV. Dümbgen–Wellner's Theorems 1–2 and equation (6) concern the true Poisson density ratio, controlling it by such quantities as the largest trial probability or the mean-weighted second-moment parameter. Part V addresses a different optimized correction to the asymptotic plateau, with both all-count maximization and unbounded numbers of low-probability trials. The second-order term exploits square sums of the two rare populations, and the construction realizes the improvement for the true finite-law ratio. [BCV, §3.2](https://arxiv.org/pdf/0806.2350) · [Dümbgen–Wellner](https://arxiv.org/pdf/1910.03444)

The supplementary Fourier calculation evaluates the center of the two explicit trial families, including at \(m=1024\), where the scaled losses are about \(0.1666780\) for pairs and \(0.0418000\) for the unequal population sizes. These are convergence diagnostics on exact finite-law formulas. The proof of both limits is analytic. [Numerical replay](evidence/r01/check.py)

# The remaining unrestricted problem


The completed results leave a strict interval for the unrestricted constant. A sufficient remaining inequality is
\[
\sqrt v\,b_k\le
\eta\sqrt{2\pi\lambda}\,e^{-\lambda}\frac{\lambda^k}{k!}
\]
for every logistic stationary finite Bernoulli vector with \(k\ge2\). The known BCV inequality omits the finite Poisson correction on the right. Its omission cannot be repaired by taking a large-mean limit in a bounded-mean problem.

The alternative compactification route must handle positive Poisson immigration together with nontrivial Bernoulli blocks. The relevant stationary equations contain an additional curvature term. The exact algebraic counterexamples in the exploration directory show that deleting that term is invalid.

Part V rules out exceeding the asymptotic plateau once the number of high-probability trials is sufficiently large. The exact unrestricted constant, finite equality classification and exact finite-$m$ suprema remain open.
