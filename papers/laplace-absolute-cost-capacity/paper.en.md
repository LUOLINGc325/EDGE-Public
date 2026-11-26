# Exact Capacity of the Laplace Channel under an Absolute Input Cost

# Abstract

We determine the information capacity of the real additive Laplace-noise channel under an expected absolute input constraint, for every nonnegative budget. For each positive budget the unique maximizing input has an atom at zero, two symmetric nonzero atoms, and two exponential continuous tails, with no mass in the two intervening open intervals. Two scalar contact equations determine this law. We prove existence and uniqueness of their admissible solution for every penalty parameter, continuity of that solution, and a strictly decreasing bijection between penalty and positive budget. A global cross-entropy certificate proves optimality against arbitrary Borel inputs, including nonsymmetric competitors, and gives an exact relative-entropy and slack decomposition of the capacity deficit. The resulting parametric formula is exact and does not rely on numerical evidence. We also give a separate, cost-preserving perturbation showing that the previously proposed atom-plus-full-Laplace input is strictly suboptimal at every positive budget. Its self-deconvolution identity remains correct. Numerical examples illustrate the theorem; they are not certified interval computations. Formal proof code is a separate, still outstanding deliverable.

# Introduction and scope

The optimization problem studied here is deliberately specific: one real memoryless additive channel, Laplace noise, one expected first absolute moment constraint, and no peak restriction. The information capacity is the single-letter supremum of mutual information over Borel input laws. We do not prove a new channel coding theorem, treat other generalized-Gaussian shapes, introduce feedback, or determine reliability functions.

The difficulty is the interaction of a nonsmooth noise density, an unbounded input space, and a cost with the same linear growth as the negative log noise density. General support-growth criteria distinguish costs growing strictly faster or strictly slower than the noise-tail rate; they do not identify the optimizer in this equal-order case [3, Theorem 7]. Standard variational conditions [3, Eq. (21)] motivate the construction, but a stationary candidate is insufficient: a global inequality, positive input masses, and coverage of all budgets are required.

There is a concrete reason to revisit the model. Dytso, Bustin, Poor, and Shamai [1, Proposition 8] assert optimality of an atom at zero mixed with a full Laplace density under the first absolute moment constraint. Their generalized-Gaussian convention gives noise scale two when the shape is one; division of input and output by two gives precisely the scale-one model below. The deconvolution identity is valid. Section 9 identifies the distinct failure of its optimality inference. The later distributional paper [2, Section 6.2, Eqs. (58)–(60)] repeats the inference from self-decomposability to capacity-bound achievability. The 2026 uniform-noise study [4, Section VII, p. 4575] still lists the atom-plus-Laplace law as the linear-cost Laplace exception. This manuscript corrects that particular assertion, not those papers' other results.

The explicit open directions in [4, preprint Section III-C; journal Section VII] concern broader nonanalytic noise families and softened or absent peak constraints. Our contribution is an exact solution of one bounded scalar slice, not a solution of that whole program. The correction and literature search support the inference that a valid all-budget solution of this precise slice was missing in the screened sources; the cited authors did not themselves label this exact corrected statement an open problem.

The principal contribution is the all-budget optimizer and capacity, together with a closed existence, uniqueness, and global-optimality proof. The three atoms are all necessary and strictly positive. In particular, removing the two nonzero atoms or filling the two gaps does not give the optimal law. The proof converts Laplace convolution into the Green equation for the operator $1-\partial^2$, proves a one-crossing sign property for a scalar forcing term, and matches the resulting potential at both ends of the gap. Uniqueness follows from the global certificate before it is used to establish continuous parameter dependence, so the argument does not assume an invertible root Jacobian.

The nearest comparisons and their limits are as follows.

| Work | Established scope | Relation to this manuscript |
|:---|:---|:---|
| Dytso et al. [1,2] | Generalized-Gaussian identities and capacity bounds; Laplace deconvolution | The identity is retained; the stated linear-input-cost optimum is replaced by a full exact solution. |
| Fahs–Abou-Faycal [3] | General support criteria and necessary/sufficient variational conditions | We use the classical certificate principle and resolve one critical-growth model constructively. |
| Stapmanns et al. [4] | Uniform noise, a peak interval, a family of costs, and changes in support structure | This is a methodological and contribution-scale comparison, not a special case covered by our theorem. Their cost family is broader. |
| Tridenski–Somekh-Baruch [5] | Error-exponent bounds; a capacity upper bound for this Laplace model | We determine the exact single-letter capacity and its input law, not the error exponent. The technical version read was the preprint. |
| Narayanan–Theagarajan [6] | The verified abstract reports peak/average constrained bounds and a peak-limit asymptotic analysis | Full text was unavailable. We do not infer the exact cost exponent or claim theorem-by-theorem exclusion from the title. |
| Verdú [7] | General capacity-per-unit-cost theory | The low-cost slope recovered in Section 10 is known background, not an independent novelty claim. |

The literature comparison is limited to the cited sources and versions accessed on 25 November 2026. In particular, the abstract-only access to [6] prevents an exhaustive priority assertion. Mathematical validity of the theorem and historical priority are separate claims. External peer review is not claimed.

# 1. Model and main theorem

Let

