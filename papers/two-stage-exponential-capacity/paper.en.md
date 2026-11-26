# Exact capacity of additive two-stage exponential noise

## Optimal support, quantitative certificates, and singular low-cost limits

Research manuscript — 26 November 2026

### Abstract

We determine the mutual-information capacity of the memoryless additive channel $Y=X+Z$, with arbitrary nonnegative Borel input, a mean-input constraint, and noise equal to the sum of two independent exponential stages. The rates may differ or coincide. At every positive budget the unique optimizer consists of an atom at zero, an atom at a positive threshold, and an exponential density above that threshold, with no input mass in the intervening interval. A monotone scalar equation determines the threshold, and a monotone budget map covers every positive budget. The proof combines positive second-order deconvolution with a strict log-concavity certificate valid for all input values. An exact deficit identity quantifies the penalty for unused budget, output mismatch, and input mass in the forbidden gap. At small normalized budgets the capacity deficit from the linear unit-cost bound has order $p/\log(1/p)$ for distinct stages and $p\log\log(1/p)/\log(1/p)$ for equal stages. At large budgets we identify the leading gap to the maximum-entropy output bound. Finally, for any cascade of three or more exponential stages, we show that this one-gap support geometry cannot be optimal. The model is memoryless and capacity is measured per use; no queue-capacity or elapsed-time capacity formula is asserted.

## 1. Model and relation to existing methods

Let $E_\alpha,E_\beta$ be independent exponentials of rates $0<\alpha\leq\beta<\infty$. Write
```math
 Z=E_\alpha+E_\beta,\qquad m=\mathbb EZ=\alpha^{-1}+\beta^{-1}.
 \tag{1.1}
```
All logarithms are natural. The density, extended by zero to the negative half-line, is
```math
 n(t)=
 \begin{cases}
 \dfrac{\alpha\beta}{\beta-\alpha}(e^{-\alpha t}-e^{-\beta t}),
       &t>0,\ \alpha<\beta,\\
 \alpha^2t e^{-\alpha t},&t>0,\ \alpha=\beta.
 \end{cases}
 \tag{1.2}
```
For any Borel probability law $\mu$ on $[0,\infty)$, independent of $Z$, let $q_\mu=\mu*n$. We determine
```math
 C_{\alpha,\beta}(P)=\sup_{\mu:\int x\,d\mu(x)\leq P}
     I_\mu(X;X+Z),\qquad P\geq0.
 \tag{1.3}
```
This includes discrete, continuous, singular and mixed inputs. There is no peak constraint. Across uses the noise is independent with the fixed law (1.2).

The additive exponential channel is a classical exactly solvable model [1]. Information-radius and KKT methods, including finite-constellation optimization, are established [2]. General support theorems compare cost growth to the negative logarithm of the noise tail [3]. Our linear cost is at the exponential-tail boundary; moreover, the half-line noise fails the everywhere-positive noise assumption C5 in [3], so that theorem cannot simply be applied.

Recent work on uniform additive noise with peak and cost constraints constructs optimal support and proves discrete-to-nondiscrete transitions [5]. Its discussion motivates broader nonanalytic noise and soft-constraint questions; it does not specifically pose the two-stage exponential problem considered here. We study a narrower cost family but give the complete solution for all positive rate pairs and budgets, without a peak constraint, together with a stage-count obstruction and distinct small-budget laws under rate coalescence.

We do not claim novelty for KKT conditions, maximum entropy, or inversion of an exponential convolution. In particular, the related Laplace-noise analysis [6] already combines second-order deconvolution, a free-boundary contact equation, a strict gap certificate, KL optimality, convolution injectivity, and budget duality. The present work uses that architecture. Its candidate contribution is the joint content of the all-rate, all-budget causal two-stage solution, the singular low-cost distinction between fixed unequal and equal rates, and the arbitrary-rate obstruction for every cascade of at least three stages. The quantitative deficit identity is a useful consequence of the certificate, not an independently invented optimization principle.

A Gamma-noise model also appears in neuronal temporal communication [4]. Its full text was unavailable in the present comparison, so its exact input constraint and theorem statements have not been checked. The precise problem in (1.3) is our formulation within the broader support-structure research direction, not a named conjecture attributed to those authors. No global priority or external peer-review assertion is made.

## 2. Scalar construction

