# Exact capacity of the quadratic-cost Laplace channel

**A compact mixed optimizer, a global entropy certificate, and sharp endpoint asymptotics**

Research manuscript, 26 November 2026. This is a written mathematical research draft; it has not received external peer review. Formal proof-assistant verification has not been completed.

## Abstract

For independent centered Laplace noise of scale one, we determine the supremum of mutual information over all Borel input laws with a prescribed upper bound on the second moment. At every positive budget, the unique optimal input has a strictly positive density on a compact interval and a positive atom at each endpoint. Its output is a Gaussian segment joined to exponential tails. The support radius parametrizes every positive budget continuously and strictly increasingly. An exact identity decomposes the loss of any finite-second-moment input into unused-power cost, output relative entropy, and a nonnegative term outside the optimal support. We obtain the sharp low-power expansion
$C(P)=P/2-P^{3/2}/3+P^2/12+O(P^{5/2})$
and the high-power Gaussian-entropy gap
$U(P)-C(P)\sim\sqrt{2/\pi}\,e^{-P/2}P^{-5/2}$.
The identity also gives quantitative near-optimality consequences and an exact allocation rule for finitely many independent parallel Laplace channels. Known compact-support criteria, capacity-per-unit-cost results, and the existing fractional-order upper bound are explicitly distinguished from the exact solution.

## 1. Problem and position

Let $b>0$. The centered Laplace density is

$$
k_b(z)=\frac{1}{2b}e^{-|z|/b},\qquad z\in\mathbb R.
$$

The noise $Z$ has this density and is independent of $X$. We study the single-letter **information capacity**

$$
C_b(P)=\sup_{\nu:\,\int x^2\,\nu(dx)\le P}I(X;X+Z),
\qquad P\ge0,
\tag{1.1}
$$

where $\nu$ ranges over all Borel probability measures on $\mathbb R$. Logarithms are natural, so information is in nats. There is no imposed mean, symmetry, density, finite-alphabet, or amplitude restriction. We do not prove a new operational coding theorem, error exponent, or finite-blocklength result. Write $C=C_1$ and $k=k_1$.

Two published predecessors delimit the contribution particularly closely. Verdú [V02, Theorems 3 and 22] analyzes the Laplacian low-power regime. In our real, scale-one normalization, his proof gives

$$
C(P)\le \sqrt P+e^{-\sqrt P}-1
=\frac P2-\frac{P^{3/2}}6+\frac{P^2}{24}+O(P^{5/2}).
\tag{1.2}
$$

The first-order slope, vanishing wideband slope, and occurrence of a fractional-order bound therefore predate this work. Fahs and Abou-Faycal [FA18, Theorem 7] already imply compact optimal support for Laplace noise and quadratic cost. We determine the exact law and capacity, including the sharp loss coefficient in place of the relaxed bound (1.2).

Generalized-Gaussian moment bounds and deconvolution background appear in [DBPS17]. The analyticity assumption in [FAA12] excludes the Laplace cusp, so our mixed optimizer is not a counterexample to that paper's conditional discreteness result. The recent error-exponent analysis [TS26] includes the same quadratic-cost Laplace model but addresses a different optimization target.

Our literature review has limitations. The primary full texts of [D00] and [NT22] were unavailable, and some older high-power references could be screened only at metadata or abstract level. The technical version read for [TS26] is its 2025 preprint, with the 2026 publication metadata separately verified. We make no unconditional worldwide-priority claim. Mathematical correctness of the statements below does not depend on completeness of this search.

The Laplace Green-kernel inverse, entropy duality, characteristic-function uniqueness, and separable concave allocation are established tools. The first two ingredients are established methods. The present contribution is the all-power quadratic-cost solution and its exact consequences.

## 2. Main statements

For $a>0$, define

$$
\begin{gathered}
v=a+1,\qquad \lambda_a=\frac1{2v},\qquad
t_a=e^{-a^2/(2v)},\\
J_a=\int_{-a}^{a}e^{-y^2/(2v)}\,dy,\qquad
A_a=J_a+2t_a,\qquad r_a=\frac{2t_a}{A_a}.
\end{gathered}
\tag{2.1}
$$

The letter $A_a$ denotes a normalizing constant, not a noise variable. Set

$$
q_a(y)=\frac1{A_a}
\begin{cases}
e^{-y^2/(2v)},& |y|\le a,\\
t_a e^{-(|y|-a)},& |y|>a,
\end{cases}
\tag{2.2}
$$

and define the mixed measure

