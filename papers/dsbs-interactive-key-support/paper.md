---
title: "Global entropy support for binary symmetric sources and the absence of an interactive key-rate gain"
date: "26 November 2026"
lang: en
fontsize: 11pt
geometry: margin=24mm
---

## Abstract

We prove the global entropy support inequality conjectured by Liu, Cuff and Verdú for a doubly symmetric binary source. For every nondegenerate source correlation and every interior supporting slope, the specified affine correlation support dominates the entropy functional on the entire family of row and column tilts, with equality at exactly the four prescribed one-sided tilts. The proof uses an auxiliary two-field Ising family: every stationary point off the two diagonals has negative definite Hessian, while a planar index calculation excludes additional maxima. Applying the published interactive source-coding characterization yields the complete secret-key versus total-public-communication boundary and proves that interaction gives no improvement over one-way communication. The argument covers all supporting slopes, deterministic posterior boundaries, and the finite-round closure of the operational region. The rate curve, candidate support, and the operational reduction originate in the earlier literature; the contribution is their global supporting inequality and its equality classification.

## 1. Problem, model, and contribution

Let $X$ be a uniform bit, let $N\sim\operatorname{Bernoulli}(p)$ be independent of $X$, and let $Y=X\oplus N$. We initially assume $0< p< 1/2$. Two terminals observe independent copies of $(X,Y)$ and communicate publicly in alternating rounds, with independent local randomization permitted. The eavesdropper observes the public transcript and has no additional side information. Reliability, uniformity, and secrecy are measured by convergence in total variation to a common uniform key independent of that transcript, as in Definition 1 of [1]. Communication is measured by normalized logarithms of message-alphabet sizes. All entropies and rates below use natural logarithms.

Write $C$ for the sum of the two public communication rates and $K$ for the secret-key rate. The coordinate $S$ used in [1] is $S=C+K$; it is not the public communication rate. Theorem 1 of [1] characterizes each finite-round region by alternating auxiliary random variables and characterizes its arbitrary-finite-round closure. The same paper determines the low-communication efficiency and the communication needed at the maximum-key endpoint. Tyagi's earlier work [2] concerns the maximum-key endpoint and the role of common information. These endpoint results do not determine the intermediate curve.

Conjecture 1 of [1] proposes equality of the complete one-way and interactive regions in the $(S,K)$ projection. Appendix F gives a stronger, pointwise entropy inequality, called Conjecture 2, that would imply this operational statement. The candidate support, its four contact points, and numerical and asymptotic evidence are already present in [1]. We prove that pointwise inequality throughout its domain, including the closed boundary of the tilt square. The key structural statement is Lemma 3.2: every stationary point away from the two diagonals in an associated two-parameter entropy objective is a strict local maximum, even when its support parameter is allowed to vary freely. An elementary planar index argument then proves that the four known contacts are all the global maxima.

Two recent binary-information results concern nearby but different optimization problems. Guo [3] maximizes mutual information under a constraint expressed through KL contraction; its upper bound does not supply the lower mutual-information support at fixed odds ratio needed here. Pichler [4] studies the information region of independent binary channels attached to the two ends of a doubly symmetric source. Its two-channel convexification does not assert a pointwise bound for alternating transcript posteriors. Neither result is used as an unproved bridge in the proof below. The assertions and proof domains in those works are distinguished from the present statement; no exhaustive priority claim beyond the identified sources is needed for the mathematical argument.

## 2. Entropy support and operational theorems

For $z\in[0,1]$, define

$$
h(z)=-z\log z-(1-z)\log(1-z),
\qquad 0\log0:=0.
$$

It is convenient to use spins in $\{-1,1\}$. Put $r=1-2p\in(0,1)$ and write the source law as

$$
Q_r(x,y)=\frac{1+rxy}{4}.
$$

Its complete family of row and column tilts is

$$
D=1+ruv,\qquad
P_{u,v}(x,y)=\frac{(1+rxy)(1+ux)(1+vy)}{4D},
\qquad (u,v)\in[-1,1]^2. \tag{2.1}
$$

Since $D\ge1-r>0$, this definition includes deterministic row and column boundaries. Set

$$
e(z)=\frac{(1+z)\log(1+z)+(1-z)\log(1-z)}2
=\log2-h((1-z)/2),
$$

and, for $a\in(0,1)$, define

