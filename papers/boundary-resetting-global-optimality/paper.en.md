# Global optimality of boundary-only resetting for outward-biased targets

*A sharp supporting bound, asymmetric controls, and the exact zero-reset threshold*

AI-assisted research manuscript

Research initiated 24 November 2026

## Abstract

Consider Brownian search on a finite interval, with instantaneous resetting to the centre at its endpoints and an additional nonnegative, spatially dependent bulk resetting rate. The target is sampled once and remains fixed. We prove that boundary-only resetting uniquely minimizes the mean search time whenever the target density is symmetric and nondecreasing with distance from the centre. The comparison covers every bounded measurable rate, without a common amplitude bound and without imposing symmetry on the control. For a uniform target on the dimensionless interval $[-1,1]$, the mean search time satisfies the sharp global supporting bound

$$
J_1(r)\ge\frac5{12}
+\frac18\int_{-1}^1x^2(1-|x|)^2r(x)\,dx.
$$

A half-interval factorization and Hölder's inequality prove the uniform comparison; a single-crossing argument extends it to outward-biased target densities. For the beta family proportional to $(1-a^2)^{\beta-1}$, zero bulk resetting is globally optimal exactly for $0<\beta\le1$. For $\beta>1$, bounded perturbations near the boundaries strictly improve the objective. We give a finite rational improvement certificate at $\beta=2$ and a second proof of uniform-target global optimality through an exact nonnegative decomposition in inverse cumulative coordinates. The contribution is a global and quantitative comparison over spatial controls; the previously identified threshold and uniform constant are not claimed as new numerical observations. This is a research manuscript with internal verification, not an externally peer-reviewed result.

## Plain-language summary

A searcher explores a corridor by random motion. Whenever it reaches an end without finding the target, it returns immediately to the centre. We ask whether additional returns from interior locations can help. The answer depends on where the target is likely to be. If locations farther from the centre are at least as likely as nearer locations, every nontrivial extra resetting rule makes the average search slower. This remains true even if the resetting rule treats the left and right sides differently or uses very large finite rates. For uniformly distributed targets, the proof also gives an explicit lower bound on the delay caused by a proposed rule. Targets concentrated near the centre behave differently: a small amount of resetting in suitable regions near the endpoints can help.

# 1. Problem, prior results, and contribution

García-Valladares, Prados, Manacorda, and Plata studied this finite-interval search model and derived local criteria for heterogeneous bulk resetting [1]. Their beta-family calculation identifies a transition at $\beta=1$. They distinguish the resulting local information from global optimality: their numerical optimization need not find a global minimum, and the cost lacks an established general convexity argument in the spatial rate.

Pinsky had already studied spatial resetting and the corresponding compact-support boundary convention [2]. His Section 7 obtains the uniform-target constant by optimizing over constant bulk rates, then suggests that symmetric densities increasing with radius should likewise favour zero bulk resetting. The present proof treats arbitrary bounded spatial rates and resolves that comparison in this larger class. The constant itself is inherited from the zero-rate model.

Optimization of the time distribution between resets is a different control problem. Evans and Ray study that question for uncertain target locations [3]; here the control is a function of the current spatial position. Neither the target nor the reset location is resampled at a reset.

The main result is a global supporting inequality at zero bulk resetting. Its coefficient is sharp, and it immediately gives strict uniqueness for the uniform target. A single-crossing argument then proves global uniqueness for every symmetric target density nondecreasing in radius, including integrable densities that diverge at the boundary. An independent inverse-coordinate identity provides a second proof of the uniform comparison. The nonzero optimal profile for a general target distribution remains outside the scope of this manuscript.

# 2. Model and statements

## 2.1. Admissible controls

Use units in which the Brownian generator is $\partial_x^2$ and the interval is $[-1,1]$. The search starts at $0$. On reaching either endpoint it resets instantaneously to $0$. In the interior it resets to $0$ at rate

$$
r\in\mathcal R:=\{r\in L^\infty(-1,1):r\ge0\text{ almost everywhere}\}.
\tag{2.1}
$$

