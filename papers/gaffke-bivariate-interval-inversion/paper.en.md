# Exact inversion and maximal length reduction for the admissible bivariate Gaffke rule

## Abstract

Ming, Ramdas, Shen, Wang and Waudby-Smith proved that a deterministic, monotone two-input merger strictly improves Gaffke's merger in the mixed region. Their Section 4.4 leaves the corresponding two-observation bounded-mean confidence interval unstudied. We give closed endpoints, exact criteria for strict interval shrinkage and a sharp characterization of the largest possible gain in equal-tailed interval length. The maximum is uniquely attained, up to ordering, by a symmetric sample. At one-sided level $\alpha\downarrow0$, the maximum gain is $\alpha/8+O(\alpha^2)$.

## 1. Problem and endpoint formulas

Let $X_1,X_2$ be independent in $[0,1]$ with a common mean $\mu$. They need not be identically distributed. Let their observed values in sorted order be $0\le x\le y\le1$. Fix a one-sided level $0<\alpha<1/2$, and put $s=\sqrt{1-\alpha}$ and $u=1-s$. Both $K_2$ and $K_2^{\mathrm{ad}}$ from Ming et al. are valid deterministic p-value mergers under independent nonnegative inputs of mean at most one. For a candidate mean $\theta\in(0,1)$, the lower-side null uses inputs $x/\theta,y/\theta$ and the upper-side null uses $(1-y)/(1-\theta),(1-x)/(1-\theta)$. Let $L_{\rm old}(x,y)$ and $L_{\rm ad}(x,y)$ denote the lower endpoints from the two rules at level $\alpha$.

**Theorem 1.** Set $L_{\rm old}(0,0)=L_{\rm ad}(0,0)=0$. For $y>0$, the two lower endpoints are
$$
L_{\rm old}(x,y)=
\begin{cases}
\sqrt{\alpha xy},&x\ge\alpha y,\\
y-s\sqrt{y(y-x)},&x<\alpha y,
\end{cases}
\qquad
L_{\rm ad}(x,y)=
\begin{cases}
\sqrt{\alpha xy},&x\ge\alpha y,\\
\dfrac{uy+\sqrt{u^2y^2+4usxy}}2,&x<\alpha y.
\end{cases} \tag{1}
$$
For either rule the upper endpoint is $1-L(1-y,1-x)$. The closed interval from each rule has coverage at least $1-2\alpha$. The admissible-rule interval is contained in the original interval. Its lower endpoint strictly increases iff $0<x<\alpha y$, and its upper endpoint strictly decreases iff $0<1-y<\alpha(1-x)$.

**Proof.** If $\theta\le x$ and $x>0$, the two scaled inputs are at least one, and either p-value equals $\theta^2/(xy)$. At $\theta=x$ their value is $x/y$. If $\theta\ge y$, both inputs are at most one and the p-values equal one. Hence if $\alpha\le x/y$ the lower endpoint is the common square-root formula. Otherwise it is in $(x,y)$, including when $x=0<y$. The two members agree at the boundary $x=\alpha y$.

In the mixed regime, the original rule from Ming et al. gives
$$K_2(x/\theta,y/\theta)=1-\frac{(y-\theta)^2}{y(y-x)}.$$
Solving its equality to $\alpha$ proves the old mixed formula. For the admissible rule their Lemma 3.4 gives rejection iff
$$
y/\theta\ge \frac{1}{u(1+s x/\theta)}
\quad\Longleftrightarrow\quad
\theta^2-uy\theta-usxy\le0.
$$
Its positive root is the proposed admissible mixed formula. The upper endpoint follows by applying the same argument to the complementary sample.

The lower-side p-value is nondecreasing in $\theta$ and the upper-side p-value is nonincreasing, by coordinatewise monotonicity. The intersection of the two acceptance sets is an interval. The sample mean belongs to the interior of both acceptance sets when it is strictly between zero and one. To see this, the two scaled inputs for either test at that mean sum to two, say $a+b=2$ with $0\le a\le1\le b$. If $a=b=1$, the p-value is one. Otherwise the larger root $\tau$ of $t^2-b(1+a)t+ab$ is at most two, because the polynomial at two equals $a^2\ge0$ and the smaller root is below one. Consequently $K_2^{\rm ad}=2/\tau-1/\tau^2\ge3/4>\alpha$. If the mean of the sample equals zero or one, the closed interval contains that boundary. Under the null at the true interior $\mu$ each test rejects with probability at most $\alpha$ by validity and independence. The union bound gives coverage; at $\mu=0,1$ the sample equals the boundary almost surely and the closed interval contains it.

The admissible rule is pointwise no larger than the original. The strict-comparison result of Ming et al., Lemma 3.5, says its p-value is strictly smaller only for $0<a<1<b$. In such a mixed configuration at the original root, the admissible p-value is strictly below $\alpha$ and remains below it until the larger root in (1), by continuity and the strict root condition. If $x=0$ or the old root is outside the strict mixed region, (1) gives equality. The complement argument gives the upper criterion. $\square$

