# Spurious Local Minima and Certified Global Optimization in Two-Sensor Switched-Linear Scheduling

Research manuscript · 25 November 2026

## Abstract

A central scheduler observes two scalar measurements, transmits one measurement and its index, and reconstructs the missing measurement linearly. The resulting two-parameter mean-square objective is nonconvex. We resolve its spurious-local-minimum existence question for every centered elliptical source with finite second moments and positive-definite covariance: a strict nonglobal local minimum exists if and only if the covariance between the two measurements is nonzero. The proof controls the singular parameter boundary and escape to infinity. An exact envelope by positive-definite quadratic functions also yields a quantitative improvement map for every coefficient pair whose product exceeds one. For arbitrary covariance, the global optimum and all its coefficient realizations reduce to a scalar minimization on an explicit compact interval. Monotone endpoint bounds provide a terminating certification procedure for any prescribed error. Finally, an explicit rational covariance gives a positive-Hessian nonglobal minimum attracting an open set of initializations of the published population convex–concave procedure. The equal-variance global solution is recovered with its prior attribution. The results concern the specified two-sensor linear reconstruction class, rather than unrestricted nonlinear estimation.

## 1. Model, prior work, and precise contribution

### 1.1 The established estimation problem

The scheduler sees $X=(X_1,X_2)$, sends either $(1,X_1)$ or $(2,X_2)$, and makes no modification of the transmitted scalar. Upon receiving $X_2$, the receiver estimates $X_1$ by $aX_2$; upon receiving $X_1$, it estimates $X_2$ by $bX_1$. The transmitted coordinate is recovered exactly. For fixed $a,b\in\mathbb R$, choosing the smaller of the two reconstruction errors pointwise gives
```math
 J(a,b)=\mathbb E\min\{(X_1-aX_2)^2,(X_2-bX_1)^2\}.
 \tag{1.1}
```
Ties may be resolved arbitrarily. This reduction and the underlying scheduling problem belong to [1, Proposition 1]. Its equal-variance Gaussian optimum is already given in [1, Theorem 5]; the same paper supplies a DC decomposition and a local CCP algorithm for general covariance. We retain these attributions.

The question whether this objective has spurious local minima is posed in [2, §2.1.3]. Data-based DC/CCP design for broader sensor models is developed in [3]. Our global population analysis neither supersedes those broader models nor establishes a finite-sample guarantee. Nonlinear basis-function approximation and empirical training for the same centralized architecture are studied in [5]; those results do not give the population landscape classification or certified global optimization of the two-slope objective considered here.

A relevant flagship comparison is [4], which studies uncoordinated independent sensors on a collision channel and proves optimal-policy structure. Our centralized information pattern and restricted reconstruction class are different. The common technical issue is how information constraints separate local design from a globally justified policy.

**Definition 1.1 (source class).** Throughout, $p,q>0$, $c^2 \lt pq$, and
```math
 \Sigma=\begin{pmatrix}p&c\\c&q\end{pmatrix},\quad
 d=\sqrt{pq-c^2}>0,\quad \rho=\frac{c}{\sqrt{pq}}.
 \tag{1.2}
```
A centered elliptical source with covariance $\Sigma$ means
```math
 X=RLU,\qquad LL^{\mathsf T}=\Sigma,\qquad
 U\sim\operatorname{Unif}(S^1),\quad R\perp U,\quad
 R\ge0,\quad\mathbb E R^2=2.
 \tag{1.3}
```
An atom of $R$ at zero is allowed. No density of $R$ is assumed. This normalization gives $\mathbb EX=0$ and $\mathbb E XX^{\mathsf T}=\Sigma$. In a non-Gaussian elliptical model, $c=0$ means zero correlation and need not mean independence.

A strict spurious local minimum is a coefficient pair that is a strict local minimum in the full space $\mathbb R^2$, but does not minimize (1.1) globally.

### 1.2 Results and scope

**Theorem 1.2 (existence classification).** Under Definition 1.1:

1. If $c=0$, the only local minimum and the only global minimum of $J$ is $(0,0)$.
2. If $c\ne0$, there is a strict spurious local minimum in
```math
 \Omega_c=\{(a,b):ab>1,\ \operatorname{sign}a=\operatorname{sign}b=\operatorname{sign}c\}.
 \tag{1.4}
```
3. No point with $ab=1$ is a local minimum. Every point with $ab>1$, stationary or otherwise, has an explicit strictly better coefficient pair with product less than one.