```math
k(x)=\tfrac12 e^{-|x|},\qquad Y=X+Z,\qquad Z\sim k,
```

with independent signal and noise. All logarithms are natural. The constraint is
$\mathbb E|X|\le P$, with $P\ge0$. Write

```math
C(P)=\sup_{\mathbb E|X|\le P}\{h(X+Z)-\log(2e)\}.
```

For every $\lambda\in(0,1)$, there is a unique pair $(a,d)$ with

```math
a>0,\qquad -\lambda \lt d<\tanh a,
```

satisfying the two scalar integral equations

```math
\begin{aligned}
u_{\lambda,d}(s)&=\lambda s-\log(\cosh s-d\sinh s),\\
R_{\lambda,d}(h)&=\int_0^h\sinh(h-s)u_{\lambda,d}(s)\,ds,\\
R_{\lambda,d}(a)&=0,\qquad
R'_{\lambda,d}(a)=-\lambda. \tag{1}
\end{aligned}
```

Set

```math
c=\operatorname{arctanh}d,\qquad b=a-c>0,
\qquad
D=\frac1{2(\sinh b+\sinh c+\cosh c/\lambda)}. \tag{2}
```

Then the unique maximizer of the penalized entropy
$h(X+Z)-\lambda\mathbb E|X|$ has output density

```math
q_\lambda(y)=
\begin{cases}
D\cosh(|y|-b),& |y|\le a,\\
D\cosh c\,e^{-\lambda(|y|-a)},& |y|\ge a.
\end{cases} \tag{3}
```

Its input is the probability measure

```math
\begin{aligned}
\mu_\lambda(dx)
={}&2D\sinh b\,\delta_0(dx)\\
&+D(\lambda\cosh c+\sinh c)
       [\delta_{-a}(dx)+\delta_a(dx)]\\
&+(1-\lambda^2)D\cosh c\,
  e^{-\lambda(|x|-a)}\mathbf1\{|x|>a\}\,dx. \tag{4}
\end{aligned}
```

All three atomic masses and the density on each open tail are strictly positive.
The two gaps $(-a,0)$ and $(0,a)$ contain no input mass.

Its mean absolute input is

```math
\begin{aligned}
P_\lambda
&=2D\left[
a\left(\sinh c+\frac{\cosh c}{\lambda}\right)
 +\frac{1-\lambda^2}{\lambda^2}\cosh c
\right]. \tag{5}
\end{aligned}
```

The map $\lambda\mapsto P_\lambda$ is continuous and strictly decreasing,
with limits $\infty$ at $0$ and $0$ at $1$. Hence it parametrizes every
positive constraint value exactly once. For its inverse parameter,

```math
C(P_\lambda)
=-\log(2eD\cosh c)+\lambda(P_\lambda-a). \tag{6}
```

At $P=0$, the unique input is $\delta_0$, and $C(0)=0$.

# 2. Existence of the contact parameters

Throughout this section fix $0<\lambda<1$.

## Lemma 1: a unique first contact equation for each gap length

For every $a>0$, the equation $R_{\lambda,d}(a)=0$ has exactly one solution

```math
d=d_\lambda(a)\in(-\lambda,\tanh a).
```

This solution is continuous in $(\lambda,a)$ on
$(0,1)\times(0,\infty)$.

**Proof.** For $-1 \lt d<1$, the function inside the logarithm is strictly positive.
Differentiating in $d$,

```math
\partial_d u_{\lambda,d}(s)
=\frac{\sinh s}{\cosh s-d\sinh s}>0\quad(s>0).
```

Therefore $R_{\lambda,d}(a)$ is continuous and strictly increasing in $d$.
At $d=-\lambda$,

```math
\frac{d}{ds}\log(\cosh s+\lambda\sinh s)
=\frac{\tanh s+\lambda}{1+\lambda\tanh s}>\lambda
\quad(s>0),
```

so $u_{\lambda,-\lambda}(s)<0$ for $s>0$, and
$R_{\lambda,-\lambda}(a)<0$. At $d=\tanh a$,

```math
\cosh s-\tanh a\sinh s
=\frac{\cosh(a-s)}{\cosh a}<1\quad(0 \lt s\le a),
```

so $u_{\lambda,\tanh a}(s)>0$ there and
$R_{\lambda,\tanh a}(a)>0$. The intermediate value theorem and strict
monotonicity give the claim. Continuity follows locally from
$\partial_dR_{\lambda,d}(a)>0$, or directly from continuity, the strict
endpoint signs, and uniqueness. ∎

Define

```math
T_\lambda(a):=R'_{\lambda,d_\lambda(a)}(a).
```

The prime in this definition differentiates $R_{\lambda,d}(h)$ with respect to
its argument $h$, **with $d$ held fixed**, and is then evaluated at
$h=a,d=d_\lambda(a)$. It is not the total derivative of the identically zero
quantity $R_{\lambda,d_\lambda(a)}(a)$.

## Lemma 2: endpoint behavior of the remaining contact equation

The function $T_\lambda$ is continuous,

```math
\lim_{a\downarrow0}T_\lambda(a)=0,
\qquad
\lim_{a\to\infty}T_\lambda(a)=-\infty. \tag{7}
```

Consequently it takes the value $-\lambda$ for some $a>0$.

