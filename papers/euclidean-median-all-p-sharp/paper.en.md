# Sharp guarantees for the Euclidean coordinate median at every finite social-cost exponent

Research manuscript, 25 November 2026. This is an AI-assisted research draft ; it is not an externally peer-reviewed publication. 

## Abstract

For a finite profile of an odd number of points in Euclidean space, consider the coordinate-wise median under the social cost obtained by taking the $\ell_p$ norm of the individual Euclidean distances. We determine its exact worst-case approximation ratio over all finite dimensions and odd populations, for every finite real $p\ge1$. A unique transition $p_*\approx1.44074973749$ separates a low-exponent nonlinear branch from a plateau of value $\sqrt2$. The plateau extends to $p=2$, and the ratio equals $2^{1-1/p}$ for $2\le p\le4$. For $p>4$ a second nonlinear branch appears. Both nonlinear branches are specified by one explicit scalar equation with a proved unique root in a stated interval. The proof first makes a scalar moment reduction exact, then classifies all global support contacts using a Hessian obstruction and a monotone contact slope. Cyclic support orbits give explicit finite odd-population profiles approaching every stated constant. A positive finite-population remainder also shows that no nonconstant finite odd profile attains the supremum. The known $p=1,2,4$ constants and the existing signature-relaxation framework are credited rather than counted as new results.

## 1. Model and main theorem

Fix a finite real $p\ge1$. A profile is $x=(x_1,\ldots,x_n)$ with $x_i\in\mathbb R^d$, where $d\ge1$ is finite and $n\ge3$ is odd. Let $m=m(x)$ be its coordinate-wise middle order statistic, and define

$$
S_p(f;x)=\left(\sum_{i=1}^n\|x_i-f\|_2^p\right)^{1/p},\qquad
C(p)=\sup_{d,n,x}\frac{S_p(m;x)}{\min_f S_p(f;x)}.
\tag{1}
$$

Only profiles with positive optimal cost enter the supremum. The minimum exists by continuity and coercivity and is zero exactly for constant profiles. The geometric norm is always Euclidean; $p$ changes the aggregation of agent costs, not the norm in the underlying space.

Let $q_*$ be the unique root in $(3/2,2)$ of

$$
(2q-1)\log(2-1/q)-\log(2^q-1)=0,
\qquad p_*:=\frac{2q_*}{2q_*-1}.
\tag{2}
$$

Thus $4/3<p_*<3/2$. The symbol $q$ in (2) is only an auxiliary scalar, not a geometric norm exponent.

For $p\ne2$ define the following functions on the domains specified below:

$$
x_p(k)=\frac{p-4k}{2(p-2)},\qquad
r_p(k)=\frac{\sqrt{x_p(k)}}{k},\qquad
d_p(k)=1+\frac{x_p(k)(1-2k)}{k^2},
\tag{3}
$$
$$
T_p(k)=(1-k)\left(\frac{d_p(k)}{r_p(k)^2}\right)^{(p-2)/2},\qquad
b_p(k)=\frac{p}{2k}d_p(k)^{(p-2)/2}.
\tag{4}
$$

For $0<t<1$ put

$$
E_p(t)=\begin{cases}
t,&p=1,\\
\left(\dfrac{t^{1/(p-1)}}{1-t^{1/(p-1)}}\right)^{p-1},&p>1,
\end{cases}
\qquad R_p(k)=\frac{b_p(k)}2-E_p(T_p(k)).
\tag{5}
$$

**Main theorem.** The exact value in (1) is

$$
C(p)=\begin{cases}
T_p(k_p)^{-1/p},&1\le p<p_*,\\
\sqrt2,&p_*\le p\le2,\\
2^{1-1/p},&2\le p\le4,\\
T_p(k_p)^{-1/p},&p>4.
\end{cases}
\tag{6}
$$

For $1\le p<p_*$, $k_p$ is the unique root of $R_p(k)=0$ in $(p/4,1/2)$. For $p>4$, set

$$
\kappa_p=\frac p4-\frac14\sqrt{\frac{p(p-2)(p-4)}{p+2}}.
\tag{7}
$$

Then $k_p$ is the unique root in the explicitly specified domain

$$
\kappa_p\le k<1,\qquad 0<T_p(k)<1.
\tag{8}
$$

All powers in (3)--(5) have positive bases on the stated open root domains. The restriction in (8) defines a nonempty interval; $R_p$ is strictly increasing there and is strictly decreasing on the low-exponent root interval. Existence, global validity and uniqueness are proved below. In particular, (6) is not a definition through an unresolved convex-envelope problem.

For each fixed $p$, the bound holds in every finite dimension and for every admissible odd population. Explicit finite profiles have ratios converging to $C(p)$. The known anchor values are

$$
C(1)=\sqrt{6\sqrt3-8},\qquad C(2)=\sqrt2,\qquad C(4)=2^{3/4}.
\tag{9}
$$

There is also a finite-population improvement. Put $t_*=C(p)^{-p}$, and let $b_*=b_p(k_p)$ on either nonlinear branch, $b_*=p$ on $[p_*,2]$, and $b_*=2$ on $[2,4]$. Then $b_*>0$, and every reference facility $f$ satisfies

$$
\sum_i\|x_i-f\|_2^p-t_*\sum_i\|x_i-m\|_2^p
\ge\frac{b_*}{2}\|f-m\|_2^p.
\tag{10}
$$

Consequently the ratio in (1) is strictly below $C(p)$ for every single admissible finite odd profile. Sharpness is a supremum statement, realized by a sequence of finite instances.

The proof has three tasks. Section 3 reduces Euclidean profiles to an exact two-atom moment problem. Section 4 eliminates that auxiliary optimization by classifying the contacts of a globally existing support line. Sections 5 and 6 construct finite odd instances from those contacts, including integer counts, boundary contacts and effective approximation. Section 7 proves (10).

## 2. Closest prior results and the contribution claimed here

Gravin and Jia [GJ25] determine the sharp dimension-free constant for the sum of individual distances, including the Euclidean value in (9), and give matching high-dimensional examples. Their varying norm parameter changes the underlying metric while the social exponent is one. Hastings [H26, Theorem 3 and Section 6] treats both the social exponent and the geometric norm. His Appendix A.1, equation (26), already gives the exact signature-wise point cost; Section 6, equations (8)--(9), then uses a further relaxation. The Euclidean specializations at $p=2$ and $p=4$ are sharp. The scalar/signature method, the cost-difference formulation, and the basic high-dimensional construction strategy are therefore existing ideas.

