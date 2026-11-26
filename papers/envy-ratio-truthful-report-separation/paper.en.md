# Truthful reports break the optimal report-independent envy-ratio barrier

## Abstract

We study one-facility location on the fixed interval $[0,1]$ with utilities
$1-|y-x_i|$ and the expected **ex post** envy ratio, normalized by the optimal
deterministic envy ratio. A known report-independent three-point lottery achieves
$V=1+2/\sqrt5$. We prove that $V$ is the exact optimum over **all Borel
report-independent lotteries**, and that the known three-point law is the unique
optimizer. Its lower certificate uses only two adversarial profiles.
Reports nevertheless have strict value: a universally strategyproof, anonymous,
unanimous mechanism obtained by clamping a random phantom to the reported
extremes achieves $176/97$ with five atoms, and
$2340000389/1293292000<1.81$ with thirteen rational atoms, for every number of
agents $n\ge2$. An exact rational polynomial certificate gives the all-Borel
single-phantom lower bound $3617/2000$. We then prove that the infimum for this
single-phantom family equals the infimum over **all unanimous universally
strategyproof mechanisms**, without requiring anonymity. Thus the optimum of
the latter class lies in an interval of width less than $0.000837$.
The reduction follows directly from strategyproofness and does not invoke an
unverified full-domain mechanism characterization. Finally, a truncation and
quantization theorem supplies a convergent hierarchy of finite rational linear
programs for the infinite-dimensional optimum. All displayed finite bounds are
certified over the continuous report domain, not inferred from sampled profiles.

**Status.** Research manuscript; no external peer review or worldwide priority
certificate is claimed. Proof-assistant formalization is a separate, pending
deliverable. The finite computations below use ordinary exact rational arithmetic.

# 1. Problem, results, and relation to prior work

## 1.1 The objective and mechanism classes

Fix an integer $n\ge2$. Agent $i$ has a true location $x_i\in[0,1]$ and utility
$u_i(y,x)=1-|y-x_i|$ when the facility is at $y\in[0,1]$. Put
$U_x(y)=\max_i u_i(y,x)$ and $W_x(y)=\min_i u_i(y,x)$. Define

$$
E(y,x)=
\begin{cases}
U_x(y)/W_x(y),&W_x(y)>0,\\
+\infty,&W_x(y)=0 \lt U_x(y),\\
1,&U_x(y)=W_x(y)=0.
\end{cases}
\tag{1.1}
$$

The final convention makes every coincident profile have envy ratio one,
including the exceptional common-zero-utility case. Let

$$
\operatorname{opt}(x)=\min_{y\in[0,1]}E(y,x),\qquad
\rho_n(M)=\sup_{x\in[0,1]^n}
\frac{\mathbb E[E(M(x),x)]}{\operatorname{opt}(x)}.
\tag{1.2}
$$

Expectations are extended integrals of nonnegative Borel functions. In particular,
an infinite loss is not silently discarded. The objective is the expectation
of the realized ratio. It is not the ratio of agents' expected utilities: the
lottery assigning equal mass to 0 and 1 makes every expected utility $1/2$ and
would trivialize that different objective.

A deterministic rule $f$ is **strategyproof** if, for every agent, true type $t$,
alternative report $r$, and fixed other reports,

$$
|t-f(t,x_{-i})|\le |t-f(r,x_{-i})|.
\tag{1.3}
$$

It is **unanimous** if $f(t,\ldots,t)=t$ for every $t$. A universally
strategyproof mechanism draws, independently of reports, a deterministic
strategyproof rule from a probability space. Whenever we call this randomized
class unanimous, unanimity is required of each deterministic realization (or of
every realization in one fixed full-measure set). Measurability of the output
at every profile is assumed. Anonymity is not imposed on this full class.

There are two different uses of a report-independent law in this paper.
A **constant lottery** draws $Y\sim\mu$ and directly outputs $Y$.
A **single-phantom mechanism** draws $Z\sim\mu$ and outputs

$$
f_Z(x)=\operatorname{clamp}(Z,a,b),\qquad
a=\min_i x_i,\quad b=\max_i x_i,
\quad\operatorname{clamp}(z,a,b)=\min\{b,\max\{a,z\}\}.
\tag{1.4}
$$

The latter output uses the reports even though its seed law does not.

## 1.2 Main conclusions

**Theorem 1 (constant-lottery optimum and uniqueness).** For every $n\ge2$,
the infimum of (1.2) over all Borel constant lotteries is

$$
V=1+\frac2{\sqrt5}.
$$

The unique optimal law is

$$
\mu_0=\frac25\delta_\alpha+\frac15\delta_{1/2}
+\frac25\delta_\beta,\qquad
\alpha=\frac{3-\sqrt5}{2},\quad\beta=1-\alpha.
\tag{1.5}
$$

**Theorem 2 (strict improvement using truthful reports).** There exist
anonymous, unanimous, universally strategyproof single-phantom mechanisms,
with five and thirteen rational atoms respectively, whose exact worst-case
ratios for every $n\ge2$ are

$$
U_5=\frac{176}{97}=1.8144329896\ldots,
\qquad
U_{13}=\frac{2340000389}{1293292000}=1.8093364754\ldots \lt V.
\tag{1.6}
$$

**Theorem 3 (a common optimum for a full truthful class).** Let $C_*$ be the
infimum of (1.2) over all Borel single-phantom laws. For every fixed $n\ge2$,
the infimum over all unanimous universally strategyproof mechanisms equals
$C_*$, with no anonymity assumption, and

$$
\frac{3617}{2000}\le C_*\le U_{13},\qquad
U_{13}-\frac{3617}{2000}
=\frac{1081807}{1293292000}<\frac{837}{10^6}.
\tag{1.7}
$$

The same infimum therefore governs all randomized unanimous generalized
medians described in Section 6.5, even with arbitrarily correlated phantom
coordinates. We do not claim an exact
closed form for $C_*$, existence or uniqueness of an optimizing Borel law, or
a matching lower bound for mechanisms that are truthful only in expectation
or fail unanimity.

**Theorem 4 (certified finite approximation).** If a finite grid $G$ lies in
$[\delta,1-\delta]$, where $0<\delta<1/2$, and covers that interval to distance
$h$, let $C_G$ be the optimal single-phantom ratio with support in $G$. Then

$$
C_*\le C_G\le C_*+\frac{\delta}{1-\delta}+\frac{2h}{\delta^2}.
\tag{1.8}
$$

