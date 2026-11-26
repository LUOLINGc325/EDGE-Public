# A predictive floor for hierarchical Poisson mixtures with growing support

## Abstract

We study the hierarchical Bayes estimator induced by a finite Poisson mixture with independent uniform locations on an interval and uniform Dirichlet weights. We prove a deterministic posterior predictive lower bound on a typical observation set. The argument combines a simplex divergence identity, a separated approximation of the observation kernel, and an induction on the number of observations. For a support bound $A\geq\log n$, an explicit choice of $k=O(\sqrt A\log(e(n+\sqrt A)))$ components gives a predictive probability of at least $\exp[-300\log(e(n+\lceil\sqrt A\rceil))]$, except on an event of probability at most $1/(n\sqrt A)$. We also prove support-uniform entropy and prior-thickness bounds and derive an average empirical Bayes regret bound of $C A^{3/2}\log^6(e(n+\lceil\sqrt A\rceil))/n$ for the original, unregularized hierarchical Bayes rule. For $A=O(n^2)$ this establishes the large-support condition posed in Cannella, Teh, Han and Polyanskiy [1, Section 3.2]. The external posterior-contraction theorem and Poisson finite-difference inequalities are explicitly identified; a bounded-support comparison then gives the risk bound with universal constants. Constants are deliberately conservative. This research manuscript has not undergone external peer review or kernel formalization.

# 1. Problem, contribution, and attribution

The statistical question is whether one fixed, easily specified distribution over finite priors can adapt to every true mixing distribution on a growing interval. A favorable average likelihood or a density-estimation guarantee alone does not control a posterior-mean formula with a small predictive denominator. We establish that missing denominator control for the original finite prior, then close the risk argument with constants uniform in the support bound.

The precise target appears in [1, Section 3.2], for the finite prior described below, $A\gg\log n$, and $A=O(n^2)$. The authors explicitly leave the high-probability predictive condition open. Our parameter range includes the boundary $A=\log n$. Our conclusion concerns the ideal hierarchical Bayes rule. It makes no assertion about optimization of a transformer, a finite pretraining sample, or efficient evaluation of the posterior.

The main contribution is the evidence comparison in Lemma 3.2 and its predictive consequence, Theorem 3.3. A local analytic approximation supplies the required rank for Poisson kernels. The same square-interval partition also supports the moment approximation needed for posterior contraction, using a separate Hilbert-space estimate. The final risk consequence combines existing Poisson finite-difference estimates with an explicit bounded-support comparison, with all hypotheses verified for the same prior.

Several ingredients have established precedents. Empty-component and marginal-likelihood relations for finite mixtures appear in Nobile [3]; the boundary contribution of Lemma 3.1 is not claimed as a new identity. Finite-support approximation by moment matching, simplex volume calculations, and Cauchy's coefficient estimate are standard tools. The PoP framework and the contraction lemma used here come from [1]. The analytic score and finite-difference estimates come from Shen and Wu [2]; the risk proof below combines them with projection and a direct bounded-support Poisson tail bound. The known minimax scale is a comparison point, not a new lower-bound result in this manuscript. Section 8 records the limitations of the literature search.

# 2. Model and main results

Throughout, logarithms are natural. Write $\mathbb N_0=\{0,1,\ldots\}$ and

$$
p_\lambda(x)=e^{-\lambda}\frac{\lambda^x}{x!},\qquad
f_G(x)=\int_{[0,A]}p_\lambda(x)\,G(d\lambda).
$$

At $\lambda=0$ we use $p_0(0)=1$ and $p_0(x)=0$ for $x>0$. The true distribution $G_0$ is any Borel probability measure on $[0,A]$. Under the true experiment, $\theta_i$ are independent with law $G_0$, and conditionally $X_i\sim\operatorname{Poi}(\theta_i)$ independently. In particular, $X_1,\ldots,X_n$ are independent with mass function $f_{G_0}$.

For a deterministic integer $k$, the fitted prior is exactly

$$
\Lambda_1,\ldots,\Lambda_k\overset{\mathrm{iid}}\sim\operatorname{Unif}[0,A],
\qquad W\sim\operatorname{Dir}_k(1,\ldots,1),
\qquad G=\sum_{j=1}^kW_j\delta_{\Lambda_j},
$$

with locations and weights independent. Denote its law by $\Pi_k$. It is not modified during conditioning. Define the evidence and prediction by

$$
Z_{k,m}(x^m)=\mathbb E_{\Pi_k}\prod_{i=1}^m f_G(x_i),\qquad
Q_{k,m}(x\mid x^m)=\frac{Z_{k,m+1}(x^m,x)}{Z_{k,m}(x^m)},
\qquad Z_{k,0}=1.
$$

For this Poisson prior the evidence is positive for every finite sequence: all locations are strictly positive almost surely, so every mixture mass is positive. The generic theorem below proves the positivity it needs without this special property.

Let $\widehat\theta_i^{\mathrm{HB}}=\mathbb E_{\Pi_k}[\theta_i\mid X^n]$, where this expectation uses the fitted hierarchical model. Let $\theta_{G_0}(x)$ denote the true oracle posterior mean, with any value in $[0,A]$ at null observations. We measure average regret by

$$
\mathcal R_n(G_0)=\frac1n\mathbb E_{G_0}
\sum_{i=1}^n(\widehat\theta_i^{\mathrm{HB}}-\theta_{G_0}(X_i))^2.
$$

Orthogonality of conditional expectation identifies this expression with excess mean squared error over the oracle. Both the true oracle and the fitted posterior mean belong to $[0,A]$.

For $n\geq3$ and $A\geq\log n$, set

$$
J=\lceil\sqrt A\rceil,\quad H=n+J,\quad \ell=\log(eH),\quad
L=\lceil1024\ell\rceil,\quad D=JL,\quad k=2(D+1),
$$

and

$$
M=\left\lceil A+4\sqrt{A\ell}+8\ell\right\rceil,
\qquad S=\{0,\ldots,M\}.
$$

**Theorem A (predictive floor).** For every $0\leq m\leq n$, every $x^m\in S^m$, and every $x\in S$,

$$
Q_{k,m}(x\mid x^m)\geq e^{-300\ell}.
$$

Uniformly over $G_0\in\mathcal P([0,A])$,

$$
\mathbb P_{G_0}\{-\log Q_{k,n-1}(X_n\mid X^{n-1})>300\ell\}
\leq ne^{-4\ell}\leq\frac1{n\sqrt A}.
$$

