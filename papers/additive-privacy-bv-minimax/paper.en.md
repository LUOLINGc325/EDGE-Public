# Nonmonotonicity and sharp high-privacy limits for additive privacy

## 加性隐私的单调性缺口与全维高隐私极小极大极限

Research manuscript · 26 November 2026

### Abstract

We study probability measures whose total variation distance from every Euclidean translate of length at most a prescribed sensitivity is at most a privacy budget. Two phenomena coexist. At every scalar privacy level strictly between zero and one, the optimal symmetric monotone law can be strictly improved for every finite even strictly convex loss. An explicit periodic contraction supplies a privacy certificate for the entire interval of allowed translations. A separate rational striped family gives exact counterexamples at reciprocal privacy levels approaching zero. Nevertheless, at every fixed dimension and positive moment order, the unrestricted optimal error has a sharp high-privacy limit, and every asymptotically optimal rescaled additive noise law converges to one uniform ball. We prove the lower bound for arbitrary Borel measures by deriving absolute continuity and bounded variation only after passage to the limit. A translation average over expanding cubes proves exact equality between the additive optimum and the worst-case optimum over all Borel Markov kernels on the full Euclidean location space. For squared error, Gaussian smoothing also gives an explicit, nonsharp finite-budget convergence bound. The contribution is the complete finite-to-infinitesimal bridge and its rigidity, together with the all-budget failure of the scalar monotonicity restriction; the scalar leading constant, the translation model, geometric tools, and invariance principle have antecedents described below.

## 1. Model, notation, and precise contribution

### 1.1 Full Euclidean translation privacy

Fix an integer $d\geq1$, an exponent $p>0$, a sensitivity $\Delta>0$, and $0<\delta<1$. All measures and kernels below are countably additive Borel objects on Euclidean spaces. Write
```math
 \tau_h\mu(A)=\mu(A-h),\qquad
 \operatorname{TV}(\mu,\nu)=\sup_{A\ \mathrm{Borel}}|\mu(A)-\nu(A)|.
 \tag{1.1}
```
For probability densities, this convention is one half of their $L^1$ distance. Define
```math
 \mathcal P_{d}(\delta,\Delta)
 =\{\mu:\operatorname{TV}(\mu,\tau_h\mu)\leq\delta
          \text{ for every }\|h\|_2\leq\Delta\},
 \qquad
 V_{d,p}(\delta,\Delta)
 =\inf_{\mu\in\mathcal P_d(\delta,\Delta)}
           \int\|x\|_2^p\,d\mu(x).
 \tag{1.2}
```
This is additive $(0,\delta)$-privacy with the full Euclidean sensitivity ball. We do not impose a density, symmetry, monotonicity, radiality, log concavity, or a parametric family on $\mu$.

For a Borel Markov kernel $x\mapsto K_x$ from $\mathbb R^d$ to $\mathbb R^d$, set
```math
 \mathcal R_p(K)=\sup_{x\in\mathbb R^d}
       \int\|y-x\|_2^p\,K_x(dy).
 \tag{1.3}
```
Let $R_{d,p}(\delta,\Delta)$ be the infimum of this risk over kernels with
```math
 \operatorname{TV}(K_x,K_{x+h})\leq\delta
       \quad\text{for every }x\in\mathbb R^d,\ \|h\|_2\leq\Delta.
 \tag{1.4}
```
The entire location space and the entire translation ball in (1.4) are part of the model. A general database query may have a smaller attainable difference set; the lower bounds here do not automatically apply to that smaller model.

Let $B_R=\{x:\|x\|_2\leq R\}$, let $v_d$ denote the Lebesgue volume of $B_1$, and put $v_0=1$. The constants in the main result are
```math
 c_d=\frac{v_{d-1}}{v_d},
 \qquad C_{d,p}=\frac{d}{d+p}c_d^p.
 \tag{1.5}
```
The dilation $x\mapsto x/\Delta$ preserves total variation and changes the $p$-moment by $\Delta^{-p}$. Consequently
```math
 V_{d,p}(\delta,\Delta)=\Delta^pV_{d,p}(\delta,1),
 \qquad R_{d,p}(\delta,\Delta)=\Delta^pR_{d,p}(\delta,1).
 \tag{1.6}
```

### 1.2 Main statements

**Theorem A (failure of scalar monotone optimality at every budget).**
Normalize $\Delta=1$. Let $\ell:\mathbb R\to\mathbb R$ be finite, even, and strictly convex, with $\ell(0)=0$. Let $\mathcal M$ be the class of symmetric probability measures such that
$\mu(S)\geq\mu(S+a)$ for every Borel $S\subseteq[0,\infty)$ and $a\geq0$, as in [GDK19, Property 2]. Then, for every $0<\delta<1$,
```math
 \inf_{\mu\in\mathcal P_1(\delta,1)}\int\ell\,d\mu
 <
 \inf_{\mu\in\mathcal P_1(\delta,1)\cap\mathcal M}\int\ell\,d\mu.
 \tag{1.7}
```
More strongly, every feasible atom-plus-uniform candidate from [GDK19, Theorem 2] admits a symmetric replacement of its continuous component that strictly lowers every such loss while preserving its privacy budget. The perturbation depends on the interval length, not on the choice of $\ell$.

**Theorem B (sharp fixed-dimensional limit and shape).**
For every fixed $d\geq1$, $p>0$, and $\Delta>0$,
```math
 R_{d,p}(\delta,\Delta)=V_{d,p}(\delta,\Delta)
 \quad (0<\delta<1),\qquad
 \lim_{\delta\downarrow0}\left(\frac{\delta}{\Delta}\right)^p
 V_{d,p}(\delta,\Delta)=C_{d,p}.
 \tag{1.8}
```
The additive infimum is attained for every such $\delta$. If $\delta_j\downarrow0$, $\mu_j\in\mathcal P_d(\delta_j,\Delta)$, and
```math
 \left(\frac{\delta_j}{\Delta}\right)^p
 \int\|x\|_2^p\,d\mu_j(x)\longrightarrow C_{d,p},
 \tag{1.9}
```
then the laws of $(\delta_j/\Delta)X_j$, $X_j\sim\mu_j$, converge weakly to the uniform probability measure on $B_{c_d}$. Their $p$-moments converge to the moment of that ball. For $p\geq1$, the convergence also holds in $p$-Wasserstein distance. For $0 \lt p<1$, only the stated weak and moment convergence is asserted.

