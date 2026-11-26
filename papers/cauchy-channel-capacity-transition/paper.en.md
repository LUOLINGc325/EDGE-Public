# The first capacity transition of the power-constrained Cauchy channel

26 November 2026

## Abstract

We determine the largest power interval on which the antipodal input achieves the capacity of the real additive Cauchy channel under an average second-moment constraint. The comparison is with all Borel input distributions. In units of the squared noise scale, the endpoint is $p_*=0.377488300894238\ldots$, defined by a unique scalar logarithmic equation. The capacity throughout this interval equals the previously known antipodal mutual information, and the optimizer is unique, including at the endpoint. Above the endpoint, a feasible three-point perturbation strictly improves on the antipodal law at every power. In a positive right neighborhood of the endpoint, we prove that the unique global optimizer is an analytic three-point family: a central atom appears at a linear rate, and the capacity gains a strictly positive quadratic term. Consequently, capacity is continuously differentiable, but not twice differentiable, at its first support transition. Finally, we specialize classical rational-density integration to obtain an exact capacity certificate for any finite Cauchy constellation: its continuum optimality inequality reduces to the real roots of a polynomial of degree $4m-1$ for $m$ input points. The three-point neighborhood is existential; neither the entire three-point phase nor the capacity at all powers is determined.

**Keywords:** channel capacity; Cauchy noise; average power; discrete input distributions; support transition; global optimality certificate.

## 1. Problem, contribution, and prior work

Consider the memoryless channel $Y=X+Z$, with $X$ independent of $Z$ and

$$
 Z\sim\operatorname{Cauchy}(0,\sigma),\qquad \sigma>0,
 \qquad \mathbb E X^2\le P.
$$

The scale-normalized power is $p=P/\sigma^2$. Scaling input and output by $\sigma$ preserves mutual information, so we work with $\sigma=1$ until Section 7. Write

$$
 c_x(y)=\frac{1}{\pi(1+(y-x)^2)},\qquad
 q_F(y)=\int c_x(y)\,dF(x),\qquad
 C(p)=\sup_{F:\int x^2dF\le p}I(F).
 \tag{1.1}
$$

Here $F$ ranges over all Borel probability measures on $\mathbb R$. It need not be symmetric, finitely supported, or absolutely continuous. All logarithms are natural, and rates are in nats per channel use. The noise scale, rather than a noise variance, is the normalization; the Cauchy variance does not exist.

The average-power Cauchy capacity is distinct from Cauchy capacity under a logarithmic input constraint. Verdú [V23, item 105] records the average-energy problem as unresolved beyond capacity per unit energy. Pang and Zhang [PZ25, Section II-C] calculate the antipodal mutual information

$$
 B(p)=\log\frac{2\sqrt{1+p}}{1+\sqrt{1+p}}
 \tag{1.2}
$$

and establish its first-order optimality as $p\downarrow0$. That formula is prior work. Fahs and Abou-Faycal [FA18, Theorem 9] give boundedness and finite-discreteness results for the appropriate stable-noise and analytic-cost class; their discussion of squared cost uses numerical optimization of support points and probabilities. Finite discreteness is also prior work. Our principal contribution is the exact maximal interval on which (1.2) is capacity, together with the first globally optimal support transition and its local capacity expansion.

The analysis uses classical relative-entropy duality, the Poisson logarithm identity, and the analytic implicit function theorem. Closed-form calculations for two Cauchy mixtures are developed by Nielsen [N22]; broader spectral-factor and residue methods for rational-density integrals appear in Trinh [T22, Chapter 5]. We do not claim those integration principles as new. Section 6 puts them into a finite critical-point capacity certificate and uses the explicit structure to support the transition analysis. The precise numerical constants illustrate analytic theorems; numerical optimization is not their proof.

Exact support transitions are an established research theme. Stapmanns et al. [S25] analyze a uniform-noise channel with a nonnegative peak-amplitude constraint and an additional cost constraint, obtaining discrete or continuous support according to the cost regime. Our channel has heavy-tailed Cauchy noise, no peak constraint, and only a second-moment budget. We determine its complete first support phase and a local part of its second phase; we do not claim a general theory of support transitions.

### 1.1. Main results

Define, for $s\ge1$,

$$
 f(s)=\log\frac{8s(s+1)}{(s^2+3)^2}-\frac{s-1}{2s^2}.
 \tag{1.3}
$$

**Theorem 1 (sharp antipodal interval).** There is exactly one root $s_*>1$ of $f(s)=0$. Let $p_*=s_*^2-1$. For every $p\in[0,p_*]$,

$$
 C(p)=B(p).
 \tag{1.4}
$$

For $0< p\le p_*$ the unique optimizer is $F_p=(\delta_{-\sqrt p}+\delta_{\sqrt p})/2$. At $p=0$ it is $\delta_0$. For every $p>p_*$, $F_p$ is strictly suboptimal. In particular, for positive power an input with at most two support points can attain capacity if and only if $p\le p_*$.

