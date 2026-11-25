# Exact Order-Three Rényi Channel Design
## Two-Level Extremizers, the Complete Frontier, and the Sharp Dimension-Eighteen Threshold

*AI-assisted research working paper. 24 November 2026. Classical proofs and exact arithmetic; no full Lean certification.*

### Abstract

We determine the maximum information trace over finite-output channels under a maximum directed pairwise Rényi constraint of order three, for every $d\ge3$ and every finite linear budget $C\ge0$. Every minimizer of $(\sum a_i^3)(\sum a_i^{-2})$ at fixed first and second moments has two coordinate levels. Its proof excludes three-level stationary points by the full constrained Hessian and an exact positive-polynomial identity. A strictly convex scalar transformation reduces fixed-trace optimization to two adjacent integer multiplicities. Finite attainment and strong duality show that at most two subset orbits attain the complete channel frontier, with supporting ratios solving explicit degree-six equations. We derive a quartic initial phase, an eventual pure randomized-response phase, and a two-term high-budget expansion. We prove that eighteen is the smallest dimension where the entire singleton-mixture family fails; an exact rational witness supplies strict separation. The resulting frontier gives the exact finite-sample globally unbiased minimax risk. Portable arithmetic certificates accompany the proofs. Full Lean verification and PDF rendering are not claimed.

**Keywords:** Rényi privacy; finite channel design; power-sum extremizers; subset selection; minimax estimation; exact certificates.

## Problem, contributions, and scope

Fix an integer $d\ge3$. A common channel with an arbitrary finite output alphabet is subject to
$$
\sum_y\frac{W_j(y)^3}{W_i(y)^2}-1\le C\quad(i\ne j),\qquad 0\le C<\infty. \tag{I1}
$$
After removing all-zero columns, a finite budget forces common positive support. We maximize
$$
T(W)=\sum_y\overline W(y)\sum_i\left(\frac{W_i(y)}{\overline W(y)}-1\right)^2,
\qquad \overline W(y)=d^{-1}\sum_iW_i(y). \tag{I2}
$$
A logarithmic order-three Rényi budget $R$ corresponds to $C=e^{2R}-1$. All mixtures, supporting lines, and concave envelopes below use $C$, not $R$.

Shvets [1] determines the full frontier for $1<\alpha\le2$, exhibits failure of the singleton family above order two, and leaves the higher-order optimal trace open in Section 7. We resolve the complete order-three branch for finite outputs, retaining every finite dimension and budget.

The essential structural problem is to minimize $P_3P_{-2}$ at fixed first and second moments. First-order stationarity permits three coordinate levels. We exclude them using the complete constrained product Hessian and an exact positive-polynomial certificate. A scalar strictly convex transformation then reduces the integer multiplicities to two adjacent candidates. Finite attainment and strong duality give an optimizer consisting of at most two two-level permutation orbits.

Additional results identify the initial linear phase through a quartic, prove an eventual pure randomized-response tail and its high-budget expansion, and establish the sharp first dimension of singleton failure: eighteen. Dimensions three through seventeen admit the full randomized-response formula. At dimension eighteen an exact rational witness beats every mixture of singleton templates. Finally, a score argument gives the exact finite-sample globally unbiased minimax risk.

Normalized columns, permutation symmetrization, subset mechanisms, and score inequalities are established tools, used here in the form developed in [1]. The subset formulas themselves are prior work. General entropy extremizers [3] and positive-order Rényi norm bounds [4] do not directly supply the mixed-power product theorem. Pure local privacy work [5--7] imposes a pointwise likelihood-ratio cap, unlike (I1). The recent shuffle result [2] concerns a three-row variance with a chosen reference row, a different objective.

The qualitative dimension-eighteen phenomenon was already observed numerically in [1, Remark 5.2]. The new contribution is the exclusion of every smaller dimension and an exact rational separation against the entire continuous singleton-mixture family. The literature comparison is limited to the examined sources. No global-priority claim follows from a finite search.

This is an AI-assisted classical research manuscript using exact arithmetic. It has not undergone external peer review. Full formalization is incomplete; the numerical verification files and Lean drafts are not included in this edition.

The model is finite-output, noninteractive, single-message, and uses a common independent channel. The main theorem quantifies over all finite $d,C$; high-budget asymptotics keep $d$ fixed. General orders, arbitrary Borel outputs, heterogeneous shuffle privacy, biased finite-sample minimax estimation, interactive protocols, and growing-dimension asymptotics are outside the asserted results.


## Global template structure and the adjacent-count theorem

This chapter proves the order-three structural result on which the full
all-budget channel theorem depends. The optimization is over actual positive
$d$-coordinate templates with equal coordinate weights. No restriction to
two-level templates is assumed. The final subsection records an exact finite
polynomial certificate in a form that can be checked independently of floating
point arithmetic.

### The fixed-moment problem

For an integer $d\ge3$, a positive normalized template is a vector
$a\in(0,\infty)^d$ satisfying $\sum_i a_i=d$. Write

$$
 U(a)=\sum_{i=1}^d a_i^3,\qquad
 V(a)=\sum_{i=1}^d a_i^{-2},\qquad J(a)=U(a)V(a).
$$

Fix $v\in(0,d-1)$ and impose the second moment $\sum_i a_i^2=d(1+v)$.
The corresponding signal is $dv$. Define

$$
 J_d(v)=\min\left\{J(a):a_i>0,\ 
 \sum_i a_i=d,\ \sum_i a_i^2=d(1+v)\right\}.
$$

The word “minimum” is justified below. At $v=0$ the only template is uniform and
$J_d(0)=d^2$. Values $v\ge d-1$ are infeasible for a positive template, because
$\sum_i a_i^2<(\sum_i a_i)^2=d^2$.

**Theorem A (global two-level structure).** For every integer $d\ge3$ and every
$v\in(0,d-1)$, the minimum $J_d(v)$ is attained. Every minimizing template has exactly
two distinct values. If it has $s$ high coordinates, then

$$
 1\le s<\frac d{1+v},\qquad
 h_s=1+\sqrt{\frac{v(d-s)}s},\qquad
 \ell_s=1-\sqrt{\frac{vs}{d-s}}.
$$

Conversely these formulas give a feasible positive template for every such
integer $s$. The complete minimizer set consists of the permutations of precisely
the two-level templates whose value of $J$ is smallest among these admissible
counts. In particular, all ties between counts are retained, and there are no
additional equality cases with three or more levels.

#### Existence and the second-order condition

The singleton choice $s=1$ in the displayed formula is feasible whenever
$0<v<d-1$, so the constraint set is nonempty. Jensen's inequality gives $U(a)\ge d$.
On a sublevel set $J(a)\le M$ this implies $V(a)\le M/d$ and hence

$$
 a_i\ge\sqrt{d/M}\qquad\text{for every }i.
$$

Also $a_i\le d$. Taking $M$ to be the value of one feasible comparison template gives
a nonempty compact sublevel set on which $J$ attains its minimum.

At a nonuniform feasible vector the gradients of $\sum_i a_i$ and $\sum_i a_i^2$ are
linearly independent. Thus a local constrained minimum has multipliers $\eta,\lambda$
satisfying

$$
 3V a_i^2-2U a_i^{-3}-2\eta a_i-\lambda=0.                 \tag{1}
$$

The second variation of the Lagrangian is nonnegative on every vector $w$ with

$$
 \sum_i w_i=0,\qquad \sum_i a_i w_i=0.                    \tag{2}
$$

There is no boundary qualification hidden in this application. The constraints
form a sphere centered at the uniform vector inside the hyperplane $\sum_i a_i=d$.
A tangent vector satisfying (2) is realized by a great-circle curve on that
sphere, and the curve remains strictly positive for sufficiently small time.

#### A positive quadratic controls all stationary levels

Multiplying (1) by $a_i^3$ shows that all coordinate values are positive roots of

$$
 p(t)=3Vt^5-2\eta t^4-\lambda t^3-2U.                    \tag{3}
$$

Suppose $x<y<z$ are three positive roots. Factor

$$
 p(t)=(t-x)(t-y)(t-z)(3Vt^2+b t+c).
$$

The constant and linear coefficients of (3) give

$$
 c=\frac{2U}{xyz}>0,\qquad
 b=c\left(\frac1x+\frac1y+\frac1z\right)>0.              \tag{4}
$$