**Theorem C (explicit nonsharp squared-error bound).**
Write $C=C_{d,2}$. For every $0<\delta<1$,
```math
 \max\left\{0,\
 C-3d^{1/3}\left(\frac{C\delta}{\sqrt{2\pi}}\right)^{2/3}\right\}
 \leq \frac{\delta^2}{\Delta^2}V_{d,2}(\delta,\Delta)
 \leq C.
 \tag{1.10}
```
The lower bound can be strengthened to the supremum over $s>0$ of
```math
 \frac{C}{(1+\delta/(\sqrt{2\pi}s))^2}-ds^2.
 \tag{1.11}
```
The exponent $2/3$ is a proved upper bound on the rate of the normalized value gap, not a sharp second-order expansion.

### 1.3 Relation to earlier work and original question

The conditional scalar optimization theorem in [GDK19] restricts to $\mathcal M$. Its footnote 1 expresses the expectation “we believe this assumption can be done away.” Theorem A refutes that removal for strictly convex losses; it does not refute the theorem with its hypothesis retained. In particular, it gives a counterexample for every squared-error privacy budget, not merely a discretized numerical search.

[BDMZ20, Theorem 3] already uses the full Borel total-variation translation model. At Euclidean adjacency its squared-error lower bound is
$\Delta^2d(1-\delta)/(800\delta^2)$. Its Section 5 asks whether the lower bounds can be improved or made tight. Theorem B settles the Euclidean, fixed-$d$, small-budget branch by giving its sharp constant and limiting shape. We do not settle their non-Euclidean adjacency problem or the finite-$\delta$ global optimum.

The following boundaries matter for novelty.

| Source | Relevant antecedent | Increment addressed here |
| --- | --- | --- |
| [GV16] | Integer-vector approximate privacy, $\ell^1$ sensitivity, and high-privacy utility bounds | Continuous Euclidean sensitivity, every fixed dimension, arbitrary Borel laws, sharp constant and rigidity |
| [GDK20] | Scalar unrestricted asymptotic privacy-utility bounds for absolute and squared error | The $d=1,p=1$ and $d=1,p=2$ leading terms, including $1/12$ for squared error, are acknowledged as known |
| [YDH+20] | Directional variation, coarea, and Wulff geometry for smoothing; related moment bounds | A sharp Euclidean moment inequality with equality traced through the finite-budget compactness bridge |
| [SLW25] | Nonmonotone numerical improvements at positive $\varepsilon$, including an explicit supplementary example | The endpoint $\varepsilon=0$, all translations, and every $0<\delta<1$, with analytic proofs |
| [LSW26] | Mixtures of Gaussians for approximate privacy, especially positive-$\varepsilon$ utility gaps | No claim that mixture improvement is new in general; our domain and asymptotic regime differ |
| [WBP26] | Gaussian high-dimensional asymptotics and rotational symmetrization | Here $d,p$ are fixed before $\delta\downarrow0$; the limits are not interchanged |
| [AR24] | Canonical noise under a full tradeoff/privacy profile | A single finite translation-ball budget is a weaker and different constraint |
| [GV13] | Translation averaging for output-dependent noise with additional regularity in pure privacy | Section 6 gives a countably additive all-kernel proof in the present location model, without claiming the invariance principle is new |

The supplementary moment bounds G.21/H.16 in [YDH+20] are stated for symmetric polytopes; the geometric method, rather than a directly matching sharp Euclidean theorem, is the antecedent. The BV moment inequality below is derived from classical analysis; we do not claim priority for that inequality in isolation. The mathematical contribution claimed is its sharp use for the entire finite-translation problem, the equality consequences for arbitrary near minimizers, and the scalar nonmonotonicity theorem. The search record and access limits are in the literature comparison. They support a bounded literature judgment, not a guarantee of global priority.

## 2. A periodic contraction of every uniform interval

### 2.1 An explicit compact bump

**Lemma 2.1 (bump contraction).**
Define the even $C^1$ probability density
```math
 \phi(t)=\frac{15}{16}(1-t^2)^2\mathbf1_{\{|t|\leq1\}},
 \quad
 b_\eta(t)=\frac2\eta\phi(2t/\eta)-\frac1\eta\phi(t/\eta)
 \quad(\eta>0).
 \tag{2.1}
```
Then $b_\eta$ is even, $C^1$, supported on $[-\eta,\eta]$, and has zero mass and zero first moment. Its second moment is
```math
 \int t^2b_\eta(t)\,dt=-\frac{3\eta^2}{28}.
 \tag{2.2}
```
For every finite strictly convex function $\ell:\mathbb R\to\mathbb R$ and every center $c$,
```math
 \int\ell(c+t)b_\eta(t)\,dt<0.
 \tag{2.3}
```

*Proof.* Integrating the polynomial gives $\int\phi=1$ and
$\int t^2\phi(t)\,dt=1/7$. The function and its first derivative vanish at both support endpoints. Changes of variable prove the mass, first-moment, and second-moment statements. If $S$ has density $\phi$, the left side of (2.3) is
$\mathbb E[\ell(c+\eta S/2)-\ell(c+\eta S)]$.
For every $s\ne0$, the two points $c+\eta s/2$ and $c-\eta s/2$ are strict convex combinations, with weights $3/4$ and $1/4$, of $c+\eta s$ and $c-\eta s$. Adding the two strict convexity inequalities and using symmetry of $S$ proves (2.3). All integrals are finite because a finite convex function is continuous and the support is compact. $\square$

**Lemma 2.2 (periodic placement with no cut bump).**
For every $L>1$, put $I_L=[-L/2,L/2]$. There exists an explicitly defined even $1$-periodic $C^1$ function $q_L$, not identically zero, with
```math
 \int_0^1q_L(x)\,dx=0,\qquad \int_{I_L}q_L(x)\,dx=0,
 \qquad \int_{I_L}\ell(x)q_L(x)\,dx<0
 \tag{2.4}
```
for every finite strictly convex $\ell$.