$$
\mu_a(dx)=
\mathbf1_{\{|x| \lt a\}}q_a(x)
\left(1+\frac1v-\frac{x^2}{v^2}\right)dx
+\frac{q_a(a)}v(\delta_{-a}+\delta_a).
\tag{2.3}
$$

Finally, let

$$
\mathcal P(a)=a-1+r_a,\qquad
\psi(s)=s^2-2s+2(1-e^{-s}),\quad s\ge0.
\tag{2.4}
$$

**Theorem 2.1 (exact all-power solution).** The function $\mathcal P$ is a continuous strictly increasing bijection from $(0,\infty)$ to $(0,\infty)$. For $P>0$, let $a(P)$ be its inverse. Then $\mu_{a(P)}$ is the unique maximizer in (1.1) with $b=1$, it uses the entire budget, and its output density is $q_{a(P)}$. Its capacity is

$$
\begin{aligned}
C(P)&=\log(A_a/2)-1+\frac{P+2}{2(a+1)}\\
&=\log(A_a/2)-\frac12+\frac{r_a}{2(a+1)},
\qquad a=a(P).
\end{aligned}
\tag{2.5}
$$

For every $P>0$, the optimal input has precisely the continuous component and the two positive endpoint atoms in (2.3). In particular, no purely discrete input is optimal. At zero budget, the unique input is $\delta_0$ and $C(0)=0$. For arbitrary scale,

$$
C_b(P)=C(P/b^2),
\tag{2.6}
$$

For $P>0$, the optimizer is the image of $\mu_{a(P/b^2)}$ under $x\mapsto bx$; for $P=0$ it is $\delta_0$.

**Theorem 2.2 (exact loss identity).** Fix $a>0$ and $P=\mathcal P(a)$. For every Borel probability law $\nu$ with finite second moment, let $p=k*\nu$. Then all terms in the following identity are finite:

$$
\begin{aligned}
C(P)-I(\nu;k)
={}&\lambda_a\left(P-\int x^2\,\nu(dx)\right)
+D(p\Vert q_a)\\
&+\lambda_a\int
\psi\bigl((|x|-a)_+\bigr)\,\nu(dx).
\end{aligned}
\tag{2.7}
$$

Here $I(\nu;k)$ denotes mutual information through the additive channel. The identity also holds for inputs exceeding $P$, although then its first term need not be nonnegative. For feasible inputs every term on the right is nonnegative.

**Theorem 2.3 (sharp endpoint asymptotics).** In scale-one units,

$$
C(P)=\frac P2-\frac{P^{3/2}}3+\frac{P^2}{12}
+O(P^{5/2})\qquad(P\downarrow0).
\tag{2.8}
$$

Define the Gaussian-output entropy upper bound

$$
U(P)=\frac12\log\frac{\pi(P+2)}{2e}.
\tag{2.9}
$$

For every $P\ge0$, $C(P) \lt U(P)$, and

$$
U(P)-C(P)\sim
\sqrt{\frac2\pi}\,e^{-P/2}P^{-5/2}
\qquad(P\to\infty).
\tag{2.10}
$$

The strict upper bound does not assert that $U$ is achievable. Sections 7 and 9 give the quantitative loss and parallel-channel consequences.

## 3. Entropy and convolution preliminaries

**Lemma 3.1 (finite entropies for the full input class).** If $\nu$ is any Borel probability measure with finite second moment, then $p=k*\nu$ is a strictly positive density,

$$
0 \lt p(y)\le\frac12,\qquad
p(y)\ge c_\nu e^{-|y|}\quad(y\in\mathbb R)
\tag{3.1}
$$

for some $c_\nu>0$. Its differential entropy is finite. For every fixed $a>0$, its cross entropy against $q_a$ and $D(p\Vert q_a)$ are finite.

*Proof.* Tonelli gives unit mass, and positivity and the upper bound follow from those of $k$. Choose $M<\infty$ with $m=\nu([-M,M])>0$. Then

$$
p(y)\ge\frac m2e^{-(|y|+M)}.
$$

Thus $\log2\le-\log p(y)\le |y|+M+\log(2/m)$. Since
$\mathbb E|X+Z|\le(\mathbb EX^2)^{1/2}+1$,
the entropy integral is finite. The function $-\log q_a(y)$ has at most linear absolute growth: it is bounded on the compact core and affine in $|y|$ outside. Its integral against $p$ is finite, as is the integral of $|\log(p/q_a)|$ against $p$. This proves all assertions. $\square$

**Lemma 3.2 (mutual information and an entropy identity).** Under Lemma 3.1,

