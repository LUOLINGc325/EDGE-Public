# Measurable leave-one-out duality for countable rewards

*Exact bounded certificates from finite coordinate grids*

## 1. Setting and result

Let $\mathcal X=[0,\infty)^n$ and let $\mathcal N$ consist of the joint laws satisfying
$E[X_i\mid X_{-i}]\le1$ for each $i$. Zhu and Duchi (2026), §1.1, obtain pointwise upper bounds by nonnegative leave-one-out multipliers and leave strong duality open in their formulation. We prove a strong measurable version for countably supported nonnegative objectives, including nonclosed and nonmonotone rejection regions.

Let $0\le f\le M$ be Borel and suppose $\{x:f(x)>0\}$ is countable. Define
$$
v(f)=\sup_{P\in\mathcal N}E_Pf,\qquad
D_b(f)=\inf_{\lambda_i\in B_b,\ \lambda_i\ge0}\sup_{x\in\mathcal X}
 \left[f(x)-\sum_{i=1}^n\lambda_i(x_{-i})(x_i-1)\right],
$$
where $B_b$ denotes bounded Borel functions.

**Theorem.** For every such $f$, $D_b(f)=v(f)$. If the support of positive values lies in $[0,B]^n$ for a finite $B\ge0$, the infimum is attained. In that case there is a certificate
$$
 f(x)\le v(f)+\sum_i\lambda_i(x_{-i})(x_i-1)
 \quad\text{for every }x\in\mathcal X
$$
with each $\lambda_i$ at most
$$
 v(f)\sum_{j=0}^{n-1}(nB)^j.
\tag{1}
$$
For unbounded support, truncate at $[0,B]^n$ with $B>0$. A certificate for the original $f$ of value at most $v(f)+Mn/B$ is then obtained by adding constant multipliers $M/B$ to those of the truncated objective.

Weak duality holds by integration of each nonnegative bounded multiplier, so it suffices to construct the certificates.

## 2. Approximation by finite coordinate grids

For each coordinate $i$, form the countable set $S_i$ of its values on $\{f>0\}$, together with zero. Choose finite increasing subsets $S_{i,m}$ containing zero whose union is $S_i$. Let $T_{i,m}(x)=x$ for $x\in S_{i,m}$ and $T_{i,m}(x)=0$ otherwise. For $X$ with a feasible law, coordinatewise reset preserves feasibility. Indeed $0\le T_{i,m}(X_i)\le X_i$, and the other reset coordinates are measurable in $X_{-i}$. The tower property therefore gives
$$
E[T_{i,m}(X_i)\mid(T_{j,m}(X_j))_{j\ne i}]\le1 .
$$
Write $G_m=\prod_i S_{i,m}$. On $G_m$ the reset is the identity, so nonnegativity gives
$$
E[f(T_m(X))]\ge E[f(X)\mathbf1_{\{X\in G_m\}}]\longrightarrow E[f(X)].
$$
The convergence uses monotone exhaustion of the positive support. The finite-grid optimum $v_m$ among feasible laws supported on $G_m$ therefore increases to $v(f)$.

On every $G_m$ the conditional constraints are the finite set
$$
 \sum_{x_i\in S_{i,m}}(x_i-1)p_x\le0
 \quad\text{for each }i\text{ and opposing tuple }x_{-i}.
$$
Together with nonnegative masses of total one, these form a feasible bounded linear program. Its dual has one nonnegative multiplier for each constraint and an unrestricted root value. Finite linear programming duality gives a certificate on $G_m$ of value $v_m$, hence also a certificate at the common value $c=v(f)$.

## 3. Uniform bounds and an attained certificate

Suppose $\{f>0\}\subset[0,B]^n$. Fix any feasible tuple of finite-grid multipliers at value $c\ge0$. At an opposing tuple $y=x_{-i}\in\prod_{j\ne i}S_{j,m}$, use the grid point with $x_i=0$ and the prescribed $y$. Since $f$ is nonnegative, its certificate yields
$$
\lambda_i(y)
 \le c+\sum_{\substack{j\ne i\\ y_j>1}}(y_j-1)
      \lambda_j((0,y)_{-j}).
\tag{2}
$$
Here $(0,y)$ means the vector inserting zero in coordinate $i$. Negative penalty terms were dropped using nonnegativity of the multipliers. Every tuple on the right has one fewer coordinate exceeding one than $y$. If none exceed one, $\lambda_i(y)\le c$. Inducting on the number $r$ of such coordinates gives the uniform bound $c\sum_{j=0}^r(nB)^j$, since the sum of positive coefficients in (2) is at most $nB$. In particular all multipliers obey (1).

Take a finite-grid dual tuple at value $c=v(f)$ for each $m$. Extend by zero to all opposing tuples in the countable set $\prod_{j\ne i}S_j$. By boundedness and a diagonal subsequence, these tuples converge coordinatewise simultaneously. Each point of $\prod_iS_i$ lies in all sufficiently large grids, so its certificate inequality passes to the limit. All limits are nonnegative and satisfy (1).

Now let $T_i(x)=x$ on $S_i$ and zero elsewhere. Compose the limiting multiplier with $T_{-i}$. The resulting function is Borel because each $S_i$ is countable and all fibers of the map are Borel. Its bound is unchanged. Also $f(x)\le f(T(x))$: if $f(x)>0$ the vector is fixed, and otherwise the assertion follows from nonnegativity. Since each $T_i(x_i)\le x_i$, the certificate on $\prod_i S_i$ extends pointwise to $\mathcal X$ with the composed multipliers. This attains the dual infimum in the bounded-box case.

For an unbounded countable positive support, let $f_B=f\mathbf1_{[0,B]^n}$. The removed reward is bounded by $M\mathbf1_{\{\max_i x_i>B\}}$, which in turn is bounded by
$$
\frac{M}{B}\sum_i x_i=\frac{Mn}{B}
  +\sum_i\frac{M}{B}(x_i-1).
$$
Add this to the attained certificate for $f_B$. Its value is at most $v(f_B)+Mn/B\le v(f)+Mn/B$. Letting $B\to\infty$ proves the equality. $\square$

## 4. Consequences

For any countable Borel rejection region, bounded measurable multipliers give its exact worst-case size, with an attained certificate for bounded regions. The law that attains the supremum can still fail to exist. For example, for $n=1$ and $S=\{a+1/j:j\ge1\}$ with $a>1$, the pointwise certificate $\alpha=1/a,\ \lambda=1/a$ gives the size $1/a$, approached by the mean-one two-point laws on $\{0,a+1/j\}$. No feasible law attains it, since any positive mass on $S$ has coordinate value strictly above $a$ there.

The companion closure-gap case gives a bounded countable two-coordinate region whose continuous-multiplier dual is $3/4$ while its measurable dual and primal both equal $2/3$. Here the countable-support result applies to arbitrary such regions without needing that example's geometry.

## Sources

- Y. Zhu and J. C. Duchi, *Finite-sample nonparametric mean tests: Leave-one-out duality and asymptotic optimality*, arXiv:2609.05360v1, §1.1 and Lemma 2.1. [Official full text](https://arxiv.org/html/2609.05360v1).
- *Nearly unit gaps for continuous leave-one-out dual certificates*. [Companion case](../loo-continuous-dual-closure-gap/paper.zh.md).
