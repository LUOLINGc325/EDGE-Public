# Optimal reset locations for symmetric strictly log-concave targets

*An exact threshold, a free boundary, and two necessary endpoint atoms*

Research manuscript v1 · 24 November 2026

## Abstract

Consider a one-dimensional Brownian searcher with a fixed positive Poisson resetting rate. A target is drawn once from a known density and remains fixed. The initial position and subsequent reset positions have the same freely chosen probability law. We determine the unique law minimizing the target-averaged mean first-passage time when the target density is proportional to $e^{-V}$, where $V$ is even, twice continuously differentiable, strictly convex, and has unbounded derivative on the positive half-line. A scalar integral distinguishes two regimes. In the first, resetting only to the origin is optimal. In the second, the optimal law has a positive density on a finite interval and strictly positive atoms at both endpoints. One monotone scalar equation determines the interval. We prove global optimality against all probability measures, including asymmetric competitors, through a nonlocal certificate and an exact nonnegative objective-gap identity. We also give the Gaussian transition constant, bounds for approximate implementation, and reproducible numerical checks. The underlying resetting model, square-root relaxation, and inverse Green operator are established results; the proposed contribution is their complete constrained optimization for the stated class. This manuscript has not undergone external peer review or end-to-end formal verification.

## 1. The question and its scope

If the location of a hidden target is uncertain, returning to the center after every unsuccessful excursion may be inefficient. One may instead reset to a random position. The design question is then not merely how frequently to reset, but which probability law should determine the reset destination.

Evans and Majumdar [1, §§4–6] reduced this question to a variational problem. Their unconstrained solution makes the stationary search density proportional to the square root of the target density. However, the reset law that produces this shape can become negative. They constructed compactly supported realizability examples and explicitly left the general nonnegativity-constrained optimization unresolved. The wider resetting framework is reviewed in [3]. The present result solves a particular infinite-dimensional class within that problem. It does not solve all resetting optimization problems.

Throughout, the searcher moves on $\mathbb R$ with generator $D\,d^2/dx^2$, where $D>0$. Independently, a Poisson clock rings at rate $r>0$. At each ring the searcher moves instantaneously to a fresh sample from a probability measure $\mu$. The initial position also has law $\mu$. A target $Y$ is sampled once, independently, from density $q$, and remains fixed during the entire search. A Brownian visit to $Y$ ends the search. The line segment crossed by an instantaneous reset is not inspected. The law $\mu$ does not change in response to elapsed time or observed search history.

We optimize $\mu$, holding $D$ and $r$ fixed. Write

$$
\alpha=\sqrt{r/D},\qquad
K_\alpha(x)=\frac{\alpha}{2}e^{-\alpha|x|},\qquad
p_\mu=K_\alpha*\mu. \tag{1}
$$

The function $p_\mu$ is the stationary density of the auxiliary process without an absorbing target. It is not a stationary density of the absorbed process. Our admissible class consists of **all Borel probability measures** on $\mathbb R$. No symmetry, density, moment, or prescribed-support constraint is imposed on a competitor.

**Target assumption.** Let

$$
q(x)=Z^{-1}e^{-V(x)},\qquad Z=\int_{\mathbb R}e^{-V(x)}\,dx, \tag{2}
$$

where $V$ is even, $C^2$, strictly convex, and $V'(x)\to\infty$ as $x\to\infty$. The function $V$ describes the target distribution; it is not a force potential acting on the freely diffusing searcher. These assumptions include Gaussian targets and $V(x)=\beta x^2+\gamma x^4$ with $\beta,\gamma\ge0$ and $\beta+\gamma>0$. They allow $V''$ to vanish, as it does at the origin for $V(x)=x^4$.

Strict convexity makes $V'$ strictly increasing; evenness gives $V'(0)=0$. The unbounded derivative implies that $q$ has every exponential moment and that $\sqrt q$ is integrable. These tail properties will justify all integral identities below.

## 2. From first-passage time to a convex objective

For a fixed target position $y$, the probability of hitting $y$ before an independent exponential clock, starting from $z$, is $e^{-\alpha|z-y|}$. This follows by solving $Df''=rf$ on the two sides of $y$, with $f(y)=1$ and decay at infinity. Thus a search cycle starting from $\mu$ succeeds with probability