For rational $G$, $C_G$ is exactly the value of a finite rational linear
program. In particular, for

$$
G_m=\{j/m^3:m^2\le j\le m^3-m^2\},\qquad m\ge3,
$$

the corresponding values satisfy
$C_*\le C_{G_m}\le C_*+1/(m-1)+1/m$.

## 1.3 What is inherited and what is added

Ding, Liu, Chen, Fang, and Nong [D20] introduced the facility-location envy
ratio and studied both a fixed-interval model and a different relative-interval
model. This paper uses only the fixed interval and the expected ex post
criterion. Aziz, Guo, Lam, and Zhou [A25] gave the three-atom law (1.5), its
$1+2/\sqrt5$ guarantee, and optimality within their parameterized constant
three-point family. Their official NeurIPS 2025 main-conference paper is the
direct technical benchmark. Their Lemma 3.1 and Appendix A.1 already give the
pointwise reduction from arbitrary agent profiles to their extremes. We
reprove these supporting statements to make conventions and quantifiers explicit;
they are not counted as new contributions.

Theorem 1 adds an all-Borel lower certificate and an equality characterization,
without symmetry, finite-support, or density assumptions. Theorem 2 adds
strictly better report-dependent guarantees. Theorem 3 identifies the exact
infinite-dimensional optimization problem for the whole unanimous universally
strategyproof class and tightly bounds its value. Theorem 4 gives a certified
way to approximate that infinite-dimensional problem by finite rational ones.
The novelty lies in this combination of a sharp information-use obstruction,
a strict constructive separation, and a class-wide reduction and certificate.

Phantom and generalized-median strategyproof mechanisms are classical
[M80, EPS02]. Aziz, Lam, Suzuki, and Walsh [ALSW22, proof of Theorem 3]
already use two-location profiles with fixed multiplicities to constrain
the marginal laws of random phantom order statistics. That technique is
not claimed as new here; our new application reduces the envy-ratio
minimax problem to a single Borel phantom law and connects that problem
to the quantitative certificates above.
Our claim is not to introduce the phantom mechanism idea. The direct
proof in Section 6 also prevents a domain error: on symmetric single-peaked
preferences, unrestricted strategyproof rules need not be ordinary generalized
medians when unanimity or surjectivity is dropped [MM11]. Section 8 supplies
an explicit example in the present model. Literature comparisons are bounded
by the sources and searches documented with this manuscript; they do not
establish worldwide priority.

# 2. Reductions on the entire continuous domain

## 2.1 Midpoint optimality and extremes

Write

$$
m=(a+b)/2,\qquad s=(b-a)/2,\qquad c=1-s,
\qquad v=U_x(m).
$$

**Lemma 2.1 (midpoint optimum).** The point $m$ minimizes envy, with
$\operatorname{opt}(x)=v/c$ and $1\le v/c\le2$. If $a \lt b$, this minimizer
is unique. Coincident profiles have envy one everywhere.

**Proof.** The extreme reports realize the largest distance from every $y$,
so, with $d=|y-m|$,

$$
W_x(y)=c-d. \tag{2.1}
$$

Each utility is 1-Lipschitz; their finite maximum $U_x$ is 1-Lipschitz too.
Since $c\le v\le1$, whenever $c-d>0$,

$$
E(y,x)\ge\frac{v-d}{c-d}\ge\frac vc,
\qquad
\frac{v-d}{c-d}-\frac vc
=\frac{d(v-c)}{c(c-d)}\ge0.
\tag{2.2}
$$

For a noncoincident profile, a zero denominator means positive maximum
utility and infinite envy. For a coincident profile, use (1.1) directly.
The value bounds follow from $c\ge1/2$. If $v>c$, (2.2) is strict when
$d>0$. If $v=c$, every report is at one of the two extremes, and only the
midpoint equalizes their utilities. This proves uniqueness when $a \lt b$. $\square$

**Lemma 2.2 (pointwise extreme-profile domination).** For the two-location
profile $e=(a,b)$ and every facility location $y$,

$$
\frac{E(y,x)}{\operatorname{opt}(x)}\le E(y,e).
\tag{2.3}
$$

**Proof.** The coincident case is immediate. Inside $[a,b]$, the two extreme
utilities are $c-d$ and $c+d$, while $U_x(y)\le v+d$. Thus, for a positive
denominator,

$$
\frac{cU_x(y)}{v(c-d)}
\le\frac{c+(c/v)d}{c-d}
\le\frac{c+d}{c-d}=E(y,e).
\tag{2.4}
$$

Outside $[a,b]$, the largest and smallest utilities are both attained at the
extremes, so $E(y,x)=E(y,e)$; divide by $\operatorname{opt}(x)\ge1$.
An infinite right side is harmless. $\square$

This lemma compares a common output location or distribution. It does not
replace an arbitrary mechanism's output on $x$ by its output on $(a,b)$.
That replacement is valid for constant lotteries and single-phantom mechanisms
because their relevant output laws depend on no reports beyond the extremes.
Repeating the two endpoints embeds every two-location profile into any fixed
$n\ge2$. Consequently their exact worst ratios are independent of $n$.

## 2.2 Truthfulness of clamping

**Lemma 2.3 (a fixed phantom is strategyproof).** For each $z\in[0,1]$,
$f_z$ is anonymous, unanimous, strategyproof, and takes values in the reported
convex hull.

**Proof.** Fix an agent's other reports, with extremes $a_{-i}\le b_{-i}$.
Set $L=\min(z,b_{-i})$ and $U=\max(z,a_{-i})$. Then $L\le U$ and

$$
f_z(t,x_{-i})=\operatorname{clamp}(t,L,U).
\tag{2.5}
$$

To verify the identity, distinguish $z \lt a_{-i}$, $z\in[a_{-i},b_{-i}]$,
and $z>b_{-i}$; the intervals become $[z,a_{-i}]$, $\{z\}$, and
$[b_{-i},z]$. The truthful output is the nearest point of a fixed closed
interval to $t$, whereas every misreport's output stays in that interval.
This proves (1.3). The remaining properties follow from (1.4).
Report-independent mixtures of these rules are universally strategyproof.
$\square$

## 2.3 Expansion to boundary profiles

**Lemma 2.4 (boundary reduction).** For any Borel seed law $\mu$, the
single-phantom worst ratio equals