**Proof.** Continuity follows from Lemma 1 and the integral expression for
$R'$. For small $a$, the interval
$-\lambda \lt d_\lambda(a)<\tanh a$ stays in a compact subset of $(-1,1)$.
Since $u(0)=0$ and its derivative is bounded on this compact set,
$|u(s)|\le K s$ for $0\le s\le a$, so
$|T_\lambda(a)|\le K' a^2\to0$.

For the large-$a$ limit, first obtain a uniform bound away from $d=1$.
For a fixed $d<1$, set

```math
J_\lambda(d)=\int_0^\infty e^{-s}u_{\lambda,d}(s)\,ds.
```

The integral is finite. The integrands increase with $d$. As $d\uparrow1$,
they tend to $(\lambda+1)s$, because
$\cosh s-\sinh s=e^{-s}$. Applying monotone convergence to
$u_{\lambda,d}-u_{\lambda,-\lambda}$ shows

```math
\lim_{d\uparrow1}J_\lambda(d)=\lambda+1>0.
```

Choose one $d_*<1$ with $J_\lambda(d_*)>0$. At this fixed value,

```math
e^{-a}R_{\lambda,d_*}(a)
=\frac12\int_0^a e^{-s}u_{\lambda,d_*}(s)\,ds
-\frac12e^{-2a}\int_0^a e^su_{\lambda,d_*}(s)\,ds
\longrightarrow\tfrac12J_\lambda(d_*)>0.
```

The second term tends to zero since $u_{\lambda,d_*}(s)=O(1+s)$.
Thus, by the monotonicity in Lemma 1,

```math
-\lambda \lt d_\lambda(a) \lt d_*<1
\quad\text{for all sufficiently large }a. \tag{8}
```

Uniformly on this compact interval of $d$-values,

```math
\begin{aligned}
u_{\lambda,d}(s)
&=(\lambda-1)s+A(d)+\varepsilon_d(s),\\
A(d)&=\log\frac2{1-d},\\
\varepsilon_d(s)&=-\log\left(1+
       \frac{1+d}{1-d}e^{-2s}\right),
\qquad |\varepsilon_d(s)|\le K e^{-2s}. \tag{9}
\end{aligned}
```

Since $R_{\lambda,d_\lambda(a)}(a)=0$, the identity
$\cosh t-\sinh t=e^{-t}$ gives the useful cancellation

```math
T_\lambda(a)=\int_0^a e^{-(a-s)}u_{\lambda,d_\lambda(a)}(s)\,ds.
```

Substituting (9),

```math
\begin{aligned}
T_\lambda(a)
={}&(\lambda-1)(a-1+e^{-a})
 +A(d_\lambda(a))(1-e^{-a})+O(e^{-a})\\
={}&-(1-\lambda)a+O(1)\longrightarrow-\infty.
\end{aligned}
```

The intermediate value theorem now yields $T_\lambda(a)=-\lambda$.
This proves existence in (1), without asserting uniqueness yet. ∎

# 3. Strict sign of the slack on the empty input interval

## Lemma 3: positivity before the first contact

For any solution $(a,d)$ of (1),

```math
R_{\lambda,d}(h)>0\qquad(0 \lt h \lt a). \tag{10}
```

**Proof.** The function $u=u_{\lambda,d}$ satisfies

```math
u(0)=0,\qquad u'(0)=\lambda+d>0,
\qquad
u''(s)=-\frac{1-d^2}{(\cosh s-d\sinh s)^2}<0.
```

Thus $u$ is strictly concave. The equation
$\int_0^a\sinh(a-s)u(s)\,ds=0$ forces $u(a)<0$. Therefore there is a
unique $s_0\in(0,a)$ at which $u$ changes sign from positive to negative.
In particular $R(h)>0$ for $0 \lt h\le s_0$.

If $R$ had a first zero $h_0\in(s_0,a)$, then
$R'(h_0)\le0$. Its differential equation
$R''-R=u$ would imply, for every $h\in(h_0,a]$,

```math
R(h)=R'(h_0)\sinh(h-h_0)
    +\int_{h_0}^h\sinh(h-s)u(s)\,ds<0,
```

contradicting $R(a)=0$. Hence (10) holds. ∎

# 4. Feasibility of the proposed input and output

For a solution of (1), put $K=D\cosh c$. An equivalent output expression is

```math
q(y)=K
\begin{cases}
\cosh(a-|y|)-d\sinh(a-|y|),&|y|\le a,\\
e^{-\lambda(|y|-a)},&|y|\ge a,
\end{cases}
```

where

```math
K^{-1}=2\left[\sinh a-d(\cosh a-1)+\lambda^{-1}\right]. \tag{11}
```

The function is strictly positive and integrates to one. In the sense of
distributions, its image under $1-\partial_y^2$ is

```math
\begin{aligned}
\mu(dx)
={}&2K(\sinh a-d\cosh a)\delta_0(dx)\\
&+K(d+\lambda)[\delta_{-a}(dx)+\delta_a(dx)]\\
&+(1-\lambda^2)K e^{-\lambda(|x|-a)}
      \mathbf1\{|x|>a\}\,dx. \tag{12}
\end{aligned}
```