Take a bounded Borel representative when constructing the process. Rates equal almost everywhere give the same occupation-time hazard. There is no common upper bound imposed on $\mathcal R$: every finite bounded profile is admissible. Literal Dirac rates and infinitely strong interior barriers are not members of this class.

A target $a\in(-1,1)$ is drawn independently at the start and kept fixed. Detection terminates the search. Write $T_r(a)$ for the expected detection time from $0$. Target densities will have the form

$$
P(a)=\frac12p(|a|),\qquad p\ge0,\qquad\int_0^1p(a)\,da=1.
\tag{2.2}
$$

Thus $p$ is the density of the target's absolute position. Define

$$
J_p(r)=\frac12\int_0^1p(a)\{T_r(a)+T_r(-a)\}\,da.
\tag{2.3}
$$

The subscript $1$ denotes the uniform target on $[-1,1]$, for which $p=1$.

## 2.2. Main theorems

**Theorem 2.1 (sharp global supporting bound).** Every $r\in\mathcal R$ satisfies

$$
\boxed{
J_1(r)-\frac5{12}
\ge\frac18\int_{-1}^1x^2(1-|x|)^2r(x)\,dx.
}
\tag{2.4}
$$

Consequently $r=0$ is the unique minimizer, up to equality almost everywhere. The constant $1/8$ cannot be increased while retaining (2.4) for all admissible rates.

**Theorem 2.2 (outward-biased targets).** Suppose $p$ has a nondecreasing representative on $[0,1)$. Then for all $r\in\mathcal R$,

$$
J_p(r)\ge J_p(0)=\frac12\int_0^1p(a)(a+a^2)\,da,
\tag{2.5}
$$

with equality exactly when $r=0$ almost everywhere. Neither symmetry of $r$ nor boundedness of $p$ near $1$ is required.

**Theorem 2.3 (global zero-rate threshold for the beta family).** Put

$$
P_\beta(a)=C_\beta(1-a^2)^{\beta-1},\qquad
C_\beta=\frac{\Gamma(\beta+1/2)}{\sqrt\pi\,\Gamma(\beta)},\qquad\beta>0.
\tag{2.6}
$$

Zero bulk resetting is the unique global minimizer over $\mathcal R$ if and only if $0<\beta\le1$. In that range its value is

$$
J_\beta(0)=\frac{C_\beta}{2\beta}+\frac1{2(2\beta+1)}.
\tag{2.7}
$$

For every $\beta>1$ there is a nonzero bounded even function $v\ge0$, supported strictly inside small boundary neighbourhoods, such that $J_\beta(\varepsilon v)<J_\beta(0)$ for all sufficiently small $\varepsilon>0$.

The last statement establishes that zero is not optimal. It does not assert existence or identify the shape of a nonzero global minimizer in $\mathcal R$.

## 2.3. Finiteness and physical scaling

For a positive target $a$, each excursion from $0$ ends when the Brownian path hits $a$, hits $-1$, or undergoes a bulk reset. Its duration is bounded by the Brownian exit time from $[-1,a]$, which has finite expectation. The chance of reaching $a$ before a reset is positive. In fact it is bounded below uniformly in $a\in(0,1]$: consider paths reaching $1$ before $-1$ within a fixed time $t$, and multiply their probability by $e^{-t\|r\|_\infty}$. Repeated independent excursions therefore give uniformly finite mean detection times. Reflection covers negative targets. Before detection, successive excursions start afresh from the centre. Their independent identically distributed positive durations have positive probability of exceeding a fixed positive time; hence an infinite sequence of resets cannot accumulate in finite time.

For a physical interval $[-\ell,\ell]$ and generator $D\partial_X^2$, the dimensionless rate is $r(x)=\ell^2r_{\rm phys}(\ell x)/D$, and physical mean times are $\ell^2/D$ times the values above. Pinsky's convention in [2] uses generator $(D/2)\partial_X^2$; comparisons of constants must account for this factor of two.

# 3. Reduction to two half-interval problems

For $x\in[0,1]$, set $r_+(x)=r(x)$ and $r_-(x)=r(-x)$. For each sign $\sigma\in\{+,-\}$ define the initial-value solutions

