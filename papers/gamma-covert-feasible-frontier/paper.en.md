# Feasible-output frontiers and covert communication over Gamma noise

Research manuscript · 26 November 2026 · Version 1

## Abstract

For a memoryless additive channel with Gamma noise, we determine exactly when the varentropy upper bound for covert communication is tight. It is tight precisely for shape parameters at most one. For every shape between one and two we identify a smaller sharp constant, together with the unique optimizer of the mutual-information problem at every finite forward-output relative-entropy budget. The optimizer is a clipped exponential tilt of the noise density. Its attainability follows from a positive fractional convolution inverse. A single-crossing inequality supplies a converse over all input laws, an exact entropy-deficit identity, and a strict improvement over the varentropy bound for every shape greater than one. Above shape two the clipped frontier remains an upper bound but is strictly unattainable at every fixed positive budget; the exact covert constant in that range is not determined here. We prove the coding theorem separately, using a finite secret key of at most linear logarithmic size, without assuming that an ordinary escort output is realizable. All claims concern average decoding error, no feedback, and the same observation at the receiver and the warden.

## 1. Problem, contribution, and relation to earlier work

Bouette, Luzzi, and Wang [B1, §V-C, Remark 3] leave the exact covert scaling constant for generalized Gamma noise uncharacterized. Their general converse is a varentropy bound. Their matching theorem requires, among other conditions, that an ordinary escort density can be produced by adding an independent input to the noise. Their concluding discussion correctly cautions that failure of that particular realization does not by itself prove a strict loss in the operational constant.

We resolve the ordinary Gamma subfamily as follows: the complete tightness classification holds for all positive shapes, and exact constants and finite-budget frontiers are obtained for shapes at most two. This is not a solution for arbitrary generalized Gamma noise, or an exact formula for every ordinary Gamma shape. The noise scale can be arbitrary and has no effect on the dimensionless answers.

The methods have important antecedents. Relative-entropy variational bounds, exponential tilting, Laplace inversion, single-crossing comparisons, threshold random coding, and random-codebook approximation are established tools. The related manuscript on two-stage exponential noise under a mean-input constraint [B3] already uses a contact equation, a support gap, a positive differential inverse, and a KL-deficit certificate. For equal unit rates, its zero-multiplier contact equation is exactly the shape-two threshold equation below; that multiplier corresponds to an infinite mean-budget endpoint, not a zero mean budget. Its higher-stage obstruction also uses continuous differentiability of convolution outputs. Neither that threshold nor those general tools and regularity ideas are claimed as newly discovered here. The present additions are the forward-output-KL frontier with a budget-independent clipped tilt, positivity of its fractional inverse throughout a continuous shape interval, the operational matching theorem, the strict finite-KL supremum separation beyond shape two, and the resulting Gamma-wide classification of varentropy tightness. A scale transformation and the exponential-noise endpoint are background consequences, not standalone novelty claims.

### 1.1 Channel and operational convention

Let the noise have unit-scale Gamma density

$$p_\alpha(z)=\frac{z^{\alpha-1}e^{-z}}{\Gamma(\alpha)}\,\mathbf 1_{\{z>0\}},\qquad \alpha>0. \tag{1}$$

For one use, $Y=X+Z$, where $X$ is an arbitrary real-valued Borel input independent of $Z$. There is no input-moment constraint. The off input is zero. All logarithms and information quantities are in nats. Define

$$C_\alpha(d)=\sup\{I(X;X+Z):D(P_{X+Z}\Vert P_Z)\le d\},\qquad d\ge0. \tag{2}$$

This is a relative-entropy-constrained information frontier; a formula for (2) alone is not an operational coding theorem.

For coding, $Z_1,\ldots,Z_n$ are iid and independent of the message and key. A uniformly distributed message $M$ and an independent uniformly distributed finite secret key $K$ determine a real codeword $f(M,K)$. There is no feedback. Both the receiver and the warden observe the same $Y^n=f(M,K)+Z^n$; only the receiver knows $K$. The covertness condition is

$$D(P_{Y^n}\Vert P_Z^{\otimes n})\le\Delta,\qquad \Delta>0, \tag{3}$$

where the output law averages over both message and key. Let $A_n(\Delta,\varepsilon)$ be the supremum of $\log|\mathcal M|$ among such codes with average error at most $\varepsilon$. We use the convention of [B1]:

$$L_\alpha=\lim_{\varepsilon\downarrow0}\liminf_{n\to\infty}\frac{A_n(\Delta,\varepsilon)}{\sqrt{n\Delta}}. \tag{4}$$

Our upper and lower bounds agree in the ranges where an exact value is claimed, so they also identify the corresponding upper limit. We make no maximum-error, feedback, keyless, or optimal-key-length claim.

### 1.2 The statistic that replaces the unrestricted entropy score

Write $\beta=\alpha-1$ and $\ell(z)=-\log p_\alpha(z)$. When $0<\alpha\le1$, set

$$g_\alpha(z)=\ell(z),\qquad c_\alpha=0,\qquad v_\alpha(z)=0. \tag{5}$$

When $\alpha>1$, let $b=b_\alpha>\beta$ be the unique solution of

$$\int_0^b p_\alpha(z)\log\frac{p_\alpha(z)}{p_\alpha(b)}\,dz=0. \tag{6}$$