The two strict inequalities in Lemma 1 give strict positivity of every atomic
mass in (12). The continuous part is positive because $\lambda<1$. Its total
mass is

```math
2K\left[\sinh a-d(\cosh a-1)+\lambda^{-1}\right]=1.
```

Thus $\mu$ is a probability measure with finite first absolute moment.
Since $(1-\partial^2)k=\delta_0$, and the homogeneous equation has no nonzero
integrable solution on the whole line, $q=k*\mu$. Equivalently, taking Fourier
transforms gives $(1+\xi^2)\widehat q(\xi)=\widehat\mu(\xi)$, proving the same
identity. Formula (12) becomes (4) under (2).

Direct integration gives

```math
P_\lambda=2K\left[a(d+\lambda^{-1})+\lambda^{-2}-1\right], \tag{13}
```

which is (5). These formulas establish feasibility without appealing to a
numerical solution or to a separate existence theorem for capacity maximizers.

# 5. A global entropy certificate

Set

```math
\kappa=-\log K-\lambda a,
\qquad
r(x)=
\begin{cases}
R_{\lambda,d}(a-|x|),&|x|\le a,\\
0,&|x|\ge a,
\end{cases}
```

and define

```math
G(x)=\kappa+\lambda|x|-r(x). \tag{14}
```

Although the two terms $\lambda|x|$ and $r(x)$ each have a corner at zero,
their derivative jumps cancel: from (1),

```math
r(0)=0,\qquad r'(0+)=\lambda.
```

At $x=a$, we have $r(a)=r'(a-)=0$. Hence $G$ is continuously
differentiable on the whole line, including $0,\pm a$.

For $0 \lt x \lt a$, with $s=a-x$,

```math
-\log q(x)-(\kappa+\lambda x)=u_{\lambda,d}(s),
\qquad r''(x)-r(x)=u_{\lambda,d}(s).
```

For $|x|\ge a$, $-\log q(x)=\kappa+\lambda|x|$. The derivative matching
therefore proves globally, in the sense of distributions,

```math
(1-\partial_x^2)G=-\log q.
```

Both $G$ and $k*(-\log q)$ grow at most linearly. Their difference solves
the homogeneous equation and must be zero: every classical or distributional
solution of $w''=w$ is $A e^x+B e^{-x}$, and no nonzero such function has
at most linear growth at both ends. Consequently

```math
G(x)=-\int_{\mathbb R}k(y-x)\log q(y)\,dy. \tag{15}
```

Lemma 3 now proves the exact global certificate

```math
G(x)\le\kappa+\lambda|x|\quad\text{for every }x\in\mathbb R, \tag{16}
```

with equality exactly on

```math
\{0\}\cup(-\infty,-a]\cup[a,\infty).
```

In particular equality holds on all of the support of $\mu$.

## Lemma 4: global optimality and uniqueness

The measure $\mu$ uniquely maximizes
$h(k*\nu)-\lambda\int|x|\nu(dx)$ over all probability measures $\nu$ with
finite first absolute moment.

**Proof.** Write $q_\nu=k*\nu$. First justify entropy finiteness without presupposing an entropy difference. The convolution density satisfies $0 \lt q_\nu\le1/2$, so $-q_\nu\log q_\nu\ge0$. Put $M=\int|x|\nu(dx)$, $B=1+M$, and $g_B(y)=(2B)^{-1}e^{-|y|/B}$. The pointwise inequality $t\log t\ge t-1$ gives

```math
-q_\nu\log q_\nu\le -q_\nu\log g_B-q_\nu+g_B.
```

The right side is integrable, since $\mathbb E_\nu|X+Z|\le B$. Integrating proves that the nonnegative entropy integral is finite and at most $\log(2eB)$. Taking the comparison scale to be $\mathbb E_\nu|X+Z|>0$ gives the usual sharper maximum-entropy statement. In particular,

```math
h(q_\nu)\le\log\left(2e\,\mathbb E_\nu|X+Z|\right)
\le\log\left(2e\left[1+\mathbb E_\nu|X|\right]\right).
```

The cross-entropy with $q$ is finite as well, since $-\log q$ is bounded
below and has at most linear growth. Gibbs' inequality, Fubini's theorem, and
(15)--(16) give

```math
\begin{aligned}
h(q_\nu)
&\le -\int q_\nu(y)\log q(y)\,dy\\
&=\int G(x)\,\nu(dx)\\
&\le\kappa+\lambda\int|x|\,\nu(dx). \tag{17}
\end{aligned}
```

For $\nu=\mu$, equality holds throughout, so

```math
h(q)=\kappa+\lambda P_\lambda. \tag{18}
```

Equality in the first line of (17) is possible only if $q_\nu=q$ almost
everywhere. Laplace convolution is injective on probability measures because
$\widehat k(\xi)=(1+\xi^2)^{-1}$ never vanishes. Thus equality forces
$\nu=\mu$. ∎

This also proves uniqueness of the contact pair in (1). Every solution gives a
maximizer in Lemma 4, so all solutions yield the same input measure. The open
tail carrying a strictly positive density starts exactly at $a$, identifying
$a$; then the output formula identifies $d$. No nonvanishing Jacobian or
unproved numerical monotonicity of the two contact equations is needed.

