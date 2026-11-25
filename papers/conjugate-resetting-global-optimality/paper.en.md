# Global optimality and uniqueness for conjugate-target renewal resetting

*An exact nonnegative gap identity for Brownian search*

AI-assisted research manuscript

24 November 2026

# Abstract

For Brownian search with an unknown but fixed target, Evans and Ray proposed a target distribution conjugate to a prescribed reset-time law. Their first-variation calculation establishes stationarity; the author manuscript explicitly leaves the global-minimum step to numerical checks within two families. We prove that step in one dimension for every probability law on positive finite reset times, including atoms and laws without a finite mean. A positive symmetric integral representation converts the renewal mean into an exact nonnegative square identity. The reference law is the unique optimizer whenever its conjugate average is finite. If its conjugate energy is infinite, every competing renewal law has infinite averaged mean. We also give a quantitative local stability bound and an extension to a spherical absorbing target in an explicitly defined exterior domain. When the reference energy is finite, the results give uniqueness of the success profile in every stated dimension and of the reset-time law in dimensions one and three. The result concerns independent identically distributed renewal resets, not adaptive or absolute-time-dependent control.

**Status (25 November 2026).** Research manuscript with written proofs. The literature assessment is limited: the full article and supplement of Chechkin–Sokolov [3] remain unavailable and have not been excluded theorem by theorem. Our proof is self-contained and does not rely on their unread contents. No worldwide priority, external peer review, or Lean certification is claimed. No full formalization is included in this edition.

# 1. Question, attribution, and scope

Restarting can help a searcher escape an unproductive excursion. A reset-time distribution specifies how long each attempt is allowed to run. When the target distance is fixed and known, deterministic restart has a general optimality property [2]. A target drawn once and then held fixed is a different optimization problem: the average is taken over the conditional mean completion times, after the renewal quotient is formed.

Evans and Ray [1] introduced a conjugate target law obtained by squaring the single-attempt success profile. Their derivation establishes a stationary point. Immediately after equation (15), the author version states:

> but it remains to confirm that ψ(τ) minimizes Eq. (1) and hence is optimal.

The following numerical tests restrict competitors to two parameterized families. Our question is the unrestricted comparison within the same renewal class.

The contribution here is a proof of that global comparison, its equality conditions, and its extended-value boundary. The conjugate construction, the renewal quotient, the exponential and deterministic examples, and the observation that stochastic resetting can outperform sharp restart are due to prior work. Symmetrization, completion of a square, Laplace uniqueness, and ground-state-style representations [6] are established mathematical methods; we do not claim to have invented them. The substantive connection is a positive spatial kernel linking the Brownian cycle cost to the success profile.

The main theorem is one-dimensional. Section 7 gives a separate radial extension with target-center distance strictly larger than the target radius. Throughout, the target is sampled once; reset times and Brownian attempts are independent; every reset is instantaneous and costless; and the same waiting-time law is reused on each attempt. A common law can have an age-dependent hazard. It cannot depend on the attempt number, earlier failures, the observed path, or absolute elapsed time.

# 2. Model and precise statement

Fix a diffusion coefficient $D>0$. Brownian motion has generator $D\,d^2/dx^2$, so its displacement variance is $2Dt$. For a target at distance $x>0$, let $H_x$ be its first hitting time without reset. Define, for $t>0$,

$$
 Q_t(x)=\Pr(H_x>t)
       =\operatorname{erf}\!\left(\frac{x}{\sqrt{4Dt}}\right),
 \qquad
 F_t(x)=1-Q_t(x),
\tag{2.1}
$$

and the mean duration of an attempt with deterministic cutoff $t$,

$$
 A_t(x)=\mathbb E\min(H_x,t)=\int_0^t Q_s(x)\,ds.
\tag{2.2}
$$

Let $\mathcal P_+$ be the Borel probability laws on $(0,\infty)$. For $\mu\in\mathcal P_+$, put

$$
 f_\mu(x)=\int F_t(x)\,\mu(dt),\qquad
 a_\mu(x)=\int A_t(x)\,\mu(dt),\qquad
 M_\mu(x)=\frac{a_\mu(x)}{f_\mu(x)}.
\tag{2.3}
$$

Here $0<f_\mu(x)<1$, whereas $a_\mu(x)$ and $M_\mu(x)$ may be infinite. No moment condition is imposed on $\mu$.