$$
\begin{aligned}
s_\sigma''&=r_\sigma s_\sigma,&s_\sigma(0)&=0,&s_\sigma'(0)&=1,\\
k_\sigma''&=r_\sigma k_\sigma+1,&k_\sigma(0)&=0,&k_\sigma'(0)&=0.
\end{aligned}
\tag{3.1}
$$

All ODE identities are interpreted almost everywhere. Bounded measurable coefficients give continuously differentiable solutions with absolutely continuous derivatives. Their Volterra equations are

$$
s_\sigma(x)=x+\int_0^x(x-y)r_\sigma(y)s_\sigma(y)\,dy,
\tag{3.2}
$$

$$
k_\sigma(x)=\frac{x^2}{2}+\int_0^x(x-y)r_\sigma(y)k_\sigma(y)\,dy.
\tag{3.3}
$$

Positivity of the Volterra iteration implies $s_\sigma(x)\ge x$ and $k_\sigma(x)\ge x^2/2$. Introduce the scalars

$$
h_\sigma=\frac{k_\sigma(1)}{s_\sigma(1)},\qquad
B_\sigma=\int_0^1s_\sigma(x)\,dx,\qquad
C_\sigma=\int_0^1k_\sigma(x)\,dx.
\tag{3.4}
$$

**Lemma 3.1 (MFPT factorization).** With $t_+(a)=T_r(a)$ and $t_-(a)=T_r(-a)$,

$$
t_+(a)=h_-s_+(a)+k_+(a),\qquad
t_-(a)=h_+s_-(a)+k_-(a).
\tag{3.5}
$$

*Proof.* For $a>0$, let $U_a(x)$ be the mean detection time from $x\in[-1,a]$. The backward problem is

$$
U_a''+r(x)[U_a(0)-U_a(x)]=-1,
\quad U_a(-1)=U_a(0),\quad U_a(a)=0.
\tag{3.6}
$$

The boundary equality implements immediate resetting at $-1$. Put $V_a(x)=U_a(0)-U_a(x)$. It satisfies $V_a''-rV_a=1$ and $V_a(-1)=V_a(0)=0$. On the negative half, therefore,

$$
V_a(-x)=k_-(x)-h_-s_-(x).
$$

Continuity of the first derivative gives $V_a'(0)=h_-$. On the positive half, the same ODE then gives $V_a(a)=h_-s_+(a)+k_+(a)$. Since $V_a(a)=U_a(0)$, this proves the first formula. Reflection proves the second. The finite mean established above identifies the bounded backward solution with the stochastic expectation. $\square$

For later use, define $q_\sigma$ by

$$
q_\sigma''=r_\sigma q_\sigma,\qquad q_\sigma(0)=1,\quad q_\sigma(1)=0.
\tag{3.7}
$$

The maximum principle, ODE uniqueness, and convexity give

$$
0<q_\sigma(x)\le1-x\quad(0\le x<1),\qquad q_\sigma''\ge0.
\tag{3.8}
$$

In particular $q_\sigma'(1)<0$: otherwise zero terminal value and derivative would force the identically zero solution. Since its derivative is nondecreasing, $q_\sigma$ is strictly decreasing. Lagrange's identities yield

$$
q_\sigma s_\sigma'-q_\sigma's_\sigma=1,
\qquad
(q_\sigma k_\sigma'-q_\sigma'k_\sigma)'=q_\sigma.
$$

Evaluate both at $1$ and divide to obtain

$$
h_\sigma=\int_0^1q_\sigma(x)\,dx\le\frac12.
\tag{3.9}
$$

The inequality is strict if $r_\sigma$ is nonzero on a set of positive measure. Otherwise equality of the integrals in (3.8) forces $q_\sigma=1-x$, and $r_\sigma q_\sigma=q_\sigma''=0$ forces $r_\sigma=0$ almost everywhere.

# 4. The uniform target: a global supporting inequality

## 4.1. A sharp product inequality

**Lemma 4.1.** On either half-interval,

$$
h_\sigma B_\sigma\ge\frac14.
\tag{4.1}
$$