For any input with cost at most $P_\lambda$, (17) and (18) show that its output
entropy is at most $h(q)$. Therefore (6) follows. This conclusion does not
presume that the input is symmetric; the certificate holds for every real
$x$, and hence for arbitrary, possibly nonsymmetric competitors.

## Exact performance-gap identity

The same calculation retains an exact identity, not merely an upper bound.
For any finite-cost competitor $\nu$, write $P_\nu=\int|x|\nu(dx)$. Then

```math
h(q)-h(q_\nu)
=D_{\mathrm{KL}}(q_\nu\Vert q)
 +\lambda(P_\lambda-P_\nu)+\int r(x)\nu(dx). \tag{18a}
```

Indeed, the definition of relative entropy and (15) give
$h(q_\nu)=\kappa+\lambda P_\nu-\int r\,d\nu
 -D_{\mathrm{KL}}(q_\nu\Vert q)$, and (18) completes the calculation.
All terms are finite under the assumptions already checked.

In particular, at the same cost, any input placing positive mass in either
open gap has strictly smaller mutual information. This applies to the candidate
$\beta^{-2}\delta_0+(1-\beta^{-2})\operatorname{Laplace}(\beta)$, for every
$\beta>1$: its cost is $\beta-\beta^{-1}$, and its positive continuous density
charges both gaps. Its output is $\operatorname{Laplace}(\beta)$, giving
mutual information $\log\beta$. With the normalization of [1] checked as in the introduction, (18a) yields the strict comparison

```math
C(\beta-\beta^{-1})>\log\beta\qquad(\beta>1). \tag{18b}
```

This conclusion uses the analytic slack sign and does not depend on numerical
capacity evaluation or on a merely necessary stationarity condition.

# 6. Uniform compactness and continuity of the contact parameters

This step is needed to justify that no positive constraint values are missed.

## Lemma 5: local uniform bounds on all contact roots

Fix $0<\epsilon<1/2$. All contact roots with
$\lambda\in[\epsilon,1-\epsilon]$ lie in a compact subset of
$(0,\infty)\times(-1,1)$ in their $(a,d)$-coordinates.

**Proof.** The small-$a$ bound in Lemma 2 can be made uniform over this
$\lambda$-interval: for $0 \lt a\le1$,

```math
-(1-\epsilon)\le d_\lambda(a)\le\tanh1<1,
```

and $u'$ is uniformly bounded for $s\in[0,1]$. Thus
$|T_\lambda(a)|\le K_\epsilon a^2$. At a contact root
$|T_\lambda(a)|=\lambda\ge\epsilon$, so $a$ has a positive lower bound.

For the upper bound, choose $d_*<1$ such that
$J_\epsilon(d_*)>0$, as in Lemma 2. Since $u_{\lambda,d_*}$ increases with
$\lambda$, the normalized integral
$e^{-a}R_{\lambda,d_*}(a)$ is uniformly positive for all sufficiently large
$a$ and all $\lambda\in[\epsilon,1-\epsilon]$. One can also see this directly
from its displayed expression in Lemma 2: its limit is at least
$J_\epsilon(d_*)/2>0$, with a uniform $O(ae^{-a})$ remainder.
Consequently all such $d_\lambda(a)$ satisfy

```math
-(1-\epsilon)\le d_\lambda(a)\le d_*<1
```

for sufficiently large $a$. Expansion (9) is now uniform in both $d$ and
$\lambda$, giving

```math
T_\lambda(a)\le-\epsilon a+K_\epsilon.
```

The equality $T_\lambda(a)=-\lambda\ge-1$ therefore imposes a uniform upper
bound on $a$. Together with
$-\lambda \lt d<\tanh a$, these bounds give a compact subset of the required
open parameter domain. ∎

## Lemma 6: continuity

The unique root $(a_\lambda,d_\lambda)$ and the quantities $b,c,D,P_\lambda$
are continuous functions of $\lambda\in(0,1)$.

**Proof.** Let $\lambda_n\to\lambda_0\in(0,1)$. Lemma 5 puts the corresponding
roots in one compact set. Every convergent subsequence has a limit solving the
two equations in (1), by continuity of the integrals. The strict endpoint signs
in Lemma 1 rule out $d=-\lambda_0$ or $d=\tanh a$ for a limiting solution.
The root uniqueness already proved then identifies its limit as the root at
$\lambda_0$. Every subsequence has this same limit, so the full sequence
converges. The asserted derived-parameter continuity follows from (2), (5), and
(11). ∎

# 7. Strict monotonicity and endpoint limits of the cost

## Lemma 7: strict monotonicity

If $0<\lambda_1<\lambda_2<1$, then $P_{\lambda_1}>P_{\lambda_2}$.

**Proof.** The two optimizing output densities differ, because their positive
tails have distinct exponential decay rates $\lambda_1$ and $\lambda_2$.
The uniqueness in Lemma 4 therefore gives the strict inequalities

```math
\begin{aligned}
h(q_1)-\lambda_1 P_1&>h(q_2)-\lambda_1P_2,\\
h(q_2)-\lambda_2 P_2&>h(q_1)-\lambda_2P_1.
\end{aligned}
```

Adding them yields
$(\lambda_2-\lambda_1)(P_1-P_2)>0$. ∎

## Lemma 8: endpoint limits