For $a>0$, set
```math
 F(a)=\int_0^a n(t)\,dt,\quad
 B(a)=\int_0^a n(t)(a-t)\,dt,\quad
 A(a)=\int_0^a n(t)\log\frac{n(t)}{n(a)}\,dt,\quad
 \lambda(a)=A(a)/B(a).
 \tag{2.1}
```
Write $\ell=\log n$ on $(0,\infty)$.

### Lemma 2.1 (threshold parameter)

The function $\lambda$ is continuously differentiable and strictly increasing from $-\infty$ to $\alpha$, and
```math
 \lambda'(a)=\frac{F(a)}{B(a)}[-\ell'(a)-\lambda(a)]>0,\qquad
 \lambda(a)<-\ell'(a)<\alpha.
 \tag{2.2}
```
There is a unique $a_0>0$ with $\lambda(a_0)=0$; $\lambda$ maps $(a_0,\infty)$ bijectively onto $(0,\alpha)$.

**Proof.** If $\delta=\beta-\alpha>0$, then
```math
 \ell'(t)=-\alpha+\frac{\delta}{e^{\delta t}-1},\quad
 \ell''(t)=-\frac{\delta^2e^{\delta t}}{(e^{\delta t}-1)^2}<0.
```
For equal rates, these are $1/t-\alpha$ and $-1/t^2$. Strict concavity implies
```math
 \frac{\ell(t)-\ell(a)}{a-t}<-\ell'(a)\quad(0 \lt t \lt a).
```
Taking the weighted average with positive weights $n(t)(a-t)$ gives the first strict inequality in (2.2); the explicit derivative gives the second. Differentiation yields $A'=-\ell'(a)F$, $B'=F$, proving (2.2).

At zero, $n(t)=\alpha\beta t(1+O(t))$, so $A(a)=-\alpha\beta a^2/4+O(a^3)$, $B(a)=\alpha\beta a^3/6+O(a^4)$, and $\lambda(a)=-3/(2a)+O(1)$. At infinity, $B(a)=a-m+o(1)$, $\int_0^a n\log n\to-h(n)$, and $-\log n(a)=\alpha a+O(\log a)$. Consequently $\lambda(a)\to\alpha$. Local linear behavior at zero and exponential tails justify these operations. ∎

Fix $a>a_0$, abbreviate $\lambda=\lambda(a)$, and put
```math
 p_0=\left(F(a)+\frac{n(a)}{\lambda}\right)^{-1},\qquad
 d_a=\frac{-\lambda-\ell'(a)}{\alpha\beta},\qquad
 k_\lambda=\frac{(\alpha-\lambda)(\beta-\lambda)}{\alpha\beta}.
 \tag{2.3}
```
Both $d_a,k_\lambda$ are positive. Define the output candidate
```math
 f_a(y)=
 \begin{cases}
 p_0n(y),&0 \lt y\leq a,\\
 p_0n(a)e^{-\lambda(y-a)},&y>a,\\
 0,&y\leq0,
 \end{cases}
 \tag{2.4}
```
and the input candidate
```math
 \mu_a=p_0\delta_0+p_0n(a)d_a\delta_a+
       k_\lambda p_0n(a)e^{-\lambda(x-a)}
                   {\bf1}_{(a,\infty)}(x)\,dx.
 \tag{2.5}
```

### Lemma 2.2 (positive deconvolution)

The measure $\mu_a$ is a probability law and $\mu_a*n=f_a$. Its mean is positive and equals
```math
 P(a)=p_0n(a)\left[
     a d_a+k_\lambda\left(\frac a\lambda+\frac1{\lambda^2}\right)\right].
 \tag{2.6}
```
Equivalently,
```math
 P(a)=p_0\left[\int_0^a y n(y)\,dy+
       n(a)\left(\frac a\lambda+\frac1{\lambda^2}\right)\right]-m.
 \tag{2.7}
```

**Proof.** With distributional differentiation $D$ on $\mathbb R$, let
```math
 {\cal L}=\frac{(D+\alpha)(D+\beta)}{\alpha\beta}.
```
The noise is its causal fundamental solution, because
```math
 \widehat n(s)=\frac{\alpha\beta}{(s+\alpha)(s+\beta)},\quad s\geq0.
 \tag{2.8}
```
The candidate $f_a$ is continuous at $a$, vanishes at zero, and has $f'_a(0+)=p_0\alpha\beta$. The derivative jump at $a$ is $p_0n(a)[-\lambda-\ell'(a)]$. Below $a$, ${\cal L}f_a=0$; above $a$, ${\cal L}f_a=k_\lambda f_a$. Therefore distributional differentiation gives ${\cal L}f_a=\mu_a$. Continuity of $f_a$ precludes derivatives of Dirac masses, and every displayed measure coefficient is positive.