*Proof.* If $L/2\notin\mathbb Z$, set
$\theta=0$, $\rho=\operatorname{dist}(L/2,\mathbb Z)>0$, and
$\eta=\min\{1/4,\rho/2\}$. If $L/2\in\mathbb Z$, set
$\theta=1/2,\eta=1/4$. Define
```math
 q_L(x)=\sum_{j\in\mathbb Z}b_\eta(x-j-\theta).
 \tag{2.5}
```
The sum is locally finite, and the supports of distinct summands are disjoint. The centers are invariant under negation in both choices of $\theta$; hence $q_L$ is even. Periodicity and zero mean over one period follow by reindexing and integrating the translates of a zero-mass bump.

In the first case, each endpoint of $I_L$ is at distance at least $2\eta$ from every integer center. In the second, the distance from an integer endpoint to every half-integer center is at least $1/2=2\eta$. Thus every bump meeting $I_L$ lies wholly inside it. At least one lies inside: the center $0$ in the first case, and the centers $\pm1/2$ in the second, where $L\geq2$. Integrating complete bumps gives the second equality in (2.4); summing (2.3) over the nonempty finite collection gives the strict inequality. $\square$

### 2.2 The full translation certificate

**Lemma 2.3 (privacy of a small periodic perturbation).**
Let $q=q_L$ be as above, let $M=\|q\|_\infty$, let $K$ be any finite Lipschitz constant of $q$, and set
```math
 A=M+LK,\qquad \epsilon_L=\frac1{2A},\qquad
 f_L(x)=\frac{1+\epsilon_L q(x)}{L}\mathbf1_{I_L}(x).
 \tag{2.6}
```
Then $f_L$ is an even probability density, is at least $1/(2L)$ on $I_L$, and satisfies
```math
 \operatorname{TV}(f_L\,dx,\tau_h(f_L\,dx))\leq\frac1L
       \quad\text{for every }|h|\leq1.
 \tag{2.7}
```
Equality holds for $|h|=1$. Its cost is strictly smaller than that of $U_{I_L}$ for every finite strictly convex loss.

*Proof.* Here $A>0$, since $q\ne0$, and
$\epsilon_LM\leq1/2$. Equation (2.4) gives normalization and Lemma 2.2 gives evenness. It remains to check all real shifts, including shifts close to one.

Write $a=-L/2$. For $0\leq h\leq1 \lt L$, use the positive part of $f_L(x)-f_L(x-h)$. On the left nonoverlap interval only $f_L$ is positive; in the overlap the two constant parts cancel. Therefore
```math
 \operatorname{TV}(f_L,\tau_hf_L)=\frac1L
 \left[h+\epsilon_L\int_a^{a+h}q(x)\,dx
 +\epsilon_L\int_{a+h}^{a+L}(q(x)-q(x-h))_+\,dx\right].
 \tag{2.8}
```
The zero period integral implies
```math
 \left|\int_a^{a+h}q(x)\,dx\right|\leq M\min\{h,1-h\}.
 \tag{2.9}
```
The Lipschitz bound applied once with distance $h$, and once using periodicity with distance $1-h$, implies
```math
 |q(x)-q(x-h)|\leq K\min\{h,1-h\}.
 \tag{2.10}
```
Since the overlap length is at most $L$, (2.8) is bounded above by
```math
 \frac{h+\epsilon_L A\min\{h,1-h\}}L\leq\frac1L.
 \tag{2.11}
```
For the last inequality, $\epsilon_LA=1/2\leq1$; if $h\leq1/2$, the numerator is at most $2h$, and otherwise it is at most $h+1-h$. At $h=1$, periodicity makes both perturbation integrals zero, so the value is exactly $1/L$. Negative shifts have the same TV value by translation invariance and symmetry of the distance. Finally, the difference in loss from $U_{I_L}$ equals
$(\epsilon_L/L)\int_{I_L}\ell q$, which is strictly negative. $\square$

The derivative may change sign many times: these are deliberately nonmonotone densities. The smallness of the perturbation is essential. A bound at just $h=1$, or a finite list of shifts without an interpolation argument, would not establish (2.7).

### 2.3 Passage to the monotone optimum

We use the following previously proved comparison input, with its scope explicit. [GDK19, Theorem 2] states that for an even loss nondecreasing in $|x|$, the optimum among feasible measures satisfying Property 2 can be sought in
```math
 P_\alpha=\alpha\delta_0+(1-\alpha)U_{I_{L_\alpha}},
 \quad 0\leq\alpha<\delta,\qquad
 L_\alpha=\frac{1-\alpha}{\delta-\alpha}.
 \tag{2.12}
```
For finite even strictly convex losses normalized at zero, its loss hypotheses hold. This known conditional comparison is used only for the restricted right side of (1.7). It is not assumed for unrestricted noise.

**Lemma 2.4 (the restricted minimum is attained).**
For a loss in Theorem A, the cost of (2.12) attains its minimum at some $\alpha_*<\delta$.

*Proof.* The cost is continuous in $\alpha\in[0,\delta)$. An even strictly convex finite function with $\ell(0)=0$ is positive away from zero and tends to infinity as $|x|\to\infty$: for $x\geq1$, convexity gives $\ell(x)\geq x\ell(1)$. As $\alpha\uparrow\delta$, $L_\alpha\to\infty$, while $1-\alpha\geq1-\delta>0$. At least half the uniform mass has $|x|\geq L_\alpha/4$, so the cost diverges. A continuous function with this behavior attains its infimum on a compact initial subinterval. $\square$

*Proof of Theorem A.* Because $L_\alpha>1$, Lemma 2.3 applies. Replace the uniform component in $P_\alpha$ by $f_{L_\alpha}\,dx$, keeping the atom and its mass. For $h\ne0$, convexity of TV under mixtures gives
```math
 \operatorname{TV}\bigl(\alpha\delta_0+(1-\alpha)f_{L_\alpha}dx,\
       \tau_h[\alpha\delta_0+(1-\alpha)f_{L_\alpha}dx]\bigr)
 \leq\alpha+(1-\alpha)/L_\alpha=\delta.
 \tag{2.13}
```
For $h=0$ the value is zero. In fact the atomic signed difference and the absolutely continuous signed difference are mutually singular, so their total variations add for nonzero $h$. The continuous cost strictly decreases by Lemma 2.3. Apply this replacement to $\alpha_*$ from Lemma 2.4 and use the cited conditional comparison. This proves the strict inequality of infima. $\square$