$$
J=\operatorname{atanh}r,\qquad
s=r\frac{\operatorname{atanh}(ra)}{\operatorname{atanh}a},\qquad
\kappa_0=\frac{\operatorname{atanh}(ra)}a,
\qquad M=(1+s)J-\kappa_0. \tag{2.2}
$$

For a binary pair with law $P$, let

$$
F_s(P)=sH_P(X,Y)-I_P(X;Y)
=(1+s)H_P(X,Y)-H_P(X)-H_P(Y),
$$
$$
A=F_s(Q_r)+e(ra)-s e(a),\qquad
\chi(P_{u,v})=A-M\bigl(\mathbb E_{P_{u,v}}XY-r\bigr). \tag{2.3}
$$

**Theorem 2.1 (global entropy support).** For every $r,a\in(0,1)$ and every $(u,v)\in[-1,1]^2$,

$$
F_s(P_{u,v})\le\chi(P_{u,v}). \tag{2.4}
$$

Equality holds exactly at $(u,v)=(a,0),(-a,0),(0,a),(0,-a)$.

To identify (2.4) with the original statement, put $q=(1-a)/2$, $f=(1-u)/2$, $g=(1-v)/2$, and $t=p+q-2pq$. The law (2.1) is the normalization, by $Z=D/2$, of

$$
\begin{pmatrix}
(1-p)(1-f)(1-g)&p(1-f)g\\
pf(1-g)&(1-p)fg
\end{pmatrix}.
$$

Writing $L_x=\log((1-x)/x)$, its support parameters are

$$
s=(1-2p)L_t/L_q,\qquad
A=s[h(p)+h(q)]-h(t)+h(p),
$$
$$
c=4p(1-p)\left[\frac{L_t}{1-2q}-(1+s)L_p\right],
\qquad
\chi=A+c\frac{(f-1/2)(g-1/2)}Z. \tag{2.5}
$$

Indeed $\mathbb E_{P_{u,v}}XY=(r+uv)/D$, so $c=-2(1-r^2)M$. Thus Theorem 2.1 is precisely the global support in Appendix F of [1], and not merely a bound on the central cross of the tilt square. Relabeling one spin treats a negative source correlation; replacing $a$ by $-a$ leaves the parameters and contact set unchanged.

**Theorem 2.2 (complete key-rate boundary).** For the operational model above, the maximum secret-key rate at total communication budget $C$ is the one-way boundary

$$
C(q)=h(p+q-2pq)-h(q),\qquad
K(q)=\log2-h(p+q-2pq),\qquad 0\le q\le\tfrac12, \tag{2.6}
$$

for $0\le C\le h(p)$. For $C\ge h(p)$ it is the constant $K=\log2-h(p)$. This equality concerns the projection onto total communication and key rate, rather than a claim about every separately specified pair of directional communication budgets. It includes the closure over arbitrary finite numbers of alternating rounds, under the operational convention of [1].

Sections 3--5 prove Theorem 2.1 without an information-theoretic coding theorem. Section 6 derives Theorem 2.2 from the published characterization in [1] and explicitly handles the limiting parameters.

## 3. The two-field objective and its stationary curvature

### 3.1. Derivative identities

Temporarily treat $s$ and $\kappa$ as free real parameters and define, on the open square,

$$
\mathcal G_{s,\kappa}(u,v)
=F_s(P_{u,v})+[(1+s)J-\kappa]\bigl(z(u,v)-r\bigr),
\quad z(u,v)=\frac{r+uv}{1+ruv}. \tag{3.1}
$$

The target is $\mathcal G_{s,\kappa_0}\le A$. Set

$$
U=\operatorname{atanh}u,\quad V=\operatorname{atanh}v,\quad
R_u=\operatorname{atanh}(ru),\quad R_v=\operatorname{atanh}(rv),
$$
$$
B_1=R_v-sU,\qquad B_2=R_u-sV,
$$
$$
E_1=(1-r^2v^2)B_1+r(1-v^2)B_2-\kappa(1-r^2)v,
\quad E_2=E_1(v,u).
$$

Then

$$
\mathcal G_u=E_1/D^2,\qquad \mathcal G_v=E_2/D^2. \tag{3.2}
$$

Here and below, the notation $E_1(v,u)$ means exchange of all occurrences of the two tilt variables. For a derivation, (2.1) is the exponential family proportional to $\exp(Jxy+Ux+Vy)$. Its means are