The proof appears in Sections 3 and 5. This is a complete existence criterion. It is not a count or classification of every stationary point.

**Theorem 1.3 (global design).** The global minimum is attained. After interchanging source labels if necessary so that $p\ge q$, it equals
```math
 \min_{a,b\in\mathbb R}J(a,b)
   =\min_{0\le z\le Z}F_+(z),\qquad Z=\frac{p-q}{2d},
 \tag{1.5}
```
where $F_+$ is explicit in (3.7). Formula (3.6) reconstructs every global coefficient pair from a minimizing $z$. Section 4 gives endpoint enclosures that converge to this minimum and produce arbitrarily accurate certified policies.

**Theorem 1.4 (algorithmic failure).** For $p=q=1$, $c=24/25$, the population CCP of [1] has a strict nonglobal fixed point with positive-definite Hessian and a nonempty open basin of attraction. Its coordinates, risk gap, and Hessian are given in Section 6.

The new contributions are the existence criterion, the quantitative branch correction, the all-covariance compact global characterization and its error certificates, and the attracting failure mechanism. Radial invariance of a homogeneous objective is an elementary extension of scope, not a separate claim of substantial novelty. We do not claim results for three or more sensors, arbitrary nonelliptical laws, unrestricted nonlinear reconstruction, affine offsets, communication noise, or dynamic scheduling. We also do not claim that every local minimum with $ab<1$ is global, or that CCP has a global convergence guarantee.

## 2. Reduction to an elementary angular integral

**Lemma 2.1 (radial invariance).** If $h:\mathbb R^2\to\mathbb R$ is measurable, homogeneous of degree two, and $|h(x)|\le C\|x\|^2$, then its expectation under (1.3) equals its expectation under $N(0,\Sigma)$.

**Proof.** Conditioning on $U$ gives $\mathbb E h(RLU)=2\mathbb E h(LU)$. A standard two-dimensional Gaussian has independent uniform direction and radius with second moment two, so the same equality holds for the Gaussian expectation. The quadratic bound justifies integrability and conditioning. In particular this applies, for every fixed coefficient pair, to the minimum and maximum of the two squared residuals. Thus their entire objective functions, and their derivatives wherever these exist, coincide across the stated elliptical class. $\square$

Set
```math
 A=p+qa^2-2ca,\quad B=q+pb^2-2cb,\quad
 t=A-B,\quad u=2d|1-ab|.
 \tag{2.1}
```

**Lemma 2.2 (exact risk).** If $ab\ne1$, then
```math
 J(a,b)=\frac{A+B}{2}
       -\frac{u+t\arctan(t/u)}{\pi}.
 \tag{2.2}
```
If $ab=1$, then $J(a,b)=\min(A,B)$. These formulas agree by continuity.

**Proof.** By Lemma 2.1 it is enough to use a standard Gaussian $Z$ and write $X=LZ$. The difference of the two squared residuals is $Z^{\mathsf T}HZ$ for a symmetric matrix $H$. Its trace is $t$, and its determinant is $-d^2(1-ab)^2$. For $ab\ne1$, its eigenvalues can be written $\lambda>0$ and $-\mu<0$, with $\lambda-\mu=t$ and $2\sqrt{\lambda\mu}=u$.

After rotating the uniform angular variable and using its radial second moment,
```math
 \mathbb E|Z^{\mathsf T}HZ|
 =\frac1\pi\int_0^{2\pi}
       |\lambda\cos^2\theta-\mu\sin^2\theta|\,d\theta
 =\frac2\pi\{u+t\arctan(t/u)\}.
 \tag{2.3}
```
For the last equality, split each quadrant at
$\theta_0=\arctan\sqrt{\lambda/\mu}$, integrate with the primitive
```math
 \frac{\lambda-\mu}{2}\theta+
 \frac{\lambda+\mu}{4}\sin(2\theta),
```
and use
$\sin(2\theta_0)=2\sqrt{\lambda\mu}/(\lambda+\mu)$ and
$2\theta_0-\pi/2=\arctan(t/u)$.
Now apply $\min(v,w)=(v+w-|v-w|)/2$.

If $ab=1$, the residuals are proportional, so their pointwise smaller square has expectation $\min(A,B)$. Equivalently,
$u+t\arctan(t/u)\to\pi|t|/2$ as $u\downarrow0$, including its zero value at $t=0$. Local domination by a fixed multiple of $\|X\|^2$ also proves continuity in $a,b$. $\square$