**Theorem B (support-uniform density learning).** With squared Hellinger distance
$h^2(f,g)=\sum_x(\sqrt{f(x)}-\sqrt{g(x)})^2$, there is an absolute constant $C$ such that

$$
\sup_{G_0\in\mathcal P([0,A])}
\mathbb E_{G_0}h^2\bigl(f_{G_0},Q_{k,n-1}(\cdot\mid X^{n-1})\bigr)
\leq C\min\left\{1,\frac{k\ell}{n}\right\}.
$$

In particular this is at most $C\sqrt A\ell^2/n$.

**Theorem C (risk of the original rule).** There is an absolute constant $C$ such that

$$
\sup_{G_0\in\mathcal P([0,A])}\mathcal R_n(G_0)
\leq C\frac{A^{3/2}\ell^6}{n}.
$$

For every fixed $C_A>0$, restriction to $\log n\leq A\leq C_A n^2$ gives
$k=\Theta_{C_A}(\sqrt A\log(en))$, a predictive surprisal bound $O_{C_A}(\log(en))$, and regret at most $C_{C_A}A^{3/2}\log^6(en)/n$.

All three theorems use the same $k$ and the same prior. No additional component, data-dependent component count, denominator clipping, or randomized model size enters the estimator. Constants do not depend on $G_0$, $n$, or $A$; only the final rewriting in terms of $\log(en)$ permits dependence on $C_A$.

# 3. A general predictive-floor theorem

Let $H_0$ be a base probability measure on a measurable parameter space $\Theta$, and let $p_\vartheta(x)$ be measurable probability mass functions. For an integer $k\geq2$ independent locations with law $H_0$ and independent uniform Dirichlet weights, use the preceding definitions of $Z_{k,m}$ and $Q_{k,m}$. Fix a nonempty finite set $S$ and put

$$
b(x)=\mathbb E_{H_0}p_\vartheta(x),\qquad b_* =\min_{x\in S}b(x)>0.
$$

All kernels are bounded by one, so the integrations below are finite. For $k=1$, the Dirichlet law means unit mass at its sole weight.

## 3.1. A boundary contribution

**Lemma 3.1 (unused-component contribution).** If $k\geq2$ and $Z_{k,m}(x^m)>0$, then

$$
Q_{k,m}(x\mid x^m)\geq
\frac{k(k-1)}{(m+k)(m+k-1)}
\frac{Z_{k-1,m}(x^m)}{Z_{k,m}(x^m)}b(x).
$$

*Proof.* Expand the future factor $\sum_jW_jp_{\vartheta_j}(x)$. In its $j$th summand, write $w=W_j$, and normalize the remaining weights to obtain a mixture $q_{-j}$. Positivity gives

$$
\prod_{i=1}^m f_G(x_i)\geq (1-w)^m\prod_{i=1}^m q_{-j}(x_i).
$$

The uniform Dirichlet law has $w\sim\operatorname{Beta}(1,k-1)$, independent of the normalized remaining weights, which have law $\operatorname{Dir}_{k-1}(1)$. The removed location is also independent. The expectation of the lower bound multiplied by $w p_{\vartheta_j}(x)$ is

$$
b(x)Z_{k-1,m}(x^m)\mathbb E[w(1-w)^m]
=b(x)Z_{k-1,m}(x^m)\frac{k-1}{(m+k)(m+k-1)}.
$$

Summing the $k$ future summands and dividing by the evidence proves the claim. These are distinct terms in a sum, not probabilities of disjoint empty-component events. $\square$

The analytic comparison with $k-1$ components does not replace the actual $k$-component prior.

## 3.2. A simplex divergence comparison

**Lemma 3.2 (approximate rank and evidence).** Suppose $d\geq0$ is an integer and measurable real functions $a_s(\vartheta),c_s(x)$, $1\leq s\leq d$, satisfy

$$
\sup_{\vartheta\in\Theta,\ x\in S}
\left|p_\vartheta(x)-\sum_{s=1}^d a_s(\vartheta)c_s(x)\right|\leq\varepsilon.
$$

The approximation may take negative values. If $d_0=k-d-1>0$, then, for every $x^m\in S^m$,

$$
d_0 Z_{k,m}(x^m)\leq k(k-1)Z_{k-1,m}(x^m)
+\varepsilon\sqrt k\sum_{i=1}^m Z_{k,m-1}(x_{-i}).
$$

*Proof.* Fix the locations first. Let the $i$th rows of $F$ and $\widetilde F$ be the actual and approximated likelihood vectors at $x_i$. Let $P$ be the orthogonal projector onto the common nullspace of $\widetilde F$ and the constant row $\mathbf1^\mathsf T$. Its rank $r$ is at least $d_0$. It is constant as a function of the weights. A Moore--Penrose formula makes $P$ measurable in the locations even where ranks change.

On the affine simplex $\Delta=\{w\in\mathbb R^k:w_j\geq0,\ \sum_jw_j=1\}$, set
$v(w)=Pw$ and $\mathcal L(w)=\prod_i(F_i\cdot w)$. Since $P\mathbf1=0$, the field is tangent to the affine span and its intrinsic divergence is $\operatorname{tr}P=r$. Moreover $\widetilde Fv=0$ and

$$
|v\cdot\nabla\mathcal L|
\leq\varepsilon\|v\|_1\sum_{i=1}^m\prod_{s\ne i}(F_s\cdot w)
\leq\varepsilon\sqrt k\sum_{i=1}^m\prod_{s\ne i}(F_s\cdot w).
$$

Here $\|Pw\|_1\leq\sqrt k\|Pw\|_2\leq\sqrt k\|w\|_2\leq\sqrt k$. No division by a likelihood factor occurs, including on faces where a factor vanishes.

On the face $w_j=0$, the outward normal in the affine span is

$$
\nu_j=-\sqrt{\frac{k}{k-1}}\left(e_j-\frac1k\mathbf1\right).
$$

The ratio of the Euclidean volume of this face to that of $\Delta$ is
$(k-1)\sqrt{(k-1)/k}$. Normalize the volume measure on each simplex. The divergence theorem therefore gives the exact identity

$$
r\mathbb E_\Delta\mathcal L+\mathbb E_\Delta[v\cdot\nabla\mathcal L]
=-(k-1)\sum_{j=1}^k\mathbb E_{\mathrm{face}\ j}[v_j\mathcal L].
$$

For completeness, the volume of the standard simplex with $k$ vertices is
$\sqrt k/(k-1)!$; that of a face is $\sqrt{k-1}/(k-2)!$, giving the stated ratio. The formula also holds when $k=2$, with counting volume on its endpoint faces. The vector field is linear and the likelihood polynomial, so the boundary version of the divergence theorem applies directly.

