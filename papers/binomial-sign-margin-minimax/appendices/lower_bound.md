# Lower bound: localized moment cancellation

**Scope.** This note concerns the frozen scalar count experiment only. It proves a uniform lower bound for every fixed \(\beta>0\), every \(L\ge1\), and all positive integers \(Q,n\). It does not prove an upper bound, the original spectral conjecture, or a complete minimax characterization. The polynomial duality input and moment-cancellation principle are prior tools; the localized embedding and its quantitative binomial comparison are the mathematical content investigated here. Priority for this combination has not been established by this note.

## 1. Model and an explicit statement

Write
\[
\mathcal G_{\beta,L}
=\{G\in\mathcal P([-1,1]):G([-t,t])\le Lt^\beta\quad(0<t\le1)\},
\qquad
\theta(G)=\int\operatorname{sgn}(z)\,dG(z).
\]
The observations are \(Q\) independent draws from
\[
(K_nG)(k)=\binom nk\int
\left(\frac{1+z}{2}\right)^k
\left(\frac{1-z}{2}\right)^{n-k}dG(z),\quad 0\le k\le n.
\]
Let \(R^{\mathrm{dec}}_{Q,n}(\beta,L)\) denote minimax expected loss
\(|\theta(G)|\mathbf1\{\widehat\sigma\theta(G)<0\}\), with randomized decisions allowed.

**Theorem L1 (uniform lower bound).** For each \(\beta>0\), a constant \(c_\beta>0\) exists such that, simultaneously for every \(L\ge1\) and integers \(Q,n\ge1\),
\[
R^{\mathrm{dec}}_{Q,n}(\beta,L)
\ge c_\beta\max\left\{
Q^{-1/2},\ n^{-\beta},\
\big[n\log(e+Q)\big]^{-\beta/2}
\right\}.                                                     \tag{L1}
\]
An equivalent lower-bound profile, with constants depending only on \(\beta\), replaces the third term by
\[
\big[n\log(e+Qn^{-\beta/2})\big]^{-\beta/2}.                  \tag{L2}
\]
The stronger statement proved below is a finite-degree hard-pair certificate. In particular, (L1) is not inferred from numerical experiments.

## 2. Prior weighted-approximation input

Let
\[
d\mu_\beta(x)=\frac\beta2|x|^{\beta-1}\,dx\quad(-1\le x\le1),
\qquad
E_d(\beta)=\inf_{P\in\Pi_d}\int|\operatorname{sgn}(x)-P(x)|\,d\mu_\beta(x).
\]
Here \(\Pi_d\) is the space of polynomials of degree at most \(d\).
We use the established weighted approximation result
\[
E_d(\beta)\ge a_\beta d^{-\beta},\qquad d\ge1,                \tag{L3}
\]
for some \(a_\beta>0\). Zhang--Amini, arXiv:2610.21363v1, Appendix E, Lemma E.3 proves this using the weighted inverse theorem of Kopotun (2015), together with a localized Jackson upper bound. This note does not claim (L3) as a new result.

The same paper's Lemma E.4, or elementary \(L^1\)-duality, gives an odd measurable \(g_d\) satisfying
\[
|g_d|\le1\quad\mu_\beta\text{-a.e.},\qquad
\int x^j g_d(x)\,d\mu_\beta(x)=0\quad(0\le j\le d),
\qquad
\int\operatorname{sgn}(x)g_d(x)\,d\mu_\beta(x)=E_d(\beta).     \tag{L4}
\]
For completeness, Hahn--Banach supplies a norm-one functional attaining the distance of the sign function to the finite-dimensional polynomial subspace. Represent it by an \(L^\infty(\mu_\beta)\) function and replace that function by \((g(x)-g(-x))/2\). Symmetry of \(\mu_\beta\) preserves feasibility and the objective, yielding (L4). Thus
\[
d\mu_{d,\pm}(x)=(1\pm g_d(x))d\mu_\beta(x)                  \tag{L5}
\]
are probability measures. Oddness gives the useful exact identity
\[
\mu_{d,+}([-t,t])=\mu_{d,-}([-t,t])=t^\beta\quad(0\le t\le1), \tag{L6}
\]
and \(\theta(\mu_{d,\pm})=\pm E_d(\beta)\).

## 3. A localized pair satisfying the original margin class

