---
title: "Self-calibration from heterogeneous convolution times"
subtitle: "Joint noise uncertainty and the exact cost of radius adaptation"
date: "26 November 2026"
lang: en
---

# Abstract

We study independent observations whose distributions are a common unknown density convolved with a symmetric Lévy semigroup at known bounded deterministic times. No pure-noise observations or repeated design points are required, and the signal characteristic function may have arbitrary zeros. The centered time information $I=\sum_i(a_i-\bar a)^2$ controls internal calibration. We first prove design-uniform minimax risk laws for an unknown semigroup, an unknown Gaussian variance, and a supplied supersmooth baseline with a supplied finite-jump radius. We then resolve two further boundaries. When both the Gaussian variance and a jump measure of mass at most $\Lambda$ are unknown, the squared-$L^2$ density risk is comparable to the sum of $[\log(e+N)]^{-s}$, $(1+I)^{-\min(s,2)/2}$, and $\ell^{-s}\min\{1,\Lambda\ell\}^{\min(s,2)}$, truncated at a constant, where $\ell=\log(e+I\Lambda^2)$. The interaction term is larger than the corresponding supplied-baseline term and is attained by conservative Gaussian extrapolation combined with local calibration. Its matching lower bound uses exact Gaussian–jump compensation on the central support of a bandlimited signal. The Gaussian component itself has risk comparable to $\min\{1,(1+I)^{-1}+\Lambda^2\}$; it can fail to be identifiable while the signal remains identifiable. Even on signals with strictly positive characteristic functions, pointwise identification does not imply uniform consistency. Finally, for a fixed known stable baseline of index $\beta$, and fixed known signal smoothness, we determine the smallest worst-case ratio between the risk of a single radius-independent estimator and the minimax risk when the radius is supplied. This ratio is of order $[\log(e+\log(e+\log(e+N)))]^{2s/\beta}$. A thresholded centered score attains it, and a constrained-risk argument proves necessity. The adaptive upper envelope also holds for a larger known-baseline class; the matching competitive lower bound is asserted for stable baselines. All rates are comparisons up to constants, not efficient leading constants or a claim of worldwide priority.

**Status.** This is a research manuscript with analytical proofs. It has not undergone external peer review. Computational diagnostics are illustrations, not proofs. No theorem in this manuscript has been checked by a proof assistant.

# 1. Experiment, scope, and relation to previous work

The same latent population may be observed after different amounts of an unknown additive evolution. We ask how much variation among those amounts is needed to recover the population density. The data are independent cross-sectional observations, not a trajectory or repeated observations of a common latent variable.

Throughout, fix $s,L,M,C\gt 0$, $A\gt 1$, and $0\lt \beta\le2$. For every integer $N\ge2$ and every known deterministic vector $a=(a_1,\ldots,a_N)\in[1,A]^N$, observe

$$
Y_i=X_i+E_i,\qquad i=1,\ldots,N. \tag{1.1}
$$

The $X_i$ are identically distributed with density $f$, all $X_i,E_i$ are independent, and

$$
\mathbb E e^{itE_i}=e^{-a_i\psi(t)}. \tag{1.2}
$$

The unknown real exponent $\psi$ belongs to $\mathcal P_{\beta,C}$: it is the exponent of a symmetric Lévy convolution semigroup, and

$$
0\le\psi(t)\le C(1+|t|^\beta)\quad(t\in\mathbb R). \tag{1.3}
$$

Thus $e^{-u\psi}$ is a characteristic function for every $u\ge0$, $\psi(0)=0$, and $\psi$ is continuous and even. The class includes stable exponents and suitable compound-Poisson perturbations. At $\beta=2$ it includes Gaussian-plus-jump noise, not only Gaussian noise. No moment bound is imposed on the noise; stable noise with $\beta\lt 2$ need not have a finite second moment.

Our Fourier convention is $\phi_f(t)=\int e^{itx}f(x)\,dx$. Define

$$
\begin{aligned}
\|f\|_{H^s}^2&=\frac1{2\pi}\int_{\mathbb R}(1+t^2)^s|\phi_f(t)|^2\,dt,\\
\mathcal F_{s,L,M}&=\left\{f\ge0:\int f=1,\ \|f\|_{H^s}\le L,
\ \int x^2f(x)\,dx\le M\right\}.
\end{aligned} \tag{1.4}
$$

Let $g_b$ be the centered Gaussian density of variance $b$. For the lower bounds assume the **strict interior condition**

$$
\text{there is }b\in(0,M)\text{ such that }\|g_b\|_{H^s}\lt L. \tag{1.5}
$$

This condition is equivalent to $\|g_M\|_{H^s}\lt L$: the norm of $g_b$ is continuous and strictly decreasing in $b\gt 0$, as follows directly by dominated convergence from its Fourier integral. One can therefore fix $b$ and all subsequent margins using only $(s,L,M)$. Mere nonemptiness of the class would not justify our lower constructions.

Write

$$
\bar a=\frac1N\sum_i a_i,\qquad w_i=a_i-\bar a,
\qquad I=I_N(a)=\sum_iw_i^2. \tag{1.6}
$$

The minimax risk is

$$
R_N^{\mathrm S}(a)=\inf_{\widehat f}\ \sup_{f\in\mathcal F_{s,L,M},\,
\psi\in\mathcal P_{\beta,C}}
\mathbb E_{f,\psi,a}\|\widehat f-f\|_2^2. \tag{1.7}
$$

The infimum permits all measurable, possibly randomized, $L^2(\mathbb R)$-valued estimators. Our Fourier estimators need not be nonnegative or integrate to one; we do not claim otherwise. All constants in $\lesssim$ and $\asymp$ may depend on the fixed class parameters, but not on $N$ or on the particular design. Smoothness adaptation below means that one estimator works for each fixed $s$; its risk constant may depend on $s$.

## 1.1. What is already known

Unknown-error deconvolution with a separate sample of pure noise has sharp minimax theory [J09]. Inverse problems with a separately observed noisy operator have general calibration and minimax theory [HR08]. Neither a second calibration term nor joint signal/operator perturbation is a new general principle. Known heteroscedastic error distributions have also been studied for arbitrary design sequences [DM08].

Meister, Stadtmüller and Wagner [MSW10] treat two independent groups with noise related by dilation and aggregation. Their fixed-parameter model and signal class differ from (1.1)--(1.5). They already show that unknown error shape can change the type of convergence rate. Garnier [G24] studies noisy compound-Poisson decompounding through independent channels. Its marginal characteristic functions have a common unknown factor and a time-dependent semigroup factor; its two-time bound already contains an inverse squared time gap. Its target is the jump density, and the common measurement-error characteristic function is assumed nonzero. Consequently, two-time ratios, time-gap conditioning, and the general phenomenon of a shape-uncertainty penalty are not claimed here as new.

Linton and Whang [LW02] use different aggregation sizes to separate individual and common components. In the inspected institutional working-paper version, the normalized aggregate has characteristic function $\phi_\varepsilon(t)\phi_{X_0}(t/r)^r$. Stable $X_0$ gives a genuine semigroup special case, including Gaussian noise; a general Lévy exponent yields $r\psi_0(t/r)$ rather than a fixed exponent multiplied by a known time. The inspected results use a fixed finite set of integer aggregation sizes, repeated observations within each size group, and nonvanishing assumptions. Kappus [K18] studies irregularly sampled Lévy increments, whose common initial distribution is known rather than an unknown density to be separated.

Misspecified-error robustness also has an existing literature. Meister [M04] studies the limiting integrated squared error of a specified Fourier estimator under a fixed error misspecification; the inspected institutional version gives the associated limit functional in Theorem 1. Kato, Sasaki and Ura [KSU21] construct identification-robust confidence bands from paired repeated measurements using direct moment restrictions, without a nonvanishing characteristic-function requirement. Neither robustness nor avoiding characteristic-function division is therefore claimed as a new general principle. Section 8 concerns a different target: an all-estimator minimax law uniform in a shrinking finite-jump radius and an internally informative exposure design.

The Gaussian component of an unknown Lévy law has its own identification and estimation difficulties. Matias [Ma02] studies unknown Gaussian variance under signal restrictions, while Neumann and Reiß [NR09, Remark 3.2] give a general Lévy example of nonuniform Gaussian-component estimation. Chen, Delaigle and Hall [CDH10] study unknown stable scale together with a compound-Poisson component in an increment experiment. Those results do not identify the radius-uniform interaction with an unrestricted common signal and centered exposure information in Section 9. We do not claim that Gaussian–jump separation or its instability is a new general phenomenon.

Adaptation to an unknown contamination proportion also has a substantial prior theory. Liu and Gao [LG19] study pointwise density loss, and Zhang and Ren [ZR23, Theorems 3.3–3.4] address global $L^p$ loss and unknown-proportion adaptation with known smoothness under their stated conditions. Their iid mixture experiments differ from the supersmooth internally calibrated convolution experiment here. The constrained-risk principle used in Section 10 is due to Brown and Low [BL96], with later general-loss formulations such as Duchi and Ruan [DR21]; neither the principle nor its Hilbert-space consequence is claimed as new. Triple iterated logarithms already occur in minimax theory, for example in sparse high-dimensional change-point detection [LGS21]. Our claim concerns the exact cost for this radius-adaptation criterion, not the first occurrence of that mathematical expression.

The contribution is a design-uniform classification within the specified common-signal experiment, including Fourier zeros and matching alternatives inside the positive Lévy cone. Section 8 establishes the supplied-baseline, supplied-radius law. Sections 9 and 10 complete two further statistical boundaries: simultaneous Gaussian-scale and shrinking-jump uncertainty creates a new interaction risk and an exact component-identification distinction; withholding the jump radius in the known-baseline experiment incurs an unavoidable, attainable worst-case oracle ratio. The latter is a global comparison over designs and radii, not a claim that the proposed adaptive envelope is pointwise minimax for every design-radius pair. Its estimator may use the fixed smoothness $s$, whereas the supplied-radius estimators do not need $s$. These are specified missing boundaries inferred from inspected results, not problems attributed to another author as an explicitly stated conjecture. The literature review is bounded and does not certify worldwide priority. Version and access limitations, including the unavailable final typeset version of [LW02], remain as stated in the references.

# 2. Main results and design consequences

**Theorem 2.1 (unknown-semigroup information law).** Under (1.1)--(1.5), there exist constants $0\lt c_1\le c_2\lt \infty$ such that, for every $N\ge2$ and every $a\in[1,A]^N$,

$$
c_1[\log(e+I)]^{-2s/\beta}
\le R_N^{\mathrm S}(a)
\le c_2[\log(e+I)]^{-2s/\beta}. \tag{2.1}
$$

The upper bound is attained by the estimator in Section 3, which depends on $A,C,\beta$ and the design but not on $s,L,M$. It needs neither a signal characteristic-function lower bound nor repeated design values. The conclusion includes $I=0$.

For comparison, define $R_N^{\mathrm G}(a)$ by replacing the nuisance class in (1.7) with

$$
\psi(t)=vt^2/2,\qquad 0\lt v_-\le v\le v_+\lt \infty,
\qquad v_-\lt v_+, \tag{2.2}
$$

with $v_-,v_+$ fixed and known. This is a separate comparison class using the same observation structure and signal class; it is a submodel of $\mathcal P_{\beta,C}$ when $\beta=2$ and $C\ge v_+/2$. Define the corresponding variance minimax mean squared error $V_N(a)$ by replacing the target $f$ and loss with $v$ and $(\widehat v-v)^2$.

**Theorem 2.2 (Gaussian calibration law).** Under (1.4), (1.5), and (2.2), uniformly over every $N\ge2$ and $a\in[1,A]^N$,

$$
\begin{aligned}
R_N^{\mathrm G}(a)&\asymp
\min\left\{1,[\log(e+N)]^{-s}
 +(1+I)^{-q_s}\right\},\\
V_N(a)&\asymp(1+I)^{-1},\qquad q_s=\min(s/2,1).
\end{aligned} \tag{2.3}
$$

One density estimator, specified in Section 5, attains the upper bound for every fixed $s\gt 0$ without using $s$. It does use $M,v_-,v_+$.

**Theorem 2.3 (any fixed jump-shape allowance).** Fix $\Lambda\gt 0$ and the Gaussian interval (2.2). Replace the pure Gaussian class by

$$
\mathcal P^{\mathrm{G+J}}_\Lambda=
\left\{\frac{vt^2}{2}+\int(1-\cos(tx))\nu(dx):
v\in[v_-,v_+],\ \nu\ge0\text{ symmetric},\ \nu(\mathbb R)\le\Lambda\right\}.
\tag{2.4}
$$

Then its squared-$L^2$ minimax risk satisfies

$$
R_N^{\mathrm{G+J}}(a)\asymp[\log(e+I)]^{-s}. \tag{2.5}
$$

The same order holds if the positive Gaussian variance is fixed and revealed to the estimator. Constants in this theorem may depend on $\Lambda$; it makes no uniform assertion as $\Lambda\downarrow0$. Section 8 gives a radius-uniform theorem when the baseline is supplied, and Section 9 gives the joint theorem for an unknown Gaussian coefficient. The lower alternatives can have equal jump intensity and equal finite second jump moment.

**Proposition 2.4 (identification).** For any fixed design, the common density is identifiable throughout the experiment (1.1)--(1.5) if and only if $I\gt 0$. For $I\gt 0$, $\psi(t)$ is also identified at every frequency where $\phi_f(t)\ne0$. The claim does not require identification of $\psi$ at the remaining frequencies. In the Gaussian model, $v$ is identifiable if and only if $I\gt 0$.

*Proof of the positive direction.* If $a_i\ne a_j$, their marginal characteristic functions satisfy $p_i(t)=\phi_f(t)e^{-a_i\psi(t)}$. Where $\phi_f(t)\ne0$, the positive ratio $p_i(t)/p_j(t)$ determines $\psi(t)$, then $\phi_f(t)$. If all $p_i(t)$ vanish, positivity of $e^{-a_i\psi(t)}$ forces $\phi_f(t)=0$ in every compatible parameter. This determines the entire signal characteristic function and hence the density almost everywhere. In the Gaussian comparison model, the signal characteristic function is nonzero in a neighborhood of zero by continuity and its value at zero, so any nonzero frequency in that neighborhood determines $v$. The negative directions follow from the exact equal-exposure alternatives in Sections 4 and 5. $\square$

**Corollary 2.5 (consistency and the known-noise benchmark).** Along any sequence with $N\to\infty$, uniform consistent density estimation in either model is possible if and only if $I_N\to\infty$. If the exponent is supplied to the estimator, the semigroup-class minimax risk is

$$
R_N^{\mathrm{oracle}}(a)\asymp[\log(e+N)]^{-2s/\beta}. \tag{2.6}
$$

Accordingly, the unknown-semigroup risk has the oracle order along a sequence precisely when

$$
\liminf_{N\to\infty}
\frac{\log(e+I_N)}{\log(e+N)}\gt 0. \tag{2.7}
$$

Equivalently, $I_N$ is eventually at least a positive power of $N$. In the Gaussian model, the oracle order is retained precisely when

$$
I_N\gtrsim[\log(e+N)]^{\max(s,2)}. \tag{2.8}
$$

These equivalences concern bounded ratios of risk orders, not equality of leading constants. The oracle proof is in Section 6. The remaining statements follow immediately from the two-sided bounds and $I\le N(A-1)^2/4$.

For two exposure levels with group sizes $n_0,n_1$ and difference $\Delta$,

$$
I=\frac{n_0n_1}{n_0+n_1}\Delta^2. \tag{2.9}
$$

This identity includes the balanced value $I=n\Delta^2/2$ when each group has size $n$. The elementary bound $I\le N(A-1)^2/4$ follows by applying the variance bound for a variable in $[1,A]$ to the uniform distribution on the design points. It is attained by balanced endpoint allocations when $N$ is even. This rate-level design consequence is not a separate novelty claim.

In particular, take balanced exposures with $I_N$ of order $(\log N)^p$, where $p\ge\max(s,2)$. The gap can be chosen to tend to zero while keeping both exposures in $[1,A]$. The Gaussian rate is $(\log N)^{-s}$, whereas (2.5) is $(\log\log N)^{-s}$. This is the specified weak-design separation; it is not a uniform shrinking-neighborhood result.

# 3. The unknown-semigroup upper bound

We first record two elementary facts that avoid sample splitting and division by the signal characteristic function.

**Lemma 3.1 (centered exponential identity).** For every real $d$,

$$
\sum_iw_i e^{a_id}
=d\sum_iw_i^2\int_0^1e^{(\bar a+u w_i)d}\,du. \tag{3.1}
$$

Consequently, for $|d|\le R$,

$$
\left|\sum_iw_i e^{a_id}\right|\ge I|d|e^{-AR}. \tag{3.2}
$$

