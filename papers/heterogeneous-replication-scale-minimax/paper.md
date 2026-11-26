---
title: "Scale thresholds, weak recovery, and stopping-design limits for heterogeneous repeated measurements"
date: "26 November 2026"
lang: en
---

# Abstract

We study additive repeated measurements with independent, unknown, and heterogeneous errors. For a fixed concentration probability $0 < p < 1$ and error concentration radii $\ell_j$, we prove that $\sum_j\ell_j^{-1}=\infty$ is equivalent to identification of the signal and every error law up to a common translation, continuity of the inverse observation map in the weak topology, and existence of a jointly strongly consistent estimator from independent randomly stopped records. No signal or error moments are needed for these equivalences. For density estimation with centered finite-variance errors, three bounded anchor channels yield uniform calibration without any signal moment or tail restriction. We derive risk envelopes for every independent stopping distribution, and matching minimax rates for a broad class of exponential or faster tails satisfying a one-sided dilation condition. The sharp rate is $(1+\sum_{j\le h_n}\sigma_j^{-1})^{-2\beta}$, where $h_n$ is a count-tail crossing index. For geometric stopping this becomes a logarithmic-index precision sum. An explicit staircase stopping distribution has a provably different minimax rate and shows that maximum record length alone can overstate recoverable information by an unbounded factor. The lower bounds use one fixed known compact-spectrum noise sequence and the full random-length experiment.

**Keywords:** repeated measurements; unknown heterogeneous noise; characteristic-function zeros; weak inverse stability; stopping design; minimax deconvolution.

**Verification status.** This manuscript supplies written proofs. Numerical checks are diagnostic only. No formal proof code or external peer-review certification is claimed; formal verification is a separate future delivery.

# 1. Introduction and relation to prior work

Repeated measurements can distinguish a latent distribution from its measurement errors, but both spectral zeros and unrestricted tails obstruct standard deconvolution. We ask how the number and quality of repeated measurements can themselves supply the missing information. Our answer uses a deterministic reciprocal-scale sum, the weak topology of the entire latent parameter, and the number of independent subjects reaching each repetition depth.

The local functional equation in our identification proof belongs to the classical Kotlarski method [K67, N07]. Compact Fourier support already appears in classical counterexamples [K67, N07]. Moment determinacy is also an established route to identification: the result of Gaillac and Gautier [GG21, Theorem 3], after an invertible difference transformation, covers a tempting moment-determinate signal formulation. We do not claim that formulation as a new result.

Frequency allocation across repeated measurements is present in Meister and Neumann [MN10], including discussion of varying finite replication counts. Derivative-ratio exponential reconstruction and its regularization are established methods; see Comte and Kappus [CK15] and the Li--Vuong construction discussed there. Our local estimator uses that method family on a uniformly controlled neighborhood. The claimed increments are the exact heterogeneous concentration-scale criterion for identification, weak stability, and joint consistency; tail-unrestricted signal estimation after local noise calibration; and full-experiment information bounds for general independent stopping, including a sharp tail class and a sharp irregular-design counterexample. The three-variable difference structure itself is already in Kotlarski [K67], and the weak minimum-distance strategy is already in Neumann [N07].

Delaigle, Hall, and Meister [DHM08] provide a close statistical benchmark: their repeated-measurement analysis uses common symmetric errors with a real, nowhere-zero characteristic function, and derives rate comparisons in a different replication regime. Gassiat, Le Corff, and Lehéricy [GLCL22] obtain unknown-noise identification and estimation using light-tail signal structure. Their rate arguments must be read together with the authors' erratum [GLCL-E]. Capitao-Miniconi, Gassiat, and Lehéricy [CGL25, Section 7] explicitly discuss heavier signal tails and increasing numbers of repetitions. Our results address a replication-based direction motivated by those questions. They do not settle the unrestricted heavy-tail problem with exactly two repetitions, and they do not replace finite-dimensional results based on analyticity.

The distinctions among the models are essential. Population and weak-consistency results allow arbitrary signal laws and concentration-only errors. The first statistical theorem uses two bounded anchor channels and a signal second moment. The stronger statistical model in Section 8 uses three bounded anchor channels, retains only a Sobolev condition on the signal, and obtains a common calibration neighborhood from the errors alone. Population identifiability by itself does not assert a uniform quantitative rate. Sections 9 and 10 show why the full stopping distribution can matter beyond its typical maximum.

# 2. Models and main results

Throughout, $d\ge1$ is fixed, $\|\cdot\|$ is the Euclidean norm, and characteristic functions use the convention
$$
\phi_P(t)=\int_{\mathbb R^d}e^{it\cdot x}\,P(dx).
$$
For a density $f$, write $\widehat f=\phi_f$ and
$$
\|f\|_{H^\beta}^2=(2\pi)^{-d}\int_{\mathbb R^d}(1+\|t\|^2)^\beta|\widehat f(t)|^2\,dt.
$$
All logarithms are natural. Constants in inequalities may depend on the displayed fixed class parameters, but never on the noise schedule or sample size unless explicitly stated.

## 2.1. Concentration-only population model

**Definition 1 (concentration class and observation equivalence).** Fix $0 < p < 1$ and finite positive radii $(\ell_j)_{j\ge1}$. Let
$$
\mathcal Q_p(\ell)=\{Q:\text{there is }a\in\mathbb R^d\text{ with }Q(B(a,\ell))\ge p\},
$$
where the ball is closed. A model consists of an arbitrary probability law $P$ and laws $Q_j\in\mathcal Q_p(\ell_j)$, with
$$
Y_j=X+\varepsilon_j,\qquad X\sim P,\quad\varepsilon_j\sim Q_j,
$$
where all errors are mutually independent and independent of $X$. Coordinates within each vector may be dependent. Two models are observationally equivalent if all their finite-dimensional measurement laws agree. They are translation equivalent if some $b\in\mathbb R^d$ satisfies $P=\mathcal L(X'+b)$ and $Q_j=\mathcal L(\varepsilon'_j-b)$ for every $j$.

**Theorem 1 (exact universal concentration threshold).** Every pair of observationally equivalent models in Definition 1 is translation equivalent if and only if
$$
\sum_{j=1}^{\infty}\ell_j^{-1}=\infty.\tag{1}
$$
When the sum converges, there are two distinct smooth centered signal densities, each with second moment one, and one fixed sequence of smooth symmetric errors in the stated classes, which give exactly the same infinite observation law. The two signals are not translates. The same error sequence works for both signals, so revealing these errors does not remove the ambiguity.

The quantifier is universal over the given classes: convergence produces a counterexample, not a claim that every model with a convergent schedule is unidentifiable. The theorem concerns laws, not recovery of one latent realization from one infinite path. The endpoint $p=1$ is excluded; the construction proving necessity uses $1-p>0$.

**Corollary 1 (variance scales and location normalization).** Replace the concentration condition by existence of an error mean and
$$
\mathbb E\|\varepsilon_j-\mathbb E\varepsilon_j\|^2\le\sigma_j^2,
\qquad 0 < \sigma_j < \infty.
$$
Universal identification up to translation holds exactly when $\sum_j\sigma_j^{-1}=\infty$. If all error means are required to be zero, identification is exact. The signal still needs no moments.

**Corollary 2 (population observation with independent stopping).** Let $M$ be an observed positive integer, independent of $X$ and the entire error sequence, with $\Pr(M\ge m)>0$ for every $m$. The population law of $(M,Y_1,\ldots,Y_M)$ has the same identification criterion as Theorem 1. The analogous assertion holds for Corollary 1.

## 2.2. Two-anchor benchmark with geometric counts

This first quantitative theorem records the two-anchor route. The tail-unrestricted three-anchor extension is stated in Definition 3 and Corollary 5; both sets of assumptions are retained explicitly.

**Definition 2 (geometric repeated-measurement experiment).** Fix $\beta>0$, $A\ge1$, $0 < \rho < 1$, $V\ge1$, and a known deterministic schedule
$$
1\le\sigma_1\le\sigma_2\le\cdots,\qquad\sigma_2\le A.
$$
For each subject $i=1,\ldots,n$, draw $X_i$ independently with density $f$, draw errors independently across all $(i,j)$ and independently of all signals, with the same law $Q_j$ across subjects, and observe
$$
\mathcal O_i=(M_i,Y_{i1},\ldots,Y_{iM_i}),\qquad Y_{ij}=X_i+\varepsilon_{ij}.
$$
The counts $M_i$ are mutually independent, independent of all signals and errors, and satisfy $\Pr(M_i\ge m)=\rho^{m-1}$. The errors are unknown and satisfy $\mathbb E\varepsilon_{ij}=0$ and $\mathbb E\|\varepsilon_{ij}\|^2\le\sigma_j^2$. They need not have densities, be symmetric, share a distribution, or have nonvanishing characteristic functions. The signal class is
$$
\mathcal F_{\beta,L,V}=\{f\ge0:\int f=1,\ \|f\|_{H^\beta}\le L,\ \int\|x\|^2f(x)\,dx\le V\}.
$$
Estimators take values in real $L^2(\mathbb R^d)$; nonnegativity of the estimator is not imposed. Define $S_k=\sum_{j=1}^k\sigma_j^{-1}$ and $k_n=\max\{2,\lfloor\log n\rfloor\}$.