In particular, $J$ is real analytic on each open set $ab<1$ and $ab>1$. Any possible singularity of the coefficient parametrization is explicitly confined to $ab=1$.

## 3. A positive quadratic envelope and a certified escape

For $z\in\mathbb R$, define
```math
 \begin{split}
 w(z)&=\frac12-\frac{\arctan z+z/(1+z^2)}{\pi},\\
 v(z)&=1-w(z),\qquad k(z)=\frac1{\pi(1+z^2)},\\
 P(z)&=w(z)v(z),\qquad D(z)=pqP(z)-d^2k(z)^2,\\
 K(z)&=\frac{d^2(P(z)-k(z)^2)}{D(z)}.
 \end{split}
 \tag{3.1}
```

**Lemma 3.1 (strict positivity).** For every finite $z$,
```math
 0 \lt w(z)<1,\qquad P(z)>k(z)^2,\qquad D(z)>0,\qquad K(z)>0.
 \tag{3.2}
```

**Proof.** The function $\arctan z+z/(1+z^2)$ has derivative
$2/(1+z^2)^2>0$ and endpoint limits $\pm\pi/2$, proving the assertion about $w$. Write $\theta=\arctan z$. Direct expansion gives
```math
 \pi^2P-\cos^4\theta
 =\frac{\pi^2}{4}
  -\{\theta^2+\theta\sin(2\theta)+\cos^2\theta\}.
 \tag{3.3}
```
The expression in braces is even and has derivative $4\theta\cos^2\theta$. It increases strictly from $1$ to $\pi^2/4$ as $\theta$ runs from $0$ to $\pi/2$. This proves $P>k^2$. Finally $d^2\le pq$ implies $D\ge pq(P-k^2)>0$, and the formula for $K$ completes the proof. $\square$

For $s\in\{+1,-1\}$, let
```math
 Q_s(a,b;z)=wA+vB-s\,2dk(1-ab),\qquad
 M_s(z)=\begin{pmatrix}qw&s\,dk\\s\,dk&pv\end{pmatrix}.
 \tag{3.4}
```

**Lemma 3.2 (exact lower envelope).** For all $a,b$,
```math
 J(a,b)=\inf_{s\in\{+1,-1\},\,z\in\mathbb R}Q_s(a,b;z).
 \tag{3.5}
```
When $ab\ne1$, equality is attained at
$s=\operatorname{sign}(1-ab)$, $z=t/u$. Each $Q_s(\cdot;z)$ is a strictly convex quadratic with unique minimizer
```math
 \beta_s(z)=\binom{a_s(z)}{b_s(z)}
  =M_s(z)^{-1}c\binom{w}{v},\qquad
 a_s=\frac{cv(pw-sdk)}{D},\quad
 b_s=\frac{cw(qv-sdk)}{D},
 \tag{3.6}
```
and minimum
```math
 F_s(z)=\{pw+qv-s\,2dk\}K(z).
 \tag{3.7}
```
For $\beta=(a,b)^{\mathsf T}$,
```math
 Q_s(\beta;z)=F_s(z)+
   (\beta-\beta_s(z))^{\mathsf T}M_s(z)(\beta-\beta_s(z)).
 \tag{3.8}
```

**Proof.** For $u>0$, the convex homogeneous function
$f(t,u)=u+t\arctan(t/u)$ has support representation
```math
 f(t,u)=\sup_{z\in\mathbb R}
 \left\{\left(\arctan z+\frac{z}{1+z^2}\right)t+
                \frac{u}{1+z^2}\right\}.
 \tag{3.9}
```
Indeed, $f_{tt}=2u^3/(u^2+t^2)^2$,
$f_{tu}=-2tu^2/(u^2+t^2)^2$, and
$f_{uu}=2t^2u/(u^2+t^2)^2$, so its Hessian is positive semidefinite; the displayed linear form is its tangent at $(z,1)$, with equality at $z=t/u$. Endpoint limits extend (3.9) to $u=0$. Substitution in (2.2), and minimizing the sign of $1-ab$, proves (3.5).

Lemma 3.1 makes $M_s$ positive definite. Solving its two linear normal equations gives (3.6). Completing the square gives (3.8). For (3.7), write $m=pw+qv$. The quadratic reduction subtracts
$c^2P(m-s\,2dk)/D$ from its constant term $m-s\,2dk$; using $pq-c^2=d^2$ yields exactly (3.7). $\square$

