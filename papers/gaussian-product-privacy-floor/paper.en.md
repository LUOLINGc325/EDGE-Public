# A nonvanishing privacy floor for Gaussian-product post-processing

AI-assisted research draft · 2026-11-24  
Target readers: doctoral researchers and specialists in differential privacy and information theory

## Abstract

Consider the proposed count mechanism $Y_x=(x+\sigma Z)(1+rW)$, where $Z,W$ are independent standard normals and $\sigma,r>0$. We determine the exact high-order Rényi-divergence limit between any two product-normal laws with a common second mean. For every $x\ge0$ and $h>0$, the outward direction satisfies $D_\alpha(\mathcal L(Y_{x+h})\Vert\mathcal L(Y_x))/\alpha\to h^2/(4\sigma^2)$. The reverse limit is explicitly direction dependent and may be zero. Thus no bidirectional, all-orders zCDP budget for unit changes can be smaller than half the initial Gaussian budget, regardless of group size. Nevertheless, both divergences tend to zero at every fixed finite order as $x\to\infty$. The large-count and high-order limits therefore do not commute. A product-preserving Gaussian comparison also proves that the outward all-orders optimum tends exactly to $h^2/(4\sigma^2)$, with an explicit uniform bound. Finally, elementary density inequalities yield finite-order lower certificates computable using only rational arithmetic. The exact bidirectional all-orders optimum remains undetermined. The analysis concerns the original mechanism, not the already studied alternative mechanisms with inverse-square count dependence.

All logarithms are natural. Proofs are analytical; finite computations provide additional checks and explicit certificates. This is a public research draft, not an externally peer-reviewed result.

## 1. Problem and scope

Pujol and Desfontaines [1] propose adding Gaussian noise to a count and then adding independent centered Gaussian noise whose standard deviation is proportional to the absolute value of that first noisy count. For one affected histogram cell this is exactly

$$
Y_x=(x+\sigma Z)(1+rW),\qquad Z,W\overset{\mathrm{iid}}\sim N(0,1),\quad \sigma,r>0.
$$

The conditional law of this expression given $X=x+\sigma Z$ is $N(X,r^2X^2)$, including negative values of $X$. The sign of the multiplier is unrestricted. The original mechanism is therefore preserved without truncation or a positivity assumption on either Gaussian factor.

For two neighboring outputs with laws $P,Q$, an edgewise zCDP budget $v$ means that $\max\{D_\alpha(P\Vert Q),D_\alpha(Q\Vert P)\}\le\alpha v$ for every real $\alpha>1$. The initial Gaussian release has budget $\rho=1/(2\sigma^2)$ for unit changes. Post-processing immediately gives the same budget for $Y_x$ [4]. The question is how much stronger a count-dependent budget can be after the second noise stage.

The precise contribution here is an exact all-parameter limit at high Rényi order, together with a sharp outward all-orders limit at large counts. It implies that every valid two-direction, all-orders zCDP budget for this mechanism is at least $\rho/2$, at every count. In particular its zCDP budget cannot tend to zero as group size grows. This does not exclude a bounded-factor improvement below $\rho$.

The mechanism's identification as a product of two normals is not new. Azize [2, Section 2.2] already gave this representation, a Bessel-function density, and the corresponding Rényi integral, leaving its upper-bound analysis unfinished. Fitzsimons [3] studies a different construction and establishes an optimal inverse-square count rate under an explicit repair of the zero-count utility condition; that manuscript expressly separates its alternative construction from the original randomized mechanism. Product-normal tail and near-zero asymptotics are also established distribution theory, notably Gaunt and Ye [5]. We give short specialized proofs and explicit constants to support the privacy limits and reproducible certificates. We do not claim the density theory, the product identification, or the inverse-square alternative as new.

The original problem has a separate utility issue at count zero. None of our conclusions use that issue: the privacy floor holds on every positive-count edge, and even for all real $x\ge0$. Nor do we infer an exact zCDP parameter from its high-order limit. A supremum over all orders must be controlled separately, which we accomplish in the outward direction only.

## 2. General theorem

Let $P_{a,b}$ be the law of $(a+Z)(b+W)$ for independent standard normals. For $s\in\{+1,-1\}$, put

$$
L_s(a,b)=|a+s b|,\qquad
\Delta_s(a,c;b)=L_s(a,b)-L_s(c,b).
$$

For $u\in\mathbb R$, write $u_+=\max(u,0)$.