To state a fully explicit nondegenerate signal class, set
$$
Q_d=d^{d/2}\left(\frac16+\frac5{4\pi^2}\right)^d,\qquad R_d=\pi d,
$$
and
$$
L_0^2=Q_d\left[(1+R_d^2)^\beta+\frac18(1+R_d)^{2\beta}\right].\tag{2}
$$

**Theorem 2 (matching minimax risk under geometric stopping).** In Definition 2, assume $L\ge L_0$. There are $c,C>0$ and $n_0$, depending only on $d,\beta,L,V,A,\rho$, such that for every admissible schedule and $n\ge n_0$,
$$
c(1+S_{k_n})^{-2\beta}
\ \le\ \inf_{\widetilde f}\sup_{f\in\mathcal F_{\beta,L,V},\,(Q_j)}
\mathbb E\|\widetilde f-f\|_2^2
\ \le\ C(1+S_{k_n})^{-2\beta}.\tag{3}
$$
The supremum ranges over the unknown errors in Definition 2. The lower bound holds even when a single admissible sequence of errors is fixed and revealed to the estimator. The upper bound is attained by the explicit Fourier estimator in Section 5 using only subjects with sufficiently many measurements. This is a rate equivalence, not a claim about optimal leading constants.

**Corollary 3 (polynomial scale schedules).** If $\sigma_j=j^a$, with fixed $a\ge0$ and $A\ge2^a$, the risk in (3) has the following orders as $n\to\infty$:

| Scale exponent | Minimax squared $L^2$ risk |
|:--|:--|
| $0\le a < 1$ | $(\log n)^{-2\beta(1-a)}$ |
| $a=1$ | $(\log\log n)^{-2\beta}$ |
| $a>1$ | $1$ |

The critical schedule $a=1$ is consistently estimable, although its worst-case convergence is only iterated logarithmic. For $a>1$, the same schedule also fails universal identification in Corollary 1.

# 3. Concentration and population identification

## 3.1. A Fourier frequency controlled by concentration

**Lemma 1 (concentration annulus).** Let $Q\in\mathcal Q_p(\ell)$, let $v$ be a unit vector, and let $0 < r\le\ell^{-1}$. There is $u\in[pr/4,r]$ such that
$$
|\phi_Q(uv)|>p/4.\tag{4}
$$

*Proof.* Choose a center $a$ from the definition, and put $Z=v\cdot\varepsilon$, $a_v=v\cdot a$. With $\operatorname{sinc}(x)=\sin(x)/x$ and its continuous value at zero, the triangular Fourier identity and bounded Fubini give
$$
\mathbb E\operatorname{sinc}^2\!\left(\frac{r(Z-a_v)}2\right)
=\frac1r\int_{-r}^{r}(1-|t|/r)e^{-ita_v}\phi_Q(tv)\,dt.\tag{5}
$$
Indeed, integrating the two exponentials, or squaring the transform of a uniform interval, gives the identity pointwise before expectation. On the concentration event, $|r(Z-a_v)/2|\le1/2$. The elementary bound $\sin x/x\ge1-x^2/6$ for $|x|\le1/2$ implies that the left side exceeds $3p/4$.

If (4) failed, Hermitian symmetry would bound the characteristic function by $p/4$ on both outer intervals. The normalized triangular integral over $|t| < pr/4$ has absolute value at most $p/2$, using $|\phi_Q|\le1$. On the remaining part it is at most $p/4$, since the total normalized triangular weight is one. This contradicts (5). No moment or known-center assumption was used. $\square$

The lemma finds a usable point in an annulus. It does not assert a zero-free interval uniform over the concentration class. Each individual characteristic function is, of course, nonzero in some neighborhood of zero by continuity.

## 3.2. Classical local calibration