$$
x_*=(u+rv)/D,\qquad y_*=(v+ru)/D,
$$

with $\operatorname{atanh}x_*=U+R_v$ and $\operatorname{atanh}y_*=V+R_u$. Differentiating its entropy with respect to $U,V$ gives covariances. In particular,

$$
\operatorname{Var}X=\frac{(1-u^2)(1-r^2v^2)}{D^2},\quad
\operatorname{Cov}(X,Y)=\frac{r(1-u^2)(1-v^2)}{D^2},
$$
$$
\operatorname{Cov}(X,XY)=\frac{(1-r^2)v(1-u^2)}{D^2}, \tag{3.3}
$$

and the swapped identities also hold. Consequently
$\mathcal G_U=B_1\operatorname{Var}X+B_2\operatorname{Cov}(X,Y)-\kappa\operatorname{Cov}(X,XY)$.
Multiplying by $dU/du=(1-u^2)^{-1}$ proves (3.2).

The covariance matrix of $(X,Y)$ is positive definite in the open square. Solving the two stationary equations in (3.2) yields the equivalent equations

$$
B_1=\kappa\frac{v-ru}{1-ruv},\qquad
B_2=\kappa\frac{u-rv}{1-ruv}. \tag{3.4}
$$

At a stationary point define

$$
P_*=(1-u^2)(1-v^2),\quad Q_*=(1-r^2u^2)(1-r^2v^2),\quad
\mu=r\sqrt{P_*/Q_*},\quad \lambda=\frac{\kappa}{1-ruv}.
$$

The quantities $P_*,Q_*,\mu$ are positive; no sign is imposed on $\lambda$ at this stage.

Differentiating (3.2), using $E_1=E_2=0$ and then (3.4), gives

$$
D^2\mathcal G_{uu}=\frac{1-r^2v^2}{1-u^2}(\mu^2-s),\qquad
D^2\mathcal G_{vv}=\frac{1-r^2u^2}{1-v^2}(\mu^2-s), \tag{3.5}
$$
$$
D^2\mathcal G_{uv}=T:=r(1-s)-\lambda(1-r^2)D,
$$
$$
D^4\det\nabla^2\mathcal G=\frac{r^2}{\mu^2}(s-\mu^2)^2-T^2. \tag{3.6}
$$

For example, the unscaled cross derivative is
$\partial_vE_1=r(1-s)-\kappa(1-r^2)-2rv(rB_1+B_2)$;
inserting (3.4) gives the stated $T$. These formulas concern stationary points; no global sign of the Hessian is asserted away from them.

### 3.2. Every non-diagonal stationary point is a strict maximum

**Lemma 3.2 (stationary curvature).** Fix $0< r< 1$. If $(u,v)\in(-1,1)^2$ is a stationary point of (3.1) and $u^2\ne v^2$, then $0< s< r^2$, $\kappa>0$, and the Hessian of $\mathcal G_{s,\kappa}$ is negative definite.

**Proof.** Coordinate exchange and simultaneous sign reversal allow us to assume $0< u< 1$ and $-u< v< u$. Let $x=u^2$, $y=v^2$, and $w=uv$, so $x>y$. Elimination from (3.4) gives

$$
L=(u-rv)U+(ru-v)V,
$$
$$
s=\frac{(ru-v)R_u+(u-rv)R_v}{L},\qquad
\kappa=\frac{(1-rw)(UR_u-VR_v)}L. \tag{3.7}
$$

The denominator is positive. In fact, define

$$
I_b=\int_0^1\frac{1-rw t^2}{(1-b^2x t^2)(1-b^2y t^2)}\,dt,
\qquad b\in\{1,r\}.
$$

Using $\operatorname{atanh}z=z\int_0^1(1-z^2t^2)^{-1}dt$ in (3.7) shows

$$
L=(x-y)I_1>0,\qquad s=r^2I_r/I_1. \tag{3.8}
$$

The ratio $I_r/I_1$ is a positive weighted average of

$$
R(t)=\frac{(1-x t^2)(1-y t^2)}{(1-r^2x t^2)(1-r^2y t^2)}.
$$

This function is strictly decreasing on $(0,1)$, since $x>0$, $0< r< 1$, and each nonconstant factor decreases. Its endpoint values are $1$ and $P_*/Q_*$. Therefore

$$
\mu^2< s< r^2. \tag{3.9}
$$

