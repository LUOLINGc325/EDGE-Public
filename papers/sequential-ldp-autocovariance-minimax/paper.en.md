# Sequentially Private Gaussian Autocovariance Estimation

*A uniform minimax law and an adaptive filtering information bound*

AI-assisted research manuscript

25 November 2026

# Abstract

Let a centered real stationary Gaussian process have spectral density $f$ with $m\leq 2\pi f\leq M$, where $0<m<1<M$ are fixed and its variance is unknown. One observes a length-$n$ trajectory through arbitrary chronological, one-pass, sequentially interactive pure $\alpha$-locally differentially private channels. For estimation of its lag-$h$ autocovariance, we prove that the minimax mean squared error is, uniformly in $n\geq1$, $h\geq1$ and $\alpha>0$, of order $1\wedge[(n-h)_+(\alpha\wedge1)^4]^{-1}$, with the expression interpreted as $1$ when $n\leq h$. A noninteractive two-bit mechanism attains this order. The lower bound applies to every allowed history-adaptive channel, including standard Borel outputs and independent public randomness. Its main ingredient is a uniform information bound for a weakly dependent hidden Markov family with a parameter-independent invariant law. Bounded private likelihoods control both the posterior and its parameter derivative, producing two privacy factors in the conditional score. An even Gaussian chaos argument supplies the upper bound under the spectral box alone. The result concerns the order of minimax risk, not exact constants or fully interactive protocols that revisit observations.

**Status.** This is a research manuscript, not an externally peer-reviewed publication. This version contains no Lean proof or claim of kernel verification.

# 1. Model, result, and contribution

Write $\gamma(k)=\mathbb E[X_0X_k]$ and use the spectral convention
$$
\gamma(k)=\frac1{2\pi}\int_{-\pi}^{\pi}e^{ik\omega}w(\omega)\,d\omega,
\qquad w=2\pi f.
\tag{1.1}
$$
Let $\mathcal G(m,M)$ be the laws of centered real stationary Gaussian processes with a spectral density satisfying $m\leq w\leq M$ almost everywhere. Their variance $v=\gamma(0)$ is unknown and lies in $[m,M]$. No absolute summability of autocovariances, differentiability of $f$, or Sobolev constraint is assumed.