```math
\lim_{\lambda\uparrow1}P_\lambda=0,
\qquad
\lim_{\lambda\downarrow0}P_\lambda=\infty.
```

**Proof.** Optimality against the zero input gives

```math
h(q_\lambda)-\lambda P_\lambda\ge h(k),
\qquad
\lambda P_\lambda\le I_\lambda.
```

The absolute-moment maximum-entropy bound and triangle inequality give
$I_\lambda\le\log(1+P_\lambda)$. Hence

```math
\lambda\le\frac{\log(1+P_\lambda)}{P_\lambda}. \tag{19}
```

The ratio on the right is strictly below one at each positive argument and is
strictly decreasing. If $P_\lambda$ stayed above some $p_0>0$ while
$\lambda\uparrow1$, (19) would give
$\lambda\le\log(1+p_0)/p_0<1$, a contradiction. This proves the first limit.

For the second, take a comparison input $X$ with the Laplace distribution of
scale $1/\lambda$, so that
$\mathbb E|X|=1/\lambda$ and $h(X)=\log(2e/\lambda)$. Addition of independent
noise cannot decrease differential entropy here: the density of $X+Z$ is a
mixture of translates of the density of $X$, and entropy concavity gives
$h(X+Z)\ge h(X)$. Thus the optimal penalized entropy satisfies

```math
h(q_\lambda)-\lambda P_\lambda
\ge\log(2e/\lambda)-1=\log(2/\lambda)\longrightarrow\infty.
```

In particular $h(q_\lambda)\to\infty$. Since
$h(q_\lambda)\le\log(2e(1+P_\lambda))$, it follows that
$P_\lambda\to\infty$. ∎

Continuity, strict monotonicity, and these limits prove that every $P>0$ has
exactly one parameter $\lambda\in(0,1)$. This completes the global capacity
characterization, including its attainment and uniqueness.

# 8. Closed contact equations

The following identities allow direct checking of numerical roots in the
$(a,b)$-parametrization without integrating $R$.

Let $c=a-b$, and put

```math
A=\arctan(\sinh b)+\arctan(\sinh c),\qquad
v(t)=\log\frac{\cosh c}{\cosh(b-t)}+\lambda(a-t).
```

The change of variables $s=a-t$ gives

```math
R(a)=\int_0^a\sinh t\,v(t)\,dt,
\qquad
R'(a)=\int_0^a\cosh t\,v(t)\,dt.
```

Here $v(a)=0$ and $v'(t)=\tanh(b-t)-\lambda$. Integration by parts gives

```math
\begin{aligned}
R'(a)&=-\int_0^a\sinh t\tanh(b-t)\,dt
        +\lambda(\cosh a-1),\\
R(a)&=-v(0)-\int_0^a\cosh t\tanh(b-t)\,dt
        +\lambda\sinh a.
\end{aligned}
```

Elementary integration, using
$\int\operatorname{sech} z\,dz=\arctan(\sinh z)$, yields

```math
\begin{aligned}
\int_0^a\sinh t\tanh(b-t)\,dt&=-\sinh a+\cosh b\,A,\\
\int_0^a\cosh t\tanh(b-t)\,dt&=1-\cosh a+\sinh b\,A.
\end{aligned}
```

Therefore the contact equations (1) are equivalent to

```math
\lambda\cosh a+\sinh a
=\cosh b\,[\arctan(\sinh c)+\arctan(\sinh b)], \tag{20}
```

and

```math
\log\frac{\cosh c}{\cosh b}+\lambda a
=\frac{\cosh c+\lambda\sinh c}{\cosh b}-1. \tag{21}
```

The rigorous root domain is
$a>0$, $b>0$, and $\lambda+\tanh(a-b)>0$. The proof above gives exactly
one root in that domain for every $\lambda\in(0,1)$. The elementary numerical
solution of (20)--(21) is a method for evaluating the theorem; the theorem and
its proof do not depend on floating-point verification.


# 9. A separate correction of the older proposed input

This section gives a strict, feasible improvement without assuming the new contact equations have a solution. Thus the correction can be checked independently of the main construction.

For $\beta>1$, let

```math
\widetilde\mu_\beta=\beta^{-2}\delta_0+
 (1-\beta^{-2})\frac{e^{-|x|/\beta}}{2\beta}\,dx.
\tag{22}
```

Its characteristic function is

```math
\widehat{\widetilde\mu_\beta}(t)
=\frac{1+t^2}{1+\beta^2t^2}.
```

Consequently its output under scale-one Laplace noise is exactly Laplace with scale $\beta$. This is the correct identity in [1, Proposition 8] and [2, Eq. (60)], after rescaling. Its input cost and mutual information are

```math
P=\beta-\beta^{-1},\qquad I_{\widetilde\mu_\beta}=\log\beta.
\tag{23}
```

For every real $x$, direct integration against the noise gives

```math
\mathbb E|x+Z|=|x|+e^{-|x|}.
\tag{24}
```

For example, when $x\ge0$, splitting the integral at $-x$ and $0$ gives $x+e^{-x}$; symmetry handles negative $x$. The cross-entropy potential of the scale-$\beta$ output is therefore

```math
\widetilde G_\beta(x)=\log(2\beta)
 +\frac{|x|+e^{-|x|}}{\beta}.
\tag{25}
```