Use $|v_j|\leq1$ while the locations remain fixed. The right side is at most $(k-1)\sum_j\mathbb E_{\mathrm{face}\ j}\mathcal L$. Only now integrate over locations. The likelihood on face $j$ no longer uses the $j$th location, and each face expectation becomes $Z_{k-1,m}$. This order is essential: $P$ itself may depend on the removed location. The omitted products give the $Z_{k,m-1}$ terms, and $r\geq d_0$ yields the inequality. $\square$

## 3.3. Induction with a fixed floor

**Theorem 3.3 (deterministic predictive floor).** Under Lemma 3.2, let $N\geq1$ and

$$
\eta=\frac{d_0 b_*}{2(N+k)^2}.
$$

If $\varepsilon\leq d_0\eta/(2N\sqrt k)$, then every sequence in $S^m$, $0\leq m\leq N$, has positive evidence and

$$
Q_{k,m}(x\mid x^m)\geq\eta\quad(x\in S),\qquad
\frac{Z_{k,m}(x^m)}{Z_{k-1,m}(x^m)}\leq\frac{2k(k-1)}{d_0}.
$$

*Proof.* For $m=0$, both evidences equal one and $Q_{k,0}=b\geq\eta$. Suppose the prediction bound holds for sequences of length $m-1$. Multiplying any such positive evidence by its positive one-step prediction first gives $Z_{k,m}>0$. Symmetry then implies

$$
\frac{Z_{k,m-1}(x_{-i})}{Z_{k,m}(x^m)}
=\frac1{Q_{k,m-1}(x_i\mid x_{-i})}\leq\frac1\eta.
$$

By Lemma 3.2,

$$
d_0Z_{k,m}\leq k(k-1)Z_{k-1,m}
+\frac{\varepsilon\sqrt k\,m}{\eta}Z_{k,m}
\leq k(k-1)Z_{k-1,m}+\frac{d_0}{2}Z_{k,m}.
$$

This proves positivity of $Z_{k-1,m}$ and the evidence-ratio bound. Lemma 3.1 now gives

$$
Q_{k,m}(x\mid x^m)\geq
\frac{d_0b(x)}{2(m+k)(m+k-1)}\geq\eta.
$$

The induction uses only the length $m-1$ bound to prove the length $m$ bound. It retains the same $\eta$ and the same $k$ throughout. $\square$

# 4. Poisson approximation and explicit parameters

## 4.1. Local analytic approximation

**Lemma 4.1 (Poisson separated approximation).** On $[0,A]\times\mathbb N_0$ there is a separated approximation with $D=JL$ real features and uniform absolute error

$$
\varepsilon_L=2e^2 2^{-L}.
$$

*Proof.* Partition $[0,A]$ into the $J$ intervals $[j^2,(j+1)^2]\cap[0,A]$, for $0\leq j \lt J$, using a half-open convention at shared endpoints. Keep the untruncated centers and radii

$$
a_j=j^2+j+\tfrac12,\qquad h_j=j+\tfrac12,\qquad R_j=2h_j.
$$

For $x\in\mathbb N_0$, the entire function $p_x(z)=e^{-z}z^x/x!$ satisfies

$$
2a(|z|-\operatorname{Re}z)=|z-a|^2-(|z|-a)^2\leq|z-a|^2.
$$

Thus, on $|z-a_j|\leq R_j$,

$$
|p_x(z)|=e^{|z|-\operatorname{Re}z}p_x(|z|)
\leq \exp\!\left(\frac{R_j^2}{2a_j}\right)\leq e^2,
$$

uniformly in $x$, since $p_x(t)\leq1$ for $t\geq0$ and
$R_j^2/(2a_j)=(4j^2+4j+1)/(2j^2+2j+1)<2$. Cauchy's estimate bounds the Taylor coefficient of degree $s$ at $a_j$ by $e^2R_j^{-s}$. Real points in the interval obey $|\lambda-a_j|\leq R_j/2$, even in the last truncated interval. The remainder after degrees $0,\ldots,L-1$ is at most
$e^2\sum_{s=L}^\infty2^{-s}=2e^2 2^{-L}$.

The separated features are $\mathbf1_{I_j}(\lambda)(\lambda-a_j)^s$ and
$p_x^{(s)}(a_j)/s!$. All coefficients are real and measurable. $\square$

## 4.2. Base mass and self-consistency

**Lemma 4.2 (base predictive mass).** With the parameters in Section 2,

$$
b_*:=\min_{0\leq x\leq M}\frac1A\int_0^A p_\lambda(x)\,d\lambda
\geq e^{-247\ell}.
$$

*Proof.* Integrating the Poisson kernel gives
$b_A(x)=A^{-1}\mathbb P\{\operatorname{Poi}(A)\geq x+1\}$, a decreasing function of $x$. Since $n\geq3$ and $A\geq\log n$, we have $A\geq1$, $n\leq e^A$, and $J\leq\sqrt A+1\leq A+1\leq e^A$. Consequently $\ell\leq A+1+\log2\leq3A$.

Put $r=M+1$ and $s=r-A$. The definition of $M$ implies

$$
0 \lt s\leq4\sqrt{A\ell}+8\ell+2\leq22\sqrt{A\ell},
\qquad r\leq40A.
$$

The elementary Poisson rate function satisfies

$$
\psi_A(A+s)=(A+s)\log(1+s/A)-s\leq\frac{s^2}{2A}\leq242\ell.
$$

For an integer $r\geq1$, monotonicity of $\log$ gives
$\log(r!)\leq\int_1^r\log t\,dt+\log r$, and hence
$r!\leq er(r/e)^r$. Therefore

$$
b_A(M)\geq\frac{\mathbb P\{\operatorname{Poi}(A)=r\}}A
\geq\frac{e^{-242\ell}}{eAr}
\geq\frac{e^{-242\ell}}{40eH^4}\geq e^{-247\ell}.
$$

The penultimate inequality uses $A\leq J^2\leq H^2$. For the last, $\log(40eH^4)=4\ell+\log40-3\leq5\ell$. $\square$

**Lemma 4.3 (explicit closure).** The parameters of Section 2 satisfy the hypotheses of Theorem 3.3 with $N=n$, $d=D$, and $\eta\geq e^{-270\ell}$.

*Proof.* We have $d_0=k-D-1=k/2$, $\varepsilon_L\leq e^{-707\ell}$,
$k\leq2052H\ell$, and $n+k\leq2053H^2$. Indeed $L\leq1025\ell$ and $\ell\leq H$. The definition of $\eta$ and Lemma 4.2 give