**Theorem 1.** For every fixed $a,c,b\in\mathbb R$, all finite-order Rényi divergences between $P_{a,b}$ and $P_{c,b}$ are finite and

$$
\boxed{
\lim_{\alpha\to\infty}\frac{D_\alpha(P_{a,b}\Vert P_{c,b})}{\alpha}
=\frac14\max\{(\Delta_+(a,c;b))_+^2,(\Delta_-(a,c;b))_+^2\}.
}
$$

Here $D_\alpha(P\Vert Q)=(\alpha-1)^{-1}\log\int p^\alpha q^{1-\alpha}$, for $\alpha>1$.

The same assertion holds if both products are multiplied by the same nonzero deterministic scalar, since Rényi divergence is invariant under an invertible measurable change of coordinates.

## 3. Product-normal density at infinity

Let $f_{a,b}$ denote the product density. It is positive for every nonzero argument. Introduce independent normal variables

$$
S=\frac{(a+Z)+(b+W)}{\sqrt2}\sim N(m,1),\quad
T=\frac{(a+Z)-(b+W)}{\sqrt2}\sim N(n,1),
$$

where $m=(a+b)/\sqrt2$, $n=(a-b)/\sqrt2$. Then the product is $(S^2-T^2)/2$.

For $z>0$, conditioning on $T=t$ and taking the two roots in $S$ gives

$$
f_{a,b}(z)
=\frac{e^{-z-(m^2+n^2)/2}}{\pi}
\int_{\mathbb R}
\frac{e^{-t^2+nt}\cosh\big(m\sqrt{2z+t^2}\big)}{\sqrt{2z+t^2}}\,dt.
\tag{3.1}
$$

The factor $1/\sqrt{2z+t^2}$ is the absolute Jacobian of either root $S=\pm\sqrt{2z+t^2}$ with respect to $z$. The two normal densities supply the factor $1/(2\pi)$, and their sum supplies $2\cosh$.

**Lemma 2 (explicit tail bounds).** Put

$$
A(a,b)=\frac{a^2+b^2}{2}+|a|+|b|+3.
$$

For every $a,b\in\mathbb R$, $s\in\{-1,+1\}$, and $z\ge1$,

$$
e^{-A(a,b)}z^{-1/2}e^{-z+L_s(a,b)\sqrt z}
\le f_{a,b}(s z)
\le z^{-1/2}e^{-z+L_s(a,b)\sqrt z}.
\tag{3.2}
$$

**Proof.** For the positive tail, use

$$
\tfrac12 e^{|m|\sqrt{2z+t^2}}
\le\cosh(m\sqrt{2z+t^2})
\le e^{|m|\sqrt{2z+t^2}}.
$$

For the upper bound, $\sqrt{2z+t^2}\le\sqrt{2z}+|t|$ and $\sqrt{2z+t^2}\ge\sqrt{2z}$. Thus the integral in (3.1) is at most

$$
(2z)^{-1/2}e^{|m|\sqrt{2z}}
\int_{\mathbb R}e^{-t^2+nt+|m||t|}\,dt.
$$

Let $k=|m|+|n|=\sqrt2\max(|a|,|b|)$. By splitting the integral at zero and completing the square,

$$
\int_{\mathbb R}e^{-t^2+nt+|m||t|}dt
\le 2\sqrt\pi e^{k^2/4}.
$$

The resulting upper prefactor is at most
$\sqrt{2/\pi}\,e^{-\min(a^2,b^2)/2}\le1$.
For the lower bound restrict the integral to $[-1,1]$, use $\sqrt{2z+t^2}\le\sqrt{3z}$, and use $\cosh\ge\tfrac12 e^{|m|\sqrt{2z}}$. The prefactor is at least

$$
\frac{e^{-(a^2+b^2)/2-1-|n|}}{\pi\sqrt3}\ge e^{-A(a,b)},
$$

since $|n|\le |a|+|b|$ and $\log(\pi\sqrt3)<2$. Since $|m|\sqrt{2z}=|a+b|\sqrt z$, these are the positive-tail bounds. For the negative tail, interchange $S$ and $T$, so the coefficient becomes $|a-b|$; the same estimates and the same $A(a,b)$ apply. $\square$

The two-sided inequalities, rather than an unquantified asymptotic expansion, are what is used in the Rényi proof. Their constants may depend on the fixed means, but never on $z$ or $\alpha$.

## 4. The logarithmic singularity at zero

