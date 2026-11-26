# Gaussian mixing recovery under response-dependent repeat measurements

## Abstract

We study recovery of an arbitrary compactly supported joint law of an individual's Gaussian mean and variance. An experimenter can use a menu of \(m\) gains for first measurements and a budget of \(R\) repeat measurements among \(n\) individuals. The experimenter may choose whom to revisit, and at what gain, after observing their responses. For every fixed upper bound on measurements per individual, we determine the joint minimax Wasserstein rate in the menu size, gain range, population size and repeat budget. The rate is attained by fixed designs. The lower bound uses a signed heat-operator construction and a larger-variance common component. Their combination gives likelihood-ratio bounds at every possible response, including the extreme responses a selection rule may target. The resulting conditional bounds hold at every revisit.

## 1. Model and result

Fix \(M>0\), \(0  <  v_-  <  v_+\), \(a_0>0\) and \(0  <  \delta_0  <  1\). Let \(K=[-M,M]\times[v_-,v_+]\) have its \(\ell_1\) metric. Each of \(n\) individuals has an independent latent pair \((\mu_i,v_i)\) with unknown common Borel probability law \(G\) on \(K\).

For \(0\le\delta\le\delta_0\), let \(I_\delta=[a_0(1-\delta),a_0(1+\delta)]\). A design specifies a deterministic first-measurement menu \(\mathcal A\subset I_\delta\) of size at most \(m\), with \(m\ge1\). The menu may be chosen using the known problem parameters. At each step the design chooses an individual and a gain \(a\). The resulting observation, given that individual's latent pair and the history and action, is \(N(\mu_i,a v_i)\), using fresh independent Gaussian noise. For the first measurement of an individual the gain belongs to \(\mathcal A\). The gains of repeat measurements may be chosen anywhere in a fixed compact interval \([a_-,a_+]\subset(0,\infty)\) containing \(I_{\delta_0}\). The actions may depend on every previously recorded observation and independent randomization. A design can interleave first and repeat measurements and can revisit an individual based on any of that individual's past outcomes. On every realization there are at most \(R\) measurements beyond the first measurement of each individual and at most \(L\) measurements on any one individual. We fix \(L\ge2\) and take \(0\le R\le n\). All actions, gains and observations are recorded. The first-gain menu is fixed before the experiment, even though the choices among its gains may be adaptive.

The minimax risk \(\mathcal R^{(L)}_{n,m,R}(\delta)\) is the infimum over these designs and measurable estimators of \(\sup_G E_G W_1(\widehat G,G)\). With natural logarithms set
\[
 x_N=\log(N+e^e),\qquad \rho_N=\frac{\log x_N}{x_N},\qquad
 D_n(\delta)=\min\left\{1,\frac{\log x_n+\log(1/\delta)}{x_n}\right\},
 \qquad D_n(0)=1.
\]

**Theorem 1.** For every fixed \(L\ge2\), uniformly in the integers \(n,m\ge1\), \(0\le R\le n\) and \(0\le\delta\le\delta_0\),
\[
 \mathcal R^{(L)}_{n,m,R}(\delta)
 \asymp \min\{m^{-1}+D_n(\delta),\,\rho_R\}.
 \tag{1}
\]
The comparison constants depend on \(K,a_0,\delta_0,a_-,a_+\) and \(L\) only. The two upper bounds require at most two measurements per individual. The lower bound remains valid for any adaptive order of first and repeat measurements, including selection of a repeat gain based on the same individual's earlier responses.

For \(L=2\) the budget is exactly the maximum number of paired individuals. For a fixed \(L\), the order also holds for the alternative constraint that at most \(R\) individuals may be measured more than once and each at most \(L\) times. The lower proof below replaces the number of repeat terms by \((L-1)R\) in that case, which changes only the comparison constants. At a single fixed gain uniform consistency is possible exactly when \(R\to\infty\). Arbitrarily many unpaired individuals cannot improve the order \(\rho_R\). More generally, when \(\delta\) is polynomially small in \(n\) the width term is bounded below on any specified polynomial shrinkage range, and consistency still requires \(R\to\infty\).