**Theorem 2 (the first global three-point branch).** There exist $\varepsilon>0$ and a real-analytic function $u$ on an open interval containing $p_*$, with $u(p_*)=0$ and $u'(p_*)>0$, such that, for every $p\in(p_*,p_*+\varepsilon)$, the unique capacity-achieving law is

$$
 F_{p,u(p)}=u(p)\delta_0+
 \frac{1-u(p)}2\left(\delta_{-\sqrt{p/(1-u(p))}}
 +\delta_{\sqrt{p/(1-u(p))}}\right).
 \tag{1.5}
$$

With positive constants $h_*$ and $\kappa$ defined in Section 5,

$$
 u(p)=-\frac{f_p(p_*)}{h_*}(p-p_*)+O((p-p_*)^2),
 \qquad
 C(p)=B(p)+\kappa(p-p_*)^2+O((p-p_*)^3),
 \quad
 \kappa=\frac{f_p(p_*)^2}{2h_*}>0.
 \tag{1.6}
$$

Here $f_p(p)=\frac{d}{dp}f(\sqrt{1+p})$. Capacity is $C^1$ but not $C^2$ at $p_*$. No numerical value of $\varepsilon$ is asserted.

**Theorem 3 (finite critical-point certificate).** Let $F$ be an $m$-point law with distinct real support, positive probabilities, and positive second moment $p$. For each proposed multiplier $\lambda>0$, an explicitly specified real polynomial of degree $4m-1$ reduces the global capacity inequality for $F$ to its finitely many real roots. The resulting inequalities hold if and only if the corresponding continuum inequality holds. They imply that $F$ uniquely achieves $C(p)$. Conversely, every such finite capacity-achieving law admits a positive multiplier and therefore a certificate of this form. This is an exact mathematical reduction, not a claim of unconditional finite-precision decidability of transcendental equalities.

## 2. Analytic foundations and the unrestricted comparison class

### 2.1. A classical logarithmic integral

**Lemma 2.1 (Poisson logarithm identity).** For every $a,x\in\mathbb R$ and $b>0$,

$$
 \int_{\mathbb R}c_x(y)\log((y-a)^2+b^2)\,dy
 =\log((x-a)^2+(1+b)^2).
 \tag{2.1}
$$

**Proof.** The standard Cauchy characteristic-function formula, obtained by Fourier inversion or residues, is $e^{-b|\omega|}$ for scale $b$. It implies the convolution law $c_{0,1}*c_{0,b}=c_{0,1+b}$. Differentiate the integral in (2.1) with respect to $b$ on a compact subinterval of $(0,\infty)$. Its derivative is the convolution of $c_x$ with $2b/((y-a)^2+b^2)$, and hence equals

$$
 \frac{2(1+b)}{(x-a)^2+(1+b)^2}.
$$

This is the derivative of the claimed right side. The two expressions therefore differ by a constant independent of $b$. Subtract $2\log b$ and let $b\to\infty$. The integral tends to zero by dominated convergence, using the integrable majorant $\log(1+(y-a)^2)c_x(y)$ for $b\ge1$; the right side does too. The constant is zero. $\square$

In particular,

$$
 h(c_x)=\log(4\pi),\qquad
 D(c_x\Vert c_a)=\log\left(1+\frac{(x-a)^2}{4}\right).
 \tag{2.2}
$$

### 2.2. Finite reference laws control all Borel inputs

For a finite candidate law $G$ write $q=q_G$ and $d_q(x)=D(c_x\Vert q)$.

**Lemma 2.2 (integrable entropy identity).** If $G$ has at least one positive atom of mass $w$ at $a$, then

$$
 0\le d_q(x)\le -\log w+
 \log\left(1+\frac{(x-a)^2}{4}\right)
 \le -\log w+\frac{(x-a)^2}{4}.
 \tag{2.3}
$$

For every Borel probability law $F$ with finite second moment,

$$
 I(F)+D(q_F\Vert q)=\int d_q(x)\,dF(x)<\infty.
 \tag{2.4}
$$

**Proof.** Since $q\ge wc_a$, (2.3) follows from (2.2) by integration of the pointwise log-density comparison. Thus the relative entropy of the joint law $F(dx)c_x(y)dy$ with respect to $F(dx)q(y)dy$ is finite. The relative-entropy chain rule for its output marginal gives (2.4). This argument does not require a density or a finite alphabet for $F$, and does not exchange infinite differential entropies. $\square$

**Proposition 2.3 (global certificate and uniqueness).** Suppose the finite probability law $G$ has second moment $p$, mutual information $C_0$, and, for some $\lambda\ge0$,