The density is generally infinite at the single point zero. This does not produce an infinite divergence: its singularity is of the same order for all means.

**Lemma 3.** As $z\to0$, from either side,

$$
f_{a,b}(z)=\frac{e^{-(a^2+b^2)/2}}{\pi}\log\frac1{|z|}+O_{a,b}(1).
\tag{4.1}
$$

Consequently, for fixed $a,c,b$, both $f_{a,b}/f_{c,b}$ and its reciprocal are essentially bounded on every compact interval.

**Proof.** Direct conditioning on the first normal factor gives

$$
f_{a,b}(z)=\frac{e^{-(a^2+b^2)/2}}{2\pi}
\int_{\mathbb R}\frac1{|u|}
\exp\left(-\frac{u^2}2-\frac{z^2}{2u^2}+au+\frac{bz}{u}\right)du.
\tag{4.2}
$$

Put $v=|z|\in(0,1)$. On each of the two intervals $v\le|u|\le1$, the exponent $E(u,z)$ has bounded absolute value and

$$
|E(u,z)|\le C_{a,b}\left(|u|+\frac v{|u|}\right).
$$

The mean-value bound for the exponential therefore yields

$$
\int_{v\le|u|\le1}\frac{e^{E(u,z)}}{|u|}du
=2\log(1/v)+O_{a,b}(1),
$$

because the integral of the error is at most a fixed constant times
$2\int_v^1(1+v/u^2)du\le4$.

The integral over $|u|\ge1$ is uniformly bounded for $0<v<1$: the terms involving $z/u$ are bounded, while $-u^2/2+au$ gives an integrable Gaussian tail after division by $|u|$. For $|u|\le v$, change variables $w=z/u$. This maps the region to $|w|\ge1$, preserves $du/|u|=|dw|/|w|$, and exchanges the two factors, giving the same bound. Substituting into (4.2) proves (4.1).

Away from zero the integral defines a strictly positive continuous density, by dominated convergence on compact subsets not containing zero. Equation (4.1) shows that its ratio to another such density tends to the positive finite constant $e^{(c^2-a^2)/2}$. Compactness gives the asserted ratio bounds. $\square$

## 5. A general Rényi tail principle

**Lemma 4.** Suppose positive densities $p,q$ have mutually bounded ratios on compact intervals, and for $s=\pm1$, $z\ge1$, each is bounded above and below by positive constant multiples of

$$
z^{-1/2}e^{-z+L_s\sqrt z}
$$

with coefficients $L_s^p,L_s^q$, respectively. Then

$$
\lim_{\alpha\to\infty}\alpha^{-2}\log\int p^\alpha q^{1-\alpha}
=\frac14\max_{s=\pm1}(L_s^p-L_s^q)_+^2.
\tag{5.1}
$$

**Proof.** On the compact interval $[-1,1]$, let $p/q\le M$. Its contribution is at most $M^{\alpha-1}\int_{-1}^1p\le M^{\alpha-1}$, whose logarithm is $O(\alpha)$.

On tail $s$, the upper and lower density bounds imply that the tail contribution is between positive factors whose logarithms are $O(\alpha)$ times

$$
J(c_{\alpha,s})=\int_1^\infty z^{-1/2}e^{-z+c_{\alpha,s}\sqrt z}\,dz
=2\int_1^\infty e^{-u^2+c_{\alpha,s}u}\,du,
$$

where

$$
c_{\alpha,s}=\alpha L_s^p+(1-\alpha)L_s^q
=L_s^q+\alpha\Delta_s,\qquad \Delta_s=L_s^p-L_s^q.
$$

If $\Delta_s>0$, completing the square gives

$$
J(c_{\alpha,s})=2e^{c_{\alpha,s}^2/4}
\int_{1-c_{\alpha,s}/2}^\infty e^{-v^2}dv,
$$

and the integral tends to $\sqrt\pi$. Hence $\alpha^{-2}\log J\to\Delta_s^2/4$.

If $\Delta_s=0$, $J$ is a fixed positive constant. If $\Delta_s<0$, then for all large $\alpha$, $c_{\alpha,s}\le0$, so $J\le2\int_1^\infty e^{-u^2}du$. For a lower exponential bound, restrict to $1\le u\le2$, where $-u^2+c_{\alpha,s}u\ge-4+2c_{\alpha,s}$; hence $\log J=O(\alpha)$ from below as well. In both nonpositive cases the scaled logarithm tends to zero.