Set $c_\alpha=-\log p_\alpha(b)$ and

$$g_\alpha(z)=\begin{cases}0,&0 \lt z\le b,\\z-b-\beta\log(z/b),&z>b,\end{cases}\qquad v_\alpha=\ell-c_\alpha-g_\alpha. \tag{7}$$

In both regimes let

$$A(\eta)=\log\mathbb E_p e^{\eta g_\alpha(Z)},\quad q_\eta(z)=p_\alpha(z)e^{\eta g_\alpha(z)-A(\eta)},\quad 0\le\eta<1, \tag{8}$$

$$m=A'(0),\quad V_\alpha=A''(0)=\operatorname{Var}_p(g_\alpha(Z)),\quad d_\eta=\eta A'(\eta)-A(\eta),\quad B_\alpha(d_\eta)=A'(\eta)-m-d_\eta. \tag{9}$$

The notation $\mathbb E_p$ always denotes the unperturbed Gamma law. We prove that $d_\eta$ is a continuous bijection from $[0,1)$ to $[0,\infty)$, so (9) defines $B_\alpha$ on all nonnegative budgets.

### Theorem 1 — Exact frontier and input structure

For every $0<\alpha\le2$ and $d\ge0$,

$$C_\alpha(d)=B_\alpha(d). \tag{10}$$

For $d>0$, the unique optimizing output is $q_\eta$, where $d_\eta=d$, and its independent input law is unique. For $d=0$, the unique admissible input is zero almost surely. For $0<\alpha\le1$, $q_\eta$ is an ordinary Gamma escort, realized by a Gamma variable plus a compound-Poisson variable. For $1<\alpha<2$, the optimizing input has an atom at zero, no mass in $(0,b_\alpha)$, and a positive density on $(b_\alpha,\infty)$ with an integrable singularity at the left endpoint. At $\alpha=2$, the corresponding boundary term is a positive atom at $b_2$, followed by a positive density; no convergence theorem in the shape parameter is asserted.

For all $\alpha>0$, $B_\alpha$ is strictly increasing and strictly concave on $(0,\infty)$ and

$$B_\alpha(d)=\sqrt{2V_\alpha d}+O_\alpha(d)\quad(d\downarrow0). \tag{11}$$

### Theorem 2 — Exact covert constant and the varentropy boundary

For every $0<\alpha\le2$,

$$L_\alpha=\sqrt{2V_\alpha}. \tag{12}$$

A finite key with $\log|\mathcal K_n|=O(n)$ suffices. Define

$$W_\alpha=\operatorname{Var}_p(\log p_\alpha(Z))=2-\alpha+(\alpha-1)^2\psi_1(\alpha), \tag{13}$$

where $\psi_1$ is the trigamma function. Then

$$L_\alpha=\sqrt{2W_\alpha}\quad(0<\alpha\le1),\qquad L_\alpha\le\sqrt{2V_\alpha}<\sqrt{2W_\alpha}\quad(\alpha>1). \tag{14}$$

The first inequality in the second range is equality for $1<\alpha\le2$. Its status for $\alpha>2$ is not determined here. Thus the general varentropy upper bound is tight exactly when $\alpha\le1$.

### Theorem 3 — Finite-budget obstruction above shape two

For every $\alpha>2$ and every $d>0$,

$$C_\alpha(d) \lt B_\alpha(d). \tag{15}$$

The proof rules out even a maximizing sequence approaching $B_\alpha(d)$; it does not merely show that one candidate input fails. Inequality (15) does not assert a strict gap between the leading small-budget coefficients of $C_\alpha$ and $B_\alpha$.

### Theorem 4 — Exact block information bound

For $0<\alpha\le2$, every integer $n\ge1$ and every $\Delta\ge0$,

$$\sup_{D(P_{X^n+Z^n}\Vert p_\alpha^{\otimes n})\le\Delta}I(X^n;X^n+Z^n)=nC_\alpha(\Delta/n), \tag{16}$$

where arbitrary dependence among the input coordinates is allowed, but $X^n$ is independent of the iid noise. For $\Delta>0$, the unique optimizing input is the product of the one-letter optimizer at budget $\Delta/n$. For $\alpha>2$, the right side with $C_\alpha$ replaced by $B_\alpha$ remains a valid upper bound.

## 2. Support, integrability, and the cutoff inequality

### Lemma 2.1 — Finite KL preserves the original input range

If $D(P_{X+Z}\Vert P_Z)<\infty$, then $X\ge0$ almost surely. Moreover $\mathbb E Y<\infty$, $\mathbb E|\log Y|<\infty$, the output entropy is finite, and

$$I(X;Y)=h(Y)-h(Z). \tag{17}$$

**Proof.** If $\mathbb P(X\le-a)>0$ for some $a>0$, independence and $\mathbb P(Z \lt a)>0$ give $\mathbb P(Y<0)>0$, contradicting absolute continuity with respect to $P_Z$. A negative input of positive probability necessarily contains such an event.

For a finite-KL law $Q$, the entropy inequality

$$\mathbb E_Q F\le D(Q\Vert P)+\log\mathbb E_P e^F \tag{18}$$

