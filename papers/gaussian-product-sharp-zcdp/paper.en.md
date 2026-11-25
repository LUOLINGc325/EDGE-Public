# The exact asymptotic privacy gain of the Gaussian-product mechanism

## Reverse all-orders collapse and a certified count-dependent zCDP budget

24 November 2026 · AI-assisted research manuscript · Intended readers: researchers in differential privacy, probability, and information theory

## Abstract

Pujol and Desfontaines proposed a two-stage histogram mechanism that first adds Gaussian noise of fixed variance and then adds Gaussian noise with standard deviation proportional to the magnitude of the first output. Its scalar law is
$Q_x=\mathcal L((x+\sigma Z)(1+rW))$, with independent standard normal $Z,W$. A previous research case established a nonvanishing all-orders privacy floor and the exact large-count limit in the direction from a larger count to a smaller one. The opposite direction, and hence the optimal bidirectional zero-concentrated differential privacy (zCDP) budget, remained unresolved.

We prove that the reverse all-orders coefficient tends to zero. The proof controls every real Rényi order simultaneously, including arbitrarily large orders: it separates the mixing Gaussian into a regular part and an exponentially small central remainder, bounds the regular part by a widened Gaussian kernel, and controls the remainder by a uniform logarithmic-moment estimate. Combined with self-contained proofs of the previously established forward bound and tail lower bound, this gives

$$
\lim_{x\to\infty}\sup_{\alpha>1}\frac1\alpha
\max\{D_\alpha(Q_{x+h}\Vert Q_x),D_\alpha(Q_x\Vert Q_{x+h})\}
=\frac{h^2}{4\sigma^2}.
$$

For unit adjacency, the optimal budget therefore approaches exactly one half of the original Gaussian budget. We also construct an explicit nonincreasing count-only budget and give exact rational certificates for finite count thresholds at two parameter choices. The result concerns the original untruncated mechanism. We do not determine its exact optimum at every finite count, the sharp reverse convergence rate, or the full utility-constrained mechanism-design problem. This manuscript has not undergone external peer review or proof-assistant certification.

## 1. Problem, prior results, and the contribution here

Let

$$
Y_x=(x+\sigma Z)(1+rW),\qquad
Z,W\overset{\mathrm{iid}}\sim N(0,1),\quad \sigma,r>0.
\tag{1.1}
$$

Conditional on $X=x+\sigma Z$, the output has law $N(X,r^2X^2)$. Thus (1.1) is exactly Algorithm 1 of Pujol–Desfontaines [PD23], including negative first-stage outputs and both signs of the multiplicative Gaussian. Nothing is clipped, truncated, or conditioned away. For unit add-or-remove adjacency, releasing $x+\sigma Z$ alone satisfies zCDP with budget

$$
\rho=\frac1{2\sigma^2}.
\tag{1.2}
$$

Post-processing gives the same upper bound for (1.1) [BS16]. The original question asks whether the extra randomization gives a smaller privacy budget for larger counts, or whether another mechanism can achieve that goal.

Azize [A23] already identified the product-normal law and wrote the associated Rényi integral. The representation is therefore an established input. Fitzsimons [F26] addresses the alternative-mechanism route through a shifted-log Gaussian construction, under an explicit repair of the utility requirement at count zero. That construction and its inverse-square privacy rate concern a different random mechanism. We retain (1.1) and analyze its all-orders privacy directly. Product-normal density asymptotics, including the logarithmic singularity at zero, also belong to established distribution theory [GY24].

The earlier manuscript [Prev26] proved three results relevant here: a lower bound $\rho/2$ for every adjacent edge, convergence to zero at each fixed finite Rényi order, and convergence of the forward all-orders coefficient to $\rho/2$. It explicitly left the reverse all-orders supremum and the bidirectional optimum unresolved. The present contribution closes that gap and supplies a nonincreasing finite-count certificate. Sections 4 and 5 reproduce the needed earlier arguments, with attribution, so the new theorem does not depend on treating an unverified claim as a black box.

The distinction between fixed-order and all-orders control is essential. A finite list of Rényi orders can all show vanishing divergence while an unbounded sequence of orders retains a positive normalized privacy loss. The theorem below controls the supremum over all real $\alpha>1$ before taking the large-count limit.

