# Affine optimality under a common disturbance law: sharp horizons, exposed-face rigidity, and moment certificates

**Research draft · 25 November 2026 · Revised draft.**

## Abstract

We study finite-horizon weighted mean estimation when all observations
are independent draws from one unknown scalar law and its mean and standard
deviation lie in a disk centered at $(0,s_0)$. Only a finite second moment
is assumed. For every positive radius and $s_0>0$, and every nonnegative
stage-weight sequence, we prove that affine rules attain the unrestricted
minimax value if and only if no positively weighted decision uses three or
more observations. The equality direction uses a matching two-law Bayes
experiment. The strict direction constructs a cubic statistic with distinct
sample indices and an explicit uniform risk certificate; no high moments
are required. An exact example improves the optimal affine worst risk
$3/2$ to at most $35/24$. Through a known regret identity, the theorem
gives the corresponding necessary and sufficient condition for fully
observed finite-horizon LQR with arbitrary finite state and control dimensions
and scalar disturbances. We classify affine optimality, without asserting
an exact unrestricted minimax value in every longer-horizon case.

The extension treats arbitrary compact convex sets of squared means and
variances with a positive-coordinate affine saddle. If the exposed affine
face has variance-versus-squared-mean slope magnitude greater than one,
three or more effective observations force strict nonlinear improvement,
even for a nonunique worst face. At slope one, equality forces binary least-favorable sampling laws when
a positively weighted decision uses at least two observations; a finite
interval-moment condition characterizes equality for every horizon. A triangular example further separates
the entire multiaffine polynomial class from the full measurable class.
The last separation is existential; its exact nonlinear optimum is not
claimed. The original shifted-disk result retains an explicit improving rule.

**Keywords:** distributionally robust regret; common law ambiguity;
minimax mean estimation; affine policies; finite moments; linear quadratic control.

## Motivation and contribution boundary

Fiechtner and Blanchet [R1] formulate ex-ante robust regret control when
nature chooses a single disturbance law and reuses it across time. Their
tractable synthesis is optimal within the affine policy class, and their
conclusion leaves optimality beyond that class open. The present paper
answers this direction for scalar disturbances under their moment ambiguity,
not for the entire multidimensional problem.

The comparator knows the candidate disturbance law but cannot observe its
future samples. A history-dependent policy can learn the common mean, so
the statistical experiment differs from ambiguity over one arbitrary joint
trajectory law. In this experiment a structural question is whether a
computable affine solution is also optimal among all measurable rules.
Theorem 1 gives a complete answer for every finite horizon and every
nonnegative set of stage weights, including weights equal to zero.

The ingredients have substantial prior history. The LQR regret-to-prediction
identity is already explicit for nonlinear causal policies in [R2, Section
3.2, equation (33)]. Nonlinear minimax-regret estimation, including a cubic
estimator in a Gaussian covariance-uncertainty model, appears in
Eldar and Merhav [R3, Section VII and Theorem 4]. Symmetric endpoint priors
and their one- and two-observation posterior identities are classical
bounded-binomial tools [R4]. Distinct-sample products and U-statistics are
also standard [R5, R6]. None of these ingredients is claimed as an invention.

The specific increment proved here is the complete affine-versus-all-rule
classification for the reused-law moment experiment, together with an
explicit global separation certificate valid under only second moments.
The exact deficit of the affine risk controls the adversary's movement
after the nonlinear correction; a derivative at an old worst-case law
alone would not suffice. The result also retains arbitrary weights and
the full causal control class in its LQR interpretation.

Closest model differences matter. Dykstra [R7] studies known compact
support, which supplies a bounded experiment and permits classical
Dirichlet-prior affine minimaxity. Wasserstein MMSE [R8] uses separate
uncertainty for random signal and noise. The temporally correlated
Wasserstein LQR result [R9] concerns a joint noise-law ball and worst cost.
These are not the same ambiguity set or regret experiment. For [R9], only
the official abstract was available in this audit; no unread theorem is
used in a proof or an absolute priority claim. The literature comparison is restricted to accessible materials.

### Scope of the secondary extension

Sections 10--12 add a geometric theory beyond the original disk. The
coordinates of the general ambiguity set are explicitly $(x,v)=(\mu^2,
\operatorname{Var}X)$; convexity in a different coordinate system is not
silently substituted. Write the optimal affine risk as $Bx+Av$, put
$\beta=B/A$, and let $N$ be the largest positively weighted observation
count. The extension assumes $A,B>0$ and a positive-coordinate dual saddle,
so $\rho>0$ is well defined. Under those assumptions:

| Regime | Full measurable class versus affine class |
|---|---|
| $N\le2$ | Equality by the common two-law Bayes construction |
| $N\ge3$, $\beta>1$ | Strict improvement exists in the bounded continuous class |
| $\beta=1$ | Equality exactly when the specified finite beta moments fit the exposed interval |
| $0<\beta<1$, $N\ge3$ | No general classification is asserted; reciprocal-integer triangular examples give equality |

At $\beta=1$, binary support of every matching least-favorable prior is
already forced by two observations; a one-observation counterexample shows
this rigidity threshold is sharp. The critical-face criterion gives a
finite prior when equality holds, and a matrix-to-polynomial construction
with a uniform off-face certificate when it fails.

Linearity of posterior means and finite beta-moment matching are classical,
including nonparametric linear Bayes analyses [R11, R12]. The interval
moment tests are also classical [R13], and constrained binomial minimaxity
has long been studied through moment vectors [R14]. The new argument does
not assume a binary or exponential-family sampling model: it starts with
every law in the finite-second-moment ambiguity class, proves the necessary
least-favorable-prior interface, and derives the exposed-face obstruction
and binary rigidity from a nonnegative conditional variance. The triangular
separation then shows why an arbitrarily rich multiaffine correction class
can still miss a strict full-class improvement. These are the specific
contributions for comparison, rather than the classical tools themselves.

## 1. Model and main theorem

Fix an integer $T\geq1$, weights $q_0,\ldots,q_{T-1}\geq0$, not all zero,
and $s_0>0$, $\delta>0$. Write

$$
\mathcal P=\{P:\ P\text{ is a Borel probability law on }\mathbb R,
\quad E_P X^2<\infty,
\quad \mu(P)^2+(s(P)-s_0)^2\leq\delta^2\},
$$

where $\mu(P)=E_P X$ and $s(P)^2=\operatorname{Var}_P X$.
The adversary chooses one law $P$, and all observations are iid from that
law. At stage $t$, an estimator $f_t$ has exactly $t$ observations.
Each $f_t:\mathbb R^t\to\mathbb R$ is Borel measurable and square-integrable
under every $P^{\otimes t}$, and $f_0$ is a constant. Define

$$
\mathcal R(f,P)=\sum_{t=0}^{T-1}q_t
 E_{P^{\otimes t}}[(f_t(X_1,\ldots,X_t)-\mu(P))^2],
$$

$$
V_{\rm all}=\inf_f\sup_{P\in\mathcal P}\mathcal R(f,P),\qquad
V_{\rm aff}=\inf_{f\text{ affine}}\sup_{P\in\mathcal P}\mathcal R(f,P).
$$

Independent randomization of the estimators cannot improve these values:
conditioning on the observations and applying Jensen's inequality replaces
any randomized estimator by its conditional mean without increasing squared
loss under any law. Thus deterministic measurable maps suffice.

### Theorem 1 — the sharp affine boundary

For every set of the parameters above,

$$
\boxed{\quad V_{\rm all}=V_{\rm aff}
\quad\Longleftrightarrow\quad
q_t=0\text{ for every }t\geq3.\quad} \tag{1}
$$

If some $q_j>0$ with $j\geq3$, Section 6 specifies an admissible
nonlinear estimator and completely explicit positive constants
$\varepsilon,C_*$ such that

$$
\sup_{P\in\mathcal P}\mathcal R(f^{\varepsilon},P)
\leq V_{\rm aff}-\varepsilon C_*<V_{\rm aff}. \tag{2}
$$

The quantification includes unbounded-support laws and laws with infinite
third, fourth, or sixth absolute moments. We do not determine the unrestricted
minimax value in every longer-horizon case, nor assert that the particular
cubic correction is globally minimax.

## 2. Exact affine reduction and a finite-dimensional saddle point

Let $I=\{t\in\{1,\ldots,T-1\}:q_t>0\}$. If $I$ is empty, then
$q_0>0$, and choosing $f_0=0$ gives value $q_0\delta^2$.
The two laws with means $\pm\delta$ and standard deviation $s_0$
give the matching lower bound for every constant $f_0$. Thus
$V_{\rm all}=V_{\rm aff}=q_0\delta^2$. This handles every case without
a positively weighted observation stage.

Henceforth assume $I\neq\varnothing$. Introduce squared mean $x=\mu^2$
and variance $v=s^2$, with moment domain

$$
K=\{(x,v)\in\mathbb R_+^2:
x+(\sqrt v-s_0)^2\leq\delta^2\}. \tag{3}
$$

This is compact: $0\leq x\leq\delta^2$ and
$0\leq v\leq(s_0+\delta)^2$. It is convex because
$v\mapsto v-2s_0\sqrt v+s_0^2$ is convex on $[0,\infty)$.
Every point of $K$ is realized by a finite-support law with mean
$+\sqrt x$, and also by its reflection with mean $-\sqrt x$.

An arbitrary affine stage rule is $b_t+\sum_{i=1}^t c_{ti}X_i$.
Average it over the permutations of the $t$ observations. Convexity of
squared loss and the iid property show that the average cannot increase
risk under any fixed $P$. It has the form $b_t+a_t\bar X_t$, where
$\bar X_t=t^{-1}\sum_iX_i$. Next average the entire strategy with its
sign-reflected strategy. Since $P\in\mathcal P$ if and only if its
reflection is in $\mathcal P$, this does not increase worst-case risk
and removes every $b_t$, including $f_0$. Therefore affine minimax
optimization may be restricted to

$$
f_0=0,\qquad f_t=a_t\bar X_t.
$$

Projecting any real $a_t$ onto $[0,1]$ decreases both $a_t^2$
and $(1-a_t)^2$, so we may also impose $a_t\in[0,1]$.
Zero-weight stages may be assigned the zero rule. For active stages,