Therefore the quadratic factor is strictly positive at every positive $t$.
There is no fourth positive root, and the middle root satisfies $p'(y)<0$.
Put $R=U/V$ and define

$$
\begin{aligned}
 H={}&x^2y^2+x^2yz+x^2z^2+xy^2z+xyz^2+y^2z^2,\\
 K={}&(x+y+z)H-(xy+xz+yz)xyz.
\end{aligned}
$$

The quadratic and quartic coefficients of the same factorization yield

$$
 R=\frac{3x^3y^3z^3}{2H},\qquad
 \frac{2\eta}{V}=\frac{3K}{H}.                          \tag{5}
$$

For the frozen scalar diagonal, let

$$
 g(t)=6t+6Rt^{-4}-2\eta/V.
$$

Introduce the positive polynomials

$$
\begin{aligned}
 P_x={}&x^2y^2+x^2yz+x^2z^2+2xy^2z+2xyz^2+3y^2z^2,\\
 P_y={}&x^2y^2+2x^2yz+3x^2z^2+xy^2z+2xyz^2+y^2z^2,\\
 P_z={}&3x^2y^2+2x^2yz+x^2z^2+2xy^2z+xyz^2+y^2z^2.
\end{aligned}
$$

Substitution of (5) gives the exact factorizations

$$
\begin{aligned}
 g(x)&=\frac{3(x-y)(x-z)P_x}{xH}>0,\\
 g(y)&=-\frac{3(x-y)(y-z)P_y}{yH}<0,\\
 g(z)&=\frac{3(x-z)(y-z)P_z}{zH}>0.                       \tag{6}
\end{aligned}
$$

If two coordinates had the middle value $y$, the vector taking values $1$ and $-1$
on those coordinates and zero elsewhere would satisfy (2). Both first
variations of $U$ and $V$ would vanish, and the constrained second variation would
be $2Vg(y)<0$. Hence a three-level minimum must have multiplicities $(m,1,k)$, where
$m,k$ are positive integers. The middle level is genuinely a singleton.

#### The grouped direction and its product cross term

For such a three-level stationary template, use the tangent direction

$$
 w_i=\begin{cases}
 (y-z)/m,&a_i=x,\\
 z-x,&a_i=y,\\
 (x-y)/k,&a_i=z.
 \end{cases}                                           \tag{7}
$$

Both constraints in (2) hold. The complete constrained second variation is

$$
\begin{aligned}
 Q={}&V\left[\frac{g(x)(y-z)^2}{m}
           +g(y)(z-x)^2+\frac{g(z)(x-y)^2}{k}\right]\\
 &-\frac{12(x-y)^2(x-z)^2(y-z)^2H}{x^3y^3z^3}.            \tag{8}
\end{aligned}
$$

The second line is essential. In general the Hessian of $UV$ contains
$2(dU)(dV)$. Here

$$
\begin{aligned}
 \sum_i a_i^2w_i&=-(y-x)(z-x)(z-y),\\
 \sum_i a_i^{-3}w_i&=-\frac{(y-x)(z-x)(z-y)H}{x^3y^3z^3},
\end{aligned}
$$

which gives exactly that cross term. A diagonal-only second-order calculation
would not prove the result.

Since $R=U/V$ is a positive weighted mean of $x^5,y^5,z^5$, one has $x^5<R<z^5$.
The relation $U=RV$ permits elimination of $m$:

$$
 m=A k+B,\qquad
 A=\frac{x^2(z^3-Rz^{-2})}{R-x^5}>0,\qquad
 B=\frac{x^2(y^3-Ry^{-2})}{R-x^5}.                       \tag{9}
$$

Correspondingly,

$$
\begin{aligned}
 V&=V_1k+V_0,\\
 V_1&=\frac{z^5-x^5}{z^2(R-x^5)}>0,\qquad
 V_0=\frac{y^5-x^5}{y^2(R-x^5)}>0,\\
 AV_0-BV_1&=A/y^2-B/z^2>0.                              \tag{10}
\end{aligned}
$$

The last inequality follows by multiplying by $y^2z^2$: the numerator of
$Az^2-By^2$ is $x^2(z^5-y^5)>0$.

We also need the otherwise nonautomatic condition $A+B>0$. From
$H\ge z^2(x^2+xy+y^2)\ge3x^2z^2$ and (5),

$$
 R\le xy^3z/2<y^3z^2/2
 <\frac{y^3+z^3}{y^{-2}+z^{-2}}.
$$

The final comparison uses
$(y^3+z^3)/(y^{-2}+z^{-2})\ge y^3z^2$. Thus
$y^3+z^3-R(y^{-2}+z^{-2})>0$, which is exactly $A+B>0$. Consequently $Ak+B>0$ throughout
the real interval $k\ge1$.

Write $a_0=g(x)(y-z)^2>0$, $b_0=g(y)(z-x)^2<0$, $c_0=g(z)(x-y)^2>0$, and let $D_0>0$
denote the magnitude of the second line of (8). Regard (8) as the rational
function

$$
 Q(k)=(V_1k+V_0)\left[\frac{a_0}{Ak+B}+b_0+\frac{c_0}k\right]-D_0.
$$

An exact subtraction gives

$$
\begin{aligned}
 Q(k)-Q(1)={}&b_0V_1(k-1)\\
 &-\frac{a_0(k-1)(AV_0-BV_1)}{(Ak+B)(A+B)}
 -\frac{c_0V_0(k-1)}k\le0.                             \tag{11}
\end{aligned}
$$

All denominators are positive and every sign has now been established. It
remains to show $Q(1)<0$. Notice that the comparison point $m=A+B$ need only be
positive; it need not be an integer. We use it only to evaluate the rational
extension of the second-variation formula.

#### The exact negative-curvature certificate

The expression (8) is homogeneous of degree one in $(x,y,z)$. Normalize $x=1$,
so $1<y<z$. In this paragraph put

$$
\begin{aligned}
 H&=y^2+yz+z^2+y^2z+yz^2+y^2z^2,\\
 D&=3y^3z^3-2H=2H(R-1)>0,\\
 N&=2H(y^3+z^3)-3yz^3-3y^3z=(A+B)D>0.
\end{aligned}
$$

The polynomial certificate given below establishes the identity

$$
 Q(1)=-\frac{6(y-1)(z-1)(z-y)^2
                 P(y-1,z-1)}{DN y^3z^3}.              \tag{12}
$$

Every coefficient of $P$ is nonnegative, and its linear terms are
$1350u+1350v$. Hence $P(y-1,z-1)>0$ and $Q(1)<0$. By (11), $Q(k)<0$ for every $k\ge1$.
This contradicts the second-order necessary condition for (7). Therefore no
three-level stationary point can be a constrained minimum.

Equations (3)–(4) excluded four or more levels. Since the vector is nonuniform,
every minimum has exactly two levels. Solving its two moment constraints gives
the stated $h_s$ and $\ell_s$, and $\ell_s>0$ is equivalent to $s<d/(1+v)$. This completes
the proof of the global two-level theorem, including its full equality
classification. ∎

### Exact scalar geometry and two adjacent counts

The two-level theorem reduces a $d$-variable nonlinear optimization to a finite
set, but an additional structural fact eliminates the need to search all $d-1$
counts. Work first with a real high fraction

$$
 0<p<\frac1{1+v},\qquad v>0.
$$

Let $h=1+\sqrt{v(1-p)/p}$, $\ell=1-\sqrt{vp/(1-p)}$, and set

$$
 z=h+\ell-1
   =1+(1-2p)\sqrt{\frac{v}{p(1-p)}}.
$$

The root product is $h\ell=z-v>0$. Since $a^3=(h+\ell)a^2-h\ell a$ for $a\in\{h,\ell\}$,
its third moment is $1+2v+vz$. The inverse second moment has numerator
$\mathbb E[(h+\ell-a)^2]=z^2+v$ over the common denominator $(h\ell)^2$. Therefore

$$
 \frac{J}{d^2}=f_v(z)
 :=\frac{(1+2v+vz)(z^2+v)}{(z-v)^2},\qquad z>v.          \tag{13}
$$

The map $p\mapsto z$ is a strictly decreasing bijection from $(0,1/(1+v))$ onto $(v,\infty)$.
Indeed,

$$
 \frac{dz}{dp}=-\frac{\sqrt v}{2[p(1-p)]^{3/2}}<0,
$$

and its endpoint limits are infinity and $v$. Its inverse is