*Proof.* Suppress the sign and put $B(x)=\int_0^xs(y)\,dy$. From (3.1),

$$
(sk'-s'k)'=s,\qquad
\left(\frac{k}{s}\right)'=\frac{B(x)}{s(x)^2}.
$$

The ratio $k(x)/s(x)$ tends to zero at $0$, so

$$
h=\int_0^1\frac{B(x)}{s(x)^2}\,dx.
\tag{4.2}
$$

Also, since $B'=s$,

$$
\int_0^1\frac{s(x)}{\sqrt{B(x)}}\,dx=2\sqrt{B(1)}.
\tag{4.3}
$$

The apparent singularities at zero are removable: $s(x)=x+O(x^3)$ and $B(x)=x^2/2+O(x^4)$. Hölder's inequality, with exponents $3$ and $3/2$, now gives

$$
\begin{aligned}
1
&=\int_0^1
\left(\frac{B}{s^2}\right)^{1/3}
\left(\frac{s}{\sqrt B}\right)^{2/3}dx\\
&\le h^{1/3}\left(2\sqrt{B(1)}\right)^{2/3}.
\end{aligned}
$$

Cubing yields $hB(1)\ge1/4$. $\square$

## 4.2. Separating the two sides

By (3.5),

$$
J_1(r)=\frac12\{C_++C_-+h_-B_++h_+B_-\}.
\tag{4.4}
$$

The cross terms satisfy

$$
h_-B_++h_+B_-
\ge2\sqrt{(h_+B_+)(h_-B_-)}\ge\frac12.
\tag{4.5}
$$

This step is the reason no symmetry assumption on the rate is needed. A gain in one factor cannot be considered independently of the factor multiplying it on the other side.

Integrating (3.3) and interchanging its nonnegative integrals gives the exact identity

$$
C_\sigma-\frac16
=\frac12\int_0^1(1-x)^2r_\sigma(x)k_\sigma(x)\,dx
\ge\frac14\int_0^1x^2(1-x)^2r_\sigma(x)\,dx.
\tag{4.6}
$$

Combining (4.4)–(4.6) proves (2.4). Because the weight $x^2(1-|x|)^2$ is strictly positive at every interior point except $0$, its integral against a nontrivial nonnegative rate is strictly positive. This proves uniqueness up to almost-everywhere equality.

The argument proves a supporting inequality at zero. It does not establish convexity of $J_1$ as a functional of $r$.

## 4.3. Sharpness of the coefficient

The first-variation calculation in Section 6 gives, for any fixed bounded nonnegative function $v$ on $(0,1)$ and the even profile $r_\varepsilon(x)=\varepsilon v(|x|)$,

$$
\left.\frac{d}{d\varepsilon}J_1(r_\varepsilon)\right|_{0}
=\frac14\int_0^1x^2(1-x)^2v(x)\,dx.
\tag{4.7}
$$

The right-hand side of (2.4), divided by $\varepsilon$, is exactly the same quantity. Choosing $v\not\equiv0$ shows that any coefficient larger than $1/8$ fails for sufficiently small positive $\varepsilon$. Thus (2.4) has the best possible universal coefficient.

# 5. From the uniform target to outward-biased densities

Define the paired excess cost

$$
g(a)=\frac{t_+(a)+t_-(a)}2-\frac{a+a^2}{2}.
\tag{5.1}
$$

Since $t_\sigma''=r_\sigma t_\sigma+1$ and $t_\sigma>0$ for $a>0$,

$$
g(0)=0,\qquad
g'(0)=\frac{h_++h_--1}{2}\le0,\qquad
g''(a)=\frac{r_+(a)t_+(a)+r_-(a)t_-(a)}2\ge0.
\tag{5.2}
$$

Thus $g$ is convex. If the rate is nontrivial, (3.9) gives $g'(0)<0$, whereas Theorem 2.1 gives $\int_0^1g(a)\,da>0$. There is therefore a point $b\in(0,1)$ such that

$$
g(a)<0\quad(0<a<b),\qquad g(a)>0\quad(b<a\le1).
\tag{5.3}
$$

