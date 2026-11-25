# Strong leave-one-out duality for nonparametric mean tests

## Abstract

Zhu and Duchi use pointwise dual certificates to control finite-sample rejection probability under leave-one-out conditional mean constraints, leaving strong duality unasserted. We prove equality of the worst-case expectation and the pointwise certificate bound for every bounded upper semicontinuous reward on the full nonnegative sample space. Nonnegative bounded continuous multipliers suffice, and a least favorable joint law exists. For coordinatewise increasing Borel rejection regions, the same dual equality holds without closedness. A finite-grid linear program approximates the exact worst-case rejection probability with a universal explicit error bound, without tail or moment assumptions beyond the null itself.

## 1. Strong duality on the nonnegative orthant

Let $\mathcal N$ consist of joint probability laws on $\mathcal X=[0,\infty)^n$ satisfying
$$E_P[X_i\mid X_{-i}]\le1\quad P\text{-almost surely},\qquad i=1,\ldots,n.$$
The null allows dependence. It implies finite first moments at most one in each coordinate. For bounded upper semicontinuous $f:\mathcal X\to\mathbb R$, define
$$v(f)=\sup_{P\in\mathcal N}E_Pf(X).$$

**Theorem 1.** The supremum is attained and
$$
v(f)=\inf_{\lambda_i\in C_b([0,\infty)^{n-1}),\,\lambda_i\ge0}
 \ \sup_{x\in\mathcal X}
 \left\{f(x)-\sum_{i=1}^n\lambda_i(x_{-i})(x_i-1)\right\}. \tag{1}
$$
For $n=1$, a multiplier is a nonnegative constant. In particular, the pointwise certificate form in Zhu and Duchi's §1.1 is sharp for every closed rejection region. For a closed region of worst-case size strictly below $\alpha$, a certificate with right-hand bound $\alpha$ exists. At equality, (1) guarantees arbitrary accuracy of the bound.

**Proof.** Put $S(x)=\sum_i x_i$, and write $\mathcal P_s=\{P:E_PS\le s\}$ for $s\ge0$. The set $\mathcal P_n$ is convex and weakly compact. Markov's inequality proves tightness from the common first-moment bound, and lower semicontinuity of $S$ proves that the set is weakly closed. On $\mathcal P_n$, the leave-one-out inequalities are equivalent to
$$ E_P[\lambda_i(X_{-i})(X_i-1)]\le0
\quad\text{for every nonnegative bounded continuous }\lambda_i. \tag{2} $$
Indeed, the signed measure $A\mapsto E_P[(X_i-1)\mathbf1_{\{X_{-i}\in A\}}]$ is finite. If it has positive part, regularity on the Euclidean orthant gives a nonnegative continuous bounded test function with positive integral: take a compact subset of a positive Hahn set and a small open neighborhood whose negative mass is arbitrarily small, and a continuous cutoff equal to one on that compact subset and zero outside the neighborhood. Hence (2) says this measure is nonpositive, which is equivalent to the conditional inequality. The integrand in (2) is continuous and bounded from below. Its expectation is lower semicontinuous under weak convergence. Thus $\mathcal N$ is closed within $\mathcal P_n$ and weakly compact. The bounded upper semicontinuous reward gives an upper semicontinuous expectation, so the supremum is attained.

Define
$$f_\lambda(x)=f(x)-\sum_i\lambda_i(x_{-i})(x_i-1).$$
For fixed $\lambda$, $f_\lambda$ is upper semicontinuous and bounded above, so $P\mapsto E_Pf_\lambda$ is upper semicontinuous on $\mathcal P_n$. The objective is finite and affine in $P$ there. For fixed $P\in\mathcal P_n$ it is affine and continuous in the multipliers with the sup norm, since the first moments are finite. The cone of multiplier tuples is convex. Sion's minimax theorem gives
$$
v(f)=\sup_{P\in\mathcal P_n}\inf_{\lambda\ge0} E_P f_\lambda
    =\inf_{\lambda\ge0}\sup_{P\in\mathcal P_n}E_P f_\lambda. \tag{3}
$$
The first identity follows from (2): the inner infimum is $E_Pf$ for feasible $P$, and a violated constraint can be multiplied without bound otherwise.

For each fixed tuple $\lambda$, the function
$$\Gamma_\lambda(s)=\sup_{P\in\mathcal P_s}E_P f_\lambda$$
is finite, nondecreasing and concave on $s\ge0$. It is bounded below by its value at the all-zero point mass and bounded above by the pointwise upper bound on $f_\lambda$. Concavity follows by mixing nearly maximizing laws. At the interior point $s=n>0$ it has a finite supporting slope $\eta\ge0$. In particular a Dirac measure at $x$ gives
$$f_\lambda(x)\le\Gamma_\lambda(S(x))
 \le\Gamma_\lambda(n)+\eta(S(x)-n).$$
The support-line inequality extends to $s=0$ by monotonicity. Consequently
$$\Gamma_\lambda(n)
 =\sup_{x\in\mathcal X}\{f_\lambda(x)-\eta(S(x)-n)\}.$$
For the reverse inequality to the pointwise upper bound, integrate the bracket against any $P\in\mathcal P_n$, for which the last term has nonnegative expectation, and take the supremum. Absorb the extra term into the multipliers by replacing every $\lambda_i$ with $\lambda_i+\eta$. Equation (3) now shows that the right-hand side of (1) is at most $v(f)$. For the other direction, integrate any pointwise certificate against $P\in\mathcal N$ and use (2). $\square$