$$
 p(z)=\frac12\left(1-
 \frac{z-1}{\sqrt{(z-1)^2+4v}}\right).                 \tag{14}
$$

For completeness, the entire domain in this inverse is valid. If $\Delta=(z-1)^2+4v$
and $z>v>0$, the roots
$h=(z+1+\sqrt\Delta)/2$ and $\ell=(z+1-\sqrt\Delta)/2$ satisfy $0<\ell<1<h$ because
$(z+1)^2-\Delta=4(z-v)>0$ and $\sqrt\Delta>|z-1|$. Then $p=(1-\ell)/(h-\ell)$ gives mean one and variance
$v$ and lies in $(0,1/(1+v))$. Thus no spurious branch was introduced by squaring.

Differentiation of (13) gives

$$
\begin{aligned}
 f_v'(z)&=\frac{vG_v(z)}{(z-v)^3},\\
 G_v(z)&=z^3-3vz^2-(5v+2)z-v^2-4v-2,\\
 f_v''(z)&=\frac{2v(v+1)(3vz+4v+2z+3)}{(z-v)^4}>0.       \tag{15}
\end{aligned}
$$

There is exactly one root $z_*(v)>v$ of $G_v$. To prove existence and uniqueness
without an implicit root-selection assumption, put $t=z-v$ and write

$$
 G_v(v+t)=t^3-A_vt-B_v,\quad
 A_v=3v^2+5v+2>0,\quad B_v=2(v+1)^3>0.
$$

The polynomial is negative at zero and positive at sufficiently large $t$, so it
has a positive root $r$. Its equation gives $r^2>A_v$. For $t>0$,

$$
 t^3-A_vt-B_v=(t-r)(t^2+tr+r^2-A_v),
$$

whose second factor is strictly positive. This proves uniqueness and the sign
on either side. Consequently $f_v$ strictly decreases up to $z_*$ and strictly
increases after $z_*$. Its unique continuous optimal high fraction is $p_*(v)=p(z_*)$,
which belongs to the full feasible interval.

**Theorem B (adjacent-count formula with all truncation cases).** Let $d\ge3$,
$0<v<d-1$, and define

$$
 M=\left\lceil\frac d{1+v}\right\rceil-1,\qquad
 q=d p_*(v),\qquad
 \operatorname{clamp}_M(j)=\min\{M,\max\{1,j\}\}.
$$

Then $M\in\{1,\ldots,d-1\}$. Define the two candidate integers

$$
 s_-=\operatorname{clamp}_M(\lfloor q\rfloor),\qquad
 s_+=\operatorname{clamp}_M(\lceil q\rceil),
$$

with duplicate candidates removed, and set

$$
 z_s=1+(d-2s)\sqrt{\frac{v}{s(d-s)}}.
$$

The complete fixed-moment value is

$$
 J_d(v)=d^2\min\{f_v(z_{s_-}),f_v(z_{s_+})\}.            \tag{16}
$$

Every minimizing template is a permutation of a candidate attaining this
minimum. If the two candidate values coincide, both permutation classes are
minimizers. There are no other minimizing counts. If $q$ is an admissible integer,
that count is unique. If $q\le1$ the unique count is $1$; if $q\ge M$ it is $M$. When $M=1$
these two endpoint statements refer to the same count.

**Proof.** The exact admissible integer set is $\{1,\ldots,M\}$; use of the ceiling and
the subtraction of one preserves the strict positivity boundary when
$d/(1+v)$ is itself an integer. The map $s\mapsto z_s$ is strictly decreasing on the
feasible real count interval. By (15), $s\mapsto f_v(z_s)$ is strictly decreasing for
$s<q$ and strictly increasing for $s>q$. Every integer strictly below $\lfloor q\rfloor$ is
dominated by the next admissible integer, and every integer strictly above
$\lceil q\rceil$ is dominated by its predecessor. If $q$ lies outside $[1,M]$, this same
monotonicity selects the corresponding endpoint. The global structure theorem
then proves (16) and every equality statement. ∎

Formula (16) is an exact all-dimension reduction to at most two candidates and
one uniquely specified cubic root. It is not a fixed-dimension enumeration.
It determines the cost at each fixed signal, but the complete channel frontier
still requires the convex-envelope and finite-mixture attainment arguments.

### Appendix: the complete finite coefficient certificate

Here $P(u,v)$ is defined by the following symmetric coefficient table. For a row
$j$, the list gives $c_{j,j},c_{j+1,j},\ldots,c_{13,j}$. Put $c_{ij}=0$ outside the listed
range and define

$$
 P(u,v)=\sum_i c_{ii}u^iv^i+
          \sum_{i>j}c_{ij}(u^iv^j+u^jv^i).
$$

| j | Coefficients beginning at i=j |
|---:|---|
| 0 | 0, 1350, 9225, 30660, 65745, 101075, 116715, 103067, 69585, 35352, 13066, 3306, 510, 36 |
| 1 | 16506, 78003, 215331, 407275, 568668, 606448, 499647, 316959, 152245, 53544, 12978, 1930, 132 |
| 2 | 302628, 726446, 1222008, 1533364, 1478795, 1107609, 642550, 284459, 93141, 21262, 3012, 198 |
| 3 | 1548840, 2328261, 2608799, 2241513, 1493748, 771864, 305958, 90671, 19035, 2526, 158 |
| 4 | 3122928, 3104175, 2348876, 1368853, 614985, 211429, 54631, 10170, 1230, 72 |
| 5 | 2713920, 1788228, 897477, 342871, 98806, 21168, 3283, 342, 18 |
| 6 | 1013250, 430989, 136990, 31950, 5323, 615, 48, 2 |
| 7 | 152446, 39312, 7145, 859, 60, 2, 0 |
| 8 | 7958, 1074, 87, 3, 0, 0 |
| 9 | 96, 4, 0, 0, 0 |

There are 167 nonzero monomials after symmetric expansion, all with positive
integer coefficients. To verify the identity behind (12), retain the normalized
$H,D,N$ above, put $P_x,P_y,P_z$ equal to the polynomials in (6) with $x=1$, and define

$$
\begin{aligned}
 V_{\rm num}&=Ny^2z^2+Dz^2+Dy^2,\\
 E&=P_xDyz(z-y)-P_yNz(z-1)+P_zNy(y-1).
\end{aligned}
$$

The finite polynomial identity is

$$
 V_{\rm num}E-4DN(y-1)(z-1)(z-y)H^2
 =-2H(z-y)P(y-1,z-1).                                  \tag{17}
$$

Expansion of its two sides over the integers verifies (17). Clearing the
positive denominator in (8) at $k=1$ then gives (12). The table, the formula (17),
and the denominator signs above form a self-contained exact certificate.

A reported exact-arithmetic calculation independently
forms (8) from the original derivative expressions and checks its rational
identity with (12). It also verifies a second 809-term positive-coefficient
certificate for arbitrary $k\ge1$, without using (11). An independent calculation starts from the weighted product $J$ and
its full three-variable Hessian, rather than from the factorized expressions,
and reproduces both coefficient maps.

These are classical proofs supported by exact algebra; no claim of completed formalization is made.


## The complete finite-output frontier

### Channel coordinates and an exact reverse construction

Put $D=d(d-1)$ and
$$
\mathcal K^\circ=\{a\in(0,\infty)^d:\sum_i a_i=d\},\quad
S(a)=\sum_i a_i^2-d,\quad U=\sum_i a_i^3,\quad V=\sum_i a_i^{-2},\quad
c(a)=\frac{UV-d^2}{D}.
$$
For a channel let $q_y=\overline W(y)$ and $a_i(y)=W_i(y)/q_y$. Then
$q_y>0$, $\sum_yq_y=1$, $a(y)\in\mathcal K^\circ$, and
$\sum_yq_ya_i(y)=1$. Its trace is $\sum_yq_yS(a(y))$, and its directed costs are
$$
E_{ij}=\sum_yq_y\frac{a_j(y)^3}{a_i(y)^2}-1.
$$
Summing over ordered distinct pairs gives
$$
\frac1D\sum_{i\ne j}E_{ij}=\sum_yq_yc(a(y)). \tag{F1}
$$
The diagonal terms disappear because their averaged power moment is one.