holds first for bounded $F$ by nonnegativity of relative entropy against the normalized tilt, and then for nonnegative $F$ by truncation. Apply it to $F=tY$ for $0 \lt t<1$, and to $F=s|\log Y|$ for sufficiently small $s<\alpha$. Gamma exponential and positive and negative power moments are finite in those ranges. Thus the cross entropy $\mathbb E_Q\ell(Y)$ is finite in absolute value. The identity $D(Q\Vert P)=-h(Q)+\mathbb E_Q\ell$ then makes $h(Q)$ finite. It can be justified without cancellation of infinities using an exponential reference density, whose log is integrable under $Q$, and truncating the density ratios. Since every conditional output is a translate of $Z$, the conditional entropy equals the finite $h(Z)$, giving (17). Also $0\le X\le Y$ on the joint experiment, so the input has finite mean. ∎

### Lemma 2.2 — Existence and uniqueness of the threshold

For $\alpha>1$, (6) has exactly one root in $(\beta,\infty)$.

**Proof.** Let its left side be $H(b)$. On $(0,\beta]$ the density is increasing, so $H(b)<0$. For $b>\beta$, differentiation gives

$$H'(b)=\left(1-\frac\beta b\right)\int_0^b p_\alpha(z)\,dz>0. \tag{19}$$

The integral of $p\log p$ converges while $\log p(b)\to-\infty$ and the Gamma CDF tends to one; consequently $H(b)\to\infty$. Continuity and strict monotonicity prove the assertion. ∎

### Lemma 2.3 — Single-crossing restriction on every feasible output

For $\alpha>1$, the functions in (7) satisfy

$$\ell=c_\alpha+g_\alpha+v_\alpha,\quad \mathbb E_pv_\alpha=0,\quad g_\alpha v_\alpha=0,\quad \mathbb E_{p*\mu}v_\alpha\le0. \tag{20}$$

The last inequality holds for every nonnegative input law whose output has finite KL. Equality holds precisely when $\mu((0,b))=0$.

**Proof.** The first three assertions follow directly from (6) and (7). On $(0,b)$ the function $v=\log[p(b)/p(z)]$ changes sign exactly once, from positive to negative, at the unique $a\in(0,\beta)$ with $p(a)=p(b)$. For a deterministic input $x\ge0$,

$$\mathbb E v(x+Z)=\int_0^b p(y)v(y)w_x(y)\,dy,\qquad w_x(y)=e^x(1-x/y)_+^\beta. \tag{21}$$

The weight is nondecreasing in $y$. Subtract $w_x(a)$, using $\int pv=0$. Below $a$ the remaining product is nonpositive; above $a$ it is also nonpositive. It is strictly negative whenever $0 \lt x \lt b$, because there is a positive-length interval on which $v<0$ and the weight is strictly larger than its value at the crossing, or is positive while that value is zero. At $x=0$ and at $x\ge b$ the integral is zero. Integrating in $x$ proves the assertion, including the equality condition. The negative part of $v$ is bounded and its positive part is controlled by $1+|\log y|$, so Lemma 2.1 justifies the integrals. ∎

The restriction (20) is stronger than the observation that an ordinary escort cannot be produced. It excludes the low-$z$ entropy-score gain for every possible additive input.

## 3. The dual frontier and its exact deficit

### Lemma 3.1 — The tilt covers every finite budget

For every $\alpha>0$, $A$ is smooth on $[0,1)$, analytic in a neighborhood of zero, and $A''(\eta)>0$. The map $\eta\mapsto d_\eta$ is strictly increasing on $(0,1)$, starts at zero, and tends to infinity as $\eta\uparrow1$.

**Proof.** Exponential domination gives differentiation under the integral on compact parameter intervals. For $\alpha\le1$ a sufficiently small negative parameter is also allowed because $p^{1-\eta}$ stays integrable at zero. In every case $g$ is nonconstant under the positive density $q_\eta$, so $A''=\operatorname{Var}_{q_\eta}g>0$ and $d'_\eta=\eta A''>0$.

For completeness write $r=1-\eta$ and $a_r=1+\beta r$. For $\alpha\le1$,

$$e^{A(\eta)}=\Gamma(\alpha)^{-r}\Gamma(a_r)r^{-a_r}. \tag{22}$$

For $\alpha>1$,

$$e^{A(\eta)}=F_\alpha(b)+p_\alpha(b)^\eta\Gamma(\alpha)^{-r}r^{-a_r}\Gamma(a_r,rb), \tag{23}$$

where $F_\alpha$ is the Gamma CDF and $\Gamma(a,u)=\int_u^\infty t^{a-1}e^{-t}dt$. These are exact integral evaluations. As $r\downarrow0$, $a_r\to1$; the Gamma and truncated-Gamma integrals tend to one. Their parameter derivatives grow at most logarithmically in $r$: this follows by integrating $1+|\log t|$ on $(0,1)$ and the exponential tail on $(1,\infty)$, with the lower-limit contribution treated explicitly. Equations (22)–(23) give

$$A(\eta)=-\log r+O_\alpha(1+r|\log r|),\qquad A'(\eta)=r^{-1}+O_\alpha(1+|\log r|). \tag{24}$$

Thus $d_\eta=\eta A'-A\to\infty$. ∎

### Lemma 3.2 — Global entropy-deficit identity

Let $d=d_\eta>0$, $\lambda=(1-\eta)/\eta$, and let $Q=p*\mu$ have $D(Q\Vert p)\le d$. Then