## 2. The largest length reduction

Define for $0\le r\le \alpha$
$$G(r)=\frac{u+\sqrt{u^2+4us r}}2-1+s\sqrt{1-r}, \tag{2}$$
and extend it by zero on $[\alpha,1]$. Then the lower endpoint gain is $yG(x/y)$ when $y>0$. The upper endpoint gain is $(1-x)G((1-y)/(1-x))$ when $x<1$. The two extreme constant samples give zero gain. For $0\le r\le\alpha$, $G(0)=G(\alpha)=0$ and
$$
G'(r)=\frac{us}{\sqrt{u^2+4us r}}-\frac{s}{2\sqrt{1-r}},\qquad
G''(r)=-\frac{2u^2s^2}{(u^2+4us r)^{3/2}}-\frac{s}{4(1-r)^{3/2}}<0. \tag{3}
$$
Hence $G>0$ inside this interval. The maximum of $G$ alone occurs at $r_1=3u/4$ by solving $G'=0$, and equals
$$
G(r_1)=\frac{\sqrt{1+3s}-(1+s)}2;
$$
the largest one-endpoint gain is attained at $(x,y)=(r_1,1)$ for the lower endpoint, and at its complement for the upper one.

**Theorem 2.** Let $r_*$ be the unique solution in $(0,\alpha)$ of
$$(1+r_*)G'(r_*)=G(r_*). \tag{4}$$
The maximum absolute reduction in equal-tailed confidence-interval length over $0\le x\le y\le1$ equals
$$
\frac{2G(r_*)}{1+r_*}, \tag{5}
$$
and is uniquely attained by the sorted sample $\big(r_* /(1+r_*),\,1/(1+r_*)\big)$. Moreover
$$
\frac{r_*}{\alpha}\longrightarrow\frac38,\qquad
\frac{2G(r_*)}{1+r_*}=\frac{\alpha}{8}+O(\alpha^2)
\quad(\alpha\downarrow0). \tag{6}
$$

**Proof.** If only one endpoint improves, length gain is at most $G(r_1)$ because each prefactor $y$ or $1-x$ is at most one. Taking the symmetric sample corresponding to $r=r_1$ gives $2G(r_1)/(1+r_1)>G(r_1)$, so the maximizer improves both sides.

If both endpoints improve, $r=x/y$ and $r'=(1-y)/(1-x)$ are in $(0,\alpha)$. Solving for the prefactors gives
$$y=\frac{1-r'}{1-rr'},\qquad 1-x=\frac{1-r}{1-rr'}.$$
Let $\bar r=[(1-r')r+(1-r)r']/(2-r-r')$. The sum of the prefactors equals $2/(1+\bar r)$. Strict concavity of $G$ gives
$$
y G(r)+(1-x)G(r')\le\frac{2G(\bar r)}{1+\bar r},
$$
with equality iff $r=r'$. Each $r=r'\in(0,\alpha)$ is realized by the stated symmetric sample at that ratio. Thus it suffices to maximize $2G(r)/(1+r)$. The sign of its derivative equals that of $(1+r)G'(r)-G(r)$. This last function is strictly decreasing, with derivative $(1+r)G''(r)<0$. It is positive at zero and negative at $\alpha$ by strict concavity and the equal boundary values. This proves unique maximization at (4).

For $t\in[0,1]$ set $r=\alpha t$. Taylor expansion, uniform on this interval because $u/\alpha=1/(1+s)$ stays bounded away from zero, gives
$$G(\alpha t)=\frac{\alpha}{4}\big(\sqrt{1+8t}-1-2t\big)+O(\alpha^2).$$
Therefore $2G(\alpha t)/[\alpha(1+\alpha t)]$ converges uniformly at rate $O(\alpha)$ to $(\sqrt{1+8t}-1-2t)/2$. The latter has a unique maximum $1/8$ at $t=3/8$. Uniform convergence implies both convergence of the scaled maximizing ratios and the stated absolute error for the maximum. $\square$

At one-sided level $\alpha=1/40$, this is a two-sided confidence interval of level at least $0.95$. The companion certificate isolates the unique solution of (4) using rational intervals for the square roots, and reports a rigorous enclosure of (5).

## 3. Scope

The result concerns deterministic confidence intervals from exactly two independent bounded observations with a common mean. The test validity and pointwise domination of $K_2^{\mathrm{ad}}$ are due to Ming et al. All formulas above concern the corresponding inversion, its strictness regions, and the sharp sample-wise maximum of the interval length reduction. Higher-dimensional monotone improvements require separate arguments.

## Reference

- Jiahao Ming, Aaditya Ramdas, Yi Shen, Ruodu Wang and Ian Waudby-Smith. *Gaffke's confidence interval for the mean of bounded data is inadmissible but asymptotically efficient*. arXiv:2607.18661v1, 2026, especially Lemmas 3.4--3.5, Theorem 3.6 and Section 4.4. <https://arxiv.org/abs/2607.18661>.