An arbitrary finite template mixture need not satisfy the coordinatewise mean constraint. To realize it, retain the orbit label and set
$$
W_i(j,\pi)=\frac{w_j}{d!}a^{(j)}_{\pi(i)},\qquad \pi\in\mathfrak S_d. \tag{F2}
$$
Delete zero-weight blocks. Permutation averaging gives row sums one, common positive support, trace $\sum_jw_jS(a^{(j)})$, and every ordered distinct-pair cost equal to $\sum_jw_jc(a^{(j)})$. Thus the original problem is exactly
$$
F_d(C)=\sup\left\{\sum_{j=1}^m w_jS(a^{(j)}):
m<\infty,\ w_j\ge0,\ \sum_jw_j=1,\ a^{(j)}\in\mathcal K^\circ,\
\sum_jw_jc(a^{(j)})\le C\right\}. \tag{F3}
$$
This finite normalized-column construction is an application of the established framework in [1]. The new input is the order-three structural theorem.

### Coercivity and attainment

The exact identities
$$
S=\sum_i(a_i-1)^2,\quad
U-d=\sum_i(a_i-1)^2(a_i+2),\quad
V-d=\sum_i\frac{(a_i-1)^2(2a_i+1)}{a_i^2}
$$
imply $0\le S<D$, $U\ge d+2S$, $V\ge d$, and
$$
c(a)\ge\frac{2S(a)}{d-1}. \tag{F4}
$$
The last inequality is strict for a nonconstant template. In particular, only the constant template has zero cost. If a positive template approaches the boundary of the closed simplex, then $V\to\infty$ and $U\ge d$, so $c\to\infty$. Every finite cost sublevel is therefore compact.

**Theorem C1 (finite attainment).** Every finite budget has an optimal mixture with at most two templates.

**Proof.** First compress any finite mixture to at most three points in the $(c,S)$ plane. With more than three positive weights, the vectors $(1,c_j,S_j)$ are linearly dependent. Move along a nonzero dependence until a weight becomes zero, retaining all three sums, and repeat.

Take a maximizing sequence of three-position mixtures, padding with zero weights. Pass to a subsequence on which the weights converge. If a limiting weight $w_j>0$, its corresponding costs are eventually at most $2C/w_j$, giving a convergent positive-template subsequence by coercivity. Do this for all positive limiting weights. Zero-weight positions contribute vanishing trace since $S<D$. Their cost contributions need not vanish: discard them, using nonnegativity to retain cost at most $C$. The surviving weights sum to one and attain the limiting optimal trace.

If an optimizer still has three positive weights, choose a nonzero weight direction with $\sum_jv_j=\sum_jv_jc_j=0$. Small perturbations of either sign are feasible. Optimality forces $\sum_jv_jS_j=0$. Continue until one weight vanishes, preserving cost and trace. This leaves at most two templates. $\square$

The disappearing atoms need not have vanishing costs. Assuming this, or assuming the convex hull of a noncompact template set is closed, would leave a gap.

**Theorem C2 (value-function geometry).** The function $F_d$ is continuous, concave, and strictly increasing, with
$$
F_d(0)=0,\quad 0<F_d(C)<D\ (C>0),\quad
F_d(C)\le\frac{d-1}{2}C,\quad \lim_{C\to\infty}F_d(C)=D. \tag{F5}
$$
Every optimizer has average cost exactly $C$.

**Proof.** Mixing finite feasible laws gives concavity. Attainment and $S<D$ give the strict finite-budget upper bound. Singleton templates approaching a vertex have trace approaching $D$, with each individual cost finite. Given $C_2>C_1$, take an optimizer at $C_1$ of cost $r\le C_1$ and a template $(c_*,S_*)$ of larger trace. Necessarily $c_*>C_1$. Mixing it with weight $\min\{1,(C_2-r)/(c_*-r)\}>0$ strictly improves the trace within $C_2$. Thus $F_d$ is strictly increasing; a non-saturating optimizer would contradict this. Zero cost gives only the constant template. A small positive mass on any nonconstant template gives positive trace. Bound (F4) gives continuity at zero, while finite concavity gives interior continuity. The vertex-approaching templates give the limit. $\square$

### Strong duality and the structural bridge

Define
$$
M_d(\tau)=\sup_{a\in\mathcal K^\circ}\{S(a)-\tau c(a)\},\qquad \tau\ge0.
$$
Here $M_d(0)=D$ is not attained. For $\tau>0$, the maximum is attained: the objective goes to minus infinity at the boundary while the constant template gives zero. The function $M_d$ is finite, convex, nonnegative, and nonincreasing.

**Theorem C3 (strong duality).** For every finite $C\ge0$,
$$
F_d(C)=\min_{\tau\ge0}\{\tau C+M_d(\tau)\}. \tag{F6}
$$
For $C>0$ an optimal slope lies in $(0,(d-1)/2)$, no optimal slope is zero, and every positive-weight template in any optimizer is active for every optimal slope.

**Proof.** Averaging the definition of $M_d$ gives weak duality. At $C>0$, choose a supergradient of the finite concave function $F_d$, between its right and left secant slopes:
$F_d(t)\le F_d(C)+\tau(t-C)$ for every $t\ge0$.
Strict increase excludes $\tau\le0$. Taking $t=0$ gives
$\tau\le F_d(C)/C<(d-1)/2$; the strict inequality follows by averaging the strict nonconstant version of (F4) in a saturating optimizer of positive trace.

Each template satisfies $S(a)\le F_d(c(a))$, whence
$S(a)-\tau c(a)\le F_d(C)-\tau C$.
A saturating optimal mixture gives the reverse bound for the maximum. Equality of the average with its pointwise bound makes every positive-weight template active. At $C=0$, slope $(d-1)/2$ and (F4) give equality, with only the constant active template. Finally $M_d(0)=D>F_d(C)$ excludes slope zero. $\square$

Every maximizer at a positive slope minimizes $UV$ at its own second moment: a strict fixed-moment improvement would improve $S-\tau c$. By Theorem A, each nonconstant maximizer is two-level. This proves the connection to the original channel problem without assuming its columns have a special form.

### Finite polynomial contacts and reconstruction

For $1\le s\le d-1$, $r\ge1$, let $L=d+s(r-1)$, $l=d/L$, and $h=rl$. The two-level template with $s$ high coordinates has the established subset formulas [1]
$$
S_s(r)=\frac{ds(d-s)(r-1)^2}{L^2},\qquad
C_s(r)=\frac{s(d-s)(r^3+r^{-2}-r-1)}{(d-1)L}. \tag{F7}
$$
For $\Psi_s=S_s-\tau C_s$,
$$
\Psi_s'(r)=\frac{s(d-s)(r-1)}{r^3(d-1)L^3}Q_{d,s,\tau}(r). \tag{F8}
$$
The coefficients of $Q=\sum_{j=0}^6q_jr^j$ are

| $j$ | $q_j$ |
|---:|---|
| 6 | $-2s^2\tau$ |
| 5 | $s\tau(3s-5d)$ |
| 4 | $d\tau(s-3d)$ |
| 3 | $2d^2(d-1)-\tau(3d^2-2ds+2s^2)$ |
| 2 | $-d\tau(2d+s)$ |
| 1 | $\tau(3s^2-ds-2d^2)$ |
| 0 | $-2\tau(d-s)^2$ |

At positive slope, $\Psi_s(1)=0$ and $\Psi_s(r)\to-\infty$ as $r\to\infty$. Hence
$$
M_d(\tau)=\max\left(\{0\}\cup
\{\Psi_s(r):1\le s\le d-1,\ r>1,\ Q_{d,s,\tau}(r)=0\}\right). \tag{F9}
$$
The set is finite and includes every real root above one and every tie. All coefficients except $q_3$ are negative, so Descartes' rule even gives at most two positive roots. Completeness of (F9) comes from the structural theorem, not from numerical optimization.

Let $\mathcal A_d(\tau)$ be the finite active set, including the constant template when its value zero is maximal. Write $c_-,c_+$ for its minimum and maximum costs.

**Theorem C4 (complete frontier and attaining channel).** For $C>0$, a positive slope is dual-optimal exactly when
$$
c_-(\tau)\le C\le c_+(\tau). \tag{F10}
$$
If $c_-<c_+$, select active templates at these two costs and use weights
$$
w_-=\frac{c_+-C}{c_+-c_-},\qquad w_+=\frac{C-c_-}{c_+-c_-}. \tag{F11}
$$
If the costs coincide, one active orbit suffices. Their orbits attain
$F_d(C)=M_d(\tau)+\tau C$, with at most
$\binom d{s_-}+\binom d{s_+}$ outputs, counting a constant orbit as one.