$$
 d_{q_G}(x)\le C_0+\lambda(x^2-p)
 \quad\text{for every }x\in\mathbb R.
 \tag{2.5}
$$

Then $C(p)=C_0$, and $G$ is the unique optimizer among all feasible Borel laws.

**Proof.** Integrate (2.5) against any feasible $F$ and apply (2.4). This gives $I(F)+D(q_F\Vert q_G)\le C_0$. Equality in capacity forces $D(q_F\Vert q_G)=0$. The Cauchy characteristic function $e^{-|\omega|}$ is nowhere zero, so equality of the convolution densities implies equality of the characteristic functions of $F$ and $G$, and hence $F=G$. $\square$

**Lemma 2.4 (finite capacity, concavity, and finite-candidate necessity).** The function $C$ is finite, nondecreasing, and concave on $[0,\infty)$, with $C(0)=0$ and $C(p)\le p/4$. If a finite law of second moment $p>0$ achieves $C(p)$, it satisfies (2.5) for some finite $\lambda>0$.

**Proof.** Use the reference $c_0$ in (2.4) and (2.2) to obtain $I(F)\le\mathbb E\log(1+X^2/4)\le p/4$. Mutual information is concave in the input law: for a mixture of two inputs it equals the corresponding mixture of their mutual informations plus the nonnegative Jensen-Shannon divergence of their output laws. Mixing nearly optimal feasible laws proves concavity of $C$; monotonicity follows from inclusion of the feasible sets. The displayed upper bound also proves continuity at zero.

At each $p>0$ a finite concave function has a finite supergradient $\lambda$. Monotonicity gives $\lambda\ge0$. For a finite optimizer $G$ and any fixed real $x$, let $G_\epsilon=(1-\epsilon)G+\epsilon\delta_x$. Its moment is $(1-\epsilon)p+\epsilon x^2$. The supergradient inequality bounds its mutual information by $C(p)+\lambda\epsilon(x^2-p)$. Meanwhile (2.4) yields the exact identity

$$
 I(G_\epsilon)=(1-\epsilon)I(G)+\epsilon d_{q_G}(x)
 -D((1-\epsilon)q_G+\epsilon c_x\Vert q_G).
 \tag{2.6}
$$

The ratio $c_x/q_G$ is bounded for this fixed $x$: dominate $q_G$ below by any one of its positive Cauchy components. The last divergence is at most the corresponding chi-square divergence, which is $O(\epsilon^2)$. Divide by $\epsilon$ and let $\epsilon\downarrow0$ to obtain (2.5). A finite Cauchy mixture has $d_{q_G}(x)=\log(x^2/4)+o(1)$ as $|x|\to\infty$, as follows either from (2.1) or Section 6. Thus $\lambda=0$ is impossible. $\square$

## 3. The exact antipodal certificate

Fix $p>0$ and set

$$
 s=\sqrt{1+p},\quad b=(s+1)^2,\quad
 N_p(t)=t^2+(8-2p)t+(p+4)^2,\quad
 \lambda_p=\frac{1}{2s^2(s+1)}=B'(p).
 \tag{3.1}
$$

The antipodal output density is

$$
 q_p(y)=\frac{y^2+1+p}
 {\pi((y-\sqrt p)^2+1)((y+\sqrt p)^2+1)}.
 \tag{3.2}
$$

**Lemma 3.1 (binary information density).** For $t=x^2\ge0$,

$$
 d_p(t):=D(c_x\Vert q_p)=
 \log\frac{N_p(t)}{4(t+b)}.
 \tag{3.3}
$$

Moreover $d_p(p)=B(p)$ and $d_p'(p)=\lambda_p$.

**Proof.** Apply (2.1) to the two denominator quadratics and the numerator quadratic in (3.2), and subtract $\log(4\pi)$. The product of the two resulting denominator terms is $N_p(x^2)$. Substitution and differentiation give the last identities. The mutual information value agrees with the prior formula (1.2). $\square$

Define the certificate gap, with the sign convention that nonnegative is valid,

$$
 g_p(t)=B(p)+\lambda_p(t-p)-d_p(t).
 \tag{3.4}
$$

It satisfies $g_p(p)=g_p'(p)=0$. Define

$$
 \begin{aligned}
 \beta(s)&=10+2s-2s^2-2s^3,\\
 \chi(s)&=9+18s+22s^2-12s^3-15s^4-6s^5,\\
 Q_s(t)&=t^2+\beta(s)t+\chi(s),\\
 V(s)&=s^4+2s^3+s^2-4s-2.
 \end{aligned}
 \tag{3.5}
$$

**Lemma 3.2 (factorization and contact geometry).** Direct polynomial multiplication gives

$$
 g_p'(t)=\frac{(t-p)Q_s(t)}
 {2s^2(s+1)N_p(t)(t+b)},\qquad
 Q_s(p)=-8sV(s),\qquad g_p(0)=f(s).
 \tag{3.6}
