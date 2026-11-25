# How much does target-recalculating Hoeffding betting gain?

24 November 2026

## Abstract

Target-recalculating Hoeffding betting improves fixed Hoeffding testing by updating the required gain after each observation. We identify the limiting rejection-time distribution of the discrete algorithm for bounded data with deterministic conditional means and variances. An exact rescaling reveals an absorbed square-root diffusion and supplies a pathwise crossing inequality needed to pass to the hitting event. At the null with limiting variance $\sigma^2$, rejection by a fraction $t$ of the horizon tends to $\alpha^{1/(4\sigma^2t)}$. The local power curve is strictly above the fixed Hoeffding curve, with an explicit lower bound on the difference. Inverting the tests yields a positive lower bound on the limiting relative reduction in expected two-sided interval length.

## Question and scope

Voráček and Orabona [1] show that recalculating the bet after each round improves the terminal Hoeffding test. Their conclusion asks how large the improvement is. The procedure studied here is their exponential STaR–Hoeffding update in Algorithm 2. Their variance-adaptive Algorithms 3 and 4 use different updates. Martinez-Taboada and Ramdas [2] identify the dimension-zero Bessel hitting event in an auxiliary, variance-matched continuous Gaussian experiment in §4.2, equations (4.2)–(4.6). We derive the discrete algorithm’s limiting rejection-time law, local power, and a lower bound for expected confidence-interval shortening. The proof combines path convergence with a separate argument that controls extinction at a zero state. [Voráček and Orabona, Algorithms 1–2 and Proposition 4](https://arxiv.org/html/2505.22422v2#S4.SS1) [Voráček and Orabona, conclusion](https://arxiv.org/html/2505.22422v2#S6) [Martinez-Taboada and Ramdas, §4.2](https://arxiv.org/html/2608.21694v2#S4.SS2)

## Statement

Fix a one-sided level $0<\alpha<1$ and put $L=\log(1/\alpha)$. In row $n$, let $X_{n,1},\ldots,X_{n,n}\in[0,1]$ be adapted to a filtration $(\mathcal F_{n,i})$. Assume that each conditional mean given $\mathcal F_{n,i-1}$ equals the deterministic $\mu_n$ and each conditional variance equals the deterministic $\sigma_n^2$, with $\sigma_n^2\to\sigma^2>0$. Independent identically distributed rows satisfy these assumptions. Take fixed candidate values $m_n\in[0,1]$ such that $h_n=\sqrt n(\mu_n-m_n)/\sigma_n\to h\in\mathbb R$. Run Algorithm 2 with $W_0=1$. At a live round with $r=n-i+1$ observations left, write $d=\log(1/(\alpha W_{i-1}))>0$ and $y=X_{n,i}-m_n$. Set $\lambda=\sqrt{8d/r}$ and multiply $W$ by $\exp(\lambda y-\lambda^2/8)$. A value $W\ge1/\alpha$ triggers rejection and freezes the process. This is the positive-part square-root rule of the original algorithm, including equality. Let $A_n(t)$ be rejection by round $\lfloor nt\rfloor$ when the planned horizon is $n$.

Write $a=\sqrt{L/(2\sigma^2)}$. For a standard Brownian motion $B$, let $Z$ be the absorbed solution

$$
 dZ_t=-2\sqrt{Z_t}\,(dB_t+h\,dt),\qquad Z_0=a^2,\qquad \tau=\inf\{t:Z_t=0\}.
$$

For every $0<t\le1$,

$$
 \lim_{n\to\infty}\Pr(A_n(t))=\Pr_h(\tau\le t).
$$

Under the null $h=0$, the limit equals $\exp[-L/(4\sigma^2t)]=\alpha^{1/(4\sigma^2t)}$. At $t=1$ the ordinary terminal Hoeffding test has limiting rejection probability $\Phi(h-a)$. For every finite $h$ the recalculating test gains at least $e^{2ah}\Phi(-a-h)>0$ in limiting rejection probability. Both tests use the same nominal one-sided level. For Bernoulli$(1/2)$ observations and $\alpha=.05$, the limiting null probabilities are $.05$ and $.0071876312$. Bernoulli$(.3)$ gives $.0282588684$ and $.0037845420$. The larger null probability represents a smaller amount of unused type-I error budget.

## Exact transform and prefix crossing

At a live step define $q=\sqrt{rd/2}$ and $V=(r+1)d/2$. After a crossing, set $V=0$ forever. Define $V$ after the last surviving round too, using $r=0$. Since $d'=(1+1/r)d-\sqrt{8d/r}\,y$, multiplication by $r/2$ gives

$$
 V'=\big[V-2q y\big]_+,\qquad q=a_r\sqrt V,\qquad a_r=\sqrt{r/(r+1)}.
$$

Here the algorithm has crossed exactly when the raw right-hand side is nonpositive. Its original wealth may overshoot the threshold. The positive part encodes its rejection status exactly. This check includes $r=1$ where $V=2q^2$ and crossing occurs exactly for $y\ge q$.

For $r\ge2$, a surviving step satisfies

$$
 q'^2=(1-r^{-2})q^2-2(1-r^{-1})qy,
 \qquad (q-y)^2-q'^2=(y-q/r)^2.
$$

Survival entails $y<(r+1)q/(2r)\le q$. Thus $q'>0$ and $q'\le q-y$. Consequently nonrejection over any block forces every nonempty prefix sum within that block to be strictly less than the incoming $q$. For a prefix ending before the last planned round this follows by summing the inequalities and using positivity of the outgoing distance. For the prefix ending at the last planned round, use its strict survival inequality $y<q$. Every internal surviving step also reduces the required remaining total, beyond its observed increment, by exactly $(y-q/r)^2/(q-y+q')$.

## Convergence of the scaled state process

Use $Z^n_{k/n}=V_k/(n\sigma_n^2)$ and hold the values fixed between rounds. Standardize $\xi_{n,i}=(X_{n,i}-\mu_n)/\sigma_n$, so $E[\xi\mid\mathcal F_{n,k-1}]=0$, $E[\xi^2\mid\mathcal F_{n,k-1}]=1$, and $|\xi|\le C$ uniformly for all sufficiently large $n$. Introduce an auxiliary signed process $U_0=(n+1)L/(2n\sigma_n^2)$ and update at every round by

$$
 U_k-U_{k-1}=-2a_r\sqrt{(U_{k-1})_+}\left(\frac{\xi_{n,k}}{\sqrt n}+\frac{h_n}{n}\right).
$$

The process freezes at a nonpositive overshoot. Induction gives $Z^n=(U^n)_+$ exactly. If a raw update starts at $u\ge0$ and $b=a_r(\xi/\sqrt n+h_n/n)$, its endpoint is $(\sqrt u-b)^2-b^2\ge-b^2$. Thus $-C_1/n\le U^n$ and $\|Z^n-U^n\|_\infty\le C_1/n$.

The one-step conditional mean of $\Delta U$ equals $-2a_rh_n\sqrt{U_+}/n$, and its conditional variance equals $4a_r^2U_+/n$. The following bounds check the uniformity needed up to and including the deadline. Since $U_+\le U+C_1/n$ and $2\sqrt{x}\le1+x$ for $x\ge0$, expectations and discrete Gronwall give $\sup_{n,k\le n}E (U_k)_+<\infty$. Indeed $E(U_k)_+\le U_0+C_1/n+Hn^{-1}\sum_{j<k}[1+E(U_j)_+]$ when $|h_n|\le H$. The expected quadratic variation of the centered martingale is consequently bounded uniformly. Doob's $L^2$ inequality bounds the expected supremum of its absolute value. The expected total variation of the predictable drift is bounded by the same moment estimate, so $\sup_{k\le n}|U_k|=O_{\Pr}(1)$.

Now $0\le1-a_r\le1-a_r^2=1/(r+1)$. The cumulative conditional means and variances therefore differ uniformly in $t\in[0,1]$ in probability by $o(1)$ from $\int_0^t -2h\sqrt{(U^n_s)_+}\,ds$ and $\int_0^t4(U^n_s)_+\,ds$, respectively. On compact state paths the errors are $O(|h_n-h|+(1+\log n)/n)$, including the grid remainder. For any compact bound $K$, the conditional increments at states satisfying $|U_k|\le K$ are bounded by $2\sqrt K(C/\sqrt n+H/n)$. This proves the conditional Lindeberg condition in probability using compact containment. The diffusion convergence criterion of Ispány and Pap, Corollary 2.2, now gives $U^n\Rightarrow Z$ and hence $Z^n\Rightarrow Z$ in $D[0,1]$. Its finite-interval form follows from the same result by appending independent standardized Rademacher increments beyond round $n$ and setting $a_r=1$ there. The preceding estimates then hold on every fixed longer interval. [Ispány and Pap, Corollary 2.2](https://arxiv.org/abs/math/0701803)

To check weak uniqueness, extend the coefficients to the whole line with $\sqrt{x_+}$. At $h=0$, the square-root coefficient obeys $|\sqrt{x_+}-\sqrt{y_+}|^2\le|x-y|$, so the standard square-root pathwise uniqueness criterion applies. The nonnegative solution started above zero is the dimension-zero squared Bessel process stopped at its absorbing boundary. A negative starting state stays constant. For general $h$, a constant Brownian drift change transforms existence and uniqueness in joint law with the Brownian driver from $h=0$ on every finite interval. In detail, the driftless equation has a strong solution uniquely determined by the driver. In any solution to the drifted equation, tilting by the Brownian exponential martingale removes the drift. The resulting joint law of the state and driver is the driftless strong-solution law, and the inverse tilt is a functional of that driver. Equivalence also transfers the zero probability of hitting exactly at any specified positive time.

## Extinction requires a separate argument

On a continuous limiting path evaluation at $t$ is a continuous mapping. The closed-set bound gives $\limsup\Pr(A_n(t))\le\Pr(Z_t=0)$. To obtain the reverse inequality take $0<\eta<t$ and $k=\lfloor n(t-\eta)\rfloor$. On $0<Z^n_{k/n}<\epsilon$, the incoming required sum is at most $\sigma_n\sqrt{n\epsilon}$. If the algorithm survives until $\lfloor nt\rfloor$, the maximum of all successive partial sums of the next $\lfloor nt\rfloor-k$ observations centered at $m_n$ is strictly less than this threshold. Hence

$$
 \Pr(A_n(t))\ \ge\ \Pr(Z^n_{k/n}<\epsilon)
 -\Pr\!\left(\max_{j\le\lfloor nt\rfloor-k}
 \sum_{i=k+1}^{k+j}\frac{X_{n,i}-m_n}{\sigma_n\sqrt n}<\sqrt\epsilon\right).
$$

The conditional mean-zero innovations of conditional variance one satisfy the martingale functional central limit theorem. This is also Corollary 2.2 of Ispány and Pap with constant coefficients. Consequently the future maximum converges in distribution to $\sup_{0\le s\le\eta}(B_s+hs)$. The open-set lower bound for the first probability and closed-set upper bound for the second give

$$
 \liminf\Pr(A_n(t))\ \ge\ \Pr(Z_{t-\eta}=0)
       -\Pr\left(\sup_{0\le s\le\eta}(B_s+hs)\le\sqrt\epsilon\right).
$$

Brownian motion has a positive supremum on every positive interval almost surely, also after a constant drift by equivalence of Wiener measures. Let $\epsilon\downarrow0$, then $\eta\downarrow0$. The driftless hitting law below has a continuous distribution function on positive time, and this atomlessness transfers under the equivalent drifted measure. Since the limit process is absorbed, the resulting lower bound is $\Pr(Z_t=0)$. This step covers lattice-valued and continuous data alike.

## Evaluation and local power gain

For $h=0$, the bounded backward solution $\exp[-x u/(1+2u(t-s))]$ to the driftless backward equation on $0\le s\le t$ gives

$$
 E_0 e^{-u Z_t}=\exp[-a^2u/(1+2tu)].
$$

The identity follows by Itô's formula and boundedness of the localized martingale. Sending $u\to\infty$ gives $\Pr_0(\tau\le t)=e^{-a^2/(2t)}$.

The ordinary Hoeffding terminal test rejects exactly when the full centered sum reaches $\sqrt{nL/2}$. Its limiting probability follows from the scalar central limit theorem. The prefix comparison implies that every path whose centered partial sums ever reach $\sqrt{nL/2}$ is rejected by Algorithm 2. By the functional central limit theorem the limiting probability of that sufficient event at $t=1$ equals $\Pr[\sup_{s\le1}(B_s+hs)\ge a]$. The maximum of Brownian motion with constant drift has a continuous law above zero. The reflection principle with a Gaussian tilt gives $\Phi(h-a)+e^{2ah}\Phi(-a-h)$, which proves the stated positive lower bound on the gain.

## Null calibration uniformly over bounded laws

The null probability approximation is uniform over the adapted rows with deterministic conditional moments and over $t\in[0,1]$, if the approximating function is taken to be $\exp(-L/(4t\sigma_n^2))$, extended by zero when $t\sigma_n^2=0$. To include sequences with variance tending to zero, rescale the auxiliary signed process by $n$ instead of $n\sigma_n^2$. The initial value tends to $L/2$, the single overshoot has absolute value at most $1/n$, and the process is a martingale under the null. Its expected quadratic variation is at most $4\sigma_n^2 \sup_k E(U_k)_+$, with $E(U_k)_+$ bounded by the initial value plus $1/n$. Doob’s inequality therefore rules out rejection with probability tending to one when $\sigma_n^2\to0$. Along any other subsequence of variances, take a further subsequence converging to a positive value and apply the hitting theorem. Monotonicity of the rejection probability in $t$ and continuity of the fixed-variance limit give uniformity in $t$ by bracketing on a finite grid. These two cases prove the uniform assertion.

At fixed null mean $m\in(0,1)$ the largest variance is $m(1-m)$, attained by independent Bernoulli observations. The worst-case terminal rejection probability therefore tends to $\alpha^{1/(4m(1-m))}$. Over all null means the worst-case limit is $\alpha$, attained by fair Bernoulli data.

## Improvement in confidence endpoints and expected interval length

For a row of observations, let $L_\star$ be the largest rejected candidate in $[0,1]$, with zero when the rejection set is empty. Let $L_H=\max(0,\bar X_n-q_0/n)$ with $q_0=\sqrt{nL/2}$. The upper confidence endpoints $U_\star,U_H$ are obtained by applying the respective lower bound to $1-X$ and reflecting about $1/2$. Assign length zero to an inverted interval whose endpoints cross. Write $\ell_H,\ell_\star$ for the respective interval lengths. Each one-sided test has finite-sample size at most $\alpha$ at its true null by conditional Hoeffding and Ville’s inequality. Closed confidence bounds obtained by inversion therefore give two-sided coverage at least $1-2\alpha$. The following comparisons hold for any rows satisfying the conditional moment assumptions above, independently of the local candidate comparison.

At every $c\ge0$,

$$
 \liminf_n \Pr\{\sqrt n(L_\star-L_H)/\sigma_n>c\}\ge e^{-2ac},
 \quad
 \liminf_n \frac{\sqrt n}{\sigma_n}E(L_\star-L_H)\ge\frac1{2a}.
$$

With the same one-sided level $\alpha$ in each tail,

$$
 \liminf_n \frac{E[\ell_H-\ell_\star]}{E[\ell_H]}
 \ge \frac{1-e^{-2a^2}}{2a^2}.
$$

For Bernoulli$(1/2)$ and one-tail $\alpha=.025$ (nominal two-sided coverage $95\%$), the lower bound on the limiting relative reduction in expected interval length is $6.777\%$. The bound concerns a ratio of expected lengths.

For the proof, at fixed $y$ the map $v\mapsto[v-2a_r\sqrt v\,y]_+$ is nondecreasing. For $y>0$ it vanishes through $v=(2a_ry)^2$ and its derivative is at least $1/2$ above that point. For $y\le0$ monotonicity follows from the two nondecreasing summands. For fixed $v$ the map is also nondecreasing in $m$, since $y=X-m$. Induction shows that $V_n(m)$ is continuous and nondecreasing, so its zero set is a closed lower interval whenever nonempty. For interior $m$, $L_\star\ge m$ exactly when the candidate $m$ is rejected. In particular, the law of $\sqrt n(\mu_n-L_\star)/\sigma_n$ converges to the distribution function $h\mapsto\Pr_h(\tau\le1)$, by the established hitting theorem. Continuity of this function follows by the Gaussian exponential change of measure. It tends to one as $h\to+\infty$ by the classical terminal event. As $h\to-\infty$, the probability of ever hitting zero tends to zero, since solving the radial scale equation gives $\Pr_h(\tau<\infty)=(1-2ha)e^{2ha}$ for $h<0$. The same conclusion follows by taking $s\downarrow0$ in the transform below.

Let $S_k=\sum_{i\le k}X_{n,i}$. The prefix comparison gives $L_\star\ge (S_k-q_0)/k$ for every $k\ge1$. Indeed the candidate at the right side, when positive, meets the sufficient cumulative threshold exactly. Since $X\in[0,1]$ and $q_0>0$ the candidate is less than one. By the variance bound $\sigma_n^2\le\mu_n(1-\mu_n)$, the means stay uniformly inside $(0,1)$ for large $n$. The variance of the sample mean is $\sigma_n^2/n$ by orthogonality of the centered martingale differences. Thus with probability tending to one the usual endpoints are both interior and their difference is $2q_0/n$.

For fixed $0<\eta<1$, restrict to $\eta\le k/n\le1$. Subtracting the usual lower bound from the maximum of the corresponding prefix bounds, then multiplying by $\sqrt n/\sigma_n$, gives the limiting law

$$
 \sup_{\eta\le t\le1}\left\{\frac{B_t-tB_1}{t}-a(1/t-1)\right\}
$$

by the functional central limit theorem. The centered Gaussian process $W_u=(B_t-tB_1)/t$, $u=1/t-1$, is a standard Brownian motion in the parameter $u$, independent of $B_1$. Its covariance at two indices is their minimum, as follows from the Brownian bridge covariance. Sending $\eta\downarrow0$ therefore gives a lower bound on the limiting tail of the endpoint movement by the tail of $\sup_{u\ge0}(W_u-au)$. This supremum is exponential with rate $2a$. Indeed the bounded stopped exponential $\exp(2a(W_u-au))$ at its first hit of $e^{2ac}$ gives the hitting probability $e^{-2ac}$, because $W_u-au\to-\infty$ on a nonhit. The use of strict inequalities is legitimate by continuity of this exponential law, including the limit from positive $c$ at zero. Fatou's lemma applied to the tail integral proves the one-sided expectation bound.

For the width claim define scaled gains $D_L=\sqrt n(L_\star-L_H)/\sigma_n$ and $D_U=\sqrt n(U_H-U_\star)/\sigma_n$. Both are nonnegative. With probability tending to one, the scaled width reduction is $\min(D_L+D_U,2a_n)$ with $a_n=q_0/(\sigma_n\sqrt n)\to a$. This is at least $\min(D_L,a_n)+\min(D_U,a_n)$, even when the two recalculating bounds cross. The same marginal tail bound holds by reflection on each side. Fatou's lemma on the bounded integral $0\le c\le a$ yields a lower bound $2\int_0^a e^{-2ac}dc=(1-e^{-2a^2})/a$ for the limiting inferior scaled mean width reduction. The ordinary scaled width is bounded by $2a_n$ and equals $2a_n$ with probability tending to one. Dividing by its expectation gives the claim.

## The exact asymptotic mean length as a Brownian-bridge integral

Let $Z^+,Z^-$ start at $a^2$. Drive $Z^+$ by $-2\sqrt{Z^+}\,dB$ and $Z^-$ by $+2\sqrt{Z^-}\,dB$, both absorbed at zero. Write $D=\{Z^+_1>0,Z^-_1>0\}$. Then

$$
 \lim_n \frac{\sqrt n}{\sigma_n}E\ell_\star
 =\int_{-a}^a \Pr(D\mid B_1=b)\,db.
$$

For a fixed local candidate $m_n=\mu_n-h\sigma_n/\sqrt n$, run the two signed chains with opposite signs on the same innovation. Their joint diffusion limit has drifts $-2h\sqrt{Z^+}$ and $+2h\sqrt{Z^-}$, instantaneous variances $4Z^+,4Z^-$, and cross variation $-4\sqrt{Z^+Z^-}$. These follow by the same conditional characteristic calculation made above, coordinate by coordinate, using the exact conditional cross moment of the centered jumps. The driftless pair has coordinatewise pathwise uniqueness for a common Brownian driver. A single equivalent change of Brownian drift gives joint weak uniqueness of the limiting pair at general $h$. The same path bound, vanishing overshoot and conditional Lindeberg estimates apply to both coordinates, so Ispány and Pap, Corollary 2.2, applies in dimension two.

The two survival indicators jointly converge in law. To see this, approximate each zero indicator by a continuous function equal to one at zero and vanishing above $\epsilon$. The approximation errors are supported on $0<Z^n_i(1)\le\epsilon$. By separate convergence of the marginal extinction probabilities, the limiting superior of each error probability is at most $\Pr(0<Z_i(1)\le\epsilon)$, which vanishes with $\epsilon$. Denote joint survival probability in the drifted experiment by $p(h)$.

Lebesgue length equals the integral over candidate values of the joint acceptance indicator. Endpoints and empty intersections have the same integral convention. Set candidate $m=\mu_n-h\sigma_n/\sqrt n$ and give the integrand value zero outside the feasible range of $m$. Both signs surviving implies $|S_n^0+h|<a_n$, with $S_n^0=\sum_i\xi_{n,i}/\sqrt n$, by the deterministic prefix implication at the terminal step. Bounds $\inf_n\sigma_n>0$ and $\sup_n a_n<\infty$ hold after deleting finitely many rows. Hoeffding's inequality therefore bounds the integrand by $C\exp[-c(|h|-C)_+^2]$ for uniform positive constants. Dominated convergence gives $\lim \sqrt n E\ell_\star/\sigma_n=\int_{\mathbb R}p(h)dh$.

By the Gaussian drift-change formula $p(h)=E_0[e^{hB_1-h^2/2}\mathbf1_D]$. Tonelli's theorem and integration over $h$ yield $\sqrt{2\pi}E_0[e^{B_1^2/2}\mathbf1_D]$. On $D$ we have $-a<B_1<a$. Indeed the two surviving radii obey $R^+_1=a-B_1-\int_0^1(2R^+_s)^{-1}ds$ and $R^-_1=a+B_1-\int_0^1(2R^-_s)^{-1}ds$. Conditioning on $B_1$ now gives the displayed integral, expressing the exact limit in terms of standard Brownian bridges ending at $b$.

## The exact asymptotic mean length as a Brownian-bridge integral

Let $Z^+,Z^-$ start at $a^2$. Drive $Z^+$ by $-2\sqrt{Z^+}\,dB$ and $Z^-$ by $+2\sqrt{Z^-}\,dB$, both absorbed at zero. Write $D=\{Z^+_1>0,Z^-_1>0\}$. Then

$$
 \lim_n \frac{\sqrt n}{\sigma_n}E\ell_\star
 =\int_{-a}^a \Pr(D\mid B_1=b)\,db.
$$

For a fixed local candidate $m_n=\mu_n-h\sigma_n/\sqrt n$, run the two auxiliary signed processes with opposite signs on the same innovation. Their joint diffusion limit has drifts $-2h\sqrt{Z^+}$ and $+2h\sqrt{Z^-}$, instantaneous variances $4Z^+,4Z^-$, and cross variation $-4\sqrt{Z^+Z^-}$. These follow by the same conditional characteristic calculation made above, coordinate by coordinate, using the exact conditional cross moment of the centered jumps. The driftless pair has coordinatewise pathwise uniqueness for a common Brownian driver. A single equivalent change of Brownian drift gives joint weak uniqueness of the limiting pair at general $h$. The same path bound, vanishing overshoot and conditional Lindeberg estimates apply to both coordinates, so Ispány and Pap, Corollary 2.2, applies in dimension two.

The two survival indicators jointly converge in law. To see this, approximate each zero indicator by a continuous function equal to one at zero and vanishing above $\epsilon$. The approximation errors are supported on $0<Z^n_i(1)\le\epsilon$. By separate convergence of the marginal extinction probabilities, the limiting superior of each error probability is at most $\Pr(0<Z_i(1)\le\epsilon)$, which vanishes with $\epsilon$. Denote joint survival probability in the drifted experiment by $p(h)$.

Lebesgue length equals the integral over candidate values of the joint acceptance indicator. Endpoints and empty intersections have the same integral convention. Set candidate $m=\mu_n-h\sigma_n/\sqrt n$ and give the integrand value zero outside the feasible range of $m$. Both signs surviving implies $|S_n^0+h|<a_n$, with $S_n^0=\sum_i\xi_{n,i}/\sqrt n$, by the deterministic prefix implication at the terminal step. Bounds $\inf_n\sigma_n>0$ and $\sup_n a_n<\infty$ hold after deleting finitely many rows. Conditional Hoeffding's inequality therefore bounds the integrand by $C\exp[-c(|h|-C)_+^2]$ for uniform positive constants. Dominated convergence gives $\lim \sqrt n E\ell_\star/\sigma_n=\int_{\mathbb R}p(h)dh$.

By the Gaussian drift-change formula $p(h)=E_0[e^{hB_1-h^2/2}\mathbf1_D]$. Tonelli's theorem and integration over $h$ yield $\sqrt{2\pi}E_0[e^{B_1^2/2}\mathbf1_D]$. On $D$ we have $-a<B_1<a$. Indeed the two surviving radii obey $R^+_1=a-B_1-\int_0^1(2R^+_s)^{-1}ds$ and $R^-_1=a+B_1-\int_0^1(2R^-_s)^{-1}ds$. Conditioning on $B_1$ now gives the displayed integral, expressing the exact limit in terms of standard Brownian bridges ending at $b$.

## A real-integral formula for the local power transform

For all real $h$, the entire limiting local rejection-time law is determined by the following single integral. Let $s>0$, $k=\sqrt{h^2+2s}$ and $b=(1-h/k)/2$. Starting the limiting diffusion at radius $r>0$ gives

$$
 E_h[e^{-s\tau}\mathbf1_{\{\tau<\infty\}}]
 =e^{(h-k)r}\int_0^\infty e^{-x}x^{1-b}(x+2kr)^b\,dx.
$$

To verify, put $g(z)=\int_0^\infty e^{-x}x^{1-b}(x+z)^b\,dx$. Differentiation under the integral at any $z>0$ gives

$$
 z g''-(z+1)g'+b g
 =-b\int_0^\infty \partial_x\{e^{-x}x^{2-b}(x+z)^{b-1}\}\,dx=0.
$$

The endpoint terms vanish because $0<b<1$. Hence $f(r)=e^{(h-k)r}g(2kr)$ solves $\frac12 f''-(h+1/(2r))f'=sf$, with $f(0)=1$ and $f(\infty)=0$. Before hitting zero the radius $R=\sqrt Z$ solves $dR=-dB-(h+1/(2R))dt$. Apply optional stopping to $e^{-st}f(R_t)$ killed on exit from $(\epsilon,M)$, and pass $M\to\infty$, $\epsilon\downarrow0$, and the time cutoff to infinity. Boundedness, continuity at zero, and $e^{-st}$ justify these limits. This gives the displayed transform without a simulation or a special-function implementation. The Laplace transform in the time variable of the local power CDF equals the displayed quantity divided by $s$.

## Numerical checks

For the fair Bernoulli example at one-sided level $0.05$, two numerical inversions of the transform at $h=1$ give limiting rejection probability $0.24834949$. The fixed Hoeffding limit is $0.07384393$. With $2048$ fair Bernoulli observations and $2048$ seeded replications, the estimated mean lengths of the nominal $95\%$ intervals are $0.04459$ for recalculating and $0.06002$ for fixed betting. This is a finite-sample diagnostic of about $25.7\%$ reduction. The universal guarantee for this example is the asymptotic lower bound of about $6.78\%$.

## References

1. V. Voráček and F. Orabona, *STaR-Bets: Sequential Target-Recalculating Bets for Tighter Confidence Intervals*, NeurIPS 2025, Algorithms 1–2, Proposition 4 and conclusion. [arXiv:2505.22422v2](https://arxiv.org/abs/2505.22422v2)
2. D. Martinez-Taboada and A. Ramdas, *Gaussian-efficient testing by betting on the mean of bounded data*, 2026, §4.2 and §§5–6. [arXiv:2608.21694v2](https://arxiv.org/abs/2608.21694v2)
3. M. Ispány and G. Pap, *A note on weak convergence of random step processes*, Acta Math. Hungar. **126**, 381–395 (2010), Corollary 2.2. [arXiv:math/0701803](https://arxiv.org/abs/math/0701803)