Choose a reference law $\nu\in\mathcal P_+$ and write $g=f_\nu$. Assume only

$$
 0<Z_\nu:=\int_0^\infty g(x)^2\,dx<\infty.
\tag{2.4}
$$

Its conjugate **distance** distribution is

$$
 \pi_\nu(dx)=Z_\nu^{-1}g(x)^2\,dx.
\tag{2.5}
$$

If a signed target position is wanted, choose its sign independently with equal probabilities. The corresponding density on the whole line is $g(|x|)^2/(2Z_\nu)$. This convention removes any factor-of-two ambiguity.

The quantity to minimize and the reference energy are

$$
 J_\nu(\mu)=\int_0^\infty M_\mu(x)\,\pi_\nu(dx),
 \qquad
 \mathcal E_\nu=\frac1D\int_0^\infty\!\!\int_0^\infty
       \min(x,y)g(x)g(y)\,dx\,dy.
\tag{2.6}
$$

All nonnegative integrals are understood in $[0,\infty]$.

## Theorem 2.1. Global identity and complete equality statement

For every $\mu\in\mathcal P_+$,

$$
 \boxed{\;
 J_\nu(\mu)=\frac{\mathcal E_\nu}{Z_\nu}
  +\frac1{2DZ_\nu}\int_0^\infty\!\!\int_0^\infty
   \min(x,y)\,
   \frac{[g(x)f_\mu(y)-g(y)f_\mu(x)]^2}
        {f_\mu(x)f_\mu(y)}\,dx\,dy .
 \;}
\tag{2.7}
$$

This is an additive identity of nonnegative extended real numbers, not a subtraction of potentially infinite quantities.

If $\mathcal E_\nu<\infty$, then

$$
 J_\nu(\mu)\ge J_\nu(\nu)=\mathcal E_\nu/Z_\nu,
 \qquad
 J_\nu(\mu)=J_\nu(\nu)\ \Longleftrightarrow\ \mu=\nu.
\tag{2.8}
$$

If $\mathcal E_\nu=\infty$, every competing law has $J_\nu(\mu)=\infty$. Thus no renewal law has finite average completion time for that conjugate target distribution.

The reference law may be deterministic, mixed, absolutely continuous, or singular. Section 6 gives an explicit example with $\mathbb E_\nu T=\infty$ and $J_\nu(\nu)<\infty$.

# 3. From Brownian first passage to a positive kernel

## Lemma 3.1. The spatial kernel identity

For each finite $t>0$ and $x>0$,

$$
 A_t(x)=\frac1D\int_0^\infty \min(x,y)F_t(y)\,dy.
\tag{3.1}
$$

**Proof.** Let the right side be $B_t(x)$. The error-function tail is integrable, so differentiation in $x$ gives

$$
 B_t'(x)=D^{-1}\int_x^\infty F_t(y)\,dy,\qquad
 B_t''(x)=-D^{-1}F_t(x).
$$

The backward heat equation for $Q_s$ gives, for $x>0$,

$$
 D A_t''(x)=Q_t(x)-Q_0(x)=-F_t(x),
$$

where $Q_0(x)=1$. The derivatives under the time integral are justified on compact intervals bounded away from $x=0$: their possible powers of $s^{-1}$ are dominated near $s=0$ by $\exp[-x^2/(4Ds)]$.

Both functions vanish at $x=0$. Both are bounded: $0\le A_t\le t$, and

$$
 0\le B_t(x)\le D^{-1}\int_0^\infty yF_t(y)\,dy=t.
$$

The last equality follows by the substitution $y=\sqrt{4Dt}\,u$ and integration by parts, which gives $\int_0^\infty u\,\operatorname{erfc}(u)\,du=1/4$. Thus $A_t-B_t$ is an affine function vanishing at zero and bounded on the half-line. It is identically zero. $\square$

Mixing (3.1) and using Tonelli yields the central relation

$$
 a_\mu(x)=(Kf_\mu)(x),\qquad
 K(x,y)=\frac{\min(x,y)}D.
\tag{3.2}
$$

The kernel is symmetric and strictly positive for $x,y>0$. Neither mixing step requires an integrability assumption: equality holds even when both sides are infinite.

## Lemma 3.2. Renewal mean without a finite-mean assumption

$M_\mu(x)$ in (2.3) is the expected completion time under repeated independent resets with law $\mu$.

