# Sharp normalization and stability for one-sided tensorization of information divergences

**Complete research manuscript, 25 November 2026.** This continuation includes the earlier normalization-rigidity result and its full proofs. This manuscript presents written mathematical proofs. It has not undergone external peer review or Lean verification.

## Abstract

We study sharp quadratic composition inequalities for smooth f-divergences and their logarithmic affinity transforms. A twice-compensated two-variable kernel gives a necessary and sufficient condition for an inequality over all independent finite probability experiments. Its pointwise supremum and infimum are exactly the optimal upper and lower quadratic tensorization coefficients; strict obstructions have positive, finite, binary witnesses. For an arbitrary Borel probability distribution of power orders in the open unit interval, we determine the exact affine dilution required for logarithmic subadditivity: the maximum retained power-mixture mass is one minus the order variance divided by the product of its mean and complementary mean. Every admissible generator with a non-Dirac order mixture and positive retained mixture mass lies outside the previously used fourth-order differential certificate, and its tensor-power logarithmic evidence saturates. Within that differential class, we prove a complementary sharp stability theorem: a global integral-mass deficit bounds the all-scale oscillation of the logarithmic derivative with optimal constant one. A common curvature-measure component yields the same sharp total-variation bound; explicit smooth families prove optimality and disprove uniform multiplicative approximation on the whole half-line. The induced affinity bounds quantify approximation to a power on likelihood-ratio windows. We retain a self-contained proof that zero affine boundary terms and differentiability at normalization force a power under one-sided product tests, including the resulting negative answer to a fixed-version bounded-multiplier question. Known covariance inequalities, rare-atom functional-domination arguments, exact tensorization identities, and earlier differential certificates are explicitly credited. Two conference full-text comparisons remain unavailable; originality claims are restricted to the sources actually inspected.

## 1. Problem, contribution, and scope

For strictly positive finite probability vectors, use the convention
```math
D_d(P\Vert Q)=\sum_iQ_i d(P_i/Q_i),\qquad
A_f(P,Q)=\sum_iQ_i f(P_i/Q_i).
```
The likelihood ratio under Q is a positive finite random variable U with mean one. Conversely every such U defines a full-support finite experiment. Independent products of experiments correspond to UV.

The first problem is to determine the best constants in
```math
D_d(UV)\ \le\ D_d(U)+D_d(V)+\kappa D_d(U)D_d(V),
```
and in its reverse, without assuming an exact composition law. A nonnegative normalized affinity generator instead leads to
```math
\mathbb E f(UV)\ge\mathbb E f(U)\,\mathbb E f(V).\tag{1}
```
If all affinities are positive, (1) is precisely subadditivity of their negative logarithms. It is distinct from subadditivity of ordinary mutual f-information under conditionally independent observations.

The results are organized into four connected blocks.

| Block | Mathematical content | Increment over the earlier manuscript |
| --- | --- | --- |
| Optimal product coefficients | Complete pointwise criterion and optimal upper/lower constants for all smooth convex generators in the stated class; an unbounded KL-plus-Pearson example | Removes zero-endpoint assumptions and exact-composition requirements |
| Arbitrary power mixtures | Exact admissible parameter region, actual binary separating witnesses, failure of the older sufficient certificate, and bounded tensor-power evidence | Gives a closed-form classification of an infinite-dimensional family outside that certificate |
| Quantitative differential rigidity | Common scale component, optimal deficit-dependent derivative and total-variation bounds, smooth sharpness, and affinity approximation | Strengthens equality-only rigidity to sharp all-scale stability and identifies its necessary limitations |
| Preserved original target | Binary zero-boundary rigidity, exact mass-defect identity, bounded-multiplier obstruction, and exponent-expression comparison | Keeps every original mathematical conclusion and its full proof |

The coefficient criterion extends the functional-domination viewpoint of Sason and Verdú [9] to a compensated product residual. Rare binary atoms and affine normalization are established tools, not claimed inventions. Abin et al. [1] already reduce suitable product inequalities to binary alphabets and provide a fourth-order sufficient certificate. The exact tensorization classification of Cruz, Calmon, and Yu [3] assumes equality, whereas the present coefficient interval applies when no exact scalar composition law exists.

The power-mixture proof uses a sharp bounded-interval corollary of the covariance theorem of Bonnefont, Hillion, and Saumard [8]; the uniform-law 2/3 correlation constant is already in Csiszár and Móri [10]. The contribution is its conversion into a necessary and sufficient universal tensorization parameter, including finite binary necessity. Likewise, mixing powers and the logarithmic-mean shape already occur in Abin and Gohari [4] for another information functional. Section 9 specifies these distinctions and the unresolved source-access limits.

All probability experiments in the main coefficient and affinity theorems have finite support and strictly positive likelihood ratios. The order distribution in the mixture theorem may be finite, countable, or continuous, but is supported on the open interval (0,1). No general-alphabet extension without integrability hypotheses is asserted. The original open statement is kept at its exact arXiv version. No channel reliability function, optimal hypothesis-testing exponent, or external publication decision is claimed solved by these results.

## 2. Optimal quadratic tensorization coefficients

### Theorem C1. A complete criterion and sharp coefficients

Let $d:(0,\infty)\to\mathbb R$ be convex and continuously differentiable, with
$d(1)=d'(1)=0$ and a second derivative $d''(1)>0$ at one. These conditions imply
$d(x)>0$ for every $x\ne1$: it is positive in a punctured neighborhood of one by
the quadratic expansion, and convexity extends positivity away from that neighborhood.
For positive finite-valued mean-one likelihood ratios, write $D_d(U)=\mathbb E d(U)$.
For $x,y>0$ set

```math
R_d(x,y)=d(xy)-d(x)-d(y)
 -(x-1)y d'(y)-(y-1)x d'(x)
 +d''(1)(x-1)(y-1).
```

For a real $\kappa$, the following are equivalent:

1. For every independent positive finite-valued mean-one $U,V$,
   $D_d(UV)\le D_d(U)+D_d(V)+\kappa D_d(U)D_d(V)$.
2. The same assertion only for binary $U,V$.
3. $R_d(x,y)\le \kappa d(x)d(y)$ for all $x,y>0$.

All three equivalences also hold with all inequality signs reversed.
Consequently the best upper coefficient and the best lower coefficient are

```math
\kappa_{\mathrm{up}}(d)=\sup_{x,y>0,\ x,y\ne1}
 \frac{R_d(x,y)}{d(x)d(y)},\qquad
\kappa_{\mathrm{low}}(d)=\inf_{x,y>0,\ x,y\ne1}
 \frac{R_d(x,y)}{d(x)d(y)}.
```

Extended values are allowed. A finite supremum/infimum is admissible, even if
it is not attained by a finite pair. This is a sharp reduction of the
optimal finite-alphabet composition coefficient, not a claim that the remaining
two-variable optimization is trivial or has a closed form for every generator.

### Proof of Theorem C1

Sufficiency follows by taking expectations: all compensators in $R_d(U,V)$
have zero expectation by independence and the mean-one conditions. Thus
$\mathbb E R_d(U,V)=D_d(UV)-D_d(U)-D_d(V)$.

For necessity fix $x\ne1$, and let $U_t$ put mass $t$ at $x$ and mass $1-t$
at $(1-tx)/(1-t)$. For sufficiently small $t>0$ this is a positive binary
mean-one law. Differentiation at $t=0$ gives

```math
\left.\frac{d}{dt}E h(U_t)\right|_{0+}
=h(x)-h(1)-(x-1)h'(1).
```

Fix a binary mean-one $V$. The inequality is equality at $t=0$; its first
one-sided derivative yields

```math
E\{d(xV)-d(V)-(x-1)Vd'(V)-d(x)-\kappa d(x)d(V)\}\le0.
```

The function inside braces, called $H_x(V)$, is zero at $V=1$, and
$H_x'(1)=xd'(x)-(x-1)d''(1)$. Apply the same rare-atom construction to $V$
with rare value $y$. Dividing by its probability and taking the limit yields
$H_x(y)-(y-1)H_x'(1)\le 0$, precisely the pointwise condition. This uses
sequential limits and requires no mixed Taylor remainder away from one.
If $x=1$ or $y=1$, both sides are zero. The reversed version follows by the
same argument. The extremal coefficient formulas follow directly.

For any finite $x,y\ne1$, the normalized composition excess of these sequential
binary experiments converges to $R_d(x,y)/(d(x)d(y))$. Therefore a pointwise
strict obstruction yields an actual finite binary experiment that violates
the proposed coefficient, rather than only a singular limit experiment.

### Relation to the affinity kernel

If $f(1)=1$ is concave, its affine-normalized convex divergence is
$d(x)=1+f'(1)(x-1)-f(x)$. The product-affinity inequality is the quadratic
divergence inequality with coefficient $-1$. Direct substitution gives
$K_f(x,y)=-R_d(x,y)-d(x)d(y)$. The general affinity result remains valid
without strict curvature or concavity, by its separate direct proof.

