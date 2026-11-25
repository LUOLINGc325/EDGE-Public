# The trivariate two-sided Gaussian Simes inequality near level one

## Abstract

For three centered Gaussian statistics, we prove the two-sided Simes inequality at levels sufficiently close to one, uniformly over every correlation cap strictly below one. The covariance may be singular. The key quantity is the coefficient of the nonrejection probability at the level-one endpoint. It is a sum of three explicit conditional bivariate probabilities and strictly exceeds the independent coefficient whenever any correlation is nonzero. A local density expansion controls the vanishing gap near independence. We give an explicit conservative cutoff.

## 1. Model and conclusion

Let $Z\sim N_3(0,\Sigma)$ with unit marginal variances and set $P_i=2\overline\Phi(|Z_i|)$, where $\overline\Phi=1-\Phi$ is the standard normal survival function. Write $F_\Sigma(q)$ for the probability that Simes rejects at level $q$: $P_{(j)}\le jq/3$ for some $j\in\{1,2,3\}$. Zhang (2026) proves covariance-uniform validity for small levels and proves trivariate validity at $0.05$ and on an interval around it. The all-level inequality remains open there.

**Theorem.** Fix any $0\le r<1$. For every positive semidefinite correlation matrix with $\max_{i<j}|\Sigma_{ij}|\le r$,
$$
F_\Sigma(q)\le q\qquad\text{if}\qquad
1-10^{-60}\sqrt{1-r^2}\le q<1.
$$
In this range equality holds exactly at $\Sigma=I_3$. The cutoff proved below is deliberately conservative.

There is also a uniform endpoint expansion. Put $A_0=\Phi^{-1}(5/6)$ and $B_0=\Phi^{-1}(2/3)$. Let $R$ be the set of $(y_1,y_2)$ such that both absolute values are below $A_0$ and at least one is below $B_0$. For $i=1,2,3$, set $s_i(\Sigma)=\Pr(Z_{-i}\in R\mid Z_i=0)$ using the Gaussian conditional law. Put $s(\Sigma)=\sum_i s_i(\Sigma)$. If $h=1-q$ and $0<h\le1/10$, then
$$
\left|\frac{1-F_\Sigma(q)}h-s(\Sigma)\right|
\le \frac{250h}{\sqrt{1-r^2}}. \tag{1}
$$
The coefficient is $1$ at independence and strictly greater than $1$ at every other covariance in this cap.

## 2. Endpoint expansion by conditioning

Set
$$ A=\Phi^{-1}(1-q/6),\quad B=\Phi^{-1}(1-q/3),\quad C=\Phi^{-1}(1-q/2). $$
Boundary events have probability zero by marginal continuity. Nonrejection is the union of three events
$$ E_i=\{|Z_i|<C,\ \max_{j\ne i}|Z_j|<A,\ \min_{j\ne i}|Z_j|<B\}. $$
Indeed the Simes constraints require all coordinates below $A$, at most one absolute value above $B$, and at least one coordinate below $C$. Since $C<B$, these are equivalent to the displayed union.

For $q\ge9/10$, Chebyshev's inequality gives $A<2$, because $\Pr(|N(0,1)|\ge2)\le1/4<q/3$. On $[0,2]$ the normal density $\phi$ exceeds $1/25$, using $e^2<8$ and $\sqrt{2\pi}<3$. Differentiating the quantiles gives $|A-A_0|,|B-B_0|\le9h$. Also $C\le2h$: $\phi(1/2)>1/4$ first implies $C<1/2$, and then $h=2\int_0^C\phi(u)\,du\ge C/2$.

Write $v=\sqrt{1-r^2}$. Given $Z_i=x$, the two residual coordinates have mean vectors with entries $\Sigma_{ij}x$ and fixed standard deviations at least $v$. For $|x|\le C$, the conditional acceptance condition differs from the one at $x=0,q=1$ only within a distance $11h$ of either absolute threshold in either coordinate. Each such band on the real line has length at most $44h$. Using the marginal density bound $1/(\sqrt{2\pi}v)<(2/5)/v$ and the probability $h$ of the conditioning strip gives
$$\left|\Pr(E_i)-h s_i(\Sigma)\right|\le(352/5)h^2/v.$$
For pair overlaps, the bivariate density bound is $1/(2\pi v)<1/(6v)$ and the square $[-C,C]^2$ has area at most $16h^2$. Summing three conditional errors and three pair overlaps gives a total strictly below $250h^2/v$. This proves (1), including when the joint three-dimensional distribution is singular.