$$

On $1\le s\le47/40$, $\beta(s)>0$ and $Q_s(p)>0$. Thus $Q_s$ is strictly increasing for $t\ge0$, and

$$
 \min_{t\ge0}g_p(t)=\min\{g_p(0),g_p(p)\}
 =\min\{f(s),0\}.
 \tag{3.7}
$$

**Proof.** All denominators in (3.6) are positive; in particular $N_p(t)$ is the product of two positive quadratics in $x$ when $t=x^2$. Since $\beta'(s)=2-4s-6s^2<0$ for $s\ge1$,

$$
 \beta(s)\ge\beta(47/40)=\frac{203017}{32000}>0.
$$

Also $V'(s)=4s^3+6s^2+2s-4>0$ for $s\ge1$, and

$$
 V(s)\le V(47/40)=-\frac{432079}{2560000}<0.
$$

If $\chi(s)\ge0$, the sign of $g_p'$ is nonpositive up to $p$ and positive after $p$. If $\chi(s)<0$, $Q_s$ has exactly one nonnegative root $r\in(0,p)$; the signs of $g_p'$ on $(0,r),(r,p),(p,\infty)$ are respectively positive, negative, positive. The global minimum is therefore at $0$ or $p$. This proves (3.7). $\square$

## 4. The threshold and failure at every higher power

### 4.1. Uniqueness and rigorous location of the threshold

Let

$$
 R(s)=4s^4+9s^3-2s^2-9s-6.
 \tag{4.1}
$$

**Lemma 4.1 (the unique positive transition).** The function $f$ in (1.3) has exactly one zero $s_*>1$. It is strictly positive on $(1,s_*)$ and strictly negative on $(s_*,\infty)$. Furthermore,

$$
 \frac{1467}{1250}< s_*<\frac{11737}{10000}<\frac{47}{40}.
 \tag{4.2}
$$

**Proof.** Differentiation gives

$$
 f'(s)=-\frac{(s-1)R(s)}{2s^3(s+1)(s^2+3)}.
 \tag{4.3}
$$

Here $R(1)=-4$, and $R'(s)=16s^3+27s^2-4s-9>0$ for $s\ge1$. The latter follows, for example, by grouping $16s^3-4s\ge12s$ and $27s^2-9\ge18$. Thus $R$ has one root larger than one. Since $f(1)=0$ and $f(s)\to-\infty$, $f$ first increases and then decreases through exactly one further zero. Its derivative at that zero is strictly negative.

For completeness, the signs at the rational endpoints in (4.2) require no numerical assumption. For rational $z>1$, put $r=(z-1)/(z+1)$. Then

$$
 2\sum_{j=0}^{n-1}\frac{r^{2j+1}}{2j+1}
 \le\log z\le
 2\sum_{j=0}^{n-1}\frac{r^{2j+1}}{2j+1}
 +\frac{2r^{2n+1}}{(2n+1)(1-r^2)}.
 \tag{4.4}
$$

This follows by integrating the geometric series for $(1-r^2)^{-1}$. At each endpoint take $z=8s(s+1)/(s^2+3)^2$ and $n=4$. Rational arithmetic in (4.4), after subtracting $(s-1)/(2s^2)$, gives

$$
 f(1467/1250)>10^{-6},\qquad
 f(11737/10000)<-5\cdot10^{-7}.
 \tag{4.5}
$$

These coarser rational inequalities are strict. The [recorded calculations](results/check_output.json) give their full rational bounds. Monotonicity and uniqueness finish the bracket. $\square$

**Proof of Theorem 1 on the closed interval.** For $0< p\le p_*$, (4.2) places $s$ in the range of Lemma 3.2 and $f(s)\ge0$. Consequently $g_p\ge0$ on the entire half-line. Proposition 2.3 gives capacity and uniqueness over all feasible Borel laws. At $p=0$, the moment constraint forces $X=0$ almost surely. $\square$

### 4.2. A feasible direction, rather than just a failed inequality

For $p>0$ and $0\le u<1$ define

$$
 F_{p,u}=u\delta_0+\frac{1-u}{2}
 \left(\delta_{-\sqrt{p/(1-u)}}+
 \delta_{\sqrt{p/(1-u)}}\right),\qquad J(p,u)=I(F_{p,u}).
 \tag{4.6}
$$

Every such law has second moment exactly $p$.

**Lemma 4.2 (onset direction).** For every fixed $p>0$,

$$
 J_u(p,0)=-f(\sqrt{1+p}).
 \tag{4.7}
$$