At time $i$, a protocol releases $Z_i$ in a standard Borel space using a Markov kernel
$$
Q_i(dz_i\mid X_i,z_{<i},u).
\tag{1.2}
$$
Here $U$ is public randomness independent of the process. Conditional on the raw trajectory and $U$, the transcript law is the sequential product of these kernels. The kernels may depend on $n,h,\alpha,m,M$ but not on the unknown process law. For every fixed history, public seed, raw inputs $x,x'$, and measurable $A$,
$$
Q_i(A\mid x,z_{<i},u)\leq e^\alpha Q_i(A\mid x',z_{<i},u).
\tag{1.3}
$$
This model permits vector-valued messages, arbitrary history dependence and independent local randomization. It does not permit a later kernel to inspect another raw coordinate, revisit an earlier observation, or use hidden shared randomness outside the product-kernel model. Statements about privacy throughout this paper refer to (1.3).

For squared error, define
$$
R_{\mathrm{SI}}(n,h,\alpha;m,M)
=\inf_{Q,\widehat\gamma}\sup_{P\in\mathcal G(m,M)}
\mathbb E_{P,Q}(\widehat\gamma(Z_{1:n},U)-\gamma_P(h))^2.
\tag{1.4}
$$
The estimator may be randomized; its independent randomization can be included in $U$. The analogous infimum over noninteractive protocols is $R_{\mathrm{NI}}$. Let
$$
N=(n-h)_+,\qquad a=\alpha\wedge1,\qquad
\Psi(N,\alpha)=
\begin{cases}1,&N=0,\\ \min\{1,(Na^4)^{-1}\},&N>0.\end{cases}
\tag{1.5}
$$

**Theorem 1 (uniform minimax law).** For every fixed $0<m<1<M<\infty$, there are constants $0<c_{m,M}\leq C_{m,M}<\infty$ such that, simultaneously for all $n\geq1$, $h\geq1$ and $\alpha>0$,
$$
c_{m,M}\Psi(N,\alpha)
\leq R_{\mathrm{SI}}(n,h,\alpha;m,M)
\leq R_{\mathrm{NI}}(n,h,\alpha;m,M)
\leq C_{m,M}\Psi(N,\alpha).
\tag{1.6}
$$
The upper bound is realized by the explicit two-bit estimator in Section 5. In particular, allowing chronological sequential interaction does not change the order of minimax risk for this scalar target over this class.

The constants in (1.6) are uniform in the lag. Thus the statement also covers $h=h_n$ near $n$, privacy levels tending to zero, and the regime with no observed lag-$h$ pairs. It does not say that every interactive mechanism is inferior to every noninteractive one, or that the exact optimal risks coincide.

## 1.1. Relation to earlier work

Butucea, Klockmann and Krivobokova [BKK26] study sequentially interactive mechanisms for Gaussian time-series estimation and prove a fourth-order privacy lower bound for noninteractive covariance estimation. Their covariance upper bound contains logarithmic losses and a sufficiently-large-sample condition. Issartel and Roueff [IR26] obtain matching noninteractive bounds without those losses, use private scale and sign statistics, and explicitly leave sharp interactive rates open. The precise spectral-box, all-lag formulation (1.6) is our bounded specialization of that open direction, rather than a verbatim conjecture in either paper.

Fourth-order privacy losses for two-coordinate information are already present in componentwise local privacy: Amorino and Gloter [AG25] prove product privacy contractions and allow interaction across independent vector samples. Their independence and within-vector channel structure do not cover all kernels (1.2) on a dependent trajectory. General private Fisher-information inequalities are also established tools [BCO20]. Strong-noise concentration of a Markov filter near its invariant law is classical [C06]; our filtering contribution concerns its parameter derivative and uniform finite-sample information under arbitrary adaptive private likelihoods.

The contribution claimed here is the uniform lower bound against the entire protocol class (1.2), proved using the adaptive filtering argument of Section 2 and a lag-dependent autoregressive subfamily. The sign inversion, threshold statistic, randomized response, information chain rule and Bayesian Cramér–Rao argument are credited ingredients. The spectral-box upper bound requires an even-function covariance bound because the box gives square summability, not the absolute summability used in the relevant upper-bound proofs of [IR26]. Neither a full spectral-density minimax theorem nor a theorem for arbitrary repeated-access interaction is claimed.

# 2. An information bound for adaptive private filtering

We first give a result independent of Gaussianity. All $L^2$ spaces in this section are real. A density transition operator $T_\theta$ maps the density of a state relative to a probability measure $\nu$ to the density of the next state. Thus $T_\theta$ is positive, preserves integrals, and $T_\theta1=1$ when $\nu$ is invariant. Set $L^2_0(\nu)=\{b:\int b\,d\nu=0\}$.

**Theorem 2 (adaptive filtering information bound).** Let a scalar parameter $\theta$ range over an interval $J$. A Markov family on a standard Borel state space has a common invariant probability $\nu$, and its density transition operators are continuously differentiable in operator norm on a neighborhood of $J$. Suppose that, for some $L\geq0$ and uniformly on $J$,
$$
\|T_\theta\|_{L^2_0\to L^2_0}\leq\kappa\leq1/256,
\qquad
\|T'_\theta\|_{L^2_0\to L^2_0}\leq L.
\tag{2.1}
$$
Observe any finite collection of independent copies of this chain, each started from $\nu$, in a fixed interleaving of successive states that respects the order within each chain and observes every visited state once. Use arbitrary sequential kernels satisfying (1.3), with no raw input other than the current state. Let $N$ be the number of observations after the first observation of their respective chain. For $0<\alpha\leq1$, the Fisher information of the entire transcript, including independent public randomness, satisfies
$$
I_\theta(Z,U)\leq8192L^2N\alpha^4
\quad\text{for every }\theta\in J.
\tag{2.2}
$$
The bound allows messages from all chains to influence every later channel. No Gaussian posterior or nonadaptive-channel assumption is made.

## 2.1. Common likelihoods for arbitrary output spaces

Fix the public seed. For each history $z_{<i}$, use the parameter-independent probability kernel
$$
\mu_i(dz\mid z_{<i})=\int Q_i(dz\mid x,z_{<i})\,\nu(dx).
\tag{2.3}
$$
The LDP inequalities, integrated over $x'$, give inequalities between measures
$e^{-\alpha}\mu_i\leq Q_i(\cdot\mid x,z_{<i})\leq e^\alpha\mu_i$.
One can therefore choose a jointly measurable likelihood
$$
g_i(x;z_{\leq i})=\frac{dQ_i(\cdot\mid x,z_{<i})}{d\mu_i(\cdot\mid z_{<i})}(z_i)
\tag{2.4}
$$
with, for $\mu_i$-almost every $z_i$,
$$
e^{-\alpha}\leq g_i\leq e^\alpha\quad\nu\text{-a.e.},
\qquad \int g_i\,d\nu=1.
\tag{2.5}
$$
For completeness, take an increasing sequence of finite measurable partitions generating the standard Borel output sigma-field. On each partition use the cell ratios $Q_i(A\mid x,z_{<i})/\mu_i(A\mid z_{<i})$, putting $1$ on zero-denominator cells. They are bounded by (2.5) and converge by martingale convergence for the product measure $\nu(dx)\mu_i(dz\mid z_{<i})$. Their measurable limit is a version of (2.4). Integrating over $x$ gives the normalization in (2.5). On the measurable exceptional set of outputs replace the whole function by $1$. This construction is parameter independent. Predictions have densities relative to $\nu$, so it also removes no positive-probability event under any $\theta$.

Let $\mu$ be the sequential product of (2.3). It is a parameter-independent reference measure for the whole transcript. Its construction does not assert that the true messages are independent.

## 2.2. Factorization at each observed prefix

For each fixed parameter $\theta$ and transcript prefix $z_{1:i}$, the likelihood of the visited latent paths is
$\prod_{j\leq i}g_j(x_j;z_{\leq j})$ relative to their unobserved Markov laws. The histories in these factors are fixed values. The prior on the different chains is a product, and every factor involves the raw state of only one chain. Grouping the factors by chain and normalizing thus proves that the conditional latent path laws factorize by chain at this prefix.

Consequently, a message concerning a different chain leaves the posterior of the current chain unchanged, once the observed prefix is fixed. It can alter the channel selected for a later message, which is fully retained in its future $g_j$. This prefix argument is essential: unconditional independence of the chains alone would not justify filtering through adaptive messages.

For a given chain, let $u$ be its predictive density just before its current observation, and $f$ its posterior immediately after that observation. The exact recursion is
$$
b=\langle g,u\rangle_\nu,\qquad f=gu/b,
\qquad u_{\mathrm{next}}=T_\theta f.
\tag{2.6}
$$
The first predictive density is $u=1$. The conditional density of the released message relative to $\mu_i$ is $b$. In particular, $e^{-\alpha}\leq b\leq e^\alpha$.

## 2.3. A pathwise bound for the filter and its derivative

Put $E=e^\alpha$ and $\delta=E-1$. For $\alpha\leq1$, we use $E<3$, $\delta<2$, and $\delta\leq2\alpha$. Let $P_0$ be orthogonal projection onto $L^2_0(\nu)$. Since $b=\int gu\,d\nu$,
$$
f-1=b^{-1}P_0(gu),\qquad
\|f-1\|_2\leq E\delta+E^2\|u-1\|_2.
\tag{2.7}
$$
Indeed, write $gu=1+(g-1)+g(u-1)$ and use the norm-one projection. The prediction step gives $\|u_{\mathrm{next}}-1\|_2\leq\kappa\|f-1\|_2$. Induction over observations of each chain yields
$$
\|f-1\|_2\leq V:=\frac{E\delta}{1-\kappa E^2}<4\delta.
\tag{2.8}
$$
This is a uniform, transcript-by-transcript estimate.

Differentiate at a fixed transcript prefix. The likelihood functions $g$ and the reference kernels do not depend on $\theta$. A dot denotes this derivative. From (2.6),
$$
\dot f=\frac{g\dot u-f\langle g,\dot u\rangle}{b},
\qquad \int\dot u\,d\nu=\int\dot f\,d\nu=0.
\tag{2.9}
$$
Using $\langle g,\dot u\rangle=\langle g-1,\dot u\rangle$ and $\|f\|_2\leq1+V$ gives
$$
\|\dot f\|_2
\leq\{E^2+E\delta(1+V)\}\|\dot u\|_2
\leq63\|\dot u\|_2.
\tag{2.10}
$$
The constants follow from $E<3$, $\delta<2$, $V<8$. Because $T'_\theta1=0$,
$$
\dot u_{\mathrm{next}}=T'_\theta(f-1)+T_\theta\dot f.
\tag{2.11}
$$
Starting at $\dot u=0$, another induction gives
$$
\|\dot u\|_2\leq W:=\frac{LV}{1-63\kappa}\leq6L\delta.
\tag{2.12}
$$
No derivative of a policy decision is present: a statistical likelihood is differentiated at its fixed observed history, and the policy is parameter independent.

## 2.4. Conditional scores and information

At a noninitial observation the conditional score is
$$
s_i=\partial_\theta\log b_i
=\frac{\langle g_i-1,\dot u_i\rangle}{b_i},
\qquad |s_i|\leq E\delta W\leq72L\alpha^2.
\tag{2.13}
$$
At the first observation of a chain it is zero. Each conditional density integrates to one, hence $\mathbb E_\theta[s_i\mid Z_{<i},U]=0$. The total score is $S_\theta=\sum_i s_i$. Orthogonality of martingale differences proves
$$
I_\theta=\mathbb E_\theta S_\theta^2
=\sum_i\mathbb E_\theta s_i^2
\leq5184L^2N\alpha^4\leq8192L^2N\alpha^4.
\tag{2.14}
$$
Conditioning on an independent public seed and then averaging proves (2.2).

Here the score identities hold for the actual dominated experiment, rather than as formal derivatives. For any finite transcript length, (2.6) is a finite composition of bounded multiplication, continuous linear operators and division by $b\geq e^{-\alpha}$. It is continuously differentiable in $L^2$. The transcript density $p_\theta=\prod_i b_i$ lies between $e^{-n\alpha}$ and $e^{n\alpha}$ relative to $\mu$, and its derivative is uniformly bounded on $J$ using (2.13). Dominated differentiation proves the normalization identities and differentiability of $\sqrt{p_\theta}$ in $L^2(\mu)$. The same bounds are independent of the seed. This supplies all regularity used below and completes the proof of Theorem 2.

**Corollary 3 (finite-parameter contraction).** Under Theorem 2, for $\theta,\eta\in J$ with the intervening interval contained in $J$, the squared Hellinger distance in the convention $H^2(P,Q)=\int(\sqrt p-\sqrt q)^2$ satisfies
$$
H^2(P_\theta^{Z,U},P_\eta^{Z,U})
\leq2048L^2N\alpha^4(\theta-\eta)^2.
\tag{2.15}
$$
Indeed, integrate $\partial_t\sqrt{p_t}=\tfrac12\sqrt{p_t}S_t$ along the parameter interval and apply Cauchy–Schwarz and (2.2). Thus the result controls a whole parameter interval, not only the information at an independence point.

**Example 4 (a non-Gaussian instance).** On $\{-1,1\}$ with uniform invariant law, the transition kernel $K_\theta(y\mid x)=(1+\theta xy)/2$ has $T_\theta(x\mapsto x)=\theta(x\mapsto x)$. Therefore (2.1) holds on $[-1/256,1/256]$ with $L=1$. Theorems 2 and Corollary 3 apply to this binary Markov chain and any fixed interleaving of independent copies. This is an instance of the general lemma, not a claim about all non-Gaussian time series.

# 3. A Gaussian subfamily with exactly the right number of transitions

Choose
$$
r=\min\left\{\frac1{256},\frac{1-m}{2(1+m)},\frac{M-1}{2(M+1)}\right\}>0.
\tag{3.1}
$$
For each $\theta\in[-r,r]$, take the stationary solution
$$
X_t=\theta X_{t-h}+\sqrt{1-\theta^2}\,\varepsilon_t,
\qquad t\in\mathbb Z,
\tag{3.2}
$$
where the $\varepsilon_t$ are independent standard normals. One construction is the $L^2$-convergent series $X_t=\sqrt{1-\theta^2}\sum_{j\geq0}\theta^j\varepsilon_{t-jh}$. Its residue classes modulo $h$ are independent stationary AR(1) chains. Its covariance and spectral density are
$$
\gamma_\theta(k)=
\begin{cases}\theta^{|k|/h},&h\mid k,\\0,&h\nmid k,
\end{cases}
\qquad
w_\theta(\omega)=\frac{1-\theta^2}{1-2\theta\cos(h\omega)+\theta^2}.
\tag{3.3}
$$
In particular $v=1$ and $\gamma_\theta(h)=\theta$. The bounds
$$
\frac{1-|\theta|}{1+|\theta|}\leq w_\theta\leq
\frac{1+|\theta|}{1-|\theta|}
\tag{3.4}
$$
and (3.1) imply membership in $\mathcal G(m,M)$ for every $h$. Among $X_1,\ldots,X_n$, exactly $N=(n-h)_+$ observations follow a previous observed state of their chain.

## 3.1. Gaussian transition operators

Let $\nu$ be standard normal and let $T_\theta$ be the density transition operator of $Y=\theta X+\sqrt{1-\theta^2}\varepsilon$. Reversibility makes it also the conditional-expectation operator. For normalized Hermite polynomials $H_k$, the generating function identity
$$
\mathbb E[e^{tY-t^2/2}\mid X=x]
=e^{\theta tx-(\theta t)^2/2}
\tag{3.5}
$$
gives $T_\theta H_k=\theta^kH_k$. The Hermite polynomials form an orthonormal basis of $L^2(\nu)$: orthogonality follows by multiplying the generating functions and integrating; density follows by applying the same generating function to a function orthogonal to all polynomials, then uniqueness of its Gaussian-weighted Fourier transform. All these integrals are justified by Cauchy–Schwarz against Gaussian exponential moments.

Consequently, on the centered space,
$$
\|T_\theta\|\leq|\theta|,\qquad
\|T'_\theta\|=\sup_{k\geq1}k|\theta|^{k-1}\leq1
\quad (|\theta|\leq1/2).
\tag{3.6}
$$
The last inequality uses $k/2^{k-1}\leq1$. The diagonal series also proves operator-norm continuous differentiability on every compact subinterval of $(-1,1)$; its derivative tails converge uniformly, since $kq^{k-1}\to0$ for $q<1$. Theorem 2 now gives $I_\theta(Z,U)\leq8192N\alpha^4$ for $\alpha\leq1$.

For $\alpha\geq1$ we instead use the unprivatized information. An initial state is parameter independent. For one transition put $\sigma^2=1-\theta^2$ and $Y=\theta X+\sigma\varepsilon$. Its score is
$$
\frac{X\varepsilon}{\sigma}
+\frac{\theta(1-\varepsilon^2)}{\sigma^2},
\quad\text{with variance}\quad
\frac{1+\theta^2}{(1-\theta^2)^2}\leq2.
\tag{3.7}
$$
Transition scores are martingale differences, so the raw information is at most $2N$. Passing through a parameter-independent transcript kernel replaces its raw score by its conditional expectation given $(Z,U)$. Conditional Jensen therefore bounds transcript information by raw information. Combining the regimes yields
$$
I_\theta(Z,U)\leq8192N(\alpha\wedge1)^4,
\qquad -r\leq\theta\leq r.
\tag{3.8}
$$
This is uniform in the unknown parameter, protocol, lag, length and public randomization.

# 4. From information to minimax risk

Use the prior density
$$
q(\theta)=\frac1r\cos^2\left(\frac{\pi\theta}{2r}\right)
\boldsymbol1_{[-r,r]}(\theta),
\qquad
\int\frac{q'(\theta)^2}{q(\theta)}\,d\theta=\frac{\pi^2}{r^2}.
\tag{4.1}
$$
The density integrates to one and vanishes at both endpoints. We recall the short Bayesian Cramér–Rao proof to identify its hypotheses. Clip an arbitrary estimator to $[-M,M]$, which cannot increase its squared error on this problem. For the joint density $p_\theta(z)q(\theta)$, integration by parts gives
$$
\mathbb E[(\widehat\gamma-\theta)
\{S_\theta+q'(\theta)/q(\theta)\}]=1.
\tag{4.2}
$$
The boundary terms vanish by (4.1). The score has conditional mean zero. Its cross term with $q'/q$ therefore vanishes. Cauchy–Schwarz proves
$$
\sup_{P\in\mathcal G(m,M)}\mathbb E(\widehat\gamma-\gamma_P(h))^2
\geq\frac1{8192N(\alpha\wedge1)^4+\pi^2/r^2}.
\tag{4.3}
$$
For $\alpha\leq1$, the regularity is supplied in Section 2.4. For $\alpha\geq1$, the finite-dimensional Gaussian experiment (3.2) has a uniformly integrable density derivative on this compact parameter interval: its covariance eigenvalues are uniformly bounded away from zero and infinity, and its score is a quadratic polynomial with uniformly bounded Gaussian moments. A parameter-independent kernel preserves differentiability in total variation, and the conditional-score argument in Section 3 supplies square integrability. These facts justify (4.2) in this regime as well. They can alternatively be used for both regimes.

Taking the infimum over every protocol and estimator proves the lower part of Theorem 1, for example with
$$
c_{m,M}=(8192+\pi^2/r^2)^{-1}.
\tag{4.4}
$$
Indeed, if $Na^4\leq1$ the denominator in (4.3) is at most $8192+\pi^2/r^2$, and if $Na^4\geq1$ it is at most $(8192+\pi^2/r^2)Na^4$.

When $n\leq h$, all observed states of (3.2) belong to different chains; the raw sample is $n$ independent standard normals for every $\theta$. Even without privacy it contains no information about $\gamma(h)=\theta$. The two alternatives $\theta=\pm r$ give risk at least $r^2$, consistent with (4.3) and the saturation convention. The use of a unit-variance subfamily for a lower bound does not assume that variance is known in the upper-bound problem.

# 5. A matching noninteractive estimator with unknown variance

This section supplies a fully specified estimator on the entire spectral box. Let $Y_i=X_i/\sqrt v$ and $\rho_k=\gamma(k)/v$. Parseval and the spectral bounds imply
$$
\sum_{k\in\mathbb Z}\rho_k^2
=\frac1{2\pi v^2}\int w^2
\leq\frac Mv,
\qquad v-|\gamma(h)|\geq m\quad(h\geq1).
\tag{5.1}
$$
For the first inequality use $w^2\leq Mw$. For the second apply the lower spectral bound to $\operatorname{Var}(X_0\pm X_h)=2(v\pm\gamma(h))$. In particular, each standardized two-coordinate marginal has covariance eigenvalues at least $m/v$.

## 5.1. Even Gaussian functions

**Lemma 5 (even Gaussian block covariance).** Let $A,B$ be centered jointly Gaussian vectors whose separate covariance matrices $\Sigma_A,\Sigma_B$ are positive definite. Put $R=\Sigma_A^{-1/2}\operatorname{Cov}(A,B)\Sigma_B^{-1/2}$. If $F(A)$ and $G(B)$ are square integrable and unchanged by $A\mapsto-A$ and $B\mapsto-B$, respectively, then
$$
|\operatorname{Cov}(F(A),G(B))|
\leq\|R\|_{\mathrm{op}}^2
\sqrt{\operatorname{Var}F(A)\operatorname{Var}G(B)}.
\tag{5.2}
$$
To prove this, whiten the two marginals and use a singular-value decomposition of their cross covariance. Orthogonal transformations preserve Gaussian laws and parity. In product Hermite bases, conditional expectation acts on total degree $d$ with norm at most $\|R\|_{\mathrm{op}}^d$. This follows by applying (3.5) in each matched coordinate; unmatched coordinates have zero correlation. Centered even functions have no degree zero or degree one component, and in fact only even degrees occur. Since $\|R\|_{\mathrm{op}}\leq1$, the norm on their subspace is at most $\|R\|_{\mathrm{op}}^2$. Apply Cauchy–Schwarz to their orthogonal chaos expansions. Singular values equal to one cause no problem: the conditional Hermite identity still holds, or follows by a Gaussian perturbation and $L^2$ convergence. Thus no nonsingularity of the joint vector is required.

In dimension one, the lemma gives $|\operatorname{Cov}(F(Y_0),F(Y_k))|\leq\rho_k^2\operatorname{Var}F(Y_0)$ for any even $F$. For sign products $D_i=\operatorname{sign}(X_i)\operatorname{sign}(X_{i+h})$, apply it to the two blocks $(Y_i,Y_{i+h})$ and $(Y_j,Y_{j+h})$. Writing $k=j-i$, (5.1) gives
$$
|\operatorname{Cov}(D_i,D_j)|
\leq(v/m)^2\{2\rho_k^2+\rho_{k+h}^2+\rho_{k-h}^2\}.
\tag{5.3}
$$
Here each sign product has variance at most one, the cross-covariance matrix has the four displayed entries, and its operator norm is bounded by its Frobenius norm after whitening. Summing the right-hand side over all $k\in\mathbb Z$ gives at most
$$
4(v/m)^2(M/v)=4Mv/m^2\leq4(M/m)^2.
\tag{5.4}
$$

## 5.2. Two private bits at each observation

Set $s_i=\operatorname{sign}(X_i)$, with any convention at zero, and $b_i=2\boldsymbol1_{\{|X_i|\geq1\}}-1$. Independently randomize each bit by keeping it with probability $e^{\alpha/2}/(1+e^{\alpha/2})$ and flipping it otherwise. Denote the results by $S_i,B_i\in\{-1,1\}$, and put
$$
\lambda=\tanh(\alpha/4),\qquad
\mathbb E[S_i\mid X_i]=\lambda s_i,
\quad\mathbb E[B_i\mid X_i]=\lambda b_i.
\tag{5.5}
$$
All these randomization coins are conditionally independent given the raw sample. Each bit is $\alpha/2$-LDP, so the pair $(S_i,B_i)$ is $\alpha$-LDP by multiplication of probabilities. This is a noninteractive instance of (1.2). For all $\alpha>0$,
$$
\lambda\geq(\alpha\wedge1)/8.
\tag{5.6}
$$
For $\alpha\leq1$, use $\tanh t\geq t/2$ on $[0,1/4]$ (its derivative minus $1/2$ is positive there); for $\alpha\geq1$ use monotonicity.

## 5.3. Estimating the variance

Let $\Phi,\phi$ be the standard normal distribution function and density, and define
$$
p(v)=2\Phi(-v^{-1/2}),\qquad
d=\phi(m^{-1/2})M^{-3/2}>0.
\tag{5.7}
$$
On $[m,M]$, $p'(v)=\phi(v^{-1/2})v^{-3/2}\geq d$. Define
$$
\widetilde p=\frac12\left(1+\frac1{n\lambda}\sum_{i=1}^n B_i\right),
\quad \widehat p=\operatorname{clip}_{[p(m),p(M)]}(\widetilde p),
\quad \widehat v=p^{-1}(\widehat p).
\tag{5.8}
$$
The unprojected estimator is unbiased. By Lemma 5, $|\operatorname{Cov}(b_i,b_j)|\leq\rho_{j-i}^2$ for distinct indices, and $\operatorname{Cov}(B_i,B_j)=\lambda^2\operatorname{Cov}(b_i,b_j)$. The diagonal terms have variance at most one. Therefore
$$
\operatorname{Var}(\widetilde p)
\leq\frac1{4n}\left\{\lambda^{-2}+\sum_{k\neq0}\rho_k^2\right\}
\leq\frac{M/m}{4n\lambda^2}.
\tag{5.9}
$$
For the last step, $\sum_{k\neq0}\rho_k^2\leq M/v-1$ and $\lambda\leq1$. Projection reduces distance to $p(v)$; the inverse is $d^{-1}$-Lipschitz. Hence
$$
\mathbb E(\widehat v-v)^2\leq\frac{M/m}{4d^2n\lambda^2},
\qquad m\leq\widehat v\leq M.
\tag{5.10}
$$

## 5.4. Estimating the correlation

Suppose $N=n-h>0$. The Gaussian arcsine identity is
$$
\mathbb E D_i=\frac2\pi\arcsin\rho_h.
\tag{5.11}
$$
One derivation writes a standardized Gaussian pair as the projections of a rotationally symmetric two-dimensional standard normal onto two unit vectors whose angle is $\arccos\rho_h$. Their signs disagree on wedges with total angular proportion $\arccos\rho_h/\pi$, which gives (5.11). Nondegeneracy follows from (5.1).

Put
$$
T=\frac1{N\lambda^2}\sum_{i=1}^N S_iS_{i+h},
\qquad
\widehat\rho=\sin\left(\frac\pi2\operatorname{clip}_{[-1,1]}T\right).
\tag{5.12}
$$
The mean of $T$ is (5.11). For disjoint index pairs, conditional independence of the coins gives
$\operatorname{Cov}(S_iS_{i+h},S_jS_{j+h})=\lambda^4\operatorname{Cov}(D_i,D_j)$.
The pairs overlap only when $j-i\in\{0,h,-h\}$. There are at most $3N$ such ordered pairs, each having covariance in absolute value at most one. Equations (5.3)-(5.4) consequently show
$$
\operatorname{Var}(T)
\leq\frac3{N\lambda^4}+\frac{4(M/m)^2}{N}.
\tag{5.13}
$$
Projection is distance reducing and the sine map in (5.12) is $\pi/2$-Lipschitz. Thus
$$
\mathbb E(\widehat\rho-\rho_h)^2
\leq\frac{\pi^2}4\left\{\frac3{N\lambda^4}+\frac{4(M/m)^2}{N}\right\}.
\tag{5.14}
$$

## 5.5. Combining the estimates and all regimes

Define $\widehat\gamma=\widehat v\widehat\rho$ when $N>0$, and $\widehat\gamma=0$ when $N=0$. Since $|\rho_h|\leq1$ and $\widehat v\leq M$,
$$
|\widehat v\widehat\rho-v\rho_h|^2
\leq2M^2|\widehat\rho-\rho_h|^2+2|\widehat v-v|^2.
\tag{5.15}
$$
This deterministic inequality requires no independence between the two estimates. Set
$$
A_{m,M}=\frac{\pi^2M^2}2\{3+4(M/m)^2\}
+\frac{M/m}{2d^2}.
\tag{5.16}
$$
Using $n\geq N$, $\lambda\leq1$, and (5.6), equations (5.10) and (5.14) give risk at most $4096A_{m,M}/(Na^4)$ when $N>0$. Also $|\widehat\gamma|\leq M$ and $|\gamma(h)|\leq M$, so the risk is at most $4M^2$. When $N=0$ the zero estimator has risk at most $M^2$. The upper part of (1.6) follows, for example, with
$$
C_{m,M}=\max\{4M^2,4096A_{m,M}\}.
\tag{5.17}
$$
These constants are deliberately conservative; Theorem 1 concerns order, not sharp leading constants. This completes the proof.

# 6. Interpretation, earlier bounds, and limits

For $Na^4$ large, estimating one lag covariance to mean squared error of order $\varepsilon^2$ requires effective pair count $N$ of order $a^{-4}\varepsilon^{-2}$, with class-dependent constants. The two privacy factors arise because the parameter changes dependence while the hard family's marginal distribution remains fixed. The past private observations can perturb the filter by only order $\alpha$ in the weakly dependent family; pairing its derivative with the current private likelihood contributes another factor $\alpha$. Squaring the conditional score yields $\alpha^4$.

The lower bound uses weakly dependent processes because minimax risk is controlled by a hard subfamily. It does not assert the same difficulty at every individual spectrum or for a strongly correlated parametric submodel. The upper bound, in contrast, covers the entire fixed spectral box. If $h\geq n$, the class includes observationally indistinguishable processes with different target covariances, so the constant-risk regime is intrinsic.

## 6.1. Compatibility with the interactive upper bound of BKK

The covariance result in [BKK26, JMLR Theorem 3 and Appendix A.3; arXiv v3 Section 2.2] displays an upper bound with a term $\log^{4+4\delta}n/(n\alpha^2)$ for sufficiently large $n$. Its truncation proof contains a tail exponential with exponent $-4\alpha\log^{1+\delta}n$. Reading that large-sample condition uniformly in a varying privacy level requires care.

Here is a sufficient-condition calculation, not a new claim about the optimal performance of their estimator. For $0<\alpha\leq1$, a corresponding union bound is bounded by
$e^{\alpha/4}n\exp[-4\alpha\log^{1+\delta}n]$.
The condition $\alpha\log^\delta n\geq2$ makes it $O(n^{-3})$; the Gaussian truncation step has its own fixed class-dependent threshold. Within this sufficient regime, the ratio of their displayed logarithmic term to $(n\alpha^4)^{-1}$ is
$$
\alpha^2\log^{4+4\delta}n\geq4\log^{4+2\delta}n.
\tag{6.1}
$$
Thus it is compatible with our lower bound. For fixed $\alpha$ the threshold eventually holds; it need not hold in a joint limit such as $\alpha_n=n^{-b}$, $b>0$. This calculation is not a necessary condition for their algorithm, does not declare their fixed-$\alpha$ theorem false, and does not adjudicate their separate full spectral-density claims. It explains why dropping both logarithmic factors and parameter-dependent thresholds cannot refute the uniform scalar theorem proved here.

## 6.2. Scope of the result and of its verification

The theorem assumes a known zero mean, Gaussian data, a fixed positive spectral lower bound, and one release per coordinate in chronological order. Approximate privacy, nonchronological adaptive ordering, repeated access, hidden correlated randomization outside (1.2), non-Gaussian full-model minimax rates, pointwise spectral estimation and full spectral-density estimation remain outside the result. The general filtering lemma has its own explicit small-contraction and common-invariant-law assumptions; those are proved for the hard Gaussian family and are not imposed on the upper-bound class.

The written proof includes arbitrary standard Borel messages and all parameter boundaries in (1.5). The accompanying finite calculations check constants and illustrative small models; they are not substitutes for this proof. The computational files are not included in this edition. The novelty claim is restricted to the primary literature actually checked as of 25 November 2026. Full Lean formalization has not been completed.

# References

**[AG25]** Chiara Amorino and Arnaud Gloter. *Minimax rate for multivariate data under componentwise local differential privacy constraints*. Annals of Statistics 53(3), 2025. DOI: [10.1214/25-AOS2497](https://doi.org/10.1214/25-AOS2497). Checked preprint: [arXiv:2305.10416v3](https://arxiv.org/html/2305.10416v3), 17 January 2025, especially Proposition 3.7, Corollary 3.8 and the independent-sampling model.

**[BCO20]** Leighton Pate Barnes, Wei-Ning Chen and Ayfer Özgür. *Fisher information under local differential privacy*. IEEE Journal on Selected Areas in Information Theory 1(3):645–659, 2020. DOI: [10.1109/JSAIT.2020.3039461](https://doi.org/10.1109/JSAIT.2020.3039461). [arXiv:2005.10783](https://arxiv.org/abs/2005.10783). Used for methodological attribution; none of its theorem statements is needed as an unproved input to our lower bound.

**[BKK26]** Cristina Butucea, Karolina Klockmann and Tatyana Krivobokova. *Nonparametric Spectral Density Estimation using Interactive Mechanisms under Local Differential Privacy*. Journal of Machine Learning Research 27(168):1–49, 2026. [Journal version](https://www.jmlr.org/papers/v27/25-0680.html); [PDF](https://www.jmlr.org/papers/volume27/25-0680/25-0680.pdf). Checked also [arXiv:2504.00919v3](https://arxiv.org/html/2504.00919v3), 21 September 2026. Numbering differs between the journal PDF and the arXiv HTML.

**[C06]** Pavel Chigansky. *On filtering of Markov chains in strong noise*. IEEE Transactions on Information Theory 52(9):4267–4272, 2006. [arXiv:math/0508446v3](https://arxiv.org/abs/math/0508446v3), 21 May 2006. Classical finite-state strong-noise filtering, cited for methodological context; its fixed observation channels do not give Theorem 2.

**[IR26]** Yann Issartel and François Roueff. *On the privacy cost for dependent Gaussian data: spectral density estimation under local differential privacy*. [arXiv:2608.24847v1](https://arxiv.org/html/2608.24847v1), 25 August 2026. Especially the noninteractive model, Section 3.1 on lag-$h$ autocovariance, Section 3.4 on interactive privacy, and Section 6 on the scale/sign upper bounds.