The output integrates to one by (2.3). Laplace transformation proves $\widehat\mu_a=\widehat f_a/\widehat n$, hence $\mu_a*n=f_a$. At $s=0$ it also gives total input mass one. Direct integration gives (2.6); addition of means gives (2.7). ∎

## 3. A strict certificate for every input value

Set
```math
 \nu_a=-\log[p_0n(a)]-\lambda a+\lambda m,\qquad
 G_a(x)=\int_0^\infty n(z)[-\log f_a(x+z)]\,dz,\qquad
 H_a(x)=G_a(x)-\nu_a-\lambda x.
 \tag{3.1}
```

### Lemma 3.1 (single-crossing certificate)

One has
```math
 H_a(0)=0,\quad H_a(x)<0\ (0 \lt x \lt a),\quad H_a(x)=0\ (x\geq a).
 \tag{3.2}
```

**Proof.** Compare $-\log f_a$ to the affine continuation of its tail. Their difference below $a$ is
```math
 r_a(t)=\log\frac{n(a)}{n(t)}+\lambda(a-t),\quad0 \lt t \lt a.
 \tag{3.3}
```
Thus
```math
 H_a(x)=\int_x^a n(t-x)r_a(t)\,dt\quad(0\leq x \lt a),
 \tag{3.4}
```
and it is zero above $a$. Equation (2.1) states precisely
```math
 \int_0^a n(t)r_a(t)\,dt=0. \tag{3.5}
```
The strictly convex function $r_a$ tends to infinity at zero, vanishes at $a$, and has derivative $r'_a(a)=-\ell'(a)-\lambda>0$. Hence it has exactly one further zero $b\in(0,a)$, is positive before $b$, and negative after $b$.

For fixed $x\in(0,a)$, extend $w_x(t)=n(t-x)/n(t)$ by zero for $t\leq x$. On $t>x$ it is strictly increasing, because
```math
 \frac d{dt}\log w_x(t)=\ell'(t-x)-\ell'(t)>0.
```
If $x\geq b$, the integral (3.4) is strictly negative. If $x \lt b$, subtract $w_x(b)$ times (3.5) from (3.4). The resulting integrand
$n(t)r_a(t)[w_x(t)-w_x(b)]$ is nonpositive everywhere and strictly negative on a set of positive measure. ∎

### Lemma 3.2 (finite-mean Borel inputs)

For every nonnegative Borel input of finite mean, $h(q_\mu)$, $h(n)$, the cross entropy $\int q_\mu(-\log f_a)$, and $D(q_\mu\Vert f_a)$ are finite, and
```math
 I_\mu(X;X+Z)=h(q_\mu)-h(n).
 \tag{3.6}
```

**Proof.** The density $n$ is bounded and $n(t)\leq Kt$ near zero. Consequently $q_\mu\leq\sup n$ globally and $q_\mu(y)\leq Ky$ near zero. Bounded density gives a finite lower entropy bound; an exponential reference density and the finite output mean give a finite upper entropy bound. This also verifies absolute integrability of $q_\mu\log q_\mu$: its positive part is bounded by the density bound, and its negative part is controlled by the exponential comparison and the first moment.

The function $-\log f_a$ is $O(1+|\log y|)$ near zero and affine at infinity. The preceding bounds imply absolute integrability of its cross entropy. Subtracting the finite entropy gives finite relative entropy. The noise satisfies the same bounds. Since each conditional density is a translate of $n$, the density identity for mutual information gives (3.6). ∎

### Theorem 3.3 (capacity and unique optimizer)

At the budget $P(a)$, the unique optimizer over all feasible Borel inputs is (2.5), and
```math
 C_{\alpha,\beta}(P(a))=\nu_a+\lambda(a)P(a)-h(n).
 \tag{3.7}
```
The same law uniquely maximizes $h(q_\mu)-\lambda(a)\mathbb E_\mu X$ over all finite-mean nonnegative inputs.