All logarithms are natural. For positive densities $p,q$,

$$
D_\alpha(P\Vert Q)
=\frac1{\alpha-1}\log\int p(y)^\alpha q(y)^{1-\alpha}\,dy,
\qquad \alpha>1.
\tag{1.3}
$$

The inequalities used below imply finiteness in their stated ranges. We also use the standard monotonicity of $D_\alpha$ in its order and its data-processing property.

## 2. Main theorem and explicit bounds

Write

$$
P_{a,b}=\mathcal L((a+Z)(b+W)),\qquad a,b\in\mathbb R,
$$

and fix $b\in\mathbb R$, $d>0$. For $a>0$, define

$$
U_+(a)=\sup_{\alpha>1}\frac{D_\alpha(P_{a+d,b}\Vert P_{a,b})}{\alpha},
\quad
U_-(a)=\sup_{\alpha>1}\frac{D_\alpha(P_{a,b}\Vert P_{a+d,b})}{\alpha}.
\tag{2.1}
$$

The optimal bidirectional coefficient is
$V(a)=\max\{U_+(a),U_-(a)\}$. This equals the supremum of the pointwise maximum of the two normalized divergences, since there are only two directions.

Put

$$
A_0=\max\{2,d+1,b^2/d\},
\tag{2.2}
$$

$$
F_a=\frac{d^2}{4}+\frac{9d^2}{4(2a-1)}+\frac{b^2d^2}{2a},
\tag{2.3}
$$

$$
R_a=\frac{(4+b^2)d}{a}
+2\exp\!\left(\frac{b^2-a^2}{2}\right)
+64a\exp\!\left(\frac{3(1+b^2)}2-\frac{a^2}{8}\right).
\tag{2.4}
$$

**Theorem 1 (bidirectional all-orders asymptotic).** For every fixed $b\in\mathbb R$, $d>0$, and every $a\ge A_0$,

$$
U_-(a)\le R_a,\qquad U_+(a)\le F_a,
\tag{2.5}
$$

and

$$
\frac{d^2}{4}\le V(a)
\le\min\!\left\{\frac{d^2}{2},\max(F_a,R_a)\right\}.
\tag{2.6}
$$

Both $F_a$ and $R_a$ are nonincreasing on $[A_0,\infty)$. In particular,

$$
\boxed{\lim_{a\to\infty}U_-(a)=0,\qquad
\lim_{a\to\infty}U_+(a)=\lim_{a\to\infty}V(a)=d^2/4.}
\tag{2.7}
$$

The bound on $U_-$ is $O_{b,d}(1/a)$; we do not assert that this rate is sharp. The bound on $U_+$ and the lower bound were established in [Prev26]; they are rederived in Sections 4 and 5. The new uniform reverse estimate is proved next.

## 3. Uniform control of the reverse direction

Let $p=f_{a,b}$, $q=f_{a+d,b}$, where $f$ denotes a product-normal density. Let $\phi$ be the standard normal density. Conditional on the first factor $x\ne0$, the product has density

$$
k_x(y)=\frac1{|x|}\phi(y/x-b).
\tag{3.1}
$$

Thus $p(y)=\int\phi(x-a)k_x(y)\,dx$. Its value at $y=0$ may be infinite; every density inequality and integral below is understood almost everywhere.

### 3.1. Gaussian kernel comparison, including negative first factors

For normal densities with standard deviations $0<u<v$, completing the square gives

$$
\sup_y\frac{g_{\mu,u}(y)}{g_{\nu,v}(y)}
=\frac vu\exp\!\left(\frac{(\mu-\nu)^2}{2(v^2-u^2)}\right).
\tag{3.2}
$$

Split the integral defining $p$ into $x\ge a/2$, $x\le-a/2$, and $|x|<a/2$.