$$
\eta\geq\frac{e^{-247\ell}}{2\cdot2053^2H^4}\geq e^{-270\ell}.
$$

One may use $\log(2\cdot2053^2)+4\log H\leq20\ell$, leaving slack. Moreover

$$
\frac{d_0\eta}{2n\sqrt k}=\frac{\sqrt k\eta}{4n}
\geq\frac\eta{4H}\geq e^{-273\ell}\geq\varepsilon_L.
$$

This closes the required self-consistency inequality without an asymptotic qualification. $\square$

## 4.3. True-data probability

*Proof of Theorem A.* The deterministic assertion follows from Lemma 4.3 and Theorem 3.3, with a weaker but simpler exponent 300. For $u\geq0$, integrating $\psi_A''(A+s)=1/(A+s)$ gives
$\psi_A(A+u)\geq u^2/[2(A+u)]$. If $t>0$ and $u=2\sqrt{At}+2t$, then $u^2\geq2t(A+u)$. The Chernoff bound therefore gives

$$
\mathbb P\{\operatorname{Poi}(A)\geq A+2\sqrt{At}+2t\}\leq e^{-t}.
$$

Every observation from a mixture supported on $[0,A]$ is stochastically dominated by $\operatorname{Poi}(A)$. With $t=4\ell$ and a union bound,
$\mathbb P_{G_0}\{\max_iX_i>M\}\leq ne^{-4\ell}$. On the complement all training and test observations belong to $S$. Finally

$$
ne^{-4\ell}\,n\sqrt A
=e^{-4}\frac{n^2\sqrt A}{H^4}\leq\frac{e^{-4}}H\leq1.
$$

This proves the uniform probability bound. If $A\leq C_A n^2$, then
$H\leq(2+\sqrt{C_A})n$, giving the stated logarithmic and component-count orders. $\square$

# 5. Approximation, entropy, and prior thickness

We use $\operatorname{TV}(f,g)=\tfrac12\sum_x|f(x)-g(x)|$ and
$\chi^2(f\Vert g)=\sum_x f(x)^2/g(x)-1$, with the usual conventions at zero. In particular $h^2\leq2\operatorname{TV}$ and $h^2\leq2$. This section establishes the support-uniform ingredients rather than using a fixed-$A$ estimate with an unspecified constant.

## 5.1. Support-preserving moment approximation

**Lemma 5.1 (local projection).** For $a>0$, define
$\langle u,v\rangle_a=\sum_{x\geq0}u(x)v(x)/p_a(x)$. Define polynomials $C_j(x;a)$ by

$$
e^{-t}(1+t/a)^x=\sum_{j\geq0}C_j(x;a)\frac{t^j}{j!}.
$$

For an integer $r\geq1$, put

$$
T_{a,r}(\lambda)(x)=p_a(x)\sum_{j=0}^r C_j(x;a)\frac{(\lambda-a)^j}{j!}.
$$

Then for $\lambda\geq0$,

$$
\|p_\lambda-T_{a,r}(\lambda)\|_a^2
=\sum_{j>r}\frac{((\lambda-a)^2/a)^j}{j!}.
$$

If $|\lambda-a|\leq\sqrt a$, this is at most $2/(r+1)!$.

*Proof.* Direct summation of the exponential series gives

$$
\langle p_\lambda,p_\mu\rangle_a
=\exp\!\left(\frac{(\lambda-a)(\mu-a)}a\right).
$$

For $X\sim\operatorname{Poi}(a)$, the expectation of the product of the generating functions at $t,u$ is $e^{tu/a}$. Coefficient comparison near zero, justified by absolute convergence, yields

$$
\mathbb E[C_i(X;a)C_j(X;a)]=\mathbf1_{i=j}\,j!a^{-j},\qquad
\langle p_\lambda,p_aC_j(\cdot;a)\rangle_a=(\lambda-a)^ja^{-j}.
$$

Expanding the squared norm of the finite sum $T_{a,r}$ now gives
$e^{(\lambda-a)^2/a}-\sum_{j=0}^r((\lambda-a)^2/a)^j/j!$.
This argument does not assume convergence of an infinite orthogonal expansion. When $(\lambda-a)^2/a\leq1$, the exponential tail is bounded by $\sum_{j>r}1/j!\leq2/(r+1)!$. Finally, Cauchy--Schwarz gives $\|u\|_1\leq\|u\|_a$. The formulas include $\lambda=0$. $\square$

**Lemma 5.2 (finite support approximation).** For $0<\delta<1$, define

$$
r(\delta)=\left\lceil2\log_2(4/\delta)\right\rceil.
$$

Every $G_0\in\mathcal P([0,A])$ has an approximating measure $G_*$ on the same interval with

$$
|\operatorname{supp}G_*|\leq J(r(\delta)+1),\qquad
\operatorname{TV}(f_{G_0},f_{G_*})\leq\delta.
$$

*Proof.* Use the square intervals and centers from Section 4. On interval $j$,
$|\lambda-a_j|\leq h_j$ and $h_j^2=a_j-1/4 \lt a_j$. Conditional on each interval of positive $G_0$ mass, match the first $r=r(\delta)$ moments by a probability measure with at most $r+1$ atoms. The finite-dimensional convex-hull theorem applies to the moment curve on the closure of that interval intersected with $[0,A]$, which is compact. The matched atoms therefore remain in $[0,A]$, including for the last truncated interval. Moving an endpoint between the two partition cells has no effect on this assertion.

The local integrals of $T_{a_j,r}(\lambda)$ agree because each coefficient is a polynomial in $\lambda$ of degree at most $r$. Lemma 5.1, the triangle inequality, and $\|u\|_1\leq\|u\|_{a_j}$ give a local total variation error at most $\sqrt{2/(r+1)!}$. Average with the original interval masses. Since $(r+1)!\geq2^r$ and $2^{-r/2}\leq\delta/4$, the resulting error is at most $\delta$. For $\delta=n^{-2}$,
$r(\delta)+1\leq6+(4/\log2)\log n\leq6\ell$, so the atom count is at most $6J\ell \lt k$. $\square$

## 5.2. Entropy with no hidden support constant

Let $\mathcal P_A=\{f_G:G\in\mathcal P([0,A])\}$, and let $N(\varepsilon,\mathcal P_A,h)$ denote its covering number in Hellinger distance.

**Lemma 5.3 (covering bound).** For $0<\varepsilon\leq1$, set $\gamma=\varepsilon^2/16$ and $m=J(r(\gamma)+1)$. Then