The logarithm of a sum of three nonnegative contributions has limiting $\alpha^2$-rate equal to the largest of their rates. If all tail differences are nonpositive, the upper bound gives limsup zero, and Hölder's inequality $\int p^\alpha q^{1-\alpha}\ge1$ gives liminf zero. All integrals at finite $\alpha$ are finite by the same bounds. $\square$

Applying Lemmas 2 and 3 in Lemma 4 proves Theorem 1, because $\alpha(\alpha-1)/\alpha^2\to1$.

## 6. Exact application to the proposed privacy mechanism

Let $Q_x=\mathcal L(Y_x)$, $x\ge0$, and take any fixed upward shift $h>0$. Standardizing gives

$$
Y_x=\sigma r(a+Z)(b+W),\qquad
a=\frac x\sigma,\ b=\frac1r,\ d=\frac h\sigma.
$$

For the upward direction, the positive-tail difference is
$(a+d+b)-(a+b)=d$, while the absolute value inequality gives
$|a+d-b|-|a-b|\le d$. Therefore

$$
\boxed{\lim_{\alpha\to\infty}\frac{D_\alpha(Q_{x+h}\Vert Q_x)}{\alpha}
=\frac{h^2}{4\sigma^2}.}
\tag{6.1}
$$

For the downward direction the positive-tail difference is $-d$; only the negative tail can contribute a positive coefficient. Thus

$$
\boxed{\lim_{\alpha\to\infty}\frac{D_\alpha(Q_x\Vert Q_{x+h})}{\alpha}
=\frac14\left(\left|\frac x\sigma-\frac1r\right|
-\left|\frac{x+h}\sigma-\frac1r\right|\right)_+^2.}
\tag{6.2}
$$

This second expression is generally not equal to (6.1). To make its regimes explicit, set $\tau=\sigma/r$. It equals

$$
\begin{cases}
h^2/(4\sigma^2), & x+h\le\tau,\\
(2\tau-2x-h)_+^2/(4\sigma^2), & x<\tau<x+h,\\
0, & x\ge\tau.
\end{cases}
\tag{6.3}
$$

The formulas agree at the omitted equality boundaries. In fact the downward limit is already zero whenever $x\ge\tau-h/2$, including part of the middle regime. In that regime the downward likelihood ratio is globally bounded: both tail coefficients for the numerator are no greater than those for the denominator, and Lemmas 2 and 3 cover the tails and compact region.

**Corollary 5 (nonvanishing privacy floor).** For addition/removal adjacency $h=1$, any budget $v$ that bounds both divergence directions at every order by $\alpha v$ on the edge $x\leftrightarrow x+1$ must satisfy

$$
v\ge\frac1{4\sigma^2}=\frac\rho2.
$$

Consequently, for all $x\ge0$, the optimal edgewise zCDP parameter $v_*(x)$ obeys

$$
\frac\rho2\le v_*(x)\le\rho.
\tag{6.4}
$$

The upper bound is the standard post-processing bound for the initial Gaussian mechanism. The lower bound follows from (6.1). These bounds do not identify $v_*(x)$, nor prove that it converges to either endpoint as $x\to\infty$.

For independent histogram coordinates, unchanged coordinates have the same output law and cancel from the likelihood ratio. Thus the one-dimensional edgewise result is exactly the result for the full independent-coordinate mechanism under a change to a single group.

## 7. A Gaussian comparison and fixed-order privacy

The high-order floor is compatible with vanishing divergence at every fixed order. We establish this using a finite-parameter upper bound, avoiding any inference from weak convergence.

**Lemma 6 (product-preserving Gaussian lift).** Fix $a,c,b\in\mathbb R$ and $\alpha>1$. For $t>0$, define

$$
\Delta_1=1+\alpha(t^2-1),\qquad
\Delta_2=1+\alpha(t^{-2}-1).
$$

Whenever both quantities are positive,

$$
\frac{D_\alpha(P_{a,b}\Vert P_{c,b})}{\alpha}
\le \frac{(a-ct)^2}{2\Delta_1}
+\frac{b^2(1-1/t)^2}{2\Delta_2}
-\frac{\log(\Delta_1\Delta_2)}{2\alpha(\alpha-1)}.
\tag{7.1}
$$