For the loss $|x|^p$, $p>1$, the conditional optimizer has
$\alpha_*=\max\{0,(p+1)\delta-p\}$ [GDK19]. For squared error this reads $\alpha_*=0$ when $\delta\leq2/3$, and $\alpha_*=3\delta-2$, $L_{\alpha_*}=3/2$ otherwise. Strict convexity must not be replaced by mere convexity in this theorem: a bump that stays on one side of the origin has zero improvement for the affine portion of $|x|$.

## 3. Exact striped counterexamples approaching high privacy

The preceding construction covers every budget but deliberately chooses a conservative perturbation. The next family gives rational densities, exact translation values, and exact errors at $\delta=1/n$.

**Proposition 3.1 (striped family).**
For an integer $n\geq2$, define
```math
 I_n=[-n/2,n/2],\quad
 J_j=[j-n/2+1/4,j-n/2+3/4]\quad(0\leq j \lt n),
```
```math
 a_n=\frac{2(n-1)}{n(2n-1)},\qquad
 b_n=\frac{2}{n(2n-1)},\qquad
 g_n=a_n\mathbf1_{I_n}+b_n\sum_{j=0}^{n-1}\mathbf1_{J_j}.
 \tag{3.1}
```
This is an even probability density with
```math
 \operatorname{TV}(g_n\,dx,\tau_h(g_n\,dx))
 =
 \begin{cases}
 2|h|/n,&0\leq |h|\leq1/2,\\
 1/n,&1/2\leq |h|\leq1,
 \end{cases}
 \tag{3.2}
```
and
```math
 \int x^2g_n(x)\,dx=\frac{n^2}{12}-\frac1{16(2n-1)}.
 \tag{3.3}
```

*Proof.* The mass is $na_n+nb_n/2=1$, and the intervals are reflected into one another by $x\mapsto-x$.

Here is a full-shift derivation of (3.2). Put $\chi=\sum_j\mathbf1_{J_j}$ and $a=-n/2$. For $0\leq h\leq1$, the positive-part formula gives a baseline $a_nh$, plus $b_n$ times the measure of
```math
 \{x\in I_n:\chi(x)=1,\ x-h\notin\textstyle\bigcup_jJ_j\}.
 \tag{3.4}
```
This description includes bumps in the left nonoverlap interval, since $\chi(x-h)=0$ there. If $h\leq1/2$, the left end of each bump contributes length $h$; an earlier neighboring bump cannot overlap that contribution. The total is $nh$. If $1/2\leq h\leq1$, the first bump contributes its entire length $1/2$; each later bump loses an overlap of length $h-1/2$ with the preceding shifted bump, so it contributes $1-h$. Thus
```math
 \operatorname{TV}=
 \begin{cases}
 (a_n+nb_n)h,&h\leq1/2,\\
 a_nh+b_n[1/2+(n-1)(1-h)],&h\geq1/2.
 \end{cases}
```
The identities $a_n+nb_n=2/n$ and $a_n=(n-1)b_n$ give (3.2); translation invariance handles negative $h$.

For the moment computation, let $w_n=1/(2n-1)$. Then
```math
 g_n\,dx=(1-w_n)U_{I_n}+w_n H_n,
 \tag{3.5}
```
where $H_n$ selects one of the $n$ unit cells uniformly and then is uniform on that cell's central half. The cell center has second moment $(n^2-1)/12$; the central-half offset has second moment $1/48$. Hence the second moment of $H_n$ is $n^2/12-1/16$. Equation (3.3) follows. $\square$

**Corollary 3.2 (strict convex contraction).**
For every finite strictly convex $\ell$,
```math
 \int\ell(x)g_n(x)\,dx<\int\ell(x)\,dU_{I_n}(x).
 \tag{3.6}
```
Indeed, conditional on each cell center $c$, the central-half law is the contraction of $c+T$ to $c+T/2$, where $T$ is uniform on $[-1/2,1/2]$. The strict convexity argument in Lemma 2.1 applies in each cell, and $w_n>0$. For even $|x|^p$, $p>1$, the uniform law is the restricted optimum at $\delta=1/n$, so this gives explicit restricted-class gaps approaching zero.

**Example 3.3 (a small rational certificate).**
At $n=2$,
```math
 g_2(x)=\frac13\mathbf1_{\{|x|\leq1\}}
       +\frac13\mathbf1_{\{1/4\leq|x|\leq3/4\}},
 \qquad \int x^2g_2(x)\,dx=\frac5{16}<\frac13.
 \tag{3.7}
```
The budget is $\delta=1/2$. Relative to the monotone optimum $1/3$, the improvement is $1/16=6.25\%$. Its eight consecutive quarter-bin masses are
$(1,2,2,1,1,2,2,1)/12$.
For step densities on a common equal grid, TV as a function of translation is affine between consecutive grid shifts: the overlap partition has fixed order between such shifts, and every segment length is affine in the shift. This gives an alternative exact finite certificate for each fixed $n$, used in the accompanying arithmetic checker. It is not a substitute for the all-$n$ proof above.

**Corollary 3.4 (smooth squared-error separation).**
Convolving $g_n\,dx$ with a centered Gaussian of variance
```math
 0<\sigma^2<\frac1{16(2n-1)}
 \tag{3.8}
```
preserves $(0,1/n)$-privacy and still has squared error below $n^2/12$. The resulting density is strictly positive and real analytic.

*Proof.* Convolution is a Markov transformation and contracts total variation; it commutes with translation. The Gaussian is independent and centered, so second moments add. Its convolution with a nonzero compactly supported probability density is positive, and the Gaussian's analytic derivatives on compact sets can be integrated termwise. $\square$

Equation (3.3) is an upper bound on the unrestricted optimum, not its exact value. Its normalized improvement is
$\delta^2/[16(2/\delta-1)]$ at reciprocal budgets, of order $\delta^3$. Thus a strict finite-budget gap is compatible with the sharp leading term proved next.