$$
\log N(\varepsilon,\mathcal P_A,h)
\leq m\left[\log(A/\gamma+2)+
\log(\lceil2m/\gamma\rceil+1)\right].
$$

In particular, if $n^{-1/2}\leq\varepsilon\leq1/2$, then

$$
\log N(\varepsilon/2,\mathcal P_A,h)\leq280J\ell^2.
$$

*Proof.* Apply Lemma 5.2 at accuracy $\gamma$, padding by zero weights to $m$ atoms if necessary. Round locations to a grid in $[0,A]$ of spacing at most $\gamma$, with at most $A/\gamma+2$ points. Coupling Poisson variables by an independent increment proves

$$
\operatorname{TV}(p_\lambda,p_\mu)
\leq1-e^{-|\lambda-\mu|}\leq|\lambda-\mu|.
$$

Thus location rounding costs at most $\gamma$. Set $Q=\lceil2m/\gamma\rceil$, round the first $m-1$ weights down to multiples of $1/Q$, and assign the remainder to the last weight. The $\ell_1$ weight error is at most $2(m-1)/Q\leq\gamma$, and the mixture TV error is at most $\gamma/2$. There are at most $(Q+1)^m$ resulting weight vectors. The combined TV error is at most $5\gamma/2$, giving Hellinger error less than $\varepsilon$ and the counting formula.

For the last assertion, replace $\varepsilon$ by $\varepsilon/2$ in this construction. Now $\gamma\geq1/(64n)$, so $m\leq20J\ell$. Using $A\leq J^2$, $n,J\leq H$, and $\ell\leq H$, the location-grid logarithm is at most $6\ell$ and the weight-grid logarithm at most $8\ell$. Their sum gives $280J\ell^2$. $\square$

Define the local covering number by

$$
N_{\mathrm{loc}}(\varepsilon)
=\sup_{f_0\in\mathcal P_A}\sup_{s\geq\varepsilon}
N(s,\mathcal P_A\cap B_h(f_0,2s),h).
$$

A global $\varepsilon/2$ net implies
$N_{\mathrm{loc}}(\varepsilon)\leq N(\varepsilon/2,\mathcal P_A,h)$: in each global ball intersecting the subset, choose a representative in the subset; the representatives cover it at radius $\varepsilon\leq s$. This handles the convention that covering centers must belong to the covered set.

## 5.3. Thickness of the actual prior

**Lemma 5.4 (uniform-location Dirichlet thickness).** Let $G_*$ have at most $m\leq k$ atoms in $[0,A]$, where $A\geq1$, and let $0 \lt r\leq1$. Then

$$
\Pi_k\{G:\chi^2(f_{G_*}\Vert f_G)\leq r^2\}
\geq\left(\frac{r^2}{64A}\right)^m
\left(\frac{r^2}{8}\right)^{k-1}.
$$

*Proof.* Write $G_*=\sum_{j=1}^m w_j^*\delta_{\lambda_j^*}$ and pad its weight vector to length $k$ with zeros. Put $\tau=r^2/64$ and $u=r^2/8$. For each target location choose an interval of length $\tau$ in $[0,A]$ such that every point $\mu$ in the interval satisfies $\mu\geq\tau$ and $|\mu-\lambda_j^*|\leq2\tau$. Use $[\tau,2\tau]$ when $\lambda_j^*\leq\tau$, $[\lambda_j^*,\lambda_j^*+\tau]$ for $\tau<\lambda_j^* \lt A-\tau$, and $[A-\tau,A]$ otherwise. The assumptions make all intervals valid.

The exact component identity is

$$
1+\chi^2(p_\lambda\Vert p_\mu)
=\exp\left(\frac{(\lambda-\mu)^2}{\mu}\right),\qquad\mu>0,
$$

obtained by summing the exponential series. It is at most $e^{4\tau}$ on these location events, including at the target $\lambda=0$.

The affine simplex $(1-u)w^*+u\Delta_k$ has probability $u^{k-1}$ under the uniform Dirichlet law. Every weight vector there satisfies $W_j\geq(1-u)w_j^*$. Weighted Cauchy--Schwarz therefore gives

$$
1+\chi^2(f_{G_*}\Vert f_G)
\leq\frac1{1-u}\sum_{j=1}^m w_j^*
\sum_x\frac{p_{\lambda_j^*}(x)^2}{p_{\Lambda_j}(x)}
\leq\frac{e^{r^2/16}}{1-r^2/8}.
$$

For $0\leq v\leq1$, $e^{v/16}\leq1+v/8$, so the last expression minus one is at most $2v/7\leq v$ with $v=r^2$. The first $m$ independent location events have probability $(\tau/A)^m$; the other locations are unrestricted. Independence of weights and locations proves the result. $\square$

In the thickness terminology of [1], for each $G_0$ one first selects $G_*$ with $\operatorname{TV}(f_{G_0},f_{G_*})\leq\delta$ and then bounds the prior mass of its chi-square neighborhood. Lemmas 5.2 and 5.4 yield, whenever $J(r(\delta)+1)\leq k$,

$$
E(\delta,r)\leq2k\log(64A/r^2),\qquad 0 \lt r\leq1.
$$

Neither small target weights nor an atom at either endpoint require an additional assumption. Only the sampled locations are restricted inside the small-ball event; the target measure and the original prior remain unchanged.

# 6. Posterior-predictive contraction

The one external posterior result needed is [1, Lemma 2.4], for a general density class. It states, with universal constants $c_1,C_1>0$, that

$$
\log N_{\mathrm{loc}}(\varepsilon_n)\leq n\varepsilon_n^2,
\qquad E(n^{-2},r_n)\leq nr_n^2
$$

imply, for $t\geq\varepsilon_n^2+r_n^2+1/n$,

$$
\mathbb P_{f_0^{\otimes(n-1)}}
\{h^2(f_0,Q_{k,n-1})>C_1t\}\leq n^{-1}+e^{-c_1nt}.
$$

This is an explicitly cited external theorem, not a new result or an assumed conclusion about our particular prior. We use its general form; the fixed-support Poisson regret theorem in [1] is not used to infer a growing-support bound.

*Proof of Theorem B.* Set $\beta=64k\ell/n$. If $\beta\geq1/4$, then $h^2\leq2\leq8\beta$ suffices. Otherwise choose $r_n^2=\varepsilon_n^2=\beta$. Then $n^{-1/2}\leq\varepsilon_n<1/2$. Lemma 5.3 and the local-net comparison give