## 3. The endpoint coefficient has a positive gap

First, for any two standardized centered Gaussian variables, the probability of lying in $R$ is at least $1/3$. This is the two-test Simes inequality at level $2/3$. To see it directly for any level $\alpha$, put $H_\alpha(u)=\Pr(P_2\le\alpha\mid P_1=u)$. Conditional on the absolute value of the first normal, the tail probability of the absolute value of the second is nondecreasing in that first absolute value. For nondegenerate bivariate normals this follows by differentiating the normal two-sided tail in the magnitude of its mean. It also holds at correlation $\pm1$. Hence $H_\alpha$ is nonincreasing. Inclusion–exclusion and exchangeability give two-test Simes rejection probability
$$\alpha+\int_{\alpha/2}^{\alpha}H_\alpha(u)\,du
-\int_0^{\alpha/2}H_\alpha(u)\,du\le\alpha.$$

For $s_i(\Sigma)$, standardize the centered conditional variables given $Z_i=0$. Their variances are $1-\Sigma_{ij}^2$ and $1-\Sigma_{ik}^2$. Starting from their standardized pair, scaling each coordinate by its standard deviation can only increase membership in $R$. Thus all three $s_i\ge1/3$. For a quantitative gap, fix $0<\delta_0\le1/8$ and suppose $|\Sigma_{ij}|\ge\delta_0$ for some pair. Define
$$u_0=B_0\delta_0^2/4,\qquad J=\{x:B_0<|x|<B_0+u_0\},\qquad p_0=\Pr(N(0,1)\in J).$$
We have $B_0+u_0<A_0$. In fact $A_0-B_0\ge1/6$ by the upper density bound one, and $u_0\le\delta_0^2/2$. Both standardized residual variables lying in $J$ puts them outside $R$, whereas contraction of coordinate $j$ by a factor at most $\sqrt{1-\delta_0^2}$ puts them inside $R$. The latter follows from $\sqrt{1-\delta_0^2}(1+\delta_0^2/4)<1$.