For $x=u\ge a/2$, compare to the denominator's mixing point $x'=u+d$. The mixing Gaussian densities agree:
$\phi(u-a)=\phi(x'-(a+d))$. The conditional means are $bu$ and $b(u+d)$, and their standard deviations are $u$ and $u+d$. Equation (3.2) therefore gives

$$
k_u(y)\le\left(1+\frac du\right)
\exp\!\left(\frac{b^2d}{2(2u+d)}\right)k_{u+d}(y)
\le K_a^+k_{u+d}(y),
\tag{3.3}
$$

where

$$
K_a^+=\left(1+\frac{2d}{a}\right)
\exp\!\left(\frac{b^2d}{2(a+d)}\right).
\tag{3.4}
$$

For the negative part, write $x=-u$, $u\ge a/2$, and reflect to the positive denominator point $u+d$. The mixing-density ratio is

$$
\frac{\phi(-u-a)}{\phi(u-a)}=e^{-2au}.
$$

The conditional means are now $-bu$ and $b(u+d)$. Consequently

$$
\frac{\phi(-u-a)k_{-u}(y)}{\phi(u-a)k_{u+d}(y)}
\le\left(1+\frac du\right)
\exp\!\left[-2au+\frac{b^2(2u+d)}{2d}\right].
\tag{3.5}
$$

Because $a\ge b^2/d$, the exponent is at most
$-au+b^2/2\le-a^2/2+b^2/2$. The negative contribution is therefore at most $K_a^-q(y)$, where

$$
K_a^-=\left(1+\frac{2d}{a}\right)
\exp\!\left(\frac{b^2-a^2}{2}\right).
\tag{3.6}
$$

The positive and reflected negative images overlap. Their constants must be added. Define $K_a=K_a^++K_a^-$; then their total contribution is at most $K_aq(y)$. In particular, $K_a\ge1$ and $K_a\to1$.

### 3.2. The central remainder and its logarithmic moments

Let $U$ be uniform on $[-1/2,1/2]$, independent of $W$, and let $H_a$ be the density of $aU(b+W)$. On $|x|<a/2$,
$\phi(x-a)\le\phi(a/2)$. Since the mixing density for $H_a$ is $1/a$ on that interval,

$$
p(y)\le K_aq(y)+\epsilon_a H_a(y),\qquad
\epsilon_a=\frac{a}{\sqrt{2\pi}}e^{-a^2/8}.
\tag{3.7}
$$

This is a density domination; the coefficients on the right need not sum to one.

Set $v=y/a$ and $\ell(v)=\log_+(1/|v|)$. Write $H_a(av)=h_b(v)/a$. Direct substitution in the uniform mixture gives

$$
h_b(v)=\frac1{\sqrt{2\pi}}\int_{2|v|}^\infty
\frac{e^{-(s-b)^2/2}+e^{-(s+b)^2/2}}s\,ds.
\tag{3.8}
$$

Using $(s\pm b)^2\ge s^2/2-b^2$, and then substituting $t=s^2/4$,

$$
h_b(v)\le\frac{e^{b^2/2}}{\sqrt{2\pi}}E_1(v^2)
\le C_0e^{-v^2}(1+\ell(v)),
\quad C_0=\frac{2e}{\sqrt{2\pi}}e^{b^2/2}.
\tag{3.9}
$$

Here $E_1(w)=\int_w^\infty e^{-t}dt/t$. For $0<|v|\le1$, use $E_1(v^2)\le2\ell(v)+1$ and $e^{-v^2}\ge e^{-1}$. For $|v|\ge1$, use $E_1(v^2)\le e^{-v^2}/v^2$. These prove the displayed global bound without an asymptotic approximation.

To bound the denominator below, restrict its positive mixing integral to $x\in[a+d,a+d+1]$. The condition $a\ge d+1$ ensures $a\le x\le2a$. Also $\phi(x-a-d)\ge\phi(1)$ and $|av/x-b|\le|v|+|b|$. Hence

$$
aq(av)\ge c_0e^{-v^2/2-|b||v|},
\qquad c_0=\frac{e^{-(1+b^2)/2}}{4\pi}.
\tag{3.10}
$$

For every real $\alpha\ge2$, combine (3.9) and (3.10) directly:

$$
\begin{aligned}
\int (H_a/q)^\alpha q
&=\int\frac{h_b(v)^\alpha}{(aq(av))^{\alpha-1}}\,dv\\
&\le C_0^\alpha c_0^{1-\alpha}e^{(\alpha-1)b^2/2}
\int e^{-v^2}(1+\ell(v))^\alpha\,dv.
\end{aligned}
\tag{3.11}
$$

In the exponent we used $|b||v|\le(v^2+b^2)/2$: its $v^2$ terms leave exactly the factor $e^{-v^2}$.

The remaining integral is bounded by

$$
\begin{aligned}
J_\alpha
&\le 2\int_0^\infty(1+s)^\alpha e^{-s}\,ds+\sqrt\pi\\
&\le(2e+\sqrt\pi)\Gamma(\alpha+1).
\end{aligned}
\tag{3.12}
$$

For completeness, $\Gamma(\alpha+1)\ge1$ follows by Jensen's inequality for the $\alpha$-th moment of a mean-one exponential random variable. If $n=\lceil\alpha\rceil$, monotonicity of probability $L^p$ norms and the arithmetic–geometric mean inequality give

$$
\Gamma(\alpha+1)^{1/\alpha}
\le(n!)^{1/n}\le(n+1)/2\le\alpha\qquad(\alpha\ge2).
$$

Thus $J_\alpha^{1/\alpha}\le4\alpha$. Since $c_0<1$, (3.11) yields the uniform estimate

$$
\|H_a/q\|_{L^\alpha(q)}\le C\alpha,
\qquad
C=\frac{4C_0e^{b^2/2}}{c_0}
=16\sqrt{2\pi}\,e^{3(1+b^2)/2}.
\tag{3.13}
$$

The constant is independent of $a$, $d$, and $\alpha$. Its dependence on the fixed second-factor mean $b$ is explicit. It is deliberately conservative.

### 3.3. All Rényi orders and the explicit reverse bound

Minkowski's inequality applied to (3.7) and (3.13) gives

$$
\left(\int p^\alpha q^{1-\alpha}\right)^{1/\alpha}
\le K_a+C\epsilon_a\alpha\qquad(\alpha\ge2).
$$

Therefore

$$
\frac{D_\alpha(p\Vert q)}\alpha
\le\frac{\log(K_a+C\epsilon_a\alpha)}{\alpha-1}
\le\log K_a+2C\epsilon_a\qquad(\alpha\ge2).
\tag{3.14}
$$

Here we used $K_a\ge1$, $\log(1+t)\le t$, and $\alpha/(\alpha-1)\le2$. For $1<\alpha<2$, monotonicity in the order implies

$$
\frac{D_\alpha(p\Vert q)}\alpha
\le D_2(p\Vert q)
\le2\log(K_a+2C\epsilon_a)
\le2\log K_a+4C\epsilon_a.
\tag{3.15}
$$

Thus $U_-(a)\le2\log K_a+4C\epsilon_a$. Finally,

$$
\begin{aligned}
2\log K_a
&\le\frac{(4+b^2)d}{a}
+2e^{(b^2-a^2)/2},\\
4C\epsilon_a
&=64a e^{3(1+b^2)/2-a^2/8}.
\end{aligned}
$$

For the first line, factor $K_a^+$ out of $K_a$ and use $\log(1+t)\le t$, together with $a+d\ge a$. This proves $U_-(a)\le R_a$, uniformly over every real order greater than one. No order cutoff depends on $a$.

## 4. The forward all-orders bound, reproduced from the earlier case

This section restates and proves the Gaussian-lift method of [Prev26]. Fix $\alpha>1$ and $t>0$, and define

$$
\Delta_1=1+\alpha(t^2-1),\qquad
\Delta_2=1+\alpha(t^{-2}-1).
$$

The independent pair with laws $N(at,t^2)$ and $N(b/t,t^{-2})$ has product law $P_{a,b}$. Comparing it to $N(a+d,1)\otimes N(b,1)$ and applying data processing under multiplication gives, whenever $\Delta_1,\Delta_2>0$,

$$
\frac{D_\alpha(P_{a+d,b}\Vert P_{a,b})}{\alpha}
\le\frac{(a+d-at)^2}{2\Delta_1}
+\frac{b^2(1-t^{-1})^2}{2\Delta_2}
-\frac{\log(\Delta_1\Delta_2)}{2\alpha(\alpha-1)}.
\tag{4.1}
$$

Indeed, completing the square in the one-dimensional normal integral yields

$$
D_\alpha(N(\mu,1)\Vert N(\nu,v))
=\frac{\alpha(\mu-\nu)^2}{2(\alpha v+1-\alpha)}
+\frac{\alpha\log v-\log(\alpha v+1-\alpha)}{2(\alpha-1)}.
$$

The two variance logarithms cancel in the product comparison, proving (4.1). Moreover,

$$
\Delta_1\Delta_2
=1-\alpha(\alpha-1)(t-t^{-1})^2.
\tag{4.2}
$$

Choose $0<\kappa<1$, put $\lambda=1-\kappa$, and let

$$
t=\min\{1+d/a,\sqrt{1+\lambda/\alpha}\}.
\tag{4.3}
$$

Then $\Delta_2\ge\kappa$ and
$\Delta_1\Delta_2\ge\kappa(2-\kappa)$. To verify the latter, the product in (4.2) decreases with $t\ge1$, and its value at the upper permitted endpoint is

$$
(1+\lambda)\frac{\alpha\kappa+\lambda}{\alpha+\lambda}
\ge\kappa(2-\kappa).
$$

If the first branch of (4.3) is active, the first mean difference in (4.1) vanishes. If the second is active, $\Delta_1=2-\kappa$ and $0\le a+d-at\le d$. The first term is therefore at most $d^2/[2(2-\kappa)]$. The second is at most $b^2d^2/(2\kappa a^2)$, since $0\le1-t^{-1}\le t-1\le d/a$.

For the last term let $z=\alpha(\alpha-1)(t-t^{-1})^2$. Then $0\le z<1$ and $-\log(1-z)\le z/(1-z)$. Since $t-t^{-1}\le2(t-1)\le2d/a$, that term is at most
$2d^2/[\kappa(2-\kappa)a^2]$. Consequently, simultaneously for all $\alpha>1$,

$$
U_+(a)\le\frac{d^2}{2(2-\kappa)}
+\frac{d^2}{a^2}\left[\frac{b^2}{2\kappa}+\frac{2}{\kappa(2-\kappa)}\right].
\tag{4.4}
$$

For $a\ge2$, choose $\kappa=1/a$. Exact simplification gives

$$
\frac{d^2a}{2(2a-1)}+\frac{2d^2}{2a-1}+\frac{b^2d^2}{2a}
=\frac{d^2}{4}+\frac{9d^2}{4(2a-1)}+\frac{b^2d^2}{2a}=F_a.
$$

This proves the forward upper bound in Theorem 1.

## 5. The nonvanishing lower bound, with a self-contained tail argument

The tail method below reproduces the relevant part of [Prev26]; the underlying product-normal asymptotics are established in [GY24]. We use explicit inequalities so that no interchange of an unbounded integral and a pointwise asymptotic is required.

For arbitrary $u,b\in\mathbb R$, let
$A(u,b)=(u^2+b^2)/2+|u|+|b|+3$. For $s\in\{-1,+1\}$, $z\ge1$,

$$
e^{-A(u,b)}z^{-1/2}e^{-z+|u+sb|\sqrt z}
\le f_{u,b}(sz)
\le z^{-1/2}e^{-z+|u+sb|\sqrt z}.
\tag{5.1}
$$

Here is a direct proof. Rotate the independent normals to
$S=((u+Z)+(b+W))/\sqrt2$, $T=((u+Z)-(b+W))/\sqrt2$, whose respective means are $m=(u+b)/\sqrt2$ and $n=(u-b)/\sqrt2$. The product is $(S^2-T^2)/2$. Conditioning on $T=t$ and adding the two inverse images of $S$ gives, for $z>0$,

$$
f_{u,b}(z)=\frac{e^{-z-(m^2+n^2)/2}}\pi
\int_{\mathbb R}\frac{e^{-t^2+nt}\cosh(m\sqrt{2z+t^2})}{\sqrt{2z+t^2}}\,dt.
\tag{5.2}
$$

For the upper bound use $\cosh w\le e^{|w|}$,
$\sqrt{2z+t^2}\le\sqrt{2z}+|t|$, and denominator at least $\sqrt{2z}$. With $k=|m|+|n|=\sqrt2\max(|u|,|b|)$, the remaining integral is at most $2\sqrt\pi e^{k^2/4}$. The resulting constant is $\sqrt{2/\pi}e^{-\min(u^2,b^2)/2}\le1$.

For the lower bound restrict $t$ to $[-1,1]$. Use $\cosh w\ge e^{|w|}/2$, denominator at most $\sqrt{3z}$, and $e^{-t^2+nt}\ge e^{-1-|n|}$. The constant is at least $e^{-(u^2+b^2)/2-1-|n|}/(\pi\sqrt3)\ge e^{-A(u,b)}$. Interchanging $S$ and $T$ proves the negative-tail bound. This proves (5.1).

For $a\ge0$, choose $s$ so that $sb=|b|$. Then the difference of tail coefficients between $P_{a+d,b}$ and $P_{a,b}$ is exactly $d$. Applying the lower bound to the numerator density and the upper bound to the denominator density,

$$
\int f_{a+d,b}^\alpha f_{a,b}^{1-\alpha}
\ge e^{-\alpha A(a+d,b)}
\int_1^\infty z^{-1/2}e^{-z+(a+|b|+\alpha d)\sqrt z}\,dz.
\tag{5.3}
$$

Put $c_\alpha=a+|b|+\alpha d$ and substitute $w=\sqrt z$. Completing the square turns the integral into

$$
2e^{c_\alpha^2/4}\int_{1-c_\alpha/2}^\infty e^{-t^2}\,dt.
$$

The last integral tends to $\sqrt\pi$. Dividing the logarithm of (5.3) by $\alpha(\alpha-1)$ therefore yields

$$
\liminf_{\alpha\to\infty}
\frac{D_\alpha(P_{a+d,b}\Vert P_{a,b})}{\alpha}\ge d^2/4.
\tag{5.4}
$$

In particular $U_+(a)\ge d^2/4$. The opposite universal upper bound $d^2/2$ for both directions follows by comparing $N(a,1)$ and $N(a+d,1)$, adjoining the same independent second factor, and applying multiplication as post-processing. Equations (3.14)–(3.15), (4.4), and (5.4) prove (2.6) and the limits (2.7).

To verify monotonicity, the nonconstant terms of $F_a$ decrease for $a>1/2$. The first two terms of $R_a$ decrease for $a>0$, while

$$
\frac d{da}\left(ae^{-a^2/8}\right)=e^{-a^2/8}(1-a^2/4)\le0
\quad\text{for }a\ge2.
$$

This proves the remaining assertion of Theorem 1.

## 6. A nonincreasing budget for the original count mechanism

Multiplication by the common nonzero factor $\sigma r$ is a measurable bijection, so it preserves Rényi divergence. In (1.1), use

$$
a=x/\sigma,\qquad b=1/r,\qquad d=h/\sigma.
$$

Theorem 1 gives the exact asymptotic coefficient stated in the abstract. For unit adjacency, take $d=1/\sigma$, $b=1/r$, $\rho=d^2/2$, and let $A_0$, $F$, $R$ have these parameters.

Define $v(0)=\rho$. For integers $n\ge1$, let $a_n=(n-1)/\sigma$ and set

$$
v(n)=
\begin{cases}
\rho,&a_n<A_0,\\
\min\{\rho,\max(F_{a_n},R_{a_n})\},&a_n\ge A_0.
\end{cases}
\tag{6.1}
$$

**Corollary 2 (count-only all-orders certificate).** The sequence $v$ is nonincreasing, and for every $n\ge1$ and every $\alpha>1$,

$$
\max\{D_\alpha(Q_n\Vert Q_{n-1}),D_\alpha(Q_{n-1}\Vert Q_n)\}
\le\alpha v(n).
\tag{6.2}
$$

Moreover $v(n)\to\rho/2$, and no valid budget on these edges can have a limit inferior below $\rho/2$.

**Proof.** For $a_n<A_0$, use the initial Gaussian post-processing bound. Otherwise use (2.6). Monotonicity follows from that of $F$ and $R$, including the transition from the constant prefix $\rho$. The lower bound and limit follow from Theorem 1. On the edge $n\leftrightarrow n+1$, (6.2) uses $v(n+1)\le v(n)$. Thus it satisfies the original ordered-pair definition at either endpoint; no adjacency endpoint has been dropped. For independently released histogram coordinates, the unchanged factors cancel from the likelihood ratio, so the scalar proof applies to a change in one group. $\square$

Equation (6.1) supplies a strict improvement for all sufficiently large counts for every fixed $\sigma,r>0$. Its constants are not optimized. In particular, a sufficient threshold from this expression need not be the first count at which the actual optimal privacy budget improves.

### 6.1. Exact finite certificates

The accompanying standard-library program evaluates (2.3)–(2.4) with rational arithmetic. For $t\ge0$, it uses the rigorous inequality

$$
e^{-t}\le\left(\sum_{j=0}^{32}\frac{t^j}{j!}\right)^{-1}.
\tag{6.3}
$$

The table shows decimal upper bounds rounded upward from rational certificates. Each bound covers both directions and every real Rényi order.

| Parameters | Larger edge count $n$ | Initial $\rho$ | Certified $\max(F,R)$ upper bound | Exact limiting optimum |
| --- | ---: | ---: | ---: | ---: |
| $\sigma=1,r=1$ | 12 | 0.5 | 0.458362719521 | 0.25 |
| $\sigma=10,r=3/10$ | 3024 | 0.005 | 0.004998713567 | 0.0025 |

At the preceding larger count in each row, the first term of $R$ alone is at least $\rho$. By monotonicity, these are the first integer-count strict-improvement gates for the displayed sufficient $F/R$ certificate. They are not claims about the unknown exact finite-count optimum. Since the certified budget is nonincreasing, each displayed improvement persists at all larger counts.

The program also verifies 200 finite rational quadratic-completion identities for the two Gaussian-kernel comparisons, 120 exact substitutions in the forward-bound simplification, and one cleared polynomial identity. These checks validate specified finite computations. The general theorem is supported by the analytic proof above, not by numerical coverage or sampling of Rényi orders.

## 7. Scope and remaining questions

The new conclusion is the reverse all-orders limit and the resulting exact bidirectional asymptotic coefficient for the unchanged Gaussian-product mechanism. Together with the explicit count-only certificate, it establishes a bounded-factor privacy improvement along the original-mechanism route of [PD23]. The factor one half refers to the zCDP budget; it is not a claim that an operational disclosure risk has literally halved.

The exact bidirectional optimum at a finite count remains undetermined. The reverse estimate is a uniform $O(1/a)$ upper bound, not a sharp asymptotic expansion. No uniform assertion is made when $r$, $\sigma$, or the adjacency size varies with the count. The proof does not analyze a clipped or truncated variant, nor does it repair the original relative-error requirement at count zero or optimize utility over alternative mechanisms. Those are separate questions.

The certificate uses only the Python standard library and rational arithmetic. There is no Lean or other end-to-end formal certification. The computation programs and raw outputs are not included in this version. The manuscript has not undergone external peer review and does not claim global priority.

## References

- **[PD23]** David Pujol and Damien Desfontaines. *Open problem — Better privacy guarantees for larger groups*. 26 June 2023. Original problem statement and Algorithm 1. https://differentialprivacy.org/open-problem-better-privacy-guarantees-for-larger-groups/
- **[A23]** Achraf Azize. *Open problem — Better privacy guarantees for larger groups*. Author-hosted research note, 2023, Section 2.2. https://achraf-azize.github.io/Open_problem_Better_privacy_guarantees_for_larger_groups.pdf
- **[F26]** Jack Fitzsimons. *Better Privacy Guarantees for Larger Groups*. Manuscript dated 15 July 2026; arXiv:2607.14406. https://arxiv.org/abs/2607.14406 . The compared manuscript was accessed through its full-text mirror; the comparison is limited to the accessed version.
- **[BS16]** Mark Bun and Thomas Steinke. *Concentrated Differential Privacy: Simplifications, Extensions, and Lower Bounds*. TCC 2016-B. DOI: 10.1007/978-3-662-53641-4_24. https://privacytools.seas.harvard.edu/sites/g/files/omnuum6656/files/privacytools/files/simp.pdf
- **[GY24]** Robert E. Gaunt and Zixin Ye. *Asymptotic approximations for the distribution of the product of correlated normal random variables*. Versioned manuscript arXiv:2309.07734v2; DOI: 10.1016/j.jmaa.2024.128987. https://arxiv.org/html/2309.07734v2
- **[Prev26]** *A nonvanishing privacy floor for Gaussian-product post-processing*. Research manuscript, 24 November 2026. Sections 3, 5, and 8 give the tail lower bound and forward all-orders bound reused here. [Companion manuscript](../gaussian-product-privacy-floor/paper.en.md).