## 2. Increasing rejection regions and finite-grid approximation

For a Borel set $R\subset\mathcal X$ put $v(R)=\sup_{P\in\mathcal N} P(R)$. Call $R$ increasing if $x\in R$ and $y\ge x$ coordinatewise imply $y\in R$.

**Theorem 2.** For increasing Borel $R$, (1) holds with $f=\mathbf1_R$. For any mesh $a>0$ and $M=Ka$ with $K$ a positive integer, let $G=\{0,a,\ldots,M\}$ and let $v_G(R)$ be the supremum over the laws in $\mathcal N$ supported on $G^n$. Then
$$
v_G(R)\le v(R)\le
 \min\{1,(1+a)^n v_G(R)+n/M\},\qquad
0\le v(R)-v_G(R)\le na+n/M. \tag{4}
$$

**Proof.** For any $x\in\overline R$ and $\delta>0$, some $y\in R$ is within $\delta$ of $x$ in supremum norm, so $x+\delta\mathbf 1\in R$. For $X\sim P\in\mathcal N$ let $B_i$ be independent Bernoulli variables with mean $1/(1+\delta)$, independent of $X$, and put $Y_i=B_i(X_i+\delta)$. Conditional on $(X_{-i},B_{-i})$, the expectation of $Y_i$ is at most one by the null and the scaling. It remains at most one conditional on $Y_{-i}$ by the tower property. Thus $Y$ has a feasible law and $\Pr(Y\in R)\ge (1+\delta)^{-n}P(\overline R)$. Letting $\delta$ decrease to zero shows $v(R)=v(\overline R)$. For each continuous multiplier tuple the pointwise suprema with $\mathbf1_R$ and $\mathbf1_{\overline R}$ are equal. At a point of $\overline R\setminus R$, approach it through points of $R$ and use continuity of the penalty. Theorem 1 for $\overline R$ now gives (1) for $R$.

For (4), replace the shift by upward rounding and truncation $T(x)=\min(M,a\lceil x/a\rceil)$ and take $Y_i=B_i T(X_i)$ with independent means $1/(1+a)$. Since $T(x)\le x+a$, the same conditional argument proves feasibility. The rounded values lie in $G$. If $X\in R\cap[0,M]^n$ and all $B_i=1$, then $Y\ge X$ and $Y\in R$. By Markov's inequality $\Pr(X\notin[0,M]^n)\le n/M$. It follows that
$$v_G(R)\ge (1+a)^{-n}(v(R)-n/M).$$
Together with $v_G(R)\le v(R)$ and $1-(1+a)^{-n}\le na$, this proves both bounds in (4). $\square$

On $G^n$ write $p_x$ for each mass. The finite linear program maximizes $\sum_{x\in R\cap G^n}p_x$ over nonnegative masses summing to one subject to
$$
\sum_{t\in G}(t-1)p_{(x_{-i},t)}\le0
\quad\text{for every }i\text{ and }x_{-i}\in G^{n-1},
$$
where $t$ occupies coordinate $i$. These are exactly the conditional inequalities, including zero-probability fibers. With a rational mesh and region membership specified on the grid, this is a rational linear program. An exact feasible law gives a lower bound. Its optimum, or a certified finite-program upper bound, gives a continuum upper bound through (4). The explicit window can be made arbitrarily small by taking $a$ small and $M$ large, with no unknown moment constants. A primal maximizer can fail to exist for increasing nonclosed regions. For example, with $n=1$ and $R=(c,\infty)$ for $c>1$, the worst-case probability is $1/c$, approached with support $\{0,c+\epsilon\}$ and strict under every single feasible law.

## 3. An exact certificate and least favorable law

Consider the increasing closed region $R=\{\max_i x_i\ge c\}$ for $c>1$. Let $d(x)=(1-x/c)_+$ and $b=1-1/c$. Then $\mathbf1_R(x)\le1-\prod_i d(x_i)$ and
$$b^n-\prod_i d(x_i)
=\sum_{i=1}^n b^{n-i}(b-d(x_i))\prod_{j<i}d(x_j)
\le\sum_{i=1}^n \frac{b^{n-i}}c(x_i-1)\prod_{j<i}d(x_j).$$
The last inequality follows from $d(x)\ge1-x/c$. This supplies bounded continuous pointwise multipliers at size $1-b^n$. The independent law assigning mass $1/c$ to $c$ and the rest to zero in every coordinate is feasible and attains this size. On a grid where the first value at least $c$ is $c_G$, the exact grid size is $1-(1-1/c_G)^n$, by applying the same result at $c_G$ and using the corresponding two-point law on the grid. If the grid has no value at least $c$, the grid size is zero.

## References

- Yifan Zhu and John C. Duchi. *Finite-sample nonparametric mean tests: Leave-one-out duality and asymptotic optimality*. arXiv:2609.05360v1, 2026. §1.1 and Lemma 2.1. <https://arxiv.org/abs/2609.05360>
- Maurice Sion. *On general minimax theorems*. Pacific Journal of Mathematics, 8(1), 171–176, 1958. The one-compact-side minimax corollary. <https://msp.org/pjm/1958/8-1/pjm-v8-n1-p14-p.pdf>