**Proof.** Differentiating the mutual information of a smooth finite-mixture path gives the integral of its input-law variation against the current $d_q$. For (4.6), the changes of the masses contribute $d_p(0)-d_p(p)$. The outward motion of the two atoms contributes $p\,d_p'(p)$. The sum equals $-f(\sqrt{1+p})$ by (3.4). To justify differentiation, restrict $p$ and the atom locations to a compact neighborhood of their fixed values. The output density is uniformly comparable to $(1+y^2)^{-1}$, its first three parameter derivatives are bounded in magnitude by a constant times $(1+y^2)^{-1}$, and its logarithm is bounded by a constant plus $\log(1+y^2)$. These are integrable bounds for each required differentiation. $\square$

**Completion of Theorem 1.** If $p>p_*$, Lemmas 4.1 and 4.2 give $J_u(p,0)>0$. Hence some sufficiently small positive $u$ gives $J(p,u)>B(p)$, proving strict suboptimality at every such power.

To justify the assertion about arbitrary two-point laws, observe first that mutual information is strictly concave in the input law: the Jensen-Shannon term in Lemma 2.4 vanishes only for equal outputs, and Cauchy convolution is injective. Any optimizer is therefore unique. Reflection preserves both the cost and mutual information, so an optimizer must be symmetric. A symmetric nondegenerate law on at most two points is antipodal. It must use the full budget, since $B$ is strictly increasing. A one-point law has zero information and cannot be optimal at positive power, where an antipodal law achieves a positive value. The already proved classification applies. $\square$

## 5. Analytic birth of a globally optimal central atom

### 5.1. Exact ternary information density

For independent parameters $u,v$ near $(0,p_*)$, set

$$
 G_{u,v}=u\delta_0+\frac{1-u}{2}(\delta_{-\sqrt v}+\delta_{\sqrt v}),
 \quad
 A=2+v-3uv,\quad L=(1+v)(1+uv).
 \tag{5.1}
$$

The output numerator, after putting it over the product of its three Cauchy denominators, is $y^4+Ay^2+L$. Let $r_1^2< r_2^2$ be the roots of

$$
 \xi^2-A\xi+L=0.
 \tag{5.2}
$$

At $(u,v)=(0,p_*)$ these roots are $1$ and $1+p_*$. They remain distinct and positive in an open parameter neighborhood. Their positive square roots $r_1,r_2$ and the quantities $k_i=(1+r_i)^2$ are real analytic there. For physical parameters $u\ge0$, $u<1$, Lemma 2.1 gives

$$
 d(u,v;t)=\log\frac{(t+4)\{t^2+(8-2v)t+(v+4)^2\}}
 {4(t+k_1)(t+k_2)}.
 \tag{5.3}
$$

This expression also defines a real-analytic continuation to the full neighborhood. The denominator factor $t+4$ cancels at $u=0$, giving (3.3).

Define

$$
 \begin{aligned}
 E(u,v)&=d(u,v;v)-d(u,v;0)-v\,d_t(u,v;v),\\
 H(p,u)&=E\left(u,\frac{p}{1-u}\right).
 \end{aligned}
 \tag{5.4}
$$

**Lemma 5.1 (the stationary branch equation).** In the above neighborhood, the analytic extension of $J$ satisfies

$$
 J_u(p,u)=-H(p,u),\quad
 H(p,0)=f(\sqrt{1+p}),\quad H(p_*,0)=0.
 \tag{5.5}
$$

**Proof.** The physical mutual information is $u\,d(u,v;0)+(1-u)d(u,v;v)$, so (5.3) makes it analytic. The path variation used in Lemma 4.2 applies at each physical point, with $v=p/(1-u)$ and $v_u=v/(1-u)$. It gives $J_u=d(u,v;0)-d(u,v;v)+v\,d_t(u,v;v)=-H$. Both sides have analytic extensions, so the identity holds on their common neighborhood. At $u=0$ the equality with $f$ follows from (3.3)-(3.4). $\square$

### 5.2. The nondegenerate second variation

Set $s=s_*$ for the next formulas, and write

$$
 \begin{aligned}
 f_p(p_*)&=-\frac{(s-1)R(s)}{4s^4(s+1)(s^2+3)}<0,\\
 T(s)&=2s^7+6s^6-2s^5-11s^4-19s^3+11s^2+15s+6,\\
 h_*&=\frac{(s-1)^2T(s)}{4s^4(s+1)(s^2+3)}.
 \end{aligned}
 \tag{5.6}
$$

**Lemma 5.2 (strict branch curvature).** One has $H_u(p_*,0)=h_*>0$.

**Proof.** Differentiating (5.3)-(5.4) first with independent $u,v$ gives

$$
 E_u(0,v)=\frac{(s-1)^3(s+3)(s^2+s+2)}
 {2s(s+1)(s^2+3)},\qquad s=\sqrt{1+v}.
 \tag{5.7}
$$

Since $v_u=p$ at $u=0$ and $E_v(0,p)=f_p(p)$, the chain rule gives $H_u=E_u+p f_p$, which simplifies to (5.6). These are identities of rational functions after the indicated substitution.

