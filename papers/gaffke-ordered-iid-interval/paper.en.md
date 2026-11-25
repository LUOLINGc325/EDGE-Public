# Deterministic ordered-sample refinement of Gaffke confidence intervals

## Abstract

Ming et al. exhibit an externally randomized improvement of Gaffke's merger but leave open how test improvements can produce tighter deterministic confidence intervals in higher dimensions. We resolve an ordered-i.i.d. version. The rank of the observed arrangement among distinct permutations of its multiset acts as a conditional discrete uniform variable. Substitution in the upper-orthant rule preserves finite-sample coverage and, because the rank stays fixed while the candidate mean varies, produces nested one-sided inversions. We give exact strict-shrinkage conditions, the sharp worst-case reduction in interval length, and the sharp conditional-mean reduction bound over sample orders. The refined intervals also agree almost surely with the original intervals eventually at any fixed level under a fixed i.i.d. law.

## 1. Setup and finite-sample validity

Let $X_1,\ldots,X_n$ be i.i.d. on $[0,1]$ with mean $\mu$, and assume the sample is supplied in its predetermined observation order. We use $n\ge2$. With independent unit exponentials $E_0,\ldots,E_n$, the Gaffke statistic is
$$
K_n(z)=\Pr\!\left\{\sum_{i=1}^n(z_i-1)E_i<E_0\right\},\qquad z_i\ge0.
$$
It is symmetric and coordinatewise nonincreasing. Vlassis and Thomas proved its validity on independent e-values. Ming et al., Definition 4.12 and Theorem 4.13, proved that for an independent $U\sim{\rm Unif}[0,1]$ the randomized rule
$$
K_n^{\Pi}(z;U)=
\begin{cases}
U/\prod_i z_i,&\min_i z_i\ge1,\\
K_n(z),&\min_i z_i<1
\end{cases} \tag{1}
$$
is a p-value for independent nonnegative inputs with means at most one and is pointwise at most $K_n(z)$.

For the ordered sample $x$, let $M(x)$ be its number of distinct permutations, and let $J(x)\in\{1,\ldots,M(x)\}$ be its lexicographic rank in that orbit, with rank one the smallest. Put $V(x)=J(x)/M(x)$, including $V=1$ for a constant sample.

**Theorem 1.** In (1) replace $U$ by $V(X)$ for both one-sided inverted tests, using the same value for all candidate means:
$$
p_{\le}^{\rm ord}(\theta;x)=K_n^\Pi(x/\theta;V(x)),\qquad
p_{\ge}^{\rm ord}(\theta;x)=K_n^\Pi((1-x)/(1-\theta);V(x)).
$$
The first is a p-value under $\mu\le\theta$ and the second under $\mu\ge\theta$. The first is nondecreasing in $\theta$ for fixed $x$ and the second is nonincreasing. For one-sided levels $\alpha_L,\alpha_U\in(0,1/e)$, their closed inverted confidence interval is nonempty, is contained in the original interval at the same levels, and has coverage at least $1-\alpha_L-\alpha_U$.

**Proof.** Conditional on the unordered multiset, the observed arrangement is uniform among its $M$ distinct permutations. One way to see this for arbitrary distributions including continuous ones is to symmetrize any bounded test function over the $n!$ permutations. Exchangeability makes this symmetrization the conditional expectation given the multiset, with each distinct permutation counted equally often. Thus
$$\Pr(V\le v\mid\text{multiset})=\lfloor Mv\rfloor/M\le v,\qquad 0\le v\le1. \tag{2}$$
For either candidate mean and either one-sided test, the branch of (1) and the base Gaffke value are constant on a permutation orbit. In its upper-orthant branch the rejection indicator depends on $V$ only through the increasing event $V\le\alpha/K_n(z)$. Equation (2) therefore makes its conditional probability no larger than under an independent uniform. Outside this branch the two tests agree. Apply the randomized merger validity and then average the conditional comparison. The two uses of the same rank need no independence from each other.