**Theorem 3.3 (quantitative branch correction).** For any $\beta=(a,b)$ with $ab>1$, set $z=(A-B)/(2d(ab-1))$. Then
```math
 \begin{split}
 J(\beta)-J(\beta_+(z))
 \ \ge\ &4dkK\\
 &+(\beta-\beta_-(z))^{\mathsf T}
       M_-(z)(\beta-\beta_-(z))>0,
 \end{split}
 \tag{3.10}
```
and $a_+(z)b_+(z)<1$.

**Proof.** At the input point, $J=Q_-(\beta;z)$. At the output point,
$J(\beta_+(z))\le Q_+(\beta_+(z);z)=F_+(z)$.
Combine (3.8) with $F_--F_+=4dkK>0$.

To verify the output branch, put $U=pw$, $V=qv$, $h=dk$, $S=UV$. Then $D=S-h^2>0$ and
```math
 a_+b_+=\frac{\rho^2S(U-h)(V-h)}{(S-h^2)^2}.
```
If one factor in the numerator is nonpositive and the other nonnegative, the product is at most zero. Both cannot be negative because $UV>h^2$. If both are positive, $U+V\ge2\sqrt S$ gives
```math
 (U-h)(V-h)\le(\sqrt S-h)^2,\qquad
 a_+b_+\le\frac{\rho^2S}{(\sqrt S+h)^2}<1.
```
This also proves $a_+(z)b_+(z)<1$ for every finite $z$, independently of its origin. $\square$

The improvement certificate is pointwise and quantitative. Its positive lower bound need not be uniform over unbounded input coefficients.

## 4. Global optimization on an explicit compact interval

### 4.1 Monotonicity needed for truncation

**Lemma 4.1 (ratio monotonicity).** The even function
```math
 H(z)=\frac{k(z)^2}{P(z)}
 \tag{4.1}
```
is strictly decreasing for $z>0$, with $0 \lt H(z)<1$.
Consequently
```math
 K(z)=(1-\rho^2)\frac{1-H(z)}{1-(1-\rho^2)H(z)}
 \tag{4.2}
```
is even, is nondecreasing for $z\ge0$, and is strictly increasing for $z>0$ when $c\ne0$. If $c=0$, $K\equiv1$.

**Proof.** Positivity follows from Lemma 3.1. Let
$\theta=\arctan z\in(0,\pi/2)$,
$h=\theta+\sin\theta\cos\theta$, and $C=\cos^2\theta$.
Then
```math
 H=\frac{C^2}{\pi^2/4-h^2}.
```
Differentiation shows that $H'<0$ is equivalent to
```math
 R(\theta)=\pi^2/4-h^2-\frac{h\cos^3\theta}{\sin\theta}>0.
```
Its derivative and terminal limit are
```math
 R'(\theta)=\frac{\cos^2\theta}{\sin^2\theta}
       \{\theta\cos(2\theta)-\sin\theta\cos\theta\}<0,
 \qquad \lim_{\theta\uparrow\pi/2}R(\theta)=0.
```
The expression in braces starts at zero and has derivative
$-2\theta\sin(2\theta)<0$. Thus $R>0$, proving the first assertion. Finally, differentiating the right side of (4.2) with respect to $H$ gives
```math
 -\frac{\rho^2(1-\rho^2)}
          {\{1-(1-\rho^2)H\}^2},
```
which proves the assertions about $K$. $\square$

**Theorem 4.2 (all-covariance global characterization).** Assume $p\ge q$, and put
```math
 Z=\frac{p-q}{2d},\qquad B_0(z)=pw(z)+qv(z)-2dk(z).
 \tag{4.3}
```
Then (1.5) holds. The set of all global minimizers is exactly
```math
 \{\beta_+(z):z\in\operatorname*{argmin}_{[0,Z]}F_+(z)\}.
 \tag{4.4}
```
Every such coefficient pair has product less than one. If $p>q$ and $c\ne0$, every scalar minimizing point lies in $(0,Z)$.

**Proof.** Infima over a product set may be taken in either order. By (3.5)–(3.8),
```math
 \inf_\beta J(\beta)=\inf_{s,z}F_s(z)=\inf_zF_+(z),
 \tag{4.5}
```
where the last equality uses the strict pointwise inequality $F_+ \lt F_-$.