Strict positivity has a useful proof that avoids a delicate polynomial sign test. Fix $p=p_*$, let $q_u=q_{F_{p_*,u}}$, $q_*=q_0$, and $\dot q=\partial_uq_u|_0$. The entropy second-variation formula and the path derivatives $a'(0)=a/2$, $a''(0)=3a/4$ for $a(u)=\sqrt{p_*/(1-u)}$ give

$$
 J_{uu}(p_*,0)=p_*^2d_{p_*}''(p_*)
 -\int_{\mathbb R}\frac{\dot q(y)^2}{q_*(y)}\,dy.
 \tag{5.8}
$$

For clarity, the terms from the two moving atoms sum to
$-p_*\lambda_{p_*}/2+(p_*/4)d_{xx}(\sqrt{p_*})$.
The relation $d_{xx}(\sqrt p)=2\lambda_p+4p\,d_p''(p)$ makes this equal to $p_*^2d_{p_*}''(p_*)$. This accounts for the mass as well as location derivatives. The domination in Lemma 4.2 justifies the second variation and the integral is finite. By (3.6), $g_{p_*}''(p_*)>0$. Hence

$$
 h_*=-J_{uu}(p_*,0)=
 \int_{\mathbb R}\frac{\dot q(y)^2}{q_*(y)}\,dy
 +p_*^2g_{p_*}''(p_*)>0.
 \tag{5.9}
$$

This proves both the nondegeneracy and its sign. $\square$

The analytic implicit function theorem now gives a unique local analytic solution $u(p)$ of $H(p,u(p))=0$ with $u(p_*)=0$, and

$$
 u'(p_*)=-\frac{f_p(p_*)}{h_*}>0.
 \tag{5.10}
$$

After decreasing the neighborhood if necessary, $0< u(p)<1$ whenever $p>p_*$ in that neighborhood. Put $v(p)=p/(1-u(p))$ and

$$
 \lambda(p)=d_t(u(p),v(p);v(p)),\qquad
 C_0(p)=d(u(p),v(p);0)+\lambda(p)p.
 \tag{5.11}
$$

Continuity gives $\lambda(p)>0$. The equation $H=0$ implies that $C_0(p)$ is the actual mutual information of the candidate, since it equates the two support information densities after subtracting their cost terms.

### 5.3. A stationary constellation is globally optimal here

**Lemma 5.3 (persistence of the full half-line certificate).** For all $p>p_*$ sufficiently close to $p_*$,

$$
 G(p,t):=C_0(p)+\lambda(p)(t-p)-d(u(p),v(p);t)\ge0
 \quad\text{for every }t\ge0.
 \tag{5.12}
$$

**Proof.** At $p=p_*$, $G(p_*,t)=g_{p_*}(t)$. Lemma 3.2 and $f(s_*)=0$ show that its only zeros on $[0,\infty)$ are $0$ and $p_*$. Moreover $g_{p_*}''(p_*)>0$. To verify the remaining endpoint sign, $\chi$ is strictly decreasing on $[1,\infty)$: $\chi'(1)=-64$, and $\chi''(s)=44-72s-180s^2-120s^3<0$. The exact value

$$
 \chi(1467/1250)=
 -\frac{74889427270356}{95367431640625}<0
 \tag{5.13}
$$

and (4.2) imply $\chi(s_*)<0$. Formula (3.6) therefore gives $g_{p_*}'(0)>0$.

We divide the half-line into four regions. Choose disjoint fixed small neighborhoods of $0$ and $p_*$. In the first, continuity preserves a positive lower bound for $G_t$. The exact identity $G(p,0)=0$ then gives $G(p,t)\ge0$. In the second, continuity preserves a positive lower bound for $G_{tt}$, while $v(p)$ remains inside the neighborhood and

$$
 G(p,v(p))=G_t(p,v(p))=0.
$$

Taylor's theorem, or integration of $G_{tt}$ on the segment joining $t$ to $v(p)$, gives a positive quadratic lower bound there.

On the remaining part of any fixed compact interval, the base gap has a strictly positive minimum. Uniform continuity preserves half this minimum for nearby parameters. Finally, (5.3), whose coefficients remain in a compact set and whose denominator factors remain positive, gives uniformly as $t\to\infty$

$$
 d(u(p),v(p);t)=\log(t/4)+O(t^{-1}).
 \tag{5.14}
$$

For example, divide numerator and denominator by their leading powers of $t$; each residual polynomial is uniformly $1+O(t^{-1})$, bounded away from zero for one common sufficiently large $t$. Also $\lambda(p)\ge\lambda_{p_*}/2$ and $C_0(p)-\lambda(p)p$ stays bounded. Thus a common tail satisfies $G(p,t)\ge (\lambda_{p_*}/2)t-\log t-M>0$. Intersect the finitely many parameter neighborhoods used in these four arguments. This proves (5.12) over the entire half-line, with no restriction on possible competing support locations. $\square$