For fixed $x$ and $V$, $K_n^\Pi(z;V)$ is coordinatewise nonincreasing. Within either branch this follows from its formula. On entering the upper orthant it can only drop relative to the coordinatewise nonincreasing base rule, by $V\le1$ and $K_n(z)=1/\prod_i z_i$ there. Scaling by the candidate mean gives the stated orders, so inverted acceptance sets have interval closure. Pointwise domination gives containment. For any interior true mean, the union bound on the two tests gives coverage. At true mean zero or one the sample equals that boundary almost surely.

It remains to check nonemptiness, including degenerate observations. For a nonconstant sample its mean $\bar x$ lies strictly between its minimum and maximum, so both tests at $\bar x$ use their original, unreduced branch. The random sum $Y=\sum_i(x_i/\bar x-1)E_i$ in the first test has mean zero and a continuous log-concave density, being a convolution of scaled, possibly reflected exponential densities. Its CDF $F$ is log-concave by marginalization and $F(Y)$ is uniform. Jensen's inequality applied to the concave $\log F$ gives $\log F(0)\ge E\log F(Y)=-1$. Therefore $K_n(x/\bar x)\ge\Pr(Y\le0)\ge1/e$. The same reasoning applies to the complementary sample. If the common observation value is interior, $V=1$ and the statistic at $\bar x$ is one for both tests. If the sample is entirely zero or entirely one, the relevant boundary belongs to the closure. This proves nonemptiness and the boundary coverage. $\square$

## 2. Exact effects on the endpoints

Write $m_x=\min_i x_i$, $P_x=\prod_i x_i$, and let $L_\alpha(x)$ denote the original lower endpoint, the supremum of rejected candidate means for the first test, with zero for no rejection. Use analogous notation for the ordered refinement. The original and refined upper endpoints are obtained by replacing $x$ by $1-x$ and subtracting the resulting lower endpoint from one, with the same $V(x)$.

**Theorem 2.** If $m_x>0$ and $m_x^n/P_x>\alpha$, then
$$
L_\alpha(x)=(\alpha P_x)^{1/n},\qquad
L_\alpha^{\rm ord}(x)=\min\{m_x,(\alpha P_x/V(x))^{1/n}\}. \tag{3}
$$
Otherwise the lower endpoints agree. In particular, the lower endpoint strictly increases iff $V(x)<1$, $m_x>0$ and $m_x^n/P_x>\alpha$. The upper counterpart uses the identical conditions for the complementary sample and its level.

**Proof.** For $0<\theta\le m_x$, the base p-value is $\theta^n/P_x$ and the refined value is $V(x)\theta^n/P_x$. For $\theta>m_x$ they agree. If $m_x=0$ the altered branch is empty. If the base p-value at $m_x$ is at most $\alpha$, the entire altered branch was already rejected. Otherwise the original boundary lies strictly below $m_x$, and the modified branch moves that boundary to the value in (3), capped by $m_x$ because all points above it still accept. These facts also prove the strict conditions. $\square$

For each $n$, there is a positive-volume set of samples with strict narrowing of both endpoints. For example, choose a sufficiently narrow interval about $1/2$. The ratios $m_x^n/P_x$ and $m_{1-x}^n/P_{1-x}$ exceed the two fixed levels whenever every observation lies in that interval. Restrict further to distinct observations in any order except the lexicographically largest. Then $V(x)<1$ and both endpoints strictly move.

## 3. Sharp finite-sample width reductions

Set both one-sided levels to $\alpha\in(0,1/e)$, write $a=\alpha^{1/n}$ and let $N=n!$. For $v\in(0,1]$ define
$$h(v)=\min\{1,(\alpha/v)^{1/n}\}-a\ge0.$$

**Theorem 3.** The supremum, over all ordered samples, of the absolute width reduction is
$$h(1/N)=\min\{1,(\alpha n!)^{1/n}\}-\alpha^{1/n}. \tag{4}$$
The supremum of the width reduction averaged over the uniform order conditional on a fixed multiset is
$$\frac1N\sum_{j=1}^{N}h(j/N). \tag{5}$$
Both bounds can be approached by distinct observations coalescing at any fixed point of $(0,1)$. Neither supremum is attained.