We have $w(-z)=v(z)$, while $k,K$ are even. Hence, for $z\ge0$,
```math
 F_+(-z)-F_+(z)=K(z)(p-q)(1-2w(z))\ge0.
 \tag{4.6}
```
It is therefore sufficient to consider $z\ge0$. The factor $B_0$ is strictly positive because
```math
 pw+qv\ge2\sqrt{pqP}>2dk.
```
Moreover,
```math
 w'=-\frac2{\pi(1+z^2)^2},\qquad k'=zw',\qquad
 B_0'=w'\{p-q-2dz\}.
 \tag{4.7}
```
Thus $B_0$ is nonincreasing on $[0,Z]$ and strictly increasing on $(Z,\infty)$. Lemma 4.1 makes $K$ positive and nondecreasing. Their product $F_+=KB_0$ is strictly increasing on $(Z,\infty)$. This proves compact truncation and attainment of its minimum.

For a scalar minimizer $z_*$, (3.5) gives
$J(\beta_+(z_*))\le F_+(z_*)=\inf_\beta J$, so equality holds. Conversely, a global minimizer cannot have $ab>1$ by Theorem 3.3, or $ab=1$ by Lemma 5.1 below. At a global minimizer with $ab<1$, use its active $z=t/u$ in (3.8). Since $F_+(z)$ cannot be below the global value, the quadratic remainder must vanish and $z$ must be a scalar minimizer. Equation (4.6) excludes negative minimizing $z$ if $p>q$; if $p=q$, strict increase with $|z|$ excludes all nonzero minimizing $z$. This proves (4.4).

When $p>q,c\ne0$, $K'(0)=0$ and $B_0'(0)<0$, so zero is not a minimizer. At $Z>0$, $B_0'(Z)=0$ and $K'(Z)>0$, so $Z$ is not a minimizer. $\square$

If $p \lt q$, interchange the two sources, solve the displayed problem, and interchange the resulting $a,b$ back. This is a relabeling, not rescaling of the loss.

**Corollary 4.3 (known symmetric solution and zero correlation).** If $p=q=\sigma^2$, the unique global pair is
```math
 a=b=\frac{\rho}{1+(2/\pi)\sqrt{1-\rho^2}}.
 \tag{4.8}
```
This recovers the Gaussian equal-variance result of [1, Theorem 5], with an independent justification of globality. If $c=0$, then $\beta_+(z)=0$ for every $z$, and the scalar minimizer is $Z$.

**Proof.** For $p=q$, the compact interval reduces to $z=0$, and (3.6) gives (4.8). For $c=0$, (3.6) vanishes and $K=1$; (4.7) makes $Z$ the unique scalar minimizer. $\square$

### 4.2 A convergent certificate, not an assumption of unimodality

**Proposition 4.4 (endpoint certificate).** For every $0\le l\le z\le r\le Z$,
```math
 K(l)B_0(r)\le F_+(z)\le K(r)B_0(l).
 \tag{4.9}
```
For a finite partition of $[0,Z]$, let $L_{\cal P}$ be the minimum of the left bounds in (4.9), and let $U_{\cal P}$ be the smallest value of $F_+$ over a collection containing at least one chosen sample point in every partition cell. Then
```math
 L_{\cal P}\le\min J\le U_{\cal P}.
 \tag{4.10}
```
The policy reconstructed from the sample attaining $U_{\cal P}$ has risk at most $U_{\cal P}$. If the partition mesh tends to zero, $U_{\cal P}-L_{\cal P}\to0$.

**Proof.** On the compact interval, $K$ is positive nondecreasing and $B_0$ is positive nonincreasing. This proves (4.9). Apply it on every cell and use $J(\beta_+(z))\le F_+(z)$ for the policy assertion. Uniform continuity of both factors on the compact interval shows that the gap between their cross-endpoint products tends uniformly to zero with the mesh. Every cell has a sample, so (4.10) converges. $\square$

For computable covariance inputs with a certified positive determinant, square roots and arctangents admit arbitrarily precise enclosures. Evaluate (4.9) with outward rounding and refine both the partition and arithmetic precision until the certified upper and lower values differ by the requested tolerance. This procedure terminates by Proposition 4.4. It does not require uniqueness, convexity, or unimodality of $F_+$. A best-first subdivision can accelerate it; periodic uniform refinement or a deterministic mesh cap retains the termination argument. No polynomial bit-complexity bound uniform in nearly singular covariances is asserted.

The accompanying program uses directed decimal interval arithmetic, exact rational input checks, a Machin formula for $\pi$, and alternating arctangent bounds on four explicitly listed rational-covariance instances. Its implemented input scope and numerical output are documented separately in REPRODUCTION.md. The general theorem does not depend on those finite computations.

