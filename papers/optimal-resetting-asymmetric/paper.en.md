# Exact Brownian reset laws for one-dimensional log-concave targets

24 November 2026

## Abstract

In one-dimensional Brownian search, the reset rate can be fixed while the law of reset destinations is varied. Evans and Majumdar showed that the ideal stationary density is proportional to the square root of the target density, but the corresponding reset law can have negative mass. We solve the constrained problem for smooth, strictly log-concave target densities on the line. The targets may be asymmetric and either tail may have a finite exponential slope. Two scalar integrals determine the optimal support, which may be a point, a bounded interval, a half-line or the whole line. Every finite endpoint of a nondegenerate interval carries a positive atom. The optimizer is unique over all Borel probability measures, including competitors of infinite cost. At the transition from a point to an interval, the optimal search-time advantage over the moving best point has an explicit cubic leading term. The supplement extends the exact optimizer classification to every one-dimensional log-concave target density.

## 1. From Brownian search to a convex objective

A target is drawn once from a density $q$ on $\mathbb R$ and then held fixed. A Brownian searcher with generator $D\,d^2/dx^2$ starts from a probability law $\mu$ and restarts at independent draws from the same law at an independent Poisson rate $r$. A restart is instantaneous and does not inspect the segment it crosses. The rate $r>0$ and diffusivity $D>0$ are fixed during optimization.

Write $\alpha=\sqrt{r/D}$, $K_\alpha(x)=(\alpha/2)e^{-\alpha|x|}$ and $p_\mu=K_\alpha*\mu$. A cycle starting from $\mu$ hits a target at $y$ before the reset clock with probability $2p_\mu(y)/\alpha$. Indeed, the discounted Brownian hitting probability from $z$ is $e^{-\alpha|y-z|}$, obtained by solving $Du''=ru$ with $u(y)=1$ and decaying solutions on the two rays. A cycle ends at the earlier of the hit and the exponential clock. Its mean length is the failure probability divided by $r$, by integrating the survival probability against the exponential density. Restarting independently upon failure gives the average mean first-passage time
$$
T(\mu)=\frac{1}{r}\left(\frac{\alpha}{2}F(\mu)-1\right),
\qquad F(\mu)=\int_{\mathbb R}\frac{q(x)}{p_\mu(x)}\,dx.
$$
This is the reset-location objective of Evans and Majumdar [1, §5]. If $p$ could be any probability density, Cauchy–Schwarz would give the unique unconstrained solution $p\propto\sqrt q$. Here $p$ must be a Laplace convolution of a nonnegative probability measure. A tail of $\sqrt q$ that falls faster than the Laplace kernel cannot be produced. The optimal stationary density retains the square-root shape where that constraint allows it and connects to exponential tails where it binds.

Throughout, $q=e^{-V}/Z$, where $V:\mathbb R\to\mathbb R$ is $C^2$ and strictly convex, and $Z=\int e^{-V}<\infty$. Put $h=\sqrt q$ and
$$
s_-=-\lim_{x\to-\infty}V'(x),\qquad s_+=\lim_{x\to+\infty}V'(x).
$$
The slopes belong to $(0,\infty]$. Convexity and integrability give an affine lower bound with positive outward slope on each tail. In particular, $h$ is integrable.

## 2. The optimal distribution

For the current $\alpha$ define
$$
H_\pm(x)=\alpha\int_0^\infty e^{\alpha u}\frac{q(x\pm u)}{q(x)}\,du.
$$
Use the unique root $L$ of $H_-(L)=1$ if $s_->2\alpha$, and otherwise put $L=-\infty$. Use the unique root $R$ of $H_+(R)=1$ if $s_+>2\alpha$, and otherwise put $R=+\infty$.

**Theorem 1.** There is a unique minimizer $\mu_*$ of $F$ over the Borel probability measures on $\mathbb R$.

**Point regime.** If $L\ge R$, both endpoints are finite. The optimizer is $\delta_b$, where $b$ is the unique solution of $H_-(b)=H_+(b)=A$. Here $A\le1$ and
$$
F(\mu_*)=\frac{4q(b)A}{\alpha^2}.
$$
The point $b$ is the best deterministic reset site. If $L=R$, then $b=L=R$ and $A=1$.

