# Exact zCDP of k-ary randomized response

*The complete phase diagram, a unique-root formula, and a sharp large-alphabet asymptotic*

AI-assisted research draft

24 November 2026

# Abstract

Harrison and Manurangsi established exact zero-concentrated differential
privacy (zCDP) parameters for $k$-ary randomized response when $k\le6$,
identified a local obstruction for larger $k$, and left its precise
large-alphabet characterization open. We give a global characterization
for every integer $k\ge2$ and every privacy parameter $\varepsilon\ge0$.
Their local threshold is also the exact global phase boundary. Below or
at that threshold, the optimal Rényi order is the limit $\alpha\downarrow1$.
Above it, there is exactly one maximizing order $\alpha_\star>1$, determined
by a scalar equation with an explicit finite bracket. The proof writes
the zCDP objective as an anchored secant slope of
$x\mapsto\log(c+\cosh\sqrt{x})$ and establishes its single change of
curvature. For each fixed $\varepsilon>0$, we also prove
$\rho_k(\varepsilon)\sim\varepsilon^2/(4\log k)$ and
$\alpha_\star\sim2\log k/\varepsilon$, with a more accurate analytic
approximation and a remainder bound. A short extension covers
two swapped probabilities with arbitrary common remaining mass. The
high-privacy limit connects to the existing optimal sub-Gaussian proxy
problem for symmetric three-point distributions; that limiting problem
is not claimed as new. The characterization is exact and implicit; no
elementary closed form for the interior maximizing order is asserted.

**Keywords:** concentrated differential privacy; randomized response;
Rényi divergence; privacy accounting; unimodality; sub-Gaussian proxy.

**Status:** AI-assisted research manuscript; external peer review pending.

# 1. Problem and relation to previous work

For an integer $k\ge2$, the $k$-ary randomized response mechanism
$\operatorname{RR}_{k,\varepsilon}$ takes a symbol in $\{1,\ldots,k\}$,
returns it with probability

$$
p=\frac{e^\varepsilon}{e^\varepsilon+k-1},
$$

and returns each other symbol with probability

$$
q=\frac1{e^\varepsilon+k-1}.
$$

Its tight zCDP parameter is

$$
\rho_k(\varepsilon)
=\sup_{\alpha>1}\frac{D_\alpha(P\Vert Q)}{\alpha},
\tag{1}
$$

where $P$ and $Q$ are the output laws for any two distinct inputs. Every
ordered pair of distinct inputs gives the same divergence. Equal inputs
give zero. Thus (1) is the mechanism's exact privacy parameter, rather
than an upper bound obtained from a particular neighboring pair.

Harrison and Manurangsi [HM26, Proposition 20] give the exact Rényi curve.
Their Theorem 16 proves

$$
\rho_k(\varepsilon)
=\frac{\varepsilon(e^\varepsilon-1)}{e^\varepsilon+k-1}
\quad\text{for }2\le k\le6.
\tag{2}
$$

Their Lemma 17 supplies an explicit threshold $K(\varepsilon)$ such that
(2) fails whenever $k>K(\varepsilon)$. Their Theorem 19 gives a non-tight
large-$k$ bound, and the conclusion asks for a precise characterization
in that regime. We retain their threshold formula and prove its
**global sufficiency**, together with uniqueness and a finite-bracket
description of the interior optimizer. The formula for the threshold
itself is not a new result of this manuscript.

The obstruction is global in the Rényi order. At fixed positive
$\varepsilon$, the KL limit in (2) is of order $k^{-1}$, whereas the true
zCDP parameter will be shown to be of order $(\log k)^{-1}$. Optimizing
only near order one therefore misses the controlling part of the
privacy-loss moment curve.

The main theorem concerns a specified finite-output mechanism and a
one-dimensional optimization over all real Rényi orders. It does not
address every differentially private mechanism or establish an
elementary formula for the interior optimizer. The necessary
global shape result is supplied by the squared-order change of
variable below.

# 2. Exact reduction to a secant slope

All logarithms are natural. For distributions with common finite
support, the Rényi divergence of order $\alpha>1$ is

$$
D_\alpha(P\Vert Q)
=\frac1{\alpha-1}\log\sum_y P(y)^\alpha Q(y)^{1-\alpha}.
$$

For the two randomized-response laws, only two probabilities are
interchanged. Direct substitution, also recorded in [HM26, Proposition
20], gives