**Proof.** Necessity follows from budget saturation and the contact condition in Theorem C3. Conversely (F11) averages exactly to cost $C$, and its trace lies on the common supporting line, attaining the weak-duality bound. Formula (F2) realizes the mixture. Equal columns within a subset orbit can be merged, and zero-weight orbits are deleted. $\square$

Thus $F_d$ is exactly the upper concave envelope of the subset curves and the origin. Linear segments, same-slope multiple contacts, and every finite budget are included. This is existence of a two-orbit optimizer, not uniqueness or a claim of minimum communication.

### Exact computation and what the implementation certifies

For rational or real-algebraic budgets, (F8)--(F11), together with the inequalities defining the largest supporting value, form a finite semialgebraic description after clearing positive denominators. For example one may impose the support inequality for each candidate curve by a first-order real formula, and add one or two contact points and (F11). Quantifier elimination over the real closed field of algebraic numbers therefore gives an exact algebraic optimum and attaining mechanism. No polynomial-time bound or implementation of general quantifier elimination is claimed. An arbitrary unspecified real budget requires an input oracle.

A practical rigorous alternative is certified approximation. At a rational slope, use exact real-root isolation and independently verify every isolating interval and the exhaustive root count by Sturm arithmetic. Both $S_s$ and $C_s$ increase on $r>1$. The former follows by differentiation. For the latter, write $H=r^3+r^{-2}-r-1$; $H(1)=H'(1)=0$, $H''>0$, so $(r-1)H'(r)>H(r)$. Since $L=d+s(r-1)$, this gives $H'L-sH>0$.

For any stationary root in $[a,b]$,
$$
S_s(a)-\tau C_s(b)\le \Psi_s(r)\le S_s(b)-\tau C_s(a). \tag{F12}
$$
The maximum of the upper endpoints and zero gives a rational upper bound $M^+$, and therefore the global dual bound $F_d(C)\le\tau C+M^+$. Rational ratios and rational weights with cost at most $C$ give an independently checkable rational primal lower bound. Their exact difference certifies the achieved accuracy.

Active costs are monotone in slope. If $\tau_1<\tau_2$ and $a_i$ is active at $\tau_i$, adding the two maximality inequalities gives
$(\tau_2-\tau_1)(c(a_1)-c(a_2))\ge0$.
For large slope only the constant is active. As $\tau\downarrow0$, $M_d(\tau)\to D$ and the minimum active cost tends to infinity: otherwise a bounded-cost compact subsequence would attain trace $D$ in the positive simplex. These facts justify slope bracketing. At a multiple contact the test is the cost interval (F10), not one selected root's cost.

A run is certified only when its stored rational primal--dual gap meets the requested tolerance. The reported portable certificates were recomputed; some historical detailed run outputs were unavailable. This distinction does not affect the exact mathematical characterization.


## Initial and eventual phases of the order-three frontier

This chapter uses the two-level fixed-moment theorem proved in the companion
chapter and the standard permutation-orbit representation from Shvets,
*The Critical Rényi Order for Sharp Minimax Channel Design*, arXiv:2603.21197v2.
The representation and the two-level cost formulas are prior work; the global
conclusions below use the new order-three structural reduction. All budgets in
this chapter are linear power budgets, not logarithmic Rényi budgets.

### Notation

Fix an integer $d\ge3$ and write $D=d(d-1)$. For a positive mean-one template $a$, let

$$
 S(a)=\sum_i a_i^2-d,\qquad
 c(a)=\frac{(\sum_i a_i^3)(\sum_i a_i^{-2})-d^2}{d(d-1)}.
$$

An orbit mixture has signal and cost equal to the corresponding averages of $S$
and $c$. Denote its optimal signal under cost at most $C$ by $F_d(C)$. The uniform
template has $S=c=0$. Every positive template has $S<D$.

The two-level orbit with $s$ high coordinates and high-to-low ratio $r>1$ has

$$
 S_s(r)=\frac{d s(d-s)(r-1)^2}{[d+s(r-1)]^2},\qquad
 C_s(r)=\frac{s(d-s)(r^3+r^{-2}-r-1)}{(d-1)[d+s(r-1)]}.
$$

For the singleton orbit $s=1$, abbreviate

$$
 S_1(r)=\frac{d(d-1)(r-1)^2}{(d+r-1)^2},\qquad
 C_1(r)=\frac{r^3+r^{-2}-r-1}{d+r-1}.
$$

### Exact initial linear phase

**Theorem D (initial phase and its equality cases).** Let $r_0=r_0(d)$ be the unique
root in $(1,2)$ of

$$
 2r^4+(d+1)r^3-(2d-1)r-2(d-1)=0.
$$

Set $C_0=C_1(r_0)$, $S_0=S_1(r_0)$, and $\kappa_d=S_0/C_0$. Then

$$
 F_d(C)=\kappa_d C\qquad(0\le C\le C_0).
$$

For $0<C<C_0$, the optimal orbit law is the mixture having mass $C/C_0$ on the
singleton orbit of ratio $r_0$ and the remaining mass on the uniform orbit. At
$C=C_0$ it is the pure singleton orbit. These statements classify the orbit law;
output splitting, relabeling, and other equivalent channel presentations need
not be unique. At $C=0$ the signal is zero and the template is uniform almost
surely.

The interval $[0,C_0]$ is the maximal initial interval on which the frontier equals
the line $\kappa_d C$. In particular $F_d(C)<\kappa_d C$ for $C>C_0$.

**Proof.** Factor

$$
 r^3+r^{-2}-r-1=(r-1)^2 B(r),\qquad
 B(r)=r+2+2r^{-1}+r^{-2}>0.
$$

For every two-level orbit,

$$
 \frac{C_s(r)}{S_s(r)}
 =\frac{[d+s(r-1)]B(r)}{d(d-1)}.
$$

At a fixed $r>1$ this ratio is strictly increasing in the positive integer $s$.
Consequently its global minimum over two-level orbits occurs at $s=1$. The
fixed-moment theorem extends the inequality to every positive template: replace
a nonuniform template by a minimum-cost template at exactly the same signal,
then apply the two-level formula. Equality in this replacement forces the
original template itself to be a two-level minimizer.

It remains to minimize

$$
 \Phi_d(r)=(d+r-1)B(r)
 =r^2+(d+1)r+2d+(2d-1)r^{-1}+(d-1)r^{-2}.
$$

Its second derivative is strictly positive for $r>0$:

$$
 \Phi_d''(r)=2+2(2d-1)r^{-3}+6(d-1)r^{-4}>0.
$$

Furthermore $\Phi_d'(1)=6-3d<0$ and $\Phi_d'(2)=(d+22)/4>0$. The unique minimizer is
therefore $r_0\in(1,2)$, and multiplication of $\Phi_d'(r_0)=0$ by $r_0^3$ gives the displayed
quartic. This proves the pointwise inequality $S(a)\le\kappa_d c(a)$. Its nonzero equality
case is precisely the singleton orbit of ratio $r_0$; the other equality case is
the uniform template. Averaging yields $F_d(C)\le\kappa_d C$.

The matching mechanism has at most $d+1$ visible outputs. With $\omega=C/C_0$, emit a null symbol
with probability $1-\omega$, independently of the input. Otherwise apply randomized
response with transition probabilities

$$
 K_{r_0}(j\mid i)=
 \begin{cases}
 r_0/(r_0+d-1),&j=i,\\
 1/(r_0+d-1),&j\ne i.
 \end{cases}
$$

The null branch is visible, so its power cost and information signal mix
linearly: the resulting pair is $(\omega C_0,\omega S_0)$. Zero-weight outputs are deleted at
$\omega=0$ or $\omega=1$. For equality in the averaged upper
bound, every supported orbit must be one of the two equality orbits above, and
the budget must be tight. This also proves the stated equality classification.

For $C>C_0$, equality with $\kappa_d C$ would require a mixture of the same two orbits
whose cost is $C$; such a mixture has cost at most $C_0$. The all-budget attainment
theorem therefore makes the upper bound strict. Alternatively, once compactness
of the feasible optimal orbit laws is established, the same conclusion follows
directly by taking a convergent maximizing sequence. ∎

#### Geometry of the singleton family

The following auxiliary result is useful both for the eventual tail and for the
small-dimension corollary.