**Proof.** The product of independent variables distributed as $N(ct,t^2)$ and $N(b/t,t^{-2})$ has law $P_{c,b}$. Apply data processing under multiplication to this Gaussian pair and the pair $N(a,1)\otimes N(b,1)$. The divergence of an independent product is the sum of the coordinate divergences. Completing the square in the defining integral gives, for $v>0$ and $\alpha v+1-\alpha>0$,

$$
 D_\alpha(N(\mu,1)\Vert N(\nu,v))
 =\frac{\alpha(\mu-\nu)^2}{2(\alpha v+1-\alpha)}
 +\frac{\alpha\log v-\log(\alpha v+1-\alpha)}{2(\alpha-1)}.
$$

The two terms $\alpha\log(t^2)$ and $\alpha\log(t^{-2})$ cancel. This gives (7.1). In addition,

$$
\Delta_1\Delta_2=1-\alpha(\alpha-1)(t-1/t)^2.
\tag{7.2}
$$

The right side of (7.1) is the normalized divergence of the chosen Gaussian lift, not an asserted identity for the product-law divergence. $\square$

**Theorem 7 (vanishing at every fixed order).** Fix $\sigma,r,h>0$. For every fixed finite $\alpha>1$,

$$
\lim_{x\to\infty}D_\alpha(Q_{x+h}\Vert Q_x)
=\lim_{x\to\infty}D_\alpha(Q_x\Vert Q_{x+h})=0.
\tag{7.3}
$$

**Proof.** In the product model fix $b$ and a real shift $d$, put $a=c+d$, and let $c\to\infty$. For all sufficiently large $c$, choose $t=(c+d)/c>0$. Then $a-ct=0$ and both $\Delta_i\to1$, so the integrability conditions hold. Lemma 6 gives

$$
D_\alpha(P_{c+d,b}\Vert P_{c,b})
\le -\frac{\log[1-\alpha(\alpha-1)(t-1/t)^2]}{2(\alpha-1)}
+\frac{\alpha b^2(1-1/t)^2}{2[1+\alpha(t^{-2}-1)]}.
\tag{7.4}
$$

Both terms tend to zero. More explicitly, the right side has expansion

$$
\frac{\alpha(4+b^2)d^2}{2c^2}
+O_{\alpha,b,d}(c^{-3}).
\tag{7.5}
$$

This is an upper-bound expansion, not a claim that its coefficient is sharp for the divergence itself. The same argument with numerator mean $c$ and reference mean $c+d$, using $t=c/(c+d)$, gives the reverse limit. Substituting $c=x/\sigma$, $d=h/\sigma$, $b=1/r$ proves the result for the original mechanism. $\square$

**Corollary 8 (noncommuting limits).** Put

$$
H(x,\alpha)=\frac1\alpha\max\{D_\alpha(Q_{x+h}\Vert Q_x),D_\alpha(Q_x\Vert Q_{x+h})\}.
$$

Then

$$
\lim_{x\to\infty}\lim_{\alpha\to\infty}H(x,\alpha)
=\frac{h^2}{4\sigma^2},\qquad
\lim_{\alpha\to\infty}\lim_{x\to\infty}H(x,\alpha)=0.
\tag{7.6}
$$

Indeed, (6.1) and (6.2) give the first inner limit for every $x\ge0$, and Theorem 7 gives the other inner limit. For any fixed finite set of orders $\mathcal A\subset(1,\infty)$, $\max_{\alpha\in\mathcal A}H(x,\alpha)\to0$, while $\sup_{\alpha>1}H(x,\alpha)\ge h^2/(4\sigma^2)$ at every count. Thus a fixed finite order grid cannot establish vanishing zCDP for this mechanism. This statement concerns all-orders certification; it does not say finite-order RDP bounds are invalid.

## 8. A sharp outward all-orders limit

The previous theorem keeps the Rényi order fixed. We now give an upper bound that is uniform over every $\alpha>1$ in the outward direction.

**Theorem 9.** Let $b\in\mathbb R$, $c,d>0$, and $0<\kappa<1$. Then

$$
\sup_{\alpha>1}\frac{D_\alpha(P_{c+d,b}\Vert P_{c,b})}{\alpha}
\le \frac{d^2}{2(2-\kappa)}
+\frac{d^2}{c^2}\left[\frac{b^2}{2\kappa}
+\frac{2}{\kappa(2-\kappa)}\right].
\tag{8.1}
$$

Consequently,

$$
\lim_{c\to\infty}\sup_{\alpha>1}
\frac{D_\alpha(P_{c+d,b}\Vert P_{c,b})}{\alpha}
=\frac{d^2}{4}.
\tag{8.2}
$$