Fix \(1\le d\le n\), and put
\[
h=\sqrt{\frac d{64n}},\qquad \lambda=h^\beta,
\qquad H_0=\frac12(\delta_{-1}+\delta_1).
\]
Let \(D_h\mu\) be the pushforward under \(x\mapsto hx\), and define
\[
F_{d,\pm}=(1-\lambda)H_0+\lambda D_h\mu_{d,\pm}.             \tag{L7}
\]
Because \(h\le1/8\), these are probability measures with nonnegative weights.
For \(0<t\le h\), (L6) yields
\[
F_{d,\pm}([-t,t])=\lambda(t/h)^\beta=t^\beta.
\]
For \(h<t<1\), that mass is \(\lambda=h^\beta\le t^\beta\); at \(t=1\) it is one. Hence
\[
F_{d,\pm}\in\mathcal G_{\beta,1}\subseteq\mathcal G_{\beta,L}
\quad\text{for every }L\ge1.                                \tag{L8}
\]
The pair is reflected, its moments through degree \(d\) agree, and its targets are
\[
\theta(F_{d,\pm})=\pm b_d,\qquad
b_d=h^\beta E_d(\beta)
\ge a_\beta8^{-\beta}(nd)^{-\beta/2}.                         \tag{L9}
\]
There is no hidden change of the margin constant or exponent in this scaling.

## 4. Exact binomial quadratic identity

Set \(B_n(k)=2^{-n}\binom nk\), which is strictly positive for every count. For any finite signed measure \(\nu\) on \([-1,1]\),
\[
\sum_{k=0}^n\frac{(K_n\nu)(k)^2}{B_n(k)}
=\sum_{j=0}^n\binom nj\left(\int z^j\,d\nu(z)\right)^2.     \tag{L10}
\]

**Proof.** Under independent fair signs \(X_1,\ldots,X_n\), the likelihood ratio of the Bernoulli experiment with signed advantage \(z\) is
\[
L_z(X)=\prod_{i=1}^n(1+zX_i)
=\sum_{A\subseteq[n]}z^{|A|}\prod_{i\in A}X_i.
\]
The products indexed by subsets are orthonormal. Integrating against \(\nu\), squaring, and taking fair-sign expectation gives the right-hand side of (L10). The integrated likelihood ratio depends only on the number of positive signs, so this same expectation is exactly its left-hand side. All sums are finite. This is the elementary binomial/Krawtchouk quadratic identity, not a new orthogonality theorem. \(\square\)

Write \(P_\pm=K_nF_{d,\pm}\) and \(\Delta_j=\int z^j\,d(F_{d,+}-F_{d,-})(z)\). Then
\[
\Delta_j=0\quad(j\le d),\qquad |\Delta_j|\le2\lambda h^j\quad(j>d).
\]
Consequently,
\[
\sum_k\frac{(P_+(k)-P_-(k))^2}{B_n(k)}
\le4\lambda^2\sum_{j=d+1}^n\binom nj h^{2j}.                 \tag{L11}
\]
If \(d=n\), this is zero and the observable laws coincide exactly.

## 5. The denominator is supplied by a feasible common local law

The Hellinger convention is
\[
H^2(P,Q)=\sum_k(\sqrt{P(k)}-\sqrt{Q(k)})^2.
\]
A quadratic bound relative to \(B_n\) alone does **not** automatically bound this Hellinger distance: a pointwise lower bound on the actual pair's denominator is needed.

For \(0\le z<1\), the average likelihood ratio of advantages \(z,-z\), relative to \(B_n\), is
\[
\frac{(1+z)^k(1-z)^{n-k}+(1-z)^k(1+z)^{n-k}}2
=(1-z^2)^{n/2}
\cosh\left((k-n/2)\log\frac{1+z}{1-z}\right)
\ge(1-z^2)^{n/2}.                                          \tag{L12}
\]
Let \(r=\min\{h,(2n)^{-1/2}\}\). On \(0\le z\le r\), Bernoulli's inequality gives
\((1-z^2)^n\ge1-nz^2\ge1/2\), so (L12) is at least \(1/\sqrt2\). By the symmetry of \(D_h\mu_\beta\),
\[
\lambda(K_nD_h\mu_\beta)(k)
\ge\frac{\lambda}{\sqrt2}(r/h)^\beta B_n(k)
=\frac{r^\beta}{\sqrt2}B_n(k).
\]
Since \(d\ge1\), both arguments in the minimum defining \(r\) are at least \((8\sqrt n)^{-1}\). The identity \(\mu_{d,+}+\mu_{d,-}=2\mu_\beta\) therefore yields
\[
P_+(k)+P_-(k)
\ge\sqrt2\,8^{-\beta}n^{-\beta/2}B_n(k).                    \tag{L13}
\]
The factor \(n^{-\beta/2}\) is essential. No uniform mixing density or atom at zero has been added.