**Proof.** Fubini, Lemmas 3.1–3.2, and the cross-entropy identity give
```math
 \begin{aligned}
 h(q_\mu)
 &=\int q_\mu(-\log f_a)-D(q_\mu\Vert f_a)\\
 &=\nu_a+\lambda\mathbb E_\mu X+
     \int H_a(x)\,d\mu(x)-D(q_\mu\Vert f_a)\\
 &\leq\nu_a+\lambda\mathbb E_\mu X.
 \end{aligned}
 \tag{3.8}
```
Equality holds for $\mu_a$: its output is $f_a$, and its support lies in the zero set of $H_a$. Since $\lambda>0$, this proves the two optimality statements. Equality for any other law forces $q_\mu=f_a$ almost everywhere. Divide their Laplace transforms by the nonzero function (2.8); uniqueness of Laplace transforms of finite measures on $[0,\infty)$ gives $\mu=\mu_a$. ∎

### Theorem 3.4 (exact deficit and stability)

For $P=P(a)$ and any feasible $\mu$,
```math
 C_{\alpha,\beta}(P)-I_\mu(X;X+Z)
 =\lambda(P-\mathbb E_\mu X)+D(q_\mu\Vert f_a)
     +\int[-H_a(x)]\,d\mu(x).
 \tag{3.9}
```
All three terms are nonnegative. If the deficit is at most $\varepsilon$, then
```math
 P-\mathbb E_\mu X\leq\varepsilon/\lambda,\qquad
 \|q_\mu-f_a\|_{\rm TV}\leq\sqrt{\varepsilon/2}.
 \tag{3.10}
```
Here total variation is one half of the $L^1$ distance. For every nonempty compact $K\subset(0,a)$,
```math
 \mu(K)\leq\frac{\varepsilon}
                 {\min_{x\in K}[-H_a(x)]}. \tag{3.11}
```

**Proof.** Subtract the equality in (3.8) from (3.7). Pinsker's inequality gives (3.10), and continuity and strict negativity of $H_a$ on the gap give (3.11). ∎

## 4. All budgets and the zero-cost endpoint

### Theorem 4.1 (global parameterization)

The map $P:(a_0,\infty)\to(0,\infty)$ is continuous and strictly decreasing, with limits infinity at $a_0$ and zero at infinity. Thus every $P>0$ determines exactly one threshold $a(P)$, and (2.5) is the unique optimizer. The capacity is continuously differentiable, strictly increasing, and strictly concave on $(0,\infty)$, with
```math
 C'_{\alpha,\beta}(P)=\lambda(a(P)).
 \tag{4.1}
```
At zero, the sole feasible input is $\delta_0$, and $C_{\alpha,\beta}(0)=0$.

**Proof.** Continuity follows from the formulas. For $a_1 \lt a_2$, penalized optimality at the two distinct multipliers gives, on addition,
```math
 (\lambda_2-\lambda_1)(P(a_1)-P(a_2))\geq0.
```
If the means were equal, both inputs would maximize either penalized objective, contradicting uniqueness and their distinct gap endpoints. Hence the means strictly decrease.

As $a\downarrow a_0$, $\lambda\downarrow0$, $p_0n(a)\sim\lambda$, and $k_\lambda\to1$. Equation (2.6) gives $P(a)\sim1/\lambda$. As $a\to\infty$, $p_0\to1$, $\lambda\to\alpha$, and the exponentially decreasing $n(a)$ dominates every factor of $a$ in (2.6); the mean tends to zero. The intermediate value theorem proves the bijection.

Equation (3.8) supplies a supporting line to capacity at every positive budget. Its slope $\lambda(a(P))$ is continuous. Trapping a difference quotient between its endpoint supporting slopes gives (4.1). The slope is positive and strictly decreasing, proving the remaining assertions. ∎

### Lemma 4.2 (linear upper bound and scaling)

For all $P\geq0$,
```math
 0\leq C_{\alpha,\beta}(P)\leq\alpha P,\qquad
 C_{\alpha,\beta}(P)=C_{1,\beta/\alpha}(\alpha P).
 \tag{4.2}
```
The upper bound is strict for $P>0$.

**Proof.** Equation (1.2) gives $n(t+x)\geq e^{-\alpha x}n(t)$ for $t>0,x\geq0$, strictly for $x>0$. Thus $D(n(\cdot-x)\Vert n)\leq\alpha x$, strictly for $x>0$. The information-radius identity
```math
 I_\mu=\int D(n(\cdot-x)\Vert n)\,d\mu(x)-D(q_\mu\Vert n)
```
proves the bound, and applying it to the optimizer proves strictness. The same local and tail estimates as before justify all terms. Scaling $X,Y,Z$ by $\alpha$ proves the second identity. ∎