$$B_\alpha(d)-[h(Q)-h(p)]
=\lambda[d-D(Q\Vert p)]+\frac1\eta D(Q\Vert q_\eta)-\mathbb E_Qv_\alpha\ge0. \tag{25}$$

For $\alpha\le1$ the final term is identically zero; for $\alpha>1$ it is nonnegative by Lemma 2.3.

**Proof.** From (20), or (5), $h(p)=c_\alpha+m$ and

$$h(Q)-h(p)=\mathbb E_Qg_\alpha-m+\mathbb E_Qv_\alpha-D(Q\Vert p). \tag{26}$$

Since $\log(q_\eta/p)=\eta g-A$, the identity

$$D(Q\Vert q_\eta)=D(Q\Vert p)-\eta\mathbb E_Qg+A \tag{27}$$

gives (25) by substitution. All terms are finite by Lemma 2.1 and the growth bounds on $g$ and $v$. For $q_\eta$, $\mathbb E_{q_\eta}v=e^{-A}\mathbb E_pv=0$ and $D(q_\eta\Vert p)=d$, which also verifies the expression for $B$ in (9). ∎

Equation (25) proves both the bound and uniqueness of the optimizing output whenever it is feasible. It also gives the quantitative stability estimate

$$D(Q\Vert q_\eta)\le\eta\{B_\alpha(d)-[h(Q)-h(p)]\}. \tag{28}$$

### Lemma 3.3 — Slope, strict concavity, and the small-budget constant

For $d>0$,

$$B_\alpha'(d)=\frac{1-\eta}{\eta},\qquad B_\alpha''(d)=-\frac1{\eta^3A''(\eta)}<0. \tag{29}$$

Moreover (11) holds, with constants depending on the fixed shape.

**Proof.** Differentiate (9): $d'_\eta=\eta A''$ and $[B(d_\eta)]'=(1-\eta)A''$. Division gives the first formula and a further derivative gives the second. Local analyticity gives

$$d_\eta=\tfrac12V_\alpha\eta^2+O_\alpha(\eta^3),\qquad B_\alpha(d_\eta)=V_\alpha\eta+O_\alpha(\eta^2). \tag{30}$$

Since $V_\alpha>0$, inversion yields (11). These estimates are for each fixed shape; no uniformity as the shape approaches zero or infinity is asserted. ∎

## 4. Positive input realizations

### Proposition 4.1 — Ordinary escorts for shapes at most one

For $0<\alpha\le1$, let $r=1-\eta$ and $a_r=1+(\alpha-1)r$. Then $q_\eta$ is Gamma with shape $a_r$ and rate $r$. It is realized by a nonnegative independent input with Laplace transform

$$\widehat\mu_\eta(s)=\left[\frac{r(1+s)}{r+s}\right]^\alpha\left[\frac r{r+s}\right]^{a_r-\alpha},\qquad s\ge0. \tag{31}$$

**Proof.** Here $a_r-\alpha=\eta(1-\alpha)\ge0$. The second factor is the Laplace transform of a Gamma variable of that shape and rate $r$, interpreted as zero when the shape is zero. The first factor is compound Poisson: its finite nonnegative Lévy measure is

$$\nu(dx)=\alpha\frac{e^{-rx}-e^{-x}}x\,dx,\qquad \nu((0,\infty))=\alpha\log(1/r). \tag{32}$$

Integrating $\int(e^{-sx}-1)\nu(dx)$, or first differentiating in $s$ and then using the value at zero, gives the logarithm of the first factor. Hence (31) is a probability Laplace transform. Multiplication by $(1+s)^{-\alpha}$ gives $(r/(r+s))^{a_r}$, the transform of $q_\eta$. At $\eta=0$ the input is zero. ∎

The endpoint $\alpha=1$ reduces to the familiar exponential-noise construction: the input is zero with mass $r$ and has a rate-$r$ exponential component with mass $1-r$. For $\alpha<1$ the noise density is unbounded near zero. The coding proof below therefore verifies its own integrability conditions rather than invoking the bounded-density achievability hypothesis of [B1].

### Proposition 4.2 — Positive fractional inverse for shapes between one and two

Suppose $1<\alpha\le2$, $\beta=\alpha-1$, and $0<\eta<1$. Let

$$k_\eta(x)=x^\beta(e^{\eta g_\alpha(x)}-1)\mathbf1_{\{x>b\}},\qquad \sigma_\eta=D^2 k_\eta \tag{33}$$

with the derivative taken distributionally on the line, extending $k$ by zero to the left. Then $\sigma_\eta$ is a positive measure supported on $[b,\infty)$. Define the fractional integral of a positive measure by

$$ (I^\rho\sigma)(dx)=\frac1{\Gamma(\rho)}\left[\int_{[0,x)}(x-t)^{\rho-1}\sigma(dt)\right]dx\quad(\rho>0),\qquad I^0\sigma=\sigma. \tag{34}$$

The optimizing input is

$$\mu_\eta=e^{-A(\eta)}\delta_0+\frac{e^{-A(\eta)}}{\Gamma(\alpha)}e^{-x}I^{2-\alpha}\sigma_\eta(dx). \tag{35}$$