*Proof.* Subtract $e^{\bar a d}\sum_iw_i=0$ and use the fundamental theorem of calculus on each difference $e^{a_i d}-e^{\bar a d}$. Since $\bar a+uw_i\in[1,A]$, every integral in (3.1) is at least $e^{-AR}$; all terms on the right have the sign of $d$. This also proves the statement at $d=0$. $\square$

**Lemma 3.2 (same-data exponential process bound).** Let independent complex random variables $\xi_i$ have mean zero and $\mathbb E|\xi_i|^2\le1$. For deterministic real $c_i$ and $R\ge0$,

$$
\left\|\sup_{0\le u\le R}
\left|\sum_i c_i e^{a_i u}\xi_i\right|\right\|_{L^2(\mathbb P)}
\le e^{AR}\left(\sum_i c_i^2\right)^{1/2}. \tag{3.3}
$$

*Proof.* The exponential power series converges uniformly on the compact parameter interval. Its absolute-value majorant yields a sum of $R^j/j!$ times $|\sum_i c_i a_i^j\xi_i|$. Independence and centering make the squared $L^2(\mathbb P)$ norm of this latter sum at most $A^{2j}\sum_i c_i^2$. Minkowski's inequality applied to finite partial sums, followed by convergence of the norm majorant, gives (3.3). The same proof applies on any subinterval of $[0,R]$. $\square$

Assume first that $I\ge1$. For each real frequency $t$, put $R(t)=C(1+|t|^\beta)$ and define

$$
G_t(u)=\sum_i w_i e^{a_i u}e^{itY_i},\qquad 0\le u\le R(t).
\tag{3.4}
$$

Choose the smallest global minimizer $\widehat\psi(t)$ of $|G_t(u)|$ on that interval. This is a measurable selection; Appendix A gives a direct argument. We do not assert that $G_t$ is monotone or that it has a unique zero. The population criterion is

$$
F_t(u)=\phi_f(t)\sum_iw_i e^{a_i(u-\psi(t))},\qquad
F_t(\psi(t))=0. \tag{3.5}
$$

Let $U_t=\sup_{0\le u\le R(t)}|G_t(u)-F_t(u)|$ and $d_t=\widehat\psi(t)-\psi(t)$. Minimality and (3.2) imply

$$
|\phi_f(t)|\,|d_t|\le\frac{2e^{AR(t)}}{I}U_t. \tag{3.6}
$$

This inequality remains meaningful when $\phi_f(t)=0$: neither side was divided by that quantity. Applying (3.3) to $c_i=w_i$ and $\xi_i(t)=e^{itY_i}-\mathbb E e^{itY_i}$ gives

$$
\mathbb E U_t^2\le I e^{2AR(t)}. \tag{3.7}
$$

For a deterministic cutoff $T\gt 0$, set

$$
\widehat\phi(t)=\mathbf1_{\{|t|\le T\}}
\frac1N\sum_i e^{a_i\widehat\psi(t)}e^{itY_i},\qquad
\widehat f(x)=\frac1{2\pi}\int_{-T}^T e^{-itx}\widehat\phi(t)\,dt.
\tag{3.8}
$$

For $|t|\le T$, its exact error decomposition is

$$
\widehat\phi(t)-\phi_f(t)
=\frac1N\sum_i e^{a_i\widehat\psi(t)}\xi_i(t)
+\phi_f(t)\left(\frac1N\sum_i e^{a_i d_t}-1\right). \tag{3.9}
$$

The first term has mean square at most $N^{-1}e^{2AR(t)}$ by (3.3), already uniformly over the random chosen parameter. No independence of $\widehat\psi$ and the data is needed. For the second, the mean-value inequality gives

$$
\left|\frac1N\sum_i e^{a_i d_t}-1\right|
\le A e^{AR(t)}|d_t|.
$$

Together with (3.6)--(3.7), this proves

$$
\mathbb E|\widehat\phi(t)-\phi_f(t)|^2
\le \frac{2e^{2AR(t)}}N+\frac{8A^2e^{6AR(t)}}I
\le \frac{C_Ae^{6AR(t)}}I. \tag{3.10}
$$

The last step uses $I\le N(A-1)^2/4$. The estimator is real-valued because $G_{-t}$ is the complex conjugate of $G_t$, so the smallest minimizers agree and $\widehat\phi(-t)=\overline{\widehat\phi(t)}$. It belongs to $L^2$, since its Fourier transform is bounded on a compact interval.

Choose a fixed $\kappa\gt 0$ with $6AC\kappa\le1/2$, and let

$$
T^\beta=\kappa\log(e+I). \tag{3.11}
$$

Plancherel and Tonelli, using (3.10), give

$$
\mathbb E\|\widehat f-f\|_2^2
\le L^2(1+T^2)^{-s}
+C I^{-1}T e^{6AC(1+T^\beta)}
\lesssim[\log(e+I)]^{-2s/\beta}. \tag{3.12}
$$

Indeed, $I^{-1}(e+I)^{1/2}[\log(e+I)]^{1/\beta}$ is bounded by a constant times any fixed negative power of $\log(e+I)$ on $I\ge1$. For $I\lt 1$, use $\widehat f=0$; its risk is at most $L^2$, and the right side of (2.1) is bounded below by a positive constant on that interval. This proves the upper bound in Theorem 2.1, including all small-information cases.

# 4. A lower bound inside the Lévy class

The construction keeps both the signal and the jump measures nonnegative. Its cancellation occurs at the mean exposure, leaving the centered design weights in the observation distance.

## 4.1. A positive bandlimited jump density

**Lemma 4.1 (an explicit jump density).** Define

$$
r(x)=(\sin x/x)^4,\quad r(0)=1,\qquad
\eta(x)=\frac{r(x)+r(x-\pi/2)+r(x+\pi/2)}{2\pi}. \tag{4.1}
$$

Then $\eta$ is an even probability density, $\widehat\eta\in C_c^2(\mathbb R)$ is real and supported on $[-4,4]$, and

$$
\begin{aligned}
\eta(x)&\ge c_\eta(1+x^2)^{-2},\qquad
c_\eta=\frac1{2\pi(1+\pi^2/4)^2},\\
m_\eta:=\int x^2\eta(x)\,dx&=\frac34+\frac{\pi^2}{6}.
\end{aligned} \tag{4.2}
$$

*Proof.* The identity $\sin x/x=\frac12\int_{-1}^1e^{iux}\,du$, applied four times, gives

$$
\widehat r(t)=\frac\pi{48}
\bigl[(4-|t|)_+^3-4(2-|t|)_+^3\bigr]. \tag{4.3}
$$

This can equivalently be obtained by convolving four uniform densities on $[-1,1]$. At zero it equals $2\pi/3$, so (4.1) integrates to one. The translation rule yields

$$
\widehat\eta(t)=\frac{1+2\cos(\pi t/2)}{96}
\bigl[(4-|t|)_+^3-4(2-|t|)_+^3\bigr]. \tag{4.4}
$$

The piecewise cubic bracket is $C^2$, including at $0,\pm2,\pm4$, with its first two derivatives matching zero at the support boundary. This proves the claimed Fourier regularity. Also $r(x)\ge\sin^4x/(1+x^2)^2$, while

$$
r(x-\pi/2)+r(x+\pi/2)
\ge\frac{2\cos^4x}{(1+\pi^2/4)^2(1+x^2)^2}.
$$

These inequalities hold at removable singularities by continuity. Use $\sin^4x+\cos^4x\ge1/2$ to obtain (4.2). The corresponding upper tail bound $\eta(x)\le C_\eta(1+x^2)^{-2}$ follows by denominator comparison outside a compact interval and continuity inside it, giving finite second moment. For $|t|\le2$, (4.3) equals $2\pi/3-(\pi/4)t^2+(\pi/16)|t|^3$. Hence $\int x^2r(x)\,dx=\pi/2$. The two translations in (4.1), odd-moment cancellation, and $\int r=2\pi/3$ give the value of $m_\eta$. $\square$

Fix once and for all $\epsilon\in(0,1/2]$. For $T\ge10$ let

$$
\nu_\pm(dx)=\lambda\eta(x)(1\pm\epsilon\cos(Tx))\,dx,
\qquad H_T(t)=\widehat\eta(t-T)+\widehat\eta(t+T). \tag{4.5}
$$

The parameter $\lambda\gt 0$ will be fixed sufficiently small, independently of $T,N,a$. These finite Lévy measures are nonnegative and symmetric. Since $T\gt 4$ and both $\widehat\eta(T)$ and $\widehat\eta''(T)$ vanish,

$$
\nu_\pm(\mathbb R)=\lambda,\qquad
\int x\nu_\pm(dx)=0,\qquad
\int x^2\nu_\pm(dx)=\lambda m_\eta. \tag{4.6}
$$

Write their compound-Poisson exponents as

$$
\begin{aligned}
j_\pm(t)&=\int(1-\cos(tx))\nu_\pm(dx)\\
&=\lambda(1-\widehat\eta(t))
\mp\frac{\lambda\epsilon}{2}H_T(t).
\end{aligned} \tag{4.7}
$$

Both $j_\pm$ lie between $0$ and $2\lambda$. Their difference is supported on

$$
\mathcal B_T=[T-4,T+4]\cup[-T-4,-T+4]. \tag{4.8}
$$

For $T\ge10$, this set is disjoint from $[-4,4]$, so $\widehat\eta(t)=0$ on $\mathcal B_T$ and $|t|\ge T/2$ there.

## 4.2. Signal alternatives with fixed class margins

**Lemma 4.2 (positive modulated Gaussian).** With the interior point $b$ from (1.5), choose a fixed sufficiently small $\kappa_0\in(0,1/4]$ and set

$$
\alpha_T=\kappa_0(1+T^2)^{-s/2},\qquad c_T=e^{-bT^2/2},
\qquad q_T(x)=g_b(x)[1+\alpha_T(\cos(Tx)-c_T)]. \tag{4.9}
$$

Uniformly in $T\ge10$, this is an even probability density, $q_T\ge g_b/2$, $\|q_T\|_{H^s}\lt L$, and

$$
\int x^2q_T(x)\,dx=b-\alpha_T b^2T^2e^{-bT^2/2}\le b. \tag{4.10}
$$

Its Fourier transform is

$$
\widehat q_T(t)=(1-\alpha_Tc_T)e^{-bt^2/2}
+\frac{\alpha_T}{2}
\left(e^{-b(t-T)^2/2}+e^{-b(t+T)^2/2}\right). \tag{4.11}
$$

*Proof.* The bracket in (4.9) is at least $1-2\kappa_0\ge1/2$; its Gaussian integral is one. Differentiating the Gaussian characteristic function twice gives (4.10), while the cosine translation identity gives (4.11). For the Sobolev bound, use

$$
(1+(u+T)^2)^s\le2^s(1+u^2)^s(1+T^2)^s
$$

on each translated Gaussian. The triangle inequality in the weighted Fourier $L^2$ space gives $\|q_T-g_b\|_{H^s}\le C_{s,b}\kappa_0$. Choose $\kappa_0$ within the strict norm margin in (1.5). All coefficients in (4.11) are nonnegative. $\square$

For a finite nonnegative measure $\nu$, denote by $\operatorname{CP}(\nu)$ the compound-Poisson probability measure with characteristic function $\exp\{\int(e^{itx}-1)\nu(dx)\}$. Define

$$
f_1=q_T*\operatorname{CP}(\bar a\nu_-),\qquad
f_2=q_T*\operatorname{CP}(\bar a\nu_+). \tag{4.12}
$$

Convolution by a probability measure contracts the $H^s$ norm, since its characteristic function has modulus at most one. By the centered second-moment addition rule and (4.6), both signals have second moment at most $b+A\lambda m_\eta$. Therefore both belong to $\mathcal F_{s,L,M}$ if

$$
0\lt \lambda\le\min\left\{C/8,(M-b)/(2A m_\eta)\right\}. \tag{4.13}
$$

The two noise exponents

$$
\psi_\pm(t)=c_0|t|^\beta+j_\pm(t),\qquad c_0=C/4, \tag{4.14}
$$

belong to $\mathcal P_{\beta,C}$. Here $c_0|t|^\beta$ is a symmetric stable exponent (Gaussian at $\beta=2$); adding a finite nonnegative Lévy measure preserves infinite divisibility. For $0\lt \beta\lt 2$, the stable exponent can be obtained directly by scaling the convergent integral of $(1-\cos(tx))|x|^{-1-\beta}$; at $\beta=2$ use the Gaussian characteristic function.

**Lemma 4.3 (signal separation).** There is a fixed $c\gt 0$ such that

$$
\|f_2-f_1\|_2^2\ge c(1+T^2)^{-s},\qquad T\ge10. \tag{4.15}
$$

*Proof.* By (4.7) and (4.12),

$$
\widehat f_2(t)-\widehat f_1(t)
=2\widehat q_T(t)e^{-\bar a\lambda(1-\widehat\eta(t))}
\sinh\left(\frac{\bar a\lambda\epsilon}{2}H_T(t)\right). \tag{4.16}
$$

Continuity and $\widehat\eta(0)=1$ give a fixed $\delta\in(0,1)$ with $\widehat\eta(u)\ge1/2$ for $|u|\le\delta$. On $|t-T|\le\delta$, $H_T(t)\ge1/2$, $\widehat\eta(t)=0$, and (4.11) is at least $(\alpha_T/2)e^{-b\delta^2/2}$. Since $1\le\bar a\le A$, the absolute value of (4.16) is bounded below by a positive constant times $\alpha_T$ on an interval of fixed length. Integrating and applying Plancherel proves (4.15). $\square$

## 4.3. Observation distance depends on centered times

Use parameter pair $(f_1,\psi_+)$ in the first experiment and $(f_2,\psi_-)$ in the second. Let their $i$th observation densities be $p_i,q_i$ respectively. The exact Fourier difference is

$$
\begin{aligned}
D_i(t)&:=\widehat p_i(t)-\widehat q_i(t)\\
&=2\widehat q_T(t)e^{-a_i c_0|t|^\beta}
 e^{-(\bar a+a_i)\lambda(1-\widehat\eta(t))}\\
&\quad\times\sinh\left(\frac{w_i\lambda\epsilon}{2}H_T(t)\right).
\end{aligned} \tag{4.17}
$$

It vanishes outside $\mathcal B_T$ and vanishes identically when $w_i=0$. In particular, equal exposure times give exactly equal observation laws even though (4.15) separates the two signals.

**Lemma 4.4 (a uniform positive denominator).** For a fixed constant $c_d\gt 0$,

$$
q_i(x)\ge c_d(1+x^2)^{-2} \tag{4.18}
$$

uniformly over $N\ge2$, $1\le i\le N$, $T\ge10$, and all allowed designs.

*Proof.* Let $S_{a_i c_0,\beta}$ denote the stable law with exponent $a_i c_0|t|^\beta$. Then

$$
q_i=q_T*S_{a_i c_0,\beta}*
\operatorname{CP}(\bar a\nu_++a_i\nu_-).
$$

The total jump intensity is $\lambda(\bar a+a_i)\le2A\lambda$. Its one-jump term is at least $2\lambda(1-\epsilon)e^{-2A\lambda}\eta(x)\,dx$. Also $q_T\ge g_b/2$. There are fixed $R_0,p_0\gt 0$ such that $g_b*S_{a_i c_0,\beta}$ assigns at least $p_0$ mass to $[-R_0,R_0]$, uniformly over $a_i\in[1,A]$: use a fixed bounded-probability interval for the Gaussian and the stable scaling relation on a bounded scale interval. For $|z|\le R_0$,

$$
1+(x-z)^2\le2(1+R_0^2)(1+x^2).
$$

Convolving the lower bound in (4.2) over this interval proves (4.18). This proof uses no stable-density tail asymptotic and applies also at $\beta=2$. $\square$

**Lemma 4.5 (weighted distance bound).** There are fixed $C_1,c_1\gt 0$ such that

$$
\chi^2(P_i\Vert Q_i)
\le C_1 w_i^2(1+T)^4e^{-c_1T^\beta}. \tag{4.19}
$$

*Proof.* On $\mathcal B_T$, the compound-Poisson exponential in (4.17) is constant. The functions $H_T$ and their first two derivatives are bounded uniformly in $T$. The same holds for $\widehat q_T$ by (4.11). For $j=0,1,2$, differentiating the stable exponential away from zero gives

$$
\left|\frac{d^j}{dt^j}e^{-a_i c_0|t|^\beta}\right|
\le C(1+T)^j e^{-cT^\beta},\qquad t\in\mathcal B_T.
$$

Here $0\lt \beta\le2$, $|t|\ge T/2$, and the exposure bounds are essential. The hyperbolic sine in (4.17), and each of its first two derivatives, have absolute value at most $C|w_i|$: every differentiated term retains a factor $w_i$, and $|w_i|\le A-1$. The support length is fixed. Thus