Also $UR_u>VR_v$, since their products are even and strictly increasing in the absolute tilt. Thus $\kappa>0$.

The diagonal Hessian entries in (3.5) are negative. By (3.6), positive determinant is equivalent to

$$
\frac{r(1+\mu)(\mu-s)}{\mu(1-r^2)D}
< \lambda<
\frac{r(1-\mu)(\mu+s)}{\mu(1-r^2)D}. \tag{3.10}
$$

Introduce the positive divided differences

$$
A_-=(U-V)/(u-v),\quad B_-=(R_u-R_v)/(u-v),
$$
$$
A_+=(U+V)/(u+v),\quad B_+=(R_u+R_v)/(u+v).
$$

Adding and subtracting (3.4) yields

$$
\lambda(1+r)=B_-+sA_-,\qquad
\lambda(1-r)=B_+-sA_+. \tag{3.11}
$$

For $0< t< 1$, integration of the strict derivative comparison gives

$$
\operatorname{atanh}t< \frac{t}{\sqrt{1-t^2}}. \tag{3.12}
$$

Apply the atanh subtraction formula with $t=(u-v)/(1-uv)$, and its $r$-scaled counterpart. Inequality (3.12) gives $A_-< 1/\sqrt{P_*}$ and $B_-< r/\sqrt{Q_*}$. Hence

$$
\lambda< \frac{\mu+s}{(1+r)\sqrt{P_*}}. \tag{3.13}
$$

Moreover,

$$
\sqrt{Q_*}+r\sqrt{P_*}< (1-r^2w)+r(1-w)=(1+r)(1-rw).
$$

This is the sum of the two Cauchy inequalities
$\sqrt{(1-b^2u^2)(1-b^2v^2)}\le1-b^2uv$, for $b=r,1$;
strictness follows from $u\ne v$. Since

$$
Q_*-r^2P_*=(1-r^2)(1+rw)(1-rw),
$$

we obtain $\sqrt{Q_*}-r\sqrt{P_*}>(1-r)(1+rw)$. Substitution into (3.13) gives exactly the upper bound in (3.10).

For the lower bound, $s\ge\mu$ is immediate because its left side is nonpositive and $\lambda>0$. If $s< \mu$, set

$$
t=\frac{u+v}{1+uv},\qquad t_r=\frac{r(u+v)}{1+r^2uv},\qquad 0< t_r< t< 1.
$$

The function $b(t)=\operatorname{atanh}(t)\sqrt{1-t^2}/t$ is strictly decreasing, because

$$
b'(t)=\frac{t-\operatorname{atanh}t}{t^2\sqrt{1-t^2}}< 0.
$$

The addition formula consequently gives $B_+>\mu A_+$. Also $B_+>r/(1+r^2w)$ by $\operatorname{atanh}t_r>t_r$. Thus (3.11) implies

$$
\lambda>\frac{r(1-s/\mu)}{(1-r)(1+r^2w)}. \tag{3.14}
$$

Finally $t_r< t$ implies

$$
\frac{\sqrt{P_*}}{1+w}< \frac{\sqrt{Q_*}}{1+r^2w},
\quad\text{so}\quad
\mu< \frac{r(1+w)}{1+r^2w}.
$$

Equivalently, $(1+r)(1+rw)>(1+\mu)(1+r^2w)$. Inserting this strict comparison into (3.14) proves the lower bound in (3.10). The determinant is positive and both diagonal entries are negative. $\square$

## 4. The origin, contacts, and diagonal stationary points

We now fix the target parameters (2.2). The function

$$
s_r(a)=r\operatorname{atanh}(ra)/\operatorname{atanh}a
$$

is continuous and strictly decreasing from $r^2$ to $0$ as $a$ increases from $0$ to $1$. Indeed, the derivative ratio of the numerator atanh term to the denominator atanh term is
$r(1-a^2)/(1-r^2a^2)$, a strictly decreasing function. Their ratio is its positive weighted average over $(0,a)$, and is therefore strictly decreasing. In particular $0< s< r^2$.

### 4.1. The origin and the four contacts

The support parameter satisfies

$$
\frac{r+s}{1+r}< \kappa_0< \frac{r-s}{1-r}. \tag{4.1}
$$