$$
D_\alpha(P\Vert Q)
=\frac1{\alpha-1}
 \log\frac{e^{\alpha\varepsilon}+e^{(1-\alpha)\varepsilon}+k-2}
               {e^\varepsilon+k-1}.
\tag{3}
$$

If $\varepsilon=0$, the mechanism is independent of its input and
$\rho_k(0)=0$. Every Rényi order gives zero, so no unique optimizing
order is distinguished. Henceforth assume $\varepsilon>0$ and set

$$
a=\frac\varepsilon2,
\qquad c=\frac{k-2}{2e^a},
\qquad t=\varepsilon\left(\alpha-\frac12\right)>a.
\tag{4}
$$

Define

$$
F_c(x)=\log(c+\cosh\sqrt{x}),\qquad x>0,
$$

$$
N(t)=\log\frac{c+\cosh t}{c+\cosh a}.
\tag{5}
$$

The identities

$$
e^{\alpha\varepsilon}+e^{(1-\alpha)\varepsilon}+k-2
 =2e^a(c+\cosh t),
$$

$$
\varepsilon^2\alpha(\alpha-1)=t^2-a^2
$$

turn (1) into

$$
\rho_k(\varepsilon)
=\varepsilon^2\sup_{t>a}\frac{N(t)}{t^2-a^2}
=\varepsilon^2\sup_{x>a^2}
 \frac{F_c(x)-F_c(a^2)}{x-a^2}.
\tag{6}
$$

The optimization is thus over secant slopes anchored at the positive
point $a^2$. Its geometry differs from the unanchored, zero-mean
sub-Gaussian optimization discussed in Section 7.

# 3. The curvature threshold

For $t>0$, introduce

$$
A(t)=\sinh t\cosh t-t,
\qquad B(t)=t\cosh t-\sinh t,
\qquad C(t)=\frac{A(t)}{B(t)}.
\tag{7}
$$

**Lemma 1 (monotonicity of the curvature threshold).** The denominator
$B(t)$ is positive for $t>0$. The function $C$ is strictly increasing on
$(0,\infty)$ and satisfies

$$
\lim_{t\downarrow0}C(t)=2,
\qquad
\lim_{t\to\infty}C(t)=\infty.
\tag{8}
$$

**Proof.** Since $B(0)=0$ and $B'(t)=t\sinh t>0$, we have $B(t)>0$.
Also

$$
A'(t)=2\sinh^2t,
\qquad
\frac{A'(t)}{B'(t)}=\frac{2\sinh t}{t}=:h(t),
\qquad h'(t)=\frac{2B(t)}{t^2}>0.
$$

Integrating the derivatives from zero expresses $C$ as the weighted
average

$$
C(t)=
\frac{\int_0^t h(u)\,u\sinh u\,du}
     {\int_0^t u\sinh u\,du}.
$$

The weight is positive for $u>0$, and $h$ is strictly increasing. Thus
$C(t)<h(t)$, so

$$
C'(t)=\frac{B'(t)}{B(t)}\bigl(h(t)-C(t)\bigr)>0.
$$

The weighted-average expression and $h(0+)=2$ give the first limit.
The elementary hyperbolic asymptotics give

$$
C(t)\sim\frac{e^t}{2(t-1)}\qquad(t\to\infty),
$$

which proves the second. $\square$

**Lemma 2 (one change of curvature).** For $x=t^2>0$,

$$
F_c'(x)=\frac{\sinh t}{2t(c+\cosh t)},
\tag{9}
$$

$$
F_c''(x)
=\frac{t(1+c\cosh t)-\sinh t(c+\cosh t)}
       {4t^3(c+\cosh t)^2}
=\frac{B(t)(c-C(t))}{4t^3(c+\cosh t)^2}.
\tag{10}
$$

If $0\le c\le2$, then $F_c$ is strictly concave on $(0,\infty)$.
If $c>2$, there is exactly one $\tau>0$ with $C(\tau)=c$; $F_c$ is
strictly convex on $(0,\tau^2)$ and strictly concave on
$(\tau^2,\infty)$.

**Proof.** Differentiate (9), simplify using
$\cosh^2t-\sinh^2t=1$, and use Lemma 1. In particular,
$C(t)>2$ for every $t>0$, giving strict concavity even when $c=2$.
$\square$