$$
s_\mu(y)=\int e^{-\alpha|z-y|}\mu(dz)=\frac{2p_\mu(y)}{\alpha}.
$$

The expected duration of a cycle, stopped by either hitting or resetting, is $(1-s_\mu(y))/r$. Renewal at a failed cycle gives

$$
T_\mu(y)=\frac{1-s_\mu(y)}{r s_\mu(y)}.
$$

Averaging over the fixed but unknown target yields the established reduction [1, Eqs. (40), (47), (49)]

$$
\overline T(\mu)=\frac1r\left[\frac\alpha2 F(\mu)-1\right],
\qquad F(\mu)=\int_{\mathbb R}\frac{q(x)}{p_\mu(x)}\,dx. \tag{3}
$$

The same initial and reset law is essential to (3). An externally fixed initial position leads to a different objective.

For each probability measure $\mu$, choose $M<\infty$ with $m=\mu([-M,M])>0$. Then

$$
\frac{\alpha m}{2}e^{-\alpha M}e^{-\alpha|x|}
\le p_\mu(x)\le\frac\alpha2. \tag{4}
$$

Consequently $F(\mu)<\infty$, and $q/p_\mu^2$ is bounded and integrable. The objective is convex because $p_\mu$ is linear in $\mu$ and $u\mapsto1/u$ is strictly convex on the positive half-line.

## 3. Complete classification of the optimizer

Define the dimensionless tail functional

$$
H(a)=\alpha\int_0^\infty
\exp\{-V(a+u)+V(a)+\alpha u\}\,du,
\qquad a\ge0,\qquad A=H(0). \tag{5}
$$

### Theorem 1. Exact optimal reset law

Under the target assumption, the following two cases exhaust all possibilities.

**Point regime: $A\le1$.** The unique minimizer is $\mu_*=\delta_0$. Its value is

$$
F_* = \frac{4q(0)}{\alpha^2}A,
\qquad
\overline T_* = \frac1r\left[\frac{2q(0)}{\alpha}A-1\right]. \tag{6}
$$

The equality case $A=1$ belongs to this regime.

**Interval regime: $A>1$.** There is a unique $a>0$ solving

$$
H(a)=1,\qquad V'(a)<2\alpha. \tag{7}
$$

Set $h=\sqrt q$ and

$$
c^{-1}=2\int_0^a h(x)\,dx+\frac{2h(a)}\alpha. \tag{8}
$$

The unique optimal stationary density is

$$
p_*(x)=
\begin{cases}
c h(x),& |x|\le a,\\
c h(a)e^{-\alpha(|x|-a)},& |x|>a.
\end{cases} \tag{9}
$$

The unique optimal reset law is