For the original mechanism, the right side is $h^2/(4\sigma^2)$ after substituting $c=x/\sigma$, $d=h/\sigma$, $b=1/r$.

**Proof.** Write $\lambda=1-\kappa$. For each order separately, choose the admissible lift

$$
t=\min\left(1+\frac dc,\sqrt{1+\frac\lambda\alpha}\right).
\tag{8.3}
$$

Then $t\ge1$ and

$$
\Delta_2\ge\frac{\alpha\kappa+\lambda}{\alpha+\lambda}\ge\kappa.
$$

The determinant in (7.2) decreases with $t\ge1$. At the upper cap in (8.3) it is

$$
(1+\lambda)\frac{\alpha\kappa+\lambda}{\alpha+\lambda}
\ge\kappa(2-\kappa).
\tag{8.4}
$$

Thus both Gaussian integrability conditions hold, uniformly over the order.
If $t=1+d/c$, the first numerator in (7.1) is zero. Otherwise $\Delta_1=2-\kappa$ and $0\le c+d-ct\le d$. In both cases the first term is at most $d^2/[2(2-\kappa)]$.
The second term is at most $b^2d^2/(2\kappa c^2)$, because $0\le1-1/t\le t-1\le d/c$.

For the determinant term put $z=\alpha(\alpha-1)(t-1/t)^2$. By (8.4), $0\le z<1$. Use $-\log(1-z)\le z/(1-z)$ and $t-1/t\le2(t-1)\le2d/c$ to obtain

$$
-\frac{\log(\Delta_1\Delta_2)}{2\alpha(\alpha-1)}
\le\frac{2d^2}{\kappa(2-\kappa)c^2}.
$$

Combining the three terms proves (8.1).
For all sufficiently large $c>|b|$, Theorem 1 gives a high-order limit of $d^2/4$, hence the supremum is at least this number. For each fixed $\kappa$, (8.1) gives a limiting upper bound $d^2/[2(2-\kappa)]$. Let $\kappa\downarrow0$ to prove (8.2). No supremum is interchanged with a limit. Choosing $\kappa=1/c$ for $c>1$ gives the explicit, generally nonsharp error bound $O_{b,d}(1/c)$. $\square$

Theorem 9 proves a one-direction optimum. It does not determine the reverse supremum, nor the maximum over both directions. The bidirectional bounds in (6.4) remain valid, but their limiting exact value is not established here.

## 9. Finite-order certificates using rational arithmetic

The high-order limit already gives a universal lower bound. The explicit constants in Lemma 2 additionally give lower bounds at specified finite orders without numerically integrating a rare tail.

**Proposition 10.** Fix $a,c,b\in\mathbb R$, $\alpha>1$, and $s\in\{-1,+1\}$. Define

$$
B=|c+s b|+\alpha\big(|a+s b|-|c+s b|\big).
$$

If $B\ge2$, then

$$
\frac{D_\alpha(P_{a,b}\Vert P_{c,b})}{\alpha}
\ge\max\left\{0,
\frac{B^2/4-1-\alpha A(a,b)}{\alpha(\alpha-1)}\right\},
\qquad
A(a,b)=\frac{a^2+b^2}{2}+|a|+|b|+3.
\tag{9.1}
$$

**Proof.** On the $s$ tail, raise the lower bound for $f_{a,b}$ to power $\alpha$ and the upper bound for $f_{c,b}$ to power $1-\alpha<0$. Their product is at least

$$
e^{-\alpha A(a,b)}z^{-1/2}e^{-z+B\sqrt z}.
$$

After $u=\sqrt z$, restrict the integral to $B/2\le u\le B/2+1$. This interval lies in $u\ge1$, and

$$
-u^2+Bu=B^2/4-(u-B/2)^2\ge B^2/4-1.
$$

Therefore the full Rényi integral is at least $2\exp(B^2/4-1-\alpha A(a,b))$. Take logarithms, discard the positive $\log2$, and divide by $\alpha(\alpha-1)$. Nonnegativity of Rényi divergence permits taking the maximum with zero. $\square$

When $a,c,b,\alpha$ are rational, the retained bound is rational. A checker can therefore recompute the entire certificate with exact integer and rational operations. It verifies an analytically established lower bound, not an exact evaluation of the Rényi integral. The constant is intentionally conservative; its role is rigorous finite-order evidence. In the outward direction, letting the certified order grow recovers the coefficient in Theorem 1. Neither floating-point quadrature nor a plot is needed for that conclusion.