Choose $\epsilon>0$, $u>\epsilon$, and $\ell>2\epsilon$. Let $\phi$ be an even, nonnegative smooth probability density supported in $[-\epsilon,\epsilon]$. Define the signed density

```math
v(x)=\frac12\sum_{s\in\{-1,1\}}
\big[\phi(x-su)-2\phi(x-s(u+\ell))
+\phi(x-s(u+2\ell))\big].
\tag{26}
```

The separated supports stay away from zero. Each pair of symmetric translates has mass two and first absolute moment twice its positive center; hence

```math
\int v=0,\qquad \int |x|v(x)\,dx=0.
```

Symmetry also gives the strict second-difference identity

```math
\int e^{-|x|}v(x)\,dx
=e^{-u}(1-e^{-\ell})^2\int e^{-t}\phi(t)\,dt>0.
\tag{27}
```

The continuous density in (22) has a positive minimum on the compact support of the negative part of $v$. Therefore $\widetilde\mu_\beta+\tau v(x)\,dx$ is a probability measure with exactly the same cost for all sufficiently small $\tau>0$. Its symmetry is preserved. Differentiating output entropy at zero gives

```math
\left.\frac{d}{d\tau} I_{\widetilde\mu_\beta+\tau v\,dx}
\right|_{\tau=0}
=\int \widetilde G_\beta(x)v(x)\,dx
=\frac{e^{-u}(1-e^{-\ell})^2}{\beta}
  \int e^{-t}\phi(t)\,dt>0.
\tag{28}
```

Here differentiation is legitimate, not merely formal. The perturbation of the output is $k*v$, with tails bounded by a constant times $e^{-|y|}$. Dividing it by the strictly positive scale-$\beta$ density gives a bounded function because $\beta>1$. For $\tau$ in a small two-sided interval the ratio of the perturbed density to the base density is bounded above and away from zero. The derivative of the entropy integrand is then dominated by an integrable exponential times a linear function. The constant term in that derivative integrates to zero. Equation (28) proves strict suboptimality for every $\beta>1$.

The source of the incorrect capacity inference can be isolated. Equation (24) gives

```math
\mathbb E|X+Z|=\mathbb E|X|+\mathbb E e^{-|X|}\le P+1.
```

For $P>0$, equality cannot occur: equality in the last term forces $X=0$ almost surely, inconsistent with spending cost $P$. The moment supremum $P+1$ is approached by the flash inputs

```math
(1-p)\delta_0+\frac p2(\delta_{-P/p}+\delta_{P/p}),
\qquad p\downarrow0,
```

but this does not supply an entropy-maximizing output. Producing a Laplace output saturates the entropy bound at its own output moment; it does not maximize that moment under the input constraint. For (22), the output moment is $\beta=P+\beta^{-1} \lt P+1$.

Since the exact optimizer exists and is nondegenerate for each positive budget, its output first moment is strictly less than $P+1$. Together with (18b), this yields

```math
\boxed{\quad
\log\frac{P+\sqrt{P^2+4}}{2}
 \lt C(P)<\log(1+P),\qquad P>0.
\quad}
\tag{29}
```

Thus the Shannon moment bound used for this model in [5] remains a valid upper bound, and the self-deconvolution identity in [1,2] remains valid. Neither is an exact capacity formula under the input absolute-cost constraint.

# 10. Scaling, regularity, and endpoints

For noise scale $\sigma>0$, divide both channel input and output by $\sigma$. This invertible transformation preserves mutual information, changes the noise to scale one, and changes the budget to $P/\sigma$. It maps feasible input laws bijectively. Consequently

```math
C_\sigma(P)=C(P/\sigma).
\tag{30}
```

For $P>0$, the unique maximizing input at noise scale $\sigma$ is the pushforward of $\mu_{\lambda(P/\sigma)}$ under $x\mapsto\sigma x$. At zero budget the input is uniquely $\delta_0$, for every scale.

One may also recover useful regularity without differentiating the contact equations. Write $\lambda(P)$ for the continuous inverse of $P_\lambda$. Applying the global certificate to the optimizer at a different budget gives

```math
C(Q)\le C(P)+\lambda(P)(Q-P).
```

Interchanging $P$ and $Q$, for $Q>P>0$, gives

```math
\lambda(Q)\le\frac{C(Q)-C(P)}{Q-P}\le\lambda(P).
\tag{31}
```

Letting $Q$ tend to $P$ from either side and using the continuous inverse proves

```math
C'(P)=\lambda(P)\in(0,1),\qquad P>0.
\tag{32}
```

The derivative is continuous and strictly decreasing; hence $C$ is strictly increasing and strictly concave on $(0,\infty)$. Since $0\le C(P)\le\log(1+P)$, it is continuous at zero. The mean value theorem, (32), and $\lambda(P)\to1$ as $P\downarrow0$ imply

```math
\lim_{P\downarrow0}\frac{C(P)}P=1.
\tag{33}
```

This slope agrees with the classical capacity-per-unit-cost result [7]; it is not a new independent theorem of that type. In contrast, (23) has slope $1/2$, which provides an additional consistency check on its suboptimality. Finally (29) directly implies $C(P)-\log P\to0$ as $P\to\infty$. None of these deductions requires smooth dependence of the root parameters beyond the continuity proved in Section 6.