For the Euclidean plane, Hastings [H26, Theorem 2] and Chan, Lin and Wang [CLW26, Theorem 1] already establish the all-$p$ ratio $\sqrt2$ for $1\le p\le2$ and $2^{1-1/p}$ for $p\ge2$. Formula (6) concerns the supremum over all finite dimensions. It identifies exactly when higher dimensions increase that planar guarantee: the two outer regimes $1\le p<p_*$ and $p>4$. Jia [J26] studies the sum-of-distances objective and optimality among classes of strategyproof mechanisms; that is a different quantifier over mechanisms and is not the all-social-exponent evaluation in (1).

The exact single-point objective itself is therefore not claimed as new. The new content claimed within this checked literature is the complete all-finite-$p$ evaluation (6), the global contact classification that makes its scalar root prescription unambiguous, and its exact finite odd-profile realization. In particular, neither an unsolved convex-envelope expression nor a fitted numerical curve is presented as the result. The Euclidean Cauchy reduction gives a direct route to the exact scalar objective; the new work lies in proving tightness and resolving its global contacts across all exponents. The existing sharp $p=1,2,4$ cases are recovered as consistency checks.

The comparison is bounded by inspected primary sources and the versions listed below. The official abstract of [LA26] describes facility location on the line with predictions. Its full OpenReview PDF and API returned HTTP 403 and were not inspected. The primary text of [S26], Theorems 2.2 and 3.1, treats uniformly rotated medians and a reference-point inequality in the Euclidean plane for $1<p<2$, a different mechanism and dimensional scope. The access limitation for [LA26] is disclosed; its abstract supports only the stated scope comparison, and unseen results or appendices are not asserted absent. No global priority or external peer-review claim is made.

## 3. Exact reduction from Euclidean profiles

Fix $0\le\lambda<1$ and put $\tau=1/2$. For $r\ge0$ and $s\in[0,1]$, define

$$
\Psi_p(r,s)=(r^2+1-2r\sqrt s)^{p/2},
\quad
g_{p,\lambda}(r,s)=\Psi_p(r,s)-\lambda^p r^p,
\quad
h_{p,\lambda}(s)=\inf_{r\ge0}g_{p,\lambda}(r,s).
\tag{R2}
$$

Write

$$
F_p(\lambda)=(\operatorname{co}h_{p,\lambda})(1/2),
\tag{R3}
$$

where co denotes the greatest convex minorant on [0,1]. Lemma 2 below gives an explicit two-atom interpretation of this notation. Equation (R3) is an intermediate optimization problem, not the promised final all-$p$ evaluation.

### 3.1 Compact radial minimization

**Lemma 1. Finite attainment, continuity, and monotonicity.**

For fixed $p\ge1$ and $\lambda<1$, every value in (R2) is attained with

$$
0\le r\le R_\lambda:=\frac{3}{1-\lambda}.
\tag{R4}
$$

The function $h$ is continuous and nonincreasing on [0,1]. It is also jointly continuous in $(\lambda,s)$ when $\lambda$ ranges over any compact subinterval of [0,1).

**Proof.** The expression under the $p/2$ power is the squared Euclidean distance

$$
r^2+1-2r\sqrt s
=\|(r,0)-(\sqrt s,\sqrt{1-s})\|_2^2.
\tag{R5}
$$

It is nonnegative. The reverse triangle inequality gives its square root at least $r-1$ when $r\ge1$. If $r\ge R_\lambda$, then $r-1\ge\lambda r$ and

$$
g_{p,\lambda}(r,s)
\ge(r-1)^p-(\lambda r)^p
\ge((1-\lambda)r-1)^p\ge2^p>1.
\tag{R6}
$$

Here $u^p-v^p\ge(u-v)^p$ for $u\ge v\ge0$ follows from $(v+t)^p\ge v^p+t^p$. Since $g(0,s)=1$, restricting the infimum to the compact interval (R4) loses no minimizer. Continuity of a minimum of a continuous function over this fixed compact interval follows directly from uniform continuity. For joint continuity on $\lambda\le\bar\lambda<1$, use the common bound $R_{\bar\lambda}$.

For each fixed $r$, the expression $r^2+1-2r\sqrt s$ is nonincreasing in $s$. Therefore $g$ and its infimum $h$ are nonincreasing. No differentiability or stationarity argument is needed. QED.

The endpoint $s=0$ is part of this continuous radial problem. Its minimizer need not have $r=0$. Such a point is realized below by support fractions tending to zero; it must not be discarded.

### 3.2 The two-atom moment problem

**Lemma 2. Convex envelope and the inequality moment constraint.**

For every continuous nonincreasing $h:[0,1]\to\mathbb R$,

$$
(\operatorname{co}h)(\tau)
=\min_{\mu:\int s\,d\mu=\tau}\int h\,d\mu
=\min_{\mu:\int s\,d\mu\le\tau}\int h\,d\mu,
\qquad \tau=1/2,
\tag{R7}
$$

where $\mu$ ranges over probability measures on [0,1]. A minimizer can be chosen with at most two atoms. More explicitly, the common value is

$$
\min_{0\le a\le\tau\le b\le1}
\left[
\frac{b-\tau}{b-a}h(a)+
\frac{\tau-a}{b-a}h(b)
\right],
\tag{R8}
$$

with the value $h(\tau)$ assigned at $a=b=\tau$. Cases $a=\tau$ or $b=\tau$ reduce to the single atom $\tau$ after deleting the zero-weight atom.

**Proof.** First impose exact mean $\tau$. For any such $\mu$, let $\mu_-$ and $\mu_+$ be its restrictions to $s<\tau$ and $s>\tau$, and put

$$
D=\int(\tau-a)\,d\mu_-(a)
=\int(b-\tau)\,d\mu_+(b).
$$

If $D=0$, $\mu$ is the point mass at $\tau$. Otherwise define a measure on pairs $(a,b)$ by

$$
dW(a,b)=\frac{b-a}{D}\,d\mu_-(a)d\mu_+(b).
$$