Proposition 2.3 applied to (5.12) proves the global optimality and uniqueness assertion in Theorem 2. In particular, the argument establishes more than stationary optimality within the three-point family.

### 5.4. Capacity expansion and differentiability

From (5.5), analyticity, and Lemma 5.2, with $\Delta=p-p_*$,

$$
 J(p,u)=B(p)-f_p(p_*)\Delta u-\frac{h_*}{2}u^2
 +O((|\Delta|+|u|)^3).
 \tag{5.15}
$$

Substituting (5.10) proves (1.6). The capacity on the left is exactly $B$, while on the right it is the analytic branch just constructed. The values and first derivatives agree at $p_*$. The difference between the right and left second derivatives is $2\kappa>0$, proving the final assertion of Theorem 2.

Numerical evaluation, provided as a diagnostic and not a definition, gives

| Quantity | Approximate value |
|---|---:|
| $p_*$ | $0.37748830089423817318$ |
| $f_p(p_*)$ | $-0.00678678447296$ |
| $h_*$ | $0.00189237844716945382$ |
| $u'(p_*)$ | $3.58637802238384495$ |
| $\kappa$ | $0.01216998733824234060$ |

## 6. An exact finite certificate for any finite constellation

Let

$$
 F=\sum_{j=1}^m w_j\delta_{a_j},\qquad
 w_j>0,\quad\sum_jw_j=1,
$$

with pairwise distinct $a_j\in\mathbb R$. Define

$$
 W(y)=\prod_{j=1}^m((y-a_j)^2+1),\qquad
 R_F(y)=\sum_{j=1}^m w_j\prod_{k\ne j}((y-a_k)^2+1).
 \tag{6.1}
$$

The polynomial $R_F$ is monic of degree $2m-2$ and strictly positive on the real line. Its upper-half-plane roots, counted with multiplicity, are $b_\ell+ic_\ell$, $c_\ell>0$, $1\le\ell\le m-1$. Conjugate pairing gives

$$
 R_F(y)=\prod_{\ell=1}^{m-1}((y-b_\ell)^2+c_\ell^2),
 \qquad q_F(y)=\frac{R_F(y)}{\pi W(y)}.
 \tag{6.2}
$$

Empty products and sums have their usual values when $m=1$.

**Lemma 6.1 (rational-mixture information density).** One has

$$
 d_F(x)=\sum_{j=1}^m\log((x-a_j)^2+4)
 -\sum_{\ell=1}^{m-1}\log((x-b_\ell)^2+(1+c_\ell)^2)-\log4.
 \tag{6.3}
$$

**Proof.** Apply Lemma 2.1 term by term to the finite product factorization (6.2). Repeated nonreal roots are simply repeated factors. No real zero or singular logarithm occurs. $\square$

Let $p=\sum_jw_ja_j^2$, $C_F=\sum_jw_jd_F(a_j)$, and fix $\lambda>0$. Set

$$
 g_{F,\lambda}(x)=C_F+\lambda(x^2-p)-d_F(x),
 \tag{6.4}
$$

and introduce the positive polynomial

$$
 D_F(x)=\prod_{j=1}^m((x-a_j)^2+4)
 \prod_{\ell=1}^{m-1}((x-b_\ell)^2+(1+c_\ell)^2).
 \tag{6.5}
$$

**Proposition 6.2 (all critical points suffice).** The expression

$$
 \begin{aligned}
 P_{F,\lambda}(x)=D_F(x)\bigg[2\lambda x
 &-\sum_{j=1}^m\frac{2(x-a_j)}{(x-a_j)^2+4}\\
 &+\sum_{\ell=1}^{m-1}
 \frac{2(x-b_\ell)}{(x-b_\ell)^2+(1+c_\ell)^2}\bigg]
 \end{aligned}
 \tag{6.6}
$$

is a real polynomial of degree exactly $4m-1$, with leading coefficient $2\lambda$. Moreover,

$$
 g_{F,\lambda}\ge0\text{ on }\mathbb R
 \quad\Longleftrightarrow\quad
 g_{F,\lambda}(r)\ge0
 \text{ for every real root }r\text{ of }P_{F,\lambda}.
 \tag{6.7}
$$

**Proof.** Every denominator in (6.6) divides $D_F$. Its degree is $4m-2$, so the cost term has degree $4m-1$ and all logarithmic derivative terms have degree at most $4m-3$. Since $D_F>0$, the real roots in (6.6) are exactly the stationary points of $g_{F,\lambda}$. Equation (6.3) gives $d_F(x)=\log(x^2/4)+o(1)$ at infinity. Thus $g_{F,\lambda}(x)\to+\infty$ as $|x|\to\infty$. Its global minimum is attained at a stationary point, proving (6.7). $\square$