**Lemma (the complete singleton-mixture envelope).** Among visible mixtures of
singleton orbits and the uniform orbit, the optimal signal is $\kappa_d C$ for $C\le C_0$
and $S_1(r(C))$ for $C\ge C_0$, where $r(C)>1$ is the unique solution $C_1(r)=C$. Above $C_0$
the optimal orbit law is concentrated on this single ratio.

**Proof.** Both $C_1$ and $S_1$ are strictly increasing on $(1,\infty)$, and $C_1$ ranges from
zero to infinity. To see the cost monotonicity without a long numerator, put
$H(r)=r^3+r^{-2}-r-1$. Then $H(1)=H'(1)=0$ and $H''(r)=6r+6r^{-4}>0$. Thus
$H'(r)(r-1)>H(r)$, which implies $C_1'(r)>0$.

Regarding cost as a function of signal, its second derivative has the sign of

$$
\begin{aligned}
 P_d(r)={}&d^2(3r^4-2r^2-4r-6)\\
 &+d(10r^5-r^4-r^2-2r+12)+6(r-1)(r^5+1).
\end{aligned}
$$

More precisely,

$$
 C_1''(r)S_1'(r)-C_1'(r)S_1''(r)
 =\frac{2d^2(d-1)(r-1)^2P_d(r)}{r^4(d+r-1)^6}.
$$

For $t=r-1$,

$$
\begin{aligned}
 P_d(1+t)={}&-9d(d-2)+(4d^2+42d+12)t\\
 &+(16d^2+93d+30)t^2+(12d^2+96d+60)t^3\\
 &+(3d^2+49d+60)t^4+(10d+30)t^5+6t^6.
\end{aligned}
$$

This polynomial is strictly increasing for $t>0$, starts negative, and tends to
infinity. Therefore the cost curve has exactly one inflection, changing from
strict concavity to strict convexity.

Let $c(S)$ denote this cost curve and $b(S)=S c'(S)-c(S)$. Since $b'(S)=S c''(S)$, $b$
first decreases and then increases. It starts at zero and tends to infinity as
$S\uparrow D$. Its unique positive zero is the minimum-ratio point $S_0$ already identified
above, which lies strictly beyond the inflection. Hence the function equal to
$(C_0/S_0)S$ on $[0,S_0]$ and to $c(S)$ on $[S_0,D)$ is convex and lies below $c$.
It is the greatest convex minorant: any convex minorant is below the chord from
the origin to $(S_0,C_0)$ before $S_0$, and below $c$ thereafter. Inverting this
strictly increasing minorant gives the claimed signal-versus-cost envelope.
Strict convexity after $S_0$ gives its equality statement. ∎

### Eventual pure-singleton phase and sharp high-budget expansion

**Theorem E (a finite pure-singleton tail).** For every fixed $d\ge3$ there is a finite,
explicitly computable $C_{\mathrm{tail}}(d)$ such that

$$
 F_d(C)=S_1(r(C))\qquad(C\ge C_{\mathrm{tail}}(d)),
$$

with $r(C)$ defined by $C_1(r(C))=C$. In this range every optimal orbit law is
concentrated on that singleton orbit. As $C\to\infty$ with $d$ fixed,

$$
\begin{aligned}
 F_d(C)={}&d(d-1)-2d^2(d-1)C^{-1/2}\\
 &+d^2(d-1)(4d-3)C^{-1}+O_d(C^{-3/2}).
\end{aligned}
$$

This is an eventual-tail theorem. The threshold constructed below is sufficient;
it is not asserted to be the first budget at which the pure singleton becomes
optimal.

**Proof of eventual purity.** For $\tau>0$ maximize the supporting functional
$S(a)-\tau c(a)$. It has an interior maximizer: $S$ is bounded above by $D$, whereas $c$
diverges at the boundary of the positive simplex. The fixed-moment theorem
allows every maximizer to be chosen two-level; its equality classification shows
that every nonuniform maximizer is itself two-level.

For every $s\ge2$,

$$
 S_s(r)<\frac{d(d-s)}s\le L_2:=\frac{d(d-2)}2<D.
$$

Let $L=\max\{L_2,S_1(2)\}$, $r_a=4d$, and define

$$
 \bar\tau=\frac{S_1(4d)-L}{2C_1(4d)}>0.
$$

The numerator is positive. Monotonicity gives $S_1(4d)>S_1(2)$, while the other
comparison reduces to the elementary positive polynomial

$$
 2(d-1)(4d-1)^2-(d-2)(5d-1)^2=d(7d^2+12d-3)>0.
$$

For $0<\tau\le\bar\tau$, the supporting maximum is at least
$S_1(4d)-\tau C_1(4d)>L$. It therefore cannot be uniform, cannot have $s\ge2$, and cannot
have singleton ratio at most $2$. Every maximizing orbit has $s=1$ and $r>2$.

The singleton cost curve is strictly convex for $r\ge2$. This also follows directly
from the displayed $P_d$: all three grouped terms are positive for $r\ge2$. Thus the
supporting maximum is unique in that range. Its ratio is characterized by

$$
 \tau=\frac{S_1'(r)}{C_1'(r)}.
$$

The right side is continuous and strictly decreasing for $r\ge2$, and tends to zero.
Let $r_{\mathrm{tail}}>2$ be the unique solution at $\tau=\bar\tau$, whose existence was just supplied
by the supporting maximizer, and put $C_{\mathrm{tail}}=C_1(r_{\mathrm{tail}})$. The unique maximizers
for $0<\tau\le\bar\tau$ then sweep all $r\ge r_{\mathrm{tail}}$ and hence all $C\ge C_{\mathrm{tail}}$. Supporting-line
duality gives the frontier identity. Equality in the support bound requires a
mixture to be concentrated on the unique maximizing orbit, proving eventual
purity. All constants in this sufficient threshold are explicit rational
functions of $d$ apart from one uniquely specified algebraic root.

**Proof of the expansion.** Put $a=d-1$ and $D=da$. Polynomial division gives

$$
 C_1(r)=r^2-ar+a^2-1+
 \frac{-a^3+a-1+r^{-2}}{r+a}.
$$

Consequently

$$
 r(C)=\sqrt C+\frac a2+
 \left(\frac12-\frac{3a^2}{8}\right)C^{-1/2}+O_d(C^{-1}).
$$

The exact signal deficit is

$$
 D-S_1(r)=\frac{2dD}{r+a}-\frac{d^2D}{(r+a)^2}.
$$

Since $r(C)+a=\sqrt C+3a/2+O_d(C^{-1/2})$, substitution yields the asserted two leading
deficit terms. The remainder is for fixed $d$; no uniformity in growing dimension
is claimed. For logarithmic order-three budget $R$, $C=e^{2R}-1$, so the leading
deficit is $2d^2(d-1)e^{-R}$. ∎

### A dimension-free fraction bound and a complete low-dimensional corollary

Let $p_*(v)$ be the unique continuous optimal high-level fraction from the adjacent
count theorem, for arbitrary $v>0$.

**Lemma (one-twelfth bound).** For every $v>0$,

$$
 0<p_*(v)<\frac1{12}.
$$

**Proof.** If $v\ge11$, feasibility gives $p_*<1/(1+v)\le1/12$. Suppose $0<v<11$ and put
$t=\sqrt{v/11}$, so $0<t<1$. The coordinate corresponding to $p=1/12$ is $z=1+10t$, and
$z-v=(1-t)(1+11t)>0$. Substitution into the critical polynomial gives

$$
 G_{11t^2}(1+10t)=-P_{12}(t),\qquad
 P_{12}(t)=3421t^4+210t^3-168t^2-10t+3.
$$

The following exact rational sum of squares is strictly positive for every real
$t$:

$$
\begin{aligned}
 P_{12}(t)={}&3421\left(t^2+\frac{105}{3421}t-\frac1{35}\right)^2
 +\frac{31487}{119735}t^2\\
 &+24\left(t-\frac1{12}\right)^2+\frac{299}{7350}>0.
\end{aligned}
$$

Thus $G_v(z)<0$. The critical-polynomial sign theorem gives $z<z_*(v)$, and the
inverse fraction map is strictly decreasing, proving $p_*(v)<1/12$. ∎

**Corollary (complete frontier for $3\le d\le12$).** For every integer $3\le d\le12$ and every
finite $C\ge0$, the full frontier is