### Corollary C2. Sharp coefficients for a KL-plus-Pearson generator

Let $a\ge0$, $b>0$,

```math
d(x)=a(x\log x-x+1)+b(x-1)^2.
```

The KL component has zero compensated kernel, while the Pearson component
has $R(x,y)=(x-1)^2(y-1)^2$. Consequently

```math
R_d(x,y)=b(x-1)^2(y-1)^2,
\qquad
\boxed{\kappa_{\mathrm{low}}=\frac{b}{(a+b)^2},\quad
\kappa_{\mathrm{up}}=\frac{1}{b}.}
```

To check the extrema, write $r(x)=(x \log x-x+1)/(x-1)^2$. For $x\ne1$,
$0 \lt r(x)<1$, because
$(x-1)^2-(x \log x-x+1)=x(x-1-\log x)>0$.
Moreover $r(x)\to 1$ at zero, $r(x)\to 0$ at infinity, and $r(x)\to 1/2$ at one.
The coefficient ratio is $b/[(a r(x)+b)(a r(y)+b)]$; its infimum and
supremum are the displayed constants. If $a=0$, both are $1/b$, the familiar
exact Pearson composition law. If $a>0$, the two coefficients differ,
so this example is outside an exact scalar quadratic composition identity.
For instance $a=b=1$ yields the optimal interval $[1/4,1]$.

## 3. An exact affinity kernel

### Theorem K1. Pointwise compensation

Let $f:(0,\infty)\to\mathbb R$ be continuously differentiable, twice differentiable
at 1, and satisfy $f(1)=1$. Write $p=f'(1)$ and $q=f''(1)$. Define

```math
\begin{aligned}
K_f(x,y)={}&f(xy)-f(x)f(y)\\
&-(x-1)\{y f'(y)-p f(y)\}\\
&-(y-1)\{x f'(x)-p f(x)\}\\
&+(x-1)(y-1)(p+q-p^2).
\end{aligned} \tag{K}
```

The following are equivalent:

1. $\mathbb E f(UV) \ge  \mathbb E f(U) \mathbb E f(V)$ for every independent, positive,
   finite-valued, mean-one $U,V$.
2. The same property for every such pair of binary random variables.
3. $K_f(x,y)\ge 0$ for every $x,y>0$.

Neither concavity nor endpoint limits are needed for this criterion. If an
affinity interpretation is wanted, impose the additional usual nonnegative
concavity assumptions separately.

### Proof of necessity

For fixed $x>0$, $x\ne 1$, and sufficiently small $t>0$, define $U_t$ by

```math
\Pr(U_t=x)=t,\qquad
\Pr\left(U_t=\frac{1-tx}{1-t}\right)=1-t.
```

Both values are positive and the mean is one. For a differentiable $h$ at
1, direct differentiation gives

```math
\lim_{t\downarrow0}\frac{E h(U_t)-h(1)}{t}
=h(x)-h(1)-(x-1)h'(1). \tag{R}
```