## 4. The sharp geometric inequality

We use standard Euclidean BV facts: the distributional derivative of an $L^1$ BV function is a finite vector Radon measure with a polar decomposition; the coarea formula identifies its total variation with the integral of the perimeters of its superlevel sets; and the Euclidean isoperimetric inequality minimizes perimeter at fixed volume. These are classical inputs [AFP00], not new hypotheses on a privacy law. All uses and constants are made explicit below. Later formal verification must prove or import these as checked theorems; treating them as unproved axioms would not verify the manuscript.

### 4.1 Moments of sets and of densities

**Lemma 4.1 (centered-ball moment bound for a set).**
If a measurable set $E\subseteq\mathbb R^d$ has volume $v_dr^d$, $0 \lt r<\infty$, then
```math
 \int_E\|x\|_2^p\,dx\geq\frac{d}{d+p}v_dr^{d+p}.
 \tag{4.1}
```
Equality with finite moment holds only when $E=B_r$ up to a null set.

*Proof.* The moment of $B_r$ is the right side by radial integration. The sets $E\setminus B_r$ and $B_r\setminus E$ have equal volume. Subtract the common constant $r^p$ on these two sets. Both remaining integrals are nonnegative, and are strictly positive if the respective set has positive measure, because $p>0$ and the sphere has zero Lebesgue measure. $\square$

**Lemma 4.2 (sharp moment–variation inequality).**
Let $f\geq0$ be a BV probability density on $\mathbb R^d$, and put
```math
 T=|Df|(\mathbb R^d),\qquad
 M_p(f)=\int\|x\|_2^p f(x)\,dx.
```
Then $T>0$ and
```math
 M_p(f)\left(\frac Td\right)^p\geq\frac d{d+p}.
 \tag{4.2}
```
If $M_p(f)<\infty$, equality holds exactly for uniform densities on balls centered at the origin.

*Proof.* For $t>0$, write $E_t=\{f>t\}$, $m_t=|E_t|$, and
$r_t=(m_t/v_d)^{1/d}$ when $m_t>0$. These quantities are finite for $t>0$ because $tm_t\leq1$. Ignore the zero-volume levels and define the probability measure
```math
 dw(t)=m_t\,dt,\qquad \int_0^\infty m_t\,dt=1.
 \tag{4.3}
```
Coarea and the Euclidean isoperimetric inequality give
```math
 T=\int_0^\infty\operatorname{Per}(E_t)\,dt
 \geq d v_d\int_0^\infty r_t^{d-1}\,dt
 =d\,\mathbb E_w[r_t^{-1}].
 \tag{4.4}
```
In dimension one the same inequality says that a nonempty finite-volume set has perimeter at least two; the constants still agree with $v_1=2$. In particular $T>0$. Layer cake and Lemma 4.1 give
```math
 M_p(f)\geq\frac d{d+p}\mathbb E_w[r_t^p].
 \tag{4.5}
```
The function $z\mapsto z^{-p}$ is strictly convex for every $p>0$. Jensen's inequality and (4.4) imply
```math
 \mathbb E_w[r_t^p]\geq
       \bigl(\mathbb E_w[r_t^{-1}]\bigr)^{-p}
 \geq (T/d)^{-p}.
 \tag{4.6}
```
This proves (4.2), including infinite moments by the same extended-integral inequalities.

If equality is finite, every inequality in (4.4)–(4.6) and (4.5) is an equality. Strict Jensen forces a single radius $r_t=r$ for $w$-almost every nonzero level. Equality in Lemma 4.1 forces those levels to be $B_r$, with center zero. Nestedness of superlevel sets and layer cake then make $f$ a constant multiple of $\mathbf1_{B_r}$, with the constant fixed by its unit mass. Conversely such densities attain (4.2) by direct moment and perimeter calculation. $\square$

### 4.2 Averaging directional variation

**Lemma 4.3 (directional average identity).**
Let $\sigma$ be normalized surface measure on $S^{d-1}$; for $d=1$, use equal masses at $1$ and $-1$. For any $f\in BV(\mathbb R^d)$,
```math
 \int_{S^{d-1}} |D_u f|(\mathbb R^d)\,d\sigma(u)
       =\frac{2c_d}{d}|Df|(\mathbb R^d).
 \tag{4.7}
```
In particular, if $f\geq0$ almost everywhere, $\int f\,dx=1$, and $|D_uf|(\mathbb R^d)\leq2$ for every unit $u$, then
```math
 |Df|(\mathbb R^d)\leq d/c_d,\qquad M_p(f)\geq C_{d,p}.
 \tag{4.8}
```
Equality in the moment bound forces $f$ to be the uniform density on $B_{c_d}$.

*Proof.* Write $Df=\xi\,|Df|$ with $\|\xi\|_2=1$ almost everywhere with respect to $|Df|$. Then
$|D_uf|=|u\cdot\xi|\,|Df|$. Rotation invariance and Tonelli reduce (4.7) to the average of $|u_1|$ on the sphere. For $d\geq2$, projection of the two hemispheres onto the unit $(d-1)$-ball yields
$\int_{S^{d-1}}|u_1|\,d\mathcal H^{d-1}=2v_{d-1}$.
The sphere has area $dv_d$; hence the normalized average is $2c_d/d$. For $d=1$ it is one, the same expression. Integrating the directional bounds gives the first inequality in (4.8), and Lemma 4.2 gives the second. If the moment equals $C_{d,p}$, all inequalities force $T=d/c_d$ and equality in Lemma 4.2. For the resulting uniform ball, $T=d/r$, so $r=c_d$. $\square$

## 5. From finite privacy to the sharp limit

### 5.1 A ball upper bound and existence at every budget

**Lemma 5.1 (uniform ball certificate).**
For $R>0$, $s\geq0$, and a unit vector $e$,
```math
 \operatorname{TV}(U_{B_R},\tau_{se}U_{B_R})
 =\frac1{v_dR^d}\int_{B_R^{d-1}}
       \min\{s,2\sqrt{R^2-\|z\|_2^2}\}\,dz
 \leq\frac{c_ds}{R}.
 \tag{5.1}
```
For $d=1$, the integral is the single zero-dimensional slice. Taking
$R=c_d\Delta/\delta$ therefore gives a feasible law of moment
```math
 \frac{d}{d+p}R^p=C_{d,p}(\Delta/\delta)^p.
 \tag{5.2}
```