Combining (L11)--(L13), and using
\((\sqrt a+\sqrt b)^2\ge a+b\), gives
\[
H^2(P_+,P_-)
\le2\sqrt2\,8^{-\beta}n^{-\beta/2}d^\beta
\sum_{j=d+1}^n\binom nj\left(\frac d{64n}\right)^j.           \tag{L14}
\]
To bound the tail, use \(\binom nj\le n^j/j!\), the ratio of successive terms, and \(j!\ge(j/e)^j\):
\[
\sum_{j=d+1}^n\binom nj\left(\frac d{64n}\right)^j
\le\sum_{j=d+1}^\infty\frac{(d/64)^j}{j!}
\le\frac{64}{63}\left(\frac e{64}\right)^{d+1}
\le2e^{-3d}.                                               \tag{L15}
\]
The final numerical inequality follows from \(e^4<64\). We conclude the following finite certificate.

**Proposition L2 (finite-degree hard pair).** For every \(\beta>0\) and integers \(1\le d\le n\), the pair in (L7) satisfies (L8)--(L9), and
\[
H^2(P_+,P_-)\le8n^{-\beta/2}d^\beta e^{-3d}\quad(d<n),
\qquad P_+=P_-\quad(d=n).                                  \tag{L16}
\]
The displayed constant is intentionally loose. Formula (L14), or the finite tail in it, is stronger.

## 6. Choosing the degree and deriving the uniform risk bound

Put
\[
A_\beta=\max\{1,(\beta/e)^\beta\},\quad u=Qn^{-\beta/2},
\quad
D=\max\left\{1,\left\lceil\frac12\log(32A_\beta u)\right\rceil\right\},
\quad d=\min\{n,D\}.                                      \tag{L17}
\]
The elementary maximization \(\sup_{x>0}x^\beta e^{-x}=(\beta/e)^\beta\) implies, when \(d<n\),
\[
QH^2(P_+,P_-)
\le8uA_\beta e^{-2d}\le\frac14.
\]
When \(d=n\), the product laws are identical. In either case, tensorization and \(\operatorname{TV}\le H\) give
\[
\operatorname{TV}(P_+^{\otimes Q},P_-^{\otimes Q})\le\frac12.
\]
Any randomized decision consequently has maximal risk at least
\[
\frac{b_d}{2}\left(1-\operatorname{TV}(P_+^{\otimes Q},P_-^{\otimes Q})\right)
\ge\frac{b_d}{4}.                                          \tag{L18}
\]
The rounding in (L17) obeys \(D\le C_\beta\log(e+u)\) for a constant depending only on \(\beta\). Combining (L9) and (L18) gives
\[
R^{\mathrm{dec}}_{Q,n}(\beta,L)
\ge c_\beta\max\left\{n^{-\beta},\
[n\log(e+Qn^{-\beta/2})]^{-\beta/2}\right\}.                 \tag{L19}
\]

The independent parametric lower bound \(R^{\mathrm{dec}}_{Q,n}\ge cQ^{-1/2}\) is already in Zhang--Amini Proposition 4.3. It also follows directly from endpoint distributions with masses \((1\pm\eta)/2\), where \(\eta=(4\sqrt Q)^{-1}\); their one-count Hellinger distance squared is at most \(2\eta^2\), while their targets are \(\pm\eta\). These measures belong to every \(\mathcal G_{\beta,L}\). Combining this bound with (L19) proves (L1), since \(u\le Q\).

To check the equivalence asserted in (L2), if \(Q\le n^\beta\), then
\([n\log(e+u)]^{-\beta/2}\le n^{-\beta/2}\le Q^{-1/2}\).
If \(Q>n^\beta\), then \(u>\sqrt Q\) and
\(\log(e+u)\ge\tfrac12\log(e+Q)\).
Thus adding the root-\(Q\) term makes the two displayed profiles equivalent within a factor depending only on \(\beta\). This equivalence is algebra, not an upper risk bound.