For the first inequality use $\kappa_0>r$ and $s< r^2$. To prove the second, the function $d(t)=1/\operatorname{atanh}t-1/t$ has negative derivative on $(0,1)$ by (3.12). Therefore $d(ra)>d(a)$. Rearrangement, with $s=r\operatorname{atanh}(ra)/\operatorname{atanh}a$, gives the second inequality in (4.1).

At the origin the Hessian has diagonal entries $r^2-s$ and off-diagonal entry $r(1-s)-(1-r^2)\kappa_0$. Inequalities (4.1) say exactly that the absolute off-diagonal entry is smaller than $r^2-s$. The origin is a nondegenerate strict local minimum.

At $(a,0)$, the identities $s\operatorname{atanh}a=r\operatorname{atanh}(ra)$ and $a\kappa_0=\operatorname{atanh}(ra)$ verify (3.4) directly. The other three axis contacts follow by symmetry. Each is a strict nondegenerate local maximum by Lemma 3.2. At $(a,0)$ the $X$ entropy is $h((1-a)/2)$, the conditional entropy of $Y$ given $X$ is $h(p)$, and the $Y$ bias is $ra$. It follows that $\mathcal G_{s,\kappa_0}(a,0)=A$; the other contacts have the same value.

### 4.2. Exactly four nonzero diagonal stationary points

On $u=v=t>0$, stationarity is equivalent to $\phi_+(t)=\kappa_0$, where

$$
\phi_+(t)=\frac{(1-rt^2)[\operatorname{atanh}(rt)-s\operatorname{atanh}t]}{(1-r)t}.
$$

On $u=t,v=-t$, it is equivalent to $\phi_-(t)=\kappa_0$, where

$$
\phi_-(t)=\frac{(1+rt^2)[\operatorname{atanh}(rt)+s\operatorname{atanh}t]}{(1+r)t}. \tag{4.2}
$$

The latter is strictly increasing, because its power series has strictly positive nonconstant coefficients. It increases from $(r+s)/(1+r)< \kappa_0$ to $+\infty$.

We next prove that $\phi_+$ is strictly decreasing. Before division by $1-r$, the coefficient of $t^{2n}$, for $n\ge1$, is

$$
c_n(s)=\frac{r^{2n+1}-s}{2n+1}-r\frac{r^{2n-1}-s}{2n-1}. \tag{4.3}
$$

It is linear in $s$. At $s=0$ it is strictly negative. At $s=r^2$, the case $n=1$ is strictly negative as well. For $n\ge2$, put $m=2n-1\ge3$. After removing the positive factor $r^2/((2n-1)(2n+1))$, its numerator is

$$
(m+2)(r-r^{m-1})-m(1-r^m).
$$

Write $r=\exp(-2z)$ with $z>0$. Then

$$
\frac{r-r^{m-1}}{1-r^m}
=\frac{\sinh((m-2)z)}{\sinh(mz)}< \frac{m-2}{m},
$$

because $\sinh x/x$ is strictly increasing for $x>0$. The numerator is strictly negative since $(m+2)(m-2)/m-m=-4/m< 0$. Thus every $c_n(s)$ is negative for $0< s< r^2$. Termwise differentiation on compact subintervals proves strict decrease of $\phi_+$. Its endpoint values are $(r-s)/(1-r)>\kappa_0$ and $-\infty$.

There is consequently one positive root on each of the two diagonals and, by simultaneous sign reversal, one corresponding negative root on each. Apart from the origin, these are exactly four diagonal stationary points. Their second derivatives along their respective diagonals are strictly negative, as is seen from

$$
\frac{d}{dt}\mathcal G(t,t)
=\frac{2(1-r^2)t}{(1+rt^2)^2}[\phi_+(t)-\kappa_0],
$$
$$
\frac{d}{dt}\mathcal G(t,-t)
=\frac{2(1-r^2)t}{(1-rt^2)^2}[\kappa_0-\phi_-(t)]. \tag{4.4}
$$

The proof below does not assume their transverse second derivatives are nonzero.

## 5. Global exclusion of further maxima

### 5.1. Boundary control and isolation