*Proof.* On each line parallel to $e$, the ball is an interval of length
$2\sqrt{R^2-\|z\|_2^2}$. Its nonoverlap with its translate has length the minimum in (5.1). Integrating this nonoverlap and dividing by the ball volume gives the equality. Bounding the integrand by $s$ gives the inequality. Radial integration gives the moment in (5.2). $\square$

**Lemma 5.2 (weak closure and attainment).**
For fixed $\delta,\Delta,d,p$, the feasible set in (1.2) is weakly closed, and $V_{d,p}$ is finite and attained.

*Proof.* On Euclidean probability measures, total variation is the supremum of the absolute integral differences over bounded continuous functions taking values in $[0,1]$. Thus it is lower semicontinuous under weak convergence of both arguments. Translation by a fixed vector is continuous for weak convergence, so every fixed-$h$ constraint is closed; their arbitrary intersection is closed. Lemma 5.1 gives a finite upper bound. A minimizing sequence with uniformly bounded $p$-moment is tight by
$\mu(\|x\|_2>A)\leq A^{-p}\int\|x\|_2^p\,d\mu$.
Prokhorov compactness gives a weakly convergent subsequence. Its limit is feasible and its moment is no larger than the liminf, by lower semicontinuity of the nonnegative continuous cost. $\square$

### 5.2 Grouping translations and eliminating singular limits

**Lemma 5.3 (rescaled translation modulus).**
For $\mu\in\mathcal P_d(\delta,1)$, let $\nu$ be the law of $\delta X$, $X\sim\mu$. Then for every $h\in\mathbb R^d$,
```math
 \operatorname{TV}(\nu,\tau_h\nu)\leq\|h\|_2+\delta.
 \tag{5.3}
```

*Proof.* At every step of length at most $\delta$, the rescaled law has TV at most $\delta$. For $h\ne0$, take $m=\lceil\|h\|_2/\delta\rceil$, split $h$ into $m$ equal steps, and use the triangle inequality and translation invariance:
$\operatorname{TV}(\nu,\tau_h\nu)\leq m\delta\leq\|h\|_2+\delta$.
For $h=0$ the left side is zero. $\square$

**Lemma 5.4 (the limiting modulus forces a BV density).**
If a Borel probability measure $\nu$ satisfies
```math
 \operatorname{TV}(\nu,\tau_h\nu)\leq\|h\|_2
                  \quad\text{for every }h\in\mathbb R^d,
 \tag{5.4}
```
then $\nu=f\,dx$ for a BV probability density, and
```math
 |D_uf|(\mathbb R^d)\leq2\quad\text{for every unit }u.
 \tag{5.5}
```

*Proof.* Take a nonnegative smooth probability mollifier $\rho_\varepsilon$ supported on $B_\varepsilon$. Convexity of TV and (5.4) give
```math
 \operatorname{TV}(\nu,\nu*\rho_\varepsilon)
 \leq\int\operatorname{TV}(\nu,\tau_h\nu)\rho_\varepsilon(h)\,dh
 \leq\varepsilon.
 \tag{5.6}
```
Each convolution is absolutely continuous. If $N$ is a Lebesgue null set, then
$\nu(N)\leq\operatorname{TV}(\nu,\nu*\rho_\varepsilon)\leq\varepsilon$.
Letting $\varepsilon\downarrow0$ proves absolute continuity, including exclusion of both atoms and singular continuous mass.

For its density $f$, (5.4) becomes
$\|f(\cdot-h)-f\|_1\leq2\|h\|_2$.
For a unit $u$ and a smooth compactly supported test function $\psi$, translation of variables in the difference quotient and dominated convergence give
```math
 \left|\int f\,\partial_u\psi\,dx\right|
 \leq 2\|\psi\|_\infty.
 \tag{5.7}
```
Indeed, the integral is the limit of pairing $\psi$ with a translated density difference divided by its step length. The bounded functional extends to continuous functions vanishing at infinity and is represented by a finite signed Radon measure of total variation at most two. Applying this in coordinate directions gives $f\in BV$; applying it to arbitrary $u$ identifies its directional distributional derivative and proves (5.5). $\square$

### 5.3 Value convergence and rigidity of all near minimizers

**Proposition 5.5 (lower limit for arbitrary feasible sequences).**
Suppose $\delta_j\downarrow0$, $\mu_j\in\mathcal P_d(\delta_j,1)$, and
$\sup_j\delta_j^p\int\|x\|_2^p\,d\mu_j<\infty$.
Write $\nu_j$ for the law of $\delta_jX_j$. For every subsequence such that $\nu_{j_k}$ converges weakly to $\nu$,
```math
 \nu=f\,dx,\quad |D_uf|(\mathbb R^d)\leq2,\quad
 C_{d,p}\leq M_p(f)
       \leq\liminf_{k\to\infty}\delta_{j_k}^p\int\|x\|_2^p\,d\mu_{j_k}
 \tag{5.8}
```
The liminf here is along this same weakly convergent subsequence.

*Proof.* The scaled moment bound gives tightness. Fix an arbitrary $h$. Lower semicontinuity of TV and Lemma 5.3 pass to (5.4) along the weakly convergent subsequence. The same fixed limit works for every $h$; no change of subsequence indexed by $h$ is needed. Lemma 5.4 and Lemma 4.3 give the first inequality. Portmanteau gives the final moment inequality along that same subsequence. $\square$

*Proof of the additive limit in Theorem B.* Choose minimizers from Lemma 5.2 along an arbitrary sequence $\delta_j\downarrow0$. Their scaled moments are bounded above by $C_{d,p}$ using Lemma 5.1. First take a subsequence realizing the liminf of these moments, and then take a weakly convergent further subsequence by tightness. Proposition 5.5 bounds that liminf below by the same constant. The resulting sequential limit proves (1.8) for $V$, and scaling proves the statement for every $\Delta>0$. $\square$