**Lemma 2 (one common local phase).** If two models have the same observation laws, there are $b\in\mathbb R^d$ and $\delta>0$ such that, for $\|t\| < \delta$,
$$
\phi_P(t)=e^{ib\cdot t}\phi_{P'}(t),\qquad
\phi_{Q'_j}(t)=e^{ib\cdot t}\phi_{Q_j}(t)\quad(j\ge1).\tag{6}
$$
This statement requires no concentration or moment condition.

*Proof.* Write $\phi,\phi'$ for the signal characteristic functions and $\psi_j,\psi'_j$ for the errors. Continuity and value one at zero give a ball on which the six functions for the two signals and first two error channels do not vanish. Marginal equality gives $\psi'_j(t)=r(t)\psi_j(t)$ for every $j$ on that ball, where $r=\phi/\phi'$; this step divides only by $\phi'$, so it is valid even for zeros of another $\psi_j$. Equality of the first two joint laws then gives
$$
r(s+t)=r(s)r(t)
$$
when $s,t,s+t$ lie in a sufficiently small ball. Taking $t=-s$ and using Hermitian symmetry gives $|r(s)|=1$. On a smaller ball choose the continuous argument $\theta$ of $r$ with $\theta(0)=0$ and $|\theta| < \pi/3$. The multiplicative equation makes $\theta(s+t)-\theta(s)-\theta(t)$ an integer multiple of $2\pi$; its magnitude is less than $\pi$, so it is zero. A continuous locally additive real function is locally linear: on each coordinate axis rational subdivision and continuity give $\theta(te_k)=b_kt$, and summing coordinate increments inside a smaller ball gives $\theta(t)=b\cdot t$. Substitute this into the marginal identities. This is the local Kotlarski--Cauchy argument [K67, N07]. $\square$

## 3.3. Global frequency allocation

**Lemma 3 (allocation with a reserved channel).** Suppose $\sum_j\ell_j^{-1}=\infty$. Fix a finite set of excluded channels, a target vector $t$, and a neighborhood on which (6) holds. There are finitely many nonexcluded channels and assigned vectors inside that neighborhood, summing to $t$, such that every assigned unprimed error characteristic function is nonzero.

*Proof.* The case $t=0$ uses an empty allocation. Otherwise write $t=Rv$, $R>0$, $\|v\|=1$. Choose a nonexcluded channel $k$ to reserve. By continuity, shrink a positive $\delta$ so that the closed ball of radius $\delta$ lies inside the phase neighborhood and $|\psi_k(u)|\ge1/2$ on that ball. For every remaining nonexcluded $j\ne k$, set $r_j=\min\{\delta/2,\ell_j^{-1}\}$. Lemma 1 gives $u_j\in[pr_j/4,r_j]$ with $\psi_j(u_jv)\ne0$.

The sum of $r_j$ diverges: either infinitely many inverse scales exceed $\delta/2$, or deleting finitely many terms leaves their original divergent sum. Deleting the finite excluded set and reserved channel has no effect. Hence $\sum_j u_j=\infty$. Take the first finite partial sum at least $R$. Its excess $e$ is between zero and $\delta/2$, because the last increment is at most $\delta/2$. Assign $u_jv$ to the selected channels and $-ev$ to channel $k$. Their sum is $Rv$, all lie in the required neighborhood, and every relevant error factor is nonzero. $\square$

*Proof of sufficiency in Theorem 1.* Apply Lemma 2, then Lemma 3 to any $t$. For the selected finite set, the joint characteristic function is $\phi(t)\prod_j\psi_j(u_j)$. Under the primed model the product of error factors is $e^{ib\cdot t}\prod_j\psi_j(u_j)$. Equality of the observation laws and cancellation of that nonzero product give $\phi(t)=e^{ib\cdot t}\phi'(t)$ globally.

To recover the $j$th error at an arbitrary $t$, exclude channel $j$ and use Lemma 3 to allocate $-t$ among other channels. In the joint characteristic function, give channel $j$ the vector $t$. The total signal frequency is zero, so both signal factors equal one. Cancelling only the auxiliary nonzero error factors gives $\psi'_j(t)=e^{ib\cdot t}\psi_j(t)$. Characteristic-function uniqueness proves the asserted translations for every law. No division at a zero of the signal or the target error is needed. $\square$

# 4. Explicit spectral obstruction

The construction here makes both the population necessity and the statistical lower bound explicit. Its mechanism is the classical compact-spectrum obstruction [K67, N07], applied to a heterogeneous sum of accessible frequencies.

## 4.1. A centered compact-spectrum density

**Lemma 4 (explicit density).** Define
$$
q_0(x)=\frac{4\cos^2(\pi x/2)}{\pi^2(1-x^2)^2}\quad(x\ne\pm1),\qquad q_0(\pm1)=\frac14.
$$
It is a smooth symmetric probability density of variance one, with characteristic function
$$
\chi_0(t)=
\begin{cases}
(1-|t|/\pi)\cos|t|+\sin|t|/\pi,& |t|\le\pi,\\
0,&|t|>\pi.
\end{cases}\tag{7}
$$
Moreover, $\|q_0\|_2^2=1/6+5/(4\pi^2)$. The density
$$
q_d(x)=d^{d/2}\prod_{k=1}^d q_0(\sqrt d\,x_k)\tag{8}
$$
is centered, has $\int\|x\|^2q_d(x)\,dx=1$, satisfies $\|q_d\|_2^2=Q_d$, and has Fourier support in $[-a_d,a_d]^d$, where $a_d=\pi\sqrt d$. This cube lies in the Euclidean ball of radius $R_d=\pi d$.

*Proof.* Let $b(u)=\cos u$ on $[-\pi/2,\pi/2]$ and zero elsewhere. Direct integration gives
$$
h(x)=\int b(u)e^{-ixu}\,du=\frac{2\cos(\pi x/2)}{1-x^2}.
$$
The apparent singularities are removable with $h(\pm1)=\pi/2$. The integral representation shows that $h$ is smooth. Plancherel gives $\int|h|^2=2\pi\int|b|^2=\pi^2$. Since $b$ vanishes at its endpoints and has square-integrable weak derivative $-\sin u$ inside the interval, the derivative form of Plancherel gives $\int x^2|h(x)|^2\,dx=2\pi\int|b'|^2=\pi^2$. Thus $q_0=h^2/\pi^2$ is normalized and has variance one; symmetry gives mean zero.

The product-to-convolution identity yields $\chi_0(t)=(2/\pi)\int b(u)b(u+t)\,du$. For $0\le t\le\pi$, integrating $\cos u\cos(u+t)$ on the intersection interval gives $(1-t/\pi)\cos t+\sin t/\pi$. The supports are disjoint for $|t|>\pi$, proving (7). Another application of Plancherel gives
$$
\|q_0\|_2^2=\frac1\pi\int_0^\pi\left[(1-t/\pi)\cos t+\frac{\sin t}{\pi}\right]^2dt
=\frac16+\frac5{4\pi^2},
$$
by expanding the square and integrating the elementary trigonometric terms. Taking products and rescaling proves (8) and all stated constants. $\square$

This explicit density has finite absolute moments of order less than three; it is not an all-moments example. Only its second moment is needed below.

## 4.2. Modulation alternatives and finite-prefix masking

**Lemma 5 (Sobolev alternatives).** For $T>2a_d$ and $0 < \eta\le1/2$, put $\delta_T=\eta(1+T)^{-\beta}$ and
$$
f_{\pm,T}(x)=q_d(x)\{1\pm\delta_T\cos(Tx_1)\}.\tag{9}
$$
These are smooth centered probability densities of second moment one. They belong to $\mathcal F_{\beta,L,V}$ whenever $V\ge1$ and $L\ge L_0$, and
$$
\|f_{+,T}-f_{-,T}\|_2^2=2\eta^2(1+T)^{-2\beta}Q_d.\tag{10}
$$

*Proof.* Nonnegativity follows from $\delta_T\le1/2$. Their Fourier transforms are
$$
\widehat q_d(t)\ \pm\ \frac{\delta_T}{2}\{\widehat q_d(t+Te_1)+\widehat q_d(t-Te_1)\}.\tag{11}
$$
The three supports are disjoint because $T>2a_d$, and the perturbation vanishes on a neighborhood of zero. Its mass is therefore zero. Since the perturbation has a finite second absolute moment, the first and second derivatives of its Fourier transform at zero give its moments; all these derivatives vanish. The two signals consequently have the same zero mean and second moment as $q_d$.

Disjointness in (11) and Plancherel give (10). On the central support the squared Sobolev weight is bounded by $(1+R_d^2)^\beta$. On either shifted support it is bounded by $(1+(T+R_d)^2)^\beta$. As $1+(T+R_d)^2\le(1+T)^2(1+R_d)^2$, we obtain
$$
\|f_{\pm,T}\|_{H^\beta}^2
\le Q_d\left[(1+R_d^2)^\beta+\frac{\eta^2}{2}(1+R_d)^{2\beta}\right]\le L_0^2.
$$
This proves the class inclusion. $\square$

**Lemma 6 (finite-prefix invisibility).** Let errors have laws $\varepsilon_j=c_jZ_j$, where $c_j>0$ and the $Z_j$ are independent with density $q_d$. The two signals in (9) give exactly the same first $k$ measurement law whenever
$$
T>a_d\sum_{j=1}^k c_j^{-1}+2a_d.\tag{12}
$$

*Proof.* The joint characteristic function at $(t_1,\ldots,t_k)$ is
$$
\widehat f\!\left(\sum_{j=1}^k t_j\right)\prod_{j=1}^k\widehat q_d(c_jt_j).
$$
If any error factor vanishes the two expressions agree at zero. Otherwise each first coordinate satisfies $|(t_j)_1|\le a_d/c_j$, so the first coordinate of their sum has magnitude at most $a_d\sum_{j\le k}c_j^{-1}$. The difference of the signal transforms in (11) is supported where the magnitude of that coordinate is at least $T-a_d$, strictly beyond this interval by (12). Thus the joint characteristic functions agree everywhere, and uniqueness proves equality of the full $k$-vector laws. $\square$

## 4.3. Necessity and the population corollaries

*Proof of necessity in Theorem 1.* Suppose $S_\infty^\ell=\sum_j\ell_j^{-1} < \infty$. Use the fixed centered error sequence
$$
\varepsilon_j=\ell_j\sqrt{1-p}\,Z_j,\qquad Z_j\sim q_d.
$$
Markov's inequality for $\|\varepsilon_j\|^2$ gives $\Pr(\|\varepsilon_j\|\le\ell_j)\ge p$, so these errors are admissible. Fix any $\beta>0$ and $\eta\in(0,1/2]$, and choose
$$
T>\frac{a_d}{\sqrt{1-p}}S_\infty^\ell+2a_d.
$$
Lemma 6 proves equality of every prefix law for the signals in (9), and hence of every finite-dimensional law. Cylinder sets generate the Borel sigma-field of $(\mathbb R^d)^{\mathbb N}$, so their infinite laws also agree. By (10) the signals differ. Both have mean zero; a translation between them would therefore have to be zero, which is impossible. All chosen densities are smooth and have the moments stated in Theorem 1. $\square$

*Proof of Corollary 1.* In the divergent case, Chebyshev's inequality gives $Q_j\in\mathcal Q_{3/4}(2\sigma_j)$ with center $\mathbb E\varepsilon_j$. Apply Theorem 1. Conversely use errors $\sigma_jZ_j$ in Lemma 6 and choose $T>a_d\sum_j\sigma_j^{-1}+2a_d$ when the sum converges. These errors are centered and have second moments exactly $\sigma_j^2$. Finally, if both models have centered errors, the common translation from Theorem 1 is zero by taking an error mean. No signal mean is needed for this last argument. $\square$

*Proof of Corollary 2.* Conditioning on $\{M\ge m\}$ recovers the unselected first $m$ measurement law, by independence and positive probability. Thus the stopped population law determines every prefix law. Conversely, equality of every prefix law implies equality of the stopped law after mixing over the same count distribution. This proves both directions of the claimed criterion. $\square$

# 5. Constructive statistical upper bound

The local derivative-ratio identity and exponential reconstruction below are classical in repeated-measurement estimation [CK15 and references therein]. We give all stability details needed for heterogeneous errors, two moments, and reuse of the same observations across factors.

## 5.1. Uniform local calibration

Set
$$
\delta=\min\left\{1,\frac1{8(\sqrt V+1)},\frac1{8(A+1)}\right\},
\qquad K=V+A^2.
$$
For $N\ge1$ independent complete records with at least two repetitions, write $\phi=\widehat f$, $\psi_j=\phi_{Q_j}$, and
$$
H_j(u)=\mathbb E e^{iu\cdot Y_j}=\phi(u)\psi_j(u),\qquad
G(u)=i\mathbb E[Y_2e^{iu\cdot Y_1}].
$$

**Lemma 7 (local derivative identity and stable inverse).** For $\|u\|\le\delta$, $|\phi(u)-1|\le1/8$ and $|\psi_j(u)-1|\le1/8$ for $j=1,2$. Moreover
$$
G(u)=\nabla\phi(u)\psi_1(u),\qquad |H_1(u)|\ge49/64.\tag{13}
$$
Define the complex-valued stable inverse
$$
D(z)=\frac{\overline z}{\max\{|z|^2,1/16\}}.
$$
It satisfies $|D(z)|\le4$, is globally Lipschitz with constant at most $32$, and equals $1/z$ when $|z|\ge1/4$.

*Proof.* The inequality $|e^{ix}-1|\le|x|$ and Cauchy--Schwarz give the local bounds. Differentiate $\phi$ under the integral using the finite first moment of $X$. Expanding $Y_2=X+\varepsilon_2$, independence and $\mathbb E\varepsilon_2=0$ give (13). The product lower bound is $(7/8)^2$. Inside the circle of radius $1/4$, $D(z)=16\overline z$; outside it, $D(z)=1/z$. The real differential of the latter has operator norm $|z|^{-2}\le16$. The formulas agree on the circle. Along any line segment, split at its at most two circle intersections and integrate these derivative bounds; a Lipschitz constant $16$, and therefore $32$, follows. The magnitude and exact-inverse statements follow directly. $\square$

Let $\widehat H_{j,N}$ and $\widehat G_N$ be the corresponding empirical means and let
$$
\widehat R_N(u)=\widehat G_N(u)D(\widehat H_{1,N}(u)),\qquad
R(u)=G(u)/H_1(u)=\nabla\phi(u)/\phi(u).
$$
Let $\Pi$ denote Euclidean projection in $\mathbb C$ onto the closed unit disk, and define
$$
\widehat A_N(u)=\int_0^1 u\cdot\widehat R_N(vu)\,dv,
\qquad A(u)=\int_0^1u\cdot R(vu)\,dv,
$$
$$
\ell_N(u)=\Pi\!\left(\exp\{\Pi(\widehat A_N(u))\}\right).\tag{14}
$$

**Lemma 8 (local mean-square error with two moments).** Uniformly over Definition 2 and $\|u\|\le\delta$,
$$
\mathbb E|\ell_N(u)-\phi(u)|^2\le C/N,\qquad |\ell_N(u)|\le1.\tag{15}
$$
The construction is measurable and satisfies $\ell_N(-u)=\overline{\ell_N(u)}$.

*Proof.* Empirical-mean variances give $\mathbb E|\widehat H_{1,N}-H_1|^2\le1/N$ and $\mathbb E\|\widehat G_N-G\|^2\le K/N$: indeed $\mathbb E\|Y_2\|^2\le V+A^2$ because the error is centered and independent. Also $\|G\|\le\mathbb E\|Y_2\|\le\sqrt K$. Write
$$
\widehat R_N-R=(\widehat G_N-G)D(\widehat H_{1,N})
+G\{D(\widehat H_{1,N})-D(H_1)\}.
$$
Lemma 7 and the two variance bounds imply $\mathbb E\|\widehat R_N-R\|^2\le C/N$. There is no independence requirement between these empirical means. Jensen's inequality along the unit interval then gives
$$
\mathbb E|\widehat A_N(u)-A(u)|^2\le C\|u\|^2/N.\tag{16}
$$
As $\|\nabla\phi\|\le\sqrt V$ and $|\phi|\ge7/8$, one has $|A(u)|\le(8/7)\delta\sqrt V < 1$. For the nonvanishing differentiable function $z(v)=\phi(vu)$, differentiation shows that $z(v)\exp\{-\int_0^v z'(w)/z(w)\,dw\}$ is identically one. Consequently $\exp A(u)=\phi(u)$, with no choice of a global logarithm branch.

Projection onto a closed convex disk is nonexpansive and fixes both $A(u)$ and $\phi(u)$ in their respective disks. The exponential map is $e$-Lipschitz on that disk, as follows by integration along the line segment between two arguments. Apply these facts to (16) to obtain (15). For finite data all integrands are continuous in $u$, hence jointly measurable. Empirical conjugation gives $\widehat H(-u)=\overline{\widehat H(u)}$ and $\widehat G(-u)=-\overline{\widehat G(u)}$, so $\widehat A_N(-u)=\overline{\widehat A_N(u)}$ and all remaining operations preserve the stated symmetry. $\square$

## 5.2. Reconstruction by small channel frequencies

For $m\ge2$ complete measurements per subject, put $c_* =\min\{\delta/2,1/8\}$, $T_m=c_*S_m$, and, when $\|t\|\le T_m$, define
$$
u_j(t)=\frac{t}{\sigma_jS_m},\qquad j=1,\ldots,m.
$$
Then $\sum_j u_j=t$, $\|u_j\|\le\delta$, and $\sigma_j\|u_j\|\le1/8$. In particular, $|\psi_j(u_j)-1|\le1/8$ and $|H_j(u_j)|\ge49/64$ for every selected channel. Define
$$
J_m(t)=\mathbb E\exp\left(i\sum_{j=1}^m u_j(t)\cdot Y_j\right).
$$
Independence yields the exact identity
$$
\phi(t)=J_m(t)\prod_{j=1}^m\frac{\phi(u_j(t))}{H_j(u_j(t))}.\tag{17}
$$
This identity makes no assumption about $\phi(t)$ at the high frequency.

Using the same $N$ complete records for every factor, form $\widehat J_{m,N}$ and the empirical marginal functions and set
$$
\widehat a_j(t)=\ell_N(u_j(t))D(\widehat H_{j,N}(u_j(t))),
\qquad
\widehat F_{m,N}(t)=\Pi\left(\widehat J_{m,N}(t)\prod_{j=1}^m\widehat a_j(t)\right).
$$

**Lemma 9 (finite-product error).** For $\|t\|\le T_m$,
$$
\mathbb E|\widehat F_{m,N}(t)-\phi(t)|^2\le C m^2 16^m/N.\tag{18}
$$

*Proof.* The true factor $a_j=\phi(u_j)/H_j(u_j)=1/\psi_j(u_j)$ has magnitude at most $8/7$, whereas $|\widehat a_j|\le4$. Lemmas 7 and 8, the decomposition of a two-factor product, and $\mathbb E|\widehat H_{j,N}-H_j|^2\le1/N$ give $\mathbb E|\widehat a_j-a_j|^2\le C/N$ uniformly in $j$. Also $\mathbb E|\widehat J_{m,N}-J_m|^2\le1/N$ and $|J_m|\le1$. Telescoping (17) bounds the unprojected error by
$$
4^m|\widehat J_{m,N}-J_m|+4^{m-1}\sum_{j=1}^m|\widehat a_j-a_j|.
$$
Square, use Cauchy--Schwarz on the finite sum, and take expectations. Projection cannot increase the error relative to $\phi(t)$, which lies in the unit disk. This proves (18) without independence between estimated factors or sample splitting. $\square$

**Proposition 1 (fixed-replication statistical bound).** The estimator
$$
\widehat f_{m,N}(x)=(2\pi)^{-d}\int_{\|t\|\le T_m}e^{-it\cdot x}\widehat F_{m,N}(t)\,dt\tag{19}
$$
is a real $L^2$-valued measurable estimator, and
$$
\mathbb E\|\widehat f_{m,N}-f\|_2^2
\le L^2(1+T_m^2)^{-\beta}+C T_m^d m^2 16^m/N.\tag{20}
$$
Equivalently it is at most $C[(1+S_m)^{-2\beta}+S_m^d m^2 16^m/N]$. This bound needs $\sigma_j\ge1$ and the two anchor bounds, but not monotonicity of the remaining schedule.

*Proof.* The estimated spectrum is bounded, compactly supported, and jointly measurable in data and frequency. Its inverse Fourier transform is therefore an $L^2$ random element; separability of $L^2$ and the isometric Fourier map justify strong measurability. Hermitian symmetry of every factor and of $D$ and $\Pi$ makes the inverse transform real. Plancherel separates the risk into the integrated error inside the radius $T_m$ and the true spectral energy outside it. Tonelli and (18) bound the first by the second term of (20). The Sobolev bound gives the first term of (20) for the tail. Finally, $T_m=c_*S_m$ and fixed $c_*>0$ imply the equivalent displayed bound. $\square$

## 5.3. Random complete-case sample size

**Lemma 10 (binomial reciprocal).** If $N\sim\operatorname{Bin}(n,\pi)$, $\pi>0$, then
$$
\mathbb E[1/N;N>0]\le\frac{2}{(n+1)\pi},\qquad
\Pr(N=0)\le e^{-n\pi}.\tag{21}
$$

*Proof.* For positive integers $N$, $1/N\le2/(N+1)$. Integrating $\mathbb E[t^N]=(1-\pi+\pi t)^n$ from zero to one gives
$$
\mathbb E\frac1{N+1}=\frac{1-(1-\pi)^{n+1}}{(n+1)\pi}.
$$
The zero-count probability is $(1-\pi)^n\le e^{-n\pi}$. $\square$

*Proof of the upper bound in Theorem 2.* Let
$$
\kappa=\{4\log(16/\rho)\}^{-1},\qquad m=\lfloor\kappa\log n\rfloor,
$$
and take $n$ large enough that $m\ge2$. Select the subjects with $M_i\ge m$ and use only their first $m$ measurements in (19). Since counts are independent, conditional on the selected indices these are independent complete records from the original model. Their number has law $N\sim\operatorname{Bin}(n,\pi_m)$, $\pi_m=\rho^{m-1}$. For $N=0$, use the zero $L^2$ function, whose squared loss is at most $L^2$. Proposition 1 and Lemma 10 give
$$
\mathbb E\|\widehat f-f\|_2^2
\le C\left[(1+S_m)^{-2\beta}+\frac{S_m^d m^2 16^m}{n\pi_m}\right]+L^2e^{-n\pi_m}.\tag{22}
$$
By our choice of $\kappa$,
$$
16^m/\pi_m=\rho(16/\rho)^m\le n^{1/4},\qquad n\pi_m\ge n^{3/4}
$$
for sufficiently large $n$ (the second inequality follows from $\kappa|\log\rho| < 1/4$). Also $S_m\le m$. Thus the stochastic terms in (22) are bounded by $C(\log n)^{d+2}n^{-3/4}+L^2e^{-n^{3/4}}$.

For a nonincreasing nonnegative sequence $a_j=\sigma_j^{-1}$ and integers $m\le k$, the average of its first $m$ terms is at least the average of its first $k$ terms. Hence $S_m\ge(m/k)S_k$. For all sufficiently large $n$, $m\le k_n$ and $m/k_n\ge\kappa/2$. The bias in (22) is therefore at most $C(1+S_{k_n})^{-2\beta}$. Since $S_{k_n}\le k_n\le\log n$, the target is at least $(1+\log n)^{-2\beta}$, which absorbs the displayed stochastic remainder uniformly in the schedule. This proves the required upper bound. $\square$

# 6. Lower bound for the full random-length experiment

The next elementary testing inequality makes explicit why exceptionally long records cannot defeat the lower bound.

**Lemma 11 (common-event Hilbert bound).** Suppose two observation laws share the same restricted measure on an observable event $E$ of mass $w$. For two targets $f_+,f_-$ in a real Hilbert space and any estimator $\widetilde f$,
$$
\max_{s\in\{+,-\}}\mathbb E_s\|\widetilde f-f_s\|^2
\ge \frac w4\|f_+-f_-\|^2.\tag{23}
$$

*Proof.* Pointwise, the sum of the two squared errors equals twice the squared distance to the midpoint plus $\|f_+-f_-\|^2/2$. Integrate over the common restricted measure, discard losses outside $E$, and bound the maximum by half the sum. The same argument covers randomized estimators by adjoining their common independent randomization. $\square$

*Proof of the lower bound in Theorem 2.* Fix the same known error sequence under both alternatives:
$$
Q_j=\mathcal L(\sigma_jZ),\qquad Z\text{ has density }q_d.
$$
These errors satisfy the exact second-moment bounds and have zero means. Put
$$
h=\left\lceil\frac{\log(4n)}{|\log\rho|}\right\rceil,\qquad
T=a_dS_h+2a_d+1,
$$
and take (9) with $\eta=1/2$. Lemma 5 places the two signals in the stated class. Lemma 6 shows that their first $h$ measurement laws, and therefore every shorter prefix law, coincide exactly.

Consider the event $E=\{M_i\le h\text{ for every }i\}$. Its probability is at least $1-n\rho^h\ge3/4$. Conditional on any count vector in $E$, each subject has an identical observed prefix law under the two alternatives; independence across subjects and the common count law show that the entire experiment has the same restricted measure on $E$. Apply Lemma 11 and (10):
$$
\inf_{\widetilde f}\sup_{f,Q}\mathbb E\|\widetilde f-f\|_2^2
\ge\frac{3}{16}\|f_{+,T}-f_{-,T}\|_2^2
\ge c(1+S_h)^{-2\beta}.\tag{24}
$$
This is a bound on the full experiment, which still contains all longer records outside $E$. Revealing the error sequence does not alter its proof.

For a constant $C_\rho$ and sufficiently large $n$, $h\le C_\rho k_n$. If $h\le k_n$ then $S_h\le S_{k_n}$. Otherwise the same decreasing-average inequality used in the upper bound gives $S_h\le(h/k_n)S_{k_n}$. Thus $S_h\le\max\{1,C_\rho\}S_{k_n}$, and (24) is at least a fixed multiple of $(1+S_{k_n})^{-2\beta}$. This completes Theorem 2. $\square$

*Proof of Corollary 3.* Integral comparisons for $\sum_{j\le k}j^{-a}$ give order $k^{1-a}$ for $0\le a < 1$, order $\log k$ for $a=1$, and a finite positive limit for $a>1$. Substitute $k=k_n$ into (3). The assertion about identification follows from convergence or divergence of the same series in Corollary 1. $\square$

# 7. Weak stability and joint consistency without moments

We now strengthen the population conclusion without adding any moment assumption. The weak minimum-distance strategy and minimization over location shifts are established in Neumann [N07, Theorem 2.1]. We adapt that strategy to the countable heterogeneous concentration model, verifying the closedness and compactness properties needed to obtain an exact equivalence.

Let $\tau_bP$ be translation by $b$, and let $d_{\mathrm{BL}}$ be the bounded-Lipschitz metric on probability laws on $\mathbb R^d$, using test functions bounded by one with Lipschitz constant at most one. It is bounded by two, metrizes weak convergence, and is invariant under simultaneous translation. For
$$
\Theta=\mathcal P(\mathbb R^d)\times\prod_{j\ge1}\mathcal Q_p(\ell_j),
\qquad T_b(P,(Q_j))=(\tau_bP,(\tau_{-b}Q_j)),
$$
put
$$
D_\Theta(\theta,\eta)=d_{\mathrm{BL}}(P,P')+\sum_{j\ge1}2^{-j}d_{\mathrm{BL}}(Q_j,Q'_j),
\qquad
\overline D([\theta],[\eta])=\inf_{b\in\mathbb R^d}D_\Theta(\theta,T_b\eta).\tag{25}
$$
The brackets denote common-translation orbits. Fix any known count law $w_m=\Pr(M=m)$, independent of the latent variables, with $M$ finite almost surely and $\pi_j=\Pr(M\ge j)>0$ for every $j$. Individual $w_m$ may vanish. The observation space is the Polish disjoint union
$$
\Omega=\coprod_{m\ge1}(\{m\}\times(\mathbb R^d)^m),
$$
with distance one between components and distance $\min\{1,\|y-z\|\}$ within a component. Let $d_\Omega$ metrize weak convergence of laws on this space, and write $F(\theta)$ for the stopped observation law.

**Lemma 12 (closed classes and a genuine quotient metric).** Each $\mathcal Q_p(\ell)$ is weakly closed; $\Theta$ is a separable Polish space in its product weak topology. The expression $\overline D$ is a metric on the orbit space and gives its quotient topology.

*Proof.* If $Q_n\Rightarrow Q$ and $Q_n(B(a_n,\ell))\ge p$, uniform tightness supplies $R$ with $Q_n(B(0,R)^c) < p/2$ for every $n$. Thus $\|a_n\|\le R+\ell$. Pass to a subsequence $a_n\to a$. For each $\epsilon>0$, eventually $B(a_n,\ell)\subseteq B(a,\ell+\epsilon)$. Portmanteau for the closed enlarged ball gives mass at least $p$ in the limit. Continuity from above as $\epsilon\downarrow0$ proves $Q\in\mathcal Q_p(\ell)$. The assertion about $\Theta$ follows from closedness in a countable product of Polish spaces.

The translation action is isometric in $D_\Theta$, so (25) is well-defined, symmetric, and satisfies the triangle inequality. If its value is zero, take $b_n$ with $D_\Theta(\theta,T_{b_n}\eta)\to0$. Then $\tau_{b_n}P'\Rightarrow P$. A ball containing more than three quarters of $P'$ and a ball containing more than three quarters of every $\tau_{b_n}P'$ must intersect after the shift, so $(b_n)$ is bounded. Along a convergent subsequence $b_n\to b$, continuity of translations yields $\theta=T_b\eta$. Thus distinct orbits have positive distance. The orbit projection is continuous since $\overline D\le D_\Theta$ and is open: the image of each $D_\Theta$ ball is exactly the corresponding quotient ball, by the infimum definition and translation isometry. This proves the topology assertion. $\square$

**Lemma 13 (tightness of all factors modulo one translation).** For a sequence of additive independent-factor models, suppose each fixed marginal family $(\mathcal L(Y_{n,j}))_n$ is uniformly tight. There are deterministic $a_n$ such that $(\mathcal L(X_n-a_n))_n$ and each $(\mathcal L(\varepsilon_{n,j}+a_n))_n$ are uniformly tight. No moments or concentration assumptions are required.

*Proof.* Choose $R_0$ such that $\Pr(\|Y_{n,1}\|\le R_0)>3/4$ uniformly. Conditioning on $\varepsilon_{n,1}$ and using independence gives a center $a_n$ with $\Pr(X_n\in B(a_n,R_0))>3/4$. For any $0 < \epsilon < 1/4$, tightness similarly supplies $R_\epsilon$ and centers $a_{n,\epsilon}$ with $\Pr(X_n\in B(a_{n,\epsilon},R_\epsilon))>1-\epsilon$. The two balls have probabilities summing to more than one and must intersect. Hence their centers are within $R_0+R_\epsilon$, and
$$
\Pr(\|X_n-a_n\|\le R_0+2R_\epsilon)>1-\epsilon.
$$
This proves tightness using the same $a_n$ at every accuracy. For each fixed $j$, the identity $\varepsilon_{n,j}+a_n=Y_{n,j}-(X_n-a_n)$ and the union bound prove the remaining tightness assertions. $\square$

**Lemma 14 (continuous forward map with closed image).** The map $F$ is continuous and $F(\Theta)$ is weakly closed, for every scale schedule.

*Proof.* Coordinatewise weak convergence of parameters gives weak convergence of every finite independent product and its vector of sums. Mixing finitely many count components preserves convergence; the remaining mass is uniformly bounded by $\sum_{m>K}w_m\to0$. This proves continuity.

Suppose $F(\theta_n)\Rightarrow\mu$. The count projection preserves the fixed count law. For bounded continuous $g$ on $\mathbb R^d$, the function $(m,y)\mapsto\mathbf1_{\{m\ge j\}}g(y_j)$ is continuous and bounded on the disjoint union. Dividing its integral by the fixed positive $\pi_j$ recovers convergence of the $j$th measurement marginal. Apply Lemma 13 and Prokhorov's theorem to every shifted parameter coordinate. A countable diagonal subsequence converges coordinatewise; Lemma 12 keeps its limit $\theta_*$ in $\Theta$. The geometric weights in (25) upgrade coordinatewise convergence to $D_\Theta$ convergence. Continuity and translation invariance give $F(\theta_*)=\mu$, proving closedness. $\square$

**Theorem 3 (identification, stable inversion, and joint consistency).** In the concentration model with the fixed count law above, the following are equivalent:

1. $\sum_j\ell_j^{-1}=\infty$.
2. The signal and all error laws are identifiable modulo common translation.
3. $F$ induces a homeomorphism from the orbit space onto its weakly closed image.
4. There exists a measurable estimator sequence that, from independent identically distributed stopped records, is almost surely consistent in $\overline D$ at every parameter in $\Theta$.

*Proof.* Theorem 1 and Corollary 2 give the equivalence of the first two statements. Under divergence, consider $F(\theta_n)\Rightarrow F(\theta)$. If the quotient distances did not tend to zero, some subsequence would remain separated by a positive distance. The tightness and diagonal argument in Lemma 14 yields a further subsequence of commonly shifted parameters converging to $\theta_*$ with $F(\theta_*)=F(\theta)$. Identification makes $\theta_*$ a translate of $\theta$, contradicting that separation. This proves inverse continuity. Forward continuity on the quotient follows by choosing near-minimizing translations in (25). Lemma 14 supplies the closed image.

To prove consistency, take a countable dense family $(\theta_r)$ in $\Theta$, put $\mu_r=F(\theta_r)$, and let $\widehat\mu_n$ be the empirical measure of the stopped records. Choose the least integer $r_n$ satisfying
$$
d_\Omega(\widehat\mu_n,\mu_{r_n})\le\inf_{r\ge1}d_\Omega(\widehat\mu_n,\mu_r)+1/n.
$$
The countable infimum and first-index choice are measurable, and the index exists by the definition of an infimum. For every true $\theta$, density and continuity imply
$$
d_\Omega(F(\theta_{r_n}),F(\theta))
\le2d_\Omega(\widehat\mu_n,F(\theta))+1/n\longrightarrow0
\quad\text{almost surely}.\tag{26}
$$
Here the empirical weak law on a Polish space follows from the strong law on a countable convergence-determining class. In this disjoint union it can also be proved componentwise on continuity rectangles, followed by controlling the mass outside finitely many count components. Inverse continuity applied to (26) proves statement 4.

If the reciprocal-scale sum is finite, the nontranslation-equivalent pair in Theorem 1 has identical stopped laws. Two disjoint quotient balls around this pair cannot both receive estimator probabilities tending to one under the same observation law. Thus even simultaneous pointwise consistency in probability is impossible. This proves necessity for statement 4 and completes all equivalences. $\square$

This is pointwise weak consistency of the signal and every error law, allowing a common sample-size-dependent translation. It does not assert a uniform modulus, a uniform rate, total-variation or density-risk convergence, or finite-time computability of the countable minimum-distance estimator.

# 8. Statistical calibration with no signal moments

We next remove every signal moment assumption from the quantitative experiment. Three bounded anchor channels replace the two-anchor requirement in Definition 2. The cancellation by differences is classical [K67, Lemma 1 and Remarks 3, 5]; the result here is its uniform statistical use in the heterogeneous, random-length experiment.

**Definition 3 (tail-unrestricted density class and general counts).** Fix $d\ge1$, $\beta>0$, $L>0$, and $A\ge1$. Let $\sigma_j\ge1$ be a known schedule with $\max_{j\le3}\sigma_j\le A$. Let errors be mutually independent, independent of the signal, centered, and satisfy $\mathbb E\|\varepsilon_j\|^2\le\sigma_j^2$, with unknown laws shared across independent subjects. The signal density belongs to
$$
\mathcal F_{\beta,L}=\{f\ge0:\int f=1,\ \|f\|_{H^\beta}\le L\}.
$$
There is no signal moment, support, centering, tail, or nonvanishing assumption. Counts $M_i$ are mutually independent, independent of all signals and errors, with a fixed known positive tail $\pi_m=\Pr(M_i\ge m)$ tending to zero. Write $H(m)=-\log\pi_m$, $S_m=\sum_{j\le m}\sigma_j^{-1}$, and
$$
R_n(\pi,\sigma)=\inf_{\widetilde f}\sup_{f\in\mathcal F_{\beta,L},(Q_j)}\mathbb E\|\widetilde f-f\|_2^2.
$$
Estimators are real $L^2$-valued. Monotonicity of the scale schedule will be imposed only for the matching theorem, not for the envelopes below.

**Lemma 15 (local noise calibration from differences).** Given $N$ complete records with at least three measurements, there are measurable Hermitian estimates $\widehat\psi_{j,N}(u)$, bounded in magnitude by one, and $\delta_A>0$, depending only on $A$, such that
$$
\sup_{j\le m}\sup_{\|u\|\le\delta_A}\mathbb E|\widehat\psi_{j,N}(u)-\psi_j(u)|^2\le C_A/N.\tag{27}
$$
No moment of $X$ is used.

*Proof.* Set $\delta_A=\min\{1,[8(A+1)]^{-1}\}$ and form observable differences
$$
U=Y_1-Y_2=\varepsilon_1-\varepsilon_2,\qquad W=Y_1-Y_3=\varepsilon_1-\varepsilon_3.
$$
On the radius-$\delta_A$ ball the first three error characteristic functions are within $1/8$ of one. Direct expansion, independence, and centering give
$$
H_\Delta(u)=\mathbb E e^{iu\cdot U}=\psi_1(u)\psi_2(-u),\qquad
G_\Delta(u)=i\mathbb E[We^{iu\cdot U}]=\nabla\psi_1(u)\psi_2(-u).\tag{28}
$$
Thus $|H_\Delta|\ge49/64$, $\|G_\Delta\|\le A$, and $\mathbb E\|W\|^2\le2A^2$. Empirical versions satisfy variance bounds $1/N$ and $2A^2/N$. Define
$$
\widehat R_\Delta=\widehat G_\Delta D(\widehat H_\Delta),\quad
\widehat A_1(u)=\int_0^1u\cdot\widehat R_\Delta(vu)\,dv,\quad
\ell_{1,N}(u)=\Pi(\exp\{\Pi(\widehat A_1(u))\}).
$$
Use exactly the deterministic error decomposition in Lemma 8, with $G_\Delta,H_\Delta$ in place of $G,H_1$. It gives mean-square error $C_A/N$ for the derivative ratio and $C_A\|u\|^2/N$ for its radial integral. The true integral has magnitude at most $(8/7)A\delta_A < 1$, and its exponential equals $\psi_1(u)$ by the same one-dimensional path differential equation. The two projections and the exponential Lipschitz bound therefore give $\mathbb E|\ell_{1,N}(u)-\psi_1(u)|^2\le C_A/N$.

For $j\ne1$, let $C_j(u)=\mathbb E e^{iu\cdot(Y_j-Y_1)}=\psi_j(u)\psi_1(-u)$ and let $\widehat C_{j,N}$ be its empirical mean. Its variance is at most $1/N$ for every $j$. Set
$$
\widehat\psi_{1,N}=\ell_{1,N},\qquad
\widehat\psi_{j,N}(u)=\Pi\{\widehat C_{j,N}(u)D(\ell_{1,N}(-u))\}\quad(j\ne1).\tag{29}
$$
Because $|\psi_1(-u)|\ge7/8$, the unestimated expression equals $\psi_j(u)$. Decompose the error into $(\widehat C_j-C_j)D(\ell_1)$ plus $C_j[D(\ell_1)-D(\psi_1)]$. The bounds on $D$, its Lipschitz constant, and $|C_j|\le1$ prove (27); projection cannot increase it. All empirical inputs are continuous in frequency for finite data. Conjugation gives $\widehat H_\Delta(-u)=\overline{\widehat H_\Delta(u)}$ and $\widehat G_\Delta(-u)=-\overline{\widehat G_\Delta(u)}$, establishing measurability and Hermitian symmetry as in Lemma 8. Only differences and bounded exponentials were averaged, so the proof is valid even when the raw measurements have no first moment. $\square$

**Proposition 2 (complete-record bound without signal tails).** Under Definition 3, for every $m\ge3$ and $N\ge1$ there is an explicit estimator with
$$
\sup_{f,Q}\mathbb E\|\widehat f_{m,N}-f\|_2^2
\le C\left[(1+S_m)^{-2\beta}+\frac{(1+S_m)^d m^2 16^m}{N}\right].\tag{30}
$$
The constant depends on $d,\beta,L,A$ alone.

*Proof.* Set $c_A=\min\{\delta_A/2,1/8\}$, $T_m=c_AS_m$, and $u_j(t)=t/(\sigma_jS_m)$ as before. At these frequencies $|\psi_j(u_j)|\ge7/8$. Estimate each reciprocal directly by
$$
\widehat a_j(t)=D(\widehat\psi_{j,N}(u_j(t))).
$$
Lemma 15 and the Lipschitz bound give mean-square error $C_A/N$ relative to $a_j=1/\psi_j(u_j)$. These estimates have magnitude at most four. The exact identity is now
$$
\phi(t)=J_m(t)\prod_{j=1}^m\psi_j(u_j(t))^{-1}.\tag{31}
$$
Estimate $J_m$ by its unit-modulus empirical mean, project the resulting product onto the unit disk, and invert it inside the radius $T_m$. Lemma 9's telescoping argument applies unchanged, including when all factors use the same observations. Plancherel, the Sobolev bound, and the measurability argument of Proposition 1 prove (30). The signal characteristic function is never a denominator. $\square$

**Lemma 16 (lower witnesses for every positive Sobolev radius).** For every $L>0$ there is a fixed dilation $b_L\ge1$ such that the densities
$$
q_{d,b}(x)=b^{-d}q_d(x/b),\qquad
f_{\pm,T,b}(x)=q_{d,b}(x)\{1\pm\alpha\cos(Tx_1)\}\tag{32}
$$
belong to $\mathcal F_{\beta,L}$ whenever $b=b_L$, $T>2a_d/b$, and $0 < \alpha\le\tfrac12(1+T)^{-\beta}$. They have squared $L^2$ separation $2b^{-d}Q_d\alpha^2$. With the fixed error sequence $Q_j=\mathcal L(\sigma_jZ)$, $Z\sim q_d$, their first $m$ observation laws coincide if $T>a_dS_m+2a_d/b$.

*Proof.* Take $b_L=\max\{1,(L_0/L)^{2/d}\}$ using (2). Dilation reduces the base squared $L^2$ norm to $b^{-d}Q_d$ and the spectral radii to $a_d/b$ and $R_d/b$. Repeat the disjoint-support calculation in Lemma 5. Its Sobolev upper bound is at most $b^{-d}L_0^2\le L^2$, and its separation is the stated value. The noise support bound is unchanged, so Lemma 6 proves masking with the narrower signal bands. No signal moment bound is imposed or needed. $\square$

# 9. Information bounds for general stopping designs

The varying-replication proposal of Meister and Neumann [MN10, p. 1615] is a close antecedent: it distributes frequencies across available repetitions and leaves asymptotic analysis of that varying-count procedure open. Here the count law enters a full statistical experiment with unknown heterogeneous errors. We obtain envelopes for every independent tail and matching rates for a broad class of tails; we do not claim that the envelopes coincide for every design.

Put $A_m=(1+S_m)^{-2\beta}$. In the next results all constants are uniform over the allowed error shapes and schedules; constants may depend on $d,\beta,L,A$ and, where stated, the fixed count law.

**Theorem 4 (arbitrary-tail risk envelopes).** In Definition 3, for every $n\ge1$,
$$
c\sup_{m\ge3}\min\{A_m,(n\pi_{m+1})^{-1}\}
\le R_n(\pi,\sigma)
\le C\min\left\{1,\inf_{m\ge3}\left[A_m+\frac{(1+S_m)^d m^2 16^m}{n\pi_m}\right]\right\}.\tag{33}
$$
The lower bound already holds for one fixed known noise sequence. Neither monotonicity of $\sigma_j$ nor tail regularity is required in (33).

*Proof of the upper envelope.* For any deterministic $m\ge3$, select records with $M_i\ge m$. Conditional on the selected indices they are independent complete records, and their number has distribution $\operatorname{Bin}(n,\pi_m)$. Apply (30) and (21), using the zero estimator when none qualify. The extra term $L^2e^{-n\pi_m}$ is absorbed by the variance term because $e^{-x}\le1/x$ and its numerator is at least one. The zero estimator also gives a constant risk bound. Taking the infimum proves the upper envelope; the choices depend only on known class parameters and the known design.

*Proof of the lower envelope.* Fix $Q_j=\mathcal L(\sigma_jZ)$ with $Z\sim q_d$. For a chosen $m$, use Lemma 16 with
$$
T=a_dS_m+2a_d/b_L+1,\qquad
\alpha^2=\min\left\{\tfrac14(1+T)^{-2\beta},\frac{\log2}{8n\pi_{m+1}}\right\}.\tag{34}
$$
The first $m$ prefix laws agree exactly. For any larger prefix length $k$, chi-square contraction through the common measurement kernel gives
$$
\chi^2(P_{k,+},P_{k,-})\le\chi^2(f_+,f_-)
=4\alpha^2\int\frac{q_{d,b_L}(x)\cos^2(Tx_1)}{1-\alpha\cos(Tx_1)}\,dx
\le8\alpha^2.
$$
Contraction follows by writing the observed likelihood ratio as the conditional expectation of the latent likelihood ratio under the minus law and applying conditional Jensen. The denominator is positive on the common support because $\alpha\le1/2$. Since the count is observed and has the same law under both alternatives, the single-record mixture has chi-square divergence at most $8\pi_{m+1}\alpha^2$. For $n$ independent records, multiplication of likelihood ratios yields
$$
\chi^2(P_+^{\otimes n},P_-^{\otimes n})\le\exp(8n\pi_{m+1}\alpha^2)-1\le1.
$$
Thus total variation is at most $1/2$, by Cauchy--Schwarz. The common part of the two observation measures has mass at least $1/2$. Integrating the Hilbert midpoint identity over this common submeasure, exactly as in Lemma 11, gives maximum risk at least $\|f_+-f_-\|_2^2/8$. Lemma 16 and comparability of $1+T$ and $1+S_m$ prove the lower minimum in (33). Take its supremum over $m$. Only the adversarial signals vary with $m,n$; the noise sequence remains fixed. $\square$

The lower envelope measures the number of subjects reaching informative frequencies. It remains useful when the expected number of long records is large, unlike a bound based solely on the event of observing no long record.

**Corollary 4 (explicit design indices).** For all sufficiently large $n$, define
$$
u_n=\max\{m\ge3:H(m)+m\log16+2\log m+(d+2\beta)\log(1+S_m)\le\log n\},
$$
$$
v_n=\min\{m\ge3:H(m+1)+2\beta\log(1+S_m)\ge\log n\}.\tag{35}
$$
Then $cA_{v_n}\le R_n\le CA_{u_n}$. If $1+S_{v_n}\le C_*(1+S_{u_n})$, these bounds match up to constants. This is a sufficient criterion, not a necessity claim.

*Proof.* The first feasible set eventually contains three and is finite because of $m\log16$. The second crossing exists since $H\to\infty$. At $u_n$ the variance term in (33) is at most $A_{u_n}$. At $v_n$, $(n\pi_{v_n+1})^{-1}\ge A_{v_n}$. These observations prove both inequalities and the matching criterion. $\square$

**Theorem 5 (sharp recovery for a broad class of stopping tails).** Add $\sigma_1\le\sigma_2\le\cdots$ to Definition 3. Suppose there are $c_0>0$, an integer $b\ge2$, $0 < \vartheta < 1$, and $m_0$ such that, for all sufficiently large integer $m$,
$$
H(m)\ge c_0m,\qquad H(\lfloor m/b\rfloor)\le\vartheta H(m).\tag{36}
$$
Let $h_n=\min\{m\ge3:n\pi_{m+1}\le1/4\}$. Then, for sufficiently large $n$,
$$
R_n(\pi,\sigma)\asymp(1+S_{h_n})^{-2\beta}.\tag{37}
$$
Constants may depend on the fixed count law and the displayed class parameters, but are uniform over admissible monotone scale schedules. No regular variation or upper doubling condition is required.

*Proof.* The lower envelope at $h_n$ proves the lower bound, because its reciprocal-count term is at least four and $A_{h_n}\le1$. The index $h_n$ tends to infinity. Its minimality gives $H(h_n) < \log(4n)$ for large $n$, and hence $h_n\le c_0^{-1}\log(4n)$.

Choose an integer $J$ and $q=b^J$ large enough that $\vartheta^J\le1/4$ and $\log16/(c_0q)\le1/4$. Let $m=\lfloor h_n/q\rfloor$. For large $n$ all iterated division indices satisfy (36) and $m\ge3$. Successive floor division by $b$ equals division by $b^J$, so
$$
H(m)\le\tfrac14\log(4n),\qquad m\log16\le\tfrac14\log(4n),\qquad
\frac{16^m}{n\pi_m}\le2n^{-1/2}.\tag{38}
$$
Decreasing averages of the inverse scales give $S_m\ge(m/h_n)S_{h_n}\ge S_{h_n}/(2q)$. Use this $m$ in (33). The bias has the required order; the variance is at most $Cn^{-1/2}(\log n)^{d+2}$ because $S_m\le m\le C\log n$. The target is at least $c(\log n)^{-2\beta}$ since $S_{h_n}\le h_n\le C\log n$, so that variance is negligible uniformly over the schedule. $\square$

**Corollary 5 (geometric and faster stopping without signal tails).** In Definition 3, under a monotone schedule and geometric counts, (37) is equivalent to $(1+S_{\max\{3,\lfloor\log n\rfloor\}})^{-2\beta}$. This holds for every $L>0$ with no signal moments. More generally, if $\pi_m=\exp\{-\lambda(m-1)^\gamma\}$ for fixed $\gamma\ge1$, then $h_n\asymp(\log n)^{1/\gamma}$ and the risk has order
$$
\begin{cases}
(\log n)^{-2\beta(1-a)/\gamma},&0\le a < 1,\\
(\log\log n)^{-2\beta},&a=1,\\
1,&a>1,
\end{cases}\tag{39}
$$
when $\sigma_j=j^a$ and $A\ge3^a$. If $H(m)=e^{\lambda(m-1)}-1$, (36) also holds and $h_n\asymp\log\log n$.

*Proof.* For the displayed power log-tail, $H(\lfloor m/b\rfloor)/H(m)\to b^{-\gamma} < 1$, and its lower linear bound holds when $\gamma\ge1$. Solving the crossing condition gives the stated order of $h_n$. Prefix-average comparison makes constant multiples of that index equivalent for the monotone schedule. The series estimates in Corollary 3 then yield (39). For the exponential log-tail, the dilation ratio tends to zero and solving $H(h_n+1)\ge\log(4n)$ gives the iterated-logarithm order. $\square$

# 10. An irregular design where maximum length misleads

The regularity in (36) is substantive. Even an exponentially dominated count tail need not obey a minimax law based only on the threshold $h_n$.

**Proposition 3 (sharp staircase counterexample).** There is a positive count tail with $H(m)\ge m$ for all sufficiently large $m$, and $\sigma_j=1$ for every $j$, such that along sample sizes $n_k\to\infty$,
$$
h_{n_k}\asymp a_k^2,\qquad R_{n_k}\asymp a_k^{-2\beta},\qquad
(1+S_{h_{n_k}})^{-2\beta}\asymp a_k^{-4\beta}.\tag{40}
$$
Thus the maximum-length expression is too optimistic by an unbounded factor, although the general envelopes (33) give the correct order.

*Proof.* Choose an integer $a_1\ge4$ and define $a_{k+1}=a_k^2$. Set $\pi_m=1$ for $m < a_1$ and
$$
H(m)=a_{k+1},\qquad\pi_m=e^{-a_{k+1}}\quad(a_k\le m < a_{k+1}).\tag{41}
$$
This nonincreasing positive tail tends to zero, so its successive differences define a finite integer-valued count law. It satisfies $H(m)\ge m$ on every displayed block. Take $n_k=\lceil e^{a_{k+1}}\rceil$. Throughout the block the expected number reaching a position is asymptotic to one, greater than $1/4$, whereas it becomes negligible at the next jump. Therefore $h_{n_k}=a_{k+1}-1$ for large $k$.

For the lower envelope choose $m=a_k-1$. Since $n_k\pi_{m+1}\to1$ and $S_m=m$, it gives $R_{n_k}\ge c a_k^{-2\beta}$. For the upper envelope use the same $m$. For $k\ge2$, $\pi_m=e^{-a_k}$, and its variance term is bounded by a polynomial in $a_k$ times
$$
\exp\{-a_k^2+(1+\log16)a_k\},
$$
which is smaller than every negative power of $a_k$. The bias is of order $a_k^{-2\beta}$. This proves (40). Long records in the plateau arise from only order-one independent subjects; their length does not supply additional independent draws of the signal. $\square$

# 11. Interpretation, reproducibility, and limits

The reciprocal-scale sum controls population reach in Fourier space. It gives an exact criterion for identification, weakly stable inversion, and joint pointwise strong consistency of all latent laws, under concentration-only errors and any independent count law that reaches every finite prefix. Quantitative density estimation additionally depends on how many subjects supply those frequencies. The envelopes (33) express this second requirement; Theorem 5 and the staircase counterexample show both the scope and the limitation of a maximum-length summary.

The two quantitative routes have different assumptions. Theorem 2 retains the two bounded anchor channels and a signal second moment from Definition 2. Definition 3 and Theorems 4--5 use three bounded anchor channels and remove all signal moment requirements. Both require centered errors with known second-moment bounds. Weak recovery in Theorem 3 uses no moments at all and identifies only common-translation orbits. These conclusions must not be interchanged.

All stopping results concern observed counts independent of signals and errors. Informative dropout, dependent errors, unknown scale bounds, and optimal adaptive measurement acquisition are outside their scope. For arbitrary tails, (33) is an envelope rather than an exact general formula. We have not established sharp minimax rates for every polynomial or stretched-subexponential stopping tail, nor the necessity of the dilation condition in (36). The exponential product cost in the upper envelope is an estimator bound, not a proved universal information cost. The density estimators need not be nonnegative, and neither optimal leading constants nor adaptation to unknown smoothness is asserted.

The results concern distributions across independent subjects, not exact recovery of an individual latent realization. Failure of universal identification does not preclude identification in specially structured noise families. The weak-consistency construction is measurable but is not accompanied by a computational complexity guarantee.

The theory is analytic. The accompanying diagnostic script checks normalization, variance, characteristic functions, and finite-prefix masking for the explicit density. Such calculations can detect transcription errors but do not certify universal statements or minimax optimality. Written proofs are provided for all claimed implications; formal verification is a separate future delivery.


# References

[K67] I. Kotlarski (1967). On characterizing the gamma and the normal distribution. *Pacific Journal of Mathematics* **20**(1), 69--76. DOI: [10.2140/pjm.1967.20.69](https://doi.org/10.2140/pjm.1967.20.69). [Primary text](https://msp.org/pjm/1967/20-1/pjm-v20-n1-p08-s.pdf).

[N07] M. H. Neumann (2007). Deconvolution from panel data with unknown error distribution. *Journal of Multivariate Analysis* **98**(10), 1955--1968. DOI: [10.1016/j.jmva.2006.09.012](https://doi.org/10.1016/j.jmva.2006.09.012). [Author manuscript](https://users.fmi.uni-jena.de/~mneumann/publications/paneldeconv_rev.pdf).

[DHM08] A. Delaigle, P. Hall, and A. Meister (2008). On deconvolution with repeated measurements. *The Annals of Statistics* **36**(2), 665--685. DOI: [10.1214/009053607000000884](https://doi.org/10.1214/009053607000000884). [Primary manuscript](https://arxiv.org/pdf/0804.0713).

[MN10] A. Meister and M. H. Neumann (2010). Deconvolution from non-standard error densities under replicated measurements. *Statistica Sinica* **20**(4), 1609--1636. [Journal full text](https://www3.stat.sinica.edu.tw/sstest/oldpdf/A20n412.pdf).

[CK15] F. Comte and J. Kappus (2015). Density deconvolution from repeated measurements without symmetry assumption on the errors. *Journal of Multivariate Analysis* **140**, 31--46. DOI: [10.1016/j.jmva.2015.04.004](https://doi.org/10.1016/j.jmva.2015.04.004). [Primary manuscript](https://arxiv.org/pdf/1407.3495).

[GG21] C. Gaillac and E. Gautier (2021). Nonparametric classes for identification in random coefficients models when regressors have limited variation. [arXiv:2105.11720v1](https://arxiv.org/abs/2105.11720v1), especially Section 5.1 and Theorem 3.

[GLCL22] E. Gassiat, S. Le Corff, and L. Lehéricy (2022). Deconvolution with unknown noise distribution is possible for multivariate signals. *The Annals of Statistics* **50**(1), 303--323. DOI: [10.1214/21-AOS2106](https://doi.org/10.1214/21-AOS2106). [Author full text](https://www.imo.universite-paris-saclay.fr/~elisabeth.gassiat/deconvolNP_aos.pdf). Read with [GLCL-E].

[GLCL-E] E. Gassiat, S. Le Corff, and L. Lehéricy. Erratum: Deconvolution with unknown noise distribution is possible for multivariate signals. [Authors' erratum](https://www.imo.universite-paris-saclay.fr/~elisabeth.gassiat/erratum.pdf). Consulted 26 November 2026.

[CGL25] J. Capitao-Miniconi, E. Gassiat, and L. Lehéricy (2025). Deconvolution of repeated measurements corrupted by unknown noise. *Electronic Journal of Statistics* **19**(2), 4141--4173. DOI: [10.1214/25-EJS2415](https://doi.org/10.1214/25-EJS2415). [Author full text](https://www.imo.universite-paris-saclay.fr/~elisabeth.gassiat/repeated.pdf), especially Section 7.