The monotone-ratio argument in Lemma 1 is elementary. The contribution
below is its application to the positive-anchor objective (6), which
turns a local threshold into a complete global classification.

# 4. Complete global classification

**Theorem 1 (exact finite-parameter zCDP).** Let $k\ge2$ be an integer
and let $\varepsilon>0$. Use the notation in (4) and (7).

**Endpoint regime.** If $c\le C(a)$, then the objective in (6) is
strictly decreasing for $t>a$, and

$$
\rho_k(\varepsilon)
=\varepsilon^2\frac{\sinh a}{2a(c+\cosh a)}
=\frac{\varepsilon(e^\varepsilon-1)}{e^\varepsilon+k-1}.
\tag{11}
$$

Its supremum is approached as $\alpha\downarrow1$ and is strictly
larger than the value at every order $\alpha>1$. These statements
include the boundary case $c=C(a)$.

**Interior regime.** If $c>C(a)$, let $\tau>a$ be the unique solution
of $C(\tau)=c$. There is exactly one $t_\star>\tau$ satisfying

$$
(t_\star^2-a^2)\frac{\sinh t_\star}{c+\cosh t_\star}
=2t_\star\log\frac{c+\cosh t_\star}{c+\cosh a}.
\tag{12}
$$

The objective in (6) is strictly increasing on $(a,t_\star)$ and
strictly decreasing on $(t_\star,\infty)$. The unique maximizing
Rényi order and tight parameter are

$$
\alpha_\star=\frac12+\frac{t_\star}{\varepsilon},
\qquad
\rho_k(\varepsilon)
=\varepsilon^2\frac{\sinh t_\star}
 {2t_\star(c+\cosh t_\star)}.
\tag{13}
$$

The value in (13) is strictly greater than the KL expression in (11).

**Proof.** Put $x_0=a^2$ and write

$$
Q(x)=\frac{F_c(x)-F_c(x_0)}{x-x_0},
\qquad
P(x)=(x-x_0)F_c'(x)-F_c(x)+F_c(x_0).
$$

The continuous endpoint extensions satisfy $Q(x_0)=F_c'(x_0)$ and
$P(x_0)=0$. For $x>x_0$,

$$
Q'(x)=\frac{P(x)}{(x-x_0)^2},
\qquad
P'(x)=(x-x_0)F_c''(x).
\tag{14}
$$

Suppose first that $c\le C(a)$. Strict increase of $C$ gives
$F_c''(x)<0$ for every $x>x_0$. Thus $P$ strictly decreases from zero,
and $Q'(x)<0$ on that whole interval. Taking the endpoint limit in (6)
and substituting (9) proves (11). This reasoning uses a strict
inequality to the right of the anchor even when $c=C(a)$, and therefore
also proves the claimed boundary statement.

Now suppose that $c>C(a)$. Lemma 2 gives a unique $\tau>a$.
Equation (14) shows that $P$ strictly increases from zero to a positive
value at $\tau^2$ and then strictly decreases. At infinity,

$$
F_c(x)=\sqrt{x}-\log2+o(1),
\qquad
F_c'(x)=\frac{1+o(1)}{2\sqrt{x}}.
$$

Consequently $P(x)=-\sqrt{x}/2+o(\sqrt{x})\to-\infty$. It has exactly one
zero beyond $\tau^2$. Formula (14) now yields the complete sign pattern
of $Q'$. Substituting $x=t^2$ into $P(x)=0$ gives (12); evaluating the
secant slope by the tangent slope at that point gives (13). The
objective initially increases strictly from the endpoint value, so its
unique maximum is strictly larger than (11). $\square$

## 4.1. The established local threshold is globally exact

The condition $c\le C(a)$ is equivalent to $k\le K(\varepsilon)$, where

$$
K(\varepsilon)=2+2e^aC(a)
=\frac{2(e^\varepsilon-1)(e^\varepsilon-1-\varepsilon)}
 {\varepsilon(e^\varepsilon+1)-2e^\varepsilon+2}.
\tag{15}
$$

The denominator is $4e^aB(a)>0$. To verify the equality of the two
expressions, use
$e^a\cosh a-1=e^a\sinh a$ and

$$
2B(a)+2e^aA(a)
=2\sinh a\,(e^a\sinh a-a).
$$