$$
I(\nu;k)=h(p)-\log(2e).
\tag{3.2}
$$

If $g_a=-\log q_a$ and $H_a=k*g_a$, then

$$
h(p)=\int H_a(x)\,\nu(dx)-D(p\Vert q_a).
\tag{3.3}
$$

*Proof.* The joint density relative to $\nu(dx)\,dy$ is $k(y-x)$. The expectation of $|\log k(Y-X)|$ is $\log2+\mathbb E|Z|=\log2+1$, and the expectation of $|\log p(Y)|$ is finite by Lemma 3.1. Expanding the defining relative entropy for mutual information therefore involves no indeterminate subtraction and gives (3.2). Expanding $D(p\Vert q_a)$ gives $h(p)=\int p g_a-D(p\Vert q_a)$. The linear growth bound on $g_a$ makes the iterated integral absolutely integrable, so Fubini yields $\int p g_a=\int H_a\,d\nu$. $\square$

**Lemma 3.3 (Laplace inversion and uniqueness).** In distributions,

$$
(1-D^2)k=\delta_0.
\tag{3.4}
$$

Suppose $q$ is integrable and continuous, is twice continuously differentiable off a finite set of junctions, has finite one-sided first derivatives there, and has integrable ordinary second derivative away from the junctions. Assume also that $q$ and $q'$ decay exponentially at both infinities. Then $(1-D^2)q$ consists of its ordinary density $q-q''$ away from the junctions and atoms equal to minus the jumps of $q'$ at those junctions. If this measure is a finite probability measure $\mu$, then $k*\mu=q$. Moreover, convolution with $k$ is injective on finite Borel measures.

*Proof.* Away from zero, $k''=k$. Its first derivative has jump $-1$ at zero, proving (3.4). Integration by parts on each smooth interval gives the stated junction formula; continuity of $q$ excludes derivatives of delta masses. For the Fourier convention $\widehat f(u)=\int e^{iux}f(x)\,dx$, elementary integration gives
$\widehat k(u)=(1+u^2)^{-1}$.
The derivative formula gives
$\widehat\mu(u)=(1+u^2)\widehat q(u)$,
so $\widehat{k*\mu}=\widehat q$. Uniqueness of Fourier transforms of finite measures yields the convolution assertion. The same nonvanishing transform of $k$ proves injectivity. These are statements about ordinary finite measures; no generalized input distribution is used. $\square$

## 4. Constructing the feasible optimizer

**Lemma 4.1 (positive mixed input).** For every $a>0$, $q_a$ is a continuous strictly positive probability density, $\mu_a$ is a probability measure, and $k*\mu_a=q_a$.

*Proof.* The two output tails integrate to $2t_a/A_a$, so (2.1) normalizes $q_a$. Inside the core,

$$
q_a''(x)=\left(\frac{x^2}{v^2}-\frac1v\right)q_a(x).
\tag{4.1}
$$

The coefficient of the continuous input density is positive because

$$
1+\frac1v-\frac{x^2}{v^2}
\ge\frac{3a+2}{v^2}>0
\qquad (|x|\le a).
\tag{4.2}
$$

At $a$ the one-sided derivatives are $-a q_a(a)/v$ and $-q_a(a)$, whose jump is $-q_a(a)/v$. At $-a$ the jump has the same value. Outside the core $q_a''=q_a$. Hence Lemma 3.3 gives exactly the measure in (2.3), including both atoms.

For completeness its mass can be checked directly. Integrating the core part of $q_a-q_a''$ gives
$J_a/A_a+2a q_a(a)/v$.
The two atoms contribute $2q_a(a)/v$; since $v=a+1$, the sum is
$J_a/A_a+2q_a(a)=1$.
The convolution assertion follows from Lemma 3.3. Both atoms and the density on every nonempty open subinterval of the core are strictly positive. $\square$

**Lemma 4.2 (exact power).** The input $\mu_a$ is centered, its second moment is $\mathcal P(a)$, and

$$
\int y^2q_a(y)\,dy=v+r_a.
\tag{4.3}
$$

*Proof.* Symmetry gives mean zero. Integration by parts gives

$$
\int_{-a}^a y^2e^{-y^2/(2v)}\,dy=vJ_a-2avt_a.
\tag{4.4}
$$

Each exponential tail has second-moment integral
$t_a(a^2+2a+2)$ before division by $A_a$. Combining both tails with (4.4) yields

$$
\int y^2q_a(y)\,dy
=\frac{vJ_a+2t_a(v+1)}{A_a}=v+r_a.
$$