$$
\Phi(a;x,v)=B(a)x+A(a)v,\qquad
A(a)=\sum_{t\in I}\frac{q_ta_t^2}{t},\quad
B(a)=q_0+\sum_{t\in I}q_t(1-a_t)^2. \tag{4}
$$

Both coefficient domain $[0,1]^I$ and moment domain $K$ are compact
convex sets. The function $\Phi$ is continuous, convex in $a$, and
linear in $(x,v)$. The finite-dimensional convex-concave minimax theorem
(a special case of Sion's theorem [R10]) gives

$$
V_{\rm aff}
=\min_{a\in[0,1]^I}\max_{(x,v)\in K}\Phi(a;x,v)
=\max_{(x,v)\in K}\min_{a\in[0,1]^I}\Phi(a;x,v). \tag{5}
$$

For $x,v>0$, the inner minimizer is unique and is

$$
a_t(x,v)=\frac{t x}{v+t x}, \tag{6}
$$

and its value is

$$
F(x,v)=q_0x+\sum_{t\in I}q_t\frac{xv}{v+t x}. \tag{7}
$$

The continuous extension of each fraction at $(0,0)$ is zero; for
example, $0\leq xv/(v+t x)\leq\min(x,v/t)$.
Formula (7), with this convention, therefore holds on the whole domain.

Minimizers in (5) and maximizers of (7) exist. If $a^*$ and
$(x_*,v_*)$ are any such two optimizers, then they form a saddle:

$$
\Phi(a^*;x,v)\leq V_{\rm aff}
=\Phi(a^*;x_*,v_*)\leq\Phi(a;x_*,v_*) \tag{8}
$$

for all feasible $(x,v)$ and $a$. Indeed the middle quantity is
bounded above by the primal value and below by the dual value in (5).

### Interior nature moments

We have $x_*>0$ and $v_*>0$.

First, $F(0,v)=0$, whereas the feasible point
$(\delta^2/2,s_0^2)$ has strictly positive value because $I\neq\varnothing$.
This excludes $x_*=0$.

If $v=0$ is feasible, it has $F(x,0)=q_0x$. If $q_0=0$, its value is
zero and is not optimal. If $q_0>0$, the best point on this edge is
$x=\delta^2-s_0^2$, whenever this number is nonnegative. For sufficiently
small $s>0$, the feasible boundary point

$$
x(s)=\delta^2-(s-s_0)^2
=\delta^2-s_0^2+2s_0s-s^2
$$

has $x(s)>\delta^2-s_0^2$, and
$F(x(s),s^2)\geq q_0x(s)>q_0(\delta^2-s_0^2)$.
If the edge contains only the origin it is already excluded. Thus
$v_*>0$ in all cases.

Consequently (6) holds for every active stage and gives
$0<a_t^*<1$. In particular, the coefficients

$$
A=A(a^*)>0,\qquad B=B(a^*)>0 \tag{9}
$$

are strictly positive. Let $s_*=\sqrt{v_*}$.

### A unique worst moment pair and its exact risk deficit

For the affine rule $a^*$, nature maximizes $Bx+As^2$.
Since $B>0$, the moment constraint is tight at a maximizer. Thus nature
maximizes the quadratic

$$
h(s)=B[\delta^2-(s-s_0)^2]+As^2
$$

on $[\max(0,s_0-\delta),s_0+\delta]$.
The already established $x_*>0,s_*>0$ puts $s_*$ in the interior
of this interval. The stationary equation is

$$
(B-A)s_*=B s_0. \tag{10}
$$

As $B,s_*,s_0>0$, it follows that

$$
B>A,\qquad s_*=\frac{B s_0}{B-A}>s_0,
\qquad x_*=\delta^2-(s_*-s_0)^2>0. \tag{11}
$$

The quadratic $h$ is strictly concave, so this worst moment pair is
unique. The law itself need not be unique; all laws having either mean
$\pm\sqrt{x_*}$ and variance $v_*$ have the same affine risk.

For any feasible $(x,s)$, define its nonnegative constraint slack

$$
e=\delta^2-(s-s_0)^2-x\geq0.
$$

Completing the square in $h$ gives the exact identity

$$
\Delta(x,s):=V_{\rm aff}-[Bx+As^2]
=(B-A)(s-s_*)^2+B e. \tag{12}
$$

This identity is essential. Improvement merely at the old maximizer
would not by itself prove improvement in worst-case risk.

### A unique scalar equation computes the affine saddle

The saddle is computable without a search over probability laws. On
$v\in[s_0^2,(s_0+\delta)^2]$, put

$$
x(v)=\delta^2-(\sqrt v-s_0)^2,\qquad G(v)=F(x(v),v).
$$

Every feasible point with $v<s_0^2$ is coordinatewise dominated by
$(\delta^2,s_0^2)$. At $v\geq s_0^2$, increasing $x$ to its boundary
value cannot decrease $F$. Thus maximizing $G$ suffices.
For $g_t(x,v)=xv/(v+tx)$, direct differentiation gives

$$
\partial_xg_t=\frac{v^2}{(v+tx)^2},\quad
\partial_vg_t=\frac{t x^2}{(v+tx)^2},\quad
\nabla^2 g_t=-\frac{2t}{(v+tx)^3}
\begin{pmatrix}v^2&-xv\\-xv&x^2\end{pmatrix}\preceq0.
$$

On this interval $F_x>0$ and
$x''(v)=-s_0/(2v^{3/2})<0$. Consequently

$$
G''(v)=(x'(v),1)\nabla^2F(x(v),v)(x'(v),1)^\top
       +F_x(x(v),v)x''(v)<0.
$$

The endpoint derivatives satisfy

$$
G'(s_0^2)=F_v(\delta^2,s_0^2)>0,\qquad
G'((s_0+\delta)^2)
=-\frac{\delta}{s_0+\delta}\left(q_0+\sum_{t\in I}q_t\right)<0.
$$

There is exactly one zero of $G'$ in the interior. It gives $v_*$,
and then $x_*$, all $a_t^*$, and $V_{\rm aff}$ follow from
(6)--(8). Monotonicity of $G'$ allows certified interval bisection.
This is a characterization of the affine value; it does not compute
the unrestricted longer-history minimax value.

## 3. All-estimator lower bound when the positive weights stop at two samples

Suppose $q_t=0$ for every $t\geq3$, and retain $I\neq\varnothing$.
Set

$$
m=\sqrt{x_*},\qquad c=\sqrt{x_*+v_*},\qquad r=m/c\in(0,1).
$$

Consider two admissible laws $P_+$, $P_-$, supported on the same set
$\{-c,c\}$, with

$$
P_+(X=c)=\frac{1+r}{2},\qquad
P_-(X=c)=\frac{1-r}{2}. \tag{13}
$$

Their means are $m$ and $-m$, respectively, and their common variance
is $v_*$. Put probability one-half on each law. Equivalently, draw
$\Theta\in\{-m,m\}$ uniformly, then draw observations independently
conditional on its associated law. This is an ordinary prior over two
fixed iid laws, not a change to the adversary's common-law model.

The squared-loss Bayes estimators under this prior are:

$$
E[\Theta]=0,
$$

$$
E[\Theta\mid X_1]=r^2X_1
=\frac{x_*}{v_*+x_*}\bar X_1,
$$

$$
E[\Theta\mid X_1,X_2]
=\frac{2r^2}{1+r^2}\bar X_2
=\frac{2x_*}{v_*+2x_*}\bar X_2. \tag{14}
$$

For the last identity, opposite signs give posterior mean zero. If both
observations have sign $\eta\in\{-1,1\}$, the posterior mean is
$\eta m\,2r/(1+r^2)$, which is exactly (14).
Thus the affine minimax rule from (6) is a Bayes rule at every stage with
positive weight.

For any causal estimator family $f$,

$$
\sup_{P\in\mathcal P}\mathcal R(f,P)
\geq\tfrac12\mathcal R(f,P_+)+\tfrac12\mathcal R(f,P_-)
\geq\tfrac12\mathcal R(a^*,P_+)+\tfrac12\mathcal R(a^*,P_-)
=V_{\rm aff}. \tag{15}
$$

The second inequality is conditional-mean optimality for squared loss,
summed with nonnegative weights. The final equality follows from the
saddle identity (8). The opposite inequality follows from inclusion of
the affine class in the full class. This proves equality for every
low-weight-support configuration, including missing or zero weights
at stages 0, 1, or 2.

## 4. A nonlinear direction that needs only second moments

Let $j\geq3$ be any stage with $q_j>0$, and write
$a=a_j^*$, $q=q_j$. Define the symmetric cubic statistic

$$
U_{j,3}=\binom j3^{-1}
\sum_{1\leq i<k<\ell\leq j}X_iX_kX_\ell. \tag{16}
$$

All factors within each product come from distinct observations.
For a law with mean $\mu$, squared mean $x=\mu^2$, and variance $s^2$,
independence gives

$$
E U_{j,3}=\mu^3,
\qquad
E[\bar X_j U_{j,3}]=\mu^4+\frac{3s^2\mu^2}{j}. \tag{17}
$$

To verify the second identity, fix one triple. Each of the three sample
mean summands in that triple contributes
$(\mu^2+s^2)\mu^2$, while each of the other $j-3$ summands contributes
$\mu^4$, and then divide by $j$.

Every product in $U_{j,3}^2$ has exponent at most two in each individual
observation. In particular, Jensen's inequality and independence imply

$$
E U_{j,3}^2\leq(E X^2)^3=(x+s^2)^3
\leq(s_0+\delta)^6. \tag{18}
$$

The last inequality uses
$\sqrt{\mu^2+s^2}\leq\sqrt{\mu^2+(s-s_0)^2}+s_0\leq\delta+s_0$.
Hence this statistic is square-integrable under every admissible law.
No moment of order greater than two of a single observation is needed.

For exact finite calculations one can also use

$$
E U_{j,3}^2
=\sum_{h=0}^3
\frac{\binom3h\binom{j-3}{3-h}}{\binom j3}
(x+s^2)^h x^{3-h}, \tag{19}
$$

where an out-of-range binomial coefficient is zero. The coefficient is
the probability that a uniformly chosen second triple has intersection
size $h$ with a fixed first triple. This proves both the formula and that
its coefficients sum to one. For $j=3$, (19) is simply
$(x+s^2)^3$.

Modify only stage $j$:

$$
f_j^{\varepsilon}=a\bar X_j-\varepsilon U_{j,3},\qquad
f_t^{\varepsilon}=a_t^*\bar X_t\quad(t\neq j),\qquad f_0=0. \tag{20}
$$

As zero-weight stages have no effect, their rule can be zero. From (17),

$$
\mathcal R(f^{\varepsilon},P)
=Bx+As^2-2\varepsilon C(x,s)+\varepsilon^2W(x,s), \tag{21}
$$

where

$$
C(x,s)=q x\left[(a-1)x+\frac{3a}{j}s^2\right],\qquad
W(x,s)=qE U_{j,3}^2. \tag{22}
$$

At the affine worst moment pair, use $a=jx_* /(v_*+jx_*)$ to get

$$
C_*:=C(x_*,s_*)
=\frac{2q x_*^2v_*}{v_*+jx_*}>0. \tag{23}
$$

Thus the new direction has a strictly negative first derivative in
risk at both signs of the worst mean. The next section upgrades this
local statement to a certified improvement over the entire ambiguity set.

## 5. Explicit constants controlling the changed worst case

Put $R=s_0+\delta$ and

$$
D_x=q\left[2(1-a)\delta^2+\frac{3a}{j}R^2\right],
\qquad
D_s=q\frac{6a}{j}\delta^2R. \tag{24}
$$

On the containing rectangle $0\leq x\leq\delta^2$, $0\leq s\leq R$,
the absolute values of the partial derivatives of $C$ are at most
$D_x$ and $D_s$, respectively. The mean-value bound on this rectangle
is therefore

$$
|C(x,s)-C_*|\leq D_x|x-x_*|+D_s|s-s_*|. \tag{25}
$$

By the definition of slack $e$ and the boundary identity for $x_*$,

$$
|x-x_*|
\leq |(s-s_0)^2-(s_*-s_0)^2|+e
\leq2\delta|s-s_*|+e. \tag{26}
$$

Combining (12), (25), and (26), define

$$
L=\frac{2\delta D_x+D_s}{\sqrt{B-A}},\qquad
M=\frac{D_x}{B},\qquad
W_0=q R^6. \tag{27}
$$

These constants are finite and strictly positive. For every admissible
moment pair,

$$
C(x,s)\geq C_*-L\sqrt{\Delta(x,s)}-M\Delta(x,s),
\qquad 0\leq W(x,s)\leq W_0. \tag{28}
$$

## 6. Certified strict separation

Choose any

$$
0<\varepsilon\leq
\varepsilon_0:=
\min\left\{\frac{1}{4M},
\frac{C_*}{W_0+2L^2}\right\}. \tag{29}
$$

All quantities needed in (29) are determined by the finite-dimensional
affine saddle and the input parameters. For any $P\in\mathcal P$, let
$\Delta=\Delta(x,s)$. Equations (21) and (28) yield

$$
\begin{aligned}
\mathcal R(f^{\varepsilon},P)
&\leq V_{\rm aff}-\Delta-2\varepsilon C_*
 +2\varepsilon L\sqrt\Delta+2\varepsilon M\Delta
 +\varepsilon^2W_0\\
&\leq V_{\rm aff}-2\varepsilon C_*
 -\tfrac12\Delta+2\varepsilon L\sqrt\Delta
 +\varepsilon^2W_0\\
&\leq V_{\rm aff}-2\varepsilon C_*
 +\varepsilon^2(W_0+2L^2)\\
&\leq V_{\rm aff}-\varepsilon C_*.
\end{aligned} \tag{30}
$$

The third line is the elementary square-completion inequality
$-y^2/2+2\varepsilon Ly\leq2\varepsilon^2L^2$, with
$y=\sqrt\Delta$. The second and fourth lines use the respective bounds
in (29). Taking the supremum over all laws proves (2), and hence the
strict direction of (1).

This bound allows nature to change its mean, variance, support, or tail
shape in response to the new rule. The estimate is uniform over those
choices. The dependence on $1/(B-A)$ is a substantive feature: at the
zero-nominal-variance boundary the unique-moment-gap argument is not
available, so that separate boundary must not be inferred from this proof.

## 7. An exact four-stage example with a visible uniform gap

Take

$$
T=4,\qquad(q_0,q_1,q_2,q_3)=(0,0,0,1),\qquad s_0=\delta=2.
$$

The moment domain is $0\leq s\leq4$, $0\leq x\leq s(4-s)$.
The affine rule $f_3=\tfrac12\bar X_3$ has
$A=1/12$, $B=1/4$, and its maximum risk is

$$
\max_{0\leq s\leq4}\left[s-\frac{s^2}{6}\right]=\frac32,
$$

at $(x_*,s_*)=(3,3)$. At that pair, every affine coefficient has
risk $3(1-a)^2+3a^2\geq3/2$. Thus
$V_{\rm aff}=3/2$ exactly.

Use the explicit nonlinear rule

$$
f_3=\frac12\bar X_3-\frac1{192}X_1X_2X_3. \tag{31}
$$

Write $R(f_3,P)=E_P[(f_3-\mu)^2]$. For every admissible law this risk is

$$
R(x,s)=\frac x4+\frac{s^2}{12}
-\frac{x(s^2-x)}{192}
+\frac{(x+s^2)^3}{192^2}. \tag{32}
$$

On the whole moment domain,

$$
\partial_xR
=\frac14-\frac{s^2-2x}{192}
+\frac{3(x+s^2)^2}{192^2}
\geq\frac14-\frac{16}{192}=\frac16>0.
$$

Hence nature maximizes (32) on $x=s(4-s)$, where it becomes

$$
R(s)=s-\frac{s^2}{12}-\frac{35s^3}{576}+\frac{s^4}{96}.
$$

To prove a uniform bound, define

$$
P(s)=576\left[\frac{35}{24}-R(s)\right]
=840-576s+48s^2+35s^3-6s^4.
$$

Write $z=s-3\in[-3,1]$. Then

$$
P(s)=3+9z+39z^2-37z^3-6z^4.
$$

If $-3\leq z\leq0$, the final two terms equal
$-z^3(37+6z)\geq0$; the remaining quadratic is at least
$129/52>0$. If $0\leq z\leq1$, then
$-37z^3-6z^4\geq-43z^2$, so
$P(s)\geq3+9z-4z^2\geq3>0$. Therefore

$$
V_{\rm all}\leq\sup_{P\in\mathcal P}R(f_3,P)
\leq\frac{35}{24}<\frac32=V_{\rm aff},\qquad
V_{\rm aff}-V_{\rm all}\geq\frac1{24}. \tag{33}
$$

This is an exact inequality over the continuous moment region, not a
grid check, and its applicability to every law follows from (32).
The upper bound $35/24$ is deliberately a rational certificate; it is
not asserted to be the exact optimum of this polynomial or of all rules.

## 8. Exact transfer to LQR with arbitrary state and control dimensions

Consider deterministic finite-dimensional matrices and fully observed
dynamics

$$
z_{t+1}=A_tz_t+B_tu_t+\xi_t w_t,\qquad t=0,\ldots,T-1,
$$

with fixed $z_0$, scalar iid disturbances with one common law $P$, and
unconstrained controls. Assume $\xi_t\neq0$, so the past scalar disturbance
can be reconstructed from successive states and applied controls. The cost is

$$
L=\sum_{t=0}^{T-1}
\bigl(z_t^\top Q_tz_t+2z_t^\top D_tu_t+u_t^\top R_tu_t\bigr)
+z_T^\top Q_Tz_T,
$$

where $Q_t,R_t,Q_T$ are symmetric. Allow arbitrary finite state and
control dimensions, and assume that every completed-square control matrix
below is positive definite. This assumption, rather than positivity of
every separate state-cost matrix, is what is required by the proof.

Set $S_T=Q_T$, $P_T=0$, and work backwards:

$$
M_t=R_t+B_t^\top S_{t+1}B_t\succ0,
\qquad C_t=B_t^\top S_{t+1}A_t+D_t^\top,
$$

$$
K_t=-M_t^{-1}C_t,\qquad
H_t=-M_t^{-1}B_t^\top(S_{t+1}\xi_t+P_{t+1}),
$$

$$
S_t=Q_t+A_t^\top S_{t+1}A_t-C_t^\top M_t^{-1}C_t,
$$

$$
P_t=(A_t+B_tK_t)^\top(S_{t+1}\xi_t+P_{t+1}). \tag{34}
$$

Here $P_t$ is a state-dimensional vector, unrelated to the symbol for
a probability law. For a known disturbance law with mean $\mu$, backward
completion of squares gives a value function of the form
$z^\top S_tz+2z^\top P_t\mu+c_t(\mu,s^2)$, and an optimal causal control

$$
u_t^{*,P}=K_tz_t+H_t\mu. \tag{35}
$$

For completeness, the scalar term is $c_t=d_t\mu^2+e_t s^2$.
With $d_T=e_T=0$ and $g_t=S_{t+1}\xi_t+P_{t+1}$, its recursion is

$$
\begin{aligned}
d_t&=d_{t+1}+\xi_t^\top S_{t+1}\xi_t
       +2\xi_t^\top P_{t+1}
       -g_t^\top B_tM_t^{-1}B_t^\top g_t,\\
e_t&=e_{t+1}+\xi_t^\top S_{t+1}\xi_t.
\end{aligned}
$$

Expanding the next value function under the next independent disturbance
and completing the control square verifies these recursions directly.
Because each $M_t$ is positive definite, completion of squares identifies
the infimum among all square-integrable causal controls at each stage,
not just among affine controls.

Let $J^*(P)$ denote the cost of the known-law optimal causal controller.
For every causal controller $\pi$ whose controls are square-integrable
under each admissible law, the same Bellman square completion, conditional
on the history and then summed over stages, yields

$$
J(\pi,P)-J^*(P)
=\sum_{t=0}^{T-1}E_P
\left[\|u_t-K_tz_t-H_t\mu\|_{M_t}^2\right],\qquad
\|y\|_{M_t}^2=y^\top M_ty. \tag{36}
$$

This is the standard advantage identity; the arbitrary-causal prediction
interpretation is already explicit in [R2, Section 3.2, equation (33)].
It is included here as an interface, not as an original contribution.
Its proof uses only conditional
independence of the next disturbance and the completed square, so it remains
valid for nonlinear causal policies. In particular, the comparator is the
controller knowing the law, without knowledge of future samples.

Suppose the nominal mean is $\widehat\mu$, and the common law satisfies

$$
(\mu-\widehat\mu)^2+(s-s_0)^2\leq\delta^2.
$$

Put $X_i=w_{i-1}-\widehat\mu$, $\theta=\mu-\widehat\mu$, and

$$
q_t=H_t^\top M_tH_t\geq0. \tag{37}
$$

For any scalar estimator family in Section 1, the controller

$$
u_t=K_tz_t+H_t\widehat\mu+H_tf_t(X_1,\ldots,X_t) \tag{38}
$$

is causal and has regret exactly
$\sum_tq_t E[(f_t-\theta)^2]$. Its controls and states are square-integrable
under every admissible law, by induction in the finite horizon.

Conversely, given any admissible control policy, regard its states and
controls as measurable functions of the reconstructed disturbance history.
For a stage with $q_t>0$, define

$$
\widehat f_t=
\frac{H_t^\top M_t
 (u_t-K_tz_t-H_t\widehat\mu)}{q_t}.
$$

The $M_t$-orthogonal projection identity implies pointwise that

$$
\|u_t-K_tz_t-H_t\mu\|_{M_t}^2
\geq q_t(\widehat f_t-\theta)^2. \tag{39}
$$

Each $\widehat f_t$ is an admissible scalar history estimator. If
$q_t=0$, positive definiteness of $M_t$ implies $H_t=0$, and that
stage contributes only a nonnegative square that can be set to zero.

Equations (38) and (39) give equality of the full minimax control value
and $V_{\rm all}$ for the weights (37). The same argument identifies
the affine control value with $V_{\rm aff}$: affine disturbance-feedback
controls produce affine states and affine projected estimators; conversely,
affine estimators in (38) produce affine disturbance-feedback controls.

Therefore the all-causal ex-ante DRRO-LQR value equals its affine value
if and only if

$$
H_t=0\quad\text{for every }t\geq3. \tag{40}
$$

If some such $H_j\neq0$, inserting (20) with (29) into (38) yields the
strict improvement (30). If all $H_t=0$, both regrets are zero. If the
horizon is at most three, equality always holds. Four stages are the first
possible strict-separation horizon in this no-prehistory model.

### A concrete LQR realizing the exact example

Take scalar state, control, and disturbance, and $T=4$. At stages
$t=0,1,2$, set $A_t=B_t=0$, $\xi_t=1$, $R_t=1$, $Q_t=D_t=0$.
At stage 3 set $A_3=0$, $B_3=\xi_3=1$, $R_3=2$, $Q_3=D_3=0$,
and terminal cost $Q_4=2$. Then the cost is

$$
u_0^2+u_1^2+u_2^2+2u_3^2+2z_4^2.
$$

The first three states expose the first three disturbances. Recursion (34)
has $H_0=H_1=H_2=0$, $M_3=4$, $H_3=-1/2$, hence (37) gives
$(q_0,q_1,q_2,q_3)=(0,0,0,1)$. The known-law final controller is
$u_3=-\mu/2$. Choose $u_0=u_1=u_2=0$ and $u_3=-f_3/2$, with (31).
The regret is exactly $E[(f_3-\mu)^2]$, so (33) is also an exact LQR
separation with a gap of at least $1/24$.

## 9. Scope and credited ingredients

- The conclusion is for a scalar reused iid disturbance law and fully
  observed unconstrained finite-horizon LQR. It does not extend by assertion
  to multidimensional disturbances, partial observation, temporally drifting
  laws, stagewise adaptive adversaries, or infinite horizons.
- Positivity of both $s_0$ and $\delta$ is used. For $\delta=0$, the
  common mean is known and all regret values are zero. The $s_0=0$,
  $\delta>0$ boundary is not proved by (12)--(30); it requires a separate
  argument and is not part of the frozen initial problem.
- Square-integrability of the cubic policy is established from independence
  and distinct sample indices. Replacing $U_{j,3}$ by $\bar X_j^3$ or by
  an average of $X_i^3$ would invalidate the second-moment-only claim.
- The finite-dimensional affine reduction, convex minimax theorem, Bayesian
  conditional-mean lower bound, and U-statistic machinery are credited
  ingredients. The claimed increment is the exact full-class versus affine
  boundary under common-law moment ambiguity and a constructive uniform
  nonlinear separation, including its transfer to LQR.
- The manuscript is a research draft. Internal checks and exact finite
  computations do not replace external peer review or a proof-assistant
  kernel check. Formalization is a separate, still outstanding obligation.

## 10. General moment domains: a steep-face obstruction and critical rigidity

### 10.1. Statement and scope

Let $K\subset\mathbb R_+^2$ be nonempty, compact, and convex. Consider all Borel laws on $\mathbb R$ having finite second moment and

$$
(\mu(P)^2,v(P))\in K.
$$

The observations are iid from one common law. Retain a finite sequence of nonnegative stage weights, not all zero, and the full class of Borel estimators square-integrable under every admissible law. Assume an affine saddle with a positive moment pair $(x_*,v_*)$. Set

$$
\rho=v_*/x_*>0,\qquad
N=\max\{t\geq1:q_t>0\},\qquad
 a_t=\frac{t}{t+\rho}\quad(q_t>0),\qquad f_0=0,
$$

and

$$
A=\sum_{t\geq1}q_t\frac{t}{(t+\rho)^2}>0,
\qquad
B=q_0+\sum_{t\geq1}q_t\frac{\rho^2}{(t+\rho)^2}>0.
\tag{S1}
$$

The standard affine saddle reduction used in Sections 1--2 applies to compact convex $K$, so the optimal affine risk is $Bx+Av$. Define

$$
\beta=B/A>0,\qquad \alpha=V_{\rm aff}/A>0.
$$

Its exposed worst-moment face, which may be a point or a nontrivial segment, is

$$
F=\{(x,v)\in K:v+\beta x=\alpha\}.
\tag{S2}
$$

**Theorem S1 (steep-face obstruction).** If $N\geq3$ and $\beta>1$, then

$$
V_{\rm all}<V_{\rm aff}.
\tag{S3}
$$

No uniqueness or curvature of the exposed face is required. The conclusion includes every zero-weight pattern whose largest active observation count is at least three. The proof yields existence of a bounded continuous estimator family with a strict uniform improvement, but does not specify its coefficients or a numerical gap.

**Theorem S2 (critical-slope rigidity).** Suppose $N\geq2$, $\beta=1$, and $V_{\rm all}=V_{\rm aff}$. A least-favorable prior exists after taking the downward-variance closure described below. Every such prior for the bounded-continuous decision game is supported on the original affine exposed face. For almost every law under that prior,

$$
P(X^2=\alpha)=1.
\tag{S4}
$$

Thus equality forces a mixture of iid laws supported on the same two points $\{-\sqrt\alpha,\sqrt\alpha\}$, despite the ambiguity class containing arbitrary-support laws. This is stronger than merely exhibiting one binary least-favorable prior.

The positive-coordinate saddle hypothesis, finite horizon, iid common-law structure, and scalar observation are used. The proof does not classify the shallow-face range $0<\beta<1$.

### 10.2. Closing the law class without changing the full minimax value

Let

$$
D=\{(x,v)\in\mathbb R_+^2:\text{ there is }v'\geq v
                  \text{ with }(x,v')\in K\}.
\tag{S5}
$$

This is the downward closure in the variance coordinate only. It is compact and convex. Write $\mathcal Q_K$ and $\mathcal Q_D$ for the associated classes of laws. Set

$$
M=\sqrt{\max_{(x,v)\in K}x}>0,\qquad
C=\max_{(x,v)\in K}(x+v)<\infty.
$$

Every law in either class has $|\mu|\leq M$ and $EX^2\leq C$. Projecting any estimator output onto $[-M,M]$ decreases its squared error for every possible target mean. Hence the unrestricted minimax value of either class can be computed using bounded Borel estimators with this common range.

Fix $P\in\mathcal Q_D$, having mean $\mu$ and variance $v$, and choose $v'\geq v$ with $(\mu^2,v')\in K$. For $0<\varepsilon<1$ put

$$
b_\varepsilon=
\sqrt{v+\frac{v'-v}{\varepsilon}},\qquad
P_\varepsilon=(1-\varepsilon)P
 +\frac\varepsilon2\delta_{\mu+b_\varepsilon}
 +\frac\varepsilon2\delta_{\mu-b_\varepsilon}.
\tag{S6}
$$

This law has the same mean and variance

$$
(1-\varepsilon)v+\varepsilon b_\varepsilon^2=v'.
$$

Thus $P_\varepsilon\in\mathcal Q_K$ and its total variation distance from $P$ is at most $\varepsilon$. The product laws at stage $t$ have total variation distance at most $t\varepsilon$. For an estimator family whose outputs lie in $[-M,M]$, the squared loss lies in $[0,4M^2]$, and the means in (S6) agree exactly. Therefore

$$
|\mathcal R(f,P_\varepsilon)-\mathcal R(f,P)|
\leq4M^2\varepsilon\sum_t t q_t.
\tag{S7}
$$

It follows for each bounded family separately that

$$
\sup_{P\in\mathcal Q_K}\mathcal R(f,P)
=\sup_{P\in\mathcal Q_D}\mathcal R(f,P).
\tag{S8}
$$

Taking the infimum and using the clipping reduction gives

$$
V_{\rm all}(K)=V_{\rm all}(D).
\tag{S9}
$$

This equality does not claim continuity of the risk of unbounded estimators under total variation. Only bounded estimators are used in (S7).

### 10.3. Weak compactness and a least-favorable prior

#### 10.3.1. Weak compactness of the completed law class

Uniform second-moment boundedness makes $\mathcal Q_D$ tight. It also makes the first moments uniformly integrable:

$$
\sup_{P\in\mathcal Q_D}
 E_P[|X|\mathbf1_{\{|X|>R\}}]\leq C/R.
\tag{S10}
$$

Consequently, the mean is continuous under weak convergence inside this uniformly bounded class, by truncating the identity function and then using (S10).

To check weak closure, let $P_n\in\mathcal Q_D$ converge weakly to $P$. Lower semicontinuity of the second moment gives $E_PX^2\leq C$, and the means converge. Choose $(\mu(P_n)^2,v_n')\in K$ with $v_n'\geq v(P_n)$. Along a subsequence, compactness of $K$ gives $v_n'\to v'$ and $(\mu(P)^2,v')\in K$. The lower-semicontinuity inequality and convergence of means give

$$
v(P)\leq\liminf_n v(P_n)\leq v'.
$$

Thus $P\in\mathcal Q_D$. Tightness and weak closure prove that $\mathcal Q_D$ is a compact metric space under weak convergence. This argument permits loss of variance in the weak limit, which is exactly why the closure (S5) is used.

#### 10.3.2. The bounded-continuous decision game

Let $\mathcal F_c$ be the convex set of estimator families with each

$$
f_t\in C_b(\mathbb R^t;[-M,M]),
$$

including a constant $f_0\in[-M,M]$. For fixed $f\in\mathcal F_c$, the function $P\mapsto\mathcal R(f,P)$ is continuous on $\mathcal Q_D$: product laws converge weakly, their bounded continuous integrands converge in the relevant integral, and the means converge by (S10). Its range is bounded uniformly by $4M^2\sum_tq_t$.

Let $\Pi$ range over probability measures on the compact metric space $\mathcal Q_D$. Their weakly compact convex space is denoted $\mathfrak P(\mathcal Q_D)$. The integrated risk

$$
L(f,\Pi)=\int\mathcal R(f,P)\,d\Pi(P)
$$

is affine and continuous in $\Pi$, and is convex and continuous in $f$ in the product uniform norm. The convex minimax theorem with compact prior side therefore gives

$$
\inf_{f\in\mathcal F_c}\sup_{P\in\mathcal Q_D}\mathcal R(f,P)
=\max_{\Pi\in\mathfrak P(\mathcal Q_D)}
  \inf_{f\in\mathcal F_c}L(f,\Pi).
\tag{S11}
$$

The maximum exists: an infimum of continuous functions of $\Pi$ is upper semicontinuous on a compact set. Compactness of the decision set is not required for this form of the minimax theorem.

For each fixed prior, the inner infimum in (S11) equals the ordinary Bayes risk over all Borel estimators. Indeed, the conditional mean $h_t=E_\Pi[\mu(P)\mid X_1,\ldots,X_t]$ lies in $[-M,M]$. Bounded continuous functions are dense in $L^2$ of the marginal law of $(X_1,\ldots,X_t)$ on $\mathbb R^t$. Approximate $h_t$ in that space and project the approximations onto $[-M,M]$, which preserves continuity and does not increase approximation error. Since there are finitely many stages, this approximates the entire weighted Bayes risk. Thus

$$
\inf_{f\in\mathcal F_c}L(f,\Pi)
=\sum_tq_t E_\Pi[(h_t-\mu(P))^2].
\tag{S12}
$$

This density step is necessary: the minimax theorem alone would produce a least-favorable prior only for the continuous-rule game.

### 10.4. Consequences of hypothetical affine equality

Assume for contradiction, or for the rigidity analysis, that

$$
V_{\rm all}(K)=V_{\rm aff}(K)=V.
\tag{S13}
$$

The affine saddle rule $a_t\bar X_t$ has risk $Bx+Av\leq V$ throughout $D$, because every point of $D$ lies below a point of $K$ with the same $x$ and $A>0$. Clipping this rule coordinatewise to $[-M,M]$ gives a member of $\mathcal F_c$ with risk no greater. Conversely, $\mathcal F_c$ is a subset of the full measurable class. Equations (S9) and (S13) therefore pin the value on the left of (S11) to $V$.

For the strict-improvement assertion, the following argument needs only equality between the bounded-continuous game value in (S11) and $V_{\rm aff}$, not the stronger hypothesis (S13). Clipping already bounds that game value above by $V_{\rm aff}$. If equality held, the remaining steps would give the same contradiction at $\beta>1$. Thus the proof also establishes that the bounded-continuous game value is strictly smaller, and therefore that a bounded continuous estimator family achieves a strict improvement. No general equality between the bounded-continuous and measurable minimax values is assumed.

Choose any maximizing prior $\Pi$ in (S11). Its full Bayes risk is $V$ by (S12). The original, unbounded affine rule has finite integrated risk, bounded above by $V$, since it has finite risk at each law and $Bx+Av\leq V$ uniformly. The Bayes lower bound and this upper bound force

$$
L(a,\Pi)=V.
\tag{S14}
$$

Thus the affine rule itself is Bayes at every positive-weight stage. Also $Bx+Av=V$ for $\Pi$-almost every law. Such a point of $D$ lies in the original exposed face $F$: if $v'\geq v$ and $(x,v')\in K$, then

$$
V=Bx+Av\leq Bx+Av'\leq V,
$$

so $A>0$ forces $v'=v$. No least-favorable prior mass can remain at a strictly lowered-variance point.

At stage $N$, the strict conditional-mean decomposition of squared loss and $q_N>0$ give

$$
E_\Pi[\mu\mid X_1,\ldots,X_N]
=\frac{\sum_{i=1}^N X_i}{N+\rho}
\quad\text{almost surely}.
\tag{S15}
$$

Even if intermediate weights vanish, the tower property propagates this identity to every $0\leq n\leq N$. If $h_n=E_\Pi[\mu\mid X_1,\ldots,X_n]$, conditional iid sampling gives

$$
(N+\rho)h_n
=\sum_{i=1}^nX_i+(N-n)h_n.
$$

Hence

$$
h_n=\frac{\sum_{i=1}^nX_i}{n+\rho},
\quad 1\leq n\leq N,
\qquad E_\Pi\mu=0.
\tag{S16}
$$

Since $|h_1|\leq M$, the one-observation identity forces

$$
|X_1|\leq(\rho+1)M\quad\text{under the prior-predictive law}.
\tag{S17}
$$

Equivalently, $\Pi$-almost every constituent law has support in this fixed bounded interval. All fourth-moment calculations below are therefore justified **by hypothetical equality**, not by any additional assumption on the original ambiguity class.

### 10.5. The exact variance identity

For each constituent law write $M_r(P)=E_PX^r$. Let

$$
u=E_\Pi\mu^2,\qquad \tau=E_\Pi\mu^4.
$$

On the exposed face,

$$
M_2=v+\mu^2=\alpha-(\beta-1)\mu^2.
\tag{S18}
$$

Testing the $n=1$ posterior identity against $X_1$ gives

$$
E_\Pi M_2=(\rho+1)u,
\qquad \alpha=(\rho+\beta)u.
\tag{S19}
$$

In particular $u>0$. Testing the $n=3$ posterior identity against $X_1X_2X_3$ gives

$$
\tau=\frac3{\rho+3}E_\Pi[\mu^2M_2]
=\frac3{\rho+3}[\alpha u-(\beta-1)\tau],
$$

and therefore

$$
\tau=\frac{3\alpha u}{\rho+3\beta}.
\tag{S20}
$$

Testing the $n=1$ posterior identity against $X_1^3$ gives

$$
E_\Pi M_4=(\rho+1)E_\Pi[\mu M_3].
\tag{S21}
$$

Testing the $n=2$ posterior identity against $X_1^2X_2$ gives

$$
E_\Pi[\mu M_3]
=(\rho+2)E_\Pi[\mu^2M_2]-E_\Pi M_2^2.
\tag{S22}
$$

Combining the last two equations,

$$
E_\Pi\operatorname{Var}_P(X^2)
=(\rho+2)\bigl[(\rho+1)E_\Pi(\mu^2M_2)-E_\Pi M_2^2\bigr].
\tag{S23}
$$

For clarity, the two expectations on the right are

$$
E_\Pi(\mu^2M_2)=\alpha u-(\beta-1)\tau,
$$

$$
E_\Pi M_2^2
=\alpha^2-2\alpha(\beta-1)u+(\beta-1)^2\tau.
$$

Substitution of (S19) and (S20) yields the exact identity

$$
\boxed{\quad
E_\Pi\operatorname{Var}_P(X^2)
=-\frac{2\rho(\rho+2)(\beta-1)(\rho+\beta)}{\rho+3\beta}\,u^2.
\quad}
\tag{S24}
$$

Every term on the left is nonnegative. If $\beta>1$, the right side is strictly negative. This contradicts (S13) and proves Theorem S1.

At $\beta=1$, the rigidity conclusion already follows for $N\geq2$, without using the $n=3$ calculation or (S20). Equations (S18) and (S19) give $M_2=\alpha$ and $u=\alpha/(\rho+1)$. Substitution directly into (S23), which uses only the one- and two-observation posterior identities, gives $E_\Pi\operatorname{Var}_P(X^2)=(\rho+2)[(\rho+1)\alpha u-\alpha^2]=0$. Nonnegativity then implies $\operatorname{Var}_P(X^2)=0$ for $\Pi$-almost every constituent law. Its second moment is $M_2=\alpha$, so $X^2=\alpha$ almost surely. This proves Theorem S2.

For $\beta=2$, $\rho=1$, and $\alpha=1$, (S19) gives $u=1/3$ and (S24) becomes $E_\Pi\operatorname{Var}_P(X^2)=-2/7$. This is an exact contradiction certificate, not an asserted variance of an actual prior.

### 10.6. Critical-slope moment necessity and the balanced-face equivalence

For $\beta=1$, the exposed face is $(x,v)=(\alpha z,\alpha(1-z))$, with $z$ ranging over a compact interval $[l,u]$. Under hypothetical equality, (S18) gives $M_2=\alpha$ for each prior law. For every $1\leq r\leq N$, multiply the $r$-observation posterior identity in (S16) by the distinct-sample product $X_1\cdots X_r$ and take expectation. Conditional independence gives

$$
E_\Pi\mu^{r+1}
=\frac{r\alpha}{\rho+r}E_\Pi\mu^{r-1}.
\tag{S25}
$$

These mixed-product expectations are already finite from the uniform second-moment bound; the stronger bounded-support conclusion (S17) also suffices. Starting with $E\mu^0=1$ and $E\mu=0$, recurrence (S25) determines all moments through degree $N+1$. In particular, the distribution of $Z=\mu^2/\alpha$ under the least-favorable prior is supported on $[l,u]$ and satisfies

$$
E Z^k=\frac{(1/2)_k}{((\rho+1)/2)_k},
\qquad 0\leq k\leq\left\lfloor\frac{N+1}{2}\right\rfloor.
\tag{S26}
$$

Thus the finite beta-moment representability condition in Section 11 is **necessary for equality in the full arbitrary-support law class**. Its already-proved Bayes construction is sufficient. Together they give the complete balanced-face criterion.

For $N=1$ or $N=2$, the same argument establishing (S11)–(S19) and the recurrence through $r=N$ still applies, so moment necessity remains valid; the separate short proof of rigidity above also covers $N=2$, while no rigidity claim is made for $N=1$. In those short-history cases only the first moment of $Z$ is required.

### 10.7. The two-observation rigidity threshold is sharp

At one observation, binary support need not follow even when $\beta=1$.
Take $q_1=1$, all other weights zero, and $K=\{(1/2,1/2)\}$.
The affine rule $f_1=X_1/2$ has $A=B=1/4$ and worst risk $1/4$.
Put equal prior probabilities on

$$
P_+=\tfrac12\delta_0+\tfrac12\delta_{\sqrt2},\qquad
P_-=\tfrac12\delta_0+\tfrac12\delta_{-\sqrt2}.
$$

Their means are $\pm1/\sqrt2$ and their variances are $1/2$.
The posterior mean is zero at observation zero and $X_1/2$ at the
other two observations. Thus the affine rule is Bayes and both minimax
values equal $1/4$. However, $X^2$ takes the values zero and two under
each prior law, rather than being identically one. This proves that the
$N\ge2$ threshold in Theorem S2 cannot be reduced to one.

## 11. An exact full-class criterion on the critical face

### 11.1. Setting and assumptions

Let $K\subset\mathbb R_+^2$ be nonempty, compact and convex. The distribution
class consists of **all** Borel laws with finite second moment and
$(\mu^2,v)\in K$, reused iid. The policy class, loss and nonnegative finite
weight sequence are as in Section 1. An affine saddle exists by the
same symmetrization and compact minimax argument. Assume it has

$$
a_t=\frac{t}{t+\rho}\quad(t\in I),\qquad \rho>0,
\qquad A=B>0.
$$

This is a verifiable assumption about the already solved affine problem,
not an assumed all-class minimax conclusion. For example, it follows from
a saddle with positive dual moments $(x_*,v_*)$, $\rho=v_*/x_*$, and
$A=B$. Put $N=\max I$, $d=\lfloor(N+1)/2\rfloor$ and

$$
c^2=\max_{(x,v)\in K}(x+v)>0,
\qquad E=\{(x,v)\in K:x+v=c^2\}.
$$

Convexity and compactness imply
$E=\{(c^2z,c^2(1-z)):l\le z\le u\}$ for some $0\le l\le u\le1$.
The affine value is $V=A c^2$. All definitions retain zero weights and $q_0$.

### 11.2. Exact criterion

Define $m_0=1$ and

$$
m_k=\frac{(1/2)_k}{((\rho+1)/2)_k}
\quad(1\le k\le d),
$$

the first $d$ moments of a $\operatorname{Beta}(1/2,\rho/2)$ variable.
Then

$$
V_{\rm all}=V_{\rm aff}
\iff \text{there is a probability measure $\nu$ on $[l,u]$ with}
\int z^k\,d\nu=m_k\quad(0\le k\le d).
\tag{F1}
$$

If the moment system is infeasible, a finite odd multilinear correction
at stage $N$ strictly improves the worst risk over **all** laws in the
whole $K$, not merely over distributions whose moments lie on the face.
If it is feasible, a prior on at most $2(d+1)$ binary laws supplies a
matching lower bound against every measurable policy.

#### 11.2.1. Classical finite Hausdorff matrix test

For a generic vector $m=(m_0,\ldots,m_d)$ with $m_0=1$, define

$$
H_r(m)=[m_{i+j}]_{i,j=0}^r,
\qquad
H_r^{(1)}(m)=[m_{i+j+1}]_{i,j=0}^r.
$$

Assume first $l<u$. The classical truncated Hausdorff theorem gives the following necessary and sufficient conditions for the moment condition in (F1).

If $d=2r$ is even, the conditions are

$$
H_r(m)\succeq0,
\qquad
D_{r-1}(m;l,u):=
[(l+u)m_{i+j+1}-m_{i+j+2}-lu\,m_{i+j}]_{i,j=0}^{r-1}
\succeq0.
\tag{G10}
$$

The second condition is vacuous for $r=0$.

If $d=2r+1$ is odd, the conditions are

$$
H_r^{(1)}(m)-lH_r(m)\succeq0,
\qquad
u H_r(m)-H_r^{(1)}(m)\succeq0.
\tag{G11}
$$

No additional rank or range condition is required in (G11) when these two-sided interval conditions are used. Their sum is $(u-l)H_r$, so positivity of $H_r$ follows automatically.

For a singleton interval $l=u$, use the direct condition

$$
m_k=l^k\quad(k=0,\ldots,d).
\tag{G12}
$$

**Why the test is sufficient.**

Necessity is immediate by integrating squares, or squares multiplied by $z-l$, $u-z$, or $(z-l)(u-z)$. For sufficiency, the degree-bounded Markov–Lukács representation expresses every polynomial nonnegative on $[l,u]$ and of degree at most $2r$ as a sum of squares of degree at most $2r$ plus $(z-l)(u-z)$ times a sum of squares of degree at most $2r-2$. At odd degree at most $2r+1$, it uses $(z-l)$ and $(u-z)$ times sums of squares of degree at most $2r$.

Thus (G10) or (G11) makes the moment functional $\Lambda_m$ nonnegative on every nonnegative polynomial in the relevant degree range. If the vector $(m_1,\ldots,m_d)$ were outside the compact convex hull of $z\mapsto(z,\ldots,z^d)$, finite-dimensional strict separation would give a polynomial nonnegative on $[l,u]$ with negative $\Lambda_m$ value, a contradiction. A representing measure therefore exists.

The interval matrix test and degree-bounded representation are credited classical ingredients. Curto and Fialkow [R13], Section 4, Theorems 4.1 and 4.3 with Remarks 4.2 and 4.4, explicitly records the odd and even characterizations. The degree-bounded positive-polynomial representation is used as a classical theorem, not an additional originality claim.

#### 11.2.2. From a failed matrix to a descent polynomial

The following construction supplies the direction used in Sections 11.4--11.5. Uniform descent on the face must still be extended to all of $K$.

Let $\Lambda_m(z^k)=m_k$, with the beta moments in Section 11.2, and set

$$
g_k(z)=(2k+1)z^k-(\rho+2k+1)z^{k+1},
\qquad k=0,\ldots,d-1.
\tag{G13}
$$

The recurrence in Section 11.2 implies $\Lambda_m(g_k)=0$. These $d$ polynomials are linearly independent because their nonzero leading terms have distinct degrees $1,\ldots,d$. Hence they form a basis of the kernel of $\Lambda_m$ in polynomials of degree at most $d$.

If a matrix in (G10) or (G11) has a certified negative quadratic form, one obtains a polynomial $p$ of degree at most $d$ satisfying

$$
p(z)\geq0\quad(l\leq z\leq u),\qquad
\Lambda_m(p)<0.
\tag{G14}
$$

Specifically, writing $h(z)$ for the polynomial with coefficients from the negative quadratic-form vector, use $p=h^2$ for a failed $H_r$; $p=(z-l)(u-z)h^2$ for a failed even localizing matrix; and $p=(z-l)h^2$ or $p=(u-z)h^2$ for the respective failed odd matrix. For the beta vector, every $H_r$ is actually positive definite, because its quadratic form integrates a nonzero squared polynomial against a density positive on $(0,1)$; only the support restrictions can fail.

Let $\eta=-\Lambda_m(p)>0$. There are unique coefficients $\lambda_k$ such that

$$
p(z)+\eta=\sum_{k=0}^{d-1}\lambda_k g_k(z)\geq\eta
\quad(l\leq z\leq u).
\tag{G15}
$$

For $p(z)=\sum_{k=0}^d p_kz^k$, with zero padding if needed, they are computable by backward substitution:

$$
\lambda_{d-1}=-\frac{p_d}{\rho+2d-1},\qquad
\lambda_k=
\frac{(2k+3)\lambda_{k+1}-p_{k+1}}{\rho+2k+1},
\quad k=d-2,\ldots,0.
\tag{G16}
$$

Matching the nonconstant coefficients gives this recurrence; the constant coefficient then agrees because both sides of the identity in (G15) have zero $\Lambda_m$ value.

If $l=u$ and (G12) fails, choose a $k$ with $m_k\ne l^k$ and take $p(z)=\sigma(z^k-l^k)$, with $\sigma\in\{-1,1\}$ chosen so $\Lambda_m(p)<0$. It vanishes on the singleton and gives the same construction.


### 11.3. Feasibility gives an all-estimator Bayes lower bound

Choose $Z\sim\nu$ and an independent symmetric sign, and put
$\Theta=\pm c\sqrt Z$. Given $\Theta=\theta$, let $P_\theta$ be the law on
$\{-c,c\}$ with $P_\theta(c)=(1+\theta/c)/2$. Every such law lies in
the original class, since its moments are exactly
$(\theta^2,c^2-\theta^2)\in E$.

Put $Y_i=X_i/c$ and $R=\Theta/c$. The finite-moment posterior mechanism is classical [R11, Section 4]. Under the ordinary centered beta prior
$p=(1+R)/2\sim\operatorname{Beta}(\rho/2,\rho/2)$, conjugacy gives

$$
E[\Theta\mid Y_1,\ldots,Y_n]
=\frac{c\sum_iY_i}{n+\rho}
=a_n\bar X_n.
\tag{F2}
$$

Under the constructed symmetric prior, moments of $R$ through degree
$N+1$ agree with that beta prior: odd moments vanish and even moments
are $m_k$. For any particular binary history, its likelihood is a
polynomial in $R$ of degree $n$, while the posterior numerator is of
degree $n+1$. Thus its probability and numerator agree with the ordinary
beta prior for all $n\le N$. The beta prior assigns positive probability
to every such history, so the denominator is nonzero and (F2) follows.
The no-observation posterior is zero. Therefore the affine saddle is a
Bayes rule at every positively weighted stage. Its risk under every
law in the prior equals $Ac^2$. The usual prior-average lower bound
proves $V_{\rm all}\ge Ac^2$, and class inclusion proves equality.

Only finitely many moments are specified. The moment vector belongs to
the convex hull of $(z,z^2,\ldots,z^d)$, $z\in[l,u]$. Caratheodory's
theorem therefore permits $\nu$ with at most $d+1$ atoms, giving the
stated finite prior bound. This is a support bound, not a claim that
the entire beta prior lies in the constrained face.

### 11.4. Infeasibility produces an explicit direction

For $k=0,\ldots,d-1$, define

$$
\gamma_k(z)=z^k\big[(2k+1)-(\rho+2k+1)z\big].
$$

The origin belongs to
$\operatorname{conv}\{\gamma(z):z\in[l,u]\}$ exactly when there is a
probability measure on this interval satisfying

$$
(\rho+2k+1)\int z^{k+1}\,d\nu
=(2k+1)\int z^k\,d\nu \quad(0\le k<d).
$$

Starting at moment zero, these recurrences are precisely the moments
in (F1). Thus infeasibility of (F1) is equivalent to excluding the
origin from that compact convex hull. Strict separation gives a
vector $b\in\mathbb R^d$ and $\eta>0$ such that
$b\cdot\gamma(z)\ge\eta$ for every $z\in[l,u]$.

The matrix construction in Section 11.2.2 provides such a vector directly by taking $b_k=\lambda_k$.

For $1\le r\le N$, let

$$
U_{N,r}=\binom Nr^{-1}\sum_{|S|=r}\prod_{i\in S}X_i.
$$

Independence gives, without any higher single-observation moment,

$$
E U_{N,r}=\mu^r,\quad
E[\bar X_NU_{N,r}]=\mu^{r+1}+\frac rN v\mu^{r-1},\quad
E U_{N,r}^2\le (x+v)^r\le c^{2r}.
\tag{F3}
$$

Set

$$
W=\sum_{k=0}^{d-1} b_k c^{-2k}U_{N,2k+1},
\qquad f_N^\epsilon=a_N\bar X_N-\epsilon W.
$$

All other rules are unchanged. Write $a=a_N$, $q=q_N>0$, and

$$
C(x,v)=q E[(a\bar X_N-\mu)W].
$$

Because $1-a=a\rho/N$, (F3) shows that on $E$

$$
C(c^2z,c^2(1-z))
=\frac{qa c^2}{N}\,b\cdot\gamma(z)
\ge\kappa:=\frac{qa c^2\eta}{N}>0.
\tag{F4}
$$

The exact risk identity on all $K$ is

$$
R_\epsilon(x,v)=A(x+v)-2\epsilon C(x,v)
 +\epsilon^2 qE W^2.
\tag{F5}
$$

Here $C$ is a polynomial in $x,v$. Minkowski's $L^2$ inequality gives

$$
qE W^2\le W_0:=q c^2\|b\|_1^2,
\qquad |C(x,v)|\le D_0:=q c^2\|b\|_1.
\tag{F6}
$$

For the latter, the stage affine mean-square error is at most $c^2$,
since $(1-a)^2x+a^2v/N\le x+v\le c^2$.

### 11.5. A uniform step controls all off-face moments

Let $F=\{(x,v)\in K:C(x,v)\le\kappa/2\}$.
If $F$ is nonempty, compactness, (F4), and the defining exposed face imply

$$
h:=\min_F A(c^2-x-v)>0.
$$

Choose

$$
0<\epsilon\le
\min\left\{\frac{\kappa}{2W_0},
            \frac{h}{8D_0},\sqrt{\frac{h}{4W_0}}\right\}.
\tag{F7}
$$

Outside $F$, (F5) gives $R_\epsilon\le V-\epsilon\kappa/2$.
On $F$, (F5)--(F7) give $R_\epsilon\le V-h/2$.
Thus the uniform strict gap is at least
$\min\{\epsilon\kappa/2,h/2\}>0$. If $F$ is empty, only the first
bound in (F7) is needed, and the gap is at least $\epsilon\kappa/2$.
This closes the necessity direction of (F1) for the unrestricted policy
class, rather than merely giving a stationary condition in a polynomial class.

The constants are defined entirely by the solved affine game, a finite
separating polynomial, and a compact polynomial minimization over $K$.
For an explicitly semialgebraic $K$ they provide a finite algebraic
certificate problem. No claim of efficient polynomial-time computation
for an arbitrary encoded $K$ is made.

### 11.6. The first nontrivial criterion and an exact obstruction

For $N=3$ or $N=4$, $d=2$. Put

$$
m=\frac1{\rho+1},\qquad
\sigma_Z^2=\frac{2\rho}{(\rho+1)^2(\rho+3)}.
$$

The moment condition is equivalent to

$$
l\le m\le u,\qquad (m-l)(u-m)\ge\sigma_Z^2.
\tag{F8}
$$

Necessity follows by integrating $(Z-l)(u-Z)\ge0$.
For sufficiency, if $u>l$ the distribution on endpoints with mean $m$
has variance $(m-l)(u-m)$; mixing it with the atom at $m$ realizes
any variance between zero and that value without changing the mean.
The case $u=l$ cannot satisfy (F8), because $\rho>0$ gives positive variance.

For an exact example, set $q_0=1/8$,
$q_3=1$, all other weights zero, $\rho=1$, and

$$
l=(2-\sqrt2)/4,\qquad u=(2+\sqrt2)/4,
\qquad
K=\{x,v\ge0:x\le u,\ v\le1-l,\ x+v\le1\}.
$$

The rule $f_0=0$, $f_3=(X_1+X_2+X_3)/4$ has $A=B=3/16$.
On the face, $m=1/2$ and $(m-l)(u-m)=1/8=\sigma_Z^2$.
The four laws with support $\{-1,1\}$ and means
$\pm\sqrt l,\pm\sqrt u$, each with prior probability $1/4$,
give a matching all-class Bayes lower bound. Hence both values are $3/16$,
although the entire worst face has $x,v>0$ and a three-sample stage is active.
Replacing this interval by a symmetric narrower interval around $1/2$
keeps the same affine saddle but violates (F8), so a nonlinear rule
strictly improves it. Face width is therefore a real statistical obstruction.

## 12. A limitation of every multiaffine correction and sharp examples

### Triangular moment sets

Let $\alpha,\beta>0$ and

$$
K_{\alpha,\beta}=\{(x,v)\in\mathbb R_+^2:\beta x+v\le\alpha\}.
$$

Assume $I=\{t\ge1:q_t>0\}$ is nonempty and

$$
q_0<\beta\sum_{t\in I}\frac{q_t}{t}.
\tag{B1}
$$

There is a unique $\rho>0$ solving

$$
\Psi(\rho)=q_0+\sum_{t\in I}q_t\frac{\rho^2-\beta t}{(t+\rho)^2}=0.
\tag{B2}
$$

Indeed $\Psi(0)<0$, its limit at infinity is $q_0+\sum q_t>0$, and
each summand has derivative $2q_t t(\rho+\beta)/(t+\rho)^3>0$.
Set $a_t=t/(t+\rho)$ and
$A=\sum q_t t/(t+\rho)^2$. Equation (B2) is $B=\beta A$.
The affine risk is $A(\beta x+v)$, with maximum $A\alpha$.
At $x_*=\alpha/(\beta+\rho)$, $v_*=\rho x_*$, these coefficients
minimize the fixed-moment affine risk stage by stage. Therefore this
is an affine saddle, $V_{\rm aff}=A\alpha$, with positive dual moments.

### All multiaffine polynomials have the same minimax value

A multiaffine rule is a polynomial in the observations in which each
individual observation has degree at most one. There is no restriction
to cubic degree. Since the horizon is finite, such a rule is automatically
square-integrable under every law in the moment class. Denote the minimax
value of families of these rules by $V_{\rm multi}$.

Choose

$$
Z\sim\operatorname{Beta}(1/2,\rho/(2\beta)),\quad
x=\frac{\alpha}{\beta}Z,\quad v=\alpha-\beta x,
\quad\mu=\pm\sqrt x
$$

with an independent symmetric sign. For each $(\mu,v)$ choose the
two-point law giving mass one-half to $\mu-\sqrt v$ and $\mu+\sqrt v$.
This defines an actual prior over admissible iid laws; all have moments
on the exposed face. The choice of these realizing laws does not assert
that the affine rule is Bayes among arbitrary estimators.

For every integer $k\ge0$, the beta moment recurrence gives

$$
[(2k+1)\beta+\rho]E x^{k+1}
=(2k+1)\alpha E x^k.
\tag{B3}
$$

For a fixed stage $t$ and a distinct-sample monomial of odd degree
$r=2k+1\le t$, independence gives the prior-averaged cross moment

$$
E[(a_t\bar X_t-\mu)\prod_{i\in S}X_i]
=\frac{a_t}{t} E\{x^k[r\alpha-(r\beta+\rho)x]\}=0.
\tag{B4}
$$

Even-degree monomials, including the constant, have zero cross moment
by reflection symmetry. Thus the affine error is orthogonal in the
prior-predictive $L^2$ space to **every** multiaffine perturbation,
including nonsymmetric ones. Expanding squared loss proves that this
affine rule minimizes the prior-averaged loss in the entire multiaffine
class, separately at every positive-weight stage. The no-observation
rule zero is optimal by prior symmetry. Its average loss is $A\alpha$.
Consequently

$$
V_{\rm multi}=V_{\rm aff}=A\alpha.
\tag{B5}
$$

For $\beta>1$ and $\max I\ge3$, the steep-face theorem nevertheless gives

$$
V_{\rm all}<V_{\rm multi}=V_{\rm aff}.
\tag{B6}
$$

This is an exact obstruction to solving the general distribution-free
problem merely by adding more distinct-sample polynomial terms. It does
not contradict the shifted-disk result, whose unique exposed point allows
a cubic descent. The policies guaranteed by (B6) can be chosen bounded
and continuous, but this argument does not provide a closed formula or
a numerical value for their optimum.

### An exact nonvacuous instance

Take $\alpha=1$, $\beta=2$, $q_0=5/16$, $q_3=1$, all other weights zero.
Then $\rho=1$, $a_3=3/4$, $A=3/16$, $B=3/8$ and

$$
V_{\rm all}<\frac3{16}=V_{\rm multi}=V_{\rm aff}.
\tag{B7}
$$

If an all-class least-favorable prior made the affine rule Bayes, the
steep-face identity would require
$E_\pi\operatorname{Var}_P(X^2)=-2/7$, contradicting nonnegativity.
The multiaffine lower-bound prior instead uses
$Z\sim\operatorname{Beta}(1/2,1/4)$ and is not a full-class Bayes certificate.

### Degenerate weight branch

If (B1) fails, choose $a_t=1$. Then $A=\sum q_t/t$, $B=q_0\ge\beta A$,
and the worst affine risk is $q_0\alpha/\beta$. The two deterministic
laws with means $\pm\sqrt{\alpha/\beta}$ give a matching lower bound
from the no-observation stage alone. Therefore
$V_{\rm all}=V_{\rm aff}=q_0\alpha/\beta$ in this branch, even when
$\beta>1$ and later weights are positive. This illustrates why the
positive-dual-variance hypothesis in the steep-face theorem is essential.

### Sharpness on the other side of the critical slope

For $\beta=1/m$ with an integer $m\ge1$, the full triangular face also
has an all-class Bayes certificate in the nondegenerate branch (B1).
Let $c=\sqrt{\alpha/\beta}$ and, conditional on $p$, draw
$Y\sim\operatorname{Binomial}(m,p)$ and set $X=c(2Y/m-1)$.
Then $\mu=c(2p-1)$ and $v=\alpha-\beta\mu^2$.
The prior $p\sim\operatorname{Beta}(m\rho/2,m\rho/2)$ gives
$E[\mu\mid X_1,\ldots,X_t]=\sum_iX_i/(t+\rho)$ at every finite stage.
It therefore proves $V_{\rm all}=V_{\rm aff}$ for these triangles.
This is a classical beta-binomial construction, included to delimit the
new obstruction. No classification for every $0<\beta<1$ is asserted.

### An explicit improving rule when the critical face is too narrow

To make the critical-face algorithm concrete, take $q_0=1/8$, $q_3=1$,
$\rho=1$ and

$$
K=\{x,v\ge0:x\le3/4,\ v\le3/4,\ x+v\le1\}.
$$

The affine saddle is $a_3=3/4$, $A=B=3/16$, with face
$z=x\in[1/4,3/4]$. Its required beta moments are $m_1=1/2$, $m_2=3/8$.
The localizing polynomial
$p(z)=(z-1/4)(3/4-z)$ has beta expectation $-1/16$, so the moment
criterion fails. With $g_0=1-2z$, $g_1=3z-4z^2$,

$$
p(z)+1/16=-g_0(z)/8+g_1(z)/4\ge1/16
\quad(1/4\le z\le3/4).
$$

Use $W=-U_{3,1}/8+U_{3,3}/4$ and $\epsilon=1/16$. The resulting rule is

$$
f_0=0,\qquad
f_3=\frac{97}{128}\bar X_3-\frac1{64}X_1X_2X_3.
\tag{B8}
$$

Its cross term is
$C=(x-v)/32+(3xv-x^2)/16$. On the face, $C\ge1/64$.
Every point of $K$ can be moved coordinatewise upwards to the face with
total coordinate change $1-x-v$. On the rectangle $[0,3/4]^2$,
$|C_x|\le11/64$ and $|C_v|\le7/64$, so

$$
C(x,v)\ge\frac1{64}-\frac{11}{64}(1-x-v),
\qquad EW^2\le(1/8+1/4)^2=9/64.
$$

Expanding the risk and using the affine deficit gives

$$
\sup_{P:(\mu^2,v)\in K}\mathcal R(f,P)
\le\frac3{16}-\frac{\epsilon}{32}+\frac{9\epsilon^2}{64}
=\frac{3049}{16384}<\frac3{16},
\tag{B9}
$$

since $3/16-11\epsilon/32>0$. The certified improvement is
$23/16384$. This is a uniform continuous-domain bound requiring only
second moments, not a finite-distribution numerical optimization.

## 13. What the extended results settle

The original shifted-disk problem is solved under all of its frozen
quantifiers. Its original explicit cubic certificate remains useful even
though the general steep-face theorem gives another existence proof.
The extension permits nonunique exposed moment faces, identifies the
critical-slope least-favorable experiment, and gives an exact finite test
and an admissible correction on that critical face. It also proves a strict
gap between all measurable rules and the entire multiaffine polynomial class
in specified triangular models.

The steep-face existence proof does not identify an optimal nonlinear rule
or quantify its gap. General shallow faces with $0<\beta<1$ remain outside
the classification. Neither the original result nor the extension is a
claim about vector-valued disturbances, time-varying laws, partial
observation, or infinite horizons. In the LQR interpretation, the assumptions
of reconstructible scalar noise and positive Bellman control Hessians remain
in force. The same statistical weights transfer the geometric results
through the already credited control identity.

The accompanying exact programs check algebraic identities, finite Bayes
experiments and explicit polynomial certificates. They do not verify
measure-theoretic compactness or act as a proof-assistant kernel. No Lean
source or completed formalization is asserted in this paper. The initial
manuscript and its independent value review are retained as provenance;
they are not replaced by the secondary-round findings.

## References

[R1] L.-B. Fiechtner and J. Blanchet. *Distributionally Robust Regret Optimal
LQR with Common Stage-Law Ambiguity*. arXiv:2604.06158v3, 23 September 2026.
[Official full text](https://arxiv.org/html/2604.06158v3).

[R2] L.-B. Fiechtner and J. Blanchet. *Regret-Optimal Linear-Quadratic Control
under Distributional Drift*. arXiv:2610.09220v1, 6 October 2026.
[Official full text](https://arxiv.org/html/2610.09220v1).

[R3] Y. C. Eldar and N. Merhav. *A Competitive Minimax Approach to Robust
Estimation of Random Parameters*. IEEE Transactions on Signal Processing
52(7), 1931--1946, 2004. [DOI](https://doi.org/10.1109/TSP.2004.828931).
[Author-hosted published text](https://www.weizmann.ac.il/math/yonina/sites/math.yonina/files/A%20Competitive%20Minimax%20Approach.pdf).

[R4] E. Marchand, F. Perron and R. Gueye. *Minimax Estimation of a Binomial
Proportion p When |p-1/2| Is Bounded*.
[Authors' report](https://www.usherbrooke.ca/mathematiques/fileadmin/sites/mathematiques/documents/Recherche/Publications/Rapports_de_recherche/rr13.pdf).

[R5] W. Hoeffding. *A Class of Statistics with Asymptotically Normal
Distribution*. Annals of Mathematical Statistics 19, 293--325, 1948.
[DOI](https://doi.org/10.1214/aoms/1177730196).

[R6] K. H. Schlag. *How to Attain Minimax Risk with Applications to
Distribution-Free Nonparametric Estimation and Testing*. Author manuscript,
12 March 2007.
[Full text](https://homepage.univie.ac.at/karl.schlag/research/statistics/MinimaxRisk.pdf).

[R7] R. Dykstra. *Minimax Estimation of a Mean Vector for Distributions on
a Compact Set*. ASTIN Bulletin 20(2), 1990.
[DOI](https://doi.org/10.2143/AST.20.2.2005440).
[Society-hosted full text](https://www.casact.org/sites/default/files/database/astin_vol20no2_173.pdf).

[R8] V. A. Nguyen, S. Shafieezadeh-Abadeh, D. Kuhn and P. Mohajerin Esfahani.
*Bridging Bayesian and Minimax Mean Square Error Estimation via Wasserstein
Distributionally Robust Optimization*. Mathematics of Operations Research
48(1), 1--37, 2023. [DOI](https://doi.org/10.1287/moor.2021.1176).

[R9] J. Nylöf, D. Kuhn, J. Lygeros and G. Ferrari-Trecate. *Optimality of
Affine Policies in Distributionally Robust Linear-Quadratic Control with
Temporally Correlated Noise*. arXiv:2609.27653, 2026.
[Official abstract](https://arxiv.org/abs/2609.27653). Abstract-only comparison.

[R10] M. Sion. *On General Minimax Theorems*. Pacific Journal of Mathematics
8, 171--176, 1958.
[Original article](https://msp.org/pjm/1958/8-1/pjm-v8-n1-p14-s.pdf).

[R11] P. Diaconis and D. Ylvisaker. *Conjugate Priors for Exponential
Families*. Annals of Statistics 7(2), 269--281, 1979.
[DOI](https://doi.org/10.1214/aos/1176344611).
[Full text](https://www.cs.columbia.edu/~blei/fogm/2020F/readings/DiaconisYlvisaker1979.pdf).
Section 4 explicitly discusses finite-sample moment matching.

[R12] S. E. Fienberg. *Linear and Quasi-Linear Bayes Estimators*.
University of Minnesota technical report, 1978.
[Institutional full text](https://conservancy.umn.edu/bitstreams/28187e28-ffbc-445e-a300-79ddada5d54d/download).
The linear Bayes shrinkage and prior-moment method are credited background.

[R13] R. E. Curto and L. A. Fialkow. *Recursiveness, Positivity, and
Truncated Moment Problems*. Houston Journal of Mathematics 17(4),
603--635, 1991.
[Original journal text](https://hjm.math.uzh.ch/v017n4/0603CURTO.pdf).
Section 4 supplies the classical interval-moment tests used here.

[R14] J. J. A. Moors. *Momentproblems and Truncated Binomial Estimation*.
Research memorandum, 1979.
[Institutional PDF](https://pure.uvt.nl/ws/portalfiles/portal/1177620/MJJA5615795.pdf).
The audit used indexed original-text passages; complete direct retrieval
was unavailable. No unread result is a necessary step in the proofs above.