It is a probability measure and satisfies $p_\alpha*\mu_\eta=q_\eta$.

**Proof of positivity.** At $b$, $k$ is continuous with value zero and its derivative has the positive jump

$$k'(b+)=\eta b^{\beta-1}(b-\beta)>0. \tag{36}$$

For $x>b$, writing $E=e^{\eta g(x)}$, direct differentiation gives

$$\frac{k''(x)}{x^{\beta-2}E}=-\beta(1-\beta)(1-E^{-1})+\eta\beta(2x-2\beta+1)+\eta^2(x-\beta)^2. \tag{37}$$

Because $0\le g(x)\le x-b$ and $1-e^{-\eta g}\le\eta g$, the right side is at least

$$\eta\beta[(1+\beta)x+(1-\beta)b-2\beta+1]+\eta^2(x-\beta)^2>0. \tag{38}$$

Indeed the bracket is increasing in $x\ge b$ and at $b$ equals $2b-2\beta+1>1$. Thus $\sigma=k'(b+)\delta_b+k''(x)\mathbf1_{x>b}dx$ is positive. Equation (34) preserves positivity.

**Proof of convolution and normalization.** The function $k$ and its derivatives have exponential growth of rate $\eta<1$ times powers of $x$. Its values and derivatives vanish near zero. Therefore, for $s\ge0$, integration by parts and Tonelli's theorem give

$$\mathcal L(D^2k)(s+1)=(s+1)^2\mathcal Lk(s+1),\qquad
\mathcal L(e^{-x}I^{2-\alpha}\sigma)(s)=(s+1)^\alpha\mathcal Lk(s+1). \tag{39}$$

All transforms are finite, including at $s=0$. Multiplying the transform of (35) by $(1+s)^{-\alpha}$ gives the transform of

$$e^{-A}p_\alpha(x)+\frac{e^{-A}}{\Gamma(\alpha)}e^{-x}k(x)=q_\eta(x). \tag{40}$$

Uniqueness of Laplace transforms for finite measures proves the convolution identity. At $s=0$ it also shows that the total input mass is one. For each fixed $1<\alpha<2$, the atom in $\sigma$ contributes the positive locally integrable density proportional to $e^{-x}(x-b)^{1-\alpha}$; the remaining density is positive on the whole open tail. At $\alpha=2$, $I^0$ preserves the atom. There is no mass between zero and $b$. ∎

### Proposition 4.3 — Explicit shape-two input and uniqueness

For $\alpha=2$, with $a=e^{-A(\eta)}$, (35) is

$$\mu_\eta=a\delta_0+\eta q_\eta(b)(1-1/b)\delta_b+
\eta q_\eta(x)\left[\eta+\frac{2(1-\eta)}x-\frac{1-\eta}{x^2}\right]\mathbf1_{x>b}dx. \tag{41}$$

The bracket is strictly positive because $x>b>1$. This follows either from (35), or by applying $(D+1)^2$ to $q_\eta$ and keeping the boundary atoms. For every shape considered in Propositions 4.1–4.2, the input is unique: its Laplace transform must equal $\widehat q(s)(1+s)^\alpha$, and Laplace transforms identify nonnegative probability laws. One elementary uniqueness justification maps $x$ to $e^{-x}\in(0,1]$: equality of transforms at all integer arguments gives equality against polynomials, then against continuous functions on $[0,1]$ by uniform approximation, hence equality of the pushed-forward measures. The zero-budget case follows in the same way, or from $\mathbb E X=\mathbb E Y-\alpha=0$. Together with (25), these propositions prove Theorem 1. ∎

## 5. The obstruction for larger shapes and the strict varentropy loss

### Proposition 5.1 — Strict finite-budget separation for every shape above two

For $\alpha>2$ and $\eta>0$, $q_\eta$ is not a Gamma convolution output. Moreover its frontier value cannot be approached by feasible outputs at budget $d_\eta$.

**Proof.** The regularity obstruction extends the integer-stage argument of [B3, Lemma 8.1 and Theorem 8.2]; the strict-supremum argument below is additional. Extended by zero to the negative line, $p_\alpha$ is continuously differentiable with a bounded uniformly continuous derivative. Thus, for every probability measure $\mu$, $p_\alpha*\mu$ has a continuous derivative, obtained by differentiation under the integral. The continuous density $q_\eta$, however, has derivative jump

$$q_\eta'(b+)-q_\eta'(b-)=-\eta q_\eta(b)(\beta/b-1)>0. \tag{42}$$

It cannot coincide even almost everywhere with a continuously differentiable convolution density: both densities are continuous, so almost-everywhere equality would be pointwise equality.

Suppose a feasible sequence $Q_j=p*\mu_j$ at budget $d_\eta$ had entropy increments approaching $B_\alpha(d_\eta)$. By (28), $D(Q_j\Vert q_\eta)\to0$, hence the output laws converge in total variation, by Pinsker's inequality. They are tight. In a coupling $X_j\ge0$ and $Y_j=X_j+Z\ge X_j$, so $\mathbb P(X_j>R)\le\mathbb P(Y_j>R)$; the input laws are also tight. A subsequence converges weakly to a probability measure $\mu$ on $[0,\infty)$. Convolution with the fixed noise is weakly continuous: for a bounded continuous test function $f$, the function $x\mapsto\mathbb E f(x+Z)$ is bounded continuous. Its limit output must be $q_\eta$, contradicting the derivative obstruction. Therefore even the supremum is strictly below $B_\alpha(d_\eta)$. This proves Theorem 3. ∎