**Proposition 5.6 (unique limiting shape).**
Every feasible sequence satisfying (1.9) has the convergence stated in Theorem B.

*Proof.* Normalize $\Delta=1$. The scaled moment bound makes the laws tight. Every weak limit has moment at most $C_{d,p}$ by Portmanteau and at least $C_{d,p}$ by Proposition 5.5. Equality in Lemma 4.3 identifies it as $U_{B_{c_d}}$. Thus every subsequence has the same possible weak limit, which proves convergence of the full sequence. The moments converge by the assumed equality (1.9) and the moment of the identified ball. For $p\geq1$, the usual characterization of $p$-Wasserstein convergence by weak convergence plus convergence of $p$-moments gives the final assertion. No assertion of total-variation convergence is made. $\square$

The rigidity statement includes nonsymmetric and singular finite-budget laws. It derives their limiting regularity; it does not assume regularity before taking the limit. It supplies a necessary limiting shape for any asymptotically optimal additive family. Conversely, for feasible laws, weak convergence to that ball together with convergence of its $p$-moment implies (1.9), so it is also a complete weak-and-moment characterization.

## 6. Exact reduction of full-space mechanisms to additive noise

**Proposition 6.1 (translation averaging).**
For every $d\geq1$, $p>0$, $\Delta>0$, and $0<\delta<1$,
```math
 R_{d,p}(\delta,\Delta)=V_{d,p}(\delta,\Delta).
 \tag{6.1}
```
For every feasible kernel with finite risk $r$, there exists an additive feasible law with $p$-moment at most $r$.

*Proof.* An additive law $\mu$ induces the kernel $K_x=\tau_x\mu$, which is Borel, has the same privacy constraints, and has constant risk equal to its moment. Hence $R\leq V$.

For the reverse direction, fix a feasible Borel kernel $K$ with finite risk $r$. Its error law at $x$ is
```math
 Q_x(A)=K_x(x+A).
 \tag{6.2}
```
The function $x\mapsto Q_x(A)$ is Borel: integrate the jointly Borel indicator $\mathbf1_A(y-x)$ against the kernel. Let $C_T=[-T,T]^d$ and form the countably additive probability measure
```math
 \mu_T(A)=\frac1{|C_T|}\int_{C_T}Q_x(A)\,dx.
 \tag{6.3}
```
Tonelli gives $\int\|z\|_2^p\,d\mu_T(z)\leq r$.

For $\|h\|_2\leq\Delta$, the definition of $Q$ and kernel privacy imply
```math
 \operatorname{TV}(Q_x,\tau_hQ_{x+h})\leq\delta.
 \tag{6.4}
```
Indeed, both kernels on the right-hand comparison are evaluated on the same output event $x+A$. Average (6.4) over $C_T$. The average of $Q_{x+h}$ is the average of $Q_z$ over $C_T+h$. The common portion of the two cubes cancels, and their two residual portions have equal volume. Consequently
```math
 \operatorname{TV}(\mu_T,\tau_h\mu_T)
 \leq\delta+\frac{|C_T\mathbin{\triangle}(C_T+h)|}{2|C_T|}.
 \tag{6.5}
```
The boundary fraction tends to zero for every fixed $h$. The moment bound makes $\{\mu_T:T\geq1\}$ tight; choose a weakly convergent sequence with $T\to\infty$. Lower semicontinuity passes (6.5) to the required TV constraint for every fixed $h$, and passes the moment bound to $r$. This constructs a countably additive feasible probability law, not a finitely additive invariant mean. Thus $V\leq r$. Take the infimum over kernels with finite risk; such kernels exist by Lemma 5.1. $\square$

The location-dependent mechanism need not itself converge, and the theorem does not claim that every optimal mechanism is additive. It proves equality of optimal values and existence of an additive representative with no larger worst-case error. Combining Proposition 6.1 with Section 5 completes Theorem B.

## 7. A quantitative lower bound for squared error

**Lemma 7.1 (Gaussian derivative estimate).**
Suppose a Borel probability measure $\nu$ obeys
$\operatorname{TV}(\nu,\tau_h\nu)\leq\|h\|_2+\delta$ for every $h$.
For $s>0$, let $f_s$ be the smooth density of
$\nu*N(0,s^2I_d)$. Then, for every unit vector $u$,
```math
 \|\partial_u f_s\|_1\leq2+\sqrt{2/\pi}\,\delta/s.
 \tag{7.1}
```

*Proof.* First convolve in the $u^\perp$ directions; this cannot enlarge TV between translates. Write the remaining one-dimensional centered Gaussian density as
$\varphi_s(t)=(2\pi s^2)^{-1/2}e^{-t^2/(2s^2)}$.
Pair the positive and negative halves of its derivative. The $L^1$ norm of the resulting derivative is bounded by
```math
 \int_0^\infty\frac{t}{s^2}\varphi_s(t)\,
       2\operatorname{TV}(\nu,\tau_{2tu}\nu)\,dt
 \leq\frac4{s^2}\int_0^\infty t^2\varphi_s(t)\,dt
       +\frac{2\delta}{s^2}\int_0^\infty t\varphi_s(t)\,dt.
 \tag{7.2}
```
The factor two before TV is the total variation norm of a signed difference of probability measures, consistent with (1.1). The Gaussian half-moments are $s^2/2$ and $s/\sqrt{2\pi}$. Substitution proves (7.1). Differentiation and the integral bounds are justified by the integrable Gaussian derivative and Tonelli's theorem, including when $\nu$ is singular. $\square$