$$
\begin{aligned}
\mu_*(dx)={}&c h(x)
\left[1+\frac{V''(x)}{2\alpha^2}
-\frac{V'(x)^2}{4\alpha^2}\right]
\mathbf1_{(-a,a)}(x)\,dx\\
&+m_a\delta_{-a}(dx)+m_a\delta_a(dx),\\
m_a={}&\frac{c h(a)}{\alpha^2}
\left[\alpha-\frac{V'(a)}2\right]>0.
\end{aligned} \tag{10}
$$

Its objective and average search time are

$$
F_*=c^{-2},\qquad
\overline T_* = \frac1r\left[\frac{\alpha}{2c^2}-1\right]. \tag{11}
$$

Both endpoint atoms are necessary: no different probability measure achieves the same optimum. In particular, no purely absolutely continuous law attains the optimum in the interval regime.

## 4. A global certificate and exact gap

The essential issue is whether a proposed law defeats *every* competitor. Verifying normalization or optimizing a finite family is insufficient. The following certificate supplies that comparison.

For a candidate $\mu_*$ define $p_*=K_\alpha*\mu_*$, $F_*=F(\mu_*)$, and

$$
G_*(z)=\int_{\mathbb R}K_\alpha(x-z)
\frac{q(x)}{p_*(x)^2}\,dx. \tag{12}
$$

### Lemma 2. Certificate and uniqueness

If $G_*(z)\le F_*$ for all $z$, then $\mu_*$ is the unique global minimizer. For every probability measure $\nu$, with $p_\nu=K_\alpha*\nu$, the exact identity is

$$
\begin{aligned}
F(\nu)-F_*={}&\int_{\mathbb R}[F_*-G_*(z)]\,\nu(dz)\\
&+\int_{\mathbb R}
\frac{q(x)[p_\nu(x)-p_*(x)]^2}
{p_\nu(x)p_*(x)^2}\,dx.
\end{aligned} \tag{13}
$$

**Proof.** For positive $u,v$,

$$
\frac1u-\frac1v+\frac{u-v}{v^2}
=\frac{(u-v)^2}{uv^2}.
$$

Apply this pointwise with $u=p_\nu$, $v=p_*$, multiply by $q$, and integrate. Tonelli's theorem gives $\int(q/p_*^2)p_\nu=\int G_*\,d\nu$. The bounds (4) and the target tails make all terms finite. Under the certificate, both terms in (13) are nonnegative.

If equality holds, positivity of $q$ forces $p_\nu=p_*$ almost everywhere, hence everywhere by continuity. The Fourier transform of $K_\alpha$ is $\alpha^2/(\alpha^2+t^2)$, which never vanishes. Uniqueness of Fourier transforms of finite measures gives $\nu=\mu_*$. This proves the lemma. $\square$

The certificate is the usual convex first-order condition, specialized here into a usable nonlocal inequality. The reciprocal identity and convexity are standard tools; the problem-specific task is to prove the certificate for (10), especially outside its support.

## 5. Existence of the boundary and feasibility

For $u>0$, strict convexity implies that $V(a+u)-V(a)$ strictly increases with $a$. Therefore $H$ is strictly decreasing. Its integrand is dominated by the integrable $a=0$ integrand, so $H$ is continuous. If $V'(a)>\alpha$, convexity also gives

$$
H(a)\le\frac\alpha{V'(a)-\alpha}\longrightarrow0.
$$

When $H(0)>1$, this proves existence and uniqueness of (7). Let $b$ be the unique point with $V'(b)=2\alpha$. Strict convexity gives $V(b+u)-V(b)>2\alpha u$ for $u>0$, hence $H(b)<1$. Thus $a<b$, proving the strict slope bound in (7).

The function (9) integrates to one by (8). The Green-operator inversion, already used in [1, Eq. (56)], is

$$
\mu=p-\alpha^{-2}p'' \tag{14}
$$

in the sense of distributions. In the interior, $h''/h=V'^2/4-V''/2$, producing the density in (10). It is strictly positive: $|V'(x)|\le V'(a)<2\alpha$ there and $V''\ge0$.

At $a$, the derivative changes from $-c h(a)V'(a)/2$ to $-\alpha c h(a)$. The negative of this jump divided by $\alpha^2$ is exactly $m_a$. Evenness gives the same mass at $-a$. The measure vanishes outside the interval. Its total mass can be checked without distribution notation: the integral of the continuous density is

$$
2c\int_0^a h(x)\,dx+\frac{c h(a)V'(a)}{\alpha^2},
$$

and the two atoms contribute $2c h(a)/\alpha-c h(a)V'(a)/\alpha^2$. Their sum is one.

Finally, $K_\alpha*\mu_*$ and $p_*$ solve the same distributional equation $(1-\alpha^{-2}d^2/dx^2)p=\mu_*$. Their difference solves $f''=\alpha^2 f$ and vanishes at both infinities, so it is zero. The proposed law is therefore feasible and produces exactly (9).

## 6. The nonlocal inequality in the interval regime

Let $\lambda=c^{-2}$. On $[-a,a]$, $q/p_*^2=\lambda$. For $u\ge0$, set

$$
B(u)=\exp\{-V(a+u)+V(a)+2\alpha u\}.
$$

Then $q(a+u)/p_*(a+u)^2=\lambda B(u)$, and (7) becomes

$$
\int_0^\infty e^{-\alpha u}B(u)\,du=\alpha^{-1}. \tag{15}
$$

For $|z|\le a$, the central part of the convolution in (12) equals

$$
\frac\lambda2\left[2-e^{-\alpha(a-z)}-e^{-\alpha(a+z)}\right].
$$

The two tail contributions, by (15), equal $\lambda/2$ times the missing exponentials. Thus

$$
G_*(z)=\lambda\quad (|z|\le a). \tag{16}
$$

Because $\mu_*$ is supported there, Tonelli gives $F(\mu_*)=\int G_*\,d\mu_*=\lambda$, establishing (11).

For $z=a+u$, write $W(u)=G_*(a+u)/\lambda$. Convolution with the Laplace kernel gives

$$
W''=\alpha^2(W-B),\quad W(0)=1,\quad W'(0)=0,
\quad W(u)\to0. \tag{17}
$$

These differential identities hold in the classical sense: $q/p_*^2$ is continuous and integrable, so its convolution is $C^2$, and its convolution with a continuous kernel vanishing at infinity also vanishes at infinity.

The secant slope $[V(a+u)-V(a)]/u$ strictly increases from $V'(a)<2\alpha$ to infinity. Therefore $B(u)>1$ until one unique positive crossing $u_0$, and $B(u)<1$ afterward. For $0<u\le u_0$, variation of constants in (17) gives

$$
W(u)-1=\alpha\int_0^u
\sinh\{\alpha(u-s)\}[1-B(s)]\,ds<0. \tag{18}
$$

Suppose $W$ subsequently reached one. Since $W(u_0)<1$ and $W\to0$, it would have an interior maximum of at least one at some $u>u_0$. At that point $W''\le0$, while (17) and $B<1$ force $W''>0$, a contradiction. Hence $G_*<\lambda$ outside the interval. Evenness handles the left side. Lemma 2 proves global optimality and uniqueness.

## 7. The point regime and its sharp threshold

For $\mu_*=\delta_0$, let $\lambda_0=4q(0)/\alpha^2$ and

$$
B_0(u)=e^{-V(u)+V(0)+2\alpha u}.
$$

Direct calculation gives $F_* =G_*(0)=\lambda_0 A$ and $G_*'(0)=0$. The normalized function $W=G_*/\lambda_0$ satisfies $W''=\alpha^2(W-B_0)$, $W(0)=A$, $W'(0)=0$, and $W\to0$.

If $A\le1$, the function $B_0$ initially increases from one, then decreases to zero, crossing the level $A$ once at a positive point. Repeating (18) with $W-A$ proves $W<A$ before that crossing; the same maximum argument proves it afterward. Thus $G_*(z)<F_*$ for $z\ne0$, and Lemma 2 proves (6), including $A=1$.

If $A>1$, then $G_*''(0)=\alpha^2\lambda_0(A-1)>0$. Therefore $G_*(z)>F_*$ for small nonzero $z$. The variation $(1-\varepsilon)\delta_0+\varepsilon\delta_z$ has objective derivative $F_*-G_*(z)<0$ at zero. Differentiation is justified by $p_\varepsilon\ge(1-\varepsilon)p_*$ and (4). Resetting only to the origin is then not even locally optimal. This confirms that the threshold is exact.

## 8. Stability and approximate implementation

The proof gives more than a minimum. Let $a=0$ in the point regime. For every $\eta>0$, continuity, strict inequality outside the optimal support, and $G_*\to0$ imply

$$
\delta_\eta:=\inf_{|z|\ge a+\eta}[F_*-G_*(z)]>0.
$$

Equation (13) gives the support bound

$$
\nu\{|z|\ge a+\eta\}\le\frac{F(\nu)-F_*}{\delta_\eta}, \tag{19}
$$

and, because $p_\nu,p_*\le\alpha/2$, the weighted density bound

$$
\int q(x)[p_\nu(x)-p_*(x)]^2\,dx
\le\frac{\alpha^3}{8}[F(\nu)-F_*]. \tag{20}
$$

For the interval regime, the exterior certificate has the local expansion

$$
F_*-G_*(a+s)=\frac{\alpha^2F_*}{6}
[2\alpha-V'(a)]s^3+o(s^3),\quad s\downarrow0. \tag{21}
$$

Indeed, (17) gives $W'(0)=W''(0)=0$ and $W'''(0+)=-\alpha^2[2\alpha-V'(a)]$. Formula (21) describes the **certificate**, not a claimed cubic law for the full objective under arbitrary perturbations.

Exact point masses are idealizations. Let $\rho_\eta$ be any probability density supported on $[-\eta,\eta]$, and use $\mu_\eta=\mu_* *\rho_\eta$. The kernel inequality $e^{-\alpha\eta}K_\alpha(x)\le K_\alpha(x-u)\le e^{\alpha\eta}K_\alpha(x)$ for $|u|\le\eta$ implies

$$
F_*\le F(\mu_\eta)\le e^{\alpha\eta}F_*.
$$

Consequently

$$
0\le\overline T(\mu_\eta)-\overline T_*
\le\frac{\alpha F_*}{2r}(e^{\alpha\eta}-1). \tag{22}
$$

A smooth compactly supported $\rho_\eta$ produces a smooth reset density. Hence the infimum over smooth densities equals $F_*$, although uniqueness and the positive atoms imply nonattainment. These approximation bounds are elementary consequences of the explicit solution, not a claim of a new general smoothing principle.

## 9. Gaussian targets and quantitative examples

Let $q(x)=\sqrt{\beta/\pi}e^{-\beta x^2}$, so its standard deviation is $\sigma=(2\beta)^{-1/2}$. With $\operatorname{erfcx}(z)=e^{z^2}\operatorname{erfc}(z)$,

$$
H(a)=\frac{\alpha\sqrt\pi}{2\sqrt\beta}
\operatorname{erfcx}\!\left(\frac{2\beta a-\alpha}{2\sqrt\beta}\right). \tag{23}
$$

The dimensionless transition is

$$
\frac\alpha{\sqrt\beta}=t_c\approx0.715669093344014,
\qquad \alpha\sigma\approx0.506054468989181. \tag{24}
$$

The point regime holds at and below this value. Above it, solve the strictly decreasing equation (23)$=1$ on $0<a<\alpha/\beta$. The continuous density multiplier in (10) is $1+\beta/\alpha^2-\beta^2x^2/\alpha^2$, and each endpoint mass is $c h(a)(\alpha-\beta a)/\alpha^2$.

For $D=r=1$, the following numerical examples compare with resetting only to the origin **at the same fixed rate**. All displayed numbers are floating-point evaluations, not interval-certified constants.

| $\beta$ | $a$ | Each atom | $\overline T_*$ | Origin time | Reduction |
|---:|---:|---:|---:|---:|---:|
| 0.10 | 9.12401640 | 0.00017207 | 4.60519079 | 23.05619436 | 80.03% |
| 0.25 | 3.21626281 | 0.01070782 | 2.55680766 | 4.00898008 | 36.22% |
| 0.50 | 1.30263084 | 0.06358482 | 1.56787012 | 1.77428596 | 11.63% |
| 1.00 | 0.39651140 | 0.21280174 | 0.93866394 | 0.95236049 | 1.44% |
| 2.00 | 0 | at zero | 0.56705924 | 0.56705924 | 0% |
| 4.00 | 0 | at zero | 0.35864237 | 0.35864237 | 0% |

For a standard normal target and $D=r=1$, approximately 6.358% of resets go to each of $\pm1.30263$, and the remaining 87.283% follow the interior density. This yields an 11.63% reduction relative to origin resetting in this model. It is not a claim about experimental hardware, other resetting rates, or arbitrary search algorithms.

For the standard normal target, the nonlocal certificate is equal to one on the optimum support and strictly below one outside it.

Below the Gaussian threshold the optimum has one atom at zero; above it, both endpoint atoms have positive mass.

## 10. What is inherited and what is proposed as new

The model and reduction (1)–(3), the unconstrained square-root rule, and (14) are inherited from [1]. Square-root search allocation has an earlier treatment in [2]. The compact central shape with exponential tails is also present in [1, Eqs. (62)–(71)]. None of these ingredients is claimed as a new invention.

The important difference is the boundary condition. Applying the smooth realizability construction of [1] to $h=\sqrt q$ selects $b$ through $V'(b)=2\alpha$ and removes derivative jumps, hence endpoint atoms. Our optimizer has $a<b$ and positive endpoint masses. The old construction was not presented as a proved optimum for this case. Theorem 1 does not correct a theorem in [1]; it resolves the constrained problem for the stated target class. By uniqueness, the smooth-fit construction is strictly suboptimal here, whether the optimum is an interval law or a point mass.

More recent work must also be distinguished by its optimization variable. Méndez et al. [4] study distributed reset positions for a fixed target and optimize rates or distributional scales in examples. Julián-Salgado et al. [5] optimize a resetting rate for specified compact reset laws. Evans and Ray [6] optimize waiting-time protocols with a fixed reset site. García-Valladares et al. [7] optimize a position-dependent reset **rate** in a finite box while destinations remain at the center; they already discuss singular peaks in optimal rate profiles. Thus endpoint singularities in resetting control, broadly described, are not novel. Our candidate contribution is the exact threshold and unique global optimum for the **destination probability measure**, at fixed homogeneous rate, under (2).

The comparison is limited to the literature examined. Searches through 24 November 2026 found no equivalent theorem in the inspected sources. This is bounded literature evidence, not an exhaustive priority guarantee. Both the 2011 arXiv v2 text and the final published text hosted on the author's institutional page were checked, including the unchanged constrained-optimization discussion in §6.

## 11. Verification and limits

The analytic proof covers every target satisfying (2) and every competing probability measure. The numerical package separately checks ten Gaussian and quartic examples, using direct convolution, direct objective integration, and the nonlocal inequality. A separately written review script tests the result with independent kernel computations and discrete optimization without imposing the proposed analytic shape. The recorded outputs specify tolerances and failure conditions. Such checks can expose algebra, scaling, implementation, or candidate errors, but cannot replace the infinite-dimensional proof.

No Lean verification is claimed. The substantive analytic dependencies include measure-valued convolution inversion and a half-line differential-equation comparison. A formal proof of only the scalar identity in Lemma 2 would not establish those parts. This edition contains the written proof; computation files and raw execution reports are not included.

The result does not optimize the resetting rate, the waiting-time law, a state-dependent policy, a fixed external initial law, or a cost of relocation. It does not cover asymmetric or multimodal target densities, higher-dimensional search, or noninstantaneous returns. Those are different mathematical problems; the present assumptions are part of the theorem.

## References

[1] M. R. Evans and S. N. Majumdar. *Diffusion with optimal resetting*. Journal of Physics A: Mathematical and Theoretical **44**, 435001 (2011). DOI: [10.1088/1751-8113/44/43/435001](https://doi.org/10.1088/1751-8113/44/43/435001). Inspected full texts: [arXiv:1107.4225v2](https://arxiv.org/abs/1107.4225v2) and the [published version on the author’s institutional page](https://www.lptms.universite-paris-saclay.fr/satya-majumdar/files/2010/12/evans11.pdf), especially §§4–6 and Appendix A.

[2] J. Snider. *Optimal random search for a single hidden target*. Physical Review E **83**, 011105 (2011). DOI: [10.1103/PhysRevE.83.011105](https://doi.org/10.1103/PhysRevE.83.011105). [arXiv:1007.3774v2](https://arxiv.org/abs/1007.3774v2).

[3] M. R. Evans, S. N. Majumdar, and G. Schehr. *Stochastic resetting and applications*. Journal of Physics A: Mathematical and Theoretical **53**, 193001 (2020). DOI: [10.1088/1751-8121/ab7cfe](https://doi.org/10.1088/1751-8121/ab7cfe). [arXiv:1910.07993v2](https://arxiv.org/abs/1910.07993v2), §3.4.

[4] V. Méndez, R. Flaquer-Galmés, and D. Campos. *First-passage time of a Brownian searcher with stochastic resetting to random positions*. Physical Review E **109**, 044134 (2024). DOI: [10.1103/PhysRevE.109.044134](https://doi.org/10.1103/PhysRevE.109.044134). [arXiv:2401.01125v1](https://arxiv.org/abs/2401.01125v1).

[5] P. Julián-Salgado, L. Dagdug, and D. Boyer. *Abrupt transitions in the optimization of diffusion with distributed resetting*. Physical Review E **112**, 044110 (2025). DOI: [10.1103/b15f-47qw](https://doi.org/10.1103/b15f-47qw). [arXiv:2507.14483v2](https://arxiv.org/abs/2507.14483v2).

[6] M. R. Evans and S. Ray. *Stochastic resetting prevails over sharp restart for broad target distributions*. Physical Review Letters **134**, 247102 (2025). DOI: [10.1103/2wpq-gl2j](https://doi.org/10.1103/2wpq-gl2j). [arXiv:2410.01941v2](https://arxiv.org/abs/2410.01941v2).

[7] G. García-Valladares, A. Prados, A. Manacorda, and C. A. Plata. *How target distributions shape optimal stochastic resetting*. Physical Review E **113**, 024107 (2026). DOI: [10.1103/9m8d-yjhw](https://doi.org/10.1103/9m8d-yjhw). [arXiv:2505.16626v2](https://arxiv.org/abs/2505.16626v2), particularly §§II, V–VI.