For completeness, convexity and $g(0)=0$ imply that $g(a)/a$ is nondecreasing. Its negative initial value and positive integral force a crossing. Once $g$ reaches zero after being negative, its derivative is positive, so a second zero or zero plateau is impossible.

Suppose now that $p$ is nondecreasing. Choose a finite $c\ge0$ between its one-sided values at $b$. Such a value exists because an integrable monotone function is finite at every interior point after a harmless choice of representative. Then

$$
\begin{aligned}
\int_0^1p(a)g(a)\,da
&=c\int_0^1g(a)\,da
+\int_0^1[p(a)-c]g(a)\,da\ge0.
\end{aligned}
\tag{5.4}
$$

Both factors in the last product have the same sign on each side of $b$. If $c>0$, the first term is strictly positive. If $c=0$, monotonicity and normalization force positive target mass above $b$, where $g>0$, again giving strict positivity. The zero-rate case is immediate. This proves Theorem 2.2, including integrable boundary divergences in the target density.

The same reasoning also proves

$$
\int_t^1g(a)\,da\ge0\qquad(0\le t\le1).
\tag{5.5}
$$

Equation (5.5) is an integrated comparison over the outer part of the interval. It is weaker than pointwise domination, which generally fails near the centre: resetting can improve the search for some nearby targets while still increasing every outward-biased average.

# 6. The beta-family threshold and bounded improving perturbations

For $0<\beta\le1$, the radial density $p_\beta(a)=2C_\beta(1-a^2)^{\beta-1}$ is nondecreasing. Theorem 2.2 applies. Its moments are

$$
\mathbb E|A|=\frac{C_\beta}{\beta},\qquad
\mathbb EA^2=\frac1{2\beta+1},
$$

which give (2.7).

To prove the converse using ordinary bounded rates, take $r_\varepsilon(x)=\varepsilon v(|x|)$ with $v\in L^\infty(0,1)$ nonnegative. Dependence of the finite-interval Volterra equations on $\varepsilon$ is differentiable at zero, uniformly in position. Let a dot denote the derivative at zero. Differentiating (3.7) gives

$$
\dot q''(x)=v(x)(1-x),\qquad\dot q(0)=\dot q(1)=0.
$$

Integrating the Dirichlet Green function therefore gives

$$
\dot h=-\frac12\int_0^1x(1-x)^2v(x)\,dx.
\tag{6.1}
$$

Differentiating $t''=\varepsilon vt+1$, $t(0)=0$, and $t'(0)=h_\varepsilon$ yields

$$
\dot t(a)=a\dot h+\frac12\int_0^a(a-x)v(x)x(1+x)\,dx.
\tag{6.2}
$$

Consequently, for any integrable radial density $p$,

$$
\left.\frac{d}{d\varepsilon}J_p(r_\varepsilon)\right|_0
=\int_0^1K_p(x)v(x)\,dx,
\tag{6.3}
$$

where
$$
K_p(x)=\frac{x}{2}\left[(1+x)\int_x^1(a-x)p(a)\,da
-(1-x)^2m_1\right],\quad
m_1=\int_0^1ap(a)\,da.
\tag{6.4}
$$

This agrees with the paired version of the local derivative in [1], but has been derived here for bounded perturbations. With $p=1$, it becomes $K_1(x)=x^2(1-x)^2/4$, proving (4.7).

For $\beta>1$, put $\delta=1-x$. Because $1-a^2\le2(1-a)$,

$$
\begin{aligned}
\int_x^1(a-x)p_\beta(a)\,da
&\le2^\beta C_\beta\int_0^\delta(\delta-z)z^{\beta-1}\,dz\\
&=\frac{2^\beta C_\beta}{\beta(\beta+1)}\delta^{\beta+1}.
\end{aligned}
$$

Since $m_1=C_\beta/\beta$, (6.4) gives

$$
K_{p_\beta}(x)
\le\frac{xC_\beta}{2\beta}\delta^2
\left[\frac{2^{\beta+1}}{\beta+1}\delta^{\beta-1}-1\right]<0
\tag{6.5}
$$