**Proof.** Each attempt succeeds with probability $p=f_\mu(x)>0$ and consumes mean time $a_\mu(x)=\mathbb E\min(H_x,T)$. The probability that attempt $k$ is reached is $(1-p)^{k-1}$. Its fresh path and waiting time are independent of previous attempts. Applying Tonelli to the sum of nonnegative attempt costs gives

$$
 \mathbb E T_{\mathrm{complete}}
   =\sum_{k\ge1}(1-p)^{k-1}a_\mu(x)=a_\mu(x)/p.
$$

This also proves the formula when the mean is infinite. There is no finite-time accumulation of reset events: some $\varepsilon>0$ has $\Pr(T\ge\varepsilon)>0$, and independent draws exceed $\varepsilon$ infinitely often almost surely. $\square$

This argument does not redraw the unknown target after a failure. The renewal calculation is conditional on its fixed distance $x$; only afterwards do we average over $\pi_\nu$.

# 4. Global optimality and strict uniqueness

## 4.1. A positive symmetric ratio functional

This is the elementary positive-kernel version of the classical ground-state representation; compare the quadratic case of [6, Proposition 2.3 and Remark 2.4]. We provide the pointwise calculation and the nonnegative extension explicitly.

For positive numbers $f_x,f_y,g_x,g_y$,

$$
 \frac12\left(g_x^2\frac{f_y}{f_x}
                  +g_y^2\frac{f_x}{f_y}\right)
 =g_xg_y+\frac{(g_xf_y-g_yf_x)^2}{2f_xf_y}.
\tag{4.1}
$$

Multiply by a nonnegative symmetric kernel and integrate. Tonelli and symmetry identify the two terms on the left. With $f=f_\mu$, equations (3.2) and (2.6) yield (2.7) directly.

Every term in (4.1) is nonnegative. Consequently the proof remains valid when an integral is infinite. In particular, an infinite reference energy forces every competing objective to be infinite. For a finite reference energy, the square term proves global minimality without a perturbative argument, a convexity assertion, or a restriction to parametric competitors.

## 4.2. Equality determines the success profile

Assume $\mathcal E_\nu<\infty$ and equality in (2.8). The nonnegative double integral vanishes. Strict positivity of $K$, $f_\mu$, and $g$ implies

$$
 \frac{f_\mu(x)}{g(x)}
 =\frac{f_\mu(y)}{g(y)}
 \quad\text{for almost every }(x,y).
$$

Fubini gives $f_\mu=cg$ almost everywhere for a constant $c>0$. Each success profile is continuous by dominated convergence. The equality therefore holds for every $x>0$. Again by dominated convergence,

$$
 \lim_{x\downarrow0}f_\mu(x)
 =\lim_{x\downarrow0}g(x)=1,
$$

so $c=1$.

## 4.3. Equality of profiles determines the waiting-time law

For $x>0$, differentiation of the error-function mixture gives

$$
 f_\mu'(x)
  =-\frac1{\sqrt{\pi D}}\int_0^\infty
       t^{-1/2}e^{-x^2/(4Dt)}\,\mu(dt).
\tag{4.2}
$$

This differentiation is valid without assuming $\int t^{-1/2}\mu(dt)<\infty$. On every compact $x$-interval bounded away from zero, the integrand in the derivative is uniformly bounded over $t>0$.

Let $\rho_\mu$ be the image of $\mu$ under $u=(4Dt)^{-1}$. Profile equality implies

$$
 \int_0^\infty \sqrt u\,e^{-su}\,\rho_\mu(du)
 =\int_0^\infty \sqrt u\,e^{-su}\,\rho_\nu(du)
 \quad (s>0).
$$

Fix $s_0>0$. The measures $\sqrt u\,e^{-s_0u}\rho_\mu(du)$ and $\sqrt u\,e^{-s_0u}\rho_\nu(du)$ are finite, since the weighting function is bounded. Their Laplace transforms agree for all nonnegative parameters. Uniqueness of the Laplace transform of finite measures makes them equal. Removing the strictly positive weight and inverting the bijection $t\mapsto(4Dt)^{-1}$ gives $\mu=\nu$.

For completeness, the finite-measure uniqueness fact follows by mapping $u$ to $e^{-u}\in(0,1)$: transforms at the nonnegative integers give equality of all moments, polynomials are dense in the continuous functions on $[0,1]$, and finite measures are determined by their integrals against continuous functions. This completes Theorem 2.1.