**Proof.** By (3) the lower-endpoint gain is at most $h(V)P_x^{1/n}$, since $m_x\le P_x^{1/n}$. In an inactive branch its gain is zero, which satisfies the same bound. The upper gain is at most $h(V)P_{1-x}^{1/n}$. The arithmetic-geometric mean inequality gives $P_x^{1/n}+P_{1-x}^{1/n}\le1$, strictly for every nonconstant sample. Since $V\ge1/N$ and $h$ is nonincreasing, this proves the upper bound (4). For the mean conditional on the multiset, $V$ is uniform on the $M$-point grid $\{j/M\}$. As $M$ divides $N$, this grid uniform is stochastically larger than the $N$-point version: $\lfloor M t\rfloor/M\le\lfloor Nt\rfloor/N$ for each $t$. Equation (5) follows. Nonconstant samples have a strict geometric-mean inequality whenever the rank gives $h(V)>0$, and constant samples have $V=1$ and zero gain. Hence neither positive supremum is attained.

Take distinct samples approaching a constant $c\in(0,1)$. Then $M=N$, $m_x/P_x^{1/n}\to1$ and $m_{1-x}/P_{1-x}^{1/n}\to1$. Both endpoint branches in (3) are active for all sufficiently close samples, and their total gain tends to $h(v)[c+(1-c)]=h(v)$ for every fixed rank $v=j/N$. Take rank one for (4) or average all ranks for (5). $\square$

For example, at $n=3$ and $\alpha=1/40$, the observed order $(0.49,0.50,0.51)$ has rank factor $1/6$. Both improved endpoints stay inside their active product branches. The companion rational checker gives an absolute width reduction in $[0.238895649520,0.238895649521]$ and an enclosure $[0.238927510770,0.238927510771]$ for the sharp supremum.

This conditional rank grid also has a precise optimality property among orbitwise substitutions in (1). For a deterministic factor with $M$ equally probable orbit values, conditional super-uniformity requires that its $j$-th smallest value be at least $j/M$. Thus $J/M$ is the stochastically smallest conditional factor allowed by this guarantee. As the width decreases when the factor decreases, (5) is sharp within that substitution principle. A permutation-invariant factor is constant on its orbit, so conditional super-uniformity then requires it to equal one.

## 4. Fixed-law asymptotic behavior and scope

At fixed levels the new and old intervals agree almost surely for all sufficiently large $n$ under any fixed i.i.d. law. The constant law has $V=1$ identically. Otherwise select $0\le a_0<b_0\le1$ with $\Pr(X\le a_0)>0$ and $\Pr(X\ge b_0)>0$. Almost surely the sample minimum is eventually at most $a_0$ and a fixed positive fraction of observations is at least $b_0$. For each sufficiently large $n$ with $m_x>0$ this implies
$$\frac{m_x^n}{P_x}=\prod_i \frac{m_x}{x_i}\le(a_0/b_0)^{c n}\longrightarrow0$$
for a deterministic $c>0$. If $m_x=0$ there is no lower gain. Applying the same argument to $1-X$ proves eventual exact equality of both endpoints. Thus the refinement preserves any fixed-law asymptotic conclusions of the original interval.

The argument uses order as an ancillary variable under i.i.d. sampling. It gives a deterministic interval algorithm with no auxiliary random draw. The same numerical sample presented in another order may give another interval. The result does not establish a permutation-invariant or coordinatewise monotone merger on arbitrary independent e-values, which is a distinct question in Ming et al.

## References

- Jiahao Ming, Aaditya Ramdas, Yi Shen, Ruodu Wang and Ian Waudby-Smith. *Gaffke's confidence interval for the mean of bounded data is inadmissible but asymptotically efficient*. arXiv:2607.18661v1, 2026. <https://arxiv.org/abs/2607.18661>.
- Nikos Vlassis and Philip S. Thomas. *An exact distribution-free test for means of nonnegative random variables*. arXiv:2607.08415, 2026. <https://arxiv.org/abs/2607.08415>.
- András Prékopa. *On logarithmic concave measures and functions*. Acta Scientiarum Mathematicarum 34, 335--343, 1973. <https://rutcor.rutgers.edu/~prekopa/LOGCON.pdf>.