whenever

$$
0<\delta<\min\left\{1,
\left(\frac{\beta+1}{2^{\beta+1}}\right)^{1/(\beta-1)}\right\}.
\tag{6.6}
$$

Choose $v$ nonzero, bounded, nonnegative, and supported on a compact interval of such values of $x$. Then (6.3) is strictly negative, so sufficiently small positive $\varepsilon$ improve the cost. This proves Theorem 2.3. No Dirac rate or limiting infinite barrier is used.

More generally, the same argument shows instability of zero whenever

$$
\int_x^1(a-x)p(a)\,da=o((1-x)^2),\qquad x\uparrow1.
\tag{6.7}
$$

For example, (6.7) holds for a continuous radial density vanishing at the boundary. It is a sufficient instability condition, not a classification of every target density.

# 7. A finite rational improvement certificate

At $\beta=2$, take the explicit profile

$$
b(x)=\mathbf1_{\{3/4\le|x|\le7/8\}},\qquad
r_\varepsilon(x)=\varepsilon b(x),\qquad
\varepsilon=\frac1{100000}.
\tag{7.1}
$$

The unperturbed value is $J_2(0)=23/80$. Here $p_2(a)=\tfrac32(1-a^2)$, and (6.4) simplifies to

$$
K_{p_2}(x)=-\frac{x^2(1-x)^2(x^2+3x-1)}{16}.
$$

Thus the exact directional derivative is

$$
d:=\left.\frac{d}{d\varepsilon}J_2(\varepsilon b)\right|_0
=\int_{3/4}^{7/8}K_{p_2}(x)\,dx
=-\frac{438807}{1174405120}.
\tag{7.2}
$$

To turn the negative derivative into a finite-amplitude certificate, fix $a>0$ and let $G_a$ be the positive occupation operator of the process with boundary resets and no bulk resets, killed at $a$:

$$
(G_af)(x)=\mathbb E_x^0\int_0^{\tau_a}f(X_t)\,dt.
$$

Its norm on bounded functions is bounded by $\|G_a1\|_\infty$. The no-bulk mean from $x\in[-1,a]$ is

$$
u_{0,a}(x)=\frac{a(a+1)-x(x+1)}2,
$$

so, uniformly in $a\in(0,1]$,

$$
\|G_a\|\le\frac98,\qquad\|u_{0,a}\|_\infty\le\frac98.
\tag{7.3}
$$

Let $(K_bf)(x)=b(x)[f(0)-f(x)]$. Then $\|K_b\|\le2$ and $A_a=G_aK_b$ has norm at most $9/4$. The backward equation reads

$$
u_{\varepsilon,a}=u_{0,a}+\varepsilon A_au_{\varepsilon,a}.
$$

For $0\le\varepsilon<4/9$, its Neumann expansion gives

$$
\|u_{\varepsilon,a}-u_{0,a}-\varepsilon A_au_{0,a}\|_\infty
\le\frac{729}{128}\frac{\varepsilon^2}{1-9\varepsilon/4}.
\tag{7.4}
$$

The same bound holds for negative targets by reflection. Averaging and using (7.2),

$$
\begin{aligned}
J_2(\varepsilon b)-J_2(0)
&\le\varepsilon d+\frac{729}{128}\frac{\varepsilon^2}{1-9\varepsilon/4}\\
&=-\frac{148764434097}{46975147835392000000}<0.
\end{aligned}
\tag{7.5}
$$

This is an exact rational upper bound on the change in the true objective, approximately $-3.16687527\times10^{-9}$. The deliberately small rate gives a simple uniform remainder bound; it is not presented as an efficient optimized control. The rational calculation is reproducible without floating-point assumptions. Its stochastic interpretation rests on the proved resolvent bound, not on numerical sampling.

# 8. Interpretation and remaining questions

The uniform-target inequality is global across rate amplitudes. Local positivity of a functional derivative alone would not suffice: a distant control could, in principle, have had a lower cost. The half-interval product inequality prevents that possibility by controlling the coupling of the two sides. Its quantitative consequence also measures the minimum delay caused by a given rate profile. The weight vanishes at the centre and boundaries, reflecting the weaker first-order effect of resets there.