$$
R(\mu)=\max\left\{
\sup_{0\le x\le1}\int K(z,x)\,d\mu(z),
\sup_{0\le x\le1}\int K(1-z,x)\,d\mu(z)
\right\},\tag{2.6}
$$

where the boundary kernel is

$$
K(z,x)=
\begin{cases}
(1-z)/(1-x+z),&z\le x/2,\\
(1-x+z)/(1-z),&x/2\le z\le x,\\
1/(1-x),&x\le z.
\end{cases}\tag{2.7}
$$

At overlapping branch endpoints the values agree whenever finite. Set
$K(z,0)=1$; at $(z,x)=(0,1),(1,1)$ use $+\infty$.

**Proof.** By Lemma 2.2 and endpoint repetitions, it suffices to consider
two locations. Hold their midpoint $m$ fixed and increase their half-width
$s$ to $\min(m,1-m)$. With $w=|z-m|$, the clamped output has deviation
$d_s=\min(w,s)$. Its envy is

$$
\frac{1-s+d_s}{1-s-d_s}
=\begin{cases}
1/(1-2s),&s\le w,\\
(1-s+w)/(1-s-w),&s\ge w.
\end{cases}\tag{2.8}
$$

Both branches are nondecreasing in $s$, with derivatives
$2/(1-2s)^2$ and $2w/(1-s-w)^2$ respectively; they agree where they
meet. The only possible zero denominator occurs for the full interval and
an endpoint seed, and the extended-real limit preserves monotonicity.
The expanded interval touches 0 or 1. Computing the two endpoint utilities
on $(0,x)$ gives (2.7); reflection gives its other orientation. Integrating
the pointwise domination proves one direction of (2.6); boundary profiles
are themselves allowed, proving the other. No extremum-expectation exchange
is used. $\square$

Constant lotteries admit the same boundary reduction, with a different
kernel $r$ in Section 3. For a noncoincident profile, a fixed output $y$,
and $w=|y-m|$,
the envy of $(m-s,m+s)$ is $(1-w+s)/(1-w-s)$ when $s\le w$, and
$(1-s+w)/(1-s-w)$ when $s\ge w$. Each branch is nondecreasing in $s$
where finite; branch and extended-real endpoints agree. Thus the fixed-output
ratio also cannot decrease under the same expansion. The coincident case
has ratio one by (1.1) and is handled separately.

## 2.4 Finiteness and measurability

**Lemma 2.5 (tail criterion).** Put $q(z)=\min(z,1-z)$, with $1/q=+\infty$
at the endpoints. Then

$$
R(\mu)<\infty\quad\Longleftrightarrow\quad
\int\frac1{q(z)}\,d\mu(z)<\infty.
\tag{2.9}
$$

**Proof.** On profile $(0,1)$ the clamped output is $z$, and its envy is
$1/q(z)-1$, proving necessity. For any reported interval $[a,b]$, the
distance from $\operatorname{clamp}(z,a,b)$ to either endpoint is at most
$\max(z,1-z)$. If $z$ is inside, use $z-a\le z$ and $b-z\le1-z$;
if it is outside, use $b-a\le1-z$ on the left and $b-a\le z$ on the
right. Minimum utility is therefore at least $q(z)$, and maximum utility
at most one, giving the uniform bound $1/q(z)$. $\square$

In particular, endpoint atoms give infinite risk, but merely having no
endpoint atoms does not ensure finite risk. Clamp is continuous, and (1.1)
is extended Borel measurable, so all integrals used here are well defined.

# 3. The exact constant-lottery barrier

For a constant output $y$ on the boundary profile $(0,x)$, put

$$
r(y,x)=
\begin{cases}
(1-y)/(1-x+y),&y\le x/2,\\
(1-x+y)/(1-y),&x/2\le y\le x,\\
1+x/(1-y),&x\le y.
\end{cases}\tag{3.1}
$$

Use the coincident and infinite-value conventions of (1.1). Its third branch
differs from (2.7), because a constant output is not clamped.

## 3.1 A pointwise two-profile lower certificate

Let $m_0=1-1/\sqrt5$ and define
$h(y)=\{r(y,m_0)+r(1-y,m_0)\}/2$.

**Lemma 3.1 (dual barrier and its equality set).** For every $y\in[0,1]$,

$$
h(y)\ge V,
\qquad h(y)=V\ \Longleftrightarrow\ y\in\{\alpha,1/2,\beta\}.
\tag{3.2}
$$

**Proof.** The function is invariant under $y\mapsto1-y$. On the left
half interval, the relevant order is
$0 \lt m_0/2<\alpha<1-m_0<1/2$.
For $0 \lt y\le m_0/2$,

$$
h(y)=\frac12\left(\frac{1-y}{1-m_0+y}+1+\frac{m_0}{y}\right).
$$

Both nonconstant terms are strictly decreasing; hence
$h(y)\ge h(m_0/2)=2>V$. At zero the value is infinite.
For $m_0/2\le y\le1-m_0$,

$$
h(y)=\frac{2-m_0}{2(1-y)}+\frac{m_0}{2y}
\ge\frac12(\sqrt{2-m_0}+\sqrt{m_0})^2
=1+\sqrt{m_0(2-m_0)}=V.
\tag{3.3}
$$

The two-term Cauchy inequality is an equality exactly when
$y/(1-y)=\sqrt{m_0/(2-m_0)}$, which is $y=\alpha$.
Finally, for $1-m_0\le y\le1/2$,

$$
h(y)=\frac{2-m_0}{2y(1-y)}-1
\ge3-2m_0=V,
\tag{3.4}
$$

with equality only at $1/2$, since $y(1-y)\le1/4$.
Reflection completes the proof. $\square$

For any Borel constant lottery, its worst risk is at least the average of
its risks on $(0,m_0)$ and $(1-m_0,1)$, hence at least $\int h\,d\mu\ge V$.
This argument permits asymmetric, continuous, singular, or endpoint-supported
laws and needs no minimax theorem.

## 3.2 Verification of the known upper law

For completeness we recheck the upper bound in [A25]. For the symmetric
law (1.5), boundary reduction makes it enough to study
$R_0(x)=\int r(y,x)\,d\mu_0(y)$. The order of breakpoints is
$\alpha<1/2<\beta<2\alpha<1$. The identities
$1/\alpha-1/\beta=1$ and $\beta/\alpha=1/\beta$ will be used.
Put $T=\int(1-y)^{-1}\,d\mu_0(y)$.