$$
\|D_i^{(j)}\|_2^2\le C w_i^2(1+T)^4e^{-cT^\beta},
\qquad j=0,1,2. \tag{4.20}
$$

The compactly supported $C^2$ difference has no distributional boundary terms. Plancherel for weak derivatives gives

$$
\int(1+x^2)^2|p_i(x)-q_i(x)|^2\,dx
=\frac1{2\pi}\left(\|D_i\|_2^2+2\|D_i'\|_2^2+\|D_i''\|_2^2\right).
\tag{4.21}
$$

This identity concerns the density difference; no weighted $L^2$ claim about the individual stable-tailed densities is required. Divide by (4.18) in the definition of $\chi^2$ and use (4.20). $\square$

## 4.4. Completion of the lower bounds

The inequality $\mathrm{KL}(P_i\Vert Q_i)\le\chi^2(P_i\Vert Q_i)$ and product additivity give

$$
\mathrm{KL}\left(\bigotimes_i P_i\,\middle\Vert\,\bigotimes_i Q_i\right)
\le C I(1+T)^4e^{-cT^\beta}. \tag{4.22}
$$

Choose a fixed sufficiently large $K$ and put

$$
T=[K\log(e+I)]^{1/\beta}. \tag{4.23}
$$

One can ensure $T\ge10$ and make (4.22) at most $1/8$ simultaneously for all $I\ge0$. To see uniformity, put $u=\log(e+I)\ge1$ and bound the right side by a constant times $K^{4/\beta}u^{4/\beta}e^{-(cK-1)u}$. For large $K$ its supremum on $u\ge1$ tends to zero. At $I=0$, the distance is exactly zero without this bound.

Pinsker's inequality gives total variation at most $1/4$. If two targets have $L^2$ separation $d$, the nearest-target test associated with any estimator shows that its maximum squared-error risk is at least $d^2(1-\mathrm{TV})/8$. This also applies to randomized estimators, since adjoining the same independent randomization does not increase total variation. Combine this testing bound with (4.15) and (4.23) to obtain the lower bound in (2.1).

For Theorem 2.3, the upper bound follows from Section 3 with $\beta=2$ and a fixed envelope constant large enough for (2.4). In the lower construction replace $c_0t^2$ by $v_*t^2/2$ for any fixed permitted $v_*\gt 0$, and further require $\lambda\le\Lambda$. Every preceding step is unchanged. The two alternatives have the same Gaussian variance, so revealing that value does not weaken the lower bound; the upper estimator can ignore the revelation. Equation (4.6) proves the assertions about equal intensity and equal second jump moment. This completes Theorems 2.1 and 2.3 and the nonidentification part of Proposition 2.4 for the semigroup model.

# 5. The Gaussian calibration comparison

## 5.1. A bounded low-frequency variance estimator

Fix $k\gt 0$ sufficiently small that $kM\le1/4$, and set $t_0=\sqrt{2k}$. If the true variance is $v_0$, then

$$
c_f:=\mathbb E\cos(t_0X)\ge1-kM\ge3/4. \tag{5.1}
$$

For $I\ge1$, choose the smallest global minimizer $\widehat v$ of the absolute value of

$$
G(u)=\sum_iw_i\cos(t_0Y_i)e^{ka_i u},\qquad u\in[v_-,v_+]. \tag{5.2}
$$

It is measurable by Appendix A. With $D=v_+-v_-$, the population function is

$$
F(u)=c_f\sum_iw_i e^{ka_i(u-v_0)},\qquad F(v_0)=0.
$$

Lemma 3.1 implies $|F(u)|\ge c_f k e^{-kAD}I|u-v_0|$. If $U=\sup_u|G(u)-F(u)|$, minimality gives

$$
|\widehat v-v_0|\le C U/I. \tag{5.3}
$$

**Lemma 5.1 (uniform exponential moments of calibration error).** For every fixed $p\gt 0$ and $B\ge0$, and every $T$ with $T^2\le\kappa\sqrt I$ for a fixed $\kappa\lt \infty$,

$$
\mathbb E\left[|\widehat v-v_0|^p
 e^{BT^2|\widehat v-v_0|}\right]\le C_{p,B,\kappa} I^{-p/2}.
\tag{5.4}
$$

*Proof.* Apply Lemma 3.2 to centered cosines with parameter interval $[kv_-,kv_+]$ to get $\mathbb E U\le e^{kAv_+}\sqrt I$. Altering one observation changes $U$ by at most $2|w_i|e^{kAv_+}$. The bounded-differences inequality therefore gives, for every $z\ge0$,

$$
\mathbb P\{U\gt e^{kAv_+}\sqrt I+z\sqrt I\}
\le \exp\{-z^2/(2e^{2kAv_+})\}. \tag{5.5}
$$

By (5.3), $Z=\sqrt I|\widehat v-v_0|$ has a uniform Gaussian right-tail bound after a fixed shift. Integrating that tail shows $\mathbb E[Z^p e^{bZ}]\lt C_{p,b}$ for every fixed $b\ge0$. Since $BT^2/\sqrt I\le B\kappa$, this is (5.4). No fourth signal moment is used: the score variables are bounded. $\square$

Taking $p=2,B=0$ gives the variance-risk upper bound for $I\ge1$. For $I\lt 1$, a fixed value in $[v_-,v_+]$ has bounded squared error, giving $V_N(a)\lesssim(1+I)^{-1}$ in all cases.

## 5.2. Density upper bound without splitting the design

For $I\ge1$, choose a fixed $\kappa\gt 0$ with $Av_+\kappa\le1/2$ and set

$$
T^2=\kappa\min\{\log(e+N),\sqrt I\},\qquad
\widehat\phi_{\mathrm G}(t)=\mathbf1_{\{|t|\le T\}}
\frac1N\sum_i e^{a_i\widehat v t^2/2}e^{itY_i}. \tag{5.6}
$$

Take its inverse Fourier transform as $\widehat f_{\mathrm G}$. Let $\delta_v=\widehat v-v_0$. For $|t|\le T$,

$$
\widehat\phi_{\mathrm G}(t)-\phi_f(t)
=\frac1N\sum_i e^{a_i\widehat v t^2/2}\xi_i(t)
+\phi_f(t)\left(\frac1N\sum_i e^{a_i\delta_v t^2/2}-1\right),
\tag{5.7}
$$

where $\xi_i(t)$ are as in Section 3. Lemma 3.2 with parameter interval $[v_-t^2/2,v_+t^2/2]$ bounds the first term in mean square by $N^{-1}e^{Av_+t^2}$. It already permits the same-data choice $\widehat v$.

Put $r_s=\min(s,2)$. For real $x$, the elementary estimate

$$
|e^x-1|^2\le4|x|^{r_s}e^{2|x|} \tag{5.8}
$$

follows by splitting $|x|\le1$ and $|x|\gt 1$. Jensen's inequality, (5.4), and $r_s\le s$ give

$$
\begin{aligned}
&\frac1{2\pi}\int_{-T}^T |\phi_f(t)|^2
\mathbb E\left|\frac1N\sum_i e^{a_i\delta_v t^2/2}-1\right|^2dt\\
&\qquad\le C\mathbb E\left[|\delta_v|^{r_s}e^{AT^2|\delta_v|}\right]
\frac1{2\pi}\int |t|^{2r_s}|\phi_f(t)|^2dt
\le C I^{-r_s/2}.
\end{aligned} \tag{5.9}
$$

Plancherel now yields

$$
\mathbb E\|\widehat f_{\mathrm G}-f\|_2^2
\le C\left[(1+T^2)^{-s}+N^{-1}Te^{Av_+T^2}+I^{-r_s/2}\right].
\tag{5.10}
$$

The bias is at most a constant times $[\log(e+N)]^{-s}+I^{-s/2}$. The variance is at most $C N^{-1/2}\sqrt{\log(e+N)}$, which is bounded by $C_s[\log(e+N)]^{-s}$. For $s\ge2$, $I^{-s/2}\le I^{-1}$ on $I\ge1$. This proves the upper order in (2.3). On $I\lt 1$ take $\widehat f_{\mathrm G}=0$. On $I\ge1$ the same displayed bound is also uniformly bounded, so it implies the minimum with 1 after adjusting the constant; no smoothness-dependent selection of estimators is needed.

## 5.3. Calibration lower bound along a heat orbit

Fix $v_0$ strictly inside $[v_-,v_+]$. Choose a fixed $h_0\gt 0$ sufficiently small and let

$$
h=\frac{h_0}{\sqrt{1+I}},\qquad
(f^{(0)},v^{(0)})=(f,v_0),\qquad
(f^{(1)},v^{(1)})=(f*g_{\bar a h},v_0-h). \tag{5.11}
$$

Require $v_0-h_0\ge v_-$ and $b+Ah_0\lt M$. The observation laws are

$$
f*g_{a_i v_0},\qquad f*g_{a_i v_0-w_i h}. \tag{5.12}
$$

The second variance is positive because it equals $a_i(v_0-h)+\bar a h$. Both variances lie in a fixed compact positive interval. For centered Gaussian laws with variances $u,u'$ in such an interval,

$$
\mathrm{KL}(g_u\Vert g_{u'})
=\tfrac12\{u/u'-1-\log(u/u')\}\le C(u-u')^2. \tag{5.13}
$$

Convolution by the same $f$ is a Markov kernel and contracts KL. Therefore the product distance in (5.12) is at most $C I h^2\le C h_0^2$. Decrease $h_0$ to make it at most $1/8$.

**Lemma 5.2 (the Sobolev heat separation).** The density $f$ in (5.11) can be chosen in $\mathcal F_{s,L,M}$, with both alternatives in that class, such that

$$
\|f-f*g_{\bar a h}\|_2^2\ge c h^{\min(s,2)}. \tag{5.14}
$$

*Proof.* If $0\lt s\lt 2$, use $f=q_T$ from Lemma 4.2 with $T=h^{-1/2}$. Take $h_0$ small enough that $T\ge10$. On a fixed-width interval around $T$, (4.11) gives $\widehat q_T\ge c\alpha_T$, and $1-e^{-\bar a h t^2/2}\ge c'\gt 0$, since $ht^2$ is bounded below there. Thus Plancherel gives a lower bound $c\alpha_T^2\asymp h^s$. If $s\ge2$, use $f=g_b$. On $t\in[1,2]$, $1-e^{-\bar a h t^2/2}\ge ch$ uniformly for $h\le h_0$, giving $ch^2$. In both cases convolution contracts the Sobolev norm and adds exactly $\bar a h$ to the second moment of the centered signal. Our choices of $h_0,b$ make both alternatives admissible. $\square$

The two-point bound now gives $R_N^{\mathrm G}(a)\gtrsim(1+I)^{-q_s}$. Using $f=g_b$ for all $s$ in (5.11) and targeting the variance instead gives $V_N(a)\gtrsim h^2\asymp(1+I)^{-1}$. At $I=0$ the observation laws in (5.12) coincide, while both $f$ and $v$ change; this proves the remaining nonidentification assertions.

## 5.4. The logarithmic lower bound

Keep $v=v_0$ fixed and compare $g_b$ and $q_T$. If $u_i=a_i v_0$, Gaussian conditioning gives the exact likelihood ratio

$$
\frac{(q_T*g_{u_i})(y)}{g_{b+u_i}(y)}
=1+\alpha_T\left[
e^{-b u_i T^2/(2(b+u_i))}\cos\left(\frac{bT}{b+u_i}y\right)-c_T\right].
\tag{5.15}
$$

It follows from $u_i\in[v_-,Av_+]$ that the single-observation chi-square distance is at most $C\alpha_T^2e^{-cT^2}$, with design-uniform constants. The product KL is at most $CN\alpha_T^2e^{-cT^2}$. Choose $T^2=K\log(e+N)$ with fixed sufficiently large $K$ so that this is at most $1/8$ and $T$ is above a fixed $b$-dependent threshold. On a fixed interval near $T$, the shifted Gaussian term in $\widehat q_T-\widehat g_b$ dominates its exponentially small central subtraction. Hence $\|q_T-g_b\|_2^2\ge c\alpha_T^2\asymp[\log(e+N)]^{-s}$. The two-point argument proves the logarithmic lower bound.

Taking the maximum of this bound and the calibration bound implies a constant times the minimum with 1 of their sum: each summand is bounded by 1, and the maximum is at least half their sum. Together with Sections 5.1--5.3, this completes Theorem 2.2.

# 6. The known-noise benchmark

We prove (2.6), rather than assuming that an unknown-error result supplies an oracle comparison. Here an estimator may depend on the entire supplied exponent $\psi$, while the risk still takes the supremum over the class in (1.3).

For the upper bound, use

$$
\widehat\phi_{\mathrm{oracle}}(t)=\mathbf1_{\{|t|\le T\}}
\frac1N\sum_i e^{a_i\psi(t)}e^{itY_i}.
$$

This is unbiased on the retained frequencies and has variance at most $N^{-1}e^{2AC(1+|t|^\beta)}$. Choosing $T^\beta=\kappa\log(e+N)$ with $2AC\kappa\le1/2$ and repeating the bias-variance calculation in (3.12) proves the upper bound uniformly over all designs, including $I=0$.

For completeness, construct a lower pair with exactly the same supplied exponent. Fix the density $\eta$ of Lemma 4.1. Choose $\tau\in(0,1/2)$ small enough that

$$
f_0=(1-\tau)g_b+\tau\eta
$$

has a strict $H^s$ norm margin below $L$ and a second moment below $M$. Such a choice exists by (1.5), since $\eta$ has finite second moment and its compactly supported Fourier transform gives a finite $H^s$ norm for every fixed $s$. Let

$$
d_T=\zeta(1+T^2)^{-s/2},\qquad
f_1(x)=f_0(x)+d_T\eta(x)\cos(Tx),\qquad T\ge10. \tag{6.1}
$$

Choose $\zeta\gt 0$ sufficiently small, with $\zeta\le\tau/2$. Then $f_1\ge0$. Because $\widehat\eta(T)=\widehat\eta''(T)=0$, the perturbation has zero integral and zero second moment. The weighted Fourier translation bound used in Lemma 4.2 places both signals in the class uniformly in $T$. Their Fourier difference is $d_T H_T/2$, so its magnitude is at least $cd_T$ on a fixed interval near $T$. Thus $\|f_1-f_0\|_2^2\ge cd_T^2$.

Fix the common, known exponent

$$
\psi_*(t)=c_0|t|^\beta+\lambda(1-\widehat\eta(t)), \tag{6.2}
$$

with small fixed $c_0,\lambda\gt 0$ satisfying (1.3). The observation Fourier difference is $(d_T/2)H_T(t)e^{-a_i\psi_*(t)}$. A one-jump term and $f_0\ge(1-\tau)g_b$ give the same denominator bound as Lemma 4.4. The derivative calculation in Lemma 4.5 therefore gives single-observation chi-square at most $C d_T^2(1+T)^4e^{-cT^\beta}$. Product KL is bounded by the same expression multiplied by $N$. Choosing $T^\beta=K\log(e+N)$ with fixed large $K$ and applying the two-point bound proves (2.6).

In the pure Gaussian oracle model the direct upper estimator uses the supplied $v$ and $T^2$ proportional to $\log(e+N)$; Section 5.4 supplies the matching lower bound. Therefore its oracle order is $[\log(e+N)]^{-s}$, as used in (2.8).

# 7. Interpretation and boundaries

The design enters the unknown-semigroup lower bound through centered times because a common amount of convolution can be moved between the signal and the noise. Moving the two legal jump components at time $\bar a$ cancels their average effect. Only the deviations $a_i-\bar a$ reveal which component was assigned to the signal. The upper score uses the same centering, but its proof does not assume that the least-favorable family describes a typical signal.

The information law concerns the common signal, not estimation of every nuisance frequency. A concrete distinction is possible: when the fixed class bounds include the density $\eta$, take $f=\eta$ and the two noise exponents (4.14). The signal characteristic function is supported on $[-4,4]$, while the difference of the exponents is supported on $\mathcal B_T$, disjoint from that interval. All observation characteristic functions then agree under the two different exponents, for every design. The common density can still be identified when $I\gt 0$ by Proposition 2.4. This example does not assert that every parameter class has this particular nuisance alias; it illustrates why full nuisance recovery is unnecessary.

There are several explicit limits to the results. The exposure interval is fixed and bounded away from zero. If it expands or approaches zero with $N$, a scalar $I_N$ need not summarize the relevant error amplification. Ordinary-smooth envelopes are not covered: there, constants in an exponential amplification bound become rate exponents and cannot be discarded as they are in a logarithmic rate. The noise is symmetric, so its exponent is real; an unknown drift or general asymmetric phase requires additional work. The procedure knows $\beta$ and an envelope constant; it does not adapt to an unknown envelope. No multidimensional or adaptive-design theorem is asserted.

Theorem 2.3 holds for each fixed positive jump-intensity allowance. Its constants may deteriorate as that allowance tends to zero. Section 8 supplies an additional uniform analysis for a known baseline and a supplied shrinking radius. Section 9 resolves joint uncertainty in an unknown Gaussian variance and a supplied shrinking jump allowance. Section 10 resolves the global cost of unknown-radius adaptation for a fixed known stable baseline. Unknown-radius adaptation in the joint Gaussian–jump model, and a matching adaptive lower bound for every baseline in (8.1), remain outside the results. All rate comparisons are up to fixed multiplicative constants; no efficient constants or finite-sample optimal designs beyond the elementary information bound are established.

The numerical materials accompanying this manuscript check formulas, positivity, selected integrals, and finite designs. They cannot establish the uniform minimax quantifiers. Those quantifiers rest on the analytical proofs in Sections 3--6 and 8--10. The novelty claim is restricted to the exact combination of model, parameter classes, design uniformity, and comparison theorems stated here; it is subject to the documented literature limits and future external review.

# 8. A uniform shrinking-neighborhood theorem with a known baseline

The fixed-radius statement in Theorem 2.3 leaves a genuine quantifier gap: its constants do not describe radii tending to zero. We now solve that additional problem when the baseline convolution semigroup is known. This is a separate statistical experiment; the baseline is supplied to the estimator.

Fix $\Lambda_{\max},c_-,c_+,D_0\gt0$ and $m\ge0$. Let $\psi_0$ be any known real symmetric Lévy exponent satisfying

$$
\begin{aligned}
0\le\psi_0(t)&\le c_+(1+|t|^\beta) &&(t\in\mathbb R),\\
\psi_0(t)&\ge c_-|t|^\beta &&(|t|\ge1),\\
|\psi_0'(t)|+|\psi_0''(t)|&\le D_0(1+|t|)^m &&(|t|\ge1).
\end{aligned} \tag{8.1}
$$

The derivatives in the last line are continuous on the two exterior intervals. Denote its semigroup by $K_a$, with characteristic function $e^{-a\psi_0}$. Stable baselines $\psi_0(t)=c|t|^\beta$ satisfy these conditions for suitable fixed constants; the conditions also permit known supersmooth semigroups with additional regular components. No moment assumption on $K_a$ is imposed.

For a supplied radius $0\le\Lambda\le\Lambda_{\max}$, the unknown perturbation is any symmetric finite nonnegative measure $\nu$ of mass at most $\Lambda$. Put

$$
j_\nu(t)=\int(1-\cos(tx))\nu(dx),\qquad
\phi_{Y_i}(t)=\phi_f(t)e^{-a_i(\psi_0(t)+j_\nu(t))}. \tag{8.2}
$$

An atom of $\nu$ at zero is immaterial. The density class and design assumptions remain (1.4)--(1.5) and $a_i\in[1,A]$. Let $\mathcal R_N(a,\Lambda;\psi_0)$ be the minimax squared-$L^2$ risk in this experiment, with $\psi_0$ and $\Lambda$ available to the estimator. Unlike the nuisance function, these quantities are not estimated from the data.

**Theorem 8.1 (uniform neighborhood boundary).** Write $q=2s/\beta$. There are positive constants $c_*,C_*$ depending only on the fixed class parameters, including $\Lambda_{\max},c_-,c_+,D_0,m$, such that, simultaneously for every baseline satisfying (8.1), $N\ge2$, $a\in[1,A]^N$, and $0\le\Lambda\le\Lambda_{\max}$,

$$
\begin{aligned}
c_* H_N(a,\Lambda)&\le \mathcal R_N(a,\Lambda;\psi_0)
\le C_* H_N(a,\Lambda),\\
H_N(a,\Lambda)&=[\log(e+N)]^{-q}
+\Lambda^2[\log(e+I\Lambda^2)]^{-q}.
\end{aligned} \tag{8.3}
$$

In particular, the constants are independent of the shrinking radius. The right side is uniformly bounded for the fixed class parameters, so taking its minimum with one gives an equivalent formulation. One estimator attains the upper bound for every fixed $s\gt0$ without using $s$. It uses the supplied radius and baseline. At $\Lambda=0$, (8.3) is exactly the known-baseline order, even for $I=0$.

## 8.1. An estimator that calibrates only where it is useful

Since $0\le j_\nu(t)\le2\Lambda$, its possible range shrinks with the radius. Choose a fixed $\kappa\gt0$ with $2Ac_+\kappa\le1/2$, and set

$$
T_N^\beta=\kappa\log(e+N),\qquad D=I\Lambda^2. \tag{8.4}
$$

If $D\lt1$, put $\widehat j(t)=0$ at every frequency. If $D\ge1$, define

$$
U=\min\{T_N,[\kappa\log(e+D)]^{1/\beta}\}. \tag{8.5}
$$

For $|t|\le U$, let $\widehat j(t)$ be the smallest minimizer, over $u\in[0,2\Lambda]$, of

$$
\left|\sum_iw_i e^{a_i(\psi_0(t)+u)}e^{itY_i}\right|. \tag{8.6}
$$

Set $\widehat j(t)=0$ for $U\lt|t|\le T_N$. The estimated Fourier function is

$$
\widetilde\phi(t)=\mathbf1_{\{|t|\le T_N\}}
\frac1N\sum_i e^{a_i(\psi_0(t)+\widehat j(t))}e^{itY_i}. \tag{8.7}
$$

Its inverse Fourier transform is the estimator. The zero-radius and small-$D$ branches involve no division by $I$. For $D\ge1$, both $I$ and $\Lambda$ are positive. The measurable-selection argument in Appendix A applies to $u=2\Lambda v$; the deterministic change at $U$ preserves measurability. All data may be used at both steps.

Let $j=j_\nu(t)$ and $\xi_i=e^{itY_i}-\mathbb E e^{itY_i}$. The population score in (8.6) is

$$
F_t(u)=\phi_f(t)\sum_iw_i e^{a_i(u-j)}.
$$

The interval $[0,2\Lambda]$ contains $j$. With

$$
V_t=\sup_{0\le u\le2\Lambda}
\left|\sum_iw_i e^{a_i\psi_0(t)}e^{a_i u}\xi_i\right|,
$$

Lemmas 3.1--3.2 and minimality give

$$
|\phi_f(t)|\,|\widehat j(t)-j|
\le \frac{2e^{2A\Lambda_{\max}}V_t}{I},\qquad
\mathbb E V_t^2\le I e^{2A\psi_0(t)+4A\Lambda_{\max}}. \tag{8.8}
$$

The empirical reconstruction term is bounded in second moment by
$C e^{2A\psi_0(t)}/N$, using Lemma 3.2 with coefficients $e^{a_i\psi_0(t)}/N$. The population multiplier obeys

$$
\left|N^{-1}\sum_i e^{a_i(\widehat j-j)}-1\right|
\le A e^{2A\Lambda_{\max}}|\widehat j-j|.
$$

Consequently, on the calibrated interval its contribution is at most $C e^{2A\psi_0(t)}/I$. None of these bounds divides by $\phi_f(t)$. On the uncalibrated interval, the population multiplier is $N^{-1}\sum_i e^{-a_i j}$; its distance from one is at most $2A\Lambda$. The integrated squared error there is therefore at most

$$
C\Lambda^2\int_{|t|\gt U}|\phi_f(t)|^2dt
\le C\Lambda^2(1+U^2)^{-s}, \tag{8.9}
$$

when $U\lt T_N$. This term is absent when $U=T_N$.

The truncation bias and the integrated empirical variance are bounded by

$$
C(1+T_N^2)^{-s}
+\frac{CT_N}{N}e^{2Ac_+(1+T_N^\beta)}
\le C_s[\log(e+N)]^{-q}. \tag{8.10}
$$

For $D\ge1$, the integrated calibration contribution is at most

$$
\begin{aligned}
\frac{CU}{I}e^{2Ac_+(1+U^\beta)}
&\le C\Lambda^2 D^{-1}(e+D)^{1/2}[\log(e+D)]^{1/\beta}\\
&\le C_s\Lambda^2[\log(e+D)]^{-q}.
\end{aligned} \tag{8.11}
$$

If $U\lt T_N$, (8.5) makes (8.9) of this same order. If $D\lt1$, ignoring the perturbation at all frequencies contributes at most $C\Lambda^2$, and $\log(e+D)$ is bounded above and below by positive constants. This proves the upper bound uniformly, including $\Lambda=0$.

## 8.2. A denominator that remains positive as the radius vanishes

The one-jump denominator used in Section 4 has a constant proportional to jump intensity. It cannot prove a radius-uniform lower bound. Instead place a fixed, small amount of the density $\eta$ in the signal itself.

First establish a uniform property of the known baseline. If $Z\sim K_a$, then Fourier inversion of a Gaussian and Fubini's theorem give

$$
\begin{aligned}
\mathbb E e^{-Z^2/2}
&=\frac1{\sqrt{2\pi}}\int e^{-t^2/2-a\psi_0(t)}dt\\
&\ge\frac1{\sqrt{2\pi}}\int
 e^{-t^2/2-Ac_+(1+|t|^\beta)}dt=:d_0\gt0.
\end{aligned} \tag{8.12}
$$

Choose $R_0$ with $e^{-R_0^2/2}\le d_0/2$. Since the integrand random variable is at most one on $|Z|\le R_0$ and at most $d_0/2$ outside, $K_a([-R_0,R_0])\ge d_0/2$. Lemma 4.1 then gives

$$
(\eta*K_a)(x)\ge c(1+x^2)^{-2}, \tag{8.13}
$$

uniformly over $a\in[1,A]$ and every permitted baseline. This argument does not use noise moments or a density for $K_a$.

Use $q_T$ from Lemma 4.2, with its amplitude chosen small enough to leave a fixed Sobolev margin, and set

$$
r_T=(1-\tau)q_T+\tau\eta,\qquad 0\lt\tau\lt1. \tag{8.14}
$$

Choose $\tau$ sufficiently small that $r_T$ retains fixed Sobolev and second-moment margins uniformly over $T\ge10$. This is possible because $q_T$ can be kept arbitrarily close in $H^s$ to the strict interior Gaussian, its second moment is at most $b$, and $\eta$ has finite second moment and belongs to every $H^s$ by its compactly supported Fourier transform.

Choose $\lambda_*\gt0$ so small that convolving $r_T$ with any of the measures $\mathrm{CP}(\bar a\nu_\pm)$ from Section 4, of intensity at most $A\lambda_*$, preserves the moment bound. Convolution contracts the Sobolev norm. Fix

$$
0\lt\rho\le\min\{1,\lambda_*/\Lambda_{\max}\},\qquad
\lambda=\rho\Lambda. \tag{8.15}
$$

For $\Lambda\gt0$, take $\nu_\pm=\lambda\eta(x)(1\pm\epsilon\cos(Tx))dx$ with fixed $0\lt\epsilon\le1/2$. They have mass $\lambda\le\Lambda$ and equal second moments. As in Section 4, set

$$
f_1=r_T*\mathrm{CP}(\bar a\nu_-),\qquad
f_2=r_T*\mathrm{CP}(\bar a\nu_+), \tag{8.16}
$$

and use observation perturbations $\nu_+$ and $\nu_-$, respectively. Both parameter pairs are legal. On the high-frequency bands, $\widehat\eta$ vanishes, so $\widehat r_T=(1-\tau)\widehat q_T$. The separation calculation in Lemma 4.3, now retaining the intensity explicitly, yields

$$
\|f_1-f_2\|_2^2\ge c\lambda^2(1+T^2)^{-s}. \tag{8.17}
$$

In fact, on a fixed interval around $T$, $\widehat q_T\ge c\alpha_T$, $H_T\ge c$, and $\sinh(\bar a\lambda\epsilon H_T/2)\ge c\lambda$. All remaining exponential factors have bounds independent of $\lambda\in(0,\lambda_*]$.

Let $p_i,q_i$ be the two observation densities. Their total compound-Poisson intensity is $\lambda(\bar a+a_i)\le2A\lambda_*$. Its zero-jump atom, together with the $\tau\eta$ part of $r_T$ and (8.13), gives

$$
q_i(x)\ge e^{-2A\lambda_*}\tau(\eta*K_{a_i})(x)
\ge c_d(1+x^2)^{-2}. \tag{8.18}
$$

Crucially, $c_d$ is independent of $\Lambda$.

The observation Fourier difference is exactly

$$
2\widehat r_T(t)e^{-a_i\psi_0(t)}
 e^{-(\bar a+a_i)\lambda(1-\widehat\eta(t))}
 \sinh\!\left(\frac{w_i\lambda\epsilon H_T(t)}2\right). \tag{8.19}
$$

It is supported on $\mathcal B_T$ and is zero if $w_i=0$. Its first two derivatives retain the factor $w_i\lambda$. On $\mathcal B_T$, (8.1) bounds the baseline multiplier and its derivatives by a fixed polynomial in $T$ times $e^{-cT^\beta}$. The other factors and their first two derivatives are uniformly bounded, apart from the displayed $w_i\lambda$ factor; this uses $\lambda\le\lambda_*$ and the fixed width of the bands. Thus, for a fixed finite exponent $b_0$,

$$
\chi^2(p_i,q_i)\le Cw_i^2\lambda^2(1+T)^{b_0}e^{-cT^\beta},\qquad
\mathrm{KL}(P_1,P_2)\le CI\lambda^2(1+T)^{b_0}e^{-cT^\beta}. \tag{8.20}
$$

The weighted Plancherel step is exactly the $0,1,2$ derivative calculation of (4.21), now using (8.18). All constants are uniform over the baseline class and the radius. The $C^2$ band edges justify that step without any differentiation at frequency zero.

Choose $T^\beta=K\log(e+I\lambda^2)$ with a fixed sufficiently large $K$, ensuring $T\ge10$. The last expression in (8.20) is at most $1/8$ uniformly for every $I\lambda^2\ge0$. The two-point inequality and (8.17) give

$$
\mathcal R_N(a,\Lambda;\psi_0)
\ge c\lambda^2[\log(e+I\lambda^2)]^{-q}
\ge c\rho^2\Lambda^2[\log(e+I\Lambda^2)]^{-q}. \tag{8.21}
$$

At $\Lambda=0$ this lower term is zero and needs no two-point construction.

## 8.3. The sample-size term and the resulting boundary

The class always includes $\nu=0$. For that subclass, take $f_0=(1-\tau)g_b+\tau\eta$ and $f_1=f_0+d_T\eta\cos(Tx)$ as in (6.1), with fixed sufficiently small $\tau$ and amplitude. These are legal signals and have squared separation at least $c(1+T^2)^{-s}$. Their observation Fourier difference is $(d_T/2)H_T e^{-a_i\psi_0}$. Equation (8.13), with the $\tau\eta$ component of $f_0$, supplies a denominator independent of the radius. The derivative calculation just used gives product KL at most $CNd_T^2(1+T)^{b_0}e^{-cT^\beta}$. Taking $T^\beta=K\log(e+N)$ proves the lower bound $c[\log(e+N)]^{-q}$ uniformly over (8.1). The maximum of this bound and (8.21) is at least half their sum. This completes Theorem 8.1.

For example, suppose $I_N\asymp(\log N)^p$ and $\Lambda_N\asymp(\log N)^{-r}$, with fixed $p,r\ge0$ and positive comparison constants. The second term of (8.3) is

$$
\begin{cases}
(\log N)^{-2r}(\log\log N)^{-q},&p\gt2r,\\
(\log N)^{-2r},&p\le2r.
\end{cases} \tag{8.22}
$$

It is no larger in order than the known-baseline term exactly when $r\ge s/\beta$. The distinction between fixed and shrinking radii is therefore quantitative, not an interchange of nonuniform constants. More generally, the necessary and sufficient rate-order condition for retaining the oracle order is

$$
\Lambda_N^2[\log(e+I_N\Lambda_N^2)]^{-q}
\lesssim[\log(e+N)]^{-q}. \tag{8.23}
$$

The result permits uniform consistency even at equal exposures when the permitted radius tends to zero. This does not contradict Proposition 2.4, which concerns a fixed unknown-semigroup class. Theorem 8.1 assumes the radius and the entire baseline are supplied. The next two sections address the joint problem with an unknown Gaussian coefficient and a supplied shrinking allowance, and the cost of an unknown radius when the baseline remains supplied.

# 9. Joint Gaussian-scale and shrinking jump uncertainty

The known-baseline experiment in Section 8 separates a supplied convolution exponent from an unknown finite-jump perturbation. We now allow the Gaussian baseline coefficient to be unknown as well. The interaction changes the radius-uniform risk: the Gaussian calibration term and the known-baseline jump term cannot simply be added. We also distinguish recovery of the common signal from recovery of the Gaussian component of the noise.

The Gaussian-plus-jump decomposition and instability of Gaussian-component estimation are classical concerns in Lévy inference. The statements below concern the particular unpaired common-signal experiment, its arbitrary bounded exposure design, and simultaneous uniformity in a shrinking jump-intensity radius. They do not claim that Gaussian-component instability is a new general phenomenon.

## 9.1. Experiment and conclusions

Retain the signal class $\mathcal F_{s,L,M}$, strict Gaussian interior condition (1.5), and deterministic design $a\in[1,A]^N$. Fix a known nondegenerate interval $0\lt v_-\lt v_+\lt \infty$ and a known $\Lambda_{\max}\gt 0$. For each supplied radius $\Lambda\in[0,\Lambda_{\max}]$, let

$$
\begin{aligned}
\mathcal V_\Lambda
&=\{\nu\ge0:\nu\text{ is a symmetric finite measure},\ \nu(\mathbb R)\le\Lambda\},\\
\psi_{v,\nu}(t)&=vt^2/2+j_\nu(t),\qquad
j_\nu(t)=\int(1-\cos(tx))\nu(dx),\qquad v\in[v_-,v_+].
\end{aligned}\tag{9.1}
$$

No moment restriction is imposed on $\nu$. As before, an atom at zero is immaterial. The observation characteristic functions are $\phi_f(t)e^{-a_i\psi_{v,\nu}(t)}$. Define

$$
\begin{aligned}
R_N^{\mathrm{G+J}}(a,\Lambda)
&=\inf_{\widehat f}\sup_{\substack{f\in\mathcal F_{s,L,M},\ v\in[v_-,v_+]\\\nu\in\mathcal V_\Lambda}}
\mathbb E_{f,v,\nu,a}\|\widehat f-f\|_2^2,\\
V_N^{\mathrm{G+J}}(a,\Lambda)
&=\inf_{\widehat v}\sup_{\substack{f\in\mathcal F_{s,L,M},\ v\in[v_-,v_+]\\\nu\in\mathcal V_\Lambda}}
\mathbb E_{f,v,\nu,a}(\widehat v-v)^2.
\end{aligned}\tag{9.2}
$$

The infima are over all measurable, possibly randomized estimators with values in $L^2(\mathbb R)$ and $\mathbb R$, respectively. They may use the design, supplied radius, and fixed class parameters, but not $f,v,\nu$. Put

$$
r=\min(s,2),\qquad D=I\Lambda^2,\qquad
\ell=\log(e+D),\qquad
J_s(I,\Lambda)=\ell^{-s}\min\{1,\Lambda\ell\}^{r}.
\tag{9.3}
$$

**Theorem 9.1 (joint density-risk law).** Uniformly over $N\ge2$, every $a\in[1,A]^N$, and $0\le\Lambda\le\Lambda_{\max}$,

$$
R_N^{\mathrm{G+J}}(a,\Lambda)
\asymp
\min\left\{1,
[\log(e+N)]^{-s}+(1+I)^{-r/2}+J_s(I,\Lambda)\right\}.
\tag{9.4}
$$

Comparison constants depend only on the fixed signal parameters, Gaussian interval, $A$, and $\Lambda_{\max}$. In particular, they are independent of $\Lambda,N$, and the design. One estimator attains the upper bound for every fixed $s\gt 0$ without using $s$.

For $\Lambda\ell\lt 1$, the interaction term equals

$$
J_s(I,\Lambda)=
\begin{cases}
\Lambda^s,&0\lt s\le2,\\
\Lambda^2\ell^{2-s},&s\ge2.
\end{cases}
\tag{9.5}
$$

The expressions agree at $s=2$. For $\Lambda\ell\ge1$, the term is $\ell^{-s}$. At $\Lambda=0$ it vanishes, recovering Theorem 2.2. For each fixed positive radius and $I\to\infty$, it recovers the unknown-semigroup logarithmic order. The additional term in the supplied Gaussian-baseline experiment of Section 8 is instead $\Lambda^2\ell^{-s}$.

For the component-identification statement, define the narrower signal class

$$
\mathcal F^+_{s,L,M}
=\{f\in\mathcal F_{s,L,M}:\phi_f(t)\text{ is real and strictly positive for every }t\}.
\tag{9.6}
$$

Let $V_N^+(a,\Lambda)$ denote the second infimum in (9.2) with this restricted signal class.

**Theorem 9.2 (component risk and identification).** Uniformly under the assumptions of Theorem 9.1,

$$
V_N^{\mathrm{G+J}}(a,\Lambda)
\asymp V_N^+(a,\Lambda)
\asymp\min\{1,(1+I)^{-1}+\Lambda^2\}.
\tag{9.7}
$$

For every $\Lambda\gt 0$, there exist two different Gaussian coefficients, two legal jump measures, and the same signal in $\mathcal F_{s,L,M}$ that produce identical observation laws for every exposure time in $[1,A]$. Thus the Gaussian component is not identifiable throughout the full signal class, even for an informative design. The common signal itself is identifiable when $I\gt 0$, as in Proposition 2.4. In the restricted class $\mathcal F^+_{s,L,M}$, the Gaussian component is identifiable if and only if $I\gt 0$, but for any fixed positive radius it is not uniformly consistently estimable, by (9.7). This last distinction requires no contradiction: the restricted class has no uniform quantitative lower envelope for its characteristic functions.

**Theorem 9.3 (a weak-design oracle boundary).** Suppose $N\to\infty$ and, with fixed positive comparison constants,

$$
I_N\asymp(\log N)^p,\qquad
\Lambda_N\asymp(\log N)^{-\alpha},\qquad p,\alpha\ge0.
\tag{9.8}
$$

The joint-model density risk has the Gaussian known-noise order $(\log N)^{-s}$ if and only if

$$
p\ge\max(s,2),\qquad
\alpha\ge\max(1,s/2).
\tag{9.9}
$$

These are comparisons of risk orders, not leading constants. For $0\lt s\lt 2$, the unknown Gaussian coefficient therefore strengthens the required radius decay from the supplied-baseline condition $\alpha\ge s/2$ to $\alpha\ge1$, even when the design already suffices for pure-Gaussian calibration.

## 9.2. Upper bound by conservative extrapolation and local calibration

Choose a fixed $k\gt 0$ with $kM\le1/4$, and put $t_0=\sqrt{2k}$. Then $c_f=\mathbb E\cos(t_0X)\ge3/4$. The true effective variance at this one frequency is

$$
u_0=v+j_\nu(t_0)/k\in[v_-,v_++2\Lambda/k].
\tag{9.10}
$$

For $I\ge1$, let $\widehat u$ be the smallest global minimizer on the supplied interval in (9.10) of

$$
\left|\sum_iw_i\cos(t_0Y_i)e^{ka_i u}\right|.
\tag{9.11}
$$

**Lemma 9.4 (effective-variance concentration).** For every fixed $p_0\gt 0$, $B_0\ge0$, and $\kappa_0\lt \infty$, if $T^2\le\kappa_0\sqrt I$, then

$$
\mathbb E\left[|\widehat u-u_0|^{p_0}
e^{B_0T^2|\widehat u-u_0|}\right]
\le C_{p_0,B_0,\kappa_0}I^{-p_0/2}.
\tag{9.12}
$$

The bound is uniform in the radius and other varying parameters.

*Proof.* The population score is $c_f\sum_iw_i e^{ka_i(u-u_0)}$. The centered identity of Lemma 3.1 and the fixed upper bound $v_++2\Lambda_{\max}/k$ give $|\widehat u-u_0|\le C U/I$, where $U$ is the supremum of the centered empirical score over its parameter interval. Lemma 3.2 gives $\mathbb EU\le C\sqrt I$. Changing observation $i$ changes $U$ by at most $C|w_i|$, with constants uniform in $\Lambda$. The bounded-differences inequality consequently bounds the upper tail of $U/\sqrt I$ by a Gaussian tail after a fixed shift. Thus $\sqrt I|\widehat u-u_0|$ has uniformly bounded moments multiplied by any fixed exponential. The condition on $T$ gives (9.12), as in the proof of Lemma 5.1. $\square$

Let $\Pi$ be projection onto $[v_-,v_+]$ and define

$$
\widetilde v=\Pi(\widehat u-2\Lambda/k),\qquad
\bar v=\Pi(u_0-2\Lambda/k),\qquad
b=v-\bar v,\qquad e_v=\widetilde v-\bar v.
\tag{9.13}
$$

Monotonicity and nonexpansiveness of projection give

$$
0\le b\le2\Lambda/k,\qquad |e_v|\le|\widehat u-u_0|.
\tag{9.14}
$$

Only the deterministic part of the error is one-sided. We do not require the random estimate $\widetilde v$ to be below $v$ in every sample.

For $I\lt 1$, use the zero density estimator. Assume $I\ge1$, and choose a fixed sufficiently small $\kappa\gt 0$. Put

$$
T^2=\kappa\min\{\log(e+N),\sqrt I\}.
\tag{9.15}
$$

If $D\lt 1$, define the estimated transform on all retained frequencies by

$$
\widehat\phi(t)=\mathbf1_{\{|t|\le T\}}
\frac1N\sum_i e^{a_i\widetilde v t^2/2}e^{itY_i}.
\tag{9.16}
$$

If $D\ge1$, set

$$
U=\min\{T,\sqrt{\kappa\ell}\}.
\tag{9.17}
$$

For $|t|\le U$, estimate the whole exponent by the smallest minimizer of the centered score (3.4) over

$$
0\le u\le R(t):=v_+t^2/2+2\Lambda,
\tag{9.18}
$$

and use the reconstruction in (3.8) at that frequency. For $U\lt |t|\le T$, use the Gaussian extrapolation in (9.16); outside $[-T,T]$, use zero. The inverse Fourier transform is the density estimator. Appendix A proves measurability of the two selections, and the deterministic split preserves it. The transform is bounded on its retained compact interval and has conjugate symmetry. All observations may be used in both steps because empirical errors are bounded uniformly over the possible chosen parameters.

The truncation error and the empirical error on the extrapolated frequencies satisfy

$$
\begin{aligned}
C(1+T^2)^{-s}
&\le C_s\{[\log(e+N)]^{-s}+I^{-s/2}\},\\
\frac{CT}{N}e^{Av_+T^2}
&\le C_s[\log(e+N)]^{-s},
\end{aligned}\tag{9.19}
$$

for sufficiently small $\kappa$. The second line follows from Lemma 3.2 before substituting the same-data estimate $\widetilde v\in[v_-,v_+]$.

On the extrapolated frequencies, the population reconstruction multiplier is

$$
\frac1N\sum_i\exp\{a_i(e_vt^2/2-d(t))\},\qquad
d(t)=bt^2/2+j_\nu(t)\in[0,C\Lambda(1+t^2)].
\tag{9.20}
$$

For $y\ge0$, the decomposition

$$
|e^{x-y}-1|\le |e^x-1|+(1-e^{-y})
\tag{9.21}
$$

separates the random Gaussian error from deterministic smoothing. Inequality (5.8), (9.12), and (9.14) bound the integrated contribution of the first term by

$$
C\mathbb E[|e_v|^r e^{AT^2|e_v|}]
\frac1{2\pi}\int |t|^{2r}|\phi_f(t)|^2dt
\le C I^{-r/2}.
\tag{9.22}
$$

Here $r\le s$ and $T^2\le\kappa\sqrt I$. No noise moment or signal characteristic-function lower bound was used.

For the deterministic contribution, an elementary exact maximization gives, for $x_0\ge1$,

$$
\sup_{x\ge x_0}x^{-s}\min\{1,\Lambda x\}^2
=x_0^{-s}\min\{1,\Lambda x_0\}^{r}.
\tag{9.23}
$$

Indeed, if $\Lambda x_0\lt 1$, the maximum is at $1/\Lambda$ when $s\lt 2$, at $x_0$ when $s\gt 2$, and is constant between these values when $s=2$. If $\Lambda x_0\ge1$, it is at $x_0$. At zero radius both sides are zero. Thus, on frequencies $|t|\gt U$, (9.20) contributes at most a constant times

$$
(1+U^2)^{-s}\min\{1,\Lambda(1+U^2)\}^{r}.
\tag{9.24}
$$

Changing the argument of the minimum by a fixed positive factor changes this bound by at most a fixed multiplicative factor. When $D\ge1$ and $U\lt T$, $1+U^2$ is uniformly comparable to $\ell$, and (9.24) is at most $C_sJ_s(I,\Lambda)$. When $U=T$, the extrapolated interval is empty. When $D\lt 1$, use the same argument with $U=0$; its bound is $C\Lambda^r\le CI^{-r/2}$.

It remains to bound the calibrated interval when $D\ge1$. The full-exponent estimate (3.10), with (9.18), gives

$$
\begin{aligned}
\int_{-U}^{U}\mathbb E|\widehat\phi(t)-\phi_f(t)|^2dt
&\le \frac{CU}{I}e^{3Av_+U^2+C\Lambda_{\max}}\\
&\le C\Lambda^2D^{-1}(e+D)^{1/2}\ell^{1/2}
\le C_s\Lambda^2\ell^{-s},
\end{aligned}\tag{9.25}
$$

where $3Av_+\kappa\le1/2$. On $D\ge1$, the polynomial-exponential factor in the second line is bounded by every fixed inverse power of $\ell$. The final expression is bounded by $C_sJ_s(I,\Lambda)$: if $\Lambda\ell\ge1$, use the fixed upper radius; otherwise its ratio to $J_s$ is $\Lambda^{2-r}\ell^{-r}$, uniformly bounded. Equations (9.19)–(9.25) prove the density upper bound. For $I\lt 1$, the Gaussian calibration term is bounded below by a fixed positive constant, so the zero estimator proves the same order. The sum in (9.4) is bounded by three; the minimum with one therefore changes only the comparison constant.

## 9.3. A bandlimited signal within the original parameter class

The lower bound uses exact compensation on the central Fourier support of a signal. This requires a legal compactly supported characteristic function while retaining the original strict class margins.

**Lemma 9.5 (positive bandlimited signal).** Under (1.5), there is an even probability density $p$ and a fixed $B\ge4$ such that $p$ has strict Sobolev and second-moment margins in $\mathcal F_{s,L,M}$,

$$
p(x)\ge c(1+x^2)^{-2},
\tag{9.26}
$$

and $\phi_p$ is real, nonnegative, $C^2$, and supported on $[-B,B]$.

*Proof.* With $r_0(x)=(\sin x/x)^4$ and its removable value at zero, define

$$
\eta_+(x)=\frac{r_0(x)+\tfrac14r_0(x-\pi/2)+\tfrac14r_0(x+\pi/2)}{\pi}.
\tag{9.27}
$$

It is an even probability density because $\int r_0=2\pi/3$. The denominator comparisons in Lemma 4.1 give $\eta_+(x)\ge c(1+x^2)^{-2}$. Its characteristic function is

$$
\widehat\eta_+(t)=\pi^{-1}\widehat r_0(t)
\{1+\tfrac12\cos(\pi t/2)\}\ge0.
\tag{9.28}
$$

The nonnegativity of $\widehat r_0$ also follows from its representation as a convolution of four uniform densities. Thus (9.28) is $C^2$ and supported on $[-4,4]$. Directly from the second moment and translation calculation of Lemma 4.1,

$$
m_+:=\int x^2\eta_+(x)dx=\frac34+\frac{\pi^2}{12}.
$$

Let $\eta_{+,R}(x)=R\eta_+(Rx)$ and set $p=g_b*\eta_{+,R}$, where $g_b$ is the strict interior Gaussian and one fixed $R\ge1$ is large enough that $b+m_+/R^2\lt M$. Convolution contracts the Sobolev norm, giving $\|p\|_{H^s}\le\|g_b\|_{H^s}\lt L$. Its second moment is $b+m_+/R^2$. Its characteristic function $e^{-bt^2/2}\widehat\eta_+(t/R)$ has the required Fourier properties with $B=4R$. The scaled polynomial lower bound, integrated over a bounded interval carrying positive Gaussian mass, proves (9.26). $\square$

For $T\ge4B+1$ choose fixed sufficiently small $\epsilon_0\gt 0$ and put

$$
\alpha_T=\epsilon_0(1+T^2)^{-s/2},\qquad
q_T(x)=p(x)\{1+\alpha_T\cos(Tx)\}.
\tag{9.29}
$$

Since $\phi_p(T)=\phi_p''(T)=0$, the perturbation has zero integral and zero second moment. Also $q_T\ge p/2$, and the weighted Fourier translation estimate of Lemma 4.2 gives a uniform Sobolev margin for small fixed $\epsilon_0$. The Fourier support of $q_T$ consists of the central band $[-B,B]$ and the two bands of radius $B$ about $\pm T$. On a fixed interval about $T$, its transform is at least $c\alpha_T$, by continuity and $\phi_p(0)=1$. The first two transform derivatives on the high bands are bounded by fixed multiples of $\alpha_T$.

## 9.4. Exact Gaussian–jump compensation by nonnegative measures

Choose an even smooth cutoff $\chi$ with $0\le\chi\le1$, equal to one on $[-B,B]$ and zero outside $[-2B,2B]$. Define

$$
H(t)=t^2\chi(t)/2,\qquad g=\mathcal F^{-1}H.
\tag{9.30}
$$

The function $g$ is real, even and Schwartz. Its integral is zero, so its positive and negative parts have a common finite mass

$$
K=\int g_+=\int g_-\gt 0,
\qquad \int x^2g(x)dx=-H''(0)=-1.
\tag{9.31}
$$

For $h\gt 0$, let $\nu_+(dx)=h g_+(x)dx$ and $\nu_-(dx)=h g_-(x)dx$. These are nonnegative symmetric finite Lévy measures with equal mass $hK$. Their jump exponents obey

$$
j_+(t)-j_-(t)=-hH(t).
\tag{9.32}
$$

Fix $v_0$ strictly inside $[v_-,v_+]$. The two noise exponents

$$
\psi_1(t)=v_0t^2/2+j_+(t),\qquad
\psi_2(t)=(v_0-h)t^2/2+j_-(t)
$$

then have difference

$$
\Delta\psi(t)=\psi_1(t)-\psi_2(t)
=\tfrac12ht^2\{1-\chi(t)\}.
\tag{9.33}
$$

It vanishes exactly on the central Fourier support of $p$ and equals $ht^2/2$ outside $[-2B,2B]$. Equation (9.31) also shows that the two noises have the same total second moment: only its allocation between the Gaussian and jump components changes.

Choose fixed $h_0\gt 0$ sufficiently small that $v_0-h_0\ge v_-$ and the moment margins in the next subsection are preserved. Fix

$$
0\lt \rho\le\min\{1,1/K,h_0/\Lambda_{\max}\},\qquad h=\rho\Lambda.
\tag{9.34}
$$

For every positive radius, both jump masses are at most $\Lambda$ and $h\le h_0$. The zero-radius interaction lower bound is zero and requires no construction.

## 9.5. Density separation and centered experimental distance

Define the two signals

$$
f_1=q_T*\operatorname{CP}(\bar a\nu_-),\qquad
f_2=q_T*g_{\bar a h}*\operatorname{CP}(\bar a\nu_+).
\tag{9.35}
$$

Convolution contracts Sobolev norm. By (9.31), their second moments are equal:

$$
\begin{aligned}
m_2(f_1)&=m_2(q_T)+\bar a h\int x^2g_-(x)dx,\\
m_2(f_2)&=m_2(q_T)+\bar a h\left(1+\int x^2g_+(x)dx\right)=m_2(f_1).
\end{aligned}\tag{9.36}
$$

The fixed choice of $h_0$ makes both less than $M$. These signals therefore belong to the original parameter class. Their Fourier difference is

$$
\widehat f_1(t)-\widehat f_2(t)
=\widehat q_T(t)e^{-\bar a j_-(t)}\{1-e^{-\bar a\Delta\psi(t)}\}.
\tag{9.37}
$$

It vanishes on the central band. Near $T$, the first factor is at least $c\alpha_T$, the compound-Poisson factor has a radius-uniform positive lower bound, and the last factor is at least $c\min\{1,hT^2\}$. Plancherel yields

$$
\|f_1-f_2\|_2^2
\ge c(1+T^2)^{-s}\min\{1,hT^2\}^2.
\tag{9.38}
$$

Compare observation parameters $(f_1,\psi_1)$ and $(f_2,\psi_2)$, with product laws $P_1,P_2$. Their $i$th characteristic-function difference is exactly

$$
D_i(t)=\widehat q_T(t)e^{-a_i v_0t^2/2}
e^{-\bar a j_-(t)-a_i j_+(t)}\{1-e^{w_i\Delta\psi(t)}\}.
\tag{9.39}
$$

It is supported only on the two high bands. On those bands, (9.33) and the identity

$$
e^{-a_iv_0t^2/2}\{1-e^{w_iht^2/2}\}
=-\frac{w_iht^2}{2}\int_0^1
e^{-[a_iv_0-\theta w_ih]t^2/2}d\theta
\tag{9.40}
$$

display the centered factor $w_i h$. Every Gaussian coefficient inside the integral lies between $a_iv_0$ and $a_i(v_0-h)+\bar a h$, hence in a fixed compact positive interval.

**Lemma 9.6 (centered distance bound).** There are fixed constants $C,c\gt 0$ and a finite integer $b_0$ such that

$$
\operatorname{KL}(P_1,P_2)
\le CIh^2(1+T)^{b_0}e^{-cT^2}.
\tag{9.41}
$$

*Proof.* The first two derivatives of $j_\pm$ are bounded by fixed multiples of $h$, since $g_\pm$ have finite absolute moments. The first two derivatives of $\widehat q_T$ on its high bands are bounded by fixed multiples of $\alpha_T$. Differentiating (9.40) at most twice retains $w_i h$ and introduces only fixed polynomial factors in $T$ beside a Gaussian factor. Thus

$$
\sum_{k=0}^2\|D_i^{(k)}\|_2^2
\le Cw_i^2h^2(1+T)^{b_0}e^{-cT^2}.
\tag{9.42}
$$

The factor $\alpha_T^2\le1$ can be discarded. Compact $C^2$ support eliminates distributional edge terms. The second observation density equals

$$
q_T*g_{a_i(v_0-h)+\bar a h}
*\operatorname{CP}(\bar a\nu_++a_i\nu_-).
$$

Its compound-Poisson zero-jump atom is uniformly positive; $q_T\ge c(1+x^2)^{-2}$; and its Gaussian variance stays in a fixed bounded interval. Integrating over a bounded interval carrying uniformly positive Gaussian mass gives a lower density bound $c_d(1+x^2)^{-2}$, uniform in $h,T$, and the design. Apply the weighted Plancherel identity (4.21), then $\mathrm{KL}\le\chi^2$, and sum over independent observations. Since $\sum_iw_i^2=I$, (9.41) follows. $\square$

Set $\ell_h=\log(e+Ih^2)$. Choose fixed sufficiently large $K_0$ such that $T^2\ge K_0\ell_h$ guarantees $T\ge4B+1$, places the polynomial-Gaussian bound in its decreasing range, and makes (9.41) at most $1/8$ uniformly in $Ih^2\ge0$. For $s\ge2$, take $T^2=K_0\ell_h$. Then (9.38) gives

$$
\|f_1-f_2\|_2^2
\ge c\ell_h^{-s}\min\{1,h\ell_h\}^2.
\tag{9.43}
$$

For $0\lt s\lt 2$, instead take

$$
T^2=\max\{K_0\ell_h,h^{-1}\}.
\tag{9.44}
$$

If the second branch applies, (9.38) is at least $c h^s$; if the first applies, it is at least $c\ell_h^{-s}$. Therefore

$$
\|f_1-f_2\|_2^2
\ge c\ell_h^{-s}\min\{1,h\ell_h\}^{s}.
\tag{9.45}
$$

Pinsker's inequality and the two-point bound prove the interaction lower bound. Because $h=\rho\Lambda$, concavity of the logarithm gives $\rho^2\ell\le\ell_h\le\ell$. In particular, $h\ell_h\ge\rho^3\Lambda\ell$, so $\min\{1,h\ell_h\}^{r}\ge\rho^{3r}\min\{1,\Lambda\ell\}^{r}$. Thus fixed rescaling changes (9.43)–(9.45) only by fixed positive factors, uniformly down to zero radius. This yields $R_N^{\mathrm{G+J}}\ge cJ_s(I,\Lambda)$. The pure-Gaussian subclass gives the other two terms by Theorem 2.2. Their maximum controls the sum within a fixed factor, completing the lower bound in Theorem 9.1.

## 9.6. Gaussian-component risk and the identification distinction

For the upper bound in Theorem 9.2, use $\widehat v=\Pi(\widehat u)$ without the conservative subtraction. Equations (9.10), (9.12), and nonexpansiveness give

$$
\mathbb E(\widehat v-v)^2\le C(I^{-1}+\Lambda^2),\qquad I\ge1.
\tag{9.46}
$$

A fixed estimate handles $I\lt 1$. Projection and the compact coefficient interval justify the constant truncation in (9.7). This bound holds over the full class and therefore over the restricted class as well.

For the exact nonidentification, take the same signal $p$ from Lemma 9.5 with each of the two noise exponents in (9.33). Since their difference vanishes on the support of $\phi_p$,

$$
\phi_p(t)e^{-a\psi_1(t)}=\phi_p(t)e^{-a\psi_2(t)}
\quad\text{for every }t\in\mathbb R\text{ and every }a\in[1,A].
\tag{9.47}
$$

All observation laws are identical, while the Gaussian coefficients differ by $h=\rho\Lambda$. The larger of the two squared-error risks of any estimator is at least $h^2/4$. This also explains why total-variance calibration cannot separate the Gaussian component: the two noises have the same total variance by (9.31).

To obtain the lower bound even for strictly positive signal characteristic functions, let

$$
p_\epsilon=(1-\epsilon)p+\epsilon g_b,\qquad \epsilon\gt 0.
\tag{9.48}
$$

It remains in the signal class by convexity of the norm and moment constraints. Because $\phi_p\ge0$ and the Gaussian characteristic function is positive, $\phi_{p_\epsilon}\gt 0$ everywhere. Under either noise parameter, a single observation is a mixture with weight $1-\epsilon$ of the common law in (9.47). Its total variation distance from that law is at most $\epsilon$, and the product distance is at most $N\epsilon$. The two product experiments with signal $p_\epsilon$ therefore have total variation at most $2N\epsilon$. Taking $\epsilon=1/(16N)$ preserves the coefficient separation and gives the lower bound $c\Lambda^2$ over $\mathcal F^+_{s,L,M}$. The pure-Gaussian calibration lower construction in Section 5.3 uses Gaussian signals with strictly positive transforms, and supplies $(1+I)^{-1}$ in this restricted class too. Their maximum proves (9.7).

If $I\gt 0$ and $\phi_f$ is everywhere positive, two distinct exposure times identify the entire exponent by their marginal ratio. Its Gaussian coefficient is then determined by

$$
v=\lim_{|t|\to\infty}\frac{2\psi_{v,\nu}(t)}{t^2},
\tag{9.49}
$$

because $0\le j_\nu\le2\Lambda$. This proves pointwise identification over the restricted class. If $I=0$, the exact pure-Gaussian heat-orbit alternatives in Section 5.3 show nonidentification even there. Over the full class, (9.47) shows that $I\gt 0$ still does not identify the Gaussian component. Neither statement contradicts identification of the common signal: where all marginal transforms vanish, every compatible signal transform is zero; where one is nonzero, the two-time argument identifies it. This is the positive direction of Proposition 2.4.

## 9.7. Proof and interpretation of the oracle boundary

Under (9.8), the Gaussian calibration term in (9.4) is no larger in order than $(\log N)^{-s}$ exactly when $p\ge\max(s,2)$. If $\alpha=0$, a fixed positive radius gives interaction order $(\log\log N)^{-s}$ when $p\gt 0$, and constant order when $p=0$, so the oracle order fails.

Assume $\alpha\gt 0$. Then $\Lambda_N\ell_N\to0$. If $p\le2\alpha$, the quantity $D_N$ is bounded, so $\ell_N\asymp1$ and $J_s\asymp\Lambda_N^r$; this is dominated by the Gaussian calibration term because $p\le2\alpha$. In this branch, the Gaussian oracle condition forces $\alpha\ge\max(1,s/2)$ whenever oracle performance is possible.

If $p\gt 2\alpha$, then $\ell_N\asymp\log\log N$. For $0\lt s\le2$, (9.5) gives $J_s\asymp(\log N)^{-\alpha s}$, so the required condition is $\alpha\ge1$. For $s\gt 2$, it gives

$$
J_s(I_N,\Lambda_N)
\asymp(\log N)^{-2\alpha}(\log\log N)^{2-s},
\tag{9.50}
$$

which is no larger than the oracle order exactly when $\alpha\ge s/2$, including equality. These cases establish both necessity and sufficiency of (9.9).

The lower construction explains the new term. A finite signed perturbation of a jump measure can compensate a change in Gaussian coefficient exactly on a fixed central Fourier interval; its positive and negative parts are both admissible jump measures. A legal signal can put its remaining Fourier mass in distant bands, with a zero region between them. The compensating measure therefore needs mass proportional to the Gaussian change, rather than proportional to that change times the distant frequency squared. The high bands distinguish the two allocations only after Gaussian attenuation, while centering the exposure times removes their common effect. This is the specific interaction responsible for (9.3), and is absent when the baseline is supplied. The upper estimator mirrors the information boundary by calibrating the whole exponent where the design supports it and using conservative Gaussian extrapolation elsewhere.

The joint theorem still assumes a supplied radius and the fixed Gaussian coefficient interval. It does not give an efficient leading constant, adaptation to an unknown radius in this joint model, or component identification under a quantitative characteristic-function lower envelope. Exact component nonidentification and the density-risk interaction are different conclusions; their parameter pairs and target losses have been kept separate throughout.

# 10. The optimal loss from not knowing the jump radius

The radius-uniform minimax law in Section 8 supplies the radius to the estimator. We now withhold that radius while retaining the known baseline. A single estimator can nearly attain every radius-specific risk, but a uniform constant-factor comparison is impossible over all designs. The exact order of the best simultaneous comparison is an iterated logarithm.

## 10.1. Experiment and main results

Keep the signal class and strict interior condition (1.4)--(1.5), the design interval $[1,A]$, and the known-baseline experiment (8.1)--(8.2). Fix $\Lambda_{\max}\gt 0$. The estimator receives the entire baseline $\psi_0$, the design, and the fixed class parameters, including the smoothness $s$; it does not receive $\Lambda\in[0,\Lambda_{\max}]$. This section concerns adaptation to the perturbation radius only.

For a measurable, possibly randomized estimator $\widehat f_{N,a}$ independent of the radius, define

$$
\mathscr R_N(\widehat f;a,\Lambda;\psi_0)
=\sup_{f\in\mathcal F_{s,L,M},\,\nu\ge0\ \mathrm{symmetric},\,\nu(\mathbb R)\le\Lambda}
\mathbb E_{f,\nu,a}\|\widehat f_{N,a}-f\|_2^2.
\tag{10.1}
$$

Use the abbreviations

$$
q=2s/\beta,\qquad b_N=\log(e+N),\qquad
\ell_N=\log(e+b_N),\qquad
g_N=[\log(e+\ell_N)]^q.
\tag{10.2}
$$

The known-radius benchmark and the upper envelope for a radius-free estimator are, respectively,

$$
\begin{aligned}
H_N(a,\Lambda)&=b_N^{-q}
+\Lambda^2[\log(e+I\Lambda^2)]^{-q},\\
\widetilde H_N(a,\Lambda)&=b_N^{-q}
+\Lambda^2[\log(e+I\Lambda^2/\ell_N)]^{-q}.
\end{aligned}
\tag{10.3}
$$

**Theorem 10.1 (a radius-free risk bound).** There is one estimator, independent of $\Lambda$, such that

$$
\mathscr R_N(\widehat f;a,\Lambda;\psi_0)
\le C\widetilde H_N(a,\Lambda)
\tag{10.4}
$$

simultaneously for every supplied baseline satisfying (8.1), $N\ge2$, $a\in[1,A]^N$, and $0\le\Lambda\le\Lambda_{\max}$. The constant may depend on the fixed class parameters, including $s$, but not on the design or radius. At $\Lambda=0$, the same estimator attains the known-baseline order $b_N^{-q}$.

To state the exact simultaneous loss, fix a supplied baseline and let

$$
\Gamma_N(\psi_0)=
\inf_{\{\widehat f_{N,a}:a\in[1,A]^N\}}
\ \sup_{a\in[1,A]^N}\ \sup_{0\le\Lambda\le\Lambda_{\max}}
\frac{\mathscr R_N(\widehat f;a,\Lambda;\psi_0)}{H_N(a,\Lambda)}.
\tag{10.5}
$$

The infimum is over design-aware estimator families that may use the known baseline and the fixed class parameters, but not the radius. This definition compares one family with the minimax orders for all supplied radii. By Theorem 8.1, replacing $H_N$ in (10.5) with the actual known-radius minimax risk changes $\Gamma_N$ by at most fixed factors.

**Theorem 10.2 (the optimal simultaneous adaptation loss).** For each fixed known stable baseline $\psi_0(t)=c|t|^\beta$, with $c\gt 0$ and $0\lt \beta\le2$,

$$
\Gamma_N(c|\cdot|^\beta)\asymp g_N
=[\log(e+\ell_N)]^{2s/\beta}
\qquad(N\to\infty).
\tag{10.6}
$$

In particular, $g_N\asymp(\log\log\log N)^{2s/\beta}$ for sufficiently large $N$, and no fixed-factor adaptation to every radius is possible uniformly over all designs. The upper side of (10.6) is uniform over the larger baseline class (8.1); the matching lower side is proved here for stable baselines. The theorem gives the optimal worst simultaneous ratio. It does not assert that $\widetilde H_N$ is the pointwise-optimal constrained risk at every individual design and radius.

## 10.2. Thresholded calibration without the radius

Put $B=2\Lambda_{\max}$. Choose a fixed $\kappa\gt 0$ satisfying $2Ac_+\kappa\le1/2$, and define

$$
T_N^\beta=\kappa b_N.
\tag{10.7}
$$

If $I\lt \ell_N$, set $\widehat j(t)=0$ for every retained frequency $|t|\le T_N$. If $I\ge\ell_N$, define

$$
T_c=\min\left\{T_N,
\bigl[\kappa\log(e+I/\ell_N)\bigr]^{1/\beta}\right\}.
\tag{10.8}
$$

For $|t|\le T_c$, form

$$
\begin{aligned}
G_t(u)&=\sum_iw_i e^{a_i(\psi_0(t)+u)}e^{itY_i},\qquad 0\le u\le B,\\
\widetilde j(t)&=\text{the smallest global minimizer of }|G_t(u)|,\\
S_t&=e^{A(\psi_0(t)+B)},\qquad
\tau_t=K S_t\sqrt{I\ell_N},
\end{aligned}
\tag{10.9}
$$

where $K\ge4$ is a fixed constant to be chosen below. Set

$$
\widehat j(t)=
\begin{cases}
0,&|G_t(0)|\le\tau_t,\\
\widetilde j(t),&|G_t(0)|\gt \tau_t.
\end{cases}
\tag{10.10}
$$

For $T_c\lt |t|\le T_N$, again set $\widehat j(t)=0$. The Fourier estimate is

$$
\widehat\phi(t)=\mathbf1_{\{|t|\le T_N\}}
\frac1N\sum_i e^{a_i(\psi_0(t)+\widehat j(t))}e^{itY_i},
\qquad
\widehat f(x)=\frac1{2\pi}\int_{-T_N}^{T_N}e^{-itx}\widehat\phi(t)dt.
\tag{10.11}
$$

The construction uses $\Lambda_{\max}$, not the unknown radius. Appendix A applies to the smallest compact minimizer in (10.9); the threshold comparison is Borel and the cutoffs are deterministic. Since the baseline is even and $G_{-t}$ is the complex conjugate of $G_t$, the selections and threshold decisions agree at opposite frequencies. Thus $\widehat f$ is real-valued. The Fourier estimate is bounded on a deterministic compact interval, so it defines a measurable $L^2$-valued estimator. All observations may be reused in both steps.

### A threshold-risk inequality

Fix a calibrated frequency, and abbreviate $\phi=\phi_f(t)$ and $j=j_\nu(t)\in[0,2\Lambda]\subset[0,B]$. Define

$$
\begin{aligned}
F(u)&=\mathbb E G_t(u)=\phi\sum_iw_i e^{a_i(u-j)},\\
W&=\sup_{0\le u\le B}|G_t(u)-F(u)|,\\
b(u)&=\phi\left\{N^{-1}\sum_i e^{a_i(u-j)}-1\right\},\qquad
\delta=|\phi|j.
\end{aligned}
\tag{10.12}
$$

The centered exponential identity (3.1) gives both inequalities

$$
e^{-AB}I|\phi||u-j|
\le|F(u)|
\le e^{AB}I|\phi||u-j|,
\qquad
|b(u)|\le Ae^{AB}|\phi||u-j|.
\tag{10.13}
$$

Because $F(j)=0$, minimality implies $|F(\widetilde j)|\le2W$ and hence

$$
|b(\widetilde j)|\le C W/I.
\tag{10.14}
$$

On the event $W\le\tau_t/2$, first suppose that the threshold chooses zero. Then $|F(0)|\le3\tau_t/2$, so (10.13) gives $\delta\le C\tau_t/I$. The direct bound $|b(0)|\le C\delta$ also holds. Therefore

$$
|b(0)|^2\le C\min\{\delta^2,\tau_t^2/I^2\}.
$$

If the threshold chooses $\widetilde j$, then $|F(0)|\ge\tau_t/2$. The upper side of (10.13) gives $\delta\ge c\tau_t/I$, while (10.14) gives $|b(\widetilde j)|\le C\tau_t/I$. Adjusting constants yields the same minimum bound. On the complementary event $W\gt \tau_t/2$, the calibrated choice satisfies (10.14). If zero is chosen instead, $|F(0)|\le\tau_t+W\lt 3W$, so (10.13) gives $|b(0)|\le C W/I$ as well. We have proved

$$
\mathbb E|b(\widehat j)|^2
\le C\min\{\delta^2,\tau_t^2/I^2\}
+CI^{-2}\mathbb E\!\left[W^2\mathbf1_{\{W\gt \tau_t/2\}}\right].
\tag{10.15}
$$

Lemma 3.2 gives $\mathbb EW\le S_t\sqrt I$. Changing one observation changes $W$ by at most $2|w_i|S_t$. The bounded-differences inequality consequently gives

$$
\mathbb P\{W\gt S_t\sqrt I(1+x)\}\le e^{-x^2/2},\qquad x\ge0.
\tag{10.16}
$$

For completeness, put $Z=W/(S_t\sqrt I)$ and $z_0=K\sqrt{\ell_N}/2\ge2$. For $z\ge z_0$, (10.16) implies $\mathbb P(Z\gt z)\le e^{-z^2/8}$. Tail integration then yields

$$
\begin{aligned}
\mathbb E[Z^2\mathbf1_{\{Z\gt z_0\}}]
&\le z_0^2e^{-z_0^2/8}+\int_{z_0}^\infty 2z e^{-z^2/8}dz\\
&=(z_0^2+8)e^{-z_0^2/8}
\le C_K e^{-K^2\ell_N/64}.
\end{aligned}
\tag{10.17}
$$

Since $\delta\le2\Lambda|\phi|$, substitution in (10.15) proves

$$
\mathbb E|b(\widehat j(t))|^2
\le C\min\left\{\Lambda^2|\phi_f(t)|^2,
\frac{\ell_Ne^{2A\psi_0(t)}}I\right\}
+\frac{Ce^{2A\psi_0(t)}}I e^{-K^2\ell_N/64}.
\tag{10.18}
$$

The constants absorb the fixed quantities $K$ and $B$. No signal characteristic function was divided out, so the inequality includes its zeros.

The empirical reconstruction term in the exact decomposition (3.9) is bounded uniformly over the same-data choice of $u\in[0,B]$. Lemma 3.2, with coefficients $e^{a_i\psi_0(t)}/N$, gives its mean square at most

$$
Ce^{2A\psi_0(t)}/N.
\tag{10.19}
$$

The decomposition into (10.18) and (10.19) is valid without independence between the selected parameter and the data; the supremum is taken before selecting it.

### Integration and proof of Theorem 10.1

Use $|x+y|^2\le2|x|^2+2|y|^2$ for the empirical and population terms, followed by Plancherel and Tonelli. The cutoff bias and integrated empirical term are, as in (8.10), at most

$$
C(1+T_N^2)^{-s}
+\frac{CT_N}N e^{2Ac_+(1+T_N^\beta)}
\le C_s b_N^{-q}.
\tag{10.20}
$$

If $I\lt \ell_N$, the perturbation is ignored everywhere. Its squared integrated bias is at most $C\Lambda^2\|f\|_2^2$. Since $I\Lambda^2/\ell_N\le\Lambda_{\max}^2$, this is at most a fixed multiple of the second term of $\widetilde H_N$.

Suppose now that $I\ge\ell_N$ and put $D=I\Lambda^2/\ell_N$. If $D\lt 1$, bound the minimum in (10.18) by its first term. Outside the calibrated interval the same deterministic bias bound applies. The resulting integral is at most $C\Lambda^2$, which has the required order because $\log(e+D)$ is bounded.

For $D\ge1$, split the frequency interval at

$$
U=\min\left\{T_c,[\kappa\log(e+D)]^{1/\beta}\right\}.
\tag{10.21}
$$

Below $U$, integrate the second branch of the minimum in (10.18). The result is at most

$$
\begin{aligned}
\frac{C\ell_N}I Ue^{2Ac_+(1+U^\beta)}
&\le C\Lambda^2D^{-1}(e+D)^{1/2}[\log(e+D)]^{1/\beta}\\
&\le C_s\Lambda^2[\log(e+D)]^{-q}.
\end{aligned}
\tag{10.22}
$$

The last inequality follows because a negative power of $D$ dominates any fixed power of its logarithm on $D\ge1$. Above $U$, use the first branch, also on the uncalibrated interval $(T_c,T_N)$. The Sobolev bound gives

$$
C\Lambda^2\int_{|t|\gt U}|\phi_f(t)|^2dt
\le C_s\Lambda^2(1+U^2)^{-s}.
\tag{10.23}
$$

When $U$ is the radius-dependent cutoff in (10.21), this has the required order. If $U=T_c=T_N$, there is no remaining interval inside $[-T_N,T_N]$. If $U=T_c\lt T_N$, use

$$
\log(e+D)\le C_{\Lambda_{\max}}\log(e+I/\ell_N)
\tag{10.24}
$$

to obtain the same conclusion, with a constant uniform over $\Lambda\le\Lambda_{\max}$.

It remains to integrate the last term of (10.18), only over the calibrated interval. With $x=I/\ell_N\ge1$, the bound is

$$
\begin{aligned}
\frac{C e^{-K^2\ell_N/64}}I
T_c e^{2Ac_+(1+T_c^\beta)}
&\le\frac{C e^{-K^2\ell_N/64}}{\ell_N}
x^{-1}(e+x)^{1/2}[\log(e+x)]^{1/\beta}\\
&\le C e^{-K^2\ell_N/64}.
\end{aligned}
\tag{10.25}
$$

The function of $x$ in the first line is bounded on $[1,\infty)$. Choose $K$ large enough that $K^2/64\ge q+1$. Since $e^{-\ell_N}=1/(e+b_N)$, (10.25) is at most $C b_N^{-q}$. This proves Theorem 10.1, including $I=0$ and $\Lambda=0$.

## 10.3. A legal constrained-risk construction

The lower argument fixes the known baseline $\psi_0(t)=c|t|^\beta$. Let $\eta$ be the density in Lemma 4.1. Choose a fixed sufficiently small $\tau\in(0,1)$ such that

$$
f_*=(1-\tau)g_b+\tau\eta
\tag{10.26}
$$

has strict Sobolev and second-moment margins in $\mathcal F_{s,L,M}$. Such a choice follows from the strict Gaussian interior and from the finite second moment and compact Fourier support of $\eta$. Write $m_*=\int x^2f_*(x)dx\lt M$, and choose a fixed

$$
0\lt \lambda_*\le\min\left\{\Lambda_{\max},
\frac{M-m_*}{2A m_\eta}\right\}.
\tag{10.27}
$$

For $0\lt \lambda\le\lambda_*$ set $\nu_\lambda(dx)=\lambda\eta(x)dx$ and $h(t)=1-\widehat\eta(t)$, so $j_{\nu_\lambda}=\lambda h$. Consider the following two parameters for each design:

$$
\begin{array}{lll}
P_0:&f_0=f_* *\operatorname{CP}(\bar a\nu_\lambda),&\nu=0,\\
P_1:&f_1=f_*,&\nu=\nu_\lambda.
\end{array}
\tag{10.28}
$$

Both signals are legal: convolution contracts their Sobolev norms and adds at most $A\lambda_*m_\eta$ to the centered second moment. The first parameter is in the exact zero-radius submodel; the second has radius $\lambda$. The null signal may depend on the design and on the alternative because the zero-radius risk takes a supremum over the entire signal class.

**Lemma 10.3 (separation and likelihood second moment).** There are fixed constants $d_*,C_*\gt 0$ such that the alternatives (10.28) satisfy

$$
\|f_1-f_0\|_2\ge d_*\lambda,
\qquad
1+\chi^2(P_1^{(N)}\Vert P_0^{(N)})
\le e^{C_*I\lambda^2}.
\tag{10.29}
$$

Here $P_j^{(N)}$ is the product observation law, and the constants do not depend on $N$, the design, or $\lambda\in(0,\lambda_*]$.

*Proof.* The characteristic function of $f_*$ is continuous and equals one at zero. Also $h(0)=h'(0)=0$ and $h''(0)=m_\eta\gt 0$. There is a fixed interval $J\subset(0,1)$ on which $\widehat f_*\ge1/2$ and $h\ge h_*\gt 0$. For $t\in J$,

$$
\begin{aligned}
|\widehat f_1(t)-\widehat f_0(t)|
&=|\widehat f_*(t)|\{1-e^{-\bar a\lambda h(t)}\}\\
&\ge\tfrac12\lambda h_*e^{-2A\lambda_*}.
\end{aligned}
\tag{10.30}
$$

We used $0\le h\le2$ and $1-e^{-x}\ge xe^{-x}$ for $x\ge0$. Plancherel on $J$ proves the separation.

Let $K_a$ be the stable baseline law. The single-observation densities are

$$
p_{0i}=f_* *K_{a_i}*\operatorname{CP}(\bar a\nu_\lambda),
\qquad
p_{1i}=f_* *K_{a_i}*\operatorname{CP}(a_i\nu_\lambda).
\tag{10.31}
$$

The zero-jump atom and $f_*\ge\tau\eta$ imply

$$
p_{0i}(x)\ge e^{-A\lambda_*}\tau(\eta*K_{a_i})(x)
\ge c_0(1+x^2)^{-2}.
\tag{10.32}
$$

To see uniformity, stable scaling gives fixed $R,p\gt 0$ such that $K_a([-R,R])\ge p$ for every $a\in[1,A]$. Convolve the polynomial lower bound on $\eta$ over that interval and use $1+(x-z)^2\le2(1+R^2)(1+x^2)$ for $|z|\le R$. The denominator constant is independent of $\lambda$; it does not use a jump event whose probability vanishes with the radius.

The Fourier difference is

$$
D_i(t)=\widehat f_*(t)e^{-a_i c|t|^\beta}
\{e^{-a_i\lambda h(t)}-e^{-\bar a\lambda h(t)}\}.
\tag{10.33}
$$

The braces have the exact representation

$$
-w_i\lambda h(t)\int_0^1
e^{-(\bar a+u w_i)\lambda h(t)}du.
\tag{10.34}
$$

Every differentiated expression therefore retains the factor $w_i\lambda$. We verify the derivative bound at the origin, where the stable exponent need not have two ordinary derivatives. The function $h$ is $C^2$, with bounded first two derivatives, and symmetry and the finite second moment give

$$
h(t)=O(t^2),\qquad h'(t)=O(|t|),\qquad h''(t)=O(1)
\quad(|t|\le1).
\tag{10.35}
$$

Consequently

$$
S_i(t)=h(t)\int_0^1e^{-(\bar a+u w_i)\lambda h(t)}du
$$

and its first two derivatives are bounded uniformly; their orders near zero are respectively $O(t^2)$, $O(|t|)$, and $O(1)$. The first two derivatives of $\widehat f_*$ are bounded by its finite moments. For $0\lt |t|\le1$, write $B_i(t)=e^{-a_i c|t|^\beta}$ and note

$$
|B_i'(t)|\le C|t|^{\beta-1},\qquad
|B_i''(t)|\le C\{|t|^{\beta-2}+|t|^{2\beta-2}\}.
\tag{10.36}
$$

In the second derivative of $\widehat f_*B_iS_i$, the possibly singular factors are multiplied by $S_i=O(t^2)$ or $S_i'=O(|t|)$. The resulting second derivative is bounded, and the first derivative tends to zero at the origin. Hence these classical derivatives on the two half-lines define the weak derivatives without a point mass at zero. For $|t|\ge1$, the stable exponential and its first two derivatives are bounded by $C(1+|t|)^2e^{-c|t|^\beta}$. The other factors and their first two derivatives are bounded. Thus

$$
\|D_i\|_2^2+2\|D_i'\|_2^2+\|D_i''\|_2^2
\le C w_i^2\lambda^2.
\tag{10.37}
$$

Weighted Plancherel for the density difference gives

$$
\int(1+x^2)^2|p_{1i}(x)-p_{0i}(x)|^2dx
=\frac1{2\pi}
\{\|D_i\|_2^2+2\|D_i'\|_2^2+\|D_i''\|_2^2\}.
\tag{10.38}
$$

Dividing by (10.32) yields $\chi^2(P_{1i}\Vert P_{0i})\le C_*w_i^2\lambda^2$. Likelihood second moments multiply for independent observations, so

$$
1+\chi^2(P_1^{(N)}\Vert P_0^{(N)})
=\prod_i\{1+\chi^2(P_{1i}\Vert P_{0i})\}
\le\exp\left(C_*\lambda^2\sum_iw_i^2\right).
\tag{10.39}
$$

This proves the second assertion, also when $I=0$, in which case the observation laws coincide exactly. $\square$

The constrained-risk principle used next is classical [BL96, DR21]. We include the Hilbert-space squared-error argument to specify the likelihood direction and constants needed here.

**Lemma 10.4 (constrained risk).** For two data laws $P_0,P_1$ and two targets $f_0,f_1\in L^2$, if

$$
\mathbb E_0\|\widehat f-f_0\|_2^2\le r_0,
\qquad J_0=\mathbb E_0(dP_1/dP_0)^2\lt \infty,
$$

then

$$
\mathbb E_1\|\widehat f-f_1\|_2^2
\ge(\|f_1-f_0\|_2-\sqrt{r_0J_0})_+^2.
\tag{10.40}
$$

*Proof.* Cauchy--Schwarz gives $\mathbb E_1\|\widehat f-f_0\|_2\le\sqrt{r_0J_0}$. The triangle inequality gives $\mathbb E_1\|\widehat f-f_1\|_2\ge\|f_1-f_0\|_2-\sqrt{r_0J_0}$. Jensen gives (10.40). If the alternative risk is infinite the conclusion is immediate. Randomization can be adjoined independently to both data laws and leaves $J_0$ unchanged. $\square$

**Proposition 10.5 (a finite-sample efficiency tradeoff).** In the fixed known stable-baseline experiment, if

$$
\mathscr R_N(\widehat f;a,0;\psi_0)\le r_0,
$$

then, for every $0\lt \lambda\le\min(\Lambda,\lambda_*)$,

$$
\mathscr R_N(\widehat f;a,\Lambda;\psi_0)
\ge\left(d_*\lambda-
\sqrt{r_0e^{C_*I\lambda^2}}\right)_+^2.
\tag{10.41}
$$

*Proof.* Apply the zero-radius risk bound to $f_0$ in (10.28), then use Lemmas 10.3--10.4. The alternative has jump mass $\lambda$ and belongs to the radius-$\Lambda$ class. $\square$

The bound may be maximized over its allowed $\lambda$. It is a finite-sample likelihood argument within the actual convolution experiment, with positive signals and Lévy measures. It does not replace that experiment by a Gaussian limit.

## 10.4. Proof of the optimal simultaneous loss

First prove the upper bound in Theorem 10.2. For $x\ge0$ and $\ell\ge1$,

$$
e+x\le\ell(e+x/\ell),\qquad
\frac{\log(e+x)}{\log(e+x/\ell)}
\le1+\log\ell\le C\log(e+\ell).
\tag{10.42}
$$

The second denominator is at least one. Since the first terms of $H_N$ and $\widetilde H_N$ agree, (10.42) gives

$$
\sup_{a,\Lambda}\frac{\widetilde H_N(a,\Lambda)}{H_N(a,\Lambda)}
\le Cg_N.
\tag{10.43}
$$

Theorem 10.1 therefore supplies the upper bound for every permitted known baseline, including the stable baseline under consideration.

For the lower bound, let $p=q/2$. Let $a_0=(1+A)/2$, $m=\lfloor N/2\rfloor$, and use $m$ observations each at $a_0-\delta_N$ and $a_0+\delta_N$, with an additional observation at $a_0$ if $N$ is odd, where

$$
\delta_N=\left(\frac{b_N^p}{2m}\right)^{1/2}.
\tag{10.44}
$$

For sufficiently large $N$, all exposures lie in $[1,A]$. Their mean is exactly $a_0$ and their information is $I_N=b_N^p$. Choose a fixed $\gamma\gt 0$ such that $C_*\gamma\lt q-p=q/2$, and set

$$
\Lambda_N^2=\frac{\gamma\ell_N}{b_N^p}.
\tag{10.45}
$$

This radius tends to zero and eventually is at most $\lambda_*$. Also $I_N\Lambda_N^2=\gamma\ell_N$.

Fix an arbitrary radius-free estimator family and let $B_N^*$ be its supremum ratio in (10.5). If $B_N^*\ge g_N$, the desired lower bound already holds. Otherwise its zero-radius risk at the design (10.44) is at most $g_N b_N^{-q}$. The ratio of the squared second term inside (10.41) to $\Lambda_N^2$ is then at most

$$
\begin{aligned}
\frac{g_Nb_N^{-q}e^{C_*I_N\Lambda_N^2}}{\Lambda_N^2}
&=\frac{g_N}{\gamma\ell_N}
b_N^{-(q-p)}(e+b_N)^{C_*\gamma}\\
&\longrightarrow0.
\end{aligned}
\tag{10.46}
$$

The strict power gap dominates the nested logarithms. Proposition 10.5 therefore gives, for all sufficiently large $N$ uniformly over the estimator family in this second case,

$$
\mathscr R_N(\widehat f;a_N,\Lambda_N;\psi_0)
\ge c\Lambda_N^2.
\tag{10.47}
$$

At the same design and radius,

$$
\begin{aligned}
H_N(a_N,\Lambda_N)
&=b_N^{-q}+\Lambda_N^2[\log(e+\gamma\ell_N)]^{-q}\\
&\asymp \Lambda_N^2g_N^{-1}.
\end{aligned}
\tag{10.48}
$$

Indeed, $p\lt q$ makes the oracle term negligible relative to the second term, and $\log(e+\gamma\ell_N)\asymp\log(e+\ell_N)$. Equations (10.47)--(10.48) give $B_N^*\ge cg_N$. Both cases thus have the same lower order. Taking the infimum over all families proves (10.6); no attaining estimator is required.

One can also retain a fixed oracle-order constraint at the exact baseline and vary the weak-design exponent. The same calculation gives the following more explicit consequence.

**Corollary 10.6 (the price near an efficiently estimated baseline).** Fix $0\lt p\lt q$ and $K_0\lt \infty$. Use designs with $I_N=b_N^p$ and radii $\Lambda_N^2=\gamma\ell_N/b_N^p$, where $0\lt \gamma\lt (q-p)/C_*$. Every estimator sequence satisfying

$$
\mathscr R_N(\widehat f;a_N,0;\psi_0)\le K_0b_N^{-q}
$$

has, eventually,

$$
\mathscr R_N(\widehat f;a_N,\Lambda_N;\psi_0)\ge c\Lambda_N^2,
\qquad
\frac{\mathscr R_N(\widehat f;a_N,\Lambda_N;\psi_0)}
{H_N(a_N,\Lambda_N)}\ge c'g_N.
\tag{10.49}
$$

*Proof.* Repeat (10.44)--(10.48) with this $p$, replacing the factor $g_N$ in the null risk by $K_0$. The ratio in (10.46) still tends to zero. $\square$

## 10.5. Scope of the adaptation result

The matching loss occurs along designs whose information tends to infinity while the exposure range remains fixed and the two exposure groups approach one another. It is therefore distinct from exact nonidentification at equal exposures. At equal exposures, the finite-sample bound (10.41) still applies, but the known-radius bias term itself is of order $\Lambda^2$.

The threshold in (10.9) protects the small risk available at the exact known baseline. The lower construction shows why that protection has a cost on nearby, weakly distinguished convolution alternatives. The constrained-risk method is inherited from prior work [BL96, DR21]; the specific centered-design transfer, radius comparison, and matching simultaneous factor concern the experiment defined here.

The entire baseline remains known in this section. The estimator may use the fixed smoothness $s$ to choose $K$, and no simultaneous adaptation to unknown $s$ or $\beta$ is asserted. The two-sided factor (10.6) is established for known stable baselines; (10.4) is the separate baseline-uniform upper statement. Neither theorem provides exact leading constants or a pointwise constrained-minimax characterization of every design and radius.

# Appendix A. Measurability and analytical conventions

**Lemma A.1 (smallest compact minimizer).** Let $h(z,u)$ be jointly continuous in $z$ in a Euclidean space and $u\in[0,1]$. The smallest minimizer $u_*(z)$ of $h(z,\cdot)$ is Borel measurable.

*Proof.* A minimizer exists by compactness, and the set of minimizers is compact, so it has a smallest element. Let $m(z)=\min_{[0,1]}h(z,\cdot)$ and $m_q(z)=\min_{[0,q]}h(z,\cdot)$ for rational $q\in[0,1]$. These functions are continuous: local uniform continuity on the compact parameter interval bounds the difference between minima by the supremum difference between functions. For $0\lt c\le1$,

$$
\{z:u_*(z)\lt c\}
=\bigcup_{q\in\mathbb Q\cap[0,c)}\{z:m_q(z)=m(z)\},
$$

a countable union of closed sets. The cases $c\le0$ and $c\gt 1$ are trivial. $\square$

For Section 3, put $u=R(t)v$ with $v\in[0,1]$ and $z=(Y_1,\ldots,Y_N,t)$. The objective is jointly continuous; $R(t)$ is continuous and positive. For Section 5 use an affine parametrization of $[v_-,v_+]$. The same affine reparametrization applies to the compact search intervals in Sections 8--10; zero-radius and zero-information branches use the explicit estimators specified there. Thus the selections made in the proofs are jointly measurable. On each deterministic cutoff interval, the estimated Fourier functions are bounded by a deterministic finite constant. They consequently define measurable random elements in the separable space $L^2$ (for example, by approximation with measurable simple functions), and the inverse Fourier transform preserves this measurability. Tonelli applies to all nonnegative squared-error integrals above.

We use the usual probability-measure convolution when a factor, such as a compound-Poisson law, has an atom. Every lower-bound signal is an explicitly defined density; convolving it with a probability measure preserves absolute continuity. Convolution identities, characteristic-function uniqueness, Plancherel, the bounded-differences inequality, KL data processing, and Pinsker's inequality are standard analytical/probabilistic tools; no Gaussian approximation to the observation experiment is used in their application here. The fourth-order weight in (4.21), (9.42), and (10.38) is applied to a difference of observation densities, not to a noise moment. Sections 4, 8, and 9 use Fourier-localized differences. In Section 10 the difference has two square-integrable weak Fourier derivatives because the perturbation vanishes to second order at the origin, as proved before (10.37).

# References

[J09] Jan Johannes. *Deconvolution with unknown error distribution*. The Annals of Statistics **37**(5A), 2301--2323 (2009). [DOI: 10.1214/08-AOS652](https://doi.org/10.1214/08-AOS652). Inspected author-available journal reprint: [arXiv:0705.3482](https://arxiv.org/abs/0705.3482).

[HR08] Marc Hoffmann and Markus Reiß. *Nonlinear estimation for linear inverse problems with error in the operator*. The Annals of Statistics **36**(1), 310--336 (2008). [DOI: 10.1214/009053607000000721](https://doi.org/10.1214/009053607000000721). [Journal reprint](https://arxiv.org/abs/0803.1956).

[DM08] Aurore Delaigle and Alexander Meister. *Density estimation with heteroscedastic error*. Bernoulli **14**(2), 562--579 (2008). [DOI: 10.3150/08-BEJ121](https://doi.org/10.3150/08-BEJ121). [Journal reprint](https://arxiv.org/abs/0805.2216).

[MSW10] Alexander Meister, Ulrich Stadtmüller and Christian Wagner. *Density deconvolution in a two-level heteroscedastic model with unknown error density*. Electronic Journal of Statistics **4**, 36--57 (2010). [DOI: 10.1214/09-EJS444](https://doi.org/10.1214/09-EJS444).

[G24] Guillaume Garnier. *Decompounding with unknown noise through several independent channels*. arXiv:2405.10588v1 (2024). [Preprint](https://arxiv.org/abs/2405.10588). The arXiv title uses “independents channels”; the title above follows the PDF. As inspected on 26 November 2026, arXiv lists only v1 and no journal reference; this is not treated as a journal publication.

[LW02] Oliver Linton and Yoon-Jae Whang. *Nonparametric Estimation with Aggregated Data*. Econometric Theory **18**(2), 420--468 (2002). [DOI: 10.1017/S0266466602182089](https://doi.org/10.1017/S0266466602182089). Model and theorem comparisons use the [2000 institutional working paper](https://sticerd.lse.ac.uk/dps/em/em397.pdf); the final typeset article was not available for a version-by-version comparison.

[K18] Johanna Kappus. *Nonparametric estimation for irregularly sampled Lévy processes*. Statistical Inference for Stochastic Processes **21**(1), 141--167 (2018). [DOI: 10.1007/s11203-016-9144-2](https://doi.org/10.1007/s11203-016-9144-2). [Author manuscript](https://arxiv.org/abs/1511.05780).

[M04] Alexander Meister. *On the effect of misspecifying the error density in a deconvolution problem*. The Canadian Journal of Statistics **32**(4), 439--449 (2004). [DOI: 10.2307/3316026](https://doi.org/10.2307/3316026). The theorem comparison uses the [2004 institutional working paper](https://www.f08.uni-stuttgart.de/.content/media/downloads/Mathematik/mathematische_berichte/2004/2004-003.pdf); the journal metadata and abstract were separately checked.

[KSU21] Kengo Kato, Yuya Sasaki and Takuya Ura. *Robust inference in deconvolution*. Quantitative Economics **12**(1), 109--142 (2021). [DOI: 10.3982/QE1643](https://doi.org/10.3982/QE1643). The comparison uses the publisher's abstract and accessible introductory model and methodological statements; it does not assert a line-by-line audit of all proofs.


[BL96] Lawrence D. Brown and Mark G. Low. *A constrained risk inequality with applications to nonparametric functional estimation*. The Annals of Statistics **24**(6), 2524–2535 (1996). [DOI: 10.1214/aos/1032181166](https://doi.org/10.1214/aos/1032181166). [Author-hosted original](https://faculty.wharton.upenn.edu/wp-content/uploads/2012/04/Constrained-risk-inequality-with-applications.pdf).

[DR21] John C. Duchi and Feng Ruan. *A constrained risk inequality for general losses*. Proceedings of the 24th International Conference on Artificial Intelligence and Statistics, PMLR **130**, 802–810 (2021). [Original proceedings paper](https://proceedings.mlr.press/v130/duchi21a.html).

[LG19] Haoyang Liu and Chao Gao. *Density estimation with contamination: minimax rates and theory of adaptation*. Electronic Journal of Statistics **13**(2), 3613–3653 (2019). [DOI: 10.1214/19-EJS1617](https://doi.org/10.1214/19-EJS1617). [Author preprint](https://arxiv.org/abs/1712.07801).

[ZR23] Peiliang Zhang and Zhao Ren. *Adaptive minimax density estimation on $\mathbb R^d$ for Huber's contamination model*. Information and Inference: A Journal of the IMA **12**(4), 3042–3066 (2023). [DOI: 10.1093/imaiai/iaad045](https://doi.org/10.1093/imaiai/iaad045). The inspected [correction](https://doi.org/10.1093/imaiai/iaae001) (2024) corrects an equation reference and a bibliography entry.

[LGS21] Haoyang Liu, Chao Gao and Richard J. Samworth. *Minimax rates in sparse, high-dimensional change point detection*. The Annals of Statistics **49**(2), 1081–1112 (2021). [DOI: 10.1214/20-AOS1994](https://doi.org/10.1214/20-AOS1994). The comparison concerns the model and main minimax results, not a verification of its full proof appendix.

[Ma02] Catherine Matias. *Semiparametric deconvolution with unknown noise variance*. ESAIM: Probability and Statistics **6**, 271–292 (2002). [DOI: 10.1051/ps:2002015](https://doi.org/10.1051/ps:2002015). [Author-hosted original](https://cmatias.perso.math.cnrs.fr/Docs/psns5.pdf).

[NR09] Michael H. Neumann and Markus Reiß. *Nonparametric estimation for Lévy processes from low-frequency observations*. Bernoulli **15**(1), 223–248 (2009). [DOI: 10.3150/08-BEJ148](https://doi.org/10.3150/08-BEJ148). [Author preprint](https://arxiv.org/abs/0709.2007).

[CDH10] Song Xi Chen, Aurore Delaigle and Peter Hall. *Nonparametric estimation for a class of Lévy processes*. Journal of Econometrics **157**(2), 257–271 (2010). [DOI: 10.1016/j.jeconom.2009.12.005](https://doi.org/10.1016/j.jeconom.2009.12.005). [Author-hosted journal paper](https://www.songxichen.com/Uploads/Files/Publication/Chen-Delaigle-Hall-JoE-2010.pdf).