*Proof of Theorem C.* Normalize $\Delta=1$, let $\mu$ be any feasible law of finite squared error, and let $\nu$ be its $\delta$-scaled law. Lemma 5.3 supplies the hypothesis of Lemma 7.1. Lemma 4.3, with the enlarged directional bound, yields
```math
 |Df_s|(\mathbb R^d)\leq
 \frac d{c_d}\left(1+\frac{\delta}{\sqrt{2\pi}s}\right).
 \tag{7.3}
```
Lemma 4.2 then implies
```math
 M_2(f_s)\geq
 \frac{C}{(1+\delta/(\sqrt{2\pi}s))^2}.
 \tag{7.4}
```
An independent centered Gaussian adds exactly $ds^2$ to the second moment, even if $\nu$ is not centered. Hence
```math
 \delta^2\int\|x\|_2^2\,d\mu(x)
 \geq\frac{C}{(1+\delta/(\sqrt{2\pi}s))^2}-ds^2.
 \tag{7.5}
```
This also holds trivially for infinite moments. It holds for every $s>0$; taking the infimum over $\mu$ proves (1.11). Since $(1+x)^{-2}\geq1-2x$ for $x\geq0$, the right side is at least
```math
 C-\frac{2C\delta}{\sqrt{2\pi}s}-ds^2.
```
Choose $s^3=C\delta/(d\sqrt{2\pi})$. The two error terms sum to
$3d^{1/3}(C\delta/\sqrt{2\pi})^{2/3}$. Nonnegativity, Lemma 5.1, and the scaling (1.6) give (1.10). $\square$

For squared error, the first constants are $C_{1,2}=1/12$, $C_{2,2}=2/\pi^2$, and $C_{3,2}=27/80$. The scalar striped gap and the convergence estimate concern different quantities: the former separates two feasible classes at finite budgets; the latter bounds the remaining uncertainty in the unrestricted normalized optimum.

## 8. Scope, reproducibility, and unresolved questions

The positive conclusions hold for fixed dimension, fixed moment order, full Euclidean adjacency, and the zero-$\varepsilon$ privacy endpoint. Theorems A and B are compatible: optimal finite-scale scalar laws cannot be forced to be monotone, but all additive near minimizers have a uniform-ball limit after privacy scaling.

The following questions remain open in this work: the exact unrestricted optimizer for a general finite $\delta$; a sharp second-order expansion; a quantitative rate for convergence of near-optimal shapes; arbitrary sensitivity bodies; general positive $\varepsilon$; and joint dimension/privacy limits. Theorem A does not assert strict improvement for every merely convex loss. Theorem B does not assert uniqueness of the finite-budget optimizer, convergence of arbitrary nonadditive kernels, or total-variation convergence of the rescaled laws.

The arithmetic checker accompanying this manuscript uses exact rational integration for the striped family and checks a finite set of integers and all translation intervals for those grid densities. It confirms those finite instances and the $5/16$ example. It does not establish the universal theorems, replace the written arguments, or constitute formal verification.

The written proof invokes standard measure-theoretic results (Tonelli, weak compactness of tight probability families, lower semicontinuity, Radon representation, and the Wasserstein moment criterion), classical BV coarea and Euclidean isoperimetry, and the explicitly scoped restricted optimizer theorem [GDK19]. All other transfers, constants, constructions, equality arguments, and mechanism comparisons used here have been proved above. These inputs are part of the mathematical dependency of the manuscript; no restriction to smooth or symmetric original noise is concealed in them.

## References

- **[GDK19]** Quan Geng, Wei Ding, Ruiqi Guo, and Sanjiv Kumar. Optimal Noise-Adding Mechanism in Additive Differential Privacy. AISTATS 2019, PMLR 89:11–20. [Official paper](https://proceedings.mlr.press/v89/geng19a.html).
- **[GDK20]** Quan Geng, Wei Ding, Ruiqi Guo, and Sanjiv Kumar. Tight Analysis of Privacy and Utility Tradeoff in Approximate Differential Privacy. AISTATS 2020, PMLR 108:89–99. [Official paper](https://proceedings.mlr.press/v108/geng20a.html).
- **[GV16]** Quan Geng and Pramod Viswanath. Optimal Noise Adding Mechanisms for Approximate Differential Privacy. IEEE Transactions on Information Theory 62(2):952–969, 2016. [DOI](https://doi.org/10.1109/TIT.2015.2504972).
- **[BDMZ20]** Avrim Blum, Travis Dick, Naren Manoj, and Hongyang Zhang. Random Smoothing Might be Unable to Certify $\ell_\infty$ Robustness for High-Dimensional Images. Journal of Machine Learning Research 21(211):1–21, 2020. [Official paper](https://jmlr.org/papers/v21/20-209.html).
- **[YDH+20]** Greg Yang, Tony Duan, J. Edward Hu, Hadi Salman, Ilya Razenshteyn, and Jerry Li. Randomized Smoothing of All Shapes and Sizes. ICML 2020, PMLR 119:10693–10705. [Official paper and supplement](https://proceedings.mlr.press/v119/yang20c.html).
- **[SLW25]** Aras Selvi, Huikang Liu, and Wolfram Wiesemann. Differential Privacy via Distributionally Robust Optimization. Operations Research 74(1):356–376, 2026; published online 10 March 2025. [DOI](https://doi.org/10.1287/opre.2023.0218). The nonmonotone numerical comparison is in the authors' GitHub supplement.
- **[LSW26]** Liu, Selvi, and Wiesemann. Mind the Gap: Mixtures of Gaussians in Approximate Differential Privacy. ICML 2026, PMLR 306:78144–78189. [Official paper](https://proceedings.mlr.press/v306/liu26dk.html).
- **[WBP26]** Wei, Bienstock, and Polychroniadou. Asymptotic Optimality of the High-Dimensional Gaussian Mechanism and Improved Low-Dimensional Mechanisms for Differential Privacy. ICML 2026, PMLR 306:133468–133499. [Official paper](https://proceedings.mlr.press/v306/wei26a.html).
- **[AR24]** Jordan Awan and Aishwarya Ramasethu. Optimizing Noise for f-Differential Privacy via Anti-Concentration and Stochastic Dominance. Journal of Machine Learning Research 25(351):1–32, 2024. [Official paper](https://www.jmlr.org/papers/v25/23-1624.html).
- **[GV13]** Quan Geng and Pramod Viswanath. The Optimal Mechanism in Differential Privacy. arXiv:1212.1186v3, 2013. [Preprint](https://arxiv.org/abs/1212.1186).
- **[AFP00]** Luigi Ambrosio, Nicola Fusco, and Diego Pallara. Functions of Bounded Variation and Free Discontinuity Problems. Oxford University Press, 2000. [DOI](https://doi.org/10.1093/oso/9780198502456.001.0001). Classical BV background; bibliographic metadata and contents were checked, not full-text access to the book.