$$
 F_d(C)=
 \begin{cases}
 \kappa_d C,&0\le C\le C_0,\\
 S_1(r(C)),&C\ge C_0.
 \end{cases}
$$

The optimal orbit laws are exactly the visible-null/singleton mixture in the
first range and the pure singleton orbit in the second range, with the two
descriptions agreeing at $C=C_0$.

**Proof.** For every feasible $v\in(0,d-1)$, the adjacent-count theorem and
$d p_*(v)<1$ force the unique minimizing count to be $s=1$. Hence every template can
be replaced by a singleton template at the same signal and weakly smaller cost;
equality forces the singleton permutation class. The complete channel frontier
is therefore the singleton-mixture envelope already proved above. ∎

The bound $12$ is the analytic base of the sharper dimension classification in the
main manuscript. The extension through dimensions $13$–$17$ uses the separate
exact Bernstein certificates, whose numerical files are not included in this edition. The strict dimension-$18$
separation from all singleton mixtures uses its separate exact dual certificate.
Those additional certificates, rather than the one-twelfth lemma alone, are
needed to conclude that $18$ is the smallest failure dimension.

### Reproducibility and verification status

A reported symbolic computation checks every displayed rational identity,
including the quartic, both curvature forms, the one-twelfth sum of squares,
and the two-term high-budget expansion, using exact symbolic arithmetic. The machine-readable results are not included in this edition.
These checks complement the arguments proving positivity, existence, equality
cases and full-domain coverage; they do not replace those arguments.

Full Lean formalization is incomplete; uncompiled source does not establish kernel verification.


## The sharp dimension-eighteen threshold

**Theorem H.** For every $3\le d\le17$ and every finite budget $C\ge0$,
$$
F_d(C)=
\begin{cases}
\kappa_d C,&0\le C\le C_0(d),\\
S_1(r(C)),&C\ge C_0(d),
\end{cases} \tag{H1}
$$
where $C_1(r(C))=C$ and the initial-phase theorem defines $C_0,\kappa_d$. At dimension eighteen, the two-high-coordinate subset orbit with ratio three has
$$
C=\frac{3328}{1683},\qquad S=\frac{576}{121}, \tag{H2}
$$
whereas every feasible singleton-supported channel, including every mixture of ratios and the constant template, has trace strictly below $19/4$. The separation is therefore strictly greater than $5/484$. Eighteen is the smallest dimension at which the entire singleton family fails at some order-three budget.

### Excluding dimensions thirteen through seventeen

The one-twelfth lemma gives $dp_*(v)<1$ for $d\le12$, hence a unique singleton fixed-moment optimizer. For $13\le d\le17$, it gives $dp_*(v)<2$, so the adjacent-count theorem leaves only counts one and two. If count two is not feasible, only one remains. Otherwise $0<v<(d-2)/2$. Set
$$
t=\sqrt v,\quad A_d=\frac{d-2}{\sqrt{d-1}},\quad
B_d=\frac{d-4}{\sqrt{2(d-2)}},\quad M=A_d+B_d,\quad P=A_dB_d.
$$
Then $A_d>B_d>0$, and the scalar coordinates are $z_1=1+A_dt,z_2=1+B_dt$. For $f_v(z)=(1+2v+vz)(z^2+v)/(z-v)^2$, exact clearing of denominators gives
$$
f_{t^2}(1+B_dt)-f_{t^2}(1+A_dt)=
\frac{-t^3(A_d-B_d)G_d(t)}
{(1+A_dt-t^2)^2(1+B_dt-t^2)^2}, \tag{H3}
$$
where $G_d(t)=\sum_{j=0}^6g_jt^j$ and
$$
\begin{aligned}
g_0&=-3,&g_1&=-M,&g_2&=M^2-9,\\
g_3&=2M(P-6),&g_4&=P^2-2M^2-9P+11,\\
g_5&=M(5-2P),&g_6&=M^2-P+1.
\end{aligned} \tag{H4}
$$
Both denominators are positive in the joint feasible range. We prove $G_d<0$ over the whole interval, so $J_2>J_1$.

For each required positive rational $x$, put
$$
\ell_x=\frac{\lfloor10^6\sqrt x\rfloor}{10^6},\qquad
u_x=\ell_x+10^{-6}. \tag{H5}
$$
The numerator is the integer square root of $\lfloor10^{12}x\rfloor$, and both inequalities are verified by squaring. Rational interval arithmetic in (H4), using $x=d-1,2(d-2),(d-2)/2$, produces upper coefficients $g_j^+\ge g_j$. Set $T_d=u_{(d-2)/2}$. Since $t\ge0$, the polynomial with these upper coefficients dominates $G_d$.

On $[a,b]\subset[0,T_d]$ compute
$$
q_j=\sum_{k=j}^6g_k^+\binom kj a^{k-j}(b-a)^j,\qquad
\beta_i=\sum_{j=0}^i q_j\frac{\binom ij}{\binom6j}. \tag{H6}
$$
The degree-six Bernstein basis is nonnegative and sums to one after $t=a+(b-a)x$, $0\le x\le1$. Therefore seven bounds $\beta_i\le-\delta$ prove $G_d\le-\delta<0$ over the entire interval. The complete certificate uses these partitions:

| $d$ | Partition endpoints divided by $T_d$ | Common margin $\delta$ |
|---:|---|---:|
| 13 | $0$, $1/2$, $1$ | $1$ |
| 14 | $0$, $1/4$, $1/2$, $1$ | $2$ |
| 15 | $0$, $1/4$, $1/2$, $1$ | $3/2$ |
| 16 | $0$, $1/4$, $1/2$, $1$ | $2/5$ |
| 17 | $0$, $1/8$, $1/4$, $1/2$, $1$ | $1/20$ |

The reported finite certificate comprises radical enclosures, coefficient intervals, endpoints, and 105 Bernstein upper bounds. Exact BigInt rational computations check full interval coverage and each negative margin; an independent expansion uses different root enclosures and recomputes the Sturm chain. This is a finite interval certificate for continuous intervals, not a finite grid test. The computation files are not included in this edition.

It follows that every fixed-moment minimizer for $d\le17$ is a singleton. Replacing every template in any finite mixture by its same-signal fixed-moment minimizer weakly lowers cost. The full frontier is therefore the singleton envelope already proved in the budget-regime section, giving (H1).

### An exact witness at dimension eighteen

Substituting $d=18,s=2,r=3$ into the subset formulas gives (H2). To bound all singleton ratios, take $\tau=19/10$. Up to a nonzero factor, the derivative polynomial has descending integer coefficients
$$
38,\ 1653,\ 18126,\ -92338,\ 12654,\ 12597,\ 10982. \tag{H7}
$$
Exact Sturm counting shows a single real root above one, isolated in
$$
\left[\frac{35719}{10000},\frac{893}{250}\right]. \tag{H8}
$$
The monotone endpoint bound for its supporting value, including the constant candidate zero, yields
$$
\frac{19}{10}\frac{3328}{1683}+M^+
=\frac{18484982566066660076382578632067291}
{3894654150843130885552551000000000}
<\frac{19}{4}<\frac{576}{121}. \tag{H9}
$$
In particular $576/121-19/4=5/484$. The reported exact computation directly checks the moment formulas, rational derivative identity, exhaustive root count, isolated root, endpoint upper bound, and strict separation. The exact output is not included in this edition.

A singleton-supported channel need not be exchangeable. Identity (F1) still bounds its average template cost by its maximum directed cost. Integrating the affine supporting bound therefore controls every mixture, including visible null thinning. The subset orbit strictly exceeds it.

The dimension-eighteen qualitative phenomenon was reported numerically in [1, Remark 5.2]. The result here adds rigorous exclusion of every smaller dimension and an exact rational witness. It does not assert that every $d>18$ has the same phase diagram, that (H2) is the first failure budget, or that this particular rational orbit is itself exactly optimal at that budget.


## Exact finite-sample globally unbiased minimax risk

The score and symmetric canonical-estimation tools in this section are established arguments used in [1, Sections 3 and 6.2]. The new input is the complete order-three frontier and its finite exchangeable attaining channel.