The continuous function $\mathcal G$ attains a maximum on $[-1,1]^2$. No point on the boundary is a local maximum. To see this, at $u=1$ and $|v|< 1$, move into the square by mixing a small mass $\varepsilon$ into the previously absent $X$ row, keeping the conditional distributions of $Y$ given $X$ fixed. These two conditional distributions have full support. The joint entropy increases by $h(\varepsilon)+O(\varepsilon)$, the $X$ entropy by $h(\varepsilon)$, and the $Y$ entropy by $O(\varepsilon)$. The correlation term changes by $O(\varepsilon)$. Thus the increase in $\mathcal G$ is $s h(\varepsilon)+O(\varepsilon)>0$. This row mixture is obtained by varying $u$ in (2.1). The other open edges are symmetric. At a corner, keep one spin deterministic and vary the other; the same conclusion follows from $F_s=sH$ for the remaining random spin and an affine correlation term.

All stationary points are contained in a compact square strictly inside $(-1,1)^2$. Indeed, as $u\uparrow1$, (3.2) gives the uniform bound

$$
E_1\le-s(1-r^2)\operatorname{atanh}u+B(r,s,\kappa_0), \tag{5.1}
$$

where the finite constant bounds the other terms. The bound is uniform in $v$: $\operatorname{atanh}(rv)$ and $\operatorname{atanh}(ru)$ are bounded by $J$, and $(1-v^2)\operatorname{atanh}v$ is bounded on the open interval and tends to zero at its endpoints. Consequently the gradient points strictly inward on the four sides of $[-b,b]^2$ for some $b< 1$, and no stationary point lies in the omitted edge strips.

The objective is real analytic in the open square because all joint and marginal probabilities there are strictly positive. Every non-diagonal stationary point is isolated by Lemma 3.2, and the origin is isolated by its positive definite Hessian. Each of the four nonzero diagonal points is also isolated, including the possibility of transverse degeneracy. Use local orthonormal coordinates $(t,w)$ tangent and normal to its diagonal, centered at the point. By (4.4), $\mathcal G_{tt}(0,0)=\ell< 0$. The real analytic implicit-function theorem solves $\mathcal G_t=0$ uniquely as $t=\varphi(w)$. The remaining equation is the one-variable analytic equation

$$
q(w)=\mathcal G_w(\varphi(w),w)=0.
$$

If $q$ vanished identically near zero, it would produce a curve of stationary points containing points off the two diagonals. Differentiation along that curve would give a nonzero null vector for their Hessians, contradicting Lemma 3.2. Hence $q$ is not identically zero, and its zero at the origin is isolated. Compactness now implies that the total number of stationary points is finite: an infinite set would accumulate at a stationary point and contradict its isolation.

### 5.2. The planar index calculation

We give the needed index argument explicitly to include possible degenerate diagonal points. For a smooth planar vector field with an isolated zero, its local index is the winding number of the field on a sufficiently small positively oriented loop around that zero. A nondegenerate zero has index equal to the sign of its Jacobian determinant. The sum of local indices inside a region equals the winding number on the outer boundary. One direct proof removes disjoint small disks around the zeros and applies Stokes' theorem to the closed one-form

$$
\frac{V_1\,dV_2-V_2\,dV_1}{V_1^2+V_2^2}
$$

on the region where the vector field $V$ is nonzero; its integrals divided by $2\pi$ are the corresponding winding numbers. Corners on the outer square can be rounded inside the nonvanishing boundary collar. For a field pointing strictly inward on that square, interpolation with the field $-(u,v)$ stays nonzero on the boundary, so its winding number is $+1$.

Apply this to $V=\nabla\mathcal G$. The origin and the four axis contacts each have index $+1$. Every additional non-diagonal stationary point would have index $+1$ by Lemma 3.2. Each nonzero diagonal stationary point has index at least $-1$. To check this last assertion without a nondegeneracy assumption, use the coordinates of Section 5.1 and let $\xi=t-\varphi(w)$. The gradient components have the exact form

$$
(\xi A(\xi,w),\ q(w)+\xi B(\xi,w)),\qquad A(0,0)=\ell< 0.
$$

In a small neighborhood $A$ remains negative. A zero-preserving homotopy changes this field to $(\ell\xi,q(w))$: interpolate $A$ to $\ell$ and $B$ to zero. There is no boundary zero because a zero of its first component requires $\xi=0$, and then its second component is $q(w)$, whose only sufficiently small zero is $w=0$. The coordinate change has positive Jacobian determinant. The local index is therefore

$$
\operatorname{sign}(\ell)\,\frac{\operatorname{sign}q(\varepsilon)-\operatorname{sign}q(-\varepsilon)}2
\in\{-1,0,1\}. \tag{5.2}
$$