On $[0,\alpha]$, $R_0(x)=1+xT$, so it increases. On
$[\alpha,1/2]$, it is affine with slope $4/5$ and reaches $V$ at $1/2$.
On $[1/2,\beta]$, it is identically $V$. On $[\beta,2\alpha]$,
it equals $(2-x)T-1$ and decreases. On $[2\alpha,1]$,

$$
R_0(x)=\frac{(2/5)\beta}{1-x+\alpha}
+\frac15(3-2x)
+\frac25\left(\frac{2-x}{\alpha}-1\right).
\tag{3.5}
$$

Its second derivative is $4\beta/[5(1-x+\alpha)^3]>0$, so its maximum
on that interval is at an endpoint. The left endpoint is already at most
$V$; the right endpoint has value
$(4/5)(\beta/\alpha)+1/5=V-2/5 \lt V$. Continuity covers all breakpoints,
and the initial increasing pieces cannot exceed their later maximum $V$.
This proves the claimed upper guarantee.

## 3.3 Rigidity of an optimal Borel law

Suppose a constant lottery has worst risk at most $V$. Equality must hold in
the integrated lower certificate. Since $h-V$ is nonnegative and vanishes
exactly on the three points in (3.2), the law is supported there. Write its
weights as $p,q,t$. The two adversarial risks must each equal $V$. Their
difference is

$$
(p-t)\{r(\alpha,m_0)-r(\beta,m_0)\}.
$$

The bracket equals $-2m_0\ne0$ by (3.1), so $p=t$ and
$q=1-2p$. For $x\in(1/2,\beta)$ the resulting risk is affine, with slope

$$
p(1/\alpha-1/\beta)-2q=5p-2.
\tag{3.6}
$$

Its value at the interior point $m_0$ is $V$. A nonzero slope would exceed
$V$ on one side of $m_0$. Therefore $p=2/5$ and $q=1/5$. This proves
Theorem 1, including uniqueness over the entire Borel class.

# 4. Exact upper certificates for truthful mechanisms

## 4.1 Why finitely many checks certify the continuum

**Lemma 4.1 (breakpoint convexity).** If a seed law has finite support
$G\subset(0,1)$, its risk is the maximum of the two boundary expectations
at the finite set

$$
B_G=\{0,1\}\cup
\bigl(\{z,2z,1-z,2(1-z):z\in G\}\cap[0,1]\bigr).
\tag{4.1}
$$

**Proof.** As a function of the boundary endpoint $x$, a fixed seed gives

$$
K(z,x)=
\begin{cases}
1/(1-x),&0\le x\le z,\\
(1-x+z)/(1-z),&z\le x\le\min(2z,1),\\
(1-z)/(1-x+z),&2z\le x\le1\quad(2z\le1).
\end{cases}\tag{4.2}
$$

Every piece is convex or affine and all joins are continuous. After
partitioning by $B_G$, both the direct and reflected weighted sums are
convex on each closed piece, and therefore attain their maxima at its
endpoints. All denominators are strictly positive for interior seeds.
Lemma 2.4 gives the full-profile conclusion. $\square$

## 4.2 A short five-atom construction

Take seeds $(3,4,5,6,7)/10$ with probabilities
$(14,12,45,12,14)/97$. The law is symmetric. Its entire breakpoint check is

| $x$ | $\mathbb E K(Z,x)$ |
|---:|---:|
| $0$ | $1$ |
| $3/10$ | $10/7$ |
| $2/5$ | $469/291$ |
| $1/2$ | $176/97$ |
| $3/5$ | $176/97$ |
| $7/10$ | $176/97$ |
| $4/5$ | $803/485$ |
| $1$ | $439/291$ |

Every entry is at most $176/97$ and three entries attain it. Lemmas 2.2--2.4
and 4.1 therefore prove the exact value $U_5$ for every $n\ge2$.
To verify its strict improvement without decimals, note
$U_5-1=79/97$ and $5\cdot79^2<4\cdot97^2$, which imply
$U_5<1+2/\sqrt5$.

## 4.3 A thirteen-atom rational construction

Take seeds $z_k=k/30$ for $k=9,\ldots,21$, with probabilities $w_k/2000$,
where in increasing seed order

$$
(w_9,\ldots,w_{21})=
(245,61,48,132,55,55,808,55,55,132,48,61,245).
\tag{4.3}
$$

These positive integers sum to 2000 and are symmetric about $1/2$.
The breakpoint set is

$$
\begin{split}
\{&0,3/10,1/3,11/30,2/5,13/30,7/15,1/2,8/15,17/30,\\
&3/5,19/30,2/3,7/10,11/15,4/5,13/15,14/15,1\}.
\end{split}
\tag{4.4}
$$

Appendix A lists the exact slack $U_{13}-\mathbb E K(Z,x)$ at every
point. Each is nonnegative, with zero at $x=2/3$. Symmetry handles the
reflected orientation. Thus Lemma 4.1 proves the second exact worst value
in (1.6), and Lemma 2.3 proves all incentive and unanimity properties.
The finite table and formulas are sufficient for the upper proof; the
accompanying program is a reproducible way to re-evaluate them.

# 5. A lower certificate for every Borel phantom law

## 5.1 An explicit adversarial probability measure

For $k=50,\ldots,70$, put $x_k=k/100$ and let $q_k$ have common denominator
$10^6$ and the following numerator vector:

$$
\begin{split}
(&2804,130421,34098,68547,48220,60079,41417,\\
 &52791,34343,49757,26694,42641,29775,29936,\\
 &29084,32205,97966,97615,18842,60847,11918).
\end{split}\tag{5.1}
$$

All entries are positive and sum to $10^6$. Assign mass $q_k/2$ to
$(0,x_k)$ and mass $q_k/2$ to $(1-x_k,1)$. Their deterministic optimum
is one. Define

$$
H(z)=\frac12\sum_{k=50}^{70}q_k
\{K(z,x_k)+K(1-z,x_k)\},\qquad L=3617/2000.
\tag{5.2}
$$

**Lemma 5.1 (pointwise rational certificate).** $H(z)\ge L$ for all
$z\in[0,1]$.

The proof is an exhaustive finite rational polynomial certificate specified
next. It includes the entire interval, including its endpoints; it is not a
floating-point sampling assertion.

## 5.2 Polynomial construction on each analytic interval

Since $H(1-z)=H(z)$, restrict to $[0,1/2]$. Because $x_k\ge1/2$,