In particular, the capacity is right-continuous at zero, and
```math
 C_{\alpha,\beta}(P)=\int_0^P\lambda(a(u))\,du.
 \tag{4.3}
```

## 5. Explicit equal-rate expressions

For $\alpha=\beta=1$, let
```math
 N(a)=\int_0^a t e^{-t}\log(a/t)\,dt,\qquad
 D(a)=a-2+(a+2)e^{-a},\qquad r(a)=N(a)/D(a).
 \tag{5.1}
```
Then $\lambda(a)=1-r(a)$, $a_0$ is the unique root $r(a_0)=1$, and
```math
 p_0=\left[1-e^{-a}+\frac{a r(a)e^{-a}}{\lambda(a)}\right]^{-1}.
 \tag{5.2}
```
The positive-threshold atom is $p_0a e^{-a}[r(a)-1/a]$, and the continuous input density is
```math
 r(a)^2p_0a e^{-a}e^{-\lambda(a)(x-a)}{\bf1}_{(a,\infty)}(x).
 \tag{5.3}
```
The mean and capacity reduce to
```math
 P(a)=p_0a e^{-a}\left[
       \frac{a r(a)}{\lambda(a)}-1+
                      \frac{r(a)^2}{\lambda(a)^2}\right],
 \tag{5.4}
```
```math
 C_{1,1}(P(a))=-\log p_0-\log a+a r(a)+2\lambda(a)
                +\lambda(a)P(a)-(1+\gamma).
 \tag{5.5}
```
These follow by direct substitution, using $h(n)=1+\gamma$. A numerical value is $a_0\approx1.6464039874$; this decimal is not used in any proof.

## 6. Singular low-cost limits

For a fixed normalized rate ratio $k>1$, define
```math
 r_k=(k-1)^{-1},\qquad K_k=\psi(r_k+2)-\psi(2)>0,\qquad
 c_k=k/(k-1),
 \tag{6.1}
```
where $\psi$ is the logarithmic derivative of the gamma function.

### Lemma 6.1 (entropy for unequal rates)

For rates $1,k$,
```math
 h(n)=-\log c_k+m+K_k,\qquad m=1+k^{-1}.
 \tag{6.2}
```

**Proof.** Under $U=e^{-(k-1)Z}$, the density (1.2) becomes
$r_k(r_k+1)u^{r_k-1}(1-u)$, the beta $(r_k,2)$ density. Differentiating the beta integral gives $\mathbb E[-\log(1-U)]=\psi(r_k+2)-\psi(2)=K_k$. Taking expectation in $\log n(Z)=\log c_k-Z+\log(1-U)$ proves (6.2). ∎

### Theorem 6.2 (distinct-stage low-cost asymptotics)

For fixed $k>1$, as $p\downarrow0$,
```math
 a(p)=\log(1/p)+\log(c_kK_k)+o(1),\qquad
 p-C_{1,k}(p)\sim\frac{K_kp}{\log(1/p)}.
 \tag{6.3}
```

**Proof.** At infinity,
```math
 B(a)=a-m+o(1),\quad \log n(a)=\log c_k-a+o(1),\quad
 \int_0^a n\log n=-h(n)+o(1).
```
The omitted term $(1-F(a))\log n(a)$ is also $o(1)$, by exponential tails. Thus (6.2) yields
```math
 1-\lambda(a)\sim K_k/a.
 \tag{6.4}
```
Moreover $p_0\to1$, $n(a)\sim c_ke^{-a}$,
```math
 d_a\sim(1-\lambda)/k,\qquad
 k_\lambda\sim(k-1)(1-\lambda)/k.
```
Inserting these into (2.6) gives
$P(a)\sim n(a)a(1-\lambda(a))\sim c_kK_ke^{-a}$.
Taking logarithms proves the threshold asymptotic.

Equation (4.3) gives
```math
 p-C_{1,k}(p)=\int_0^p[1-\lambda(a(u))]\,du.
 \tag{6.5}
```
The integrand is asymptotic to $K_k/\log(1/u)$. Its integral is asymptotic to $K_kp/\log(1/p)$: after $u=pv$, the ratio of $1/\log(1/(pv))$ to $1/\log(1/p)$ is at most one and tends to one for every $v>0$. Dominated convergence, together with uniform eventual upper and lower bounds furnished by the asymptotic equivalence, proves (6.3). ∎

### Theorem 6.3 (coincident-stage low-cost asymptotics)