Its total mass is 1-$\mu$({$\tau$}). If $B_h(a,b)$ denotes the bracket in (R8), direct integration gives

$$
\int h\,d\mu
=\mu(\{\tau\})h(\tau)+\int B_h(a,b)\,dW(a,b).
\tag{R9}
$$

Indeed the coefficient of $h(a)$ integrates to $\mu_-$(da), and the coefficient of $h(b)$ integrates to $\mu_+$(db). Thus no distribution with exact mean $\tau$ improves on the best two-point bracket. Conversely, every bracket is realized by the stated two-point probability measure. The bracket extends continuously at $(\tau,\tau)$, so its minimum on the compact parameter triangle is attained.

For completeness, the minimum-expectation function at a general mean $t$ is a convex minorant of $h$: mixing feasible distributions proves convexity, and the point mass at $t$ proves that it lies below $h$. Jensen's inequality shows that every convex minorant lies below this function. Hence it is precisely co $h$.

Finally, if $\mu$ has mean $m<\tau$, mix it with the point mass at 1 with weight $t=(\tau-m)/(1-m)$. This produces mean $\tau$. Since $h(1)\le h(s)$ for every $s$, the operation cannot increase the expected value of $h$. This proves equality with the mean-at-most-$\tau$ problem. QED.

This argument also explains why an odd profile's strict finite-sample inequality on its mean support mass is compatible with an asymptotic sharp constant governed by the value at exactly 1/2.

### 3.3 The universal upper bound

**Theorem 3. Sufficiency.**

If $F_p(\lambda)\ge0$, then for every finite $d$, every odd $n\ge3$, every profile $x$, and every reference location $f$,

$$
\sum_i\|x_i-f\|_2^p
\ge\lambda^p\sum_i\|x_i-m(x)\|_2^p.
\tag{R10}
$$

For $\lambda>0$ this implies $C(p)\le1/\lambda$.

**Proof.** Translate the median to zero. If $f=0$, (R10) is immediate. Otherwise divide all points and $f$ by $\|f\|_2$. Reflect individual coordinate axes so that the normalized reference vector has $f_j\ge0$ and $\|f\|_2=1$. For odd $n$, the coordinate median transforms equivariantly under these translations, positive scalings, and reflections, so it is still zero.

For each point set

$$
r_i=\|x_i\|_2,\qquad
s_i=\sum_{j:x_{ij}>0}f_j^2.
\tag{R11}
$$

Every $s_i$ belongs to [0,1]. Cauchy--Schwarz yields

$$
f\cdot x_i
\le\sum_{j:x_{ij}>0}f_jx_{ij}
\le\sqrt{s_i}\,\|(x_i)_+\|_2
\le\sqrt{s_i}\,r_i.
\tag{R12}
$$

No coordinate is divided by $f_j$; zero reference coordinates cause no problem. It follows that

$$
\|x_i-f\|_2^p-\lambda^p\|x_i\|_2^p
\ge g_{p,\lambda}(r_i,s_i)\ge h_{p,\lambda}(s_i).
\tag{R13}
$$

In every coordinate at most ($n$-1)/2 points are strictly positive, because its odd median is zero. Therefore