$$
K(z,x)=
\begin{cases}(1-z)/(1-x+z),&z\le x/2,\\
(1-x+z)/(1-z),&z\ge x/2,\end{cases}
\quad
K(1-z,x)=
\begin{cases}1/(1-x),&z\le1-x,\\
(2-x-z)/z,&z\ge1-x.
\end{cases}\tag{5.3}
$$

Partition $[0,1/2]$ at all interior points $x_k/2$ and $1-x_k$.
There are exactly 36 consecutive base intervals, indexed from left to right
as in Appendix B. On a base interval $I=[l,r]$, determine the branches
at its midpoint. The same formulas extend to its endpoints by continuity.
Let $D_I(z)$ be the product of the **distinct nonconstant** denominator
factors in these branches. Each factor is one of $z$, $1-z$, or
$1-x_k+z$. Every selected factor is strictly positive throughout $I$:
a $z$ denominator is selected only for intervals strictly to the right of
zero, $1-z\ge1/2$, and $1-x_k+z\ge3/10$.

Retain constant factors $1/(1-x_k)$ in the numerator of the corresponding
term. For each of the 42 terms, write its selected branch as $A_j(z)/B_j(z)$,
where $B_j=1$ or is one of the selected nonconstant affine factors, and let
$v_j=q_k/2$ be its weight. Define the rational polynomial

$$
N_I(z)=-L D_I(z)+\sum_{j=1}^{42}v_j A_j(z)\frac{D_I(z)}{B_j(z)}.
\tag{5.4}
$$

Every quotient in (5.4) is a polynomial, and
$H(z)-L=N_I(z)/D_I(z)$ on $I$. The degree of $N_I$ is at most 21.
Thus it remains to prove nonnegativity of 36 explicit polynomials, with
their coefficients fixed entirely by (5.1)--(5.4).

## 5.3 Bernstein verification and its exact finite data

For a polynomial $N(z)=\sum_{j=0}^d c_j z^j$ on a subinterval $[l,r]$,
define

$$
a_j=\sum_{k=j}^{d}c_k\binom{k}{j}l^{k-j}(r-l)^j,
\qquad
b_i=\sum_{j=0}^{i}a_j\frac{\binom{i}{j}}{\binom{d}{j}}.
\tag{5.5}
$$

The binomial identity gives

$$
N(l+(r-l)t)=\sum_{i=0}^{d}b_i\binom{d}{i}t^i(1-t)^{d-i}.
\tag{5.6}
$$

For clarity, (5.6) follows by expanding $z^k$ after the affine substitution
and using
$t^j=\sum_{i=j}^d\binom{i}{j}\binom{d}{j}^{-1}
\binom{d}{i}t^i(1-t)^{d-i}$; the latter is the binomial theorem applied
to $(t+(1-t))^{d-j}$. Every Bernstein basis term is nonnegative for
$0\le t\le1$. Nonnegative $b_i$ therefore suffice on the whole interval.

Use each base interval unchanged, except indices 22 through 34, which are
bisected once at their rational midpoint. This gives exactly 49 subintervals.
For these subintervals, all **366** coefficients from (5.4)--(5.5) are
positive. Appendix B gives a rational lower bound $10^{-e_I}$ for every
coefficient belonging to base interval $I$, together with its degree and
partition. These finite comparisons use integer multiplication and ordering
only. The accompanying certificate records every exact coefficient and
denominator factor; the verifier reconstructs the polynomials from the
kernel, and a separate implementation recomputes the polynomial identities
and coefficient bounds.

This proves $N_I\ge0$ throughout each base interval, since the listed
subintervals cover it with their endpoints included. Strict positivity of
$D_I$ proves Lemma 5.1 on $[0,1/2]$, and reflection proves the rest.

## 5.4 Integration against an arbitrary law

For every Borel phantom law $\mu$, the supremum of its boundary risks is
at least their finite adversarial average. Nonnegative integration and the
finite sum in (5.2) give

$$
R(\mu)\ge\int H(z)\,d\mu(z)\ge L.
\tag{5.7}
$$

No interchange of minimization and maximization is involved. No finite
support or integrability hypothesis is placed on $\mu$; infinite risks
already satisfy the bound. Repetition of endpoints gives it for every
fixed population size. Together with Section 4, this proves the interval
for $C_*$ in (1.7).

# 6. From all unanimous truthful rules to one random phantom

The class reduction below is independent of a full generalized-median
characterization. It applies to deterministic rules on the symmetric
distance domain used in this paper and then to their report-independent
randomizations.

## 6.1 Inward invariance and convex-hull efficiency

**Lemma 6.1 (inward invariance).** Fix other reports. If a strategyproof
rule outputs $y \lt t$ at report $t$, replacing $t$ by any $r$ with
$y\le r \lt t$ leaves the output equal to $y$. The right-side version follows
by reflection.

**Proof.** Let the new output be $v$. Strategyproofness at true type $t$
implies $v\le y$ or $v\ge2t-y$. Strategyproofness at true type $r$
implies $y\le v\le2r-y$. Since $r \lt t$, the intersection consists only
of $v=y$. $\square$

**Lemma 6.2 (unanimity forces the convex hull).** Every unanimous
strategyproof rule outputs in $[\min_i x_i,\max_i x_i]$.

**Proof.** If its output $y$ were below $a=\min_i x_i$, move each report
strictly above $a$ to $a$, one at a time. Lemma 6.1 keeps the output at
$y$ throughout. The final all-$a$ profile contradicts unanimity.
Reflect for an output above the maximum. $\square$

## 6.2 A two-agent representation on an ordered region

**Lemma 6.3 (two-agent ordered representation).** Let
$F:[0,1]^2\to[0,1]$ be unanimous and strategyproof, without an anonymity
assumption. Put $p=F(0,1)$. Then

$$
F(a,b)=\operatorname{clamp}(p,a,b)\qquad(0\le a\le b\le1).
\tag{6.1}
$$

**Proof.** Fix the second report $b$ and put $J(t)=F(t,b)$,
$A=J([0,1])$. Strategyproofness at true types 0 and 1 shows that
$\ell=J(0)=\min A$ and $u=J(1)=\max A$. Unanimity gives $b\in A$,
and Lemma 6.2 gives $\ell\le b\le u$. Every $J(t)$ is a nearest
point to $t$ in $A$, because every member of $A$ is reachable by a report.