The probability that both standardized residual variables lie in $J$ is at least $p_0^2$. Indeed after a sign change, which leaves $J$ invariant, represent two normals with absolute correlation $\rho'$ by $\sqrt{\rho'}W+\sqrt{1-\rho'}W_\ell$, $\ell=1,2$, with independent standard normals $W,W_1,W_2$. Conditional on $W$ the two membership probabilities agree and their joint probability is the square. Jensen applies also at $\rho'=1$. As $B_0\ge1/6$ and $\phi(x)>1/25$ on $[B_0,B_0+u_0]$, $p_0\ge\delta_0^2/300$. Thus
$$s(\Sigma)\ge1+p_0^2\ge1+\delta_0^4/90000
\qquad\text{if}\qquad \max|\Sigma_{ij}|\ge\delta_0. \tag{2}$$
Taking $\delta_0$ arbitrarily small proves the strict endpoint coefficient claim for every nonzero correlation.

For example, at the singular equicorrelation matrix with all off-diagonal entries $-1/2$, conditioning on any $Z_i=0$ leaves two opposite Gaussian variables of standard deviation $\sqrt{3}/2$. Thus $s(\Sigma)=3[2\Phi(2B_0/\sqrt{3})-1]$, which lies in $(1.14319,1.14320)$ by the rational series enclosure accompanying this manuscript.

## 4. A quadratic gap near independence

Let $\delta=\max_{i<j}|\Sigma_{ij}|>0$. For $\delta\le1/8$, write $\Sigma=I+\delta M$ where $M$ is symmetric, has zero diagonal and norm at most two. Use the Gaussian density with covariance $I+tM$ as an analytic function of complex $t$ near zero, with determinant square root fixed at $t=0$. On $|t|=1/4$, the inverse has operator norm at most two and the determinant factor has modulus below three. At $z\in[-2,2]^3$ the density has modulus at most $3e^{12}$. By Cauchy's coefficient estimate, the Taylor remainder after degree two is at most $128\cdot3e^{12}\delta^3<10^8\delta^3$ on the real interval $0<\delta\le1/8$.

The nonrejection region $\mathcal N$ is even in each coordinate. Linear covariance terms integrate to zero, as do mixed terms of degree two in distinct correlations. For example, changing the sign of a coordinate that belongs to only one of the two covariance pairs makes the mixed term odd. The pure second derivative for the pair $(i,j)$ at independence is the product density times $H_2(z_i)H_2(z_j)$, where $H_2(x)=x^2-1$. This follows by differentiating the bivariate normal density twice at correlation zero; the third coordinate remains independent. The volume of $\mathcal N$ is at most $3(2C)4^2\le192h$. Consequently
$$1-F_\Sigma(q)
=h+\frac12 K(q)\sum_{i<j}\Sigma_{ij}^2+\mathcal E,
\qquad |\mathcal E|\le2\cdot10^{10} h\delta^3, \tag{3}$$
where $K(q)=E[H_2(X_1)H_2(X_2)\mathbf 1_{\{X\in\mathcal N\}}]$ for three independent standard normals. At independence, Simes has exact level, giving the first term $h$.

For $a=2A_0\phi(A_0)$ and $b=2B_0\phi(B_0)$, we have
$$\left|\frac{K(q)}h-k_0\right|\le6000 h,\qquad
k_0=\frac{2(a+b)}3+2ab-b^2>\frac1{40}. \tag{4}$$
To derive $k_0$, separate the three strips $E_i$ at their $x=0,q=1$ limits. The one-normal probabilities of the absolute intervals below $A_0$ and $B_0$ are $2/3$ and $1/3$, and their $H_2$ integrals are $-a$ and $-b$ by integration by parts. The rectangular union defining $R$ gives the one-coordinate moment $-(a+b)/3$ and product moment $2ab-b^2$. The first two strips multiply the one-coordinate moment by $H_2(0)=-1$, while the third contributes the product moment. Since $0<b\le1/3$ and $A_0>1/2$ gives $a>1/25$, we obtain $k_0\ge2a/3>1/40$.

For the error in (4), on the relevant sets the moment integrand has absolute value at most nine, so strip overlaps contribute at most nine times the sum of their pair probabilities, which is at most $432h^2$ using $C\le2h$ and the independent joint densities bounded by one. Within any one strip, the acceptance region changes only in four absolute-threshold bands. Their total probability is bounded by $176h$, as in Section 2 with no mean shift and unit standard deviations. Changing a strip-coordinate factor from $H_2(x)$ to $H_2(0)$ changes the product by at most $12h^2$ when the strip coordinate is part of the product. After multiplying each conditional error by the strip probability $h$, the total error is at most $432h^2+3h(9\cdot176h+12h^2)\le6000h^2$.

For $h\le10^{-6}$, (4) gives $K(q)\ge h/80$. Taking $0<\delta\le10^{-13}$ in (3) now gives
$$1-F_\Sigma(q)-h
\ge h\delta^2(1/160-2\cdot10^{10}\delta)>0. \tag{5}$$
For $\delta\ge10^{-13}$, use (1) and (2) with $\delta_0=10^{-13}$. If $h\le10^{-60}v$, the error $250h/v$ is strictly smaller than $\delta_0^4/90000$. This proves the theorem over the entire cap. At independence $F_\Sigma(q)=q$ for every $q$ by the Simes identity.

## 5. Scope and references

The result complements Zhang's small-level and local $0.05$ ranges by treating a neighborhood of one, with explicit dependence on the pairwise cap. When pair correlations are allowed to reach one simultaneously with $q\to1$, intersections of two near-zero strips require a different analysis. The expansion and cutoff here concern the cap $r<1$.

- Xianyang Zhang. *Exact Simes inequalities for two-sided Gaussian tests*. arXiv:2611.02513v1, 2026. Introduction, Theorem 2.1, and §3. <https://arxiv.org/abs/2611.02513v1>
- R. John Simes. *An improved Bonferroni procedure for multiple tests of significance*. Biometrika 73(3), 751–754, 1986. <https://doi.org/10.1093/biomet/73.3.751>