## 5. A complete criterion for strict spurious minima

**Lemma 5.1 (the boundary has descent).** No coefficient pair on $ab=1$ is a local minimum.

**Proof.** The two residuals are proportional there:
$X_2-bX_1=-b(X_1-aX_2)$.
Keep the coefficient of a pointwise smaller squared residual fixed, and change the coefficient of the other by an arbitrarily small nonzero amount. The two residual linear forms then become linearly independent. Under a nonsingular Gaussian, there is an open cone of positive probability on which the changed squared residual is smaller than the fixed one. The new pointwise minimum is never larger than the fixed residual square, and its expectation is strictly smaller. This works also at $a=b=\pm1$, where the original squares coincide. Lemma 2.1 transfers the strict inequality to every source in Definition 1.1. $\square$

**Lemma 5.2 (escape to infinity).** Put $L_0=d^2/\max(p,q)$. For any coefficient sequence whose Euclidean norm tends to infinity,
```math
 \liminf_n J(a_n,b_n)\ge L_0.
 \tag{5.1}
```
On the finite boundary $ab=1$, $J\ge L_0$.

**Proof.** By radial invariance use a nonsingular Gaussian. To evaluate a finite liminf, take a subsequence on which the risk approaches it and then further subsequences of the coefficients. If both coefficient magnitudes diverge, both squared residuals tend to infinity almost surely; Fatou's lemma gives divergent risk. If only $|a_n|$ diverges, extract a further subsequence with $b_n\to b_0$. The squared minimum tends almost surely to $(X_2-b_0X_1)^2$, and is bounded above by a constant times $\|X\|^2$, using the bounded $b_n$. Dominated convergence gives
```math
 J(a_n,b_n)\longrightarrow q+pb_0^2-2cb_0
       \ge d^2/p\ge L_0.
```
The case of divergent $b_n$ is symmetric. These alternatives cover a suitable subsequence of any coefficient sequence escaping to infinity. On $ab=1$, complete the two squares to obtain $A\ge d^2/q$, $B\ge d^2/p$, and use $J=\min(A,B)$. $\square$

**Proof of Theorem 1.2.** Suppose $c\ne0$, and first let $p\ge q$. Fix $b=c/p$, and choose $a$ with the same sign as $c$ and sufficiently large magnitude that $ab>1$. The residual forms are linearly independent. There is positive Gaussian probability on which the first squared residual is smaller than the second, so
```math
 J(a,b)<\mathbb E(X_2-(c/p)X_1)^2=d^2/p=L_0.
 \tag{5.2}
```
For $q>p$, swap labels. Select such a point with risk $r \lt L_0$. The set
```math
 \{\beta\in\overline{\Omega_c}:J(\beta)\le r\}
```
is nonempty, closed, bounded by Lemma 5.2, and disjoint from the finite boundary. It attains a minimum at an interior point $\beta_*\in\Omega_c$. This is a local minimum in the full parameter plane. Theorem 3.3 proves it is nonglobal.

We next prove strictness; compactness alone does not imply it. Let
$z_*=(A_*-B_*)/[2d(a_*b_*-1)]$.
On $\Omega_c$, the active envelope is smooth, and its derivative in $z$ vanishes. Consequently stationarity of $J$ implies
$\beta_*=\beta_-(z_*)$ and $J(\beta_*)=F_-(z_*)$.
The function $F_-$ is real analytic. Its endpoint limits are
```math
 \lim_{z\to+\infty}F_-(z)=d^2/p,\qquad
 \lim_{z\to-\infty}F_-(z)=d^2/q.
 \tag{5.3}
```
For completeness, $w(z)=2/(3\pi z^3)+O(z^{-5})$ and
$k(z)=1/(\pi z^2)+O(z^{-4})$ as $z\to+\infty$; hence
$k^2/P\to0$, $K\to d^2/(pq)$, which proves the first limit. Symmetry proves the second. Since $F_-(z_*) \lt L_0$, $F_-$ is not constant.