# 5. Quantitative stability and exact admissibility formulas

## 5.1. A local stability estimate

Suppose the reference energy is finite. Set $h(x)=\log(f_\mu(x)/g(x))$. Rewriting the square in (2.7) gives

$$
 J_\nu(\mu)-J_\nu(\nu)
 =\frac1{DZ_\nu}\iint \min(x,y)g(x)g(y)
          [\cosh(h(x)-h(y))-1]\,dx\,dy.
\tag{5.1}
$$

For $I=[b,c]$ with $0<b<c<\infty$, let

$$
 G_I=\int_Ig(x)\,dx,\qquad
 \rho_I(dx)=G_I^{-1}g(x)\mathbf1_I(x)\,dx.
$$

Using $\cosh z-1\ge z^2/2$ and $\min(x,y)\ge b$ on $I^2$,

$$
 \boxed{\quad
 J_\nu(\mu)-J_\nu(\nu)
 \ge\frac{bG_I^2}{DZ_\nu}
       \operatorname{Var}_{\rho_I}
       \!\left(\log\frac{f_\mu}{g}\right).
 \quad}
\tag{5.2}
$$

All logarithms are bounded on this compact interval. The bound controls spatial variation of a near-optimal success-profile ratio. It is not a total-variation bound between reset-time laws, and does not by itself control distant tails.

## 5.2. Nonnegative tests for normalization and finite energy

Writing $\min(x,y)=\int_0^\infty\mathbf1_{\{u<x\}}\mathbf1_{\{u<y\}}\,du$ gives

$$
 \mathcal E_\nu
 =D^{-1}\int_0^\infty
       \left(\int_u^\infty g(x)\,dx\right)^2du.
\tag{5.3}
$$

This is an exact finiteness criterion, valid also with value infinity. If $T,U$ are independent with law $\nu$, elementary Gaussian integrals also give

$$
 Z_\nu=\frac{2\sqrt D}{\sqrt\pi}
  \mathbb E\!\left[\sqrt T+\sqrt U-\sqrt{T+U}\right],
\tag{5.4}
$$

$$
 \mathcal E_\nu=\frac{4\sqrt D}{3\sqrt\pi}
  \mathbb E\!\left[(T+U)^{3/2}-T^{3/2}-U^{3/2}\right].
\tag{5.5}
$$

The expectations are of the displayed nonnegative functions, not differences of separately evaluated expectations. To verify (5.5), integrate first

$$
 \int_0^\infty F_t(x)Q_s(x)\,dx
   =\frac{2\sqrt D}{\sqrt\pi}\,[\sqrt{t+s}-\sqrt s]
$$

over $0<s<u$. Formula (5.4) follows by the same integration-by-parts calculation for the product of two complementary error functions. These deterministic integral formulas are already present, with density conventions, in the supplement of [1]. Their role here is to specify admissibility and provide independent computational checks.

# 6. Three explicit reference laws

## 6.1. Exponential resets and an unrestricted optimality conclusion

Let $\nu=\operatorname{Exp}(r)$, $r>0$, and $\alpha=\sqrt{r/D}$. Then

$$
 g(x)=e^{-\alpha x},\qquad
 a_\nu(x)=\frac{1-e^{-\alpha x}}r,\qquad
 \pi_\nu(dx)=2\alpha e^{-2\alpha x}\,dx,\qquad
 J_\nu(\nu)=\frac1r.
\tag{6.1}
$$

The construction and this reference value are known [1]. Theorem 2.1 shows that no other law in $\mathcal P_+$ has a smaller average, and equality forces the same exponential law.

For a competing exponential law with rate $s$, set $z=\sqrt{s/r}$. Direct integration yields

$$
 J_\nu(\operatorname{Exp}(s))
 =\frac1{r z(2-z)},\qquad
 J_\nu(\operatorname{Exp}(s))-\frac1r
 =\frac{(z-1)^2}{r z(2-z)}
 \quad(0<z<2).
\tag{6.2}
$$

For $z\ge2$, the objective diverges. The threshold is important: truncating the target domain can conceal an infinite averaged mean.

A competitor outside the single-exponential family is, for $D=r=1$,

