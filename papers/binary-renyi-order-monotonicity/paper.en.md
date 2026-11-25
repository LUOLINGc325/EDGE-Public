# Sharp cross-order bounds for binary Rényi entropies above order one

*A positive answer to the remaining powered-monotonicity question*

24 November 2026 · Public research draft

## Abstract

For the binary Rényi entropy $H_\alpha(p)$, define $F_\alpha(p)=(H_\alpha(p)/\ln 2)^{2/\alpha}$. A question arising in quantum entropy estimation asks whether this quantity increases with the order. The assertion over all positive orders has already been refuted; the subsequent refutation dossier explicitly leaves orders above one open. We prove that $F_\alpha(p)$ is nondecreasing on $[1,\infty)$ for every $p\in[0,1]$, and strictly increasing at every nonuniform, nonpure binary distribution. Consequently, for $1\le a<b<\infty$,

$$
H_a(p)\le (\ln 2)^{1-a/b} H_b(p)^{a/b}.
$$

The exponent $a/b$ is optimal among all exponents in this normalized power comparison. The proof combines log-convexity of binary Rényi entropy in the order above one with a Shannon entropy–varentropy inequality that controls the endpoint. Both facts follow from one elementary inequality in the odds ratio. The result applies directly to density matrices of rank at most two. It supplies a uniform entropy-comparison tool, without asserting a new computational-complexity separation or changing the known counterexample below order one.

## 1. The precise question and its scope

Throughout, logarithms are natural and $c=\ln 2$. For $0<p<1$, set

$$
H_\alpha(p)=\frac{\ln(p^\alpha+(1-p)^\alpha)}{1-\alpha}
\quad (\alpha>0,\ \alpha\ne1),
$$

and use the continuous extension

$$
H_1(p)=-p\ln p-(1-p)\ln(1-p).
$$

At $p=0,1$ all these entropies are zero. Their common maximum, attained at $p=1/2$, is $c$.

Liu [1, Section 1.4(2)] asks about monotonicity of $(H_\alpha(p)/c)^{2/\alpha}$ in the order, motivated by inequalities used in reductions for quantum entropy estimation. The published comparison with order two [1, Theorem 20] does not compare arbitrary pairs of orders. The later trureturing dossier [2] gives a counterexample at $p=1/17$, with orders $1/4$ and $1/2$, and explicitly leaves the interval $\alpha>1$ unresolved. The exact statement addressed here is that remaining interval, including its Shannon endpoint.

Earlier work already describes the joint range of Rényi entropies and its distributional extremizers [4, 5]. Those exact parametric descriptions should be distinguished from the explicit power envelope proved here. Work on curvature in the entropy order [3] provides other convex transforms, and preservation of log-convexity under positive integration is standard [6]. Our contribution is the above-one binary inequality and its proof, rather than those underlying analytic tools or the general idea of cross-order entropy comparison.

**Theorem 1 (powered monotonicity).** For every $p\in[0,1]$, the function

$$
F_\alpha(p)=\left(\frac{H_\alpha(p)}{c}\right)^{2/\alpha}
$$

is nondecreasing in $\alpha\in[1,\infty)$. If $p\notin\{0,1/2,1\}$, its derivative is strictly positive at every finite order in this interval, with the right derivative understood at one. At $p=0,1$, it is constantly zero; at $p=1/2$, it is constantly one.

**Theorem 2 (sharp cross-order comparison).** Let $1\le a<b<\infty$. Then

$$
\left(\frac{H_a(p)}{c}\right)^{b/a}
\le \frac{H_b(p)}{c}\le \frac{H_a(p)}{c}
\qquad (p\in[0,1]).
$$

The left inequality is strict for $p\notin\{0,1/2,1\}$. Equivalently,

$$
H_a(p)\le c^{1-a/b}H_b(p)^{a/b}.
$$

For fixed $a,b$, $a/b$ is the largest positive exponent $\theta$ for which

$$
H_a(p)/c\le (H_b(p)/c)^\theta
$$

holds for all binary probabilities $p$. This optimality concerns the exponent in this particular normalized power form; it does not exclude stronger bounds using additional terms or more information about $p$.

The proof below is analytic. Finite grids, plots, and symbolic calculations in the accompanying package are reproducibility checks, not the justification of the universal quantifiers.

## 2. One elementary odds-ratio inequality

By symmetry, it is enough to consider $0<p<1/2$. Introduce

$$
r=\frac{p}{1-p}\in(0,1),\qquad u=-\ln r>0,\qquad d=\ln(1+r).
$$