The set $A$ is closed: if $v_k\in A$ and $v_k\to v$, strategyproofness
at true type $v$ against reports realizing the $v_k$ gives
$|J(v)-v|\le|v_k-v|\to0$. Thus $J(v)=v\in A$.
If $A\ne[\ell,u]$, choose a gap $(r,s)$ with endpoints in $A$.
Because $b\in A$, the gap lies either weakly below $b$ or weakly above it.
In the first case, take $t\in(r,(r+s)/2)$: its unique nearest point
of $A$ is $r \lt t$, contradicting the required output in $[t,b]$.
In the second case, take $t\in((r+s)/2,s)$: its unique nearest point
is $s>t$, contradicting the required output in $[b,t]$.
Consequently $A=[\ell,u]$ and

$$
F(t,b)=\operatorname{clamp}(t,F(0,b),F(1,b)).
\tag{6.2}
$$

The same argument with the roles exchanged, fixing the first report at 0,
gives $F(0,b)=\operatorname{clamp}(b,0,p)=\min(b,p)$.
For $a\le b$, convex-hull efficiency gives $F(1,b)\ge b$, so (6.2)
reduces to $\max(a,\min(b,p))=\operatorname{clamp}(p,a,b)$.
The reverse ordered region can have a different parameter $F(1,0)$;
no anonymity has been inserted. $\square$

## 6.3 Compressing two groups with identical locations

**Lemma 6.4 (group restriction).** Fix a nonempty proper subset $S$ of
the agents. For a unanimous strategyproof rule $f$, let $F_S(a,b)$ be its
output when agents in $S$ all report $a$ and the others all report $b$.
Then $F_S$ is a unanimous two-agent strategyproof rule. Hence, for $a\le b$,

$$
F_S(a,b)=\operatorname{clamp}(p_S,a,b),
\qquad p_S=f(0^S,1^{S^c}).
\tag{6.3}
$$

**Proof.** Change the reports in $S$ from a common true value $a$ to a
common false value $a'$ sequentially. At each step the agent being changed
still reports its true value $a$. Individual strategyproofness says that
the distance of the new output from $a$ cannot be smaller than before.
These comparisons all use the same true value, so they compose. This is
strategyproofness for the first argument of $F_S$; the other group is
identical. Individual strategyproofness holds for every configuration of
other reports, including the intermediate mixed reports in this chain.
Unanimity is inherited, and Lemma 6.3 gives (6.3). $\square$

## 6.4 The minimax equality for the full unanimous class

Let a unanimous universally strategyproof mechanism consist of rules
$f_\omega$ with a report-independent random seed $\omega$. Fix any nonempty
proper $S$, and form the random variable

$$
P_S(\omega)=f_\omega(0^S,1^{S^c}),\qquad\mu_S=\mathcal L(P_S).
\tag{6.4}
$$

This is measurable by the mechanism's output assumption. Lemma 6.4 holds
for every realization in the fixed full-measure set, simultaneously for all
$a\le b$. Thus, on the two-location profiles with this fixed assignment
of agents to groups, the randomized output is
$\operatorname{clamp}(P_S,a,b)$. Their optimum envy equals one. Taking the
supremum over $a,b$ gives exactly $R(\mu_S)$ by Section 2, hence at least
$C_*$. Conversely, every single-phantom mechanism belongs to the unanimous
universally strategyproof class, so arbitrary $\varepsilon$-optimal seed
laws give the reverse infimum inequality. No existence of an optimizer is
assumed. This proves the class equality in Theorem 3.

## 6.5 Arbitrarily correlated generalized medians

For comparison with the classical representation and the two-location
marginal technique in [ALSW22], let
$P_1\le\cdots\le P_{n-1}$ have any report-independent Borel joint law and
output the median of the $n$ reports and these $n-1$ phantoms. A fixed
realization is strategyproof: after removing one agent and sorting the
remaining $2n-2$ numbers as $q_1\le\cdots\le q_{2n-2}$, its response to
the missing report $t$ is $\operatorname{clamp}(t,q_{n-1},q_n)$.
It is also anonymous, unanimous, and in the reported convex hull.

On a profile with $k$ copies of $a$ and $n-k$ copies of $b$, $a \lt b$,
the median is

$$
\operatorname{clamp}(P_{n-k},a,b).\tag{6.5}
$$

Indeed, if $P_{n-k}$ is inside the interval, at most $n-1$ entries are
strictly on either side. If it is below $a$, fewer than $n$ entries are
strictly below $a$ and at least $n$ are at most $a$, so the median is $a$;
the case above $b$ is symmetric. Ties obey the same counting argument.
Writing $\mu_j=\mathcal L(P_j)$ therefore gives

$$
\rho_n(G_P)\ge\max_{1\le j\le n-1}R(\mu_j)\ge C_*.
\tag{6.6}
$$

Conversely, choosing every phantom equal to a common $Z\sim\mu$ makes
the median precisely (1.4). Thus the generalized-median class has the same
infimum $C_*$ even if arbitrary correlation and nonidentical marginals
are permitted. This is an explicit dimensional reduction, not an assumption
that every truthful rule has an anonymous median representation.

# 7. Convergent rational linear programs for the Borel optimum

## 7.1 Central truncation

For $0<\delta<1/2$, put
$T_\delta(z)=\operatorname{clamp}(z,\delta,1-\delta)$.

**Lemma 7.1 (uniform truncation bound).** For all $z,x\in[0,1]$,

$$
K(T_\delta(z),x)\le K(z,x)+\frac{\delta}{1-\delta}.
\tag{7.1}
$$

**Proof.** There is no change for an interior seed. If $z>1-\delta$,
both $z$ and its truncated value exceed $x/2$, and $K(\cdot,x)$ is
nondecreasing there, so moving left does not increase it. If $z<\delta$
and $x\ge2\delta$, the first branch is decreasing in its seed, so again
there is no increase. Otherwise $x<2\delta$. If $x\le\delta$, the
new loss is $1/(1-x)\le1/(1-\delta)$; if
$\delta\le x<2\delta$, it is
$(1-x+\delta)/(1-\delta)\le1/(1-\delta)$.
Every old loss is at least one, giving (7.1). The infinite cases satisfy
the same inequality in the extended order. $\square$

Since $T_\delta$ commutes with reflection, (7.1) holds for the reflected
kernel too. If $\mu_\delta$ is the pushforward of $\mu$, then