For $L=\log(1/p)$, as $p\downarrow0$,
```math
 a(p)=L+\log L+\log\log L+o(1),\qquad
 p-C_{1,1}(p)\sim p\frac{\log L}{L}.
 \tag{6.6}
```

**Proof.** The gamma integral gives $\int_0^\infty t e^{-t}\log t\,dt=1-\gamma$, whence
```math
 N(a)=\log a-1+\gamma+O(e^{-a}),\qquad
 D(a)=a-2+O(ae^{-a}).
```
The first remainder follows by integrating $t e^{-t}\log(t/a)$ over $t>a$. Therefore $r(a)\sim\log a/a$. Equation (5.4) yields
```math
 P(a)\sim a\log a\,e^{-a}. \tag{6.7}
```
Taking logarithms first proves $a/L\to1$, and then gives
$L=a-\log a-\log\log a+o(1)$; substitution proves the threshold expansion. In (6.5), the integrand is now asymptotic to $\log\log(1/u)/\log(1/u)$. This function is eventually increasing with $u$, so the same $u=pv$ dominated-convergence argument proves (6.6). ∎

These results keep the rate ratio fixed. No uniform crossover is asserted when $k-1$ varies with $p$. In particular $K_k\to\infty$ as $k\downarrow1$, and the fixed-distinct-rate expansion cannot be substituted directly at the repeated-rate endpoint.

## 7. Sharp high-budget gap to maximum entropy

Set
```math
 b=a_0-\frac{F(a_0)}{n(a_0)},\qquad \kappa=m-b.
 \tag{7.1}
```

### Theorem 7.1 (first entropy-gap constant)

One has $b>0$. For fixed rates and $P\to\infty$,
```math
 C_{\alpha,\beta}(P)=1+\log(P+\kappa)-h(n)+O(P^{-2}),
 \tag{7.2}
```
and therefore
```math
 [1+\log(P+m)-h(n)]-C_{\alpha,\beta}(P)
     =b/P+O(P^{-2}).
 \tag{7.3}
```

**Proof.** Since $A(a_0)=0$, the nonconstant function $w(t)=n(t)/n(a_0)$ satisfies $\int_0^{a_0}w\log w=0$. Strict Jensen gives
```math
 0>\left(\int_0^{a_0}w\right)
           \log\left(a_0^{-1}\int_0^{a_0}w\right).
```
It follows that $F(a_0)/n(a_0) \lt a_0$, so $b>0$.

Equation (2.2) makes $a$ smooth in $\lambda$ near zero. Rewrite (3.1) as
```math
 \nu(\lambda)=-\log\lambda+
   \log\left(1+\lambda\frac{F(a)}{n(a)}\right)-\lambda a+\lambda m
 =-\log\lambda+\kappa\lambda+O(\lambda^2).
 \tag{7.4}
```
The remainder is smooth with derivative $O(\lambda)$. Comparing the unique optimizers at neighboring multipliers gives the envelope identity $\nu'(\lambda)=-P(\lambda)$, by the same difference-quotient squeeze as in Theorem 4.1. Thus $P=\lambda^{-1}-\kappa+O(\lambda)$. Substitute in $C=\nu+\lambda P-h(n)$ to obtain
```math
 C=-\log\lambda+1-h(n)+O(\lambda^2)
   =1+\log(P+\kappa)-h(n)+O(P^{-2}).
```
The exponential maximum-entropy bound uses output mean $P+m$; subtracting and expanding the logarithms gives (7.3). ∎

## 8. An exact boundary for the one-gap support geometry

Let $j\geq3$, let $r_1,\ldots,r_j>0$, and let $N$ be the sum of independent exponential stages with these rates. In this section $v$ denotes the density of $N$ and $m_N=\sum_i r_i^{-1}$. Repeated rates are allowed.

### Lemma 8.1 (cascade regularity)

The density $v$ is strictly log concave on $(0,\infty)$. For $j\geq3$, its zero extension belongs to $C^1(\mathbb R)$, $v(0)=v'(0)=0$, and $v,v'$ are bounded.

