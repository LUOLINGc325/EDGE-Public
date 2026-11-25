---
title: "Supplement: Every one-dimensional log-concave target density"
lang: en
date: "24 November 2026"
---

This supplement gives a canonical contact interval even with affine tails, corners, a Cantor part in the curvature measure, jumps of the density at the edge of its support, and bounded support. The smooth theorem in the main manuscript gives the cubic onset for strictly convex, twice continuously differentiable potentials.

## Statement

Let $q$ be a nondegenerate log-concave probability density on the line. Set $I=(u,v)$ equal to the interior of its support. Use the representative that is positive and continuous on $I$ and zero outside $I$, including any finite endpoints. Its values at individual endpoints do not affect the objective. Let $V=-\log q$ on $I$, a finite convex function, and $h=\sqrt q$. Fix $a>0$ and $K(x)=(a/2)e^{-a|x|}$. The admissible controls are all Borel probability measures $m$, with $p_m=K*m$ and $F(m)=\int q/p_m\in(0,\infty]$.

For $x\in I$, define
$$
H_\pm(x)=\frac{a}{q(x)}\int_0^\infty e^{at}q(x\pm t)\,dt,\qquad
S=\{x\in I:H_-(x)>1,\ H_+(x)>1\}.                                      \tag{1}
$$
A divergent integral is infinity. Then $S$ is an open interval, possibly empty.

* If $S$ is empty, both tilted moments $\int e^{\pm ax}q(x)\,dx$ are finite. The unique $b\in I$ with $H_-(b)=H_+(b)=A$ has $A\le1$. The unique optimizer is $\delta_b$, of value $4q(b)A/a^2$.
* If $S=(L,R)$ is nonempty, each finite endpoint lies strictly inside $I$ and satisfies $H_-(L)=1$ or $H_+(R)=1$ respectively. Put
$$
M=\int_L^R h(x)\,dx+\frac{h(L)}a\,{\bf1}_{L>-\infty}
                     +\frac{h(R)}a\,{\bf1}_{R<\infty},\qquad c=M^{-1}