Thus $p=r/(1+r)$ and $1-p=1/(1+r)$. The letter $d$ depends on $p$; $c=\ln2$ remains fixed.

**Lemma 3.** For every $0<r<1$,

$$
d(1-r^2)>u r^2.
\tag{1}
$$

**Proof.** The integral formulas for the logarithm give

$$
\ln(1+r)=\int_0^r\frac{dt}{1+t}>\frac{r}{1+r},
\qquad
-\ln r=\int_r^1\frac{dt}{t}<\frac{1-r}{r}.
$$

Multiplying by the positive factors needed in (1) yields

$$
d(1-r^2)>r(1-r)>u r^2.
$$

All inequalities are strict in the stated open interval. $\square$

The same scalar inequality will control the dependence on the entropy order and the dependence of Shannon entropy on the odds ratio.

## 3. Log-convexity in the entropy order

**Lemma 4.** For every fixed $0<p<1$ with $p\ne1/2$, the map $\alpha\mapsto H_\alpha(p)$ is log-convex on $[1,\infty)$.

**Proof.** Continue with $p<1/2$ and the variables above. For $s\ge1$, define

$$
g(s)=d+\frac{u r^s}{1+r^s}>0.
$$

The numerator in

$$
H_\alpha(p)=\frac{\alpha d-\ln(1+r^\alpha)}{\alpha-1}
$$

vanishes at $\alpha=1$ and has derivative $g(\alpha)$. Consequently,

$$
H_\alpha(p)=\int_0^1 g\bigl(1+t(\alpha-1)\bigr)\,dt
\qquad(\alpha\ge1).
\tag{2}
$$

This includes $H_1(p)=g(1)$.

Write $y=r^s$, so $0<y\le r<1$. Direct differentiation gives

$$
g'(s)=-\frac{u^2y}{(1+y)^2},\qquad
g''(s)=\frac{u^3y(1-y)}{(1+y)^3}.
$$

It follows that

$$
g(s)g''(s)-g'(s)^2
=\frac{u^3y}{(1+y)^4}\bigl[d-(d+u)y^2\bigr]>0.
\tag{3}
$$

Indeed, the bracket is bounded below by $d(1-r^2)-ur^2$, which is positive by Lemma 3. Thus $g$ is strictly log-convex on $[1,\infty)$.

For completeness, log-convexity is preserved by the integral in (2). If $a,b\ge1$ and $0<\lambda<1$, log-convexity of $g$ gives, pointwise in $t$,

$$
g\bigl(1+t(\lambda a+(1-\lambda)b-1)\bigr)
\le g(1+t(a-1))^\lambda g(1+t(b-1))^{1-\lambda}.
$$

Integrating and applying Hölder's inequality proves

$$
H_{\lambda a+(1-\lambda)b}(p)
\le H_a(p)^\lambda H_b(p)^{1-\lambda}.
$$

The integrands are positive and continuous on a compact interval, so all terms are finite. This establishes the claimed log-convexity. $\square$

The restriction to binary distributions matters. No general-alphabet log-convexity assertion is used or claimed. Equation (2) also supplies the smooth extension through order one required later.

## 4. The Shannon endpoint

For a binary distribution, its varentropy is the variance of the information content $-\ln P(X)$:

$$
V(p)=p(1-p)\left(\ln\frac{1-p}{p}\right)^2.
$$

**Lemma 5 (endpoint inequality).** For $0<p<1$, $p\ne1/2$,

$$
\frac{V(p)}{2H_1(p)}<\ln\frac{c}{H_1(p)}.
\tag{4}
$$

At $p=1/2$, both sides are zero.

**Proof.** Parameterize $p$ by $u\ge0$:

$$
p(u)=\frac{1}{1+e^u},\quad
w(u)=p(u)(1-p(u)),\quad
h(u)=H_1(p(u)).
$$

Since $h(u)=\ln(1+e^{-u})+up(u)$,

$$
h'(u)=-u w(u),\qquad
w'(u)=-w(u)\tanh(u/2).
$$

Let $k(u)=w(u)/h(u)$. Differentiation gives

$$
k'(u)=\frac{w(u)}{h(u)^2}
\bigl[u w(u)-h(u)\tanh(u/2)\bigr].
\tag{5}
$$

For $u>0$, put $r=e^{-u}$ and $d=\ln(1+r)$. The negative of the bracket in (5) is

$$
h(u)\tanh(u/2)-u w(u)
=\frac{d(1-r^2)-ur^2}{(1+r)^2}>0
$$