**Proof of Theorem 3.** If the finite inequalities hold, Proposition 6.2 gives the full inequality (2.5), and Proposition 2.3 proves unique capacity attainment. Conversely, Lemma 2.4 supplies a positive multiplier for every finite optimizer of positive moment, and Proposition 6.2 reduces its inequality to the stated real roots. $\square$

The certificate separates support search from global verification. It does not give a universal bound on the size of an optimal constellation, a formula for capacity at all powers, or a guaranteed finite-precision procedure for every exact zero comparison. Algebraic root isolation can assist when the parameters are algebraic; strict logarithmic inequalities can be certified by directed bounds. Active equality cases still require exact identities or a separate rigorous argument. A floating-point list of approximate roots is diagnostic unless completeness, error bounds, and the required signs are certified.

## 7. Scaling, scope, and reproducibility

For noise scale $\sigma>0$, the first transition is at $P_*=\sigma^2p_*$. On $0\le P\le P_*$,

$$
 C_\sigma(P)=\log\frac{2\sqrt{\sigma^2+P}}
 {\sigma+\sqrt{\sigma^2+P}},
$$

with the unique input $\pm\sqrt P$ of equal probabilities for $P>0$. Immediately above $P_*$ the unique input has central mass $u(P/\sigma^2)$ and outer locations $\pm\sqrt{P/(1-u(P/\sigma^2))}$. Capacity in bits is obtained by dividing every rate by $\log2$.

The [reproduction script](code/check_cauchy.py) checks rational endpoint inequalities, symbolic identities, and independent numerical evaluations. Its exact part uses rational arithmetic for (4.4)-(4.5) and the polynomial signs, and symbolic subtraction for algebraic identities. High-precision integration independently checks (5.9). Three selected positive offsets from $p_*$ are examined through the complete candidate critical polynomial rather than a sampling grid; these computations remain diagnostics and do not certify a numerical value of the neighborhood in Theorem 2. Negative controls at powers above $p_*$ detect the failed antipodal center inequality and an actual feasible improvement. The [reproduction guide](REPRODUCTION.md) gives the command and dependency versions.

Theorems 1-3 are mathematical statements under the scalar, real, independent, memoryless Cauchy model and the average second-moment constraint. They do not concern peak constraints, logarithmic costs, vector receivers, practical coding guarantees, or arbitrary impulsive-noise distributions. The entire three-point phase and subsequent transitions remain open in this paper. This manuscript presents written proofs. External peer review and proof-assistant verification have not been performed.

## References

[PZ25] S. Pang and W. Zhang. Information Rates of Channels With Additive White Cauchy Noise. *IEEE Communications Letters* **29**(1), 115-119, 2025. DOI: [10.1109/LCOMM.2024.3502753](https://doi.org/10.1109/LCOMM.2024.3502753). Author manuscript: [arXiv:2411.11385v1](https://arxiv.org/html/2411.11385v1).

[FA18] J. Fahs and I. Abou-Faycal. On Properties of the Support of Capacity-Achieving Distributions for Additive Noise Channel Models With Input Cost Constraints. *IEEE Transactions on Information Theory* **64**(2), 1178-1198, 2018. DOI: [10.1109/TIT.2017.2771815](https://doi.org/10.1109/TIT.2017.2771815). Author manuscript: [arXiv:1602.00878](https://arxiv.org/abs/1602.00878).

[V23] S. Verdú. The Cauchy Distribution in Information Theory. *Entropy* **25**(2), 346, 2023. DOI: [10.3390/e25020346](https://doi.org/10.3390/e25020346).

[N22] F. Nielsen. The analytic dually flat space of the mixture family of two prescribed distinct Cauchy distributions. In *Geometry and Statistics*, Chapter 6, 2022. DOI: [10.1016/bs.host.2022.02.002](https://doi.org/10.1016/bs.host.2022.02.002). Author manuscript: [arXiv:2104.13801](https://arxiv.org/abs/2104.13801).

[T22] Y. T. Trinh. *Option pricing and CVA calculations using the Monte Carlo-Tree (MC-Tree) method*. PhD thesis, University College Cork, 2022. Chapter 5, especially Theorem 5.2.1 and Section 5.6. Institutional record: [hdl.handle.net/10468/13565](https://hdl.handle.net/10468/13565). The present literature check verified the institutional metadata and relevant available theorem and section extracts; this citation does not claim a complete examination of the thesis.

[S25] J. Stapmanns et al. *Phase Transitions of the Additive Uniform Noise Channel with Peak Amplitude and Cost Constraint*. Author manuscript, [arXiv:2510.12427v1](https://arxiv.org/html/2510.12427v1), 2025. The author record reports that part of the work was presented at ISIT 2025; this citation refers specifically to the arXiv manuscript.