**Proof.** For $c=\prod_i r_i/(j-1)!$, $r_-=\min r_i$, $r_+=\max r_i$, the convolution simplex gives
```math
 ct^{j-1}e^{-r_+t}\leq v(t)\leq ct^{j-1}e^{-r_-t}.
 \tag{8.1}
```
To see strict log concavity, let $h>0$ be a smooth log-concave function and $H(t)=\int_0^t h(s)\,ds$. Put $b(t)=h'(t)/h(t)$. Then
```math
 (\log H)''=\frac hH\left(b-\frac hH\right)<0.
 \tag{8.2}
```
If $b\leq0$, this is immediate. If $b>0$, the log-concave tangent bound gives
```math
 H(t)\leq h(t)\int_0^t e^{b(t)(s-t)}ds \lt h(t)/b(t),
```
again proving strictness. Convolution with a stage of rate $r$ has the form
```math
 v_{\rm new}(t)=r e^{-rt}\int_0^t v_{\rm old}(s)e^{rs}\,ds.
```
Starting from the log-concave one-stage exponential density, (8.2) proves strict log concavity from stage two onward. Also $v_{\rm new}'=r(v_{\rm old}-v_{\rm new})$. At stage three and later both terms vanish at zero and are bounded. This proves the regularity statement. ∎

### Theorem 8.2 (three or more stages cannot have the same support)

At any finite positive mean-input budget, no capacity-achieving nonnegative input law $\mu$ for noise $N$ can satisfy all three conditions
```math
 \mu(\{0\})=p_0>0,\qquad \mu((0,a))=0,\qquad
 [a,\infty)\subseteq\operatorname{supp}\mu
 \tag{8.3}
```
for any $a>0$. The tail need not possess a density; topological support is sufficient.

**Proof.** Every finite-mean output $q_\eta=v*\eta$ has bounded density and finite mean, hence finite entropy. Thus the capacity function is finite, concave and nondecreasing. It is unbounded: for an input uniform on $[0,2P]$, $q_\eta\leq1/(2P)$, so the mutual information is at least $\log(2P)-h(v)$. A finite concave nondecreasing unbounded function is strictly increasing and has a finite positive supporting slope $\lambda$ at every positive budget. Therefore any hypothetical optimizer uses the full budget and maximizes $h(q_\eta)-\lambda\mathbb E_\eta X$ over finite-mean laws.

Suppose (8.3) holds, and write $q=v*\mu$, $g=-\log q$, and
```math
 G(x)=\int_0^\infty v(t)g(x+t)\,dt.
```
Since $q\geq p_0v>0$ on $(0,\infty)$, (8.1) and boundedness of $q$ imply that $g$ is bounded below, grows at most linearly at infinity, and has at most a logarithmic singularity at zero. Consequently $G$ is finite on $[0,\infty)$ and continuous on $(0,\infty)$.

For any fixed $x\geq0$, let $v_x(y)=v(y-x){\bf1}_{y>x}$ and $q_t=(1-t)q+tv_x$. The preceding bounds imply $D(v_x\Vert q)<\infty$, and
```math
 h(q_t)=(1-t)h(q)+tG(x)-D(q_t\Vert q).
```
Moreover $D(q_t\Vert q)/t\to0$. Indeed, with $\phi(u)=u\log u-u+1$,
```math
 0\leq\frac{\phi(1+t(u-1))}{t}\leq\phi(u),
```
and the quotient tends pointwise to zero; apply dominated convergence under $q$, with $u=v_x/q$. Penalized optimality therefore gives
```math
 G(x)-\lambda x\leq B,\qquad B=h(q)-\lambda P.
 \tag{8.4}
```
Integrating against $\mu$ gives equality almost surely. The zero atom and continuity on positive support imply
```math
 G(0)=B,\qquad G(x)=B+\lambda x\quad(x\geq a).
 \tag{8.5}
```

For $r>0$, the backward exponential resolvent
```math
 (R_r u)(x)=\int_0^\infty r e^{-rt}u(x+t)\,dt
```
satisfies $(1-r^{-1}D)R_r u=u$ distributionally on $(0,\infty)$, by differentiating $r e^{rx}\int_x^\infty e^{-ry}u(y)\,dy$. Fubini gives $G=R_{r_1}\cdots R_{r_j}g$, so
```math
 \prod_{i=1}^j(1-r_i^{-1}D)G=g.
 \tag{8.6}
```
On the tail, (8.5) and (8.6) imply
$g(x)=B+\lambda x-\lambda m_N$. Thus $q$ is exponential on $(a,\infty)$. Below $a$, the support gap gives $q(y)=p_0v(y)$.