# 11. Reproducible evaluation and interpretation

The exact result is a parametric formula: for each $\lambda\in(0,1)$, solve the unique admissible root of (20)–(21), compute (5) and (6), and use the monotone budget map if a prescribed $P$ is desired. Elementary closed form in $P$ is not asserted. A numerical routine must explicitly enforce $a>0$, $b>0$, and $\lambda+\tanh(a-b)>0$; unconstrained root searches can return spurious values with vanishing residuals caused by cancellation.

The companion reproducibility directory uses high-precision arithmetic, continuation, and checks against integral identities and the original convolution. The following values are illustrative, rounded to six significant digits; full precision and checks are stored separately.

| $\lambda$ | Budget $P_\lambda$ | Exact-law information $C(P_\lambda)$ | Old-family information | Moment upper bound |
|---:|---:|---:|---:|---:|
| 0.10 | 9.72430 | 2.28786 | 2.28504 | 2.37251 |
| 0.20 | 4.38223 | 1.54320 | 1.52598 | 1.68310 |
| 0.40 | 1.29927 | 0.680142 | 0.610918 | 0.832591 |
| 0.60 | 0.276516 | 0.187015 | 0.137821 | 0.244135 |
| 0.80 | 0.0112307 | 0.00929236 | 0.00561532 | 0.0111681 |

All information quantities in the table are in nats per use. At $\lambda=0.4$, for example, $a\approx2.70247$ and $b\approx2.62250$. The zero atom has mass approximately $0.725749$; each boundary atom has mass approximately $0.0255030$. The remaining probability is in the two continuous tails. The old-family information is about 10.2 percent below the new capacity at that budget (equivalently, the new value is about 11.3 percent larger). These percentages describe this example, not a uniform bound.

The numerical results provide reproducibility checks, not evidence substituting for the all-parameter proof. No interval-arithmetic root certificate, external peer review, Lean verification, or implemented channel code is claimed.

# References

[1] A. Dytso, R. Bustin, H. V. Poor, and S. Shamai, “On Additive Channels with Generalized Gaussian Noise,” *2017 IEEE International Symposium on Information Theory*, pp. 426–430. DOI: [10.1109/ISIT.2017.8006563](https://doi.org/10.1109/ISIT.2017.8006563). Author-hosted full paper: [Technion PDF](https://shamai.net.technion.ac.il/files/2017/04/dbs-ISIT2017.pdf).

[2] A. Dytso, R. Bustin, H. V. Poor, and S. Shamai, “Analytical properties of generalized Gaussian distributions,” *Journal of Statistical Distributions and Applications*, vol. 5, article 6, 2018. DOI: [10.1186/s40488-018-0088-5](https://doi.org/10.1186/s40488-018-0088-5). Publisher full text, Section 6.2.

[3] J. Fahs and I. Abou-Faycal, “On Properties of the Support of Capacity-Achieving Distributions for Additive Noise Channel Models With Input Cost Constraints,” *IEEE Transactions on Information Theory*, vol. 64, no. 2, pp. 1178–1198, 2018. DOI: [10.1109/TIT.2017.2771815](https://doi.org/10.1109/TIT.2017.2771815). Published-version full text from the American University of Beirut repository.

[4] J. Stapmanns, L. Eilers, C. Dias, T. Kühn, and J.-P. Pfister, “Phase Transitions of the Additive Uniform Noise Channel With Peak Amplitude and Cost Constraint,” *IEEE Transactions on Information Theory*, vol. 72, no. 7, pp. 4565–4586, 2026. DOI: [10.1109/TIT.2026.3687151](https://doi.org/10.1109/TIT.2026.3687151). [Preprint v1](https://arxiv.org/html/2510.12427v1), and author-uploaded journal text on ResearchGate, Section VII, p. 4575. Version-dependent locations are distinguished in the source register.

[5] S. Tridenski and A. Somekh-Baruch, “The Shannon Upper Bound for the Error Exponent,” *IEEE Transactions on Information Theory*, vol. 72, no. 6, pp. 3539–3555, 2026. DOI: [10.1109/TIT.2026.3683949](https://doi.org/10.1109/TIT.2026.3683949). Technical text actually read: [arXiv:2509.08425v1](https://arxiv.org/html/2509.08425v1). Final publication metadata was verified separately.

[6] P. Narayanan and L. N. Theagarajan, “Capacity of Peak and Average Power Constrained Additive Generalized Gaussian Noise Channels,” *IEEE Communications Letters*, vol. 26, no. 12, pp. 2880–2883, 2022. DOI: [10.1109/LCOMM.2022.3208888](https://doi.org/10.1109/LCOMM.2022.3208888). Bibliography and abstract were checked; full text was unavailable. No unverified theorem from this source is used.

[7] S. Verdú, “On Channel Capacity per Unit Cost,” *IEEE Transactions on Information Theory*, vol. 36, no. 5, pp. 1019–1030, 1990. DOI: [10.1109/18.57201](https://doi.org/10.1109/18.57201). [MIT-hosted paper](https://web.mit.edu/6.441/www/reading/verdu_unitcost.pdf).