### Proposition 5.2 — Orthogonal loss in the entropy score

For every $\alpha>1$,

$$W_\alpha=V_\alpha+\operatorname{Var}_p(v_\alpha(Z)),\qquad \operatorname{Var}_p(v_\alpha(Z))>0. \tag{43}$$

**Proof.** From (20), $\mathbb E_pv=0$ and $gv=0$, so $\operatorname{Cov}_p(g,v)=0$. All second moments are finite. The lower-tail function $v$ is nonzero on sets of positive Gamma measure, giving the strict inequality. For $\alpha\le1$, $g=\ell$ and $V_\alpha=W_\alpha$. Finally, $\operatorname{Var}(Z)=\alpha$, $\operatorname{Var}(\log Z)=\psi_1(\alpha)$, and $\operatorname{Cov}(Z,\log Z)=1$. These identities follow by differentiating $\mathbb E Z^t=\Gamma(\alpha+t)/\Gamma(\alpha)$ at $t=0$ and $t=1$. Expansion of $\ell=Z-\beta\log Z+\log\Gamma(\alpha)$ yields (13). ∎

This proof supplies a strict converse for all additive inputs at all shapes greater than one; it does not infer a loss from a failed escort construction. For $\alpha>2$ it proves a strict loss relative to varentropy while leaving open whether the clipped upper coefficient itself is sharp.

## 6. Block information and the operational converse

### Proposition 6.1 — Tensorization with an output-divergence budget

If $D(Q_{Y^n}\Vert p^{\otimes n})\le\Delta$, let $d_i=D(Q_{Y_i}\Vert p)$. Relative entropy decomposes into the sum of marginal divergences and total correlation, so $\sum_i d_i\le\Delta$. Entropy subadditivity and independence of the noise from the input give

$$I(X^n;Y^n)=h(Y^n)-nh(p)\le\sum_i[h(Y_i)-h(p)]
\le\sum_i B_\alpha(d_i)\le nB_\alpha(\Delta/n). \tag{44}$$

The last step is strict-concavity Jensen together with monotonicity. The integrals are finite by the multivariate version of Lemma 2.1, applied to the sum of coordinate entropy scores. For $\alpha\le2$, iid optimizing inputs attain equality, proving (16). At positive budget, equality forces identical positive marginal budgets, all optimizing marginal outputs, and zero total correlation. The output is therefore $q_\eta^{\otimes n}$. The joint Laplace transform of the input is uniquely determined by division by $\prod_i(1+s_i)^{-\alpha}$, hence is the product of the one-letter transforms. This proves the uniqueness assertion in Theorem 4. ∎

### Proposition 6.2 — Covert converse

For any code of average error $\varepsilon$, conditional Fano gives

$$ (1-\varepsilon)\log|\mathcal M|-\log2\le I(M;Y^n\mid K)\le I(X^n;Y^n)\le nB_\alpha(\Delta/n). \tag{45}$$

The middle inequality follows from independence of $M,K$ and the Markov chain $(M,K)\to X^n\to Y^n$, equivalently by subtracting $I(K;Y^n)$ from $I(M,K;Y^n)$. By (11), division by $\sqrt{n\Delta}$ and the limits in (4) imply

$$L_\alpha\le\sqrt{2V_\alpha}\qquad(\alpha>0). \tag{46}$$

Together with (43), this already proves strict looseness of the varentropy bound for every $\alpha>1$.

## 7. Coding achievability with a finite secret key

This section proves the missing operational bridge for every fixed $0<\alpha\le2$. It uses the feasible exact family from Section 4; it does not assume the ordinary-escort condition from [B1].

### Lemma 7.1 — Small-tilt information density is uniformly integrable

Let $X_\eta\sim\mu_\eta$, $Z\sim p_\alpha$ independently and $Y_\eta=X_\eta+Z\sim q_\eta$. Define

$$i_\eta(X_\eta;Y_\eta)=\log\frac{p_\alpha(Z)}{q_\eta(Y_\eta)}
=X_\eta-\beta\log(1+X_\eta/Z)-\eta g_\alpha(Y_\eta)+A(\eta). \tag{47}$$

As $\eta\downarrow0$, $\mathbb E i_\eta=C_\alpha(d_\eta)$ and $\mathbb E i_\eta^2\to0$.

**Proof.** The exact Gamma or clipped-Gamma densities in Section 3 have uniformly bounded exponential moments of a fixed positive order for all sufficiently small $\eta$, and their means converge to $\alpha$. Since $0\le X_\eta\le Y_\eta$,

$$\mathbb E X_\eta=\mathbb E Y_\eta-\alpha\to0. \tag{48}$$

Thus $X_\eta\to0$ in probability and its fourth moments are uniformly bounded. The elementary inequality

$$\log(1+x/z)\le\log(1+x)+\log(1+1/z),\qquad x\ge0,z>0, \tag{49}$$