by Lemma 3. Hence $k$ is strictly decreasing on $(0,\infty)$ and continuous at zero.

Now let $E(u)=\ln(c/h(u))$. We have $E(0)=0$ and $E'(u)=u k(u)$. Thus, for every $u>0$,

$$
E(u)=\int_0^u v k(v)\,dv
>k(u)\int_0^u v\,dv
=\frac{u^2w(u)}{2h(u)}.
$$

The right side is $V(p)/(2H_1(p))$. Symmetry covers $p>1/2$. $\square$

We also need the order derivative at one. Differentiate (2) under its continuous integrand:

$$
\left.\frac{\partial H_\alpha(p)}{\partial\alpha}\right|_{\alpha=1}
=\frac{g'(1)}2=-\frac{V(p)}2.
\tag{6}
$$

This avoids taking a derivative of a quotient with a removable singularity.

## 5. Proof of powered monotonicity

**Proof of Theorem 1.** Fix $p\notin\{0,1/2,1\}$ and define

$$
z(\alpha)=-\ln\frac{H_\alpha(p)}c.
$$

Lemma 4 says that $z$ is concave on $[1,\infty)$. The integral representation makes it twice continuously differentiable at every finite order, including the right endpoint derivative at one. Set

$$
R(\alpha)=z(\alpha)-\alpha z'(\alpha).
$$

Then

$$
R'(\alpha)=-\alpha z''(\alpha)\ge0,
$$

while Lemma 5 and (6) give

$$
R(1)=\ln\frac{c}{H_1(p)}-\frac{V(p)}{2H_1(p)}>0.
$$

Therefore $R(\alpha)>0$ for all $\alpha\ge1$. Since

$$
\ln F_\alpha(p)=-\frac{2z(\alpha)}\alpha,
\qquad
\frac{d}{d\alpha}\ln F_\alpha(p)
=\frac{2R(\alpha)}{\alpha^2}>0,
$$

strict monotonicity follows. The three exceptional probabilities give the constant functions stated in the theorem directly from their definitions. $\square$

For every fixed $0<p<1$, $H_\alpha(p)$ tends to the positive min-entropy $-\ln\max\{p,1-p\}$ as $\alpha\to\infty$. Hence $F_\alpha(p)\to1$. The convergence is not uniform up to the pure endpoints: $F_\alpha(0)=F_\alpha(1)=0$ for every finite order. We make no interchangeable-limit claim at those endpoints.

## 6. Optimal exponents and rank-two quantum states

**Proof of Theorem 2.** Theorem 1 immediately gives the left comparison. The right comparison is ordinary Rényi monotonicity. Within this proof it can also be read off from (2): $g'(s)<0$ implies that the average is strictly decreasing in the order for a nonuniform, nonpure distribution.

To prove optimality, write $p=(1+\delta)/2$ and let $\delta\to0$. For each fixed finite $s\ge1$,

$$
H_s\left(\frac{1+\delta}{2}\right)
=c-\frac{s}{2}\delta^2+O(\delta^4).
\tag{7}
$$

For $s>1$ this follows by expanding $(1\pm\delta)^s$ and the logarithm in the definition. At $s=1$ it follows from the Shannon expression, giving the same coefficient. Therefore

$$
\frac{H_a(p)}c=1-\frac{a}{2c}\delta^2+O(\delta^4),
\qquad
\left(\frac{H_b(p)}c\right)^\theta
=1-\frac{\theta b}{2c}\delta^2+O(\delta^4).
$$

If $\theta>a/b$, the desired upper comparison fails for every sufficiently small nonzero $\delta$. Since Theorem 1 proves that $\theta=a/b$ works for all $p$, this exponent is optimal. $\square$

**Corollary 6 (rank at most two).** Let $\rho$ be a density matrix with rank at most two, in any finite-dimensional Hilbert space. For $1\le a<b<\infty$,

$$
S_a(\rho)\le c^{1-a/b} S_b(\rho)^{a/b},
$$

where $S_\alpha(\rho)=\ln\operatorname{Tr}(\rho^\alpha)/(1-\alpha)$, with its von Neumann extension at one. Equality holds for rank-one states and for states with two equal nonzero eigenvalues; otherwise the inequality is strict.

**Proof.** The spectrum has at most two nonzero entries and, after adding a zero entry when needed, is represented by $p,1-p$. Zero eigenvalues make no contribution at positive orders. Apply Theorem 2. $\square$

For entropy estimation, this yields a direct comparison between every pair of orders at least one. If $h_a=H_a/c$, then

$$
h_a^{b/a}\le h_b\le h_a.
$$

Conversely, $h_b\le h_a\le h_b^{a/b}$. The exponent is strongest near the maximally mixed binary state in the exact sense proved above. These are deterministic inequalities. A useful complexity reduction additionally needs an input model, an appropriate promise gap, and a separate reduction argument. Those tasks are outside this manuscript.

**Corollary 7 (independent binary factors).** Let $X=(X_1,\ldots,X_n)$ consist of independent binary variables, with $n\ge1$. Then

$$
\frac{H_a(X)}{nc}\le
\left(\frac{H_b(X)}{nc}\right)^{a/b}
\qquad(1\le a<b<\infty).
$$

The same statement holds for a tensor product of $n$ density matrices, each of rank at most two. This is a direct corollary, not a claim about arbitrary correlated high-rank states.

**Proof.** Rényi entropy is additive for independent factors: the power sum factorizes, and the logarithm turns the product into a sum. Write $h_{s,i}=H_s(X_i)/c$. Theorem 2 and concavity of $x\mapsto x^{a/b}$ on $[0,1]$ give

$$
\frac1n\sum_i h_{a,i}
\le\frac1n\sum_i h_{b,i}^{a/b}
\le\left(\frac1n\sum_i h_{b,i}\right)^{a/b}.
$$

The spectral power sum factorizes in the same way for tensor-product quantum states. Identical factors approaching the uniform binary distribution show, by (7), that the exponent is again optimal within this normalized power form. $\square$

## 7. Reproducibility and limitations

The companion package contains a high-precision numerical audit of the derivative sign, symbolic checks of the algebraic identities, scripts that generate the comparison table and figure, bilingual manuscripts, and a documented literature audit. The main proof uses elementary calculus and Hölder's inequality. It does not rely on numerical optimization, an unproved conjecture, or a finite search.

For the binary distribution with probability $1/17$, prior nonmonotonicity occurs below order one; the theorem establishes strict increase above order one.

The main theorem concerns binary probabilities and density matrices of rank at most two, with the direct independent-product extension in Corollary 7. We do not classify the largest possible interval below one, prove the same inequality for arbitrary correlated high-rank states, or claim to have repaired the false all-positive-order conjecture. The low-order counterexample belongs to [2]. The result here establishes the remaining regime at and above order one and its sharp power comparison.

This is an AI-assisted research draft. It has not undergone external peer review. No end-to-end Lean verification is claimed. The literature comparison is limited to the primary sources examined; it does not certify worldwide priority.

## References

[1] Yupan Liu. *Computational Hardness of Estimating Quantum Entropies via Binary Entropy Bounds*. STACS 2026, LIPIcs 364, 66:1–66:23. DOI: [10.4230/LIPIcs.STACS.2026.66](https://doi.org/10.4230/LIPIcs.STACS.2026.66). Full version: [arXiv:2601.03734v2](https://arxiv.org/abs/2601.03734v2). The published question is in Section 1.4(2), and the comparison with order two is Theorem 20; the full-version numbering differs.

[2] The Omega Institute / trureturing. *The powered binary Rényi entropy is not monotone in the order*. Primary research dossier and associated formal source. [Research dossier](https://www.trureturing.org/research/liu-2026-powered-binary-renyi-monotonicity-refutation/), inspected 24 November 2026. The final scope note leaves orders $\alpha>1$ open.

[3] Filipp Buryak and Yuliya Mishura. *Convexity and robustness of the Rényi entropy*. Modern Stochastics: Theory and Applications 8(3), 387–412 (2021). DOI: [10.15559/21-VMSTA185](https://doi.org/10.15559/21-VMSTA185).

[4] Peter Harremoës. *Joint Range of Rényi Entropies*. Kybernetika 45(6), 901–911 (2009). [Primary journal text](https://dml.cz/bitstream/handle/10338.dmlcz/140023/Kybernetika_45-2009-6_2.pdf).

[5] Yuta Sakai and Ken-ichi Iwata. *Sharp Bounds Between Two Rényi Entropies of Distinct Positive Orders*. [arXiv:1605.00019v2](https://arxiv.org/abs/1605.00019v2) (2016).

[6] György Steinbrecher and Giorgio Sonnino. *Numerical Stability of Generalized Entropies*. [arXiv:1603.06240v3](https://arxiv.org/abs/1603.06240v3) (2016), Section 6.4.1.