For a target distribution increasing toward the endpoints, the proof does not compare every individual target time. It compares their averages using one sign change of the paired excess time. This distinction matters physically: extra resets can help some central targets while damaging the average for the specified target class.

The exact zero-rate threshold does not provide the optimal nonzero profile for $\beta>1$. Determining that profile, deciding whether the infimum is attained among bounded functions, and controlling possible measure-valued limits are separate problems. Other extensions include nonsymmetric target distributions, time-dependent controls, finite reset durations, and controls depending on the already explored region. None is assumed to follow from the present theorem.

# Appendix A. An independent nonnegative decomposition

The following identity gives a second proof of uniform-target global optimality and resolves the cost into three types of nonnegative contribution. It is not needed for the shorter Hölder proof.

## A.1. A cumulative-coordinate constraint

Use the functions $q_\sigma$ and masses $h_\sigma$ from (3.7)–(3.9). Define

$$
Q_\sigma(x)=\int_0^xq_\sigma(y)\,dy,\quad
F_\sigma(x)=Q_\sigma(x)/h_\sigma,\quad X_\sigma=F_\sigma^{-1}.
\tag{A.1}
$$

For the zero-rate profile,

$$
F_0(x)=2x-x^2,\qquad X_0(u)=1-\sqrt{1-u}.
\tag{A.2}
$$

Convexity and $q_\sigma(1)=0$ imply that $q_\sigma(x)/(1-x)$ is nonincreasing. Indeed, for $x<y<1$, the chord inequality gives

$$
q_\sigma(y)\le\frac{1-y}{1-x}q_\sigma(x).
$$

The likelihood ratio of the normalized densities $q_\sigma/h_\sigma$ and $2(1-x)$ is therefore nonincreasing. Both integrate to one, so

$$
F_\sigma(x)\ge F_0(x),\qquad X_\sigma(u)\le X_0(u).
\tag{A.3}
$$

One direct proof integrates the ratio ordering over $x\in[0,t]$ and $y\in[t,1]$, yielding $F_\sigma(t)[1-F_0(t)]\ge F_0(t)[1-F_\sigma(t)]$.

## A.2. Transforming the objective

Lagrange's identity for $q_\sigma$ and $t_\sigma$ gives

$$
t_\sigma(a)=q_\sigma(a)\int_0^a
\frac{h_{-\sigma}+Q_\sigma(x)}{q_\sigma(x)^2}\,dx,
\qquad 0\le a<1.
\tag{A.4}
$$

Although the integral is singular as $a\uparrow1$, its product with $q_\sigma(a)$ has a finite limit, equal to the regular initial-value solution in (3.5). Tonelli's theorem gives

$$
\int_0^1t_\sigma(a)\,da
=\int_0^1
\frac{[h_{-\sigma}+Q_\sigma(x)][h_\sigma-Q_\sigma(x)]}
{q_\sigma(x)^2}\,dx.
\tag{A.5}
$$

Put $\alpha=h_-/h_+>0$ and $w_c(u)=(c+u)(1-u)$. Changing variables to $u=F_\sigma(x)$ yields

$$
J_1(r)=\frac12\int_0^1
\left[w_\alpha(u)X_+'(u)^3+w_{\alpha^{-1}}(u)X_-'(u)^3\right]du.
\tag{A.6}
$$

For $A,B\ge0$, the elementary identity

$$
A^3=B^3+3B^2(A-B)+(A-B)^2(A+2B)
\tag{A.7}
$$

applied with $A=X_\sigma'$, $B=X_0'$ gives a useful tangent decomposition. Since $X_0'=1/[2\sqrt{1-u}]$,

$$
\int_0^1w_cX_0'^3\,du=\frac c4+\frac16,
\qquad 3w_cX_0'^2=\frac34(c+u).
\tag{A.8}
$$

Integration by parts, using equal endpoints of $X_\sigma$ and $X_0$, turns the linear term into $\tfrac34\int_0^1(X_0-X_\sigma)du$. Define