and the finite fourth log moment of a Gamma variable give a uniform fourth-moment bound for the log term in (47). This term tends to zero in probability: split at $Z\ge a>0$, then let $a\downarrow0$. For $\alpha>1$, $0\le g(Y)\le Y$. For $\alpha\le1$, $|g(Y)|\le C_\alpha(1+Y+|\log^-Y|)$ and $|\log^-Y|\le|\log^-Z|$. Consequently $\eta g(Y_\eta)\to0$ in $L^2$ and also has uniformly bounded fourth moments. The remaining term $A(\eta)$ tends to zero. Equation (47) therefore tends to zero in probability and has uniformly bounded fourth moments, which implies convergence in $L^2$. The mean identity is mutual information and Theorem 1. ∎

### Lemma 7.2 — A uniform positive information-density moment

For each fixed $0<\alpha\le2$, there are $\rho\in(0,1)$, $C\ge1$, and $\eta_0>0$ such that

$$\mathbb E e^{\rho i_\eta(X_\eta;Y_\eta)}\le C\qquad(0\le\eta\le\eta_0). \tag{50}$$

**Proof.** If $\alpha>1$, then $q_\eta\ge e^{-A}p$, $\beta>0$, and

$$\frac{p(Z)}{q_\eta(X+Z)}\le e^{A}e^X. \tag{51}$$

Use $X\le Y$ and a uniform small positive exponential moment of $q_\eta$.

For $0<\alpha\le1$, put $u=1-\alpha\in[0,1)$, $r=1-\eta$, and $a_r=1-u r$. The explicit Gamma density gives, with constants uniformly bounded for small $\eta$,

$$\frac{p(Z)}{q_\eta(X+Z)}=C_\eta e^{rX-\eta Z}Z^{-u}(X+Z)^{u r}
\le 2C_\eta e^X Z^{-u}(1+X)^u(1+Z)^u. \tag{52}$$

Choose $\rho>0$ sufficiently small that $\rho u<\alpha$ and that $e^{\rho X}(1+X)^{\rho u}$ is controlled by a uniform exponential moment of $Y$. Independence of $X,Z$ then factors the moment bound; $\mathbb E[Z^{-\rho u}(1+Z)^{\rho u}]<\infty$ by the chosen inequality. This proves (50), including the exponential endpoint. ∎

### Lemma 7.3 — Two elementary random-codebook bounds

For a channel with measurable conditional densities $W_x$ and an input law $P$ whose output density is $Q$, use the likelihood ratios $W_x/Q$ on the support of $Q$ (defined $P$-almost surely). An iid codebook of $M$ codewords admits a threshold decoder with expected average error at most

$$\mathbb P\{i(X;Y)\le\log M+\gamma\}+e^{-\gamma},\qquad \gamma>0. \tag{53}$$

For a collection of $N$ iid codewords and its equally weighted output mixture $Q_{\mathsf C}$,

$$\mathbb E_{\mathsf C}D(Q_{\mathsf C}\Vert Q)
\le\frac1{\rho N^\rho}\mathbb E e^{\rho i(X;Y)},\qquad 0<\rho<1. \tag{54}$$

**Proof.** For (53), decode a codeword whose likelihood ratio to $Q$ exceeds $Me^\gamma$, breaking ties by a fixed rule. The sent codeword misses this threshold with the first probability. Each independent competing codeword crosses it with conditional probability at most $1/(Me^\gamma)$, because its expected likelihood ratio at a fixed output is one. A union bound proves (53).

For (54), select the transmitted codeword uniformly from the mixture. By symmetry call it the first. Conditional Jensen on all other codewords gives

$$\mathbb E_{\mathsf C}D(Q_{\mathsf C}\Vert Q)
\le\mathbb E_{X,Y}\log\left(1+\frac{W_X(Y)}{NQ(Y)}\right)
\le\frac1{\rho N^\rho}\mathbb E_{X,Y}\left(\frac{W_X(Y)}{Q(Y)}\right)^\rho. \tag{55}$$

The scalar bound $\log(1+t)\le t^\rho/\rho$ follows by integrating $(1+t)^{-1}\le t^{\rho-1}$. The argument applies to densities and mixed input laws alike. ∎

### Proof of Theorem 2, achievability