$$
 \mu=\tfrac12\operatorname{Exp}(1)
       +\tfrac12\operatorname{Exp}(4).
$$

It has $f_\mu(x)=(e^{-x}+e^{-2x})/2$ and
$a_\mu(x)=(1-e^{-x})/2+(1-e^{-2x})/8$. Substituting $u=e^{-x}$ in the target average gives the exact value

$$
 J_\nu(\mu)=4\log2-\frac74>1.
\tag{6.3}
$$

## 6.2. Deterministic resets

For $\nu=\delta_\tau$,

$$
 g(x)=\operatorname{erfc}\!\left(\frac{x}{\sqrt{4D\tau}}\right),
 \quad
 Z_\nu=\frac{2(2-\sqrt2)\sqrt{D\tau}}{\sqrt\pi},
 \quad
 J_\nu(\nu)=\frac{2\sqrt2}{3}\tau.
\tag{6.4}
$$

The last identity follows from (5.4)-(5.5). Theorem 2.1 gives strict optimality among all positive waiting-time laws, rather than only Gaussian perturbations of a deterministic time.

For a competing deterministic cutoff $s$, the averaged mean is finite exactly when $s>\tau/2$. Indeed, the large-$x$ integrand is a positive constant times

$$
 x^{-1}\exp\!\left[
 x^2\left(\frac1{4Ds}-\frac1{2D\tau}\right)\right](1+o(1)).
$$

At $s=\tau/2$ its integral diverges logarithmically. Near $x=0$ there is no divergence.

## 6.3. A finite optimum with infinite mean reset time

Fix $t_0>0$ and take the inverse-gamma law

$$
 \nu(dt)=t_0t^{-2}e^{-t_0/t}\,dt.
\tag{6.5}
$$

Equivalently $T=t_0/U$ with $U\sim\operatorname{Exp}(1)$, so $\mathbb E T=\infty$. Set $c=2\sqrt{Dt_0}$. Direct integration gives

$$
 g(x)=1-\frac{x}{\sqrt{x^2+c^2}},\qquad
 \int_x^\infty g(y)\,dy=\sqrt{x^2+c^2}-x,
\tag{6.6}
$$

$$
 a_\nu(x)=
 \frac{x\sqrt{x^2+c^2}
       +c^2\operatorname{arsinh}(x/c)-x^2}{2D}.
\tag{6.7}
$$

For example, set $u=t_0/t$ and integrate $\int_0^\infty e^{-u}\operatorname{erfc}(x\sqrt u/c)\,du$ by parts to obtain (6.6). Integrating its square and using $x=c\sinh v$ in (5.3) yields

$$
 Z_\nu=\sqrt{Dt_0}(4-\pi),\qquad
 \mathcal E_\nu=\frac{16}{3}\sqrt D\,t_0^{3/2},\qquad
 \boxed{J_\nu(\nu)=\frac{16t_0}{3(4-\pi)}.}
\tag{6.8}
$$

This law is therefore the unique optimizer for its conjugate distance distribution despite having infinite mean waiting time. The inverse-gamma family itself was considered in [1]; the example illustrates the precise scope of the global theorem and supplies closed expressions for verification.

The conjugate priors are different; their costs should not be compared as if they shared a common target.

# 7. Radial extension with an explicit exterior domain

Let $d\ge2$ be an integer, let $a>0$, and place the center of an absorbing sphere at distance $R>a$ from the reset point. By translation and rotation this is equivalent to Brownian motion starting at radius $R$ outside a sphere centered at zero. The sphere is fixed throughout the search. Its radial generator is

$$
 \mathcal L=D\left(\frac{d^2}{dR^2}
          +\frac{d-1}{R}\frac d{dR}\right).
$$

Use the measure and kernel

$$
 m_d(dR)=R^{d-1}dR,\qquad
 K_d(R,S)=\frac1D\int_a^{\min(R,S)}u^{1-d}\,du.
\tag{7.1}
$$

For $d=2$, $K_d=D^{-1}\log(\min(R,S)/a)$. For $d\ne2$,

$$
 K_d(R,S)=
 \frac{\min(R,S)^{2-d}-a^{2-d}}{D(2-d)}.
$$

It is strictly positive and symmetric on the exterior domain. For $d>2$ it must not be confused with the usual Green kernel subject to a vanishing value at spatial infinity.

## Lemma 7.1. The radial representation