The right side of (15) is precisely the threshold of [HM26, Lemma 17].
That lemma gives failure of the KL expression above the threshold.
Theorem 1 additionally proves its validity at and below the threshold,
and identifies the unique global optimum throughout the remaining
regime.

**Corollary 1 (phase diagram).** The function $K$ is continuous and
strictly increasing on $(0,\infty)$, with limits $K(0+)=6$ and
$K(\infty)=\infty$. For every integer $k\ge7$, there is exactly one
positive $\varepsilon_c(k)$ satisfying
$K(\varepsilon_c(k))=k$. The interior regime is
$0<\varepsilon<\varepsilon_c(k)$; the endpoint regime is
$\varepsilon\ge\varepsilon_c(k)$. For $2\le k\le6$, every positive
$\varepsilon$ lies in the endpoint regime.

**Proof.** In (15), both $e^a$ and the positive function $C(a)$ are
strictly increasing. Their limits in Lemma 1 establish the two endpoint
limits of $K$. Existence and uniqueness of the critical privacy
parameter follow from the intermediate value theorem. $\square$

At a positive-parameter phase boundary, the interior optimizer tends
to the anchor $a$. Indeed, for any fixed point strictly to the right of
the limiting anchor, the sign of $P$ at the boundary is strictly
negative by Theorem 1. This sign persists for nearby parameters.
Uniqueness then traps the interior root between the moving anchor and
that point. Letting the point decrease to the limiting anchor proves
the assertion. Thus the optimizing Rényi order tends to one at the
transition; there is no competing distant maximum.

# 5. Explicit finite bracket and controlled computation

A stationarity equation alone does not exclude spurious local extrema
or specify where a search should stop. Theorem 1 supplies the global
sign pattern, and the next result supplies a finite upper endpoint.

Define

$$
b=\log[2(c+\cosh a)]
 =\log(e^\varepsilon+k-1)-a,
\qquad T=b+\sqrt{b^2-a^2}.
\tag{16}
$$

The inequality $2(c+\cosh a)\ge2\cosh a>e^a$ implies $b>a$, so $T$
is real and exceeds $a$.

**Proposition 1 (finite global bracket).** In the interior regime,

$$
a<\tau<t_\star<T.
\tag{17}
$$

For

$$
H(t)=(t^2-a^2)N'(t)-2tN(t),
\tag{18}
$$

we have $H(t)>0$ on $(a,t_\star)$ and $H(t)<0$ on
$(t_\star,\infty)$.

**Proof.** The identity $H(t)=2tP(t^2)$ transfers the sign pattern from
Theorem 1. Set

$$
r(t)=\log(1+2ce^{-t}+e^{-2t}).
$$

Then

$$
N(t)=t-b+r(t),\qquad r(t)>0,\qquad r'(t)<0,
$$

and

$$
H(t)=-t^2+2bt-a^2+(t^2-a^2)r'(t)-2tr(t).
\tag{19}
$$

The polynomial part vanishes at $T$. Both remaining terms are
negative there, hence $H(T)<0$ and $t_\star<T$. The other inequalities
are already part of Theorem 1. $\square$

The following bisection procedure is therefore globally valid in exact
real arithmetic.

1. Determine the sign of $c-C(a)$. For a nonpositive sign use (11).
2. For a positive sign initialize the bracket $[L,U]=[a,T]$.
3. Set $m=(L+U)/2$. If $H(m)>0$, set $L=m$. If $H(m)<0$, set $U=m$.
   Exact equality gives $m=t_\star$.
4. After $n$ bisections, $t_\star$ lies in a bracket of width
   $(T-a)2^{-n}$, and $\alpha_\star$ lies in a bracket of width
   $(T-a)2^{-n}/\varepsilon$.

The removable endpoint root $H(a)=0$ causes no ambiguity: every
midpoint used by the procedure lies strictly above $a$, and the signs
in Proposition 1 identify the interior root uniquely.

For a rigorous numerical implementation, threshold and midpoint signs
can be enclosed with outward-rounded interval arithmetic, increasing
precision when necessary. If the lower endpoint also satisfies
$C(L)>c$, then $L>\tau$ and (9) is decreasing over the entire bracket.
This gives the particularly simple parameter certificate

$$
\varepsilon^2\frac{\sinh U}{2U(c+\cosh U)}
\le\rho_k(\varepsilon)
\le\varepsilon^2\frac{\sinh L}{2L(c+\cosh L)}.
\tag{20}
$$