$$
\log N_{\mathrm{loc}}(\varepsilon_n)\leq280J\ell^2\leq k\ell\leq n\beta.
$$

Lemma 5.2 at $\delta=n^{-2}$ uses fewer than $k$ atoms. Since $r_n^2\geq1/n$ and $A\leq H^2$,

$$
\log(64A/r_n^2)\leq\log64+\log A+\log n\leq4\ell.
$$

Here $\log64+3\log H=3\ell+\log64-3\leq4\ell$, as $H\geq5$. Hence $E(n^{-2},r_n)\leq8k\ell\leq n\beta$. Apply the displayed external theorem and integrate its tail up to $h^2\leq2$. The threshold contributes at most $C\beta+C/n$, the $n^{-1}$ term at most $2/n$, and the exponential tail at most $C/n$. Because $\beta\geq1/n$, we obtain $\mathbb Eh^2\leq Ck\ell/n$. Combining with the deterministic bound proves the minimum form. Finally, $J\leq2\sqrt A$ and $L\leq1025\ell$ imply $k\leq C\sqrt A\ell$. $\square$

# 7. The unregularized empirical Bayes risk

## 7.1. Leave-one-out representation

**Lemma 7.1 (posterior-mean identity).** Let $\overline G=\mathbb E_{\Pi_k}[G\mid X^{n-1}]$. Then $\overline G$ is supported on $[0,A]$,
$q:=Q_{k,n-1}=f_{\overline G}$, and

$$
\widehat\theta_n^{\mathrm{HB}}
=\theta_{\overline G}(X_n)
=(X_n+1)\frac{q(X_n+1)}{q(X_n)}\in[0,A].
$$

*Proof.* Conditioning on the training data, the latent test parameter has law $\overline G$. Fubini gives its observation mass $q=f_{\overline G}$. A further application of Bayes' rule gives

$$
\mathbb E_{\Pi_k}[\theta_n\mid X^{n-1},X_n=x]
=\frac{\int\lambda p_\lambda(x)\,\overline G(d\lambda)}{f_{\overline G}(x)}
=(x+1)\frac{q(x+1)}{q(x)}.
$$

All denominators are positive by the positivity noted in Section 2, and the conditional expectation is in $[0,A]$. Under the true experiment, $\theta_n$ conditional on $X^n$ has mean $\theta_{G_0}(X_n)$; the training observations are independent of this latent-test pair. Expanding a squared loss around that conditional mean proves the regret identity in Section 2. Exchangeability then identifies average vector regret with the one-coordinate quantity. $\square$

## 7.2. A bounded-support risk inequality

For a probability measure $D$ on $[0,A]$ and $\rho>0$, define the comparison rules

$$
\theta_D(y;\rho)=(y+1)
\left(1+\frac{\Delta f_D(y)}{f_D(y)\vee\rho}\right),
\qquad
\psi_D(y;\rho)=\operatorname{proj}_{[0,A]}\theta_D(y;\rho),
$$

where $\Delta f(y)=f(y+1)-f(y)$ and
$\operatorname{proj}_{[0,A]}z=\min\{A,\max\{0,z\}\}$.
These rules are introduced only inside the proof. The estimator in Theorem C remains the original hierarchical posterior mean.

We use two analytic results from [2, arXiv v2]. Lemma 13, equation (6.12), supplies a universal constant $C_1$ such that, for any Poisson mixture $f_D$, any $0 \lt r\leq e^{-1}$, and any $y\geq0$,

$$
\frac{|\Delta f_D(y)|}{f_D(y)\vee r}
\leq\frac{C_1\log(1/r)}{\sqrt{y+1}}.
\tag{7.1}
$$

For two mixtures $f=f_G$ and $g=f_D$, define the squared weighted difference quantity from [2, equations (6.5)–(6.6)] by

$$
\mathcal A_1^2(f,g;\rho)
=\sum_{y\geq0}
\frac{(y+1)\{\Delta f(y)-\Delta g(y)\}^2}
{(f(y)\vee\rho)+(g(y)\vee\rho)}.
$$

Proposition 14 of that version states, uniformly over the two mixing distributions and $0<\rho\leq e^{-1}$,

$$
\mathcal A_1^2(f,g;\rho)
\leq C_2\left[\log^4(1/\rho)h^2(f,g)+\rho^{10}\right],
\tag{7.2}
$$

with a universal $C_2$. Neither result has a moment-order parameter. The following specialization derives the risk bound needed here directly from (7.1)–(7.2).

**Lemma 7.2 (bounded-support comparison).** Let $G,D$ be probability measures on $[0,A]$. Let $0<\rho\leq e^{-2}$, $B=\log(1/\rho)$, and let $T\geq\max\{1,2A\}$ be an integer. Set $c_* =\log2-1/2>0$. There is a universal constant $C$ such that

$$
\begin{aligned}
\mathbb E_{Y\sim f_G}
\{\psi_D(Y;\rho)-\theta_G(Y)\}^2
\leq C\bigl[&(T+1)B^4h^2(f_G,f_D)
+(T+1)\rho^{10}\\
&+(T+1)^2\rho B^2\bigr]
+A^2e^{-c_*T}.
\end{aligned}
\tag{7.3}
$$

At any point with $f_G(y)=0$, the oracle is assigned an arbitrary value in $[0,A]$; that point contributes zero to the expectation.

*Proof.* Write $f=f_G$ and $g=f_D$. Since $\theta_G(y)\in[0,A]$, projection cannot increase the distance to the oracle. On the finite range $0\leq y\leq T$, the squared triangle inequality therefore gives a contribution at most $2U+2V$, where

$$
U=\sum_{y=0}^{T}f(y)
\{\theta_D(y;\rho)-\theta_G(y;\rho)\}^2,
\qquad
V=\sum_{y=0}^{T}f(y)
\{\theta_G(y;\rho)-\theta_G(y)\}^2.
$$

For each $y$, put

$$
a=f(y)\vee\rho,\quad b=g(y)\vee\rho,\quad s=a+b,
\qquad u=\frac{\Delta f(y)}a,\quad v=\frac{\Delta g(y)}b.
$$

The exact identity

$$
v-u=\frac{2\{\Delta g(y)-\Delta f(y)\}}s
+\frac{a-b}s(u+v)
\tag{7.4}
$$

separates the change of the numerator from that of the denominator. From (7.1),
$|u|+|v|\leq2C_1B/\sqrt{y+1}$. Using $f(y)\leq s$ and $y+1\leq T+1$ in the two squared terms in (7.4), we obtain