By Lemma 8.1, convolution makes $q$ continuously differentiable. Matching the two output derivatives at $a$ therefore forces
```math
 \lambda=-(\log v)'(a). \tag{8.7}
```
Continuity also fixes the exponential tail as $p_0v(a)e^{-\lambda(y-a)}$. Equality at zero in (8.5) now yields
```math
 \int_0^a v(t)\left[
     \log\frac{v(a)}{v(t)}+\lambda(a-t)\right]dt=0.
 \tag{8.8}
```
But (8.7) makes the bracket the strict tangent-line gap of the strictly concave function $\log v$ at $a$. It is positive for every $0 \lt t \lt a$, contradicting (8.8). ∎

For two stages, $n'(0+)=\alpha\beta>0$. An input atom at $a$ can produce a jump in the output derivative, which is precisely the positive threshold atom in (2.5). The obstruction therefore identifies a boundary of this support topology within exponential cascades. It does not characterize the true optimum for three or more stages, prove its discreteness, or exclude every continuous component.

## 9. Reproduction and limitations

The result requires only scalar quadrature and monotone root-finding for numerical evaluation: bracket $a_0$, solve $P(a)=P$, and evaluate (2.3), (2.5), and (3.7). At very small budgets, direct capacity evaluation subtracts quantities much larger than the answer. High precision, or the integral (4.3), is preferable. Numerical checks are diagnostics; the continuum certificate supplies the proof.

The optimization is over all finite-mean Borel laws and has no discretization assumption. The capacity is the mutual-information capacity of the stationary memoryless per-use mean-cost model. The standard memoryless cost-constrained coding theorem gives its usual operational interpretation under that convention; no new coding theorem is claimed. There is no result here for queues, intersymbol interference, synchronization ambiguity, a fixed message-duration constraint, or rate per unit elapsed time.

Coincident rates are included directly in the finite-budget proof. The asymptotic formulas are fixed-parameter statements and are not claimed uniform in the rate ratio. The higher-stage theorem is an obstruction, not an exact capacity formula for higher stages. Formal proof-assistant verification and external peer review have not been performed.

## References

[1] S. Verdú, “The Exponential Distribution in Information Theory,” *Problems of Information Transmission*, 32(1), 86–95, 1996; Russian original *Problemy Peredachi Informatsii*, 32(1), 100–111. Publisher record: https://www.mathnet.ru/eng/ppi324 . Publisher abstract and bibliographic record inspected.

[2] R. Mathar, A. Schmeink, and M. Zivkovic, “Optimum Discrete Signaling over Channels with Arbitrary Noise Distribution,” *2nd International Conference on Signal Processing and Communication Systems (ICSPCS)*, Gold Coast, Australia, December 2008. Author-hosted five-page manuscript: https://www.ti.rwth-aachen.de/publications/output.php?id=654&table=proceeding&type=pdf . Sections I–III and finite-constellation scope inspected; conference metadata checked against the authors' institutional publication directory. An unverified DOI is omitted.

[3] J. Fahs and I. Abou-Faycal, “On Properties of the Support of Capacity-Achieving Distributions for Additive Noise Channel Models With Input Cost Constraints,” *IEEE Transactions on Information Theory*, 64(2), 1178–1198, 2018. DOI: https://doi.org/10.1109/TIT.2017.2771815 . Complete publisher article at the authors' institution: https://scholarworks.aub.edu.lb/server/api/core/bitstreams/6e8d1eae-fa8e-4249-8c53-7207808c5c8f/content . Introduction, growth-order transition, and assumption C5 checked.

[4] K. Aghababaiyan, V. Shah-Mansouri, and B. Maham, “Capacity and Error Probability Analysis of Neuro-Spike Communication Exploiting Temporal Modulation,” *IEEE Transactions on Communications*, 68(4), 2078–2089, 2020. DOI: https://doi.org/10.1109/TCOMM.2019.2962805 . Author bibliography: https://sites.google.com/site/behrouzmaham/publications . The author's linked PDF could not be retrieved during this comparison; exact constraints and full theorem statements remain unverified.

[5] J. Stapmanns, L. Eilers, C. Dias, T. Kühn, and J.-P. Pfister, “Phase Transitions of the Additive Uniform Noise Channel With Peak Amplitude and Cost Constraint,” *IEEE Transactions on Information Theory*, 72(7), 4565–4586, July 2026. DOI: https://doi.org/10.1109/TIT.2026.3687151 . The author-uploaded final typeset article, including its introduction, support theorem, capacity statements and discussion on p. 4575, was inspected. Author publication record: https://tobikausk.github.io/publications/ .

[6] [*Exact capacity and unique mixed input for Laplace noise under absolute input cost*](../laplace-absolute-cost-capacity/paper.en.md). Research manuscript.