For $z$ close to $z_*$, continuity keeps $\beta_-(z)$ close to the local minimizer, and (3.5) gives
```math
 F_-(z)\ge J(\beta_-(z))\ge J(\beta_*)=F_-(z_*).
```
A nonconstant real-analytic function has isolated zeros after its value at a local minimum is subtracted. Therefore $F_-$ is strictly larger than $F_-(z_*)$ at every sufficiently close $z\ne z_*$.
For a nearby $\beta\in\Omega_c$, insert its continuous active $z(\beta)$ into (3.8):
```math
 J(\beta)=F_-(z(\beta))
 +(\beta-\beta_-(z(\beta)))^{\mathsf T}
       M_-(z(\beta))(\beta-\beta_-(z(\beta))).
```
If $z(\beta)\ne z_*$, the first term is strictly larger. If $z(\beta)=z_*$ and $\beta\ne\beta_*$, the positive-definite remainder is strictly positive. This proves a strict spurious local minimum.

Now suppose $c=0$. Away from $ab=1$, a stationary point of $J$ must be stationary for its active quadratic $Q_s$. By (3.6), its only possibility is $\beta=0$. Boundary local minima are excluded by Lemma 5.1. The global characterization in Section 4 supplies the attained global minimum at zero. Thus it is the only local and global minimum. The remaining statements of Theorem 1.2 are Lemma 5.1 and Theorem 3.3. $\square$

In particular, nonzero Gaussian correlation suffices even when the variances are equal. Additional bad minima do not contradict the already known equal-variance global optimum. The no-spurious-minimum assertion made from the illustrative landscape in [2, §2.1.3] cannot hold over the whole coefficient plane at its nonzero correlation. A bounded plot and a successful trajectory do not establish absence of other local minima.

## 6. An exact attracting trap for population CCP

### 6.1 A rational-covariance strict minimum

Take
```math
 p=q=1,\quad c=\rho=\frac{24}{25},\quad d=\frac7{25},\quad
 \eta=\frac{14}{25\pi},\quad
 h_+=\frac{24\pi}{25\pi-14}>1,\quad
 h_-=\frac{24\pi}{25\pi+14}<1.
 \tag{6.1}
```
The inequalities follow from $3<\pi<4$. In the region $h>1$,
```math
 J(h,h)=1+\eta+(1-\eta)h^2-2\rho h.
 \tag{6.2}
```
Exchange symmetry and differentiation along the diagonal make $(h_+,h_+)$ stationary. Along the orthonormal symmetric and antisymmetric directions, its Hessian eigenvalues are
```math
 \lambda_{\rm sym}=1-\eta,
 \tag{6.3}
```
```math
 \begin{split}
 \lambda_{\rm anti}
 &=1+\eta-\frac{16\eta}{\pi^2}
             \frac{h_+^2}{h_+^2-1}\\
 &=\frac{175\pi^3-2402\pi^2-700\pi+18824}
         {25\pi(\pi-14)(7\pi-2)}>0.
 \end{split}
 \tag{6.4}
```
One way to check the transverse derivative is to put
$a=h_++x,b=h_+-x$ in (2.2), use
$A-B=4(h_+-\rho)x$ and
$u=2d(h_+^2-1-x^2)$, and expand to second order.

The positivity in (6.4) has a short exact certificate. Its denominator is negative for $3<\pi<4$. For
$N(s)=175s^3-2402s^2-700s+18824$,
```math
 N(3)=-169,\qquad N'(s)=525s^2-4804s-700<0
       \quad(3\le s\le4),
```
because $525s^2\le8400<14412+700\le4804s+700$.
Thus the numerator is negative as well. This proves positive definiteness without a floating-point Hessian test.

The two risks are
```math
 J(h_+,h_+)=\frac{49(\pi^2-4)}{25\pi(25\pi-14)},\qquad
 J(h_-,h_-)=\frac{49(\pi^2-4)}{25\pi(25\pi+14)},
 \tag{6.5}
```
and their positive difference is
```math
 \Delta=\frac{1372(\pi^2-4)}
 {25\pi(25\pi-14)(25\pi+14)}.
 \tag{6.6}
```
The latter pair is the known symmetric optimum (4.8). For orientation, the bad and good risks are about $0.0567397353$ and $0.0395718539$, respectively; the gap is about $0.0171678814$. These decimals illustrate exact formulas, not their proof.

### 6.2 The actual CCP map

The decomposition used in [1] is
```math
 J=F-G,\qquad F=A+B,\qquad
 G=\mathbb E\max\{(X_1-aX_2)^2,(X_2-bX_1)^2\}.
 \tag{6.7}
```
Writing $D_0=\operatorname{diag}(q,p)$, its smooth population update is
```math
 T(\beta)=\beta-\frac12D_0^{-1}\nabla J(\beta).
 \tag{6.8}
```
This follows by minimizing the quadratic $F$ minus the affine expansion of $G$; it is not a newly substituted optimization rule.