**Theorem G.** Fix $d\ge3$, $n\ge1$, and $0<C<\infty$. Inputs are i.i.d. with distribution $\theta\in\Delta_d$. Each passes independently through the same feasible finite-output channel, with one message and no interaction. Among all such channels and all integrable, globally unbiased $\mathbb R^d$-valued estimators,
$$
\inf_W\ \inf_{\widehat\theta:\ \mathbb E_{\theta,W}\widehat\theta=\theta\
\forall\theta\in\Delta_d}\ \sup_{\theta\in\Delta_d}
\mathbb E_{\theta,W}\|\widehat\theta-\theta\|^2
=\frac{(d-1)^2}{nF_d(C)}. \tag{G1}
$$

**Lower bound.** Write $u=\mathbf1/d$, choose an orthonormal basis matrix $H$ for $\mathbf1^\perp$, and define $v=a-\mathbf1$, $x=H^\top v$, and $q_0=\overline W$. At the uniform parameter,
$\mathbb E_0x=0$ and
$T=\mathbb E_0\|x\|^2=\mathbb E_0S(a)\le F_d(C)$.
The local parametrization $\theta=u+H\eta$ has message probabilities
$q_\eta(y)=q_0(y)(1+\eta^\top x(y))$.
For $Z=\sum_{r=1}^n x(Y_r)$ and $\widehat\eta=H^\top(\widehat\theta-u)$, global unbiasedness differentiated at zero gives
$$
\mathbb E_0[\widehat\eta Z^\top]=I_{d-1},\qquad
\mathbb E_0\|Z\|^2=nT. \tag{G2}
$$
This is differentiation of a finite sum. Estimator randomization may first be conditionally averaged. Infinite risk at the uniform point already proves the lower bound. Taking the trace and applying Cauchy--Schwarz gives
$$
(d-1)^2\le\mathbb E_0\|\widehat\eta\|^2\,nT
\le\mathbb E_0\|\widehat\theta-u\|^2\,nT.
$$
If an unbiased estimator exists, (G2) excludes $T=0$. This proves the lower bound.

**Attainment.** Choose the finite exchangeable frontier channel with $F=F_d(C)>0$. Permutation invariance and $\sum_i v_i=0$ imply
$$
\mathbb E_0[vv^\top]=\kappa P_T,\quad
\mathbb E_0[\|v\|^2v]=0,\quad
\kappa=\frac F{d-1},\quad P_T=I-\frac1d\mathbf1\mathbf1^\top.
$$
Indeed the first matrix has equal diagonal and equal off-diagonal entries, zero row sums and trace $F$; the second vector has equal coordinates whose sum is zero. Since
$q_\theta=q_0(1+\langle\theta-u,v\rangle)$,
$$
\mathbb E_\theta v=\kappa(\theta-u),\qquad
\mathbb E_\theta\|v\|^2=F.
$$
The estimator
$$
\widehat\theta=u+\frac{d-1}{nF}\sum_{r=1}^n(a(Y_r)-\mathbf1) \tag{G3}
$$
is globally unbiased, with exact risk
$$
\frac1n\left(\frac{(d-1)^2}{F}-\|\theta-u\|^2\right). \tag{G4}
$$
The worst point is uniform, proving (G1). No uniqueness of the optimal channel is asserted.

The estimator's coordinates sum to one but need not be nonnegative. The class cannot be replaced by globally unbiased simplex-valued estimators: unbiasedness and nonnegativity force the value to equal a vertex under that vertex's sample law, while common positive support makes all vertex sample laws mutually equivalent, contradicting unbiasedness at another vertex. At $C=0$ all rows coincide and no globally unbiased estimator exists. The theorem makes no claim about finite-sample biased minimax risk, interaction, multiple messages, or growing dimensions.


## Certified computation examples

The dependency-free portable solver checks every admissible high multiplicity, isolates the complete supporting-polynomial root set, and produces a rational feasible channel together with a rational global dual upper bound. The original manuscript reports eight solved and reverified cases. Five altered-certificate tests were rejected, including an attempt to pass a singleton-only bound as a full-frontier certificate. The solver files and execution reports are not included in this edition.

The table gives outward-rounded rational intervals for the exact optimum. Both decimal endpoints are obtained by integer arithmetic from the exact stored fractions. The final column describes the constructed near-optimal mixture; repeated counts denote two nearby ratios in the same family. It does not prove that every exact optimizer must have those counts.

| $d$ | $C$ | Certified interval containing $F_d(C)$ | Constructed high counts |
|---:|---:|---|---|
| 3 | $0$ | $[0,\ 0]$ | null |
| 3 | $1/10000$ | $[0.000033741581,\ 0.000033741618]$ | null, 1 |
| 3 | $1$ | $[0.297572758755,\ 0.297572765879]$ | 1, 1 |
| 18 | $11/10$ | $[2.936114706592,\ 2.936114709955]$ | 1, 2 |
| 18 | $3328/1683$ | $[4.760330573943,\ 4.760330579910]$ | 2, 2 |
| 18 | $33/10$ | $[7.049179201149,\ 7.049179203320]$ | 2, 1 |
| 50 | $1$ | $[7.805547721373,\ 7.805547767490]$ | 4, 4 |
| 30 | $10000$ | $[539.558117244858,\ 539.558117253403]$ | 1, 1 |

The exact fractions, mixing weights, supporting slopes, all root intervals, and verifier results are stored in the portable result files. These examples test implementation and illustrate the proved all-budget characterization; they are not the proof of that characterization.


## Reproducibility, verification levels, and remaining questions

The complete coefficient table and the polynomial identity in the structural section are a self-contained finite certificate. The original manuscript reports agreement of the generator and independent reconstruction of the 167-term and 809-term coefficient maps, nineteen exact checks, and a fresh integer expansion of the 167-term identity with zero residual and strictly positive coefficients. These are exact arithmetic checks, not Lean proofs.

The original manuscript reports independent reconstruction of the sharp-dimension certificate, including fifteen intervals and 105 Bernstein upper coefficients, and separate verification of the dimension-eighteen witness using exact rational derivatives, direct moments, Sturm root counts, and a strict rational upper bound.

The original manuscript reports fifteen successful exact symbolic checks of the phase identities. Some historical detailed outputs were unavailable. The numerical exploration found no counterexample in 528 unrestricted-template comparisons and 63 three-level searches; these finite searches do not prove universal structure.

The numerical verification files and original execution reports are not included in this edition. The reported computations have not been independently replayed during its preparation.

Full Lean formalization is incomplete; no full compilation or axiom-closure verification or external peer review is claimed.

The general order-$\alpha>2$ classification, exact finite-sample biased minimax risk, optimal communication for every attaining channel, and a compact description of all high-dimensional transitions remain distinct questions. They do not restrict the all-dimension, all-finite-budget order-three value and finite attaining construction proved here.

## References

[1] Alex Shvets. *The Critical Rényi Order for Sharp Minimax Channel Design*. arXiv:2603.21197v2, 24 October 2026. <https://arxiv.org/html/2603.21197v2>. Verification archive: <https://doi.org/10.5281/zenodo.24063702>.

[2] Alex Shvets. *Uniform Rényi Privacy Amplification by Shuffling*. Version of 9 November 2026. <https://doi.org/10.5281/zenodo.24088069>.

[3] Dominic W. Berry and Barry C. Sanders. *Bounds on general entropy measures*. Journal of Physics A: Mathematical and General 36(49), 12255--12265, 2003. <https://arxiv.org/abs/quant-ph/0305059v3>.

[4] Yuta Sakai and Ken-ichi Iwata. *Sharp Bounds Between Two Rényi Entropies of Distinct Positive Orders*. arXiv:1605.00019v2, 2016. <https://arxiv.org/abs/1605.00019v2>.

[5] Peter Kairouz, Sewoong Oh, and Pramod Viswanath. *Extremal Mechanisms for Local Differential Privacy*. Journal of Machine Learning Research 17(17), 1--51, 2016. <https://www.jmlr.org/papers/v17/15-135.html>.

[6] Hyun-Young Park, Seung-Hyun Nam, and Si-Hyeon Lee. *Exactly Optimal and Communication-Efficient Private Estimation via Block Designs*. IEEE Journal on Selected Areas in Information Theory 5, 123--134, 2024. Extended version: <https://arxiv.org/abs/2305.01261v3>.

[7] Seung-Hyun Nam, Hyun-Young Park, and Si-Hyeon Lee. *Optimal Privacy-Utility Trade-Offs in LDP: Functional and Geometric Perspectives*. <https://arxiv.org/abs/2605.02319>. The latest revision's full text was unavailable in this audit; the comparison uses accessible scope information and the explicit citations in [1].