The distinction between unconditional and conditional comparisons is necessary in this protocol. Consider a toy pair of experiments with the same first binary response \(X\), with \(\Pr(X=1)=1/n\) in both. The second response agrees in law when \(X=0\) and is Bernoulli with probabilities \(1/4\) and \(3/4\) when \(X=1\). The divergence for one fresh pair is \(c/n\) for a fixed \(c>0\), while the first responses have zero divergence. With \(n\) first responses and one repeat, choose an individual with \(X=1\) whenever one exists. The transcript divergence is then \(c[1-(1-1/n)^n]\), bounded away from zero. In the Gaussian experiment, the uniform conditional bound in Section 4 rules out this concentration of distinguishability on selected outcomes.

## 2. Estimation by fixed designs

We first give the moment bound used by both estimators. Transform \(K\) affinely to \([-1,1]^2\), writing the transformed coordinates as \(x,z\). For every \(k\ge1\) and probabilities \(G,H\) on \(K\),
\[
 W_1(G,H)\le \frac{C}{k}
      +C_1^k\max_{0\le p,q\le k}\left|\int x^pz^q\,d(G-H)\right|.
 \tag{2}
\]
To prove this, normalize a Lipschitz test at one point, which bounds its sup norm by the diameter of \(K\). Lift the test function to the two-dimensional torus by \(x=\cos\theta\), \(z=\cos\phi\). It is separately even and Lipschitz on that torus. Convolve in each variable with the normalized kernel proportional to
\[
 \left(\frac{\sin(j t/2)}{\sin(t/2)}\right)^4
\]
for \(j\) of order \(k/2\), with \(2(j-1)\le k\). The kernel integral before normalization is comparable to \(j^3\), by the upper bound \(C\min(j^4,|t|^{-4})\) and a matching lower bound on \(|t|\le1/j\). Its first absolute moment after normalization is \(O(1/j)\), by splitting that same bound at \(1/j\). Thus the sup approximation error is \(O(1/k)\), allowing an enlarged constant for small \(k\). The convolution is even in each variable with trigonometric degree at most \(k\). Its cosine coefficients are bounded by a fixed multiple of the test function's sup norm. Expanding \(\cos(j\theta)\) as the Chebyshev polynomial \(T_j(x)\) gives monomial coefficient sum at most \((1+\sqrt2)^j\) for each \(T_j\), by the three-term recurrence. The coefficient sum of the bivariate approximant is therefore at most \(C_1^k\). Integrating it against \(G-H\) and applying Kantorovich–Rubinstein duality proves (2). Transforming back to raw \(\mu,v\) moments costs at most another fixed exponential factor.

Given estimates of all raw moments of bidegree at most \((k,k)\), fit a probability law by minimizing the largest moment mismatch within tolerance \((N+1)^{-1}\), with \(N\) the sample size used in the estimator. Specifically, fix a countable dense family of probabilities on \(K\) and choose its first element whose mismatch is within this tolerance of the infimum over the family. All choices are measurable since the infimum and the comparison are over countably many measurable functions. The infimum is no larger than the mismatch of the true law \(G\), by continuity of all these moment functions. The fitted law's maximum moment error is therefore at most twice the estimation error plus the tolerance.

### Paired observations

Take \(R\) pairs at gain \(a_0\). With \(\lambda=a_0/2\), their average \(S=(Y_1+Y_2)/2\) and half-difference \(D=(Y_1-Y_2)/2\) are conditionally independent \(N(\mu,\lambda v)\) and \(N(0,\lambda v)\) variables. Put \(J_h(D)=D^{2h}/[\lambda^h(2h-1)!!]\) for \(h\ge1\) and \(J_0=1\). Then
\[
 U_{p,q}(S,D)=
 \sum_{j=0}^{\lfloor p/2\rfloor}
    \frac{p!(-\lambda)^j}{2^j j!(p-2j)!}\,
    S^{p-2j}J_{q+j}(D)
 \tag{3}
\]
has conditional expectation \(\mu^p v^q\). Indeed \(J_{q+j}\) has conditional expectation \(v^{q+j}\). The remaining conditional moment sum follows by taking the coefficient of \(t^p/p!\) in \(E[\exp(tS-\lambda v t^2/2)\mid\mu,v]=e^{t\mu}\).