With $F_t(R)=\Pr_R(H_a\le t)$ and
$A_t(R)=\int_0^t\Pr_R(H_a>s)\,ds$,

$$
 A_t(R)=\int_a^\infty K_d(R,S)F_t(S)\,m_d(dS).
\tag{7.2}
$$

**Proof.** For $\lambda>0$, put $q_\lambda(R)=\mathbb E_R e^{-\lambda H_a}$, with $e^{-\lambda\infty}=0$. The bounded hitting-time transform solves

$$
 D(R^{d-1}q_\lambda')'
   =\lambda R^{d-1}q_\lambda,\qquad
 q_\lambda(a)=1,\qquad q_\lambda(\infty)=0.
$$

Explicitly, writing $\kappa=1-d/2$,

$$
 q_\lambda(R)=
 \left(\frac Ra\right)^\kappa
 \frac{\mathrm K_\kappa(R\sqrt{\lambda/D})}
      {\mathrm K_\kappa(a\sqrt{\lambda/D})},
\tag{7.3}
$$

where $\mathrm K_\kappa$ is the modified Bessel function, distinct from our spatial kernel. This standard first-passage transform also appears in [1, supplemental Eq. S42]. Its exponential decay implies $R^{d-1}q_\lambda'(R)\to0$. Integrating the differential equation gives

$$
 \int_u^\infty q_\lambda(S)S^{d-1}dS
  =-\frac D\lambda u^{d-1}q_\lambda'(u).
$$

Tonelli and an integration in $u$ now show

$$
 (K_dq_\lambda)(R)
 =-\lambda^{-1}\int_a^R q_\lambda'(u)\,du
 =\frac{1-q_\lambda(R)}{\lambda}.
\tag{7.4}
$$

The time Laplace transforms of $F_t$ and $A_t$ are, respectively, $q_\lambda/\lambda$ and $(1-q_\lambda)/\lambda^2$. Thus Tonelli shows that the right side of (7.2) has the same transform as its left side.

To upgrade transform equality to every finite $t$, fix $T<\infty$. The bound
$F_t(S)\le e^{\lambda T}q_\lambda(S)$ for $0\le t\le T$, together with (7.4), proves finiteness and continuity of $K_dF_t$ in $t$ by dominated convergence. $A_t$ is continuous as well. Laplace uniqueness proves (7.2). $\square$

## Corollary 7.2. Global radial optimality

Define $f_\mu,a_\mu$ as before, using radial first passage. Set

$$
 \begin{aligned}
 Z_\nu&=\int_a^\infty g^2\,dm_d,\\
 \pi_\nu(dR)&=Z_\nu^{-1}g(R)^2\,m_d(dR),\\
 \mathcal E_\nu&=\iint K_d(R,S)g(R)g(S)\,dm_d(R)dm_d(S).
 \end{aligned}
$$

Whenever $0<Z_\nu<\infty$, the additive identity (2.7) holds with $\min(x,y)/D$ replaced by $K_d$ and Lebesgue measure replaced by $m_d$. Its proof is exactly (4.1), now justified by Lemma 7.1.

If the energy is finite, equality holds exactly when $f_\mu=f_\nu$. Boundary continuity and $f_\mu(a+)=f_\nu(a+)=1$ remove the multiplicative constant. In three dimensions,

$$
 F_t(R)=\frac aR
  \operatorname{erfc}\!\left(\frac{R-a}{\sqrt{4Dt}}\right),
$$

so profile equality reduces to the one-dimensional injectivity proof and implies $\mu=\nu$. We do not assert reset-law injectivity in the other dimensions.

In the finite-energy case, for $I=[b,c]$ with $a<b<c<\infty$, the radial counterpart of (5.2) is

$$
 J_\nu(\mu)-J_\nu(\nu)
 \ge \frac{k_I G_I^2}{Z_\nu}
   \operatorname{Var}_{\rho_I}\!\left(\log(f_\mu/g)\right),
 \quad
 k_I=\frac1D\int_a^b u^{1-d}du,
\tag{7.5}
$$

with $G_I=\int_Ig\,dm_d$ and $\rho_I=g\,dm_d/G_I$ on $I$.

**Domain convention.** Section VIII of the author supplement discusses $R>a$ while some normalization displays integrate from zero. Here every radial integral is explicitly over $R>a$, so the starting point is outside the target. The constant surface-area factor cancels in the normalized radial probability. We do not extend an exterior Bessel expression inside the target or take a zero-radius limit in $d\ge2$. With $a>0$, exponential reset laws produce normalizable conjugate priors with finite energy in every integer dimension: their profiles are bounded at $a$ and have exponential tails at infinity. No $d<4$ restriction is imported from a different lower-limit convention.

# 8. Verification and limitations

The accompanying programs check the exact algebra using symbolic manipulation and rational arithmetic, evaluate independent integral expressions, reproduce the explicit examples, and test radial resolvent identities. Computations are evidence about the formulas and their implementation. They are not substitutes for the continuum proof, and floating-point output is not an interval certificate.

The independent scripts use direct time integration, spatial integration, and known closed forms as separate oracles. Recorded outputs include precision, tolerances, parameters, and actual execution results. The research log records objections concerning infinite means, zero-time atoms, the radial boundary, density conventions, and the scope of uniqueness.

No Lean theorem is supplied. The written result uses measure-theoretic interchanges and standard uniqueness arguments; the algebraic certificates cover only their stated algebraic or finite-dimensional portions. No part of the paper is described as end-to-end machine-verified.

Several restrictions matter. Allowing a zero-time atom makes waiting-law uniqueness false: $\mu=p\delta_0+(1-p)\nu$, $p<1$, scales both $a$ and $f$ by $1-p$ and leaves their ratio unchanged. A nonzero reset overhead changes the cycle-cost numerator, so it requires a different analysis. Adaptive or absolute-time-dependent schedules, feedback from the path, non-Brownian dynamics, and arbitrary prescribed target laws are not solved here. Uniqueness of the optimal reset law for a fixed conjugate prior does not mean that a reset law can be optimal for only one target prior.

Within the recorded search, we did not locate an earlier proof of this unrestricted conjugate-prior comparison. This is a bounded negative search result, not certification of novelty or worldwide priority. The full text of the important antecedent [3] was not obtained from the checked lawful public sources; its abstract includes multiple targets, so we do not exclude its complete theorem scope from the abstract alone. The literature assessment remains limited by that unavailable full text; it is not a complete exclusion of all antecedents. The comparison is restricted to the cited literature.

# References

[1] M. R. Evans and S. Ray, *Stochastic Resetting Prevails Over Sharp Restart for Broad Target Distributions*, Physical Review Letters **134**, 247102 (2025). DOI: [10.1103/2wpq-gl2j](https://doi.org/10.1103/2wpq-gl2j). Author version actually inspected: [arXiv:2410.01941v2](https://arxiv.org/abs/2410.01941v2), 19 May 2025, main text and supplement.

[2] A. Pal and S. Reuveni, *First Passage under Restart*, Physical Review Letters **118**, 030603 (2017). DOI: [10.1103/PhysRevLett.118.030603](https://doi.org/10.1103/PhysRevLett.118.030603).

[3] A. Chechkin and I. M. Sokolov, *Random Search with Resetting: A Unified Renewal Approach*, Physical Review Letters **121**, 050601 (2018). DOI: [10.1103/PhysRevLett.121.050601](https://doi.org/10.1103/PhysRevLett.121.050601). Bibliographic and abstract verification only; full-text comparison pending.

[4] M. R. Evans and J. C. Sunil, *Stochastic Resetting and Large Deviations* (2025), [arXiv:2412.16374v2](https://arxiv.org/html/2412.16374v2), especially Section 8.2. This later exposition cites the conjugate example but does not supply the unrestricted proof.

[5] G. García-Valladares, A. Prados, A. Manacorda, and C. A. Plata, *How target distributions shape optimal stochastic resetting*, Physical Review E **113**, 024107 (2026), [arXiv:2505.16626v2](https://arxiv.org/html/2505.16626v2). Its finite-domain, position-dependent rate optimization is a different admissible control problem.

[6] R. L. Frank and R. Seiringer, *Non-linear ground state representations and sharp Hardy inequalities*, Journal of Functional Analysis **255**, 3407-3430 (2008). DOI: [10.1016/j.jfa.2008.05.015](https://doi.org/10.1016/j.jfa.2008.05.015). [arXiv:0803.0503v2](https://arxiv.org/abs/0803.0503v2), Section 2, Proposition 2.3 (quadratic case) and Remark 2.4.