$$
R(\mu_\delta)\le R(\mu)+\frac{\delta}{1-\delta}.
\tag{7.2}
$$

The error is counted once, because the two orientations are maximized,
not added.

## 7.2 Quantization on a central interval

**Lemma 7.2 (uniform Lipschitz bound).** For $z,w\in[\delta,1-\delta]$
and any $x$,

$$
|K(z,x)-K(w,x)|\le\frac2{\delta^2}|z-w|.
\tag{7.3}
$$

**Proof.** The absolute derivatives of the first two seed branches are
$(2-x)/(1-x+z)^2$ and $(2-x)/(1-z)^2$. Their denominators are at least
$\delta^2$ and numerator at most two. The last branch is constant.
The pieces meet continuously at $z=x/2,x$; partitioning a segment at
these joins gives the global estimate. Reflection has the same estimate.
$\square$

Choose a nearest-point map $\pi_G$ to a finite $h$-covering grid in the
central interval, resolving ties by a fixed order. This map is Borel.
Applying (7.3) to the pushforward of $\mu_\delta$ gives

$$
R((\pi_G)_\#\mu_\delta)
\le R(\mu_\delta)+2h/\delta^2.
\tag{7.4}
$$

Start with an $\varepsilon$-optimal Borel law, use (7.2)--(7.4), and
let $\varepsilon\downarrow0$. This proves (1.8); the reverse inequality
follows from inclusion of the feasible classes. Finiteness is not in
question, since a deterministic midpoint phantom has worst ratio at most
two by (4.2). For $G_m$ in Theorem 4, take $\delta=1/m$ and
$h=1/(2m^3)$ to obtain the stated explicit convergence rate. This is a
sufficient rate, not a claim of optimal discretization complexity.

## 7.3 An exact finite LP, rather than a sampled adversary

For a finite grid $G\subset(0,1)$, use the variables $p_z\ge0$ with
$\sum_{z\in G}p_z=1$ and $c\in\mathbb R$. Lemma 4.1 identifies $C_G$
with the optimum of

$$
\begin{array}{ll}
\text{minimize}&c\\
\text{subject to}&\displaystyle\sum_{z\in G}p_zK(z,x)\le c
\quad(x\in B_G),\\
&\displaystyle\sum_{z\in G}p_zK(1-z,x)\le c
\quad(x\in B_G).
\end{array}\tag{7.5}
$$

The probability simplex is compact and the maximum of these finitely many
continuous affine functions attains a minimum. When the grid is rational,
all coefficients are rational. To make the boundedness argument explicit, put
$B=\max_{z\in G}1/\min(z,1-z)$, a finite rational number. Lemma 2.5
shows that every probability vector has risk at most $B$, while every risk
is at least one. The restriction $1\le c\le B$ therefore preserves the
optimum and gives a nonempty compact rational polytope with a rational
optimal vertex. Thus rational
primal certificates can be checked exactly. Sections 5 and 7 respectively
give a finite all-Borel lower certificate and a convergent sequence of
finite upper problems. A numerical candidate alone is neither of these.

# 8. Scope, counterexamples, and unresolved questions

The distinction between universality and truthfulness in expectation is
substantive: Section 6 uses a fixed deterministic strategyproof realization
at every step. Its proof does not apply when only expected utility obeys
incentive constraints. Unanimity is also substantive. For $n=2$, consider

$$
g(x_1,x_2)=
\begin{cases}
1/4,&\max(x_1,x_2)\le1/2,\\
3/4,&\max(x_1,x_2)>1/2.
\end{cases}\tag{8.1}
$$

This is anonymous and strategyproof. If the other report exceeds $1/2$,
the output is fixed; otherwise the report selects between $1/4$ and
$3/4$, with their distance-indifference threshold exactly $1/2$.
It is not unanimous. Its ratio is finite, since all utilities are at least
$1/4$ and maximum utility is at most one. Therefore finite risk does not
imply unanimity.

Nor can unanimity be imposed by simply projecting an arbitrary strategyproof
output onto the reported convex hull. Apply that projection to (8.1).
At the true profile $(1/5,2/5)$, the output is $1/4$, and the second
agent's distance is $3/20$. By reporting $51/100$, that agent makes
(8.1) select $3/4$, which the projection changes to $51/100$.
Its true distance becomes $11/100<3/20$. The projected rule is manipulable.

The exact value, attainment, and uniqueness of the all-Borel optimum $C_*$
remain open here. We make no theorem from an approximate numerical optimizer.
The lower bound (1.7) is not promoted to a bound for nonunanimous universally
strategyproof mechanisms or all truthful-in-expectation mechanisms.
No prediction model, multi-facility extension, unequal utilities, or
relative-interval model is analyzed. The contribution is a complete theorem
package for the explicitly fixed setting, with exact finite certificates
where indicated.

# Appendix A. Complete thirteen-atom upper certificate

The table records $U_{13}-\sum_{k=9}^{21}(w_k/2000)K(k/30,x)$ using
(4.3). Both orientations agree by symmetry. Nonnegativity and the zero row,
combined with Lemma 4.1, give the exact maximum.

| $x$ | Exact nonnegative slack |
|---:|---:|
| $0$ | $1046708389/1293292000$ |
| $3/10$ | $70348627/184756000$ |
| $1/3$ | $314192173/969969000$ |
| $11/30$ | $10258769309/38798760000$ |
| $2/5$ | $3896137139/19399380000$ |
| $13/30$ | $1796520989/12932920000$ |
| $7/15$ | $1871573229/25865840000$ |
| $1/2$ | $2395203/10346336000$ |
| $8/15$ | $241619/1108536000$ |
| $17/30$ | $4724887/31039008000$ |
| $3/5$ | $305287/5173168000$ |
| $19/30$ | $113459/10346336000$ |
| $2/3$ | $0$ |
| $7/10$ | $2613337/51731680000$ |
| $11/15$ | $12450254353/232792560000$ |
| $4/5$ | $976203091/6466460000$ |
| $13/15$ | $10461288443/46558512000$ |
| $14/15$ | $16100452493/58198140000$ |
| $1$ | $1148367631/3879876000$ |

# Appendix B. Complete polynomial partition and coefficient bounds

For each base interval, form $N_I$ by (5.3)--(5.4). The degree $d$ below
is after removing any zero leading coefficients. If the split column says
"yes", bisect once at $(l+r)/2$ before applying (5.5); otherwise use
the whole interval. Every Bernstein coefficient on every resulting subinterval
is at least $10^{-e}$ with the exponent in the last column. These are
conservative rational lower bounds, not rounded decimal evaluations.

| $I$ | $l$ | $r$ | $d$ | Split | $e$ |
|---:|---:|---:|---:|:---:|---:|
| 1 | $0$ | $1/4$ | 21 | no | 9 |
| 2 | $1/4$ | $51/200$ | 21 | no | 6 |
| 3 | $51/200$ | $13/50$ | 20 | no | 6 |
| 4 | $13/50$ | $53/200$ | 19 | no | 6 |
| 5 | $53/200$ | $27/100$ | 18 | no | 6 |
| 6 | $27/100$ | $11/40$ | 17 | no | 6 |
| 7 | $11/40$ | $7/25$ | 16 | no | 6 |
| 8 | $7/25$ | $57/200$ | 15 | no | 6 |
| 9 | $57/200$ | $29/100$ | 14 | no | 6 |
| 10 | $29/100$ | $59/200$ | 13 | no | 7 |
| 11 | $59/200$ | $3/10$ | 12 | no | 7 |
| 12 | $3/10$ | $61/200$ | 12 | no | 7 |
| 13 | $61/200$ | $31/100$ | 11 | no | 7 |
| 14 | $31/100$ | $63/200$ | 10 | no | 6 |
| 15 | $63/200$ | $8/25$ | 9 | no | 6 |
| 16 | $8/25$ | $13/40$ | 8 | no | 6 |
| 17 | $13/40$ | $33/100$ | 7 | no | 6 |
| 18 | $33/100$ | $67/200$ | 6 | no | 6 |
| 19 | $67/200$ | $17/50$ | 5 | no | 6 |
| 20 | $17/50$ | $69/200$ | 4 | no | 6 |
| 21 | $69/200$ | $7/20$ | 3 | no | 5 |
| 22 | $7/20$ | $9/25$ | 2 | yes | 5 |
| 23 | $9/25$ | $37/100$ | 2 | yes | 5 |
| 24 | $37/100$ | $19/50$ | 2 | yes | 5 |
| 25 | $19/50$ | $39/100$ | 2 | yes | 5 |
| 26 | $39/100$ | $2/5$ | 2 | yes | 6 |
| 27 | $2/5$ | $41/100$ | 2 | yes | 6 |
| 28 | $41/100$ | $21/50$ | 2 | yes | 5 |
| 29 | $21/50$ | $43/100$ | 2 | yes | 6 |
| 30 | $43/100$ | $11/25$ | 2 | yes | 5 |
| 31 | $11/25$ | $9/20$ | 2 | yes | 6 |
| 32 | $9/20$ | $23/50$ | 2 | yes | 5 |
| 33 | $23/50$ | $47/100$ | 2 | yes | 6 |
| 34 | $47/100$ | $12/25$ | 2 | yes | 5 |
| 35 | $12/25$ | $49/100$ | 2 | no | 5 |
| 36 | $49/100$ | $1/2$ | 2 | no | 6 |

There are 36 base intervals, 49 subintervals, and
$\sum_{I,\text{subinterval}}(d_I+1)=366$ coefficients. In particular,
the manuscript fixes all rational data and the exact finite rule needed to
reconstruct the certificate, without trusting a numerical LP solver.

# References

**[D20]** Yuan Ding, Wenjing Liu, Xin Chen, Qizhi Fang, and Qingqin Nong.
*Facility location game with envy ratio*. Computers & Industrial Engineering
148 (2020), 106710. DOI: [10.1016/j.cie.2020.106710](https://doi.org/10.1016/j.cie.2020.106710).
The later arXiv posting [2607.02330](https://arxiv.org/abs/2607.02330) is a
posting of this work, not a new 2026 improvement to the fixed-interval bound.

**[A25]** Haris Aziz, Yuhang Guo, Alexander Lam, and Houyu Zhou.
*Learning-Augmented Facility Location Mechanisms for Envy Ratio*.
Advances in Neural Information Processing Systems 38, NeurIPS 2025 Main
Conference Track. DOI: [10.52202/085713-5447](https://doi.org/10.52202/085713-5447).
[Official paper](https://proceedings.neurips.cc/paper_files/paper/2025/file/eecc0a5d47f9ade2672ee2389376f4d5-Paper-Conference.pdf).
Theorem 4.3, Lemma 3.1, and Appendix A.1 are the specific comparisons used.
The arXiv record [2512.11193](https://arxiv.org/abs/2512.11193), v2 dated
4 February 2026, retains the $1.8944$ upper bound in its abstract.

**[M80]** Hervé Moulin. *On strategy-proofness and single peakedness*.
Public Choice 35 (1980), 437--455.
DOI: [10.1007/BF00128122](https://doi.org/10.1007/BF00128122).
Historical context for generalized-median rules; no unproved characterization
from this reference is used as a premise in Section 6.

**[EPS02]** Lars Ehlers, Hans Peters, and Ton Storcken. *Strategy-proof
probabilistic decision schemes for one-dimensional single-peaked preferences*.
Journal of Economic Theory 105(2) (2002), 408--434.
DOI: [10.1006/jeth.2001.2829](https://doi.org/10.1006/jeth.2001.2829).
Historical context for probabilistic phantom mechanisms.

**[MM11]** Jordi Massó and Inés Moreno de Barreda. *On strategy-proofness
and symmetric single-peakedness*. Games and Economic Behavior 72(2)
(2011), 467--484.
DOI: [10.1016/j.geb.2010.12.001](https://doi.org/10.1016/j.geb.2010.12.001).
Used to position the necessity of care with symmetric preferences and
non-surjective rules; the needed statements in Sections 6 and 8 are proved
directly in this manuscript.

**[ALSW22]** Haris Aziz, Alexander Lam, Mashbat Suzuki, and Toby Walsh.
*Random Rank: The One and Only Strategyproof and Proportionally Fair
Randomized Facility Location Mechanism*. Advances in Neural Information
Processing Systems 35, NeurIPS 2022.
[Official paper](https://proceedings.neurips.cc/paper_files/paper/2022/file/bac4d92b3f6decfe47eab9a5893dd1f6-Paper-Conference.pdf).
The proof of Theorem 3, especially its two-location profiles and phantom
order-statistic marginals, is a direct methodological precedent. Its
Strong Proportionality objective is different from the envy-ratio
approximation objective studied here.