## 7. A concrete failure of an unjustified amplitude shortcut

Consider the simpler pair
\[
G_\pm=(1-\rho)H_0+\rho\delta_{\pm h},\qquad
\rho=h^\beta,\quad 0<h\le1/2,
\]
which also belongs to \(\mathcal G_{\beta,1}\). At \(n=3\), counts one and two receive no contribution from \(H_0\). Their combined Hellinger contribution is exactly
\[
\frac{3\rho}{2}(1-h^2)\big(1-\sqrt{1-h^2}\big)
\ge\frac9{16}\rho h^2.                                   \tag{L20}
\]
Joint convexity and the binomial affinity give the upper bound
\[
H^2(K_3G_+,K_3G_-)
\le2\rho\big[1-(1-h^2)^{3/2}\big]\le3\rho h^2.             \tag{L21}
\]
Thus the squared output Hellinger distance is of order \(h^{\beta+2}\), not \(h^{2\beta+2}\). An arbitrary claim that local perturbation mass contributes its **square** to Hellinger distance is false when the only common background is at the endpoints. Formula (L13) is the explicit feasible denominator that avoids this error in Proposition L2.

This example diagnoses a proof mechanism. It is not a counterexample to Conjecture 6.4: the conjecture concerns the supremum over all admissible pairs and the minimax risk, whereas (L20) concerns one small pair.

## 8. First-transition interpretation and what remains unresolved

Theorem L1 extends a useful middle-regime lower-bound scale to all \(\beta>0\) and all sample sizes. It does not force the conjectured \(\kappa_{d,n}/\sqrt Q\) tradeoff.
For instance, along \(Q=n^\beta(\log n)^a\), \(a>0\), the bound (L1) has scale
\[
n^{-\beta/2}(\log n)^{-\min\{a,\beta\}/2}.
\]
The original spectral formula has a different possible first-transition scale involving \(\log\log n\), because \(\log\kappa_{d,n}=\Theta(d^2/n)\) for \(d\ll n\). A smaller lower bound does not disprove that formula.

The smallest substantive next step is an upper construction with variance controlled under the **actual margin class**, including its atomic members. A localized inverse estimator might concentrate its unstable coefficients near the decision boundary, but no such bound is asserted here. Conversely, proving the original formula's lower side would require a stronger hard pair than Proposition L2 near the first transition. Numerical optimization of finite pairs may inform either direction but cannot settle the full quantifiers.

## 9. Exact finite certificates and limitations

`code/lower_initial.py` uses Python's standard-library `Fraction` throughout. It constructs a separate explicit finite-support family from odd-order finite differences, adjusts the common mixture mass to satisfy the margin inequalities exactly, and checks:

1. positivity, total mass, reflection, and every binding margin inequality;
2. equality of moments through the chosen degree and opposite nonzero targets;
3. the exact quadratic identity (L10);
4. a rational triangular-discrimination upper bound on squared Hellinger distance;
5. a concrete integer \(Q\) satisfying \(QH^2\le1/4\), hence the finite testing lower bound;
6. the rare-atom obstruction (L20) through a rational lower bound.

These discrete witnesses are not represented as exact realizations of the weighted-dual profile \(g_d\), and their finite target separations do not prove (L3). The all-parameter theorem is established by Sections 2--6, with the stated prior approximation input. The exact checks verify explicit finite examples and the algebraic channel identity; no floating-point output is described as a mathematical certificate.

## Sources

- Z. Zhang and A. A. Amini, *Two Sample Sizes in Test-Time LLM Ensembling: Buffered ERM and Minimax Theory*, arXiv:2610.21363v1. Sections 3--4; Appendix E, Lemmas E.3--E.4; Section 6.3. Primary source: <https://arxiv.org/abs/2610.21363v1>.
- K. A. Kopotun, *Polynomial approximation with doubling weights having finitely many zeros and singularities*, Journal of Approximation Theory 198 (2015), 24--62, DOI: 10.1016/j.jat.2015.05.003. The weighted inverse theorem is used via the detailed specialization in Zhang--Amini Lemma E.3; this checkpoint does not independently re-prove the external theorem.