Fix any binary mean-one $V$. Its support is finite, so the derivative of
$h(u)=\mathbb E f(uV)$ at 1 is $\mathbb E[V f'(V)]$. The assumed product inequality and
the fact that its slack vanishes at $t=0$ give

```math
E\,[f(xV)-f(x)f(V)
 -(x-1)\{V f'(V)-p f(V)\}]\ge0. \tag{N1}
```

Define the bracket as $H_x(V)$. Then $H_x(1)=0$, and differentiability of
$f'$ at 1 gives

```math
H_x'(1)=x f'(x)-p f(x)-(x-1)(p+q-p^2).
```

Apply (N1) to $V_s$ constructed as in (R) with rare value $y$, divide by
$s$ and let $s$ tend to zero. The result is
$H_x(y)-(y-1)H_x'(1)=K_f(x,y)\ge 0$. Cases $x=1$ or $y=1$ give zero directly.
The limits are sequential, so no unproved uniform mixed Taylor remainder is
being used.

### Proof of sufficiency

Take the expectation of (K) at independent mean-one $U,V$. Every compensator
contains a factor with zero expectation independent of its other factor.
Consequently

```math
E K_f(U,V)=E f(UV)-E f(U)E f(V).
```

Nonnegativity of the pointwise kernel proves the claim for all finite laws.
The implication from all finite laws to binary laws is immediate.

### Relation to the old fourth-order certificate

If $f$ is $C^4$ and $g(x)=-x^2 f''(x)$, then

```math
\partial_x^2\partial_y^2 K_f(x,y)
=\frac{-(xy)^2g''(xy)-g(x)g(y)}{x^2y^2}. \tag{D}
```

All kernel and first-coordinate-derivative boundary data vanish on $x=1$
and $y=1$. The differential condition defining $\mathcal T^-$ in Section 5 is $-z^2g''(z)\ge g(a)g(z/a)$ for every $z,a>0$. Thus this condition implies $K_f\ge 0$ by two successive
second-order integral representations. For example

```math
K_f(x,y)=\int_1^x(x-u)\int_1^y(y-v)
 \partial_u^2\partial_v^2K_f(u,v)\,dv\,du.
```

For $x<1$ the signed integration direction and $(x-u)$ are both negative,
so this still preserves nonnegativity; similarly for $y<1$.
The exact kernel criterion therefore replaces a sufficient fourth-order
condition by a necessary and sufficient second-order/two-variable condition.
Section 4 below supplies whole admitted families that fail the older certificate.

## 4. Exact normalization of arbitrary power mixtures

### A credited sharp correlation inequality on an interval

Let $S$ have any probability law on $[0,1]$, with $m=\mathbb E S\in(0,1)$ and
$v=\operatorname{Var}(S)$. Put

```math
k=E[S(1-S)]=m(1-m)-v,\qquad
\gamma=\frac{k}{m(1-m)}.
```

For finite nonnegative concave functions $u,w$ on $[0,1]$,

```math
E[u(S)w(S)]\ge\gamma\,Eu(S)\,Ew(S). \tag{C}
```

The constant is sharp for every fixed law: $u(s)=s$ and $w(s)=1-s$ attain
equality. No log-concavity or density assumption on the law is needed.

### Attribution

The underlying covariance inequality

```math
v\operatorname{Cov}(u,w)
\ge \operatorname{Cov}(u,S)\operatorname{Cov}(w,S) \tag{BHS}
```

is **known**: Bonnefont--Hillion--Saumard (2024), Theorem 1.2(1), states it
for arbitrary laws and two convex functions; replacing both by their negatives
gives the concave form. The sharp bounded-interval multiplicative constant
(C) follows from that theorem and the elementary slope bounds below. It must
not be advertised as a new general covariance inequality. A short self-contained
proof of the only fact used from (BHS) is included next.

### Elementary proof of the covariance step

Suppose first $v>0$ and define the affine projection

```math
\ell(s)=Eu+\frac{\operatorname{Cov}(u,S)}{v}(s-m),\qquad h=u-\ell.
```

Then $\mathbb Eh=\mathbb E[Sh]=0$ and $h$ is concave. Unless $h=0$ almost surely, its positive
set is an interval; its nonpositive set lies outside that interval. The zero
mass and zero first moment force negative mass on both sides of the positive
mass. Let $a \lt b$ be the endpoints of the positive interval on the convex hull
of the support, extending to zeros of $h$ if necessary. The chord of $w$
between $a,b$, extended as an affine line $L$, satisfies $w\ge L$ inside and
$w\le L$ outside by concavity. Therefore $h(w-L)\ge 0$ pointwise on the support.
Since $\mathbb Eh=\mathbb E[Sh]=0$, $\mathbb E[hL]=0$, whence $\mathbb E[hw]\ge0$. This equals (BHS) after
expanding the projection. A limit of chords handles endpoints; in the
two-point-support case the projection already agrees with $u$ almost surely.
For degenerate $S$, (C) is equality.

### The endpoint slope bounds

For $\mathbb Eu>0$, concavity and endpoint nonnegativity imply
$u(s)/s$ is nonincreasing on $(0,1]$ and $u(s)/(1-s)$ is nondecreasing on
$[0,1)$. Consequently

```math
-\frac{v}{1-m}\le
 \frac{\operatorname{Cov}(u,S)}{Eu}
\le \frac{v}{m}. \tag{S}
```

For example the upper bound is equivalent to

```math
m E[Su]\le E[S^2]\,Eu.
```

The difference between the two sides is the double integral

```math
\frac12\iint (s-t)\{t u(s)-s u(t)\}\,d\nu(s)d\nu(t)\le0.
```

This proves the inequality even when $\nu$ has endpoint atoms, without dividing
by zero. Applying the same argument to $1-S$ gives the lower bound.

If both $\mathbb Eu,\mathbb Ew$ are positive, combine (BHS) with (S). The smallest product of
two numbers in $[-v/(1-m),v/m]$ is $-v^2/[m(1-m)]$, so

```math
\frac{Euw}{Eu Ew}\ge
1-\frac{v}{m(1-m)}=\gamma.
```

If an expectation is zero, (C) follows directly from nonnegativity.

### Theorem M1. Exact admissible dilution of arbitrary mixtures of powers

Let $\nu$ be a Borel probability measure on $(0,1)$. Define

```math
H_\nu(x)=\int_{(0,1)}x^s\,d\nu(s),\quad
m=\int s\,d\nu(s),\quad
k=\int s(1-s)\,d\nu(s),\quad
c_*=\frac{k}{m(1-m)}.
```

Then $0 \lt c_*\le 1$, with equality $c_*=1$ exactly when $\nu$ is a point mass.
For $0\le c\le1$, choose any $A,B\ge 0$ with $A+B=1-c$, and set

```math
F(x)=A x+B+c H_\nu(x). \tag{M}
```

This is nonnegative, smooth, concave and normalized by $F(1)=1$.
All mean-one affinities depend only on $c$, not on the split $(A,B)$.

**Sharp classification.** The inequality

```math
E F(UV)\ge E F(U)E F(V) \tag{P}
```

holds for every pair of independent positive finite-valued mean-one random
variables if and only if

```math
\boxed{c\le c_*=1-\frac{\operatorname{Var}_\nu(S)}{m(1-m)}.} \tag{F}
```

The same threshold is necessary if only binary experiments are allowed.
The formula covers finite, countable and continuous exponent mixtures.

### Sufficiency by concavity in the exponent

For fixed $U$, let

```math
d_U(s)=1-EU^s,\qquad0\le s\le1.
```

Finite support implies continuity and gives the second derivative
```math
d_U''(s)=-\mathbb E[U^s(\log U)^2]\le0.
```
Also $d_U(0)=d_U(1)=0$ and $d_U\ge 0$ by concavity
of $x^s$ and $\mathbb EU=1$. Independence gives

```math
d_{UV}(s)=d_U(s)+d_V(s)-d_U(s)d_V(s).
```

Writing $D_U=\int d_U\,d\nu$, the product slack is exactly

```math
E F(UV)-E F(U)E F(V)
=c\left\{\int d_U(s)d_V(s)\,d\nu(s)-cD_U D_V\right\}. \tag{G}
```

Apply (C) to the two concave functions $d_U,d_V$ under the law $\nu$.
This proves (G) nonnegative for $c\le c_*$.

### Necessity and binary witnesses

Set

```math
b_s(x)=1+s(x-1)-x^s,
\qquad B_\nu(x)=\int b_s(x)\,d\nu(s).
```

For $x\ne 1$ each $b_s(x)>0$. Direct substitution into (K), or sequential
rare-event differentiation as in (R), gives

```math
K_F(x,y)=c\left\{\int b_s(x)b_s(y)\,d\nu(s)
                 -c B_\nu(x)B_\nu(y)\right\}. \tag{MK}
```

For each fixed $s\in(0,1)$,

```math
b_s(x)\longrightarrow1-s\quad(x\downarrow0),\qquad
\frac{b_s(y)}{y}\longrightarrow s\quad(y\to\infty).
```

For $x\le 1$, $0\le b_s(x)\le 1$; for $y\ge 1$, $0\le b_s(y)/y\le 1$.
Bounded convergence thus yields

```math
\lim_{y\to\infty}\lim_{x\downarrow0}
\frac{\int b_s(x)b_s(y)\,d\nu(s)}
     {B_\nu(x)B_\nu(y)}
=\frac{k}{(1-m)m}=c_* . \tag{E}
```

For any $c>c_*$, choose finite $x,y$ making the ratio less than $c$; then
$K_F(x,y)<0$. The necessity argument of the affinity-kernel theorem constructs binary laws with
negative slack. In particular, this is a statement about actual finite binary
experiments and not an unattained endpoint model or a limiting-only failure.

For a two-atom mixture with weights $w,1-w$ at $a,b$,

```math
c_*=1-\frac{w(1-w)(b-a)^2}
 {[wa+(1-w)b][1-wa-(1-w)b]}.
```

For example a balanced mixture of exponents $1/4,3/4$ has $c_*=3/4$.
The continuous uniform exponent law has $m=1/2,k=1/6,c_*=2/3$, and

```math
H_\nu(x)=\frac{x-1}{\log x}\quad(x\ne1),\qquad H_\nu(1)=1.
```

These are exact infinite-domain thresholds, not consequences of finite search.

### Theorem M2. The sufficient differential certificate misses all nontrivial mixtures

For (M) with $c>0$,

```math
g_c(x)=-x^2F''(x)=c\int s(1-s)x^s\,d\nu(s).
```

Suppose $\nu$ is not a point mass. Then there exist $0 \lt a \lt b<1$ such that
$\nu((0,a])>0$ and $\nu([b,1))>0$. The corresponding integrals of $s(1-s)$
are strictly positive, say $L,H$. For $z\ge 1$,

```math
g_c(z)\ge cH z^b,\qquad g_c(1/z)\ge cL z^{-a}.
```

Their product is at least $c^2LH z^{b-a}$, which tends to infinity.
But the defining $\mathcal T^-$ inequality with product argument $x=1$ would require

```math
g_c(z)g_c(1/z)\le -g_c''(1)
=c\int [s(1-s)]^2\,d\nu(s)<\infty.
```

This is impossible. Hence **every non-Dirac exponent mixture fails $\mathcal T^-$
for every positive scale**, although Theorem M1 proves the exact nonempty
admissible interval $0 \lt c\le c_*$. This is a strict structural separation of the
necessary-and-sufficient kernel from the original differential certificate.

### Corollary M3. Tensor-power information saturates for every admitted nontrivial mixture

For strictly positive finite probability vectors $P\ne Q$, write

```math
a_s=\sum_iP_i^sQ_i^{1-s}\in(0,1),\qquad 0 \lt s<1.
```

Strict Hölder gives the displayed strict bound. For product experiments,

```math
A_F(P^{\otimes n},Q^{\otimes n})
=1-c+c\int a_s^n\,d\nu(s).
```

Bounded convergence yields $\int a_s^n\,d\nu\to0$. Thus if $0 \lt c<1$,

```math
-\log A_F(P^{\otimes n},Q^{\otimes n})
\longrightarrow-\log(1-c),\qquad
\frac{-\log A_F(P^{\otimes n},Q^{\otimes n})}{n}\longrightarrow0.
```

For a non-Dirac $\nu$, the exact admissibility condition forces $c\le c_*<1$,
so all admitted members have this bounded-evidence limitation. For a Dirac
law at $s$ and $c=1$, the quantity equals $-n \log a_s$, the usual linear
Rényi/Hellinger-affinity behavior. This concerns this fixed scalar transform;
it does not rule out adaptive scales or different information functionals.

## 5. The differential class and its exact mass defect

Write
```math
\mathcal T^-=
\{g\in C^2((0,\infty)):g\ge0,\ -x^2g''(x)\ge g(a)g(x/a)
\text{ for every }x,a>0\}.\tag{4}
```
For a generator $f$ we use this certificate when $g=-x^2f''$ is nonzero.
Thus the differential route requires $f\in C^4((0,\infty))$;
endpoint values are limits, not differentiability assumptions at zero. The
classical powers themselves need not have finite derivatives at zero.
The following preserved lemmas supply the exact Green normalization used by
the new quantitative theory. The classification of equality everywhere in the
differential certificate is already in [1, Lemma 16(3)]; the original manuscript's
contribution was to show how the boundary normalization forces that equality.

For nonzero $g\in C^2((0,\infty))\cap\mathcal T^-$, define
```math
 M(g)=\int_0^1\frac{g(t)}t\,dt
      +\int_1^\infty\frac{g(t)}{t^2}\,dt. \tag{9}
```
Finiteness of this integral will follow from the certificate, rather than being assumed.

### Theorem L2. Mass and differential defect

Every such $g$ is strictly positive on $(0,\infty)$, satisfies $0 \lt M(g)\leq1$, and obeys, for every $a>0$,
```math
 \boxed{
 g(a)[1-M(g)]
 =\int_0^\infty\frac{\min(a,t)}{t^2}
   [-t^2g''(t)-g(a)g(t/a)]\,dt.} \tag{10}
```
The integrand is nonnegative. Equality $M(g)=1$ holds exactly for
```math
 g(x)=\lambda(1-\lambda)x^\lambda,
 \qquad 0<\lambda<1. \tag{11}
```

#### Proof: boundary terms

The differential condition implies $g''\leq0$. A nonnegative concave function on the positive half-line has nonnegative derivative: a negative tangent slope would force negative values sufficiently far to the right. Thus $g$ is nondecreasing, its finite limit at zero exists, and $g'$ decreases to a nonnegative limit at infinity.

If $g$ vanished at an interior point, monotonicity would make it vanish to the left, and the nonnegative nonincreasing derivative would then vanish to the right as well. This contradicts the assumption that $g$ is nonzero. In particular $c=g(1)>0$. Taking $a=1$ in (4) gives
```math
 -g''(x)\geq c\,g(x)/x^2. \tag{12}
```

If $B_0=g(0+)>0$, integration over $(x,1)$ yields
```math
 g'(x)\geq g'(1)+cB_0(1/x-1),\qquad0 \lt x<1.
```
A second integration would make $g(1)-g(\varepsilon)$ diverge as $\varepsilon\downarrow0$. Hence $g(0+)=0$.

Let $\ell=\lim_{x\to\infty}g'(x)$. If $\ell>0$, then $g(x)\geq\ell x$, and (12) gives $g''(x)\leq-c\ell/x$. Integrating this inequality eventually makes $g'$ negative, which is impossible. Thus $g'(\infty)=0$. Concavity and the zero limit at zero also give
```math
 0\leq xg'(x)\leq g(x),
```
so $xg'(x)\to0$ as $x\downarrow0$.

#### Proof: the identity and integrability

For $0<\varepsilon \lt a \lt R$, integration by parts gives
```math
 \int_\varepsilon^a t[-g''(t)]\,dt
 +a\int_a^R[-g''(t)]\,dt
 =g(a)-g(\varepsilon)+\varepsilon g'(\varepsilon)-a g'(R).
```
The endpoint limits and monotone convergence imply
```math
 g(a)=\int_0^\infty\min(a,t)[-g''(t)]\,dt. \tag{13}
```
Multiply $-t^2g''(t)\geq g(a)g(t/a)$ by the positive kernel $\min(a,t)/t^2$ and integrate. By (13) and the substitution $t=au$,
```math
 g(a)\geq g(a)\int_0^\infty
    \frac{\min(a,t)}{t^2}g(t/a)\,dt
 =g(a)M(g).
```
This proves that $M(g)$ is finite and at most one. Both terms are now integrable, so subtraction is legitimate and yields (10). Strict positivity gives $M(g)>0$.

#### Proof: saturation

If $M(g)=1$, (10) has zero integral for every $a>0$. Its residual is continuous and nonnegative, and its kernel is strictly positive. Therefore
```math
 -t^2g''(t)=g(a)g(t/a)\qquad(t,a>0). \tag{14}
```
At $a=1$, this is $-t^2g''(t)=c g(t)$. Comparing the two expressions and setting $t=ab$ gives
```math
 g(ab)=g(a)g(b)/c.
```
The positive continuous function $g/c$ is multiplicative, so it is a power $x^\lambda$. Substitution in (14) gives $c=\lambda(1-\lambda)>0$, proving (11). Conversely, (11) gives zero residual and
```math
 M(g)=\lambda(1-\lambda)
       \left(\frac1\lambda+\frac1{1-\lambda}\right)=1.
```
This proves Theorem L2. $\square$

### Normalization measures the affine boundary terms

### Theorem L3. The boundary deficit

Let $f\in C^4((0,\infty))$ be nonnegative, satisfy $f(1)=1$, and have nonzero $g=-x^2f''\in\mathcal T^-$. Then the nonnegative limits
```math
 B=f(0+),\qquad
 A=f'(\infty)=\lim_{x\to\infty}f(x)/x
```
exist, and
```math
 f(x)=B+Ax+
       \int_0^\infty\frac{\min(x,t)}{t^2}g(t)\,dt,
 \qquad A+B+M(g)=1. \tag{15}
```
Consequently,
```math
 \boxed{
 g(a)(A+B)
 =\int_0^\infty\frac{\min(a,t)}{t^2}
       [-t^2g''(t)-g(a)g(t/a)]\,dt.} \tag{16}
```
If $A=B=0$, then $f(x)=x^\lambda$ for some $0<\lambda<1$. Every other normalized generator covered by this theorem has $A+B>0$.

#### Proof

Because $g\geq0$, the function $f$ is concave. Nonnegativity on the whole half-line implies $f'\geq0$. The limits $B\geq0$ and $A\geq0$ therefore exist. Integrating $f'$ shows $f(x)/x\to A$. Concavity gives
```math
 0\leq\varepsilon f'(\varepsilon)
 \leq f(\varepsilon)-B\longrightarrow0.
```
For $0<\varepsilon \lt x \lt R$, integration by parts gives
```math
 \int_\varepsilon^R\frac{\min(x,t)}{t^2}g(t)\,dt
 =f(x)-f(\varepsilon)+\varepsilon f'(\varepsilon)-x f'(R).
```
Taking the endpoint limits proves the representation in (15), and setting $x=1$ proves its normalization identity. Equation (16) follows from Theorem L2. If $A=B=0$, the mass equals one; Theorem L2 gives (11), and the integral in (15) equals $x^\lambda$. The coefficients $A,B$ account for both possible affine terms, so none has been lost. $\square$

### An independent proof by concave contact

The zero-boundary conclusion of Theorem L3 also has a direct proof that does not use saturation of the mass integral. The endpoint argument in Theorem L2 gives $g(0+)=0$ and $g(x)/x\to0$. For fixed $a>0$, define
```math
 H_a(x)=g(x)-g(a)f(x/a).
```
Then
```math
 H_a''(x)=g''(x)+\frac{g(a)}{x^2}g(x/a)\leq0.
```
If $A=B=0$, the function $H_a$ has zero limit at zero and satisfies $H_a(x)/x\to0$ at infinity. Such a concave function cannot have a negative derivative: its tangent would force a negative limiting slope. It is consequently nonnegative. Normalization gives an interior contact point,
```math
 H_a(a)=g(a)[1-f(1)]=0.
```
A nonnegative concave function with an interior zero must be identically zero. Thus
```math
 g(az)=g(a)f(z)\qquad(a,z>0).
```
Taking $a=1$ gives $g=g(1)f$; the preceding identity then makes $f$ multiplicative. Continuity and the two endpoint limits give $f(x)=x^\lambda$, $0<\lambda<1$, as before.

### A nonpower example with a positive boundary deficit

The oscillatory construction in [1, Example 5] has
```math
 g(x)=\frac{\sqrt{x}}{128}[9+\sin(\log x)],
```
and its normalized concave generator is
```math
 f(x)=\frac{\sqrt{x}}{160}[45+\sin(\log x)]
       +\frac{23}{32}x. \tag{17}
```
Here $B=0$, $A=23/32$, and direct integration gives $M(g)=9/32$. This example is entirely consistent with the obstruction: it carries a positive linear boundary term.

For completeness, its differential residual has a simple uniform lower bound. With $t=\log x$ and $v=\log a$,
```math
 \frac{-x^2g''(x)-g(a)g(x/a)}{\sqrt{x}}
 =\frac{9+5\sin t}{512}
  -\frac{[9+\sin v][9+\sin(t-v)]}{16384}
 \geq\frac7{4096}>0. \tag{18}
```
Thus (16) evaluates its integrated residual exactly as $23g(a)/32$. This is a concrete check that the rigidity statement depends on zero boundary deficit, rather than merely on nonnegativity and concavity.

## 6. Sharp all-scale quantitative rigidity

Let $g$ be a nonzero nonnegative member of $C^2((0,\infty))$ satisfying

```math
-x^2g''(x)\ge g(a)g(x/a) \qquad(x,a>0). \tag{Q1}
```

The preceding section proves that $g>0$, $g$ is concave and nondecreasing,
$g(0+)=0$, $g'(\infty)=0$, and

```math
g(a)=\int_0^\infty\min(a,t)(-g''(t))\,dt.
\tag{Q2}
```

Set

```math
\ell=\int_0^1\frac{g(t)}t\,dt,\qquad
q=\int_1^\infty\frac{g(t)}{t^2}\,dt,\qquad
M=\ell+q,\qquad\delta=1-M.
\tag{Q3}
```

The mass-defect identity gives $0 \lt M\le 1$, hence $0\le \delta <1$; strict positivity gives $\ell ,q>0$.

For every scale $a>0$ define a measure on $(0,\infty )$ by

```math
\mu_a(du)=\frac{a^2\min(1,u)(-g''(au))}{g(a)}\,du,
\qquad
\nu_g(du)=\frac{\min(1,u)g(u)}{u^2}\,du.
\tag{Q4}
```

**Theorem Q1 (common component at every scale).** Each $\mu_a$ is a probability measure, $\nu_g$ has mass $M$, and

```math
\mu_a\ge\nu_g \quad\text{as measures, for every }a>0. \tag{Q5}
```

If $\delta >0$, there are probability measures $R_a$ such that

```math
\mu_a=M\,\bar\nu_g+\delta R_a,
\qquad \bar\nu_g=\nu_g/M.
\tag{Q6}
```

For total variation in the convention $\operatorname{TV}(P,Q)=\sup_E|P(E)-Q(E)|$,

```math
\operatorname{TV}(\mu_a,\mu_b)\le\delta,
\qquad
\operatorname{TV}(\mu_a,\bar\nu_g)\le\delta.
\tag{Q7}
```

**Proof.** Formula (Q2), with $t=au$, gives the normalization of $\mu_a$. With $x=au$, (Q1) states

```math
a^2(-g''(au))/g(a)\ge g(u)/u^2.
```

Multiplication by $\min(1,u)$ proves (Q5). Subtraction and normalization give (Q6); its residual has mass $\delta$. The two total-variation bounds follow directly by cancellation of the common mass. For $\delta =0$, $\mu _a=\nu _g$ for every $a$. No differentiation of a parameterized improper integral is required. $\square$

The common-component statement is stronger than a scalar derivative estimate. In particular every measurable event $E$ has the same uniform enclosure

```math
\nu_g(E)\le\mu_a(E)\le\nu_g(E)+\delta
\quad\text{for every scale }a.
\tag{Q8}
```

### A sharp global band for the logarithmic derivative

**Theorem Q2 (elasticity band).** Under the same hypotheses,

```math
\boxed{q\le \frac{xg'(x)}{g(x)}\le q+\delta=1-\ell
\quad(x>0).} \tag{Q9}
```

Consequently

```math
\operatorname{osc}_{x>0}\frac{xg'(x)}{g(x)}\le\delta.
\tag{Q10}
```

The constant one in (Q10) is optimal, even among strictly positive smooth functions satisfying the differential condition (Q1), including arbitrarily near mass saturation.

**Proof of the bound.** Since $g'(\infty)=0$,

```math
\mu_x((1,\infty))
=\frac{x^2}{g(x)}\int_1^\infty -g''(xu)\,du
=\frac{xg'(x)}{g(x)}.
```

Since $\nu _g((1,\infty ))=q$, the event bound (Q8) is precisely (Q9). Formula (Q10) follows. $\square$

There is a second proof useful when no probability notation is desired. Define

```math
F(x)=\int_0^\infty\frac{\min(x,t)}{t^2}g(t)\,dt,
\qquad H_a(x)=g(x)-g(a)F(x/a).
```

The integral is finite, because $\min(x,t)\le \max(1,x)\min(1,t)$. One has
$F(1)=M$, $F'(1)=q$, $F(0+)=0$, $F'(\infty )=0$, and $F''(x)=-g(x)/x^2$. These claims follow by monotone/dominated convergence, with the finite dominating measure $\nu_g$ locally; the derivative is explicitly $F'(x)=\int_x^\infty g(t)t^{-2}\,dt$. Condition (Q1) gives

```math
H_a''(x)=g''(x)+\frac{g(a)}{x^2}g(x/a)\le0.
```

Its limiting derivative at infinity is zero, so $H_a'\ge 0$; also $H_a(0+)=0$. Therefore $0\le xH_a'(x)\le H_a(x)$, by concavity. At $x=a$, this says

```math
0\le ag'(a)-qg(a)\le(1-M)g(a),
```

which again proves (Q9).

### Integrated all-scale consequences

Set

```math
p_* = q+\delta/2.
\tag{Q11}
```

Then $\delta /2 \lt p_*<1-\delta /2$. Integrating (Q9) in $\log x$ gives, for all $x>0$,

```math
\min\{x^q,x^{q+\delta}\}
\le \frac{g(x)}{g(1)}
\le \max\{x^q,x^{q+\delta}\},
\tag{Q12}
```

and equivalently

```math
\boxed{\left|\log\frac{g(x)}{g(1)}-p_*\log x\right|
\le\frac\delta2|\log x|.}
\tag{Q13}
```

More generally the same enclosure holds for a ratio at arbitrary positive base scale:

```math
\left|\log\frac{g(ax)}{g(a)}-p_*\log x\right|
\le\frac\delta2|\log x| \qquad(a,x>0).
\tag{Q14}
```

Thus no compactness assumption on $x$ or positive lower bound on $g(1)$ is needed. On a fixed logarithmic window $|\log x|\le R$, the multiplicative error is at most $\exp(\delta R/2)$. Global *uniform* multiplicative closeness to a single power, without the $|\log x|$ factor, is false; see the limitation below.

As a separate normalization estimate, with $c=g(1)$, integration of the power bounds yields

```math
\boxed{q\ell\le c\le \min\{q(1-q),\ell(1-\ell)\}.}
\tag{Q15}
```

Indeed, on $(0,1)$, $cx^{q+\delta }\le g(x)\le cx^q$, so
$c/(q+\delta )\le \ell \le c/q$. On $(1,\infty )$, $cx^q\le g(x)\le cx^{q+\delta }$, so
$c/(1-q)\le q\le c/(1-q-\delta )=c/\ell$. All denominators are strictly positive because $q,\ell >0$. Combining these inequalities gives (Q15). No optimality assertion is made here for the lower bound in (Q15).

The upper bound is sharp in the closure of the smooth class, by the symmetric family below.

### Smooth sharpness witnesses

Fix $0 \lt w<1$, $\tau >0$, and define

```math
c_w=\frac{1-w^2}{4},\quad a_w=\frac w2,\quad
g_{w,\tau}(x)=c_w\sqrt{x}
\exp\left(-a_w\sqrt{(\log x)^2+\tau^2}\right).
\tag{Q16}
```

**Proposition Q3.** Every $g_{w,\tau }$ is strictly positive and $C^\infty$ on $(0,\infty )$ and satisfies (Q1). Its elasticity oscillation is exactly $w$. Writing $M_{w,\tau }$ for its mass and $\delta _{w,\tau }=1-M_{w,\tau }$,

```math
(1-w)e^{-w\tau/2}\le M_{w,\tau}<1-w,
\qquad
\delta_{w,\tau}\downarrow w\quad(\tau\downarrow0).
\tag{Q17}
```

Its two half-masses coincide, so $p_*=1/2$. In addition

```math
\inf_{p\in\mathbb R}\sup_{x\ne1}
\frac{|\log(g_{w,\tau}(x)/g_{w,\tau}(1))-p\log x|}
{|\log x|}
=\frac w2.
\tag{Q18}
```

**Proof of membership.** Put $t=\log x$ and
$H(t)=\log g_{w,\tau}(e^t)=\log c_w+t/2-a_w\sqrt{t^2+\tau^2}$. Then

```math
H'(t)=\frac12-\frac{a_wt}{\sqrt{t^2+\tau^2}},
\quad
H''(t)=-\frac{a_w\tau^2}{(t^2+\tau^2)^{3/2}}.
```

For any positive smooth $g$, the chain rule gives
$x^2g''(x)/g(x)=H''+(H')^2-H'$. Hence

```math
\frac{-x^2g_{w,\tau}''(x)}{g_{w,\tau}(x)}
=\frac14-
\frac{a_w^2t^2}{t^2+\tau^2}
+\frac{a_w\tau^2}{(t^2+\tau^2)^{3/2}}
\ge\frac14-a_w^2=c_w.
\tag{Q19}
```

For every $u,t\in\mathbb R$, the triangle inequality in $\mathbb R^2$ gives

```math
\sqrt{t^2+\tau^2}
\le\sqrt{u^2+\tau^2/4}
  +\sqrt{(t-u)^2+\tau^2/4}
\le\sqrt{u^2+\tau^2}
  +\sqrt{(t-u)^2+\tau^2}.
\tag{Q20}
```

Therefore

```math
\frac{g_{w,\tau}(e^u)g_{w,\tau}(e^{t-u})}
{g_{w,\tau}(e^t)}
\le c_w.
\tag{Q21}
```

Combining (Q19) and (Q21) proves (Q1). Notice that no claim of normalized pointwise supermultiplicativity is used: $g_{w,\tau }(1)=c_w e^{-w\tau /2}$, not $c_w$.

**Proof of the mass and sharpness claims.** The elasticity is $H'(t)$. Its limits at $t=-\infty ,+\infty$ are $(1+w)/2,(1-w)/2$, and it is strictly decreasing, so its oscillation is $w$.

The identity $g(x)=xg(1/x)$ gives $q=\ell =M/2$. Transforming (Q3) to the logarithmic coordinate gives

```math
M_{w,\tau}=2c_w\int_0^\infty
e^{-t/2-a_w\sqrt{t^2+\tau^2}}\,dt.
\tag{Q22}
```

Since $t\le\sqrt{t^2+\tau^2}\le t+\tau$,

```math
e^{-a_w\tau}\frac{2c_w}{1/2+a_w}
\le M_{w,\tau}<\frac{2c_w}{1/2+a_w}=1-w,
```

which proves (Q17), including convergence and strictness for $\tau >0$. In particular

```math
0<\delta_{w,\tau}-w\le(1-w)(1-e^{-w\tau/2})
\le w\tau/2.
\tag{Q23}
```

Furthermore

```math
\log\frac{g_{w,\tau}(e^t)}{g_{w,\tau}(1)}-\frac t2
=-\frac w2(\sqrt{t^2+\tau^2}-\tau).
```

The ratio $(\sqrt{t^2+\tau^2}-\tau)/|t|$ lies in $[0,1)$ and tends to one as $|t|\to \infty$, proving that the supremum in (Q18) is $w/2$ for $p=1/2$. For any other $p$, the two limits at $t=\pm \infty$ give a supremum at least
$\max(|(1-w)/2-p|, |(1+w)/2-p|)\ge w/2$. This proves the infimum identity. $\square$

Letting $\tau \downarrow 0$ proves the optimal constants one in (Q10) and one half in (Q13), even if the approximating power exponent is allowed to depend arbitrarily on $g$. Choosing additionally $w\downarrow 0$, $\tau \downarrow 0$ and using (Q23) proves sharpness in the near-saturation regime $\delta \downarrow 0$, rather than only at a fixed nonzero deficit.

The coefficient one in the pairwise total-variation bound (Q7) is sharp as well. For this family, use the single event $(1,\infty )$ and take the two base scales toward zero and infinity. Their event probabilities are the two limiting elasticities, whose difference is $w$. Thus $\sup_{a,b} \operatorname{TV}(\mu _a,\mu _b)\ge w$, whereas the universal upper bound is $\delta _{w,\tau }$. The ratio tends to one as $\tau \downarrow 0$, also in the double limit giving $\delta \downarrow 0$.

### A limitation that should accompany the quantitative theorem

For each fixed $w>0$, $\tau >0$, the smooth witness has different power exponents at zero and infinity:

```math
g_{w,\tau}(x)\sim c_w x^{(1+w)/2}\quad(x\downarrow0),
\qquad
g_{w,\tau}(x)\sim c_w x^{(1-w)/2}\quad(x\to\infty).
\tag{Q24}
```

Consequently there is no exponent $p$ and no finite constant $C$ such that

```math
C^{-1}x^p\le g_{w,\tau}(x)/g_{w,\tau}(1)\le Cx^p
\quad\text{for all }x>0.
\tag{Q25}
```

To have two-sided comparability at zero requires $p=(1+w)/2$; comparability at infinity requires $p=(1-w)/2$. These are incompatible. The failure persists with arbitrarily small positive mass deficit. Thus local logarithmic windows, an error linear in $|\log x|$, or power-index enclosures are necessary; a global uniform multiplicative approximation cannot follow solely from small $1-M$.

## 7. Consequences for Green-normalized affinities

### Corollary Q4. Likelihood-window and composition bounds

Under the hypotheses and notation of Section 6, put

```math
F(x)=\int_0^\infty\frac{\min(x,t)}{t^2}g(t)\,dt,
\qquad h(x)=\frac{F(x)}{M},\qquad p_*=q+\delta/2.
```

The change of variable $t=xu$ gives
$F(x)=\int_0^\infty\min(1,u)g(xu)u^{-2}\,du$. The all-scale power inequalities for $g$
therefore survive positive integration:

```math
\min\{x^q,x^{q+\delta}\}\le \frac{F(ax)}{F(a)}
 \le\max\{x^q,x^{q+\delta}\},\qquad a,x>0.
```

In particular $h(1)=1$, $h$ is positive and concave, and

```math
\left|\log h(x)-p_*\log x\right|\le\frac{\delta}{2}|\log x|.
```

For positive finite probability vectors $P,Q$, let
$L(P,Q)=\max_i|\log(P_i/Q_i)|$,
$A_h(P,Q)=\sum_iQ_i h(P_i/Q_i)$, and
$A_p(P,Q)=\sum_iP_i^p Q_i^{1-p}$.
Then

```math
\boxed{\left| -\log A_h(P,Q)+\log A_{p_*}(P,Q)\right|
\le\frac{\delta}{2}L(P,Q).}
```

Indeed the pointwise comparison bounds the ratio of the two positive sums
between $\exp(-\delta L/2)$ and $\exp(\delta L/2)$.
For a product of different experiments the right side is at most
$(\delta/2)\sum_jL(P_j,Q_j)$, while the power-affinity logarithm is additive.
These are deterministic approximation bounds; $h$ itself need not satisfy
exact affinity supermultiplicativity after removal of the affine boundary mass.

There is also a direct approximate composition estimate. Let
$H(t)=\log h(e^t)$. Its derivative lies in $[q,q+\delta ]$. Integrating
$H'(t+v)-H'(v)$ over the segment from zero to $u$, and exchanging the roles
of $t,u$, proves

```math
|H(t+u)-H(t)-H(u)|\le\delta\min\{|t|,|u|\}.
```

Hence for independent positive $U,V$ with $|\log U|\le R$ and $|\log V|\le S$ almost surely,

```math
\left|\log \frac{E h(UV)}{E h(U)E h(V)}\right|
\le\delta\min(R,S).
```

This does not assume the random variables are mean one, although that
condition is needed for the likelihood interpretation. If the original
normalized generator is $f(x)=Ax+B+F(x)$ with $A+B=\delta$, its affinity is
$A_f=\delta +M A_h$; this relation distinguishes the valid full generator from the
boundary-stripped one.

For the smooth sharpness family in Section 6, the Green transform
has the same two endpoint exponents. More precisely, with
$a=(1+w)/2$, $b=(1-w)/2$, one has
$F(x)\sim x^a$ at zero and $F(x)\sim x^b$ at infinity, because
$g(x)\sim c_w x^a$ or $c_w x^b$ and $c_w=a(1-a)=b(1-b)$.
For completeness, split the Green representation as
```math
F(x)=\int_0^x\frac{g(t)}t\,dt
     +x\int_x^\infty\frac{g(t)}{t^2}\,dt.
```
At zero these two terms are respectively asymptotic to
$c_w x^a/a$ and $c_w x^a/(1-a)$. At infinity they are respectively
asymptotic to $c_w x^b/b$ and $c_w x^b/(1-b)$.
These assertions follow by bounding $g$ between $(1\pm\varepsilon)$
times the appropriate endpoint power on a fixed endpoint neighborhood,
integrating the two powers explicitly, and then letting $\varepsilon$
decrease to zero. Only the fixed part away from the endpoint is lower order:
it contributes $O(x)$ at zero or $O(1)$ at infinity.
Since $c_w/[a(1-a)]=c_w/[b(1-b)]=1$, the asserted constants follow.
Thus the logarithmic-power coefficient $1/2$ for $h$ also
cannot be improved uniformly. For reciprocal arguments $x=e^R,\ y=e^{-R}$,
the composition defect divided by $R$ tends to $w$; then $\tau \downarrow 0$ makes
$\delta \to w$, proving that the coefficient one is sharp for the last bound over independent positive random variables, where deterministic reciprocal variables are allowed.
No claim of a uniform multiplicative approximation over the whole half-line
is made; that stronger assertion is false even for arbitrarily small $\delta$.

## 8. Preserved zero-boundary rigidity and the fixed original question

### Theorem L1. Rigidity from binary product tests

Let $f:(0,\infty)\to[0,\infty)$ be finite-valued and satisfy
```math
 f(1)=1,\qquad
 \lim_{x\downarrow0}f(x)=0,\qquad
 \lim_{x\to\infty}\frac{f(x)}x=0. \tag{5}
```
Assume that $f$ is differentiable at $1$. The following statements are equivalent:

1. Inequality (1) holds for every independent pair of strictly positive, two-point, mean-one random variables $U,V$.
2. There is a $p\in(0,1)$ such that $f(x)=x^p$ for every $x>0$.

In the second case, (1) is an equality for all independent finite-valued positive random variables, without the mean-one restriction. Moreover, $p=f'(1)$.

#### Proof: isolating one likelihood ratio

Fix a strictly positive, two-point, mean-one random variable $V$. We first prove, for each $x>0$,
```math
 \mathbb E f(xV)\geq f(x)\,\mathbb E f(V). \tag{6}
```

Suppose $x>1$. For $0<\varepsilon<1$, let $U_\varepsilon$, independent of $V$, take values $x$ and $\varepsilon$ with probabilities
```math
 p_\varepsilon=\frac{1-\varepsilon}{x-\varepsilon},
 \qquad 1-p_\varepsilon=\frac{x-1}{x-\varepsilon}.
```
These probabilities are strictly between zero and one, and $\mathbb E U_\varepsilon=1$. Since $V$ has finite positive support, (5) gives
```math
 \mathbb E f(U_\varepsilon V)\longrightarrow
 \frac1x\mathbb E f(xV),\qquad
 \mathbb E f(U_\varepsilon)\longrightarrow\frac1x f(x).
```
Taking the limit in (1) and multiplying by $x$ proves (6).

Now suppose $0 \lt x<1$. For $M>1$, let $U_M$ take values $x$ and $M$ with probabilities
```math
 p_M=\frac{M-1}{M-x},
 \qquad 1-p_M=\frac{1-x}{M-x}.
```
Again $\mathbb E U_M=1$. For any fixed $v>0$,
```math
 (1-p_M)f(Mv)
 =\frac{(1-x)Mv}{M-x}\,\frac{f(Mv)}{Mv}
 \longrightarrow0.
```
The same holds with $v=1$. The support of $V$ is finite, so (1) converges to (6). For $x=1$, (6) is simply equality.

#### Proof: pointwise supermultiplicativity

Fix $x,y>0$. If $y>1$, apply (6) to the two-point variable with values $y,\varepsilon$ and mean one, and let $\varepsilon\downarrow0$. Both terms involving $\varepsilon$ vanish by (5), including $f(x\varepsilon)$, giving
```math
 f(xy)\geq f(x)f(y). \tag{7}
```
If $0 \lt y<1$, use the variable with values $y,M$ and mean one and let $M\to\infty$. The terms involving $f(M)$ and $f(xM)$, each multiplied by a quantity of order $M^{-1}$, vanish by sublinearity. This again gives (7). The case $y=1$ is equality. These are sequential limits of binary tests; no joint limiting argument or continuity at the finite points $x,y,xy$ is needed.

Once positivity and pointwise supermultiplicativity have been established, the differentiable rigidity step is the classical conclusion of [5, Proposition 2], equivalently applied to the reciprocal generator. The passage from binary expected-value tests and endpoint limits to that pointwise hypothesis is the preceding bridge. The following proof is included for completeness.

#### Proof: positivity and rigidity at one

Differentiability at one implies continuity there, and $f(1)=1$. For any $x>0$, choose a positive integer $n$ large enough that $z=x^{1/n}$ is in an interval where $f$ is positive. Repeated use of (7) yields
```math
 f(x)=f(z^n)\geq f(z)^n>0.
```
Consequently
```math
 H(t):=\log f(e^t),\qquad t\in\mathbb R,
```
is well defined. It satisfies
```math
 H(u+v)\geq H(u)+H(v),\quad H(0)=0,
 \quad H'(0)=f'(1)=:p. \tag{8}
```
For any fixed $t$ and any positive integer $n$, superadditivity gives
```math
 H(t)\geq nH(t/n).
```
Taking $n\to\infty$ and using differentiability at zero gives $H(t)\geq pt$. Applied to $-t$, this yields $H(-t)\geq-pt$. On the other hand, (8) gives $H(t)+H(-t)\leq H(0)=0$, hence $H(t)\leq pt$. Therefore $H(t)=pt$ for every real $t$, and $f(x)=x^p$.

The first endpoint condition in (5) forces $p>0$; the second forces $p<1$. Conversely, powers with $0 \lt p<1$ meet (5), are differentiable at one, and satisfy (1) with equality by independence. This proves the theorem. $\square$

### Why differentiability at one matters

Let $0 \lt b \lt a<1$ and define
```math
 f(x)=\min\{x^a,x^b\}.
```
This function is positive, satisfies (5), and is concave. It obeys (7), since
```math
 \min\{(xy)^a,(xy)^b\}
 \geq\min\{x^a,x^b\}\min\{y^a,y^b\}.
```
Taking expectations and using independence proves (1) for arbitrary finite positive $U,V$. Nevertheless, $f$ is not a single power: its left derivative at one is $a$, and its right derivative is $b$. Thus the regularity assumption in Theorem L1 cannot simply be deleted.

One can retain even a bounded modulation of one fixed power. Define
```math
 f(x)=\sqrt{x}\exp\left[-c\frac{|\log x|}{1+|\log x|}\right],
 \qquad c=\frac1{16}. \tag{8a}
```
Then
```math
 e^{-1/16}\sqrt{x}\leq f(x)\leq\sqrt{x},
 \qquad f(1)=1,
```
and both endpoint limits in (5) hold. To verify (7), put $q(r)=r/(1+r)$ for $r\geq0$. This function is increasing and subadditive; indeed,
```math
 q(r)+q(u)-q(r+u)
 =\frac{ru(r+u+2)}{(r+1)(u+1)(r+u+1)}\geq0.
```
The triangle inequality therefore makes $h(t)=-c q(|t|)$ superadditive. Since $\log f(e^t)=t/2+h(t)$, (7) follows.

This example is also globally concave. For $t\ne0$,
```math
 h'(t)=-\frac{c\,\operatorname{sgn}(t)}{(1+|t|)^2},
 \qquad h''(t)=\frac{2c}{(1+|t|)^3},
```
and, with $t=\log x$,
```math
 \frac{x^2f''(x)}{f(x)}
 =-\frac14+[h'(t)]^2+h''(t)
 \leq-\frac14+c^2+2c=-\frac{31}{256}<0.
```
At one, its left and right derivatives are $9/16$ and $7/16$, respectively. This downward jump preserves concavity. Thus a nonpower bounded multiplier can satisfy the affinity product inequality and all endpoint conditions, while failing differentiability exactly at the normalization point. It cannot meet the original ordinary-derivative certificate $g=-x^2f''\in\mathcal T^-$ in Section 5.

### Corollary L4. No nonclassical generator under the original hypotheses

Fix $s\in(0,1)$. Suppose that $f_s$ is of the form $f_s(x)=x^s\psi_s(\log x)$, with $g=-x^2f_s^{\prime\prime}\in\mathcal T^-$, that $\psi_s(0)=1$, and that there are constants $0 \lt a \lt b<\infty$ with
```math
 a\leq\psi_s(t)\leq b\qquad(t\in\mathbb R).
```
Then
```math
 f_s(x)=x^s\quad(x>0),\qquad \psi_s\equiv1.
```

#### Proof

The upper bound gives $0 \lt f_s(x)\leq b x^s$, hence $B=f_s(0+)=0$ and $A=\lim_{x\to\infty}f_s(x)/x=0$. Normalization gives $f_s(1)=1$.

If $g=-x^2f_s''$ were identically zero, $f_s$ would be affine. Its two zero boundary coefficients would make it identically zero, contradicting its value at one. Thus Theorem L3 applies and yields $f_s(x)=x^\lambda$ for some $0<\lambda<1$.

The bound $x^{\lambda-s}\leq b$ holds for every positive $x$. It forces $\lambda=s$: otherwise it fails either at zero or at infinity. Therefore $\psi_s\equiv1$. $\square$

The proof is pointwise in $s$; it does not require uniform bounds across the entire parameter family. In fact, the positive lower bound on the multiplier is unnecessary for this conclusion. This does not contradict [1, Theorem 9]: its stated admissible generator family collapses to powers. Nonclassical examples do not exist under those hypotheses. The separate channel-coding converse proof is outside the scope of this result.

Theorem L1 gives a complementary conclusion. Even if the differential certificate is replaced by the product-affinity inequality itself, zero endpoint affine terms and differentiability at one still force a power. This stronger conclusion concerns the fixed negative-log-affinity structure. It does not classify all transformed divergences.

### A comparison that does not require differentiability

The binary isolation argument in Theorem L1 uses differentiability only after it has established (7). This observation gives a further bound when a fixed power envelope is retained.

### Proposition L5. Pointwise domination and the exponent expression

Fix $s\in(0,1)$. Let $f_s:(0,\infty)\to[0,\infty)$ be finite-valued and satisfy $f_s(1)=1$, the binary product inequality in Theorem L1, and
```math
 f_s(x)\leq B_s x^s\qquad(x>0)
```
for a finite constant $B_s$. No differentiability assumption is made. Then
```math
 f_s(x)\leq x^s\qquad(x>0). \tag{19}
```

For the following comparison of finite logarithmic expressions, assume additionally that each $f_s$ is strictly positive and concave on $(0,\infty)$. Consider a finite-alphabet channel $W(y\mid x)>0$, as in [1, Setting 3], and use the same domain of full-support reference laws $Q_Y(y)>0$ for every generator. Then the variational expression in [1, equation (61)], on this common domain, is at least its value for the classical power family. Hence replacing powers by this nonsmooth family cannot strengthen that particular expression as an upper bound on the reliability exponent.

#### Proof

The upper power envelope gives both endpoint limits in (5). The binary isolation argument therefore gives (7). For every positive integer $n$,
```math
 f_s(x)^n\leq f_s(x^n)\leq B_s x^{ns}.
```
Take the $n$-th root and let $n\to\infty$ to obtain (19).

Set
```math
 \widetilde f_s(x)=x[1-f_s(1/x)],
 \qquad \widetilde p_s(x)=x-x^{1-s}.
```
Equation (19) gives $\widetilde f_s\geq\widetilde p_s$. The additional concavity assumption ensures that these are convex divergence generators. Therefore, for strictly positive finite probability laws, the associated divergences satisfy
```math
 D_{\widetilde f_s}(P\Vert Q)
 \geq D_{\widetilde p_s}(P\Vert Q).
```
The logarithms are finite on this common domain, because
```math
 0<1-D_{\widetilde f_s}(P\Vert Q)
   =\sum_y P(y)f_s\!\left(\frac{Q(y)}{P(y)}\right)
   \leq\sum_y P(y)^{1-s}Q(y)^s\leq1.
```
The last inequality is Hölder's inequality. Thus the increasing transform $G(z)=-\log(1-z)$ applies to both ordered sums. For every fixed input distribution and full-support auxiliary output distribution, the corresponding transformed conditional average is ordered in the same direction. Averaging over input symbols and taking the infimum over the same auxiliary domain preserve that order, so
```math
 I_{G,\widetilde f_s}(X;Y)
 \geq I_{G,\widetilde p_s}(X;Y). \tag{20}
```
Here the variational information functional is
```math
 I_{G,h}(X;Y)
 =\inf_{Q_Y:\,Q_Y(y)>0\ \forall y}\sum_x P_X(x)
      G\!\left(D_h(P_{Y\mid X=x}\Vert Q_Y)\right).
```

For clarity, denote the expression itself by
```math
 E_f^{\mathrm{expr}}(R)
 =\sup_{P_X}\sup_{0 \lt s<1}
   \left[\frac{I_{G,\widetilde f_s}(X;Y)}{1-s}
         -\frac{sR}{1-s}\right].
```
The coefficient $1/(1-s)$ is positive. Thus (20), followed by the two suprema, yields
```math
 E_f^{\mathrm{expr}}(R)
 \geq E_{\mathrm{power}}^{\mathrm{expr}}(R). \tag{21}
```
A larger upper bound on a reliability exponent is weaker. This proves the comparison. $\square$

Equation (21) is an algebraic comparison of the specified expressions. It does **not** assert that [1, Theorem 9]'s converse proof extends to arbitrary nonsmooth functions. That validity question is separate. The strict positivity assumption in the expression comparison ensures finite logarithms; the pointwise domination (19) needs only nonnegativity. Without strict positivity, some generator sums can give $G=+\infty$, which is outside the finite-logarithm formulation used here.

## 9. Attribution, verification, and limits

### Comparison with the strongest inspected neighboring results

| Source | Established content used or compared | Exact distinction of the present results |
| --- | --- | --- |
| Abin et al. [1], Theorem 4 and Appendix E.1 | Binary reductions and a sufficient differential condition | Theorem C1 and the affinity kernel are necessary and sufficient; Theorem M2 supplies a whole admitted family outside that sufficient condition |
| Abin et al. [1], Lemma 18 | A derivative interval determined by g(1), collapsing at the square-root extremizer | Theorems Q1-Q2 use total Green mass, collapse near every saturated power, and have smooth sharpness at arbitrarily small deficit |
| Cruz-Calmon-Yu [3], Theorems 15 and 30 | Exact quadratic scalar composition laws and their generator classification | Theorem C1 determines optimal inequalities for general generators, including examples with different best upper and lower coefficients |
| Sason-Verdu [9], Theorem 1 | Sharp one-variable functional domination and binary rare-atom sharpness | Theorem C1 applies twice-compensated two-variable domination to the product excess; the sharpness technique is credited |
| Bonnefont-Hillion-Saumard [8], Theorem 1.2(1) | Arbitrary-law covariance inequality for two convex functions | The needed concave correlation bound is a corollary, not a claimed new general covariance theorem; Theorem M1 is its exact tensorization application |
| Csiszar-Mori [10], Theorem 4.2 | Uniform-law sharp correlation constants for nonnegative concave functions | The known 2/3 becomes the exact logarithmic-mean dilution coefficient; the arbitrary-law theorem is supported by [8] |
| Abin-Gohari [4], Appendix D | Mixed powers and a logarithmic-mean example with a KL component for mutual information | The present transform is a fixed negative logarithm of an affinity, with an exact universal coefficient and a tensor-power rate limitation |

Two material formal conference texts were not obtained: Cruz-Diaz-Calmon [2]
and the six-page version of Abin et al. [6]. Their abstracts, bibliographic
metadata, and the available longer author manuscripts were compared. The first
abstract mentions a necessary condition for exact tensorization; its auxiliary
calculation might overlap a special case of the compensation method. The
second formal version might change the status of the fixed preprint's open
remark. Neither full text is used as a premise in a proof. We do not assert
that those auxiliary results have been excluded, that the formal versions are
identical to the preprints, or that the present results have global priority.
The mathematical answer to the precisely
fixed preprint statement does not depend on an assertion that it remained
unresolved in every later version.

### What the stability theorem does and does not show

The deficit-dependent power envelope is global in scale, but its logarithmic
error grows with the logarithmic scale. The smooth sharpness family proves that
a uniform multiplicative approximation on the whole half-line cannot be
guaranteed from the deficit alone, even arbitrarily close to saturation. The approximation of a Green-normalized affinity
does not make that stripped generator an exact tensorizer. Conversely,
nontrivial mixed-power tensorizers demonstrate that the sufficient differential
class does not characterize all valid generators. These statements describe
different precisely specified classes and do not contradict one another.

The saturation corollary concerns one fixed generator and its fixed transform.
It does not rule out different transforms, adaptive scales, vectors of
information measures, or other coding converses. The KL-plus-Pearson example
is a sharp illustration of the general principle, not a new identity for KL
or Pearson divergence. The one-sided derivative and pointwise criteria do not
by themselves supply an efficient exact optimizer for every arbitrary input
function. No numerical grid is used to establish a universal quantifier.

### Reproducible finite evidence

Exact-rational computations check the compensated identity,
admissible kernel values, and the expectation identity on finite families.
They give a strictly negative rational product slack for the balanced orders
1/4 and 3/4 at c=4/5, while the analytic threshold is c=3/4.
A separately constructed smaller-probability binary witness gives
```math
-\frac{159007797540002901}{3190488982962381441545984}<0.
```
The exact input values are fourth powers of positive rational numbers, so all
generator evaluations in these examples are rational. Symbolic checks verify
the KL and Pearson product residuals. High-precision integrations illustrate
the mass of the smooth sharpness family; those integrations are diagnostics,
whereas membership, sharpness, and every limit used in the theorems have
analytic proofs above.

## References

[1] H. Abin, M. Zinati, A. Gohari, M. H. Yassaee, and M. M. Mojahedian. *A Class of Subadditive Information Measures and their Applications*. arXiv:2601.15639v1, 22 January 2026. <https://arxiv.org/abs/2601.15639v1>. In particular: equation (40), Theorem 9, Remarks 7--8, Lemmas 16 and 18, and Example 5. Theorem 9 and Remark 7 are on printed page 16.

[2] R. Cruz, M. Diaz, and F. P. Calmon. *Tensorization of f-Divergences*. 2025 IEEE International Symposium on Information Theory (ISIT). <https://doi.org/10.1109/ISIT63088.2025.11195387>. **Metadata and abstract checked; full text unavailable in this review.** The description of its exact composition-law setting is also supported by the later account in [3].

[3] R. Cruz, F. P. Calmon, and Q. Yu. *A Complete Characterization of Tensorizable f-divergences*. arXiv:2608.28556v1, 28 August 2026. <https://arxiv.org/abs/2608.28556v1>.

[4] H. Abin and A. Gohari. *On the Subadditivity of Mutual f-Information*. arXiv:2610.21231v1, 15 October 2026. <https://arxiv.org/abs/2610.21231v1>. In particular: Theorems 3--4, equation (11), and Examples 3--4.

[5] C. E. Finol and M. Wójtowicz. *Multiplicative properties of real functions with applications to classical functions*. Aequationes Mathematicae **59**, 134--149 (2000). Proposition 2, p. 136. <https://doi.org/10.1007/PL00000120>.

[6] H. Abin, M. Zinati, A. Gohari, M. H. Yassaee, and M. M. Mojahedian. *A Class of Subadditive Information Measures and their Applications*. 2026 IEEE International Symposium on Information Theory (ISIT), six pages, August 2026. <https://doi.org/10.1109/ISIT62367.2026.11653956>. **Metadata and abstract checked; full text unavailable in this review.** Institutional record: <https://research.cuhk.edu.hk/en/publications/a-class-of-subadditive-information-measures-and-their-application/>.

[7] I. Csiszár. *Axiomatic Characterizations of Information Measures*. Entropy **10**(3), 261--273 (2008). <https://doi.org/10.3390/e10030261>.

[8] M. Bonnefont, E. Hillion, and A. Saumard. *Covariance inequalities for convex and log-concave functions*. ALEA **21** (2024), 627-660. Theorem 1.2(1). <https://doi.org/10.30757/ALEA.v21-25>. Publisher full text: <https://alea.impa.br/articles/v21/21-25.pdf>.

[9] I. Sason and S. Verdu. *f-Divergence Inequalities*. IEEE Transactions on Information Theory **62**(11) (2016), 5973-6006. Theorem 1 and its sharpness proof in Section III-A. <https://doi.org/10.1109/TIT.2016.2603151>. Author full text: <https://webee.technion.ac.il/people/sason/f-divergence%20inequalities.pdf>.

[10] V. Csiszar and T. F. Mori. *Sharp Integral Inequalities for Products of Convex Functions*. Journal of Inequalities in Pure and Applied Mathematics **8**(4) (2007), Article 94. Theorem 4.2. Publisher archive: <https://ftp5.gwdg.de/pub/EMIS/journals/JIPAM/images/192_07_JIPAM/192_07_www.pdf>.