$$
with infinite-endpoint terms omitted. The unique optimal search density $p_*$ equals $ch$ on $S$. At a finite left boundary continue it by $ch(L)e^{a(x-L)}$, and at a finite right boundary continue it by $ch(R)e^{-a(x-R)}$. The objective value is $M^2$. The unique reset law has restriction to $S$
$$
m_*|_S
 = ch(x)\left(1-\frac{V'(x)^2}{4a^2}\right)dx+
   \frac{ch(x)}{2a^2}\,D^2 V(dx),                                       \tag{2}
$$
where $V'$ denotes its almost-everywhere derivative and $D^2V$ is its distributional positive curvature measure. It also has possible endpoint atoms
$$
m_*(\{L\})=\frac{ch(L)}{a^2}\left(a+\frac{V'_+(L)}2\right),\qquad
m_*(\{R\})=\frac{ch(R)}{a^2}\left(a-\frac{V'_-(R)}2\right).               \tag{3}
$$
Only include finite-endpoint formulas. The one-sided derivatives in (3) are from the interior of $S$. The reset measure is zero elsewhere. Its support is $\overline S$ in $\mathbb R$, and $\overline S\subset I$. The absolutely continuous term displayed first in (2) is positive almost everywhere on $S$. Finite endpoints can have zero mass on exactly matched affine tails. Affine critical tails can have dual contact outside this canonical *support* interval.

Whenever both tilted moments are finite, the balanced $b$ exists uniquely and is the unique minimum over single sites. $S\ne\varnothing$ is equivalent to $A>1$. If either moment is infinite, $S\ne\varnothing$ and every single-site risk is infinite.

## Proof

**Regularity and localization.** An integrable log-concave density is bounded and has at least exponential decrease along each unbounded end. For the bounded part of the claim, a supergradient of the finite concave $\log q$ at any interior point bounds it from above on compact distances, including finite ends. On any infinite right tail pick two interior points $x<y$ with $q(y)<q(x)$, which exist by integrability. Concavity bounds $\log q$ beyond $y$ by the strictly descending affine continuation of the secant from $x$ to $y$. Reflect for the left tail. Thus $h$ is bounded and integrable.

The right ratio is nonincreasing and the left ratio nondecreasing in $x$ by monotonicity of convex increments. Setting the density to zero after the end of the support preserves the corresponding inequality for the right integrand as its argument moves right, and likewise on the left. Each ratio is either identically infinite or finite and continuous throughout $I$. For example
$$
H_+(x)=a\, e^{-ax}q(x)^{-1}\int_x^\infty e^{ay}q(y)\,dy.
$$
The integral changes by a finite continuous function between interior limits. Thus $S$ is an open interval. If $v$ is finite, $H_+(x)\to0$ as $x\uparrow v$. Indeed, for any $x_0<x<v$, choose a subgradient $d$ of $V$ at $x_0$. For $x+t<v$, $V(x+t)-V(x)\ge dt$, so $H_+(x)\le a\int_0^{v-x}e^{(a-d)t}\,dt\to0$. The reflected statement applies at finite $u$. Hence a nonempty $S$ never reaches a finite target support edge. At any finite $R=\sup S$, $H_-(R)>1$ because $H_-$ is nondecreasing and exceeds one somewhere to the left. Continuity of the finite $H_+$, or openness if it had been identically infinite, forces $H_+(R)=1$. The same proof gives $H_-(L)=1$ for finite $L$.

If the right tilt is infinite then $v=\infty$, $H_+\equiv\infty$, and $H_-(x)>1$ at some sufficiently large $x$. In fact if $H_-$ is finite its expression $ae^{ax}q(x)^{-1}\int_{-\infty}^x e^{-ay}q(y)\,dy$ tends to infinity by bounding the last integral below on a fixed positive-mass compact interval. The case that $H_-\equiv\infty$ is immediate. Thus $S\ne\varnothing$; reflect for the other direction. In that situation every deterministic site has infinite objective by the infinite tilted tail.

If both tilted moments are finite, $J(z)=\int q(y)e^{a|y-z|}dy$ is strictly convex, differentiable and coercive. Strict convexity follows by integrating strict convexity in $z$ for each $y$. The derivative follows by dominated differentiation (the point $y=z$ is null), and coercivity by restricting to a bounded interval of positive target mass. The minimizer $b$ lies in $I$ since the derivative has strict outward signs at finite endpoints and outside the support. In the interior $J'(z)=q(z)(H_-(z)-H_+(z))$; hence $b$ is the unique balance. If $S$ is empty there cannot be $A>1$. If $S$ contains $x$, then $x\ge b$ implies $A=H_+(b)\ge H_+(x)>1$, and $x\le b$ implies $A=H_-(b)\ge H_-(x)>1$. Conversely $A>1$ implies $b\in S$.

**Measure inversion.** Suppose $S\ne\varnothing$. For $x\in S$, if $V'_+(x)\ge2a$, then convexity and any finite target support edge give $H_+(x)\le a\int_0^\infty e^{-at}dt=1$, impossible. Reflection similarly excludes $V'_-(x)\le-2a$. Thus
$$
-2a<V'_-(x)\le V'_+(x)<2a\qquad(x\in S).                         \tag{4}
$$
The endpoint limits from $S$ of these derivatives give the weak matching slope bounds in (3). The distribution identity in the interior is
$$
D^2h=\frac14h(V')^2\,dx-\frac12h\,D^2V.                            \tag{5}
$$
Indeed $h$ is locally absolutely continuous with derivative $-hV'/2$ almost everywhere. Local derivatives of the convex $V$ are of bounded variation. The product rule for an absolutely continuous continuous multiplier and a function of bounded variation gives $D(hV')=hD^2V+h'V'\,dx$, which is (5). Curvature on $S$ has total at most $4a$ by (4). Both terms in (5) are finite in total variation over $S$, by boundedness and integrability of $h$. The tails of $p_*'$ vanish, using bounded active slopes on any infinite side. Hence $m_*=(1-a^{-2}D^2)p_*$ is given by (2), (3), is nonnegative, and has mass $\int p_*=1$, since the integrated second derivative including the derivative jumps is zero. Its first term in (2) has positive density almost everywhere on $S$, so the support is precisely $\overline S$. The Laplace kernel is the Green function of $1-a^{-2}D^2$. Thus $K*m_*=p_*$, as the difference is an integrable solution of $f''=a^2 f$. In particular $m_*(I)=1$.

**Certificate without strict tail inequalities.** On a finite right exterior put $B(t)=e^{2at}q(R+t)/q(R)$ for $t\ge0$; reflect on the left. This function is log-concave with $B(0)=1$, and $a\int_0^\infty e^{-at}B(t)\,dt=1$. For any nonnegative log-concave $B$ from these tails or a balanced point site, if $B(0)\ge C>0$ and $a\int_0^\infty e^{-at}B(t)\,dt=C$, the set where $B\ge C$ is an interval containing zero. Therefore one has the weak sign pattern $B-C\ge0$ up to a boundary and $B-C\le0$ afterward, with equalities allowed and no need for a crossing point of exact equality if the density jumps to zero. If the superlevel interval is all of the half-line, equality of the average forces $B=C$ almost everywhere. In all cases $B$ is bounded: if the threshold cut is finite, boundedness on a finite range follows from global boundedness of $q$ and the finite exponential factor, and thereafter $B\le C$; if the cut is infinite use the average equality just noted. For every $t\ge0$,
$$
\int_t^\infty e^{-au}(B(u)-C)\,du\le0.                             \tag{6}
$$
Before the cut this is minus a nonnegative head integral; after the cut the integrand is nonpositive. This includes the case of a critical affine exterior, where $B$ is identically constant.

For a distributed candidate write $\lambda=c^{-2}$, $w=q/p_*^2$, $G=K*w$. The function $w/\lambda$ equals one on $S$ and equals the corresponding $B$ on each finite exterior. The weighted tail equalities and the Laplace product on each separated half-line give $G=\lambda$ on $\overline S$. In particular $F_*=\int G\,dm_*=\lambda$. In the point case write $\lambda=4q(b)/a^2$, $B_\pm(t)=e^{2at}q(b\pm t)/q(b)$. Now $C=A\le 1=B_\pm(0)$ and the balanced halves both have weighted average $A$. Their sum gives $G(b)=\lambda A=F_*$. On every exterior half-line in either case, set $W(t)=G(z_0\pm t)/\lambda$, so $W(0)=C$, and differentiate the split integrals of the bounded $w$ to obtain
$$
(W-C)'(t)+a(W(t)-C)=a^2e^{at}\int_t^\infty e^{-au}(B(u)-C)\,du\le0.
$$
It suffices that this hold almost everywhere (indeed the convolved function is continuously differentiable). Multiply by $e^{at}$ and integrate: $W(t)\le C$ for $t\ge0$. Thus $G\le F_*$. The identity
$$
F(n)-F_*=
\int(F_*-G)\,dn+
\int \frac{q(x)(p_n(x)-p_*(x))^2}{p_n(x)p_*(x)^2}\,dx
$$
holds for every probability $n$, including $F(n)=\infty$, because $w$ is bounded and the linear integrals are finite. Equality forces $p_n=p_*$ almost everywhere on $I$, hence throughout $I$ by continuity. Apply $1-a^{-2}D^2$ there to get $n|_I=m_*|_I$. Since $m_*(I)=1$ and $n$ is a probability measure, the equality holds on the whole line. This proves uniqueness even if $q$ vanishes on one or both exterior rays.

**Finite boundary atoms.** If at a finite right contact the target has finite right support or an infinite tail that is not exactly $q(R+t)=q(R)e^{-2at}$ for all $t\ge0$, then $V'_+(R)<2a$. Otherwise the tangent inequality would give $B(t)\le1$ everywhere, strictly on a positive-measure set in the stated case; this contradicts its weighted mean one. Thus $V'_-(R)\le V'_+(R)<2a$ and the right atom is strictly positive. On an exactly critical affine remainder, (3) gives zero or positive mass according only to its interior one-sided slope. Reflect for the left. The choices $L=\inf S,R=\sup S$ prevent any ambiguity if $H_\pm=1$ all along a ray.

## Rate threshold without strict smoothness

Set the outward slope $s_\pm=\infty$ at a finite support edge. At an unbounded edge let $s_\pm\in(0,\infty]$ be the limit of the outward one-sided derivatives of $V$. The tilted moments are finite precisely for $a<s_\pm$ on that side. At a finite slope $s$, convexity gives $V(x+t)-V(x)\le st$ outward, so $e^{ay}q(y)$ (or its reflection) is nonintegrable for $a\ge s$. For $a<s$ an outward tangent with slope $>a$ gives integrability.

There is a unique $a_c>0$ with an optimal point for $a\le a_c$ and nonempty $S$ for $a>a_c$. If $s_{\min}=\min(s_-,s_+)<\infty$, then $a_c\le s_{\min}/2$; equality can occur. To see this, for $0<a<s_{\min}$ the balanced point $b(a)$ is continuous. The strict derivative signs of the continuous $J'$ bracket $b$, and joint continuity in position and scale follows by dominated integration on compact scale subintervals. The balanced value satisfies
$$
A(a)=\max_{x\in I}\min(H_-(x;a),H_+(x;a)).
$$
Indeed to the left of $b$ the minimum is bounded by $H_-(b)$, and to its right by $H_+(b)$. The maximum is attained at $b$. The value $A$ is continuous by evaluation at $b(a)$, and strictly increases with $a$: evaluate both strictly increasing finite ratios at the former balance site. As $a\downarrow0$, the sign of $J'(z)/a$ tends to the sign of $2\int_{-\infty}^zq-1$ at every fixed nonmedian $z$, by dominated convergence. Bracket $b(a)$ on either side of the unique median, an interior point. Therefore $b(a)$ tends to this median, and (1) gives $A(a)\to0$ by uniform tail domination and the explicit factor $a$. When $s_{\min}<\infty$, for $s_{\min}/2<a<s_{\min}$, the ratio for the side with slope $s_{\min}$ is bounded below everywhere by $a/(s_{\min}-a)>1$ using the convex upper secant bound $V(x\pm t)-V(x)\le s_{\min}t$. In particular $A(a)>1$. If both slopes are infinite, for each fixed $x\in I$ both ratios tend to infinity as $a\to\infty$, by restricting each integral to a positive-length interior subinterval away from zero. Thus the unique $A(a_c)=1$ gives the threshold, and once a tilted moment diverges $S$ stays nonempty. The stricter upper threshold in the smooth strictly convex case follows from the non-affine outward increments there.

## Exact checks and a singular example

1. The uniform target on $(0,1)$ has $H_-(x)=e^{ax}-1$, $H_+(x)=e^{a(1-x)}-1$, hence $b=1/2$, $a_c=2\log2$. Above this value the optimizer consists of a uniform density $c$ on $(\log2/a,1-\log2/a)$ and equal endpoint atoms $c/a$, where $c^{-1}=1-2\log2/a+2/a$. At/below this value it is $\delta_{1/2}$.
2. For $q(x)=a e^{-2a|x|}$, the root equations equal one on outward affine rays, while $S$ is empty. The unique optimizer is the single site at zero, and its produced $p_*=K$ coincides with normalized $\sqrt q$. The dual certificate is constant on the entire line. The reciprocal remainder proves uniqueness even when the exterior certificate is an equality. This matches the critical double-exponential example in Evans–Majumdar.

## An equivalent relaxation to all densities with Lipschitz logarithm

The same $p_*$ uniquely minimizes $F(p)=\int q/p$ over the larger set of all strictly positive probability densities $p$ with $|\log p(x)-\log p(y)|\le a|x-y|$. In fact, every Laplace location mixture satisfies $p(x)\ge e^{-a|x-y|}p(y)$ by the triangle inequality for its kernel. Conversely the constructed $p_*$ belongs to the smaller mixture class, as proved above.

For a direct proof, on an exterior ray starting at the corresponding support endpoint $z$ (or at the atom $b$), let $U(t)=w(z\pm t)-F_*$, where $w=q/p_*^2$. The matched construction gives $\int_0^\infty e^{-at}U(t)dt=0$. Log-concavity gives a cut $t_0$ with $U(t)\ge0$ before and $U(t)\le0$ after it; a degenerate infinite cut means $U=0$ almost everywhere. For any admissible $p$, $\rho(t)=e^{at}p(z\pm t)$ is nondecreasing by its logarithmic slope bound. Subtract the constant $\rho(t_0)$ at a finite cut:
$$
\int_0^\infty U(t)p(z\pm t)dt
 =\int_0^\infty e^{-at}U(t)(\rho(t)-\rho(t_0))dt\le0.
$$
This holds even for unbounded $\rho$, since $U$ is bounded, $p$ integrates to one and $e^{-at}U$ is integrable. On an infinite-cut ray with $U=0$ the conclusion is immediate. Active interior points satisfy $U=0$. Therefore $\int wp\le F_*$; the positive reciprocal remainder proves optimality. If equality holds, the positive target density on the open interval $I$ forces $p=p_*$ there. At any finite target support edge these continuous densities agree. Beyond such an edge, $p_*$ has exactly its exponential continuation; the logarithmic Lipschitz constraint forces $p\ge p_*$ everywhere off $I$. Equal mass forces equality everywhere. This compares the reset stationary profile to an entire class of densities that includes non-mixtures. For example, $p(x)\propto e^{-a|x|/2+(a/(4n))\cos(nx)}$ has logarithm $a$-Lipschitz, and for sufficiently large integer $n$, at regular minima of the cosine on $x>0$ its $p''/p$ exceeds $a^2$; hence its inverse $p-a^{-2}p''$ is negative on an interval and it is not a Laplace mixture.

3. A positive, continuously differentiable target can give a reset law with all three Lebesgue components. Let $C$ be the Cantor distribution function, extended by zero to the left of $0$ and by one to the right of $1$. Take $V(x)=x^2/2+\tfrac14\int_0^x C(u)\,du$, $q\propto e^{-V}$ and $a=3$. On $0<t<1/3$, the integrands without the prefactor $3$ in $H_-(0)$ and $H_+(1)$ are $e^{3t-t^2/2}$ and $e^{(3-5/4)t-t^2/2}$. Both exceed one, so the ratios exceed one by restricting the integrals to this range. Monotonicity places $[0,1]$ in $S$. The quadratic growth gives finite endpoints and both atoms are positive. Since $D^2V=dx+\tfrac14\,dC$, (2) gives the nonzero singular continuous component $(ch/72)\,dC$ as well as a positive density.

## References

1. M. R. Evans and S. N. Majumdar, *Diffusion with optimal resetting*, J. Phys. A **44**, 435001 (2011), §5.1. [DOI](https://doi.org/10.1088/1751-8113/44/43/435001)