All input moments are finite by compact support. Realize $X\sim\mu_a$ independently of $Z\sim k$; by Lemma 4.1 the output is $q_a$. Since $\mathbb EZ=0$ and $\mathbb EZ^2=2$, its second moment is $\mathbb EX^2+2$. Thus $\mathbb EX^2=v+r_a-2=a-1+r_a$. It is positive because $\mu_a$ is not concentrated at zero. $\square$

## 5. A global certificate and uniqueness

**Lemma 5.1 (explicit convolution potential).** With $g_a=-\log q_a$,

$$
H_a(x)=
\begin{cases}
\log A_a+1/v+x^2/(2v),& |x|\le a,\\
\log A_a+a^2/(2v)+s+e^{-s}/v,
& |x|=a+s,\ s\ge0.
\end{cases}
\tag{5.1}
$$

*Proof.* The convolution $k*g_a$ exists and has at most linear growth. By (3.4) it solves $(1-D^2)H_a=g_a$ in distributions. The proposed expression is continuously differentiable at each junction: at $a$, its derivatives are $a/v$ and $1-1/v=a/v$, and its values agree. Direct differentiation on both regions gives the same equation; its second derivatives also agree at the junctions.

The difference between the convolution and the proposed expression solves $F''=F$ distributionally. Such a solution is an ordinary linear combination of $e^x$ and $e^{-x}$, as follows by solving the constant-coefficient first-order factors of $D^2-1$. A function of at most linear growth at both infinities can contain neither exponential. The difference is zero. $\square$

**Lemma 5.2 (global noncontact residual).** For every real $x$,

$$
\log A_a+\frac1v+\lambda_a x^2-H_a(x)
=\lambda_a\psi((|x|-a)_+).
\tag{5.2}
$$

The right side is zero for $|x|\le a$ and strictly positive for $|x|>a$. Moreover, $\psi$ is strictly increasing on $(0,\infty)$ and grows at most quadratically.

*Proof.* The core equality is immediate. Outside put $|x|=a+s$ in (5.1) and use $v=a+1$. This yields (5.2) exactly. Also

$$
\psi(0)=\psi'(0)=0,\qquad
\psi''(s)=2(1-e^{-s})>0\quad(s>0).
\tag{5.3}
$$

Twice integrating proves strict positivity, and once integrating proves monotonicity. The formula (2.4) gives a quadratic upper bound for large $s$, and continuity handles bounded $s$. $\square$

*Proof of Theorem 2.2 and optimality in Theorem 2.1 at $P=\mathcal P(a)$.* On the support of $\mu_a$ the residual vanishes. Equations (3.3) and (5.2), with $\nu=\mu_a$, give

$$
h(q_a)=\log A_a+\frac1v+\lambda_a P.
\tag{5.4}
$$

Subtracting the noise entropy gives (2.5). For an arbitrary finite-second-moment $\nu$, integrate (5.2) and use (3.3). Subtracting its mutual information from the value (5.4) gives (2.7). The residual is integrable by its quadratic growth, and all other terms are finite by Lemma 3.1.

If $\nu$ is feasible at $P$, the three terms in (2.7) are nonnegative, proving global optimality. If equality holds, $D(p\Vert q_a)=0$, so $p=q_a$ almost everywhere. Lemma 3.3 then gives $\nu=\mu_a$. In particular the mean, symmetry, mixed structure, and full power use of an optimizer are conclusions, not assumptions on the competitor class. The budget range needed to finish Theorem 2.1 is proved next. $\square$

## 6. The parameter covers every budget

**Lemma 6.1 (normalizer and power derivatives).** For $a>0$,