$$
\frac1n\sum_i s_i
=\sum_j f_j^2\frac{\#\{i:x_{ij}>0\}}n
\le\frac{n-1}{2n}<\frac12.
\tag{R14}
$$

Apply Lemma 2 to the empirical distribution of $s_i$. Its average $h$-value is at least $F_p(\lambda)\ge0$. Summing (R13) proves the normalized inequality. Multiplying back by $\|f-m\|_2^p$ proves (R10). Taking the minimum over $f$ gives the ratio statement. QED.

This proof does not require the earlier fixed-sign KKT reduction. It uses only the strict positive support, the odd-median counting inequality, and Euclidean Cauchy--Schwarz.


## 4. Global contact classification and evaluation

We now evaluate the auxiliary moment minimum rather than leaving it as the answer. Write $t=\lambda^p$, $u=\sqrt X$, and

$$
F_t(r,u)=(r^2+1-2ru)^{p/2}-tr^p,\qquad
h_t(X)=\min_{r\ge0}F_t(r,\sqrt X),\qquad
H_p(t)=(\operatorname{co}h_t)(1/2).
\tag{11}
$$

Thus $H_p(t)=F_p(t^{1/p})$ in the notation of Section 3. The function $F_t(r,u)$ is a pointwise cost difference, whereas $F_p(\lambda)$ in (R3) is the moment minimum; their arguments distinguish them. This section proves the exact threshold and the contact configurations needed for the finite witnesses.

### 4.1 Existence of the global threshold and support line

For any compact subinterval of $0 \le  t < 1$, the objective is uniformly coercive in $r$, because for $r\ge 1$,

$$
 F_t(r,u)\ge(r-1)^p-tr^p\longrightarrow+\infty
$$

uniformly over $u\in [0,1]$. Consequently $h_t$ is continuous in $(t,X)$ on every such compact set. Its lower convex envelope at $1/2$, denoted $H_p(t)$, is attained by a probability measure on $[0,1]$ with mean $1/2$; a minimizer with at most two atoms exists. Equivalently, one may minimize the chord value over $a \le  1/2 \le  b$, extending the coincident case $a=b=1/2$ continuously.

At $t=0$, $h_0(X)=(1-X)^{p/2}$. If $p\ge 2$, Jensen gives $H_p(0)\ge 2^{-p/2}$; if $p\le 2$, the chord bound gives $H_p(0)\ge 1/2$. In either case it is positive.

Every radial minimizer satisfies $r\ge u$: on $0\le r<u$, increasing $r$ decreases both terms in $F_t$ (with the evident one-sided interpretation when $p=1$). Therefore, if $t_2>t_1$, using a two-atom minimizer at $t_1$ gives

$$
 H_p(t_2)\le H_p(t_1)-(t_2-t_1)\min(1/2,2^{-p/2}).
$$

The lower bound on the moment uses $E[X]=1/2$ and $r^p\ge X^{p/2}$. Thus $H_p$ is strictly decreasing. It is continuous by uniform coercivity and compact minimization.

The trial measure with equal mass at $0,1$ gives $H_p(t)<0$ for $t$ sufficiently close to $1$: for $p>1$, $h_t(1)=-E_p(t)$ tends to minus infinity while $h_t(0)\le 1$; for $p=1$, $h_t(0)=\sqrt{1-t^2}$ and $h_t(1)=-t$.

Hence there is exactly one $t_*\in (0,1)$ with $H_p(t_*)=0$. At this threshold there is a finite supporting affine function through $(1/2,0)$, say

$$
 h_{t_*}(X)\ge b(1/2-X).
$$

Its equality contact set has $1/2$ in its convex hull. Because $h_t(1)<0$ and $h_t(0)\le 1$, the slope parameter satisfies

$$
 0<2E_p(t_*)\le b\le2.
$$

Equivalently,

$$
 Q(r,u):=F_{t_*}(r,u)+b(u^2-1/2)\ge0
$$

on its whole domain. A contact is a zero global minimum of $Q$. This existing global support line is used below to identify the unique explicit parameter. No assumption that an arbitrary stationary point is globally minimizing is made.

### 4.2 Classification of interior zero contacts

Consider a zero contact with $0<u<1$. Its radial coordinate is positive; otherwise the right radial derivative is $-pu<0$ for $p>1$, and $-u-t<0$ for $p=1$. Also $D=r^2+1-2ru>0$. The stationarity equations imply $r>u$ and, setting $k=u/r\in (0,1)$ and $A=D^((p-2)/2)$,

$$
 t=(1-k)(D/r^2)^{(p-2)/2},\qquad
 b=\frac{pA}{2k}.
$$

Using the radial stationarity equation, the objective at the contact reduces to $F_t(r,u)=(1-ru)A$. Combining $Q=0$ with the expression for $b$ gives

$$
 \boxed{\ 4k+2(p-2)u^2=p\ }.
$$

Thus for $p\ne 2$ every interior zero contact is one of the explicit parameterized points in Section 1.

Define

$$
 N_p(k)=p-2(p+2)k(1-k),
$$
$$
 J_p(k)=-2(p+2)k^2+p(p+2)k-p(p-1).
$$

Then

$$
 D=\frac{N_p(k)}{2(p-2)k^2},
$$

and direct differentiation of $Q$ in variables $(r,u)$ yields

$$
 \boxed{\ \frac{\det \nabla^2Q}{(pA)^2}
       =\frac{(p-2)J_p(k)}{N_p(k)}.\ }
$$

Since $N_p(k)/(p-2)>0$ at every physical contact, a necessary condition for a local minimum is $J_p(k)\ge 0$. The discriminant of this quadratic is

$$
 p(p+2)(p-2)(p-4).
$$

Two further identities, obtained by differentiating the explicit contact curve, are

$$
 \frac{d}{dk}\log b_p(k)=\frac{J_p(k)}{kN_p(k)},
$$
$$
 \frac{d}{dk}\log T_p(k)=
 \frac{p(2k-1)J_p(k)}{(p-4k)(k-1)N_p(k)}.
$$

These identities provide a global count of admissible interior zero contacts for a fixed support slope; they do not require uniqueness of the unrestricted radial minimizer of $h_t$.

#### The region $1\le p<2$

The physical contact interval is $p/4 < k < (4-p)/4$. Its endpoints are symmetric about $1/2$, and

$$
 N_p(p/4)=N_p((4-p)/4)=\frac{p^2(p-2)}8<0.
$$

The quadratic $N_p$ is convex, so its value throughout the closed interval is at most the common endpoint value. Thus $N_p(k)<0$ on the entire physical interval, not merely at the already identified global contacts. Consequently $d_p(k)>0$ there.

The quadratic $J_p$ is strictly concave. Its nonnegative set, intersected with the physical interval, is therefore an interval. On the interior of that stable interval it is positive: a nonzero quadratic with negative leading coefficient has positive values strictly between its two distinct roots. Since $kN_p(k)<0$, the logarithmic derivative of $b_p$ is negative there. It can vanish only at a boundary root of $J_p$; it does not vanish on any subinterval. Hence $b_p$ is strictly decreasing on the whole feasible stable interval, including any included boundary root. A fixed support slope has at most one interior zero contact.

In particular,

$$
 J_p(p/4)=\frac{p(p-2)(p-4)}8>0,\qquad
 J_p(1/2)=\frac{(p-1)(2-p)}2\ge0.
$$

Strict concavity (or comparison with the chord between these two endpoint values) gives $J_p(k)>0$ throughout $(p/4,1/2)$. At $p=1$, $J_1(1/2)=0$, but every point of that open interval still has a strictly positive value; the upper stable endpoint is exactly $1/2$.

#### The region $2<p\le4$

For $2<p<4$, the quadratic discriminant is negative and its leading coefficient is negative, so $J_p(k)<0$ everywhere. For $p=4$, $J_4(k)=-12(k-1)^2<0$ for a physical interior contact. There are no interior zero contacts.

#### The region $p>4$

Here $J_p$ is strictly increasing for $0<k<1$, because $J_p'(k)=(p+2)(p-4k)>0$. Moreover, $J_p(1/2)=(p-1)(2-p)/2<0$ and $J_p(1)=p-4>0$. Its unique root in $(1/2,1)$ is $\kappa_p$, and every interior zero contact has $k\ge \kappa_p>1/2$.

Every point of the stated high-$p$ root domain is physically valid. Indeed, for $\kappa_p\le k<1$,

$$
 p-4k>p-4>0,\qquad p-4k<p-2,
$$

so $0<x_p(k)<1/2$ and $r_p(k)>0$. Furthermore, $k(1-k)\le 1/4$ yields

$$
 N_p(k)\ge p-\frac{p+2}{2}=\frac{p-2}{2}>0,
$$

which proves $d_p(k)>0$. Thus the real powers defining $T_p$ and $b_p$ have positive bases throughout this domain. The restriction $T_p(k)<1$ only enforces the original coefficient range; it does not conceal an additional geometric restriction.

On this stable interval $J_p(k)>0$ for $k>\kappa_p$, so $b_p$ is strictly increasing, with a possible zero derivative only at $\kappa_p$. This gives injectivity on the entire stable interval. The derivative identity for $T_p$ gives strict decrease, since its denominator has signs $(+)(-)(+)$ and its numerator is positive. Also, as $k$ tends to $1$, $d_p(k)/r_p(k)^2$ tends to $p/(p-4)$, so $T_p(k)$ tends to zero. Hence the admissible set $T_p(k)<1$ is a nonempty final subinterval of the physical branch.

### 4.3 Boundary contacts and the global contact pattern

At $u=1$, direct minimization gives $h_t(1)=-E_p(t)$, as in Section 1.

At $u=0$, for $p\ge 2$,

$$
 (1+r^2)^{p/2}-tr^p\ge1+(1-t)r^p,
$$

so the unique radial minimizer is $r=0$ and $h_t(0)=1$.

For $1\le p<2$, instead,

$$
 r_0^2=\frac{t^{2/(2-p)}}{1-t^{2/(2-p)}},\qquad
 h_t(0)=\bigl(1-t^{2/(2-p)}\bigr)^{(2-p)/2}<1.
$$

This positive radial minimizer makes a zero contact at $u=0$ impossible: at that point, the one-sided derivative $Q_u=-pr_0(1+r_0^2)^((p-2)/2)$ is strictly negative. The full support inequality would fail immediately for positive $u$.

For $p>4$, a zero contact at $u=0$ would require $b=2$. Along $r=u$ as $u$ tends to zero,

$$
 Q(u,u)=(1-u^2)^{p/2}-tu^p+2u^2-1
       =(2-p/2)u^2+o(u^2)<0,
$$

also impossible.

At the boundary $r=0$, one has $Q(0,u)=1+b(u^2-1/2)$; any minimum there other than $u=0$ is impossible since $b>0$ (or directly because $Q_r<0$ for $u>0$). Uniform coercivity excludes contact at infinity.

It follows:

* For $2<p\le 4$, the contact set must be the two endpoints $X=0,1$, because it must bracket $1/2$ and there are no interior contacts. Therefore $b=2$ and $E_p(t_*)=1$, giving $t_*=2^{1-p}$. At $p=2$, the direct formula $h_t(X)=1-X/(1-t)$ gives the same threshold.
* For $p>4$, the contact set must contain the endpoint $X=1$ and the unique interior zero contact, whose $X$ is strictly less than $1/2$.
* For $1\le p<2$, the contact set contains at most one interior point and cannot contain $X=0$. Consequently it is either a single contact at $X=1/2$, or the unique interior contact with $X<1/2$ together with endpoint $X=1$. At a plateau transition the endpoint may also be an equality contact while having zero weight in the mean-$1/2$ measure.

This classifies all possibilities for the global optimum, including possible nonsmooth radial branches. No additional interior contact can be hidden by taking a lower envelope of several radial minima: every such zero would obey the same stationarity and slope monotonicity conditions.

### 4.4 The unique admissible scalar root

For $1\le p<2$, define $\Delta_p:=p/2-E_p(2^{-p/2})$. At a single contact $X=1/2$, the contact identity forces $k=1/2$, hence $r=\sqrt2$, $t_*=2^{-p/2}$ and $b=p$.

Along the interior zero-contact parameter curve, differentiate the identity $Q=0$. The derivatives in $r,u$ vanish by stationarity, so

$$
 -r_p(k)^p T_p'(k)+(x_p(k)-1/2)b_p'(k)=0.
$$

Therefore, on a contact branch with $x_p(k)<1/2$,

$$
 \boxed{\ R_p'(k)=b_p'(k)
 \left[\frac12+E_p'(T_p(k))\frac{1/2-x_p(k)}{r_p(k)^p}\right].\ }
$$

The bracket is positive. For $p>1$, $E_p'(t)=(1-t^{1/(p-1)})^{-p}>0$; for $p=1$, it is one.

For $1\le p<2$, on $p/4<k<1/2$ the quadratic $J_p(k)$ is strictly positive, so $b_p'<0$, $T_p'>0$, and $R_p'<0$. The endpoint limits are

$$
 \lim_{k\downarrow p/4}(T_p(k),b_p(k),R_p(k))=(0,2,1),
$$
$$
 T_p(1/2)=2^{-p/2},\quad b_p(1/2)=p,\quad
 R_p(1/2)=\Delta_p.
$$

Hence $\Delta_p<0$ gives exactly one root in $(p/4,1/2)$, whereas $\Delta_p\ge 0$ gives no root there (with the endpoint root at equality). By the global classification in Section 4.3, if $\Delta_p\ge 0$ the threshold must be the single-contact value $2^{-p/2}$. If $\Delta_p<0$, the single-contact support violates the endpoint inequality, and the unique root must be the true threshold.

For $p>4$, $b_p'>0$, $T_p'<0$, and $R_p'>0$ on the interior of the admissible stable interval. The condition $T_p(k)<1$ cuts out an interval; hence at most one root exists there. A root does exist: independently established threshold existence and the global contact classification force an interior/endpoint pair, which supplies such a root. Thus the unique root is exactly the threshold, and the global support inequality in Section 1 follows from this identification. This uses necessity plus existence plus uniqueness, not an unsupported local-to-global inference.

For completeness, the improvement over the planar guarantee is strict on both outer intervals. In the low interval $\Delta_p<0$, the trial single contact at $t=2^{-p/2}$ would force $b=p$ but violate the endpoint support inequality, so the exact threshold is smaller and $C(p)>\sqrt2$. For $p>4$, the endpoint trial measure at $t=2^{1-p}$ has mean cost zero. If this were the threshold, the bounds $2E_p(t)\le b\le2$ would force $b=2$ and a contact at $X=0$, which Section 4.3 excludes. Hence that threshold too is strictly smaller, and $C(p)>2^{1-1/p}$.

### 4.5 The low-exponent transition and the known $p=1$ anchor

To prove that the transition is unique, put

$$
 q=\frac{p}{2(p-1)}>1,\qquad
 f(q)=(2q-1)\log(2-1/q)-\log(2^q-1).
$$

For $1<p<2$, $\Delta_p<0$ is equivalent to $f(q)>0$. Moreover,

$$
 f''(q)=\frac1{q^2(2q-1)}+
 (\log2)^2\frac{2^{-q}}{(1-2^{-q})^2}>0.
$$

Since $f(1)=0$, $f'(1)=1-2\log2<0$, $f(3/2)<0$, and $f(2)=\log(9/8)>0$, strict convexity gives exactly one further root $q_*\in (3/2,2)$. Thus

$$
 p_* =\frac{2q_*}{2q_*-1}\in(4/3,3/2),
$$

and the scalar ratio is $\sqrt2$ precisely on the low-$p$ plateau $p_*\le p\le 2$. The reported numerical value $p_* \approx 1.44074973749$ is illustrative; the root definition and uniqueness proof specify it exactly.

At $p=1$, the outer equation simplifies to $4(1-k)\sqrt x=1$ with $x=2k-1/2$. Writing $v=\sqrt x$, this is

$$
 2v^3-3v+1=(v-1)(2v^2+2v-1)=0.
$$

The admissible root is $v=(\sqrt3-1)/2$, giving $x=1-\sqrt3/2$, $k=(3-\sqrt3)/4$, and

$$
 t_*^{-2}=6\sqrt3-8.
$$

This recovers the known Gravin-Jia constant; it is a check, not a new contribution.


## 5. Finite odd-population witnesses and exact sharpness

The following construction applies to arbitrary finite radii, not merely radial minimizers.

### 5.1 Two distinct support fractions

Suppose

$$
0\le a<\tau<b\le1,\qquad
w=\frac{b-\tau}{b-a},\qquad
1-w=\frac{\tau-a}{b-a},\qquad r_a,r_b\ge0.
\tag{R15}
$$

For any even integer $d\ge4$ set

$$
k_a=\max\{1,\lfloor da\rfloor\},\quad
k_b=\lceil db\rceil,\quad
a_d=k_a/d,\quad b_d=k_b/d,
$$
$$
A=k_b-d/2,\qquad B=d/2-k_a,\qquad
N=d(A+B),\qquad w_d=A/(A+B).
\tag{R16}
$$

Then $1\le k_a<d/2<k_b\le d$, A and B are positive integers, N is even, and

$$
a_d\longrightarrow a,\quad b_d\longrightarrow b,\quad
w_d\longrightarrow w,\qquad
w_da_d+(1-w_d)b_d=1/2.
\tag{R17}
$$

In particular, $a=0$ is handled by $k_a=1$; one must not set $k_a=0$ when $r_a>0$.

Use the reference point

$$
f^{(d)}=d^{-1/2}(1,\ldots,1).
\tag{R18}
$$

For an integer $k\in[1,d]$, a radius $r\ge0$, and shift $t\in\{0,\ldots,d-1\}$, define $v(k,r,t)$ by assigning $r/\sqrt k$ to the $k$ cyclically consecutive coordinates

$$
\{t,t+1,\ldots,t+k-1\}\pmod d
$$

and assigning zero to the others. Repeated vectors are retained as distinct agents. The vector is zero if $r=0$. These vectors satisfy

$$
\|v(k,r,t)\|_2=r,\qquad
f^{(d)}\cdot v(k,r,t)=r\sqrt{k/d},\qquad
\|v(k,r,t)-f^{(d)}\|_2^p=\Psi_p(r,k/d).
\tag{R19}
$$

Take A copies of the complete $d$-shift orbit with parameters $(k_a,r_a)$, and B copies of the orbit with $(k_b,r_b)$. This gives a base multiset of N points.

Each coordinate belongs to exactly $k$ of the $d$ supports in a $k$-orbit. Consequently the number of assigned positive-support labels at each coordinate is

$$
A k_a+B k_b
=\frac d2(k_b-k_a)=N/2.
\tag{R20}
$$

When a radius is zero, actual strictly positive entries are fewer than the assigned labels, which only helps the median condition.

Now replicate the entire base multiset $L\ge1$ times and append one zero vector. The resulting profile has

$$
n=LN+1\ge3\quad\hbox{odd}.
\tag{R21}
$$

All points are coordinatewise nonnegative, and each coordinate has at most $LN/2$ strictly positive entries. Thus at least $LN/2+1$ entries are zero and the unique numerical median value in every coordinate is zero.

This proves the actual order-statistic condition, not just an abstract sign-balance constraint.

### 5.2 Exact cost formulas

Here $\operatorname{SC}_p$ denotes exactly the social cost $S_p$ defined in (1).

Define

$$
S_d=w_d r_a^p+(1-w_d)r_b^p,\quad
T_d=w_d\Psi_p(r_a,a_d)+(1-w_d)\Psi_p(r_b,b_d),
\quad E_d=T_d-\lambda^pS_d.
\tag{R22}
$$

For the finite odd profile constructed above,

$$
\operatorname{SC}_p(0;x)^p=LN S_d,\qquad
\operatorname{SC}_p(f^{(d)};x)^p=LN T_d+1,
\tag{R23}
$$

and

$$
\sum_i\bigl(\|x_i-f^{(d)}\|_2^p-\lambda^p\|x_i\|_2^p\bigr)
=LN E_d+1.
\tag{R24}
$$

Provided $S_d>0$, the profile is nonconstant because it contains both a nonzero point and the appended zero. Its true approximation ratio is at least the completely explicit reference ratio

$$
\left(\frac{S_d}{T_d+1/(LN)}\right)^{1/p}.
\tag{R25}
$$

No assertion that $f$^($d$) is the optimal facility is needed: the optimum can only improve the denominator and increase the true ratio.

Cyclic support orbits suffice: all objective terms depend only on support size, and cyclic orbits already equalize each coordinate's incidence. Here $N\le d^2$; explicitly listing all base coordinates uses at most $O(d^3)$ entries. Replication may instead be stored as integer agent multiplicities.

### 5.3 A single atom at 1/2

If the scalar distribution is $\delta_{1/2}$, with radius $r\ge0$, choose any even $d\ge2$, $k=d/2$, and the $d$-shift orbit $v(k,r,t)$. Set $N=d$, replicate L times, and append zero. All preceding median arguments remain valid, and (R22)--(R25) become

$$
S_d=r^p,\qquad T_d=\Psi_p(r,1/2),\qquad
\text{reference ratio}=
\left(\frac{r^p}{\Psi_p(r,1/2)+1/(Ld)}\right)^{1/p}.
\tag{R26}
$$

Thus a=b=1/2 is handled directly, without division by $b-a$. If $a=1/2<b$, only the a-atom has positive weight; if $a<b=1/2$, only the b-atom has positive weight. Delete the other atom and use this case.

### 5.4 Necessity and matching sharpness

**Theorem 4. Exact equivalence.**

For $p\ge1$ and $\lambda\in(0,1)$, the following are equivalent:

1. Every finite odd profile satisfies (R10), for every reference facility.
2. $C(p)\le1/\lambda$.
3. $F_p(\lambda)\ge0$.

**Proof.** Theorem 3 proves 3=>1, and taking the optimal facility proves 1=>2. Conversely 2=>1 because every reference cost is at least the optimal cost.

For the remaining implication, suppose $F_p(\lambda)<0$. Lemmas 1 and 2 supply a two-atom minimizing distribution and finite radial minimizers. If it is nondegenerate, write its data as in (R15). Then

$$
E:=w g_{p,\lambda}(r_a,a)+(1-w)g_{p,\lambda}(r_b,b)
=F_p(\lambda)<0.
$$

The finite construction satisfies $E_d\to E$ by (R17) and continuity. Choose an even $d$ with $E_d<0$, and then an integer L with $LN(-E_d)>1$. Equation (R24) is negative, contradicting (R10). Negative E forces $S_d>0$ for sufficiently large $d$, so this is an admissible nonconstant profile. For a single atom use (R26) and increase L. This proves necessity. QED.

**Corollary 5. Realization of a zero contact.**

Suppose a one- or two-atom distribution of mean 1/2 and finite associated radii satisfies

$$
w\Psi_p(r_a,a)+(1-w)\Psi_p(r_b,b)
=\lambda^p\{w r_a^p+(1-w)r_b^p\}.
\tag{R27}
$$

Then the construction gives finite odd profiles whose reference ratios tend to $1/\lambda$.

**Proof.** Let S and T be the limiting weighted numerator and denominator powers. If $S=0$, all positive-weight radii vanish, which would give $T=1$ and contradict (R27). Hence $S>0$. Moreover, $\Psi_p(r,s)=0$ only when $s=1$ and $r=1$. A distribution of mean 1/2 cannot concentrate on those pairs, so $T>0$. By (R27), $T=\lambda^p S$. The cost formula (R25) converges to $(S/T)^{1/p}=1/\lambda$ as $d$ tends to infinity (and, if desired, L also tends to infinity). For the single-atom case only L need increase. QED.

These are genuine finite odd-profile witnesses. The limiting scalar distribution itself is not presented as an admissible finite input.


### 5.5 Applying the construction to every branch

On a nonlinear branch use $a=x_p(k_p)$, $b=1$, radii $r_a=r_p(k_p)$ and

$$
r_b=\begin{cases}1,&p=1,\\
(1-t_*^{1/(p-1)})^{-1},&p>1.
\end{cases}
\tag{12}
$$

The contact masses are $w=1/[2(1-a)]$ and $1-w=(1-2a)/[2(1-a)]$. Section 4 proves that both contacts attain the same global support line. Their weighted cost difference is therefore zero because the weighted support fraction is $1/2$. Here $0<a<1/2$, so the construction in Section 5.1 applies directly with finite radii and positive limiting numerator cost. Its dimension and population are finite at every step.

On the $\sqrt2$ plateau, use the single contact $X=1/2$, $r=\sqrt2$. The corresponding squared reference distance is one, and $t_*=2^{-p/2}$. A particularly simple two-dimensional profile has $L$ copies of $(2,0)$, $L$ copies of $(0,2)$, and one origin, with reference $(1,1)$. Its reference ratio is

$$
\sqrt2\left(\frac{2L}{2L+1}\right)^{1/p}\longrightarrow\sqrt2.
\tag{13}
$$

For $2\le p\le4$, use $L$ copies of $2$ and $L+1$ copies of $0$ on the line. The median is zero and the reference facility is one. Its reference ratio is

$$
2\left(\frac{L}{2L+1}\right)^{1/p}\longrightarrow2^{1-1/p}.
\tag{14}
$$

The ratio against the actual optimal facility is at least each displayed reference ratio and at most the universal value in (6). These two inequalities squeeze the true ratios to $C(p)$. The profile in (14) also covers the endpoint $p=2$, while (13) covers $p=p_*$. Thus every boundary and every finite exponent in the main theorem has a genuine sequence of finite odd witnesses. No claim that a reference facility is exactly optimal in a finite constructed profile is needed.

## 6. Effective finite-instance selection

The construction can be made quantitative before solving any branch.

Let the nondegenerate data in (R15) have $\Delta=b-a>0$ and let R be any upper bound for $r_a,r_b$. Set

$$
K=p(R+1)^{p-1}\sqrt2,\qquad
M=(R+1)^p+\lambda^pR^p.
\tag{R30}
$$

The vector representation (R5) and

$$
\|(\sqrt s,\sqrt{1-s})-(\sqrt t,\sqrt{1-t})\|_2
\le\sqrt{2|s-t|}
$$

show that, for $r\le R$,

$$
|g_{p,\lambda}(r,s)-g_{p,\lambda}(r,t)|
\le K\sqrt{|s-t|}.
\tag{R31}
$$

If $d\ge4/\Delta$, then $|a_d-a|,|b_d-b|\le1/d$ and

$$
|w_d-w|\le\frac{2}{d\Delta}.
$$

The last bound follows by subtracting the two fractions defining the weights; the numerator is
$(\tau-a)(b_d-b)+(b-\tau)(a_d-a)$, and the denominator is $\Delta(b_d-a_d)$.
Consequently

$$
|E_d-E|\le Kd^{-1/2}+\frac{4M}{d\Delta}.
\tag{R32}
$$

If $E=-\gamma<0$, choose an even $d$ at least

$$
\max\left\{4,\frac4\Delta,
\left(\frac{4K}{\gamma}\right)^2,
\frac{16M}{\gamma\Delta}\right\},
$$

and choose $L\ge\max\{1,\lceil4/(\gamma N)\rceil\}$. Equations (R24) and (R32) then give

$$
E_d+\frac1{LN}\le-\gamma/4<0.
\tag{R33}
$$

Thus these explicit integer choices produce a finite counterexample to any proposed $\lambda$ with negative scalar certificate.

For a zero contact at $\lambda$, and a requested ratio within $\epsilon$ of $1/\lambda$, first choose $\lambda'>\lambda$ so close that $1/\lambda'>1/\lambda-\epsilon$. At the same contact data the new scalar energy is

$$
E'=-(\lambda'^p-\lambda^p)S<0.
$$

Apply (R33) with $\lambda'$. The resulting finite odd profile has ratio greater than $1/\lambda'$, hence greater than $1/\lambda-\epsilon$.

Radial minimizers can be approximated constructively on the bounded interval (R4). On $0\le r\le R$, the scalar function is Lipschitz in $r$ with constant

$$
p\bigl((R+1)^{p-1}+\lambda^pR^{p-1}\bigr).
$$

A uniform mesh therefore gives a rigorous additive objective tolerance. Contact support fractions and radii can also be approximated by rationals with the continuity bounds above; strictly negative certificates survive sufficiently fine approximations. For computable parameters this gives an effective finite-instance procedure. No computability assertion is made for noncomputable real input parameters.

The companion `code/geometric_witness.py` implements the finite construction from supplied rational contact approximations. Its numerical cost output is a floating-point diagnostic of an exact symbolic orbit specification, not a certified evaluation of the all-$p$ scalar optimum.


## 7. A positive remainder for finite odd profiles

Section 4 proves the global pointwise support inequality

$$
F_{t_*}(r,\sqrt X)\ge b_*(1/2-X).
\tag{15}
$$

For the low plateau its single contact gives $b_*=p$, for the middle interval the endpoint pair gives $b_*=2$, and for the outer intervals it is the explicit positive slope in (4). At $p=2$ the direct formula $h_t(X)=1-X/(1-t)$ gives the same slope two. These choices agree where their intervals overlap.

Normalize $m=0$ and $\|f\|_2=1$ as in Theorem 3. The odd-median count (R14) implies

$$
\sum_iF_{t_*}(r_i,\sqrt{s_i})
\ge b_*\left(\frac n2-\sum_i s_i\right)\ge\frac{b_*}{2}.
\tag{16}
$$

Combining this with the pointwise Euclidean bound (R13) and scaling by $\|f-m\|_2^p$ proves (10). When $f=m$ the right-hand side is zero and the left-hand side is $(1-t_*)\sum_i\|x_i-m\|_2^p\ge0$, so no normalization is needed.

Every $C(p)>1$: (13) gives a limiting ratio $\sqrt2$ for every $p$, and (14) supplies the middle-interval values. For an admissible profile, if an optimal facility equals $m$, its ratio is one. Otherwise (10) at an optimal facility has a strictly positive right-hand side, and its ratio is strictly smaller than $t_*^{-1/p}$. This proves finite-instance nonattainment while preserving the sharp supremum from Section 5.

## 8. Scope, computation and verification status

The result fixes Euclidean individual distances and allows all finite dimensions, all finite odd populations, and every finite real $p\ge1$. It does not compute sharp constants at each fixed dimension or fixed population. It does not treat the endpoint $p=\infty$, even-population tie conventions, prediction-augmented mechanisms, randomized mechanisms, or optimality among all strategyproof mechanisms. The coordinate median's known strategyproofness motivates the problem but is not a new mechanism-design theorem here.

All universal assertions above are established by the written arguments. Symbolic algebra and finite numerical checks are supporting reproducibility artifacts, not proofs of a continuum of parameters. A symbolic check described in the original manuscript differentiates the original support function and verifies the displayed identities exactly in SymPy. The independent implementations of the cyclic construction enumerate finite vectors and check both coordinate medians and aggregate costs, including zero radii, support fractions tending to zero, and single-atom cases. A separate numerical calculation evaluates the specified roots at high precision and produces compressed finite witnesses. Its decimal outputs are not interval certificates. The analytic root domains and uniqueness proofs provide the exact specification.

Full formal verification is incomplete. The partial Lean statements have not been compiled and are not included in this edition. No Lean kernel certificate of the main theorem, machine-checked full proof, or external academic certification is asserted.

### References and access boundary

- **[H26]** Jabari Hastings. *Strategic Facility Location with p-Norm Social Costs*. arXiv:2606.12187v2, 10 July 2026. [Primary text](https://arxiv.org/abs/2606.12187v2). Theorem 2, Theorem 3 and Section 6 were inspected.
- **[GJ25]** Nick Gravin and Jianhao Jia. *Approximation guarantees of Median Mechanism in $\mathbb R^d$*. arXiv:2502.08578v2, 13 February 2025. [Primary text](https://arxiv.org/abs/2502.08578v2). Sections 3.2 and 3.3 give upper and matching asymptotic lower bounds for social exponent one.
- **[CLW26]** Hau Chan, Jianan Lin and Chenhao Wang. *Strategyproof Mechanisms for Euclidean Facility Location Problems under Lp-norm Social Cost*. arXiv:2606.08621v2, 28 June 2026. [Primary text](https://arxiv.org/abs/2606.08621v2). Theorem 1 concerns the Euclidean plane and was inspected.
- **[J26]** Jianhao Jia. *Strategyproof Aggregation in Euclidean Spaces: Rigidity and Median Optimality*. arXiv:2609.19394v2, 4 November 2026. [Primary text](https://arxiv.org/abs/2609.19394v2). The inspected model uses total Euclidean distance; the focus includes mechanism rigidity and optimality.
- **[LA26]** *Learning-Augmented Mechanism Design for Facility Location under L_p-Norm Social Costs*. NeurIPS 2026 poster 149389, OpenReview qPSvrFGIoy. [Official abstract](https://nips.cc/virtual/2026/poster/149389). The line-and-predictions scope is supported by the accessible official abstract. The complete OpenReview PDF and API were unavailable (HTTP 403); no unseen claims are used in the proof or excluded by the novelty comparison.

- **[S26]** Song Zichen. *The Exact Approximation Ratio of Uniformly Rotated Coordinate-wise Median in the Euclidean Plane*. arXiv:2609.18152, 16 September 2026. [Primary text](https://arxiv.org/abs/2609.18152). The rendered primary text, including Theorems 2.2 and 3.1 and the conclusion, was inspected through the indexed source. No claim of a downloaded PDF is made.

The literature comparison is limited to the cited materials and accessible versions.