Fix $0<\Delta'<\Delta$ and $0<\zeta<1$. Choose $\eta_n$ uniquely so that $d_{\eta_n}=\Delta'/n$. Then $\eta_n\to0$, and with $I_n=C_\alpha(\Delta'/n)$,

$$nI_n=\sqrt{2V_\alpha\Delta'n}+O_{\alpha,\Delta'}(1). \tag{56}$$

For each key, draw $M_n=\lfloor\exp((1-\zeta)nI_n)\rfloor$ iid codewords from $\mu_{\eta_n}^{\otimes n}$. Choose $K_n=\lceil\exp(cn)\rceil$ independent such codebooks, where $c$ is large enough that $\rho c>\log C+2$ in (50). Thus the full collection has $N=M_nK_n$ iid codewords and a finite key with $\log K_n=O(n)$.

Apply (53) separately at each key with $\gamma=\zeta nI_n/2$. The information density is a sum of iid coordinates. Chebyshev's inequality and Lemma 7.1 give an expected average error tending to zero, because

$$\frac{n\operatorname{Var}(i_{\eta_n})}{(\zeta nI_n/2)^2}\longrightarrow0. \tag{57}$$

Only $\operatorname{Var}(i_{\eta_n})\to0$ is needed; no unproved rate of that convergence is being used. The exponential remainder in (53) also tends to zero.

By (50) and (54), the full mixed output satisfies

$$\mathbb E_{\mathsf C}D(Q_{\mathsf C}\Vert q_{\eta_n}^{\otimes n})\le\rho^{-1}e^{-2n}. \tag{58}$$

The exact averaging identity, not a triangle inequality, now gives

$$\mathbb E_{\mathsf C}D(Q_{\mathsf C}\Vert p^{\otimes n})
=\mathbb E_{\mathsf C}D(Q_{\mathsf C}\Vert q_{\eta_n}^{\otimes n})+D(q_{\eta_n}^{\otimes n}\Vert p^{\otimes n})
\le\Delta'+\rho^{-1}e^{-2n}. \tag{59}$$

To justify the identity, expand the two divergences: the remaining term is the integral of $\log(q_{\eta_n}^{\otimes n}/p^{\otimes n})$ against $Q_{\mathsf C}$; averaging replaces the random mixture by its mean $q_{\eta_n}^{\otimes n}$. Absolute integrability follows from the Gamma log and exponential moments already established.

Let $e_n$ be the expected error. By Markov's inequality the probability that a codebook's error exceeds $\sqrt{e_n}$ is at most $\sqrt{e_n}$, while the probability that its KL exceeds $\Delta$ is at most $\Delta'/\Delta+o(1)<1$. Hence for every sufficiently large $n$ at least one fixed finite codebook satisfies both the original KL budget and error tending to zero. Its message rate obeys

$$\liminf_n\frac{\log M_n}{\sqrt{n\Delta}}\ge(1-\zeta)\sqrt{\frac{2V_\alpha\Delta'}\Delta}. \tag{60}$$

Let $\zeta\downarrow0$ and $\Delta'\uparrow\Delta$. Combining with (46) proves (12). Equation (43) then proves the tightness classification (14). The code can be chosen separately for each $n$; finitely many initial blocklengths can use the trivial off code. ∎

## 8. Scale, numerical illustrations, and reproducibility

For Gamma noise of scale $\theta>0$, replace $(X,Y,Z)$ by $(X/\theta,Y/\theta,Z/\theta)$. Relative entropy and mutual information are invariant under this invertible change of variables. The same transformation applies to codewords and decoders. Thus all frontiers and constants above are unchanged, and the nonzero input threshold becomes $\theta b_\alpha$.

The following values are numerical illustrations, not interval-certified inequalities:

| Shape $\alpha$ | Cutoff $b_\alpha$ | $V_\alpha$ | Sharp $L_\alpha$ | Varentropy upper bound |
|---|---:|---:|---:|---:|
| 1 | 0 (endpoint convention) | 1 | 1.41421356237 | 1.41421356237 |
| 1.1 | 0.193891065410 | 0.913947179103 | 1.35199643424 | 1.35228176909 |
| 1.5 | 0.885038103414 | 0.720540204179 | 1.20045008574 | 1.21136332298 |
| 2 | 1.646403987356 | 0.607935427955 | 1.10266534176 | 1.13572361677 |

For shape two, $W_2=\pi^2/6-1$ and $W_2-V_2\approx0.036998638894$. The strictness of the gap comes from (43), not these decimals. Reproduction materials evaluate the cutoff equation, variances, input normalization and convolution, dual residuals, and small-budget slopes using both high-precision quadrature and an independent floating-point implementation. Finite diagnostics do not establish universal statements or replace the analytic proof.

## 9. Scope and unresolved questions

The result uses forward KL from the actual output to the off-output law, arbitrary nonnegative amplitudes forced by finite KL, independent additive noise, average error, no feedback, and a secret key unavailable to the warden. Reverse KL, unequal receiver and warden noise, peak or mean input constraints, maximum-error guarantees, and optimal key consumption are different problems. For $\alpha>2$ we prove both an improved covert upper bound and strict finite-budget separation from the clipped frontier; we do not calculate the exact covert constant or claim separation from that frontier at the leading square-root order. We also do not treat general stretched-Gamma noise.

This mathematical research manuscript has not undergone external peer review.

## References and attribution

- **[B1]** Cécile Bouette, Laura Luzzi, Ligong Wang. *Covert Communication Over Additive-Noise Channels*. IEEE Transactions on Information Theory 71(3), 2157–2169, 2025. DOI: [10.1109/TIT.2024.3522151](https://doi.org/10.1109/TIT.2024.3522151). Technical comparison uses the full accepted author version [arXiv:2402.16475v2](https://arxiv.org/html/2402.16475v2), especially §§II–IV, §V-C Remark 3, §VII, and Appendix B.
- **[B2]** Cécile Bouette. *Information-theoretic limits of covert communication over additive-noise channels*. Doctoral thesis, CY Cergy Paris Université, defended 23 January 2025. [Official full text](https://theses.fr/api/v1/document/2025CYUN1361), §3.4.4 Remark 3.5. Used as a later statement of the same open branch, not as an independent proof of the present results.
- **[B3]** *Two-stage exponential noise: exact capacity, unique mixed input, and a stage-count structural boundary*. Research manuscript. Its mean-input-cost constraint differs from (2). The contact-threshold, inverse-convolution, and duality precedents described in §1 are explicitly inherited.