**Distributed regime.** If $L<R$, define
$$
c^{-1}=\int_L^R h(x)\,dx
 +\sum_{e\in\{L,R\}\cap\mathbb R}\frac{h(e)}{\alpha}.
$$
The optimal $p_*$ equals $ch$ on $[L,R]\cap\mathbb R$. At a finite left endpoint continue it by $ch(L)e^{-\alpha(L-x)}$ for $x<L$. At a finite right endpoint use $ch(R)e^{-\alpha(x-R)}$ for $x>R$. The reset measure has density
$$
ch(x)\left(1+\frac{V''(x)}{2\alpha^2}
             -\frac{V'(x)^2}{4\alpha^2}\right)\mathbf 1_{(L,R)}(x).
$$
Its finite endpoints have the masses
$$
\mu_*(\{L\})=\frac{ch(L)}{\alpha^2}\left(\alpha+\frac{V'(L)}2\right),
\qquad
\mu_*(\{R\})=\frac{ch(R)}{\alpha^2}\left(\alpha-\frac{V'(R)}2\right).
$$
The density is positive throughout the open interval and each displayed atom is positive. The value is $F(\mu_*)=c^{-2}$. The pure square-root law for $p_*$ is feasible exactly when $s_-\le2\alpha$ and $s_+\le2\alpha$.

A deterministic reset may have infinite mean search time even though the distributed optimizer has finite cost. This happens, for example, if $\alpha$ is at least the smaller outward slope.

## 3. Proof of Theorem 1

### 3.1. Roots and the best point

For $\alpha<s_+$, the integrals defining $H_+$ are finite. Strict convexity makes $V(x+u)-V(x)$ strictly increasing in $x$ for $u>0$, so $H_+$ strictly decreases. At the left end,
$$
H_+(x)=\frac{\alpha e^{-\alpha x}}{q(x)}
       \int_x^\infty e^{\alpha y}q(y)\,dy\longrightarrow+\infty.
$$
The integral is bounded below on a fixed finite subinterval. At the right end $H_+$ converges to $\alpha/(s_+-\alpha)$, with zero for $s_+=\infty$. For this limit choose $x_0$ with $V'(x_0)>\alpha$. At $x\ge x_0$, the integrand is dominated by $\alpha e^{-(V'(x_0)-\alpha)u}$ and its pointwise limit is immediate. If $\alpha\ge s_+<\infty$, the tilted tail $e^{\alpha y}q(y)$ is increasing and the integral diverges. Reflection proves the corresponding assertions for $H_-$. Joint continuity of the finite integrals on a neighborhood of any $(x,\alpha)$ follows from the same domination with a uniform tail margin.

These limits give the stated root tests, including the equality $s_\pm=2\alpha$. A finite right root satisfies $V'(R)<2\alpha$. If $V'(R)\ge2\alpha$, strict convexity would give $H_+(R)<\alpha\int_0^\infty e^{-\alpha u}\,du=1$. A finite left root satisfies $V'(L)>-2\alpha$ by reflection. Thus $|V'|<2\alpha$ throughout the active interval, also on a side with no finite endpoint.

When both outward slopes exceed $\alpha$, the opposite monotonicities give a unique balance point $b$. Differentiation of $\int q(y)e^{\alpha|y-z|}\,dy$ with respect to $z$ gives $q(z)(H_-(z)-H_+(z))$ by the finite tilt bound. Its sign changes at $b$, so $b$ uniquely minimizes $F(\delta_z)$. At that point the two equal integrals give the value in Theorem 1. If both roots are finite, their order gives $A\le1$ precisely when $L\ge R$. In the distributed regime with both roots finite, the point $b$ lies strictly between them.

### 3.2. Positivity and an optimality test

The Laplace kernel is a Green function, with $(1-\alpha^{-2}\partial_x^2)K_\alpha=\delta_0$ in distributions. Apply this operator to the proposed continuous density $p_*$ in the distributed case. In the interior $h''/h=V'^2/4-V''/2$. Each exterior exponential contributes zero, and the jumps of $p_*'$ give exactly the two atom formulas. The slope bounds and $V''\ge0$ give positivity. The second derivative in the interior is integrable because $h$ is bounded and integrable, $|V'|$ is bounded there and $\int_L^R V''\le4\alpha$. The derivatives of $p_*$ vanish at each infinity. Consequently its full distributional second derivative, including jumps, has integral zero. The resulting reset measure has mass one and convolving it with $K_\alpha$ returns $p_*$. Their difference would be an integrable distributional solution of $u''=\alpha^2u$, which is zero by Fourier transformation.

If either outward slope exceeds $2\alpha$, the pure square-root shape violates
$$
p_\mu(x+t)\ \ge\ e^{-\alpha |t|}p_\mu(x),
$$
which follows from the triangle inequality inside the positive kernel mixture. When both slopes are at most $2\alpha$, the interior formula realizes $\sqrt q/\int\sqrt q$ on the whole line.

For a feasible candidate $p_*$ define $w=q/p_*^2$ and the certificate $G=K_\alpha*w$. We will have $w$ bounded. Tonelli gives $\int G\,d\nu=\int w p_\nu$ for every probability $\nu$. For $F_*=F(\mu_*)=\int G\,d\mu_*$, the exact comparison is
$$
F(\nu)-F_*=\int (F_*-G(z))\,\nu(dz)
 +\int_{\mathbb R}\frac{q(x)(p_\nu(x)-p_*(x))^2}{p_\nu(x)p_*(x)^2}\,dx.
$$
It follows by expanding the reciprocal around $p_*$ and holds with $+\infty$ on either side because the linear terms are finite. Therefore $G\le F_*$ certifies optimality. Equality of objective values forces $p_\nu=p_*$ almost everywhere and hence everywhere by continuity. Applying the Green operator gives $\nu=\mu_*$.

### 3.3. One sign change controls the exterior

Suppose $G(z_0)=\Lambda$ and $\int_0^\infty e^{-\alpha t}(w(z_0+t)-\Lambda)\,dt=0$. Write the integrand as $f(t)$ and assume $f$ is positive on $(0,d)$ and negative after $d$ for some $d>0$. At $z_0$ the contribution from the whole half-line left of $z_0$ to $G-\Lambda$ is also zero, so it remains zero under a shift $s>0$ to the right, since its kernel factor then gains only $e^{-\alpha s}$. For the right contribution,
$$
G(z_0+s)-\Lambda
=\frac{\alpha}{2}e^{-\alpha s}
   \int_0^\infty e^{2\alpha\min(s,t)} f(t)\,dt.
$$
The multiplier $m(t)=e^{2\alpha\min(s,t)}$ is nondecreasing. Subtracting $m(d)$ leaves the integral unchanged because $\int f=0$. The new product $(m(t)-m(d))f(t)$ is nonpositive and is strictly negative on $(0,\min(s,d))$. Thus $G(z_0+s)<\Lambda$. The left-hand statement follows by reflection.

For a distributed solution choose $\Lambda=c^{-2}$. The function $w/\Lambda$ is one in the interior. On the right of a finite $R$ it is
$$
B(t)=\exp[-V(R+t)+V(R)+2\alpha t],\qquad t\ge0 .
$$
The root equation gives $\alpha\int_0^\infty e^{-\alpha t}B(t)\,dt=1$. The left endpoint has the reflected formula. Each finite tail correction therefore has zero contribution throughout the active interval, so $G=\Lambda$ there. The logarithm of $B$ is strictly concave, has positive derivative at zero and tends to $-\infty$ because $s_+>2\alpha$. It follows that $B-1$ is positive until its one positive crossing and negative thereafter. Apply the one-sided test. Infinite endpoints contribute no exterior term. This also proves boundedness of $w$ and $F_*=\Lambda$.

For a point solution take $p_*=(\alpha/2)e^{-\alpha|x-b|}$ and $\Lambda=4q(b)A/\alpha^2$. Balance gives $G(b)=\Lambda$ and a zero weighted correction on each side. The functions $w(b\pm t)$ are strictly log-concave on the two rays and tend to zero since both slopes exceed $2\alpha$. At the origin of either ray they are at least $\Lambda$. If equality holds there, the zero correction and strict negativity far away force a strict excess somewhere. Strict log-concavity then gives a positive interval starting at zero and exactly one downcrossing. The one-sided test proves strict inequality off $b$. The comparison in §3.2 now completes both cases.

## 4. Varying the reset rate

**Theorem 2.** For each target in Theorem 1 there is a unique scale $\alpha_c\in(0,\min(s_-,s_+)/2)$ at which $L=R=b_c$. If both slopes are infinite, the upper bound means $+\infty$. The optimizer is a single atom for $\alpha\le\alpha_c$ and is distributed for $\alpha>\alpha_c$. Each finite endpoint subsequently disappears to its outward infinity when $\alpha$ reaches half its slope.

On the range where both roots are finite, each $H_\pm$ increases strictly with $\alpha$ at fixed $x$. Thus $L$ decreases and $R$ increases strictly and continuously. As $\alpha\downarrow0$, the two ratios tend to zero at any fixed $x$ by dominated convergence, so $L\to+\infty$ and $R\to-\infty$. If a slope is finite and minimal, at its half-slope the corresponding ratio is strictly above one at every fixed $x$. The root therefore escapes outward when that parameter is approached from below. The other root is moving in the opposite direction. If both slopes are infinite, then $H_\pm(x)\to\infty$ at each fixed $x$ as $\alpha\to\infty$, by integrating over any fixed interval of positive distances. These facts imply exactly one meeting. A missing endpoint stays missing as $\alpha$ increases. In physical units the transition is at $r_c=D\alpha_c^2$.

### 4.1. How much does the new interval help?

For $\alpha$ just above $\alpha_c$, let $b=b(\alpha)$ be the moving best point, let $\varepsilon=H_\pm(b)-1$, and put $\kappa=V'(b_c)/(2\alpha_c)$. Then
$$
F(\delta_b)-F(\mu_*)=
\frac{q(b_c)}{6\alpha_c^2(1-\kappa^2)}\,\varepsilon^3+o(\varepsilon^3).
$$
Also $\varepsilon=A'(\alpha_c)(\alpha-\alpha_c)+o(\alpha-\alpha_c)$ with $A'(\alpha_c)>0$. The advantage is zero below the transition. The physical time advantage is obtained by multiplying by $\alpha/(2r)$ at the same rate.

To prove this, use
$$
\partial_x H_-=\alpha+(\alpha+V')H_-,
\qquad \partial_x H_+=-\alpha+(V'-\alpha)H_+ .
$$
Both follow by differentiating the split tail integrals. Near $\alpha_c$ the slopes exceed $2\alpha$ with a uniform margin. This also justifies differentiating the parameter and gives $\partial_\alpha H_\pm>0$. At the transition $D_-=2\alpha_c+V'(b_c)>0$ and $D_+=2\alpha_c-V'(b_c)>0$. The implicit function theorem at balance gives
$$
A'(\alpha_c)=
\frac{D_+\partial_\alpha H_-+D_-\partial_\alpha H_+}{D_-+D_+}>0,
$$
with derivatives evaluated at $(b_c,\alpha_c)$.

Set $d_-=b-L$, $d_+=R-b$ and $t_\pm=\alpha\mp V'(b)/2$. Taylor expansion and the nonzero endpoint derivatives give $2t_\pm d_\pm=\varepsilon+O(\varepsilon^2)$. Taylor expansion of the normalizer gives
$$
\frac{c^{-1}}{2h(b)/\alpha}
=1+\frac{t_-d_-+t_+d_+}{2}+O(\varepsilon^2)
=1+\varepsilon/2+O(\varepsilon^2).
$$
Write $p_0=K_\alpha(\cdot-b)$. Uniformly for $0\le u\le d_\pm$,
$$
\frac{p_0(b\pm u)-p_*(b\pm u)}{\alpha/2}
=\varepsilon/2-t_\pm u+O(\varepsilon^2).
$$
At each endpoint this difference is $O(\varepsilon^2)$. Beyond it the ratio $p_*/p_0$ is constant and therefore $1+O(\varepsilon^2)$. The exact comparison has zero linear term at $\delta_b$, since the certificate is constant on $[L,R]$. Uniform boundedness of $\int q/p_0$ makes the exterior contribution $O(\varepsilon^4)$. On either interior half the squared term integrates to
$$
\frac{2q(b)}{\alpha}\int_0^{d_\pm}(\varepsilon/2-t_\pm u)^2\,du
+O(\varepsilon^4)
=\frac{2q(b)}{\alpha}\frac{\varepsilon^3}{24t_\pm}+O(\varepsilon^4).
$$
Adding the halves gives the coefficient. The two atoms before coalescence tend to masses $(1+\kappa)/2$ on the left and $(1-\kappa)/2$ on the right, directly from their formulas.

## 5. Two asymmetric examples

**Finite slopes.** Take $V(x)=\log(1+e^{-x})+3\log(1+e^x)$. The target is the logit transform of a $\mathrm{Beta}(1,3)$ variable. Substituting $z=(1+e^{-x})^{-1}$ turns the tilted tails into incomplete beta integrals. The critical scale is about $0.3719087183$. The optimizer is a point up to that scale, has two finite boundaries until $\alpha=0.5$, has just a right boundary on $[0.5,1.5)$ and occupies the whole line at $\alpha\ge1.5$. The cubic coefficient is about $0.41109608$. At $\alpha-\alpha_c=10^{-5}$, numerical integration of the exact deficit gives a ratio to $\varepsilon^3$ of about $0.41107028$.

**Infinite risk at every point.** Take the reflected Gumbel density $q(x)=\exp(x-e^x)$ and $\alpha=1$. The slopes are $1$ and $+\infty$. Every deterministic reset has infinite cost. On the right $H_+(x)=e^{-x}+e^{-2x}$, so $R=\log\varphi$ for $\varphi=(1+\sqrt5)/2$ and $L=-\infty$. The distributed optimizer has finite objective
$$
F_*=\left[\sqrt{2\pi}\operatorname{erf}\!\left(\sqrt{\varphi/2}\right)
       +\sqrt{\varphi}\,e^{-\varphi/2}\right]^2 .
$$

The numerical check described in the original manuscript verifies the density reconstruction, mass, sampled certificate and cubic coefficient for six beta-logistic cases. The original manuscript reports partial Lean verification of the one-crossing integral argument and its exterior Laplace specialization. The Brownian reduction, candidate construction, analytic uniqueness and asymptotics are proved in the manuscript. The Lean source and numerical files are not included in this edition.

## 6. Relation to prior work

Evans and Majumdar [1, eqs. (49)–(56)] derive the objective, the unconstrained square-root shape and the inverse operator. Their §5.1 treats a symmetric double-exponential target. Their §5.2 constructs a feasible smooth splice for a symmetric target, and §6 identifies the general positivity-constrained optimization as open. The even, steep-tail case with optimal endpoint atoms has already been treated in the related manuscript [7]. The results here add independent asymmetric boundaries, the half-line and full-line phases, a unique moving-point transition and its cubic objective gain.

Related studies vary the width or parameters of the reset distribution [3, 4], the reset timing law [5], or the spatial triggering rate [6]. The literature check located no equivalent theorem with the same control variable and target class through the stated search date. This manuscript is a research contribution for review, and academic priority remains subject to that review.

## References

1. M. R. Evans and S. N. Majumdar, *Diffusion with optimal resetting*, J. Phys. A **44**, 435001 (2011), especially §§5–6. [DOI](https://doi.org/10.1088/1751-8113/44/43/435001)
2. M. R. Evans, S. N. Majumdar and G. Schehr, *Stochastic resetting and applications*, J. Phys. A **53**, 193001 (2020). [arXiv:1910.07993](https://arxiv.org/abs/1910.07993)
3. V. Méndez et al., *First-passage time of a Brownian searcher with stochastic resetting to random positions*, Phys. Rev. E **109**, 044134 (2024). [DOI](https://doi.org/10.1103/PhysRevE.109.044134)
4. P. Julián-Salgado et al., *Abrupt transitions in the optimization of diffusion with distributed resetting* (2025). [arXiv:2507.14483v2](https://arxiv.org/abs/2507.14483v2)
5. M. R. Evans and S. Ray, *Stochastic Resetting Prevails Over Sharp Restart for Broad Target Distributions* (2025). [DOI](https://doi.org/10.1103/2wpq-gl2j)
6. G. García-Valladares et al., *How target distributions shape optimal stochastic resetting*, Phys. Rev. E **113**, 024107 (2026). [DOI](https://doi.org/10.1103/9m8d-yjhw)
7. *Optimal reset locations for symmetric strictly log-concave targets*, earlier research manuscript. [Companion paper](../optimal-resetting-logconcave/paper.en.md).