$$
\frac{A_a'}{A_a}=\frac1{2v}+\frac{r_a}{2v^2},
\qquad
r_a'=-\frac{r_a(a^2+3a+1+r_a)}{2v^2}.
\tag{6.1}
$$

Consequently

$$
\mathcal P'(a)>\frac{a}{2(a+1)}>0.
\tag{6.2}
$$

*Proof.* Differentiate the finite core integral, remembering $v'=1$ and both moving endpoints. The integral term in its derivative is
$\int_{-a}^a y^2e^{-y^2/(2v)}dy/(2v^2)$.
Using (4.4) and
$t_a'/t_a=-a(a+2)/(2v^2)$
gives the first identity in (6.1). Logarithmically differentiating $r_a=2t_a/A_a$ gives the second.

Since $J_a>0$, $0 \lt r_a<1$. Therefore

$$
r_a(a^2+3a+1+r_a) \lt a^2+3a+2,
$$

which, substituted into $\mathcal P'=1+r_a'$, gives (6.2). Differentiation under the core integral is legitimate on every compact subinterval of $a>0$, or after the substitution $y=au$ on a fixed integration interval. $\square$

**Lemma 6.2 (endpoints and differentiable inverse).** As $a\downarrow0$, $A_a\to2$, $r_a\to1$ and $\mathcal P(a)\to0$. As $a\to\infty$, $r_a\to0$ and $\mathcal P(a)\to\infty$. The inverse $a(P)$ is continuous and continuously differentiable for $P>0$.

*Proof.* The first limits follow directly from (2.1). For large $a$, the interval $[-\sqrt v,\sqrt v]$ is contained in $[-a,a]$ and
$J_a\ge2e^{-1/2}\sqrt v$.
Meanwhile $t_a=\exp(-v/2+1-1/(2v))$ tends to zero exponentially. Hence $r_a\to0$ and $\mathcal P(a)=a-1+o(1)$. Continuity and strict monotonicity now give the full positive range and a continuous inverse; (6.2) and the inverse function theorem give its differentiability. $\square$

**Corollary 6.3 (marginal value and strict concavity).** On $P>0$,

$$
C'(P)=\frac1{2(a(P)+1)}.
\tag{6.3}
$$

The capacity is strictly increasing and strictly concave, extends continuously to $C(0)=0$, and has right derivative $C'(0+)=1/2$.

*Proof.* Differentiate the second expression in (2.5) with respect to $a$ and use (6.1). The terms containing $r_a/v^2$ cancel, leaving
$dC(\mathcal P(a))/da=\mathcal P'(a)/(2v)$.
This proves (6.3). The derivative is positive and strictly decreasing. The formula (2.5) and Lemma 6.2 give the zero limit and the right slope. Strict decrease of the derivative also proves strict concavity on any interval including zero by integration. $\square$

At $P=0$, the constraint forces $X=0$ almost surely, so the zero-budget assertions in Theorem 2.1 hold independently of the limiting argument. The measures $\mu_a$ also converge weakly to $\delta_0$ as $a\downarrow0$, since their supports shrink to zero.

For scale $b$, set $\widetilde X=X/b$ and $\widetilde Z=Z/b$. Mutual information is unchanged by the invertible scalings of input and output, and the budget becomes $P/b^2$. This proves (2.6), the optimizer scaling, and all remaining claims of Theorem 2.1. The scaled density has the additional factor $b^{-1}$; the atom locations become $\pm ba$ while their masses remain $q_a(a)/v$. In particular $C_b'(P)=1/[2b^2(a(P/b^2)+1)]$ for $P>0$.

## 7. Quantitative consequences of the certificate

**Corollary 7.1 (output and support control).** Fix $P>0$ and let $a=a(P)$. Suppose $\nu$ is feasible and has gap
$\varepsilon=C(P)-I(\nu;k)$.
Then

$$
\begin{gathered}
D(k*\nu\Vert q_a)\le\varepsilon,\qquad
P-\mathbb E_\nu X^2\le\varepsilon/\lambda_a,\\
\|k*\nu-q_a\|_{\mathrm{TV}}\le\sqrt{\varepsilon/2},\\
\nu\{|X|\ge a+d\}\le
\frac{\varepsilon}{\lambda_a\psi(d)}
\qquad(d>0).
\end{gathered}
\tag{7.1}
$$

Our total-variation convention for densities is one half of their $L^1$ distance.

*Proof.* The first two bounds follow by retaining individual nonnegative terms of (2.7). Pinsker's inequality in natural logarithms gives the total-variation bound. Monotonicity of $\psi$ implies
$\mathbb E\psi((|X|-a)_+)\ge\psi(d)\nu\{|X|\ge a+d\}$,
and (2.7) gives the last bound. $\square$

The residual has cubic contact with the boundary:

$$
\psi(s)=\frac{s^3}{3}+O(s^4)\qquad(s\downarrow0).
\tag{7.2}
$$

This is a Taylor expansion of the explicit residual. It is not a claim that a cubic exponent is optimal for every possible metric on input measures. Likewise, (7.1) controls output total variation and input mass beyond a fixed margin; it does not assert an input total-variation stability theorem.

## 8. Sharp low- and high-power behavior

### 8.1 Low power and one-sided analytic inversion

**Lemma 8.1 (local budget expansion).** As $a\downarrow0$,

$$
\mathcal P(a)=a^2-\frac43a^3+O(a^4),
\qquad
a(P)=\sqrt P+\frac23P+O(P^{3/2}).
\tag{8.1}
$$

*Proof.* Put $y=au$ in $J_a$. Near $a=0$ the integrand
$\exp[-a^2u^2/(2(1+a))]$
is real analytic jointly in $a$ and $u\in[-1,1]$ with uniform Taylor remainders. Thus

$$
\begin{aligned}
t_a&=1-\frac12a^2+\frac12a^3+O(a^4),\\
J_a&=2a-\frac13a^3+O(a^4),\\
A_a&=2+2a-a^2+\frac23a^3+O(a^4).
\end{aligned}
\tag{8.2}
$$

Division gives
$r_a=1-a+a^2-\frac43a^3+O(a^4)$,
and hence the first assertion. In a neighborhood of zero, $\mathcal P(a)=a^2F(a)$ with analytic $F$ and $F(0)=1$. The positive analytic square root of $F$ makes
$s=a\sqrt{F(a)}$
an analytic function with derivative one at zero. Its local analytic inverse, restricted to $s=\sqrt P\ge0$, gives
$a=s+\frac23s^2+O(s^3)$.
This proves the second assertion with controlled one-sided remainders. $\square$

By (6.3) and (8.1),

$$
C'(P)=\frac12-\frac12\sqrt P+\frac16P+O(P^{3/2}).
$$

Integrating from zero proves (2.8). This also explains why the exact loss coefficient is $1/3$ while the relaxed bound (1.2) exposes only $1/6$. The result refines a known fractional-order bound; it does not originate that exponent.

### 8.2 The Gaussian entropy gap

**Lemma 8.2 (a tail identity with a controlled remainder).** For $v=a+1>1$, define

$$
B(v)=\int_0^\infty e^{-s}
\left\{\exp\left(\frac{s-s^2/2}{v}\right)-1\right\}ds.
\tag{8.3}
$$

Then $B(v)>0$ and

$$
\sqrt{2\pi v}=A_a(1+r_aB(v)).
\tag{8.4}
$$

Furthermore

$$
B(v)=v^{-2}-5v^{-3}+O(v^{-4}).
\tag{8.5}
$$

One valid explicit bound for the absolute remainder in (8.5) is
$36e^{1/2}v^{-4}$ for $v\ge1$.

*Proof.* In the omitted Gaussian tail substitute $y=a+s$ and use $a=v-1$. This gives

$$
\int_a^\infty e^{-y^2/(2v)}dy
=t_a\int_0^\infty e^{-s}
\exp\left(\frac{s-s^2/2}{v}\right)ds.
$$

The full Gaussian integral is therefore
$J_a+2t_a(1+B)=A_a+2t_aB$,
proving (8.4).

For $S$ with density $e^{-s}$ on $s\ge0$, put $W=S-S^2/2$. Then $\mathbb EW=0$, $W$ is not constant, and $e^{W/v}$ is integrable because $W\le1/2$. Strict Jensen yields $B(v)>0$. Direct factorial moments give

$$
\mathbb EW^2=2,\qquad
\mathbb EW^3=-30,\qquad
\mathbb EW^4=864.
\tag{8.6}
$$

For example,
$\mathbb EW^4=4!-2(5!)+\tfrac32(6!)-\tfrac12(7!)+\tfrac1{16}(8!)=864$.
Taylor's theorem gives, for $v\ge1$,

$$
\left|e^{W/v}-1-\frac Wv-\frac{W^2}{2v^2}
-\frac{W^3}{6v^3}\right|
\le\frac{e^{1/2}|W|^4}{24v^4}.
$$

Taking expectations proves (8.5) and its remainder bound. The tail cancellation $\mathbb EW=0$ is essential. $\square$

**Lemma 8.3 (exact entropy-gap formula).** Let $P=\mathcal P(a)$, $v=a+1$ and $r=r_a$. Then

$$
U(P)-C(P)=
\log(1+rB(v))
+\frac12\log(1+r/v)-\frac{r}{2v}.
\tag{8.7}
$$

The left side is strictly positive.

*Proof.* By (4.3), $q_a$ is centered and has variance $P+2=v+r$. The Gaussian entropy identity gives

$$
U(P)-C(P)=D(q_a\Vert \phi_{P+2}),
\tag{8.8}
$$

where $\phi_{P+2}$ is the centered Gaussian density of variance $P+2$. All integrals are finite by the exponential tails. Equality in (8.8) would make $q_a$ Gaussian, which is impossible because its log density is affine, rather than quadratic, on each unbounded tail. Substituting (8.4) into (2.5) and using $P+2=v+r$ gives (8.7). At $P=0$ strict positivity holds directly for the Laplace noise density, giving $U(0)-C(0)=\frac12\log(\pi/e)>0$. $\square$

*Proof of the high-power claim (2.10).* We already know $r\to0$ and $v/P\to1$. Rewriting the exponential in $t_a$, using $v=P+2-r$, yields

$$
r=\sqrt{\frac2\pi}\,v^{-1/2}
e^{-P/2+r/2-1/(2v)}(1+rB(v)).
\tag{8.9}
$$

Consequently
$r\sim\sqrt{2/\pi}\,e^{-P/2}P^{-1/2}$.
In (8.7), the linear terms $r/(2v)$ cancel. The elementary logarithm expansion and (8.5) give

$$
U(P)-C(P)
=rB(v)+O(r^2B(v)^2+r^2/v^2)
\sim r/v^2.
$$

Combining this with (8.9) proves (2.10). The displayed error divided by $r/v^2$ tends to zero because $B(v)=O(v^{-2})$ and $r\to0$; thus the exponentially small difference is controlled analytically rather than inferred by subtracting two rounded numbers. This completes Theorem 2.3. $\square$

## 9. Independent parallel channels

The following application supplies an exact scalar level response in a familiar allocation problem. The separability principle itself is not new.

**Theorem 9.1 (weighted allocation and joint uniqueness).** Let $m$ be a positive integer, $B\ge0$, $b_j>0$, $w_j>0$, and let the noises $Z_j$ be mutually independent scale-$b_j$ centered Laplace variables, independent of an arbitrary joint Borel input vector $X\in\mathbb R^m$. Under

$$
\sum_{j=1}^m w_j\mathbb EX_j^2\le B,
\tag{9.1}
$$

the information capacity equals

$$
\max_{\substack{p_j\ge0\\\sum_j w_jp_j\le B}}
\sum_{j=1}^m C(p_j/b_j^2).
\tag{9.2}
$$

Extend $\mathcal P(0)=0$. If $B>0$, there is a unique
$\eta\in(0,\max_j(2w_jb_j^2)^{-1})$
such that

$$
\begin{gathered}
a_j(\eta)=\left(\frac1{2\eta w_jb_j^2}-1\right)_+,\qquad
p_j(\eta)=b_j^2\mathcal P(a_j(\eta)),\\
\sum_jw_jp_j(\eta)=B.
\end{gathered}
\tag{9.3}
$$

These are the unique optimal powers. The unique optimal joint input is the independent product of the scaled scalar optimizers, using $\delta_0$ on inactive coordinates. At $B=0$ it is the point mass at the zero vector.

*Proof.* Set $p_j=\mathbb EX_j^2$. Finite weighted second moments imply finite second moments in every coordinate. The joint output density is bounded above by $\prod_j(2b_j)^{-1}$. Integrating the input over a sufficiently large box of positive probability gives a positive lower bound of the form $c\exp(-\sum_j|y_j|/b_j)$. Thus its entropy and the marginal entropies are finite by the same argument as Lemma 3.1. The total-correlation identity is legitimate and gives

$$
I(X;X+Z)=\sum_j I(X_j;X_j+Z_j)
-D\left(p_Y\middle\Vert\prod_jp_{Y_j}\right)
\le\sum_jC(p_j/b_j^2).
\tag{9.4}
$$

For any feasible power vector, independent scalar optimizers attain the right side. This proves (9.2).

The feasible power simplex is compact, and its objective is continuous and strictly concave. It is strictly increasing in each coordinate, so at $B>0$ the optimum uses the entire budget and is unique. By (6.3) the derivative with respect to $p_j$ is

$$
\frac1{2b_j^2(a(p_j/b_j^2)+1)}
$$

at positive power, with right derivative $1/(2b_j^2)$ at zero. Matching this derivative to $\eta w_j$ on active coordinates, and requiring it to be no greater than $\eta w_j$ at inactive coordinates, gives (9.3). Conversely these derivative conditions imply global optimality by concavity, so they are sufficient.

The left side of the final equation in (9.3) is continuous in $\eta$. It tends to infinity as $\eta\downarrow0$, is zero at the stated upper endpoint, and is strictly decreasing below that endpoint because at least one coordinate is active. This proves existence and uniqueness of $\eta$, including all activation thresholds.

For any joint optimum, all inequalities in (9.4) must be equalities. Strict concavity fixes the powers, scalar uniqueness fixes each input marginal, and the vanishing total correlation makes the output coordinates independent. The joint noise characteristic function
$\prod_j(1+b_j^2u_j^2)^{-1}$
is everywhere nonzero. Dividing the joint output characteristic function by it forces the input characteristic function to be the product of its marginals, proving joint independence and uniqueness. The zero-budget case follows directly from (9.1). $\square$

## 10. Reproducibility and scope

The proofs above are analytic. Accompanying Python checks independently integrate the continuous input and endpoint masses, convolve them with the noise, and compare the resulting density and potential with (2.2) and (5.1). Finite symmetric and asymmetric competitor laws test every term of (2.7), including a positive noncontact residual. Exact rational series arithmetic checks the local coefficients and factorial moments. High-precision tail calculations check the severe cancellation in (8.7).

These finite computations are diagnostics. They do not prove optimality over all Borel measures, a global inequality, or an asymptotic remainder. The numerical integration uses high-precision floating arithmetic rather than directed interval rounding. The theoretical conclusions come from the displayed proofs, especially (2.7), (6.2), and the integrable Taylor remainder in Lemma 8.2.

This paper does not treat a simultaneous amplitude constraint, other cost functions, a general generalized-Gaussian noise family, correlated noise coordinates, feedback, or exact reliability functions. The finite parallel theorem assumes independent noises and a separable weighted second-moment budget. The output-stability consequence must not be reinterpreted as input total-variation control. The finite literature-access limitations stated in Section 1 remain material to priority assessment. No Lean source or kernel validation is part of this manuscript's present verification status.

## References

**[V02]** S. Verdú. *Spectral Efficiency in the Wideband Regime*. IEEE Transactions on Information Theory **48**(6), 1319–1343 (2002). [DOI: 10.1109/TIT.2002.1003824](https://doi.org/10.1109/TIT.2002.1003824). [Primary published text](https://web.mit.edu/6.441/www/reading/verdu_wideband.pdf).

**[FA18]** J. Fahs and I. Abou-Faycal. *On Properties of the Support of Capacity-Achieving Distributions for Additive Noise Channel Models With Input Cost Constraints*. IEEE Transactions on Information Theory **64**(2), 1178–1198 (2018). [DOI: 10.1109/TIT.2017.2771815](https://doi.org/10.1109/TIT.2017.2771815). [Primary published text](https://scholarworks.aub.edu.lb/server/api/core/bitstreams/6e8d1eae-fa8e-4249-8c53-7207808c5c8f/content).

**[DBPS17]** A. Dytso, R. Bustin, H. V. Poor and S. Shamai (Shitz). *On Additive Channels with Generalized Gaussian Noise*. IEEE International Symposium on Information Theory, 426–430 (2017). [DOI: 10.1109/ISIT.2017.8006563](https://doi.org/10.1109/ISIT.2017.8006563). [Author manuscript](https://shamai.net.technion.ac.il/files/2017/04/dbs-ISIT2017.pdf).

**[FAA12]** J. Fahs, N. Ajeeb and I. Abou-Faycal. *The Capacity of Average Power Constrained Additive Non-Gaussian Noise Channels*. 19th International Conference on Telecommunications (2012). [DOI: 10.1109/ICTEL.2012.6221320](https://doi.org/10.1109/ICTEL.2012.6221320). Author-uploaded full text inspected for its analyticity conditions.

**[TS26]** S. Tridenski and A. Somekh-Baruch. *The Shannon Upper Bound for the Error Exponent*. IEEE Transactions on Information Theory **72**(6), 3539–3555 (2026). [DOI: 10.1109/TIT.2026.3683949](https://doi.org/10.1109/TIT.2026.3683949). Technical version inspected: [arXiv:2509.08425v1](https://arxiv.org/html/2509.08425v1).

**[D00]** A. Das. *Capacity-achieving distributions for non-Gaussian additive noise channels*. IEEE International Symposium on Information Theory, p. 432 (2000). [DOI: 10.1109/ISIT.2000.866730](https://doi.org/10.1109/ISIT.2000.866730). Primary full text not obtained.

**[NT22]** P. Narayanan and L. N. Theagarajan. *Capacity of Peak and Average Power Constrained Additive Generalized Gaussian Noise Channels*. IEEE Communications Letters **26**(12), 2880–2883 (2022). [DOI: 10.1109/LCOMM.2022.3208888](https://doi.org/10.1109/LCOMM.2022.3208888). Metadata and author abstract screened; primary full text not obtained.