For \(p,q\le k\) the polynomial in (3) has degree at most \(3k\), and its coefficient sum is bounded by \(\exp(Ck\log(k+1))\), since the fixed \(\lambda>0\) only changes an exponential factor and \(p!\le k^k\). The conditional means and variances are bounded on \(K\), so Gaussian moment bounds give the same form of upper bound on its second moment, with a larger \(C\). Using independent pairs and bounding the expected maximum error by the sum of the individual standard errors gives
\[
 E\max_{p,q\le k}|\widehat M_{p,q}-M_{p,q}|
   \le (k+1)^2 \exp(Ck\log(k+1))/\sqrt R .
\]
By (2), moment fitting and \(k\) equal to the integer part of a sufficiently small positive multiple of \(x_R/\log x_R\), the risk is \(O(\rho_R)\) for large \(R\). To check the choice, \(k\log(k+1)\) is at most a constant times that multiple times \(x_R\); taking it small makes the term multiplying \(R^{-1/2}\), including the coefficient factor in (2), at most a constant times \(R^{1/4}\). The diameter upper bound treats bounded \(R\). Formula (3) also proves identifiability from an exactly known same-gain two-view distribution, since it gives every mixed moment and polynomials are dense on \(K\).

### First measurements across different gains

For any integer \(j\ge0\), \(\mathbf E_G Y^j=P_j(a)\) is a polynomial of degree at most \(\lfloor j/2\rfloor\) in the gain and
\[
 [a^q]P_{p+2q}(a)=\frac{(p+2q)!}{2^q q!p!}\int\mu^p v^q\,dG.
 \tag{4}
\]
This follows by expanding \(Y=\mu+\sqrt{av}\,Z\) and using the even Gaussian moments. For \(\delta>0\) and \(k\) with \(s_k=\lfloor3k/2\rfloor+1\le m\), take \(s_k\) equally spaced gains in \(I_\delta\), dividing the individuals as equally as possible. The Lagrange interpolation polynomials at these nodes each have monomial coefficient sum at most \((C k/\delta)^{Ck}\). In fact each product denominator has each factor at least the node spacing, which is of order \(\delta/k\), and each numerator factor has bounded coefficient sum because the gains lie in a fixed compact interval. Gaussian moment bounds give standard errors at most \(\exp(Ck\log(k+1))/\sqrt{\lfloor n/s_k\rfloor}\) for estimating each \(P_j(a)\), \(j\le3k\), at the chosen nodes. The reciprocal of the combinatorial coefficient in (4) is at most one. Taking maxima by summing errors, interpolating, fitting moments and applying (2) gives, for \(s_k\le n/2\),
\[
 \sup_G E_G W_1(\widehat G,G)
 \le \frac{C}{k}
       +n^{-1/2}\exp\{C'k[\log(k+1)+\log(1/\delta)]\}.
 \tag{5}
\]
Here the sample-size imbalance, polynomial factors and the fitting tolerance have been absorbed in the exponential.

Choose \(k\) as the integer part of a sufficiently small positive multiple of
\(\min\{m,x_n/(\log x_n+\log(1/\delta))\}\).
For \(k\ge1\) and large \(n\) this choice ensures \(s_k\le m\), \(s_k\le n/2\), and bounds the second term of (5) by \(O(n^{-1/4})\), by the same exponential comparison as for pairs. It gives risk \(O(m^{-1}+D_n(\delta))\). If the proposed \(k\) is zero then one of \(1/m\), \(D_n(\delta)\) is bounded below by a fixed constant and the diameter suffices. At \(\delta=0\) the diameter suffices for this bound as well. These constructions give the upper bound in (1) for large \(n\), and bounded \(n\) can be included by increasing the constant since the expression in (1) is bounded below there.

## 3. A common pair of mixing laws

Fix an interior upper variance \(v_b\in(v_-,v_+)\). Let \(k\ge1\) and \(c_1,\ldots,c_k\in[a_-,a_+]\). Write \(h=M/k\), \(b=(v_b-v_-)/k\). Denote by \(u_h,u_b\) the uniform probability laws on centered intervals of lengths \(h,b\). Put
\[
 \Phi_k=u_h^{*2k}\otimes\tau_{(v_b+v_-)/2}u_b^{*k},\qquad
 \zeta_k=\prod_{j=1}^k\left(D_v+\frac{c_j}{2}D_\mu^2\right)\Phi_k ,
 \tag{6}
\]
where \(\tau\) translates the variance marginal and derivatives are distributional. Each expansion term is a finite signed measure, by distributing each derivative to a distinct uniform factor and using \(D u_h=(\delta_{-h/2}-\delta_{h/2})/h\), and likewise for \(u_b\). Every term is supported on \([-M,M]\times[v_-,v_b]\) and has zero mass. Use \(\|\zeta_k\|_{\mathrm{var}}=|\zeta_k|(K)\) for the mass of its variation measure. If
\[
 A_k=\left(\prod_{j=1}^k c_j/2\right)(2/h)^{2k},
\]
then
\[
 A_k\le\|\zeta_k\|_{\rm var}
 \le A_k\prod_{j=1}^k\left(1+\frac{h^2}{b c_j}\right)\le C A_k .
 \tag{7}
\]
For the upper bound, a term replacing the \(j\)-th location derivative by a variance derivative incurs at most the factor \(h^2/(b c_j)\) in variation. Their sum is the product in (7), bounded because \(k h^2/b\) is constant. For the lower bound use a 1-Lipschitz function of \(\mu\) alone that alternates between \(h/2\) and \(-h/2\) on the lattice \((j-k)h\), \(0\le j\le2k\), and matches the signs of the binomial masses of the all-location derivative. Interpolate linearly between nodes and extend constantly outside them. This function integrates to \((h/2)A_k\) against the all-location derivative. The remaining terms have zero integral against it since each has positive-order variance derivative. Dividing by its sup norm proves the lower bound.

Let \(\zeta_k^\pm\) be the positive and negative Jordan parts and form the two probabilities
\[
 G_{k,\pm}=\tfrac12\delta_{(0,v_+)}
               +\zeta_k^\pm/\|\zeta_k\|_{\rm var}.
 \tag{8}
\]
Both contain the same Gaussian-generating component at the larger variance \(v_+\). The test just used in (7) yields
\[
 W_1(G_{k,+},G_{k,-})\ge c/k,\qquad
 A_k\ge (c k^2)^k.
 \tag{9}
\]
The hard alternatives differ in their mixing law even when every permitted first channel has identically the same law under the two alternatives.

## 4. Pointwise likelihood bounds and conditioning on selection

For a gain vector \({\bf a}=(a_1,\ldots,a_s)\in[a_-,a_+]^s\) with \(1\le s\le L\), let \(g_{\mu,v,{\bf a}}(y)=\prod_{j=1}^s\varphi_{a_jv}(y_j-\mu)\), where \(\varphi_t\) is the Gaussian density of variance \(t\). Write \(b_{\bf a}(y)=g_{0,v_+,{\bf a}}(y)\) for the reference density and \(p_{\pm,{\bf a}}\) for the product-observation mixtures under \(G_{k,\pm}\). They are densities for fixed gain vectors before any selection.

### Gaussian derivatives above a smaller variance range

For any multi-index \(\beta\) of total order \(\ell\ge1\), uniformly for \(|\mu|\le M\), \(v\in[v_-,v_b]\) and all permitted \({\bf a}\), we claim
\[
 \sup_{y\in\mathbb R^s}
   \frac{|\partial_y^\beta g_{\mu,v,{\bf a}}(y)|}{b_{\bf a}(y)}
 \le C_L(C_L\sqrt\ell)^\ell .
 \tag{10}
\]
For one coordinate, continue the Gaussian to the complex plane. If \(|z|\le r\), completing the square in \(y\) gives
\[
 \frac{|\varphi_{av}(y+z-\mu)|}{\varphi_{av_+}(y)}
 =\sqrt{\frac{v_+}{v}}\,
    \exp\left\{-\frac{(y+\Re z-\mu)^2-(\Im z)^2}{2av}
                      +\frac{y^2}{2a v_+}\right\}
 \le C e^{C r^2}.
\]
The coefficient of \(-y^2\) in the exponent is bounded below by a positive constant because \(v_b  <  v_+\) and the gains are bounded. The linear term in \(y\) can therefore be absorbed at cost \(C(M+r)^2\). The product bound on the complex polydisc is \(C_L e^{C_L r^2}\). Applying the Cauchy formula in each coordinate, with \(r=\sqrt{\ell}\) and \(\prod_j\beta_j!\le \ell!\le \ell^\ell\), proves (10). The constants are uniform over all partial prefixes of length at most \(L\).

### Simultaneous cancellation and derivative decay

On the product kernel,
\[
 \partial_vg_{\mu,v,{\bf a}}=\frac12\sum_{j=1}^s a_j\partial_{y_j}^2g_{\mu,v,{\bf a}},
 \qquad
 \partial_\mu^2g_{\mu,v,{\bf a}}
       =\left(\sum_{j=1}^s\partial_{y_j}\right)^2g_{\mu,v,{\bf a}} .
\]
Let \(T_{\bf a}\) denote mixing of this product kernel against a measure on \(K\). Integration by parts in (6) gives
\[
 T_{\bf a}\zeta_k=
 \prod_{i=1}^k
   \left[\frac{c_i}{2}\left(\sum_{j=1}^s\partial_{y_j}\right)^2
                  -\frac12\sum_{j=1}^s a_j\partial_{y_j}^2\right]T_{\bf a}\Phi_k .
 \tag{11}
\]
One can use a smooth compactly supported cutoff equal to one on a neighborhood of the support of \(\Phi_k\) and its derivatives for each distributional pairing. There the variance is bounded away from zero, and the test function is smooth. Differentiation in the observations can be passed through the compact mixing integral.

Each factor in (11) has a sum of absolute coefficients bounded by a constant depending only on the fixed gain interval and \(L\). Total derivative order is \(2k\). Combining (7), (9), (10) and (11), we get
\[
 \sup_y\frac{|p_{+,{\bf a}}(y)-p_{-,{\bf a}}(y)|}{b_{\bf a}(y)}
       \le C (C'/k)^k .
 \tag{12}
\]
In particular every mixture density \(p_{\pm,{\bf a}}\) dominates \(b_{\bf a}/2\). For \(s=1\), (11) simplifies exactly to \(\prod_i[(c_i-a_1)/2]\,\partial_{y_1}^{2k} T_{a_1}\Phi_k\). The two first-response laws agree at every gain included in the list \(c_1,\ldots,c_k\). When all \(c_i=a_0\) and \(a_1\in I_\delta\), the upper bound in (12) strengthens to \(C(C'\delta/k)^k\). These are all pointwise comparisons, independent of the observation values.

### The conditional cost of a revisit

Take \(k\) above a fixed constant so that the right side in (12) is small. For a fixed gain vector and its prefix \({\bf a}_{ < s}\), (12) and dominance by \(b_{\bf a}/2\) give
\[
 \left|\frac{p_{+,{\bf a}}}{p_{-,{\bf a}}}-1\right|
 \le C(C'/k)^k,\qquad
 \left|\frac{p_{+,{\bf a}_{ < s}}}{p_{-,{\bf a}_{ < s}}}-1\right|
 \le C(C'/k)^k .
\]
The ratio of the two conditional densities of \(y_s\) given \(y_{ < s}\) is the quotient of these likelihood ratios. For all \(s\ge2\) and all \(y_{ < s},y_s\), it differs from one by at most \(C(C'/k)^k\), after changing constants. Consequently the conditional KL divergence of the next response is at most \(C(C'/k)^{2k}\) uniformly in the prefix. This follows from the bound of KL by chi-square, since the chi-square divergence is the integral of the squared ratio difference against the second conditional density. The analogous one-view KL is zero at listed gains and at most \(C(C'\delta/k)^{2k}\) in the shrinking-width comparison.

These bounds apply to the conditional law of an actual sequential transcript. To see this, condition on the available history. Under either mixing law, the current joint posterior of the latent pairs factors by individual, with individual posterior proportional to its prior times the product of the Gaussian densities for that individual's recorded responses and gains. This holds at initialization. A randomized action selected from the history contributes no latent likelihood factor. After that action, the likelihood for the new response updates only the selected individual's posterior. The factorization follows by induction, also when actions are chosen retrospectively among individuals whose first responses have all been seen. It identifies the new response law at every repeat with the ratio \(p_{\pm,{\bf a}}(y)/p_{\pm,{\bf a}_{ < s}}(y_{ < s})\) evaluated at the realized old values and selected new gain. The uniform bounds above therefore hold even for a revisit triggered by an extreme value. At an unused individual the posterior remains its original law, so the single-view bound applies. An independent protocol seed can be included in the transcript and early stopping can be padded with deterministically empty updates.

## 5. The lower bound and the role of the repeat cap

Apply the KL chain rule to the two full transcript laws \(P_+,P_-\). Each action has the same conditional kernel under both laws, hence contributes zero. By the pathwise counts and the conditional comparisons in Section 4,
\[
 D(P_+\Vert P_-)\le n\,d_1(k)+R C(C'/k)^{2k},
 \tag{13}
\]
where \(d_1(k)=0\) at listed gains, and \(d_1(k)=C(C'\delta/k)^{2k}\) when all \(c_i=a_0\). The bound holds for every policy on a prescribed deterministic first menu.

For a menu of size \(s\le m\), include every menu gain among the \(c_i\) and take \(k=\max\{s,\lceil A/\rho_R\rceil\}\), filling any unused positions with \(a_0\). Take \(A\) a sufficiently large constant depending on the fixed model bounds. The single terms are zero. For \(k\ge A x_R/\log x_R\), \(A\ge C'\), one has
\(\log(k/C')\ge\log x_R-\log\log x_R\ge(\log x_R)/2\).
Thus the repeat part of (13) is as small as desired uniformly in \(R\). The Wasserstein separation in (9) and the two-point testing bound give a risk lower bound of order \(\min\{m^{-1},\rho_R\}\), uniformly over the menu. For clarity, if KL is at most \(1/8\), Pinsker bounds the total variation by \(1/4\). Choosing the candidate closer to an estimator yields a test whose incorrect decision forces loss at least half the separation. The sum of its error probabilities is at least \(1-\mathrm{TV}\).

For the width comparison take all \(c_i=a_0\) and \(k=\lceil A\max\{D_n(\delta)^{-1},\rho_R^{-1}\}\rceil\). The repeat bound is unchanged. When \(\delta>0\), put \(z=\log x_n+\log(1/\delta)\). If \(z\le x_n\), then \(k\ge A x_n/z\) and \(\log(k/(C'\delta))\ge z-\log z +\log(A/C')\ge z/2\). If \(z>x_n\), then \(\log(1/\delta)>x_n-\log x_n\ge x_n/2\) and \(k\ge A\). In both cases \(2k\log(k/(C'\delta))\ge A x_n\), so the first part of (13) is as small as desired, uniformly in the width. When \(\delta=0\) it vanishes exactly. The second two-point risk bound is of order \(\min\{D_n(\delta),\rho_R\}\). Finally,
\[
 \max\{\min(u,w),\min(v,w)\}\ge\tfrac12\min\{u+v,w\}
\]
for positive \(u,v,w\). This proves the lower bound in (1). For the variant with \(R\) distinct revisited individuals, replace \(R\) by \((L-1)R\) in the divergence estimate and enlarge \(A\). The same \(k\) still gives arbitrarily small divergence with constants depending on fixed \(L\).

The assumption that \(L\) is fixed is substantive. At a single gain and with an unbounded repeat cap, the same total repeat budget permits a polynomially smaller risk than \(\rho_R\) as \(R\to\infty\). For example, use \(q=\lfloor R/(r-1)\rfloor\) individuals with \(r=1+\lfloor R^{1/3}\rfloor\) measurements each. At gain \(a_0\), the sample mean and sample variance divided by \(a_0\), clipped to \(K\), estimate each latent pair with expected \(\ell_1\) error \(O(r^{-1/2})\), by the elementary Gaussian sampling variance formulas. The empirical law of these estimates differs in expected \(W_1\) from the empirical law of the true latent pairs by at most that quantity. The latter law has risk \(O(q^{-1/4})\): partition the rectangle into \(J^2\) cells with diameter \(O(1/J)\), project to the cell centers, and bound the discrete total variation from the true grid law by \(J/(2\sqrt q)\) in expectation by Cauchy–Schwarz. Choose \(J\) of order \(q^{1/4}\). Since \(q\) is of order \(R^{2/3}\), this construction gives \(O(R^{-1/6})\). It distinguishes fixed-view sampling from designs that concentrate many repeats on one individual.

## 6. Relation to prior work

**Location mixtures and moment bounds.** Wu and Yang establish optimal Wasserstein estimation for finite Gaussian location mixtures with common variance. Their Theorem 5 gives the \(\log\log n/\log n\) high-order rate for a bounded location law and a known common variance. This rate is the natural comparison for the paired term in (1), whose target here is the joint law of location and individual variance. Ma, Wu and Yang, Theorem 1, find the sharp number of components needed to approximate a compact homoscedastic Gaussian mixture density. At fixed positive support width and small approximation error \(\epsilon\), the count is of order \(\log(1/\epsilon)/\log\log(1/\epsilon)\). This is a forward approximation complexity, whereas (1) measures recovery of the latent law. Nguyen, Le, Rinaldo and Ho study separation- and weight-dependent Hellinger lower bounds and estimation rates for finite Gaussian location mixtures with known covariance. Bariletto, Le, Rinaldo and Ho, Theorems 5–6, bound the observation-density discrepancy in terms of the Wasserstein discrepancy of the location mixing laws and the difference of two unknown covariances, each common within its own mixture. These comparisons identify regimes where moments or density distances control an identifiable latent law. In the present joint location–variance model a finite set of single gains can have exact common null directions, as (11) shows.

**Repeated measurements.** Ritov's author version §4 considers two observations at the same latent mean and scale and gives qualitative identifiability from the resulting full exponential family. Equation (3) supplies explicit mixed moments, and (1) quantifies the statistical cost when repeats can be scarce and adaptively allocated. Capitao-Miniconi, Gassiat and Lehéricy give identifiability and matching compact-signal density risk in a repeated additive measurement experiment, using noise independent of the signal. Here the measurement variance is a coordinate of the latent pair and can depend on its location. Repeat selection can moreover depend on the observed responses. These are different inverse models even when each has two observations per latent draw.

**Heat cancellation and conditional information.** Le, Bariletto, Rinaldo and Ho identify nonidentifiability of infinite location–scale mixtures via parameter differential operators. Nguyen and Nguyen examine precisely the nonidentifiability of sets with interior in Proposition A.1 and use the backward heat equation to analyze constrained support geometries. The single-gain heat identity in (11) is this established mechanism. Applying higher-order products to a compact signed direction lets us cancel all listed gains while retaining Wasserstein separation and rapidly small response differences. The new requirement for post-selection is the pointwise estimate (12) against an anchor of strictly larger variance. An integrated discrepancy for each complete pair controls averages over fresh outcomes. It need not control the conditional likelihood at outcomes singled out for a repeat. The larger-variance component and the analytic derivative estimate supply that control for all finite prefixes with length at most \(L\), which is what enters the sequential entropy bound. The constants in (1) may depend on \(L\). A changing first-gain menu selected from the responses is a separate design class.

### References

- Y. Ritov. *A mixture of a normal distribution with random mean and variance: Examples of inconsistency of maximum likelihood estimates*. Sankhya A 88, 467–480 (2026). [DOI](https://doi.org/10.1007/s13171-024-00375-5) · [Author version, §4](https://arxiv.org/html/2408.09195v1)
- Y. Wu and P. Yang. *Optimal estimation of Gaussian mixtures via denoised method of moments*. Annals of Statistics 48(4), 1981–2007 (2020). [DOI](https://doi.org/10.1214/19-AOS1873) · [Author version](https://arxiv.org/html/1807.07237)
- Y. Ma, Y. Wu and P. Yang. *On the best approximation by finite Gaussian mixtures*. IEEE Transactions on Information Theory 71(7) (2025). [DOI](https://doi.org/10.1109/TIT.2025.3558841) · [Author version](https://arxiv.org/html/2404.08913v2)
- H. Nguyen, D. Le, A. Rinaldo and N. Ho. *On the geometry of separation in finite Gaussian mixtures*. [arXiv:2606.16179v1](https://arxiv.org/html/2606.16179v1)
- N. Bariletto, D. Le, A. Rinaldo and N. Ho. *Convergence rates for latent mixing measures in infinite homoscedastic location-scale mixture models*. [arXiv:2605.06845v2](https://arxiv.org/html/2605.06845v2)
- J. Capitao-Miniconi, E. Gassiat and L. Lehéricy. *Deconvolution of repeated measurements corrupted by unknown noise*. Electronic Journal of Statistics 19(2) (2025). [DOI](https://doi.org/10.1214/25-EJS2415) · [Author version](https://arxiv.org/abs/2409.02014)
- D. Le, N. Bariletto, A. Rinaldo and N. Ho. *Partial differential equation barriers to identifiability in infinite mixture models*. [arXiv:2608.08597v1](https://arxiv.org/html/2608.08597v1)
- N. N. Nguyen and X. Nguyen. *Identifiability of infinite location-scale Gaussian mixtures*. [arXiv:2611.29836v1](https://arxiv.org/html/2611.29836v1)