**Proposition 6.1 (open bad basin).** At the point (6.1), an open nonempty set of initial coefficient pairs converges under (6.8) to the strict spurious minimum.

**Proof.** At any smooth fixed point with positive-definite Hessian $H_J$,
```math
 DT=I-\tfrac12D_0^{-1}H_J.
```
The function $G$ is convex, being the expectation of a maximum of convex quadratics. In a smooth neighborhood this gives $H_J\preceq2D_0$. Therefore $DT$ is similar to the symmetric matrix
```math
 I-\tfrac12D_0^{-1/2}H_JD_0^{-1/2},
```
whose eigenvalues lie in $[0,1)$. In the corresponding weighted norm, continuity gives a contraction on a sufficiently small closed ball centered at the fixed point; the ball is invariant because its center is fixed. Every initial point in its interior converges to that center. Equations (6.3)–(6.4) supply the required positive Hessian. $\square$

For (6.1), the update eigenvalues are approximately $0.58913$ and $0.95144$. The theorem asserts existence of an open basin, not its size or the probability of entering it under any chosen initialization scheme. Nor does it assert a finite-sample empirical-CCP guarantee.

## 7. Verification, interpretation, and limitations

The analytic arguments establish the entire stated parameter range. Reproducible calculations serve three narrower purposes: checking the displayed algebra and explicit trap, independently comparing the angular objective with its closed expression, and enclosing selected unequal-variance global values by Proposition 4.4. These finite checks do not replace the proofs.

The central design lesson is operational. A local solver can be attracted to a genuinely worse estimator even in the original two-Gaussian model. The explicit map (3.10) certifies improvement from the whole region $ab>1$, and compact scalar minimization supplies a global alternative for every admitted covariance. Neither statement requires assuming that a finite landscape plot shows all stationary points.

The positive-definiteness and elliptical-source assumptions are material. We have excluded singular covariance and infinite second moments rather than silently extrapolating formulas into those cases. Near-singular inputs may be numerically ill-conditioned, and the compact interval may be large. The certificate's termination is an accuracy statement for each fixed admissible input, not a uniform efficiency theorem. The scope remains a static centralized scheduler and switched-linear reconstruction.

Novelty statements are confined to the primary works cited here as of 25 November 2026. No external peer review, journal acceptance, or exhaustive priority certification is claimed. The manuscript supplies written proofs.

## References

[1] M. M. Vasconcelos and U. Mitra. Observation-Driven Scheduling for Remote Estimation of Two Gaussian Random Variables. IEEE Transactions on Control of Network Systems 7(1), 232–244, 2020. [DOI: 10.1109/TCNS.2019.2900864](https://doi.org/10.1109/TCNS.2019.2900864). Author-hosted [published full text](https://mullervasconcelos.github.io/Resources/ODSS.pdf).

[2] M. M. Vasconcelos and U. Mitra. Extremum information transfer over networks for remote estimation and distributed learning. Frontiers in Complex Systems 2, 1322785, 2024. [DOI: 10.3389/fcpxs.2024.1322785](https://doi.org/10.3389/fcpxs.2024.1322785).

[3] M. M. Vasconcelos and U. Mitra. Data-Driven Sensor Scheduling for Remote Estimation in Wireless Networks. IEEE Transactions on Control of Network Systems 8(2), 725–737, 2021. [DOI: 10.1109/TCNS.2021.3050136](https://doi.org/10.1109/TCNS.2021.3050136). Author-hosted [published full text](https://mullervasconcelos.github.io/Resources/Data-Driven_Sensor_Scheduling_for_Remote_Estimation_in_Wireless_Networks.pdf).

[4] M. M. Vasconcelos and N. C. Martins. Optimal Estimation Over the Collision Channel. IEEE Transactions on Automatic Control 62(1), 321–336, 2017. [DOI: 10.1109/TAC.2016.2558644](https://doi.org/10.1109/TAC.2016.2558644). Author-hosted [published full text](https://mullervasconcelos.github.io/Resources/Collision_Channel_MMSE.pdf).


[5] M. M. Vasconcelos and Y. Zhang. Neuroscheduling for Remote Estimation. arXiv:2405.10892v1, 17 May 2024. [Original manuscript](https://arxiv.org/html/2405.10892v1). This citation identifies the inspected preprint version.