$$
R_c(X)=\int_0^1w_c(u)[X'(u)-X_0'(u)]^2
[X'(u)+2X_0'(u)]\,du.
\tag{A.9}
$$

Then the exact identity is

$$
\boxed{\begin{aligned}
J_1(r)-\frac5{12}
&=\frac{\alpha+\alpha^{-1}-2}{8}
+\frac38\int_0^1[2X_0-X_+-X_-]du\\
&\quad+\frac12R_\alpha(X_+)+\frac12R_{\alpha^{-1}}(X_-).
\end{aligned}}
\tag{A.10}
$$

All terms on the right are nonnegative. They measure imbalance of the half-interval masses, cumulative-coordinate displacement, and the remaining cubic discrepancy. Equality again forces $X_+=X_-=X_0$, then $q_+=q_-=1-x$, and finally $r=0$ almost everywhere.

## A.3. Endpoint justification

Let $c_\sigma=-q_\sigma'(1)>0$. Since $r_\sigma$ is bounded and $q_\sigma(x)=O(1-x)$, integration of $q_\sigma''=r_\sigma q_\sigma$ gives

$$
q_\sigma(x)=c_\sigma(1-x)+O((1-x)^3),\qquad
1-F_\sigma(x)\sim\frac{c_\sigma}{2h_\sigma}(1-x)^2.
$$

It follows that

$$
X_\sigma'(u)\sim
\sqrt{\frac{h_\sigma}{2c_\sigma}}(1-u)^{-1/2}.
$$

The weighted cubic integrands and the remainders in (A.9) are therefore integrable at $u=1$. The integration by parts can be performed on $[0,1-\eta]$ and passed to the limit; its boundary term tends to zero because $X_\sigma-X_0\to0$ and the coefficient in (A.8) stays bounded. This justifies the exact decomposition for the full admissible class.

# Verification scope and research provenance

The mathematical assertions above are supported by the written proofs. Exact arithmetic checks the polynomial derivative, its integral, and the finite rational certificate in Section 7. The supplied numerical ODE checks cover 30 symmetric and asymmetric rate profiles and 180 weighted-cost evaluations. A separate finite-difference program solves the original nonlocal backward equation. These finite checks do not prove the universal theorems. A formal check of scalar algebra or rational arithmetic does not certify the Brownian construction, ODE reduction, Hölder argument, or integration results unless those statements are separately encoded and compiled. No end-to-end formal verification is claimed.



This AI-assisted manuscript has not undergone external peer review. Literature comparisons rely on accessible primary manuscripts and publisher metadata. The numerical programs and raw outputs are not included in this edition. No claim of absolute priority or a solution for arbitrary target distributions is made.

# References

[1] G. García-Valladares, A. Prados, A. Manacorda, and C. A. Plata. **How target distributions shape optimal stochastic resetting.** *Physical Review E* **113**, 024107 (2026). DOI: [10.1103/9m8d-yjhw](https://doi.org/10.1103/9m8d-yjhw). Author manuscript: [arXiv:2505.16626v2](https://arxiv.org/html/2505.16626v2), 5 February 2026. Relevant locations: Sections II, IV–VI and Appendix B.

[2] R. G. Pinsky. **Diffusive search with spatially dependent resetting.** *Stochastic Processes and their Applications* **130**, 2954–2973 (2020). DOI: [10.1016/j.spa.2019.08.008](https://doi.org/10.1016/j.spa.2019.08.008). Author manuscript: [arXiv:1805.00320v4](https://arxiv.org/pdf/1805.00320), 3 December 2018; also available from the [author's university page](https://math-faculty.net.technion.ac.il/files/2021/05/Diffusive-search-with-spatially-dependent-resetting.pdf). Relevant locations: Corollaries 1–2 and Section 7, especially printed pages 25–26 of the author manuscript.

[3] M. R. Evans and S. Ray. **Stochastic resetting prevails over sharp restart for broad target distributions.** *Physical Review Letters* **134**, 247102 (2025). DOI: [10.1103/2wpq-gl2j](https://doi.org/10.1103/2wpq-gl2j).