$$
\begin{aligned}
U
&\leq8\sum_{y=0}^{T}
\frac{f(y)(y+1)^2\{\Delta g(y)-\Delta f(y)\}^2}{s^2}
+8C_1^2B^2\sum_{y=0}^{T}
\frac{f(y)(y+1)(a-b)^2}{s^2}\\
&\leq8(T+1)\mathcal A_1^2(f,g;\rho)
+8C_1^2B^2(T+1)\sum_{y=0}^{T}\frac{(a-b)^2}{s}\\
&\leq8(T+1)\mathcal A_1^2(f,g;\rho)
+16C_1^2B^2(T+1)h^2(f,g).
\end{aligned}
\tag{7.5}
$$

The last step follows pointwise from

$$
\frac{(a-b)^2}{a+b}
\leq\frac{(f(y)-g(y))^2}{f(y)+g(y)}
\leq2\{\sqrt{f(y)}-\sqrt{g(y)}\}^2,
$$

with the middle expression defined to be zero when both masses vanish: the map $x\mapsto x\vee\rho$ is $1$-Lipschitz, its application increases the denominator, and $(\sqrt f+\sqrt g)^2\leq2(f+g)$. Since $B\geq2$, (7.2) and (7.5) imply

$$
U\leq C(T+1)\{B^4h^2(f,g)+\rho^{10}\}.
\tag{7.6}
$$

For $V$, the summand is zero when $f(y)\geq\rho$. When $0 \lt f(y)<\rho$,

$$
\theta_G(y;\rho)-\theta_G(y)
=(y+1)\frac{\Delta f(y)}{f(y)}
\left(\frac{f(y)}\rho-1\right).
$$

Apply (7.1) with the temporary regularizer $r=f(y)$, which lies in $(0,e^{-2})$, to conclude

$$
V\leq C_1^2\sum_{\substack{0\leq y\leq T\\0 \lt f(y)<\rho}}
(y+1)f(y)\log^2(1/f(y)).
$$

The function $x\mapsto x\log^2(1/x)$ is increasing on $(0,e^{-2}]$ and has limit zero at zero. Consequently,

$$
V\leq C_1^2\rho B^2\sum_{y=0}^{T}(y+1)
\leq C_1^2(T+1)^2\rho B^2.
\tag{7.7}
$$

It remains to control $Y>T$. Both $\psi_D(Y;\rho)$ and the oracle belong to $[0,A]$, so the contribution is at most $A^2\mathbb P(Y>T)$. If $Y\mid\lambda\sim\operatorname{Poi}(\lambda)$ with $\lambda\leq A$, then

$$
\mathbb E 2^Y=\mathbb E e^{\lambda}\leq e^A.
$$

Markov's inequality and $T\geq2A$ give

$$
\mathbb P(Y>T)\leq e^{A-T\log2}
\leq e^{-(\log2-1/2)T}.
\tag{7.8}
$$

Adding (7.6), (7.7), and this tail bound proves (7.3). $\square$

## 7.3. Substitution and removal of the comparison regularization

*Proof of Theorem C.* Condition on the training sample and apply Lemma 7.2 with $G=G_0$ and $D=\overline G$, which is supported on $[0,A]$ by Lemma 7.1. Choose

$$
\rho=e^{-300\ell},\qquad B=300\ell,\qquad
T=\left\lceil\max\{2A,20\ell/c_*\}\right\rceil,
\qquad c_*=\log2-1/2.
\tag{7.9}
$$

Since $\ell\leq3A$ and $A\geq1$, we have $T+1\leq C A$ for an absolute constant, while $e^{-c_*T}\leq e^{-20\ell}$. Taking the training expectation in (7.3) and using Theorem B yields

$$
\begin{aligned}
\mathbb E\{\psi_{\overline G}(X_n;\rho)-\theta_{G_0}(X_n)\}^2
&\leq C A\ell^4\frac{k\ell}{n}
+C A e^{-3000\ell}
+C A^2\ell^2e^{-300\ell}
+A^2e^{-20\ell}\\
&\leq C\frac{A^{3/2}\ell^6}{n}.
\end{aligned}
\tag{7.10}
$$

For completeness, the first term uses $k\leq C\sqrt A\ell$. To bound the remaining terms, use $A\geq1$, $\ell\geq1$, $n\leq e^{\ell}$, and

$$
n\sqrt A\leq nJ\leq(n+J)^2\leq e^{2\ell}.
$$

Their ratios to $A^{3/2}\ell^6/n$ are at most constant multiples of
$e^{-2999\ell}$, $e^{-298\ell}/\ell^4$, and $e^{-18\ell}/\ell^6$, respectively. Thus (7.10) holds uniformly in the stated support regime, including $k\geq n$; the contraction bound in that regime is justified by $h^2\leq2$.

On $q(y)\geq\rho$, the comparison rule $\psi_{\overline G}(y;\rho)$ is exactly the original rule $\theta_{\overline G}(y)$, which already lies in $[0,A]$. On the complementary event, the original rule and the oracle remain in that interval. Therefore

$$
\begin{aligned}
\mathbb E\{\theta_{\overline G}(X_n)-\theta_{G_0}(X_n)\}^2
&\leq\mathbb E\{\psi_{\overline G}(X_n;\rho)-\theta_{G_0}(X_n)\}^2
+A^2\mathbb P\{q(X_n)<\rho\}\\
&\leq C\frac{A^{3/2}\ell^6}{n}+A^2ne^{-4\ell},
\end{aligned}
\tag{7.11}
$$

where Theorem A supplies the probability bound. Its contribution is also of the required order, because with $H=n+J$,

$$
\frac{A^2ne^{-4\ell}}{A^{3/2}/n}
=\frac{\sqrt A\,n^2}{e^4H^4}\leq1.
\tag{7.12}
$$

Lemma 7.1 identifies this one-coordinate quantity with average vector regret, without multiplying it by $n$. The same typical event also controls all leave-one-out predictive masses simultaneously. Finally, when $A\leq C_A n^2$, the bound $H\leq(2+\sqrt{C_A})n$ gives
$\ell\leq[1+\log(2+\sqrt{C_A})]\log(en)$. This proves Theorem C. $\square$

No bound of order $A$ for the original rule's squared-error risk is assumed. The entire argument uses the given prior, its posterior predictive mixture, and the original hierarchical posterior mean.

# 8. Interpretation, limitations, and verification

## 8.1. What the result settles