Let $N$ be the number of additional non-diagonal stationary points and let $i_1,\ldots,i_4$ be the indices of the four nonzero diagonal points. The boundary winding number and the preceding bounds give

$$
1=5+N+\sum_{j=1}^4i_j\ge5+N-4=1+N.
$$

It follows that $N=0$ and that all four diagonal indices equal $-1$. These points cannot be local maxima. Indeed, by (5.2) and $\ell< 0$, their reduced derivative $q$ is negative to the left and positive to the right. Along $t=\varphi(w)$, the reduced function has derivative $q(w)$ and hence a strict local minimum; along the tangent direction it has a strict local maximum. They are saddles, even if a transverse second derivative vanishes.

Every global maximum is interior, and the only remaining stationary points are the four axis contacts and the origin. The origin is a strict minimum. Therefore the four contacts are exactly the global maxima, each with value $A$. This proves Theorem 2.1, including its equality statement. The argument also classifies all interior stationary points: one minimum, four maxima, and four saddles; only the minimum and maxima require a nondegeneracy assertion here.

## 6. From global support to the complete communication boundary

### 6.1. Alternating posteriors and a correlation martingale

We use Theorem 1 of [1] with finite auxiliary random variables $U_1,\ldots,U_m$ satisfying

$$
U_i-(X,U_{< i})-Y\quad(i\ \text{odd}),\qquad
U_i-(Y,U_{< i})-X\quad(i\ \text{even}). \tag{6.1}
$$

Every positive-probability transcript posterior is a row and column tilt of $Q_r$. This follows inductively from Bayes' rule: each odd message multiplies its density by a nonnegative function of $X$, and each even message by one of $Y$. Any nonzero nonnegative function on a binary alphabet is a positive scalar times $1+ux$ for some $u\in[-1,1]$. Thus all such posteriors have the form (2.1), including those with deterministic marginals.

The support in (2.3) is affine in the correlation moment. The law of total expectation therefore gives

$$
\mathbb E\chi(P_{XY\mid U^m})
=A-M\bigl(\mathbb E[XY]-r\bigr)=A.
$$

Theorem 2.1 implies

$$
\mathbb E F_s(P_{XY\mid U^m})\le A. \tag{6.2}
$$

Define the canonical auxiliary information rates

$$
S_U=\sum_{i\text{ odd}}I(U_i;X\mid U_{< i})
 +\sum_{i\text{ even}}I(U_i;Y\mid U_{< i}),
$$
$$
K_U=\sum_{i\text{ odd}}I(U_i;Y\mid U_{< i})
 +\sum_{i\text{ even}}I(U_i;X\mid U_{< i}),\qquad C_U=S_U-K_U.
$$

The Markov conditions imply the telescoping identities

$$
S_U=H_{Q_r}(X,Y)-H(X,Y\mid U^m),\qquad
K_U=I_{Q_r}(X;Y)-I(X;Y\mid U^m). \tag{6.3}
$$

For the first, the conditional information about $(X,Y)$ in each message equals its information about its sender's observation. For the second, the conditional change of $I(X;Y)$ equals the information that the receiver's observation supplies about that message; the other conditional term vanishes by (6.1). Summing proves (6.3).

Combining (6.2)--(6.3) gives

$$
K_U-sS_U\le e(ra)-s e(a). \tag{6.4}
$$

The rate characterization in [1] has $K\le K_U$ and $C\ge C_U$. Since $0< s< 1$, it follows directly that

$$
(1-s)K-sC\le e(ra)-s e(a),
\quad\text{or}\quad
K-\frac{s}{1-s}C\le\frac{e(ra)-s e(a)}{1-s}. \tag{6.5}
$$

This step uses the two monotone budget inequalities, rather than identifying an arbitrary budget pair with the canonical $S_U$. In particular it remains valid when a scheme discards some of its available key.

### 6.2. Attainment, supporting slopes, and closure

In the bit representation, the one-way auxiliary $U=X\oplus B$, with $B\sim\operatorname{Bernoulli}(q)$ independent and $a=1-2q$, attains the canonical rates

$$
S(a)=e(a),\quad K(a)=e(ra),\quad C(a)=e(a)-e(ra). \tag{6.6}
$$

This is the one-round specialization of the achievability theorem in [1]. Its two posteriors are the contact laws $P_{a,0}$ and $P_{-a,0}$, each with probability $1/2$, so every inequality in (6.5) is tight at (6.6).