Because $t_\star>\tau$, a sufficiently narrow correct bracket will
satisfy $L>\tau$. Alternatively, interval evaluation of the objective
in (6) over a bracket with $L>a$ also encloses the optimum. Such
certificates, rather than a grid maximum or a fixed-precision
optimizer, justify a reported numerical upper privacy bound.

The exact equality $c=C(a)$ is settled analytically in Theorem 1.
No finite-time equality decision for arbitrary black-box real inputs,
and no floating-point bit-complexity bound, is asserted here. This
distinction does not affect the finite bracket or geometric
convergence proved above.

# 6. Sharp large-alphabet behavior

In this section $\varepsilon>0$ is fixed while $k\to\infty$.
Constants in asymptotic error terms may depend on $\varepsilon$.

**Theorem 2 (large-$k$ asymptotic with remainder).** With $b,T$ from
(16), the optimizer eventually lies in the interior regime and obeys

$$
t_\star=T+O_\varepsilon\!\left(\frac{\log k}{k}\right),
\qquad t_\star<T,
\tag{21}
$$

$$
\rho_k(\varepsilon)
=\frac{\varepsilon^2}{2T}
 +O_\varepsilon\!\left(\frac1{k(\log k)^2}\right).
\tag{22}
$$

The difference $\rho_k(\varepsilon)-\varepsilon^2/(2T)$ is strictly
positive. Consequently,

$$
\rho_k(\varepsilon)\sim\frac{\varepsilon^2}{4\log k},
\qquad
\alpha_\star\sim\frac{2\log k}{\varepsilon}.
\tag{23}
$$

**Proof.** The threshold $K(\varepsilon)$ is finite, so every
sufficiently large $k$ is in the interior regime. We have

$$
c=\Theta_\varepsilon(k),\qquad
b=\log k-a+O_\varepsilon(k^{-1}),\qquad
T=2b+O_\varepsilon(b^{-1}).
$$

Uniformly for $t\in[T-1,T]$, the remainder in (19) satisfies

$$
r(t)=O_\varepsilon(c^{-1}),\qquad
|r'(t)|=O_\varepsilon(c^{-1}).
\tag{24}
$$

Indeed, $2ce^{-T}=O_\varepsilon(c^{-1})$ and
$e^{-2T}=O_\varepsilon(c^{-4})$, and changing $t$ by at most one only
multiplies these quantities by fixed factors.

Write $H_0(t)=-t^2+2bt-a^2$. At $T-1$,

$$
H_0(T-1)=2\sqrt{b^2-a^2}-1\sim2b.
$$

By (24), the correction $H-H_0$ is
$O_\varepsilon(b^2/c)=o(b)$ on $[T-1,T]$. Therefore $H(T-1)>0$
for large enough $k$. Proposition 1 then gives
$t_\star\in(T-1,T)$.

At the root, (19) implies
$H_0(t_\star)=O_\varepsilon(b^2/c)$. The exact factorization

$$
H_0(t)=(T-t)\left(t-\frac{a^2}{T}\right)
$$

and $t_\star\in(T-1,T)$ yield
$T-t_\star=O_\varepsilon(b/c)$, proving (21).

Now let

$$
q_0(t)=\frac{t-b}{t^2-a^2}.
$$

Its derivative has numerator $H_0(t)$. The smaller root of $H_0$
is $a^2/T<a$, so $q_0$ has its unique global maximum on $(a,\infty)$
at $T$. Its maximum equals $q_0(T)=1/(2T)$. Since

$$
\frac{N(t)}{t^2-a^2}
=q_0(t)+\frac{r(t)}{t^2-a^2},
$$

evaluation at $T$ gives a value strictly above $1/(2T)$. At the actual
optimizer, the first term is at most $1/(2T)$, and (24) bounds the
second by $O_\varepsilon(1/(cb^2))$. Multiplication by
$\varepsilon^2$ proves (22). Finally $T\sim2\log k$ gives (23).
$\square$

The KL expression and (23) also give

$$
\frac{\rho_k(\varepsilon)}
 {\varepsilon(e^\varepsilon-1)/(e^\varepsilon+k-1)}
\sim
\frac{\varepsilon k}{4(e^\varepsilon-1)\log k}.
\tag{25}
$$