For the specified finite prior, Theorem A supplies a single-observation predictive lower-tail bound with the required failure probability throughout the stated growing-support regime. Theorems B and C establish the density and decision consequences under the very same prior. The conclusion includes arbitrary discrete true distributions and endpoint masses. It is not merely an existence theorem for a different universal prior.

The dependence $A^{3/2}/n$, up to logarithmic factors, is the established comparison scale discussed in [1, Section 3.2] and attributed there to [2]. We prove an upper bound for the original hierarchical rule, not a new minimax lower bound or a sharp logarithmic rate. The explicit constants 1024 and 300 are sufficient constants, with no claim of practical optimality. A vanishing-regret conclusion follows in particular when $A^{3/2}\ell^6/n\to0$. The displayed bound need not vanish throughout $A=O(n^2)$.

The generic argument requires the uniform Dirichlet distribution. Extending its boundary calculation to arbitrary concentration parameters is not proved here. No Gaussian extension, multidimensional Poisson theorem, model-size optimization, posterior sampling complexity, or training-dynamics result is included.

## 8.2. Literature boundary

The final search checked the original question [1], the risk-conversion work [2], and the earlier finite-mixture evidence identities [3, 4, 7]. A 2026 near neighbor by Favaro and Fortini [5] studies Dirichlet-process Bayes procedures and Newton-type quasi-Bayes procedures. Its fixed positive-support setting and its merging conclusions differ from the finite-prior growing-support problem here. Absolute continuity is imposed in its main merging theorem, not in every posterior-contraction result in that paper. A further October 2026 work [6] studies sums of latent and observed functionals via minimum-distance estimation; its fixed-count density lower bounds concern a constrained mixing class, rather than this prior's posterior predictive. These distinctions are based on the retrieved primary text, not just its abstract.

No earlier proof of the exact target or of the evidence comparison in Lemma 3.2 was identified in the inspected sources. This is a bounded literature-search conclusion, not a certification of worldwide priority. The accompanying novelty report records the queries, versions, inspected sections, and distinctions. Source versions are part of the evidence: we do not equate theorem numbers across preprint and journal versions without checking them.

## 8.3. What the computational checks establish

The accompanying exact-arithmetic audit independently integrates low-dimensional Dirichlet monomials and verifies the simplex geometry, boundary identity, evidence comparison, and induction on finite models. Supplementary high-precision checks inspect the Poisson identities and explicit parameter choices. These are error-detection checks with finite scope. They neither prove the universal quantifiers above nor replace the written arguments.

The written proof uses three external statistical results from two sources: the general contraction theorem [1, Lemma 2.4], the regularized Poisson score estimate [2, Lemma 13, equation (6.12)], and the weighted finite-difference inequality [2, Proposition 14]. All new model-specific ingredients are proved here. A future full kernel verification must also discharge those dependencies by verified library results or proofs; merely naming them as assumptions would not verify the unconditional main theorems. No Lean source, completed formalization claim, or kernel-build certificate accompanies this version.

The general assumptions are nonvacuous. For example, the two-point parameter space with Bernoulli kernels $p_\vartheta(1)=\vartheta$, $\vartheta\in\{1/4,3/4\}$, uniform base law, $S=\{0,1\}$, and $k=4$ has an exact rank-two representation, $b_*=1/2$, and $d_0=1$. Thus Theorem 3.3 applies with $\varepsilon=0$ for every finite horizon. In the Poisson model, $G_0=\delta_0$, $G_0=\delta_A$, and any convex combination of these measures all satisfy the main assumptions. Their inclusion follows directly from the proofs; no regularity or positive-density condition on $G_0$ is used.

# References

1. Nick Cannella, Anzo Teh, Yanjun Han, and Yury Polyanskiy. *Universal priors: solving empirical Bayes via Bayesian inference and pretraining*. Proceedings of the Thirty Ninth Conference on Learning Theory, PMLR 336:896--937, 2026. Technical version: [arXiv:2602.15136v2](https://arxiv.org/html/2602.15136v2), 22 June 2026, especially Definition 2, Lemma 2.4, and Section 3.2. [Official proceedings record](https://proceedings.mlr.press/v336/cannella26a.html).

2. Yandi Shen and Yihong Wu. *Poisson empirical Bayes estimation: When does g-modeling beat f-modeling in theory (and in practice)?* The Annals of Statistics 54(1):146--175, 2026. [DOI:10.1214/25-AOS2560](https://doi.org/10.1214/25-AOS2560). Technical inputs verified in [arXiv:2211.12692v2](https://arxiv.org/pdf/2211.12692), Lemma 13, equation (6.12), and Proposition 14, with the finite-count comparison in equations (6.19)--(6.23); arXiv submission date 19 November 2024. The moment-tail Lemma 15 and the moment-class form of Theorem 4 are not used in our risk proof. Publication metadata verified against the [IMS volume record](https://imstat.org/publications/aos/aos_54_1/aos_54_1.pdf).

3. Agostino Nobile. *On the posterior distribution of the number of components in a finite mixture*. The Annals of Statistics 32(5):2044--2073, 2004. [DOI:10.1214/009053604000000788](https://doi.org/10.1214/009053604000000788). [Authoritative reprint](https://arxiv.org/pdf/math/0503673), especially Theorem 3.1 and Corollary 3.1.

4. Agostino Nobile. *Bayesian finite mixtures: a note on prior specification and posterior computation*. [arXiv:0711.0458](https://arxiv.org/abs/0711.0458), 2007. Section 2, equation (13), records the empty-component interpretation of adjacent-model evidence ratios.

5. Stefano Favaro and Sandra Fortini. *Merging of Bayes and quasi-Bayes empirical Bayes procedures for Poisson compound decisions*. [arXiv:2607.02340](https://arxiv.org/pdf/2607.02340), 2026. Sections 2.1.1--2.1.3 and the stated assumptions of Proposition 2.1, Proposition 2.2, Lemma 2.3, and Theorem 2.4 inspected for overlap.

6. Stefano Favaro, Sandra Fortini, and Soham Jana. *Poisson empirical Bayes estimation of sums of random variables via minimum-distance methods*. [arXiv:2610.07190v1](https://arxiv.org/pdf/2610.07190), 5 October 2026. Sections 2.1 and 4.2, Assumption 4.1, Theorem 4.2, and Lemma C.4 inspected for overlap.

7. Jairo Fúquene, Mark Steel, and David Rossell. *On choosing mixture components via non-local priors*. [arXiv:1604.00314v5](https://arxiv.org/pdf/1604.00314), 11 June 2019. Section 3.2 and Supplement S4 give further empty-cluster evidence identities; these identities are not claimed as new here.