Furthermore,

$$
C'(a)=\operatorname{atanh}a-r\operatorname{atanh}(ra)>0,
\qquad
\frac{dK}{dC}=\frac{s_r(a)}{1-s_r(a)}. \tag{6.7}
$$

Section 4 shows that this slope is strictly decreasing and covers $(0,r^2/(1-r^2))$. Thus (6.6) is a strictly concave upper boundary between $(0,0)$ and $(h(p),\log2-h(p))$. For each interior budget, choosing its unique $a$ in (6.5) bounds every interactive rate by this boundary. Nonnegative points below it are obtained by reducing the key rate. For larger budgets, the bound $K\le I_{Q_r}(X;Y)=\log2-h(p)$ follows from (6.3), and the endpoint is already one-way achievable. This proves (2.6).

All the support constraints are closed half-spaces and hence persist under taking closures. Definition 2 and Theorem 1 of [1] identify the arbitrary-finite-round region with the closure of the union of the fixed finite-round regions. Their convention permits the finite round bound of a block code to grow with block length: Appendix B, Theorem 10, provides a finite-block converse whose error vector in equation (209) is independent of the number of rounds. We use precisely this convention, with a finite deterministic round bound for each block; no claim is made for a single block with unbounded random stopping or infinitely many actual messages.

### 6.3. Limiting and degenerate parameters

For fixed $0< r< 1$, the support formulas extend continuously to $a=0$ and $a=1$, uniformly as functions on the compact tilt square. At $a\uparrow1$, $s\to0$, $A\to0$, and $M\to0$, so the entropy inequality becomes $-I(P)\le0$. This is the maximum-key endpoint. At $a\downarrow0$, $s\to r^2$ and $e(ra)-s e(a)\to0$; equation (6.5) gives the origin support $(1-r^2)K\le r^2C$. These endpoint support statements are not substitutes for the intermediate-slope proof.

If $p=1/2$, the source is independent and the capacity bound gives $K=0$ at every budget. If $p=0$, the terminals already share the same uniform bit, so $K=\log2$ is achievable with zero communication and is maximal. This case is handled separately rather than dividing by $1-s$ at $s=1$. A flip of $Y$ treats $p>1/2$, including the fully complementary endpoint $p=1$. To express the rates in bits, divide every displayed entropy and rate by $\log2$.

## 7. Scope of the result

The global pointwise inequality and its exact interior equality set are the new mathematical results. The single-letter operational characterization, the one-way test channel, the candidate support, and the endpoint mechanisms are prior results, used with attribution. The global proof does not rely on a numerical grid, an expansion at high noise, or an assumed equality between independent coding and arbitrary interaction. It applies to the binary symmetric source and the transcript-only eavesdropper model specified in Section 1. Asymmetric binary sources, extra eavesdropper side information, and separately fixed directional-rate regions are not determined by Theorem 2.2.

## References

[1] J. Liu, P. Cuff, and S. Verdú. *Secret Key Generation with Limited Interaction*. IEEE Transactions on Information Theory **63**(11), 7358--7381, 2017. DOI: [10.1109/TIT.2017.2746104](https://doi.org/10.1109/TIT.2017.2746104). Author manuscript: [arXiv:1601.00899v3](https://arxiv.org/abs/1601.00899v3). Relevant locations: Theorem 1; Definition 2; Section VI, Conjecture 1; Appendix F, Conjecture 2; Appendix B, Theorem 10.

[2] H. Tyagi. *Common Information and Secret Key Capacity*. IEEE Transactions on Information Theory **59**(9), 5627--5640, 2013. DOI: [10.1109/TIT.2013.2264355](https://doi.org/10.1109/TIT.2013.2264355). Author manuscript: [arXiv:1304.2444](https://arxiv.org/abs/1304.2444).

[3] Q. Guo. *A Sharp Mutual Information Bound for Binary Pairs*. [arXiv:2611.02392v1](https://arxiv.org/abs/2611.02392v1), 2026. Relevant location: Theorem 2.1 and the concluding discussion of unequal directed contraction constraints.

[4] G. Pichler. *Three Conjectures on Binary Channels for the Doubly Symmetric Binary Source*. [arXiv:2609.27991v1](https://arxiv.org/abs/2609.27991v1), 2026. Relevant locations: Theorems 3.1 and 3.4, for independent attached channels.