Thus the relative failure of the endpoint formula becomes unbounded
as the alphabet grows at fixed positive privacy parameter. The sharp
constant in (23) and the controlling order explain this behavior;
an upper bound that merely tends to zero does not determine it.

# 7. High-privacy limit and the known three-point connection

The limit $\varepsilon\downarrow0$ at fixed $k$ is different from the
large-$k$ limit. It connects the present result to the optimal
sub-Gaussian proxy for three-point distributions, studied in [AMA25].
We include the connection to identify the boundary of the novelty.

Fix $k>6$, put $c_0=(k-2)/2$, and define

$$
q_k(t)=\frac1{t^2}
 \log\frac{c_0+\cosh t}{c_0+1},\qquad t>0.
$$

Its continuous value at zero is $1/k$. The curvature argument of
Section 3 applies also at anchor zero, using the Taylor expansion to
extend $F_c$ there. Because $c_0>2$, there is a unique positive
maximizer $t_k$, which satisfies

$$
\frac{t_k\sinh t_k}{c_0+\cosh t_k}
=2\log\frac{c_0+\cosh t_k}{c_0+1}.
\tag{26}
$$

Moreover,

$$
t_\star\longrightarrow t_k,
\qquad
\varepsilon\alpha_\star\longrightarrow t_k,
\qquad
\frac{\rho_k(\varepsilon)}{\varepsilon^2}
\longrightarrow q_k(t_k)>\frac1k.
\tag{27}
$$

To justify these limits, observe that $a\to0$, $c\to c_0$, and the
functions $H$ in (18) converge uniformly on every positive compact
$t$ interval to the corresponding anchor-zero function. Choose one
point on either side of its unique root. Their opposite signs persist
for small enough $\varepsilon$, trapping the unique root from Theorem
1. This proves convergence of $t_\star$; the other limits follow from
(6) and (13). Strict improvement over $1/k$ follows because the
anchor-zero secant slope initially increases when $c_0>2$.

If $X$ has probabilities $1/k,(k-2)/k,1/k$ at $-1,0,1$, then

$$
\mathbb E e^{tX}=\frac{c_0+\cosh t}{c_0+1}.
$$

Therefore $2q_k(t_k)$ is exactly the optimal sub-Gaussian variance
proxy of this centered three-point distribution. This is an existing
type of proxy problem, not an independent new resolution claimed
here. The finite-$\varepsilon$ problem studied in this manuscript has
a positive anchor $a^2$, and the same finite-$\varepsilon$ parameter
also enters $c$ through $e^{-a}$.

For $2\le k\le6$, the established endpoint formula instead gives
$\rho_k(\varepsilon)/\varepsilon^2\to1/k$. This recovers the small-$k$
high-privacy behavior of [HM26].

# 8. Extension to a swapped pair with common mass

The same analytic argument applies to arbitrary $c\ge0$, independently
of an integer alphabet size.
Consider any pair of distributions of the form

$$
P=(p,q,r_1,\ldots,r_m),\qquad
Q=(q,p,r_1,\ldots,r_m),
$$

with $p>q>0$, $r_j\ge0$, and $p+q+\sum_jr_j=1$. Let

$$
\varepsilon=\log(p/q),\quad a=\varepsilon/2,
\quad r=\sum_jr_j,\quad c=\frac{r}{2\sqrt{pq}}.
$$

Their Rényi sum equals

$$
p^\alpha q^{1-\alpha}+q^\alpha p^{1-\alpha}+r
=2\sqrt{pq}\cosh\bigl(\varepsilon(\alpha-\tfrac12)\bigr)+r.
$$

Since $2\sqrt{pq}\cosh a+r=1$, dividing by the normalization reduces
the pairwise zCDP objective exactly to (6). The curvature criterion,
unique interior root and finite bracket of Theorem 1 and Proposition 1
therefore apply. Here the endpoint value is $\varepsilon(p-q)$, and the
quantity being characterized is the coefficient
$\sup_{\alpha>1}D_\alpha(P\Vert Q)/\alpha$ for this particular pair.
A mechanism with additional neighboring pairs requires taking the
supremum over all of them.

Equivalently, let $w=p+q$ be the probability of activating a binary
randomized-response component, with an input-independent common
output component of mass $1-w$ on the remaining output symbols, disjoint
from the two distinguished symbols. The component label is therefore
observable; a hidden overlapping mixture is not being asserted to have
this representation. Then