## 10. Interpretation and remaining questions

The mechanism can look nearly Gaussian around its main mass when $x$ is large. That observation alone cannot certify all-orders zCDP: high orders inspect output magnitudes of order $\alpha^2$, far beyond the main mass. In the standardized positive tail the relevant exponent is $-u^2+\alpha d u$, with maximizing $u\approx\alpha d/2$. This tail saddle preserves a positive privacy cost regardless of the count.

For every fixed $r>0$, (6.1) holds independently of $r$. At $r=0$, however, the mechanism is the initial Gaussian itself, whose normalized Rényi divergence is $h^2/(2\sigma^2)$. Taking $r\downarrow0$ after the high-order limit therefore differs from setting $r=0$ first. There is no contradiction: the tail constants and the order at which the product tail dominates are not uniform as $r\downarrow0$.

Theorem 7 supplies the separate finite-order proof and Corollary 8 shows exactly why the large-count and high-order limits cannot be interchanged. Theorem 9 controls the outward supremum and proves its sharp limit. It still does not compute the bidirectional limit $\lim_{x\to\infty}v_*(x)$; the established bounds on that quantity remain (6.4).

The mechanism studied here is not competitive, in its count dependence, with alternative constructions whose zCDP budgets tend to zero. Its fixed-order behavior nevertheless explains why numerical investigations focused on a finite range of orders can suggest stronger amplification than all-orders privacy allows. The distinction is mathematical and mechanism specific: it does not challenge the validity of post-processing or the alternative mechanism results in [3].

The remaining questions include the exact bidirectional edgewise zCDP parameter, a uniform reverse-direction large-count bound, sharp finite-order asymptotics, and the effect of modifying or truncating the multiplicative noise. Such changes alter the mechanism and require new proofs. The present paper fixes the original untruncated Gaussian mechanism throughout.

## 11. References and attribution

[1] David Pujol and Damien Desfontaines. **Open problem — Better privacy guarantees for larger groups.** DifferentialPrivacy.org, 26 June 2023. [Original author-maintained problem statement and Algorithm 1](https://differentialprivacy.org/open-problem-better-privacy-guarantees-for-larger-groups/).

[2] Achraf Azize. **Open problem — Better privacy guarantees for larger groups.** July 2023. [Author-hosted manuscript](https://achraf-azize.github.io/Open_problem_Better_privacy_guarantees_for_larger_groups.pdf). Section 2.2, Attempt 1, identifies the product-normal law and formulates its Rényi integral. Section 3 concerns a different algorithm. The product identification is attributed to this prior analysis.

[3] Jack Fitzsimons. **Better Privacy Guarantees for Larger Groups.** arXiv:2607.14406, 15 July 2026. [arXiv record](https://arxiv.org/abs/2607.14406); [accessible full manuscript](https://www.researchgate.net/publication/410301346_Better_Privacy_Guarantees_for_Larger_Groups). The paper gives an alternative shifted-log Gaussian mechanism and a matching count-order lower bound under a zero-tolerant utility formulation. Its scope statement explicitly excludes analysis of the original randomized Algorithm 1.

[4] Mark Bun and Thomas Steinke. **Concentrated Differential Privacy: Simplifications, Extensions, and Lower Bounds.** 2016. [Primary manuscript](https://privacytools.seas.harvard.edu/sites/g/files/omnuum6656/files/privacytools/files/simp.pdf). We use the standard zCDP definition, Gaussian calibration, and post-processing property.

[5] Robert E. Gaunt and Zixin Ye. **Asymptotic approximations for the distribution of the product of correlated normal random variables.** arXiv:2309.07734v2, 2024. [Versioned manuscript](https://arxiv.org/abs/2309.07734v2). Proposition 2.1 and Theorem 2.2 establish relevant near-zero and tail density asymptotics in a more general product-normal setting. The present paper supplies elementary independent-factor bounds for its subsequent privacy analysis and claims no novelty for product-normal asymptotics themselves.

The candidate contribution is the exact directed Rényi formula, its application to the untruncated proposed privacy mechanism, the two contrasting order regimes, the outward uniform comparison, and the rational lower certificates. Novelty is assessed within the separately recorded search and full-text comparisons. This manuscript makes no global-priority or external-peer-review claim.