$$
c=\frac{1-w}{w}\cosh a.
$$

The endpoint regime is exactly

$$
w\ge\frac{\cosh a}{\cosh a+C(a)};
$$

below this threshold there is a unique interior maximizing order.
For $k$-ary randomized response, $w=(e^\varepsilon+1)/(e^\varepsilon+k-1)$.
This extension is an immediate consequence of the same proved
optimization theorem. It is not a claim that arbitrary privacy-loss
distributions reduce to three masses.

# 9. Reproducible examples and scope

The following values are high-precision approximations. An optimizing
order of one means the continuous endpoint extension; under the
definition $\alpha>1$ it is a limiting supremum.

| $k$ | $\varepsilon$ | $\alpha_\star$ | Tight $\rho$ (approximate) | KL endpoint |
|---:|---:|---:|---:|---:|
| 7 | 0.1 | 16.863706959 | 0.001496918480 | 0.001480202507 |
| 7 | 0.5 | 1 | 0.042407171587 | 0.042407171587 |
| 10 | 1 | 2.186743926 | 0.148132973355 | 0.146632574093 |
| 100 | 1 | 8.521666745 | 0.061138212223 | 0.016892556555 |
| 1000 | 1 | 13.274110058 | 0.039074657904 | 0.001715334401 |

Selected examples have separate, fully rational interval certificates:

$$
\begin{aligned}
0.436747543470&<\varepsilon_c(7)<0.436747543471,\\
8.021666745077&<t_\star(100,1)<8.021666745080,\\
0.0611382122225&<\rho_{100}(1)<0.0611382122227.
\end{aligned}
$$

The certificate verifier uses integer and rational arithmetic with
explicit elementary-function remainder bounds. Its finite examples
do not replace the analytic theorem. The primary mpmath solver returns
approximations; its decimal rounding is not a certified privacy upper
bound. The computation programs and raw outputs are not included in this version.

## 9.1. Scope

The proof provides the exact parameter for every $k\ge2$ and every
$\varepsilon\ge0$, with a strict distinction between an endpoint
supremum and an attained interior maximum. It treats the equality
boundary explicitly, establishes all-orders global optimality, and
gives a finite root bracket. The large-alphabet result is an
asymptotic statement for fixed positive $\varepsilon$; it does not
assert uniformity when $\varepsilon$ grows or shrinks with $k$.

The reproduction programs described in the original manuscript implement the scalar
formulas and compare them with direct evaluations of the original
Rényi curve. Numerical checks support implementation accuracy and
illustrate the theorem, but do not replace its universal analytic
proof. A claim of a rigorous numerical upper bound additionally
requires outward-rounded evaluation of its certificate. No new formal verification or execution is claimed by this version.

The present manuscript is an AI-assisted research draft. The
literature comparison identifies an explicit question in [HM26] and
the nearby three-point proxy problem [AMA25]; it does not constitute
a guarantee of worldwide priority. External peer review and any
full formalization of the privacy theorem remain separate from the
written proof presented here.

The result supplies the exact budget of the specified single mechanism.
Standard composition gives a valid sum of budgets; exactness for
arbitrary heterogeneous composed releases is not asserted.

# References

**[HM26]** Charlie Harrison and Pasin Manurangsi. *Exact zCDP
Characterizations for Fundamental Differentially Private Mechanisms.*
7th Symposium on Foundations of Responsible Computing (FORC 2026),
LIPIcs 368, 3:1–3:18. DOI:
[10.4230/LIPIcs.FORC.2026.3](https://doi.org/10.4230/LIPIcs.FORC.2026.3).
Preprint: [arXiv:2510.25746v1](https://arxiv.org/abs/2510.25746v1).
The theorem numbers used above refer to the FORC version.

**[AMA25]** Soufiane Atouani, Olivier Marchal and Julyan Arbel. *Optimal sub-Gaussian variance
proxy for 3-mass distributions.* 2025.
[arXiv:2510.06132v1](https://arxiv.org/abs/2510.06132v1).

**[Ste24]** Thomas Steinke. *Tight RDP & zCDP Bounds from Pure DP.*
27 May 2024. [Author's original article](https://differentialprivacy.org/pdp-to-zcdp/).
This gives the general pure-DP comparison and binary randomized-response
tightness used in the figure's comparison bounds.

